Return-Path: <linux-kernel+bounces-422859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BC99D9F11
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD4E1B251B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 21:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072B61DFDB4;
	Tue, 26 Nov 2024 21:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hHT2eAuo"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8971DFD8E;
	Tue, 26 Nov 2024 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732658290; cv=fail; b=n0Y7p8A/UT9Oe8pjH+1BIFATyAYeXBfxBUyYjP5PhGoO0h9oAm0PCdTCB1z+cYR8pynmybJvQmc34jZAcdEPZC+vsHoO1XlY+h0qbo/dfjv1KnxyUTqER1MRbC38cKqIUbfP3Sk9xRC+mO97y+3GONobfrGNUfZzf9IuaxO3LFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732658290; c=relaxed/simple;
	bh=zOsfiL56J1A9jRJbI4aI5B7U+F1qsnvbQpsTzdykHmQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F9KXs8WpwDLz5TLIAjNQ6m2FA7S5ospNGPaNhkUcODnlxJJ1sAB265dKKw4Jwd78RDPkBC3njK0wQ3jGpqRBgWH3IFBZLfevmB+QA4MZJ4UnM55Ahwd7ukKfTDccaVi3q4fOgtcKzFDKe+Aa5AkVQl7I0UedPte4nzFnfKr0/9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hHT2eAuo; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfkbXniW/gLc3zRK/BQX1Ee+9RCtWseu7rNTm8uiEb+Eg2slm7/lQykCiHHj8XLuSUziWZPPnzxE24/jI0aYpCRguJIRizBVHE76Y6UA0WuEP1ZsYMuik1pT3/O+HHQ8BWFrQh9oUFOwDvVD9awOEuVcKi/bLntkbWA04FCmZXssE1SdxNumyz+zm8XJVBPB/LeVfqb+v7KEWmsTJ+szwkmgoBh0YkuC2l+vZNzf+rcbvaL+npZghMCemmtqgh34FI/LelrH+1hwzsbojuaIGTF7LfPqn4tzsB1fbpUBaDsGCGvYYFAYTa2UR+rJ4BVvNveqrQgBTWk7H0inKUSTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrSwyk+q5WS/UUa2XaRX6nvbylhnTso6CpnJHNGS6bQ=;
 b=C9bm/sQciomO0SkvrEsV4gRyPdgzCwRS5mvu+xV5VyDQ6f4iyqjkQEHU1SioesyAkifIkdY+AhdQtcV0X4kA6+G12r/EWeHKB4PiurgqyKpK6VGk5jp8gl4zSZjTpfugm+HFt85FtGb1M9+f44gKZwb2aB0cdmM9Aclf6+4bMXsycP1OXhJQGxbcZwS/yN62JxGZ99B6rHdHuqPW/uNf/NuV+fIq6B8wqBdebM00iiTJ1WhnQXS+g7eM655sjSziu3L2/70ykNJ1RC0xaDc+B/ZNHlhF2bdpREzcwnTYSqOqWvLz737NvXLCYR3F1oquO08omafeotAUaXDTT7P4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrSwyk+q5WS/UUa2XaRX6nvbylhnTso6CpnJHNGS6bQ=;
 b=hHT2eAuoJcio+Et3sZyx8VPnzlgnq1TzI+OCil1eDCoOe8pbvBgF5osIzzqE2I0/8fGpap8RTvkQouQocEJleLJt8KMFG6OfrYz23bPZK66hn3SLoO8csSYetERUQ2BYh55FKYz/ShxGJUgAMXcqp010IpTVZ0euAgVtFkX/ALw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 21:58:06 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8207.010; Tue, 26 Nov 2024
 21:58:06 +0000
Message-ID: <186dbcfe-dca8-49d0-ba26-8fdc12ccef62@amd.com>
Date: Tue, 26 Nov 2024 15:57:56 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 08/26] x86/resctrl: Introduce the interface to display
 monitor mode
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, thuth@redhat.com,
 paulmck@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 jithu.joseph@intel.com, brijesh.singh@amd.com, xin3.li@intel.com,
 ebiggers@google.com, andrew.cooper3@citrix.com, mario.limonciello@amd.com,
 james.morse@arm.com, tan.shaopeng@fujitsu.com, tony.luck@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peternewman@google.com, maciej.wieczor-retman@intel.com, eranian@google.com,
 jpoimboe@kernel.org, thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <121c79ea1abe6f21f726d086eba9fa61d31da3f1.1730244116.git.babu.moger@amd.com>
 <fe518638-a82e-4136-ae77-fa6a7abb4b2e@intel.com>
 <33cd0cc0-4f81-4a2d-a327-0c976219996a@amd.com>
 <d5bead60-6a38-426e-afa6-e7980a268d6f@intel.com>
 <0eff9462-e7e2-49a9-9538-c8907024322f@amd.com>
 <6c5f8c64-43f6-4145-b0dc-429603f8ee24@intel.com>
 <9fc844fc-23e3-4b58-958d-75c96c98fad7@amd.com>
 <6bd4335d-4b55-455f-a042-948df227e02e@intel.com>
 <18eacffe-3839-4104-81ee-a3497b1f28f1@amd.com>
 <3f26c0b6-e010-4dfc-b5c3-7659f341dbe1@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <3f26c0b6-e010-4dfc-b5c3-7659f341dbe1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR19CA0021.namprd19.prod.outlook.com
 (2603:10b6:208:178::34) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW3PR12MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b018274-888e-40cb-95db-08dd0e656856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1FxbHR5TWdxeGtFUHVpUld2OW9FWDJuMVJkNFBJRkFaeXJGaVIrU0Z5RFNx?=
 =?utf-8?B?eTBCVmtSTGx6UkNhNlVDTWhKd1p2TTB6dUxqcktrQ0p2Y3lrTm5aUndzZzQ4?=
 =?utf-8?B?VCtCMStTZ3lKUHpkTHQvTjF4WFVuQlROcmlVVld6ZVhPdyt2MUNCZEo4YnlE?=
 =?utf-8?B?cHV6elg4Y1k4M2VjeDBJWTBzZU56b29waDJVMWZiemYrb3BiYXpmVWkwaDdI?=
 =?utf-8?B?Zmx2WjRwYnpMZ1lrMnBrdGJlWmJYbnJ5aFg2aDEreDFHRVBSTVhVaUtaRWY2?=
 =?utf-8?B?YTZ4UmZmOTZDeEVteVdxbU1KNDhYVVhWb0c1b290aEd5YjlmY3pqczNkL255?=
 =?utf-8?B?bXNseHNRaThCcDFrMEtwZVA0MUlxaUoxTUJZME9ZaHd0TFB0V2RxRnBpZVBZ?=
 =?utf-8?B?Vi94dkw1OUFMWVJxVkcrYUM1WmllK254VHhubGlaL3BJVEFWSW01NlFRTkJz?=
 =?utf-8?B?aHhpYXB5VTZuU1JxQ0YvSHMxSGRuQkRxZzVNaHljQ0F4MmM5d2R1VjJLcHVS?=
 =?utf-8?B?WGNjWVgvTHRSU0F6NzkzQmFrZW9iRWtBcDVsWmEvYWd0b3lDcTEwWVVsbEFt?=
 =?utf-8?B?dWNMcHpWUS9VbGhEQWdiaFhxMlhLQ2gyeUpiclVKZUJaVDBwYUZTWjV0cDZF?=
 =?utf-8?B?SWwwNzV0eUlSdzBtM3ZYSll6UlI0NlBvOVV5NERNQldEazdFUHVZR0drYVRI?=
 =?utf-8?B?d2Y5MlJRWTBTUlQrb2xjQ0pobTBhdFpidU1kSW8zYngzbmJNcUxGckpwUkUv?=
 =?utf-8?B?VkFGRFNNMlJIM2tESXlENGlLY2g4YU51dHRhd2dGcXFHdTNDVk5Vckx6ZXNS?=
 =?utf-8?B?NW1aVDhhNVE5USs0SFFRalpETCs1ZlB4ODJjNG1iaUVzV1BwUlVlMzYwWDhB?=
 =?utf-8?B?TnNPTWhIcHBkSFBWR1BTalJFUUdwR0phd0xtZ1BRZHpoR2txcWtsaGo2NUV0?=
 =?utf-8?B?azBwaXhnZzREZzFJTzdTTlRqRnFnNmplZG43V3JvbHp3NnUrMHBOSFliMlkw?=
 =?utf-8?B?WVFHNUtiMDArNGp6RDhsYk5zZ0NheG00WlFZWk4vcFNyUFNkUVJCSkxpM0NI?=
 =?utf-8?B?WUFhSzlUVXdRQ3VQUGpCclkwYzRxekV3RjlTUWt3MzBYWGZYZDMwQlJQYUp2?=
 =?utf-8?B?VkpYUWlVZjAxa05LNG80SjJwNXNQNlRlUm5GSDM3VWdTNldZdTBLSnRBTUVL?=
 =?utf-8?B?N3Z2T24wdXQzbm9BdjZEdUpLNnlRSldQdEsrRU9PN1lHOWwyazA3bER2WEZC?=
 =?utf-8?B?WHRKbkV1ZE1WWlE1dWJwdk5pNUN2R1lwRi9DWDV6YUhDaDZ5TEJCL1RBaFRM?=
 =?utf-8?B?WTVKZHIzdGNYVUJxVCs1R281dWNabEhpZFNLLzBvdUp5NmMzOFFkSit4VGxQ?=
 =?utf-8?B?YmE5aXJvTWNyODZkVTQ0cm9XRTJsRHM2cFFnbHZ1eVg4VTFWaWp1V2pQMWVJ?=
 =?utf-8?B?Tms1amxNM1VyTEd5Q0lmeitHNFY0ZG1hTUNzVHRweTlMcTVyRzlEM1Naa1FI?=
 =?utf-8?B?TUozVW5yOFpJTnd6WnlOMWdQNEFPTVhHUXFsWVBDWUF5WWlkSUxxdDZuZk1o?=
 =?utf-8?B?eDFUdWpNSE5XN3plN2NHZlJMWjc2cVZKcWtmc1JMTHpMY3QzcFN1SjQ3MGR4?=
 =?utf-8?B?TlNPWGZWVEdVNnF4c0hpTjBhdkQ4L1BOTEdLU24rVWxUSFJvTzdlai93TnpM?=
 =?utf-8?B?aVIzVHU4U1VRYmhYQzlCZHFGTERtTWZxdGhXUzdBNi9EdC9rZ3FsZzF2M0lR?=
 =?utf-8?B?SmxQeGIrN1h3OXNqb1c5aWN2ZjFrV2VHMmcyV0EzUm5ZN3hEVU5tSExxQjFN?=
 =?utf-8?B?Z1cyaHZRSitNYndlcUJNUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFViWldIb3I5YXdwMG8vbHpUMGFhRC9yQ3FzTDR1bVlmZ3NBRlpmSUpiaTVo?=
 =?utf-8?B?K2diUVd1RVFPRVRKSC9OazNCK0hPK3FzanV1Q2lhV1l1d0VZVjZ0S0VWUjQz?=
 =?utf-8?B?dDVudEZZaVlTVGlhVzdXVGdaMnFtS2JONkQ3RnNjMmJUL0NLRzBrbEU4ZGl0?=
 =?utf-8?B?NVlBUlRTZ1NXeXJkYVo5OEx6eGpnY3J0Mk5xSGRuSUFpaDI4SU1aNWFpY3lT?=
 =?utf-8?B?Sk9HV1VDVDlhSHQvUzloV09nNTR3aGVzZ1VORlNtY2ZnT25HdFNFT0xkeVJV?=
 =?utf-8?B?WGtDMGZmMDZxOHFtU0h1RVlZNUpJeXR6UTJHNWh2WW9hZ25Fc002dHM1QTBX?=
 =?utf-8?B?blFFTGNFR1hqMXJPRzg1a2Z1dG1BQi9OWmZSY3hjamdSck9mT0FhZkUxYlZY?=
 =?utf-8?B?UWZmaTZDUHhFV2poZDQxTyt2ZkhHdzA4N0NFMjR4cUVtTFlEeVRzN3BlQUJI?=
 =?utf-8?B?dWZvMkl1cWlldUlwbWZZQTV3ajBQc3NNa09kOENxMXZHMk9RZU5KOERNVEhn?=
 =?utf-8?B?eEhiTDJ1WXh0Q0Z2VVFGTEIvUXhaWmFhWHRkaXhkZG5KYVdhZzJzUnBZbWRl?=
 =?utf-8?B?QW5hZk1lQTl2TzBMM3RsemtmbHplVmJhdlFnRzJBV2RYTUQ5MHF0WGhIc1Bt?=
 =?utf-8?B?MkVqenNxMVBjTE83L1pZZlBuYU1yWlBCb2E5RWJqSHNkYXorSjZ0bEpHbjNX?=
 =?utf-8?B?NDVPcjRrSFRyVHB3TU02SUF6bW81aDhmMWxCRU1pMDcxckMwS3BjUmlpempt?=
 =?utf-8?B?bzIxUXJzS2c2eVZZQUF3YjNtaXd6YW1GajJIc3dEK0NnWVFFWERSeWRjaWxR?=
 =?utf-8?B?WUxyeVVNOFIyM3ZpeGJHNFM4Y2hPbytpQVV4OTFldDQzYmhqSjQ0cXhxQ2lq?=
 =?utf-8?B?VjFEcGVxT3plck4reXROMjk1ejFQVldFNCtkSVpwQk1DK1BuY0I0YUNBejJr?=
 =?utf-8?B?cmRtZ21MUk1OOVAzUEpDMGJVN0FDRWpTYW1nK3lPQ0Y4MUxzZ05YUk1taFpG?=
 =?utf-8?B?VFNpUlUxeHJYMDZEdW5wSytUam1CNFpRSC8zc2NaTlJzOUtWdHJpeWRMa0Zn?=
 =?utf-8?B?aTZadXBNQWY2RGF0VjZhRGR5QVJ0Qm1SMUpFUVRxMTNTQ1VqUTRKUkJ2WWto?=
 =?utf-8?B?U3Z1dVN6OW1Ib3Q5UUhXT0Z4VlIvRzc2ZnorWkl5dlRxeXNmWW45SFAyUkFs?=
 =?utf-8?B?cXRtWmJnNEU4VitiZWJBRUpCNW1JajROams5OW5zWjI1TURBOUpXdDMwNEpn?=
 =?utf-8?B?Znk5em9SVHR1WGZRZnJkRHJESHFjVkQxN0pFUzVkMUN2NmwzdTZONXVQeUhM?=
 =?utf-8?B?Um1QMDhLdFUzeFdxWlh0L09xc2xHSUw1Yzg2ajdOVGZZMzRjUm5MYkFkQTly?=
 =?utf-8?B?bGtHWWE3QzVsM1hvUlBzdk53VWlTWWtheDVXRGlxUUtiOEhTRVMyTzkrZk80?=
 =?utf-8?B?NHkwRjRBVEwvT2JOd3NvcXdrMjZSZUorUUFheXhnZk9hcXljNXlrQnU2d29W?=
 =?utf-8?B?bzhQM285Z3kvamtqQ09HR05DM3NYVkZjeDk3Tll2L1AwSHdHVzhabktlNDZM?=
 =?utf-8?B?L2ZRTWRrdzZ5Z1hsenlvVFZzbjc1TmgwYWd5Z1ZsRGNXaTcrSU01Nm8yb2dB?=
 =?utf-8?B?YSs0R0UvR3B5b21RTzFHRFJUdmVzMFhna2lTdHE2MGpoWWFYMTRqbHR3UVpQ?=
 =?utf-8?B?RVRTb0ZIaHdLYmpIN1lSdTQrYjk1blF6RkQyakVHN2ZUY1hvUHNkdktaMW1x?=
 =?utf-8?B?SjFWTHRDQmx0WEhZR0RzVyt5ampOU3d0UnRRUU1zaEhoTitDLzZpbFlncFRl?=
 =?utf-8?B?eDV5R0tRc0xzZjFqQ3hMNUJEMFp5d2UyT2dhczgwbzdTdnhYMmt0bkZkc25V?=
 =?utf-8?B?NlhERlE2d0ZwQ3AvUC95dEplN2w1VEZOWHVnY2FFTFhaSDdRUGZwdWRLc1Jj?=
 =?utf-8?B?NGViYXJQR3RoR0o1WlEwQzI1aU1EcWNBUEdieUllK1VNWFBJeXRwQWdld1NW?=
 =?utf-8?B?ZjhKK3kzRFVUOC9NbTQ2V05Lbkdaa0hYK0xWYjZjaEQ5blozNmQxODZPV3Fo?=
 =?utf-8?B?L0tJcXA4eEtOS1dCTDQzT2VjZzdvT0d4RW9wSUJ6M1JGeFVvRHVNNEpQY0Fz?=
 =?utf-8?Q?dtpA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b018274-888e-40cb-95db-08dd0e656856
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 21:58:06.3623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEyQmoiT4Jte9XbFXnrjWw4lFzWZg7pD4Gosjb31X+eMXyLXeq53DwONOzoKjr8Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409

Hi Reinette,

On 11/26/2024 1:01 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 11/26/24 9:09 AM, Moger, Babu wrote:
>> On 11/25/2024 12:17 PM, Reinette Chatre wrote:
>>> On 11/22/24 4:02 PM, Moger, Babu wrote:
>>>> On 11/22/2024 3:37 PM, Reinette Chatre wrote:
>>>>> On 11/22/24 10:25 AM, Moger, Babu wrote:
>>>>>> On 11/18/2024 4:07 PM, Reinette Chatre wrote:
>>>>>>> On 11/18/24 11:04 AM, Moger, Babu wrote:
>>>>>>>> On 11/15/24 18:00, Reinette Chatre wrote:
>>>>>>>>> On 10/29/24 4:21 PM, Babu Moger wrote:
> 
>>>>>>>>> I'm concerned that users with Intel platforms may want to use the "mbm_cntr_assign" mode
>>>>>>>>> to make the event data "more predictable" and then be concerned when the mode does
>>>>>>>>> not exist.
>>>>>>>>>
>>>>>>>>> As an alternative, is it possible to know the number of hardware counters on AMD systems
>>>>>>>>> without ABMC? I wonder if we could perhaps always expose num_mbm_cntrs as a way for
>>>>>>>>> users to know if their platform may be impacted by this type of "unpredictability" (by comparing
>>>>>>>>> num_mbm_cntrs to num_rmids).
>>>>>>>>
>>>>>>>> There is some round about(or hacky) way to find that out number of RMIDs
>>>>>>>> that can be active.
>>>>>>>
>>>>>>> Does this give consistent and accurate data? Is this something that can be added to resctrl?
>>>>>>> (Reading your other message [1] it does not sound as though it can produce an accurate
>>>>>>> number on boot.)
>>>>>>> If not then it will be up to the documentation to be accurate.
>>>>>>>
>>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +    AMD Platforms with ABMC (Assignable Bandwidth Monitoring Counters) feature
>>>>>>>>>> +    enable this mode by default so that counters remain assigned even when the
>>>>>>>>>> +    corresponding RMID is not in use by any processor.
>>>>>>>>>> +
>>>>>>>>>> +    "default":
>>>>>>>>>> +
>>>>>>>>>> +    In default mode resctrl assumes there is a hardware counter for each
>>>>>>>>>> +    event within every CTRL_MON and MON group. Reading mbm_total_bytes or
>>>>>>>>>> +    mbm_local_bytes may report 'Unavailable' if there is no counter associated
>>>>>>>>>> +    with that event.
>>>>>>>>>
>>>>>>>>> If I understand correctly, on AMD platforms without ABMC the events only report
>>>>>>>>> "Unavailable" if there is no counter assigned at the time of the query. If a counter
>>>>>>>>> is unassigned and then reassigned then the event count will reset and the user
>>>>>>>>> will get some data back but it may thus be unpredictable (to match earlier language).
>>>>>>>>> Is this correct? Any AMD platform in "default" mode may thus be vulnerable to
>>>>>>>>> "unpredictable" event counts (not just "Unavailable") ... this gets complicated
>>>>>>>>
>>>>>>>> Yes. All the AMD systems without ABMC are affected by this problem.
>>>>>>>>
>>>>>>>>> because users should be steered to avoid "default" mode if mbm_assign_mode is
>>>>>>>>> available, while not be made concerned to use "default" mode on Intel where
>>>>>>>>> mbm_assign_mode is not available.
>>>>>>>>
>>>>>>>> Can we add text to clarify this?
>>>>>>>
>>>>>>> Please do.
>>>>>>
>>>>>> I think we need to add text about AMD systems. How about this?
>>>>>>
>>>>>> "default":
>>>>>> In default mode resctrl assumes there is a hardware counter for each
>>>>>> event within every CTRL_MON and MON group. On AMD systems with 16 more monitoring groups, reading mbm_total_bytes or mbm_local_bytes may report 'Unavailable' if there is no counter associated with that event. It is therefore recommended to use the 'mbm_cntr_assign' mode, if supported."
>>>>>
>>>>>
>>>>> What is meant with "On AMD systems with 16 more monitoring groups"? First, the language is
>>>>> not clear, second, you mentioned earlier that there is just a "hacky" way to determine number
>>>>> of RMIDs that can be active but here "16" is made official in the documentation?
>>>>>
>>>>
>>>> The lowest active RMID is 16. I could not get it using the hacky way.
>>>> I have verified testing on all the previous generation of AMD systems by creating the monitoring groups until it reports "Unavailable".
>>>> In recent systems it is 32.  We can drop the exact number to be generic.
>>>>
>>>>
>>>> There is no clear documentation on that.  Here is what the doc says.
>>>>
>>>> A given implementation may have insufficient hardware to simultaneously track the bandwidth for all RMID values which the hardware supports. If an attempt is made to read a Bandwidth Count for an RMID that has been impacted by these hardware limitations, the “U” bit of the
>>>> QM_CTR will be set when the counter is read. Subsequent QM_CTR reads for that RMID and Event may return a value with the "U" bit clear. Potential causes of the “U” bit being set include (but are not limited to)
>>>>
>>>> • RMID is not currently tracked by the hardware.
>>>> • RMID was not tracked by the hardware at some time since it was last read.
>>>> • RMID has not been read since it started being tracked by the hardware.
>>>>
>>>> All RMIDs which are currently in use by one or more processors in the QOS domain will be tracked. The hardware will always begin tracking a new RMID value when it gets written to the PQR_ASSOC register of any of the processors in the QOS domain and it is not already being tracked. When the hardware begins tracking an RMID that it was not previously tracking, it will clear the QM_CTR for all events in the new RMID
>>>>
>>>> - Babu Moger
>>>>
>>>
>>> I think I am starting to understand what is meant with the "count the traffic in an
>>> unpredictable way". From what I understand the hardware uses the "U" bit to indicate
>>> that an RMID was not tracked for a while, but it only sets this bit on the
>>> first read. After that the "U" bit may be cleared if a counter can be assigned to an RMID
>>> afterwards.
>>> If it was only user space that reads the data then it should be clear to the user when the
>>> hardware limitation is encountered and thus hardware behavior can be "predictable", but since
>>> the overflow handler runs once per second it may indeed be the overflow handler that
>>> encounters the "U" bit and that bit is not currently handled. This could leave user space
>>> with impression that events are always returning data but that data may indeed be wrong.
>>>
>>> In another thread [1] Tony confirmed that "U" bit is not returned by Intel systems so
>>> this issue only impacts AMD. As I understand the other scenarios in which AMD systems
>>> can return "U" (the first read after assigning an RMID and the first read after changing
>>> the memory config) are all scenarios that can be controlled by resctrl.
>>>
>>> I do not see why unpredictable data should be addressed with documentation. Could this not be
>>> fixed instead? Essentially stating "AMD systems without ABMC count the traffic in an unpredictable
>>> way" seems like a poor user experience.
>>> What if instead resctrl handles the "U" bit better? For example, when the overflow
>>> handler encounters the "U" bit the RMID can be permanently marked as "Unavailable"? Would
>>> that not be better than the counter behaving unpredictably with users never knowing if they
>>> can trust the event counters?
>>
>> Actually, I was looking at handling "Unavailable" in little bit better way. Right now, I see it reports "Unavailable" first then it goes into overflow and stays in overflow forever.
> 
> Could you please elaborate what you mean with "stays in overflow forever"?

This may not an issue. Once overflow(large number) happens, it will stay 
in that state until there is another change. But we are only concerned 
about the delta. Delta is fine.

> 
>>
>> Also setting the RMID Unavailable permanently is not a good option. We should have a way to reset it. At some later point the RMID can become active and report the correct numbers.
> 
> I assume that when an RMID becomes active cannot be the trigger to reset it since user space cannot
> then be aware that a counter was not available for a while.

Yes. That is correct.

> 
>> I was thinking of introducing a new arch state(in arch_mbm_state) to handle this case. Need to investigate more on this. What do you think?
>>
> 
> Some new state is surely needed to reflect that the RMID's data may be wrong. It is not clear to
> me how you envision the reset of the state. If it is driven from user space then I expect that
> resctrl needs to be taught something about this and it cannot just be buried in arch code.
> 

Yes. We need to take a hard look at this.
-- 
- Babu Moger


