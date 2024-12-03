Return-Path: <linux-kernel+bounces-429319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A999E1B7A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBA4FB2EC3A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90BE1E3791;
	Tue,  3 Dec 2024 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="T1Mansl/"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7BA1E32BE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224414; cv=none; b=dzbliYggVqB8bO1ay104fAh/MjtL0BhAAjlIgv+/AcoUVlDHjvGJYWSGPk2v4FXsS6iTG3TY7vot/se3jp42+xLXbO6D4SAoi8O1RYDNu7U8zQ2dBh3IGBxywdfj/bJ+LPki8t43GfllEaqDUnSb7EZPiFF2dXJ7HTUxsNno8ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224414; c=relaxed/simple;
	bh=oGSk6hVxW1wYB/QI1mVV80YFrcUPoJqrE8+x2OzhEEI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PmKPr0Mk5yaaIVga5PNCNiSVHnuSPOROK/a9aP2kZdmgb5dhTvjo7k8asyWC0/qA+rNp2sYEvWCtwrGRNhG7VAh1Lji0ojwsRfDMpTi7Cubc1XLZWqsuBsGZ9joQ2UhLIWFRtIs9GoXlVJ6/p67TK+dcIZNiJm/qcoux/64UvZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=T1Mansl/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4349e4e252dso50164095e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 03:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733224410; x=1733829210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHAew+5pIUtNZ469Ay/e6iOZX+tKVuk7Y65o+7qMTAc=;
        b=T1Mansl/VVrNqeYSnHiYEZTqakQvk/nx49YN3fgp8Rg+KuMxAhUWAZabiOdqYyOZsp
         8k5c0nH36NbZidcxPKY7IDdM3v/Ht8fzXEWFd0fiX3XvQhv4IieC7aCDgc8I/YHqNtv9
         svkoribsIoW7pcoCaZUykqDrB82Mu3Bam8E+jfgHavADowlFG2YMYeUQ+fCL+CTeo2Sx
         BniANs0Tr9sKS/rlgLv7q5QYW/UIwREHeuDPis1TeMDf5vLbPpfqMjBJRz+MBQVVN1XX
         LAsAqjQWVXK+FnMDXUCUK7Im5di9D0MLb6sgx9Ymh5XDKu1wDlx0naTRBVsLe/0lheSC
         bNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733224410; x=1733829210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHAew+5pIUtNZ469Ay/e6iOZX+tKVuk7Y65o+7qMTAc=;
        b=mMaZWP+llNlVPryKDDIFYOhxzRgzLYVGIrchtPSa2ysm5QHhzaFiF97vN7cDc0wL3z
         1IZe4oWfye2+2XTi00LdpqcUZd7sXJ8QZwVGe4zR0c5Mt62VaSpjgbU2UNQdgW1TORsD
         BfsQEVLHtQCIvQgRi85V+YPEFtUeAZUnpJuiwU7M2FAxBi5ptjLSsLeDGlZarsmrZlpW
         r2w52GRwTHISpi5eJ2V5qt2bnbt9g49rQvo170Vuo42jgs0RbSE8z9/Se6QjJS3QjmfW
         bqTUilZ79KLbnw04s866K0aB62hvjgFHZzpyK5VjuTLG9PrH4Jr0J7Fa554YCD2ESROJ
         n5Xg==
X-Forwarded-Encrypted: i=1; AJvYcCW7Z2nm9cNxZP+nZZDTh6CElzf31n4KxdNje3REBQFkwrf0PQUAAxDMyg1EBvle+WbxJMP4rqohmuRHXRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTHcxJc1z5Pa51DjsXnYtrLyVKgE8SuiQcxMre7wIekOSd7fkE
	HSOqyVQqweuBlkk9on3bC278Em5BAHzVURx7A7ochyl5kK10m3afzgZI4+aX2wk=
X-Gm-Gg: ASbGncsI6SMr7iBefU6P8MfgLgPv417LEbul2/MDUwNMAaZIN47KKUAfBm2H4usTt4X
	dsl1TsvuXiz6GCe/ZrWBQl9lxcsWR6FuESagogly9Rsk6IqRsje0khESIC7t5qHMAFjgDGlqyKc
	bYavbiDF27wh0IzBnu1xfzF2/ez76u5SGkkHerS4vji+F7mdACd5LP8fFpVxm1DLOKXYYH18hA9
	4STwnB6KkTbG8+yzAlWXu3uyYaTXTxtQ3F3v2sDoZKMEfZZH7lD7nLrP7PtaWorMVdHv1gib/2g
	M3dk
X-Google-Smtp-Source: AGHT+IErtKnY0Pv3GfVcIJwifhLrCQ99HAQ814LD/e3xtS/wVzvpDdVQw8u6DVBzuWDInXQU6dGy3Q==
X-Received: by 2002:a05:600c:1f91:b0:42c:de34:34be with SMTP id 5b1f17b1804b1-434d09acf48mr20434705e9.3.1733224409944;
        Tue, 03 Dec 2024 03:13:29 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e0117069sm11794315f8f.60.2024.12.03.03.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:13:29 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 00/14] iio: adc: rzg2l_adc: Add support for RZ/G3S
Date: Tue,  3 Dec 2024 13:13:00 +0200
Message-Id: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series adds ADC support for the Renesas RZ/G3S SoC.

Series is organized as follows:
- patch 01/14:		adds clocks, reset and power domain support
			for ADC
- patches 02-06/14:	cleanup patches to ease the addition of RZ/G3S
			support
- patches 07/14:	enables runtime PM autosuspend support
- patches 08-12/14:	add RZ/G3S support, including suspend-to-RAM
			functionality
- patches 13-14/14:	add device tree support

Merge strategy, if any:
- patch 01/14 can go through the Renesas tree
- patches 02-12/14 can go through the IIO tree
- patch 13-14/14 can go through the Renesas tree

Thank you,
Claudiu Beznea

Claudiu Beznea (14):
  clk: renesas: r9a08g045: Add clocks, resets and power domain support
    for the ADC IP
  iio: adc: rzg2l_adc: Use devres helpers to request pre-deasserted
    reset controls
  iio: adc: rzg2l_adc: Simplify the runtime PM code
  iio: adc: rzg2l_adc: Switch to RUNTIME_PM_OPS() and pm_ptr()
  iio: adc: rzg2l_adc: Use read_poll_timeout()
  iio: adc: rzg2l_adc: Simplify the locking scheme in
    rzg2l_adc_read_raw()
  iio: adc: rzg2l_adc: Enable runtime PM autosuspend support
  iio: adc: rzg2l_adc: Prepare for the addition of RZ/G3S support
  iio: adc: rzg2l_adc: Add support for channel 8
  iio: adc: rzg2l_adc: Add suspend/resume support
  dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3S SoC
  iio: adc: rzg2l_adc: Add support for Renesas RZ/G3S
  arm64: dts: renesas: r9a08g045: Add ADC node
  arm64: dts: renesas: rzg3s-smarc-som: Enable ADC

 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   |  37 +-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  53 +++
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   4 +
 drivers/clk/renesas/r9a08g045-cpg.c           |   7 +
 drivers/iio/adc/rzg2l_adc.c                   | 414 ++++++++++--------
 5 files changed, 323 insertions(+), 192 deletions(-)

-- 
2.39.2


