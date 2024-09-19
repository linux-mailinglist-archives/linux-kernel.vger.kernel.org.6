Return-Path: <linux-kernel+bounces-333561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C2E97CAC7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9312B22D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283D919F480;
	Thu, 19 Sep 2024 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bbEgJIOf"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF8119CCF4
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755021; cv=none; b=n2inorO5XGAtcc/aJJMtaQznRODYcwIQ3G/abi1R4U0VQBGH5HFrKOyhrb4/L044JORI1oF3ugIuaNv5CZDN+OzpgsAN3CSVzhi2QC8rOFo6leXP6RwWOC4grUDvjp8toiGwISlSnYQq2tnGJ2xUJfTq59PxGz7wWYWQ92JEssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755021; c=relaxed/simple;
	bh=H+5clAZUKsmOOEplBL2fKoxshYWNeRjCdmc/EtZQ6Wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UE4bycnoFHdDXdmK15KmMCsOVqJoiBxicV10xKAGPOfORsHzBbFGGepkbVFyedJ1bkle2wX41u4JFamHZZtTajLWGkKibS16tFC00Id9KpPSQ0neh/xBMXoBUu4OlucxgTIH9vXrSS+74ZRapJqqtZvefOh9iqzNVB7oM/m6l3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bbEgJIOf; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c35b545b41so16736716d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 07:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726755019; x=1727359819; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=metzN5T5EJu9FHDm5vMdIZOHJtG5k/+dvGu8Ig+aIgg=;
        b=bbEgJIOfXvSK/WVly6xA0SEdoCXqTTAfh4TGheFydtzYQPCcgSgXBWZ7kz1erKKn3e
         ycdAC/bYsRw4OpgCAxJwwZHzmRpXSK/PA7NgxJbyLzHbJZBW0eId7n4i5kvZZYqKwiQ7
         RZUqSp7+XichRBFYBy7NYa6/xNc08nje5AjSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726755019; x=1727359819;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=metzN5T5EJu9FHDm5vMdIZOHJtG5k/+dvGu8Ig+aIgg=;
        b=tZb/vVWmO0PdcNqM6XAAj/jqP3Y6dobwuEsI9rHA01FYhck4qP8aLchxAMtp/OCUZd
         y6/V2b8QcGrORGo8Uykdvm/wfbVTBBBc/M41wgJLF+j6iYexI+1tbCYP1cepvCmV7dHA
         Na41ctnpmhpJs1CFx/B2xnb9eK06jEpXxn1SV/jjNBpsXlioku61kTMh3Zlg4m9AB3yS
         BAhR1QMPE/Hn9LZKeowPaDuE4qYpHoMbD+O9ViIv4ULgBY6WFC/C8dEW/A5xWzJ3xTJZ
         0MLctjcqu9eGJIvwjyopjqPDTTsECsnQraQRkCBB8afBOMdVEhuUqwgmaOoKbmZu/yjK
         r0aw==
X-Forwarded-Encrypted: i=1; AJvYcCUiyiYhTv/mq4jHY9vTXAE60VuseP0IRlLkew2UknrhVPzRj+Ax+lqIJXqpQxw3lVF7CQQNuVz2FIjnJZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6+sOSj8ODWc+e29du3GYpNt5WDqkNWACIALeSa4T8RcQL8KWC
	YIbfAVq4D7T1jO5ik34dxL9b8FpePFb3+fJXV+qt4ZHOL430kV7Mx1dxMs12KjzBPFuGZVW+038
	mDPz4fFYxUJ36lZz+q0gYQkIlVLcfSMLBMcg61FHZgEqh9aIwkaw1Fr0=
X-Google-Smtp-Source: AGHT+IEjFiStNQiQAys4Tir7SfllPtVEJOTKBW24ncqOUFq3SKJ/Eh8Usl8MvfMR7fU2WV/WTqbF04D8gbn+ySGzygc=
X-Received: by 2002:a05:6214:2348:b0:6c3:6344:d4e1 with SMTP id
 6a1803df08f44-6c6823a987dmr46956066d6.20.1726755018945; Thu, 19 Sep 2024
 07:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com> <20240918152136.3395170-35-patrick.rudolph@9elements.com>
In-Reply-To: <20240918152136.3395170-35-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:10:08 +0200
Message-ID: <CAFLszTjQNpb+PjSkVKLrfvpaLFUP8t0k5j9L9DPGru7brcJBLg@mail.gmail.com>
Subject: Re: [PATCH v4 34/35] bloblist: Fix use of uninitialized variable
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Sept 2024 at 17:28, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Initialize addr to zero which allows to build on the CI
> which is more strict.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  common/bloblist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

New patch, I believe


> diff --git a/common/bloblist.c b/common/bloblist.c
> index 2008ab4d25..cf1a3b8b62 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -499,7 +499,7 @@ int bloblist_init(void)
>  {
>         bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
>         int ret = -ENOENT;
> -       ulong addr, size;
> +       ulong addr = 0, size;
>         /*
>          * If U-Boot is not in the first phase, an existing bloblist must be
>          * at a fixed address.
> --
> 2.46.0
>

