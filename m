Return-Path: <linux-kernel+bounces-301390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E0695EFF5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DCF28146D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633E116EC19;
	Mon, 26 Aug 2024 11:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+dZUjqK"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E01416C84B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672360; cv=none; b=qZWNMy7iUpHV4Gb53Qs5vxCMzrbH0r82c9pX076J5EnuZ6yCNgh83C2YcOyRSeHxGeEhp325Q0fYqz0SVj3BdMjovXo4hxyoF5LCLigZJFGGcxpnO/bIH3DywGlPoFMTHq3e2qr1p4kWoXTsNQx8w3RgPHOzFEMbyqpANTnT7mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672360; c=relaxed/simple;
	bh=Rwh2LwwBpzKTgvRHzVQ3gWwFNixZmyAVwJLMdtAh/0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b77oFVK02J0gphFAmq3ZYoJ+hCPNZdIKDWoercZEutyVRqAnYCb82OZ2q8v1CKEO4oc9LjdrFOuMjaxAe1D8An3nltgshUQwgJjfYhbL8NXVUbKUYjKPpLmGD6WS2fG719hc0X/FgfOuFBh77ol92Bk6b9qVpGG4/23RdkRNRv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O+dZUjqK; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e1654a42cb8so4166324276.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 04:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724672358; x=1725277158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lj1uhnFdqDXbAdE4f2Y9iYQuc3TxJEK7JxbQMv0Akk4=;
        b=O+dZUjqKJFA17hOrP3C4AKHUwSiStp9HKQUV7PO3qsuh6AREzSbJiSVLGsPmMHDNEv
         uuMqKDH0zJc2GwpCn8k1edfe+SR+T1gu9E04GTfqTFjO5O8XMNOh0/km+JzZWoZGX3pY
         albD8QKQey2uQI8hfS/RMZZnV8tqtfqsdtYS9MgQELDPgk6SMnpvUYNsbsuSffyE4HMH
         UOjXab1ALUfWH0zwW7VhRw33GxBSDflLh2DzkcMxFIVqOBWw0apklcQrSL+tnAPqymu7
         pLNhvuUmUWNGhOVTAVlFzwanQtgEApr7JdSZKntH/OVUZUP4r3W6iLTltbXYn6TrRpEe
         ueUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724672358; x=1725277158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lj1uhnFdqDXbAdE4f2Y9iYQuc3TxJEK7JxbQMv0Akk4=;
        b=gfCca2QzkaC97P9mWz/d5q/w9HIZnbIyO6fcNgYzFKvtUhi41ITO+Ujw2zzRUgW3LF
         U8KILph+J5El290SctvNYjmljGpZmTHpNpnh27QunnZ/X6HB9J8nw7E4uhfQ5D5nwGhA
         x1SI9TJPF/OmLCp7zvssy7HU788oA3eb2kh7nCWVdOZtbbSGQG4E/EwuD0DN7xVfUCqH
         p60soS75ispfBJWYPR7rCSiP/M9456cZ9LL88+Pt9mujIhwMSyfYIMaA5d4mBvtQP9n2
         vncbpPY8EJivztOVmEqpPEPN5PGVMzHCqpBV4L1sWxO/59MocYk4ljm+YtAQdvxIiR1Y
         e29g==
X-Gm-Message-State: AOJu0YyLl7zwxhzHWzBFQVaRwgUkKfLk7DHsZV6/O3jse5LBbI5IjdA4
	AYopopaYg+5XuTIeiQ7xMGnl3Rq812X3povw6HE5NTuinThvtWB9wP0XjE9VQtxut/f1V3TYFG2
	DGiU5XEodDd5na5Ebdp8OiiQiD8UtlpUegDpPZA==
X-Google-Smtp-Source: AGHT+IEAA2eR1CF21wxXJhBK6Hja6nGKN6FOH0gS8wg8S5DjXKbEDhtopM9INx+Et4Pz58X0bcnls83hbYMzJRZC6gI=
X-Received: by 2002:a05:6902:2849:b0:e11:6bbb:d700 with SMTP id
 3f1490d57ef6-e17a83e2a1emr8932113276.30.1724672358211; Mon, 26 Aug 2024
 04:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <232106a8a6a374dee25feea9b94498361568c10b.1724246389.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <232106a8a6a374dee25feea9b94498361568c10b.1724246389.git.christophe.jaillet@wanadoo.fr>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 26 Aug 2024 13:38:42 +0200
Message-ID: <CAPDyKFr9q=EcDpQApyu-RwXth=ghV07B1Mo70hUZEZRp4vdm=w@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Remove struct mmc_context_info
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Aug 2024 at 15:24, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> The 'mmc_context_info' structure is unused.
>
> It has been introduced in:
>
>   - commit 2220eedfd7ae ("mmc: fix async request mechanism for sequential
>     read scenarios")
>
> in 2013-02 and its usages have been removed in:
>
>   - commit 126b62700386 ("mmc: core: Remove code no longer needed after the
>     switch to blk-mq")
>   - commit 0fbfd1251830 ("mmc: block: Remove code no longer needed after
>     the switch to blk-mq")
>
> in 2017-12.
>
> Now remove this unused structure.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Compile tested in drivers/mmc/ only
> ---
>  include/linux/mmc/host.h | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 49470188fca7..545bddfd7e1f 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -292,20 +292,6 @@ struct mmc_slot {
>         void *handler_priv;
>  };
>
> -/**
> - * mmc_context_info - synchronization details for mmc context
> - * @is_done_rcv                wake up reason was done request
> - * @is_new_req         wake up reason was new request
> - * @is_waiting_last_req        mmc context waiting for single running request
> - * @wait               wait queue
> - */
> -struct mmc_context_info {
> -       bool                    is_done_rcv;
> -       bool                    is_new_req;
> -       bool                    is_waiting_last_req;
> -       wait_queue_head_t       wait;
> -};
> -
>  struct regulator;
>  struct mmc_pwrseq;
>
> --
> 2.46.0
>

