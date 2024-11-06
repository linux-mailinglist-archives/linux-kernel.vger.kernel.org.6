Return-Path: <linux-kernel+bounces-398610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DBF9BF394
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D781C21D5E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BD9201115;
	Wed,  6 Nov 2024 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ha9MMNcw"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011063.outbound.protection.outlook.com [52.101.65.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C230E1DFE33
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730911711; cv=fail; b=jH4SUGc0R1b2OG4yBT2FQiLlZa1LhCUIJ8MeskEbSmdvw061NAP06+n76wWTqhHm61eu0cf8cXRMrd8OYkXnVcC7k9eOgpWFTKVB2y5XYUvr77LWISJRSxu88xph+lm6qHlXInvZzZNzSZw6bOOzNh/nHc+7NUsLsw/Eppftj1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730911711; c=relaxed/simple;
	bh=GwUHhzwMtKD5uPVG9ifWaYMIfHBhufJ+VnE5lfepJhI=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QzYxtaYTuaKUYkhLnLz2qSGTKOE8FUGoAokgFw80EsTsX3hCHoU9Qq2k4ajsb1CzeOGY25HJaWlznfJNTK5QA/gP1TFt55a/4NlUSX29IYrDb+fqIoOEHqbqFLNrMRkYj5wJgDt7nTAhOQDXHiW3k+OUEPtggJ8F/jabEzOcuu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ha9MMNcw; arc=fail smtp.client-ip=52.101.65.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVG9qn5u8D7b8VOxx7Lk4y2DQF19CagxIfzT0YXbZHP0HV0LdqXf8UH4v6Hl720Jwh4GeG8+1kQs5k7xIgOt0y4k5k/XM10+2GPZpdSuPqw7o0qV02zkA7jYgCF3RSyLMcgn3Jg3Tt63kdz5r42bag4tWB8nfQVpjhH0kQegkSKO5fepEaktfC6ElXSEXJhSWjvxxljsP0+xdEzQ979n8cwJawks/JEVcOie68b/ldrONOqZ1NzkOoRD9eZcyZt59vFTsB9kQ9qrbdH37Ww0BN/6NQICFCcg7JiEMJhk2RtZ7QflXjb5iHmRm1ikTnLEfMDTBDGXzHFabLXi6mx1wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6d+SQNSFeCVTazYEjOpq4fAzrai47BD/wMkPD1t5ols=;
 b=MXhus4URmlcRkMUG5US0w/ynJ0mpuD2nHEYv6gCSCBIiGTUZxaE+v4ZC3EL2wiv53+71gCgm86TNvVPSbsPViZwGesecN/FkjwqKAQ21B+n+xCIGCs/XNvstWZGAShkmgJXosnSMwtHNZ0cd2YAwJxRvmW+zihqm+UVmlYLJPCWcOir7m8eIC7zGtTPRqXzZ5kcGi7FMGr6TTB9HHb2EPdOHpXn661RSJ1chxVj/T7KMljriNYAOL34BTmAT5F75dXjJMLNg/+ezSywCypRBoHn+rk33WRNMOA59giHuPCh83wSL8kgTrG7i3ZgaLXObaHfkpQa5sQgWgSHaPcee0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6d+SQNSFeCVTazYEjOpq4fAzrai47BD/wMkPD1t5ols=;
 b=ha9MMNcwJKc4oKFIzLs5gp6+/P7uR1DCNl4MVadH1nInHgwMS+AMXAI1KXiAugS+EFeZK2GBnfzqiq1mD8MlVIWsSZeBSkjpMks1lwx7oD97YQK2Yp2Cl0e3kfF8kd3gH7ftednEdJiySDCodnJNXUmj/caeTIBr2ogA+TCmlvg=
Received: from DU6P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::17)
 by GV1PR02MB8609.eurprd02.prod.outlook.com (2603:10a6:150:96::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 16:48:22 +0000
Received: from DU2PEPF0001E9C3.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::ef) by DU6P191CA0023.outlook.office365.com
 (2603:10a6:10:540::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Wed, 6 Nov 2024 16:48:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF0001E9C3.mail.protection.outlook.com (10.167.8.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 16:48:22 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 17:48:17 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Zhihao Cheng <chengzhihao1@huawei.com>
CC: Richard Weinberger <richard@nod.at>, <kernel@axis.com>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ubifs: Move update of cnt in get_znodes_to_commit
In-Reply-To: <4751d3df-99a6-ec67-1175-ea5375290726@huawei.com> (Zhihao Cheng's
	message of "Fri, 18 Oct 2024 09:24:03 +0800")
References: <ebf1570e3d28462a97b1a595794e1969a4c27d81.1729191143.git.waqar.hameed@axis.com>
	<4751d3df-99a6-ec67-1175-ea5375290726@huawei.com>
Date: Wed, 6 Nov 2024 17:48:17 +0100
Message-ID: <pndo72s2tri.fsf@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C3:EE_|GV1PR02MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1585bd-2872-4600-d03f-08dcfe82d33c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUgxdjRuUGYyUUlTTlNCZVNGTW9JeW1scGVSYVREU2JPKzcraXAxVGMvZEsr?=
 =?utf-8?B?MEEzRk52UU5VKyttdUEybVlLVDZlWHNseEo5YjRkNlVFbGFzcXlDTHgzS1NT?=
 =?utf-8?B?aHIyYzJkbldUWkVwUDNISDkwMW5rYXBFMlpZZk14ZWFmWjdLc05BajcrM2Rs?=
 =?utf-8?B?b2YvQmFmeEpEUHpPV09iNTNoMVBsRnRNSDZBSXUwMGo1MTFkd0NUMTJpeEdK?=
 =?utf-8?B?QXdKVDRIU1NHREdGRzdqYUx1RVB4c1lyNGEwSFZWcFZtVW55WGdZc21RNk16?=
 =?utf-8?B?d2t6bzFPancrbGZYWEh4a29vb2hQUGVrdUR0U2RLMlpHYW00MXA1SUVHeHpD?=
 =?utf-8?B?bTlWNnp1ay95QXg3YW5oZU83ZzZQVi9kampHVXIxWmZOK2RLQzNzZ3ZTdFVt?=
 =?utf-8?B?VUVjcW91c3FUdGZvNTRWaGRUdFZnOVRDaEp2V21BenZkMnJjZHpmL2liQ05S?=
 =?utf-8?B?eXk2eENKQ2tpSjg2aGtzdWZuK0svZUh0U1ZsYi9yakRqTjA3WUhmS2ZLM3d4?=
 =?utf-8?B?RjBueUdJY2NwTTVvZzBhV01QVlljeXZGZ1B2VG9pK25ObE50Z2ZHbFFrOEhm?=
 =?utf-8?B?Uk5aOWlMTkswcTBGNzAyRGxiWmNpNlJFOFlIWHBuSkozMUovVGN2QzFRNllh?=
 =?utf-8?B?VG40SjduTVNrWnVYN2NxbDdNOGEwL0VZQlJodm5idHRCb1dMSldneWdpQXN0?=
 =?utf-8?B?OGVSZlFKUHhHTXVaMDlkQURZWGNjRnlYTDZKQzBCY0EveUVXUnA2a2hkcmhR?=
 =?utf-8?B?NWVsdXM0R2RiSzlWcWNHc3gyWUQ2ZjB4QStyL0ZrakgweU1HTm0rN1NkdUc1?=
 =?utf-8?B?N0NOV3RsbmVVNVo1dFkzN2xNNkphUnJVazEya1g0UllmYnhpTVFBQ2VuMkNs?=
 =?utf-8?B?dzVIdnVhMXRZVmxobXA5Mk92U3Jodk1DSVluNVF2N0I5OTAvZ3J5dzM2MGVO?=
 =?utf-8?B?MllXRTF3Q0l2WlN5ay9ha1RWWCsrTHJwditzNXZPNmxRaytlNFNQODlqSGtj?=
 =?utf-8?B?ZnhnL3gwK2Q1MWNBR3NOZjNtU2hzV3NEdW9iMlovUlNueTRQZXlvZmRmbmJh?=
 =?utf-8?B?aXplUXM0aXVTdVJGTUNoWU41ZEdNb3Z0KzRjeXl6c3czcG1IVGVSNTZiYVp3?=
 =?utf-8?B?bGNQVmFva3Bvbzc4YmY0THdOdklHUjdtT3VrVTBqaXhxL1o5VDlMN2VuNkFO?=
 =?utf-8?B?NDNqOEpGYjF5Q1E1OXhjNVlIZUhDc0pWTm5qdVpmYVY0V1Z0Z09aVXV4UFdy?=
 =?utf-8?B?eExZT05tcmVxMGpPZG9kWFRqTWxyTGFpRG5HVTIwNUhjTk0rcFIvZjJra2w2?=
 =?utf-8?B?TU51c3o2bmg4bDVXaUR1WTM1V3BnVjhsMmtQVnVzV2FWWExyY1lqdWJEYXQw?=
 =?utf-8?B?dzVsYjZmNTVGaHgwR1BscjRiRko0NDFYK2F6TkJ2MjFnZGRkbFRKS0YvbzU4?=
 =?utf-8?B?eWlTbUxaYnRjWFoyMlNIcFNBdHBBRWlOUUMxWFlmbGRPRE11RmNCSVFLOHJO?=
 =?utf-8?B?R1BndGllUnp5bTAwKzBobGFIWTZnNkt4RTI0aHJ3eUkvdEMyZHZGcWMya080?=
 =?utf-8?B?YWVWQ1lUS2dhc0dMVkJzdHFMR2NVeFVLOGVKeUwycE9zbFUxTHRhdTAzZVlR?=
 =?utf-8?B?Q281U2g4b3VnLytCODJvd3MvVjJ4dGxMbEw4MThRVzhaZGFGRklUOG1NNGh0?=
 =?utf-8?B?R3Y4MFloRnJyOUFaTHpjbUJ2WG9aQ3ZwL2huc3J2eVBsbWgyUUp2U01OeEdQ?=
 =?utf-8?B?clFVdFBNVHlXRm1uUFcrWENpVkhoN0ErSjBaOGtLMVdoR1JPUVcrdWJTYUNY?=
 =?utf-8?B?Q2xEalZkK0ZSV3BhaC9RdC9zWklmTXE1SndNQXJPTDBZTUFwelNzWUdyTHdD?=
 =?utf-8?B?VGJNeGRVckEyZDRYY0FHQ29BNTBROFBCemZCL0RHU0dHaWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 16:48:22.2324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1585bd-2872-4600-d03f-08dcfe82d33c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8609

On Fri, Oct 18, 2024 at 09:24 +0800 Zhihao Cheng <chengzhihao1@huawei.com> =
wrote:

> =E5=9C=A8 2024/10/18 2:41, Waqar Hameed =E5=86=99=E9=81=93:
>> There is no need to update `cnt` for the first dirty node just before
>> the loop, and then again update it at the end of each iteration for the
>> next dirty nodes. Just update `cnt` at the beginning of each iteration
>> instead. This way, the first iteration will count the first dirty node
>> and any subsequent iterations will count the next dirty nodes.
>
> Well, from my own view, I prefer the orignal style because it looks more
> readable.
>   c->cnext =3D find_first_dirty(c->zroot.znode);
>   znode =3D c->enext =3D c->cnext;
>   cnt +=3D 1;  // We get the first one.
>
>   while (1) {
>     cnext =3D find_next_dirty(znode);
>     znode =3D cnext;
>     cnt +=3D 1; // We get another one.
>   }
>
> After applying this patch, the intention of 'cnt' updating is not so obvi=
ously.
> However, it does reduce the duplicated codes. I will add an acked-by to l=
et
> Richard determine whether or not apply this patch.
>
> Acked-by: Zhihao Cheng <chengzhihao1@huawei.com>

[...]

As you say, there could be a subjective argument here (for me it was the
other way around :) ), and that the objective argument is that it
reduces the code.=20

I'm fine with either! Richard, you decide then.


