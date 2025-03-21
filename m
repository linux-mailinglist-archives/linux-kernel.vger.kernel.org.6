Return-Path: <linux-kernel+bounces-571337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86461A6BBEC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFDA1890263
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDD5B663;
	Fri, 21 Mar 2025 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HWBPOsKU"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387907E1;
	Fri, 21 Mar 2025 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742564798; cv=fail; b=itUllTirlsGtd7CLQfANgxANCJkuVN9/QEAZB/S+EVgRBomn6qrywmFPhY/+rLAAdqNbWbq54ZrnO8jnbuvEc/rm5j76kd1pzPw2GELjN5iJotGZWrlYY45lWPF+fBtlLpMguRutcvvZH9KV9Bi1+OpMs2FpBAQe6B/oggIzVyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742564798; c=relaxed/simple;
	bh=zPaHsdZobmO3Ixm7+n+sWNqS9ERw124tj+BCH3tEt0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rTmTWVMAWDbNGv0ua8IFth/fQYyFPF9gFeMgFivvZ8Mm61EbqLI+94eutlR0PPTesuKQkluYusJh1iDm75p0ArY7sWlMcNYaP+2SZFJIgFfmFRAdaB0LyzvtEkxHp37kfZMkO2HWlGnjLXd0LYJ+eRVpF5pgSblW1dwYfuQ3gx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HWBPOsKU; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbSLfROWI13tBJjCYHl/asggAPvE1e7W/vdxbTLXjTIU0CpkuUCqzmeBhHDD4+WN8jFZMeOSQlEmRQ0cdtAi4cKeHbE1ucDF9pQXkroB9K6xLoZ3lTLSCDeG1OPfIUbVup3VsLHUmhIOws9oNR+i4dO3OqpNB1gKC4TTkNt1J5/DVgFoiut9u/7nwG+D/BToztv4ildnB9jBWE2D0NNit5P55yOKH/XDcHqkj9SzDNhpBLvxZuGc5kWI4aqJK0G8OaMl8PEsj5W8WiyjAU8rzrX2eS/is193J94sP9UBZe0xbXdncfeHEk4TTtH+jRlI3I9HLw+m1iNh8M10B3POKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fk288syobnkVkK6HBGb7jwUjR/Nu+UkaK4DM7rx9OTE=;
 b=IGtrKBCHWYSfg0niQdqHdUcNU2VKls2Hc2sumJYHk9RUpZ1XcBwjhlHluVPoejhFZh25Wl0e+GbpHIlXG3xtbVDYT4b9qafh45MeUZoA/VaShuEig233K8hUFSlfsz2CZOgkehTJ3D1Fw8KjU/UI3jU7O/hxzklJdgFHET0e3D9MH1yCVmeHwTY+U/DExs8Z1wKMJzO0zT+wR6fiXlflgSf5pTVZwZkVJrLKXgZqBQ89g7eJAWltiFHHeCMOjaG38WnuMS0F3wWQ3JN3OT3pudANsuOZBl24FWfn1T8Va8RlI1YsngbDDpDTfy37KLARTtOSj0lZxtl+yn+T3zOH7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fk288syobnkVkK6HBGb7jwUjR/Nu+UkaK4DM7rx9OTE=;
 b=HWBPOsKUXlvCL2llsZWKNvZPqv3O0KAMtQsfxkaMpR7KFUdpOWVW1w81TZThuwFhgjK+27wgi72YRvDMXXem12HrJc/mmtf58ApzxEDqmXUq0ic+hywPxkBXInjtXGlvJHl4oXaL/nO5qU7x4L9H6wvOBNCBacrfAz2rXvr/BkQhTJa6+T0QoG4eWLcErZc/Ij2C2jk9M7mzS4XhM/0ZXuJ9IuJVwMhrG7YCBgfe+oMP6aj/pewFpoMcH494C/o++YXMoucF9nw7hhmb1DFrEAPsVlbqR0cRMp4iIPNxdikYY3/9Dpqn/cBmKDfnb6E6bO5c7yiDu4YE7LKc4YlfvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB8063.namprd12.prod.outlook.com (2603:10b6:a03:4d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 13:46:31 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 13:46:31 +0000
Date: Fri, 21 Mar 2025 10:46:29 -0300
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
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory
 preservation
Message-ID: <20250321134629.GA252045@nvidia.com>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-10-changyuanl@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320015551.2157511-10-changyuanl@google.com>
X-ClientProxiedBy: BL1PR13CA0259.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e21cca-9033-4cc2-89da-08dd687ec973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tXk8OCrRgdvw8JyJDWofxN5hZffPAepqrKJosKPQ1Ll09/HviG2y75goY+wd?=
 =?us-ascii?Q?hhvTT5ol3O/xaWaIXeiqXrtr8AHB6PbKiiq2apHUeAnk+KQLKX+aSt3vMWW/?=
 =?us-ascii?Q?M+hqPpSJADocqYwiMdWCPFJoz7J3RJ8q+YLzXVsPKFjp+3i2+/mph1i9A0zO?=
 =?us-ascii?Q?K7+dAr/524GNkU/jGWud9KzfJAV+GAr3Rqe7BsUSIMTJwn/HFLFnpOFrNf/C?=
 =?us-ascii?Q?u3xkQeYXvTs2B2tWMYwM+d/ZIoi3RGtav9XikZQ5FHqlWTFKe9AJ5lmKNUuU?=
 =?us-ascii?Q?exPVOwR6tarZ5j3UgpnpWaal+DTlTaKD0GcniUYz5CosYK+SWQHhecPYGBRH?=
 =?us-ascii?Q?2r/m3vGunGL5k1WkJ5oSjvbdr39y81CRzYuvzMZkvwZo/m+6zPbnxOaoJW0I?=
 =?us-ascii?Q?qQHj5L8/z2uvlKcmPz4161FgQg/8NdBkxM3CjiIZd3UBOxkGjwk+na64m7zb?=
 =?us-ascii?Q?je5bO7F9AjwfiI6uaZP5B/ebm6DPIsZ3TN1kZ56mQ4ZiG3D8AWxzr1FjxjbT?=
 =?us-ascii?Q?E8csly3+z8FXtCrr1tGdDsSYFJVdQk/a0E+JYDrLT6KZxmHi7kOv0HtW0YIV?=
 =?us-ascii?Q?RxYA9qWefnQxGW2FAse2jQNGOOWDLpzqkZjdAyxyY/2IlM5fsfCwg2coJntK?=
 =?us-ascii?Q?vVqmntjv22Ymx5bPqOWhwwRsA8YueJH3aZi08E0+FQb3npfZ3ox1IdF4LkVB?=
 =?us-ascii?Q?RNHLYLqrNJPoyXbSW9tsb0AfY2DIzo8IlrwB0Zc4SS95crVgrw2+YbRdS5Xh?=
 =?us-ascii?Q?cYwxv8ctQq+l3KsMM5M7vEgTmYOWAuj5Bn+MdZ2j/wRa4MiYDjCVgY36GE8T?=
 =?us-ascii?Q?DnFSgjpv+Pi7Iy/RYTRAh5NBvKVMFsGmh1uwoa6QNzYYF7MoCk9oH1LSeyIm?=
 =?us-ascii?Q?lELpTkCM52nx/YGHzEj02zkVVw+lvsuNiVn5oC0ewlQ+IbDyvdKT5ueEEPY9?=
 =?us-ascii?Q?//Vneq8I0YY9SklQgJjTwPkpvfFRFqsKDNZh63JfBjDAZ5v0aQiXRrLhs0s5?=
 =?us-ascii?Q?XjXGROp8k2Ot+VVjEib+3E6RaIiBz23A09c7I8q+uiDJY7z2GDq6QKFmp3Xc?=
 =?us-ascii?Q?M2SUUOY5JAzu5w+CW+VEGdgLocWKPOnw51Q74AMGb0zhTecdg/c2rbCJ792s?=
 =?us-ascii?Q?LHMH/ZNnwhuYJgRugjga9wahxRv109YTWjQXei8i7Yy45eawbHAqmRQ2QaVc?=
 =?us-ascii?Q?LEGAr25nzE6wtNb5QWN8zR74LjxAp+jUbXH8HcnSoOCVu3Q5MQFpjgaxVhvI?=
 =?us-ascii?Q?SzH0Q91Bui9sp0WyI6vyPI5YeT9Bc+4zvG3u3aIx1O2ZJQIygSFkBEgIlQJO?=
 =?us-ascii?Q?ce91kuY2w7nthTLZ+QZRAx7ePRaBD+N3xcIPXOADHm4gfu+/PKSHGxnDyE+5?=
 =?us-ascii?Q?66FqdztxxY2ueeZhLkNZGOdtPjNg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sJsF2cJT7iUFkTDJX/6mG/QTYj2mUK9DuvFnaYOYLnxhaY3JHRXkwCj8yCuw?=
 =?us-ascii?Q?vqUplzgNAdGACQK4iucbo9csIu+k/mDST3/nClw4GtYcdHtDbGLXQqKjE5JX?=
 =?us-ascii?Q?J4aQpJFbBErBi7/zE2rMCDgnfnjt4/VUFWFCN9pBF0dXLaNAitoOjY4mQxtt?=
 =?us-ascii?Q?L98Kcsk4fCqjr8F+KoDNtLX1OOb3Un360eDvi1xTSAe647QfsUIB9u5j86He?=
 =?us-ascii?Q?hLU0EricCqarJdfhPJ7vpdJxC7p4PVj0hobnaYXnyxerOzXSSiN0lg5LCFBA?=
 =?us-ascii?Q?boTfoH9VpF6lhYS6xeen44W0AIPqJJo8VyPWEFkHI6s0NtjmU5MVUAcrZcb2?=
 =?us-ascii?Q?RXKXqGS0bAqX/CuKoVoracwSjdWjLH7F6uPmrUS8ygTZvDzoMHZiVSmbGBQS?=
 =?us-ascii?Q?6skvKzhZimi8Uy74lELrey/MxmjUJcM/NTyZS+d0z9Wwd2+b9vgAiq4x2rGL?=
 =?us-ascii?Q?SVxnrbwTqYLUdKbI3o9CG6L2YxtCQ2FhXdmhFdseiVkIU1Q0QG77T/88gAVx?=
 =?us-ascii?Q?WBUdO88bU6pZGzqfOtFje3UP8GAoHde9EaR6n1n1ILWswSPfULUmc0EcIACi?=
 =?us-ascii?Q?HJHbM5A7gln/qhJa7U1ve9JVO68jT7lXD0vSADRwp7coc4UKV6VZuOrIWWab?=
 =?us-ascii?Q?ZSVTRWULIBP/ApwDsEg1O8sgcPEPsqhg5QizeYbiFpSPbS1c1oV1047keQGy?=
 =?us-ascii?Q?oYR6eHWYuLENvvGf8hdIVtnqFyTXWrhvruQFhgf0Xhv638Ca1Ov4nPRrNrQd?=
 =?us-ascii?Q?9vy/JVgZ3ANqiy2pzXstgJeR3l5OvbJ6TNOTCo6rpPqC7V1jeVuaY75u+2kS?=
 =?us-ascii?Q?CobMulO414NJoAdJJonWmlCS+P+1yzcvpKUaZC97GYMBawJi5bdc+9LxYelc?=
 =?us-ascii?Q?6bkS1bYU9OncCnwfIoF3m6+CWUvLz2vWDc5pQ6Jb2feDndXBkg0ul7g82wEB?=
 =?us-ascii?Q?1VEVEitiu1K/qESFKgcgQDD+SbfxTqdhJnPNX0Wm2Kiag2pR+wosofBxvgEi?=
 =?us-ascii?Q?bT6CeIp1OEv98Dglvx0LGwP/sio7PfTeD7rg9eZyleRw/uKv+Z7SnQiKGm0i?=
 =?us-ascii?Q?zmC0U88cDm4a6lr0yUIQ401MD6CrMA2BKdK0ekPdlmVuD4pWiqbV9k/uIQgz?=
 =?us-ascii?Q?OwoTlrt88+C6H9kNqT4B7zO68LUUAtetWZ7EpAMN19VfIdT42Y5sCJTluhBx?=
 =?us-ascii?Q?PRlOU6o1fiy4pfvLPF5WfWlEj+WpUARwy6lq0uNvh/pazEfLx+jpnsv4uA1P?=
 =?us-ascii?Q?iHWSfN+C9i0fVl+SwiUM1rSoK3s/Kt2PA2VtUlzyryv4W164Lzf1ZQ/U0UqZ?=
 =?us-ascii?Q?aHSyWxHP4dT3m+TThGNF++V8gsLE54jFF21vAJCoqwGxictEYK+Z5HpvY4wW?=
 =?us-ascii?Q?z8t9I+66QtpSvAwHh2xeXEheowKNTO3OENgFRvz1L3QSo+jVjeA8X/svxjhf?=
 =?us-ascii?Q?QfH5xZYUUOGyNqCmZgTG4Ou0oeaicAoMWx+sDEpyyPLl9g+aEhpM0jOhkzSz?=
 =?us-ascii?Q?SkQTKf75Om2pJMiExyMjbjakVBRcigeHKrQwupdT/tFLnDkwhU5NLtY0MOJy?=
 =?us-ascii?Q?ure0iS7tlWjnKmj+OJJSWbrfTl/Cfcu5VUEFzGqi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e21cca-9033-4cc2-89da-08dd687ec973
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 13:46:31.4131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++VX6EwMBhgPFifT3Fbe/HBxLUGFOF6PnUatYeF8lCh6x5AQptJje+5RXsFfI2Lz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8063

On Wed, Mar 19, 2025 at 06:55:44PM -0700, Changyuan Lyu wrote:
> +/**
> + * kho_preserve_folio - preserve a folio across KHO.
> + * @folio: folio to preserve
> + *
> + * Records that the entire folio is preserved across KHO. The order
> + * will be preserved as well.
> + *
> + * Return: 0 on success, error code on failure
> + */
> +int kho_preserve_folio(struct folio *folio)
> +{
> +	unsigned long pfn = folio_pfn(folio);
> +	unsigned int order = folio_order(folio);
> +	int err;
> +
> +	if (!kho_enable)
> +		return -EOPNOTSUPP;
> +
> +	down_read(&kho_out.tree_lock);
> +	if (kho_out.fdt) {

What is the lock and fdt test for?

I'm getting the feeling that probably kho_preserve_folio() and the
like should accept some kind of 
'struct kho_serialization *' and then we don't need this to prove we
are within a valid serialization window. It could pass the pointer
through the notifiers

The global variables in this series are sort of ugly..

We want this to be fast, so try hard to avoid a lock..

> +void *kho_restore_phys(phys_addr_t phys, size_t size)
> +{
> +	unsigned long start_pfn, end_pfn, pfn;
> +	void *va = __va(phys);
> +
> +	start_pfn = PFN_DOWN(phys);
> +	end_pfn = PFN_UP(phys + size);
> +
> +	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> +		struct page *page = pfn_to_online_page(pfn);
> +
> +		if (!page)
> +			return NULL;
> +		kho_restore_page(page);
> +	}
> +
> +	return va;
> +}
> +EXPORT_SYMBOL_GPL(kho_restore_phys);

What do you imagine this is used for? I'm not sure what value there is
in returning a void *? How does the caller "free" this?


> +#define KHOSER_PTR(type)          \
> +	union {                   \
> +		phys_addr_t phys; \
> +		type ptr;         \
> +	}
> +#define KHOSER_STORE_PTR(dest, val)                 \
> +	({                                          \
> +		(dest).phys = virt_to_phys(val);    \
> +		typecheck(typeof((dest).ptr), val); \
> +	})
> +#define KHOSER_LOAD_PTR(src) \
> +	((src).phys ? (typeof((src).ptr))(phys_to_virt((src).phys)) : NULL)

I had imagined these macros would be in a header and usably by drivers
that also want to use structs to carry information.

> +static void deserialize_bitmap(unsigned int order,
> +			       struct khoser_mem_bitmap_ptr *elm)
> +{
> +	struct kho_mem_phys_bits *bitmap = KHOSER_LOAD_PTR(elm->bitmap);
> +	unsigned long bit;
> +
> +	for_each_set_bit(bit, bitmap->preserve, PRESERVE_BITS) {
> +		int sz = 1 << (order + PAGE_SHIFT);
> +		phys_addr_t phys =
> +			elm->phys_start + (bit << (order + PAGE_SHIFT));
> +		struct page *page = phys_to_page(phys);
> +
> +		memblock_reserve(phys, sz);
> +		memblock_reserved_mark_noinit(phys, sz);

Mike asked about this earlier, is it work combining runs of set bits
to increase sz? Or is this sort of temporary pending something better
that doesn't rely on memblock_reserve?

> +		page->private = order;

Can't just set the page order directly? Why use private?

> @@ -829,6 +1305,10 @@ static __init int kho_init(void)
>  
>  	kho_out.root.name = "";

?

>  	err = kho_add_string_prop(&kho_out.root, "compatible", "kho-v1");
> +	err |= kho_add_prop(&kho_out.preserved_memory, "metadata",
> +			    &kho_out.first_chunk_phys, sizeof(phys_addr_t));

metedata doesn't fee like a great a better name..

Please also document all the FDT schema thoroughly!

There should be yaml files just like in the normal DT case defining
all of this. This level of documentation and stability was one of the
selling reasons why FDT is being used here!

Jason

