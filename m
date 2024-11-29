Return-Path: <linux-kernel+bounces-425826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EB59DEB72
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47C28B20E0A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9F3155382;
	Fri, 29 Nov 2024 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m1AH3NL2"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F162C18C;
	Fri, 29 Nov 2024 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732899974; cv=fail; b=XrvAHz5IPIyd1Ri0jSmmhDxnqojbecMBlSJPmsgZ2mtGFZGzAtreQg1qpjBErnp4CMTXxWQ59vGdeVbgiKbM0F9xd7inMQMDTSuFBfMCr2rjkWXRyvZW2CYKMKwp+L9w2C5fpMjocYIEmMCAraq1LhII8QTLEPwqPW6A8F9OTZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732899974; c=relaxed/simple;
	bh=MC5MKCGWhyRODUdvgDK1jc+ttFtayWEW+zd33nJqTQY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=km3kLAyRflUDUrviXG8044GhxcBhM4yB9ruxO3PYGu5wFLKYlUSvv7zJCUrudVFY25oRX23SJ7/iLEQ18SfhkhqzpnY0VNlGFeFskD9V16WXp3twpUF2VyTr9fZGjxv6wB2kfK+JkuaU6w2GUL04AfwqFdbKlIisdekCOaqLjB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m1AH3NL2; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9AAQU/8WfLp7PUkO9E5S7CFJsaLKXyb97kOymuyMC5rd3oVhzl4nisWX6awG8BPs+pAx2bvyfQs0tiag0uEHg6qrBRf62nMZ4ThTi3+x8oCjIHHF3fOau1SE5w70OxCDUiYlaVsF0yQATAFWUtuHRaNxvnR0M3Uu8L8kYNBNSCFSxvXUZISMWJmbxf1PmduDn4sqYnI1JzWm2cXTRTbwCuH/F1tXhbr7hSz/loXVcVBZQUDj/J2riEn2vVdCPvYbKz3gxIt5Pft9KYL5WGUMxqDWMtzWZ/y1RZ8ElxzJeGcfCu3Ig7Ywq66CjJvE7Q5PFaZsSqsFbTUn7/Hd5b1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ES8TNmkAgn1KAxKHPTqvQlH9mrT0ISbHAevqEWv7Cl4=;
 b=ieDcGLKHodErvQ8jvd81P8Re1FnUpSlZMX6tZ9VTtAi+T25/r0JjjXnMZ4VkhL3TIRkDZ1dMrWyy3YNMiET4i1fIzXE/h2rMpwXggIb5ph9zPDpp0E90GxuTeNge0QZ5eBFHl7Sbwj0D33QLoQbfADVpzJwFbbwoLf4IP2/2cTF0VSCbV0S2PpKz/2wRvzQuToBwNty6KEW9DPhxw3XbquhbJwjyROibf+1dqyNXJE98TK/ifPOp1eCrM7k0tHljF7cPN3YALzjXNL2enWqouFe4w00wIdydH+OJEdKQvKQeiX7JokiJoU+kkOLQ8Qs32saFEKxs71qINalbUbjwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ES8TNmkAgn1KAxKHPTqvQlH9mrT0ISbHAevqEWv7Cl4=;
 b=m1AH3NL2xoydWHHIr89a0arzj3WgTUMrXv6nUjoRd7LNOvJJSaAM/K+1lJXWVOQj/PfLQ+Bk94e0PreDZbBaULBJfq77gjexw6ROFsAGZJR91opoEvq2GVU1jU/7c3gqxS2BPFNK1fRCLParET/7F+CayYI86XXoEuGCBl450wc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 17:06:08 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 17:06:08 +0000
Message-ID: <18adb251-b340-4820-a808-e1583b44480a@amd.com>
Date: Fri, 29 Nov 2024 11:06:02 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
To: Peter Newman <peternewman@google.com>, babu.moger@amd.com
Cc: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, fenghua.yu@intel.com, x86@kernel.org,
 hpa@zytor.com, thuth@redhat.com, paulmck@kernel.org, rostedt@goodmis.org,
 akpm@linux-foundation.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 perry.yuan@amd.com, sandipan.das@amd.com, kai.huang@intel.com,
 xiaoyao.li@intel.com, seanjc@google.com, jithu.joseph@intel.com,
 brijesh.singh@amd.com, xin3.li@intel.com, ebiggers@google.com,
 andrew.cooper3@citrix.com, mario.limonciello@amd.com, james.morse@arm.com,
 tan.shaopeng@fujitsu.com, tony.luck@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
 eranian@google.com, jpoimboe@kernel.org, thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <265f3700ac0c0d33703806fdc3d096b08c992efc.1730244116.git.babu.moger@amd.com>
 <0dc08082-0f3f-4acc-9285-b925a4ce3b02@intel.com>
 <5d426af4-a947-4115-b7b7-4eeecfa13fec@amd.com>
 <c587f94a-7920-49cf-94b1-4c52140db914@intel.com>
 <ef92f1fb-086c-4ee1-b8ec-e08ed68f963a@amd.com>
 <e065b193-dbcc-451b-98db-68a5a69e6ae0@intel.com>
 <20959b58-a882-4ef7-bd11-e8bb0a998945@amd.com>
 <1a93f4e3-d3d2-4764-90d1-728b9cb70481@intel.com>
 <36d8fe9f-0000-4d0d-a097-efddc3881a2a@amd.com>
 <5aa7924d-b27d-4ee6-b8dd-4bae0e25267b@intel.com>
 <CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com>
 <4bf82744-da09-43c3-b8f1-7fc203d1c1c3@amd.com>
 <CALPaoCjL6FEmVgX-h3_GQEVZNAT3FcH34t9o1PwbUacVzXjZPg@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <CALPaoCjL6FEmVgX-h3_GQEVZNAT3FcH34t9o1PwbUacVzXjZPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ1PR12MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f61b7ad-25dd-420a-5512-08dd10981dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1JvczF0RGVyTXhEcW82SEYzM0cwY2d2TzF3MUMxV21mTjJoYVMrRnh5aHNR?=
 =?utf-8?B?Q3JBaEZFenhvWGZickpDVHlTT3R3eEd2RFlVbkh4Uk1EZnlRekluckJwZ1Jy?=
 =?utf-8?B?V2hnZ0J0MkRWMXEyVFlreUVBa1NjVU9nR0Rmd1pNN0hiaTh6MVdIeVF6and3?=
 =?utf-8?B?eVl4OStHb2ZyY09nQm9vRm0yQkxwbE5VRWNZdkJyeEtUSExmNTliM1NHUVZX?=
 =?utf-8?B?WWJEd29mZUI3amVEZ2Z5b0lucjVtQnRMdlJxSyszT245N0o4Y2kveEVJRXZ0?=
 =?utf-8?B?bTBRT0w4Y1ZCOWgwVzVycHZWQWFPem5BYTRkVXNzMTA4cVFWQXFiRlBlbUhs?=
 =?utf-8?B?UEE2ZVR3OW1DNDQ4Z2pYdGJjY2VZMWxtcGoreU5VV0hIOUJ1M1Zjc3l0SXZV?=
 =?utf-8?B?NlJGeTBQa09BL3djbk9oQ1R5c0gwcU1NUkhMcDRpTWF5L0czT0tialNuM3FN?=
 =?utf-8?B?bk85MWgvOC9UcjFjVURyR1RwUVBQQjdkUGVXZGlpVjJWQVRIQjlHSTdwVlJm?=
 =?utf-8?B?UGZtRGhaeU1FckFZdkpqVWVtcEQrLzQ5UHRzWUNnbnJ6WG5DY1pXN0dkemtW?=
 =?utf-8?B?WUY3V210UmlBU1ZOUTE2aXhGQlFNM0lDMzRvWUpCbWdsRVpudnJjNkpHS2dE?=
 =?utf-8?B?NzBFOHJSQjhsN1BJdEt0Qm82TklhSTZXb3I3eFpZanp3YlVrcXBvS29DVWp2?=
 =?utf-8?B?SDFXMWNiL1UySXY1TFlpSmxQdjJLRk9FMFV2cWVBSS80ZDFKT2FoMklUcmdK?=
 =?utf-8?B?N0JyelJVdUJkODVQVXRSQm1haUZReDJkVDRXb1VTalh1RTZveHAvRzNkSGdO?=
 =?utf-8?B?M2U0UC8yZVpqaEZLZVFZdlpSYWxNeVpuZmZud252cHRNR2pwVFhlcTZtQXJz?=
 =?utf-8?B?WXNsRzM5dlFYNG50amhTY2xZRFo4RWpHTkY1T3p4TkdYUStMYTZYcDBQanNZ?=
 =?utf-8?B?ZFZvanVHRDFuVEhYVXNIaGRBeWFQSW9sUkIzVDZxSUduSExWeiszK0tYR0xP?=
 =?utf-8?B?VlhZVmRpMmM4WlJtYm9yZTBocm15U1FxMlRZajFiOU9RQlkxcWV1RktXVXNN?=
 =?utf-8?B?eDFDS2RLdWs4NS9icmFpZTBNSmEvdmJza2xmUkhKZUxGcFYwR2dUczhOTVIv?=
 =?utf-8?B?bjIwckY4NGVLb1BkNnArY2gzaGlaV3FPYWJ3bVhJdnc2bFlUbE9WOENuZU83?=
 =?utf-8?B?bEdyVm5VdWhteHZhSVdwdDU3b3FmeUZpeFJPQWlLM2RlRnY4Z3p3WjNCUDBL?=
 =?utf-8?B?QkdLM1ZZMzRYbnNCWGY1ZmJXNG84bWtFTTJLQzR4TWVYODNZMFk2YTRmL2NY?=
 =?utf-8?B?VVFUZ0xRUlkrbGpZVkNLWk9lYy90TE93dldaUGgyR0pOMC9MRC9LcFVsNmZh?=
 =?utf-8?B?aHVEOTdkaWRHQUpNOFpjcnpGNDVEbiszYVVLeWpUTWQ5TWRMbGlRR01tVGZZ?=
 =?utf-8?B?d2ZHc3NBeldlV0NYcDJxY0s0c2YweGM5c1FGK3crcUFiV1NaaS9Sc3ByT2Vj?=
 =?utf-8?B?OURHandueXUxUCtJM3U0d1hxYXNZa0tkWFFaZWNsL1h3YXd6ek50S2xKb0Fn?=
 =?utf-8?B?SDFXQ2JSanNOWFBmMjJsWUNwTUUwUXRUVXVYbUJzM1phMWpIY0JSOU1yQkNP?=
 =?utf-8?B?U25VQktZYUtVSk95SVF2L3NlNklDcDkreXE0NThobUdESzNwT291djFnQUo5?=
 =?utf-8?B?RDc2dnJrYVFPdE03bzJaNEFCcFF5dG5qaXg3Y0d5UWdUbVpRekZnM21KdXlv?=
 =?utf-8?B?Z29ZVTJObmVpM3htWEtPeEdhNWhKMS9pZGtOL3QzZDJ3MWE3Snk1SWlOZlFX?=
 =?utf-8?B?TjVjOGMxTkl2SWJtQ2FIdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QytsZ0lNZmdpY2NQWmZUT1VvdUJUejN6ZExxbEo0a1ZwbnlsSXl5Rk5QTEVZ?=
 =?utf-8?B?V0N3ZFNaYVpiTy9TT3c2VkluQkt3Zk8xWFJuOUN4WnQ2ZWVQMHhWRTU0ZkxK?=
 =?utf-8?B?Z1NqOGtxVFhQTEJ4dFZOb3ZyQ0Nza2l0RW1IVThXUm5GTEVPODgwUXhTODZn?=
 =?utf-8?B?dFRHUTJkZXBsaHNiT3p2Ry9rZGtuaE1QS05LbEJJS3ZzcCtxYXpsYytkbEFN?=
 =?utf-8?B?K3U2TTRWRklMWjhqdUtNRzBuZUJvRktnZzgrSnRFNjR6eWNGTmgrMS9saUkv?=
 =?utf-8?B?bExmRWZUc2FDUFpmT1daZW9WZXArdTAvMnhtT2lRZHU5Vy83WWltQ25BOEty?=
 =?utf-8?B?emFsN2VBTVgxYVpDU290cVErczlDbVRidHVEMW9pUGJnWkpBaC9FZDBicHo3?=
 =?utf-8?B?aVIzYVg3amdJQzJuem1FQ2NGUVh1YUVLMUxIR0s4aXFWdkxpNmhoL0wxeUMx?=
 =?utf-8?B?VFpFTFBMMWE0MzZyMkMycE82QWpveGdOWHM4VWZ3Ylcxa2ltdDM4eUYxV3FI?=
 =?utf-8?B?MW1ocUhjblJUOEt0UU9DMVRieTVxcGN5UWcrZmhpYW9taGQ0ZkhONHZ0S051?=
 =?utf-8?B?ZDBqU2w4cW5NdzFjU2Y2RUdiZE9LT3MybDB6WTRIMzZReG9ZM2JsaUJxWUVT?=
 =?utf-8?B?aGxLazZia29LWllrVm5Wd09jQzZHZjhxMkhGVm1qd0hjWk1JS3RXcWhBOWJi?=
 =?utf-8?B?ZkxSTEdTOVhzcmtGcG5xWWZ3azh2bGJrTzFSTW5MZWlOZmpFS0VCVEhQWXA4?=
 =?utf-8?B?dHRsVHhuc0l1V1JSWFhPZVQ2WCszT1NXa2doYithaHRFdUVqS0RHODB4SHd1?=
 =?utf-8?B?bjh6N3M3ckhiWkdkSlZ5YXV4bWFSRjhLbG01a3k1Qm1TeUlZV1Z0TmVRT0FJ?=
 =?utf-8?B?MEhqbU51RDFUR2x4TFFXVXRhMG9DVmJXc2VhdG8waGRZVFlzUGxBT1hsRTdX?=
 =?utf-8?B?K2h6d3dqOVFYYzAyWkRMYmNIZHNXMmt5M2NodEt3Y1NCWDZJQ3JkNDhuSU9F?=
 =?utf-8?B?R0d6ZENEenNuTUVheFlhRUk5N3c3b094ZFZxUUxvQnVIUTBBYnZMTFlBaHhO?=
 =?utf-8?B?UzJkZS9CeVdCSE5DZDR4c1hXb1hVTTVtQ3c2SHdhUDFBVktETTh6NVpCQVpz?=
 =?utf-8?B?Yjl0NGhvL0QyKzAxeUppN3lFeVd6VEkvOGxjakJMSTlKSnJqYXlPZllsSXJq?=
 =?utf-8?B?ZnA3R0RobmRNd2JQTDVGZFd3Y05sdGNzUWgxNjcrMUdMRTVpOE5lTEVsdG10?=
 =?utf-8?B?SWY0bkY5VXJIS2wwL0VWQXVSbmVKTTE2UjJnRitsd1BJUmh4a0NaTTZ4bVJJ?=
 =?utf-8?B?anRKby9ScmZnK1JHS1lCVHphSUxPRitid0tqd1ArOUdTcTlZeWxSY0ZDWWw4?=
 =?utf-8?B?TWM0Y0RmMEdxK1c4SitTWEwrUzZvTGorS1B2K254Tlo2emRwbnZxbVZCcUFJ?=
 =?utf-8?B?VzZJSS9xZ3ZYZTJTVnMyaDVURkh3RDB4NU1ubGF5K0tuKytaYnYvMTJmZWps?=
 =?utf-8?B?NzdyUElSdVdSZEtua1o2SGhnVFNDT1poMXNVK2RKQ2g2cEc2aHl3NFVpYktr?=
 =?utf-8?B?U2E4SE04TkJKTjNlTE91MU5OL1RFSnhPcFpyMVJGYmRTM0VLZVBWSFZuN0xB?=
 =?utf-8?B?bC9Ob2JwZUJXQmtIZDJtTWhudGdNYmdIajNRdVBZY0lONFFGSlNhNEVqREZh?=
 =?utf-8?B?ZlFNNzJET2s3T0dLelFka2ZHRHVBWDdPb1JabVpTS3NzQSt4NVNHTWRhd3VU?=
 =?utf-8?B?Sms3WjZZaVN2SkUxeVlBeEV3KzVpTHJaQVRNcE1WSDN0MWluV2J0cTFLUUpQ?=
 =?utf-8?B?OCt5eW5BVGlTWFhaUUt0M1RoN1ZXMjNJbkRKWk9jKytyeDhWSkdXUFpuZzla?=
 =?utf-8?B?TzJLcTFCdldoQ0RDUldmUGVoYURQVE5JRWdDdSs3MEdndG5HYVFhQ09qUTFV?=
 =?utf-8?B?aHQ2dVFEK1JpKzVJNnVYWDBlSlJkY3FrWkIydkxSTU1aaTYyWGRTdGxIWFRt?=
 =?utf-8?B?enZ4RHhtdU9ObnZXeTZld1c5c3RvR1Jsd25FYWl2eGpwYXFINE9Dc3NFVG1V?=
 =?utf-8?B?QThxSHc4SEU5TUtYN1FDZm95M0xkaWlyc01FQWM1bUtZTkFxaGJrZEQ4OTg3?=
 =?utf-8?Q?e5Nc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f61b7ad-25dd-420a-5512-08dd10981dc9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 17:06:07.9153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fHZ+BjWk8RcEAFnnZox3SOfkfXjOiUrIUif+10nDQPsewVFOYTLpWWcQ7tDIIMJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050

Hi Peter, Reinette,

On 11/29/2024 3:59 AM, Peter Newman wrote:
> Hi Babu,
> 
> On Thu, Nov 28, 2024 at 8:35 PM Moger, Babu <bmoger@amd.com> wrote:
>>
>> Hi Peter,
>>
>> On 11/28/2024 5:10 AM, Peter Newman wrote:
>>> Hi Babu, Reinette,
>>>
>>> On Wed, Nov 27, 2024 at 8:05 PM Reinette Chatre
>>> <reinette.chatre@intel.com> wrote:
>>>>
>>>> Hi Babu,
>>>>
>>>> On 11/27/24 6:57 AM, Moger, Babu wrote:
> 
>>>>> 1. Each group needs to remember counter ids in each domain for each event.
>>>>>      For example:
>>>>>      Resctrl group mon1
>>>>>       Total event
>>>>>       dom 0 cntr_id 1,
>>>>>       dom 1 cntr_id 10
>>>>>       dom 2 cntr_id 11
>>>>>
>>>>>      Local event
>>>>>       dom 0 cntr_id 2,
>>>>>       dom 1 cntr_id 15
>>>>>       dom 2 cntr_id 10
>>>>
>>>> Indeed. The challenge here is that domains may come and go so it cannot be a simple
>>>> static array. As an alternative it can be an xarray indexed by the domain ID with
>>>> pointers to a struct like below to contain the counters associated with the monitor
>>>> group:
>>>>           struct cntr_id {
>>>>                   u32     mbm_total;
>>>>                   u32     mbm_local;
>>>>           }
>>>>
>>>>
>>>> Thinking more about how this array needs to be managed made me wonder how the
>>>> current implementation deals with domains that come and go. I do not think
>>>> this is currently handled. For example, if a new domain comes online and
>>>> monitoring groups had counters dynamically assigned, then these counters are
>>>> not configured to the newly online domain.
>>
>> I am trying to understand the details of your approach here.
>>>
>>> In my prototype, I allocated a counter id-indexed array to each
>>> monitoring domain structure for tracking the counter allocations,
>>> because the hardware counters are all domain-scoped. That way the
>>> tracking data goes away when the hardware does.
>>>
>>> I was focused on allowing all pending counter updates to a domain
>>> resulting from a single mbm_assign_control write to be batched and
>>> processed in a single IPI, so I structured the counter tracker
>>> something like this:
>>
>> Not sure what you meant here. How are you batching two IPIs for two domains?
>>
>> #echo "//0=t;1=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>
>> This is still a single write. Two IPIs are sent separately, one for each
>> domain.
>>
>> Are you doing something different?
> 
> I said "all pending counter updates to a domain", whereby I meant
> targeting a single domain.
> 
> Depending on the CPU of the caller, your example write requires 1 or 2 IPIs.
> 
> What is important is that the following write also requires 1 or 2 IPIs:
> 
> (assuming /sys/fs/resctrl/mon_groups/[g1-g31] exist, line breaks added
> for readability)
> 
> echo $'//0=t;1=t\n
> /g1/0=t;1=t\n
> /g2/0=t;1=t\n
> /g3/0=t;1=t\n
> /g4/0=t;1=t\n
> /g5/0=t;1=t\n
> /g6/0=t;1=t\n
> /g7/0=t;1=t\n
> /g8/0=t;1=t\n
> /g9/0=t;1=t\n
> /g10/0=t;1=t\n
> /g11/0=t;1=t\n
> /g12/0=t;1=t\n
> /g13/0=t;1=t\n
> /g14/0=t;1=t\n
> /g15/0=t;1=t\n
> /g16/0=t;1=t\n
> /g17/0=t;1=t\n
> /g18/0=t;1=t\n
> /g19/0=t;1=t\n
> /g20/0=t;1=t\n
> /g21/0=t;1=t\n
> /g22/0=t;1=t\n
> /g23/0=t;1=t\n
> /g24/0=t;1=t\n
> /g25/0=t;1=t\n
> /g26/0=t;1=t\n
> /g27/0=t;1=t\n
> /g28/0=t;1=t\n
> /g29/0=t;1=t\n
> /g30/0=t;1=t\n
> /g31/0=t;1=t\n'
> 
> My ultimate goal is for a thread bound to a particular domain to be
> able to unassign and reassign the local domain's 32 counters in a
> single write() with no IPIs at all. And when IPIs are required, then
> no more than one per domain, regardless of the number of groups
> updated.
> 

Yes. I think I got the idea. Thanks.

> 
>>
>>>
>>> struct resctrl_monitor_cfg {
>>>       int closid;
>>>       int rmid;
>>>       int evtid;
>>>       bool dirty;
>>> };
>>>
>>> This mirrors the info needed in whatever register configures the
>>> counter, plus a dirty flag to skip over the ones that don't need to be
>>> updated.
>>
>> This is what my understanding of your implementation.
>>
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index d94abba1c716..9cebf065cc97 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -94,6 +94,13 @@ struct rdt_ctrl_domain {
>>           u32                             *mbps_val;
>>    };
>>
>> +struct resctrl_monitor_cfg {
>> +    int closid;
>> +    int rmid;
>> +    int evtid;
>> +    bool dirty;
>> +};
>> +
>>    /**
>>     * struct rdt_mon_domain - group of CPUs sharing a resctrl monitor
>> resource
>>     * @hdr:               common header for different domain types
>> @@ -116,6 +123,7 @@ struct rdt_mon_domain {
>>           struct delayed_work             cqm_limbo;
>>           int                             mbm_work_cpu;
>>           int                             cqm_work_cpu;
>> +     /* Allocate num_mbm_cntrs entries in each domain */
>> +       struct resctrl_monitor_cfg      *mon_cfg;
>>    };
>>
>>
>> When a user requests an assignment for total event to the default group
>> for domain 0, you go search in rdt_mon_domain(dom 0) for empty mon_cfg
>> entry.
>>
>> If there is an empty entry, then use that entry for assignment and
>> update closid, rmid, evtid and dirty = 1. We can get all these
>> information from default group here.
>>
>> Does this make sense?
> 
> Yes, sounds correct.

I will probably add cntr_id in resctrl_monitor_cfg structure and 
initialize during the allocation. And rename the field 'dirty' to 
'active'(or something similar) to hold the assign state for that entry. 
That way we have all the information required for assignment at one 
place. We don't need to update the rdtgroup structure.

Reinette, What do you think about this approach?

> 
>>
>>>
>>> For the benefit of displaying mbm_assign_control, I put a pointer back
>>> to any counter array entry allocated in the mbm_state struct only
>>> because it's an existing structure that exists for every rmid-domain
>>> combination.
>>
>> Pointer in mbm_state may not be required here.
>>
>> We are going to loop over resctrl groups. We can search the
>> rdt_mon_domain to see if specific closid, rmid, evtid is already
>> assigned or not in that domain.
> 
> No, not required I guess. High-performance CPUs can probably search a
> 32-entry array very quickly.

Ok.

-- 
- Babu Moger


