Return-Path: <linux-kernel+bounces-245188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3607792AF6B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA77B2128F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F53212D74F;
	Tue,  9 Jul 2024 05:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MNLikAQ9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D365B139F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 05:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720502826; cv=none; b=IjsM7lUJXvc1ZbeTyCxoivlITPyt2aB10MJB/p700ewsU6IdO7xVR1Z/D12Zvt/d9appNmQ7aR/+vJhLDgmw4msB6zZbzlovHi+Syqrkjvao+yRoz1thLPfWD0MKJAjHwTKXdFKDFsCxTT6aD54+4fZXF1qr2FDIQSUxAcCTWkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720502826; c=relaxed/simple;
	bh=KWSYl+hYYDrago0dhMXIWxMSW9g0AYk60B4rAJhVo4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxzqAO7z+GKpB4pTjrjGPwe9ZP0M+U1GNoVS0ckArKBW6J0mPgJDd+hx8KIt+2jul8Actf7MdKRebDLU5E8P6E7jdRsWwwqiGCH6xiUsTbWXFXn0ncKSpPXeWiTMopjGYKfSc4vp9b4GFZs6RqJaFxjiv8hIJWcWWOuih5mtFno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MNLikAQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D53C32782;
	Tue,  9 Jul 2024 05:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720502826;
	bh=KWSYl+hYYDrago0dhMXIWxMSW9g0AYk60B4rAJhVo4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MNLikAQ9qxj0/BdbWcLnhwHBk12WWb1Wqgr2pwBCa690OIZg0xzoFeR1QV9p+rFp+
	 ySlIx0TXNLsmnbRWUCO9CO76M1nI8KfNLs+jETc/JNpfqXaTc66OdqhcMS8r/RI29B
	 JiNtUH9uB7rdEXYopiJSSnpHSUwZiXzn6EnUVeVk=
Date: Tue, 9 Jul 2024 07:27:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yu-Ting Tseng <yutingtseng@google.com>
Cc: cmllamas@google.com, tkjos@google.com, arve@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	surenb@google.com, aliceryhl@google.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/2] binder: frozen notification
Message-ID: <2024070945-glider-muscular-8b00@gregkh>
References: <20240709052408.4032665-1-yutingtseng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709052408.4032665-1-yutingtseng@google.com>

On Mon, Jul 08, 2024 at 10:24:06PM -0700, Yu-Ting Tseng wrote:
> Separated the binder_features change into its own patch.
> 
> Yu-Ting Tseng (2):
>   binder: frozen notification
>   binder: frozen notification binder_features flag
> 
>  drivers/android/binder.c                      | 284 +++++++++++++++++-
>  drivers/android/binder_internal.h             |  21 +-
>  drivers/android/binderfs.c                    |   8 +
>  include/uapi/linux/android/binder.h           |  36 +++
>  .../filesystems/binderfs/binderfs_test.c      |   1 +
>  5 files changed, 346 insertions(+), 4 deletions(-)
> 
> 
> base-commit: 14d7c92f8df9c0964ae6f8b813c1b3ac38120825
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

