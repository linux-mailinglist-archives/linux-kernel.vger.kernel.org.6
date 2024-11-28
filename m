Return-Path: <linux-kernel+bounces-424982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 159B19DBC0F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9D7164391
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1C31C1AAA;
	Thu, 28 Nov 2024 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jYrJcU6A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hFEwqDnG"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFB513D893
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732817123; cv=fail; b=RklkZSvniR7t3lQMrSJXhNo2keLVJ5O+bfCphnAlquHFOJdl0Nwzt4xtO4j3wVxzuIW96gmZp+xhrMGiV3Ye4GSUbgoQcADM9dv+Q/EP3m5/wXEuozqjxH8zBmMbbbj1h+RdSBDaeHqMJ/IA5jkyfLpYc0rt1k+VpmqOxr+olao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732817123; c=relaxed/simple;
	bh=tKTgD390SEYnljxea/lNSLYM9f3tFgJQe5OETvrPE9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UpgHuW2DyYOo9QaKTBttZXjzEMDZP+bmu+ftV1SaH/oI++cFMB0VeHsr9nJpte5BRxYmqlzOCmtyFoDyGOh3Ps5kRGfmLELg5/aaspGPf0nfq9fXy1LT1dCuA2MWjD+7U5sYUdhKZaTJ6x+SxsV0NZn0/RiQkCwdUM3Frh+FsZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jYrJcU6A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hFEwqDnG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASDuwLo013608;
	Thu, 28 Nov 2024 18:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=tKTgD390SEYnljxea/lNSLYM9f3tFgJQe5OETvrPE9Y=; b=
	jYrJcU6Akx/LXvpCxZB2Y7bg/iW3pDk9xoGRREokw9vALMn+NOHTCxuVXuWlUY+D
	fkAm6zkwv/cg/xawhp8PHjKx1mtpA/po3gymwyFxsi3TRRMcCxtzr4zscu1e+G67
	ypsxqNEMNBj668lUh8o2YYF8bFZYPFMon1KfYtBW0cqAN5utePURrtOatCK1aHcy
	zXU6y8OUMcOpdxpEIMfM/P7cv5GZ441j+nxrrBlwFMe6VR5Iuzxs/qxw2fbyNZdg
	l/To2e8IfRLxO+OxI7nMUpG5eTHzZu2CtGWN60PrgyB4dXaMdtEiKvku6OtgJc7H
	FAUKvURPxf9DWb9WWh0/WA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xx27cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 18:05:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASHe4vX018044;
	Thu, 28 Nov 2024 18:05:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 436705vhgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 18:05:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwXmpm9Tt87Pf5mySmJkvoNWSSgiKsezvwZZHxDxeEk2Pu9+7FlWh1jTNfF9ZLLGrDn/7XuiPxsTUuaHDFYaZxULcUlknOJVjrpUPZoQw7R/6DtAHWmp87dsZLek8eEo08HNoJge3zXtcImdeVYOTQWdodUcS/UPSX+Q1cm4j9VBmf1QDlBX9Kr5k/VA8psBmDZC7xcK48HOMzI59nQhOvmHnruJPc/Vir0GbVNeymk7Q6ehMwBYWKQfaskjqCOn0feZ0IzwJy9h9ibPo4bP00+UIgcGUsGSFJqqNIQB8LRfD+Mj+Z2xgYX1Z69G5t6GGmM9u09YHHqecPZP5jR5pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKTgD390SEYnljxea/lNSLYM9f3tFgJQe5OETvrPE9Y=;
 b=HG1nVvvCNnviJC+Lm/QXF1TmsR8JA+OoZf5G7cV1d0mxTZnU3IQlzQ7Cei7xIpp4dkoxXyh7ZpuNHz/EIYZau6M+L1Ao5iH26aldrECoVCVrhzgN+TLqEgMa5dLzXiZ37FWziEBA7Y2COmclOM9IE6waOctRXSZdGpIXKov3cm/sW7/qx+jFov+CgOnLQ8wyFxuSmvG9qZcJHRltdPtPEV4RyxDIInzlhoikknBp1BBDbvHTHRnQZcmQBAzHzaEt4JCksXgUtTlNOYRqoAK5YhFSc3mtpEqZbnQlzauPJyJwYXCZKUxlTUERPMCn8ubbaxt/THPjlmMeFRX4Fit1Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKTgD390SEYnljxea/lNSLYM9f3tFgJQe5OETvrPE9Y=;
 b=hFEwqDnGYfMQtFpUK/aFIRMMkEkgJrMx7vY8QiKBGsVEf+tWfEhPRJCB67rFQVgPnia605GAUFqOrr+Ua9wqdVSfupXEGd8oxLeLSbMid68Na2KLBC4uZk+amlAwWz6FeLPNOzFlcnWrO/xAotfK+ASVIWnI2SLBlBaiseZalp0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA1PR10MB7699.namprd10.prod.outlook.com (2603:10b6:806:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 18:05:06 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 18:05:06 +0000
Date: Thu, 28 Nov 2024 18:05:02 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Julian Orth <ju.orth@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: reinstate ability to map write-sealed memfd
 mappings read-only
Message-ID: <8219cfd3-f488-492c-8d4c-26e9f0169e8e@lucifer.local>
References: <cover.1732804776.git.lorenzo.stoakes@oracle.com>
 <99fc35d2c62bd2e05571cf60d9f8b843c56069e0.1732804776.git.lorenzo.stoakes@oracle.com>
 <CAG48ez1OQWsaFGBs_EPz+9C=FwddyKG=r1PMbfDtwHNow2SYOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1OQWsaFGBs_EPz+9C=FwddyKG=r1PMbfDtwHNow2SYOA@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0215.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::22) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA1PR10MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b286a0-604b-4fcd-f97f-08dd0fd73029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3VQSmIvWnUwWitMUHQ4OEZLd1grSmtzYjY0c0VId2RaaE1zSnNhV1hCTVhV?=
 =?utf-8?B?MWZ2dzJaSGNaM01aL1FkZWlwRnFaV2dMb0xjelVKaE0va2ZPbHZ2Qm9yZTFR?=
 =?utf-8?B?ZENvQmUzWGRhR1UzOUduQ01KME9nc1N1L1kzWDlaTFdRZnVBdlRmazdqVFlI?=
 =?utf-8?B?QTJ6d3BHSzlaRUVPVE8zQjQxUkxOMFBZa1NEcE9HUGFEbnZVakVNbEJxSkVk?=
 =?utf-8?B?ZllQWVYzMURyWGVaYVdNNUdqaVBPNW1jaDB4MHdqWGk2VUNRY29ITzFYaXhM?=
 =?utf-8?B?c0lSTkhCTjFadHdvdGhZcHlGRFc2Y1lpcWlRNjR0N2JBeTlWLzlSd0RoYlhX?=
 =?utf-8?B?U2dRdXVnN1JHZHVOZDlIOEg1eElnQnlUOTNLd3JhRW41MFA1bWgzd3lmSzV0?=
 =?utf-8?B?dUtnaUJIUGdkUGlOWEVwbjBlVEZRM2pXQ2JNK3RSdWdCVTVWc05rU2dvUnVt?=
 =?utf-8?B?SmFwODFhV2o1Z0NtVE44Yjh0RTdJUFVuY1EvcGtwSVZ0bUhsSnZhK0N2ZWo4?=
 =?utf-8?B?UEM3RmpZc1FwMTY5YTVhWHZsMXJiVEFxU0N0RHVUV1NwVUU0QXhicGJZRWNz?=
 =?utf-8?B?anYrNmZEQ1g3Sy9ZK0ppVWphOTJmaWJhbFlEdURqcjVwbFB2a1FuMHZRV2FD?=
 =?utf-8?B?QnJmQmN1TGJsM0daS2t6V1JwaHVXQTZsamVpNmRnRk5ZQzNXMGxlQlVRVW43?=
 =?utf-8?B?SnZOekYzY2RNdXU0TENaK2lNYXpmcWlNWUdRNnJGazl4azMyd3NQRTNueklD?=
 =?utf-8?B?RGdGdG5BVVliR3NpVkk1eitnclhqNkpqM1lIdW9ZZVA5RnZRVVRCYjNUN3lj?=
 =?utf-8?B?ZzhpQzNENHVvRitzeUtNMEU3bHJQTDRXZXhuRUNDMXlqK0lyd29qUVBIejEx?=
 =?utf-8?B?ejhnOHVOZFBhalN6eDRMZUxXUitXODRsS3d3Z0dKVEF2MThEcmluNXVGK3h4?=
 =?utf-8?B?bitlK09JV3pHZGFQRmFmOU9Zb0xXMkFZVjI1cjJCQ09zN0cvOVFlYlJJK2pG?=
 =?utf-8?B?cXlJMHczYzQwRE9wMW15cW9rUHoxOW9wUjkzUEUyNGNBSkRDeW5CY0tKSHRa?=
 =?utf-8?B?Q0ZqMzk5MDh2TTRmaWdaRytQSHlvaUM0NVhkdDBOdXBTNUN3YmdiTHBOQi9N?=
 =?utf-8?B?aGE2SVBCUmEzREZPYU9YWGFScDB1TFJUb1dSZWRTTC9hRjBVTjRVU0RnM0NF?=
 =?utf-8?B?M3JQbUVOSVViMXlFVkRGY0FITTREU3BzR28yc0RsMWMvNG5TTDNXcHJpaDVy?=
 =?utf-8?B?bUpmdjFTSlFpSE52MnhQSmQ1b1ZlQ0RISHY2VUtFU1RQT3BZYlBTcTQ3cTg4?=
 =?utf-8?B?YjE3VExCMm10c0pDZ1F0U1I0V3lDMWYzRzVDbm84RThpSFUrUnlvek1TWk4z?=
 =?utf-8?B?ays1OGRaUVVXUWtGaDlrNG9iM1hkMm1CSE10MHBxdEQvbDVHY3NSVWROTWRE?=
 =?utf-8?B?bWZFamVnaXVSM3pVb2E5L1ptamtJUkJ1OVQ5NFRjWm4vekxyc1hUZGNvS2VP?=
 =?utf-8?B?cUhiQ1BwaUwxbHR0UHpXUmFtZ3FwcysxbUpZNHJCZ0hYV3lJQW9nMjFSTndD?=
 =?utf-8?B?NEZGcDJSMzFGR20vWGx0cGFWaTduaVJoMVB3bjZGd2EwYllGSlByd3VFQkJO?=
 =?utf-8?B?Vm1qM2lqVVNBZGhSMnB1NnROSmJMdTZZR0FRTWV3VjVvR25NM0dpSktRaXBt?=
 =?utf-8?B?NEJHR3JyMmRTVjhTdVVueEZXUU1JOStpa3lJbGhDYXNGQmwyUWVCNldURith?=
 =?utf-8?B?L1NCRWpjUFZvbFFQalMvQmZEZDE5QlFlTFpidFRkR3dHUG5zbXdEVk9sODk3?=
 =?utf-8?Q?KuRDJ6x6NFWnVWr3PUHwIQk1DZlvQgXu21/hI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ynh2Qk05MElhMEZ3QnhEYjJXSnE4ZzErMW03UG9LSVh2VkkycWNxR0dobzNC?=
 =?utf-8?B?c0Zwb1FaaTdaWUxOUTZlRG00b2JKVUhaVnlxenR3SnBza1psMEs4aDN1MVhI?=
 =?utf-8?B?QTVNeHFtc0lFZTZwTlJRa1JRbEVTclBxc2FWZzFqTzB2czNyRW1Ea0JZUkta?=
 =?utf-8?B?N2tZTkFoMkU3UWxxMWk4YnVaeUJXV3NBRUIrbE5MeUFLd0R4UlgxR09WcWdM?=
 =?utf-8?B?WE0rWkEzMTJqcjFyY3p6NEkrVnNjem1zTFBqcXpLZTR5emg3VWNHWExjKzZO?=
 =?utf-8?B?Skc3akN5b1ZURGtxZGZIOE5KTGlHZkY0OCtHSERMTlNyUzdGWkwwWTd2QnFo?=
 =?utf-8?B?NmVVTDJGOGp6MGNFeTVCYkVZVjdxa04yNDVnU2xrbTQzOExsdjBiRDdqOHlI?=
 =?utf-8?B?UE1zblk2U25NbHZrUDE1OUdIV3RrYUd6TG0vRmE2NkpTTjdXbGRwSDd6TThG?=
 =?utf-8?B?YUtUNDZ4VlJPeEViRHl5ejFOenBXOS9PcXh1azFTNnN2WHVBcTlzNVFBUldu?=
 =?utf-8?B?bHphYzR2VzlpblNZcDJVakloOGlYVlcwenB4Y1hYMXVBODdqUkxQYjg0NmRk?=
 =?utf-8?B?RllqcldnVUw4T3A4dHI0QWxveEdERkZDZzFnYjF6dHRLcHdPQlpvUlkrK2sy?=
 =?utf-8?B?TkwzcFIxU2I2TXRGMnJxS0VDanJTK2laRkdDMThsZ0NpRHJYTkJMVFJLTGEz?=
 =?utf-8?B?ajVkWG9vekp4QU85UWV1dE5QM3RFdjQ2czcycThNcFNPS0RQL1B5L09Mdy9u?=
 =?utf-8?B?ejBhLzBadE9nYVRmZE9nSmYyT0l2bmhVdWpUMHRkMFkzOFBBTkpCcEhWQWhn?=
 =?utf-8?B?ZkdiUjJGd283TUhMM2E2YzdpSHRLUEtJbTRpVm5vQ3ZjaURmVzVqaDNXV1BO?=
 =?utf-8?B?WkdjSEtXaW9yd09yby9TQ3V0L1hlWk54bnVZQzBNUWpiYWtaZG9qYXY5RUZr?=
 =?utf-8?B?L3FHZTRVQ0hwTWRINklLUi92SGUxd0pRL0xQdWlMRkQ4S3dHN1hCMTAyMlNQ?=
 =?utf-8?B?K0xVdktYbkZPRVBPWWlZWmZXU0ZubHVQeGlCRXVLRmtKNTMvTWY1MmRoa3RU?=
 =?utf-8?B?dkUrbllXT0piejE3c1lXakFxa3g5VnNucGVlRlZOZkwwUFkvTUpIa20yY3NU?=
 =?utf-8?B?M2pHazJXdHZrdkU0NXZXK1NUSDJ3bW1Qbm1nbmQ2dk1EMHJMajJSRWJjaEZC?=
 =?utf-8?B?TmdDbloxbG1aVTZkbFlrQzBMczdkdjV5ZGkvRFJmTU5jWFhrL3RMOWdyOGdu?=
 =?utf-8?B?dm1xWERoMy84Qk1oTTZOU0EySVpzOWR3cVVHZE5KNHV5dGpCeTEvS1dLd0Nl?=
 =?utf-8?B?R3ZoUHpjb2Z6OFFyTndWUmRDYjlJczlZRUxoa0FET21ZQ2h0ZjVmbkVCcmtJ?=
 =?utf-8?B?cGpMdUJIZmNQK3IzSUVFMkkrNGZBNThnU3JXRytEQlFNSC9pTHZ1NUdIVC9G?=
 =?utf-8?B?VXUrKzhFc0JBMHB6OG5FaDkwb01XQ3krc0oyUUZCaFpZOS9CRmhTUTFvSU1K?=
 =?utf-8?B?dVZ4MzNMT0RPY1BJbXF3Nk82Z1RDQkV2ZGlrdXdpams4UWx3d2xGa1FRZ0w1?=
 =?utf-8?B?bXNXcTdrNlpGdk1pWDZkUTRPenlXV3grYkIvRER3OTk0cGZEd3Q0ajlwTU02?=
 =?utf-8?B?RSthVTcva3FUSFZFbmZCcDNsZWZKQlBLWnk0bVFhTTkrcFAyTUpuTWQ0OVcw?=
 =?utf-8?B?Mk56TTUrcThrVU9ZMlJvSUZWQWZZbjY2dzhXTk1RVkgxZHZwaFZOVFQxTlUy?=
 =?utf-8?B?R2U4MnpSTzJ1Y0xFN1U0MXQwQ09BbVdnWXFvOFFJdjFhNmFrQUdvVzlWZC9n?=
 =?utf-8?B?MXdKT3cxK1JSZmRPMVV0R056eFlMMTFWWTFtY2ZGb3dpZ25FcTYwcUpJdmNv?=
 =?utf-8?B?d0VnUktZVDBOSXNnWnZwc3k2RUtpNXRQeVVHZFh3V3k4cDhXeG9GTXE1bXUy?=
 =?utf-8?B?QTVCVnJVdTVqVU9IV3VlcllqMEllQ09mejYzSGYrUnBVREJVTHJSWmpZS2FI?=
 =?utf-8?B?WHNyazNZNW9iVkFFYk9CSWVwUHk0TzFQclFpek5Va3BhQ2JXb2Mxc0dCQW0x?=
 =?utf-8?B?VVpvQVorOXRSb1U3OVR3VXJVV1drR25iUlo3TjBrR29yTVVFejhhL0Y5ZFlE?=
 =?utf-8?B?QXR6bmdhL1ptQi9YRjY2UExwVExYSDk2ZUViekdqU0xxS3hRSk5kWGlPQ3U0?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7msi5kKqjb/zLtT8dnj8dntL94+Ib6lLrI6JSgdiYOS+9Ltv2kqi/xKqB8si9KwmWWzjfmbZ4bLrlTFnCzwExqE98IDELM2gHAjgELm5sZn42iWm23UMu/37AScN76NceVLqsiKHuIXXuuGbO91erEiy5tgYuBpxJFKteuDKUa0UDC0I4Q0xd+qFoBT8aStmX8WwdPxtWQ+GG/sUSLYl1YfbqbWgso4oRNWPi4kGLtfgFrkdmM7z+MIJcWOLDSUQHvxFJgHm8qYsrJMh1Zr+Vlp3QiI/R5JxxvlLRlBlmk3zPe1hsXg43mRbFVTv92RLiBZLMQIRpAnFI6lRJDTUis5P9hDx3vZctb1wlN9irgsKlp8e//R811K+hs2sFC5LdjNwPuiTY/v0KmDscoZP0y7Y6VfABwkrI5gYaGRRQwGDXEVHqAeRSlZB7Gh/cP6Ofinr4qskm41VU3Qm2LBRh4vwIIsIhAhr6aCh1KVm+UvZUo1aVTwgtPQoxHe04DF6b8nHcGoKQsUFjxTcsTQuKvP+T7rIVLqStS8Lil8Z09ZEbnFpCiDCaK59ZbrRHm07ZN8EJkIeUGO+Rt+xsjmsTzA+PEKqKPHt6cfnngB/zCc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b286a0-604b-4fcd-f97f-08dd0fd73029
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 18:05:05.9399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQA3QEmkyZj2TTdCRk/KJYkGwMd8jt9cQPOgsTZlu6js442V1yzfUCVhGjcvSaoKViYO8I84ncYMvZSxp1NNtoD51/sstMZxrzN+EldAl/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-28_17,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411280143
X-Proofpoint-GUID: puSKL-vTKF3w5Rbo7kdXz5MSCRUS1buE
X-Proofpoint-ORIG-GUID: puSKL-vTKF3w5Rbo7kdXz5MSCRUS1buE

On Thu, Nov 28, 2024 at 06:45:46PM +0100, Jann Horn wrote:
> On Thu, Nov 28, 2024 at 4:06 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > In commit 158978945f31 ("mm: perform the mapping_map_writable() check after
> > call_mmap()") (and preceding changes in the same series) it became possible
> > to mmap() F_SEAL_WRITE sealed memfd mappings read-only.
> >
> > This was previously unnecessarily disallowed, despite the man page
> > documentation indicating that it would be, thereby limiting the usefulness
> > of F_SEAL_WRITE logic.
> >
> > We fixed this by adapting logic that existed for the F_SEAL_FUTURE_WRITE
> > seal (one which disallows future writes to the memfd) to also be used for
> > F_SEAL_WRITE.
> >
> > For background - the F_SEAL_FUTURE_WRITE seal clears VM_MAYWRITE for a
> > read-only mapping to disallow mprotect() from overriding the seal - an
> > operation performed by seal_check_write(), invoked from shmem_mmap(), the
> > f_op->mmap() hook used by shmem mappings.
> >
> > By extending this to F_SEAL_WRITE and critically - checking
> > mapping_map_writable() to determine if we may map the memfd AFTER we invoke
> > shmem_mmap() - the desired logic becomes possible. This is because
> > mapping_map_writable() explicitly checks for VM_MAYWRITE, which we will
> > have cleared.
> >
> > Commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
> > behaviour") unintentionally undid this logic by moving the
> > mapping_map_writable() check before the shmem_mmap() hook is invoked,
> > thereby regressing this change.
> >
> > We reinstate this functionality by moving the check out of shmem_mmap() and
> > instead performing it in do_mmap() at the point at which VMA flags are
> > being determined, which seems in any case to be a more appropriate place in
> > which to make this determination.
> >
> > In order to achieve this we rework memfd seal logic to allow us access to
> > this information using existing logic and eliminate the clearing of
> > VM_MAYWRITE from seal_check_write() which we are performing in do_mmap()
> > instead.
>
> If we already check is_readonly_sealed() and strip VM_MAYWRITE in
> do_mmap(), without holding any kind of lock or counter on the file
> yet, then this check is clearly racy somehow, right? I think we have a
> race where we intermittently reject shared-readonly mmap() calls?
>
> Like:
>
> process 1: calls mmap(PROT_READ, MAP_PRIVATE), checks is_readonly_sealed()
> process 2: adds a F_SEAL_WRITE seal
> process 1: enters mmap_region(), is_shared_maywrite() is true,
> mapping_map_writable() fails

I don't think this matters? Firstly these would have to be threads unless you
are going out of your way to transmit the memfd incompletely set up via a socket
or something, and then you'd have to be doing it on the assumption that it
wouldn't race?

The whole purpose of this change is to _allow read-only mapping *at all*_. Not
to avoid silly races that are the product of somebody doing stupid things.

>
> But even if we fix that, the same scenario would result in
> F_SEAL_WRITE randomly failing depending on the ordering, so it's not
> like we can actually do anything particularly sensible if these two
> operations race. Taking a step back, read-only shared mappings of
> F_SEAL_WRITE-sealed files are just kind of a bad idea because if
> someone first creates a read-only shared mapping and *then* tries to
> apply F_SEAL_WRITE, that won't work because the existing mapping will
> be VM_MAYWRITE.

I don't think so?

If they try to do that, attempting to apply the seal will fail as write will be
disallowed. So there's no risk of overriding the seal.

The idea is you establish a buffer, write into it, unmap, write-seal, and now
you can mmap() it PROT_READ.

Obviously it's not sensible (or really probably sensibly feasible) to try to
find every VMA that has it opened VM_READ | VM_MAYWRITE and clear the
VM_MAYWRITE, so instead we simply disallow that scenario.

But it's totally reasonable to be able to mmap() it readonly afterwards.

>
> And the manpage is just misleading on interaction with shared mappings
> in general, it says "Using the F_ADD_SEALS operation to set the
> F_SEAL_WRITE seal fails with EBUSY if any writable, shared mapping
> exists" when actually, it more or less fails if any shared mapping
> exists at all.

No, it's when any writable mapping exists after my changes :) but people
might not be quite aware of the distinction between VM_MAYWRITE and
VM_WRITE.

>
> @Julian Orth: Did you report this regression because this change
> caused issues with existing userspace code?
>
> > Reported-by: Julian Orth <ju.orth@gmail.com>
> > Closes: https://lore.kernel.org/all/CAHijbEUMhvJTN9Xw1GmbM266FXXv=U7s4L_Jem5x3AaPZxrYpQ@mail.gmail.com/
> > Fixes: 5de195060b2e ("mm: resolve faulty mmap_region() error path behaviour")
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

In any case, we are not discussing my original patch in 6.6 that permitted
this behaviour, whether you agree or disagree it was sensible, we have
regressed user-visible behaviour, this change restores it.

