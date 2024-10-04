Return-Path: <linux-kernel+bounces-350585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6251499070C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2562B28C7B5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588591AA7A5;
	Fri,  4 Oct 2024 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jq6BRkbQ"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B01148316;
	Fri,  4 Oct 2024 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054188; cv=fail; b=tTzeHY7sUZ4KQ5WwDors85Ny+QeHwsHHutRtIDuGNdEpVrU1TlWmlFzI4Py583PougTDEWqtWfTuZPIJnH76l+kP+zqAPCXivQ/XTkLYaERnvcZSgKAkz2ZU8BIwSu66HiL1UIeI/6242RvYJ7JLpmy7qWcg9NoZftRtIcOIaZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054188; c=relaxed/simple;
	bh=9I4+vFHTb7kdKYH7dtVPJW3IOxhFO13MH4wMbR6Q8FA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QXw74J3YEnLKrVB7FpQ3Sjc6Wn9ACUCRrGX0qbR2VoKVE5Ak8a6hUvkKkV/lpdu7EMChFveit+ycERIG+KdA4/VLRoYp84HggQiJ8OaeoqkLZdAKEONDgkeBkYS8fzrYfEbrQTyCT2zvqMlRrdNAKtw3yAgzRCtts+VxSZZN/E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jq6BRkbQ; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quZbX7x4M4Q5xY9HGSZiqVyNpEVhZK6/vkUvZv2dfoAH5YoybwUVpiFuoVueTe3Kpmz38EudNDajSJ0dijrjNmk2a9OYXQfMJIc1n83gUqJ97n7yxn82o+ADSKL81RXUsQSc7u9yfxn4abeZLYKK3LG/ruTfd8DzFlbe4PJa7sh358194IUFxYy+slvMw8A8tZI0YRiTvJwOWqrrfqZrYHJNAMpJiHVrX8nv/Ow5osulTE2sEtpUVEuDd8aIqTFIZOTJiSMh/IG4y1KSSZuGP48FkpnD8ZkQg//5zAxROtigMSQmsvLYddWW+E4qUO3BOJhRdoAqzu3461T1Q+/AVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1axE5ZKuzCnqeh76mWI4H7XhsSeb1I+AAfGGwvSTt0=;
 b=e9eLxm3U9DWCGFUqq1EZtYgMjobGcE/lx03eFlHg6IavOkCWTBaqcSKARAaRJOOwL2IKlIfNVVeTCQSRDaRVEs2bw2MoXLVnuZCFFzEpfsyKMvvu8ofF6edeISp94PGH5jqvuDEM+/aTfPxtXPRAL+uNZusQbkKcrMc4oSdvvu8Slyen+r2bU3lVJwk+uCE/Fq4b0Y2FpxWJGyskgfKeLGeHGBOKQRXSHkPJPYgVSFz6x7OsvisJx/aLxgWQJwJtwSI7dy6+uLActmnizK3Fo8cUth7XLIyYmkMhWUyijJgqOQFfvWLXlkIZF0H4FHJpMj65Dma9tdyy5lBcSs6H3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1axE5ZKuzCnqeh76mWI4H7XhsSeb1I+AAfGGwvSTt0=;
 b=jq6BRkbQat+kXhSQOdGP1dgmJSOtB4LPUFR/iD+iACxhngON//kvm96VtJwkXktG54Opnubtd0O1AoMqQwMCxSwd2k6V6vCRqv/LIFmHvbisGXlpLVxLnx8KvKVdWKT/ESQdm+viaR7sk7BpN4W+C67CgoZCUgAu5PDjPUNXhcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB9195.namprd12.prod.outlook.com (2603:10b6:610:1a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 15:03:03 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 15:03:03 +0000
Message-ID: <9621def4-2753-0f50-ceb6-3185c1789fec@amd.com>
Date: Fri, 4 Oct 2024 10:02:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 22/24] x86/resctrl: Update assignments on event
 configuration changes
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
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
 <ff0cd2a73c78fdb7487632381b4aec642a0af5ef.1725488488.git.babu.moger@amd.com>
 <384c2074-0076-4686-bebd-ba3ac3c05188@intel.com>
 <f77737ac-d3f6-3e4b-3565-564f79c86ca8@amd.com>
 <d2147cb6-9d1a-49af-9be8-5d788ce7ee7b@intel.com>
 <c514416e-4320-3826-21dd-7e79ebc83351@amd.com>
 <33c56f32-4e56-47b5-890c-fbf1d45d7213@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <33c56f32-4e56-47b5-890c-fbf1d45d7213@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0038.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::19) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e177e7-c896-4937-7323-08dce485a54d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0J5cXV2YXA1c2c0enNXbzRIYVp1UHQ0dGNXc1ZGOC9RYi9TUXRtNDdTRXB5?=
 =?utf-8?B?aDU3TlZGVE5yMnNwT05KRTR6RWlsY3puUFFWQlJaR1IwSitzZDIwUDlHV1py?=
 =?utf-8?B?NmJ1MDJCZjlmTUhaODdqcG13ZmowNWRSeXNqVHkweUVlanFpci9RcGJCSERn?=
 =?utf-8?B?U0NianJ5Y2dBd1FrMmtnekFwcGdLbndFTEFpRTlOY1NCMUkvMWR3M28wUmI4?=
 =?utf-8?B?RE5oYkRVWEtSMk11U09rZE53ZEpldW45N20vczFwZ05SZ0IyY3UyMUlrODRv?=
 =?utf-8?B?dW53am1saHc0alU2TmpzVGkwTFdlcHNaT3F4YWMvWkIveDZwald2cEkwU2N0?=
 =?utf-8?B?V21ETkl5amhRcEc5dkNub1VPRk0zQUxhUmlxaDg0VEZWUUFNQS83SmVyaFJk?=
 =?utf-8?B?a0JlQnFYL2NwMFRXMksxaWZBWCttSFJSbTRQd092V2JMcXI5S3V6S3ZIaEtk?=
 =?utf-8?B?MklhbG5lMmVNbkJhTkI2MEMvQTRLN3dRaVI2KzFadDg2U0ZvVnlrYmpORldY?=
 =?utf-8?B?d3dnQ0FTaVlFQ3Izd1lwb0VzRjVSODBFVWNNMHY1VTNxUXduWUxWMmZCdjFz?=
 =?utf-8?B?ZnpsN3FMY01xN1ZON1JwbXBaeDgyNnNlT2JpVTYvaTJibmMxeFgrc3Mwanoz?=
 =?utf-8?B?dGppNkdONDNYOUwvMkRIZFlBYm9MQ3g2SExUQ1VWTXV5ak1jdW5ybndCQjVk?=
 =?utf-8?B?TjRBK2dIOHUyWEx3SGNydjljY292bVlaQjBQdk0ycGNjS2liY3ZPUlNjOTl3?=
 =?utf-8?B?dFNleVhkOCtBWmxzVStKcUU0UFQweVlGOTRzdkRhMWVwdjV2RUliRTdMdkQ1?=
 =?utf-8?B?OHIwcWJhcEw1VjZZTXBSODlNQmlicm8xOFBucXdMZVA5QVpCckx3T2hDY050?=
 =?utf-8?B?UEpKQnZoM3BGeE9hV3YxR0s2eXZadmdlTFFzUm5HWGd6Y1pvMlpSYUFhcGVo?=
 =?utf-8?B?NUhmUXdUeTV6cHc3Uk1mNTA1UG8vc3RIVkgzZU9Db1FSd3kxdDNMQ0NlNW1K?=
 =?utf-8?B?WCtzZkZMemNtNndDdG9lSzFNUGRIUFZjMUpjbGdpNkpvK2wzekxDeFR3bXIw?=
 =?utf-8?B?emdWdHl0NzFYSjdOMENJdFpsTnpYcUp0VXRTcEh2UFRLTlJiSTQxNkd2RGUv?=
 =?utf-8?B?QUN0QWgvNy90VkVvdzBpajJoSmNNampFcm9teDRISjRJcUl2VWl0RnpSOTZo?=
 =?utf-8?B?SDVnNWo0cDhleWhPRlZXcFN0SnIvNEZvNjF3OFBybzA3d0plQ2lCMWNhYTdt?=
 =?utf-8?B?TXg4dEF6MHVWZGFONW5JbG1SQ0ZRWUZ2VHB1K3dGekZoSS9hNmdpdUlod0dL?=
 =?utf-8?B?T2taZnZhU1B2bklYblN2cXNaU3krVlc5Z0o5TSt1eHp3Tys0T0dkeTVIZHBK?=
 =?utf-8?B?dG1VcDB0d3FxMFd2ekpUMEVaeTUreEM4d255MzlTWm9UVFhhUlVPb2Iza2M5?=
 =?utf-8?B?UmFpZVFiWTMvK01QdXRuMGpEMHZoaW9pb2YzOWY2dVdQQVd1ME15amdiNm9R?=
 =?utf-8?B?dlZFbWxyQjZOY1hOQktVYWg4cWZ3L3NZY1E2UlJLQXNvdkROZW95aU40N0Jr?=
 =?utf-8?B?ZW83cS9ROFBMY1BneDhocjlzc0d2YVJ3SVNjUWRGZTg0d2lHcnFNTTl6MzNS?=
 =?utf-8?B?WlB1WDRzclhSL2lYVi9pdTVCZnh0bERpT29YdysycFlzVlo5U2JrOU02ejV6?=
 =?utf-8?B?c3cycXJEMjN3eDZneTVJR3krU1ZLWWF1STJPUEhQQ0FZcWpSYXI2UWRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjZTc25CaXloaE0wZ0VXTERPMk5tTUdvbGo3MVczamkrTnd4QzVSdERhb2Rl?=
 =?utf-8?B?T0ZSRmxQSU1qZE94dHdjaHREQy9SVERVd0pKdDhlVUNsczlTd285cU45WmRz?=
 =?utf-8?B?WDdUUDVBcnJsdzRoWU5qUENkbDNHOTB1U3NURkhOelJaUjRvQ09Gb1d4SEI3?=
 =?utf-8?B?RnZJVGdhazJVZHpOYlRLRXB0TGVNSE5KSERLcUJmZlltRU9CbWlMNXQ2dmJX?=
 =?utf-8?B?akVKb1JQL2lUNThaSVA5NVJtbmF0Wm5mdFhxN2NhV1VxM1FIS0JFTXdvUXQx?=
 =?utf-8?B?ck1PamFkU2Focm56Q1d2V2dyamM1eWFXanZMeSttZVd1WFl4WU9ORGI1UVpt?=
 =?utf-8?B?Tk0vUk9uYWhqYmFLa2VXcmJoYzR5eU9kVEpUSXI4OEFoaDBOWTEvdU84b2FT?=
 =?utf-8?B?WXlyWWREZU9tajVqLy9uNXJQR1VuU2lRdG9OT21TYXF3elVRdnBxUzBFdTZj?=
 =?utf-8?B?Z25BMFh3WVlXK0tuVTJvNkN3TTU4ZnBSaUhEV3lsSDN2bHVwRVBxaFdwQkxN?=
 =?utf-8?B?L21iM2NQV3VVcE9PcXQ4RXRlb3hoV0k2K21HOG5XcHFnQkVqNmNQOXY1ZzVP?=
 =?utf-8?B?RmVPSERsSElLUnlnSXV6cW12OG9OZmlBQitHelpyYWhmTGJOem9CQk14U2U1?=
 =?utf-8?B?K0l1N1NyNkN1TzE3RFFBNHEzdHVleGpiTW5YTlM3TjRHV09pNUtmWW51VTdq?=
 =?utf-8?B?QlhiZnZ4ajZSU1lXZXZ3MDQ5VElGeTlOQTVreXhBNWZMMXNmN01KZU93WVFT?=
 =?utf-8?B?TjNxbWFZOHhTQy91RnVseUhocEZuMVBXUE1MbGNPOFFiODI1Y1ZlcnhWUWEz?=
 =?utf-8?B?d2x0NGpFWS9oU2hNZFB0UWd6RVlRb3F5citoZ3cwWlhMY2RRZ1p3cXZQU2lm?=
 =?utf-8?B?ZmFLVVlWWEZwdENCTEFUR2Fkb0FRM2xwVTFHMEFEeFlOc3h0TVdjdS8rRkJM?=
 =?utf-8?B?OXI5UUlwV0NHeTljMXF1eHpMaitQUEhoaU9oNkVuQVRKc3oycG12aW9VZzMz?=
 =?utf-8?B?QVFrQVNEbFlUb0F4WUxuakVrd1ZxUDFPZ0syOE9qL3h2NjdkeFowU2IxclR5?=
 =?utf-8?B?MW8wZDdNMHhnc2YvZDhqM3pHVW1aWnc0Tk5MK0cyZU1EUlZNblVVbTNyV2U0?=
 =?utf-8?B?RjREQXlqQzF2QTJvMmZtN1ptVWxqaTNHc0pRSWtFQjdqdm84c0hzSDNIdFkv?=
 =?utf-8?B?cFNGZDQxanYvSGViRXoxdTJzWTJpR2NwWFNwbG10eUdvdjVoL3JnWWtTNVV3?=
 =?utf-8?B?S2NNWWxrR2QzN1Z2ZXplQi9RTnd3aGliNVRPNkNxUlF0aHZkZHJTbHY0SjVN?=
 =?utf-8?B?V0NLQnplVWtnT1FSN014RzN6b0RVQlN3L1dxR2JuOTNMblJUbFloUGV6SzI5?=
 =?utf-8?B?NTM2RUxCOEZDRHdIa0JieHRjYVcvVTEzREY2VDZyQ08zaE1wTndJQVBzbG1N?=
 =?utf-8?B?NXFmbUpvc09BT2pPMEdhVTNFOU5ZbEVobXhWN25mZ3EyajBrMUd4RENaNmVZ?=
 =?utf-8?B?OEY3VlY1Tnp4ODQ5MVF1RmdyZG9zYTNkTEM4VkIyMzlGSk02Yms2RTJMTDlM?=
 =?utf-8?B?cEVUem1PWnFDSDFoY3JZZUxxZ1pQd2k5TGtpYXoycWc4L0luc2JyM3QrTTJN?=
 =?utf-8?B?Tmw5RkMxM2Z2S011bmlMSHhoUTc2OEYreHd5M2ZjUHVqNkhLenNmeU9jNkl5?=
 =?utf-8?B?Qy92L3VFbzY0MW1YK1BSaUQ3bnNaV1VmZ0twczZqU0RERmF4b3ZqRlhUUUlD?=
 =?utf-8?B?aE1yb2lJY241SjJOOTlhQ3QvZDd1S0ViRFhrYWpiR1V6bDZaVkx3b0pzVVVW?=
 =?utf-8?B?YW9nK2I0Q0pKWnFFSDNxWjBVV0NMSjBoWjBjR21oYWRrRWpUWUpBbTN2dDRu?=
 =?utf-8?B?c1BsMUE0UjdTYkVyRWp3aG8rN2lJT0wwTFcyemNvU1M0OHJPZ3M1M0htRWZm?=
 =?utf-8?B?c2pNZjBxUGxoWWhzK3FyNGdBU2VIRnh3WTJidm85YU1FS3YrSGdtUnQvSmxn?=
 =?utf-8?B?ZTFYMjJhWDZDb1o5MHBzUHVKSnB2aVYwa3JRd0gveVNqb3R1QmZkREtoUHZu?=
 =?utf-8?B?ajFncUVVVVgydFFLRHF3R1VqeTZaSHBNOWZHZzhWV2Nka3J1dlBEWkdjZU5L?=
 =?utf-8?Q?prLM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e177e7-c896-4937-7323-08dce485a54d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 15:03:03.6419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzzzs1A1UBrnkayLdq0u43lGY88AKSrAezrwbHUdylyBhDxlOWs2VP0+lwYUWG1t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9195

Hi Reinette,

On 10/3/2024 9:17 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/3/24 5:51 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 10/2/2024 1:20 PM, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 9/27/24 9:22 AM, Moger, Babu wrote:
>>>> Hi Reinitte,
>>>>
>>>> On 9/19/2024 12:45 PM, Reinette Chatre wrote:
>>>>> On 9/4/24 3:21 PM, Babu Moger wrote:
>>>
>>> ...
>>>
>>>>>> +}
>>>>>> +
>>>>>>     static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
>>>>>>                          struct seq_file *s, void *v)
>>>>>>     {
>>>>>> @@ -1793,12 +1802,48 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
>>>>>>         return 0;
>>>>>>     }
>>>>>>     +static int resctrl_mbm_event_update_assign(struct rdt_resource *r,
>>>>>> +                       struct rdt_mon_domain *d, u32 evtid)
>>>>>> +{
>>>>>> +    struct rdt_mon_domain *dom;
>>>>>> +    struct rdtgroup *rdtg;
>>>>>> +    int ret = 0;
>>>>>> +
>>>>>> +    if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>>>>>> +        return ret;
>>>>>> +
>>>>>> +    list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
>>>>>> +        struct rdtgroup *crg;
>>>>>> +
>>>>>> +        list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>>>>>> +            if (d == dom && resctrl_mbm_event_assigned(rdtg, dom, evtid)) {
>>>>>> +                ret = rdtgroup_assign_cntr(r, rdtg, dom, evtid);
>>>>>> +                if (ret)
>>>>>> +                    goto out_done;
>>>>>> +            }
>>>>>> +        }
>>>>>> +
>>>>>> +        list_for_each_entry(crg, &rdtg->mon.crdtgrp_list, mon.crdtgrp_list) {
>>>>>> +            list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>>>>>> +                if (d == dom && resctrl_mbm_event_assigned(crg, dom, evtid)) {
>>>>>> +                    ret = rdtgroup_assign_cntr(r, crg, dom, evtid);
>>>>>> +                    if (ret)
>>>>>> +                        goto out_done;
>>>>>> +                }
>>>>>> +            }
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>> +out_done:
>>>>>> +    return ret;
>>>>>> +}
>>>>>>       static void mbm_config_write_domain(struct rdt_resource *r,
>>>>>>                         struct rdt_mon_domain *d, u32 evtid, u32 val)
>>>>>>     {
>>>>>>         struct mon_config_info mon_info = {0};
>>>>>>         u32 config_val;
>>>>>> +    int ret;
>>>>>>           /*
>>>>>>          * Check the current config value first. If both are the same then
>>>>>> @@ -1822,6 +1867,14 @@ static void mbm_config_write_domain(struct rdt_resource *r,
>>>>>>                       resctrl_arch_event_config_set,
>>>>>>                       &mon_info, 1);
>>>>>>     +    /*
>>>>>> +     * Counter assignments needs to be updated to match the event
>>>>>> +     * configuration.
>>>>>> +     */
>>>>>> +    ret = resctrl_mbm_event_update_assign(r, d, evtid);
>>>>>> +    if (ret)
>>>>>> +        rdt_last_cmd_puts("Assign failed, event will be Unavailable\n");
>>>>>> +
>>>>>
>>>>> This does not look right. This function _just_ returned from an IPI on appropriate CPU and then
>>>>> starts flow to do _another_ IPI to run code that could have just been run during previous IPI.
>>>>> The whole flow to call rdgroup_assign_cntr() also seems like an obfuscated way to call resctrl_arch_assign_cntr()
>>>>> to just reconfigure the counter (not actually assign it).
>>>>> Could it perhaps call some resctrl fs code via single IPI that in turn calls the appropriate arch code to set the new
>>>>> mon event config and re-configures the counter?
>>>>>
>>>>
>>>> I think we can simplify this. We dont have to go thru all the rdtgroups to figure out if the counter is assigned or not.
>>>>
>>>> I can move the code inside mon_config_write() after the call mbm_config_write_domain().
>>>
>>> mbm_config_write_domain() already does an IPI so if I understand correctly this will still
>>> result in a second IPI that seems unnecessary to me. Why can the reconfigure not be done
>>> with a single IPI?
>>
>> I think we can try updating the counter configuration in the same IPI. Let me try that.
>>
> 
> Thank you very much.
> 
>>>
>>>>
>>>> Using the domain bitmap we can figure out which of the counters are assigned in the domain. I can use the hardware help to update the assignment for each counter.  This has to be done via IPI.
>>>> Something like this.
>>>>
>>>> static void rdtgroup_abmc_dom_cfg(void *info)
>>>> {
>>>>       union l3_qos_abmc_cfg *abmc_cfg = info;
>>>>           u32 val = abmc_cfg->bw_type;
>>>>
>>>>           /* Get the counter configuration */
>>>>       wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *abmc_cfg);
>>>>       rdmsrl(MGR_IA32_L3_QOS_ABMC_DSC, *abmc_cfg);
>>>>
>>>
>>> This is not clear to me. I expected MSR_IA32_L3_QOS_ABMC_DSC
>>> to return the bw_type that was just written to
>>> MSR_IA32_L3_QOS_ABMC_CFG.
>>>
>>> It is also not clear to me how these registers can be
>>> used without a valid counter ID. I seem to miss
>>> the context of this call.
>>
>> Event configuration changes are domain specific. We have the domain data structure and we have the bitmap(mbm_cntr_map) in rdt_mon_domain. This bitmap tells us which of the counters in the domain are configured. So, we can get the  counter id from this bitmap. Using the counter id, we can query the hardware to get the current configuration by this sequence.
>>
>> /* Get the counter configuration */
>> for (i=0; i< r->mon.num_mbm_cntrs; i++) {
>>   if (test_bit(i, d->mbm_cntr_map)) {
>>     abmc_cfg->cntr_id = i;
>>     abmc_cfg.split.cfg_en = 0;
>>     wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *abmc_cfg);
>>
>>     /* Reading L3_QOS_ABMC_DSC returns the configuration of the
>>      * counter id specified in L3_QOS_ABMC_CFG.cntr_id with RMID(bw_src)
>>      * and event configuration(bw_type)  Get the counter configuration
>>      */
>>     rdmsrl(MGR_IA32_L3_QOS_ABMC_DSC, *abmc_cfg);
>>
> 
> Apologies but I do still have the same question as before ... wouldn't
> MSR_IA32_L3_QOS_ABMC_DSC return the value that was just written to
> MSR_IA32_L3_QOS_ABMC_CFG? If so, the previous wrmsrl() would set the
> counter's bw_type to what is set in *abmc_cfg provided as parameter. It
> thus still seems unclear why reading it back is necessary.

Yes. It is not clear in the spec.

QOS_ABMC_DSC is read-only MSR and used only to get the configured 
counter id information.

The configuration is only updated when QOS_ABMC_CFG.cfg_en = 1.

When you write QOS_ABMC_CFG with cntr_id = n, abmc_cfg.split.cfg_en = 0 
and reading the QOS_ABMC_DSC back will return the configuration of 
cntr_id. Note that when abmc_cfg.split.cfg_en = 0, it will not change 
the counter id configuration. when you read QOS_ABMC_DSC back here, we 
will get bw_type (event config), bw_src (RMID) etc.

union l3_qos_abmc_cfg {
	struct {
		unsigned long bw_type  :32,
			      bw_src   :12,
			      reserved1: 3,
			      is_clos  : 1,
			      cntr_id  : 5,
			      reserved : 9,
			      cntr_en  : 1,
			      cfg_en   : 1;
	} split;
	unsigned long full;
};

We need to update bw_tyoe (event config). When we write QOS_ABMC_CFG 
back with abmc_cfg.split.cfg_en = 1, the configuration will be updated.

if (abmc_cfg->bw_type != val) {
        abmc_cfg->bw_type = val;
        abmc_cfg.split.cfg_en = 1;
        wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *abmc_cfg);
    }

I will send you the code later today.



-- 
- Babu Moger

