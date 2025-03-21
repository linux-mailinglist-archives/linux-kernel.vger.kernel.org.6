Return-Path: <linux-kernel+bounces-571344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEC4A6BC01
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56D417A5DB6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1933C47B;
	Fri, 21 Mar 2025 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q06rafH6"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434A23594F;
	Fri, 21 Mar 2025 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742564939; cv=fail; b=E6Lpr0qS+ZeKlLHtyBEQcOMMVUHSExi06Sb1Rh8CSzO0xUwAnFaab9u3gKBLtJ0C7eUlmAgNs/IfI0STKq1nksVDC8CWM37DvIWm5vrN5YAItRMW2RiET037KAVTvBHMNTy7QYlJwJaPt/jsVFPCahIWaNrIxReDmOpItaividg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742564939; c=relaxed/simple;
	bh=34i4kN6JHewFU65OIVUo0hN6khG3uyJ5/gaxfFRUAnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dpAQKd0jwKbKV0xrb7Yl3aifXP+sAYOSZgPwPfOA4Zdoj8kdzthQeSqkrQcYotjUyHxFKgAcs1MQ4rEOoq5RlsBFcX9DmNG2UuRJbV+IGfl92IVi0fhRQN0mQdPzFzRv2Uz4QnfT6KO0vsTWT9k74yPlCXREVUe9TfQQJ0WH/tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q06rafH6; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEjh7COA/1809GnU7EfEzTThZ0zmb3kKNtUvR9kRAQcmeP2Fd5wempH9lFde3Q7XVKk0yjTjiU5QMOF9u4x7px6fUt4DodsB9JpIJn7oocCDZY/i8tExAmPTSwQF172glbMhmD6oHyT+cqaH5GMAALSxRRaAT8ePBXaOM1UCyHLtBQr+/62y63hf8J1+69bTQ2ptE+OQ3rE6xedn57NuhMmhxct8PS9pfbeB/dMRoh7z3fspXGlvYuPDOf5yBr2cyq1BPI68m/LXLXIIfDkWRUPh6rcyF9JD15W8rYAKkf0l9+zIaBNmElSnyVuDvQKBBEqrOwKON8LVYiZXbzf0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVjjSaw11boavQBJicbnwVw7UaKJKUYbA6xJoJbYDoY=;
 b=BHnt+XsEjKIJGRQK3/WXP95LCdAuGNNS7zW2y6pZNXZbizEcaiuL/8I3dAi4JQVm5GxDZ4UGNjaaORJEB3IdugkGgGH+g4XEh4WrngIw9fP+PjYwsKJsCTrG7Q9A+0BXB9qGbDIsQwbK0NXmeTgGL8SyxrjLbenviHLHrOjATs0WKSwMBfEMi3jh3xtKm3VVTrmohdbxJ/reXClicAy8SPRKVxBDF7qkfb4j7NC9cGFTZkhEFYVxlXPFINTObuw7Wy+msdhWKkC6QlbNV17SobhM0ZLd2YPN3eNQb53q9EvF8Uph9MSh8JuG43BZZkPG0hQlYtQ/D8JyvQlqBzEZXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVjjSaw11boavQBJicbnwVw7UaKJKUYbA6xJoJbYDoY=;
 b=Q06rafH6gvAUQYH5/D8TLDr4eEj347PN/85247aMGLmhvJVxhm/4D5OtW/IRoyzFBRrcBjcjy2mRKF5t8jkuc62a9kQm2wZUcNsQPrQibkSaEv2FxAHth3DmM/YQlp6CnapbpvUhHl/T1nf81+UJzH6MRDt2NSUSZnYbn4rKklz3AmNMUdmC1nJXvQkRlF4I0cFwpLUZdCYEYnu6/FDoEcoO2WLm/H4s4scOfe4Fj9CKgVWC/22eOsT0ddw7F4OBBxV5vCUs/jTuAFLjjAJ3QNsJuvsVyG6svbXkIcjwj+gtuaJNoq4p1vq7MSop3YyvEmo40tPafuE9z6XKNajekw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB8264.namprd12.prod.outlook.com (2603:10b6:208:3f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 13:48:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 13:48:55 +0000
Date: Fri, 21 Mar 2025 10:48:54 -0300
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
Subject: Re: [PATCH v5 10/16] kexec: add KHO support to kexec file loads
Message-ID: <20250321134854.GB252045@nvidia.com>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-11-changyuanl@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320015551.2157511-11-changyuanl@google.com>
X-ClientProxiedBy: MN2PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:208:236::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB8264:EE_
X-MS-Office365-Filtering-Correlation-Id: 20d9b702-4ef1-49d3-06ff-08dd687f1f46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?grXFAbXaL4vuNaRoFd60tc3iLmGrf9Cl9Yp+NuMkp2TTCBNmRRPTALIVR6Aq?=
 =?us-ascii?Q?F5nvy51Iow9kaNKu2QJrLMPF+7/80hjP6dDU92Acsc+h9Jyyroc8Q1FhrOhD?=
 =?us-ascii?Q?mYjKmPP9JlRai7Kgr/cJa6TBUihE3abLiKUTJkVX4l8yQUHtgd1s/SF+OT/O?=
 =?us-ascii?Q?+8a2lS1X5+RB+PxsJccu1khH8/GScB1HFqhEgWUmTvTuAKrF2XUmFGs37Hxr?=
 =?us-ascii?Q?N3Q6YE68FVSNo4BspV3CJuHuL3C2k++pjljPuWdq+nGVsCVn7Fc6KJHpg+io?=
 =?us-ascii?Q?Ynr3k7m3n0QHl5NjagqzrzF71NAuQm4qxaoLGaH76antAjSdjZXoGsjEYgmi?=
 =?us-ascii?Q?1L9foMh5Me3m48Ol+aE6B/eFZaa8x7pS8ws9LtyeI5LYCsMUoFBx0qps4BLT?=
 =?us-ascii?Q?irhae02byk5kddh1Xo1ASCO8liCqfCGkwAgdKD2NLgbEjNGnJceYFTp0NVz7?=
 =?us-ascii?Q?zS5kHSUHJLKC0Eun+ggyENF3zyUxcviZKdQYm5wlZig287t8SC5JHFibKveU?=
 =?us-ascii?Q?f/+QoEDPnLxr+1e0wxcutPxkoqlPQggX/iAlh3T2BK7iZ/i6dHmbppjbU7nu?=
 =?us-ascii?Q?DJJfzreS1EGqOZQLR07dB8eKXCC48CR7rhDw0fQ4hyqWOLBONc9u3LQwP4BQ?=
 =?us-ascii?Q?V3W8nWPlS5YT9dotoNh3jdGlSRXXf3AGGTf4SQfv5aeDCp3Fovpe8qe2pxZ9?=
 =?us-ascii?Q?zPFRgAICZ4o0J0pHLbIPsZqUyu9S4suWwYfv3AmbrL+Qt1exIKCfF7rduhta?=
 =?us-ascii?Q?rXOwfVihxFQbbvue0q55ZEH2B7oojNZMPmxypTQ37d3kgElI0eCQZ0xSmQr0?=
 =?us-ascii?Q?nA8fTVJOdu4a0f3Ic+ocRva0uqgzXmXMyK3BGzYMtF5ovP/8A+svGhE2gkxj?=
 =?us-ascii?Q?GaE2XJr1+00ep18pxJJzZ3MIxi7jCjpuOij0MFtktR5fRVmDKMYS8KT4gbT9?=
 =?us-ascii?Q?+JAcMz42wHHMvn2WhswENSD4kCP3Xq7c/TUlStJrV5+yMDKRRkw/wVfvzId1?=
 =?us-ascii?Q?k+4kDJXUjziQ4JoNzVhoatWv0U4vVczTnPd0+QSQe5tvHP/s1dFIVAEo+Rhj?=
 =?us-ascii?Q?vAxYIIHjNBmbxZq+RQeM0ohaiwhpCGEZKsFGsWDlW4N6yMKxXcozIxr5f46n?=
 =?us-ascii?Q?FZojzzRGoeQxR8qgbvhJ3XqCTvUghQ51tenLs6tpwS38QvOOJAWn4ys1L6g9?=
 =?us-ascii?Q?CT4C9aBtao4MOizVfjWfCkEC66rdHLvrYaizEelVe7t8+MepUeeyDP5ILBCy?=
 =?us-ascii?Q?MAxrlWLK1OkYC6APPcprrzKPLxnA+QZxuWpsbU8e9JQ6+6Jawv5k7SckZIgM?=
 =?us-ascii?Q?xMVTp/1+j11fzHgt/kFIK0J64qyIZnbdEnIvHQ4Uuuj6/EARN1G8HsArbag5?=
 =?us-ascii?Q?zCFWROExfpZn4ooMJXshO+8AeAZk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZpGZxSSlucsgvPEu8Gs953DLLhRl2nqqN7cB8Z+FBN10vDs46FVe5bcKk5YK?=
 =?us-ascii?Q?fX1p5Xkz5GDAtKinI93clv8nt3eMFCkmVHzNCaYTqd+/N/O9LK6/k5stZ7M/?=
 =?us-ascii?Q?hnizBzViL/BxR3nJlmGFlb096nl1ddBPMA/cVdTTwDLEn/Pv1NQVhDhOOG/x?=
 =?us-ascii?Q?TPXtbro7KvO0yu3rlvDfR77nPZdWDaz04dGNJXD8wNlT5yJfxAnO4F32dnai?=
 =?us-ascii?Q?34pASWIzC7up0wSGNG0m/FnnMsyZwZozzemUJeylCoML/w24IonmREBLjmtq?=
 =?us-ascii?Q?BYH7Bgje1V1gCfImifwZeJr7DBGZB2ROQDV3xlsqvXQbJO2UHK3UfY4xDD0S?=
 =?us-ascii?Q?GXM89e7bUCC84P8unmCAN1hDC2IWt+ShCeVnJmTZs2TbJaTIq1aJIpWDPO8j?=
 =?us-ascii?Q?1LHJDIPhON6JJ1PaSa8c5mdMyVUICHHn9PBz1rZKo8GNpfv4gmKZTFJma73w?=
 =?us-ascii?Q?ULgUCTUK3ls7/CjDq/nxo0fQ9Vz2kp0Vc+z5OF/dHljIHm7MSrNT1CI95Bx9?=
 =?us-ascii?Q?Cvk2Hz/F2NvXns/cXyaoe1xW7ZfctfGmTDOW0Ukze1rNGWWGOdrq841ui2qo?=
 =?us-ascii?Q?Psxvtsgf9AbgaPOrKP7tV8wFpz7lsD58LH/2KHcaRerZM/EST5xuIJ6MGY9j?=
 =?us-ascii?Q?VeS7djU6MUfeKHNK+h83KFrDP5nyMPD9+KqwAE7KaI8fGsyDjpYvDEuQaYeo?=
 =?us-ascii?Q?+YDIp6eIivEmNakbYFNiYW4tJhm72AtdoOUm6aYVZmCjymNbvmcexd22pvim?=
 =?us-ascii?Q?MY+VhTCi7Smxdl69aje0lj44QmfBmw/+qHVVzF7HLvNNPUItsABEs5zt0OZC?=
 =?us-ascii?Q?BcGgu5eGD7lcEWqkWyi6GML9tGUSFh7iCUOr0BPi1k/DQ7y3+6aqaEK24zZ0?=
 =?us-ascii?Q?AOsHQUG2ycYARfpu4++tSnsD5rEV5POhnF2y1xKBpJzhPKg/xFmUFDeAeg2Y?=
 =?us-ascii?Q?tiQMqnbmoiLV5wYcFWp5b5SOygm6/Ish86r7UZ0PYWbbmBl7/cishzD2WJ66?=
 =?us-ascii?Q?nzBCvsyWYSOSdLL8ExRGbT2l8EpSIZMAsNwgH2uG3hkbVHt4p9oVebhWgcP1?=
 =?us-ascii?Q?hHxe97Jwo/pxjeoQ5L3i8pDhS3FGsKUz33XKT4PqGiX7XItrvHO3T6mY2ZnX?=
 =?us-ascii?Q?uW8Ka58eCaAZPXqFqvWtCsWw5oCw97qJ6OR3iL3x6CGIOFEpXlIyyqGT2FRT?=
 =?us-ascii?Q?O8q/DNIrCi3imt2039e2K2AciO6UJjnMpc4jTWCMLqfgWJIdRAs8AqnGU1zr?=
 =?us-ascii?Q?UCsNf2TyXWDnCPS+pWdgWxpO4PqGVGc+Nfns81vWzHz+2glGuEHvNyP/CNWA?=
 =?us-ascii?Q?HXmuxbednVEQGz0Lk8VVfhbAQxotB82GgdHjsTTUNZAnucD2nONJDsmHZfav?=
 =?us-ascii?Q?VbKqFWNsEjBiZNz8DRF+zSi0/yVkCcKvxcO94LGRZDAWX//fYrBBfJNdcOfi?=
 =?us-ascii?Q?BLYKZg6/kJnzqRI2g5tqTOVDgT9fe/Jlmo1b7T7M0jKRZEhus1ezhVViyD7T?=
 =?us-ascii?Q?OVFAv/Ly941IxBQ4o/0oaF+YApT0S7UdNLPwibriQr4PKGWqvl16BJa2KCR1?=
 =?us-ascii?Q?XTb30yqDMf0xQlH+KfVKZ7jNxI+Hjmwumz79uwZR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d9b702-4ef1-49d3-06ff-08dd687f1f46
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 13:48:55.3763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9p7fh1lOdxHo68l5yu8gKDJXRWdiCWZZERG6SN8E/9Fl9Pvb8b3Lw6WZwvhTO4yJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8264

On Wed, Mar 19, 2025 at 06:55:45PM -0700, Changyuan Lyu wrote:
> +int kho_copy_fdt(struct kimage *image)
> +{
> +	int err = 0;
> +	void *fdt;
> +
> +	if (!kho_enable || !image->file_mode)
> +		return 0;
> +
> +	if (!kho_out.fdt) {
> +		err = kho_finalize();
> +		kho_out_update_debugfs_fdt();
> +		if (err)
> +			return err;
> +	}
> +
> +	fdt = kimage_map_segment(image, image->kho.fdt->mem,
> +				 PAGE_ALIGN(kho_out.fdt_max));
> +	if (!fdt) {
> +		pr_err("failed to vmap fdt ksegment in kimage\n");
> +		return -ENOMEM;
> +	}

I continue to think this copying is kind of pointless.

I liked the point where we could get the FDT blob into userspace and
validate it ie through debugfs.

But as a way to actually do the kexec, I think you should not copy but
preserve the memory holding FDT using the new preservation mechanism
and simply put a 16 byte size/length on the image to refer to it.

This would clean up the special hard coded memblock reserve to
preserve the FDT memory too as normal preservation would take care fo
it.

Now that this is all in the kernel it seems like there is no reason to
do the copying version any more.

Jason

