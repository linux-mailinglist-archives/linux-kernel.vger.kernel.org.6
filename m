Return-Path: <linux-kernel+bounces-335957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637F797ED23
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242F0283015
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBA319DF43;
	Mon, 23 Sep 2024 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UpUQXHn7"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902FA2AD25;
	Mon, 23 Sep 2024 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101329; cv=fail; b=F/gB5NNPe1wr4p/sIO+iiwFxFE3cguBqeVHbN3rnQr4NJ1pxsCjFNunCYRkXwFp2M+haqMbLH+/DRRO1EaKfiJXILoaFS3r2ANTEXpUyRaaECaCoccKBwaJqJK+eqVX1HBEFtqf+ekSHYn7QKb5R3uO62Qzbjf7GSRfEp6g0bMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101329; c=relaxed/simple;
	bh=9drg+rj4Iu9ykaNtPQV6xLa5pi6+ai9X7JL1KCXeMio=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M0FNrrynvTGK0oJmq/bS79+XWRpNI63CVcJQ6x7nzU4E2MGl1M7L6RIgCbZXmV/mY/6qPW6aYg1Rh3k8IL6TdA4znxragPjuVjeNxBcJUriD0PuG++XqKZN5yEvaMvx9KnqULo5ZJZn0x2mLXe2sV+P/DzDyqmfGqx0Xi9hyQf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UpUQXHn7; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9BTh9eGn+9qVVsC2/RaJGu85FnYh6gVYWubjRh8XI/MoCks4VSVeJD2wAbUCgRmSOS04sq/+JjEVZpaf22Vk8i7il1FRo6LrP4jzvXgken6ie5q4R3w5RDPkzEANmmKVB9sSpmq9E08N2iPc1aFUthg+X75p7lh3nVUvPtxXQ0lpNQlkqVmNebOopeRacriMEg+c4LcvqQ/mSjJzH2Sb7uPrjQvw2T+/jfpTL4KkoHOFOCY1aPVX7L6ikg5gLcYufMIQa4PjDK5hDI022iMidUAFKxTCpFUGgmE7MRPorBOyMXgn6htiGuSybIacLAcplOVwtwY40DCOmRjUvwkoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOwGisqqMBJSEmslpnQoQQBMhh/nFH6XSl/ei1yY74M=;
 b=Ak++71vZEZ9uin9UgMISFdDdaL45Qhl1smT6R9lhfnNju2j5w87OEIdmku5nJK+v4We0wOXdDIbIDily15EETQZiSMZhIwVxKjrGTZMp4f5mSq18PmFr+nIiWMytNeAK8lSkTplB2cwEahVAOazSALkohuJHSLfaeJE2/6vqfvhyrIhC0knwgA+84MCl59v/FJfx44PCHv3gzxFloBd8hGcMjnJRdpohQPImU++vMKgujiU3B27qRAmRtu85CLWneRjQbkWwKroLF7U10j9Q2rw+neLrrrvKbpy/BIYN24JTra9F4NBuoSHpiv4dNZIbRLgpnsIN9rRmJAJmShaMcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOwGisqqMBJSEmslpnQoQQBMhh/nFH6XSl/ei1yY74M=;
 b=UpUQXHn7RrTzRQL7azbH1VnwWGVOOzFy5L6dsykFIdOOOMxS+bsmS+fdI0eAlMgjY5MrYB7WIJZ9DBO3mog5XLaGzSWU9KJJU+LpmILETsJ7Otkg+9xg6WjjVb9CMNdo7mnZELGm8CorOzmNU7m/tdEp0p4JtQRGsW2Y5vBPWeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB7761.namprd12.prod.outlook.com (2603:10b6:610:153::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 14:22:02 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 14:22:02 +0000
Message-ID: <a2daaa7b-f4b9-4cf2-9cba-2cadd6f09ab6@amd.com>
Date: Mon, 23 Sep 2024 09:21:57 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 02/24] x86/resctrl: Add ABMC feature in the command
 line options
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <a08d9391f48252410ab084ab90bd5f20b5d4a4f0.1725488488.git.babu.moger@amd.com>
 <da731387-dd85-4c01-bc0d-936559ebb783@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <da731387-dd85-4c01-bc0d-936559ebb783@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0178.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::33) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f67e0c8-0fab-4642-e315-08dcdbdb176a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0NOemluM0IzQjIzQnptODgyUURlSnZxWWhMcHV5RzVWK1Q5MFFXNUZDUm1Q?=
 =?utf-8?B?WXc2WVJrVWNVMVVoQm1FVWU4djRsVTFYUmNlc2JtL012bzhucEV3R3ZyaDNz?=
 =?utf-8?B?aDlvUEpSRGE5blJMWU1uUHVkRjVlbXlGMzh3anlvaHp1ZVF0dGdwSWlsbTFY?=
 =?utf-8?B?RnUvZVRRNk5oclUxaUtzbmhYZSsxYldWMHdxb3VySWNQZ1ZTSmRHNTN3ODBI?=
 =?utf-8?B?VDdYaFFpV0NMbVlYU2R5UzF1eTY4eHB4Ryt2WTc4SDdQZ0pwVlBFMFg3WmdX?=
 =?utf-8?B?V29tV3RLTU5ZRitCQStoUno4VUM4cjFDMnFBemZYc2oyQ0hxMFIxdWNCaWdo?=
 =?utf-8?B?WkRLR1M5d3JMNnZTZTRZZHN6ZWdXQzdOaFlkUXlrbDF5OHFwL3JzOWdtVWZy?=
 =?utf-8?B?V25MY2pONmVHeUdZMTZPaXhNd3N2dXpaWGw1bnBVMElmL0dyUEhXZE9Hd2VZ?=
 =?utf-8?B?eXhqQ3dZWDhyWHhDUE85bTdSbTJ5WmlJL0JpTmZ1MC9jWG1FUEJFV3VCdmQw?=
 =?utf-8?B?Uzc4a21YQXBTUHVJdUY5c0NYTWRuZjBzSHhiSUhJSVBDbHV1akJkbTR5SGdh?=
 =?utf-8?B?aEQxOGVheWxHZmVuM0crSDd6RVovQi9BK041K1hjVFR0ZkpTbFNMTi8wQVFD?=
 =?utf-8?B?U2ZERENoMXR0d2NldnVUNW85R2NUQlpRbi9WMitlaCtaWEhwWkl5UWw0THBB?=
 =?utf-8?B?bEpFZlRNdnhNTzJpRlhOYUhud0tPOVUvWkZhM3Z5b2NPRVhreElGZldNdFFw?=
 =?utf-8?B?TGNvWTFDbStxa3RRZ1JPd0FTTnIvRzVhRGRIdHFZd2V4Z0xxNHJxMDZYMkYz?=
 =?utf-8?B?dFVBeWpMVWk2TGlrQkwxeXdieVJ2YkFVWFpmcTA3Sk5xYzJYNnZmSGs5ZU1U?=
 =?utf-8?B?VHdlRTA2R0xocTNsdVlHL0sxNlhROEtoVnowZThHTmtjMUxlSzF5ZWRkekFM?=
 =?utf-8?B?OXpHWUIyRmJNamJETVVhZHY2VStJT3U4RUxwYURuOXAxT3NrekdtbFRHM3FW?=
 =?utf-8?B?ZjRMRzArQytDcGl3Mm0xQ0RlQXNPakY5bmtqQyt0ZlFjVTd2bXF2b0txNjhn?=
 =?utf-8?B?bmROWDdRcTVKTmtmMzE5N0RaemNmaGI3YVduSXU0aVJmekNJODlqMWtUVU5I?=
 =?utf-8?B?bVgvbHUzT2ZYOGVoYWxEZDE0YkZEOTl5aWxaRERTS3dMQXdFL0pkZSsvNXF6?=
 =?utf-8?B?c2xoc2pNTUxxUHQ5WEkxV2dVM0VjVVZhR01uK2ltRUR2QXcrRUVOcndWL2Iw?=
 =?utf-8?B?Qi9kNEJCSTdMTU5Ba0N4d1UxS0dPT0ZkaFFtWWwrY0QzTzdCaWw3MGM1Z3ZZ?=
 =?utf-8?B?RGtqZG91Qjl4UlFyYzR4M3IwaDhFd2lVcC9uekhkZHZhMzJsT3FrNXVWUXA5?=
 =?utf-8?B?TjllQUx0RHA3N1U2ZkdiR1lJM3pOTUs4UWNVRjNGSzFCVVhGSzVhVlQzeHYy?=
 =?utf-8?B?eGp3aGtVVERGc1ZiMlh2Tm01UkJEVHdZMW0zKzdZM3Q5ZGY3bEc3UWk1cXRO?=
 =?utf-8?B?emRlaERmSkQ3NUZSMGJxdE40ZTMwSnByczQ5T3FKVW1zR2tHS0puSkJMQWNC?=
 =?utf-8?B?d21ZUHpRVXBTTmdCaUFXWElaVzNVdnFuQ2FlSVlkYUgrUExaem1nN093MC9y?=
 =?utf-8?B?UlAyV3ovWWI2MFhFSWRPTkUvL1FDU3BsNGxuY3h5RDVvdVAyd1JjRUtPZDd6?=
 =?utf-8?B?c1M5MnBjTzhmMmc1U085Mm5WSUFDWC9CTkcrOFEzaHIxYU5mMVBKSXVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHptVTFLaDZZY2p0aVpHNjNSZWxibGJ6UE90Y3VDUms1bG5yZ3VBTjVPcERp?=
 =?utf-8?B?MHlUdzVHTVZEeXBFMTBRcEx4cVYyeDJ2RkVVZU9lSXhmd1UxU3MxcDIrVE9l?=
 =?utf-8?B?Z2hORU9COXBSOUxKTVVvejdpMUZ0djBZS21yQXJzYW1ZZGM0V3BUVmRkSTRl?=
 =?utf-8?B?Q1lCWjkrUkZRN2dvY050VE1ta1pXTUM1OHFSeHlJdXRVampOR2ErNFl5SUh1?=
 =?utf-8?B?WUNUaVVDTCt1Ylh4ZUNoNStPWWdLMXNTZ0Rsam91THpMVE5vQXZOQjFzTDF0?=
 =?utf-8?B?aDgvOS9SRVdFOHVWd2tkRDRET3BWNzNvRHh0WElKYWJSemNNblNlK1VGVXpm?=
 =?utf-8?B?b1lVb1pyVUZoZVpJQnRVL3dEWC9YRWRQamhSUUhLbEtJaDRTTXZmRWNMZkR2?=
 =?utf-8?B?WWQyMVlSc2hLOGpYWnJNSklzQUpzZ2dTOGNCVEErZzJMdlVrVVMwazFBdzRt?=
 =?utf-8?B?eFhtTklJZ2tKS2tyeGZaaGkvS1BZbHFWV0d5dlBWQmExMUZ3N0dpQVU2QVdv?=
 =?utf-8?B?MlcreWJyQktBK2Q0SmJyL2Q1SHhJQ3VKQnMrRlh5cnBiWDZxeVNaQWE3cmZw?=
 =?utf-8?B?dnErRjR4OXIrSlJZaVByZ1JpbXc2aVhGS0Y4QjBRalRNc1VDRS8wcU1xd2pr?=
 =?utf-8?B?UlFHelM3Zit4cUFtTGZidjJhbXpPVVJHalFVcjBxRUhTQW51ZXM5T1U2YXpE?=
 =?utf-8?B?R2NPYzE3Z082Y0ZXS1ArK2xNKzcrTjYvaElNUHg2U2YxRHVOa2NhUGNlb21q?=
 =?utf-8?B?UU10Q3ZqcFJaQ1VROTFrZ002TlU4WmlTbHJVS2xOSzkvaWpzaUMxYzBnUzJW?=
 =?utf-8?B?YmFYLzY3aHBzV2RxQVlsSDRPZ3hva05UZG5aSUVPTjBiSEtycHVxcE9UNFNa?=
 =?utf-8?B?dU9wQnNpL3duRWM3WUdiemxHU1piS0swZmE5dHJmc00wcm1EYmZ4Uk0xb045?=
 =?utf-8?B?eHF3QWQ0Q2FDS1VkbmVzNWg0bTFqRjFlUzZWc0N1SEZOTlNMZnQxaXNmU1J4?=
 =?utf-8?B?Y25icnVSa3d5NVZhWEtpRUVseHVlZ2pwRmdRMmg1bGpIdzU4ZEp1WFJ6NjlR?=
 =?utf-8?B?MjYrU3BCK3cyYVBPMVh5a1FyZVhKaldqbzFJeElqZzAySlh3b2JETytQRjBW?=
 =?utf-8?B?TERLUTZQd3I4bWtLQ0ZVWTFzOFNyQzRud3dOdHNvTStURUdPTTVUdHB0LzUv?=
 =?utf-8?B?MlBNRVY5a0dpb2FHN08xbWN5T2VEYmpxanlBMUJsMk1xU1dxMnYvTkNDcXFq?=
 =?utf-8?B?RjBOQ2VZZjNIVkxpeGZmNGo4N0RXY1JMbWJvUTdDVkQxaFhmNHdLbFFWK1FV?=
 =?utf-8?B?ZnRKNWFRekNCNSt4aHArZ0c0ZVo1cXNkRS9WcTZWQm9YajRTWFdXQ2VGcGVM?=
 =?utf-8?B?eHROVVFaRjc4aEhGenlPbVRneFowZW5mV0J1dzFrMGRubm5hbk1SUEhGSjda?=
 =?utf-8?B?K2Vsdnh5OFB4SE5nZmZYdjFvTVlkRmVNWDJJVWhDZFdWTEJtSE5NT1NFYmJ3?=
 =?utf-8?B?SXRtUjE1blZ0TGdkK1NDQW56VnhGQ25HaHZ4bFczUm5uMmtLaHZOTkkvVDE5?=
 =?utf-8?B?Z2VFMXVOMm9yVVRCdlFpTUp1UUxOM2MrYzgwdTkvK0tZaVYwa09TSDByRUpN?=
 =?utf-8?B?ZjQ4ckRMNnl1TitMVHcwMzIxMi9sSlBGdTBidzRLYmc5NzIyaUxiZnlRTGhG?=
 =?utf-8?B?Wi9Za0F4cm10dytyT1hibE9US1JXRVlCcEgvVm9tWEM0TUU0Y2Zid1MvVEpY?=
 =?utf-8?B?Y1hnUThrQkQ3UHNRa2x5cndqZ0xMTmgvdTFDSy9VRi93ZUdydTBHV0dUMXgw?=
 =?utf-8?B?VUpncU1sTWdEcEJndlBCZDQySUdZN1dZbEpPanNZNlBNaDhlRjh0ckcrRVVS?=
 =?utf-8?B?Z1dOVVlQcmxSdjNRUTBKRGJwdmdZak1XWTdNOHQvbVlzNDUycTRDY0U2ZjRm?=
 =?utf-8?B?Qnp2L2oveDJ3WWhDZEFualc2S0dzc2kzMVV3NFpsbzU1SlNMdmZFR0R3Rk9P?=
 =?utf-8?B?endEZTJFWTZFenpZT3BiN3owanBYdUMzaFErTDNwaTdOV0Q5OWFKQU1QN1dS?=
 =?utf-8?B?RE5wbWE2QXcvaWlVaGhuMy9CSTJXdlk4SnlHVDR3TXJ2Q0NyMzRHSXl2bDNy?=
 =?utf-8?Q?gBqE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f67e0c8-0fab-4642-e315-08dcdbdb176a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 14:22:01.9920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdVmPQG77Dse/qQgDk+k963yYttQu6a9KqZDXyhplTjUVSEU2KYpS5N2iANfRPDB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7761

Hi Reinette,

On 9/19/24 11:00, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/4/24 3:21 PM, Babu Moger wrote:
>> Add the command line option to enable or disable the new resctrl feature
>> ABMC (Assignable Bandwidth Monitoring Counters).
> 
> This does not reflect the fs and arch separation that this version highlights
> since ABMC is not a resctrl feature.
> 
> This can get confusing and I think this interface is indeed for the
> architecture where hardware features are enabled/disabled (highlighted
> by how the parameter is connected to the X86_FEATURE_ flag) ... so
> perhaps something like:
> 
> 	Add the command line option to enable or disable exposing
> 	the ABMC (Assignable Bandwidth Monitoring Counters) hardware
> 	feature to resctrl.

Sure.

> 
> Patch looks good to me.

-- 
Thanks
Babu Moger

