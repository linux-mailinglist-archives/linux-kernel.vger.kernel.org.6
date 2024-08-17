Return-Path: <linux-kernel+bounces-290789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207EC9558B4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 17:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB2D1C20D14
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CB2143722;
	Sat, 17 Aug 2024 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IUqr1CKi"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977B88063C
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723908866; cv=none; b=f7UsLqBgCvNYSaVa5bKVnRRB+0M/6UL1SAYbzs6ii8nCaGhL/Q59GLik0LDR2wxNmTmkbXOZmYlx9LhQdvdxrwTxadmgZVx5rdS+7G39CAsXNFFCkmlDOHsgiRkKOZ5YpCxeB/5AJ1mLmkPtCJx/eFYJGn46jwN8Dg7JpHgYO/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723908866; c=relaxed/simple;
	bh=4W/Y6BiJMxSnwgO47spVbAk5tyI3nap6YIH8p8Sxih8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ouB7d+UGaAZBQNJW9h3BJWYsX7tRaF/+k3RXj4K/xRQddXPVen7rOMZ4wj/n6zT+HXk6SsVxrG0SDKsF4zj/veWKha2KggZweDkP9YWDsE0tIpulQ4daOCASrrjBKXY1BiGDu5Zw5jHjDT1GJp3wnp7enx1xyjFbl9QE2B8NGog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IUqr1CKi; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-842fdb1afb1so926470241.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 08:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723908862; x=1724513662; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8eoWHKmZrDuz5TVj5RFNMVS0TvpziubW752S/ws51A=;
        b=IUqr1CKik/4LSJlesgHFoMQPD6x3PHg1AYphAfW7XdQTEzn5eoHd6HiE2Ci7k/90qK
         6ERBEd0RZtRUeUYbVxsBnRi4P5qb+rULIe/NOdrn969Qm878hwygyxQu1Cp3GccKysgJ
         b414ri4v9EMfBo2VBJBYDdAzCXOZad6TI0AJzEE2b+wY6Qrw64IHKPaee6tFqAguBkdK
         i4JhIkDiu9lLBi1dNn1bfCKeYVX0ndAgXBsY3Ngeg51sXdjxbjYVFaljeLezoPKCxT0j
         a/d+33QTFog46MwC5NQXQY+0i/KfuJpETP8TILZZzqRF/Mq3eeuJ1nOoQjfjUPcreu+u
         8ICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723908862; x=1724513662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8eoWHKmZrDuz5TVj5RFNMVS0TvpziubW752S/ws51A=;
        b=rpnyNAXdK7WLMsRo2k0G0FS+oJiWPGx5wLX2gJf3MqyJ7nuev1slsUyeANH2yvbok3
         UYeC/oaP/2fgYgBEmiuyLdEC5ovtgwyiXlk0n/lI7jfazAxA0hgOhny57OAbnzi5sWKn
         tfXT/v6FqL6XquK4CB2acxUepLBPZRnwhho10B+IRA6P/lQVC1M9kxWCgbbzjm52oBiy
         9SjUUPjvBid9O1ACwXAXnTjCGXxHx1EBLSqpFLqQSMLc48F4BVwtHPulL2oc7DMb0kji
         daq3nzBm8WydpR5MOKGVpQzS++gLe4+UkHH4ErwhQxuYsPp5efUKiW9smA6XWhFA+FIx
         h/lg==
X-Forwarded-Encrypted: i=1; AJvYcCVbb/e5EV9bDbMKPn2L+HHci9c1R11DOfpPR0ruoQL8Utf+l+1rWa8Xf5O8YpDyf+uY6kHCRK2UykkOFAj1OXjgr++TLNopXVZVQpNq
X-Gm-Message-State: AOJu0Yy5a5WVqP43/gM4EKXf5xTtW/bkcNVqG/E75SlmYLOUj1Dflqc9
	cPL6kVtEAzdXBGyIGPIwK45k17jFjus4jMu+AHCzOAPa1TPiElT6+aOBep9erQP0is5qBYt4G6p
	iaTuUG+9FfI1BGtSqcjdNmjxue0rS6pdoh3InGA==
X-Google-Smtp-Source: AGHT+IGryT/KxWwiBHtKufxRiy8ES1KCnuo4booGpak6/PFr/3xYW4X3k+uP5qw9d5dQpPL/X2iClWn1D103V2/VYxE=
X-Received: by 2002:a05:6102:304d:b0:48f:8ead:7b7 with SMTP id
 ada2fe7eead31-4977997fc1fmr7556666137.21.1723908862208; Sat, 17 Aug 2024
 08:34:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816091210.50172-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20240816091210.50172-1-srinivas.kandagatla@linaro.org>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Sat, 17 Aug 2024 21:03:46 +0530
Message-ID: <CAMi1Hd1bYgmnL5O946rxVK2k8ygYm1ur2nCe3KNpmYHnvPa+hQ@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: codecs: lpass-va-macro: set the default codec
 version for sm8250
To: srinivas.kandagatla@linaro.org
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmitry.baryshkov@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Aug 2024 at 14:42, <srinivas.kandagatla@linaro.org> wrote:
>
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> sm8250 and sc7280 have lpass codec version 1.0, as these are very old
> platforms, they do not have a reliable way to get the codec version
> from core_id registers.
>
> On codec versions below 2.0, even though the core_id registers are
> available to read, the values of these registers are not unique to be
> able to determine the version of the codec dynamically.
>
> Add the version info into of_data, so that driver does not need to use
> core_id registers to get version number for such situations.
>

Thank you Srini for this patch. This (along with the DT patch [1])
fixes the HDMI audio regression on RB5.

Tested-by: Amit Pundir <amit.pundir@linaro.org>

[1] https://lore.kernel.org/all/20240815170542.20754-1-srinivas.kandagatla@linaro.org/

> Fixes: 378918d59181 ("ASoC: codecs: lpass-macro: add helpers to get codec version")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Changes since v1:
>         - updated commit text to add more details
>
>  sound/soc/codecs/lpass-va-macro.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
> index 8454193ed22a..e95d1f29ef18 100644
> --- a/sound/soc/codecs/lpass-va-macro.c
> +++ b/sound/soc/codecs/lpass-va-macro.c
> @@ -228,11 +228,13 @@ struct va_macro {
>  struct va_macro_data {
>         bool has_swr_master;
>         bool has_npl_clk;
> +       int version;
>  };
>
>  static const struct va_macro_data sm8250_va_data = {
>         .has_swr_master = false,
>         .has_npl_clk = false,
> +       .version = LPASS_CODEC_VERSION_1_0,
>  };
>
>  static const struct va_macro_data sm8450_va_data = {
> @@ -1587,7 +1589,14 @@ static int va_macro_probe(struct platform_device *pdev)
>                         goto err_npl;
>         }
>
> -       va_macro_set_lpass_codec_version(va);
> +       /**
> +        * old version of codecs do not have a reliable way to determine the
> +        * version from registers, get them from soc specific data
> +        */
> +       if (data->version)
> +               lpass_macro_set_codec_version(data->version);
> +       else /* read version from register */
> +               va_macro_set_lpass_codec_version(va);
>
>         if (va->has_swr_master) {
>                 /* Set default CLK div to 1 */
> --
> 2.25.1
>

