Return-Path: <linux-kernel+bounces-245704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5377592B6AA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775FC1C20BD7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281D81591F1;
	Tue,  9 Jul 2024 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X0V4d5b2"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31DF15957D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523722; cv=none; b=U3u/SIg9c8qJUrAlBAdCkCpYsfSZDMgMaqhRf1O+oD6zJyQv8BuOo60q3ZnbxMrkC/t4vvZwUlfMQOiGEELB8xNepSMjUYoaAZlJrPepsCbgofgJnlLpoXG0ye82HVYQerkzHuWiBqnv+h/5lM5VG9cNARWvkK4ieiClipkM17w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523722; c=relaxed/simple;
	bh=8o9HK/XW5AhtJvK6eFRArwMqdWRhZ5tZPR9MnQJ5oeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZw6dMI+7LaAQzi3mfIr4zR1whlPtWBAXtJAedw72k93N52u5EYhk0HZ4uQ2KcLdz45GWhKKe6dRkj1qprTB+ng9b9rHST514xNjzixzO7/qGSiQr87CtWZamX9War5i4+kyaTw0oWDwDgRrGYgeUTR2t8W2UTado+iDLND+qwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X0V4d5b2; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-64b3655297aso48523967b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 04:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720523720; x=1721128520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=amibtjMeBpHYdoWGEAnGfjOuZ2WN6rEsWzK1yJggVqI=;
        b=X0V4d5b2DHrmkHpMqUq9F2twFXuz8n8ts6uR4Dh+jUNW2oWTbAYztI1gbOD8g+BgfH
         Spcal3qkQShKInEPIS3kfg3F7+0+fcjuw3DXKxTzmtJpATbaeOea8nGGwe5YLzKoqKRG
         ns6Uxq3yRJ08F0r/BHPwTaUXUxqu8Zs+U52diS9v6itHkb08k0pNuxmg9eoxvNw5W4c8
         nRhlhExa+1uSHymJi9mGc22Zm1UQDc0KuN7cd2lIjbDGAQCGJf7kfZwRjgKw+SPIJJbk
         bvxWamXqKPKoDZKg12YUX1TP7q3Bs10UbL6JNueEoK7z8oqRUVcuEit4MjfRjV7rdHsu
         QbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720523720; x=1721128520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amibtjMeBpHYdoWGEAnGfjOuZ2WN6rEsWzK1yJggVqI=;
        b=oa8rOH7A4nI56FHvFNhsb2nvgRgb0geObnxTYwOYv0bToQEXgY6lipKIx7ycghCxZj
         nStnXHxskqRQiQUx4cDvX2NVEWrwjFz39WeCV28zOAfI7zy7jLBIpGscFFlJbj+1nA4p
         V9avNN8pTJ9pwAf9rZMdQTb0HI9U487yx05bfVKMUCQWox3oz4492JRCy/9E8YWxMUj/
         oumpGkJujRkngOiCMAWV4zJ74iuV1rtlPIoRwBRHQ9+hDEIbzTSKg5P57G8hSwQeqjyI
         JN5PyfVBzd1sm6OZvtlSoHt/8rPK1TY0BLoDo3WF+eqRFww2jzwdlb3t6f117Qs+1v4c
         QalA==
X-Forwarded-Encrypted: i=1; AJvYcCVsEXKt8qPJ5OBJBJKcc54buRCkcDt0gO06z8ea8Q8iVhtMo27PpHtbn9WUYIiSlcjO/9Wrv8r0QIC/aph8TzYGSE4ITGSvjG10Vt4D
X-Gm-Message-State: AOJu0YzPsmFAu/o4Y8zHqk1vysLtg1zXAx++Op9dl4qVQhuOMYbccETG
	BEaSA9n4kwsm/SOJkdSmmeZcYJk6zO2yJ7El7NpunBbR5IfX5HzC7nCq+M25oxLCg1nd3OwCfom
	8IH+Zxc77uAFNX4cyXhVnnW/D6jff7V2Lou5Q8A==
X-Google-Smtp-Source: AGHT+IFZPKT3QneE1vinb0l0LrB8IBVWI9enPV/6FaauTcqtNWGCxq5Rdp14ew2EtEqk25i4Zh3v1NHOT10WrvY4W2M=
X-Received: by 2002:a05:690c:7306:b0:64a:e7ec:f3d with SMTP id
 00721157ae682-658eed5eae3mr32126757b3.18.1720523719826; Tue, 09 Jul 2024
 04:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <871d6b708de8bb42e1fabd8a601dc9a9a217cf00.1719863475.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <871d6b708de8bb42e1fabd8a601dc9a9a217cf00.1719863475.git.christophe.jaillet@wanadoo.fr>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 9 Jul 2024 13:14:43 +0200
Message-ID: <CAPDyKFprG1iwNDegi45d0KPWiZ7QNthGUWihY05UQ63MCvs=2A@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: amlogic: Constify struct meson_secure_pwrc_domain_desc
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jul 2024 at 21:53, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'struct meson_secure_pwrc_domain_desc' is not modified in this driver.
>
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
>
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text    data     bss     dec     hex filename
>    4909    4072       0    8981    2315 drivers/pmdomain/amlogic/meson-secure-pwrc.o
>
> After:
> =====
>    text    data     bss     dec     hex filename
>    8605     392       0    8997    2325 drivers/pmdomain/amlogic/meson-secure-pwrc.o
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Re-based and applied for next, thanks!

Kind regards
Uffe


> ---
> Compile tested-only.
>
> The .is_off() function is *always* set as pwrc_secure_is_off(), so it could
> make sense to remove this function pointer and call pwrc_secure_is_off()
> directly when needed.
> This would save some memory and useless indirection.
>
> I leave it as-is because it is maybe here for future use.
> ---
>  drivers/pmdomain/amlogic/meson-secure-pwrc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pmdomain/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> index df5567418226..62857482f874 100644
> --- a/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> +++ b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> @@ -46,7 +46,7 @@ struct meson_secure_pwrc_domain_desc {
>
>  struct meson_secure_pwrc_domain_data {
>         unsigned int count;
> -       struct meson_secure_pwrc_domain_desc *domains;
> +       const struct meson_secure_pwrc_domain_desc *domains;
>  };
>
>  static bool pwrc_secure_is_off(struct meson_secure_pwrc_domain *pwrc_domain)
> @@ -110,7 +110,7 @@ static int meson_secure_pwrc_on(struct generic_pm_domain *domain)
>         .parent = __parent,                     \
>  }
>
> -static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
> +static const struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
>         SEC_PD(DSPA,    0),
>         SEC_PD(DSPB,    0),
>         /* UART should keep working in ATF after suspend and before resume */
> @@ -137,7 +137,7 @@ static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
>         SEC_PD(RSA,     0),
>  };
>
> -static struct meson_secure_pwrc_domain_desc a4_pwrc_domains[] = {
> +static const struct meson_secure_pwrc_domain_desc a4_pwrc_domains[] = {
>         SEC_PD(A4_AUDIO,        0),
>         SEC_PD(A4_SDIOA,        0),
>         SEC_PD(A4_EMMC, 0),
> @@ -155,7 +155,7 @@ static struct meson_secure_pwrc_domain_desc a4_pwrc_domains[] = {
>         SEC_PD(A4_AO_IR,        GENPD_FLAG_ALWAYS_ON),
>  };
>
> -static struct meson_secure_pwrc_domain_desc c3_pwrc_domains[] = {
> +static const struct meson_secure_pwrc_domain_desc c3_pwrc_domains[] = {
>         SEC_PD(C3_NNA,          0),
>         SEC_PD(C3_AUDIO,        0),
>         SEC_PD(C3_SDIOA,        0),
> @@ -172,7 +172,7 @@ static struct meson_secure_pwrc_domain_desc c3_pwrc_domains[] = {
>         SEC_PD(C3_VCODEC,       0),
>  };
>
> -static struct meson_secure_pwrc_domain_desc s4_pwrc_domains[] = {
> +static const struct meson_secure_pwrc_domain_desc s4_pwrc_domains[] = {
>         SEC_PD(S4_DOS_HEVC,     0),
>         SEC_PD(S4_DOS_VDEC,     0),
>         SEC_PD(S4_VPU_HDMI,     0),
> @@ -184,7 +184,7 @@ static struct meson_secure_pwrc_domain_desc s4_pwrc_domains[] = {
>         SEC_PD(S4_AUDIO,        0),
>  };
>
> -static struct meson_secure_pwrc_domain_desc t7_pwrc_domains[] = {
> +static const struct meson_secure_pwrc_domain_desc t7_pwrc_domains[] = {
>         SEC_PD(T7_DSPA,         0),
>         SEC_PD(T7_DSPB,         0),
>         TOP_PD(T7_DOS_HCODEC,   0, PWRC_T7_NIC3_ID),
> --
> 2.45.2
>

