Return-Path: <linux-kernel+bounces-515510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAE9A365BD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5823AA5B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2411118A6B2;
	Fri, 14 Feb 2025 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qd29/G41"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783D42753FB;
	Fri, 14 Feb 2025 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739557873; cv=fail; b=Pqm4wGMHtPgVZEAGPI5DRvCs6RXwjOrf2hBmD8w8hlwjm4eMZxfZIlZv6skiJHLMReLidSEwiqqSsnwTOEq07gv785rXv91sWvKO72XWsmXGtWddRAEKgyZOz1GpFdq82wsNU5hky2dCyJJRYRxMxD/qXrDufhp+v5wiR8Tz+P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739557873; c=relaxed/simple;
	bh=Bm0wik9kVi+2DIZIKdXdoxqQwNJ8wbn/RedWhYQ9Rbc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mfIoWPbdMEROw5kBn9Y8Hf02xHEkXjzPQ0pCnaBJdeODCCw3P1iQYNI6a95+K0GHXDfHoEiCZALjhlTinHWvtX+Zab2/oV1eDKhenOMlyphtGlP5H5YSSv4ky6zwVRsAemZ0jZ1rpymgLbDeotAB+9jApOOVk9TF6R3H+CE2we8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qd29/G41; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3wUbtfAUyp3Wyk871/SuVXY16BdkuGkOjIF/ELwO6SYmTCMyoi6EMATx61glgXNVS+b1et64vzJSsyaVyBFoSWx4zVVJhfVZau3YThzdcX+rCQu4MwFG36LZrqvrPZKRXZuHcTuoSBfFBRLuSi92E2sbPX/vt9kgblAwAzqHX3NELMoCc/0Bqj2OJKGv0nL5lOwmXf2vl0CShuwL9MF1d72iabb+HMuaegUxnNKNcC4pVAJ2w49JYi77VIxMojn5/jqidJ7ocLbSROAvYpmfd+yv82CiRZjOI9ngY+bTeO3HjYYo+EEu+G5NA4wHK4Zi66Un5NspLp534jP260yFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I59s4BUmAaqEGLyh8EV6UYneoaYg5NyOViZK63fxnPg=;
 b=QfYH0mkxOw61QfFv+r+qEfKwqleuOl5EbiEVhVieRMRXSQRHZo1rkhltwPxifuzLNszIS5WqXJ5mCwjRpsHWWxpFtXzsm2ymcx6EqnmwV/2EK76clIzIYp1RnoZcA+Z1jcwwv309FjbTMmYbGA9WtEJkFlw9KMt1BteL53Px0QuNMY71OWS46uF+6piR+j3k1v3iT+t8iyit+Fa2NPUzq3WGCk2Z6L1HjpHUhCl4iuRrsUMRTgtbvaeJ+x3v3zSiwLB8QjBZlCLpW3lLYv2MhrUhGWRwjR8UvfqeXDcLfn9dXv8GI2QNCdZGEr9wZf10mz16wPaRx9Xwk2+EJn4BBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I59s4BUmAaqEGLyh8EV6UYneoaYg5NyOViZK63fxnPg=;
 b=qd29/G4182Q6q6A4sAC3Q8pjsbvI8J5vSFPef8rGP/jVdxzHhfGB1dmDNGxp6ZKnY354aWBlpEsBykjYgFhE0XVvxhMVXBXOhz8rR/EvwWXS9kYYTKjVbQ4u9xjzz0AigLopPypk6eHB7DQjdDqPT6oRaEWNCAKYMjtITkfcqz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH8PR12MB6721.namprd12.prod.outlook.com (2603:10b6:510:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 18:31:06 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 18:31:05 +0000
Message-ID: <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
Date: Fri, 14 Feb 2025 12:31:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>
Cc: Babu Moger <babu.moger@amd.com>, peternewman@google.com, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, tony.luck@intel.com, fenghua.yu@intel.com,
 x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
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
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::34) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH8PR12MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a5b979-3ae3-46e8-6fe8-08dd4d25bdf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjI5b0lZeXJVZUs3aysrVFYwd2RIZjdKQjIzdmNQSDJTbVE4eGJBUzlhd2Iz?=
 =?utf-8?B?SnVZbHZoTVlYRjFhbTd5NTkzdVpnQThzSW90Q3JpbjlzNmEwcWdLVFB1Y0ZW?=
 =?utf-8?B?WlRuZFoxd3A2WmlRWVZKYm55QWVzaW5wQ0Z6a0tWbjlHTVpXNSsra2JIWXYz?=
 =?utf-8?B?OEp0UEhzcjZib2RleDNmcnhwcVkxY1NvVnFpejllNXFwNk5BT1p2eitFZExy?=
 =?utf-8?B?Q1JxVEI3TGN6MmJ1SUpaeTNaazY3ckQ1ZW9HaVhiNEVoSWhka1gyL013aWow?=
 =?utf-8?B?NE42OVNFSkZ3WGJqRmJlM3A3a21QTFRMbElMbStmWkZHdXBFRVRPSnM2SnJJ?=
 =?utf-8?B?cjNQcFdvZUZNZ2xZSkxrRnV5TU5MdkdMbERYRlJhZy9BYWo4UTZ3cEpIbGZB?=
 =?utf-8?B?K2Z3L0hvZ1VrQ3RaVGFIUE55Z1JDWWVWR0lJOENjMWdzK0JNM280Z3JHdDBh?=
 =?utf-8?B?dW5WK1haRDNSWmVMZ0hqYjlEdVpsZUhocXc1aDJlMHViRnZhT2g5NkFXa3hU?=
 =?utf-8?B?eldkK3AwamJXQjgzMERldDdkSjNNVk85bWE2RVVTanBDK094YlgyNC9yZEtx?=
 =?utf-8?B?TnhLMUxiTzhUeXpQUmlDdUd5WlJoU3hYK0lWNGExV2tpMHVlSVRrL0ZwMGNO?=
 =?utf-8?B?M3BFVUdnTjVOTVUwUHFsNTJzdlNOZDlyYkdHeFZFT0E4MjZnejJiSUIrN1hD?=
 =?utf-8?B?YkI3TGdiM0ZCelJVeDZaVHU3Sk5Qa0JTMGdpNy90R2N5ZFRVSVBJaHJGRVVu?=
 =?utf-8?B?dVZCNUFOVy94aUNJdVhzSlZDMnpLRGZCWWRSS1RSWGVoSnM5RG9INGtIMFZE?=
 =?utf-8?B?MjFReWpKZko1eE9MKzJWTGc5QVF4OVpLS0hHRkZlOTBEQjhidTJ4cHZuQkt4?=
 =?utf-8?B?Nnc4MXJPMHNTQ0lNeENHQ25ONGEzZGRvWnk4UWZvdVJ3c2gvSExFL1BoUVcz?=
 =?utf-8?B?N2QvajNOSU5pcXY2Sy9ZYi9KSzRjSGVWMzJNSUFmNXQzSElMbDk2NkZRc0xU?=
 =?utf-8?B?NzVGcUZLdTJOL3VGTTJwVmF2UXhXT2swZzYrNDBZekl3MjAyc0RMNUdCRTFQ?=
 =?utf-8?B?TzVla1BOdmJwMVpSZlBHQTlmcXZPdjV6dHRqZGNDVkl2R2htT2dYdWg1czdK?=
 =?utf-8?B?TytOYUtGcWk4bmNOKzFKVWRIcFJ4RXZJdy9ueWYxbFFvaE44UWY5b25zU1FW?=
 =?utf-8?B?TzM2dU1CaE1aL0pYdnlmbjBkd2x0Unk2czh4cENWdlE4Y3k3WGZZL1RuNVNP?=
 =?utf-8?B?eGpVZGZZOERFWnZCdysxTVhIeFpFL29taVlpODhhMUR2MjhXRTRFa2dNeGk5?=
 =?utf-8?B?UXNsdzY2SFhmWlBlcFJwWmtVeGJUbkJ2UFFORUw1bmg4eit3NkxaZVBZeTVt?=
 =?utf-8?B?aERVb0R3NENwOGpSUWpGbFk2ZFV4MDU0ZCttZ2U3TERXc1Q1eDNBK3Jia0tH?=
 =?utf-8?B?MjhwcnJHVExnWWN2b0h6K0hoaVk1dXZNcVEyV0NjMTZGZVdDMU5Dc2o3dlJG?=
 =?utf-8?B?a2l2VFN2eEJUM2grNS8zMkJ4U2tEWFhWREJTRW8rNkpTaDA5Q2xkcUFmYUM0?=
 =?utf-8?B?aTlpb1hVYjZYYVFqdURaWG1KZGc5VzM0NW50L1k1UW1XNkpoL2dMOUNjbFBt?=
 =?utf-8?B?VW1yUzBWd0g1d3c3d1JXbHAvYjJPTHc4Q2pLaXhtLzltY1Y2LzUzU0hMNkQy?=
 =?utf-8?B?amxBT0h4ejRkVDNJVk9KR3RBMk5DbHZiMG1xcU1vMXMzUjlTMjh1QU1MUi9Q?=
 =?utf-8?B?M0s1TEhhdVNLbFRqWTVSRnBrUTB1WmRVMEVpYU9kSlVCVFRYYW9NWWd4anJ5?=
 =?utf-8?B?cHcrUmlBbm9BM09BY0lJdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3hON3RlYmZiZjByeXU5Y0NQSHNNRmxCUzNyK1k3LzBhRVRsT0I4VWgxVXJ4?=
 =?utf-8?B?U2hVNzBjTXdQRllTNFZtVTduZlI4TDVkL2lwMTZBVUZpSmkwZUJKWTRCYjEy?=
 =?utf-8?B?aXJaNC9hSXVPZlpUOHJycE1rRkZDeDVhQkJtSVloVlRmejJKUTl3WUJOMGJX?=
 =?utf-8?B?Q2FYekYyUStMNFI5Wm5BaUNTZUduOVg0YlVzN3VweEFEWVN1Y2gzYzhlTng1?=
 =?utf-8?B?QjgvekNzUVNSbkluNnlZcm41Z0s1c0kvZWRtVXpMY0U2bjdWL3duYzN1cWtt?=
 =?utf-8?B?SUZ5SCtMT3BDMlJBMEF0RXEyQTJEdTRIK00rYUxTRitndzA5TmljNXorc0RB?=
 =?utf-8?B?RFE4Qm4zN3d4UWMzNzVyME1BVmdObGpVZWJKeU1SUGZ0TVltVlNuQ0IxQXU5?=
 =?utf-8?B?cmU2a1QyZ3QzQ1AxV0VrNllTelVQejErTmx4OE5QYTVXK3B5TjRsMUI2ZXhU?=
 =?utf-8?B?RzJQYWdvWDdvZmRmSDlGeTh3SHFBYXZCa1ExV3dEVXBkVnhBaTlhWHZRS0c4?=
 =?utf-8?B?TS9EUUZiekxGQjArNFUwdGtTWEIzNG5reWp5ZmV4SzdiaTNmU0hSUzFTRFZM?=
 =?utf-8?B?SjVibXlaNjNlWWlMYUVyRkRwckdBUHk1Zjk5Q01FMDVjeHRySEwzZ0FJZnlj?=
 =?utf-8?B?c2FmazI5Wis3eEpTc3BJdUIwTGM0QkxmWEhINEQ0RUhScnh6dFFwdklDcHJU?=
 =?utf-8?B?SmJVWHM1RXhoaWNkRDVicmsyTnJjazhiWkJBV3lkL3N0b2E3N3FPdk5OUXRC?=
 =?utf-8?B?cWJIWS93OUhTMGd6ejMzZWt5ckttWDcydjVlYi9TSmVLd1pWSUErQlVoZkcr?=
 =?utf-8?B?SEsreE1nZTZZQWdaNjAzWXF2NE01Mmp3RW0xTEIxTmhpSzVjNXVYMXpFM2U1?=
 =?utf-8?B?ajZGcjZwWUZLa011ZDZTTnFQR2lrdzQzQ21lbjZmc3h1ZVA3ZlBrVTZKZ0R5?=
 =?utf-8?B?UUt1dWVEL0RCVjVCSWFvUTNFamVEdkczTlhvSEtqbVVJZjhzTDhMcUNYSDAx?=
 =?utf-8?B?V3JzNUxxR3NiQTBzUllxaEVhSzQyN2J6d204NVFMWkthZEpmcWpMVEoveXNK?=
 =?utf-8?B?Wi9uVFVSZWpreG9aVlhhcWhXdHl5TWRWMFMvUGszcVhVcGFnZnRrRkpRc3Rq?=
 =?utf-8?B?ZHA0UFk1T2huenFNSmg1QTh3L2hKMXZGa2NNVTFwMmgyeTVQaEl3SmpjblZr?=
 =?utf-8?B?akpjcGhBMW9OTllnVktjendVRVFpSlovWlM5VTVvQ1krSXhqa1dKYXpCOS9P?=
 =?utf-8?B?YlBzNytaa2g1UzBKRjBUMmRYUEhsQ1cwajBUNzlOU3BBc2VuMEt6MEFYZkxY?=
 =?utf-8?B?REF5NEt2bk83UmZ1c0crNFpEc2ZXNktpWlNhY1d1bi9la3hoTVFHaXFpZSt6?=
 =?utf-8?B?R0hObkNzVzIxTGNqNWoyYzNCb1BiUllMZTdQZkpmeDdaa3pjdFpUdlNUVUE5?=
 =?utf-8?B?Vng3QkQySDhCQlVtV3NVbFZxSXZLMUtndWhtTENKNHZieCs1L2djK3RLR3BT?=
 =?utf-8?B?ZG1SNFhCaG90eW9KYmdhbDE0VVRTRFA3WDBFRnljKzhyU2hWOUJRT3hUenBT?=
 =?utf-8?B?Y3Rja2xlR005Ny9Pa0dXbnpCbW9NMVlNMnNIZmV4Rm9RWG5uRWdMWFk2ODZr?=
 =?utf-8?B?cUJETitqOWNndDFKSFp1eVlrSklweUlSVFI2aEdIeFVXZ1hROTdLNTJjUVFr?=
 =?utf-8?B?QUo3bnQ0RHJ1VWtxc2pLUGFuN3lPeW8rZ284amR6U1F5Zjd2cGxjQTVUYWtk?=
 =?utf-8?B?d0N4NXcvS2g3R284UUZMdFlQVTRDKzRKQUNEY0N6dllGUktLS3Y3WGE0UzNW?=
 =?utf-8?B?bWRUenB0elRvak9FbGttNXFralp2SU1NdTF0V0RxRWRGMXZvUjBLblpjN2dL?=
 =?utf-8?B?NFp3YkVndktWWlJianhpOWwxazhUQkpHZXAwVjlEUGdSR3V4ckVKb2RXOW5q?=
 =?utf-8?B?b09VNUJyaEV0eDZKcWhmYWkvdUpqdWw3TXN0R0o5dnA5RTRRbklsVG02T2Q1?=
 =?utf-8?B?MzhJLzhhc2hwMFowY2VabmthR0c2b2l3R1ZaQnV0eEZGSzJ3a0J5aXVCYWZa?=
 =?utf-8?B?VHpsYmJKaktPaHR4K0lJRlBybkxLWGVDZ3JPKytvTXJzK2dhRURGK0pHZ2RO?=
 =?utf-8?Q?HKsc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a5b979-3ae3-46e8-6fe8-08dd4d25bdf5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 18:31:05.7641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCwmu/E8MnkJEKcHLQ16BMguG95n3J54tczyDg5tBZiSnZE0yrxdE4n0/9uAJ69w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6721

Hi Dave/Reinette,

On 2/14/2025 12:26 AM, Reinette Chatre wrote:
> Hi Dave,
> 
> On 2/13/25 9:37 AM, Dave Martin wrote:
>> Hi Reinette,
>>
>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
>>> Hi Dave,
>>>
>>> On 2/12/25 9:46 AM, Dave Martin wrote:
>>>> Hi there,
>>>>
>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
>>>>>
>>>>> This series adds the support for Assignable Bandwidth Monitoring Counters
>>>>> (ABMC). It is also called QoS RMID Pinning feature
>>>>>
>>>>> Series is written such that it is easier to support other assignable
>>>>> features supported from different vendors.
>>>>>
>>>>> The feature details are documented in the  APM listed below [1].
>>>>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>>>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>>>>> Monitoring (ABMC). The documentation is available at
>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>>>>
>>>>> The patches are based on top of commit
>>>>> d361b84d51bfe (tip/master) Merge branch into tip/master: 'x86/tdx'
>>
>> [...]
>>
>>>>> b. Check how many ABMC counters are available.
>>>>>
>>>>> 	# cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
>>>>> 	32
>>>>
>>>> Is this file needed?
>>>>
>>>> With MPAM, it is more difficult to promise that the same number of
>>>> counters will be available everywhere.
>>>>
>>>> Rather than lie, or report a "safe" value here that may waste some
>>>> counters, can we just allow the number of counters to be be discovered
>>>> per domain via available_mbm_cntrs?
>>>
>>> This sounds reasonable to me. I think us having trouble with the
>>> user documentation of this file so late in development should also have been
>>> a sign to rethink its value.
>>>
>>> For a user to discover the number of counters supported via available_mbm_cntrs
>>> would require the file's contents to be captured right after mount. Since we've
>>> had scenarios where new userspace needs to discover an up-and-running system's
>>> configuration this may not be possible. I thus wonder instead of removing
>>> num_mbm_cntrs, it could be modified to return the per-domain supported counters
>>> instead of a single value?
>>
>> Is it actually useful to be able to discover the number of counters
>> that exist?  A counter that exists but is not available cannot be used,
>> so perhaps it is not useful to know about it in the first place.
> 
> An alternative perspective of what "available" means is "how many counters
> could I possibly get to do this new monitoring task". A user may be willing
> to re-assign counters if the new monitoring task is important. Knowing
> how many counters are already free and available for assignment would be
> easy from available_mbm_cntrs but to get an idea of how many counters
> could be re-assigned to help out with the new task would require
> some intricate parsing of mbm_assign_control.
> 
> 
>> But if we keep this file but make it report the number of counters for
>> each domain (similarly to mbm_available_cntrs), then I think the MPAM
>> driver should be able to work with that.
>>
>>>> num_closids and num_rmids are already problematic for MPAM, so it would
>>>> be good to avoid any more parameters of this sort from being reported
>>>> to userspace unless there is a clear understanding of why they are
>>>> needed.
>>>
>>> Yes. Appreciate your help in identifying what could be problematic for MPAM.
>>
>> For clarity: this is a background issue, mostly orthogonal to this
>> series.
>>
>> If this series is merged as-is, with a global per-resource
>> num_mbm_cntrs property, then this not really worse than the current
>> situation -- it's just a bit annoying from the MPAM perspective.
>>
>>
>> In a nutshell, the num_closids / num_rmids parameters seem to expose
>> RDT-specific hardware semantics to userspace, implying a specific
>> allocation model for control group and monitoring group identifiers.
>>
>> The guarantees that userspace is entitled to asssume when resctrl
>> reports particular values do not seem to be well described and are hard
>> to map onto the nearest-equivalent MPAM implementation.  A combination
>> of control and monitoring groups that can be created on x86 may not be
>> creatable on MPAM, even when the number of supportable control and
>> monitoring partitions is the same.
> 
> I understand. This interface was created almost a decade ago. It would have been
> wonderful if the user interface could have been created with a clear vision
> of all the use cases it would end up needing to support. I am trying to be
> very careful with this new user interface as I try to consider all the things I
> learned while working on resctrl. All help get this new interface right is
> greatly appreciated.
> 
> Since your specifically mention issues that MPAM has with num_rmids, please
> note that we have been trying (see [1], but maybe start reading thread at [2])
> to find ways to make this work with MPAM but no word from MPAM side.
> I see that you were not cc'd on the discussion so this is not a criticism of
> you personally but I would like to highlight that we do try to make things
> work well for MPAM but so far this work seems ignored, yet critisized
> for not being done. I expect the more use cases are thrown at an interface
> as it is developed the better it would get and I would gladly work with MPAM
> folks to improve things.
> 
>> Even with the ABMC series, we may still be constrained on what we can
>> report for num_rmids: we can't know in advance whether or not the user
>> is going to use mbm_cntr_assign mode -- if not, we can't promise to
>> create more monitoring groups than the number of counters in the
>> hardware.
> 
> It is the architecture that decides which modes are supported and
> which is default.
> 
>> It seems natural for the counts reported by "available_mbm_cntrs" to
>> change dynamically when the ABMC assignment mode is changed, but I
>> think userspace are likely to expect the global "num_rmids" parameters
>> to be fixed for the lifetime of the resctrl mount (and possibly fixed
>> for all time on a given hardware platform -- at least, modulo CDP).
>>
>>
>> I think it might be possible to tighten up the docmentation of
>> num_closids in particular in a way that doesn't conflict with x86 and
>> may make it easier for MPAM to fit in with, but that feels like a
>> separate conversation.
>>
>> None of this should be considered a blocker for this series, either way.
>>
>>>>
>>>> Reporting number of counters per monitoring domain is a more natural
>>>> fit for MPAM, as below:
>>>>
>>>>> c. Check how many ABMC counters are available in each domain.
>>>>>
>>>>> 	# cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs
>>>>> 	0=30;1=30
>>>>
>>>> For MPAM, this seems supportable.  Each monitoring domain will have
>>>> some counters, and a well-defined number of them will be available for
>>>> allocation at any one time.
>>
>> [...]
>>
>>>>> e. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>
>> [...]
>>
>>>>>         Flags can be one of the following:
>>>>>
>>>>>          t  MBM total event is enabled.
>>>>>          l  MBM local event is enabled.
>>>>>          tl Both total and local MBM events are enabled.
>>>>>          _  None of the MBM events are enabled
>>>>>
>>>>> 	Examples:
>>>>
>>>> [...]
>>>>
>>>> I think that this basically works for MPAM.
>>>>
>>>> The local/total distinction doesn't map in a consistent way onto MPAM,
>>>> but this problem is not specific to ABMC.  It feels sensible for ABMC
>>>> to be built around the same concepts that resctrl already has elsewhere
>>>> in the interface.  MPAM will do its best to fit (as already).
>>>>
>>>> Regarding Peter's use case of assiging multiple counters to a
>>>> monitoring group [1], I feel that it's probably good enough to make
>>>> sure that the ABMC interface can be extended in future in a backwards
>>>> compatible way so as to support this, without trying to support it
>>>> immediately.
>>>>
>>>> [1] https://lore.kernel.org/lkml/CALPaoCjY-3f2tWvBjuaQPfoPhxveWxxCxHqQMn4BEaeBXBa0bA@mail.gmail.com/
>>>>
>>>
>>> I do not think that resctrl's current support of the mbm_total_bytes and
>>> mbm_local_bytes should be considered as the "only" two available "slots"
>>> into which all possible events should be forced into. "mon_features" exists
>>> to guide user space to which events are supported and as I see it new events
>>> can be listed here to inform user space of their availability, with their
>>> associated event files available in the resource groups.
>>
>> That's fair.  I wasn't currently sure how (or if) the set of countable
>> events was expected to grow / evolve via this route.
>>
>> Either way, I think this confirms that there is at least one viable way
>> to enable more counters for a single control group, on top of this
>> series.
>>
>> (If there is more than one way, that seems fine?)
>>
>>>>
>>>> For example, if we added new generic "letters" -- say, "0" to "9",
>>>> combined with new counter files in resctrlfs, that feels like a
>>>> possible approach.  ABMC (as in this series) should just reject such
>>>> such assignments, and the new counter files wouldn't exist.
>>>>
>>>> Availability of this feature could also be reported as a distinct mode
>>>> in mbm_assign_mode, say "mbm_cntr_generic", or whatever.
>>>>
>>>>
>>>> A _sketch_ of this follows.  This is NOT a proposal -- the key
>>>> question is whether we are confident that we can extend the interface
>>>> in this way in the future without breaking anything.
>>>>
>>>> If "yes", then the ABMC interface (as proposed by this series) works as
>>>> a foundation to build on.
>>>>
>>>> --8<--
>>>>
>>>> [artists's impression]
>>>>
>>>> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>>>   	mbm_cntr_generic
>>>>   	[mbm_cntr_assign]
>>>>   	default
>>>>
>>>> # echo mbm_cntr_generic >/sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>>> # echo '//0=01;1=23' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>> # echo t >/sys/fs/resctrl/info/L3_MON/mbm_counter0_bytes_type
>>>> # echo l >/sys/fs/resctrl/info/L3_MON/mbm_counter1_bytes_type
>>>> # echo t >/sys/fs/resctrl/info/L3_MON/mbm_counter2_bytes_type
>>>> # echo l >/sys/fs/resctrl/info/L3_MON/mbm_counter3_bytes_type
>>>>
>>>> ...
>>>>
>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_counter1_bytes
>>>>
>>>> etc.
>>>>
>>>
>>> It is not clear to me what additional features such an interface enables. It
>>> also looks like user space will need to track and manage counter IDs?
>>
>> My idea was that for these generic counters, new files could be exposed
>> to configure what they actually count (the ..._type files shown above;
>> or possibly via the ..._config files that already exist).
>>
>> The "IDs" were inteded as abstract; the number only relates the
>> assignments in mbm_assign_control to the files created elsewhere.  This
>> wouldn't be related to IDs assigned by the hardware.
> 
> I see. Yes, this sounds related to and a generalization of the AMD
> configurable event feature.
> 
>>
>> If there are multiple resctrl users then using numeric IDs might be
>> problematic; though if we go eventually in the direction of making
>> resctrlfs multi-mountable then each mount could have its own namespace.
> 
> I am not aware of "multi-mountable" direction.
> 
>>
>> Allowing counters to be named and configured with a mkdir()-style
>> interface might be possible too; that might make it easier for users to
>> coexist within a single resctrl mount (if we think that's important
>> enough).
>>
>>> It sounds to me as though the issue starts with your statement
>>> "The local/total distinction doesn't map in a consistent way onto MPAM". To
>>> address this I expect that an MPAM system will not support nor list
>>> mbm_total_bytes and/or mbm_local_bytes in its mon_features file (*)? Instead,
>>> it would list the events that are appropriate to the system? Trying to match
>>> with what Peter said [1] in the message you refer to, this may be possible:
>>>
>>> # cat /sys/fs/resctrl/info/L3_MON/mon_features
>>> mbm_local_read_bytes
>>> mbm_local_write_bytes
>>> mbm_local_bytes
>>>
>>> (*) I am including mbm_local_bytes since it could be an event that can be software
>>> defined as a sum of mbm_local_read_bytes and mbm_local_write_bytes when they are both
>>> counted.
>>>
>>> I see the support for MPAM events distinct from the support of assignable counters.
>>> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
>>> Please help me understand if you see it differently.
>>> 	
>>> Doing so would need to come up with alphabetical letters for these events,
>>> which seems to be needed for your proposal also? If we use possible flags of:
>>>
>>> mbm_local_read_bytes a
>>> mbm_local_write_bytes b
>>>
>>> Then mbm_assign_control can be used as:
>>> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
>>> <value>
>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
>>>
>>> One issue would be when resctrl needs to support more than 26 events (no more flags available),
>>> assuming that upper case would be used for "shared" counters (unless this interface is defined
>>> differently and only few uppercase letters used for it). Would this be too low of a limit?
>>>
>>> Reinette
>>>
>>> [1] https://lore.kernel.org/lkml/CALPaoCjY-3f2tWvBjuaQPfoPhxveWxxCxHqQMn4BEaeBXBa0bA@mail.gmail.com/
>>
>> That approach would also work, where an MPAM system has events are not
>> a reasonable approximation of the generic "total" or "local".
>>
>> For now we would probably stick with "total" and "local" anyway though,
>> because the MPAM architecture doesn't natively allow the mapping onto
>> the memory system topology to be discovered, and the information in
>> ACPI / device tree is insufficient to tell us everything we'd need to
>> know.  But I guess what counts as "local" in particular will be quite
>> hardware and topology dependent even on x86, so perhaps we shouldn't
>> worry about having the behaviour match exactly (?)
>>
>> Regarding the code letters, my idea was that the event type might be
>> configured by a separate file, instead of in mbm_assign_control
>> directly, in which case running out of letters wouldn't be a problem.
> 
> This work started with individual files for counters but the issue was
> raised that this will require a large number of filesystem calls when, for
> example, a user wants to move a group of counters associated with the events
> of one set of monitoring groups to another set of monitoring groups. This
> is for the use case where there are a significant number of monitor groups
> for which there are not sufficient counters. With mbm_assign_control this
> can be done in a single write and such a monitoring transition can thus
> be accomplished more efficiently.
> 
>>
>> Alternatively, if we want to be able to expand beyond single letters,
>> could we reserve one or more characters for extension purposes?
>>
>> If braces are forbidden by the syntax today, could we add support for
>> something like the following later on, without breaking anything?
>>
>> # echo '//0={foo}{bar};1={bar}' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>
> 
> Thank you for the suggestion. I think we may need something like this.
> Babu, what do you think?

I'm not quite clear on this. Do we know what 'foo' and 'bar' refer to?
It is a random text?

In his example from
https://lore.kernel.org/lkml/Z643WdXYARTADSBy@e133380.arm.com/
--------------------------------------------------------------
The numbers are not supposed to have an hardware significance.

	'//0=6'

just "means assign some unused counter for domain 0, and create files
in resctrl so I can configure and read it".

The "6" is really just a tag for labelling the resulting resctrl
file names so that the user can tell them apart.  It's not supposed
to imply any specific hardware counter or event.
------------------------------------------------------------------

It seems that 'foo' and 'bar' are tags used to create files in 
/sys/fs/resctrl/info/L3_MON/.

Given that, it looks like we're discussing entirely different things.

> 
>>
>> For now, my main concern would be whether this series prevents that
>> sort of thing being added in a backwards compatible way later.
>>
>> I don't really see anything that is a blocker.
>>
>> What do you think?
> 
> I do not fully understand the MPAM counter feature. It almost sounds like
> every counter could be configured independently with the expectation to
> configure and assign each counter independently to a domain. As I understand
> these capabilities match AMD's ABMC feature, but the planned implementation
> to support ABMC first configures events per-domain and then assign these
> events to counters. hmmm ... but in your example a file like
> "mbm_counter0_bytes_type" is global. Could you please elaborate how in
> your example writing a single letter to that file will be interpreted?
> 
> 
> Reinette
> 
> [1] https://lore.kernel.org/lkml/46767ca7-1f1b-48e8-8ce6-be4b00d129f9@intel.com/
> [2] https://lore.kernel.org/lkml/CALPaoChad6=xqz+BQQd=dB915xhj1gusmcrS9ya+T2GyhTQc5Q@mail.gmail.com/
> 


