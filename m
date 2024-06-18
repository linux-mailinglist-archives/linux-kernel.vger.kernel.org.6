Return-Path: <linux-kernel+bounces-220196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E0990DDF4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059AA1F21BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888E8176AB0;
	Tue, 18 Jun 2024 21:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AmF9IhJC"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9601741CF;
	Tue, 18 Jun 2024 21:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718744625; cv=fail; b=TAOP/CNAeKKlr43QdcrBewc7825wgggxlNNnI6HSnJd7v20JU3ZinHq5EnjnkPEIni2m7iLaZLXTAKpAahdPWiWwECHwpKcxKOP06au81d1PePraK2o2QINupGlGJcKI5+3Ar+boklBg1RcwX9CxAfzXiqEstWp3sAN4PXadX6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718744625; c=relaxed/simple;
	bh=tHINSMwqkw+l6Aq/vCUTI7NDS06vK+gF2nFrsgWbGcY=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SeCIAfyerObxqlY4gnNDDstCEJfoCjT/6lkfRkBL7C6xYX0CCm+wIi5puAzflOzXacXTpb5Nx8zxHZyRHvKwvr/xk9hjGRy/zpVDFeLyQaN82zDabvZnYLiU++4AWAzm1/PlHdQ0PjQwcYHiofkIQN/0/wsrVYXuC0F5Iqmgtxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AmF9IhJC; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLeuU8S2WCuDMBCkEqPT+A7lwQQ3Ot2L8/wrFRIhDl7O+hOk+bS72xKzeSN5LAeVU0UpIl2NWzN1zKX2PXng+uroabI7bB30t4LD4hSemFqog+b18evonN2tRt4DfqCxr2ekr2FBuQBtotXVJehxuANJO/LPu9jnJynUKbCeTxhViYG3SmPNA38iOzBLuf4Jn1Pn3fY8tOj+rnzRK/2UR8GlJ57Z2zLFEv2riD4nT+w6Y7ZeYSvcpqH+itLZSLP/cqw+g7152/6iLDszrusos/iRVwKReEVVIlcXlyZu3AeAu/KZLpAVAaAWTwrvdrPUMk+sNvTHCgEhteNfq98Oow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ztp3rztCIin36Uxl5Ng0foMo1Ni82WhDSAcSfOCP/V0=;
 b=Fr9VoIuRXZXdsN1WU0pE9w/RrRcjHrPBEmXGGj4PD1hdaj/KncdkK00Qyrn6QENIz8yzkTRw+0wyWAqL5/7udBAN8XofNbzONyqMaZ3NFzq0GUPElh+ZlcpOr4ii7YsFYdGF3wDdNA2LALF6z0tn4OSjFBBs9EKHookpm69T8jI+TPh7x9fdJgqBVNSryYiAhxNJwECnIEy3AeraDvwuEvOLgNPWPessCGCgEOwAKpCa3KiE8JAhysrc3HEB1iJCGX8z9E6NWzn88GdcmGjDx7uPPeUfk+ARhvQtM6FvbJPcMbObKiKI28umVBMoeEKcJtdvku3zjfCLqNp1+iYOLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ztp3rztCIin36Uxl5Ng0foMo1Ni82WhDSAcSfOCP/V0=;
 b=AmF9IhJCByEOKMFenwTwiJrklnHiWLfa585t0bs5bojHNY9z9zHBISxv2L1JcGSDal6vYQ4NkksajAMWgivrm880J2lV5Jm49D1z+El9YYSgLxlxcJkyQ6DU/VM84REcGeMdSM2BgrySHecrpRu1G0ck3gdVcjspoxV4oLt+plU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB8925.namprd12.prod.outlook.com (2603:10b6:a03:542::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Tue, 18 Jun
 2024 21:03:40 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 21:03:40 +0000
Message-ID: <c9c06c1f-a12e-9b73-5808-0761c3a127b0@amd.com>
Date: Tue, 18 Jun 2024 16:03:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v4 05/19] x86/resctrl: Introduce resctrl_file_fflags_init
 to initialize fflags
Reply-To: babu.moger@amd.com
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
 <67c8cd614925496971496a8fab7459cf5c037652.1716552602.git.babu.moger@amd.com>
 <69c72f43-6b1e-4c83-861c-375fe15a74b9@intel.com>
Content-Language: en-US
In-Reply-To: <69c72f43-6b1e-4c83-861c-375fe15a74b9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0025.prod.exchangelabs.com (2603:10b6:805:b6::38)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: 062be6da-4e7a-4a04-75dc-08dc8fda211e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDBVd3Q4MUlMS0RvUnRraVkyeFY1bi8yM3pmdlRocnBJbmFQckViZDd4S2Vl?=
 =?utf-8?B?QnNTblJqRUJ0R0ptUFo2RXRJZkRWaTFEUm5hNm5wb1hPSHpuQTFWek1qZ2VQ?=
 =?utf-8?B?Q1dxeDl0UlRoamQ3VDV3RmxHaVhGaU1SQzNyMTFtTzNWN1E4aDdMMzBEU3ZV?=
 =?utf-8?B?eFUyckJSQnpScFVGWGNKYWdEM3d3dGkyTk1XRVFLTW9TQUNMcTVrSjBQV09a?=
 =?utf-8?B?Y1FzbDhZWHE3di9yeGJ1SWtPTnhaNkpWamhwT3BtWjV1THc1elhOQ000Qlgw?=
 =?utf-8?B?SXAvdzdQU0NHeUgraElhUGdvdFE3SzdYU0dsVlB2UTluSFZMS3hnVC9WWUo2?=
 =?utf-8?B?bHo3VDM0eUQzeTdDVUNmQ1AxeEVZMFB2R29Hc0hxWDR5aDNNdEovREFMS3NP?=
 =?utf-8?B?SDhWMU1MTXIvU29jSXJhS1RCNWhQZmpyZnlEK1VsdFBydThQSlFYeGhlSERl?=
 =?utf-8?B?ei8rZHRxQlJaV3ZtRnlzalhRMlQ4NVEzbG1pcTZYbkZpclZNZVZSbnNvZVNH?=
 =?utf-8?B?c3U3KzY3SWplNURGODhjT3pNNGIxeWE5ZkdGZlorUVRKL09nT3BrTmRHN1VN?=
 =?utf-8?B?LzRIUTFQVGhnbUorOE1RbjlJeVQwSnFxUWNvT0lFeGZ1R0NtNEhGSkRkb0Nv?=
 =?utf-8?B?c2hFTXpJWTkzLzBLRHF6ZnY5cjd4WUhKRmY4ang2ZzdMQzNmMmxMbFA5OUVB?=
 =?utf-8?B?dVVockZWYWx4OUN4TkJHZHNYU0FaWkJ4QndpcTJObjVnV1R5eFQzak91VlEx?=
 =?utf-8?B?MTA0RW5IUXZkdnhUS2FMckNKQWVkQTlJRHB5VVZYbkZlcGUyM3Y2NDlnY09Y?=
 =?utf-8?B?YXRhcTFhaExkbTR1UkdQQm5BbWR0SHVybWltamZzS2ZBQzYrZDU2VG5rcmJs?=
 =?utf-8?B?TjZkZGt3eE1DZVNMejJjNWY3RzNEUmM5WitOWDlLS0kvaGZuSy9YSFRYN09h?=
 =?utf-8?B?aTRUQ2tRdTRuQkMvbDd2d25NaWMxTkU0Tk1CQkR6ODN4UnZZL2pZRlRia2VW?=
 =?utf-8?B?QVZOT055ZWNkeHBGdzgxaVhXSEsxdHg1eWRVWGRuVmxXck85VnVFWWMwR1Rx?=
 =?utf-8?B?Q3oyRzdKcGtjZW52dzc0ZzgwM1VNRncwbHUvd3UwOCs3a0poRHlvN0JCVnND?=
 =?utf-8?B?dWloOTBWaFVEVE9BSWJyVmZkOTNBZnR5dGQyMDQxSE9FZitDWnF1L2RVWTYr?=
 =?utf-8?B?NzIzcms5YW8xSUMwMWFZd1dtSlVLNzBTSHZSQjJYbG91cUoxdTBiUzkrbXBn?=
 =?utf-8?B?TVFOTTB4YmdWcnN5YzRSNVN6Y1piZ2c1SXNZQXlqbGlSZWZLaXl6OXgvL05S?=
 =?utf-8?B?emplYWJNc1NSQjhOZTZ6NkhQaExFckVQS0VOczJKeWFQaDd1b0NwZExkNE5v?=
 =?utf-8?B?QXFvR200aXVjcTBmNXE5UFBra25id0FDbWVHTUhZcFZNNlpONkNpbzZyUkMz?=
 =?utf-8?B?TmlISkN6RUNDdDdTQXVuVFpjNG5ZVjgvZTFTeFU5ZlNOMmdjSzB5Vmd1RUQx?=
 =?utf-8?B?NE9yN3doblRxMHJrditCUEp6eDJVbjNNdGpBbDJsT1o2WjV3UXpnSXgvaGJD?=
 =?utf-8?B?S05sK09vTnMvdW55UGFQNlNCZGIvOXVBWHVMQ0VqbkpPVXlWaU5yamdraERv?=
 =?utf-8?B?alV4YkwrWWRuVEc2bFUxSHl2cUc2bHlZWHhwbDdHQ1crTWdxak5zY2xqbE5U?=
 =?utf-8?B?N0N4dzBxL1pueER6RnNyZkJmbkEwZUNkNFVSN3VSNFFURE5Ob0xmWXZvaytR?=
 =?utf-8?Q?ZyI1e6qMgFhVvky4a8NPIt7MQs/PYDT2Pzqfe7R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlowZE9ldStZdGdqTjR3eG1ScVYrTEwrMGs1dzA3MDZEaEF2M2pwQlk4Y1d1?=
 =?utf-8?B?UjZjb0RRWW5EdDhQM1lqOStZYnRRL0hzL2dLSm1RUERGeHN2bDJOOU5lWmND?=
 =?utf-8?B?U29FVkY0UHVCVVBxakZJdXJQeUxoSDZUR1pYZzNqREczZzdpQTVIckxPb3F4?=
 =?utf-8?B?NmNUU2tldHRCSmkzblo1MldTSDdIVnpIT0ZtOXBqT3ExdkFHcVBlRTFMZVJv?=
 =?utf-8?B?dWVSZndXSDNJTzRzR1hzNDRzdE1YOU4rVUF2UnlpRktMai9LSEQxcElrZzUr?=
 =?utf-8?B?QmhMdTR2cVB1VXVjVjBxUTVrTFZwK2FuRWpTZW96N2srOXBGbmN4SEpYalY2?=
 =?utf-8?B?ZFh4Q08rSkZuSUduajdCRFVxWnFxcVhOeHd5dTgxT01mdWxqajlTUWlyNWxw?=
 =?utf-8?B?RjMyNWlGRm8yL2Q4WnY5NjBCc1pRMW9lUTU3cSt2ZXhRM01ycDNLeTRYUmoz?=
 =?utf-8?B?dHd0NVN6NHZoMHl3OFlqbUhzaDZSNmZDRmtreGhGK1h5UlJVTGZLZTN5cnBF?=
 =?utf-8?B?dEo1a2xMbzUxTmpST1FGWG03Q0JDa0lRM1c3L2hTaWR4MUxkaEhESVNnOGs2?=
 =?utf-8?B?VUU1UmNhZmt3YlRvNjdEUllsaEJERWE0NGlrNXE1ZzNFK0lSbEZycGQrdWhl?=
 =?utf-8?B?Z283YUI4ZlNVNGh4aXBwcUNJdHF6bkNuSlpndk0rZ29BR1l4TVVoVHVWaTJv?=
 =?utf-8?B?cXFrdElDZFByNG5UZENYOUE5QkJpeXdCWDJrV0U4ekJITkV6Ullhb0hybmpj?=
 =?utf-8?B?T0ZxdzVDZUFRSXBBcStXLzkxVjJTY29zeWIwZy9uL0RtY1VzekJIS2w4QzRI?=
 =?utf-8?B?M2kvU1JWczA3OE1qWktkZTlaU2lXN2lPQ3Nhc2ZLNnN6a0xEUjV2cmFhZ1hP?=
 =?utf-8?B?UGdYL1laQWdMaHowVmxkeCtKZ2FnQjIwK3N6bWdEUVh5OENMUFhoa2ZheXdv?=
 =?utf-8?B?eXJMa01Rc2JwWUI2VGR3bHRNdmZPWHhGcEp5SjdBS21paDlDamNHdTg3WDMr?=
 =?utf-8?B?NXlFdjhBb1RneFcyaGlzYkt5alZJYXpZUE9Qc2dIcFl2SHZ6VFRlbkZXZlpQ?=
 =?utf-8?B?WnY2RTFEejFBTEJNTWZVZm42MG1hWkcrbzgxd0F2L0tsYnBDOFVsaTlTWHht?=
 =?utf-8?B?aW5sTkRrRGZHR3ByeUlBYUtIREd5eUZTeWZldnV2Q3BscFlSQ3hWR1lNVmRr?=
 =?utf-8?B?MzBPeHhVUXFMQ1NBK003bkdVWERnTmNsN3llUzM4ZVk3S1IvMHBpelN2SnRn?=
 =?utf-8?B?bFVzbU5aY1puVytIZEpzQ0pUcUpFM0svYzB3VXFYMUhFUDNwOVdBajdIVVVo?=
 =?utf-8?B?YTZad1N3ZXFPeUdDNGZUenc0NFVzcU9hVmhJUGVzSnU5YTEvMEtVamZCcVVn?=
 =?utf-8?B?bVNQN3kzdWdxdDFVK2RSTTB2c2NzN2s4UmpkeHNOaEhvQ0hEMFpOYXN4M05t?=
 =?utf-8?B?MzBSdmUzNmVNdlgxTWZ1OXp4bTFPZjJCZDE0T2xrREVWMGo1dEpFVjlWN3NB?=
 =?utf-8?B?OWdJUFJKSXd3a2JTQlBPQkJuZ1l3RC9adGtYdWJGZVVTNVdzTDJsb1lrb0xM?=
 =?utf-8?B?N29wR1IzOXY3WmRzeHovVG9nUjZSL2JjSFUzUWFFeVgyVDBpQnQ1eFd6aXNa?=
 =?utf-8?B?NDh4MHBzKzZNWDlIWWFoM2xtbHZrSDBwV3M5OE5PVGdHNGpZMnlOL28vL3VG?=
 =?utf-8?B?eFBPSmJwMlFxWlpFU2ZvR3hNY2ZvNUowTnJwRkUxend2Z1FjcGhkWjVPemFZ?=
 =?utf-8?B?WW8ycFVPMzBSeDgxS0NWdHVuVUhmWmJxN1lMYVE1bkJSMUt3VUZEeE1hNVha?=
 =?utf-8?B?S3dZYkcwRFJYUDBmM1l0MHora01vSWpCMCt0bmdIWmpZUmd0NlZoTytGb25V?=
 =?utf-8?B?UlI4K20wbi9VUzJjZjg1Ti9IQk5IRUhLQmF1N0NDMThNeUR5dmR0Q2owZlBt?=
 =?utf-8?B?b3hmdlpUbGcvL25BRjhqMDF2bHhIbGQ2bGJzT1QvQTVsaXZ2Q1EvQXhBNFha?=
 =?utf-8?B?OFBJbVMwVmJxMWdGUWtxN0VZS0grM2duaU9PZlVMRVhCV09ReTI5aWdWOEc5?=
 =?utf-8?B?Zk5Fd3JFU2xMeTdKZlFFOEVkeDB1aXVSeitCQThWczZQeDJIKy9TTkhidHBE?=
 =?utf-8?B?d1d1VFNpc1hkNlNUMDMwNCt0NGtUUnQ4SjNYc2syVTUydUZ0OUNVR3NvSTBu?=
 =?utf-8?Q?nwin2qG5Wp1upI4lww74Sl6dcEVxxHPZbQ+puppYO1UL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062be6da-4e7a-4a04-75dc-08dc8fda211e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 21:03:40.3214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJStjSEuBKMRYbLqZTBIPK2cZfToudDjmK6Trhl6gLc3CK3PSfMwu7L0Cf7cOCJ2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8925

Hi Reinette,

On 6/13/24 19:57, Reinette Chatre wrote:
> Hi Babu,
> 
> Shortlog: "Introduce resctrl_file_fflags_init() ..."

Sure.

> 
> 
> On 5/24/24 5:23 AM, Babu Moger wrote:
>> The functions thread_throttle_mode_init() and mbm_config_rftype_init()
> 
> You can drop "The functions".

Sure.

> 
>> both initialize fflags for resctrl files. Adding the new files will
> 
> "Adding the new files" -> "Adding new files"? (this should be in new
> paragraph)

Sure.

> 
>> involve adding another function to initialize the fflags. All of this
> 
> Solution should be in new paragraph and written in imperative mood.

ok

> 
>> can be simplified by adding a new function resctrl_file_fflags_init()
>> and passing the file name and flags to be initialized.
>>
>> Consolidate multiple fflags initialization into resctrl_file_fflags_init()
>> and remove thread_throttle_mode_init() and mbm_config_rftype_init().
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> Patch looks good.

-- 
Thanks
Babu Moger

