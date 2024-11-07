Return-Path: <linux-kernel+bounces-400733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E489C1188
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38BB11C21859
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92775218927;
	Thu,  7 Nov 2024 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="OdoZJg5u"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2070.outbound.protection.outlook.com [40.107.103.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21135215C6D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 22:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731017477; cv=fail; b=P6BRlLlUlZAlEOfjPyrsy37KGlCV/XBlAyO7akySAdxPCmWWr1jC7PYoCp8r66pv22uSTcK6+/zfGgtWdtKW5hJDsT7O5bmIGtSjdazmY3+flWSkDi2jOGaWNJhAnGLP4h3pzvTtXDirXxGOXYWjbm9aBWHC3ngeLn5oma8MgrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731017477; c=relaxed/simple;
	bh=mjaKXZWx6eBYLPUZvAHC5L7nE9hNIemRgIZd4zX3qyk=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j7Wp7k/B4EiGA4uxV5Xftd8GRQLW0BncsAl7Ad+cTUt3JgQwsuJQyQ0vj2HeGyMt4IQ758hFSXveK21QTEAa/ABNZ2IvoxPxKGmphbtlHKv+jfDm4KZ4V7K3mTAqYXP2PF6NYVNCCpCzm2tmHWbQAZjBy2oB+EPuEaU7svTGOuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=OdoZJg5u; arc=fail smtp.client-ip=40.107.103.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXJ0QYQlWkuSEM2rfYSgj9FVj24okot8EJy+hbNlPnegHiLa0vN3mWpXt07LXbuQg69sc69CVhbXTFWDT/N4NrFr9leqs5FARkj8NhbwZV32EtM0TWnGuJcod5Jv6hz8m46VDKh3kv9T4961oIm1lOF3w8FW91xNJElkP6gwoM1g9s/U+gLpwhs1aHBchJ0JqDTLprHn7VYhhqsMkT4wJlFIAx0oASwEKjYFbGrSdZRPa0zNti6pagfoj/g9QE1va/CzwQ+TrwMMMD1ozL5zmF5nkXnVps1lc6eIe3KA1Er2VhHNqFV7JQOYZ8q67sweP/tcwgLhgjFKwXKkOovDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxGcAYJkHcgeppxRTXoPM7bDxNhVEVimWCepthn55HU=;
 b=qZNlqWNWVaAqEayefF4RRLWh5R0wuqlHK1PtaA0JRHDQUQKGdr9rAnyXUHNZWCWJWVByCLy1HWmYMr9sTvVc2rWy/6+fHe5/+bu1JiOHz0e2OPFR7+2AWmX0NWoUV+1v5rxz+dMNX8vNlw/chMOD3pcAkpeN57yt+TGL9E/MECqJbz0iDGY8fxh+xJ7RtfgXGNV5WFFtA9rPEdrR3jTYiPDLR0P5UNnOcC3SX6ufq3F+vsWkVAEgi9twkJ26eqZLm5bMwC76AbXPfawuVsE1gYep5Nt5eOC8g4pwZPEnetnCH9klhDyc2zm1uRvueEYcIZV8b93TT/mW5bLj+qRI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxGcAYJkHcgeppxRTXoPM7bDxNhVEVimWCepthn55HU=;
 b=OdoZJg5uojWzpkiakHS33lEt2StVr249o/CXIJF/lVtlIEQcwS+pa7mMj08EQvo6F74g7JHoupeL528pulxRzF6acpJOrmuCBxn9EwE+zZh66fv/aR+ohuhQyngjiBpSCFyCxaaZSjflyi5Mp2cJrb2f0rDc4e6NA+dyEayVwzc=
Received: from DUZPR01CA0114.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::13) by DBAPR02MB6134.eurprd02.prod.outlook.com
 (2603:10a6:10:18c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 22:11:11 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:10:4bb:cafe::93) by DUZPR01CA0114.outlook.office365.com
 (2603:10a6:10:4bb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Thu, 7 Nov 2024 22:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 22:11:11 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 23:11:09 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Zhihao Cheng <chengzhihao1@huawei.com>
CC: Richard Weinberger <richard@nod.at>, Sascha Hauer
	<s.hauer@pengutronix.de>, <kernel@axis.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ubifs: Fix use-after-free in ubifs_tnc_end_commit
In-Reply-To: <932b3c63-82a7-e1ec-b46c-136e9fd60e64@huawei.com> (Zhihao Cheng's
	message of "Thu, 7 Nov 2024 15:14:56 +0800")
References: <1225b9b5bbf5278e5ae512177712915f1bc0aebf.1728570925.git.waqar.hameed@axis.com>
	<5173d3d2-4a6b-8b0b-c8f7-8034c9763532@huawei.com>
	<pnd7ca9r0pt.fsf@axis.com>
	<239af2ee-c18d-414f-099f-2c82f98d9671@huawei.com>
	<pnd7ca6wp9r.fsf@axis.com>
	<b3b80d1c-6c99-5d47-cba0-3be14ff79c36@huawei.com>
	<pndses42uam.fsf@axis.com>
	<932b3c63-82a7-e1ec-b46c-136e9fd60e64@huawei.com>
Date: Thu, 7 Nov 2024 23:11:09 +0100
Message-ID: <pndwmhe1ypu.fsf@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F3:EE_|DBAPR02MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa2ca08-d1ec-4cba-b731-08dcff791693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WURKWEVoVUZvLzZJRzVwLzN4SlNmZ2lLYlNhVy9zUE52QUZsOWtVVXdIY0RK?=
 =?utf-8?B?SGxJNktQSXJPYnJPSXdESnY1MUxQY3d2UjUxdU9GZ2lEajhhL2RVNVBMKy9t?=
 =?utf-8?B?WlgzRHhsL21TNzBWclA2ZVZBY1BtR0xLRzlWRzFVcVNEVWpFQURMa3hRODls?=
 =?utf-8?B?NE5tWWNPa0hvU25RQW9McHk1VUJqcHNmOWpwaXY5SUFZN3VTUnZhM2hVcTJ4?=
 =?utf-8?B?MDUzOTBUdDIwM1lPci9yOUFIQnVlenk3R3JUQlkwcU5oZTZhN2Fwa3BLbitV?=
 =?utf-8?B?R2pPT3pSK1NjdzQ4dCtMd3g2Y29maS81VmFGNzhmSU5UWWFuR1krM3Q0YURa?=
 =?utf-8?B?MU5aRjFjbTdNeEh5eFhkdGxuazdqR203SFVaVWZ6OXhLQWdsRXZMTTJ0Rlhi?=
 =?utf-8?B?elhyYlV2NXJjcFEwN3M2SlNyK1pQMlFGY1RXVksvZVBaVkw3RGFxRTlYSk0r?=
 =?utf-8?B?OVVoNW02K29Ta1B3QzZSOW41aE1RMjY5NjVNZlo0OHh3QW5pZU9XQXpUWFoz?=
 =?utf-8?B?Zlh4MGxOdzVrdGdsZTR6VGlpdWFJeGNIV0dlNWVYMTd6eStoQTZjQXFINjBh?=
 =?utf-8?B?NkhkMnUzZDRKTWFxakU4b1JvdjVPV3ZpWXppcXkyVkU2Mkd4OWJjOC9xcFNE?=
 =?utf-8?B?VGRrb29XZmhQZVQyVlJRMC9VZys1cWtBOWdtV0poNjQrMEhobkVkUC9pODdE?=
 =?utf-8?B?Y3BMZ3FxaitjZ0hHWVkrVk93K3RueDBSck9pRE56WEhtNTVHeGRySUJXZGRq?=
 =?utf-8?B?YlYyOXF1UUxPY3Q4RmhEV2gyZytNaXZqUHlVZDloMURHTHBzWVVPOG5HUDAy?=
 =?utf-8?B?aU1YeHhHMVdDdWNOV2JWV2NuOHpXbWY2SDUvMy9FQWpHaElhNm9KMXNuV1py?=
 =?utf-8?B?eHE3LzAzSVpKcVY0TkJGV1N0S2REQ3RXSFc4NXEzNjFhZXdQRXFEWUZCL253?=
 =?utf-8?B?YzdMSlF6bWtTSStxQWM5U1VCOFoyeVhDK1dIL1BtVEx2L09KYjRFMzNiT3pa?=
 =?utf-8?B?ekZwNjlrVGxvUnBkYjNQbzNSTk1yRHFndFRTRGlvaTZMbmFyQlBNL2FnbDhs?=
 =?utf-8?B?TFhiMk51R1J1cEk4ZzFhZjhsUitYYUJFdnNoWEk5dHNtVTdYaXZPQ2YweWdy?=
 =?utf-8?B?RHZnUFMxeklIWWl0TFhNUmE0U0ZBN0plZ2ozRUwxNU9lT1VnWEozTjVSZDlF?=
 =?utf-8?B?cnpCL09wTXlyeWtRVStKMndPUXl5SHBnQU9DeFFnYU5sbjhxYllvbjFHSlNp?=
 =?utf-8?B?Y1ZUekc4aWI0MEsrUEJpeW92UmZwZnRJQkN1ZzJUWjZIaGc4R2hOM2FXMkFD?=
 =?utf-8?B?bWpsdlpVd2ZrblEva3Z6bXpjRlN3ZjZucVJLYmh5V3J4bHVpZHJYdi9rdWF0?=
 =?utf-8?B?b2xETC85OG5KUDJDd1grb3AvTmE3STdlOHoyMGltY2NkU1hyQVV2cGFxcWtH?=
 =?utf-8?B?cDFNTXhyNk43dXRNd3pFZnhYOGo5WktIZXNTM0hsbStGV3JlZStWUGhTc3hp?=
 =?utf-8?B?eElZL0tGazNVdHJsNElQWnFZajVObUFtRWZpRWRZeGxDQm9uNkgxQ3daNmdE?=
 =?utf-8?B?eVBQTnVxS21qdFNxTGNlYmhnZ2JWOTVyVHdmVjQvdW50ZG00RHFwN25nSTdI?=
 =?utf-8?B?QjBnYkhsOEZTMStRQUZJYi83L05hZWw1aTRXTnVLNGJSbWFiWmsySnNkU0dv?=
 =?utf-8?B?YmFnbTQ2U1NmWUtoWXJ3VXBHSngwL3RFNXRxbFhsTFcrQ0hNanNFOGtHa1lC?=
 =?utf-8?B?SjlNUFNKdGlKZzRkcTBjVEdFOU93NTVUbVVRTFI1K3B6ZnJQbG9RanNDVTRX?=
 =?utf-8?B?a2wwbkoxbmNNNWZFU0E1dXhzYnh2b1hFcFoxMm9VMG5hcUxLNURkMzk5VVJ6?=
 =?utf-8?B?dWdDcW9UdHpHNmJIc3JoSlQwWFo0L0Nldy8vWVBJS1NIb1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 22:11:11.3891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa2ca08-d1ec-4cba-b731-08dcff791693
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6134

On Thu, Nov 07, 2024 at 15:14 +0800 Zhihao Cheng <chengzhihao1@huawei.com> =
wrote:

> =E5=9C=A8 2024/11/7 0:36, Waqar Hameed =E5=86=99=E9=81=93:

[...]

>> Did you manage to reproduce the issue with this?
>
> I tried, but I still cannot reproduce it on my local machine.

That's a bummer! Sometimes it really could take a while. For example, my
last attempt needed 248 iterations (almost 4 hours)...

[...]

> @@ -662,6 +662,10 @@ static int get_znodes_to_commit(struct ubifs_info *c)
>                 }
>                 znode->cparent =3D znode->parent;
>                 znode->ciip =3D znode->iip;
> +               if (znode->cparent) {
> +                       ubifs_assert(c, ubifs_zn_dirty(znode->cparent));
> +               }
> +               ubifs_assert(c, znode->ciip < c->fantout);
>                 znode->cnext =3D cnext;
>                 znode =3D cnext;
>                 cnt +=3D 1;

None of the asserts got hit during my last run, but KASAN still
complained.

