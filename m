Return-Path: <linux-kernel+bounces-192364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7628D1C24
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0728E1F24B18
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C2716E861;
	Tue, 28 May 2024 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j3HUy74a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53E916DED0
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901542; cv=fail; b=lmlvnqrwgCYE5W2apmPu7qwZtWkC76Heyl19Fdnaqn3JKZGuzXhWORAjOT1wUGMaIZFprOxuS2YXagg9rEqkqeHk52A0vb5LK9fNXps6ZBqqD26nC/iShcuaNyr3HIzDy5LkVwRj3c9pDPe7nIrNAXo5aBjTANWt/moqc/lQKOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901542; c=relaxed/simple;
	bh=7t7uvGhDqXNJctedfaf/GItdSNpUYkmsxzeniO7gARU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QqC7Wp0SVcZRhxv88l8VmMjndJHvH1OOYYZHQ89Hu1SCQBZIJrrDmDZdOWNUNihdQJy9AxwEpsAQOjrmq3joLq8xgkqvHdBz1NXQj3ErjtKbK9qwsz1JgzT6mC64sr87yusuhT22a8zakHJSq8h+FsBgXElMh3H1vwVANpjMdQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j3HUy74a; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716901541; x=1748437541;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7t7uvGhDqXNJctedfaf/GItdSNpUYkmsxzeniO7gARU=;
  b=j3HUy74ahP3EOHlKU9aN0VU8TdXbx+8Pudwqd/ezQ9D46AM2fL+T8/tb
   NBkcNpg4XOv2LZvNYUy/5HAvJ8rNvJplEq9TPTo6g/Ge3/ZFSg0eKv1Rt
   mvzzgRrgtundRjenilV2dWPCIMT9eVEPmoEOz9/0OvvGMayekEMlAGbo0
   kBlVdtIG71oLmUUyVCX3IWuhTEo0JvzSaLRDuK6ksXGp2CcXIeDd7kpQt
   r0ma9wrU6q3LAYYyPPaVY/ODntYWi01sy6I6z/DxWhyMEQc+1iHhrggEH
   +7L7QeVQdwuqskFWqNb05LVxoRSDoxCGyTO/6WQLoetcKgeV2RzCHOh7A
   w==;
X-CSE-ConnectionGUID: xWP6DZwfRZuLPQigO2H4cQ==
X-CSE-MsgGUID: R3BqBfasQa2vyCxDYYdzGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13431768"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13431768"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:05:39 -0700
X-CSE-ConnectionGUID: gmlAzp4cTX29iiUtb/oibQ==
X-CSE-MsgGUID: L1EoZ+4UQSyQec7ikQOkXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35151233"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 06:05:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 06:05:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 06:05:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 06:05:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 06:05:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehkmhL91EEZmh1U35Txz3UVEw5d+7vBcivvCmSMALAwSqnXqj9IANtwYiKCUAe3sCzf3eTsFL/IIUXEh3Ie8sGFK72H/dDX/qcY9sJwZIP6jH2KHsTZBYCiCfurmA9v5sVG5Tivw5Eo7URLvFHqUjUBRWr99sEinOSczeP+RaYpKV1Q0S3voVLSe1nO4afZoPZCViQ693xAyTkDKwQoLvnAogrFK9k/GMoyNufbC0B1iIFw31QdPqI2f7QGFVxgyokdKgJSrd8MSQiSK9F9t2pqdRRj++JEqYu5IqNRbny0Ggcy0m4sQpHJpVi2p6PhC59neclDzK0aq7zLEa5oLaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOj7OFUull77XYoqWeB1Rf+kJEfYpTYh0SxbQrrTJ9s=;
 b=L9fIJ+aWxrxJFqey3aBxx59Y1wJ/wudULmzct/1wt0ctsMFf96uJeMN3H+Jy4Vdt9yzKsF4I9HepJi7D7JYO1wFkr85PjuDkbTUlsuObhk++g+2ExDJoM+ZfbIL037xWFcScM9PsFY5N7AQh8bbYopRiG8Kza3AKgfCYc9PW8mU3Pdw0xOGHY5Jhq7OasN0ySq/dduybpZiwOKfy3aYLNeYl2kFxpf55IXSbElu/zVRyvagNjrd8tUmqU9ZFGC1Kb8uMj7HR45B/syYbXEzJ48o10ekQfZ19sz1pf+rbiX6NIupETzgcknhz2fE0S3IsRJ8gPkSrCxSXidtXMogmTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DS7PR11MB6038.namprd11.prod.outlook.com (2603:10b6:8:75::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.30; Tue, 28 May 2024 13:05:35 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508%4]) with mapi id 15.20.7633.017; Tue, 28 May 2024
 13:05:35 +0000
Date: Tue, 28 May 2024 21:05:26 +0800
From: Feng Tang <feng.tang@intel.com>
To: Chengming Zhou <chengming.zhou@linux.dev>
CC: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David
 Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew
 Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Roman
 Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<zhouchengming@bytedance.com>
Subject: Re: [PATCH 2/3] slab: don't put freepointer outside of object if
 only orig_size
Message-ID: <ZlXWlrjdZpoD4bS9@feng-clx.sh.intel.com>
References: <20240528-b4-slab-debug-v1-0-8694ef4802df@linux.dev>
 <20240528-b4-slab-debug-v1-2-8694ef4802df@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240528-b4-slab-debug-v1-2-8694ef4802df@linux.dev>
X-ClientProxiedBy: TY2PR01CA0008.jpnprd01.prod.outlook.com
 (2603:1096:404:a::20) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DS7PR11MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 63969335-0bf0-4e3e-a7d3-08dc7f16dcf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eaw2g1rsWL2I4Su4uft2T3n854Cao/sGsRchile9QVXpkpg3totjZb6yVg5n?=
 =?us-ascii?Q?ByG2H1SfkQQ9zGwBEwouFIhyjkP+NXeokzmunRCiuW5fwLbzR8Mw1kTDsfmf?=
 =?us-ascii?Q?JfhiVdsxZPXANGLNYCvXog7YTt5TxADjWeMQKQ6cxdkOuxQiSbsCvY7diCE0?=
 =?us-ascii?Q?CJglej41XHwnoxQW3VmsspXxRf+YdOgfXej1o6iA8SkByu+jW13NOb1JE4aG?=
 =?us-ascii?Q?sPMT08melQ2bRJz9BSmk/i6yFEtZmUQ4qUFKpJiWQR3LH7h3YSoDX0SFUYbk?=
 =?us-ascii?Q?wMaQKEsh+M+C/XG0yZevyK7NcGsRjc0s50uUHHvSpz3fhGLUWuXbFIG58+K1?=
 =?us-ascii?Q?ZoLZ03e55ekXRAj0LsRsXsC23xWKkr/ZbHWla0u3hjEHm9I48ncJq+I6r8vP?=
 =?us-ascii?Q?KS1Rh2dSC1uCCsrH9VBBhB7gk52O2kSEkwSTe/ApjDUr8WbT0pm6gzwN3BvA?=
 =?us-ascii?Q?fSwwesW8P6DoiK4pqU3YCa/mw0yw1zR2RoXL4/TJXt4Y1uL5Qxy7sPcoAiHC?=
 =?us-ascii?Q?Spphbu4e9y8dfvEc7tII1Ynfwu1ugePChMfv7M07u5Yl/165hG4UhFpV09yY?=
 =?us-ascii?Q?7iNXlDpTb++uzcni0F4hqhYVZyq5XNI0hsvI55GB/NoASTvNnmPmmPk+23bo?=
 =?us-ascii?Q?ZPWaiGKv74M58GYkxYwFIl5duFOYX0rK8ZUtvxbzqcK7GHifvFoUYx0F8+Rk?=
 =?us-ascii?Q?bWRzA/qcf43mj1kwUfAkWUczZNwbsdEPJAVobawDvoou5zU+INe1nFA33eFG?=
 =?us-ascii?Q?wC7iQ6ki0Rmst7WA51kmG1yRui0659sFM4uqqjqbWQnloV12WpMVkV2FmdZZ?=
 =?us-ascii?Q?oA/t4mUDNqQYdWr9Gyje6s76jLdhF9qx0nmWk9rQV9ZloTrb4iEVDGAYOoH9?=
 =?us-ascii?Q?3ww3M/C9ruaNGEgpTHgy5IIx5FDNLVpO2+e8fbGpQf2pfudVqRPyKlRCPOe1?=
 =?us-ascii?Q?qY5oc2A84UVUkh/dClJceLCD+xVcBdomeMx0tOLdDFT1P57wn/+7cH53zeoj?=
 =?us-ascii?Q?A2Mvg4lpPSBUvLU7NsP0YD92rNaSTcG6m8TXXaZNFpUWkDQuO5HpItEC+QiV?=
 =?us-ascii?Q?DQ5kFKItX0G/jEDVxdtPwvrmnEu0Lg2oFsHfpBr0+3nS1is44NSjEsqDHL+c?=
 =?us-ascii?Q?I7B676TF8NaQZ3IgWgDBJVeTntg5jsWJiDHcxwhEgXfPToyo9EICiJun7XBG?=
 =?us-ascii?Q?LHNUacEEkCzzYw0obqp/pNn2OJOK5nNJUJ/2YL5e2qknYTJQRkgMxDkw/XzH?=
 =?us-ascii?Q?4lZJWDlalbwUk+ynqLRO7TVRoo7LxX7fxPbibiUOpg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RSrJZGHfhFLLww4gi38KXvsiW9cOIWbI9cnC1Q6qWwb0XxuFecynWcqGVK0o?=
 =?us-ascii?Q?l8fxwzMSOXYMN4QKvDRt5YALVYcDGiOVNPSTQso2h9Jkajw9EK1FCZsqEvS+?=
 =?us-ascii?Q?jlWfEGcg4XuxM1G0ZJic5JiFltyiqShs3VcxXjc/lDZpC2Lxjbq4MUo/ySCK?=
 =?us-ascii?Q?4PUsq+4CeonhURgdJ5m/IBl7vlqHcL0Ahl3uxrp+8mebx4gdnx5vMtIuIDQX?=
 =?us-ascii?Q?XMBqFpzc2py7JHx+zx6MFC3vhySupc0T780xP70aXqAHXeqeQEhaBhp6lj3m?=
 =?us-ascii?Q?M+PXx773a+xfExJEh3oGX/M92H9XoKJ6u5wA55XONNy5aLQQGQ5e5GaxkkQ2?=
 =?us-ascii?Q?x5fzi35r8YTEt167yOgJp+QZroYxKmnhpCc5QE4B1L7RghAXeLeK5lbUu0Wy?=
 =?us-ascii?Q?eJ8rXoztWoLxZonBqFff2T6yYOpX2HVgMbBKlIV0CQKI8Fsnks900Z36Jfu2?=
 =?us-ascii?Q?EbsyZUInb82yU70P8NSKojFlcktDRu5rA837B5F/NBUv3fcNDnWB2c1PhlQA?=
 =?us-ascii?Q?4y3E+4f9pwaCBOWiHTOy8gVMMUhaRGf1U+YdrEHOd03l3weu63aGvWu1Gh96?=
 =?us-ascii?Q?hQoVXZD53/rtXSHfBgPg/VHuzpTSkhOilVVGXh9boDMOaBEh3SoyAX44vTAq?=
 =?us-ascii?Q?7BcO6yuPknpHPt/Gy2pEgBAzrNRqNBOnlcTjvl7G4c/HAzOF6E1aVmwqBy84?=
 =?us-ascii?Q?hAKxow5Bod27ikszhGVJvOymVPLFWtP0v94uYamg0I5aIw0ivwRLiM74ZFiU?=
 =?us-ascii?Q?Q9vmfA7irUBx5xBGm3gsPd7cYB3u4AaG5J7C6wxAt0BObOl34Va/cyTlEPdx?=
 =?us-ascii?Q?goqE1yCJK4CF5VpMOAhcvjCJT6CBN6Y8MIeRMOZL+1Ey/gRpFcF1nt/y+wLi?=
 =?us-ascii?Q?1Duar7dADyKOnEB1p4eh0vITvpZEuw9XgI1VCPjGUMQfUpnHsSSqWl3CF4Ni?=
 =?us-ascii?Q?zftDAMlXXTyWEFl4uwQ6BQmF7zPxAYZqzhlbfmQtfS9f3QCUhz6q7kkaJYx3?=
 =?us-ascii?Q?KDBepXrhIDE5s7jYbcSA+Jjb6cFTM970KUS5kVG6OEHoviQ76x+7UnEMRp6k?=
 =?us-ascii?Q?jZPGWFu+hC0iykYPaqafVFP243KnyzSG+8HRc9NASDelzwoCAk0GVlYBQAku?=
 =?us-ascii?Q?NbceSeUp7Njfvjw+ANI7EjzDoSufXksNWEG5nWtej1nsGP4KJoXR0JE9UuGi?=
 =?us-ascii?Q?kRfBOTTZ2mtDG5f+bHq/QFqU80ayoRPQ09GagJ4OF0SPt9Y0t/7j3m6Q1jC/?=
 =?us-ascii?Q?qa3XzH4QC97Fw8ZdkJ2HuEanzf8ytvEq+WgW9EvOa92p8x1raNCjfOXIKI4Z?=
 =?us-ascii?Q?lbvIrn04odwz/c3rCdA/Qa1m8nClXzZttSCJrtZkPQ6p0K8q87lkKyOau7W6?=
 =?us-ascii?Q?979b56cvPCUz6/O9r3zJFURy2L5EsX0PFM2br4w7K3QnpcGP3kzRdNB+XPKh?=
 =?us-ascii?Q?7oCyw0ITEz8+cc6A8PO+TyOyjlAE0u4nf/DKmImubwUTyO4dxBvD3BUWnVei?=
 =?us-ascii?Q?6wEjhtHr/SgBzsxB/L4gfTIPxGwOIhgvrCGGQwVEftbUZlIBcLoaSlrriVfA?=
 =?us-ascii?Q?aLzl3QYkkGzeu9dofq8VsiCgCRdev9t1vmE0iJ+r?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63969335-0bf0-4e3e-a7d3-08dc7f16dcf2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 13:05:35.4445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2bS7G2Q0rI2OzYuOaVT1aktiKrREt0o02Mkb8LTMY+9oPjAU8T1LTF4gUc4D2lmACcEB/vpe1Y+i+N7igQvXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6038
X-OriginatorOrg: intel.com

On Tue, May 28, 2024 at 03:16:47PM +0800, Chengming Zhou wrote:
> The commit 946fa0dbf2d8 ("mm/slub: extend redzone check to extra
> allocated kmalloc space than requested") will extend right redzone
> when allocating for orig_size < object_size. So we can't overlay the
> freepointer in the object space in this case.
> 
> But the code looks like it forgot to check SLAB_RED_ZONE, since there
> won't be extended right redzone if only orig_size enabled.

Look good to me. Thanks!

Reviewed-by: Feng Tang <feng.tang@intel.com>

> 
> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index de57512734ac..b92d9a557852 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5150,7 +5150,7 @@ static int calculate_sizes(struct kmem_cache *s)
>  	 */
>  	s->inuse = size;
>  
> -	if (slub_debug_orig_size(s) ||
> +	if (((flags & SLAB_RED_ZONE) && slub_debug_orig_size(s)) ||
>  	    (flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)) ||
>  	    ((flags & SLAB_RED_ZONE) && s->object_size < sizeof(void *)) ||
>  	    s->ctor) {
> 
> -- 
> 2.45.1
> 

