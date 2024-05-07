Return-Path: <linux-kernel+bounces-172044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D638BEC61
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 21:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9EF1C24161
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA1D16DEB3;
	Tue,  7 May 2024 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sALASOjA"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0F616C84E;
	Tue,  7 May 2024 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715109160; cv=fail; b=flj3JU6gfMjYTZwrxLziF2W8GpxJuEtsPWzo3FgVUC1xcq2r25wCFQ2pKvOJq/qzbETDRRcn0rXZZrqGuzlCfxa5mFDd5Ybut+aH/wBDlO4Y3+Y0UwbWEWV0Yb9siOpz+L42OU+rHqXFG7Z2CUWb6t+PG0Vyx/F3AGUq3iP6BuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715109160; c=relaxed/simple;
	bh=6Xs+bog6gjNYzRNZDW+5yb4LhhXSW99tLJOL1lGUIBc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EAWiVbpIhti98x+AyiiV4T1jL6DAEEQUFOkFPybtsph7lUb3NpB4iu33RzRJBeftjMDp9ZprUKmDdzEbWPP28atT090h++e3yZH8VzZ6mlYBLr3vWG3dSkqKW4q7hVm1D+TuA+6AtPQ1xQ8ifsZ8lELPxwCGUxJ2dXLrqpdEoBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sALASOjA; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRs9gb7RTIB8ZvoZ7JVCWITtTIGmHVyZecRF8D28cnuz42yWM0ceoKTpfP5o0WctpcoIuxcyO5yA2Mb463CBVVr9H1yEKSSJwLfS2+6hy6HE84GHqeH7/MDOeMxUCUdpKpPNs3KR4Z5QqqzbwEUfLK6P1nRnkbGeKBAINrMGoW9uQwSRPCLQUajPZZIklzSdgGxfioolfyyu8rZQ7qpvSQuAyXc9+KG99shsQGK4+tLHYpcvhrDwgZrNd+o0lxXAr8fFXjuZ2j7R3HN66M2gJzaBFlvXOYqxcXExE938pVNCDvnT1xmaplDcbZT1Th1WMZSHyMgIRaSpJXkHI5AAAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88CIg4Xi6DG17FYdEE7yLYhAsJZ4Ni+3DTKJfzeiPdc=;
 b=SegxKMjd/5BJ6uwdmQIBlYw3PKa/lPuFgh4WpEbuD2cVaYKtBjBjNUeRYqeFrPH0hVao/5Boywb57ZP05P4Y7XLvi0Y2nGTJ5yxyh3hjcWTViFEkOg8BrvNpxzv37EwxvpoVzIAieq5XbdK2Csg8hOVgHZiBUuaXcrke9/aTmK/Q6Yr962hgKEEIF3BQqDfrKo2Di+BMTFpu0hvLjjRWZvLrLeYP7gR3ojbHbKRPLwwFSqodiZI5ZeuuC5UgvC4z8Lvhr41y5QAZlAML2+76DVocjltY+2oZhfZBk2ZlafhkFlVQyU3Aymqad5xXfysXm5rf198oB8rwTFmGFxgPTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88CIg4Xi6DG17FYdEE7yLYhAsJZ4Ni+3DTKJfzeiPdc=;
 b=sALASOjA2HgoLFJPXSqTxcd8ZYjQmuw2q0aDNTvetoqyzRde6BzHzfCnq8FwoRc07ONNxR5/Y1vgmhSl8IY5mjhc6oNEPPlRPK8zM79F1LhPC+/sKmznWMqIIPnQ2TmMsMb3ic8Gfpbboux4NGI8bTgrJ5FL5rjKgCN3G6IxXtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 19:12:36 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 19:12:36 +0000
Message-ID: <54ec73f9-6c9e-44f4-8ee9-a683bfcee607@amd.com>
Date: Tue, 7 May 2024 14:12:31 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 07/17] x86/resctrl: Add support to enable/disable
 ABMC feature
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
References: <cover.1711674410.git.babu.moger@amd.com>
 <0db75c94886da62b8da498ef159d8fe27b0b3811.1711674410.git.babu.moger@amd.com>
 <54b1fe8f-13e5-440b-bb36-4100c1d283d0@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <54b1fe8f-13e5-440b-bb36-4100c1d283d0@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0039.namprd05.prod.outlook.com
 (2603:10b6:803:41::16) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf95d6c-2f81-44bc-dca5-08dc6ec9a7ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1Z2V3RXWTY4WFpYSkl2c2VvQjl3blVhS281azRoVkNwUlhsaEF6Y0pPc0lV?=
 =?utf-8?B?ODBHMGp3YzJRRWVROHU0dFhWVXExMHRGUmUrRC9pL0xQKzN3QXZYbnI3RjBP?=
 =?utf-8?B?b090M0Nad21BanZ4SGI4ME1EWjlTRWtsdW8yRkFXU2d5MkVsOXZqQk9henZV?=
 =?utf-8?B?Z1pkS0czckFkMzJaaldwdUFJVjdidndJNTJ1WXk5T1BGSjlPMnRQWW00MXVt?=
 =?utf-8?B?cUo0bjhDVWxvaTdVaVlyRTZrSXNDbXpxa3czS01kNTFpUzNIUWVpeVJSVEtY?=
 =?utf-8?B?aENvYkVENUdua3lENzc3TGMvc2pRU1A1YjhyQ0FkS012bjFiL2VvVGdZMC9t?=
 =?utf-8?B?bUI0TDhRUFVaYStCS0NXNkZBTVVHV1hTMFhZc05SUVdaSXV2WVVoRThvdWVK?=
 =?utf-8?B?VmQ3SjFsWU1FYTFtU0RJMmliUTIrZ2IvaHUxOUV5c3djWktjTDk1OXJUM0pS?=
 =?utf-8?B?bWJkaHE3cWZ1VHd0UXBBd2t2MndjMDlIa0tjYXpqbXV6UEtiQVFuQlBNS3lu?=
 =?utf-8?B?L1dhTFdOZEFVWVBrMVhSWkVQSlFrNFNNRHlhckhjZ3lLdU9neDVnLzBWZ3VJ?=
 =?utf-8?B?TTVINFVhS2tGYTcwTHJGdU4rdXM0bE9ERHlmMTdpZ3dpelY0bnUvcXdsMzlJ?=
 =?utf-8?B?T0kzeDZxc3k1RXhteGR0WjIvRnhYYkFCc1RJVUpUY2s3WDM5NElIa0xOMW5i?=
 =?utf-8?B?V3RIQkRvYlQrSDJMMERNUllYWmRpT3NLdklpYTVtVWphL3FEd2ZLSFdTZGNQ?=
 =?utf-8?B?eEU4L0tWWlZieHhYaDdFNmJtWnFQYkIvdU1mbDVpeU5peHJVRVVyZDBtQi9L?=
 =?utf-8?B?Zm9YU2xVUWVHRE0xbXRPL0ZVYTF4dGo3ZWs4b1MwK3dhMlcyNjk1a0hmNlNM?=
 =?utf-8?B?cnJadnRIRlFwbC9VaVRkOFk3OXJBbXptU1A5TS90c1ZOU0MvNkppZGt4bDRG?=
 =?utf-8?B?b0UxeThibGdyWlhZcFNLNUlycW1Vd1Q0bVVvNDhEQ0VaSFJ6cnc1cElIK2pq?=
 =?utf-8?B?TmpFVFdpMll1WUREb2lPWFl0cjJGUFNmUmNzZDVxZjZENkw1Q0tPcm5rZ2Q0?=
 =?utf-8?B?SEdpUTZnL1c4SFFHUEswVGVSQmRVZk4vR0liQ1JGcXV2TEluOUo0aFB0VXZl?=
 =?utf-8?B?YUlpZmZaZ1UwTHpNd2lOb3ZvMXBFSmtJK1ppSVV5ZnRpcUx5RnUveU93V3Vi?=
 =?utf-8?B?WjRjdWxzR3FXQ09EeG5HYlZjWkNlOW1yU3R2KzhSR3JoU0V0bXFTazZUYWV6?=
 =?utf-8?B?T3ZITTNyaldSZzRnSVBtYi9qSXhFOHYxVDNuMFVQYk5RaVcxK3VseDdoK0lx?=
 =?utf-8?B?TFUzL1RFZEhUYXNFVmhOekxlM0xaYldaMDZEOEZ3ZjJIbGpGQTQ3aXFyM3Na?=
 =?utf-8?B?S3ZXaUhvYnNKazdVTi9vSUlxVHRnZW1BVmlrYlE1YVh2Y3k1QXdVSExjUktV?=
 =?utf-8?B?VmlpUElZTE5ueXp3NGc1T3NKK3ZqR09RVWtMQ3RxMkRmQ0ppa3dhUmhveVJn?=
 =?utf-8?B?amJMUG12OCtjYlhzTU53cGo5WWFSUmFUYXROZzhWYkp4bmltVm11N2dwWk94?=
 =?utf-8?B?YU1Da2lpQ0ZvK3RQdUtPcTh6MS96b0p3a2pVZy9QYTVxQ1VsRTdOaFBLa2Vt?=
 =?utf-8?Q?eGI7UrpvUU2/6S/0n1HNjo6SZ1lrpn7EB62MM180I+sY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ykk1cS9nV0FOSG40Q2FSVkJ2Z0MwUlZ5RFhReDlWOStyeWRscFhYWU10N3Y3?=
 =?utf-8?B?YUdNNXRNSC9td0Y1WU8yZ3FwTkdFNHpRZ2JWYkIrQ2F6VEtNWmpvMUJUdGFj?=
 =?utf-8?B?cTFBQXVJTU53TllrVElqVTU5d1NDM0RYa0tYQ3UrQkRUblNnSGppMTlRbkIw?=
 =?utf-8?B?b2dsQkZ0cFYvVzhKeitZN0NaK1g0SnlxUXV2ZXBQdEc3QmNTSDNBWlRsSnM3?=
 =?utf-8?B?VTlRNDVYYTRJNzZzNnZJdVFZMzAyRFFRUVcwSWNTWVVIdDc1clFOVXRSemV4?=
 =?utf-8?B?RWplZHJtR3U4Z3pzaTB6WVZTaWJSd2NmNVRjNno3bitiUFd5WUF2OE1ndmRh?=
 =?utf-8?B?eVcvOXhxTXVoUHo1TGdxeUJlUmdsNFo5RithU0hIV0lUbGhTOHBoVGtzM1F6?=
 =?utf-8?B?RFluVTNaVzVsQ1QwVy9nM1p2ckdUWkVKVm5zUzNIMXVNTU5pSEc3ZHRvQjJn?=
 =?utf-8?B?eFBGMzdUY21qZ2sxSG1hR1BNUWYzbXNMT285cGJ3US9xVkdVcEFMMmpWMVAr?=
 =?utf-8?B?SDZPNWJ2cjdZTmJGd21zd0pQSUJKOHNrSzlIbDVTMlk1Z0xDOW5LS09Sek91?=
 =?utf-8?B?TWExUWc0dm9UZzRKZUhSOVUzdUlrdFBGOEVncUM4aTY0U01Yd3lsVjJKa21X?=
 =?utf-8?B?Y0JUd0xHZ3NFZ09GeCtVYU4yKzA1L21MSkdFMjE2RStJWmc2TjFwZkM5YkJC?=
 =?utf-8?B?UTl5NWl4eFlBcUc0T1MvWUZObFdndUd0OUhkN1h0WEliUzJCMXVZQzBZRWkz?=
 =?utf-8?B?R0h6Ync2dmJWZjdMZmswN3RBZHhnemZkN2xhSE1PU0FtbnpWV3dWWGJKVHJ0?=
 =?utf-8?B?V2wxZDl0WFNKVFJRQStsRTgwUFZyY3ErVnhqb1dJQXN5LzlPMzZrdVo1K0JZ?=
 =?utf-8?B?V0xLTnYxSnpSaVcyRmRyUWZ5UEpWeXNSbW96Q2t5L2JGVGdMajc5MGY2Q0dt?=
 =?utf-8?B?cWZhejM4V0svV3pzOVNTajVrL2lzNUV1Z0NsN213TlJSMmFQZWJZR05qQWQ0?=
 =?utf-8?B?SjhjVkRYc3BkTVYrdzN0N1pwQ1pPUDQyYnN2QVd1MFV1Y2NtcmowMWxDOCtn?=
 =?utf-8?B?eWxxOGhlN1Q3TlR0ZUZZZkszT0t6MTdyRDVNL1NQaUdVdWxST0lPcTRiTFNU?=
 =?utf-8?B?aysvL2Z5Skd3Y1hEOXVBTURoWkUrZFFTbFRrS0IvWWsrVWNTNHQrSjN0L2Na?=
 =?utf-8?B?RlVTMXlaWTR0MDN2emdIazNZTDBWRUl0bVdnWnIraVEzOXZQa24zUTdhSUtU?=
 =?utf-8?B?NFBwamJFWmsrNUxONDdxQm9qcFdsdTJEU1NkdmhISUdpRmk3WG9HNmhOVEpu?=
 =?utf-8?B?OEh3b0dmdFZlaWgzQkhTa2Z4a1pCQ3hkZFExeTN4cjkzU1EraFdQWGFEbyt0?=
 =?utf-8?B?YmR2OVloQmNKUjR3dWhnL0RWKzgzdjgzTGxhTHNaWm1OVlJLSFFzVVRsOU9S?=
 =?utf-8?B?MFRmNGFDRnVtdUd2MG1ac01Tbnh0OTI5NjlFazJBMTQ0UVdGV0NuZGUrRHFN?=
 =?utf-8?B?VHl2Y2Q0dng4dzJnbURMM0w0cTdUMmJMVmpGYzZvT2xlV2VUVmYzY0kyOVJn?=
 =?utf-8?B?THVUTlU5YjNJSUk2bk9JYWNjbUVhc0RVNlpFUGRiSFlVZHdvbUcxeTVLVEJS?=
 =?utf-8?B?WHZqWGh4K2Z3ZjM2V1hnaWdkb0ZYSFFRRjRLUU5EZGs1Qi9ybklhWU5rUFZm?=
 =?utf-8?B?alhaa2JaUi8yMG5UalB3Mit2S3ZlTzRTTFVWcHRpUFJKRzRDbVhDK0tsYVhZ?=
 =?utf-8?B?TG8xbHlMa2E0M1lYQnFtWVgxcUNneTgzM3NhUlppQVNOWEZJN0lZc1QxWk9R?=
 =?utf-8?B?bVoxc09ub0J4cXBTVkFvYk5JVkxZZEFsVGNnd3p1Mm9vVU83SHM0bFJsZ0lZ?=
 =?utf-8?B?M2VPNm1nbExaV0pCbVprQzNDVjZENGdUai9WNDdUSGNZNUxFbGVmY2wwd0g2?=
 =?utf-8?B?U1d0aDh0WUg3cmJrMmVRZVR6WkhoVW5HeFN2N1FRUDN4OTRkUU1nN3B2bU9m?=
 =?utf-8?B?SEJIazRMK21wQ0dMWlBxSXFqSkMrQjkvU2xrUW5jZVZ5S0JHa2tpVUE3bWty?=
 =?utf-8?B?YmpZM2ZEVUU4WVlOQkI5WFVYOThhRks1N3RDUm05aEJRKzlQWlh5Z04xeGZS?=
 =?utf-8?Q?0Vjs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf95d6c-2f81-44bc-dca5-08dc6ec9a7ee
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 19:12:36.6411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+TYGg+zCu0ERJVtKa2ZPmwylYXhJWmy36CnJuVwWXqyg5HWcMiCatFC+5OgZ58d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562

Hi Reinette,

On 5/3/24 18:30, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/28/2024 6:06 PM, Babu Moger wrote:
>> Add the functionality to enable/disable ABMC feature.
>>
>> ABMC is enabled by setting enabled bit(0) in MSR L3_QOS_EXT_CFG. When the
>> state of ABMC is changed, it must be changed to the updated value on all
>> logical processors in the QOS Domain.
> 
> This patch does much more than enable what is mentioned above. There is little
> information about what this patch aims to accomplish. Without this it makes
> review difficult.

Sure. Also I need to add details about why resctrl_arch_reset_rmid_all()
is required. Will do.

> 
>>
>> The ABMC feature details are documented in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> ---
>> v3: No changes.
>>
>> v2: Few text changes in commit message.
>> ---
>>  arch/x86/include/asm/msr-index.h       |  1 +
>>  arch/x86/kernel/cpu/resctrl/internal.h | 12 ++++
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 76 +++++++++++++++++++++++++-
>>  3 files changed, 88 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index 05956bd8bacf..f16ee50b1a23 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -1165,6 +1165,7 @@
>>  #define MSR_IA32_MBA_BW_BASE		0xc0000200
>>  #define MSR_IA32_SMBA_BW_BASE		0xc0000280
>>  #define MSR_IA32_EVT_CFG_BASE		0xc0000400
>> +#define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
>>  
>>  /* MSR_IA32_VMX_MISC bits */
>>  #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 722388621403..8238ee437369 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -96,6 +96,9 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>>  	return cpu;
>>  }
>>  
>> +/* ABMC ENABLE */
> 
> Can this comment be made more useful?

How about?
/* Setting bit 0 in L3_QOS_EXT_CFG enables ABMC features */

Or I can remove it totally.

> 
>> +#define ABMC_ENABLE			BIT(0)
>> +
>>  struct rdt_fs_context {
>>  	struct kernfs_fs_context	kfc;
>>  	bool				enable_cdpl2;
>> @@ -433,6 +436,7 @@ struct rdt_parse_data {
>>   * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
>>   *			Monitoring Event Configuration (BMEC) is supported.
>>   * @cdp_enabled:	CDP state of this resource
>> + * @abmc_enabled:	ABMC feature is enabled
>>   *
>>   * Members of this structure are either private to the architecture
>>   * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
>> @@ -448,6 +452,7 @@ struct rdt_hw_resource {
>>  	unsigned int		mbm_width;
>>  	unsigned int		mbm_cfg_mask;
>>  	bool			cdp_enabled;
>> +	bool			abmc_enabled;
>>  };
>>  
>>  static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
>> @@ -491,6 +496,13 @@ static inline bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
>>  
>>  int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
>>  
>> +static inline bool resctrl_arch_get_abmc_enabled(enum resctrl_res_level l)
>> +{
>> +	return rdt_resources_all[l].abmc_enabled;
>> +}
>> +
>> +int resctrl_arch_set_abmc_enabled(enum resctrl_res_level l, bool enable);
>> +
>>  /*
>>   * To return the common struct rdt_resource, which is contained in struct
>>   * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 05f551bc316e..f49073c86884 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -850,9 +850,15 @@ static int rdtgroup_mbm_assign_show(struct kernfs_open_file *of,
>>  				    struct seq_file *s, void *v)
>>  {
>>  	struct rdt_resource *r = of->kn->parent->priv;
>> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>  
>> -	if (r->mbm_assign_capable)
>> +	if (r->mbm_assign_capable && hw_res->abmc_enabled) {
>> +		seq_puts(s, "[abmc]\n");
>> +		seq_puts(s, "legacy_mbm\n");
>> +	} else if (r->mbm_assign_capable) {
>>  		seq_puts(s, "abmc\n");
>> +		seq_puts(s, "[legacy_mbm]\n");
>> +	}
>>  
>>  	return 0;
>>  }
>> @@ -2433,6 +2439,74 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
>>  	return 0;
>>  }
>>  
>> +static void resctrl_abmc_msrwrite(void *arg)
>> +{
>> +	bool *enable = arg;
>> +	u64 msrval;
>> +
>> +	rdmsrl(MSR_IA32_L3_QOS_EXT_CFG, msrval);
>> +
>> +	if (*enable)
>> +		msrval |= ABMC_ENABLE;
>> +	else
>> +		msrval &= ~ABMC_ENABLE;
>> +
>> +	wrmsrl(MSR_IA32_L3_QOS_EXT_CFG, msrval);
>> +}
>> +
>> +static int resctrl_abmc_setup(enum resctrl_res_level l, bool enable)
>> +{
>> +	struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
>> +	struct rdt_domain *d;
>> +
>> +	/* Update QOS_CFG MSR on all the CPUs in cpu_mask */
> 
> "all the CPUs in cpu_mask" -> "all the CPUs associated with the resource"?

Sure.

> 
>> +	list_for_each_entry(d, &r->domains, list) {
>> +		on_each_cpu_mask(&d->cpu_mask, resctrl_abmc_msrwrite, &enable, 1);
>> +		resctrl_arch_reset_rmid_all(r, d);
> 
> Could the changelog please explain why this is needed and what the impact of
> this is?

Sure.

> 
>> +	}
>> +
>> +	return 0;
>> +}
> 
> I think the naming can be changed to make these easier to understand. For example,
> resctrl_abmc_msrwrite() -> resctrl_abmc_set_one()
> resctrl_abmc_setup() -> resctrl_abmc_set_all()

Sure.

> 
>> +
>> +static int resctrl_abmc_enable(enum resctrl_res_level l)
>> +{
>> +	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
>> +	int ret = 0;
>> +
>> +	if (!hw_res->abmc_enabled) {
>> +		ret = resctrl_abmc_setup(l, true);
>> +		if (!ret)
>> +			hw_res->abmc_enabled = true;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static void resctrl_abmc_disable(enum resctrl_res_level l)
>> +{
>> +	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
>> +
>> +	if (hw_res->abmc_enabled) {
>> +		resctrl_abmc_setup(l, false);
>> +		hw_res->abmc_enabled = false;
>> +	}
>> +}
>> +
>> +int resctrl_arch_set_abmc_enabled(enum resctrl_res_level l, bool enable)
>> +{
>> +	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
>> +
>> +	if (!hw_res->r_resctrl.mbm_assign_capable)
>> +		return -EINVAL;
>> +
>> +	if (enable)
>> +		return resctrl_abmc_enable(l);
>> +
>> +	resctrl_abmc_disable(l);
>> +
>> +	return 0;
>> +}
> 
> Why is resctrl_arch_set_abmc_enabled() necessary? It seem to add an unnecessary
> layer of abstraction.
> 

I feel it is better to keep it that way. It is consistent with definition
of resctrl_arch_set_cdp_enabled. It handles both enable and disable.
Otherwise we have add those checks from the caller.

-- 
Thanks
Babu Moger

