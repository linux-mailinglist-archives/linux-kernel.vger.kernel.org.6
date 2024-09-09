Return-Path: <linux-kernel+bounces-320517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EBD970B76
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865F31C2011E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3434611CA1;
	Mon,  9 Sep 2024 01:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="CNHcsxLv"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E45D12B64
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 01:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725846446; cv=none; b=giZEQQu8RWaphhPZjuxhfm5Es/LLYcDegEV3wi3duqM9WjaZZseHJF4Gst5QyLWTKtbT20Kpcaq+rhJhHVa5RV3wNMoiHRyqyX83Xb7ef7NKZpudR5mR6C4bIHkuLWt2Ijgv0UZ9xNP/9tlI9LkP9TJTFwzIC7TXdpruVFo1o1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725846446; c=relaxed/simple;
	bh=L9TNAtnBy3nR64TFNqaXVI/oToOp2YKmFJxlvG3+790=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtLEIyRfmermftorB2IyFzWtLWNqBqSHi0UdEfGhb9SqZGWzSLh+XclKkCp30IoKzVACYzsuNT8wBZeRRdsmNQmS/Iw8tI1m/cLjZkQfbRe6HfW8hClVgPXCEtOGCiFoUthEWF5ndD8WNbqIljao95qSTkPVRlVX5DvPdOVhNbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=CNHcsxLv; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 903F12C0517;
	Mon,  9 Sep 2024 13:47:16 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1725846436;
	bh=gpkGo77cm18FSmg2ftRjYbF+hAbg60pgDNCScLTabCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNHcsxLvGlXkLcsuoRKfSgbfzCyeSF7oGxoVF1UNYjG7GkM4KgaVrpyXcyVr+9fUF
	 1OVaq6hPAxE9RmoUcjhsgxRUWbQzXmsa/ixpEuRJR4n1ACWXWcWfPQ6+yliyVM1UnM
	 4AXJGdPlZVCueqIDiV0eatXCD5ovCNuJeo58CFPsIrf9WwRckejbdnv0FQKX7xpUqD
	 8w8DIWfS2cvTopX3+tGG5vUnghUUn1Is0s0umpecfCLe1/UEK5swG4+dJVAK1cC+0x
	 UQTyHJxC6YEPtzhNzqe3yJ4sc859emIiWj4txsNEpW1MSLvdkxgSRU8q1EF+xK7+F0
	 +7qIHNMnFz3/A==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B66de53a40002>; Mon, 09 Sep 2024 13:47:16 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 451C213EE84;
	Mon,  9 Sep 2024 13:47:16 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 4227A28056E; Mon,  9 Sep 2024 13:47:16 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	tsbogend@alpha.franken.de
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/2] mips: dts: realtek: Add syscon-reboot node
Date: Mon,  9 Sep 2024 13:47:07 +1200
Message-ID: <20240909014707.2003091-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909014707.2003091-1-chris.packham@alliedtelesis.co.nz>
References: <20240909014707.2003091-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=KIj5D0Fo c=1 sm=1 tr=0 ts=66de53a4 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=EaEq8P2WXUwA:10 a=oSNYpAVFohJLBMLz1HQA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

The board level reset on systems using the RTL9302 can be driven via the
switch. Use a syscon-reboot node to represent this.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 .../dts/realtek/cameo-rtl9302c-2x-rtl8224-2xge.dts    |  3 +++
 arch/mips/boot/dts/realtek/rtl930x.dtsi               | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/mips/boot/dts/realtek/cameo-rtl9302c-2x-rtl8224-2xge.dt=
s b/arch/mips/boot/dts/realtek/cameo-rtl9302c-2x-rtl8224-2xge.dts
index 77d2566545f2..a517135446a3 100644
--- a/arch/mips/boot/dts/realtek/cameo-rtl9302c-2x-rtl8224-2xge.dts
+++ b/arch/mips/boot/dts/realtek/cameo-rtl9302c-2x-rtl8224-2xge.dts
@@ -71,3 +71,6 @@ partition@1180000 {
 		};
 	};
 };
+&switch0 {
+	status =3D "okay";
+};
diff --git a/arch/mips/boot/dts/realtek/rtl930x.dtsi b/arch/mips/boot/dts=
/realtek/rtl930x.dtsi
index f271940f82be..cf1b38b6c353 100644
--- a/arch/mips/boot/dts/realtek/rtl930x.dtsi
+++ b/arch/mips/boot/dts/realtek/rtl930x.dtsi
@@ -29,6 +29,17 @@ lx_clk: clock-175mhz {
 		#clock-cells =3D <0>;
 		clock-frequency  =3D <175000000>;
 	};
+
+	switch0: switch@1b000000 {
+		compatible =3D "realtek,rtl9302c-switch", "syscon", "simple-mfd";
+		reg =3D <0x1b000000 0x10000>;
+
+		reboot {
+			compatible =3D "syscon-reboot";
+			offset =3D <0x0c>;
+			value =3D <0x01>;
+		};
+	};
 };
=20
 &soc {
--=20
2.46.0


