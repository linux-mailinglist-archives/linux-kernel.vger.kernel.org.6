Return-Path: <linux-kernel+bounces-308022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0A1965626
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AFB1C22566
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D0C16A947;
	Fri, 30 Aug 2024 04:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OtOETeOC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YyrqeELN"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A4F166F1C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990524; cv=fail; b=lmgItzHU7aiRcspRzdqZI2xRynSf6GoAdzHtg6V/eQGwlWSpiFveRlTLcVrvBqFeqcHWFXCQla2PMF7IIf80t/+A7F0pHgBiF8VLAacCavlAhO3Avw5W24WKOtnmol+gqAVridCb65bNiWeZi1RlItvlVIuKfw6+VkxT0keE2Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990524; c=relaxed/simple;
	bh=ussy/GJDTzIR8D5TwyTz3JCerHmIpN9mGwxWHavmKMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p03R9d+V+0q/j97yPwp7dQV6DhAeV2tlxhrBjdZEu+mkAMEtI65Hs+CChjomKwa5gOE53zlAU6CnVX3wGg+1/uKToVvmDwq6jHflFdUALXddcR8ZQGgLWNZMBCh6j6lQuen63ARNsbZ1Wv7CA5ZYHaTqIL0ZbNmjnO0Atw+l4C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OtOETeOC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YyrqeELN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U2uL9I019681;
	Fri, 30 Aug 2024 04:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=Ls6YlP+qGa3+3FNlDv9PERPNFJAt0V//E29iP7vaPv8=; b=
	OtOETeOCENI+UV/YzUmpykj0qWupQrlXh75cyrweWNFvEVwOHMXvkHh4t9avgYT+
	3GiHvJrsRrXDRFU2u/pu+imN4tDZtVlgUiiYls1qDbKIEhsgBfcP9wjsWGgM8nMG
	LWrXUfT8FgVzi4GY3FQvrEFThHb9TpXRmNCA0Fwo4F0SfICaCLB1g21FJ8ueyVC+
	g8gQFp65RwrqS8IxjtEvY1gEzwdD5q+2YXTXNQvSjplaSQS0H/lXdHYsN/TQjls3
	xy668czWckjo1IMijqCiaBytqhMrplDmgiSRiWtC2ChPOhiTXq7IxYhBbiPh9COV
	H0LUWxrWm51ABsVoZq3Ndg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugwrfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U0LvZn036604;
	Fri, 30 Aug 2024 04:01:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jp2tga-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRCquFTjlwz6mjQLAKWK7sl/+oHtnYhtuEpxdupu4owqgPEbb9OX9chAglANmafBlySVRQWbw522KLKZiW3U9vhGsopA7veDl4gOyWcK1ODWiw2obVsMf3HNZRI4zIW6IfwTBRIU833vlERMiL/TvLfELkHEKixHefP3ixnPbub5q6CCEHI30CspmT1Q8KHGLZqPFULbINnv3l6WXqwfKgqLJ96QHjWAj6hHVy7YjcgihjWcw+inI+eNI6OJjvobw4zhdTxTntWUMmdBKR+DY051LwVMA9Vk5onKA2RMEMeqN8BHIBF8GaCHSXPEBRKgPACEjZ0qureAo+JDpAyDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls6YlP+qGa3+3FNlDv9PERPNFJAt0V//E29iP7vaPv8=;
 b=VoFHlwM0cLjlraVK9ytP43qpM9GVB/BGVnxJYBJ70KNH1wPIMW22fUBLn1NZJ10c36u5VDzOVBjDnPyHaq+wVuvUVWeeuWnIQmrt7pbkAxvKgv4FE0A23mk2SOo+TJU0fQG6D0OubvG6CRDZybFJZVTkAHgLlikqSpG9Dt6kZX/5lXHDSDRP6Vhm7plzmefglON71euLgrOS/PnOdyswo2hCFPSRZl+Em9ScEZsIr6TsWd9JK0zM1+avaOH+HkXMHBujg5VtkIMQN9XJk9iKA4ZxUYc/fYlljOVCLhu+LMbC9YUE6mDvu78Abf7z896EBgz2aFpmtJL1uBFq92oxNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls6YlP+qGa3+3FNlDv9PERPNFJAt0V//E29iP7vaPv8=;
 b=YyrqeELNPY8dyNk0wuBbC5sIBpD1A9jIP5GEYXajt3ajp7hAu5SUdfmC1L6Mnn5xJ5UjiImf+kZkTaJPO2SrtkEvz5MXJcGNY2pOF2YyljBISTUjHQb6LNFkQwQRt3ob8k82xPQ33HHbuuVj/sWUvD1haxCyFbQcimWsqEraBUA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA3PR10MB8115.namprd10.prod.outlook.com (2603:10b6:208:506::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Fri, 30 Aug
 2024 04:01:49 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:01:49 +0000
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
Subject: [PATCH v8 19/21] mm: Move may_expand_vm() check in mmap_region()
Date: Fri, 30 Aug 2024 00:00:59 -0400
Message-ID: <20240830040101.822209-20-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830040101.822209-1-Liam.Howlett@oracle.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::25) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA3PR10MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: c769d78b-4085-4f64-97b8-08dcc8a8792f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7/tuBpwMzUkHAHnUPRBxKTUV1azZ9uwST74CA6ssFQ2J26MGpJngyKQVLlyW?=
 =?us-ascii?Q?Mz8a/cFL0Yh10neH/fA5EbdJeIrh/Z3N2JAsyrO/pgkfHIMBYDmtDl1SDlf6?=
 =?us-ascii?Q?HfmHnpAe008gTizHurHEnoDxJguoZhFILAXupcJO64rapXJ0mwliQDnVyH1p?=
 =?us-ascii?Q?XzIloSY4skVuGZOvFdFqM9BoK/fZWYU8JnWPRDAOedMRm/X8koyw7IckogOi?=
 =?us-ascii?Q?/bXJRd1yRwxluwFdOxFyisAtDprsL6iQ0HasrLisj0eQ2fNgbsBfC+m3103/?=
 =?us-ascii?Q?dJ1Q08Ow6hUgiRw06bUZlyVo1wz+cd3Vzl9GiRwOo+OioGyCqK+gIKUwuQyE?=
 =?us-ascii?Q?2bBZ1tqaUVhAvAcjwIFZtz4GpO8ffImnOn8Jg+7PGEhIWxZossVIZJLeNTzN?=
 =?us-ascii?Q?UhTmVVsD+7TWOENpAIWAVXdj6qHNH0xBp/daOc0q3cOjmRm6g0TUPjqPwjF0?=
 =?us-ascii?Q?zLxTtsmip9DLoRr9uWE8MgNLjNAwFK9ppxBRbkrHBBXJhWqOHFxElQH0lLlD?=
 =?us-ascii?Q?92BROMZ5AgTCpZ3aUPmj0RENcwULQCSWlnhIeni5G5xFGUAoezG1ezDF+pGg?=
 =?us-ascii?Q?PkRkc+i2xX8MTBz+IUuOQvV5YCm+y9nAJm1Qz2NHQnyoijr4fM1R66gFGSKh?=
 =?us-ascii?Q?SwXRRD5RWgU9ChfVlYlVDaSrEkvOqw/ZcZTyN8JrIdEg+5euQiS/b99wP0jd?=
 =?us-ascii?Q?Go3/fbcsvwqRtnLlFtNoQ2Pdc9qvnpK7Be3xiShrKyzZPRkUYhfbmD/z4OH1?=
 =?us-ascii?Q?A162PDUaMW6VEzeN4cPH+p18XRQZYJGWyid9GWO+Klt+DvZtSK7UskoZhIAh?=
 =?us-ascii?Q?rzCJ5C1mNmcUF2nPChEqIbFrcGKKPfKD6vjZiFokYpAofK5irGs+S9sXCX4V?=
 =?us-ascii?Q?6dM0NL4xIloZqxg3xeV/ASps6UPbFy+muAk4+w5CtBT25v6mX9bwmzGsAa2i?=
 =?us-ascii?Q?NjCBV6DY63EVuff5xdDcEnS5h+VI9fdyYEIY8zhNvZcVcBKdKF2Tkd2ALXEc?=
 =?us-ascii?Q?kZahc1U9tiHyeTN3E/2XPnSersXgdkorwpBvi5ISZwjRFdW4i9MlFcbx8PgG?=
 =?us-ascii?Q?0SQXgQIDqvcKWynJvMajmE5tsFQjbY/0XTOG5I1l3l6rsspPLXoWN0YPP7tm?=
 =?us-ascii?Q?wWB6rZ7MKCwyxtQ+EvEd+h3yfD1GbzGjwTFfizExZE0dcx1piO5FMeDgcPrj?=
 =?us-ascii?Q?nEgg39ppbKJ5uOD6jDl/dc/0wJfRLhI+rGvudp5nc/UYDH4kW1XBNsZVQF4S?=
 =?us-ascii?Q?P35FUZq8Fx5/T1F/VhnNGs6VJnmUqe6HB/gjsIUEZaqF8Cbqmpou66D7FedE?=
 =?us-ascii?Q?wg1bx7z8vKZF9ukp/RDMcow9HKKukIas6Q3ssEAtjZK/SA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gXTl6CGO43aldaAfvqb6TPuGzUrWfnmt0ZCgxsUUAfO/lyXJLbdRYrZ+K1Qh?=
 =?us-ascii?Q?pS4IVH0vfsytt/1YODiEGoVdfCi2UtQbTxAC+09REfjuG7veLRq16XG6wBly?=
 =?us-ascii?Q?Mxxf3Nnp3IQi8ZvZVRtZFMMnjFJt1wXgESf8fY1S7VZ/5CVQwBcpdETM5rrt?=
 =?us-ascii?Q?rcLgzRkI1kfPq7ZIDaBRZoHlZmjZQOHFo5swfyCwwUNhXK0Yj0VoEO80JeOd?=
 =?us-ascii?Q?ANe5J7PGasJNl33Oj3OPTnlBby4Y6BOnIrSHifD4t1Y9OFqWuG/l4ZFicAlj?=
 =?us-ascii?Q?LI3qGTI4e1H6K4t96ZlperakphzcKiTleZfqCWOuX5knq4qiRHgWmrv+Q/a/?=
 =?us-ascii?Q?1ZV3Ne+EmjPOydX4XRYhvIwmoTNx2yFHTci4iqgybopYCvwBoSuBT1xmTUl1?=
 =?us-ascii?Q?aAlkMWfU1NGBy1yMk+J3WhURbUgrRylTyOhF76Ttt8wRWZHr46be/FFR5gjl?=
 =?us-ascii?Q?ZnvrEr2JKgFH8tKUzqyXlPXSWwfN6oIp8sNzBtvM07PNPgLpUheZAzT9VFOG?=
 =?us-ascii?Q?8D2nJoScWz1+SlORDSNDcKVyRpxCmAOFmxJk+xSdHLWszk0ndhhmtK1Li79Y?=
 =?us-ascii?Q?PmErXQ6F/J4J6f9L280i4xMpWEon1Y3XIYqtXTHk2inzhCSJoQVTlgIOYtr0?=
 =?us-ascii?Q?/mFnhVIeFp11wc0Jp3DYYRZD0UNbchCZ/NsyfkCnIMd7W174zPKypjspJiaQ?=
 =?us-ascii?Q?WloE2wSbjuzN7M4m12GmXhD7RAZip9whrp6xbmOWvOC3Zt3kfOs4w6i4RuCc?=
 =?us-ascii?Q?7TCOgwfhAzrRcqC2w77Nz8uEKuihTxh27XrwfnvfcJGe4HdO9IQYJaya23Ok?=
 =?us-ascii?Q?OGAKB009cchA5V/+iZDbBb4F2eVJ0H4hB/D0NCon7V/nZvgp+66zKXHrljoV?=
 =?us-ascii?Q?Q8kwqgQ9EFCKPrG8yVvo7i0AUglrFglsBzWOcH38KCTaU7y5HQahPv4OPww6?=
 =?us-ascii?Q?+67o4T3hl9pmYp8TmWWl++THpnXEEGcqR4244LqdOoaIMDceYbyw8ItUq9+p?=
 =?us-ascii?Q?CTDvPfcIa1wZwpYldG1fhaJv1Px385hmidCjdnTFCipdJVj5uCcA2WxBywhU?=
 =?us-ascii?Q?dQBBbimgKIpWlXwpoaDVfPY2bbxQxYaOiDfMg29RIc5kZixKDp5Gg82DIn4e?=
 =?us-ascii?Q?UO8gl0zIjWwpxgg5iPPuS1hEPxv7pPUS2zXqtBnYPrVfCnGIcOYXLQ5TC92n?=
 =?us-ascii?Q?mK+5wEuSFibueKD+VXgWiQQgK54Z3L+nhzHrAdqSuZZZW5fvDt17Pw4wYLA/?=
 =?us-ascii?Q?9YGnCPGvR5Jm2r32R4TpB59pPfrhbP6NzHT+sYPDx+d5DKxOFVPfp4KP1LKy?=
 =?us-ascii?Q?onOklMRwzuKXXeYuuHDGgIslXWBD1qrf1cjt5LkspDhqtA4OIMGeijJwV09z?=
 =?us-ascii?Q?4uoUxmpAXg+ATF9YVWWbmn+kCgGqL2ZlGH45EKSXxXOVrpMkmprIQ6aHHu5M?=
 =?us-ascii?Q?9PmoFYK9b1iyd0zIXlE4bdMKYrlKBRuWNPT3+2uquh3dn0KME44s9uINaVY+?=
 =?us-ascii?Q?OfSP+sqI2fdkpbOWQ36oO7MuAg9Mk5E10HN6kvENeYAyzY4yLIFbhepR3nOS?=
 =?us-ascii?Q?CPZaEPUyXgNviw/P4KKruXt8PwgLCaMEELas/rfsJB/wcgmRj7nmo4rog53v?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eUq8eiU7bPCcZegGH5tYw/C7x7a6F4tniPSmIkrRbJGeJV2xbmgTcMINSmgTqZ61iT5iVOQc1zZk9XmZuGeFEKPAveKEQxSLddF7VazQTLEn7vLT0nn1p5kaCnLdy4T5d9miTc6643kmsTNbtf1vklOuILCD3GdHhwLyogTuyRFd24IeRLeQwU6SKI3JR80PWGMQa+2NEbamncTURYnDWtGdgAUF6H6QMIazah3g78ACB+yAehJby5pQ01Tgiy27EJxrniRSGBjPD++dX9MG5uIv0Ibvy00qqB6qDo/JIEK1V8hTQC2IoE7z2P3WuHYZR0qxtUe0delJLy6K7L5W12v118pfGW9UD0ekXjX3iaKHQZnxndZqbP7Z5hGRqMYIeHwhsHkqI/a7/q7I+W6sy3PowqssduvxJH50XON0RIsGa6Me2/5YNrfletOnsVpAOXeoT3/o8xBxObBYVOccsEOC5nzTQ1RG2w41iTL/fh6UHTxd810WY4q3Zs4NxDefrPSCzFHYU1vZ3lzQ728/StTyU/0mbQqiA0NB158yyLU8abk6CwaNyIXY5O6S66vgN/QSkmTHocJggBJCGH13QhMbao4jpuMLto4MMtsFlQU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c769d78b-4085-4f64-97b8-08dcc8a8792f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:01:49.4056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWPs0jN3bfJmaRT/sxcCUk1LJ38oSQH6Pe/I9Suw2gelOBg0hFLfGsXzSKoPEocfn2txSxoS5pmcTYcxpM5W4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=976 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300028
X-Proofpoint-GUID: -zRDwOCZO6MDemVYfKCuJLUwuhvqzR5y
X-Proofpoint-ORIG-GUID: -zRDwOCZO6MDemVYfKCuJLUwuhvqzR5y

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The may_expand_vm() check requires the count of the pages within the
munmap range.  Since this is needed for accounting and obtained later,
the reodering of ma_expand_vm() to later in the call stack, after the
vma munmap struct (vms) is initialised and the gather stage is
potentially run, will allow for a single loop over the vmas.  The gather
sage does not commit any work and so everything can be undone in the
case of a failure.

The MAP_FIXED page count is available after the vms_gather_munmap_vmas()
call, so use it instead of looping over the vmas twice.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 15 ++++-----------
 mm/vma.c  | 21 ---------------------
 mm/vma.h  |  3 ---
 3 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6485f2300692..fc726c4e98be 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1376,17 +1376,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	pgoff_t vm_pgoff;
 	int error = -ENOMEM;
 	VMA_ITERATOR(vmi, mm, addr);
-	unsigned long nr_pages, nr_accounted;
-
-	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
-
-	/*
-	 * Check against address space limit.
-	 * MAP_FIXED may remove pages of mappings that intersects with requested
-	 * mapping. Account for the pages it would unmap.
-	 */
-	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
-		return -ENOMEM;
 
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
@@ -1410,6 +1399,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			vma_iter_next_range(&vmi);
 	}
 
+	/* Check against address space limit. */
+	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages))
+		goto abort_munmap;
+
 	/*
 	 * Private writable mapping: check memory availability
 	 */
diff --git a/mm/vma.c b/mm/vma.c
index 713b2196d351..3350fe2088bc 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1640,27 +1640,6 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
 	return vma_fs_can_writeback(vma);
 }
 
-unsigned long count_vma_pages_range(struct mm_struct *mm,
-		unsigned long addr, unsigned long end,
-		unsigned long *nr_accounted)
-{
-	VMA_ITERATOR(vmi, mm, addr);
-	struct vm_area_struct *vma;
-	unsigned long nr_pages = 0;
-
-	*nr_accounted = 0;
-	for_each_vma_range(vmi, vma, end) {
-		unsigned long vm_start = max(addr, vma->vm_start);
-		unsigned long vm_end = min(end, vma->vm_end);
-
-		nr_pages += PHYS_PFN(vm_end - vm_start);
-		if (vma->vm_flags & VM_ACCOUNT)
-			*nr_accounted += PHYS_PFN(vm_end - vm_start);
-	}
-
-	return nr_pages;
-}
-
 static DEFINE_MUTEX(mm_all_locks_mutex);
 
 static void vm_lock_anon_vma(struct mm_struct *mm, struct anon_vma *anon_vma)
diff --git a/mm/vma.h b/mm/vma.h
index eea1b5e9c15a..6900e95bcaac 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -319,9 +319,6 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
 
 int mm_take_all_locks(struct mm_struct *mm);
 void mm_drop_all_locks(struct mm_struct *mm);
-unsigned long count_vma_pages_range(struct mm_struct *mm,
-				    unsigned long addr, unsigned long end,
-				    unsigned long *nr_accounted);
 
 static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
 {
-- 
2.43.0


