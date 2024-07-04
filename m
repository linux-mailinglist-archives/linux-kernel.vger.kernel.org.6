Return-Path: <linux-kernel+bounces-241605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEB9927D09
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729D2287853
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3665143887;
	Thu,  4 Jul 2024 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CapaBp4N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="guve+6pW"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8AE14386C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117694; cv=fail; b=RpYR2RgOBi+maEsNxZO7F0CkUTL59fTmNEAGjS+ueAcP8XWyOwuDccEH7o2ILgM/DByg1LKd9j2i78m7rYsECN0P2MkluR8fVwEFC/eVK07yZ6qzrpEcJcBQfkUG0pF5yRtHXluv1U4fPlbfCJF657S0/TECSzwrElqVbo5/XTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117694; c=relaxed/simple;
	bh=xA3dNpPZAw+JpZraipDp0YWv+VivFlQj5zO8Wc4KM/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cQWATQdkotPXmcigVeuREd8no6ilUOTvPG6HmYvvC/wgzwZXvwrTJTYS7OLXPG82zPzT4JMvDbm9QbFYJTd7u74ScVNhk9r1ugEpULPZbR/z2mlXLqy71tLVRcn/cMtFdayDRYLdT8Abeakwb6NSU71BqT99ZxPOGzwFGxtYHkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CapaBp4N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=guve+6pW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464DNuh3031095;
	Thu, 4 Jul 2024 18:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=iJMd2qwdMvbAWEntWtILy35IFR9pga/f4uv1MeD4ONY=; b=
	CapaBp4Nf7EGZUSTfvZD0RrslQkJD+PJMbUlG7nFGzxrEOE4VIcxwbhfkFa/8AZM
	eyXfO2zXiwxZihWEKZdjbs4e/dooY3cZKpQKh5k/6ssfxsZ/W+Gf6iP2eKbKIJxB
	iWhwTMLKdai0JtcMRo+TDX0e0fyB41r0F7P9vOoNDjmNY8+s+5Y+D5SmgWWC9sPp
	JYQX/IQbdgYTEN8zfSwU1iPn967xROL1WjxX/Z/XeCZkbwesIKpksTve+QkqjJwQ
	VB/9RHHkCZEo+TUQbRPpiXUfn2tviBFWRtkP83r/DHJ6FIGZKVtUfKoXXD3Ja3aG
	lqaIaqDBwS8GVp2h7Y4kSQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402aacjt0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464IBWLL023488;
	Thu, 4 Jul 2024 18:27:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n11kmsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXzfnVw3Crdxu5uvVSZJAyGmGoaYYGADjkTvD/YZ4GGylmT/0QZGOnsny4bs9at/1GzxQRx52A7Q3wkvxz3I1VD72xM8b8Up9VEo72RZc58qFaOLcq5qop9pgJH9nn0SzqFiMf5N47PeFglcZZrPHFt12QlBWoadTOBQUgvP5OJYQM3vhQK3yQGtwyoiH7eRNSwMzO4tsio9S427x2kV3CybpTFsEvksdW/atswXTBdmWhGr+V0By1of3lmfFEi3LN6FEGiTaGfh3XNZZg0RjOsNoakWKlvUD39PySDamg3hhXrDMVHalkbXK/o7DpklzkQX/Z9zX8h+NPJYJxs0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJMd2qwdMvbAWEntWtILy35IFR9pga/f4uv1MeD4ONY=;
 b=MyrpTQreUybhIELIWLWuXJnIAG5EumvxuHHX9oEDko6753vqHTg0dDXQIJcnQnuO5ERvjzk6XPq1WvO58TI+oexEF9tEn4iNg8UuGdfRLS8DjXZY4R0Gk4nhI8c+3MeiGBUDdbhTbSHkWDLBSJdKTr8z9dNbl9vCgptiJ2BBVtZ2MyLr326f6nCRQ+Ter14AHiIu1mkeTs4LXXlSLuO5TigPCK2hQqvxXN2aDL50mQw84Jhbh7WrGVLw7IPPOoMC7yPubypcZMrHttf//wo+cZm0YNzbTSdsZSRSqzPtmtR/ZFJJuIGxDMjrI6gLlN+c8hEQ5StuzHA4jNYaOpTmgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJMd2qwdMvbAWEntWtILy35IFR9pga/f4uv1MeD4ONY=;
 b=guve+6pWf3/1PMmfVk07ouFUdaSxb8nQqv2kbs8Z6aV46aS0yJ/LIkh+BW39rTzFX19+bcyIwze2uQ4R++BGwnSY4+RuQq5ykdNxFaFpj4ymg/Ic6Y3bvWrp/ur/Hv9wQdXGCe51ihVei7SENxsox04RtBk4EI60o0HayrGvGcg=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA3PR10MB7995.namprd10.prod.outlook.com (2603:10b6:208:50d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 18:27:56 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 18:27:56 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v3 16/16] mm/mmap: Move may_expand_vm() check in mmap_region()
Date: Thu,  4 Jul 2024 14:27:18 -0400
Message-ID: <20240704182718.2653918-17-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0337.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::12) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA3PR10MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: c13f5917-2166-4e6d-06cd-08dc9c570695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9hrLd7Slab6mCkDINJ//vAhdH3Y1DbUB/ZK4HeXDSaxGBbWioyuXRgf3KdKm?=
 =?us-ascii?Q?ZWdcOQLHHAT7cCQz22PvEQH/YHPoJ2zaoo3n3qWwKq6WYbwsrQt4oNCCVVmh?=
 =?us-ascii?Q?aU6M+WaiU0WST/F/eWET33A2Rk1/N+JlgTjLPBqQhu5+xp2mljdygOmp0l1I?=
 =?us-ascii?Q?TJXl0OcZRklkfUuG2ntKhULzjwlCopzT7cvcHBRvsn/uHWLj5Q7SkcXrODkm?=
 =?us-ascii?Q?bPsPuQG6BRb+b9uJWaHM/uCaK3a172RYflodq55WDZyLUQJVlZ6VKE7zK5DI?=
 =?us-ascii?Q?igCKtnvf1RH0cKznO+t1yDK39+6ftkYCNXnVL36oFWwgDierCQjmcXbzd+ra?=
 =?us-ascii?Q?zXI2neVKiN3WPDSvduF4feoCNCiaVDaYQDEPSyD36HUJ9X+Ibe5M1cdZR7S5?=
 =?us-ascii?Q?nTaBN3GSqf8qeBbcd2nkQ/Srh2d+G9lD4/iy9XknKRmRyARCjnDTpV6LrMIe?=
 =?us-ascii?Q?sF5UF6yBZOhdG3QJjzi5azZN+LXqz+YmeFT08Ft+y7vkPdt7E7oaCoc0diqP?=
 =?us-ascii?Q?IDrIOC8HabvHqQkrbclAx+BxXPWPZ84J/LKvM2I5I6Bmdeb83xFvQDRIs2om?=
 =?us-ascii?Q?0V/UCw9bbX1FetICYUjm0FI7krAIJSWlw68IxQshLl8DNOJt3fPNfxky0npX?=
 =?us-ascii?Q?mXJVK7rhRhuJXevF5UJs40SiZGjlIm7C7rnka9xhHy3xXWagvDYOfahOX9uM?=
 =?us-ascii?Q?vx3qOi9BJjH1YTgW4wjW/W0+r5ZTjM4MquPCZHWjaQuq3J3ziXPVcgiBUEna?=
 =?us-ascii?Q?RDkGxoXl8xVth7SZAqvbpGzG63Nfo14emNlNURCeQq3yY4IekB9DgJqcR8k7?=
 =?us-ascii?Q?bVb3SZFtaskaqsCJvY/mLp6PbglrxmSy6at4aBYWyIvvFeTEOIkos7V6v/I8?=
 =?us-ascii?Q?B99I+0FW/P61iS6zqCltxawMFYQEpotP+qNni/wzdGE+nnm4HQ5S5D29V5KN?=
 =?us-ascii?Q?mWm2Q3fJ3yIBElYRWv3DYDPTVk2RsOW2mzAvdsAzIhaTC2huk3VslchuJ7t+?=
 =?us-ascii?Q?WeJVK5S2C7L4NUXEtaQik8uOwiNUqWLgismykJUxsKLzKkiHwv59LgKYpEot?=
 =?us-ascii?Q?yTBKNlX/uGg8zCgWfqqacSyMjLcKNn4XpCGyM7ZnWAxn62wM8GwyviTOWQ4G?=
 =?us-ascii?Q?aCq75Fy4GJWs2HQtd8E5HWfB1YQFD3yPMW6TvQbT1XUFpfL0YRUuMcsDhtOJ?=
 =?us-ascii?Q?RF0Bbz0eSc2uj6X3q/yOJIrf0Y/RokN0XTHNkU6cX8Asy98pVQnpLOwIHQBp?=
 =?us-ascii?Q?Sri72sigl5Xnvd0I7F50um1S4AR+BvahdUK/R7T2/70oO8iuUWrMv1f+Mr6R?=
 =?us-ascii?Q?JkdpB8Z3u5Q05DQxSmDI875ioeq3tNPcL6OO7f+bdMAUiQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+tI9tL1aXCQ8xtArz4N/ZMO2v7J5z7bn4QTQ3UOeAh63Y2ZvO0XsV86RC+DE?=
 =?us-ascii?Q?SNfeTXqA+JB96zLV5JW8rKibsQ+f4RmXtSgTyrv/p6EQZhsW4YCv1/VinxbY?=
 =?us-ascii?Q?77v6qjkzKLqyqgCCCiLuumdeXvZsTtWOrMycdaWJfo9ITZFJa+ez6m7NkUrz?=
 =?us-ascii?Q?bY7ytu3oVHenI4YqL2vlBPv44Iy3dfOrMA3JDc6K1AhKy0lewEaZuOhR1xdn?=
 =?us-ascii?Q?X5GUC7RuoBGHsIiYzwV7oscJUBJMLOWAvcmHzI8yjiXdQujpJ76eErsfCCHY?=
 =?us-ascii?Q?Ms41ZfaHPPOHg84WxhjEyzCI1jrvVIHGMQ9Z1wji5VEmt5sceDiHBh8MsG60?=
 =?us-ascii?Q?ldY6oiJ35lIGZEWgBXK6VlrZ3j/j15FGffJfDv5MYtDeJE1r75+wuSYT8Wbx?=
 =?us-ascii?Q?dK0qa/9Qt9sk2hDeptpfUaITuXlLqOPA2+iN5cVKc0Jc5kxH/PQiajI1J4Js?=
 =?us-ascii?Q?gUqg0abMRSzQrS5n65ZDey6gHA/ho+vrbTGkS5BXF6rQdwsn5/gx0A/MAFhg?=
 =?us-ascii?Q?5i3H15Uk1DG3KHcAFg9W/riMNXWdOXBYHyBJ6laXi7Ui9ZF27/UBvzy6cIHD?=
 =?us-ascii?Q?55UD69eRcqidb6qldLWAKsF4DnkEE3jaewcwcsug5PkcGaz0pgoHVqsqxIr3?=
 =?us-ascii?Q?5CvhvYeoPjut/WGh47pA+YycDlSiNcRZWbcHFdBeMp5yojuGE2aPA9dxqZyD?=
 =?us-ascii?Q?qKDik0N+ZcNGhB0ADOme1rPNZQVRhwhOZjqkPbvaEMKTcENagNlkr19XZnkm?=
 =?us-ascii?Q?OJB1Ltkt5ZQORUBuLJpwsAMoDzoZOuyFYzomhz4NYf+QxmC9KGOZm1r5UkB9?=
 =?us-ascii?Q?ok8JjVYogoj4aTx4FeL/qUuo6dMns6pyzoUQCNlzvU5GUdD+BndMeaMfgExO?=
 =?us-ascii?Q?RehO5t7Z0StP9anzWFGom63SOPiIwYi/+/lW5CuBbvj+/M8g+OJ9EWqnb2Ve?=
 =?us-ascii?Q?TNdCcRjm16FBzGHUA7J2Pox90YewM+6fsFKfc3TALkbt+JHUVhMGcihlLY4p?=
 =?us-ascii?Q?QFB1YA/jNtGpShBVNAc/ga7iIThLPThpLKSRJ9XrCAd5oosyNwXAlb/NvhWr?=
 =?us-ascii?Q?egGnCxnKB6ICcIyrKXVa5AWN7+GtkX5RhL44vQ1tc1kjyGLME+Ou4zy6o05r?=
 =?us-ascii?Q?LuzBseki0EVk63CyBDWJpbNVad+r9ddt5sUCsi3CyAdx58Bd2ZGM+oQ0u1Bo?=
 =?us-ascii?Q?RsUioFaAUeFTmKifyASy6aD/BHNjzBFMzb4NGlDaiZfFLTM1iDBmQMD1DisB?=
 =?us-ascii?Q?3NcF0D82re+K4UE10t3fYxpQFpHofc7bsKVlGcWIqikslg9JfcOKXGKO39QP?=
 =?us-ascii?Q?gsyU7NPVELObR+TgpGReD7y9kYcw3tFDnO0stD5e8nRCppRgKo1PgI8uO09W?=
 =?us-ascii?Q?EhUAXkmfEiryEKdE/w30TF0QYUxJPgCYbT3bHQWkLrcZBuydcyXTArxlHjXB?=
 =?us-ascii?Q?PPf3cP8o9Sj78u8E5I0L+EDfvWYRG4Nxoc+q+Dm407FQNyF61TmKFAVBpaXU?=
 =?us-ascii?Q?+dYCy/QACEjdA8+PiY3e84lurYJL4CT00bLQ3vxo77FGKeQQMtzBHciepRUX?=
 =?us-ascii?Q?XoVN/QjAjN1h136igH/e99xVmcf3kQGlY1yj8yB2XR5RdvD2hdB2yp7fYI2q?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yy37DRmdQsmDvv5W90ElizW1hJn9jQDovwDr6SyDHZDbBl4sxzlE4WfQ1FjW4XA3FpziPNh4EMJmIhLyDQ2oapWlBSjfd6NNWG8oQuQ8K0zxQG3wSM6GI0VG+LVGU31l4ikv5zVUY3npz+qZVuggUqrOIi0SPJn6Uorvr2Ku4Gcut/7Nqvp7hFb+kkteod4C08J3/i5S2Ysh4mAIqSrBenuej8cizavA43dHKUS+1osFeRPA6xutYx9c4SMhlHD9H8p0kvtR5+MI2AFH92r0fpAbAml6zzwG4Kgh1Z6cJw9BB7HTU06sytsdQHQe3og93Yd+gitIkUAuJztNcOx7ku+DPu0qhexOF2B/1k25XVFFbEMRPMoHRYDbQ6onHQYK/dm4dNnoK9hC/HZJB2fusvK15QriBX6ofIaHpMXmhnteUJgQJLHsSykeHHN+3+DBkcigVMBV7JFwUPjVMAqk3dL7UxOsA3z09eJdC0TI4X8MZrLQXvlr7HgHQhYVF0/5F6oZrEVGzqzzgEM+jujxzxoIC65zCiVmNJ1LAH6WQrb5m+vO/eKHvlk+5m9IgtyWAVK1WD+aQzmrKykySoOY27WTNn9NDi5MCtiu0X6pvJQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13f5917-2166-4e6d-06cd-08dc9c570695
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 18:27:56.6940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TR7DKH3mmzU1t2CXIe9j0NffjBUkx2tArwWye85Wfgv3qBB5dnztialO8L3z7yIWgTzTyIQuiJB3Qx8oNPKoXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB7995
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_14,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407040134
X-Proofpoint-GUID: ZFcKDY4dstibXBYjfC0XvFO9YYqTxAAo
X-Proofpoint-ORIG-GUID: ZFcKDY4dstibXBYjfC0XvFO9YYqTxAAo

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The MAP_FIXED page count is available after the vms_gather_munmap_vmas()
call, so use it instead of looping over the vmas twice.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 36 ++++--------------------------------
 1 file changed, 4 insertions(+), 32 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b2de26683903..62edaabf3987 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -400,27 +400,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
 
-static unsigned long count_vma_pages_range(struct mm_struct *mm,
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
 static void __vma_link_file(struct vm_area_struct *vma,
 			    struct address_space *mapping)
 {
@@ -2946,17 +2925,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	pgoff_t vm_pgoff;
 	int error = -ENOMEM;
 	VMA_ITERATOR(vmi, mm, addr);
-	unsigned long nr_pages, nr_accounted;
-
-	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
-
-	/* Check against address space limit. */
-	/*
-	 * MAP_FIXED may remove pages of mappings that intersects with requested
-	 * mapping. Account for the pages it would unmap.
-	 */
-	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
-		return -ENOMEM;
 
 	if (unlikely(!can_modify_mm(mm, addr, end)))
 		return -EPERM;
@@ -2987,6 +2955,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			vma_iter_next_range(&vmi);
 	}
 
+	/* Check against address space limit. */
+	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages))
+		goto abort_munmap;
+
 	/*
 	 * Private writable mapping: check memory availability
 	 */
-- 
2.43.0


