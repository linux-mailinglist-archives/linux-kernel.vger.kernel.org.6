Return-Path: <linux-kernel+bounces-381136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 035279AFADB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239DC1C20D81
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7A31B0F15;
	Fri, 25 Oct 2024 07:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CspKCS3S"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60894D8C8
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729840719; cv=fail; b=Tpv2FwhzYS+uiJD+4phM9KEiNLXtPUiSMZjvT3k2Vx1zJUqSzpamInJTsKSzLL2PkpBpDTUgYWN+4ELROBnFxLnUenX96xvZopETIfeTdGVLSWy+GAwUSazzFwZCGhyeXxAPTs2PHVG6cwANjIRRE61yVMPSE4h0+LiNo3WxdXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729840719; c=relaxed/simple;
	bh=F/U5l9GbPyWK5DSO2dpcofrmpOWB/Y+RqqKlhIsZ/N0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZKnKqLr58gn70hpx6pRIPC++YSgpdJHyQnDXgMrnQgdj52kGHQyzDG6hWt2sy965Y2RKHPhOf05uUccoSJlVgYqIVn6R4zqfS2+l5zffZt44Y2l27RxNoDaZecxm/yOWn5+Djy+xWehL60nZW5l4uy6IEZrEgeUC1Y9Qf9WzzSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CspKCS3S; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEmAmQpvuVYQ9Zd68C4AxCqDjcg8QJgAFyY+TVtQCIqBNYI4lRPDfFNTWwJ/QH7JwxmU3yHzg+6Q98rXatVFHSP/R9WCWbdyQ/W6h+p3gPIK/iUoK0kmDOa7HevFfHH69IqrD2OvMtCQW2Tg0JmsXLPbN1AZKLgDLSAgKSJHQUbFVRwRQN4R0crNd3+CAGg2h5Z7TCfrwZ9lVUkuq0fzPEEJE8NWzvSgaDbhWCrJ+weYSSsrEbSwN3t9OPhPijSB1MDZVAezSq/VFflGy1rCMLMamkW6RI67qHLKIruO1JU8mLG/yiS/SrALLJjd0sqX+Htu+yrcMkNHwKighsNDOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djc+8cCltekCDZyyv/TJy7NbztSPwwWlDXGoa4LRFE0=;
 b=RiqGhk0rkSdwqN05GD8Az//oQouv7eDDzbmEy0JcX6NGnCqAea+ktG/43pbUdPfaKDMDe/UYLyqO0sKQWWKoYNKpNJ8LJZlBYpD+o0kmKiqeJp2jXOQjKLBpNPR9bl6KETW5qcqEE1E4iQUj5jhCjoeRv04bWxJGMAh+5eQNJNDvjAX1CkIMELcd7yHm4iuS+Uccttz0HEFGgXbs6BW9gGwqCMpaYe0Q587ujlZFrMT1Vh+52nDwha23obd2fUGG9UpTRz0dKWKhcPw+wBUo7y7ATHDAPtGCo69mklBUL0zDkT6BtackyEArNe+//MCfl3okPXAkrq2JwVtINimWtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djc+8cCltekCDZyyv/TJy7NbztSPwwWlDXGoa4LRFE0=;
 b=CspKCS3SyimV90w7eTgQHOXji7HeatpGi28CyCwOOvwX23dr5gU8FXMTDK5w6lpJihu3nIwUTv0/bBtKbTmxSF5Wu7jzmzcH7QhEJLgzi2Wz9DxOY8aVzX9FHxZ0uvDfBTRIcVDJsppCxZetqtbMlWEUlmW7pMCvk4s6ouCsgGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 07:18:28 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef%7]) with mapi id 15.20.8069.027; Fri, 25 Oct 2024
 07:18:28 +0000
Message-ID: <0d3a7f2f-ce1e-401b-bf73-057f1023077c@amd.com>
Date: Fri, 25 Oct 2024 02:18:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] x86/sev/docs: Document the SNP Reverse Map Table
 (RMP)
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
References: <cover.1729708922.git.thomas.lendacky@amd.com>
 <69e573fb0415eba78069ed8098b69a8dcb973592.1729708922.git.thomas.lendacky@amd.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <69e573fb0415eba78069ed8098b69a8dcb973592.1729708922.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::15) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|MN6PR12MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 107bfff7-b16b-4208-b013-08dcf4c538ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjBhSG5TME1Wem9FSzM3N0VvNE9Xeld3akZGZUxyWXZmK0pPT2ZqNDRmQzJl?=
 =?utf-8?B?aDlUdWdEZFNDWDdFa3VVNnA4cEtxcnFycGYvODE3Rm4zSUV4NE13ZkNPNFF2?=
 =?utf-8?B?enlYUFdnTnROOFdFWEJnaU94Mm1SWmsrcHM1NFhmT00xUGNPRGl2dXlnbmMx?=
 =?utf-8?B?VGgyNXArckwzZENRL0ZCT2RPZmsrY1dZME9JZlFKTXhKRlpYNjJvenhhUmYr?=
 =?utf-8?B?UWtISzZENjVLelFIYkJqR0ZjSmE2d25ZbUw4bERRUGp2bWVONGFVZWp1YVVD?=
 =?utf-8?B?TzY1MHVIWjNlK3FEVHQ0VmFhTHdUQ2RlYjFUSGs0YStOTEU1M1ZvN1ZVcGhq?=
 =?utf-8?B?QXA2YkxZb2JPYUFHaVl5a2xXRldaUWFrZzdYdFFWa2tHWmg5SXAvSGcwMG1p?=
 =?utf-8?B?czYzQndWSDZMV1hYUEdsSmxNdTR5VUJuTDhwNjdyRVpnYzZuOUdQcm5hRW1o?=
 =?utf-8?B?L2djWVpjd3R2Tytta01CSGlYc1B4T2kreVN1VzJSOVVGSVI5TEVyUzVOa2pm?=
 =?utf-8?B?cXA5UTNiWHFNaFZ6TERDSk9Lb1BUaUczbVhqVlRUcUg1Q3l3MHo3UXdYS0Jk?=
 =?utf-8?B?OHdGVVlJdEt0SGQ5QUFudmlPVU1xcG1JVmpvbmVoQVlxRW5QYWZ2UnlrSlN0?=
 =?utf-8?B?VmZnTEpZWGlOUWpPTHlxci9VSGdXd0diaU12a2hTV3lySmErL1NDK2VsM0RG?=
 =?utf-8?B?OEpBbSs2bjRmaHJYZEtDVEp2MnZ4ekJ2Q0NqTXZ6Wm85STh1cVh6UEZJa1BM?=
 =?utf-8?B?ZlhzSHhxSlNQU3NpNmg3MzlGK1ovTzhzNG85blFKTk5xN240Uk1hVC93a2ta?=
 =?utf-8?B?Z0VLNDdTdjZXVk9vTEIxNXJQL3UycE9ZdlFvSTU5VkNmRlIvQU1hKyt6S3pF?=
 =?utf-8?B?M090NStkdklaYlpibndqVitUcUlTMUJvdnRrUTZSd2FEaHRDRHE4cXpGMndC?=
 =?utf-8?B?TmFZOElJSjJ6Rms1S3V2WEJGREdkakFNUktIaTlIVUd3aWszVGdrVmk4eklv?=
 =?utf-8?B?ZDFiU3Q0SjVrZ1JJMVVXVlFQUCtZMko4VmRFckU0QzIwN3MzdmFzQmRBY2Mv?=
 =?utf-8?B?TEhrQVk3UzZ2VXVYT1JYMVFYVFNSaUZ0RlFOZm1SY0dWelNEVU9ZZUJVNzNK?=
 =?utf-8?B?dGVGNDI4L2RHN1p3bUhlcUxhNHZOWFVxamdXL21LZHoxcHp2ckFMQnMrWEdh?=
 =?utf-8?B?Y0NhVkdIVTUyNTZ6K3NWejc5NE8wc3FyVndxSkRDMm0yOUhOWDc5ZnM5TnVY?=
 =?utf-8?B?SXYzUjU0SnhpZnM1K21ZckpFTzZ3bzhYSG9vTXA5WHZLRXRyMUczaVJzWi9n?=
 =?utf-8?B?SUhwSzVCamlrZnZSUmJ6SlVLakZub2ZmNzVaMGpXNFdTVEIrKytvcHlseFRr?=
 =?utf-8?B?RXN6Z0FHZkExZk80dDZjTWdWQ3lsMWJ1d3RxMm5QVUt6NTdlTmVtYW9GZnZP?=
 =?utf-8?B?OG9xY3BESUZ2U1lvTFZ3Z1BBbTV4ZFRpeXBuandiOXlDQ1lMdGVkUks1WnpQ?=
 =?utf-8?B?SFdoZ0tqcnJVOXpVM1ZoUTBCWGtwTGNUV1V4Rm5LNUtOZXhXVzNGSE1HSlRk?=
 =?utf-8?B?dk1kZ0g3VDZ3WnpCM3RwVHo0QVE4c3o0djcvZTdUYWQwU3k0Sk5QRmdpc0hm?=
 =?utf-8?B?cklwSjBaOXByWjFUV0V0WTZoN0o4bms3NSt3Kzh6b2VZZ0JudUcyYmYzdXBW?=
 =?utf-8?B?R1drczV5NHlrZTA0bzVoZ3BScXhsUTZGVFZQVTNqYk9XUjdxQXpVVnYydEVE?=
 =?utf-8?Q?tXXSSnmYhIqT38/QiYXQydWeFj79+klqGKB5xNb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWFQbHVDRTh1L3gxOW1BWG5MaWtteGQ5eGVtT1NBd0RJVVM1djVhcDJMMXl0?=
 =?utf-8?B?dEZ1dDAxN2ZJRTJmZnRnUE5PWDMzQXplRlR5Q3FkR05CbDBscjRwTTR0UVls?=
 =?utf-8?B?V0tlY0V3UWwydVhtS1JaRG4zcXpFRWRkSVkyeG5yZnBJd0N0d3FXOFNScXEy?=
 =?utf-8?B?T21nSHNORGk3ZmNaa091VENia0VIZjJlSnNmazl2a0ZuTzNneDZBbC8vV0hJ?=
 =?utf-8?B?b3hDbzlmc1pHdEV0TWhOeDJyV3Rla2NMRVVoRHl4bWo0R3I0dXdGaThURkNY?=
 =?utf-8?B?MEVibW53eDlxSVpmay9DYUhwNUlObXp4amNPWTdzTnlUenhqQUFBUnZhcWhN?=
 =?utf-8?B?Yk9lVUJ6TjI4cTJnbVNqamlsSmdNTWxVVklTaW9aU0wyVllmdlJXTTMzTHI1?=
 =?utf-8?B?YUVhdmhjWHIyUGVubTVNRFhGZmFkU3oweEFZN1VOeG1zcnpKcmxWSjkvbHBM?=
 =?utf-8?B?M3dDRThORGIyOTFjbWs3dG5DaVF6R3RqTGwydmRWMW5zVnVyajdQQW9MWmFP?=
 =?utf-8?B?ZzUzejR4L1hvaXBOL0c3c0RERmNkWjlFWEdQK0E5Y3FaUThBZ0djWHErSU8w?=
 =?utf-8?B?UVM3ZVUrZjdONHJaOVNIRjZGbGFXbmxwRnlldVZnbDZVK0h4dkdCa2JNN1A4?=
 =?utf-8?B?aGIzcTZ4V3VNVVZZd2FsV05KaUgvWndXNjhaRVN0YmpiYnhoTTQ1V0UyZzlH?=
 =?utf-8?B?UXg4YzJ1Qm5VbEtEOEoyc3EydDNYaDNVNHFhS1hRbWd0UEgyY0NVYzhzemJh?=
 =?utf-8?B?bzZscjYzZEtPTWlIWGszdi9tV2o2OW00cW5McXlrRC9wUjdTNGR2dUgzTktF?=
 =?utf-8?B?S0FtVzZRU2dnZ0lubGZBWDZQd2pIdjRMNko0c0Zwa3dsWG1SU3JPaEM1bG9p?=
 =?utf-8?B?dVcvRjVwQnhyTmdMTVluNnBHNWJQMG5hSG9UbEx2K0tSSXpwRFIzK3dqaHcw?=
 =?utf-8?B?a0J4SUVaaElKL3U4c2pQcUFkdVdieEtDWEZnZFd4cFVvSUZvNituaEVkRmh3?=
 =?utf-8?B?YysvUGJOcElKZWM2bFhtYmVZSjlUVDVuMHY5STlUZ3VFakFMeGpHMGtzODB1?=
 =?utf-8?B?bVVjeHVjR1pFa0RHWHJpM05OMnQ2NXpsckJaaTNYZVJsaFptenFFSVBmR0c3?=
 =?utf-8?B?QjN6YzBldkQrZFBBSmRrdlkvZzNpbm1jRVl4bVczMUFXTUkxTkRMZzFIeVVR?=
 =?utf-8?B?V1hSTm1zNk4vTWVBUjBGN0duRHg4alhRQUR2NzZtck5uMXI4eFRNbWh4TzZU?=
 =?utf-8?B?amtJd0tMamtydVZvYkF4Z21EN3Q1aTk0aWFzV013QWpFV2tKMHFJazdqb2kv?=
 =?utf-8?B?V1Z3b01yYldlVGZleE5iemVmTlc0ZzhxTHg2UTcrSHhTYi90YlEwbkZiNElw?=
 =?utf-8?B?NGVVOWwxckRUeFNDeFZyd3ZwRUhqdFIrMVRJbzJpcVVmc3Z2enNKaE5tSGsr?=
 =?utf-8?B?Y1FNTWJaaVBzSjRIRVJQOU5VVnNWYng2S09GTnVFN3BHVDFXSGV0bGdGT3Qy?=
 =?utf-8?B?cWpQdVdmTVF4OFIyK2pGUXBFZW9MclZHb3ZvazdaVzJrRHp0aTBXdFRNWFpG?=
 =?utf-8?B?VkpHTXNucEtlTnBOeWMzZVhmbnNqandhOFp0Q1NyU0owYXNmcXBSRjQ1RDY3?=
 =?utf-8?B?RUsyaW9hSkdvakxxN2owcVh0R244aEhEMUFZS0x4ZlVQeUNIT0NUZWR3Vlph?=
 =?utf-8?B?T2MvZ1ovQWRjU2pUbVRtRlNkaXpqeEM4c3p6L2RaQTVPSWZ6Mlg3a0xZSXps?=
 =?utf-8?B?SkJrd3ljZUdSWEdpQzF1VXZybm85UUdONnptbTJpeEQzbG1NSUtZLzkwQWNm?=
 =?utf-8?B?RS9rVDZqcU52akRvY1V4MGVUQk52WlJXY2RoTVNJSGRJMFIvclNYSmJDdUJV?=
 =?utf-8?B?Ujh4a1pnUjU4Qi9VcmpiSVpXM2JIdzJ3TzFwTi9Xa0g4d0N4bC9WMDNFUCtT?=
 =?utf-8?B?SUFTVUxNK29OK0JGQTRwSEgyMTdEOVdONGFCR00vRWZmQUxESWs2ZEZseXAv?=
 =?utf-8?B?M0YwTUFBcFMyVGJ5QW5SdWtLZGhtMDY0Z3RYT2lOSklrSEJiN0JXOStNc2VC?=
 =?utf-8?B?Uk81RGxaVDRYdk5IMlFFVUx3SWtLbjlCSEZpUThDMjYvYU1laXYvQnRVRlpT?=
 =?utf-8?Q?Qlbvm8w5g69gfKAHFB8mPvl5F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107bfff7-b16b-4208-b013-08dcf4c538ce
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 07:18:28.1387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NADMPuMC+J2lR4TtTzgyd24gnYIDZ3P0aopRn//N4ZWrWSJjvoeYjJiP3GB2BRAhj/7pyApEUTc/c/9e54pUYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8568


On 10/23/2024 1:42 PM, Tom Lendacky wrote:
> Update the AMD memory encryption documentation to include information on
> the Reverse Map Table (RMP) and the two table formats.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  .../arch/x86/amd-memory-encryption.rst        | 118 ++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/Documentation/arch/x86/amd-memory-encryption.rst b/Documentation/arch/x86/amd-memory-encryption.rst
> index 6df3264f23b9..bd840df708ea 100644
> --- a/Documentation/arch/x86/amd-memory-encryption.rst
> +++ b/Documentation/arch/x86/amd-memory-encryption.rst
> @@ -130,8 +130,126 @@ SNP feature support.
>  
>  More details in AMD64 APM[1] Vol 2: 15.34.10 SEV_STATUS MSR
>  
> +Reverse Map Table (RMP)
> +=======================
> +
> +The RMP is a structure in system memory that is used to ensure a one-to-one
> +mapping between system physical addresses and guest physical addresses. Each
> +page of memory that is potentially assignable to guests has one entry within
> +the RMP.
> +
> +The RMP table can be either contiguous in memory or a collection of segments
> +in memory.
> +
> +Contiguous RMP
> +--------------
> +
> +Support for this form of the RMP is present when support for SEV-SNP is
> +present, which can be determined using the CPUID instruction::
> +
> +	0x8000001f[eax]:
> +		Bit[4] indicates support for SEV-SNP
> +
> +The location of the RMP is identified to the hardware through two MSRs::
> +
> +        0xc0010132 (RMP_BASE):
> +                System physical address of the first byte of the RMP
> +
> +        0xc0010133 (RMP_END):
> +                System physical address of the last byte of the RMP
> +
> +Hardware requires that RMP_BASE and (RPM_END + 1) be 8KB aligned, but SEV
> +firmware increases the alignment requirement to require a 1MB alignment.
> +
> +The RMP consists of a 16KB region used for processor bookkeeping followed
> +by the RMP entries, which are 16 bytes in size. The size of the RMP
> +determines the range of physical memory that the hypervisor can assign to
> +SEV-SNP guests. The RMP covers the system physical address from::
> +
> +        0 to ((RMP_END + 1 - RMP_BASE - 16KB) / 16B) x 4KB.
> +
> +The current Linux support relies on BIOS to allocate/reserve the memory for
> +the RMP and to set RMP_BASE and RMP_END appropriately. Linux uses the MSR
> +values to locate the RMP and determine the size of the RMP. The RMP must
> +cover all of system memory in order for Linux to enable SEV-SNP.
> +
> +Segmented RMP
> +-------------
> +
> +Segmented RMP support is a new way of representing the layout of an RMP.
> +Initial RMP support required the RMP table to be contiguous in memory.
> +RMP accesses from a NUMA node on which the RMP doesn't reside
> +can take longer than accesses from a NUMA node on which the RMP resides.
> +Segmented RMP support allows the RMP entries to be located on the same
> +node as the memory the RMP is covering, potentially reducing latency
> +associated with accessing an RMP entry associated with the memory. Each
> +RMP segment covers a specific range of system physical addresses.
> +
> +Support for this form of the RMP can be determined using the CPUID
> +instruction::
> +
> +        0x8000001f[eax]:
> +                Bit[23] indicates support for segmented RMP
> +
> +If supported, segmented RMP attributes can be found using the CPUID
> +instruction::
> +
> +        0x80000025[eax]:
> +                Bits[5:0]  minimum supported RMP segment size
> +                Bits[11:6] maximum supported RMP segment size
> +
> +        0x80000025[ebx]:
> +                Bits[9:0]  number of cacheable RMP segment definitions
> +                Bit[10]    indicates if the number of cacheable RMP segments
> +                           is a hard limit
> +

Some more details on cacheable RMP segments on why are they supported, platform/processor specific ? 

> +To enable a segmented RMP, a new MSR is available::
> +
> +        0xc0010136 (RMP_CFG):
> +                Bit[0]     indicates if segmented RMP is enabled
> +                Bits[13:8] contains the size of memory covered by an RMP
> +                           segment (expressed as a power of 2)
> +
> +The RMP segment size defined in the RMP_CFG MSR applies to all segments
> +of the RMP. Therefore each RMP segment covers a specific range of system
> +physical addresses. For example, if the RMP_CFG MSR value is 0x2401, then
> +the RMP segment coverage value is 0x24 => 36, meaning the size of memory
> +covered by an RMP segment is 64GB (1 << 36). So the first RMP segment
> +covers physical addresses from 0 to 0xF_FFFF_FFFF, the second RMP segment
> +covers physical addresses from 0x10_0000_0000 to 0x1F_FFFF_FFFF, etc.
> +
> +When a segmented RMP is enabled, RMP_BASE points to the RMP bookkeeping
> +area as it does today (16K in size). However, instead of RMP entries
> +beginning immediately after the bookkeeping area, there is a 4K RMP
> +segment table (RST). Each entry in the RST is 8-bytes in size and represents
> +an RMP segment::
> +
> +        Bits[19:0]  mapped size (in GB)
> +                    The mapped size can be less than the defined segment size.
> +                    A value of zero, indicates that no RMP exists for the range
> +                    of system physical addresses associated with this segment.
> +        Bits[51:20] segment physical address
> +                    This address is left shift 20-bits (or just masked when
> +                    read) to form the physical address of the segment (1MB
> +                    alignment).
> +
> +The RST can hold 512 segment entries but can be limited in size to the number
> +of cacheable RMP segments (CPUID 0x80000025_EBX[9:0]) if the number of cacheable
> +RMP segments is a hard limit (CPUID 0x80000025_EBX[10]).
> +
> +The current Linux support relies on BIOS to allocate/reserve the memory for
> +the segmented RMP (the bookkeeping area, RST, and all segments), build the RST
> +and to set RMP_BASE, RMP_END, and RMP_CFG appropriately. Linux uses the MSR
> +values to locate the RMP and determine the size and location of the RMP
> +segments. The RMP must cover all of system memory in order for Linux to enable
> +SEV-SNP.
> +
> +More details in the AMD64 APM Vol 2, section "15.36.3 Reverse Map Table",
> +docID: 24593.

The document does not cover Segmented RMP specifics, is there any other reference to a document
containing Segmented RMP details ?

Thanks, 
Ashish

> +
>  Secure VM Service Module (SVSM)
>  ===============================
> +
>  SNP provides a feature called Virtual Machine Privilege Levels (VMPL) which
>  defines four privilege levels at which guest software can run. The most
>  privileged level is 0 and numerically higher numbers have lesser privileges.

