Return-Path: <linux-kernel+bounces-422082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D1D9D9470
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14ABDB2ACFC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2951C1D63E9;
	Tue, 26 Nov 2024 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NrfxCNhi"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1081D5ABE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612893; cv=none; b=GUX8JhfkDWYsezY9v7+Bsl3VPo6ZciJrjKaZpxhVjBsQiuqB4ubIM7byk6zylQZskXrF8joloyOvN1Ey6UUH0/G2JrSh6Q1HgAA/mvpB6xavbzIA1qxcdZF2XXz6/U5qKo6UN2tdJT5KtiPYlT9VtosnSaxjwWpHNimHVbyXmyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612893; c=relaxed/simple;
	bh=yx8G5kN1dPvXv5haopV3811q4NYnuaEFQqxgpb3NT9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HdhzetlB4VJxFJUg+OQcDnxDbavcAiVNa9ze7bMHZwGMWTSn0xaZ9X5lTzsZSpwDnsviidqtFXR2K4vO2jjuXJdt1EYcQRjOj6ukg9ecJhL2gppT7tDcKQzl6hrRMWAu0z1dAmbCxQPfjZZM5zn2L5wppuoA+q7VtAMSHGqmM7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NrfxCNhi; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53da209492cso6811283e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1732612887; x=1733217687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YL9Ut0Si+rVh2q7F4JB/asIqIrf6jT+s8Jqs0j7Utvw=;
        b=NrfxCNhilBiejXHT9F52bpfhlKI8cP9bJGB16MQHlKRZvZwLiRszjJ90dAXJHV2zue
         VnJV35XznayLZuWj+EUz+sY9/XHmgGqjziXqcjSTzs+zUZ4Oh2HGpGWJicTe/jv9aw5i
         zKXCZHUQAO7SN2TmaGYUx5K8ioS4bH/T40pMN+WVMo3A9NAOu6iL4jSjycvU5FIOgKyu
         glDKSLCbYapA1ZzM5HtN+VR7zqxtLgVt1xDTlSPaXJpUMEmF0+rJQif9qTNO4xyMgb5E
         eGrF3e71XVu8bB5N/ms7UHFyUjoP9NdCjY2HrQ2vUoeBoE20kBz8lpr0gSW69LHIiEa9
         Su4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732612887; x=1733217687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YL9Ut0Si+rVh2q7F4JB/asIqIrf6jT+s8Jqs0j7Utvw=;
        b=rdx7blbhY/D7A7Mdy7DPfV5lHYSeRYLVlRZ/g7tExo9PZZzAjRij6FmSHEuy37sJHe
         go+3610qY2e3jsGlQSFIEQDPBIEmwYmd9RbBocwcH/IjUpmIUIrzbc6vkIH5dnTMLrkZ
         9Vx3fKaxj++LwpfSz1v5zfx0Hkr+3Fc8HDvQDnp1k5IVZVLs8kNRBuzJKAb0xw2hbP1r
         QgFoI4aYkrIsbC1KqXNamduP80ubUA2ZGAeEltb6wPNHDB+kA9XyhES78MuGtnqK/idZ
         nVfitHDS5yCo57DzAEG+Qq3LinlEkWH/9B+hi/GIb3E6St+C9h1NnrDKg2+YLnS+tiHb
         Oo+A==
X-Forwarded-Encrypted: i=1; AJvYcCVOoldWk/9unLrmymyLWHD9IhYa7H4D5GXCaGgMtyrS04hmtS6ZieIxOGlZq+keyA0qF6HlfPTx7y/Dlnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBzlZxRQ0WYWzNYf9Tbx+GOlfMoxunpvYXVhOrkzfCvIaKenRN
	HiIzYn8/5B0B1OsCtTLJFtJvi5v9HGAs7L263Sc1/wdizPMN6mZurUVxkH6UAU0=
X-Gm-Gg: ASbGnct32gBtbABpRwOG2hEJL83zSrrpEqB4s9LFxTnsX9Xz30GWPq3wseHS0apQauM
	CYTQel/pCTFhFUlRmUFDSUuxpW0oShgnGo7Uwq4zeu8noy4HcE0KC53RdABuilcF93c1eS8KhZh
	ZNTpZf1SKXEOL603N/MvHdY3WIfeIGHyAym5fGuOxjpGFK5xIJpX9xA/j9P00bDPF0tedXa8PBU
	QHPEqIj1vX1cpxKDafQuYnXbmpZLcfz2+VOC2RpR5QXxJq6582CMEsofnOBcHA8IdflQlnTzZTo
	3Pw=
X-Google-Smtp-Source: AGHT+IEqjpoyWsGOaOphc9gwJtzIyZu0gka779JBN5g8gKK1cf1hZ2MPQM9ajRauQ6fRNW3ZJEX2Wg==
X-Received: by 2002:a05:6512:e86:b0:53d:de36:7069 with SMTP id 2adb3069b0e04-53dde36707cmr4605894e87.6.1732612887547;
        Tue, 26 Nov 2024 01:21:27 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc3a47sm13027694f8f.73.2024.11.26.01.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 01:21:27 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	gregkh@linuxfoundation.org,
	yoshihiro.shimoda.uh@renesas.com,
	christophe.jaillet@wanadoo.fr
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 13/15] arm64: dts: renesas: r9a08g045: Enable the system controller
Date: Tue, 26 Nov 2024 11:20:48 +0200
Message-Id: <20241126092050.1825607-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241126092050.1825607-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241126092050.1825607-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable the system controller. It is needed for USB and SoC
identification.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none; this patch is new

 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 169561386f35..89cf57eb8389 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -207,7 +207,6 @@ sysc: system-controller@11020000 {
 			interrupt-names = "lpm_int", "ca55stbydone_int",
 					  "cm33stbyr_int", "ca55_deny";
 			#renesas,sysc-signal-cells = <2>;
-			status = "disabled";
 		};
 
 		pinctrl: pinctrl@11030000 {
-- 
2.39.2


