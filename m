Return-Path: <linux-kernel+bounces-511644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C3EA32DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5301690BD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E178425B69B;
	Wed, 12 Feb 2025 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B5mT3kVE"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688EB25B671;
	Wed, 12 Feb 2025 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382189; cv=fail; b=GaTBQbWkxxLQfo7xkfMISJ8ZA2kqvT41C5bg5xpAsMPeMe4sV77cfzq3N+8HqMOZpQM/1n2QCUq67ApnZJkFO0EAryZu7EJL/cpDKe8+z1cNIcDAWFy6Cqs9p9/AF8e+MmaTgRL+Y3OkLMQBIrWekrSIuIBDNSNEDOwrzDYzXIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382189; c=relaxed/simple;
	bh=Vyw93R2lC4BMMJo1dRa13p+G9jwrKioAwOQKXvCREz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g5R9TnFavqx2Nmu4Kr5kOvxkkRMeIhbxzc+S4lWkvI78VtlgVd36qsvkbC0cWCio8J2OGnfqLYLuHfFwbNsB0MXcctNZ8aR9lXYLqj5htShNOiyUcsEVqgYIX7WD5u6Tz/Um5+lw0A0cRjop9TglpcnbBPGj+ca+V2qblbbsTgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B5mT3kVE; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVJBSwDw2qAPMBIclB5NQARQtlUAmjOiiEwinfHtuz708pu/+Kz9UAAsQywdHczHU2cwrxlb5j8i+neZZmikM564uV92M0NVuwn2PVSWRWmCGpXwrJFgqlklVJc+IBUbdIbeH/NapL9yK2VKlqbTmzpU/OvT5b+9XoCrVQG2i519VjzzqiG8R4nVHZMMf3vGIGCfQgGW4HoJu3plD6GmA7eEyC5aydAQna9/tPOvjSYBj1QKszZd0MCzS4GsG8t8+ovq3mt1WBjXx3th/hquL0Ppf/kSQ3n9KS4jqFtd7Bb9J5LXs/Wr3SLm6UgE2nZg0Nd8pzJWxIdpXWMSSrDWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vyw93R2lC4BMMJo1dRa13p+G9jwrKioAwOQKXvCREz4=;
 b=xNHOpSjxJB2dVr97AchlClMUt7pZkoO+vG/NOB1r5edbWAL8hartgZjW/LA/32wnWDIwM5eAf6zLmwfUBoBzjd6Rr1paCavxlQTeb66HQ/jBNn3O5dMkyrncuevjlrKESSTy3Yjbc/tk+lZ8JpbjiQq7Tkc+Fs1+fR6K8CBnFgO5upe8yBi8r3giM3gx+jgiIUfLrNMR5AKuxj5ymXbBjpY0Rcq5pCVyySW133I0iM69xKaqzRAIgqlHNsE3fYDYXTjMxYEpO8hYqsMuAqOHzDK+tm/w5kpJwCrOchjP7rkCx/QacZTg2ZyT7ACx4KeVHmLbo8Rdl7Bmsk2M16Jg8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vyw93R2lC4BMMJo1dRa13p+G9jwrKioAwOQKXvCREz4=;
 b=B5mT3kVEfHmiQQhmC0MYKqyKcfPVbLuuFFJ2o7idT/yGzWvqfdCxXs4wOJT37RaM4NeeQatDnqzx92hZT1AMujQYGcFf5Gtt5Bv5Nb1Y2MZ2JSVyriamWtBKK6pUv/Iu/GHDsOzBGRDmYheZZSRlNc5B3JbVx3DsrXKHufVx0BuelS2g5rKThZNkU1ubjvnH/eUN+NviT45chJgz25VbfMjdx2Wxy8i7tjlEq8L30WSkgy/sTYmXS1hXvJqovg8jqmWXoTFa1yvtHpZ+OL9W+fmZHdzVQ+JqXKQ6WQmjaCdukOjGX5eB8MP39VD+qE759uT8j09Fwk2xRU7dcjrSZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by IA1PR12MB8221.namprd12.prod.outlook.com (2603:10b6:208:3f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 17:43:04 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 17:43:04 +0000
Date: Wed, 12 Feb 2025 13:43:03 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 05/14] kexec: Add Kexec HandOver (KHO) generation
 helpers
Message-ID: <20250212174303.GU3754072@nvidia.com>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-6-rppt@kernel.org>
 <20250210202220.GC3765641@nvidia.com>
 <CA+CK2bBBX+HgD0HLj-AyTScM59F2wXq11BEPgejPMHoEwqj+_Q@mail.gmail.com>
 <20250211124943.GC3754072@nvidia.com>
 <CA+CK2bAEnaPUJmd3LxFwCRa9xWrSJ478c4xisvD4pwvNMiTCgA@mail.gmail.com>
 <20250211163720.GH3754072@nvidia.com>
 <20250212152336.GA3848889@nvidia.com>
 <Z6zOqtaLQwnIWl2E@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6zOqtaLQwnIWl2E@kernel.org>
X-ClientProxiedBy: MN2PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:208:e8::34) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|IA1PR12MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: fcda6154-e116-4491-99c7-08dd4b8cb3fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eCRtdU5NxRln6L2vSD9zK3Np5n0fC70kE9dYCC7RxAz3J+sxt7LICm5NxsNt?=
 =?us-ascii?Q?27NvA9BOzP3/NTtZHdMGVr9ERDLt9Mqjb13sR1IrJKySHT4kNPkGrFBZOEDH?=
 =?us-ascii?Q?HH6U30i32HBa4W2IAOApEvCitZzkURf9k3K1FuZwCLJoI63v5UCI7Pk4Hh1a?=
 =?us-ascii?Q?TqeDPsDwU5sdYQ9lIi0fpPbo4HOAovmqj2k+B9gf33ke+/IJeT9vCxaGbPVB?=
 =?us-ascii?Q?lUpE4pZFt2rykDk/RA/nzierCZ/lNmZMmUDDmhp81cRX8YOLV74Rsu2HDIY4?=
 =?us-ascii?Q?K1DShJUsi+fi2yKtzDzyeW1aQSSAdYzMBaV2Db8FTDjD1kpSGoPtIQOTzQIN?=
 =?us-ascii?Q?TQ4oVcDQmFSc9Aloutqtk4BPr62uHviY+PibF2nIe99LeotniTQGtnBzKVQD?=
 =?us-ascii?Q?OExKzvf3qRHaoew+oBKd4e1Tl0NTiZb5+uOREhH0Vp+T6ctqS9Gk8dTDs9uo?=
 =?us-ascii?Q?6DcCVKqztwBG0RRar7IQWSN83RRx2sKwWXvf85Wa71VrAUKCNVFt88VTQQZe?=
 =?us-ascii?Q?Wbh0GS2llWLViSInnFVgnXZk9zZOnb0IC77Fo/af7anBfmyA+/SRy/UW5S7J?=
 =?us-ascii?Q?T0nunRMY76Dnh9A3Eje+f4Gg86aYmi//Ogkgm2DWyfB3MEZC9RIPU3n+o04J?=
 =?us-ascii?Q?fjELK+Aa4keBvIaZb3zG7uPbDPzEmXFG4yZ6Nhldm8krSwhwoHhHMv8GDXY0?=
 =?us-ascii?Q?p/Si/ywjB3W/gi8rCpEfJrUcdTMwLaEAB88jTvU6IpUrnc5AMkBIuNJHzM4M?=
 =?us-ascii?Q?kZzgWVG3Tt9YqNX+GYWZy1zKOb6359JupFiujj9hMZFb8klmMJBtUcEycmgG?=
 =?us-ascii?Q?O6T6rxNXixD4ZXcUKKiRQZeMDTrYWNJ3cQrET67DnbmC8DxmyXbokJN/esFq?=
 =?us-ascii?Q?9VqhJlQuUN+ZRTM+ZjLpq8RuKS8Cwq+9vHnYgRMIr+PwivooCXsz5e6aUrfe?=
 =?us-ascii?Q?LOI9EfRTUO3EpytBbDBSKGrkZkx6+v2wfLhFf5tw8ljm6voCLkiDHeYUs53I?=
 =?us-ascii?Q?iHhEGsmjqVCnIfMHM3AGQZGL+r8/nJ2OSZ/zzZS+O1RrXHSSdehOHJu9PDd7?=
 =?us-ascii?Q?SyPgQ88jiEJ4gwQSAZjVGR3rjxdTcFdkMV4JVp/9tw6m/uMJ8oDEsIb6a8Yt?=
 =?us-ascii?Q?9Q1ubHS+9z0cJgEE+9PWMvE1yTKrLUb7ZUzkzlPWpyy11ZmcgNfu59eKyS4Z?=
 =?us-ascii?Q?DL4nU+cspC0jJI64Q7W06TCodMii6ZI1d/GEOWVwDzj98E3HxpRh7B9Qrzgh?=
 =?us-ascii?Q?Hatv5iWtuyHchnaqff1u48ZxsDUFM8PrLuCZFn3A6vvkmS+po3jAqC5WF/xz?=
 =?us-ascii?Q?hSUzeUze5DYqrOc90o++K8bnnEQoub3Bth4Czp5TVP+/DdYx9HgcPerJ20xb?=
 =?us-ascii?Q?zBhXRsXRdqOC+uo2QFUYA2gB4U/6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k6pKXTxW+ltA8nSIxzihH4SzSnKE55QKEUfZGww6P7DKYjl0UqrlI2UfuK16?=
 =?us-ascii?Q?PmhT6qRWiUDCmdmBuuSymrVjhMb8/ds6QI6tFQZqUSa3RlITlu80J142r32n?=
 =?us-ascii?Q?53Z47mQKT4xqle4DPuLpwg686HXlmFXUXRUATIoriCtRZkkvxTnzhiaP2DY0?=
 =?us-ascii?Q?2vjQAgcuCzkuHFeWYJg/0OeMo1P0LdX2srFeZoX9SS+fGEmZHJVRbcRBm057?=
 =?us-ascii?Q?vwsw6yjGRmf8fNpgWXL3IucTzPjdGh5O7UZSVl+B0vk303JKazEaxcts6nGv?=
 =?us-ascii?Q?eEPRMQm0z0xvivo9KP+Bm+YUfLDKCgdxsfD2FJlRHbY8s3cO6aRBdxeNIifh?=
 =?us-ascii?Q?5mfpMiUot0KB1PJdNH65D/gtwb7DBc88ZNNf5QFhdG2xfzjAKENR+UWH+zKU?=
 =?us-ascii?Q?AxtGYI/lfEVJXiT7svdaTlPB7DdHQspwT4tkdLNTNZFl2gg61TuqcnuDHOS6?=
 =?us-ascii?Q?tKzRfmZNIozDMIyPJ1RLeVqAwf+NE1bOolbB0EtpQsHkv6aGnDm2F21ApE1a?=
 =?us-ascii?Q?5qXND3D7kuJgCgF+H9MQfHcJpzA/xACe6Iin1WW9MyT/AiWGkXBnaLz49WiD?=
 =?us-ascii?Q?qlUcGqaCvnOd3YN1AYPdSsOIG8/1VTuwlnqAry66df25CmqC4ovVi+98/Aec?=
 =?us-ascii?Q?6/RbUUPw8K9EzvsO92QkJ6z5v2KnZ4gGK0+imS4YDpvzuMQpmA+zf7k3Cpro?=
 =?us-ascii?Q?OfdACLRY96+3Ulp3cGIUxy98jgJzvFBaNcarNUk9d4p7cRm17QrFvr877BEz?=
 =?us-ascii?Q?Hk+SCK+eo1QPsBO/rxj90ATPk266Zd7U24TZMg4aiU1d6yJeXRKQTjBfB1cW?=
 =?us-ascii?Q?GVW9n0sMIFv8g5LXuokGegQUqqoqYe5BUrCrzIN/3Y017zVmY/LxrzEbvMOv?=
 =?us-ascii?Q?wKkB3tQpgb6ZILSpgifnIHIbHmtM4ZRXqbaFS3A3FK6BZVQUcjZH9eP0xGKG?=
 =?us-ascii?Q?ygJgQkYIOQvrIqsj6D4+Wt0VGN5wQHCb1JSWzcSs/R2AnQWSmZvwsBkY3142?=
 =?us-ascii?Q?rUlbQSyQS5Kq65n/1lbdoOulOV9a6CboWIYGHCHoIEysNDa3gXg/27wNtepk?=
 =?us-ascii?Q?Of01/PcBxyN4Xqrn7Vn7sUtVYHV7gGzjdOIZ9EYV9k25xW/YwjESRETyWtiM?=
 =?us-ascii?Q?CqhmpR2yOIxfQ8oaIV0ePjEXoPzN8sYgFgicwyZoRe/fo7/mpQQC9plUFV5X?=
 =?us-ascii?Q?K9QYBzFrB5G6hC2L4nRIRVEbNdMUuVedXcIQWyJ6BrTgpfYDdC89ywge9uV1?=
 =?us-ascii?Q?iLyUpUDuoyUoKSlU4/Y9onLHo2rzx+plL9FFpzIhffP4Rd+GNBerBRwlaLkc?=
 =?us-ascii?Q?Fj30lcvOb8AnE2OajA7yN9fYsdKv4pb3RLxhbpCNTe8FaBJOXnZbQ5yBpyrS?=
 =?us-ascii?Q?jE0plZu5B15d1LC8yGtpqjuP2MKDISfxUjjSrsbVqeGSbVGOt5pAtrtyf9Yz?=
 =?us-ascii?Q?YeW3sHqYqYgugMRBY0YjxgsVbNjETjnJgTPHuzRO+/nadrL/N93TTrqNRe55?=
 =?us-ascii?Q?6/DjKh9lsaLE8Zh9Gu0HXlAKUZSTBTLxXxNmKkBr60eWNnrbpK/U0aiE9Bf0?=
 =?us-ascii?Q?cOIg92EPW3kJ+73YS2oaGTOR95BG2p3tVLLa1tDw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcda6154-e116-4491-99c7-08dd4b8cb3fd
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 17:43:04.5053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0P8Jj8OH+WGU64qtS4cFL034ya9n+OiNd7/9MkzdFHwZT/PxjorcgP9YJm7OOU71
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8221

On Wed, Feb 12, 2025 at 06:39:06PM +0200, Mike Rapoport wrote:

> As I've mentioned off-list earlier, KHO in its current form is the lowest
> level of abstraction for state preservation and it is by no means is
> intended to provide complex drivers with all the tools necessary.

My point, is I think it is the wrong level of abstraction and the
wrong FDT schema. It does not and cannot solve the problems we know we
will have, so why invest anything into that schema?

I think the scratch system is great, and an amazing improvement over
past version. Upgrade the memory preservation to match and it will be
really good.

> What you propose is a great optimization for memory preservation mechanism,
> and additional and very useful abstraction layer on top of "basic KHO"!

I do not see this as a layer on top, I see it as fundamentally
replacing the memory preservation mechanism with something more
scalable.

> But I think it will be easier to start with something *very simple* and
> probably suboptimal and then extend it rather than to try to build complex
> comprehensive solution from day one.

But why? Just do it right from the start? I spent like a hour
sketching that, the existing preservation code is also very simple,
why not just fix it right now?

Jason

