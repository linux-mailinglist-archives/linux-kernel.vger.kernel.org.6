Return-Path: <linux-kernel+bounces-200976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD29E8FB7F0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D7A8B2625C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EDC146A7A;
	Tue,  4 Jun 2024 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KVHi/Pth"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883B7143C7B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515727; cv=none; b=Njcga7NqA7cTwOO3BTV8fG8K2QI1kjkMEIugyJpYtlCEcbPTGoo7W6VFf5f4l902lM8c+MPdWxqqkVzskCnl4DR0fhEw4/1eezKajq7P17gw4YL8cOnEahKv82PGlMN9Wm+rMtncM7pMRU1JpV3twZvXO7MpPMlc7/vCTW9MfxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515727; c=relaxed/simple;
	bh=u74weg/rqAL/u/z9KNzZ6rqil4ZEmVTrdRFhj1PZu1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvVLw9lBuHcQMFd30W5rR50jAgn4080SItnMNl6Vuf036gfDHT+7Z4D6abgdyrC6fAe8zjf3jKVUYMiQvknqCeva33dbvUNrEd1qYXgyv7+zqnfcGBTSw76FzqmU6OIZTkJna1ufOfmQHNM+0TmnqPK2siWq/xnBnc95YcI2IkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KVHi/Pth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4122AC2BBFC;
	Tue,  4 Jun 2024 15:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717515727;
	bh=u74weg/rqAL/u/z9KNzZ6rqil4ZEmVTrdRFhj1PZu1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KVHi/Pth50g7B5WGQwpo/CtpF6C9C8UGB09Cdo/UpR/DGvb4w4WLD9hyc4PZMOTZ/
	 YCg7WwGXiPZok5mYP6OAUsXSXZBjVX8YYQdVvIBqYJtybKrNgACH1oToskaim7TN6y
	 ZwnIhxjWUz0VZpMOxfZiXDN1IA8NQaOc4sz2QVvg=
Date: Tue, 4 Jun 2024 17:34:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/4] kernel/panic: initialize taint_flags[] using a macro
Message-ID: <2024060405-grouped-mower-96ff@gregkh>
References: <cover.1717146197.git.jani.nikula@intel.com>
 <8a2498285d37953cfad9dce939ed3abef61051bd.1717146197.git.jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a2498285d37953cfad9dce939ed3abef61051bd.1717146197.git.jani.nikula@intel.com>

On Fri, May 31, 2024 at 12:04:56PM +0300, Jani Nikula wrote:
> Make it easier to extend struct taint_flags in follow-up.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

