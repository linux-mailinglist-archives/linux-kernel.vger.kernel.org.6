Return-Path: <linux-kernel+bounces-241062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8784A9276A4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365521F23D09
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F451850B2;
	Thu,  4 Jul 2024 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0lX2sPAt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D9641A81
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098011; cv=none; b=AHV+Fs8a8+As3y6iBRfRtCaRfRCkogEV2uF7NJpYWBhposapCV90nYHluMYiMAO8bufhU1punIHlFJ/Swc/ekP+vz1qVkp5f1rqaf3W2xNnVDcrs7L1vghE+P110tFUpm1yERnAXCZHcHbu2kw5vHACGaVtakctJ/kklF01opII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098011; c=relaxed/simple;
	bh=LqqBoTPJhx2EEB+1QmuivYZgdQgFAwkpT2zWOPv2KNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awPfNp4vP3w1IPt4ylfQV1o8e3Zgtrt5jy9MbQVB+cfYQKNmoHyoYXjt+VwJ9mq9OdGIyEP2uxlMtTrP7MieD4BjB8oDKRFEWpkhCiTFc+W9eSYTinGlbkGORe2/BlPeDr3z/Nolyg+1Jc7YPtu+diisRoFpoDAlT8ax9EOGh10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0lX2sPAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF6EC3277B;
	Thu,  4 Jul 2024 13:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720098010;
	bh=LqqBoTPJhx2EEB+1QmuivYZgdQgFAwkpT2zWOPv2KNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0lX2sPAteihf1iDwcGMeukmGFoUJoxIYx/JUxt4mEfcCGpowYfL20e9s1UmFd+7eP
	 87Zxk69pLm0ihfmp/fXz0Izp1I/WLq4BkfR1akOshrkEBBsTKF1tX61sXMCRu7ODNI
	 moUUg/joEom8dPMnwHtGj/eL+ZFFi6zsUJM2YWP4=
Date: Thu, 4 Jul 2024 15:00:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yu-Ting Tseng <yutingtseng@google.com>
Cc: cmllamas@google.com, tkjos@google.com, arve@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	surenb@google.com, aliceryhl@google.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] binder: frozen notification
Message-ID: <2024070439-expanse-usual-434f@gregkh>
References: <CAN5Drs06fbditeSaVLc6i6wEY+A47HHzQmhCS1rzJgacNs1Tjw@mail.gmail.com>
 <20240703175843.3639568-2-yutingtseng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703175843.3639568-2-yutingtseng@google.com>

On Wed, Jul 03, 2024 at 10:58:42AM -0700, Yu-Ting Tseng wrote:
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

This email thread is crazy, sorry, look at how it shows up in sane email
clients:
	https://lore.kernel.org/all/20240703175843.3639568-2-yutingtseng@google.com/

Please just send a new series, as it's own thread, so we can figure out
what to do here.

And for some reason I have 2 different copies of the v6 series, one sent
to the list, and one not, which makes no sense either.  For that reason
alone I can't take this :(

Please, realize what this looks like from a reviewer's point of view,
you want to make it simple and easy for us to know what to do...

Please fix up and send a v7.

thanks,

greg k-h

