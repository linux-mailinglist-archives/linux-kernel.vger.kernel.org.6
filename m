Return-Path: <linux-kernel+bounces-422625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 630C59D9C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15CA164AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883735B05E;
	Tue, 26 Nov 2024 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gj3XlTtT"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE461C5799;
	Tue, 26 Nov 2024 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732640971; cv=fail; b=s/m7Ol3L+za86fhUjEhGLegIj8i4o0d5hmEtYUPGr252n4w+yr6QpfnNljoR7Bk8d42FA8Gm4lJKZPVDZ9b2pvhm5kHrlBwgCOmIkU4PvhSWtfXz2ymzAngtlc5EVu575zwuifFKo7KWrTlYtKHdL6VDfZv7TG3ymDVBpx8HlT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732640971; c=relaxed/simple;
	bh=sp+rXO03M3jDe4bbrD+xLpR9gcpw80ZLwp+GVDNz9Hk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b34HXDpBC8Yu0uH1pmlBHmRowLZ1pRBgWG4Gc9/URkkDCq4h7XI/0K4wv0kAc9MlP7R72iqaVXJ1vaTf2lutvHEho/3emtp9aGlLEir5BjNNK9oRg7uHGDNb7/wlhbCB8iaRn1rc9rsrTwjjhLpaB20QxCB16X4vvO+wacmAsJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gj3XlTtT; arc=fail smtp.client-ip=40.107.102.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bie3je6PHSdw3krYv9oexhy4ybcRvpmGpFenCQe57qPdtD8VmQUjdBy3le5G9CLEb5Q+ajsdn1RRwCG/MbdwmjpHd+OXbykM1mtbBtLehOfd43196TIpYcl5ovSOjQjdfMNk9XdVCOzV/uNbTEGofuZNShupjidGzl4vERjEcNrtxnt2cEVHJb+kSFy9PXKETdDQl4o+nf/3QrliRvrq6IPymVA/k/O6cl3QNl9afMgkVjX5QvMbDFrQEx+bC2VD398tqBYREcWCFm3oNL0dasqY9MAHUYQZlr0rHlFHeB1HS6DTxEpuSq0oBi7Ju6wBm/dWJSVFuV9jDjFc4qgbdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1HDNTS1vHXZcmmiCRAV9pZPc0GbdsWh7/MWgirxmk4=;
 b=oyqzoZAehztyy4zOnN4i9QawDaTHItDSzm3Vibc187J/tPYJjq6tqi15lAVbcWDLtfUtrJcenDFol8FutN/3KDp7hJ8KEfTsO+mhHsci+jCmaXhjcB7iQ41Vx8tsSKypfj1q2IZkoDRg5U9kUBO2vdDbzzh0FF6hBS6Lph9teWzfvi1xivSNbIPS9vOEv7PqwQkPeQdMgloaGfKK6dPZ1dcsKCMxuL4eD/Lg5J1vh44nvWHWFOJQT8TIbTDHW/MeGhuDaiHM8BvsFwFYL/owlZUjywZhHSZ0AUD1VxY56CE+x3ZxJ6ceZw3cWb2JaApwbN/TmP/p94On36Dh+nCuIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1HDNTS1vHXZcmmiCRAV9pZPc0GbdsWh7/MWgirxmk4=;
 b=gj3XlTtTIIEwbqbBMd+1/mb69aTHD1s6yu/3bjIAIeDzM2CN5jliRIpoUqOrqEpWuPeWiQrCAN8CuaBGiJzGqoBIBZHu88FU8C1Fa/vIGmAEoP7E3JDE2FraEHBpl9iq3YhqMj8dP6xSD+b5h76WK9IvZVqOJ6UvsOyK8eImscI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 17:09:23 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8207.010; Tue, 26 Nov 2024
 17:09:23 +0000
Message-ID: <18eacffe-3839-4104-81ee-a3497b1f28f1@amd.com>
Date: Tue, 26 Nov 2024 11:09:18 -0600
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
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <6bd4335d-4b55-455f-a042-948df227e02e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:806:27::31) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 62453a84-42d8-457a-fcf1-08dd0e3d1314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWxLc2hwRUdXQ0dWZXk1WmlIYVhUNTI1aTJjTU16aGVzOEtvVkhldndjeG93?=
 =?utf-8?B?UW5BZTFuVjRFUmpjT2wzbWhmM3ZGMlZrY0xYUkhCK0NMN3IyQXMrcmZJY0ox?=
 =?utf-8?B?Qm9CUkFpVEdrMEh1ZFYxam16dmZoNWJ4NDMvRXVIRTVZb2lxMDROQ1ZERE1I?=
 =?utf-8?B?Vk1iOWZYTkxtM3ZySjlxUFBVWjlFZlZlWGdadCsxOEFRSkM5WUd2SS8xTnBz?=
 =?utf-8?B?bjdLaXgwSGttQXNZZ0VNczlkMlJoTzVGaTFhN1l1YnNTSVRNMXNUZ0l4K3o2?=
 =?utf-8?B?SG5jWS94TjRaL2Z0WTRlbVpQczJsR0o3Vjk0ZkJzQWZLYjg2bVhYdDNsM1hQ?=
 =?utf-8?B?RThyM3VLVHA2dlpSL0lsWEp0M2NHMEZaOGNYcW81ZEZhN1pzNmhVbmU1dDZI?=
 =?utf-8?B?OTg5TmZsVUcxNlZ6UjZuTHpRK1VjNmRKTG1XN2FFRXdTRUtmTDQzeXFIY25j?=
 =?utf-8?B?KzFuaEdaWDNDRmx5a0gxMzA2ZnFiYS9pOWg2bUxUUmk5UFU1T0RWak4xL2k4?=
 =?utf-8?B?bngyK1g2RndWYWRxNHlKSVdoZURVd3JPMnVFOWJydVN5Tk92ZUZlaXRZOVRX?=
 =?utf-8?B?YjJ3ZWlsR0ozYk1OSzZYcnhhaWU5QnlwRGpKc25kYm1XZG1jbzBOM3BIMGMx?=
 =?utf-8?B?M0hnV29tUFRWUFRMZFMyZm05SVhXY3E5TGZndnY4OWRkWGNCeXVtZTdwNHA3?=
 =?utf-8?B?dk5aUHpyVlRWOXpwMzNUVkwxT1NiNy9KL29oYTVvMGkzMitVUytxZG5hRUlh?=
 =?utf-8?B?TEJVS3ZTd2Uzb3ExMHlOU2NLS2VPOWg1bGlCa2pwSHZhUzdCYi8yTFZhQThx?=
 =?utf-8?B?aTFuTzh0WnJSR2ZBbUJkcTMvS01hUEVJU1ZBWUJjQTVDRUI5N3dBcWJ2MjVq?=
 =?utf-8?B?akRVUkZsOWVlbHV0bEVsN2ZDbFYyWHNNODZtemNHQ281R2xGZ0pLZ3NKMk4v?=
 =?utf-8?B?TW5INVNIYWNpbHY0OXQweXpvNitPWmp2cUhyS2orWnNCekZQNXpxNDBTZlZq?=
 =?utf-8?B?QjAwb2o0cVZ5WENISllwaHdra2lwRjRPbXhFbEpuczJ3V3hsOW9oN3FEMy9y?=
 =?utf-8?B?ejNBMi9jTjVNdHNoR2FhMktpYTBEWXhndFZnZ1hsRWROM3JxWVhiSXZGVTNI?=
 =?utf-8?B?L0s1UFBZQ2I1d0kvNlA5M3RJYW5wYWZMelB3cnFITmM2akhyR0RvanFwZVZp?=
 =?utf-8?B?UXBBOXdseWZrL0NIZStCR2liR3A1L0xjK0VpNXVOTUVWK2NnUFh5TDF4L29v?=
 =?utf-8?B?S2ViRWNwenAxcCtqVFpvaThlRmFUUjBubXNHQitIYzZCbkdDQjd1UHRodE9m?=
 =?utf-8?B?SitQUnk5RVhsb0R1SFpLL0hHZ1hxWmswSkd5UXFUYkdqNlhuUHB6OUpiMGUv?=
 =?utf-8?B?Z2MzbWFtU2xEWkpRVG9EVkp4K2RpbmJqNE53NEFpU01oUk5xVUJGTXhtMFQz?=
 =?utf-8?B?Uk0xU2IxMDVGRlRLQUx5dG9OUXdrU1lnSlpibW03SE9VeUlBWUx3eStjbzZ3?=
 =?utf-8?B?ZEttK2xWbXFrLy9TMFkxODd0dHVvV3dnQ3oyTkhPdTExR2MxUXFya2UzVTdR?=
 =?utf-8?B?RjY4VHVLVE5jNGE3MHhSRGtUdUR2R1FXcjJ5ZnlyV0R1UzlES1hwWlgzeEZ0?=
 =?utf-8?B?emFnTlZ2aVp2dGJQbkwyMFhUTkNMbGt5azQ5Y0VWZkp1NWFRaXF1c2ZKdnZ4?=
 =?utf-8?B?UHIzRFFyVWdzNUlMN2E5bUEyK2xQWUtReStTR1E4K1VpLys3TGV6VlBTYmNH?=
 =?utf-8?B?V1E1UzhSTkF1Sm8way9VV1RkTDIyUFVlcGFxZmgvMXpsRXRzSGFzb2lhTDcy?=
 =?utf-8?Q?6VDMs7tWwDxpO291fPgGyXKftq0hMaPAjoaRM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZStYM0orTWNEeGdBSmFYVjNCWjV5OERpdmYvMkpDaWM0U045V01pOUZTbklu?=
 =?utf-8?B?WGZIWS9SNmpocEpBWlRsbmpuQlJkMGh4UGhnYkJiWGx1bVh0ZEZvWGxNNmlY?=
 =?utf-8?B?NHJjNzdQRGFuOEtaSjhHeXFWNmNJNWdwdWZJL2g1RGRVUEViOU9hcWNkMHJC?=
 =?utf-8?B?VDJoNnJaY3ZVMFhXTGhabUtFUlU1SnU4T3ZaM0tBWXgwdUg5blFMa3NKUjlK?=
 =?utf-8?B?Snl4ejJCSk1jVk5IdHliamlUd0gvKy9ycXRycHoxUnBObUJiSGxxSVhhdThH?=
 =?utf-8?B?bURpck43Wkl3bCtxMG9NQ2drbExpbEdvWlhLZXZ1SWtCditjWXh4c0hkZGRs?=
 =?utf-8?B?QjRtSW1wTVJCR3hoMWxxNHhFZ2xiMy90cmdudGpUa0ltOGkyTjNrZWZ5Rm9l?=
 =?utf-8?B?WEgxMVdZOCsvS001Wm5RdDRXSmREc3Y3MWxoOGZ1M3VrQUFPaEY0MVk3TlpM?=
 =?utf-8?B?a2lXMHVXZnhLeTZ1YWlGeGZLd3hzcWNuM1MzNjhlVkxPNUw3UmhmRkVYbnBF?=
 =?utf-8?B?SkhqLzZPeHA4RktWeDRnaGkvVHVCYUZMMHgyVUlDOG9rQjMvWGJNM29uczRj?=
 =?utf-8?B?ZHhnV1NrNGRYdTVrRzJBSFdSa0JubTlqc3JtekxsRDBNSmVHYkMrVXU0cHFr?=
 =?utf-8?B?Z0RINjBqVDRBRzNCT1dOZm5INC9YNkFIbGgvRWl6R1g2Ung1QUg0MWEzZ0JM?=
 =?utf-8?B?NlZhbjJMT1NRRTUyZ3ZSdEdOc0J5QXV0aGdKdU5VWE5RVG5ObHB0N0Nkcnlo?=
 =?utf-8?B?MjJjK1hwb0pyK1JYY2RFQkpxeElMbGN0TE9yRHVXUWEwYjJWd2xkQkF3L1R1?=
 =?utf-8?B?aUNyWG1tVDBWYmxMN0pGZUNJQ0dtTTNIaGdqNDJBb1l3QVBDVllkek1COHdC?=
 =?utf-8?B?WU5Jb1lKWEQvaDJEaXROZDNzTDZuQVlJdmVwUWRjSzNuaHZ2N1ArTXRoR2d0?=
 =?utf-8?B?ZGdhNXdWclBEZFdTUUF0RmF0L3VJUGJ2WjE1SEY1TFlKUzN2U2FWSzhQZ2h0?=
 =?utf-8?B?TjNkWlRjMjV4RzlMektUODlUSEpuTWtVNmZJalVucjNDZ1h6ZXgxWFc2ZXdx?=
 =?utf-8?B?aWJQTkw2a1R0a295bEhSbmE3TXpLVlVWemVxZGxDalB0Q1d4UnBqN3VJQ3do?=
 =?utf-8?B?NDlBdUNkMUZRcDVvaDNydFdzTWx2NE1Zck1rYWdBWVJqeEIrTjU3Q0pvTTVW?=
 =?utf-8?B?YUdpdWRLbUdVK3VEL0Z2alJRZUJ0cXZRRVhJN3hpamNnZFREVDhpK1R3ZDFU?=
 =?utf-8?B?cTAwOHVTQmFndVlORmpuV0lSVTdpTUF6RUJJTHB2V3ZlSjRqSzBQYWtpa0ho?=
 =?utf-8?B?Qldvc1B2TzUzOE9lN3JncGVZMHVjOEdkTjBrZm9aOXpxcnc0NkJVeTR1SlV6?=
 =?utf-8?B?OGpMUzExVUt5Mk9EbS9ndEtyNHdEYXIra1V4UmFaZW9lQ2thL3FwMmd0UkFu?=
 =?utf-8?B?eTdOODRlVEpvcG84NHJtL2tFRGFFcmxnLzhDZ0lQNGdlRHFKZ2NZK3JoQWFL?=
 =?utf-8?B?UjM4dkVtUTJQaDRFYWxCNWhWclVXaElUc3Nlamd4THAzWVppdWcyQ2hzLzdN?=
 =?utf-8?B?R1B2eW9ieXZOck8yeGw5Y2I4REJaZzhEempHdnJhbzJCcUFSSTVqUmR6Q2ho?=
 =?utf-8?B?U0xCa1JzR1dIYlhZMlkwT2ZUZGZUZk9tN25pQUhHNFRmdDROb0pVRW5SZVdh?=
 =?utf-8?B?Y2xsU2c2SFpkR2h4c2ZUckRubXMreE1mUDlzalFjU3M5UytaTFMybDZ4Wmkw?=
 =?utf-8?B?NEtpSS9LOU5KWlliT25HRnFrVjlmLy83cjlzRWQzZE01ZGlHVVZVNEhLU0k0?=
 =?utf-8?B?TkJNT2tNQURUK2c2RisrYWpTRjZrc1N3L3hxTzk2d1FxSTNGZU96c2wyOU91?=
 =?utf-8?B?eHhFcDViaTlOYXdwVkFITWNTclNZVjJrVTA4aTUvM1dLQ3Y3WStYR2JHbjNR?=
 =?utf-8?B?TUNYbmRhcUhQWUV6dWN6MDJoUDdZZHM1Z0Rqd0ZnZGtON01jamZSRlBYUHNt?=
 =?utf-8?B?RjFJOEhkSFZZblUzckFqZUpRVWVXM2s3aWxCMEwzMnpZOTFvK0t1MWNLbjBH?=
 =?utf-8?B?YUxiUEVhdUNYMC9lYWpUaGpreHozUkVVa3RqT0hNb0o1cHE5VkFxVnk4ZFZu?=
 =?utf-8?Q?sZ88=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62453a84-42d8-457a-fcf1-08dd0e3d1314
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 17:09:23.4247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0G2Rm3iP8GFOFwYv27hwmptK7NGYJ/RUaFwZcJZoDc7mU0B0Hp823xKTzUXT9ujg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008

Hi Reinette,

On 11/25/2024 12:17 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 11/22/24 4:02 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 11/22/2024 3:37 PM, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 11/22/24 10:25 AM, Moger, Babu wrote:
>>>> Hi Reinette,
>>>>
>>>> On 11/18/2024 4:07 PM, Reinette Chatre wrote:
>>>>> Hi Babu,
>>>>>
>>>>> On 11/18/24 11:04 AM, Moger, Babu wrote:
>>>>>> Hi Reinette,
>>>>>>
>>>>>> On 11/15/24 18:00, Reinette Chatre wrote:
>>>>>>> Hi Babu,
>>>>>>>
>>>>>>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>>>>>>> Introduce the interface file "mbm_assign_mode" to list monitor modes
>>>>>>>> supported.
>>>>>>>>
>>>>>>>> The "mbm_cntr_assign" mode provides the option to assign a counter to
>>>>>>>> an RMID, event pair and monitor the bandwidth as long as it is assigned.
>>>>>>>>
>>>>>>>> On AMD systems "mbm_cntr_assign" is backed by the ABMC (Assignable
>>>>>>>> Bandwidth Monitoring Counters) hardware feature and is enabled by default.
>>>>>>>>
>>>>>>>> The "default" mode is the existing monitoring mode that works without the
>>>>>>>> explicit counter assignment, instead relying on dynamic counter assignment
>>>>>>>> by hardware that may result in hardware not dedicating a counter resulting
>>>>>>>> in monitoring data reads returning "Unavailable".
>>>>>>>>
>>>>>>>> Provide an interface to display the monitor mode on the system.
>>>>>>>> $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>>>>>>> [mbm_cntr_assign]
>>>>>>>> default
>>>>>>>>
>>>>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>>>>> ---
>>>>>
>>>>> ...
>>>>>
>>>>>>> I'm concerned that users with Intel platforms may want to use the "mbm_cntr_assign" mode
>>>>>>> to make the event data "more predictable" and then be concerned when the mode does
>>>>>>> not exist.
>>>>>>>
>>>>>>> As an alternative, is it possible to know the number of hardware counters on AMD systems
>>>>>>> without ABMC? I wonder if we could perhaps always expose num_mbm_cntrs as a way for
>>>>>>> users to know if their platform may be impacted by this type of "unpredictability" (by comparing
>>>>>>> num_mbm_cntrs to num_rmids).
>>>>>>
>>>>>> There is some round about(or hacky) way to find that out number of RMIDs
>>>>>> that can be active.
>>>>>
>>>>> Does this give consistent and accurate data? Is this something that can be added to resctrl?
>>>>> (Reading your other message [1] it does not sound as though it can produce an accurate
>>>>> number on boot.)
>>>>> If not then it will be up to the documentation to be accurate.
>>>>>
>>>>>
>>>>>>>> +
>>>>>>>> +    AMD Platforms with ABMC (Assignable Bandwidth Monitoring Counters) feature
>>>>>>>> +    enable this mode by default so that counters remain assigned even when the
>>>>>>>> +    corresponding RMID is not in use by any processor.
>>>>>>>> +
>>>>>>>> +    "default":
>>>>>>>> +
>>>>>>>> +    In default mode resctrl assumes there is a hardware counter for each
>>>>>>>> +    event within every CTRL_MON and MON group. Reading mbm_total_bytes or
>>>>>>>> +    mbm_local_bytes may report 'Unavailable' if there is no counter associated
>>>>>>>> +    with that event.
>>>>>>>
>>>>>>> If I understand correctly, on AMD platforms without ABMC the events only report
>>>>>>> "Unavailable" if there is no counter assigned at the time of the query. If a counter
>>>>>>> is unassigned and then reassigned then the event count will reset and the user
>>>>>>> will get some data back but it may thus be unpredictable (to match earlier language).
>>>>>>> Is this correct? Any AMD platform in "default" mode may thus be vulnerable to
>>>>>>> "unpredictable" event counts (not just "Unavailable") ... this gets complicated
>>>>>>
>>>>>> Yes. All the AMD systems without ABMC are affected by this problem.
>>>>>>
>>>>>>> because users should be steered to avoid "default" mode if mbm_assign_mode is
>>>>>>> available, while not be made concerned to use "default" mode on Intel where
>>>>>>> mbm_assign_mode is not available.
>>>>>>
>>>>>> Can we add text to clarify this?
>>>>>
>>>>> Please do.
>>>>
>>>> I think we need to add text about AMD systems. How about this?
>>>>
>>>> "default":
>>>> In default mode resctrl assumes there is a hardware counter for each
>>>> event within every CTRL_MON and MON group. On AMD systems with 16 more monitoring groups, reading mbm_total_bytes or mbm_local_bytes may report 'Unavailable' if there is no counter associated with that event. It is therefore recommended to use the 'mbm_cntr_assign' mode, if supported."
>>>
>>>
>>> What is meant with "On AMD systems with 16 more monitoring groups"? First, the language is
>>> not clear, second, you mentioned earlier that there is just a "hacky" way to determine number
>>> of RMIDs that can be active but here "16" is made official in the documentation?
>>>
>>
>> The lowest active RMID is 16. I could not get it using the hacky way.
>> I have verified testing on all the previous generation of AMD systems by creating the monitoring groups until it reports "Unavailable".
>> In recent systems it is 32.  We can drop the exact number to be generic.
>>
>>
>> There is no clear documentation on that.  Here is what the doc says.
>>
>> A given implementation may have insufficient hardware to simultaneously track the bandwidth for all RMID values which the hardware supports. If an attempt is made to read a Bandwidth Count for an RMID that has been impacted by these hardware limitations, the “U” bit of the
>> QM_CTR will be set when the counter is read. Subsequent QM_CTR reads for that RMID and Event may return a value with the "U" bit clear. Potential causes of the “U” bit being set include (but are not limited to)
>>
>> • RMID is not currently tracked by the hardware.
>> • RMID was not tracked by the hardware at some time since it was last read.
>> • RMID has not been read since it started being tracked by the hardware.
>>
>> All RMIDs which are currently in use by one or more processors in the QOS domain will be tracked. The hardware will always begin tracking a new RMID value when it gets written to the PQR_ASSOC register of any of the processors in the QOS domain and it is not already being tracked. When the hardware begins tracking an RMID that it was not previously tracking, it will clear the QM_CTR for all events in the new RMID
>>
>> - Babu Moger
>>
> 
> I think I am starting to understand what is meant with the "count the traffic in an
> unpredictable way". From what I understand the hardware uses the "U" bit to indicate
> that an RMID was not tracked for a while, but it only sets this bit on the
> first read. After that the "U" bit may be cleared if a counter can be assigned to an RMID
> afterwards.
> If it was only user space that reads the data then it should be clear to the user when the
> hardware limitation is encountered and thus hardware behavior can be "predictable", but since
> the overflow handler runs once per second it may indeed be the overflow handler that
> encounters the "U" bit and that bit is not currently handled. This could leave user space
> with impression that events are always returning data but that data may indeed be wrong.
> 
> In another thread [1] Tony confirmed that "U" bit is not returned by Intel systems so
> this issue only impacts AMD. As I understand the other scenarios in which AMD systems
> can return "U" (the first read after assigning an RMID and the first read after changing
> the memory config) are all scenarios that can be controlled by resctrl.
> 
> I do not see why unpredictable data should be addressed with documentation. Could this not be
> fixed instead? Essentially stating "AMD systems without ABMC count the traffic in an unpredictable
> way" seems like a poor user experience.
> What if instead resctrl handles the "U" bit better? For example, when the overflow
> handler encounters the "U" bit the RMID can be permanently marked as "Unavailable"? Would
> that not be better than the counter behaving unpredictably with users never knowing if they
> can trust the event counters?

Actually, I was looking at handling "Unavailable" in little bit better 
way. Right now, I see it reports "Unavailable" first then it goes into 
overflow and stays in overflow forever.

Also setting the RMID Unavailable permanently is not a good option. We 
should have a way to reset it. At some later point the RMID can become 
active and report the correct numbers.

I was thinking of introducing a new arch state(in arch_mbm_state) to 
handle this case. Need to investigate more on this. What do you think?

> 
> Reinette
> 
> [1] https://lore.kernel.org/all/ZzUvA2XE01U25A38@agluck-desk3/
> 
> 

-- 
- Babu Moger


