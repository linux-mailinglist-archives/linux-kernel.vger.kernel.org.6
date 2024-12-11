Return-Path: <linux-kernel+bounces-441694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7679ED2BD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A5E1883B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E6A1DE3B3;
	Wed, 11 Dec 2024 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XFMgLd/L";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XFMgLd/L"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013017.outbound.protection.outlook.com [52.101.67.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149BA1DE3D2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.17
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935876; cv=fail; b=AV0klTfarm0sUkaArEfuhm/A0D7zaJmWoZIbH33x146+hbb8PWekxRgu+11GhsdwzJ0C0zo6O2iK66Zaqbk336h0O0m4RcGQFnb88NuEiEw5bMYMQZpc4bNSm25rL94tv95gvJaf0uJNq3WYC/aXngvtpiyZgNKSU4S5gls5RCA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935876; c=relaxed/simple;
	bh=y+V5tHaB4VCBaWSRjrBGGaReYYahp0XSKHi/1ufhay8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ioDPbfCb+4k7QwXp6itg8/+ZWneokbZBtnQURG7LyMOWR7GiWIFw8cECiI3tk2x1ej9HlLC3Np9OIcLKXl7RN0SGlgG0Gfawr6kteVAE517Nk81e/DIsvy5oRmwYuONGCGYkxpVnw9k0LrmiYVeC91Ke9neRX3hx8UReTYDy2L4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XFMgLd/L; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XFMgLd/L; arc=fail smtp.client-ip=52.101.67.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=FhqKkMA2S4VoizAZ6xcfGMecS997LeWiLD0m1PjByN7nRWPcG9myquOwLZf8rgiNTiSACvQrQiSO9T+k1O74uThH+STXPszz7voOec2quol/GAep0e4QkBejsVeI7YVb1BrMGV5462BDXm9YM90WrDqyYAMjzMp8PbBZYFNNTQJkNX4eafSWe+v0vBtoPoSwcRIfqDX13F0rmudHfjfEDWvRagp+ZQ5ZYyJwKCmQKhDYpXINK0RlivBtz+vmIYOaAo7IchFRuoY2ThK1a+ogVjGz/xcvraEJyR1I6bo3HZsR5YQ9QuuysxIdyNmkxbithpcnxun0cYMBtOQCkPTCkw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaX14YeBrqQ55oL90hZxXWkPfrsjE1oA4+6EggOQyC8=;
 b=Uf+ywg+b5cyczqh/tbS2tpQFbaJytRjCkFS0McD/cns+K8sXy+6I6B8Ihp3haLGJUJpKi+ZmPz+llgv7xLZSU3xSPEM+A7mgHfGz1AJT9jfYU10+yO87WH+/V4k4wAC2PR+3ASQHO4cKgAaB9Dq2v9cwqzfB6sztBL0fTx79W383VdWHzHFII/iBkpGjHsjzFoC2VsykkPhe80bHbgJglDc6GkWyIXntuhg8bkl8E8vd2Kt880gQrHJE8tdrPtucFsT6pv03a+vY+glLm0ayuB6HYKS89pIQ5INd8cta3AmggLRUsWJgkfHdv4EMPDqsP3V20GOsv65I1T7W8gom1Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaX14YeBrqQ55oL90hZxXWkPfrsjE1oA4+6EggOQyC8=;
 b=XFMgLd/Ld6kKWf1W9JZ/+/jL8CKBtab8BGi8xXSmDX9/7P1tKFPXmw+YI6Ickk/Z3910I7iy/3z+Ki6rDC4lsCSd6DHu1Yb8m4yHwfasLjc4qMAzkquwuG/V0bqIdq4VwXC1Dx1TUEBZj9S5JDpKAsNeJkmBSLT/+XFdrgEy5+8=
Received: from AM0PR01CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::22) by DBAPR08MB5607.eurprd08.prod.outlook.com
 (2603:10a6:10:1ae::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 16:51:04 +0000
Received: from AM3PEPF00009B9E.eurprd04.prod.outlook.com
 (2603:10a6:208:10e:cafe::a7) by AM0PR01CA0081.outlook.office365.com
 (2603:10a6:208:10e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.20 via Frontend Transport; Wed,
 11 Dec 2024 16:51:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF00009B9E.mail.protection.outlook.com (10.167.16.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Wed, 11 Dec 2024 16:51:03 +0000
Received: ("Tessian outbound b4c479532664:v524"); Wed, 11 Dec 2024 16:51:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6735a9b1c298019f
X-TessianGatewayMetadata: mPGgXeDGlzWhPLjJz6rDC4d2cvl90ccw1fRBdYPODbBdthwifJsUQpXMkSSYO4HYLdF/lbY/4GIEGWHrxUc/3gfug4OnW+uzaDjU+TrLw0KfWPLN+uvOA9YNDRWg0llQWvD+d5yM+GMFOtr6HAJteQFnZsKOR6MHY8RK4JLxblQ=
X-CR-MTA-TID: 64aa7808
Received: from Lb4d115023e01.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 08B2961B-B90F-474D-810F-F2A149523A9E.1;
	Wed, 11 Dec 2024 16:50:55 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lb4d115023e01.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 11 Dec 2024 16:50:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsGj0TMHKm4PbUpHkC3vRJoagy6AH5peNiF+Htxn3EUrPhTNUAe5dPaFiSquqynr3IRyKTTADr96g6PkpCvirhZgANHKXjQCRrtU9Ni34mognSM4qexcrowSdW64B+DB2wWjeBvP6WuugzoGuncWjiq5O1tbqGvPLS1NpiPJ43RQHAH0cbjmk8lY5S0+4esvETTy7vApIIMJAhrIR2IY6xSuB9ZrLjcdFBcwtvWnzcyFLY7v5KNsbUXGhltIUAALZutTJJCBQ9Z1WSJ3kuy0TB1viVLfGEULE2ViCkBh39PqoMwqDn9djXUT3+iOqZzNp0KkkfR5Xm3whvu5ih8B6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaX14YeBrqQ55oL90hZxXWkPfrsjE1oA4+6EggOQyC8=;
 b=YJ1CHGpx9xf2GBJHz66izkfnNZS/zW94aez85YYiWPlfLx8LmLAepFCzeWe0xVM89IaU4oxcSJGPlweDJGY9jjGztBD/l9vULeKOcrLb8pSTudqe54e8lHjp3vGIN14QxH9FWs57ekprTVNYhFpwOGTuM9kjYo5uGvdrm3guTKya19JF6hcTtHrSBm/yUBNrkROlIxhLAkWN98SAywlaho958uc/KOWALNVdrzmO6Obsd3Cgs0REVP8XEC4kfyNdWH63p16/pBQl21ATcPVoUJ10v64TSdvAVGoi2U2JXJkigjfx0L9PRT0nhxYz4E09rkuC7mpEza4SnR+L+j8YOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaX14YeBrqQ55oL90hZxXWkPfrsjE1oA4+6EggOQyC8=;
 b=XFMgLd/Ld6kKWf1W9JZ/+/jL8CKBtab8BGi8xXSmDX9/7P1tKFPXmw+YI6Ickk/Z3910I7iy/3z+Ki6rDC4lsCSd6DHu1Yb8m4yHwfasLjc4qMAzkquwuG/V0bqIdq4VwXC1Dx1TUEBZj9S5JDpKAsNeJkmBSLT/+XFdrgEy5+8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3317.eurprd08.prod.outlook.com (2603:10a6:209:42::28)
 by DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 16:50:53 +0000
Received: from AM6PR08MB3317.eurprd08.prod.outlook.com
 ([fe80::e42a:494c:6581:1897]) by AM6PR08MB3317.eurprd08.prod.outlook.com
 ([fe80::e42a:494c:6581:1897%7]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 16:50:53 +0000
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Mihail Atanassov <mihail.atanassov@arm.com>,
	nd@arm.com,
	Lukas Zapolskas <lukas.zapolskas@arm.com>
Subject: [RFC v2 1/8] drm/panthor: Add performance counter uAPI
Date: Wed, 11 Dec 2024 16:50:17 +0000
Message-Id: <20241211165024.490748-2-lukas.zapolskas@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241211165024.490748-1-lukas.zapolskas@arm.com>
References: <20241211165024.490748-1-lukas.zapolskas@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0300.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::24) To AM6PR08MB3317.eurprd08.prod.outlook.com
 (2603:10a6:209:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM6PR08MB3317:EE_|DU0PR08MB8422:EE_|AM3PEPF00009B9E:EE_|DBAPR08MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b203ed8-628c-4738-fab5-08dd1a04000d
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?f1x9mEA7Pj3F1p1p/MQTC81bMimZQHUpcizg8JG2def6O9fiVANiXt0gWMQb?=
 =?us-ascii?Q?vIanwAjF2mKoXt31s0nt5QnDRYyTguzVhv9+QvfX1c4MBfnVQUeIX0L3dD/J?=
 =?us-ascii?Q?72X26O5c95UxpJRNQcDFPMZU2mPaBfA5aWfQRR7Jx5tHhn9sL/pDbjo6KIDi?=
 =?us-ascii?Q?p2V1IjvB+4dFW1KLb0LwQGTf7dy5wt13MwJuH9YA1wjJPosWSQCXZFAE8DP4?=
 =?us-ascii?Q?NOTL7zjXLIER2mU9CmfHUoJGrgAfUwReQhvcs5eJHMtFRGLo1ucECITQph2a?=
 =?us-ascii?Q?KNaKjdOb5M4Sm3CA0AZZzlZ6FyZmeP5G1uUcusFzle6e16ZO/9GzxBR9OvbI?=
 =?us-ascii?Q?VlIdEKWO7z7uzmrvBU/qjm4j5GcVnkKChu9KSB0+TfLMOjXG+1/WjOaDSVm/?=
 =?us-ascii?Q?Li5RdNBS9Xm40bW2dP/XqA1brWyehRzvXAYT6spncc6OWXiw5thBXDNljfDW?=
 =?us-ascii?Q?8p/z3knW7/aqq1Nb79L++ags8/sLmwm9jzD+DI4PMdlGo+gUl63pXtzw7mH7?=
 =?us-ascii?Q?oeZFBnJgNbrbslf05Z/+Ovtzffa8t3rcFhKa1uvqsQOhqA3u3jtA0nO7vZvs?=
 =?us-ascii?Q?SI5ZkW/E6zn80e/I5Swwvpwrt2S7K/BN7pDAWa6+pOFhC0ely7jlyhCwMtl4?=
 =?us-ascii?Q?qiT0mxtv89TFemDbkW+0oHNv8pqecOz3TZNgqC4G+nFbuBDtNW0S1wA+shbo?=
 =?us-ascii?Q?nBRec5hnpnAp6EyvBZPi+2loATDkbctBJ9Y8oripV11Pf62a9uyY37sWnJi1?=
 =?us-ascii?Q?/PTju7HWWMQwZRwHQ6lLs0Tk7xQwWqIGcvBBlIVP10+JGGkVTTLiT6OQIen/?=
 =?us-ascii?Q?61zlaI2X6fr5aJUEha8eNJxG60TTKm7nQQ+w+YvhWebOoyhzgAdVEqBY/rOY?=
 =?us-ascii?Q?nEs5hxlVFhNO2yzp/rcdRhmlG1IJn0mvHQURPy2BfPldAZ8q948H0O5AXsPw?=
 =?us-ascii?Q?LVH/iddAFuU9I+cJ+93KguMrMGWR1xyO5ht5wdWWroclaKVB+pMfO+i4BRwX?=
 =?us-ascii?Q?mX4cY7/mSIfib7lRlIfO8LlsdGOQuO4j/dDTxZR/8459AgQPELOCdiQFs835?=
 =?us-ascii?Q?DOvnEF5A9REfS1OIylsgGGUmJsW2COMp4orrbOUCKgOExXRA5Jnw/Hff6fp5?=
 =?us-ascii?Q?uJxKl+LjQGAAlzCkYEj6heMPNpkbK4vLofHn9/OAsl6Ow1xED77eUkToqLlQ?=
 =?us-ascii?Q?H4kyEudwelnV31rt6G3WvuM3IT4P7/cHp2S2dwZXD08sgMJhJ8/ZLUQDtzze?=
 =?us-ascii?Q?U3PlBnrq6aqBRX/NFtVMPDlSxwaVXqmRRRwxoDwcWDy5rDwyF1saSQqilbX2?=
 =?us-ascii?Q?wiAaYwj2GrbU2Kv4YochJ8d9nEbEgD1Xa8RERsg56Me0Nw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3317.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8422
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:209:42::28];domain=AM6PR08MB3317.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ec41d26e-bcb4-4b2b-c35c-08dd1a03f984
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|35042699022|14060799003|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?folsRg6V5DvbOfujZTi+P/OLhFL12ovIhcOOsepIP/73EuSp8wWJR+fd6iIB?=
 =?us-ascii?Q?gQpi+AOkP6B1HeCnb2IB50K5tI1RL3PRbfHj3ULxtQYLaKMHGkaSLhoKQ/9Z?=
 =?us-ascii?Q?yH2HEyqj4xRvXLIZmxCpRVCOh4p/TkZnKXMsV4bOQLvM231Q8lCqQtjWIXOO?=
 =?us-ascii?Q?oxyV+08p/4TsNsiYX07HJBrj4XL9NJ6xphajslmD1rjTTK+cM+OaA8wZ7QKR?=
 =?us-ascii?Q?Gpvjv8CmjaQIHXygVJYCTehmOc+gNGzOkOxyPdrLblSzmQ04GDALWagaYmZH?=
 =?us-ascii?Q?EI5W7XnvF0zA1molhY/3lU8oFECRTCW52H8mnKQUu8OOveoAjVVT3ra1Qaje?=
 =?us-ascii?Q?7S6zqBIvM0l16yJSJYYlbL/uSj2fY2d9l6MFj78HydSMc15HvfxMx1d6/jO8?=
 =?us-ascii?Q?6LaCyc8Ph0FwqBI9Ic1U/WpbcrfUn0GSwpwI6bAaFgSXFIH8a2gLPsvf51TR?=
 =?us-ascii?Q?G+8A6KsH77lISSSdepvOnbCv6SHuxlR1pFGLh7fJwogrxvbSbNC3WeyfUDzW?=
 =?us-ascii?Q?VdOzbK0w0GQA8IlxLvXPbr6DC7DpmdtTZEkkLKKr31IFmrr1XpvLah5oxpMw?=
 =?us-ascii?Q?vxHVjJJH82+SZdAC45cppy5E1EmMJb/CJG9tgCIHx2UkKMn+avUPnFF9v8eo?=
 =?us-ascii?Q?Q+RhdeY3/VXWqZ6W/myHoTJS9MXhgGXAdtLG8YjoqG4FnVis4wndZ20cTCHt?=
 =?us-ascii?Q?JxmrcaVUH9ZU6ZeiNDcqxDVdAU0HJsi18F0F0Zi2MP7u4sTwzi2syz1bbckw?=
 =?us-ascii?Q?JpoUwH9LTrMvi7Q4A0xSAot+OhKvjt4DnTUPYRAV9H529TkALfEmp3N5QGIh?=
 =?us-ascii?Q?qgw5K9H7W/4HrPyi54RBmOiISo73n+y5nwjULMl7Ozgf8hy8MJk6yflC4C6a?=
 =?us-ascii?Q?HQ1CNf7QBWgvuI0x5i1kFPklSh8R4jkmywQEKVovjMvIbaTx/g1SV3nC4iiD?=
 =?us-ascii?Q?6YVZwLJwKxcnBvznjFYCBL1d2lYNReonqjKLb2lBzpylqCPaGAxzmQSjaacT?=
 =?us-ascii?Q?MwmmaS4y31yiAW9kwvpjYnCwklsT0qxIuCukiRSwynoPDwv5lSI4btsGZZHc?=
 =?us-ascii?Q?o9BVIWNba25a2brdd0wUP2w8aWLGU5VUo9cCgc+/72jawJd55uegdqFGTp7Q?=
 =?us-ascii?Q?LYxreubpvy0xn8iBiGu7FBsE8u/Z9iYJUK7jSIlsn+kl4KuvUKZE9qDjfXzw?=
 =?us-ascii?Q?I2yqTsjidU/BEmCka5vdnuPsyeJ8FYhPMOt8kBhRFGSXxPcKZ8yLU4+BNRjt?=
 =?us-ascii?Q?ne879HDWKp6U4ZL3Rsfd/vdcrkmg5OhkzoavnZKszZhOjyPeq7r9W8hbPuxF?=
 =?us-ascii?Q?sAKq7lyN33WmvpmZZyFgL+A9Mt5AQmCqfn/4CSs/nIXpSmq/TeDFUdAcS4OS?=
 =?us-ascii?Q?kIoE1a3FoRxYQyPtt3sl+i6zmk7stnLrQbJ2odOAwxezlC7BA3jvsc8u/qgO?=
 =?us-ascii?Q?X8mjF2Nm43IMQsM4IWEXbiguqpoUoG2uCOP+yswY2mk4eTd9Zry9aw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(35042699022)(14060799003)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 16:51:03.8960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b203ed8-628c-4738-fab5-08dd1a04000d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5607

This patch extends the DEV_QUERY ioctl to return information about the
performance counter setup for userspace, and introduces the new
ioctl DRM_PANTHOR_PERF_CONTROL in order to allow for the sampling of
performance counters.

The new design is inspired by the perf aux ringbuffer, with the insert
and extract indices being mapped to userspace, allowing multiple samples
to be exposed at any given time. To avoid pointer chasing, the sample
metadata and block metadata are inline with the elements they
describe.

Userspace is responsible for passing in resources for samples to be
exposed, including the event file descriptor for notification of new
sample availability, the ringbuffer BO to store samples, and the control
BO along with the offset for mapping the insert and extract indices.
Though these indices are only a total of 8 bytes, userspace can then
reuse the same physical page for tracking the state of multiple buffers
by giving different offsets from the BO start to map them.

Co-developed-by: Mihail Atanassov <mihail.atanassov@arm.com>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
---
 include/uapi/drm/panthor_drm.h | 487 +++++++++++++++++++++++++++++++++
 1 file changed, 487 insertions(+)

diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index 87c9cb555dd1..8a431431da6b 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -127,6 +127,9 @@ enum drm_panthor_ioctl_id {
 
 	/** @DRM_PANTHOR_TILER_HEAP_DESTROY: Destroy a tiler heap. */
 	DRM_PANTHOR_TILER_HEAP_DESTROY,
+
+	/** @DRM_PANTHOR_PERF_CONTROL: Control a performance counter session. */
+	DRM_PANTHOR_PERF_CONTROL,
 };
 
 /**
@@ -170,6 +173,8 @@ enum drm_panthor_ioctl_id {
 	DRM_IOCTL_PANTHOR(WR, TILER_HEAP_CREATE, tiler_heap_create)
 #define DRM_IOCTL_PANTHOR_TILER_HEAP_DESTROY \
 	DRM_IOCTL_PANTHOR(WR, TILER_HEAP_DESTROY, tiler_heap_destroy)
+#define DRM_IOCTL_PANTHOR_PERF_CONTROL \
+	DRM_IOCTL_PANTHOR(WR, PERF_CONTROL, perf_control)
 
 /**
  * DOC: IOCTL arguments
@@ -268,6 +273,9 @@ enum drm_panthor_dev_query_type {
 	 * @DRM_PANTHOR_DEV_QUERY_GROUP_PRIORITIES_INFO: Query allowed group priorities information.
 	 */
 	DRM_PANTHOR_DEV_QUERY_GROUP_PRIORITIES_INFO,
+
+	/** @DRM_PANTHOR_DEV_QUERY_PERF_INFO: Query performance counter interface information. */
+	DRM_PANTHOR_DEV_QUERY_PERF_INFO,
 };
 
 /**
@@ -421,6 +429,120 @@ struct drm_panthor_group_priorities_info {
 	__u8 pad[3];
 };
 
+/**
+ * enum drm_panthor_perf_feat_flags - Performance counter configuration feature flags.
+ */
+enum drm_panthor_perf_feat_flags {
+	/** @DRM_PANTHOR_PERF_BLOCK_STATES_SUPPORT: Coarse-grained block states are supported. */
+	DRM_PANTHOR_PERF_BLOCK_STATES_SUPPORT = 1 << 0,
+};
+
+/**
+ * enum drm_panthor_perf_block_type - Performance counter supported block types.
+ */
+enum drm_panthor_perf_block_type {
+	/** @DRM_PANTHOR_PERF_BLOCK_FW: The FW counter block. */
+	DRM_PANTHOR_PERF_BLOCK_FW = 1,
+
+	/** @DRM_PANTHOR_PERF_BLOCK_CSG: A CSG counter block. */
+	DRM_PANTHOR_PERF_BLOCK_CSG,
+
+	/** @DRM_PANTHOR_PERF_BLOCK_CSHW: The CSHW counter block. */
+	DRM_PANTHOR_PERF_BLOCK_CSHW,
+
+	/** @DRM_PANTHOR_PERF_BLOCK_TILER: The tiler counter block. */
+	DRM_PANTHOR_PERF_BLOCK_TILER,
+
+	/** @DRM_PANTHOR_PERF_BLOCK_MEMSYS: A memsys counter block. */
+	DRM_PANTHOR_PERF_BLOCK_MEMSYS,
+
+	/** @DRM_PANTHOR_PERF_BLOCK_SHADER: A shader core counter block. */
+	DRM_PANTHOR_PERF_BLOCK_SHADER,
+};
+
+/**
+ * enum drm_panthor_perf_clock - Identifier of the clock used to produce the cycle count values
+ * in a given block.
+ *
+ * Since the integrator has the choice of using one or more clocks, there may be some confusion
+ * as to which blocks are counted by which clock values unless this information is explicitly
+ * provided as part of every block sample. Not every single clock here can be used: in the simplest
+ * case, all cycle counts will be associated with the top-level clock.
+ */
+enum drm_panthor_perf_clock {
+	/** @DRM_PANTHOR_PERF_CLOCK_TOPLEVEL: Top-level CSF clock. */
+	DRM_PANTHOR_PERF_CLOCK_TOPLEVEL,
+
+	/**
+	 * @DRM_PANTHOR_PERF_CLOCK_COREGROUP: Core group clock, responsible for the MMU, L2
+	 * caches and the tiler.
+	 */
+	DRM_PANTHOR_PERF_CLOCK_COREGROUP,
+
+	/** @DRM_PANTHOR_PERF_CLOCK_SHADER: Clock for the shader cores. */
+	DRM_PANTHOR_PERF_CLOCK_SHADER,
+};
+
+/**
+ * struct drm_panthor_perf_info - Performance counter interface information
+ *
+ * Structure grouping all queryable information relating to the performance counter
+ * interfaces.
+ */
+struct drm_panthor_perf_info {
+	/**
+	 * @counters_per_block: The number of 8-byte counters available in a block.
+	 */
+	__u32 counters_per_block;
+
+	/**
+	 * @sample_header_size: The size of the header struct available at the beginning
+	 * of every sample.
+	 */
+	__u32 sample_header_size;
+
+	/**
+	 * @block_header_size: The size of the header struct inline with the counters for a
+	 * single block.
+	 */
+	__u32 block_header_size;
+
+	/** @flags: Combination of drm_panthor_perf_feat_flags flags. */
+	__u32 flags;
+
+	/**
+	 * @supported_clocks: Bitmask of the clocks supported by the GPU.
+	 *
+	 * Each bit represents a variant of the enum drm_panthor_perf_clock.
+	 *
+	 * For the same GPU, different implementers may have different clocks for the same hardware
+	 * block. At the moment, up to four clocks are supported, and any clocks that are present
+	 * will be reported here.
+	 */
+	__u32 supported_clocks;
+
+	/** @fw_blocks: Number of FW blocks available. */
+	__u32 fw_blocks;
+
+	/** @csg_blocks: Number of CSG blocks available. */
+	__u32 csg_blocks;
+
+	/** @cshw_blocks: Number of CSHW blocks available. */
+	__u32 cshw_blocks;
+
+	/** @tiler_blocks: Number of tiler blocks available. */
+	__u32 tiler_blocks;
+
+	/** @memsys_blocks: Number of memsys blocks available. */
+	__u32 memsys_blocks;
+
+	/** @shader_blocks: Number of shader core blocks available. */
+	__u32 shader_blocks;
+
+	/** @pad: MBZ. */
+	__u32 pad;
+};
+
 /**
  * struct drm_panthor_dev_query - Arguments passed to DRM_PANTHOR_IOCTL_DEV_QUERY
  */
@@ -1010,6 +1132,371 @@ struct drm_panthor_tiler_heap_destroy {
 	__u32 pad;
 };
 
+/**
+ * DOC: Performance counter decoding in userspace.
+ *
+ * Each sample will be exposed to userspace in the following manner:
+ *
+ * +--------+--------+------------------------+--------+-------------------------+-----+
+ * | Sample | Block  |        Block           | Block  |         Block           | ... |
+ * | header | header |        counters        | header |         counters        |     |
+ * +--------+--------+------------------------+--------+-------------------------+-----+
+ *
+ * Each sample will start with a sample header of type @struct drm_panthor_perf_sample header,
+ * providing sample-wide information like the start and end timestamps, the counter set currently
+ * configured, and any errors that may have occurred during sampling.
+ *
+ * After the fixed size header, the sample will consist of blocks of
+ * 64-bit @drm_panthor_dev_query_perf_info::counters_per_block counters, each prefaced with a
+ * header of its own, indicating source block type, as well as the cycle count needed to normalize
+ * cycle values within that block, and a clock source identifier.
+ */
+
+/**
+ * enum drm_panthor_perf_block_state - Bitmask of the power and execution states that an individual
+ * hardware block went through in a sampling period.
+ *
+ * Because the sampling period is controlled from userspace, the block may undergo multiple
+ * state transitions, so this must be interpreted as one or more such transitions occurring.
+ */
+enum drm_panthor_perf_block_state {
+	/**
+	 * @DRM_PANTHOR_PERF_BLOCK_STATE_UNKNOWN: The state of this block was unknown during
+	 * the sampling period.
+	 */
+	DRM_PANTHOR_PERF_BLOCK_STATE_UNKNOWN = 0,
+
+	/**
+	 * @DRM_PANTHOR_PERF_BLOCK_STATE_ON: This block was powered on for some or all of
+	 * the sampling period.
+	 */
+	DRM_PANTHOR_PERF_BLOCK_STATE_ON = 1 << 0,
+
+	/**
+	 * @DRM_PANTHOR_PERF_BLOCK_STATE_OFF: This block was powered off for some or all of the
+	 * sampling period.
+	 */
+	DRM_PANTHOR_PERF_BLOCK_STATE_OFF = 1 << 1,
+
+	/**
+	 * @DRM_PANTHOR_PERF_BLOCK_STATE_AVAILABLE: This block was available for execution for
+	 * some or all of the sampling period.
+	 */
+	DRM_PANTHOR_PERF_BLOCK_STATE_AVAILABLE = 1 << 2,
+	/**
+	 * @DRM_PANTHOR_PERF_BLOCK_STATE_UNAVAILABLE: This block was unavailable for execution for
+	 * some or all of the sampling period.
+	 */
+	DRM_PANTHOR_PERF_BLOCK_STATE_UNAVAILABLE = 1 << 3,
+
+	/**
+	 * @DRM_PANTHOR_PERF_BLOCK_STATE_NORMAL: This block was executing in normal mode
+	 * for some or all of the sampling period.
+	 */
+	DRM_PANTHOR_PERF_BLOCK_STATE_NORMAL = 1 << 4,
+
+	/**
+	 * @DRM_PANTHOR_PERF_BLOCK_STATE_PROTECTED: This block was executing in protected mode
+	 * for some or all of the sampling period.
+	 */
+	DRM_PANTHOR_PERF_BLOCK_STATE_PROTECTED = 1 << 5,
+};
+
+/**
+ * struct drm_panthor_perf_block_header - Header present before every block in the
+ * sample ringbuffer.
+ */
+struct drm_panthor_perf_block_header {
+	/** @block_type: Type of the block. */
+	__u8 block_type;
+
+	/** @block_idx: Block index. */
+	__u8 block_idx;
+
+	/**
+	 * @block_states: Coarse-grained block transitions, bitmask of enum
+	 * drm_panthor_perf_block_states.
+	 */
+	__u8 block_states;
+
+	/**
+	 * @clock: Clock used to produce the cycle count for this block, taken from
+	 * enum drm_panthor_perf_clock. The cycle counts are stored in the sample header.
+	 */
+	__u8 clock;
+
+	/** @pad: MBZ. */
+	__u8 pad[4];
+
+	/** @enable_mask: Bitmask of counters requested during the session setup. */
+	__u64 enable_mask[2];
+};
+
+/**
+ * enum drm_panthor_perf_sample_flags - Sample-wide events that occurred over the sampling
+ * period.
+ */
+enum drm_panthor_perf_sample_flags {
+	/**
+	 * @DRM_PANTHOR_PERF_SAMPLE_OVERFLOW: This sample contains overflows due to the duration
+	 * of the sampling period.
+	 */
+	DRM_PANTHOR_PERF_SAMPLE_OVERFLOW = 1 << 0,
+
+	/**
+	 * @DRM_PANTHOR_PERF_SAMPLE_ERROR: This sample encountered an error condition during
+	 * the sample duration.
+	 */
+	DRM_PANTHOR_PERF_SAMPLE_ERROR = 1 << 1,
+};
+
+/**
+ * struct drm_panthor_perf_sample_header - Header present before every sample.
+ */
+struct drm_panthor_perf_sample_header {
+	/**
+	 * @timestamp_start_ns: Earliest timestamp that values in this sample represent, in
+	 * nanoseconds. Derived from CLOCK_MONOTONIC_RAW.
+	 */
+	__u64 timestamp_start_ns;
+
+	/**
+	 * @timestamp_end_ns: Latest timestamp that values in this sample represent, in
+	 * nanoseconds. Derived from CLOCK_MONOTONIC_RAW.
+	 */
+	__u64 timestamp_end_ns;
+
+	/** @block_set: Set of performance counter blocks. */
+	__u8 block_set;
+
+	/** @pad: MBZ. */
+	__u8 pad[3];
+
+	/** @flags: Current sample flags, combination of drm_panthor_perf_sample_flags. */
+	__u32 flags;
+
+	/**
+	 * @user_data: User data provided as part of the command that triggered this sample.
+	 *
+	 * - Automatic samples (periodic ones or those around non-counting periods or power state
+	 * transitions) will be tagged with the user_data provided as part of the
+	 * DRM_PANTHOR_PERF_COMMAND_START call.
+	 * - Manual samples will be tagged with the user_data provided with the
+	 * DRM_PANTHOR_PERF_COMMAND_SAMPLE call.
+	 * - A session's final automatic sample will be tagged with the user_data provided with the
+	 * DRM_PANTHOR_PERF_COMMAND_STOP call.
+	 */
+	__u64 user_data;
+
+	/**
+	 * @toplevel_clock_cycles: The number of cycles elapsed between
+	 * drm_panthor_perf_sample_header::timestamp_start_ns and
+	 * drm_panthor_perf_sample_header::timestamp_end_ns on the top-level clock if the
+	 * corresponding bit is set in drm_panthor_perf_info::supported_clocks.
+	 */
+	__u64 toplevel_clock_cycles;
+
+	/**
+	 * @coregroup_clock_cycles: The number of cycles elapsed between
+	 * drm_panthor_perf_sample_header::timestamp_start_ns and
+	 * drm_panthor_perf_sample_header::timestamp_end_ns on the coregroup clock if the
+	 * corresponding bit is set in drm_panthor_perf_info::supported_clocks.
+	 */
+	__u64 coregroup_clock_cycles;
+
+	/**
+	 * @shader_clock_cycles: The number of cycles elapsed between
+	 * drm_panthor_perf_sample_header::timestamp_start_ns and
+	 * drm_panthor_perf_sample_header::timestamp_end_ns on the shader core clock if the
+	 * corresponding bit is set in drm_panthor_perf_info::supported_clocks.
+	 */
+	__u64 shader_clock_cycles;
+};
+
+/**
+ * enum drm_panthor_perf_command - Command type passed to the DRM_PANTHOR_PERF_CONTROL
+ * IOCTL.
+ */
+enum drm_panthor_perf_command {
+	/** @DRM_PANTHOR_PERF_COMMAND_SETUP: Create a new performance counter sampling context. */
+	DRM_PANTHOR_PERF_COMMAND_SETUP,
+
+	/** @DRM_PANTHOR_PERF_COMMAND_TEARDOWN: Teardown a performance counter sampling context. */
+	DRM_PANTHOR_PERF_COMMAND_TEARDOWN,
+
+	/** @DRM_PANTHOR_PERF_COMMAND_START: Start a sampling session on the indicated context. */
+	DRM_PANTHOR_PERF_COMMAND_START,
+
+	/** @DRM_PANTHOR_PERF_COMMAND_STOP: Stop the sampling session on the indicated context. */
+	DRM_PANTHOR_PERF_COMMAND_STOP,
+
+	/**
+	 * @DRM_PANTHOR_PERF_COMMAND_SAMPLE: Request a manual sample on the indicated context.
+	 *
+	 * When the sampling session is configured with a non-zero sampling frequency, any
+	 * DRM_PANTHOR_PERF_CONTROL calls with this command will be ignored and return an
+	 * -EINVAL.
+	 */
+	DRM_PANTHOR_PERF_COMMAND_SAMPLE,
+};
+
+/**
+ * struct drm_panthor_perf_control - Arguments passed to DRM_PANTHOR_IOCTL_PERF_CONTROL.
+ */
+struct drm_panthor_perf_control {
+	/** @cmd: Command from enum drm_panthor_perf_command. */
+	__u32 cmd;
+
+	/**
+	 * @handle: session handle.
+	 *
+	 * Returned by the DRM_PANTHOR_PERF_COMMAND_SETUP call.
+	 * It must be used in subsequent commands for the same context.
+	 */
+	__u32 handle;
+
+	/**
+	 * @size: size of the command structure.
+	 *
+	 * If the pointer is NULL, the size is updated by the driver to provide the size of the
+	 * output structure. If the pointer is not NULL, the driver will only copy min(size,
+	 * struct_size) to the pointer and update the size accordingly.
+	 */
+	__u64 size;
+
+	/** @pointer: user pointer to a command type struct. */
+	__u64 pointer;
+};
+
+
+/**
+ * struct drm_panthor_perf_cmd_setup - Arguments passed to DRM_PANTHOR_IOCTL_PERF_CONTROL
+ * when the DRM_PANTHOR_PERF_COMMAND_SETUP command is specified.
+ */
+struct drm_panthor_perf_cmd_setup {
+	/**
+	 * @block_set: Set of performance counter blocks.
+	 *
+	 * This is a global configuration and only one set can be active at a time. If
+	 * another client has already requested a counter set, any further requests
+	 * for a different counter set will fail and return an -EBUSY.
+	 *
+	 * If the requested set does not exist, the request will fail and return an -EINVAL.
+	 */
+	__u8 block_set;
+
+	/** @pad: MBZ. */
+	__u8 pad[7];
+
+	/** @fd: eventfd for signalling the availability of a new sample. */
+	__u32 fd;
+
+	/** @ringbuf_handle: Handle to the BO to write perf counter sample to. */
+	__u32 ringbuf_handle;
+
+	/**
+	 * @control_handle: Handle to the BO containing a contiguous 16 byte range, used for the
+	 * insert and extract indices for the ringbuffer.
+	 */
+	__u32 control_handle;
+
+	/**
+	 * @sample_slots: The number of slots available in the userspace-provided BO. Must be
+	 * a power of 2.
+	 *
+	 * If sample_slots * sample_size does not match the BO size, the setup request will fail.
+	 */
+	__u32 sample_slots;
+
+	/**
+	 * @control_offset: Offset into the control BO where the insert and extract indices are
+	 * located.
+	 */
+	__u64 control_offset;
+
+	/**
+	 * @sample_freq_ns: Period between automatic counter sample collection in nanoseconds. Zero
+	 * disables automatic collection and all collection must be done through explicit calls
+	 * to DRM_PANTHOR_PERF_CONTROL.SAMPLE. Non-zero values will disable manual counter sampling
+	 * via the DRM_PANTHOR_PERF_COMMAND_SAMPLE command.
+	 *
+	 * This disables software-triggered periodic sampling, but hardware will still trigger
+	 * automatic samples on certain events, including shader core power transitions, and
+	 * entries to and exits from non-counting periods. The final stop command will also
+	 * trigger a sample to ensure no data is lost.
+	 */
+	__u64 sample_freq_ns;
+
+	/**
+	 * @fw_enable_mask: Bitmask of counters to request from the FW counter block. Any bits
+	 * past the first drm_panthor_perf_info.counters_per_block bits will be ignored.
+	 */
+	__u64 fw_enable_mask[2];
+
+	/**
+	 * @csg_enable_mask: Bitmask of counters to request from the CSG counter blocks. Any bits
+	 * past the first drm_panthor_perf_info.counters_per_block bits will be ignored.
+	 */
+	__u64 csg_enable_mask[2];
+
+	/**
+	 * @cshw_enable_mask: Bitmask of counters to request from the CSHW counter block. Any bits
+	 * past the first drm_panthor_perf_info.counters_per_block bits will be ignored.
+	 */
+	__u64 cshw_enable_mask[2];
+
+	/**
+	 * @tiler_enable_mask: Bitmask of counters to request from the tiler counter block. Any
+	 * bits past the first drm_panthor_perf_info.counters_per_block bits will be ignored.
+	 */
+	__u64 tiler_enable_mask[2];
+
+	/**
+	 * @memsys_enable_mask: Bitmask of counters to request from the memsys counter blocks. Any
+	 * bits past the first drm_panthor_perf_info.counters_per_block bits will be ignored.
+	 */
+	__u64 memsys_enable_mask[2];
+
+	/**
+	 * @shader_enable_mask: Bitmask of counters to request from the shader core counter blocks.
+	 * Any bits past the first drm_panthor_perf_info.counters_per_block bits will be ignored.
+	 */
+	__u64 shader_enable_mask[2];
+};
+
+/**
+ * struct drm_panthor_perf_cmd_start - Arguments passed to DRM_PANTHOR_IOCTL_PERF_CONTROL
+ * when the DRM_PANTHOR_PERF_COMMAND_START command is specified.
+ */
+struct drm_panthor_perf_cmd_start {
+	/**
+	 * @user_data: User provided data that will be attached to automatic samples collected
+	 * until the next DRM_PANTHOR_PERF_COMMAND_STOP.
+	 */
+	__u64 user_data;
+};
+
+/**
+ * struct drm_panthor_perf_cmd_stop - Arguments passed to DRM_PANTHOR_IOCTL_PERF_CONTROL
+ * when the DRM_PANTHOR_PERF_COMMAND_STOP command is specified.
+ */
+struct drm_panthor_perf_cmd_stop {
+	/**
+	 * @user_data: User provided data that will be attached to the automatic sample collected
+	 * at the end of this sampling session.
+	 */
+	__u64 user_data;
+};
+
+/**
+ * struct drm_panthor_perf_cmd_sample - Arguments passed to DRM_PANTHOR_IOCTL_PERF_CONTROL
+ * when the DRM_PANTHOR_PERF_COMMAND_SAMPLE command is specified.
+ */
+struct drm_panthor_perf_cmd_sample {
+	/** @user_data: User provided data that will be attached to the sample.*/
+	__u64 user_data;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.25.1


