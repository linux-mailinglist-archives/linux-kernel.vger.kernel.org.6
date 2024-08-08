Return-Path: <linux-kernel+bounces-279974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D0F94C40A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B781F260BE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB81F13D8A2;
	Thu,  8 Aug 2024 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K2JOik3H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TkwYuQRo"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCC733F7
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723140154; cv=fail; b=OVK3ml6F+yxrD0iwxBlzfwENLiTt60WuxzQ2XiQTPtlEBj//pXbDYemIi2p7XI3No5SHsF/JhWxgPDBKvpvc3IuzgXogq9O5Hc5e+lt7iLhFrWXWvl1VBRFxWOD3V+JCmIPWzYFwLxDoX962Hs6JJb6rGald8lOoivhcFMk5HgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723140154; c=relaxed/simple;
	bh=jWTjl76RAKifydZPpAtjva1pV1dKUev9cB1Ah2tmiyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RKClZjrHvsyCURXnUWJviXjXVVfbFKwoKzbZZZfIjTIE+JfmPWByEN/ZhjbBV0ENKefcJAh8wWcH5s22Zed0KyNag7APzonp3woXpO+FA796VFpU0iS5hpV2CRNOS+S8fcLvVkU3tgbySrm0ItNeaQ6Ycv6Fxx4+rVt/LhGQJbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K2JOik3H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TkwYuQRo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478HfVev018724;
	Thu, 8 Aug 2024 18:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=v02FmSgsUJplaJH
	QcEIsHP9meBKWfjrU72Qjen1eMzs=; b=K2JOik3HXSXGQwdaZw8ScfmQH6QKr0y
	9nJmtFDNyukWoxsYA9qn8Wx1UjLHz6r/q5jLtmbadXym8ofT0HrxEgR/yRuhgDN8
	UHCei5cAcyGqcfZzcVpMA1U9/AZZ+CUAAnBSZ9OGpMtK/tPBMoC/GLSS+00YG/3H
	ZexK1pfOPxI/08KVwo1yE0Yr6ekha1wBwiPbXIrl/iPN89ZU2C2ptEcq5oMuhVLq
	nHFbGea56N04UCaIjXacnwJ6Cco5SJSyKCiW6mObCJKgc8xSK8yDbaniagGRO/o8
	Db5TrY0t5N1eFCLZYOMZN7+C454qb7Sh3TqiVpfvZ2lWdwr74HidjYg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sayeab2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 18:02:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 478Hp25T021755;
	Thu, 8 Aug 2024 18:02:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0hy6yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 18:02:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLV6hRy6FNHx5okk+QgaULc84uSF1Rq/EZCoQcVkheX2nrHG13JRah8Bl3O51PAZD6Qc123DbolFP5zBfQZ8wi2inm3ZE629HQMRro9nsN14rwxnG8a66/14+d1WnywrRbqpplKHx6p26GIrRkI2V5yB99KT00OVWCpOIyUxFUI51qChpjJYpvirxWsr1V7tKVcUO0t3dvA9iwMsBNoRIJAXCa4KlUKckHFLQ/gQ8nHWYp1hWp84GhBUeK4FOLucHKiOaF93+77CkZq0qqSo1bQDSYwekhqCVxW3KFw4qtBb+6atZI1fyz4H52QGiwJ/LrR1buDSmb7c1vp6MPysFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v02FmSgsUJplaJHQcEIsHP9meBKWfjrU72Qjen1eMzs=;
 b=FrP/XJAeDviyjhOJKLN0WYxER1tASUMIgRuNAVVw+zs72VMVn//yeTss0dNoKJAhhJbtxARj2qnYTMjkXRcsMqx6deysv/hPUFIDxhVHgU5Mw5pX5F7U0WV60uv7ccnrv4Fxpyk6Kuj1IfdxRgYdvo3VYCtP41k8/TF2R8yi7N6JXFxCg16OZe0EENQbJ9fHRi7fEWW3RKjtGyacNE0VDL8D+QBBFFkWAw0TLY1+OjQyd6Tx0S/neTZvY8LYRMrRUEYOSVeSSvcf0OFK/zAz/VzfRIo7psDbFnyeY+mCZhIizW+BPdBXqQ/jqpBo4r+/GGt3c1+zKdLh/bSHUyJBsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v02FmSgsUJplaJHQcEIsHP9meBKWfjrU72Qjen1eMzs=;
 b=TkwYuQRo17GYtylCaXaZufETIaD2yf6IQmQBHcXtBNbRURj2BsUF28tApP6OFZwRLMIjufw+ZEfXdA1LvONI5M/mjiSwqPI1qfo8XUuKf0Xsi1suastukvsB1QLrAYUgx1WV/ggNKsu2PnES5uuIReiRjozy+Mb/+WK1znkoSOE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CY8PR10MB6657.namprd10.prod.outlook.com (2603:10b6:930:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Thu, 8 Aug
 2024 18:02:18 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 18:02:13 +0000
Date: Thu, 8 Aug 2024 19:02:09 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 07/10] mm: avoid using vma_merge() for new VMAs
Message-ID: <dec849e1-cfa5-4a1b-820b-8dc2ee5a8bdc@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <cf40652a2c3f6b987623f8f11a514618718546f7.1722849860.git.lorenzo.stoakes@oracle.com>
 <28774b9d-b74e-4028-acef-5d4f09a5d36a@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28774b9d-b74e-4028-acef-5d4f09a5d36a@suse.cz>
X-ClientProxiedBy: LO2P123CA0025.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::13)
 To SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CY8PR10MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: dff72336-e743-4167-62c0-08dcb7d43b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3UWf5F5idJh6dguwHHXUnOgfdbJQqdEYtOzl/pAO3S2jk8Ncf6F1hJDnfmMT?=
 =?us-ascii?Q?H5TZP4sN8seGEoheNyv49zlw8hOZPMtXFiFST9ImV4gC0mNAIqb2vZElqp8Y?=
 =?us-ascii?Q?WDOMk1GQW/WT6sx0+nIIvHWKUpwqND2gnvrFMpPE3nu4QFbsv9cIvXewn6gP?=
 =?us-ascii?Q?99suVFHje8u+/qgeYKSGtNfBNssYximuIzdb9WGTfOR29KwxK2PmplDSfQ4Y?=
 =?us-ascii?Q?JaZGxMnE0BWV0f55+vRoDaWLjZTsTa2wf3PjSzyRYzdUl8AWBHD9CiYItYTR?=
 =?us-ascii?Q?OSERqXaohJhUt6UW4lHmiZbliEssV03XJUChtxb8km2ImkjHOJc9ePvb/hWR?=
 =?us-ascii?Q?WvDrP7+Y4L9tNDr/rIV4GMTLIO4zHDP3bSct80+an0V1kj4o6ZSgBI0nYL6x?=
 =?us-ascii?Q?AtBN5Dxfae/ZBFro1CPLVe4V5WNVB1tudtlYte0MQZmSDfEQiJIDlrhpEwWU?=
 =?us-ascii?Q?NY5HlEghiMjQL52WAYtaxBqIymSmj/9eN8ZOM8AVLZFkEJlssazTuQnY4uJA?=
 =?us-ascii?Q?H3/B3bZnTqyS2Z+sr9Bhcx2ALhp72GZrAx8MNPV3sUaRNcqTRSAfKD9A5jp3?=
 =?us-ascii?Q?/dgeYp1L3Oc99uAG71niUmxM2xu2AgLUar/0HG+OvV2sQWuxqa+IGFqTtb7X?=
 =?us-ascii?Q?hkeZinSbPdcDjxoOSuPkecOqYv60lShjPVZjBA37R+4OHMVT9Jcv3Q8Sf9AQ?=
 =?us-ascii?Q?r+gXX2NM2k0uDRTGM1LqfgLeHZZIgiWdo0f4f6igRQYJRIi7tML9gcFQ8ALx?=
 =?us-ascii?Q?tCPl9gb15FsFuayfsTAkApP4BSJpSVnR4t20cts2xkovyJUeYZxpyX+yIkKL?=
 =?us-ascii?Q?FBkAlnAVjvvhP7KIGHfWptoZ3ccGpXCubUtVhrpSSiQbqiMemPakpmlNFJXY?=
 =?us-ascii?Q?wVsLtiDVsiXM7ZdKiFNu1E9Shxkoh8SOdeVhbuWtuha/nVw9JbOC786dZgeY?=
 =?us-ascii?Q?J6p//a57ogwfQl+XSFs+lByQ9Nf7VKV2bByCtbA8izOKMlXEmMbHWmF9Lwsn?=
 =?us-ascii?Q?KLK6+ipB2ZzgABRPjOIKoXkYW9Yw2xoywNLmD3jH4GrlkHBoLD/uZerf2NwO?=
 =?us-ascii?Q?6qf7R6fzoxOQw0vdowVobynkTiCvxbUmz+tDJyEsdZiU2gDYtKIAUXbvROYl?=
 =?us-ascii?Q?gc8qOqzrU8XVaQ0XwV3Wo4IuPj+WjRAPd5ElnRxWMTpWOJiBbEzykYiQk15+?=
 =?us-ascii?Q?7H18RfCm8U6I6bGew+KsEOXvCSXMm28twkY97PXxoa3BoMRCEcuK99H96XFa?=
 =?us-ascii?Q?e6qt55eLzq/58a+WaO9cSHcJj24TceaLTxqmEuf0hlnnuI0CzlBbGGTyK9Qz?=
 =?us-ascii?Q?TJl8JRWXt/uoMNZmyiKmT6VtKC7Y7Z1EGs6T+CUpGkJCAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?slxpxTJiPx/r47Qf1fPr55dqnoVDanSUogtyY5dbWsZIQ8hOUl+/BvUZ4yFr?=
 =?us-ascii?Q?jJCFsmSF3lyoc1qQR9bJkXNX2sgUsR6cAiOjjlajK2DAi08aIQKiEDv/ZieL?=
 =?us-ascii?Q?iEX3HKyfSWrJloVWFoyQCc4Ic7k0C3f72L6W4gtenMYJfvkEVhrmktegip8y?=
 =?us-ascii?Q?ivD4IcmWmudhlGaUhvG3+EQRU2ax7GZ2/zpE6pWXLXOPWY2ymS4LGmLpCf7U?=
 =?us-ascii?Q?zw+2DhHuFNr88fqSb6u/RXJEx3sH9o3IP0FR/E5KGZT0tEoqpS2Hqs+2arwr?=
 =?us-ascii?Q?nOyVLRTgmpI3OS7lTAc/ym2xEltnX+jm/A9VU+EuKqBiqvZe3wpCfVbj6GAy?=
 =?us-ascii?Q?jXE77/aQO1KOjbbS5dn2j1i7dLqZd9z4ff51Hz0suNd1yJxV+3s8yIEaddJC?=
 =?us-ascii?Q?A58rlFPuCMIF7BvWwdx1pqNnRiW6HfJQDJGDUj4dPRshwPnHieDFLx2rRRlU?=
 =?us-ascii?Q?9ITvuXsdxzVRR5McdqMrrn/NJEyVt4hoOI9vMEL+a4XB8plqrU6ES3cRBKQM?=
 =?us-ascii?Q?MKM4LkcLTAlPAhB2WIGzDKTe/qTzYjUA852SiuSnfCdNe5sQJwJRqkOjuj3w?=
 =?us-ascii?Q?skHmb/C+d6+mXnC7ijdx6dfoRqJESfi0GsbJ+/aX6IpSW6YGFX+0SFp+7eNL?=
 =?us-ascii?Q?nXuO3yhmG9eqCnnXHdi7a4/N6OAz8X6spIgHxSuFENMsFQ88Qzxw630eLSAg?=
 =?us-ascii?Q?58QOmxoOG5J1Oywrt0tNeOQH9PmTU+6Y9JenKKg/PTVpukMOfFZSgdP2z6wP?=
 =?us-ascii?Q?6ipv+5tixT1qp/z+qqzaIZTw8b6YnbaHiycfG8Sp9jw6u6fWCwJVjdoAEiRZ?=
 =?us-ascii?Q?nTkGpdFA35Pc9lurOhN67DymfouUzhILzUdsiGPGpV/K2Hti6wbTErWor2d4?=
 =?us-ascii?Q?GY7EjsK8qHfRKpqlTP/uPCcPKwuJT1WwmsKUjfStUpCO7cwy+naZ6NgOWmjG?=
 =?us-ascii?Q?5vHW3xCExiR9G4n18jXBApTeU/hP6rGKUbzq3qNzmxI8Swo6Sbx8DBku6KSg?=
 =?us-ascii?Q?6dkWSKE+hOB3XBDXFNoB+7y/4zwuovfyATUtoBpGSIFFsiRyQzj3OnSwKLX6?=
 =?us-ascii?Q?1Bauja7EvQ/ucu3j98qxmCAOCp3CoT2KwDOEnjahCOnAGyg6tXlrAYSRhTR/?=
 =?us-ascii?Q?1j0S7OeilMsBgolxwEh8DXJaYrh38iayPYoY6mJ8bXbC84wkJ54y69lTieE2?=
 =?us-ascii?Q?fZUht8h08PqEUbpJwnSPvIzfVIqmAQXSM9ZDFAKJN1MdhO0RIg4P4hm9YhQB?=
 =?us-ascii?Q?di7iVBy3oXqLsa5MSQ7Tdk0J4FpYuDV1IFzkPlEarlXEWdBwbEKXWNVluGhq?=
 =?us-ascii?Q?NQvXuIpvhogbKuPoPB4TexuEQWWnbqxyAJiD8XR1E2kjlmuo88rIWrSfJok2?=
 =?us-ascii?Q?ePq0C72a+mpgMo9JKaLY8iq8VWFhLZLhx7h1QEFOMRCvH6G4jcuBcF4Fsrlc?=
 =?us-ascii?Q?QXvPVJcqOTGBaw/MnDw+ID4MCdWh0rvK31iDM2AkuZ4KYnBp0VejA4ca5GNO?=
 =?us-ascii?Q?wEM5hxHJJNoSMa13Q4yzNz9NE3D5Me2OIdr+wgPRtTpqsQPb/FOIdVXJXE9w?=
 =?us-ascii?Q?/4nCSpv4ivYbK3h70pm4njD+Rz1obnFEa3dHs0Z39wJ7i/00OMzLH+PrbMuS?=
 =?us-ascii?Q?2yp0uxz2EvT+UkRNxGEuO01MjAXnBiD2IPCcMJ05nTZRxRouKKr7h2SHsQd2?=
 =?us-ascii?Q?CXvwsw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tvnCGxTibrfhMFyr/gXwq2KdxDOLeOiISdh1tLmzlVaVS7d9WmQ4MQEUQdJcmYzhWzj5QaYAWpGs/0nH7pIQaAekJtBDf2LmyZOS8T+beTVX2Bl3FOcs+DFVl2M257ds972n4+L91eIG4irfHR0m/UKIcq9qY1RmZWPuO2dUqNjre6Yo/Ruk/3Kylllz30jRa9fk41mFZvu4rhh/aRGkTcA7gNaBzEII85KxZ/An6bSfgJRyh79BVhI5Aoy93XCsGfx/2PoWHnuUYHpil+3e/Vq9aw31DE434yphGTL7zPj3cv2z6n/Ncsr0o0pkWtbgPe2KpOXx9M3UFmcmKuEdcLV5tSLqRSxSwO/7f1+0Dsb8ECUTF+EMH/hm5aARtHuikBiDcwW96HTbA6k2D1jXLj/zHfnH+BTU3K+o/eHZyQS+Yfwti9dvs2A0eTA2n5dur/0CDJb8YD6ZIVOVQyQuRYL5t38zKM6GeWEwwnbMHtKOcj/lqY+tXQX1IE7lf3iap9eTPI382AfyPU+gpVrMDKln36RQpNiBJYBHJWeNLwj0f4RiLixYqArMpi4NMLLRTkXjD+519xRORJxee3jT8UU9AfOoXz0IJvgHEQj/ap4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff72336-e743-4167-62c0-08dcb7d43b51
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 18:02:13.7011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWMi0LR8pukKHU41sgRNsA8KPlY8TNAKdDhCst5rnR67S4xHm5mewwjp2Xqu7e1ekNmJDz686WrCJosd+wLjwN+rjuwYhZWsvz49pBnvij4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6657
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_18,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408080128
X-Proofpoint-ORIG-GUID: ssLOWylA1UVzBMc4wx_yOSBprW-Ts9K2
X-Proofpoint-GUID: ssLOWylA1UVzBMc4wx_yOSBprW-Ts9K2

On Thu, Aug 08, 2024 at 06:45:43PM GMT, Vlastimil Babka wrote:
> On 8/5/24 14:13, Lorenzo Stoakes wrote:
> > In mmap_region() and do_brk_flags() we open code scenarios where we prefer
> > to use vma_expand() rather than invoke a full vma_merge() operation.
> >
> > Abstract this logic and eliminate all of the open-coding, and also use the
> > same logic for all cases where we add new VMAs to, rather than ultimately
> > use vma_merge(), rather use vma_expand().
> >
> > We implement this by replacing vma_merge_new_vma() with this newly
> > abstracted logic.
> >
> > Doing so removes duplication and simplifies VMA merging in all such cases,
> > laying the ground for us to eliminate the merging of new VMAs in
> > vma_merge() altogether.
> >
> > This makes it far easier to understand what is happening in these cases
> > avoiding confusion, bugs and allowing for future optimisation.
> >
> > As a result of this change we are also able to make vma_prepare(),
> > init_vma_prep(), vma_complete(), can_vma_merge_before() and
> > can_vma_merge_after() static and internal to vma.c.
>
> That's really great, but it would be even better if these code moves could
> be a separate patch as it would make reviewing so much easier. But with git
> diff's --color-moved to the rescue, let me try...

Will separate out on respin.

>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  mm/mmap.c                        |  79 ++---
> >  mm/vma.c                         | 482 +++++++++++++++++++------------
> >  mm/vma.h                         |  51 +---
> >  tools/testing/vma/vma_internal.h |   6 +
> >  4 files changed, 324 insertions(+), 294 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index f6593a81f73d..c03f50f46396 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1363,8 +1363,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  {
> >  	struct mm_struct *mm = current->mm;
> >  	struct vm_area_struct *vma = NULL;
> > -	struct vm_area_struct *next, *prev, *merge;
> > -	pgoff_t pglen = len >> PAGE_SHIFT;
> > +	struct vm_area_struct *merge;
> >  	unsigned long charged = 0;
> >  	unsigned long end = addr + len;
> >  	bool writable_file_mapping = false;
> > @@ -1411,44 +1410,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		vm_flags |= VM_ACCOUNT;
> >  	}
> >
> > -	next = vmg.next = vma_next(&vmi);
> > -	prev = vmg.prev = vma_prev(&vmi);
> > -	if (vm_flags & VM_SPECIAL) {
> > -		if (prev)
> > -			vma_iter_next_range(&vmi);
> > -		goto cannot_expand;
> > -	}
> > -
> > -	/* Attempt to expand an old mapping */
> > -	/* Check next */
> > -	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {
> > -		/* We can adjust this as can_vma_merge_after() doesn't touch */
> > -		vmg.end = next->vm_end;
> > -		vma = vmg.vma = next;
> > -		vmg.pgoff = next->vm_pgoff - pglen;
> > -
> > -		/* We may merge our NULL anon_vma with non-NULL in next. */
> > -		vmg.anon_vma = vma->anon_vma;
> > -	}
> > -
> > -	/* Check prev */
> > -	if (prev && prev->vm_end == addr && can_vma_merge_after(&vmg)) {
> > -		vmg.start = prev->vm_start;
> > -		vma = vmg.vma = prev;
> > -		vmg.pgoff = prev->vm_pgoff;
> > -	} else if (prev) {
> > -		vma_iter_next_range(&vmi);
> > -	}
> > -
> > -	/* Actually expand, if possible */
> > -	if (vma && !vma_expand(&vmg)) {
> > -		khugepaged_enter_vma(vma, vm_flags);
> > +	vma = vma_merge_new_vma(&vmg);
> > +	if (vma)
> >  		goto expanded;
> > -	}
> > -
> > -	if (vma == prev)
> > -		vma_iter_set(&vmi, addr);
> > -cannot_expand:
> >
> >  	/*
> >  	 * Determine the object being mapped and call the appropriate
> > @@ -1493,10 +1457,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		 * If vm_flags changed after call_mmap(), we should try merge
> >  		 * vma again as we may succeed this time.
> >  		 */
> > -		if (unlikely(vm_flags != vma->vm_flags && prev)) {
> > -			merge = vma_merge_new_vma_wrapper(&vmi, prev, vma,
> > -							  vma->vm_start, vma->vm_end,
> > -							  vma->vm_pgoff);
> > +		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
> > +			merge = vma_merge_new_vma(&vmg);
>
> Can this even succeed if we don't update vmg->vm_flags? Previously the
> wrapper would take them from vma.

You're right... ugh. Will fix.

This is yet another example of how having this _not_ be under test is
problematic, as that'd have picked this up.

I will try to move at least VMA merge invocation logic over in a later
series.

>
> > +
> >  			if (merge) {
> >  				/*
> >  				 * ->mmap() can change vma->vm_file and fput
>
> <snip>
>
> > +/*
> > + * vma_merge_new_vma - Attempt to merge a new VMA into address space
> > + *
> > + * @vmg: Describes the VMA we are adding, in the range @vmg->start to @vmg->end
> > + *       (exclusive), which we try to merge with any adjacent VMAs if possible.
> > + *
> > + * We are about to add a VMA to the address space starting at @vmg->start and
> > + * ending at @vmg->end. There are three different possible scenarios:
> > + *
> > + * 1. There is a VMA with identical properties immediately adjacent to the
> > + *    proposed new VMA [@vmg->start, @vmg->end) either before or after it -
> > + *    EXPAND that VMA:
> > + *
> > + * Proposed:       |-----|  or  |-----|
> > + * Existing:  |----|                  |----|
> > + *
> > + * 2. There are VMAs with identical properties immediately adjacent to the
> > + *    proposed new VMA [@vmg->start, @vmg->end) both before AND after it -
> > + *    EXPAND the former and REMOVE the latter:
> > + *
> > + * Proposed:       |-----|
> > + * Existing:  |----|     |----|
> > + *
> > + * 3. There are no VMAs immediately adjacent to the proposed new VMA or those
> > + *    VMAs do not have identical attributes - NO MERGE POSSIBLE.
> > + *
> > + * In instances where we can merge, this function returns the expanded VMA which
> > + * will have its range adjusted accordingly and the underlying maple tree also
> > + * adjusted.
> > + *
> > + * Returns: In instances where no merge was possible, NULL. Otherwise, a pointer
> > + *          to the VMA we expanded.
> > + *
> > + * This function also adjusts @vmg to provide @vmg->prev and @vmg->next if
> > + * neither already specified, and adjusts [@vmg->start, @vmg->end) to span the
> > + * expanded range.
> > + *
> > + * ASSUMPTIONS:
> > + * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
> > + * - The caller must have determined that [@vmg->start, @vmg->end) is empty.
>
> Should we be paranoid and assert something?

This will have a performance impact, if we do that we'll want something like
an #ifdef CONFIG_DEBUG_VM around that.

>
> > + */
> > +struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
> > +{
> > +	bool is_special = vmg->flags & VM_SPECIAL;
> > +	struct vm_area_struct *prev = vmg->prev;
> > +	struct vm_area_struct *next = vmg->next;
> > +	unsigned long start = vmg->start;
> > +	unsigned long end = vmg->end;
> > +	pgoff_t pgoff = vmg->pgoff;
> > +	pgoff_t pglen = PHYS_PFN(end - start);
> > +
> > +	VM_WARN_ON(vmg->vma);
> > +
> > +	if (!prev && !next) {
> > +		/*
> > +		 * Since the caller must have determined that the requested
> > +		 * range is empty, vmg->vmi will be left pointing at the VMA
> > +		 * immediately prior.
> > +		 */
>
> OK that's perhaps not that obvious, as it seems copy_vma() is doing some
> special dance to ensure this. Should we add it to the ASSUMPTIONS and assert
> it, or is there a maple tree operation we can do to ensure it, ideally if
> it's very cheap if the iterator is already set the way we want it to be?
>

To be fair this is something that was previously assumed, and I just added
a comment.

Will add to assumptions, and again I think any assert should be done in
such a way that under non-CONFIG_DEBUG_VM nothing happens, maybe
VM_WARN_ON()?

Will try to come up with something.

> > +		next = vmg->next = vma_next(vmg->vmi);
> > +		prev = vmg->prev = vma_prev(vmg->vmi);
> > +
> > +		/* Avoid maple tree re-walk. */
> > +		if (is_special && prev)
> > +			vma_iter_next_range(vmg->vmi);
>
> I wish I knew what this did but seems it's the same as the old code did so
> hopefully that's fine.

I think point is that we are about to exit, so we'd be left pointing at
prev. But since we're exiting in just a second, we want to be pointing at
the next vma which will become the prev of the next merge attempt.

Liam can maybe elucidate further.

>
> > +	}
> > +
> > +	/* If special mapping or no adjacent VMAs, nothing to merge. */
> > +	if (is_special || (!prev && !next))
> > +		return NULL;
> > +
> > +	/* If we can merge with the following VMA, adjust vmg accordingly. */
> > +	if (next && next->vm_start == end && can_vma_merge_before(vmg)) {
> > +		/*
> > +		 * We can adjust this here as can_vma_merge_after() doesn't
> > +		 * touch vmg->end.
> > +		 */
> > +		vmg->end = next->vm_end;
> > +		vmg->vma = next;
> > +		vmg->pgoff = next->vm_pgoff - pglen;
> > +
> > +		vmg->anon_vma = next->anon_vma;
> > +	}
> > +
> > +	/* If we can merge with the previous VMA, adjust vmg accordingly. */
> > +	if (prev && prev->vm_end == start && can_vma_merge_after(vmg)) {
> > +		vmg->start = prev->vm_start;
> > +		vmg->vma = prev;
> > +		vmg->pgoff = prev->vm_pgoff;
> > +	} else if (prev) {
> > +		vma_iter_next_range(vmg->vmi);
> > +	}
>
> Sigh... ditto.
>

(Liam can correct me) I think this is just setting up the vmi similar to
the other case such that if expansion fails we can positioned correctly for
the next merge attempt.

Yes it's fiddly, maybe needs a comment...

