Return-Path: <linux-kernel+bounces-572020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FE6A6C582
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF328189CC42
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AB623371B;
	Fri, 21 Mar 2025 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a1kqZ+H8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YFAPK+8b"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B67232395
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742594107; cv=fail; b=XXgrE2ijq31bxDQ976VXyBmLVu4DRJ6irsACvpkqPwY3OQMxSCRPUr7EyL/fh+t878S1XVPOTqUUuiz9D3Y9Ijlo08TcKhIShcfV3wNP2Lny/LaRb+iHxBVeA/6+x39N/dtwr3ZxmdSaSALx4/q/64VrUBEeWBMWjav1cVQAkI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742594107; c=relaxed/simple;
	bh=oihNkfJQWcgGNmEt2DJf9ZX8XhEwmCcHUmdHvAJk2jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uvOnT5e6p/cs72NRfwO5kxS3TqURBSI8fkqgetvb+HeCN2O3JHhnbOqNeNub5N9YDkj1CKarIsETVE/QuwDGhJ9BGGccmnPjMXD1+G5luf5BLfIkIDzVpzNxXvsYZxVShMzatHGm//rcsiYrtNER5JiLKKL8P0Cw1SmwNDaBvUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a1kqZ+H8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YFAPK+8b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LKfwkN005492;
	Fri, 21 Mar 2025 21:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1kvm3UDHamn645oOdYhnc+vjXMc0M/KQa2SlxBwaiuI=; b=
	a1kqZ+H8/+LQaIaLnq0CVh7u+5AEtXy4bEYgqnG2pwFMlB81Xo37CN5FJec/pE6n
	ZQ0tOVV7Z7dBRYYzwhYIT39zqpJWtAn4gD5whmisYU+zHGvvmMO9VMK6GRAI9OtG
	eTPv9tgJj1Qbd8g70mGyPd2CV7qCJnzq4NSIFahh3XtY/W8THCe8kJoICtZNPhsB
	WprXMujBUhZSQmj5SJSlAcdWVjHdfKZthlb34WjcWL7/2Ib9U9rtHIGBcioGWaum
	sJi90JveMgmt3vcRB9zXGxzX6YK2moEEDkjSB9g0uXL6vxp+aQk4oW5aNhGsA4m1
	qdzOFi5vMLahqirtq6DZBg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m41dnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 21:54:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LK2WRM022409;
	Fri, 21 Mar 2025 21:54:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxcah0qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 21:54:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKXfR3MUbha+4jdZZ+iNpNP9q1Plb7N0Gq8GuupM57J8A+ulq9TLsysFIJD6ZOsjEYmqcMxWThKuklQRC9/5o1Q793BJE8iJy+HWWL67g/QdCPQmliq6valg1jMszDz7O0sw2b6+w5fr3vb7OUyQcpI20g7esUq0tDIGe52be/7fo/0kB+261LqlQyrbbKZbUMzo6I4lt/tETzZb/QN7X7aCNmrQHxIzP/lRDWf0aYUey37oq2UkvYTRoBRmWb9ERlmPBWVOt2c1pXEoKFdUq3g+oVbLkTkN5zebPkfa8GiwihigFNd1oPsQdSPYcesVA7O9rfSf7B6PQkHVwLeIRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kvm3UDHamn645oOdYhnc+vjXMc0M/KQa2SlxBwaiuI=;
 b=px02bUtwC1/10T6fSyZ3K9pB6sahyUJvrnCI2DivLWwIH8jY4T7XkoSXi5Fvw6Cvm7QwhBnfrsCOCEtCzG8JDBegK0Y4XcUemh+Ry3TdLOmmnGPKbxDTWq5j0utCUXWddOe2KkQ3S9067xVOMMdcMv/zvp3PXUi6fNbXYuJ5ulmuZsom7dRjDxogk9DLMFo2XRNYkKFX1f4ZxcvG09PuLe+kDuPwJGFAnGa4u0mdXNHa2yMIvWc79c/DAbPSEDLmJJCUKExz2/whzq2O4zTJI4pfzRmr3ockKE5WcnRgfYkgd4rTxqZs+dOGt635UVAE0kzlgHWSvmZ9a++sBlzPyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kvm3UDHamn645oOdYhnc+vjXMc0M/KQa2SlxBwaiuI=;
 b=YFAPK+8bPVT6vmuv4wViTZ9mKLlpKqixymt/0yCx4JGit0563N8SM9LBiQozRO//ZuNdam4B/b75hLCEymPtI0f0/RSwAo+WMhh9PSD+FWECB2ghXVHdssXsqK9jW6z/OX1pJDhW70KjBpnhH25i4NufNpQKd+pwYNjICE6tBLs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY5PR10MB6144.namprd10.prod.outlook.com (2603:10b6:930:34::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 21:54:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 21:54:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/7] mm/mremap: add MREMAP[_MUST]_RELOCATE_ANON support for THP folios
Date: Fri, 21 Mar 2025 21:54:32 +0000
Message-ID: <5b9f21d3a0b5df610877633127f975c2d79ae46a.1742478846.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742478846.git.lorenzo.stoakes@oracle.com>
References: <cover.1742478846.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY5PR10MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 017b8123-99dd-4157-da6b-08dd68c300e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DhUjxCTlkiU53QatdbgFmTbJun4e8vvhWasWbGb0qXZLzRysudRLE/aK3eBH?=
 =?us-ascii?Q?JxYDlqd7pXnyRFu8ynhDtjjl9quzayE75wWX8S0DM3Loclt/SO76DpGt05GS?=
 =?us-ascii?Q?leaQdkqTre0zNrRLXkSgm5R0uxyECpNwRE7a9Z+tRIE4h3+njYe48l5MjslO?=
 =?us-ascii?Q?BVyy+MVpy0UlFdwOli2BMbF5YcapklUtooepLvCiHF9DCcTMCIh6Y5kDgX36?=
 =?us-ascii?Q?buLL/2LjQmHM1Ik7IS6dAjTsWMmx0WHzbwROpO8ZsiT02mocwhghj97SyaHD?=
 =?us-ascii?Q?wZh+blLcbbbwVgHF5SWRuJzDomDljovcwxbLfZHWUCuUgkxh+Y/GzY+xytGS?=
 =?us-ascii?Q?/u+gCHirqYFax0OakQD0OA0Qn3343rTTyg+B7nXdf9lTeXbA1aZDairJGHuq?=
 =?us-ascii?Q?VQ16Q4x6cK7x3tSCfmB6kcAkwttB0dDWILJn0is/Gx7udoRw8PIHO9fC6r28?=
 =?us-ascii?Q?JtfJmgUlbnsxDtNudG34nqLnuckmx9fsT10wSALYMUS9CNgfVCYs7KNz8gtd?=
 =?us-ascii?Q?AU4WOxCoEta/PuxI84v6FARkr9BvGUOEEwF9+PxDmHokrvYODCiEKXClW5Xa?=
 =?us-ascii?Q?Nd1ptyZlueCx63GFCQiZkFj3T5WVo30S0HMsfQT3lHktc4u+avurpafgBOpN?=
 =?us-ascii?Q?yToBHkhvlofvss5oHi+CxusCNu09EQQCPp+IHmCJdqJhMFYaWoUDh2UNHF3L?=
 =?us-ascii?Q?+Ykx7Agn82V9oBsPIwFyn9nV9ipdmQExXSl3wR8RcVuwfI8AFF6tI1Eyx+8V?=
 =?us-ascii?Q?SwD91Qkxsi3MqOOHGygmE/YuLXW3NU6TIj70mobLAxivCdISKBxcGQUVaaYq?=
 =?us-ascii?Q?jFdwTjDplwHC8dF1fajvxgOUQuMNsg5skizAmWFSvh3Dlbm158HzaxqY+Z/k?=
 =?us-ascii?Q?YDezBjhyPa8TiGwA9JS3tGW1Fri+1UP9Nr8HOgPaKQUY/15EjLzJFpn+TzSE?=
 =?us-ascii?Q?FGzbhiog1Ly4BYbAvGxeWFowQ6hyZKb+B+XGd55RV43T7Av9RRajZ2AYfoje?=
 =?us-ascii?Q?s7h0XX/tWxRI+Xib2txj0b7bNNc4jj6uLsLAWDkIWGWC9ZXhjmis6twmnfre?=
 =?us-ascii?Q?nZ1dvQPOb81Y6/nfLldy6W7FqGbaeiJLfoFZ2NIUD9G1MCQEHefo0cxq8fbC?=
 =?us-ascii?Q?lEBN9cdivOmb0Q7BaextIMP3n2+Vw0GhGQtLsgMflf5U7YimaV4M1Udk8ngj?=
 =?us-ascii?Q?pdidqQb3aonUKD0gOuvuha+CPavnKzXf21Yka2JXhOvLcTLNEhhjg7ckBQ4A?=
 =?us-ascii?Q?AiOmkRTDMusRgLP8QIEs4qZhWmaWL8upOYZ0YTUOOk5CHhkHGgY5jlaORTZx?=
 =?us-ascii?Q?7v0ezSWrJX6a30yY6lHDGJf9jSnz7jm+YqH/13MGDgVGM9xFuChZaVfBJMGg?=
 =?us-ascii?Q?Do++cPoFzQFIV1iSk4TJxEEynZcA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P9GO821tCOM9Y/rDgq6HefV42rn432ol4xPx9VD9iINZ6leFUcDRTRNoZ/9g?=
 =?us-ascii?Q?DvN8yg+/mvd67iuvmTa9mel7zgLowz/nQvDwv9I3xt6VoqzhkRGoSDQZ+FGu?=
 =?us-ascii?Q?ZX8+kHlV0toGlTnxt4V+6UIlU4eaPqj6L31lNDLj0N1/XSq+FAbTi9wGc/EU?=
 =?us-ascii?Q?SZQBV3TQ8s60mlMLXdx+JwaMSbPdxoAfhyDWpsvwzcCq8QG4GSYrJYfiaSqn?=
 =?us-ascii?Q?f/acpQM5R3+Ku1uSUJiO1jq7zX7XDpsj9OqvqG+k7BLICkFRX/EyZiiAell/?=
 =?us-ascii?Q?S6yhRUc6CZFoVlsBu5UpR3Bo/cSS/UG8ekivWZ9DRISSAqqX2ttNiuftVVOH?=
 =?us-ascii?Q?mJPU4YhqnavRYKi59GI84/yEWsEheStiEU0GRKOSvMeEfhHeABgtOTZXPx6c?=
 =?us-ascii?Q?DOIv10n1AK3Vfl+OOTamGk3Fj9KxatGQUhk9rTxcBJWsroS+wmcpFdwYrKBe?=
 =?us-ascii?Q?Y20sARIpYYThQG4bwh4NG/PGbllDNtw5d2V02VuBuQtiM94/BvGGKPAddTKo?=
 =?us-ascii?Q?HiBKKE26ZKHdAB4cHqON+t7znMFdKtHhwmVcukKICMZq/K48G3JuI8thuh3x?=
 =?us-ascii?Q?dIEupix3x2tn4eihYJhUli7CS5tTtyiM7AEzrk60sJJO8yP8Rr6lH2cswbnT?=
 =?us-ascii?Q?4BRUF8a8jx/rEH3ZSE+mCabi4plJ0aoyRRQac93VmwH8DB/JklxroX01zjav?=
 =?us-ascii?Q?f1bW8ijg1k0Qgku9I3FHVIPIjFu4WXHNT4rH47+we7eWqq0pWhRB2kDH/3CM?=
 =?us-ascii?Q?8C8a8nwkz3m+rPRdIq+QLUfA7XjkuPoo4YkcNBciKyApfU/6oTC/IBBt7Jxq?=
 =?us-ascii?Q?GamBGAQcOuiFhq30FhOpIXapP7FFLQ8tL7lA1D4eSFZgrNJJo7iS5vPU7WmH?=
 =?us-ascii?Q?JWhRSXo2gNxjtcxyF/GeQzLQQhWJvruetxkSd09x7G69JjhY+H3p7WO4+D2D?=
 =?us-ascii?Q?7vt2kUrino7fwEV6W2IXU7VSb3zaGn0oMQXhYY0eyhj10cUbaFkU2lYlzOjw?=
 =?us-ascii?Q?bGkrvIRibVMxuQzoVgGENaMjZnOjXWHwLGIuzHRWX7H+ztIYofy6L6PIoLTT?=
 =?us-ascii?Q?5d6iz9RKxXPh+K5tbKaqtwyECrWt2+n+kEV/At+ZjKgju2OYq6oSc7qENrj2?=
 =?us-ascii?Q?gqbmZ/jRlu3/WQdg5mJFCA60tMiDNk39aVYs92t9wcjt4ArnjmKdioiI+O6t?=
 =?us-ascii?Q?oje21AzPbfP7KDLl2FVrOrk8HYDBRTuiBkvmEhbm03PWZulXGzubW90tGDsD?=
 =?us-ascii?Q?ScrGFG/2lvmfKOV/1xViyP+dyjGfGeKv0PMZ2mau3iRAnsh1iHlhoqvav4fl?=
 =?us-ascii?Q?7C2yQMos0l/rkqIcH5LyJCg7MjuaVPtvFKeR1H2IUQ9lRSVhyZ7Uzd0DS87a?=
 =?us-ascii?Q?w2pB3zCJP4kUG6PIUjOR9IE7hx36REAY5kGE7KERusWSqak+Hv5+arAextSP?=
 =?us-ascii?Q?AqXb7UGa3xO7125x9x5jFHXAfEJbqKt6I+0QzZVhqc3kZKFiaddTEw3Keiic?=
 =?us-ascii?Q?wJzgjqh3nVr+UgXbZepa3Jf0y9Pko5ssx88NqzJ5dPev7cumpgoKiBU/4HmL?=
 =?us-ascii?Q?IdV4c3zpb0cq4b9j/J0PgkKaCF8PUlxUTE8cv3UEmkEYFZYmvy0NnRA7l3cl?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kL8H4g9sDfn5ZYN+2ngL6NWomUz/gR6ypdZzojwI5PZuY0gsvopUvFY8Czt+AmFJcfc4tPE3S9H2GnjBbh0ZgdyTRUYlPjHlYCwhrTCCUxQivE0WJty648SgZ6O8Y3Nby97pylyaiH5g+SrUN8IQKAgp7Xz2EOx8BTX8/5DHjfFTc8okFPvO77zx1U2v2HPe0P40GuR31pPupfdzVZVmT3ipn4SuIECnQR36amrKcOiO0fTYFzSVJQYY4yIq9C3+DXDhzAfzBCc/9iZm6oGSjtyMiW0A1NQs4xwZG0SudrBdLrrr+F9+EU7DlJJgaKHidYKHNrR+cWKtLDlPwdViJkYdWyXzghRMItx1jIQNc+VPq72BG1ik2XTZXFtuGmT9BHsPEzStZN7MhZTORGqtCZEJrl2qXYk+WBlv9ZiYlToG0AugOMWasa+8mmO5H9qureNU1UftswAqaUhvPXYKhX24g07Y6Vckc3bEqTC3eRqsDWF7VjUJtJGiX0mTlV6npSV6ElQLnyMLesOJItRdyWSgPhQCth40Q7Y8nSizp+HA9O6l/x3aoK6mVgaBHqsVwqo5p6gmQEUi18ByoQTeHSfuQ1hKQZM1+gg+7ETZ81g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017b8123-99dd-4157-da6b-08dd68c300e8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 21:54:50.1613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hxc72cyjiE9eOoHxkaqm/mcHv6xSMxfHbS0JGiaiaL5GC4LZPAs+SbyHfla1HMdMDNYPfI4cQNT08ILM5a+SiEJ2KZNYnSkeBPpHP1qPbjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_07,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503210160
X-Proofpoint-ORIG-GUID: Dba4zAsvbblfnp_KqTPChuBh73EGqp3Y
X-Proofpoint-GUID: Dba4zAsvbblfnp_KqTPChuBh73EGqp3Y

Transparent Huge Pages (THP) represent a problem for the existing
implementation, as we don't know if a large folio is fully spanned or not.

If not, then we have a folio that straddles different anon_vma's and thus
which cannot be relocated. We could split the folios, but it seems unlikely
that a user would prefer such a heavy handed operation (which eliminates
the THP performance improvement) to simply disallowing anonymous
relocation.

Introduce the ability to both relocate huge PMD and PUDs if wholly
contained by the new VMAs and, if the PMD or PUD has been split, to do so
at the PTE level also.

In the case that an ordinary mremap() call would split the THP (that is, at
the page table level) then we preempt and do so during the relocate
anonymous folio step.

We are able to handle large folios of variable size correctly at PTE level
generally.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mremap.c | 275 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 241 insertions(+), 34 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index f104147cd66d..2f8853d1f2e7 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -524,40 +524,67 @@ enum pgt_entry {
 	HPAGE_PUD,
 };
 
-/*
- * Returns an extent of the corresponding size for the pgt_entry specified if
- * valid. Else returns a smaller extent bounded by the end of the source and
- * destination pgt_entry.
- */
-static __always_inline unsigned long get_extent(enum pgt_entry entry,
-						struct pagetable_move_control *pmc)
+static void __get_mask_size(enum pgt_entry entry,
+		unsigned long *mask, unsigned long *size)
 {
-	unsigned long next, extent, mask, size;
-	unsigned long old_addr = pmc->old_addr;
-	unsigned long old_end = pmc->old_end;
-	unsigned long new_addr = pmc->new_addr;
-
 	switch (entry) {
 	case HPAGE_PMD:
 	case NORMAL_PMD:
-		mask = PMD_MASK;
-		size = PMD_SIZE;
+		*mask = PMD_MASK;
+		*size = PMD_SIZE;
 		break;
 	case HPAGE_PUD:
 	case NORMAL_PUD:
-		mask = PUD_MASK;
-		size = PUD_SIZE;
+		*mask = PUD_MASK;
+		*size = PUD_SIZE;
 		break;
 	default:
 		BUILD_BUG();
 		break;
 	}
+}
+
+/* Same as get extent, only ignores new address.  */
+static unsigned long __get_old_extent(struct pagetable_move_control *pmc,
+		unsigned long mask, unsigned long size)
+{
+	unsigned long next, extent;
+	unsigned long old_addr = pmc->old_addr;
+	unsigned long old_end = pmc->old_end;
 
 	next = (old_addr + size) & mask;
 	/* even if next overflowed, extent below will be ok */
 	extent = next - old_addr;
 	if (extent > old_end - old_addr)
 		extent = old_end - old_addr;
+
+	return extent;
+}
+
+static unsigned long get_old_extent(enum pgt_entry entry,
+		struct pagetable_move_control *pmc)
+{
+	unsigned long mask, size;
+
+	__get_mask_size(entry, &mask, &size);
+	return __get_old_extent(pmc, mask, size);
+}
+
+/*
+ * Returns an extent of the corresponding size for the pgt_entry specified if
+ * valid. Else returns a smaller extent bounded by the end of the source and
+ * destination pgt_entry.
+ */
+static __always_inline unsigned long get_extent(enum pgt_entry entry,
+						struct pagetable_move_control *pmc)
+{
+	unsigned long next, extent, mask, size;
+	unsigned long new_addr = pmc->new_addr;
+
+	__get_mask_size(entry, &mask, &size);
+
+	extent = __get_old_extent(pmc, mask, size);
+
 	next = (new_addr + size) & mask;
 	if (extent > next - new_addr)
 		extent = next - new_addr;
@@ -787,15 +814,153 @@ static unsigned long pmc_progress(struct pagetable_move_control *pmc)
 	return old_addr < orig_old_addr ? 0 : old_addr - orig_old_addr;
 }
 
+/* Assumes folio lock is held. */
+static bool relocate_large_folio(struct pagetable_move_control *pmc,
+		unsigned long old_addr, unsigned long new_addr,
+		struct folio *folio, bool undo)
+{
+	pgoff_t new_index;
+	struct vm_area_struct *old = pmc->old;
+	struct vm_area_struct *new = pmc->new;
+
+	VM_WARN_ON_ONCE(!folio_test_locked(folio));
+
+	/* Impermissible. */
+	if (!folio_test_large(folio) || folio_test_ksm(folio) ||
+	    folio_test_large_maybe_mapped_shared(folio))
+		return false;
+
+	/* no-op. */
+	if (!folio_test_anon(folio))
+		return true;
+
+	if (!undo)
+		new_index = linear_page_index(new, new_addr);
+	else
+		new_index = linear_page_index(old, old_addr);
+
+	/* See comment in relocate_anon_pte(). */
+	folio_move_anon_rmap(folio, undo ? old : new);
+	WRITE_ONCE(folio->index, new_index);
+	return true;
+}
+
+static bool relocate_anon_pud(struct pagetable_move_control *pmc,
+		pud_t *pudp, bool undo)
+{
+	spinlock_t *ptl;
+	pud_t pud;
+	struct folio *folio;
+	struct page *page;
+	bool ret;
+	unsigned long old_addr = pmc->old_addr;
+	unsigned long new_addr = pmc->new_addr;
+
+	VM_WARN_ON(old_addr & ~HPAGE_PUD_MASK);
+	VM_WARN_ON(new_addr & ~HPAGE_PUD_MASK);
+
+	ptl = pud_trans_huge_lock(pudp, pmc->old);
+	if (!ptl)
+		return false;
+
+	pud = pudp_get(pudp);
+	if (!pud_present(pud)) {
+		ret = true;
+		goto out;
+	}
+	if (!pud_leaf(pud)) {
+		ret = false;
+		goto out;
+	}
+
+	page = pud_page(pud);
+	if (!page) {
+		ret = true;
+		goto out;
+	}
+
+	folio = page_folio(page);
+	folio_lock(folio);
+	ret = relocate_large_folio(pmc, old_addr, new_addr, folio, undo);
+	folio_unlock(folio);
+
+out:
+	spin_unlock(ptl);
+	return ret;
+}
+
+static bool relocate_anon_pmd(struct pagetable_move_control *pmc,
+		pmd_t *pmdp, bool undo)
+{
+	spinlock_t *ptl;
+	pmd_t pmd;
+	struct folio *folio;
+	bool ret;
+	unsigned long old_addr = pmc->old_addr;
+	unsigned long new_addr = pmc->new_addr;
+
+	VM_WARN_ON(old_addr & ~HPAGE_PMD_MASK);
+	VM_WARN_ON(new_addr & ~HPAGE_PMD_MASK);
+
+	ptl = pmd_trans_huge_lock(pmdp, pmc->old);
+	if (!ptl)
+		return false;
+
+	pmd = pmdp_get(pmdp);
+	if (!pmd_present(pmd)) {
+		ret = true;
+		goto out;
+	}
+	if (is_huge_zero_pmd(pmd)) {
+		ret = true;
+		goto out;
+	}
+	if (!pmd_leaf(pmd)) {
+		ret = false;
+		goto out;
+	}
+
+	folio = pmd_folio(pmd);
+	if (!folio) {
+		ret = true;
+		goto out;
+	}
+
+	folio_lock(folio);
+	ret = relocate_large_folio(pmc, old_addr, new_addr, folio, undo);
+	folio_unlock(folio);
+out:
+	spin_unlock(ptl);
+	return ret;
+}
+
+/*
+ * Is the THP discovered at old_addr fully spanned at both the old and new VMAs?
+ */
+static bool is_thp_fully_spanned(struct pagetable_move_control *pmc,
+				 unsigned long old_addr,
+				 size_t thp_size)
+{
+	unsigned long old_end = pmc->old_end;
+	unsigned long orig_old_addr = old_end - pmc->len_in;
+	unsigned long aligned_start = old_addr & ~(thp_size - 1);
+	unsigned long aligned_end = aligned_start + thp_size;
+
+	if (aligned_start < orig_old_addr || aligned_end > old_end)
+		return false;
+
+	return true;
+}
+
 /*
  * If the folio mapped at the specified pte entry can have its index and mapping
  * relocated, then do so.
  *
  * Returns the number of pages we have traversed, or 0 if the operation failed.
  */
-static unsigned long relocate_anon(struct pagetable_move_control *pmc,
-		unsigned long old_addr, unsigned long new_addr, pte_t pte,
-		bool undo)
+static unsigned long relocate_anon_pte(struct pagetable_move_control *pmc,
+		unsigned long old_addr, unsigned long new_addr,
+		pte_t pte, bool undo)
 {
 	struct page *page;
 	struct folio *folio;
@@ -818,12 +983,18 @@ static unsigned long relocate_anon(struct pagetable_move_control *pmc,
 	if (!folio_test_anon(folio) || folio_test_ksm(folio))
 		goto out;
 
-	/*
-	 * This should not happen as we explicitly disallow this, but check
-	 * anyway.
-	 */
+	/* If a split huge PMD, try to relocate all at once. */
 	if (folio_test_large(folio)) {
-		ret = 0;
+		size_t size = folio_size(folio);
+
+		if (is_thp_fully_spanned(pmc, old_addr, size) &&
+		    relocate_large_folio(pmc, old_addr, new_addr, folio, undo)) {
+			VM_WARN_ON_ONCE(old_addr & (size - 1));
+			ret = folio_nr_pages(folio);
+		} else {
+			ret = 0;
+		}
+
 		goto out;
 	}
 
@@ -886,7 +1057,6 @@ static bool relocate_anon_ptes(struct pagetable_move_control *pmc,
 		return false;
 
 	state.ptep = ptep_start;
-
 	for (; !pte_done(&state); pte_next(&state, nr_pages)) {
 		pte_t pte = ptep_get(state.ptep);
 
@@ -895,7 +1065,8 @@ static bool relocate_anon_ptes(struct pagetable_move_control *pmc,
 			continue;
 		}
 
-		nr_pages = relocate_anon(pmc, state.old_addr, state.new_addr, pte, undo);
+		nr_pages = relocate_anon_pte(pmc, state.old_addr,
+					     state.new_addr, pte, undo);
 		if (!nr_pages) {
 			ret = false;
 			goto out;
@@ -922,29 +1093,65 @@ static bool __relocate_anon_folios(struct pagetable_move_control *pmc, bool undo
 		pmd_t pmd;
 		pud_t pud;
 
-		extent = get_extent(NORMAL_PUD, pmc);
+		extent = get_old_extent(NORMAL_PUD, pmc);
 
 		pudp = get_old_pud(mm, pmc->old_addr);
 		if (!pudp)
 			continue;
 		pud = pudp_get(pudp);
+		if (pud_trans_huge(pud)) {
+			unsigned long old_addr = pmc->old_addr;
+
+			if (extent != HPAGE_PUD_SIZE ||
+			    !is_thp_fully_spanned(pmc, old_addr, HPAGE_PUD_SIZE))
+				return false;
+
+			VM_WARN_ON_ONCE(old_addr & ~HPAGE_PUD_MASK);
 
-		if (pud_trans_huge(pud) || pud_devmap(pud))
+			/* We may relocate iff the new address is aligned. */
+			if (!(pmc->new_addr & ~HPAGE_PUD_MASK)) {
+				if (!relocate_anon_pud(pmc, pudp, undo))
+					return false;
+				continue;
+			}
+
+			/* Otherwise, we split so we can do this with PTEs. */
+			split_huge_pud(pmc->old, pudp, old_addr);
+		}
+
+		if (pud_devmap(pud))
 			return false;
 
-		extent = get_extent(NORMAL_PMD, pmc);
+		extent = get_old_extent(NORMAL_PMD, pmc);
 		pmdp = get_old_pmd(mm, pmc->old_addr);
 		if (!pmdp)
 			continue;
 		pmd = pmdp_get(pmdp);
-
-		if (is_swap_pmd(pmd) || pmd_trans_huge(pmd) ||
-		    pmd_devmap(pmd))
-			return false;
-
 		if (pmd_none(pmd))
 			continue;
 
+		if (pmd_trans_huge(pmd)) {
+			unsigned long old_addr = pmc->old_addr;
+
+			if (extent != HPAGE_PMD_SIZE ||
+			    !is_thp_fully_spanned(pmc, old_addr, HPAGE_PMD_SIZE))
+				return false;
+
+			VM_WARN_ON_ONCE(old_addr & ~HPAGE_PMD_MASK);
+
+			/* We may relocate iff the new address is aligned. */
+			if (!(pmc->new_addr & ~HPAGE_PMD_MASK)) {
+				if (!relocate_anon_pmd(pmc, pmdp, undo))
+					return false;
+				continue;
+			}
+
+			/* Otherwise, we split so we can do this with PTEs. */
+			split_huge_pmd(pmc->old, pmdp, old_addr);
+		} else if (is_swap_pmd(pmd) || pmd_devmap(pmd)) {
+			return false;
+		}
+
 		if (!relocate_anon_ptes(pmc, extent, pmdp, undo))
 			return false;
 	}
-- 
2.48.1


