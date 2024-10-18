Return-Path: <linux-kernel+bounces-371835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 488319A4109
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB981F245AB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38B613A244;
	Fri, 18 Oct 2024 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zr0RR077"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E939A13C8E2;
	Fri, 18 Oct 2024 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261388; cv=fail; b=W8VIGxAU1PAokfK71w+W/H8IAoXiVfQ7+K4nIFzNE+UyvAe4oxUm6AEbyGFBMRct4rXcgeooH1iZCXAC5XTazSOPBI2DQENOBaxUXxaBEEIuI844xxUpFfoaEgbn3rsWJQNdHKxApBnE+rGxCPvYWVn0va8NsD4qTcfn/JkYXsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261388; c=relaxed/simple;
	bh=d6Lbqcrnhv6lbl5t2YXL3MPr5+e7AoxB7Zol6RV/Jqw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lCWSsu5Ou7VEF4TTJtvXV/rxk6W061D6hubIWPm/mbLdUdxhUfUwfQ8gONkeKUnqN+TFWRdrAME2TdoiRLnsMdVuxlaofnSMozosvTsdY+a3wooZBaE4Vt7HHVfsiR2FOIl+tgM1Y/rrLec+eo5ACzgnbQUUGzKIVFE0qywRGe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zr0RR077; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahoH2Sh2VexYn12zcsQugn7C3OQZo0Eg+vVpd8AQpdg0f0dR+w1lLUB3HDr8H9WPIA8d6vHR/z6wWxJDzPvFTCIg1MEAmo9I/qLoZ0lbOIh0pA1OUx+RoN926Y4ucl3mpEDNBuHa5Ta5ij+oZSaA5jxM97900kPRBXmwgjQ/gApBo6HIJJc41MDTyfhlld0AEqpKvT27A4U1EAvsWUVH0GqQ9GTJhx0cG/Twv27NVdRDiYUOo9BnrWhyobnJufb9z0OjNQyIPBSdfSaUQIDSTTbNRX/a7qaCt5Zj3v0LMvNAh6hn0vDjhobs33Dep3hYti6EYaICu+z0DOvD0SJ3LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fYA0+ndttn71lwXBgxqKgJWI58nBGY/ed+ZoXHVy7E=;
 b=Fx08Zkwe9BPjRkMcWzonpO2vTD6t5bxuEkDO+QYOZLO2VuaD/O5IsyBYuT1fftjEFbCQe72OxukVQtOLIyoBps4aDSBHUD8u+Jo8CcNtiBvjgnT9iXN4lQgzBaX0FvMGaWmU44csI0+JURcrzCU2S6aaFBg25oKvU1vVgmvRgmW5NJ9IuUkEMH8kUAGKCEWDJZviRz9ELHu6PNT0Aj3XA/POyxvsHGdl6V0hSXh61oDir4uQ1m1CMx7nw0yZ6e7I7/F4NEcjwIoETKaNUr1y6oOWFrqaXi3jDGEDV391poYRQqCb/shVS7DIvuq3ZA9nkc8XDKNWijV+Z9SpnfIGiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fYA0+ndttn71lwXBgxqKgJWI58nBGY/ed+ZoXHVy7E=;
 b=zr0RR077QckryLt2e/pD1cDoIaobCB9zFpmKHcEa0kNPUAqtBkWWkZxQwPobKesn12tUfni/3jHC29GyV3G0e/s0iBsxY93mBeRGWyP99D5QhhyPCliUHE+FHqDkMUNMwjq0WYhpGI+0Tch3tTexfs0k4n+Nc0sN7zY2pfyVTm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 14:23:02 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 14:23:02 +0000
Message-ID: <766ecc49-555e-6e14-c9c2-6abb076dfd5c@amd.com>
Date: Fri, 18 Oct 2024 09:22:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 19/25] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <ce07d802260f537b24b3affec57c2d2e65023709.1728495588.git.babu.moger@amd.com>
 <6c2a4904-af6f-49ac-b05e-65cba54f81ea@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <6c2a4904-af6f-49ac-b05e-65cba54f81ea@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:806:d1::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: 30414bd7-d512-4a9a-b899-08dcef805ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0thRGVLZkRsQytjcEwrZko1SzIydmErNHUwQmtld2wvYjFxd3pxVHhSR3lY?=
 =?utf-8?B?N1BrMDlUcnFpZkxoRVVmR3M5cjc5YWhCekdHM2xHOGtUeldISUJnYjRTQUd3?=
 =?utf-8?B?U1ZsRm4xMHQ4RUZRMXdEM01OcU0zWXVNaUVYS21nelFmZktHSDFrS3I4Um1l?=
 =?utf-8?B?RzJXb3RoZkkyME93UlZNVnJvRTlJdXkyNnV3VGxEZ0R4SCt0enpFakVpeWNC?=
 =?utf-8?B?K2tQNTc1NUh1NXZaNFRJMTNwTnFzeGdJQmVzUUhQVEpEUTUxKzkwcmFGUG5o?=
 =?utf-8?B?TkhUL1Y2RHZuMXEycmtqakdvRStOZEtwbzBXcDQ3c0FtZjVzTFVnV2ozakYv?=
 =?utf-8?B?c0xwdFZ2RSszeHdZU3JxcVQ4VXlIaUsvZ2UzajN1L3c2WjVJSWZrTUthOHV4?=
 =?utf-8?B?MGJoenRqaXFzUXlkeGllWXdzSmQ4ZWpmZFYrVEsyRFN4RkJZU2lTbGJxUmxl?=
 =?utf-8?B?WktuSGN6Sk84K1lBcXdGSGJzRG1UQzJqM1BLU2tJZG5rUCtoMzdoVkpDdWxC?=
 =?utf-8?B?RytyQzZtRWRqZm9qbWdCamdtbThVR1lPUXVjVSs2NWlyRkV0dDVKekdmcXdK?=
 =?utf-8?B?bzdWcTYzUzMyTk4vSmlnd2RqUllFQXZ5UGVvSlBxVkcvOXFaMUY5dm1tRzRv?=
 =?utf-8?B?Z1ZVVHltWmdYNFp1Q3RLT3hmWllaMjUydzkzb2M0SHhkckVhcGhnZVg0Z1FE?=
 =?utf-8?B?Z056Y0gvSjBiUmNNL2dyOE9xR0syM3V4OCs1UlVIb2VzWk1rRXhjNEliZ0la?=
 =?utf-8?B?Rkhrd3NPemNQUGxFV0UyN1l4eDBBcElRNFBVSUg5RU9kL2xqSWlZWktVTjM0?=
 =?utf-8?B?YUJ2SGFiSXIyazFrRW42K2dEZkMyL3VpUjdNUExDa3FFejI3RUoyd0FBYk5n?=
 =?utf-8?B?ZmhITTdRZnhXNWFnUmlqMko5NDA1bXdTSUZhM011ZmRVRWpVNHBUdTZLMlRG?=
 =?utf-8?B?Nm9KRnIzR1dzOXI5ek5TMWxpd0Y4MDg4aWxqVjNONk1kVFRyakthQTdyWTVk?=
 =?utf-8?B?N2JlNjFhcWp2czZlNXErbFNGdjIwRWY2OUVQUTR0b1V5YUplcjhZZU5DbWI3?=
 =?utf-8?B?Q0JoZmU3ZmM2WW5CZFphZGZ1NEZCZ3NaemRFYmNTM2loOGVFVURKUWYrTVd2?=
 =?utf-8?B?ZlU4QU9UYTFLKy9DSWtSaGYxWWg3bUt1bFJKZVBYWi9uWEx2WFlNYmV2amNX?=
 =?utf-8?B?c0gxUHJJWndybCs4aVpNaHVtQjh3eU9sWEZ4WEI0WFVJc2N6TDNEY0FTNEVp?=
 =?utf-8?B?WDN1eEg3WjRUSG9ucUlyQlY3dzdQWHMweFUybDROS1FDakMvM3Y5Z2U2aFpy?=
 =?utf-8?B?REx3c3FoYmJ2WUI0OU9DdllUQWFIVVFSRWJtZEJYbWdkOTZGQy9CRDZRa1hv?=
 =?utf-8?B?Tkhxb1hlZ0xoMHM3QUtwbDdka2pGcHE4a05yejRIbEIzVjgzblVlY01QQUVR?=
 =?utf-8?B?UzRnMWhuUWhDY05TN2wyMXcvalR1UmJ5dVJjUk9YNmZFUG9DV1laSWFZalov?=
 =?utf-8?B?MUx4QVFwdTlJVHM4QkdFZzh2M2pXd2hwTS85b3BLUDRJb2FqU29OMnM4Nlps?=
 =?utf-8?B?L0JqNjhFMkdsbzMxK0s5aUdTemtJK0NJMGtuQXVWb25wZEJYOXlBWTM4Qmtx?=
 =?utf-8?B?RWRBYXBnSzFZTkZGZUVNNmJoaGVzVUdJZXI5K3BURE1zWDNIeXdRaDdXQTRm?=
 =?utf-8?B?c2QyZVo2cUR6ZTZRTzF2RlR0eWhxakFvT3BLSHpQc29UV3k3NGZucVI4V3JE?=
 =?utf-8?Q?sWJCPOMfZ34xcB9XoJTwscOJRVHfZWxDMhN+sBu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGI1Q0diL0RnalFxL2dGYkJTQVVzUmN0MGJrQXdVblZIVEdkNHN0cE5hVXBQ?=
 =?utf-8?B?dEVuNlBsVEY5bUdkSHBZMjJqZlVVOGZMYzFIeUQvb212Q1lEMnRIV3RmMnhm?=
 =?utf-8?B?aFQvZGZ1MTdSK2xhMUdmNTAxb29BYVFMMnFncGV6bHhZeWxnV3NCZEtDM09w?=
 =?utf-8?B?TEJCL1p0d0twSHJ2Nno3MzBEdVJBc1RIbytQZDlFdm1Ta29jWVd5T09SYjFO?=
 =?utf-8?B?ZEMxTlk0NnltYlBKQ0E2MmNtek1JZGI0SUFiait2cjdjZ2lWZ0syeGtNZkFh?=
 =?utf-8?B?VUVqL2dCWmxRUzc5TW9acmxuSzVPK3cyOVRwUUtoOGdTZ1lIYXVHa1NWcnRG?=
 =?utf-8?B?U0hqd2ZJaVdlU2hUaUZhOTZkWDdrYmIyNDA3cnpaa1JvdGFQcURpcnJCOU1r?=
 =?utf-8?B?VThhVHJXajFlamdEVGphV3B3ZitHdFAxWktqZ01aZWlwcFg0LzZNWlBLdHlJ?=
 =?utf-8?B?S1FTV2xiMVFVVmt2VVB0YUp2blJlS2hVcithMFVvSVJMVW9VWElJZFBpaGlU?=
 =?utf-8?B?OG9tYXc1NlRra0lPbUYxdnlMNG05OGR3b0lSZVhFOENmNUNieVlqRitxSm9L?=
 =?utf-8?B?emZZRmx4dnVZb2RIK2tJOTJuZ1J5ZXZWbUx5NTdZVEtPUXNSbU84LzlRbElo?=
 =?utf-8?B?RzIxL25TZ3FBRnZ4N29OOGtQN2tpNW50MHpNOWlPMEtBckpLQXc1ek50QTZr?=
 =?utf-8?B?MHJnWTZpUXJJbXFFdStNLzB5TlQrTlREUFBMRzUwaFZwdTgvMVlHeHBCOU1I?=
 =?utf-8?B?Wjlxd011Nkx4bUg1YUJTamRJeDVoTXphVFFiS3B5ZDY4MWVENGQrVnA2RW9Y?=
 =?utf-8?B?cTV1UHB4QzYvT0NxR3hXaWlBUjVKUm45MmFpVjJsaTFFRTlSMkUyRENESGFo?=
 =?utf-8?B?OEc4dHN2ZGY2bG1IUGUyNG5Lek40OFJqWmVRdTBST0ZldDZnRmQrUmVmdDdZ?=
 =?utf-8?B?TWlwK1BkeDhxTjBDdUJLSW1qUkZFY1IzdkJ0ZWJRM2FnRGJoQ1lnZ0RwOWpV?=
 =?utf-8?B?L2Jha1NlSEZVdm5VWTFzMktKRWhRVndIQlpnamhreGVUNVhvSWVnZVZ4eitL?=
 =?utf-8?B?RVp4Zmd2Z2ZBVEZpd2VSZUVBMFlZY2VyM2xLbllrS2FSZDc0dkR6VUNhN3pT?=
 =?utf-8?B?QnNxQ2RTNERKLytmSXBIU0F6UHAreWlndnEydkhaU3R1clJFTUd5ZkFxVHl5?=
 =?utf-8?B?SnVVbEY5Z0FEOW1ObFh3M2oxbW0vaGFkaG1TckNJN1BQM3RSakJzT24ycHNK?=
 =?utf-8?B?T1d1UURWL1ZyeHdySlVmVW84cFJEVzNYMWt6UmtYQ2w0UGxJcHdCaDUyOXRl?=
 =?utf-8?B?Q2JmcHl6eTZvTTExTFRNcHBtbjRlS0tOc2hvMS9WOHpTcHVUS1FoNWh4V3lr?=
 =?utf-8?B?TEJzek1RM2dDeTlyL1Z0SWMvU0w3clNBdld3U2Y5VUROQzJGVUR1WXZJRWE0?=
 =?utf-8?B?QmxURjB1U1VRSXJJYlZ3djFVTysxVGhsdzlhV3c2WDN0SFdvNzl1QkVDYkxk?=
 =?utf-8?B?L3FneVZiMFpreDJ2WXdjOXpBWEY2MElSWWhCZTd2VHFPTktMTnlYNDQ4c25h?=
 =?utf-8?B?RGdPUUx4b3FvSjRCRW44NDdQVCtMRE9SNFl6SHJES2hQcllkRXBsRFd3VkNK?=
 =?utf-8?B?TVJVWUpNWHhTc25mVndOR0U4bnI2WHA1cGs3Mnp2UWVsM2RkVVYyRDJVWEZs?=
 =?utf-8?B?T0JKV0MxaDBnZzZGL1FqQ2NhZ1dld3NXWklGM0V4MUNiL3lOSEpmMVM3b1pQ?=
 =?utf-8?B?MjY0SjA3M3hkYkZFcHlZQTliWE9CSEVwTlRmZmdVeWlmbDdBQ1BVVFNKbmVW?=
 =?utf-8?B?UWRScEs4QU5Ua2Z5Z3hDdUdJaUttZDAzTzE4K2lCYVhBeDllTXhwUzYrUlVs?=
 =?utf-8?B?QkxzWjgzS3J6NTJnT0sxS3MvdkJMbHRJMHA0azJYYlJNZVA5clRlTlljN1NW?=
 =?utf-8?B?MGVzUDhaWFNrdXNUenR0VjBocUl4N2g2QWFaODhwVUZvSzRoaTJ2RVpNNjRQ?=
 =?utf-8?B?bXFrd241bGNUUTg3RE0xMkx6Lytmb2lJOThLTWc3WG5EM0xFcXI1LzlxNjNm?=
 =?utf-8?B?SXErTDJpdDhDRXhkTnlENTVDRGNMWjJqSGRVbzlISGRnV2w3dnVaQ3c5STJV?=
 =?utf-8?Q?jjlk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30414bd7-d512-4a9a-b899-08dcef805ff4
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 14:23:02.6634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjCQbzvkdnmjD+F6wnxrYbnLO1JL2Q7762bsoLCRKb8KSlTH8a2Ad8ZuQLgm49BU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9273

Hi Reinette,

On 10/15/2024 10:30 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/9/24 10:39 AM, Babu Moger wrote:
>> Assign/unassign counters on resctrl group creation/deletion. Two counters
>> are required per group, one for MBM total event and one for MBM local
>> event.
>>
>> There are a limited number of counters available for assignment. If these
>> counters are exhausted, the kernel will display the error message: "Out of
>> MBM assignable counters". However, it is not necessary to fail the
>> creation of a group due to assignment failures. Users have the flexibility
>> to modify the assignments at a later time.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> ...
> 
>> ---
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 64 ++++++++++++++++++++++++++
>>   1 file changed, 64 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 791258adcbda..cb2c60c0319e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> 
> ...
> 
>>   static int rdt_get_tree(struct fs_context *fc)
>>   {
>>   	struct rdt_fs_context *ctx = rdt_fc2context(fc);
>> @@ -2934,6 +2980,8 @@ static int rdt_get_tree(struct fs_context *fc)
>>   		if (ret < 0)
>>   			goto out_mongrp;
>>   		rdtgroup_default.mon.mon_data_kn = kn_mondata;
>> +
>> +		rdtgroup_assign_cntrs(&rdtgroup_default);
>>   	}
>>   
>>   	ret = rdt_pseudo_lock_init();
>> @@ -2964,6 +3012,7 @@ static int rdt_get_tree(struct fs_context *fc)
>>   out_psl:
>>   	rdt_pseudo_lock_release();
>>   out_mondata:
>> +	rdtgroup_unassign_cntrs(&rdtgroup_default);
>>   	if (resctrl_arch_mon_capable())
>>   		kernfs_remove(kn_mondata);
> 
> I think I mentioned this before ... this addition belongs within the
> "if (resctrl_arch_mon_capable())" to be symmetrical with where it was called from.

Sure.

> 
>>   out_mongrp:
>> @@ -3144,6 +3193,7 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
>>   
>>   	head = &rdtgrp->mon.crdtgrp_list;
>>   	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
>> +		rdtgroup_unassign_cntrs(sentry);
>>   		free_rmid(sentry->closid, sentry->mon.rmid);
>>   		list_del(&sentry->mon.crdtgrp_list);
>>   
>> @@ -3184,6 +3234,8 @@ static void rmdir_all_sub(void)
>>   		cpumask_or(&rdtgroup_default.cpu_mask,
>>   			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
>>   
>> +		rdtgroup_unassign_cntrs(rdtgrp);
>> +
>>   		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>   
>>   		kernfs_remove(rdtgrp->kn);
>> @@ -3223,6 +3275,8 @@ static void rdt_kill_sb(struct super_block *sb)
>>   		resctrl_arch_disable_alloc();
>>   	if (resctrl_arch_mon_capable())
>>   		resctrl_arch_disable_mon();
>> +
>> +	rdtgroup_unassign_cntrs(&rdtgroup_default);
> 
> Unassigning counters after monitoring is completely disabled seems late. I
> think this can be moved earlier to be right after the counters of all the
> other groups are unassigned.

Sure. Right after rmdir_all_sub().

> 
>>   	resctrl_mounted = false;
>>   	kernfs_kill_sb(sb);
>>   	mutex_unlock(&rdtgroup_mutex);
>> @@ -3814,6 +3868,8 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
>>   		goto out_unlock;
>>   	}
>>   
>> +	rdtgroup_assign_cntrs(rdtgrp);
>> +
>>   	kernfs_activate(rdtgrp->kn);
>>   
>>   	/*
>> @@ -3858,6 +3914,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>>   	if (ret)
>>   		goto out_closid_free;
>>   
>> +	rdtgroup_assign_cntrs(rdtgrp);
>> +
>>   	kernfs_activate(rdtgrp->kn);
>>   
>>   	ret = rdtgroup_init_alloc(rdtgrp);
>> @@ -3883,6 +3941,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>>   out_del_list:
>>   	list_del(&rdtgrp->rdtgroup_list);
>>   out_rmid_free:
>> +	rdtgroup_unassign_cntrs(rdtgrp);
>>   	mkdir_rdt_prepare_rmid_free(rdtgrp);
>>   out_closid_free:
>>   	closid_free(closid);
>> @@ -3953,6 +4012,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>>   	update_closid_rmid(tmpmask, NULL);
>>   
>>   	rdtgrp->flags = RDT_DELETED;
>> +
>> +	rdtgroup_unassign_cntrs(rdtgrp);
>> +
>>   	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>   
>>   	/*
>> @@ -3999,6 +4061,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>>   	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
>>   	update_closid_rmid(tmpmask, NULL);
>>   
>> +	rdtgroup_unassign_cntrs(rdtgrp);
>> +
>>   	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>   	closid_free(rdtgrp->closid);
>>   
> 
> Reinette
> 

Thanks
- Babu Moger

