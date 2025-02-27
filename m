Return-Path: <linux-kernel+bounces-537272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E1BA489D9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB53188F7B7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D99626FA4E;
	Thu, 27 Feb 2025 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eBTFt6j5"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D821326A1A4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740688013; cv=fail; b=r2rPg/FyAp7M71VWDLJ+GFbXaV7p/eeYO9Lr+yJZUgJgAdYyFHXXDV8EZCkWKzUPw6zUK3AwfUcivgK7SLyBRIzNUvDuOJ0yVtAhN8hFWTvrSbVYW7Z1QuRaHUYlW806UQBEnwrfsoC4sV/L7R0LBs1lHZ29WIARQ8oiqhlMBFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740688013; c=relaxed/simple;
	bh=zEaEZ/3Oev65oPG9kKIHTdGjdwruvTReqvTcs46XkmI=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y/mae+8Ly4C/4OxFdbxCx54QtZ4/r4/3TCyYv+riC/4e20xU0E4wBssCVsgbcmBePWjad/m6IMl+mc+bUbcZFUAQo8YECgC5OqdoGAPU2qsFdFhaNzrbwG1Tu2mDZ1bY0i8chLgNpz5qOW39K1fgnPwl0Lz2alGudg1GxWPev1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eBTFt6j5; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPhP00u5EGosnWUeCMC8IeXAwEFYy72LZMrfMW5R/5NzzdbK/19UtE8d0V+SYPLK7sQZ71zTNIIfcv0f9DmwyL23MjDVy9W8d4UWmm56GjBFXjPgbcuognS2CD4VNzXIl4kAQU3DkT4dVc1ZYg7XJ43XSWS6fkGriPHi/XOglI4AqWX3YH2pArCnKl/8fRpnbQFELVpl+l60ZOyOZeVUqv+ACLMTqDFns9W2jWAw1GmAVVrmIDyBc++aTDWwqNxxi8LX+686o3d1L11AbCrbOyLL3mlpgQL1XsDfFjW1KejZm5UK/5sXrEmjTPg6Cvfn4Ym/CYNN20eqcNq5wvNeNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yoQNDFHrNTNa66IzYV1Pp/085qnED24xMWj9+moYMM=;
 b=swQMz6ikBzGcT3aKNoZpDFizhK/6OpMUeVmNj8qDSDCVOsHOm0bZ2JC1lLDsQo8O8vijaG2jaBOB78CqXV/aJJs8fN/KY9l+ZOn+eFb5uLL4Mq7FnEMycad8BqVtOe6TaLbjiz1sLhXBfutUQc3tQNbBMYYl9D3xSW5QkgG3ne0e2xcS/0vgiJIjYSXtxyOfkXf/ZbFZbFLd7nRAUL4lSeA9ILstFe9WazMNKWNLFRQxSsJA0yDCY4u4dGWOPIqm+b4/79b27Z7sE15qskvHaLMpjUeTk3ZjRsIfY/LwlNtMgcNez/4IooZbZCAw1p8ZqcXLhcQcyAHDAWu5ogAZNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yoQNDFHrNTNa66IzYV1Pp/085qnED24xMWj9+moYMM=;
 b=eBTFt6j5Uf0Am3JEHJnc07RkO+tXOo9McRPDF/GzkL0Ccx4x5N9yr6te5HmxwHlNSGmSqvt7zjZ1vizTvEyhaihvOWRw2T+RSNbAzvAeoIlkgcWTid41D7YRtXbNraGvliqLWy7w2sxCxWSEoV5Gbof3g2hHUs0qakboqg2n2T8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.24; Thu, 27 Feb
 2025 20:26:49 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8466.015; Thu, 27 Feb 2025
 20:26:49 +0000
Message-ID: <f91e1dd2-2ab3-4c23-893d-a87d4d38e43e@amd.com>
Date: Thu, 27 Feb 2025 14:26:36 -0600
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v6 36/42] x86/resctrl: Add end-marker to the
 resctrl_event_id enum
Reply-To: babu.moger@amd.com
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-37-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-37-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ROAP284CA0264.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:10:f1::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: 69cec384-4a15-4133-ee0c-08dd576d1068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkltYTBLUEhQMVo3eE9JbkV5M1dLMStqM2FCMk1GbjdLWjRrS2RtaEUzTjhl?=
 =?utf-8?B?VVpxR0Fxa1k5RDBPRkw3QUp5VC9TVGIyQ3lVaXBXekx5TnFpWjg2TEowRnlz?=
 =?utf-8?B?ZDl6d2k2Q3JIemYvWnJRRGdjci9YOEU0MERvT3k1ZlhoWW0vdzJBcWFrQjNW?=
 =?utf-8?B?dDBBWGk0RUFkY3NZc05vK0c0MkZRQi8rYm9wSWprOTlWNno0b3EvelgwUDda?=
 =?utf-8?B?bFZhOUxwZGJ0UTUweHJhNU0vR3FJWVhhOXdjZEZha2cyeVIzQzhobitUaVBx?=
 =?utf-8?B?MzdEblBYL0dBdk9hZlRaMVIwSFBXLzJuYmJlQllmenBrQ3EycHFIbXYvYWd6?=
 =?utf-8?B?aUNORjRWaUFPZk1SMlJjbTV0Tk9nZG0yRzAwTUx1ZlE4aXNpcXBMd21yMDRX?=
 =?utf-8?B?Y1ZleDlpa1RTWXVDTWNyOGpQNWxWL09xSTcyK000WnlJcGpoYXJUWlF3VVNl?=
 =?utf-8?B?NzkrRmJaU3pnMHh2aW9ZWWx4S1dFcmFGR3VLdFZ0bnE4SXBYZkFsYWRTMk1P?=
 =?utf-8?B?Q2xWckZUNEx1RTg3S2xRMVI3dENRcHFiOEFHUU4wL3BHa0VEYStpd1BXVnYv?=
 =?utf-8?B?SGVYbWdjOFdCMTJsL0xEcGVLcnlxeXQvOHlKV0dKVHNpbjNiNmYwVE1XNFF0?=
 =?utf-8?B?eTI1VlB5MnBKWStsd2lyU1o2aGYrSUZPT3ZCWEpIWDVqWG8wRHQwZnIrM0Rv?=
 =?utf-8?B?NGF0WTdTUEpEMGN4UVZCcmdEc1N4a3J0VHg1c21ybytMZ3hqS0pRb29zNmVv?=
 =?utf-8?B?Ym90Z1dFVWJUdUpxWm44RmoxVXZDQ0xBTCtkUjh5aXF0N0JtS2RUTldhRjBD?=
 =?utf-8?B?R0lMUFFqbG1QdHlKMy95WVpidjYrTG9rdThoOWdidVNWa2paSE52WEs3V3Ns?=
 =?utf-8?B?SVhmRVcrUFh0ZGJaa3RzaEZPT2ZqMk5hbDYxOURCMmN3NFFVSEFiVWt2R0k4?=
 =?utf-8?B?cnY1czkxbmUycDhqY1g4ZmY5OFpobWlWRXZlckpJcmRCemQ2blNPVENNOVVl?=
 =?utf-8?B?OENpdyttSmllWmxmNW1Jc2NoK1prUW5oQ0w2NTM5UTRSb0JZZmlabEpJNHlG?=
 =?utf-8?B?VXVwcmhhaXFwNFhYTTFUcU1nYXhRRUFBTW9NNHk1WVR3V0RIbXZoWGtNS3dX?=
 =?utf-8?B?UTlmL09OZTNlbzV0N3JrWDNmSGlaZnhWNmtnQ0pEZGo0SUJEVTI0V3Rkeld0?=
 =?utf-8?B?NTc2UjFzUjk1MVcrMG5BN3RYdVhWZFBMZmhDZHlZUTF3dlVObnAwdWplZzg1?=
 =?utf-8?B?dytsc1FVeHMwZFdvL2RteUVhaHowc2ZtTHgzWjF3VjBBSWsxTjdxc1hCL2J5?=
 =?utf-8?B?WEtDNjdKbTZheFJNaWFhaXlmMzBVMWFTOEF6YTRCZFIwQ0NYTXVZVVZNT3pS?=
 =?utf-8?B?N0xsVGZxU1JmNWtNVzhRcFpBNWthSWZxWUNhSVhmckNoSExxKy9rMThjcUZj?=
 =?utf-8?B?alpheDBTbmRKU2xtM3A4eHc5R3BkMllTTHJPQi84SUxIM1ZzZEFzTmRWb0Fn?=
 =?utf-8?B?d2pYSitHYkJHSXVjMVZTYmErdGRyeURaQjBERnhrTWRUTlh4ekw1SjgxZ29S?=
 =?utf-8?B?K2szTWhGOHN5V3NLc0YwL1JGYnJSejhTV0Q3dFhhWldMcElJT0NwMVBMQmY0?=
 =?utf-8?B?SkJpZUdON3Y0VnVPSFladmNwbDJEeTNSRWh0bG9HZkpMVjBZWnNnelNwOXdt?=
 =?utf-8?B?L3BibFZvNDR2ajh0RVVsVHl0Y1FaWmhLeWVUci9tRVlBRmord3EyOHQ0WjFO?=
 =?utf-8?B?Y3BQMUx3eXRSNDlKLzl1UXgrTDlpMzhtZWVEWTR1aUZYdmRSUkJlSEM4RXZp?=
 =?utf-8?B?My9COUNZd3JrSTcvU2VvK20zdTk1c3p5bWRDM3dLcGFsTlB6d0w1MHBSNzBC?=
 =?utf-8?Q?B1TuTj3ndHO+Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTJVMFE1OHZiVzArajJxUGZxQ3JCYWZ2aUJIL01pblVIU1hOUUxWWmg5OTcx?=
 =?utf-8?B?ekFtQ1NuNU9LVXliQktDS2QrcThrdW9vaHdLSDhpeUgrdFdmOCtPVTdhYnJ3?=
 =?utf-8?B?eVp4SkpOMWRvTGlDWWRyanR0MGFCa0w2QWxYanZkZFp6UkVrVDRTcTk4MHlX?=
 =?utf-8?B?NU1CNklNUlBabWgwRjA2SUNHUU5Ebjh3NzMrNlpjL09OM3NuNGt2WTcxVGhE?=
 =?utf-8?B?Y08rU1hvTGN3ek1XN0lYUjdacVBjY29sSUZpYWxMMlFnWnNVK0hhZ01OeTJ6?=
 =?utf-8?B?WGJob1VkSUc3c0JrdkZQajBDbUNEK2p4UFRJSm5HNjVsb3pxeXJseGs5VG4z?=
 =?utf-8?B?dmN6UkRnWlo0SWp3aTZVbHhwZVcwWml2UUtvSGkrLzJ2T2c5akZwWXYwVWpY?=
 =?utf-8?B?enZrdk1aczVyc25vRGhkUWN2bEFLUmZrNHNmUEpydTNEV1QwaWdZc0c4dmtj?=
 =?utf-8?B?RXQya04rRmJjNkpmWVE5bXV3eHRrMTdib1V3MmM4LzJ1bHlkOWFIU0J1Snpk?=
 =?utf-8?B?VGhaa2NHTkhObkJmbTMzSGJONjl2RjBZSmtEM3IwNW1CT3AwRHdHMVJ4TGUw?=
 =?utf-8?B?OC8rQVQ2Y0JQWFBQeFJpQTBnbjFnSFVRWVdKNThSYi9rSERTR1hIeDI5S2VE?=
 =?utf-8?B?M0ZTby8waEVQME9RUzJlY0Q1Si9Tc1RRd21OaDg4bXV1STVQby9VTDhNVmk3?=
 =?utf-8?B?SzBzWGJldUx1RGEycnN2aVgyeFRBTW51SlhDRmRaZi9TaDlNSjdtNXJjTHNR?=
 =?utf-8?B?K0JUbmYrUm9WWHBBVDFUbFZBUytVQkRhaCtYcmh5OXdxM1ZjUTliUnl2U1VO?=
 =?utf-8?B?Y2FCT0dCTUxvUEUrZDNJOTRESStVUzlZZGc5ZDIvU1I4MGU5T2x1cFI5RlY2?=
 =?utf-8?B?bjNYckFnUzdlMGd0MThrbnBmcnRFRjdTTndMZkJhS0kzUWxWZXI3YTRWMWZO?=
 =?utf-8?B?MHZHazFDRnoyelZPNjV0N1NVNVZKaU9CMXJrWS9sQnl3TmxwcDFrN0FYSmpJ?=
 =?utf-8?B?YjkyUHltMDlSZENpRlBWN1BvVEc3SWFPNGZtazZ2WWNLRmEwVHl3QXM5UVY2?=
 =?utf-8?B?R1RncE4reWZBSkNvNGY3VTRjZjEwVzZVOUFFQzRZOUdzWWF4c3JIRXc1cnhh?=
 =?utf-8?B?ZXZieUg1NnBzWitLWHJBZm9IMU5zZUdtNFlXRmNEeU1CR2x5YnpObGRjSmdv?=
 =?utf-8?B?YnFGYWQxMGR5TzFSVFlPTjc3aWV0UG1hZnhiOHVJL0djSmg0SHJYMEg0UHlj?=
 =?utf-8?B?RWRxL21KN21pVHdIV2IxVVlOZldyaytLbHZGR0pMU2o1OGJwNlo4K0Z3eFcy?=
 =?utf-8?B?US9wY2V2N2hjb1JSZHZHZWxESWdXMzYvZjFIRHdvejFDTjRKKzA5WGI3R0ZT?=
 =?utf-8?B?MjFCWjBqRmpVa0xvczJ0dzlUWDdOYXd3QnRQZ2VoUHJpN3dWUitqbUgwVGN0?=
 =?utf-8?B?MUpEODZ2RENDOTFjbnlQN2F3MjRKeXR1dFYzK1pzejBOSmhTa1NSK2t4ekRW?=
 =?utf-8?B?UDJXTTNiMmZSTm0zLyt3RzdDSWVML3g0OVRZbFl3Yi9yQks5Mk9ZQ1N1MjR5?=
 =?utf-8?B?NmZVSUtUSGNuc3E4MVRpOW5lYlF4VTlQdXptVXdIRnpUcHJCaCs4UVJpR2NK?=
 =?utf-8?B?QjFQU2FmOGVHNzlQRGhyWGJxN3U5Y2x0Mjl0SFRBcnpBbTdHeUJML3JsSm5E?=
 =?utf-8?B?Nmp3WFNBWEc0UHdGMGtDdFBtK1JuTzlTZzR4bmxFNnNxSGo3VFVqSU1nVHZX?=
 =?utf-8?B?dnNiUHJ0UlkxZnNTTWRFZkhoWDUzaGZsd244aHA5cVYvWmtVaGVJNlh0TmI2?=
 =?utf-8?B?ZUdVK01vbVZNaDd2YW5DNGQyOHZiRzhEMTBZYXp4MmZNOHAwTisyT1pGQmVx?=
 =?utf-8?B?d0JZcjdXcWxKbTFTN0VLNzIzczE0L1ZjZ3NraTIxazVlV1RKNTFSLzJ1cFFG?=
 =?utf-8?B?V01hY1gyMHpPazZKSmRvMjVERUtDeEVEMmNnaUdtUS95aGMydXFrVzhMcjZ6?=
 =?utf-8?B?MUx1WnRZOEhBVWtHSm9wUjJZNkV2bjVxdnBaelJIU1B3TGo5VlFEL3lGL2FZ?=
 =?utf-8?B?Z3ZtajJPWjZ2UUEyKy8vcEVqbGowTEFZZlhYY01aSnRrRHc2eGp2ckgwelhy?=
 =?utf-8?Q?poAA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cec384-4a15-4133-ee0c-08dd576d1068
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 20:26:49.7307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXT8HvJGgw3nJzyouE8XOiZEqlqNNtsRoiBUH1KlxwrURy1826+i6DMc7jNTri9u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214

Hi James,

On 2/7/25 12:18, James Morse wrote:
> The resctrl_event_id enum gives names to the counter event numbers on x86.
> These are used directly by resctrl.
> 
> To allow the MPAM driver to keep an array of these the size of the enum
> needs to be known.
> 
> Add a 'num_events' define which can be used to size an array. This isn't
> a member of the enum to avoid updating switch statements that would
> otherwise be missing a case.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  include/linux/resctrl_types.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
> index 51c51a1aabfb..70226f5ab3e3 100644
> --- a/include/linux/resctrl_types.h
> +++ b/include/linux/resctrl_types.h
> @@ -51,4 +51,6 @@ enum resctrl_event_id {
>  	QOS_L3_MBM_LOCAL_EVENT_ID	= 0x03,
>  };
>  
> +#define QOS_NUM_EVENTS		(QOS_L3_MBM_LOCAL_EVENT_ID + 1)

Why cant this be part of "enum resctrl_event_id" like we defined
RDT_NUM_RESOURCES?
-- 
Thanks
Babu Moger

