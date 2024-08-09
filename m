Return-Path: <linux-kernel+bounces-280996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FB994D1B4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885BD282814
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E55195980;
	Fri,  9 Aug 2024 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U9E/PbCO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ikvVkJRK"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6FF1E49B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211859; cv=fail; b=AoBQSWUTU5FciERb6X/0T5TGucdaHKr4DedD5mdQxB4LTu/UXt0szGT+/SZwhda3wCoQ3UR1ShOitf+ZJ1mJRGdpRbvur08F6sZS6Xmj38ZnobAWTm6WtK8q8guZDAp+FpicjKxS02Akrfe0HeteGc5RIA/urWE/Afcd2vM8bGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211859; c=relaxed/simple;
	bh=g69CslI+KJED1oi60jov2G03QcSW+UTrhgF2E3Pw4m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ONgaCPm61zOldTZIoYwrY1el12DF7s4Pc+JjjMnhVTCY605ewVQSdDW3iRu2I85FZKYB0eJF1LwDZC6WECFXVEXK0NsB4hyx/BNJmzCjcvJLsf4VnS9V3S3MmZoDIQ6Kh+FJmbcBX+7VevwTY+WOUSK0rCm/DUEZrhRkn2IzYgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U9E/PbCO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ikvVkJRK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4798fagJ030920;
	Fri, 9 Aug 2024 13:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=x2qI+8m32puU3Fl
	w/Y3IDWaEC3T2PkBMd3k/HMDIIIM=; b=U9E/PbCO63D0qMjuR95RaxNVPlhkLpJ
	V2gJ76SygSXVvqADiJnvYIhFgyaMlJYnQS+a99EpYM8xl3cZQMmt/Ma+WBfZzSUg
	GRvWegkGP/R4f0DnfN58U8Pdw5TBigHRAPgh+gnNkaBSGspVN72ByKHZESvAO/mQ
	ESu/Qf6KUoAfJPgmVzrUVvT5wys6ll3mjPSPnGkpiD/xrxE3B3aCV00VYGpz5l3B
	TNErVAU1JuYbJ6vERpWJUJVrblRAVall1+l1KacFQUimSEKXEyKbPpX4QB2blGSU
	ajEEESlBvx6F8l93e0axRDNmZUiNRoD3pM4eP0+F4s3rFy/ceKZlU2w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbfav49f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 13:57:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 479CJSKe023766;
	Fri, 9 Aug 2024 13:57:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0jpvtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 13:57:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+OiI9XpQBPPNDNmkyvyF+MAtBJawSkV6QaVq9J07E1srppYCanM2DC53ZieB9yKyVzbBm/KN2EsfEvyjq96hDFqBU9VqSAp7H9OmPX5bDDKlJq/xqt7BY2isrEh5gnGBojZpBPHmTrL8HaGMYfv0m7Zkxl9vktqR6ZzfPCfgSJ4CPE7DSZWubqvf+vXLBA1+suZJj+EgChfAEKLzEnZ3t9uqBjbboa/WBQjujp4qN48E0yTW2PUokN7kVPFaNlnpaMdHHbSOu7UbUkuBJ2APFwt3mjJRyniRWgZmHtsFC1zrqMtPXPYWyr2SqE5WZcY64roz/P4AiblhcvcXsiGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2qI+8m32puU3Flw/Y3IDWaEC3T2PkBMd3k/HMDIIIM=;
 b=UzBHtIQKtv8DO+0Lj48m7euFvJtng0k5uy32XrEHaBsvMuPlS/JHKRt/CVxsPYdxqLCRFPnd/P6VJUWrsyYDPjdTLzVvWubqC/dB5qUmNx1fnw8yGHI2k6RHgPpDV+/URCDKHgNoEbAZY/UM4lzWhFrYkirIb7pRp5bA7RyzfJ4CMzUEtR3bQvY3jp9XhGVtmC0M4kACo7tTbudeN3kxMzX+ApP6NSgt3aeqFCh2WTgamByk7RF3Y8jfNz1PZ8sNOpdpkakmMWb0+CplIkZjH1477qUCw0bLlKhtj5vYdTXCzxymQPA1un2eN/gnoFMtchhyEIhHWkwpylhx47oIwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2qI+8m32puU3Flw/Y3IDWaEC3T2PkBMd3k/HMDIIIM=;
 b=ikvVkJRKuiYfUah8aL6V/gBOkmqHP1tAJdZtuepTDkV03c/Na5qTqBnAzwYOj17N3caOEaesL6SFAYZytBzYvO661/xJoKgiAkfVjR2O4H0di11rU+0c0rczictudo05gWmxNYThVQ/CRgKHG6IEBoMa5vXjGBWfMRCnH80oGzQ=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH2PR10MB4309.namprd10.prod.outlook.com (2603:10b6:610:ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.9; Fri, 9 Aug
 2024 13:57:18 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 13:57:16 +0000
Date: Fri, 9 Aug 2024 14:57:13 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 09/10] mm: refactor vma_merge() into modify-only
 vma_merge_modified()
Message-ID: <f87b18e5-9caa-472f-9fe7-2ba30e4b46cd@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <5ffdf3241d10bfe96371947a27f596bf21761af8.1722849860.git.lorenzo.stoakes@oracle.com>
 <8c490115-59fe-4e87-ac07-ec7dd6a3ccd3@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c490115-59fe-4e87-ac07-ec7dd6a3ccd3@suse.cz>
X-ClientProxiedBy: LO2P123CA0083.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH2PR10MB4309:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd1d30b-e7ee-4472-49de-08dcb87b2dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?crhBnaBm9n8pNVPaGXWsCpD31MHUEi/I434lgpKePuLCkdvJFwV8zAsZ6ief?=
 =?us-ascii?Q?szkan5haqf/d6+xNHyBA5aws2j78CnPkphlqkQ5ui2t3mugv5tFUa2u+8fwQ?=
 =?us-ascii?Q?x2aTrslyY/Zb7upo0Xos5oq7ju2s8TU2y0gY66qeAmQDKXCiDKYnkmrUDwDE?=
 =?us-ascii?Q?UkcRZMvXk0YJ2cxUJNl/k75hj0Xsd90Cb8EHZxhMdH2rBj6n+MzwHOUuaECY?=
 =?us-ascii?Q?teVhk32+MGpLRDcRRXg/RoTKqXb1/owJRHAUOkqb9HQJ/bjLjYGPf1BJ5u/G?=
 =?us-ascii?Q?1CMjSwMPhRF5i+0uHpH1CmYqpuwHOajlS2yePD83PXIG8bDlvQGycadKj7aU?=
 =?us-ascii?Q?rPLsp8lFIYfWquW+Z00iawDt9efMtoF2VvRBaTljLaqSoIqn0LY6RaD8dNwx?=
 =?us-ascii?Q?chShw3+LHJFqk/QWYfezqO0Dcbf/pYt0488WHv2hNsypQUb8oP5UAFshgAhM?=
 =?us-ascii?Q?H97M5f5W26mzFY8LnQqxIx1ySYpaozEBrouwWKln76sYeTxqzjpgU72XQBiL?=
 =?us-ascii?Q?bXRV+LA1a//EesEipqHzphPfxBcVxASnouANgfMPcCbVLVy/Obw2gw/IwQWp?=
 =?us-ascii?Q?Vu42N8Usf4A7VE9kjz9wssskulTKjzZesIPbpNbCSSQ0FgyMjWzW6x6rBuPZ?=
 =?us-ascii?Q?/7bOXaB4p23qNatpJLcwmgaNyCoIMNB955C1aRiOQrvZnEFiv/mxAL2Us4Sv?=
 =?us-ascii?Q?yFbToshPb/lqAHMQ7kAgod5/ymqItOE5IXl4Q9tDlRpJ1Intupwm1PM/YuRS?=
 =?us-ascii?Q?h6MfDPGff4wx62V1muZEuqOEr0F2+ExLtUgaEdptGGdJALlMZ5Jsc/uangmM?=
 =?us-ascii?Q?LnaKD+WUewkSxUy89WZ+69GkAM5AZA4P+yU+rzbHCVeJKRBhc/g6IcujkMPO?=
 =?us-ascii?Q?5lde/8DnD1aDpwYNI93oV800f+CVLYVxy06kPyMOEcmNCMHG0QPTc8fh0ZEq?=
 =?us-ascii?Q?cxUhMXwloKyYD8AbnGExnv/+vlU1m3VXe7RZpl2uxUYoMXmFUFxnzLg+gKb8?=
 =?us-ascii?Q?Hs1D4S5r1f9Y3hQ0MmSi1UWT7HM2pruZmyd7jtfqRYv7TA8M1f4JUjK6f2ne?=
 =?us-ascii?Q?iEgjOALa4/wwUTsLs2rovpTxJTAcVr6zSyWjYKb66yj2Hdi6v2R8O/gcq29I?=
 =?us-ascii?Q?Ig6vDjudqAGZnQeEI7i10lWiQvkELkvD2NGgFJC9jLNgq4CA3s/kNU5RimYe?=
 =?us-ascii?Q?XwgsVXbN4tR/lAr4uzKmVbRsTg401ncyMtKVkoFFyF58yiGjnuNR0/C2xYch?=
 =?us-ascii?Q?dCp57WUtHlw55TJonyRWSbrw+qK/4tUKLM4jpSGtYzM7qdkSVxEybUGSBZGq?=
 =?us-ascii?Q?fu0j7fCXzBt9DKptLHvbkuY2XK1y1XNJfdGmxSe0MndrPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xqv4ZGJV8GYmDIFMQWhPA3H4Qb6pTV6+EMbmN/lTB3SsPdOWkFz6X5SqgDio?=
 =?us-ascii?Q?SkfXqBJldgaVyq+99I6S5o+GrjdGHGpbu0XtCNKAGzafpxA8CcyJEH8NrBbM?=
 =?us-ascii?Q?wfKbosXTcifMuuaV1a+ZerWXipCoXhI571kBJQ95efOAnidCgC6duMeVtBOs?=
 =?us-ascii?Q?CNNxX4OH0+1WfmP3WMhn/FQoJKn+X5m6FTtFXGGlZxJjWt3+v17fkwYY5SPf?=
 =?us-ascii?Q?LiPEGUPGP/wKBez1vU1kihKmfymz6kxI45tBZOmT0bymT3FGj+CFiDFiTq2f?=
 =?us-ascii?Q?dNvm6cb1Rh0qwNQCPF+YVQcT2G/U6xe2mMz0ExcuCw8W+0YDUOp4q0UrTLEw?=
 =?us-ascii?Q?h8WWGxKnrEezI6QGC7hleva2atiwkLtLoWOLhJJtoAObP8JjWDwqJNh6gEcS?=
 =?us-ascii?Q?Q3xNPN9GSDneJXG9YL+Z8iU5mpMhGVBos3VaD15avg7JhVT0bNp1BtMjdCKo?=
 =?us-ascii?Q?dPDi8I2ECCD8ug1N/efD5P9r/Eg0wFqeh9zXFf4aSgNJFJkRmKnE9fEA9QSV?=
 =?us-ascii?Q?FEflKCf9GDHwDRsTqoKHgsLSkEmpmoACKxuFcSzcfeB1s3UmXFnGrnYK617r?=
 =?us-ascii?Q?Vx/gESzBQj1CnP1/WSkUcTJ1deH1FgqJd+e6/8pct2zAVmfNfZQORVdKQcPE?=
 =?us-ascii?Q?sF1y18B7I2jhldrU3nWRgn2c7dq3gw2162hfgFbWU+8Jrs0VK7gEps90gWsj?=
 =?us-ascii?Q?+g4hYj6o3lbgXyEg5HCOMJ6AIMXf2IgJpoOqWNnyclVVYiTEe/loKVtuxgnn?=
 =?us-ascii?Q?WvA1G55zmR0AZuUu+CgeczXtOdD/IG8gECncQcJ78tt4pE8YOII7TCC2vlhI?=
 =?us-ascii?Q?glkGVpWeeJ2SxaJ+/hqiayT5Q/zWj8Q9U8TPgu3vtZo8z+X05HGwsrdhbNP7?=
 =?us-ascii?Q?IUhTXABoDqWq0wZowWsn96Lz0hGf+/EwG/jA7GzzyvU/5QJKwzFdmkD6Eu5Y?=
 =?us-ascii?Q?llSCjFwcP2Hr0LgDRTh7b5D0Slm2p9voLHE7cM9wkxEvo+WblK5Bn4lOIWFG?=
 =?us-ascii?Q?dtTGLMMKlhON9QPFe5IMdV8NhJS5zA7nQezT6Rpmj8N5oOy5FVng0wQk1TyQ?=
 =?us-ascii?Q?4c5wBpyiIeUM5Ar/YJqKRURE0mp9VdCThTxbr7AGVFI8cvUzjiLDKGX884m+?=
 =?us-ascii?Q?X28KCDTRvnxyvNSUK5HUpfo+MdM/XAo+KKsxTmp6IR8fNqddj/UY3UGUCw2u?=
 =?us-ascii?Q?LY4LZCKpYUZE+BZf1PYjXAG84epAexzm+iFFMMrRGGVW3RP8HC227rtyujYD?=
 =?us-ascii?Q?aLPSZRm1Et0P8fc0huomCg2C9RnP6MlrpKX+r6eycO9RYzefHov6fmow4Ww1?=
 =?us-ascii?Q?LBKGg1WXomIRSQOhysRfwu7ROzaDd1MrI8BdZyShorOUGdCvIyI3WFM/TwIz?=
 =?us-ascii?Q?lX1nZ1qOmtQ7TteXgEWEfQ50XQftTQA/OGTDRyWq7GUk9xwsPL0a3x+zM6OC?=
 =?us-ascii?Q?DlxT9sG+mU+JrxXjMvll7xIjbralp3oqYNJbhHKV/5u80u3E6ts7K2TTXlTg?=
 =?us-ascii?Q?E/bQWcwjbvsr+cajz9xxkUT/YLfZXnkutFRksxkNHaSmRLaB1/VaYMTNyLsf?=
 =?us-ascii?Q?2rTBSo+/6VvCtJ8o1iKFquToAJrzbpN7460YTpeS7sOIp5PRy3SGxljFAMJD?=
 =?us-ascii?Q?ot2ewa40pJYtsx9a/i9Fb1bJoh6ysjYmft5HG1JXP+maTRGFzaniCnCZzPWi?=
 =?us-ascii?Q?atn3EQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/8j0ruOuytAH+Y80R1nO/zsABkuPVoo1/qi0kmOj04HwcQ5IrVZAzm3o9j5rIv7AKHGbakqKZ/HxbrnCHrTh0MORt/tiIJx7UwxsEmfYa/s4mWY4yvv5RbEjXUdBbPyLbPRKR547qM4IW09L7AqtQV7Q6fvo/6+sUJRc6SHK4Zr6ee89Fpv4xOia9HBzZIxfdmTBaFbFey5x7tm+cXCdH9yEtf+vCzL8XmcSIf8TC3G5RJtK9W5BI3r7kHo6/Bi6r13KuoAJXw7kl8gMFtTtzn1ZSoHRpLjRbbeyRTs1jUj48cVSOJ2OeRnugn3tiKvLPF7LQ4LHKgkpjeUH6vJKjfecuNFvVHllNzy39AOUf9A1YRxE4y2WLM0pAoNMkYDdlwlch1hZ7mpOPyJwfiPPMw8pRC3GeUHd4I7oCV0AmAKNzEqtXfUrE6w9eKC4St/rSZXSzYKzRt5A4b/LZKntZDUuymakQ2BYUIN5N9MTURopZrKNWL5S8jBNBWjmVlDlAiWGOrwQltIRhSzDnXSFANemnOygyrMlcd124Id5TTK0cB8pk3aKasEHL+BOPvOvCng69tKBu2Bd5OOlRbtGim/SbgGvYDw0FznZMEbNUyo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd1d30b-e7ee-4472-49de-08dcb87b2dbb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 13:57:16.8915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEivoeVb/4cN2jRuK55XoEyp7dH+rUQ9S2RdyTf5qx/dTnRGugtPWq8dWTHCy9OVKPgbGdAf54xHfMoNhbYSnyuxsTz5c8Un+pBKmBmgB9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_10,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408090102
X-Proofpoint-GUID: _tngadcVEohGlSXEns2zLoaATtQG4Mwg
X-Proofpoint-ORIG-GUID: _tngadcVEohGlSXEns2zLoaATtQG4Mwg

On Fri, Aug 09, 2024 at 03:44:00PM GMT, Vlastimil Babka wrote:
> On 8/5/24 14:13, Lorenzo Stoakes wrote:
> > The existing vma_merge() function is no longer required to handle what were
> > previously referred to as cases 1-3 (i.e. the merging of a new VMA), as
> > this is now handled by vma_merge_new_vma().
> >
> > Additionally, we simplify the convoluted control flow of the original,
> > maintaining identical logic only expressed more clearly and doing away with
> > a complicated set of cases, rather logically examining each possible
> > outcome - merging of both the previous and subsequent VMA, merging of the
> > previous VMA and merging of the subsequent VMA alone.
> >
> > We now utilise the previously implemented commit_merge() function to share
> > logic with vma_expand() deduplicating code and providing less surface area
> > for bugs and confusion.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  mm/vma.c | 474 +++++++++++++++++++++++++++----------------------------
> >  mm/vma.h |   6 -
> >  2 files changed, 232 insertions(+), 248 deletions(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index b7e3c64d5d68..c55ae035f5d6 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -569,8 +569,7 @@ static int commit_merge(struct vma_merge_struct *vmg,
> >  			struct vm_area_struct *adjust,
> >  			struct vm_area_struct *remove,
> >  			struct vm_area_struct *remove2,
> > -			long adj_start,
> > -			bool expanded)
> > +			long adj_start, bool expanded)
> >  {
> >  	struct vma_prepare vp;
> >
> > @@ -607,6 +606,236 @@ static int commit_merge(struct vma_merge_struct *vmg,
> >  	return 0;
> >  }
> >
> > +/*
> > + * vma_merge_modified - Attempt to merge VMAs based on a VMA having its
> > + * attributes modified.
> > + *
> > + * @vmg: Describes the modifications being made to a VMA and associated
> > + *       metadata.
> > + *
> > + * When the attributes of a range within a VMA change, then it might be possible
> > + * for immediately adjacent VMAs to be merged into that VMA due to having
> > + * identical properties.
> > + *
> > + * This function checks for the existence of any such mergeable VMAs and updates
> > + * the maple tree describing the @vmg->vma->vm_mm address space to account for
> > + * this, as well as any VMAs shrunk/expanded/deleted as a result of this merge.
> > + *
> > + * As part of this operation, if a merge occurs, the @vmg object will have its
> > + * vma, start, end, and pgoff fields modified to execute the merge. Subsequent
> > + * calls to this function should reset these fields.
> > + *
> > + * Returns: The merged VMA if merge succeeds, or NULL otherwise.
> > + *
> > + * ASSUMPTIONS:
> > + * - The caller must assign the VMA to be modifed to vmg->vma.
> > + * - The caller must have set vmg->prev to the previous VMA, if there is one.
> > + * - The caller does not need to set vmg->next, as we determine this.
> > + * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
>
> Also there's again some assumption about vmi? :)

Yeah I will add.

>
> > + */
> > +static struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg)
> > +{
> > +	struct vm_area_struct *vma = vmg->vma;
> > +	struct vm_area_struct *prev = vmg->prev;
> > +	struct vm_area_struct *next, *res;
> > +	struct vm_area_struct *anon_dup = NULL;
> > +	struct vm_area_struct *adjust = NULL;
> > +	unsigned long start = vmg->start;
> > +	unsigned long end = vmg->end;
> > +	bool left_side = vma && start == vma->vm_start;
> > +	bool right_side = vma && end == vma->vm_end;
> > +	bool merge_will_delete_vma, merge_will_delete_next;
> > +	bool merge_left, merge_right;
> > +	bool merge_both = false;
> > +	int err = 0;
> > +	long adj_start = 0;
> > +
> > +	VM_WARN_ON(!vma); /* We are modifying a VMA, so caller must specify. */
> > +	VM_WARN_ON(vmg->next); /* We set this. */
> > +	VM_WARN_ON(prev && start <= prev->vm_start);
> > +	VM_WARN_ON(start >= end);
> > +	/*
> > +	 * If vma == prev, then we are offset into a VMA. Otherwise, if we are
> > +	 * not, we must span a portion of the VMA.
> > +	 */
> > +	VM_WARN_ON(vma && ((vma != prev && vmg->start != vma->vm_start) ||
> > +			   vmg->end > vma->vm_end));
> > +
> > +	/*
> > +	 * If a special mapping or neither at the furthermost left or right side
> > +	 * of the VMA, then we have no chance of merging and should abort.
> > +	 *
> > +	 * We later require that vma->vm_flags == vm_flags, so this tests
> > +	 * vma->vm_flags & VM_SPECIAL, too.
> > +	 */
> > +	if (vmg->flags & VM_SPECIAL || (!left_side && !right_side))
> > +		return NULL;
> > +
> > +	if (left_side && prev && prev->vm_end == start && can_vma_merge_after(vmg)) {
> > +		merge_left = true;
> > +		vma_prev(vmg->vmi);
> > +	} else {
> > +		merge_left = false;
> > +	}
> > +
> > +	if (right_side) {
> > +		next = vmg->next = vma_lookup(vma->vm_mm, end);
> > +
> > +		/*
> > +		 * We can merge right if there is a subsequent VMA, if it is
> > +		 * immediately adjacent, and if it is compatible with vma.
> > +		 */
> > +		merge_right = next && end == next->vm_start &&
> > +			can_vma_merge_before(vmg);
> > +
> > +		/*
> > +		 * We can only merge both if the anonymous VMA of the previous
> > +		 * VMA is compatible with the anonymous VMA of the subsequent
> > +		 * VMA.
> > +		 *
> > +		 * Otherwise, we default to merging only the left.
> > +		 */
> > +		if (merge_left && merge_right)
> > +			merge_right = merge_both =
> > +				is_mergeable_anon_vma(prev->anon_vma,
> > +						      next->anon_vma, NULL);
> > +	} else {
> > +		merge_right = false;
> > +		next = NULL;
> > +	}
> > +
> > +	/* If we have nothing to merge, abort. */
> > +	if (!merge_left && !merge_right)
> > +		return NULL;
> > +
> > +	/* If we span the entire VMA, a merge implies it will be deleted. */
> > +	merge_will_delete_vma = left_side && right_side;
> > +	/* If we merge both VMAs, then next is also deleted. */
> > +	merge_will_delete_next = merge_both;
> > +
> > +	/* No matter what happens, we will be adjusting vma. */
> > +	vma_start_write(vma);
> > +
> > +	if (merge_left)
> > +		vma_start_write(prev);
> > +
> > +	if (merge_right)
> > +		vma_start_write(next);
> > +
> > +	if (merge_both) {
> > +		/*
> > +		 *         |<----->|
> > +		 * |-------*********-------|
> > +		 *   prev     vma     next
> > +		 *  extend   delete  delete
> > +		 */
> > +
> > +		vmg->vma = prev;
> > +		vmg->start = prev->vm_start;
> > +		vmg->end = next->vm_end;
> > +		vmg->pgoff = prev->vm_pgoff;
> > +
> > +		/*
> > +		 * We already ensured anon_vma compatibility above, so now it's
> > +		 * simply a case of, if prev has no anon_vma object, which of
> > +		 * next or vma contains the anon_vma we must duplicate.
> > +		 */
> > +		err = dup_anon_vma(prev, next->anon_vma ? next : vma, &anon_dup);
> > +	} else if (merge_left) {
> > +		/*
> > +		 *         |<----->| OR
> > +		 *         |<--------->|
> > +		 * |-------*************
> > +		 *   prev       vma
> > +		 *  extend shrink/delete
> > +		 */
> > +
> > +		unsigned long end = vmg->end;
>
> Nit: This is only used once below, thus could be used directly?

Yeah this is probably a holdover from a previous (maybe buggy before I
fixed it) version of this code which used it more than once.

Will fix.

>
> > +
> > +		vmg->vma = prev;
> > +		vmg->start = prev->vm_start;
> > +		vmg->pgoff = prev->vm_pgoff;
> > +
> > +		if (merge_will_delete_vma) {
> > +			/*
> > +			 * can_vma_merge_after() assumed we would not be
> > +			 * removing vma, so it skipped the check for
> > +			 * vm_ops->close, but we are removing vma.
> > +			 */
> > +			if (vma->vm_ops && vma->vm_ops->close)
> > +				err = -EINVAL;
> > +		} else {
> > +			adjust = vma;
> > +			adj_start = end - vma->vm_start;
> > +		}
> > +
> > +		if (!err)
> > +			err = dup_anon_vma(prev, vma, &anon_dup);
> > +	} else { /* merge_right */
> > +		/*
> > +		 *     |<----->| OR
> > +		 * |<--------->|
> > +		 * *************-------|
> > +		 *      vma       next
> > +		 * shrink/delete extend
> > +		 */
> > +
> > +		pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
> > +
> > +		VM_WARN_ON(!merge_right);
> > +		/* If we are offset into a VMA, then prev must be vma. */
> > +		VM_WARN_ON(vmg->start > vma->vm_start && prev && vma != prev);
> > +
> > +		if (merge_will_delete_vma) {
> > +			vmg->vma = next;
> > +			vmg->end = next->vm_end;
> > +			vmg->pgoff = next->vm_pgoff - pglen;
> > +		} else {
> > +			/*
> > +			 * We shrink vma and expand next.
> > +			 *
> > +			 * IMPORTANT: This is the ONLY case where the final
> > +			 * merged VMA is NOT vmg->vma, but rather vmg->next.
> > +			 */
> > +
> > +			vmg->start = vma->vm_start;
> > +			vmg->end = start;
> > +			vmg->pgoff = vma->vm_pgoff;
> > +
> > +			adjust = next;
> > +			adj_start = -(vma->vm_end - start);
> > +		}
> > +
> > +		err = dup_anon_vma(next, vma, &anon_dup);
> > +	}
> > +
> > +	if (err)
> > +		goto abort;
> > +
> > +	if (commit_merge(vmg, adjust,
> > +			 merge_will_delete_vma ? vma : NULL,
> > +			 merge_will_delete_next ? next : NULL,
> > +			 adj_start,
> > +			 /*
> > +			  * In nearly all cases, we expand vmg->vma. There is
> > +			  * one exception - merge_right where we partially span
> > +			  * the VMA. In this case we shrink the end of vmg->vma
> > +			  * and adjust the start of vmg->next accordingly.
> > +			  */
> > +			 !merge_right || merge_will_delete_vma))
> > +		return NULL;
>
> If this fails, you need to unlink_anon_vma() ? The old code did.

You're right, good spot this is a subtle one...

Will fix and I'll add a test for this too. The preallocate would have to
fail, but we can simulate that now...

>
>
> > +	res = merge_left ? prev : next;
> > +	khugepaged_enter_vma(res, vmg->flags);
> > +
> > +	return res;
> > +
> > +abort:
> > +	vma_iter_set(vmg->vmi, start);
> > +	vma_iter_load(vmg->vmi);
> > +	return NULL;
> > +}
> > +
> >  /*
> >   * vma_merge_new_vma - Attempt to merge a new VMA into address space
> >   *
> > @@ -1022,245 +1251,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
> >  	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
> >  }
> >
> > -/*
> > - * Given a mapping request (addr,end,vm_flags,file,pgoff,anon_name),
> > - * figure out whether that can be merged with its predecessor or its
> > - * successor.  Or both (it neatly fills a hole).
> > - *
> > - * In most cases - when called for mmap, brk or mremap - [addr,end) is
> > - * certain not to be mapped by the time vma_merge is called; but when
> > - * called for mprotect, it is certain to be already mapped (either at
> > - * an offset within prev, or at the start of next), and the flags of
> > - * this area are about to be changed to vm_flags - and the no-change
> > - * case has already been eliminated.
> > - *
> > - * The following mprotect cases have to be considered, where **** is
> > - * the area passed down from mprotect_fixup, never extending beyond one
> > - * vma, PPPP is the previous vma, CCCC is a concurrent vma that starts
> > - * at the same address as **** and is of the same or larger span, and
> > - * NNNN the next vma after ****:
> > - *
> > - *     ****             ****                   ****
> > - *    PPPPPPNNNNNN    PPPPPPNNNNNN       PPPPPPCCCCCC
> > - *    cannot merge    might become       might become
> > - *                    PPNNNNNNNNNN       PPPPPPPPPPCC
> > - *    mmap, brk or    case 4 below       case 5 below
> > - *    mremap move:
> > - *                        ****               ****
> > - *                    PPPP    NNNN       PPPPCCCCNNNN
> > - *                    might become       might become
> > - *                    PPPPPPPPPPPP 1 or  PPPPPPPPPPPP 6 or
> > - *                    PPPPPPPPNNNN 2 or  PPPPPPPPNNNN 7 or
> > - *                    PPPPNNNNNNNN 3     PPPPNNNNNNNN 8
> > - *
> > - * It is important for case 8 that the vma CCCC overlapping the
> > - * region **** is never going to extended over NNNN. Instead NNNN must
> > - * be extended in region **** and CCCC must be removed. This way in
> > - * all cases where vma_merge succeeds, the moment vma_merge drops the
> > - * rmap_locks, the properties of the merged vma will be already
> > - * correct for the whole merged range. Some of those properties like
> > - * vm_page_prot/vm_flags may be accessed by rmap_walks and they must
> > - * be correct for the whole merged range immediately after the
> > - * rmap_locks are released. Otherwise if NNNN would be removed and
> > - * CCCC would be extended over the NNNN range, remove_migration_ptes
> > - * or other rmap walkers (if working on addresses beyond the "end"
> > - * parameter) may establish ptes with the wrong permissions of CCCC
> > - * instead of the right permissions of NNNN.
> > - *
> > - * In the code below:
> > - * PPPP is represented by *prev
> > - * CCCC is represented by *curr or not represented at all (NULL)
> > - * NNNN is represented by *next or not represented at all (NULL)
> > - * **** is not represented - it will be merged and the vma containing the
> > - *      area is returned, or the function will return NULL
> > - */
>
> RIP our precious diagrams.
>

I always disliked these... and I can say so because I was involved in
changing them so it's self-criticism too :)

Very much representing the overwrought complexity of trying to do
everything in one function.

