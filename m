Return-Path: <linux-kernel+bounces-367516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9CA9A034B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28FC1F22464
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578601D2202;
	Wed, 16 Oct 2024 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TpYleqlz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AC41D1F70;
	Wed, 16 Oct 2024 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065324; cv=none; b=YiVGRsEp97gv81vqO/rqVvZXWlwI1qSNmlB/nTN5rZZ8nM+FNDnRDLIyMokQtfOqQVaPSbnr5J1YMw/pOxWBPQcRrsSRiGf/396uVtwhSyw/pQkkyS5JijvIDmTCTWZKkQYpfXCgtsgDyOgFI8oOSl+6PH49lLZxsOBDjffjxcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065324; c=relaxed/simple;
	bh=hRvW7vtfVwAx7B7zDSN0FerDG4Cm+YG+5rGNfksKbjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9pZ+PjjUh7AcrzloZNLMJBPLWu7LFuHy87SUfqIZ4p7COsuXj6Jtwo2bn5hygX8qBsA2pN3mNQHlMtgUVCtiO5Q5VhisL08LpVeZeHSoCnMG4jn81zC5+HPJEGv5U1ellQiZxSQ4t+UcreiRliBUoaDqzSsLN9lNL9FRCiDVdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TpYleqlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40DCC4CEC5;
	Wed, 16 Oct 2024 07:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729065324;
	bh=hRvW7vtfVwAx7B7zDSN0FerDG4Cm+YG+5rGNfksKbjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TpYleqlzSEOY/IsPbv0nUzFp64WofFux2OalMr7KJtch8lkbIRoqDVpGZXndr7pA6
	 iT8N+4m7cX0jkm2+NyGU8oFaOUwPqON1+JdU5aHadxP2CDa1UhvdxIUqkTRaJt6xZ/
	 DJayive37L52VRsUHNUSjMcbC250+nEHfUSF29EQ=
Date: Wed, 16 Oct 2024 09:55:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rohit Chavan <roheetchavan@gmail.com>
Cc: Dave Penkler <dpenkler@gmail.com>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gpib: Replace kmalloc/memset with kzalloc for
 zero initialization.
Message-ID: <2024101652-reattach-laborer-129a@gregkh>
References: <20241014075907.1571439-1-roheetchavan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014075907.1571439-1-roheetchavan@gmail.com>

On Mon, Oct 14, 2024 at 01:29:07PM +0530, Rohit Chavan wrote:
> This patch updates the GPIB driver code by replacing the use of kmalloc
> followed by memset with kzalloc. This change simplifies the memory
> allocation process by ensuring that the allocated memory is zero-initialized
> in a single call, improving code readability and reducing the potential for
> errors related to uninitialized memory.
> 
> Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
> ---
>  drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 3 +--
>  drivers/staging/gpib/cb7210/cb7210.c                 | 3 +--
>  drivers/staging/gpib/gpio/gpib_bitbang.c             | 3 +--
>  drivers/staging/gpib/hp_82335/hp82335.c              | 3 +--
>  drivers/staging/gpib/hp_82341/hp_82341.c             | 3 +--
>  drivers/staging/gpib/ines/ines_gpib.c                | 3 +--
>  drivers/staging/gpib/tnt4882/tnt4882_gpib.c          | 3 +--
>  7 files changed, 7 insertions(+), 14 deletions(-)

You sent 2 patches that do almost the same thing, and have almost the
same subject line, shouldn't they just be merged into 1 patch?  Please
do so and resend it as a v2.

thanks,

greg k-h

