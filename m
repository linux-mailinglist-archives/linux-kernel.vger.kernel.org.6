Return-Path: <linux-kernel+bounces-523674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2331BA3D9E9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17DC0700A22
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B56D1F7060;
	Thu, 20 Feb 2025 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb2qg+Lv"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768E71F55ED;
	Thu, 20 Feb 2025 12:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054154; cv=none; b=PXeS3tGsgiyOrw7h4z1n6AdIFFPUj8qMuuTaDqsn6+L0YZ1smL+nqD2QDByw2qZXoXaOZZGFD7itzAd2tyI8KVEjgOJSbx1SPiIZFoMu+b6j5CVb6rzsz2cVttrkpX/fD4LS3KMBg1NeUfj/9sSoPf1XgMVErMYrfWM8fXLQNck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054154; c=relaxed/simple;
	bh=ZoFAboTTORCIiwfMRZBtk/4gIxbXbV5LowBP1mj/Ne0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nBQm8dJMiIim56dk4U5x1fzYgPClpMgD9ExTSRLu1M9Gyq+h0qKm+007tEl/swOTxviFLhSEn9sO+pYX1bYfvkKAqmAvp752nLS2QigsasQjz1uHZi+zI2pLo626F/h7ZSUl6mP37z0Wbk/Wy7RHaF0R0w5E/pu0ZC0BAyRdN9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gb2qg+Lv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220bfdfb3f4so17451805ad.2;
        Thu, 20 Feb 2025 04:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740054152; x=1740658952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTteZauPNy6vSlRahT0l3anygq+qMXyNmxkONLZYlOk=;
        b=Gb2qg+LvhSl+EzLp6GtGy0cj0G1erHYNNQwtyOnB1hipuduGTn3/uISAlD4BC25He3
         XczIgtZeLeIUREXlVYGoTftSTZJZUYslsg/7aTRMLr6MTjGEyKVzHnxT1sp2Dcqj1lQE
         Hp/eozdKfXJktNwBV+TZi2bPfRA/fGXdwuwOMipy3HcQL7+XO4/F7k3jXkiywLBLocmk
         7saHy0wP9k0rea4M9oVAPp8zOCyPEbaROiaCtv4dqSeNCVR1rYW7NAj+kOQvhI5RuFIS
         IeqY4VEk8kSFU+W+pezF1a9M7+fUMLfUVEK7IPgCip6WcYzO156GHSnjz5zGuFthiVNS
         KLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740054152; x=1740658952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTteZauPNy6vSlRahT0l3anygq+qMXyNmxkONLZYlOk=;
        b=QdgW3IvIMtFxg2gkwVbYHV8b4UYnasrrMm157QbQNNPvX003jkWxzezf3LSSMwSv4m
         hQZGW5zgcq0Js62ka0Ose5m+nlNbrHCYCP6oQd/ddZ7JjzfZYRftEXbUnjX1dX43eVDD
         Y//JImfsNK26VJzt2r/+fWt6rymYX4i+EOkiXs50wpmvv3ZY2KG/7oryg4qxBpdBUUsN
         7ALrxpQhvHZ20FBuDrrGhANWHV01/IRuhvfCkovY0L27Awa7zgX4NpopaVU+xRFDBZPz
         zIVXIPbsU2DgzVLIgJuqFP/Hap/VYDcztbuyjSTsHChq6CPFwJj7l3Ghjm13N9lxN3DV
         E8yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcCvEsSeoXAB/4c1U0H1ifLgae0wWA7XN3T5Bsd5fBkAeLRmHNEK55rzURTfZFGvU+MuxXe564BMPt7tV3@vger.kernel.org, AJvYcCWGIymfToGbq0C+GEjTlZhLOyqmPf2b4i3I0uLLfcrSs8hedGh1Io2PCCxLUDMsABDsPPAmZQoADSoZ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp2MyDCHo1g7OG6J8VUAGcWEDdwDf7Jx7mdA1gZ8+yvILCuSA4
	DJiuWRM35MReXb15wCGKdzpvkqaffWd+oJ75OZ959GED5IdnYol7HSCs7g==
X-Gm-Gg: ASbGncvaXWN5/Uq6MBEAt60c8+Eny05DVJyxsW4P99k2z7GTacgcj/6RzQCRUKuwZZe
	NgbBpJd8U5o7VDM14Pm98aucA5Z55nETwc595QIcA8d5Z4GH+LIgmoKpwaxaNxo8JTvPJcLH4eW
	9V0JZg7+/OMSkCXWuYx9vombtjFRawJwhOYCXLpN768ZxR8ouMI5uN4OVBjkmHUBMt7P27vQ9PQ
	Lt03VAWDAkMaXF0keF3AFnXIjulbNkIcdBVnD9OMDURoaDyTw+sWlEGwnLbuPU5nu7/tGVimfJ6
	X90gXmzsvAcdgKyvyQ==
X-Google-Smtp-Source: AGHT+IHbidj5ZO18Td1QTyEmiRAdi45GlrXUu2QGtSYq+K2SCUDB/E/xSTypUJeAm5+h+BQ1uKj1Zg==
X-Received: by 2002:a05:6a00:3d0d:b0:730:9a85:c940 with SMTP id d2e1a72fcca58-7329df59b5fmr13027683b3a.20.1740054151736;
        Thu, 20 Feb 2025 04:22:31 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73242568146sm13653149b3a.47.2025.02.20.04.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 04:22:31 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 20 Feb 2025 20:21:43 +0800
Subject: [PATCH 2/9] arm64: dts: apple: t7000: Add CPU caches
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-caches-v1-2-2c7011097768@gmail.com>
References: <20250220-caches-v1-0-2c7011097768@gmail.com>
In-Reply-To: <20250220-caches-v1-0-2c7011097768@gmail.com>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=ZoFAboTTORCIiwfMRZBtk/4gIxbXbV5LowBP1mj/Ne0=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBntx5+LCgvVTDgoUd0iBlRyUgpGAbBux2045I4f
 yesRBGCmreJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ7cefgAKCRABygi3psUI
 JEF9D/kBf5LvSkslGuNWkshtevt+gtvr6PpA6VRTGq61xc8YW2hC1gZJ+Rn4wjN2tLU0eCAFZpz
 WO98sKNPxSTADYzQFT14pDlMM9lx50sXJcmES2LUOJQ6UOkE9daYhheIS1kC5L++RNy6E6IUZB2
 /JqxIUtYiJGjneJU4c2jrViqdEzIG2sgctmLjGoxoIjsh59sW3ZO5Q4Tawn92HakkLIW+rYOuE2
 sqWCs9IQlDssCcZ6LCAWKQbGo0CajB/axd4mfDrax7vwM6bZD8H9p6oIjEL9GgZv8bO98O9Z3bd
 /dmqLiDZzYxRDqvifYw596GiSPbo8T8bqkO/mkwIUmwGlx3rzDV3p8kjQzi2MeANS3dYF0jatR4
 BmCepz1bTt1gjVq+v2AZW8xx/OgpeoWlDRV1R+7azeqdqMZhc9ICHaYWepQKqDVGfvxJhN3BFMK
 I53O8lpFOf29VsO70pKUZLDhTAZrWjeQBqqxoRQL6QDBmIHnLXkopzos9VczWwLTFpgGezRturI
 k5l3fPHGzbm6aa71sIQIW3m+EbylfAtqO14xw2c+PH5S38fI5BWi9NOqgqh3vwIR0bbcmOBPnB9
 rm8oecdlwZ96L8wpnm4M+4RXVI7guU0mX2L1YjkEzyd0wiFSLCD1LklfeeOvWAnNfO8Tm/MtLuC
 6eRDePdEEAEhWRA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add information about CPU caches in Apple A8 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t7000.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t7000.dtsi b/arch/arm64/boot/dts/apple/t7000.dtsi
index 32cac8c30e62d657079dbf32aece8af0fd9cef38..229ebd78c9d14609c30cdd011d1ec59847c846f8 100644
--- a/arch/arm64/boot/dts/apple/t7000.dtsi
+++ b/arch/arm64/boot/dts/apple/t7000.dtsi
@@ -37,6 +37,9 @@ cpu0: cpu@0 {
 			operating-points-v2 = <&typhoon_opp>;
 			enable-method = "spin-table";
 			device_type = "cpu";
+			next-level-cache = <&l2_cache>;
+			i-cache-size = <0x10000>;
+			d-cache-size = <0x10000>;
 		};
 
 		cpu1: cpu@1 {
@@ -47,6 +50,16 @@ cpu1: cpu@1 {
 			operating-points-v2 = <&typhoon_opp>;
 			enable-method = "spin-table";
 			device_type = "cpu";
+			next-level-cache = <&l2_cache>;
+			i-cache-size = <0x10000>;
+			d-cache-size = <0x10000>;
+		};
+
+		l2_cache: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x100000>;
 		};
 	};
 

-- 
2.48.1


