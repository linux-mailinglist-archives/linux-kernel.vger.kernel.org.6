Return-Path: <linux-kernel+bounces-239181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFED9257B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5493B1F271CB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B2613D8B5;
	Wed,  3 Jul 2024 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hLK23n0o"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DD713D2BE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000943; cv=none; b=mpzo4ypGQB2lmuRFoDICXZmB+pi17kjG59lMn3VgMBlD6hFcqXpF+xs0UgsbI5NuA3S47wYotpTISy7B+vVBATun+hZcIK+9OHpS8g0ENcUZm/5MQw3i4/dLoAep2xym83ZKZKSsxUnICxwbtU6Zn3mGa0HAUFNQwkVWq5D/G0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000943; c=relaxed/simple;
	bh=2BueQlBHNUIUsB9Kn2OPvhoSOi/prFH4uiBvlAu1/5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DyxRXv2WpOhrWGA6/SMkEQ1bAqIVayRTAALyUxbYKciIDj00H2OselLM0uVebHbO7FaUrH6AermbaoKMdSei2HgTMe1raMCk15pwqweB9p4LsRfmXjeDkLhhrPTdKRbAmYap310KJwgckiCVVtew/arItfadg2B+A0cOhAnVGdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hLK23n0o; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cf4ca8904so8486570e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 03:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720000940; x=1720605740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKXjwCiaLg72R2gJ/FT04OGaQAr4J9i9LzgGVlBH+qc=;
        b=hLK23n0onEk1CF3XTzyjr0MjReLqzOfhQzV04LBBRM74og0zmEdpLDvZuk+U4/w5XZ
         Y0UJpyuN0+3YeAukNLedAYHHZ532ImpNIXN1GK8wxUsUK7n8J39tct1yl22o1HFFHmgM
         /OUZ3j6ymoH+FMuNPjhS+zn86aGGHhILS2XzPR/HRLdIrkvdvSj1QhPCw+4WzRhqmS4x
         uTooZFRIaym0Lat8YRHhsBpLdpsWXjPlCyAvJEEJ3K4Yryr5Jljt5vy7DnDADsFgaGPD
         BhhKn2YE/Suq/bIbTzWt+W8axArnpgKlJXMCzESbPBXe5809qYTuoQtUhGZuMWilut1E
         8+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720000940; x=1720605740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKXjwCiaLg72R2gJ/FT04OGaQAr4J9i9LzgGVlBH+qc=;
        b=JJmsHS4mb90mCKEI9cZW35O01n2OyESmlwC68CPfIcXuwXNJ9E5oJkEAUqMPCb+Ol0
         rFQMyuiId3SgEfybNYRZt3hLY053OtLTY81LclpML9fIyyjeX20kR/buOQzO9LNDb95Q
         tpXDYGfgshamZDSDLvxPqxhoVnCmgZxlmnsMZCDcHW6Vctl1mfvGuPWiPTkYncawmuEg
         TERMLF45HqxR78UQ1/K9P9IjW0++4Ijt0VmNqs/K1TsDewZA8BheV+GfMDflh3Nje2wk
         Bu2dLslK7BIPYtSA0aQADbR0Z5bOrTXsbnbl6HN8VGcZSZ8Kva5zq6C/jNOxx+ZUUC7Y
         9Kzw==
X-Forwarded-Encrypted: i=1; AJvYcCXED5CRYpYSGcFewVmaIiMtlEz8CiloBXqFJ1CAc5roajI/6MdljaBPcXYzs+ieHdKEfLcAb6/+4oeWakdBuy5HATzMx/4K8cJ4l9Ml
X-Gm-Message-State: AOJu0YzofiCkZUqOA6q/vRXKFKaGd7kYcuAefxrGzuh7M8KFBF8dKBGB
	8iZs7BtETjTZsiMPo1YRqLo+6zK+84aKwgqG4Nd3BF9a5Qg0M78DHrOzLfFUZhQ=
X-Google-Smtp-Source: AGHT+IHzaRxDw+0xOP288QMyiqj94os0mlDtdORAYbbCky+tos45ZKFz/8bNjlRpBD4147ufyiEMjg==
X-Received: by 2002:a05:6512:b92:b0:52e:7de3:64fa with SMTP id 2adb3069b0e04-52e826feba4mr7443996e87.46.1720000939825;
        Wed, 03 Jul 2024 03:02:19 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:c37f:195e:538f:bf06])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8df0sm15560651f8f.29.2024.07.03.03.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:02:19 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: gpio: fsl,qoriq-gpio: Add compatible string fsl,ls1046a-gpio
Date: Wed,  3 Jul 2024 12:02:17 +0200
Message-ID: <172000093537.12215.11059064969197754180.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702201724.96681-1-Frank.Li@nxp.com>
References: <20240702201724.96681-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 02 Jul 2024 16:17:24 -0400, Frank Li wrote:
> Add compatible string for chip ls1046 to fix below warning.
> arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1046a-gpio', 'fsl,qoriq-gpio']
> 
> 

Applied, thanks!

[1/1] dt-bindings: gpio: fsl,qoriq-gpio: Add compatible string fsl,ls1046a-gpio
      commit: f2e395629747e718a67b567cb84b49d14792b312

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

