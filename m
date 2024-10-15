Return-Path: <linux-kernel+bounces-364924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A8599DB30
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D6D2832E9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF6A154423;
	Tue, 15 Oct 2024 01:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PdEg/GVP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0Vn/v3ac"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365A013D53D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728954689; cv=fail; b=D1T1p70zefIIHPPAGeC0yQDoxZnjQGJ9ee+IPlhSGHtGV68UE8mCp/iC7pRPkHbKeh8AnMdsFUzH2msrtHLMc7KtXxwtrbjvJJlVtvlvsA1q/T+38oi/yRNsO7EBg0G5L7nKGVYQgQ6Zs8BromDAqbx4QyuwBaBO26qCbup7n+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728954689; c=relaxed/simple;
	bh=DNsQtWZmtmqqZ+NiBN63V3/0SiJw19UtgqcfNq4G3w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rk444mWkDJifK9dqOzcbosi7dtSiHfZtRS/PLz8K4/29TexT1tWioCz1Ec7R73kDl/3W1TC+z784c7dM90/enLKq4DN0+Icxg4e9++aZS3ZX0iLnVSj4NLQFbn05VWZqCzjHIw3C/UIPHa4MLqixxkqwm/d8ILOg+OAifieOxi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PdEg/GVP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0Vn/v3ac; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ELMl56001132;
	Tue, 15 Oct 2024 01:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=m335OywcnQiuPEdcLsFz9+b3FOlFXhz1L4QccgvN91M=; b=
	PdEg/GVPo8/H7If9KaYBwVZ6R1+k84otOowNkuOmRv7Dt3eJUl3VYAsU11kokPgr
	FQ0Ggn2JaayPxs9FoR97dSVo6/rY14kqwYPC/P9AYSbjFp93bhEcoQUtSqvLZbNZ
	BMtn8P3RWa/Q81S5KNqyjogQCqKcOQ9Om0hhpr5Bnf6iIE4nBOT+yrjxBn3CnLh2
	+5Rd0ybRrb/eOPHnIbtIXxUHAp7ZzQjegFQHCtB4MTvPygh0K805H26cr6TPUUfl
	pyN9SZeCnEoCMWq7B78b9/Uo/Ss/ML6KaFzRatlPe2E/OQpee7/hrlTuYd1wgbUO
	RUk85aMIQCIDnFy+MdDRFg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1affd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 01:11:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49F01bl2036660;
	Tue, 15 Oct 2024 01:11:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjd2a3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 01:11:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haBtsWXxIBne+fYbtqUDiwo6nkYandQQi2ZOH2gS+m4jrylcvDBW7aNbB7Pujosqi9bA/B3OJO+ZWrzNw9vkJ9+EYZGhinVFEW0XxrancrKa7ZIHOcyWZevaDPmrcljj3JKelugqQocm0ZN5F2o6JQatGGP7KlP9DOdWp9i2yRlA1LeBDnXqViQEG10lnoun+x9GZKAO9PGy3ZBEDx532/QfJ0K3Ms7I5IoyaItl+87qRN8r8GhDvPygbFxUsd2ECXKLdhN8AvEYjNg13VMfcXvAWuc9zvGd8QIbkHbbRd5fMVQYo5V286/BCq/1o+KGc2JpqtNMaaijkwftaPNRzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m335OywcnQiuPEdcLsFz9+b3FOlFXhz1L4QccgvN91M=;
 b=qIhoEOB2CJ/7bUshRWYbqJ4zU7PrixR+FoWrbAg3TUg8DiSbOuHipkHPT/y7MpjfVAGm7si4qZA7P0d4RBYHYsQ3HL8oHCB13O+Sjjvflth2LlK05nERW7DkX5LEdzZ2gWK6ckin3W/RHpwnGeCVv3769LvsRduyBpN6UWXEqJ0Mqlx9aFrmhj3EKJC2fPl8yhAF41nxuKTzT/H1bZBklw639MkKRvICLhGhvGOEqPQul802mSzD1nvAkxM1TWO7m5vMjlS5B1VFmQBoDoufbLjbUnHHuYRMgrTqh32ztleTMSkfx4SpAs2pdmL1dwM021A47BhwIa1wOtiQQhITrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m335OywcnQiuPEdcLsFz9+b3FOlFXhz1L4QccgvN91M=;
 b=0Vn/v3ac1SkV0WqRdF9lcjgGn4W9d6qRuz8Cc5CzIQx3NjGCNxVNGe13Znn83S3rrhu7/ESpIXLSE/49t3vlKayMxLM8mewCf5BxU2etXLLRhIRlh4sa944n27XTc4iZxK5MEK/6BD5+XVg6+iqhvVmE97/4zPKrBP1+0yLJcDE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB5901.namprd10.prod.outlook.com (2603:10b6:8:87::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.26; Tue, 15 Oct 2024 01:11:08 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 01:11:08 +0000
Date: Mon, 14 Oct 2024 21:11:06 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, sidhartha.kumar@oracle.com,
        lorenzo.stoakes@oracle.com, zhangpeng.00@bytedance.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: fix -Wunused-result in linux.c
Message-ID: <ddepbtajvjqoftjqanab7dpcx62pjrl4s3cowhciocevfa43wa@sncxpv75hpjp>
References: <20241011225155.27607-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241011225155.27607-1-skhan@linuxfoundation.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0388.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::29) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: 595b406e-dd2e-4ff5-227d-08dcecb64041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1pUZ0dHdWh1eXFoU0loTXZVZCsva09pYkRVUWk2YTVBbVFaWjNML3BYd1dU?=
 =?utf-8?B?UXQyekUyeFBQdzRuNGZ0VmNwdXpSNVJNQjljY3pkNURsbk1uY3RuVDJsZDA1?=
 =?utf-8?B?OXVybjQydE5DTTNNLzZoTjZRYytxY0Q3MVpYemJLSU5aRW5NelIrRWR4Qm1Y?=
 =?utf-8?B?cVZNdmVWSkJVUWlGUTFaRE15Sjd1enZOVlM2azFiS2FEUWNnMjc4WEhqTWh0?=
 =?utf-8?B?TkVlS2xoem9YRU9FQ3Q3cndORUdReTRqMWNuTlF4Y20xeFo2WHlyRk9ibHh2?=
 =?utf-8?B?M3JMYUx2encvYkdzMkswZnp1ZjByMlFxRjByMDV6bFZmbXdwUUJ4ZkdLYngx?=
 =?utf-8?B?YUdpOWhSTTMySWVJWm54NUVrMHFiWE1PeGNVSTA5bmI1bWF6TEZvY0hYaytk?=
 =?utf-8?B?MkdmSFdvSlkwMXltUjdmbDhjbTgxekU3anU2WFdsQWpUb0l6ZkJmaWd0dXdu?=
 =?utf-8?B?YmZPeW5CU3RLcGs4MTJjMzRyOUtvWEpCR2Y1R285Tmlub3RTYUwxaDJFNFJE?=
 =?utf-8?B?U1dJTm5WMGFLbDlHQjdLYnlySkZEQU1IMzRGZ1AvWnlLV3FwRWhQa1BWSXh2?=
 =?utf-8?B?MzBtbDM3N0tEazRwYUlFRjlzbFZBMkEyN3pjUlRnRm1MZkt4aG1QRWxkOHhP?=
 =?utf-8?B?RUpUWDc1NzduNjRiS1o5SWxlbjM0aTF4QmtvUHM1SW14TlV3Q1kxK2lDUjF6?=
 =?utf-8?B?NUtnY3pvSGxha3pVcWpXWktubG51U0FzMUY1Z0NPRzhHMStSMzFONnZIOVh4?=
 =?utf-8?B?Q1NrSFJpK0o1N2kzc3M3cUJoY28vVE5EZW1qcm4weFJDNUdabDcvZXZPSUFK?=
 =?utf-8?B?Z2xvOTNXdmVXc0I0T2wzZkZKVng4elZ2Y3ExNmJobVczUGl2Y21JY3duNWI2?=
 =?utf-8?B?MGJUNndRUjJ3UWZlUU4vVUo5MXlGNGMzaUs2Q2piZFp0YnNHMXFKVmFCcDlu?=
 =?utf-8?B?c1J5L2J2bmtZN0kxSFltUzgvNVdzZVBhV2I1cU5HUUlUZW1seTJPdEhCaWs3?=
 =?utf-8?B?cjVCcnI2WGJPaEVrR0Fuei9SK25RM2pDcFl0MXpFanZyWGJWeHdwY2ROcmNv?=
 =?utf-8?B?dWdHbDNyMWcrb3hKcHdiaDNKN05rRFVqM2N4T2dFNGhzMGtjMmRWYzFCSmN0?=
 =?utf-8?B?K2toYVBxVlAzcHB5eXhmZ05sczYwQWVmamFOT2tvalFJTXRRYlptR0RueGYy?=
 =?utf-8?B?ZGtVS3NXWE42SGV5NExHYzZKaHB0MGYvMDBCMmZTUmR1V3dNQ0NSRWFIY3dZ?=
 =?utf-8?B?MkE2TEUxb01LTEU3RFhyazVoRHJFRmx1Y0xFUzluT3hzdGF0ek5id0Z0WXJ1?=
 =?utf-8?B?RU52Q05Hb2V1KzNib201bm10L0hqWHJuVWlBK2RxeFZiNnQzNGFPQlo2dnZL?=
 =?utf-8?B?MFNQK0ZrZHNYUmVNblh0VkVZbnlMZXhhYSt3dnV0bVdnTy9sWXdITzg0VnNn?=
 =?utf-8?B?RGJrSkIyNks1UEIyelJtRVBwVm03RzJOUGFVZmI0YXIzQVNFVGI2K3NYdnFN?=
 =?utf-8?B?YUFJQmR3YWgxQ2VLUm4yOVlSN2k2eWQxZXlCV1g3eUVnYmNqYWxoZEtvU3Vr?=
 =?utf-8?B?YW9OS0FCTTYybTVmdkloTnJPYTJqM3FrMy9qWU12NERBYzJHMG5sWWlqdldl?=
 =?utf-8?B?SnBKa0Y3NDgySTFMYkdiQ3h2cmx6eEJRb2NHblZCSEhZUUtGTGNEVlpDQXpK?=
 =?utf-8?B?aFNid2VGcElLbDdVVXRBWE1HYXIyRG0zQW96RWFyUjc1Z0lORDJVR25RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHFKRmtRZGp0UGNObVEwU2V3cnQxaERVL2dWcVNZYm1GaXo0V2R4dklyeWlp?=
 =?utf-8?B?Sjl2RlZuT0VXNkNuRGZIMm54dWNpK3dLbSt0bjg4cklRN1FBeHFqTjJHOUsw?=
 =?utf-8?B?bEU3VG9SSDZISkdDeUt3WHJNenRtTnRZVExSZEVUY0JqeFRQRll2RTk0Q3Vh?=
 =?utf-8?B?N1Y1cjBSWHViU1lremJ6YUdZdVhiYjJqRjZzN0N6aWw3bk5FUlVFcEZFQlFR?=
 =?utf-8?B?OWlLeURGRkp1dE9WaC9rRmZkcWlqWDNwTWtBNTVKbmdjV2pMSWpZUElEaTZ6?=
 =?utf-8?B?U3R3STVtNEVMYXhVZ0JkV0xNYTljdGZBeWFZcHpITUo5N2dxMTF3ekw0RHdr?=
 =?utf-8?B?c0Vvait6ajhvajd3ZkgrOHdYbkl0d0RIQUt6UVRUU0ZvUEJEdEsrdUpOeW5C?=
 =?utf-8?B?YSt1eFlWa2ZSMTFsYSt5S25YU0JYWDdCMDgrV1BOLzdBTVVLTW8xSkFBMGQ5?=
 =?utf-8?B?b2hjWi9QSm9paXIrNGxYblkrMzFFQ0VHM2ZCL3V0RXNkSk5PTm0zMy9OMFRN?=
 =?utf-8?B?N09TeVRvSE40NXFOc2syVmgzazJTMTlVQ0xQQ0RsK1prdWNKUkdZL1lHSzQ3?=
 =?utf-8?B?VzNBS3lmdEtlVkZDK011YzhaR2YzZDBFblVCY3FWYTFScjNydFNKL2tmeDNp?=
 =?utf-8?B?WkFXSG1Oa2k5R2kzZDBXVktRRE1HNkJ2Nkd4S3lmdjQ4L2hmNzluc2xNNUpn?=
 =?utf-8?B?dmh1Q29WY3pVNGw2Vys2ZDNZV2llU2l5Y2NreS9UNXh0TWV1bENwTTJiV1Jt?=
 =?utf-8?B?b0kyemYvSE1LK2tuVVFPNWp2RHB5TG9UdW1kMWxtdFdNdGs2Rk5zZ0ZQOUFx?=
 =?utf-8?B?eEdjRUtjMHRnWE9EczlXbk94NTkvS2k5THMzd00yNmZISlFFYW94cVZ6QWNx?=
 =?utf-8?B?K2ZqeHRqUWd3V05uTTFBTGNrRWpCL3hLS3hMVU0vblppWnhlcXpPVTBrL1M3?=
 =?utf-8?B?aUxySDVwc2w1V0UwdDFTTWVqeFZqNW5ibmpubjlBQW5jSno2VklUUXBMVjEy?=
 =?utf-8?B?cTU0c2MvRWdpZmNTT3FwSHVSNHdwa2J2My9YWUpVbENrYWFFeEh5SlV0dWF0?=
 =?utf-8?B?NGl4TVc1T29xMGVQbkJkKzUydm51c1NxbytWQ3ZqMGErenF5S0pnUzhMT2Iv?=
 =?utf-8?B?bm5mT0JmaDlUSkUxNUFKc2YxSG8zS2lpTjZoSVhNdTJCbzIxRHRnZnJrclFE?=
 =?utf-8?B?bmJNdzE0dVVmWThicVllcW1Td09QWlFKd1B1T01RT0htLzVocCsweThjMjEx?=
 =?utf-8?B?NUc5SWhHMW9aNCtsUGJOcllSdkxlK251ZVpBZEJEOHQ5OTdTZEZJbXpGK2N2?=
 =?utf-8?B?eWhFVzZ1bU9tanZQT3JVcjJpaHlpemhSZmYyVUpVTzhaU08vakQ3ZGFhWVMx?=
 =?utf-8?B?VGtHNm5EcEw4NlFPbGlKVERPcXRGVWNIdVorMDlKSkF1RjA0dzdtMDgwRlp1?=
 =?utf-8?B?VVloZWF2aHQwSjVGUS8yM0NLcUZwOXNzN2habDk0Mzc1bDU1a2ljcm01Yzk1?=
 =?utf-8?B?ZEFQSkZucXFqYm9ZTG52YlMxUWtGRkZHTTBXQm5ZN3FmTXNrbCtqS0tDOWhl?=
 =?utf-8?B?TlFKbGRVSTdRNGhGTkEzV1pJM2pqTlNpSHU4ZnNuZU1kZVFaWENRRzhFOSt1?=
 =?utf-8?B?ZzFvbzFDWVgrUGVqRjhXbVNOTW9kbm05b3FzWmhIelVFaXlMd2pCU1R0cTlJ?=
 =?utf-8?B?UTNkRmJNQmVCVi8vT1lEM2Y2dkR4bmFhZDMwWVYxTGRkQno0SEx1VWhXdUJl?=
 =?utf-8?B?b3pFVTcvVWM1UjA2b2pWdXp4cE43ZVRTdmZ4enlSbTVTR3VOM0VMZEhCME1U?=
 =?utf-8?B?SmIwN3dORCtia244ZzlJYkVtQ3A3OHJ1eTB2TFV3dlJycGJmZFBjZXp1MzFG?=
 =?utf-8?B?ZWtzVUk1cnREUlRmdU8wd2dmdDQxcnlQYzJxOVJ5Z1FZRkNCcThjVDJSVmtF?=
 =?utf-8?B?cktUaG94V3dEYUp5RE1ZWGFrK2w4MlA3WDJJWXVWdmVhQ3NSMmVhMkVlRHVQ?=
 =?utf-8?B?NlN2aDQ2Z09MS1Raa0g3YnVhVTZVc1MrRUE4dHIvbHVpc3JTaGs4Wmt3bUs4?=
 =?utf-8?B?TVczM1Y5RnpUekI2d1AwTk9WNEEyRWdMUmdvL0FHeHkxMjdhcWVDdHZrRVNh?=
 =?utf-8?Q?WVgfMF3PeL/mOulUsU/VmobtZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BtaeD+Pw1G2ZJYVh40Px9J46zZDlTWFEaBnqB/n+E+e6e4YB501n9+wlbOjOkIGY40JutAdTWLOLzVxTlfOdVI7Z5B+SSC/UdhuyOZmMadXYeX/K+ri0aJC+xhvpGKqE8fNMAIhq8qElunjrBwzalbYj6sC9M0o4PwztrCn9r360vUmiKxlYqxd4vHpjOX4KrxfUWgNCgFjI2+ms0Zv/IYYKlPWDTC4EHdZIReKDy0DIPajIW5i5T7gi+iBAFGYxWCSnaBKW3OrXgNzdip3bgZmt5eSYrWHZgYJOEA87NWIbG7uN32OXIGZ8gj6lGopZKa3ZYMYYREMraqSgSQA1Z3BiYjDQWxZVjlNDavjczXhsRbyNeHaHnIBTfvw+ne9+61c+t2u8xJfekixKZclB4O+HgrntXtm4NuDEhgnYuxK5WdIiTKyCipP6BRvg/aImDkptnJ5PElEMIaDPz3aLnEL2ziis6U3TNMhIRcAWavJ+oJmw17jqTO2KA3WvS+F1gLJMlYto+O+5Exp6bB1HT6z0iKHakvfmjhKNc32j4G804DiIHTE7cglne1be6N+HAsCC3sJ4r5OYq3WUr0iayhd44QDmaqM++tcF2zN1cKE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595b406e-dd2e-4ff5-227d-08dcecb64041
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 01:11:08.7257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pp+zpkD+yxq3NPbzF8Zqlz5w3H7Q0Ijrj8TmPtWP9Sh9W+8MH2pep4O7aje3+B9cBlFMDanS4IzvuU9sqO3fTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_19,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150006
X-Proofpoint-GUID: MNVJIglt82S2yNlKwaL9tlhFr9bWgWVI
X-Proofpoint-ORIG-GUID: MNVJIglt82S2yNlKwaL9tlhFr9bWgWVI

* Shuah Khan <skhan@linuxfoundation.org> [241011 18:52]:
> Fix the following -Wunused-result warnings on posix_memalign()
> return values and add error handling.
>=20
> ./shared/linux.c:100:25: warning: ignoring return value of =E2=80=98posix=
_memalign=E2=80=99 declared with attribute =E2=80=98warn_unused_result=E2=
=80=99 [-Wunused-result]
>   100 |          posix_memalign(&p, cachep->align, cachep->size);
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../shared/linux.c: In function =E2=80=98kmem_cache_alloc_bulk=E2=80=99:
> ../shared/linux.c:198:33: warning: ignoring return value of =E2=80=98posi=
x_memalign=E2=80=99 declared with attribute =E2=80=98warn_unused_result=E2=
=80=99 [-Wunused-result]
>   198 |          posix_memalign(&p[i], cachep->align,
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   199 |                                cachep->size);
>       |                                ~~~~~~~~~~~~~
>=20
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  tools/testing/shared/linux.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
> index 17263696b5d8..66dbb362385f 100644
> --- a/tools/testing/shared/linux.c
> +++ b/tools/testing/shared/linux.c
> @@ -96,10 +96,13 @@ void *kmem_cache_alloc_lru(struct kmem_cache *cachep,=
 struct list_lru *lru,
>  		p =3D node;
>  	} else {
>  		pthread_mutex_unlock(&cachep->lock);
> -		if (cachep->align)
> -			posix_memalign(&p, cachep->align, cachep->size);
> -		else
> +		if (cachep->align) {
> +			if (posix_memalign(&p, cachep->align, cachep->size) < 0)
> +				return NULL;
> +		} else {
>  			p =3D malloc(cachep->size);
> +		}
> +
>  		if (cachep->ctor)
>  			cachep->ctor(p);
>  		else if (gfp & __GFP_ZERO)
> @@ -195,8 +198,9 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, =
gfp_t gfp, size_t size,
>  			}
> =20
>  			if (cachep->align) {
> -				posix_memalign(&p[i], cachep->align,
> -					       cachep->size);
> +				if (posix_memalign(&p[i], cachep->align,
> +					       cachep->size) < 0)
> +					break;
>  			} else {
>  				p[i] =3D malloc(cachep->size);
>  				if (!p[i])
> --=20
> 2.40.1
>=20

