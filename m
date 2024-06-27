Return-Path: <linux-kernel+bounces-231799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05237919E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 06:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D8A1C232AB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 04:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6687421350;
	Thu, 27 Jun 2024 04:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="NfHzEWzM"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58BE18E28
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 04:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719462808; cv=none; b=F4A+jm3ptr790FG2cFwr7h3kvOLngktYCtrlJS4KUqRVB4QI1GgJRp+D1hkkzlDL+Dvk1qrcs0xNZ2InfCSj5zXMq1GCQmE+An+kzNs0+3n8q71VL1i5b0uPvaXK/YKMp6FACfV6Wi9ww5wDMeD8vHYQ29h+Ubji3tDg953bE5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719462808; c=relaxed/simple;
	bh=PK2W04ll2hb3v5bvKi3h167n4UeVm/19716wzgjOpak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKuxFENcErKj2MofRxY9CFw03nbH2K0CPfrtaAdWX6Ftoju1tZwhKFHlhUgz14/VLtbzZob79sR6eHopZTkw7Tw5Ru8n/0gS8x2WWqrRLEGIpqC7/bEliz1hotE8fmJmhSe5vO5LMBCuZvZWj1m4GpF7pgmO7DSZQ/3AN6rj/fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=NfHzEWzM; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 605282C02A7;
	Thu, 27 Jun 2024 16:33:22 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1719462802;
	bh=7RK4VpqVUUaL3B9RJ09rDSqQRUnNry1hz3tgFTTAcV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NfHzEWzMcvbtHvB91GsZFZE4xO57zW+q1kunlNxC8DyG49j09RZf6kCSbQUdEUvm1
	 uybd+Yn3guMX9AR5F3w9lroaS8PL1cvuPpfZ3SbR+6hEHcqr7DAHfafbRyoBvZ92P1
	 4qBZ46ev7d/z8Rz6349eTbFnwJn2vGxlR1aiKk2t+vCL6ywttb8KizX2bs/JtVgeYj
	 7n8Hs6u+lL95BUJy0uQ9W3zPcxqfgi8Pk7IhvFdYlFWIVf9TE0/FmA0cJmAe83rk6H
	 nrQFP17T50j0pJO9LKjav5qjodY/qwnu6AfCNMlfdhHyDddVrcaF9n5cgiDh+dFHsx
	 w84gXoeCMN2/w==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B667ceb910001>; Thu, 27 Jun 2024 16:33:21 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id E1D1313EE6D;
	Thu, 27 Jun 2024 16:33:21 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id DD06E280499; Thu, 27 Jun 2024 16:33:21 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: tglx@linutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	tsbogend@alpha.franken.de,
	daniel.lezcano@linaro.org,
	paulburton@kernel.org,
	peterz@infradead.org,
	mail@birger-koblitz.de,
	bert@biot.com,
	john@phrozen.org,
	sander@svanheule.net
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	kabel@kernel.org,
	ericwouds@gmail.com,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 1/9] mips: dts: realtek: use "serial" instead of "uart" in node name
Date: Thu, 27 Jun 2024 16:33:09 +1200
Message-ID: <20240627043317.3751996-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627043317.3751996-1-chris.packham@alliedtelesis.co.nz>
References: <20240627043317.3751996-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CvQccW4D c=1 sm=1 tr=0 ts=667ceb91 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=T1WGqf2p2xoA:10 a=fO4XG2tHwy1-jxZR0dsA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Update the node name for the UARTs to resolve the following dtbs_check
complaints:

  uart@2000: $nodename:0: 'uart@2000' does not match '^serial(@.*)?$'
  uart@2100: $nodename:0: 'uart@2100' does not match '^serial(@.*)?$'

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - New

 arch/mips/boot/dts/realtek/rtl83xx.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/realtek/rtl83xx.dtsi b/arch/mips/boot/dts=
/realtek/rtl83xx.dtsi
index de65a111b626..03ddc61f7c9e 100644
--- a/arch/mips/boot/dts/realtek/rtl83xx.dtsi
+++ b/arch/mips/boot/dts/realtek/rtl83xx.dtsi
@@ -22,7 +22,7 @@ soc: soc {
 		#size-cells =3D <1>;
 		ranges =3D <0x0 0x18000000 0x10000>;
=20
-		uart0: uart@2000 {
+		uart0: serial@2000 {
 			compatible =3D "ns16550a";
 			reg =3D <0x2000 0x100>;
=20
@@ -39,7 +39,7 @@ uart0: uart@2000 {
 			status =3D "disabled";
 		};
=20
-		uart1: uart@2100 {
+		uart1: serial@2100 {
 			compatible =3D "ns16550a";
 			reg =3D <0x2100 0x100>;
=20
--=20
2.45.2


