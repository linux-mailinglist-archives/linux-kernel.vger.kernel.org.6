Return-Path: <linux-kernel+bounces-200668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6434D8FB32E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F459B2CA2A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8564B146A88;
	Tue,  4 Jun 2024 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHhxRvIr"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307F1144D2E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506342; cv=none; b=fTvvOQ+sxpAu8qkZyawPIbU8lR7fhuDqj3l4rWJVBE95m7iT4kc95WopL3RA3igoVVobLOBV9FQ0De14aaddB4o1EbTmyzSuq2PB8iE8Yqty44vm+2aB7JA2kt15Woiuj4ft6uksz4xdAaw/Jior8CwhXPRvxjqbbIq4zu1+gDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506342; c=relaxed/simple;
	bh=y/0k4cj1U/HXhi7gEv84nKFSEhX46PQFmUke6alZTKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lF8IKu11PnKxfwp5uM31HgeP8G5YpMzYaLFEc2P5C2y6DY9ZX16muiaLYwziu4WNdfWVeM0ZnU0lM2rN/WMXiEgnGsKBEgsL3skAU6g9EbsebiySEUMoYw8evG+zc6Oz4CPq/6bv+2CEMjxjKV56Blb2p0lPBClW6SkRvjA6Gpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IHhxRvIr; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso10477261fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717506339; x=1718111139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LcPd0EvGWInISD65KsuyYkyeorSvJUBJhZgfuheFWcQ=;
        b=IHhxRvIrT+gMz4JDOEds6mhWWOgLigMBF0gYRpdDTkflPseKVX3bRtI+uTmxpCMFQ/
         nvO0xxZcEgo26yqvsjb4w0IvQqutin63RV1NUV6rAI8FyECDmcJHPUcoWnv+2nGovAkw
         S3cejlEnzUNMwyKDUZ2NMP4csaaz+nX4mCYFHcSaK2pZJQMACxylJzPHbS3q4LMYbISF
         g5Offha7DH3SXcRjYcjSe7aqWZyGJ9Qohg/92yi9TUIP8SB1VLyRXNPCVQ0z93qinEb8
         W91dsjCvvYoHom6C5bxCzqnrCTEUg2gmcTdMNNqfr0BY0+uA4bD2xmKtxCQbyTmGu92I
         UztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717506339; x=1718111139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcPd0EvGWInISD65KsuyYkyeorSvJUBJhZgfuheFWcQ=;
        b=NsbyytmQAd03cO9sgN8nI+N+c/AlKARUq+QTn5AjKyogLNmYBPNj+v8HJ4NP+BTPY9
         40MeQy3wrIQ42biA6NTP49f5OlOFLO5HmAh8+1opTHI/+6TX6tMRTfPUta7eipOqEDxQ
         jHRU/8iKPYAC+p2YBDKPlVz3lDpIM5aZry4i3IRVMzU3Zv+jhMOuAHGDJo3LLNj4m73V
         Y8qzasBEpat1IB/pQJ3oOPKwHVEsBHBA3WZ2pwkSpCZhXldLYVF6q00arcBY3AdvJ9fk
         onXpuRz9fYTusX4iSKhoH1yilhUBa02nNn1vbaOJaR2JFuHj3abFcJGiAexeIAeRGwAh
         BnAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuhcBN8cg1SENVvvQbFUPmsYUMjtBxfKxD6velHYsisBOwItHTEILZKZCbnWcbKpAKbZCEHT5Aw0v+KdaqfpH41UtyjPdpwTyUwntr
X-Gm-Message-State: AOJu0YxSRztrI32DSUbpRDSTPwR7g6q7Xq+J0LGv8IihGrQDMS9rFEh3
	KjrGD+OsrmUOyZiAj7A4dmBxeDYyZjAtLvrfYJO/cXWBhPfsYXJJAp06vh76k7Y=
X-Google-Smtp-Source: AGHT+IGQ0jryfZA0LLkh0n2aqxVrJ3UY9JtqM7qOVOHdB/b5Ws7J9Opew6MYO5nTDhRe6XK+lzEUpQ==
X-Received: by 2002:ac2:59c9:0:b0:52b:84bd:345e with SMTP id 2adb3069b0e04-52b8970c011mr7177186e87.43.1717506339216;
        Tue, 04 Jun 2024 06:05:39 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42148ae3262sm29798955e9.7.2024.06.04.06.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 06:05:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH] clk: sifive: prci: fix module autoloading
Date: Tue,  4 Jun 2024 15:05:31 +0200
Message-ID: <20240604130531.170371-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzk@kernel.org>

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.  Clocks are considered core
components, so usually they are built-in, however these can be built and
used as modules on some generic kernel.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
---
 drivers/clk/sifive/sifive-prci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index b32a59fe55e7..caba0400f8a2 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -603,6 +603,7 @@ static const struct of_device_id sifive_prci_of_match[] = {
 	{.compatible = "sifive,fu740-c000-prci", .data = &prci_clk_fu740},
 	{}
 };
+MODULE_DEVICE_TABLE(of, sifive_prci_of_match);
 
 static struct platform_driver sifive_prci_driver = {
 	.driver = {
-- 
2.43.0


