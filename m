Return-Path: <linux-kernel+bounces-572227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68313A6C807
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 08:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1174609A4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 07:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C06E1514F6;
	Sat, 22 Mar 2025 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PicpBmtz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nLly48Z0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C901C2AE8D
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 07:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742627863; cv=fail; b=R0zlJW8WPeqfLm90563TKnq/bjm4XlAs8RmEyJ2p7w2kOpm9Y2qMA6ILMhPQ5ruSal+Bo3/i111ZX/iePiHcQb791zsYePrANBJSF+FcMF+i2wpbOpTEgEWT7LyDnRE1doZRY1ptEAQC1fe0ILKOOd5R+ScL+OL49SzdoLnVpbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742627863; c=relaxed/simple;
	bh=vBnYZ0COBng1hIAt9nia4rgFagoKVvSraczGajvcfsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fSpDPCwOY618EQiKrYZqbmKrjSVcJ6Jko0ut7a4EfqyzUaGGJzpFQtIlfVk3Zak2rEFi4mvC5AbEKcB01CFzWKDn/p4BWQ+DqliHwyEVImBHwMXzvMUEXh8Ryb5YfKhU2WCqO8smiaSIfpIk10xq2GCu9rTBPQMOwF4hh8kh7O4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PicpBmtz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nLly48Z0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52M5CeNa029608;
	Sat, 22 Mar 2025 07:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=btVOzJ/8VwheCIJW4PJBWthNFlZGgtIO7cwzhcSqXyE=; b=
	PicpBmtzZ6kw00jIPlLO3PtbFpXTCRZUcutVe9ccZwTk7/ApQec9ubwSEA9mx3tt
	CiUlEoib8RY9NQ4FMu/2C1Jth8cXv/9l9VopgMOUGnm8lJHicp4mtb79gZA1TmHR
	wOSk5vqUl7lhnD+N77gSZ0TahfwGCYP3wJYiYZqYaeY4/T0YrI9AVhF8xf53NCQF
	XkDcc+HtZEaRIHV7KAQPmXNG1cJ4GCRs9RsNl7vQk7dHb2jSVziDZSA9+10P2til
	IuWf/MHn8/it54+HU8lqqyH9g1in595wZDpmYeFcIUOfuNiO2emdzBWjzWOFjn0+
	tLCa6xzIVZ8JbIiHvenTOg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hncrg3gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Mar 2025 07:17:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52M79reX026402;
	Sat, 22 Mar 2025 07:17:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45hkncd6p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Mar 2025 07:17:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUWVGGjAgW+GCkR+6NVD+aMoYIpXQzo8gpfsUdrNKLSS3kUkgpm1m/0+omHnPY12X1XtQGChbBdIoizKY8CkZ1CnIf/cwFkIO7LqEmve8baL9ZwZXZMEb2VTzFZ8bIXpc4zV2uiMRWVt3j4ItR63lu9u0KfeXeZuPQGsTcjYtBJ1zSo1O5maiVDrFaZnqgJX5f2j+n86zaOvNdkZvnCqlP8j/EG2HgbnoBqo6oj6z3Vcl7lhL5eIpQLEkj++wXjy0VD72cqlvHkYKLElRz2dTNkucI8r8jc2R38zaQdkqazzJxEClQBWShvTswse7+fOW63HZ4vJHb/YUk/4x0422g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btVOzJ/8VwheCIJW4PJBWthNFlZGgtIO7cwzhcSqXyE=;
 b=sMVwlfa4trPMrhZj5bl4LV4PAjy+TXfFlS2Q6WBXBTW7myNKXrjRAk8+ZRzjG2iOlwHB/UgIhiTr+Fl2DKNwRQhcky9YrWn3cxVwQ/j1/IL66nzunY5HbYIbFmceEgqm0zgbmf9QaTET8FEOSBO1kFad1m3mzC1OgD2SP7pqrJ2+rH1J630Hmw6OVTpdNiZFGtbFMCfPEL8FxH4B1ou9pCtsFwjq5Umn0oC4+XjBk/jjqAN7g3rxad/+YjVgn4sdFn1FiVGYrrOP6gw9td2Ug5p3/nK02GilzgkuUHUYI8ILbD19HcYv4yIFwnCtgME6pH0Ag7MMlglAWAgCHLpnWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btVOzJ/8VwheCIJW4PJBWthNFlZGgtIO7cwzhcSqXyE=;
 b=nLly48Z0niv81VGDrMZPdnr+KohCnTrAyGwz0+UBC7WxNl2YYSGO/+86ErmGgrLOz1srXnhbdzMBu/vm195SANVuNqao/k7051izq86kpdYTtN9WO6p2zMH6zQGC9RFbVtvNHMyEFVid7pPoknJMYN53zysPbuH0oqgfHlsNlFg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB5829.namprd10.prod.outlook.com (2603:10b6:510:126::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Sat, 22 Mar
 2025 07:17:24 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.036; Sat, 22 Mar 2025
 07:17:23 +0000
Date: Sat, 22 Mar 2025 07:17:21 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] mm/mremap: introduce more mergeable mremap via
 MREMAP_RELOCATE_ANON
Message-ID: <2bdf7ac4-b359-420f-94fe-466ae98c4a49@lucifer.local>
References: <cover.1742478846.git.lorenzo.stoakes@oracle.com>
 <d10037699391c42a4943f578c2a0bca890640f30.1742478846.git.lorenzo.stoakes@oracle.com>
 <CAG48ez3CiRTUv4Qwy_UQzQuEDtUoPVVXnuPyiWoAhWVqkF3VTA@mail.gmail.com>
 <182bf1ce-1b67-4243-854b-4d0c26aae563@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <182bf1ce-1b67-4243-854b-4d0c26aae563@redhat.com>
X-ClientProxiedBy: LO2P265CA0339.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d7d885-8269-4087-fd3e-08dd691197c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T290Mi8xSjYvbFJLRzVQcWpPS0RpQVkvSWUvZWFiRTR2aFJmWDVzSHBYK0R4?=
 =?utf-8?B?b3QvNHBzeXpubDloaDZwT3p6N2NuUWNKNWYvVGFMKzdHMjFJZmIwMFQ2U0lJ?=
 =?utf-8?B?VzdOSzhnZnRld0Z4VGtUUHJmSHY1TEhEYm91Q3NVd1duQW5TQ3RiWmVlbkhp?=
 =?utf-8?B?UkVjU2loQVdwQ0VkNlZ6TXRjeFNlNFA4M3QyNFFnTG1jWm1JZkhIc250TURV?=
 =?utf-8?B?Vjlab1NmK3RCQ0wxcEV1NDd0NjlpT1E0NjBDempTa1g3WUVOZThPK2dXa3J1?=
 =?utf-8?B?VjZRTUhTTjdDNithZkYyYTlHTU4vMi9CVTN3eUJsZkVQUjZjRXltdVlJbFcr?=
 =?utf-8?B?Qldub1pzZTJGUHhZT3ZISHJhRU1qMSs4VnZKd3M3RnRnRUFPc0R5UUlrTWdi?=
 =?utf-8?B?YzdkYVBGcUtCTGVSZ0o3Qkc2b2I0WVlqMWRnQm1RZ3lLREJENmlsUml1WExL?=
 =?utf-8?B?anZabTVDTWdEOUNGM3VDWm5vTWw3Zm1FYm9iSlNZRTFsUVRFaXpwaWVpTmlm?=
 =?utf-8?B?K3BkcFZSWlBFc2lYMHM5d2VLZzNXSVBJNnI0QnRuSXlUTFM3akRyeDBpV2pM?=
 =?utf-8?B?VGtJaTNHU2JyVnI0SEJIN1pkbXVFNERUNmF6M2hWTzRxSnpCUWlJQm5uM3JZ?=
 =?utf-8?B?dVRyaUVwLy9rRDR3eHZTbXJWTnkrN2s3dTQ5SUNjZDdMODU2dVRoaFdub1Rh?=
 =?utf-8?B?clQwZEYva09CM0MyZTlUeHRSeFVoZXhqengrUGZWYnpNQlgraG1aSFF4YXdC?=
 =?utf-8?B?bmtNdmloVzMvT1FCT2ZJbUplNHZ3M2diVjdCdHovaE1NTVZiQm9OSlMyaEFK?=
 =?utf-8?B?TFFBTi9FRzNPZStBdEJwTE9kQ2tlZWRzMWFCWWRzQ0dkRjRtdnNPek5KaHB1?=
 =?utf-8?B?OUVHSFVCck9QTG4rV0J1QjBOd2ZGaWZ0aTVVS2xhbWZwbVBqWFo2MWE1SzNP?=
 =?utf-8?B?c00wRGFOb2lKbUxzRnQrQjN1ZTdPV210bWt6RFVrTEZtL0E0dWFIYkcwc29M?=
 =?utf-8?B?SUtrUWgwdnhkL3Y3eUFLVFVFdThVZUNjcThya3ByNTk5c0lRR3ZNdlJPS3dm?=
 =?utf-8?B?YlN3c0EyT2dJQkV5R2pMUkFicDloZG95Nks3dXVlaXZTUXE0VmdJeHZjUlFR?=
 =?utf-8?B?R2dKMldGQ0FuRXlqWGhHQ1ErLzlOZDkxUUFZS1pjWUZDdVc5WXlObGNsdFll?=
 =?utf-8?B?VUdsR0pocmxVN2FCZ1hjVjhzZlJNSVhMKzVHWkg0cVBGcG1nYnlkbndYb24v?=
 =?utf-8?B?T1JrbW5zNk5NdFgrdlFJMVhSNXA1OEE2ZE9UMnhoS0hONjFmVXBaNnA5cFlr?=
 =?utf-8?B?SGVNVldDT1p6eGZpbWRBVk85eGV2eFZ3SHl1VFY1RGxwbm1QR0FUTml4N0Ny?=
 =?utf-8?B?dlhkUDlXbVMrL2FIbDBPMzNMOXhscUZsNVA1aTVkNmNDNnlYWm1MZ284ZGRz?=
 =?utf-8?B?aWVMdENSclNOTkEwMXZaVEZUQzU5T21La1l5ejlhQ0tiUktFbGdqWXYzUTJz?=
 =?utf-8?B?NVdJdVpHT2RtT0RTYmtMcFdsUk9hYi9lNHBJSGxwUGxnY05JaTNYbFRvYUZZ?=
 =?utf-8?B?aXBOVlFDRjE0Vi91eDA3T1QyckNsc0VwbjNrZUkwdWdpVnFoN29iMXdzc0JS?=
 =?utf-8?B?WmFRU0dXbitGNk1Fd1BYdldrRnNsZDFSZnM0L052UFVIMXIxMUJ0M2RIY3k0?=
 =?utf-8?B?SHJSTWMrRDN3dUErakJya25xN29TSWpTRGFsMDM2OHpOTmRQc0drK2dLdXJO?=
 =?utf-8?B?VDdnYU1odE5KWU5Ndnp4K1VrR3piV0pwcE9ReStzMEU0MUJ0YWsyaWw5VzNk?=
 =?utf-8?B?SmpJYjM2TzNDOURIdFdJYzRrNmFmZE5LZ0dmbFNaMXljVjR0QjhzeS9RRWZn?=
 =?utf-8?Q?hi6hqsZ8idKiA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWt2dlBaak55blRCSzVKYTQ2dkZmcWp3d0U1TFI1N2VmUEZybk56ZlVIaGlJ?=
 =?utf-8?B?emVUOTdzRXFaYWIxT0kwSlhRWG5vYjM1Mzg5MGR4Lzg3Q3V4NkQvZC9vTDRp?=
 =?utf-8?B?ZzFGSjhVOU1rUEhEZng3Vmh1dmE4VlU4V2ZCc0x1dWlVbVN3c0JhbnBZMGQz?=
 =?utf-8?B?dTc5anNtVlV3WGIvWGlwVXpmWFdWUUMrVTJzRVRQd2NvQUpjSVEvL3hxaDJy?=
 =?utf-8?B?K2lHK3V0Mlh6MkNUemdtTy9nRmxjR25tZG9LRm5DS3hlWW9BSnUvMThPN1VW?=
 =?utf-8?B?L2NpajZyWW9Ea0xPLzZZZzF3RGx1S3NHR0oxQ09sRi9rS2V4eFh2K0xoRHdF?=
 =?utf-8?B?L1k5YnFuV1ZtMjZJNXptcjlOSWdUOTFJVkFoOUFUcWpzWXFmRzMrdHRYeXBQ?=
 =?utf-8?B?YlRGMjVMVG5HU05TNHRNZTRpcE9BcFBGck1iTWFnOU82TTRUbFF0SXZ6MXlo?=
 =?utf-8?B?RkxDR1N2cThlamtOMDQwRUhFVUMxOFBYRFhuWDJGaml0SjFmUnBhekpYQ0hk?=
 =?utf-8?B?ckVCd0pEOFloU1dpazgvdVlTdTJScFVVTk12TkFQVngvV0VSNS9XRThxUHFr?=
 =?utf-8?B?d1kwMFBTZjhyVVpYYUZickE1c3kwS2tJS2RLbUtvakVGU2N4N2JTNlR0R3NZ?=
 =?utf-8?B?eTdZaUI1VHBGS3owR3I3UURRYS9PMkwxdGwyY3VyMEwzdFlMMzNBa3dRRWg5?=
 =?utf-8?B?N0lsOG5PTWhTK29wbFM4aktPNWUwc0NvQnlZZDZqVVBVR1dBY2g1L2ZGVXFo?=
 =?utf-8?B?YnhSUXY1d1pIdGRqT1VjT25QcWtwQzJXU2QvOENzdHlBd2kvYlNXRVhkME9W?=
 =?utf-8?B?eDJkNll4cllYZlI1TzRtd2o3eUZBNW54dGhBejFkdkVWV1dwT0JHK25SbjFW?=
 =?utf-8?B?RHc4ck1hUTVIbHpDR0VQdmRtTTBaS2pQaTZ3SkZYclVpZ3ptZ3RMcGxSbmY5?=
 =?utf-8?B?MW9RMjQvVzhZYlhraDkwUmUzazlYOHJVRG1yaXpQQjZ1QzBXdHRlTDNHT1lT?=
 =?utf-8?B?bDkza1hPMjM4d2NxcFowUzFMZERPbFk5NlJEeTVEVUZwVWljTWlZRlNtNUh2?=
 =?utf-8?B?bmx3SWs1OERqcVdybEl1eG5JR0Q0UkVqb29hTzRQcHdiVmdHeTJlVzAyb2cr?=
 =?utf-8?B?QXg5U043OEF1TzloNUdua3pneHRzb0hwL1BRT0EwNkZsQmJkMVFYbjM1VWdx?=
 =?utf-8?B?eUtyMnYwNW41WCs5WDZKcFV2WXdSNnNVeWxBc21OWDhuNEpDd0lQajB1WUlV?=
 =?utf-8?B?V3FJMTVKWnZYRHZJakJhUHNLYkhrbEJST2R1cXNiWUFqQUxsZzc0ellpRjIv?=
 =?utf-8?B?VkhxdXBsdTRZbmF1SGViaFlmZGlRZXAwTEN2ODdwSFhiQ3RPSU1hWnB5VG1X?=
 =?utf-8?B?cDBHQ0dDRzhubFdyQldxS09vYmQ1M3JmbU5BNmNJdkpNZ1NZYTZKMkRkSlFp?=
 =?utf-8?B?V2dPaUNmNnBwNzlrSzVSYWVEQkwyOUpSUlVwN0hSMUwrd0tHQytHdjRsQUtF?=
 =?utf-8?B?YUlycnB0eXdzMHRHK2JhSzkyOVg5SUVzc3cyTGxSdXROdTJkQWZiazNrOGh1?=
 =?utf-8?B?b3ZZMGFkZkVEZzFtRm1EdU1qZE5oN1ZJeWlXZUxDb0ZqU1VlN3NaZkJGUmh5?=
 =?utf-8?B?VG9HT1hMZlhGM2JxaHFOc2krUXpPVTRvd1hTZGhEdGttQ1ExWGFOUEJ4ZVM0?=
 =?utf-8?B?WTJRZVdOWnE0MVN4NHI5M0l6VTdUZ1JMdEZoMVkwVzJpQTdrNlBQVnJ2d3Nk?=
 =?utf-8?B?NDlNKzY0dENuVGlHNXNiVjZaTkdieTVvNTExSnVCUklRV3hVUVNPaHA0RzNL?=
 =?utf-8?B?bjVwNmxXZU9UT09qbExCeDhkVmtka2VkcWJ2MkhCZmRrRmZtczRGeWI1L3Br?=
 =?utf-8?B?NU50dkJZRHBQVFZDTDRBdDB5U01HeFRrVjN6Q1BZanVzaWpmem5VV24xNVhq?=
 =?utf-8?B?V0Y3ODdOR3VOUUNBRGtvemlQSi9CT05ra2t3cGxuMlNZWUxSaTE3MjV4UGxJ?=
 =?utf-8?B?b2p1THZPeXpOaFk3YUt4QVR6VEI0dS9wd29pRVlTVGVZcWxsa0psbVlxa2Vq?=
 =?utf-8?B?byt4MEpNRDlUdW1vMFdMcE9tMWhpOVd6YU81aFdLd2RLOUQ2VEhjanpnSUVY?=
 =?utf-8?B?SkkyblZnUERtTWUyY3AxSk1OTm5XelFFR21lLzlaNnlDR3JITm0veW1ud0Js?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eDm3X4qxKQ3tY9Fh1JLihczsEYiA6+vOstU2uuCYth/ucSaR0oDT/Yo2VuvMprua8EvdHjj3UvofkZnIHgLbtXNJMEKX30zbc9hZIOT3zIIFADy4N7NeQzW033KG7xIsRymteeaAbsgyttXqudyBkvAoHaBKXtZ4Mckkq17ROVD+N0J2H6T8u+C1FyX2dYoeE6kn5hjwu3o1vO/ffDZzEmz8DxNmhW/wqpgc3Zxc+s+1SDnyhzcqcM9ZQ4cSWyG+Bq3rZr65jfXAn1F7Belsw2quK5g9EjGFz01aG/5xmIrBe1829uHjOPbscm817W8tSt5gtXn8IeRLhPidFh5KK2WKLNaD36k//TGxrfaOTF0nREI9/fL21XgNTnuO4vKLzDvzd0MlBmU3Yc/Fv6jsr9LYbSWnZ7ygZlCKm8cVc3CdxO3hSJpPUqapFvmAhWXuvBdQ/6Rvv8apTSqVrKnTfE7YDAXYVFD/ORqZt12JvtNEb0p4eXyrlXJ/9lgrQDEo3RqdhqIj5y0Gf4Lu19PTzfCEfPbeCfoaPMa4VtDAL/0MB/g4KsqYreH2EBtg85jzruQwFi4EpRtop66TmYSqyWRpTGx8PdsOLVwVXXLkuUo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d7d885-8269-4087-fd3e-08dd691197c4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 07:17:23.8758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mqMjnTrbzqjRGs71XLCyXu1+e2tgXM2AvGSKiWyL2fXiSnY4JIvSlHcQS+mq9E5K1BzVJL2atC7/gFIo5NTyFJiOI19Ga3zwiLvm0V4fmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5829
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-22_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503220050
X-Proofpoint-GUID: 1SobNSJ3rFzu8g8vXleYYT4QpH7D-oXe
X-Proofpoint-ORIG-GUID: 1SobNSJ3rFzu8g8vXleYYT4QpH7D-oXe

Thanks for early review, pints_owed++ :>)

On Sat, Mar 22, 2025 at 06:33:22AM +0100, David Hildenbrand wrote:
> On 22.03.25 01:14, Jann Horn wrote:
> > On Fri, Mar 21, 2025 at 10:54 PM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > index 0865387531ed..bb67562a0114 100644
> > > --- a/mm/mremap.c
> > > +++ b/mm/mremap.c
> > [...]
> > > +/*
> > > + * If the folio mapped at the specified pte entry can have its index and mapping
> > > + * relocated, then do so.
> > > + *
> > > + * Returns the number of pages we have traversed, or 0 if the operation failed.
> > > + */
> > > +static unsigned long relocate_anon(struct pagetable_move_control *pmc,
> > > +               unsigned long old_addr, unsigned long new_addr, pte_t pte,
> > > +               bool undo)
> > > +{
> > > +       struct page *page;
> > > +       struct folio *folio;
> > > +       struct vm_area_struct *old, *new;
> > > +       pgoff_t new_index;
> > > +       unsigned long ret = 1;
> > > +
> > > +       old = pmc->old;
> > > +       new = pmc->new;
> > > +
> > > +       /* Ensure we have truly got an anon folio. */
> > > +       page = vm_normal_page(old, old_addr, pte);
> > > +       if (!page)
> > > +               return ret;
> > > +       folio = page_folio(page);
> > > +       folio_lock(folio);
> > > +
> > > +       /* no-op. */
> > > +       if (!folio_test_anon(folio) || folio_test_ksm(folio))
> > > +               goto out;
> > > +
> > > +       /*
> > > +        * This should not happen as we explicitly disallow this, but check
> > > +        * anyway.
> > > +        */
> > > +       if (folio_test_large(folio)) {
> > > +               ret = 0;
> > > +               goto out;
> > > +       }
> >
> > Do I understand correctly that you assume here that the page is
> > exclusively mapped? Maybe we could at least
> > WARN_ON(folio_mapcount(folio) != 1) or something like that?
> >
> > (I was also wondering if the PageAnonExclusive bit is somehow
> > relevant, but we should probably not look at or touch that here,
> > unless we want to think about cases where we _used to_ have a child
> > from which the page may have been GUP'd...)
>
> UFFDIO_MOVE implements something similar. Right now we keep it simple:
>
> 	if (folio_test_large(src_folio) ||
> 	    folio_maybe_dma_pinned(src_folio) ||
> 	    !PageAnonExclusive(&src_folio->page)) {
> 		err = -EBUSY;
> 		goto out;
> 	}
>
> Whereby we
>
> a) Make sure we cover all PTEs (-> small folio, single PTE). Large
> PTE-mapped folios are split.
>
> b) Make sure there are no GUP pins (maybe not required here?)
>
> c) The folio is exclusive to this process

Yeah, later I actually add handling for large folios :) but this is something
separate.

The maybe dma pinned thing is a thing and probably I need to add this. Will do
so.

>
>
> In general, things I can reason about with confidence are:
>
> a)  As alternative to PageAnonExclusive(), we can check folio_mapcount()==1
> under the folio lock for small folios / PMD-mapped folios. As you (Jann)
> say, there might be unexpected references on the folio from other processes.

Ack for sure will add.

>
> b) For large (pte-mapped) folios, we could try batching multiple PTEs
> (folio_pte_batch() etc.). We'd be processing all mappings with folio_lock +
> folio_mapcount() == #PTEs.

Interesting, hadn't thought about this, maybe we can discuss at LSF?

>
> c)  In -next, there is now be the option to use folio lock +
> folio_maybe_mapped_shared() == false. But it doesn't tell you into how many
> VMAs a large folio is mapped into.
>
> In the following case:
>
> [       folio     ]
> [ VMA#1 ] [ VMA#2 ]
>
> c) would not tell you if you are fine modifying the folio when moving VMA#2.

Right, I feel like prior checks made should assert this is not the case,
however?  But mapcount check should be a last ditch assurance?

(actually at least one of the 'prior checks' for large folios are added in a
later commit but still :P)

>
>
> --
> Cheers,
>
> David / dhildenb
>

