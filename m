Return-Path: <linux-kernel+bounces-305420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7962962E66
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C471F2325F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566AC1A4F1F;
	Wed, 28 Aug 2024 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VLlud/nZ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VLlud/nZ"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2056.outbound.protection.outlook.com [40.107.247.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FC336130
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.56
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724865987; cv=fail; b=D1oBaffZ4v4gljOrHrWZ9KLgjQTvLeo5bI3OonFQkRNm4kMY0MClky8J9wv2ELHG26QdgPorN/gLl6YHojejbEALWDDmuSanBpwLf4TDB2JHxRFVBlD/7fedBG7eUuOFmNhYfL6fb+3P9XJ3IKFkY6asmH1h7lQWDSfr5BTT4ZI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724865987; c=relaxed/simple;
	bh=WUYituZQ4iCG/TujtWd/K9z6GEbNzJvzaeSGDFbQxtU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P2ABacv13GhCG592g5RbjtaeshH2XNd5KvLY04YJ5zOk3cIY/oZR2ubAevGeUazKetrVbFF7xxKCL2hwQRuL5YNBWV5jyye8XZgKWxOHCJP1vMD0QtT4zfUK2oJyBNWun76P4rU+o4t6Hy2NX6NtO0F4BcXQH3wYkmPVUAYJWqY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VLlud/nZ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VLlud/nZ; arc=fail smtp.client-ip=40.107.247.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JR0xQwtPNlaF/hW3HTlSTyhmDmGDhyKkr8PwWkoA1Y8vUVhiApFjel/mz0YBJZ/BbrjDhkN6HNgeZo4hGHDHmFzHRjWoWUjlE87aZYFvqIXXARBuG3bixGuZaX+QWxwLR5DuTxTmWnaq7+1+SZfs7cqTH7DUF4DmJc4SV5imZme00z29GiGFKnoKd/qhUSR9VgeIfgXDQr0HTYEgv2pAinjKEm1Km4/nSGfHGo0+OlvQJOU0thhXfHa+ldTmo5Ub0UknUF6yCampyFTcUtvmiEhyy5javOgnMv0HWCR+CqSkJNwRPj+R98goUFElwlZNojg8BYI74/l7PfOj6WmLaA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ml9krNOY1z3lu2uy4dgfvpCfoKPiLSWDheMD1MelDPg=;
 b=Chs2ExOr+K1R9cOSjLtJRPElDD4NeANpsLpM0sV6kPhWkDyy3kY24o1CxRKbvTQZTINkQ0B2cKAuJenbYHMlgsKKJbKMXAEAjbxN8RrIOCxuzSYwnKqZzEDZL0wAmasv7sG4eeyuyEUTsg93/f6T5gKCrpvTYZMRDEj2qI1PHLfmQUXf4GyKwRxGnkKEFeHAIu+JcbKG2fltoALGKPHkRVA3wievTvSFe0jGAvr8egTbnVo5bWmfvEHipA7GkpU23u4tpmuSFuOhnIkFSOICe3tvSybu5SCoEtQb4V5rmDpA50AS5Wl1hXssTH1uPP/HOHZ/Rd5cwivGlZ1qLoIhXg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ml9krNOY1z3lu2uy4dgfvpCfoKPiLSWDheMD1MelDPg=;
 b=VLlud/nZe0uaQ0L2WMnOKXldTbhbGDmiH996cmBywqk2ItpA0JiAch6+g1dWwwsTXoEyZD5wWdCfXyS/WU2y0RU+Gtu+JWZ7D9M8zOgnZ9i/E6Uk5RzJFrgDYfjZVSF3OfvWYGjxQvI31i9xJcNVTOk0EC97qhIuOdAIEMhIAS8=
Received: from DUZPR01CA0176.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::12) by PA4PR08MB6270.eurprd08.prod.outlook.com
 (2603:10a6:102:f3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Wed, 28 Aug
 2024 17:26:19 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:4b3:cafe::c8) by DUZPR01CA0176.outlook.office365.com
 (2603:10a6:10:4b3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Wed, 28 Aug 2024 17:26:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13 via
 Frontend Transport; Wed, 28 Aug 2024 17:26:17 +0000
Received: ("Tessian outbound 7d86ec5dfeb5:v403"); Wed, 28 Aug 2024 17:26:17 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 749c5843b15c9026
X-CR-MTA-TID: 64aa7808
Received: from Ld778b74ff0d4.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2F828FFC-9A6C-431B-8699-757598A84704.1;
	Wed, 28 Aug 2024 17:26:10 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Ld778b74ff0d4.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 28 Aug 2024 17:26:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVMMg/yJeXqX8DGPS3gFPmzY9CL1szfhjHkLFZgEaMr71bEVNLQ4W7uoNnL80wSkjMBH2pO6xE8fVj9g7/UeApNTJ6Td12E7KCm1O7J6Eu+eGaSs8IRdMqUwWMyAMGDT7Prj32l3mQwK4j2i7G9IW1FiM4W0WSQ1BeGuDIG6472beYgPYq+YBwDtlbAqh+LuMwMexeU1tc4n/2PwoqcRCG/Eo+2ZCIrhDp99tgQdCrXYynw6zVvNPsbZIj0dz4+3NZ+e6NOtv0h7PnZJn8vgfV5wplGCvzZ8Ukdht8fYAlX1FW/2Xnfh1RKqsqMpf8R2wm9IztqBS27JpS17bw3GuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ml9krNOY1z3lu2uy4dgfvpCfoKPiLSWDheMD1MelDPg=;
 b=VWp+ycz1zm3lIzUbXjD5S7/kY/D96esaHbuU3oS8k0zWUqTsbZCglNArTvKDZfgks+DncP4XncGj+KIbl8YB8Ec5noM/VHr3kHfwa4HHTXvDFFqjtW9uPjQIgun2eI+0BufUVadL3wb7DrbAiYu+ZsoN4QG0sgmCnOeRXfR8wgNVppIT7PASrJVY/aZh5udukyWpwySm8n5zP7RgNuqiplsAXZ8t48BpvEvje0qS4yLTn11pN6ZPc9sWbUhXSwR0Ot3W3wgKuIZS28Y05PteXbBBSNltIk6ELXV7wQ5XpoGKsXbA+4P7GLlS+GMDX7/kEcAZrG639ZLEWpz2kvPXsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ml9krNOY1z3lu2uy4dgfvpCfoKPiLSWDheMD1MelDPg=;
 b=VLlud/nZe0uaQ0L2WMnOKXldTbhbGDmiH996cmBywqk2ItpA0JiAch6+g1dWwwsTXoEyZD5wWdCfXyS/WU2y0RU+Gtu+JWZ7D9M8zOgnZ9i/E6Uk5RzJFrgDYfjZVSF3OfvWYGjxQvI31i9xJcNVTOk0EC97qhIuOdAIEMhIAS8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com (2603:10a6:20b:290::9)
 by AS8PR08MB6551.eurprd08.prod.outlook.com (2603:10a6:20b:319::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.18; Wed, 28 Aug
 2024 17:26:08 +0000
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c]) by AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c%7]) with mapi id 15.20.7918.012; Wed, 28 Aug 2024
 17:26:08 +0000
From: Mihail Atanassov <mihail.atanassov@arm.com>
To: linux-kernel@vger.kernel.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Steven Price <steven.price@arm.com>
Cc: dri-devel@lists.freedesktop.org,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	Shashank Sharma <shashank.sharma@amd.com>,
	Ketil Johnsen <ketil.johnsen@arm.com>,
	Akash Goel <akash.goel@arm.com>,
	Mihail Atanassov <mihail.atanassov@arm.com>
Subject: [RFC PATCH 00/10] drm/panthor: Add user submission
Date: Wed, 28 Aug 2024 18:25:56 +0100
Message-ID: <20240828172605.19176-1-mihail.atanassov@arm.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0091.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::8) To AS8PR08MB6263.eurprd08.prod.outlook.com
 (2603:10a6:20b:290::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB6263:EE_|AS8PR08MB6551:EE_|DU6PEPF0000A7DF:EE_|PA4PR08MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: de8950b5-26a5-4b2e-57ab-08dcc78686c3
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?M1dBcWxJOEhzMHY4aDUzWjhrWTBmbjgwMjF5WVJTSHJ0eE5hTUhhR2ZBd1FB?=
 =?utf-8?B?RUlPZFpZOXdkWW9Ra01LL252UnVoNkVuUis1dEY2dFAyZTNrK3IrRC9YTGJ2?=
 =?utf-8?B?OW5VMW05UklHTC9KblNZMTVBdEhVd1IzeTM3VEV6b3AweFcrb2MvcEdRdXFP?=
 =?utf-8?B?OTdHaEpUV3JPZTdSa05rNW5KTElZQTZ4dWtMS3ZCVXVkM0RQYUxidjVuS3hL?=
 =?utf-8?B?NFRrRU52S3dOMkw0YjFuR0t0R0FWQVdEU1pDTnZNQTFWWlRKUzBraGZDc2dn?=
 =?utf-8?B?SjRDdlE4dGducmZrbDBlOGJna2kzaUlZVWdDTHZ2SHNaM0dpblM2TGZjQm1X?=
 =?utf-8?B?OEpaRDlFTGp4M1dxTnUwTWZWUEtNNjZ6NTJOT21ZYkxnNzh0Si9pMTNueWVx?=
 =?utf-8?B?dXJRakVUYUZMeUhZYjQ1NVQ1R0NWV0xPcTQ2SDd1WU52OXk0U2x5MzQ2L3VN?=
 =?utf-8?B?WWdHQUVWeFRWU0VHUDN0SmRZdEdvT0ZrbHlGYXRwTnljMXNMWGZaK3lId2J3?=
 =?utf-8?B?bEZydHFtN09oclFaazI4ejc4QkJSQ1ZRaDhMNGJRNENJVjJpckN2Q2ZhbkRU?=
 =?utf-8?B?OGRyandnZGdZcThRZ3NtQVlIcm42bEkxb3o0Z2JaZlJlRDZIcXQ3eVJrUzd0?=
 =?utf-8?B?aWJCeERBUXVqc3BJZFN3TXd3UGZrQ3JFQ2tQVzFZTHNzdFlrTjJuTk4wNHZO?=
 =?utf-8?B?OFphNFFOcytvNUJIMmJWaG0vZysrOTArTzIwcEZsR3JWU2JEM3hCc0lsT0pl?=
 =?utf-8?B?bDBVUzZnNnZMMjcyb1lZQVhVbnVaSENiRFR5QUlOMFFkZlUrd3FkaFZrNzJy?=
 =?utf-8?B?VXNtWktCLzFYWnd3NW0xTjN5M3d4Y0FVQ0QrMGcveVRqcXZmK0hOTVpSTzlJ?=
 =?utf-8?B?eW5ITzVIRWRObnBuQy9pcUJCQm52ZzEycUFIZkY3OFdmcS9ObzdxYm1LM0Fr?=
 =?utf-8?B?bHJYck5ZTVg0dWQ3S1lTVzNVcXl2L3MzRWJJN3hKN1VIb3Nlb2ZCcHBIZTdN?=
 =?utf-8?B?ZklPRkZodHhtVCs3UEVCajVKa2ZRUlJ1SGRxY3N3S00xVGFYM2psZXRGOS80?=
 =?utf-8?B?bTRCVGw5TVk2OW13eUVFRlMyZnZCd1M1TGw5QmtPVUU1RXNMZWtPYmZtUVd4?=
 =?utf-8?B?MGpraWJRaTJQTFhjOFBPd0szYVlPdi9yMmYxMzlSdmE2TEl2bmlqY21nMHlY?=
 =?utf-8?B?clBTLzZtR1FXSVBYS01nbnJzOUMvTUttR3hnRXM4SncxY0w4bERHcEw2dDhu?=
 =?utf-8?B?NmpUOEErZFhQOFpxYUtFWTVHd3A5VEJGQUxxL2o0eGtwVWFMaEczQktLOC8y?=
 =?utf-8?B?cnI0dlVkVlNLRWN6U0lEaGg4Q3pIakdkZ3cxZU82SE4xYXJiTWlJMXJpUkVi?=
 =?utf-8?B?TzBwWDhBUlpFckdnd3RNZnNTUVZGSnNNMGtZalJyWThCQkhLYk55YTI0VWV2?=
 =?utf-8?B?cmlCYlExL3hxQ2ZmN0ZycEpDeVd3TlJ4TGZJUUJ0RFMvMHZiWHgwRndVYTQ3?=
 =?utf-8?B?WEQ1eFJvaEFtQys3VUQ4WW5KYlhNVytTakZnSEE2c0JJdWxJS1ZIV1UrZkp1?=
 =?utf-8?B?cUFkaDU3NjR5RzR0azVaQktyQjBiUGFMajhFL2VYZlFadi9vcHhHcWdBVU9N?=
 =?utf-8?B?M0QwRk83ZHNTWlhBcFhCbVFPZWJIdzFWbkZESUlPemdPZ1k2RDBRRlNOdzVB?=
 =?utf-8?B?d2Z3dXU3MkZZVW5idWErUkl4eDNRSjdlTm0vQTRCbEtsRDJqdEhOdFVSbk9V?=
 =?utf-8?Q?9EoFSqq+wph5GeD5Ek=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6263.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6551
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:290::9];domain=AS8PR08MB6263.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f0b9c133-4b40-4654-78f6-08dcc78680fa
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azRITGdCYUJta25RQnlKZGdMaEdtZmY5eUJKVVhEM3d1d3BseHJlWWduay9S?=
 =?utf-8?B?STQvMFJhTmZUbm1Ib05ZVERhcjh2T1ppRjZ5VkhFd050TVpBWThsZ0oxWStL?=
 =?utf-8?B?SGlLcnorZW5BKzdCa3FRZG9PdzNzSmNjN3JCZHRWUkNKOHRyemduLzNQdTlm?=
 =?utf-8?B?NkFFSEdpektwdU5tZUZRQlUrditvU0dCNGF0N0p2V0FmUC9QaldNNy9tNDJD?=
 =?utf-8?B?Sys0WlpETXRBNkFpdk4ya25xcEVLYlp1YS9yRWxHY1ExME9QRzhhYlBrRTFt?=
 =?utf-8?B?bGR1dFFZbFg1alVpcUdkWmJURU5sMVNZTk1wZnNzWnJBdDVLZ2JqRWFxT2x4?=
 =?utf-8?B?dk1PMkp4dXY1eFk0R1VvUjFZSWRsWXVJZGE1NENNV2tBNlEwbmJRNzBCazhR?=
 =?utf-8?B?UzBoRlFPZWxmZ2g4ODA4Z0pjNFVjNnRNa0h0U0RKWnR2YWg0NzRlVk9CZ0Ey?=
 =?utf-8?B?eWZNYThURngwcExvK0xaaXVuT3l4cG5oejFxejZpK3BFK1M0NmpNZkJRVjRk?=
 =?utf-8?B?ajRvdEhZdy9Fb2JKSWtIcngzM3RIbWtsN3BGNjVRM3ZJNm9VdmV1TDhHZHJL?=
 =?utf-8?B?MUFGRFBRRGpObDhRQkRtSVJTT2FvdkJWVERQZXpCWDNSQk04QkVTSVgzUkY1?=
 =?utf-8?B?QWZyandDRTVYMnI5ZTNkYnRKcml4d0NEZ2IyNnVZaFFsZVRSTlduU2dwZlN6?=
 =?utf-8?B?NU5PbUQ2TDR5UE5saGFhbDJFZXhPbWRnTjVnSHFPVVdUaHA4SUZiWU1ZeUs0?=
 =?utf-8?B?UWJNOUxjZzlOcEhVb0tGNVhHUUVSbW5iVGxLTUtUcGs3Wk5RRk5QQVRWOWFK?=
 =?utf-8?B?WkFWbmp0a0t3VnQ0M1ZSaFJ2ZmF3bzJVUFlnbEthN2NjUXpaZzN3QTlHTENI?=
 =?utf-8?B?UENVbVNJODJRMTQwMzJxbE5ESVJqcDdHUW5QNEhzRHhPam1USWNjcEVDOTF3?=
 =?utf-8?B?MGtLMm9lSXMvTk5WR3BKWUVCSEtYb3pDOW1WUUFma01YUktHWkU3amFRclRK?=
 =?utf-8?B?U2dNU1NBcVdNa2pCTy85NlJhV3RnbXpBVnQ0S2orejZsb1dPblgrVjc1K2pE?=
 =?utf-8?B?bGkzZjlpd1kyaXYza2toR0RwS210WWQ4Rk13SFJwMGdhTGtGMTJhbE41TExy?=
 =?utf-8?B?SFR3dFVkNzFpUWZxL1lxTGNjcFlvMDYrVzhjNXZPTGJ6L0lmQ2ZoSjN5SThx?=
 =?utf-8?B?RkgxQW53dWJzL0dJckxmdG8vZXQ3YWhkQlkzWHJYeko0ZmtwbHZPUzBXQk5I?=
 =?utf-8?B?V0Rtdm5ydDBCeS90azhvTnRrQytpVUtjbnVjbEd6OGtLaUlpSjFvTENGbWNR?=
 =?utf-8?B?cW1RVG52ZHl6WnBEWktneVliRWlSbnRLS0wzZVNiejhtcGg4cmZ6N2cyU2VS?=
 =?utf-8?B?ZDFod0Y1ZjhmcWlNVHN5Ynl0MVB3T3hxKzlQR3E5bVBoVnk3L0dqQlBkenE5?=
 =?utf-8?B?QnJHS2JMNEhEL3E2YTdGQUlUSHNibGhKSC8rOWZUMGRMMUlCQ1pDS2h4M1JG?=
 =?utf-8?B?bE1JdzlmNmZzT2U2VG5FVU9tUldKVHovK2RqQ20zM3FVYXV4SGtORjhLa2FF?=
 =?utf-8?B?OWVyc04ySnMwK0wxRktjTGQ0MG0zVnJRRk41UWJBbUsvYkRicUxyTDhSaUpL?=
 =?utf-8?B?RWVJV0NGTWhWbmloaERXYVZmdk5rTkw0YmZjaENoNWZvb2l0SjVIQzZtcnVr?=
 =?utf-8?B?S0VBbTEycExnWW1QNStYQ1QrT0JNN0ZOMjNSQzV3M3d1TGREQ3Vac3VmTkN2?=
 =?utf-8?B?TjVnL0lEdENXdjZJQVh2VTRWd1NMYW9lRTBHNyt3NHYzME9qSjlnQ3NWL1Fs?=
 =?utf-8?B?M05lVVVhMHhuK1gyUnlxME1FTjFqQ1VWSHdId2xjc3c3MzVERjBGaGloK1pF?=
 =?utf-8?B?TGJjazd6N1A1aGRyRVEyOUptcEhKU01VeEJjUUJBY2FSVHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 17:26:17.9793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de8950b5-26a5-4b2e-57ab-08dcc78686c3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6270

Hello all,

This series implements a mechanism to expose Mali CSF GPUs' queue
ringbuffers directly to userspace, along with paraphernalia to allow
userspace to control job synchronisation between the CPU and GPU.

The goal of these changes is to allow userspace to control work
submission to the FW/HW directly without kernel intervention in the
common case, thereby reducing context switching overhead. It also allows
for greater flexibility in the way work is enqueued in the ringbufs.
For example, the current kernel submit path only supports indirect
calls, which is inefficient for small command buffers. Userspace can
also skip unnecessary sync operations.

This is still a work-in-progress, there's an outstanding issue with
multiple processes using different submission flows triggering
scheduling bugs (e.g. the same group getting scheduled twice), but we'd
love to gather some feedback on the suitability of the approach in
general and see if there's a clear path to merging something like this
eventually.

I've also CCd AMD maintainers because they have in the past done
something similar[1], in case they want to chime in.

There are two uses of this new uAPI in Mesa, one in gallium/panfrost
(link TBD), and one in panvk [2].

The Gallium implementation is a naïve change just to switch the
submission model and exercise the new kernel code, and we don't plan
on pursuing this at this time.

The panvk driver changes are, however, a better representation of the
intent behind this new uAPI, so please consider that as the reference
userspace. It is still very much also a work in progress.

 * patch 1 adds all the uAPI changes;
 * patch 2 implements the GROUP_CREATE ioctl changes necessary to expose
   the required objects to userspace;
 * patch 3 maps the doorbell pages, similarly to how the user I/O page is
   mapped;
 * patch 4 implements GROUP_KICK, which lets userspace request an
   inactive group to be scheduled on the GPU;
 * patches 5 & 6 implement XGS queues, a way for userspace to
   synchronise GPU queue progress with DRM syncobjs;
 * patches 7 & 8 add notification mechanisms for user & kernel to signal
   changes to native GPU syncobjs.

[1] https://lore.kernel.org/amd-gfx/CADnq5_N61q_o+5WYUZsZ=qu7VmeXTFHQSxLwTco05gLzHaiswA@mail.gmail.com/t/#m116a36a598d8fad1329e053974ad37a4dc0f28ed
[2] https://gitlab.freedesktop.org/larsivsi/mesa/-/commits/panvk-v10-usersubmit?ref_type=heads

Ketil Johnsen (7):
  drm/panthor: Add uAPI to submit from user space
  drm/panthor: Extend GROUP_CREATE for user submission
  drm/panthor: Map doorbell pages
  drm/panthor: Add GROUP_KICK ioctl
  drm/panthor: Factor out syncobj handling
  drm/panthor: Implement XGS queues
  drm/panthor: Add SYNC_UPDATE ioctl

Mihail Atanassov (1):
  drm/panthor: Add sync_update eventfd handling

 drivers/gpu/drm/panthor/Makefile          |   4 +-
 drivers/gpu/drm/panthor/panthor_device.c  |  66 ++-
 drivers/gpu/drm/panthor/panthor_device.h  |  35 +-
 drivers/gpu/drm/panthor/panthor_drv.c     | 233 +++++++-
 drivers/gpu/drm/panthor/panthor_fw.c      |   2 +-
 drivers/gpu/drm/panthor/panthor_sched.c   | 408 +++++++++-----
 drivers/gpu/drm/panthor/panthor_sched.h   |   8 +-
 drivers/gpu/drm/panthor/panthor_syncobj.c | 167 ++++++
 drivers/gpu/drm/panthor/panthor_syncobj.h |  27 +
 drivers/gpu/drm/panthor/panthor_xgs.c     | 638 ++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_xgs.h     |  42 ++
 include/uapi/drm/panthor_drm.h            | 243 +++++++-
 12 files changed, 1696 insertions(+), 177 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_syncobj.c
 create mode 100644 drivers/gpu/drm/panthor/panthor_syncobj.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_xgs.c
 create mode 100644 drivers/gpu/drm/panthor/panthor_xgs.h

-- 
2.45.0


