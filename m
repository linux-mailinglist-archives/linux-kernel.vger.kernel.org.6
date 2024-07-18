Return-Path: <linux-kernel+bounces-256032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7BD9347FC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D3A1F22F2F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 06:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F8D6A332;
	Thu, 18 Jul 2024 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C7Vso6pV"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015864D8D0;
	Thu, 18 Jul 2024 06:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721283735; cv=fail; b=M0UZHr+sItR0EOq8UU27YPbtJgxhsh/6/gnl1G4k3KqlbZVncsxIZhkEa4KUYe6IT9+12c4BljGWqY8L4rMzuLqfwHrA9rKZSFFPnNo5l214ROttWJiCGF7tiOLWRwU/A9vCBRLcKvKQwo2VDVJoABVsQN+MHC79Uh4MbSUo1lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721283735; c=relaxed/simple;
	bh=RpRZPFZ8/bCtV81VuJ9z8YWNRZkRS+PW+drcXOV4Cjs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pFizls+z2QJOx6z2fSBwt1qTbJVQvQQIWYunLErTbyvB4DzN86X7RHZ0L12KigZNN5pYuge3Ipo7wCYvBzzcXJdusCuadSNiwMrr/4Snc6ClNERi86g9Teu1n7xdNy1TA4FPDGWjBXlsrIsBN44oMpwRcQlvK8DivKXfpAxhUCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=C7Vso6pV; arc=fail smtp.client-ip=52.101.69.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5t0eo0af8T9Z/QNR7n4SSe/VkESDCFX7BqcDNxm3NZaGFX27PW1zzHy3HbTUpCobuu9Km/AZn7ZGoPpVdegyYhNZAvYkbos1Vf/xxYKLcg3b5RtO45u+2T7Hen4beAELO5mN84lFa7Cw1EH6gSbglvY3uFMvpbHC0Df5+4EB9hyIjUKq3ewj8L+klStr+Y2sVfrR/Af8HfdafRMg3xCwhyGOgV1lHdmQdLzPil1nzpqVWRrt85xyBydUPFyrbg+1DHKwrkmleU60wxpj3eY76oq+aJt4AD8w94PVaCcmgWZsKiLHO+V9LoyHoA9/bOLkFV62jRpfaBYCaLZB13Ukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpRZPFZ8/bCtV81VuJ9z8YWNRZkRS+PW+drcXOV4Cjs=;
 b=lk6a7pBcMTBeYB4fYiLOeYLMWoy/M8rcqFIfL9O7zfyseAhkvmwTHH9lmE0tLITTOSZSZ5lqQzl0CksCPwv1AQIktig7Ky5PeUrDAEabe6MXG9bVWqjU1no62jKsMcca1OuaEEnZi3dB8/3rnvEDeM8HCl37dBYmJvVAR+50zMOaPFhNi30zJRb5S4PmGaFr45S2Vb/XFeG6NzSaK6hjs9cHVGzLAy7H53JvvLk82BsgIylELtA6HwhtT30oaTraV1/4M+A3tpy4+v+l94HrNpm2BU9DBzUlBNPl51jsCf5WHvJCY1K8AUNEQGG829Pul6pXd9Ty+ypZjcDaSZ2IwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpRZPFZ8/bCtV81VuJ9z8YWNRZkRS+PW+drcXOV4Cjs=;
 b=C7Vso6pVEpdxNBHEY4MC0m0WHnGaf8kZoenmtzacySXzg+9XMmOS0g3k5iYb9u4R6osM+Or0tXR1Ik3BlJlZ1rCFjU0e1DpIwBqdA5gUOaWjQf95tyuG0LU1kwM0/VznL0izPQvab0i5kd800NhDq1QA/AiAHQcsxbX66U9LSrY=
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB11056.eurprd04.prod.outlook.com (2603:10a6:10:58c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 18 Jul
 2024 06:22:10 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7762.020; Thu, 18 Jul 2024
 06:22:10 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH V3 2/2] firmware: arm_scmi: set mailbox timeout value from
 device tree
Thread-Topic: [PATCH V3 2/2] firmware: arm_scmi: set mailbox timeout value
 from device tree
Thread-Index: AQHa0gh1nzSgPeT6CEaXte3Yk8eLv7H7zrKggAA/yoCAAAJK8A==
Date: Thu, 18 Jul 2024 06:22:09 +0000
Message-ID:
 <PAXPR04MB84594CFA6A0E3DE2A06729AD88AC2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240709140957.3171255-1-peng.fan@oss.nxp.com>
 <20240709140957.3171255-2-peng.fan@oss.nxp.com>
 <PAXPR04MB84594F4271F68D9072BA0C0D88AC2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <3c6bae57-9fad-4643-ad18-e964bca17b45@kernel.org>
In-Reply-To: <3c6bae57-9fad-4643-ad18-e964bca17b45@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU4PR04MB11056:EE_
x-ms-office365-filtering-correlation-id: 53cd3094-70c6-462a-62bf-08dca6f1f48e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bUpNRUg2czlIZFlyOFF5YmhQeGtrekxEU2Z5VGpYR1BheTQrekYzdTY2Rlpa?=
 =?utf-8?B?Z3RIcWdxZ2xXb2IrMS95VzRtRzd3VmFUU3ppazRPOVBPK2UxYlVsMVBhR2xK?=
 =?utf-8?B?dE5xYmtQUFdOZWhrVVRhRlVzamZGNGRiM0pZdDY2b0YweEsrWHdFbi9QaWxo?=
 =?utf-8?B?aU9CWmtweU5qSjUyMk5Qay9ZaXFPMmJTdGZzblNDVDFIZldNcnFGOUR0ekx1?=
 =?utf-8?B?OE9XUEIxSEI0MUppSGNMNXRwVlNDVWNXeGJXSy9KSDZqVFN0L1VMS2d3Q2tl?=
 =?utf-8?B?TVA0U0ZNSmhGbVYwNURQYjMyTXBEQXlRbFpOOGhQTVlrRjk5SmpLZVAyWnV6?=
 =?utf-8?B?N1VlODNmMXVPNkRCR3ZzUW50UGxWQ2hGUm9WbE5TNjlwbUZza0Z6dTdNV2Yr?=
 =?utf-8?B?ZHRibFAzNmtYZXZRZkVmeFc0eXk2N3RJVlJvUjRUUlVFb3dXNW1kTHZVM2U5?=
 =?utf-8?B?aFFBYjU0d2lETkJ6cUkrMUwwTUtJenk3TGNBcjdLK3VlMXc0M2JqRnlteEo2?=
 =?utf-8?B?Q1VPNnI1RWJwVFlqcGkvRzNXOXY4UmtzbU9pK2VTT1pEU3d2K291UE1vMzdr?=
 =?utf-8?B?SlhNczYyeEh0dE5rWWQ3TlB5Z2JCQ2oremdnVy9NbXRNY2U2WDJkTlp1M2cr?=
 =?utf-8?B?SkgvWUlpM1pOQmsyZEI1eGNjV3VSOVNWYnZuYTB1N3YwK1pEejlMZ0tObFF4?=
 =?utf-8?B?Z1ZtUDlHZk0rTklSRVMva1hPRnVoc1l6NSswUVF3UU9vMUNKTGhldW1aNUk0?=
 =?utf-8?B?cWtKdUJTS3IrTUw0aWorTTdSR3pxV3BDWnAvTkh5LzgzMUtJWnB5WDJLK2dv?=
 =?utf-8?B?TjBlTTZwa2JnS3diTnRrQzNaZzU1Y3FCeWFYYnNCbXFPV0NPWlRGR2dSbVQv?=
 =?utf-8?B?Vm0yTGJidjhGRVk4MFBLck00SlJxRnFoRTdDaUJ5eFJZQUoyWk9XQVh2Qk1V?=
 =?utf-8?B?cDRzUFRNUENkWHZ5KzdtRy9FSnJyYVQ3U1JXQ2tiTC82MkpUZTBCNlFLelRh?=
 =?utf-8?B?QityZXZNSCtwSVpUT1JSVVNLc1lYN1BtRmlLTjhERXAyd2RGREpNdzNlL1lw?=
 =?utf-8?B?R1hqU1pIemp5N2wrcG1TMGlKSlhCTEFpL1FjaHdJVXIybEd5LytRZXc1VTNO?=
 =?utf-8?B?RU1tK2pGeTVibnM1NytFUVVjVjJ6ZDZ3SDdteTAwMkxGWGJYeU5QMVJTWWRJ?=
 =?utf-8?B?QlhIbjFsVHY3Y0pYWGpVK2xjdjNNaG9HbTJxb3ZHZHJ4a0l1VHMzZEZVS2py?=
 =?utf-8?B?VWh5N0ZNV2pXU1RGTEdCRTR3b0pUSFRFSDh3TGpMS1EzSWhwWXIweHRoaXFu?=
 =?utf-8?B?Y0FZYjJHQ29HbnRLSDk4UlZadCtEcW5RTE9pd1hyL0k4OTVDejZsdi9nQldH?=
 =?utf-8?B?Z1JoVlc2c2FwQ0dXVVBGaGhIZjRWbUtSZXYvTjBmcVJVdDFtb3BQVFEyZkp0?=
 =?utf-8?B?eHNCcW91NXQvU28zYnRnaU5nL01uMWp2ek1keHVleXdlSmVYMmRBRzZZeXl2?=
 =?utf-8?B?N2ZYcHRkaFVGb2R6NHdUUEFMb0FMdVc1akJRM0g5eHd2QWw2ZUVnNXY4QlNQ?=
 =?utf-8?B?UFhiVEwrRVFCcDNkUlFLYVNCVGtUNDN0YWlNaGtKL2Z5WSt4cVdJc3AyZmVZ?=
 =?utf-8?B?bW9BaUI2cGFBQTB1VWlKS0YwcjhwQmVCaXBHVGRlTisxbCtTYU1TblpaWmZT?=
 =?utf-8?B?Ty9nMFlxekpXMTNzUzcvY05QbEYrK3VBY2g2ZFRYektJdXk5QzdUSTZ2UGJv?=
 =?utf-8?B?czZyTndRV1Bacm9QaUh4dncrVS9MVHlzcEhIZTUyVlVEM09BYTRPMlNKcEcw?=
 =?utf-8?B?dTNvdHg0OU5QeGV6ZlZaU3J0WEV5OWx5RDZHcHhWYTFuRVVzd0FIbmlYSFhE?=
 =?utf-8?B?ZjN0bGg1RktpSkhrYWNVbjVIcnc0NE43a2pTelo3eW1Zd1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGxiMVRKSEE3aCtQQjZBZlZGNC9MR2ZGR3k5WFUyV25ORGdoY1N1Z1o0eU4r?=
 =?utf-8?B?OWNCRkFSREtwcDlnYmVyWFVzRjVTRVNmOTFKYncvSTZDekNlZ0J4UFg2aW80?=
 =?utf-8?B?ZXZnM3pqbGhtTmNnSWdXajZrWkhHbHl6cFJtdjNwaFhjOEhUSTNqajkvaThx?=
 =?utf-8?B?L0tQSTQvck10dkMxQkJuM2xkZlgza1M0WGNzVGhTdVpiTG1LMGNIMEJFdUM5?=
 =?utf-8?B?bVZQK3BkanZpV1B0NXFNT0YvaHd4Q0tGWGRyaVBveFFMYzQzU1JRMHpvdHdu?=
 =?utf-8?B?QXlyVmFCb2FGTmQ1dVY3M3RidEpxMXMrTGdVdHoxRjBtMmpEa3EvVGRyZFJO?=
 =?utf-8?B?VVhQQWhLUGYwb1podXNmeTdiVUoyK0daZzJtNUxEOVlQdytKWUVlWWNRZ3Vv?=
 =?utf-8?B?aFk1RmU3RTJBWWs2TTVWeWxOTUJ3ekduVmNFMXVVNkVCY2ZxUmMwZ3ZyUndO?=
 =?utf-8?B?U3ZCb2NsM3h3WUdOVHNnSzgyVk0weDRZek03N01hRC8rWVRJOENNZXliOGVI?=
 =?utf-8?B?cnlsSW5nQ0F5d25FTWIxZ3hYWjRTMzBHbjI1eFU5dlpjN0UrZDNIWWY0VzAy?=
 =?utf-8?B?ZEZmeUFmdEw2Q3JnTWt4QitDS3pLY3hIQWZQVjNMS2NGZzIwL2JXWUhESExX?=
 =?utf-8?B?SDB4UllFeTcyQUU4MXNnQTR0dWhOa3FvMEVkaGFWTnVxYWRjNnQ2aFp0bWlM?=
 =?utf-8?B?blkzY0JHNC9NcFg3MXQvTUI4M2FzQkt1bVUrUG81cFlxbXMxRDVwNHRqOG5a?=
 =?utf-8?B?UFZMNWpqczBoYjVMeWRFTVF0b1pFb1gwb1J5dUhqL3JtVytZWk5sMXFEczJE?=
 =?utf-8?B?azFHamV3S0FQWExpL0VDTXVKWUN2Yy8yT2grWDZIZ0lUSlh3eVc4UGN2WEl3?=
 =?utf-8?B?Q0JpdCtBUXMxK0VhZm41REt5Mkk3MVIwQ2FkNVQ3cDJYaXV6SEZpTXgwdnBT?=
 =?utf-8?B?Sisya2ErNTNwNzFmUk5yRmhMaFR3akYvUUJhOFc4K0JueXdMSEt2Mkw0T1c5?=
 =?utf-8?B?NFdkOVQ4VDJVVlJLQ3VkMFU0NmVySjVObDFyZFNZT2pQdGNyS0kxSEJqUEQv?=
 =?utf-8?B?d1hFYzl3YVNUMGlnYTZvTkZOK2FSZk9zUmNOOXdrcGRQQ1NXUW9nbkdNNkRo?=
 =?utf-8?B?NXhaTS9RMzRYbUoyak8xcFNkbWQrSmQvWmF3dHJDU0dQK1c4TUhPenNVTWpV?=
 =?utf-8?B?VmZ0YWJwWlMrVythcHhFL09rZGVKbndsUnYvMU50MExXQnJqTHBpSnZZc1BX?=
 =?utf-8?B?cVc1U1FYQlU5d3hLckphVm5JRFQvbzJMb1lHSUlkVlJoMnNCa2UzMldIWVFy?=
 =?utf-8?B?cTlLYlJ0T3EvSldRV01ZaUNPWlY0dkI5clNrL0lqTjhHOWJrZlVOejU1WTRU?=
 =?utf-8?B?VmYvZVZ5WWVtTGo3VnRDcTliR1A4Mld2TURqdEY4THhTc0Zsdk9jVm1sYjdN?=
 =?utf-8?B?ZXFMMXRrVEVpWFE0WGxjb0t4Z2FFYWNKUzZMTkJ0aDUwRVRxV1N1K0dpcWd5?=
 =?utf-8?B?ZS8wcXJrcXhIR2pDWU16cjQxMkJiaHFQSnVHQXp6dWhaRUhqQ25QVTFwa1JX?=
 =?utf-8?B?T29WUU05eG9kZ21KTTlRN1ZxVmZabEFQQlhUVFZuSGhhelVCNGNtaW96ZXdn?=
 =?utf-8?B?bFlVc2wvaUI2enordjE5a1pGRzk1UVFkWHpVcEQ4SENmdnVnNmhDM3ZHV3pq?=
 =?utf-8?B?N0ZzNGp3RDRZalVXdDVVcE9mUFpabzRINDNwUTlUeGN4VTZBWWltazZubk94?=
 =?utf-8?B?YjJZMkx1eXlQMklUZC8yUlFUWVNQK2gzbmtTRzNTckVYb3Bmak92a1pqeHky?=
 =?utf-8?B?ZXFuajlyZm80OUwzYUt4SFdTQi9TSEFCY2U3MlU5Q0pIcExJUTJFSkpkVXRy?=
 =?utf-8?B?NWx1aVNCYk9VTytIWmdBWUxsMzd2ZzFRaGdkWU1URXAyU2VENCtMTHA1ZG9B?=
 =?utf-8?B?Zno5THlFN1pObG1xOUVvTFM0YWRXaXhZMEFTbnFuaXJzMWs3N0hMVkNSUXcx?=
 =?utf-8?B?b1F6aGdPbnArREllTlJCNkRCNVFERnYyY2V4L29ycjMwUjF2VmpPdFpqZEdE?=
 =?utf-8?B?SUdBTjBvMHNvMktReFFucnZLL2p5bHVLMFZsMEZTMm13SWQ1d3AxM0hWZnhY?=
 =?utf-8?Q?iYug=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cd3094-70c6-462a-62bf-08dca6f1f48e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 06:22:09.9971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3/YFFKD2hrFCOTKEZVHOX3yeOKbVVaCjHPT5I0ZybjR6K1qaDDUs+R4ZaI1sr6apIcvlpfU3jJRHXHiV3dLIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11056

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDIvMl0gZmlybXdhcmU6IGFybV9zY21pOiBzZXQgbWFp
bGJveCB0aW1lb3V0DQo+IHZhbHVlIGZyb20gZGV2aWNlIHRyZWUNCj4gDQo+IE9uIDE4LzA3LzIw
MjQgMDQ6MjQsIFBlbmcgRmFuIHdyb3RlOg0KPiA+IEhpIENyaXN0aWFuLA0KPiA+DQo+ID4+IFN1
YmplY3Q6IFtQQVRDSCBWMyAyLzJdIGZpcm13YXJlOiBhcm1fc2NtaTogc2V0IG1haWxib3ggdGlt
ZW91dA0KPiB2YWx1ZQ0KPiA+PiBmcm9tIGRldmljZSB0cmVlDQo+ID4NCj4gPiBUaGUgYmluZGlu
ZyBoYXMgZ290IFItYiBmcm9tIFJvYiwgd2lsbCB5b3UgcGljayB0aGlzIHBhdGNoIGluIHlvdXIN
Cj4gPiBuZXh0IFBhdGNoc2V0Pw0KPiANCj4gUGxlYXNlIGRvbid0IHBpbmcgZHVyaW5nIHRoZSBt
ZXJnZSB3aW5kb3cuIElzIHRoaXMgYSBmaXg/IFdoeSBzaGFsbCBpdA0KPiBiZSBwaWNrZWQgdXAg
ZHVyaW5nIG1lcmdlIHdpbmRvdz8NCg0KVGhpcyBpcyBub3QgdG8gYXNrIFN1ZGVlcCBmb3IgbWVy
Z2UuIENyaXN0aWFuIGlzIGRvaW5nIGEgcGF0Y2hzZXQNCmZvciBzY21pIHRyYW5zcG9ydCwgaGUg
c2FpZCBpZiB0aGUgYmluZGluZyBwYXRjaCAxIGdvdCBSLWIsIGhlIHdvdWxkIHRha2UNCnBhdGNo
IDIgaW50byBoaXMgc2NtaSB0cmFuc3BvcnQgcGF0Y2hzZXQgdG8gYXZvaWQgY29uZmxpY3QuDQoN
ClJlZ2FyZHMsDQpQZW5nLg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

