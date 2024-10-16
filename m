Return-Path: <linux-kernel+bounces-368275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD0C9A0D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DFD1F25A47
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA2620A5C5;
	Wed, 16 Oct 2024 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AWecBrUp"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45471EB27
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090918; cv=fail; b=tJDhlymHrc3uVkbAmMkkrHD90zeFJhnZk8wqnCtJkNVROWl1B3F4GUu1PDfeo8W0/jsgPJirhG1EcYVMOPNNtND2JbswuNOqmxD7mzpEmEVR4GHEeEcIpvkCVxj8OsON69WAwr2R5Ojc6tgGfkhtiFfZwM5JY8L1Le27KFlxMjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090918; c=relaxed/simple;
	bh=UdC7CPZg0IHXy/av56lrqGQVM6Ac0u6YI+VIoKJUUjs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IZ/5JgeQLiIjMWdmYP1iQd6S6HBD7Ff4oA+S+I3lbxcBqtDHpW1+ZVLsN2rSA57nEIg6TdGVMb7l8YyDa7/K8GRBRCPTXw12c29BrpjrIJKfvc6U/JeTJa/ncUc5//xSlOBVLHHo4RQd873DHYJiUL/y6MwHv8NBKbmhBww3i1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AWecBrUp; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJX74cFlR1rSUQhp7sD8VUBM9kl/BBJguKayGpKKKc7D5673GDBs9evOknLy3flahBcLwURQxkle3dfhUMfI8De8zM1DKkAfkDosKwKhRTXWPO1qIt8AovRTFyvCyDZllDqSvYQYa+0MztbadqoYpJQnqhO7tisW+bA+OUlG6GKK0aZQ6HCk7aBYCU66zQ+SSeg/OUi+v82bzbOjTb8jvItnvU+P/hiM5XcdD+cIsx6ycVWpLhSgaH/uCVWXOBNhsOEq8CiuCCB9PxbEp3S2KF976KS1zlILhroDaS3dR51nrX11T2PL4hlXJIMcmhjKk07tDpd8KThIqHW6bDM7VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiNXFtY1/RsHOEF8zLPjWFGyRyouiVc0xg7LzKdG6Bo=;
 b=F5kryGuBWhJovHkLZsbXy9By+iOcQkfo35PqhFFcWAUk6FgZ8+wc/f0UrfTRDAVehomFUPHJBry9itg14AgVnurrpe/HymqhHnJlH7HZi9aZYwFsuQAuqPgYfG0wsclENnI2Vy1FUgE8WrXD8SONeOe9m4geJOKTjMURQnib3T0KJX67fRATTD2sADTcC3VB8FkZtx+K/j6GO/rQ8uQ1qsqD99MPTLQy8/hTAR/q78UnWg8Jdc86PO7yJbLEU7Z+MQJ0MXIDH9vwrVAvE0ZwNp11+UkfTTsNnJvkcF2YuDeWnPWW3RX2ViGxk+9WfmBxUkKj1E39uvShthjBQyBF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiNXFtY1/RsHOEF8zLPjWFGyRyouiVc0xg7LzKdG6Bo=;
 b=AWecBrUp5OGhyaBRcd76TIgvFAKj/BppLPocBoS3IJJKdv2Johw4XahKDcmihtTaI5h2f93dEnCjg9IPGnzCaLx0oxBOJhYbwIrcp+1+6hanXqpxSkih5EO1xyxPlb78szKBqauxJkjm9pV/+rovLN42at/0f8oVkuJZEwVRSYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.26; Wed, 16 Oct 2024 15:01:54 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 15:01:54 +0000
Message-ID: <91fe3ca6-e18c-4090-8d37-551c06175f13@amd.com>
Date: Wed, 16 Oct 2024 20:31:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] x86/sev: Prepare for using the RMPREAD instruction
 to access the RMP
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <4d62cc503d1e3278c3830f24462e3956233760ac.1727709735.git.thomas.lendacky@amd.com>
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <4d62cc503d1e3278c3830f24462e3956233760ac.1727709735.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0211.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::6) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b94d1c-ccac-4dda-91f8-08dcedf378c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDhIemhBeFMzYVRmZ0lURkswUS9qZWIwano4OXk5KzkwaW91Zng2V3gyQzdU?=
 =?utf-8?B?d1R6SmFSSDdGTHhpcWRpVnM3MnB1STFWZnZ6dS91MFU1akpCcC9RWm5uZjNF?=
 =?utf-8?B?Y25xT3FkN0ExZ2xOdHFWZVpRSXBtdld1RDFJWmNxdmJFMUlJVXppZXpuemph?=
 =?utf-8?B?ODk0OWFWMXdhNmg4RmJUbEFoVlVlWHRZMlRkdGxwVnNGNlJINWN3a1A0M1Fi?=
 =?utf-8?B?bnMrdGFTM0xDMFNaZlZPcCtwRjQzdHp2Ky9UcnFTMTFRQStJZnlCaWpuSElO?=
 =?utf-8?B?RVhoWUpTcERyd2ladjJVSERjc3haTXc3TFU4enh6bWN2YWp4NmdTeUNHQUhN?=
 =?utf-8?B?dEFOVGRhTE1uamViY0pZZjUwL3BQS3dkanBQS0pwUXorK28xT2JETlZTVkR5?=
 =?utf-8?B?c21nM0ZPdlpIYlpnTkFMelBya2hmdFNIOUNtMHU4SUxxczB5cGpZcFRwSmVD?=
 =?utf-8?B?VVRmd2ZaeWlMeDNBZ2xKNmpNZE9GY1JwbUJvelpsVUlmTjZISDN4d3JJdlUx?=
 =?utf-8?B?U1RqcVRpd0txQjRIb0NybDB1Wmd3UUY3enlLQWxoVEdtTUZBblZjUkxBU3hB?=
 =?utf-8?B?SjA5bk1UbzdVQnRxcW1ZYmE5NGdQMnpHb0hzZFA3aVF6K1FjUnRCanhqS1BK?=
 =?utf-8?B?LzJvVXo3Uy9CN1JRaExFQVJpVWRXZXN0Tk11aENiUXdrT3Uybm4za2tEU1NS?=
 =?utf-8?B?M2tmTXBXVW1KTmpkVmhxbFFBK1JzaytIaEVxNFJXQlAzb05MT25CWmoxSXQ3?=
 =?utf-8?B?b3ZxVnBGQjZiTmJKYkgwcUQ3UzJvQ0psWFk3L0V1R3gwM1cwUWVVcnd6ZEsz?=
 =?utf-8?B?M0ljbHRaZFMySzRSWVRxTkV3Qy93aElkOXJoODQvbEFqdVowZUI1U0xJZWZ6?=
 =?utf-8?B?Ti9TQUd5Q3hFaDNoTmZQSUdPTmxwZ3EwMTU2Vm9YcmtMSmZTNXdtL1p6Rk1n?=
 =?utf-8?B?S2gwVzVtNklXODBabExvYWlGaDlWMGFsQ2VXSEZaVlBVc1hpL0x1SmhhWk5J?=
 =?utf-8?B?UDM3dDFQc3RFOC8xQVFvY3J3cW1mUlN5YkdycWZkaW9sa3FsbjZseWRrTmEy?=
 =?utf-8?B?eUduU01zUzRhcTFHYjhhV0VLbzJHL045d1dIVFJEMVVSK3U1cmF1dkVSN3lq?=
 =?utf-8?B?V1BiWjFiZ2ZmU2plT3BwaSt2Mm90NU5wa2gvdVl3anlqSU5lakE5MGNhM2RS?=
 =?utf-8?B?NENjUEMvUVJlV3dzRTRTZVlkSnlrQjhmOTJFajhxaFpia3hnam00Nmw2UW95?=
 =?utf-8?B?bWhWZ2F0Z3dwR2J6ZHEzM1ozQkZLKy9IMzF3N2lTYXlvV0Q3dW4zY3Z4VmtK?=
 =?utf-8?B?SFoyMy9WbEhvUFdoRGU4QzBQNFIxdFF2cEc2SFFEVVNJZmRoR1dEVHk3N2ZE?=
 =?utf-8?B?QlY3cnlUMmVTZS96SnhmUmUrbG05NkY1cjRQN29LV3pUS3IrWjNNTDFuNk9N?=
 =?utf-8?B?YnFSZ1NCTnJXRTZScUNrVUpzeUtvZmxhaG9qbkMvWWluOVdpYjhKVEMzUytB?=
 =?utf-8?B?UHV5NFJZWlhhTzhYSlJkb2JUYUpUNGdUUDh1Ty9wOWU0WnlxbDRkTXZGcUhh?=
 =?utf-8?B?Rk9EWlR2cW9IRjhSUHV0MWNNaVF1WGZMR0FnTlNkYXpSaFNVTk5EZW55MmZH?=
 =?utf-8?B?cVI3T3J2T01GdjhUT1dhYlYxREtqZnhGNmdGV3lMOURsRzZBWnV4WXdUZjNl?=
 =?utf-8?B?NU4zZWVkc1o2aXhONjR6c3VqMEdWZnlVekNOUnNZV04wVWExR2I1VGpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXNGVHRIN2V0cFpEbEppYlExUzk4dndXZXRkcU5VU2xhaXRkQ3UyK0xGTHZy?=
 =?utf-8?B?R2ppY083c0dxMHlTc1dyaHdMT25JZXVHZklUWElrbFNuY08zdFNYZUhaeTl2?=
 =?utf-8?B?UmlndWNLMm5NTWpEYWE4b1duL1VzYUZIYW9tUTFvSzZZUjVUWkhYaWtUK3NB?=
 =?utf-8?B?MmZVcEo2SytkY09aT1p5aUhWbnMvaGl4ZFZsM1VzUWlvOFpWTnp2bHd5czdm?=
 =?utf-8?B?V2pQVk5icm1oejRyWXdDK0dNTGJDNWxiRjVSVTlnZm5RaUV4ZWxaSTRqdURE?=
 =?utf-8?B?bnRPaUZtNkUyVFhNbXRXeHQ1RDFwRGxqZ2FCdWNIVU00bFJ5dFMyN2ZjLzRv?=
 =?utf-8?B?TW5iRE1hclNuYklmY3lwcEVvVWFKVzBBWFF5MXU0RWpxRktSVzB0UEtacWNr?=
 =?utf-8?B?Vnk3SVI0a0dRVGR1bEsyQnRvVEJYNUhidWdIWGZ3UTJRM0l1Z2JDVXZKVjc5?=
 =?utf-8?B?b1hqU2VPUkxlTzE1ZjlkQVhhZ05KMUFlUDZpTUp6Y3RIMVhxS1l1cW84dHhD?=
 =?utf-8?B?ckNqSEEzTUZadHpDZXdORjdNVENOZUM1NmNTRW52MXdpakdoNGd2Wm9ubHBn?=
 =?utf-8?B?eE9kek1uVjJlbGo1eDZrcGl6dFFOTmlFeEFZSEU4d0NTUHlkUjBiNEJodWE2?=
 =?utf-8?B?V3A2bm90Sm5lbFB2L01iaXZLeWJrMThwRUlUdnlpZThsb1RPYnYwa2ZNeTNZ?=
 =?utf-8?B?RzNrODkxbnU3cVQ1TTVCY2ptc2RIeXo2TFZUa01lK3RQdHhEVlMwdlFYblZZ?=
 =?utf-8?B?ZUJtVnBkZW1BSEVDYWcrTFRiTWc4dFhwVVV0c1JJZENQaTlsMnpvcDlDUTBX?=
 =?utf-8?B?MTNMNTEwN2hwYjhvbFNpblY4bkFhZitmc21abjRrMml3bGd2aElrYVkyTXVn?=
 =?utf-8?B?aWpQS3p5c3BZZm1TRjZtdnUzalQ0NjFhejFtakxPdVhKNkdoLytZTW5ZU3BU?=
 =?utf-8?B?aVBzcC9GaGZ6ajJ3UzRTaGNwZ1FLVlpUQWRYMlhVWGFTWk9WTzJQOWE3RlJq?=
 =?utf-8?B?NU95Uk5vclR2WlRLczBqa29OU21lTm04TUxQOEhJN3NsV0Y2M2JHNkwvSGxC?=
 =?utf-8?B?YkZmWXVNcFJ2VjdYZndaN3dSdXp6NUpUQ3JnWU1oSE5BZm0zeXQzRkJyYWVW?=
 =?utf-8?B?Vm5FOWcyaXE3VC9YZVNDWDVtdWVxWUZZK2RHMEhmbzhmZXV5dVNsVWYrZk82?=
 =?utf-8?B?RTVvb1dwUllhL1Z0VWlXZWpjRlY5Vk1nRGFsRXVLbUN3eVZ3ZlV5T0RRNzNG?=
 =?utf-8?B?RGhmV1dDekRQWU1VbXU0a3MzYWF3NGoxelk3NndnZTVYMHV3WUNWbno4aHgv?=
 =?utf-8?B?cDV0eVlaMWMrRzBUMFR4WUFCQUUvYmUvb2o3MkFyV0hMdWNKWXNpOC9iaEpr?=
 =?utf-8?B?NGxzdkRPd1MwT2RJaU41YWlhSEJsOGhqWTZ5bjFVdmVBeE1HRDg2Rmg3OHh1?=
 =?utf-8?B?WEZpUG9jTlFIQ2k2SVdFSVptWGdmMmNIVVpKYmY4YlNkYlpHbFgwWUVxeTJR?=
 =?utf-8?B?WlJzcHlFbXo4ZW9sTUs3MFFUSXZyRGE2cjE0c3lHTTd5aE84OE5YZzBMUEF2?=
 =?utf-8?B?SkprNFNrSTFCdFJEZmEzcSt3SGx6bTk4enVjQXRBcU1lZ1FpOHVjQm9XcEZ0?=
 =?utf-8?B?OUU3QXRaVHV1SlQrcU14ZFJiVi9NQjJPRjVXcGVvYm5Vd1BrMlBnMFFvWlpl?=
 =?utf-8?B?T0lseHAySXNNVXVBT2QrVkw4R0EyZVpJbXNMRTJLWWNnQ2xSV1dLRUdMSm13?=
 =?utf-8?B?bWtxQXA4SndjejBLa0JqNXcrdFNscnhYNmd5SnRFZC9ldnAyaVhGUENqTEFG?=
 =?utf-8?B?QXdvZFhISDRhSUUwUmpwRndMVTZhUG9YWXFjOEgyU2licmNhSTJwc3dRMjdP?=
 =?utf-8?B?OVgzdkllZVc5TU1qbGJpeHYwbXJzUkZKbU1GaVdhTENlWlUySUJQdHJhVFFL?=
 =?utf-8?B?b2NoempaR0pBZmZudFpJRUJuMWRUdnpLSnNnOTg4QnlrbFA4ZWJmUTc1d3hz?=
 =?utf-8?B?RU9TUldZUm5KbEIvZ1c3SS9ERUZvRHBJVmlHWmg5ZlZtWW40aVMrRk40S2Jj?=
 =?utf-8?B?eDFic0JGTGdBODNEWHlkc1BIRnl1UnZYaVRSUmFvMHNyUCtibHFiYlkvY1Fx?=
 =?utf-8?Q?u/n+MsQuYcEYUZsS6ylejhTs0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b94d1c-ccac-4dda-91f8-08dcedf378c5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 15:01:54.2351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qR2hBS7AiY4yoGYLJA9agjtnxDamJZRrc3BWtoE18vXAY9xAxG3MLMK60tmAsOJdDQBx41HmZqORovH7vj47WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819



...

> +
> +static int get_rmpentry(u64 pfn, struct rmpentry *entry)
> +{
> +	struct rmpentry_raw *e;
> +
> +	e = __get_rmpentry(pfn);
> +	if (IS_ERR(e))
> +		return PTR_ERR(e);
> +
> +	/*
> +	 * Map the RMP table entry onto the RMPREAD output format.
> +	 * The 2MB region status indicator (hpage_region_status field) is not
> +	 * calculated, since the overhead could be significant and the field
> +	 * is not used.
> +	 */
> +	memset(entry, 0, sizeof(*entry));
> +	entry->gpa       = e->gpa << PAGE_SHIFT;

Nit: Do we need to use PAGE_SHIFT here or hard code the shift to 12?


- Neeraj

> +	entry->asid      = e->asid;
> +	entry->assigned  = e->assigned;
> +	entry->pagesize  = e->pagesize;
> +	entry->immutable = e->immutable;
> +
> +	return 0;
> +}
> +



