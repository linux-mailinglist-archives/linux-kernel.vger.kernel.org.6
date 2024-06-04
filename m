Return-Path: <linux-kernel+bounces-200977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5450F8FB7AA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856C11C22076
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277EC145B3F;
	Tue,  4 Jun 2024 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XMj5NG1F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6345713C9CF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515735; cv=none; b=r1Gw0g/UvJiKRXpeDSNp77zx9Aoqv2YYqLjzxxK9P2mJRyrGAhVClEOoezqaZCosqCzPX5dJT+YtFi1ChGOU6nXq3H1nf2sP8inTRdl3eE6uR5gMX/M+pJGweEDr+ixtTtKo2J+AEJdStcvSXitb0KJx1Strc7diTySTPBybpDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515735; c=relaxed/simple;
	bh=jLx2ZFFGoYBUTSPxOo+y2w4849kT0K2pHsMwBEdZTcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFJVsAlWpVJIy5++Yz85lHgzvKIqqnqLJWZzzUdBZwrK1oUBLYrAHWbEV0YJd1fZ9WiA6JpEer9UOn5vyqGY7Fv5pGSgSJlXl5j91/Yt6XkFpdjtKhIa7Jm7lKXOPca4zNZKDCZjYPyEHiz+92S5lKWPv2Ihm+nwEXoanP3dNjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XMj5NG1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A26C2BBFC;
	Tue,  4 Jun 2024 15:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717515735;
	bh=jLx2ZFFGoYBUTSPxOo+y2w4849kT0K2pHsMwBEdZTcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMj5NG1Fwwda8uLMHcmWWV/3euHRsHHSbyNHFdSoima8VsE2Ta3r3YVGqbAfEH24Z
	 cVMUv4H7XnCoscRIAsl2GdHyljgphsPbIpx0V//4P8L0EXpZ6XianQwWulTobo6sk8
	 AbDiK7fC0xPWMIYFhgNx6f4oaRrFT7od66LIgZlw=
Date: Tue, 4 Jun 2024 17:34:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/4] kernel/panic: add verbose logging of kernel taints
 in backtraces
Message-ID: <2024060413-seldom-happening-4361@gregkh>
References: <cover.1717146197.git.jani.nikula@intel.com>
 <7321e306166cb2ca2807ab8639e665baa2462e9c.1717146197.git.jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7321e306166cb2ca2807ab8639e665baa2462e9c.1717146197.git.jani.nikula@intel.com>

On Fri, May 31, 2024 at 12:04:57PM +0300, Jani Nikula wrote:
> With nearly 20 taint flags and respective characters, it's getting a bit
> difficult to remember what each taint flag character means. Add verbose
> logging of the set taints in the format:
> 
> Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN
> 
> in dump_stack_print_info() when there are taints.
> 
> Note that the "negative flag" G is not included.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

