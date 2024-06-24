Return-Path: <linux-kernel+bounces-226526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52EA913FB9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 03:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A6D1C211DF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 01:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3655823C9;
	Mon, 24 Jun 2024 01:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="SDN1Vzyf"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63DF79CF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719192194; cv=none; b=DRLNIDfVtEzkfKRqjN2hP12y53egroBNtifcz042KeQJ05QTX1vD8OrL/ldazhAGkTFZ23+ZRVtVlOtIJl8TJuh+mImBET9Y6DhU5n5KkiaaVZ2NZmahyeXVyvaI5QPv++YXR2Bl3HJ9S6gyTl34zSh6dHKYx+ZlqA5OCNTdev0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719192194; c=relaxed/simple;
	bh=qQR/McBQUictKN6FDFcmG2wHXZ9K5U/5SuRHpnHk9NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bn7P7B/f04qcV2gzewz/XQUezCzCeA+4NDJdco/q1aLmBcfPItBjfJxx/FUsgVSG4i9TdTYqt6pL9walp+cYoUBqQjP7K5ULdQjsuEPV+D2nXQ2O6GAoGpPoDn73P/FrNBX0lw3euLjmUYxLihCipfgAc8UzyRE0UrSvncryHks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=SDN1Vzyf; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 80BE32C047F;
	Mon, 24 Jun 2024 13:23:09 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1719192189;
	bh=VqDnsxa9IRPhUHF/UMDGZUqazd5Q4It/crg+iHCE85s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SDN1Vzyfsvi2AyeKKnr5/FDmOxDAzO/7Wh+j8Z0OLN0JlTLXBYgoKklG4w2U4AYTk
	 0Atex0CSHf4+9kkeLdZkSfcmy5fzrM37FKGQyvBhPDUcz2wwE5IYx5uoW2JCOaCEUi
	 E8dSg1S3K1L2GLUWcSEOKR9pY0gzwx+xMbrfjr+A14jwtt1mRu6XNrIq7yU123GjG1
	 VZsoCRQnPaFRqQM9eKJ4vlldRveuoshmxCnmcShccYUAoWM2mOijZb7zhv9BdtHipO
	 tavwCLQWPiH/xzeqZzA5A+sp1UbYUi36OVFntEY2dHjIvFzXrnwuuvvx4991UdSvka
	 1xNadL4s5Jqhg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6678ca7d0002>; Mon, 24 Jun 2024 13:23:09 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 359C413EE84;
	Mon, 24 Jun 2024 13:23:09 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 2F2BC28058C; Mon, 24 Jun 2024 13:23:09 +1200 (NZST)
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
Subject: [PATCH v2 2/8] mips: dts: realtek: add device_type property to cpu node
Date: Mon, 24 Jun 2024 13:22:54 +1200
Message-ID: <20240624012300.1713290-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624012300.1713290-1-chris.packham@alliedtelesis.co.nz>
References: <20240624012300.1713290-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CvQccW4D c=1 sm=1 tr=0 ts=6678ca7d a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=T1WGqf2p2xoA:10 a=WrkMwgpS-tb6rWOXYdcA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add device_type =3D "cpu" to the cpu node for the rtl838x SoC. This
resolves the following dtbs_check complaint:

 cpus: cpu@0: 'cache-level' is a required property

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - New

 arch/mips/boot/dts/realtek/rtl838x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/boot/dts/realtek/rtl838x.dtsi b/arch/mips/boot/dts=
/realtek/rtl838x.dtsi
index 6cc4ff5c0d19..722106e39194 100644
--- a/arch/mips/boot/dts/realtek/rtl838x.dtsi
+++ b/arch/mips/boot/dts/realtek/rtl838x.dtsi
@@ -6,6 +6,7 @@ cpus {
 		#size-cells =3D <0>;
=20
 		cpu@0 {
+			device_type =3D "cpu";
 			compatible =3D "mips,mips4KEc";
 			reg =3D <0>;
 			clocks =3D <&baseclk 0>;
--=20
2.45.2


