Return-Path: <linux-kernel+bounces-348098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D8698E278
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74E31B21E55
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121902139A8;
	Wed,  2 Oct 2024 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bNOIU3+Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eIlL06T/"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32261212F1D
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893754; cv=fail; b=UQ9w46Y21YXmQ/QBsVDofr0/y2CPDwY/8ncAzD9J0LQRpXkTcd9N/FRS+KwXwLRRZaSq5S509ru+wagswNi+1dPeBjOc6O/XBXO41ZtyPbRt1Mk+jNtF1S8FdoDE0XbNl3DJORJ67BxWpT93sLaiZC6TydkdspLs9qEZCpKn7fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893754; c=relaxed/simple;
	bh=bhQN43MmUhafZkiZlTqujgGxezZW6uV7BdFoqRQF/Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QIMV8TJ7A9mF3BiTRgE05XxgK9vjtVzkg3K0Gc9nnA2hSJWS2M3tCNXQ6rwXHtaRjOXU3y3R4JQUNI2ZL4pFac1pqe/87cAsqyFuZYn8/loC35jqMaF0fbfEIUSv9qeUGOCuVOU4EbKUxlbFrniIqe/FoQdvXbyBFtfnHfip3Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bNOIU3+Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eIlL06T/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492IMbCU011167;
	Wed, 2 Oct 2024 18:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=zFWQq3LfQcshlA7
	/UpfTKrlFZxTjB4+QKEgOtoe0L8s=; b=bNOIU3+ZlYSXZprU1d2oY7OmqP0KVg0
	SAoOJ6OVKSQXGY8WRjTeqQniUhiBGW2anGgPvc+Wn9Wm/02p5fHBRFB89dLZnRM3
	YZZBOlJFQHEPzahoj9GoqML9TpIwEp4q0TniBUziGcw+HB8vMVzqJZil0nBawR4t
	aetaUJYLWOkEv3103P8ANQnr2ENNe2VnyNz9eHK5tBkswORerZoipqh5RWaHhJhW
	LjvZw+pRsz4vW7Vj+lBkUuGF5C8cIKSRDLmpU3XT7U25yhnaB9fXli/m3Dzrnhrq
	xp2tUbmoc8PSu0O/UWStwPjoErvHFS4HJMdhio9slTP/bfyxgrtrdmA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41xabttab5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 18:29:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492IIEsa026199;
	Wed, 2 Oct 2024 18:29:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x88996ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 18:29:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cak19RHgfSsueRgKOFtk54T9sB5f7jOCthlFEBrAP7dwNidkiHwUNaLWTti2GyEbIUJIXpou4BMjGtq//acaRD7WDjRFY6Qfnbhr5hme6IW9VM9myBNhLnG6+GfcZbl3R52ZPVgKCub7O4aymgcLz1nDkrHlBrGyk5LiaB6Q05OG0jbM9N4dDDFeNZVfRFzEY3KIDew7BrdX+oVjc4rSfLjfW+leP8VUIBrOToDodFbYPrLoJp/VYJ+sqfr037xLEyhOuT/P7Ut2s6/OpL4+dRaf0TItVjblVr5OzKKYcJABDYT+CdvBNsu1g6LOJ6YbTpWLX1t5qvFUvcr3+TznMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFWQq3LfQcshlA7/UpfTKrlFZxTjB4+QKEgOtoe0L8s=;
 b=wMCf4i+J8GxQPmpaQLMdzAHo38eukiDQt2iJj9BNzgoMMkWmKSWMh+A+n8JTTG8RN4WAYEdGA4+VfJRhJ3G3ldDlrZw26ZjXjBugtkqRSh2XSgNYuZsVvlqUEEDYxG09tQC+xjDCFUGHh7EQMhYcUbmk/eglPI7fzYtZeTglYi6Jb5fVU4iOFIvs6DLVvisrxbPRYy0OlnIsWq+6I91IaMxso/Z0x6Mxg0k8KwLPeKSAJM3zCnlwWPaNKdDgo+HubMAUfAcNIPBZPlXQz0F+7QRqHjPK+Iww3u/8e15Rn5Iez+tqsQiXQ5uIMqvLUa3wTfrQTdrAcCrWNGz0DeuURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFWQq3LfQcshlA7/UpfTKrlFZxTjB4+QKEgOtoe0L8s=;
 b=eIlL06T/oiM1UUjVPu5zEEyc5XOg3tP+8NbIUJH/y3oJsCMDx3rrRRckY6s3sVU0oX7ZfVQCWvgksLTwFVtketA6Y4Dv/zHLRoBbWkRUiQRmg7lcMyU40bZScMFsz2lQ3Dcv6XKWMspGqhIzjtiU8c1C1TRoXb1tlULtCMUP/Qk=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SN7PR10MB7045.namprd10.prod.outlook.com (2603:10b6:806:342::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14; Wed, 2 Oct
 2024 18:28:09 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 18:28:09 +0000
Date: Wed, 2 Oct 2024 19:28:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <cf72fda8-5fc5-437b-a290-6a2c883e6adf@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
 <26991b8a-9fc4-4cf9-99de-048c90e7a683@lucifer.local>
 <32c0bcb3-4f05-4069-ac18-3fc9f76c6f7f@lucifer.local>
 <9d8761c5f32e2bad14b23772378a0a856b51003b.camel@web.de>
 <c63a64a9-cdee-4586-85ba-800e8e1a8054@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c63a64a9-cdee-4586-85ba-800e8e1a8054@lucifer.local>
X-ClientProxiedBy: LO6P265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SN7PR10MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f8b76b-0d88-41f0-ede7-08dce30ff747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LTWRhhH5YMgS6Rws5NATHRiLjXB5oy1U7ZnLrgGD2k3Mm7jggpNKCu1sM1II?=
 =?us-ascii?Q?ta+RP4qF22oHN9FFiST1ie4LAR7YadRWJJ5JQythlVZ1Buxv86R3vNUlh0cF?=
 =?us-ascii?Q?axnwk6tSJDjOmA36I+3bZYVN6tnVNy1NWapCUNvoIaKsVThzqEPjZEOldEBv?=
 =?us-ascii?Q?p1z8kPVYObQeYtOl4DCFB9/GEMnDFF+vvZUg+qD/mS7/l186MSaGQQM8FjQx?=
 =?us-ascii?Q?WrApzPwPzdE1iSY6s31d2gZyHnHtV17pfn/DY83ACE2isRcclcCM4+vZsUlb?=
 =?us-ascii?Q?IvCxp41x+TZ0ABtxrUVf5V0kvEx+U9IU9e0CFfyfbcVdZPNOXs9Bq8j9XLJv?=
 =?us-ascii?Q?MgegbNOrVKkn4nzBzAulTQ7ftifACc55JvwKV3SQdUtUlom653SBG9nB5JXr?=
 =?us-ascii?Q?KNcrlKU/n39v786JFUL/i0VmU+FJIb3WDYVrh7lHeb3LIILYr7fGSTDhEr8R?=
 =?us-ascii?Q?/Z0Txd+SP/DQ8+P1cVaSRGXZHz2DTCFZW+fG70UuSEQrjBCrz1msuV5KrvKC?=
 =?us-ascii?Q?x+jzW4icwZe5w+Pn5QDrqlWjYotWRZSX6OmD62mHGEcza2x6K9GylCgw3V1B?=
 =?us-ascii?Q?om/znQu2iUPrIsHAlGTxWBYum7jN2SXvYRM8kfTuswgJctRv/7XxfSySCm0A?=
 =?us-ascii?Q?HeeqMadWxxZshirp3OqKrUs7DUmW5rvkKH4owB/xNi00wFCycY2oZXFjuPoQ?=
 =?us-ascii?Q?2g8V6wJsvjz2y3OYyGO3wZpA1FRwB1jSIyPdzz4WQTMytR1J8UiC8OOCl4E4?=
 =?us-ascii?Q?6+Xvjn+GsM2Sstrl86uIzZyGu3Bq4E5VLS/FEmX8mgLBW0nxGMzUl0WWvysG?=
 =?us-ascii?Q?GU1/h0D/KlJjIVvOuzfB/1alhXLfQXwGxS7aPS85fwvn55bSa2KafhMnPmPm?=
 =?us-ascii?Q?GMOOnaIm8plsS3naQWlsBE6Yj9bfVhIj2BNYOCbi7aHpaTBx5w3Oh0Rtq0Sr?=
 =?us-ascii?Q?NG59ZLM81P0LIPyaYVjuYtWgKJ1pLfUW6ZpCkRtR7g1jd/plLmquRcu4gAdy?=
 =?us-ascii?Q?brGVkGWkecwtyuzGTJ2SZKRTSnWq46Q8sjA6ot/H0X8T+w94ao1EtlZ4rxS9?=
 =?us-ascii?Q?bECznn/TehtQI6hqvQN9suRYXFZ0XYr50bXtfrm9FIhMmB10LIu4GhhEkaR/?=
 =?us-ascii?Q?+NT7lYcjdT0yd4r/KODPCxUne59eMN8smQgM9dw9UiKySJpdbKz/SykO6HbH?=
 =?us-ascii?Q?sBruHLnp+tg2s4QGTB7tpX4y3iqKeNJ4JZlGnMxAKgxSYNMbAyRaAxnuca26?=
 =?us-ascii?Q?Nh/HExVm+JMHbck1JdVmEKynZ36roirF1Kqjk0kbwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0IdQv+X9Lfd3IY7uFyLmdfUOwpufZT+nVQsJITj1YMcDevnI8F6LWE6WSuTu?=
 =?us-ascii?Q?DiwFfH+Ojq65IcubXJbPhvS9f4pCrS7vNbjfAvX+YwiUXOaTmhHVlH5HvR//?=
 =?us-ascii?Q?fFUoeu2LTFdnFPPTP5R8k3AMz+nVDureeA0DHo7lgK9lJSVb35aRAd6s8Bx7?=
 =?us-ascii?Q?EYJUXyCFU/1m3lpFurwa6ZdAG7nRMdaS9CBp7dZIaxEizStcygGDmlHj9ws7?=
 =?us-ascii?Q?ty74Z7Eye68BxPPm8EDSduPbMLFDSOtLhFNR8bAzJDULX4VniVJAmbuGxWji?=
 =?us-ascii?Q?HaisPnwOmYVSQcaya/zzprj1kyZyF1xIELL4szVvfwccpu2Z/+N8aW91tOjZ?=
 =?us-ascii?Q?/MPHpypgWaR2ZuUqMQ6FuwmKXcWa84nlVuhmNkSbrEA204COsYr4EmIWGe/v?=
 =?us-ascii?Q?yWRJ+bc2FKfX4b6wwu4R1LPTofHoHOtVSxp3PN6NWq0qiHMlV7Cf2oGiZbh5?=
 =?us-ascii?Q?N/rInMFCSHrcOCF18DJX6QcIPUyNRikpgeX/+pvZDme9wqE8RKRuQF6G7TtX?=
 =?us-ascii?Q?JIDRirimGH8fvrGRtWr/DvCuE8osLt/2IqMpbr4lHtngkhiwGcnad+DOe835?=
 =?us-ascii?Q?zFlNidCS3mT/hnyp4/VD+7/t0ibBkdSLkKOz47aLBL4gjr6saPzZLqMnFv79?=
 =?us-ascii?Q?AzHlB55voMPkQJecmO9YWNG1I7pf5iZJqYksTZFwR5mbX+rqh4NL4R2qu3jH?=
 =?us-ascii?Q?8OSNRbY3hSujb3g6Sy6WtVpMPW0m3h0TnxYHJFgRHu2SbC8XRGk9paVAiTkh?=
 =?us-ascii?Q?H07uKA6p8TkC36yaup8WJcYbzN863opollJMPGLNHWZJObxoc9Vw60wD9u0V?=
 =?us-ascii?Q?on5pqlFt8IwwP6LnVyeP07AdZlfnh6NHs2YjgHCN0OvDT/c2E1mq6Bo24JSR?=
 =?us-ascii?Q?5Vzsl83pfvBIx7n+PSjp64QKGMs4UsoIoJ5vI4vb/61LDwy72ctfSO+P8uxA?=
 =?us-ascii?Q?IRWrZ28LJRxMDLk2d3QPJtbXL08qhgfvCisg56pFjWuaalG2kCaCm08YURzc?=
 =?us-ascii?Q?sL4vim9kpZXX+yPfeX/+modBoFANalexf+MtjduznJil1NpV+DkvOxgdYWq1?=
 =?us-ascii?Q?ciAjdrwVKtuUGVt7m4u6I+SBUlw7P2OC7LdFAPw6P00URH4vwhfn6scbduYC?=
 =?us-ascii?Q?kNCGXjlSNsirZfOikyjURVC7GoYTJuuyqDFFmFPDzHoBwYuVN+r1cksK8MbY?=
 =?us-ascii?Q?Hx4yIFm3MOL2aLUgPp6w/DuIV45HGWadKh4ptYTag2OcQXoYHOtZiq/o2CWD?=
 =?us-ascii?Q?2Fr2+J2gH/W61bcZ8AsMQqAswUaAk9Z+/B4Yf5Ca35m5T3laoffZZghgNtzj?=
 =?us-ascii?Q?qrc197fpkaHrhWwWqkrI/pxqZ3x0VvPJ6n1svrkf0rH6zDv6e9FqAim/k0WU?=
 =?us-ascii?Q?2EOlV9uHTNIhJh4Ji2TaUxbJiVzMwOm2V5QeaRL7yfvb23ZUwxvoIBW/S7dq?=
 =?us-ascii?Q?G87c0UA7TgFqixx8pEzYZVLYfphzUassGTvwZCkunOFalKXAtLDMhbD2/5Bg?=
 =?us-ascii?Q?NC0XSIm48lTvw96vVkDvT8tXwlgLV+R9nsMBJ3hDF1CoNSOcgje/h8js7dMP?=
 =?us-ascii?Q?VUNb+2kJz/LSQOnI8W9ahAwyiU1S6C22eMiafaL+v42hnwaJ3LuVVnsaac+O?=
 =?us-ascii?Q?Na8KpwIUM2dWFreal5tDitZabrAARweqEgrzX90JTNremIIRQhb9NLYr5W3L?=
 =?us-ascii?Q?mQOq6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8jJp9tTkpazZr6JNOjGaOCuTEIcDQjLPT90+oE7UhgrexxwXE/ySyGJeJ6SECIjO5FxhqYvxTr7nX6Zm3A6XL/IjjskGXR/U5MGfyQPUe/CZvIR5RKkEY6OQdMEdqQ/3vLgzPkJOzlesMbeUjRAkXakZ9GcHnPFhleXC9yVLK5YzJLPI0xjuK5LNfELpJh2SO7b+6u20CabYY4USI3rNyUHcfzIErGdfiNF2lSYiH5rzRiig9i1PGbqkq5MdHb/Mg9SgPJ/+/9p1M11iSTpP44vxKanAGBA2odUKtUoYZgdVFJrZnmo8ek6SpVu6sn7pxjov6gKwK8dsaHL74PlMIkEdOOKP2MH/CcqIi2gNdt9KVgqPjZcuW6Gl921qnN3D3Zfw5fJslnRm5/GvrxmIM8bxyH4ZIUDWkEejR1Rf5yTQJulrApYMCfbQ1jvgELLaoyP8fArw7jALXm5HHt1+x8s2bb32O7tPGsAFtXK/hMhg2opvBxZIPmIzFNR6JiZVWZt8RwCdpmcKn1LirouQnh7BMYHSOj9mR+eXk7Ppclnin33B2pVEuRkou/t5kC6wO3beHM6bY+gMXpruEKgE8DKvu3Hun0pyXbxgh7pIA30=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f8b76b-0d88-41f0-ede7-08dce30ff747
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 18:28:09.3215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzpqPRaHPTvFcKF6sd5jKnsE8+qSRgPP3wrSmxJoaQxQ2Zd6uC59yQ8kPxAuBGZUEkI5dRKB5avX+23XqV8m9OzOKoXYHPYCO07S4qPXrt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_18,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020134
X-Proofpoint-ORIG-GUID: CkJSmWXdOdTwuICLEUwHv45FhK92ZVjw
X-Proofpoint-GUID: CkJSmWXdOdTwuICLEUwHv45FhK92ZVjw

On Wed, Oct 02, 2024 at 06:19:18PM GMT, Lorenzo Stoakes wrote:

[snip]

>
> Current status - I litearlly cannot repro this even doing exactly what you're
> doing, so I wonder if your exact GPU or a file system you're using or something
> is a factor here and there's something which implements a custom .mmap callback
> or vm_ops->close() that is somehow interfacing with this, or if this being a
> file thing is somehow a factor.
>
> Recreating the scenario as best I can with anon mappings, it seems immediately
> before it triggers we are in the position on the left in the range with the
> problematic node, and then immediately after we are in the right (plus an
> invalid entry/pivot for 0x68000000).
>
> The final action that triggers the problem is mapping [0x1b90000, 0x1bae000)
> PROT_NONE, MAP_RESERVE which merges with A and D, and we unmap B and C:
>
> 01740000-017c0000 ---p 00000000 00:00 0       01740000-017c0000 ---p 00000000 00:00 0
> 017c0000-01b40000 rw-p 00000000 00:00 0	      017c0000-01b40000 rw-p 00000000 00:00 0
> 01b40000-01b50000 ---p 00000000 00:00 0	      01b40000-01b50000 ---p 00000000 00:00 0
> 01b50000-01b56000 rw-p 00000000 00:00 0	      01b50000-01b56000 rw-p 00000000 00:00 0
> 01b56000-01b60000 ---p 00000000 00:00 0	      01b56000-01b60000 ---p 00000000 00:00 0
> 01b60000-01b70000 ---p 00000000 00:00 0	      01b60000-01b70000 ---p 00000000 00:00 0
> 01b70000-01b80000 ---p 00000000 00:00 0	      01b70000-01b80000 ---p 00000000 00:00 0
> 01b80000-01b86000 rw-p 00000000 00:00 0	      01b80000-01b86000 rw-p 00000000 00:00 0
> 01b86000-01b90000 ---p 00000000 00:00 0 * A   01b86000-68000000 ---p 00000000 00:00 0
> 01b90000-01b91000 rwxp 00000000 00:00 0 * B   < invalid 0x68000000 entry/pivot >
> 01b91000-01bae000 rw-p 00000000 00:00 0 * C
> 01bae000-68000000 ---p 00000000 00:00 0 * D
>
> It seems based on some of the VMA flags that we _must_ be mapping files here,
> e.g. some have VM_EXEC and others are mising VM_MAYREAD which indicates a
> read-only file mapping. Probably given low addresses we are setting up a binary
> set of mappings or such? Would align with PROT_NONE mappings also.
>
> This really makes me think, combined with the fact I really _cannot_ repro this
> (on intel GPU hardware and ext4 file system) that there are some 'special'
> mappings going on here.
>
> The fact we're unmapping 2 VMAs and then removing a final one in a merge does
> suggest something is going wrong in the interaction between these two events.
>
> I wonder if the merge logic is possibly struggling with the (detached but
> present) VMAs still being there as we try to expand an existing VMA?
>
> Though my money's on a call_mmap() or .close() call doing something weird here.
>
> Investigation carries on...

Hey Bert - sorry to be a pain, but try as I might I cannot repro this.

I've attached a quite thorough hacky printk patch here, it's going to
generate a ton of noise, so I really think this one has to be a link to an
off-list dmesg or we're going to break lei again, sorry Andrew.

If you could repro with this patch applied + the usual debug config
settings and send it back I'd appreciate it!

This should hopefully eek out a little more information to help figure
things out.

Also if you could share your .config, ulimit -a and
/proc/sys/vm/max_map_count that'd be great too, thanks!

Again, much much appreciated.

Cheers, Lorenzo

----8<----
From d85fb5d2fd096e84681bdb6da8b5d37f0464ff84 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Wed, 2 Oct 2024 09:19:28 +0100
Subject: [PATCH] hack: mm: see if we can get some more information

Add some dreadful printk() hacks so we can try to get some more information
on what's going on.
---
 mm/internal.h | 15 ++++++++++++
 mm/mmap.c     | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 mm/vma.c      | 34 ++++++++++++++++++++++++--
 3 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 93083bbeeefa..cd9414b4651d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1443,4 +1443,19 @@ static inline void accept_page(struct page *page)
 }
 #endif /* CONFIG_UNACCEPTED_MEMORY */

+static inline bool check_interesting(unsigned long start, unsigned long end)
+{
+	const unsigned long interesting_start = 0x1740000;
+	/* Include off-by-one on purpose.*/
+	const unsigned long interesting_end = 0x68000000 + 1;
+
+	/*  interesting_start            interesting_end
+	 *          |--------------------------|
+	 *           ============================> end
+	 *        <=============================   start
+	 */
+	return end > interesting_start && /* after or overlaps... */
+		start < interesting_end;  /* ...overlaps. */
+}
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index dd4b35a25aeb..8a1d5c0da86f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1341,6 +1341,18 @@ struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
 	return vma;
 }

+static void ljs_dump(struct mm_struct *mm,
+		     unsigned long addr, unsigned long len,
+		     vm_flags_t vm_flags, bool is_unmap)
+{
+	if (!check_interesting(addr, addr + len))
+		return;
+
+	pr_err("LJS: %s mm=%p [0x%lx, 0x%lx) [vm_flags=%lu]\n",
+	       is_unmap ? "munmap" : "mmap", mm, addr, addr + len,
+		vm_flags);
+}
+
 /* do_munmap() - Wrapper function for non-maple tree aware do_munmap() calls.
  * @mm: The mm_struct
  * @start: The start address to munmap
@@ -1354,6 +1366,8 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 {
 	VMA_ITERATOR(vmi, mm, start);

+	ljs_dump(mm, start, len, 0, true);
+
 	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
 }

@@ -1375,6 +1389,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	VMA_ITERATOR(vmi, mm, addr);
 	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);

+	ljs_dump(mm, addr, len, vm_flags, false);
+
 	vmg.file = file;
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
@@ -1390,6 +1406,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,

 		vmg.next = vms.next;
 		vmg.prev = vms.prev;
+
+		if (check_interesting(addr, addr + len))
+			pr_err("LJS: prev=[%lx, %lx), next=[%lx, %lx)\n",
+			       vmg.prev ? vmg.prev->vm_start : 0, vmg.prev ? vmg.prev->vm_end : 0,
+			       vmg.next ? vmg.next->vm_start : 0, vmg.next ? vmg.next->vm_end : 0);
+
 		vma = NULL;
 	} else {
 		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
@@ -1413,9 +1435,29 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vmg.flags = vm_flags;
 	}

+	if (check_interesting(addr, addr + len)) {
+		char *special = vm_flags & VM_SPECIAL ? "special" : "";
+		char *has_file = file ? "file-backed" : "";
+
+		pr_err("LJS: Interesting [%lx, %lx) flags=%lu, special=[%s] file=[%s]\n",
+		       addr, addr+len, vm_flags, special, has_file);
+	}
+
 	vma = vma_merge_new_range(&vmg);
-	if (vma)
+	if (vma) {
+		if (check_interesting(addr, addr + len)) {
+			pr_err("LJS: Merged to [%lx, %lx), addr=%lx, end=%lx\n",
+			       vma->vm_start, vma->vm_end, vma_iter_addr(&vmi),
+			       vma_iter_end(&vmi));
+
+			mt_validate(&mm->mm_mt);
+		}
+
 		goto expanded;
+	} else if (check_interesting(addr, addr + len)) {
+		pr_err("LJS: Failed to merge [%lx, %lx), reset...\n",
+		       addr, addr + len);
+	}
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
@@ -1441,6 +1483,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (error)
 			goto unmap_and_free_vma;

+		if (check_interesting(addr, addr + len)) {
+			pr_err("LJS: call_mmap() on [%lx, %lx) old_flags=%lu new_flags=%lu new range=[%lx, %lx)\n",
+			       addr, addr + end, vm_flags, vma->vm_flags, vma->vm_start, vma->vm_end);
+		}
+
 		if (vma_is_shared_maywrite(vma)) {
 			error = mapping_map_writable(file->f_mapping);
 			if (error)
@@ -1467,6 +1514,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			/* If this fails, state is reset ready for a reattempt. */
 			merge = vma_merge_new_range(&vmg);

+			if (check_interesting(addr, addr + len))
+				pr_err("LJS: flags changed for [%lx, %lx) from %lu to %lu %s",
+				       vma->vm_start, vma->vm_end, vm_flags, vma->vm_flags,
+				       merge ? "merged" : "");
+
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
@@ -1510,10 +1562,18 @@ unsigned long mmap_region(struct file *file, unsigned long addr,

 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
+
+	if (check_interesting(addr, addr + len))
+		pr_err("LJS: mm=%p: iter store addr=%lx, end=%lx, vma=[%lx, %lx)\n",
+		       mm, vma_iter_addr(&vmi), vma_iter_end(&vmi), vma->vm_start, vma->vm_end);
+
 	vma_iter_store(&vmi, vma);
 	mm->map_count++;
 	vma_link_file(vma);

+	if (check_interesting(addr, addr + len))
+		mt_validate(&mm->mm_mt);
+
 	/*
 	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
 	 * call covers the non-merge case.
@@ -1530,6 +1590,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	perf_event_mmap(vma);

 	/* Unmap any existing mapping in the area */
+
+	if (check_interesting(addr, addr + len))
+		mt_validate(&mm->mm_mt);
+
 	vms_complete_munmap_vmas(&vms, &mas_detach);

 	vm_stat_account(mm, vm_flags, pglen);
diff --git a/mm/vma.c b/mm/vma.c
index 4737afcb064c..33f80e82704b 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1108,8 +1108,13 @@ void vms_clean_up_area(struct vma_munmap_struct *vms,
 	vms_clear_ptes(vms, mas_detach, true);
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		if (vma->vm_ops && vma->vm_ops->close)
+		if (vma->vm_ops && vma->vm_ops->close) {
+			if (check_interesting(vma->vm_start, vma->vm_end))
+				pr_err("LJS: mm=%p Closing [%lx, %lx)\n",
+				       vma->vm_mm, vma->vm_start, vma->vm_end);
+
 			vma->vm_ops->close(vma);
+		}
 	vms->closed_vm_ops = true;
 }

@@ -1179,6 +1184,10 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	struct vm_area_struct *next = NULL;
 	int error;

+	if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
+		pr_err("LJS2 vms->start=%lx, vms->vma->vm_start=%lx\n",
+		       vms->start, vms->vma->vm_start);
+
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 * Does it split the first one?
@@ -1202,6 +1211,11 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			goto start_split_failed;
 		}

+		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
+			pr_err("LJS: mm=%p vms=[%lx, %lx) split START of [%lx, %lx)\n",
+			       vms->vma->vm_mm, vms->start, vms->end,
+			       vms->vma->vm_start, vms->vma->vm_end);
+
 		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
 		if (error)
 			goto start_split_failed;
@@ -1217,12 +1231,23 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	for_each_vma_range(*(vms->vmi), next, vms->end) {
 		long nrpages;

+		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
+			pr_err("LJS: mm=%p vms=[%lx, %lx) UNMAP [%lx, %lx)\n",
+			       vms->vma->vm_mm, vms->start, vms->end,
+			       next->vm_start, next->vm_end);
+
 		if (!can_modify_vma(next)) {
 			error = -EPERM;
 			goto modify_vma_failed;
 		}
 		/* Does it split the end? */
 		if (next->vm_end > vms->end) {
+
+			if (check_interesting(next->vm_start, next->vm_end))
+				pr_err("LJS: mm=%p vms=[%lx, %lx) split END of [%lx, %lx)\n",
+				       next->vm_mm, vms->start, vms->end,
+				       next->vm_start, next->vm_end);
+
 			error = __split_vma(vms->vmi, next, vms->end, 0);
 			if (error)
 				goto end_split_failed;
@@ -1295,9 +1320,14 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	}
 #endif

-	while (vma_iter_addr(vms->vmi) > vms->start)
+	while (vma_iter_addr(vms->vmi) > vms->start) {
 		vma_iter_prev_range(vms->vmi);

+		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
+			pr_err("LJS3: addr=%lx, vms->start=%lx\n",
+			       vma_iter_addr(vms->vmi), vms->start);
+	}
+
 	vms->clear_ptes = true;
 	return 0;

--
2.46.2

