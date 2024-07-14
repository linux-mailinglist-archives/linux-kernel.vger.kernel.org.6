Return-Path: <linux-kernel+bounces-251863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD40930ACA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 18:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACBB1C210CE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 16:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACC513B5AD;
	Sun, 14 Jul 2024 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Z72MGWx3"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2187.outbound.protection.outlook.com [40.92.62.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ECA7346C;
	Sun, 14 Jul 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.187
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720974577; cv=fail; b=u4YJ8gy5q4HcG44z2v5I+wip0pBgFCyafoSTMPDzVA28zXVLRQeldoQGPLRekcsIKUgiKRBpt2cDk1EVvLsEvQRPbTKWqlguSVZf5ewrz/0LHyRSwKIpIN1HKqLQMsx77+OMKFY7XoBHY3AyslwV3dDF8NJ1ktEKvbZ8qsyQfzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720974577; c=relaxed/simple;
	bh=p6ZOavmwxUBkGpRvFtz0yfXkrHlI+lk/90+3Aho8BZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VDt8APkCgnE6pYGxmXQxwO1tCWANg/x3xF7Hy8K19ncWAAYzWIxc3VG/mLvalLm1D/8dSH8IU7iZPLffqG96Y87ucf96exLt693eQXbFwh3UxD/d1Crfy43xy2y6PGDLKiKFuwagqKixvER9TrI0al3wuzJOLHIg3wddcgdCj74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Z72MGWx3; arc=fail smtp.client-ip=40.92.62.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnHh2EFMFjarSP4MIhckLLIXqsAUPncp1AlawUH+VP/vV9xpVeld2UI3aJvfw4gFHyXlYYCTPzHiaIiXd8ybhiBTWTgIwcYsZCHqRIfDsY5rCKvkW39Q3gerp8tUvAnF+/iAut2ALCNNQtUVsfdNXo2UnZcWwb6LduuvOsIkwbh15968sVzUalB9aBeBYp+bg/ccJe/0KkQeTcRVjtBUp5HcauDoJdU+TYXWZCDOc6hjZ5pJKH/922W7+1J2Y76LypxeNBh2yKvORQh+bnKQc87/gk1P4ZEz1UjH8mJQtM6Bd6SyuqO1lQif2jhga61/XVl+fATI6OC066nXcQazKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phmv+tQ1eyYFW0OxLr/9rfI6g4c70iqIJjQVYcaU9K8=;
 b=nBkQ5FOJu37Z858OORn6/aYFk9REW2QaqORpgqUMOjTKt/0tOL63BfqPxa/9xroLtZEaI/9BnpwuC0za6c6gMgBkKaBzZ/mdj/AfP/Y/7qKvzuPBRXgvg+uC/pmplDuaamr7BxkSZTcYoQqddqbZkDwJoc46YEhVZCPeFVm7L0lKbf2n3xbM0PIhjft5iDRD5GZitbXjegzW4aWHsVn1JqmtH2sm2WLToWBZz6Fu0k86c/5an+qHu/ErjkfWXRFT9taKz0sqKdv6/2a8ON8Ay4v/vVFX7WjcgV+rgAc4cNmuDf89hto+9SIXwp0v7xAawwO3Lp86SFHauiBwzmwPWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phmv+tQ1eyYFW0OxLr/9rfI6g4c70iqIJjQVYcaU9K8=;
 b=Z72MGWx3+HUj+mMEbomfGfVd2mbjXydXbTJiUp7LUipH4EZbDISRnaRa26xFdZBiwNyrsOOpfT0h5SV7hZud7TP+iuQnMXyCZEQMIDh5voUiVNzymyft+NXWJFziBZ2+QsraP75nc060aEQSdjyrpi5dlQN/gqaI4TokNGIR4FQd4S+Q3pmoJXOGT5OUyzvgNZOU4PAaPH7ndyFtMEg01Hop2NgbPOWfWq9HNbc/8tOMjjwcp49pJajN/B8VvBssJiOzto2QWQf6x1jLEM1H/UdePXbEW64xV05o4pyluXlUdmzs3MGmr46zoyKMoYBi5UF7Wf2fqfg1YTvcdNfGwA==
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:9b::8) by
 MEYP282MB1752.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:bc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.28; Sun, 14 Jul 2024 16:29:29 +0000
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3]) by SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3%4]) with mapi id 15.20.7762.027; Sun, 14 Jul 2024
 16:29:29 +0000
From: Yuntao Dai <d1581209858@live.com>
To: jassisinghbrar@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yuntao Dai <d1581209858@live.com>
Subject: [PATCH v2 0/3] riscv: sophgo: add mailbox support for cv18x SoCs
Date: Mon, 15 Jul 2024 00:28:43 +0800
Message-ID:
 <SYBP282MB223825D5903777B937A8A377C4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-TMN: [WMd+oALftthi6+lw2EBV1i0gMjxbfzTkZgWO5aiMDWM=]
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:9b::8)
X-Microsoft-Original-Message-ID: <20240714162843.9646-1-d1581209858@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB2238:EE_|MEYP282MB1752:EE_
X-MS-Office365-Filtering-Correlation-Id: c8491c91-2bbf-4b64-6eef-08dca4222138
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	wal2kdcyRBG2XVurXZs4IoSDz6m6/oRa7MSylLuJVEWCUNcuFJexvhJ7LE2tFR2rO4/exXrXPG4a4REsIoywbLMhCENs2zq/mHQP2UBEjFJoAamS1o43GtqkUYJzz+VMvmQMEEy4/pHDoHWArUxvfDYlvbzQoCdxG4z5tIESyLoCvtsRBb7xnmD4xXsg+N2G0OqV9zPdZ2uTiAlZDaXMudkg6x0kpFU7P0YY/tN+1o5k+BYdyJVYuOqEnuGDywU55RnmZjTtBLGUsaxk64mjramzUunYZIvCRv/sO0DIm8W0BTHCRbsDEcvMBl4AqgywTFsQiNC056d+x+ULpkXjnGtULPm9xQo+uHXMkL8ueX/fbD49W6o+I/2ZR/bcH7TbHAYV//Xg6wtUWz2Y4LIv1+ybESpni4Qbz4DO3IftMDrGenyWAxuH/8tiGQDA+NhAmO99Fu7aLIyGCpp4nqjm16WMj1XWty2kGvA+sol3GxAsdYnAerudQ5cXQZDq0GscDHPF+WXBeu5esG+4im5QJ7dpHRmDXip3J7DdCDoI2iFB7W4fUpL9QOHl9Tyq3Rf8BCGmVNGNFqIdkZbCUd0dzRxHFSHydT2txLKVHPdWsiNXlVoCr7sFCVxrqi84w3AKhR+d9dwhLLyfhZL+QKuAaLs8itxn9akRSqjiIg7uzrY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AWF0WEKs79H53Z2h9awMzpt5JWDRqkHh5ep5Tzdz8eq64TA+0hiNpWAj7fk5?=
 =?us-ascii?Q?nHBPzpLaII0tGWhy5LTrFIUHjS7f4KkQY50PtH68qqlvUbAGZ3Xh3xHYZjzJ?=
 =?us-ascii?Q?x55O6/LnKtR9vzeHECcc5nfttwb4ysFuhr0WWtM6LPSOM8zIGZU1sQsCVyki?=
 =?us-ascii?Q?AiyMwQTqlJfN2+e3F5EPFyASAGJPjBLpV83esWCYSjad77yjKWEBKMRAUjjm?=
 =?us-ascii?Q?mdGVHeFoPwBTZxtUQeWYkdL8nbTmmPmNs0OMZwTootXo9tuHsRzc0YJPN1CH?=
 =?us-ascii?Q?VL9Rg2+fZGTt5YMspNxU0q0gZYF/qpy6+nt97v2e/5hV0gfKnIYd5NvwrFi7?=
 =?us-ascii?Q?JtSeVQRGidDPwdrFPJoGx6LwxAPK2jx5a9Ean7O6pMWmRuSrywMJKXhSxSvR?=
 =?us-ascii?Q?PvOpHYbO/1LwYK+PVHg229t4IzDf1rxwCZwh+dHRPHOnmjBMpyvYJyF+8i2Z?=
 =?us-ascii?Q?mVNdj+JxS2j7yICqyP4x127LZWo8DliS7CAWGKDMtBvnHBObk3qv4EqRR/8p?=
 =?us-ascii?Q?7Z46JU3lRu6c6EjKPchVJ+u4YOXsxslYJMh0FwNUEU/xcQRfW5/qYMWTz50t?=
 =?us-ascii?Q?0Yq315zxlQmz8uJ3TryrGMVplGJRjV5RPq13hni83WOg1ZQ6Q9JJhnb+Qjzl?=
 =?us-ascii?Q?UuIib/4fQ02AJ9UBV4PWm7BCWufke4YUeMe49b8UrCDSC6IVV/nTVMTx7dwk?=
 =?us-ascii?Q?EbtuDehote5S5UiKIIp7DEzou8qU6ACjVGiIxmKyoEDGz15qYo10jJkSzdTc?=
 =?us-ascii?Q?BwMLl7YaCIutF3xRD718TtiTGRCydxHHKRC60U/g5mVe+SKjndeD8ilIuSml?=
 =?us-ascii?Q?Xr2XhHXnSO/soSQLUudS3E6mhvgS/aDJfJGQSPfiDYE6YNeNObRlBfRZoHPy?=
 =?us-ascii?Q?MYpQc8GHrxsdkWg31mFsRc4UE58te+tP3OzWyQ4Xj53xlC4XaUi/LWkTTwrJ?=
 =?us-ascii?Q?swcJ47VCtU+h9rV6TSQLxxMzNuFWcR5nK0mzCfBRcq0H6XM3GMnEY2887dQh?=
 =?us-ascii?Q?f88V1fMHj93qjWUIARj6r3iAvUPFiVC3ejpSqyhb1MMCXIpW707Sc61+IidA?=
 =?us-ascii?Q?7tcYVOwbAm+UA97u2tLI3cfXgHTpdKfEbV/Q0jaEBTiHnEAtHnio/FWMfi1u?=
 =?us-ascii?Q?HsQM+78q3XVV7deZGHbV72BbqyyTUZDEDG496ZexdezWmAlor8e3En+2ntUi?=
 =?us-ascii?Q?yGXUS/QhDLz3+aB7d3ssU4OqLl5ZgFyeXDaJOchzwf1JkngZvD+T3W5LDVs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-722bc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c8491c91-2bbf-4b64-6eef-08dca4222138
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2024 16:29:27.6644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB1752

Add mailbox support for Sophgo cv18x SoCs, and test on both cv1800b SoC for 
milkv-duo and cv1812h SoC for milkv-duo256m

Changes in v2:
- drop 'recvid' 'sender' in dt-bindings
- fix compatible to 'cv1800-mailbox', and change filenames too
- change #mbox-cell to 2, for <channel tagert_cpu> 
- add struct cv1800_mbox_chan_priv and function cv1800_mbox_xlate to extract 
  informations in mbox devicetree node of mailbox client

Yuntao Dai (3):
  dt-bindings: mailbox: add Sophgo cv18x SoCs mailbox
  riscv: dts: add mailbox for Sophgo cv18x SoCs
  mailbox: sophgo: add mailbox driver for cv18x SoCs

 .../mailbox/sophgo,cv1800-mailbox.yaml        |  61 ++++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        |   9 +
 drivers/mailbox/Kconfig                       |  11 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/cv1800-mailbox.c              | 203 ++++++++++++++++++
 5 files changed, 286 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/sophgo,cv1800-mailbox.yaml
 create mode 100644 drivers/mailbox/cv1800-mailbox.c

-- 
2.17.1


