Return-Path: <linux-kernel+bounces-226560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B7591405A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB151F22BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 02:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F11ADDC1;
	Mon, 24 Jun 2024 02:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="HKbVWXKa"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D0C525E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719195349; cv=none; b=Pwcyo05EJJDVKMm8bGMgjO+Vzwhi7mUaCOg0nR+5XIxk1fBqeBdomM1TJgsyQVOgbMs4hMwvQS+lTt6CNT2omcdUMh3SDWsqCgBKKk2KcDktyMhEUk4n8i0fAaR/nZC7Y2O9CUgVNyww2RS0yIcHBBFAWRh2N7/6N/jtDLl8/Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719195349; c=relaxed/simple;
	bh=Tex1awMNjudnvI3gtikHr2F7lrSHZ1e0QS1byS+Ld1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z3msUbKWXZezFhFRObIl/+TLX19KN1hn/Clu4OoxVBLZe2cqgEX+liyMjYNcxRmUWQq3xrRDbqLexlptl1jVvryHqh+jfJETBRfZ/dJEEchgP7ARMi/aVH+AtrtuC8B4VaXSwIvCDfhQ4ZoA/oq5vpPOeAHOt2K9izfb7Rwdrds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=HKbVWXKa; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-24c9f6338a4so1973490fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 19:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1719195347; x=1719800147; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGMftM3u/EVg1JXHvGCIYFkGfbzrpBOJHnaNcrnQheM=;
        b=HKbVWXKag8S6sjGR3QKw4VuAHiVq7EgPsf+JZx84o1z2PSCX+lOA63JhSl6UHWYP3C
         fwD3H0gS+I94bf3QsHjQZkKTBYCgsGU1zGXYmuHIxqiULv0WwsGBieyr6gGxXSSwfRpU
         C2MCL9W9UbZxQblIxb1SuMXmdg9Kq+LyzYfKqJAnhhE1dvIcbHI/1m+qIC6V/2WmhNmG
         ulo0NqyXeF3c8WHbV0eiNT6fxHuDTmyEXYxtGPZmNXlyTKPVz+3XPM2BfXMW+9k/pAI/
         yzo97qKLwAziZxuXSpJxe2BE2NER/S1jKZYXyOZwn1+RwsCLMBuCl/AnIf0vNvjeXIdo
         tLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719195347; x=1719800147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGMftM3u/EVg1JXHvGCIYFkGfbzrpBOJHnaNcrnQheM=;
        b=nMhNsruptXtLeSzbr6aTz0OAI4hZyD1LVoyk026HBJLufsbvzxzeZh3MxjJLbUj+9l
         ElQE3OJ3oAv6KcVlqgllTHkXhN+/3w16AyQfrPUNGdgqcIx+91SzT05FiEj0amuNbrzF
         unXzKTaSbkoKTGthpO34NUeMUhneAOPEl7gvHPxh6vMexI1kyU8EeN8lhjLFIr07L2js
         AYbsYfonO7Zs4UbZeg4b8JfX/hsJ0xk72dntt9pai+ONMncvgwTl8rbSLrlapXf88oQe
         aW7LGOyrF3W02d+obo506VcgKrk7d/DaBSCRImczesYUKYyEd2R0y5QtLSB4WKZRPEzJ
         O+lw==
X-Forwarded-Encrypted: i=1; AJvYcCUAyqWGch6dlZoppVHH92FnhOv70HCFwEXS3uW6xHXyA/YRCp1e4GTnvDXHGON9XaZqwxYKHMKYAmS3ElngA84MIkQXvhhQO09EVPIh
X-Gm-Message-State: AOJu0YwJel5ZA9kT0hB2YFvyu7ZxsHb1UH9LPwSJdAFRi47j5RYaVujb
	UGpcmaqT85VNER5s1ZC5n6EHHGbqmlRIgEWle4f6W9HIeidhF5xNsKCx9+Ns0IY=
X-Google-Smtp-Source: AGHT+IEpDx0tS68+3PyfSRasBu1UPwFnFC5nIDXZBQcSCJeXpbH89rMfScOc6GKf5M/rx9toXWlgrg==
X-Received: by 2002:a05:6871:587:b0:24f:dd11:4486 with SMTP id 586e51a60fabf-25cfcf2eb04mr5016896fac.36.1719195347161;
        Sun, 23 Jun 2024 19:15:47 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1802:170:1584:936e:5eb0:fab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706511b137csm5071770b3a.86.2024.06.23.19.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 19:15:46 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Sun, 23 Jun 2024 19:12:33 -0700
Subject: [PATCH v2 3/7] riscv: dts: thead: Add TH1520 AP_SUBSYS clock
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-th1520-clk-v2-3-ad8d6432d9fb@tenstorrent.com>
References: <20240623-th1520-clk-v2-0-ad8d6432d9fb@tenstorrent.com>
In-Reply-To: <20240623-th1520-clk-v2-0-ad8d6432d9fb@tenstorrent.com>
To: Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Yangtao Li <frank.li@vivo.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719195343; l=1133;
 i=dfustini@tenstorrent.com; s=20230430; h=from:subject:message-id;
 bh=Tex1awMNjudnvI3gtikHr2F7lrSHZ1e0QS1byS+Ld1c=;
 b=pu8+Mu7mJzVnU5HrfATMNP9rHowooKXJoEvBNn6bXAtFkRqWrQI19xVB26zkobp5fnXrOXElB
 hN1N6vPKEoNCZlE+eMWGRcGy88R8bdUeAt6ViPI/yK9kVPYosF9CtGV
X-Developer-Key: i=dfustini@tenstorrent.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=

Add node for the AP_SUBSYS clock controller on the T-Head TH1520 SoC.

Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index d2fa25839012..10a38ed55658 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/thead,th1520-clk-ap.h>
 
 / {
 	compatible = "thead,th1520";
@@ -161,6 +162,13 @@ soc {
 		dma-noncoherent;
 		ranges;
 
+		clk: clock-controller@ffef010000 {
+			compatible = "thead,th1520-clk-ap";
+			reg = <0xff 0xef010000 0x0 0x1000>;
+			clocks = <&osc>;
+			#clock-cells = <1>;
+		};
+
 		plic: interrupt-controller@ffd8000000 {
 			compatible = "thead,th1520-plic", "thead,c900-plic";
 			reg = <0xff 0xd8000000 0x0 0x01000000>;

-- 
2.34.1


