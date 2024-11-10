Return-Path: <linux-kernel+bounces-403383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4ED9C34D0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 22:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FB9281611
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 21:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489A7155743;
	Sun, 10 Nov 2024 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="fj2oVLwh"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538B5224FD
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731275338; cv=fail; b=trAUQ3TDnJ/TkJlxmYNsqMb172sKhsQHwwziz4DUPUWfKkZhSA287iDfPk2zj7RhEt/Yi7ealq4WCEwpSdF2cMXC9oRWiRgOsMJqwFYvXeJd4sbizPsSr4UMxfic9r4ZHJ7ftbYXbwCMlqPlZ5MSiuRH0739SAtr0rL7I+jPUH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731275338; c=relaxed/simple;
	bh=6hT0PhjWeDdtWxOOW/qZGoYpHYnDztIbW6wv7hVjr/E=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i8v+HEgOL6/9JfHk60gFYZ6ct8M6UoauCce9aqCuPoI4IyW6NojcHfeV3J1WAI777hZLbdNSkqCecoUe/zV49Ys54H/T1yRvHXhXCBcBjlJgamCUNwBH2dnVRqzIxqKaoNQnGNumYECn+8BZBjv90QpalPFfMSvYSlbuaXwv+Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=fj2oVLwh; arc=fail smtp.client-ip=40.107.21.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZeEozcx6wjbMsfoc0ZPAq3dRIQGqsDY8fWOSU836NNTO0tj/szsIGB8LiKEF1rPCWYejOY2xfYYuB4NtUWc15b3zvNlLjryh3HGIaLIvn2d5nURwYNxR6P4K/VLAHf36UsJWFgipj+v0AJCrJbia2wbW9bn6I+iDghR49/bcgtxVzrEusxXNKiNzpwDu7L1pElos3NIEO4oOk0sbDBayqFltVlYZK7Ef926eCKuzG28lY8yMb249ZOKqkZpn0BxFpLZYnlL5ZTFZWcfI99VRbH1bvYcjtXF3kDMCgWWA5iHr09/kFcsMdAMji2hzT7ev4TZrKwdy0tLVRddsacT38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCX42AwCmM7xTqVst8syx4YPcffvPA1Pttk2cTfwD6E=;
 b=j8ONTVefOK2btjVnfFnr6YR75KXYYWYHvs6p5BlapqvfoU6Ta+Rk03SE1dju17g7ouIV5e/ZcXASbgjGuPp8rcwbJNVh7rI8RLeT45PxMJ9qqggohqyTSOxPIvD9EpkOiz25/MYU5sZuQ37sG64Cek0rd5H/5eu1tWQBYSAOQPNXYSRRJK2DM9iQKUd9ZwhHrVxJ8wbS9viHsRRnvlfFDSa7J+WORbvvbt0API99/bbf79r1xvoezinwkTwG72dIHnUAAIUKLOnjFHgjUl3Stw/2aj9GAh8vkj1QCi1ybUhpSUx+zOn6xJy5S+fPhvwtV+gz7wdhGNKqRPsm+yZSuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCX42AwCmM7xTqVst8syx4YPcffvPA1Pttk2cTfwD6E=;
 b=fj2oVLwhK9IipMBKZRKbdoal/ujpVICEMEQlXPRCJ0sIQ4o2hc3ebTjwbEFeQohfPI08K6wkZdRXjd3GFAB1j/mMChieATCYQXDxrUe9fdU8QAdDxu1IbTXFYq/wiTDR8fSKHOsRqQMMSCiwiur8elMKsgqYRQAvmteiDPpGM8Y=
Received: from AS4PR10CA0003.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5dc::16)
 by AS4PR02MB8742.eurprd02.prod.outlook.com (2603:10a6:20b:58e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Sun, 10 Nov
 2024 21:48:52 +0000
Received: from AMS0EPF00000199.eurprd05.prod.outlook.com
 (2603:10a6:20b:5dc:cafe::e6) by AS4PR10CA0003.outlook.office365.com
 (2603:10a6:20b:5dc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Sun, 10 Nov 2024 21:48:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000199.mail.protection.outlook.com (10.167.16.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Sun, 10 Nov 2024 21:48:52 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Nov
 2024 22:48:50 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Zhihao Cheng <chengzhihao1@huawei.com>
CC: Richard Weinberger <richard@nod.at>, Sascha Hauer
	<s.hauer@pengutronix.de>, <kernel@axis.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ubifs: Fix use-after-free in ubifs_tnc_end_commit
In-Reply-To: <3c46013e-809e-cdcf-8648-2ffe2ab6c32b@huawei.com> (Zhihao Cheng's
	message of "Sat, 9 Nov 2024 10:34:25 +0800")
References: <e7b5151bb1186e2342ed677cce0ef77592923084.1731088341.git.waqar.hameed@axis.com>
	<3c46013e-809e-cdcf-8648-2ffe2ab6c32b@huawei.com>
Date: Sun, 10 Nov 2024 22:48:50 +0100
Message-ID: <pndbjymzrnh.fsf@axis.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000199:EE_|AS4PR02MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: a10795e7-91e9-459d-07dd-08dd01d17787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkZKYkhaaTFyMXJFYUhwK3A1NXJiNmlGUmhXNlo2N2ZicndHMHhrVXhXV1Vq?=
 =?utf-8?B?bHpYWUxmZk1tbk1ubkplbHFva21pQzY3cUNmeTdMWHBSYUtPZTdTTmpKNVZ0?=
 =?utf-8?B?ak90aHhEVHVwNGpjWjRXSTRVY1JCRldPSFRINC8reXFLa1RwWERKUHJRRXUz?=
 =?utf-8?B?TUdCbHU4UmxjWllkM0owa1NjUHpmWWozVi9CVlpjREswVWlYMmFDM3NBRmh6?=
 =?utf-8?B?bnkweVdjNnBIRUprRldWWXczYTJqWFN1WHZTbjZEMVQxZThsMGJ4TVZCYzBG?=
 =?utf-8?B?b1haNU9DdkxhVkQwZFViYWxvSjFXcEFiaGt5NXlLaEMxQVNXRTZjelBNRkhp?=
 =?utf-8?B?dGI0c04reXkrWkZKc0N5TWQ0dEVLVjQ5NGIvQi9taUNYWWFEZ2tocjEvclYv?=
 =?utf-8?B?cGRqQmN1QUJ2R0UwQWZHWWsvcXFFNlJEUk04TnJQL2s2dUJHcHd6MXFLSmp3?=
 =?utf-8?B?aDc3bmNVL2hlNW9md3FRd2tSMG9JY0p4a0RzTHB4bGdXYlg5KzZ5SE5NM2pE?=
 =?utf-8?B?cVNsdkMxazRmVGQvWnM4czArZDNXRWdWVkVsWFFEZDRxajE3eElqSkl1Z3JP?=
 =?utf-8?B?bndScERJQXJMOWd3Tk9aRS9EbUNMaEN5VmlFNnFTMXo5b3R0Y09PVkRFS0du?=
 =?utf-8?B?bzhFd2l1QmZKTVN4RnF4UWh3aHhMNVUxS0xQMTJXZUNwbk5ZeGpTdjZqeHZv?=
 =?utf-8?B?UVEremxIc1M3SFVnb095OEpscnc1SUl2aXA4Ynl4RUdNVGNIUWx4a3J4OVRt?=
 =?utf-8?B?UW02Z0RNc01xdzQ3cDltVVhIT0x2VzY0NXp0VnNHMlEvOU50MGc0MzRxd0do?=
 =?utf-8?B?eURYaW94N2tmK0FXd3Z3VmVlcEFWbitGNzR1U3lLM0t6amR3cmlydUNRZXJT?=
 =?utf-8?B?N0NlbS92QVl0OWJ2V0N4aVRjSXU2SDFkKzZ1Z1VwWjhQVGx5b2lXb0wxMk0x?=
 =?utf-8?B?Y29Ca2ZER1RQSmQ2NFFVL1JyWHo2cDFMYWw2Q1JCWnRENXJXdDBSQTM4VE9k?=
 =?utf-8?B?NUEyRnVqSllKMVlta1RjdkU5NW9Nc21LMU9aWU54RGFqWGZDRmQ0M2hpRmxZ?=
 =?utf-8?B?Y3JlL2hLbXNabWhaL3N4T01xMUw5WGRPS3QwbUNoZmxJNmFjL2llZjhxT2Z5?=
 =?utf-8?B?THdCSUl1V3VEKzB5V29JZFU2TXRBU1FhYTN1NzhBVldHekF6eHRzazc2c3hl?=
 =?utf-8?B?MGNVVENCRWR6N1REQmc0dWdiRlMwdU9acTBVaGczYTJYN1lSUlBMQlRsamVv?=
 =?utf-8?B?TFY2Z0h5UTYweG54RmtVQysveFZDSVkxL1Y0c2ZEdE1zQzBHUFBHS2ROekFU?=
 =?utf-8?B?STd0NHl2RE5Gd2pSaU9WTFJmT2hEK3BsanFyVjViYUtmcjZpTXNaenJCR1RE?=
 =?utf-8?B?WWFDYWVQalVUWk41dlZhV1BKVTFXc1JzN0dHK1RvU1ExczBzckppZXRpdUlr?=
 =?utf-8?B?ZFMvU3JRSDE0WjFNSmpOS3drYjV3cjNwamgwcUhNdmlMNkpjdENRNEpBMllC?=
 =?utf-8?B?SFJldzZKYk90T1A3Z0F5eUNnY2tBQy9HVG9JNlkzdGhVb3BhOE1BNThuQ1JM?=
 =?utf-8?B?QzFxOUg4YVd5aGpUKzMybi9yZk8vRmZIRERwbmZVb21TMnZDVmtUNlRlRHF5?=
 =?utf-8?B?VjVXWldFeHhlOVJDNTl5Z0d3d3A5cWE4NDdPMXJ6YkZETFRIYjdvelhHZzdz?=
 =?utf-8?B?Y1pHWFVmTG1lSWNBaXRkWlBEdFpBcWVBVHpwSFVva0RmNDA1ajVyNWhlSmt3?=
 =?utf-8?B?WVlQSVNtaGFGdCtUakxtSjRWYWpzUEZwbENZUFErSEFpWDVlWmRlZ1N2M0w5?=
 =?utf-8?B?dUd2T1d6UDBVaXdKcnhpQVZRZ3RCZUxjMytranEzTHpmL0lDbXd3VktQV2RI?=
 =?utf-8?B?dXhvQ2kyYURoL1o3Z3B0TldqZEJSS1ZBUVo3TTFNemFnVlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2024 21:48:52.1140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a10795e7-91e9-459d-07dd-08dd01d17787
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8742

On Sat, Nov 09, 2024 at 10:34 +0800 Zhihao Cheng <chengzhihao1@huawei.com> =
wrote:

> =E5=9C=A8 2024/10/9 22:46, Waqar Hameed =E5=86=99=E9=81=93:
> 3 nits below.
>
> 1. Make the title as 'ubifs: authentication: Fix use-after-free in
> ubifs_tnc_end_commit'
>
> 2. At the begining of the commit msg, describe the problem:
> After TNC tree inserting(which may trigger a znode split and change the
> znode->parent) and deleting(which may trigger znode freeing), the
> znode->cparent(which still points to a freed znode) may not be updated at=
 the
> begining of commit, which could trigger an UAF problem while accessing
> znode->cparent in write_index().

Alright, will rephrase the commit message a bit.

>
>> Running
>>    rm -f /etc/test-file.bin
>>    dd if=3D/dev/urandom of=3D/etc/test-file.bin bs=3D1M count=3D60 conv=
=3Dfsync
>> in a loop, with `CONFIG_UBIFS_FS_AUTHENTICATION`, KASAN reports:
>>    BUG: KASAN: use-after-free in ubifs_tnc_end_commit+0xa5c/0x1950
>>    Write of size 32 at addr ffffff800a3af86c by task ubifs_bgt0_20/153
>>    Call trace:
>
> [...]
>> diff --git a/fs/ubifs/tnc_commit.c b/fs/ubifs/tnc_commit.c
>> index a55e04822d16..a464eb557585 100644
>> --- a/fs/ubifs/tnc_commit.c
>> +++ b/fs/ubifs/tnc_commit.c
>> @@ -657,6 +657,7 @@ static int get_znodes_to_commit(struct ubifs_info *c)
>>   		znode->alt =3D 0;
>>   		cnext =3D find_next_dirty(znode);
>>   		if (!cnext) {
>
> 3. I'd like to add the the assertion 'ubifs_assert(c, !znode->parent);'

Wouldn't the assert always be true? Since the root node wouldn't have a
parent. Or are we afraid of some other edge cases (bugs?) that might
have been missed and want to be defensive here? Either way, I'll add the
assert.

>> +			znode->cparent =3D NULL;
>>   			znode->cnext =3D c->cnext;
>>   			break;
>>   		}
>>=20

