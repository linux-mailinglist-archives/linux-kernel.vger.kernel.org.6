Return-Path: <linux-kernel+bounces-241596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE35E927CFD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8661F28620B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC10F13BC0C;
	Thu,  4 Jul 2024 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="akEY+1VT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UG4cY5XB"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419EE136E28
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117672; cv=fail; b=YXIGIx/2D9GQffuBJUwSPePQjPxqkWlfQY1boQvRAWFQOIg+5b0GgSt6/X9PFsaoGlB43ouMwkZawfN9XlNlzWshdzd9gRID64qN6KTYG5aajpAu8d9h/WDYoF8Qzti46dEomUBYtfbJHFG7OyGUtgrzzk6pPMgXyLC1T8cq4w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117672; c=relaxed/simple;
	bh=ZhHASXsDjJQk35XUufOhjqy994W5LpS4Us3LUb2mv20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vD26LzWw3wmRHQebfG55stOivMopCAMVHb6bjFY6m20hOKfcEKskIapL96kqXBvec1Ds8QStCfoLkMItsyEKyBikasiQRSt1z0SVb3b0OLhMaQroodS+JV9voJlngu8843FJ+0CAc7WGVeVVt+gm3HZGY9Y/BcTQ+vhqWDREBTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=akEY+1VT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UG4cY5XB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464Db5N4016625;
	Thu, 4 Jul 2024 18:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=+94w+aUh7rIC0VkZLxNQUqvZi/AuuyUgrmfpptBAnKQ=; b=
	akEY+1VTpi/c/ugDSskvlHPJRcjGkxkohRKP7TZaxK0HWw8UTaHQtj52mI2rVWid
	sqorbVRgnIgCCI/+Q1yMmWF5leYUDh6Y5UDBnD6/COtCLWyw4KPZk20XmzV6h7ri
	D1WYJ0w5iGN+4tTujxfGmhswvHVB4TA+dDYRmy/JoA8veM0vv5d92T2Xav9jjpvM
	scwTxNCp5qOuwaY2rOK/AVNXAZc4UgXP1W77OGaS9MdkB19wNc65RdKNirPXG1wf
	zYN1arMwBUEvBA0yayDGiz3tRWyIRBnLmgRRUr4SGtrljCTOauexAm4P8GxOIqpj
	a/yXBIyOHJA0KpFgORYH0A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028v0tqkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464HF6rP035655;
	Thu, 4 Jul 2024 18:27:35 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qacuj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7IAkSIRQOaxOpvrgDJbMAwsKZfzWBIwt2p/WLRipi4kGhSTGu548HIq/+RhE3xPq4m7woHwfFymTVOm3eCb0mpjOn8Z6l1aAerJDeewx1HuCoKIsELJwUqKtkgZUlNs/RZQGyYb9WjHQjxq6ZfBHc+X2x6dCAQGWnQmQVEVO+ryAzyaFUoh0f1kdmHkASM0S7iFVJ9JCN3lbFRP0OLt48xdz4RsvCkr4usA9F6ZoK9n3VXaEb8zavlm4EPFHVOaSca0S/CfcD6lLLNORAC3si0W/TdUfxLoAKsFFnon8TkgS9eTY975m0aHQ1HojY54PrPT5aF2XSxJcHfnkLYWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+94w+aUh7rIC0VkZLxNQUqvZi/AuuyUgrmfpptBAnKQ=;
 b=UIuhh9jpttPq8dIhVR6Og9QCDFzClc6wnIWvSNOqlwv34eqe2+cAvJAkM/1eV2kt7GBcDWGDb5Yg7z8CB2NWqIlw5sVDChiFyv5KbkgRHpmb68w+6YGTbMIK9QS/f/YxaStS1eHv0VhIP2CKIKLfd3qANMNx0JeQAE+Zm8dC3OfCZlsHTLUL/f+oI/MTJqZDLuNGpLNVlgn8Fu3+MrSmhSqqzcLOZyPsM2LYnb69w3MGaMiWJV2wUg/H4TGKGVLX98mwDcRtA6qndCX4k+wTqO5rvTX8Lb/mkOg1vCKrNvXNhhhyOxRC3YjgE7XObPEc3Nc/tR2hdfP+7ekYKsHHnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+94w+aUh7rIC0VkZLxNQUqvZi/AuuyUgrmfpptBAnKQ=;
 b=UG4cY5XBf15HzHIY7HOE/alDs5LjIqb1xr/IyNAh5Kfs3sdF95v4GVLiYOfEuE7TH2KoHx8or6vDarcF624PetVIWviL16guBPgIbAP8BKsi2OX27LFl0zs3Zj+shbN+wDXlgl3YualEwYerHA3XW6eAa70p7MU04Kn7wVuA/SI=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BY5PR10MB4242.namprd10.prod.outlook.com (2603:10b6:a03:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 18:27:33 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 18:27:33 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 05/16] mm/mmap: Introduce vma_munmap_struct for use in munmap operations
Date: Thu,  4 Jul 2024 14:27:07 -0400
Message-ID: <20240704182718.2653918-6-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BY5PR10MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4e607a-7910-4bd9-93bb-08dc9c56f8a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TyBr4zn48apxomYf3ltYJ1rbNcrwZ2XMvLzCMOWkLITjVZKBUo81167Z/yGQ?=
 =?us-ascii?Q?3P5Slq84s2IhAZY49kOjYXKgwIDVVOGGuOat/HMIWNkR9Eqn18lQMKQF7V9D?=
 =?us-ascii?Q?BqRpb1Ox/2uW0Xn9RQdl0nEn7BIrGBvGNJk6ji/DhWNJWtFOWwzlwiUnQ5Bp?=
 =?us-ascii?Q?I5afhDXiD3BXlL0twp0Ae7IBanbzYaia872c51z53/dPvDtbrWEFkVn9zKgU?=
 =?us-ascii?Q?7+k2JmFXwrBpkVDZDri017N2H/OlCsf3Q0biWJqsVh2FV+nnGF28mjm7ioV0?=
 =?us-ascii?Q?KysNqTss93tQjImA0L4EZfUqw9PusNYvRb0UxTJHKRT+BttqF2DQpZXKJVR/?=
 =?us-ascii?Q?Vh49JIMr04NszGIfIMBEuTSmd9MFown90qw4QMHpxqLjgBJ+0cNrH1/wSxgz?=
 =?us-ascii?Q?WyZ+FaMGLUUx6WVYYn0fYEGS4pJaUyNbbwIXBGg/SX9gFDrY2oe/qdRQ8a61?=
 =?us-ascii?Q?ap/8iO7K6C74O8/J6hWttJ2xPr4Y9UYrviEh8a6kk7nkg36uuvZr5A6bSgOx?=
 =?us-ascii?Q?eKmuWqwNi1hcKWQBAJj4gQiNx9dG6tMXlqNKaaDbaj0ZbPsd6kuIF634LwWQ?=
 =?us-ascii?Q?Oc5Z7jWTcgcnfJwcsf1VPuIJzV5hB02mmeGk7J/vhxFv0wIytibf8QeCM25H?=
 =?us-ascii?Q?uTTyCxnE3ZtBBRIVOyXDcxevP7yBtdGsIbl2NWCd07n/zeyDQnaa7WEELyf0?=
 =?us-ascii?Q?bHU597FRITvlcSaBM3eagh+9UEZG+RWRKR96pPq85/ZnSDJaqv1JaMZxqsNf?=
 =?us-ascii?Q?2RDoOMKKnd5zRp1mnyxWIrvS+E/sCz0ENP4zMPSuquY+LDIDQ9j21XOI5Urx?=
 =?us-ascii?Q?C/gZNq940RN4u5HucfznS18bUWTanEUcBPnGs/X0JMVeDH/zH71qP/HDJR3/?=
 =?us-ascii?Q?wp+07NmLqygLUHdI2IDwtblCfOcKWt5BU3oH+a9+Rc3QZvlUEmJ0gFnatA3f?=
 =?us-ascii?Q?cmy7ImLY9mxlqOPjnRVCn6I3EIpyoUb04Svt2VgRXBSJS3Yp2zRoAcAFni0l?=
 =?us-ascii?Q?KVTozStPEk9yq70ns1AZvDic6WviVCkO27ANOWfxclrZQ503ZRwmD1gBbYsY?=
 =?us-ascii?Q?uoU6DTnAkQW+kQMneBHK498YlXgcDV0S2GqN7MQ5SkiWeZx5aTCESq3b+ROA?=
 =?us-ascii?Q?5iD3qr5ppcC05W220MTc8qP1V75PsHk6nlCC+GVaeGGbLrdzJhfe3p29RjaD?=
 =?us-ascii?Q?mrrL486PsfPc8w5tncV4oHU2FQ3wOpJmuAuMUFL0fukZmjDc67fWWqytxLd2?=
 =?us-ascii?Q?PFZ4LRqPomj5FADb8EHHwIUDaACWr4/BWaWTLVslaQPTn+w0O39qZpY6JZ7H?=
 =?us-ascii?Q?riilM/9QbPg6PskT+aUwn4zJ6DjnktWS187g+nkuaviTYA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?quVJ2AYEDMXO41TKjou2ngrnrryyzgUDM+/ir/mcMWAcj7XMilDjc8yxL0J5?=
 =?us-ascii?Q?uw6R8HqPLK9isNbaGREYmZhXVhROaakqKi2+5GBIK8ggV08dZlWDrf8pXhRP?=
 =?us-ascii?Q?A2+fvOIAN4CRnZtzpa/OZme1sFnZgHoKBjcU56UgAB6F4BZ6Y8Np+CadBh4z?=
 =?us-ascii?Q?zoB5ZqeMp9EJrRurUA1rJCHSG23iZ/PXEhFCruTYYQJSYF/Cx0EV/jEt48j+?=
 =?us-ascii?Q?IfLCLIPZ3eMalfHODa6TiTDBbZal5smexgVO3Ch8952onh6VXtywK5LkyF7W?=
 =?us-ascii?Q?ZW9Nz/htooF2EHZrOsyDusLyxfw1VtJvkjex6ydueWb4kjBEc9ahMiqp//U2?=
 =?us-ascii?Q?7nMqDzBl1avcK5XeK33wJlzRB8jjYYT9tRwzhHm6FALn05g6IjysjwRHiKfi?=
 =?us-ascii?Q?PRrWSjug7AVM51/uOVyVkiJVy1N/TjekT+lIQHUUveXKL0moBitk8DGJOTGD?=
 =?us-ascii?Q?WluIjQYNa3fdbvA72K1rKPmpoFGMhsE+77ZtVWnPe8Vb0+P/0zr95QceXRxp?=
 =?us-ascii?Q?cRjjvNVUAD1FXR8JTdnQz1U6ihaBDX+eIsBMHLZDvST+9gsjTZy6+Hc9QC9/?=
 =?us-ascii?Q?D/vUd/vhdJpBxqJ3V0aL21fAK7GW2+d3zcfomqdn0MndY5ouvpOV3kqoQWxj?=
 =?us-ascii?Q?bvITAzUwNUl+td8ipeh3muGUMYzxriAc4aGJ1HLmaBc79SHa/SK6QZ6a3tpb?=
 =?us-ascii?Q?7uLOBK69NC9KVemYkTlwKyaBhJMcNMfRKdxtaQcPcVxg2H/Mj8pfNiXyRskA?=
 =?us-ascii?Q?CdOOExiC/bqZB0Lc40WBOTPJUkZNjXOBk203xVWBVrsP8yd3/yW0p9TN3324?=
 =?us-ascii?Q?uyOhPDiTCvO3rlwxYmZoFqaI6OMLbSMyHf4bbB9zZh76PR39RCStDRdOqKTJ?=
 =?us-ascii?Q?Vdw1CaNpqlk0CCeJz4j81suKORQfx3j0NuMTBE7vCzSIdERiGwjsvK7U+rMJ?=
 =?us-ascii?Q?+d0IswjbX5fjOVjzTQMmlWZJMuNn7/ucRwmI+PaaIxK7YX4Vv1R7P6bMIVlW?=
 =?us-ascii?Q?HoMLmnTbJ0MEmn94rSldN+91CrYzF7PBWCQUfV9jn7beLS82ltH/IpVYdbV+?=
 =?us-ascii?Q?2s60VETiYlnbTBY9ijztSS2jI9Z07gUGRRn+1wfMRrIsnU5fUUj0gsPXwKlC?=
 =?us-ascii?Q?7tCJvr3wc1koRSX3MyTak44JylWjD54bKd0tdyiAFvQDQM8aKOF8qYm0EAxo?=
 =?us-ascii?Q?o1FxKi+xUz9u7ksPSkQv6wql+R38ZnAnTRjk0g5HbtBBTTfsz3D0h+51wRvP?=
 =?us-ascii?Q?bz6tDI97HBAi+sVxwUpI4OcMI3S/eeZ9XU3J5dQv8Ek83RIoNPYycXsYylZv?=
 =?us-ascii?Q?x8G+Svq8kwYIC+E+U2N+dmQAjCSgQ3MYTw4E3wEsFAFaG6SQ3CkDPypfaeJi?=
 =?us-ascii?Q?M0BFGVZiky6jSCOha4m7K9+NLF7GnFPKQ97HzJrFnaNO/kYSjM3O3e0rW05z?=
 =?us-ascii?Q?55hiYHcUvGqtHrnl1jultnGGFpnzor7gOdGlg4J1m55sDZ7xtgEF3b/8qTYP?=
 =?us-ascii?Q?7OLUFxFIzqG76Cr8TpndheedGLuTfxX6U7vaimCEQLFavqXWGbW2tV5GotHO?=
 =?us-ascii?Q?Z5wLOMb5j/PVnJDiHvKNDdHHqbSFc94W57pN7tVJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TSJ2QIDY9wzAWk01wGq35hPw8y/U1xTrjSr4cjBEktWCmg4R0RRel5S+mzI7QBXu4QYLy/lE/KQz4aB9BdhCL7HmAhP5gkSyAiHNxtH7vAxGxo+48RiQKaVDbZV9e3yRNiuupqaDBb0EfVBdugJxq2yUey7bHQRjf58kun75DNcXHHi6mj6kKKggQBq2xk+w1qnjKpM040wJRL9k5Ejw59fOPPg/Pzr87asdLikWXjlALS8h+SEvpntSuBQgeHbsJ8AbZv/3IrZK7RtgwUThIDjQZjclcIzNrijsITSLRmjYkXLVMeZ5T5QG+8L8hLp3tKXCVn0+E1FpMXbR+98z0r+BgRr7y51AyFnxljWrl2wD055TTVVUJIBLRRCxiwvads8alBhIwEdYkkdLPcSyYeNJX7oa16mdHhPRtZMZivYwQnvmoV8Szs5DS6SHXywsNmMM38PAfCR/9fgSWLhYuK5aJLJNegXN+GPMvQ6F/74fCNf1n8VQsnGdkrJtbXK2WtQnQUMfb+Gh/y+CZ2wqfCa36YVBcxIRF5TSBCIWZKjU+aNkVHUwi5nOAqFCE5F99L34xXY+P4r7obsrYGgBsMmycOUJJ3S8wPVJ31iHOBA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4e607a-7910-4bd9-93bb-08dc9c56f8a5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 18:27:33.3273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kg/yl5RrqNIG3EM6BiH2RTk/4+B54vo5sgpd1K2tlx0CWaWzkXN6cHvEUSrnw8MNUAFNv+GbaxerLWUdfSQtJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_14,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407040134
X-Proofpoint-ORIG-GUID: QtWr2BaTsvvemOnCSPMscJQ9mTV56EGz
X-Proofpoint-GUID: QtWr2BaTsvvemOnCSPMscJQ9mTV56EGz

Use a structure to pass along all the necessary information and counters
involved in removing vmas from the mm_struct.

Update vmi_ function names to vms_ to indicate the first argument
type change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/internal.h |  16 ++++++
 mm/mmap.c     | 137 ++++++++++++++++++++++++++------------------------
 2 files changed, 88 insertions(+), 65 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 2ea9a88dcb95..f1e6dea2efcf 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1481,6 +1481,22 @@ struct vma_prepare {
 	struct vm_area_struct *remove2;
 };
 
+/*
+ * vma munmap operation
+ */
+struct vma_munmap_struct {
+	struct vma_iterator *vmi;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;	/* The first vma to munmap */
+	struct list_head *uf;		/* Userfaultfd list_head */
+	unsigned long start;		/* Aligned start addr */
+	unsigned long end;		/* Aligned end addr */
+	int vma_count;			/* Number of vmas that will be removed */
+	unsigned long nr_pages;		/* Number of pages being removed */
+	unsigned long locked_vm;	/* Number of locked pages */
+	bool unlock;			/* Unlock after the munmap */
+};
+
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid);
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 8dc8ffbf9d8d..76e93146ee9d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -500,6 +500,31 @@ static inline void init_vma_prep(struct vma_prepare *vp,
 	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
 }
 
+/*
+ * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
+ * @vms: The vma munmap struct
+ * @vmi: The vma iterator
+ * @vma: The first vm_area_struct to munmap
+ * @start: The aligned start address to munmap
+ * @end: The aligned end address to munmap
+ * @uf: The userfaultfd list_head
+ * @unlock: Unlock after the operation.  Only unlocked on success
+ */
+static inline void init_vma_munmap(struct vma_munmap_struct *vms,
+		struct vma_iterator *vmi, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, struct list_head *uf,
+		bool unlock)
+{
+	vms->vmi = vmi;
+	vms->vma = vma;
+	vms->mm = vma->vm_mm;
+	vms->start = start;
+	vms->end = end;
+	vms->unlock = unlock;
+	vms->uf = uf;
+	vms->vma_count = 0;
+	vms->nr_pages = vms->locked_vm = 0;
+}
 
 /*
  * vma_prepare() - Helper function for handling locking VMAs prior to altering
@@ -2606,78 +2631,59 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 }
 
 /*
- * vmi_complete_munmap_vmas() - Finish the munmap() operation
- * @vmi: The vma iterator
- * @start: The start address
- * @end: The end address
- * @unlock: Unlock the mm or not
- * @mas_detach: them maple state of the detached vma maple tree
- * @locked_vm: The locked_vm count in the detached vmas
- *
- * This function updates the mm_struct, unmaps the region, frees the resources
- * used for the munmap() and may downgrade the lock - if requested.  Everything
- * needed to be done once the vma maple tree is updated.
+ * vms_complete_munmap_vmas() - Finish the munmap() operation
+ * @vms: The vma munmap struct
+ * @mas_detach: The maple state of the detached vmas
  */
-static void
-vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		struct mm_struct *mm, unsigned long start,
-		unsigned long end, bool unlock, struct ma_state *mas_detach,
-		unsigned long locked_vm)
+
+static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *prev, *next;
-	int count;
+	struct mm_struct *mm;
 
-	count = mas_detach->index + 1;
-	mm->map_count -= count;
-	mm->locked_vm -= locked_vm;
-	if (unlock)
+	mm = vms->mm;
+	mm->map_count -= vms->vma_count;
+	mm->locked_vm -= vms->locked_vm;
+	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	prev = vma_iter_prev_range(vmi);
-	next = vma_next(vmi);
+	prev = vma_iter_prev_range(vms->vmi);
+	next = vma_next(vms->vmi);
 	if (next)
-		vma_iter_prev_range(vmi);
+		vma_iter_prev_range(vms->vmi);
 
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
 	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
-		     !unlock);
+	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
+		     vms->vma_count, !vms->unlock);
 	/* Statistics and freeing VMAs */
 	mas_set(mas_detach, 0);
 	remove_mt(mm, mas_detach);
 	validate_mm(mm);
-	if (unlock)
+	if (vms->unlock)
 		mmap_read_unlock(mm);
 
 	__mt_destroy(mas_detach->tree);
 }
 
 /*
- * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
+ * vms_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
  * for removal at a later date.  Handles splitting first and last if necessary
  * and marking the vmas as isolated.
  *
- * @vmi: The vma iterator
- * @vma: The starting vm_area_struct
- * @mm: The mm_struct
- * @start: The aligned start address to munmap.
- * @end: The aligned end address to munmap.
- * @uf: The userfaultfd list_head
+ * @vms: The vma munmap struct
  * @mas_detach: The maple state tracking the detached tree
  *
  * Return: 0 on success
  */
-static int
-vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		    struct mm_struct *mm, unsigned long start,
-		    unsigned long end, struct list_head *uf,
-		    struct ma_state *mas_detach, unsigned long *locked_vm)
+static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *next = NULL;
-	int count = 0;
 	int error = -ENOMEM;
 
 	/*
@@ -2689,17 +2695,18 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 */
 
 	/* Does it split the first one? */
-	if (start > vma->vm_start) {
+	if (vms->start > vms->vma->vm_start) {
 
 		/*
 		 * Make sure that map_count on return from munmap() will
 		 * not exceed its limit; but let map_count go just above
 		 * its limit temporarily, to help free resources as expected.
 		 */
-		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
+		if (vms->end < vms->vma->vm_end &&
+		    vms->mm->map_count >= sysctl_max_map_count)
 			goto map_count_exceeded;
 
-		error = __split_vma(vmi, vma, start, 1);
+		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
 		if (error)
 			goto start_split_failed;
 	}
@@ -2708,24 +2715,24 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	next = vma;
+	next = vms->vma;
 	do {
 		/* Does it split the end? */
-		if (next->vm_end > end) {
-			error = __split_vma(vmi, next, end, 0);
+		if (next->vm_end > vms->end) {
+			error = __split_vma(vms->vmi, next, vms->end, 0);
 			if (error)
 				goto end_split_failed;
 		}
 		vma_start_write(next);
-		mas_set(mas_detach, count++);
+		mas_set(mas_detach, vms->vma_count++);
 		if (next->vm_flags & VM_LOCKED)
-			*locked_vm += vma_pages(next);
+			vms->locked_vm += vma_pages(next);
 
 		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
 			goto munmap_gather_failed;
 		vma_mark_detached(next, true);
-		if (unlikely(uf)) {
+		if (unlikely(vms->uf)) {
 			/*
 			 * If userfaultfd_unmap_prep returns an error the vmas
 			 * will remain split, but userland will get a
@@ -2735,16 +2742,17 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			 * split, despite we could. This is unlikely enough
 			 * failure that it's not worth optimizing it for.
 			 */
-			error = userfaultfd_unmap_prep(next, start, end, uf);
+			error = userfaultfd_unmap_prep(next, vms->start,
+						       vms->end, vms->uf);
 
 			if (error)
 				goto userfaultfd_error;
 		}
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
-		BUG_ON(next->vm_start < start);
-		BUG_ON(next->vm_start > end);
+		BUG_ON(next->vm_start < vms->start);
+		BUG_ON(next->vm_start > vms->end);
 #endif
-	} for_each_vma_range(*vmi, next, end);
+	} for_each_vma_range(*(vms->vmi), next, vms->end);
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
@@ -2753,21 +2761,21 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count = 0;
 
-		vma_iter_set(vmi, start);
+		vma_iter_set(vms->vmi, vms->start);
 		rcu_read_lock();
-		vma_test = mas_find(&test, count - 1);
-		for_each_vma_range(*vmi, vma_mas, end) {
+		vma_test = mas_find(&test, vms->vma_count - 1);
+		for_each_vma_range(*(vms->vmi), vma_mas, vms->end) {
 			BUG_ON(vma_mas != vma_test);
 			test_count++;
-			vma_test = mas_next(&test, count - 1);
+			vma_test = mas_next(&test, vms->vma_count - 1);
 		}
 		rcu_read_unlock();
-		BUG_ON(count != test_count);
+		BUG_ON(vms->vma_count != test_count);
 	}
 #endif
 
-	while (vma_iter_addr(vmi) > start)
-		vma_iter_prev_range(vmi);
+	while (vma_iter_addr(vms->vmi) > vms->start)
+		vma_iter_prev_range(vms->vmi);
 
 	return 0;
 
@@ -2803,11 +2811,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	MA_STATE(mas_detach, &mt_detach, 0, 0);
 	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 	mt_on_stack(mt_detach);
+	struct vma_munmap_struct vms;
 	int error;
-	unsigned long locked_vm = 0;
 
-	error = vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
-				       &mas_detach, &locked_vm);
+	init_vma_munmap(&vms, vmi, vma, start, end, uf, unlock);
+	error = vms_gather_munmap_vmas(&vms, &mas_detach);
 	if (error)
 		goto gather_failed;
 
@@ -2816,8 +2824,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto clear_tree_failed;
 
 	/* Point of no return */
-	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
-				 locked_vm);
+	vms_complete_munmap_vmas(&vms, &mas_detach);
 	return 0;
 
 clear_tree_failed:
-- 
2.43.0


