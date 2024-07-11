Return-Path: <linux-kernel+bounces-249855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDFB92F0BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB31E1C20EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6931019EEC6;
	Thu, 11 Jul 2024 21:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Z1xyqDdK"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020107.outbound.protection.outlook.com [52.101.85.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B472C51004
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732376; cv=fail; b=QQSxmcHxFIpD6nld8OJYaJLeOYq39tRya6FUUH0WAhfo9ruHx3uLGnihBzBmqmQiMJhfL2a5WUiE0zDLFb24cp7HlfT6kbAMGKtDwCAKr+VSWam4PicnKcxkBrc7qGu80yA3TjgIdAgHqen1ELuw+SHxjHtZEdeugscT3OdPLSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732376; c=relaxed/simple;
	bh=vw4qqegsuRt37o3j3Di9gAkEZxEjg9XGiH8n4391NL8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=VrSAz2kvjAeXadjaTnYcDJbwp997PFvNtJ0wpDaTAa4Siis6gu1hxadWe8/4ZSBo/48t1y5aqV7q7LnEuBwUxkermqUXAWSWYeq98l86K0oc/qjZr/3YVqypyQsi0wEzzVqVLbZ3Gm9WcJN5xpTtrydOCpw22bDySvtVl0vj27g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Z1xyqDdK; arc=fail smtp.client-ip=52.101.85.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgkGLgF7+pYQ2+EamBC70JMyLJDAcsBUG4Xk/cZuBYuebk3jT6uQS7a2V1riqQqQ5dvhcUmIZBwxeknkfqKiGT9YSE3hmNxWrJNtiT6k3uUbaKmtDynoJGiqQ5Dx8w1TXPavlGn5KwZSZExon8eegs8I9fms/cf/VaU1Tk4IN+TsYqZpF+tQYyAWUnFqXSQVl+EWocY/2PqQWYE92dNTbNfbL/ukxDbhNUAHMLytO0elkN7c8F12iP3Aw5/9RT/+9/JtdPhseEHPjiZ0a8i2CXa53154vVnkoBjCZd2AXq1oz8pqY4HrkUm6nHDIRZUHJX+cGsZxqy+atkicxVLpNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWVU3mYTPK8Qd76sEQttg8QpWVUCSIqgaefJjCuJbRg=;
 b=S/hZnysZQ5i7DiHmwglGbV7uAecLnKlo1/TW2tXWrlmMUOEKuM35oRdDglhrbomGhknv3F49Kc2nscy0jko+w536ZA6IIGBrr6Nvpe3NJWxtV4wgnyrDFB05wKmOdNUziutgfHwzOwoLuBV4tIII9lj9j9ssBPSUnvnwEqpZT5Zc/r/tryLJMlovYkSnyrHnfztV1aDOODK3M0jtNapLZQ4ByMdUzmCeDSTcw8YjmASpz3uKa9D+jfZnx/xbZ1ynKYKWE0Y5R1y6chqQkPutuYIBPUbAthPF7Il9Ian6NSenftDikOQvcG/945mAgQJmqt1ltW4/9wuSB30sK0QQdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWVU3mYTPK8Qd76sEQttg8QpWVUCSIqgaefJjCuJbRg=;
 b=Z1xyqDdKWyCgmF0Noiof5YWiwXPVKr0QmOCru1oghnjZVlOoC0wmFBkdIrfoGrifA/CWNkG7phMQS7G5iyKWwkAf7cw06iVoS5z8JvICo9TO5OwyiRO87sj3uoASFvYwvdDmWMUdwaOEXivk23orYTeMcjQg0BsMSSYTWBs8pDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN0PR01MB6862.prod.exchangelabs.com (2603:10b6:408:161::11) by
 PH0PR01MB6634.prod.exchangelabs.com (2603:10b6:510:7a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.22; Thu, 11 Jul 2024 21:12:51 +0000
Received: from BN0PR01MB6862.prod.exchangelabs.com
 ([fe80::8a1e:34a8:2ad9:7f83]) by BN0PR01MB6862.prod.exchangelabs.com
 ([fe80::8a1e:34a8:2ad9:7f83%3]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 21:12:51 +0000
From: Carl Worth <carl@os.amperecomputing.com>
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
 <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>, James Morse
 <james.morse@arm.com>, shameerali.kolothum.thodi@huawei.com, D Scott
 Phillips OS <scott@os.amperecomputing.com>, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>, Xin
 Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com, David Hildenbrand
 <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave Martin
 <dave.martin@arm.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v3 15/38] x86/resctrl: Move monitor exit work to a
 restrl exit call
In-Reply-To: <20240614150033.10454-16-james.morse@arm.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-16-james.morse@arm.com>
Date: Thu, 11 Jul 2024 14:12:42 -0700
Message-ID: <87ikxbd451.fsf@rasp.cworth.amperemail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0191.namprd04.prod.outlook.com
 (2603:10b6:303:86::16) To BN0PR01MB6862.prod.exchangelabs.com
 (2603:10b6:408:161::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR01MB6862:EE_|PH0PR01MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de6f7f6-3477-4497-b16d-08dca1ee3912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C0RmWk/qVJwWeLyzx19wkFVAURcRP2G28RWqpgpjh0sJPHa9FGmemYeLqwCH?=
 =?us-ascii?Q?+PxDLjhyDwEk9H5s7DpNh3FMAFPHXble2MQP2cZb4QwKWen8jQm64o7eu8Ry?=
 =?us-ascii?Q?LwsaURkmWQ02y4+d8DH83O4IJawpL5MzcgLYnTRttKZYY362yXVF4Bx/swNX?=
 =?us-ascii?Q?BZnZEW5yZ7c4w0FQd89ouiOWeViG+1tWHsB3Bo4d6IMzcVet+RUmB3CqgYj2?=
 =?us-ascii?Q?30alww5P0Egk7stfnnFEh0G7tQkscDk6B73HCp2QapzMZuVH13156bJQG+tk?=
 =?us-ascii?Q?ezTCOX3/pFAIOdfZEMEsq51BvYiTbPx6C2hzD5D20Vz5PqpRgsXeSYpOLE8D?=
 =?us-ascii?Q?GbCvk3qjhutkDK4jyyY/BffauKEtPpcITAdND0Y5Bvly7740GAh3AeuSagLz?=
 =?us-ascii?Q?5MFxo5ZbtdaqIloVFQ0bMXbBkTznwC+L5/XedR7jboOJXtbmPt30jwuK+rg5?=
 =?us-ascii?Q?tv2X9cVnfsC2m5YbQTeYka8mjsOQdjCBBWmrYTb4it72WPPquCe5gRIgXcHP?=
 =?us-ascii?Q?Lo/RK89LsKlUr05/v7X9PlXclYaK2E8QfYv7EoiGXHbxgkiPEubvnOsNgjvL?=
 =?us-ascii?Q?py3UpliQ3J1yjBfJYSV/sTHib+VQmj0Ssi5BstLAfoOQFC+BTWn5YMzbL9PM?=
 =?us-ascii?Q?dOgRs/E3JkImT8hVg+SZFrIgF4x3zZxgCh32MHdURNjqLwDLZ6zZ1JsiywN1?=
 =?us-ascii?Q?uDghf7DFrQbSFdlODjfJGPivfUSKe0wM0mNJmh9FcSaq1JTpfv+h18UDIpLQ?=
 =?us-ascii?Q?QeK+4/B1pFtJI/0LSpVddweI9eOWXHZBQN17N4KL16+ehbSR7aFKdhvnuNYa?=
 =?us-ascii?Q?L0Jx1SUdEkgtYZCDao47CxaW99mJlvYWt2/GOLL1hxFmd4bDdgfUuKL5PJ19?=
 =?us-ascii?Q?Est1y9KVoasNj2H7ewPtx3fYrFrYc0ZL9hMV4K7GzIk8LOlP3OsE4ysydnAZ?=
 =?us-ascii?Q?YIMYyX9HbhBPoSMXGWtErykmyFNq4NxcdaQO0RbGKflv0nfJjQ5YuGpXpeJr?=
 =?us-ascii?Q?Fc29BoL/TpOdCTmw/wQymiZIz/7+0E4/wZqfdZej5A0Ye1kOg/6bpVTtyts8?=
 =?us-ascii?Q?tUiIqhRTdlonAylUxzoUlO/7d3wFkz20eq2FtmUZajKANFTus3PjxOoDU5fn?=
 =?us-ascii?Q?8nq3abE1nzwMQbVKj7JoLjxzZMC0ZUXvpvxUizg6MtEpNb1+3zVAQtGK25cT?=
 =?us-ascii?Q?nZcg2xaSudKZIscFCBymnYnwNISTWDQaK+pxCmhx3FnORViJy1cj1b42S3S3?=
 =?us-ascii?Q?JhNgARU6DK+G9aRUQBV5T8QgbbAU4SiWjMjFv65purPwlpbcrUFbAjAsTy8I?=
 =?us-ascii?Q?99L7erNIW32W3ZhyJf8nop9b4TNoVXVj8X/T8+FYe/l4Tn0b0YwzdocvQc6n?=
 =?us-ascii?Q?roltbIk6vGrRgCdpb+PNgP8OEoh9exF6IUfu6MEhtCgp6KIUvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR01MB6862.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a6tnVvbIxeNVqph3SbUTJiWqWgSECXVHYWWqAJFJSEdwn1uLh4M/lczzizcR?=
 =?us-ascii?Q?pJkgZae3Of/Do18R8esz/B4GzdNEqMPQ5Yc/UnSRvN4xEFKIggCZFHTATnmP?=
 =?us-ascii?Q?/1Cu9mPBnmvblv6ksL33JBpc228mFQbahbBmDYt6SxNJtXlHU45q0O59441o?=
 =?us-ascii?Q?8wPSB++vVqAUvAe19YEcHEkxX/OvkIY+fj8oNS9vxgwFSwhUScm3/5dIN/Tj?=
 =?us-ascii?Q?Ba0/NEQtEEvCWWHlwVvhQFswnirr+sp25Kw8fpaS+K2GVmnSfa+py53XeszV?=
 =?us-ascii?Q?VpmoVnENw5eniH/DTeBGw0XFUh5gTv3FbdkbPj7p270fin+vzFk7UQO5Ysc0?=
 =?us-ascii?Q?GEx7zyKZ91tNzVzjSmXzdRi8QZQcQY0lTH3JMLzrMbPWaGRWl2HXEH0qJkHN?=
 =?us-ascii?Q?NilflO0bYrSxqpDjAsF4a5UjDag2mQlXMJDwak1F4Z4NXUVfe4rzjegNEaRq?=
 =?us-ascii?Q?UUHfne57/Tb0Pv9rKONGEFXuYgx2xmyaXxYi2R07bAN95bxDsBGl4v8l1NtD?=
 =?us-ascii?Q?ZmIC035njg4PFaxPZvg3+2deHcYTZV01xrbLF2hJHI4k2NUe9cg3sbpdsGrY?=
 =?us-ascii?Q?eRHYG5yVeZN9FJ6zTdTSpI735ne5PxOos9Y1fp1qwUjph8u1inMs133Y3IZl?=
 =?us-ascii?Q?khHuZfBg6XlKFmSJXRnJPoqGWsR1SY5v+R3ycWJPYwr5ykJ2C95eu4hn51KB?=
 =?us-ascii?Q?7QUvHdVBD3atzrGFrLyVtWL+HnYj/L7b+dQ+/+qAeKAfo0aJ7tIe4JqnpiU/?=
 =?us-ascii?Q?KsEafeN+HNuh7vYJ4gx+QOxZeqp9vYOyYZ/CN7h30uzdg119A04gG2maTj+S?=
 =?us-ascii?Q?mSyGrsPjnFCi8lTVRnHB4rfp/Ab3gq+V2Sd8O3PyoN7jxIOVeKXIO7o0+2Y0?=
 =?us-ascii?Q?ST/F9AEaxiy4DmxYapIGnnY14gKT7rk+VsBm/j9KUDTSon1YObTbRO5jjcK8?=
 =?us-ascii?Q?wgp+oNfKYDKLBJGon0nZh0InHare/GRWsQR9MH225MHvaNndMas4OieuxnFP?=
 =?us-ascii?Q?kghZUF7DPiTGky5EUd9RQf16ODryzPdpZ9fdOinR1OD+zDhq1lIPECGUzY0e?=
 =?us-ascii?Q?5fggEOlJerVRdH2Ut/bCmBIaBm/2UHWaYZ95PQos6uRlVMFCA5q3y+kmfGL/?=
 =?us-ascii?Q?2qwh1IlAX8dpTZkZ3D12d41nN6aZiHvZdoggAxLaiH2pT+HBiV6CjVWM/UaY?=
 =?us-ascii?Q?3v6UdXGf+/74x58XhDshL8nwrqKq5uW41k/57cwUSdRUHOLx23T612lp5Vb9?=
 =?us-ascii?Q?djk6JBEYJXe7Eg8I6uB1hwhkwZm62KU3V+d5YfRTTvNg1jy8JqwTRkobkO4c?=
 =?us-ascii?Q?lmxmaIrsBqYJLNoB8xq5qbPbPjccU2yZvadej8VXdgsOeoJhrFmjEZpW7D2J?=
 =?us-ascii?Q?DRnPSuhp94nCs9JIErFI5tzTYfiVcQyL7mJGXesOnHvfdzfojK+ufD2bXcy5?=
 =?us-ascii?Q?wwtZbr2hm5AaIdsYpGqSFyLaZQIbhUzoiYly5nct2k7/ox2Z5zDOZIR/a0db?=
 =?us-ascii?Q?RKrKg9m1L+nfccMzElKsgiZUeo5WTXHx1sBtvIgNnaiLki8BdXLnOqjaz6F0?=
 =?us-ascii?Q?bfMmolGSPVS3Vc0MpYLX2pYv/t53WM0RwOj9yHDVKYxpW0EA3bWUdSkY3JtN?=
 =?us-ascii?Q?ffoNUBJnf084u72r+eOer0s=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de6f7f6-3477-4497-b16d-08dca1ee3912
X-MS-Exchange-CrossTenant-AuthSource: BN0PR01MB6862.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 21:12:51.4217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXb7D/ddejVVGNVp3cDHbP5DSXqovbB5FDangS2555HWYB/1aSaTzSk+bg+HWtordL59AA+CCBSkOMlvTocjwEodBNeGzRrL+2eB9B4lDJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6634

James Morse <james.morse@arm.com> writes:
> __exit, and is removed by the linker as resctl can't be built

Typo fix: resctl -> resctrl

Also in the commit message subject line:

Typo fix: restrl -> resctrl

> Change since v1:
>  * [Commit message only] Typo fixes:
>    s/restrl/resctrl/g
>    s/resctl/resctrl/g

Oh? I'm not sure how convinced I am. :-)

-Carl

