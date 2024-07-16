Return-Path: <linux-kernel+bounces-254153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA220932F90
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF5E1C22786
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0B41A01A6;
	Tue, 16 Jul 2024 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MJZ2Md7v"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A12A1A01A7;
	Tue, 16 Jul 2024 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152807; cv=fail; b=QrdFByedaG5Uc2wOXQC+/6T+IbeBNlg5CMLWK01J4zTt9txoyuBffe0e8JiW8szvorodP2/TcTtMLcm7mmN2bd1lyMh6hXlTzO1L/KqYjH+uCJ2H7Vaap2YbhBE1dkVHZZH5+WA9gW1CjQ+T68fU9ttzPqwFQUIqxUTe+cpGcyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152807; c=relaxed/simple;
	bh=J69Ye+PhDQLPsU6oGx3HUkb0o7qK8Vfh99ZnajbNxAU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xsu9ZVJNXBk2EBomL4VkA6ZPdaGVweqm73OSGyDAuyDuglhwu2lDb15It3TAJq/f85NbwPqUow4SSboB/ERltFM0TD1VQsmONOkVh03GCRKSNQDe0wi12/7lxleM8C7i26umbv5V0+cWXIkLeau9MLWAsJmS/IsiO/rR9i/4L9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MJZ2Md7v; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qe0H+9jvmDZ90TwwGUi7M/wnBnXQ5vhDo9vuSVRFbGQhG1DEh7PwbaWpcrwv9hPDg1Ry/oWBjE3waFma/TSAXRifpjSJ/QnYSdgJ1AQggd4IzQDH6qXD2aYwWSzRfmYIo2y1QQXUV7zxv1aT4uNGh1OtWfNeEUo0ZGoKSiPNuoq7lS96XM4vqtYi/N4evlm2A+OW6wwgvYFGZEOmq12wVaYu9KxsIyQpXZxKqU/NdxXL4FNOZGgzwD7DKaKbFJSUfiVWZ4AD1apE0COX2PK2QtG+401CQgDoBZIdL3O+UxEKbOUMFVyrfjPl6vNWKLp0wWrqS9mL7mspGhYXtz3BwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkcZx1T33vooihgiblQaO4+slO1zpPY91bg70hSSFW8=;
 b=EokS5JEnEihSs87FKo5qiXrsfDyk1f9EBWoLB5dI8i2bYwSB5nlSaRSpHcJlybZhTPn38Oivwk6jVuTKcGjpsD4E8dl4s+HL2m2YS18LYR456WabeaFqT9kyNjQgOgcw5ZdJwsQTLi2Wt5Vbmui6fsXrBvMZRqpyPVVgop+v8twmIcmKGjf8/UjIAMuD0ZaDWcyE5BHSd2oFFH6Czpvfc4tYg0ColYVujrgBxTfE9eeHsNLBzPtNwu3iRjrUYTDMt72m9Oir+5MUkxAit+yM9S5CqRgWUQQHTt/cWvawQs7zphBaK87DQpMlo/K5kHlD5sRTCbp3WvSL52meTUx2tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkcZx1T33vooihgiblQaO4+slO1zpPY91bg70hSSFW8=;
 b=MJZ2Md7vYzY3Ou6IooWnaQpbDkcsb/8YMfH2rG1ll8xLEZqQve0ysboyDA9VRFOz0hnJM7IeLtxsTreCAOxU7QlHPxPIz2t3ogMgmEWAQEvROUwUdWM9TqWYeBBLGj1LG8PQ3D8NIyyKd4HPEAFNUQAM3Eej2qijlZXFFsxjeBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB6695.namprd12.prod.outlook.com (2603:10b6:510:1b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 18:00:02 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 18:00:02 +0000
Message-ID: <d28753ea-6e2f-46b3-8fd3-5b66799b76ca@amd.com>
Date: Tue, 16 Jul 2024 12:59:57 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 09/20] x86/resctrl: Initialize monitor counters bitmap
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <28866653751deb8405f575e40df6f08affdb25d6.1720043311.git.babu.moger@amd.com>
 <75e18bbc-306e-4cf9-841b-a261fb62fe42@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <75e18bbc-306e-4cf9-841b-a261fb62fe42@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0062.namprd12.prod.outlook.com
 (2603:10b6:802:20::33) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb8917b-9e23-42f7-7a5e-08dca5c11d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3ZVYk5XRXR4ZXd6aXc2aDFSQnlydVBZeE9ZelZNNlkrZGlOWXpFaXpISjBs?=
 =?utf-8?B?NkwzcGdSTGc0OThhczBCS0NRZmQycGU4TThqYktsVXFHNGQ2SFZlQWY3ekxM?=
 =?utf-8?B?Q0tTSnpUckR5ME1Henp1MTZDMGRFaGc5V1d3TmpFS0JtUmdMbnh3VlAzcTlH?=
 =?utf-8?B?bTczamlrZ3dZMnNJbFVHcEMvcmZESE1uQWNHTFMwQ2p1Rm9PWnA0cW5MNXQ0?=
 =?utf-8?B?dlYrQWVDR0ZrcE1rTlpINFVzWUkrZ3NLUDY2SG1IUkZZWGZsUlJIQklmWFpn?=
 =?utf-8?B?ZTdCemZmWnpaOW44K3U1K0NZSCtxempXRjJDWUtPN3N1aEZyNERpR3o3WmhY?=
 =?utf-8?B?US82VS9CbTFTU0t5M29iU2J4dWphT3U2WnJNUmxFY0Vuc3Fkbzl6TG9VVG9T?=
 =?utf-8?B?bFpvRlp2QWdkUnJIK1gxeFcwK3BqL1RJUTMzS21ZYXI0YUVzSTBGbUxOU29H?=
 =?utf-8?B?SGRhZVhvNlcrNmNhTUhHcWUxeDR6SmpkcFQxZ0ZBQWZJV0c0T3djSFBLbjZW?=
 =?utf-8?B?Mlh5aVluWjB5NG0zT2wyQ3BSZDlyQTRkWngvMTB3NHpYR2lSV21NVnFvUEcx?=
 =?utf-8?B?NTY4NDFuU2FXTzVPNHdLMDJzci84aENsZ0JpWlJPaXdaeFk3VHYwcDdBUnhh?=
 =?utf-8?B?SVZ2N29yeUN1dWpSWEhyYjRXV1kwR0tKMGU0RER6NFE5eC9jeVFrZy82WXpU?=
 =?utf-8?B?WDAyZ0xFVWlYeVVGMVJJUDJWNEJIbnB4ZldKSTJQOEFvSjRtWUI1U05IUi8r?=
 =?utf-8?B?Q08yZXJWbWNtZnVKc20yamcvazBOTUl1QzVMUDYwVEtNWFloM1BoaC9hem81?=
 =?utf-8?B?Sm1Eam5IM0xuTjJZbmZBcHByZ1ZTYXUxUW1kWFBtYWR5ZFdXQ0F4dTg5dFpY?=
 =?utf-8?B?U0xiNjZEQWhDbUpyZ2E1cSt1OWhYR1dadFJMQ2NNM2dydUdtZkFYUDlSc2Nr?=
 =?utf-8?B?Y21XWHRYODkrejZSSGNBV2tNVzExdGZZa0FFUDZGTG9TdlVyUW10R2hwbDVO?=
 =?utf-8?B?cTRZRWpvMlN1VHVpcmdoN2ZEZklmL1FpTmpaR0dORU1pSkFnZi9iSVV6UDRr?=
 =?utf-8?B?OWdlRk1hdmM5RTR6MHVMV1M0U3RhMVlMaUJwenR6MnFjL1J6OE0veTh4Mm9P?=
 =?utf-8?B?Ykh1WXlaTUxjQlZMRzVObTJxZjRHRG5KUlZwb0pDVzVxKzlYMmovaHRHOHVn?=
 =?utf-8?B?Um16REpqejdzRjExYkpNOHB0YytPaHlYdHo5b1RIbXVVd1FuUHpHMDViL09y?=
 =?utf-8?B?WnkrTXVEa0VaS2Z4alZqSlZkVTFudmp2OVU3eVY3VXEyQkQ1MlBISXhMTWJ1?=
 =?utf-8?B?MHFnN3FtcHFxdnQrTHNPSU54RE94Y2pTRUphT2o4Z20zbEpHOXBXYUp1KzRO?=
 =?utf-8?B?b09rOWR2U1hGV2dBeVlKdklHRDRwRTdOZmQyT2NNRTBXN00wOVVmNVRHZ1VS?=
 =?utf-8?B?YTNwekFORGdvNzJOdWF5NlRNRmtzUWRKNGJQTldpS1NSdklXSFUyZkVJV0pY?=
 =?utf-8?B?Y3B2TkxQdTlWcSs0NHZDaHU1emF2NXd4NUsraFljOWZ1dVlMZGdJblNGY0N1?=
 =?utf-8?B?WmdzQlZiL25jd2I2aHMzYXZhY0tOWjZvc3VkQ00zaVpVcXdQeFJ5VFBxT1VJ?=
 =?utf-8?B?WWY1TlJjT2FvamxXOFBraUlDdXVhWDM1cHhGR2NrY0xxcFJrRzFpWXNyckxU?=
 =?utf-8?B?bHJiN21wTGRHMTh5QkpqTUR3cVBrSk1ZQUFJQjVwV0RBamRISHVCaXo5SHRx?=
 =?utf-8?B?RGZqZ1VQNWZ4SXhSaGFWQnNkK3U3K2pNcXFNSk9lZUVEbnpzaFJRdGk5dkEy?=
 =?utf-8?B?U2FMbG8xeTFEa2w4eEFLQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU5wclViWVduNVozOUk2RkgyaER3dkExdjV4TVZIamErcEtBRGZBenFrS2FP?=
 =?utf-8?B?T0tWREpsdUxjU0NWaWhrV090RmkvOEQzKzlhcTFQQjYrR1VhSlJqZnV5cGNT?=
 =?utf-8?B?LzhJdThqaUthN3RIM1ZjZHFBZk5yaTFRWmFUMmxrNFFSNFRzMXp2WGNmUjd0?=
 =?utf-8?B?ZEN0aHpiVWRGOHBOb1VVaTJianNFakxCb2wyTmI4TTdZbnVyUUdXcnlSSU9p?=
 =?utf-8?B?bmY1TU5YOHI1NzlTNk5jbjR5djVYUHkwbUVjVWVBd2EySmpEZE8xZzhNcDA3?=
 =?utf-8?B?dC82emZ3cGhxcytvZXZsMHZ0UFlOVVp2Z25vMlhCeUpOSjNVeXhqOHc1UE1C?=
 =?utf-8?B?TG9Nam0rVlVhSlE2QStpSVczem5KbDZQRXpTTExKVDRxQmdzenR5TWJEMkt6?=
 =?utf-8?B?NU4zZTZycGhMTTB6QzRNQXZURFhnM0ZOSWJNU1dBMThyNWlkdjdPaE1sRTkv?=
 =?utf-8?B?RDJMOUp1MzdkNHd2S2V0NmNIeGgvUm13MHRIYXJ5dzErU2ZFa1ZMamxYRktW?=
 =?utf-8?B?TFMreTEzbE1CNFRma1BsckJFMVhYNWRHOW9nZWlhNnFzMllqd1YzclI4Nk1Z?=
 =?utf-8?B?RXhkYnRFMS9LNzBFWUdoVE5jTWhhUmM2QjBDTTBCMkE5K01pTjBaNWdXUjA3?=
 =?utf-8?B?QlNNMjJHdjg3L3JIZ0c5TDQxUU1VSkVPb0plQ1FDNGwvVURUMFZxTnlzNmxi?=
 =?utf-8?B?dFN1d3liSUFYOWVYQlBWSTlydWloSFJVbXJuODc4Z1gwaGtjbkZuR3h6elR6?=
 =?utf-8?B?eHN0OVFYNmpMZjZKc1puRXZUTGNFYjRxdmNtZHdVS29QWXQ2YlovaGRCZXhh?=
 =?utf-8?B?cWRZR1V3aHp5a1lUR1F5djVEakhrMlhubVJDUkwrNXpSY1JmV1FQRVhyWjBq?=
 =?utf-8?B?NjlwaWk3UUFBTHVFOTRlV1hqaS9LTk1heENRNG80ZjRiRnNqN2tjZUZWbzZT?=
 =?utf-8?B?ZTJNckp3RjJJbjNGNDBjQytWYzIyMGNmOTV1VFFKNldQS2pmTFB6VUdFaHl5?=
 =?utf-8?B?bFZaTzdjOS9FckdKNHE0NnlaTDRkMmZRNkk2U0tsd3JCdzIzQ3dFZE1iSnFx?=
 =?utf-8?B?a3h3Smcvc2Z0SDlCZWJRbXBVR1Y4aUJVdU5nQzJtMEcrWUZYclZicmtqcWds?=
 =?utf-8?B?dnBVVnJWR1B5eVFJZThISmpMKzhKSFhxemVnZlJyQnhzQ2Q0ZzNvdXhaYVJR?=
 =?utf-8?B?MnNvWmpreks3NFN5N21DMGxkUWVRUG03UTB4Z0luenE1cTlNUE05eDZHWEsv?=
 =?utf-8?B?WXd1OXFsV3pGUFhRT2xsSHNTR2Y4U1h2L1l3L2V1b28ydDI0MktlOXNMc2dB?=
 =?utf-8?B?TTFlNngvOXBiek9zY1k2N3gyY3BveUI5YnYwT2RncUsyQVExQ0xyYlNHV3Jn?=
 =?utf-8?B?cERLVHZpV1dEMkY1VHdFc3JrWTJnczNSL2NiNmRFclVlMHc2SmRrRFlNNXBW?=
 =?utf-8?B?enJjTnRCa25EMjJIdHg0dlJ1ZGk4M09UUWgvenF5QS8yZTRGVmhULzdDa1hH?=
 =?utf-8?B?dngyMDFQZjg1RHVJY0NlQTNUeWxxTVpPTEhHblJaVHdRUDdQTjY5M2wxaXl0?=
 =?utf-8?B?U01QT0I4cDRNNU1Za0pyNGx6R3ppNzRicSt5T0lLai8rbXVTVW1rVWlOZytT?=
 =?utf-8?B?aGU5SVY4UThVcWpBenJOZmo3c1ZrOUZaSy9GS0xZOGVtRDl2RUJ4Rk1vVWJw?=
 =?utf-8?B?TmZUdGhoTkJNdEJnb2hkeHpQUDE0ZmZMdzJJQ2tJcXdZUGZlcnVmMmk2S0hq?=
 =?utf-8?B?WEhNR2lkYm5wanB6Mm5qOFJSVVg4N3VYS2UvRlJqZGp4cUdLUnVkL0JzbjU2?=
 =?utf-8?B?MzhhNTlFdHduZ2tEWGVpSGRFWVRvaU9FQkk5WGtNMEwvZGtQNzNSL0tPZDdT?=
 =?utf-8?B?MDdaQ1hnMERtOUdHZHk0VW9QcUo2Z0EyNVNObkVxbGl4SHJzUnJkY0hudEQ1?=
 =?utf-8?B?Nk5qdzNQQmFXWkwvUDJUR0c3QW5RTG1EcHNJZ3QrRnlieVpZUTJYZ0VVY2F6?=
 =?utf-8?B?RmNCYlBuREkyRmprSlYrUkRxanprUWNHWXI4UnJCSWQrNHBTYzBpdUR6MkZZ?=
 =?utf-8?B?RVJYczgwcFZkNTd3UFVFbUxEUERNQ09KcGdsQ2ozYXh5eTlaYkVNQ2pJU2dp?=
 =?utf-8?Q?cLxE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb8917b-9e23-42f7-7a5e-08dca5c11d4c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 18:00:02.0272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdE97IekgKAvzNHt1g99j5n09G6mPZqzUdM+P86nbw693/CmU9znFbmpyZl6wKbh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6695

Hi Reinette,

On 7/12/24 17:07, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/3/24 2:48 PM, Babu Moger wrote:
>> Hardware provides a set of counters when the ABMC feature is supported.
>> These counters are used for enabling the events in resctrl group when
>> the feature is enabled.
>>
>> Introduce mbm_cntrs_free_map bitmap to track available and free counters.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v5:
>>    Updated the comments and commit log.
>>    Few renames
>>     num_cntrs_free_map -> mbm_cntrs_free_map
>>     num_cntrs_init -> mbm_cntrs_init
>>     Added initialization in rdt_get_tree because the default ABMC
>>     enablement happens during the init.
>>
>> v4: Changed the name to num_cntrs where applicable.
>>      Used bitmap apis.
>>      Added more comments for the globals.
>>
>> v3: Changed the bitmap name to assign_cntrs_free_map. Removed abmc
>>      from the name.
>>
>> v2: Changed the bitmap name to assignable_counter_free_map from
>>      abmc_counter_free_map.
>> ---
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 29 ++++++++++++++++++++++++--
>>   1 file changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 4f47f52e01c2..b3d3fa048f15 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -185,6 +185,23 @@ bool closid_allocated(unsigned int closid)
>>       return !test_bit(closid, &closid_free_map);
>>   }
>>   +/*
>> + * Counter bitmap and its length for tracking available counters.
>> + * ABMC feature provides set of hardware counters for enabling events.
>> + * Each event takes one hardware counter. Kernel needs to keep track
> 
> What is meant with "Kernel" here? It looks to be the fs code but the
> implementation has both fs and arch code reaching into the counter
> management. This should not be the case, either the fs code or the
> arch code needs to manage the counters, not both.

Yes. This needs to be done at FS code.

> 
>> + * of number of available counters.
>> + */
>> +static unsigned long mbm_cntrs_free_map;
> 
> With the lengths involved this needs a proper DECLARE_BITMAP()

Sure.

> 
>> +static unsigned int mbm_cntrs_free_map_len;
>> +
>> +static void mbm_cntrs_init(void)
>> +{
>> +    struct rdt_resource *r =
>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +
>> +    bitmap_fill(&mbm_cntrs_free_map, r->mon.num_mbm_cntrs);
>> +    mbm_cntrs_free_map_len = r->mon.num_mbm_cntrs;
>> +}
>> +
>>   /**
>>    * rdtgroup_mode_by_closid - Return mode of resource group with closid
>>    * @closid: closid if the resource group
>> @@ -2466,6 +2483,12 @@ static int _resctrl_abmc_enable(struct
>> rdt_resource *r, bool enable)
>>   {
>>       struct rdt_mon_domain *d;
>>   +    /*
>> +     * Clear all the previous assignments while switching the monitor
>> +     * mode.
>> +     */
>> +    mbm_cntrs_init();
>> +
> 
> If the counters are managed by fs code then the arch code should not be
> doing this. If needed the fs code should init the counters before calling
> the arch helpers.

Yes. We cannot make this call from here. I need to move this call to FS
layer before coming to this code. Thanks for good point.

> 
>>       /*
>>        * Hardware counters will reset after switching the monitor mode.
>>        * Reset the architectural state so that reading of hardware
>> @@ -2724,10 +2747,10 @@ static void schemata_list_destroy(void)
>>     static int rdt_get_tree(struct fs_context *fc)
>>   {
>> +    struct rdt_resource *r =
>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>       struct rdt_fs_context *ctx = rdt_fc2context(fc);
>>       unsigned long flags = RFTYPE_CTRL_BASE;
>>       struct rdt_mon_domain *dom;
>> -    struct rdt_resource *r;
>>       int ret;
>>         cpus_read_lock();
>> @@ -2756,6 +2779,9 @@ static int rdt_get_tree(struct fs_context *fc)
>>         closid_init();
>>   +    if (r->mon.abmc_capable)
>> +        mbm_cntrs_init();
>> +
>>       if (resctrl_arch_mon_capable())
>>           flags |= RFTYPE_MON;
>>   @@ -2800,7 +2826,6 @@ static int rdt_get_tree(struct fs_context *fc)
>>           resctrl_mounted = true;
>>         if (is_mbm_enabled()) {
>> -        r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>           list_for_each_entry(dom, &r->mon_domains, hdr.list)
>>               mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
>>                              RESCTRL_PICK_ANY_CPU);
> 
> Reinette
> 

-- 
Thanks
Babu Moger

