Return-Path: <linux-kernel+bounces-308014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A5396561E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1C0DB215F4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D90C1537BE;
	Fri, 30 Aug 2024 04:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ko/UW/6V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nSjg6gPb"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E2C1509AE
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990507; cv=fail; b=ByoRou4BKMffZgQpgBmdkj16AXGLHTcaGT6eETSA7iCp+tix5ErVEJ+lQ5epL7yfq4wTUThMFIfY7YtV6oEGK3aVVErflStjpy0uO7KJpxCzPB9JueCMND9qUVYUFdH7hzbMNY+t6B3UdP1cWsuMsfQoULWQxn7ja4/VkmISiac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990507; c=relaxed/simple;
	bh=GoiOTA7WVOopV+4y+OAv1a9H4neQ8gmMA1xSLweKQHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VXZErYQrZMSYzkFnRvh2AlgPOvvlesNThEjN4O2glL16FlGT9Mob4mv+8v41sMQIKRUeSRxw9rEABNqNkrhFSG46WAvdHhIrPexSZob64uHUVjBBVFzCAW1itHgGVP6Y8YsEBOcqxAIi16ACLekUd3T1FHs2OcKTCZfcopngVds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ko/UW/6V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nSjg6gPb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U3LAZi021755;
	Fri, 30 Aug 2024 04:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=U2YvcKwGePCmxbcIx/fyjPP4qSdkHYCXwCKrh6Jw9fk=; b=
	Ko/UW/6VpgrfGTy0RBnPr2Cn16neC5oudnKBMmyFnK/YpnyY5csQ1atfkOso9LT5
	efS0e5XSUfOfnMBt814l3Em8unjlqmI2C2uXdHpsWhffWomx1ShP5TU/WZ/RKBa6
	aLTwrWxyTvVUdKBhU8DyycTsP5SIjIC5sJXP0CRngqi5r8cCQ4HkSncLgv6v8kea
	5keEztCLgIGXICqG+KTNFr2cMV4DZhZkZqehDRnsY6TI13w864RhYPBBegQCYKmZ
	Ce8/UAIcrMoNvnN2hsuUfJ4E4aOFEv2dUfp3fKRjK7VXduxh9X3ttQXx9onQQVyz
	HJXUislrJYBHF+7of9y72Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b3myr582-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U3jJaL036502;
	Fri, 30 Aug 2024 04:01:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jp2swm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbcP5asReJOpeZ032lgN084joZ6FpJSrQjwhhnIfQeF1Kd4szUaoLPsmeGBKHb9lEPAH04DFUvDwC48rOYoaDdjoPv6Vd3xrR25/TQBPrx147oJURMk70YQ80uS0hER9HKGgO2v5HU5yfZybX5kYx3UPXCNNUHVOiWTWBpEyi5v3Ujxydk2w1dlKD8arhUlH/nbXEoJi7yXdzmqhqqwHalp+dlaIORxa8rBRIYXoHnj2zBCqi8n527+2tHsNGDPx8GACiNW90lwxuybRWDnntua1+EaDV7C+rKPyDjkuRO02Q00ZP7jSSrltgvl5Si5WF/XjjKQbjSoJ/6TeVKzsUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2YvcKwGePCmxbcIx/fyjPP4qSdkHYCXwCKrh6Jw9fk=;
 b=nTnix203VT9VVKwKxVySvDUoAoy/BPp8iyn0JHCURKdRkiiVG6wRjzusFK1gEWp/brXgvsYPXub9LAnJdqBY3HijI46ixlAMJ1lZtiz7/khtnfd4F9Y8B4UH0MMLaAKOx3qKcOnTvWrJOv9uhpIDEfm3cJMiAgSJ1jQgl/k7GEZ3QyIGhECNy48a9hfWdUi4QHIJAKnA0GYu6DwFzT2l5Cxv31xEVWHYetoNUvtA4u2jLv4dW7ueBHb2TjULr5RyV/UrVFufpEblGjc1XKQa76xICXMfb1svAxAVo2KtRIOusSid5Ic8pYDlwysydF9QWnYUbokvE9Eh0JjZop1wFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2YvcKwGePCmxbcIx/fyjPP4qSdkHYCXwCKrh6Jw9fk=;
 b=nSjg6gPbll0zN4Xx5a1qUtxnVp32vZFeUZDsJG/gkdw+R2hAQPxLRFCwv9Aqr9ztWLqbNkdKWD4zBjFeYENweceDcJX5Vw8foDmG9ztbSXA1n6qKj598/PYJXGwKS8jgfk3LXtX2xIMnBr2qdOKJCpPgGzcuTqfoGoN7uC6Ol74=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CYXPR10MB7949.namprd10.prod.outlook.com (2603:10b6:930:e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 04:01:17 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:01:17 +0000
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
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v8 05/21] mm/vma: Introduce vma_munmap_struct for use in munmap operations
Date: Fri, 30 Aug 2024 00:00:45 -0400
Message-ID: <20240830040101.822209-6-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830040101.822209-1-Liam.Howlett@oracle.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CYXPR10MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: f251c220-45db-49a0-583e-08dcc8a86646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5L4g0gx/TkS1IxSXmI4czmvnewFasMREi+OmruuknktiaH8sc1rxyZ46mUuz?=
 =?us-ascii?Q?yvQ7513iXYuvZgxNBBwzIqkPLl8KPgZEzYUtfmzeOXHRx6KjdvXguJDl7SR9?=
 =?us-ascii?Q?kJwoha3CbdxCeIquGJUMbRP1vpRZtujeGW9D66rNrmDxdqCXjN2dHUUOORXG?=
 =?us-ascii?Q?5p8flkAR3RsRWuTNAgrn4W1tTS+PQ6ZL1JwPo/X4MhY0CLts0KUce6Q3ubG7?=
 =?us-ascii?Q?u4EbmxkHr7bx/zi0ToFJXFKb8DXxy/amvRlEgmlkOqClTYWRPo8oI6OZ0R28?=
 =?us-ascii?Q?1BiLVm4bGqX/oHBCMirbWLLUib9aaxOfDJ9mkJKebo4C9KFbYqf8Ap/T1NBQ?=
 =?us-ascii?Q?YIBCUZ/VN8nrqUXY0wl9uzHDJCu9Y0Ui0XYWUBKEFx6ubUzoen9vMlvri6sm?=
 =?us-ascii?Q?tDAAXsnyUeh9uaFz9MnjCM68myWreuivqnYTzV3ljMKC9dLn3CoqY+u7qv+r?=
 =?us-ascii?Q?0DaqfNHdwAy39RvHXlh//Z1oFXZnqYLMqnV2Gh0MP1FBbJDzePsDaNccBtCL?=
 =?us-ascii?Q?cBRe9bhPCvKFHGMAHOMF3hnX7VAr3lzhrkRygL7d0QPsJPlpNXAb1D1WhaeI?=
 =?us-ascii?Q?ux9QkYAYSA2Imj067Nkqw62We+EdrBi+icqSg9dau5aCYLiYzjkohhpBBkMo?=
 =?us-ascii?Q?g6Vnb+bouUToC3Qmo8bOpcLe7e7f4tcnkRYRa5fSD3uB/macVRB5IvXb0eis?=
 =?us-ascii?Q?IIbU3YdCUOW+IBi5E+R9m54Fv5oMR/JwwyKCiVE7FmOjpXIL5EQ/gCzd52fp?=
 =?us-ascii?Q?X34LtzpAASoRIX+6K3opobLT3lC0ODi+p1OuRgnC6QxGAzIYykbqe47PnM5k?=
 =?us-ascii?Q?5kCiD015dzW5pFjBRJo86tTS1f5vwMQr5pkei+C5ozXdrE+aK+uSmqeGL3ra?=
 =?us-ascii?Q?LRGXNSHnw/LJIJLZHc82oKYl4BXhIvlB28L+pV59wp+veBIWYZmDZbUssex3?=
 =?us-ascii?Q?UXkidc4kbq8m2WyVgrGdVWvVMKSatwrxdI4DEfL/XHGyROSwFd86lpKvcfzk?=
 =?us-ascii?Q?K3aGWo1cXvUJwLzfVFCUb8mi1T1S5dvFtQlDSnfRVpOUM2bOaUJoZyWiqc6q?=
 =?us-ascii?Q?6edc0+6R25TWvD46x7YH8eIbwPIt+CLappbzy3OmBkVh99tj4PlKSvL+1uzB?=
 =?us-ascii?Q?cI4zshHjcZbeLRiCsb461zg3ZEF7OghW8Sxa6WAmombZt/9Fz0dTMf0vcakU?=
 =?us-ascii?Q?E8b5PtZWEKyJ9vTO748LCNldslmpDQGQuU6bgTwbioJNePPGG6M7DgZAwGWN?=
 =?us-ascii?Q?Dy70E+srNYLI4vo9y15CaQCTFEvuCnIc3Rt5YnSMizx8fwDD1anzhXiVYhpn?=
 =?us-ascii?Q?yVZpBoZYVk8gyxnOLRmvdSTZDvUoY8UDpk+mZPEAD6nhQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yqmThh2VpgfCMg2JmYgzuXahXt9HQLSDgY5OPy3+pRF6CruG+B/MzWr6psqm?=
 =?us-ascii?Q?cNvUCtVU3Be5rFYWfQ1Ay8xHipSjxT6R5sjS4jHFI1ucXxozy9UQ3F7SSgYj?=
 =?us-ascii?Q?Fd55cY+Q2OfNr1QgZDpHtZSB0uxnI40Ql6F/3MW8L5Z3Yy1SjVLB1T+yjbRC?=
 =?us-ascii?Q?QLVchrQlGuLGvsdxpqzqcHlEv9pLbiYziZY1kDNtOSDi1x/xIeIEGyviLryo?=
 =?us-ascii?Q?3UABK2yC2WhmGLyY64EaPWy1Xdpub+j1N4INZPDECPzP8+6oFGpyhW+vlhqF?=
 =?us-ascii?Q?IZ1eKF63zJOoV0QBtm2JoNvrww1zVwiTyw9m286CyIrqSCzLswKxqcrlFg3E?=
 =?us-ascii?Q?aGMtb9oJO69vXJ4oKsrHVNqioWkFt57m/AhmH8D4HTsB6gUSZo6YII88mA0u?=
 =?us-ascii?Q?D0iAvs9YkbQUg4xCvmjA1Bn3PPULQAzZ2PuRB/co+aM30CaxjQCkPLJ+2pEm?=
 =?us-ascii?Q?EdG3F0NGEiXKAhpDz67weQ6hhn4bSOplDJB9PmCvuFv8bWHScsJhs9iaEWTz?=
 =?us-ascii?Q?xM68fVk1utRhUK/CsiDCb32V9GMlzUSEFd073LnP/fY31YCAa2JlLIEdHpPO?=
 =?us-ascii?Q?hbunp1FU9E9K33VsZtuimFqD2XwgUl1hpWcT7uWFoU3WqYGekQM6GYS37wEn?=
 =?us-ascii?Q?rcxCICnvCerd0MSpQna4tG8tvg6n51yYJcbqEMrZC3J4p6Iz9e57exnvFT+5?=
 =?us-ascii?Q?Y9HdFLeJ41aD8amslxNT8FeDXNWjmcpOpOlIxCHpjsqVAyuGPnPz88118LGc?=
 =?us-ascii?Q?dNJvf0dTuk1gg8IhgfgOv8lzjh21/iis1q4/jOZJ9ogeipkUP1+LCMDt+BpQ?=
 =?us-ascii?Q?k4w3K2thNau9fIyR83m5xs74P8Yy2uwrW9j+/9khxBSU0fipoEA2sdK+D8mA?=
 =?us-ascii?Q?ZyQip/hoFoHgbP6UxU5mZvk/KfUPsq7FsOoBtQOX/WaNxDvrPgqMMicS7wSa?=
 =?us-ascii?Q?Lvfom+zSLhWtGdW93aqBMjfqr4pAN9GgNImOgNvUuKgz9jR4CrPZ7VfBlii9?=
 =?us-ascii?Q?86X95h5RiNRUcrqc+hwTaJZp7RBDCIdQhE0nIgsjyNoi1mfF+Os+maplaRL8?=
 =?us-ascii?Q?25sxagP/vMpzMtniuCmlicJWXdzeIf+P7Iqm5JWpsIovizgRSmSEjltPCKlO?=
 =?us-ascii?Q?ZKK4M7THEudzbQl+1iAoYp8932gXGEiXzklH7W88rOk4IaT7KSd+B9PTN8Jv?=
 =?us-ascii?Q?BoU/+BXr1eF+keSVZT9FFytvsAr+Kv7zapjkeqRlVh47Qao963AmiIhXWsSe?=
 =?us-ascii?Q?JWmcVwJ7veJPhMas/mO0z+5nJgY0e2Uuio5QY8viSIAhfOyTHLf86mk3MjPK?=
 =?us-ascii?Q?DIMIxpLQpCLS3+zfpM9ms3cPmxG5MVgxVDlrFBX0dJCIIv+wk7T4/YCXhiki?=
 =?us-ascii?Q?MyOrxo+fnf7AfHaEJAftj3Mm6nJGMusdDTphx+S6YxJPnvhTPksLs75Iyc4X?=
 =?us-ascii?Q?v2ZrDngafNJqaFZ6KNKXCfATgi/dnJTFGoxA7sJyhQoRbt4AAURcIGO5UMdh?=
 =?us-ascii?Q?DOO0RzgYZL+pTIenSXgjiZIlRqKH2VBD86rsoPEar3NACDXrerAFCjoJMFxa?=
 =?us-ascii?Q?GJ4LUWpM7DSBPNQRxLVyIbVd1mdAHbxIQwoTD47p?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hukItWkbqsXc6w1YiD6Eye5ag70SlU7YdkaC1+28yq2lwVwZ1qQSfwtGQZaGgYLzNnCUfOhirWmWVD9aEiHOqCtUBqqa8pym//HxCySJnriS8S0AhNW81g6KqOOhvWebUKYk2MMyT1kqrqj/dbqiTi6zWDVpkqx8kOC0BTRkAa2XG+yEmei6IC/MXIdQefGj+cSWUUfER0o3KnulBB9eH79nYfQBufcDhXvn/s3SUm5NqymN67WonGoLQ8hb/y4UqmJy8RQOqkCpCWP7uAa6EJJW72DCEot3UqjpzQ/OIF2u7BTH+mPKpdA1j7+dDRYz+DliUIHqb4e/wJX5Y5Ph01BnyQfMFbhYTMMoPn1h+eEs/i+emV4jHizpfzuvcXlBHhaiE2gDoelRRbMrTl98kWyi63lEAbG6EXKvVsIFfM+wkEF5uSnbaPpadPuw6aHFWLwZPfEmcm2hPx5MjxyVguKSlfC0gkU6z5CbC2q7OxS4xt1TWzXelHsFWPIhC8T36UoipiX45P2tLS+oczhvzSQTjU/zlGoAO11+8LeBrdRY1PzQwgtxO8iEkS9Yvvkxdsb5fRF0n+WRUumc6ZB3h/BPv1ZqTHUAaZTSDUmnxNQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f251c220-45db-49a0-583e-08dcc8a86646
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:01:17.7382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhBvNQLSm+4QFz4jpUAJVR8jl88NqNHL9rGYTbRnhQbCg9so3LIqucH2sP635Tz9ck14CuVjFUhvSDMdyMs9dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300028
X-Proofpoint-GUID: 0Iy5k441AOmygkUK8-kHZhCA-bCtgAIJ
X-Proofpoint-ORIG-GUID: 0Iy5k441AOmygkUK8-kHZhCA-bCtgAIJ

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use a structure to pass along all the necessary information and counters
involved in removing vmas from the mm_struct.

Update vmi_ function names to vms_ to indicate the first argument
type change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 140 +++++++++++++++++++++++++++++--------------------------
 mm/vma.h |  16 +++++++
 2 files changed, 90 insertions(+), 66 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index f691c1db5b12..f24b52a87458 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -80,6 +80,32 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
 
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
+
 /*
  * Return true if we can merge this (vm_flags,anon_vma,file,vm_pgoff)
  * in front of (at a lower virtual address and file offset than) the vma.
@@ -685,81 +711,62 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 }
 
 /*
- * vmi_complete_munmap_vmas() - Finish the munmap() operation
- * @vmi: The vma iterator
- * @vma: The first vma to be munmapped
- * @mm: The mm struct
- * @start: The start address
- * @end: The end address
- * @unlock: Unlock the mm or not
- * @mas_detach: them maple state of the detached vma maple tree
- * @locked_vm: The locked_vm count in the detached vmas
+ * vms_complete_munmap_vmas() - Finish the munmap() operation
+ * @vms: The vma munmap struct
+ * @mas_detach: The maple state of the detached vmas
  *
- * This function updates the mm_struct, unmaps the region, frees the resources
+ * This updates the mm_struct, unmaps the region, frees the resources
  * used for the munmap() and may downgrade the lock - if requested.  Everything
  * needed to be done once the vma maple tree is updated.
  */
-static void
-vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		struct mm_struct *mm, unsigned long start, unsigned long end,
-		bool unlock, struct ma_state *mas_detach,
-		unsigned long locked_vm)
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
- * @locked_vm: a pointer to store the VM_LOCKED pages count.
  *
  * Return: 0 on success, -EPERM on mseal vmas, -ENOMEM otherwise
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
@@ -771,23 +778,24 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
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
 
 		/* Don't bother splitting the VMA if we can't unmap it anyway */
-		if (!can_modify_vma(vma)) {
+		if (!can_modify_vma(vms->vma)) {
 			error = -EPERM;
 			goto start_split_failed;
 		}
 
-		if (__split_vma(vmi, vma, start, 1))
+		if (__split_vma(vms->vmi, vms->vma, vms->start, 1))
 			goto start_split_failed;
 	}
 
@@ -795,7 +803,7 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	next = vma;
+	next = vms->vma;
 	do {
 		if (!can_modify_vma(next)) {
 			error = -EPERM;
@@ -803,20 +811,20 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		}
 
 		/* Does it split the end? */
-		if (next->vm_end > end) {
-			if (__split_vma(vmi, next, end, 0))
+		if (next->vm_end > vms->end) {
+			if (__split_vma(vms->vmi, next, vms->end, 0))
 				goto end_split_failed;
 		}
 		vma_start_write(next);
-		mas_set(mas_detach, count++);
+		mas_set(mas_detach, vms->vma_count++);
 		if (mas_store_gfp(mas_detach, next, GFP_KERNEL))
 			goto munmap_gather_failed;
 
 		vma_mark_detached(next, true);
 		if (next->vm_flags & VM_LOCKED)
-			*locked_vm += vma_pages(next);
+			vms->locked_vm += vma_pages(next);
 
-		if (unlikely(uf)) {
+		if (unlikely(vms->uf)) {
 			/*
 			 * If userfaultfd_unmap_prep returns an error the vmas
 			 * will remain split, but userland will get a
@@ -826,14 +834,15 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			 * split, despite we could. This is unlikely enough
 			 * failure that it's not worth optimizing it for.
 			 */
-			if (userfaultfd_unmap_prep(next, start, end, uf))
+			if (userfaultfd_unmap_prep(next, vms->start, vms->end,
+						   vms->uf))
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
@@ -842,21 +851,21 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
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
 
@@ -892,11 +901,11 @@ int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
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
 
@@ -905,8 +914,7 @@ int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto clear_tree_failed;
 
 	/* Point of no return */
-	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
-				 locked_vm);
+	vms_complete_munmap_vmas(&vms, &mas_detach);
 	return 0;
 
 clear_tree_failed:
diff --git a/mm/vma.h b/mm/vma.h
index da31d0f62157..cb67acf59012 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -26,6 +26,22 @@ struct unlink_vma_file_batch {
 	struct vm_area_struct *vmas[8];
 };
 
+/*
+ * vma munmap operation
+ */
+struct vma_munmap_struct {
+	struct vma_iterator *vmi;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;     /* The first vma to munmap */
+	struct list_head *uf;           /* Userfaultfd list_head */
+	unsigned long start;            /* Aligned start addr (inclusive) */
+	unsigned long end;              /* Aligned end addr (exclusive) */
+	int vma_count;                  /* Number of vmas that will be removed */
+	unsigned long nr_pages;         /* Number of pages being removed */
+	unsigned long locked_vm;        /* Number of locked pages */
+	bool unlock;                    /* Unlock after the munmap */
+};
+
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
 void validate_mm(struct mm_struct *mm);
 #else
-- 
2.43.0


