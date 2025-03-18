Return-Path: <linux-kernel+bounces-565563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A69A66ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD40C3BAA40
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CD51DED70;
	Tue, 18 Mar 2025 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="AB5HEiSx"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023124.outbound.protection.outlook.com [40.107.162.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D3916F8F5;
	Tue, 18 Mar 2025 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742280335; cv=fail; b=S+u/PcKqtBg7zRCadMypODDrwZkMPLkjz2sKdjcKJMgEV4OuGsyxA9GrUfCPRdtouHucr4l9fkGVYiuWfnN5ixIXcPIEzgi6V/spi7d1vxNGzSKiznMJ99cP5n1TtN6hVXJP2HHwJeKsENN6IQj5QvDjMfdpOBp1Z/azVkxXMq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742280335; c=relaxed/simple;
	bh=b9mnSIGhzxxBuSpJJmyorBgRx/1XYaZ64sc5HAjwnjE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=BmEde6pxO2YiQVysFv6YLad1sVc3AkWmELPJMycFt4OhsnoGfeD1U65rxkoF5ju9hNX8MWalrD5JSPon90572wCw2KVsR10XtKQ68rYCg924hTNOsell/jzS55tEsV0Mv76J7YgmXj+LIsxyEjYW3qxuP4b/v2dtNQTYKZe3SXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=AB5HEiSx; arc=fail smtp.client-ip=40.107.162.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZhrv9aT6ulwPRywtBiQBmrImoIoB7lHZTBiOuRzoFMdyIi1KULkB8zDbEdX2g8qnwS+ojiwhUHkLBqlj7FER8leWlH/YAhoyRB23BEcNySKPEssp4Axb/85ej6PENHbHBMsutCscMrViSr0Ju/OHFk1/2FXG15LKp3j87txtvN3bebbCPxw+Amf5NbVDRBuib41cr9EOvVSZ3XxU59J+FEhin5oGb7B7o9jL0vqcxxUT52QdsF/qO0H/eXtIfhXVOdRy1k3WCnxMSFkKT8uqg6+UZrymKfSrsMtH+r+3whf/5zShMl8lLMD2icW63SeCNtllhLS3ivJ5dhgYMM8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQlx0onkuf2ROjfJYS6RKpQ09HoLqPXSTMvfB2lDraM=;
 b=swL9hlPuDd+sth0BP7QLmoC2XlHuAd9Ba7WNpeP/51EshLgbZbmJetNfg9pH4F1IPLTCv+LUSjyEvORzPDihaTsTOCzBEwelFDxd02WN9DmqpExwZRZFRx3G3ftjkT5IE30n0kysi4/wipt1dBg5UrygD26zHrg6vvR9vsk8GmTetf3VBhGV82fSdZc24HANIwXhbYOCEAbfDMqmKY8WlQbHA4zqDjgpl0xmolhm+Hqa/GXYvlkO3tK6qT5FzdACWOdgoYXlyAKT4smroJpK1w55GbQBIEJQqnGq1pEAmUWaF2VBkCgfvhMhMs3vPJZ27na5OC13eIA6JYNGE0o7zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQlx0onkuf2ROjfJYS6RKpQ09HoLqPXSTMvfB2lDraM=;
 b=AB5HEiSx5Wdb8509hxfImv/FNCMdPvp0+J7juzHVlE65Gl6RgtXHI51rjqsKdoVfdoaofG/3wu/akNPJxVHe0gYXOCCB4nDzkV1dv9yxLk6/CVjgPqmQxVnq1c+qWeuu2WZfp2KpWlXCbqaMGOqVD8jI120PQJtxkPBroJPVz1YhgdE07TCkOgRuKKgMNh5CvUInbMCnpak1SShF5yU5fB2XkhosMAcGpWvL+7Q4XgAG5jJHh+13qhOD8bUHcbpYZX+HcV1vEQWAjSioCABP3i/4Gq6tyh5tz2qCnddUkLfalkwuEP4rV/KbBN8zSDLIp4wLBCsSnTAtkd36sYcFHg==
Received: from AS8PR04CA0088.eurprd04.prod.outlook.com (2603:10a6:20b:313::33)
 by DU2PR04MB9113.eurprd04.prod.outlook.com (2603:10a6:10:2f4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 06:45:27 +0000
Received: from AM3PEPF0000A791.eurprd04.prod.outlook.com
 (2603:10a6:20b:313:cafe::e4) by AS8PR04CA0088.outlook.office365.com
 (2603:10a6:20b:313::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 06:45:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AM3PEPF0000A791.mail.protection.outlook.com (10.167.16.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 06:45:27 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (104.47.51.237) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 18 Mar 2025 06:45:26 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by VI2PR04MB10167.eurprd04.prod.outlook.com (2603:10a6:800:22c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 06:45:24 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 06:45:23 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-usb@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Piyush Mehta <piyush.mehta@xilinx.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: dwc3: xilinx: Prevent spike in reset signal
Date: Tue, 18 Mar 2025 07:44:52 +0100
Message-ID: <20250318064518.9320-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0009.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::12) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|VI2PR04MB10167:EE_|AM3PEPF0000A791:EE_|DU2PR04MB9113:EE_
X-MS-Office365-Filtering-Correlation-Id: fcde1199-c653-4e12-a579-08dd65e877d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?luWvEvEeJifurCQMEr/FKg/QbOlNes4LfrQXSBPHZU1EwX78qTdRkWMAsy7e?=
 =?us-ascii?Q?cTA2wVv5o/qHNvgdrWi+9BiCMxtDc+PbUerSxjClyIQg0q214URbr+WwGmoJ?=
 =?us-ascii?Q?JeQcnY2s60cfgWgy2vUSD89mLmbX2IwSKK0mqGpsHhHIlwHR9fB7PYvODhp8?=
 =?us-ascii?Q?pZYkGo//Z//8aKVhxQFsZMctF/xCKlnhzRAAuQXVM+PYzMET0rq81WnbGE+U?=
 =?us-ascii?Q?CFwtD0UvcHuwR0WOMAEVzwP4bV4VbTVlsAcHXlg6jip8iQeigW8aAj2Q2dYZ?=
 =?us-ascii?Q?KhJywMdbkvHpoD592LoPjaE1WxpHIECTYkPwY/6Bj18/j3fGm01JcRZoqJjh?=
 =?us-ascii?Q?8Sn6iGzWA+rZUxWwGdorZEQ7WLbL7qnDnikv+hwiZRCtwdz5IU6VpaYvvzCJ?=
 =?us-ascii?Q?gKSVuGME01Tn8YhizM4DGwkET/kuu5UFmBBcaQXwzK7w/8oBXN5QHUzr9e2P?=
 =?us-ascii?Q?gtobOiVdoHee0pVGN7AcGRWM3pncQKJnHwrigVJIC6/0to7TkgCVDvp5yyUV?=
 =?us-ascii?Q?/574IR9sVUObchj5hzxSGcTwZVCAj+FlOaLslNetPMSUph5YMUVzmBltiLxG?=
 =?us-ascii?Q?QoXgrqc5KFUyDpx/ef5hF8iPgasKSzbIjOhinBwh9zVAyDjXRqY42GaW9ZNI?=
 =?us-ascii?Q?VxZBvRYNBhWBQRVs6uBvp6sSMmG7PyDDdxH9o539ZUx1MhF9wvSR5iw/bSpt?=
 =?us-ascii?Q?+J0JgtyJU5Kpmks0ZQ1G2WgSrqrQdIMuyErBKVmmPGVrgYtReU8E9acM7ovN?=
 =?us-ascii?Q?ptJTorHiQbEQtd20lbEnGLMfXAsXfmqlQj4RfEEK4My3G0n6vc5eXZ5FB139?=
 =?us-ascii?Q?vxTGNN3qsvnbOlg5KEIBFcRtnkOTLZ3KJJqsk1O9lZYsMcpuqL4Dkj9vjXBu?=
 =?us-ascii?Q?i1qca/lRGYyWnM3ApyaXtJ2V7tVjaUEZMTMoLb9yFJvQWMStQa0OOBNtKPdv?=
 =?us-ascii?Q?W14qyevQ7OAsHoZlzmjjbCf0Wb9x7I15+I72ryajX4ow+WWlYwvgEGmKqDpf?=
 =?us-ascii?Q?x4TGVK2OdEZFe2w9rsqFQPdMoI755enlDJXfPUKQBBNoOPdUYEv/nB2xvvt4?=
 =?us-ascii?Q?9uMynnkOuvH0i2z3eUHcfq4k7d22CloTOLDQvEkUwjeRKaKxR4sHTYIMJaOn?=
 =?us-ascii?Q?E+AYGmVyb4mzyiZCyPg9lECd/ENag3qq89w5jgFuV1tO1yAZ7SzO4jQD6AIV?=
 =?us-ascii?Q?Wvd16DgTs7J3hSqJCj15ZVKd8+Xx8xzPEsfbXHvY+abUb6F9ONaJwjt6xts/?=
 =?us-ascii?Q?y0y12ME/1oUh3Tv5W2necgNQ0lxGsY64e0wzY/jMglaSoEMy55zXCDUOcOjt?=
 =?us-ascii?Q?ddH4RKGnrjImYhz1xVzgRfjk+F66vkb9atL8pDpeScjmp4gKl6ZtcVgHGd14?=
 =?us-ascii?Q?H8TjAhBXxvpgsSCgBWI4VY+WyU9copbCjratTF0av5Yl7AUECREoV6eMy6Cz?=
 =?us-ascii?Q?wirdTdSbpCMBk67CTw4f8kUjJZthNdg+?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10167
X-CodeTwo-MessageID: 314dd080-ee20-45c1-83ce-0b920499924b.20250318064526@westeu12-emailsignatures-cloud.codetwo.com
References:
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.92a20336-7677-4cd7-9893-b0e0da853ba9@emailsignatures365.codetwo.com>
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	813c9843-e2ec-429f-5c69-08dd65e875af
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|376014|14060799003|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UkvztQqHwYN4WhGeGWrcaEs+fZptkvSbiC3oSaZxQMVY0EMNRwdra/YYGz4K?=
 =?us-ascii?Q?Fm6He3/ayzNUgaN9Wm4uzjk+1Rw79lr28RWNEOcqDzQfroTfB9kvAyRuTtoP?=
 =?us-ascii?Q?e+5UyMgAX7BgmA7ZpKQkLQ3tN8cVEwGtPSNFWenld+bMLMJkYomZiNvg39wh?=
 =?us-ascii?Q?0ifdnZDnYXoFZ7ndpJLP6fadsCdJ5oNGQTh6y0JDIA5mqf5b2OscLTZFTCZX?=
 =?us-ascii?Q?+Nzf8SpOR4SgrqJ7eanYyECVNHwb+MbxInI1D0+BhTMoBpbIWjtf7faU3P+s?=
 =?us-ascii?Q?+RYhdDzE2yhlmIi+dcxBcIrb+Do8/TZ8UA3eURCSquuP40VF14uQGnqPI2PN?=
 =?us-ascii?Q?QxhgQY5fT5noOK4783XOFkfSA7hVQBUbL9W4GDwvX6E2/jYq6VBytKmEHfG+?=
 =?us-ascii?Q?Frr+7Du/O+Sf/tp7hUKgOIlOw2p12UlD/YRb24C/QLIeDW/OaWGIAztKIzmC?=
 =?us-ascii?Q?1Xvbm3B1o8tt0zxG8tUXfITiHizJJzGVN7TC9cEPGs6zW6HPNqzkwD+Fxk3E?=
 =?us-ascii?Q?dgJnc36r5vOiDyVXoEIRju8XN//p1lIplu/tlriO6ueRMr3vNOj5t+PhIWlc?=
 =?us-ascii?Q?eRRYQEvvG7YIuAVI2XJj29cXEpVtLVJMCkRMmj2Xwf8XiG+e7ebSuAcVrRtz?=
 =?us-ascii?Q?SfnOr/qB4H0C0OtFUt6FBOOGS8+ljfqNC05BbIJzHZDvFCch0luU+tG9w+ep?=
 =?us-ascii?Q?430Fd6+x3w7S1vPEzEocODF/6Hp4kHDYlL0DPneanrfBxoN58RAATwbO5OWy?=
 =?us-ascii?Q?klIn1K4WWx3A39NPZFyvcahh47RTKP3jllxJdDRsrqxLJe5exjrVyhJov6Zi?=
 =?us-ascii?Q?uBMBrfG1UreoA8WiZYwfrtOAc/TaEkYwTHqRscjHIrRJZaE9PADr+7et3L3H?=
 =?us-ascii?Q?9CzyNZaor+xqtdQ/ES4CNg7eZc6oNhHein/kd2+VaPvTV5HRJI/Qg+yg9FY4?=
 =?us-ascii?Q?b14P5IBxINVUCY/RlYuyfe0bDyHqPky4ZB25LhXQaHhiYhzrXXLzde4MtexV?=
 =?us-ascii?Q?He7w0Sdso3Qd0YvBuwm3sbRnSComMaSVfr5sB+wJn9RMVkVfJOWQjll9k2JZ?=
 =?us-ascii?Q?JaYvxhAV+88nZHIbMmxVBSEYS9P3ICBeBMxByRagVqRi7p53Xu7S3qVW7+w7?=
 =?us-ascii?Q?m4EBsGVMoe/yr8lQNFPoKr6TSlwjDHKDXu739SzRh81/6/zixHe9wn4Ks6Se?=
 =?us-ascii?Q?FFQwm5MGa5NBbJwE0hwdsrRooyCw9s+zNfrVM8P2Rjy6tFF84dxp5T56EKvU?=
 =?us-ascii?Q?9FbXEvu7L9Y4VN+aJ8Dg5aH2ErWQ0G3B5pLYIZjtbXxKqQ5e9flaWZueX/hq?=
 =?us-ascii?Q?y7lH9ov+AJS91EPqD6P+6OMqjM7HDwoHazfWPAVJ2x3flkkz9UrTeo9c9JA0?=
 =?us-ascii?Q?P4jp30JwMw0I0TllwMm7dVuKeft/kI+MfBPNoCUYBtEk8DEy+uoimqVTJQQ0?=
 =?us-ascii?Q?w185m1wzQ5k=3D?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(376014)(14060799003)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 06:45:27.3539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcde1199-c653-4e12-a579-08dd65e877d6
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9113

The "reset" GPIO controls the RESET signal to an external, usually
ULPI PHY, chip. The original code path acquires the signal in LOW
state, and then immediately asserts it HIGH again, if the reset
signal defaulted to asserted, there'd be a short "spike" before the
reset.

Here is what happens depending on the pre-existing state of the reset
signal:
Reset (previously asserted):   ~~~|_|~~~~|_______
Reset (previously deasserted): _____|~~~~|_______
                                  ^ ^    ^
                                  A B    C

At point A, the low going transition is because the reset line is
requested using GPIOD_OUT_LOW. If the line is successfully requested,
the first thing we do is set it high _without_ any delay. This is
point B. So, a glitch occurs between A and B.

Requesting the line using GPIOD_OUT_HIGH eliminates the A and B
transitions. Instead we get:

Reset (previously asserted)  : ~~~~~~~~~~|______
Reset (previously deasserted): ____|~~~~~|______
                                   ^     ^
                                   A     C

Where A and C are the points described above in the code. Point B
has been eliminated.

The issue was found during code inspection.

Also remove the cryptic "toggle ulpi .." comment.

Fixes: ca05b38252d7 ("usb: dwc3: xilinx: Add gpio-reset support")
Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

Changes in v2:
Add "Fixes" tag
Remove "toggle ulpi" comment
Extend comment to explain what is happening in detail

 drivers/usb/dwc3/dwc3-xilinx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.=
c
index a33a42ba0249..4ca7f6240d07 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -207,15 +207,13 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *pr=
iv_data)
=20
 skip_usb3_phy:
 	/* ulpi reset via gpio-modepin or gpio-framework driver */
-	reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(reset_gpio)) {
 		return dev_err_probe(dev, PTR_ERR(reset_gpio),
 				     "Failed to request reset GPIO\n");
 	}
=20
 	if (reset_gpio) {
-		/* Toggle ulpi to reset the phy. */
-		gpiod_set_value_cansleep(reset_gpio, 1);
 		usleep_range(5000, 10000);
 		gpiod_set_value_cansleep(reset_gpio, 0);
 		usleep_range(5000, 10000);
--=20
2.43.0


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=

