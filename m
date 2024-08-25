Return-Path: <linux-kernel+bounces-300319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D912495E24F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 09:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29A27B213AC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 07:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14DD47A73;
	Sun, 25 Aug 2024 07:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="TCh9UJG9"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2079.outbound.protection.outlook.com [40.107.255.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F0E10E6
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 07:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724569747; cv=fail; b=tb+D0atjWxOBzHiy2yup/2ASPdnu0nfnLK4pQi6vZcNfUhe6IQc7WGfWKzuqHTQaLT0422LOCWKLoZUSSfsa/54i3IiFMr6jLIliUx1tiJ9Ojf5ykVlbwxptekCipJc44E4h2Ky/nsAz/2lFx9eRYUH8VasZEJgS7sMrV3KYsJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724569747; c=relaxed/simple;
	bh=wB671p//g6mqH3XBC2mJlkG6pYpyC7ivaOl5Bm4iao4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OjtSuJwgwuSs8rIGOcHKmsVAyT5RGt3JXYSfQS5KHuwo6lmExKTgfUbo4qdQ10sebtfYHD4nuInThzfyQIK4S0/PaAdgtuZHaalqMq/VToZlT82TolM1echC/DrQez+luH788qfHBXkwNQgEC7FVmMLZOt69LDjL0FatRohSu1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=TCh9UJG9; arc=fail smtp.client-ip=40.107.255.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRqU3nboiqDXPSLoD3vp2lWZnrxWji9H+yZvI+DmniAe1Wb+rGK8QoP1oyrvPpdvsu23615N+W1lO9i7lcHSuByHd+JMuVyl1XHTfMAE45D/q+GS/TEOS57C/96CQ3m6foGhSLu39amjksNoe+oFVH82trP0b2OF1fhkM5syHCnxjfYGxrmSzfZ5Dw0R23ZnB7M5mc8+nPfIYi1BiR7/WhJLkjS2YgWmk8ojPUo2IzYTc6qTPqH5NZKLqk435SjDqFvEYd52d1q2FKZ03hV5rfOyXf+2hh0cY+Q/Zkdo7t1r0D8CoMwcOyS/h57GNGI+2Eb+FYf4I6ESo50va4idtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLG13tXoPQe/6GKh2OqJj+PWRVwR0obyZAepoTqMmJU=;
 b=IWyPL4ubPLRTBFvb2/st2KwAHNqODWzEvkkg4JCeCLpa6be+B+sI/4Gx4rF9zWH947Emb5n73PLLI+4ZD+KBq89p7OZwyBptUhl8Tb60HD00LtMvW4TXENLEH4w62Bb1UhK+2dLmx0xs7znqWCT9bBUbW0/4BPkD9BTS+baaxJcw5k743DqPx2Qo2toZUYjrmwvlZsuRHZeBGsaUhT5CAIUnGBKFYWUOVZ6mOhnc8MgUrns/eoLiHq7YftY9vcHe8A2tJXkwdSD/r93GnomyAD6JS0KrQ8ktsR9+BZkmsMq3ZwrcnfoGu+VWqLLf9JK26hC5hb1Q3wFOGYTTJP7Pdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLG13tXoPQe/6GKh2OqJj+PWRVwR0obyZAepoTqMmJU=;
 b=TCh9UJG9dEx9X6PatymZpkHot23AHQmx97o1d+l8rGeqHYnlAAfp3u+EBxWcFjyggtE878GGOK5Vzql6EJN7J1q6fuWZbR5VKS/DX+O/qWtliDUh8LSTuhmzzGRfJCGjtmiUTxgL8/0h5Yq/fybeCsLTrBlu/QMzUPPZrP47jM5quoKCsUADy7YYH1ZfjUhdQlkowzsiZaiPjj9Ro0XwMry+CnCNojrXD36bSuYxBFcXx01dVRIMxVKHWg2CLj+H3edz/LZHwjgMRKe3q/Zs71CHImaD007Hpkd0ac6XTH5q8+dXT0R+7awhrgJI/lkIPSjn2UHC4IO5R7hfHXdp5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SI2PR06MB5114.apcprd06.prod.outlook.com (2603:1096:4:1a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Sun, 25 Aug
 2024 07:08:57 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7875.019; Sun, 25 Aug 2024
 07:08:57 +0000
Message-ID: <5a17754a-162f-48e0-93a5-19b043d29c37@vivo.com>
Date: Sun, 25 Aug 2024 15:08:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vma remove the unneeded avc bound with non-CoWed folio
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, oe-lkp@lists.linux.dev, lkp@intel.com,
 opensource.kernel@vivo.com
References: <20240823150206.565-1-justinjiang@vivo.com>
 <73ad9540-3fb8-4154-9a4f-30a0a2b03d41@lucifer.local>
 <4dd13a4c-e968-4a3a-98e5-97f28036deff@vivo.com>
 <1109aeab-fd4a-4c83-a110-04d01177d72d@lucifer.local>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <1109aeab-fd4a-4c83-a110-04d01177d72d@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SI2PR06MB5114:EE_
X-MS-Office365-Filtering-Correlation-Id: 772b23ef-e2ed-456b-6b06-08dcc4d4c938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ujc5MFdBTmVCclVHdjBiVXVSU2dib1lVd1NSWEoyOTNxaXo4ZkRlVk9RQm03?=
 =?utf-8?B?VXJnbFBMcjBCNTkyQlFPRS9sMW5hcG05WUxxZjlsckZxemp1U2xPMysrNFRH?=
 =?utf-8?B?QUE0UVNodUd3SzFVd251QWJ3RFdaWW5JaG41TW1vOTFoVHdpTk9MZy9IUDlU?=
 =?utf-8?B?YzR0a1JoWXJ2OGNaVHhOcy93eDlMQ0RtK3luV29JakZuYkd3ZmNwNjJ2bjNl?=
 =?utf-8?B?VkVvT1lFYnRCcTlobDA4NVA1Rm5sOEI4MFI1Y1FWLytkc1Q5eEphVmgxZUdG?=
 =?utf-8?B?QWdMUDl6aGIzdmpieEVCQkVvK0Vyb2VrRjd6bVlKUUhoUW9ERE4ybktEdnZI?=
 =?utf-8?B?UENXRXY4dHE3OTdsN1BvRlNaLzBwNEZya3NPbkI4MWtWQVNubzI3ak5ZM3Jy?=
 =?utf-8?B?M0dMSGp2cmUxNDVZUzNBeWtXTjVzeW9JaHkwSXZUTlNCMmtXVXB2cWRXZlEz?=
 =?utf-8?B?ZFVOQzVncnNhM01lanlTSUdxL21VNDFLVEJZWmVPWUUrTVlHSzRyZW1TajhR?=
 =?utf-8?B?TmtSTnlQM0VIT1l3cUg3NW80RXdnMjIraUFldFA4b2hNbmRBbVpqcUpPTmda?=
 =?utf-8?B?cXlYbWdVSitMV3RZeC9jaWNzTG5Ddm9Zd25VUjdEcFFkUTFGUGRkd0lkVEYz?=
 =?utf-8?B?bURMMFpFREQ1b3pUTGhrcmtGa2tYVFNodVdFYXRJUXl6L0IrQ2ZXbGZBQ1Ju?=
 =?utf-8?B?cG1WR3hYaWxSWXo4N0d4SG9hQTRGSlEyMlZuNzhiaXd2OFhFcEx6VExUUWkv?=
 =?utf-8?B?NkVlWUNkSWIxcElHWHVHUTdoTWcxSlcwNjlhS2NSeXBwVzNFeCsvYmphd3U1?=
 =?utf-8?B?V3pWYnlLc0VlTmUycUliQW1YVy96Qi9vVTBkSytEdTV6d082UGZZOTgvNTF0?=
 =?utf-8?B?Z3FaUk1kd0VONGp2dkZDVStXcWNjMXdpYzgrL2dFQmZJRnY4M25ib1lmcnd4?=
 =?utf-8?B?VWd1Um9JM0ZNbG0yRUVIRzZUR0FHbGV6UVViOUZmeFpVenRRUitob0lZaUVk?=
 =?utf-8?B?eWVQbUJYS3FJZTUraUxJNitJckpJUVNnNDJkendhWEYyVE1iZGlQNHRJajRo?=
 =?utf-8?B?UkhZVWF4VDAzR2VDZmNCRitGbzlWVVkrZWNESDJ3T1BKdzZlV0l1QkU0OERF?=
 =?utf-8?B?U2tWNEI0VzcvOEozQ1Z1bTFsQ1BzWXVGbXcyZzJ0S3VsR2RrOXMrbHF4NXFX?=
 =?utf-8?B?a3cwd0dBY3J1K09VUEZzdXlETU54Z2lOa00rMDdMQmJpcEJ4N1Z2QTVkWHNy?=
 =?utf-8?B?UWdNbWU4NjFHd1pXbnUvOStyRzJxd1dKeldCMjJjeXpsZTlwVUNHaTlVQStF?=
 =?utf-8?B?R0Q0ZG5GK2s2cWlvTWpJbDNUSnBObkhuM3F4eHhmWUs2TldXdEM0RHVpOHNF?=
 =?utf-8?B?YTI4UE5Nbm8vT3NvbEgwSFNQU2tNVHVvSVhzdkc5S0I2aFBjQjhDTmRVNEdF?=
 =?utf-8?B?dzNmTGNkcXd0S3AzTTM1WTJXMW1od0dVcmZYSTUyUlc1a2pOa0pQWTVyYlEy?=
 =?utf-8?B?UWhTUDVJUTJONUpIejZQZHBNcTNGYzRLUUp6M1docmwyVTFZRS94bXBMMzFs?=
 =?utf-8?B?aGpIcWJKdnZCM2xkcy9xMVNxR2QzeFBCK0xGd1hBcThFNGVDKzhpdzZoSEZi?=
 =?utf-8?B?KzYwem10dmtRY3VaWVFHOUhxM0tRU1I5bHQxMHE0RTNiTDlrTDc3cXlBcU5X?=
 =?utf-8?B?b1R1RGtFanVzSXk3Z0NhTjZ6anlieWhmS0g3N3NmNkl1SC9TMjZncUNTRDFW?=
 =?utf-8?B?b2dHQ2lqZnBUNWJKT2w1VHdBMzdreDNrUXEveGtSaXo0YXBwUVJBK21pd243?=
 =?utf-8?B?dG1RK01nUWo0ZmFja3lJZHUrTGw5eFZwTDcrbXdQNXhHR3dxejUrK21lNENt?=
 =?utf-8?B?b1BsYXpwU05IRDBoTmVNNFNhYVRuR09mYXAvWG9hREZsOVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGZ5WTM5UEZWbDlkYTFlelM5ZUJiK3hPSS96cDRGck9wRHBUc2hMdm9tUnZr?=
 =?utf-8?B?dkZRdDQyb1F2cWxwV2c1dzVxZ3FjMXlZckMvVjdncjNDUURZODFxaE5oUGRO?=
 =?utf-8?B?MVBJUmRVZ2VFRVh1VnU3cUxrL2FwSEtzeCtHKzVtdjBXTENDc05xc01GNUFG?=
 =?utf-8?B?TWJxdDBMZkRUUHoxYUl4VkJWT09ScElnSXU0R01Rem03Wng0OWE0c2o3SGE0?=
 =?utf-8?B?RnViZlk3cXp3N3R4bEFqcVEyTEZPWERpZVRMR3BHTE03TlpDMnVUWk40dHBG?=
 =?utf-8?B?N2I1RUZaMFhUS0tMQ3RqNWoxOWNXNHl6ZitiVEsxc0RHOTkwTWUzbC9QTzhY?=
 =?utf-8?B?NHE4NlF4UTZTVU5TRExFR1lyU2ZOUjhUUWJzVEJITnpEUGlLVEhOdHlCWjhj?=
 =?utf-8?B?Yi9SL0xCYlRkM2tSV0tnR092MHY1Y29XL201NGNCb3pFdThlOFRhdU9DT25N?=
 =?utf-8?B?VGQwYys3RitYSEkvcUFsYkd5R2lXYjl2cHprdkdidjJtMWFwK1hPYmZ1UWFj?=
 =?utf-8?B?Si9PYVVwazVPQVdUL0FldjBmSU1yQmFQTWh6bGh6Vmc1SU5SWUxPbmV2c2Qy?=
 =?utf-8?B?MjBsSHVyM2lWOHVDZXJiOWpoTEIrNjBUVUswQ0Z3Y3hPbGZrQ2N3NVRwSTZ2?=
 =?utf-8?B?ejFMV0h1M0F2WUZmVGJmTWZJdWFtcWUvRmhvTDRLSGhFdjgxT0ZKMlRHTWM4?=
 =?utf-8?B?NkJpS25oMTNKWGVQaUtCM0MrNStPa1FJUkJGeVY5S2orc0l2VDduZi93SWlk?=
 =?utf-8?B?NFZUUHRlaW5UQ3hlU05ORGJ6QUZwR2wyc1poR0tsWEFvUWpKcnBtOWExRDVP?=
 =?utf-8?B?SUpNZlpFZ095NU9HaHFldkRtd1ZqZlZyK0FJY2VXTUpINzYwMGtBSzQvRlJQ?=
 =?utf-8?B?VERoSVFVaXJRYUtsM3pFeWxqV05aamQrMFNlNHduSG5HbDFMWis0V0kxM21K?=
 =?utf-8?B?eldPMnNCYkZ2dFIvbmNHQXBTbWxDZ0hVdzc2clBDVHFLbzFPbWFQU2xhMGp0?=
 =?utf-8?B?alMzbVhRMXl6elVndHcyMWQ3c1lXZzVtbGpiWldjVlZxNG4wRDJlbmovZ3Br?=
 =?utf-8?B?ZTE5WmZ2cUhPWkJMRXBhQUNIVU9VVzczQWhaQVF5SVpKYlp1eVZTeGswMVZx?=
 =?utf-8?B?bloxM0ZUYVd6eW83UDNUNnoxZnZsTHZOMWNWWGdoVkNtQ3JWOU5YbmxaZThC?=
 =?utf-8?B?UlRHLytIdTg2S01OQU1yaHVwRHZzZXdpYVBZTmk4c2JiVjhlMGlreXNmaFU3?=
 =?utf-8?B?Q0RaRVBqUTFsMXdtOGhmcTlKMFdmQnJMMDJTdW1SL2laMFVKa0I1ZjhaWDJk?=
 =?utf-8?B?OVZhWE1NbXNFUmNKT29Ec2hPNEZ5cUdwMVcvdUhHQzdpcnkweWNjanZnMDJh?=
 =?utf-8?B?Nm5YSWFXWHdFTGVodE9OQ08xRnphWHJHaEgxZTh2NnBTYVFoL2ZCS3VlR2t4?=
 =?utf-8?B?WVlSR0NEcXhNTU0vYmh0U0d1ZmhUSDhCSmd5SFJEbGFkc2FaYlQzTU5waGNT?=
 =?utf-8?B?UFRSVlY2bGU2U29RRStVWkRydWtzYVBOaFVxRHRKcS9IaFFOeUNMUWRVdFZU?=
 =?utf-8?B?cDBqUUp2S05IM0R2UW1NYmZTTlg3QVAwaXRXTW9VTWkyampPQmxjWWllNENH?=
 =?utf-8?B?d2FKODBVWFU5TUZYVWYxZFl5MVlGT3FuWXdmckhlNlg3dmNlUEJ3U2VURC9T?=
 =?utf-8?B?TEN5U0o1dVpFKzhQV0FaVmxkUEU0UHhLYjdlYklVWVdJTXo4Y3RvaVFaRjRF?=
 =?utf-8?B?Mko1KzAvNlZKR0Rla3FVa1RKQWdpOU04SllBNWw3TVBzQjYwODg1TW93b0Zk?=
 =?utf-8?B?NGZLYjY5ZUlhbmFhRzRGYUc1dk5vVDRaMVFBRVdET2p5TEIyeVg0Wm5uZ3Aw?=
 =?utf-8?B?V2J0Y2N4OVBwRGRqWTFhVFN0WUFBVEVrcXRRalE5VkdBVkdDbGJmcTFNMlVZ?=
 =?utf-8?B?WFlEajk1dUpaeGhMVmhNK3JOTmMwQmtlb1d0VTVHS0NoYUF3RnFzaEhrRzRI?=
 =?utf-8?B?ODJHU1lacUQwL3A4ekIxNWVrd1F0Z200UVIzcytrWnJXRVJsZGEyazdFVk5F?=
 =?utf-8?B?UnNXK0JMR1pKU2lQVU01NEZNZ3l5OXFHa3dHMFVBUytjTkJ2QUh5SUxBcGlr?=
 =?utf-8?Q?+B5ZYQDa3A4Yh7ET8EOv+svpK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772b23ef-e2ed-456b-6b06-08dcc4d4c938
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2024 07:08:56.8707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHf20ZIc2FeqUb6WZW30E6isp2xgF4jRgjFAu9gPiv7DvD8Cc2qweHxOjv0rQSIut/8d9xs8zrJSuZiCazKpkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5114



在 2024/8/25 14:42, Lorenzo Stoakes 写道:
> [Some people who received this message don't often get email from lorenzo.stoakes@oracle.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Sun, Aug 25, 2024 at 01:06:40PM GMT, zhiguojiang wrote:
>>
>> 在 2024/8/25 0:26, Lorenzo Stoakes 写道:
>>> [Some people who received this message don't often get email from lorenzo.stoakes@oracle.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> On Fri, Aug 23, 2024 at 11:02:06PM GMT, Zhiguo Jiang wrote:
>>>> After CoWed by do_wp_page, the vma established a new mapping relationship
>>>> with the CoWed folio instead of the non-CoWed folio. However, regarding
>>>> the situation where vma->anon_vma and the non-CoWed folio's anon_vma are
>>>> not same, the avc binding relationship between them will no longer be
>>>> needed, so it is issue for the avc binding relationship still existing
>>>> between them.
>>>>
>>>> This patch will remove the avc binding relationship between vma and the
>>>> non-CoWed folio's anon_vma, which each has their own independent
>>>> anon_vma. It can also alleviates rmap overhead simultaneously.
>>>>
>>>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>>> NACK (until fixed). This is broken (see below).
>>>
>> Hi Lorenzo Stoakes,
>>
>> Thank you for your comments.
>>> I'm not seeing any numbers to back anything up here as to why we want to
>>> make changes to this incredibly sensitive code?
>> I added a debug trace log (as follows) in wp_page_copy() and observed
>> that a large number of these orphan avc-objects still exist. I believe
>> this will have a certain redundant overhead impact on anonymous folios'
>> rmap avcs, so I want to remove it, which is also the most essential
>> value of this patch.
> Sorry nack to that idea unless you can provide actual _data_ to demonstrate
> an overhead.
>
> And even if you did, given the original patch was so completely broken, and
> in such a sensitive area, I'm going to need to be VERY confident you didn't
> break anything, so we're going to need tests.
>
>> -- the vital part of debug trace patch:
> Thanks for providing! Will snip for sake of making it easier to reply.
>
> [snip]
>
>>> Also anon_vma logic is very complicated and confusing, this commit message
>>> feels about 3 paragraphs too light.
>>>
>>> Under what circumstances will vma->anon_vma be different from
>>> folio_anon_vma(non_cowed_folio)? etc.
>> In anon_vma_fork() --> anon_vma_clone(), child vma is bound with parent
>> vma's anon_vma firstly.
>>      /*
>>       * First, attach the new VMA to the parent VMA's anon_vmas,
>>       * so rmap can find non-COWed pages in child processes.
>>       */
>>      error = anon_vma_clone(vma, pvma);
>>
>> When child vma->anon_vma is NULL in anon_vma_fork(),
>>      /* An existing anon_vma has been reused, all done then. */
>>      if (vma->anon_vma)
>>          return 0;
>>
>>      /* Then add our own anon_vma. */
>>      anon_vma = anon_vma_alloc();
>>
>> new anon_vma will be alloced and filled in this child vma->anon_vma.
>> Then during CoWed in do_wp_page() --> wp_page_copy(), this child vma's
>> new anon_vma will be different from folio_anon_vma(non_cowed_folio).
> Thanks for the explanation, but I was suggesting you have to put this in
> the commit message rather than in repy to me :)
Ok, I will update it in next version patch.
>
>>> Confusing topics strongly require explanations that help (somewhat)
>>> compensate. This is one of them.
> [snip]
>
>>>> index 93c0c25433d0..4c89cb1cb73e
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -3428,6 +3428,14 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>>>>                          * old page will be flushed before it can be reused.
>>>>                          */
>>>>                         folio_remove_rmap_pte(old_folio, vmf->page, vma);
>>>> +
>>>> +                     /*
>>>> +                      * If the new_folio's anon_vma is different from the
>>>> +                      * old_folio's anon_vma, the avc binding relationship
>>>> +                      * between vma and the old_folio's anon_vma is removed,
>>>> +                      * avoiding rmap redundant overhead.
>>> What overhead? Worth spelling out for instance if it's unnecessary to
>>> traverse avc's.
>> I think this will have a certain redundant overhead impact on anonymous
>> folios rmap traverse avcs process.
> This is again nowhere near detailed enough, and again I'm asking you to
> write this _IN THE COMMENT_ not in review.
Ok, I will try to test and update it in next version patch.
>
> I already understand what you're trying to do (I think the fact I provided
> a _working_ version of your patch as an attachment in this thread should
> give a clue ;), this is for the benefit of people coming to read this code.
>
> [snip]
>
>>> Again I question the value of this change. Are we REALLY seeing a big
>>> problem due to unneeded avc's hanging around? This is very sensitive,
>>> fiddly, confusing code, do we REALLY want to be playing with it?
>> Thank you for helping to identify mang issues with this patch. However,
>> I think this will have a certain benefits for anonymous folio rmap
>> traverse avc overhead.
>>> It'd be good to get some tests though unless you move this to vma.c with
>>> its userland testing (probably a good idea actually as Andrew suggested)
>>> this might be tricky.
>> This patch belongs to anon_vma rmap's content, and it seems more
>> appropriate in mm/rmap.c?
>>> NACK until the issues are fixed and the approach at least seems more
>>> correct.
>> Thanks
>> Zhiguo
>>
> Please see the attachment in thread for an example of a working version of
> this, this is sadly fundamentally broken.
Yes, I have seen the attachment you provided and thank you very much for
your help. I will update it based on your modifications in next version.
Currently I am thinking about how to implement the anon_vma->root code.
> But you're going to really need to sell this a lot better, provide some
> numbers, and provide extensive testing and a much, much better test for
> this to stand any chance.
Ok, I will try to do some tests.
>
> I appreciate what you're trying to do here, and it's not totally crazy, but
> we have to be so, so careful around this code.
>
> anon_vma code is horrendously subtle and confusing (I actually had to
> reference my unpublished book to remind myself how this stuff works :)), so
> we have to tread very carefully.
You are right, anon_vma code is indeed complex and sensitive.
> I definitely think we need ASCII diagrams if we were to go ahead with a new
> version of this. But then again I'm a bit of a fan of ASCII diagrams...
>
> Please cc- me on future revisions of this series, thanks :)
Ok.

Thanks
Zhiguo


