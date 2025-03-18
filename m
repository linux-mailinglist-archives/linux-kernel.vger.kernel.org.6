Return-Path: <linux-kernel+bounces-565544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22E8A66A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0621D1772A8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1011DE3D8;
	Tue, 18 Mar 2025 06:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="MZpCJ/nT"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2112.outbound.protection.outlook.com [40.107.21.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704974C6D;
	Tue, 18 Mar 2025 06:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742278904; cv=fail; b=O1WQ7ilB8YL4UtudGOjLOXMi9TrI9jZY9FWsfzwTcsKF9QZdnVcaK+GZZ74wBJ+spZQZsMOsGI+MY0a0Vy9+nkNTtWx2EnzbcjKTUTOoB2uR1Ys3tFvyI5p7sTZETqPmt81gI75gX9OBSjJv1LAsArFxxASwBZsBv30fr3dOGzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742278904; c=relaxed/simple;
	bh=Wd6SJsDn0Qq/bIcNr95dMxyRxkphU1n3Is4ktfhB3X8=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ew9tboELUIp065p/D++q9yTX5HRuB5BavTJvi+ov0jRYNuqJvgNynYyGpcX84W4yQdqZ10fhf4u0E54IaJLW7SFzK0K5UM5qDemroYFD78hxwJujk0OlDqmDoZTlupHqy1/lUL8fWM+fG3Q28f7XTrJdr5/JHSOfmMZ6RgN7lwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=MZpCJ/nT; arc=fail smtp.client-ip=40.107.21.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rw2dK+LmjT+gRKuJ0wFLEC52IWhqXC+6dFbWt76XwqlTYKBmf/4bCBmJPkq+MHwpif5XTHVeGUZOp/MCHjdEB/ljlPYRTU7RnfHg39dcQFXIGTUDyBV0E6lHos8+GsSrxullkScANZGBAGsWh/boyWlp/wFrJ54epQXKnlN8hip+qRyc1mon9ir6hAkGeNADUDLYimR+UWnfi4x5vlhKN4akl2Pfp4PwjZTy9jau8kDRcWCVyhCIb8FK1kXtZVdlhiXvfrGAZeFEm0kHv/n70IYsgYpzubDADRba0AV+pTdYrdEtALWzgdWCOSdDMCnB3HzkflGcEdOmHNpJ7uTE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fd6TDO56JuGrytWKgFjzQwIvh7VFd5wp8jVh8dKId90=;
 b=CXB63ZsvgdWgzNkqK44kujXIRhEeJJbqqNaT2ljqvhti1CJAibfP7FCSXuba/iMH5CT6oU9caRg6ojy8q60PcdhnmksPw0vKpX6qcfFkqfbv+iqmwoVmVkhYindqqKR1+yjAWUF71cUmNiXXdPfm6kRk3SRaVtfeot8UQiS840MUhbfynjyQaYmrjLda2Dt6PqHM9kkzWKbGCbjcNNnOjjHsjmRT7oY2CGNVyGVZeHr2cExJ9wAPUdxXIOpnUBzGqV+M1vHA8WG5/aGDszx3tS6tX35dFvuMwfPqM2fGr8+ewINzz8OLtxOb3APfFtx/GJOdjpVJh59AmuQQ7TfGDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=synopsys.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd6TDO56JuGrytWKgFjzQwIvh7VFd5wp8jVh8dKId90=;
 b=MZpCJ/nT2zldRORQAoMJD4+ZMKyGJXD0kj792M2p/qa895+leGn2aKCEpmW6gZqFVByI4n1tLQjdXz8l/YLCszFWGFbXHs2J77ts+NgU+e1WDLzXh2mj4C6WrCy1XzTkND8znUDNfl/WsEijGqc2s2RWW91gQjrb3bRuBQPETnolNPo76z0AzsnZtzbxzY0xrUcU6sAQ1EGwtPfMnNsin/nvdbb/ZUT58VcecI+qsspDITx67gWFUtCgyMSmGkutzPamOMyFIdbr832Hfyk/GZsZo7PQ9N0IMVoelazkdvs7aSDM/o0EcbzMujVBOW9FJ7flS6CKuFScHXfaHaIUFQ==
Received: from DU7PR01CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::15) by PAXPR04MB8368.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 06:21:34 +0000
Received: from DB5PEPF00014B96.eurprd02.prod.outlook.com
 (2603:10a6:10:50f:cafe::cc) by DU7PR01CA0012.outlook.office365.com
 (2603:10a6:10:50f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 06:21:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB5PEPF00014B96.mail.protection.outlook.com (10.167.8.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 06:21:33 +0000
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (104.47.30.109) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 18 Mar 2025 06:21:32 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PAXPR04MB8703.eurprd04.prod.outlook.com (2603:10a6:102:21e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 18 Mar
 2025 06:21:30 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 06:21:30 +0000
Message-ID: <a9812897-2c79-4a1c-9431-c6f184233a57@topic.nl>
Date: Tue, 18 Mar 2025 07:21:28 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] usb: dwc3: xilinx: Prevent spike in reset signal
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michal Simek <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.323aeebd-1577-4c21-85a6-ff9262fb6cb7@emailsignatures365.codetwo.com>
 <20250314155706.31058-1-mike.looijmans@topic.nl>
 <20250314211411.l5taj5nysvcalfyz@synopsys.com>
 <8ee2ce74-dc6b-463a-ba95-ad25669a1179@topic.nl>
 <20250318001211.tnjwfckt5j4fbvjf@synopsys.com>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <20250318001211.tnjwfckt5j4fbvjf@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4PR09CA0003.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::6) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|PAXPR04MB8703:EE_|DB5PEPF00014B96:EE_|PAXPR04MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: fa81a0b4-599a-4208-01e7-08dd65e52108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|52116014|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MWJCOUpKT05aaldvNEpDRUNabnVyc2UxRllBemZ2VjlXb2wrbSs2MytjL0pU?=
 =?utf-8?B?cDI2MmtwLzByZSt2YkRXNzVHcEUzR1hSZGtaTmNSYlRncC9xSXJLWFBXRitk?=
 =?utf-8?B?eEt2TStoUFcrYzdBZWxJTFB5SlVjeEwzU0c2NmozR1dKcXlvbTNGQWlhM2w0?=
 =?utf-8?B?ZFUxVzFheUlpQURyOHMzK1NPTHBmWlZZQkVzWE41M05ZeXZwTTBKOE1heTdr?=
 =?utf-8?B?MU50TlFjcWZhQ0VxbDFkQkoreVZYRnhOUHUwM25hZ0tlaFo2RE9TaktFc2px?=
 =?utf-8?B?WVpiVzBtaTNzVisxWk9CVmZmQjkvNU5EMmRjdTVKU3hQM1E1Q3pYOHJ3MUhZ?=
 =?utf-8?B?ckExMEowS1VISFlOTndsNVdYL1JqWkhrajIwWEo4WHRwWldxcHlxTklIejha?=
 =?utf-8?B?cGFvWTFCSGlDMjBuUG9DZEhzOTliWjB4dTVkQlozN1Bqd0dRS3ZrMDMzWXor?=
 =?utf-8?B?R2ZtYm9KNk53U0pLaWNmYmV6dlRLMWNLZ0lRSUNYTitIUmVZWWlKZ0UvSDVk?=
 =?utf-8?B?ZlhvdDM0Z2l1WHZoNjNQZUROYmdTUmJKVEhLV1JBempBWU4zUnlTU0ZOQUVa?=
 =?utf-8?B?ZUdVblp3RDZ4R2RrdmNEMDU0cmlldHRZbHU1SWVQRUpCc1ZBbzg5RHBoTnZG?=
 =?utf-8?B?V1Blck1GYmkzak84TFg5OXczTDd1bFMrRnBJY0FwZXpPelJ4UDJyZlE5Z000?=
 =?utf-8?B?WmVPaDRMK0JGc2pMeU5hSk54WUlzZngzemRWVTJyOHpWSFZlZFZBRFdzdmVG?=
 =?utf-8?B?RmlHc0Q0c3o3UGpwazYrd3g3STRXOXlaK0h4RllSSE9lZWt4QUdNVTJ2UjJv?=
 =?utf-8?B?TWE2QXQyZ1JnZ3dLd0VyUG9zUzJTM04xSUxHMnlUTTAwYW9MKzFCQmV3dFBk?=
 =?utf-8?B?ZTFtbUZ5Y1Y3bWVpTVN2eCtqV2NiMVF3RTdtZnc4U1kwbUdWbDNJN05NWFZs?=
 =?utf-8?B?M1BHa3lwR0tUYlpYNmYyNnZ1YlVZOE9pRkgxOUx6YmZ3RGlQeG43OUJ0UVI4?=
 =?utf-8?B?YVhNUElsNWhQdDJRanAzcXhkSW9RQzFpWG5IUkxnTE9LTzlETzltZDc2UkpE?=
 =?utf-8?B?ZXE0YTZteTAyTGpoMENZR3dMazRLV2NSVTNWdTRFZTF5N3h6dG40L0YxWCtq?=
 =?utf-8?B?eEcxbGV0bFA3U3VMUEY2NGh3U0RpZ2dYOGVvWXd3UVltemRsbGNCcnBJd2Jt?=
 =?utf-8?B?aFBCUFRxY2h1ZXJqMkJHNlQvc0xYcGZKZ3dIYW1US0d3dTYvdTlTMnM0Y1Fu?=
 =?utf-8?B?dnV2ekplTmd1clIzK2NoczhyK2s1eVVvY1pZbmpaMmlqOFhzSkFzdHZ3Q2Nv?=
 =?utf-8?B?YXg1Y1dSZENQUk9OT245NjJMUTZSU2tvbU16TDRraEhCdHlUMFFLalFpaFlQ?=
 =?utf-8?B?RmhJaEtFY0pTL0kxMmt5cUJ2N2VDaHgrbWFLRUxQa1h1dUxZTFJIQ1BXNjFq?=
 =?utf-8?B?LysvckxRQUdPcER3cGYrZ3kzYmYzY0pUMytQSkU5bWwvT1duRFlpZ3JZSFk0?=
 =?utf-8?B?RjBZM3ppK3FtUDY5eE9nUWd5M2ptSVk3MUxpUDl4YUdYNi9TUnFPKzUxeHFT?=
 =?utf-8?B?aUxEc3NZaEFNTWNxdUgrYmJLQURrN1BRUEFITC9Ld2tTeG9SeHF4NU4rMlhD?=
 =?utf-8?B?SFc3SG9hS1hCN0JrN2JYa3hXOVNObWNOa1MwZUZmVnNIRmZseHdsei9oUkJW?=
 =?utf-8?B?ZjVyTEIrZWpTOWppbG94cGdEVVQ2aXd6VGd6Z3FIaTNqQ01QM09RWTFrdGx2?=
 =?utf-8?B?clcwSjh1VDlpWGd3WEc4cnVMbnh3VnhPQzYzb1RNb0Z1Z2pLU2dod3ExRWhE?=
 =?utf-8?B?QzhDK0p1Y2JJa3ZPdWJYT0wxMSsxSXlTM3BPdjZMa1QxZWNUUVNES3o2VllI?=
 =?utf-8?Q?NQFQQxMbwK795?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(13003099007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8703
X-CodeTwo-MessageID: 78cf08d5-7ef5-415c-95b3-2e8096a2e154.20250318062132@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B96.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5b04af62-c2e7-43bc-ae34-08dd65e51ee5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|36860700013|82310400026|376014|35042699022|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkhtcHU2S04wNGRuRURGTzE1TkpVdXpIVFh2TnBENlVDRVRkYzM5NzB3K2Iy?=
 =?utf-8?B?bEpXNU45Z0l2Um1jUzhuWU9scS83N09kc2lOMlFncEtXQVNsT2pLVmV5aFgz?=
 =?utf-8?B?VFYzbmNJSkdMTmxiQzhUSnZ1VWloWjlPOWU4RzE1TjFJQVg1QzZuV1E4Szd1?=
 =?utf-8?B?VVBhR0MvNlNDSmYvaHpCYlUybE90V1VORWVjTXlsaHZYZUZ6STF2SFpwdEJU?=
 =?utf-8?B?bVN0M1UyV2IyVzR5WWFJT0RzRi9YNEZMdkFQYjlCbVE5VDFMamV2ZTB5SUZk?=
 =?utf-8?B?ajViNkNnTGtYZ1MrQk96OFU4TEs5TnJlak1NWXNOeVNtQzR4Si85dGtscVIv?=
 =?utf-8?B?Rk8yeGVKRFZXU25ZU2NUUFRCQms3ai9MNTZyUWdyYjQ2MkNPOUhsWHJHbE1G?=
 =?utf-8?B?MDZjRjRpQnZja0Z6SGwyNmtmSnArM0x5QXo0WEtiMWxjeE5CM2Y2bkNoM1pP?=
 =?utf-8?B?MUJWZTJpRmdKa0hKa2tFa202RXplSFRvOE9yM3hYb3FpajJ4V3h6akV6ZEVx?=
 =?utf-8?B?UE5jWThJUXBvNy9QZ2pKRWlIdUtQd1FtS2xlY21OL3V6UG9rMHNMSXZqci9R?=
 =?utf-8?B?N0xwTVZKQ0FpS3BxTjBIWEZPeG9lYnZmWk5Qb3o1ZHEyWVhpMFVGVW9JYmtX?=
 =?utf-8?B?NGtjVzRob1BkdUR3V3dMUDd1WEcyM1pqbUtXZmdsdkNieXhXdnpoem5QSGhM?=
 =?utf-8?B?NGtnNGdySDhGejVONGpLWURvUjZ2QjBBM2YzVlZHa0NHN3BkaTdWZUg2THVE?=
 =?utf-8?B?Y1RVcGx3UWRTUTBydDl4bmFKWDRDc1hxZWZNTW5lbEhXM3ZlMnRxTTE5c0Z6?=
 =?utf-8?B?MU4yRGJOME9jaHZDdVQxNnQ2bk5pR0EvcWRzUmF5bkVKS05rbkhPU3psalBQ?=
 =?utf-8?B?YzJTRzhXVTlNWlVlR2hnNXIrNHhFc3hNSlJYVXRNS1dWSjJuQWdhb1JrQW9q?=
 =?utf-8?B?RGZVbVY5dWdOY3g3Z1NIbnpEUC9WYklrSCtDd1VNSU9vOFFHRVdDMytJTW8w?=
 =?utf-8?B?L1oyT2crTjkxRGhLNFczUlBYZmhVc3oyeGVLeUV2eDgwc1N1SUtQdnZrS1Q3?=
 =?utf-8?B?TTBsMFhqT3AvR1ZQdXNlOU9rZkpsN1VzQjZnSGx4VGo1UGhJTXBDYThVMGNN?=
 =?utf-8?B?NkZuRkEwdDR5QzBENldwR1NzMitnSnBvQzkrc2lJQzlNT1loSlR0NzZjMWty?=
 =?utf-8?B?RlN4L2hYWFhxcnowVjZWb2N5MTRtcXFtbjU1SE5CdTlRWWRVVTVKYjI4VWtF?=
 =?utf-8?B?NHZQdTR2czZ5TklHVytNT2JDM1VSVEdNazBKS0RWd0JFTEt1dVBjbmUzMGRw?=
 =?utf-8?B?MlhteThaaU9RVmpmSU1PUUlSaGFxcTRXaEJnK3p0Rm5kcXBzQ3BKVkpnLzMv?=
 =?utf-8?B?ajhwWHB1NHplSEZ4cWUrT3dGRXFtV09VQUUxVVBnTFhSTk5JNU8zNmJjdElM?=
 =?utf-8?B?WWpwcEE4Y1c5SDBsZVljVjk4UDV6d1dST20yekFRVkpZWlRPNHA2MEk3N0Z5?=
 =?utf-8?B?M2tXa25CVHJjalpFaUZMcjJvMVowcTV2ajYrR0RWUExJYklOblcrVnE4NzZm?=
 =?utf-8?B?SVdnc0Urc2lwcVZnQkkvSVhJbFpna3ZLT1V1RWVZcFIybC9hMnE2TThxbTdN?=
 =?utf-8?B?VUROZ256ckx2d1RNYnMrVDBFbUhlODNHM1Z3OENudE9PVlBlYjBjSCtrNEhn?=
 =?utf-8?B?bmR1QTJranhpMWxibkxpQ2hIZnYzT2l0U2VXcUdHK240c3lJb043RnlxRHhD?=
 =?utf-8?B?Z2FWR210SnhhWlRTZ3FBUHltTkQ1MFhpYnhXRUVaQnFHb2tna3BIMnpWTUpv?=
 =?utf-8?B?bVRiMXpnaG4rSzhZaW8xVHpDY0NlaHNZRnlieHpuUGIvanRkOUFqM1RBWU5K?=
 =?utf-8?B?ZHJlU2NwQkJIQnhxWVFZQW85UkJTdC9FcUxnOC9NTW5Zdm5BU2Q0UjJYMi9N?=
 =?utf-8?Q?Xwn2Gj3EWvY=3D?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(36860700013)(82310400026)(376014)(35042699022)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 06:21:33.1473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa81a0b4-599a-4208-01e7-08dd65e52108
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B96.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8368

On 18-03-2025 01:12, Thinh Nguyen wrote:
> On Mon, Mar 17, 2025, Mike Looijmans wrote:
>> On 14-03-2025 22:14, Thinh Nguyen wrote:
>>> On Fri, Mar 14, 2025, Mike Looijmans wrote:
>>>> Set the gpio to "high" on acquisition, instead of acquiring it in low
>>>> state and then immediately setting it high again. This prevents a
>>>> short "spike" on the reset signal.
>>> How does this affect the current programming flow beside preventing a
>>> spike to the reset signal?
>> I don't understand your question. What "programming flow" are you referr=
ing
>> to?
> It's not obvious to me if this is an error in Xilinx documentation, the
> driver issue, or whether this is found through experiment. Since I don't
> have the info of this platform, it would help to know where the source
> of error is so we can document this in the code or change-log.

It's a bug in the driver, found through code inspection.

The reset GPIO here is to control the reset signal to an external,=20
usually ULPI PHY, chip. This external chip is not part of the Xilinx=20
hardware.

>> The reset sequence was just plain wrong, the issue is almost the same as=
 the
> Do we need a fix tag and add to stable then?

That would be appropriate I think.


>
>> one described in this commit:
>> e0183b974d30 "net: mdiobus: Prevent spike on MDIO bus reset signal"
>>
>> Note that I see this high-low-high-low double reset toggle in many Xilin=
x
>> software drivers, they seem to teach that at the Xilinx academy or so.
>>
>>
>>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>>> ---
>>>>
>>>>    drivers/usb/dwc3/dwc3-xilinx.c | 3 +--
>>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xi=
linx.c
>>>> index a33a42ba0249..a159a511483b 100644
>>>> --- a/drivers/usb/dwc3/dwc3-xilinx.c
>>>> +++ b/drivers/usb/dwc3/dwc3-xilinx.c
>>>> @@ -207,7 +207,7 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx =
*priv_data)
>>>>    skip_usb3_phy:
>>>>    	/* ulpi reset via gpio-modepin or gpio-framework driver */
>>>> -	reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
>>>> +	reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH)=
;
>>>>    	if (IS_ERR(reset_gpio)) {
>>>>    		return dev_err_probe(dev, PTR_ERR(reset_gpio),
>>>>    				     "Failed to request reset GPIO\n");
>>>> @@ -215,7 +215,6 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx =
*priv_data)
>>>>    	if (reset_gpio) {
>>>>    		/* Toggle ulpi to reset the phy. */
>>> Does the comment above still apply?
>> Now you mention it, the comment never made any sense anyway.
>>
> Then can we remove it?

Removing would be better, yes. I'll make a v2 patch.


>>>> -		gpiod_set_value_cansleep(reset_gpio, 1);
>>>>    		usleep_range(5000, 10000);
>>> Do we still need this usleep_range here?
>> Yes, this is the "reset active" time.
>>
> But why do we need 2 calls to usleep_range? From just looking at this
> here, it appears that the first was intended for the removed
> gpiod_set_value_cansleep(reset_gpio, 1). If this "reset active" time is
> needed irrespective of the existent reset_gpio, then shouldn't it be set
> outside of this if statement?

It helps to see the whole thing instead of just the patch.

If I omit error handling and comments then the original code reads:

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset_gpio =3D devm_gpiod_get_o=
ptional(dev, "reset", GPIOD_OUT_LOW);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (reset_gpio) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 gpiod_set_value_cansleep(reset_gpio, 1);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 usleep_range(5000, 10000);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 gpiod_set_value_cansleep(reset_gpio, 0);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 usleep_range(5000, 10000);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }

So the gpio is acquired in a LOW state and then, without delay, is set=20
to a high state again. This causes the "spike" I'm mentioning here. The=20
correct procedure is to acquire it in the HIGH state immediately, so the=20
sequence becomes:

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset_gpio =3D devm_gpiod_get_o=
ptional(dev, "reset", GPIOD_OUT_HIGH);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (reset_gpio) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 usleep_range(5000, 10000);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 gpiod_set_value_cansleep(reset_gpio, 0);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 usleep_range(5000, 10000);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }

This patch does exactly that.


> BR,
> Thinh
>
>>
>>> BR,
>>> Thinh
>>>
>>>>    		gpiod_set_value_cansleep(reset_gpio, 0);
>>>>    		usleep_range(5000, 10000);
>>>> --=20
>>>> 2.43.0
>>>>
>>>>
>>>> Met vriendelijke groet / kind regards,
>>>>
>>>> Mike Looijmans
>>>>
>>>>
>> --=20
>> Mike Looijmans
>> System Expert
>>
>> TOPIC Embedded Products B.V.
>> Materiaalweg 4, 5681 RJ Best
>> The Netherlands
>>
>> T: +31 (0) 499 33 69 69
>> E: mike.looijmans@topic.nl
>> W: https://urldefense.com/v3/__http://www.topic.nl__;!!A4F2R9G_pg!e45B0w=
D5dvB4NV8gz5JjIWaRTQrX9M2uE0ouoBVX4TQC8sKqtYRL8rJY3y2bb061gzSoGL0FOPJv-3-ad=
kP1b3ldzRZnxdY$
>>
>>

--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




