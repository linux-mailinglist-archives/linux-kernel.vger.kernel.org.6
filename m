Return-Path: <linux-kernel+bounces-255623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F14A9342F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833641C20EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06D118EA9D;
	Wed, 17 Jul 2024 20:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LfS6mrRI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fQcGhEC9"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B395618C358
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246875; cv=fail; b=WWRbhm9+oRJkrHAcuI6ONYnF7IPXhvzIgevwVajtxeJ6xvHH2qvFvgZUhAU4NNiMiLrinnnMqdeAzfjU5ZQ+0Vd321dPuPan2NTMZbJkxdylEFDDu8S2FcxD2sOR9AzOkqbm2LlKB/zZBpQB+5b2xd0fuaBn9KpgOHonxIagpG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246875; c=relaxed/simple;
	bh=IhMOLcuSQN/JHaFm4a7nERN/KbYH1yWudUpYznD0MmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zc1sdCJFUEraUboz32Zamj6OkcPAz0IiGjogFgMqaFzYSXRIB45rrhLNbGBv9+XhUMiAEOusyg/C2SlMQmlb5zZCLzNPdm1tM3dsSzB4kU2rTi3REEJhFn2y6K8YbjhBk82396IdJNPrpjkIw6yEM686w1DzTrmJcqHq8tVwHng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LfS6mrRI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fQcGhEC9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HK0js6029063;
	Wed, 17 Jul 2024 20:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=S37ZWrf+uGjTlHx8kEYsOJHDQEEph06qnirTptSS0/U=; b=
	LfS6mrRIfemTMAlMIdrimYUoynbGPKJ+l9SGCvjRCSjk06gmaZikCIhBcisw964/
	M2tuld2XJE2afpY9ItpNykqXn9lV4lWXuECpNLlCQTlkw7Nc+g0zLP7xyMK3Bzkh
	Gi7qnibnuDcvS+BBVhx4pCGYuyuw+EG2CuNFjCeQenA3SE//6XdW1E49G9JR+mnd
	mjcDxKlRI8J3t3acQfMbnybgylEnTVCsFLaLp0C7+6SkgqdsvsEY/QWCne6ukiM9
	oUxEwF20IG3f6OgQI7UL3K5MEvCQ3blUGlH8VSXHqFMkCt4hhCRWLLTfZ6+/Ev38
	ZI2P3q1RcZKNpgdnwJyd7Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40emkyg19x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HJmtKI031693;
	Wed, 17 Jul 2024 20:07:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwexugp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZ/ZwiecW9/6oMuncH6VVKvKsY0NvK+CfK3CvzQoVLz4tytgWumvjMw85uzmz5EPDt1gxP8vHVZqhRjztZSFkfAk3y1izFGPFMUsZVYEl7zUj2GwnuFq2bc/TQmMsSrOtv8YnEnxGQ1a2mMTZCCrrCrryb4zqE9mxRa6awcSndHPEGRfo4nxhz0XzB7VGqHrfLs8KutQZmtzBgUZB6y1PBaYRVN2sqkyGbHQmP6abBPtlD2XeQ19GuYmAhdP/R2BIjSZfnJ/HjcSPxqidAmS9ve+Mvplo8bhBcTJ7NMYAf8QrLqLlKVJPoP0E9Su1TPAy6Q3lgRGuAA4tcOo+0Ho6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S37ZWrf+uGjTlHx8kEYsOJHDQEEph06qnirTptSS0/U=;
 b=p0oe4vs89fd6UGGhEroClw7ydAdzakJiPjh6p72oY4EqgIr3RToNvgoySakZRIjPyuJpKYK4OyxHOZ9hdvOHjGRHFEuKxfOhqFK+cHkGqiOB5vp0GfMoZRqP+BDG29RnMZC2wPNFk+13lyt8QhdvxByGVTRq2mxjttbPyyO4hvr9Ij4DjLFGHewStPM9ztxX3aq9FIwMJS8rd/yZDAjQ9bjoAR+ake5I0D4jyuehKXrdKntBRJmOb6oPKZ2vjuT2wgYp4911NlyMSbSQShdo57+ZbPWJXkgsaM0LTIBnZNzVxJRGoOU50CMhN9sTPMnqxHOew6EaxNBY+SLNHHvY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S37ZWrf+uGjTlHx8kEYsOJHDQEEph06qnirTptSS0/U=;
 b=fQcGhEC9os9r923QtdTBa5LlRjykSpYFHuDM9k2OsPtB5gy7CAs5ZOkY8NDcybIuoBvvy3Jr31LdWKCJRxd7gQrqpOYabHf2oZvobUKeEWvs/XsnBlF5eipeVkpISD96oC3EQ7wjEA6W/ppTPT+0kX+JlegKuva/8mReIGppe50=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB7303.namprd10.prod.outlook.com (2603:10b6:208:40d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 20:07:35 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:07:35 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v5 10/21] mm/mmap: Support vma == NULL in init_vma_munmap()
Date: Wed, 17 Jul 2024 16:06:58 -0400
Message-ID: <20240717200709.1552558-11-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::20) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: e3993f67-2566-42ad-0cab-08dca69c1994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7PN68O8py4iovjHTdV4p2GzTeG8afpWCx49mHftk2xFhZteOhQJokObg/kg6?=
 =?us-ascii?Q?IacHaxRzJVyXgh6lq8UA0QoUf3xrZ5SXi3U8DYWhqp2SsnjAi3oAikLnzKe6?=
 =?us-ascii?Q?yOPM7yn9erFlJ2b5H9jRl5BISAC0JOV45ZUoG9j1AZ0y+RSoSnJuzxAqyxBo?=
 =?us-ascii?Q?FgxP6b+HadhKGj7ksyjxNtnTDZhVdpbpD91qQuXaCf+NEUB5FPbs+CnKceEE?=
 =?us-ascii?Q?OSRjrZrreGxz76HbR0dFI4r5L3iAMKQVAPGubuPfNoGADdwDcXAevhRBKtY+?=
 =?us-ascii?Q?AUiPqRK8wyONOcRBm9Cexd9lVg50w3qiKFDkZA8Rt7NFgVSGVxKaycuSqweA?=
 =?us-ascii?Q?QarhQQhGdCGwy9EbImXDrNHPMTXJr8nLWoDBwaADeXbpBQ5ZflJpRpmXiyRC?=
 =?us-ascii?Q?ZSxVc+w6QZ5jbBCHNm82L+IM/r0jyJaSKxh3pwsUc/CYKPOqzfcuwwfTtb8J?=
 =?us-ascii?Q?MJQSUfqWQgmxHy3apbDt7Fl54olm87xyFbouvsSS/l7UEkAT4z9iYOO8Vkgh?=
 =?us-ascii?Q?8TxXzhpbNXkydf6uwU0FHEykAe4TdR/U2W1xsnRo+n4xdwHCyyUH217DJsXX?=
 =?us-ascii?Q?tgAXRL2eW1eR6FDH4WDyJNvO/95uQfQRoB9/I2NGBRa5KLY+dEDCGsnULfQ4?=
 =?us-ascii?Q?dl5B5UWmYUAD5fgNPaPMrqfBndZCH/x3tcqM3w2/hvXtH6o3VMu0PCg5ya2u?=
 =?us-ascii?Q?iLhTow5xYTCf7XD4xJwxaxMIW8RrqTOqr1kRSwuKzWeZPwjUdEq7FXGaVYtj?=
 =?us-ascii?Q?n6g08w7aZkrOZtAfFk5pNILdwSKRHwreUi6l4TdO/f0p+6mlC76MZHR9t4st?=
 =?us-ascii?Q?2/1kBP1Yv5go1ShX7mI1Fd22qT83SKAbDgDlSa02f7ygIm5VdzzUsR0oDAJU?=
 =?us-ascii?Q?TwUXE5RyyblmPtdFVKiXm4zkYhjyW9Wo5oE9wGUEhMgIko7o2j/v+2a731l+?=
 =?us-ascii?Q?IgaTFhNtweezoyabIbgKePFR/ckKi2Wa3QWtr+Vd3CEUS0enoHcG0/LLgb+L?=
 =?us-ascii?Q?N0nWcwN2YK9rSC5CG/z5VMlWMLcJywNxYWb22zo5yh46E1lY+H+oFPwmtc8U?=
 =?us-ascii?Q?WN+0QrMke96Kh+QEbZLsdtqsRygq0OyWL/D/euzu4ilumalFL+b3rLd1GoyB?=
 =?us-ascii?Q?WD79PyXQ41oRV9Px93xdZ0l3U2I/EqdhC/jU/14qNYl/RdPwEEz4T9gfiRER?=
 =?us-ascii?Q?R5PK+YzskogVCy1P7mCc5YiNIWlW/fjC6WB9hQK9pAGLJyVZ+7A+P3uY4LoT?=
 =?us-ascii?Q?D02xgIsqJzmwXNEXnu5GEYTeD8e18LyvoV8JZOBDcnzdo7NS3eiByo5U2vo9?=
 =?us-ascii?Q?1EoZsBzR/kQ35pdGG55TS3aux0tAEc9c/QfJ8P4fyD9ikg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Z0NV3fsPhkqRQIfXskgBEphkl2zMJCosDKGBghYwvz7s+Rh6/eAc2K0eo4Vf?=
 =?us-ascii?Q?CRrdZlbeOj3k0y7xMpLwX9R0sRASHuSeH5xLy4URMPdCKFtNJ2cxUiDNvgB+?=
 =?us-ascii?Q?Xg8Jg/fYPPg7gH0WmQKo2H/1/8vO+SQE83hfrqnOAUsnBzjb3Wzun+3Phb2A?=
 =?us-ascii?Q?Pz34G26NRWXWpFq0FTTVxvc37jWggQzFI2CS0h2NdRcsGjJZIQ6kHC7uQFIz?=
 =?us-ascii?Q?7eDmZ8IFwG+3qivcdtXZThx9ov78jLN7bE7kNSuKTnEw0AHog4xJWr2Xbpdi?=
 =?us-ascii?Q?69VgMqHHYUC3vPl9klso8Tp4CHuMsMqRkd/FgodYplpu+GO1CyX3OcfbujWb?=
 =?us-ascii?Q?o1T2IcDwdCYTb5sAbzfD0l0VDvHHOVlZMxtSFes8PZzzubl/oORI6Ojej6fu?=
 =?us-ascii?Q?Z0kQCo5JEIytsaqAcSFPQquU7ZgdK/vAzTjq60yJ8HM3s5+vJR5Hh6/Pc1BA?=
 =?us-ascii?Q?anMdySUR6lr8oF4FZpjEMed7P2Q8Y3C5YOzpikhl9i7NDfXOaTxaJaEzmEvc?=
 =?us-ascii?Q?NyRPghj+JQUu1aHl/1QkHJ25i7WyT7/tE3x8Sn+V8qD+p4iKmVZ3HGgMzl+4?=
 =?us-ascii?Q?vXHJJPPTwDwyNtfHCkOedgWYxynKPaumK09j5zfoXNKFjwHkJOUsvCDqTSpc?=
 =?us-ascii?Q?MDTyQEUDi7qct0n/QZ/hEF5QTxMaSWk+kBHqkotLmt8PMJx9YpDZin/cvHOm?=
 =?us-ascii?Q?lr3uUndZR5ZwO9n7yMC0KqVQ8linmLhDfP43m3WoznZJH7/jRCqhnaVnfbPf?=
 =?us-ascii?Q?aWrwocUVJp0bu13KDJbYMhHA+Nyys1IZ30aDEek6KrSCfxcA8p94V4EW0nNl?=
 =?us-ascii?Q?MkeC0SXD4cIasILcGDcemnfUFY7BBnlwUeoPHNTviw036IGcy7CiD47MZWml?=
 =?us-ascii?Q?7i17oGY6iA+WbJUCgQIG2lk+ZOK/Qbfv8Znh1c4QSAVE9Hb8ZVeofV4bjDij?=
 =?us-ascii?Q?ZJtF21pNQ0QtNtgfrEapb+O6HELYlNHNlJsrWqpOe+wRR83ge1vthQpML5DP?=
 =?us-ascii?Q?ON00CGu+bvTmKTh4S5VN5WHrejn+tfXQrineTMKguxXSE2blzdI9gl/SFxmK?=
 =?us-ascii?Q?E3akwWXhbCQcINuRhrkFYDriuj3QFUnvFRcHxmKZFHyOeB2R5G21TZ7QJK4q?=
 =?us-ascii?Q?76rx+zD5RHvN1Y8RbhLMWHwGPJqw8jcyVVtiKtGvY/Kx+J2QcbzkomsBTerw?=
 =?us-ascii?Q?LPbPqzgBGzYJPgwf/7s1jOYwuBqP/aN2cPIPlovKOr3b9EXCOuK5yIO8oTIF?=
 =?us-ascii?Q?Z2qtV20gsbiohhCJRaEI0iWGIQuMjPLuo4Ie7M9SenQioNgedLcneBekU/bE?=
 =?us-ascii?Q?QMFKKc8PJ5oJKboWxJMCyJsdpovMUXyKm2PWuXhKNiYLH3DOO8bWfjuN9YzD?=
 =?us-ascii?Q?u+Bs0CPfT4SO8HK5+d72AjIf6BsQx+S5SiCtzl3+tVMMllzq8LWZQvMT6xQr?=
 =?us-ascii?Q?DI//Sivsy6v6/E7gswWCmtbjXpkzEGKhetBvbzm+wRLixpnEHrLVSeVcm0vl?=
 =?us-ascii?Q?3g+wSKokv5aGHV0v+i2lTLbCu/EF1POT+aMxH7ZJyFzOdW5t7C4l50U5+hks?=
 =?us-ascii?Q?t4Ka+uPkShfNF8l31p06z90MKQPoS/dOA88E61vaPAsRaqAN5cJavgFPsXzp?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Z2z9nbA7/+vrgtoAXCHJhKwnxubioLjulJu8Vd/UGcbJKzdw8R4ZTpJW6nQ4t1JpFmDnk1VeoADSwuq58Uv4E28tvC0SOPOoHvzsTtIi2D77skflS6ELs7cnOoeEKAdreYUppQ5XhlyMJJBEJWDBoiTn/J7qNkPHp2Qy+cT2DKOXlNEkooGSHnPJg8PV9dojPfcVOylmvj1rp7DstR2bG7LzMfB5voH465xXTTnTvAZGzAjCuEPPYWxy9SqoLHXqFSPyX/wcPLmW+8cjioeOqevikEf+qTTZ9vHIh0IK6fiq4vUHpIaUJJIb/ISARKkSPiyb6b3I3sMOxBvKA8D1uPM4B2d9pbA7GBrcjFGvzq1/HQ7WNmXFYv423QSsLFs8cVTOwYCgUK3sapOR95PIUeVmDDUkAY1E+Grrqu0Q5wZPwBk+SN0hlcRh9UtCzQGN6SUOV3lGefZJuDiGQf52ZUiDdV1cettkporl+KO6y0mHiuRPqXuk5F4rhuAY4Vkt73hIbK/pl4Qj6+eRlvQMv27mWOEVuZhRSNetZmJINJiAXsxbCPEVgdWuhASC0v1xjOoO6VA9o7U6Gp+YlOQ2sntA/mWkFQfnsonIdX9AAg0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3993f67-2566-42ad-0cab-08dca69c1994
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:07:35.4887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57YsfsvxnY3Xcr44LgGMAFFFpDH9pazZ9hO9yK+dPJlChGbik0wwh6zK2DGDNX6FWyJxvAC07Cw8wZdjW7gzUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407170152
X-Proofpoint-GUID: wwNEHToBeP4Sd4mr0IdCfKDHLKEjCElI
X-Proofpoint-ORIG-GUID: wwNEHToBeP4Sd4mr0IdCfKDHLKEjCElI

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Adding support for a NULL vma means the init_vma_munmap() can be
initialized for a less error-prone process when calling
vms_complete_munmap_vmas() later on.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index a1544a68558e..722bcced0499 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -517,9 +517,14 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 {
 	vms->vmi = vmi;
 	vms->vma = vma;
-	vms->mm = vma->vm_mm;
-	vms->start = start;
-	vms->end = end;
+	if (vma) {
+		vms->mm = vma->vm_mm;
+		vms->start = start;
+		vms->end = end;
+	} else {
+		vms->mm = NULL;
+		vms->start = vms->end = 0;
+	}
 	vms->unlock = unlock;
 	vms->uf = uf;
 	vms->vma_count = 0;
@@ -2950,11 +2955,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
+	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
 	if (vma) {
 		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 		mt_on_stack(mt_detach);
 		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
-		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
 		/* Prepare to unmap any existing mapping in the area */
 		if (vms_gather_munmap_vmas(&vms, &mas_detach))
 			return -ENOMEM;
-- 
2.43.0


