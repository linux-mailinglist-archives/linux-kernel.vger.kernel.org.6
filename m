Return-Path: <linux-kernel+bounces-547094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6D3A502F1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2152C16407E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B610924EF72;
	Wed,  5 Mar 2025 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WYWrzSbi"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CBB24EAB6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186448; cv=none; b=SHgVXlg4XmkYW4oKdHvNOpkRWIcYVl+mSnq4lDehPgkUJ+QHSPwve1ajXO9ed6bfzCDLjv7Q30mWBtPRQaVMqwE7871cKGf7Sfnns0uK1GsRhRpRahh/dsDnOM3IKNDiYTRxzINng7rG7fCo/IAWQSgPgb5T/mivqWGQLN+9GlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186448; c=relaxed/simple;
	bh=WwcEMSxxHLOGH9XJtwTKimEYpC2lcD67Srx1N2R9Nj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXOMS+Z7kSIYRUmXaYGieICnJ1l6WcwbMPjpEe2LW7DEr7492iQvWadS6Njmw0pypVJgcf/S4H7SVCXFjLn2TamKjkUFKnfpZlSVTMWRSqdI1Fz5rVOSGSGJtoZa/ItG3SUB9olbZMHC4kckbXMxkOuYJ7P+XbGRgrm1tcloZPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WYWrzSbi; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6fd2fca1cebso43706217b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741186445; x=1741791245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VeNLwaFo16zfbUMvLDVk5OOLd3X39XkqYnX5zvlPNF0=;
        b=WYWrzSbiP/d/yY1ksRcSJUCn4y1DK7lmTatxizCLzUldPJ7vvnQ01CzaKgrxKxFX8h
         MbI719Agtv6mPco3dXZ8ACO04azQY4Aj0a7SZuZep8w7Bqqc9EHJEPyPl9ZJ3e6JZe3Z
         1tTH2dGEYwmlXfQTkexaosnP0NQvgEUpSu9eupcE0cTxfbd9Li9bIkROisDlMIFdRlJY
         Ieyyp0hTpwhP6Q6hrRkOn9/T+tSY8Ma1EeQ3BmJlu6SWXDzK2jPIGfk2dKTKY7UU1yh/
         vsv05aTb+JzTZWUyn1gKlJ3MQkpDd1FxMIZFca2HRst8Ns8/38dXgaqA0VQMKLDBfDZs
         jZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186445; x=1741791245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VeNLwaFo16zfbUMvLDVk5OOLd3X39XkqYnX5zvlPNF0=;
        b=QVr3ZgnT1lJD3z/5Rauo9++zvXLbQHZY9o8E1C7Opgc1CjPfId54nOyrJhEcEa4SJW
         qBYkT8iicDMxtLpGASfQM045OpeEGOeB5trCnfa7lPxbDQ0+gOT70j8nme04k+DzvEqs
         O521ePmQuom3VJ0iN8ELno3xFcYiDNe0S/9+dBCBq3bJdLjCdcYctqo86teeqHu1gSPD
         yYbIHiYC3uzxP/KmCGypyBmkh/HXzxqpD3plg5NsYsM61LtBKgd81xjRxHycEN0x5ebo
         sG8lEWiOi3Kc0vUfXiafXU4BeOtuHEbqX7Zei65lp4TiN0uQ7ftJdzaaWEYFgDyrYcOr
         hXoA==
X-Forwarded-Encrypted: i=1; AJvYcCWdPL2ac4/1Uj0JXhyjgEJ+eFPPwznwNMoa4mCD55ZVt4iJSn7V35YbyirGh3S1yfUEafDo8XGYZzaQblM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNHM1MWSXzOAYi5NS50DSm5onbhC3q3h1ZURGGujMBMzVRlqVk
	+d1T/uh8Vy9CxjzuZ7qWlkKwgOoxk41517uGde4PHxeO6MnSxwlsEe7M8K9jSpQ9WGcMfxRsE4C
	HyVeTNATupWfvJkRHibsAAIwMlMXmhSmj4F565g==
X-Gm-Gg: ASbGncvaGN4uj1Ry2gLM+EfMqENjYHzLptxpt6d+EjfL9i5NixEDIZcaMpxmFJL4NGc
	63zlDfuGA5AgSpdse3Xq/oacYJtzsFxhyTJwI8VGyfmwUNE7VPegRX28RGlK6lNcSq751g3FSNu
	EqjqKpsbCF5q5OpDo/P4PHR0Zxxvg=
X-Google-Smtp-Source: AGHT+IHaRzLfs4e0s/mjCkKbOX/Qq8AuRys4/xKKYjDcoyyp0XIFqNuIteg7ybYGY5j3p+l87FS/VuOkxSFDK6iD0FQ=
X-Received: by 2002:a05:690c:3749:b0:6fb:b78a:c0e5 with SMTP id
 00721157ae682-6fda310bbf6mr42777697b3.28.1741186444835; Wed, 05 Mar 2025
 06:54:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-fix-t7-pwrc-v1-1-b563612bcd86@amlogic.com>
In-Reply-To: <20250303-fix-t7-pwrc-v1-1-b563612bcd86@amlogic.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 5 Mar 2025 15:53:29 +0100
X-Gm-Features: AQ5f1JpdUfHmjKXFkOL_14EaaLzX4OU9jP-SAbgoA1LHg0Ze3bkxnPXr7Krf_aI
Message-ID: <CAPDyKFoTBt4g=M1rHrZEPLO1y61csy3_cHfJDANPbvV+bH+YXw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: amlogic: fix T7 ISP secpower
To: xianwei.zhao@amlogic.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 10:06, Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>
> ISP and MIPI_ISP, these two have a parent-child relationship,
> ISP depends on MIPI_ISP.
>
> Fixes: ca75e4b214c6 ("pmdomain: amlogic: Add support for T7 power domains controller")
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/amlogic/meson-secure-pwrc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> index 42ce41a2fe3a..ff76ea36835e 100644
> --- a/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> +++ b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> @@ -221,7 +221,7 @@ static const struct meson_secure_pwrc_domain_desc t7_pwrc_domains[] = {
>         SEC_PD(T7_VI_CLK2,      0),
>         /* ETH is for ethernet online wakeup, and should be always on */
>         SEC_PD(T7_ETH,          GENPD_FLAG_ALWAYS_ON),
> -       SEC_PD(T7_ISP,          0),
> +       TOP_PD(T7_ISP,          0, PWRC_T7_MIPI_ISP_ID),
>         SEC_PD(T7_MIPI_ISP,     0),
>         TOP_PD(T7_GDC,          0, PWRC_T7_NIC3_ID),
>         TOP_PD(T7_DEWARP,       0, PWRC_T7_NIC3_ID),
>
> ---
> base-commit: 73e4ffb27bb8a093d557bb2dac1a271474cca99c
> change-id: 20250303-fix-t7-pwrc-f33650b190ef
>
> Best regards,
> --
> Xianwei Zhao <xianwei.zhao@amlogic.com>
>
>

