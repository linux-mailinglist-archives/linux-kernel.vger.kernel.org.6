Return-Path: <linux-kernel+bounces-263923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CD693DC67
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97BE71C233EC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CB0154C00;
	Fri, 26 Jul 2024 23:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mhyx1Cq8"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CC914B07B;
	Fri, 26 Jul 2024 23:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722038241; cv=fail; b=K0JYc6bI9tADsvf+44yQ1AVlxH7gBpr0F2p6j97JeBUJEBbGHIJ8umzkOOVVHXgrW50E5LCCgiP4cbvfhpuvGhSNtMgDlpSf3Cw03R/r9+VJ935AQ9qg5GffYyJ/UFCV6c2hurSf8R+YP2uPMdq6HxaXczTimPzwO2453xRHP1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722038241; c=relaxed/simple;
	bh=3V0ETh5nIprsglHnoWNDz/zmEJRFYC1KkYajDxTf4M4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p+dlaEcooP2yzpYScM0szdbv3r3lNpsuS3LOzKW730fEied75IenQAUfmn6O5GFsiSf5EP5wTVsLBeGG29+SvYCCMwkld10YgbVGhsGcR1DJXQRRaOom10JRcc1TV4QRMnS0MsPOPiXPmK9wA3redrqCmrEqD6py5Cdtsyb2hpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mhyx1Cq8; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7/XgFqlsjqBS2+PUyS2HZ2eaP9PZeuO7/OWGqwaIMCgHQXW+MaTn8L30YfvnL/Jzt/XfzMplsFQPqluPgt3hCFd/SzsEVwKcvcu13LcN37JiljSod3pGEEiaPiK0X/U1syCv9ArKiqGR2oSVELRcWSGsBsdJHc+4oM/VEIqBj6ZFQ8Kx/7I5FOm/vZ8PPbm2JdBtBUOM9Am/wxkmxWkr8SwW2u8vFEoJXjBXYyip2gqOpHsqSb5IaUEJSW/3cEB1VezAh4eabENqjNYxUPffl57fiRcMQPhZsisiYfZbrrdD2EzL/5h4+oPdSkx3KyFclhjSkBBNe+jxjVpcuxAbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UkbPCSst/5AhA6jZXXF0W1vF7+hAOxGA7wfHtVjpzg=;
 b=Sb8cjIR9HS+tPQHfdzpANDU1iffKyDIxduP/jBuiubQmfOkWNzWcbiUlHV3Bz/Sg537RGwEOvucDIBdP84vclW+zUZRWZc1PmBSSkPZTGm9uYr/nKNowTpv+h3PFtJoXvdGn+5RHj8TfWiqRaPMEzACLVET30J4oNWvWoqL5vHvwpR4erSCc7X1h0urKvOe+QWJnIrGQ1RtTeg3os0JATMhdCMoFcdmZTvh4wn2SXQzEhuF44CDz5N9sWm71uDiPX/FjiGW8A11gV7uLlvnfagcsxJ9r/6ccWyd10wTwj2QF7Z5rs35mQhcxHgqXhzYCUq+ZsFpE04S+MqY3pytqpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UkbPCSst/5AhA6jZXXF0W1vF7+hAOxGA7wfHtVjpzg=;
 b=mhyx1Cq8wBibkmXoWANk0+IbqEs8kw/dzXUiFV9NYhseiby/5qcb8h8/NSr2wuM6Az83NyQ2PG7PenOqODG1xWiFLYO6gnip7CtHDsgxqFT7Ff12vGgqjjlPFbyQAwTVO4OPzTd6QRWwjXb2mYok7WcdvtKVv7DIBJAwyK/LJAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB7772.namprd12.prod.outlook.com (2603:10b6:8:138::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 23:57:17 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 23:57:16 +0000
Message-ID: <c651e5f6-cf58-b75f-db21-61784007a201@amd.com>
Date: Fri, 26 Jul 2024 18:57:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 15/20] x86/resctrl: Assign/unassign counters by default
 when ABMC is enabled
Content-Language: en-US
To: Peter Newman <peternewman@google.com>, Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
 james.morse@arm.com
References: <cover.1720043311.git.babu.moger@amd.com>
 <89b7b4c59f3389034337301c1741ce224e19061e.1720043311.git.babu.moger@amd.com>
 <CALPaoCi2dKoqGEPO6JDLG-4ce8y=uAg-9znQfNo6xg_0k=TknA@mail.gmail.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <CALPaoCi2dKoqGEPO6JDLG-4ce8y=uAg-9znQfNo6xg_0k=TknA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0115.namprd11.prod.outlook.com
 (2603:10b6:806:d1::30) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 1367f192-c944-4865-aeb3-08dcadcead9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R290ZW9aZ3owZ0I4eTh4U3ZwVi8zWDZmTkRobWEwZWZ4dlF0YWNCUHhyN2hW?=
 =?utf-8?B?dU9vNUN3NGNFcVZoT3Q4WUJXWlBLbEdCNCtUQ2tiT2l6M2F6NHE1KytXekR3?=
 =?utf-8?B?RFFlaW5ENmxQZnhtUTBGb0ZKejl4ZnB1RFlPdlZSMVZUc3NGMWJqdERVQ1h2?=
 =?utf-8?B?UURCaXJMY2Z3aFliTlB3Y0JkV013K3djV1lDdFdtdFNlVXo4cVhDbkd2M0dn?=
 =?utf-8?B?a21iWW9lZWdJelE5aDh3UnRKZC80ZzhCN1V1Tzkya2xLaVl1VXdLS2xhWVZx?=
 =?utf-8?B?VnRPYTkxMkJGOTN3cHFWRjgrVVE1eFNqLzU0TStCU0hpSUJlTVk3UnFDcTFj?=
 =?utf-8?B?V1lVYTRDR0VMbHJlSndvVWIva1RseFNvZWdxUEZDV0hGUE1ra3VIYkxoOG15?=
 =?utf-8?B?WWlrMlVYZTA0RHRIRGNMODdPY2gvQS9nWStHTUJuUUxJUCtWcUh4TzRYcEQx?=
 =?utf-8?B?dGpwdzRmTkZQUG9zUFlFTUI5OFltMXN0dGNGOWtoSkYzMnJ6TFBvMU1OVDU4?=
 =?utf-8?B?NmlYcjV1UWh5TFNIejFXTUg5Q3h1YS83YVlqMFI2eGdOM3AzQVNGMjdOMTly?=
 =?utf-8?B?SGh5OW9mT1BERlU4b3BPMFAxRWFDeWhmeDlMa09tMWhjMFJLdndOMXc3UkxE?=
 =?utf-8?B?bFFNai92aGhwNXFVeWhQOVByeER2YzhuZ3ZvRzFxVkNETjgwZ3lQamJwR1Jo?=
 =?utf-8?B?ekpybmE1eWlYMkpILzRkdTBsb1dFZWQyUllzNWsrSVhPZ29ucGNmQzNkRVE5?=
 =?utf-8?B?VGxXa2U2TkMySnNPaklHYlRiZVByWnZNcHV1UlNIVDhQVUZDSnBpL0FIMWlC?=
 =?utf-8?B?aUtQQmZTQjQ3a0ZSeDBQSDhHYmt3YWZrWUxMRHFVNEdMc0N1TS92QUpJRy9F?=
 =?utf-8?B?UTltWFRLUXhEcGVjcDhnNVVCZGsyNTNZcUpINlEvdU84eFcvREtKMWRsVWs1?=
 =?utf-8?B?YVJERnF4Y050NWlBZ3RNeDQ3RzdzZHJ2WVBGT0tEdXdtVjFmSTNLUHNwaUIv?=
 =?utf-8?B?VmNPMzgvTDFYeStkNnIxOGphcG5qMnlydytjUnpoUmg3NHBWMGEvZ2FuZFU2?=
 =?utf-8?B?ZnIzdHcyVVVTM0NsTUwwWjY3RzVjWTRVYXd6QnJrVDZkWkNsVWVFeGRHT0tj?=
 =?utf-8?B?QWVzOWxUUjdRV3Fhei83NXByMUpVOVAxckVqa3hIa2JLSE1maHZsWGNueGh2?=
 =?utf-8?B?WXluQ1d3b2dXVjUxaGhBME1yc09IWkdadjBhbGtYS2FVR09wa1dGT0hROUxh?=
 =?utf-8?B?V2grUjQveURZMzNtZk1JSXZKaWVyY093ZkdXVkVHdFJyOWFJRTBLNzZkMzdW?=
 =?utf-8?B?bFhaYW55bm1KZVNxYnRGc2VjUnd5SnRyT1dEWmZIZXRQTk50aHJZU2gvVnNQ?=
 =?utf-8?B?cGJwc25PQzlzZjlYeWs3YkdaMFRDN240Y2FDM3dkdmMwdDNESGdtSVNUWnlB?=
 =?utf-8?B?WXpoQkoxWTluemN1RUVmcXZETm1vdGVINU03aDdPTERLbzBEaFhtSjVkbm12?=
 =?utf-8?B?TkthS0Q4UEJxem9ObERHUzRMWThkQnpDR1ZsWElSakVZWHJ6YjRuOEFTbkF6?=
 =?utf-8?B?TEsxcTIyNmY1MlhVWW1CWkVvMU9DYWo5SlM0UGQ0K1BqdUt1WjdXY2VoOVI4?=
 =?utf-8?B?bE1wS05DTUprNzVlRmdBRTQweUNrWUxVU2pOT3k4QXgxWThqVFl6RGljMjds?=
 =?utf-8?B?NHZzTXJYaFlhMWFaQXBsR1FzK2d1L3Yxd2c5cVprYkFXSXVtWlNRUDZHdUlX?=
 =?utf-8?B?dEpyQVhkSVh0NElIOWFMMXA1dXpZWjVDYlhObTJneEJTNll2bnU5cldDd1lK?=
 =?utf-8?B?Tm0vWlVKdE5FdXdBK0ExQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2dSVzN6ZFVRbEtUMHpSREtSc0FEdEpzZWFWMkQ5WHkzcnN2VmExWTkrLzk3?=
 =?utf-8?B?aXBreU5LczlZTWNXbTJVdWNTbjNka0VWV2VraEpuSjFBd1hiVjBGTloxNDZP?=
 =?utf-8?B?Qk10cFJNdk5xbjI3Ull6VjdJQVNadmh6UDdWZStleFNFclBLcjRrd2J0dGQx?=
 =?utf-8?B?R3BaY1BWNU1BWkJWbXIwSTU1dE9OK2dCbFFWQUw0eU4vQzJvV1F0Nnc5b3dQ?=
 =?utf-8?B?RnBYYTE3OTBQbzczWmFFYUkrMTRkN0U2YmVhNTdTL3RQci90VGJTVlhrTW4z?=
 =?utf-8?B?b1RwVXg0Si9DZ1dLZEtXam1mWjRST1U5RjRJdW1JTm5wbDNmN3VhalJLS3FE?=
 =?utf-8?B?aks4cjJFc2FrcWRUc2xwa1ZuMEJBZmw3bDFFWXgwV2FTdEFHZlhrTmozeDVW?=
 =?utf-8?B?K0oyTkFXNzFjbCtHV0JlVDZQYlJGMWh4VlM2YmNpRHRsSnlsVEc2YlJTTzFN?=
 =?utf-8?B?SW0zNjk4OUtNUU1aMzFVLy9rQ1BoKytoZXllR0duWGI1a1FKb3J2RDJPbEt0?=
 =?utf-8?B?bnpCcUR4ZC9hZXp1UTVjSkt1c3I4SGpySTNXWG1kMUhyRDFmNVpWY0FMckRj?=
 =?utf-8?B?VWVLSkhISEVQWW5ZdkhPRzZRdS9kbUpPa3V4UWpJQ01RaDhSZmJZZUFqM0xo?=
 =?utf-8?B?RzByZUZOeGhYOXNYNkxzNGZzeFRKVkhxU2tGOS9PYnhCemQxYzhmd1VveWxE?=
 =?utf-8?B?RHYyMUNzT0lKOHlSVWFqMWlPcEpjMUMvMG9tbVFneWtkSk9wSWhoQjhZc2kz?=
 =?utf-8?B?dk5Pam9HM0NaQ2hJV09mSHMybXRxNzZTVHl5dEVYalByMUlVdHg3d29OVUpo?=
 =?utf-8?B?WURLRk1LU2crNTJnUFpKOHNCN1lIWEhoTUNYdXltZWIxZTQxSXkwYmRJUVox?=
 =?utf-8?B?TTF5UHNpaXlGRHJsdzRJZWNqb21HUGFXUzdLdlVsZ2lqTG81M3RHUDhyS0lP?=
 =?utf-8?B?RWtMVFlYQTB6R0dlV0Z4aVRINGhYQlNsUW05dnI4V1ZLUTA0aUxoOFM0NVlz?=
 =?utf-8?B?U25UUGtTb041K0hSdXZ0eWx2K214Nk9sNUJSNjA5UEhlaFBmcEkvb0l3aHZz?=
 =?utf-8?B?WVUrOFJlbXhkcTJyOStGL3hjbmpNZjNodnVlcDRNV3JuZ0VLMW1IcklnU2R4?=
 =?utf-8?B?QmtJVjZvZEE5V2NmQUhOM3NrNTU5SG1EZzJYSTlYb3VzVkxHbHRWNzVjeDk0?=
 =?utf-8?B?YmxlR3RoeFVNbE0zNkNNcG5xU3ZGeE9kV0tWVFdXVEZsMVpTZTdrekJ0eW5D?=
 =?utf-8?B?QThGOFppMmlBci9BbXhJbkhKbUIrUS9zbjROQS83NVdaTm9wV3FuS1RGUFBu?=
 =?utf-8?B?NUkzVnBXZm55MHZVdmZSQXg1OVNlaE0vN1p5MVpNOGtGWWRrYXRMWjdEVDh5?=
 =?utf-8?B?WEwxNk0yLy9vbS82SXYwMno3aFQ5VDFTNFdkVkRvaWJxYUtRQzlpcGd0b0ow?=
 =?utf-8?B?QmVPalBDZmt3SVVUUUNnS1NURGVTVm5tWlJCdTBrMWEvQ0h4UWV5NGsvSUF1?=
 =?utf-8?B?MmFBQnZXbDY1V3l4dDVUWW5JMkdwOHpYUlIwR3lORWVFclhhK2NMK2NHWXpk?=
 =?utf-8?B?eEdodkJ5clBNaThaYlAxQ0xyMytVcVJoQ3cxM1RadStGL2RqVW1lUnhSNkNI?=
 =?utf-8?B?WGVzRGVnd3hCcVh1RUhzcmtKUGRnR3lUUWpDem1IU1pvOEE4bVk5Q3Vtd1cz?=
 =?utf-8?B?YnBkWmpMRUlhRnB5d2NyNUZ2eTJCMlB1Y1JSWTNHZXRzZlFHZW5OcEhscWxv?=
 =?utf-8?B?WXhiV0xEZVY0NmloUnNuR09IMmdHTXZZR1VvQUw1MWJnSnlhb0dhdlVZRHpB?=
 =?utf-8?B?U0J3VXBnZlZlZnAvOFQ1VjlMNFpDNGpUTHcxUi9RZ3U0cUdsa0Q5WlF0UjJL?=
 =?utf-8?B?eWpRUHJaUjNObWlJSXQ0bGhXbXRSODVYdW9vZkFROWQ0K2h1RnpzRkhJWThL?=
 =?utf-8?B?NTBPRUZOeFlTOXpKdERnSWxxNUIzNUxYSGJ6UElWUTRKZGIvc1RoVkkwU081?=
 =?utf-8?B?U3U4anRPRkRUeTVaMWR6clM5cURPbEk3MzdNYVlDazQ1QXl1amRvL0VHZUt2?=
 =?utf-8?B?UCtqaTVJWU9IMEJMaTl0V2xHWWZGNGtWZzN0SWdLRXk2WnR1aTZCOFNYQ2l6?=
 =?utf-8?Q?fx3E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1367f192-c944-4865-aeb3-08dcadcead9b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 23:57:16.9444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WayU/y8quMuy5E++09gFNoQ37TESA5Tg1cYaG3uBATLX9AYwJ3GEIUX0Z5QWL2ES
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7772

Hi Peter,

On 7/26/2024 6:22 PM, Peter Newman wrote:
> Hi Babu,
> 
> On Wed, Jul 3, 2024 at 2:50 PM Babu Moger <babu.moger@amd.com> wrote:
> 
>> @@ -3894,6 +3956,17 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>>          if (ret)
>>                  goto out_closid_free;
>>
>> +       /*
>> +        * Assign the counters if ABMC is already enabled.
>> +        * With the limited number of counters, there can be cases
>> +        * only on assignment succeed. It is not required to fail
>> +        * here in that case. Users have the option to assign the
>> +        * counter later.
>> +        */
>> +
>> +       if (rdtgroup_assign_cntrs(rdtgrp) < 0)
>> +               rdt_last_cmd_puts("Monitor assignment failed\n");
> 
> Supposing rdtgroup_init_alloc() below fails, would you want to release
> the counters allocated here?

Yes. Sure. Fix it in v6.
> 
>> +
>>          kernfs_activate(rdtgrp->kn);
>>
>>          ret = rdtgroup_init_alloc(rdtgrp);
> 
> -Peter
> 

-- 
- Babu Moger

