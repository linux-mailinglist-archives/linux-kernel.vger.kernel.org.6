Return-Path: <linux-kernel+bounces-209288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E67AB903153
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D75F1F27134
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DC8171E54;
	Tue, 11 Jun 2024 05:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="YJraejpu"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57A017167B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 05:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718084072; cv=none; b=SvgvFgPAhjQaCMJ5nNo3tshcqh2UFHzoS7Cm5UD7jAZxDBRVaJZ4cFl1R8YZPFXvy6IjbSdNq5FvflkNJ3Ix9meklMfKnN4TUqdd+tRQSDvXYx3Mk1vgBkRZw9SKncCfkxVs1GRCuJR0Kr5R+EV5hVP/q9ddNrJWGCd45J/Rt8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718084072; c=relaxed/simple;
	bh=FZQLqX5Y2ngBysVwSTRSq5XLf9h7YQTa/154yewSc9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B3Q6nSH5pJVaG7lxlVB2InI3ir9mNwHCpQfVQV3Pk85vI7e/U5gJljDJc0/gMZsoLmIrYkgCA1367IZvT6CwfhJ3b4p6CEkUDDtCMCeqMoEOSWUYcQhtITI9bwOOfZ2Gcgd1IOWm/RPyHtjr6IjhqvBDUg2/14UHecyhUjSUCYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=YJraejpu; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3701D2C018D;
	Tue, 11 Jun 2024 17:34:21 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1718084061;
	bh=HxqIGh5dA/kSfFp32bHkCRuqWPU7CmM14H2oM5pyHUk=;
	h=From:To:Cc:Subject:Date:From;
	b=YJraejpu+/7+5e7H5oN5L1vAUewZBjGA4bEhVyZkUgSFttH2WwoB6ItaNAfDjgidf
	 TaZD7UJ0A6ZvfBq87wkZYkNDKv3AuYLZ6PvvuYhD/Rn8+M1j5ZsVOU0jx3aktS/Emd
	 1E2PUXQLMgh3ET4g/1dP7pnFrF+UhBB8P9SFHY8Su4GakyiWC9a7KFczjt0qeX90Du
	 jhJL2Ebu8ETP5dH8Svlk2Fz3FpVY22/KHGOFhtLx2wcLxap693w3pv6BmPwB08QRq4
	 HRpOMBLgw0BUJdOoztXr+bXX+nW0IaodQ3bCxDounsoSOBtpeXb078tZV5JITYTlqi
	 LMnlCpf2xYwNg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6667e1dc0000>; Tue, 11 Jun 2024 17:34:20 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id D687813EDE9;
	Tue, 11 Jun 2024 17:34:20 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id D08D3280A38; Tue, 11 Jun 2024 17:34:20 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH next-next] net: phy: realtek: add support for rtl8224 2.5Gbps PHY
Date: Tue, 11 Jun 2024 17:34:14 +1200
Message-ID: <20240611053415.2111723-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F9L0dbhN c=1 sm=1 tr=0 ts=6667e1dc a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=T1WGqf2p2xoA:10 a=hXTH84Ue4OLBKuaX9zUA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

The Realtek RTL8224 PHY is a 2.5Gbps capable PHY. It only uses the
clause 45 MDIO interface and can leverage the support that has already
been added for the other 822x PHYs.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    I'm currently testing this on an older kernel because the board I'm
    using has a SOC/DSA switch that has a driver in openwrt for Linux 5.1=
5.
    I have tried to selectively back port the bits I need from the other
    rtl822x work so this should be all that is required for the rtl8224.
   =20
    There's quite a lot that would need forward porting get a working sys=
tem
    against a current kernel so hopefully this is small enough that it ca=
n
    land while I'm trying to figure out how to untangle all the other bit=
s.
   =20
    One thing that may appear lacking is the lack of rate_matching suppor=
t.
    According to the documentation I have know the interface used on the
    RTL8224 is (q)uxsgmii so no rate matching is required. As I'm still
    trying to get things completely working that may change if I get new
    information.

 drivers/net/phy/realtek.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 7ab41f95dae5..2174893c974f 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -1317,6 +1317,14 @@ static struct phy_driver realtek_drvs[] =3D {
 		.resume         =3D rtlgen_resume,
 		.read_page      =3D rtl821x_read_page,
 		.write_page     =3D rtl821x_write_page,
+	}, {
+		PHY_ID_MATCH_EXACT(0x001ccad0),
+		.name		=3D "RTL8224 2.5Gbps PHY",
+		.get_features   =3D rtl822x_c45_get_features,
+		.config_aneg    =3D rtl822x_c45_config_aneg,
+		.read_status    =3D rtl822x_c45_read_status,
+		.suspend        =3D genphy_c45_pma_suspend,
+		.resume         =3D rtlgen_c45_resume,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc961),
 		.name		=3D "RTL8366RB Gigabit Ethernet",
--=20
2.45.2


