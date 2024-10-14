Return-Path: <linux-kernel+bounces-364213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE4099CD2B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6059E281414
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0461AA793;
	Mon, 14 Oct 2024 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epnwuTXI"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD71018035
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916181; cv=none; b=n3tR7WfQtcwXyd8earz+54GLvM0XCiu6cxKxiR/DvBL03wyfA5oaU9EDqxq8CQLg1taY5FFWWvVs2FwuTvol+lejXFVXHl2gGvE5vrwqWeVyKip7eXoEY7Iv48VrMgVnfq5IH2GGjt0qrMfXE4VXPy3KF+bW0o8mH5LB81iq/fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916181; c=relaxed/simple;
	bh=1rpXd0MNL/xUML30VuQIma2h8PYQvhkF0ow5qY5IEzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCdabOTu1vED5fQyBp8x9hKxUrmhh4YZ+hBUcPma8YLKoGQrXA71hAW5Jr2we3EvcH43066p7WOgOa0jLp3l8vqfSGQE2SpX3ef17QrsuFBM3SxvqTLzgtsOtTC8xjXpYmegnHVkMJ3wQwIgpfL6b3yQmdpibHXpWpknU0T0MPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epnwuTXI; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso2851932a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728916178; x=1729520978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p6PmpippfRD0AVdWVQukdvNDDCNPYHvTfxXjiJDA988=;
        b=epnwuTXIwYeUQ/MMmpsaWECDu3MDY3Ew/rulefv7zJmBKeRx+Iawrkm96dw5kBbb0D
         QGcCREeAEbTEb2ngJF6GpAO1pMTqg3FiM0i44qI4OyNGFaKrkydSLNFFh/u7aLWpF9JI
         EiiGpt851U0L3cXwJthbm4Cf7pFuBwP/EpT3rb7qQhxKsR6Lnj9zPwcRq+AMEcgv0uoU
         o1fpDXb9CnL4iI1br5Z48llMjpLP5me+yFScBOBVyDj5+2DLsSclETxbcrsO+Y4BLOUG
         2EaUG5DKxKH43M4PWjZT/jK1VpYv8Lph4ggUn1cCxKIXBp+X2oRcvTnyBvuIc2dTB5Aq
         iOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728916178; x=1729520978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6PmpippfRD0AVdWVQukdvNDDCNPYHvTfxXjiJDA988=;
        b=kVKP2tfCHEgrjJh+oOnd0isI3lJl5QErpW6u4OiNpStlnx5MqKBIPnO0WgrhHXRuNw
         iLepOKRM4k4IKkr5GR7oK51L/2uiEqP9H0ThxKuTedeaIP1uv96jTNLwf4cbCljqC5H2
         tZKjBNrGXA4VBBZUJFhxgfcH5D9iidTF3iLz7HS8xUR7xiP5b02vHjFwn3RBK9Fis6I/
         SfiZe6BA+FHdDUNcHsAR4JbIzATGYlaiRJ9HjnheF8iPqzo0Y8urOivgHyjRBVf9xTvn
         y8jzIWyCVei4ERx0wl0mSu5QJ/uxKS7o0w9lIik2Pn/MLi76dVcsLnpu2lQ2hmSb5IIm
         ZGkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0BxOZdTmBDtaLKMjQLbOn5fQjaF3k+gh4QHTbKuNFUbVPklqn+dIyN5aEHfQ5I04boz3jbTSwG9IQtMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiEpIB+KllCV+FpCEzHhLPrl98w91/IWx+Q+ZnS5hlCAnAIyJP
	xXHRT1MnR2Xl/Pk8znYk7c5hh789NTzd9mBCpc830cAEIZvoib+wWdWoSBJ+JGQF2SPHW9KLyV7
	AijyRxH4P4g7aiRSqPvuPkbIGLbI=
X-Google-Smtp-Source: AGHT+IGPar8POCQpGQzKdZSoGAdDaFCFze21kQy/l/MmqMJ+f5P/jiLtykXJzQtNS+c8V39xOL2sigGPfyIycfMe4lc=
X-Received: by 2002:a17:907:928b:b0:a9a:123d:3f1a with SMTP id
 a640c23a62f3a-a9a123d52b7mr174548566b.17.1728916177781; Mon, 14 Oct 2024
 07:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006082926.20647-1-quic_pintu@quicinc.com>
In-Reply-To: <20241006082926.20647-1-quic_pintu@quicinc.com>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Mon, 14 Oct 2024 19:59:25 +0530
Message-ID: <CAOuPNLggU3VcVCfRSpOe1Pxd9ObW6S3SWpprcr-t8gcGvB4ysA@mail.gmail.com>
Subject: Re: [PATCH v5] sched/psi: fix memory barrier without comment warnings
To: Pintu Kumar <quic_pintu@quicinc.com>
Cc: hannes@cmpxchg.org, surenb@google.com, peterz@infradead.org, 
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, christophe.jaillet@wanadoo.fr, 
	linux-kernel@vger.kernel.org, joe@perches.com, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sun, 6 Oct 2024 at 13:59, Pintu Kumar <quic_pintu@quicinc.com> wrote:
>
> These warnings were reported by checkpatch.
> Fix them with minor changes.
> No functional changes.
>
> WARNING: memory barrier without comment
> +       t = smp_load_acquire(trigger_ptr);
>
> WARNING: memory barrier without comment
> +       smp_store_release(&seq->private, new);
>
> Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
>
> ---
> Changes in V5:
> Corrected api name and missing () in comments as suggested by Christophe JAILLET.
> V4: https://lore.kernel.org/all/a8393bc0-6f56-4e40-b971-4a837cf28323@wanadoo.fr/
> Changes in V4:
> Added () in comment as well suggested by Christophe JAILLET.
> V3: https://lore.kernel.org/all/00aeb243-3d47-42be-b52c-08b39c5fef07@wanadoo.fr/
> Changes in V3:
> Removed signature of Joe as requested. No other change.
> V2: https://lore.kernel.org/all/CAOuPNLi1mUKW_vv0E6Ynzvdw_rHvCye+nAf2bWv6Qj9A8ofX1g@mail.gmail.com/
> Changes in V2:
> Retain printk_deferred warnings as suggested by Joe Perches.
> V1: https://lore.kernel.org/all/a848671f803ba2b4ab14b0f7b09f0f53a8dd1c4b.camel@perches.com/
> ---
>  kernel/sched/psi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 020d58967d4e..907fa3830c8e 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1474,6 +1474,7 @@ __poll_t psi_trigger_poll(void **trigger_ptr,
>         if (static_branch_likely(&psi_disabled))
>                 return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
>
> +       /* Pairs with the smp_store_release() in psi_write() */
>         t = smp_load_acquire(trigger_ptr);
>         if (!t)
>                 return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
> @@ -1557,6 +1558,7 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
>                 return PTR_ERR(new);
>         }
>
> +       /* Pairs with the smp_load_acquire() in psi_trigger_poll() */
>         smp_store_release(&seq->private, new);
>         mutex_unlock(&seq->lock);
>
> --
> 2.17.1
>
Addressed all review comments on this latest v5.
Any further comments on this patchset ?

Thanks,
Pintu

