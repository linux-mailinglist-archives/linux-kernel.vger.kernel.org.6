Return-Path: <linux-kernel+bounces-366571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0C599F73D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBED284AF2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7491F80D8;
	Tue, 15 Oct 2024 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hBQGpFn1"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2BF1F80A9;
	Tue, 15 Oct 2024 19:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729020312; cv=fail; b=F353WfrK/uuGOo6/xE14l6aef8ef71HbdPf+acfcBSLkm49uIO216X8r2TkPvfDURUmsYoQ3laj42lPf1HkBOn+8qDlLzhzdKcrWSY4Hyn5dEJsRQj9PjNfB0iUHYc6zz9BRiXkkRhtU6Vbe7YZu5eKvTaEtV1McaPo1baLkoNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729020312; c=relaxed/simple;
	bh=VRAZtLGvqcl1VcJ5QEIBZrI5desMA+7vpbmHxt+tKBk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pLsu/W1XWQIOEWohbrhOb8bKEqbdHPLgA9xveJSfJjw2hQh77Hd5ri5mhcQ1vtYITBVW8xiQcvCuASAk0AdwLRrtrxFSWDsVd3jzBZ9XXkebWyfGKW2NIyCm0ucvI9m+yNLR3u1iw+ew2jhCLk8/QsD6DUaOYsqHD7Xov1TJMH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hBQGpFn1; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDGL0XrFS9GXOgfFeqqbQ5b3P3msP7NPVkg1L70UV7dEtV35+XE3ENjh+U7TJimRMpuOeHYafxAj/rKRl1V7BrqD/nWek88vGkj17nBF3f3exOXEjM9fCfVdukQHdadP/vaiAS1LHJgTDgqBrN94VpbFNyFTiZBNBEUZ3KsIcYsWatQ5C00I2w36DvywFLVB4M/8vMdkeDbWIH8PcDGHS30wPZIABINB5yGAHCvEV9kymQ56RvrnZjalvUYxYxJzVK/q5DnHApt7PR7yZUKWtlgCL8minYNaKLVRgVFUGE+twOGFI633lG6ZiC+x7uE13isIHemmRfo1vnnN+3XBpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgkxWpEForSeFjX5TgwqqtQak6M4AjCPpbgXgK1+OjM=;
 b=QE0CYnH1D0G+vHXWRwMKu0WP69Z/K77tH/KWQJ8JqrMkwRE5zaRFLQ+Q9W45pdHpMY35sx/2rbB53/ODA7q+xgLNB4Zgqljs0KAnsU7goUgUjN53HY5r9C79FpKxEmnYLu2XTYsMX2ZGmhwmrORlhtDNRaVBvxU/4VrnbvFmFJzS2M/fksLgFYdbQFIqcjTt4V0E9I2HEi0yigzSe6+XYpsQAuQecS28LLJKiEtVXUihrdggoCatHhpW6BtSmh60bjj8p1/D4u4h9zLO6vVdEKyxb+v4fe4Y1dorOWJGxiKl4X8GQ8dPx27Zh0zBb6+vUG7ZJmC+SU2fribfbZEoOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgkxWpEForSeFjX5TgwqqtQak6M4AjCPpbgXgK1+OjM=;
 b=hBQGpFn15Yw88cHQG7CVENhyIz71hRpYUnc87Cr8xGqgwFwYixewSb3MQuzIkbdCTl5z9volN8cTVUPcvajVGd9PF3uYMjiyDxjNf3gq4xY6EE0rQOZwH7gsGsHmKM/+cET9kyTGGVKboMGCvttwA/B5O1p9/El4sIinOudsl1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH8PR12MB6842.namprd12.prod.outlook.com (2603:10b6:510:1c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 19:25:08 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.029; Tue, 15 Oct 2024
 19:25:08 +0000
Message-ID: <a6a1dde1-5b4c-4c3e-a9e7-b2f2b327894e@amd.com>
Date: Tue, 15 Oct 2024 14:25:04 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 5/7] x86/resctrl: Add interface to enable/disable SDCIAE
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org
Cc: fenghua.yu@intel.com, hpa@zytor.com, paulmck@kernel.org,
 thuth@redhat.com, xiongwei.song@windriver.com, ardb@kernel.org,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 sandipan.das@amd.com, kai.huang@intel.com, peterz@infradead.org,
 kan.liang@linux.intel.com, pbonzini@redhat.com, xin3.li@intel.com,
 ebiggers@google.com, alexandre.chartre@oracle.com, perry.yuan@amd.com,
 tan.shaopeng@fujitsu.com, james.morse@arm.com, tony.luck@intel.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1723824984.git.babu.moger@amd.com>
 <e43947374dd9124ef5a6c677d0ec3ab715b6a7e7.1723824984.git.babu.moger@amd.com>
 <cd0585f6-1d90-4ef1-9a10-7db50cb879ea@intel.com>
 <ecdffce0-796b-4ebe-8999-73f2be1e703b@amd.com>
 <ec170d40-7390-4cc7-9128-d200df7405ee@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ec170d40-7390-4cc7-9128-d200df7405ee@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR01CA0019.prod.exchangelabs.com (2603:10b6:805:b6::32)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH8PR12MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f81238-231f-40c8-0cd3-08dced4f1450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnFsU24xWS9VbHNCRXRZWTcvOS9QN2kzVWpGZWIwSUhJUTJFMEgzTXpRRzc1?=
 =?utf-8?B?K0syRitDMTBHMmk0UnRMM3pkaEdGRHh1ZXNiM2QwTXN6MDA2NXc5djIyejd1?=
 =?utf-8?B?VkhMcVZnYzFrY2xNUmJKYnMzUktNY2tXcTR4d1k0RWZhTk1EVVoxWmNVVlNG?=
 =?utf-8?B?b3IyakRkNXJ6TlgwZUhMdWcxTmJoRjFjdlMrWFdxdGE1U0Rmem5oVnliWlJu?=
 =?utf-8?B?bEdLazhJd0VRT0l0d2RTUjFOYlVacmxkYkd3ZGpORXlkMlhMeFdpZTA3YkQ0?=
 =?utf-8?B?aTNOelJob0Fmb0lwaHBvSFQwR0RkL2xXbE1YUGNDTk5DQlFCYkVwZ2RXUkRs?=
 =?utf-8?B?L3RFT1N1bEVNRHpkZGhJNCtoVmZwMEdMOHlkZ2UvYTM3dVVKemNSQkJ5WU5O?=
 =?utf-8?B?TlRDRU9sRVh6SzlhR3ExdkNnT1pSQW8ySkgzN2U3ZjdGYUp2aTd5QTl5aFAr?=
 =?utf-8?B?T1F0Uk5wSVFIQ3hmYjFNQ3JwUHNrcDlaMHM2SDgwR1VoelNuTnZLc0x1NDRE?=
 =?utf-8?B?TjI1NXc0SWVmWUNWQXd0QWVJZVFUZS9QaDVpSFRjbldGVUpzS1hzNkhPOEQx?=
 =?utf-8?B?RUthZFEvdndhRkgvaDA5NlI4eDJ2MC80VWkrcXgxcjdlVFp5eDFPVzBITVZy?=
 =?utf-8?B?MEVramZqaUJZQ1dZUEduZWJualVJSmhnK2NjS05QTURtalBWRCtQb1pRZVZD?=
 =?utf-8?B?VjFvNWsvWWM4NjNmUzFXR2N4Tm5GVUZ4Nk04dHpVdXJGbkhCVUh0UnRpd2kv?=
 =?utf-8?B?Q0VndmcyMk9hdnY0NWlqcWFkanpTalJJNklTNVhEL2VpMnQ1Z2tRZ0p1cGVV?=
 =?utf-8?B?b2lmMnZ5cTdVZXRMUGVhNm90RGRBQnhjRzJQaWEzL2VGOVlZMzMrc0locS9o?=
 =?utf-8?B?aEVpSTZtWlFPcGNjZzQ3eTM2TE5lSDIwbzc1UHRiRStDWU5pTXVkQkxpbFV1?=
 =?utf-8?B?elUzb1ltUXhyak1WSUVKczVQYklsNFJ2V3Q2V3ZFc0tXSlVWUGlrdm9wWC85?=
 =?utf-8?B?YlZMU3BhT0Qram1TWENhRlJZRDJJN1NFSGtEcm1FS2NabEJXQTlXVmF6V0pZ?=
 =?utf-8?B?NnN4bUxmZ3g0RGFZQmp0SWgvc05pdnF2Tnd2NSs4TE5hQ21DQjMwbFRkeThF?=
 =?utf-8?B?bUt6cThSTDNZZVdOeXdURTdMdmo2dy9lSFk4RzdFbmpnRGtxQnhNdk96MWZ0?=
 =?utf-8?B?blpoOWxHaHRFZ1hkVjhwRUdmYmxiOWJTUEJFNnZzRHoyNHlnWWdpdFlCU2dP?=
 =?utf-8?B?TGo2SWJYRUpSVFVxR0o1VlI3d1RHSExBQmZ0aUxiRStyK0x1TDNFN0QxU1Zv?=
 =?utf-8?B?Mi9ZTGpCbGtYYndQR2F0U3JkTTU3K3pQTnB1dmdvVDlDRS9yUmhnbmJlRUNB?=
 =?utf-8?B?S1R5b0thNHREUFNiUFpFYlhqdVNBV1VLSXZYeitSUXBHNG5tTysxQ2RRVEIz?=
 =?utf-8?B?WTVKZitBYzRqUGxKbzlOTDBkYW5TVDViZ0FESTBJVzBYRjE4UFMyQkpkODk1?=
 =?utf-8?B?cStnNmpsaW9JcVV3M3RJKytlWjFLWEgvM0N3NFRCQWM0OEYzcGMrQWF3RUQ5?=
 =?utf-8?B?cDN1Z0gyYzVnaTVZWG02UkYrTHp3cjVqMS8rTmk3NzB0ckZqcGxQcVFlVVFL?=
 =?utf-8?B?SXIvTHFHWlVOMkhSd0c4S093YisvTmpQTUZkTzI0Yy82QXREWUhEYTRCTWU4?=
 =?utf-8?B?bFR2cjBrUGZZbDU1OE9KYmpQSTExTUJJNmJ3RGRNUHNrZ1cvem4yNGR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWdQUWxyRnNWdDN0dDBVSFV2TzErZkJIVEZETVNSWWw0anZHL3RTSVpTVHo2?=
 =?utf-8?B?NmFsdlozbkcvTTRHSGFoTTkvU3dDc1Z0eEVzbW9kS0hkTnp0UXZWeTg2Sy9j?=
 =?utf-8?B?M2pZWWg2TzQ1ZEFCWmlhVnUrbDJXRUdWaFo5RmRFNTBqdnJob2lwLzhXMHZh?=
 =?utf-8?B?TnJLMWZscGlISnJXSkNUajhEbmFRaFNsSHJvTWl2WUpRT1p3aEdEa3NzRDlV?=
 =?utf-8?B?czFObERDQWxPVUgrNzBNSFlYdXVEZWM2Z3MwdlhmRUVPNFBsa0syTVRPUWxn?=
 =?utf-8?B?ejExdmI1WXdOMXRZbjRKa084NXk0dE9ZS1YxQkNrZlhyQ3RMS0dFYU4ySTA5?=
 =?utf-8?B?YkNWcXJCK3c1T0J5TmNyV1gvZGIreWN2UGNWTlVyWjFsOEJKdTUwRWh6Tllx?=
 =?utf-8?B?dVlveFloeUsrbXczNmVKU0FMRnJQRyt6di9nUE5oRWJ1UGVQSVp2eFh4amEr?=
 =?utf-8?B?aEI1amg4KzdBMi9mTkJKQjR2RWdXeEVxc3kvYjh3SUZNby9BUDZHWUVPbGVH?=
 =?utf-8?B?QUNuYnFkUmNZbFk2YmFWK04zV0JUdHE2aGJZeFpvaktHVEs5Zi9VaUJQc1pJ?=
 =?utf-8?B?SzMzbldEWmFoeFN2R3ZQczRSWmNJZ2tLOVIrbUZzTU85WUpNOUZzcWR1cVlO?=
 =?utf-8?B?SHc3V2x2bXhkUlNmbWl3dkhqbHRoOXR3OGhrVWozWjlqSTc5MXRoZ01nVjdn?=
 =?utf-8?B?eWJVNDNBZFoxT1RCSHBodTlqbTJnbkovdXBKZkRWNFJLWTlPL0F2WjZ1Uk5D?=
 =?utf-8?B?TUVoMWFta2FUaUM5UFhCSzQ4aEFrVytFWXA5RTh1ZXBIb0Jka3JqNmhCb3Y3?=
 =?utf-8?B?N3BhMU5DYXVKYkhtUUttQ1ExNEJhOFBkbmQyZTkxbkxDalBMMkVSc1ErVXZj?=
 =?utf-8?B?enQrWnBvdTF2Wjlza3Z0QWRpWWFqcW5uMEpZR0hBZWtyRGNoRDdtdFFSaGtU?=
 =?utf-8?B?dUVNbERaWWNWbjI2UUltdFRRZm5EeXlGcHNhTG4yeTQrZ0ZFS2RIRjJWeFl1?=
 =?utf-8?B?QldxbFAxMm8xYkdFWTA3c2JsUlRXaW1XNWxlMFNrVUFGbm1XZ201L2dxL0xJ?=
 =?utf-8?B?K0pSQWhyd3B6UG9XclJORFEzempRQ0R3YlFBT1U0V0hQc2V0Z1ZURng0bHhz?=
 =?utf-8?B?YmlpSnYwZFhYcGNLM1FubGdzekU3SG5DTnNDdUlhNFhOaVIvNVMwRmkyZUpQ?=
 =?utf-8?B?c3pkcStqRHFMVGM4MllFY2dBcWJPTFM3SVc3R0N6VXNwMG8wbCtEZm1EbHpj?=
 =?utf-8?B?VzZaZ25xWTJ6RWFwMU5ZTWp4K0s5Vm9OTkd5dWJ4TG1XQ0lwV25lQnhiL0Jq?=
 =?utf-8?B?YWt5MDFDL1A1MFhuaitvbm01MHQ0OEg4SHRNaFlBbkdRM2p2UUJoOHIyOUdh?=
 =?utf-8?B?SkkySnVNVHhPZkJoM09Fa3dHdGJsaG1Ldy9RbUZHTDNhaWxxS3hndUg2d01a?=
 =?utf-8?B?SHN5ZXJkcTY3TTJRQ2lab3h4d3FuaTJSWFJ3bHN4dnhFTitoYjgxeUs1NG1X?=
 =?utf-8?B?K3p2ZXYvZW5FOXJ1TUNhcDlDUVdBU1NNQXVtVFVHTUVRSW5odWJhOFZmTEhD?=
 =?utf-8?B?L3NNSzZjL1ZNeTRSa08yNkdEM01VUWpmVHRhTWpla3B4R2tMc09SbGRKZTN2?=
 =?utf-8?B?aGFseWpMRldhd3VzKzVwRnRXdHlHUkVGNVpuempqbk4weHcrNGtadDcwUVE4?=
 =?utf-8?B?UXRORXdlMlNEZnN4amYvL1pLQVNSbnRZYWtnazUzMS9IcmFlOXJMNnlWbFBq?=
 =?utf-8?B?QjA3UDRQZG1FZDF4b0tjOEJiajFnK3Zmd2xGdVVtMEh4QWQrdVVxNGMyK2Rw?=
 =?utf-8?B?dDJpYUxBM3B5UGNCZ2ZOWS9YeDBzajR2UGswU0R2SERQYzFlVHpMa1I5ZUZa?=
 =?utf-8?B?NjBWc3hBQmpzTXFxdXhoMHpRdE9XcXlSbVQyUStvZFp2UU1MaE5iVlVaL0E3?=
 =?utf-8?B?YnFKOTFsQXpmZEFobExRcHREd041bjI4cnJnSE9ySXFSemZZc1cvUkRMV2JZ?=
 =?utf-8?B?TzBrUjlXdEpudmpyVWVJR3lQNENXQytPVmt4SitMYzU3dnZVUW5HOHorMHh4?=
 =?utf-8?B?OFBHc2lQUDJuYUorSFFaNUR0S3BhVWhaZlY0NHhNdkVSa2VkUGk4aVRPUitC?=
 =?utf-8?Q?tQD0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f81238-231f-40c8-0cd3-08dced4f1450
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 19:25:08.0518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6uL/STVvv4dk1b3VjPJvU9cP8YcuYjRHdh+9GZiU5weNpW6c6qKTY6Z8qlo8DXE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6842

Hi Reinette,

Noticed I didn't respond to this comment.

On 9/19/24 10:35, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/18/24 1:10 PM, Moger, Babu wrote:
>> On 9/13/24 15:51, Reinette Chatre wrote:
>>> On 8/16/24 9:16 AM, Babu Moger wrote:
> 
> ...
> 
>>>> +        if (enable) {
>>>> +            ret = closid_alloc_sdciae(r);
>>>> +            if (ret < 0) {
>>>> +                rdt_last_cmd_puts("SDCIAE CLOSID is not available\n");
>>>> +                goto out_sdciae;
>>>> +            }
>>>> +        } else {
>>>> +            sdciae_closid = get_sdciae_closid(r);
>>>> +            closid_free(sdciae_closid);
>>>> +        }
>>>
>>>
>>>> +
>>>> +        ret = resctrl_arch_set_sdciae_enabled(RDT_RESOURCE_L3, enable);
>>>
>>> I assume that once SDCIAE is enabled the I/O traffic will start flowing to
>>> whatever
>>> was the last CBM of the max CLOSID? Is this intended or should there be
>>> some default
>>> CBM that this feature should start with?
>>
>> It will start with whatever the last CBM for max CLOSID.
> 
> This seems arbitrary based on whatever allocation the previous resource group
> using the CLOSID has. When a new resource group is created resctrl ensures
> that it is created with all usable allocations, see rdtgroup_init_cat().

Checked again with with the team here. When SDCIAE is enabled, it uses the
value in L3QosAllocMask15 (value in L3_MASK_15 MSR).  Enabling SDCIAE does
not change the value of L3QosAllocMask15.


> Letting cache injection start with whatever allocation remnant programmed
> in a register does not seem ideal. What if, for example, after that resource
> group was removed, a new exclusive resource group was created that overlaps
> with that allocation? 

In that case. it will share the bit mask with the exclusive group. We may
need to add a text about it.
-- 
Thanks
Babu Moger

