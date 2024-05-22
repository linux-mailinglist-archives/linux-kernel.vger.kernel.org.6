Return-Path: <linux-kernel+bounces-185757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE598CBA4B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 06:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00DC28292B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60703763EE;
	Wed, 22 May 2024 04:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zSy+agBl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F059360;
	Wed, 22 May 2024 04:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716351705; cv=none; b=mt2mgpw1rzlmzUycEWtkQBaP+96h5niwLg7qNY+UiihWnaU5PdVBO0BpVWFMdSVGlZ/dxcNyVdyyGOyosHROzVjGTPcUACnvqxOGpRLxT3XPHV7nxBZmTEGbMMtqC3E/aSrujsENW5RiHqv+oRUyatkGhHzav0L/F3AMem4zQYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716351705; c=relaxed/simple;
	bh=mTHrYVSkHty3/g7xV+eC5f2SXN3gBUMTd6Tb7+MCzHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMb1ejcxXjWMV0w4peS/Zt23nIoyYDdCbtKgohsvqqy84be7HKgYHTR52inlev07OmUyIC8K7PpWsEOyfkOXOh3q8AFfIRUIBaobjwG4bHziLOf7pvU/e0vzvhrmXelzzP8fCCvTyos4UW3zRdm7ZvhDTYLkKl1KUUmdL1voZDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zSy+agBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC02C2BD11;
	Wed, 22 May 2024 04:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716351705;
	bh=mTHrYVSkHty3/g7xV+eC5f2SXN3gBUMTd6Tb7+MCzHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zSy+agBl8A3AjVFuIfw0v/OrqRA0TiNAdvglJVwWIeuTYMn6wZ8aRDjASefpznw1H
	 g/MwcHoNwgCL2z2NuRIRrImXxcIifglCBAR2iGyi0CEGs+JMkD9Qlcl4r/3MC70pgs
	 rVgwuRQdYsb2ygzRZSOiwro1Caweu8tu7FTVbS7c=
Date: Wed, 22 May 2024 06:21:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: andrey.konovalov@linux.dev
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Tejun Heo <tj@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kcov, usb: disable interrupts in
 kcov_remote_start_usb_softirq
Message-ID: <2024052232-juggle-oxygen-5bd2@gregkh>
References: <20240521204324.479972-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521204324.479972-1-andrey.konovalov@linux.dev>

On Tue, May 21, 2024 at 10:43:24PM +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@gmail.com>
> 
> After commit 8fea0c8fda30 ("usb: core: hcd: Convert from tasklet to BH
> workqueue"), usb_giveback_urb_bh() runs in the BH workqueue with
> interrupts enabled.
> 
> Thus, the remote coverage collection section in usb_giveback_urb_bh()->
> __usb_hcd_giveback_urb() might be interrupted, and the interrupt handler
> might invoke __usb_hcd_giveback_urb() again.
> 
> This breaks KCOV, as it does not support nested remote coverage collection
> sections within the same context (neither in task nor in softirq).
> 
> Update kcov_remote_start/stop_usb_softirq() to disable interrupts for the
> duration of the coverage collection section to avoid nested sections in
> the softirq context (in addition to such in the task context, which are
> already handled).
> 
> Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Closes: https://lore.kernel.org/linux-usb/0f4d1964-7397-485b-bc48-11c01e2fcbca@I-love.SAKURA.ne.jp/
> Closes: https://syzkaller.appspot.com/bug?extid=0438378d6f157baae1a2
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Fixes: 8fea0c8fda30 ("usb: core: hcd: Convert from tasklet to BH workqueue")
> Acked-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
> 
> ---
> 
> Changes v1->v2:
> 
> - Fix compiler error when CONFIG_KCOV=n.
> ---
>  drivers/usb/core/hcd.c | 12 ++++++-----
>  include/linux/kcov.h   | 47 ++++++++++++++++++++++++++++++++++--------
>  2 files changed, 45 insertions(+), 14 deletions(-)

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

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

