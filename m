Return-Path: <linux-kernel+bounces-570298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 453D8A6AE77
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8CCF7A9B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FA5227E96;
	Thu, 20 Mar 2025 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qd6JcvrA"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B001E47C5;
	Thu, 20 Mar 2025 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742498769; cv=fail; b=JTD9zRCY+0ZL9hCnbpH74R0O8+jgD5FAaf2Sx5Rpel5SU1G93Lj8PDoK3wqtoBMP/jBb7EO+LArAROUq+NEnptNfZk7ce/TEGeI6/hnpKiot/dnKFhjhTcIpx9pKagLwAE1Kpktox5UK78y9t87aUFk60RI6rYNvP+G4fWACwZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742498769; c=relaxed/simple;
	bh=zQ18gQZ1Cc923pB8zo8WL7ZvML9TYtkAYzhopUpardo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sYZQHd61iUgXbsdnrjILM1Cs3cuecK435V+W2wCbWjV8nI7NccA2C+eU5jYDktZrNWbPG7g2RfshRsvCuNdsKiXGm0nrpPiiLILfgAtYOQnZN5Pl/vAZvpFyxLnkfeG3Ioyeydni4Odxkd5IC0NYrCvwl6NyfMxXWCsE7f1DdDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qd6JcvrA; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yY6CtSEDsPai9D56sShcgrv7ECLObPgmvzsRwxKvHE5axfYKij+1KfugtoaR4qDK2zQN+4D4hGG664og9khVpg+C8Gnqq8ipv2P7+t3pw5E45qgtqKKJS1GOzqQlMwXkOv/eC5kVqjMpPWw44qfKWN3X4T97dHdZzcNnVTe9+xCN8iEWOufxcMsd1JoQic5xLPuZQlX+bToF32Bwba15mc4u4Wek5iA8+6xktcl7BlZq2DTHzUE4osiFo2SGIRExx3UaHWiWiYLhoMrV92bjOLhefpGDGZgoPwwqriseMdQiDBYDt9gqNcA4QfM6J3zI2fO0QlLUSTH46Z1bEZ18Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16vnLyA7xEb7Fn3JmVZvj09Qsyf0HnSAvWu8Fj/KLF4=;
 b=u+Z4WhzpViCeE9V36564e1M4gJujwiI/h85AySqP5pYoAkHcxExO6NFGHw0IzpBhjVvd+xAFU05xql7SwVp8BSixRe7vZGCtjpPctQBDe4WidWvgx+DqZYTMrT2gldAR18xdipYFvEUblQULhnp+X9FcLhhxR7RpZiLYL4jEYViu901cIU4Bd1oJDKZyIBMMVArCg4riCfc7PI9Nk5a9bulE3ma6iJFJQ6a6hv4sU10MIHrEWlPAaOznFby4DaFX95BmlH1wPDpIVlpU1bxPZ+gq2PBL10PpSl4l8DHSb7CYj8YDdmXddUOALVdHO8UN7VHtSH0z6qo5493HScy5OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16vnLyA7xEb7Fn3JmVZvj09Qsyf0HnSAvWu8Fj/KLF4=;
 b=qd6JcvrA+FsR1gKksWC9Jsd/5oZlm+e5Tpll4y8UC09+s8V8iSZarcf/jGM9VQgTENHC0JQdC77KYCILerQB+H5Q4MFdnh0IEtnlcleCmJ97hqnwn6Xi/umrUF2AfxsS6ksoaVnwbUFdYxXwHpl8f+QNA32HLqR2KTS1Zv/V5nZr0swvDe/j8u95qzGzTu04obz075W/v6isJeO0v1doXgcY7dXzyA7c06HDuChLwsjMGs0uugnCivGGbV+mHJEh/gjqckKP8KlQrjNMxu0XzlGaMCYCJw0W+E5RyjduS7GDMcrt5AgoqNfD1NX2HntmAweztpiM1RGYbqzecZKi2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 19:26:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 19:26:03 +0000
Date: Thu, 20 Mar 2025 16:26:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: changyuanl@google.com, graf@amazon.com, rppt@kernel.org,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, jgowans@amazon.com
Subject: Re: [RFC v1 1/3] luo: Live Update Orchestrator
Message-ID: <20250320192601.GG206770@nvidia.com>
References: <20250320024011.2995837-1-pasha.tatashin@soleen.com>
 <20250320024011.2995837-2-pasha.tatashin@soleen.com>
 <20250320144338.GW9311@nvidia.com>
 <CA+CK2bBovJ68FPOqD5J-_xmzy_mm8gNhJW80EsWGLgq+NhuX5Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBovJ68FPOqD5J-_xmzy_mm8gNhJW80EsWGLgq+NhuX5Q@mail.gmail.com>
X-ClientProxiedBy: LV3P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: 599974bf-6a38-437a-4f7b-08dd67e50d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4lITNxdD2rjn61sAR5VrTUG6xP1QeXlU8qMLI2NBBK2W6oyKztve3Rz62Bet?=
 =?us-ascii?Q?YmPZPiwIUOj7LuK+D7UHr/63CO3sStYBCUpsXP0AnOhtziM7+OtTGY4zpjEt?=
 =?us-ascii?Q?QBgpn9K/Ep3gt+skLCU3ZXWBA0X7frZXzhmiPMf+pAfz1byF1ta+FMMR1eQ6?=
 =?us-ascii?Q?plx/b2qFUs7kz+AXeaKZEj79bYZdJ4ukFp7bGfkDVFFfOYOt4ZBvKQalw5mk?=
 =?us-ascii?Q?cHCcMyAGiRa3VfPV9JTvDQiTWiXUFTncO6IruwE1d2SXqyQjwQY5I117Keso?=
 =?us-ascii?Q?UiavJHn007ugwyaX/DGZFvGv5vnybHL0zLptYj165f4BXxBngQa8nAg5+oJF?=
 =?us-ascii?Q?TpdCnIn2UL3Z8MZyeoiTNSketjzwQlximLlkb7dTxMUH0mrBI3krhGZSJ+f5?=
 =?us-ascii?Q?J9LSkiLim2Lgkb5+BpvSEQZuUw28Xufo+z5Qfoh0bkGvvIDSQK0bGOngG7wx?=
 =?us-ascii?Q?LrrCCBms9dmWUx7jJyqhqaTfW45bkNLjLDr6bb4B5aIty8dJE5pzbDgEBqWc?=
 =?us-ascii?Q?945qXiYtAe3RUuI/HzpWZ52rMcw02VcAft6AmTsUkB/cBsEeZOEjddy144Ln?=
 =?us-ascii?Q?U2fezcZ/Nvst3O9zMfm1SQWnRyNOJ3LW2QJRzmFJ++oFy8jDRT6XCWcFIQHY?=
 =?us-ascii?Q?JpccYQeLmkKc5Yp6cfTjtRjosv83iUHsSWskNw0Eiz1XwrUVgBtpUMg57weX?=
 =?us-ascii?Q?+LlwoY48lRelzE7IvSUqsm6wH2NrQhetCM3SUUYSWqtExgc9TOmEeM4PHATm?=
 =?us-ascii?Q?WbS1asGX5A0jihv2jF4iAFMNBpGhWJ0zSfUBYzP+jT+DTGhblC9vxhXtHzSF?=
 =?us-ascii?Q?zazq5DfMMCbI62Vjq0E+4Fd1y1KZ42FUBq/YA9SwJqFe1ysXewWbpD/J6erq?=
 =?us-ascii?Q?ruQ4Y9tW1/vWIsSgL5Fei2Aq/kX/4qi+R0Y1cSoJBp2d9J61F7Fa8nCMO/+n?=
 =?us-ascii?Q?K6M3Zk1GQsx/KcuWygNgTAyZJApO18dlGTZWq0O9I9YnPHLJmxHarxFAsil2?=
 =?us-ascii?Q?NalA/pQocD/TQsfFagoUHu/mAXjGsFJRB1ucovtZESBaF10Kd1m84FG/N8LD?=
 =?us-ascii?Q?clt0r1mI5qTpfRXUmqe5V5jnwq94K0c0uVu+fk0ppsDLbv97chmHtykS/0ep?=
 =?us-ascii?Q?4jWmXbclx/cl3pFC7bWPVaQ4mUx1XEobh+Ugg4oqW/0v2CUJd3CxfTePETWV?=
 =?us-ascii?Q?STxXNDdZvPMU3PFNOU2U5FZIthY/ysNzUSlXLyWl5fYivlnatgvY0rSSkpit?=
 =?us-ascii?Q?wCvfqdPQZ96kF4ebXZ9EtHKr6ur5UV6mwLyKIpXIbXKm5RCnucCWRa+etNQm?=
 =?us-ascii?Q?KdYe07crroPuZ5p2vheXnzFOb6ZxU0To91Y8z7Q3CNMiI+dtTYveA01WuSs4?=
 =?us-ascii?Q?Ys1NW/dv7KB09JBDLWEp6A5dyOI7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oSrF8pHViSoyGFyWuGnM8jZ9hYKTILUkbAnkcIGGJOMDIsiWv/qLN73Kw4Sf?=
 =?us-ascii?Q?o+P1qserbYY+p6FaLSXMkUkWDo91AirvCW4z5/6NPZeL6wJeLFum7eZHu8BV?=
 =?us-ascii?Q?gA60vvDPkICbYLOxCxGvt88hDe50VkLNdGEoWMSmt011pdhVpN+3soK0WDJy?=
 =?us-ascii?Q?LNHx3LUxnncButrdhfY9tQ3iHUAn8I3JonmsxTsA/8jrF6Pq4xyniGD6HE7E?=
 =?us-ascii?Q?HQihING/mcFouMnYmXIP/Vz2uKID9yQgqkiiKvQYyZGYRYgLe+JwTXthJob5?=
 =?us-ascii?Q?7TLIBiiKeUx46QSOAxdD13moDiZjYrXDhXo5zTmsFXEWCtbDHXvSzOS0FURK?=
 =?us-ascii?Q?M5Xof1noGg3K7Vco0/21TbAdDnQLjJ7P1siaB5Onaf8O+J/OIHJNW/C4rcCU?=
 =?us-ascii?Q?nq4tR/1okLJOMnSPDJq81L95noN/JvZZ5j05fkcn8U6M7QabByu4W1CqScCI?=
 =?us-ascii?Q?6TQihOKNUXAm0CHKZTXTP667Vo8dqRWdT2GPwkqTDM+j9kseMb6vm8IARcWA?=
 =?us-ascii?Q?YeJjm/WxjCn15dv/dpRBX2ombmMHyYw2YEjve66bZ4FlzhTBDh+SP3MHhxPs?=
 =?us-ascii?Q?C9naPCp9TaJNKMuafX9+2C3xx41iQPtlMTmosn74Lav2vnuuCXcq7lyjMOzk?=
 =?us-ascii?Q?MYfX3CFuhb0jExcZrjRVl5nDLJEp0wfRWaHifV1dcyfIIL6SZaNV8sDkazDD?=
 =?us-ascii?Q?3HXn8Cbqsgu6C/RIddbWg65+DO84kGGYLqQzMpNyhasaPjhiw2SfmxHnXdlw?=
 =?us-ascii?Q?HEuXoLbAPs44hzVv6L4f9tWZd2H+cWzd09ksVe6XE8kqmHQUbrjbymKWXVsn?=
 =?us-ascii?Q?utBecK9ZH4pYm7Gp81Jj9zCOJjW+Wbg1etYTkTKTagrbasFRACyUi9LMX9sr?=
 =?us-ascii?Q?d9sngHIiNb3b3sb6k5VzyDsC7l8/00GptE2LfHJ6ClK01Qy2lXwW4D115hxL?=
 =?us-ascii?Q?/ooFgPUmeCbdOKLqjS8xIUabanVrg+3AQJ0YGA3cA6n0aHDlemA7xpALl387?=
 =?us-ascii?Q?qOQM5tRv3fFkesoZZOYGk6KQSPV8yrCk7lBq68AgUiP9mD4twbrh0fK8GaiE?=
 =?us-ascii?Q?GYEPAfGeqDQDJxmWH7BlU2leRXCSznxYyNbe9MmS57vRhEf/fYvdKLKafYBm?=
 =?us-ascii?Q?q1f//lTLFzEER1ugz+FnljwjG7nnc+F3pwlZtYL8KPsG7jyr854NAa5M+ylz?=
 =?us-ascii?Q?epNYeDyHyvdkAHEwzeG74CSq2dwQqTaNVCVct199O/CpUGt/m30O3Nta+Ny4?=
 =?us-ascii?Q?+Fm/fU6qAU8NEYxubXuU3R8SO980Rimu50BrFrnlPLCDLWwZyV5BnhEtWTz3?=
 =?us-ascii?Q?Rq1uK3kV1pvpACq62d2IlJ40zQgE7PRLqsWF+MpbedbToDbRyB2L3HLcDbtO?=
 =?us-ascii?Q?ufybcxtgy9+isMIfqRONT9JVkG3LcKHzAXit3WqrYqayskIOqJutgaEN1zIW?=
 =?us-ascii?Q?8faHzgtKEoNeGOyIj1QAk3MLNkb2hkgbd0CuQv3Z67Inva/UKKs4/zr44Ig/?=
 =?us-ascii?Q?Sc2KUhxeVmO0dIvvsI6qZKMlEP5iOkdrTFBI3zdRwF4c/rDq5dE2uMnDG0ym?=
 =?us-ascii?Q?veCKJFKA8iUv3PPcNVf97YnBk4d4iTm7YcnaETfq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599974bf-6a38-437a-4f7b-08dd67e50d8c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 19:26:03.1034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkNG2PWrlJUvXuIxLzPqyUoFpRwwsePA9INw5BGdVx8nIJ2ei6gXoVYkDdMe76xl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284

On Thu, Mar 20, 2025 at 03:00:31PM -0400, Pasha Tatashin wrote:

> > I also think we should give up on the sysfs. If fdbox is going forward
> > in a char dev direction then I think we should have two char devs
> > /dev/kho/serialize and /dev/kho/deserialize and run the whole thing
> 
> KHO is a mechanism to preserve kernel memory across reboots. It can be
> used independently of live update, for example, to preserve kexec
> reboot telemetry, traces, and for other purposes. The LUO utilizes KHO
> for memory preservation but also orchestrates specifically a live
> update process, provides a generic way for subsystems and devices to
> participate, handles error recovery, unclaimed devices, and other live
> update-specific steps.
> 
> That said, I can transition the LUO interface from sysfs to a character device.

Sure, I mean pick whatever name makes sense for this whole bundle..

> > through that. The concepts shown in the fdbox patches should be merged
> > into the kho/serialize char dev as just a general architecture of open
> > the char dev, put stuff into it, then finalize and do the kexec.
> 
> Some participating subsystems, such as interrupts, do not have a way
> to export a file descriptor. 

Interrupts that need to be preserved are owned by VFIO. Why do we need
to preserve interrupts? I thought the model was to halt all interrupts
and then re-inject a spurious one?

> It is unclear why we would require this
> for kernel-internal state that needs to be preserved for live update,
> which should instead register with internally.

Because there is almost no kernel state which is machine global and
unconditionally should be included. eg Interrupts for devices that are
not doing preservation should not be serialized. Only userspace knows
what should be preserved so you must always need a mechanism to tell
the kernel.

> IMO, the current API and state machine are quite simple (I plan to
> present and go through them at one of the Hypervisor Live Update
> meetings). However, I am open to changing to a different API, and we
> can expose it through a character device.

Everything seems simple before you actually try to use it :)

> > Also agree with Greg, I think this needs more thoughtful patch staging
> > with actual complete solutions. I think focusing on a progression of
> > demonstrable kexec preservation:
> >  - A simple KVM and the VM's backing memory in a memfd is perserved
> >  - A simple vfio-noiommu doing DMA to a preserved memfd, including not
> >    resetting the device (but with no iommu driver)
> >  - iommufd
> 
> We are working on this. However, each component builds upon the
> previous one, so it makes sense to discuss the lower layers early to
> get early feedback.

I think part of the problem is there are lots of people working on
pieces as though they are seperate components, and I'm not sure this
is entirely wise, or the components are actually seperate.  I see
fdbox and this luo patch series as effectively being the same
component, just different aspects of it.

I'm not entirely sure that Mike's work is actually really
separate. Yes you might use it with a crash kernel too, that mechanism
is going to trigger for a crash kernel scenario without something
triggering the serialization steps. It kind of makes sense to me that
the same uapi could both setup the crash scenario and choose what gets
pass to crash and also support kexec.

Jason

