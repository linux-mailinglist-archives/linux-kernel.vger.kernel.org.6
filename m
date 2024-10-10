Return-Path: <linux-kernel+bounces-359851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575CA99917F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B55282F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF961DFE13;
	Thu, 10 Oct 2024 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uiLiA5Sw"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354731CBEAB;
	Thu, 10 Oct 2024 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728585413; cv=fail; b=gY47+EupQmxhUz7SILg/5QPDHLL4EuyuHSFflSd4yTDhUT6dF3MueKH02b076tmDjMtypcbJ+MZa3g4F6CBk6XTh5xP3vLeIV+4eHqNBQL3OTpFrrbmktIEzpFHGTCYXGYZgsNQWgM9biuxmt0OkN2Wl+uvQ1e6aAdRS15H+RTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728585413; c=relaxed/simple;
	bh=3KvhDgraFxvEgUaeD99SEk97JsmTDHHwW1fEE6HlaI4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L+eWe4aaCY4Y1CHFFSyeEukWjr98Y+BotiC5ntMFLkxAalaq3oH2OAF6sNqG6icxAz4W8U8R/c25NN4z3KP/Wdq4J1FTnDibNca3OFapKx2wBSWoHjVJiWXlbbEa2KWSWn+8l/knN5ABAHWoEmVhxPhqh4PpZePuTGFmMDsdcCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uiLiA5Sw; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svXMEBZsfaG+oCqQCH2PbAKEimbXXn5Aa1nJfiF+J16gcYMw5JczFfaNfnchynRN+4fboYgsixzGd+7/qKimicg9ZlGL9QhLUBBMWdhPmStObvjEdEqGZUEjBIM+lZ3py/BGFOabd0tXSF4WhlK6thvlTXTNZlNrELaR3pZ5puZo1jD6VkVDP3PRNPMvowl31SJrGIDm2vX11enpbaC6NoeULRqXxUGHa9bTNRBnQcSXJav+pphBEQAMCMFWPYsV1ZUv54pjBYOxSnANHFa1wG7d6bx1hT/gd3mjhUrm7BLfhF+aua8N3alJiJavvBCS03jwnfbX5xaSg2k/mSdlVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9PQ/97dN+Mysvi1WDS1x5ebqRtprxmVyW7oM+/gdXc=;
 b=meeqmF86g4Fx0sJVPdE232pJqghLhNP6kdDdLjpsRipq8QUSIHh/cS0H6w2IVENCzjXY6q01nPPrKPAjuqUFkXigfuz8zRRsadGZ+jp+mod3pHszfmanL0f5JkTuLhcL8KjtpvjaVSaNJ/BC/RZvsXapzkVLYElpFOuZwrU1RArAsuyqKTkTaPoou1tZJbIpbnVEQegjKZLqI9qLjvYry61NoHsElJux3DJ2LNoB6M+qUFY4voMj9QPkeoJfrdkJE/VxiYmo4xbFQlRcdd/wr7AjuPO97OMDbz+RlgMv9DtV+G+QJNpBvimyn+9U/iIQVxz+pq5vRWrWBNWnEldzog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9PQ/97dN+Mysvi1WDS1x5ebqRtprxmVyW7oM+/gdXc=;
 b=uiLiA5SwHLCaHwfkDg77J2imVJCiBqjdbivGP6+rEFUD8HkuZvPnVn4ymUaYmb311KakziyV4+t5VermavDZUJu2nR+EbZ+VZSOo9kbh5YWqGhHpRwzpzPV1Yo2r5iaTQO8oZ3dPIaFuhmgvyolxG3RcodFSW1yMeQfiDl3BZl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 18:36:49 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 18:36:49 +0000
Message-ID: <d1986f3f-9db7-4ac9-9fea-56878548ad61@amd.com>
Date: Thu, 10 Oct 2024 13:36:44 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "tj@kernel.org" <tj@kernel.org>, "peterz@infradead.org"
 <peterz@infradead.org>, "yanjiewtw@gmail.com" <yanjiewtw@gmail.com>,
 "kim.phillips@amd.com" <kim.phillips@amd.com>,
 "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "jmattson@google.com" <jmattson@google.com>,
 "leitao@debian.org" <leitao@debian.org>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "Joseph, Jithu" <jithu.joseph@intel.com>, "Huang, Kai"
 <kai.huang@intel.com>, "kan.liang@linux.intel.com"
 <kan.liang@linux.intel.com>,
 "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "peternewman@google.com" <peternewman@google.com>,
 "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Eranian, Stephane" <eranian@google.com>,
 "james.morse@arm.com" <james.morse@arm.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <c79fdf4196d974325df995eb334221463747689e.1728495588.git.babu.moger@amd.com>
 <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
 <SJ1PR11MB608381B9DA3AE26749070BE8FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0fedcbd4-487c-4d55-8151-69dc34f41f1d@amd.com>
 <SJ1PR11MB6083FFA19F9387F21C058A09FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <SJ1PR11MB6083FFA19F9387F21C058A09FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0195.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::8) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|LV2PR12MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: fea362db-9ddd-4448-8f30-08dce95a8077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDJpdCtaK3lFV0RzaG9pWnBIdDRDOHIwdWFyV0FTZzFBMHdBa3ZEQVZlWkdQ?=
 =?utf-8?B?UjZicUo5V3F5VERRc2FpR0l4TEY2M2lRYWxjZElhTDM2bU1hcVZ0TEV6cmNr?=
 =?utf-8?B?Z29NU2kyeTl5V0x0ZkNudkdPYWZidWZ2Q1hDRVJLRkl0SkUxVkJYci9sMkd3?=
 =?utf-8?B?Y1I4ajZuSUZLMmhDRWRacTR6d04zdlEyOG1LTGN0RzYwMXFVenJ0SFZHODVl?=
 =?utf-8?B?cmtkUTlnYTBoNU1KdXRVYjkzZlFtKzYxYldkcHFWSk1ibFRBOFY2MDlpdkZn?=
 =?utf-8?B?dzByUm16ekhHMDVTWGc0aEplZUlhZnVWZmVRcit4ZTR0bXZXM1pUbW1VN0wx?=
 =?utf-8?B?bzd6OTZmOEpGV3hSQ3lELy8zNHUvSC9uODRaOTlpUENKR093SXlEZmx1WGxv?=
 =?utf-8?B?U3pXdFZuOGczcXJWd2xPenVERUZRckJpUHNwSFRHQ2VIOVVpcGx3Mm42WXdk?=
 =?utf-8?B?U2ZOY3BsOW8rVGRTT3JvWU5xUGQvV1YwR21KRG96ZVdHc3pwS1pGd2NmYVFi?=
 =?utf-8?B?aVRQTjlkRDIvMXZ6S1hTWWIxZHh0MG5KWEVreGIyN0Q1cXp6ViszNnBSUy9D?=
 =?utf-8?B?UGx3dmdRQjZ5UUdqMVMyVUtFcy9UeVZXcHRQaTJnR0t4Z2xwaElzdFBuaVFq?=
 =?utf-8?B?MzhOS2YwNEdrYmp4RDBUdTJ4M2lvTHNPWDBJK0RyQnp0a21McUpGNi94VGFw?=
 =?utf-8?B?L2dTYnVnd3lvUmE5TzZJZ09yc3NnSGpUeUdBQzJFTkVmanEveWJGMGlzbFFG?=
 =?utf-8?B?c3F4cVdWcURaazhKRm9tWE15TFZXRFR3bXhaYWRZM01TWDdjRGowcTJsSUxI?=
 =?utf-8?B?ellyU3Y4WXU3SllGSmJSajVYbmZmbHZiRkU1R0JjSWdQQTlCUERPemZTRzJL?=
 =?utf-8?B?N2tpVmlZc0xocnllcDV1K214YTRBZHBFQis4TW0rQ0VjckViSEx0WFU1a3hx?=
 =?utf-8?B?bHFoSkxSQ0lmOWRYSHpzTDRvQ3o3dXdibHNOSnBJS0ZLeHMyRUtxZi8rL0lX?=
 =?utf-8?B?L09tSDdnR1B0ZjNLUnBUT2lGOVZhTFV2VUV6ZUl4TG12Q1hrQ1RoS2JDalZq?=
 =?utf-8?B?RW9tSDNwOFRFeGxTVWZUK3pDbGNVVkZFZmk4RnBNRmloWGVyNnlKY1BIZFZF?=
 =?utf-8?B?bk5oeUhuNTUxclR3VGh5ZGY2dkU1NUNLL2ZEWCthUHp2NldTMmQyZGVBeUhn?=
 =?utf-8?B?QytoVzNWdnVSU3V3WkZvOFFER2lqb3lNZnZQeEVEdmlNd0x1ZUJFUTBuQTlk?=
 =?utf-8?B?VW1OYXNVQnUxcXRzNUY4L3RlclE5NlRsT2hVRFUvbzdPTlZ3MGI0cmJGV2RG?=
 =?utf-8?B?SzNFTm5hN29aSjZpVmE2USt5U0ZYcFd6ZlUvWDliVHU4ZVIvUkRyZkR4U01i?=
 =?utf-8?B?VEpwUmY5MjNScFduMEJTVGE4Z3U4RWZhZlgySFMraUxNeUVSS2J0R0lWRkhC?=
 =?utf-8?B?ckd4ZkxCcDl0N3pKVFFBVE9JRDQzZDNiWk1NMDIvTGEyeUpuaXh5QUJmSGhp?=
 =?utf-8?B?TkIycWpwVHRnbDhrc2k2MFFGcWljd0NLMEFpaUkwWWk0TDNGdCtJellrMzVI?=
 =?utf-8?B?dGtMS3g3YkFIQTVKeXhQaDdsN1pJb1k1bldiU3pWVGtmcTc4dkp2SE0xKzlE?=
 =?utf-8?B?dEhnYndKL09RZ0o4WWtJditad3NKRkRLZ1dCTWNBTk9Pd3pPZVFBTWtMaUFr?=
 =?utf-8?B?SURUZlluN1JVYkdDY3A4ZGRUWFZweWNtWTFwUUFCZEJwUUU2alBCaVhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHdsUGxYS3k4a0FITXNZQVJKMHpyeEZoRTBReVZPSkxXdWN0WjVydVJDdlhP?=
 =?utf-8?B?VUg2QWZydUNuN0ZUZ1hTVE84YlpPSGw1cEltOWN6L3ViUjVkeGdlY01zeHRW?=
 =?utf-8?B?dXh1VlE1OUJRY3JnQjBoeGNBYTY2SHgxcWx5dEIwY0hnOG5DK2JmVHl1Wk9h?=
 =?utf-8?B?TjhQOG5yM3YzUmQ0YTNOYzU1cjRKTlg4WGExYWJQQ3lZcnM5MUFVTXdjNHpv?=
 =?utf-8?B?YkVJMnJDUlZLRG1sbjJrTkJ2M1ZoMkxIb2lRZUFvRTdTM1hrM3d3c2ptMU1w?=
 =?utf-8?B?WHBpWTFOTEVyZWFtcGJSWFZJMXo1aWJkbDBVNnYyejVkOTdoWStqeUFycXN3?=
 =?utf-8?B?MVdRS2kxa2I2ZkVhdWtScGJacGwvb1I0L2JzMDc5eGNRdTdSOXBtQnRXMlRI?=
 =?utf-8?B?V00rM01HcW1xWHRIdUwwdnIzRnJESWVhclR5TTYzajJxZU8wSUdFQ29PdWl1?=
 =?utf-8?B?RDhaZENaaHFMUTdjb3dMbmZ5dlQ0V3Z1b0k3cEo0MHpLa2h3V3FUQnEvVE03?=
 =?utf-8?B?eWZ5RmtZUGI4am9QbjQzcUhKZDMrK3hJb0IreFlTQmYyZ0ZDNCsybElEMkpZ?=
 =?utf-8?B?VFhEanpycGpXeW5zeUtKWFk3cFpyc1doZm14UEVWTmQvVHBpZzZGb09UamJ2?=
 =?utf-8?B?eW5pVXFxeW1pc1lsSFVCMVQxdU5zc2EvSTZ3bTBmVFM1MjlpYSt6bnB2ZjVu?=
 =?utf-8?B?eWZGOUtDSGNFS0E1Z3BDMm02MTBYZ29KUWM0VUV0OTAza0JsNGpZUSsyREUv?=
 =?utf-8?B?SkZPY04yL29xKzI3WDJBbWlObEVhUGEzNWUyaVJiQURpb0dvemlNYlVnVFpk?=
 =?utf-8?B?K3dOK0xPWUhQc2REWEJiUTA1Z0F4cFF6a2d5V1R0ZnRoLzAyK3BZb1gyY0Fh?=
 =?utf-8?B?MVVnNktzRStZT3FLNG5MRm5IQ2xrTWJnak1neFQ1MjZ5Q294M25LNytFa2R6?=
 =?utf-8?B?TkxYVzNWYUV5ZXl4MVJWWXNKNXE4cGZrNkI2STViL3pXL0lkTXg4dHNvQWhz?=
 =?utf-8?B?ZHM3bmMrQjBUekNPcVp0eGJ3elVqNHZQQ1hKQWV6UENYS1BVOTIrS1BCMWZ5?=
 =?utf-8?B?YzJma3REQ0R3UGJUbXFlUmF3SHdBWFJGWWpMWGVBK3AzaUgyNkg2Ylk3Qm9E?=
 =?utf-8?B?NTlGdXlYRDdIZ0hGakVUWTgvZmt1T0NUWHA4c3poNnd1QmhQNU9xaFBUd1cz?=
 =?utf-8?B?VGlaLzBNbkI1Rk1CWkVDMGRQK1lwRkRWV2VNc0dWdnY1alNnQjg4VG1EKzM1?=
 =?utf-8?B?NkwzbTdrQm1GdnZ2RCtJeUplNFBJc1lOVWQ5SWFWT3ZCZ0JJb0xMRnE2bDRa?=
 =?utf-8?B?ZGRNTVFJeTJ6NytYUXJLLzExa2RLMXRmNWlzcVhjOXlLanlEMDNMZHVBd2pU?=
 =?utf-8?B?bUVvRlRaU040TU0wajlzbVdCU0l3eVdFdnZUQmpaT3MzZ21TL3NGUDJ6Nm5B?=
 =?utf-8?B?VnVGNDhQZi9VQXVXeVYyTjFRVDd1RktRZkFuWFEraHRFMUs5b2tEZmx1ekw5?=
 =?utf-8?B?WGQ4d0ZxQ0N3WmpmN2VBcExpMzc4VEIyUUtGcEtCN0t6d1lVa1BGc2lSWjFG?=
 =?utf-8?B?OG9LcHNVSUVZZ3ArdEExcXd3V2xVR0h5ekNMZktzSWNDZnJuOVNMVjdzamlU?=
 =?utf-8?B?aHMrbG9ncjVETG4xck4rRGlteTBSY0JRQ0l0QitIVjBuV2x3ckZLM0tkUUZ5?=
 =?utf-8?B?ZTloOG4xSDlUeUtOaXJLZlh0c0F6L1RLYUlZYmxpU1VhNmJ3VXFmLzVaMkRT?=
 =?utf-8?B?eHFyQTNBVnpDSCtzQ0p3RHhndHJBV216R084RndvbWxSMmRBZHpQU2sxSlhQ?=
 =?utf-8?B?V3I3dUtxNWIra2RtbElqYkMrckJsNVlBRG5ya3ZqTXJha1lwMUN4Ky9HVXZW?=
 =?utf-8?B?U1Vna2lsN1paNmNCYVI1dU9TbExlNkQyMmFRM2lWalRFTkxEUEdRSjByUklG?=
 =?utf-8?B?N3h4NWQ5ZHl4OGo2bXg4Y0ZkbHI2STRyT0pDS3AwY251aWtBcjR4bEpiV1lO?=
 =?utf-8?B?eStDdksrZGJBdUprN29uWlkyaTJDcEhhcTRpNHdHNGZpbW1va1Z2Z2hFZGdI?=
 =?utf-8?B?M2RkbExPNlN0c0V3VVNsbjZ6STRISmd0WEhPVEhaMmMvYm9OVTliN0sycDdh?=
 =?utf-8?Q?Dazw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea362db-9ddd-4448-8f30-08dce95a8077
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 18:36:49.2822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bK0ECKM6AclY1AaGlU4nSLhY0TvyjxCEyQex4sDPFsDD2txQIQqG3mGzM5EQlUhr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944

Hi Tony,

On 10/10/24 12:08, Luck, Tony wrote:
> Babu,
> 
>> We have the information already in r->mon.mbm_cntr_free_map.
>>
>> How about adding an extra text while printing num_mbm_cntrs?
>>
>> $ cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
>>   Total 32, Available 16
> 
> Either that or:
> Total 32
> Available 16
> 

Sure. Fine with me.

> which looks fractionally simpler to parse. But I don't have strong feelings.
> 
>> There are all global counters, we don't differentiate between sockets just
>> like number of CLOSIDs.
> 
> Interesting. So there is no real benefit from "0=tl;1=_" ... you are using
> up two counters, just not reporting them on socket 1.
> 
> Why have this complexity in mbm_assign_control syntax?

Lets take an example:
$ cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
Total 32
Available 30

# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
//0=tl;1=tl;

Here default group has taken two counters.

# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
//0=_;1=tl;

Here default group has two counters.
Domain 0 does not have counters applied. So, you wont be able to read the
MBM values for domain 0.
Domain 1 has both the counters applied.

Domain level application is important.

This is similar to what we have with schemata. You can change the value in
each individual domain.
#cat schemata
    MB:0=2048;1=2048;2=2048;3=2048
    L3:0=ffff;1=ffff;2=ffff;3=ffff


> 
> You could have just {grouppath}/{allocation}
> 
> where allocation is one of _, t, l, tl
> 
> -Tony

-- 
Thanks
Babu Moger

