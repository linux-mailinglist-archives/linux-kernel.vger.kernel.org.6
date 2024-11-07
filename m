Return-Path: <linux-kernel+bounces-400694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CEE9C110B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336822857BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7098A217F3C;
	Thu,  7 Nov 2024 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VscPk2vg"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01467FC08
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 21:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731015441; cv=fail; b=fn1RSp2CQGONWhSV3hpel+qdT9IT8QsJ0v3YhTw53+RYAfajdeRpgEa/m6V/yGbW0XEF2pmBcBa5FOGUq9j097gAS5XstWs5q3A7PJq6RHz5ozX52w+KfXiShSo3hWvvuIwaqWbMULRTqnXxEaemSSECvTByMK6ZPJsEgAAJY+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731015441; c=relaxed/simple;
	bh=Ughf7CV2NN63KesAPffK5o/ULFRUQzB+Ipy8SNYPTmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EAfV33gSK4Zvno9QovRKtsGe6AF1dBChUsxBP3B5zGIACPwF+wseFpcbry7dIVli8Z5sFlUzqjBIGvuPIJxV71Sc3B0YSawoHJcvV53oyXFTbQCY8QbPbNEPGpl+WzjQoxG13kLEdVZSPlhjVNDgnRdmEZaa8rjK07+oJIFSlXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VscPk2vg; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzKZ4BSlg4oBh12/3h2a9feO7YpgMFqQh6zKuF80w5irn8D+uIdiOq8etagsAXIb7g/X77+9ZZGOTMNiMBNeXbkji0BgkLe1+x8kGdWlQ+s7fsx3DQEpV+4Ua20a6oecjWQY5nPsnESfQksGo8rzceH5uBNEIR7inAE6TJazlR9S9G2E+qs5UvGUxtm0zMhJv/5JaKth6PsIizz+5nigejHgrOs1au+bCcJgPNh49e2RtqORACRwrUVQQA60RX0DbLG3gplNo6DRfM0WrZPJUZYgDvceMe6LAvERXnfxFYQlQy8Ddm+wjXbNGA7XvlOxw44zCizA8M3gvrMo2G2glg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLqZvRlZYABM4K7gJa4YJ+9kKqHg+vcuObKLhiYsogM=;
 b=Q2DVE/P4E4SmYhPoDTC93OgxSIrf6LoPvE9zn9vPmTjk7ovc7z3Dy4JHg748ms/wiriEUTYaM4bszasHb/5Jm8pb/U4pZFq7DQVsv3z3dUFdKYrVHYej54Xr6LdD4lM8/Z4dyNSjr8sDwvDKgrvVUGpKiuhttIVrPxDaRBiGV983akitATT6ZRFoekzu3rKawDWDHuUlNhxvxzUowCmaGPjyLyPk24HPMz51uWihHnVUwERKjQJfMnVvLGm9un76c2PClXQ6CFi+YSDcUshGvofBKzw1zs1vj7tKH7M/Oe2XmUMAANURREcHDNUkrKiJmRBJI3YOjuUwscH8pNaUXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLqZvRlZYABM4K7gJa4YJ+9kKqHg+vcuObKLhiYsogM=;
 b=VscPk2vgSnC+StQST6beBGQITi6llplixypSX2yzzO/hPCzgklobvwpG2Ou047O7nt+XKQO+jfZPZQMqGpY4tAWAyqkKfGSj+ZVLCdc+cUjX0dJObviSK3/S9m8WnbBrxZygjlJvAp7pJApF+I33+AyFwg/NXi3gS+pnFVKnsAdkGe02OaiVLV0bA40aO4WGEGBsYk0ybmCfrZmxR/Q39x5lPmbiwo5R7W+miUdGK2kqbGD8DtK8yqOpEJJ/r59rLV+pSlNt0zFCuu7RgSi+7fygEpM8+5zP34UqH9XF6xjnEe32F0GDvIXLoiIJQlUH6TLV9H36i5TJRcCBI7/vfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SA3PR12MB7999.namprd12.prod.outlook.com (2603:10b6:806:312::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Thu, 7 Nov
 2024 21:37:14 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 21:37:14 +0000
Date: Thu, 7 Nov 2024 22:37:10 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-6.13] sched_ext: Do not enable LLC/NUMA
 optimizations when domains overlap
Message-ID: <Zy0zBsabOT6uAr6V@gpd3>
References: <20241107084805.120265-1-arighi@nvidia.com>
 <Zy0PWPaYHWsgh7Rp@slm.duckdns.org>
 <Zy0fijpzYNA4qNCx@gpd3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy0fijpzYNA4qNCx@gpd3>
X-ClientProxiedBy: FR4P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SA3PR12MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: b6db1d38-0783-43c6-7f71-08dcff74582f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+/3EPl7N31MoanXQxZ5c9DF9RZHiO5XDVwuG3M+jiBhCntBt3QHxZ4QyD04z?=
 =?us-ascii?Q?/XxC7Z+cZkKFy9njcXekWImxkAMuZm+W5DnV1RRDCxPcrvYNvIsFbvEyxhkg?=
 =?us-ascii?Q?fCErr0pd2IY/Tg4Qpld38Lu6fRxgsQwzmhj2lUOrRMhLAFWOJNdB9XtA1Ka3?=
 =?us-ascii?Q?ax8wIDFOkr6Psj1Run0/rZJfENRl/S4+iFUWJheiJpCD9xn96akTy32t5wH8?=
 =?us-ascii?Q?B1/slg+LObl6sKMbN2Ah4FO2/hrduJnfclIZ7G9rTdbI5QZnc3EgQmo/sNdx?=
 =?us-ascii?Q?tGTpx7kjIeSuujVGj0W6VU89B1PsWl0a3NFlnkSAuoAmEKkjG9x5ObZfHYYv?=
 =?us-ascii?Q?8RzN20MomZT8MBYQ/FvZOnrVgF6eJsh09030fhMQoZZHaE7Uv6ehlaiozaln?=
 =?us-ascii?Q?zoLQXy2bYRVUYJpHqt1frQwWLMSizBKqYdRupPhNfJJmdJwbAAstsEDK52xp?=
 =?us-ascii?Q?jA1Eo9qvoQkvN/D0+XOl8SGo3ObvgSKRY8enIk++HkCQ9LV1Rpxz5t7//y3M?=
 =?us-ascii?Q?48S2vTa0xEifu5+fwYAsJqtTUhLL+gA71pABNb27a7PdRq+WgKcHW61ZD670?=
 =?us-ascii?Q?ZceVdBYLnEea/yCTZ/i9fvDHKzFE1ryL/3XeTkv0PQ8VrQo9cGpvl70jHJo5?=
 =?us-ascii?Q?YID632LJbC7RFGHFOrUxSgnIKjyCBetNiC8Zo+a7Zac5KQsO6Shq09oJbmdX?=
 =?us-ascii?Q?52XlnRelibo23Ln2xXCAfHR69ei7+jmnqgEnk/AuGULIpgjGbIKcJV8+fByc?=
 =?us-ascii?Q?02f6xLY15VlAUdJOILIHGfUWk2lWOHEsTeSMWuqPkUdcZFw2hO8z2m0xjpHu?=
 =?us-ascii?Q?gSWjBX8DoCgJiwZlNXyFpu4mDxwKSMPouzFRztH8I/1g2ruKU+nd00GXQ04M?=
 =?us-ascii?Q?aOW1raxwlD/yzZczmOdt/uvrsE/95/54KcnCXL/IajMrTiyzH7une8h1YmNn?=
 =?us-ascii?Q?6LsAz10x6x/qODcqKwm0wxVBuNJl/EnFqG8Gfa7GUHn8tG9fRxl+FeD3EPYc?=
 =?us-ascii?Q?KlIl+xuC7yRJd9qHi4QKWa3PXrhOj+9rfYVFX0h3HhJJwN78uGywES+1Y9Uv?=
 =?us-ascii?Q?Jjblftkq1lqF4mgSvVwrU77aGy+96VbXmNsluZ6pMCNdzTUvf1xUp1+BTUBy?=
 =?us-ascii?Q?V7MqrN7iK5UGp9ymwMPsbuuxkxVKtuTD9D6MYPcGv9DzTfHxNHrSCEf/jNbp?=
 =?us-ascii?Q?7GM14+MtTaji9XYCOTyxTOQRreqV7V1iK2L08/SHv1Als6WbUcVf1z0ACJZd?=
 =?us-ascii?Q?zYDTMqtxOrr5/vb7AhQGXbn0MjfA8cVQEDFKR2PG03uNtIJ+u3UarX+sKR6n?=
 =?us-ascii?Q?XvmHQlxNfVWu4k9jocS6xl+E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i6+A/eIfrn5ciaE+8YUtoztFvKrtR5pYewMne/3zL5AJ06nW0a7nyvf0GaM2?=
 =?us-ascii?Q?JUqdBVRQl5a5Tf+ycrGaQX4gOErHvxpeRv7zyq3plQj9yybfngCfYDB8qOuE?=
 =?us-ascii?Q?DLO5EsK0yypLNYtu3vmR+TDtwKrBLcQI6uOxR1ZQ8Dmi2ThJaVRqNCd3urJu?=
 =?us-ascii?Q?T6n0VpJw/sVELglKBmodjz3fCpuXykaSVnfVc2FMScvEibLrYtJy/FIcqzqS?=
 =?us-ascii?Q?7AJuElTbK/B2f7xVcVXFYPU1xWNUABydtXUDQJNXcyLb5xGllszLpftEG5Jf?=
 =?us-ascii?Q?FFEwMT1lTS4BkE7sBxVT96greosuWD4A8ewOP06cyErzrX9GEKo0ocnbFQsV?=
 =?us-ascii?Q?9Q3MqjC6rMPIFjwy1IO7uUNDcrWL3Z2Z2/BCBePZYYqy5ndjVBJJYYo5P0Bx?=
 =?us-ascii?Q?CdjbcvQHqZHlyoUal6VQ8Y5Ca8WD8loEuUZTMA8Q2Is/gYJaDWE1C+WJZvtJ?=
 =?us-ascii?Q?9AnHIWO0e7XuV8b89RsuXpFtnKcmHCZXEpjEivyfJ3gPxDWbQ6QfCwYxzd7M?=
 =?us-ascii?Q?2SHeeXcNh1UvN651VL6dsieuL2p1IoI8afe/wm/6obUf13Mx8IBNIK4PvQBu?=
 =?us-ascii?Q?j+bhE/b1dCNY96dvHtxUDQsBdS3uBosfBkqEEOVG1wopwDH8tpQoIu9KKnMt?=
 =?us-ascii?Q?sIh++dyWuXbZiaUfXxdKwptZP7bJEjlLDHWzCwMBtq9zu8FZ6g6WO9JDCFV6?=
 =?us-ascii?Q?+l4favQADoy44v6BBpFLDCYOfXAHv6RxoqA0Iq8OviAGrkRdc89M/ZxEgvXr?=
 =?us-ascii?Q?Eafb1cERXSXu8kAmpVVtVeg1BvxiT2Qx+5sxZLprJCV9V3wxdBFfB26kyb5j?=
 =?us-ascii?Q?X1Ei/ZE3S/TtT6SBMMWVlG+UkQs4TiQK8fyLGRpOYEsA51q0woNMgRdP9kp5?=
 =?us-ascii?Q?gnQolGgvC4uLr7DKVqHoYC2AeFEHVOhZjKCgovUOjQn+hJybZnHcJz7wA22A?=
 =?us-ascii?Q?fAdM8Fq5pcfym44p2JA5Pa4AOcsAAKvan+4phPuWExAIXVoQmclo6mzvo68R?=
 =?us-ascii?Q?5WlCGFzxehTD0LS+aXoCMUhW4nX859OpewBc7nRbr0uC47GAH8VBNjk66jOy?=
 =?us-ascii?Q?NJxNEmGfZt2dGe4fioUucmMBWcztVUsleop+qXj76PDjmk7nx5QVl22Sn60v?=
 =?us-ascii?Q?qYn+c8lWLy3BBXy7H3vrB2UTg2RbQLvaI4Kmq7oOrtjipsqk4JP1HtE1Ovgd?=
 =?us-ascii?Q?e/V9WLdCLK8EDAPn8qmgqyfvpi7eIsC3inU6IvFVZknrZ6f3RSYORfg1y947?=
 =?us-ascii?Q?x+81U4L5B1v8yMMZ5gaIOiprHc78ek+k3S+OrveaB8/bQgI7wGX4NvErHlr8?=
 =?us-ascii?Q?yhEAZ2i1yAtQAe6S89eqmGSlqiIYK+IO6AP6sSvn2BmeNM2hx+l/hrZEdhbA?=
 =?us-ascii?Q?o0nFI2MRNlNDvyHSyIgtYs9F+jDZP3MB0l8YyHQRoTDr3D29ee3yS3IKiDsD?=
 =?us-ascii?Q?tsmkfvBwa4wvDdMyI9ChXHqmtAgn2Uv78l42oVnE8UHhXjSCOW1XypDW4BZ9?=
 =?us-ascii?Q?2VhBcgKnjarHF+eXVditJIUw4j6tUxQpmD1N1GUqHVCAIRDymZGxPR0HQOus?=
 =?us-ascii?Q?wFID3XV4srjWWypLeEwGZ6cAs/NgcKLW54rjiqjS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6db1d38-0783-43c6-7f71-08dcff74582f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 21:37:14.2007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDrvy27b7siRsPzi2xXJWil7UwY5a+s/m/JGDcDXrrvn/rmP+s9zbjjjWcmDm0tH4ZxqndDNBt2onjjcSB9iOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7999

On Thu, Nov 07, 2024 at 09:14:07PM +0100, Andrea Righi wrote:
> On Thu, Nov 07, 2024 at 09:04:56AM -1000, Tejun Heo wrote:
> > Hello, Andrea.
> > 
> > Some nits below:
> > 
> > On Thu, Nov 07, 2024 at 09:48:03AM +0100, Andrea Righi wrote:
> > > +static bool llc_and_numa_mismatch(void)
> > > +{
> > ...
> > > +     for_each_online_cpu(cpu) {
> > > +             sd = cpu_rq(cpu)->sd;
> > > +
> > > +             while (sd) {
> > 
> > This can be for_each_domain(cpu, sd).
> 
> Oh that's nicer, thanks!
> 
> > 
> > > +                     bool is_llc = sd->flags & SD_SHARE_LLC;
> > > +                     bool is_numa = sd->flags & SD_NUMA;
> > > +
> > > +                     if (is_llc != is_numa)
> > > +                             return true;
> > > +
> > > +                     sd = sd->parent;
> > > +             }
> > > +     }
> > > +
> > > +     return false;
> > > +}

Actually the logic here is not correct at all, because it's inspecting
also the sd of SMT CPUs for example, so it will end up enabling NUMA
when it's not needed. I'll rethink this part.

-Andrea

