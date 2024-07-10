Return-Path: <linux-kernel+bounces-247236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6B292CCE6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09DE71C2081D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260C51272A7;
	Wed, 10 Jul 2024 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hVc3TT4Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uHoj5UqD"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D26F126F02
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599918; cv=fail; b=U2VPD65K9ubCh4LAOcmM9wjLYy7tiWQxtlU5xdWFApXS2Or6XIdLpnFj1FvCQNjz+S+SvzjJsO0kroer1q14NMGz1CJPnyfQzycQ3/J8upcHfs0zbmRcv0IiXrp92v9TtnnHlSlQWWdHFz2yMGXJEKw8uy4Eph/A0ijgGl7ROAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599918; c=relaxed/simple;
	bh=oc9qGCYtxL+Pci16gyeqLbboyh8LMATmhzSlj3JMIv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B0qr7pFDLNC3DrqL2bAtDYzX8Vn94c+BcXgxrcs9Hv2z3/B5rBz9nnN+QQtGI2/PWwezKz/z39PnlIpxTJk8F4+ObvFCBaldkhl44MNHNM13mHG3Z5T4e6C8eM4V5ldzXbx21IRWP/d+y1o+mhc4kH2gEiSD3cRsUjLTRbd+NyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hVc3TT4Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uHoj5UqD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A7fYPN013740;
	Wed, 10 Jul 2024 08:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=YsCET5/o8Mts+EK
	Vgkbjrdrch3G+s8LIafLiQN/cqcY=; b=hVc3TT4ZPxiaAxO55VDB8AGa9G5fkDx
	CNpo99BGN/gzjyLkl6KkJt/OAYtUFx7dcQITiWCjCHvBf/mhwElyGIvY5/TncFYe
	mffgDp3slLOU8aWKXXmY10VfjEDpTpj0mjF6footOyPh/rxYdZ6HXAmr4RvbsSK6
	RqaWbm5IZlMS+0u+Z//Vn74N1VnSZDl3wmrFL3Z8lK5hCogyA+/Pim6musPDc7fU
	RgW0zCqYl3uE7+/DhVFFdQ5np3OJMZu774VXXr7Mrsd027K4ewji5ynAhGf6WBEu
	kLH1ezmQ6lgTX6K0wkrerY9ODva1SP8M05JJ8Lzlf7y43fcN5FFjcvA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8enae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 08:25:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46A7chS5005651;
	Wed, 10 Jul 2024 08:24:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tx3xdf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 08:24:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQMrA6sTVQVn5jIem4l+rXTR6oaev6ZTPs+EsSgcMUF3kzpJxpG4Khp5cC7cjXe9c/nSjlHvupn6842sF3i8UgKrI4dWYfdPwn+U+6CIFXSWylcgGGjZ1fFSOX8zgeso1cvVEeAcTgFUfXmNWfsqZ3Ijs/LbovwrB1H61RDndCWC0ZaQLvl1V+OQivL8K1mJwsgLLawrWTW3ihXh+x4pel+yrADMkqjevu957vsPjW+Oz0J3O6bZjotopAyydn8XIdtqiS6nw9rQDnPZEkVWGOk78ojKFabfivb+t+jZ4rsNu1gNXJxOzahXeZoppBZ1WbKmaFFXyuTnmcSUratKmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsCET5/o8Mts+EKVgkbjrdrch3G+s8LIafLiQN/cqcY=;
 b=MAc0mNeMTcgnNa8HtewpDF/T/lKhpESchu56O98RtqXvrla6Ructl+anGOSuDeW5i28IsQtjDYcJgMx4DYTAGxzeLuQdsgNnW5GMm+tgxMr6IuOURRmnUuHENN+q5UddFQJkrJZNnsv84HYeUHCzlkjezK3wYL88Btce3bF0LLKvO3aDFcDkKEKbEYh1+j+pDmi5khPSHY6TZaBeYal8YTkB/qyhpaLK0MK6d+A1bTMZVITBwa/fo1jpwxgN9hKBiVq1EcDGLqnqMTHuDYFWycyC8aL7W74lTeFB09MuboinMQDCaQ5QTy4MAz0fEbeI7ZuKAO6iNh3wnT1fuSUOnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsCET5/o8Mts+EKVgkbjrdrch3G+s8LIafLiQN/cqcY=;
 b=uHoj5UqD02/Nwkx/lD26iColSCBBNZvg6Q8XqUGgnHLaN1+sKWewJN3fSspnkUOXSW0q1L2eh2v6vrohyr21u2MIJSGiqotju93psH4reKSD1LHTLReRmeYcHYm+qXBN24D6xWsNHvR5tlc9661VN0ESs4xLSanFaOotdtiQb6s=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MW6PR10MB7550.namprd10.prod.outlook.com (2603:10b6:303:240::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 08:24:41 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 08:24:41 +0000
Date: Wed, 10 Jul 2024 09:24:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Haoran Jang <jianghaoran@kylinos.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, vbabka@suse.cz,
        Liam.Howlett@oracle.com, akpm@linux-foundation.org
Subject: Re: [PATCH] mm/mmap: Align the length parameter of munmap with
 hugepage size
Message-ID: <96c9fe70-f787-42e2-b2e7-4ccad0d2e805@lucifer.local>
References: <20240710054558.1959243-1-jianghaoran@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710054558.1959243-1-jianghaoran@kylinos.cn>
X-ClientProxiedBy: LO0P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MW6PR10MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ae047a-cc3f-4297-2eb1-08dca0b9beb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?aHrFWT/KyLSojzITE1tZ4TEqIFqAsZl/pYdKlo1WVsSa69jRn4FK0IlZCu3X?=
 =?us-ascii?Q?sJ+ktvK8vNmmqSLFE+5NjF9Ev9+YnsLiWhPl9PRBsrsOncYJoc2hkbn+Xt8b?=
 =?us-ascii?Q?6h6enDRWqCmnV6lJN3pG8dPIyj0PleWlawQKCKfNK3w/ceWdAkUqINNleBBV?=
 =?us-ascii?Q?KJ6Brt3B7BTNc2JRmrhkCYYTKkuUKiKIw8WpgSp8nbCiEFznr7D4YZ/1BHXg?=
 =?us-ascii?Q?lUrT928EFi96/JLb3bpiGJZPlZ256L5sNcnyDXLteaDd9XXXVWIB5ET86xvO?=
 =?us-ascii?Q?OcJnRvA7MlpkJfj6+pwmdJHU6kisa2iWmtr5VtSt/Rdx8BsMxYKhYYjpUXYZ?=
 =?us-ascii?Q?EWjEoUWw6gFWSDvkZTFnZmPAEUKu8h9GX0oQCn8RolA9UO343yq4SqrIc0Wf?=
 =?us-ascii?Q?VOu/W5yJlZHg74ngN39SfwPV3AuyefioMdv56naASJn14AK5zFQBX8qchEpc?=
 =?us-ascii?Q?sdp2sbkhcnBpNG+UOhQgWste2y60JaXJZJ+OqjF/oBkNPaw6O86RAv+hGuZy?=
 =?us-ascii?Q?gPNNBIcX5pVUsRDiRkkB9a/fEsenkUaETibL/MkHXcGMTGRe9EtOI9culdkF?=
 =?us-ascii?Q?xn5aaqD5p8Zcfd+dPCKNNfllZSEThVsKy67Ug4stCZWJ/FKp+/U8HuItFfrE?=
 =?us-ascii?Q?jgPri8jKcSdLqd6e8MmYCw0S4tb5vclHml0dNYG+WnKnqyPtZglQsHTcz39u?=
 =?us-ascii?Q?8QBQRcgnpjt1dghsmnekmou5PN1Kw095KHaB+CqwYhQZ424zucFjowxgNu5H?=
 =?us-ascii?Q?Z0x2ti8mz4vb/Hy3i64j/9xr0E3YXXxuZqBCLf6mQUDn2aiqOaNRl/nqsI2h?=
 =?us-ascii?Q?fm2h3UajzHgY7d0o07tlu13mjb4A28KA+PczaVSmuowsgZL9edTPaaTMfkMk?=
 =?us-ascii?Q?ESCjUo6Gd97Pang2DSrh52wifvTqw/rXhMwwO7DmeT6ZCboTCf19mr8whBVN?=
 =?us-ascii?Q?iCU5Aoqbrc2yJZDBRb9O+DhdhLma4SYQzbgnSFGMDUB0LyNFV7l5cBglVcHH?=
 =?us-ascii?Q?qg9hf3Zu0WbSudMZOeb7pwB1a0IjMeaDMeXVgOb6je1IcSlkAYCxTznVjgED?=
 =?us-ascii?Q?WN8wADauysNq6QPYnEJj76TCcVwvDH7TcB8gY9izdS3/Ms3ZKYepEz3j9BBm?=
 =?us-ascii?Q?lrlKj2m/glpk3C5sHHFFBssENhIUVYf+o9pAVB+TgxFJleCa5zAYWYsZwtq+?=
 =?us-ascii?Q?3ktNaJERnzThO03caaFJN+c47l8vmjoUTi7AScuoeEU2DzgN+EkT2u+aS/nN?=
 =?us-ascii?Q?kD4PLvniaVRAoLipQ9iqr/Tp99tb9rdVUHUMAK03b91ybGZ0PdFvXZrsljmc?=
 =?us-ascii?Q?qabTDgLjf3HX4bpRIVkDwsIPrFTQ2OM74Uw0zwrKvvEUXQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?goclTrw6f2HXEBoGSDIdurCaNwafHBTvCoFwvkKH5RQGT/cp8CXfclKf0flW?=
 =?us-ascii?Q?3/Q3Q9/Fbr/RkpeBHY6jrxYX+1UZRDXD4aMB+A0sVc4k2UkX5GsYCncS7P3I?=
 =?us-ascii?Q?H8wVSQxoYADXa1IghpTKHwmug/l0qYwotcgdmPY6XHkIJHwNI36d32r7caR3?=
 =?us-ascii?Q?KYDeJcIAJnTUuFuaZWFpPVA9Q/+Fr7ugljbBOOGKqVHnF/g/M4+xzYj1h4Yo?=
 =?us-ascii?Q?rdqsr75IUYhRBnOwUgPkzM4rXwr7rAidSscYW7mjQEuJo2BoH5+L0REAyES0?=
 =?us-ascii?Q?1WVBFA4GSGZpEIRkq/nGsTl+77TLTzbXzcJ9mE3O5eMqCM9NPTiTFJ5hYfNm?=
 =?us-ascii?Q?NGj1v1yxITHKulJnNnZTbZK4zgEVOWRRqERtfu5iN6WsVBMP6Tq2cU5ChIiC?=
 =?us-ascii?Q?c4SnVOxlfL3xCEHVzC9EJfwz8Jco647PLbBmDkbfu1zu82YXzv+OBlQhCeuF?=
 =?us-ascii?Q?fYzqxxteIBhTHw2G+r+Hsp9Zp5IWU7z5VvWMp/BiAzjHNojWIWDjvxOdsMxo?=
 =?us-ascii?Q?KHFXcADlAs3S+24b0e88vQEHdMyoURLOKz4ch6iIrpqsxaMPsZcuFp5BmxcQ?=
 =?us-ascii?Q?bNsNJGwAGa5x5FRNvG5V0hd1cfZHcDF7+lXgN59B9a8YjyzoYm/mIU19EYBh?=
 =?us-ascii?Q?hJZ204Zpp2nECV3IaU1Mx7Fs6rGXdaorsyCgIijtCardMKPv30jDaUkAftgX?=
 =?us-ascii?Q?II0VUTmHriv7rFCKCxEIK/F1yIZXp3l0/PL/tyF2opFFWVFHG4N/2HyzjcKo?=
 =?us-ascii?Q?N8XUUaLR2mpfJBun45YfEUE4HBptislFYqvbTHZ3gJ/s2FQYV6kbnhI9lBoJ?=
 =?us-ascii?Q?iY3y2GT9LkYEERjGEKmhdqZwmFx3ReU7VteQ77kcHuXEh1Wk7hG3NFTv2ZbM?=
 =?us-ascii?Q?jcpSF6X9ezvFlo+3ufKM1/bnrAVHciq8Jz3wMzAOUP2BcEIhg2qhynE3CFfk?=
 =?us-ascii?Q?Il43XCMGW3a8RJrJFs9U1x6WVDJjvQeqpCJPsAlmIVZRO3a3x5LHMfwlwCXl?=
 =?us-ascii?Q?JaCOandihdOyXczBqtibl1hjRiUhN68o2XugDEBIDsBv4FbYqPc5CIi0qF8T?=
 =?us-ascii?Q?QJKQaQV8RRIr7HBrR3UtgrfDEjWutnsToQusI4fDaUYN5xpG1NdDD7gGD+m0?=
 =?us-ascii?Q?vpc5IjT3iSkyGlL9sHVU7h3KUpq61xSa3gRG8iENsmS3MwNmEeHA+I7RhgJb?=
 =?us-ascii?Q?zMVqNFnmIYtQ07+0/Uycdf2811M8UExgnF69q9m2KNJOM6K8lIoLJKGSL/Ch?=
 =?us-ascii?Q?7xnmEbMrer6LPPvpQ1Ldc2sLontaeLIsOwdN/+hjzf2y/tvdC8wNbL+TG4Cx?=
 =?us-ascii?Q?xuv0gKCeqC3o+07kuL+zoaOISbkkyd2EIbMHY9faoXZ35pJnJPhHux4yxIOi?=
 =?us-ascii?Q?MiMOr4daDppfZkXc/+11X+mGXL/Pn92K22hm4syFfnoPWJs2of3CVLpdgsM6?=
 =?us-ascii?Q?jRHFo8ngwoDzlSeSHsE0pF/CmWjrmOLeeN/XTOuYHO4tbKWpqllMq8PZgEi8?=
 =?us-ascii?Q?KmCPT/iu1e521kHJq76hvBazl4tF6e8V7NO1ho2JyUlbZnmUj7X4CD+lW9Bj?=
 =?us-ascii?Q?47K0Q+xBeYT6FTvQTvQ5lyoeCZv4wG5v6vfL6QqRYV1lyfqybNk82r3K1IuE?=
 =?us-ascii?Q?s6Nq/CQ8iLyb8Ku8bRuqT1LJkaWYBelXbOO1s1T6BSgFu72GsZmPG+SDs2kc?=
 =?us-ascii?Q?HHpcFg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MqBQLz1KBPaYOJXGE+Lx1EvJXipUl7uX75VM9O7AQdZsZ9YTeRntuspAidYu2BIdPQu/G69I82cxx3MWLhkHIqw05MnuMzvhzXuDZi3PMULOkCWgm0LHjHHxeY/DMmHC62LVkcWoY/W8L/1TYgCO1kHcRXTh2xUvQtWBhmQ6jO/QKEJwkM7Th6Yp3uOb+Ck6gfG6GJBjsnpFqx1Sw0YBSi6Xb9iCZGr3hxEaMeMJ2RyS//Cpo1i4ZW5QZW8AUUgAw9A28+E5PDj2mjkGrfKahKUQG9fkLzKTiddmfh0JubM6tyOtOtJzKvi+SttJl10r9xNPndM6zq1xj2HBOlgZnolioztXmgaUDLJWX/ir9QGx9tJ6FACpTFmYIJ40qClRQhCLurBCHe1KTcr23YNXCTKmoZ+5/ZZKglP8eYixR3FXvHEOAOTIGWBHexBtl/aOIjD/h1A7k2kFrwXs8PrAtBNEX0OznBzpYL59EFGxfY8ARe1A9lEfs0sE8WcFEieEmR2RFTVD1TKQ2pEhwk1yIfzdnDmZDkSP48FjwqNfQ1dx44p/vFCxggxODQz1sd5A67dBXnYjwES8F8RBB2NzctrO1F8RSKwxxZQYcP8oHMk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ae047a-cc3f-4297-2eb1-08dca0b9beb7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 08:24:41.0020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVf/dEM2DnSk7yEFVU9MgkKabiOPsvCA68+hClkKCf0PlKa66004kciYw5ar4z2enuomA+OHqpfmI9X5Ucc8SgUMOX1H8424syVjsyG2zME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7550
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100056
X-Proofpoint-GUID: YOhC0J13beat6Qug_KRHPvTqISFG6E1z
X-Proofpoint-ORIG-GUID: YOhC0J13beat6Qug_KRHPvTqISFG6E1z

On Wed, Jul 10, 2024 at 01:45:58PM GMT, Haoran Jang wrote:
> From: Haoran Jiang <jianghaoran@kylinos.cn>
>
> munmap hugepge mappings, if the length of the range to munmap
> is not aligned with hugepage size,munmap will fail.
> In the hugetlb_vm_op_split function, an error will be returned
> if startaddr+len is not hugepage size aligned.
>
> before this patch:
> in "tools/testing/selftests/mm/hugepage-mremap.c"
> modify DEFAULT_LENGTH_MB to 3M,compile and run,
> the following error message is displayed
>
> -------------------------
> running ./hugepage-mremap
> -------------------------
> TAP version 13
> 1..1
> Map haddr: Returned address is 0x7eaa40000000
> Map daddr: Returned address is 0x7daa40000000
> Map vaddr: Returned address is 0x7faa40000000
> Address returned by mmap() = 0x7cb34b000000
> Mremap: Returned address is 0x7faa40000000
> First hex is 0
> First hex is 3020100
> Bail out! mremap: Expected failure, but call succeeded
>
> Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
> ---
>  mm/mmap.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 83b4682ec85c..0b3a60bf9b6f 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2733,7 +2733,15 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>  	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
>  		return -EINVAL;
>
> -	end = start + PAGE_ALIGN(len);
> +	vma = find_vma(mm, start);
> +	if (!vma) {
> +		if (unlock)
> +			mmap_write_unlock(mm);
> +		return 0;
> +	}

I really don't like this, firstly we're duplicating the VMA lookup (we
vma_find() below), and we fail to use the iterator here, and also we are
duplicating the unlock logic.

Also the semantics seem wrong, we are looking for a VMA that ends at or
after start, so you're just checking to see if start is past the last VMA
in the mm aren't you?

This doesn't seem to be accomplishing anything too useful, unless I'm
missing something?

> +
> +	end = start + ALIGN(len, vma_kernel_pagesize(vma));
> +

This seems to be the 'action' part of the change, but I'm concerned this is
completely broken, because you're using the result of find_vma() passed
into vma_kernel_pagesize() which could find a VMA _after_ the input range,
and end up unmapping a far wider range...

I'm also wondering if we should be doing some hugetlb-specific logic here,
or whether that belongs elsewhere?

Liam can chime in on that.

>  	if (end == start)
>  		return -EINVAL;
>
> --
> 2.43.0
>

