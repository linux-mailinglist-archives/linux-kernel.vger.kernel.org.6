Return-Path: <linux-kernel+bounces-551567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7E4A56E06
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E1637A4FA0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03781241C80;
	Fri,  7 Mar 2025 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yxx77jSa"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9018A2417C9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365555; cv=fail; b=Chwe37PzyDIf/nZSt2VtQ0d1b2wpx8ac/4VTpkzsqGSn7T3HF+DY5HGG6E8Io5npoosWb4CssBBIAq5Z6O8pjFLkDXqdH31g8fbIxT17Vb2KrNF7pJPzxXXrXx0JO3djvuUiJ9yIN/piittM8QTBihIMqqDq0Ve9kxcvpViDtm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365555; c=relaxed/simple;
	bh=jvPTwWXbbAJdiA3cToxwviyBCdwKT517WcB8btekucE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iUsb7+vjKIj8mBOvapzDbkosgm/yD57FQVWY/WPvfMhy0bU4JCJdcnhXlOwYeWfOkRr5i+AGEJQ1l+O79a3F6BTKk94RQB+1zqZsQtToPSeT/IY76zt7aROmsnuAA4Ghp0SJUJfXMhEwV99xnNcfywN8TJO88P8jawbUb3sNZ2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yxx77jSa; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzwQ2ly7nic4UnxvBdPCx353DCOWtCSrwQlAhwAMq96iMl055yA6uInq0gfGQeuRobYEOv5+oUhbagtAPrMtaiJYOxrx8isFOZ6kU+OiMYgfOsh0/jL4XWaAQxQDau0SwSBr1kOFQpSdoD+LPEZcjNCv169RsVMLYbRnqp2OxEtlCWhU6ERZpc6C230PYaIJUHIeyqIbVTM6ZqbwKSFjpL2J3DpvnD9UlerckqaJZqGgqDRc6gOk0r3PVGy8HI2S/qDx9szYAYQA2qLPQ17p0gpW30wHXARpZoRqkVwIasExDXnWlGtnw9FPaBgASqs+lyKc2hMtYa315T3zF3npAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvPTwWXbbAJdiA3cToxwviyBCdwKT517WcB8btekucE=;
 b=pvsEEDB6VO4jMZXxUc4WZc7Y4dtfHkFRoyzfkg0WG+OwxY7neu0GQsjxHwoDAGEIBc5eUzUq5+X7PdJhm/KSP3IT7vH07CW+Q74pLqzrVRXHoMLp9kXLPBoRIWfidDBt+ukpXKUr6uOI+dIFS4/JnBcrpM4RhWZF4c5p2bCjUyAdIsDOTl7/I5SIINXJ0BI/LCxPL8h4VNj8liObCCUA6SjyGx9vPPnADDfBOxmxnZtuuKuLUBG227ksJTPUIYTuPwLLQ7jcYklNNxmDDiVzFG8+hDLd2+RSz0/V9NzfUWL2KU/9u9rseivTFUXai5sPCRJe4xLMCyP9HlsedkMj6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvPTwWXbbAJdiA3cToxwviyBCdwKT517WcB8btekucE=;
 b=Yxx77jSarrnhHUp8kgKcGUdGUyCLxp5oXXmQvCtokuFP92l93bBeMYFyNINZ3uT834ydMP40Wscb8FztUvNuSkUniNppQ9JZIXudp1Uj+JBS2prEbIqcftQMcbY68sgry4btR+GNYnHzaEF5eSvUXsLbHgS9DUuj+vziVdxgBEbsuB+AT1rF+HtVQkZ9GWNIZwQlb6cIxFSBHrBTY+ytWgfXxBw55WzuYgAe1K8IElb+ZQCfUP2AWVHqrzVgSi6UDx73tkAGmpJbcvrlU+w1sFiePDbrn8q0VANVGVO2ZeCbOK38K2qztxgPSCVDQ97EYj7mAgvNyYOk4tDFXiXsqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6606.namprd12.prod.outlook.com (2603:10b6:8:d2::20) by
 DS2PR12MB9565.namprd12.prod.outlook.com (2603:10b6:8:279::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Fri, 7 Mar 2025 16:39:09 +0000
Received: from DS0PR12MB6606.namprd12.prod.outlook.com
 ([fe80::ee84:cbaf:9af1:3f5a]) by DS0PR12MB6606.namprd12.prod.outlook.com
 ([fe80::ee84:cbaf:9af1:3f5a%4]) with mapi id 15.20.8489.028; Fri, 7 Mar 2025
 16:39:09 +0000
Message-ID: <956a210d-1883-477a-9c90-9667031610e6@nvidia.com>
Date: Fri, 7 Mar 2025 10:38:43 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/49] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, David Hildenbrand <david@redhat.com>,
 Rex Nie <rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, fenghuay@nvidia.com
References: <20250228195913.24895-1-james.morse@arm.com>
 <5436632b-cdc8-4a55-8766-0cc2aec0b807@marvell.com>
 <5f3171e0-d96e-47ea-92d7-0a3e3e3f8147@marvell.com>
Content-Language: en-US
From: Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <5f3171e0-d96e-47ea-92d7-0a3e3e3f8147@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::20) To DS0PR12MB6606.namprd12.prod.outlook.com
 (2603:10b6:8:d2::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6606:EE_|DS2PR12MB9565:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d403e98-4adc-478c-5275-08dd5d969580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OG5qWFdTbWwzdXh2K01pejV5VlNlclMxTHNLTmtUb2MyVktpdHZBNENXNzFU?=
 =?utf-8?B?Y242ck1VN1ROL1ZpQWZIMHZOY1gzdGZLanNOcHJDQkNzTWY0dkx3TDN0OE9C?=
 =?utf-8?B?WThoTUUxcm4zV3dFTFBINWdFdHRZM1R2L1dXNktvcmFPT096RU8rZ21DZTBN?=
 =?utf-8?B?TWpVNVlxTTdtVDY2dXBROWJaYURoRU0wSnlLVU5TY2dnUi9BcFJxTjJCN3ZI?=
 =?utf-8?B?ZnZEaWhzdjFZNTZiRWUwbldMMHZUUzdNVkJ3MzNBVS9zVnQ2MDNJcS8vY1Nx?=
 =?utf-8?B?WFdMSUVHbG9rZm5hQ05iVGRBeHlITTZhTlp2OXNjSlZIdzJOdzFaRHJsSk5o?=
 =?utf-8?B?dWd6UnVBeTZTUzVYc1NWenBZeFIxelhWMDM3cDhqSGNwMmpZQldsSjlYUSsx?=
 =?utf-8?B?Y0gvd1JZdnZJVTFEQTk5L3NYSlpiNU5KNDl3SmdvbHNHaFhjVjA5SzVtU1ZJ?=
 =?utf-8?B?UFJ5YU13Wk5Td3BrMmZEeHVTK1BJSE5KQWhDbG0vbXN6Z3B1Y1ZibTF4aTJn?=
 =?utf-8?B?bEdwZFdqVjBVZTdpZldLanhZRlJpNmE3aExTYTh3THpCVFNYVXNRaUhPNjRa?=
 =?utf-8?B?eDB2UW1Hdi82WGdyQUJ1Qkd6Smthd01QMFhZdXJGTk5lckt6RW5aSHJSN2ts?=
 =?utf-8?B?cXdJQXozMEpYM05udGdoc0ppblpJcEZtSTJTYzZGRFV2bWRVMnd6SHFWbDRG?=
 =?utf-8?B?bjNDazIxYU5wTk1rQ3FJR09yeUMwcjhpZjJNU1RGQjFiMXAxTjZBMU5PamZD?=
 =?utf-8?B?OHREVnk4aWVKbWhkN1YzNUd5ZFdUOWJVaHNxSExQMmh5ZDBtYURzTzJab09h?=
 =?utf-8?B?S2FtUTR4dFVYeVdES3RBUVhRRWJyR3dXT1c0SS9xamN0M0JtMFF2TVZkd2RJ?=
 =?utf-8?B?NGNOS2xJczFTOEZWdVo5S0Y2N2JwNHVBZEdOemM1ZkVXUGFCamVTRGJNYjdu?=
 =?utf-8?B?ZEY0d05VTU5ZR3U5emJpWU15UTlWYlA3Q2x0TG92cFlhTXkwS0k0RzlKZW12?=
 =?utf-8?B?TGc0S1pQdDRkRU5xVml6b28zbGNyUnUxTVZDUzlBdlpSYlJpK3pkQlRVR0t5?=
 =?utf-8?B?S0dMZ244Vzl2SkVHNEc1QzdweWhLdloxMm5HOFVkVGpSOWorUnZHKzBOVTh5?=
 =?utf-8?B?ZlBPb0U4aW85MTJqdHFTYlpwdVY1aVpVb01JYTdGdkNjS3hMdnB4dE1VTFcr?=
 =?utf-8?B?eHpROXYvN3ZIMmxONVo2a1NYaGVnUDVZeEJwV2tmb0ZLUDJHVHpJWmZ0Yzc5?=
 =?utf-8?B?TUhURm9PVTFLa0tadzNhNFM3OE1GOHpjSk1ibzR5YU51dnRNbUYyaGkvMFps?=
 =?utf-8?B?WXR5bnJLMXRkcTVkejBWWjNRWnBMZzhRRklIamU3dWlXRmtqWi94K3lsSG9y?=
 =?utf-8?B?dTl1dWpSTlNhazV3Sk5helBURXQ4SWFUenNBWnF1QmVRUkk1dkhicnUrc1lu?=
 =?utf-8?B?WHB6bXNnWE11L3Rxenhzakt1Tm85U1lLelhjS3FodHN3V1hPNTlRelZ2c2NJ?=
 =?utf-8?B?RUkvTTA2NkUvMFhrU0hXWU9CQjhKK2dMLzIyNWJEUTBKeWF4WEZOcU9lNVBI?=
 =?utf-8?B?Sm5JSk8xVzltdFRkTXg0MmcxY21kZ2Y4TDgrSEowMmFRMFRmeWdzSTBlVDRj?=
 =?utf-8?B?NmxPTjlCOHZuUHRMSmZ2cDVqalRNdkd3ZUJOQm5TcHBnZ2tMbmYwVUtSUkQz?=
 =?utf-8?B?bEFiME50SzBuOWRla0xRZ0tEb3BsODRPRUtDaDEvbXB4c3ROR25xSGRxUlVL?=
 =?utf-8?B?blllYmdCOVR2d0FCa2xiYXRNSDFtVTMwSlZuTVpQQXFCK2Q3allVUHFhUUJ4?=
 =?utf-8?B?U21QdFdzYlJJUkZ0WkNyWTg5My81YTZPSUkzQnZlQ3dBdGY3M2ZadlNqRFVL?=
 =?utf-8?Q?aA/E9G0MBbQRM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6606.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0cwcEFlRFNMQW4vMkhrc2doeU5mV3R1M1FWRjh2ZU5Rb2Q4OUNMTkxYaXcy?=
 =?utf-8?B?eC85dkZFU0oyM3l0aDFIak9hRlBIQW1Jbm5lMW52NXlUM0FqaHA3VTMwRmhh?=
 =?utf-8?B?SnF6YWYzdlFMWExkU2QwWVpvT0FJZ2k1aXliT0FRekthNkY2ZUVSWFFLb0NZ?=
 =?utf-8?B?RWdXS1VuTXNicnFYQjFQeXEveTA0WFphKzJhbnRrQm5USDdxU1FXdHg3UVZu?=
 =?utf-8?B?bVZ0N2o1MEpCa0tkUzVyR1NPLzRyTUwxME5ydVpkRGx5REEvdml1elpuL2dp?=
 =?utf-8?B?dHhxT0hNSUN4Y3d3ZjNsK1FHSGYwZnBnTGdvYUlBODFaYVVXTE9BamxqZW1h?=
 =?utf-8?B?eW13ZGhoalYxeW5VTnI2TTFzRmZJUTlJQi9BNHJnMXZMeCtFOWF2a3pLY1Vv?=
 =?utf-8?B?RXRvaHdkWmQ4ZDEyMGFIdTRWRjNvZWU2emlVdmtuZ2ZQbVM1MHF6RXNxalN1?=
 =?utf-8?B?UnpmZTl2eE5ZL21IU01zS29ZaisyZGs4dTR0NGlqSC9CallBV3Iyd2ZJV1FR?=
 =?utf-8?B?R2lESnRyZGFtM0lrSk04WjQ2UzJjdzE1Tms4cUJkNWkyb3JoZEhGR1UvQUlD?=
 =?utf-8?B?RVd4amJoRkxFN1A1M2JPb1NON1RsUisxa21vTWkvaVhxZVU1Znp4dFcwSjdW?=
 =?utf-8?B?cEM0dktSZUV0ZitaM0FPUnNJZlIyaWpFaCt1MHc5UHZGZG96UmpPWHY4RVQ2?=
 =?utf-8?B?VXBCOGpSTU1UM0ZPQ3cvdXM5UmJsRWZIQm5XVEpaZUtjbGR3bXhGSTBONlMx?=
 =?utf-8?B?N0x3NmxkRlVCQ1ZyNGw4V1ZQSE0yZzlyclB1Y0JGc0ZQa2graCs2dG5Rc2lu?=
 =?utf-8?B?MUltSWZ3NkJUTURMQk1QSXlrOExpZ2F5ZWZuYWJOMTZjRzV2VW9RcjdrTTFp?=
 =?utf-8?B?OXNFN092OVhlMTR0YWlTL1NtUURlSjVUMGhJc2tnWE1wYTBpdVhtL29xRGNS?=
 =?utf-8?B?UkhjL2dGcm9PN1NTbHJ0Sk1nU0dpVlZqYW5sbFJ1V0NQYlFQQnk2L1BPZXp0?=
 =?utf-8?B?T0JhU016dDBsMDlKYmdaZ1p3ZSt3dXVMSVVIYThWVFhlZWpHdm1rd0YybXV5?=
 =?utf-8?B?WHNpd1VTSE84WmNqRGFGRzVjb0EwZ0tHeG12ckwvRzFyOWo0bVJZd0pySkZ6?=
 =?utf-8?B?d0ZabHp3VjNGeVg2M3ZmajhGYllSdUwyV0Nrb2JVc3o3QWhlQXZFejFkMGJH?=
 =?utf-8?B?MDVuR1RCTDdyUkp4amFLdVYrdUJaNWVqNzMycGNNUnUwdWRlc0lDMWUzSTR3?=
 =?utf-8?B?WlhqRmJpWmhDc2hKcy81bnRMb0orOWc0NmYwa2R5TU1JT3RoQmRzTzRlaGJT?=
 =?utf-8?B?MWx0YW9VdWpvS2xWSm5LU0s2T1VxM3FhaXpYWmlWQ0pYMTNhc2ZCZUtpUitI?=
 =?utf-8?B?NEZ3TmNkRXVXcTZqYW9aalZsUExOK2U3RStKRFJaUXE4QzYvRUpLc0pibVhj?=
 =?utf-8?B?eWtnU2twWkppQnNycm92YllxcVdqNzE2TkNZQmoveDZlTk5QYSt2ZGJzOFFn?=
 =?utf-8?B?V1UwSzhwTmlQbHNpUkNZN1BWcklvUzY2SU4xS0hjeXlxMnZCa1NHRzRUQW5F?=
 =?utf-8?B?UXlFK3BYd2poSGZ5K1BqR1Jud3J0bEVLUWg1THlXRnp2Y01lR2NhdEoxcnE0?=
 =?utf-8?B?bVAxbHdRNityMDJDQ1NUYTRaSDBUb0x4bUJKNXFhNkVSV1MxaDNYUWlSd1FH?=
 =?utf-8?B?M2k2WFFZMUlwS1Nja1ROWDZLc2JsUEM4aitVbkxCdXJSZXhxKzZSYlRIVUF6?=
 =?utf-8?B?OXQ4cXUvdlJCbWhnOFZrOTdSbUg0MTdDRnRCajFPTEl2MkpqUzl4cjJ3SzI0?=
 =?utf-8?B?Ykp1S3hmYm1TS1FoOWJnSDhjbGpOMkNvQW1qUi9FSnZXQkJDY2VibS81S0NL?=
 =?utf-8?B?WUpXUFFHQXU0elVRTDlpNEVpQ3c3eFlsaDVkMEZKVklveU9zZDIxSHA0anJ2?=
 =?utf-8?B?eEUzejhpbzMwUUFhM3JpTFFXRFA5bEhVbmxPNTRmdFVOZHdQWVUwekk5bWh0?=
 =?utf-8?B?eEFTVUlRSS9iQWQxdSs2cURqSHpwYnJoRjVtaXJuNy90MGN0N0Q1clpCTGF0?=
 =?utf-8?B?ME9EeSsvRTRIQ2ZRZUtEai82VTMyMnNKT0Exb3VkSFR1OVZvcmZMVEp0MHc3?=
 =?utf-8?Q?ZIZMal7w9nhngiasUMaBlkVTF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d403e98-4adc-478c-5275-08dd5d969580
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6606.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 16:39:09.3509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApjuRkznGDsTcVj1d/jfv3jMtM2IHrP4fLaqCmYUleFj/2bJqG46W9X9PBYK7Q7ptRpt0CIsCMIVhRaXJRQ1aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9565


Hi James,

I have tested this patch series w/o MPAM patches on the Grace server platform.
Validated both the features CPOR and MBW, results as expected.

Tested-by: Shanker Donthineni <sdonthineni@nvidia.com>


-Shanker

