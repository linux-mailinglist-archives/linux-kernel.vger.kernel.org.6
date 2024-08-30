Return-Path: <linux-kernel+bounces-308023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0980A965627
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897541F248B3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E0016C6BD;
	Fri, 30 Aug 2024 04:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YrB2yYhr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q7SvwMNF"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6668414D71D
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990531; cv=fail; b=riYRosHf9tRcJxZxVnaB6fJWczNQcVDSuSiW3UhUsIS8L8Mez2fnMXVC4krSXKo03mw4O4lLwoL4LIV/Hn6VF131VHoZpnpfcnz6re9O/jQmAcrGQ/yAL/PRHIAA83FqV/P4RlQKh50AKE0Ttl4Ul1ck7G+vuX8dMcMTDARGaVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990531; c=relaxed/simple;
	bh=EB5LoO8g0uWS85vO1KWgmQgX5gDidMWfZVTHC3fmSMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zo8RKeDQXgt7eoncY9B0Hqq/8dpg1L+r0oBSiHugiAy0ScG6HUAk5TUFXMM0LlOmQL9IfQI2nOZRA9ucfffRXU5XaRGFIKS9Fb0NevhaZB5lF4kKroo7VnyhEGVjahdq+WaHr53b/ZdNqRMbu4Kq4UyV+wPMS1OyGdoXxBt8dzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YrB2yYhr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q7SvwMNF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U2fg78022887;
	Fri, 30 Aug 2024 04:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=pb8FfoW4hL8yzz8RrA4fEnWEaS/lgspvQmeLTt4miDw=; b=
	YrB2yYhrl7FkVL+E9T1r4padjIze9VoK2cGvHoOQ21dM8xmw6RS7OLS71aw+IQHB
	E2PsOcV1CECQIGEF8+fMyDZVggbZ9GeaA0kzbbictR0AmA8MXaKC+uGXVRObwOqA
	esHmfd5XIKCmO+eZ0HmEVxGZaMwvC9i+3sutUhbg2wPuUkw9bPCcRR7qbRoW4iID
	4OcHKU9bfILralyPjI7bJ449KdQT5TBJtYL60YujvNQ9gD9VWgbYpfXNSFIfn1qh
	D6hi+wW4gbNlb0ECtCrgLCuMS7Qzau3KcYQ5PKJ/12hd9a7xC1gyR8JVo+D6pt/O
	gxNWYNj6GgfKQ5SHGRc8ZA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b28508p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U0LvZm036604;
	Fri, 30 Aug 2024 04:01:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jp2tga-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bW+oL7pmBAHqUvCIUdD0nrFv+W0iPZZViNrs9t5VDgzbV2qFA5UAyx8n+cFhfA1dShVabus3LNz+gD67xsi0UlJR61WUWSANtLU8qzGP2rsNfpIZz2Av8ufiuZfF8lnEa1B9TlwWqAftTKDpoodqOKa0M1GT9GE4xX69Mi+wzWCuIUQbyy02V04Cs1iJaFg7WaMdcVcnbmQ2wjm/02TFrzpF4G6s1wz1CTOW+hggZ2MghhtpBRMl5iBlI6kk+JM5S1nolTzEicPe+rQBONmlPnLUVSrzraqlhULAxf36bPbRNknonrHWFQR1j7Jh5bNZIpIh6O8eKAIMAU0vXL8a4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pb8FfoW4hL8yzz8RrA4fEnWEaS/lgspvQmeLTt4miDw=;
 b=XjLqOb4LGD14q0cirXGJHrld63i0fOzTQLe6swFvZrbCBS4FO26T5K4PXCcQ2YMMa5xhJzQcT8zICxm+IDelGxeXR/B+XGAHBdT1sbt6B5YQW7LktyJn0hJXMbq8PEOaBW3o+jp9wZxKJrjJJSGTqYONN7pV4efJV/rVaKtuVZzCAPxtBeBlghDAWSA6Xt5g79SvHgqWsGwE0ZSfGkVwnvs43fVEYxiACpxiOsqqaO4WSC6kLZKkt3QmxTc1eU0FkNH1mPWP+P2EBJup/zb3NERtnFvre/eAgpXXGIgUN1oDTU/Rjery4Ix/ngPWG+Iyv2K/dVlZaWaqfqUGMxgFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pb8FfoW4hL8yzz8RrA4fEnWEaS/lgspvQmeLTt4miDw=;
 b=Q7SvwMNF1ZB3Pv8lq6U+GBa30WtwV7Aes80aoDQJHQeFUSPNU7PSLCIlVPpG956ZRVVCZoE9UkdOyqWwZvFIQib62ZJ21p7hPeCl6Wu/Maz+9btNXbpqBe8uGf4PLchhJfydivcZu+DCCFl5f0JsPUZzG9yP0RvP/IXq8LJ3hsY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA3PR10MB8115.namprd10.prod.outlook.com (2603:10b6:208:506::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Fri, 30 Aug
 2024 04:01:47 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:01:47 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v8 18/21] ipc/shm, mm: Drop do_vma_munmap()
Date: Fri, 30 Aug 2024 00:00:58 -0400
Message-ID: <20240830040101.822209-19-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830040101.822209-1-Liam.Howlett@oracle.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0465.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::26) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA3PR10MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: 642ca968-994f-4f12-bfbf-08dcc8a877ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nirAp6yA/MPSgr0yVCEr3AIZA2a16Qcx0A49E6YSl2FxIniJYje9lXgdCD7Q?=
 =?us-ascii?Q?n4Q4UO5/Mj6CIqw+FVe9lrAVc59ZdJ4l+dZcRUeA8DYl6/wOvmQQ7EwGdObh?=
 =?us-ascii?Q?pA7W07ArLvpzsNJbBREBm0YI3x2bRM7nPyKkJEqsmwEJWcu0xXjBTA2//Kxi?=
 =?us-ascii?Q?RiWiQG/gAehWZ3iQydp1rflO3eCeb9tDF97m+1oTMakk4ki1JtLfU3oC2tX3?=
 =?us-ascii?Q?Skjd4LkXSNrCUgU+DxsS4DXYY3O5chrbefWIyc2s8IwF4/3Qgfbu9Hd+ylbx?=
 =?us-ascii?Q?0cBm+FFUPRDiZr8XY7U5WXN6tFRBUQuWd8DIYl70w3WvYIFmAqZvskzS2Tks?=
 =?us-ascii?Q?KT3YyD9DSB0RpShF+aux7RdGUTF3Bpl2/WasM8POA3Q94TcFKLCjTLJOGaEf?=
 =?us-ascii?Q?PKy+jZPfBFVSCyFEN+S0EWzF3nC63zUvkgQfhgcHPfuDm7amOqkysBZzj2S4?=
 =?us-ascii?Q?81hNKwtioLe3a7ETKUJ/InCwO8ruJkAmDdVNvpu85wKb3+IX91pt2dZotFPh?=
 =?us-ascii?Q?Z0gb8WYB3KLdP2gp34YthZ9XN4ZlJVN9Es5jqOIbzmSrA81vbQpum3Yhos2Y?=
 =?us-ascii?Q?s3Z50iRDE6EC6PCeSkfyUe5LV2/gwHCDAmg2VXixOEsifmTLGR2EycIhJk24?=
 =?us-ascii?Q?zBV2dCScD0VoYqFJUhKBvo7z4ZXGxtXDu7se/kndswysKL81Mr8IMolU4SDO?=
 =?us-ascii?Q?WxPdf2g9JmB6JTdL4nhSzYRTyeUrOsqGDk7HpdqAKT1C7Tfla3O2mCTFvZQC?=
 =?us-ascii?Q?rqI2hw6MBWyVeHwTIUNzGG9vYYQFlsfv2lUJ8rpIw8jjAXqf9mB2giVkQZIE?=
 =?us-ascii?Q?8kla/k3U4kM9KeooMBvkVjt6eKMqsiGIMsIfi80twL0F12Fhl9Y5LKmLfvpl?=
 =?us-ascii?Q?6DQmf8pvdndk+TZAQ9eYJaw6KrMM7Ib0v1r08u4YQxInpYGeLz2LDuEySP0S?=
 =?us-ascii?Q?iAA0ZciZCbhdgsBgb1YBzvltx3rMjuMPKI/eZJtGorxwBerYAqxZS8V5x0Et?=
 =?us-ascii?Q?jYQugkUcd56Xkt2zXO2LsemUU4I8IEErznEduizSY895Cjqs/Ur9XaP4Rmpr?=
 =?us-ascii?Q?IKxu6v4qI766B6FwF84BbSrPoagp4bJLy9MKmk+ysvr34hJnDvXgf6vnhh9R?=
 =?us-ascii?Q?BEl6sQ1bz5ODhkixsF29yV/wrgArSaZr9wp3T2T8DP7XRl8wJW+Nv8U/1fsN?=
 =?us-ascii?Q?klbPnGmdet4UlHOwj7cZjIH9hWvSxYbItkg7n8WMsxWNEBUR2X0y4msqu4GT?=
 =?us-ascii?Q?SjsGIdAk7n1vqzF4WjcFdpO2ME5wiK9mX1MpJR8xFlJArQKEK57Kh/lqGshh?=
 =?us-ascii?Q?GVH1d1d7BBHTJXqpM4CvHAEYPiN4s1BG5mlsJjiXzE0FrA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7TnNJlWXlOAvpbmFNMZGaE74giNN4wVzuYLjRtetJ2y/M3UDQtrEIQay3hBA?=
 =?us-ascii?Q?v9kCuDRPajyD6n1j6kBeos9WDipkQKfsvnrIGqIi6Nw8KBV/OKJlz7l/wauP?=
 =?us-ascii?Q?KoMWMDVyxPQJgadZOknVZLe/u5aL/DsOEUgBqFGMJu3SJ/oKPYeM+IJsAjOr?=
 =?us-ascii?Q?8zoltH/yxfVfuW+zWIudtbBjGLmo1zdXlndxQgh9uEajCgZy4q5tB9yLpbIa?=
 =?us-ascii?Q?puCPELddm6Xvlff+f0QKSBoS9xOZg1REgCZFIy1lgJGDaulReD+s6XdJwJLn?=
 =?us-ascii?Q?HCTwNlRJq1rR7pK0Xhi0JPJyESobxYfjf0KUQYO94ZrNvn8KrHveiNaUw4jy?=
 =?us-ascii?Q?LEj2rVhLCKUSCwxjjm0S76u4DoGgO0jABxNr5ufNV8iFu4ocb2u8mYa64P0s?=
 =?us-ascii?Q?0wtkkXWTzIwAMsztxL4pZ+oyspPS5JWWZAq3lXqjLCZHt/lQxrmtdeWzqET5?=
 =?us-ascii?Q?p7YOcK7yY7JhBvOigYJsRDVSgRxGyT/V2FGCEaeNnTk4a/ajX/Utb2PdCmZy?=
 =?us-ascii?Q?g32VktGR2oxsokpZBFbF+SShyA7TghsFpL+0YBPKmWq3KDb5c95x/ZfX5UNG?=
 =?us-ascii?Q?+w93laMoNbpmAA+mJL+mydMIS9+/zQstTQyIk6ECX4bOg/DdC+u9JpqMNeQx?=
 =?us-ascii?Q?OgWq0J7w5wtaq6Q+6FJo2ZukuLPLU592JzuiOEj/PK8xpWBaWTv7knin1+Hq?=
 =?us-ascii?Q?gGv+EtaHMJ4Nn90L5NZctf2g08wF2ty1UJaw7mhbBpOuVY/5TMsOrFAf/0fC?=
 =?us-ascii?Q?J6PKzXf/ZD2fYTbXjC8f9ZWMCgtVXx60m0WiA+io0QanfniorS7NahCQ0/rN?=
 =?us-ascii?Q?7X/LyxV5aFJSmr4T91zzid5XywCnh22ixAt2FfR655fbxLegdnLiC2ByA27q?=
 =?us-ascii?Q?7CdGm5brTloSwcRT59nasmR2Ni/9LdYl4+2bPnSdf5jF97YtMI4xYLRcZynL?=
 =?us-ascii?Q?JhwK8quvTMURyYiZKTgv0L5whmtW/iYhNu55XiKiDuvzpLKchs01Aavvc9Js?=
 =?us-ascii?Q?ry17pqa2RyC/xLSB8plQNQ39H97DhgOm3Y4/gtDOcUYZ8RGOZCkGKopgAxwH?=
 =?us-ascii?Q?RPI08KdPGAiBOrQwx1jesD/KZji5ztWemgx6LBuIce+Xsw2d3IvdJ152wWye?=
 =?us-ascii?Q?xzGtyn5ngX8QX1A8RKuvXCe9GXJxGkJS+NgBPA+XSHF4j5/lvdhzPgp05UC2?=
 =?us-ascii?Q?wvqawLpaJnj6yl0Tvd8VoO/e89kUi5yDEvgwTlY+BD6N2YwPUQtKpYHRZQme?=
 =?us-ascii?Q?nsebiBSVKqg2rcRTSe4tijj5qnmjXtTQyzEKtKD7KCD+LOFBl+rOpj1Nstxl?=
 =?us-ascii?Q?e5nrdGgPsO1B8GZ7GdHSP+F5bQlBb8mTUTl8HFbQnPZUhaMbAPaco1pg3Uov?=
 =?us-ascii?Q?0fJ4N4cxHvCp4YSGDkbS8HO+XJioaw3fUOoMaWvSyHKr36dHZXL4eFiHJUf4?=
 =?us-ascii?Q?SwmgEuMTqn99ELZMCyB+S2jqkDVDdM1IGWTeyNSOePIt23KEVU8UMrJYDaZ2?=
 =?us-ascii?Q?iBn5F/r3J3Qtkq8nigJz4dHDOBaOiohv69Ptx0lOo7ZWP++BXgjOm1uwtjml?=
 =?us-ascii?Q?P7ruTg7vNR7sgeh2qumeiGglgWrsfnnCggQRiI2FM8kzzDjflHOtGtj8BU9a?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w1ZftlI5YnnTLcj9YR1s10EMdmzTNWeYmzvPebKvBKF48Uzv6RWubnxoo6L3y9JRZCs4ppaDMLs5tMwcGm1PuXdC3eldJTWV7JWopYUWf8oxa1IonErIQlQ71L5fzMsowER16feZVRPVn4gvUShvdBmgKqWFlxSGunIyFmWXOne1pwFPYZA07KVlFzsBinENyUGIQwXkM8qPgXv1/li2yQGhNDUHmMBL0njaAqxNAKEC/QxQKXHuGPmZE0etOTsA8AP1glkJrvV1kmkdxk3c2dtpcIsLIeuGgTJ9UYZdtj0UCDqtvifoFGdFDceRdIHHGycemw7oMkw58L9JL2kAQ2vDGYT7XfKwJdfobXZd/ctEaCyoPzw9WZ2clcFUW3E7tWP+EdoQOV9AQZbg+UCk0FxWJXoDmSnyIjsQ0p6xFzVGktOWFONbptPxnhDt7Os7xplp2Uvirv9Knmys/RiiYbai1U+6t5GPS/N43ZF9N3dfmY6YpnDwBQcBpkU511DDW7KqEUEQmieele1YqHEdIkf5r72wyr7cGhMlA+ymz6QkC+0my1B9zAt39fJxIUijsg/Jb7esBPHI21w+Y870euwse3KY1mDNfyTa/AgUKPI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642ca968-994f-4f12-bfbf-08dcc8a877ee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:01:47.3186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3a14O2bpsr/n0s8tKQosAJi+LE/oL5eZNmyIlhHq6AlogsPh6vWRNPFHcJDWZX6OPrk6zKjtxzBNKMjGLufIug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300028
X-Proofpoint-GUID: 4RDZw8oszWaGKRmYvPCSNNQwBri_Kmm5
X-Proofpoint-ORIG-GUID: 4RDZw8oszWaGKRmYvPCSNNQwBri_Kmm5

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The do_vma_munmap() wrapper existed for callers that didn't have a vma
iterator and needed to check the vma mseal status prior to calling the
underlying munmap().  All callers now use a vma iterator and since the
mseal check has been moved to do_vmi_align_munmap() and the vmas are
aligned, this function can just be called instead.

do_vmi_align_munmap() can no longer be static as ipc/shm is using it and
it is exported via the mm.h header.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h |  6 +++---
 ipc/shm.c          |  8 ++++----
 mm/mmap.c          | 33 ++++++---------------------------
 mm/vma.c           | 12 ++++++------
 mm/vma.h           |  4 +---
 5 files changed, 20 insertions(+), 43 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6f6053d7ea6f..b0ff06d18c71 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3287,14 +3287,14 @@ extern unsigned long do_mmap(struct file *file, unsigned long addr,
 extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 			 unsigned long start, size_t len, struct list_head *uf,
 			 bool unlock);
+int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool unlock);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior);
 
 #ifdef CONFIG_MMU
-extern int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
-			 unsigned long start, unsigned long end,
-			 struct list_head *uf, bool unlock);
 extern int __mm_populate(unsigned long addr, unsigned long len,
 			 int ignore_errors);
 static inline void mm_populate(unsigned long addr, unsigned long len)
diff --git a/ipc/shm.c b/ipc/shm.c
index 3e3071252dac..99564c870084 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1778,8 +1778,8 @@ long ksys_shmdt(char __user *shmaddr)
 			 */
 			file = vma->vm_file;
 			size = i_size_read(file_inode(vma->vm_file));
-			do_vma_munmap(&vmi, vma, vma->vm_start, vma->vm_end,
-				      NULL, false);
+			do_vmi_align_munmap(&vmi, vma, mm, vma->vm_start,
+					    vma->vm_end, NULL, false);
 			/*
 			 * We discovered the size of the shm segment, so
 			 * break out of here and fall through to the next
@@ -1803,8 +1803,8 @@ long ksys_shmdt(char __user *shmaddr)
 		if ((vma->vm_ops == &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE == vma->vm_pgoff) &&
 		    (vma->vm_file == file)) {
-			do_vma_munmap(&vmi, vma, vma->vm_start, vma->vm_end,
-				      NULL, false);
+			do_vmi_align_munmap(&vmi, vma, mm, vma->vm_start,
+					    vma->vm_end, NULL, false);
 		}
 
 		vma = vma_next(&vmi);
diff --git a/mm/mmap.c b/mm/mmap.c
index 4faadc54e89d..6485f2300692 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -169,11 +169,12 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
 		 * mm->brk must be protected by write mmap_lock.
-		 * do_vma_munmap() will drop the lock on success,  so update it
-		 * before calling do_vma_munmap().
+		 * do_vmi_align_munmap() will drop the lock on success,  so
+		 * update it before calling do_vma_munmap().
 		 */
 		mm->brk = brk;
-		if (do_vma_munmap(&vmi, brkvma, newbrk, oldbrk, &uf, true))
+		if (do_vmi_align_munmap(&vmi, brkvma, mm, newbrk, oldbrk, &uf,
+					/* unlock = */ true))
 			goto out;
 
 		goto success_unlocked;
@@ -1479,9 +1480,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vma->vm_file = get_file(file);
 		/*
 		 * call_mmap() may map PTE, so ensure there are no existing PTEs
-		 * call the vm_ops close function if one exists.
+		 * and call the vm_ops close function if one exists.
 		 */
-		vms_clean_up_area(&vms, &mas_detach, true);
+		vms_clean_up_area(&vms, &mas_detach);
 		error = call_mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
@@ -1744,28 +1745,6 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	return ret;
 }
 
-/*
- * do_vma_munmap() - Unmap a full or partial vma.
- * @vmi: The vma iterator pointing at the vma
- * @vma: The first vma to be munmapped
- * @start: the start of the address to unmap
- * @end: The end of the address to unmap
- * @uf: The userfaultfd list_head
- * @unlock: Drop the lock on success
- *
- * unmaps a VMA mapping when the vma iterator is already in position.
- * Does not handle alignment.
- *
- * Return: 0 on success drops the lock of so directed, error on failure and will
- * still hold the lock.
- */
-int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		unsigned long start, unsigned long end, struct list_head *uf,
-		bool unlock)
-{
-	return do_vmi_align_munmap(vmi, vma, vma->vm_mm, start, end, uf, unlock);
-}
-
 /*
  * do_brk_flags() - Increase the brk vma if the flags match.
  * @vmi: The vma iterator
diff --git a/mm/vma.c b/mm/vma.c
index d2d71d659d1e..713b2196d351 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -658,8 +658,8 @@ static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
 	 */
 	mas_set(mas_detach, 1);
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, vms->mm);
-	update_hiwater_rss(vms->mm);
+	tlb_gather_mmu(&tlb, vms->vma->vm_mm);
+	update_hiwater_rss(vms->vma->vm_mm);
 	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end,
 		   vms->vma_count, mm_wr_locked);
 
@@ -672,14 +672,14 @@ static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
 }
 
 void vms_clean_up_area(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach, bool mm_wr_locked)
+		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *vma;
 
 	if (!vms->nr_pages)
 		return;
 
-	vms_clear_ptes(vms, mas_detach, mm_wr_locked);
+	vms_clear_ptes(vms, mas_detach, true);
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
 		if (vma->vm_ops && vma->vm_ops->close)
@@ -702,7 +702,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 
-	mm = vms->mm;
+	mm = current->mm;
 	mm->map_count -= vms->vma_count;
 	mm->locked_vm -= vms->locked_vm;
 	if (vms->unlock)
@@ -770,7 +770,7 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		 * its limit temporarily, to help free resources as expected.
 		 */
 		if (vms->end < vms->vma->vm_end &&
-		    vms->mm->map_count >= sysctl_max_map_count)
+		    vms->vma->vm_mm->map_count >= sysctl_max_map_count)
 			goto map_count_exceeded;
 
 		/* Don't bother splitting the VMA if we can't unmap it anyway */
diff --git a/mm/vma.h b/mm/vma.h
index b2306d13d456..eea1b5e9c15a 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -31,7 +31,6 @@ struct unlink_vma_file_batch {
  */
 struct vma_munmap_struct {
 	struct vma_iterator *vmi;
-	struct mm_struct *mm;
 	struct vm_area_struct *vma;     /* The first vma to munmap */
 	struct vm_area_struct *prev;    /* vma before the munmap area */
 	struct vm_area_struct *next;    /* vma after the munmap area */
@@ -114,7 +113,6 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 		unsigned long start, unsigned long end, struct list_head *uf,
 		bool unlock)
 {
-	vms->mm = current->mm;
 	vms->vmi = vmi;
 	vms->vma = vma;
 	if (vma) {
@@ -142,7 +140,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach);
 
 void vms_clean_up_area(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach, bool mm_wr_locked);
+		struct ma_state *mas_detach);
 
 /*
  * reattach_vmas() - Undo any munmap work and free resources
-- 
2.43.0


