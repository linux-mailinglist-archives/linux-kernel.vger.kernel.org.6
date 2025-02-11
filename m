Return-Path: <linux-kernel+bounces-509888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1433CA31592
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 20:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33BB3A3152
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 19:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BB41DB148;
	Tue, 11 Feb 2025 19:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PvnMy8qI"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FE01B6CE4;
	Tue, 11 Feb 2025 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303109; cv=fail; b=I/1FxSxmOuoE5sxhUFezA//aQ9heqqQAkR2oyynkac6Mp0ov1N1bGXvj1xO0CMesgJAjEOaAoJ0D8ibNPz75LlArC85QxMHMtSmSXLREt66pd5UW7bwlO2NDugvuhI5QsOWTBDC3q/cHOWVEGDtNATzSiJhs5wViincVbsk2rVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303109; c=relaxed/simple;
	bh=iuWNwEEtm6GB1H2tAJ3PZ86jlmVPk8j1P/tSeg27D9o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PMPMjnrsh+oo9DRbtoAHkUp9t15H5fTMMY4nHtcCkvvmXUMXB3W+hIJLI2REi9vVuhOrSLLXSWheXIziXWNlaFo60nrbVcFmoUYMbYwJgamC/9Dpw8D70E5NCyTzbfUmcRYF9+hyUSShvia5DX6DZpDapYt/p8c0OiqRwTrzlZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PvnMy8qI; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORJRjXjuHULHyssnj2NiIzwJ+WQFjbTBKV87+v8ixLuLnk6W0SPVQCzfaKcImIH3fTixpGLl30RypMT5io6ZtEqWoToh2mStf6n/GY7V8i0Xdc8S3OvZDS1fztxwvJM8bt0HgaJIDWADDbwSux7OOjkGpWIqME2h4bU/gY+EuZq/NaubUf6Kk9SAxw6R3z3EDgfyajpem58idvcj0FnCetj5P7YcvB2GmxODCL7a43uGVp2sLIawJLyYEfCQ+1M5rtKP8yvmJhTkcwrL+99VHEnFDBWOMSjbHAQrCqo6K4TYNDZhic9m0kZ2mpJcU07Pz+qYXa8Zhin2sbWW33MsdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHSTzUT4XvGDuqOrlYPPnNEC7uP97xkAZ7P4woQfSdo=;
 b=fMWjLw7bHxFidR3vXhtkY4oNLjNRN0405mDpQXMe955Lj50/s5w1mJSZEeQ8UMZ2TB552rEA8UE0g9oE2TwBs1qqGG266OU2bcuyqAlNGhnebgPwzbHxis4+W6Z7vtg3k2XfYoBO/jTvIMOJnQmuZEpBVAoxl3G8eVoBBSqGC7PxMaF4UgLWyZmS1uAi2B4ppqnc+3ErFo77sMNS91cehi+G7kD0yhok4GjijYiw4OsY0UpsfEvM70i/lxj4dx88qQTQTPPk2CMPZ0qYU1XoPJHn+At3CbiADlw1kGvmhg2CvGWaMIXgk5MojmMayjkk2yGXYfqmIUh1Utvv5Xa9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHSTzUT4XvGDuqOrlYPPnNEC7uP97xkAZ7P4woQfSdo=;
 b=PvnMy8qI++NDQU4OzIlLoOX4Zi/kGjLowabeRLExbgazQDNqNrdmV7evTb7VVyq1oBC2Y+XH9509kWYono01DaemZonP+e0ksV77duSzE2+xmYdHEypPbesdEuHVvME04o92B/xE04myBPGct468IuSYrvGbM0lJGGm+D73PZd0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 19:45:04 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 19:45:04 +0000
Message-ID: <b09e5829-6192-47f0-aed4-93116c33f4a0@amd.com>
Date: Tue, 11 Feb 2025 13:44:59 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 10/23] x86/resctrl: Remove MSR reading of event
 configuration value
To: Xin Li <xin@zytor.com>, Reinette Chatre <reinette.chatre@intel.com>,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, tony.luck@intel.com, peternewman@google.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, jpoimboe@kernel.org, perry.yuan@amd.com,
 sandipan.das@amd.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 seanjc@google.com, xin3.li@intel.com, andrew.cooper3@citrix.com,
 ebiggers@google.com, mario.limonciello@amd.com, james.morse@arm.com,
 tan.shaopeng@fujitsu.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
 eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <b4298186c0be8db76be4eb74e1d948fbe5c1de7d.1737577229.git.babu.moger@amd.com>
 <ead5a097-44f7-4eaa-8e98-08450b4d51f6@zytor.com>
 <ffb74a45-ca63-46a4-9047-d55c9f51375a@intel.com>
 <0fc8dbd4-07d8-40bd-8eec-402b48762807@zytor.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <0fc8dbd4-07d8-40bd-8eec-402b48762807@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0024.namprd21.prod.outlook.com
 (2603:10b6:805:106::34) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: bc55042b-60e3-4889-4910-08dd4ad4947b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0NscjlkR2lQTEc2MDEvZjRaVWI4a0hlMUhodlJUMm1pYTdQclZtc0NSemVO?=
 =?utf-8?B?d2RwU0R0MjZ1WEs1NmcwQWlreWU0ekYzdklmUWxhazlKTktKUUczRGo4QlVE?=
 =?utf-8?B?RGJpYnJIVXZndDNhTUZWcW1qT0lUWEQ2aEFDcnNjNzRWUmlHbkcvMnlkcERT?=
 =?utf-8?B?eFVwaGR6OG9GWjl0S3o5NUNlWGIrU20zcEZrQXl4ZXhiNHpKQTNsNlp4UWNm?=
 =?utf-8?B?ZGloeFZ5OHVLZk5NK2l2OWdidXJuZERRMnp6TEdDSEtrcEN2aVBYOU1TT0pP?=
 =?utf-8?B?QU8xR0VqWnFQQm1ocFZaNzdmYTBYZm5SVWR3eFVYeWNvdk12QStpU1VmZUkv?=
 =?utf-8?B?ay9pMjhYRmk2RElyamRGdVN6WXZrNTFZd0xXb2IzbC9WMFpzcnYyclhyV1Rv?=
 =?utf-8?B?ZXVybkd6SVY5NTFvWWo5YXlCWTcybENRN1ZmS2pmS2Znc3FuTUNhWitTVHZ2?=
 =?utf-8?B?OWY3NVVxKzNPcFN2dFkwMFlwMGg4OEcrTm54T09LdlFrTHAxTzUzYTg4dDda?=
 =?utf-8?B?c3ZlaXFtcVFoU21Uby9mTVlwalcrejh5ZitFQWlXb3dMREVlaDJMenJnTlF4?=
 =?utf-8?B?OXZKTkxoR3RRRWw3QmJSQWY4SGdQa29vYk5oUE52U05pQ1FkSzVYUlJubzFi?=
 =?utf-8?B?ZFJqNFg1KytXS1ZhQUVHa1BlSit0OEdRNUdzR1A3ZjNRVmRnWS95Vjc3VVJE?=
 =?utf-8?B?bkVvdW1BVitpa0d0aitkMWR2eUU5SzhIVVFqNmp6RGJ1UDVyeXNWVUpMUjN1?=
 =?utf-8?B?SXd1KzgzOFZpZW85dTZxNWR6Sm4vaENUVDNrRVMycUYyaG4yczN5YmovMEJM?=
 =?utf-8?B?ZG5GK1p1VytsclpYSFZhVzVabmpUSkd4RTlBNWxmcFVGVU9FaGl4QlJQNE53?=
 =?utf-8?B?R0ZpK0EzbUdoMHBvYzJSTmhvdkRicG9KQWl1a1RUdFFlR0tNdHdtWmhjK0JU?=
 =?utf-8?B?QWhnL3k4dWVUdDkxT0dZWDkra0tyU3BlWmtPVHppUFZ0ZGVvMk03bzBvUk1C?=
 =?utf-8?B?OFgyQ1VtMDhpYTZBWVNVYk1rWGRCbmhYNEwxOFdTeExjU00rcldEYk4yRTYx?=
 =?utf-8?B?Q2FBcUdTWTd5T0NKYnphYU1sQzFQUi9Xc1o1VGRlY1NmZGVNa2hxU0xZRHg4?=
 =?utf-8?B?QVlWMkM1TDcrdUtqRzFMV2FRN2J2UUZQTEVBRHRadm9RdzE1ZDRnT2Y4N0xh?=
 =?utf-8?B?Z1g1Tm9vV3RYSjhPY0hBS05hWGU2L0czTlJwQVoyR0Jzb0RITHpFdmRYcm1U?=
 =?utf-8?B?SklDZGtKY3F6YVlJNUtBeldLK3VFQ3NXbGZmUkVxVXlaWjVvOHlyZkpOS0RH?=
 =?utf-8?B?WHVaNElTNEE3ckZnM293MEt1ckhoY2sxRW43OU1QMjZKUkp3REFrMHNpQVow?=
 =?utf-8?B?Ly95UWNFSU9KSzQzN2RYZ0hZWmgyQnRFRDNXYjl3MEVOOXF3YXdQVDhWRElV?=
 =?utf-8?B?SWRLSGZLVEthVWF0UmNTRGNpY3FzVWlob0xsa015eWFyc1d5YmlEVHc1bmp4?=
 =?utf-8?B?bnNFZnZ6RDRwZXFyT1BGRmJLWGVQWk9IWnhOdUxuZDhJdXNoeTZvY1hSdjBJ?=
 =?utf-8?B?aG5ENUc3aGRwaHFHYVB2YVRRRWVoTkdLZGYzMlBqWE9yMmxleEJxUThYN0Z2?=
 =?utf-8?B?MnI0SVNZb2NuZ29rYU9ucUJjMko4V1VwVm9CR0gyZVoxYisySUJIK0UzL1No?=
 =?utf-8?B?d3JGREJoelRVaDNpRVU5T1AwNjhqTVY0VkFZaFAvQm9SUjZFZXZBd0ZyTUVZ?=
 =?utf-8?B?azdpbXVvL2dta05BS3pSZ2t5cVE0SnRjL1c4Snp4WjBnckJRZ1FWOFRpaGNS?=
 =?utf-8?B?dUZjSDFZS0xpYlZncmJ4N0tPZXo1MTJPSHFlbGJHSjZUYTAxelk5Skw1QmRV?=
 =?utf-8?Q?nep/DC4bAlrXH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2ZpdlgwTUNGa25LRWJ6bElqOGR0NUlnMEwzd3pkcVQrT3M4NVBkaGgwQTlt?=
 =?utf-8?B?N01ZSmxhbjJNWTZieU4wL1U3M1A3VDhhOFR1TFVOejVPaEhTL3JpNGVCZno4?=
 =?utf-8?B?WDc0OTg4VnJEdlVFT1pFQUt6bS9rWEg1cUgrdmZSbVg5eDRaaVJGckZiK1ZB?=
 =?utf-8?B?ZnVRdTBPVkVqMUZwMi9Kb0VKc1RkbHJlVkhlQ2lUUjRIWTFJemVwVDh5V0Fa?=
 =?utf-8?B?TUxveDcyeW9oV082bmt4eUtlRnFERHVBbGlyUDl3dlpOaThpUWVraE1MTGta?=
 =?utf-8?B?cTREend4Yy9CdmVtdG9DQ0dIdkdQSHJ6aDRmQlZJQ0RXMlNoQVBuOFdMMUc0?=
 =?utf-8?B?R05qc3FrTGVMV21Cbmd4Y3N2TUF2TGFwUWhVSlo5cGlaRkdmaFYzRTlydnZ4?=
 =?utf-8?B?QTV2S1REVGJkeW40My9OV2FrdTRTejlnYlgxNmdOSW15eDJ2Y0RadDF5blJB?=
 =?utf-8?B?ZDlTTDUxbUUvcmhmb1VEcElvT2JPQ1phcWsxN2FxcGhMc2NTR1hYbFB1L0w4?=
 =?utf-8?B?YlV3TVkwTTVNMGpoRlhRWGpGaEFIdEVPSi8wUFhIbmtsc29ENzlyajdPeVJv?=
 =?utf-8?B?S0VKQ1FzWU9WbU5kcXVHNG1OMC94Nk4xUEZpNHRKcGVRTnRUbzcvZW8rbk1I?=
 =?utf-8?B?UnRnckE3Uy9qUGFXdUhJZXZ0VTZMM1JHT1RQU3FMSjVxKzFoZUgzLzJLcllL?=
 =?utf-8?B?bTQvdnY5VU1DTmpIakVubHZ6WnpLdGF0YWEwVjNUSkxtT3NVT1FiVDNXa3U5?=
 =?utf-8?B?Q0pDUyswT2c1amR3R0JZdTlXT3IrN0hORUtnSnVCZzBuQmdvSzg5RHJsWnE0?=
 =?utf-8?B?U3E4c2lPZ1EwVDhMcWdMY01sRHRUdi85Y3B0RUJ6eHA1ckpGZFhORStoLzVt?=
 =?utf-8?B?bHFNcCtNeEw3dmFJa2YvNUVMOHBmRWxpa3MzeTh0N29MYTZmenFHaVhlelIx?=
 =?utf-8?B?cWFQSUh2T2wxazBzSWkxbHVKOTN5NnlkVzRHVmh2VFBnRWsvSUhwYnJMeEM5?=
 =?utf-8?B?N0Z0SXczTDRCV3FObk1XSGFyWUxPU1dwZG5GUGJDK0MyakorU054Q3ovM3c3?=
 =?utf-8?B?c09kOG5SaW12Qllsb3dHQjlocG1nZDIwR2FDRTZ4ZFkzYXV5MVRBa214cWlD?=
 =?utf-8?B?SGd2djhBdmZiMzFNM1YrTnk5QTgvOXhYSUc1NUpGZ3FlTkZrVWFKVzZpTmQ1?=
 =?utf-8?B?OXpzQ3FNVWp6M09RcHRmT01WajRrQmJGdFREWWRraDVmRGhvL2VPSmowZDJs?=
 =?utf-8?B?eWh0MThza1lldXhaOEx4OUxORlNhampVMnByQURrRFg3ZWJFUnhGNU14emxO?=
 =?utf-8?B?QVRIcW1UaWtzMVd0VzZhcmlyT2J4dFRqUXJaNGNEeTN3alRndldQOGo1Tktn?=
 =?utf-8?B?U3BTRVZleE5MZHE4akFvY0hWVHNpNEFuQURxUjlob2lSczhEd0hDTGVGSW0z?=
 =?utf-8?B?STAwcXdSOGFXYlZkRzMyNWI1YVdrZlJnSDY5UGhuL0gvaitkRWx3bERGVmRF?=
 =?utf-8?B?QkhQVlczY3ZJcldRV1Z3VTd0alF3NE1qcWkzcnp6MlFRQ2JCZXR6T0lSSnJt?=
 =?utf-8?B?L2lYVUFXZTZaSm50MkU3TElXODl2ekUwUnB0dTk4Nm1MTjZmQnJONG0rMW0y?=
 =?utf-8?B?aEVhQXZiSmk4L3h0QTJNRlJCWnViZTlZNFBrdHQ2SDhGTitwYWVqVm1uSlBO?=
 =?utf-8?B?TnJZa1FLQTM3d0E4TDNQMnFzNmJDSGNtUFpQVnhvWG9DTnYyN0QwYVNRc3ZH?=
 =?utf-8?B?VkNuYWg2d0ZxWHpwTVhJMmRXKyt6akJrdmZCSTNPend2RmcyenJ5T0FUcHZ1?=
 =?utf-8?B?UjJnQmxiZk1HcnZuSTd4TVpLNGFvUSs2R041NUxuN0xjeTNET2QweWNUbzk0?=
 =?utf-8?B?bHRFVm5aVUtDd0M3aWxUT01QVVFISHJ1emJscEkvNHF5MkpYVFdoM3lqemFN?=
 =?utf-8?B?Z1pZR1NKUmJvN2VoL0wwRHIyQXdmYmtFWXV5NGYyZloyejZadFd3T1B4SnA4?=
 =?utf-8?B?UHpGU0lZT21EQjNkdTVvQlZqeXF2dG5ZN2NYNGZIN3kxWnBEVWtMUTJmenVZ?=
 =?utf-8?B?cVVxR3g5UGF4UWVGVUh2TXV2bHphVlBqTTBWWXlJY2dMcmVEemx5VmJEcGU5?=
 =?utf-8?Q?7wtw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc55042b-60e3-4889-4910-08dd4ad4947b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:45:04.5200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BK4yJ7dwQHkhg6OQYlKrhtTFGt8COG9pz8eO4Zhh/Lop/mnx6VnGdf7MB57cSjZ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369

Hi Xin,

On 2/7/25 04:07, Xin Li wrote:
> On 2/6/2025 8:17 AM, Reinette Chatre wrote:
>>>> +    wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
>>> This is the existing code, however it would be better to use wrmsrl()
>>> when the higher 32-bit are all 0s:
>>>
>>>      wrmsrl(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config);
>>>
>> Could you please elaborate what makes this change better?
> 
> In short, it takes one less argument, and doesn't pass an argument of 0.
> 
> The longer story is that hpa and I are refactoring the MSR access APIs
> to accommodate the immediate form of MSR access instructions.  And we
> are not happy about that there are too many MSR access APIs and their
> uses are *random*.  The native wrmsr() and wrmsrl() are essentially the
> same and the only difference is that wrmsr() passes a 64-bit value to be
> written into a MSR in *2* u32 arguments.  But we already have struct msr
> defined in asm/shared/msr.h as:
>     struct msr {
>             union {
>                     struct {
>                             u32 l;
>                             u32 h;
>                     };
>                     u64 q;
>             };
>     };
> 
> it's more natural to do the same job with this data structure in most
> cases.  And we want to remove wrmsr() and only keep wrmsrl(), thus a
> developer won't have to figure out which one is better to use :-P.
> 
> For that to happen, one cleanup is to replace wrmsr(msr, low, 0) with
> wrmsrl(msr, low) (low is automatically converted to u64 from u32).
> 
> However, I'm fine if Babu wants to keep it as-is.

Thanks for the explanation.  Changed it to use wrmsrl().

-- 
Thanks
Babu Moger

