Return-Path: <linux-kernel+bounces-573131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B37A6D359
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 04:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B6E16F5AE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 03:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36363F9D2;
	Mon, 24 Mar 2025 03:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dgtu5izf"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABA51D540
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 03:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742787364; cv=fail; b=SnvXeOnQ+5bZGwVXP8ScRQZmyARFtV06irPl6wUZUTgYEB0bM8UoiQW658EmD/vhxq3usafx0zJpcIOIblG3tzMYKJuo+FnHhcrm0J0zHT429XE2GbTyU3ofpyn4Dj6A0mTiejq0uVXLapJ72esWaIGx2oZV8JbrxR3D0nT4kWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742787364; c=relaxed/simple;
	bh=Br/GH3ejmov9NWBNGE9fmuiS+fAFFXzlUQDlttH/Bsw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CX8gCvaDN+i6gywUnUKsByTwOq2jslKhu4mCdw8aUOdJu4N1HmdXC8DTzdIkymgpxarCeK6+W1IDm2NLLQxn7dGDu41/3Gb0Ix1tlP9wBTEAj8y/2Qdu3ZGzt2eIzBaCxRd6/UR/shQlFWGLF5z5msEMctuzfh9wW1YD0RjtbQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dgtu5izf; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LS+6ar1hvHpdvv50g4Cjv+VKroIxCcQJ4EHIFbOU3GR1zJ/h3D+fxjnRsKPcda5bvEToQouyR3whfiIHsl4ax2aEtE22arU40WRss34PEQszHoOwzJStSXkgCfdbs2DvKwePjBwPRjYmWKdvDM4JQAXEeQs86QeEPz5wdKYj+Yuwntl6ZLwW9kCM6+BA0FRvYAxkG8MZPSov+p002W7MDGcW9mmrBvdf3V2pYKg++jvWK10IG39nHEeYSOG4SXaf98WxNZeQF0rkhMapqpn4k2w6o5nko7xgsWifTjV6gQPvoZBTn5WesrPnPYMyVog/Efl67u/tyqoxcf/4pJuD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RcfEQ8xuoQXywhDBR/H67f8LsOV6sJScWYZNOcZrwA=;
 b=q21FM8FLNX4AzzFgueb/V/URPD6vQ/UtwMhwFPUpfrAxEXBIfrD1eWnBxTpU/5zpXSDJlAjlQuhbOnE/iZvOqEP6ZRGkmyNXzJEF0NPV1DShVmT9R9vms8Ddt1l0/jN9gh5Xl+MnO9NQELN7Irse55nwqyrJJu/Z9WiqP07WGIx55tVdnUOkju8odNa7f5afJH2N0rHKomF6DvgvBakQ4MOOrn3k0zxWdAOOqnj9W3hg4eKNC25TKPOQQXY6BFeLRIt8n1Hx1PU5Wh309hBpz0SoOMBrI+TFuPNZAN4HZbDfiGCwMia/b3aS5djtXLAN4wyVdq9r2T313TkgPJMEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RcfEQ8xuoQXywhDBR/H67f8LsOV6sJScWYZNOcZrwA=;
 b=Dgtu5izfn76kdPvqAdrwxXrN6MTwrICbklKR8ggyePLs+tavsceVvINXY0P1dMzs5DMwFfj99P3oGYJ+ViI6k1ZM0s0n0GBweX2RH5x8aJUQ/1gE+hzWUqeoArfm64Qrl/TgnhRkkZiqYhxquBNhixFfKSW8xdMMnD8xa3K5ObyziXxqT8XPJY7ko4GQTgmQzLnZv1XuBz+GAYaWFZTQVr/ahYCNFD1XC1ZdvBaaAzt/+HeuGnrI2FWCq09yWKjDWg2PXQloaY31pp3zbmQZ34JZwsAB7nSBWWBG7IG+UO+HURtHWS9uKxQnH6rgMuHDJGfCikvjOfzQetZFna1JbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 03:35:56 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%6]) with mapi id 15.20.8534.031; Mon, 24 Mar 2025
 03:35:56 +0000
Message-ID: <c9c7e0da-115e-4f81-be81-193431fe838e@nvidia.com>
Date: Mon, 24 Mar 2025 14:35:44 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] mm: kpromoted: Hot page info collection and
 promotion daemon
To: Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
 Jonathan.Cameron@huawei.com, Michael.Day@amd.com, akpm@linux-foundation.org,
 dave.hansen@intel.com, david@redhat.com, feng.tang@intel.com,
 gourry@gourry.net, hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
 jhubbard@nvidia.com, k.shutemov@gmail.com, kbusch@meta.com,
 kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com,
 liam.howlett@oracle.com, mgorman@techsingularity.net, mingo@redhat.com,
 nadav.amit@gmail.com, nphamcs@gmail.com, peterz@infradead.org,
 raghavendra.kt@amd.com, riel@surriel.com, rientjes@google.com,
 rppt@kernel.org, shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
 vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net,
 yuanchu@google.com, hyeonggon.yoo@sk.com
References: <20250306054532.221138-1-bharata@amd.com>
 <20250306054532.221138-3-bharata@amd.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20250306054532.221138-3-bharata@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:74::18) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|MW6PR12MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 746d24aa-0e0b-4b03-3de7-08dd6a84fc4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmNtYk05alBMRDlzTjlFeEdOekdTbG5iNWFkMEZOTkI0M1NoTWFHK1JyRTE5?=
 =?utf-8?B?amRPc2czV2JWbk0zMGRuNWRqSDh5UUxEVFRyZVAvUkVCakF0SmdGSjNZc05n?=
 =?utf-8?B?ZTVmbkJIWU41TUJRc1ZiNHl1OHNvQXplSU9DRkpkdDcycEpHbmtadFU3RGc1?=
 =?utf-8?B?aFFidDRBWWZyaldqSm9TdlVnSE5neW5MRjNjcnVQM2UwVXVIdGtRZ1lUN0ZH?=
 =?utf-8?B?cTdINGduK2wzRStCVjFjZnZvODRiOFdYUSs0TXY1UThLU2VibVhXTTV2ckpS?=
 =?utf-8?B?UU5lTEQwdzcram9JSDl3RVM1aDVaWEx4RDZTcmFmb1BFTnJoUUhUL1VBM21Z?=
 =?utf-8?B?S1ZvRVA2QmR6UXQvNi8yWFc0bit3aUozZnBBQThwYytnRWlHRDNNNmdSYjE2?=
 =?utf-8?B?VGVhMFBEYlh4c3FoV1VxSzN6WlRBVjF2bFZHMDdSTGhKcWJEZ0lmZHdNbzEw?=
 =?utf-8?B?ckVMY3hMTkcrWW5yYkc3Ly9lWjU4dkdhM3daSVE1MnQyZ3J3VlQ4cE41NXh3?=
 =?utf-8?B?YUJIdFRIb0RQZDRkdS8rbVNjaVFGbkxteGxEUi9ndGJzaWtqaGNCS2dKRkZR?=
 =?utf-8?B?RXVTQStEdnFGU0VabURqU3ZreDJnelArc0ttZXk3eTJzRys4Z3FyMXNTQms4?=
 =?utf-8?B?VmZBaHFQYlJUR1ljTVRSMWNTTmUwTDdKT0NZTzRhZ1VGOXRHRmhyRDE1R0U0?=
 =?utf-8?B?bksvV0NXOGhQUkdvWFgyR0V6UE0yZVBqQ2U5NytOdzVMa3djQUtFdGdiSEta?=
 =?utf-8?B?dkRwZlB3Z2x0bk5sV0wzSk9Wc3owVnZZUkdscWlTb0pJY1pNS0RJYzI1NG1T?=
 =?utf-8?B?d2Y2cmhML0cwZktMNU5wM3ZWTlFLRXpNTm1lajcvMWtUYVE1eUtjalE3TzlZ?=
 =?utf-8?B?Wkg3YWJ1WmFRZzZsSDJUNDNkS2lKS3ZCQnFycE96TmpZS1IrQThCNThHb2tz?=
 =?utf-8?B?NmhRVnVia1VTcmhpcDhUdzNpZmhGRlg4U3pKSmN6am85MmljS1ZVbWxJSnhr?=
 =?utf-8?B?MDN5c2NqcWRnT24reGhjTDlMb2ovWlhXTGp4c2V6dStUc1ExUEhCWTNQazJ2?=
 =?utf-8?B?dUZ5K0hzWGtad0ZUbXVNWVA0MHFMNGFyREJ6clVNOHZ4RUg1TUpPbnJEelVM?=
 =?utf-8?B?MDg1Vjg1UjlkVmc2ZnZwYkxrSWdYUWNGQmdjQWQ2b2EwdE5kZ0xiMTZaRUxs?=
 =?utf-8?B?WGtGaWczZzNtNE9TRmxSRnRaLysxU1A1TU0wcnMxMlpTelJhNFNjL1VOd2Q4?=
 =?utf-8?B?RnJaU3hYc3JOc1l5OWF2cVN5MWZveXcvY0xKQlZWcU10amZpYnFWWnBiYmp3?=
 =?utf-8?B?WjRtWmoySy9BN0xSL3p2cjYvVEFIa2I0MHFOdzk0d1IwV3BaNkdSWnRZMkZx?=
 =?utf-8?B?QndCeS9ma1p2Mk5DTXF1NTQ4ZVVxYjdCUk9RU1FtNmtRTjFZQTRjMkJpd2Vi?=
 =?utf-8?B?QllUaDRtVTdjRkVONVBlRnhQejg5QVJHRUNBNG5nNEorNjU4YVU1emRZb0Uy?=
 =?utf-8?B?UGNiSmoxNUpzL2NBZ1dyeUlDSFdxeW44UDRGZ200WnF5SlhEdS8rVFV4L3Bu?=
 =?utf-8?B?bDA1WjdIdVJiMm4zcnZqUjZ4eWIzZmpPSm4vVFdmRURONGhvMmJBTEQzaGhO?=
 =?utf-8?B?QjkzTGVjVWp3Y2NQa2RaYjlVMmJJbjhrUXNNTWlmdzdiOGp1ZnRQMlNxYU5F?=
 =?utf-8?B?cE5aTEsrYU1xb0dQSXk1V04rMXk0Wk1aajFQZUhvRXoxOFhRTnA3YnVUcmFR?=
 =?utf-8?B?VEVoYmp3WHJsaVhaNk5Ob0JWY2ppZzlSeXBHUEVyeG9idGZoNzZSSWphaE1I?=
 =?utf-8?B?ZXlRci9OOUlaY2FCOVNjZ29EU3NoMStSRHloSStDR0FOOUxPWEpZRllJNm5B?=
 =?utf-8?Q?yVkND6035rJew?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkMvc1VJL3RiTHM5bk9FZDlEWDdCWlNxN0RGeS9HRml0azMweVVnakJtR2Nt?=
 =?utf-8?B?MURiUDFrOCtVNElKb2twc29rRTVLZkNLc3FQemJiTTFNM3RSOHNhVjdrSFo5?=
 =?utf-8?B?Vmt4M2poc0VWRVNseXVEVnpqUFAzMVJFaGJLcGkzVnY2V0ZFL2hBbHBJY0ov?=
 =?utf-8?B?ekJpc1JJeG43OVloYy9iSU9tS2JJemNvaWNwcVIxRGx2ZUhyMWk5ei8ySlJi?=
 =?utf-8?B?UEFuS0xXcG84Z3k4ejBXemczZ1RkeVg3THNPNUtpdFBwTUx0VjhNM3NTY3pS?=
 =?utf-8?B?WXFkamdsaVNnb2FiV2ZqM0ltRlJUNG1USElWckNVeWJOY1lHQjRqcVJBMWRz?=
 =?utf-8?B?cHJ5dUs2RG0zeG8zN1FqdFJsWmY4R21LdDlZRnBqR3F5NHZuVVB0Z1B5c1pW?=
 =?utf-8?B?dENiNitmZ1VrOUs1ek9pdHdYQ3RqTEVPYjFBbXBpcndIKzMyREtDMTl6bjQ3?=
 =?utf-8?B?Zm5VN0E4TDY5Q2lqY3NSRFJlM040VW1Ha2JmUlNiQ0dsYmdIYXZpYVdNaDFU?=
 =?utf-8?B?Zkc0S3FiNGxZT0Y5dUh1Uy84RHdFUEllcWhHUldKd2xoRE82ekMvb2E2Uits?=
 =?utf-8?B?OHVONkFnd3hrZmJUcmFIaTN6OW9SWmZCbTRoMjkzcDJXU2pPTm8zVUNOMXRC?=
 =?utf-8?B?dnRjR2o2YUtUelowSjRzZlIrb2xqcmRKK3NSajFoSmNZMDNZT2hMQWJSbW5B?=
 =?utf-8?B?TjZ4TVRydnduQVA3M05DN2lGcEVyc21ySzF1R2pRRFhkR0ptZnd1ZjlIT3NZ?=
 =?utf-8?B?blpFckpPS0VDdEhMQTFHdE5KZ0JkYzdWK0dJQm5LOXRXbElCUjgvMmQyd3NX?=
 =?utf-8?B?ckY3UXh1dURxaG9xbk9VRFpWK2svSDVSMEZWcVllSnVUOVVJM1pDTzVvOFBR?=
 =?utf-8?B?aGhlbFJVSGQ5SnF3aGwyd3VWd2QxSjFwTGRhelQ5RHdmbXpEb1JzL2pvcERJ?=
 =?utf-8?B?Z1hPd0JtMTBOUmg4bkdRcDZ1K24wOUNXbmVOWWtRWGtrNXNRMHo0MVQvcmtG?=
 =?utf-8?B?NEtsVjJMZTJLejhybVYweDJoUnNFRUxROEN2dXB6Z09ydTRNS09OUXdQRUlL?=
 =?utf-8?B?SVZXOXRvYlBlVlloSnh5Tk9SNHQ0Z1M0cFdXN2xZWThtMGZjSFRoQTNGVE54?=
 =?utf-8?B?bE1sWGZwd0hHaFMvcGE0YmlldXZ6YXc0VVZhTXhmS05hcjhFRENRQTlVVGRp?=
 =?utf-8?B?K0ttWXA5enAwWUpCQ2hWTVBhZlJiZHBqdXNvY0FQRUJJVDNYeG13YzVmYnlD?=
 =?utf-8?B?U05xVmJYZXA3YlJvaDdsSnVNeFBNUUZnTXJmdVkrRjd2RFlaTWtuQUg0Rmdq?=
 =?utf-8?B?ZUY1Tlp6NFNYOTEvNGxRY3pmS2grUHQrVXpwQWg0N0dSVDFONDF4K0grR1Js?=
 =?utf-8?B?Rkx1MDF0WUFKZ1VqQlpCTmJFNWZRV0hFd1VnWkpoMTZZQkZzRGpvU1UxbWNL?=
 =?utf-8?B?aHVlQU5oUWNucHMyb1JKdE04dDQ5N3JXT284OUUxYzdob2xDK3F0WWZsZDFj?=
 =?utf-8?B?OEg2MU1IR21TQTdsZ2d4MDM4VE5yQzVoZG1KMXpZWGRNOWhlT1JLc2k1djhV?=
 =?utf-8?B?SnpnREFuS3M1SXFlUWFqcDNPRmhRbjFCK1RuVTA5NXRUMzlxdlNoeTNqdUFQ?=
 =?utf-8?B?TGNsVmk3dytYVGk0akxtMFZUVndrUnptWkUzUHBUZ1VrWmEvTFhjaXp1bEpF?=
 =?utf-8?B?U3gzZExqVyt2NFV6dW93U2V4Z05GbWI1bU9iMlJidDlUYUo5K3FiZlllNFFK?=
 =?utf-8?B?Yit3RjBnc3dvLzFIR1MxcG1LWE9DTDBjKzZqa0E2azRLVENEckl6N24velNo?=
 =?utf-8?B?cFFrbUVnbGRpaVFKMmJta1VGZzhtTjZiVEo3bnFRa2dPYlFnVFRVczJKODBP?=
 =?utf-8?B?OW90VzBON05ReFBvOGxBa0VndGwzV1pQTGdsK1NNcHlkUFNZSS9BUlMvaVBM?=
 =?utf-8?B?SE5NeGJBcXhOaTVGZ1BCeUtrMUpRcGVsQmpIbXI1RHNGQmtnM2ZzUnBhVFZM?=
 =?utf-8?B?K2JGeXR0OUUxTld3ODh1MHFRamI2OUJvaWR2eUdBZWVLcTIrcE16N0JiZzQr?=
 =?utf-8?B?NDVpYWYwMHQ1OWQveE9oaDIwMHMxU2xYSnZ0N3o3MmNldUt5Z3FBN005U1p5?=
 =?utf-8?Q?J2se6+bWwLgOeotvsv5GLqe1D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 746d24aa-0e0b-4b03-3de7-08dd6a84fc4f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 03:35:55.9579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96Uyz9ZrRUa4RYfTKTyIy16PzY6j7goZ5OQgl8FdIWmUr3xqqcmPRfEiY8H2pzfvPiZBcMHTx0/3ogpHjCqyEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705

On 3/6/25 16:45, Bharata B Rao wrote:
> kpromoted is a kernel daemon that accumulates hot page info
> from different sources and tries to promote pages from slow
> tiers to top tiers. One instance of this thread runs on each
> node that has CPUs.
> 

Could you please elaborate on what is slow vs top tier? A top tier uses
adist (which is a combination of bandwidth and latency), so I am
not sure the terminology here holds.

> Subsystems that generate hot page access info can report that
> to kpromoted via this API:
> 
> int kpromoted_record_access(u64 pfn, int nid, int src,
> 			    unsigned long time)
> 
> @pfn: The PFN of the memory accessed
> @nid: The accessing NUMA node ID
> @src: The temperature source (subsystem) that generated the
>       access info
> @time: The access time in jiffies
> 
> Some temperature sources may not provide the nid from which

What is a temperature source?

> the page was accessed. This is true for sources that use
> page table scanning for PTE Accessed bit. Currently the toptier
> node to which such pages should be promoted to is hard coded.
> 

What would it take to make this flexible?

> Also, the access time provided some sources may at best be
> considered approximate. This is especially true for hot pages
> detected by PTE A bit scanning.
> 
> kpromoted currently maintains the hot PFN records in hash lists
> hashed by PFN value. Each record stores the following info:
> 
> struct page_hotness_info {
> 	unsigned long pfn;
> 
> 	/* Time when this record was updated last */
> 	unsigned long last_update;
> 
> 	/*
> 	 * Number of times this page was accessed in the
> 	 * current window
> 	 */
> 	int frequency;
> 
> 	/* Most recent access time */
> 	unsigned long recency;
> 
> 	/* Most recent access from this node */
> 	int hot_node;
> 
> 	struct hlist_node hnode;
> };
> 
> The way in which a page is categorized as hot enough to be
> promoted is pretty primitive now.
> 
> Signed-off-by: Bharata B Rao <bharata@amd.com>
> ---
>  include/linux/kpromoted.h     |  54 ++++++
>  include/linux/mmzone.h        |   4 +
>  include/linux/vm_event_item.h |  13 ++
>  mm/Kconfig                    |   7 +
>  mm/Makefile                   |   1 +
>  mm/kpromoted.c                | 305 ++++++++++++++++++++++++++++++++++
>  mm/mm_init.c                  |  10 ++
>  mm/vmstat.c                   |  13 ++
>  8 files changed, 407 insertions(+)
>  create mode 100644 include/linux/kpromoted.h
>  create mode 100644 mm/kpromoted.c
> 
> diff --git a/include/linux/kpromoted.h b/include/linux/kpromoted.h
> new file mode 100644
> index 000000000000..2bef3d74f03a
> --- /dev/null
> +++ b/include/linux/kpromoted.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_KPROMOTED_H
> +#define _LINUX_KPROMOTED_H
> +
> +#include <linux/types.h>
> +#include <linux/init.h>
> +#include <linux/workqueue_types.h>
> +
> +/* Page hotness temperature sources */
> +enum kpromoted_src {
> +	KPROMOTED_HW_HINTS,
> +	KPROMOTED_PGTABLE_SCAN,
> +};
> +
> +#ifdef CONFIG_KPROMOTED
> +
> +#define KPROMOTED_FREQ_WINDOW	(5 * MSEC_PER_SEC)
> +
> +/* 2 accesses within a window will make the page a promotion candidate */
> +#define KPRMOTED_FREQ_THRESHOLD	2
> +

Were these value derived empirically?


> +#define KPROMOTED_HASH_ORDER	16
> +
> +struct page_hotness_info {
> +	unsigned long pfn;
> +
> +	/* Time when this record was updated last */
> +	unsigned long last_update;
> +
> +	/*
> +	 * Number of times this page was accessed in the
> +	 * current window
> +	 */
> +	int frequency;
> +
> +	/* Most recent access time */
> +	unsigned long recency;
> +
> +	/* Most recent access from this node */
> +	int hot_node;
> +	struct hlist_node hnode;
> +};
> +
> +#define KPROMOTE_DELAY	MSEC_PER_SEC
> +
> +int kpromoted_record_access(u64 pfn, int nid, int src, unsigned long now);
> +#else
> +static inline int kpromoted_record_access(u64 pfn, int nid, int src,
> +					  unsigned long now)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_KPROMOTED */
> +#endif /* _LINUX_KPROMOTED_H */
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 9540b41894da..a5c4e789aa55 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1459,6 +1459,10 @@ typedef struct pglist_data {
>  #ifdef CONFIG_MEMORY_FAILURE
>  	struct memory_failure_stats mf_stats;
>  #endif
> +#ifdef CONFIG_KPROMOTED
> +	struct task_struct *kpromoted;
> +	wait_queue_head_t kpromoted_wait;
> +#endif
>  } pg_data_t;
>  
>  #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index f70d0958095c..b5823b037883 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -182,6 +182,19 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  		KSTACK_REST,
>  #endif
>  #endif /* CONFIG_DEBUG_STACK_USAGE */
> +		KPROMOTED_RECORDED_ACCESSES,
> +		KPROMOTED_RECORD_HWHINTS,
> +		KPROMOTED_RECORD_PGTSCANS,
> +		KPROMOTED_RECORD_TOPTIER,
> +		KPROMOTED_RECORD_ADDED,
> +		KPROMOTED_RECORD_EXISTS,
> +		KPROMOTED_MIG_RIGHT_NODE,
> +		KPROMOTED_MIG_NON_LRU,
> +		KPROMOTED_MIG_COLD_OLD,
> +		KPROMOTED_MIG_COLD_NOT_ACCESSED,
> +		KPROMOTED_MIG_CANDIDATE,
> +		KPROMOTED_MIG_PROMOTED,
> +		KPROMOTED_MIG_DROPPED,
>  		NR_VM_EVENT_ITEMS
>  };
>  
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 1b501db06417..ceaa462a0ce6 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1358,6 +1358,13 @@ config PT_RECLAIM
>  
>  	  Note: now only empty user PTE page table pages will be reclaimed.
>  
> +config KPROMOTED
> +	bool "Kernel hot page promotion daemon"
> +	def_bool y
> +	depends on NUMA && MIGRATION && MMU
> +	help
> +	  Promote hot pages from lower tier to top tier by using the
> +	  memory access information provided by various sources.
>  
>  source "mm/damon/Kconfig"
>  
> diff --git a/mm/Makefile b/mm/Makefile
> index 850386a67b3e..bf4f5f18f1f9 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -147,3 +147,4 @@ obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
>  obj-$(CONFIG_EXECMEM) += execmem.o
>  obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
>  obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
> +obj-$(CONFIG_KPROMOTED) += kpromoted.o
> diff --git a/mm/kpromoted.c b/mm/kpromoted.c
> new file mode 100644
> index 000000000000..2a8b8495b6b3
> --- /dev/null
> +++ b/mm/kpromoted.c
> @@ -0,0 +1,305 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * kpromoted is a kernel thread that runs on each node that has CPU i,e.,
> + * on regular nodes.
> + *
> + * Maintains list of hot pages from lower tiers and promotes them.
> + */
> +#include <linux/kpromoted.h>
> +#include <linux/kthread.h>
> +#include <linux/mutex.h>
> +#include <linux/mmzone.h>
> +#include <linux/migrate.h>
> +#include <linux/memory-tiers.h>
> +#include <linux/slab.h>
> +#include <linux/sched.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/hashtable.h>
> +
> +static DEFINE_HASHTABLE(page_hotness_hash, KPROMOTED_HASH_ORDER);
> +static struct mutex page_hotness_lock[1UL << KPROMOTED_HASH_ORDER];
> +
> +static int kpromote_page(struct page_hotness_info *phi)
> +{

Why not just call it kpromote_folio?

> +	struct page *page = pfn_to_page(phi->pfn);
> +	struct folio *folio;
> +	int ret;
> +
> +	if (!page)
> +		return 1;

Do we need to check for is_zone_device_page() here?

> +
> +	folio = page_folio(page);
> +	ret = migrate_misplaced_folio_prepare(folio, NULL, phi->hot_node);
> +	if (ret)
> +		return 1;
> +
> +	return migrate_misplaced_folio(folio, phi->hot_node);
> +}


Could you please document the assumptions for kpromote_page(), what locks
should be held? Does the ref count need to be incremented?

> +
> +static int page_should_be_promoted(struct page_hotness_info *phi)
> +{
> +	struct page *page = pfn_to_online_page(phi->pfn);
> +	unsigned long now = jiffies;
> +	struct folio *folio;
> +
> +	if (!page || is_zone_device_page(page))
> +		return false;
> +
> +	folio = page_folio(page);
> +	if (!folio_test_lru(folio)) {
> +		count_vm_event(KPROMOTED_MIG_NON_LRU);
> +		return false;
> +	}
> +	if (folio_nid(folio) == phi->hot_node) {
> +		count_vm_event(KPROMOTED_MIG_RIGHT_NODE);
> +		return false;
> +	}
> +
> +	/* If the page was hot a while ago, don't promote */
> +	if ((now - phi->last_update) > 2 * msecs_to_jiffies(KPROMOTED_FREQ_WINDOW)) {
> +		count_vm_event(KPROMOTED_MIG_COLD_OLD);

Shouldn't we update phi->last_update here?

> +		return false;
> +	}
> +
> +	/* If the page hasn't been accessed enough number of times, don't promote */
> +	if (phi->frequency < KPRMOTED_FREQ_THRESHOLD) {
> +		count_vm_event(KPROMOTED_MIG_COLD_NOT_ACCESSED);
> +		return false;
> +	}
> +	return true;
> +}
> +
> +/*
> + * Go thro' page hotness information and migrate pages if required.
> + *
> + * Promoted pages are not longer tracked in the hot list.
> + * Cold pages are pruned from the list as well.
> + *
> + * TODO: Batching could be done
> + */
> +static void kpromoted_migrate(pg_data_t *pgdat)
> +{
> +	int nid = pgdat->node_id;
> +	struct page_hotness_info *phi;
> +	struct hlist_node *tmp;
> +	int nr_bkts = HASH_SIZE(page_hotness_hash);
> +	int bkt;
> +
> +	for (bkt = 0; bkt < nr_bkts; bkt++) {
> +		mutex_lock(&page_hotness_lock[bkt]);
> +		hlist_for_each_entry_safe(phi, tmp, &page_hotness_hash[bkt], hnode) {
> +			if (phi->hot_node != nid)
> +				continue;
> +
> +			if (page_should_be_promoted(phi)) {
> +				count_vm_event(KPROMOTED_MIG_CANDIDATE);
> +				if (!kpromote_page(phi)) {
> +					count_vm_event(KPROMOTED_MIG_PROMOTED);
> +					hlist_del_init(&phi->hnode);
> +					kfree(phi);
> +				}
> +			} else {
> +				/*
> +				 * Not a suitable page or cold page, stop tracking it.
> +				 * TODO: Identify cold pages and drive demotion?
> +				 */
> +				count_vm_event(KPROMOTED_MIG_DROPPED);
> +				hlist_del_init(&phi->hnode);
> +				kfree(phi);

Won't existing demotion already handle this?

> +			}
> +		}
> +		mutex_unlock(&page_hotness_lock[bkt]);
> +	}
> +}
> +

It sounds like NUMA balancing, promotion and demotion can all act on parallel on
these folios, if not could you clarify their relationship and dependency?


> +static struct page_hotness_info *__kpromoted_lookup(unsigned long pfn, int bkt)
> +{
> +	struct page_hotness_info *phi;
> +
> +	hlist_for_each_entry(phi, &page_hotness_hash[bkt], hnode) {
> +		if (phi->pfn == pfn)
> +			return phi;
> +	}
> +	return NULL;
> +}
> +
> +static struct page_hotness_info *kpromoted_lookup(unsigned long pfn, int bkt, unsigned long now)
> +{
> +	struct page_hotness_info *phi;
> +
> +	phi = __kpromoted_lookup(pfn, bkt);
> +	if (!phi) {
> +		phi = kzalloc(sizeof(struct page_hotness_info), GFP_KERNEL);
> +		if (!phi)
> +			return ERR_PTR(-ENOMEM);
> +
> +		phi->pfn = pfn;
> +		phi->frequency = 1;
> +		phi->last_update = now;
> +		phi->recency = now;
> +		hlist_add_head(&phi->hnode, &page_hotness_hash[bkt]);
> +		count_vm_event(KPROMOTED_RECORD_ADDED);
> +	} else {
> +		count_vm_event(KPROMOTED_RECORD_EXISTS);
> +	}
> +	return phi;
> +}
> +
> +/*
> + * Called by subsystems that generate page hotness/access information.
> + *
> + * Records the memory access info for futher action by kpromoted.
> + */
> +int kpromoted_record_access(u64 pfn, int nid, int src, unsigned long now)
> +{
> +	struct page_hotness_info *phi;
> +	struct page *page;
> +	struct folio *folio;
> +	int ret, bkt;
> +
> +	count_vm_event(KPROMOTED_RECORDED_ACCESSES);
> +
> +	switch (src) {
> +	case KPROMOTED_HW_HINTS:
> +		count_vm_event(KPROMOTED_RECORD_HWHINTS);
> +		break;
> +	case KPROMOTED_PGTABLE_SCAN:
> +		count_vm_event(KPROMOTED_RECORD_PGTSCANS);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	/*
> +	 * Record only accesses from lower tiers.
> +	 * Assuming node having CPUs as toptier for now.
> +	 */
> +	if (node_is_toptier(pfn_to_nid(pfn))) {
> +		count_vm_event(KPROMOTED_RECORD_TOPTIER);
> +		return 0;
> +	}
> +
> +	page = pfn_to_online_page(pfn);
> +	if (!page || is_zone_device_page(page))
> +		return 0;
> +
> +	folio = page_folio(page);
> +	if (!folio_test_lru(folio))
> +		return 0;
> +
> +	bkt = hash_min(pfn, KPROMOTED_HASH_ORDER);
> +	mutex_lock(&page_hotness_lock[bkt]);
> +	phi = kpromoted_lookup(pfn, bkt, now);
> +	if (!phi) {
> +		ret = PTR_ERR(phi);
> +		goto out;
> +	}
> +
> +	if ((phi->last_update - now) > msecs_to_jiffies(KPROMOTED_FREQ_WINDOW)) {
> +		/* New window */
> +		phi->frequency = 1; /* TODO: Factor in the history */
> +		phi->last_update = now;
> +	} else {
> +		phi->frequency++;
> +	}
> +	phi->recency = now;
> +
> +	/*
> +	 * TODOs:
> +	 * 1. Source nid is hard-coded for some temperature sources
> +	 * 2. Take action if hot_node changes - may be a shared page?
> +	 * 3. Maintain node info for every access within the window?
> +	 */
> +	phi->hot_node = (nid == NUMA_NO_NODE) ? 1 : nid;

I don't understand why nid needs to be 1 if nid is NUMA_NODE_ID? Does
it mean that it's being promoted to the top tier, the mix of hot_node,
tier and nid is not very clear here.

> +	mutex_unlock(&page_hotness_lock[bkt]);
> +out:
> +	return 0;
> +}
> +
> +/*
> + * Go through the accumulated mem_access_info and migrate
> + * pages if required.
> + */
> +static void kpromoted_do_work(pg_data_t *pgdat)
> +{
> +	kpromoted_migrate(pgdat);
> +}
> +
> +static inline bool kpromoted_work_requested(pg_data_t *pgdat)
> +{
> +	return false;
> +}
> +
> +static int kpromoted(void *p)
> +{
> +	pg_data_t *pgdat = (pg_data_t *)p;
> +	struct task_struct *tsk = current;
> +	long timeout = msecs_to_jiffies(KPROMOTE_DELAY);
> +
> +	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
> +
> +	if (!cpumask_empty(cpumask))
> +		set_cpus_allowed_ptr(tsk, cpumask);
> +
> +	while (!kthread_should_stop()) {
> +		wait_event_timeout(pgdat->kpromoted_wait,
> +				   kpromoted_work_requested(pgdat), timeout);
> +		kpromoted_do_work(pgdat);
> +	}
> +	return 0;
> +}
> +
> +static void kpromoted_run(int nid)
> +{
> +	pg_data_t *pgdat = NODE_DATA(nid);
> +
> +	if (pgdat->kpromoted)
> +		return;
> +
> +	pgdat->kpromoted = kthread_run(kpromoted, pgdat, "kpromoted%d", nid);
> +	if (IS_ERR(pgdat->kpromoted)) {
> +		pr_err("Failed to start kpromoted on node %d\n", nid);
> +		pgdat->kpromoted = NULL;
> +	}
> +}
> +
> +static int kpromoted_cpu_online(unsigned int cpu)
> +{
> +	int nid;
> +
> +	for_each_node_state(nid, N_CPU) {
> +		pg_data_t *pgdat = NODE_DATA(nid);
> +		const struct cpumask *mask;
> +
> +		mask = cpumask_of_node(pgdat->node_id);
> +
> +		if (cpumask_any_and(cpu_online_mask, mask) < nr_cpu_ids)
> +			/* One of our CPUs online: restore mask */
> +			if (pgdat->kpromoted)
> +				set_cpus_allowed_ptr(pgdat->kpromoted, mask);
> +	}
> +	return 0;
> +}
> +
> +static int __init kpromoted_init(void)
> +{
> +	int nid, ret, i;
> +
> +	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +					"mm/promotion:online",
> +					kpromoted_cpu_online, NULL);
> +	if (ret < 0) {
> +		pr_err("kpromoted: failed to register hotplug callbacks.\n");
> +		return ret;
> +	}
> +
> +	for (i = 0; i < (1UL << KPROMOTED_HASH_ORDER); i++)
> +		mutex_init(&page_hotness_lock[i]);
> +
> +	for_each_node_state(nid, N_CPU)
> +		kpromoted_run(nid);
> +

I think we need a dynamic way to disabling promotion at run time
as well, right?


> +	return 0;
> +}
> +
> +subsys_initcall(kpromoted_init)
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 2630cc30147e..d212df24f89b 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1362,6 +1362,15 @@ static void pgdat_init_kcompactd(struct pglist_data *pgdat)
>  static void pgdat_init_kcompactd(struct pglist_data *pgdat) {}
>  #endif
>  
> +#ifdef CONFIG_KPROMOTED
> +static void pgdat_init_kpromoted(struct pglist_data *pgdat)
> +{
> +	init_waitqueue_head(&pgdat->kpromoted_wait);
> +}
> +#else
> +static void pgdat_init_kpromoted(struct pglist_data *pgdat) {}
> +#endif
> +
>  static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
>  {
>  	int i;
> @@ -1371,6 +1380,7 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
>  
>  	pgdat_init_split_queue(pgdat);
>  	pgdat_init_kcompactd(pgdat);
> +	pgdat_init_kpromoted(pgdat);
>  
>  	init_waitqueue_head(&pgdat->kswapd_wait);
>  	init_waitqueue_head(&pgdat->pfmemalloc_wait);
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 16bfe1c694dd..618f44bae5c8 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1466,6 +1466,19 @@ const char * const vmstat_text[] = {
>  	"kstack_rest",
>  #endif
>  #endif
> +	"kpromoted_recorded_accesses",
> +	"kpromoted_recorded_hwhints",
> +	"kpromoted_recorded_pgtscans",
> +	"kpromoted_record_toptier",
> +	"kpromoted_record_added",
> +	"kpromoted_record_exists",
> +	"kpromoted_mig_right_node",
> +	"kpromoted_mig_non_lru",
> +	"kpromoted_mig_cold_old",
> +	"kpromoted_mig_cold_not_accessed",
> +	"kpromoted_mig_candidate",
> +	"kpromoted_mig_promoted",
> +	"kpromoted_mig_dropped",
>  #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
>  };
>  #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG */


