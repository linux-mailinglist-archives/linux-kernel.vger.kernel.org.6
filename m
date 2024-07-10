Return-Path: <linux-kernel+bounces-248155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F9492D903
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0690C1F22870
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775D1198824;
	Wed, 10 Jul 2024 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iXqu4pEL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KGdvoCN9"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D1819007C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639426; cv=fail; b=M163BNy29tEfD5R76djlIHFVkbte05FZmwdA9Q8ejtHTpCGWN19vejYvFbqfzaCt5/xa5MmaRiZRgatrPHYGBjKuL8OoZJqaiLuPbH8ExDYS9IgCRKPytcgnhKo3mkcg6ZDNhMx7euIRhGOxfUBkQYuLnWmf+FS5GOQHrPiA8r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639426; c=relaxed/simple;
	bh=HxBHxkKm3AhqwDr6kUdVgq6UsZzfrODotR8onovNq+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FfZ2JwKz4Xrz9gKfNmT/46x89pI1yXDnte0ywfc0TOstLqdtfPkd7O1qxPfy/YpA/5W7DLi/t1/tHYDXiOQMJa8BzzBzKEznj9koykIsb2VG5i/AuHc9sriwLTNNi/lVqG1hmKJBdgs8l46s5hn9yt6jB/+aM6fK/OF29cuahBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iXqu4pEL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KGdvoCN9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AFjKmQ019272;
	Wed, 10 Jul 2024 19:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=wem2AJBoTGHtBckyqvpen9uiSUKgs9mhKNjHQHA0o5E=; b=
	iXqu4pEL4R3T86JONcL6mO3LUi4elvurQNNkiDIIiwrAUnb5yw88ZY6hSb9P1091
	C5J2tcqi6zadycxYUZ/Ltc3hOjjdIulvp1eXOGunqmuXl6kHjgQ/jGeZPqodpf49
	fVOXnAVxrcYHKHddo4SF1TkCBMCV9FGxGCoHDnQtE+qlBBAvhG9OGI6OB+NKDAiJ
	dTALgxTrvvSAjKvUqSxLvPLkIXuWQQCXAHkJRJy2BMcEWiaU2IymRqT4mMbCPO/s
	lLE3uD4m26S/0U8Tp5pgVLUc79ZkBpc9Tg7Czm6Rt1c6yPxnYdgKkRAy0iTUnT37
	jmfYbETenU2aYJptZwEblA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wky83q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AIihM9033699;
	Wed, 10 Jul 2024 19:23:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv1948k-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhpRj9Ck7xN/rILqUZwbcd7jtsAo75m+Rgtaa3by39DpQ2XnBN3Rwal75qDTnM6vCwC2Z2PXtFRu52ivPL1T+J/geTXZemvoWIqIRLY31Nh9ReQQp5cJXq2sGlYuc3Eu7GryNxW2/2hlyzMxXB9L9sn4TXkVytkb6wAJv78EUJofZjE+n+Z3ZLR1sG4vXSjLJ0eNMxSto18yDOZcsSL2KPc1CTZDHbNA2eOEf49/xL0v/CpN0YTuKSarRM5d4F98He9rBt77u+Ly64FG3u5MfGy84GVcTyLAb8mPVFKgq/qxaBI8BNh9LC8G4VYwyk92YQlM1JOjOSlf8WqRgq05/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wem2AJBoTGHtBckyqvpen9uiSUKgs9mhKNjHQHA0o5E=;
 b=ZIGrEN6GE6mk3eJLGXKShMCWngDaxw17eUBZGHEt6kojfT32stKJf6w69cp875HQQjV8jXsUOovaLvyWuFcepJesMitgyygKMaqaoMaAunJXoVbZR4WTO9hQFozLyuQIttfqvwIAnwmEyXDQf0LXzLJtne6A+oVwWKIK6+rDxLhirbbewYODAHREotJVK3eMfV/nQxUvCF4I6msR4Mq0d1NbTgiIfxby3exmXHJ2VGEUp0IA1puwDq1bIPFcHKcxtVADA6PqRngpp3bcSOVSmd0vlzTUrMrwqeJ7DMM3/eOXLu0iQEjnGs9EqLM6ZbwcQk1N7w7B4KLwJnIpqdB/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wem2AJBoTGHtBckyqvpen9uiSUKgs9mhKNjHQHA0o5E=;
 b=KGdvoCN9/XkzDhoxZzbnJpNdPht5sT/aiyHfJgs7a/wys0vcGFEv6JfVyYAtVPn7yzZSoCJzMRaRRHlcLCd6TdjWPClxjOrmfeMwQSCTVP1G4u/GVbimfQR8ONx3Fdxj3eH7Rvfarwh8thuXFuPiOUAYNygNOEleQmCjsu8D2Xo=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB7295.namprd10.prod.outlook.com (2603:10b6:8:f7::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.36; Wed, 10 Jul 2024 19:23:03 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 19:23:03 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v4 02/21] mm/mmap: Introduce abort_munmap_vmas()
Date: Wed, 10 Jul 2024 15:22:31 -0400
Message-ID: <20240710192250.4114783-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0014.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::27)
 To DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d77bf7-a659-4962-a51f-08dca115b7dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?nuh+P7iMtc7k8ZTMONoa+l93MPMNWf9+I7dnUFNvNtCwOAuyMe3Z9YrWfOh1?=
 =?us-ascii?Q?cTajBUUWxsMsLK9xT91xHGaFh3cDiDYrjpCOa5cGgFcMwIC42lt291/5oaka?=
 =?us-ascii?Q?EsFqn4Y/IyLH/Th6o7K7vqBVfq8vUHc02tu3kwnPUI0H+ClDS7+JhlDqgdK0?=
 =?us-ascii?Q?p+1AgTsF9hQP9T0mKt12ODmBZ+Q7wBUQcnxP8GziZwflfhyja0sugyDbiU0N?=
 =?us-ascii?Q?rQmAaAZMXL1sV44rmTsVUP+0M5usycDMJRJ3o+KTdxEbebx6LTfuwSCBJiIv?=
 =?us-ascii?Q?adtpF+7V+DUJPu1d0ldHFhdRaQz6AB0d7y99adDchtpCU6gl3DZWieC7Sj87?=
 =?us-ascii?Q?tzLqW9giM6jUVHpWrnMSaB0b0RnpkSkQQmapKX+NJmuoIOFld24lOaI79Rs2?=
 =?us-ascii?Q?U1cH8d/ylZwubqdgQyfTDR03HJXqpw5zDOMeoHaQlC+ep0UTtS4T260MgCFR?=
 =?us-ascii?Q?KsxHpiG22r4okYKCFQWeCHWw0mc/Uvikncu8ke/a/ieupDzmorWGD8pmcR+P?=
 =?us-ascii?Q?aPlhsAaDQLE0j3HnNHBtL59nDA27g+9qmVOPRen9RoFheYkq7fz6o8QnPAP7?=
 =?us-ascii?Q?paXcP1KDGethcoR8SMolJogMNnPTlwmO2OBzTaov4woJm2c5ZJU8jF4ZknO8?=
 =?us-ascii?Q?DbJGo22iMkfpf2i41JMSARmFHIQzEzramQH3KOOP0KudIiiwpeZzHjviNmmB?=
 =?us-ascii?Q?up7GRz6pq9LPjjFDnVopRXxHEOe5xtahQ1cM0tKg8EHNfcdk0l9yqzmSO/4U?=
 =?us-ascii?Q?vK6pcCnn68WkHkZEk4qxH5f5aHtTuYdPAPKZ/ekQkAncBlXDqekzIhYzc8aT?=
 =?us-ascii?Q?BnT4YlUugs9p5gCTGDKnvRAO2aJAPUvgiIcvk9kgpZqMh2xMqRH/x3Cky7wH?=
 =?us-ascii?Q?GEirsbEpb00s/x72PVClZbcW4lE7Vww9bxvwALk8Sy6521Galt6+FTm5bQPM?=
 =?us-ascii?Q?+DqdCbVZTg+tBUulLnTErLK4zPqT+OHLMAFZ5t6OqoWDkvUecZNZTVrhMtyu?=
 =?us-ascii?Q?KnaFd1Fcfz+zPDUpzOdBLPzDCaamUDgbLfmX+ZRR99AAW/wpWSZ+WNWhlDI5?=
 =?us-ascii?Q?tW6ruEE4O2ty2su3Qbe9IIUyA3XI/Gu3wGIbxRQfnD7tHFc1Ej8Zon8eAkFK?=
 =?us-ascii?Q?syjLzZzXYiG4Y1Iv+vY1U8G5LKD/EuJ4T4ctR7fH5eSP0q6c/ztlNRiIiwpO?=
 =?us-ascii?Q?/DznYTzDn6h/n67VVNecEf+Rln7keWednvdg/Lt9ZvPptX3FuAszztvgmPv0?=
 =?us-ascii?Q?2u765sWsnUzp1EGN0t6iFH1UQAKHPqAFWzdiZVeFkF4Uz6r8V/SQhFyQid/7?=
 =?us-ascii?Q?RXwIYW7GU34XZ9213vPcOCthn0nlnrRyAJwodmsGtBQsUQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?n6pza8LVajuptPuGlfLqqCNjcuyXIisIB37/ddANrcu1u4CFjN/rBP3zuMW/?=
 =?us-ascii?Q?RqVXZD/AylwsIUwntshe79Os6ahgp5efzO79AiGRmLSLEK38VA+KfO8Su/Cz?=
 =?us-ascii?Q?pMCcmK8Ysl3T952neXqsONMd7gkRaKJN/Dv0xSi0+zH5smCFZQjspC9jCuO5?=
 =?us-ascii?Q?FWaJCmdrGpWStoI7i9QMt+8B1g/bJ5bocaz7hcsTwI5xoOkEEcvrgskn3X6s?=
 =?us-ascii?Q?bf0BJ79US7PqQp4Jg2y5rzetAf3i0Z+DtgZS7yjKIBpMAcRXEk+XwXO/Z4jc?=
 =?us-ascii?Q?s2jpGGtce5DtbPs4CTalpWiLiEGjQxKcbnAwk+f6QNnJF8zNexLZDpdaF51m?=
 =?us-ascii?Q?3/mlXm4gf1I16aYDRDiMrqq3Bk2AUh5I2CdwQgQNh/O8Od4mjHHe62f02ckg?=
 =?us-ascii?Q?TVr+30wTPejPNfyQVWIbdHoKKd4O4OC9Zilzw1oQjpuFx3sbM0uH5Vo+/Mjt?=
 =?us-ascii?Q?yjuCwj+ba2iYDrQNWB9ZRCcDGoKZCsw0kHa7mnjXM15nHlfz3rac4wX+ZrLM?=
 =?us-ascii?Q?y4eo8aw1dboSCu/s1srBKY/mc9I8fKC1iMXj5MdzXuWD9liOZcKRvpluemhb?=
 =?us-ascii?Q?8C7Ds/0Ao6Q2PIJWXLnA9YijSCpd62tgEle5vhrwpCEaj4Spv7hKYQDMU/N4?=
 =?us-ascii?Q?baRRx1bWCmclcJ4kHoTEvwz7uK2t6h7SK1UiNnhRULBYC9R5Y1MO5pR/BIQm?=
 =?us-ascii?Q?kasPa1D2fAIc20k4WAqqEKLBekMKuo9LO0pCx1x0wy6cJf0oqmz1hO+4x6m9?=
 =?us-ascii?Q?VmsSvsxgB1uoHItx0Yeh6OHwyUu78lpFlwsFElLD8xYzHupfwo5jqU+7Otoc?=
 =?us-ascii?Q?5ZQTM1wz7/6NSDSVpwSaDHvIbFV+G5HYbTfI8B5uQuKJxGR7QEptlF/JN2vF?=
 =?us-ascii?Q?m7a3B65ZznYkgijq2RY1e/iTdXK0Vq5XHuCMVRFbicG7qysnvEyrxrW3Ore+?=
 =?us-ascii?Q?YPNtDWEDNwxCfM+u/p6FPE2xPf7Jp0pAYI4klkzQbfX8Q8OCbsZYR9iars2Y?=
 =?us-ascii?Q?4khlBl1FMKxgI6AGZXdBGDy5XZe6jvBoWv3FOPqzRrDKaIOxjV5b3plq7ZTh?=
 =?us-ascii?Q?84Tye+F8HhGg1LPHobl1Dq1NyY/IWVYZCQCHft8SVMQhcBD8T4SAwFqaiWFo?=
 =?us-ascii?Q?KMOJPExYqEbfpLV7wc2Bf/vy4AueN0ZtTvflUQzwnOmnbjBtI8WscAfdHlCw?=
 =?us-ascii?Q?iDnwQ77Z2NHdm/kaqqkLyGCD11aL9lVQ7VjFWqzncimcNz18tRxQNsqoH/n3?=
 =?us-ascii?Q?aoG5QC5isurWiBVDsydhBf9oKyns7YFi496tGXF7t1TMefP2IIlW4KqfKSHk?=
 =?us-ascii?Q?z1MCYFFGyVLQ5OHbuNRgwC7W6DLhXdykjl83nJuZgTWgmuLxdEfVKERK2XT/?=
 =?us-ascii?Q?/zO6nriWDN5e7FFPaQMvrKT3dPAapuQHLkRLu9unKpbzvtgjPihCEkAkP41b?=
 =?us-ascii?Q?Fn56MXLz5FOJ19b9z5R+Xb0hPiA3OW6LzFv19Jx/81zuV6Urtgh41CSPcJFp?=
 =?us-ascii?Q?IqLLgEYanvEetzMP8I3UiPLAmjSkzW70yrJiGd+45PDGlBJuKWtH3d4PmSI7?=
 =?us-ascii?Q?RQIED1llISknQRUXxADV+vbiodo2Z7ES8mcMXioG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	603Xjj5xTHyJJ9HbQVQDT5PXaFO43tYJljLTICoVrtHYx8qnlrTPoK+ecG9Brsd3EyXaQbmoqipQDdvzd8MRAQzDnvaIVI8N8dSrY/rLz1Ez74mY+6TsTYCy97ZEB/rZ6yl0G7bW1luNglUEGduI7JCCLR0cKmnrueAerWuyd//vgVHupq8xltYPxp6ovqM+TH8Sp/zZwPuBy1CEzVW9QvCqd7zN2c6lbbYRsurrZ/KGLQS+zFC9lcidQ1EcuQg+HrV0VCKdzEqv8/pcXmMTSPU29zawysipsfs33DNPcuArvd+4T6zgytoI10cEKFBHqA7sd0p3Rxn83z+KGVKeNsbmQz/z+L7X5S4Dw4Qp3TR8ThXQ3LCQaGXhbaAsC2RqW6YyAUWl+3fJkHzTcJk6OlGIuGFHDBYES2e5YiL2eHLQGk3v9WRMiou0Q4lI0VqqMGb61uc0UcgQb7LAbzTdFFmdh82OQ5BycsHoxQYmfc+iq5mHc3O9NvrqgZbb+GfKoRZ5LqdK8zTmbHI21fytc37fjg4jaXbbwBUp9GnAaKLkZVU80SqetmprcuUrMO7tkpS+IAZaOYm5egx1BiAOS32vX7dbJXQO4+ehKJ+CJnE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d77bf7-a659-4962-a51f-08dca115b7dc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:23:03.1664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TeETa5Q/eV16ls5AzgbH7LThokvHOBhZQ6byKTCj/Xf7TCpdEXqL4NaKoFJUWF7gjdnUsFfiY6j4Q4xBH56c6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_14,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100137
X-Proofpoint-ORIG-GUID: BnDWKDQlDsXSIS-IGiGDdWGUXf6w-iuO
X-Proofpoint-GUID: BnDWKDQlDsXSIS-IGiGDdWGUXf6w-iuO

Extract clean up of failed munmap() operations from
do_vmi_align_munmap().  This simplifies later patches in the series.

It is worth noting that the mas_for_each() loop now has a different
upper limit.  This should not change the number of vmas visited for
reattaching to the main vma tree (mm_mt), as all vmas are reattached in
both scenarios.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 28a46d9ddde0..babfa50f1411 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2586,6 +2586,22 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 }
 
+/*
+ * abort_munmap_vmas - Undo any munmap work and free resources
+ *
+ * Reattach any detached vmas and free up the maple tree used to track the vmas.
+ */
+static inline void abort_munmap_vmas(struct ma_state *mas_detach)
+{
+	struct vm_area_struct *vma;
+
+	mas_set(mas_detach, 0);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		vma_mark_detached(vma, false);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -2740,11 +2756,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 userfaultfd_error:
 munmap_gather_failed:
 end_split_failed:
-	mas_set(&mas_detach, 0);
-	mas_for_each(&mas_detach, next, end)
-		vma_mark_detached(next, false);
-
-	__mt_destroy(&mt_detach);
+	abort_munmap_vmas(&mas_detach);
 start_split_failed:
 map_count_exceeded:
 	validate_mm(mm);
-- 
2.43.0


