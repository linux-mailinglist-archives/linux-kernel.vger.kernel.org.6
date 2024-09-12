Return-Path: <linux-kernel+bounces-325818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE3A975E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFEE2810A5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FBB29D06;
	Thu, 12 Sep 2024 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TEk9AIUA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jblhYmIP"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0751326AFC;
	Thu, 12 Sep 2024 01:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726105380; cv=fail; b=nNOwPuDL53ouxoOHrkNuBioDPvq/6VQ3pGOrYmwB7KHRYkCRt8UGPztI2YZdZkaFVCqcCDh1Pg47s+ZQht4iekc1pedwN1Oxc6s0xidG+vbvjLghA1K+pbc7cDlpfuiqbjXapwOgIjnoW6MplGcbyi/TcYsv729P77/i+iMle2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726105380; c=relaxed/simple;
	bh=KUVXaPkxiAErQw6bpnYP2Ld9jzvROr2j1PsB6DveZ1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=btrVAxOYV93ve0eMmPYalqNxg2CmE52lEbjCZ3GTUlW04DUfmBg9iNWpKIJsWQ8vSnpka1pzs+f8Z+QhYv1CxMoFTMcfoE+Zi8B2JjRg8QNyCRY/zcNavChqVEOPRyFskSlMt7MQJ3cTFl1O1zgbfhHGGp25KWpCqTnh+wrSsWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TEk9AIUA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jblhYmIP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BMfWuR024034;
	Thu, 12 Sep 2024 01:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=NbcgRKIq5/ZQz7KlbZ3Zz/qZZ46qum+XJn6AwlnWX/g=; b=
	TEk9AIUA+K8PmlkkuqrKsG3YjfWHgK5Jfv6QrsgmX8TvdDONlui+19Bl7Id9k3wK
	JsLkUADEZKGNqNmiC0Oh0f3bsXbPtM4UuHOKaRIzJZtj4oKDLFHEn+78FUNYEN1A
	MtavraIuQyPzjnQG2mpngkeJx75PHlDlN6CfTpiXB6EPSqRwm99IvgDORhJ0UY9k
	vZjIzcOC130T2qwXGD+wdyCbpEqdI/OkYGpeTURQl//C4koWNa/h3KKRYT4aMAsQ
	9EDwGpo06ttIZZCpbJv0/Rd64hfPFZEaDo6ros2jI1qgpVPKdsg7+GmU3Mq8JYYC
	yfPKA7Dkijbrjqu+uojizQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdm2sj2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 01:42:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48BMdbUw032402;
	Thu, 12 Sep 2024 01:42:47 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9h05q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 01:42:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHcPZ3pmb91mu2MZhwgLdZoZk5KcMS6GXoGtVnhJ1/25gupqiOb281D8xBbau4ThOZgyGeJ5tUP2Z2CmZ6u0YmNc6uCHpeNNO3P27vrrykvI6t8AREzavZxb5iyq6yDsHzoJSE0KhQw5CtOCCT9oepYDfuRbZ0O/1MCAHbfuTrkxOb7580MtnkaviE3uPR4Uww+XF22x5UMNAWGZUCj9+mhM3u82jc70GcTkv5zfMVJZ/ZdRzV2lJ3R2jtlabVh+ffLQjjyhqE31+EzaVxRlp4ifcYckV0c7YSiNj/eCcEEIxafWYxSXICp66orTppqgHRiIGsMI2IOPYJPkkCQ9og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbcgRKIq5/ZQz7KlbZ3Zz/qZZ46qum+XJn6AwlnWX/g=;
 b=tH9UoeTaHKkCpc8AgdKqYaPa5tNOjvZgo75+jndUT9nHJavNnn1C3elBVrh62vjjz0lvn+218Xt7/DOrUmB1yDBLU54Txh/rMSMTROKFKAAeDuvwIDhJpt/eNdLi9q5x32TMa71dqmAswFEHhVwlZxQXwKZCROv2AF5Q7QDVgIxa4FQGXMcBT1a++Hw3m/DPujSUfvQD9G9tH2tKVWwkMXe71Brc/uLFxA4cb7YvL20fFjQlqnTL/0FqPXYx83TeNrLquvmgjxC2EVzSJFgNve0lNZLh1mDQa46rLaPo/3bujq6U3GB+59lkVmdZTBVXtKMoyr7fhp6BjnAdI66APw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbcgRKIq5/ZQz7KlbZ3Zz/qZZ46qum+XJn6AwlnWX/g=;
 b=jblhYmIPxUfsvmFGvuzdcbMT/EJ6646R+lkr9bxZXjv1+9r9inMQozZ88CpG8rw9Qm8hjqO0tFuqMVilXOX35UvOCixcfJj32KR/+ca4GYtnb15C0ajDN7l+Ycy13UMjN6aZhb9qtXMcSDBcRm3FNBIR+B+M90CexcabYbyqkXg=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CY8PR10MB6852.namprd10.prod.outlook.com (2603:10b6:930:84::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Thu, 12 Sep
 2024 01:42:44 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.024; Thu, 12 Sep 2024
 01:42:44 +0000
Date: Wed, 11 Sep 2024 21:42:42 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Yang Shi <shy828301@gmail.com>
Cc: Helge Deller <deller@gmx.de>, Helge Deller <deller@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH] [RFC] mm: mmap: Allow mmap(MAP_STACK) to map growable
 stack
Message-ID: <75ihgmlcmou7yatoeva5sezbf6stow4gtdyurwzj5fxghjq7yw@o3u5wudjdnkk>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Yang Shi <shy828301@gmail.com>, Helge Deller <deller@gmx.de>, Helge Deller <deller@kernel.org>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-parisc@vger.kernel.org
References: <ZuHtb43Ar21ZptNz@p100>
 <focr7orndhsr7vhownfdhrpctwztloz54bfbg2wnd4xmqtcymu@26pn5wteugl6>
 <CAHbLzkqhc2yT=rh6ZkjaRJ8RF_NrZM6bXd-nau6jJjbow8vogw@mail.gmail.com>
 <tvllphck5fky6zqhkpcomjj5zuncgligdqapwkv5qwqamtjfc7@3geizoueze4d>
 <95c4efe9-e92a-46fe-bf41-9141e125332d@gmx.de>
 <CAHbLzkotBTOf0OrPSN4o=UEvRXjT=L=NSZn_=FBA6nG51ppjYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHbLzkotBTOf0OrPSN4o=UEvRXjT=L=NSZn_=FBA6nG51ppjYg@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0265.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::29) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CY8PR10MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da1366d-1dfb-4d6d-88e3-08dcd2cc327a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bC9mTlBWMmJCTGg0aVdnMHcrRkw1Lzh3T3lKWTdZWXVJVGxWUktQZ2p2L3Y4?=
 =?utf-8?B?cEdwSXhuMUZhWnhKNE1WWFFJb0xDSTJyU21KRVo1ZmVFN2FNcjliVUNsQnVm?=
 =?utf-8?B?QzUwY3pEbWEvdng2Vng0M1h1aDd2ZGh2d0RIUk1POHRFb3dPMHAzdXlGcXJy?=
 =?utf-8?B?akYyV2I1dDQrUzhZT2w1VG40NGJjMjFrUndjSXRLRG8rVGpaNFRKV2ZuR3Nx?=
 =?utf-8?B?WmtUbUNyQlNtWE1yakQvRjNGbE5mTm5qWDZNZHlIOCtVYmRaeU5FR1dsRUFB?=
 =?utf-8?B?SDk3MkdXckg1V0xKeEtuM09jbWpwS1YvNExHbndYSG5jQ3RZbHN5elFlY1dh?=
 =?utf-8?B?ei9sNGxTTmZDUEVwY3hLWk9qOVZuZTRiNnVYc0pIa0drU0MxbVZZcTF3SFZM?=
 =?utf-8?B?OFpxR0d2WlltRU43ZzFuWlFmRjJtVy96WDgrYzJKT1FEK3B3cGE3SldOQWQw?=
 =?utf-8?B?NnRlNUNaR1FUalBvVWtnU3RyQ01KNUxhVitGWjA1UVpYcDF5NmxwRmc3WUl0?=
 =?utf-8?B?MzVpWjh0SDQwdFVYckZnOTlRUEJtdDlicHBCY1lXa2VPYzdEWnJyRFJVVU0z?=
 =?utf-8?B?Mnp0TzRqcE1lSVdaaTZWUllpZUk4bzFSdFN3Z0FTUTUvYkhtaDViZnArdDNJ?=
 =?utf-8?B?Ym1uSVYrcDJOK1BuMXFLelVOTWhrVW9XLzhIZ2wzZVVCS2xoOHArb2JmSksv?=
 =?utf-8?B?dXZnUEZ4bFhLeDVmb2lwZlh2alpjOC9YRW1uMTJLT0lUSk9wMFFtTm1JUmlN?=
 =?utf-8?B?L05Vcng2ck9VamdQeFZ0RkpVa2ZobS9ROXVPZ05hTHFpZ0xvb3phMTFBbURp?=
 =?utf-8?B?RVUvdjVJWkxRUGtQWTF4elNONlY4aWVZZ1dNNXZ3ek5OYkp0eXIwV3NRQUF2?=
 =?utf-8?B?NUNoTTJFY0ZpeXZhMFJKazh0RlZ0ZERlVGR3RURBWmpLRG9DYVNEMDN0N1pO?=
 =?utf-8?B?R05EZEhmdGVvbktSN3hvNC8yUHpSRndJVWtQazREYTU2NldpejJaT3owYTJI?=
 =?utf-8?B?bmtFTm84WHlkTmtrV2lyZm5yZGlCWU1ybWJmSDZQL0liSFh1akZoNHd5L2RW?=
 =?utf-8?B?VUY5KzB2Yzd5amRsZzF1cUhEWHdob2FYS3BNdVljSVF3aDlZWGxKVDI5Tk41?=
 =?utf-8?B?cHZXMXluNW1paWM3VHdFTGRnNGl6VXNLbUx0KzlSSEswZFlLUFZWSzdyZFhQ?=
 =?utf-8?B?dE9zalZPQmNJZzlDZXRVYkUrbWdhWXJZSUJpMG9VWnlITTBPcEh4N1EvNVZt?=
 =?utf-8?B?ald0bklaWnpoYXAzeFdTakVsbHJ6L21wY0VVKzk0bWlkMFEyMjlIbEFtMFkx?=
 =?utf-8?B?N1hzS0ZLaUI3QmJlakViWW54MGc4bDMxYklLYlBWbXZuNlN6K1J6N0NUUE41?=
 =?utf-8?B?WEtrUTRlL1RJK3ViWndRN2ZzM1FTTUQreE04YlZKUFoyei9ZL25ENVdjQzFy?=
 =?utf-8?B?Ky9TM29ITzA2VW9qajRST2lEUFpJVUM2QlQ0WjFwTUFXUHdHbzdDc2ZMc1o1?=
 =?utf-8?B?Uk5WMFN5RHlscEFmQmJDV05EYTBKZjJTK1RiY2VMRDFFTFZBSW1Lc3VSc0tT?=
 =?utf-8?B?TGUzanNMQ0J0RERCQ0N2MGVOM0wra0svUzNudU1NdDdkTkhPbFdyamgvaXlr?=
 =?utf-8?B?R25CMDZyazkwbXA0V09temVYaGtuZXhjOW5qVHpVbm9ONVpNWlVGcis4NXUx?=
 =?utf-8?B?Q2pqcGVrK1ZyWFh0SThPUFpvajJBSGJ6c0xTT2NVR2gvZXhWamZHZ2Npdjkz?=
 =?utf-8?B?YkE1MVRXRWdsSWtrQ2FnSTQ5ZzVsK3RRY09aTkRjT0pjZHR0azYxTExaUzU0?=
 =?utf-8?B?TDl6aWpQTXRtbDdEVzZaZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUFCVUcyeEtyYlpkOFk0OURtUG1SYll4YnJnNjZLeHN5WWVtZ2I2SkpUMXdm?=
 =?utf-8?B?ZGgxVExlbW4yMnA1Uy9CYm9zYWxxTUNobk5FNWtJQ2pmdEV6UDlsWlhaUFBh?=
 =?utf-8?B?SlpBaVJuSXRUL25OSW4rak1ST0txVlRNZnVHRnJla2xUNVJqbWpOczZoK08w?=
 =?utf-8?B?cHZEWml1ai95eHdkcWZjVkxJZXBGZVhZTFE4L0dDTUQ5aHhBM29KbFNzVTdY?=
 =?utf-8?B?dTdPTm9NWWhUb2k0ME5HTndUb2xXQmhkcVJvdThRNlM0K0cyOWlGVDJWVVl3?=
 =?utf-8?B?aEp4YUdaUy80cjFKZXlCN1JCaytrTWZ5RFJaT3dJeG5NaWlFcWRoWWFsT0pT?=
 =?utf-8?B?TVRURUhnQ1k0R1d3anZNVStOVVlPcmxyYjcxTllLZWJHU1BtUEhuRStjcWZl?=
 =?utf-8?B?eUlPb0xvSmErR1lVQzUzODhPWXYrWTdyejhpU1M3eHpCNFR5azgyaVU3M2Nz?=
 =?utf-8?B?aDdsb01oMDZac2lvblpIQ3ZNVU9wNUZhaUlMUjBvdDVGNzZCTWFCWWhWV3VO?=
 =?utf-8?B?RERPMVV5WFpvRzJ3UzdhS25SY1cyUmNHL290YmxwckNXYU1BUTlEZzRiNUhp?=
 =?utf-8?B?R2hlZlhHMHJPTlowUEVsb1Z0aXl2VGdYb3dqclQxWlZsUWZ6Zm5IaVNXZEpl?=
 =?utf-8?B?SHk4b2h4ZGdUenhkNmhOS0NRV1Yray9nM3FUN1A5bkMrOFh6SDJvOVBldU1I?=
 =?utf-8?B?djV5K1lLSDF5MGdDdERtemFRY2xmS1Fjb3A0WDdmK1cyWjBkejBWUGk4a2xE?=
 =?utf-8?B?bjhXRTlraGI3R2gvUE9ERjZHQ1haZlJZNjdUQTBTR0dRWDVtaGtLS1FJK1Nn?=
 =?utf-8?B?TEhUZSthUHJiMFJhOHRpMDMxd0M4cjFtVDBvZnlqNUdxSVJPcWlzVDgzWWh4?=
 =?utf-8?B?UDZxeUV1Sjdwbi9CUWRjeHFhQytTMEFUamh6THNKTnRBOWMwQW5RWklQRGRQ?=
 =?utf-8?B?TlpsNzU5NStKZXBXT3E2RzlmK1BrdFE3ZGFQRnBockF2Wm92Yk9Ka294VGRQ?=
 =?utf-8?B?VGtaNXROUkpJdGxoN0lEQjU2SmF3VVVTZlpSUy9KWVVndGxsdVNxc1BTSTQ1?=
 =?utf-8?B?WU5tSjlwdURZaVdJcXF2ZlNLQ3NoZ0M2OGF4K1MyZTl2Q3luWDk2VEpUdC96?=
 =?utf-8?B?UnU3Mk9SWXUrWTZsMnU0b2k5Tlh4TE4wV0Z6K2tOUHpjSW5MVzUyWFJyNnd3?=
 =?utf-8?B?WW9xdWpNWGxTODVWUTdzMWNnb1ZnKzY0N2lVNnNrVUNMQUdqTGIzRk1YYktS?=
 =?utf-8?B?VTYwbWtTYjNuejBNS1A2ZmpnUldrb3pCQm1IS2NWL1RZaStMR0FFZUp0QS9C?=
 =?utf-8?B?cHJ5NGdWUmMwdGUvWnJXSDZvNktscHdyOW5jNG81ZlZ0TWU0bXY1OW9hVTdS?=
 =?utf-8?B?OXpSYS9YcE1CU1l6RVA1c3QzN1c0UmtjQWNLMWtLS2RnbVZIcXBpeUxhZU4y?=
 =?utf-8?B?L1BKWHE5UlZTc1V0STU2UWw4UmZUQ0M0WWtRejZURjJKbG1WQURaWDlmZjVz?=
 =?utf-8?B?bks2ZkFkZ0ZHRHdaZUprTHEyaDJTemJ1L0NYTUx2T01vaUxaNkZrSHdxSTZ0?=
 =?utf-8?B?eVAyYkl1QmxuZ3kzSzNkVnFTRncrY1NnVlNwQ3JvT21ocllSVDBQaCtyZDVV?=
 =?utf-8?B?b3dZeHFEZ0hTd3ZnRVBOa3VvMHlsUGliUkpJcjJienZFWU9nOWl1Y3NUbk9n?=
 =?utf-8?B?NUhLQVlidzQyMlR4dXpqNzVYaGZtTUFWMVpJT2tOaFcraFl2djVWMlUrc0Jp?=
 =?utf-8?B?TWNGUCtOMWs2Q2p4T0lzRGQxUHpVTldOZm9PbnE1VHl0TUorQ2M3eENNRll4?=
 =?utf-8?B?bXdFd1FqRVRCaHkxSHpYcjFKNEVkbHdFVG1ZU0hENENmQ3U4Z2JzZFZ2QndK?=
 =?utf-8?B?NGhxLytpN0VEanBjdmdpZUlWZmVkRTlhMC82ZDhYUEpKbDQwWlA5TWZYVG9V?=
 =?utf-8?B?dThUQlpvQURCdGloMzVoZVZXVWN1SCtEOHRVRzhTaUhkMnRsQm9FNk50dmFl?=
 =?utf-8?B?ZGxQclZuMFlQWjBTQ3NzYXMrK3JyT2lGQ1dKRmxFdHdRSnl3SEg2czNkZ0lv?=
 =?utf-8?B?aWVzWk9pTWtRZ1gzNmx3bTNOZUw5ZTI4OTlPQUl4MTh0cjhqTWZwMy9YbCtQ?=
 =?utf-8?Q?/VcRy8TzNzY2tdJxFRCvm4LxD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e7d9YIYnNSSUYdZ4M/TSGv2akQuQ/uRX2Aa62JH8Q7aukJYfhY9hjleOOEYOSnkNRkjqEMVI02mICNMEvPE5fVxNmVh5aFPy40oxd/KJh+bEcpZVyvQvgWN7qdG+hsNlfO3F2YPRaPAniVi54x4DBtfp/ksnhWmZwd3U/uW+MGu/tyYNAQ0E+6x3mnlyEuR3KKbgIjlhz6MvIe4Fic3lWWFzkNAFOzXUXv+fLeboNGAikUesTM3JYsYvM+XfJBWaZixwNsV55Kr+2rOmPUrQn59ORlxzYwo5Xrl8NjJoMLZ9DqVVcsILcaRY1ynl3SC6wFZq0s9FTZLwHuoCOisthdiWUG1UI3jiVUgmQAEhf0jsHuOzxspF5LcoIPeG8aOb+hfp9YA4MD9MIweCKV6j0gH0+zuEFeiR93+vG3/UlsM4VAnzsd1zPjDfCBXf6SZmHwVj0qgj2S+d1X8cH+9vnFiM9xaX378xMahT20XgeSvTOsBCCNNKu1KPUn09P4ArruAj1+USa/Kx20ai8vuZ3hrA1CrTBOX7MaJ7OaK5u8owZmp0+YbUJ5PQDDVz558Ah4VZcfypTesgndcJ2SNpMkd+V9+cnhzS19X7E7AjHdE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da1366d-1dfb-4d6d-88e3-08dcd2cc327a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 01:42:44.2834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KEldU1lcUWGNlXxsJUO3mshjCHTjieZrPaNqISoDItp/8sQ1fI1lvhYKnB3FmNSxU4LbzKbkOyMOKrwxnyCow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_02,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=655 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409120011
X-Proofpoint-GUID: OgYBw3n5H-4l2X_2BJsKsgo3DhGd2M1o
X-Proofpoint-ORIG-GUID: OgYBw3n5H-4l2X_2BJsKsgo3DhGd2M1o

* Yang Shi <shy828301@gmail.com> [240911 21:08]:
> On Wed, Sep 11, 2024 at 5:50=E2=80=AFPM Helge Deller <deller@gmx.de> wrot=
e:
> >
> > On 9/12/24 01:05, Liam R. Howlett wrote:
> > > * Yang Shi <shy828301@gmail.com> [240911 18:16]:
> > >> On Wed, Sep 11, 2024 at 12:49=E2=80=AFPM Liam R. Howlett
> > >> <Liam.Howlett@oracle.com> wrote:
> > >>>
> > >>> * Helge Deller <deller@kernel.org> [240911 15:20]:
> > >>>> This is a RFC to change the behaviour of mmap(MAP_STACK) to be
> > >>>> sufficient to map memory for usage as stack on all architectures.
> > >>>> Currently MAP_STACK is a no-op on Linux, and instead MAP_GROWSDOWN
> > >>>> has to be used.
> > >>>> To clarify, here is the relevant info from the mmap() man page:
> > >>>>
> > >>>> MAP_GROWSDOWN
> > >>>>     This flag is used for stacks. It indicates to the kernel virtu=
al
> > >>>>     memory system that the mapping should extend downward in memor=
y.  The
> > >>>>     return address is one page lower than the memory area that is
> > >>>>     actually created in the process's virtual address space.  Touc=
hing an
> > >>>>     address in the "guard" page below the mapping will cause the m=
apping
> > >>>>     to grow by a page. This growth can be repeated until the mappi=
ng
> > >>>>     grows to within a page of the high end of the next lower mappi=
ng,
> > >>>>     at which point touching the "guard" page will result in a SIGS=
EGV
> > >>>>     signal.
> > >>>>
> > >>>> MAP_STACK (since Linux 2.6.27)
> > >>>>     Allocate the mapping at an address suitable for a process or t=
hread
> > >>>>     stack.
> > >>>>
> > >>>>     This flag is currently a no-op on Linux. However, by employing=
 this
> > >>>>     flag, applications can ensure that they transparently obtain s=
upport
> > >>>>     if the flag is implemented in the future. Thus, it is used in =
the
> > >>>>     glibc threading implementation to allow for the fact that
> > >>>>     some architectures may (later) require special treatment for
> > >>>>     stack allocations. A further reason to employ this flag is
> > >>>>     portability: MAP_STACK exists (and has an effect) on some
> > >>>>     other systems (e.g., some of the BSDs).
> > >>>>
> > >>>> The reason to suggest this change is, that on the parisc architect=
ure the
> > >>>> stack grows upwards. As such, using solely the MAP_GROWSDOWN flag =
will not
> > >>>> work. Note that there exists no MAP_GROWSUP flag.
> > >>>> By changing the behaviour of MAP_STACK to mark the memory area wit=
h the
> > >>>> VM_STACK bit (which is VM_GROWSUP or VM_GROWSDOWN depending on the
> > >>>> architecture) the MAP_STACK flag does exactly what people would ex=
pect on
> > >>>> all platforms.
> > >>>>
> > >>>> This change should have no negative side-effect, as all code which
> > >>>> used mmap(MAP_GROWSDOWN | MAP_STACK) still work as before.
> > >>>>
> > >>>> Signed-off-by: Helge Deller <deller@gmx.de>
> > >>>>
> > >>>> diff --git a/include/linux/mman.h b/include/linux/mman.h
> > >>>> index bcb201ab7a41..66bc72a0cb19 100644
> > >>>> --- a/include/linux/mman.h
> > >>>> +++ b/include/linux/mman.h
> > >>>> @@ -156,6 +156,7 @@ calc_vm_flag_bits(unsigned long flags)
> > >>>>        return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN )=
 |
> > >>>>               _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    )=
 |
> > >>>>               _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      )=
 |
> > >>>> +            _calc_vm_trans(flags, MAP_STACK,      VM_STACK     ) =
|
> > >>>
> > >>> Right now MAP_STACK can be used to set VM_NOHUGEPAGE, but this will
> > >>> change the user interface to create a vma that will grow.  I'm not
> > >>> entirely sure this is okay?
> > >>
> > >> AFAICT, I don't see this is a problem. Currently huge page also skip=
s
> > >> the VMAs with VM_GROWS* flags set. See vma_is_temporary_stack().
> > >> __thp_vma_allowable_orders() returns 0 if the vma is a temporary
> > >> stack.
> > >
> > > If someone is using MAP_STACK to avoid having a huge page, they will
> > > also get a mapping that grows - which is different than what happens
> > > today.
> > >
> > > I'm not saying that's right, but someone could be abusing the existin=
g
> > > flag and this will change the behaviour.
> >
> > Wouldn't a plain mmap() followed by madvise(MADV_NOHUGEPAGE) do exactly=
 that?
> > Why abusing MAP_STACK for that?
>=20
> Different sources and reports showed having huge pages for stack
> mapping hurts performance. A lot of applications, for example, pthread
> lib, allocate stack with MAP_STACK and they don't call MADV_NOHUGEPAGE
> on stack mapping.
>=20

It makes sense to have a stack with NOHUGEPAGE, but does anyone use
MAP_STACK to avoid the extra syscall to madv to set it on mappings that
are NOT stacks which would now become stack-like with this change?

...
> > >>>>               _calc_vm_trans(flags, MAP_STACK,      VM_NOHUGEPAGE)=
 |
> > >>>>               arch_calc_vm_flag_bits(flags);
> > >>>>   }
> >

