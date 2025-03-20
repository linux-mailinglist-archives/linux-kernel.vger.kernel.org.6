Return-Path: <linux-kernel+bounces-569538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA5BA6A448
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 688487B2563
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50EC22577C;
	Thu, 20 Mar 2025 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="S/JV0h9s"
Received: from naesa04.arrow.com (naesa04.arrow.com [216.150.161.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A5223719;
	Thu, 20 Mar 2025 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742468163; cv=none; b=WfYr9yFmtKA/Y+7wA6nk2nszv9MgX234DjgNQZQpofgYLZJoNfphj1sanGHp8P/i02mHcJLG45Dl1OxIP1plHL2yiAtUfjbkRBgXfOBNYLaSgdimqmX+d1UaHdrjHHjCdgGF5xMaWcuk1F6XIiVQJTNTaO1i8iPlxOYucimVsdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742468163; c=relaxed/simple;
	bh=48tAi45I8uFpjXnUr6Whz6NO1YAMjCklEIDkcMApDYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jxge+rizM8IhEIzi/bOQDQscJgJ6TJzal5cUfiFPD7+NbQg72gFIPDzLv1Pff1H/KDc+wJkL71KIxw9rEF65egoM+PUzfV9JKqNnRXg1DsWQf0MRPTiqxo9Cjjd8wVpCnBWfP9mmBa3DNmEnYI3E+zE9HPynecsEHAcs+dA2A/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=S/JV0h9s; arc=none smtp.client-ip=216.150.161.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=einfochips.com; i=@einfochips.com; l=984; q=dns/txt;
  s=NAESA-Selector1; t=1742468161; x=1774004161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=48tAi45I8uFpjXnUr6Whz6NO1YAMjCklEIDkcMApDYw=;
  b=S/JV0h9sIILohJobk8gFXTTCgo1adNL7tHQNi/qAw7TXBSxmNLsq1c9S
   spq6b8JF7sN8FLKcqSWqeQq1farST0/nM7W4LwKydvWCjLVGpxxfUCPWd
   i1wwpgAv1nlk8ZLUYFDUK1lh48rO3t6mgM3dWgurNZ87C6QDBaErz77bn
   FZmgfTaqjqVV6VoJgXBG7ix9nlQtGZrqmUB5l2AABQnk21Lgg868s0OkF
   eovjqIaJT2eMzMHrz7Yyyqh2u+z5CiyaWjeltJmwFOiiKSPqho0PwjfaM
   W3LRn+sgbxM4vY00L4meP6rU6zQrRzFpn+lr+yHeEr8DuBsmHwOEZFs3F
   g==;
X-CSE-ConnectionGUID: XuAfGMfURxWbm/K/Mu2rjw==
X-CSE-MsgGUID: UUCMG54/QQqQYub1WfEu1A==
X-IronPort-AV: E=Sophos;i="6.14,261,1736838000"; 
   d="scan'208";a="80263089"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa04out.arrow.com with ESMTP; 20 Mar 2025 04:54:52 -0600
Received: from AHMCPU1888.ap.corp.arrow.com ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.14393.4169);
	 Thu, 20 Mar 2025 16:24:49 +0530
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
Subject: [PATCH v2 01/10] dt-bindings: riscv: Add SiFive P550 CPU compatible
Date: Thu, 20 Mar 2025 16:24:40 +0530
Message-Id: <20250320105449.2094192-2-pinkesh.vaghela@einfochips.com>
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
X-OriginalArrivalTime: 20 Mar 2025 10:54:49.0757 (UTC) FILETIME=[8077E4D0:01DB9986]

From: Darshan Prajapati <darshan.prajapati@einfochips.com>

Update Documentation for supporting SiFive P550 based CPU

Signed-off-by: Darshan Prajapati <darshan.prajapati@einfochips.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 2c72f148a74b..3ee7468001f6 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -51,6 +51,7 @@ properties:
               - sifive,e5
               - sifive,e7
               - sifive,e71
+              - sifive,p550
               - sifive,rocket0
               - sifive,s7
               - sifive,u5
-- 
2.25.1


