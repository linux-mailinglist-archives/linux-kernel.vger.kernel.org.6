Return-Path: <linux-kernel+bounces-254542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7661A933486
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 01:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D57528419D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ED9143C6A;
	Tue, 16 Jul 2024 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3a2fiFqx"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1363A249F5;
	Tue, 16 Jul 2024 23:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721172235; cv=fail; b=NchTc/9Ppje3wNofiz6N5bDgoP0w4RtmixnX34+fqw38zcJFJWJ3QP0Fk4z/bO5ZSoNyO7aVdBpRdC32lujQd1j8z2bKU/mny70WNOf67p/oLRoywhQMjAULU99XUhgAC6fDvxi4LRFlWajFS0w5c/Ly1XEtR6bDhEocEvh6Xh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721172235; c=relaxed/simple;
	bh=vaQRgV0L8Y0b6taowvLOviN/N6XnwBCsSLmgvvEaiG8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gzM1kNvP8W5KCJVR47QcxTet5YPu0rYXEp31APfuB/qG2KmIwRAPuN4AaaC4B3Cdh5HWV970Na1FQj+6WdjqSO/drAKOpEwnj3OaDuVfX9bQbqyFLEVU677XbZDtMVjUfWDW1wcTepi4056KtxOzVKulpjhnkLzVD3h1oBEKASk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3a2fiFqx; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SccIquuUtBqNW+fetcjfMK2xV1GbHwGVCv9wdRFqtzoqfudvV81PW/vcf7WY98qNWnVMXyVL2coqi33rg6uHq81Vv6u58sPnc3TS1EBdFdqzgdOYiIVBEWHFbihxJ8HKQTcSleIWFyqSHsd/37GYxshqgPh2wUTqHfXHr6TJqOMCbTvIM7CaQK15935Y/4dStCjVIHfaEPHIeCWycG/pl5VEPEdxwar4mR+SfbuQk50+BxGrPZikFZ5idHw0TIvtZO8yN7UkXxc1TCG8786zrwccBmhmY8Lm0s/+AWcEmSaQjxf0E56ZVpaebp9L5Wd6Q2KyUGCctH9Sv6avVv/lYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rW+RRw9hlmekbkiylIPVMoiU8VieuViVnvcYuW58hs=;
 b=CU/JGcBX3JBdqBXzxKpTfJzt4lVP192tnGD+OkGYgeI2iPjkFjc/C6aIv9k9yuVCGFv7FFJhY28xhGyD635DCrX8zw8xrEKq15XGXvPFF5IddTb6H0/JOEMgjOoHCEmr2/qxRnsmDnYjsSadEjoIQfjl9Ool89FEWIyZUZYzJbi2cQMcZwLvTew8Avf02e7F7pSSYvMGeS/6QoVh+U5IFVH/6O9XkZyURwe0HIt2QQfSPjlx0cloeSIwuIGqxlQKZWgTFRxai37p4IsL3vxTRId2xxtWEaU1jTePZKRo7u8LfWWF+mR5onf9PMVDY+T7o+WdSZI5pCHnNdVKXOqelw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rW+RRw9hlmekbkiylIPVMoiU8VieuViVnvcYuW58hs=;
 b=3a2fiFqxqsj0vsTh6kwejaPrrT3iVUXkMiCokmFxTR5TCaADTB/e6qEeQcU9gfykQgZD5wU1Y5z4Gb1JD7hgxixv/YE5g/WEC5ER4I02CZpIazbuJAysQuC8pZYnnvl5p0z2TNfWDIqMdI4FW5ep1Z/JcMx5nbl86IVMQItFIzk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 23:23:50 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f%7]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 23:23:50 +0000
Message-ID: <eb7f2b83-8d2a-753e-b7ab-9b004af2592d@amd.com>
Date: Tue, 16 Jul 2024 18:23:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 18/20] x86/resctrl: Enable AMD ABMC feature by default
 when supported
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1720043311.git.babu.moger@amd.com>
 <9f03d5661a4f054124cc7ae1903207714c5188ee.1720043311.git.babu.moger@amd.com>
 <d9de1a56-8b0c-484e-bf44-69891a2e9894@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <d9de1a56-8b0c-484e-bf44-69891a2e9894@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0086.namprd11.prod.outlook.com
 (2603:10b6:806:d2::31) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: d7799235-d52f-40a9-9051-08dca5ee592f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0hKTXpmM1I5SXdJd2Q1ZkZMUlVyMi9ZWFRERG02TEIwdkZHU0ZjaGNIWnQx?=
 =?utf-8?B?UUVqZmNwR0tEanJnTWdsTkVreUpQK3dyK2I4TUlHVTRwR3dYQk94ODdmVi9x?=
 =?utf-8?B?SG1GOVNWRXpmd3VSYTJwM1VRY0VuVzhlaGs5UGx2dE9vRTM3NDQ5Smg5Z2li?=
 =?utf-8?B?ZWt0STFGWFpFWkU1QXM5UWloQThoc1doY3FwVE5SUEk5NDRnZGN2MUlpSlFV?=
 =?utf-8?B?cnUzL2FjN3RtZFBTVjRPYVk1bHpacFltdm5GcmZ0bG9nMkl2VktraG5vRWps?=
 =?utf-8?B?TmFXMkViV1pOTnRTTVVTOGJHRDhCRnU4VjJYU0N3Ykk4dys3OERZQVVqYWVn?=
 =?utf-8?B?RnNlMHgwTTBnWHJvU1ZxODE0SFVXS1pRaXdhTnRrcVZBNHBDcktpb1FsOTZG?=
 =?utf-8?B?SkNEcS83akxNYWN6MGc4UHh3OHljajNMbXI0UDdoREdwMXdxeXM4UkZlOWxU?=
 =?utf-8?B?WXF1bnNoQnNYYjJVRlV6SkFNZmJxYTU2ai9SNldFdTdLMHY0R1NBTjMvUStN?=
 =?utf-8?B?Zm9VYi9HR3N5RWtGUGNkUHBoR1dwV1hVSmt4TElobmNvVkl1RGtLc1BCcXhQ?=
 =?utf-8?B?ZTNzd3FhWllNZVBVZXJUVmpTdjFrNU11V3JSRlVXb1VNb3U5ekZ1ZFY2VUxz?=
 =?utf-8?B?SHovdnpOWE1qdG9mREJZc1ZIRjJjYU93d0hxc0N6alFyZVRzbmg1ZVd1cnB4?=
 =?utf-8?B?QU9uMVBjNlZzbGFUVFpwc0FrTDNLaTJNK2FYYXRYKzdobWF2TmFDOFFlOEEv?=
 =?utf-8?B?MUM1M3dsSEFSWEdVWE5kQldyTzFIcTNDWndnbWg5a3RNVVlkcUZDV1dONnB0?=
 =?utf-8?B?aVZ3SEZLc3lWay9NeG5jeTI2eElKZ05MNDFpbmliOTQ4aXhYelhLd2pNSWdL?=
 =?utf-8?B?bmEvb1lXb0ZFNElPRkVWZEgwZ0NyK1ZVWXkwS3RabnhmZ2pzWDc4bkswdU03?=
 =?utf-8?B?VVVmaTZxMEJBUmw0WGZ6ejZFWmk5NXpBaXNTcytNY2tiQ0d3ekoxeGtJdity?=
 =?utf-8?B?bm92N1BSZGIwOE5WNTh2SmxPSGtNV1Q1cytQQVVNb3dKV1JBbkJkdE1ROExG?=
 =?utf-8?B?d3pqeUJ2ajBST1dWV2RqK3Nza1kwaEJJRmVla3NDNHZiVGVKZk9WRGJoOU1N?=
 =?utf-8?B?SmRBRnp4SEZmWGtnTGp5NUZyOHE3clQ0OW1KeFBqVWxXdmRiMWw5T2JDZDdh?=
 =?utf-8?B?OTF2RkxpL3NzOUtVMlJ1WkxJNVFqc0ZRNDFZWmlMazhxK3luaU53YnF3YXBv?=
 =?utf-8?B?TTArVWE2ZWRYK2M5Lzc4MTNzcklQakhNcVgranUzMGFuNklrVStSV1hBTWhW?=
 =?utf-8?B?Q3RJckcrNjlMQ2NUNFVqbkFLVTZTZHRXWjdEMGVYTTRtNnhUM1BpeDlOU1RV?=
 =?utf-8?B?Y3RnMFpaTzZlRUZJSzQrNHYrSVEvVDA3bi9ZWVd0VGYxVm10MmZLM2NxYlIr?=
 =?utf-8?B?VWhWazVLU2hVMmFXODZsQVdHbFVnR3RrVVRSeS9pTlp3UVk1MnhVR2ZFc1R2?=
 =?utf-8?B?R0E3Z3Bzc21zcGdna3dLSTJiWjZNZmMrdGJXN2dNVGgzdkxUNjJDdjZKVXZa?=
 =?utf-8?B?czFaT0pZc2V6T04yTXJMa1R2TjJHSUtSamdzRktWem5yY04rUEhTN2JtK1dG?=
 =?utf-8?B?VGdhSnRad2VseGxDL25zb0pyODA1Mk02UHZqdlo2cTFON1Z6eTMyQ1JGVGtY?=
 =?utf-8?B?V3ovd2tDMUdIQmRGcjhac0owaVZ6NUkrbUNCSGxiaGNFa2RZa3A2R3Q0R1hl?=
 =?utf-8?B?Y0w2RnpxYk9iMmxQNGJoMVFLUFRxM3VDN215aXFjalNzSnpaWFNEbUIrcHFE?=
 =?utf-8?B?Y0FWWWU5VjlLNEVON1lUUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkpPbFVZQlFFUUZoTGJ3UXY4WXhXTTJGR0REbWpadzZqVGdOd2VYYTl4algw?=
 =?utf-8?B?L05DZkxjY3hFd0V1SXd6VUFYWEt2U2kvUXJ6eDM1YTNRUE5tQUJId0pZOFRV?=
 =?utf-8?B?cnNmSkFOKzYxeWszQkpMeDNEaXdwbXZwRWl6eHd1WVFNcUdQYnB6bHk0Vllm?=
 =?utf-8?B?SnR0N3JJT3NzbDM3UEU3Y0UvdE55TUhmZUMrZU1hajdtalBhellhRzFJbVlB?=
 =?utf-8?B?cVMxSHBXWXFzallUeFJ4enVTeG9LUHh1ajhDL01QeXdiT3lDVzZ0UUNpRXFU?=
 =?utf-8?B?d01pU3lGempQQm1rNGVDb3lxVnFJc29GRUxkM1ZxZWt4THpMNGFaWVFLbTEw?=
 =?utf-8?B?Wi9OOXhXTmdBRUQ0cFVxY3BqdEp2WEQ2Qk1uV0JjdTY5cDdJbVoyL2NXMkZh?=
 =?utf-8?B?WTkvMUJGcUZ4SGgvcit5WkVwQU9CNzNuODk1dzBHWC9qUlBhNSt6NkdSd3Zs?=
 =?utf-8?B?bmg2dVBzOWpKWDBBdkJPcmw1VERad2tERitPRXN5VVJRdVpvOGd0ak43ZS9F?=
 =?utf-8?B?OUsyeU5XNzRFbTZoMHdXekUxSlEwQzlkL3NTOWhPNDZyaDNNYVEzcmJrOVUr?=
 =?utf-8?B?L1JiNktrbzFKUXdRbWw3ell3Q1M1anpSc1RockpGWnl5djBpVXpQT0U1dXE5?=
 =?utf-8?B?dk9rWlZjWkhMQ0NaRExYZXhHNDJER1BzSEwxUFBZelB0R1FSS0tobnBzMmFG?=
 =?utf-8?B?M1FlSmV4cnlGZktMYjcwOFNuVm8xTVFQSUJQRGRzUVc1eWlJMll6bFRGOC8y?=
 =?utf-8?B?MGNrYXJwbmlsdWhTR3l6bU1XNW9yTlQ4K2ZFdktYRlAwSEVpTHRsSVBXcGgz?=
 =?utf-8?B?VXRsaEdWKzd5SlNlbWhyNU5lS1JJMjJFR2szTU10YndDam81NHlyNXprTGNk?=
 =?utf-8?B?TnFDRGtFclhhL1pHQmJ3c0JOZXlvS3dISGNtVmNEazlBTnIxWTRKdzVZUTk1?=
 =?utf-8?B?OFV2SmRnT3FobitFVURkMVhkblFrQVpMaVQ1T1BBdFVJbXZDS0JWRDRCQjky?=
 =?utf-8?B?QjlVaC9hdGk1V0YwblVvaWtDSUgvajhKNFBhWjY0ZVhoNytjRk8zMmkxZE11?=
 =?utf-8?B?Q1daTlV0Z2RRWitsb0huT3BwRTA2T0JaL3NhaCs2ejl5ditIMWkramZqOGF2?=
 =?utf-8?B?dWt3NTZqeDYwakE2cDVBSVA3OUhaNTUxcFczUlErODc2aVZrdlBpMVNOQXV1?=
 =?utf-8?B?SCtNaGJUVzlWK2pBRkZvUEh1UGxxdlNuNHZtc0VkTWNhL1pGSU1JMXBreXVw?=
 =?utf-8?B?ejdVeE5pWkozcGlNVHJjZ3BRMUF1WWJzMU1CdmhBTUZURUxsRVR0bU1uME1I?=
 =?utf-8?B?dTRROTZ2TkdLaFZia2pXRkxFQXdKaEJLcE9wTVpvN2N5SUNENGl0emhHSmwr?=
 =?utf-8?B?RnhkcTBGRXNac3NsUlVWeUVJYk9ETmIxOFdVNXVOTXFaK1EvRHdtcXo0N1R2?=
 =?utf-8?B?bTVRZndRckpZaFlUVkRDOWtueFlFOVhabktJOTNaRXFWaUFSNnc4RDN4UHlF?=
 =?utf-8?B?V2FPZHhwZTFyS015cjh1VmwvM1A5aTZmYTZEM0RGNzdXcUJmVk1ha0tSU0hp?=
 =?utf-8?B?dEViOUhjSFgvc1VTOVZUQ0RzUHB1YzJSQkU1S1l6a2k2Q2pCWjNidHFQUXhr?=
 =?utf-8?B?YjJFd0R3V1JZdnFUOUdBeXdXSzBKd3lwN0dYK2FUVDlPMFBBNThaamFobHha?=
 =?utf-8?B?K3hYNDl4dEVwRlYwYmRwYmVILzBIam1jVUNmSzdaV1BzdWI0aGwwUGY5Q21l?=
 =?utf-8?B?dTkrSG4vZnRsc2FCZXpUaTVGQlFzbVIvb2x4Q3lqaWZBUzBnakUzTFo2cmpH?=
 =?utf-8?B?Q1BVTmRuYmRJV0UzYmJwYkg1a2VQb0ZmMGhhTExlMzY3a1diZUExS21MY1ZG?=
 =?utf-8?B?NE9pUHkxS2s2MVVjMEFkVTlpTHBNc2VOZ0pFVW1EYTBZVnhQWFlBZCtJZ09n?=
 =?utf-8?B?UVJtVjhsaGZDUmM2ekptZld4L2l3dUZqRmhLc0kvV2crSkNtYkQyZkN3NlNk?=
 =?utf-8?B?ckt5Y1RzbVU3R2tnZFZIWGRodW1TUmE0WFBhNzErUUIxRzIvb3pGQkhKUVFK?=
 =?utf-8?B?cFdpUWxpY0o3VHBTZXFpY1NRTGNZbERETHhHemN3N2JEa04zWUdtbzROUmU3?=
 =?utf-8?Q?iYCl5TG9pBImqlZ487DkN7Ljw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7799235-d52f-40a9-9051-08dca5ee592f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 23:23:50.0553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICtl7XVwpbogQEP2l0ypp8jlMsjbZF1Npdfw03Xo7VwQ+4S4UjcYN1QCPXYbVE+3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656

Hi Reinette,

On 7/12/2024 5:15 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/3/24 2:48 PM, Babu Moger wrote:
>> Enable ABMC by default when supported during the boot up.
>>
>> Users will not see any difference in the behavior when resctrl is
>> mounted. With automatic assignment everything will work as running
>> in the legacy monitor mode.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v5: New patch to enable ABMC by default.
>> ---
>>   arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
>>   arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 +++++++++++++++++
>>   3 files changed, 20 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c 
>> b/arch/x86/kernel/cpu/resctrl/core.c
>> index 6265ef8b610f..b69b2650bde3 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -599,6 +599,7 @@ static void domain_add_cpu_mon(int cpu, struct 
>> rdt_resource *r)
>>           d = container_of(hdr, struct rdt_mon_domain, hdr);
>>           cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
>> +        resctrl_arch_configure_abmc();
>>           return;
>>       }
>> @@ -620,6 +621,7 @@ static void domain_add_cpu_mon(int cpu, struct 
>> rdt_resource *r)
>>       arch_mon_domain_online(r, d);
>>       resctrl_arch_mbm_evt_config(hw_dom);
>> +    resctrl_arch_configure_abmc();
>>       if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
>>           mon_domain_free(hw_dom);
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h 
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index beb005775fe4..0f858cff8ab1 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -707,6 +707,7 @@ void rdt_domain_reconfigure_cdp(struct 
>> rdt_resource *r);
>>   void __init resctrl_file_fflags_init(const char *config,
>>                        unsigned long fflags);
>>   void resctrl_arch_mbm_evt_config(struct rdt_hw_mon_domain *hw_dom);
>> +void resctrl_arch_configure_abmc(void);
>>   unsigned int mon_event_config_index_get(u32 evtid);
>>   int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, u32 evtid, 
>> u32 rmid,
>>                    u32 cntr_id, u32 closid, bool enable);
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c 
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 531233779f8d..d978668c8865 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2733,6 +2733,23 @@ void resctrl_arch_abmc_disable(void)
>>       }
>>   }
>> +void resctrl_arch_configure_abmc(void)
>> +{
>> +    struct rdt_resource *r = 
>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +    struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>> +    bool enable = true;
>> +
>> +    mutex_lock(&rdtgroup_mutex);
>> +
>> +    if (r->mon.abmc_capable) {
>> +        if (!hw_res->abmc_enabled)
>> +            hw_res->abmc_enabled = true;
>> +        resctrl_abmc_set_one_amd(&enable);
>> +    }
> 
> This does not look right. It is not architecture code that needs to
> decide if this feature is enabled or not, right? The feature is enabled
> via fs (for example when user writes to mbm_mode). If the default is
> enabled then it should be set by fs. resctrl_arch_configure_abmc()
> then checks if feature is capable and enabled before it configures
> it on the CPU.

That is correct. But this is a default setting should be done during the 
initialization. This is like rdtgroup_setup_default(). I can move this 
inside rdtgroup_init(void). I will have to change few things make sure 
arch and fs code separate (like accessing abmc_enabled).
Thanks
- Babu Moger

