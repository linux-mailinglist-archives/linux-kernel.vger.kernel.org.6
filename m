Return-Path: <linux-kernel+bounces-368460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75689A1001
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A6F4B24851
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B66018732B;
	Wed, 16 Oct 2024 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kRa75eqr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aMVTDijG"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D347136358
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729097167; cv=fail; b=MOizRxRPJKoHdtFPKpWMKsKPLOlghB2lWfFGLLAJbyqI5CbLcAOCnAnIPLJRHmASbK9W+3/EedVP08Ce9M8YUU5wrMVHc3vi6snxNRBk0maZRytUXM5hPHyEDsHZwrZQG/Y+99zoJ2wU37+L5lm17IIppB1FYGLCUOMqutaLWGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729097167; c=relaxed/simple;
	bh=4awo00ca92fbtb+L6b1jjMTD7O0rXzAaBB9Xj1AV8C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ND0mZXJn7hQJyiw/HTi1YcRUhk73BChwjMclZ5c+zho+dUuCKIKMCj+hNFhK8MLsI1ikYOWewhOQaqbnc0g9JDet76qib/1XzWuo3vkRcfj4Yu8uN6cyOgYgsjQ4e4HabbTEJomj+3Iy1D24baOySo9BulMiaSZYzD1FJjXLd+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kRa75eqr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aMVTDijG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GGBgmf017880;
	Wed, 16 Oct 2024 16:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BVmGttl5WutzRv4lLv/m8eYToQGT1EIplVAChfMVSXQ=; b=
	kRa75eqrCE72+/Jnt2yPNQczl3kzIhaHQYzvWpeWXmca6plAEYC46hcu5jnW+6IQ
	g7J97fpfrZMy5IJQBNlUhnx7wB9wYXP9FX4TzR7UyDwkLFgum12cYl/hJ9srj3ZT
	VRsYD5X97wkTxsjUeq9cPaUFLBQT8Ljsy9m6I3ESiA64S+lGQ6LqN4xU9Y2DaHUy
	yyHxUIRDWewN+73ye2OJGL3c8gIxx4qK05CA/LgVFRuH3KoRBSUfiO3uMicURfMB
	OV03Z52az77uiPlJfB/6HgjYNGtzWPR2V+7Dnq0qB8PfHLfA10bXI9Yykuaqm84O
	laycRChB4JFcvjc09Xunjg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhckww0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 16:45:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GGanWm019884;
	Wed, 16 Oct 2024 16:45:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj93tdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 16:45:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzwTlEcVuq2TMiJtBxyg2Qw4stHmLs8C8MAdj17t6GEmiVMqQ+pmPGCqUQd7RaiIlkbgCyC5ssIYmjOjldVmzXiX3zoHlSaNk5ZT789Dt+PblXmzC2quS8mRLaeABJ6w8wEjJxtsbFJwBtpoLtyX+JO/EPjK2x3kzCdtoEYfcLqkV/H9Ylaz+6vw4Kei/jTEOAxBXAjn9BsPAzrqKRrEG1NnNEh0vV8HNHIYYMZ4wMjalSeXOsYrHBPyTw7qu269UB2ypYP5bA9DCkh7qiWXplPVPbcYT0w1XLZXpkYSVa630/344c0/tqpj2HKxGYd2v/JzmFBTdt5YWw0uwLDu/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVmGttl5WutzRv4lLv/m8eYToQGT1EIplVAChfMVSXQ=;
 b=qBbrVeEAIJZDfF49faK0FLYVSd/wxtOZkDfzBJE7NHVloeAG+LKGJMb0aK8lgESHXLRMNdJygZ9ASJTOpsp8oA2hzzC31fWtfLMmMQJswwIsumf0NYSbQMhpyyRwf+AGVGv6Gm9sci/urLpu8ke+x1GPLmCe7AVw1zTUFSYdIOxSqKjNRuirHMs1FG6kz5q3Jax1u6QubNJNnjlChzOTp9BaqTyXXvbOSeZonrxjOOxLrwEAjIATPr1pzPSwQsBCw5jR4zH3GJihRiMY2fpqxbgcIeJh55ICozI19rYKybE9LxJ1RCYP2dUBGZ1dlJotlhrPgzeZjKOi1TjqnapDmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVmGttl5WutzRv4lLv/m8eYToQGT1EIplVAChfMVSXQ=;
 b=aMVTDijGxEAKpwklvsiSA3yhJzQ7v+jWgf8X9PnUWk1cB0vNS1bb2GLnQ7U4Ft42z7KfNTjaev+nmqBaFm+L5IO+Ut5uh8OTZKex66RCO8EEmqRD8sN0uyNh6c20fOnx7er6hT3pPeQryMY2EuOjowdJtJ+GST1GwQ1LWqSUhS4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BY5PR10MB4305.namprd10.prod.outlook.com (2603:10b6:a03:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 16:45:51 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 16:45:51 +0000
Date: Wed, 16 Oct 2024 12:45:49 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH fix 6.12] mm: mark mas allocation in
 vms_abort_munmap_vmas as __GFP_NOFAIL
Message-ID: <tzvhz2bdmnuhcz6o6tqcdvkdbhjvptsaqzcv5acxqyhjevztvd@grkw6pqthovb>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20241016-fix-munmap-abort-v1-1-601c94b2240d@google.com>
 <3lixuwepwvc6zqy57k2zcw4dntd7cc5cwlx7xxoieuo3pvaajy@e2p5zf5mdzon>
 <CAG48ez02xVZzOwfx869pEh+UhRvbpq5Z4RVz_Y-S-i6Hm21Jdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAG48ez02xVZzOwfx869pEh+UhRvbpq5Z4RVz_Y-S-i6Hm21Jdw@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0014.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::17) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BY5PR10MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aee3c6c-14e4-4275-08ed-08dcee01fe42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dS9lVE5yUncxYzdsOXNjV2ZSeWRTQ3J2R3ZuWGVxdE9OSlpDRzN2RHRmSkE1?=
 =?utf-8?B?dk1KOEJXcm1CRUFya1Blb3JQbXl6ejkrY3BTZmc5TXdHSHJsOVJ4blBTMEVt?=
 =?utf-8?B?U0hKZUo3aXl1dFRCbWZvdzVCb3Zrakt2Wno4WmNpUHl5L2FBUFZDNEZodXNi?=
 =?utf-8?B?cmhKVWIxUVVxTU5YNXg3blZhZjM3SVpYVDFKS1B4WnVISjl6bmtaaURpbXAx?=
 =?utf-8?B?TWorYWM1Q1FuMWdjRS9DNTl4TlBlUE92bHVrUWplUHFFYWV5bUV2YzRNeHEw?=
 =?utf-8?B?N3R2U3k3Wlh1MlQ5OVVyZzNkSTE5TXVZZWtVN1pYNG9CY014Ui9NZ054MmRL?=
 =?utf-8?B?ZWNoQ2YycGhwR2lFQ3BYemJkeVJPV1Y5dFRjdkJpM25qMGZUazVyWGpUVlZi?=
 =?utf-8?B?TGthYk5LZjlxU054T1Z0eWJ5ZzRmLzNpVEU5MVVWTzR0SzI0Q1JZcE9sQ1hz?=
 =?utf-8?B?OVIwWkx0YmNJN0U1S3l5ZlVOOFZQNXlyK082ZU9aQWlkU2hpLzhlMGtoUHJm?=
 =?utf-8?B?cDA4TzFpTm9kMVFCQlM0a3BtWVBQaUxHRWMzZm5aSnFCK1RWRGN1RUIrWTk4?=
 =?utf-8?B?NzIzb2ZoUUxnSHE0RlJIdEpZN2RVbFh2dFRucHpvb1cvQlZkVjY5WnpmK2ZC?=
 =?utf-8?B?YnV3b3krRkYwYkFDTUR4UGkweFJrdkVDdnQydTJtcHJMRTFnMWp0QnhZUXlR?=
 =?utf-8?B?cjQwT05JcWxCalpqMTNValcxNjVnNTZwa1JLMlNxSGN0N2t4K21DbklPWnN3?=
 =?utf-8?B?N1ViUHVrU3VlU2RKVmxRK1NrOUtScW54cVd3ejh0Qjk3ZTAwbEZWcGcyakpN?=
 =?utf-8?B?OFlWcmN1S0s5eXBHVTJIeDlCQ1NWVjk4N0tGTWtnMmtkVWRUbWtxeDZCd3g4?=
 =?utf-8?B?K0RUVFQ5dUp6Q0pWZUswNjhNWVcwa3dQOVhnZXp1elFGZHdkeWNkbmR5QjU0?=
 =?utf-8?B?V0tTK0J5MFdQYW0vM0lSSmx3L2xhNHdNTEZyNWlHdDU1d1J5SVlVM3lXL0RU?=
 =?utf-8?B?QUllU3NROURYNjR5U0Zrc2VnZ3NKRlNycVZUbk9MYTk3dEh2U3dKMHNNSCsw?=
 =?utf-8?B?MnZjZEVacTFEM2VEUk93RGhudE04VXMybHdpb0U1SVJXMlNnZTg3ZkpzOC93?=
 =?utf-8?B?TXFTQjdYZkdYVmhsTWVCb0kyckdBV0JadlVBQmw2NjBLRGdkQWJtc0k4SXY4?=
 =?utf-8?B?b093Y3NodVFNOC8rR2M5TlVsMS9xczh6ekZhWms0Nm1Sa2pGc3NLQ3U4TWhV?=
 =?utf-8?B?QVZvVElIRlFCSldObldKWi9MLzBTS29jcE5OckNhM1lrdUxkcVRONVFUelVU?=
 =?utf-8?B?a2FoSStJMGZxTjJjN3BJZHlmVnZuclFrdStySVdJb2ZRaEEyS0dXL1h3Z0py?=
 =?utf-8?B?ZkowQWNwcG8wcEZYQ0JYWWo2VmVRaXhRWE53VE1BTGpWN3RoQWtFKzhPSk1z?=
 =?utf-8?B?UUZkRmtIRDRkbjlpa0JMckFnN0JScjh4TVlwRlNPTDg0VjZ2Y2xJMU1vSGR0?=
 =?utf-8?B?bzI4ZE8ySnFUS2RLcHpVUXZOc2d3bk44dkRGMkdmeHRpcTlzRExEVkZwSlZP?=
 =?utf-8?B?SS9NWTNZclZsT2NNdUIyY1YwVnRRNUdocU9aL3ViMTVmelpuRG1mNXhUODdR?=
 =?utf-8?B?Mm5wUEc0N1doa2Q0M2Mzek1DNU5EZWo0UFVEeEhhWTQ4REo4STJRb2VKRlIr?=
 =?utf-8?B?a3N3aWNweExlZGozWjZhWlVORVZ5b2RMRW5GWlBham12aHdETk9aR253PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHd0OU1yRWpGQUdMT1JqMDVVb3BZQXRxUm55bU95OGFGYmFTbEF1NVhqbWJs?=
 =?utf-8?B?K0p2RHRWRE5FVit2bjdGaVBKbE1td29VMmVyV1FkM29NTWNrejJvV0hZcVdI?=
 =?utf-8?B?L3lndzRFbzZuVHFLNDNzdVZFTlkrL2VUc2dCMThHSklOb3dQd0JkZzdtaXJT?=
 =?utf-8?B?ZkV6RkVUWWwwb09JYlBhUVMrdjdBczh6WUhaTUFJQWNDb0puOG5UdE11V2J2?=
 =?utf-8?B?ZHp2dDJoM0krS0xkM01ybDVrSy9nVUlod2FSY2xBS3ZES3hNZWxLSEgyYitT?=
 =?utf-8?B?MWhiSDNhSXdLL0NNbk1WejNQVGkzZ1JYUGpTcklYcm9PZHh2SGU3Vk4wcFFr?=
 =?utf-8?B?cEpSS0lLVU1BN3pjWUd1enoxenhONEgzN05qWndRM0xoZVREelBjL3pIZjk1?=
 =?utf-8?B?M3ZuSVp6a3RqWEJFNHE3Nzl5My82bFFFRlRKbHB6d3c4UkQ2QkE4YmtRQUlI?=
 =?utf-8?B?OGVSVm1IYVVTd3JGY1NvTXh2TWlwQTNleEpGK2V3c3RFT3JkTHU3ZVVLa0ls?=
 =?utf-8?B?UkxGYjJzZ0xwbi9OQWZkcUcraTBnNUFwbnpMcDJoM1pwV0JhcDNPNXZidW5S?=
 =?utf-8?B?a0hTY01pMkJaN0V6UFk2NGQxSzVWcHhtVnlDcXAwbEtJcFh0UHJwLzJXT1Bw?=
 =?utf-8?B?NlU3TytwR1NLMTBlaDhlRXRNNkg3TE94SktuQlptanltN09meXEvNUROZXdm?=
 =?utf-8?B?RXF6UzJSd2ZmVVdndnljN05tRnF1UDdGRlkxaGFMdVJIRmg2ZkZVckViY09X?=
 =?utf-8?B?RHdyMUxBUmZWRktQMzhvVVBtYmhCcDk2dkN2ZEtMTnZBUU04eE84b1lJUjFw?=
 =?utf-8?B?azZkK1luRG1uMHRpUlNVVjhVS3drNWtvaDBJZXZlTzRvRmxqM08yOHY3djRm?=
 =?utf-8?B?bWRmajRPM2dsZzNJdWdRaFZzeUIxSzVaVGp0T3ZVdzdyNEp3ckgrZGR6Wkg3?=
 =?utf-8?B?c2Q2T1gxRTdJekVPcmJCMWllQmhUOXdPNkt3Y1ZNemloYnRmSXdqYUg1NmJr?=
 =?utf-8?B?OGdBZGJBMVo1T1NkK05JN2laalorTjVMSk4wRitPcjgwQXEvekRuck5sRjdl?=
 =?utf-8?B?WVQwQWgrQSszaUtYKzcwc2I4OUtib29NTlNxUnlJMnl4a1V0RnA5Qmh5KzBK?=
 =?utf-8?B?eUpTOU55NENEeEw1aCtSdittSHgwR0t5U01mZEExSGdxMkcyNDdDeVN6UUkx?=
 =?utf-8?B?aU42RlpqQzFMeE50S2JyZTRERE9GSEpOZ3ZCZkR5WWV2ME1VZy9YcHh4cGwr?=
 =?utf-8?B?STlMK0VCT2x4T0g4cDA3U0VKdEpMOURlZXFZUFZvZ2RKSFNNMlFhbk1SeEs1?=
 =?utf-8?B?M3hwZFNVUzZKRFIxWVVHNXMrczIvNU5TYkk2cVlGTWU1clA1cXJET20rWjJC?=
 =?utf-8?B?NG9MSG1SWU9NT21CbG9WUERBZkpjMXNacXhCelZkb1FnSnFjckVaWThLNmdp?=
 =?utf-8?B?aWhTZkxGNmhhTHpIUXlsT1k2cVFsWExwWm1oRWFpWFdMc0RLdEFENWV6MWZr?=
 =?utf-8?B?dU42M1JPZmloY2tjMEZMSmhVSEw4aUtVU1hQcDVuZi9iemhxVlFDMHR1WTA4?=
 =?utf-8?B?K0N3dlpCQ2dMMTROa0JjZ1d3WE43bGl2QTJaR3A0ekJUSjhFd1FWak10bTJl?=
 =?utf-8?B?SVJ0UHMyOG9CVWZxV2RpQktET0Y5VWcyVFVjNlY3WUYvSElrQ29QemoxOFVX?=
 =?utf-8?B?Ly9wTTY3Z25wU0hwcTRYUkZ6cEV1TFpRM09EL1o0N3grdEM1WTI4dURKWDlt?=
 =?utf-8?B?eS9tYVZqdEZkaENoRENDWUl2QUFGNk1LVXZ5MDc1RXZpcUhqUCtXVTFJam1D?=
 =?utf-8?B?MUN0N3BjQkpncGFwOEEwb3pDQ3hPdzVZbEtwdmI2cGlNNzRIcUhIVHFYRThK?=
 =?utf-8?B?b2xuaWhJWktQaGYzNzZCOHJWZ1ptV3VBWGhXcXhvaTRaSUhQeFpWcVh4SVBv?=
 =?utf-8?B?bXh0bE9kYWh4QTBVU3FGZ3ZCV29aQVh3Q0pCRVUwWThxWDFqM0ZnL2ttV3pK?=
 =?utf-8?B?WDdSRTBYcm5mekEvN0Vyem94bFZzUHB0TC9vek9OOTc0Q2NCamJCdjBidlh5?=
 =?utf-8?B?SkxmZlZZTVVIWkNRZ1ExR1JxK1J6N3g0Y2JsNDNlTE1qcDFkcmlTZnJTYjZ6?=
 =?utf-8?B?b293aFlyQTNvQ2srOE42T2xwWWpLZWVHMUFPT1RyejM4ZDFNOExuRDFSYTZi?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FjOM02xepIWtUKHk4LPusTEknpNQQ7AQu6XbpVijQU4aow+649xU6vXvXedjrzzjJGZ6AottiLao9emEpM3v7rpDrPUgTzFJTH3zQg/wrlrx3+yyACn1eeZnZ+Q/m/WO7bE+hJZQwjK0YAnEiM79/SEqWy/9p7GAVkihZ843/h/o7ulclqUVbuxO5g/RBl9Xgbm4uSNlqCINO510plcioGdqjVvdsYzw1ex6JkibM7DaUpPOcnLuitd3Rg5HHztl5pKtaLTDsn9HZyO146iGvcKVscGOs4mc4gj0B3ANjLHYzmbV/Hh4OEZB7HYJWR6vuTs1a0JuSVPnnPXHYBsrFj+NaaqErGpoltFnBeVuSQGsrNOLUUb6oxJsEhQQXylvn6ja/zIaMf90bSMCnugLFdCmLvqpH9oNfK2E3lbBv507NJcSUkKq6bXkzfhg/RYEtw6xNtHKcwWHncAl34X85hRKn73VwsQwWePtBkNTX5+m3f9SLO95iwf3zAVa3XNydVVabF04ayb3VztDW8hmHX8pvWPVEgF1j0Wd3hut6cicpzirBUgBMzpCv1mHcBinW8fi3ZSFQ94KrAcvfbmKUMMwZUs6K+n/6gJ3rzetQA0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aee3c6c-14e4-4275-08ed-08dcee01fe42
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 16:45:50.9903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQdYtaz/Ng97uRDZZ+dnxqjkbdhzae1clEHC5i9jq4KPN3J65EYEwQZVm7iIigOkKXmeh6sK3GHhC+7JL0jWsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4305
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_13,2024-10-16_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160106
X-Proofpoint-GUID: AAu4lCJlCcLNlZ96Ij2OO0fihZX0acdZ
X-Proofpoint-ORIG-GUID: AAu4lCJlCcLNlZ96Ij2OO0fihZX0acdZ

* Jann Horn <jannh@google.com> [241016 12:04]:
> On Wed, Oct 16, 2024 at 5:40=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> > * Jann Horn <jannh@google.com> [241016 11:08]:
> > > vms_abort_munmap_vmas() is a recovery path where, on entry, some VMAs
> > > have already been torn down halfway (in a way we can't undo) but are
> > > still present in the maple tree.
> > >
> > > At this point, we *must* remove the VMAs from the VMA tree, otherwise
> > > we get UAF.
> >
> > Wait, the vma should be re-attached without PTEs and files closed in
> > this case.  I don't see how we are hitting the UAF in your example - we
> > shouldn't unless there is something with the driver itself and the file
> > close?
> >
> > My concern is that I am missing an error scenario.
>=20
> Where are the files supposed to be closed? vms_clean_up_area() unlinks
> the VMA from the file and calls ->close() but doesn't unlink the file,
> right?

Correct.

>=20
> FWIW, I tested on commit eca631b8fe80 (current mainline head), I
> didn't check whether anything in the MM tree already addresses this.
> (I probably should have...)

I have not addressed this.

>=20
> > But since this is under a lock that allows sleeping, shouldn't the
> > shrinker kick in?
>=20
> Yeah, I think without error injection, you'd basically only fail this
> allocation if the OOM killer has already decided to kill your task and
> the system is entirely out of memory.
>=20
> OOM kills IIRC have two effects on the page allocator:
>=20
> 1. they allow allocating with no watermarks (ALLOC_OOM) (based on the
> theory that you might need to allocate some memory in order to be able
> to exit and free more memory)
> 2. they allow giving up on GFP_KERNEL allocations (see the "/* Avoid
> allocations with no watermarks from looping endlessly */" part of
> __alloc_pages_slowpath())
>=20
> > Should we just use __GFP_NOFAIL for the first store
> > instead of the error path?
>=20
> Which first store? Do you mean get rid of vms_abort_munmap_vmas()
> entirely somehow?

Yes.. but there are other failures throughout the function so I think
this is the best plan.

>=20
> > > Fixes: 4f87153e82c4 ("mm: change failure of MAP_FIXED to restoring th=
e gap on failure")
> > > Signed-off-by: Jann Horn <jannh@google.com>

Thanks for fixing this.

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> > > ---
> > > This can be tested with the following reproducer (on a kernel built w=
ith
> > > CONFIG_KASAN=3Dy, CONFIG_FAILSLAB=3Dy, CONFIG_FAULT_INJECTION_DEBUG_F=
S=3Dy,
> > > with the reproducer running as root):
> > >
> > > ```
> > >
> > >   typeof(x) __res =3D (x);      \
> > >   if (__res =3D=3D (typeof(x))-1) \
> > >     err(1, "SYSCHK(" #x ")"); \
> > >   __res;                      \
> > > })
> > >
> > > static void write_file(char *name, char *buf) {
> > >   int fd =3D open(name, O_WRONLY);
> > >   if (fd =3D=3D -1)
> > >     err(1, "unable to open for writing: %s", name);
> > >   if (SYSCHK(write(fd, buf, strlen(buf))) !=3D strlen(buf))
> > >     errx(1, "write %s", name);
> > >   SYSCHK(close(fd));
> > > }
> > >
> > > int main(void) {
> > >   // make a large area with a bunch of VMAs
> > >   char *area =3D SYSCHK(mmap(NULL, AREA_SIZE, PROT_NONE, MAP_PRIVATE|=
MAP_ANONYMOUS, -1, 0));
> > >   for (int off=3D0; off<AREA_SIZE; off +=3D 0x2000)
> > >     SYSCHK(mmap(area+off, 0x1000, PROT_READ, MAP_FIXED|MAP_PRIVATE|MA=
P_ANONYMOUS, -1, 0));
> > >
> > >   // open a file whose mappings use usbdev_vm_ops, and map it in part=
 of this area
> > >   int map_fd =3D SYSCHK(open("/dev/bus/usb/001/001", O_RDONLY));
> > >   void *map =3D SYSCHK(mmap(area, 0x1000, PROT_READ, MAP_SHARED|MAP_F=
IXED, map_fd, 0));
> > >   close(map_fd);
> > >
> > >   // make RWX mapping request fail late
> > >   SYSCHK(prctl(65/*PR_SET_MDWE*/, 1/*PR_MDWE_REFUSE_EXEC_GAIN*/, 0, 0=
, 0));
> > >
> > >   // some random other file
> > >   int fd =3D SYSCHK(open("/etc/passwd", O_RDONLY));
> > >
> > >   /* disarm for now */
> > >   write_file("/sys/kernel/debug/failslab/probability", "0");
> > >
> > >   /* fail allocations of maple_node... */
> > >   write_file("/sys/kernel/debug/failslab/cache-filter", "Y");
> > >   write_file("/sys/kernel/slab/maple_node/failslab", "1");
> > >   /* ... even though it's a sleepable allocation... */
> > >   write_file("/sys/kernel/debug/failslab/ignore-gfp-wait", "N");
> > >   /* ... in this task... */
> > >   write_file("/sys/kernel/debug/failslab/task-filter", "Y");
> > >   write_file("/proc/self/make-it-fail", "1");
> > >   /* ... every time... */
> > >   write_file("/sys/kernel/debug/failslab/times", "-1");
> > >   /* ... after 8 successful allocations (value chosen experimentally)=
... */
> > >   write_file("/sys/kernel/debug/failslab/space", "2048"); // one obje=
ct is 256
> > >   /* ... and print where the allocations actually failed... */
> > >   write_file("/sys/kernel/debug/failslab/verbose", "2");
> > >   /* ... and that's it, arm it */
> > >   write_file("/sys/kernel/debug/failslab/probability", "100");
> > >
> > >   // This mmap request will fail late due to MDWE.
> > >   // The error recovery path will attempt to clear out the VMA pointe=
rs with a
> > >   // spanning_store (which will be blocked by error injection).
> > >   mmap(area, AREA_SIZE, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|M=
AP_FIXED, fd, 0);
> > >
> > >   /* disarm */
> > >   write_file("/sys/kernel/debug/failslab/probability", "0");
> > >
> > >   SYSCHK(munmap(map, 0x1000)); // UAF expected here
> > >   system("cat /proc/$PPID/maps");
> > > }
> > > ```
> > >
> > > Result:
> > > ```
> > > FAULT_INJECTION: forcing a failure.
> > > name failslab, interval 1, probability 100, space 256, times -1
> > > CPU: 3 UID: 0 PID: 607 Comm: unmap-fail Not tainted 6.12.0-rc3-00013-=
geca631b8fe80 #518
> > > [...]
> > > Call Trace:
> > >  <TASK>
> > >  dump_stack_lvl+0x80/0xa0
> > >  should_fail_ex+0x4d3/0x5c0
> > > [...]
> > >  should_failslab+0xc7/0x130
> > >  kmem_cache_alloc_noprof+0x73/0x3a0
> > > [...]
> > >  mas_alloc_nodes+0x3a3/0x690
> > >  mas_nomem+0xaa/0x1d0
> > >  mas_store_gfp+0x515/0xa80
> > > [...]
> > >  mmap_region+0xa96/0x2590
> > > [...]
> > >  do_mmap+0x71e/0xfe0
> > > [...]
> > >  vm_mmap_pgoff+0x17a/0x2f0
> > > [...]
> > >  ksys_mmap_pgoff+0x2ee/0x460
> > >  do_syscall_64+0x68/0x140
> > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > [...]
> > >  </TASK>
> > > mmap: unmap-fail: (607) Unable to abort munmap() operation
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > BUG: KASAN: slab-use-after-free in dec_usb_memory_use_count+0x365/0x4=
30
> > > Read of size 8 at addr ffff88810e9ba8b8 by task unmap-fail/607
> >
> > What was this pointer?
>=20
> Should be the "struct usb_memory *usbm".
>=20
> > >
> > > CPU: 3 UID: 0 PID: 607 Comm: unmap-fail Not tainted 6.12.0-rc3-00013-=
geca631b8fe80 #518
> > > [...]
> > > Call Trace:
> > >  <TASK>
> > >  dump_stack_lvl+0x66/0xa0
> > >  print_report+0xce/0x670
> > > [...]
> > >  kasan_report+0xf7/0x130
> > > [...]
> > >  dec_usb_memory_use_count+0x365/0x430
> > >  remove_vma+0x76/0x120
> > >  vms_complete_munmap_vmas+0x447/0x750
> > >  do_vmi_align_munmap+0x4b9/0x700
> > > [...]
> > >  do_vmi_munmap+0x164/0x2e0
> > >  __vm_munmap+0x128/0x2a0
> > > [...]
> > >  __x64_sys_munmap+0x59/0x80
> > >  do_syscall_64+0x68/0x140
> > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > [...]
> > >  </TASK>
> > >
> > > Allocated by task 607:
> > >  kasan_save_stack+0x33/0x60
> > >  kasan_save_track+0x14/0x30
> > >  __kasan_kmalloc+0xaa/0xb0
> > >  usbdev_mmap+0x1a0/0xaf0
> > >  mmap_region+0xf6e/0x2590
> > >  do_mmap+0x71e/0xfe0
> > >  vm_mmap_pgoff+0x17a/0x2f0
> > >  ksys_mmap_pgoff+0x2ee/0x460
> > >  do_syscall_64+0x68/0x140
> > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >
> > > Freed by task 607:
> > >  kasan_save_stack+0x33/0x60
> > >  kasan_save_track+0x14/0x30
> > >  kasan_save_free_info+0x3b/0x60
> > >  __kasan_slab_free+0x4f/0x70
> > >  kfree+0x148/0x450
> > >  vms_clean_up_area+0x188/0x220
> >
> > What line is this?
>=20
> Should be the vma->vm_ops->close(vma) call. (That would call
> dec_usb_memory_use_count(), which tail-calls kfree(), so the
> dec_usb_memory_use_count() wouldn't show up in a stack trace.)
>=20
> I don't have this kernel build anymore though, sorry. If you want I'll
> rebuild and get a properly symbolized trace.

Right, so it's the driver.  That makes sense.

Your patch is the best plan.

