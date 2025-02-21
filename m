Return-Path: <linux-kernel+bounces-525203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772B4A3EC5D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB7F3B6255
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DD51FBEB2;
	Fri, 21 Feb 2025 05:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k18YZGFB"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C81B1F3FD7;
	Fri, 21 Feb 2025 05:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740117051; cv=none; b=EX/kn0gjNGjY47Xk5SgR4UcZwOyeS/WBVJAO1eGO2rB5uF7dT7qPZiDbzkc5YEnVUeBSgK4aQI0ZVaG4mp82tgHF/tXBJXCoM9Z6AMBaj1u/eHqOIoBFe3HTPUulKbiP/73VvcXd+fFNvO2GjGC6SCdZDA/pampQLHl7fUwnCfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740117051; c=relaxed/simple;
	bh=/r37Uw7CkBPVUgHSzBMXiIbx/pc5+LM6KKEWlFa1wcA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T2XSaf4Tcxg9LUvsEyz0xCrsELK+/3LP39kpWpInkrHNxZryEmzKG8RaPL/lBHt9TPbk6xhADz+mg3oeoUUkZsUgvkxQEQydfR70YjIIf8Fr7ByVxOB4E+7NMjwAmXS0VSjKMtWj0sr6wbXP3B4XEljj9XPC9Q1Y6df37Efy3f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k18YZGFB; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5fd19b469b0so129342eaf.3;
        Thu, 20 Feb 2025 21:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740117049; x=1740721849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHGavz6z1XAW16p7P/7q7QGD5LUvtpVWO2vRaC4bQT4=;
        b=k18YZGFBLNql9CHMXEaYY4RhBFaQLXaG0Z5TpXPVL0xhRJ1eVvgSPmzpkrjV/QLc+R
         gBHsxUPitKl5bRmg40zEnPPJA/CPfNoqNSbT+rAtVbS4SzoYZxl8fhQTvjyfHwMYFYwU
         0GfrNDqYGaBlaVwIi1zgkWvE8QP57VeWMosASc77wH9605IcvhPg1dP/pWlC9CiupxkA
         QjUtypRw8O+jgku5ovE41O6YTjT2AbtbcHkm2Nio2h3NdE69XsGWENnYcQYShUt7VdDG
         yv2fL0z4XKpZoevsarrYoqKNWnjuh1dXmk0iqrdgyIkdGSHRCLJcUtTTUMY4b9VPQH0N
         v9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740117049; x=1740721849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHGavz6z1XAW16p7P/7q7QGD5LUvtpVWO2vRaC4bQT4=;
        b=a9HfakDil/mtUvUrwOhLRZSnt9kWM3+Dogfqsdd+KjCY2jq5UOX+BsXvaSb4ulMYDk
         WtswQ/Y0TF0mm5ACRJ9w4qMbjz0Vnls03dPjIeZv2t8NUieKLwo/7gQ8bllzMgqndZqi
         pKvGGNvMovIPslPH/dVixvUHSeILW7AkLJYjizD/t6hbHjR34rPyEVldUWa+bbtk73O8
         suipM3JooUgDvMnQQtVfxlWNmbL/Ah3/ssvUsU7smFotxUz0zBxxFyXZ79Rqc6CHxzd3
         qXy/UrsPR+cqYxE2qqFMLRV/oxHIn+4wPD4PjOJNoKOURXTcAiIJWJ5cetmuGWt9V6Sn
         5YSA==
X-Forwarded-Encrypted: i=1; AJvYcCU25F0q1NRtftIGhmrc9tJi+rmw2eUwN9xstBex9D0nx1p5tD8Mm+4Ec7k5jQ5mj9qAp6WT4948tJg8@vger.kernel.org, AJvYcCVs7ByiHK2W4pJ3FVxEIrUH3TWyJO0oRzO4k3Ks77vwEXOb8y69qFPS3anRJJRdCLNZL5Hu4O9yTjbsnwVc@vger.kernel.org
X-Gm-Message-State: AOJu0YxpmFmmJggEgwQDjendoSOsnl35RugbwEbFuOT7l4kgStq6hG7m
	RWLoWW14tIiMjd9oSFPZyPS8D3M5t6I4kHuBQHuJ6S+5qj5534aJ
X-Gm-Gg: ASbGnctH9BkzKZXADMMY8FjC+lSJKlAy0uXIjB2zmeccW5AdQWIMTW8ontmZc8r6ARl
	asIpAorleeuddjwElGo3gqb9/gTdNc4YW+cXbXNJck8ZveyH5MDl38k2I2cwUAN6ZkbHfcoDwzH
	DORncp7AJakaWulLXWLT8LECNhV40g5b6dF3xcl2B+9eA2ldiT27kYYGnuYYEPllOXypO2QB9QR
	t9Qgs1giynZCVGY8/XPxUPPfG8+BrhZuxMgDh/vGirIcJqaehzF10j8GfPkUh+ahNJwnhvHHrXQ
	b65D5aLaLGbKcpqU3gnrQvJ+yJmu7rmSduWL
X-Google-Smtp-Source: AGHT+IFwikgEbJWrEyp4vrUx8cx9RHZSejrAnFnvwxrUiLhFl9PU70edm1tzNRG0rhEUOQ1UVD5Lig==
X-Received: by 2002:a05:6820:8cc:b0:5fc:f9b4:7f49 with SMTP id 006d021491bc7-5fd1a9ab7e8mr984921eaf.5.1740117048687;
        Thu, 20 Feb 2025 21:50:48 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fcdca274ecsm2553301eaf.0.2025.02.20.21.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 21:50:47 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	krzk+dt@kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	tglx@linutronix.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: [PATCH v4 3/3] riscv: sophgo: dts: add msi controller for SG2042
Date: Fri, 21 Feb 2025 13:50:38 +0800
Message-Id: <9706541bcb87fca5331a085dc8e5f9a921ed5918.1740116190.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740116190.git.unicorn_wang@outlook.com>
References: <cover.1740116190.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add msi-controller node to dts for SG2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index e62ac51ac55a..fef2a0e0f7a3 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -173,6 +173,16 @@ pllclk: clock-controller@70300100c0 {
 			#clock-cells = <1>;
 		};
 
+		msi: msi-controller@7030010304 {
+			compatible = "sophgo,sg2042-msi";
+			reg = <0x70 0x30010304 0x0 0x4>,
+			      <0x70 0x30010300 0x0 0x4>;
+			reg-names = "clr", "doorbell";
+			msi-controller;
+			#msi-cells = <0>;
+			msi-ranges = <&intc 64 IRQ_TYPE_LEVEL_HIGH 32>;
+		};
+
 		rpgate: clock-controller@7030010368 {
 			compatible = "sophgo,sg2042-rpgate";
 			reg = <0x70 0x30010368 0x0 0x98>;
-- 
2.34.1


