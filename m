Return-Path: <linux-kernel+bounces-561652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E11BA6148D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645EC3B5A90
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1CD20110F;
	Fri, 14 Mar 2025 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hUGSMLUr"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B9E200119
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965129; cv=fail; b=c3Dp55U6lPz4UAz28ysUc6Kp1lx/rqP4wJ1nqIID4X5MSzKow8F/1Wk4EJ4w0BghtpBcHW0VhzL0bPQxH8aaBWEz/fq7EOMncB7XFxi4JP9rfAn3vyT2+rp9GQFr1zM4i5OJrxwNlEzmPd10lze2tmxOSvLxqFPSJTFm4biU9nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965129; c=relaxed/simple;
	bh=2LeJZjEByPAhMVG4I0OOm6xKARPhGfxLDm91feH4bf0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=coNuU7od/68nBwY7MZKXaluMZJuqyuMuWK0/mMvCx2yyrJwWVOCs8PgBk1Fx8+vbqEDW3FthVpEH78ntfAm4LEuVjfa443qZC5xmllMySWY4EH2ALyv1nJuPUXWsfQvFW5ErbK2wk+wsAOUHzuEqQFQnc8Vk+gq83Er2dYwuznA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hUGSMLUr; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBwYLH+0qftVEhSbwIJNcmgQz5rqpKW1hOzGFGXRxD4fVdhxAydv4oNA5sNRr5ZdWLJBlgtZpvnGVIfjXxFevZsorwkp9f9VAAzaUUgjhF9I2Bhhxv33aUEnIgQbp1jMJfk6vc1RrVyce+fDm4SiZlRTecr/jUUjiL8m7ygj/qU5FpLtCK56J2IRYCDikGP3LVGee44HZxwkI1weXE8ZzCWc/sBDx4kRzcsCkbgkdi7vG8ydi+DVXAGw8VU1+/7gAnpKSTTtgf5gpp3X/RS8RBMs6k6v0S/GIxs6o3yfSrEagMc7vEuf1x7COETedJ3ebpE0ldyjAdPohOOvx7fhhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIZPeQhRHBW+RVJBa6540+D2yebyDTxBQKDharFM+SE=;
 b=X4ynkuWZQCF3XB+tLpTfHoauJxbouvokePIbnxs0QNhu9dNDlWrtsUzx6sGSbDL4XAgvrZqM0JhO9frn+AawjziQ8cl5HvaclaC4rHMTnQR+qAwNlQgdj0808SeGtv92vnbUeMJ6CHjQs3ZuWWzphHP8BhkHWFZGHtQqShgPBwKlotVdOsmDX3lVzi/BYdr+Kpom2fMWqjoz/uUMT9S8XnZ8Vv82ifNBWJDwNcb8f0LSRTmr0MGHRfUXD7ISPyNHgjn5U3lOV0wiYVOl8zKtF9H16jkkc69E2lpfEnjp1BDWh9iJk7HWS2GPSGp6RV5U2lfOBzkM4myEe+76byVZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIZPeQhRHBW+RVJBa6540+D2yebyDTxBQKDharFM+SE=;
 b=hUGSMLUrjmCcJecZTFXJQpZRSwgOiZ/1IOwEV4pAbeWTTqvu7Whri+GPYkVHKutAV4X8o5t9CKJenHde7S9Uu89jyXxNFOZLiXHfgfkedHxpPcYj3cf6ChjsNtNawiQL71xuUABethTiRUI/I1WT5VPi4WRc/kX066bRDQTWyRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MW4PR12MB7015.namprd12.prod.outlook.com (2603:10b6:303:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.29; Fri, 14 Mar
 2025 15:12:04 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%4]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 15:12:04 +0000
Message-ID: <e7adcb16-ff6c-d901-155b-866be4de2d40@amd.com>
Date: Fri, 14 Mar 2025 10:11:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for bare-metal
 in stop_this_cpu()
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
 <dave.hansen@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Cc: "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "bhe@redhat.com" <bhe@redhat.com>, "seanjc@google.com" <seanjc@google.com>,
 "x86@kernel.org" <x86@kernel.org>, "dyoung@redhat.com" <dyoung@redhat.com>,
 "sagis@google.com" <sagis@google.com>, "hpa@zytor.com" <hpa@zytor.com>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
 "Yamahata, Isaku" <isaku.yamahata@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>
References: <cover.1741778537.git.kai.huang@intel.com>
 <e9ee3c7ffc3ba6feb97247faa40789684e39ffd0.1741778537.git.kai.huang@intel.com>
 <e0d9a3d599025c92fce5e159e8acc1af32844912.camel@intel.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <e0d9a3d599025c92fce5e159e8acc1af32844912.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0064.namprd12.prod.outlook.com
 (2603:10b6:802:20::35) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MW4PR12MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: b7986237-f64e-48ff-0fec-08dd630a93fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1IzMUFOdngyY2VOR2wyS1dTQUlVYTFWWmkrc0FmemZscjFSbXB6SlhHNWRr?=
 =?utf-8?B?azBSV0xkNkZSRm5icGVHY2NnSnFvNzRReDJWQmNqQ3Q3N1ZvUFlYeDhWUTBp?=
 =?utf-8?B?QUUwQVp5ck05YVFua0ZRelVpTEN0bWxkWVNZa1RwdGRhdlNucWNraVYrVkxS?=
 =?utf-8?B?YmxseHJoVGUrSXNKR1MvaUZpbG0rRGlBbnU5QUpKOUI2djFHSVQrVHMzTzQw?=
 =?utf-8?B?N2VHczM4dmFHa1lXN2RBWlE2ejJ3V1dxL3dmOHAwMWxic1c2SjY1bUJJZERJ?=
 =?utf-8?B?TXRpMy9rb3hpYkNIM2FSQlpLTGphakYwSm9aUlJIdDdjZ3FrZXpWZUFtTDRL?=
 =?utf-8?B?blVuMFZCKzRIaU93UEM0U2ZlajB6MUo5OENHcllxZ0RxZXI1MDZ1RnloVzJz?=
 =?utf-8?B?R0E3ZTBjWmhWb09QNDhPMW1aUTc4dUlsODYzVWd6RFEzR1NySFl6S1ppQUV5?=
 =?utf-8?B?UytJek1yMTd6dE82WEhmYVJYaWpZVDZEL2RQRkZoc0FRQU9leGxpTEgxeEhB?=
 =?utf-8?B?Q3lCOStFdDREOVMzeWFuQWtweTZ4cmh1VDBrUnFnSEZTcDZWVVIvNzdsbGNh?=
 =?utf-8?B?K0x1RzhjZ3QyWlV0NFFMNlg2WHhLbTR6SGRGT2QxMkprSFZKU0tjeHVSeUJu?=
 =?utf-8?B?bFNNYVB6aVpCMExuYkVmNXRFdFUzQy9aWERMVVFpbEhoNVU0RlI5MVl4Z3BU?=
 =?utf-8?B?OElYeEhubXJjRnc1TFRCVXN5YjJhZVFYV29RSlduai9EcTZsd3pSSkp2UVoy?=
 =?utf-8?B?YVROb2RCZEVjQVRKWVhsT21tUDN2eGhZZXlZZnRQMlIzSGJOK2g2WlR2aXZN?=
 =?utf-8?B?N3plL0txdC9IYmc1Z0Z2RDhtY2hCRy9sSkFmQXlTS1AvT2tKR25vN2hFNGZl?=
 =?utf-8?B?cDQ3NGpIbUkzbWU0ZnBlNmJkVncxV1ZQWWtNYSt5MFFPRDNOdjAyTEE1ZXhD?=
 =?utf-8?B?Ym82ZFpKbGhqa1VrTTBOelIzSmRCM1Jqb0x4QW4rNkt2dm5ITHpESVhVamxO?=
 =?utf-8?B?RTFzWUFtbytHTWZxRmEvNHN1ZWRwSE5rOUxHV1JyYUdXU3I5bmlacDY2VHlQ?=
 =?utf-8?B?S3Mxd3U0dzZMR3AwVGVUZ3R4U3hoZjBQd3Y1SXNDa2FWbWRrVkhVWlhPaEtD?=
 =?utf-8?B?aDNCZ1lvbTAyamEyaWVhampZSzB3akljNzJUeHA3ek1aK1BXMnRSR1ppeC9t?=
 =?utf-8?B?TDJLZ0M3N0RWaWlOVkZLbHhrajU0UzJrUEhSZ1d6dUdlU0Era1JnMFdWck1F?=
 =?utf-8?B?UGdsRk9zTzh6M01oUnlRQUgzMDB4TkI1NG9mcytsbVV0ei91ZzN4ZTBJVUNr?=
 =?utf-8?B?NVZISEJENGVQaHhwTWY0bWpnYmRjNzVITkREL3o4U0cwN2dmVk40ZDNhR1hk?=
 =?utf-8?B?MjJDb0o0T2N3dGx4bUJ3NENZQTRtN2I0N3FWdXpRNzJuMUZLa2taaWgrL1ph?=
 =?utf-8?B?M1Uwc2pDK3BoOU9CSCtvTElEam9aelJvLzNDa2VlUmV3aWVyQUpkejFSZU43?=
 =?utf-8?B?S3V0UTdGbk9DUzVOakV2RDdaRDloZHpsaENjWnkvUkJTTXpvOUlVMktKb1di?=
 =?utf-8?B?ei95elJOdG0rUUU5KzdDTTVOekFWVDY5Y2lCeEJEallDUWR3VmVYUnpLRzdo?=
 =?utf-8?B?VjRZQjBzTW1QUDVZNTA3VVA1S2NuSUxYSGdSMm5ncHJkaUhuYjJwcklsdUZT?=
 =?utf-8?B?eFBhNXVtMXlkVkRuM0VZMGxKcVh0bmNuUWN1OFFFQUhSeG9XNEVTKzdtbzBR?=
 =?utf-8?B?dUx0SS9KZnR2Ylp2b0FjdGdlOXhFeXkzVzZ5dFJZbUQrUHplbnY1Tm1MaGtu?=
 =?utf-8?B?MjJ3SW1NYVo5TjFXN0JiNk1RTXRBVmVXRkhRbEJQWWM4NEtxa2dTMnpJSG1I?=
 =?utf-8?B?bGhmQ3VTSkExTXlRYWxVSjFacUl6S295a01WVS9JNWQ1ZEhRMklvY29YbTEr?=
 =?utf-8?Q?4rOLWnkNW4fXsjjjDmABoaDirFK7Z/kA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGdRTzJIbk5ZOWVsTGc3cFBWM1BNZElmV09uV1VkZjh0NE5lMVlFWGU5RUxl?=
 =?utf-8?B?OGJGLzlVQTBWVzJpZjhtRzJ5WHA2L3BOc2x5Um15cFI0SzJOVlM4WERVYTNn?=
 =?utf-8?B?VXM2ZzZmN28vWk1qUHE4MEhpdHFsUCs0OHFKQ3hDQjRDU0EwSlcxbU40bm1V?=
 =?utf-8?B?OG02MmN1OE9GbW90MnBhQ2VxcnUvaWh3cHNSeVZoMzIraDVjU1ByMWVkMmVp?=
 =?utf-8?B?anNvcEI3SUJFTVJ3YSs4Zk94dEdmcWNqRWVXL044RUIxUTRWOU5QSHVIV2c0?=
 =?utf-8?B?TjluQVdyMjRFS0cxcUNIbnRpSU9mUjBuNktBNkE1dVZUWXpLM2M5OWFUMkpi?=
 =?utf-8?B?a3Q2Y2lOT1ZMQWlLdEh4VEhTT0FVVkR2dVVocnl6ajRoSGlVRXQ3MkVZTWkw?=
 =?utf-8?B?TmZva3BKdFFrbFovak5QKzFYY0JzaXlOeTBRUEdZdUVCZzUxdkozQ2RTcHZw?=
 =?utf-8?B?ekQyZDdpZCtvNXJPdHhqclZZanFwN3pLMkJxb1c2V2dDTEh2bTRkR2tqRnZ4?=
 =?utf-8?B?MXc4UTJ6bGhSS01uK3p0T1VDWEJoYjVBa3BDTDViSDBveE04Mm5QdXBDNGhp?=
 =?utf-8?B?cmFQeHNJR0Z6M1BhdXFHMVdKbUJRdk9NQTZMMGNIREU3YUd1ZVVVVmo1dllF?=
 =?utf-8?B?aENFYXdoZTZhNlVqYm5YbmhOcUdCd3ZURWJoYjBGbkdHMElWVXJBbDlXZXI3?=
 =?utf-8?B?S3dQZnZ2bzBqSjhZMEdMeTNmQWxhYWN5eEZhZ2dzbmU2YlNZKzFYTnJiUk9m?=
 =?utf-8?B?MTVFekduVnAwSkNFQ1o3eU9BZDhjM3RFWmR5ZEJOV1FIZ09qZGt5RkQ0OXQ3?=
 =?utf-8?B?YUJVbTdPOVBjY3B6dWVpdFM0bnh5OVh4QXhCOFBVT2p2NWlSOHFmb2g4SlRE?=
 =?utf-8?B?dzcxbXJSY0V6WTdPbVFBOFNIeUNxbnVqMkNNOTJoVWhqVWhUdld3Y0ZoQlo3?=
 =?utf-8?B?MXc5NXRUOXB4dWJWRFBBNDdLMy96YmVrMWN4SFlTVzFxU1V6YVluS01vcWZF?=
 =?utf-8?B?cGRaY2p1RzVRVEtrWklTR0twdk1DOVdBZUYwOUd3WXB1dllzeGhEcWU5VXU1?=
 =?utf-8?B?bDRZWVFuRDlkUm5ocUhFNEQ1a3RCTWc3U002NndPOStXM2tHbHhlWW1pQnE1?=
 =?utf-8?B?R2pPYVloRjNmcDB6MExVMWRJOGlHdWorY1lWUkd1QWVsRHFWd0pPbUluUHM5?=
 =?utf-8?B?TlVIbyt3NWd6eUdzOWU2VE5iWDVjTDBTeCtLbGRmaU9GNXdwWUhIeGZZV3dB?=
 =?utf-8?B?YS8rMlpNdzVOZjc3UGVFOXYrL1hybEl1bjgvS2g2SXMzdFBiVmFvMWJTSkhR?=
 =?utf-8?B?UFFkdWR6YUM3Wmx2ZGgrUEIwQTlLYjNYOG9zMGZxNWEyVjczVHBvSDg0a3lz?=
 =?utf-8?B?dkgxZlcwV21yU1RKVkhnNUJwNTMzWnBlUy9MV2drWnZOdWMyaHlCcld0cFY5?=
 =?utf-8?B?WjNqc0JyeUZ3RW9CdWVKb1pVMit4SU9pT3pveitiWGhOenY3dE1BWVZzYVNs?=
 =?utf-8?B?dmRVNGF5aUNyaUs0dnpDT0ltbWJ0MnZteThCNTVsekpQMDV6L3l1OEV6SURL?=
 =?utf-8?B?Q2R4VnNQdWNuSjlYQTBhd1JOcHlEUWtZQzZyT29wclBQZTZwa29lc0JvRS9B?=
 =?utf-8?B?V3JML0V0VHhzY1cyaFZza1VEenpZVWF6YWowbkgzcW5IV1ZXa1ZmQS9xdWRU?=
 =?utf-8?B?YXFad1FPdmxZY05SM2dWZ2ErNVlqUXNxN0YxVmNMSnFHUDFYa2hJOXdzbXpY?=
 =?utf-8?B?cU9ZNk9HMFNLRGFGdUMwbm0zNHUwSGRPM0pyZkR2eUxVSmxZRnJVZXE2RkdN?=
 =?utf-8?B?OWk3TUNPOWJ3UG9BbWRER1g3UWRHMW93QTNKLzQ4OUhJTHltMEZwRnlsbHBH?=
 =?utf-8?B?YS9nYnJURXZJK0U0ZDZqOUZIeFNGQ2NKK3NGc1hLVU5Kb05sVkJpN3Nwb0VF?=
 =?utf-8?B?c3Zmc2Y5SlVaTnhuZ29hbWFMSE16dXdxSmtteWJHcExCZmxWZVlJZzl2N0tj?=
 =?utf-8?B?MkpIUHdFWVlraXJYUnlDTmJwYi9MSFdZS3BZTm1pOGM3Qm9IUDdEa0lLMloz?=
 =?utf-8?B?cmJrTWVweW96MXZRNjV5TE9uQm5OeVZsa1plN2Q2MU1IUnV2S1VYNVFUSk5q?=
 =?utf-8?Q?GLKWyyngXEjthedhUlJhzsUrr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7986237-f64e-48ff-0fec-08dd630a93fa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 15:12:04.1445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETGY0IqsE0AHGll7DUHngnIIGXpW+XmTc7nA9lXZZwOqLSKFtYWFMofdOlH0uxfHHenyP5m6H6DAvpynYEkNsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7015

On 3/13/25 13:40, Edgecombe, Rick P wrote:
> On Thu, 2025-03-13 at 00:34 +1300, Kai Huang wrote:
>> TL;DR:
>>
>> Change to do unconditional WBINVD in stop_this_cpu() for bare metal to
>> cover kexec support for both AMD SME and Intel TDX.  Previously there
>> _was_ some issue preventing from doing so but now it has been fixed.
>                              ^ Adding "the kernel" here would read a little
> cleaner to me.
> 
> 
> When I read "some issue" I start assuming it wasn't fully debugged and it is
> "some issue" that no one knows. But below it sounds like it was root caused.
> 
>> Long version:
> 
> It might make this easier to digest this long version if it start with a "tell
> them what you are going to tell them" paragraph.
> 
>>
>> AMD SME uses the C-bit to determine whether to encrypt the memory or
>> not.  For the same physical memory address, dirty cachelines with and
>> without the C-bit can coexist and the CPU can flush them back to memory
>> in random order.  To support kexec for SME, the old kernel uses WBINVD
>> to flush cache before booting to the new kernel so that no stale dirty
>> cacheline are left over by the old kernel which could otherwise corrupt
>> the new kernel's memory.
>>
>> TDX uses 'KeyID' bits in the physical address for memory encryption and
>> has the same requirement.  To support kexec for TDX, the old kernel
>> needs to flush cache of TDX private memory.
> 
> This paragraph is a little jarring because it's not clear how it follows from
> the first paragraph. It helps the reader to give some hints on how they should
> organize the information as they go along. If it's too much of an info dump, it
> puts an extra burden. They have to try to hold all of the facts in their head
> until they can put together the bigger picture themselves.
> 
> The extra info about TDX using KeyID also seems unnecessary to the point (IIUC).
> 
>>
>> Currently, the kernel only performs WBINVD in stop_this_cpu() when SME
>> is supported by hardware.  Perform unconditional WBINVD to support TDX
>> instead of adding one more vendor-specific check.  Kexec is a slow path,
>> and the additional WBINVD is acceptable for the sake of simplicity and
>> maintainability.
> 
> Out of curiosity, do you know why this was not already needed for non-self snoop
> CPUs? Why can't there be other cache modes that get written back after the new
> kernel starts using the memory for something else?
> 
>>
>> Only do WBINVD on bare-metal.  Doing WBINVD in guest triggers unexpected
>                                                 ^the
>> exception (#VE or #VC) for TDX and SEV-ES/SEV-SNP guests and the guest
>> may not be able to handle such exception (e.g., TDX guests panics if it
>                                                              ^panic
>> sees such #VE).
> 
> It's a small thing, but I think you could skip the #VE or #VC info in here. All
> they need to know to understand this patch is that TDX and some SEV kernels
> cannot handle WBINVD. And TDX panics. (does SEV not?)
> 
>>
>> History of SME and kexec WBINVD:
>>
>> There _was_ an issue preventing doing unconditional WBINVD but that has
>> been fixed.
>>
>> Initial SME kexec support added an unconditional WBINVD in commit
>>
>>   bba4ed011a52: ("x86/mm, kexec: Allow kexec to be used with SME")
>>
>> This commit caused different Intel systems to hang or reset.
>>
>> Without a clear root cause, a later commit
>>
>>   f23d74f6c66c: ("x86/mm: Rework wbinvd, hlt operation in stop_this_cpu()")
>>
>> fixed the Intel system hang issues by only doing WBINVD when hardware
>> supports SME.
>>
>> A corner case [*] revealed the root cause of the system hang issues and
>> was fixed by commit
>>
>>   1f5e7eb7868e: ("x86/smp: Make stop_other_cpus() more robust")
>>
>> See [1][2] for more information.
>>
>> Further testing of doing unconditional WBINVD based on the above fix on
>> the problematic machines (that issues were originally reported)
>> confirmed the issues couldn't be reproduced.
>>
>> See [3][4] for more information.
>>
>> Therefore, it is safe to do unconditional WBINVD for bare-metal now.
> 
> Instead of a play-by-play, it might be more informative to summarize the edges
> covered in this history:
>  - Don't do anything that writes memory between wbinvd and native_halt(). This
> includes function calls that touch the stack.
>  - Avoid issuing wbinvd on multiple CPUs at the same time. As tglx implies it is
> too expensive.
>  - Don't race reboot by watching cpumask instead of num_online_cpus(). But there
> is a race still.
> 
> Hmm, on the last one tglx says:
>     The cpumask cannot plug all holes either, but it's better than a raw
>     counter and allows to restrict the NMI fallback IPI to be sent only the
>     CPUs which have not reported within the timeout window
> 
> Are we opening up more platforms to a race by unconditionally doing the wbinvd?
> Can we be clarify that nothing bad happens if we lose the race? (and is it
> true?)
> 
>>
>> [*] The commit didn't check whether the CPUID leaf is available or not.
>> Making unsupported CPUID leaf on Intel returns garbage resulting in
>> unintended WBINVD which caused some issue (followed by the analysis and
>> the reveal of the final root cause).  The corner case was independently
>> fixed by commit
>>
>>   9b040453d444: ("x86/smp: Dont access non-existing CPUID leaf")
>>
>> Link: https://lore.kernel.org/lkml/28a494ca-3173-4072-921c-6c5f5b257e79@amd.com/ [1]
>> Link: https://lore.kernel.org/lkml/24844584-8031-4b58-ba5c-f85ef2f4c718@amd.com/ [2]
>> Link: https://lore.kernel.org/lkml/20240221092856.GAZdXCWGJL7c9KLewv@fat_crate.local/ [3]
>> Link: https://lore.kernel.org/lkml/CALu+AoSZkq1kz-xjvHkkuJ3C71d0SM5ibEJurdgmkZqZvNp2dQ@mail.gmail.com/ [4]
>> Signed-off-by: Kai Huang <kai.huang@intel.com>
>> Suggested-by: Borislav Petkov <bp@alien8.de>
>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>  arch/x86/kernel/process.c | 21 +++++++++++----------
>>  1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
>> index 9c75d701011f..8475d9d2d8c4 100644
>> --- a/arch/x86/kernel/process.c
>> +++ b/arch/x86/kernel/process.c
>> @@ -819,18 +819,19 @@ void __noreturn stop_this_cpu(void *dummy)
>>  	mcheck_cpu_clear(c);
>>  
>>  	/*
>> -	 * Use wbinvd on processors that support SME. This provides support
>> -	 * for performing a successful kexec when going from SME inactive
>> -	 * to SME active (or vice-versa). The cache must be cleared so that
>> -	 * if there are entries with the same physical address, both with and
>> -	 * without the encryption bit, they don't race each other when flushed
>> -	 * and potentially end up with the wrong entry being committed to
>> -	 * memory.
>> +	 * Use wbinvd to support kexec for both SME (from inactive to active
>> +	 * or vice-versa) and TDX.  The cache must be cleared so that if there
>> +	 * are entries with the same physical address, both with and without
>> +	 * the encryption bit(s), they don't race each other when flushed and
>> +	 * potentially end up with the wrong entry being committed to memory.
>>  	 *
>> -	 * Test the CPUID bit directly because the machine might've cleared
>> -	 * X86_FEATURE_SME due to cmdline options.
>> +	 * stop_this_cpu() isn't a fast path, just do unconditional WBINVD for
>> +	 * bare-metal to cover both SME and TDX.  Do not do WBINVD in a guest
>> +	 * since performing one will result in an exception (#VE or #VC) for
>> +	 * TDX or SEV-ES/SEV-SNP guests which the guest may not be able to
>> +	 * handle (e.g., TDX guest panics if it sees #VE).
>>  	 */
>> -	if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
>> +	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
>>  		wbinvd();
> 
> I see that this already has Tom's RB, but I'm not sure how this works for AMD.
> The original SME patch tried to avoid writing to memory by putting the wbinvd
> immediately before the halt, but today it is further away. Below this hunk there
> are more instructions that could dirty memory before the halt.  Ohh... it's new.
> 9 months ago 26ba7353caaa ("x86/smp: Add smp_ops.stop_this_cpu() callback") adds
> a function call that would touch the stack. I think it's wrong? And probably
> introduced after this patch was originally written.
> 
> Then the cpuid_eax() could be non-inlined, but probably not. But the
> boot_cpu_has() added in this patch could call out to kasan and dirty the stack.
> 
> So I think the existing SME case might be theoretically incorrect, and if so
> this makes things very slightly worse.

But the wbinvd() is performed after those checks, so everything gets flushed.

Thanks,
Tom

> 
>>  
>>  	/*
> 

