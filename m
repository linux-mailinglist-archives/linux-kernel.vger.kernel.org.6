Return-Path: <linux-kernel+bounces-548789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0D8A54963
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E288B18969BD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7550D20E319;
	Thu,  6 Mar 2025 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ndUx2INf"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF6720DD50
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260646; cv=none; b=MSS6uZaQtBhMmHgbsbT4qagZx6n507HyU5M95fh8RDWiBP7S6JvzntfYBZa+MtYytsvME0vIbhow8No+fVjv3NMHeBu2qzdCOL3Zzq2TkwJ7NKoyrbvB25w8ZCJScYDsLCg7uC9il1fvsXMyxlNRaHzQUsh6XcNIQ2qzjkhoPHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260646; c=relaxed/simple;
	bh=MWwhsP/1Gq2jtC+XMH/+PSmlpfJmY2R2gm9uwDR4fZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Af7pp05mbJwPPJcYmcVqVpbklTOmqy2xo7gSWuqzi55OBkUqouI1fJBywdBF3xJpx20tjRwTFQu5dZJM1xMFRc3+ir8b3m2KLv3ktqMjNHCRn8fNAKaiQOZXR6L+iGcZWsYWKoBF0EZmFud3kVUv+tC8WOdfUROckET8KZXxxBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=ndUx2INf; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39129017bbbso235633f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1741260643; x=1741865443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mr8rvSiMKhhr7+g2wBjSbr4ZapMlTY5YRIRH4XPzpek=;
        b=ndUx2INfq/L2o8KnUsKtft29cbyaHZL5QwQ0dZV/Rtop09JheCKl7XuvhWC6yeAtBe
         CvulEnqnhEhfXf9odA8+dO+hj1VxvNcOxFeElzBx4Za9EW65dPrCa2Dy5QPIaIsv7QEp
         PutrbaLRzRlIVY9Yhiq3SE8wJbqHMyz2N5xQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741260643; x=1741865443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mr8rvSiMKhhr7+g2wBjSbr4ZapMlTY5YRIRH4XPzpek=;
        b=xQsyI/7jNTUvjAt7aohE7p3xc7Km64M5RAn1LBfu8hFwNVou7ioRprVvq6L3C45wxG
         R+/xzMAKCR6xI+rxXTPlHfmwiPlTkIqdX7Sdum3lSU+W2PHVnNZfEudChjebGgxTqQji
         2m58iYv5VUsC7+2kdavIfAZ1cygNDf2N4v6bQ6UctVPvHAgWHOWPggHODL5tl4ac+TJR
         iCyMmZpr4l+lwYMcHwkqO3gcArFHX+nrVT5Kzo+s9/cph4dkB4A6DhoUhP2ERm0DeH46
         I+G0pPufJIdyrB8tnLpXmK3pDPwskn36NNsVJoeHYrjrcX2hUhh/YJDMVYbLY4upDD2e
         2ZmQ==
X-Gm-Message-State: AOJu0YwvDHQgeiFMRFIUYOQWPwK2BRx51VDLdmO5kPewp+2s3Hn5VJIa
	aOfEMyOrUet1wSlgHs+YFfDeUMUmw0LhPfCbJzk+qngh5qgFTfHiAlU8TmfUudP5Eqr3p+YTSuH
	V
X-Gm-Gg: ASbGncvJar/KA6Ke2Z1r2vgwyIOp9x4fDOKjuy09bBquQtQilR8uABfO4hmtv3a8kq+
	ZdhMHY1UQeXjOvqTFN3emZmBoJIsK12LDUcxy7QA3QPqoE7BvzGFL5vxo4s1wjYcClwBdKTtMq3
	yaL+yIa4DxUFhp8fKq9I8DEZlWQLZvAoCEAjT+m4430S0dQSrjAXTh0vQyVindxKqBQK4CHmRJL
	3FCmSk6nYGuWx7rvBFH4ILsxCSWC09ygWvl1U/NCO326mAs1r9kXYv/FQKfG5mnanSDYpagWOIS
	hXVtEeAD8F1RrkvGlbrH5M5CXfEicpbT7+0a1DYrv3pIFFCr9xcDOB2QjB/r/3zy2whRUQVBgD9
	kdBN+XQ==
X-Google-Smtp-Source: AGHT+IHvHIK6gnR7vBN0ADzhz0P4KuVyIojDRjOIHgSb1eLz6CEIpvyk+w8pwsH+YWiTBaZGmarvoQ==
X-Received: by 2002:a05:6000:154a:b0:390:d796:b946 with SMTP id ffacd0b85a97d-3911f7c229amr6475681f8f.44.1741260642721;
        Thu, 06 Mar 2025 03:30:42 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:4703:aa8c:6eab:8161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79b9sm1749650f8f.3.2025.03.06.03.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:30:42 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Abel Vesa <abelvesa@kernel.org>,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v10 07/18] arm64: dts: imx8mn: add anatop clocks
Date: Thu,  6 Mar 2025 12:27:56 +0100
Message-ID: <20250306112959.242131-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306112959.242131-1-dario.binacchi@amarulasolutions.com>
References: <20250306112959.242131-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add clocks to anatop node.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v4)

Changes in v4:
- New

 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index a5f9cfb46e5d..49be492b5687 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -606,6 +606,8 @@ anatop: clock-controller@30360000 {
 				compatible = "fsl,imx8mn-anatop", "fsl,imx8mm-anatop";
 				reg = <0x30360000 0x10000>;
 				#clock-cells = <1>;
+				clocks = <&osc_32k>, <&osc_24m>;
+				clock-names = "osc_32k", "osc_24m";
 			};
 
 			snvs: snvs@30370000 {
-- 
2.43.0


