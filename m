Return-Path: <linux-kernel+bounces-364605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D32999D6C8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138A1281BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3751CACDE;
	Mon, 14 Oct 2024 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kMRZl6ON"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC7A4683;
	Mon, 14 Oct 2024 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728931905; cv=fail; b=DiTqU3b6rJ4MI3z0SKzAEkAR7qhvOUfrBKRojc3XUqGjE4AHZJG5N4d+yTlry3PDuX4DgNTKKU8911Qt8E7sZAK+SgezkgQlYjCejWymElXM/ZadbQ9I0L6KnPyCYukfy/OmKhzLc6aioRJR3WZ6EMOJoOEUGOhVKwYxaqO9UmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728931905; c=relaxed/simple;
	bh=GfSHEmznaCMXw5Wwqo1q0kRoJw84krh8s3m/ZCQDj1g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ao3qRonqT8Pep0ozCOhHVMimA0Ikz7JJljYE77KyKgYeiWikiOQ9LAXdI/F0mfK0+Nbznm0VBR6svsqmJjL3bR3tQt5ezFCLJoPtfn48cujqAqEXFomUKgdjS59p7AB5MpxXTzs+HbRbbyhGRGYPN+atpK4jIIA8PGny7fsQOrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kMRZl6ON; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnFTyG8lLQ/tOkIcByA2QM1SRy9v2cDMFnG0wOjzCRI+e3RQUwHzhEmRvl01agCuZ6aPQdu9E831lpXVEa0mT6oLkZsLX852bTp+6ez5Fz8O1EQU1gFUfVtdmwMkR7cXdXwGlsFkFyqvIdPkvMWtOAKocOaiFQ2wEmJuvrreZXvy7nCh159XJpAokd1wTM7in3a0YVZKAt/bqwfzuZZM6fCOCb/5z+v+np4o5/dqV5hrWyGkV/zHd7cQH3BQnL/lYiDiTmcHpzVjYtnx9R0UUXlVoTAK1+HcRbosbicUiPaU/d5iz0qWJEbU3+Pj6vvJLFVaPX96itMS6MZAspv/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atu0Yk1ToYqgR3+kysF+g+99BNTfl7CqwKO2F77B5xs=;
 b=vRVuLZkbW4HSN1rYq5Qxs2hBB9sbKJ+8EwH1wCuZyms4vfF7gw3a9K+WA/9DoH59GXrB+ox7MxaQDd0d4h91da4YIylBaUb0Fv/KKrM1WxUm9Z8okJAb7QiRoCFWf53Rvo3EEmn4z8X+Straq0tWMG8D033JygKlg3JI+5vcpmWrAre1if2IU3Tuey984dxJOHnYqbsnkRwfyVM3TqjGxd8XFcehZB3gGfg7yCCY1f9u75ItuWR2JDpzXLUc9GJ4ChbEpxzuOAuLi75vrIUMelVrOlpCZcM9/lTobg7qMIvRRZajisfZfV9kY8XOQ1tKbTdNchiOztr32ke1QmgXWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atu0Yk1ToYqgR3+kysF+g+99BNTfl7CqwKO2F77B5xs=;
 b=kMRZl6ONpagIp/cXSS5Ptn/wDGWZgg97fjhF3biSVf7y0wr80br/tCTm3RDXrJ+VJog7WEfFxsoP/4u5F6KboMvLk9BW2JbXkNr+A9PdqWTUJN2HRjHAwyVIa1oPkOVsBGmlblxyaSgVLlTGZF5MovegD9ByirDrNOackwSnVZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 18:51:41 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 18:51:41 +0000
Message-ID: <456e0266-2ec5-41a8-8808-080c8b9607d8@amd.com>
Date: Mon, 14 Oct 2024 13:51:37 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
To: Reinette Chatre <reinette.chatre@intel.com>,
 Tony Luck <tony.luck@intel.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1728495588.git.babu.moger@amd.com>
 <c79fdf4196d974325df995eb334221463747689e.1728495588.git.babu.moger@amd.com>
 <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
 <ceeaf5a7-190e-4c29-89da-ba9e83693360@intel.com>
 <91f63f7b-32e8-4a67-9851-1c080fe62e23@amd.com>
 <7687ed8b-006d-4a92-b9d1-64fa952ede1d@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <7687ed8b-006d-4a92-b9d1-64fa952ede1d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:806:122::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: cc931967-01a8-47e1-f604-08dcec813dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UCs0V2RpNVdQenJJYlQ1V0ZEOVBjQ2tCYUQvaE5KWnEzY2dvdXZ1VDUxaENl?=
 =?utf-8?B?aUY0ei9HREpualFNOElxR2VxVE1yT2UzQW4wWTluNFFlQSsxVXBENHo5U01Q?=
 =?utf-8?B?MmRnUDNXQVI5V1lHZXVQUzhjVkhmYTZYV3RYREMvc2dhMUZsUWdmUGczZzhl?=
 =?utf-8?B?N3QrK29LN0Z6SlhvUTlKVm5BREVoU09MeHhiYW00M0Q1K2RFNXNBQWdEOHFH?=
 =?utf-8?B?RzIzcTRMMU5iRzBmS2FsaGtoRUlmREpmTXJlSXdhdk1od243ejRTVHg3eG12?=
 =?utf-8?B?S20xdXNTV0RUWDRaYndqNU9HL3JGM0xVMEFJWW1MTXJFUzg1ejVSaVFVYWxx?=
 =?utf-8?B?U3M1MUxlcmFYNy9BMVJVVHJOV21rOEpmQVRKdnk0YkRHUnJFUU51enQzT001?=
 =?utf-8?B?cUt6KzdOaTNrOHRvOG9vYnNZdk42UGI4dWRuVG5hL05jVnh1WHdyRHF6THhm?=
 =?utf-8?B?UFEwMHU3NkZNNko5N1h4TERBeWN5QTduYk5WS1pBRkJSZVVRTDdObEJ2eXdG?=
 =?utf-8?B?bzBxRWx0THhxdS95NnFWYWNia2FxcTkvS1hLNVpXL2VORXNmRk5pbWxISGxi?=
 =?utf-8?B?RmVqQzlheWV1Ly80Y0pyVXBVa2NTeU5RajFUUWhSeHFmZHkyTVVLY3pBVTZQ?=
 =?utf-8?B?b1VnRjVFamFJNmZUUXJJQ2FySDhVZkdscnhxV21Fa25ZODlvYWdrOVJ1V09T?=
 =?utf-8?B?OExrQUlTZUR3bzA5U0FpbzVnSWtFVjNvVlBIVFM4QWpzbUFvTXVuWTN1VzN6?=
 =?utf-8?B?SGVuREpyWEFuc3d6T1NsWlVDZHkwVG93VGpTWjJqV0hOS0lXa3lwbCtYbFVp?=
 =?utf-8?B?bnBNSUNVeHlvalZRMzkzWWYvMG03UU1HM3dCM1RhQ3BYdEszR1FBZ0s2RGVX?=
 =?utf-8?B?WmYxOFUvaGhhRndvVVJtZWgrMkFxNEFwNkVIZmVFMktoUWlZNnRhMEl0L05p?=
 =?utf-8?B?ZlFlU0tVbk5vV3h3RGlRdWVrQWxUajYwTkVlemYvLzhXM1QwRVA0dDE1WXNh?=
 =?utf-8?B?MEY4L25FK3A4YVo4RlVZVXlmaXVTQzBRVmNqT05ZclJYNVlQSVhmRVIzanNo?=
 =?utf-8?B?MXZORHA2TG94NkRxV3JGNmlBaGNsdkNYdFk3cTc1QWFoSmRqb2pxOEg4VVFI?=
 =?utf-8?B?TCszdjVFcXhLNXYvT0dhcmx5NlZ5Q2hLbVF2T0lkTnJBOVBEZDdXT1BZc3ZU?=
 =?utf-8?B?dklvMEhGS1RZZ2t0NTZndGNGeStjR3hKeWxEcmMyWUVCTHhaRmVqS1UyeGFZ?=
 =?utf-8?B?QWx6QS9LcE55eTN5Y0dlVGgvSHM3TXB4dmFXVVhXb3IrWEhUVEozaTdRU0hN?=
 =?utf-8?B?RmliRHRJOWVTWjhpY3ZCTUNETFJVK0NvSnBsNzFDL3poRWZYNlJZV3lZZy83?=
 =?utf-8?B?SmZzMEZHNVFQaSt6dGI1ZTZsNzZrbnRRdzdFNUFYcXRkWHRlaENHSW4rbWk2?=
 =?utf-8?B?UGY3Tk1tOUdLOUxKcFZSWCs3WCthcmgxeGZ5cUFPSFdaWlFGbFVtQktmQ1pF?=
 =?utf-8?B?cmZHU1EyODBjV2VueTdTNkJaNkw0OGZvdHRHcERsdG1LdGRkRnpzZ1hyeksx?=
 =?utf-8?B?OHRXOW5Vc3hudUhYblhFZFlCbXZsdVdZRDVJN09LTUwvd3k1TGdwa3NMWi91?=
 =?utf-8?B?d08vSFNBZVhBZWZFK1hqQ1VjekFPT2xodXo2M3NQVmVFUXg2WTk2R0ZjVGJ6?=
 =?utf-8?B?YmxsTXBPd2dPd2kxOVlCdFlIVDIzK3dja0JPN2M5OU5OYm12Q2FRdG13PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vkhoa0l1ejQ3dmorWm9UZ09RalNyRWJsTUYxbkVKWTJpVU1LbFcwWUN3dlND?=
 =?utf-8?B?K21SdmVkUXBWWm1mS01KbWd0TzJLVWluMXBVY1hOYnR6bFNVbmVGZFpjZ3Ru?=
 =?utf-8?B?OERUVVZSMkF1RnZ3eXU0Z092RDA2bWhiL3F6T3Q3QnZHM3NxaTVHUUhOcU8r?=
 =?utf-8?B?dzNSOUF0NjY5L1VveE1VQVRvQ1JXaHZjWGczMkVQN1VXalJXR0xCNVE0S2w1?=
 =?utf-8?B?bTc3Z1N2ZVFlUnZZSEcyWTREQmtDMVI3ZC92SUViSXFnOUZaenRYd3VxajlS?=
 =?utf-8?B?azB3Qm5FbFRtOElXZTJKR1ZnRlMzTm92bSsydWowYVNEK1RpWWdsOTZtbnZY?=
 =?utf-8?B?MFVVV09XU0VHVmpEM1FiV1ZHY0xYZ0IwcHZMcTBORXNjUEFkSVJXQTRjSEpD?=
 =?utf-8?B?S3VzY05qaEJBTThSUFVwRTcwU1JVWURvVzNOTS9neHlmamFqaGcwd1p0bENR?=
 =?utf-8?B?NFdZTWUxbkh0c01kVkpncjJyMElOTW9SUzB3ZmFMQjRCdU5FcXM2MGlyQ3Y2?=
 =?utf-8?B?bzJuV1dFQWo5RkxLY1NySVVMYVRoaU1EWTAxaVJHUjNpZkxWbzRLdmxRNmFt?=
 =?utf-8?B?Y1o0RXBldmpEbkcvRVByTXkremNHWXV6eTl3TzhGM0ptYi9sdy9HRElFUnJt?=
 =?utf-8?B?MExRT2dJc2JISmh5SHh6UFBoRnl0aGo0aXVLSEovQU9kQ1FnSDNqZHd6VTBD?=
 =?utf-8?B?V0FKRk1TbTRnR1VqRExVcll5eUNpS09zOVJQNnNDWitmNlZuckx3cWpaSGpZ?=
 =?utf-8?B?dXduZTkyY3hwTG5iaDdzWXY2emtxUWpoSVpseS81WlppRUFVK1NwTU4rSE9W?=
 =?utf-8?B?N3AranZZcEE1L0JWOGkwZzhmZUdGOGswN1pWbFY5N2QyNzFqcXh2d01YYXJu?=
 =?utf-8?B?dGZ4cjJMTmJMNVZPT2Fwdi9FYmJ4NFBBRkh2RlZGZDR5ejErblVwaXN2NTQ2?=
 =?utf-8?B?SzVzb0FjUFFKYWw3cjhKSGFmWllmMHVEMmdBSWJNZ2F6Zk0rSzMyYklXdjB3?=
 =?utf-8?B?ZUhHTEFLUVpLU0N0MzZiZFE2L28yVmkrbW1LWTZhQnZPVDFvbjVWcHRXZkJj?=
 =?utf-8?B?eFJKZXl0Ykd3OWhqRUJ6c1lrTFF0VDNpSFlhS1FiR2ZtTmkzOHJ5d2l3QU1V?=
 =?utf-8?B?dC93VXZlRGUxTzFiWFZtb1hzd0s2TnpTa3lkNWNXVFQ0TWdoV0NUL0V1enc2?=
 =?utf-8?B?L1RXZW5kOHU4dmh0ZnlKVVB6cGxYaWNNVjFMU0VzcWdGeWczS3JXSlp3cGFm?=
 =?utf-8?B?bXkxMmxxc2xYSXM4RUNDZ0pySW8zaVlRWXplKzFzTUdpOHZXaWFJUnlBRllu?=
 =?utf-8?B?T05mWXN0UGQ0ZnZlMDVtNG9EU2ZrcEU0QTZYR1Q5RG1uWGxKRzdnWDRVbFFN?=
 =?utf-8?B?NVJpdkNNUkg1c0pWNGFJZEhRU3lhM1VVSGZYT0ZscE5JR0tRaDdzTGdqdzdH?=
 =?utf-8?B?dUo4OEpCbzFGODJidjloUWJoK1hGWGhab0JDTlhsMjBSOEtLZGhhVkM4WERu?=
 =?utf-8?B?SVg0M1JhR1hZY3RiU0Yram9WN3pCNkZ1cGZhZU9uWTF3UUpGL28wY1ZaVmRt?=
 =?utf-8?B?WTFlY21PcHNvVmF2UzUzY3ZWSVJsdXpsbHM3MUp2VmRMbnhPY0RqaStpQjhm?=
 =?utf-8?B?ODdBRWZxYjMwN0dnMVRObStjMnJNM3kxRHV4WlV1RFNGTXZyODJxSGdXTllX?=
 =?utf-8?B?aEhrbnZnWEFsbWNkUjZydGZORFBhcDBENWNJVUd3SlYrOWlBSHEvU3RjU1M1?=
 =?utf-8?B?Q0ZySHQ0Ylo0eElaRDN3SkJ2TnFoaUFpOUJIMWZqa2hTM2NCdkFENHVYanBJ?=
 =?utf-8?B?YmNjSHZYNk13dUl1dXdjODV2YUllU091dThHMWRrVXRpL1pVdVdzMEwzNEor?=
 =?utf-8?B?SnU5eWpITkd3MldHbFZOSTVsMGJTUUhwbzRVMnFqcy94Zm1BRWxYK25zK2p1?=
 =?utf-8?B?SThiZXk4SFdyUUlFQ0kxSmxGTnh6N3BBTHMzV3cxNGxrcXV3cE4rOWxNbWJD?=
 =?utf-8?B?eGh3Z2hoUnI2VDdVWHo0Vzg3aGFVeDFwdmhWdkRNemVER2JLZW9XSytkaE9v?=
 =?utf-8?B?Q09qcDQreHI1UzIxMmFUaW1kdktkR1NaWEhKVGF5Q1lYcDUxUzRablBDSTBJ?=
 =?utf-8?Q?/4hQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc931967-01a8-47e1-f604-08dcec813dd3
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 18:51:41.3144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDeUZRwOIwpQ8icnbGZIZQwdO7Is734i6LGz+KegMfUt0Qgx+aaY6Ft9No5Awk/A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782

Hi Reinette,

On 10/14/24 13:30, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/14/24 10:46 AM, Moger, Babu wrote:
>> On 10/14/24 11:25, Reinette Chatre wrote:
>>> On 10/10/24 8:12 AM, Moger, Babu wrote:
>>>>
>>>> All good points. How about this text:
>>>>
>>>> "num_mbm_cntrs":
>>>> The number of monitoring counters available for assignment when the
>>>> architecture supports mbm_cntr_assign mode.
>>>>
>>>> Resctrl subsystem provides the interface to count maximum of two memory
>>>
>>> subsystem -> filesystem
>>
>> Sure.
>>>
>>>> bandwidth events per group, from a combination of available total and
>>>
>>> Is this "from a combination of ..." snippet intended to hint at BMEC?
>>
>> No. We support 2 MBM events right now. That is why I added combination of
>> total and local. I can remove that text.
>>
>>>
>>>> local events. Keeping the current interface, users can enable a maximum of
>>>
>>> What is meant by "Keeping the current interface"? Which interface? What will
>>> "current" mean when a user reads this documentation?
>>
>> I meant not to change any interface to support mbm_cntrl_assign feature.
>>
>>>
>>>> 2 counters per group. User will also have the option to enable only one
>>>
>>> "User will also have" is talking about the future. When will this be the case?
>>
>> Again.. will have change the text here.
>>
>>>
>>>> counter to the group to maximize the number of groups monitored.
>>>>
>>>>
>>>
>>> I think that we need to be careful when making this documentation so specific
>>> to the ABMC implementation. We already know that "soft-ABMC" is coming and
>>> Peter already shared [1] that with software assignment it will not be possible
>>> to assign counters to individual events. 
>>>
>>> The goal of this work is to create a generic interface and this is the documentation
>>> for it. If this documentation is created to be specific to the first implementation
>>> it will make it difficult to use this same interface to support other
>>> implementations.
>>>
>>
>> Agree.
>>
>> How about this?
>>
>>
>> "num_mbm_cntrs":
>> The number of monitoring counters available for assignment when the
>> architecture supports mbm_cntr_assign mode.
>>
>> The resctrl filesystem allows user track up to two memory bandwidth events
>> per group, using a mix of total and local events. Users can enable up to 2
> 
> "a mix of" remains unclear to me since there are only two options. I think we
> can be specific here.
> 
>> counters per group. There's also an option to enable just one counter per
>> group, which allows monitoring more groups.
>>
> 
> How about below for the second paragraph:
> 
> 	The resctrl filesystem supports tracking up to two memory bandwidth
> 	events per monitoring group: mbm_total_bytes and/or mbm_local_bytes.
> 	Up to two counters can be assigned per monitoring group, one for each
> 	memory bandwidth event. More monitoring groups can be tracked by
> 	assigning one counter per monitoring group. However, doing so limits
> 	memory bandwidth tracking to a single memory bandwidth event per
> 	monitoring group.
>  

Sure. Looks good.
-- 
Thanks
Babu Moger

