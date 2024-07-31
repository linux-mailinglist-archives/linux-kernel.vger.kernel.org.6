Return-Path: <linux-kernel+bounces-269674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B2D9435A3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E4E1C21F40
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915E138F83;
	Wed, 31 Jul 2024 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fTRlVpUZ"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE553F9CC
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722450514; cv=none; b=lJhwhSTrdnLZ0jKoQso/xYQWC77GWvjRj+bDQzwcrg1QxX4lGghdrC0adiywBMvUc1DyCrFPS3oPd0vRUFEZCRekyPb/Sdkl5fcF2oG8fA1EwbnG4F48qsUUiTJKXKedigGrJX0dZLu9wx23ci1jy4e1oZdgTr+fWt2pPhWQGMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722450514; c=relaxed/simple;
	bh=LoEnpyZdjxa7YTVgUWETn4KKToh/DGNRLXn0j7zShNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8wpl9LLBJ5m+6EnnSdb215eukRJtcvYxmDrVPvoDHtBt4TdggBYf/7G5d1h5FeYMylaIUK6fYHY07EcM46cwzJND0Hs+VcWs20n6+268KNhOvqBzsSKoBHYw4jAMSgXk7utm3Xdt8nJaISqVoMC9diV8JP9K2DoQy/BKshtagw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fTRlVpUZ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-661369ff30aso46648777b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 11:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722450512; x=1723055312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZQiTCpakrmI/hG6ccbr7ADOzk36Y11Q6omsUDXJBR0=;
        b=fTRlVpUZjpANWrl0L+1w4U2oH+cg6on3TOfnNlqP+RpU5YVwetu+X44S/ZFjp/YRko
         5/vgKh47+F+DG3GRIR0aKa0pHhn/rGK0A3NM3YhQlfktPs106c0u+zm91Vvf109Z/ncv
         u7UVpE+iunWcJNcacUJc3rO2kQ8vrEFq68RmfB5al8w33KDMJVhAWSdsNGcJZPT6yqWy
         atKEiZgVw692VQ4woDAu7Xl6Ay/6T5pLeUJpwedmpkfWtkeS26kimn5M+KES8sMrxBIY
         3mcAb2UAVCcFEPHVzXZw2HDgkjgeR9tmfpyfTNY4mQowUTWIdBtSnqd3SzTQRL4AAFx5
         1N2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722450512; x=1723055312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZQiTCpakrmI/hG6ccbr7ADOzk36Y11Q6omsUDXJBR0=;
        b=AzWCqswEIkS8ZwvZCmS9Fr8HF+iasOemYBL+YlVqsGxwpKci8RfS3omWdJ2NBtTagd
         jkTInXvmj5eI3MGtgs2MUOc9WB7SQR3Vv2uaP8Qhfv/98YaSMmUNYcEOXewrj75ziTJP
         QiqYBw0Rsr1ceDOXIlZ3us8+gUmq/VGmkOuAwj69l+sQwCdZ/85cyumtRzpfILU37H8E
         TDRdhpLDX3Pc9SnK7OLPwuPohcf1HP1KoH9cltg6NCMheEwHcwb55uBxibZF0uekIiI9
         wgVMl2xvsB4Yj63ulAg5nhdLsE2LXe/LLgshyszX9/NmW02eR6236cLdTMUxuEzNPArx
         RAJw==
X-Forwarded-Encrypted: i=1; AJvYcCUara4Bd2qHC4M0oW4KTXrEw0CPRTMKvnVm1dLT4UIAEQexYiCC1ViHxhKmMVLoI7x8kxL79YNR+kcIrfADMIR3FsAfKLaRURxBLjNG
X-Gm-Message-State: AOJu0YzA/QvLPKl1DFu9jGdvJqwV7uEn70GgF4bglUUpLmbzQX723Du3
	sCPtssnEoyKUZJhsBdWLqqE3cEMJFJw8d3qOlSssoHrfpvJr3Nh/+b0jhzBrXNA7v85RHWftLSi
	Qd9f92QFKepJBfElfMzOdgeagvP/Eaj7o+NdM2g==
X-Google-Smtp-Source: AGHT+IGkcmUq+gWGlEnHu1TDME5ReG9CGFf/FdG16ffSla45VUSMcNw0dtEakvWLuX/KIOkHadrm/0K0Fv9MS3xe+7E=
X-Received: by 2002:a81:9e0f:0:b0:651:a00f:698a with SMTP id
 00721157ae682-67a0a136bdfmr151536777b3.38.1722450512137; Wed, 31 Jul 2024
 11:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129204717.9091-1-semen.protsenko@linaro.org>
 <8659d79a-e18e-4591-be9e-817d0ab63b75@linaro.org> <ae202942-fdc0-4913-bd37-c167440807af@linaro.org>
In-Reply-To: <ae202942-fdc0-4913-bd37-c167440807af@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 31 Jul 2024 13:28:21 -0500
Message-ID: <CAPLW+4nxhQRzaEZzxZEOPKpdDxN1mCrpURYPN3+tUa_W+2G06g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add entry for Samsung Exynos850 SoC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Jaewon Kim <jaewon02.kim@samsung.com>, 
	Mateusz Majewski <m.majewski2@samsung.com>, Henrik Grimler <henrik@grimler.se>, 
	David Virag <virag.david003@gmail.com>, Artur Weber <aweber.kernel@gmail.com>, 
	Raymond Hackley <raymondhackley@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 10:17=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 30/01/2024 08:29, Krzysztof Kozlowski wrote:
> > On 29/01/2024 21:47, Sam Protsenko wrote:
> >> Add maintainers entry for the Samsung Exynos850 SoC based platforms.
> >>
> >> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> >> ---
> >>  MAINTAINERS | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 939f6dd0ef6a..77c10cc669f8 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -19281,6 +19281,16 @@ B:  mailto:linux-samsung-soc@vger.kernel.org
> >>  F:  Documentation/devicetree/bindings/sound/samsung*
> >>  F:  sound/soc/samsung/
> >>
> >> +SAMSUNG EXYNOS850 SoC SUPPORT
> >> +M:  Sam Protsenko <semen.protsenko@linaro.org>
> >> +L:  linux-arm-kernel@lists.infradead.org (moderated for non-subscribe=
rs)
> >> +L:  linux-samsung-soc@vger.kernel.org
> >
> > Sorry, but I am still against individual SoC entries in maintainers,
> > like I replied multiple times and pointed to the updated
> > get_maintainers.pl script to fetch emails from boards.
>
> I retract my earlier statement.
>
> Some background: I was really hoping that scripts/get_maintainers.pl
> patch, which adds fetching emails from files (e.g. DTS), will be picked
> up, but it has been few years, few resends and there is no conclusion. I
> don't think it will be ever merged, thus this email.
>
> Since C files do not have in-file "maintainer" entry and particular
> drivers have MAINTAINERS-file entries, then why DTS should be different?
>
> I'll take the patch after merge window.
>

Thank you, Krzysztof! I'll happily look after this platform. Please
let me know if you want me to rebase/resend this patch.

> +Cc few other folks,
>
> I understand that with lei/lore filters one can easily track patches
> sent for particular boards or SoCs, but being listed in MAINTAINERS have
> a bit bigger meaning. Therefore if any of you consider / want to add
> themself to MAINTAINERS for particular DTS, then go ahead. By DTS I
> mean: particular boards (e.g. Galaxy Tab 3 family) or particular SoC
> (e.g. Exynos850 like here).
>
> Best regards,
> Krzysztof
>

