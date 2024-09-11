Return-Path: <linux-kernel+bounces-325157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2275B9755AB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5588B1C22CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E921ABECB;
	Wed, 11 Sep 2024 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hoNaWoKp"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6477F1AAE2E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065332; cv=none; b=nv1l4Ro7m8MyoN19ztP/XgaBsO/w4xZUIPvMR5we0Bl3VEYzcsxQ4yl0QY0wlX9sTgH2k5bxgavJUXKORs3imHyAyD4YBA6VPDNEdiSDvD8M3oQMojIJIckJA4/gRNjmppkQXw2aU6vli0HzytubUZKL4VfI9XqECX6lDtSHIJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065332; c=relaxed/simple;
	bh=Mdf/C8H31e0A17oTlgLfRigSnR8yQty9jPtcPTYT7pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9d2i4iIkrc0/TrdAA1l7s4CI8lNkUl1dKdtQBKMNmOtgrN0JxfKAh61Ok0TH304v64mN3HpuigPN7GGu7YlB6A0zdyImgrtorhZ9wE1XTSFZkMCD2gidDNnSNoQdPMoDLq372rkKt9VDhXnDxyWY8XZjHATSv86HR+r4ayRY7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hoNaWoKp; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e033e37bc9so2519799b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726065330; x=1726670130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5leCC+xnoiSa3zCuz8WQhl2vdhzFBVOxY/5F24dS42M=;
        b=hoNaWoKpbcTj6wsW3ixSDFOVz2BctcfvGorVKQKOMJIi3Oqb+PAX5PymPXqT6qAMn2
         G5U1ZtPNOm7xJ7NUYdaiEw7nZVTm01uQD/Vzi0e/UO7C0/SL+GJL/HgDabNvZRhrFoHT
         BBuKY3JAme1U89hqrAjIflyMdq4WzqoZ9Ac68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726065330; x=1726670130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5leCC+xnoiSa3zCuz8WQhl2vdhzFBVOxY/5F24dS42M=;
        b=ADFvsP3+8AX/F8EmXnCgJkJMEGMkVaiPM9Ghgivm7ffSffhuOZf+XWndXLro0oJ7wl
         xnLKUWfcRIERRVPtgowJ/dX05qctfPhsUgL/u1vxa9A3OrEDG/NnhFIbXi7uKfnQPqJ/
         5k1jnTNKbslwkvfGI8r3ZcZvUyKD5AM7zkyxoOIJ2a3wETfgNx6ipYJnK6+IwujJxpb8
         9RJ9ZGGvnUYaWmXp6O3OdsECvJ9eJjF1SnYphhypK8kE7HvlTpVNjMfxyViZIeT+7t2n
         LRaiPv2fpuTcSykYZJfBuYsZNG/gDIqvbJLsjCFOlkg1mzHL/mBrmphh9Q7xYEH5G3eU
         9+PA==
X-Forwarded-Encrypted: i=1; AJvYcCV0dlMaxM4N5aQY60lhOTMTloFXasO9+J/z7BnNS9vyJDsOWjwKOVsnytvMz+pcmKhb/XsSB7w8NI6hNUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1h/eeqFQai9Zf6orGNh8JFj928PEFtloO5qvfHPbaA0JDo5q5
	4sysbrZ6O7DTlkSoC2cXAAelJbC4WSHLnL1+kGmiwunSYPRZNzX1dPJ+kXzi/w==
X-Google-Smtp-Source: AGHT+IH+J+C6d8gNDzhINHwohdN90QAPrsAQWdc7FOUHpN8LW5zv/B/GqRWKq88yB99+d8bvpAIm1g==
X-Received: by 2002:a05:6808:2f16:b0:3e0:486e:366f with SMTP id 5614622812f47-3e0486e38cbmr7154413b6e.5.1726065330530;
        Wed, 11 Sep 2024 07:35:30 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:102f:d738:6069:fd4b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbb5901sm46620a12.24.2024.09.11.07.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:35:30 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 8/8] arm64: dts: mediatek: mt8188: Add socinfo nodes
Date: Wed, 11 Sep 2024 22:34:01 +0800
Message-ID: <20240911143429.850071-9-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240911143429.850071-1-fshao@chromium.org>
References: <20240911143429.850071-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two socinfo efuse data nodes for the SoC information probing on
MT8188.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v2)

Changes in v2:
- Added socinfo nodes in v2

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 6327e1006de8..bf15ac9901da 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1904,6 +1904,14 @@ efuse: efuse@11f20000 {
 			lvts_efuse_data1: lvts1-calib@1ac {
 				reg = <0x1ac 0x40>;
 			};
+
+			socinfo-data1@7a0 {
+				reg = <0x7a0 0x4>;
+			};
+
+			socinfo-data2@7e0 {
+				reg = <0x7e0 0x4>;
+			};
 		};
 
 		gpu: gpu@13000000 {
-- 
2.46.0.598.g6f2099f65c-goog


