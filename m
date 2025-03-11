Return-Path: <linux-kernel+bounces-555591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 726A7A5B9FB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F6918958B4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA400225A20;
	Tue, 11 Mar 2025 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="JeuzAA9/"
Received: from naesa05.arrow.com (naesa05.arrow.com [216.150.161.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DCC224AEB;
	Tue, 11 Mar 2025 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678547; cv=none; b=o7ls0hmS3+B0a87ZrIzjtbyM30qT1O2mX42jnjV7R5BbFvI9yUZpU+PyD0BjjcQhc5VC9yOW7x1+NNuerSUsv01pcHnJj8t6+SM5EjmUdyryJE9nWtXUiw4bAL/P7M5NvnX1j+EIcGp4hLv0BspFDla+F39OpkNXUpgoL7OKHlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678547; c=relaxed/simple;
	bh=OYF7/55p2x4bh2lBVQC558u/lk/ZKZ7jhSldjLUhz/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m13T94AcgFj4t69jkN5zSu0QDGbb1kUobcJwBXBO5vwNMdWYs/6lgdmKgp4ADDgT4iaayuncShgXsRU3afxwtT5xRnUG9Qvglu3UGMe1SlszYHf83JYqPn3p36mp6BZZdYXIqI6Ri8a4NWOnZmz874/OGbUFDiNDE9CLUrMxcMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=JeuzAA9/; arc=none smtp.client-ip=216.150.161.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=einfochips.com; i=@einfochips.com; l=931; q=dns/txt;
  s=NAESA-Selector1; t=1741678545; x=1773214545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OYF7/55p2x4bh2lBVQC558u/lk/ZKZ7jhSldjLUhz/s=;
  b=JeuzAA9/JD8+uNmqt5ljAQKR2vnBcNnDVz88T5+ZfIAP995HeA+UdOqN
   ZSoo7TjqfIVj73qmftd9d7kL8w4/pN0acW11N5eNc45cqxb3ETT7KGN1c
   egq0Z0pdOmDJdi9ZSN30LrIKCR+/+03VIFCQ3oPdISgkgW6bqZODCIP3q
   cpKmlFFH+zhlzqMC9fg5+9W92Eb0T++hWv5rvC+DvOvPW5BPH/Tu/JgiV
   wLxomxiZ2zNqei1sB9vm0L/H4MnMtTjkatxSL4PVrFQsfk66vJmDTebxj
   iqD3gzKmF9JdK6+ZPUyIMKB/cZ1g7PIXIF6knNyJgWv0CayPNA/7rvk+7
   Q==;
X-CSE-ConnectionGUID: dT4PtiToRuao+sHKEdbR1A==
X-CSE-MsgGUID: OGczvkKQTMmOk/VzmHxUuw==
X-IronPort-AV: E=Sophos;i="6.14,238,1736838000"; 
   d="scan'208";a="20386364"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa05out.arrow.com with ESMTP; 11 Mar 2025 01:34:35 -0600
Received: from AHMCPU1888.ap.corp.arrow.com ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.14393.4169);
	 Tue, 11 Mar 2025 13:04:32 +0530
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
Subject: [PATCH 01/10] dt-bindings: riscv: Add SiFive P550 CPU compatible
Date: Tue, 11 Mar 2025 13:04:23 +0530
Message-Id: <20250311073432.4068512-2-pinkesh.vaghela@einfochips.com>
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
X-OriginalArrivalTime: 11 Mar 2025 07:34:32.0749 (UTC) FILETIME=[080E3DD0:01DB9258]

From: Darshan Prajapati <darshan.prajapati@einfochips.com>

Update Documentation for supporting SiFive P550 based CPU

Signed-off-by: Darshan Prajapati <darshan.prajapati@einfochips.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
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


