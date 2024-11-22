Return-Path: <linux-kernel+bounces-418764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53539D6569
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341A31615D7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 21:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6379418733B;
	Fri, 22 Nov 2024 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GXfr64te"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D19A176231;
	Fri, 22 Nov 2024 21:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732311286; cv=fail; b=l15qpdXJoc6xuRl0bV8JI2XCLNPqikh+us0cfkfIQc3vlwrNH6W6hAI5S9ajmzHsoFfOU7gJigAopY7+yNj6gqsucw17F+P5YVMBPL6B1SvD2E341OIgu/AkYyLwlYXjUq2yRwp9IHBy+jhKgp467yxEtfwBsMil/20mP4Ea6zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732311286; c=relaxed/simple;
	bh=gjoE7djY/1OhaEp5E3mKAQ4PF9Ihdadv1wUEhSbP/TE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HSOAQpL1ZKEbHhOVPvXkhZlJbLWzczgtiAInTWCL9TnyH54Zbj4SoFekxIEy3mj+tGB2bOHpo2mKOnyUC7838lq/915kYs0nbApd7k4V619pJ2XaszUKic3sH7im13xnGQLQgASXnxgD4L+xY8aJjUtlMdk86fkYVqJXIiMStqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GXfr64te; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgztC1QUlLSVvcVj4ofcH5yb+S0YRZdsKEFPpmpLDQWY4eJcXL+kIhP5kYNvUVFAmdbWw0NZ+tGRxup0/aVPfeHgpRrHe66AxdnFIKrYXPDrEGbtCVvLinuEkTR73iD+ft1RSZP8vJlpJj0Lnuds1hAQomoh+5dBiWOhGWvCt43cSWXN91UsPEmhpDtga5sV3M67bTy3rJikXWybFFj2iXFgmyEp+mDK0Ry02VdODIkQXY9YeCv9aoVL4zuUefL6TeX57p3fIJOs/Xt8iYTEITmvBg2LL5bxlHonfekijROJvclG7TYR34+PUblEGJ1Abx9ZNMl4by9UC6CZcfmlUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+S0E3qhxNTBW+3byApUhnarpNiiW3wy11I8okl+lgsE=;
 b=oDL8rRygknX+KbNMjxKMuof1YL022vgyRy4LHmhZ6nac7MmTjMImZU5H8/gckQ7AemAOH7R5teo4eVJZ8ykYIbnnga3nVrUW7LuAy5XzBPHADL4F6NfRMnJ4j5s0cRAmUtZfzCZ/rK+ghaTggFSO/MrY4xOVnvEXMgKWmvpmZMIAcPGApkAP8DwAGPGgFd/o0B0n82HP757OEyXc7gNoWyto071c4vqUddDd1hcKvyO4Lc2M89qKzJaLv9Po9NFDwHdL6p2oNhdhDXQFn/QUceny15ICG2Al2a+ld1/t24lVb4BoQEz+XFHTaeOkaimvdXWfZx32NM82lkBARqIF7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S0E3qhxNTBW+3byApUhnarpNiiW3wy11I8okl+lgsE=;
 b=GXfr64teu8N8h+qMGbgqmKGfK2uUZeqVZgciqNZtAX3pLXgiIfa8/fD0sbC6LA3FFZ4QnxVxgRhVQ39tob2RNmONgcLfSpUK1IWDWIPleRcftVdra3I2aA0qSggL6I4tSY7dqMX5foChnTwp6YrDmQx3zPq+9+KZrwX3XEslWLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN0PR12MB6127.namprd12.prod.outlook.com (2603:10b6:208:3c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 21:34:39 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.024; Fri, 22 Nov 2024
 21:34:39 +0000
Message-ID: <ef1ce9fa-7616-4763-b31c-1b5c3a8a7360@amd.com>
Date: Fri, 22 Nov 2024 15:34:33 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 20/26] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
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
 <4ec00fe60cd42c1f22c98c9f5c2f5d3ceb9f8d58.1730244116.git.babu.moger@amd.com>
 <79b8049a-b213-4d86-a021-cfd9f7389f5b@intel.com>
 <3d32c528-24fb-e701-a70b-331d1a04493a@amd.com>
 <d9571277-5d1b-39f2-696b-27000cd8fd3e@amd.com>
 <c6f4bbec-0188-4855-a57b-fa2bf1e1b731@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <c6f4bbec-0188-4855-a57b-fa2bf1e1b731@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0220.namprd04.prod.outlook.com
 (2603:10b6:806:127::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN0PR12MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b6128d-47ce-4a28-22dd-08dd0b3d77e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHVZY05HNTFmM21RNUp1ckpLOTFIODZONmduUXRJVXFTZGpzUHJxU3VUZHVs?=
 =?utf-8?B?eUdmYnQvS29rQ3pLcHpJUzRHTmpEQkFkNG5nNnIrb3lFVE50VmMyS21KamN0?=
 =?utf-8?B?c1R5K1ZyN2RqbVVsdjYzOWV3UC9ETFl0RDNPWUJmS2hMa0Z3TEo3MDVybGQy?=
 =?utf-8?B?bHFVNTFTVEUzS2MxbjRCMEtEUzZsS0RaVmtyRFhzc1RjRDg1Vi82eWNQb2do?=
 =?utf-8?B?ZnJ3SXY4S3JBQklBZ2dGVnlSbC94eXBkcnhkTDVyaVJNVStuQlZxaVQxN1B6?=
 =?utf-8?B?aEROK21lNmV6cVgySDQzWVY3TWpzUVBhOXAyUmxOU2pURnMzN2hvd3lSN2oz?=
 =?utf-8?B?S1pwK1RCVXk5SHYvNWtmRE1UM3JWcVhneUUrWU1FT2h0QmVTSEw1Ti9oYjVE?=
 =?utf-8?B?OGxZVDFVQzE0V01ZK1hwWkNQUDZRUEJEN0tJZzBCTVZKaDd6R1lsWkJwRksr?=
 =?utf-8?B?dmQxcE5KR3h2THF1UkFCUlN1Nm5PUkpGbUlFNUxxUmFwVFR0MU9BeTZQOEsx?=
 =?utf-8?B?c1ZEZmFlUytOZnliQWFLSytXSXF4RkZtcFV4bWMzdlNHTHdTNFlvWlgyMExn?=
 =?utf-8?B?dGhFL1ZOQnNVT0Q1azBNSFoxWUwwbkdUOUdWT2VTd1hSM3NOa0lsVWJYN2p2?=
 =?utf-8?B?aEU1UVQvd0cyYmxhZ2VHUHJFc0N1ckE3K016NERQcVJlblY5UkRvNlpCQ294?=
 =?utf-8?B?UlkwampMYkkwL20rS1pIa2YvZ01DcVpqK0Erdi9mZjVuN29KWlJpM2RNN0J5?=
 =?utf-8?B?QmhQRVpXOWxxekNFUi9ZVzNpU2l1ckFnN0U1T1NCR01xbkRIZVliQ1VnVWtZ?=
 =?utf-8?B?aS8xZlpwSzlIWEpDY2hmM3NBVlcvRGM4MnQ5YXZFOHROSWNUbzVmb3plWlZm?=
 =?utf-8?B?dW9pcVBFa2hGaGhHeXRBUlpKTEFTK0dCbUNpMFd6REt2VTdxZmhHb0NvaEdL?=
 =?utf-8?B?N1FveEtERGhKRmNXbkVLUzRpZUhWUk9LUVVMUmU2U2NsMzJ5dHlmVnBXMHht?=
 =?utf-8?B?a3lzSnhrQy9wRy96WFFySHJzQjlWN2tRQm9LcHo2OXZzajBuNTFybVZ1aG9l?=
 =?utf-8?B?TWpsdlQrL0tyejFGV1Ztc3R5OWpoZzFhSlZzYXZYL0VGVTZnSlhhUHR4VDlD?=
 =?utf-8?B?TGdxMTUveUZqQzBpUm1uMmloV3ZKeUNHSFJmMHlWbzNTaWpDZ3dyOWJPMnl3?=
 =?utf-8?B?RnBpUmMxWklBTlhXS2s4S205OUQzU3dRbW9UcGZmbmtGNms1U3VKNzFrZTJZ?=
 =?utf-8?B?ZFdZMmVFa2pVZEE0dkgxTHN6NFhxa3BGSU84dWUyeEsvQjlDeGUyeUY5ci9O?=
 =?utf-8?B?YmViQysxZkRCWllKdGsyQWNXNGl3aWJFVTRCMnJleG91QlVxOFlhSGtldjRh?=
 =?utf-8?B?Smw2VmdhQ1VmY0Y5cXR6eDZsL01vZWZkSjR4eWYza0Z3RkZMWGdyZUZ6L011?=
 =?utf-8?B?YjducGZWSTJsYkUwUU9DdmZxdnByeEpQY1NjSVJ0cjdGSVY4SW5lS2d2MzlD?=
 =?utf-8?B?eUlKdDB4RmVQN3NKcWFVTHJWZnRMZGZvcis2bDFtWGhzMFlBZGx1OUlsZk1j?=
 =?utf-8?B?YWRJV1VxVytlYXoyNTdIUzV4YTVoT3k2eXR0MUNXNUpNYjRiN29kTGcvWGxa?=
 =?utf-8?B?d015bDNMWnh1cExrT0wxZkFobnZLenJEQVdYQTJWOWFVTEtXUXJRTEQ0aVFn?=
 =?utf-8?B?UjllVXYyekNHRURUWThkc2d6Y3RmRGRhYUl0V3BzbTZYL1M1MDJNeDZnUkts?=
 =?utf-8?B?TFYyQXVmdzM0eGFNaUs3QmxiN3hQSjVBVVNwVjM0SkxmaVZKdUU1dmtPM0Y4?=
 =?utf-8?B?R2VoOXhTYUtzU1QvbEF5QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elE4K0RnMy9kN0lQT056ckEvTnZtWmxtanVnNG5OdGthd3RkZDNrRTVrVUpX?=
 =?utf-8?B?dDcwRnN4aXdoa2RINVVEa2RiRnJlTjR1U3RucVpCa2dwL1B1UEprYkkrSDJa?=
 =?utf-8?B?Ylk5OUJJNUFxa0xhQ3Erb2ptaGN4UUw1dm9LUVk4cVJkLzBWbUxKR2pFazNE?=
 =?utf-8?B?VG53alNqTjdYeWErQmhDVEc3SlhHVnI5WUowcHZPVFFnT0pnT0NxaU9Qc2xn?=
 =?utf-8?B?TWxLNUQrc1NxdU5UbDdhSzdCWjY5OTJGakpGVnpaelRQUlg4aVdKK3V3UjNi?=
 =?utf-8?B?emcyem9mbTlSeG9YZkRiOWFuZ2FUOWhEampBdmM3T2RwR1plbVZnTVhPcnQr?=
 =?utf-8?B?MERta1ZLT0ZIR3FCbm9hUTkzNEJ5Q1BnOXFZNTRwSlRYMmgzdVR6Z2s4bkc4?=
 =?utf-8?B?bHdJQ1dzMW1tOHQ0eVJCcnhyRVI1QWErWGZSM01CYllaYXB3UFJBMXdJMWJl?=
 =?utf-8?B?WGphMFJLOGFIQTZhNndhTjY3MHNqcHl1VFF2WndYVUtFVnRRSkQ2TEE2Nk1G?=
 =?utf-8?B?WUYrdW5MU2FVaXAzR0Fqa1owWEV2QSticjU0ZFRsS0gxdUozUHI1TnZoVjhu?=
 =?utf-8?B?dmpPd0d0K3VRaFRLbG9iWmFzcTZ4NHFNbzRMdXg0Yjhzcm1HczRuU3dSUS85?=
 =?utf-8?B?ajlJR3UwRWFGMExzb01IQzExY25VZEtZMGJMbWxuNk5HV2haL2lCWC8zeFlJ?=
 =?utf-8?B?T1BzMk5VVno1eTQ3SGx4d1BWMUtnYnEvSzJWanZ6YkYzam1SRWdBYnFaUmpi?=
 =?utf-8?B?Y1hHZHdpZ0RkRUU4V0pTMUF3TE1jSk5OeVRHNXkyQ0toTVN0c2FYNWVIcEpi?=
 =?utf-8?B?bmxBMDNCb3Q1Z3dOUWdHclJGY3lzNkMrejc5dUtobC9ob04zZlpLVnVleU0z?=
 =?utf-8?B?UEVwRTVqclA5ZnVhbzBTeVpudkxvdlU5TllRV2gzckNwczl5RU0vNFRjNkdo?=
 =?utf-8?B?VXNHQnBsckZlL25qQTNKSDFJUFlDWDVOVlJ3a2k3WlBmY0dPOEh1YnY3N3Jk?=
 =?utf-8?B?RDVkVVRpeE1neTFHTW1OSVIwYi9qK0E3YlBwdTI4Nm9uM2ZPWk1uZmwrK20r?=
 =?utf-8?B?MFlzVy9nWFJHMER5RGRpUnVpbXhMTHR4R1cxVGJTT1QrTUVVdkNYU1lQUnFo?=
 =?utf-8?B?M01mekE0YkMxcGJzelpYeTdDYmwrN1RlVU1YT3BVdFYvaWEwYXdZS0lxVmJv?=
 =?utf-8?B?VVkyWkc2eDJMRWtsRkJCR3FzRVVaUjljc3ZHN3Eva1RIN0R0d1ExWXQwR2tp?=
 =?utf-8?B?L0JjUjBmeFZqWG1rdkFNV1BYd2phVTRycy9laUtIVnRCSG5iY2NVUUUvVWtQ?=
 =?utf-8?B?MnpONVJ2L2tGQzJBekF4aHdkR2FPVFV6ai9sc1JTVm4zZVdCS1pBVTNtNm9O?=
 =?utf-8?B?eXgxU1d0dUhKaUJuZ2ZsRVAvRkdrcXdyeFVhayt1R3JqaFJoSEJqRzMxeVpC?=
 =?utf-8?B?QWNxZkRzNjZRV1gyV0E5aUdrYW1tZ0grR0xjYktMZGJRUSszSDlubC92YXlu?=
 =?utf-8?B?V1grZnpRaCtja1RqWmNRNjNDOW5lTEIwMUQ5YnZFVTBzRGdSb2JwSDkwaHVD?=
 =?utf-8?B?R2l5cVpNVE1tM3ZjZi9od2FOQytETE5ldkJQR3B3dU9mZmVGSGplZ0U4cG9z?=
 =?utf-8?B?RWd6bzVvbERraytaNzkzbTBVV0U3YU9oNHUzQURIa1dZbHZEVUZzMWcvYTU3?=
 =?utf-8?B?MkpOVjk1TnBMblpOWjVkVXM5Q3NqL08yTHdDNUV2V3N0YnNsY0RwTVdCeHVW?=
 =?utf-8?B?K0NTck9YYTNvMkZlbkx3SUZFeGxmRmg5MUZyM2h2ZGlPUkQzS0lrMExvVi9S?=
 =?utf-8?B?TUR0bmh6MmszTGYvUXZZeUwwYjUxLzlNQk5tdis3ZFBQTC8xVDIvM0N4SGhG?=
 =?utf-8?B?cVBCeFd5NStZbURyb1ltbG1VQ1VwYlBGNWNaMGlUZWVWUmJ2VUo0eFg3dmc3?=
 =?utf-8?B?Y1ZRYVQybGVxNmRpdEc5bDY5UEJkU05nUXJJYjRUcjVtVXcwZlNLcDdHSzVY?=
 =?utf-8?B?Z1p1bFk5M1FKR1NWeklHcUpZWk1VclE3ZWtkTUE0NGducEFiODRkN3FLQWhw?=
 =?utf-8?B?VzdXRWMySDYwdnZPeHl3NUcwWEtEMmJTRlNtNGFLU0ZiMzErVzFTL09FUkNJ?=
 =?utf-8?Q?Y16U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b6128d-47ce-4a28-22dd-08dd0b3d77e8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 21:34:39.0933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8S6+nhfx5AbKwsKEZT0wrYflnLrLgjSKtpNIqNeson/0QgivMRdupDKqxR/ypWOq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6127

Hi Reinette,

On 11/22/2024 12:12 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 11/21/24 4:26 PM, Moger, Babu wrote:
>> On 11/21/2024 6:22 PM, Moger, Babu wrote:
>>> On 11/18/2024 11:18 AM, Reinette Chatre wrote:
>>>> On 10/29/24 4:21 PM, Babu Moger wrote:
> 
>>>>> @@ -3871,6 +3920,8 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
>>>>>            goto out_unlock;
>>>>>        }
>>>>> +    rdtgroup_assign_cntrs(rdtgrp);
>>>>> +
>>>>>        kernfs_activate(rdtgrp->kn);
>>>>>        /*
>>>>> @@ -3915,6 +3966,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>>>>>        if (ret)
>>>>>            goto out_closid_free;
>>>>> +    rdtgroup_assign_cntrs(rdtgrp);
>>>>> +
>>>>>        kernfs_activate(rdtgrp->kn);
>>>>>        ret = rdtgroup_init_alloc(rdtgrp);
>>>>
>>>> Please compare the above two hunks with earlier "x86/resctrl: Introduce cntr_id in mongroup for assignments".
>>>> Earlier patch initializes the counters within mkdir_rdt_prepare_rmid_alloc() while the above
>>>> hunk assigns the counters after mkdir_rdt_prepare_rmid_alloc() is called. Could this fragmentation be avoided
>>>> with init done once within mkdir_rdt_prepare_rmid_alloc()?
>>>
>>> It seems more appropriate to call rdtgroup_cntr_id_init() inside mkdir_rdt_prepare(). This will initialize the cntr_id to MON_CNTR_UNSET.
>>>
>>> And then call rdtgroup_assign_cntrs() inside mkdir_rdt_prepare_rmid_alloc().
>>>
>>> what do you think?
> 
> Taking a closer look this seems most appropriate. mkdir_rdt_prepare() is where the resource groupreset
> is created and all fields initialized, control and monitoring (irrespective of monitoring enabled).
> Doing the MON_CNTR_UNSET initalization in that central place seems good.
> Yes, and then assigning the counters in mkdir_rdt_prepare_rmid_alloc() sounds good.

ok.

> 
>>>>> @@ -3940,6 +3993,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>>>>>    out_del_list:
>>>>>        list_del(&rdtgrp->rdtgroup_list);
>>>>>    out_rmid_free:
>>>>> +    rdtgroup_unassign_cntrs(rdtgrp);
>>>>>        mkdir_rdt_prepare_rmid_free(rdtgrp);
>>>>>    out_closid_free:
>>>>>        closid_free(closid);
>>>>> @@ -4010,6 +4064,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>>>>>        update_closid_rmid(tmpmask, NULL);
>>>>>        rdtgrp->flags = RDT_DELETED;
>>>>> +
>>>>> +    rdtgroup_unassign_cntrs(rdtgrp);
>>>>> +
>>>>>        free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>>>>        /*
>>>>> @@ -4056,6 +4113,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>>>>>        cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
>>>>>        update_closid_rmid(tmpmask, NULL);
>>>>> +    rdtgroup_unassign_cntrs(rdtgrp);
>>>>> +
>>>>>        free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>>>>        closid_free(rdtgrp->closid);
>>>>
>>>> There is a potential problem here. rdtgroup_unassign_cntrs() attempts to remove counter from
>>>> all domains associated with the resource group. This may fail in any of the domains that results
>>>> in the counter not being marked as free in the global map and not reset the counter in the
>>>> resource group ... but the resource group is removed right after calling rdtgroup_unassign_cntrs().
>>>> In this scenario there is thus a counter that is considered to be in use but not assigned to any
>>>> resource group.
>>>>
>>>>>>  From what I can tell there is a difference here between default resource group and the others:
>>>> on remount of resctrl the default resource group will maintain knowledge of the counter that could
>>>> not be unassigned. This means that unmount/remount of resctrl does not provide a real "clean slate"
>>>> when it comes to counter assignment. Is this intended?
>>>>
>>>
>>> Yes. Agree. It is not intended.
>>>
>>> How about adding bitmap_zero() inside rdt_get_tree() to address this problem? Also need to reset the cntr_id in rdt_kill_sb().
>>
>> I meant reset the cntr_id for the default group in rdt_kill_sb().
> 
> Doing the cntr_id reset like this matches the custom is to reset to defaults in rdt_kill_sb(). I am not sure
> what you envision with the bitmap_zero() in rdt_get_tree() ... I wonder if it may not just be simpler to
> call mbm_cntr_reset() from rdt_kill_sb()? This does raise the question if mbm_cntr_reset() should reset
> architectural state. I do not think it does harm, the state will just be reset again when the mon dirs are
> created?

Yes. Calling mbm_cntr_reset() from rdt_kill_sb() seems more clean approach.

Architectural state will reset again when counter is assigned(when mon 
directories are created).

thanks
- Babu Moger


