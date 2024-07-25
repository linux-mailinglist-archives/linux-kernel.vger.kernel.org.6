Return-Path: <linux-kernel+bounces-261619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF6193B9FC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 02:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C375C1C218D2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 00:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC2A5C89;
	Thu, 25 Jul 2024 00:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yaUj+OEF"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F4E23CB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 00:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721869008; cv=none; b=ZQNBMj6gc1OmQkXTKZAiyIQ1y8l0Oira7APa3gEHvyJRFN+DBq0eoGaoiqXWTM/j3LNyb/4QBUHkGAH2YlsEiGm//SJHxD6EoCe06ITD7g6V4WYFhfh2WYMxYNDc5CUzvqi/GOYyFg9krVhp7HBO9mjjTY4EgUcETKToWNZxpBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721869008; c=relaxed/simple;
	bh=PGxObZitrHONB8DARS3qQLkgOiWYASPux5Uxri9IFCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nI4AgksbEbzqcaUkVGyfbDCsxUT3Mz75cNbMflsM8E8o9T/wvDXMJjTQgbpxe5CqCusEAOBbq/esC+IHlFqmghXQB7ZicxbNF+GS341mjPw2kitmq1XuwqO+fNqW4xGAdoP65oo19xJgk5d0/1M7bc6VF8xXcclK2/qy440182I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yaUj+OEF; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-66a1842b452so3610127b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 17:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721869006; x=1722473806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YD3jeRCk+f0mBi38ATBp9QnVYA+oraXbIZZVdMF7rHg=;
        b=yaUj+OEFzuiPOmtkitwl51CBImJ2z6v4YjfT46+lCgVWRiy5MA7ktwaxVop7ZNNKCF
         qJiKwUiNwe0p482PTN2+kVUL+e1KTGSBj9RCIwTL20hUmBZLEXjwTrxJUQSbA8OU010i
         ex2sfAPJJ+E7uYYja3IOQjfXcKfI4ohjzjSf/J0Kp/BuMYPff9DjtMY8Zi+Y+o98Lvhc
         634bxnxLnoueKnnM9faoGLgrU7I+FEu2enpA//jvSRnGWOvzovigV3J2nqu9y/1ggFu3
         a0dq4TJEMevjUfl5ocTVgWbfxTRSZwY08eP/ZHs1FuQq+A2+/x0yo3eCAH6Jp8/6L0Li
         40zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721869006; x=1722473806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YD3jeRCk+f0mBi38ATBp9QnVYA+oraXbIZZVdMF7rHg=;
        b=mU/rOKEzggn6A9F80KbR06ft6hOBTr6VOELg7lOVGRCTChvjsESJh/r/5EsAez+V1h
         tf1uxlWmcSPmUk2FQsvK05RM/BcLvVcfQe9oVTcVN+fcHlr3BaQSmLEVkHNlwVRHIqX2
         nQEXJm+ipXEyWwn8dyRLQcyBJ74mx3Jtnr1JzQFUcbeKeyOCxemOWSuZT0Ctlknr9rob
         ESgoAUh5b17RhliRLBN80epmtXITi1Ks9QMIAknbBERmK0IRdtprk27EhzJIa1sL3+Wi
         f32Pl0ehfXSR2XEYzCiGVeB8Eo01Ad4BqPlTLoyr0AA5yOu/TV2yMz2+85zaqySV7Oij
         qSmA==
X-Forwarded-Encrypted: i=1; AJvYcCUubRx+ewRLg2XWfP3ogKmNWrZRlcSeUfld7ZwiT/RClN7mmSguh/IG3iwZ+Nb4zyRoUX/8xmWD4kLpF/KmSkqCjk/SV5j6hrICkOZN
X-Gm-Message-State: AOJu0YyVBRnuSTkfomw2XfS1w9rI0hzXeFm5egTNL1tQiOjdCAhSbX+F
	uMdjehpJAHZJEfnvezECyaZ37bk2ur1dujYpZ0anE85yDEQWrgySG3RQ4PLSATEZKtafoJknn1z
	DA7Ne2LC9OE3qIMcHyCXjJYGIgA3LpTp1PQ2V8xfA/beXoWy1Re7hKA==
X-Google-Smtp-Source: AGHT+IHuSuD8Y03E9T2N4n9K7jxp0O14PtidV2gQH1LBB+ld5W02YV9xlOBvrKBjjyo65ew6CM85i4knKatAz3yFl1M=
X-Received: by 2002:a81:8245:0:b0:652:e91f:a1bc with SMTP id
 00721157ae682-675b8908043mr3207417b3.3.1721869006269; Wed, 24 Jul 2024
 17:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240724153105eucas1p2f46f2128ba9ce4dc42a5d952cd816c38@eucas1p2.samsung.com>
 <CAPLW+4n6XB3fm8KQA=6_2z8ay9pDPtu-VFgAaW5imZkRH2ywkg@mail.gmail.com> <20240724153058.914693-1-m.majewski2@samsung.com>
In-Reply-To: <20240724153058.914693-1-m.majewski2@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 24 Jul 2024 19:56:12 -0500
Message-ID: <CAPLW+4ktoygdOcy1_isdhsWvfnziR+wzhs8OtUwsn7E2y7HFzQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] drivers/thermal/exynos: add initial Exynos 850 support
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 10:31=E2=80=AFAM Mateusz Majewski
<m.majewski2@samsung.com> wrote:
>
> > I'd suggest to group all the definitions here as such:
> >
> > #define REG1_OFFSET
> > #define REG1_FIELD1_OFFSET
> > #define REG1_FIELD2_OFFSET
> > ...empty line...
> > #define REG2_OFFSET
> > #define REG2_FIELD1_OFFSET
> > #define REG2_FIELD2_OFFSET
> > ...etc...
> >
> > Or otherwise each shift/mask constant should contain its register name
> > as a prefix, to avoid confusion. But right now it's kinda hard to
> > understand what belongs to what :) But that's just a nitpick.
>
> I came up with this:
>
> /* Exynos850 specific registers */
> #define EXYNOS850_TMU_REG_CURRENT_TEMP0_1       0x40
> #define EXYNOS850_TMU_REG_THD_TEMP0_RISE        0x50
> #define EXYNOS850_TMU_REG_THD_TEMP0_FALL        0x60
> #define EXYNOS850_TMU_TEMP_SHIFT                9
>
> #define EXYNOS850_TMU_TRIMINFO_SHIFT            4
> #define EXYNOS850_TMU_TRIMINFO_OFFSET(n) \
>         (EXYNOS_TMU_REG_TRIMINFO + (n) * EXYNOS850_TMU_TRIMINFO_SHIFT)
> #define EXYNOS850_TMU_T_TRIM0_SHIFT             18
>
> #define EXYNOS850_TMU_REG_CONTROL1              0x24
> #define EXYNOS850_TMU_LPI_MODE_MASK             1
> #define EXYNOS850_TMU_LPI_MODE_SHIFT            10
>
> #define EXYNOS850_TMU_REG_COUNTER_VALUE0        0x30
> #define EXYNOS850_TMU_EN_TEMP_SEN_OFF_MASK      0xffff
> #define EXYNOS850_TMU_EN_TEMP_SEN_OFF_SHIFT     0
>
> #define EXYNOS850_TMU_REG_COUNTER_VALUE1        0x34
> #define EXYNOS850_TMU_CLK_SENSE_ON_MASK         0xffff
> #define EXYNOS850_TMU_CLK_SENSE_ON_SHIFT        16
>
> #define EXYNOS850_TMU_REG_AVG_CON               0x38
> #define EXYNOS850_TMU_AVG_MODE_MASK             0x7
> #define EXYNOS850_TMU_DEM_ENABLE                BIT(4)
>
> #define EXYNOS850_TMU_REG_TRIM0                 0x3c
> #define EXYNOS850_TMU_TRIM0_MASK                0xf
> #define EXYNOS850_TMU_VBEI_TRIM_SHIFT           8
> #define EXYNOS850_TMU_VREF_TRIM_SHIFT           12
> #define EXYNOS850_TMU_BGRI_TRIM_SHIFT           20
>
> #define EXYNOS850_TMU_TEM1051X_SENSE_VALUE      0x028a
> #define EXYNOS850_TMU_TEM1456X_SENSE_VALUE      0x0a28
>

Looks better, thanks!

> This also omits some definitions that were in v1, as they had the same
> value and they were the same thing anyway. For instance, I dropped
> EXYNOS850_TMU_T_BUF_VREF_SEL_MASK in favor of
> EXYNOS_TMU_REF_VOLTAGE_MASK, and have a single EXYNOS850_TMU_TRIM0_MASK
> instead of EXYNOS850_TMU_BGRI_TRIM_MASK, EXYNOS850_TMU_VREF_TRIM_MASK,
> EXYNOS850_TMU_VBEI_TRIM_MASK and EXYNOS850_TMU_T_TRIM0_MASK. Also,
>
> > Suggest using GENMASK() macro whenever possible.
>
> This would make me have a separate mask for each of these again. Maybe
> if this driver gets refactored in the future to use u32_get_bits() and
> so on this would make more sense?

Sure, that was just a suggestion, don't have a strong opinion on that
one. If you don't like it, feel free to skip it for now.

