Return-Path: <linux-kernel+bounces-222745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 942A49106AA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1F66B228EB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB191AD488;
	Thu, 20 Jun 2024 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EtSj5dij"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4201AAE20;
	Thu, 20 Jun 2024 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891332; cv=fail; b=uPNd4LdszHjn2yT/me5JOxBJcvkb4/fxyRvf/RsKiKeCb6uma/GOlP6uv/nB3+1S2D5FgJUSQpyaqOgLfW5fBZm9TnTmp9lKgjnZtPUjns2hkODWigIFo/BC9LDcioNy882jK3j37jUAfIaSw0jYfrmf45iswSiMAqoF6668Ay0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891332; c=relaxed/simple;
	bh=eatYgpHw51qlq+CTp+VIq63wuRg7lZGmBVvVGYKFgBw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M+aEfJlVzvWAAf6xTfDxctur7VWtawVmr2M9yOVX40P/kP69RTcIk9WIhxRMAy2niMopznqraYpYkJ3kqDVd3GRuY65IIbdtFZO51SWrQn1hzm7q/NTbJrN08jPjoRpVcMOQ0eEOXktJVncvoecxClFQD7vxG7zJWnlFZgB07rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EtSj5dij; arc=fail smtp.client-ip=40.107.101.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRkkqod/np8IfmZPuqHvJJztnhXUXu1vCUtS1FT37Emd9HD7MT+4EMG0ZzxWc1ILmkRh7Udq/suOJ+iRu1LSthEFm7VHnOP3T8XMZUcD9dnEQgvU21IjGq3pT1Jlb/4ofz9sCyvO8A4Ve0drPhpMAHqqkGtGwS25VGBqXwvYpDHpPKB17G+dVpRO6We19W7nwywqHD9g8N9fHRRp28mQdeyK5O+hOKABOOzB52m9XAyXjQ4gler5rvGP7H9k7BFBA23cinva3RVUnEC4xu/jrad/VTk5yZH8ClsCPwgfMMWcM8bvCo4rpfXYG+D1xI+u74S/0hPOxsdeBSw5XPjPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUo1jXLrGBdwuvDPgTYrv33EI8fl2RYMlzyDurTJ2GU=;
 b=lKFSXEIaJPnsNgmeCl9D5+DPe8UoorySt76EGp/qqd5+KNXm+WR4TDzUlgm5jn0wMOwCcIPcvue/XYS3moP1HzhElZbRvadltf6TeU8bv3tlzJiboVcwTYBv/EafIeOKEU6XzaJm7Vg51bsl7Z5z0sAs6V0rEBTEl9ExMV3Agt4gYI6DsdVSDsuk5Gld8CgvQoXDUczOcpSmtJeb4jsZjmAZQ3gP4j2+TnKpF9JASt/Gr8Bg3eF6i/vWSl29sQaUQZz96oH/5PSBQKcws5rXoHQmCfVPLUGD60JnXJ3ZQYq5evan+Mb0M8/45dCbiKLjtjbwoN8E7bQF7UbTdyh2iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUo1jXLrGBdwuvDPgTYrv33EI8fl2RYMlzyDurTJ2GU=;
 b=EtSj5dijjoA7kQmr5jRjXK1A5m98AjzTCO8WCTwpD3PGaEG7rpchwyO6mgIMeZovXblGnZqrIAN1idybhGul5QUKuB98PuxLDjwGaO5JyolYEHB8806EUCDvtCrCsXUcdwu4JxA3wxwFqk/0/ueDb9aQjMkcz814lT/+yNdTh8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 13:48:46 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 13:48:46 +0000
Message-ID: <16e22ce2-6567-458f-a9a6-6bd79dfb9a23@amd.com>
Date: Thu, 20 Jun 2024 08:48:41 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 15/19] x86/resctrl: Add the interface to unassign ABMC
 counter
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <1964d74c24b041e5c9589040701a6f6aaa839e19.1716552602.git.babu.moger@amd.com>
 <333339e1-5b94-4fac-8d18-f18c7780e6e1@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <333339e1-5b94-4fac-8d18-f18c7780e6e1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 49716e96-7ab6-4219-126c-08dc912fb4fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|7416011|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnUrcTlGSkxERklZei9PUHJjaVVWSXpHMVA1QTVranI5b0dINmoreTZpS0Fi?=
 =?utf-8?B?TjB3Y0wrcUIrdktzMlpQUjRaMkNCeStwVGQ4UjNnbHRiWWVPMDFUZCszZnc2?=
 =?utf-8?B?bGNwZFRUUnA3SzhLTy83N2E5SkVhQmIvN0pFdEJMR3dCMUpoU2thbjJyOXVu?=
 =?utf-8?B?MjlBZXIzQWF6U3hBMXJQa0FLOEdWd3ovRVdtOWxBNmZ5UzFHaldibnFUTm9u?=
 =?utf-8?B?R0VHMWR3T25TYUgrV0JBbWlPR25VZlc3dndJeFZ3aTFsTlVVZ0pSZDVWRW9E?=
 =?utf-8?B?eDB5S0ZhdkcyVktjQVE4bG5Uc3Zoczg2TFgrWitXNlBpTDc1TUVQMmdFaHB1?=
 =?utf-8?B?a0JRME9yTlRZdVFFcDhLWGNkUHh0L3laQ3ExUTE4L05LNWw4RDNHdFhBK3RU?=
 =?utf-8?B?T1hYTTNwVHUxajBrMDRyZnJDWExSZDlTelhmSy9LWCtRVUltQ1lPVG1HOUlR?=
 =?utf-8?B?cVF6RExnNlFTNHhhZHVUMkxxTVNCMkRrdGw3b2dSRHJuWHdHS1ZqNklJTVhU?=
 =?utf-8?B?ZmxQdDNISC9wY0paRWJ1VjhXdEJ0VXhmdy8wSGFBWEFFdHVuTWZEVXVGOGw2?=
 =?utf-8?B?Y2RXOEF3enk4eWF5NFBQSHdjMklXMUxpUkVwUHdrQllhMWNkQnRoRGdiQnh2?=
 =?utf-8?B?T05yLzI4VjQ0STN0WmgrK3V4R1ZKRjlpcHZVaTRiWEZLdkplRjhSS2F1WWN2?=
 =?utf-8?B?SXh0Nk5kd0hHWEhPUE5xKzhsMjNUbEd6RHRIcFJ6ZnoyNEFnSndWandPemp1?=
 =?utf-8?B?Z1I3TitwdnUrNy9PckZpUTBkdW1KVHlXSWhCSzhzajFPY0kzWFg5UGVXMFVv?=
 =?utf-8?B?aFhtM1dOeGg0T3J5ZUpkRFBycGZBa1BBY1RpdEw1Umh5QkMxMHU2OUlNZnhF?=
 =?utf-8?B?MDFsRlhHSEVmejJmRGNGanAwRWJ2NEk1ZU1tUHhiS04vY0cvcHNzb3FKejFH?=
 =?utf-8?B?eVdacnd3SWtYc3g4RCtubXFUdER2ZEtyaldtTzlyMjd5S3F5ZEc5RnFBamRm?=
 =?utf-8?B?Zk5xMFJPbk9MSnZST3FZeVpPcGdBdjBmQmkzeWphaFlMS3NnSGFoNVBPZVYz?=
 =?utf-8?B?UVM2bGJVaVoydm9oYlhZc2Yvdlc0Rm81MkVRNWk1Zk5YdWxIeVVRbk82OTlD?=
 =?utf-8?B?QmFlZEZRM01oMStXTDZnM1g1NkhieE9mS1N4UDNrQjQvdm1YcEZMcmhFYWtU?=
 =?utf-8?B?U1lrNlJKSlduQ2JXS0ZYeEw4TTJyZllVMGl6MlhCQmpXR2ZHRUVPV3dTTzJk?=
 =?utf-8?B?aXFEa1d3K3JwTGhPbmNHRy90ZFRsNEFvdkpnK3dRVGdlQlZCd0tiY1U2TWsx?=
 =?utf-8?B?L1F5eXFCY3I4aGdzdEV6bFhsWUNvRFRSbjBWb1E4akFiNnRlRFVwYmQxakoy?=
 =?utf-8?B?K3VMWDFHL3p6SVQ3a0t0KzBjbjk5RnhSYldhV1VrYkJ6S1ZRZXV2YThkOGFD?=
 =?utf-8?B?NC9UTmNSWnhIelJlZkhXT2lIRlM0cXQ3VGkxUTNnSmJHLzN0Ni83Q1BrdEZl?=
 =?utf-8?B?c1YwWnEyTmx6NnFybU9hZEV2N0VFaUNXWHpCTW9TVk1PWEZZa3RQaklJYWUz?=
 =?utf-8?B?ODlkTEFBSmp4Rk5ZNk95aDFhSUllc2RuM1Z4ZmRQTHJuVzZmZ2Q5NEtBeDgz?=
 =?utf-8?B?VG95TXR1TkNZVUNVOXlKaG9QTG50dm45Y3B1NitDZkxqc1BsT0RYa3liRWVN?=
 =?utf-8?B?clNmcm95ejgxclVRZ050a1BwVHl3VThDZllHRmFtaFE2eVZ4aS85UEt3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(7416011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ai8xM3NQdlBpMmVkRllzS2VMK2R5SkV4V0lQUm8wRlZNTURLU3J5NU4rWFM2?=
 =?utf-8?B?a1p2NnQ5b2VBenJCakJUV1h2L24rUEZpeVcvNS9IY2VFb2pvOVpGMGNTM3Br?=
 =?utf-8?B?S2VWZmUwTERvNjN2YVkvaS9JaFVENk1uRkRxK2dReTQ1eFRiTnlieFZiZ2lC?=
 =?utf-8?B?cWw3T0FHb0JlL296cEd5U1ZIR0ZWSGsxb0haanUyeVJoeGY5djJheERmUFpr?=
 =?utf-8?B?a21NRFc0NlJGWU1RTkdia0hHdFUzRFdyenVLTkMvUmVSb0NrQjRJTXdJQVFs?=
 =?utf-8?B?QzdUODN3b3NZUDB4dlRRbzIrQ2doTC92SXZacXptalNOMHYvZ2xneDNmazFn?=
 =?utf-8?B?aVRNclpET2ZzdFMxV2R4S3dZS0FGUUkyR0FRUmw2eUlyWStFb3JKSzcrc2Fl?=
 =?utf-8?B?T0xBckMrd3BnMDBESjhBbzhWV2hvaGM3QXZGdkd2TEVkU0swOTNpVFhia0p1?=
 =?utf-8?B?bkx5Q1VCZDI4Q01TUVJFcTZvbVBxMGlSOXF6YU9FUGdNekg1MkltaGtHcjhh?=
 =?utf-8?B?RHRpYWxhRFF4dkxzVXA5SHFlT2lpaW0rZFdHdkdXQlNoWnhlVGlOVjE1QWVk?=
 =?utf-8?B?a2F0VnUyajRiTGdwdStBSnhqeHVzOGx5WTZyV25vWlRWUVZJRXZtcS92T3hE?=
 =?utf-8?B?cmFPR0MzaFQ0YTNpVHg5WHJ2cXRxUXBZRjNrOXRmSGVlKzRYUW9ZN0tKN1or?=
 =?utf-8?B?MEwweTJvVEYveEluNzl5d1ZsZTBQS1pmL0hxcEN6VzNibm4xNjhDdmpEV0hH?=
 =?utf-8?B?QVE0WjMvOXZhMk90VjdzZFVmbXpZNVVkVUJFQ29iNzhidCszcndQaVZXNThW?=
 =?utf-8?B?Zlh6cWxZakJSb1l2Qm9KcU5OSXRyYW5FOFpzTXhCYi9TYkdLN3o3MC9QeVpo?=
 =?utf-8?B?bncydGE2ZS9QUmZ1NHFNTUxidUhXaHU3R3JEUHkxT3FHSkFGQzUvditYY0sz?=
 =?utf-8?B?bzE4RXpVTXBEQVdiWU1tKzE3QkcyNmRIQWEvQ3dyVGFTSVBwZmMyZ1dCVXNn?=
 =?utf-8?B?SEdzK3IzU0c0Zm1iT1dXdTlaamJNSUhkV2NBUEpmeFk1ZHl1aXhxWEVzbUIv?=
 =?utf-8?B?TmRGMzJlWFZja0J6WWRYbmJIdXdRU0JzVXBUME1aUStFeVNUcmJJdk5Eb0tQ?=
 =?utf-8?B?cjEzOVJVZWhETHZXOVJ5MUVYbFFnTXRSMmpNQThKcUpsZzBkUkdwWVlydENt?=
 =?utf-8?B?MU9iRnRWeHcxRXk3ZlFIRmVBZyt2U2NmSFFtSzE3SlFKWHh1L3AxQ1lIdzBE?=
 =?utf-8?B?MjB6dWhiS3RvUWhuTDVlUzlPOXJzUzlBOWdMditKZHhKRU8rM2VnYkVubFVT?=
 =?utf-8?B?SE9rQzMrQzdFVWRUVndFckRZOW45dTV0UmV1N2x2WnBUeS9tK1BYd3M5NXEw?=
 =?utf-8?B?QXN5YnZ2M2pVcFErbUZYRDlkY29SMUZxVmw5Y2NKbkNNekt3N2VVc1pySHZP?=
 =?utf-8?B?OU1LdDdUZEU1WE13dU1kNkhlMnJrZVJtMmNNSjNJeGY4a3ZtVENJUkJuaDJk?=
 =?utf-8?B?OExFZmlxajBnY0J4MW9ZZEcyVDdSV2ora3E0U3ZHNGFtM2RXTlJYWHdRdzVj?=
 =?utf-8?B?OGkrQmdoMUgrMDNLa3lCNTNiSHk4MW9wa005MzFvU0M1RTZPMFc4aGlNcjdP?=
 =?utf-8?B?T3RvVElnN1lVTkRRT2VqcUsyaEpsKzhmWVIwV3VIUjdBTkJ5WDJGcS9FVVly?=
 =?utf-8?B?MzRTMHRTWnVabkFrbXd6VGgvMGQwc1Fsa2lxanM2VzV5aDhlZEpScGhjQXBp?=
 =?utf-8?B?T2FuZzNkVGZZbHc0L2lrcjRrVnE1bUZLMlZveUJyZHdjYkF2R0Qva0VWb3RR?=
 =?utf-8?B?R1BxamRjSElVMS9xajA4M1ZibjFzOS9xV2NERVVjclk3UXFEYlJ5b2JLS1la?=
 =?utf-8?B?cS9pOEptcTBST05kWUNmcmtaSzNrYktqWjhsS1RIRjVjN1BWV2hIdlJYVll5?=
 =?utf-8?B?RjVmYkNiWFV5MHNKd29Vc0MwRHgxckRzMndmOUlaTzloS0FoQnJ4TmtxUldr?=
 =?utf-8?B?Z052UlYvSTJPSVJlZFlTOUhHTmhOSXRRVUM4bkRJSFh1NVVxYXpzR21rekg0?=
 =?utf-8?B?cW81NGF2QU43clpNa0dzWHJ2OFJsb0JJSEFCcEdKbmtHZmdPVXp3V2NuSkY5?=
 =?utf-8?Q?pD9I=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49716e96-7ab6-4219-126c-08dc912fb4fa
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 13:48:46.7476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDaL0LxFYHtpPTAXP+8ZmedIJN4IUKFJvndYkKcRmePNXiNiVYz66r8DR9z0ikKf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721

Hi Reinette,

On 6/13/24 20:49, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/24/24 5:23 AM, Babu Moger wrote:
>> Hardware provides a limited number of ABMC counters. Once all the
>> counters are exhausted, counters need to be freed for new assignments.
>>
>> Provide the interface to unassign the counter.
> 
> Please write a proper changelog. This needs information that explains
> what this patch does and why.

Sure. Will elaborate on this.
> 
>>
>> The feature details are documented in the APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>      Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable
>> Bandwidth
>>      Monitoring (ABMC).
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> ---
>> v4: Added domain specific unassign feature.
>>      Few name changes.
>>
>> v3: Removed the static from the prototype of rdtgroup_unassign_abmc.
>>      The function is not called directly from user anymore. These
>>      changes are related to global assignment interface.
>>
>> v2: No changes.
>> ---
>>   arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 42 ++++++++++++++++++++++++++
>>   2 files changed, 44 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index a88c8fc5e4df..e16244895350 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -660,6 +660,8 @@ void arch_domain_mbm_evt_config(struct rdt_hw_domain
>> *hw_dom);
>>   int resctrl_arch_assign(struct rdt_domain *d, u32 evtid, u32 rmid,
>>               u32 ctr_id, u32 closid, bool enable);
>>   int resctrl_grp_assign(struct rdtgroup *rdtgrp, u32 evtid);
>> +int resctrl_grp_unassign(struct rdtgroup *rdtgrp, u32 evtid);
>> +void num_cntrs_free(u32 ctr_id);
>>   void rdt_staged_configs_clear(void);
>>   bool closid_allocated(unsigned int closid);
>>   int resctrl_find_cleanest_closid(void);
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 48df76499a04..5ea1e58c7201 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -216,6 +216,11 @@ static int assign_cntrs_alloc(void)
>>       return ctr_id;
>>   }
>>   +void num_cntrs_free(u32 ctr_id)
> 
> The name does not reflect what it does. It neither frees the "num_cntrs"
> information
> nor does it free "num_cntrs" of counters. How about "mon_cntr_free()"?

Sure. If we change the name of num_cntrs to mbm_cntrs, then we can change
to mbm_cntr_free().
Here is the comments on name change.
https://lore.kernel.org/lkml/62fe683f-3a4c-4280-8770-d2aaff478d33@amd.com/


> 
> 
>> +{
>> +    __set_bit(ctr_id, &num_cntrs_free_map);
>> +}
>> +
>>   /**
>>    * rdtgroup_mode_by_closid - Return mode of resource group with closid
>>    * @closid: closid if the resource group
>> @@ -1931,6 +1936,43 @@ int resctrl_grp_assign(struct rdtgroup *rdtgrp,
>> u32 evtid)
>>       return 0;
>>   }
>>   +int resctrl_grp_unassign(struct rdtgroup *rdtgrp, u32 evtid)
> 
> Same comment wrt namespace. Also this function needs a description.

Sure.

> 
>> +{
>> +    struct rdt_resource *r =
>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +    struct rdt_domain *d;
>> +    u32 mon_state;
>> +    int index;
>> +
>> +    index = mon_event_config_index_get(evtid);
>> +    if (index == INVALID_CONFIG_INDEX) {
>> +        pr_warn_once("Invalid event id %d\n", evtid);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
>> +        mon_state = ASSIGN_TOTAL;
>> +    } else if (evtid == QOS_L3_MBM_LOCAL_EVENT_ID) {
>> +        mon_state = ASSIGN_LOCAL;
>> +    } else {
>> +        rdt_last_cmd_puts("Invalid event id\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (rdtgrp->mon.mon_state & mon_state) {
>> +        list_for_each_entry(d, &r->domains, list)
>> +            resctrl_arch_assign(d, evtid, rdtgrp->mon.rmid,
>> +                        rdtgrp->mon.ctr_id[index],
>> +                        rdtgrp->closid, 0);
>> +
>> +        /* Update the counter bitmap */
>> +        num_cntrs_free(rdtgrp->mon.ctr_id[index]);
>> +    }
>> +
>> +    rdtgrp->mon.mon_state &= ~mon_state;
>> +
>> +    return 0;
>> +}
>> +
>>   /* rdtgroup information files for one cache resource. */
>>   static struct rftype res_common_files[] = {
>>       {
> 
> 
> Reinette
> 

-- 
Thanks
Babu Moger

