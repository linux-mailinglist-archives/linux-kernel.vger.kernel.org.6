Return-Path: <linux-kernel+bounces-328681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA29E97874E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 240F1B262A1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C75126BFE;
	Fri, 13 Sep 2024 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="HDQ+uHTD"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2119.outbound.protection.outlook.com [40.107.236.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3270C86131;
	Fri, 13 Sep 2024 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250216; cv=fail; b=gHVkcCOyhddBeDykW7xKt2vxGNdQXuC3GkJLqz99s74OviXEsuXWki2okB+rc3LoW99ESkB+ecRtZTky4xpYP8vLgXM8F7xxuRev+k3RcWK7GT1u8qQQyjfNw1KK71FsQO401Di4ewRtE0zfkWdW0WOzhNCEsHh186ZYjBeK3Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250216; c=relaxed/simple;
	bh=c/JJu0ph1dIufQIOet6fDRNYfO+NHTdhtwAE6vgDcLo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=j+/sdd1xCtxLZIydEsDsHpoRH95Mv2JTBE+Pr+4AfwQ6VOrziET/QepKNBL4qYwZBDxufv0rkuzaKNw59lqsrBFcd0bByLCxxn+AeOAHodsLi/2d2F+OKHChRrMgpKc2tn++14iSwuFqYhZttmonAtxg9/cFaHki1/APthKHHw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=HDQ+uHTD; arc=fail smtp.client-ip=40.107.236.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=px1lV49vDD+26PS6qHJvs+icSHzwv+Xg3MT5AzqTSfE57wzYaKfMzavkCkp7iyK7LH1jC4mqStc/h9cxOO426D70MgB/4ijgTOqygP+/jftuK1dKdmm+LPoi3P5JY6eUSN2Gj+tnCvMpog5C1h8J4zzdHao+L/gorP0r5+BS7pCzHlSYjG9plvAcB8fiaddt6juIkNZ5FCWNSCtgCqc1dL/zWpME2lV+DQPhc5IAt9ypN219TuYlMqrT92rpBuQSlBR7CZoB9eie2TZGAB0hmzu6Iw99bBTQiJyrdJZQkmYB8GkULciDIN+82EX6w2QTlhKOu/sR0Nvc2v0NWeHwuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gw21nE6vBaYXu4cYgTzzIiW2ZIGBbSIowBe9+W9kfxs=;
 b=Dgt4sDfN6qzivULhAmkZ3qNOXj9TslTcEDQbYH0q1nIkfFQD+R6BYKUCqEszhp3rSPt0Odl/Df467GQ5JgGn2Dwjy1r6txP8eFitzeH/vXua3eSyP90pVvQDlRD8H2v5lrAID8I5I1aSFmGzXWQbpmO2o//VYGxuvQYGMTzdIT+G9resIBxBmDvnJjwjJXebA/YUefEHp4JnWZ9EC6hcezrKI6eIcqsvB5HYGFfdOpXTn9pShNh071UUeB0SdYvMZfrGdfveNpijYNS9790AxGTxoksYBnCbOQInooYNBKZvd9Nc6ep1fpdsN5urN2NSW8BWzpCjszGWID5yndgxNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw21nE6vBaYXu4cYgTzzIiW2ZIGBbSIowBe9+W9kfxs=;
 b=HDQ+uHTDtZ3/9umTH+uTQ/9EvA6dH7bb/NzUsjoOdE5Ox96Ih9FRY2efQO8b6T1PRai64c88K/WFT57dUcJGOHYejYPQhDl3/qD+WBRrCpp/5WoGXFKL7QRi1teiygnCjl4rVvd6ucrA3pfxR12q7whdKR6Zv/gEuKU6e43jaGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by SA6PR22MB5894.namprd22.prod.outlook.com (2603:10b6:806:411::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 17:56:50 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%5]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 17:56:50 +0000
From: Garrett Giordano <ggiordano@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	w.egorov@phytec.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH 0/2] Reconfigure 1.4GHz in AM62 PHYCORE SoM
Date: Fri, 13 Sep 2024 10:56:23 -0700
Message-Id: <20240913175625.3190757-1-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:610:5b::12) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|SA6PR22MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 6271741e-dfd9-4ed1-387c-08dcd41d715f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FNNZ1/E+1v8JcbOfPA4NVuIzQCOy7x5W75MK4Eunp5fMMv+3SX2pVNFoguUI?=
 =?us-ascii?Q?mxzzaaGvDqpe28ADtYdVVetqZBm/QQA1q51KoGh6dsnz2mDHZNRDxNY4CGWd?=
 =?us-ascii?Q?gF51sJawtWjSnPhZCmLSNo8skbQtrDMbYV2Uc5Bd8V1DB2rmKbU2nnY0plPL?=
 =?us-ascii?Q?U+B5UD3DOnzsFAubgc+KuvYE79VcJtSjQjB3Z+0V1P3xOpB1rOEdHYY5zust?=
 =?us-ascii?Q?6/qu7fa12scN/nMG41qIVgiYSjvD8hB/radYh2qjNAwTdEaFxHXXMx0hPEPC?=
 =?us-ascii?Q?Zv1y3AuZm7OZnqztabE/OBIC+iPCZv3Oxb5JsjSLn2MB7zynb4cFLZO1sq++?=
 =?us-ascii?Q?LumL3POPFVH1xZg8qfcSgSuNNzfWreFYeet0MSq/DfDkTtgG1cBjMh39hchx?=
 =?us-ascii?Q?p42O4efQ+yK2xF+D/LQS/c0Qc20JhhMoK4yAATZSV4HYsAf3lSHfvEBAKG4X?=
 =?us-ascii?Q?L8rIyk31CfqiAruSU7AhK01FKoX0wfHhg9wHZYqC2FCVAGvIRosH1TdXXcim?=
 =?us-ascii?Q?Ef89Yx8wfoUj4g0SY3WYFhFEFWnOLv3Y6rdenZp4h+fvHHO184d3m4l7EB6T?=
 =?us-ascii?Q?8niQLVPNG8q0C++5qzpyGL4sKxUqJyh9vqPefh7g+E9GVMFKokkN40WW0MP6?=
 =?us-ascii?Q?QiVXKC+5ZRDhp6pcTOy5Hgd+J/5wImoUXJXpYFa4bz4ef0Hk/T7l1ZNswBzt?=
 =?us-ascii?Q?/T5VXK5tasuN+FquVyTACQiJ7s7HWn9ly6s1RMxgvp1RaaPzBauWZaiS2hAy?=
 =?us-ascii?Q?wq+yRouoShZUDrvCqI71Pv05Vw/j2BHMvs6l5Cqc/y4QskYYW4pVDRCqF4BY?=
 =?us-ascii?Q?GpI7HXGRCpVEQ5okDjUKq4U57tARrbhCht77pCGK7ztpRjDDhsH8eRBbUTvz?=
 =?us-ascii?Q?orMoKZ6uk3x+DhT/7DrOnIQGgEr59ml86wWT4z04qdTT3aXJ8Lj/d8D2Ad8M?=
 =?us-ascii?Q?kSldPyq8FobZ1p95eSRt7TI/8joEI7uHMdblxv0cnCXSvqT0uNTTmIgNdx4x?=
 =?us-ascii?Q?Ja2RMXn7aCvn+6o3clCLsj8K1gHtwyHtvuFw0tPIPQtCCLXQwHsgYm03dHaq?=
 =?us-ascii?Q?D1L/7ov+6qe1e8kY7ZitVnmO6NANnpv1KK1mkufGF3G62XCOgt7ukCTR4neT?=
 =?us-ascii?Q?/PhcUzI2A/bstFmoAfxOYA7UGCOBlqhVJCDMfXT4fqmb9Scu2N+TEHF9p/Xu?=
 =?us-ascii?Q?Zyi7iWxDa3F/1oDVyEjlqMgKHckkzIH82ocJOUv1GTzkHuEJBFGa1ek8swsU?=
 =?us-ascii?Q?qZFydHKQaKIJp8+jDySkIFz0uruO+OkKplcEWlZbEyZiHZvJnFTfaHT3aUcP?=
 =?us-ascii?Q?oMTwUI2+gLaJ85u9F8r0Q/i39pnDIfLj3XeZOy3iFFL8B19K0om+QnBhoXl2?=
 =?us-ascii?Q?ek5nQ9Ksc9r97su8tQ18AtvXnSFSq2Yv+IQ6Pvg+9UrpsqQS9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4354.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XVBYfQPPbT9yYx2zbfEFhaXCAdg1e+CvWheD4Uzg5RlCbHg01pG8FIZfvZPs?=
 =?us-ascii?Q?oMckKaIUCJ4oGzNy2h71LsUxnTraF7P96ExSFjkjxsZXyKLXEgDlaKqnXKcI?=
 =?us-ascii?Q?/0axPOPUBwty4k/U4fuGsJBIOTIblpQ1TrfvP3zQL7O3xnHjVazYM68vORUt?=
 =?us-ascii?Q?l285Vw0onr+Xhg6tVazM6pWfSw5MQosRIxfsyYsI3dr2KxGqVCmt9uO2gY0C?=
 =?us-ascii?Q?6JrWVT+0FFQJWjLwax2duDiySht/AMQqZv//g+VgVo67nw6NDtAemtBKniIA?=
 =?us-ascii?Q?vp79igqZtkkO2dHVtcd0cheXucELofOAqwT9vIUq4yf+CRZCQ3QHvUGUNgiy?=
 =?us-ascii?Q?B/SY93Eq+agcGcRmSOgGDNp0TBa2dMbNQkZAhgPz0ruCviOiPANF+QaDIf7Y?=
 =?us-ascii?Q?jrgH4nPZmkJGyT0A6ELXjYpjitAos6mvp1xN+cLszNH6rAIjeuj3bru2FA10?=
 =?us-ascii?Q?i1NTZiEnWR9k3y8RGcezc4UlL+jt4oPfxLN1zbrD9SREIzMMT6sqthsPflXU?=
 =?us-ascii?Q?4QT3K5n6+70pV1YTYLHVP0u2vJaSZ/Ww64LhX0kQ4FtOxpnAAX397XOwQDdP?=
 =?us-ascii?Q?rKC42d6LM5NylUqtXzOphWTlUikp+dcE68UAE/ctRSL1FQIqYzh8eD2QQSHe?=
 =?us-ascii?Q?MCDgJzC6rKnI9Ii1eX55dErr7cjC//fZDBXVuJYu1xksrq8Sn1ZRJFsr/JXZ?=
 =?us-ascii?Q?lin7E5ITHbIXZm0oRwzCyIFstnQymNXDYPJPlIOm/lcQK8cX7yc36E5RzdPa?=
 =?us-ascii?Q?fDrRdoZ6AEmQZKpooETbnx77HfKliMuwLd5rmMA6jOE2JwbEz2jIBmn7miB5?=
 =?us-ascii?Q?QL2R+AZHnsNIwsols9Gf/6vSIf99YVnzzA7QF0ZNEE4lSpODzd3bwkHlu0e7?=
 =?us-ascii?Q?DsljSi4VnzrHpwQ6mmVCItwKyJmw592d2ftV9eW+g/ILXDNCd3H2/HJfxsTj?=
 =?us-ascii?Q?HAlua+RbiAU++kxDAKQtrEhuydjJiLoeufn5war3RT5o+o0hYr2YgVLt7Vhg?=
 =?us-ascii?Q?M4Jer3iIZy9zAu4b/fLNxx8b8HzksZFnvtzqG8uw5SMN/hCP4W4H9IwIRYKV?=
 =?us-ascii?Q?Am60YuBuNr55d/0CCamJjiDcZAGPvvWMOotZCJZHlo2V1wdDppqR0/zLeUPO?=
 =?us-ascii?Q?f+k1vZqd3fA2mNrcmTRu1+XIwKG317dzYbh5MkK2Bd1KLQayPiehInVKgGBY?=
 =?us-ascii?Q?5c9HnG3NyjF0nuu9kxKctcvVkQCmPMWtdl/nmiZAEcCUzJ7W6kDQYHScBClJ?=
 =?us-ascii?Q?8fCnpcvhp5nJLZfxE4W+8fbKC0h4LI39mCOylD4fCvxaHveThMVTzmyBSfVx?=
 =?us-ascii?Q?aUleRsC36Qm1CiXM7Y59o6VmC4F/4jNJwLxWNQdUf5Urj5jX/x1b3TYauAKu?=
 =?us-ascii?Q?QZHgwzUQRwusZK2ajeafERzHI/QjLnUA1rhuLB/1+GJ9pF8rNZ9ISIE42IH5?=
 =?us-ascii?Q?uQQ7GaLSyOdO14HqXQ4T6hHSH6lSFcjaGZk4e0LRM0FuFGcrcb46Gd7z3aeq?=
 =?us-ascii?Q?TD7GoYx4y/OslY3y27VAfDkab/i6PbtKBDVWFaVv5tA8E1dGEk4rh6ZTroIr?=
 =?us-ascii?Q?3HThFUWxfVVttYdfn1p/+FVrA7dQh5xDaRV/xKCv?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6271741e-dfd9-4ed1-387c-08dcd41d715f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 17:56:50.3240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6iTpxCthEabtutAhO8n/N3Yv1OzKIO1bIFaQa4BvduzLmuSRndtYNv6+8PSorUh1yCDg0lEmRlA79z4kqKFTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR22MB5894

This patch set moves our 1.4GHz opp table definition out of our overlay
and into our som dtsi. This change goes along with our updated PMIC, which
is now configured to output 0.85v by default.

We drop the overlay as it is no longer needed.

Garrett Giordano (2):
  arm64: dts: ti: am62-phycore-som: Increase cpu frequency to 1.4 GHz
  arm64: dts: ti: Remove k3-am625-phyboard-lyra-1-4-ghz-opp overlay

 .../boot/dts/ti/k3-am62-phycore-som.dtsi      | 11 ++++++++--
 .../k3-am625-phyboard-lyra-1-4-ghz-opp.dtso   | 20 -------------------
 2 files changed, 9 insertions(+), 22 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtso

--
2.25.1


