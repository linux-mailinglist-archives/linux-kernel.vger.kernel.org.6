Return-Path: <linux-kernel+bounces-443421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1B39EEFFE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B957176769
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719CE22969D;
	Thu, 12 Dec 2024 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U7mg0IcI"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B9722A7E0
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019254; cv=none; b=iwKWgxSw5l4ZpKPAFwRdUcONGyKrc9VjkacD3fUeHXmwlrqcvkOOfo/tjfHjBSPzQ4lT0YD0g7L8TDFVKr5S0zniv2lJY3SKDLiwD4RoyQevZzEHFTU31+VEatxI8oorm623LVGKK755SS1JPq/KxmRSYA1lOGSwbGqVFDK/clQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019254; c=relaxed/simple;
	bh=g9Y6c/Lu4XdnwvVgrnVv9tKSFGDPtKMBC9QqU0RCKUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gDzujXB0fjiLA8XAbz21yAsr6VYa77Jfb/WeNwPGh7o6bGk+bv/62KpK8NnIrKPvvsnWM9ykQo5SM9NCpn3qGlOPiIl1nv9nAMaljK6Ws7Ofg4qDY3UfbvDyTN044zW9WtcBFPtXZfE8/H3vUhY/lVBsh/juoojCm4yFRB9FjCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U7mg0IcI; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385de9f789cso603102f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734019251; x=1734624051; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oL8eR/tz3ZIpCfja0LO2ssPcqKhJCh2en92mW/OWpZE=;
        b=U7mg0IcIlNEQuvGd21pN2PvtcuyIqrA9uo8oWNG+/N6Kmm/pbOruqIQGLUIdvI/kXE
         uqrANBIzr5MoAOSJk9HzPn3uCJaC5bkkIXmVR+pjyB4C3oERamdbq8SdgJKa2214HI/p
         sSnre3MHwvJk3f6xS1FLjCyNZ4HI+uV1w6CGAS1mglImc245szJ5+lpYMUrTdl5ijsHj
         BO1X57cOUP2rPoGcOi5kwx1w41SHyjeXr9Blajn0J00IVcy6Zp5eaaBfP8ajpQoXwHfy
         T5CJTnSeSoYO/ivPNqI2t7R7lZbvaNYDi+bgilpdwXHhd2MaBxBID/EJG2JeeBno76AK
         k4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734019251; x=1734624051;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oL8eR/tz3ZIpCfja0LO2ssPcqKhJCh2en92mW/OWpZE=;
        b=ExHde7JY6IaG9bYrc4zyjFXNTkvdxm0gMrO8CJW1LLocQpSryxlLUwR+1xFIRD7Rgz
         H+YG+n1jzyK/pTeo3HQSQsgVUh+N5vJMw+IGmVh4ZQNnMptNdOfnEArI7OtsQGUnIP1C
         1GOWSBqY8o8cp5f0EbUdLb/7L+pX1r90ydA6BZs4UBNWYN0+7IE0GZwlsbTKbwwNQVcR
         6EQiQmMB38Of8hOyvHnDdBKxe9kftBq1DB3LyZJGKRfk/vA1ga1/lJ2vsi3ilN9oT0kD
         r6CWRQOb/VTjdDfm5Pi5cMqTWeQKvFpDQKOGNt+0k3zNlpoyEBZRig2S2AZvc/mR/8sI
         YTlw==
X-Forwarded-Encrypted: i=1; AJvYcCVWkgrov+mcDnf/1Uf966n50f6+78q93rp+Slv/8ZTaQejAiCacU26H1xvybomMVFg063ewjx48J7m1kTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX46f/p/pHYsSQess7z5nKuGCNlLv4AbmcsEwcgVLSseYOPyZf
	IBfb1cAlN2B58H5+uo0AGfRIl3dTRXzWw4rNs/XM+lKfe+VZSvj5eeHxtRoMBmU=
X-Gm-Gg: ASbGncsP3i0i30DUrUhhzOpT98dIItfD9GfKGdOQLlGntulPyz1nuBzqi8iW0Zg52jC
	dpgDqRRRIOrDn5iwTCt6ETk+XCrvFyPRdRa+Z/mzXItULIoE53ZcZpyzJyIkrTjlehYXycGDfdz
	K2pPVtSgQn9hEc/H/SOgXn2bfoiyHVl65DRVkRAEbVnf3u2WJC1PFD4Cfs0Vd2kBZqw75e+BaVJ
	F0j0yzDX/UxTPVfcIKpKbFXf+ScI4LjfsquuHJYhHn/msuznD59l1poXHOUMXtGfyItzolXHgBi
	loYu3btRbAqVht+dX39/hd/wGGsJDOFPKA==
X-Google-Smtp-Source: AGHT+IELIxGohPpZyWs+kDS3Jy7c+lDT9602oSXSeH7EbGUTFSeHBff+tDxvNYOauQEuqumTsB12pg==
X-Received: by 2002:a05:6000:186b:b0:386:4a24:1916 with SMTP id ffacd0b85a97d-387877c2690mr3555724f8f.55.1734019248941;
        Thu, 12 Dec 2024 08:00:48 -0800 (PST)
Received: from ta2.c.googlers.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514d35sm4462941f8f.74.2024.12.12.08.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:00:48 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 12 Dec 2024 16:00:38 +0000
Subject: [PATCH v2 1/4] arm64: dts: exynos: gs101: add SRAM node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-b4-acpm-v4-upstream-dts-v2-1-91b7a6f6d0b0@linaro.org>
References: <20241212-b4-acpm-v4-upstream-dts-v2-0-91b7a6f6d0b0@linaro.org>
In-Reply-To: <20241212-b4-acpm-v4-upstream-dts-v2-0-91b7a6f6d0b0@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
 peter.griffin@linaro.org, daniel.lezcano@linaro.org, 
 vincent.guittot@linaro.org, ulf.hansson@linaro.org, arnd@arndb.de, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734019247; l=979;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=g9Y6c/Lu4XdnwvVgrnVv9tKSFGDPtKMBC9QqU0RCKUw=;
 b=pe7nkbrj20qSYnrPkOzt+GqPA7lDUyR+IOiNPFAd4WlYXzbH8ZVMKRBtJ2AJ6BEWj54kNiXY8
 XhWrSTkps7uBOgZLxbruYT2X/DmIRHZ7qF4C+mnzBjagKE9cPO7q4Im
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

SRAM is used by the ACPM protocol to retrieve the ACPM channels
information, which includes the TX/RX rings among other channel
configuration data. Add the SRAM node.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 302c5beb224a..1441e9a252c2 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -269,6 +269,14 @@ bldr_log_hist_reserved: bldr-log-hist-reserved@fd900000 {
 		};
 	};
 
+	apm_sram: sram@2039000 {
+		compatible = "mmio-sram";
+		reg = <0x0 0x2039000 0x40000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x2039000 0x40000>;
+	};
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;

-- 
2.47.0.338.g60cca15819-goog


