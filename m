Return-Path: <linux-kernel+bounces-297889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 525C995BEDB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8A5AB23DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072931D1F7D;
	Thu, 22 Aug 2024 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VYg7RxJM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bGwzU7jx"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2BA1D1F4E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354820; cv=fail; b=k4wkUslvpzOwfTMP8AcmVDT7y/NsR57ATggYUpU2pKKAk9GiPqcgOd6YCy4z4167wZCT5I6Okc9T/xJr7NjokSPPjbJRU9dfN62HkEZoPrFdXRPP3aqKVg0XICPvARPfTxETT7wbveIsyvtdzAED1JPpeT3aSx7mqmox3OaGQAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354820; c=relaxed/simple;
	bh=FTgPHsnHJZh/sl4Sa1jEE+kHVAYm/TA+EbiK6qtGo3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rAoG9srcAD0o+3wn/5DzdPgHXgKeVcvbkFCE1Gw2MepeQEPpaSm6zPvvBVpBZZf7UEOo8yq5n4QNJB6/Ym2ScURym8DkNCmJHHSL7dv7Q7+hdVnJDZsMqpPf/V/OI/qivFR5w4uIHpj8lar2zOEFa1LM9Jf/I6kIzR4UdDxBA7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VYg7RxJM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bGwzU7jx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMXAO029758;
	Thu, 22 Aug 2024 19:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=RKhc07Fbuk3qCe2lrKepHFoKO/JwtwJK4RHQzIAhFhY=; b=
	VYg7RxJMXC58fPuV0nhFlldKDexpm5j2kPsUsWFjV4Tcj+OAsmPESQ3VI1NfTuRQ
	ctvac4oYpHu3zfcajW+pkrEeNKb+nO6LfVbkue+80C5BipqWP3cHglflOinfCej0
	WVu9EISCns067H/YOxkIoGOtwpoOeTjn3R0R92iouVxwTryTpMA0BjZ2YowRbkDQ
	+idOCEbYeyOuk9daf5hdwA+mK5GbHxUH8rocBvp+u7D/dJdXI0j9XJilEPxXc3bY
	jr2Qs+t/Tj2AVt+qxqji64ER9Ga0FlIGy1F4W9+qbZqO2chD5FdSAJoCUIgrs6qj
	2kvKIzCgH3APs4NW5Nyyuw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m67jrrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIqaPw019453;
	Thu, 22 Aug 2024 19:26:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 416b0b9ckf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfOQSiI//qph2J9YwbBlhiWCqFYxiLAouuDLEbFld316M/mYg6SdSg0O8PazuYW2ghsVLNRWbgRjRZF/oUzo69Gg8t9VETNhK/2LDV+7iDsQGINo10QcCbDlUV6JdPPVEjHxktXmd+Hb7Z/7z5NejJBHmqrbnUjDb7SgL4Dr8glzf/ertUnAgZql14VIlXfPyKoj6NgxSWdOV6jH2XscbkBxQGuUzwHHwottdmyS5vJjaq+HhpJlEhc0I8BD8NGEmUyArSbQBaLddmIW9Il3qYUWKun9k2aeQLUWwJqBzsbY+wsbcvLzoNJ+4eAXILugPFNGgVpzIgbDkUq/D5lYAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKhc07Fbuk3qCe2lrKepHFoKO/JwtwJK4RHQzIAhFhY=;
 b=dUWvmWDw3Ks3MoHt49csrzGOqSVWf42c3YRIcdHcWUknDSFyUu28prVnoMqvtZYv/679Qnxl9jsTJ9bjmvxYPNyEF64fU4TtoOU1TTuKCsJZY0k4eMHhDrYXyaVsrz2FpPHbEF+HKLXCge3BE4LnsKt1mH/h/iTPgrvVtVuziIQwxYpSZrV1sMfq39QOzm4D61ibwuI/bvrVWPaPqcW/0cD+cEsyM1/OtzIj8I0lTOesJGApuyJz5PcvIS1/Jj6pjKlOiVmUSwmQI2w+qgb2lPrJ3EKILleQtfbRb2G+B1eDP7eMQ6UcCa7bpzVxiv/IqlsG71mDsAtFeRq/v6WBJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKhc07Fbuk3qCe2lrKepHFoKO/JwtwJK4RHQzIAhFhY=;
 b=bGwzU7jxn7735D+qhG4eDj89ka/22j9JfvjfBmpDvStZyd7BpbbXLLtoHt0dAfuR9DhAd2UFf8oZrrWO3K9iRjVyk8M6suQQjAqQ0ers5ArV/ynZYtS5ieM3tjWwkodeVYT9GVcbo8cyQbmu2bM8WqkzVn/1zLGShIJIikRnVq0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7761.namprd10.prod.outlook.com (2603:10b6:610:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 19:26:29 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:26:29 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v7 10/21] mm/vma: Support vma == NULL in init_vma_munmap()
Date: Thu, 22 Aug 2024 15:25:32 -0400
Message-ID: <20240822192543.3359552-11-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: c89b1153-a699-40c9-3512-08dcc2e05261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fDxvVSCYSgsRmEK0wd8IrowfhdGrp7zIpv316qvoWn0NYcDED0ZPKPqiDU03?=
 =?us-ascii?Q?8wp9ePTkbrAPRvnNEKGPwnE7c+dYeUYKOHDz7hyX8VoW6sS/gsJRKLu8DCNY?=
 =?us-ascii?Q?9KlfwXUeluNDzGho5MMZe9b+Fa5iYXJMUCGgbEqwOQ5pHVxH+/LhjQoB7S6s?=
 =?us-ascii?Q?N797e7Tx8GLRU5JacYxBJByVpLVVkcM4N86Nussdn6b8ic9ySLavBIYMlkWS?=
 =?us-ascii?Q?UnjGioOwDJ/nX8M9SMJDZClYGQp1oxVNgyZQmJqRlQvq5sLtoNyAZ4kJURYI?=
 =?us-ascii?Q?7NzXAjt2a9JpwW15JkV2uiIRZQuC3QOJlyH4M5SPNXkaRjGEd6jsScoeyNw3?=
 =?us-ascii?Q?nGGCNTAs0cwCrOU+iMAXirPRRv69AxJDqXHRbuzrdMx5Hq0J4wFPJpUnYTkb?=
 =?us-ascii?Q?YQXDBIb2p0yBjVPI6bUhmszBj9NJ66pZhGXO52R351hC//eOjZH4dXlW89Kf?=
 =?us-ascii?Q?dUXGAnXJa1llM+Eeown2o+UXBEqG4pDMM5P2NjB2mp/nUpk35UY7EIZRsRcJ?=
 =?us-ascii?Q?PasJBKE9uxEELurnS4AAGcQZc97aAqusq5/go9HrrxsdbdyCkVT9NU0HEiBV?=
 =?us-ascii?Q?xyoDGeN62fhNWByW9v0x/EDsuAT9AMM70pg2seVr1ppgBYVg9H9cUnUOE0HC?=
 =?us-ascii?Q?vTPWcVB4Zpqo/5hW0m0nREOd/vTFqyLOW1NGk8UJ5edIv0X3yO11elj2DK70?=
 =?us-ascii?Q?1D4aNlmwhWk/U8zaWeaZ/Dp0nOsLkiBd6BiG+rapIve2t8G5pBeiPBDtkrmU?=
 =?us-ascii?Q?2JgFI92zlDnLMA2HiYhALS7qy3sU4Qa+6djoxuopPddfna2QbG781Qb8/Ly3?=
 =?us-ascii?Q?BWRxQLYr1hNm0DQPyEYId5c+SxR+sY+jcUEMnRWvFJQYvFYAkFsHJfm8DEXn?=
 =?us-ascii?Q?sAL23Rb1f9z1bTQMAbUOqokL64i/zNVU608HJZZz0ILsB3GIAtWdgyeRs+Bn?=
 =?us-ascii?Q?SeMCH5QnWgJ97zZKmqrYDFAzbuz3AgY1KWGC/E3mjcsfisaNcD1N1LanGNM0?=
 =?us-ascii?Q?hLLdxkEsFt3ktoRg5sgF1fQzIvByi41DmOkO3qTqvOfMBISWhvc4P7+vinsG?=
 =?us-ascii?Q?Atcu2hQ+WLpjnbW8cRi3KiEBUCDruc6FVg8IpXk/gxCOaM7oLqPiNh4jUqM4?=
 =?us-ascii?Q?7rW/k9rTgYsLly0MdC1ccNQxP8ipoIT9viHdBRo29phnFBEvUOWK3rEhn3BM?=
 =?us-ascii?Q?78la5GPruFBjyIc1Sqb6NQuNyK3GFDoL5wnqtTK/9N6xh1U0MI+khTM42obG?=
 =?us-ascii?Q?Hva0FFxh2W9kRmtRIeU4HOrEHyAA/wLRFwjeL/2yPN6W46XlQVakEaIsafbU?=
 =?us-ascii?Q?mBsUuuSxmo1Pb44Fw3eMkGwNfDsYhd8pElIFStMbtG/TVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rt+XRtI6eoj/EYuZDINfdIpnuPBQClN0vQZMU6Q8Ra/7UlLj7o1pp5mJe50O?=
 =?us-ascii?Q?t/fSCUBGriVBkwhwchOQK7VzWgkvXsifdwKHqeDSuNL4gbKNFeoltc4ZGDtB?=
 =?us-ascii?Q?Jp66TJh//TOdfB3plBoESuFk5FHZpVdmDwn720Tw3aYH/OvHWORecfimW4wi?=
 =?us-ascii?Q?aTmpDAF46J7qWjBfrWqxdMc8CH3P138ZyGsqPpmAEjJz3QffdwlgguworTBP?=
 =?us-ascii?Q?s8THOBeVstswh47suASSxF5hb2KF1ouXGqScqaZzga946bcMB+vv2PHLLRIZ?=
 =?us-ascii?Q?0JmU4J43F7PPmTgoavec1IUGLqcN1B1arB1B0CoAj7VYz1vBb7bVs+q1I/7e?=
 =?us-ascii?Q?QS/wB6SkPjIK6Hm2ztdHBRkdQDM+E2CPAwwIJtsHaaBDr2y4eJqGTVsL967j?=
 =?us-ascii?Q?17fuiEq9vae8L4qAedy2Gskh8QdiDZpvR8HixbMcittg5Zms0BNaJHmIoZbs?=
 =?us-ascii?Q?kLkCQJ/RA7kO32miA1XxmYwwn0syK9uPmYccoj5iccgA1sZ4CXDT1cK/mwcU?=
 =?us-ascii?Q?AR35v+9bTsHKG8YcaCPPgIXKO6KA+l5FCPPntW3muX6di7EOpTTorNp1JAT0?=
 =?us-ascii?Q?+o2/doajizGGcyYNZKiluZZoJwAn7xakV0EkFKqz+qfJdT2vS4wU/NE5maST?=
 =?us-ascii?Q?1UFKJbOtifRc6gEuGX4QmfdWN/f2CFCzFlHjxTxavqUlrdRdwzinIAwBO6Om?=
 =?us-ascii?Q?2LzqolYjmWfvTNnyXjFLwUie0fCjYHVO8/zV+2FWwffFc48M4pihYF2ZpbBM?=
 =?us-ascii?Q?2TMmamS+iMWCdmJGS7oQNf2pArMxOwMSuT1me5+6juRc2WYxxpr9Foc6WnLp?=
 =?us-ascii?Q?QQoxCv6S7uCYJQFF2Jx9eDNVe/DDK26HEYUBqGTW98gu1YAVfckk8UQLkzwj?=
 =?us-ascii?Q?7djIOBEh2F8isVON7gcOmPr2nbjm1sYr8ytvVbMVQHY1IMQHvMyfwyrdEWnY?=
 =?us-ascii?Q?V5yVqaZ+AkVK/AolLx1Mepqn0pFQOEUsH/apWfEC48mNk3kxMErEOQzJutB0?=
 =?us-ascii?Q?oNstLGnAj75wmrSwr3trLJh/rvHesxc/oDeQeu8381MptG8lx7mppnVRH7Xh?=
 =?us-ascii?Q?qVJ/Wd+gs8crzF11p0xOROZxMeh/MWoPJEti2+oHjSaiKLoqSRX/9/yqiBVc?=
 =?us-ascii?Q?p3a5Dq2EP6qrYRJ3OeeOvfBH8nnWmhJK9zhIbVPp9vXR8Z/BckPOWPHW2Yyy?=
 =?us-ascii?Q?tX+0gVCL+L5nNOTEIfihaS2HbekaHawO8N8iBTr10f/34ik+PKlN7dufB0iM?=
 =?us-ascii?Q?+pil1TwY8n+YGtckOQ1SGbW+uw8Yp1nsWyjaguhlEPN0ObzN4EXr9H076me4?=
 =?us-ascii?Q?QcDqu8YQYkEKilEdKfLI8LP+tZGhc8Metvjn0pfIPd1soWgRAnGtYhdXo8jP?=
 =?us-ascii?Q?HbwukCEKDXd3lEPjOTbi++IBdF9YmKR6YCzj5umDE6ozpc3NPnYKTMShp9zU?=
 =?us-ascii?Q?hlHOFpSeghaH0smtKbrl3kayPkmtQh179cWxvJXDAfdKjJuwXQGiZI5Cuy7R?=
 =?us-ascii?Q?Lo9akqs3L4mGeCWmbvArK3bS/bmMJrWYFtrEdH7poyLwTduk//EIy5NyLwQp?=
 =?us-ascii?Q?xDnIl6BnGRbI85eUfr2rWJ+a+Dw4ANpgqETkWGSdUu2l+sSIH1wFtKK7y77X?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bW/wMVG7JkO6k785Rg04yBnEyOhlYRru7+L8AWLIZfUL2PL8GCx2EPptwfhq1pF3X1Jf8AW+ScaAWgH2yrqi8uwFbTwhsV8yoB70KS4XyDt6EUoheqBN1kXzBAJoIeCdCr4L9nh+1h3lUoPimIb8O3OQf4F4iogKIDjpRscvOjAxjGODzzMNU/6GmW+prwQxp9TRv3oryi1hTat6z1/3neU2e3GPwXy/H3I1otNVYZAssGohofndfjqVTIbHulLLlmu2Rtts/HTM0aT1gT2asLTpbmy6LhurBHZT+74nL2hhWgn0UOvdoRrnIFCYSSpdXJNOp9j8PHzz1EwbyV4c0rKX/RLS0r57Hcxo957jhJNPqllNLUjbDC3it8M4Vkn3vaCEDeYLHT0OaNBxs5syhwnD0rRKN2p2m3iU0v9P7jFuJq1NqqXGtM5s6XBeTsDjwT0gUYjSdM1sXq8lY9IlJiaFkhAbY9atNoMT1p0IxKLT55+erI0OvX9Oq5fG3SFnGfX96OMVpoQaee7P60Gw293FdfGdqsAlLxF37Mi2U+ifbn+RU6scaJZ+8LS24uYF2X+pO9jAgMFYPlo7iagof+j9Wwc5K1Vdy0BznBs1AQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89b1153-a699-40c9-3512-08dcc2e05261
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:26:29.2401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lt7MTMHA5MZC0rJ02GvpMnPVSL9V8M3fNJvP48Smz5uWh/G7LKFnMmOczX48RBS7Cl4tSu+LbbPxbzv0PYCig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408220146
X-Proofpoint-ORIG-GUID: ksJX0AYixcUgqwMp0-Iif4tsc88hSg4Q
X-Proofpoint-GUID: ksJX0AYixcUgqwMp0-Iif4tsc88hSg4Q

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Adding support for a NULL vma means the init_vma_munmap() can be
initialized for a less error-prone process when calling
vms_complete_munmap_vmas() later on.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c |  2 +-
 mm/vma.h  | 11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e7e6bf09b558..2b7445a002dc 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1393,11 +1393,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
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
diff --git a/mm/vma.h b/mm/vma.h
index e78b24d1cf83..0e214bbf443e 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -95,9 +95,14 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
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
-- 
2.43.0


