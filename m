Return-Path: <linux-kernel+bounces-569531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96129A6A43D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB2446787D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3808C225408;
	Thu, 20 Mar 2025 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="Z1OAs5Pn"
Received: from naesa04.arrow.com (naesa04.arrow.com [216.150.161.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3552224B16;
	Thu, 20 Mar 2025 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742468104; cv=none; b=EhWJy1hB23X+MViMFJTlSVSC5/M8zjm78WjFu4NBwqXIEkuI42uRiT1cDN8TYBld9dh2M6HxMKfkOKz6hH7oSy+1Rot+9rPzmfsVAytkaZQpfl8KV/nq1dEJubrShLzT51VvIp9Gqp+YYI8m068EyNsWgz+1gsndRc5gztOk4mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742468104; c=relaxed/simple;
	bh=/DfX64G/gD+2bC60ieqN4nFImELPORhEeqU2sLa5/xM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FwD5/Si5mRlIYcHWmknVEl1dcy6mlPwReXCulmaIj5G7k1bhAbPeUFR7iycOsqaFuGFw1BfZyD+8xvgyZcd3njDGG6dzKA8fu1n8QQmOkdx4QJutHcahuiMt6de/gsQDpe3mVRnrX1n+5HXfI5ug1dKUSBYfsLdahEpoM25i2v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=Z1OAs5Pn; arc=none smtp.client-ip=216.150.161.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=einfochips.com; i=@einfochips.com; l=1142; q=dns/txt;
  s=NAESA-Selector1; t=1742468103; x=1774004103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/DfX64G/gD+2bC60ieqN4nFImELPORhEeqU2sLa5/xM=;
  b=Z1OAs5PnbTW5lWsxdAQEPa7iY5JiQig0huDmT+qsEmhVVRaTBrMDcKbt
   nUZCktYKA/n7SzU/6PorYMNX68izX5UDH0pPyZFy0Xy4p0Dcc+KjZV3o8
   O79Ht3Xj1JY81L4KRFCy0s48mN6U0ETllTPa3zvQ6eamLe++ESBPa4dej
   mpQasEj3Ud5njff0youYKAs9wXgUKkdWrR/JXtgjMSBqV3BzdbYiO9kB/
   UUpJqbUbX2EGf8GilPZAm2LllspkbW5MOtheJCd7M1TZNwb7Ym4OkWDds
   LoI2vWvoiZEfWmiW3BYheUyMaPWE8RH4BVSP3zzCREuPcYOacYcZfyEge
   w==;
X-CSE-ConnectionGUID: 62qhchz7QsS5LW0FXlEkUg==
X-CSE-MsgGUID: kL173Qa6QbGfowzRItJzxg==
X-IronPort-AV: E=Sophos;i="6.14,261,1736838000"; 
   d="scan'208";a="80263123"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa04out.arrow.com with ESMTP; 20 Mar 2025 04:55:02 -0600
Received: from AHMCPU1888.ap.corp.arrow.com ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.14393.4169);
	 Thu, 20 Mar 2025 16:24:50 +0530
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Min Lin <linmin@eswincomputing.com>,
	Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	rafal@milecki.pl,
	Anup Patel <anup@brainfault.org>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/10] dt-bindings: timer: Add ESWIN EIC7700 CLINT
Date: Thu, 20 Mar 2025 16:24:47 +0530
Message-Id: <20250320105449.2094192-9-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250320105449.2094192-1-pinkesh.vaghela@einfochips.com>
References: <20250320105449.2094192-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Mar 2025 10:54:50.0022 (UTC) FILETIME=[80A05460:01DB9986]

From: Darshan Prajapati <darshan.prajapati@einfochips.com>

Add compatible string for ESWIN EIC7700 CLINT.

Signed-off-by: Darshan Prajapati <darshan.prajapati@einfochips.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index 76d83aea4e2b..eb03a0602315 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -30,6 +30,7 @@ properties:
       - items:
           - enum:
               - canaan,k210-clint       # Canaan Kendryte K210
+              - eswin,eic7700-clint     # ESWIN EIC7700
               - sifive,fu540-c000-clint # SiFive FU540
               - spacemit,k1-clint       # SpacemiT K1
               - starfive,jh7100-clint   # StarFive JH7100
-- 
2.25.1


