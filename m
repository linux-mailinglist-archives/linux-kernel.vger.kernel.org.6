Return-Path: <linux-kernel+bounces-526359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF171A3FDA4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A187164B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83649250BEB;
	Fri, 21 Feb 2025 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UAPISjfQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ygf7tQ9Y"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E152505AC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159678; cv=fail; b=BE7H8ghdYGgm3/GP/lZTViqSDLLMaMwHmTaW3Pp2nm2GYYNkske9NI+NN0/vrvUe5+Dj3CmXDX6LQ9uJdCzQbFl2K4F1HZzWqqXZwWVT15AoG34xD0/hU4j2SdWeMsMqietBNelJfBMnkEnTDSHrzIL86Pvka13+/chKT/eYsG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159678; c=relaxed/simple;
	bh=xFq+GhNkBI5XRYUY+VJ49rKGLleWYy+AWFD0Bratrvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TVGYvl80CrNiYWMQLt4s56bznU7Ycd8y90I7qHMvj/42s7JUKDiF55dyKl7gucw5zS0a5gBN1O412bdevUEPv+ChfxL2EoPQet1VpxB3p6qjEZ9Vp6IzXd3NAcJg62ecap9jxQrhnx9QEIRFVQS3uz6Bk9n3hdQbfec6aX7PBHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UAPISjfQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ygf7tQ9Y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8fd7u018610;
	Fri, 21 Feb 2025 17:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=xFq+GhNkBI5XRYUY+V
	J49rKGLleWYy+AWFD0Bratrvo=; b=UAPISjfQ9sLc9ivfvvrG3+jrPDxZUBU3xZ
	os9TpEOBLmUBb0bmupj60fataY7bs2A1VRrXDqaqNQW1msP3ANiGjIQYrcmKlP1V
	+yaaVcHpbXq9WRiCBWu9lbDVmSA/oP03P5sSTeKNt28j7EsNOgVu1M/ihGEDdNhA
	TjjtXgt7wSGbFwXTHol/Z12T6cyFNkmIcLZDUpLpgLQtOEh8v0RK+bwDRirnj9Bz
	gMjJjN7QZY+0pnJViCz2vkj4Bbs51G+PaIHbVKku5pPjsK0dy2iz0JyZlONcjQpU
	lEt7U8AXiENSlWVjKXzoyMzJ0/ggNHO7kCUaizeunmppI/DFh9iQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00npukb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 17:41:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LGK832025194;
	Fri, 21 Feb 2025 17:41:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w090yec9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 17:41:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhbFPraJvWTRSvUcCmgyOI7Sn1HfypgSr1O55z2+jTBUWQFM6m2p+TG20fgoHOKoIC58bbGyYZEOTsk6suUtTiOf1z9VLKoJmKJ3pPxpF7rqtrBjUF606mvpYzDwt7OMZKpfjyPxmYUu3ksCcYO5yWSoYQtdBT9X+jTBgDEuEhMTbumDpl4El48HtLUCLZjBIKlFZED2sgY3/KlAlsLTvgPUfCNBxOn0OOavDapyMg6CCB/z7ybBGhGpz9537PC0x1c5lnUdQdBoh+A9KVRsUIW4d4fdA8QfWOjKgdO3odAR4eXZ9dFTyPRcxrh13ZWWXkvh3wKzI/w4rA/8KNYoLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFq+GhNkBI5XRYUY+VJ49rKGLleWYy+AWFD0Bratrvo=;
 b=wCXH1tFVoAE+T5Tu92nQwf0lo7OjuKIdLPQQf/Vwq1HXPjH6BIhszhzF2J0kaap7H38L7l0pLDoSJYZytJmDQEyeYRihW90gcJgIxKmK07vuEhdkBgbuwerbWsLCw+jYkaUeBU3aY8KNIQYjnm+cRo9ckVtyxdO1IR97fLk78Nn5px/HjfVV8tggHAhD8RHZvt0V/RmSeER/l6cQ9OC6eO1odHtGRkZGGhQ/nUr2Jc/3vrOESPp5qNCQHwWkK4YFqpmphb+uQ0sg9bU0TV/euNXXBK92UoXDu/1Lhu/nzKgsZ5WEUyox07PjkGFrHEi9b9d8WiHdAdwBJri6v4gWUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFq+GhNkBI5XRYUY+VJ49rKGLleWYy+AWFD0Bratrvo=;
 b=Ygf7tQ9YLj5rsB8pgf6HR5TFdioDlOMNUJeeiJsEzA8Ux/1ty22QVZryq9nxMrZh7bFdcQoOwrfxmxWMEX7Iqiu1EobGNbz6Ck1ugd/9ReFhzgtJPkzPNCH53KxOKOrfz2dZM0X6ARmtZWGscMoJ0OaiEj9uSoMkG/sv7rUwPdA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV3PR10MB7747.namprd10.prod.outlook.com (2603:10b6:408:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 17:41:02 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 17:41:02 +0000
Date: Fri, 21 Feb 2025 17:40:59 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] intel_th: avoid using deprecated page->mapping, index
 fields
Message-ID: <f4f9c663-9ed5-40a0-858d-d7ac79cd3551@lucifer.local>
References: <20241203080001.12341-1-lorenzo.stoakes@oracle.com>
 <0fcfc239-19c7-404f-bbc5-70a29ccf6ec0@lucifer.local>
 <87v7tyyrvb.fsf@ubik.fi.intel.com>
 <64514bd2-0271-4b2e-b1f5-a35520fae4ff@lucifer.local>
 <87sep1zw6d.fsf@ubik.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sep1zw6d.fsf@ubik.fi.intel.com>
X-ClientProxiedBy: LO4P265CA0220.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV3PR10MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3c50f6-f81d-459c-0542-08dd529ee8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i1VNX7EmCVnQRx/g+nJazVHmt6VsjOne4ZXIvTEM5r2s6rfwAGHqY3syWyQo?=
 =?us-ascii?Q?MM09iajRD/xHfJl91yNStjgLOF+liqvgXHI4oFNDuY0g7tj+IX+wxA+wpUjk?=
 =?us-ascii?Q?DE7kCgUgvDtikZ4W/Zo3sJMwBd+qrtH1C+ghwTnwpNe9TOlwBqUEeG2CyMEc?=
 =?us-ascii?Q?HDcZTD0FLVRC/sSK3+1273mOYa3HCLZeP2HihksNQ3kI4rjO9uG87xixhQRt?=
 =?us-ascii?Q?WNVfRu632v3BFTkjSkOkVXXOzFWF+XtdYMuzmLovvD/A2gKVAXeNk1XchxaZ?=
 =?us-ascii?Q?0AkFYjlcTtwjqKURDoSHwq5s5muQj71W5xN4tptfYcgnGb4jUIJhKWx4581l?=
 =?us-ascii?Q?EqwKJN3JtyytV2AUTs+r5Xfh7HH1l21e2uFM/4ffFPLQMxPzVZdaYo/wjmjT?=
 =?us-ascii?Q?+KL9mKVjmuHHIPDKSK+US47Y3di4RssTjZaEboH5kJW2QvLM0laa7qiQ1M0O?=
 =?us-ascii?Q?QfksA1hIWVOJqvl8q8yIBq8BUmOsIunxp0chqPuAxuCGsh8Iacu1MkCUo3FV?=
 =?us-ascii?Q?MI1eVZTpiZo/kpOYcbCD38vIs12x2coT9xfaLDOIFa+U+cIz9Ql9DGKTg492?=
 =?us-ascii?Q?zw2Yxt/uVpMV5b//Jt3mlb3r3Cs3J5WKJt+yJH1RQjFP93Ynx2R3etOwQr+v?=
 =?us-ascii?Q?PlGSoX45tV+9jIe6rsjsutHNUkrqajg9iy5wXU4CcDiDxacko+MLbFragSPY?=
 =?us-ascii?Q?7EwAN8cZYOFtsfi0uD3qH2pkyB60v9o+/iEPOtciPhJnZ+qCeuWUPk+MPquk?=
 =?us-ascii?Q?Zmwr34L+r6U+Kz1rgJiIE6mPz1elYH8lQSDb1u9qofIwlSmIfPgJvbeP9o8p?=
 =?us-ascii?Q?x0W74RdZKHUkdOAv1HmmNyAz2OLJkXGqOLVHjrQR1o8RM/IFjdNVgHg92gJD?=
 =?us-ascii?Q?ZUWkqLFhsAdPUXbWIJrv3ZwOvTPxDDHjQDq/SzcJob+IFb/fMPwLQ+2w1LaO?=
 =?us-ascii?Q?sIlS+pt09QxjLQuO9ybYhqBHxnLg+b1q3octeZ3mhLE8b+ocottVxp8+oVoo?=
 =?us-ascii?Q?hEr/kaxt/1Bbh6ziJ9/58trdriJ4/6CVsAR+hmZInltSNckhq09alw9PuGzX?=
 =?us-ascii?Q?1RxitfLS+Bt6tiKPT+M+OWg1skLVUe2q4XRJvW3PGxM4AtwV1aay9sWLTT+l?=
 =?us-ascii?Q?zNeDxt+au6+GFhq84TUqSge3A416a1hi88PGyXzZCR3fpMGO95ngyd50TSB8?=
 =?us-ascii?Q?6sRgEHpaHyHMYa/GnRk9C/Bt+z610UM52HlO+B77NYgR52Ir3QwwUpCtET5z?=
 =?us-ascii?Q?XswcSkwW/bwqn5SGuVSPSD6KxKMuk9da7FthwMh0dT5e3yZoZOaQ4dMNDznq?=
 =?us-ascii?Q?uhrNTrufFpiMzZAHl1N9XGKLQkq4V9Gfamf0bWd/JP/NN1LmFIseBeX1UutQ?=
 =?us-ascii?Q?rvaQXLyQdv6sCiaoWM8JwqCa4h0r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AIsGIo2NZ9fRiK6HGf9civjxzTFFfFTA/Iv2wNuf7MXsHtoZN1iweqN/Dpg6?=
 =?us-ascii?Q?JemIbjRJx3jdhYmL0KKj9hZN1Rsa0M/AC6faJkFO4h8qspzYeVs4w6tkVURn?=
 =?us-ascii?Q?rM3/MFLaAQLfAL+0KcVj8ZTWS4ID8eOrScEuzAOUtVDU0D/pVQMBng0IigId?=
 =?us-ascii?Q?W7WfOPYosUAAUkfHr4Sg8Sh4UYRV/7QPEfFjjD/FhjgbZjjY2PLkIHFLHh5r?=
 =?us-ascii?Q?cA7QEhdlAgW+zMEC/u0UD/Jh6RTX3h9ZLlyjhKeMsmUbDDmkFKeTPQjkUePU?=
 =?us-ascii?Q?Y2hp+3c+b+qi3oyJQyQnJd9tB5mHmJ0Ibo7AVkk8LN0CpyJBusraorsVeVnv?=
 =?us-ascii?Q?c3+7eea4huVRQ3dowG4u1YRn2UZzmW7vM790pR91pmBSZO3/mSkWRMS6/mAh?=
 =?us-ascii?Q?bJuEJUgEWjHqLAbLiRddeCF7A+IV/bX2/5lVLul4wlEv2vvT4rigvCTT78lC?=
 =?us-ascii?Q?lIm3tI/CiKK+ZmrE/s42SFYMmQ0K1lC6ZiBr8C7OahPwF5tFLYg19lNqKeux?=
 =?us-ascii?Q?lil/WsDWnn+8h3BCti0pV+EvwIaoL09DxRlLUlG2uPoACBzQSY2lksXr6kXl?=
 =?us-ascii?Q?j+hwFy6vdllHOdDdFyRpT6WP5NppPuIRssB0W2VKZP2KMOQk7YUuqR/fP3Y8?=
 =?us-ascii?Q?s159hLcaroJIdFQtmYDLlRsCydoMN+x5LUFeNBdgMmV7oV9jVFM69w7EOYB1?=
 =?us-ascii?Q?8gjzME6AVMA8gdxWUrRLuoeZdd+xrf0kZ9G40pmV2upsy79liylv/8rIsKYL?=
 =?us-ascii?Q?J3gBDZ0mEGSJSowgDcfveQe91BuxPYcjHFqVdCL8vr2RIv3jrsYTV66rjyBl?=
 =?us-ascii?Q?P+ip7hHD8v+eX8BXCsZeSduH9IUky1Em+Zz9iR7TENXi5XThh2Cy8uYU5lb9?=
 =?us-ascii?Q?HH+pPhJyXTLDmK7MRlpJvIOjGfGxoO3hl72/v8hZaDIkQ2j+uT3i4qDOoRoH?=
 =?us-ascii?Q?/4O62PhI0qAvh1J6IxnwKmy2z3rdUMOrpFDDXpyqaH5nM8pQhp6xti6Ulgjy?=
 =?us-ascii?Q?49GcN3anRsdtSjqWBOh8riYbOhxohzVM+DuPRRfVe7rE/LLO6rp2IdGnYQEY?=
 =?us-ascii?Q?9/7KkJf0gIjS29RwvNHtVGaWZcs6QtWaQCoa05i8BMDb9aVf4J9zaj8Y+sug?=
 =?us-ascii?Q?XAdodEGpYTauoPnMBwRjfkhGqpL0ZOaY0reqe39DECLklW0unsYIJu950q24?=
 =?us-ascii?Q?pPvd8bRXpOqvmjLVqn+imAnhs+spHAG7GmxVL7cIzcqpE8koJ6baMfzbdv/Y?=
 =?us-ascii?Q?Lbpfinp6wGTQ+fKLFzbmRaqMNZGaFKisbLbE/48ki5mxS9dl1BKTv2EGQaPk?=
 =?us-ascii?Q?31Qew5+ktr3dNvmKKTbk+1bPYwf7h0CdV16WTG+SzTQpkWUVdFIF/QqiBwbF?=
 =?us-ascii?Q?aWtUeupI9yUDtenqHy99L+K4x9ETsRiQ3B2hlbi3v7p5/JUQfAWIRcF58wc/?=
 =?us-ascii?Q?gVIUjvi3y9BMOGIjygCULsbDwOeiaHRrdZy4h6tNaKS045WUvvrNNTTnssul?=
 =?us-ascii?Q?EyF1dlvJJLMtFll4Yi9A5vzANqEHJvl+rK2hTypOo9HI9bnJmUecyrx3Tnrj?=
 =?us-ascii?Q?+fM0+L+pTBzeZamllowhS3F6aUqRIqnK05xxj36FQbD9+3ly+PK4R7SnW4nS?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CzjHtL+/IMEs2AvNqa9YYOUKpFLFPH/rv6ueQKUP9+bO2osm5MqBD8EE1oZPuta+GklumfDz53BqYEU1a6XacVnGXzjkMibJycvNjidlo9QQZPtnnwQdu8COUF9rtbRnb5nF0KzT9YZsUFNx5t+ylbkOBknaQQc8bj9M/iA4L9aPAvmkXglSK8sGIPbahJZLPuvfUHiXbx5AAQi54XXEq7FLOtvF3S7/7r2qoiKl1jjG3NmIFPbbOA+HFTUuQJyHdJ0VcFDQYCs33JQPi/CSz9FC0OZdLHL0NJwgscq7Bkx8/NZcxyAzmRS8tosa5Utf0M5xVX4oD+SjEkiGCYyu+J4l9YKQLOS8I7MxcoBm2v15yWy/Qrz9evkyDEuPclhlM3fnmhMlYCYjhvC50Hd+tFFYV7dXD5JUWrifn7qY8e2kmnsSRcBBSWk2jezZiVoHFPmHsCPv50hhp1LKJDDK52/AqHwhLJpbtm4LkLlXoqazrPT6wjQjGkTo0lFVujW4zmIiRioM8ldWv3nYbJy68UXjcM57cAe0bg+XlH/rFbwQ/qvZvrGmR5KWSBTrtucXa7O1F1okBvfKg6OkdbzJdqXaZgnaP8IsP1+nk/IWdzQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3c50f6-f81d-459c-0542-08dd529ee8c7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:41:02.1669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1EZuO82UnnUJO3vW/9j+30Fvr+5H+xah0fSWREJoCwj2UArYY/qWwlfVoS4uSHknMYDZBrIUXvtIx5dPYZa6ENjYPzBSt+qX4n3YGTh87U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210123
X-Proofpoint-GUID: 2mhm27aewHDfaAFWqSxSGxIYy0vEc-5Z
X-Proofpoint-ORIG-GUID: 2mhm27aewHDfaAFWqSxSGxIYy0vEc-5Z

On Wed, Jan 29, 2025 at 01:39:06PM +0200, Alexander Shishkin wrote:
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> writes:
>
> > Thanks very much! Yeah just keen to get this in as we are moving towards
> > removing these fields very soon.
>
> My understanding is that this is a part of larger effort to reduce
> struct page to 8 bytes and an optionally dynamically allocated slightly
> larger structure, is that correct? Just curious.
>
> > Could you take this in your tree? I think that'd work best.
>
> Sure, will do.

Hi, we don't see it in linux-next yet, did you take this patch? Or just not
sync with -next?

As we'd like to assess the current state of pending 6.15 for page->index,
mapping usage to ensure we 'got' everything.

Thanks, Lorenzo

>
> Thanks,
> --
> Alex

