Return-Path: <linux-kernel+bounces-312471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A31969716
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 721B4B2323F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ED921018A;
	Tue,  3 Sep 2024 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wyYEej1x"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CFC1D04BF;
	Tue,  3 Sep 2024 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352294; cv=none; b=bDmZvIcxlkBLUL8/CrxM5orcIGuG4PC3mgCbkWcFlsB08z8yhOojd34h5cvm8oGH/LO+fvnGdeSqDNSSNU1aQ0bd+zq3NJmJGLndTMF7iRXOElXD8QnTNLnT5L0ZchqF/FZHLixtqNA3uADeGoGZ1K6EnqDB/K0mJtqwbvYthok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352294; c=relaxed/simple;
	bh=lYG7sWLNubhIsgn0ldrRT8aWjANoNzPbDyV9QnNk6nw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KkwnD43sdKMrUUw+ROhxBSUY3+tp/4hlzcS27m8Ghble/3mQKImWEZQSzQcdgRST+KZWYl52NCxZV4RSrGIVvgQJTR1NOO0zuLXRpuqahZrhop+ylC/bGuGPYkNz30HvKPceuyqIs+mL1HYvGuo7ojKGU45dplrPfipePHnMjXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wyYEej1x; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4838VCSw012770;
	Tue, 3 Sep 2024 03:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725352272;
	bh=hqeyzmvGdqaZH7UmCcauPjdhGh8RVSEQWcfiZFqvHec=;
	h=From:To:CC:Subject:Date;
	b=wyYEej1xCaI5MpeQQNwiZAQEoZWuo15tmtN2nVNydgU630xNy+rCOAkAA2ZmZNIVW
	 HNkdYXUjshXE35Sai4jafegILJLCGQMeCrKXbeEfA6GT7zliLRqUJYDjefBIRoaxNF
	 2w6WZjAR9RFu5k9fkcJ00aTFm/DgFw8qOizfS110=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4838VCrZ036671;
	Tue, 3 Sep 2024 03:31:12 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 03:31:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 03:31:11 -0500
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4838V7kU085647;
	Tue, 3 Sep 2024 03:31:08 -0500
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <tglx@linutronix.de>, <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <u-kumar1@ti.com>, <vaishnav.a@ti.com>
Subject: [RFC PATCH 0/1] Add interrupts property to interrupt aggregators/routers
Date: Tue, 3 Sep 2024 14:01:06 +0530
Message-ID: <20240903083107.3562816-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The interrupt aggregator in TI K3 devices currently uses a
custom vendor property "ti,interrupt-ranges" [1] to specify the interrupt
source to parent mapping. As per interrupt controller bindings [2],
it is mandatory for Nodes that describe devices which generate
interrupts to contain an "interrupts" property, an "interrupts-extended"
property, or both.

Without this, standard DT parsing code cannot identify the mapping, 
for example while booting these platforms with Xen hypervisor, we see
that the interrupts are not injected to the guest Linux since the mapping
is missing, and Xen expects standard properties to specify the mapping[3],
while adding the interrupts fixes the issue, for some platforms the list of
interrupts can be so large with more than 192 entries[4], moreover in some
systems (like TI K3 platforms), system designers can change the mappings
according to system needs and a long list of repeating entries is error prone
and difficult to maintain.

Are there any existing solution to solve this problem of maintaining long list
of identical interrupt properties (mostly continuous) other than adding individual
entries one by one?

It looks like such general solutions will help multiple platforms, TI platforms
use ti,interrupt-ranges[1], Socionext platforms make use of socionext,interrupt-ranges[5]
and multiple other platforms which maintain long list of interrupts in DT[6] can benefit
from such general implementation. If there are no existing solution is it okay to add new
support for a general property, my proposal is for sometihing similar to interrupt-template
and interrupt-ranges as described in [7].

1- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi#n111
2- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
3- https://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=xen/common/device-tree/device-tree.c#l1135
4- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi#n1346
5- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi#n228
6- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/nvidia/tegra234.dtsi#n126
7- https://android.googlesource.com/kernel/common/+/android-trusty-4.4/Documentation/devicetree/bindings/trusty/trusty-irq.txt#10

Thanks and Regards,
Vaishnav

Vaishnav Achath (1):
  arm64: dts: ti: k3-am62p-main: Add interrupts property for DMSS INTA

 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 35 +++++++++++++++++++++++
 1 file changed, 35 insertions(+)

-- 
2.34.1


