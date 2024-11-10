Return-Path: <linux-kernel+bounces-403166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64199C31DB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 12:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FA81C20308
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 11:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C25155756;
	Sun, 10 Nov 2024 11:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f4k3ZUMw"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B51A149C7A
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731239577; cv=fail; b=KwW+NkI5kxDWialuQujjocl6rBtybUDZGcr5xLyPobvH5DG1pcLgPVzKNItgqRGF5eGpuTKeUcWwOmjgk4WLzskyCZmfJuQ4T+lxiYwOYKWb+jFE/ARCEThBju+c1chXAaJODXmroDppJsZyyfu3QjhXc7eFw8lGdnNJGnsepbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731239577; c=relaxed/simple;
	bh=Ljmh6Savq0YlDof/k/w6lmSa7CVRQLOBO6ePjoWvp1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=onw60+Q1CRb2YzK3p2/4S4ivyQET+dZkFLdE8j5arSS36PZPBQT+jhNWv2kQU0oIAa7aOWGGyilf5CoHTt3yR4KrIiPyV9SHqczC7KRU9+QPIHQHJf3nlEimOn0hT6K1pnsJZmuL7QzN7oM7JOddLHLlsF8TSk1Wskjh58UyfrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f4k3ZUMw; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0b96IRGm9dxpYEfnWg4ulD1dNuRximrFENk+EkRZOQZc3kGNttJ9/GZ6Hcpqgo08fMIXRYEXqhoRzRWtFvLEg572W/t8o/o9b4QIEzZiYsT4cu0aEU0i9sWT+LBOKK4jfavRbgfDWXD72zzlKGe5QQBOhqnm8LTU1OzGuOK4+jBhVprCNN+eRQRmjVh7+UAR9R75TJ3/Ey/se+BrLuVzmY5mSM+xSu2LA61QFLHgcWv/Z/1FG2OdxeraF4wh71jobGDChgIEd69vbML5ddZd8efJBc6moJ+UnbzFFMQ9fGBnqup66IflePgxPmlq9iswvBWrBHsTzqWwMQ/PfX+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxOGICpTs/KXBADdZA+n+Zf/47/0YPmNon5dxxBKPvU=;
 b=QqbzKnoW/yjAMfmxNDVsbNyfckpG7bp+oc9U4sUUb1GgJMVuReKk5kLpWU/u68HhTSDyzYwEpcftKBhRORUfCbDUG7htBmQhaZjmf0kseKNVzV2eEucCtCmQphyyQPqThZ3oRdg4TDHU6yMUqUOTltlBjtmnBcHriAJdoXz0naCGFBSRMO5hISnwhQ6KHgvNtUgjJqgKeSJJ4YhWzCdd2VIvbP2xc2yTuc0Ia83x8Qe/TTTVOaFPhRtOpak9z2Q1CM1Rk1mlf9XoUudVC2RFa9FdrbwDjcrIMSNoBr7N2tyskErV+kk9A9tO8KpdjoOXIHOD8NnIUooURZNiSAq1jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxOGICpTs/KXBADdZA+n+Zf/47/0YPmNon5dxxBKPvU=;
 b=f4k3ZUMwOzbSOQlFZufzOuVYIxYSyVKvBvCSAS3aYfHLLxDRqD/pK2RQ+RDuzkIXMKAVTGOYLGOizk1nnVC6yt3hm2OVeeOfsJlH8mEg4psBZe1SJMMeD+UQWXp4Ni4xjKMSUbM++TrNzYI8yucgralx5X8YJ+jsGXyCEwb+IthD5I5dHZiksgzl299bRFWR/E6zEd61i2QveX+3D4nr0//Lo5zsRvfJ1I9KfSMaRChKsU7adSDlijH+LBgF/Vccx4/5BVJVuPBDu834ii+oXvDPBbxFNWKMSwqwg2SJRTPQgY19Pcw25TiEwvnUjugowYkqBRt7kXzU1BpS47RkCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB6859.namprd12.prod.outlook.com (2603:10b6:510:1b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Sun, 10 Nov
 2024 11:52:50 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8137.027; Sun, 10 Nov 2024
 11:52:50 +0000
Date: Sun, 10 Nov 2024 12:52:47 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <multics69@gmail.com>
Cc: tj@kernel.org, void@manifault.com, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, sched-ext@meta.com, me@mostlynerdless.de,
	ggherdovich@suse.com, dschatzberg@meta.com, yougmark94@gmail.com,
	changwoo@igalia.com, kernel-dev@igalia.com
Subject: Re: [PATCH 2/3] sched_ext: Rename scx_bpf_consume() to
 scx_bpf_dsq_move_to_local()
Message-ID: <ZzCej_1NNr2wB0AD@gpd3>
References: <20241109194853.580310-1-tj@kernel.org>
 <20241109194853.580310-3-tj@kernel.org>
 <81281555-d57f-4507-a3a5-ea9d1aa27871@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81281555-d57f-4507-a3a5-ea9d1aa27871@gmail.com>
X-ClientProxiedBy: MI2P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::12) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: df68a2ae-8e89-4957-87fb-08dd017e3409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hkiPP4Az0ckSoybEs9WhZySbIWKze9raYPNtlGn2K+OrnIeYiB4SyBsAvjCk?=
 =?us-ascii?Q?6u1vGXJR8O3o3RqiBFk0ckVrGfKYyVOGjkO23R0YItJNgRJvJ0iRlqbBF7EL?=
 =?us-ascii?Q?FfxkGDO3+NhouXfPIUakzzpOJ2SCvtWNDphNNMoU/XcytOEHF1P3wkiiRY4A?=
 =?us-ascii?Q?h91UstkbWDfurfI41p/E1qaxbqaR0F0QQn+9y7aKVoghqhjIrbJbITlG2bWy?=
 =?us-ascii?Q?Alk33d/Jyx9n6I4CJISTvtBAMtJK9io7axEVDLoApnuN8GxJfx2QW1b7JB1/?=
 =?us-ascii?Q?V/Vjtk+FWBy7gJUWpQh3Bf9lE7HgNLmyc+ndXUefvn+X06X7Ecz7ogw36yC+?=
 =?us-ascii?Q?9S5Nxx1QLuJWQnGXhbC8XiF0Z/uJfQKWnjRS/M3QRhiR+8y+55vwCislRjG6?=
 =?us-ascii?Q?wzjUvxBUgmEsuysTj7of5jI2tzglr0VqyLfJJWuMSzIaqkbFSoXCkOlIk20p?=
 =?us-ascii?Q?3M3jDQGuBESbveKaDepnadKMiRBzEUUIQxOnbjm0ssrmatyFOdO4oizsldiT?=
 =?us-ascii?Q?TiC0oHCIFH/7B9VCCafUW4H816l2b8i4Wh50S2bgvkpVpInOPE1xozDSYr0Y?=
 =?us-ascii?Q?U3d9Me3raAiwg81kIQn+HLC53tHc/f16ECG8kB8z0DYdEURPL691roZpQCEW?=
 =?us-ascii?Q?qUFa0Q1UFIZSactwj6Sp2NSSNMMKLXRK76CwxGUWF+Dix1TTHvW4suHlDSg9?=
 =?us-ascii?Q?ygrJ29Kb7DI26yOb0NVPKa7cNdWpk0CdYNvtHgKFwux0/uVnofgO0j848+J0?=
 =?us-ascii?Q?TGPsXhusnNr2OFSMpOkyvboiR9Ix+mOPMRW3kWayllkcl45NycOnjnd7DZIg?=
 =?us-ascii?Q?XpAe5dSV9B0L/HArXIcUR0S8x6Gx2S49Od3/28jAjAjxr97XtA972pljaMEv?=
 =?us-ascii?Q?aTW4NGJYE02Z9hkneU/EVq3tPVoDquhIJy8ZZ8amTo6Lq6WaZUKemVpo+Ojn?=
 =?us-ascii?Q?LTDSY8Hgm4yOByCgF2siaA+DkHVZpmOk/3jVlCB3/PjQKGdU2pHuIeghysZ1?=
 =?us-ascii?Q?im0AtNgugz0FdIPdgkworIbUBfEvdbS+c8SOcdn/aRMpiCaX43eLKO+WTJTu?=
 =?us-ascii?Q?cMpeS+/trIYapRwqLO4bjeFlEVGS62P6v5W7C+Job+nnTPpQVcV/dXriisGI?=
 =?us-ascii?Q?g0y3liKabNdAY940WkWl2xFXGpkyFKADVOI3WQULaBNtfc4ToAQOCAjR7ZJv?=
 =?us-ascii?Q?mmYa87RLD3PnDrcN8lPE4s95rH+37HJwNfgJViTGKTPH9qoOL52qzLrRABjt?=
 =?us-ascii?Q?rDboL8QsVTGvNaeoTnhcX1kwK3Nk0oI+xEWDy3rmG0AGMqEKPsgyrQWRFUAt?=
 =?us-ascii?Q?sVNpJEeYezJXWszDgh7KMafl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?621PSBnQiyxYMgE/0fz4mBE7OYQGwe43xCiq/zmeCPXJNJwzhVnaHtUtE6Gu?=
 =?us-ascii?Q?JMWOIq9DpN+/5+5DkkxNXMcCfNB4/QvZcuF6ZEHVFAk262xrVkuwL6qwMo6K?=
 =?us-ascii?Q?fc/qO/OZCh5YvyhUXJZ1qSkqgo0eJzam9RCsG3ju4E/IJmwm6LKT85cenIns?=
 =?us-ascii?Q?s6CtzHfaxwzQOa5RElqfI/GDdkQSSIP9s0dLOvG33hGkDzTnz+FdJlnkge/T?=
 =?us-ascii?Q?VMq2B2ujOm3Yh/sFQFJmvWV3D70ZwltC1ErC9Ylilq+gSVM8hV42a1TDDKRP?=
 =?us-ascii?Q?/O9NBcD2KkmfjzmdqomzftEduQ+2z/w5VOn/hfDPG1AtJdeurS4WeyarOkNu?=
 =?us-ascii?Q?Rh2hQL7sGgFkCnJ0xpJ9r4w9Nb6T8Cv18vSc88Ssx74s67VlA6ARIWkdKYff?=
 =?us-ascii?Q?bCMN+I5wtWxPyCH2eECJ2pc8KI9CarUdGm7/e86GWtYqesUKa328FWuQIiD8?=
 =?us-ascii?Q?S6qD6+A9Q/6J/rWMezuKa+rHMR2TMrXmF3/gCa6UOJFKSuzCeGDOrwHC94++?=
 =?us-ascii?Q?jY71dnMKuf0b0JT960UUMse17fiFi3MPKqiD5iJj60EEDt7/rLxjpwhfpDq5?=
 =?us-ascii?Q?DIVDr4GI8QHGQThMPHSpP6yHMV92swBmIP90e/CEqsmMLD9ZtR3vP8Pa7pNV?=
 =?us-ascii?Q?xpK6xI5audbxpkLC7phwLCiJnawsnsOju/I9pg4a0SBF7SPLPZa+zklaIgxZ?=
 =?us-ascii?Q?sdR8DgciNupHz9KYuEy9lfPAvoKVMPhIXeh97UGWfoWzNTecpQf/MATkJ5A4?=
 =?us-ascii?Q?o7u9dsk/GFXmHnM0riz3tTgJtxucjgIdH3yrkme/2VWgDsz9M/o5EsfCAnWy?=
 =?us-ascii?Q?vIeabFXbSfVxV6DX2Ln/Py6EyJrN4gnHQ/7nN5ZxmH8v+FdChgo2ObpbkO6w?=
 =?us-ascii?Q?fYvBbxXXdjy2K3RNh4yGRT3KjFre0exF8oc3Jh3oNroCPFTh085oi+vBjDjD?=
 =?us-ascii?Q?Dlz2lOGq6jGk3s0JQqXqlkhzOsbdm53KyDZzeT7l9M/Kq4CHOAluS8SPIGrA?=
 =?us-ascii?Q?+otA4tZYnbWrwW+giUTzBXXUnMz8eLILPl6pkFE1AjYwn7QVh3DHB2+6TZCg?=
 =?us-ascii?Q?jHOlh3i6caClSrKhWUH4sILhcTBq7FAwekguq6KUvlaHJ1/ohBrS07q/JM3M?=
 =?us-ascii?Q?GOgqCc+3tApcPBnXYutbwqpzr31H3SmouJK8SyptNzP/FrTkLO2tO8EzmcF1?=
 =?us-ascii?Q?qvw2r6vOlP3PZisMRh96ktyIRKqBGcWE51eB2GUNY/bVP2GwnOpXJjwYItx0?=
 =?us-ascii?Q?QtM8KaqGaaoiH7Gafa1UPNhZIx0zvlQq03y+D/D1rxENRJ1ZrFzwjQ5wl2yh?=
 =?us-ascii?Q?02nW6ppsiBQWF3+Qx6Qh4jkFlYrdvJGHvnS+OgB0u57dAdOxfmcds7LMlKP9?=
 =?us-ascii?Q?aWY8vt0ELqBjNxy3R2sBWZ10whtVbAhwZXOrAfCrJpBwbFLup4PvV9XSITQ9?=
 =?us-ascii?Q?p/ZChsU3CCjd/9JK7O3iCcDrvADkwHxNRgxBTSD6UEv0yyGiRlsWwfSQ/iM9?=
 =?us-ascii?Q?cFBwU6g8TJVylNeuZq8yV9ZhyO79xuZEvNxP+EfMHtMDERoF9lnfvSw7x++Q?=
 =?us-ascii?Q?oK0huO+XyUswacwZy4jaK9Xxxh127FwoH16V6B7W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df68a2ae-8e89-4957-87fb-08dd017e3409
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2024 11:52:50.7960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gX5BY86Q8wSL5kQRC+Sht4F+6O+S30y1Q6YXvQL42Hixq6rmKSo8KYW2YKIkNxnlp8xUqC5u74p1sO+menQo7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6859

On Sun, Nov 10, 2024 at 07:03:03PM +0900, Changwoo Min wrote:
> Hello Tejun,
> 
> Overall looks good to me. I have one minior comment:
> 
> On 24. 11. 10. 04:48, Tejun Heo wrote:
> > @@ -6372,9 +6372,8 @@ __bpf_kfunc void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
> >    * @enq_flags: SCX_ENQ_*
> >    *
> >    * Insert @p into the vtime priority queue of the DSQ identified by @dsq_id.
> > - * Tasks queued into the priority queue are ordered by @vtime and always
> > - * consumed after the tasks in the FIFO queue. All other aspects are identical
> > - * to scx_bpf_dsq_insert().
> > + * Tasks queued into the priority queue are ordered by @vtime. All other aspects
> > + * are identical to scx_bpf_dsq_insert().
> 
> I suggest keeping this part, "and always consumed after the tasks
> in the FIFO queue." Otherwise, IIRC, there is no place to explain
> the priority between FIFO and priority DSQs explicitly.

I think we don't allow anymore to use the FIFO queue and the prio queue
at the same time. Maybe we should clarify this here and also mention
that we can't use scx_bpf_dsq_insert_vtime() with the built-in DSQs.

Thanks,
-Andrea

