Return-Path: <linux-kernel+bounces-252816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EEF931866
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA35B21789
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F571C6A0;
	Mon, 15 Jul 2024 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gORZ0ZrD"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D201A29A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721060461; cv=fail; b=tjwrX5ODNbHB3DwKpbcS4YCULdxwWS2gy4eiL0jKe0G+TFhXvixQa/7i6NVMNZqlMs/AdmFLaX/AqzMLBW1xFN3UKaeMCE2FIhJLx2zxC4uhVJhtA34pjlLDEH34e/iRtReqyZK8TZnw2Bvxgc7wArCKb/JoygsYJkqD2ARiFiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721060461; c=relaxed/simple;
	bh=DA/HHTHdfmqnfsqZAmd5T+vDTuH8g2APbjzsSYRCk0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dg06/Mxv8VsWoOGPyIUGkRA7tnYr0QHkbsxaLWnsV2mWoJbtc2Dcax+ej+v5f0XTKrfRqbHR0UoLwacm1CGUKDg29l68TGjpuAhfKWhXIqV906VZ5YyvgESf7ik9OI2Ok/xRMOaV6KZHR0TotO8tFQaZxGXYfguXW+TzSM0LbrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gORZ0ZrD; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZFcYk5oX/MaaQxRq6Vqbc3ZcfHoqgv7R0/YA3VhkLKqH7qZF4rf/NQtj8S150vA/IIs7OxASIhPZzbUJIwoC0ukznAVJgbCCKGpTplRTtcIeTWHA/EN33GsQ/G16RdLc1yIAWMBdwacSLndYSbqbFtW62gFM3+gSzshdEFml2LV9qq4NPAy1CK/23wiw4rRnWtNNzVvDuq/SAfICfUSTRpplRX94GzEvBvSr1WD4mT84Iyhz6fX70aWyn+3n+aRRnV9ADAnvss6gDXug1hTqKVaK0F9LBxtE0D2uR/JU+FU5GuQzR2iPzmR+UkkFpKx75WFYQVEIsRAR1nRhgQ/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrIHz5FwO71IKiSoJ6tFwOEjOjevVNPvP+iiKxHg7Lg=;
 b=CxSNWIXbP8pNri77ELB7UjCaDhYStLIXFrIpx9EkTG/5uhImzWsaDrDjvC+lg7nUMphz3Q6dmIt7fwPYTnrYy6PbjPzmbkTmLwPvUium6CYCt1YZI4+3SoGxviNA4NczzFZcafJaDn5fjdrlNSpxvdUIuuUMfBFVWooH2OeE4HgDCwrtoveFDwQC1p3wShfHypcUdLnjc/gq/xich1jRCzgKgzub1Tio7EOqpdDt3vAIktJrSYkVA/4J6w68JQdN1MtydAWFd1V5+RilkhKQ9TLet6pas87p6t/DkjXahnVFiiwIKDAC0GFts+BcE4qdMhJc5Y7ZjEGnVtj2IOp0PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrIHz5FwO71IKiSoJ6tFwOEjOjevVNPvP+iiKxHg7Lg=;
 b=gORZ0ZrDjN/rC7wQxAQCflqMi0XpMy+/UyNOHKoCTGDeVWYMiOu+O9Tf+Etqv/mhYXJSNWLJlg7NNTXxk4Fpu4JFvT9AF+Khzj6SL5RdtCHpOeDKhDF/NF+3kVLoNuOeEZG66TV6IBuPN1G2V6Wth23GiQftKSfohshCQCo332FVPSCrqQq5PmG3q7K6XX1kzQXwrPrIFhwqkGk/P7oxy7Wo3nRWPaBT+VrSxyDA/DiNfIDP9ioIO0JEY/MXY1KcQwIBiJ/7YcXpmtwMZdkgMJ3MoFTzVZseyw2ZYtycUdS+ndubuc/iF72VPtXkP7GndSoOSCD8Yc6iBoAbMWcqJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS0PR12MB6632.namprd12.prod.outlook.com (2603:10b6:8:d0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.34; Mon, 15 Jul 2024 16:20:56 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 16:20:56 +0000
From: Zi Yan <ziy@nvidia.com>
To: Gavin Shan <gshan@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, david@redhat.com, willy@infradead.org,
 baohua@kernel.org, ryan.roberts@arm.com, peterx@redhat.com,
 william.kucharski@oracle.com, baolin.wang@linux.alibaba.com,
 ddutile@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v2] mm/huge_memory: Avoid PMD-size page cache if needed
Date: Mon, 15 Jul 2024 12:20:53 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <CE8D3C46-1FF7-4E28-AD84-162878FB9AB3@nvidia.com>
In-Reply-To: <20240715000423.316491-1-gshan@redhat.com>
References: <20240715000423.316491-1-gshan@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_093A393D-242F-435A-B9E3-CD6395A6BB2A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0444.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::29) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS0PR12MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: a206cf4b-ffa2-4714-d493-08dca4ea1b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l46/ydx+iinLJnjiErB44LkYirEu3h25hdR7hVL3TwzvuFxatwC4I7JzL2Dt?=
 =?us-ascii?Q?55QNgoqMpIbQdbRZXCwbSCKmUDGMYoop9v2hDdLX27ud6zGnG/sbanqrsngk?=
 =?us-ascii?Q?RwRlNrT+TWNoAx8xtOWSIusYTraik3Ucd9sJuB0p6eMn1f5d2mbyubxEt4sO?=
 =?us-ascii?Q?x0jUwTOCTxKbLVJWddzGHtOU1k0XsiwwdW9Fa7SSvOcQ14/g2a1UdQDMsA2q?=
 =?us-ascii?Q?rvSTHmQ0Ac16zDCO+T3Jpua2iYGQIvyIXBRpuZIZRcainSkq30PZw8psGKuX?=
 =?us-ascii?Q?Ciaw8s7HWVWgRvvJaZ54dIDU1ZGdiKO89JXeRSkrFrTlvDMjz//IrLWHkO2t?=
 =?us-ascii?Q?0sOcfBbXzdgTIZA/i6ieIl8xagQkKuDMI5079zOdn50ZhvuofR2In8IOMhlR?=
 =?us-ascii?Q?1n/qcvmdjuiZKPtPshSVyI1RZSxuhq1E3CSH88wQJelrAavy1RfFxnh97DqL?=
 =?us-ascii?Q?CoGJH4ccM3J9xhiTGtBL5R57B5VYpxUeu7XxbvTjs4EaQoecOpA7KC9gsdIQ?=
 =?us-ascii?Q?/AKpATDyt4wJAZRg8PNo2YaIPuehevPJCKeJVvDkkUK2QwA0soQrcysN1SAB?=
 =?us-ascii?Q?S49rqMRlEluGHi3jVWCJ62PrZ42LYlggE4M4on2WHmcSSuCVu7P0Nl9huJxK?=
 =?us-ascii?Q?r255Gjo9uk8FRpsTB/BNkI1iSOI7FPMXqsKkZr1CQvpaf5vjjhG76+f/FC3b?=
 =?us-ascii?Q?VIQm/YBcYNx1tykmA2aMy8UUKJqkpxItWPm//e1fSVBgo5EF744RYuoprL//?=
 =?us-ascii?Q?8MLeWJuv24bGgKgphAB7ytYZQfh7I7noQRUlRHh9ZlPYlx7bndvBIFr743yx?=
 =?us-ascii?Q?kmYcphSYKBeg6C1ltLnM4e+2DNkh/k5aLsBPiWvLCEeORZgl+7QF4inm8eY8?=
 =?us-ascii?Q?zJuYxOeot9Nq4xbSNLeMFBBGa3YtZAiu/3UzH1SBnOb/c087q5pPTohKfcPQ?=
 =?us-ascii?Q?+4XArgpmI/9aBe8ICZqsCLaCdWg//LpyTfdjeNhk2IY9h8rvEuZHwtIp6NKN?=
 =?us-ascii?Q?bhS01Q/Xhr15xcEDy85xCt4bU6aTymm+Bf32fst7Cix3sTZFYC67ntlPBgpr?=
 =?us-ascii?Q?J8zh0eB71nySfmDQGfna4nCfgGU/4J6NzendcRj8Xpbj6dCNj56iKI5mvVkk?=
 =?us-ascii?Q?MJa90QsaQff6Z6iGyCfIhgpQq2RJLXgTc/VdXz1B2Og3Kp/At+7vg+G53/vI?=
 =?us-ascii?Q?Ebo6BDFxgpkxIKj/hmRyit3sNQr7jTjobQAtLifHxlCSFnRl9bES1ST+YIuG?=
 =?us-ascii?Q?vcHEZmwewVrwyt3+9zmn3ObwRJ0TNmr46HLpYtRrizrp7tk8nhFbyJNJvF5u?=
 =?us-ascii?Q?oaU7jvEOmAA+KalkKqYVYDGj4uGaUY9JDB6LscsX304N0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?88M/AQf7C+crDeMu+5cA1EMURwdYoc5LZPo/rTdkSYebfW55L4r8/OVLFWKl?=
 =?us-ascii?Q?scVo22JalolyOhnDLL1XUw4w6fPnBgblocExg5qbgQgboLOJoYaQzsL85Sy1?=
 =?us-ascii?Q?WBggDXqzzcBIxUT0x7i6ixgUuAPx2yJOd+ZW9QJjALP2mNFxIcQUKI5hk2qT?=
 =?us-ascii?Q?I2+MOqx4OEoBOd46iTq66HU7uA0MPg979YdZqSBtgHhwviKy3kmiu4or3Yra?=
 =?us-ascii?Q?76SfL9iBrAv8pLkWN5zr9gFyQNiNHHqI8aWL9XsFsSLHBgarE3SmAd1reSUs?=
 =?us-ascii?Q?4+eWvyECXQjHC0POFvTnEB3/ppZDWaDBJsI9tilHYeyfEd944XeazCjMDzmo?=
 =?us-ascii?Q?/0+ttyXX61Lf3ye9LWnem+LQoi2r43aYCKXQGa47aQqtGhecjzQhDTXgwiRV?=
 =?us-ascii?Q?H189MfwJPd1ObpCVI2AqswBOK9sJgpZSD/V498UAiYsVMyjoj5GkWraaPcPZ?=
 =?us-ascii?Q?ELC/aSZSX41BQaYj0cUtwH++vNRT30YuQG/3oqSLSnF9JxBU1LJIJjxliRCU?=
 =?us-ascii?Q?KDnzBI0VQVtPpMckGSygqYPEJe7RGRW9KHyJX6AMkNdJ9rZkYvvL/B4dbIf/?=
 =?us-ascii?Q?LcYMCKQLDUcvxaoHtdI3gCtYw/JdLs0OO97bXQjeZm5tJZF1SVySsFesdq0y?=
 =?us-ascii?Q?kPirK8KsYeZGaw9gJClVKjj4w8OMACP1Duium6GIGKEh/7/EL4AyxhgWRjQG?=
 =?us-ascii?Q?OgInknniFTkx9KlSO2Q5jv7Q9/ES6pbCnQ+rD0rAHAaHrbDKMpjint/nol/2?=
 =?us-ascii?Q?RhM2I+/kG584d7GN2YA/0SIFrTOelYC4eiN8wPEMfsfvfIZrJFN2nF3lEapc?=
 =?us-ascii?Q?yVYW/zE51s43F1PuUntkzQTXC9/yQtvwv810Omg9sCIrC+Nx2K4i7aTCXx/9?=
 =?us-ascii?Q?KumhYbyhyWd40omP4bUs3dWMba3OvdkmR3lBO5n2XAz0r/ITzPP3OqdPwEw6?=
 =?us-ascii?Q?KBOqChAYABd/45kSjTjmftEjTrbDY6KGvodp+gS/gXNoaW+ULqDkTgC8XiJZ?=
 =?us-ascii?Q?WhEgGBdXAlUXa4DpQzY85UtuELITsQ0dltSn4Qp8pPlOWYOjZfh2keW8yT/B?=
 =?us-ascii?Q?F2R5lS8UmJcviXhrF8GOggs0YgELiSD3mfgs3jrvkIhj2XNwDda9tws8tVIs?=
 =?us-ascii?Q?B3glGL84Ebse+hDAmVKtcf9Y20LBFSRAmX3HOlxGuc07CYNY8J6dgfWjw24W?=
 =?us-ascii?Q?XcIAOCH6jXYbOWvMAaFvTwET09usbS/YxEMuK6Tm+X8LXRkNZA36ZzTsEXiw?=
 =?us-ascii?Q?03uKrnCKQaWyR2ZkCNq25GI2vcA9fjcz8l/HP6apKZfTNrvQbINXZaP8NdK2?=
 =?us-ascii?Q?iWk/Z4y6OnIbQ6MaFEPmYlH9lSrDAiSZ+FPiFZhqCL+rgtU2vwD3zjFwOF5I?=
 =?us-ascii?Q?Xmc5+SQUsti4OJg7pZ3UQ/8av/JEO5ChQnAFxIrMH+qlB7m5E63VuwcUCGM/?=
 =?us-ascii?Q?9Yov9Kc1M7O2L79z3kfeOAByTW/6KE1b/aERsN+75UKECjl1/8WjrB/J/D/p?=
 =?us-ascii?Q?MRKqlboq+0PerE6jA0+SyszcN9zXK/ETAJVrrsjbWlVTXuqAplW2wdsrT0Bo?=
 =?us-ascii?Q?z6QYLWQniqIdRQm/aV8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a206cf4b-ffa2-4714-d493-08dca4ea1b4b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 16:20:56.8015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xavLtay57lajugljX+tB2fE6yRJgGbhcESV1Nf6ezRzXYDYmOF7VKCJP7eyZwMLo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6632

--=_MailMate_093A393D-242F-435A-B9E3-CD6395A6BB2A_=
Content-Type: text/plain

On 14 Jul 2024, at 20:04, Gavin Shan wrote:

> xarray can't support arbitrary page cache size. the largest and
> supported page cache size is defined as MAX_PAGECACHE_ORDER by
> commit 099d90642a71 ("mm/filemap: make MAX_PAGECACHE_ORDER acceptable
> to xarray"). However, it's possible to have 512MB page cache in
> the huge memory's collapsing path on ARM64 system whose base page
> size is 64KB. 512MB page cache is breaking the limitation and a
> warning is raised when the xarray entry is split as shown in the
> following example.
>
> [root@dhcp-10-26-1-207 ~]# cat /proc/1/smaps | grep KernelPageSize
> KernelPageSize:       64 kB
> [root@dhcp-10-26-1-207 ~]# cat /tmp/test.c
>    :
> int main(int argc, char **argv)
> {
> 	const char *filename = TEST_XFS_FILENAME;
> 	int fd = 0;
> 	void *buf = (void *)-1, *p;
> 	int pgsize = getpagesize();
> 	int ret = 0;
>
> 	if (pgsize != 0x10000) {
> 		fprintf(stdout, "System with 64KB base page size is required!\n");
> 		return -EPERM;
> 	}
>
> 	system("echo 0 > /sys/devices/virtual/bdi/253:0/read_ahead_kb");
> 	system("echo 1 > /proc/sys/vm/drop_caches");
>
> 	/* Open the xfs file */
> 	fd = open(filename, O_RDONLY);
> 	assert(fd > 0);
>
> 	/* Create VMA */
> 	buf = mmap(NULL, TEST_MEM_SIZE, PROT_READ, MAP_SHARED, fd, 0);
> 	assert(buf != (void *)-1);
> 	fprintf(stdout, "mapped buffer at 0x%p\n", buf);
>
> 	/* Populate VMA */
> 	ret = madvise(buf, TEST_MEM_SIZE, MADV_NOHUGEPAGE);
> 	assert(ret == 0);
> 	ret = madvise(buf, TEST_MEM_SIZE, MADV_POPULATE_READ);
> 	assert(ret == 0);
>
> 	/* Collapse VMA */
> 	ret = madvise(buf, TEST_MEM_SIZE, MADV_HUGEPAGE);
> 	assert(ret == 0);
> 	ret = madvise(buf, TEST_MEM_SIZE, MADV_COLLAPSE);
> 	if (ret) {
> 		fprintf(stdout, "Error %d to madvise(MADV_COLLAPSE)\n", errno);
> 		goto out;
> 	}
>
> 	/* Split xarray entry. Write permission is needed */
> 	munmap(buf, TEST_MEM_SIZE);
> 	buf = (void *)-1;
> 	close(fd);
> 	fd = open(filename, O_RDWR);
> 	assert(fd > 0);
> 	fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
>  		  TEST_MEM_SIZE - pgsize, pgsize);
> out:
> 	if (buf != (void *)-1)
> 		munmap(buf, TEST_MEM_SIZE);
> 	if (fd > 0)
> 		close(fd);
>
> 	return ret;
> }
>
> [root@dhcp-10-26-1-207 ~]# gcc /tmp/test.c -o /tmp/test
> [root@dhcp-10-26-1-207 ~]# /tmp/test
>  ------------[ cut here ]------------
>  WARNING: CPU: 25 PID: 7560 at lib/xarray.c:1025 xas_split_alloc+0xf8/0x128
>  Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib    \
>  nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct      \
>  nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4      \
>  ip_set rfkill nf_tables nfnetlink vfat fat virtio_balloon drm fuse   \
>  xfs libcrc32c crct10dif_ce ghash_ce sha2_ce sha256_arm64 virtio_net  \
>  sha1_ce net_failover virtio_blk virtio_console failover dimlib virtio_mmio
>  CPU: 25 PID: 7560 Comm: test Kdump: loaded Not tainted 6.10.0-rc7-gavin+ #9
>  Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20240524-1.el9 05/24/2024
>  pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
>  pc : xas_split_alloc+0xf8/0x128
>  lr : split_huge_page_to_list_to_order+0x1c4/0x780
>  sp : ffff8000ac32f660
>  x29: ffff8000ac32f660 x28: ffff0000e0969eb0 x27: ffff8000ac32f6c0
>  x26: 0000000000000c40 x25: ffff0000e0969eb0 x24: 000000000000000d
>  x23: ffff8000ac32f6c0 x22: ffffffdfc0700000 x21: 0000000000000000
>  x20: 0000000000000000 x19: ffffffdfc0700000 x18: 0000000000000000
>  x17: 0000000000000000 x16: ffffd5f3708ffc70 x15: 0000000000000000
>  x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>  x11: ffffffffffffffc0 x10: 0000000000000040 x9 : ffffd5f3708e692c
>  x8 : 0000000000000003 x7 : 0000000000000000 x6 : ffff0000e0969eb8
>  x5 : ffffd5f37289e378 x4 : 0000000000000000 x3 : 0000000000000c40
>  x2 : 000000000000000d x1 : 000000000000000c x0 : 0000000000000000
>  Call trace:
>   xas_split_alloc+0xf8/0x128
>   split_huge_page_to_list_to_order+0x1c4/0x780
>   truncate_inode_partial_folio+0xdc/0x160
>   truncate_inode_pages_range+0x1b4/0x4a8
>   truncate_pagecache_range+0x84/0xa0
>   xfs_flush_unmap_range+0x70/0x90 [xfs]
>   xfs_file_fallocate+0xfc/0x4d8 [xfs]
>   vfs_fallocate+0x124/0x2f0
>   ksys_fallocate+0x4c/0xa0
>   __arm64_sys_fallocate+0x24/0x38
>   invoke_syscall.constprop.0+0x7c/0xd8
>   do_el0_svc+0xb4/0xd0
>   el0_svc+0x44/0x1d8
>   el0t_64_sync_handler+0x134/0x150
>   el0t_64_sync+0x17c/0x180
>
> Fix it by correcting the supported page cache orders, different sets
> for DAX and other files. With it corrected, 512MB page cache becomes
> disallowed on all non-DAX files on ARM64 system where the base page
> size is 64KB. After this patch is applied, the test program fails
> with error -EINVAL returned from __thp_vma_allowable_orders() and
> the madvise() system call to collapse the page caches.
>
> Fixes: 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache")
> Cc: <stable@vger.kernel.org> # v5.17+
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
> v2: Corrected supported orders for DAX and other files as suggested
>     by David/Matthew/Baolin
> ---
>  include/linux/huge_mm.h | 12 +++++++++---
>  mm/huge_memory.c        | 12 ++++++++++--
>  2 files changed, 19 insertions(+), 5 deletions(-)

LGTM. Thanks. Acked-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_093A393D-242F-435A-B9E3-CD6395A6BB2A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmaVTGYPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUGIwP/3xsMSlyBrhukc/G3KaRxyYQ1IjIySzArwvr
A9LkDElLvPg2Qolu+dfidvrFxT9GJJ5IBdYWslvR+07jv7m2+liBcTuc6P9v45w0
njDa2KUOHRzkHL8Vjwxg8CRn4qplk103A3r9DDPAypaO9cjvO0AiARxUokqJrq8Q
NViXFL6lZi4O5ZdQwG3DBe/ygBNx2QEnMNNU5eNFa6TCm/ITlwu/0PNUImybfaQ5
Rtms+HKwYrlQHp4v9dBHL6JrIJVh81YsZXZFOiDey90gIhblhgYAx/lG1DCQzxgl
vjnYHEDUSM902IZVoCGlEzFuZ0v6Q0wGnrg6Hjnka+Lwm6hoF+i5eBgMmaEABiT8
sF7sABLJlHGFHxmYUN5RI4fTImt6E3ugGOdoSB7lbV3E9yM/Fw+hcBxlghOw2aBN
8jx2OZRpbwxfzax97tf0cSDlb8W67kpEAsDUJLkp+8t5gwZTZJFiAk/uB6Yr9oVG
l3nVicBsqoVXSxe3/ru44v2o9Vms47AAo45xZs9mU5gejYiU7G1lq2tufjqhQ62X
s+9o96ijnG5rxNxKYSPeYLgSnPhi5XTNTuaq1yWltlM46ke5jJlessb8NUe8B27g
S5WN+dvkhRhs+hKm0OO/huMncNmgsEl1ZKVbVmXbKOiwIFsSEwQiDOpuQABiNImj
Xbbz6FDa
=puT/
-----END PGP SIGNATURE-----

--=_MailMate_093A393D-242F-435A-B9E3-CD6395A6BB2A_=--

