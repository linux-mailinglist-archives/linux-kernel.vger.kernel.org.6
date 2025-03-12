Return-Path: <linux-kernel+bounces-557517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF06A5DA4B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F253AD533
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AF923E33D;
	Wed, 12 Mar 2025 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sSw4dYBs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D7F23E32B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741774554; cv=none; b=EOzT8/pL3fxyrpINNpqSO+HkuRs3d+3mlRhsN/MWnbFYgH8d1a+V5e5KuHZUIUWtLlqhxbSH/pHE7P+DKkx1V5Gnl23gXM+zSEjxEGFuswioMwE+rO4s992SdZkyW+BlJ3EmA6d3vSh6iyurguvC93TyrHtlFMUXWbm5lsBLerY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741774554; c=relaxed/simple;
	bh=m/8CcVSzjkw9ZPpZN5jkPhm7S6MvAm8LmEMxsh5n8gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLc8IjyhJtE3BVOIqLpuofZ4ap9RJkctBy9dnnSdFgLC56I1NVzY1KKSqPniV3oBpB4Sx1XXiaenrXujjQDkPqCWik8BSmNPJIRC5csn/FVRf+ZyN2fQQS0rG84EuqtWu4Xle1+kxzNSzMA7hudrMuOZ/CJH+QcxPLrlt3oNNZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sSw4dYBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D648AC4CEED;
	Wed, 12 Mar 2025 10:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741774553;
	bh=m/8CcVSzjkw9ZPpZN5jkPhm7S6MvAm8LmEMxsh5n8gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sSw4dYBsCxGnySEMg3hkt3qJV7wpjYgy7SGfGBsq2oVn1HGy7tunr5GSEXL7lvYD3
	 jNCpUY4QT1fVk/Xhe2xC0MCXcgVqP3m3mcYz3OfmtmK37bDBAb9cSlO0qyrAOF0Qk8
	 q3GLhCGe+gnWnVxbyhJNJsM5yItW3iKHmDS3gHb8=
Date: Wed, 12 Mar 2025 11:15:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nipun Gupta <nipun.gupta@amd.com>
Cc: linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, derek.kiernan@amd.com, dragan.cvetic@amd.com,
	arnd@arndb.de, praveen.jain@amd.com, harpreet.anand@amd.com,
	nikhil.agarwal@amd.com, srivatsa@csail.mit.edu, code@tyhicks.com,
	ptsm@linux.microsoft.com
Subject: Re: [RFC PATCH 1/2] drivers/misc: add silex multipk driver
Message-ID: <2025031236-siamese-graffiti-5b98@gregkh>
References: <20250312095421.1839220-1-nipun.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312095421.1839220-1-nipun.gupta@amd.com>

On Wed, Mar 12, 2025 at 03:24:20PM +0530, Nipun Gupta wrote:
> Silex MultiPK device provides a char device interface to interact
> with Silex device for offloading asymmetric crypto operations.

Great, then why isn't this in drivers/accel/ or drivers/crypto/ ?

thanks,

greg k-h

