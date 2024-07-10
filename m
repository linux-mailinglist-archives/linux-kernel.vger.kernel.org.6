Return-Path: <linux-kernel+bounces-248159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5A792D907
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9898D281779
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313EB198A21;
	Wed, 10 Jul 2024 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BlYHKinr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xa4/BQHy"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CD6197A95
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639428; cv=fail; b=DW40dvNsN0fVZ2/GpdnSeAK1OKYPi7TrOkKfIZhyBX9/aclJuHhZGqOyg/+yDsdXxZQTl6V1Fcj8osfExIE1jSkF5I2FuU3/MoXUWdWLvP/LM6lfWz4buf5LtmONL2p+VpJL3vLFeW9FxUHKTKfOJafwTmxIESrs2wh0Fn/UmTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639428; c=relaxed/simple;
	bh=SPC04A4gl7qVW535wKd38FTZ+QYFwYocvr8pZPQC/lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K9EgnmSyV76dtjHQvJnfd1fSSpUXEz0r/isZCTbBr2P0Ay6PHiLu+wzx5bJMMU5X8W5E7tMsCDDIvUjjqy3wJN18fSGVejd5IZrqZinIaVcBJ/loU+2qIHpBOQ34taqyUfac5iBFnZD+zP+X+kO3LJDzAPVI5TsPPbuKj0hWIdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BlYHKinr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xa4/BQHy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AFqbUf019840;
	Wed, 10 Jul 2024 19:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=LArHVtRPmTnLL4Ka/8b8U968Rn79AaiiLYmA/o/M1Rk=; b=
	BlYHKinr82YswGyrcvOyNb14MaPu+zvsYJdpdUufMcVtbJdelLgRUzplSzlOotNu
	ep7JianDBtfn3XYubnjyqn4htnHlcCsBCYmgFgEquU0bX5sUY9coRzl/OuO7Vcl6
	Zg7zwM82+zEPBepsQziaxRFpXC0yAFuJdH7JtgrWHk/+LjSoRquqEmV6gUC8+PRc
	rk1VIivCDTEWx+64zENn33aiopdduvWQ7MPF2IDQpIJV5Ig+MHZCJVFVr3ldD/SA
	Zkl9iRAzti0XkTYsSiMCavXWcUG0rnZO2IioDZ46rOSpUbdkfIMx9rHOf7U57+Yo
	qkVxvygLSIYD9qJa2SvdXA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wky83qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AIdNi6033802;
	Wed, 10 Jul 2024 19:23:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv194ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A02j7e0iojj32mXhLwH5dqIplgiu8KPFri9UTEnZ2Wzi561bU+J2bbLA6uXoP+ZeIlCFlFq4h1J5ud+za1u7wNQ231aaqYuI1HmXrbT64xHIyRb1S7VVwa10RiL7oujCUw28AXQvR0ENvu6O91glNDcAJ9vgU1yyhQTRawd2B2GvmG3yzmakQU8JDFhTofxprAIPg70ZpxaTVxKnsJ8NDsfG9wEb1vVuY7dpvs/u1ortAM4DDZYrAObIDOE9Xwgmpmudckv4ssguu0dHcb8JvLSr59GoD5g43rbU9fPOm8dvRUq2fQhenYsVNgfwfd3nHr4757QrP738aPhcw3CIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LArHVtRPmTnLL4Ka/8b8U968Rn79AaiiLYmA/o/M1Rk=;
 b=ipVH1ZFf1vSAv/vxWz+54RNijxYUIQJtf0LveApiU9tdUrUon5TcUCxnuRD3mSB8PaZuUDNa/Qs24vazLgWt7GLWXJf0vhv5SMqU0KTo6o9VDyZ55rRX3dkXgqh9i7vMpv8yx5yCrs30fWRDOBDV80Zsi4D79bIapyudsp9NvyWom6gj+4aXZC8bATtFaNTNOlS8X796O5g22it0Tw5s8Z9s63hMIO7Zs8FbF98q7KGu9Qn1Uvzw4unEY5+pnCkcdOtWGmq9rnkfRklJCdjKpoUHuHlA614Vh2f9YkHUApqXQsLiV90xZUQQylpe+IEC+pcbbXs6v1twWZxTVcIo7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LArHVtRPmTnLL4Ka/8b8U968Rn79AaiiLYmA/o/M1Rk=;
 b=Xa4/BQHykvbbeG5SNfeiBaykc4q7y3YayV0YHXWhQJYpkdE8W17GfjC1KXdzu15pYoQPMKkQLIbBnPhpFVJAOHxFPLkEPznGnF4J4f3wrwM71cdH6DRlflmg3brmVcdCWORDxSSzU5XGEJskdxIwMIYF7mM1ca8P0EB61E5A8xQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:23:14 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 19:23:14 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v4 08/21] mm/mmap: Inline munmap operation in mmap_region()
Date: Wed, 10 Jul 2024 15:22:37 -0400
Message-ID: <20240710192250.4114783-9-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0031.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::9) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 77060ebb-325b-427c-7863-08dca115be9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rTXd+9saBLgDXe9JmUOdq2KJFBVlQXs71CJKuBADWgkQYjDqqA/rUUK13cBW?=
 =?us-ascii?Q?TQUSf87h5hfV7xHRKahWUJgBLhk2o/aZCTG123folqAdFywHkIGtl+P2BFvP?=
 =?us-ascii?Q?H0nxv26wj0Zg4MDCdCjYLFaLKmF46m+otLA25/EMduuRcOSmfDfDJyAHJfiD?=
 =?us-ascii?Q?gZruu0N94G+fZD/XVNtXdJCtUIy+WlumiwbCtKD9taHN1IPVD6zODX1MKogh?=
 =?us-ascii?Q?wPZq+e38/YH3HeAe5YG9NKurEk4gNse1yZFTpNKPOrAf3F6LAOmEQIakjAdC?=
 =?us-ascii?Q?3rSVdLDAZobNwZxGETuUrFPISH0O/K0KvZaIlCHxKZkFfK4+G3ZOivWK2J+q?=
 =?us-ascii?Q?P07W4gi3XBMJHRMMvykWakIzIELRoOtvhJ+G4bRjkJdp8wqNNPZj1geI9JlE?=
 =?us-ascii?Q?rgAySdIaYKjLeRsRkX5nm4qt5nbHMppjbpQ6CVKq1PX4aEJXRY3iDiGui+zZ?=
 =?us-ascii?Q?t03C2R4F/uDWcYiGocKhyU/iBfMx9+66lKPXbDkeli8WoyQl9c56DUpNVb4S?=
 =?us-ascii?Q?tg285pWH5QQj2H6LqBIx7nbzv5XmrXBXOB9xnNtbfMJ8tSFPBBcWP2QzAiqs?=
 =?us-ascii?Q?S3wo6TZAt96CF5TpPG8v48r7tHRPnPSfoZZZ2Gfv9J+iDWco9WXPOeXk+ks0?=
 =?us-ascii?Q?e98DgHMbjqLoaHZNBeAi+VmxVPZlvMSVUXHhEqu2HEOx7XQFzs0K+fu2nMYT?=
 =?us-ascii?Q?nUMlZy8lSpxu0vN3MsIK35sg0L6eculimMKmBKbKBq+ypVJN4kWOctyYQfdU?=
 =?us-ascii?Q?wGZu3VbHuz4h/ceRGjjzgTxSBb2L7MH9YPHfVbigh/7kkINXMww9CNx4yjpC?=
 =?us-ascii?Q?YjzqvX5sY6aAXdNbJ0df7o15X5nkfR4YU6M5HPCCwV7cYObmr5ZVEqo+IujD?=
 =?us-ascii?Q?A1/58EH6Hzq1exP4n5iGuQa+PZ9K82rDRbqM8xWzYz/9ikRuIg59eC7UJPJo?=
 =?us-ascii?Q?PB9KacxNN0k1lqwaxMiQK90qMLvCE8N2Uzd8wwX9cocm4mTNdwgN15bkDcuf?=
 =?us-ascii?Q?eAvXvB9C/OA2x3BuQMSMXOFv6lJkeFQLuvZuGxTZxpyta39P7LcHO6YAW+g7?=
 =?us-ascii?Q?Re+w6IVIVUM2IaK54zm3tsntXwjnRgLhsx/bZUajVyA8rbMzL6SVNDls8rS0?=
 =?us-ascii?Q?wCurO00UF2dYRi2/NddLMNnOvjq8FOMTlgsrsySzeoY4DDyora6m2zW5iVHu?=
 =?us-ascii?Q?fK4A2UWHgcJfCmGYMkfwZ0P20vXopwQDDT8Cbugw6unjOt3dO/HsOFZFS/up?=
 =?us-ascii?Q?xS+AD1BKW8Dyo0pFlugOSDZj6Sx5XiatrOuO+P+/khh+bjpNuWw0tgO3g4XY?=
 =?us-ascii?Q?vXUFgKun6as4MwGTD8mDy82OQY6aBSCD0GWFTY1E0zqigQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?F7q4+GgKpp+cJbeqwFiEuIAhB1AKM4OLAnO2Ig0OiHrsY3y+hhn8xBDZ/V1R?=
 =?us-ascii?Q?E91pS2yUd6TYETl1FVRPidEgk60fmLCtd8PLRTiHivpyTEx9lZdaekOTasA6?=
 =?us-ascii?Q?NCjQAe6duPRY/fFWnZGT6ReXjqQNz8ZYO3TRSAX9G+0sAgJbNYY5Ap5hZd2b?=
 =?us-ascii?Q?p0iIN+6+AOpJ+Ff+HhUp/Nrl6/ZcoAzwHhDkn8oVPNbstEC4bNLDeo2VBM0B?=
 =?us-ascii?Q?guHzr6sbCPM7Jq8XpGt/1c0lrYnjwvi1zo/S93tp50jPfIeDLbimoh56h1B8?=
 =?us-ascii?Q?rh9szayhrrhrajxpW+6yyjgrFWlLbkLjYaWlVPawrT/Lp1PVaRXPK36sg69B?=
 =?us-ascii?Q?v1VlH9wXFPUqRDIwZw9EM9yy8tVn7LHgqs0O0ZHSODhwdGo6/54MYIEkmWEg?=
 =?us-ascii?Q?Fd+wU5veLx5i2EJDeNlQfZRlrK0m9qTCnEpneUFuMBKxNNLTOEp+FafRTwvX?=
 =?us-ascii?Q?fzcGJFKLnvtzQU5phDujtSwpPHMDIEKrG32Ufkg/7x7enf44r8kcK2hTosQf?=
 =?us-ascii?Q?Oi/TMDNihNiFz1TymiNdXCbkVEAwqHVS/kcHGkhpU0BoPIXa5UN6hSk6L/pQ?=
 =?us-ascii?Q?8PR5kv9B8fQlEedQhWOwdT+G0HGeMWMwXHEHDsEMPKnJ2Bx0vfhdf+Ua83FI?=
 =?us-ascii?Q?3uf3RF1GxO5xENTmr4813C/uZnvzmz1g7yxXs34YJ3J64YAVcbC7rZ2k13q5?=
 =?us-ascii?Q?NTXpo2TcvNwRgzk5Ge9aB4iD8mwlW+YwDY5GIyJZelFhr0gbwE152XUroLAX?=
 =?us-ascii?Q?SEED2DNyOU4dV55ZlZuO7iLW4cM/tu4AbJ2RIB4KRrOrbkofTZh9LCs72ul0?=
 =?us-ascii?Q?XGzfCc+Bz67RGyy/22zcb6LAD/3Rv5PLvUMLxJJjSJWaKlcuX16ByKEAjMCQ?=
 =?us-ascii?Q?mYbzMg6IlkZ+u1v7Uv7DBuIHAMMW7fBZoBfN2UIOqPQ0Q1mklC9bPKZ9T/Kp?=
 =?us-ascii?Q?vFEU7QQ7PpGGsPNKMmo8PBaci9+EkVGuWU+O6UV/UoTnLiuMUSU3suCDqFhP?=
 =?us-ascii?Q?VZvOrON36F6A7swl17qQfjt3PrVGzPQwKauBqJEhClH57DmjAIFi3DvAcqBw?=
 =?us-ascii?Q?hQzFM94xixo2G713n0elB45X07d9F+DzGuwdweucwlruLn8vX5wF1cgqTdT6?=
 =?us-ascii?Q?4oK/lYUGA5qr6E6LYEE04iLrc1RUMRHCl4PQdGywoNeH2CZMl2y6tRU8sHLD?=
 =?us-ascii?Q?+3Njk4NgEjnzG4sGVt98AL2WUdpwriGwZk8zCwf0JtZTi7TYRNxel5qUSO2M?=
 =?us-ascii?Q?53h/EHi0rEPMGUc9R+zdLDpHEK3yFD3SVwoelInApfeUj9Ms8XgrtWiRcWHn?=
 =?us-ascii?Q?bkKuV6HD47X6G/PztKXp39y+H0x5T3I/OZ1fUPSSW+/ed9pBRY3K7Sy6iAF8?=
 =?us-ascii?Q?GZ6WNBEUdl5U1FakM6ZsBRYo83f/DkEE/4iM1tV2lIvlPnCaHvhzldhkWwYa?=
 =?us-ascii?Q?IAajrIsK78gcDTQczQZPhTWn8zclTtMKSzLw0Opx9zVn6JFKVcYBl+UaPuma?=
 =?us-ascii?Q?FTNZK90YJG3fhC1Uob3yYU1SmuQeFqTyKnxLZGHfrKU9JL4QbggUQUbwMPhx?=
 =?us-ascii?Q?XwoRc1MOvITm1wa8YT/M7SPLRysgSQq8QrxlCXw3jS0/+m87cBjC2hNAJkGC?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8xqp2jHzeIPjsYY8wzqu0qQyk1jUH1diznUqwM6N5UMuJNV5LcZHFN9Y7k83s1X94hUpPP04sRjKshZuf6uQP1F/f7EHPoj6ntx7I+PnkeDY5Vh5UTFfF6tNRdpLLrKodv7HoEiaoTIRvi63wZfQ02E6J4YselSeQi/Z8p/7NCzcA4IAjOK8eaMJvIG5b0gU9R6W6MRp8YQ8Q7P/n/gtj2Ln33aHofC1KMOtwhi2iMoygkw9UL6L04ShIf0E+unGxB4hfrbXOs8JvaKQ62hLmlNNVuxFz5lAruj1cvN6QRszX9KHit00lbUBE+le+BOV9Asp33Mfa6lBgs/wA6xE65U4bnpzwMWpk9TyTo75Y39ZIRssvY3osgYw6uT3DZb72GS4mI5+8AySsU1GizwwJpOYarJKEjXZIuwFqsxiBPat223tSdQcEQY6gYR/j80h2mCmtqou9u9jbggO+yvVE8M/NwvrvLqmsw5CEa/ywiE+CrtWadK+IjNSkuNsttTcbbglTxckrc1+3tn+wujhyf4LzRikc+DH05rFVfk2tqdTM2ecawnT2EXTcBoxh2Zo3jNe7jn/FBVrBa/KDKdaKzQiT6lTtp2Iogp2vLAIAMs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77060ebb-325b-427c-7863-08dca115be9a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:23:14.4756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIA8rkUZpur6leMIEaKvbAWfwNSk0P3no6T6RQ7iLNWTSGtuxZWKta+xF4Gl6LSbXlH5eXJbO2yFx38EId5KyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_14,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=989
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100137
X-Proofpoint-ORIG-GUID: h64IlDrb024vwkfQzkZDau3q1xp2pUri
X-Proofpoint-GUID: h64IlDrb024vwkfQzkZDau3q1xp2pUri

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

mmap_region is already passed sanitized addr and len, so change the
call to do_vmi_munmap() to do_vmi_align_munmap() and inline the other
checks.

The inlining of the function and checks is an intermediate step in the
series so future patches are easier to follow.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1c9016fb6b5c..49b3ab406353 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2938,12 +2938,21 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			return -ENOMEM;
 	}
 
-	/* Unmap any existing mapping in the area */
-	error = do_vmi_munmap(&vmi, mm, addr, len, uf, false);
-	if (error == -EPERM)
-		return error;
-	else if (error)
-		return -ENOMEM;
+
+	if (unlikely(!can_modify_mm(mm, addr, end)))
+		return -EPERM;
+
+	 /* arch_unmap() might do unmaps itself.  */
+	arch_unmap(mm, addr, end);
+
+	/* Find the first overlapping VMA */
+	vma = vma_find(&vmi, end);
+	if (vma) {
+		/* Unmap any existing mapping in the area */
+		if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false))
+			return -ENOMEM;
+		vma = NULL;
+	}
 
 	/*
 	 * Private writable mapping: check memory availability
-- 
2.43.0


