Return-Path: <linux-kernel+bounces-227445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFE691514E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726831C22E85
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB89B19B586;
	Mon, 24 Jun 2024 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4GADix+B"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DD219B3FE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241447; cv=fail; b=ikbz56GpQMDcNL+lKLPOs8GgnUDSt/Bn49i0x5X/MWwwftJZfJKvXLZeecv58G52E6Az2IUpijsVJ/0BAwILP6zZgJOQo8CNVvQkZGNbsqN2MNPD4roPIUTZQ1ArStvqX06ynR8Z9UnMBdKsBnGBw0h33pVqWZAsHeyNX0mS/M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241447; c=relaxed/simple;
	bh=zyU+rNCDSga9Uq4VoMCGe2Zvuc4b3RAEr58AnO3681E=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=V6/SFte4I3rVy0ky/D4nNKMw+jUbkfwuMdzZCOgIXW4XI+2Z3CbO0eCEO2gaT0vhtljAW3OdgOu+bjTuJZmvyqwhfaygHS7yOtG3RbmHESDstPY2e6/EqpkCkz2yHs8e3uFd+OCIse2BOuFRowjJWIfpFNVk0Dlk2bqmGIqA+zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4GADix+B; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBgzHIDU7UGd8rFSBAFVD/BwB/T4eh+DzqrXeBJSBr5c/FPJmIZYT8lyHCh8nuYU2EEolf1z9DenB1CP0rzX0RygbvfCofqqqMEvMf99ZNIrwVmAZNjXgo0/duGVN4pL0bX8wTuAlcUwOBWAlJC3te10wPNySIodaodIskgPVZDU9B8Zw2B0T8C6OxbWWvtTur+kEEzDnX8/E5WVh2TrIC9y8SsKwxMeVZ1wd2eBDXQuYvIHi7twnsp2Fp0QfPJtI+sxO0RMXImlL9M/EHYhzj4AJsrAbioiRxATm3XN5uzXkBdC0ED3pZ9bQA7wtoVf8BWnKR23KrDnGhEbnV3SzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5x4ioisHO8noZHX+E9fTa+4ZB3SRbQcYo1rwsvTUR6U=;
 b=CnBFNsYWCE5e9rTNJ2+7Gdu89kMXPF/UPP2OIgcTs3HDaD5s7z+P6aJVElqtFgi3kic37sv4MM+sQ717Yu8XXZhQ5sAaewUOHXxuCOk76KPn1foonkc8t7JXSW+gHblYVGgs/Gmcq57ZvVaSUrho6C6ZbKPTCEhNgR21zHXTgsYYznN47sgpWutL54A+puFHYjX8Wr6xf6xZjI1+pPNSXCndTWxecAUMFHZehYC//SBOkIi+t0M6aWbYyl0PwcgbnYZw6Wxp7sbfQjnCJo74seKG5F9m+3Thb/IEUGaHt4L78KuNrZ8dVH30jcl17kNxpQ36ABeU1khteaVcNCE0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5x4ioisHO8noZHX+E9fTa+4ZB3SRbQcYo1rwsvTUR6U=;
 b=4GADix+BJ+wjkNwjiR1qkLUo/S9Eb8KZCpMBurONuqyChD4UKwdvk4SMx9g1x9bvXZwarN5i/OrsKd+dIRr+zXvJqGy/f0SlgmGPzp9nm5lDQpz28FPj0UPNKX6Ppx4oqWIdWco2IwiZPA9IkF/igvzG6jbJHdlDyY4WQA+5QjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CY8PR12MB7681.namprd12.prod.outlook.com (2603:10b6:930:84::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Mon, 24 Jun
 2024 15:04:01 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 15:04:01 +0000
Message-ID: <c7bb1de4-604c-5bf3-72fa-7d955df84294@amd.com>
Date: Mon, 24 Jun 2024 10:03:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
Cc: rafael@kernel.org, hpa@zytor.com, peterz@infradead.org,
 adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, michael.roth@amd.com,
 seanjc@google.com, kai.huang@intel.com, bhe@redhat.com,
 kirill.shutemov@linux.intel.com, bdas@redhat.com, vkuznets@redhat.com,
 dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de,
 ardb@kernel.org, dyoung@redhat.com, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
 <cover.1718920799.git.ashish.kalra@amd.com>
 <42f56d2405522cc207b59235506c0b5bec67123f.1718920799.git.ashish.kalra@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v9 2/3] x86/boot: Skip video memory access in the
 decompressor for SEV-ES/SNP
In-Reply-To: <42f56d2405522cc207b59235506c0b5bec67123f.1718920799.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0187.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::12) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CY8PR12MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d82168-0816-49b8-4e0c-08dc945ee166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUgrN2dUZ3NIQnd2R1pNZ21XU040R3dTY3c5MzlpVEV4TFpTTTNGUTE4bUZJ?=
 =?utf-8?B?RXVoTS9ON3lrcEVTSTcvS1RMTWN3NUpyVExBTjQ2SVgwa0NkdC85eEdYNUVV?=
 =?utf-8?B?U2FPYUFLRi9lS21rc3dTeXhhSU9xTXlTdldtUWJ5UFJhNFVGVkZkcEZPQ0p0?=
 =?utf-8?B?anZ0UkVFRmtpUkhkWDk5WjZTL0lsendlUnZJSEhBZVZoalEzL2ozWUNsRDNt?=
 =?utf-8?B?NEN0WWEvZFdYbUlwQ2JQSVMrR1ZjRWw2UHNPNTArV3ZEQjJFc3ppY0tPZU9Z?=
 =?utf-8?B?R1BPeUpSTGIzRjczSElvQmNrRHdhbkpQeTVJUGczWGpGY2tZYUQxdGNmOHNt?=
 =?utf-8?B?dVBHcDljRXU5ak8vUWFRcFVNcG5HUllrbzY1cGREMFIvbUMxa0RHbGNKNVlv?=
 =?utf-8?B?VG1YQ2Yzb2dHamluRGlHTWhMTVFqWFFqNHlFUjEvTWZMNXdkLzdpNEhRV0p5?=
 =?utf-8?B?b3dUb2YvT0xMRGZIRFZVQnU0ZHg3ZzliYWhNWUxWRk42LzR5T1g0TmhkWjVP?=
 =?utf-8?B?VU15WjUrWnlKWisxaG5iL0JVU0NxRW5mTDVyR3BtUHhaRTZPcnp3eUNTeS9v?=
 =?utf-8?B?OTMwODdOa2Z4RXUwcGlENHgreUJFa3FocURvMmY3bnFob0s1OElGUXVVZ2FL?=
 =?utf-8?B?Wk0yaFFVYk96WlpyYU9TZUd1Z0hrb0Nmc2RTTHI1WE1yc1UyN0JTbEd5L0pH?=
 =?utf-8?B?aFFXMkM2b0xwcnNRMVNzY09CNC84K3dBYjZQSmViN2VZeWhGRC9aU25VWFA3?=
 =?utf-8?B?WU5kV1FGTW1pNUdOL0pxdWdOYnJSQVVnc09CZTQ2ZkRzNU5ZdVpyeXQwbWs0?=
 =?utf-8?B?VWg1OElUMU5DajczQUlCb0dDV2sxRHZvNTVJcWRSREx6czNiTDkzOUhoenpC?=
 =?utf-8?B?NlZaSVlleUlQV0VjZVVoVlZRZkVKd0xUVWNuWTk4ZlRJUlVhUnZYalUzRGJq?=
 =?utf-8?B?MEVHeHp2TFdIbHczMVk2TGc4SUppQ0g2WlNsUW5GQnY3L3cyMFl6NXdKc0N1?=
 =?utf-8?B?dU9RQzdXYkhYZlYrZGRiUjhsZWZKc0J0WDZIb1FFNm5wSmhJVG5TUnE5RWV0?=
 =?utf-8?B?ZzhCQ09HdDZ2TWNlMk4rZmxWQm9WbkNHZmFubXhvMVBBdnpTQjIzWVgvKzFh?=
 =?utf-8?B?UFdZdEk2YmJBUlB5NlVDTjFmZ2dMVlN5TmhDN0RPYkIzTWpCUUJwM01ERkdM?=
 =?utf-8?B?L2pybm4rUnRVN25SajZsMGhSUzBSMUNTTzRtMHJ5bVhPRzZEMkNXOGhGd20y?=
 =?utf-8?B?bjdDZ2tPYXRoYWs1ay9sL0tmaGxyelRXVzByTVFtWExwcTlYSkEwem9wdmR0?=
 =?utf-8?B?cEVjU3ptaFR2dkpOdGt1bWMxMHBDdlhuVHVoODl1YjNOWnpmd3BYL3JvQ2FO?=
 =?utf-8?B?N3dDeVhhK3BNUW1xUDVHdU9mTFNaSTdSc1NHZVZhNG9RN2g1WkpmRHFXbXBo?=
 =?utf-8?B?N1lRQW9wTGltU1hmTkEzRE9WTTVibTViTW9HaEtZMi9PQ2hnUWtWeTlLalFr?=
 =?utf-8?B?b1EwMHZ5bkVJaTVDWmJUK1V5d1hNTFhlUlo0aEdCQzZUY05ONnVRWjZJMnBR?=
 =?utf-8?B?d00rRDgvV0JtdWJHSERSYjd5WlMwTFNXVXJJOWYzcWZmRCt1eEZWWXlWVUdN?=
 =?utf-8?B?aHNDclZaNkpXOURIMGZoWmw4UWhUbDV1SXJ4TTAzNnVZaXk1cXI5dmtRckVy?=
 =?utf-8?B?K2ZsWU1rTXJqVWUyRXpyRUkyMHVwUVkyYUROT1Y2cEJ1RVpSbTNyeC9FR2Yx?=
 =?utf-8?Q?7Eh3NV+LRuL+KIysmDuACttnNtp7orHLOmV3TCl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3dlNEE5MU4vdC9kWHRpYVJqOGRVS2NHMFAvMzJvVDJUMFZpSWFqTDl6a3p1?=
 =?utf-8?B?WEdDYTh1eWNxbDFiaExqeEZUQ1U0WGxZTnZVcmJwbU1hYjhMaWpIVkZvckpR?=
 =?utf-8?B?Q25LMGk4VkNzODkxaWh5ckgwblRwVHNvY2o2T0tOWjRic0tHQU5wR1BIRjVL?=
 =?utf-8?B?M0R1aXFvM09ZVGtCdDBmS0xSb0RjRFFTZXN2N0gzRFgxclJ5RjA0dTFPdjNI?=
 =?utf-8?B?V1FTNGI5Tmc2Q1hnWWwrZk9HSmtTT0JsdDkxVzUvR2RnN1N6cUNHTjNmeHMv?=
 =?utf-8?B?M0Q4SW5hS1hKT2ZwNThqK2tBdXpVYXBpNUhsdyt2di84REw3b1BHaHIwbS8r?=
 =?utf-8?B?elBRYyt2VGNDWUk1VnU3SEJkTlFBTjNtZTFBZk5nSGVqNlgzUXlzRXBPeGxH?=
 =?utf-8?B?VDA3SUFoUUU1VXIvaUZ2M3NJc2xUTzlPZHIxeUg5YlRjTUhFZERaNXRSUHJt?=
 =?utf-8?B?dFBkMVc5ZWJSdlVXK2Q1Y2FRK1JwVUpNUVdFQUFqS2JHYVdFdHdKOFRCb0Fm?=
 =?utf-8?B?ejlRUzZhVmNDOFdhdEo5UHdNNmNoQXhzRHlNZVZETkRDemJQTE92aklNbzUv?=
 =?utf-8?B?TzJiZzdSWjhsMDlpSnZsQlZuQWFMV0lRdndsSFE5N3Z1ZkFTNTh3WFdLeCtI?=
 =?utf-8?B?dG9HNjhpcUQ2VWYzemVMQkI3OXFaN01BTWIxNWZTblVET1BjVWNKS0hDNVBx?=
 =?utf-8?B?blhqVjBmMmNLRUpmOG1vR0NVMGxXbmpXK2hVa2RrSUttZXRZSFltSnVucEdI?=
 =?utf-8?B?NCt5UXVYQ2NLOGhzMi9NYUgxVlVXbzdldENnbUY3a0xEUXZwTjdlbi9FOGxo?=
 =?utf-8?B?enlvUVRwOGQ1aFdHeWljZ1EwRmE1Zm9yVGwvSHRuQmYxTHRNandNcGp6V2ls?=
 =?utf-8?B?Ti90WGMzVUI4dXA4QmNDNE5IeUhOT3FwRS9lVHB0SCtId0hiQ2xKYlI0b0cz?=
 =?utf-8?B?ZzVzU2RvSDY0UFVoU2JhZ1hzbVBPU1dUeXdRazBVWW9QZjNLa1pySnZFMFRC?=
 =?utf-8?B?SS81MjVpTG5GWkxZLzhpa2JvNHJzd093RGViL2VXM3RhYWRSdDNWNU1sV1pV?=
 =?utf-8?B?cHBla3lHUWtEUlJWVTVKbGI1Yk5BTTl5THhuZGF0VVdreVB0bXZPTE9wSGtC?=
 =?utf-8?B?czgyM2dsM3JKOEFaSEVpeUwwbzRLUnh1Z3NQRUlXNHNDeXRFTTRVMkhsMm1x?=
 =?utf-8?B?ZGMybngxM0l6RmVoQUJaQjZRYjM0ZG1RdndGOGhMLzNrVm9HSzFHMXM0S0dj?=
 =?utf-8?B?Yi9nbGYvczBiOEhRd0wzc1c5ZFgzeDAwOXBsOGEvaVVmSzBKV1dFZ29QUXJ2?=
 =?utf-8?B?SE94N0FHak15WG8zMlFQYjZRVmIrSE9tNkJMeS90VitCSFlyMytnMnNkSUE0?=
 =?utf-8?B?NlpTdERpMnVDRFdJY1ZJZzJSZnIvUFNyaDRoNWFadGtQdWdRelBPTDdkbW1p?=
 =?utf-8?B?c1RVbi9rM0VRZUU2SElwcmpJSE1jYUp0U21meG9YNEMvWTg0WU5oSnFYM1lW?=
 =?utf-8?B?VkloQ2dvdm9WbW1BQmJkVi9kMUtVNEY3dk9rZzkwdGdweXBZM29UN00rbkdC?=
 =?utf-8?B?NlJqQVVnQkpnQkxuSkVEaW9Hc1g5MTNzMXoxMFVTWWhZQkdES21OT2F6S01U?=
 =?utf-8?B?c2IvSTVNdVlBRmlWM1R0dlpGSks0enQ1UDBPRjAvQXhNM0FtTGd0QXZwUG0v?=
 =?utf-8?B?M09VWUtrdi8rZ2ZTM0E0L3ZRMnNlVUlpd3k2cHRaSVE4ek16cGVZY2tiR2Fv?=
 =?utf-8?B?YUlOQTUvcHZXMFVYVWl3MFdMbWE1azVSNjdHamxvL0ZtQXMxV1k2eGlHNWJi?=
 =?utf-8?B?NG5ZRFhhTDdoV3lLQkl6UWI5ZnhFb2hIazZPbTJHQnlBRWFJbFBsWENNYWhx?=
 =?utf-8?B?TUFqTlc3WVIrU3FqcERUdGFNUWhUNXZsVmYxblYrR1M2d2dHUThzeGJzaWI1?=
 =?utf-8?B?di9taWVrM1h5WUZBMmViOUFhRm9wOENnNDd6MnhxbHQyeWt6Y1FxRCtjYVdU?=
 =?utf-8?B?TmtpeUVXWnpZTytOZDRPUy9tbGwxeU4zY0xSMzFpVVh3UU5WYU9lRnhpZ3dk?=
 =?utf-8?B?R080WkM2MTBHc2lObDAxSzVXbWtwdGVPdERacFZRL2MrL0lsRG5zQ1dSbndV?=
 =?utf-8?Q?sUSYZ3chg7Rh1Nd9UvMWQLM10?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d82168-0816-49b8-4e0c-08dc945ee166
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 15:04:01.2826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XA7mH8+2FuwpKetu9CaO4SxROh0cF8cafKZ60auL8F4Y3ihi20EL9DDvFetRpZkLCA+msfB8X1JfMdoBct2iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7681

On 6/20/24 17:23, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> Accessing guest video memory/RAM in the decompressor causes guest
> termination as the boot stage2 #VC handler for SEV-ES/SNP systems does
> not support MMIO handling.
> 
> This issue is observed during a SEV-ES/SNP guest kexec as kexec -c adds
> screen_info to the boot parameters passed to the second kernel, which
> causes console output to be dumped to both video and serial.
> 
> As the decompressor output gets cleared really fast, it is preferable to
> get the console output only on serial, hence, skip accessing the video
> RAM during decompressor stage to prevent guest termination.
> 
> Serial console output during decompressor stage works as boot stage2 #VC
> handler already supports handling port I/O.
> 
>   [ bp: Massage. ]
> 
> Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
> Suggested-by: Thomas Lendacy <thomas.lendacky@amd.com>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/boot/compressed/misc.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

