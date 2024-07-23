Return-Path: <linux-kernel+bounces-259534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1D0939804
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 03:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01FA2282D01
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 01:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BDF139D16;
	Tue, 23 Jul 2024 01:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WYlouhGw"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC77D1332A1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721699029; cv=fail; b=cUkwf4UdOaoKrE8CzCxkzRfAjL6JbPxl9mp1ZfDfowjwOeLB2BUUIXMHfUCz7OPZRdDshbJFLKpr2oBNBRo2X2oSAgCuHPm8BwG2+IHCX0oMgEYice0Jn3sNGD50FVKG3La8ptgjSUFb6/BL3htRMa7YEnCLZu9+ax+jpX5Mv5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721699029; c=relaxed/simple;
	bh=d12ZpHjdUxVhL0Mri4/840HCPozBAql/rcN76IXgs/s=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=Flh316gXf2/WLJf3u5WIeKJWJXsC8WK7kg2xh0u6wn/bdvBzbuE7J8zrGP6PpT9pQviyjpFCfI01rtCl4iUrbPWTnEUyxyxjN+9vmR5aCA0bcoLdvgjFBjrXFvaelwiTczTOkuINX1ev3mqzQROpuL4ZT+MNy4RbE82vtFpzYMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WYlouhGw; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovqOFi/M6jUCsQQ4ZV1Ne0oKsaGiH5IRSV3e8Uq0ADkst/7CH3CvytwgpdJxmNtL68Rb2osetxPkG+QJT4CLuPc6zG7jXy42jYZmpYnMFPRuHXELbu5GpFI3n6tJC6NOCq29uY2J697XduELt+tU59kVwkbe2HngzOZYQPq/0YH06eag4RXOdeQEBNXTZUYidSnWapRPDLn3l0+mmwafYJNrduhNaZ3cOWFuooIQWpKtZD8xtFfQVorLkO6tlGz0yReHl0c7CK2Bdn3vJ228kccQzYmJCfvpw5O9Ca0w3e3lC4tOnpM6fMIanJRpbD7fKk4hb/uL05JThu2xA7fY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDuYxHGMWr+UWSvOl6EWBhhyNShG2TGC1f9ivLQ9WVA=;
 b=jU/WhZj8WZVkmNGDCybNGfH6KZoraPxVhZx5c7wgOtcdpnl/8+6iQ6yMMIkGQjoQyRHEmx0ZgMXSMbETwHT7xAfzEM4Ev018viP+OGryZ0cTvmmaIi7OLCU2LtGItw3c2RHKejnheDBFma2nX9cQmGxjbWQ0slrZXFX2AOdjskXr3EHyfzpkCKdjinKiaAtvPAd1gjkW6KU0ujd5zlqDuHkhDFd/6ZgDrZf9BDkWnNLFcTurgrzxU33uAe5WHJVeO9RYKmzXSRkiL+d+uGs0371Dt8sW4xOyJ523I0hYji/VCc5zLWoNide+zcKr54MvrR4QGuP4THuWqYrJJB1fmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDuYxHGMWr+UWSvOl6EWBhhyNShG2TGC1f9ivLQ9WVA=;
 b=WYlouhGwM8poWEV97GH/qZ3Nnk+EuDSPog9mglVs0C4LnuU7TrPhzX26vY4ZclGK7eul3m1RnAuT6ETvfJCAniID4nAVEL6zEEu2ZaDcE8vQynDKCrbHs2oYRLlFOchX8Ys+9wPqUm+JSVtUjtVJ+QKLm8o3Gi42IjxjbATqyFnHGx5Ko8W3rJsr2TAGhDPIOnpTZ8rwPQI8kbderJDramJEhywxGAYKEvo9NbIoyOHbfe1FVByjotC8LGQS2isWNnHuEZPI9WGnT2DuUWGdyrnZNtU0ULUyvxNcgDBNt6b6cUf1Nhqhm7ZERflyaTjUYJGCpL2uwWqZbbAYe3FQQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.20; Tue, 23 Jul 2024 01:43:45 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.013; Tue, 23 Jul 2024
 01:43:44 +0000
Content-Type: multipart/signed;
 boundary=c00737704e38f4c2189763a41c3b03984f69e7aeb2511c47c7b45142ab8c;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 22 Jul 2024 21:43:43 -0400
Message-Id: <D2WJD87NON2T.ZE0SCIMOBRIH@nvidia.com>
Subject: Re: [RFC PATCH 3/3] mm/migrate: move common code to
 numa_migrate_check (was numa_migrate_prep)
Cc: "David Hildenbrand" <david@redhat.com>, <linux-mm@kvack.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, <linux-kernel@vger.kernel.org>, "Mel
 Gorman" <mgorman@techsingularity.net>
To: "Huang, Ying" <ying.huang@intel.com>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.17.0
References: <20240712024455.163543-1-zi.yan@sent.com>
 <20240712024455.163543-4-zi.yan@sent.com>
 <87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <735B3DEE-5C4A-43BD-B003-17F4B1F0DC98@nvidia.com>
 <87sew2jiyr.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1844A1CA-7120-4DB2-8F67-8F91BA5B18C6@nvidia.com>
 <B9364CE0-1F23-45DD-8AD7-AAC8461FE6D8@nvidia.com>
 <87frs0kiwe.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87frs0kiwe.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BL0PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:208:91::31) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MW3PR12MB4427:EE_
X-MS-Office365-Filtering-Correlation-Id: 676827fa-6ac1-447c-4fac-08dcaab8e37b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VU94T1lzQXpkeVQvZVQ1VVgzaUxrNXRYQlZORWhHZUpkdGpKa2NHNDhsSUx6?=
 =?utf-8?B?M3lidTM4Sjg4QU81SGRJS3hRSG05U3MyaDA2QkNvVHZrMC9Bd3BqMEJSRWdI?=
 =?utf-8?B?dVFhVHBhVHc4RHd3eGFwNmU3VDZFVlg4cGl5eGRsa2VHZEEyZkNHUTdOZ2ZH?=
 =?utf-8?B?bXJTTDRyK3Vyd1FWR1RnR1VKdjBXNTQ1eHRmN0dFNmhJODY3cHQzQXJ2NGtE?=
 =?utf-8?B?UmNzY1R0RVVBUjNGblAyYnhlWkpQUHd1dkRzejFTcUJnejRiNkwrRzl1M1hJ?=
 =?utf-8?B?V3g2YURNcmQxcjFzRCs1TEJwUDdjR0lOWUE1ZVIwaFRRbXhQcDc0dzhRR1A5?=
 =?utf-8?B?UTgrZ1g1NTg1SVNNenR6WDVCOUlST3VqTFJQWVdsSE1ndmRtaXJqbC8ramRE?=
 =?utf-8?B?VUlidnl2TVk2dEI0b28xRXM5MTVraUV2WVd3QzlzMkxKZ1poWTVVKzB2a2FM?=
 =?utf-8?B?NGo4T3FNVHdEMSt1STZIbEtqa1pENHVXcEF1enNmZlpueEJnWXc3WDRyRUEr?=
 =?utf-8?B?NlAvUXFPeVJJMnF5cy9FNUh0Q25RanhyRzJxbGhlRFdVN2VNT2FMYURMTDJ2?=
 =?utf-8?B?WCt3NStwNkU4QWxHaWZiaDdFWlByMGk0SldpL1FYZXNObWxmcHFzQW1MN2hS?=
 =?utf-8?B?TGFCOFVRL2VvLzVKaW1TSU5vc1RFa293TForOHdlSU5mT2lmU1I5dndyVnFs?=
 =?utf-8?B?aWZxaklIclBTNGNnRFBLeFR2SnkzQXUzM0tFUkd4N0RxQkZnRVByUXAwdEFo?=
 =?utf-8?B?NnlFRjg1RjRLcWlibTRkaWFoVWNTZWwzaTF2YXFMVGdYb2g0SDFVNXFQM1By?=
 =?utf-8?B?SjBFVERCZ05Sb29PM0I1MWRwdm0wSEhOTEp1bThWelZJMWUzc2YwRkh4WWVS?=
 =?utf-8?B?blN0aVFoUVhldmFUMERXTGQrbFQ5Y3lvTTBsWThUNmxZUkFFV3hlcmtGZ2Fw?=
 =?utf-8?B?YkJpNFZOKzc1VUJic3dkemJ5cUl5VjZHRkZoQ21Kdm1FRVpWMm54VzJOVS81?=
 =?utf-8?B?SjB1MGVjcWRoSTZ1TDIrcFpHZnhYV0pjNlM0NC9DS1hZYnZDVng2RmhVRDRh?=
 =?utf-8?B?Y1RJekxRdldUL1hoNnZLeFhJQ2lFMlpGOXFuV2p2RjMwUHVCQmRQNWdWUUUw?=
 =?utf-8?B?VVVGcFYxTEJiWkhTRmZWZGFuNGlBVFIxWFV6Wjg4YlpRZjA3WUxyUlRibVBU?=
 =?utf-8?B?RWJCSlBqbkRyMVlEMEtNNm04SXNPYkhrR2dRL2tFemp2Q0sybXJUM1dZWVNH?=
 =?utf-8?B?RzZkUUdSY3JRL2pCUlhtdFEyTnNmZWpGU3JJWEdIWG5UWmhIRVQrbUg2WXdW?=
 =?utf-8?B?dVR0akZMRFEyeDVQcUdCem5aSnU4cG96Z2Nud09vZm84SVI1RDM3cEl2alVJ?=
 =?utf-8?B?U04zVmJRa2RyT0pteEtsOS9NOG1UWmZ4MkdvSEdrQVFiWjZiZ1BOOTNheFhp?=
 =?utf-8?B?RGkyblYwVjNZaFA0eUo1RXBjSWNLVlRnWko0cWRYRVJLZ25PVTU2STJIK2RH?=
 =?utf-8?B?WjI1Ykk1bkN1Tkh4QTBQZ2xxRGU3NW1UK2ZEVVlKQmgxdk13djBkQlpjbWZS?=
 =?utf-8?B?ZkhzNkU1V0ZWUlRlTmoyejhQS3lFYlVXd1p2TEZRbzRHV1hrL0tuYU1xaHJM?=
 =?utf-8?B?M2Z4cGtxSndPaXRDVGtURWRYNGM5TFFpN05kTHJwKzRKSG5BdEJ2U0lZT1ZQ?=
 =?utf-8?B?M256YmxPMnhVTVQrMStsbU5VM3hpR0xMa3RQY1dlQ0VWVzVsUlAyZ2tkeWJ2?=
 =?utf-8?B?dlNyT3VNeGd6WDcwL3drVTdaaEZjVDdPSGpidXdYcVpJdXpqZzNZTzYrNml3?=
 =?utf-8?B?TjBDS2RwaGJlNHd0WGo1QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTNOazNBaVlUcnFaazNNSi9hTWN1bFlIVDd0YnRPTzgwMGJtWk1uaWowMGF3?=
 =?utf-8?B?Y2lvR1ZSZHNVUnlDNGNQQmhvYURycFVnZjNLWXE4S3NKRi9ZVmR3SEtrcHlY?=
 =?utf-8?B?RUFkMXNOdnVwT3hnZC9ZTXJyVlRGQkU3V2RIcGRKMXIyVWg5OVhiR1BxK2NC?=
 =?utf-8?B?THJDdllCRE81WmVhMTVkZGNBQk5QU0dvTjFvU2F1VU1WOE1iM1hKblhGZkJk?=
 =?utf-8?B?YlJSVHQ1YTVvM29KMk5CWk5GTEhRbmdvYVo5UjIzY0hJcFRCVEkzTXZOdmJp?=
 =?utf-8?B?UHo0V2pPNURjWG5vbnl0U05SU2EzUzdqeklXZ3NUTm43Q1Y1L0VzaGMxSjJI?=
 =?utf-8?B?UWQ2bk1nZDB5ek9jY1JlMTkzcVNlanNYRm1KNTMrM210ejBmKzc3UE5sTkNE?=
 =?utf-8?B?T1E5czNFc0QySGtZNFJuT1diaVo3ZUlxMENkRnZyUTNYTmhjdXQ2MytSL0tB?=
 =?utf-8?B?VVgydUU5SGFGSjc0KzQxblZHTG5wVUtTWFN5dmdhUTA0U09QYnRmcnlaWjlE?=
 =?utf-8?B?VlBPcC9CZlZDeXZLaTc2WC81ZWxvOVVlT0pxTTU1UDJsOFlNdXA0ZkFWZzc1?=
 =?utf-8?B?TkYrZ093SW5SNzUwUkZqd1JyZ0Q3ZkZxK0l0dElJY2JkQUl2TGgwcVZCSWFJ?=
 =?utf-8?B?dG1VQTQwUk9rK2tmUSt5Skhva3R4OWhERVVpR2RVc2pVVFh5dlJqQ21mTGNC?=
 =?utf-8?B?cms5c3p4SkdOQlRaSVJQTTZXNWdnZXRta1IyY1dsUnNFQThRZ0k2bm4wYTRC?=
 =?utf-8?B?Sm1hTytDT1ZWRDRMYzFqbGVxSUt5dzV4WHVCUWtUa2syVWc4QkgvZ3U1VEx4?=
 =?utf-8?B?V2JubGNyWXVNb01mcTNodldHOU1JUzJ4M2JSZ01hQmRjdDhWK05FdWFtTVhN?=
 =?utf-8?B?WFVzR2ptb05LS2NjRXZMK1NaWERXbFhDNzNmV0JZRk5MZnBUWWpibDBkdnUx?=
 =?utf-8?B?YlRoSW5rbFVqSUNZSUtQTk1WZ3F2U0xwemVrTlhIQVZGU3A0eWZtR1JnSmcy?=
 =?utf-8?B?cDgxMUNRRWJXczZYSURqcTBqVWFhWFlQaytRcmROczc4TjJlc0Z5b2sxUFFF?=
 =?utf-8?B?bFhCS1cvOFptWklEbUFyK2t3N1h3cHV6L2FUWGZWVE93V1phMXBkNEo3ZlR2?=
 =?utf-8?B?a005cDBQYVlmNXg0RGRoQzl3VjI1RUQwajh1UDhVaWlzZXJnZXJxWk9MbEtH?=
 =?utf-8?B?ZWl1dk1mWmY2dTRXWjBod1FzSVc2ZVY3VGVHR2JxY3EyOVA4ckhDc3RnenFU?=
 =?utf-8?B?S3l1M1hDb1JIbGtyRjFXU1ZJUStXd2VoajNtMElLbFlBOVd3Z3RncTJJMC93?=
 =?utf-8?B?ejg1dnNWUWdBZ0pJYXFQTFhhWkNrbWRTdWZOWWVnZElKWXZ3OEZzQ29HY0Yw?=
 =?utf-8?B?YlYxd1BlYlRPaDg2em1jeVhkUDh2b1pSNm1hSm5wSlArQjdpTkJ5dzBOYUN1?=
 =?utf-8?B?Q3dxZ21zamFITnViM21NU1ZaOTRQWHFGM2hURjN3amNwcWZTVGRiaGR2NUZ0?=
 =?utf-8?B?U3ByTTh3cEVNZEI5K3hDb1pFWDFWSXhCWFN0bmdtT01veDdublNSMVFiV0o5?=
 =?utf-8?B?OEZ2NG9SVHpaZm8vcjhPMThjYWhxOEFFeURJQVRicFJna3lzUERvbi8xbWdH?=
 =?utf-8?B?WmZmUjdPWHhBWXJVWWdWYXhicnp4aFZQU21LMmZYckRFbWVaQ0JxNW9CNkZy?=
 =?utf-8?B?NEROLzF1ajlaV0tjVWRJNEpINjhId05EYUtyMGtzbnkwV0tMRlRTYTNFWkov?=
 =?utf-8?B?Nnl4Ty9yWDNyeDhoZTBNWThoOFQ1UG5TaFNKN2dEL0NQY00zQ2lzbzN1RlQw?=
 =?utf-8?B?blQrTWxxMXM0KzdwbVJxUHhOYnJEc3BGU1pER0lya2lGcW9iTTZKMDJuYXNu?=
 =?utf-8?B?ZUhHYzlNSzlHUmVxM3NqbzloMFprSGtGYk4zb204Wlc5UVdma3VkRVYwZUpq?=
 =?utf-8?B?M1A5bUNwQnRqOUtVTEUrVVRaNGVqNUVOdUNCMmlEYUgwdTVGWnc0U2gvU0M2?=
 =?utf-8?B?dFRybW1iSlE0c3NEZ1d3Wko4TVd1NXdNN3NWYjBHTmRRVzJkT2pTNFFFVjlN?=
 =?utf-8?B?YytSTWR6Z1JveUdtajNoTmYyYmoxaVdma2g0RG96cVhoaFpNRERqakRVSHly?=
 =?utf-8?Q?Rt6k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676827fa-6ac1-447c-4fac-08dcaab8e37b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 01:43:44.8109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fcXpDbeNq8BXk1OZs+vKhvNLwRsoOgg6Ri5n8dGIe6ifQKbPhHYTphsSFH+UVAd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427

--c00737704e38f4c2189763a41c3b03984f69e7aeb2511c47c7b45142ab8c
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Jul 22, 2024 at 9:16 PM EDT, Huang, Ying wrote:
> Zi Yan <ziy@nvidia.com> writes:
>
> > On 22 Jul 2024, at 10:01, Zi Yan wrote:
> >
> >> On 21 Jul 2024, at 21:47, Huang, Ying wrote:
> >>
> >>> Zi Yan <ziy@nvidia.com> writes:
> >>>
> >>>> On 18 Jul 2024, at 4:36, Huang, Ying wrote:
> >>>>
> >>>>> Zi Yan <zi.yan@sent.com> writes:
> >>>>>
> >>>>>> From: Zi Yan <ziy@nvidia.com>
> >>>>>>
> >>>>>> do_numa_page() and do_huge_pmd_numa_page() share a lot of common c=
ode. To
> >>>>>> reduce redundancy, move common code to numa_migrate_prep() and ren=
ame
> >>>>>> the function to numa_migrate_check() to reflect its functionality.
> >>>>>>
> >>>>>> There is some code difference between do_numa_page() and
> >>>>>> do_huge_pmd_numa_page() before the code move:
> >>>>>>
> >>>>>> 1. do_huge_pmd_numa_page() did not check shared folios to set TNF_=
SHARED.
> >>>>>> 2. do_huge_pmd_numa_page() did not check and skip zone device foli=
os.
> >>>>>>
> >>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >>>>>> ---
> >>>>>>  mm/huge_memory.c | 28 ++++++-----------
> >>>>>>  mm/internal.h    |  5 +--
> >>>>>>  mm/memory.c      | 81 +++++++++++++++++++++++--------------------=
-----
> >>>>>>  3 files changed, 52 insertions(+), 62 deletions(-)
> >>>>>>
> >>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>>>> index 8c11d6da4b36..66d67d13e0dc 100644
> >>>>>> --- a/mm/huge_memory.c
> >>>>>> +++ b/mm/huge_memory.c
> >>>>>> @@ -1670,10 +1670,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm=
_fault *vmf)
> >>>>>>  	pmd_t pmd;
> >>>>>>  	struct folio *folio;
> >>>>>>  	unsigned long haddr =3D vmf->address & HPAGE_PMD_MASK;
> >>>>>> -	int nid =3D NUMA_NO_NODE;
> >>>>>> -	int target_nid, last_cpupid =3D (-1 & LAST_CPUPID_MASK);
> >>>>>> +	int target_nid =3D NUMA_NO_NODE;
> >>>>>> +	int last_cpupid =3D (-1 & LAST_CPUPID_MASK);
> >>>>>>  	bool writable =3D false;
> >>>>>> -	int flags =3D 0;
> >>>>>> +	int flags =3D 0, nr_pages;
> >>>>>>
> >>>>>>  	vmf->ptl =3D pmd_lock(vma->vm_mm, vmf->pmd);
> >>>>>>  	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
> >>>>>> @@ -1693,21 +1693,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm=
_fault *vmf)
> >>>>>>  		writable =3D true;
> >>>>>>
> >>>>>>  	folio =3D vm_normal_folio_pmd(vma, haddr, pmd);
> >>>>>> -	if (!folio)
> >>>>>> +	if (!folio || folio_is_zone_device(folio))
> >>>>>
> >>>>> This change appears unrelated.  Can we put it in a separate patch?
> >>>>>
> >>>>> IIUC, this isn't necessary even in do_numa_page()?  Because in
> >>>>> change_pte_range(), folio_is_zone_device() has been checked already=
.
> >>>>> But It doesn't hurt too.
> >>>>>
> >>>>>>  		goto out_map;
> >>>>>>
> >>>>>> -	/* See similar comment in do_numa_page for explanation */
> >>>>>> -	if (!writable)
> >>>>>> -		flags |=3D TNF_NO_GROUP;
> >>>>>> +	nr_pages =3D folio_nr_pages(folio);
> >>>>>>
> >>>>>> -	nid =3D folio_nid(folio);
> >>>>>> -	/*
> >>>>>> -	 * For memory tiering mode, cpupid of slow memory page is used
> >>>>>> -	 * to record page access time.  So use default value.
> >>>>>> -	 */
> >>>>>> -	if (folio_has_cpupid(folio))
> >>>>>> -		last_cpupid =3D folio_last_cpupid(folio);
> >>>>>> -	target_nid =3D numa_migrate_prep(folio, vmf, haddr, nid, &flags)=
;
> >>>>>> +	target_nid =3D numa_migrate_check(folio, vmf, haddr, writable,
> >>>>>> +			&flags, &last_cpupid);
> >>>>>>  	if (target_nid =3D=3D NUMA_NO_NODE)
> >>>>>>  		goto out_map;
> >>>>>>  	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
> >>>>>> @@ -1720,8 +1712,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_f=
ault *vmf)
> >>>>>>
> >>>>>>  	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
> >>>>>>  		flags |=3D TNF_MIGRATED;
> >>>>>> -		nid =3D target_nid;
> >>>>>>  	} else {
> >>>>>> +		target_nid =3D NUMA_NO_NODE;
> >>>>>>  		flags |=3D TNF_MIGRATE_FAIL;
> >>>>>>  		vmf->ptl =3D pmd_lock(vma->vm_mm, vmf->pmd);
> >>>>>>  		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
> >>>>>> @@ -1732,8 +1724,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_f=
ault *vmf)
> >>>>>>  	}
> >>>>>>
> >>>>>>  out:
> >>>>>> -	if (nid !=3D NUMA_NO_NODE)
> >>>>>> -		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
> >>>>>> +	if (target_nid !=3D NUMA_NO_NODE)
> >>>>>> +		task_numa_fault(last_cpupid, target_nid, nr_pages, flags);
> >>>>>
> >>>>> This appears a behavior change.  IIUC, there are 2 possible issues.
> >>>>>
> >>>>> 1) if migrate_misplaced_folio() fails, folio_nid() should be used a=
s
> >>>>> nid.  "target_nid" as variable name here is confusing, because
> >>>>> folio_nid() is needed in fact.
> >>>>>
> >>>>> 2) if !pmd_same(), task_numa_fault() should be skipped.  The origin=
al
> >>>>> code is buggy.
> >>>>>
> >>>>> Similar issues for do_numa_page().
> >>>>>
> >>>>> If my understanding were correct, we should implement a separate pa=
tch
> >>>>> to fix 2) above.  And that may need to be backported.
> >>>>
> >>>> Hmm, the original code seems OK after I checked the implementation.
> >>>> There are two possible !pte_same()/!pmd_same() locations:
> >>>> 1) at the beginning of do_numa_page() and do_huge_pmd_numa_page() an=
d the faulted
> >>>> PTE/PMD changed before the folio can be checked, task_numa_fault() s=
hould not be
> >>>> called.
> >>>
> >>> Yes.
> >>>
> >>>> 2) when migrate_misplaced_folio() failed and the PTE/PMD changed, bu=
t the folio
> >>>> has been determined and checked. task_numa_fault() should be called =
even if
> >>>> !pte_same()/!pmd_same(),
> >>>
> >>> IIUC, if !pte_same()/!pmd_same(), the fault has been processed on
> >>> another CPU.  For example, do_numa_page()/do_huge_pmd_numa_page() has
> >>> been called on another CPU and task_numa_fault() has been called for =
the
> >>> PTE/PMD already.
> >>
> >> Hmm, this behavior at least dates back to 2015 at
> >> commit 074c238177a7 ("mm: numa: slow PTE scan rate if migration failur=
es occur=E2=80=9D).
> >> So cc Mel.
> >>
> >> The code is https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/l=
inux.git/tree/mm/memory.c?id=3D074c238177a75f5e79af3b2cb6a84e54823ef950#n31=
02. I have not checked older
> >> commits.
> >>
> >> I wonder how far we should trace back.
> >
> > OK, I find the commit where task_numa_fault policy settled:
> > 8191acbd30c7 ("mm: numa: Sanitize task_numa_fault() callsites=E2=80=9D)=
.
> >
> > It says:
> > =E2=80=9CSo modify all three sites to always account; we did after all =
receive
> > the fault; and always account to where the page is after migration,
> > regardless of success.=E2=80=9C, where the three call sites were:
> > do_huge_pmd_numa_page(), do_numa_page(), and do_pmd_numa_page().
> >
> > The current code still follows what the commit log does.
>
> Per my understanding, the issue is introduced in commit b99a342d4f11
> ("NUMA balancing: reduce TLB flush via delaying mapping on hint page
> fault").  Before that, the PTE is restored before migration, so
> task_numa_fault() should be called for migration failure too.  After
> that, the PTE is restored after migration failure, if the PTE has been
> changed by someone else, someone else should have called
> task_numa_fault() if necessary, we shouldn't call it again.

You are right. Will fix the issue. Thank you for the explanation.

--=20
Best Regards,
Yan, Zi


--c00737704e38f4c2189763a41c3b03984f69e7aeb2511c47c7b45142ab8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAABCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmafCtAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUlfQQAKY5MQlRyUgyaxk9jGzOu9dLY6Mv5Csoc8yV
XVPeF0IMgLk2N23zx/aBQYYyso9Ia7e/HFrPHBzvhA/7yMuedipsDoKj5vmvXFmZ
TRI8pl8zaDcMtQzS4ydYI4P0WV6jGdTOaNtPIl8QblYY7kisABeJ2hFKQ5Lf/5Dn
l8l/WkPvuJoj16W8TAMUvkDdn3ZrEEG3DRodMvOKkf8jJjSYjG0zUbPdRWP7USn0
QvO3SFTP+c3Lrt4L0VGE5IBMJ9UW9Uzx5pO1m5ITLTTmf/IY6JPp7lBs+2IKbdUF
9R9YesmCMi+JIHkJJ9cprogFPOA6/XIQoNExJSorqeZNr9w9qj1AlrcEvu7x+0ZP
rIn1b6ZC9QMOWforvyUbklFLcmLgavTf5QbN6xPXVFZE/JmmXhEYPDMO2SkAmZo5
pphaaKuFhFCVHl+pEZ4KLeZ2RiMC6bnBZdtxm/peZSHPIYDWjyrFQUiCLvmqhrma
/QajuLgOgN2FjcB/mSX/DxRFo/7SVfFeKfqOccWprFj8oIsHZx3WBHIvDAHMU6Vo
4QkkxAv4wt08RJl60f6J+vARONa1ErryNlq2eENbc1JWXgDVDlSzT8jJ/hby9Oqx
V8T2xtR7ajOYO1Fm7ToGATO/nUFp2oGj0f8nrT7x1C87tFlih3lK7PWyFPbbhjkU
J/K4FRcH
=Dgxw
-----END PGP SIGNATURE-----

--c00737704e38f4c2189763a41c3b03984f69e7aeb2511c47c7b45142ab8c--

