Return-Path: <linux-kernel+bounces-328173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BCE978002
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638AF1F22695
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2983F1D9336;
	Fri, 13 Sep 2024 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0ymerS4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A7F1D932C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230715; cv=none; b=V8fw8xEyoQeEMCvkag6PSMbk/vUnOiHDc5uZd2o++sD116auPg3uOPksRUSVEEpdqpnbj24nYCHOqVUHrLsPECqB8U3hMBh5CEBG+/wAnV768xMrO1Mz35zUnF6NzokI0jH0zlnzzXm6CjtT76Bb2wdrlj77aNKmecGY3VL38do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230715; c=relaxed/simple;
	bh=hFu6l/Eu0xMWvXkd8mqxPglsljVxWICxpMtx/veffvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKg9c1PZT8uZw/2fbediUQ7FHDjH2JR0tgTjWhI6FbJmZSa73osbgA0EMHgDpG2b+DCkY0eiDwpZqLTQ0BCcO9Kb+ya2YSvDyKurLcrsVEXhAlMYcZ4uJpAr3cm8oTLLIwZs8i5vMe0YymXUNDQ1jgebWWlp7Hb/wZ7QjCeNKeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0ymerS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE264C4CEC0;
	Fri, 13 Sep 2024 12:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726230715;
	bh=hFu6l/Eu0xMWvXkd8mqxPglsljVxWICxpMtx/veffvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0ymerS4i7qMbHkZ/P0ZxIDTUZKxM+eDnx9GBZVKE0CSTy+Gbozzi688U40D23sWn
	 DFVdjO/ycA3WYsDRO+EhnP5t4P05x6KEcTkEPnCfE/qCQA7l291fM8WVSo8LsR6UKS
	 7TCO/wCVeasarJnWBRBMdj26Or0NIY39RTjkj4TDDFCAalSb2XbsGYj42i6lf8uzqy
	 piM40TefE8ZLmDOmnNeka/9cNcTsXfamG/2lbZeuaNMiEiSahlVlh19qn6qvlEqHMq
	 P8AOSmsz1EeXboaM7zfsCK0mwJmcBvMufo3VdVba9WqoKwAUwCZzw6l/oU4OfoDuRm
	 Tw9MemrnLbB+w==
Date: Fri, 13 Sep 2024 14:31:52 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] kthread: Unpark only parked kthreads (was Re: [syzbot]
 [wireguard?] WARNING in kthread_unpark (2))
Message-ID: <ZuQwuM9_vnj5sBFc@localhost.localdomain>
References: <ZuGHTBfUlB0qlgn4@localhost.localdomain>
 <20240913121109.289-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240913121109.289-1-hdanton@sina.com>

Le Fri, Sep 13, 2024 at 08:11:09PM +0800, Hillf Danton a écrit :
> Test Frederic's idea.
> 
> #syz test upstream master

Thanks!

> 
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -623,6 +623,8 @@ void kthread_unpark(struct task_struct *
>  {
>  	struct kthread *kthread = to_kthread(k);
>  
> +	if (!test_bit(KTHREAD_SHOULD_PARK, &kthread->flags))
> +		return;
>  	/*
>  	 * Newly created kthread was parked when the CPU was offline.
>  	 * The binding was lost and we need to set it again.

But are the following bits deliberate?

> --- l/drivers/input/misc/yealink.c
> +++ y/drivers/input/misc/yealink.c
> @@ -438,7 +438,7 @@ static void urb_irq_callback(struct urb
>  
>  	yealink_do_idle_tasks(yld);
>  
> -	if (!yld->shutdown) {
> +	if (!yld->shutdown && status != -EPROTO) {
>  		ret = usb_submit_urb(yld->urb_ctl, GFP_ATOMIC);
>  		if (ret && ret != -EPERM)
>  			dev_err(&yld->intf->dev,
> @@ -460,13 +460,13 @@ static void urb_ctl_callback(struct urb
>  	case CMD_KEYPRESS:
>  	case CMD_SCANCODE:
>  		/* ask for a response */
> -		if (!yld->shutdown)
> +		if (!yld->shutdown && status != -EPROTO)
>  			ret = usb_submit_urb(yld->urb_irq, GFP_ATOMIC);
>  		break;
>  	default:
>  		/* send new command */
>  		yealink_do_idle_tasks(yld);
> -		if (!yld->shutdown)
> +		if (!yld->shutdown && status != -EPROTO)
>  			ret = usb_submit_urb(yld->urb_ctl, GFP_ATOMIC);
>  		break;
>  	}
> --
> 

