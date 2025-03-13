Return-Path: <linux-kernel+bounces-560134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F11A5FE6E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF9F1886345
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903271CD215;
	Thu, 13 Mar 2025 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="HNfLNYzP"
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021135.outbound.protection.outlook.com [40.93.199.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2A91C84A8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887777; cv=fail; b=eXobwYDBuSSQ6nf1Hy/cCarOZf1vKmc1yu/dJ7+GgH4bQLQ0+04sayl52QdyLSFvneapvPSHPdmph/hi2Umxv8snlkiNP+/3AvbL3qggmjtYrwR1/3veI/JdoP/fCykE80Jq9K8WZbg4kDNZmMeo6SZxM3icvJh11ZoT6erv9CI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887777; c=relaxed/simple;
	bh=qfBfFBOufYehXBQrfST3iNDturOSD9bmDFEiSDZHGRM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YG6gvmUK90XbydEBfWNlgzIaQIoWZjzRCcoTVQtk41YCzhkHTxQJQIaeP9yho96hOxP+EboMoj22o4Qf6IKd3ZYXEhjCNRqerRAyWV5VhVFHkiLXW6TXD8qP2mCVQucJbsa5zb5/urDzgEkpv/VXUH+xjI+aqmc6J3QNDlQFZz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=HNfLNYzP; arc=fail smtp.client-ip=40.93.199.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXpKxDP4xlmbLR3jFttwkFqz6tkRBIaQyoidhqAuKm7NTMCpxSTaWRfZpwf8IeBn8aCV3Lx/4nZvsTlt3tqODnKHUX95xpSChGnuvPU4yeUEl8UFSO4arlIrkBj26Uv2Nbv8JqQYIvFn/UMl7odxKY8mrWydUri6jATKQjFfBDsCW+wsVW66yfK/IGg1CPz4mL0hbbwu7282HRkpJnDVLY9NN6PI/BCa++lmUR5g44IcUPoQId8k1wQ/C+oK17H9ipSrUChQCOSd7jCicfJTyyDvpmhaN611nZ7MzuHqjojVwzzeYK2fCFVKMX4YOE7Au+/FucLW2n34IzOphhMWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0XRRvJ+/3suVOu4MDaSlkqiDoXCTDUpT24GHZ4qnSQ=;
 b=TkI5XF2+xk8PpgNvYcW7jBDBcd7SzI6x/ig3UZ3ENWwLv9zwVQKlyeOhtJEe5Erpj0gLn+2LBQk7t2LWHr96o6ciSHg0yIyx1DVpHvyhJ4Bl4oYPb1fYvPYKs/9FqZpWFuZ0rWfuPqPLXaRgQVaJMw1nUT/McO6PAUcmnfn2WdoqfkAEqMvPhWxtME9D/ZtdrVifDXiTdAhd0gsuEdaQXVexwZejUFH3c+KQ/fNDVhXwHxNK3JipPc12qs3yNrgU288T5h/Hh+L7d6fNXx/A4aZ3TBGrmNNrzLIm8nKQqKvy2Gt9w8JtECaxDkRV0Pk5XGt2eXfP5W0lwLdAft91Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0XRRvJ+/3suVOu4MDaSlkqiDoXCTDUpT24GHZ4qnSQ=;
 b=HNfLNYzPSTONtW/dmHQLMrfX1cFexgGzZkiTIryhwVIhAtAo/cjScXtnFSlLCtogVjc6XhmfQsY9YtXGRts0LBdTc1HSa7bigRFlXYlj4pOma1+XUcnswR0U1HSI9Ay92Dabf4jB5FAX/PArF6lQLHfD9wLoVnyx8tYXgLstRlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 BY3PR01MB6708.prod.exchangelabs.com (2603:10b6:a03:363::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.28; Thu, 13 Mar 2025 17:42:48 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 17:42:48 +0000
Message-ID: <e8192bd7-6c74-4f3e-95d4-38adf56fd4fd@os.amperecomputing.com>
Date: Thu, 13 Mar 2025 10:42:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] mm: vma: skip anonymous vma when inserting vma to file
 rmap tree
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vasily Gorbik <gor@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Liam.Howlett@oracle.com, vbabka@suse.cz,
 jannh@google.com, oliver.sang@intel.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
References: <your-ad-here.call-01741821544-ext-0004@work.hours>
 <459212b0-6440-48c4-b7ae-47be46f17089@os.amperecomputing.com>
 <9dc18681-66fa-41f4-ab49-4a395b52ea25@lucifer.local>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <9dc18681-66fa-41f4-ab49-4a395b52ea25@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0415.namprd03.prod.outlook.com
 (2603:10b6:610:11b::26) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|BY3PR01MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8128e1-b0e0-449a-ae1d-08dd62567851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmcwSndzdHBlbkIxQTFmc3BjY2VtU01PR2hsMTVKN3l1N1BMTmpMTXpQaUdT?=
 =?utf-8?B?Z05UejV2VE8yUy9wN3k3emxXQXVlampheXA3NXlreFR1NzljRC9VbG9YcEtL?=
 =?utf-8?B?aUMvODZPd0U5S3FkbFEzKzFLejdQWEN2b2tDdHdXMnpwSVJVU2ZUNmg3Z2dW?=
 =?utf-8?B?ZEorTWdzQ2RqZW96cktuTkZXVlgwdHp0ZGNRTFFUUUVaaXp1ckRobG8vdjJW?=
 =?utf-8?B?aDFvZW9jZFcrZWluWmNHL2F2a0VsQWpLUUU1Z3U1KzBRWU5iallBTzZ4aitV?=
 =?utf-8?B?SVJpd0h5cTFkdFppcE0vMzlBRDlneHY1ZVFtYVIvV0EwNXYvc2xnSk5ZUmY5?=
 =?utf-8?B?Z0lEeEI5Yms4SmpmVlpnbjRrTlVsQzNpODFxQnlKWEx1RCtpNFowaEJiUDFM?=
 =?utf-8?B?aWZsdGlWZDZmZUJ3U3JwTzlDWEduMSt1Q2QzWE5ZUE9UU1hPVjhaVndFZDNF?=
 =?utf-8?B?UzNwQ0E0blNHRVdQWWwyUGVSNUQ5VnhnZjRBdHhOMU1udXhINXo2Nk9tbEJs?=
 =?utf-8?B?U0JHWUVkNVlsQTVZbitHQUozZVZvNGRYWVdBK0l4SEMvQ3RjVHVReXoybHhW?=
 =?utf-8?B?NjdRMFNzcUp5MFpWQWRrV0I3K1Bnb2hpQ1psejVMOW9Uakk2c0pZVDRBSDBY?=
 =?utf-8?B?V2ZsY3ptaHFUcHhEck5HeC9rdU55OGJpRWV4NERkU0JaK2tBTnA0NXM5L2E2?=
 =?utf-8?B?dHRrd2VINmZLcDFxNmdsK2R4aWNpQnJKS0UxcjhaYllSWFU0KzlUbkJSVlVy?=
 =?utf-8?B?NytXRVhSUEtvbnRQRm0zMUhHaVRBOXc0R0ZQek43WEM4VHR5bytia2hFWXFy?=
 =?utf-8?B?UmszQTl6ZlJQYmFETzBjbDBPL2xBVFhhUXp4Z2k4RFpQTHFuUDFRQ1JsOWts?=
 =?utf-8?B?OXFDM0FDVUpOQ010ckpxam5QdjVkdEljNEZnZFg0dFlDem5NVUtyWU1Vd1Iv?=
 =?utf-8?B?TVRKaFRkUm9oWTlLWnZFK2dUMExIdDUzT29SQnZKeVdXSUlLV2NRMlFVOXhy?=
 =?utf-8?B?d0k3NGtJaFlCc2FvVkRIdUlDUG1RK0RIT2xrS0w4emhwY0hoUTlBVUlqTFdO?=
 =?utf-8?B?Rmd5aWJaWEM2d3pQNVNzYWcvbWxVMFIrV3NnTUtXbjMwUExSWHd0V3RHVU1D?=
 =?utf-8?B?dFE5cXFGa2Q2Z0JZSjYzWUlGV0I0MDV6MDNXMG9hQzdGbWNyWkpZTzJpMWtR?=
 =?utf-8?B?UXFOSVd2aTNqeVVhbDFnb0pwQ3NCWC9IZHRmYXF4T0hJbEJBS3F4UGZValBN?=
 =?utf-8?B?Sk5tSXVzWGQrZTFLaFg5L3pvanRQWFFLRlNCdE9wZjVqOXZycTlnWThqcXBq?=
 =?utf-8?B?cTlKNWU4RkFGbUVBd1JqUndCSnp1ZUZkK0RBTk9LNVdZTWY3TklXeEVSWTRK?=
 =?utf-8?B?VmoyL1lJS3MxVklJNnBpUFpFb0R2c3ZYTXF0SzRWYWh0UmtJenMzcnE3S3FY?=
 =?utf-8?B?ZFFwNDhEQlBuY0NSVVNYQ29EUzloODF2eklSVVFSSU0zV0Vzd003Tk1yRHhq?=
 =?utf-8?B?RSswVG1lVkxXUk5QYW5UbWVvT3MrRWxwODVSNHZ6UmQ3VSt6dXllWDFtTWUz?=
 =?utf-8?B?dTJPcU9rWlo2RmdqU0FzVklXd2xVZ0FEQnAwQ3RkeHpCYTE1bk9yb2ZJRTlZ?=
 =?utf-8?B?S3dKMUhHUHhrQlNnYmZWYjlPVmJtSmhRQm1PYVRNSUdzb0NPRWpIZnAxMjNu?=
 =?utf-8?B?bU81V0laa3Y2dkdKUlEzOW85Vzg4dzBzL3VmL1NWZjdPeDkrYzZHQnFXblFq?=
 =?utf-8?B?cUU2ZXRta2xYR2IyY084N3FNOGtoOVFnUlJORlNVVHptWk43cVg3VW9xTlBR?=
 =?utf-8?B?dnFJTWU2T0RoeUpGQVc3eWR2d1hnU2hjR2ozZTU4djBjc202WG81ekZldlds?=
 =?utf-8?Q?53zJuzXp+pnXV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFNNN0JHemtFd1ZMeGxSZy9ibld2MUkwbkxBR0lCMWc2L0RLR2o1YzdoOGlN?=
 =?utf-8?B?TDhwYXhyams3alkrRG1YMzZsMk5wSDFPYTdwVEdnSGl6Yi9YQm9WekNWRkpj?=
 =?utf-8?B?ZDZ4bVZaWnNYZ1cydUQ0OHJHTks4SkJWc0c4RWwrZDJDYVdYR1Y0aWtjRzNE?=
 =?utf-8?B?blh1Z3Z4bC9WZ3RjNEVNVGtqZlZtQjhhcUxIV2w4bWNFejM0cFk5WlRLRVMz?=
 =?utf-8?B?Wm9UQVZWTDhRZnRDeGEwdjZHa2J1anp1N1VOMXpZYktxa1Y1a2Y1aS95eFlG?=
 =?utf-8?B?aytIY3lndU5PWmpGTWFNUlMrQTl1ZW1SdHBITERjNDJ3ZEhuMS9UWDNQYVpx?=
 =?utf-8?B?WVlYYjhrdXF4bVpuMG1DZjJjNUdrSFJNdFJYeDZ0R1dxa0p4S001Y3pyYjRX?=
 =?utf-8?B?c0pqT0RpS29PYmxnc28zWmxZdnEyb0xLSHlkYlYrTU1KSjB0SWl1dG1OSEtq?=
 =?utf-8?B?NGhQMEE5VWh1bzI4SmFHemU1a1VGN2tYbHM0RmVvQ3M3ZjNzeThmVExidUMx?=
 =?utf-8?B?bVVJSDBMLzFSeGJBb3hUMUM1bWkzVE03Z3VzTC9FYStna1hjb1RWamxEYk1C?=
 =?utf-8?B?anoxVlAvVHRzZGJnbjJxdzMySHJneGdzaXhSWDhvZ1hjNlpKSTAxdFc2MXFz?=
 =?utf-8?B?cUJ1aWZUSzl1L3lwMWNOa1IxbHR3aHRnMHBiWEQwQndCSXE5akxncmkxNitO?=
 =?utf-8?B?T24vV2FESHZUS2dLNzFqWWdIZWNjR0RZdTJBVFdiMjJXSlhCdzBUTkNlNHMy?=
 =?utf-8?B?TWQvTjIrMzg4dFdyY0JGaTl6UEJQd0g1a1lIbHFIRC9aMEgvQlJMWm9yWFNG?=
 =?utf-8?B?VjV4VlRNUHFCakp5TG1rRHZrNld2RFpXNTd5QUNORUNMMFA4QnpOelZBMEk4?=
 =?utf-8?B?OUVPNkVscis4cUpCbDl4NytOblFHUmFSOFFLa2RkYkJLNUFseFo2OEtYMjJp?=
 =?utf-8?B?TXNFRmhjNm5rclZhcWRwMXZqT2pYeEI3L0xZa1AwVThPSEpIUUdNTXZ3c0dj?=
 =?utf-8?B?NTFZTWlHRVlSNGRlTHBlNUhaSnBJbGEyQzZlMHRjOU9SZmxLcjV3clNIdEN0?=
 =?utf-8?B?TVN1OHJVYXRQOHI5bEtHNG1ZL1FVVEhjMmNVd09zSWRNVGxoa3dVYXZyZ1Rr?=
 =?utf-8?B?cVdaeExQcDlCSm9Pcm5iUzZDUWtRMDdZeDdwYnhieTAvVmRQRTdYSWVkOFMr?=
 =?utf-8?B?L0R6d0g4OW5CdHJlUEg3NUM2UFFoRVdQVWNldnJIclo1Vm5iV1BYd1BDS1Zz?=
 =?utf-8?B?ZFk3NG9YM29IaFhSRXhib1dQMXV4UVd3SU50QmJrTVU3dWI4UmwwUGovVnk4?=
 =?utf-8?B?NjJGRC9qNDBvUUVyODZ5MWNwTktyd1J3aFZERmo0OFpleTVieFoxUGZSVGtr?=
 =?utf-8?B?cVBFajB0Q2VDZnNmekpLTkhiTnN0RGRGVmVkZExNSk9KYm8rbDFhVGI4V1Jn?=
 =?utf-8?B?dVRaalEyT1FqQXdkL3NneXlEL05lc1FqVjdKZ01obldrdUIzNGZYa3FnbXlP?=
 =?utf-8?B?aDNzc05UM21nclk5cjVDWU9tQXpPaW5MRklEVGVFaVZudC83UUc4SHhuSDI0?=
 =?utf-8?B?YWJWN3pKTWIyM3I0Y0VzTzZPU2JpQkxkVzQzcmFOblhKN0I0ZGxvY3lWNVJk?=
 =?utf-8?B?RFN4YWFFU1FUc0thNEdneXBLYm5QVmhqaVYrZWdTb3lmT2ZaTTU2cTBNdUh1?=
 =?utf-8?B?dmx0ZDd4c3JZOGZrYnZ5Z2p6T1VnOUQySFVXY0trK01wWjBCZHc5OG54VGVT?=
 =?utf-8?B?b1QvS3ZqeThuek82aUtmdWFyamF0YVQ4U3BIaVhJRUFHNFRzdk1TQ3ZBQjJ2?=
 =?utf-8?B?cmFoSTlYejg5TWQyZW5VMlRMQjZnUnlGckFsWW5vaGJuNEQ4alZxeG1vcWx0?=
 =?utf-8?B?OFNCSitXSDNsdmFxYms4T1JJVDFqallDQncreS9RdmY4Zm00RzNhK0xIZnUy?=
 =?utf-8?B?TmI3cW5ja05YNHRYcGI3dW9zM0oxV2pvRm01Sk1jakp5RUVMRC8yQmg2SnBE?=
 =?utf-8?B?Zng0bmtEOFJRM2JtWGEzaHZUc2FUaHhZK1ZlWk85bmVoNVhoVEV4ZE9NQzZy?=
 =?utf-8?B?ZTUzOW1SKzYrY0Y3emZSa1FHOEFoRGpSeElYSU9pRUVlaWtsNGcvTkRpK3BU?=
 =?utf-8?B?akFrU1Nib1BmOFAyWFNZeHZTdzVXejZHM3VSWWtMRFcrdmZ3UU9qYkpudmY2?=
 =?utf-8?Q?8mzFb7F/AY1R4L6ypzBVPOU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8128e1-b0e0-449a-ae1d-08dd62567851
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:42:48.3333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+HXGk/jbG48kS1Q5bJ0KdjTJTp0VmhHdkgU4n3V85vKPe8D/R66iWlniJW8uRGaTHwK2osMTQ/QPlejIMIbU0FpEH5A3GI3eLEOAg+bck4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6708



On 3/12/25 10:16 PM, Lorenzo Stoakes wrote:
> On Wed, Mar 12, 2025 at 08:04:23PM -0700, Yang Shi wrote:
>>
>> On 3/12/25 4:55 PM, Vasily Gorbik wrote:
>>> On Wed, Mar 12, 2025 at 03:15:21PM -0700, Yang Shi wrote:
>>>> LKP reported 800% performance improvement for small-allocs benchmark
>>>> from vm-scalability [1] with patch ("/dev/zero: make private mapping
>>>> full anonymous mapping") [2], but the patch was nack'ed since it changes
>>>> the output of smaps somewhat.
>>> ...
>>>> ---
>>>> v2:
>>>>      * Added the comments in code suggested by Lorenzo
>>>>      * Collected R-b from Lorenze
>>>>
>>>>    mm/vma.c | 18 ++++++++++++++++--
>>>>    1 file changed, 16 insertions(+), 2 deletions(-)
>>> Hi Yang,
>>>
>>> Replying to v2, as the code is the same as v1 in linux-next:
>>>
>>> The LTP test "mmap10" consistently triggers a kernel NULL pointer
>>> dereference with this change, at least on x86 and s390. Reverting just
>>> this single patch from linux-next fixes the issue.
>> Hi Vasily,
>>
>> Thanks for the report. It is because dup_mmap() inserts the VMA into file
>> rmap by checking whether vma->vm_file is NULL or not. This splat can be
>> killed by skipping anonymous vma, but this actually will expose a more
>> severe problem. The struct file refcount may be imbalance. The refcount is
>> inc'ed in mmap, then inc'ed again by fork(), it is dec'ed when unmap or
>> process exit. If we skip refcount inc in fork, we need skip refcount dec in
>> unmap too, but there is still one refcount from mmap.
>>
>> Can we dec refcount in mmap if we see it is anonymous vma finally?
>> Unfortunately, no. If the refcount reaches 0, the struct file will be freed.
>> We will run into UAF when looking up smaps IIUC. It may point to anything.
>>
>> Lorenzo,
>>
>> This problem seems more complicated than what I thought in the first place.
>> Making it is a real anonymous vma (vm_file is NULL) may be still the best
>> option. But we need figure out how we can keep compatible smaps.
> Ugh lord. I am not in favour of this for reasons aforementioned, and I _really_
> don't want to special case this any more than we already do...

Yeah, understood. I meant we should find a way to make smaps unchanged 
or compatible.

>
> Let me think a bit about this also.
>
> Maybe if you're at LSF we can chat about it there?

Unfortunately I can't make it this year. Have a fun!

Thanks,
Yang

>
> Thanks!
>
>> Andrew,
>>
>> Can you please drop this patch from your tree?
>>
>> Thanks,
>> Yang
>>
>>> LTP: starting mmap10
>>> BUG: kernel NULL pointer dereference, address: 0000000000000008
>>> #PF: supervisor read access in kernel mode
>>> #PF: error_code(0x0000) - not-present page
>>> PGD 800000010d22a067 P4D 800000010d22a067 PUD 11ff09067 PMD 0
>>> Oops: Oops: 0000 [#1] PREEMPT SMP PTI
>>> CPU: 5 UID: 0 PID: 1719 Comm: mmap10 Not tainted 6.14.0-rc6-next-20250312 #3
>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
>>> RIP: 0010:__rb_insert_augmented+0x2b/0x1d0
>>> Code: 0f 1e fa 48 89 f8 48 8b 3f 48 85 ff 0f 84 a4 01 00 00 41 55 49 89 f5 41 54 49 89 d4 55 53 48 8b 1f f6 c3 01 0f 85 e1 00 00 00 <48> 8b 53 08 48 39 fa 74 67 48 85 d2 74 09 f6 02 01 0f 84 a0 00 00
>>> RSP: 0018:ffffc90002b47cc8 EFLAGS: 00010246
>>> RAX: ffff8881143ab788 RBX: 0000000000000000 RCX: 00000000000009ff
>>> RDX: ffffffff814ad5d0 RSI: ffff888100bb5060 RDI: ffff8881143ab088
>>> RBP: ffff8881053af8c0 R08: ffff8881143ab700 R09: 00007ff6433f2000
>>> R10: 00007ff6433f2000 R11: ffff8881143ab000 R12: ffffffff814ad5d0
>>> R13: ffff888100bb5060 R14: ffff8881143ab700 R15: ffff8881143ab000
>>> FS:  00007ff643df1740(0000) GS:ffff8882b45bf000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 0000000000000008 CR3: 000000011b042000 CR4: 00000000000006f0
>>> Call Trace:
>>>    <TASK>
>>>    ? __die_body.cold+0x19/0x2b
>>>    ? page_fault_oops+0xc4/0x1f0
>>>    ? search_extable+0x26/0x30
>>>    ? search_module_extables+0x3f/0x60
>>>    ? exc_page_fault+0x6b/0x150
>>>    ? asm_exc_page_fault+0x26/0x30
>>>    ? __pfx_vma_interval_tree_augment_rotate+0x10/0x10
>>>    ? __pfx_vma_interval_tree_augment_rotate+0x10/0x10
>>>    ? __rb_insert_augmented+0x2b/0x1d0
>>>    copy_mm+0x48a/0x8c0
>>>    copy_process+0xf98/0x1930
>>>    kernel_clone+0xb7/0x3b0
>>>    __do_sys_clone+0x65/0x90
>>>    do_syscall_64+0x9e/0x1a0
>>>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>> RIP: 0033:0x7ff643eb2b00
>>> Code: 31 c0 31 d2 31 f6 bf 11 00 20 01 48 89 e5 53 48 83 ec 08 64 48 8b 04 25 10 00 00 00 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 89 c3 85 c0 75 31 64 48 8b 04 25 10 00 00
>>> RSP: 002b:00007ffdac219010 EFLAGS: 00000202 ORIG_RAX: 0000000000000038
>>> RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007ff643eb2b00
>>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
>>> RBP: 00007ffdac219020 R08: 0000000000000000 R09: 0000000000000000
>>> R10: 00007ff643df1a10 R11: 0000000000000202 R12: 0000000000000001
>>> R13: 0000000000000000 R14: 00007ff644036000 R15: 0000000000000000
>>>    </TASK>
>>> Modules linked in:
>>> CR2: 0000000000000008
>>> ---[ end trace 0000000000000000 ]---
>>> RIP: 0010:__rb_insert_augmented+0x2b/0x1d0
>>> Code: 0f 1e fa 48 89 f8 48 8b 3f 48 85 ff 0f 84 a4 01 00 00 41 55 49 89 f5 41 54 49 89 d4 55 53 48 8b 1f f6 c3 01 0f 85 e1 00 00 00 <48> 8b 53 08 48 39 fa 74 67 48 85 d2 74 09 f6 02 01 0f 84 a0 00 00
>>> RSP: 0018:ffffc90002b47cc8 EFLAGS: 00010246
>>> RAX: ffff8881143ab788 RBX: 0000000000000000 RCX: 00000000000009ff
>>> RDX: ffffffff814ad5d0 RSI: ffff888100bb5060 RDI: ffff8881143ab088
>>> RBP: ffff8881053af8c0 R08: ffff8881143ab700 R09: 00007ff6433f2000
>>> R10: 00007ff6433f2000 R11: ffff8881143ab000 R12: ffffffff814ad5d0
>>> R13: ffff888100bb5060 R14: ffff8881143ab700 R15: ffff8881143ab000
>>> FS:  00007ff643df1740(0000) GS:ffff8882b45bf000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 0000000000000008 CR3: 000000011b042000 CR4: 00000000000006f0
>>>
>>>
>>>
>>> LTP: starting mmap10
>>> Unable to handle kernel pointer dereference in virtual kernel address space
>>> Failing address: 0000000000000000 TEID: 0000000000000483
>>> Fault in home space mode while using kernel ASCE.
>>> AS:000000000247c007 R3:00000001ffffc007 S:00000001ffffb801 P:000000000000013d
>>> Oops: 0004 ilc:3 [#1] SMP
>>> Modules linked in:
>>> CPU: 0 UID: 0 PID: 665 Comm: mmap10 Not tainted 6.14.0-rc6-next-20250312 #16
>>> Hardware name: IBM 3931 A01 704 (KVM/Linux)
>>> Krnl PSW : 0704c00180000000 000003ffe0ee0440 (__rb_insert_augmented+0x60/0x210)
>>>              R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
>>> Krnl GPRS: 00000000009ff000 0000000000000000 000000008e5f7508 0000000084a7ed08
>>>              00000000000009fe 0000000000000000 0000000000000000 0000037fe06c7b68
>>>              00000000801d0e90 000003ffe04158d0 0000000084a7ed08 0000000000000000
>>>              000003ffbb700000 00000000801d0e48 000003ffe0ee057c 0000037fe06c7a40
>>> Krnl Code: 000003ffe0ee0430: e31030080004        lg      %r1,8(%r3)
>>>              000003ffe0ee0436: ec1200888064        cgrj    %r1,%r2,8,000003ffe0ee0546
>>>             #000003ffe0ee043c: b90400a3            lgr     %r10,%r3
>>>             >000003ffe0ee0440: e310b0100024        stg     %r1,16(%r11)
>>>              000003ffe0ee0446: e3b030080024        stg     %r11,8(%r3)
>>>              000003ffe0ee044c: ec180009007c        cgij    %r1,0,8,000003ffe0ee045e
>>>              000003ffe0ee0452: ec2b000100d9        aghik   %r2,%r11,1
>>>              000003ffe0ee0458: e32010000024        stg     %r2,0(%r1)
>>> Call Trace:
>>>    [<000003ffe0ee0440>] __rb_insert_augmented+0x60/0x210
>>>    [<000003ffe016d6c4>] dup_mmap+0x424/0x8c0
>>>    [<000003ffe016dc62>] copy_mm+0x102/0x1c0
>>>    [<000003ffe016e8ae>] copy_process+0x7ce/0x12b0
>>>    [<000003ffe016f458>] kernel_clone+0x68/0x380
>>>    [<000003ffe016f84a>] __do_sys_clone+0x5a/0x70
>>>    [<000003ffe016faa0>] __s390x_sys_clone+0x40/0x50
>>>    [<000003ffe011c9b6>] do_syscall.constprop.0+0x116/0x140
>>>    [<000003ffe0ef1d64>] __do_syscall+0xd4/0x1c0
>>>    [<000003ffe0efd044>] system_call+0x74/0x98
>>> Last Breaking-Event-Address:
>>>    [<000003ffe0ee058a>] __rb_insert_augmented+0x1aa/0x210
>>> Kernel panic - not syncing: Fatal exception: panic_on_oops


