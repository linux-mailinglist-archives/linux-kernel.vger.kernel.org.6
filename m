Return-Path: <linux-kernel+bounces-320699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D60970EB0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7852282924
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 06:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F811AD3E4;
	Mon,  9 Sep 2024 06:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zeiss.com header.i=@zeiss.com header.b="EzeZyxlw";
	dkim=pass (2048-bit key) header.d=zeiss.com header.i=@zeiss.com header.b="EzeZyxlw"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639C91F95E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 06:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.49
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865036; cv=fail; b=B9of/dT9jHQ3X0ijl3eUsQvv9FJsOWTmQgMo2DziR+/oi4l1OxquBwv5LCitr2uN1Vj5oymbf2GBs7hpnfurqrrO4OsRN1t5+bZwKvA3MfkXOnFthN6O3+ggqz30g7BezGeEIpa/ImXnevNsZvR+zwTr1zNUtsL/Nnw22l9nXd8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865036; c=relaxed/simple;
	bh=2O5IbrzPsHKRbzoUmgL+9jbjpdHmhT6DJbLW72YPuu0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VEqGteD4hj2BsSnOFkVn0M9ZaLICGBR89yWxMMGTqY3qWXz5ShGzLu+nDDiveIj9qftd2BxflNFD9L1N0kwRcCtuiHkJTA0Zlf30UKI8WPJA078DjrY2PnRxwjsfbrWOT8ozmyIQs8W+Fe90B5l6fMjlodcRFluDE473OguvjpY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zeiss.com; spf=pass smtp.mailfrom=zeiss.com; dkim=pass (2048-bit key) header.d=zeiss.com header.i=@zeiss.com header.b=EzeZyxlw; dkim=pass (2048-bit key) header.d=zeiss.com header.i=@zeiss.com header.b=EzeZyxlw; arc=fail smtp.client-ip=40.107.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zeiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zeiss.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=HptL8bwgVwAAHqCnsbSjeRJI5Y84WcolFZqYMmn5KRJQ/RDEzGtumhHvsoZ9nwQtxHqZzFT1XeFmPCk0CXcEFsIs5yC0FrnzltRyP1CgqO5EMNT09C13+aEwVro8eQyyorrLg+t2SeSKYbzHq411YdadmqsW7LvGpCTGtftJbIg7YaCv5BhXjzfblhE9Anrz5PSTRlCQHT29O5prMrL8H+Nu8oj8w3uiP34rRAlbaEHOXprPC4eYbI3kw8MSzMCcZ+2uhYlnXPKzlpJtWng12y/VFqBAUMB7kVsMokbnuSEGS8pxmTof4A6+zz11Gb6+6+XXAcMI74deKOVsdxlVQA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V89/lwUBY4P1IigBCHjewQlFxAzefw/YI0KY2zPeSVY=;
 b=AAR4Cl58i0GH9tRnaceNklqYDaallCjrIOExPzHY10o7piahbx2NEsVTQqiguQrjdQtL+AqmlMaQ7l6Elyv1vBRgLUoVKv6DGKl/d8lyPH4mNnTQB4KO/bLwvXQf65KCAFP0aeP4QWwMRXVjrxS1HmwrE862rcU6MHh/XNtkC/sxjUtWmvwQB410kmb8Ln9lFzFq8pUaYdaa+qs85YcocNxgDKFxndasg09qkH2kz39h9O6LV62zLSqkfOokU3+9gjsJ9PGfd2l1Lu64/e7E/YZPsmgFXYl6t/22wEe27JQQj7rF6bxcWmodfldw5qBRDjE2M9VJkBQGyMBBkf7gJQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 3.126.247.145) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=zeiss.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=zeiss.com; dkim=pass (signature was verified) header.d=zeiss.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=zeiss.com]
 dkim=[1,1,header.d=zeiss.com] dmarc=[1,1,header.from=zeiss.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeiss.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V89/lwUBY4P1IigBCHjewQlFxAzefw/YI0KY2zPeSVY=;
 b=EzeZyxlwhXWac3ybjtQl9LRWDFaImivu3VS568nbsPI04hLhEMFCeX06+XdZljYA7gzxZRjBKWKJbsjLEIoDarQjHawNgaqRCcVtgGzG2Hshn6w/y6h1wuJ+xh5w7QInewKGm6GdKXWyPW9rnP6MIRVMktZ9LJd/OBvvY6smWZdPhGxBGnJWJTKICCTPAFPQ8j4VZC/9i6bBc++PWGa3vufFOkDUs11Tq4PTrjggC9Ef1r9/JGwVSElr+nOYn94MQinO7GTZeC+ylvo4oVokxt0Zn4LgccfDVfgknj9Bz6ltng92ugqTmxXe5NY+AmqtB8jgyCimfmnFNy9X2stpqg==
Received: from DUZPR01CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::11) by DBAP190MB0965.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:1a9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 06:57:10 +0000
Received: from DB5PEPF00014B99.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::bd) by DUZPR01CA0007.outlook.office365.com
 (2603:10a6:10:3c3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 06:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 3.126.247.145)
 smtp.mailfrom=zeiss.com; dkim=pass (signature was verified)
 header.d=zeiss.com;dmarc=pass action=none header.from=zeiss.com;
Received-SPF: Fail (protection.outlook.com: domain of zeiss.com does not
 designate 3.126.247.145 as permitted sender) receiver=protection.outlook.com;
 client-ip=3.126.247.145; helo=jegw2.zeiss.com;
Received: from jegw2.zeiss.com (3.126.247.145) by
 DB5PEPF00014B99.mail.protection.outlook.com (10.167.8.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Mon, 9 Sep 2024 06:57:09 +0000
Received: from ip-10-25-10-142 (localhost [127.0.0.1])
	by jegw2.zeiss.com (Postfix) with ESMTP id A35F31B58B6
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:57:09 +0200 (CEST)
Received: from kag06088vm017.zeiss.com (kag06088vm017 [10.25.10.199])
	by kag06088vm012.zeiss.org (Postfix) with ESMTPS id 8FCAD1B5837
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:57:09 +0200 (CEST)
Received: from ip-10-25-10-199 (localhost [127.0.0.1])
	by kag06088vm017.zeiss.com (Postfix) with ESMTP id 8AC8832DD7E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:57:09 +0200 (CEST)
Received: from kag06088vm014.zeiss.com (kag06088vm014.zeiss.com [10.25.10.164])
	by kag06088vm017.zeiss.com (Postfix) with ESMTPS id 7E0AD32D81C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:57:09 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02lp2111.outbound.protection.outlook.com [104.47.11.111])
	by kag06088vm014.zeiss.com (Postfix) with ESMTPS id 62F6F3EBD5
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:57:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKpTOjvRQSRh7gdq/EYg+uld4SxpFgZhjhNJ+7o0eCtgITzDuxbnuQV/NZFlxfteD7qGVj4kzBPbqoSPcv4vFt7bJAnf9QopDFCa9KBKwa0aG2AxAmBM4GzgMhxnyCdwj3w90/T6qo3b448lyWx0t8LcrOoRuLHYNIOfgwdkaummZWsCoDbZpSILlzA2hOAbJ6kebuk9sARQFKg9BMlYHaRTTR+nKdYEUVKExZPt5Dk8CqVthQNRnoO2VZO+D56Bi37sIftZdE2zxhm1YXLsPPxs8gxoWMhcjwo4x9krR0Xh/BbnR7EVnw/D0CVH9fyBFhPrwLFIAvVN+dod6FsmjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V89/lwUBY4P1IigBCHjewQlFxAzefw/YI0KY2zPeSVY=;
 b=GE7O3HiYWay9BCmV25v7rug1vd38bAruzzZBNB+ddai1Swsar+Jds74zNQfer4RtxvKbUiWWFIjbfJqt6M4MKoe4zNAYPsJ8UPCPI+5sz5r/r0JvxiM9qM3ZKpZYjN+RSgtwVpfuRlL/rRJyZNLN9bhUTZb+7VErjudUe3HEGrBKsTVPDWY2a7oZOJdI9ZZ/kN/kPjqI+dIgUvWgPWa75CWHUVZm14E3lQYAdp9CFsdbMkVWFJeQqVN5o6txfYTALnnAkFpsBWsxjuTCfZMApynK9dyxiB4JngD2yM4FxFCdT+gXc7U3QPUhshB7oJwInpQh+blcuHPOdGPIGcRPAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zeiss.com; dmarc=pass action=none header.from=zeiss.com;
 dkim=pass header.d=zeiss.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeiss.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V89/lwUBY4P1IigBCHjewQlFxAzefw/YI0KY2zPeSVY=;
 b=EzeZyxlwhXWac3ybjtQl9LRWDFaImivu3VS568nbsPI04hLhEMFCeX06+XdZljYA7gzxZRjBKWKJbsjLEIoDarQjHawNgaqRCcVtgGzG2Hshn6w/y6h1wuJ+xh5w7QInewKGm6GdKXWyPW9rnP6MIRVMktZ9LJd/OBvvY6smWZdPhGxBGnJWJTKICCTPAFPQ8j4VZC/9i6bBc++PWGa3vufFOkDUs11Tq4PTrjggC9Ef1r9/JGwVSElr+nOYn94MQinO7GTZeC+ylvo4oVokxt0Zn4LgccfDVfgknj9Bz6ltng92ugqTmxXe5NY+AmqtB8jgyCimfmnFNy9X2stpqg==
Received: from DB9P190MB1820.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:33a::19)
 by VE1P190MB0845.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 06:57:07 +0000
Received: from DB9P190MB1820.EURP190.PROD.OUTLOOK.COM
 ([fe80::cbf1:c783:12cc:8886]) by DB9P190MB1820.EURP190.PROD.OUTLOOK.COM
 ([fe80::cbf1:c783:12cc:8886%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 06:57:07 +0000
From: "Suesens, Sebastian" <sebastian.suesens@zeiss.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: devicetree support for PCIe cards on x86
Thread-Topic: devicetree support for PCIe cards on x86
Thread-Index: AdsChT3NTvUNDMtCQvyH6KP10NSoew==
Date: Mon, 9 Sep 2024 06:57:07 +0000
Message-ID:
 <DB9P190MB1820F09E9FC2DFE12DB838E4F1992@DB9P190MB1820.EURP190.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zeiss.com;
x-ms-traffictypediagnostic:
	DB9P190MB1820:EE_|VE1P190MB0845:EE_|DB5PEPF00014B99:EE_|DBAP190MB0965:EE_
X-MS-Office365-Filtering-Correlation-Id: 65fffa80-c305-4775-9f2d-08dcd09ca028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?ROnIDZYelEnyAqdytUGmPi8lviaT+FO6mN8IA/ebyIj7ZyR/vemcu/qMu2YM?=
 =?us-ascii?Q?iI/YK6lmGjGAbo0uN/Vg9v77MntKNh+UsCKpR011m0INXX9G3S4pTD4NcdVC?=
 =?us-ascii?Q?sBidJMP2HKDI69td1SUPksXRmtPUl3KaOfD8uTaI7ac1VyF5f5K4A9kavpjW?=
 =?us-ascii?Q?xFXC7pDL5K4Fz0Dth61YR2LM+r/iNOrD7KnYeyuJgCc5nxnjhwKpk4aMxSY2?=
 =?us-ascii?Q?3PUr5GX+AvKT2OHPPlo1bf5Wlh+wX/ljfR6nzOfc//tblnrSRDeeEme3vaYE?=
 =?us-ascii?Q?4q/1VUcCMrWGaiOiV4qe8Aj0dd2dprrRq5QWKeCjm2VkiZeeMq8cDqY2VgtA?=
 =?us-ascii?Q?UX6R/Ra/7ixW71exMv7KVD0ugF5MFaYk3Uo39d7Z3rNJUhTyooxKiO9WlJPp?=
 =?us-ascii?Q?9chitcRRCqwPTmkH4Abhk9fK8pIq0mTmtZtpl2TQH2dyua80iFI7qRoL6wA2?=
 =?us-ascii?Q?O3ni/YZsf7uJCORDx/qeRudUESRlw0AIL3eHw3w/7n+lNNuOTtfuSCtUoBCp?=
 =?us-ascii?Q?U0hYzFHXUltd6fg5cGQUmwBdeLYdjX/tvVeoIWK/OjH1W136CwBlcASTMgKe?=
 =?us-ascii?Q?jPr/48YRXEErPgUC1KubqyazAmbJS7MWek7XYEPIFfbhJib8sdzN1VOy76nL?=
 =?us-ascii?Q?ELbdtJCCSQuUbEWahH5A/p4AZVlcurxbXnplWqVJok9zaYxa+LGHOWoCNCcf?=
 =?us-ascii?Q?/YrtW/Czqf4O0b5kYjfKJqLIJmwC9k9O0KYbt1zU+ewHj8n4zJrZzMu0X2hj?=
 =?us-ascii?Q?nWm3AZ+qopLLdhBmntO+PQryDq6rQY9QFrDO9dSEUBzCk1uQnPSWv0elfbvO?=
 =?us-ascii?Q?/bTUm2L6fItmisjIgosHEkJrfBdaqlWJ0e9JCzYm7JgSzfVlkddafbAYWOBF?=
 =?us-ascii?Q?7Zxr0/9SvnAaXSNe23qQOeOYUfwEuFD3RsP264bI6MrvYr4pg+cccL2INvjr?=
 =?us-ascii?Q?QIDdlzvpMWUPovDe89/iGvMspiWtga3qAmSeTo+1OLBXws3NI9bhwWM5Qs2/?=
 =?us-ascii?Q?h/bEE6sAwHEP5P4X1NwIyfJmmc/zk5Cfb1cuAJPhgsLXc3SD8cmlFlZNHqS0?=
 =?us-ascii?Q?+iwu3BisMCgqas1k/8f305jlU7ueq6oEi52QkbVBGLY7n+dd1IDR4HE7UGHi?=
 =?us-ascii?Q?WHywa9jevZ1csP9bSrc3sb4seg4/TzSazTWE8Cuj4qlsFZ772ohpAFtohbol?=
 =?us-ascii?Q?10c2RSgD0qQ8pgafwOSNN4hRYDZfYoE0tDwZ29Vc8kHH/cuB3hq5SZVNxEha?=
 =?us-ascii?Q?pbNBEjSx2oHaqOd7Rh2OVuZ7ZTf/C0/eYPLzIJVLbPq7dd7o8q60XbLKAo2L?=
 =?us-ascii?Q?ma+BlC/O6ZvUJniypV+J/CROf9eqq1OWVzTJsR/nPlfvQZeXIHXYqcjTmiMj?=
 =?us-ascii?Q?CGX14DB2HjAyNySIPQzt+Yesmhqsiw61LPYyC1i5F3ex0Ipk/Q=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P190MB1820.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P190MB0845
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[3.126.247.145];domain=jegw2.zeiss.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[3.126.247.145];domain=jegw2.zeiss.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B99.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3101f20e-ff9c-4e06-7c59-08dcd09c9e74
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info:
	BPQO0+sCf8n/hB7IyuKYgBnAat3R9duprlJ1PzK2clH1s8hHQcQh7CkTvNG9nsUcwIDYauVIFjQ3dJsvF8fo/6qqcJSL8agq6o3VIu8pe8X7DPiJzRwjNhycmXFpomm/jI+L0xozyTogygSCZa5mgHfjmCNDPEI584WnoWsuEklfSXMzeHdVtjcx4EGVVGlUdjhb36YNS/uJeB+MSmG/xaLZrRQOmBOj8eDQ3TltOcVdEt1ZKYpVLabfZd3lodZ/tIpWSuOH9kieZEQaDN6ObqybadkZjPsajEoSzqxLSbbUL5+bi99RtBj2kYOLrPneJLudlG5fAkCHhjgSdKp9sn7eooYbuNMxc/ptx77TNTrE9MP9w7TR+EZVeKgg65J8pt8FOZ5U4k59545BmzhZijpFTmk4c7/Z8pAd5n5ext5ccx4Gl0chxE8QaWI6uwKSjtl58hVd8KmCvjNKg6RJDF2Fidfyb7hadL9gIKqHg1lZWTE6wKoACwTxX2NG5pYhR2I3D7nJ4xfp66KNM2+xd0uAFFNovKfx2RU+vuUJW89G6EKOv2UzMwMPCsuBtlNtVy30nSqMh7Ha2ZpXj9UI/d92SiuMdlfeORYcoBz4J1lZglv2Ff0pB81hQknQ9t4F925HyQY00AGa3/xUBrgK6044yqEA9oJX4G+AOjiCdxjwAVrzZsHBgAAmyJrQgVMGOJrzz/tnPqLGJlspei/Rc4Ok79B/M6JbI6AC6k2VckrZ0g1j8Er6FZboHtJNKfMitstBm9kucB8yZXwhhrOc4af1rsSXlcTUKrU3UPooruXi90XhMEJNOr+H+hLlNSboCxaPLKFeLTPhFxZW+dxDcA==
X-Forefront-Antispam-Report:
	CIP:3.126.247.145;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jegw2.zeiss.com;PTR:ec2-3-126-247-145.eu-central-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: zeiss.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 06:57:09.9322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fffa80-c305-4775-9f2d-08dcd09ca028
X-MS-Exchange-CrossTenant-Id: 28042244-bb51-4cd6-8034-7776fa3703e8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=28042244-bb51-4cd6-8034-7776fa3703e8;Ip=[3.126.247.145];Helo=[jegw2.zeiss.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B99.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0965

Hi,

first, I want to explain why devicetree support for PCIe on x86 make sense =
and how I patched devicetree support on x86 for PCIe.

Why I require devicetree support?=20

I have a PCIe Card with an Ultrascale+ FPGA from AMD which has a PCIe Endpo=
int support. I implement in this example an GPIO and SPI interface on the F=
PGA.
For all this parts the Linux Kernel has drivers, but these drivers are only=
 supported with devicetree support (exception of SPI).=20
Simply I want to use the Linux Kernel eco system.

I enabled "CONFIG_OF_EARLY_FLATTREE" and "CONFIG_PCI_DYNAMIC_OF_NODES" to g=
et PCIe overlay support.
With the option of "CONFIG_OF_EARLY_FLATTREE" the file empty_root.dts is us=
ed for devicetree support. I patched a pci root-complex node in this file,=
=20
So that with option "CONFIG_PCI_DYNAMIC_OF_NODES" a PCIe tree is generated =
automatically.=20

I have to do some other parts in my driver see patch: https://patchwork.ozl=
abs.org/project/linux-pci/patch/20240430083730.134918-17-herve.codina@bootl=
in.com/#3311787

For your information I work on Kernel 6.10.

I wrote this message for people who needs devicetree support for PCIe cards=
 as well.
But the main reason is to get a real x86 devicetree interface into the Linu=
x Kernel.

Regards, Sebastian


// SPDX-License-Identifier: GPL-2.0
/dts-v1/;
/plugin/;

/ {
	fragment@0 {
		target-path=3D"";
		__overlay__ {
			#address-cells =3D <3>;
			#size-cells =3D <2>;

			interrupt-parent =3D <&pcie_user_intc>;

			pcie_user_intc: interrupt-controller {
				interrupt-controller;
				#address-cells =3D <0>;
				#interrupt-cells =3D <1>;
				xdma,num-intr-inputs =3D <16>;
			};

			pci-ep-bus@0 {
				compatible =3D "simple-bus";
				#address-cells =3D <1>;
				#size-cells =3D <1>;

				/*
				 * map @0x70900000 (256kB) to BAR0 (AXI)
				 * map @0x70940000 (64kB) to BAR1 (Config)
				 */
				ranges =3D <0x70900000 0x00 0x00 0x00 0x40000
				          0x70940000 0x01 0x00 0x00 0x1000>;

				axi_gpio: gpio@70920000 {
					compatible =3D "xlnx,xps-gpio-1.00.a";
					reg =3D <0x70920000 0x1000>;
					#gpio-cells =3D <2>;
					xlnx,all-inputs =3D <0x0>;
					xlnx,all-outputs =3D <0x0>;
					xlnx,dout-default =3D <0x0>;
					xlnx,gpio-width =3D <0x09>;
					xlnx,interrupt-present =3D <0x0>;
					xlnx,is-dual =3D <0x0>;
					xlnx,tri-default =3D <0xFFFFFFFF>;
				};

				axi_spi: spi@70909000 {
					#address-cells =3D <1>;
					#size-cells =3D <0>;
					bits-per-word =3D <8>;
					compatible =3D "xlnx,axi-quad-spi-3.2", "xlnx,xps-spi-2.00.a";
					fifo-size =3D <0>;
					interrupt-names =3D "spi_irq";
					interrupt-parent =3D <&pcie_user_intc>;
					interrupts =3D <2>;
					reg =3D <0x70909000 0x1000>;
					xlnx,num-ss-bits =3D <0x3>;
					xlnx,spi-mode =3D <0>;

					spidev0: spi@0 {
						compatible =3D "rohm,dh2228fv";  /* actually spidev for my_spi_dev */
						reg =3D <0>;
						spi-max-frequency =3D <100000>;
					};

					Spidev1: spi@1 {
						compatible =3D "rohm,dh2228fv";  /* actually spidev for my_spi_dev */
						reg =3D <1>;
						spi-max-frequency =3D <100000>;
					};
				};
			};
		};
	};
};




From 44453e0e471eec792602c8f08762d4ca0b9f7f73 Mon Sep 17 00:00:00 2001
From: Sebastian Suesens <sebastian.suesens@zeiss.com>
Date: Mon, 2 Sep 2024 09:33:11 +0200
Subject: [PATCH] patched file empty root with PCIe root complex node to get
 PCIe overlay support

---
 drivers/of/empty_root.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/of/empty_root.dts b/drivers/of/empty_root.dts
index cf9e97a60f48..212f375b712c 100644
--- a/drivers/of/empty_root.dts
+++ b/drivers/of/empty_root.dts
@@ -3,4 +3,10 @@
=20
 / {
=20
+	pci {
+		device_type =3D "pci";
+		bus-range =3D <0x00 0xff 0x01 0xff 0x02 0xff>;
+		ranges;
+	};
+
 };
--=20
2.34.1








