Return-Path: <linux-kernel+bounces-558312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A229A5E435
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD38189E165
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403572580F3;
	Wed, 12 Mar 2025 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vnJaVwU4"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79B9255E37
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741806901; cv=fail; b=miaqVtfQkdjfWWQ7jYLk1R6gj77wBAOaLW8W4vHyHLzYAkmzGBgwfm4AhVqG3nMMf2tOJAq31VDD3VVU02mK0GcFj9mJSEKJl/D4HNi4LaXYmm14jbtOPT2eQBGLTipDTaRSyH//wpFwV6jnye6CfnWsKbFftjXcw3M3g6NtCac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741806901; c=relaxed/simple;
	bh=2mNwllz/DBraqw69erQk7t0vnRh8EBDzi5QQ8igi7RI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BLSjaFtPH/SOnoWxH832f6dOkK3CqXB4DEpQ+VLHfNvC6wCeEsKV2/pvZplvKxHuw8xNnTGTbQfL+K6lQFRQrrU8FO5Cmndo3bIQbIKEXejFPNdJb3y+DILAq3UkwqT+W5RLE3VfQ5dtSbLlzjdmVtYhcvNXq+5b3BHjE4kw024=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vnJaVwU4; arc=fail smtp.client-ip=40.107.96.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pe7gTQ/kaJnDqG86an7RE7pOZbnesyXG24e4R45nf07Y3eavaDBGz9bLdv87CWzjuvJ0dF+M19RSJKjG8Raju/VdHcp80ngQHOtaY6JRQJNdF3udxI/vJbtxubqqlBKvaSZ12FJiOIhEIU6JcaSqulSCJJAB/jhXuzlCc8mC0MFxZbwuRISAdAXPdN8iFBVLL+D2C/DnUGioTBvWPu6cx7zPEJhZN8YMLQzYxmk/P7B+Gg1UmCkT26yWZ9H33eCFSRU2h5e19TgFmjJN5mYDxwsXqjAsU3HMNlj0qvgfd3JBEWvKXDFY/ebvmuaA9faULXmcQOpajA86A1t85BXg5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K639+FtW5Rh1VT3/IM13MaxhalDLrYfojjJff+1lcNc=;
 b=oQSDXNp4iG8r3bg8dPRovZJmc1UdpH/V+an9HGc2XHIVmzCPwWsSH9+f2XmU3ai3y9b8/T3c1jP5nWp5HpA/SF/UxS25GJGbamthtpwYtcs1h91/9uHw7nUoZy4S4FDeBw3L8Leo8l7IzLgczRd38inzBO+KIcf6NJXiPRPugIzS3PmL+7JnwelLWMEYfSipm1wTI+9MyVrC/JNwhNTJUCGzzx7tww8Z77JV6Tt1kqf8a15kXq07sEoQiojKmgm2MA9b1/T2YgnQO2vnktbq/XifqYjqj3Zp3wPBT4/9NwgHFTzMAE9WOlkSqUuiHIY0GB84DPtMtijhFljP3md8VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K639+FtW5Rh1VT3/IM13MaxhalDLrYfojjJff+1lcNc=;
 b=vnJaVwU4Ig4kFF82Godob1gmuX7oGy33llEEna/aGonYevSpBz9yz0kEZqLN5wgNQ8Q1tKCCUyzWPLcYU2xgWv8fEZLRmAtARYUNjAHPv4jtCptVklfXQI/PBS0Gy2/OJev0dpb2+xxVxXrCR5KWIwNNNib5NOuFH2xcl8FRxUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 19:14:54 +0000
Received: from IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48]) by IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48%7]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 19:14:54 +0000
Message-ID: <db55a588-9720-498f-bf3c-0f21013241e0@amd.com>
Date: Wed, 12 Mar 2025 20:14:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: Fix memory accept before watermarks gets
 initialized
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 linux-mm@kvack.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, Farrah Chen <farrah.chen@intel.com>
References: <20250310082855.2587122-1-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20250310082855.2587122-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::19) To IA1PR12MB8189.namprd12.prod.outlook.com
 (2603:10b6:208:3f0::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8189:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c0d4c8-f329-435a-1e6e-08dd619a2b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTNKNUR1U1A1ODFydGxPc1BoK0pqZk83dy84Nk9VVldNV3ZNZkRSTk1BT24r?=
 =?utf-8?B?M0ViUGZsZWtQalZEckRScXFlZlA3MWJRSmtUOEZzWEVWWmF6N2xQUkV0VHN6?=
 =?utf-8?B?d1g3TVNvRUQyaEtUU3hGQUdkVWw2ZG5rZXVSaXZEMFNFYzhtbTB6Uk9pdzdC?=
 =?utf-8?B?Ujk5TUR2RkdzQmtLOS9SVDlPZGtIa0NEdDhqMEtrWGE2ZzhCMDdLY0lEcmtX?=
 =?utf-8?B?T0NQK2I0Z2kwUWRoUWJFcXo2SjVqSnM4eDlvSERDdEk3V0hQVjdqcUp6NTRG?=
 =?utf-8?B?eWgwZG1CQVVSWm80akF3OEIvcjhldGdZdFZHejVMa3JwdDZDV1ZSK0pvUkxQ?=
 =?utf-8?B?M1M2K3RKQmJWVEhJa254R3UvR2tkd2xEVXNqVVJobjFRSnZPSm94OVVvNmx3?=
 =?utf-8?B?OEx0UTI3aU9Bdmphb01PQm5QMDVmaFhIRHY2dHRlbWVwczdWczcxWlpWL0ZE?=
 =?utf-8?B?MVpIUUllSXk4bkZHdXNuNnFFQUtUTkdka3JDVU04UksyakxZYlJxV3VQRWVw?=
 =?utf-8?B?TjcybnphMy9ENDh3VUt1b0RoQVhwUDRHcGlCVDluR0xxdW0vWE91YTRxWVRP?=
 =?utf-8?B?OU9LUHptQnlMQ1lrT1FiOGJmSHpwNXdPMHh6Q0s3d3JXcmEweXJyQUkyWjB1?=
 =?utf-8?B?eXltcHZBVUVYLys1QXR4cXUwTUhHTGVyREpjbklJaWJ5R0RTY1k3OW9NcXho?=
 =?utf-8?B?THY0bnpCbjZaSEIyb255ZDZ0NHZUYklOMlVadXJMTFAvSndNd3JXdnhJMFAv?=
 =?utf-8?B?QTZsQ2NCVzJhT05LdzVKcVNCVWhxelZtRlFlZTE4NTJOWHZITGowVXVpcHBD?=
 =?utf-8?B?VjRqRzBpeWRaVmtFNGdsODNWVU50a3grcm14c216TTV1cSticE16VVIwRDFI?=
 =?utf-8?B?ZEVLWlh4RFd3UEJEMFVpS3VoNzBCWlQwNTV5RHFtTXo0Mm1mSU1kSWduSHVy?=
 =?utf-8?B?RFJmQUR0QlFNZ1JBT2dYcFAwbGFudHNKOEJ1K2psQzk0QTEwNVBHazk0UFlM?=
 =?utf-8?B?S2dLbjJzcGpsR0JmdnM2SkNLc0dPc1h0cjhYeWIwcTNaT3Awd0FGWVozd3dH?=
 =?utf-8?B?bmh5ekNmcUdxVklzWkZ2bnQ0cUxISitzMWdhTGdnSmhwTmRuZVpuQmcvdUV0?=
 =?utf-8?B?c1gxRzF6WUM2eVZqc2RWMml6WlpwZ25YMjI2dWx3VXQ0dkZSTGpweEx6OTQ2?=
 =?utf-8?B?eENVcVhUblVnZEN2Q0R3NWdNMjJaMFNyOHNlaUNPSVREVnc3N3J6VDdGUTNv?=
 =?utf-8?B?L3BjclZHbHJEaDR6cC9iWXRZMXlXSkRsek93S1hxNUdUY2JodWpvYWN3TEYy?=
 =?utf-8?B?YXNZNDlPWVJnVFJ3MXp4eTJFc3crdWRZS0xGSW9HZ1lXektpQXdDQWpiV09a?=
 =?utf-8?B?WFhlOEQxWXFYUFZweUhNYVRLNWtoS2xJbTA0YVdqYTA1QmJ3QTgycyt1QlJD?=
 =?utf-8?B?TktFellCb0liaWdsTnZveUVXVkNWWS9pYlRwb1JRUnpkeHFpdzJrU3RVUDg4?=
 =?utf-8?B?aVlrRWNFTTA2UHR3OUwyb1Z3M29ZS1JjSExodFRqbWdnZmhvcHVPQjN2VzZ5?=
 =?utf-8?B?TmloaW5EbDVCbmhIbHkvV2o1SnZpVXNEMHgwK05wSnYxdzF3YllxT2JGWDZC?=
 =?utf-8?B?T3BiQ0RjMUUyTDRSMkF4dHFwT0h2c2YralB6Zzl5WjBhY1ZmTlBiNll4UWdG?=
 =?utf-8?B?bUFJY0NiTU9mSEN2SERvRzdqazZ5bFVjYjczWnQ1UW84bHMwNmlZTzNNY05B?=
 =?utf-8?B?Q1FnS1RwZ3BlcHcxSjh6UitmcngvWDlBTkVWb2tib0hqcDNKS3NrSzBYNGEv?=
 =?utf-8?B?aklyQ1dNM0czblBXaHNvaGtvS2ROTnVVRTNwa0ZHQjNrVCs2b0xlMVJGYU16?=
 =?utf-8?Q?l9IR1mbVM3Tx4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WStDaUxWL0xadlEzUEpIOTFXNDA1UVl5RUhIbUpqdFc3dW96YUZKc25ydXor?=
 =?utf-8?B?c2VJSVBlUmNPcVA1bm1ENWxPeUJrcVNSMzI3Q1hVeE1IMUx3RnhjTjNXbDRB?=
 =?utf-8?B?Y1ZSdE9pL0s1Q2lwbTVUa2JIR2VyMS9UdlRxT09EYmtwczNrTFRqeVRHOGJY?=
 =?utf-8?B?TG12TlJZclZhd2hFbnBPdUl5cXdKSkRRdWtTNUttS3JEZzU1WXJXc0FhdzVB?=
 =?utf-8?B?bVV4cHdRbFFhdDVackY4VkgyakhKVndmWnNhbHFWd2JnUk53REIvWSttanBT?=
 =?utf-8?B?NlV6MnB3MXRqYnVNMWZhMVpOZDdjVG1QUU9PL0x2T0crRXAvSThaajU1VURC?=
 =?utf-8?B?RUtIUHBmUm1uanZnOHU2QldyZlJCb0FGWFZ4WUlsSDNnc25aUDlzbmF0c2tt?=
 =?utf-8?B?NXpZMHJrT0ZCQk11NWpZWms4QzFMd1JIdm5pNnVjTGc0aUFTMHVoZTRsL1hl?=
 =?utf-8?B?KzJLcEJHaUJ3MDFTdUhKN2Joc1ROMHh0NVhVRmNpemhSNEVCVVRrSkZPWWcz?=
 =?utf-8?B?L2RuSUFtZkhxUTFNRnFTdVdIV0FocHh4bHp0d1J5V2p4M1owNkU2cVZiYVU4?=
 =?utf-8?B?S1ErY3lwVlBmUENITnlUdGVDK1YzQU9vaWtwMFdWdUtJdXpuSWFxVWFMYlZ0?=
 =?utf-8?B?YUo3a0dQV1JCb0VNUVJER1R5SW1COXhRWHBhZVRzOHp6NVZWR0VhYVBibmdz?=
 =?utf-8?B?dkl0aXJPVHNkbDhPbW5tTW9sYW1EODF0b05HWGxjWm51d3AwZUdJSElZQ2Jp?=
 =?utf-8?B?R1JsQUtOdHUwT1g2cEt0a0xuNG5tc3hrTlE2TW8vMjV3VEJjTW1Sc0FqY0xz?=
 =?utf-8?B?Vk93bG5WUG0zSVlxUmcrRmFBK012aVhHWFpVU2xrSlA0eXlOQ3YvcmN1Z1pL?=
 =?utf-8?B?NkVMdzUvOGhoaGJTNjdDZ0RLeXdXdWhNOUlDRkp1VUFmUTM1SklpL3lVRlFv?=
 =?utf-8?B?SVgrYy9uRjBwcmhZdkV0ZXN5MFJzbkpTR2w2eTZnOFRaUlhDVDZTMmoyc2M3?=
 =?utf-8?B?MEN5Y3lpeCtRZ0dHU0xhNW05a213WlA2WEZZdnFxTGFWUzBSRU5iS2ZCK0Na?=
 =?utf-8?B?ZURnZzBYTHNlTG10d3BBSUVyTWFPekQ5czhoaHNXem9ZeG8zODFCbVpuSTRS?=
 =?utf-8?B?T2U3NlZnRmlRSHVMVSthQyt3SHVwT0xxaXNxREpsWWoyRm1JY2UySEhwNVFj?=
 =?utf-8?B?VHhCVmUvZEVSdGZiS0JYMXU3aGpNOHJZV3dvcHFFd2ppVmZXTnZpN2tWZFd5?=
 =?utf-8?B?YUtSbDV5ZnJjbTBqN0tKYVd6TUEwZ21sdnFIU084SjhVZHlzbk1Mcy94N21o?=
 =?utf-8?B?ZkVYejNoOXk1R1ZRQiszSktXdWdwT20yQ3ozZm9PZDlqYlFoK1lNVDFzZ0xo?=
 =?utf-8?B?NFFoOWMrTWdnNUJoSmZkVU5teW9VYWpreVVnZGZ4bnYzWHdDYmo5QzlFeTF5?=
 =?utf-8?B?V2FZbW1BdVc2T01iRTdobXRpeFoyWXBrVUVJRDZZQld5QUgwRlMvcGZ2cU9I?=
 =?utf-8?B?QnBFNVNyeWRhYkRUNjBjMEdITGZxYm1VcnNLdno5WitqUTBacXNCaUt1cXFl?=
 =?utf-8?B?MllnMlhiMXpLWUtKRUp3N1Rib2xGU1VxMndMZGprRTNvMGJRQkZNK3pWaXJO?=
 =?utf-8?B?ZW5nc2RUUDlDT0d3eC9ZYmRiN3hFTC9DUE4zSnVYUll2VGRqN2ZSeDdNTHBX?=
 =?utf-8?B?TFErV0N1enR1OVN0STliNlZNSTVLK0xUOXQ3UU5lL0RJdjNrR2QrdmRqNURC?=
 =?utf-8?B?aWRheGl6eTlQMTEvRjBWckFHRW1pZFc3c01ubTh3UGRFZjFQNU5WVWl2VGpS?=
 =?utf-8?B?SENwakc2cXNXUkJqUmFId0VtaHVHRW5ZZGJ1VFBFK1hyNytUTkpUNEJWem1a?=
 =?utf-8?B?QSs0d2NXeDhWTG9Mcml4QUE5MkF6TnhZcFVkVFY0NG9XMDd4MDJIUnBsL01y?=
 =?utf-8?B?MG9KMEo0Rkh5dHU2UU1XVlVCNkZyT0d1SFpUd25MaWNqenlka0o0a2JkQWIr?=
 =?utf-8?B?RmpJMzM5ekt6dDVrK0NRMGYyWU52cWJqbGVQN3JQTUxXMzhlZFRGL0VwaUN6?=
 =?utf-8?B?TDIxdWpnYlVOM2s0WUI0dTdnV25oUUxOOHhxaE91NGR6U1ZoTFV3UXV4VnFh?=
 =?utf-8?Q?6Fymbpzbhzy/QKvo4RDb6LPNH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c0d4c8-f329-435a-1e6e-08dd619a2b68
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 19:14:53.9802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOK8zcouPq7Z60E/KjuV3u2o293wwfGf8W8d3aIUjxpiy9na0pBDmWDDV1gPHU+yZ3yldXOqhJnvTF+QDGPLgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478


> Watermarks are initialized during the postcore initcall. Until then, all
> watermarks are set to zero. This causes cond_accept_memory() to
> incorrectly skip memory acceptance because a watermark of 0 is always
> met.
> 
> To ensure progress, accept one MAX_ORDER page if the watermark is zero.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-and-tested-by: Farrah Chen <farrah.chen@intel.com>

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

Also, did a basic boot test of SNP guest kernel 6.14-rc6 with the patch 
applied on top.

> ---
>   mm/page_alloc.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 579789600a3c..4fe93029bcb6 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7004,7 +7004,7 @@ static inline bool has_unaccepted_memory(void)
>   
>   static bool cond_accept_memory(struct zone *zone, unsigned int order)
>   {
> -	long to_accept;
> +	long to_accept, wmark;
>   	bool ret = false;
>   
>   	if (!has_unaccepted_memory())
> @@ -7013,8 +7013,18 @@ static bool cond_accept_memory(struct zone *zone, unsigned int order)
>   	if (list_empty(&zone->unaccepted_pages))
>   		return false;
>   
> +	wmark = promo_wmark_pages(zone);
> +
> +	/*
> +	 * Watermarks have not been initialized yet.
> +	 *
> +	 * Accepting one MAX_ORDER page to ensure progress.
> +	 */
> +	if (!wmark)
> +		return try_to_accept_memory_one(zone);
> +
>   	/* How much to accept to get to promo watermark? */
> -	to_accept = promo_wmark_pages(zone) -
> +	to_accept = wmark -
>   		    (zone_page_state(zone, NR_FREE_PAGES) -
>   		    __zone_watermark_unusable_free(zone, order, 0) -
>   		    zone_page_state(zone, NR_UNACCEPTED));


