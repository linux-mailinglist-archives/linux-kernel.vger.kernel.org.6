Return-Path: <linux-kernel+bounces-201196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 532BA8FBAC7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082F928864F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9C014EC4A;
	Tue,  4 Jun 2024 17:42:49 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA7A14E2D6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522968; cv=fail; b=oFBqGF4fc1WSBWQSU0P59WqTUJGQZaKlKEBmxvxM1SD7YcNEK/P8Y1iJnSi49nEIDEeqDfWaQSJcbOvkk/MUzXJCK/OUy+2BeNkEkISXVq/HY4Bp2lJP1pnoZHIMF86P/z9ZkEgKSn5foOmR5kiLRlqbJImtMlqIM/ZH0uOye7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522968; c=relaxed/simple;
	bh=H9hUTn0iiv4Wx6kgm5qw3t79LsUP9/bEVVIGje6HMP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VHeawZWLqSp5ho85tWCqxBMefDN8buenBuWBBd3LvzcST4I14eziLK2t3hKxFxBou1GIIy9k+hflnrW91k++3gURPrEbBR6J9BHNWjxzgN5VWcpIsYPUWjijSX6QuOBPZKPT70IHItoNuyI0VoFCyphuzjyMNUmJDsfkgcvggAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454Bn0BI032321;
	Tue, 4 Jun 2024 17:42:29 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D0uxtuNjYvHMIW8wAN+0vAK8V7rBgN5K87NjJME5JiWY=3D;_b?=
 =?UTF-8?Q?=3DSuSDeCT6k4JxTRnAh7YZG19ZY5u98xhIPhe392kcyRogcz8oNHCgGZTO783M?=
 =?UTF-8?Q?zGzNPPc3_x7UsMe42V5rgvdOxkZLrRFtJxFr5LNEmKIJtS9fPjYz0yqsoNqyS8n?=
 =?UTF-8?Q?bpwg2au6Yyw5Be_gfkD7uavK52wcip5wzZi6gf0SSUANVNGeeC547lKTHE67tgh?=
 =?UTF-8?Q?oqy0BRmiRPalkAO3X8LY_LB2zyPnaM7jsxz+2YOohXAAVzrVUSkRJa7l9Ws8ZKz?=
 =?UTF-8?Q?AUhDW0vdXP/KfPQFo1JDYw//Eq_LDs8M3225KMU35pTwJFSlDJQchP8QdnXvLtY?=
 =?UTF-8?Q?Q1Xfqxpu10BN7U0sDJ/hleF2FIUb5P2n_9Q=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuyu5j6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HVuMC016217;
	Tue, 4 Jun 2024 17:42:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrsaf3bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejQ1k1KIl0LvQ+vGg/OA3JREpbN2oLRHEOoG/BnPnOypYA7XUd8dpoyFAPi1nwSkOqU6wiAET27LP8SNAW/Z7By5vNqxn8sH9T5Xc8lMikCD7kD5lyEs89122qVwC/tcLdfZoDscx+TYUxlF6I5ryA6K9VTBhAOBjgMJDzQuy0PY9S9qaCStYs4mKS0JEZ6GShRJjMy1jPOCzWtFtjXfwyFchcFjeX2dBi1iFMIq9WueFDK0oXsvyu0TqdznA+rDJFnusH1cRAHr8pqjgD70XusuY/jpAPu7cmIfiqhGS2ZJvbSwM5hJZJEe5nhW7WciyjB4QhWJ1cM/cX+NxbcWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uxtuNjYvHMIW8wAN+0vAK8V7rBgN5K87NjJME5JiWY=;
 b=UyPFarxfD+BvOcB4iJNjRYJY3CPDjq3nGgXzhC3GoBeYN2CheeKSWHnWEsfNuqN26z2NEzlcZD4mpLIwzRpby926xkF8BpiavEPCM/SAwRj96vTF1yl4njytn247vH8un027suvv+IQ1FFmOhmi+LQYx803ewGFRZG7FM8YgOJubMouYva0bYHrsMf2Szbm1PLeVGaADkVPZyslTYqfRVL0MHNnZV7ZvxyDs3qmedIMneoLzl36ud0YYgPGqbK1fQSpNbbbZynvvii8MjPSzJS5kqb41PMC3/qgDfC6ia8Ru8UjeHTktPFWW+L+IMDpkyAhQ0xQ2DZB6QIEJqsXtKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uxtuNjYvHMIW8wAN+0vAK8V7rBgN5K87NjJME5JiWY=;
 b=RBMDmi1KrKtLwLolYilKgkciEsUNgQ9D2lwqGJDkbfCtN0se22yha9+nm05qx2kxmx2g7bcWk6mMmnbOEiC3hoj8X3CeCC/8gUIY2rH3i6qIQM1sWs4P+Xdn/ADycbz1hjCRbIQMvvZEElkh9K+JzNOQ5JmoirZ/v3kYayCoSiU=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 4 Jun
 2024 17:42:26 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:42:26 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 16/18] maple_tree: remove node allocations from various write helper functions
Date: Tue,  4 Jun 2024 10:41:43 -0700
Message-ID: <20240604174145.563900-17-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0144.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::29) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH0PR10MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 8488f0fc-f35a-4911-06f9-08dc84bdb2aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?oK/OcY0NJ6d5ujnBIVNTzNIo22tuS5FIWAIZLJZwMqj7lIuuINspIl4nDzV8?=
 =?us-ascii?Q?MLQlL6ueBpb1okEa3sUSuXy19uCJJQtJprXjv0QuErIshbGq6mMbwQiEeVJL?=
 =?us-ascii?Q?8S+nXZ7XPMWWj1K8UkMjvDlgzNnzO4rME2cHffEjaPw1cM6zfKkTaIbQc0gT?=
 =?us-ascii?Q?Rfn9i2hry4DCaH3yeGKyLtsxdu4wu8ClRxEk11mXHYNjufUEQzNPrFGdTRR6?=
 =?us-ascii?Q?RlDq36I4IzGCDd8vNzPtIq/s6aE4uxBrIRYmN3pmNaNY3mDJbeaQzqxuXIe7?=
 =?us-ascii?Q?BJpND6quU+b5Rvnbvp6jaPK+6lKuCusxIPMQiEo8kl3wPyWxhI1CJPRQy/EZ?=
 =?us-ascii?Q?BHZLaOun7SCbCV3xxBgiJlPdNiuYwtfOWFdiZauksH4ApLswgyu79IFiD54T?=
 =?us-ascii?Q?gPdFcW0f+qedbCqwu8LUKQG2rqbN24v/MXG1EgPetc5hB+a4N3b/6mpYbQde?=
 =?us-ascii?Q?RLPGTAjFMyMEoZQqRps8+hMOkIWAk+L0GSZGwUZ+YfCksjy8tJ4Eup2wHwz4?=
 =?us-ascii?Q?sWq6m+jLcbQCq+hYIP4i79WQ8mf+xxz/bVicjA0nj0KGDyoP5KueYFI27ms8?=
 =?us-ascii?Q?lBFnCGEbakgrG5Rbfn4x31ax2Zgney5QN+6oayc6n1Bnoa2kSWpTli/FT6jf?=
 =?us-ascii?Q?SSEG4FV/f1W+rE5LYuIXh3TjqgfMoTAo6uQTSWFFFzAW1xWbdGEhZz2OaGDP?=
 =?us-ascii?Q?it1RIUCLrBCqfjXWIpqmhErzKwJgWAtC1bVyydP4BxrcpR4mOHUVZCjACMfJ?=
 =?us-ascii?Q?HESKkn++iodtAv7Bu55G9attLD0yy/rjLitdabQlFzDjNhKfxMJAIC8Gik/c?=
 =?us-ascii?Q?amV9DcBuoIMPA1R5EpV5slKfa/AoqkToOMqJSIHEzN4ex6ao0nPjrPSCsPHr?=
 =?us-ascii?Q?zWvwDgqB0Z9LKDQAPVO0x9OB9IyP5XYV6deHetd284yLk/WPW87OSPUIkLEo?=
 =?us-ascii?Q?7UMqfPX1hE3J+QEKv9K7PwbuBiK4nznfeAH+hAbDmleKTAXQPZqgbwR1sN67?=
 =?us-ascii?Q?7eEjnfRIxv2fEuYMMAyXTq4tYiOkAmD7HAEM/bI8bKETOkai8FAuyD2oNJO+?=
 =?us-ascii?Q?IHAyae+rmi2dGvqHYepkXNheoEf0Oz20fFAiVr6Fe5EyxLlcILvVX/fMwSsf?=
 =?us-ascii?Q?BL0aiOaSQtSkZnb/1bKmpXREBD6+OR6j3BtuzUKuTbd8wRC98nNaJlxHBCZy?=
 =?us-ascii?Q?cJHmiHEk0erbEmzogm+Oxl5z35Tr2CI/mvYAYfg6n+yoF7n7JxCxKrkFtNq1?=
 =?us-ascii?Q?WL+Thqm8gMmz4AtO5GwpVA5xhpGGc7/zDv+j50lyF5NBJ2OmE4l4cJUakAm9?=
 =?us-ascii?Q?8ncEEfzjPBJ/A/5OjQEYFJgG?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BXcOFhxRzYF5/v1cbW0Kp9kHw9VvjKp4zwSPLwnAZdXMB8YCivdIFluCKX63?=
 =?us-ascii?Q?aTGEDWSPjctkWm3HB9rurfmRRQ4OY91zkRIUa8WuALX/4ajkWEIimz2OAfxT?=
 =?us-ascii?Q?gJJ2e32cSe3S/KYEuGsaxfnz77EiaaClpBdyDakhNQCInMlIzcd6MG0j4fOf?=
 =?us-ascii?Q?NBPsT3Ce8d9/S6KdHssrJmlUcDz4yFn4tKJe/CQwptmZEfHSMvQYwh6U7qFe?=
 =?us-ascii?Q?ayxdJX9BkSbJU5ut2B+Gbez8EDVUuRRMo+nLHal1ZOHdQu596O7ectXVnTBX?=
 =?us-ascii?Q?IWbXm1JVfaHufGP3slGlgjzbRvWEFbTBPu07IGU2PBu4DK6dktNBL2+xKLQ+?=
 =?us-ascii?Q?EZergsvbTKIU8YTjqddaQXScZ2iSk3Qqc4irvaSrU9RD50ObEzVqdzP1CX0v?=
 =?us-ascii?Q?xkyzj068TeTxJfCM6fBi/PXXL0dNtfVGZXHpPPLZU9mhynqMrnF7Zt5C0Qsm?=
 =?us-ascii?Q?PXf/LeZNTHy7KGUy6dOBSMxpj7EXdTLtGixWrPj2+mkLz2OF1XmcaVZutSwt?=
 =?us-ascii?Q?H9w6yFjR3LyepG/MuiX5ILz4eVdSBVuAD9K3VaFcYHLn5p0wO8CaV0sYUt48?=
 =?us-ascii?Q?U7fXDb6OMggkYpbv5EmbYCCZuKPCd0Kv5YYc3/rPTiskML5b5rqWrc0K+WJ0?=
 =?us-ascii?Q?CHZHWjL9E5H3Omc+Szkf7biKXcFV6az8dq9D/majh5e20rHJXnmvXpS4dKx0?=
 =?us-ascii?Q?wz9a/RCK18xDBsMJhz+wtlHPNFq8/jGQsrGKT9zFlXzH6/Nls6sicRvumgDz?=
 =?us-ascii?Q?/9O5sS/UIrVbCPpCY6CsmdVG/hOEjE0lFrI1t8o5z+b6ApEtL8Akl09OxsdT?=
 =?us-ascii?Q?gLGXTFB3SXn1y3Y+WQAqFm0PasDGvpSa3MjHmCN00hFWAW+Ifaa/faEuPoEC?=
 =?us-ascii?Q?r3xRiju5Isv2ZGgM5bOKMmqnStDh4qS/sGXi301exzHlskXhpc632X3i4dHI?=
 =?us-ascii?Q?niL/x9ch86anrC3CUcak/Ycs6yVheKVXk8iX7nCfyKr2ykzkYDxRk6G6aXok?=
 =?us-ascii?Q?HioOQ35aI9eoA/3vlHURkCqY/H2u0V+lEQzsMWob/LqkSfKMEn1+LOQi6pgA?=
 =?us-ascii?Q?rzebwbdepr946X7N+MjCuONJn9q2KILFGLq4ZCqt+ykVPs+sWcJOJuh5nfHe?=
 =?us-ascii?Q?XMuEmU04+j/gSl1PxKBlYmxO+nLtibchPtCpladduP35aGq4rkysoBm2q+NY?=
 =?us-ascii?Q?wKA8C6WzDgcHAjJgHi4F0VINbv37NPFc6Rd9pMqSWHL8XUroj2iMlaLNOHkp?=
 =?us-ascii?Q?UJ1roHAtoKr2l9XEmzgyeJWTjwbgdYGofpuyiVDNzWJSTdOrA7At/ri0KsuY?=
 =?us-ascii?Q?CQiFhsb52sdU25UvXZqC/RMdTdBZ/EeQGY/0qPdJH665/gjDIztKZGh9Drgp?=
 =?us-ascii?Q?7TBbwG1j8kpSJbopZViWqUYs0M4tdBQWA76ciASssR1O6LsFHqCOj2/IkkCl?=
 =?us-ascii?Q?hga4w5MAIzt+AKmrt7Nv7eJOjG+6WvXsyFMqpnxJDkDPqIibK4Bw8yo5jj3/?=
 =?us-ascii?Q?2reIUSgx0y5Khja4y4aE297XKoUQ/b74IEH+cSX5tlHLqc4Y3wnjG03MSQTx?=
 =?us-ascii?Q?lmZe7OUzXEsd+/MP5vZxJ7PK600vCu0Vb2ol+IGjgI1V9vTcBkLhAH1v2smb?=
 =?us-ascii?Q?eC5EozJUw5HVGm5qpJdy//E=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SvjC0emdopi8UgS/Izqw9Jy1k9GcC+7sZV6U+12VGRUBORNsXNLSPHmjiLAaMg9q4cYlgiBQxj+sLCP2yO8gSLgBmBhhrPTCPJEzUSnz2wbQy77yWJnxYYMZjrNAtac6zheueJLYSRlHBtaZX7sUcvJAg4p+i7PhOjcuOyntMd4bIvWILg9KRM/p2XvMZbHz0Gqj19G/F9Ds4rMVlit0RJs3BTAGdKvUclggsoD18r2W3lFNvtF0xIGTDvPn6FwKQPqhnrMK35mNd2eIxYlTXv2spO/2/jnCme0F9tMI0LPcuJPvpw0L7FPYhetwBtnNCrjOM+BP7KGdp3ua26EoF4aL3w4NkvKvHinZxh94ww9aPkftVkeZ0v5idM5lEL+pReHWCOEo6zce8aAL4iZwBLLMIkcCwLlXSHgAcWdVr2oruJbSlidhfdfjjpN+VegU+R1MFPiQ3eZNMMPNhhljrGQgU16gtzNlbymciJgqzhVT6gVY0xn0n565QIOtmAjZT3blQBwStvKwQ7KkbXVAP8UsmfNqP1cVndDWZj1h4MuyMj9AFpEL5jGVY2rAJGXcau6YQENOgyGZGE3iunyC6mvBSFlocRePMKjN3o45DWQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8488f0fc-f35a-4911-06f9-08dc84bdb2aa
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:42:26.2483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEoo2PFgHYUssV8ayh73BYLJ0CA60xpLE1OGAtK1AV2WjyAD/YBbE8iiKBfoGcHX+s/Vkau1pBLxdGxO71Z36c6JXol/dyqLz/o5TSUkSyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040142
X-Proofpoint-GUID: mfb-EawXCMblJdKVNmvf0rl_1vmYtDiL
X-Proofpoint-ORIG-GUID: mfb-EawXCMblJdKVNmvf0rl_1vmYtDiL

These write helper functions are all called from store paths which
preallocate enough nodes that will be needed for the write. There is no
more need to allocate within the functions themselves.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 42853afc3885..3d2d8c2c24df 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2976,9 +2976,6 @@ static inline int mas_rebalance(struct ma_state *mas,
 	 * tries to combine the data in the same way.  If one node contains the
 	 * entire range of the tree, then that node is used as a new root node.
 	 */
-	mas_node_count(mas, empty_count * 2 - 1);
-	if (mas_is_err(mas))
-		return 0;
 
 	mast.orig_l = &l_mas;
 	mast.orig_r = &r_mas;
@@ -3029,11 +3026,6 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
 
 	/* set up node. */
 	if (in_rcu) {
-		/* Allocate for both left and right as well as parent. */
-		mas_node_count(mas, 3);
-		if (mas_is_err(mas))
-			return;
-
 		newnode = mas_pop_node(mas);
 	} else {
 		newnode = &reuse;
@@ -3341,10 +3333,6 @@ static int mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 
 	trace_ma_op(__func__, mas);
 	mas->depth = mas_mt_height(mas);
-	/* Allocation failures will happen early. */
-	mas_node_count(mas, 1 + mas->depth * 2);
-	if (mas_is_err(mas))
-		return 0;
 
 	mast.l = &l_mas;
 	mast.r = &r_mas;
@@ -3446,10 +3434,6 @@ static noinline_for_kasan int mas_commit_b_node(struct ma_wr_state *wr_mas,
 	if (mas_reuse_node(wr_mas, b_node, end))
 		goto reuse_node;
 
-	mas_node_count(wr_mas->mas, 1);
-	if (mas_is_err(wr_mas->mas))
-		return 0;
-
 	node = mas_pop_node(wr_mas->mas);
 	node->parent = mas_mn(wr_mas->mas)->parent;
 	wr_mas->mas->node = mt_mk_node(node, b_type);
@@ -3475,10 +3459,6 @@ static inline int mas_root_expand(struct ma_state *mas, void *entry)
 	unsigned long *pivots;
 	int slot = 0;
 
-	mas_node_count(mas, 1);
-	if (unlikely(mas_is_err(mas)))
-		return 0;
-
 	node = mas_pop_node(mas);
 	pivots = ma_pivots(node, type);
 	slots = ma_slots(node, type);
@@ -3747,10 +3727,6 @@ static inline int mas_new_root(struct ma_state *mas, void *entry)
 		goto done;
 	}
 
-	mas_node_count(mas, 1);
-	if (mas_is_err(mas))
-		return 0;
-
 	node = mas_pop_node(mas);
 	pivots = ma_pivots(node, type);
 	slots = ma_slots(node, type);
@@ -3813,9 +3789,6 @@ static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	 * entries per level plus a new root.
 	 */
 	height = mas_mt_height(mas);
-	mas_node_count(mas, 1 + height * 3);
-	if (mas_is_err(mas))
-		return 0;
 
 	/*
 	 * Set up right side.  Need to get to the next offset after the spanning
@@ -3899,10 +3872,6 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
 
 	/* set up node. */
 	if (in_rcu) {
-		mas_node_count(mas, 1);
-		if (mas_is_err(mas))
-			return false;
-
 		newnode = mas_pop_node(mas);
 	} else {
 		memset(&reuse, 0, sizeof(struct maple_node));
-- 
2.45.1


