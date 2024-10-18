Return-Path: <linux-kernel+bounces-371909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE2E9A4213
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9E61C225D3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B11200CB1;
	Fri, 18 Oct 2024 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="foptl7tH"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D600C18C03B;
	Fri, 18 Oct 2024 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264441; cv=fail; b=Y3k/SwDL45YdS9N5T6tXIZD4L2jV8/Z1e2Ba01o0nmaLlJMzMwv4Ud4a91wzDQ4mW4lQJ0wL6A41BxGjgQaWsz9MMquzkubDigKcTSEj1p5ScZv5oaRYXBScS0NB9alPw9TGA06f6SKUcBaCdjLtVfJJUmXkwqWLQW2BkhLHgGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264441; c=relaxed/simple;
	bh=/48r5PrbdCbYw1f+K3geiiMnpLHUoJ9ZCMeXBc1yBdY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XKVi6vg2VFo9pC2oQtNlVnFWzUzIMx+V71Ye2EmH4lJHNxeflJSQ5s1z/rcnm6Xjf47l+YhaYag7Q4zXwG45GjGQ8E8IdpSmMxx3Vb37+XDj1PBU9MKrfvgDAKI+YgxuHTssWq40qNEDioUJ/N4EGrgyrHpgp9kCooWvqurT9N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=foptl7tH; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyNKc0PeCYd6T9HU9eTRohlQedBc/9t2HArhyaVyE247iUrtvQ5AkNnF6G694j2DXCqLtec0ocBrgs+8G5uhDmf/vv2Kjv2iUi9Aa72CF0zlZJdyiOyhliWpNWMNcqJBPr4+Y+WfrvuH1E3oM7R6aTdidH9PS3hYjIGMoEEifb9pin8wF7RiRobJygpnR6Swfl1v+KPxMzVnHOQR8WD1wtuFofuhUk4DxQOBKRUKPkL+7bpHallczXf42V9uie7EoYgQbdYjznJ37M81Tm2jQQ4WQKDPNgQExSkXpxHj8qdpy69WsyWC1ItpArL+9MngungO225DxFZGNSx3YH0KqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2cMZBtROS5M9TNrhJeN6Yx0h0J2P/eGzFVQDmXqFdA=;
 b=ywM6yEuEGOlSKZ2WcbdS6qqROwXzptoXkf+aVV2S7Z5z1QUegrr2/RW+K79w3GKXfs2eiASFuQ9WeZI7IBuwgc1O/RxHi06AUAzMxifsbo9hYrayU0xggE+TxYsgOOFIDYlauhIkUzZhoNrKv12d8isUV5bKQ4GvoUODfXKcnRp7w2ghfkWOXMBaF/hth872HZjXpiXHgKQ49wdgD+37DY+Lbln1EOeROCK//nZ1fBgFfOrIjFCBgljA5ZQIV3UwTpFC9+foKnBVwqVqaGwYlu+AMYRBcX04xl3CKKWNEBJNPkvOEjgbyGsxQRFMohgw+Pt2N83bVhGibXQAwi1mZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2cMZBtROS5M9TNrhJeN6Yx0h0J2P/eGzFVQDmXqFdA=;
 b=foptl7tHllN4uewvhhBBr3NqR6DfhJAcTkEiaR/NQrpePOAAq/liLcxm7Kx2cA1tS8mNzGh7nvuM16OckTkRK/OUxgzfNdftMgNkSrzniZIx5k/hD0gF49gRCjf/XTbBaqhrp52Rv/+AZj4EnFb8H8gH5yOp3JzUAX2C12/Y3sE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 15:13:55 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 15:13:55 +0000
Message-ID: <51b47b50-1b83-6565-e7da-14d4de0b15c8@amd.com>
Date: Fri, 18 Oct 2024 10:13:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 21/25] x86/resctrl: Introduce the interface to switch
 between monitor modes
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <d3d1238b58ba9d808a8094b2174a52df2fcc5e6d.1728495588.git.babu.moger@amd.com>
 <4d49182f-6185-49df-b9bf-29fbd17dccf6@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <4d49182f-6185-49df-b9bf-29fbd17dccf6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0136.namprd11.prod.outlook.com
 (2603:10b6:806:131::21) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 9712e1a0-5172-4206-2d90-08dcef877b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkpOVkNjVjNkZ1Zia3A3d09xdjY0N09jUVJFdDNJSXpmcndoeUtqQjZaUC9l?=
 =?utf-8?B?MmQ0UnI5WVhKUTFNcUVmRU9XR3grZi8zSldVck9jd2ExbHFMWURkdjB6U0wy?=
 =?utf-8?B?ZGdKRlhpL05Udzc5YkR2K3ZLbTUrYTR2czdXWi82SnlWc1ZPQ2FhV0o5TkVR?=
 =?utf-8?B?U1VNemJWSm53SUZxU2xudnU0YkxvV3ByV3ZZYWt1SWl6bjZrR3lRTnFsUURy?=
 =?utf-8?B?VCtkN2JXcEZCMkZwSXAyV2VyajZJV3JKL2JjQ0JLV1FYQUxnZnRsOVVMdjhC?=
 =?utf-8?B?SC83UlNxcG5xam5pNXBGQm9lTzJORHczcFhZVTluSUNEUEdleUNHcXdHK3RC?=
 =?utf-8?B?MFBMOXA2RmFWdzJGS1Y5UmFLY0hDT1ByK3J4NERlaXA4RXk2eFRNbHFJZ1pt?=
 =?utf-8?B?ZEJ1ZmU3ZCtPTWhsRlYySjNHZDJDMGhZV0VnNmozakNiT1J1cTcyRkpBRVI0?=
 =?utf-8?B?QWlYZDdMclQySnIvaHphZG8xcTVqSGN5NHpTcllXNXpUUk1pMnpHdmFKbTM5?=
 =?utf-8?B?dHh2U0xjQ1Z4R2Vnd3hTSi9Rb2krTG83ck5LUXlCMmV6TzkycnB3YUVXR0JX?=
 =?utf-8?B?dU1Cb3pHbEo4bE9iQ2h1OFMvNUhuejc1c0lxRWV3dWtMelIxWWt4NHplbnVK?=
 =?utf-8?B?WXdJdVR3czMwYmtUdHRYYkVNMHJaQ1pSMFRIN0dQc2xUelJwYzBzaHFZVSti?=
 =?utf-8?B?MW5TL1paVC9MZWZFQitTVk1Ddno1NHFiSEpUQkx2K3gyV2pZbW5hNE5KeStX?=
 =?utf-8?B?VW1aWEFjbWdLenFRdk83UE5COTFPbHVXdEhReHlETWJCWXhvS0FLQUZ6TkRs?=
 =?utf-8?B?aWdQUDhTYUYvR0dDQ0VRck54YVJWeFYvMzJiNnZsWHJhNU1PMGVoL2RKbTR6?=
 =?utf-8?B?dnJwemRaSXZoSk9CelNva3doMVBmVmRMdVVJYmlsMThCY2tnOVRJdmsySklB?=
 =?utf-8?B?YXVzVkloeUlJYmVwZ25YalNRa21XZ1BDK2o1eldIREl0T1Z4TjF0YTZ3dllF?=
 =?utf-8?B?YVBiL2xkOGZZbzl4QXJYVDdZc0dxclRVTlkvNktwamFYY1pUQjd5T25XV2E3?=
 =?utf-8?B?emFDaGVPZFcvNG1lQnZBQjFoRkZ2MHpyNENYS0dZZ2JNdEtTYVF6azJWQzJN?=
 =?utf-8?B?czh1ZFZnY25IMi9qZmdBK3lVbEZDYVVSRENlV05GMWZ4NlpseWtrZk9CYnYx?=
 =?utf-8?B?b2k4WlFRUWs3aFJvTXJJNTZLUlUxdDNZVVM2TVMrRXo3ellLRFlTeWdtenRC?=
 =?utf-8?B?aVRlQXg0MXI3L3g4N3MvVEl0RlR3TlJZcU12K3ZkSGpsNm14MlVUMmtvc0hw?=
 =?utf-8?B?Ky9pUkNub0ZNVERhTFBJV3hZRjNSc29pRWRQcjVyOUM1TUU5TVFVMzZYQkpP?=
 =?utf-8?B?MThsQ3lQM2s2ZDc2d3U1RmZPOXFiZVBoc0dxb3k3SHlMVE9JaFRXL1RuZnVP?=
 =?utf-8?B?MGFKbkRZQVpOMmJ0akJzSm83NXBIMGlBczBtcFExODVWT3JtVlk0a0ovYm93?=
 =?utf-8?B?V0F5enVHYytTM3dNU3lFRTE5MlpNNWk3SUw4ZitCUi9MN2Y2RTJtaGp5NlJh?=
 =?utf-8?B?VE1HdExJd0tJejBtVzBnb2xNaXR3eFlscHVCd2g1ZVZMdnNYK1hnT0hTOWdI?=
 =?utf-8?B?K1RCTk5IemFCT1dYMEMwTXIxV3V2cmZNalNkdStoOC9GYkJYcTM5SUpRb1Ji?=
 =?utf-8?B?dTlHNHRvOG9zdDlKd1lCZVNRdXFFWU5LYzF5WGthRzlNYXpuTytCTDNBMXNw?=
 =?utf-8?Q?U3ItxpEs9RVeurGGRB2RpIxP6oW4FdQRKkM3dve?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vk5oUjgyRGVFempyTktPVi94TDhFZU9LajJHRjFObExjRE9GMk5UZmpPdDFo?=
 =?utf-8?B?dHRIU0ZlYmF1ZGx3eXBwTHdXWUlyZk9Ob202MHpCZWd4Z2tnUUJNcDkrU0Zp?=
 =?utf-8?B?eTRTSkxidHJXVFZQWUpSTnlNdUF2YUdmcVR1dHU0R1NvY1VOTzF3cFQxcHJT?=
 =?utf-8?B?b1BQRllabVJYRFdRdVVUMHBDcHkvZFdGeC9lSU9qTUIwcmVpVGVBOGxzSUJ2?=
 =?utf-8?B?QnhEdGEvaFJpMVNuajNzSEEzNjN6eE1kNE9RZUtmdkV1WkZXeGZ1ZU54bm5C?=
 =?utf-8?B?UGFYSjc2YVFESmdteG42UzlHRHM0ME5uRTV0T3VhOVRmbE1PaHg2YzRwY0tv?=
 =?utf-8?B?d2c0SjdXZlBYcW9aVUhtWW54S0g0K3JoZkkwcEZ5VWo1U25ocUx4RXl0aDBs?=
 =?utf-8?B?MEsrS3I1ZncxUHdDL0NGQTFKRXQ3ZjUrNElWQm56WU91ZE0rRzFrRmhxcDVV?=
 =?utf-8?B?bkk5T3ZLWExpVWVjTFZ0VlcwdG1nU3FMSWFYOGNoOUx2NHYwTy9qTjFaT1lq?=
 =?utf-8?B?VU0zVmEvei84TEI2dlpMT0VMRWI4bkVXb1U1VWw2VVQwb1kzcEJ3YmpDRTdK?=
 =?utf-8?B?V2VzVE1yUWliVU5aUVhTdGt1V2t4dkNUOGRlRUx6VHNhTWsvSllPeEIxS29B?=
 =?utf-8?B?bHQ4U2t1cGNsVkx4Z1pKTElrUWo4MGtCaE92emR6cVFUN0xaS1UramxvMUlF?=
 =?utf-8?B?NTl5NHhZd09Zam5CbHdocWsveEhyOEtGd2pBL2hYbkY2dEpqVERWSCs3Uisr?=
 =?utf-8?B?VWtUWHB4Y1BMOE5PWjArQVA3aWlEWXM5Q3l0djM4ODFCendZMWFHSGJXcGFm?=
 =?utf-8?B?N3RvTzhGdFlYNEc3VHdPVUw2eXVkK0kvOVB5V1plM0dzQVFuT3VzcVFQTW1K?=
 =?utf-8?B?a2d3dEwxN3c5Ykx4ZUNPOURQVHVzbllZYkp1MEo5UGZkT3ZLUUxscUNYSVU0?=
 =?utf-8?B?QVZtcTZ5Z0dLVmY0TEZBc1l4SVRsMTBOZ25MMExiKytPMlV1M0VvL3pKTmFF?=
 =?utf-8?B?NTNuZkd1RFFWZnprNVR1SVAwbURBUXY3QTA4MFJpWTQ5SkRWMWgzUjIwTC9Q?=
 =?utf-8?B?TGRIOG1EdkxPb1VoS0VPcXZFQjQ5NDJNaCtkVlRtR3FKbFliYjdwT0NwM0pU?=
 =?utf-8?B?WUZNdXRwb0hqYnVJOXpWd2xNOFQ0bEh2SFZqaS9VRE5iWUhodkxrbXlkQWRq?=
 =?utf-8?B?TTNROENZZURIZGE3UjJ2a0xGZGxjT0hNNEMyaUY1R3RJcGlsZVpsSm52UUNH?=
 =?utf-8?B?RTZMTjdJemxiRTk4dHBKZkpzR1VLWDdoTWw2Um1OSTZLRmJvNXNWeU1vRDhF?=
 =?utf-8?B?NHJvRUJSVEpnbzI1OEkzeFZyZ1htd2pLRXRKcHhNNmwydGNIQktpZ0ttNGlj?=
 =?utf-8?B?S2lpWExSMCtVRzl2aTFKS0dpWEo3TTFlckhDTGkvanR0dDM1OS9pUU1rMnV3?=
 =?utf-8?B?T1labTRFM0tmMUlVNm9yZ2RFeDZJS0FhcUlBVzVnMHc0Y1ZyNFdORFRqamRm?=
 =?utf-8?B?dHpuUXM1ZTNOSzNqa2tGWmJiMzZFZ2NnelNjbDZaWm83UVRNUDg2TVVtL3Vk?=
 =?utf-8?B?Z1FlMXo3MzVkS3NOMjZSQmQzRFBDMXRLTDVaMTJPbXloS1hKOE5qejkraGdD?=
 =?utf-8?B?NmVwU0pxY3JKVDJHS3pzUlk5QzZ1YU40UytJd0V2NlorVGNlTTUrUTdtZVRL?=
 =?utf-8?B?SDZYUnlVK0xPZkx4UUpmZGpVaE8zY2FGM25iazJZaU14R2pKQk1pZEQyZVdN?=
 =?utf-8?B?OVA1aHd3U2FseUlQR3ZPMURzdzNIS2ZocWpCcCt4djcxS29PbWxFQ3BtM3Ju?=
 =?utf-8?B?WUdGYlJSNzNWZFFvWlZCL1lwRTIwL2dlVFlRM2FjVUVwRko2UjE5SytmUG01?=
 =?utf-8?B?dVljMXJNNFljRHFYdEtlaW9NeUE2TFh0bnVCSWwrWEtSRzIyUGNyTS9tU0Zx?=
 =?utf-8?B?VWFMajViS1Q3V0dtRkF5OExDVHNFQzNUcmUzOWh4OTUvVjZRUFoxQmJLb3dE?=
 =?utf-8?B?TTRKK0JuWERlUU5LZHpqSkJrL3Zvb2s5M3lCRUpvT0JBWHdmalFWaHFTSXpv?=
 =?utf-8?B?SmlXOUw1a05pOFR0SklVa0wrK0VaWDdoOUxHNTBzZWd5MlVCRDBiSjZQUXFr?=
 =?utf-8?Q?w0y8A2noTH/GhsYYU8SDGHydR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9712e1a0-5172-4206-2d90-08dcef877b6f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 15:13:55.1999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpzKrQu0mcplKBeVWb8pTaW7WwGede6b81389P7TP1uUEtzqYU/7FeoQutdlmyyC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416

Hi Reinette,

On 10/15/2024 10:36 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/9/24 10:39 AM, Babu Moger wrote:
>> Introduce interface to switch between mbm_cntr_assign and default modes.
>>
>> $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> [mbm_cntr_assign]
>> default
>>
>> To enable the "mbm_cntr_assign" mode:
>> $ echo "mbm_cntr_assign" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>
>> To enable the default monitoring mode:
>> $ echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>
>> MBM event counters will reset when mbm_assign_mode is changed.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>   Documentation/arch/x86/resctrl.rst     | 15 ++++++
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 75 +++++++++++++++++++++++++-
>>   2 files changed, 89 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index 99ee9c87952b..d9574078f735 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -291,6 +291,21 @@ with the following files:
>>   	that case reading the mbm_total_bytes and mbm_local_bytes may report
>>   	'Unavailable' if there is no counter associated with that group.
>>   
>> +	* To enable "mbm_cntr_assign" mode:
>> +	  ::
>> +
>> +	    # echo  "mbm_cntr_assign" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> 
> extra spaces

Sure.

> 
>> +
>> +	* To enable default monitoring mode:
>> +	  ::
>> +
>> +	    # echo  "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> 
> extra spaces

Sure


>> +
>> +	The MBM events (mbm_total_bytes and/or mbm_local_bytes) associated counters
> 
> I did ask you not to copy the text verbatim
> https://lore.kernel.org/all/b38c93bf-4650-45d1-9aca-8b4c4d425886@intel.com/

Outch Yea.

The MBM events (mbm_total_bytes and/or mbm_local_bytes) associated with
counters may reset when mbm_assign_mode is changed.

> 
>> +	may reset when the mode is changed. Moving to mbm_cntr_assign mode will
>> +	require users to assign the counters to the events. Otherwise, the MBM
> 
> "will require" -> "require"
> 
>> +	event counters will return "Unassigned" when read.
>> +
>>   "num_mbm_cntrs":
>>   	The number of monitoring counters available for assignment when the
>>   	architecture supports mbm_cntr_assign mode.
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index cb2c60c0319e..88eda3cf5c82 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -888,6 +888,78 @@ static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
>>   	return 0;
>>   }
>>   
>> +static void mbm_cntr_reset(struct rdt_resource *r)
>> +{
>> +	struct rdtgroup *prgrp, *crgrp;
>> +	struct rdt_mon_domain *dom;
>> +
>> +	/*
>> +	 * Hardware counters will reset after switching the monitor mode.
>> +	 * Reset the architectural state so that reading of hardware
>> +	 * counter is not considered as an overflow in the next update.
>> +	 * Also reset the domain counter bitmap.
>> +	 */
>> +	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>> +		bitmap_zero(dom->mbm_cntr_map, r->mon.num_mbm_cntrs);
>> +		resctrl_arch_reset_rmid_all(r, dom);
>> +	}
>> +
>> +	/* Reset global MBM counter map */
>> +	bitmap_fill(r->mon.mbm_cntr_free_map, r->mon.num_mbm_cntrs);
>> +
>> +	/* Reset the cntr_id's for all the monitor groups */
>> +	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
>> +		prgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
>> +		prgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
>> +		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list,
>> +				    mon.crdtgrp_list) {
>> +			crgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
>> +			crgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
>> +		}
> 
> Please use MBM_EVENT_ARRAY_INDEX

Sure.

> 
>> +	}
>> +}
>> +
>> +static ssize_t rdtgroup_mbm_assign_mode_write(struct kernfs_open_file *of,
>> +					      char *buf, size_t nbytes, loff_t off)
>> +{
>> +	struct rdt_resource *r = of->kn->parent->priv;
>> +	int ret = 0;
>> +	bool enable;
>> +
>> +	/* Valid input requires a trailing newline */
>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>> +		return -EINVAL;
>> +
>> +	buf[nbytes - 1] = '\0';
>> +
>> +	cpus_read_lock();
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	rdt_last_cmd_clear();
>> +
>> +	if (!strcmp(buf, "default")) {
>> +		enable = 0;
>> +	} else if (!strcmp(buf, "mbm_cntr_assign")) {
>> +		enable = 1;
>> +	} else {
>> +		ret = -EINVAL;
>> +		rdt_last_cmd_puts("Unsupported assign mode\n");
>> +		goto write_exit;
>> +	}
> 
> Please keep two things in mind:
> * this file is always accessible, whether platform supports assignable
>    counters or not.
> * this is resctrl fs code.
> 
> So, considering above, how should user interpret the "Unsupported assign mode"?
> Shouldn't it also return this error if a user attempts to enable
> "mbm_cntr_assign" on a platform that does not support this mode?
> 
>> +
>> +	if (enable != resctrl_arch_mbm_cntr_assign_enabled(r)) {
> 
> resctrl_arch_mbm_cntr_assign_enabled() returns true if mbm_cntr_assign
> mode is enabled, but when it returns false it could mean different things:
> platform supports mbm_cntr_assign mode, but it is disabled, or platform
> does not support mbm_cntr_assign mode.
> 
> resctrl fs should not rely on all archs to duplicate the all the checking done
> in resctrl_arch_mbm_cntr_assign_set(). It should never ask arch to enable a mode
> that it knows the platform is not capable of.

Agree. This should take care of it. Good catch.


  if (!strcmp(buf, "default")) {
             enable = 0;
  } else if (!strcmp(buf, "mbm_cntr_assign")) {
          if (r->mon.mbm_cntr_assignable) {
                  enable = 1;
           } else {
            ret = -EINVAL;
            rdt_last_cmd_puts("mbm_cntr_assign mode is not supported\n");
            goto write_exit;
           }
  } else {
         ret = -EINVAL;
         rdt_last_cmd_puts("Unsupported assign mode\n");
         goto write_exit;
  }


> 
>> +		ret = resctrl_arch_mbm_cntr_assign_set(r, enable);
>> +		if (!ret)
>> +			mbm_cntr_reset(r);
>> +	}
>> +
>> +write_exit:
>> +	mutex_unlock(&rdtgroup_mutex);
>> +	cpus_read_unlock();
>> +
>> +	return ret ?: nbytes;
>> +}
>> +
>>   static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
>>   				       struct seq_file *s, void *v)
>>   {
>> @@ -2115,9 +2187,10 @@ static struct rftype res_common_files[] = {
>>   	},
>>   	{
>>   		.name		= "mbm_assign_mode",
>> -		.mode		= 0444,
>> +		.mode		= 0644,
>>   		.kf_ops		= &rdtgroup_kf_single_ops,
>>   		.seq_show	= rdtgroup_mbm_assign_mode_show,
>> +		.write		= rdtgroup_mbm_assign_mode_write,
>>   		.fflags		= RFTYPE_MON_INFO,
>>   	},
>>   	{
> 
> Reinette
> 
> 

-- 
- Babu Moger

