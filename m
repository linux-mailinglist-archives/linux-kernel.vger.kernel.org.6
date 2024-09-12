Return-Path: <linux-kernel+bounces-325792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED11F975E45
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49B9284B19
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D0C1D545;
	Thu, 12 Sep 2024 00:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c2V2I1SM"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E86282FB
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102746; cv=none; b=X9rYvUgPdFtd90WGldsbfXwkiE3gEU6jcencxpifbaQymu7UABqdrEN2esFv7IModsMkqqiR3QJV3FYNjAS8xh3ui1qAJ+utPcM4a98fKQGwZdMrNm2s3m1FOzPZzYQTGdCifz9d5gOKwj0iL+ER3f04zI4WRT2w4rcBGInjs8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102746; c=relaxed/simple;
	bh=f8xPwMxdQ4tCbuHW14yOv03uUtCOnyDHqEtuSeRhmvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1Ba296yWFSNkXYPKZ9ghoBIsttXWFcnTe7Rhhgf7zfreAaCG+9u/ft5s4v8EQsBuY3/2qWprPGiJE6Tkovepihup+psG+NpzPW9nuGxMd+/huhm95kxPsxnYzVLBnOznTOEE6cz1OOyq5np1B0i93NLexJEM1tTfoIdEQSZdnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c2V2I1SM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718da0821cbso297827b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 17:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726102744; x=1726707544; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=77Q8lr9BKD7MyqNH9EI2s+lEVnPH+6P8Cx5LdmYRJHk=;
        b=c2V2I1SMFbvCRanHTG0aR8JPWhP3ARszGlWJ4f5XRVznwtNycprxFi15pV7tGkQR48
         6DiQRbfVWvcmTG8IYYkWoZA/DMmtoJX4DhIIGucQ9UG0vPFYQYkQmT31Aojp29TWOUzb
         N9o17mj6vbNYrMnd6Kb7H3qpGoVhlaSq4DLCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726102744; x=1726707544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77Q8lr9BKD7MyqNH9EI2s+lEVnPH+6P8Cx5LdmYRJHk=;
        b=qOfVapcOrgYaI4RzBh3SsQBlHzhLflTVTlu/XIc5nyvWffbE1SAeeU3E9mIRsaaBwf
         fDLXokXWfj57VOcM0xWv12ej1iyckeyyTcWk8DzTyK4WLhy+5r982tEGEscPVgzBsNBW
         PNzRu66nWgvCmckx7JtGg5LKwpKV/Ug1yFgnUQ75XKMi8ECHUQddSjEZorE/QSewGyvn
         G3Bcuja8gFonxfNAay//Eeb26vrJU4MYq+OOAwwEWaY1vFI2/pUILahj5Sm+QjAEAyST
         KVEZGmkv+IWjXQdDdqfqq58hjv7tS/6NgVPYTNv9n5O565mbvhfU9nkC2fXl1Ql1D5OU
         DBkA==
X-Forwarded-Encrypted: i=1; AJvYcCXhp6c4hasVNbt/J80FkXstEPPXUv2fJ44Na+C1ieJSg3oo7Aw2Y0BDX1iBjX5bBl/BBvqO3iSxh5tY3L8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLY4fnLouN1oQcXGp7liqGT13aGNyKz5KasZalApOX7nekNxJG
	27OuzaAdsoJ6q/9ukzqFSPlHWtr93D8GpXtWKZh3wV+taD4+8yb/Osyx2qcbIF5JFwCtKpzc4ne
	ATO8/8UZ60NwbrqbKk1U8R6Fb0jPdtJrqMHff
X-Google-Smtp-Source: AGHT+IG9eR1TbOqBK9sGXWLyh8kekPaGioY88izzwvDG+5Pyd19EEQGzFq50UYXYWFx74CbBqxY1REtBlSoW5nLddMc=
X-Received: by 2002:a05:6a00:1a86:b0:717:839c:6838 with SMTP id
 d2e1a72fcca58-71926095e9bmr1300204b3a.14.1726102743870; Wed, 11 Sep 2024
 17:59:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com> <20240911062511.494855-20-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-20-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:58:26 -0600
Message-ID: <CAFLszTj90Xm50hNCC0S3wn7nJyXp4R2JoMMg1+sCUabjJGhJTQ@mail.gmail.com>
Subject: Re: [PATCH v3 19/30] arm: gic-v3-its: Rename objects
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

On Wed, 11 Sept 2024 at 00:29, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> The code accesses the gic-v3 node, but not the gic-v3-its node,
> thus rename the objects to clarify which node it operates on.
>
> The following commit will make use of the gic-v3-its node for real.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  arch/arm/lib/gic-v3-its.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

But how many interrupt controllers are there? Would
uclass_first_device_err(UCLASS_IRQ) work?

>
> diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
> index 2cc0a32f9d..22fa46a341 100644
> --- a/arch/arm/lib/gic-v3-its.c
> +++ b/arch/arm/lib/gic-v3-its.c
> @@ -35,10 +35,10 @@ static int gic_v3_its_get_gic_addr(struct gic_v3_its_priv *priv)
>         int ret;
>
>         ret = uclass_get_device_by_driver(UCLASS_IRQ,
> -                                         DM_DRIVER_GET(arm_gic_v3_its), &dev);
> +                                         DM_DRIVER_GET(arm_gic_v3), &dev);
>         if (ret) {
>                 pr_err("%s: failed to get %s irq device\n", __func__,
> -                      DM_DRIVER_GET(arm_gic_v3_its)->name);
> +                      DM_DRIVER_GET(arm_gic_v3)->name);
>                 return ret;
>         }
>
> @@ -158,13 +158,13 @@ int gic_lpi_tables_init(u64 base, u32 num_redist)
>         return 0;
>  }
>
> -static const struct udevice_id gic_v3_its_ids[] = {
> +static const struct udevice_id gic_v3_ids[] = {
>         { .compatible = "arm,gic-v3" },
>         {}
>  };
>
> -U_BOOT_DRIVER(arm_gic_v3_its) = {
> +U_BOOT_DRIVER(arm_gic_v3) = {
>         .name           = "gic-v3",
>         .id             = UCLASS_IRQ,
> -       .of_match       = gic_v3_its_ids,
> +       .of_match       = gic_v3_ids,
>  };
> --
> 2.46.0
>

Regards,
Simon

