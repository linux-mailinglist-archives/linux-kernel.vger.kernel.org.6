Return-Path: <linux-kernel+bounces-199975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1111A8FA8A8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 05:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4DADB25508
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 03:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D6713D62B;
	Tue,  4 Jun 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="0mQwofby"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE61322066
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 03:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717470628; cv=none; b=UJcZqlHRPnqb9KPvT9w2COWLSAVIlayL6yzrusRlUqsPw6HedHxuvmeUdf1Rkm9KZEqxiicpjBWJ7z13qvx2u3im7F/HGCUTBWduI+gTeMUKE6yWhb8ru4PnVsSG5qJuPrwke/eycV4dU75d+PJwskJ+Z3qhjxxigsmTNoKcjrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717470628; c=relaxed/simple;
	bh=r/KulotwnindLZundgEfHdVGhEAYwldtPiohbaSnvcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nEMsx59eHp8HnfCMT2V5JgFEI81++0bKl70CUWKfDXRjC9yDHlEQk3OgRfxBwIqsscbw/GPHITF5w+XkBFbiB50u+0ALymvP73aCo1U6oln60Qgzo7rMUEWVg8udlYC4GcTXKXCOPD/g1TO5UkX/HCmC3Omke7fT+eTXl6R6RUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=0mQwofby; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 42A042C0304;
	Tue,  4 Jun 2024 15:10:22 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1717470622;
	bh=pnm4VvNxff61Xbs7PCXNlnP5w/sI2C5GXRKzsvs5upk=;
	h=From:To:Cc:Subject:Date:From;
	b=0mQwofbyDlXjFvSFo8IKIOVNmtmWIo13N0QwPgW6heK55zxL6uzFRiOVCe7v/dN50
	 GDfnp5mbUxoapQ/oTcdyr53F7JWnBWMq4ioi5LNDUyB6Vn8jFmV7yB8+elZc/T6iOg
	 rQxtpum0U3HblpWaDAqFUyGW0+EiQmXosyeUyp6hSBsv8rbRoJpnS1d+RvcoLX6o2a
	 cRaAJGf3oG4ECnQIw+ZJ+FkKdpYDr0ZhtWTqRmnqsiY1HFBFjY3W0/VbxooibhMxxt
	 j37b8yr2lP24z/XbUwI8oWrpJ4ZuxvWl0AJMX3Pe+gaEVqkjmo9gQy6n0wJnuNfigI
	 HM0XDx1c7M+tA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B665e859e0000>; Tue, 04 Jun 2024 15:10:22 +1200
Received: from jackiej-dl.ws.atlnz.lc (jackiej-dl.ws.atlnz.lc [10.33.25.29])
	by pat.atlnz.lc (Postfix) with ESMTP id 0FD8713EE2B;
	Tue,  4 Jun 2024 15:10:22 +1200 (NZST)
Received: by jackiej-dl.ws.atlnz.lc (Postfix, from userid 1927)
	id 08F1A1C0747; Tue,  4 Jun 2024 15:10:22 +1200 (NZST)
From: jackie.jone@alliedtelesis.co.nz
To: davem@davemloft.net
Cc: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	kuba@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	jackie.jone@alliedtelesis.co.nz
Subject: [PATCH] igb: Add MII write support
Date: Tue,  4 Jun 2024 15:10:20 +1200
Message-ID: <20240604031020.2313175-1-jackie.jone@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F9L0dbhN c=1 sm=1 tr=0 ts=665e859e a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=T1WGqf2p2xoA:10 a=YmqHs4GwyjAq34ObVysA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

From: Jackie Jone <jackie.jone@alliedtelesis.co.nz>

To facilitate running PHY parametric tests, add support for the SIOCSMIIR=
EG
ioctl. This allows a userspace application to write to the PHY registers
to enable the test modes.

Signed-off-by: Jackie Jone <jackie.jone@alliedtelesis.co.nz>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethe=
rnet/intel/igb/igb_main.c
index 03a4da6a1447..7fbfcf01fbf9 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8977,6 +8977,10 @@ static int igb_mii_ioctl(struct net_device *netdev=
, struct ifreq *ifr, int cmd)
 			return -EIO;
 		break;
 	case SIOCSMIIREG:
+		if (igb_write_phy_reg(&adapter->hw, data->reg_num & 0x1F,
+				     data->val_in))
+			return -EIO;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}

