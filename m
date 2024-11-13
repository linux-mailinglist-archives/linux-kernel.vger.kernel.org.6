Return-Path: <linux-kernel+bounces-407915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ABB9C7768
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0593C281715
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB6A204020;
	Wed, 13 Nov 2024 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WD3RYfGI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B5PZTAeS"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1BE1632CD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511909; cv=fail; b=VAKIqK7LL8FuD7coGr/j9lKTHeDoUJv64Sva0BLM2rWa4Nep284MGeAzTXaHnbDQUy9GeaoZez4LyjnuYx9FCxFO0WKsIXfYnyce3zZixnPyaiMPJnunXRkGdMWFkh+a0ULZYH88KSV/1yvZhgw8X89cjCHiQeyQKitBkYHWnSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511909; c=relaxed/simple;
	bh=Du/ZV5BVFa0MzZaDaSfQE7P5J+1rXVF08sMpUtn7g7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JpWho80n1+rlb+c5QUrD/Q6Q2y780ZubtSz1fntU0eMuGjSMcBykawcbKNBYfBtfvN0vTlHPrJxQ3BNHhawPcdiNLe6V3ogNW2+YPmRc6ILNIGWVpK8p9t2KWAxkUzI1m8v6EJgzlmRILimGVvOOP2ovCwkZ2Oies+0UBeW6do8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WD3RYfGI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B5PZTAeS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDXXL8010688;
	Wed, 13 Nov 2024 15:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Bzoabl8JTRFnCARjJkIYhFqG73UitPWWOTZz14mevlw=; b=
	WD3RYfGIi92zRJVny7XRmWnLSukSGEARWkyvMdJs+79PxVXJ5qyt8CojQ/4NR9JZ
	FxMsT0yoOvs9yQBBfJ1UCsiZltpsfUe6Ne09aArfD6W7DZ4x6Kx2Y0tsITOV/7se
	Q06GwySb43CoUIMdqfp+RrbH8f21hUizE1gAT7H8dIRyduCWKfG9ozHrgWh9K9FV
	eoqaXBKM3vFkOT2uRrnP48eLn0SR+TorMw/YY4RifDl+qL1GAUJPZMtv5N4buRbo
	+zk9s3HiZdrcVi6hcWk+J61dCjkR2rx2MksEAEw3Nutr28QDw8MsJ41l85MLpZ+3
	5CjhKHvCVOaiCpqp3fYbWQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5f0rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 15:29:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADFFOKs025896;
	Wed, 13 Nov 2024 15:29:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx69fjnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 15:29:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0OmBMMfVhhWvgacNG8nCepBb1AmQ+Za8VoDt1SaKVC3JKZAkzXSRdc+Qfo4Lv+DVy4eHA+UYPb4ZYycjbyKsAHDdHmDONeyUYuhthD2zH5n2kPkXp39bomSkzWRA2KULzahlihkN25K98V3vggxYdMgP/P803/kdWl9HxIdXUdIRbOgvPVbff/48dAovdQ0WxIOymGez2qJioaZ2NSwJCxuXa2q/SwnePU1XAFvzYADm081TOJu8xKda3jW89ubSfX0hRCcHjMGyaL3NZHQ3eiB+GGYn/O+YYUSwtomJvRxycE9/KcSvUO0CZFArFoPxHiLLYS4DVQg6SXxJ2ZDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bzoabl8JTRFnCARjJkIYhFqG73UitPWWOTZz14mevlw=;
 b=BZPiSnOh0T5AymyIVIvEusl/c1gJuv8wbaKtTEh+xQSnpqhVBqMEPsEXs2PHLnw/aAjY1KG1M0KYsN0DpggxkKdMSNBPBc36E2xz2Ml8050eFiQWRFtKCSEawcQMw/XE722sOUlEGAUsmEYfxSOoNVQ7t9KsD/GoLTar0ft+q92p/+xz/pGKB8dqGrfFhEFhBS5vebykwS1hS7u2cEOaNGIJ2Gqn9t63bv5Ouwgq3BUQgtpfYv731aMswC1y7xcuSj6ePRkbse/llrTRpfvOaC2KztDw1sHAtSy5jUM4hYORQoEDXCUcboenCYWpFxvnp945wJeDo8jHZtm5q2u9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bzoabl8JTRFnCARjJkIYhFqG73UitPWWOTZz14mevlw=;
 b=B5PZTAeSsANjmMeyqqRYIuG/C4eOlwacu6jwSOfU3Twu/nVu3HuYOdVARPm2eX6y6ha58Z86p4WLnuIZxTOgNAtIlsaBmJI36ojxg2xWSh7sCMHVdCx4t8CZ+Pxz2rD2JTISl3hKCppw9heBz22S8Tm9CNyM4znUrmlho+xgH9Q=
Received: from MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15)
 by PH7PR10MB6481.namprd10.prod.outlook.com (2603:10b6:510:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 15:29:45 +0000
Received: from MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9]) by MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9%7]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 15:29:45 +0000
Date: Wed, 13 Nov 2024 10:29:41 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, mhocko@suse.com,
        hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com,
        mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
        oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
        brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
        hughd@google.com, minchan@google.com, jannh@google.com,
        shakeel.butt@linux.dev, souravpanda@google.com,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
Message-ID: <aa4i3inhnkyi6yazttb55khbm7swt7xq2sklmhp5y63kxw7bsc@i4wlyyzoo7h3>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, oleg@redhat.com, 
	dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, 
	hdanton@sina.com, hughd@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20241112194635.444146-1-surenb@google.com>
 <20241112194635.444146-5-surenb@google.com>
 <54b8d0b9-a1c7-4c1b-a588-2e5308a977fb@suse.cz>
 <sdfh56itaffzhpk4rft2tsjm7r44auhjomfthzgxzrmj5632eq@noi2uhgp3a3h>
 <ZzSwM5qwStadOZvv@casper.infradead.org>
 <k26pa6fhn2j6bgfwtcdp6u5vk25mkclitzvqqeqvji77k4lqop@yowwrqusmdyp>
 <CAJuCfpHjuMWCzeONq2YOOkr1JGH=E=xn=BAcjQyo_=P1cz=crA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJuCfpHjuMWCzeONq2YOOkr1JGH=E=xn=BAcjQyo_=P1cz=crA@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0354.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::14) To MW5PR10MB5764.namprd10.prod.outlook.com
 (2603:10b6:303:190::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5764:EE_|PH7PR10MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab62656-140f-4191-5688-08dd03f800b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|4022899009|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjBPQ2NLY2I2YWlsVGgrdDEyZGZTVThRaVJRWmV6ajBVbEJKSXdzaUtsZGNy?=
 =?utf-8?B?K1AyOStUQ3lpTmhvQ0tSalpsenZSZGtJT1N1eGN4VVVRUnl4elVEWTBmbURw?=
 =?utf-8?B?N0RMcTVhT2o2OTRhcFMzc0tUYUVicFFjWm0zZUUyTVZMTHZRd2VZY1ZsTkly?=
 =?utf-8?B?WDkxNG10RHFhTXJuYitEenNJVzRtT0pXVTRMZjlvWUVtM2plNm05cGo1QXF0?=
 =?utf-8?B?UHdxL3ZuK29NVUdyUmlnbTc1Nmk2YW0zdVp6d1J5azlwNlptbmlMai9RWDEw?=
 =?utf-8?B?VWZwZE9mQ0dpQzduTkRRMnBaQ1pyeW53YmVDMHlPWlZTOTErdU94WVRWSHpW?=
 =?utf-8?B?MkJnQURQZzFjZExzOFRFUmNpTTVXL2lvcDhQazdVNkpDK0FmVkpCQkxxTG5Y?=
 =?utf-8?B?WXlJbXNKWG9tQ1V4TDBJSm9JVXJjd3hiMENKeEZJcDdwRlhkMHlrcXZ5dFlF?=
 =?utf-8?B?VE9UZUNpM2I4VDdScHJQallqMkR5eWt2U3hyMDdrOE1lZlRkMFp0Uk5oeW8w?=
 =?utf-8?B?TWtpMVhmbU1NMmlSZXdPM2d3M2NLcFRQZXVlelBmbmRybHNMRmY0cjkxQm1r?=
 =?utf-8?B?Sm1xcWhMZWFRSURuVEQ2b1dGT1JtTUdGcmNqcTNiMUZsd3kzQmZyR3UvMmFh?=
 =?utf-8?B?bUIyRE5hOEozbFVSZTlZemFOZnlKcXlJVk9tZ1R1d0RuOWJhWXBYRWxJQ05M?=
 =?utf-8?B?cjUvZ2FDR3dPRnlIREd5V0FXUjRHN05PWFVOV2VFd2Q0UkFjTkNmeFpzYmhO?=
 =?utf-8?B?U1BGeUlkMGtSQ0pMSHpoSHYydG12WXVTNzNTNzVyMzIzYXhvZWk0d2JtZ1pq?=
 =?utf-8?B?QnNZdWlHcEN4aUw1UzlZRGIzRHBOdnNveGVJN2R3Ym9wVlMvSGg2MFVyUi9E?=
 =?utf-8?B?ajJOTXgzMThiVERPOENGMEkwZTJlZllneU52MW1zYnZLTmJSM2tsTSswYmNt?=
 =?utf-8?B?QW56bllsWm1heUV2Ujh0ZVhqRUI1bWsyc3BtUmtVWWV0NGJ3ZDVHNUFwQ3dh?=
 =?utf-8?B?OWtyKzkxNVBNZWtuNEI4M0pEbUkyNkVIWkJhejVlcThmaDZyMlFZWFFqS1pt?=
 =?utf-8?B?bGtqR01tR2FyRjNrL1JDeEpvamJEU1hTOWhIYVRJZ3doM2s4azNuNGtJR1Qx?=
 =?utf-8?B?TGJLRDUwZGZ4MmdUSG9rL25BaVZndURPSHpQRE9WUFpNRzIwU1pDSkg3bytz?=
 =?utf-8?B?d0o4a1hza0N2bFFYZWZ5YnlGb3RFdjJWRUc0Vldpd0p5NGphS2YzbzZkYzZp?=
 =?utf-8?B?cXV1VVVWN0FzMjVkeGVxSmoyVG9yMkd1S01laHNtTGF0MVJmTnZ0NWwvaXQw?=
 =?utf-8?B?Z2NFOEx3ZklXT3NjK3psRjhyQ0c0d0ljVktjYmVJSjBMbStscXBkNDNFZVVE?=
 =?utf-8?B?M1B1dW5MdHZJSWxFZGdnUEhzTlBIMm0xbzBYbFlXU1d5cm5MT1lseUxydlVz?=
 =?utf-8?B?MnVTWERJaWNPNlY1Zzl1NXVRNFJEQmplSXgwLzlSallxa0pEeTRiYXRqQVBh?=
 =?utf-8?B?b0piWU1XeVU1Z1FEdWNrMW4wTjhLT0VrS2VLK25FdEpWc0xYT3pUbGlSV3hw?=
 =?utf-8?B?T1JGeHRRMms2THVwRW9veTJVdjVTYTdRdkJqdGdna2JUMERKanpaMHlGQTdw?=
 =?utf-8?B?elgraEhGN3l4QXJRa2VnblBkSG5ob1NaTUhVVVhpV1VEbFh3eWNESDhDbk9P?=
 =?utf-8?B?Q2xhWDlKejdFN053Tkx1VnhpcFRtOVhFdUZPV1VlVldCM1dJSEVnUk9FMlds?=
 =?utf-8?Q?OUp2lSZ9480UWPF1RWFY9i+/fO8uur9VYZYexRD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5764.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azBidlBENk1wTFhpU2ZaUVpETXJqbnBWZ0Y4dUlOZ21ZZXRuQ3pkRExwRk9x?=
 =?utf-8?B?bkw4STlLQTJIbmJobUpTTVdlRkM0SFFnbElVNVV2cUJLZlVoZ2djV25sMGVS?=
 =?utf-8?B?eWNFWjNUbHlvUGhKQk1pb0Y0eFlwWWx1M0dXWGpQL1kxOG5wcGgza2oveXJI?=
 =?utf-8?B?T0t1MmgxZ0g4KzVybS9uckRXdUZzYmswL2h5dEpYbzgwNmVGenpUNkpoTVMx?=
 =?utf-8?B?dTU2MFo0K09RZHRlZlk3YXc2clpvL2t4d1o5TG9NOUk4NGtERnphTnlBR1Rv?=
 =?utf-8?B?WXZTNDRqY1NTRlpuSmZjN0kvNnV6VHNUNjNhU1hiUkRpdURSeWRzT1JRazRa?=
 =?utf-8?B?Nk1DdStiU0t4TEVsdTJoekJ6S09USWdNbkxvM2hJUUFJQTdJSzV4ekFwZGZv?=
 =?utf-8?B?dkYrdTYyaDIwcWhXaEM2YzVLMWVPcEVzZXkzK2FCd0NJYThrc25XS1Vwakl1?=
 =?utf-8?B?RHJVTGlLWU80WHgweXhiSndCR0lieFB6YjVsWFdKbk1tdGR0YXlpZjRsREFw?=
 =?utf-8?B?WVpxVWdmNlpOZzNQSXAxeHdmdVdnWnhKNlNrMWFOSTVMQ0gyYWNpVXRORFdI?=
 =?utf-8?B?YzRwVUtXSThhc1FBdGFwb3JVVDcyNFlKdlNscFc5dVNuVUFRR1ErTXN5dlAx?=
 =?utf-8?B?TEVDbzlKci9Wa1BuVTI5WXNqRFhFc1plcU8yOGZtVVN1V2ZDYi9ZV2NzMTF6?=
 =?utf-8?B?TzhjMU9rRnJ6NEw5Zmk1YVNVNVlITktzYzRwV2hSamh4K2E5bFZsdkk3c2F3?=
 =?utf-8?B?ZWpoSE5EbFdZRlB2TlNTQTlzcUFlTHNWeHdwL3REcWtEdlVxMGRoMXZGbk8z?=
 =?utf-8?B?SjRINmV6Z0JnUGRBTEs4Z3pYQmh4Qmx1VnF4YkNJaE4wVUJlVUtHUVlzOVRv?=
 =?utf-8?B?Z0ZOVmxwOVQ1QXpPajd6bHNxT2hscVpYZTVDTk1Nbm1hTFNsVHZ3V0Zqbm9h?=
 =?utf-8?B?Rjk5S1BKY09yVEh6M1NNME9tTzA1YkJ2NFJ1c0NYeE5kd0JTU3hDTFFiUUI1?=
 =?utf-8?B?ZTZ0WVRlMW1qU3hVeE5pMEJrcjFLUXhEQmpmdlo5WG1oRnI1Q0tuWVlUZ1M1?=
 =?utf-8?B?bENlSThkaCt6aUhiK29nRERwUlppWFAzNVJpOWdueFFtQi8xRW5iZm91cU5x?=
 =?utf-8?B?ZnZPNFY3U0pzd0lLRW5DcEVyZXErREpjcE5Fck1Ia01Fci94bC9PQ29HSmZL?=
 =?utf-8?B?bVo2MVNGc3RCMnM3dHc5TEVqdjhxUU13aUdCQ1djc21sVUVKTnRINTk2c0NO?=
 =?utf-8?B?Nzk5bGhlQ2xQZjgrVEpVYjdNRjJsSFYycGN0V0dudW40WExnaHJiNXFQem0z?=
 =?utf-8?B?dUlPbkQzK29TbXkraXQweGtZR0dLMm5YU2VyU211VW4welNuRWpLTjdKbTlt?=
 =?utf-8?B?emwxRStEOER3WDRwOEsxcllQZlQ2VEx6d2ErcGxIQmc0dGdZdldwUEtDekFI?=
 =?utf-8?B?UkwzQmFOTE91S2tKSW1GZlE0N3JETTJWTFdyRFFiendxN3hQK0lVU1NNVi81?=
 =?utf-8?B?RGRrbm42c1VtZjFLNXBjQ1ArdWNmUk9IMzByWHlRZUovRWovaTBleDZ6bUg3?=
 =?utf-8?B?NkMwWmlzZkRJUzZ0QWlqU0phWVljcElyV3N6cVNOQTlIcmRlaVRzL1hwUjR2?=
 =?utf-8?B?RUtCVkFqYWZXSEd5Q295TzBJSURmaXY5S0xPZHUzS2FiNTFUNGxjMFI5Ynl0?=
 =?utf-8?B?SklueUxwYWZxTUdXWjBBbHpxNzZHV2Q0V1ZEbGlRWGZmTGNGNVExVG9zdEFm?=
 =?utf-8?B?dTdFc0lhdTZhSzBZcGhTcWpndjlSSG53Ujg4ZW1CNTlBOGQ4R3pCVzFOdGQ3?=
 =?utf-8?B?bW9PUm02UHl3UnYyWmZkUEZQT1V5OEdYY0pkWHBKV2xpaGtHaThMc0JkZUJq?=
 =?utf-8?B?OGZWNTNQNTdTVEJ4Z1E2ZGxTcjllODNZNXgxUzFBVTBzbXF1ZHdFVzB6NXRz?=
 =?utf-8?B?bHJLSnpyYmtaUVRJNmdxY3dpcFo1OWtyMlZidlRsdXZLRm1vSnhtOGU0ZmtB?=
 =?utf-8?B?T1ZOKzJGbDJmdktmRmpDcXhGNnQrblZKTXBDVFRVZ3F1cWh2TWRleXZVSmd3?=
 =?utf-8?B?bzIvZnZSSktBVE92ZGZ3b1hNY1RiamxnRHQ2TmpIKzFqbU9IY1I2blRtU3JZ?=
 =?utf-8?Q?ThbiMJGfzOj/eJ3rbBlJr+iMM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CYW+M9JEx4O8j8/R4N59pmTaMVOniqFpiPu2jYiw3wsVXI6WdR5jgHinTQkn8YkCc+C+mqOW7WTSsIJ0L9DnpzJBXkQ1QY1M03s1/Bli+kxGoeVp4b5USOE/12nLdzbUIE4h9hMSOxJOefS1NyltrccIrgBEcQ9YOGvvzjdaj0omgJfzd/byLp9eZlhaCYTioNIZPrH0s6wvj/1DJuIcJPQD0oH3GYjwCOyhXmSg3xPcdQsHnfeAYmqPhUUJ7VaDLQl+jPpAyK80mx1TVZ9rCYUkagj0dpWvaEbWsJeNLGA3wDQmyuiHp0S/rpWr5uNZrViP5CCPWlsJkb+2ZmUQrJCRFI+lJ8ZXW4U+T5JUsv+d9uCtixK6x5KpNnYTDBPlTCwCSPnCeu/UjqJTu+5HdpWfKqIc9gjG1mrBS5pSo6ZauhXZQzFkjgvWNN2os07nBh76Yz5FkYFUXo2qPVz8ZAaKS4yE/L+52OdByc3X019b3RCbbR13zt1sHk06TVfwGUiDbqPVWOrhtLW86bSaihFDTIVcE+6qSB4528XTQajh2ByT4Xh19vqziOvSImK95d1ksVUn3c2pmGE3VDl02qLMaerYD6/5KC/TwS9pelk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab62656-140f-4191-5688-08dd03f800b8
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5764.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 15:29:45.7320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQxRZrWbfsLpS8Ul9SsFvYSsOJMiTnT0wm6nkNrRw+s6VSvVXZKdxj9DiX+fgCnKNt6n7/sKGkotPmZ62XKkug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6481
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_08,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411130130
X-Proofpoint-ORIG-GUID: PrsKn7EptqGP2WgeZMH4WoELu4XHYSle
X-Proofpoint-GUID: PrsKn7EptqGP2WgeZMH4WoELu4XHYSle

* Suren Baghdasaryan <surenb@google.com> [241113 10:25]:
> On Wed, Nov 13, 2024 at 7:23=E2=80=AFAM 'Liam R. Howlett' via kernel-team
> <kernel-team@android.com> wrote:
> >
> > * Matthew Wilcox <willy@infradead.org> [241113 08:57]:
> > > On Wed, Nov 13, 2024 at 07:38:02AM -0500, Liam R. Howlett wrote:
> > > > > Hi, I was wondering if we actually need the detached flag. Couldn=
't
> > > > > "detached" simply mean vma->vm_mm =3D=3D NULL and we save 4 bytes=
? Do we ever
> > > > > need a vma that's detached but still has a mm pointer? I'd hope t=
he places
> > > > > that set detached to false have the mm pointer around so it's not=
 inconvenient.
> > > >
> > > > I think the gate vmas ruin this plan.
> > >
> > > But the gate VMAs aren't to be found in the VMA tree.  Used to be tha=
t
> > > was because the VMA tree was the injective RB tree and so VMAs could
> > > only be in one tree at a time.  We could change that now!
> >
> > \o/
> >
> > >
> > > Anyway, we could use (void *)1 instead of NULL to indicate a "detache=
d"
> > > VMA if we need to distinguish between a detached VMA and a gate VMA.
> >
> > I was thinking a pointer to itself vma->vm_mm =3D vma, then a check for
> > this, instead of null like we do today.
>=20
> The motivation for having a separate detached flag was that vma->vm_mm
> is used when read/write locking the vma, so it has to stay valid even
> when vma gets detached. Maybe we can be more cautious in
> vma_start_read()/vma_start_write() about it but I don't recall if
> those were the only places that was an issue.

We have the mm form the callers though, so it could be passed in?

>=20
> >
> > Either way, we should make it a function so it's easier to reuse for
> > whatever we need in the future, wdyt?
> >
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kernel-team+unsubscribe@android.com.
> >

