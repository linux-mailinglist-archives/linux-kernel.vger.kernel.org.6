Return-Path: <linux-kernel+bounces-555583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AD5A5B9E9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39303ACFA4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825DE224AE9;
	Tue, 11 Mar 2025 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="qQBAFvme"
Received: from naesa05.arrow.com (naesa05.arrow.com [216.150.161.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6EC222580;
	Tue, 11 Mar 2025 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678487; cv=none; b=l4PUVjQ0+96+0NbI8p8KzAnRwbIYPNdAM76RELmZQdkkpr1dsG3oTZRLgVfWBjnczQ6xJhBWE+0z6bzQiLdkRxP8PgLnQAJK5248l/yjECaAaGwTYndYGMS84cLMQgQYBq1NXmkrkxYp5l4VU9VuHuEzqSWIBqJSpOBKCJsTRr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678487; c=relaxed/simple;
	bh=2J8ImN1eOLZcCD3mcs/m/xlW9C0b++wBIjdeDhMtX88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W6uasCJcNhiQ9rO/ZI0gbgbuOo1GH62d3Q03kLAjyPVi8YQK2o0sPpyef9TrIKAcuHgNAQHRm2vqu1hZjR67yYntY4Wbkt2kb3cgSNPsLN0mU4eVcrbh6EGg6nNvCzCF8ZEfXY+RW6dFU2ommSAsyA5rWpAWSqKkYTPbYN3Uq4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=qQBAFvme; arc=none smtp.client-ip=216.150.161.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=einfochips.com; i=@einfochips.com; l=1089; q=dns/txt;
  s=NAESA-Selector1; t=1741678486; x=1773214486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2J8ImN1eOLZcCD3mcs/m/xlW9C0b++wBIjdeDhMtX88=;
  b=qQBAFvmeupiNVCa2oEWza4gp8QhMBW9LfRM9Kdf/0j2q4bnVQrcBspBm
   PluBDSi9AtWoOfBZQqd/W15/35xROojmZSKrXAXShuoGJS1fORC/Ss3Jm
   8odbHHjH/TKrSjsWgj56xllOBxf5DxwJZ9YxVYL4eBuNgdulT3GHRqjSY
   Hm+X7QKOZDYITx/GK9qJXVKooukXVYRHXebGc/yVP7Uh5c0rYaYcn8RFp
   z+NZ+kjrstDrs/vBfK56MuvmQ0KEbdUgXYTPEzPUVyDr0IoHh+ZWZ58o/
   OrNKL4fbjetm3DrFzGG755w6kY61iBQL9TcxJ2aeLVGsohxZ8KT8wFnPq
   A==;
X-CSE-ConnectionGUID: 280TzgSYRAKvmP8KWF28xw==
X-CSE-MsgGUID: LhzM7vY4TuOYyVdYXkueuA==
X-IronPort-AV: E=Sophos;i="6.14,238,1736838000"; 
   d="scan'208";a="20386410"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa05out.arrow.com with ESMTP; 11 Mar 2025 01:34:45 -0600
Received: from AHMCPU1888.ap.corp.arrow.com ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.14393.4169);
	 Tue, 11 Mar 2025 13:04:33 +0530
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
Subject: [PATCH 08/10] dt-bindings: timer: Add ESWIN EIC7700 CLINT
Date: Tue, 11 Mar 2025 13:04:30 +0530
Message-Id: <20250311073432.4068512-9-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Mar 2025 07:34:33.0149 (UTC) FILETIME=[084B46D0:01DB9258]

From: Darshan Prajapati <darshan.prajapati@einfochips.com>

Add compatible string for ESWIN EIC7700 CLINT.

Signed-off-by: Darshan Prajapati <darshan.prajapati@einfochips.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
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


