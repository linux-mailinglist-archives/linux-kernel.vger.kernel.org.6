Return-Path: <linux-kernel+bounces-565172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EE2A66251
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18AC117AFF2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF342045BF;
	Mon, 17 Mar 2025 23:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fXohylLh"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8374205504;
	Mon, 17 Mar 2025 23:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742252465; cv=fail; b=ATE1a0ji8+SZTR7F5rZOm6Jq6YNVsGMRRxImKRnSt2BDkU0cJX4kgXS+Qd3h5bvM62gMvNqX4S3OlDkvLK3S3hvYz1cmRA5cqjai97C+9AOfpeDviz9pgi9nbiZEfQ1ud8pEoGNvwVc/48LA5QuhjanWAGBwNuSQmrdYcHFNJCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742252465; c=relaxed/simple;
	bh=NYKiuCUQwZpuqE/ohh9BMEP70mg3a/mW6+d/DDnIoZQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nuY5Qa92TG6eN7RBdzKM5Df1COHH2z6jx7a2nLoYz2OSE5LW1Nq/5QwjAdiSLSdTSRJwwdcd4CNpooj13GlbQMj9nqghbHtnXu1jGNWoL0K7FX/KZvBVp4d7GFKwAOlL7eDQOnTZKwB5L6So5t8v2puKfYRzRBLHLRdoYy4AUDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fXohylLh; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHYejjMAvN8XWW7Xuzn/xud4CICYF2F1bvRYdVexu9ks6XEQs5+vqb+tEUhh9bkAA+erxxQhDAId5sDHuVMFLfMNsQf+PbIu8r74tCYHj8LPxS1mRNrKbTA9AuEsBTdmaNIlLJ87qp4AF784S09ewsmPAGEy+GHwEkLTJd4JCxbznSuY6RtaKq34KoWXr5rWEzp03kXJgQoha3FMnImC/C8AeadFI6aiMeFuZQlPWbpzi+7DJkgMIzUG2xphL7i09TC6DCl8jhloPFxnr05oVSI1IktwCaSFnSpxSp7bDi9NJc7S7xMcIsP4LsVMChxd5bFuDDkHtoZ/pTyNFoeB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4BiQilNyGOHau61N8nqH7Fkqo50Ipqn914r9GhskE0=;
 b=UpW8CjrVx0de/lj3DW3ho0xAym314BYurZxYA32G+SayNV1wB04Z9EbDutc2zZf/UuHdPxo869kSN73//4FN7VxqEW2ZnTN5W3ZF7VA3EoRXTXDgYtqzG/33dfO+gB1DCVZT1aiDOAgMHCoLESevpkeBe9DolJ0ecfmGeQLBXNuqhJvUrhhFxD3EHPnv+35cFmYYuF8KylderzeJx0zKjenWCNa6PZ5DARUA62eet5fOfEJ1cpKh4QPdERJYDSUxekvcMHfHBLDGUo+wrHnfbT6YNWbLgKG8dG3RLYyjIvd0qkRfkzQy5ZYC49upyMFNgVfABfWuzNxWk5STSa3zIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4BiQilNyGOHau61N8nqH7Fkqo50Ipqn914r9GhskE0=;
 b=fXohylLhp5d3etB5AAzyyRsBjlgat/SyOqhQ/+ZJ38926UPitzx0z1seRNp8VQas33DpYepkiHPSN1h6iKOlPlwvzVOX53LlEtHR0XnvLIPwMfrAuwuPdzWOV+SKYHYCTekNFeX5KX+y4AZPBVLUVRF/Bmb7hDXk6de0pZZBbtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB7247.namprd12.prod.outlook.com (2603:10b6:806:2bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 23:00:57 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 23:00:57 +0000
Message-ID: <8babbd2a-50ae-4a18-8e48-5421539ef0e6@amd.com>
Date: Mon, 17 Mar 2025 18:00:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Peter Newman <peternewman@google.com>,
 Reinette Chatre <reinette.chatre@intel.com>
Cc: babu.moger@amd.com, "Luck, Tony" <tony.luck@intel.com>,
 Dave Martin <Dave.Martin@arm.com>, corbet@lwn.net, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
 thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
 mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com>
 <f1744c45-9edf-4012-89bc-47393b4c53fc@amd.com>
 <CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com>
 <d1ca9220-1ab7-4a39-819a-03a6069b7ac4@amd.com>
 <CALPaoChLL8p49eANYgQ0dJiFs7G=223fGae+LJyx3DwEhNeR8A@mail.gmail.com>
 <a4ab53b5-03be-4299-8853-e86270d46f2e@amd.com>
 <c1c0a99a-a467-4ae6-80ee-04b6a9cdb6e5@amd.com>
 <Z890Q2GoP6GecwW4@agluck-desk3>
 <04e47d0e-6447-451e-98e4-7ea65187d370@amd.com>
 <6508cf67-3263-432e-892c-9b502b3c6cd4@intel.com>
 <f8a20ed8-6e30-4cff-a96b-8df89a605081@amd.com>
 <d07a70f5-b1ca-4766-a1d9-53988dd9164f@intel.com>
 <14c14b11-5b45-4810-8e46-019c8a67fc90@amd.com>
 <1db8ad73-5194-4821-844a-8fd7cac72ad4@intel.com>
 <9b8653a3-c6fd-4748-a4b5-94d5598d180f@amd.com>
 <20ec195a-c4dd-48d9-89f6-4d48fd438fe8@intel.com>
 <be6d23c8-3e93-4bdc-8b33-d3af7df7cc94@amd.com>
 <7f54f9aa-1102-49ed-b830-6facb6f48366@intel.com>
 <CALPaoCj7aSVxHisQTdKQ5KN0-aNzN8rRkRPVc7pjGMLSxfPvrA@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <CALPaoCj7aSVxHisQTdKQ5KN0-aNzN8rRkRPVc7pjGMLSxfPvrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: c91eebde-5581-46bb-b90e-08dd65a79419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXUrSTdTZTdYd2xOSjBJcW9MM2tMTndCaUt1Mnl5N29lVDJIa2Y4Uk1TbXpy?=
 =?utf-8?B?a0NpaE84amN3NmI0cXkvcHZRVFpGdndscnFPMG5QSHR3d25aYWV3WEdieldN?=
 =?utf-8?B?Yk9ORHhNWUNITDk5b3FBWHowbHZCRWRpQXdwTjg4elNLY3J0TElwVnl4SFpE?=
 =?utf-8?B?SmZmR0JmdjA5bVBqc0pyUmRiMUZhYlZjcXo5T2RUWVNTZEFSRHFPMWZuTG5o?=
 =?utf-8?B?eVM4TXZURUhUdTJDR2dhQmExaVJqc3UzU0JnSngxc0Q2dk83andHUndYRFBq?=
 =?utf-8?B?Z01wdXZWZURDRkhKWWZtZko1bWRoc1Blalg5OHlJK1o2OE5lenBiU1dFdmFz?=
 =?utf-8?B?bFhvcWp4VG0wTTBFTnhZYlJXVE0wK3p6QVlUT051L2Qxc2dFdFk0UWRaMWNi?=
 =?utf-8?B?OEFXbnZvZkU1YVRCaVlRU0RyNVd3LzNUQTFBREFhcHg0QXpPc0d5UWJjRlRY?=
 =?utf-8?B?RjllNjJFb2JjbmQxZkVZdkdZYUpTblBEbE1IT2t6QUhYd0hOZGhzV01QOTJv?=
 =?utf-8?B?ZXdweTBNdHlEN3lacTUvSW5ibjFXNnJ6dTlNYXB3QkxGanFESHFEanFBcmNJ?=
 =?utf-8?B?bXBvS29TVWgxejRxRktBRUJkSTVodDkwZS9yem9VTkRMQUU5VklGTmUwNFl4?=
 =?utf-8?B?bUs4Y29GWXNhemtDYXp0eW1POG5iMURXa2szTCtBdlhxNDI1Ym9jeVI5ZGFZ?=
 =?utf-8?B?SGpYelBvdEpMUkFXSGduS3RscUUzNkFxMHZJckVMZ2w2SGdHbkpqalpraGxG?=
 =?utf-8?B?eUVDUUl2SzY4WGd2dDNRcytRUnMyUWdsMTlyTy9nZmJKNmdoTzdybWY3dDNY?=
 =?utf-8?B?QjgxWm9RSUNwUEpqVE5RbFk0TkdZaVpTcWU3ekNuOTZ1b2FQS3BWV1RvZlhn?=
 =?utf-8?B?eFJ2S1kwa2N6T3RINklJRjFQQUc2OU9QR0xsMUFkelErUFlvTTcwZFpHV25E?=
 =?utf-8?B?YWU1cU11K3hnT3V4ajZ1RVFGTDQ0bm15TzNvQnBuMGdnS29VcERhQWd4ck8w?=
 =?utf-8?B?QVlTUElJZ29HQ2FwMVJDU3dDaHhtWEFOQ1NiV1JkNFNYV3VmVTNrbVZSZDdP?=
 =?utf-8?B?YW5RdHJTTk5IWWZzYTE5bmdVay9YZVIyRFZ0WElpNyt2MUcwYWxrZG84NEta?=
 =?utf-8?B?OWxMSjE2M3YzMUhBYzg5bnYrNFZHMG9vQUN5dXVWdk11bzV5eFRGTGliRVUz?=
 =?utf-8?B?Z0tXcDZNMVlMZ3RhMXBlM2ozdHJqRVR1OFlOTzVoWWlOQytBMHZtQ0pQcmFn?=
 =?utf-8?B?S2h3TGtqZWFSdWtJbldMU2c2K0thczVlazF6MVVRTHp2c1ViRWtQaWpVR0k1?=
 =?utf-8?B?a0lNMFN2dXRhOFlSNmtoSTREQnFrMU5sMXhZMjhlMUw3dVkvczd3UUZMUUlo?=
 =?utf-8?B?RDIrc0dvRGhSaWpvaVc5bk9DWGlQQVdqWXQ5Y01ZTFl6ZG0zZkxyYjV5YmJa?=
 =?utf-8?B?TVlpUnU5SWFBaGJyVGhKSW1lT0h0bFp0d0QzVkF5ajFKU20ydVJoRWU0V08x?=
 =?utf-8?B?UEhSamJ3Rk90aWhuTm9QTUJDZUpWa2dYU2xoWDM1eHVOUXIxS0FXVzBKa2ZY?=
 =?utf-8?B?RjFQdTB5L2h2a2ttbXhldkM2MzFHSEdodHEvd09UNWJYUlRqWHNvZUZ4UVdH?=
 =?utf-8?B?Y2JwYko1RE1CM20rajhxV0lOajdiRFlaczYwby9GbTdNODBpS1lHZ2FqVEc5?=
 =?utf-8?B?ZlRyRjJjNUk5a0pWQnJRT1Noa0NZd2xqMFd1YjhmQXRSZElJeHZRdWFTUW1s?=
 =?utf-8?B?c0F3ajhId255TUpvN3pycmNRUkV3TmluNFhBeHBUQ1lKZjFXaHJJVXBuLzJa?=
 =?utf-8?B?b1A2V0VGNW5kbS9pNk1IaVpuZEh2YlFCUHVtU0ZQRlEvWGVWdk5iMi9pQi9u?=
 =?utf-8?Q?gDMG4FufXawtL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHRGc0JLRmhERElnSmhWdEVSYkU5NXIzQTRGSmR4ZEFnMkU4dlhTSnM1cy8x?=
 =?utf-8?B?OGhFRlp3VFJtaUs5WFJuWDFRQSt2bGJlUkZOY2IzYUMyYWhPTGFzaW1kei9Y?=
 =?utf-8?B?OURpVWRWenhCYXBlcnoxL25rVGxvU0RPby9IbzdCNFZmNUFEbkVLM3lCNS93?=
 =?utf-8?B?blp6Q014Z1pTUzFsY0JKOVVIby9RM1ltcVV6RGVaTmtJOGh1bXpuem1veWFq?=
 =?utf-8?B?TUFHWlVQSG1QeVhEY0xPaWxMUVVmdVhjM25RYmI4SXQ2dzlvTHREWGdPQmkv?=
 =?utf-8?B?VyswbUpCRW5nbVZPRVNzckpBTDNMZjlWb0xLV3JPaFg4Nk50WmxiYTZrVmU5?=
 =?utf-8?B?aU9xU3UxVTNSYlEzcDNGc3k3ZVRTTmVhczFvWUNJMTZ3eG1DMjFrYXZXcUVO?=
 =?utf-8?B?MDhPbDZvdHdlZy9OcnFRNUZ0Z2lxUmc3U2VFS28vMEZ4STZZaVJ4MHcySDFK?=
 =?utf-8?B?YTVqN3pXaFpCME54b0psa0VzS2MrdmNNMDVEaVNCdzUyNFdRcGJEeDNxWUVE?=
 =?utf-8?B?MmVxY0VzZHdRaVhrTlFRb1piRDNFU3Z6K3pTbEM4YWdLZGFDRm1oMm9XNWxS?=
 =?utf-8?B?d0VtdFZWZzRZMkY3VTFyR3VuSE53c3EybDVQelJRY2l2emd5dFRETTBFYUJG?=
 =?utf-8?B?Y0xWQ2NSM3RBUmlOd3BDdnNWRkNPUTB3S2hXNjFPT1AvNnprTVJ4OEJSYnRS?=
 =?utf-8?B?MTMzbHRiSjlMdWhkK3NOSFY0UGxBOXFhSTFoclMycWVXRjk4ZnhBSVpUWXpB?=
 =?utf-8?B?Z3ovak1OYzlLUzdnZWxIQXNRUHFGNlNwWVJFOXFqR0NnQXBmQ2QvdXc0eEgv?=
 =?utf-8?B?cG9SbkVoUCtvMkZRSjNYc2dNUHJJWGhnQlJQRCtsNzVyNHo3ZFR4TytZTEx6?=
 =?utf-8?B?ZUU5UDE2NWRvSmEyMWlaaXhMbmdCNGh6RFpGWXpHeTBtekwzczFmQ05YT3Yv?=
 =?utf-8?B?TFpLZVg3S3JTejN2eEp6WXhuRUpnamlqWUROTEtGSHdhb1lEeFFRYTQ2R3NV?=
 =?utf-8?B?TkhpTWo1YURIQnlZYTRHakpXWjBIUzFaMXZscWhJeGRKdmNrQUh3bCtJNmp5?=
 =?utf-8?B?S0Q1R2xKOVplSm1uTHZiNUlUQndRQVBoYlJtdFhSQ1RhSktRUG1MSjM5dEp6?=
 =?utf-8?B?azc3L210RSsvREQ5ckZHOFJ6M1gwajRKK3V1UG9SKzU5eGU4ZXBUTVA0WmpD?=
 =?utf-8?B?aVdqMFRLNHcya2U5bXQxUGVkcmMzYlROVEwxd2wzQmNXcG93NnU3a3B6b2NT?=
 =?utf-8?B?b0N2N1RvWWJkc2V1cEh6NzFUbGE5QXVWOXFrUy9DZ3ExcDN2RWsycWF3RTBT?=
 =?utf-8?B?cUxiVnZZUm9wKzVVNFlYdnRXOWd5UzRYZDlQTVhOTWx4cm5lYW02aVcyL2Y1?=
 =?utf-8?B?ckpOUlh4K0NkbGw4RlRXYVQrbjU5cmt3OXZ1UUhrK2doajdna1dyUnVpMXFu?=
 =?utf-8?B?K3JrYmtpdld0Tmc1MG0rcG14N3ZFR25lQlhnYUkyMXJkRDBaVlhEYTQ2UUUv?=
 =?utf-8?B?djEvTmhsc0p6bDN1cnFrOTBvV2czTGptVUdnRWV4UVlicDBCOFJYRVhCOTFE?=
 =?utf-8?B?K0hZVVkwNGJTMVNKVTNUNG9yYlJSZlVRNlJxKzVFcFc0SEJPd0FoK09obldT?=
 =?utf-8?B?VHJReDZFbEhWMW55SFhqZFBJR1dSTUlNbVcvQUZuQW5mNFU0R2pGVnZpTnVo?=
 =?utf-8?B?SXRWMWNQU05GVzhHd2ZIUk5uM3FrRCtMWTNzMDlRTGlpRVZ0U0Q0U2dGQ3Ew?=
 =?utf-8?B?aGh2VHJ5eXFKa29CWnluWUxSZTV6Z0VJWXhmNGpZeWlYRjFYNHd2Nm1wVzlu?=
 =?utf-8?B?eUxmNHMwZVBZR0RUUlVXSEJYc0lKSktJTDMzVzd0UUVzTkZYZFRBUVg2NTF5?=
 =?utf-8?B?akpsTmdLdUljZ1FnRGVGNXJWQzdaR21jUGlwazdvUGVPZGswSjV1NERmbGZ1?=
 =?utf-8?B?dGM0WEtIa3FGOTV5Z3M4bFpENTZlZWVwZDB4V2lhMndkY05OeXFSZHdpcWJR?=
 =?utf-8?B?SDlFaFozd3cwVTJ5ZmpCNDN0Q2t1bER0TndQVlZrZjVQQkJKTm8yTmZ5TGtJ?=
 =?utf-8?B?QUpBT21HdlhSS3d5bFBsbWNrdGxXWWF4b0x1OFJITXNaa01TaGpNeVJZSHJF?=
 =?utf-8?Q?FDKw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91eebde-5581-46bb-b90e-08dd65a79419
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 23:00:57.6564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1D5NFcSVKROxS9Qm5A5PeGL62agR7NCBhdny0QPi4J+8il1KoU5ulb9qbn2ALAR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7247

Hi Peter,

On 3/17/2025 11:27 AM, Peter Newman wrote:
> Hi Reinette,
> 
> On Thu, Mar 13, 2025 at 10:22 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> Hi Babu,
>>
>> On 3/13/25 1:13 PM, Moger, Babu wrote:
>>> On 3/13/25 11:08, Reinette Chatre wrote:
>>>> On 3/12/25 11:14 AM, Moger, Babu wrote:
>>>>> On 3/12/25 12:14, Reinette Chatre wrote:
>>>>>> On 3/12/25 9:03 AM, Moger, Babu wrote:
>>>>>>> On 3/12/25 10:07, Reinette Chatre wrote:
>>
>>
>>> Here are the steps. Just copying steps from Peters proposal.
>>> https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/
>>
>> Thank you very much for detailing the steps. It is starting the fall into place
>> for me.
>>
>>>
>>>
>>> 1. Mount the resctrl
>>>     mount -t resctrl resctrl /sys/fs/resctrl
>>
>> I assume that on ABMC system the plan remains to have ABMC enabled by default, which
>> will continue to depend on BMEC.
>>
>> How would the existing BMEC implementation be impacted in this case?
>>
>> Without any changes to BMEC support the mbm_total_bytes_config and mbm_local_bytes_config
>> files will remain and user space may continue to use them to change the event
>> configurations with confusing expecations/results on an ABMC system.
>>
>> One possibility may be that a user may see below on ABMC system even if BMEC is supported:
>> # cat /sys/fs/resctrl/info/L3_MON/mon_features
>> llc_occupancy
>> mbm_total_bytes
>> mbm_local_bytes
>>
>> With the above a user cannot be expected to want to interact with mbm_total_bytes_config
>> and mbm_local_bytes_config, which may be the simplest to do.
> 
> How about making mbm_local_bytes and mbm_total_bytes always be
> configured using mbm_{local,total}_bytes_config and only allowing the
> full ABMC configurability on user-defined configurations. This could
> resolve the issue of backwards compatibility with the BMEC files and
> remove the need for the user opting-in to ABMC mode.

There is no opt-in mode. ABMC will be enabled by default if supported.
Users will have option to go back to legacy mode.

The default configurations will be used for total(0x7f equivalent to 
enable all) and local(0x15 equivalent to all local events).

Same thing will show up at
a. info/L3_MON/counter_configs/mbm_total_bytes/event_filter
b. info/L3_MON/counter_configs/mbm_local_bytes/event_filter

> 
> It will be less clean implementation-wise, since there will be two
> classes of event configuration to deal with, but I think it seems
> logical from the user's side.
> 
>>
>> To follow that, we should also consider how "mon_features" will change with this
>> implementation.
>>
>>>
>>> 2. When ABMC is supported two default configurations will be created.
>>>
>>>    a. info/L3_MON/counter_configs/mbm_total_bytes/event_filter
>>>    b. info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>
>>>    These files will be populated with default total and local events
>>>    # cat info/L3_MON/counter_configs/mbm_total_bytes/event_filter
>>>      VictimBW
>>>      RmtSlowFill
>>>      RmtNTWr
>>>      RmtFill
>>>      LclFill
>>>      LclNTWr
>>>      LclSlowFill
>>
>> Looks good. Here we could perhaps start nitpicking about naming and line separation.
>> I think it may be easier if the fields are separated by comma, but more on that
>> below ...
>>
>>>
>>>    # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>     LclFill,
>>>     LclNTWr
>>>     LclSlowFill
>>>
>>> 3. Users will have options to update the event configuration.
>>>     echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>
>> We need to be clear on how user space interacts with this file. For example,
>> can user space "append" configurations? Specifically, if the file has
>> contents like your earlier example:
>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>   LclFill
>>   LclNTWr
>>   LclSlowFill
>>
>> Should above be created with (note "append" needed for second and third):
>> echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>> echo LclNTWr >> info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>> echo LclSlowFill >> info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>
>> Is it possible to set multiple configurations in one write like below?
>> echo "LclFill,LclNTWr,LclSlowFill" > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>
>> (note above where it may be easier for user space to use comma (or some other field separator)
>> when providing multiple configurations at a time, with this, to match, having output in
>> commas may be easier since it makes user interface copy&paste easier)
>>
>> If file has content like:
>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>   LclNTWr
>>   LclSlowFill
>>
>> What is impact of the following:
>> echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>
>> Is it (append):
>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>   LclFill
>>   LclNTWr
>>   LclSlowFill
>>
>> or (overwrite):
>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>   LclFill
>>
>> I do think the interface will be more intuitive it if follows regular file
>> operations wrt "append" and such. I have not looked into how kernfs supports
>> "append".
> 
> I expect specifying counter_configs to be a rare or one-time
> operation, so I think ease-of-use is the only concern. I think
> multiple, appending writes is the most straightforward to implement
> and invoke (for a shell user), but I think commas are easy enough to
> support as well, even though it would look better when reading back to
> see the entries on separate lines.
> 
> I believe you can inspect the file descriptor's flags from the
> kernfs_open_file reference: of->file->f_flags & O_APPEND
> 
> I haven't tried this, though.
> 
> -Peter
> 


