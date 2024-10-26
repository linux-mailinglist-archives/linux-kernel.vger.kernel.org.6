Return-Path: <linux-kernel+bounces-383372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6AC9B1AC1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 22:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285EE1F21D25
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 20:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F407C1D88D7;
	Sat, 26 Oct 2024 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWT8hV9z"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9671D2B1A;
	Sat, 26 Oct 2024 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729974515; cv=none; b=MLNjTY3XOHWtsQzDCq7CIIR2Jg3QqugFW0xKLP/OX/RBo0ljoZdIJ+OiFEeW56xl4a/id7Rn+I9daFuLOtTmlFDpXD4D2Js07HAg2Xaa2jr838kV7Pxb+F+sEZaS3JCinc1mQaGXBvyUleRSvANBB3j7ew1bqGwqPMAFH4sFWIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729974515; c=relaxed/simple;
	bh=J394BmadQmA1BF0F092yR1AXD6HdCMt8v36z3hVLWCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jAz5/oA1edi4rjg1FSdr7ykA0ksdeNS7Z7uUrQyVyPTmmoolJHR6jaqfT4g+4T2SB4MOTAn0Z1NVpePg2+HVn4O9OQ53n+0Y9WXFWc5zxDf3PfIErgU048nWTQXtOiwl3K12Zpjc9Z/PoWFjOwzDKF8t+cObK7LhdRt/k7+6i6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWT8hV9z; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb5111747cso29031311fa.2;
        Sat, 26 Oct 2024 13:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729974512; x=1730579312; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CsVTZGFbY21TI4h6N0MykNeyLT86RRhuXmj+gk/1J9g=;
        b=cWT8hV9z6u6fXUV0g3jF/nQ7C6amZtKr47diXu8B4vK4ns5tr7jtWf6VyXfLri2EyI
         B0jkX3uzfCfwW2HQeQA0uypCkcQOs/kYR1egCUuytaphz87z2Fl3m2MGBmdoUmJ3LrDH
         2eKsJVwGFqWrf0B0rYR5j2o6KqK7C+RAfpf3QS+cBBSv2Iuysyt3sk756fO9u07HyXS9
         69UFjnHhwDB53QwCrgJE7lzCyeYdkq6QoOAx1MymN/zWT4Ds7mcGDZBaUfO4Qv99qmIK
         o75x8mtRLdZ/ZJ1ptgTVUVDHdUiBl7GeTFhnquZ8uGOXPBpKWzwK+tB1cVgtGzeHUyau
         Z+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729974512; x=1730579312;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsVTZGFbY21TI4h6N0MykNeyLT86RRhuXmj+gk/1J9g=;
        b=iRqIwU4764s/+K7TeqhufFgWk3o5oanELv3yFEmCEEt4ZR3VuHAFmbSdp742gZKuMt
         EO83H1ocdhYHeGJnS7eOJvuXt80X352lodeSJJEJ16RcKorgr60RgcBn+qFlJJHx1kBe
         eNdh94a7XZnHZ0NR/k3OzZo+7ZujKmd9Ub+/5oMZSsUiTSjfYVYMmBH77K6uCXUQPtw5
         pDWOnohvC8rtaLCU9XZEdFbar3dVWhgwrw3jMnSrKYowPa+DzUgBpq6qBmrUHR9cZ/0r
         PYmGW51gmVyCrA9ciZn2AnF623qCwd+cVImAoQNkE3bnzjfZhjExEVCTmoq1IH+jtONh
         5wRA==
X-Forwarded-Encrypted: i=1; AJvYcCVKIAhTNUOp+OAZxotldX0esUqpw6+weAWNmVFg0zZ+rYbB/VE6x83Bzm3x0DJ0o0sMfkmdz8gS573r@vger.kernel.org, AJvYcCW4Esp2k8DWhjz9ESvBn++LNXvT6zHA2fb7DN1InuQOBUGzjuMxRssay8eRC9bimhAokFHwrSK+S2HJeLAN@vger.kernel.org
X-Gm-Message-State: AOJu0YwOk0C8rBl9gJasN2PWSqAnKhuDD5Yz+yMyzvWcBFs4fIM6yMvr
	o0TA6bs498RFno8k0jw8UdE5RSJ9Evakzjmjnyplf+Jc89lYbaEgBzwTHA==
X-Google-Smtp-Source: AGHT+IFkHMcqEsYsUAhbqWkX2bkPWgakOe470h23dN0/WTOTTeXfHC6ixA4LqqD+dEvAB0ZuXSb+qw==
X-Received: by 2002:a2e:a78a:0:b0:2fb:c6e:9a36 with SMTP id 38308e7fff4ca-2fcbdfc6495mr12308581fa.24.1729974511392;
        Sat, 26 Oct 2024 13:28:31 -0700 (PDT)
Received: from [192.168.1.105] ([178.136.36.129])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb451a494sm6370421fa.39.2024.10.26.13.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 13:28:30 -0700 (PDT)
From: Markuss Broks <markuss.broks@gmail.com>
Date: Sat, 26 Oct 2024 23:28:09 +0300
Subject: [PATCH 2/2] perf: arm_pmuv3: Add support for Samsung Mongoose PMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241026-mongoose-pmu-v1-2-f1a7448054be@gmail.com>
References: <20241026-mongoose-pmu-v1-0-f1a7448054be@gmail.com>
In-Reply-To: <20241026-mongoose-pmu-v1-0-f1a7448054be@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, 
 Maksym Holovach <nergzd@nergzd723.xyz>, 
 Markuss Broks <markuss.broks@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729974508; l=1399;
 i=markuss.broks@gmail.com; s=20241024; h=from:subject:message-id;
 bh=J394BmadQmA1BF0F092yR1AXD6HdCMt8v36z3hVLWCg=;
 b=jMGqUvYaEE7eyVFSQzLzTFOFSEqQJZ5vGtuufroNlKvgKvDnsS4nuhMCzmHpP5IIzR/Nupmm3
 dSciX6H/BsmDkAhEovrMcL9ZZapBv9dmxRWHNFnn8O/t3Aik9GRMTX2
X-Developer-Key: i=markuss.broks@gmail.com; a=ed25519;
 pk=p3Bh4oPpeCrTpffJvGch5WsWNikteWHJ+4LBICPbZg0=

Add support for the Samsung Mongoose CPU core PMU.

This just adds the names and links to DT compatible strings.

Co-developed-by: Maksym Holovach <nergzd@nergzd723.xyz>
Signed-off-by: Maksym Holovach <nergzd@nergzd723.xyz>
Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/perf/arm_pmuv3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 0afe02f879b45a8600b9cea1bfd88e6a68096a67..9eb5603e1dda18c4bdd2745304737932a27fde8a 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1364,6 +1364,8 @@ PMUV3_INIT_SIMPLE(armv8_neoverse_v3ae)
 PMUV3_INIT_SIMPLE(armv8_nvidia_carmel)
 PMUV3_INIT_SIMPLE(armv8_nvidia_denver)
 
+PMUV3_INIT_SIMPLE(armv8_samsung_mongoose)
+
 PMUV3_INIT_MAP_EVENT(armv8_cortex_a35, armv8_a53_map_event)
 PMUV3_INIT_MAP_EVENT(armv8_cortex_a53, armv8_a53_map_event)
 PMUV3_INIT_MAP_EVENT(armv8_cortex_a57, armv8_a57_map_event)
@@ -1409,6 +1411,7 @@ static const struct of_device_id armv8_pmu_of_device_ids[] = {
 	{.compatible = "brcm,vulcan-pmu",	.data = armv8_brcm_vulcan_pmu_init},
 	{.compatible = "nvidia,carmel-pmu",	.data = armv8_nvidia_carmel_pmu_init},
 	{.compatible = "nvidia,denver-pmu",	.data = armv8_nvidia_denver_pmu_init},
+	{.compatible = "samsung,mongoose-pmu",	.data = armv8_samsung_mongoose_pmu_init},
 	{},
 };
 

-- 
2.46.2


