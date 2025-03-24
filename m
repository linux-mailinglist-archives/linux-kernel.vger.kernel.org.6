Return-Path: <linux-kernel+bounces-573924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EE9A6DE28
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF881892914
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A136286329;
	Mon, 24 Mar 2025 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ne2ldmEr"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242D613AA27
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829469; cv=fail; b=mkVmjsYRQSoI2HOMYMEErHf7kD8LuZ8fY/qiPpjCi7G1s3f5OPEqaoGLhFaCoqujd3eMmjVnNySUh+ebf3V/zDkYgKcNvgJQe75r0PqfpWqnk9/r78B0vDB/aRBc4miVbvh/WqJ3rvNeQcb2HVb+kXX/4ebalpXvB2nxjMwawaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829469; c=relaxed/simple;
	bh=p+GzbO2zprbX/JDQ7/8dJ0O5CngSokixlm8K8qoiluw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SgBBjTRHSMfKR8a/M499tq1eRy36U6tbrrZzjbkJqJew4NypWzCb6SE5tr51FPXl2z9VOC/VM8h0uB1a/MH3HCtlRxq5VOGs1DpvDtZcJn2nlBZBrNjdY99UZSLjYsDTDT/lan2OR0zI/R4krKVH7YxWbMb5eGzbCNwmarkkY9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ne2ldmEr; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joReJbpbGU9BKWXczqas/a4U1L8njRkSv+Sp8klBOH0qfT6bipscGWt6py8Uu3JJHqKIVQaG9drWR+B03UNiZxbBTSLhSdrjgUF17wwMANLQ0GlAA/5uTU/OsV/73w1IMQGSjuoX7RPssXCVj2fh/4tUWshmyaPdmXEu/mMnmBFrjJZ/bNNM1u3HoMfJYMeBgWdE1uw3ieQUNGJwiHV5Im/T8Fn/90mo6eHlSojXo8YSU+nm9VqR/4sw3Cx9rdVkpFEESOGdWUDPe1/xrT9fEbPGX/LN8GKDdT78LEWY8457pGPGjdfKky/IWXEgCLUlIh53jQzqzGurGWedGGMJPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMLrr68klJgZuex00p6XZ8YhgVEqz+yF7LMDeqfgJds=;
 b=Bz/qTPxaqE7y1EIn9Q1QOFVT2nqgco8H/Oz0A01ot6B8IrKiPQYnHCY6i8D7ODdv4G9PD9eD1wHBWukhUGiIjxCoWfniFXYdTTG4ondUoxjcwzV8Z90GYzifpz9FWVnl0Xga4dZTnYZzzbQZ/bGZ8ZD7R9VORouRX5ZljjMt0lqhh+srWpZkMlAxlraTt8I85E7qzWegU/6U4Sp1MIytSWi/efdw8IFXISar5rfyqv0JWDrrd8GLkSILRJ/G0zi2AeFKjcmaf92fzu9O693bT1e1d6NOIT7kmkZ9sqzJbzfy7ZacXt/xiBiEShsKkNNTZqWm/9GWyv2iiKwDIO7JUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMLrr68klJgZuex00p6XZ8YhgVEqz+yF7LMDeqfgJds=;
 b=ne2ldmErq0zZ3Zh06/kKhetsbINxYi6bvzt+rMGUnNr8iOP8cAReT9iqAJWsvOJX98LviebYq0/7IQqKq00le3BWB10AuNAJYL+gYQV379SXnpm5h8sWKx/nvb6yzXU8gUPK7bsyBCa1GqMAaZspb+HEn28jFAhYg85yRpJF8r0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by PH0PR12MB5605.namprd12.prod.outlook.com (2603:10b6:510:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 15:17:42 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%3]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 15:17:42 +0000
Message-ID: <acec8834-0933-4483-86de-19f39fa789fb@amd.com>
Date: Mon, 24 Mar 2025 20:47:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V1 04/13] mm: Create a separate kernel thread for
 migration
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
 Michael.Day@amd.com, akpm@linux-foundation.org, bharata@amd.com,
 dave.hansen@intel.com, david@redhat.com, dongjoo.linux.dev@gmail.com,
 feng.tang@intel.com, gourry@gourry.net, hannes@cmpxchg.org,
 honggyu.kim@sk.com, hughd@google.com, jhubbard@nvidia.com,
 jon.grimm@amd.com, k.shutemov@gmail.com, kbusch@meta.com,
 kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com,
 liam.howlett@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mgorman@techsingularity.net, mingo@redhat.com, nadav.amit@gmail.com,
 nphamcs@gmail.com, peterz@infradead.org, riel@surriel.com,
 rientjes@google.com, rppt@kernel.org, santosh.shukla@amd.com,
 shivankg@amd.com, shy828301@gmail.com, sj@kernel.org, vbabka@suse.cz,
 weixugc@google.com, willy@infradead.org, ying.huang@linux.alibaba.com,
 ziy@nvidia.com, dave@stgolabs.net
References: <20250319193028.29514-1-raghavendra.kt@amd.com>
 <20250319193028.29514-5-raghavendra.kt@amd.com>
 <20250321172940.00007646@huawei.com>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20250321172940.00007646@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::30) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|PH0PR12MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: bb0a00b6-ba76-4fa1-7143-08dd6ae705aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjJTM0NBNlJYTjkram5DL2JEend5S042ZnI2R2dXZHFwaUt5UWJET1lwVEhj?=
 =?utf-8?B?TmRZSjJ2WE8rRG1pMDV6M0EzMHB5Zmk0ZXNURnNUV2o0UXpzM1Z4WDcrT0lu?=
 =?utf-8?B?dEJpb2xlRUI1Nng1WklRTlQwZ3pDQUxHa0hKUmJXd2VaTHhmVi9lcDZsd2J1?=
 =?utf-8?B?STZoaGJvMDRqYk1zOHVXNlhXeWR2M0J6ZDl6YUpIMU04a05ZZ3ovVzZWZ0l1?=
 =?utf-8?B?VFhlK1dHa2YyVnFlRHg5K0xZY3VZMzFKOXZURjJNbDNBMHo5UVFvT05JeDcz?=
 =?utf-8?B?ZjZVMklYZG1KalBkcWp1Zzc5ajkyd2Ztbm9HMiswRTBFOUEzelZROUN6WWh4?=
 =?utf-8?B?dFdacTgyVHRBbjB2ekhBZjNnU0RPa01SWDRIMWNVZUoyZEFBVUgrcHpZU2Ry?=
 =?utf-8?B?Sk9SOFVsSjFZbDc3MUk2TzgzRzZvQ3VnU1R5THdjMExUOUppYjJJNTZaUzdu?=
 =?utf-8?B?UlI5dHRqSzV5ZzJvMjRhcnFJQXVuTlI1MG9Ceno2Wm9WTVQvZHZ6MzlYaUtH?=
 =?utf-8?B?clMzVGovbjNER2VYSEdmdldUR2orWXhKd254cFdUaHgvMXNIRkZJckdTbHNx?=
 =?utf-8?B?dm4xSEorc0V0ZlhzZ0l6dGVUbTdPdGVYVWQ0MW9vK2xHRkt5YmNmMHBpOEVK?=
 =?utf-8?B?WmJ3U3BPTHhEOFpOV2dxelhSVVhibXdUcjljdUZ5WjFaVDZ5cWVkUmk2TXlq?=
 =?utf-8?B?U1A0emk5LzFxb3JFL29mTkNoeS84dEROMHY5cjkrTFFKbkJ6UXlBZDZsdEV0?=
 =?utf-8?B?ekZSd1JhazVLQ0ppUmpldzVMYjBNRVVHclpGUXJXaDBXL2N6YXAwejJ2MEJF?=
 =?utf-8?B?K3RscUVnL0dsaU5tZzUyQVl2Z1ptT2wxSG5NZXllQWRoaHZXU2pvQWFXSisx?=
 =?utf-8?B?Z3MvNEN3UUY5VnNQYU1vQ2FpUk9WcVhiZEVzVzM1dnlNYXJzbDIyTXgwVDZn?=
 =?utf-8?B?N2hHcEpzQnJ6OEtMWnBxVng2NG5YNXNJajFFS0libkxSMHNSMysxamh0Vi9P?=
 =?utf-8?B?c1ZCSklpbW02aW9jRklYb1FNT1YvVWxXTFc3TmgyRzd5aEpGcEpXeXkvVnhR?=
 =?utf-8?B?MnVzb09GcWxpZmQzK0dITWhrVFdLT1U3cHdBVTc5R3J2bU5ORlYva1dsU2M3?=
 =?utf-8?B?eDVsUktGMmk2K2RlTUFwbDVwNHJaZzd2bmE0SVc3M08vdzl3dzJPMjFIK21r?=
 =?utf-8?B?ZXNvdlpMSkt2US8zZkNJbWtNQS9BZ2VzMURlcXQwd2k0cG5CdDU2QnVTWk5z?=
 =?utf-8?B?Y1hBTVVKL3BLQ1E3NzF5THU3V1hvUDhiOGFMUEZvTGhEK2tQZWMwOStEbHVV?=
 =?utf-8?B?YndGZ09XaDUwazRaVkxOdlU3aVRyT0p6K3NrQTA3UFYxZlRyNlNZMFF2NkN1?=
 =?utf-8?B?ZTA4V0xzcTdjRmxuT1RESWo0SGRDeVNscFhpZWZLMWNpOUdKVFdIRFRTTGpr?=
 =?utf-8?B?a3FEN3pycjlkRHdvY3RwOE5OQ0E5MWZzRFpxK3EzUlF3ZXNKSnJOMWhnbmww?=
 =?utf-8?B?VThUczlSeGtuaHI2VmtkT3hUYjlxK3BsdlpLU1FUdEpWUDhMUmc1aUpmRzdk?=
 =?utf-8?B?L1p3YUpKZmh6VU1HQjg5TmtyZTdRZkp1MUlMaDVGWEcremo4dVVoSzEyYVVm?=
 =?utf-8?B?cDJob2grT1F5N3J4ckttU1pKZVgyQU04RjZqL1hNSjU5b0hXcDNyMW0xV2lI?=
 =?utf-8?B?K3VKeEV3TVB4ODc3VTNlT3d2ZU9LQzcrKzVLRk5MSVlGWGZiSElTcnBpR2h0?=
 =?utf-8?B?NFg1dDlpQUtrYjd0ZzAxSjFuVUlqbWpPT1NvZEtLOHEvdWxXMXBFcDkyaXFP?=
 =?utf-8?B?TFJoM2ZnQmJSbXkzNDhmcUtCdjRWUW14bTJrZGUwYUtCckF4VHVCMzdTb2NF?=
 =?utf-8?Q?Zktowu5FcZBl7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3luOWZjNUo2eTlLa1BGR1NMdUlGMkJhWk92RUxSM0lKYWpjQ0REQXhGVTJ2?=
 =?utf-8?B?cEpSYlZCb0wyaUp2ODVUcTlkUmQ5MVl4Z0IzZWVSMWkrenRMSEFjUmRQSndv?=
 =?utf-8?B?clc5ZkhzMEk4bkd5cUQybS9CTjFhZ2tyN2NLNmFvR0p1d2JEdmNtMmFnOFpQ?=
 =?utf-8?B?ZmZPeWlTSEI0VUlkQkw3WkJlb09jTVFSaWJBcjg3TTFxVzFOZHorc3pXR0dy?=
 =?utf-8?B?TXNvQUxpUmtIR3UzRTluUzlNWFNyWnA3ZUhNZU5telhxdDB2NlZzREErRmJr?=
 =?utf-8?B?Q2dCTVNaSmxLMmF6dDROZVplTGxqVjRmNGlnOXdxbnB4QXlaZG1KT09OdnRh?=
 =?utf-8?B?dzNhRERLczdmQWlla2tMSUtGdzJ1OEJ0MlYvbThMdlV2bzJzZUhiZk5MUEtr?=
 =?utf-8?B?M3N2NDQ3b2cxU0d0K0lRb29Ha1ZzUFIwQUhjYXhOVmFwb1VucUNqUWVFSkVQ?=
 =?utf-8?B?OTZhSGp1SFh0K3U4USsxTlVsRS9iaXNSazNrakpzUTNhZDVrL2JQTTBDOEZm?=
 =?utf-8?B?TG14S0ZGOFVCMEw1UzBKR2x1RmdCUFpTcisrYXRJd2VUU1h3RzBqa3QvcG0w?=
 =?utf-8?B?dWErRTlQT1duekI2b21sMTNuSHRjaTVwRGx1eFNkRE9aWHEzS0JUV1lob3ls?=
 =?utf-8?B?TGZDNlQ3MTkxV3YxekI1MVVtQlhlNFNDelZGL3FJR2M0ckczQWc1UDJGWXVh?=
 =?utf-8?B?NDgzdFk2Mzl2Tk5nYUFlY0xjc0RYZE4yMzBaOTBsWVhTb1lucG5IVTlaVW15?=
 =?utf-8?B?SUQ5TG82Ui9jVnN1NHU4alFYM0RBNE9UeENtQ1FPME5TaklDM2YrV0U3Qzh1?=
 =?utf-8?B?dVRtTkFoVlJhQm8wV0w0cUptNTB3dzFqaHJ2OGsrWWhDVm1XVFRqSDkzdkx4?=
 =?utf-8?B?MzlBVGlSdFUvSE05UXBPYTEyVzJyN25FeWFCc2hlaUpPdE9wMWJ0YUFIamxD?=
 =?utf-8?B?MnQra0cxcC9kMjVwbmh6NVlrTjJ1VVhQYTloUmt6akRtR2VzYmZTZXlnci9h?=
 =?utf-8?B?MHZtckw4RDVNMy92bmNCbzZ1VHZNQjFJek5YbDJ0UGNETFA2dmhzTmpwaFg4?=
 =?utf-8?B?WUZRcVhteFlmYUNtcUU3VmV6d0JINVZwQ0NRVmdOQjgxRThZTHFGNk5GeXRM?=
 =?utf-8?B?VlFUUy8yUlp4M0p6RjZObjZIZmZDcGZ4cjBYQ1NkUllYempHdGZkbnFSRlBP?=
 =?utf-8?B?bm12dExDZnZKc2RpN1ZCcFRqMkl6VEVSM290SlkwU1FhOUF6bk92TWhHVFNz?=
 =?utf-8?B?aGhBV2RpNFZZSlJ4OFR0NVF1ZDY0MlFiUmtXdVhFM2R4TE5yZGtGWTdxSnVW?=
 =?utf-8?B?UjgzRTg0SWNSS0UrVGpPUXk5dDdIbDNEZVdIb1ZsYnlrSHZaWmV3Z2VQejAv?=
 =?utf-8?B?WCs2TXBncG1PN1E5KzByck9iNEk1MmFyNEQzb1NIVzBXRk42azRXU3ljczRL?=
 =?utf-8?B?TGJTMWNrdFNmVVdCMzVmQ2JuTkM3Zjc1bEJ5bnhQeEMwWlM0YmJNUHliWjd6?=
 =?utf-8?B?NnhQN3Bnd0N6bHBtNVBvTEhObGJaK0NLVmRuMEx5RjlmMGtneU9Edm9CUklJ?=
 =?utf-8?B?SzU0a3RWaW5yeUlTVWR6UDJ3SVlmd2pHbHJyVEFRTEJ2MkJEdGc3WHZsRUpk?=
 =?utf-8?B?REhXY0RVTUFlckphV1F6SUIwd1VVdkQyK0tRNEZVWWNXMG83dmtsMENham10?=
 =?utf-8?B?bEl2YVJkZmhmMkluYlNWU0ZadlAvRTQwV0NXTTg3SUEySTgrNUJMbEgzTDJ0?=
 =?utf-8?B?dEdkN2cxODFmTjNnYitzcG5kZ1pMSlNpTEF1b2R0Ris0bFhBZ0NnL005T1lQ?=
 =?utf-8?B?amcvS2JHd213bE9ITkJhL3VpNnB5M3hVM3VlZERRTDdhK0pHdGo1ajEyZS9G?=
 =?utf-8?B?OEVIS1dhdGZRS1lIQnhnYkdDRTZmNnVienBoN0VjS3RTOHc1emZ5OE00cE84?=
 =?utf-8?B?MlVqWVZOZWUzOFFSUTVlUFRiNlFVZWtsQXlJVW5LVEM2Ymp5aWlJUnNxYVdp?=
 =?utf-8?B?bHVpUGV6VVFWNXlsZ2Q2a2hKQUFMYzczLzlWWm1pTDYzTmpoRkU0VFdGSlFv?=
 =?utf-8?B?R01HeWJyMVhheG9KUk80QTdZb0VBaE8zTWdPd1BpZDB6TUs0aFM3WFkySEcw?=
 =?utf-8?Q?HXu91+vUUCXJozMcs+W3jCMLg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0a00b6-ba76-4fa1-7143-08dd6ae705aa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 15:17:42.5612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlX05OtMcOIIWsGErwwWO5NHz53kUH2OMhjBmpULkVMtDQK5oZyrR8H3gZ/5F33DKlnXrqUeVr3NAWnGxGmqkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5605



On 3/21/2025 10:59 PM, Jonathan Cameron wrote:
> On Wed, 19 Mar 2025 19:30:19 +0000
> Raghavendra K T <raghavendra.kt@amd.com> wrote:
> 
>> Having independent thread helps in:
>>   - Alleviating the need for multiple scanning threads
>>   - Aids to control batch migration (TBD)
>>   - Migration throttling (TBD)
>>
> A few comments on things noticed whilst reading through.
> 
> Jonathan
> 
>> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
>> ---
>>   mm/kmmscand.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 154 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/kmmscand.c b/mm/kmmscand.c
>> index a76a58bf37b2..6e96cfab5b85 100644
>> --- a/mm/kmmscand.c
>> +++ b/mm/kmmscand.c
> 
>>   /* Per folio information used for migration */
>>   struct kmmscand_migrate_info {
>>   	struct list_head migrate_node;
>> @@ -101,6 +126,13 @@ static int kmmscand_has_work(void)
>>   	return !list_empty(&kmmscand_scan.mm_head);
>>   }
>>   
>> +static int kmmmigrated_has_work(void)
>> +{
>> +	if (!list_empty(&kmmscand_migrate_list.migrate_head))
>> +		return true;
>> +	return false;
> If it isn't getting more complex later, can just
> 	return !list_empty().
> or indeed, just put that condition directly at caller.
> 

Sure.

>> +}
> 
> 
>>   static inline bool is_valid_folio(struct folio *folio)
>>   {
>> @@ -238,7 +293,6 @@ static int hot_vma_idle_pte_entry(pte_t *pte,
>>   			folio_put(folio);
>>   			return 0;
>>   		}
>> -		/* XXX: Leaking memory. TBD: consume info */
>>   		info = kzalloc(sizeof(struct kmmscand_migrate_info), GFP_NOWAIT);
>>   		if (info && scanctrl) {
>>   
>> @@ -282,6 +336,28 @@ static inline int kmmscand_test_exit(struct mm_struct *mm)
>>   	return atomic_read(&mm->mm_users) == 0;
>>   }
>>   
>> +static void kmmscand_cleanup_migration_list(struct mm_struct *mm)
>> +{
>> +	struct kmmscand_migrate_info *info, *tmp;
>> +
>> +	spin_lock(&kmmscand_migrate_lock);
> 
> Could scatter some guard() magic in here.
> 

Agree.

>> +	if (!list_empty(&kmmscand_migrate_list.migrate_head)) {
> 
> Maybe flip logic of this unless it is going to get more complex in future
> patches.  That way, with guard() handling the spin lock, you can just
> return when nothing to do.
> 

Agree. This section of code needs rewrite when implemented with mmslot
for migration part also. will keep this in mind.


>> +		if (mm == READ_ONCE(kmmscand_cur_migrate_mm)) {
>> +			/* A folio in this mm is being migrated. wait */
>> +			WRITE_ONCE(kmmscand_migration_list_dirty, true);
>> +		}
>> +
>> +		list_for_each_entry_safe(info, tmp, &kmmscand_migrate_list.migrate_head,
>> +			migrate_node) {
>> +			if (info && (info->mm == mm)) {
>> +				info->mm = NULL;
>> +				WRITE_ONCE(kmmscand_migration_list_dirty, true);
>> +			}
>> +		}
>> +	}
>> +	spin_unlock(&kmmscand_migrate_lock);
>> +}
> 
>>   static unsigned long kmmscand_scan_mm_slot(void)
>>   {
>>   	bool next_mm = false;
>> @@ -347,9 +429,17 @@ static unsigned long kmmscand_scan_mm_slot(void)
>>   
>>   		if (vma_scanned_size >= kmmscand_scan_size) {
>>   			next_mm = true;
>> -			/* TBD: Add scanned folios to migration list */
>> +			/* Add scanned folios to migration list */
>> +			spin_lock(&kmmscand_migrate_lock);
>> +			list_splice_tail_init(&kmmscand_scanctrl.scan_list,
>> +						&kmmscand_migrate_list.migrate_head);
>> +			spin_unlock(&kmmscand_migrate_lock);
>>   			break;
>>   		}
>> +		spin_lock(&kmmscand_migrate_lock);
>> +		list_splice_tail_init(&kmmscand_scanctrl.scan_list,
>> +					&kmmscand_migrate_list.migrate_head);
>> +		spin_unlock(&kmmscand_migrate_lock);
> 
> I've stared at this a while, but if we have entered the conditional block
> above, do we splice the now empty list?

We break if we hit the conditional block. Also there is a check for
empty list in splice too IIRC.

But But .. there is surely an opportunity to check if the list is empty
without using lock (using slowtier accessed count),
so thanks for bringing this up :)

> 
>>   	}
>>   
>>   	if (!vma)


