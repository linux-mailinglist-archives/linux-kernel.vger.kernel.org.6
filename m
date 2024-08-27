Return-Path: <linux-kernel+bounces-303491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29785960CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88D61F23CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AE21C4634;
	Tue, 27 Aug 2024 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0QhVBq7r"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874A41A0739
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767252; cv=fail; b=H7XwKNhzmcPMhqXILIF4fi2eQAQUUlH2IaJe/sGbrhkD01lCCtRwFN+mvHYTX6Y1J5bikXz6i722tJpAlwVW/jnTqvIxaJnKkac29rs24Fk4gU0EKGTv/uzrcHH/gDMKRK/xTDW+MDQQRehryRwO2VEFQVC1BV1/AS4Nt4kGdv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767252; c=relaxed/simple;
	bh=sJy3FXj04dfhEUakLJXJFyqV3gklX+zQSdlIsyKkUJM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J9cm0BBDFdKShcDMx1ql5QDtO6Igh0m3T9JxBAgH0GWSd36IvgsA2lUziwKFupIZw7PZkNlEsnGdnBqgPgpadB1WcPaFEE71T6/o32NY6WBwXwfiYF0cdI0jF1eYps73RTPnlxzpLE4pWoN9qtbp27LOYfQfbNysh07HBnBiqDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0QhVBq7r; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xa6KCoL8AP2GijXXa8s7hJhwa5yi/ioS8ujcjScNLJqySpTqjsnWR6LWTc7Hg1O+jNs3G7mpRx+KCKE1Or522DABPORrtLNnEgUljuygFtvB4dR6Qw2BNGM3THlqLPVn9wUHC6unxdwxo2aMefqun0quWZ/gAKT7p1MvmYUxEAUCX9AUZHiiastNXi8Wt1bpduHFhMVz1vgxXnvaedeNCoMYMcykQvgiFVqlf9AWiUwHvxaZX1Jgoxdn5jXEOlMZ9i6Os6v8dtqV0x5fGFZV7+/LstpMsYDrKaYIW2tCB/ztNp3pDpkpFQKBpKAyREu+0hJoxDKD6aT3VOSWFOYkug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1i6ZPw9UzHvc2NYFlVnAy1hUD/pmWc8O1pc18YhuS8=;
 b=N8Sl6Num2NO/bG/g0dx15kmoV5hOWYJ+n5bC6Ahrx99HFxW2hhT8enqqUofLvRu34RjmRJ76DH2AhgTDwaNjK6+CEv1MZVIknVm7nn1jwOqUJAzyJVtQkqGN5Y5JQ/Lkx0AD2dnQsAQHvfGag1BnYBWSULuJWGYp0OnR7NER/lsNCtoUqC+fe4f7+zLYJb7BtsKNTatHOXTxy32w/3DDziv3OhtbvkI0fb2O8jIPLO7qOqHaI6Te/hxspHudBqvzhVdtFZE6mc2jUO4bRi10uvnfmU9HweHQp+PA7xJBxY/NFkfLvdtGDuQWEVjjH9BNSq2nu8HKO+dCVt6iwFgnzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1i6ZPw9UzHvc2NYFlVnAy1hUD/pmWc8O1pc18YhuS8=;
 b=0QhVBq7rfrEClsGkQiQzQG9kSIfh+28Mae3ziMaHm4x8CKpuZtfbb8PM5d87NHs+IWr/jNgTMlcRkiMSST2iDuOk5CDcTHtm9JCF3F5ECknKrcGiPlLRs0f8o1heVufpiAdOw/DNfXfGwHyUQcvWXn7acExxIEHircqZIzKugEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Tue, 27 Aug 2024 14:00:48 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 14:00:48 +0000
Message-ID: <ac929075-27a3-8cbd-5ffd-966ea3e82697@amd.com>
Date: Tue, 27 Aug 2024 09:00:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/mm/sme: fix the kdump kernel breakage on SME system
 when CONFIG_IMA_KEXEC=y
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, noodles@fb.com, x86@kernel.org,
 lijiang@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org
References: <20240826024457.22423-1-bhe@redhat.com>
 <35e40987-1541-cbbe-6b16-1ddadc2c4c35@amd.com>
 <Zs1FrZVuZK14Je7z@MiWiFi-R3L-srv>
 <be6e5ab6-8b43-1a3f-39a6-b4aa5e0523ac@amd.com>
In-Reply-To: <be6e5ab6-8b43-1a3f-39a6-b4aa5e0523ac@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::17) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DM4PR12MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: 742a9754-bf7d-45b9-5a1c-08dcc6a0a702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akxuR3BYTVVZcHVOZmtFUjgwOWg3ZDlLMGpXamk4bjV6eEdaN2l6d1gyaDFI?=
 =?utf-8?B?bGdsdGdSVmlSTWt1K3ZTdlR1TGRqSElPandaeVhEdS9iMU1TS2ZtOGM0bDdZ?=
 =?utf-8?B?blVRUnRIWmhoVTAyc0ttU3NYRit2K3R3bld2aFRoTHVCRGVzcEpMZEpPUXRT?=
 =?utf-8?B?cHNla2dLWWU4cWZmd0lzb1hULzFydGRhYnZnRmppQzdMK3d6WWwvQzRtYjFC?=
 =?utf-8?B?Umk0S3JybVZUbXNkdGcvRTNTUjhrUHUwaEFGYy8xbHdkQW9BSnhINS9xL251?=
 =?utf-8?B?UUM3L0krSUN0Z3drUm9xL1hYcU9lN0ZMNGVGbjFiK2pYdXd3N1Bpb3VtR3VC?=
 =?utf-8?B?dC9xeWxJanFVUktVMmtaSWhZZE9JTjhRay8zaC83NGFXdkZSNitTMGMreTNH?=
 =?utf-8?B?UUtKOTQ2bjZGbXRVOWV3SVFhRTVYMjFUZVYzdWM0Ujl2MGwwdTNXMjM0bFU3?=
 =?utf-8?B?dm9FeEt5RUpocXVYOG9BVzZCR3R5WWE5UlB4VkdaTG1YYml1b0dGQUxvRnpY?=
 =?utf-8?B?WG1oamZnQlNTTzZMa0VVSnNRWDRVclZjV29zOFdwV1BmMWdnZEFQand6WStU?=
 =?utf-8?B?K2tVWS9oL1UyTHhBWk00eTRXWGRielE1LzJsTTl3cnA5NXBqZG9OZi8wZjl1?=
 =?utf-8?B?SGhxVVNoL1lYaFFRSnZjNGw2KzFYMDNXVkpEeDRKSnc5bUhkY3lqVHdKZSs5?=
 =?utf-8?B?eWZMSDc3S2dRTXkrVzlGZGNCT1dscnc3Q01mUDEyb3E2czBYSW9vSDhVVHdD?=
 =?utf-8?B?cHhpcENNMTZYY0ZOQ01PdHRnVkpTSEhFMzJlRkJEZkVWR3lJSDJyT1hXNUt6?=
 =?utf-8?B?QW4ybUlEQ1dNMGt3eFFqN1RXdEx1cUJjdGptN1JHTlAzNVllVmcrd1UvaWJR?=
 =?utf-8?B?bmhoNUcvS0J3MWZpa3BYYytjWWhsUGRVblQ2dFN6QWNrQWR3VGlTNGxVcHhs?=
 =?utf-8?B?ajhYZExid29rK3JrUFFYU2RNUXhtQUh3QjA4SFplOVdNSExBTGYreE9UNlZK?=
 =?utf-8?B?WTFGQkx1VE4vZHZjTkFPY0EzeGgyMER5MnN6OHdPRlNyWGF5aFVYUVJQMUlX?=
 =?utf-8?B?eTk3elNYRFNod1cvZmRIMFY4RDE1UHpIMHhYYncvMzd3TG9vWGxBUjFUSU9E?=
 =?utf-8?B?WHZ0dlA0MmVtdlBFUENGV2ZvSXhDMFUzaTNURlZWZHZHaFV2dGt1U3FZbHN3?=
 =?utf-8?B?Qi9QdWVaQmg5TmpBcng2cVRmaG53MytydUV4elBvMFJIUHJmTi9sVk4wOHJm?=
 =?utf-8?B?eVc2SkFnREE3OHJ0YVdqSnUralpiSGNLdEE2MUVXWXBlQkF0YnRleFhXenZ4?=
 =?utf-8?B?WnI5N2c4VFVhYldjWWtMbkE1WmVyYWRLT2NVVnYzN3VscWIwWXh2SFhZS2FI?=
 =?utf-8?B?S1FraXFGWldTZTFRd3F4UTdXUXczVTcxb1hrSW5GS1BKNG9JSTE3RFg4b1Mr?=
 =?utf-8?B?VG44YTdyY0ZrNnI5UFpXbFZNeHB2THFKYUJDM2RwNy9Rc0ozbWxTRmpiNmJm?=
 =?utf-8?B?SXR3YWxudkM2a2ZoWVpIQ2NZeGdIb0tqcklSczM1OWF6TnQ3a0dxRGZWMGtl?=
 =?utf-8?B?RzFRQTdOSStXMkVzVXFKNGhMYklRMTgzdjJlbjlDWDU3WmgrOUZMQXR3RlVr?=
 =?utf-8?B?cFpGOHlaajBRdmEzdDlrZk55cFFobE5NQWRRRFNnWjBCNkYrczhGdHFjRllZ?=
 =?utf-8?B?Zmh5WlRoMHozakxodkJBOE82V0VSQi9HM3pDTTZBS0ZGc2lJajVvNlZEMnJp?=
 =?utf-8?B?Z0dBcE9PNWhySy9UaHRHZ25GTnVRQ2dYRi9wd0UvMmZDbklyOU9vNERobG0y?=
 =?utf-8?B?MjZRMHpYK2pSSzNva25zdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NG9wdElMa0ordWE5R3pZbW5Oc3ZzVDNHNCttcUU2QWdnOEhoNC9GaC9naThM?=
 =?utf-8?B?VE9taEFXY0hKYmxGdm5uMnRzUjFib0JhaitsN1NFUlZ6SUUvMGpmRzZMcVlq?=
 =?utf-8?B?Vk54cG1jWVZUMFM0TXRNSGcyYlZmTTlYOUZMRWZhS1VTWCtDVENWZ0liWmgx?=
 =?utf-8?B?dytmaGdyWU1VZ0V6TUpCaHNFZ01aSllWbHhVdm8vWkl6RkFvZ2RaM2lTaU1h?=
 =?utf-8?B?dXZEaDg0L3hmQWFuZFQ4Y1BBSkEwZzd6Z0hXa0paRktDYk1Ebkgwamg3enpF?=
 =?utf-8?B?OTk1UzNLeVc1VWVHT1VzQmJqL0c3MjA1d094SlFkRW1IRytaYVkzc0FSSEJ6?=
 =?utf-8?B?NC9XaDMzaHd4cTNQb0daNGptWkRlMUk4VWlEK2lwVGVsSlBxSGwxOXZLMEVE?=
 =?utf-8?B?ZUlkdzB3Q1VtVU1kdUlYa1J4VnZ4aTZteUFUbTJvSHhWanlUSTlMQVRMMVpo?=
 =?utf-8?B?aU9uZXhybnBHZGNGWmZhRHh4ajFsM24vUTNQdS9ISkhYaXVWTmpHSGdXY3pq?=
 =?utf-8?B?N0Y1a3pkZTBOWVZtZ2RCMTZvbVREUmpveWFFcDJDVTlpSHRVTTRsNHBVMWth?=
 =?utf-8?B?WFhoV1hSVmFaTzYwVURzRlJSUGVkc0RTQTFPbytraWk2MWM2cVhra0tBWWJv?=
 =?utf-8?B?eC90ZnJqZkR3YnA3TUQrMndSOHlBaXk2cFZHYzJzY3lDdlBMbHoyYVZlUEEx?=
 =?utf-8?B?WlhteElLbElXbklpVGRNWm1oYWpPdVZlK1FxMDhudERacWlKQVIwZjlTMVo0?=
 =?utf-8?B?dW5RaHhWRTZRMmIycmgrRkRSUjJaZFlyZWd0N01rdHpOTlN4QjVwdHNjaDhZ?=
 =?utf-8?B?WlpTdldIVStKQWpaNTlYVmxOTjROR1g5UWxDVHcyQjl1bXpYS3R6aXBYOEdS?=
 =?utf-8?B?RkhlSXA3WVdHU2VJSE90bXdqa3dIVUJFdGc1dmhyaUduWmwrQ0ZyS05FNUkr?=
 =?utf-8?B?dnd4TE01RzQvSVNpc1hOc01EcEFHTXVtVXFWSEliRStKbVUwbXBmUUFlL0pJ?=
 =?utf-8?B?c2d5K1d5TERBbXU1bnh5bFRhcGNLYUEyUUsxU2d3UUZmdVEycEJTU0U0cnBQ?=
 =?utf-8?B?dXVWZDhIeGpaUm1SeWhrZlFHcURCMnlWVjdncUtPRUhaOUV1UUlMRkNHZUk0?=
 =?utf-8?B?R2xtTnU5RGtJLzFmM1lCaVVtdHF6ZnRtM0xIYTBJRTdUUFlvN1k5QjFZZVZy?=
 =?utf-8?B?cjZqSWZ1TzdOeVpqamJBY1B3M3Q3OEY5MEU3Mm5uQmk1aEhHV2dVOFZ4QThp?=
 =?utf-8?B?RXJhQjkyNWN2ajNCOC80WXZGWTRYTVZnZjAxcitzNWZjV20wR25adDRsb1Zp?=
 =?utf-8?B?d29VWVZWWEFMZXNvYkxlMHBnNnlRYnJ6TUxTM3hpSzkweDltRFpWZWY1NERK?=
 =?utf-8?B?NkxsTTdJVStFOEFnZWpUc3BOdlBUbmhQZXEzOURJSmVBUXU3OTlHTzhXbW5W?=
 =?utf-8?B?M01EcVBXY1NsZzhRb2VFOFpyMVZ4L2NUUER3Ym51a3ZFTE9LNDk1SStwUVBw?=
 =?utf-8?B?c3NhTHFsZXFVL3FmRG5pUld5N2N1YlVPclcvR2hSK2VLS0REbWNudVFXaGRC?=
 =?utf-8?B?ajdwdENsUGZaajVXSE51MWNVRHU1M0xxclpFd0pXeDZaS1ZxaHRaSFVhWm1X?=
 =?utf-8?B?OGhZMHlTdEZCajlCbElQWE9xQm80NUpaKzUraVhrQ3QrWDRCYlVPMjNSa1Fj?=
 =?utf-8?B?K1gxaHNpUTZwMmZEVFlQQ2k1UHJBUWxFZU1veGlWYVQycmRkSWsvYVY2T0Vq?=
 =?utf-8?B?VmZxMm12R05MVDZrNHVqclBQR2VlWElBbFZrRGlYNHpRZUZRYllvcis1bWhs?=
 =?utf-8?B?bmhvMG4zclZZSUFYMkFQL2JhRnhOR0tlK3Arem9MMEp3WERxT0ZwZkxnbHVW?=
 =?utf-8?B?ekYzMXBpYW1jc09NdzdYYVpNVzZNU0ljRUNwZlU5WTgxNEg0SmlXV0lQakRI?=
 =?utf-8?B?ZjQrL2pmYm93NENZcXdhZ25lTXM1WjNtbTRVQmpQS0JOTmdCaGRuLzNMVHdo?=
 =?utf-8?B?Q01obDN2Znc5UE5qNGlya1ZHTEtZTFMyL1pla2pXTWd6Tk8rUEFRaG5tYXlu?=
 =?utf-8?B?RGYyT01PbEtsSU11NkgrdlNFeVB4aWZPd1VxanMyTVZud2J6cjFuTUtKOTQ5?=
 =?utf-8?Q?Ezv0Vi/PMAWqBGLknJW2t/76P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742a9754-bf7d-45b9-5a1c-08dcc6a0a702
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 14:00:47.9749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfwaVCussP1eddAO1UQOrQLgnVB4VSdolaX0K3qpa0MYqqNIzuJIvEVvpJujx+E823SgQBrEQe1bBAkTTlRgbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6351

On 8/27/24 08:52, Tom Lendacky wrote:
> On 8/26/24 22:19, Baoquan He wrote:
>> On 08/26/24 at 09:24am, Tom Lendacky wrote:
>>> On 8/25/24 21:44, Baoquan He wrote:
>>>> Recently, it's reported that kdump kernel is broken during bootup on
>>>> SME system when CONFIG_IMA_KEXEC=y. When debugging, I noticed this
>>>> can be traced back to commit ("b69a2afd5afc x86/kexec: Carry forward
>>>> IMA measurement log on kexec"). Just nobody ever tested it on SME
>>>> system when enabling CONFIG_IMA_KEXEC.
>>>>
>>>>
>>>> Here fix the code bug to make kexec/kdump kernel boot up successfully.
>>>>
>>>> Fixes: 8f716c9b5feb ("x86/mm: Add support to access boot related data in the clear")
>>>
>>> The check that was modified was added by:
>>> 	b3c72fc9a78e ("x86/boot: Introduce setup_indirect")
>>>
>>> The SETUP_INDIRECT patches seem to be the issue here.
>>
>> Hmm, I didn't check it carefully, thanks for addding this info. While
>> after checking commit b3c72fc9a78e, I feel the adding code was trying to
>> fix your original early_memremap_is_setup_data(). Even though
>> SETUP_INDIRECT type of setup_data has been added, the original
>> early_memremap_is_setup_data() only check the starting address and
>> the content of struct setup_data, that's obviously wrong.
> 
> IIRC, when this function was created, the value of "len" in setup_data
> included the length of "data", so the calculation was correct. Everything
> was contiguous in a setup_data element.
> 
>>
>> arch/x86/include/uapi/asm/setup_data.h:
>> /* extensible setup data list node */
>> struct setup_data {
>>         __u64 next;
>>         __u32 type;
>>         __u32 len;
>>         __u8 data[];
>> };
>>
>> As you can see, the zero-length will embed the carried data which is
>> actually expected and adjacent to its carrier, the struct setup_data.
> 
> Right, and "len" is the length of that data. So paddr + len goes to the
> end of the overall setup_data.

Ah, I see what you're saying. "len" doesn't include the size of the
setup_data structure, only the data. If so, then, yes, adding a sizeof()
to the calculation in the if statement is correct.

Thanks,
Tom

> 
> Thanks,
> Tom
> 
>>
>>>

