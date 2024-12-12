Return-Path: <linux-kernel+bounces-443197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC869EE8A9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13FB282B95
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2C92147E0;
	Thu, 12 Dec 2024 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i4TVL8+7"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81F68837
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013396; cv=fail; b=VOTvM0hG1dp9NYG0tXQYwr1dk/3K38MqOC84qQXp2buatizwfNBHJXwtSLVaMsE0L8fcwUN0hHwavKSPOAVHvkVk9VnFhwATmVxMX4b0eeTVv6yS4sQ2afwChcSB2I3G/77tLzJ45l5ZoSRwd8Lo9TEzmaGO5LSzkIEIDhH7mGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013396; c=relaxed/simple;
	bh=KSFPJWGY597/F1CPWuBNGCBXudYiIXxB79/swZV+Jk4=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=d+SRr8529iCTUBGyKtnxJ0CX150Oac/F7AAVyneBBRroE6KRt7kuAjj5/XWQWZKV+tGDKOjMIPDXFlmJznF/0M+xjmiqHlKhnF8pjgSN8lq8U+hMisWpy1LWMEl92AvL6LNIbE9SYK1wCtKXUaCxR6wrp/MFdKRwf0pcdcR32Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i4TVL8+7; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wt/oGfnixDd2qlg7N+V/8s9evc+32d1egpZFhw7whwFwg4h4L0nIVN822TL36VN4dYhFagEeTEKoCX8wAe1qpQGiMgzJHbzeOCdBe2C0RPgynlQyMAOfDQvBXeAuR66tbRBuxGSl2vO0/fulsCV+5/wXwaLGXWGcmVDZIX7Z6cSqJbJzK8f8S6YMXuhEteyQTZv/CfpkzAGg3VtyPfEvatxV1pMLis0Uh+YtChi2Ez/IQqaTqgLFXIm1ZYPLY2zQmMYbdAcOPchhxNmW1NbkgkTM2UhFyYnhliWyFyqM97Px/4dTHQiRfk5tbpPGann+7rQvHDsv3ky47gtzn1nJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPIGVCbWTfznHy6Nkh9NvPj7qPp5L+R6+sCB+rAZdNY=;
 b=vCHV73c0AHdFNtNB7W3bL84UPHnfHqwUMJR+JtTxzvn6RiN3DPsQPok/HpYotOu2zdvOTebK3tls2EHCH25uszM8kgYaOZYjGzfW0AMueyC0m3Si3O08Po5775ZwJGflM/QwoUDN5X6n1hFe3gBQ/Gk4urDfd+H7A4izaF5Mr/3lLpINnlWMg0hGO83tn/md5PfeCJaUZY0zB95qutprXn0iSB0ORcepxuPkxF88yloeQDdCGROcJZ2fRGUSj/9JEWuvrHjUuHbtJPZb3JIFXhPePL2emlTs78jiSmtkNQkpFeBpNpkoxOylJ8GVDUxrzlvraRfYvxKKcQaDKlR2GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPIGVCbWTfznHy6Nkh9NvPj7qPp5L+R6+sCB+rAZdNY=;
 b=i4TVL8+7IoAAvoFb4k69v2Jwhr5BnAEB5ZV7EAz3OSZh/X/TZsWBbxD8l7+Vt9zbupgVDkXc2qywGE8d4NnSr7AOBLsajqrFgQwem0xTHDuSV6Cb4JumJLZC6BWTJN531UqG5b6/W0p3WDzS+vzlXCD/grHZ19fmKqDpm3LtQeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 12 Dec
 2024 14:23:10 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 14:23:10 +0000
Message-ID: <079cb87c-78aa-5fb5-b28f-e7a54e51aa78@amd.com>
Date: Thu, 12 Dec 2024 08:23:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>,
 Andrea Parri <parri.andrea@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Daniel Borkmann <daniel@iogearbox.net>, Eric Chan <ericchancf@google.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kai Huang <kai.huang@intel.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Russell King <linux@armlinux.org.uk>,
 Samuel Holland <samuel.holland@sifive.com>,
 Suren Baghdasaryan <surenb@google.com>, Yuntao Wang <ytcoode@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Ashish Kalra <ashish.kalra@amd.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <20241021105723.2707507-1-kirill.shutemov@linux.intel.com>
 <20241021105723.2707507-3-kirill.shutemov@linux.intel.com>
 <20241118164616.GAZztvWGs9cOV8t20_@fat_crate.local>
 <s4frmqwtuvclinuu7ttyzfpe7bj7hju5xgt6sxzy3gyt3prr62@rrgvhkv4lgwv>
 <20241121114952.GCZz8eYEVa3yubYQzO@fat_crate.local>
 <bz3vlh3lri7yfckdkddopwhsgvkmizhw5q6ecomgeba7q22ufp@ntu2kugiho4o>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCHv2 2/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as
 encrypted by default
In-Reply-To: <bz3vlh3lri7yfckdkddopwhsgvkmizhw5q6ecomgeba7q22ufp@ntu2kugiho4o>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0199.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::24) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|BY5PR12MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: 973f9965-948f-4924-066a-08dd1ab88136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjV1MDlRcm9Ub0MxWmlWS0l5eFc5WmlFeDZKSzA2N0RlUnZBK2xXdk9YNmRS?=
 =?utf-8?B?b0JkRStSUFJkdDRPeUpQWU5qaERrRURJWGFUa1ZCbFdTc2l0a0d0WkJLRm9D?=
 =?utf-8?B?alRpcWljNkpWVHFqZzRiYkdydE50a3MzMXpHN2FRTXkvM3doUm5YMVdSTEly?=
 =?utf-8?B?S2FJb1FHUjB4T21DaEdzZ2tHTGJPaEJsVGdiZkFXTzVtRlQrOGlMNWU3Rkpm?=
 =?utf-8?B?MVFMai9qSTFtdU9KdFJsc0ZRbzlXa0YzRU9yTjQyNGNWSWlXbGVrakxJcWNM?=
 =?utf-8?B?TFFuRzRSalNXVzgrZlcwL1lGVERQY1E0Mm52SGxUM2RwNmhXL01jOFFVMkRE?=
 =?utf-8?B?WjY1dTZtWGp1MHB6eElFOStSZVJBM3h6emNQN21TVWZmL3NXajZMbFM0SnBE?=
 =?utf-8?B?WkJtSkJqcUZCQWJvdURCTHl3WXdWbVBTQncycDdTU3BsVFhhb0Z2UEptcVlT?=
 =?utf-8?B?UFhleVF2ZlpvclA2Sys0ZUQreWhaTjRLdnRNelVNRVZ5VzhVWnpYWUMwTUdv?=
 =?utf-8?B?UlM2V0xJaUhHMzZtbnl2VjV6cmZoK29Qc01veFordjNFRUR3eUVFVUZtM3Uz?=
 =?utf-8?B?QTJ0bE45eXFEY2JvRlZvZS9pbW5Jb0MvbU9zclZOWnVnaCtrNk5tMHAyblUx?=
 =?utf-8?B?VTBTblI0NlFVV2JBeDVQZDZZUW43WG9uNk4wZDRlUUk2NzhCdkZTZGVhWmxS?=
 =?utf-8?B?NWx4dVFWMHM1aUd5OWVWeWM4Y0xGTjdKVlJvb0lYcmtMKzZUM0ZoOVorbVBP?=
 =?utf-8?B?OURRNmpudnhtL1J5ZmhzQ0huQXNFc2N5MGFTSmo1QTMwNTBQRlBCSitTRng1?=
 =?utf-8?B?RlB2Wi9iVlRDRFEwS09SN2hSSTg1RDZXek92Rlh0cXc4cmY4N3pUS0pKQ2pm?=
 =?utf-8?B?WHhtR2lQN0p3S3Zsc0pqejBUcW5XTFBWa0xwaG5WSHpabkxwYzZTSjA4Yndx?=
 =?utf-8?B?ODBUeG94ZXdwRGs4RGFnQVluY1prUDhnQ2dDZGk2ZzF6d2NHVHVkL3FQdXRs?=
 =?utf-8?B?ZVlTZ3NWQ0Z0Q29UU0pBMy9FRDZXN1BqQ0huL0h6ZjJhemc1djQ2UXRBeXIz?=
 =?utf-8?B?anlnUXE5Tng5VXFHazQwYXduYy9vcm10WWsyclVldm8xSGlMZkE1RTBlMjdK?=
 =?utf-8?B?SmlTdkx1YzMwaU9sZWdYMVZPc2h1WVJPR2VnWjJObS9zMHptTytzalNvTGtv?=
 =?utf-8?B?clh4ci9yL0dPMDd2UEx0NHVxdThlcXFBbEN0T29tQmx4SnFLSUFhc3dUbDc1?=
 =?utf-8?B?OHBFSlpvbWtwbnpwQ08vSjg4KzZBSVNsaTllRzVUQVJKLzQ0M0oyV0ljckZr?=
 =?utf-8?B?WSsvNjk1NmlmSkl2Njg1YXUzOVQ2WDk4RFozVzMrSTJ4Ynp6L2Q3aE5sc0Mr?=
 =?utf-8?B?c0VxbUI2WFJVWE1GWk1lQi9rcEROMnFWV3V0TlJBTEZMZWJ4QTBuQjFFQjZh?=
 =?utf-8?B?Qjh0R0FSRFA3YVloV2EraHNRRU1xTkcvR3EzR2p1dExoOXNKV2FWT3V0K1h1?=
 =?utf-8?B?aGN1RHc3c1RnUyttTXVubDVienhDSFhROHNBM1VldHVRTE9TbEswNXM4NWxu?=
 =?utf-8?B?Ni9KSkduNkJWV1JFRjQ1UnNlMHIyUCtaQ282R01ycWFOajQ4YlVyU3RIVHls?=
 =?utf-8?B?Y0hPS0xlOUJNM2RXbkxVNm5xdUZnbUJhU1g0bXQ0QVJ5QlQ4VFMzQUJLaWt1?=
 =?utf-8?B?NlR5TjJ3MFl6RHlNS2J2ZjRFL0E1RkhLeHR4S2lqQUZkVkpNYzcvenUwS1Ey?=
 =?utf-8?B?WGsvVy9lU2VGNEFtOGEzT09ubzRTalRZSWJ5a09UN3JoQjk3ejNYYU1ES0RH?=
 =?utf-8?B?U0ZYeEt2RXhoZ3ZCZ1Z3QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YklSOS9oYjdkSEFSK1p6Nkx0aVc2Yzkra1FNWUdDa3VoWmw3dkxnMHNiNWxt?=
 =?utf-8?B?VkIySmJlQ3ZocGJCTm1scHVmK00yc3pZa2gwemdubWlDbG1pUFJWTmtKallN?=
 =?utf-8?B?dFU5RVhTMm5YWjFPQWtwRVpJYjR4dzNabHMvRi9rTDkwaXZIdXBnRzBFZzMy?=
 =?utf-8?B?MzRIZWo3OU9VcTc4bmZaN1VYTy9hbjMybThMRnlSVjJodVloSXF1OXRCUnRv?=
 =?utf-8?B?VlBXSkVwN1ZlOWNMTnY0RXR4dWdlMmlHUC9HYXl2TDhmelNvR0tsTlJVQ2hq?=
 =?utf-8?B?OVB1QWdkMzdiWDI2UmtnWFBQZ3poVjVGbnB2YkdFeng0Ym4zQVFkWU5VSmE3?=
 =?utf-8?B?eVR5aUV6RHYxVHVlaG5VVE8zdjE4U2JFWjJFQmFMM2k0ZDQyRUtRWXBtNTE3?=
 =?utf-8?B?dlBEZkowTHBuMyt1YnVlY1NGMzYrcGNsVkQxRmExbzJCS1BpQzBWNXVXM1Az?=
 =?utf-8?B?VXo0UTM0dnc5Um9NaVQydmpJRkRUYW01dVNZdDEzRVZVdnIvU1pCZ2dpWWF5?=
 =?utf-8?B?SjRheTd3K1diajh2WURrT1RScjBmYVNWOENac3VSelAxcm9lVUw3S3NOUm1a?=
 =?utf-8?B?SVUvT0M5V3JlWXRMd2pzVGxvREJCZG9jdGdFL0ZiTjM2QTJnN2JyTjVXa0pG?=
 =?utf-8?B?TVo1R2dkb0ZRbTQreVFHVWpjWmF5L3lGQmZ2cUlpbWhqRWhFWDM1SmIxT3Nw?=
 =?utf-8?B?YTArd1V2OTdUdDdnR0tDdDRnUVhSc2w2UCtMb3MwK0NYTVVRWmdVVkpYREFR?=
 =?utf-8?B?akN0Vzk4aStlWXdUeWJWa0xJRlBDR3ZXMjVibU1hU2wwanFWNmVpTzVxS3Jr?=
 =?utf-8?B?ZTZHdk4vNGhxalFnUFZLdUw0ci83K2IyUzI3NnZRZ2FBcy9keE9zWU5LYnly?=
 =?utf-8?B?NGpDWGdDcU56RUxLYXB2UGVTK0ptOHVncWRHMHB3N00wMnc2aEs5V1FEa1V0?=
 =?utf-8?B?WDVJeEo1QXpZby9PS3dwOU16R3RXR1N4Z3I0eGhjcExCeE5LaE9zNzRwb3ZH?=
 =?utf-8?B?dTBhT2ZyRGJIYTdHRit0VGMwRWlNQ0k4YWo5bXl6d2xOOG5oMWxNSU43MW9P?=
 =?utf-8?B?NnEveVJ0NTNUeHkrMDgzT1Q1cHNGTlJ1Y2NDaCtmMjFwNU5LRS9pdTl0amo1?=
 =?utf-8?B?amtOWmxnT2V6Yk5QSUFIOXU3SDNKZ0NpOFZqU29TSFozZ214dUNzUldTTURG?=
 =?utf-8?B?YXVLclNFZW5LdFRyRCsrSEVscmJCcTVBVHBtYWFrT09HNzF0SFFUbnEyZ0Nx?=
 =?utf-8?B?UHRQNE4yaUp4V0tHR1NtZ0hzVVR6Q0tYVjlEdjNveGQrUzArYzJsZXpxTGtx?=
 =?utf-8?B?MjNQYTlaNjRBTXNZV3hyQk1obUE3a3FGUXZFS2xpSlBoejRDSm4yclVXdXlG?=
 =?utf-8?B?M0szZVpwWnVTRDJHc0swaXhyR0Jtc2tWb2tlUUhNZlc1L1FXK3N2Z3JWVGxK?=
 =?utf-8?B?akgxeXhFaFRJNFh2cDlwM1p1QjlGVXYwbmk5bXFsbnlmYXBWQ3RZcFpwTmgw?=
 =?utf-8?B?NjlhQnkyZTNmVVczUzZ6dTI5bUZPY1FTTm1mQ0tpU0EvK0ZITklIc3VJTWY1?=
 =?utf-8?B?TG0yUFFqeVlObGZQZmh4aG5aSWRiRWhwZ0h3cTNwYjYzVEc4Sko4TnVJNXJo?=
 =?utf-8?B?WmhuNXJzZmJYaStrTlg1cFVyeFVmSSszTGh0MUw0bHVaVE9qcWlmNzNwOFdr?=
 =?utf-8?B?bVVJMEtENmFuUTc4cy81N1JwOW8rOXRucFppSjBMNmZ0S29mS0VscVA2WXV6?=
 =?utf-8?B?Y2FqMWdRSWMrNysvVzQrVC80aWkwRzhFRXBOTHNwdUxvZEhoVnUrTm9tMGQw?=
 =?utf-8?B?QjFhak9rTkQzeW81S1oyMWJqVU81dE5qSnh5YmV6Wm5CTXUrK2w1T3F4bU4v?=
 =?utf-8?B?VnpBK0cvc2Z2cXJ2YXN3TVZhV05jalRTWnJoT2gwZUwwNEI3M0lZRkJGcEg4?=
 =?utf-8?B?WUpyWDZJUU9rTkgxK1M2L0o1akttNHowd29EWEw4TDJ4cG1CcEp2RjdtdzZX?=
 =?utf-8?B?cmI1VXpiRzFQaG1SOHZaWmtRcXdiVGt2NldmWVM5SUJGTVcxSWF5Wmk4b080?=
 =?utf-8?B?WXdDQng3WkxuQS94TzVGbEUrZSs1dlJjYmdQWkRxNDJUdXFMSUNBZ3R0bzRa?=
 =?utf-8?Q?Jo6OoqJEs03/gwycHamriB+qh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973f9965-948f-4924-066a-08dd1ab88136
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 14:23:10.2253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gulfXOhTH/Cy9iw6iAKFG9aHe8QF78P4Zh4i93blWLPApcVBjhVRSzgQXNA7DeBG70G9gDlxO28Aw9FlW2tALg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113

On 12/10/24 07:26, Kirill A. Shutemov wrote:
> On Thu, Nov 21, 2024 at 12:49:52PM +0100, Borislav Petkov wrote:
>> On Tue, Nov 19, 2024 at 10:21:05AM +0200, Kirill A. Shutemov wrote:
>>> Sure, we can workaround every place that touches such ranges.
>>
>> Every place? Which every place? I thought this is only an EISA issue?
> 
> I looked at other places where we call memremap(MEMREMAP_WB) such as
> acpi_wakeup_cpu(). We actually get encrypted/private mapping for this
> callsite despite __ioremap_caller() being called encrypted == false.
> This happens because of IORES_MAP_ENCRYPTED check in __ioremap_caller().
> 
> So we depend on the BIOS here. The EISA problem happens because the
> target memory is in !IORES_MAP_ENCRYPTED memory.
> 
> It's hard to say if any other memremap(MEMREMAP_WB) would trigger the
> issue. And what will happen after next BIOS update.
> 
>> Then clearly your changelogs need to expand considerably more what we're
>> *really* addressing here.
>>
>>> Or we can address problem at the root and make creating decrypted/shared
>>> mappings explicit.
>>
>> What is the problem? That KVM implicitly converts memory to shared? Why does
>> KVM do that an can it be fixed not to?
>>
>> Doesn't sound like the guest's problem.
> 
> Well, the problem is on the both sides.
> 
> VMM behaviour on such accesses is not specified in any spec. AFAIK all
> current VMM implementations do this implicit conversion.
> 
> I think it has to be fixed. VMMs (not only KVM) should not silently
> convert memory to shared. But VMMs cannot make memory access to go away.
> The only option they have is to inject #VE instead indicating bogus
> access. At this point it becomes a guest problem.
> 
> It will get fixed in VMMs naturally when TDX Connect gets enabled.
> With a secure device assigned to a TD, VMM would loose the ability to
> convert memory on its own. The guest would have to unlock the memory
> first. This will make implicit conversion impossible.
> 
> But it also means guest should never initiate shared access without
> explicit conversion. Otherwise #VE will crash it.
> 
>> Or maybe this needs a lot more explanation what we're fixing here.
>>
>>> Such mappings have both functional (as we see here) and security
>>> implications (VMM can manipulate the guest memory range). We should not
>>> create decrypted mappings by default on legacy interfaces.
>>
>> So we're getting closer.
>>
>> The changes themselves are fine but your text is missing a lot about what
>> we're fixing here. When I asked, I barely scratched the surface. So can we
>> elaborate here pls?
> 
> What about this:
> 
> x86/mm: Make memremap(MEMREMAP_WB) map memory as encrypted by default
> 
> Currently memremap(MEMREMAP_WB) can produce decrypted/shared mapping:
> 
> memremap(MEMREMAP_WB)
>   arch_memremap_wb()
>     ioremap_cache()
>       __ioremap_caller(.encrytped = false)

That's because try_ram_remap() invokes arch_memremap_can_ram_remap()
which is returning false (for some reason).

When arch_memremap_can_ram_remap() returns false, ioremap_cache() is
invoked. ioremap() should provide shared mappings unless specifically
requested to provide an encrypted mapping (via encrypted parameter) or
if __ioremap_check_mem() determines that an encrypted mapping is needed.

Can logic be added to arch_memremap_can_ram_remap() to return true for
the cases that TDX is having issues with?

Thanks,
Tom

> 
> In such cases, the IORES_MAP_ENCRYPTED flag on the memory will determine
> if the resulting mapping is encrypted or decrypted.
> 
> Creating a decrypted mapping without explicit request from the caller is
> risky:
> 
>   - It can inadvertently expose the guest's data and compromise the
>     guest.
> 
>   - Accessing private memory via shared/decrypted mapping on TDX will
>     either trigger implicit conversion to shared or #VE (depending on
>     VMM implementation).
> 
>     Implicit conversion is destructive: subsequent access to the same
>     memory via private mapping will trigger a hard-to-debug #VE crash.
> 
> The kernel already provides a way to request decrypted mapping
> explicitly via the MEMREMAP_DEC flag.
> 
> Modify memremap(MEMREMAP_WB) to produce encrypted/private mapping by
> default unless MEMREMAP_DEC is specified.
> 
> This change fixes the crash on kexec in TDX guests if CONFIG_EISA is
> enabled.
>  

