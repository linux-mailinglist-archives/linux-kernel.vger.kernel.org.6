Return-Path: <linux-kernel+bounces-295970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 782AA95A3C3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3DCA1F21669
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDE51B2ED2;
	Wed, 21 Aug 2024 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GxzqjNcv"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5651C1B2EC8;
	Wed, 21 Aug 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260834; cv=fail; b=hKi6toGyrpibSlPin4XtyphqKx58wxtUuBFpwcMjYIHDtHqPztpeOHzmGB0Oh5fiBOyvol6KPqqQMAFh7U1273sQ9v8smiju1CI/b2A1PIgbp+WuT3mXeT1ENBXCBschmEw2GKQsd4PEBvThJROLmKfoJ8WDONbhAeh7kQfVSM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260834; c=relaxed/simple;
	bh=RL1YikwWcGN0Fw+rHiP9+1rleRKZvkVevyWnzq18onU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q+LbeWD/mG8p4j47ciQfJ4mr2u6o7gnnxptAVXJEoPjF4l2fgM6wfrdvjVgTRtpIH9JpB/u5CJQL2iRfLEls/hT5sURlkGxS73sf/YJAxgW9mV5q7NUQj4tacnGxkT4yOFANuYZAID98tyhYvYXAd4YE+35qeVeTKb+rHS58ZkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GxzqjNcv; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VW9yXEsy8qThpkkroFmylbil23JUc2Ld69QK4QcfEdNOBTB7qffTKtIE6KHWrSRgLZvKlQLW7POW4/rz7Zq528LmjLVPkFEM3Dxo5yaaaHxJ+rQB8TfePnM/da5qpNaCvOvJBeww0VuMdT1EidN9ujJ9W2P9itUeVFGKTugoivCZgGrMHP9LQvuWwzddFDZV8NTg+qUxbA9/H2Uii5WAju0ah/SLvTZ/hqXZhZL0+Dw2l0Ggyc2Y8keAXBCEK1FwBXXrKFKVXPnvbgqBTigv6s7XqTxnQM8ZRxm5Ks6pNX4Nzk2mdD++TMrG2TSaDUNIgu9SdUyMI85d6QcS8c9SsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hu8XBHlQgDVDorNPvRILbJ0GbeI7MaBERqJmEf+PR/4=;
 b=ked7gxw7kP0xwxC+70TNmoopsZ2JPD1GuTQAghZ0U7Bw9kA/ekWrWt8DUZ87twJzR3ezNob8+PD8ENVojCvsB3o0TNGsq4evvWHuAIqLYWDIFYocWtWunBBvEerzhWSoFXyFISZ8IrXMKEPAYgeO72PrsbrhttzL+7BA2AbCcuH7aQLrareV3Dr82xBGHzRzO/3k9eKg/hnDfRFT8mHP7imXR+8gF0s2sMvZjU4yfxt3rZqOvSr4sKMML766uoKcXU5j6sVm0GCYH+Vw9LMeXMHNciB5U9XsRFXLQIgvjUtCFbmgVdGAr/KYx5ZQ1pCj+PJcCs5CYUySzV2mSDLh7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu8XBHlQgDVDorNPvRILbJ0GbeI7MaBERqJmEf+PR/4=;
 b=GxzqjNcvR78/tFxdB75EOIQYKxw7w0xmY1/+cbphOpyYoV9WogsgjL6a0KqPxbptnPQZHnVE3LP+u8eKBbgUrv3/VwdwohVvLrO9bGM56q9sVMR44HjiG0JlA/94gJm51VWxtveersAq0qV7ct0eIUdKI9Wp3Raj9UWwTE5ftTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.27; Wed, 21 Aug
 2024 17:20:28 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 17:20:28 +0000
Message-ID: <f505b25a-8299-48fb-b508-64037937cb52@amd.com>
Date: Wed, 21 Aug 2024 12:20:24 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 17/22] x86/resctrl: Assign/unassign counters by default
 when ABMC is enabled
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <48e7516ccc04715d4fd6678cf00a99ccf43fba10.1722981659.git.babu.moger@amd.com>
 <6d2dd646-49c0-4d7a-90da-10919f617e77@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <6d2dd646-49c0-4d7a-90da-10919f617e77@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0049.namprd05.prod.outlook.com
 (2603:10b6:803:41::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: 1826b998-2c80-4545-df56-08dcc2058d49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlNISXRCRjR6L043eStvYUFxeE83Qnc3MGhGU3lxYTErMFdXajdkRmdFSVdU?=
 =?utf-8?B?Q3l5SE8yUlNpZWY1L1lGeHBpN3pGMStldFpZbk4xS3d2T1lkNlNQMUt3Um9q?=
 =?utf-8?B?blZFa2xvMkJRNnZYV3JnRGIxSFNlc3owN1IybEkvaThPai9zcU5QWjVHcTRq?=
 =?utf-8?B?NG05Y3ZjbExsWkYzaXlDTVZqSUwxWnpjYmIyT2NaZWhaV0VpaVNyTWVwb0ph?=
 =?utf-8?B?cVQ4MHNidE55cWl4QVZZczNLWk8xaGNBbFZDNzdnK3h5OUZPVjNIZVVxK0lK?=
 =?utf-8?B?UU1YZUdVTnlielM5Z0I4RWNzNHNCdU5kdTYxaEp4MlFxTWxaSUpYS3pKdjQv?=
 =?utf-8?B?TTduOTRwLzVTZEtWRmowSHh1cWdkMDJ6Tm1ZMkl0SU5mUG5ybG8zSm1VOEp6?=
 =?utf-8?B?bkdBYUpRZmdFREtkZGY1eGIxY3BuYW1ROWF2TTB4djgrWnlJZnU1am1lN0JD?=
 =?utf-8?B?UkRtbXV2aHJBNkNDME9ybUdmUm9LUDRkWUpjN04wUlNSaDI0UFZmK09oQ2NT?=
 =?utf-8?B?djRFTHgyUkJBYlBtYWQ1WDJ3SWZBVlRtLzBHamc5djdXY0RFZGlieHI2eHFn?=
 =?utf-8?B?ZXBjcnQ5MXNacmpHQnU2eHJHZFVRN2N6NEhoT2U5WmVObWt2K3hmK2R2cVQ3?=
 =?utf-8?B?M2VndFl4TkxpMURJWUVuUDczTFhkNEw0UGtuTmt6VERFeTYrUExRaGhPNE9H?=
 =?utf-8?B?aTRGaUttcXBzbktsZm9GYUt5elYwOXhJOGIrZVNzNmowb1paNDNMbXpTVVhT?=
 =?utf-8?B?RHRQdHJHYmZvNDFFdS9pTzZEakV4bk9HditqcURuTm1UTktEVW1HMzhUdXRW?=
 =?utf-8?B?TStnbEtMdUNGa1Y3TEoydzBENUZrZzJLVVl4L3N1MXg0WnFzUmtwL05NREZP?=
 =?utf-8?B?ZmpIcmdKdkJtQ3VkdlJsaHR4QXBMa2RVUzUzaVVzcUtQdzUzNDE5bEh1czZO?=
 =?utf-8?B?bFpIRlliczV0czlid0JodXdydWNUR0tKenBYYXJXbkZlTFczNGszTG5WNkIy?=
 =?utf-8?B?SUpQdHAweDlKMk9wVWJ4c2xOYWZqM2o0QmwxaFlNSnlYcjJjVVRWMTZkMUpI?=
 =?utf-8?B?eTBPRzNCWkJrNGNEQloveDBFQXhKTDk1VEFyRmltckFlN3gva0tWV0FkcTdi?=
 =?utf-8?B?b3p3MmkvemVMWm9oSGRvNVZ5VmtpRFg0Wm9zZlZnVWRoTlRTeDNkUFVSWEVm?=
 =?utf-8?B?bnM5UUlQZWhCTTFBTk4wRXpHUTRMdDR2eFluM2Ezb1haYTRrcm1Kdi9haEEx?=
 =?utf-8?B?cDIzc0JwbVdZSzkvSUkwSFZBVVF1dW5oWlBPUmNhTm9ud3YvTlUxUGIzcm5w?=
 =?utf-8?B?UWZVMGcvYUJBNmVhc21JZFZCZzJUNG82SW9rZHJZUDRheDRtYlVDWXZ0bWFj?=
 =?utf-8?B?STkvWDNXbitsd0RrZTVMU3ZvUEpZUnpQMHNNVFdqbjk5RFptdExGRjZhWWJv?=
 =?utf-8?B?UGRoWElVVGlEZldZbERoMG8wTVUwMk1jRDYwNzhEWFNXMjVWV3puV0dpdlRB?=
 =?utf-8?B?Umh4MDE0R1ZJZU16TzlrQzZxbk1UcWJ2TXZveTZuMXBUZWVCN2VvOWhCRUly?=
 =?utf-8?B?elBqamlMWlN2V2hBUFVoMkFRbitybjc1SGNhdFZzTkZWK2VFZVcrOFRKMWt3?=
 =?utf-8?B?UVE3aVVDcllVcnh4VFh3Z3gyRDNNeGgvWTRmT2pxVWcyTlN6UDRuQnRTNmxO?=
 =?utf-8?B?aEp3K3JFdDFRWnc5WU9wb0FNT3BpS1EvRWc0RjhvemJDV1Y2MG1DYjJOdkl6?=
 =?utf-8?B?TGlpRUhXdHRYbkVWRjRVbVhrOXdZYi9WQlNLQ0dPeWt3ZGVkcEROQzRadURN?=
 =?utf-8?B?WEdXRERyZk9GVkZpVTFSZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3k4dUlYTFkyQ0xIVGM3NGhzTDBocEhDYUtnTG5QVGhKY1lPUFA2bUlCaUI3?=
 =?utf-8?B?c2QwREMzUk96VkZHMnpkT0Nvc2FvTXpjYTdXTzJ1RlBUSk9EdXpTckc0N3ND?=
 =?utf-8?B?NVNkRE9uOFZ2SXkwdXZucnIwUGlUVzd4YUliRnFoMVZOdlhJbmt3MjFNMFF2?=
 =?utf-8?B?L2YxMjdWQVdWMS9Eb0tXb3MyK1A3cGZxS05leWFoQ1l6dDF1UWdncVRHak1l?=
 =?utf-8?B?NG9mbDVZejd4aTd3ZGpBaDhaNHRjdzd2elNNWGl4bXpxdy8zWStCV2s0RGp2?=
 =?utf-8?B?azdtWG0zSFpBQ2MyTzNrbStERDJMeU00TmZYdFRJWlB0VjJWMmRjNU5EVnlV?=
 =?utf-8?B?eGdTNWo2UXhiN1hCY05zWFVySGRhQXZWZnY5MGI2eWlXbW8veGREalRIWTho?=
 =?utf-8?B?WUorQ2RGb3lHSkZoSFhNWjdrY3NWTjBqdFR0VXFnT0MxeWJlRUZ6Y1ozYnZp?=
 =?utf-8?B?ajVucjNtVVYxZWdCSEgraEhSclUwOTB5ZEw3Wjk5N3dEYlk4aGUwRXZLVTds?=
 =?utf-8?B?aktRd0p1N21sVStPbGVybEtXQWUwYUxzOS9KdmRtTWEzbGlnZVkvRStSTUhF?=
 =?utf-8?B?RDhSY0FzTmtUdVcyQ2FpVEpzdE82Q1VLZXZtVFUvYmF6OENQN3RLbVlXRzNv?=
 =?utf-8?B?WVVMSWJOa3BLc1Y4MkZDcEFZMWJHZkVyWmk1blJXWnNmTjlDRnpYMk9IaGxR?=
 =?utf-8?B?M3VtZUVVZmVIUFpCVnltUytROEhZZmZJYno4YVR4NmJTbDFIRGVybUhlTWxw?=
 =?utf-8?B?UzYxZ0U0Rm80WXRvNVV3RmFPbmFoYmRSWkl0cC9zMlpaWVMxOVNSYnZiMUI4?=
 =?utf-8?B?cjdzMG04a3drTExGUndEbzNHZHp2RExaQWRHNytoMjZnUHNpbFovaCs4dyt4?=
 =?utf-8?B?YlBnNjhSbEtycmEzRjkvS01nQzFRRDlXb2tRZ3JyNjBRMmNhSnRQbzBHZ3I2?=
 =?utf-8?B?VHFaMTgrODJGQllHMEtXMGlpekl2YU5uNDFYYm5iZlpPU3VYd05ldTlGQnRj?=
 =?utf-8?B?ZmhiUjM5cC9wSnB3cW5VRFg1S0NUWmpMT2svU1Y1Tk9iUlVhVGNxWUFEYzdL?=
 =?utf-8?B?WnZDU0lJWmVzeHJLYUNBc1lRVk9sNHlaR2ttWXZDL2NsTmx3NGdJT29SR29W?=
 =?utf-8?B?YmZmZUtPeHp0ajhLc1FSMHErT01yV3BXZ3U1SE9EQUlJakZjM1NodG51RTlL?=
 =?utf-8?B?QXRwczVSS3BmcTYwWjFjbmhVS05rUjVzd3UyaTNmeUJZc0VZbi81ekl6cVJw?=
 =?utf-8?B?blNCM1RaNmpIWjh5cU1acHFOaXBVMDMrWUM1NzlBdnNrMkVxNUNRTVJrdytl?=
 =?utf-8?B?S2tNb1hZQ1BUQXppR2NUWXpLMXZlVXg3OGtaK0Z4Z3p3ajNmNmRnOEtJT3Fl?=
 =?utf-8?B?eEl5YjZnLzNMYmZuajl6OUp5SjFDR0pEOHhGakM0WGRieTZHM2hjaFZMZE5O?=
 =?utf-8?B?N09xczUydkc0dVdVb2RheDhiSEFuQ1Y0bEc4VDVQZzlURTNrV29oNmkvbE1k?=
 =?utf-8?B?OWUvaEhmbjVFYkVieVZLV0x0T0o5dit3M2dTUWJuQ2VrWk1qbnJIZU9qZHRz?=
 =?utf-8?B?QWk5cENQNkVHcmJVWEtCaEd0WlhJZ09WaXZLVG10YllOYXhMTTZGUzJlMkRQ?=
 =?utf-8?B?RnNvRVZOeDY4VExkQVdoVkhWWGNIRHpPbklSZG05ODRJZEQ0bU9ka2I5cStD?=
 =?utf-8?B?bm94Um5OV1djWUlYUUdVbEpyMGtQTStkM2RFYnRxSU5aMnZ6bmpvU2FydnFk?=
 =?utf-8?B?Tmp0cVZ6OVdjK254YlVLajhMOVBvT040SW05YVlodVZuTlVxQ1BRM0dtK3J2?=
 =?utf-8?B?dVk5VDQ4clNBRk5TZmJZdmJTeWwvc2VQbFAvM3E4TW4xMTVrVk5pS3JKeWNO?=
 =?utf-8?B?d2dmdWRqNHNVSHB2L3p4R2RMYWFmcnNDa3JjVTI1QUdiODVoWFp5M01kcnlq?=
 =?utf-8?B?TWNnZXBNM1NlNGhHVWYyNlRzYmJBdkVLbEFzWU9YN3h4V3NHQzI2NTlFUC9D?=
 =?utf-8?B?OFd6MlpYWE5sczdjbnk2c2E4c3lGcjRFRzNRZ3J6SU5KTzJXQ3h3UE1IUVBm?=
 =?utf-8?B?N3RMNHE4SldUSjB5ZGhDdHBLNWs0WkZzU1pHd0ZiWFFQenU4OFJxalFuZ096?=
 =?utf-8?Q?Tq00=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1826b998-2c80-4545-df56-08dcc2058d49
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 17:20:28.2452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9OFMt+6Uq7IV/BHBMV/hn6kuVBX9JQqFkD0+G44rQUv/rgi9tmaHnpcBKNFNJ51
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206

Hi Reinette,

On 8/16/24 16:42, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/6/24 3:00 PM, Babu Moger wrote:
>> Assign/unassign counters on resctrl group creation/deletion. Two counters
>> are required per group, one for total event and one for local event.
>>
>> There are only limited number of counters for assignment. If the counters
>> are exhausted, report the warnings and continue. It is not required to
> 
> Regarding "report the warnings and continue", which warnings are you
> referring to?

I was referring to "rdt_last_cmd_puts("Out of ABMC counters\n");"

I will make that clear here.

> 
>> fail group creation for assignment failures. Users have the option to
>> modify the assignments later.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v6: Removed the redundant comments on all the calls of
>>      rdtgroup_assign_cntrs. Updated the commit message.
>>      Dropped printing error message on every call of rdtgroup_assign_cntrs.
>>
>> v5: Removed the code to enable/disable ABMC during the mount.
>>      That will be another patch.
>>      Added arch callers to get the arch specific data.
>>      Renamed fuctions to match the other abmc function.
>>      Added code comments for assignment failures.
>>
>> v4: Few name changes based on the upstream discussion.
>>      Commit message update.
>>
>> v3: This is a new patch. Patch addresses the upstream comment to enable
>>      ABMC feature by default if the feature is available.
>> ---
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 55 ++++++++++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 0c2215dbd497..d93c1d784b91 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2908,6 +2908,46 @@ static void schemata_list_destroy(void)
>>       }
>>   }
>>   +/*
>> + * Called when new group is created. Assign the counters if ABMC is
> 
> Please replace ABMC with resctrl fs generic terms.

Sure.

> 
>> + * already enabled. Two counters are required per group, one for total
>> + * event and one for local event. With limited number of counters,
>> + * the assignments can fail in some cases. But, it is not required to
>> + * fail the group creation. Users have the option to modify the
>> + * assignments after the group creation.
>> + */
>> +static int rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
>> +{
>> +    int ret = 0;
>> +
>> +    if (!resctrl_arch_get_abmc_enabled())
>> +        return 0;
>> +
>> +    if (is_mbm_total_enabled())
>> +        ret = rdtgroup_assign_cntr(rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
>> +
>> +    if (!ret && is_mbm_local_enabled())
>> +        ret = rdtgroup_assign_cntr(rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
>> +
>> +    return ret;
>> +}
>> +
> 
> Reinette
> 

-- 
Thanks
Babu Moger

