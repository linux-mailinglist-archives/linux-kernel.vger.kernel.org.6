Return-Path: <linux-kernel+bounces-571326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB644A6BBC8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE783B2559
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECCC22B59C;
	Fri, 21 Mar 2025 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mmUwS8GS"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E94522A1D5;
	Fri, 21 Mar 2025 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742564094; cv=fail; b=WdSJIQtCSAB8mWJ0+ydIhuPG3ZrKUfWGbqAq4tGTKyfHD1vW9Xw9DWxt21pZeid/YTo2KhV1j6Wum5oAylmHSkSEB6RKQV0CRfGnnmifGpDkGVMorBTXzfRMjqzPsnLCuOsI7wwiGzvytE0jOpp15pJipjSvIjlBHVFGEzF32g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742564094; c=relaxed/simple;
	bh=l4AgjiWffoR4GKZ8Angr/gYWGWibkUZb84mf7Iw73bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O+HMuvcsRvyAEbcsftl4pT1KWkEAnjB2hwAPcuRe9erVN4Es9AaHZzg5ebn4vkQj0YHIyAA2zOl0b5Sx3wrRyk9kYRu6H78XFpHVNYU+xMIZWMObwb5OIR3TUgtlYOeVSy2UFIi340WLxwas65D0JXbPgxnNyHpEtuenVTNUJzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mmUwS8GS; arc=fail smtp.client-ip=40.107.95.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvHf3KddWjGaG7JFvOzRSXMj+VF0HVo5ogsnVMc5aI3+/8LNsasWSBFUz4yzg+LrJKXAgzF2FSNtbHv0HShCinZwoCvTLKxtbKllrGWnPTCgivZdR+YEb9RLt3WgtHTe7PeDUZjHclj4J41BfZ0PmSAux5Lr2jfpnA8bAA9Tem0lhvnaAywoRMMCDphdGdEA0/E3SfW0UKHFNT5aVBF6JYkXYiXW/bXY2wloh58GX2hCOkIl7SA+mgmBe77kQ3aOl7y8WII+lZgBesdFLBwFcFsJ8StcuEIv8Te15suyzj31mJliXTrnDMHWMVcggFhtoxoRxHPV6/H6fYQ12AkAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r19dy1h/efUoSCKQjibx6+2/93JkupqYItH8fkWVixY=;
 b=s7ClVZVQyMj5zOGrZ6OZhxsXkSKE9sicHZUVJ3VZKXCaKOF2Di1E3FKS69FACiq7s4yU0wQQO85+0XOyM6q1kfgKmbaBPrDw14q1/7AvZaPPVN7xH705JLQhv0b253nvQ+Qi4lzKiX/XQQj2jx/jUwXyq2JV0OGinW+B+cw+nzrlnjAIVtn1VOwJsHC9y3u4KAqmAZAEmFFPO74BKAe4D6lGolaD0kTvdY9aur1NGUaSmy8b3fIeg9kJEBd8Qtb902luF9fG7osp/bcnm1DIoQI9p7PG11qtfp7WvjQHc1CvCD3Ymhpwf7p+Cyu5ds/QPw+H/5+vR6xCajhM4lQLEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r19dy1h/efUoSCKQjibx6+2/93JkupqYItH8fkWVixY=;
 b=mmUwS8GS/ixtccZu0UTYiz4Z1lq0GQ2UlGW9EszZ4e8SkoG8R7NrMFdI1Xsyp6KLHwFY3YtJtUL953sg02OGcoeQfEY3E9P5LcfqJcuisxEBpO6DzHF61pzJbhc/NKyT6El7jXYq477a4KOprRbo5Rkk3Fh+y/b7rj0wioeF31umebLdrjGmBpb1KIl4xdoVOAhP8/nec6N9lLUlNPDZUPbtMOsXqyhs0kFvlx3baFcjBWbGGe6bWnUC4VUmUIn08oTW9aX8Yfyzrq+mboxUoiH6KWjQkpXovy0CaE/JYPm0v0XNNAunPHBDfQd69pN1vezmvJxO9AqI/AXBF7ZkEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 13:34:49 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 13:34:48 +0000
Date: Fri, 21 Mar 2025 10:34:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Changyuan Lyu <changyuanl@google.com>
Cc: linux-kernel@vger.kernel.org, graf@amazon.com,
	akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, rppt@kernel.org,
	mark.rutland@arm.com, pbonzini@redhat.com,
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org,
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org,
	saravanak@google.com, skinsburskii@linux.microsoft.com,
	rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 07/16] kexec: add Kexec HandOver (KHO) generation
 helpers
Message-ID: <20250321133447.GA251739@nvidia.com>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-8-changyuanl@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320015551.2157511-8-changyuanl@google.com>
X-ClientProxiedBy: BL1PR13CA0416.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e8a737-876f-48a0-8728-08dd687d267e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?686swMVR76sdl35h7IhFiCO+06XxqMBVtd9wSydxcgG6fgrhc8JS4EbTpEjU?=
 =?us-ascii?Q?hFVQmDYOesHEiBeYW6N9gavUexIvlkDiFIjDNaYI6WQ+hCqZYp12f3nzI0HW?=
 =?us-ascii?Q?7DQjCC8iJKQjnENGAcOtIAmlIJGIISYMNL+MtbLX8HuWa5crrIY24j+wkCd+?=
 =?us-ascii?Q?th0zrnHtjSK+UAZAa8s5T3eV7KDtySYxo48sRh/THxKU9yQETCiiDixByiSq?=
 =?us-ascii?Q?U43Jg4c2wr/5OjF39AavHJax4ovBLtlX8Y//WYFdlbJ8OP0Cw13labsBuB5y?=
 =?us-ascii?Q?5zJSCVS7C3XhFCvRPCwsFoYTsuwRyu18WIdw7FerMqZjKaW2RvJt6lT4oyR8?=
 =?us-ascii?Q?BMW+U3DRVR5Znl/moiCIocgfrdOBmSuiXm5Aryx+SJLu4QNL57pLJBhy59TT?=
 =?us-ascii?Q?JkR2NqkNJMAXC5uTevmVQvyM6Yv/chGa1ZnAFtGL3+ChZxqBPmGxSyWFjr46?=
 =?us-ascii?Q?Rif8izTlzVX8tC8RqoDWyNw4WhS0htc2Fi1pHoUs2XEkSEMF/Z7/ARw0qd9b?=
 =?us-ascii?Q?XMwWNRFcYXfPHRiefl68MnspO/q2wByg/zAatP20d6FZNDSQNXdtBaeN68bo?=
 =?us-ascii?Q?BAhBMywJBeiQkl7oob1vi4Lr9qmqjLtmjLXi+pSoUdFd/QJw0aEE+DjLrHu/?=
 =?us-ascii?Q?4HxuBb6xXoAH37p3+lGP4VxVtjze8qx3wMxqzMv5RmQoPwJuLqrvESIpVjAe?=
 =?us-ascii?Q?39wBBl3Yq6sh/s/O/1Grzm4iipXr2Tm3g6Xy+NWrCgigQziBL1TOFm5OtCIV?=
 =?us-ascii?Q?7AsMKXi277ZgFyj1CMVrNIb2gT0sq1DGGaEYj28RX4FxsvBsEjdqPnV/nAzZ?=
 =?us-ascii?Q?jaJw94cc87u9WtlZr+ibcBL8Vp3z8T1GNMDQK0797dCPec2YbgTn+lba1OWA?=
 =?us-ascii?Q?UhbGcOSoSjfpFgsOjwcNiI5cz5NmxxkBjFZ0j2Svdg2U3aDBJLIICmcRYtYn?=
 =?us-ascii?Q?XrYdDdu8jkcV5Ng/buNEtqea/UqAdf7FGD+11Z9AYHiIHwYkqMDVt4tiXCV7?=
 =?us-ascii?Q?AVgjVJP5mlxUPmm0HWG9811uoTmaXZhqkf5FTInJ21/9R0CyI+jQOV0Qbo+6?=
 =?us-ascii?Q?EwC8YVDjGTDDpikq0PodkovRuwc4BhbcO92Pz/DtXi/Fbtb1xqmn6dyFg529?=
 =?us-ascii?Q?s/IyJ4u9gtHdRKRy1iRnTzqMNiyzVFJCRdvsWdtEvbNXDK/7v4l2S/9Wzb0+?=
 =?us-ascii?Q?6aJ+tjObpvzbQHMQQR0AokukCOmq2bJRmmAVQHKXU53McRsaxiQJT8WoD64I?=
 =?us-ascii?Q?2/nvxylGGksGQtIsZFNJgPvopAMQdJaEf+uIuSngTig7/C+22mgah9UnZUgG?=
 =?us-ascii?Q?zqjqWut3TQdVTaXuboIWCCSuoSYo47v6EeSycThHBw6AT6Dn7Sefhlzh5aOK?=
 =?us-ascii?Q?ocmeV0z0IarGesys68ZZyVWejfoS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mtjm435sHx8Zw7oJLc0CovVcZP4stk6QDQJEa5WMyKEXLFhxLLLbZvhuqsVF?=
 =?us-ascii?Q?jF0GDHecfZctrKWvDQrjoThdraTR76K9L9TjDD+bLrObqj8cZkvZcbT9AwIK?=
 =?us-ascii?Q?BtMjSzgQeX5JCn1aVcxKJhsQ/mzW4ZFBo9c4Bwx6L8F0ffVThQgRTJZ0UZbi?=
 =?us-ascii?Q?m2ngJHEt7lOqsHQ246HTfU1UifitSPwi+sUlIEyizut2N7OtesCavDCD52/o?=
 =?us-ascii?Q?Hsvs9CN02iVUlENrDSULCYI6ThpQGelQMY1X0zmUzxYSmSihN29iIp2Z8SSa?=
 =?us-ascii?Q?0yTWMBK4N4PKplJVdsOlZlK6Zn+2PqjaHHteo/GlSnd5PIVfyuhT3HPhXQbd?=
 =?us-ascii?Q?oQ0vstP4WqeNRITkifPBy3CA0uYxCas5IQmp9LGU/k5RgKsc+NugyZ98Z3Nl?=
 =?us-ascii?Q?YUhxxmt2rly1CWhK+FTKra9s+dE38FU8qEDrX3wVS/QpU1bGwU/5biNSGiJV?=
 =?us-ascii?Q?HmQaxEyCRHXplw/nG7jl5+o45C1Ha71IOMOmwyjUp6iRNVfPFKJksmNna9Hg?=
 =?us-ascii?Q?TpVDe95cWGlc8yTfAUmK9eVQJHZp256OEr611SC0NIpAvLyS4lmkOYreEaY6?=
 =?us-ascii?Q?KL3y07Ho1JV1jc3xcbnEeEmO6CMqyz1yrPGfh69Vt3M9p6NKLINYrOVwXd1N?=
 =?us-ascii?Q?XUGLoz0vsK05byC4pE6wiNjxrEBXag6iWBjeTSOEC067a4nV8omu+0YT6erd?=
 =?us-ascii?Q?MmpPO4TJtUeMBnhijTjCJepXm5talYhkwBPZUckoIScFGSDwAjpAmj56yNga?=
 =?us-ascii?Q?HcmzGUShKVVwy7uQblizjHWkf/wLabxExKS/LgVrn4Jr/UUiXO/4BRsnGxEr?=
 =?us-ascii?Q?n2KqvBhPOfs+13SqxnQ67qWrBx8T2MoRzgRYPGB+vUtYP0b+/YUQWOjy9BRW?=
 =?us-ascii?Q?Sjpp34nA50pZfK7SjBL1Hn89kWhLfSCqyFrSY5TRaHPiPubA1W6ZvInmAQFU?=
 =?us-ascii?Q?XLg8CWYfh2Y0C3x35+869NsRa2paHHp3mkcCsOQNhoKKk3nXFx/zaf1yV0O+?=
 =?us-ascii?Q?UVWDsDrc/ZfFXhHWn3ALS1w7GNn0CUCnAjp6j/GIbYTqMsfTg+SapU3x2B8J?=
 =?us-ascii?Q?RlxC18R4iRgdoNl3kALUVG7k5JiIG7mF5M5TjK0ouh6CwnIavGFbuBTkagwf?=
 =?us-ascii?Q?NgmHHot+rTYGYIemrAZTN/Ca6enLUvgvgzVm9JW4nlRKJvcxv8eHWOHIkYME?=
 =?us-ascii?Q?tx4rtzGTzidsXZ45COBi3aPDZfR2LBttKiHmZdZYgFCm1pepZGHu2jWk/rX6?=
 =?us-ascii?Q?cLvL4FERdM0Sn4tfpY8kBdmsipLvjGU8Asy9L4np22wmSy9XtOF/NANFAmHn?=
 =?us-ascii?Q?0D9iqJsYvKUnXJcQd8yr26jX+YikUVM/xlbefRJFAvl5PUAcR6USTZeCknHz?=
 =?us-ascii?Q?D38T2wACEj4rsEMAnE/2glfusyJIicr9aEazyNVpCbYLVUfyvZF3MK0jB3DK?=
 =?us-ascii?Q?yr+rUoEg6FaXEGwZstgI0W/VebiWgiCxuSuZ0nv9jYwcse35VcVoCWgj+Dgw?=
 =?us-ascii?Q?qpG6g0fzP/4ADB3yzkErYTSVh/v1SR39RsgJzPAOb0bBary5ns6ZGA/oE7GA?=
 =?us-ascii?Q?eQS4kHTaiBryVFSJaGY7X/GWPa9VuLAk5E1iuywE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e8a737-876f-48a0-8728-08dd687d267e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 13:34:48.7320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IuKN+c69obwKlXgvMZcNaAn7QIs6xSQ3A/LOHPLvALE5hVpcbucYwMIZQZ7Ol0j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5761

On Wed, Mar 19, 2025 at 06:55:42PM -0700, Changyuan Lyu wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> Add the core infrastructure to generate Kexec HandOver metadata. Kexec
> HandOver is a mechanism that allows Linux to preserve state - arbitrary
> properties as well as memory locations - across kexec.
> 
> It does so using 2 concepts:
> 
>   1) State Tree - Every KHO kexec carries a state tree that describes the
>      state of the system. The state tree is represented as hash-tables.
>      Device drivers can add/remove their data into/from the state tree at
>      system runtime. On kexec, the tree is converted to FDT (flattened
>      device tree).

Why are we changing this? I much prefered the idea of having recursive
FDTs than this notion copying eveything into tables then out into FDT?
Now that we have the preserved pages mechanism there is a pretty
direct path to doing recursive FDT.

I feel like this patch is premature, it should come later in the
project along with a stronger justification for this approach.

IHMO keep things simple for this series, just the very basics.

> +int register_kho_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&kho_out.chain_head, nb);
> +}
> +EXPORT_SYMBOL_GPL(register_kho_notifier);

And another different set of notifiers? :(

> +static int kho_finalize(void)
> +{
> +	int err = 0;
> +	void *fdt;
> +
> +	fdt = kvmalloc(kho_out.fdt_max, GFP_KERNEL);
> +	if (!fdt)
> +		return -ENOMEM;

We go to all the trouble of keeping track of stuff in dynamic hashes
but still can't automatically size the fdt and keep the dumb uapi to
have the user say? :( :(

Jason

