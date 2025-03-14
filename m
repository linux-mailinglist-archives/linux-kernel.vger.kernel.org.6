Return-Path: <linux-kernel+bounces-561507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C699AA612D1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2261B63825
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A1E1FF5F7;
	Fri, 14 Mar 2025 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OIH7ERGQ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3411FDE26
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959300; cv=fail; b=rfUB9wprfgnK/0pGJ+N0At8rEdOULyS8xvptcz8yC47CdzBBJWe8gCXXxajw3zr2KT8bKjlu5QXejNx0qoFJYqs8+Mgj/2SECH1ztZm59L8MfdgjKShetD/ypD6im72EzwzYOR/65OA/FGNrI6Gm25RKS/BTTgpG3JV+oiPN/G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959300; c=relaxed/simple;
	bh=BmhEkyO2CUo1qqW0xKvLe30+LMgG9Wd6D9nJM+ZNMBA=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eCqltpgC9qSBFnhv3iRyawm2fChCJRpYE6dsmhYqGe8pyPuzebZGgnPkXaumh0htkxNRmCodm4ud4UQHNp04F0qfCVGE/AXJHctwJHl9eZJDqUDeYhydu/2opZ0s+ZTfuuUlNdq68paAUMR68wzIo2gnsYYTn9NZ0Jzq/UMD/bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OIH7ERGQ; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=on6UTuELO+iJNrd5eFwsp7tYggRq28FpY1zybdrQOgV740AHTx1BpNagcipo0zwKcEZQ4OZ5lPSTuejicvDN4EFJ+/jrLKPzsOZXfZqSqGgbzCpJvYtO4q9Gvv3ZXIz7UjlBe/702T5z6sZ1qpx1Yph+Hqay3hhv9RgQRV4tzXHyhq0CKw+hmR6k1+mJbVZyT+Z7qzRoA3cp979lqicWplilaHz9o8GO1DcLW4M3gjXWdeWjXmcvbMLzcN2whSd4YfVBchDtL54oQqKbNEoBhLXdVWl8WS0rQuVA+9lFVwO3CoTU8vLKwbidvJFsHacioiTTQjqIZO7Vtjr7O6IwVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsJd00Xx15Av4WpPdKOX8uS0aW/8hxsOZFHoWBFruuM=;
 b=p8jX8fayG/H4Z1B5c+ZopQBuAsp+OUnc7aQ1sGznIN8x1laCIPniirjUU/44Dy8epYxWiLYKgSUVVxdeGXF2UFTJKG4XKMY1MAtFiin3jGgEYghCeQBHYbw4cq00aw49OVjAroUK1UU/SUEAcaCy60tjKm23FXBrYiLXygOvDJW7W6mr2qtt+XxbsfGZYf5dleAz+SahQ6SSLQ45e0deGwLI0Xya7Y9tTIFGaPNnj3/1V/s2Puf0mg+9Txl3TZ4NEv/nCzSbVXWZY4yVqNLZOXh5gaMSxgbz1CCnfBpbzMJqqxAH7pRBG7gZz3TT7VnReBPoHUjr8WxpMiieGIvDeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsJd00Xx15Av4WpPdKOX8uS0aW/8hxsOZFHoWBFruuM=;
 b=OIH7ERGQDvCfAU7gZlyTkfN8aNlBvw/jhlLX5d7KAd+jzdWarmfG+0eQojwyNqBWBFhIsYXNM0Kx2+IA786Oi//e1J+M3NlqMHzJh8Zz6DEh+1c648g0AuWtak1k8nOJC9aL839jn1x42N8GtVZdhj1NrSLnD23mvgIvAAy4aAXXMLnVHXeK/HBta2XRazOl+lv0CRUhplspo9I5nHEtzfDyr0U+SpxXqtZuknhBIKnZ47TN9/1+f3ze1hbq5tu4pW9rGzC89piB2kev49ScDporj5voKkvBUyMgh9CyrtKn2suo42lN/EJi9EX/CDGOm4Uv7AqsvaBh6ZNVpB6fBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 13:34:55 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%6]) with mapi id 15.20.8511.031; Fri, 14 Mar 2025
 13:34:55 +0000
Message-ID: <a168e78b-ae27-4675-8821-0b1a2499b2b2@nvidia.com>
Date: Sat, 15 Mar 2025 00:34:51 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
From: Balbir Singh <balbirs@nvidia.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20250310112206.4168-1-spasswolf@web.de>
 <951f9d13-72e4-41c3-9ace-8639e2a9485d@nvidia.com>
 <ce940e2a-632d-41be-9f13-e5b11d49b0db@nvidia.com>
 <09131c563332c892284ec7fb4ce706996131db8c.camel@web.de>
 <9a5df5627d3d72b2a97f501dfb7d944cc1e9920f.camel@web.de>
 <fdea59fe-f570-489f-bf88-1ffd47119cac@nvidia.com>
 <414f4deb8c7670a159854006b0c410ce05a6049e.camel@web.de>
 <12d950ee-4152-4ad6-b93e-7c5b75804b1a@nvidia.com>
 <705e95cec3dc5181ca2aa73722e6b84f63f3e91d.camel@web.de>
 <20b5823e-247a-456a-bb55-d50f212a9f5a@nvidia.com>
 <a34a1ae0b1d226b1bac7d73daa24da8e5899cb3e.camel@web.de>
 <c7bb0bd1-529d-466d-9cce-abbac4b480ab@nvidia.com>
 <146277bb0ecbb392d490683c424b8ae0dfa82838.camel@web.de>
 <b63b1de8-7eec-4235-b61e-e654e78543ba@nvidia.com>
 <fa8d5e76694918bdaae9faee9648776f298f78ca.camel@web.de>
 <7866593f-0322-4fb3-9729-82366940fc85@nvidia.com>
Content-Language: en-US
In-Reply-To: <7866593f-0322-4fb3-9729-82366940fc85@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a03:505::22) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 50945719-6964-4b99-cfa2-08dd62fd01c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3Q1N0xzdGlHcEN0QWMyU0ZIT3pxOUJZLzZsZVpuWXA1cEFsRkpEK2lsSyt2?=
 =?utf-8?B?aThuSUdvaVBOQzZIeitsdExxdGZQRlhmMXVkZWtTanNpalRKMnRXWWpHbVhP?=
 =?utf-8?B?elhrS0NBNWY0NmRjOFNzWitXY2FBaDVpeEtSTXF4ZzJDRWkreFFPZ1ZaaERT?=
 =?utf-8?B?Rm12cjNYeTluNXVHUTVnOVd6UGYyM0g5STNBRWZVMzJnSWlUWk5Qb2g4RG04?=
 =?utf-8?B?UGw0RHlPN3F3K3k2U0xCUzduemlhSDdhZ2ZjazFwemtsck9yYml0RkpPcDIx?=
 =?utf-8?B?eTFnNHN2WHNqVGEzMnh3MW8rQ3Q0K2dQeXRjNDdVR2s4dnFVYi9BZkRoRWgw?=
 =?utf-8?B?bWd6ZG5mMUZidW5zOFh0MXNKeUtXWEJGVUhKWGdzV3JJMElwSURkaWhhNEds?=
 =?utf-8?B?Uk5tc3RtRk5xK01abU1qY0hPMEFTQzVzaUdMNjVsMzhOYTBKc3RFNnFRWENQ?=
 =?utf-8?B?RVFUdjErQXJKanpiR1lyL2hQTkZTc0JBQUJaT0VqZWI2aGhyd2t3KytUc0o5?=
 =?utf-8?B?SWNwZFNkRWhOOTFlc2hndVp6S1BYYytiSnJhWW96ajA3QUpiRE5yRkgycGk2?=
 =?utf-8?B?R0hJUmVFTFhlVGY1eGF3ZGFrWmYxVFV2T3JzelR1MmpUVzAxb0hJN1VIb0xN?=
 =?utf-8?B?Si9MSUNBQ1d6WjM0YXl5R1daaVhQZFR3SjRVK3V4bTRjM0RDeWpqeDJEM0kv?=
 =?utf-8?B?U1pQRk1yTEFpMnJLa1dTYlBlQ1l2YUNneXMvVXN4RVk2cEIrUXhiTWhCRmxp?=
 =?utf-8?B?YnMrVldqcnYxTEhkaDF5eW04RjgwMlVMZm5yRktYbE5teWUvb1JQM3gzZzFB?=
 =?utf-8?B?eG8zRUgrbHpxNzNmWlpJL3JxQmh2dWx2MXQ5SGZxQmp1RmJPcEFXSEVlSk1J?=
 =?utf-8?B?bEluT3doUnBVSmV2OHdWcmtqRkRXRWtYbGdZS1liNktuVVV0RHdKaXluMHdh?=
 =?utf-8?B?a2x6aWJCRGlTVUt5WnY2KzQ3U3VrbUR1dXYra1RCbW5TekJHVHZGVTdrK0Qz?=
 =?utf-8?B?MXpSb3ZhSyswdGFrWDlsaEMwbGJaWDBVa2hYQUZBOW1xQVFwdXJZbDNoUUt1?=
 =?utf-8?B?UGNabG03eWRRTUVsSG9KVnoyVWxXcVY4RkorY0ovamV0cVFtNGJTSjBrTGJx?=
 =?utf-8?B?QmV4dnFaOEVGZjZONVAvenZyZW0xZ0Zsdmk5WDZ1Wm5JNmVudXI1WW9xTEgw?=
 =?utf-8?B?cGh3YWI1d0Q3azhoUm41Wi8yWlFJRElBTzg5RnpNZmlibGxldEhPVi9rb2ZV?=
 =?utf-8?B?MGRzbytKVXJndDFBTFB2OG5kV0liYnJxMit2ZVdIQmhUUmNqS0FYdjlCakll?=
 =?utf-8?B?YzFhK3Y1WDZ6SFRsK1pHa1ZwWVZtOFY4cXk3ZjB0Z0ZIUUI5TFNtMGcxVEov?=
 =?utf-8?B?V1NFKzhYcnJLckl5YVZ2T2VOQ3VmV3lITkVaM0s0NVgyaUVia0Rhd0g1cncy?=
 =?utf-8?B?bC94T0R3VkJkQlhDcStJQzVCMVU1UlQyZ2s3V1FBZHpad0RGZW1wTnQ5Z3pJ?=
 =?utf-8?B?OVpnQ2l0eXVOZHFxQm5XVUZqK2pVQ3FEZnpNTzBkWEFmQnV2Q0tKcTBIZ0g3?=
 =?utf-8?B?RkJnMEV0OUUyR2IrUCtuRzYrbjYrcGVtMUFVWlpETVNuZzVzdGgycmlSbXRj?=
 =?utf-8?B?RUpRRDg0WndKRlZoWE0yRUltMEw2cGhWb2FaKzU1NkRrM3BBSmFqa0JsV2JO?=
 =?utf-8?B?Vk1NYUFxZi9vSGZZQkhBdTdvQzV2SHUyNDZoWk1kT3JxSkI4aUtkVElnalFC?=
 =?utf-8?B?a2ZpdWhScS9WaXFaNlJhSUxhVnY0aXJzSk9IR0ZINWk0RWpiOUZ4Vlo4bzhz?=
 =?utf-8?B?WXloUlZIbVBPcm9BRjhEYkhMRXZydmgxcDlabmpNN1BVb2VGRzVxTVByV0k3?=
 =?utf-8?Q?rJnAH0Xhsc3YK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ektzOWRQU3VJWVdHdktPVTR2aWZ6UWNGZG9GMDFPa2ZteitnM004OUdJMFpJ?=
 =?utf-8?B?eEVYWWhia1VOOVkveE9FbS9rQjZiQVJXN0F2eVVmQytyRExPQ2ErcDIrQzR3?=
 =?utf-8?B?VUJqYjUxalNHTVBjZ3hvbFowMWlGSDh1eUNZUkFXSFBHVmVTVmxmNXl1WGps?=
 =?utf-8?B?NlRpRFhEbVpzR1JJSDFrQ0tnajBjV1p4dURaZFVKWFA2Z3kxRU5aWEFMSXhH?=
 =?utf-8?B?YUY3cUQ4Ukh6N3lXcTViWkh5UDhiYmIwcUxNUUNKbzJxd2h3SHNxY0piamU0?=
 =?utf-8?B?ekNzRDRGbUVyNHB1dWVTeDVuVVZGaG5kaWhxcDFhUGtLbDV2aVFiTnRLUzcw?=
 =?utf-8?B?RFRXSmsxOVN4bEs0SjErc0JtS0t4Rnl5ODF2d2x5ODIwTUFDcDl6YVZQTVhR?=
 =?utf-8?B?WjJSTmwxVUJMVDlQTUJCL3NObW1BRXBmR21OTVB0bEFGNTNuSGtQVXJVenY2?=
 =?utf-8?B?VUdkL1h3MFl0VlVZa2VDdXdrVlBIL1RGS3FDV25JMjgxRHR2LzBWNDJKWkE1?=
 =?utf-8?B?Y0ppMU5IMGtTMDFldzEyRGhVU3lsTFY3SldKN3NKemRlbE5oNE8vNnFObVA0?=
 =?utf-8?B?VU1WNWd1RjNkUHQvOTd5dlcxYlgybGFjV2lPYlZhMi9OOXYrMkwvL2dCSHd6?=
 =?utf-8?B?OWpHUUh3b0NUTWJoRkNKVCtJYWQ4S0tPV0dxSFlvT09ZSjhrekEzbXFsSFdM?=
 =?utf-8?B?ZzUzNlFSUldTOElqdHRpTnhKM0FiMXRHV0hJZ0w5UVpyeHJacnVMenE2NGVB?=
 =?utf-8?B?TjR0a1ZOelpWSUxFUy9WMzVHL2Q4aHZxcjc0VXFRWmwxb3o0OStiZDdra3dY?=
 =?utf-8?B?Sk16VmxraWhORWx1amdxMEFuNXlIeTk0Z2Q3OFJIdGNyTGQ4b2hZTEpuMDRn?=
 =?utf-8?B?OGhmY2Nxdmt3QW0wZDN1c3V2anJKUnRpZnhIWnhFL0JYWXlBR09UbEV0ajBh?=
 =?utf-8?B?UktqQ1NXNXl1czg4ekNhZzJZa1RJdW1SNjFjVHRvK3FlY0gzMHpmVW14ZjRo?=
 =?utf-8?B?L21MTVZVRmZ6VGxSVGIxWXVLOFVxT3BMcGFQUUZZNnJMR1M3Y0dmUWlUOWNQ?=
 =?utf-8?B?ZDh3U1JncmwxZGdVRFRtVkZkaXBqamFPS05YanBPa3VUWktUWWpIVHBwMlF4?=
 =?utf-8?B?OHNEdE9LblVRUXZzT1ZoZHNybDJ5S3dybWtuYzN4d3NVditaN2hBd3RlTmVM?=
 =?utf-8?B?L0VaNGhvVnBwdG1KVE4zRnoxSUxTMml1dWRhQXBaWEthcGMxZklpTldpUkJh?=
 =?utf-8?B?YzlCUUhrZUFrZmRhYkhKKzVla01xOHRlZEhweFU3VFZxYnBrNkVIbkZ0VzV1?=
 =?utf-8?B?RksyOVd0VVVFUWVnb25vNGIwOVVmcGZHcXVHRE93MXRBWVo0NkZyZUUxRFd6?=
 =?utf-8?B?bTNhdW9yTDgyOWN1bUJ4Zm9YYzJZQzd4MlJtYkNvWHZuYXVqeHRUV25lY3FN?=
 =?utf-8?B?MXFOZzROZkVHb1V2c2NCeXZoaWRua1lPLzBRdE90b3JYTHFoSUVUdlhPN1h1?=
 =?utf-8?B?TkRiNWdWRGtvcVR5M2ZDMy9oaUtmMlhjb3JOd0NWU1o2V2d2Vzhick5WbmFk?=
 =?utf-8?B?SUdVRWV1MTFEWWpvQmpIaG9WM09ZRE5wUmxCVXBGVk1QRDZmVGwyM3NmN1hK?=
 =?utf-8?B?bEE0bHlYWCtweG5KbDI3aW9sazR3NmR6Qk40ODhCc1V3NzBJUlVLd2xBTmJI?=
 =?utf-8?B?TEZid3NzaExabVJRTjlZaFVwRkk3aWxHdkhKbFZqdTdFVnBuaFdlUE1FV2JK?=
 =?utf-8?B?d1dVdUIvdkNCLzJkUHlNRlNtWE5WNWFKc0RZYWhhRGJSM1ZoZ0Y5d2RDZURN?=
 =?utf-8?B?NTFRVElvZmQwaEM2VHFiK2VIdW12MUF0UnZ3SEIvM2RYUzZSeE5vTnZ4dEZp?=
 =?utf-8?B?Ny9EU2c3YndIM1RQR0U1Wkl0ckkzdzYrY2V0U2xva3pGQW03ZTF2b2FNRkY0?=
 =?utf-8?B?L21LYzNydUhHNDN5azBqamVQVUxDb0pkdWh1cWlrcWJEbDRBUE5xR092a1Zk?=
 =?utf-8?B?WXE5L3VqV2VQVFAvSmMrVmFXZTdWYkJmL0RQbS94N2VmLzVVUkxXQlRLZzE1?=
 =?utf-8?B?NEZxUFl2TGlETmJ4K1g2MDdPZ0sxZ21uMlEzNnYvRkg0YWpXVUJoZ3QzZHNX?=
 =?utf-8?Q?xe19V/Lf691AW4vXNNI0E6nkd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50945719-6964-4b99-cfa2-08dd62fd01c9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 13:34:55.4602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wA/MsDiflcCtCMji4dvT/X/uyFluhD87Jd8CyfHywKNpHm9uUy8f/+1yULdY5yL+I2OEK3Nx+SJtptXDQrctA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249

On 3/14/25 17:14, Balbir Singh wrote:
> On 3/14/25 09:22, Bert Karwatzki wrote:
>> Am Freitag, dem 14.03.2025 um 08:54 +1100 schrieb Balbir Singh:
>>> On 3/14/25 05:12, Bert Karwatzki wrote:
>>>> Am Donnerstag, dem 13.03.2025 um 22:47 +1100 schrieb Balbir Singh:
>>>>>
>>>>>
>>>>> Anyway, I think the nokaslr result is interesting, it seems like with nokaslr
>>>>> even the older kernels have problems with the game
>>>>>
>>>>> Could you confirm if with nokaslr
>>>>>
>>>> Now I've tested kernel 6.8.12 with nokaslr
>>>>
>>>>> 1. Only one single game stellaris is not working?
>>>>> 2. The entire laptop does not work?
>>>>> 3. Laptop works and other games work? Just one game is not working as
>>>> expected?
>>>>
>>>>
>>>> Stellaris is showing the input lag and the entire graphical user interface shows
>>>> the same input lag as long as stellaris is running.
>>>> Civilization 6 shows the same input lag as stellaris, probably even worse.
>>>> Magic the Gathering: Arena (with wine) works normally.
>>>> Valheim also works normally.
>>>> Crusader Kings 2 works normally
>>>> Rogue Heroes: Ruins of Tasos (a Zelda lookalike) works normally.
>>>> Baldur's Gate I & II and Icewind Dale work normally.
>>>>
>>>> Also the input lag is only in the GUI, if I switch to a text console (ctrl + alt
>>>> + Fn), input works normally even while the affected games are running.
>>>>
>>>> Games aside everything else (e.g. compiling kernels) seems to work with nokaslr.
>>>>
>>>
>>> Would it be fair to assume that anything Xorg/Wayland is working fine
>>> when the game is not running, even with nokaslr?
>>>
>> Yes, Xorg (I'm normally using xfce4 as desktop) works fine. I also tested with
>> gnome using Xwayland, here the buggy behaviour also exists, with the addtion
>> that mouse position is off, i.e. to click a button in the game you have to click
>> somewhat above it.
> 
> So the issue is narrowed down to just the games you've mentioned with nokaslr/patch?
> 
>>
>>> +amd-gfx@lists.freedesktop.org to see if there are known issues with
>>> nokaslr and the games you mentioned.
>>>
>>>
>>> Balbir Singh
>>>
>>> PS: I came across an interesting link
>>> https://www.alex-ionescu.com/behind-windows-x64s-44-bit-memory-addressing-limit/
>>>
>>> I think SLIST_HEADER is used by wine as well for user space and I am not sure
>>> if in this situation the game is hitting this scenario, but surprisingly the other
>>> games are not. This is assuming the game uses wine. I am not sure it's related,
>>> but the 44 bits caught my attention.
>>
>> Stellaris is a native linux game (x86_64), the one game (MTGA) I tested with
>> wine worked fine.
>>
> 
> Thanks for the update! I wonder if there are any game logs. If you can look for any
> warnings/errors it might be interesting to see where the difference is coming from?
> 

In addition to the above, does radeontop give you any info about what might be
going on? I am also curious if

nokaslr and pci=nocrs works for you?

Balbir

