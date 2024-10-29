Return-Path: <linux-kernel+bounces-386893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE6C9B4926
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F5B2831F6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF9E205AAD;
	Tue, 29 Oct 2024 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q9QxWqcK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GTBQI56G"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642F6188CDC
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203800; cv=fail; b=rG8bpq0W493gjKkPymR5+zFqraFq1/9LjvtTp+XJj7KzXE62BhcE3uMcMwZwb2EeIZIPD0OzULPRISQYPxd8Zol2/TzE9vQIwK//8Pn01SPhdZt+AUB1/OqzpL3ujobnq8bTLjIL8d4FwCG1PVDObbB87JqepC6LFf5qQekbTgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203800; c=relaxed/simple;
	bh=IGBIhuPjRGOeGiu1iiM92RmblPmBKBmY9FM0NdtBwQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aovaTl0xg0d0/fX8WBiCzTR4DuiqAcV+ph7cmy1Mw8h5XMR0qyYpoJLVhRDwMVpWSOxaGIXcjU995HbBkbgD2w5tq3ZqH/VYELRPk/hWxpv72okfqbD8qIdZ43XdFDMkPLyx78aphFZdWl86UhH/vFu6WmnoeaJwDTgeyxBPV9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q9QxWqcK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GTBQI56G; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T7tc57009065;
	Tue, 29 Oct 2024 12:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=hNrBqWxDYgFHsaIcRW
	xVnG/r6OPr6WAz20/VNA5VB7Y=; b=Q9QxWqcKgsQdgVIzinF0qwPANGXnQHdCV+
	CQTq6my/Hwvl66Jq1yse4PTr1GtKLF6XUTHWvVTjfZKvZuHDQG1WEnBIv4M7pqZz
	HoHId8NXK6zXvclO4khW1G0+xEmY93pWG3vaB1itdGDW6JS1NlgxqPObRTdkwntc
	sVnoFVH+OUg1Q4c3LdvUL3NJiqSHbYzkbDtjEkFrw2GLTCubtJiBBIENJJoB/cPk
	hqO13NCN7YgppW9nUjQ13NXko1dVqTSe+vidNRIsQSZgsgTvMr8j36TavzFz7t6t
	kXgi+fgBD/ezhjIQR6Y7ZHtKE2ZZgsk4pfLmhvibs6sJL04+QhiQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdp57px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 12:09:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TBD5Xd008454;
	Tue, 29 Oct 2024 12:09:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hne9hyu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 12:09:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKZMkZf4rkxojWulRqCvimX1J61sCJjNSlruWL2id6g6BhlTCPkWKM220prGwQHFGSgLE6l0AMgeVBpymAkTlSNU8X8dHqC+XUkoKW0LZKRn1c0ReQtREtWvC/AnOngPse/eQgiz2OzngKgJB+LmMcdc/icjLqbPWDBGErF/buPtTrSi+lbkEU5JUSFg69lNW1MkMSxzp9y01D96OSwyg8tg5AMDN+UvjlPN1Cl6m3/153NnK+HAC2v6OKVosJDCGh0MfBsQyWWUY+nE5qnqmHqT++5kXlcAubO9neo5FJwT10aDWFhv6RuTbmAPfRmC9sN3KhCb1AWevp/NPkwcZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNrBqWxDYgFHsaIcRWxVnG/r6OPr6WAz20/VNA5VB7Y=;
 b=V059uhaGm3DPX2MvrHMypBLxEI0hvfK8DbaeT9wtvoOxuSQga9H4/o4Ag9OfCLBTdgvkLlXKQzdRZAUJRovdG7ky8R5DMPJ0UHqvosjtclljgS4M/TBfxBDHmHx9eYPHtkW0RrpONGIizr59O5Cx0FpYgbLcPq5qR3h0HRn8suxTRtXR9Mp811h5kLxOyiL9KlYcJ214y+usX7vXM6G8dKTDe9SRc5hrUJK102M2kMWDMqvolr2X29ch4ZGYKLKbUkVRwCe1lx72O+zBLTKR5YjtaZWmFXJ3Ev5mwiNE3zpRK1ERjARdRNf68EZe36LGyQzYL/lfgtxjyL6j1nyYUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNrBqWxDYgFHsaIcRWxVnG/r6OPr6WAz20/VNA5VB7Y=;
 b=GTBQI56GznivK9pNSmkLJltqR5/ne1adSWRAlY2+DJ3+0bMjrrg5L5opzBhEKdn8UEH2cBQg3uId2ERFqypn0atXhLpXrnR+6oPh7+76MG/Tm3/iP3mae76TI8HPHDWrL1a6RWz2HfhWljm+Pg5g8ISm1WGcGLKSb82y8YfKjhk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BY5PR10MB4177.namprd10.prod.outlook.com (2603:10b6:a03:205::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 12:09:48 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 12:09:48 +0000
Date: Tue, 29 Oct 2024 12:09:45 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: syzbot <syzbot+4b5c704012892c4d22fd@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in zap_huge_pmd
Message-ID: <23811290-dc18-4f54-8222-929969e6ed9b@lucifer.local>
References: <67205708.050a0220.11b624.04bc.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67205708.050a0220.11b624.04bc.GAE@google.com>
X-ClientProxiedBy: LO4P265CA0264.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::15) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BY5PR10MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: a20a97a4-8fff-4243-c75b-08dcf812957d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bAI+3Aj2db1cfQN+WeEIjJdJ0SG+a/UAHmDCBi24lLf7A6yajG7pX3gUn3I6?=
 =?us-ascii?Q?l2/GvbagQGRqkYQL0Vmj39AnOb0iLY10JhLyzGhKVzfJmDvRPuT/wg7jsIyu?=
 =?us-ascii?Q?uoL1csCseHpelSARutMVT6BhuEsnZ3QImy83khMBOGB6n1w9rcl0lw95OTjh?=
 =?us-ascii?Q?Xp7BTjCNrmBR691b4WEX5nXDT/FDmSGnM7miJRRQlv+S+Mk8l3cpS+KsJLlT?=
 =?us-ascii?Q?QiKzWofX1Yf93QjvUhaywKcyJWdXk8QXfioumMfcpsNOKsgh9oJaG3lzsY4R?=
 =?us-ascii?Q?3KvNk4rXDRIt0MgRd5xK3k/6iH0QNGcLzNt9en2F4sICQ5nSaOWswqHdEj8R?=
 =?us-ascii?Q?X7i5PexD4U5PExRHri0sBTcTfKIQ6O3eWHvMnmvJ5yOXdAplm4AlE9CgnTib?=
 =?us-ascii?Q?XydDQdpeAr5uP7BycjLK8JU5OfAsUHWQoto4nQQJNB57siYuKYLQRmQqlfXn?=
 =?us-ascii?Q?ghzI05RBeC1C43bzdqC9QUsHLLhq6VVpMPBLC50+LjqvuKiDpnDmmCRipEJQ?=
 =?us-ascii?Q?0I3tbfe0xC2GWXW+jKfiqtj9lUK/5OetuvxZc0B5YkhbFXQnZ0fUr+5DKsPi?=
 =?us-ascii?Q?S7aTwa0UjbRtpvdf0Lqn+x/Cwt7uFJ8qkBvnpW7TLyrQWRf8wtSYkx7PELAO?=
 =?us-ascii?Q?YmYqOMpXvusngmmTLv15Xz87yYKf8LYZjWgDMHmXGlUHu6ZmjmBcKuPFURGN?=
 =?us-ascii?Q?G5DRnC9Yd1FzSRDF0/C4mWtJ8QqSeZpKw9p+2L1NETvHSSQ4iRA7QNM0ckPK?=
 =?us-ascii?Q?bviGGcOjX9RPOtU/JdA1jMin8ZfxqoLbA5M3pkLNOtfniGeP0dYymdtO34r9?=
 =?us-ascii?Q?P4wcycw0lMNIwfLwnh3O/tqhcPl93B7eqw71Ror11MM8Zn/y8G6PQLNEPJIp?=
 =?us-ascii?Q?AGKmOnYu96s4hdhUQauXD0Azj+5/E+iNHanAxg9dVnnmA+zrc7Cr+ddfnlJJ?=
 =?us-ascii?Q?CmgbbLxe7NajKscAwNYAouAKGi9XLIotb9UtOuUQ0zX3Ldj8IJNB0f/g7fD4?=
 =?us-ascii?Q?X4ISdiAEom/mKTnzwaP+nFmEsSInQdWlJofjN+/4d9L70O9gOdHlZOfKQcJ4?=
 =?us-ascii?Q?Nq+8wrOO5jS0n1mdfSPbvucOAGsSmwBtWqE6qVQIK26YTzSQTan45A7CBJNN?=
 =?us-ascii?Q?o2rz1cPms+bHeKBsBKqzWbu+JLSMfyB11SElLcpEitqXfvj52c5g1oJGKGBB?=
 =?us-ascii?Q?ukjHRkaSXZ1Mn9Le+sJFacUJWaYSK/Git2LGnb6+DofQNZ7eili7OBpTx+Mx?=
 =?us-ascii?Q?XO4hb7cvjvjF+3szny/ZosOXs5mthF0LTGwChfIGmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6zPzx+BHao49CbBs7jmf6gZ6Lv7bXkKsw1Rp/gqhLGsqwJwBlKG6GCQTgCUv?=
 =?us-ascii?Q?NPKjF106IeKPS1C0El8iuLs5mhHQiQAHN9nVp1ZzIFVL8spI85Rva964vyRQ?=
 =?us-ascii?Q?Vu/zAbpY3PjrSzVJO63IOn6NuX6FNKVA5biAWZ1iqgvNdsA8il9kPhxg5/oS?=
 =?us-ascii?Q?hpvYykVBXc2BApET3kbSV4+nxX85mEDkCXORlB/MItAKhV0Ao/n+ohFWuAqH?=
 =?us-ascii?Q?mKl3xGNkibLhO4y4snaxXFY512pderrPrvHpD2zc5YQTX8iY6e9azdr5LszU?=
 =?us-ascii?Q?GHA7gAlNGR0oqv2FAAJOA2yUBjU3PF+rPUMA8esYjIjWf138yyEIzXAmqM55?=
 =?us-ascii?Q?TqpWezeqfqmdWSRo2OgJdPEDQF4OvWfFWPA9rmFm8l7XHNVKJMzgDcBtXqmP?=
 =?us-ascii?Q?KRhna+mm2Ns4t+b3o0+P6YUNwb1KgjyUVM0S0hsMgfVvx/mrCceS5jnI65jW?=
 =?us-ascii?Q?ifbHGCyKeCqtWI6emH4F0bWYyI1ojSotFN4Cjjc1tjz9qF4kzsgiu70JN9hO?=
 =?us-ascii?Q?J/BItNBUkK4BajCybnitQXIbbu2zQteS46AVmpM92dZcm/AGt/ue9hpQNnDy?=
 =?us-ascii?Q?T+KQdyyxsimCPVyjYK4e+4Xt0aEgoVdGs+TVHCO/CSYx0MXqDY+YEpVpHGkg?=
 =?us-ascii?Q?dws8zh0cz+3kesHtun89vrRf2n1YCAWz1rVPEqHwD37hVhHQeRmZ4Tx5jls4?=
 =?us-ascii?Q?dFAQuEnaWocIiLRWawtI0HQ/plzEl3pTQugim5775RhWUuPM3po4QwJuQnii?=
 =?us-ascii?Q?qIa5QIKMtwZryYf5Wy93VVykph65X5VsUOW6KDsCcfDxCqUtGyK8gyTkPvPN?=
 =?us-ascii?Q?FC6bLyPlh3wmbNxtKs50vp5Q42JI3PG3J6wgjFhMhHC9bMVcCpdBg+S2/5tB?=
 =?us-ascii?Q?xkP8F927iuuy9eBhUzta4fbZOWp7yEBK/pEUcnCZ2qSiZcvFTHX4vgH1whEh?=
 =?us-ascii?Q?vUEVtQDcSjKSqjIRYXDzBBYlK5De/gRCU6o/KZrGDlU4VpJ/e/lPtQ6NSf1a?=
 =?us-ascii?Q?/9cfA2J1b/tdoZCX13wX9DAwO6KV7gc+M5oA42xI4TQFqyT9I87zaKKcuVa3?=
 =?us-ascii?Q?hoQ/uGqs/2uuSF3kwM3RM0d6fAGdQNayJTXGuLK7npyrzPFxMuy/ymMVntXh?=
 =?us-ascii?Q?ADFgbuhs0Y0Ryfo1hSbNiYiPgALYu9qf/Uka0RuIhSjkO06QIc3FgdDxq4IN?=
 =?us-ascii?Q?DoCJyaktgB4XgWGWzTvrplGTQXLZKBM6PjDamIZ5twu56XjH6fIu1w5b7T/h?=
 =?us-ascii?Q?yldxrpFZo3+w1EE0CHDMpBOiIYM8rMxwK2RL3Z2ttCFd2MpHDcPEKmCmw034?=
 =?us-ascii?Q?UTJtjOAiL2HHVgpeoa6NsWUWmxWn/NOGRwTXDkF72vBWpot4J54P3kCyyUlE?=
 =?us-ascii?Q?64LLP4tK35Xax9SNJACp1eKeTxkZnyXsM71D11C/MNTWQNZzg43IKDg989fr?=
 =?us-ascii?Q?nnEwELsPhnFZXMEXNH6YPxkPLyfDSj0xNrP1EPozdiPQHWAW1FxJPn+F6j03?=
 =?us-ascii?Q?nA+tdBg0uwNNzDVgKZ/hDSX5uwidAVs+TbugkyDHh8qKeDw3lhWXoNoAKihO?=
 =?us-ascii?Q?BspETIY42NHP+E204goK6KNS5J0pAUWXTE4kHaOlwbiyzoI//TbgmyogfQH7?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Lb5Pn7I43t0Ciw8YsFLz1a+mW9iTFW34DV9bHIP5z1AYeFWlv62VrHRoMCxXa2kij9bw8Ey4Z7WkIrM1OOv4galwLJ16+twP1d8fKuWvzSr/QVTBPYGvD7iTwJmxNTO9eJgfMjdgwyKGw4DMLwtYYEbmoqzTdyDXue++9j6DnE8bRH1QgunmmVPLoJ6hP5sCP9r0UC2xJojfqThm0gjbqTNZT+vC/XPnWErltD6BhMiL7W3jwK5J7yRG3xQthttL58yln+Vt/ViQxFusUdZH/x82LnAelkntbO2RLjBIQNs3ejN71OzCT9eZ//qZkEyqvgmcQO9In/nYG6MHXcvrROFvZNjM1AHgJYSxNg7oQfgpo9Tqt0yRkP/ZtsAiRbeMsJeckpB/AnvtYjDGSbyraXM3e80YtAPS3Ig5YdTt3DOcjY3lYPazC2BojrzGxKn8rtCDmJQ6ZV8Y8wrvZ2Mqf0qB6MDcrv2qlX0Z3Lg6ETmdlIwAmc3kjNuVHpxvx0VmuFq1gfqzT1DBtmPw9tXgWMNs90AFzM2VASQG5PGGdkGvCrTYf9USSqjyDqFVlqPq1JM3dqA9SqQXadISBurZ5vdwhMLdDDTS1wg+5x/OCT4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a20a97a4-8fff-4243-c75b-08dcf812957d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 12:09:48.3302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqMEgFaK0yhAkc9C3f/YcuWBzyoRrvGvw5tHSF9RJoQhSwmIFHti2F9esYIgE6d1eXLn0gjBMxph9n0LKrul9v8RZoXTuYLpYBrpKOks3h0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_08,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290093
X-Proofpoint-ORIG-GUID: Ut-biDtTc1XlIqDF5wfHJwW3pu3Y8ci7
X-Proofpoint-GUID: Ut-biDtTc1XlIqDF5wfHJwW3pu3Y8ci7

On Mon, Oct 28, 2024 at 08:31:20PM -0700, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:

Thanks!

>
> HEAD commit:    4e46774408d9 Merge tag 'for-6.12-rc4-tag' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10fb2ebb980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
> dashboard link: https://syzkaller.appspot.com/bug?extid=4b5c704012892c4d22fd
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f730e7980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177eae40580000
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-4e467744.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/058a92aaf61a/vmlinux-4e467744.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0b79757fbe5e/bzImage-4e467744.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4b5c704012892c4d22fd@syzkaller.appspotmail.com
>
> R10: 000000000401d031 R11: 0000000000000246 R12: 0000000000000004
> R13: 00007f33ed7673fc R14: 00007f33ed737334 R15: 00007f33ed7673e4
>  </TASK>
> ------------[ cut here ]------------
> kernel BUG at mm/huge_memory.c:2085!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 5095 Comm: syz-executor380 Not tainted 6.12.0-rc4-syzkaller-00085-g4e46774408d9 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:zap_huge_pmd+0x953/0xc40 mm/huge_memory.c:2085
> Code: fe ff ff f3 0f 1e fa e8 ab 16 92 ff 48 89 df 4c 89 fe e8 50 ba 08 00 e9 2c f8 ff ff e8 96 16 92 ff 90 0f 0b e8 8e 16 92 ff 90 <0f> 0b e8 86 16 92 ff 4c 89 ef 48 c7 c6 20 65 17 8c e8 37 a2 dd ff
> RSP: 0018:ffffc9000aeef1e0 EFLAGS: 00010293
> RAX: ffffffff8202c152 RBX: 000000000000001e RCX: ffff888000b70000
> RDX: 0000000000000000 RSI: 000000000000001f RDI: 000000000000001a
> RBP: 000000000000001f R08: ffffffff8202bca6 R09: 1ffff11008416106
> R10: dffffc0000000000 R11: ffffed1008416107 R12: 0000000000000000
> R13: ffffc9000aeef750 R14: 0000000020e00000 R15: fffffffffffffa00
> FS:  000055555711b380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055e22940b470 CR3: 000000003daee000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  zap_pmd_range mm/memory.c:1719 [inline]
>  zap_pud_range mm/memory.c:1768 [inline]
>  zap_p4d_range mm/memory.c:1789 [inline]
>  unmap_page_range+0x762/0x40e0 mm/memory.c:1810
>  unmap_vmas+0x3cc/0x5f0 mm/memory.c:1900
>  unmap_region+0x214/0x380 mm/vma.c:354
>  mmap_region+0x23fa/0x2a30 mm/mmap.c:1583
>  do_mmap+0x8f0/0x1000 mm/mmap.c:496
>  vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f33ed6f19e9
> Code: 48 83 c4 28 c3 e8 c7 1b 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc77c44b78 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> RAX: ffffffffffffffda RBX: 00007ffc77c44be0 RCX: 00007f33ed6f19e9
> RDX: 0000000002000007 RSI: 0000000000c00000 RDI: 0000000020400000
> RBP: 0000000000000001 R08: 00000000ffffffff R09: 0000000000000000
> R10: 000000000401d031 R11: 0000000000000246 R12: 0000000000000004
> R13: 00007f33ed7673fc R14: 00007f33ed737334 R15: 00007f33ed7673e4
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:zap_huge_pmd+0x953/0xc40 mm/huge_memory.c:2085
> Code: fe ff ff f3 0f 1e fa e8 ab 16 92 ff 48 89 df 4c 89 fe e8 50 ba 08 00 e9 2c f8 ff ff e8 96 16 92 ff 90 0f 0b e8 8e 16 92 ff 90 <0f> 0b e8 86 16 92 ff 4c 89 ef 48 c7 c6 20 65 17 8c e8 37 a2 dd ff
> RSP: 0018:ffffc9000aeef1e0 EFLAGS: 00010293
> RAX: ffffffff8202c152 RBX: 000000000000001e RCX: ffff888000b70000
> RDX: 0000000000000000 RSI: 000000000000001f RDI: 000000000000001a
> RBP: 000000000000001f R08: ffffffff8202bca6 R09: 1ffff11008416106
> R10: dffffc0000000000 R11: ffffed1008416107 R12: 0000000000000000
> R13: ffffc9000aeef750 R14: 0000000020e00000 R15: fffffffffffffa00
> FS:  000055555711b380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055e22940b470 CR3: 000000003daee000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

This should be resolved with recent changes to rework mmap_region(), let's see...

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/ mm-hotfixes-unstable

