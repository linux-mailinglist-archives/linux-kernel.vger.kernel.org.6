Return-Path: <linux-kernel+bounces-519758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC30DA3A18D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3EEB3AFEB9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E55F26B2B2;
	Tue, 18 Feb 2025 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XCAiNQR/"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8863C26D5B2;
	Tue, 18 Feb 2025 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893192; cv=fail; b=B1aWtu62OIsqk1r+5k9OLPX3+6MHNOiUgXC8NM9oK9qoBD8Dg0+DaXmZtWqrE2etYBs/E0K5ooZ62YkojTna2VHNnpIoP6QJtQuL3xdqJiTmflCoZn2KGEg+K3fCdXr9wRvP9o0p2N8pRImsHMXfamZBPkUdrdFX06ZsAX4ZaBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893192; c=relaxed/simple;
	bh=jWwNkR52mWd0oRj4s7NduYjacYmrp4YX4KIOrzn++5s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YLAo0neFk9ckl/0H+bAlw8WT7kRtTBPzuuaVixe5O9AinLSWizRzVVacVuee0bxQ+fX8irigFxbc3AxhTsomLG5IZgztVq5M98JG3E4B9kbNw6RWUqG8/Gd/9TsyirSo3kCUVygtkfS2bZ18ks9t/2CzBB+Z28d49KHMxLufT9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XCAiNQR/; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ofmtq8BlE/xmk/PB6UER2XQhSkmbvGdWRLzcYIbaj92L/2niX37sBp1IICsjnr/LvrqRLemd7GVOMMrbuvMUJNjDqeJCDnt7vfUPnKPWi8G03Q5jJkhmYlgaH1NVAyrBnqYhSP2Ixc8VMmJu0CHii0FBTyFvPS6qykNZcLxqbKuDFRQG9HE5B3Y8SScmuq569tiwaRuK8/LOkoPiW8f56I/4CCnE6A6s5jj5VEeVY0shk8Kqi6WBZ7+3xutqStkGM9CgylsvQZjt1aNR07Qksi0U/ggFgBv1/Pg3aaMEERA3v17mrzfVlio6C+eg95evSnR6ZlubDeRMvKUI7HrmlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdXtpm5KxGghDVKKtOxp1xFU+dCXWd1dB0/scy2cfn0=;
 b=yEVfh2tYadxMTdRAVy0YN1EWQnaaBfTCyYjcoP7DdxdJdrD1K9b4ZAjWIC2+HsL2HbXBK33eGm5dUJ8iAwcQIZ2HBRmW2YJt6ZUVmgMmkFftoRR767Dly2XtHYhAgeqC68bffdp3PwsOArdoNy3BTjedEupqco3LhcShV8VYzOAVAe8FPfTTvScjDfU25VORG9DWtPM6fp78w0Ozw6BCRC30eXFvRkvt+YhRcqx4QqYcjwolVJL6iw1J0Io+yJStbkuC+cL/5T1nqbZf/hUxrxEWt+/NB6BMSwl+xa2j8+aIZKNzF5xbvMEzAsvmjK/wiFXJ+G7inAXHsdxoOKq+fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdXtpm5KxGghDVKKtOxp1xFU+dCXWd1dB0/scy2cfn0=;
 b=XCAiNQR/KdhRL1JpdiUCROFdviWU43Vf+xd9329DWL2XZyTmKZ6e/ChWXmdfR/qGFW9JGc3c6kpIOQMPnqVsNfmOOsxxSqBkWM1Fe/9buGNlwkkHdpx3c2b5ZQKdtONNx/IBDeCFKrr/p5LnSquLAVauWf0AMCkA2cI6+oqtr30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 15:39:47 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 15:39:47 +0000
Message-ID: <56a48b63-7625-4d90-81bb-29a1eb588871@amd.com>
Date: Tue, 18 Feb 2025 09:39:43 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Dave Martin <Dave.Martin@arm.com>,
 "reinette.chatre@intel.com" <reinette.chatre@intel.com>
Cc: Peter Newman <peternewman@google.com>,
 Reinette Chatre <reinette.chatre@intel.com>, "Moger, Babu" <bmoger@amd.com>,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, tony.luck@intel.com, x86@kernel.org,
 hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
 thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
 mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <bdb48b29-92cf-4f98-b375-25ec84f0941a@amd.com>
 <Z7R9VedhOSp64W7X@e133380.arm.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <Z7R9VedhOSp64W7X@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR16CA0040.namprd16.prod.outlook.com
 (2603:10b6:805:ca::17) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe01398-b10e-4863-2d43-08dd5032793e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVRMeDAvTld6WU5BRG1HVCtaWlArTXJkZDIzT0dDM3BvUkt2aG05M2p6WmJF?=
 =?utf-8?B?a2NnaEFOSzVtVHRjRDVnaWlYL3RIWjFSUkRwZVdJa0laQVByOW9SdEJpRnpw?=
 =?utf-8?B?WkNBMUVtQVE3M0pLeFc4akJRMCthdGR5ODVjMVMyb3V4Q09BNGJPdHFrZUFz?=
 =?utf-8?B?R3lmRzZiWU1hanJtdXZpczQyaCtSeEV0R0xaY3lQREFEb29Gak5wb0NWQm5V?=
 =?utf-8?B?R2FZZVpzN2tNV0lIcmw1WEFCSnFNOC9iRWNaR2FYZmdsU2ZnNHF6aTY5a3lz?=
 =?utf-8?B?MUExNUNXeWNrczJNSlhEbmduUGdLS3FhZWVlclduOENwTGVyWnVIRWdSY0x4?=
 =?utf-8?B?S0FaVnc0RkZUbU1EaERVaUlOd095Vm1YVUh2dDd0cGoyc0JVTnR1bE14MkZo?=
 =?utf-8?B?QnhqRGkyc2l1WFVyYWhJYXlYdU84aW1ORW5aenFBSjVKUVpEd05zSDZzaHl4?=
 =?utf-8?B?Y3VOM0pYeXNHTEpmNGRaRmxQbjlvQVFhYlhHS2FnelBGQ2JaWUNxQllZb1JH?=
 =?utf-8?B?UTVncktlMWFDNHNkOUtvODhVY1oxRmxJRzJESGhwdURtRVVzRG9FTytFRnZv?=
 =?utf-8?B?RnllNm5XZWdNKzJZckxDeE1NZ0ZObUNwUGN5aSsyVlBLZUpBWkhxWVNVeG9q?=
 =?utf-8?B?aE5Pc2x4Q2hJcmZjdEpYZmw2VUpPTDVVUkdZRUZZVVpIc2lma1JHUWNXT0Ru?=
 =?utf-8?B?T1VzeDRIbHBBUTg4UVo5NE5IZStvbWFoNVF2NnRvNFk1K0hROXRPWWs0RGU2?=
 =?utf-8?B?ejJlK0xhRUlPZ1k2TlVKQ3dTelZ4Vi9hL1RVb3RIM1FzMFdUSXI2YnJJc0ps?=
 =?utf-8?B?YllmdG9QMVJ3dHRBWkhndXpjRmFUbUdUaTdRUUNWMFkxNy9DRElWQXd4SUsz?=
 =?utf-8?B?d1RyRmsyNkxSTExpZ3UycElTK3BDTzJBeEtaa1NSaU1XbE5WcE93NVlLUUVm?=
 =?utf-8?B?Y0U1Y3dlSldyZDJ1VmRod2pBL21aTHZSbTZSZlBYNis0bWRJZ0lCV3VJOUhD?=
 =?utf-8?B?NytqZU54TmEva2pJSkVkNGJuTXp0bnZDQ2RRbld4d2Ixa2lLZG1kU0d0ZGpy?=
 =?utf-8?B?Nys4WHUydjVLMDhuWkNIT0VCRVp4ZW9VV3duUi9zK25BOWZyaDNRMDlkeSs2?=
 =?utf-8?B?aDBUWDByblJnYTJneTlIUjlKbEE3SVpvR0diOWlrTnQzSW9LVUVQTlNrV2Ur?=
 =?utf-8?B?ZTVBL1ZIczBidVp4SkF6cnZ0S01lY2NFcG5NMEdsNHdJY1ZzK2w1Y1RxMU1w?=
 =?utf-8?B?UGxDbHVCcmtOU0JIOU9GQTdpU0Vmb1YzbWRvaHRIQlIvc01IZU5tajdPVWNi?=
 =?utf-8?B?UHVGZGdQWWFRMjY0MkJhZlBPQTM1bDlBR05lV2tsR1QvTDQvM2ZEeXFUc252?=
 =?utf-8?B?WjZnSVl0V3NvZTQwK3Q0WmhvUGhDOUZOdXhBZjI2K0R6MVFGeVhEUlZCSmxp?=
 =?utf-8?B?dVFyVE94ZHNMTU1xT3V6b25rOXFqVlZLMEFIaHlRbFRJSTRkV05iUHdSWmRr?=
 =?utf-8?B?aG9halhyWWF6aGk2OFlydWlxN1B3WVpKdnZ0Ty9JUHMvNndpQmljaHczN1gw?=
 =?utf-8?B?RldzRnNxYllvSjY2SFNaWlVKVGxlRlhTWmpidlhwbjc4TUoxWDJMUUhGZWty?=
 =?utf-8?B?RmFDRUNDSEE3cXRta2s4TzFnZ1JnS1lBaFE3UHVOTWRvR0JhbUMvYmhvQWtS?=
 =?utf-8?B?bFI5aE9MNU1nbG9WNWt1TjAvQUQ1VDlvR1pvZ21QeEFmV0tHS1phNVJ2U2RQ?=
 =?utf-8?B?aE1aSjNINzdKYk1MTmxtQU8yY2piLzlUVHZVbndWSWMxVXZ1ejVUYms4R25M?=
 =?utf-8?B?RTdrK0xQdzQ1S1drZjErUURhMnJpdVlIUU5uZ0tKMDF1a21sU1AxZDNaekVs?=
 =?utf-8?B?eWZoLzBuUS9jV0NCQjdxUDJPLzcvWVczWlIzeHRlY1k2UkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkFWb09iTERMWnJ1eXlON2VMcDhvN0V1NmFQNS83Q1Q5U0FTd0hoQTJEWm1x?=
 =?utf-8?B?bGJLbEtwV1VaR2hUcUtFenN3QktCUzUvU3V3bGNRN3ZEMkdEekhxTUJ2ZnM4?=
 =?utf-8?B?b25vRFJ3akFzTlhob0lFSCtVeHMyMEh3dWQ0NHNVdHk3TFdaWTBOOC9tRUlY?=
 =?utf-8?B?TG5yWDRnK0Z1NTBQcUNGam85WkplRGpwR1RMcjBKT0JaZ3BWZ2lkWDlTNTF3?=
 =?utf-8?B?ZlRZejV4K2thU29xNUduLzdTNW90MmJXRzdmVkJDeWQ2NXFvOU1aSFd0NCsr?=
 =?utf-8?B?UnpTVFpUVzhPY2xGdm0vVnRiU0ltRWhFdzF6QVBaUWd5amJieUt0a21obGZk?=
 =?utf-8?B?RXhLVDFxQ0JjazlVSitYczJUejZCVmNIVzNZRHltOWozRlRtWkt0a3dhcjN6?=
 =?utf-8?B?ckl0Y0RWQi85eGZLajlqbDhlWXluaG82S2hWTHJCYTN5MFhXY2t0aHk3N3ow?=
 =?utf-8?B?WnhEbUJQQUZyeUFvbWFKdnRycW5LR010eW51dXJvS04vQ1BtSFJVM0ZyK1JW?=
 =?utf-8?B?bjFzZ20wemVLQU82TkpYME94YVoxNXBFanhhOW8raVE0UlZFdFBuSkdkNXZh?=
 =?utf-8?B?eU04SUhVdWxUS1R0bE1YYkkwZEdNN2J3TXFmNktpWjQ4aEJsTFY3NCtuZDhL?=
 =?utf-8?B?OHZxclJ4Qm4yMnIxM2x4eUxSZStMd3BicmVaVU1SWlJORE1MWTlCcWV3ZFJq?=
 =?utf-8?B?Wm16R1czclN5VUlYMzJMLzVDdU0rRDRWZVZEeVlmNGpyRnEvd2t2bVZsckls?=
 =?utf-8?B?OTJTMnExMndwQkN3RUdkaTYwL3JWRU9rZndPbGdUNzJsWXUwaG9lbEthUDcz?=
 =?utf-8?B?cHl3MktValI5R1lpMzBhOHhMZCt5cXFaMFZkMVo1b2dvWEk0eGNOUHp5cnZL?=
 =?utf-8?B?ekxhTTRndVdPRTRxc0ZlMUxra0txeHd0bGZDZmdDRWp3cjRsQjI5YklBNklC?=
 =?utf-8?B?M1pjYzM5NGI4dmtZUFFJNDNjY2p6RDVteDRaY3pLQXk4K05ORG9WRDBlUFhl?=
 =?utf-8?B?T2cxdHVnV3B2WG91dkdPV2VXZmE1SlEyUHQzbmxVV3FTbGFsOGIzb3VUeTNX?=
 =?utf-8?B?ZU5USFZBUGtIZ01yRjlwWTJxRTRSVk13YmY3ZTlScE5sdVdOZ1BHWlJ6YTh1?=
 =?utf-8?B?VkZGZ1JlL0R1NFFjWE9WTE5XVFlYWnByYm8rRzdTbDQxUHFscklBbDJScXly?=
 =?utf-8?B?TGxQc0dZa1ptNDRGQldOWDhRRks3K0JPRVVJa2U5ME5ib29oNUNVbWthL3pP?=
 =?utf-8?B?dytRUGU2eU5aTWIxemliaE9abGJWbTRMRFVCOTh5Tk9DUTluUkpRVDl5UG5I?=
 =?utf-8?B?MWw2WnJoRk1paDNJMVhHSlVMMDJHWmpNNU05RVVFb083UmQ2NzlvOE5FcmRu?=
 =?utf-8?B?ZXBQT3ZsbFpyRWIvVExxMGdTNElEUmxrZExIRWN5V3VsOFpZWDZQTHR6SHBj?=
 =?utf-8?B?RTVUL1Vna0hMVkR5MDJjbXdsRnNDOEduNnNxQlVGdEZwc2NzYjcrMUk1b0pM?=
 =?utf-8?B?U3ZMWEU2OEViWmVFcS9raVE0dkhWVklqdGFteWZ4ZUtNZnFhRWRpQ2VON1Mw?=
 =?utf-8?B?RFFaZ2MwM2Zmb0tvT1cxejA3aFBtM3dtOSt5SnRyRERwNytDNjR6NjFFWldR?=
 =?utf-8?B?Q0g2RUQvTmZWYkdCb0NPaWpZOEFYVDBjNFpwTWl2V01RYlZnTHZzNXNrUkxs?=
 =?utf-8?B?OTVjbW9Qd3pDWEhHenVBakg5RkZ3WDVOdVQ0WTNLelRPS0tHc0tITXU4Z2ZV?=
 =?utf-8?B?NmJnVllGNEhJMWZMbGovOVYxTVBxZkowazlYcy9LbXhncWNRSTBZazZTRVY0?=
 =?utf-8?B?Tm1pc1pUbFdkTjUvWEdFbVpwdDd1N2wvbTRTZk1rdUNmU01qZHhRNUNBWmtx?=
 =?utf-8?B?NFJHdnpmdDEramx5OTZmaVJ6RnU3STFmZVpvWXUwMElCTGIvU0ZwMTBSVnI3?=
 =?utf-8?B?bGpHa0JZekRVd05xR1NIY1dZRGFObTFUZlNXSzBtTjlDTEg1STI0cTY1RGFK?=
 =?utf-8?B?T3FtSmN2bExoOElxejVTUWw1N0djb2pRTW4zclRQeldtTUllcmhDa3ZlQ3R3?=
 =?utf-8?B?aUZNaXptY0xuNStaS2R4MERGN2pmTEYrdk4zTUhQZnAzOHdJbXlIRXdmMjdS?=
 =?utf-8?Q?UsXk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe01398-b10e-4863-2d43-08dd5032793e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 15:39:47.0983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdvHDQCA5+rKSnc4JSOQIEwvQuS07KN9+1sDbO6drZSpTHmeWJD91D50ILa++/+V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656

Hi All,

On 2/18/25 06:30, Dave Martin wrote:
> On Mon, Feb 17, 2025 at 10:45:29AM -0600, Moger, Babu wrote:
>> Hi All,
>>
>> On 2/17/25 04:26, Peter Newman wrote:
>>> Hi Reinette,
>>>
>>> On Fri, Feb 14, 2025 at 8:18 PM Reinette Chatre
>>> <reinette.chatre@intel.com> wrote:
>>>>
>>>> Hi Babu,
>>>>
>>>> On 2/14/25 10:31 AM, Moger, Babu wrote:
>>>>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
>>>>>> On 2/13/25 9:37 AM, Dave Martin wrote:
>>>>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
>>>>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
>>>>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
>>>>
>>>> (quoting relevant parts with goal to focus discussion on new possible syntax)
>>>>
>>>>>>>> I see the support for MPAM events distinct from the support of assignable counters.
>>>>>>>> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
>>>>>>>> Please help me understand if you see it differently.
>>>>>>>>
>>>>>>>> Doing so would need to come up with alphabetical letters for these events,
>>>>>>>> which seems to be needed for your proposal also? If we use possible flags of:
>>>>>>>>
>>>>>>>> mbm_local_read_bytes a
>>>>>>>> mbm_local_write_bytes b
>>>>>>>>
>>>>>>>> Then mbm_assign_control can be used as:
>>>>>>>> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
>>>>>>>> <value>
>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
>>>>>>>>
>>>>>>>> One issue would be when resctrl needs to support more than 26 events (no more flags available),
>>>>>>>> assuming that upper case would be used for "shared" counters (unless this interface is defined
>>>>>>>> differently and only few uppercase letters used for it). Would this be too low of a limit?
>>>>
>>>> As mentioned above, one possible issue with existing interface is that
>>>> it is limited to 26 events (assuming only lower case letters are used). The limit
>>>> is low enough to be of concern.
>>>
>>> The events which can be monitored by a single counter on ABMC and MPAM
>>> so far are combinable, so 26 counters per group today means it limits
>>> breaking down MBM traffic for each group 26 ways. If a user complained
>>> that a 26-way breakdown of a group's MBM traffic was limiting their
>>> investigation, I would question whether they know what they're looking
>>> for.
>>
>> Based on the discussion so far, it felt like it is not a group level
>> breakdown. It is kind of global level breakdown. I could be wrong here.
>>
>> My understanding so far, MPAM has a number of global counters. It can be
>> assigned to any domain in the system and monitor events.
>>
>> They also have a way to configure the events (read, write or both).
>>
>> Both these feature are inline with current resctrl implementation and can
>> be easily adapted.
>>
>> One thing I am not clear why MPAM implementation plans to create separate
>> files(dynamically) in /sys/fs/resctrl/info/L3_MON/ directory to read the
>> events. We already have files in each group to read the events.
>>
>> # ls -l /sys/fs/resctrl/mon_data/mon_L3_00/
>> total 0
>> -r--r--r--. 1 root root 0 Feb 17 08:16 llc_occupancy
>> -r--r--r--. 1 root root 0 Feb 17 08:16 mbm_local_bytes
>> -r--r--r--. 1 root root 0 Feb 17 08:16 mbm_total_bytes
> 
> 
> To be clear, we have no current plan to do this from the Arm side.
> 
> My sketch was just a thought experiment to test whether we would have
> difficulties _if_ a decision were made to extend the interface in that
> direction.
> 
> But it looks OK to me: the interface proposed in this series seems to
> leave enough possibilities for extension open that we could do
> something like what I described later in if we decide to.
> 
> 
> Overall, the interface proposed in this series seems a reasonable way
> to support ABMC systems while keeping the consumer-side interface
> (i.e., reading the mbm_total_bytes files etc.) as similar to the
> classic / Intel RDT situation as possible.
> 
> MPAM can fit in with this approach, as demonstrated by James' past
> branches porting the MPAM driver on top of previous versions of the
> ABMC series.

Thanks Dave.
> 
> As I understand it, he's almost done with porting onto this v11,
> with no significant issues.
> 
Good to know. Thanks

I am working on v12 of ABMC with few changes from Reinette's earlier
review comments.

Most of the changes are related to commit message update and user
documentation update.

Introduced couple of new functions resctrl_reset_rmid_all() and
mbm_cntr_free_all() to organize the code better based on the comment.
https://lore.kernel.org/lkml/b60b4f72-6245-46db-a126-428fb13b6310@intel.com/


On top of that I have few comments from from Dave.

1.  Change "mbm_cntr_assign" to "mbm_counter_assign".

This will require me to search and replace lot of places. There are
variables, names like num_mbm_cntrs, mbm_cntr_assignable,
resctrl_arch_mbm_cntr_assign_enabled, resctrl_arch_mbm_cntr_assign_set,
mbm_cntr_assign_enabled, resctrl_num_mbm_cntrs_show, mbm_cntr_cfg and list
goes on.

 This is mostly cosmetic and not much value add. Will drop this change if
Dave has no objections.

2. Change /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs to display per-domain
supported counters instead of a single value.


3. Use the actual events instead of flags based on the below comment.

https://lore.kernel.org/lkml/a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com/

 Something like this.
 # echo '//0={mbm_total_bytes}{mbm_local_bytes};1={mbm_local_bytes}'
>/sys/fs/resctrl/info/L3_MON/mbm_assign_control

 Are we ready to go with this approach? I am still not clear on this.

 Reinette, What do you think?


-- 
Thanks
Babu Moger

