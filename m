Return-Path: <linux-kernel+bounces-521476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC32A3BDE5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9913B1F0F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42DC1DF26A;
	Wed, 19 Feb 2025 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLFT2SJR"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D6E28629B;
	Wed, 19 Feb 2025 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739967495; cv=none; b=nZAf1jwsX0wPO3b3erVhxaitaia0vfgHSDjFr728G0Z2n8m6MSVCAH7Gf0GCDT5ayG57r+KgG0YXx4VdZ3yRZx0Bo4+RjyQk4ryasxwPUi/G/PyZ+ODigxQSjVNetmxTfGJ+tjb8ultPXOeXL7PHDyyLGj5MMJDl3q1bIv736+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739967495; c=relaxed/simple;
	bh=CkJjV4pYyBmnvMr8dXnwe++5yWa/O/7CmfltUEorV3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAFoytjvSa4xnulG5X5mxHcP+3I6Ooke2ioz5+5RCL1ZP7JdjYJu4TsU3/oIxspqdq1AHY2vhyVY4wjV8A347GS8ysq8hsQUr2cN1+e7Ic9j8z11qS2VkEYAAy+wc2IPTuKsLcdGS3YfQ16yD8UB3iiLJ3pWap1m8OYoV2NxAQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLFT2SJR; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54622940ef7so3338166e87.3;
        Wed, 19 Feb 2025 04:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739967492; x=1740572292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTPWbSgjrTLpPmlX3MdNrwi/24I03HDG8gfadoLFfKo=;
        b=FLFT2SJRZs7hCYj0/HvesL/phOhwwi7aaiXz8f5Rzf8jA1Htf6uMKOMqfjZ08lJQW2
         UkzoelAR3dzy+eoqZUHU8dedMG+xyRia/0fBBTjkXe7qXosU6838n/U4XZkVVX9btkME
         U5YFkGHu3TiUySC88ad7+eFxJTep+6/OShXs75NlngaO7Bm4bC5/Xa+rFqD1WS31911s
         VJEzXsCl83vngrR3LoeGPCknr2dUcKgDJ70yTX4y8qMSms8Trhk9YFqumXlMTsBvo+mw
         hBpoJZacDpSUpa5xI8uEgBSmEYiYiNp2a1SEXXx338fspYa7mZ+dokPUd2P4z7QBlgpB
         K+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739967492; x=1740572292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTPWbSgjrTLpPmlX3MdNrwi/24I03HDG8gfadoLFfKo=;
        b=ECCM27rx751PrFSm1TG1tyMTBQcXmpwbYtpkFTfcKXwhdeC2+OdnNIZWbTKnGX9k6Q
         vtcCwdT/uSoSOpuLckWghLxFxnKwklTUA8gCGqKQSmL1OfQuGOqOhjFU+hMegv/nu9Ah
         T6+PW06KkVHp82N1OXtXgAyiPqDz+mJTyVKE/qKOqHDiAG1lTs85siXcVsZCFtO5apmF
         T9XM4ReN4gge9McauKr+6N+prbO0bqMECUvXoX8FFCDfq/8ojymXc7duhBSfLP757/CK
         CTVtoDNCMjbX03fmqFQjkmdknILkZERig3saUxzsu8GQiLooodTo+b3EHnqDRdJQH/U0
         ofWg==
X-Forwarded-Encrypted: i=1; AJvYcCU1kUkSSfF+h/lRRWPPrqxtk60+KXSOFxgkgV62cBowPjpPL/e2IPRj4UzdrBfD7XGAy/Ehp0bultT+3CW8@vger.kernel.org, AJvYcCUIrEJBvtnWBBduXUYIFvPC1WYFr8XHzLRVnycj/Fw+7V2Ql+CBKMfriDcXRu1Hpt2oPv3AaG4+v3Yc@vger.kernel.org, AJvYcCWwpqb8sYYEZVFV3mPNElZrWTXA8t8zQarokyaMJhikE1Rc6/jz/KDIaks8fUIV2RgE8m2UUlbR+7FV@vger.kernel.org
X-Gm-Message-State: AOJu0YylPEB0CuVVQ6CgLUleQiO4pm1b4dDHRZH/JbAfnG/NtC4iOXgZ
	6W/AJUSXa9M4ZqdgExi5V3P5GrefccwfI7DXjPYpYiW1oE9fxnN8ZdxMlEScVErdFtsC9DEE9aJ
	8B9kG0+2rtZVGwE2NeqNl+Z5bwm0=
X-Gm-Gg: ASbGnctMu1/KH472CgiFvzzpaKCAS4Cg0eUxUBeetud1q9oL2lfLTpyDLCD3m0jFizg
	9EWJu+QOTYVNy0hUm4RNjEwwF2i3aatDcp+LO7sUAbNBMbYQKcndhD98mz8w7icNMEXNtxAblKn
	RIXY311XDezNyO2nynQT3CstRC3d8=
X-Google-Smtp-Source: AGHT+IGjNIoen8ULKXTmUUOdA8vnMJhMrh0uHRpn94zwbfBEqhRrLoruJpWGVHqyNRMVU7htjBuXJmu/uj1ajZZO9rM=
X-Received: by 2002:a05:6512:3d28:b0:545:2eca:856 with SMTP id
 2adb3069b0e04-5462eed85c8mr1170113e87.9.1739967491394; Wed, 19 Feb 2025
 04:18:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219114936.3546530-1-lukma@denx.de> <56e56623-9cef-48b9-8a57-ef7840f0a8f3@kernel.org>
In-Reply-To: <56e56623-9cef-48b9-8a57-ef7840f0a8f3@kernel.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 19 Feb 2025 09:18:00 -0300
X-Gm-Features: AWEUYZl9H3BRYlwGymanzXLFA6lr62seClEuWhg-mC8ltYhyVYgZA4_v-XW8gpM
Message-ID: <CAOMZO5Cf3JpKBjQXdjWNeSgOCOLmcNuSvQpR_ewiFtH-p3KwfQ@mail.gmail.com>
Subject: Re: [PATCH] arm: clk: Add ETH switch clock description for vf610 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Wed, Feb 19, 2025 at 9:06=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:

> This defiine should not change. If you need to change it, means it is
> not an ABI. Just like for other cases, I suggest to drop the define in
> preparatory patch.

You can follow the same approach that was done for i.MX93.

Please check the two commits below:

commit c0813ce2e5b0d1174782aff30d366509377abc7b
Author: Pengfei Li <pengfei.li_1@nxp.com>
Date:   Wed Oct 23 11:46:48 2024 -0700

    dt-bindings: clock: imx93: Drop IMX93_CLK_END macro definition

    IMX93_CLK_END should be dropped as it is not part of the ABI.

    Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
    Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    Acked-by: Peng Fan <peng.fan@nxp.com>
    Acked-by: Conor Dooley <conor.dooley@microchip.com>
    Link: https://lore.kernel.org/r/20241023184651.381265-3-pengfei.li_1@nx=
p.com
    Signed-off-by: Abel Vesa <abel.vesa@linaro.org>


commit 0af18ba60752e8a4ba34404c1d9a4a799da690f5
Author: Pengfei Li <pengfei.li_1@nxp.com>
Date:   Wed Oct 23 11:46:47 2024 -0700

    clk: imx93: Move IMX93_CLK_END macro to clk driver

    IMX93_CLK_END was previously defined in imx93-clock.h to indicate
    the number of clocks. However, it is not part of the ABI. For starters
    it does no really appear in DTS. But what's more important - new clocks
    are described later, which contradicts this define in binding header.
    So move this macro to clock driver.

    Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
    Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
    Link: https://lore.kernel.org/r/20241023184651.381265-2-pengfei.li_1@nx=
p.com
    Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Also, the Subject should not contain 'arm'. You could use:

clk: vf610: Add support for the Ethernet switch clock

