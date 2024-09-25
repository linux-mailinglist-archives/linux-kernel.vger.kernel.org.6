Return-Path: <linux-kernel+bounces-338375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAEC98570A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 12:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F28F1C22A49
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BDD13A884;
	Wed, 25 Sep 2024 10:15:55 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2096.outbound.protection.partner.outlook.cn [139.219.146.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B1F3F9D5
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727259354; cv=fail; b=HpaChlxty2oD8xw7K3br3bON5g44FgCanGDZ1GMgRqEkmQIL3Lvq1ERprPQk+6xbtyWRIhlmKq61auu1ybqLL5beiy8Erdm7243D7wDEjzSPIr83sNBmvek8BFbil3d47jezgoaDDxjTrjEms0Z4PQjkFY8r9Ei2jV2RvHjd7Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727259354; c=relaxed/simple;
	bh=/s8+s8t3ZveAC6QzUwgVNJnlJTa3ZKkicvsXElOk/Yg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mC2g4w/Jrfa4KyEIbef+/ToLSJrMsA4dZl59Pj7Ce+fCiKDSLrAm5dBEXmpq+6fMizDp2q0mSIxSQsfzaO/WrJz6XOPed/VCtPNOjRX3M2SvD2qKBokm8O2ygdD48+4Pu+6ZWNmEaPt8r6CeNRnVltEX3D6YKvn7SAQHYH2cYMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9v5yGUWpdHIJ14Txat5kf5hV66E7EUOR+UDPwAV2DU9nnXkp84JVdMxz48ejCpNH8H0RcsbzqoltXAwWeSQTz2twoV4+vJifququNSwcui/vZh6HywEPYfeki7Q2SlvFRzXZw5FvUo6lzMayEcsFEcDNFWvfEQBGPnmPCMkMAiAZjOVB0G5HA1JbqzXCUn4w+Xkts0VyU1pk/mIbg1HYCYNhk+A6zjAusysVdIax1+YBmHkOLeJ2e1Zu2M//4PWAYjKa+bzs6Zm1KcbrBo9+fHBDqS2jp3FOKI1CyeYqDK0LOUSh9b15b3x3lp8yUc3qkg2pcB7fCeWDVyHuGpCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q78oL9QIhd/pRsG9o9xqABuE2HSWpPyCeXmQlHsZFIE=;
 b=etey/3pwJwWtvD9AfZ0kybuJR05Vvk5cbFNWF4kEJ46gmlOoXRMxHmL2JFVb1+eRos8/+oUG4VmZaUcvJBAygNQHebS9Y67XSNpVYJygy9dqnP/81td/LK69eRDgCyTW6scUWpKHXFGX8XRqZ7DaIxvLvk0B+jCQUhcFMEDEFMsN2vkm8ZMS7PybdPuAUzrzH282xKhVH3BV6GnjSonQtVUT3N/P3kSY0XDZ7UwrOUP6T9UiJXzNgZC9xRCljtSyEMTggU7WTlupM004w372QVvnb+I4eZYa127QW8HaPWRJ+xK3Il3TaLk0EYQE/Su6zQ81zoRi2Lv1rIAeJ1Wl/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB0984.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 25 Sep
 2024 09:59:36 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::64c5:50d8:4f2c:59aa]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::64c5:50d8:4f2c:59aa%5])
 with mapi id 15.20.7962.029; Wed, 25 Sep 2024 09:59:36 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Hal Feng <hal.feng@starfivetech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2] reset: starfive: jh71x0: Fix accessing the empty member on JH7110 SoC
Date: Wed, 25 Sep 2024 02:59:29 -0700
Message-Id: <20240925095929.1729726-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0065.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::32) To ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB0984:EE_
X-MS-Office365-Filtering-Correlation-Id: ecaf5aae-9720-4c78-78d0-08dcdd48c33f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	E/7/fWJ0uMS/SJwu+OJ6gXoGWMwfoW8iM0esI6VO+veKGAcNGnFiAWrH7XtQ2UapYjLzisMIly5hexmYdnuvgA2wR19j3plMbSl2+UdqQW7tmZvUqzaDOO3UYZUxAj//FDA1/Jeyz0W0WKbS7e1DvI5iM2xMdqNL5h6/7LBHKeigAx1PLluQ9JGtYSH/nj9WHRTBl/Dy6vJUevY9jqGwLVn9nqI69pM4itBrBBS0HeNNHWtLjizbW7iXrYKQmVAOcnPxkWsLkEYKtxgm0YHg3oTXDekmvwKx1VZzr1U+e9MDp4EA5Pzb084bomDeeIkzjEJ5htnihkstpmtvsWLfpjLF6dWvanKTu2lPDJgUX84tDzf/mGg/u9ZkvGGgf9p9H87IbECj3ctBBaQ+hj3ZOATCml5MBfNBM+RU+pWCexBPCElCDUdXJwGx1RJEWHlRoG/z0f0fCmDgdVy/i0ixG6iBMfukfondDvNJ3Ug01DiCby8EW/noVuKqqh8jQW3TThSiZVtZW975uzEZ6/8eM0zXuPbYjgydOWn0xsXwnCdmcQ4yETBaAauNc6BJP9piTY51Tpyol8sypdJlqs9OFXzuzLGeiOS9RnmZDR+fVCA6FSC5IRTeAwOjwmIA+ekJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a3vbSxAvuL5yKVuGFbIlh/KrHmM0kKiOQ3VxXtL3jqvhZXqqILu3A3EslaIs?=
 =?us-ascii?Q?opalVWrNDAD6D6K9Y+fQ62fAmywgM61Ho2FEK1rOKJIsX+zdVPTkQLmzhJQd?=
 =?us-ascii?Q?STJzSXHileB1kHZ3yR2P7g1H5ToGNDemTmfE3fPWKmh1kWJn0owJKoXs1m0p?=
 =?us-ascii?Q?wgd1zsN7449OnencVdo0+R5wK4qkTc4IIx/nfnu+w5zLJBH20KOFEPZpob0r?=
 =?us-ascii?Q?vpo92BKvBzEfVsYMkwdMn9/L46xt9YNndo4UGCnPGEghdKKumee0xsOcnmjX?=
 =?us-ascii?Q?2G4u4j8Wkwo+2VOmRLW4xTJ1YdE14sme7fkmQH2bakg3kVgVLD/FeZbp0UH9?=
 =?us-ascii?Q?Y4oloHEOKAIEAvHLBt7YOxnsHQcnmu20E8ARsIrGIkVOwAw1enDs69XumpW2?=
 =?us-ascii?Q?aXsi7dW5YzZfe8UR9r/wL7zFRg9rUu48dJL/HN9nIudUOSI4l61poE0geP3S?=
 =?us-ascii?Q?agnWCHJsNX+mg2yC04o8Hj06kDYuAcRmGbngL7IqBezUQY0QjSDg0u2PXC+V?=
 =?us-ascii?Q?A44nLSvvvWcWBnR42qjDKcBTeNLzJpMGL5Nbb+JA1UM6vpVdTi/naUamVGW8?=
 =?us-ascii?Q?5YTu/AJXM+x+f3+2dlH/RxV+VRph4LN8FI/I725SXN0LPDa9lTHoTn8nwll7?=
 =?us-ascii?Q?UP+rmkkHMFcOFhX6/3hx1mTsVoAcB/jMcOqHUPQcX6XGoCcJHj2FrbBEg2Ru?=
 =?us-ascii?Q?oJ8MAwWlb5lhAmvtJ/cn+LdDGHVk28G6RJxI5XZaP9GW1EHDSYG5yeh0ryRE?=
 =?us-ascii?Q?A3kQpdAQtQwi4UcxwBHev76OPbXGTLL9i6PALP09h6Za+UxNgklcAw+oAdxi?=
 =?us-ascii?Q?kvrAcN/T1PstgVJFpPpRNE8oAVOCsXGmZw66Oe6FuQ0QZ2zDTqPtvLuEibGV?=
 =?us-ascii?Q?672qYm/btwNFiR47d2knCb3G0pLNaJY5e5T28BiWpN+PCldpKnrP0/ffJVuf?=
 =?us-ascii?Q?Ahdj8AaSD1PMFbLagNgsP30pV3C3GQEm8joht5T6XmHHC21KFnCt8nQuq8Rt?=
 =?us-ascii?Q?2rPFW0Z0Y7f1U+Og2jljKm0j9cbtk8sfSHO6HD3xJVTTwIHBwd+RiTzZGRaK?=
 =?us-ascii?Q?qb2b5P6+qQ3oV9eUxo9Vjbq1nhhJ2bESK8k1/kI8FVQBQK9oQvZWQBc/fUuC?=
 =?us-ascii?Q?XltewBl6r3pewxCDBmHSxlPl1wCrYr8pMVI4GxbqMH5nhmHs4xOXXmbtpj6j?=
 =?us-ascii?Q?jNWDx2jP4/zBRUHoxVvVwI1/CC2xiDj+f9buuANZPfkMiMUhbJkh60un5Ec9?=
 =?us-ascii?Q?7mZ1sgkYFGtz46Qfm4pbrl46GJ/SB+JDkaJdmRhaSaPkE+xsC0hb45HCn8Hw?=
 =?us-ascii?Q?2LInDouMHxuNEY9GCyJ6zzBKWWOO7n14QMsbDVe7arb5VTICkI4iOLAqy347?=
 =?us-ascii?Q?kkN9dEJ7rb0VtgDY9nKkH+qVS43sJNWCG+eij5kxK05JnlNt1oqoGRrn2D0a?=
 =?us-ascii?Q?QvsIrZdXsIIchfBBQrORZ6ZE5NfF9dmRfeMS0/y3NaYlO22801NTu803vTla?=
 =?us-ascii?Q?JXLcYvFEl6bkzG3xX4Vy92piOpsexDBxLzMsZbZUy3t0g2yVkxJIpBQ+BoRg?=
 =?us-ascii?Q?FpFFLBe2z/GgBCH3g9BYUDFRL1KE0nayoXqe5ilQQihgQH6UW2YLdD5jiqkL?=
 =?us-ascii?Q?41G/iImAbBTlR/QIhfoVSz4=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecaf5aae-9720-4c78-78d0-08dcdd48c33f
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 09:59:36.4062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJ8E+tdT0DdCmledMGttd5NdPmZ4kUeNyYT2abIA2npNngzPdODjR7Nu0Y1bqH/7qR3zVs4WJhSjwxTOi+MNA5qrzglu52qE9Zeifa6YBbuMvLHugdX3M+ivoFbGBa45
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB0984

data->asserted will be NULL on JH7110 SoC since commit 82327b127d41
("reset: starfive: Add StarFive JH7110 reset driver") was added. Add
the judgment condition to avoid errors when calling reset_control_status
on JH7110 SoC.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Acked-by: Hal Feng <hal.feng@starfivetech.com>
---

v2: Improve commit message

 drivers/reset/starfive/reset-starfive-jh71x0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.c b/drivers/reset/starfive/reset-starfive-jh71x0.c
index 55bbbd2de52c..29ce3486752f 100644
--- a/drivers/reset/starfive/reset-starfive-jh71x0.c
+++ b/drivers/reset/starfive/reset-starfive-jh71x0.c
@@ -94,6 +94,9 @@ static int jh71x0_reset_status(struct reset_controller_dev *rcdev,
 	void __iomem *reg_status = data->status + offset * sizeof(u32);
 	u32 value = readl(reg_status);

+	if (!data->asserted)
+		return !(value & mask);
+
 	return !((value ^ data->asserted[offset]) & mask);
 }

--
2.25.1

