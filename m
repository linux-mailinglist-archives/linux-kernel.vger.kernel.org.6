Return-Path: <linux-kernel+bounces-398597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863DA9BF354
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17FBE1F23166
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078D9203706;
	Wed,  6 Nov 2024 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="BpboX83r"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2056.outbound.protection.outlook.com [40.107.249.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6115F201021
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730911019; cv=fail; b=MVcVCTIzVD8hugycEwdW8BaduxzrtSpHoR23L/YR8rcSiZb47mwVPj6raV0C22JKhLe9ighx4/+Cdo/N1mDwrdNuGmBcJdy7CVWElv/Boj2V1+9+K0O36ptioQlMOFeqj8LMjgPmDvY+ndnaVyGZazoi+LAcPTbatzZGxbk0afY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730911019; c=relaxed/simple;
	bh=zXPqicMXjAyz2WVyGlehlf96MmpKNqDQYzlQN3TOvyg=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZsHB0rhSn1EKf75D64pQOavADDOEWbjuR/EnAxedO+bnMilKgt92hi6EMJnY5H2HxMGwD4tU/XRfU1WOgIE+xgpBqBbhNiUJilCeXgbtEWmWqNoNYi/U/cgzrv8NSIyJskUP5XBvZehDPwhu5Sdq7DCo+0B5MSHY8zFiF5cRGC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=BpboX83r; arc=fail smtp.client-ip=40.107.249.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/IhlRqoWpBnsFgpnkB+dNhfcIKYRCwoCcLcTCD1bX/5PLfl3HsmrAgXaT/N/HdTHNdsrdD+CCcpmFU4T4UF9DZQvoc7Ni5TmHddcl+9Z241mKsI0CU4y1kSqr8ASQcJ7KrAWi17A9YU3QyuzlVq9q6qsFuLjCUw9IA9HJufV2Rt+DI8kw4RZBUHJqyqjM2Yazj6GzTeQkyBt3u4oImE5Y/r9QWBRLQxSMEqWDrlG1DNDhsKrlaJjl8WiRHX4ZaApArN6wooqvu1YIYFuTbPR8dWtQgX9MirOXGCEE4IXMuzNybX25EcKgqpea9FJdvCl6L4aWRPGT0MpF+CIyVDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Org0fItIUfeJVa0PNPX2AGuBzHJRZ65cmBW1R4tmHM=;
 b=I08TASuzn0MgKkApiBD2+b/pInMxFh44YLwMIQKhseLrE+fbZZTRoWPvy8aPXAROy+XhHGPNFkSSbVHsHTJqRydfiw9HtZdaTX3nsrKJNyOo5iGUdsoOtVInd2qXDbu2nuN1TT4PosI7yIQ+101fKxYrky1rsMnnSJ1hgD+M9HcxpRevzOwLgqAGUqydwXOX1EweCiKIgs94vzhNFzTv8kN0MdF4cEb9ARQ4kN3gKezyrAeIgQJgmGa8sCuzLuQVJhjLTQtCDI8saxGezG0326nJBaqEWEX85oxamccAs2A6UtnWzVnw/UKiICIjH8cLSA0J/6XdaVw2yxfsMpJkeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Org0fItIUfeJVa0PNPX2AGuBzHJRZ65cmBW1R4tmHM=;
 b=BpboX83r09c4erPw1P0SNrVJzGuPHmkM1blxKGC3QPiJyyVUM30naFKhPYhXr7XWbgfG7tAiB2/1QEd7Mwi4vziJo0OM25NoljsDdRh/QogIRxELfAWRz+SCNGXi6sItgkFrnmH/s1GWYUo1sYi9j3mwXG3t+pM19Pvkrbz+Dr8=
Received: from PA7P264CA0004.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2d3::10)
 by AS4PR02MB8288.eurprd02.prod.outlook.com (2603:10a6:20b:510::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 16:36:51 +0000
Received: from AM4PEPF00025F95.EURPRD83.prod.outlook.com
 (2603:10a6:102:2d3:cafe::a2) by PA7P264CA0004.outlook.office365.com
 (2603:10a6:102:2d3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Wed, 6 Nov 2024 16:36:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00025F95.mail.protection.outlook.com (10.167.16.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Wed, 6 Nov 2024 16:36:50 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 17:36:49 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Zhihao Cheng <chengzhihao1@huawei.com>
CC: Richard Weinberger <richard@nod.at>, Sascha Hauer
	<s.hauer@pengutronix.de>, <kernel@axis.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ubifs: Fix use-after-free in ubifs_tnc_end_commit
In-Reply-To: <b3b80d1c-6c99-5d47-cba0-3be14ff79c36@huawei.com> (Zhihao Cheng's
	message of "Fri, 18 Oct 2024 09:40:57 +0800")
References: <1225b9b5bbf5278e5ae512177712915f1bc0aebf.1728570925.git.waqar.hameed@axis.com>
	<5173d3d2-4a6b-8b0b-c8f7-8034c9763532@huawei.com>
	<pnd7ca9r0pt.fsf@axis.com>
	<239af2ee-c18d-414f-099f-2c82f98d9671@huawei.com>
	<pnd7ca6wp9r.fsf@axis.com>
	<b3b80d1c-6c99-5d47-cba0-3be14ff79c36@huawei.com>
Date: Wed, 6 Nov 2024 17:36:49 +0100
Message-ID: <pndses42uam.fsf@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F95:EE_|AS4PR02MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: bc78499b-5e28-41fa-bada-08dcfe813731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUhjNld0VHBQMTkwYjlUN2FiY3pmSlExNGgzRGlyR3owR0lURHBZc2VUREFC?=
 =?utf-8?B?anpUZFNCeE95L0IzdTArQm54a3VPMFEyUUxVMmNlVDA3SVFDU2tKbDVBVmpu?=
 =?utf-8?B?cytvblM3NXFHd2hJbzdQTE0vK0UyYzZRamhXQ3JqKy8wNkhwdktuczVKSUJo?=
 =?utf-8?B?R2xaZkxQR3VQYUt3WTVua2JqbUFyL3prbStmbFdHWG1wQ2F4NjVISnJjNTU0?=
 =?utf-8?B?V0tUbm5CZkc5czVBWDNxTzVEMEo3QXNYUEZ3d1Y3cDNySVEwUVA0MkNBQkRz?=
 =?utf-8?B?RlVWWGtKTldnb2kxd21hdUp3NjNDeTd4Z0ZsNVpOd2g3U1U0MmJOeCtGVDFV?=
 =?utf-8?B?MXVCS1BRdHhWTSsrSTRvcEpkcjdFL25WaVl4bWQvVUtrOVNDMmh6N1VSMWFw?=
 =?utf-8?B?aXIvNU9mWThZT0o1TmQ4L0VGbEFITGErcEFqUG9wYy9kTjZEWUZUdDFCYjNp?=
 =?utf-8?B?aDcrSnhWMENlbjFUY0NkQWlmS1dFMlFOTEUvQkl3LzJHQmVyTE4vSFI1MUFQ?=
 =?utf-8?B?UTJXNmFubDBTWm9sV28weEFZaExkZ0tjeFBrZmNVUDhuMmc1Q3U3SmR1bldo?=
 =?utf-8?B?dWdKQ0J3SE5va09FSHBrRWk2QWtrcEU1cHVwQmp1Z2NBdnVEYjh6V09ZODdQ?=
 =?utf-8?B?bHhCcGsxLzVWT21BTVlhVXBKRUNVWlFlbjdab09pSmY2QkpaM1ppVFRiWXJE?=
 =?utf-8?B?emhES0VuQ1N1QzNvRXdtSE5JeFJaZHR4WXZJckJxV0UwZlpKdFF4Tld1NmU5?=
 =?utf-8?B?Y3ZSYUVTQ1RYQ2lZYXpPK1UwbzBGOHl5aGZVSjZOZjZ4anJvcGViRWx4MDd4?=
 =?utf-8?B?elp0U2Y5QitycnVSNjhKc0pDMXgrbkZybWZ5UUtra1NpQjh0NE1oekdNaE9D?=
 =?utf-8?B?dmo3T3ErQXJyZ0lNMGlvTXNhdnNJTXlZU2RVbTB1dkpQWE44VmdKUWFHWkh3?=
 =?utf-8?B?aFNSODROeGJ2azBQY0JLSGhKa3F4Z1BuVm1BZ2ZFNXpVUHJvRS85TUJreWs5?=
 =?utf-8?B?L1prZTZOQmVoaEx1SUlpS3pST1pYSmRRMXlkNHVnV2FNdHovam5mbExiTjRZ?=
 =?utf-8?B?cVdGSWQ3eUV2KzdnV1REbVVFNVNFR3JycnUra3pCc1NveXJCeTFjSURMZkNa?=
 =?utf-8?B?b0NGcktSOVlKSkhzaytXL0wrOUoyaHRhOXI1VEF4QXdhM0toczViZFFtQyt5?=
 =?utf-8?B?b0NDbTBoU3BXdDVUVUtZL1BlTkZCa3hDSjQ2NXJHOWZtcUo0UFNocWRmYXdY?=
 =?utf-8?B?YnBBY25Ra29TTjNrUHpxb1VCWUdCT3p5K0N0eFNhcENpSEpHTEFTSjZ3RW4r?=
 =?utf-8?B?MHlxOUx0a29sVWVVSmJSRktoay9HYVl6aTRyS3FYOTJSRFBTVklGR1dIblB4?=
 =?utf-8?B?OUJiSHFTOG5JY2FtS2JkQ0pLVXRaR0dNY1h4SGt1ZWM5MEt5NzZ2SFlHMTNx?=
 =?utf-8?B?NDc1eEJXa2dPaEIxSTFnS2pQSG9kTGNXQUZyeDlyeDNaZWhrSlQ1ZlJucnVG?=
 =?utf-8?B?MFRJcmwzN2cvS3FmbmZ2NHNMTWI2ODIxblFrSkJvSGVrOHpCM3J2Zi9aakEy?=
 =?utf-8?B?Z1ZSVnNqU3JBNi9RZlRCSytJeHRjNXE3cDMwZ1RNRXUrd0IyaWpmb0UrWlVQ?=
 =?utf-8?B?TkhNejNwdFFxeEFXQUdzWk50YVc2Uk94Y21uRk5OV1ZMbmtlYVVDM2RNdXVW?=
 =?utf-8?B?VTNwREhsVEh4K3NVRXJoNkdheHFDVUNvSXJKbk51dW5LemxGUmxRUzR6aU1i?=
 =?utf-8?B?L1RiQVZEcUhZUmdUTExocVJ6ZFZFUDVyRUQzRGFVTWdteHBJNTNPZ1c4NVZM?=
 =?utf-8?B?RnJpSEVNQU9uWEVEVlo3djdTc1Q1elEydDZUYUtyeEZ5RmJVendUZ2pERVpL?=
 =?utf-8?B?ck0zWWphQjduQ2VhUkkxV1BmMm54cHdVSldSZmhCY0YzYUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 16:36:50.9540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc78499b-5e28-41fa-bada-08dcfe813731
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F95.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8288

Sorry for the late response Zhihao! I've been quite busy these days...

On Fri, Oct 18, 2024 at 09:40 +0800 Zhihao Cheng <chengzhihao1@huawei.com> =
wrote:

> =E5=9C=A8 2024/10/18 2:36, Waqar Hameed =E5=86=99=E9=81=93:
>> On Wed, Oct 16, 2024 at 10:11 +0800 Zhihao Cheng <chengzhihao1@huawei.co=
m> wrote:
>> [...]
>>=20
>>> BTW, what is the configuration of your flash?(eg. erase size, page size=
)?
>> $ mtdinfo /dev/mtd2
>>    mtd2
>>    Name:                           firmware
>>    Type:                           nand
>>    Eraseblock size:                131072 bytes, 128.0 KiB
>>    Amount of eraseblocks:          1832 (240123904 bytes, 229.0 MiB)
>>    Minimum input/output unit size: 2048 bytes
>>    Sub-page size:                  2048 bytes
>>    OOB size:                       64 bytes
>>    Character device major/minor:   90:4
>>    Bad blocks are allowed:         true
>>    Device is writable:             true
>> $ ubinfo /dev/ubi0_0
>>    Volume ID:   0 (on ubi0)
>>    Type:        dynamic
>>    Alignment:   1
>>    Size:        661 LEBs (83931136 bytes, 80.0 MiB)
>>    State:       OK
>>    Name:        test-vol
>>    Character device major/minor: 244:1
>> [...]
>
> Thanks, I will change my nandsim configurations to generate a mtd device =
the
> same model.

Did you manage to reproduce the issue with this?

>>=20
>>> Well, let's do a preliminary analysis.
>>> The znode->cparent[znode->ciip] is a freed address in write_index(), wh=
ich
>>> means:
>>> 1. 'znode->ciip' is valid, znode->cparent is freed by tnc_delete, howev=
er znode
>>> cannot be freed if znode->cnext is not NULL, which means:
>>>    a) 'znode->cparent' is not dirty, we should add an assertion like
>>>    ubifs_assert(c, ubifs_zn_dirty(znode->cparent)) in get_znodes_to_com=
mit().
>>>    Note, please check that 'znode->cparent' is not NULL before the asse=
rtion.
>>>    b) 'znode->cparent' is dirty, but it is not added into list 'c->cnex=
t', we
>>>    should traverse the entire TNC in get_znodes_to_commit() to make sur=
e that all
>>>    dirty znodes are collected into list 'c->cnext', so another assertio=
n is
>>>   needed.

I'm a little worried that traversing the whole TNC could change the
timing behavior, and thus might not trigger the race. Let's do that in
steps? Start with the other asserts (see diff below) and later just do
this assert. Does that sound reasonable?

I could modify `dbg_check_tnc()` so that it also checks that each dirty
`znode` is present in `c->cnext` list. We then call this at the end of
`get_znodes_to_commit()`.

>>> 2. 'znode->ciip' is invalid, and the value beyonds the memory area of
>>> znode->cparent. All znodes are allocated with size of 'c->max_znode_sz'=
, which
>>> means that 'znode->ciip' exceeds the 'c->fantout', so we can add an ass=
ertion
>>> like ubifs_assert(c, znode->ciip < c->fantout) in get_znodes_to_commit(=
).
>>>
>>> That's what I can think of, are there any other possibilities?
>> I looked a little more at `get_znodes_to_commit()` when adding the
>> asserts you suggest, and I have a question: what happens when
>> `find_next_dirty()` returns `NULL`? In that case
>> ```
>> znode->cnext =3D c->cnext;
>> ```
>> but `znode->cparent` and `znode->ciip` are not updated. Shouldn't they?
>
> Good thinking.
> According to the implementation of find_next_dirty(), the order of dirty =
znodes
> collection is bottom-up, which means that the last dirty znode is the root
> znode, so it doesn't have a parent. You can verify that by adding asserti=
on to
> check whether the last dirty znode is the root.

[...]

To summarize, I'll start a run with the following asserts:

diff --git a/fs/ubifs/tnc_commit.c b/fs/ubifs/tnc_commit.c
index a55e04822d16..4eef82e02afe 100644
--- a/fs/ubifs/tnc_commit.c
+++ b/fs/ubifs/tnc_commit.c
@@ -652,11 +652,17 @@ static int get_znodes_to_commit(struct ubifs_info *c)
 	}
 	cnt +=3D 1;
 	while (1) {
+		ubifs_assert(c, znode->ciip < c->fantout);
+		if (znode->cparent) {
+			ubifs_assert(c, ubifs_zn_dirty(znode->cparent));
+		}
+
 		ubifs_assert(c, !ubifs_zn_cow(znode));
 		__set_bit(COW_ZNODE, &znode->flags);
 		znode->alt =3D 0;
 		cnext =3D find_next_dirty(znode);
 		if (!cnext) {
+			ubifs_assert(c, znode =3D=3D c->zroot.znode);
 			znode->cnext =3D c->cnext;
 			break;
 		}

Then later, another run with a modified `dbg_check_tnc()` to check that
all dirty `znode`s are indeed present in the list `c->cnext`.

