Return-Path: <linux-kernel+bounces-389080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C78D19B684C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3A71C20CED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832C8213EEA;
	Wed, 30 Oct 2024 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="oNrwA1Az"
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020118.outbound.protection.outlook.com [40.93.198.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650A6213ED7
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303308; cv=fail; b=FqkYqp5HoIyJskNCylm7s+lv3ZMaSbIWpkeM+N/mzCiJaQjDpw/n0I5bIkG0whQiT0bRrWm1kycu42sf9drgM/qR7CHPhmqroMQeg/60cJZFbrAX+/XcMtcBqyxa5UAqjdS3yU0HFM7KZJtR51ca3n4VNSqJf638MTHksqgNXWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303308; c=relaxed/simple;
	bh=al1LPPXHThhajI5Cyvv1/T8hDGp+S5aorYjrJcboufQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pfWSqzSi4AOI90epRRTrth+AkIyBvk60I5VOR3MdDsrBpqJQAbEsFwe4AdwHwo2rk2Uhnh7nWadK3Vn4uIBX8Q/SBdxY2mOHphg4lU4Ikpn7pn/KthNJrQEA98KGHpIKx/XKYBzFkbaQEzZAAbjb2UZYoipVeVNGCWNvZocuQBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=oNrwA1Az; arc=fail smtp.client-ip=40.93.198.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7GXFFrEigNQNfQ9oOeWBP+YeuyshmR12zPIVJuQSUDmGee86c7rIQ4oKkywpysV3tydJtO0QMRKLDktLOk/cuL8cD8PZ5pnkgeY8xRxtp3UXk99KrzmEoC/rHpCAoXVbYN8m06OHtwHruUgU4yeObsL90Nz+IYCqfvJ5ecJCBw0q3OmyFKb73FykTkYEEGR/kVI680l8n/yQvzwPZndKwivhOA+06DWrkUQdbT4pHeGi8bx16A5qV6OMjCMdmxvqBH10YvwWrwvL5MY2U+KpePYJLfQ9enwjRLsu5xUaGlCR0v0oR+Fco9+TB7eX2hCWlGkI84NlH8GA2nDkEh/dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5YlnNVzO8f/0Eudnkb4tKVyMBJdJ0kkdqGdEXGPsO0=;
 b=crKkRVRUD2DWOMHBZc9fbpCw5ksekSt6+F1sEOaDq14kAcG8ml4ng/Bisz1lDJSmZ7K0upMoWI4JENuZNukN+4IWPwB19vP0NkdwPq+aeyAhYQvuFTCdo8mW2qjEk7i8uGX0tpGrz1KpAaMv5iMajYEnNkLyHpZg17JePq0SyakqXKiDQDQ34YKk+u8QYYzowHWSXyVBQqaFf0JM2xqHzK0K4eyxLMrA/Y10/Fi2sK/vINsTtRJCyv00CY8FuVcaArJF+mFbMsvZYewQ0LWzGGBtD2NrQyKf0Z46auyN1Qa/pzjYMt2oSHdp5ebdJDtldMTLNrte5LqMt1Ie1YN5vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5YlnNVzO8f/0Eudnkb4tKVyMBJdJ0kkdqGdEXGPsO0=;
 b=oNrwA1AzMpky/k/bxuv7h5YQi4BQyK/3ozxtzUJDFTF0hZPxgjjCjveUApFghbVtUBzJrXgDh9/8Q5Jf/v2rF444tuVunymP+P7cFdg1Igdoy5mQ+jL9W3l5daTcjtSfRzMHxn57eggQKa5OOK2bfTy8uRcpiOpxgwNq7eYBkRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SJ2PR01MB8345.prod.exchangelabs.com (2603:10b6:a03:537::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.19; Wed, 30 Oct 2024 15:48:22 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 15:48:22 +0000
Message-ID: <8f75f59a-e7e5-4f37-abe1-6986f1ec2eaf@os.amperecomputing.com>
Date: Wed, 30 Oct 2024 08:48:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix 6.12 v4 4/5] mm: refactor arch_calc_vm_flag_bits()
 and arm64 MTE handling
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Peter Xu
 <peterx@redhat.com>, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>
References: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
 <ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com>
 <f5495714-19ba-40b8-a3ac-fe395c075a36@suse.cz> <ZyIRbbA-_8duD2hH@arm.com>
 <c8760d0e-acbd-4fd6-b077-58b5c374cad3@suse.cz>
 <3f184fad-e0da-470a-888e-70a17419e206@lucifer.local>
 <a2c1e121-91ea-4868-bb01-ac6ee43257c2@os.amperecomputing.com>
 <641cb1c9-340d-4b30-a036-261096defc27@lucifer.local>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <641cb1c9-340d-4b30-a036-261096defc27@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR20CA0029.namprd20.prod.outlook.com
 (2603:10b6:930:3::34) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SJ2PR01MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b58bc4-c09a-482e-ccb1-08dcf8fa4894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3hYOVpTUzNsdjZ1b1hNcDE1anJqRzJIRVdHdEZ5Ym5nVG5UNnIyMHBEWW0z?=
 =?utf-8?B?WXh5LzZpRW55dExXMG5QQTNGUStWTG5vMnFOQWc1cEZmZkljeWREWDJ6bnQr?=
 =?utf-8?B?b1J0Vk5yVnYvZi9rMlBkVzJ1dkdLZlN2clBWU0ZhQU4vdXpqcFljMFgrZWN2?=
 =?utf-8?B?TE9IVFBmNGw2TEVkdGFPNStDRDdUcnlTaW1xekVsZllvNWRMM2NJdHB0NUp2?=
 =?utf-8?B?ampqdEdKUC9ObWNydFRadUJCWEoycXNLbmE3dndUWnhBaDNHRWprR0xOLzMr?=
 =?utf-8?B?TU5tVnRmdUR5bkpHTkdkTHhEMDNhdzRPcURraE5lUStaK1lhY0hWRXFhM00v?=
 =?utf-8?B?bE1uRUFZaW92SkJtVmU1SmV3akF1MWM5RDRKWDEza1ZwKzJraHIzbE9xb1d3?=
 =?utf-8?B?YXd5UHBta1M3RytIU3FYMVFOSnErQVRiTERoeWFwY25Yb1lQcHVJQzd3TE0y?=
 =?utf-8?B?aXc2dHB6Uk55REZHWGRaUlp1N05Sdm95eVVob0VJbUxZUHRHb2c1dGx5S0Uz?=
 =?utf-8?B?RE1GbU1Oak0yeFJzOEorTThnTk5QSWxZaUh2SUdLMkkxS3p5eDg2d29mRTRN?=
 =?utf-8?B?MTRDYmZFMFhOaHFZaDQyWld5MHpHRlZmcWN4TnBDaTFkZUVScnRXQzYzMCtn?=
 =?utf-8?B?S244OGdKcnJ2RlVwNk5oOG9XWkgvdExjSTdRYVROUGNuN3NTUzNMV1N1MlFr?=
 =?utf-8?B?NlpvZnIwOUZFRXFacnQzbDR2WEdlOWhUZEcxSUF2aXVCOXNMa1UxeGRHczZm?=
 =?utf-8?B?RlhZZzFxa3J5c0ZiYWFmeC9jZXJ5enRvQmo0VlZIWkJxSkhhYVpReW0xaVpv?=
 =?utf-8?B?ZFVtS0VwQmdVSnJwYXpsSXRFT0QvclJpZXQzNW1DTy85SGZpMUVpU1FRWEJn?=
 =?utf-8?B?YUFuc2lHUzRWSXQzSS9vSG5EUDhqSXNsTW1qQkZSVUZYRjVBQnc1eEJqR3JO?=
 =?utf-8?B?SVA4Mmd4NDJrOHBYRCtrSnpwN3F1eTFhQkxMNXBOMzFTSlRUQU5JdjhLMTdk?=
 =?utf-8?B?b1prclpQeWtCSnBRdUF5SXZ3S3FSQWQ2L1Z0dXVjRlpWbUpUaGdmYU92MFha?=
 =?utf-8?B?dm9XenFZdDFTSVpKWC8yVzg0bVF0UjVpanVLTktQYWNkMkIxTkFYRjd4L203?=
 =?utf-8?B?OEt4R0xiWTdhdFBNZElIdGNkQXNEY01Fc29OUlNTS09VVHJsTFRLdnVGYVBh?=
 =?utf-8?B?N2E2SlUwaHJ3Uit3K2djZUs1bGxBU2IwTzRkUTU3RmhGNzNGUVlwNjBLUXV5?=
 =?utf-8?B?YXpqbEZXdWJvWnRtSVhsQ01ROE5DZVR5YXloaXgwb1FDZ0VtTDMvNHNjVW9l?=
 =?utf-8?B?R2xjZ2JUYWgwOFBhL1djdWZWbVE3NUphRjlpS0FIbVJFM28yMEV6anp6RWta?=
 =?utf-8?B?YW1zTVMyNnBGWHF3UTZMSTc2bGFOdlFNSFR2ZFNvd3c4dUhwemkvcU1TSEc2?=
 =?utf-8?B?azRQSzg4N21hUVNPUndmVVNLSldHVlJJZzBITnpoL2F3MFlqbVVoM0NjK2tQ?=
 =?utf-8?B?bitUUnZYNHBmWlo1YXJiR0NhQ0t4WTBzMjNubVN3UXJLckhXYmpNbjRVc0ZL?=
 =?utf-8?B?d1NMaWVUQmU1QzBBb3dQV0dxaCt4M1NmT2ZSVXdPU0x1MlFUWWUxcUNZS1pk?=
 =?utf-8?B?aGdsVTRFTDRCTm1UWktma2VNNVBNeEtjZUVab2xqQ2N3Wlpsck5EYTV4RzNy?=
 =?utf-8?B?dVhyK01RMFpPNlJkNHBtN3ZaaHBLeUI2UjR5NXVXN3MwbjlzRFMvekpML3d3?=
 =?utf-8?Q?zzbnCIlazdtty6/3ENbiFkaIslUpr2C3uUOYdBR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bi9UbEE5Z05VYUZQc3J6RWQwM0I2SlRJb1BIWXZTZUZwM3dvQWhva2ZWdGsx?=
 =?utf-8?B?bnpNZWJYMFZlN1FpR2FNYVZIMnhxRk9iMFVLWXoxblZnUDBWTFQ2ZElQeTU0?=
 =?utf-8?B?ekp1RGp3VUhRVHQ4dk1TSlNvMXE1a2I3RzBhNGNKakhMZmhVdXhaelB5d0g2?=
 =?utf-8?B?Z3VHS1hNUnhxNEpMemNuSnFla2JIMStCSnhXR0gwMGVvQUlzb0lzZmduTmtJ?=
 =?utf-8?B?MFBtZ21uQzU1ZFlpUzdlY1NWaUVxcEdtbUZpRzExU0kzSVRZaVo3RDg5QlFw?=
 =?utf-8?B?Z2FjeS9oTUlMZWhlYVN2TE1icllma1dSWEJSTE9nWHJ3QlRtK0x2NFlGK3Mw?=
 =?utf-8?B?UnQ4dUZKNkY3VmtDTHBLUHhoN2hyRytUblFoQ292QXRPSXpHdHo1akEybVRS?=
 =?utf-8?B?ZDBHTTM0R1A1cVAwLzVkNDRBYUpDVE1kbEZPclVIR2hKK0JuL3VMb1dJRWY3?=
 =?utf-8?B?WTNWRE9XeHVjYlBDa09EaThKby9FK1FDM2hzYXducVJJTGZUeHRsWDZUZ2NQ?=
 =?utf-8?B?eE4yVkh6eWNOOTJnNkxOb0NMbWVGUDRXbmt5TDJJQVpMOEdyY2hSRzFuNnZm?=
 =?utf-8?B?M085UzhJdnRSU1B0dkZsMzZZZkhFYTFCWElZYVAxMHhZQlA0L0tSZ3JIN0sv?=
 =?utf-8?B?eDRCc3pyNUFOUUNkam40K0hMeWZzejFVSnZ3UW4rd0NBUEtEdkhxUGtkdVhJ?=
 =?utf-8?B?MGlVQUVXa3A0NEFjR3laK210ckRSWVF2OE4yeWlmdFVzb0YybVdaMGVobU5D?=
 =?utf-8?B?ZWtHWGkrN1VDVWJiWFNZRUxRa2hzbTlQVlFSb1kwQmxWdzNnT25sRE1COHdB?=
 =?utf-8?B?bXcrdU9ZM0oyVE9EdFUvK1V6cDNQdXY5WTJ5QytYMjE0TEt6WFpqdkJCdmU4?=
 =?utf-8?B?NEU2Ym03bld0MCt4T1dzYlo4L0FGbWNXN2Q1UXB0eURuTWEzenp2NzlkWU5p?=
 =?utf-8?B?ZDdvbTBRajZGRzA0Qm45YTViWDM2RVozNDJHc3JLU3lSU095NVkxbnA2bmp6?=
 =?utf-8?B?Rm1ZOXFHeXFKVjdyRW1YUzJLTVRzeHNySjVRRTFaaCtEQXRZbGwza05zcWkv?=
 =?utf-8?B?M24wOEpQekNlazZHaWVvVnM4SFBjcjRoNGpnNzJ3OWdwNC9mR1BXcDQzZVl0?=
 =?utf-8?B?Z2JyVlJWVUJHQUFTeVZnQlFzN2lqbTh4M2FuNC9EU2E0WnN0VXBTa0JraEZk?=
 =?utf-8?B?SWQxd3NCcXhHdFVjK1lVYjhrcUdVOTlSY1paMVNNbU01OEdyV2tkSW1CcU53?=
 =?utf-8?B?eFZySVBpa2F6NU4yRjdOREg5R3UxdDU5dnN6Y0RXdjRYdzNuQStxUzFkb3lw?=
 =?utf-8?B?VUdDVksxODltcGUydkJjeFZhbEpHYTc3cWNITDRMVGV5WGFCL3cxV2ZIeXlz?=
 =?utf-8?B?eXVrVGtqeTZodCtDSHhxOWxuR2MvZ3hkQVRGUWk0TS9SZllHd210YXZmY1lT?=
 =?utf-8?B?YzNhS3RoUDFocXUxTjI1aHoxWmVZUlgzZ3lRSkowTDNqcTFOdzJoT1dNemZw?=
 =?utf-8?B?UnRWdkVtWVRFUERyYlRlamNoczJ0S2pCYjVadTJ0KzdFYWV3cWMyU3pTc0hP?=
 =?utf-8?B?VUNwYUZWcVh1VmJOTHRsZ0Q5dkxETGtaaXoxbEt6M0VPLytaa3ZDTVZBOFFs?=
 =?utf-8?B?S3NCcExCUmlRZmdIRHVsempFL2RmaC92bVU5Y2pESy9scE1IUzZzbjhrN1pB?=
 =?utf-8?B?TEtBa3EvZFFvRFE3YUJ5c3FmUEdtQ1hrYXN3VVBxajJpSzRMSTNwUWhQWSta?=
 =?utf-8?B?T3hYSzhwYnhFL1hXRDQ1UC9BajJDQXltam12M0ZFallHaFpUVEVjWmNXaDll?=
 =?utf-8?B?cUl1N29Wb1VnL2x2ODk3MzQ0MXB6MWVDOUFJQ2FnYXBrUjdYUllPYTJZbkZI?=
 =?utf-8?B?eXhBTndqVVpBcllQeXJkdTFDdmFPaHRablYyVGhIeC9wT2w3UDk2aExXWkc2?=
 =?utf-8?B?MCsrbFFOSGw3SDRCeXowL0dWY0U0SE9reURkYkg5ZWdXVVZ3OWg2ZXlLdGM2?=
 =?utf-8?B?UVF5TnQvL3YySThPU2ZEeUJtMjFlMkFnV1M5bEl5dXFSVVR2NlIyZ1dsRlY2?=
 =?utf-8?B?Q0lDRlVPc2VOUTk4VzhlZk5aaDJwakYzNjVhSkl4MW5STUpaN1AvK3FQSVg1?=
 =?utf-8?B?cE5aRHdMUEt5R0J1eld4Q1RVMktFd2NnRU92K3lDZDFnSG95SCtLRFF0dW15?=
 =?utf-8?Q?am11861a+jtkWKaPkS6fSPE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b58bc4-c09a-482e-ccb1-08dcf8fa4894
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 15:48:22.4774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcSErx8+MhuDsVmGvdMuosy3jOLelgY9ErZJoz/c7Hatj3y5rSp/zfjikU6YEGZYnPKhHgQFGncMT5mwlts2+qSZTqDqvTp8WecYmOK6n1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8345



On 10/30/24 8:08 AM, Lorenzo Stoakes wrote:
> On Wed, Oct 30, 2024 at 07:58:33AM -0700, Yang Shi wrote:
>>
>> On 10/30/24 4:53 AM, Lorenzo Stoakes wrote:
>>> On Wed, Oct 30, 2024 at 12:09:43PM +0100, Vlastimil Babka wrote:
>>>> On 10/30/24 11:58, Catalin Marinas wrote:
>>>>> On Wed, Oct 30, 2024 at 10:18:27AM +0100, Vlastimil Babka wrote:
>>>>>> On 10/29/24 19:11, Lorenzo Stoakes wrote:
>>>>>>> --- a/arch/arm64/include/asm/mman.h
>>>>>>> +++ b/arch/arm64/include/asm/mman.h
>>>>>>> @@ -6,6 +6,8 @@
>>>>>>>
>>>>>>>    #ifndef BUILD_VDSO
>>>>>>>    #include <linux/compiler.h>
>>>>>>> +#include <linux/fs.h>
>>>>>>> +#include <linux/shmem_fs.h>
>>>>>>>    #include <linux/types.h>
>>>>>>>
>>>>>>>    static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>>>>>>> @@ -31,19 +33,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>>>>>>>    }
>>>>>>>    #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
>>>>>>>
>>>>>>> -static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
>>>>>>> +static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
>>>>>>> +						   unsigned long flags)
>>>>>>>    {
>>>>>>>    	/*
>>>>>>>    	 * Only allow MTE on anonymous mappings as these are guaranteed to be
>>>>>>>    	 * backed by tags-capable memory. The vm_flags may be overridden by a
>>>>>>>    	 * filesystem supporting MTE (RAM-based).
>>>>>> We should also eventually remove the last sentence or even replace it with
>>>>>> its negation, or somebody might try reintroducing the pattern that won't
>>>>>> work anymore (wasn't there such a hugetlbfs thing in -next?).
>>>>> I agree, we should update this comment as well though as a fix this
>>>>> patch is fine for now.
>>>>>
>>>>> There is indeed a hugetlbfs change in -next adding VM_MTE_ALLOWED. It
>>>>> should still work after the above change but we'd need to move it over
>>>> I guess it will work after the above change, but not after 5/5?
>>>>
>>>>> here (and fix the comment at the same time). We'll probably do it around
>>>>> -rc1 or maybe earlier once this fix hits mainline.
>>>> I assume this will hopefully go to rc7.
>>> To be clear - this is a CRITICAL fix that MUST land for 6.12. I'd be inclined to
>>> try to get it to an earlier rc-.
>>>
>>>>> I don't think we have
>>>>> an equivalent of shmem_file() for hugetlbfs, we'll need to figure
>>>>> something out.
>>>> I've found is_file_hugepages(), could work? And while adding the hugetlbfs
>>>> change here, the comment could be adjusted too, right?
>>> Right but the MAP_HUGETLB should work to? Can we save such changes that
>>> alter any kind of existing behaviour to later series?
>> We should need both because mmap hugetlbfs file may not use MAP_HUGETLB.
> Right yeah, we could create a memfd with MFD_HUGETLB for instance and mount
> that...
>
> Perhaps somebody could propose the 6.13 change (as this series is just
> focused on the hotfix)?

Once this series go in rc7, we (me and Catalin) need to rebase hugetlb 
MTE patches anyway due to the conflict. But it should be trivial.

>
> Note that we absolutely plan to try to merge this in 6.12 (it is a critical
> fix for a few separate issues).
>
> I guess since we already have something in the arm64 tree adding
> MAP_HUGETLB we could rebase that and add a is_file_hugepages() there to
> cover off that case too?

Yes

>
> (Though I note that shm_file_operations_huge also sets FOP_HUGE_PAGES which
> this predicate picks up, not sure if we're ok wtih that? But discussion
> better had I think in whichever thread this hugetlb change came from
> perhaps?)

It is ok. SHM_HUGETLB uses hugetlbfs actually.

>
> Catalin, perhaps?
>
>>> As this is going to be backported (by me...!) and I don't want to risk
>>> inadvertant changes.
>>>
>>>>>>>    	 */
>>>>>>> -	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
>>>>>>> +	if (system_supports_mte() &&
>>>>>>> +	    ((flags & MAP_ANONYMOUS) || shmem_file(file)))
>>>>>>>    		return VM_MTE_ALLOWED;
>>>>>>>
>>>>>>>    	return 0;
>>>>>>>    }
>>>>> This will conflict with the arm64 for-next/core tree as it's adding
>>>>> a MAP_HUGETLB check. Trivial resolution though, Stephen will handle it.
>>> Thanks!
>>>
> Thanks all!


