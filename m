Return-Path: <linux-kernel+bounces-528006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CE4A4126A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4451F3B215A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 00:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DA3291E;
	Mon, 24 Feb 2025 00:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DKyykXuu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DG+4xZ3c"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6A6195
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740355268; cv=fail; b=jkJ6m9oh8dxk86VxkVqsMRKdyONB9AmNjfa03Ajd4SkUWs1jGTuz2v5hBoYCflGRsxoDeFXCaqUglegOlvecYlqlj3MnyLP2m4OpS8zUZbXdH0/EC7EGulHDHXhKL6xvN/4tHPF6ufja+HmVfbuuiLzaV0zWgBBUVZiKWvaZX+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740355268; c=relaxed/simple;
	bh=3tyavmEHDtswS94wuQHlJuhfmRTLxNUUVdRELlcahJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EaFyPp/6PCvGq+lYLDp1+yQDcQ7wbwpRHVibXK04lZ+bHn5FgV6amKJzzj1x57qOVAhHoSsF6oGMS/KdbIL+3D0zvGIecGHJpMgTrQOjUKsjwfk6TmSzI9XspELrGpsHGXwXymjkA6+iNfOGaQjAOKr6YzMZK8+tA0YuOrpr2ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DKyykXuu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DG+4xZ3c; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51NGR4X0010923;
	Mon, 24 Feb 2025 00:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=b9h0qaMqyW5PtbhGRq
	CZiA6vpOusOdrxWIZhgplu6Nc=; b=DKyykXuuFXNUN13j2yCfY5ZSaa5oNrsCBd
	3l2bu4Jb6okKJWjOv8AgqyN9ksHlIcHRHzNOMJ6DAv6Svx7vvExQYPaMaI5lhi04
	5gBpzW1F0+GywCNQDQJnatf4xndEgdhYeKu+fQh5KJ8t+Zvo96kXcBzMMwdN1sUh
	SuVRHWP4L0uClEyTkE/p5QL+P+GdIw2i6fdB87xaRem58lItcxvNYxOxiBBMkQ7J
	eRQhufd/5zJpbwns5WYK0RDgzbJl+wju3dG5oeJyvKyMNyXubpRG3VhytfNqblwB
	JwNjTLUqaQOCNT2sCdJh80peK2TFsNUNUcCHgFY1incFvZWYSm3A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5gahjsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 00:00:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51NM8L7D024463;
	Mon, 24 Feb 2025 00:00:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y5170pux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 00:00:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wd0UpJ0tQg28+J84BZAO+Hm5IqjuNDMUnbWiosrK5hvpUORZjQuMwPelNFUs815jdu1emXpmnMjgr4NI+8rB8ESyvA1mcLkI+2qRdc4+AqSExwJQdx2yaLi+Tnmu7+AyM5D3moW6pqCi08vxhp0zvMHAlZJ+BqunZ7PEeU/qIGf/FSKpfG0jL2/z4biVOHqETZgBrLhPEOi3oFFOX9MDNOgancHc3jH59wN0o33mPrdP65S15Ze7lajGu4LbrO67Ls+Os0Iwl3In5pYUZk9Dl6cCrsxVQqai43gWq4BZEnliMb4gbfQeQT71EmMGzDyW9hX7RV8k89HO0qWLDIuylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9h0qaMqyW5PtbhGRqCZiA6vpOusOdrxWIZhgplu6Nc=;
 b=ap0VarJQZp9VJtejG90ftjXf/0a51sr9L7L0maJaJUNpZpdJZPmlvaSa8gOxAdU+hRgGqHDwvY8qqS2yJI4u7+Bq3mxCaziG7k46lnVWupph6X47/5zjFn1t8SB8IJ4PEP+yWwGiELUDeRBWOFpmrVI6rsGaIL6Af0XZVnuq9HZF7F50dOmdev/kVwLFr2D+FyHEggSZDAhYT0EJtGUVT61EAwz/ejE/2FmKrHKPWhP95YE9ybh0nHGj8TZAfSAaCU+cs7kDRN2rqLKCn2/VnMgw+fEXEjRtaGHDVxyvc8gVQi4fKEYXvUIjP5u2EfnJOs2qf1kzIS4QkHivEm05qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9h0qaMqyW5PtbhGRqCZiA6vpOusOdrxWIZhgplu6Nc=;
 b=DG+4xZ3cMkQRngHFF5w+YIvpAv/mz4yxmIgiLutLCw2uTyn2wL6nzGCC/Ykhuk0L3Soqjvon4JmCWt719QGJPUxuI1ayg8AgcSh1mZ5SUXhaFkIUtDWiRtFmjGlUHooKmLXBgsgsCodS9tjvGrjGG88E6XbJcuYXlFlOGzg7QB4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7806.namprd10.prod.outlook.com (2603:10b6:610:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 00:00:22 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 00:00:21 +0000
Date: Mon, 24 Feb 2025 09:00:14 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Lilith Gkini <lilithpgkini@gmail.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slub: Fix Off-By-One in the While condition in
 on_freelist()
Message-ID: <Z7u2jgDadOwceYeN@harry>
References: <Z7DHXVNJ5aVBM2WA@Arch>
 <Z7blsPJiOPTFWEL2@harry>
 <Z7b0CvTvcS47o7ie@harry>
 <Z7iUVJA-luvNaIac@Arch>
 <Z7lLXCZB2IXth7l8@harry>
 <Z7mX6PFxUptwX0mW@Arch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7mX6PFxUptwX0mW@Arch>
X-ClientProxiedBy: SE2P216CA0030.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: 657fa6f0-e6fb-476f-e892-08dd54663b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E0UAT7gyVtAK7cqgofTs5GEnoYJshVju0afT6adxJ+cY+G+hvAcg+l4rQ/IA?=
 =?us-ascii?Q?pi5cK8w1RRR20DSWbOAW9PDC4ELvWrpDQUpGObtUTzmpvpLzswJtrx8Y6Cup?=
 =?us-ascii?Q?reWlirSc3iX3DI16XHbruCnd8OJ0O3ImPUVmeAYWHUuBb9FVGE38hmB51H2r?=
 =?us-ascii?Q?cxOmC/YgJiIlFPKh0VR7yYAworgHImr2ZkIRr5WtM80LewRgWOPAWs9j7x4Z?=
 =?us-ascii?Q?Y8lAPpwWRyb0Fek52amqcwCqOUN6IQH/LZ/sd8xZbPVkts9OQ/IIjvbjPD0n?=
 =?us-ascii?Q?ytvvfBOwUUVhH0OJzaK/2IH0HuTKpGym5AcN3PNUBN1FFP1gchLQHXOpxfCE?=
 =?us-ascii?Q?IYIJ6/lQdlY3bjgzJNdbWTpWHVnswZqnxbqrOI9Joq22DhqgyB2Fp5Gjersp?=
 =?us-ascii?Q?N407RPg8rTXcbMlappgkgp18UTT6+uCPMVFr5VjqAq+Yn/q8mJ+ZK+bwYZ5i?=
 =?us-ascii?Q?OwNf+VsZ1hQLprvD8CQ3lKR0TC9h8BiW0WDSvRYjWDkTwDNS60LRL+8VL8Fq?=
 =?us-ascii?Q?bCOq3mp95YA94Heq2Wg6+EUKuMStbmSZBEMGglwCOpFRDXvwZ2Elln2u/Gjd?=
 =?us-ascii?Q?8/+oTI00jLfgaXRPb7YnV1yuneel4Iwlc2/VJ/8ggBeWq3HIJXPfbfrTrYzC?=
 =?us-ascii?Q?uEXucpvjhfnjETJV8DoEAeA3bSUBaJQK8YegtR+iYnmxvFiS8slKsPWEE51Z?=
 =?us-ascii?Q?31xsolZiyCnSZnbpnACykfpJA2XRf7Qj8iIvS5tsWpsCnoHTrLOt1Cw2ham7?=
 =?us-ascii?Q?k04i11MeqJdGU7nibuDHkynWh2s8q/PghujF95o2zE7uTYKfvsEoAqX+ghye?=
 =?us-ascii?Q?947jKxu8ocrIL3l1Qa5hvfcWjP7l9+xemKYnSzdDSHl14dLiQrPSnmMj2biW?=
 =?us-ascii?Q?p6mF/vSJGZ5aFQZHFWiBFetfBEYWe80Qo6qpo4AzcrFxYVqt/pCQz0zCBg0X?=
 =?us-ascii?Q?7nM/i7EwQ9RMR/7rrlc+kptwR0pjmRtZdZMRxWJxD1N6Vcu5QQFN40NA5baD?=
 =?us-ascii?Q?xJUVOLt5zAglxS5k88PqjdslRtCbylBvwRW1fsybhs2iPrQPztwooc1MxmrK?=
 =?us-ascii?Q?mP13c6YNDHqpvF521ZxfL1rCoz2gJkHk94hSQbIxYGCGWTlSHcJPCotAQayA?=
 =?us-ascii?Q?Eit++agR3CLGI8WAWsDZzQCWi1nuay5ynP/dehs3cFM5/hHgf0KVnX+EdCnb?=
 =?us-ascii?Q?6ZdxH2IzqSerS3cvFWIOp6vqtxUdv75bvNwuRf92Eqz/95eOv/jC6cxuzudu?=
 =?us-ascii?Q?LMKTMT1KtvRyEmy5OxkwYesxrD3a0Gb8HShoPH13qmKOKeEU5HZbd8rDGCHe?=
 =?us-ascii?Q?GSYWb47/nwIGUKbZDZAu7/xT3HjgGGKERj60N9abyK/tE9hwswFoaGZYoENF?=
 =?us-ascii?Q?7yo8MewsdEcgsfQAdrVxTnrH4EqF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5lEZrCnID9f3krQLidp95weK5wNpRuOQjyfwbZn6wbqQ3r/fxKbCAWlTyndD?=
 =?us-ascii?Q?mmZsmjZMpJ5bXkfeczrhkcfb6uQmTtAC7DibhtJ8L8UPRtFSwvsdjWJb4THS?=
 =?us-ascii?Q?YqguD7YZq8JdK41lReUJtlv6Oix8pYFgT6gHb+3dbktKfWH50r45F2jqBls2?=
 =?us-ascii?Q?pGsawwJrxRu9HUV41DsN9KoJ5t9om1gmoCrptj37/hiXNL0RlLRoJcRZRvsG?=
 =?us-ascii?Q?RobV6kTOSbdVTnKBF0XT4GBZ0Hm8TkTy5YNL/1JutXWGUGxWMfuK9RjQKS+s?=
 =?us-ascii?Q?MyQbSVClTwQHsl8IRCH0usFeySaPJ1LoKAwWkSsc1RTlHXFHKqDb09npaVAB?=
 =?us-ascii?Q?ecKRkrjdiuaL1JqWitVBcL/9eLIhv0MGyLcxJorOIv4adRqx9iSEInAAS1EY?=
 =?us-ascii?Q?Q++/rnwH2sJY5vV5BUQuKcOBCq71GNLPKR5j5k9GtrGrKFUJV/pxNQRCoPjT?=
 =?us-ascii?Q?gBccsrCPQRhcziO1kyu5SQKpC9cEsmbM2nAbqNcxbiFfnJ/OWUoBOEK+FqxG?=
 =?us-ascii?Q?nLjyTALpkawR80Cq7ZjZmsQLGVQ8i8ctC9QzwRYM4VHJdCZhNpIcqhpQe+dQ?=
 =?us-ascii?Q?c3IGilCpqYglGQMz/NJx8SvTjlOKehTP5CEGZQYDwIQ5Y6VOJ1gixVLpPf+e?=
 =?us-ascii?Q?COJow+7aMKuF7jtEYrq5GxeH6C9r1JHfYdIpQDNSqvkGkOzPDTog47z2MFD5?=
 =?us-ascii?Q?x/VdsSkAYYszvFi9qFhOKv4HPrGF55LAWJJzF3ymbPQCnizxsnLKjTBvwuMG?=
 =?us-ascii?Q?IVIYHG1euFxCENp9hTjAcpo27lmpQafdB7ovgBbFApe3O6c1RA262CVU+Q0H?=
 =?us-ascii?Q?+H327UKvj2HoVN1SDKUdVP2NDR9Q89bt4AxwSoDcp5XShSbhunThlfFIPsIY?=
 =?us-ascii?Q?Wc2NO5vOgsc3Uf2nCbzDnrIYmqwqG4u5Sj2hydPg/3y+lM1/UjztS1SpagAw?=
 =?us-ascii?Q?7/I1iMbJ3Ok7IoBiKtQtvSCC/rcs5Z0ZUUhYjchJFnR49mLHfUoil5P0Qliu?=
 =?us-ascii?Q?NvoZ5AzaQZSppSAH8IzkvMq9m619pc8T7LQ5wbXVEqx3oGl1lJm3bIAc3K6x?=
 =?us-ascii?Q?eKtthgk9/WRKdJh5jn/hLYb+R2rwDete8u/II+V6Voh/qyduEKde/3nIbxEX?=
 =?us-ascii?Q?DpKcrodcrSJbvf/ydzWG/D6ElUosFdyP3h+xId21LfwweOx+NUbc5FuEjlIr?=
 =?us-ascii?Q?8tb+jjEcthHmxpAqn4BIV75hYflDViPmklHwT4/lVYTUOY8zPD8DrfKjcNEc?=
 =?us-ascii?Q?NKzcvZtsHD33VzjM0RF/LFwi4ej26B1L20irERoS2OOOcmbniEKB+rUDMMNR?=
 =?us-ascii?Q?19/pl7cnTvodbQ3GCQq+JxtT5oEQP0qkj45eMAPOI7uZylMa4Ou/epWpfB3F?=
 =?us-ascii?Q?fxNMPziZrwvhNF2tT6iEEKojTXz/KGfEf7CsWz67JGhAO2Pu8RWv7oVVlpd1?=
 =?us-ascii?Q?fqMJNHF5RQQvEjljEx2O0lyXC9c1k1Y5hCnNffsugfd+Q8wy0BsipXrzIjOj?=
 =?us-ascii?Q?tgXWFyaLlZ0u7dfRDq+0EzZ8cMGr3LS1/bOLVjqkV2mW+F9dD2d+8k6J0QCn?=
 =?us-ascii?Q?62YkMi7mIxZI5lz85dP+Eaf8CROwS7VqygSxoVjM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Sx9MOokkmW55ZjjU+Gv+L1sVB5ZdwQDahYshZYOAqIYXF1TSai7XYfKwOnvTLn+rjYA7RipWRUr85M1zi+0vPHtJ+H8xCbgRuLqbZwCzqb/lNJDO+bmElEA8CP/Kg2Buxskzd6cNwJR6U4aWMBwMlmB9I60Cqbmg6UCQPUPK53LclKvfgvRNkHxnk5lB66KnpoK7fDLQfEv5qmMdZfodIKSL2HJdaa9C5QwPol/s3ZKDkhH3vM77AzZF+UCTmRuFTtACfEFAFdBhwk1wfu+ShVnKvC51hKs5SMMx2kz/k6EVlm2AKQbiZkbQznbev6RgLwzTXrJFz0UQk1cIHM+I78GlzbC9XkLBOOVZTj41ihxGOKSeA4iu5xIyzN0yMZUFIGfK7Hc5hb6hdP2sI9bYU6oTXY94B1sraI2IzxtYnYwcP1n2xh7Kff5AfFVM4tQbcI5aWdraZ81eQWhcjFq74Af6FRq0BCtp1f4P5vwVj0dfSqvXY+u/w8xt9dWzkhevpYNlXw22w4EbDHqJVW1kB5aKtIH12IJFKzXXu4OpOfPVHlfO/FxV0QQQipFjwoRx5eTcKvSI97+7ypICykGrfA5BzRTsqoQbQeJzQWPcIwk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657fa6f0-e6fb-476f-e892-08dd54663b3a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 00:00:21.6313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZac1GP1wO82g8qm5LAFqTrOpKHLTLDLMsHEMWjVrgKw8lFAvRFvZWvGz08Adh5Q2vypweSOrGnP/7GLoapuOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7806
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_11,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502230190
X-Proofpoint-ORIG-GUID: 2HKaZFt0Vjdg_-KBsOd0aCmIZRy_nJom
X-Proofpoint-GUID: 2HKaZFt0Vjdg_-KBsOd0aCmIZRy_nJom

On Sat, Feb 22, 2025 at 11:24:56AM +0200, Lilith Gkini wrote:
> On Sat, Feb 22, 2025 at 12:58:20PM +0900, Harry Yoo wrote:
> > On Fri, Feb 21, 2025 at 04:57:24PM +0200, Lilith Gkini wrote:
> > > On Thu, Feb 20, 2025 at 06:21:14PM +0900, Harry Yoo wrote:
> > > > On Thu, Feb 20, 2025 at 05:20:00PM +0900, Harry Yoo wrote:
> > > > > On Sat, Feb 15, 2025 at 06:57:01PM +0200, Lilitha Persefoni Gkini wrote:
> > > > > > The condition `nr <= slab->objects` in the `on_freelist()` serves as
> > > > > > bound while walking through the `freelist` linked list because we can't
> > > > > > have more free objects than the maximum amount of objects in the slab.
> > > > > > But the `=` can result in an extra unnecessary iteration.
> > > > > > 
> > > > > > The patch changes it to `nr < slab->objects` to ensure it iterates
> > > > > > at most `slab->objects` number of times.
> > > > > > 
> > > > > > Signed-off-by: Lilitha Persefoni Gkini <lilithpgkini@gmail.com>
> > > > > > ---
> > > > > >  mm/slub.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/mm/slub.c b/mm/slub.c
> > > > > > index 1f50129dcfb3..ad42450d4b0f 100644
> > > > > > --- a/mm/slub.c
> > > > > > +++ b/mm/slub.c
> > > > > > @@ -1435,7 +1435,7 @@ static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
> > > > > >  	int max_objects;
> > > > > >  
> > > > > >  	fp = slab->freelist;
> > > > > > -	while (fp && nr <= slab->objects) {
> > > > > > +	while (fp && nr < slab->objects) {
> > > > > 
> > > > > Hi, this makes sense to me.
> > > > > 
> > > > > But based on what the name of the variable suggests (nr of objects),
> > > > > I think it makes clearer to initialize it to 1 instead?
> > > > 
> > > > Oh, actually iterating at most (slab->objects + 1) times allows it to catch
> > > > cases where the freelist does not end with NULL (see how validate_slab()
> > > > calls on_freelist(), passing search = NULL).
> > > > 
> > > > It's very subtle. A comment like this would help:
> > > > 
> > > > /*
> > > >  * Iterate at most slab->objects + 1 times to handle cases
> > > >  * where the freelist does not end with NULL.
> > > >  */
> > > > 
> > > > -- 
> > > > Cheers,
> > > > Harry
> > > 
> > > nr is the number of "free objects" in the freelist, so it should start
> > > from zero for the case when there are no free objects.
> > 
> > Hi Lilith,
> > 
> > You're right. It was an oversight.
> > 
> > > Oh, you think its on purpose to catch edgecases, like a defensive
> > > programing sort of way? Huh, thats interesting!
> > > 
> > > In that case it would prevent a case where every object in the slab is
> > > freed and the tail of the freelist isnt NULL like it should be, maybe because
> > > of some Out-Of-Bounds write from another object, or a Use-After-Free.
> > > If that pointer is some gibberish then the chech_valid_pointer() check
> > > on line 1441 will catch it, set it as NULL in line 1445 with
> > > set_freepointer() and then break from the While and continue with the
> > > rest of the program. nr will correctly remain as the number of freed
> > > objects and the freelist will have a NULL in its tail, as it should!
> > 
> > Yes, but corrupted freelist implies that the number of the free
> > objects (nr) may be invalid? (if free pointer in the middle is
> > corrupted).
> > 
> > But that's another story...
> > 
> > > But if the pointer isn't some random address and instead is an address in
> > > the slab, lets say as an example the address of a free object in the
> > > linked list (making the freelist cicrular) it wont get caught by the
> > > check_valid_pointer() since technically it is a valid pointer, it will
> > > increment nr to slab->objects + 1 and then exit the While loop because
> > > it will fail the conditional nr <= slab->objects.
> > > 
> > > Then later on, in line 1470 slab->objects - nr will be -1 which is not
> > > equals to slab->inuse and enter the If case where it will set the
> > > slab->inuse to -1, but because slab-inuse is an unsinged short it will
> > > be stored as 0xFFFF, ie 65535, corrupting the slab struct with an
> > > unreasonably large "inuse" value.
> > 
> > While (slab->inuse + nr != slab->objects) will prevent overflow,
> > I think either way is functional, because it prints error when there are
> > more or less objects than it should have on the freelist.
> > 
> > > You mentioned validate_slab(), I assume you are refering to how it
> > > searches for NULL when it calls on_freelist() and if it does find NULL
> > > in the freelist it will return 1 (basicaly TRUE).
> > 
> > Yes.
> > 
> > > In the example where every object is freed it will return TRUE
> > > regardless if NULL is in the freelist or not, because on_freelist()
> > > returns search == NULL if it doesnt find the search in the freelist. In
> > > this case it would be NULL == NULL which is TRUE again.
> > > This will have the same behavior even if we remove the equals sign from
> > > the While, like the Patch suggests.
> > 
> > Ok. that's actually a good point.
> > 
> > But as validate_slab() expects to return false if there is no NULL
> > in the freelist, I think we need to fix on_freelist() to support that?
> > 
> > I'm not sure why on_freelist() returns (search == NULL).
> > It has been there since the beginning of the SLUB allocator
> > (commit 81819f0fc828).
> > 
> > Since commit 53e15af03be4 ("slub: validation of slabs (metadata and guard
> > zones)"), validate_slab() started passing NULL to on_freelist().
> > Looks like passing NULL to on_freelist() has never worked as intended...
> > 
> > Can we return false in on_freelist(), if it could not find
> > target object (search) in the loop? (need some testing to verify,
> > though...) regardless of search is NULL or not?
> > 
> > > I am still pretty new to this so I apologize for any mistakes. I
> > > appreciate the feedback!
> > 
> > Your questions are valid.
> > 
> > > Is it ok to refer to lines of code, or should I copy paste the entire line?
> > 
> > I prefer copy-and-paste because sometimes it's not obvious what commit
> > is HEAD of your repository.
> > 
> > > I understand that even small changes could have a huge effect to some
> > > other function or subsystem in ways that might not be obvious to someone
> > > not as familiar with the codebase.
> > 
> > That's why we need to be as careful as possible and test the code ;-)
> > 
> > > I hope I am not coming off to strong or anything.
> > 
> > It's ok. I don't think so.
> > 
> > -- 
> > Cheers,
> > Harry
> 
> Hi!
> 
> > Since commit 53e15af03be4 ("slub: validation of slabs (metadata and guard
> > zones)"), validate_slab() started passing NULL to on_freelist().
> > Looks like passing NULL to on_freelist() has never worked as intended...
> 
> Haha, yeah, it would seem like.
> 
> > Can we return false in on_freelist(), if it could not find
> > target object (search) in the loop? (need some testing to verify,
> > though...) regardless of search is NULL or not?
> 
> You are right, I should write a test driver that uses on_freelist() and
> analyze it through GDB with QEMU to see how it actually behaves when I
> have the time, but just looking at it I am thiking that something like 
> `return fp == NULL` could replace the `search == NULL` and check if NULL is
> at the end of the freelist or not, in addition to my original patch.

On second thought (after reading your email),
I think it should be (fp == NULL) && (search == NULL)?

When fp is NULL after the loop, it means (the end of the freelist
is NULL) AND (there were equal to or less than (slab->objects - nr) objects
on the freelist).

If the loop has ended after observing fp == NULL,
on_freelist() should return true only when search == NULL.

If fp != NULL, it means there were more objects than it should have on          
the free list. In that case, we can't take risk of iterating the loop
forever and it's reasonable to assume that the freelist does not               
end with NULL.

> The reason I m saying this is cause the While loop is looking through
> every non-NULL freelist pointer for the "search" pattern. If someone
> wants to search for NULL in the freelist that return 1 will never
> trigger, even for normal freelists. If "fp" was ever null it wouldn't re
> enter the loop. Thus the result of the function would be search == NULL
> because the original writers assumed the freelist will always end with
> NULL.

Agreed.

> As you correctly pointed out there might be a case where the freelist
> is corrupted and it doesnt end in NULL. In that case two things could happen:
> 
> 1) The check_valid_pointer() catches it and fixes it, restoring the
> corrupted freelist.
> 
> 2) The check_valid_pointer() fails to catch it and there isn't any NULL.
> 
> 
> In the first case the problem fixes itself and thats probably why
> validate_slab() worked fine all this time.
> 
> The second case is pretty rare, but thats the case that validate_slab()
> wants to rout out when it checks the `!on_freelist(s, slab, NULL)`,
> right?

Yes.

> Also to make my added suggestion of `return fp == NULL` work in the first
> case (since it does corrrect the freelist we want it to now return TRUE)
> we could also add a line that nulls out the fp right after the 
> `set_freepointer(s, object, NULL);`.

Why?
fp = get_freepionter() will observe NULL anyway.

> But words are cheap, I should test it out dynamically rather than just
> reading the code to see how it behaves. Feel free to also test it
> yourself.

Yes, testing is important, and you should test
to some extent before submitting a patch.

> I know I am supposed to send a proper Patch with the multiple added
> lines, but for now we are mostly brainstorming solutions. It will be
> better to see its behavior first in a debugger I think.

I think it's generally considered good practice to discuss before
writing any code.

> I hope I am making sense with the thought process I outlined for the
> return thing. I probably shouldn't be writing emails ealry Saturday
> morning, haha.
> 
> Also I really appreciate the kind feedback! The Linux Kernel is infamously
> known for how rude and unhinged people can be, which can make it a bit
> stressful and intimidating sending any emails, especially for someone
> starting out such as myself.

You're welcome ;-)

-- 
Cheers,
Harry

