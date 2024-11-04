Return-Path: <linux-kernel+bounces-395097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FA99BB874
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137A8285CF9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8006A1531D8;
	Mon,  4 Nov 2024 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y9gF75dg"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442284A08
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730732624; cv=fail; b=PvyUsxSIJ9gPMsefU5MkT0kU3xEDfvcpuftNsLTU4J0YVEQezQtnq08zb3l3onYU+W9eU1VH6ld8EtuqKLWGN0CWOkgiLRdBbPtX6tqnNtxy1PB55Sf6h2pv/ynlQQ6gJuXBoIWtcrcIOns4hoH8sIGprg4N8ZDVxYIDQ6Wx5As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730732624; c=relaxed/simple;
	bh=huorUpUO7MvfiZOhMNGybL+5rG1+YkGmYejDkT4rqD0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MxnXmplqzsJpe+8BL/khDgn+kJBu6lIzjpP6rT20dsqCaGOZenQRAN8b4WOm99JWQTjnUeFgLMptLhIBNKwwsPZRs4CsEKVXW9F7/FU3uYLu/0QSBsIOJci0iSJm+76i3zjNrUzAOfG5on2CnmIUOShdZdtRb8OtAIsMkvDwbGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y9gF75dg; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vya78H4qWjQPvhE0yYVZzZG+ydiHcWjIQPiS3mY3spYGjgO+oGAY0nXLEAxikRi/xxjwilnfw7ajVspZMqsaQu5eJBFzt9LosNIqoTaKxUIXYLBHcVTq8joYiY9spo9RTPzmj3GxaLR3GysoBSU9O+gDvWLpzK56i7BOBXAhF9Cf5cDHXRJY8ShAD2x5VMNaBBA2ig7kwqaFSnXzaxaXtcdBorm7ZfiCojuKcGg6ja1+qC19AUKFUbeh5PLwhhK1wnLsQfo1XJuSRWYYqdfJQRCb/yD10/d4RiX6SVRG0jeRsp37IpzmJ2p8h0VZjFKqud5zH6ztoqmA1Eq3fhy88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nrC08hryPfK2/605wLYXyZiESBgGm09prPioKSywpw=;
 b=Qh85dVZCnNyuTpOF1mZ6oQH3QAfKUfHuNzAs8RbPvuDld+yXq/EYVs6VVBAcL10s2k8EWZZZdE0YgQRtkOMkUEaHjSPHnSQ4uQUceB3OJRXwgPaJU15sah0M++M+/04p28wqHci+/YXP1i5VJk+yCFHfOSokXl3gr9yTQsy1gl0SDU6VM9K+2t4anrbJxverO/GNPxonOF2M+QyW6IgkWRMSc50/PhOAhLAi99+T4rCObbEl+IXnJZzue5bnZuB8WdSzAi7duhs+hn7k81PhNCgVm4Jre70d0ObiJ1wAJsYM6YIOqq8ENRuW/P+8RfTO5qPaADGX+Mwd2VPcAyVSug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nrC08hryPfK2/605wLYXyZiESBgGm09prPioKSywpw=;
 b=Y9gF75dghHdHAbtH6rjxA5k7lwW5NWoDKV6XEwoU3wPVHheGIVb8qrUMaoixq4ShS6BtTyJMUOdXrAZwqmJ6pWC7IxdWex2hJizG4PbCd91f13bS0GniOeeLnEi7o5PZ88IhOvHkDe42c9S2RY2goWqZtDTC8jKPJ3COUR9n3aM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by LV3PR12MB9094.namprd12.prod.outlook.com (2603:10b6:408:19e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Mon, 4 Nov
 2024 15:03:40 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 15:03:40 +0000
Message-ID: <1e0d8039-5721-7172-877f-e3b0bbf216d2@amd.com>
Date: Mon, 4 Nov 2024 09:03:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 5/8] x86/sev: Map only the RMP table entries instead of
 the full RMP range
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
References: <cover.1730143962.git.thomas.lendacky@amd.com>
 <f48b9b551abb544fb7f997b9465680637f014dec.1730143962.git.thomas.lendacky@amd.com>
 <20241104062845.GPZyhpnWueB-jCEl2H@fat_crate.local>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20241104062845.GPZyhpnWueB-jCEl2H@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0067.namprd12.prod.outlook.com
 (2603:10b6:802:20::38) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|LV3PR12MB9094:EE_
X-MS-Office365-Filtering-Correlation-Id: ac60cd27-42dc-4bd1-df5c-08dcfce1ddf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGF4Y2dYczdUOWFQcjRxdk0xV3lOalZ2QTQwOVB3S3B4QmhIQTVpQ1VNYjRD?=
 =?utf-8?B?VTRPTHl2L2o2WFcwZlBRblRzaVEvcjhzbUZoUlFSRWJvRGhYUXhJdWtjdTRv?=
 =?utf-8?B?QnFOVXp4bkE5aWdwcnZUM0k0L3N5TEpqc2JPQlN3NmNYU09LczltLzRqN0tK?=
 =?utf-8?B?SktvK1psVFNNMWI5a0RJcW5yYjFpNWlvektrWjN3WTNqak9mbndaUmdyUXlx?=
 =?utf-8?B?Y0R6OHpwUmNnaXljK0twcnVuSjVQOUIyanlqTDkwbU5xVWVxZS9GTlVtYy9w?=
 =?utf-8?B?Sk9pc0VUTHpuSUhKOHp2NHFvanZCOGdhMDh1YkYrZVV2NTM1Vi8rYVpoMkRr?=
 =?utf-8?B?TWpMa3FaL2VUUGZ3bUJiT0YyRlVaUTlUL1ZtYlRYMmRPcC8zZGJpRDFMckxI?=
 =?utf-8?B?LzFLV1M3bGRKMFpwZ0t3VFFwVkE5dmp4NCtTQ2cyaStKdDdSb1daazJaZDJy?=
 =?utf-8?B?K0xpWnJ3dWpnN0F6cjNQc2xDVGFsRExaekxMa0lhZG0rSTIweHFIYkwxaCtu?=
 =?utf-8?B?bkt6cnFCa1JPbUUyTThZRGdRRVNnTklCbWJ0YWhzcGRvYlZ2cExmT0RkczNT?=
 =?utf-8?B?dE1IalZzQlIxQVVaVURMbURUcTI5bkF6NkJabGxLWStLU3RhQ2JGTURSSkw3?=
 =?utf-8?B?Q1pkQkpzeXdHN2JOQzRPMXN3a0FtclpkTTROY3Q3bzZGVE11WDhCendIZEtQ?=
 =?utf-8?B?ZlVZNUVTcW9xZVV2WnJRWkRKZC92VlZZdFBsMTlZdzFuV0VVSCs4TmZlOVht?=
 =?utf-8?B?enEzWEc3YkxCdTVpbmlPUVpsbWVQay9Za0ZEbUJHS3p6VEhGY2NHa2t6NG05?=
 =?utf-8?B?akY5VFlhVHpzdHAvUFgvblpxeTlzNytCTnUrVGlKaWQ2aVVBMTVtcGIxRHVR?=
 =?utf-8?B?NlZLNDRFNTBFcGNYRlN6ajhjUUh0Q3lWWjhNNm9ldk1WbE5PYTVGUyt4b05k?=
 =?utf-8?B?MzBEWCs1RGhka0VsV2VGc0lpOGNqRlhJQTZBZXI1WVVLOUxySE03WHlpN1dU?=
 =?utf-8?B?d0VDQmM2cmo4eVBEUnpIazhwOWtwc1k5Rkw0OWZ3dTFGQTNUd1dSMmtkb3g4?=
 =?utf-8?B?YW9pdGNnQmtrek5Qd2JocWxYNGtWd09kbjlnSEJRNlFpWmJrOXlMQk9iRzl5?=
 =?utf-8?B?WHRGQWJsUTN3MFZhMmljc01Sd2lkRHAxcElSVXB5RXlodTh6dm9JS2NaN2xD?=
 =?utf-8?B?ajhxTkwzU1R2d09EWlFtZExSM0RuR3c0S2xOc2J0Qmh4dUpOaHVvRHZmamJ2?=
 =?utf-8?B?UFdlME5kRzdzNXdpQWtWS1kyL1NEdmhTRkx6TEE5MGxXT09xeWJwS2ZSR2Fw?=
 =?utf-8?B?TUUxUFJRdy83M213QTljVFAxVFQ3d1hHYjVlV3JobWVnYUlCUUpKQmRNRC9B?=
 =?utf-8?B?QzF4UEgzcEY0R2k4T0dmeGlScmVJR2tBZ2VOeHVQNVd1MDZ6MjNoaHllemx4?=
 =?utf-8?B?c3ZCeTllSFFMTEhqaWdHci9EeWRURTZUYkJ4MDdrZ0NFU1BFaS9RVmM5QWV5?=
 =?utf-8?B?TVVEcG9oc1JtaUpWNVBtdHlkQU9KdHo2S1BHUUN2RUVZdHUwbzQ1WFpzUlN6?=
 =?utf-8?B?Z1ZScFdPaFdTRDNwZVdJa0ZRL1hRNXZDNjVmaCtpc3JBbFdkWWJ2eUxMam96?=
 =?utf-8?B?THlVZjN3RTJ3cTA4RkpFU0FONUpWdWdBdFlCNFdBbDNmd05HNVE2MkVRZllS?=
 =?utf-8?B?SGs1SnlPMjRpblZwMzk0bFBxYXpZTVFmR2hpbysxTkR3b2FMYjcrZ2JWYksx?=
 =?utf-8?Q?4PMzEs1O2AdIBmqszJV4JWL7XTbjll+RWYvWF5P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGhxZ2FzeU4wSm9aT09ybnFTRG1XdHZTbDVaUWRFemFuSnBZMHFQbHZ1SE8z?=
 =?utf-8?B?TmtRK1pHcnRvRWF0MHNzdm5FaHFxaDJZMklFekkzNHhzcFdBWVRlaDJpaUdR?=
 =?utf-8?B?TUV0eXhGb2ppWm40dWQ3bVNlVUhCd0I2K2d0Y2ZPRGFYWlJ2WmVyZDZFdzFE?=
 =?utf-8?B?akVRNUVNYzFVTkJSbDVSVVJrcVRrbEFpM0YrZ0h3bnMrMWtDcGp6S1c1L2g5?=
 =?utf-8?B?Mm1xVTB4YmYvUTVtOUhOUmh5Sy9KZWg0TElCV1lpaktUVGs5aWlwVUs3Y3NC?=
 =?utf-8?B?NUdPamJvMUpGZmlsNEpGNWQ3cGtUSldFczhSejRUT0s1aG9oTmVvakJ2SW9B?=
 =?utf-8?B?N3FwYzdFdk9ibFVIWFprQlB2Y3N6aHdOZmsxdU1TQ3c1Z1FwVERlalpGSi9n?=
 =?utf-8?B?aHc5L2Fvall5TXhYSHV0bm1hekxEK1BxcHI0c3gyVndDZXc3d24zc0FUR3g5?=
 =?utf-8?B?bzNtSVdxRGhOMXBtSUFwVkdjbUJ1aERwWVdPNGlFMkVHdmNxaG0xUjRkWGsx?=
 =?utf-8?B?dFI3MnVSb25SVWxBSUxka2lFNk4zY1N3cGt5RitSWjRQRXZGdGtBUHh6aUJN?=
 =?utf-8?B?bVdXd0h5eW9kcjZhUllwaHE0Q3ZBUGRVZGU2Y2R0Y2g5dlcvRmhELy94VmFk?=
 =?utf-8?B?dUEveTQ1S0tTZTVkTks5MmE1WlRPMDI1ZE9ZVjZPNGp4eWhBeEwrdzFzUGNa?=
 =?utf-8?B?ZEVYYmlLM3dFL3QwMXVld1JXN1gvTDEvdjVWSW1TOTlYbTgrMUprNTdDZ29J?=
 =?utf-8?B?LzVRSW1za3pZaTI2NGdNK1hzQlAySmhkaHJtKy9HdDJvNXVvclRNR0g3NldG?=
 =?utf-8?B?YlNWUkE5ZklzQTUrZ21JSEp2aTAvcHE2LzNwOTdYRXpxZ2R5ZXRlVWhpT09I?=
 =?utf-8?B?bWxLbTRnSDlEZTVEMlNKUFdVRStrNjd5ZHpDN2l1SXc2dXE3cDdSQ0NjeUZM?=
 =?utf-8?B?cDFzSkFUNXFlalVleVJKQ2t6U0I4RmJ4NjhmMnZ2am1IRG91eG8yMmRZdXJ2?=
 =?utf-8?B?aDZzQTZZSmFjL0R4ZmwrbzdxVml3RThHL1NDV0l6OVRxVHc2NkJUSzV4SmFV?=
 =?utf-8?B?UFhxc0gxMStVRExWVVd3Nm9VMjVTaVVlRkJzMUJybXN0VHFrRTZlY0pNWnJ5?=
 =?utf-8?B?dEJGUWpOWjNhVmVReHhqZU5xaStVY1RFZ2xIOHR4dHQzRlhuU0tqeXpqLzJJ?=
 =?utf-8?B?Z21iNkFqc3M4ZU12YURYb0U3Nys0SllqWnpGL3ZGZ2o4bDVQV3BWSUlEaE51?=
 =?utf-8?B?TUlrZ2VjdUE1YUZHaWg1UWI3QnkvSkgySXQyNllLL1FRRHFKTHNLSUxKQXlW?=
 =?utf-8?B?U0RPV2lKeitYUDBESjJhaTVZL0o0OWZmTDVlc3diOXgrQWVNbmxkV3hCd21L?=
 =?utf-8?B?VEpjd0lmUTNybDRpZzJ0TitvWFp1c2RXMEJieW5zbE03cVRoWnVydlNTdzZD?=
 =?utf-8?B?cUlnZGdhS1pVY2NsdnZmVHBYR3BSL2ZPc1RjZlBlR1dha09KbThpQmlraUk2?=
 =?utf-8?B?VzFnUTNvQWtMeTRrTnJId1VSUXhOdzJQc2N6TEdrakRQc0w1ZzlHM0l1Y1Bx?=
 =?utf-8?B?U0toMU5EOHJJZWJFa0o3SE91eGprcVc3QytNYWdvSUIwQ2JMVjRyNDEvclp1?=
 =?utf-8?B?cHczOGxsSWFLQ01wV2pOcWo2bEdNa0N2VHg3bXEzOUVlU1hTTVZDSGJPSGsw?=
 =?utf-8?B?TGFOVTkyYnR6SG9TT2hGRnZkMEp0VVJ3MmxYNzFwa3FOSEZWQVdiSnh5eXZl?=
 =?utf-8?B?UCtRYWs5RDVXNHRudFd3ZzlDTjJ4dENkSG45ZXFSaXIxV0xMc3hkT3ZmcTVP?=
 =?utf-8?B?WXJVRFUvVjBuaDA4Rjk3elBIWnhSZ2pBeWQ4bFYwYTJsczZjbDIydEJDUnN0?=
 =?utf-8?B?VXZqS3NsdFVGN0ZDdVdBZHdEMFMrUzI2Y0U2WEQyaDk0a042QWZ6a3g1TnB0?=
 =?utf-8?B?Z2Fyb0NmUU5Wc3k5ODBtZWJKR2VIRUdWOEgxTkczUmZKR050Ym55M0UvOFJx?=
 =?utf-8?B?MkxIZlEyanpYVVNRYTF2RTFxbUp1Sm9ObGF4QnVyQWJRdnc2SnZMdUJmVmMz?=
 =?utf-8?B?RnJXRitPNzZLYm9mMmRSKzJyakxWakkrQy9ENm9wUm1wbzQ3REpXZWZhM1RP?=
 =?utf-8?Q?vqDBPfqEJhY5uNVCKVVk56GQ2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac60cd27-42dc-4bd1-df5c-08dcfce1ddf6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 15:03:40.3474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/gXFAIsLushS4gL+cRLZSygCTCJPOTRrQGvjajTRxjaRITm1Ntw0po3lQRD0mVj6G+SkF4iZ8wviLoNU76etA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9094

On 11/4/24 00:28, Borislav Petkov wrote:
> On Mon, Oct 28, 2024 at 02:32:40PM -0500, Tom Lendacky wrote:
>> @@ -224,7 +246,14 @@ static int __init snp_rmptable_init(void)
>>  	if (val & MSR_AMD64_SYSCFG_SNP_EN)
>>  		goto skip_enable;
>>  
>> -	memset(rmptable_start, 0, probed_rmp_size);
>> +	/* Zero out the RMP bookkeeping area */
>> +	if (!init_rmptable_bookkeeping()) {
> 
> So let's call it what it is then:
> 
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 5871c924c0b2..8145a7b14fa2 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -173,7 +173,7 @@ void __init snp_fixup_e820_tables(void)
>  	__snp_fixup_e820_tables(probed_rmp_base + probed_rmp_size);
>  }
>  
> -static bool __init init_rmptable_bookkeeping(void)
> +static bool __init clear_rmptable_bookkeeping(void)

Sure.

Thanks,
Tom

>  {
>  	void *bk;
>  
> @@ -246,8 +246,7 @@ static int __init snp_rmptable_init(void)
>  	if (val & MSR_AMD64_SYSCFG_SNP_EN)
>  		goto skip_enable;
>  
> -	/* Zero out the RMP bookkeeping area */
> -	if (!init_rmptable_bookkeeping()) {
> +	if (!clear_rmptable_bookkeeping()) {
>  		memunmap(rmptable_start);
>  		goto nosnp;
>  	}
> 
> 

