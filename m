Return-Path: <linux-kernel+bounces-517895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CD8A38714
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825BA188ED7C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E00A2248B6;
	Mon, 17 Feb 2025 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgUl99y5"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D569C223316;
	Mon, 17 Feb 2025 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739804277; cv=none; b=S7CMYA5iEGxY2nn0iR6VzyjGQa0BtI1VOi8U8UMzePxR8jw/Uqjt2/ToBD7kgQj0ZJD4lAkPdyqE/XA5OzuYrGHC6wpjy2u6Yc1aXsJ4k1CMxOaeOsM1IyhzhJyLUy1/K+pM2aSglI79QfUp5hiDD58UuAsTwPDS5yj6dk+eQ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739804277; c=relaxed/simple;
	bh=3xUxJBnNR34hA0dS2K5KCNKLuezaW5408mwlrKn6eAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/KhQfnYX4yjIzPwMsThIajWhbVJMKb+adaBQDIb5X5cjJGTZOK4pZbLyqX8ELyQWxIzOBzm1Z7LYoLWlono9dsppFaojNQ4sKV2jGcG+thSb9HU0US5KlOO6B+b2yf+G9xKwLxFmP+JL04ThC+TRBPS18gzc7xJSlwSZP54c74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgUl99y5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f22fe889aso3475069f8f.3;
        Mon, 17 Feb 2025 06:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739804274; x=1740409074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPzjBHrzzVCbUkGlqURX2pauy/TIgkOkpaFezU8RL+8=;
        b=bgUl99y5JfqW+kS/FuuOupLXIoZomDX+O68U+ini/QqsowwwlbOa4fhHT4hs9Feni4
         Dtf5E+7UOy/uuKHZkG0r4Gnq7hEoqAj1BzdNg/0Mal18t+nuWuYGi4yy3J5e13NRXucc
         lp3mLvQKZQzJ+tcZrCoRPQ2ywafpFLhwWfKpdDW8FK2oDco63+ZMZ/vG/omvS1yYsng+
         64TbnZp9W/nlfxYJHHL2hHFroyObhb2snKB1Rs6FqikTX8UzQ1VL94AEg3ZkswLDwOHX
         nPT8wV1CCccqdshw7C3H9EoEZmRAkRMHKFhkc3IWyRAVza7UTMkQV+qr8btXpsU0OyBk
         nTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739804274; x=1740409074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPzjBHrzzVCbUkGlqURX2pauy/TIgkOkpaFezU8RL+8=;
        b=UApsdsJBCrTLm72siw6eyUypwTQrB2OiAMGqrNzKM6Fnea65Nt1ZF+vfSuBhCUCZQb
         uQwrkRIb5Cu8i+67vjdoa6F2DWEpXpZU4QFsL5On6Y+vRxHmqeLlPSXRu+jgBULalga3
         ohQuGT+RDZ29mUXJMDKDFig3XRm7ZIymdYMq7hSKk8Ew05Iq3hreejx9FPBUCdCzihDX
         hzWZ9HzJL36aF3yurIYF3nqLzVZ+uWcK5khYyq1xQneUNGH3rsjT+9q64GykJtrn7oxE
         Uuj+znKlzQ0HqOaRycb3z1HTDcFfh8gwAkIpW04iPKieB0lQYUtGnzqWJ5/JCnaK+jCM
         T4wA==
X-Forwarded-Encrypted: i=1; AJvYcCXnxfbbWN5s6fv/xa+KfvQI96tpO71TlirO95Cv5lLO/5ZlISTrdMiGUBTiJdsOSBnxIpidhekfc/A1mI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycLGkgFJDYAQP/I/AuUj6N7Up+26Wl8etLhEtK3uKRZyO/fkgm
	AGfJ4g+haxlNdsyJ6NN92VWadkv8b3c5/3icKIukChudXUF+M8Nh
X-Gm-Gg: ASbGncuXBAMzlj9jjI7mqLzXn8I4RuLVkDjhabwfY28K5cBaUNuxh/jvurVzx7z80OS
	JcoAvq9ltTpnilyHLL7GxjmkFskquTEJ5W8QLjD62FvIpMA4uB6LrSUBBVUYONpSgxkbpagkitT
	Ab/NYQqp3J1Y/bkUc92U6H4NWVa6k5rkjrqej/8ETmG8R9ZQjPj+RdfJBc65lRXVezAvPc8iVs+
	bSaylHBTHIxrul4ab1+qKHShp/pBkHcQwCD3FNDc4f+n09Ummib4DZQbRHTMLrdYzapeZ8n8Ms7
	McAB2Ym01d96zdY2iOcdb6X8Ljxi6zQ=
X-Google-Smtp-Source: AGHT+IGK7+cIXXgIKkuykxAfls8SaqI808N2jXSNqI/UIxUmdRXsLloVYzsBEB3YjD9VWOD/Jw0UYA==
X-Received: by 2002:a5d:438c:0:b0:38f:2856:7dc4 with SMTP id ffacd0b85a97d-38f33f62c72mr8242324f8f.55.1739804274078;
        Mon, 17 Feb 2025 06:57:54 -0800 (PST)
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:48e7:ac19:aeba:f677])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25915146sm12645020f8f.56.2025.02.17.06.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:57:53 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	francesco.dolcini@toradex.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v1 1/2] arm64: dts: freescale: imx8mp-verdin-dahlia: add Microphone Jack to sound card
Date: Mon, 17 Feb 2025 15:56:40 +0100
Message-ID: <20250217145744.179213-2-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250217145744.179213-1-eichest@gmail.com>
References: <20250217145744.179213-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The simple-audio-card's microphone widget currently connects to the
headphone jack. Routing the microphone input to the microphone jack
allows for independent operation of the microphone and headphones.

This resolves the following boot-time kernel log message, which
indicated a conflict when the microphone and headphone functions were
not separated:
  debugfs: File 'Headphone Jack' in directory 'dapm' already present!

Fixes: 874958916844 ("arm64: dts: freescale: verdin-imx8mp: dahlia: add sound card")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
index da8902c5f7e5b..1493319aa748d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
@@ -28,10 +28,10 @@ sound {
 			"Headphone Jack", "HPOUTR",
 			"IN2L", "Line In Jack",
 			"IN2R", "Line In Jack",
-			"Headphone Jack", "MICBIAS",
-			"IN1L", "Headphone Jack";
+			"Microphone Jack", "MICBIAS",
+			"IN1L", "Microphone Jack";
 		simple-audio-card,widgets =
-			"Microphone", "Headphone Jack",
+			"Microphone", "Microphone Jack",
 			"Headphone", "Headphone Jack",
 			"Line", "Line In Jack";
 
-- 
2.45.2


