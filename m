Return-Path: <linux-kernel+bounces-297895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378FD95BEE2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64315B2398A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3671D3186;
	Thu, 22 Aug 2024 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AUBtDl+n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A2pirFbv"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8691D2F50
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354830; cv=fail; b=eqx8eHfqCKy9Q/m4RuL+ykj0az8MPA/tyTPt2lRQwiUddl3rYYaUD85z9mpi4pHLsqfW7AMHTavkXi/x8mXL4hfGZdmBIYwnPll47rRfxzuy/pbK1RcsHXFdwtQEiXjjtDTSkqlOnUktWP/fw/S2+21arT5BTnC9/Qe7HaJgrtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354830; c=relaxed/simple;
	bh=6kYI599eHO3W0vCC0M8rfPf2vwxqSBojefIeFr9Gz1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U4nDJB4m6e+A2wcA9aUieOGApkG9jp5K62uIHzK0QAqVwHK0Rhi087AKhZJNRRg4hf8QnOLfgC7wjMUiumVtQtegOAwPbDjfKZ6PZCiATouxwyNCdgXlCdv+KUGC7RiVOkTc4FsifWm9B7rB93884nr+f1Q4bL2RSdD1ughzxqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AUBtDl+n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A2pirFbv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMVP3026316;
	Thu, 22 Aug 2024 19:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=IvG2WpdeI5OiqGGcNid8Tye85YyH/LiFaaeLo2szEDY=; b=
	AUBtDl+nWAWwEhybSpDl4S7j9Wbu/MBGEuywQE0pp1QTkX4n6XGU64q1n8UPbWDW
	j3+GIJ/1gqsnJolFfcbN5gHhyPAqXEVwdRnC405FHS034KzNbGldSx91UfX4Q8xm
	DWsZxQGmVfc37ZopE5aINSEHpTUfiCnUWpzXeeVOD4d4dMPhdUOlL6tjGlxX6Mzm
	w5Hqnu6ltWxOYEiUPKzKTM0G1BL96vV15RRsZIUsYrfXyiA78XFpQ5qf/nSM9SpY
	/V/Vh9CdZcL1udUmnHvvk+Ca78y9YpkWvyQ63uSToEcRMitGAa2uoDqtdknTAthi
	SN/HRyQI5mnPdBmk7XJyaQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4v2waf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MJJOnX005646;
	Thu, 22 Aug 2024 19:26:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416bcu08bq-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHGbQx7x5ax9Rakl7c43PBXX2MTdZGzZ5K1dcRHnVjcVyQTk2WmrOfqEgxGf5SURjGZNc6egARHcH98rS++qlw1XMFIwKkqDsdR3UIX2HAfmgBAz8r0W5GMRfiRClffK385KtAko3gZn+nnf5LKHNfDH5j1YEd7lGzLeGMPbZqVQkWhQoVZapbzXS1T6ERtuHZ8tYZTwGWx1SNt5gDd409X/9zWno05ngeF8e5lS6a1WYQsZA/FqW8znJrt8MQJ90CeIlim1wjejglZtTkUaXUVkAsXp9+QX8cfLtUbH8cUvH7HuJXLgtfxYd3bdZ6iPe4BsNj52lEn4Yd5YzzXsjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvG2WpdeI5OiqGGcNid8Tye85YyH/LiFaaeLo2szEDY=;
 b=Jj6oL7uNxfwjwkNxGkq0aJqGdawyIMXef1bW6xtkmUejTgKkvXoXJn0Xj/ijSRT75Ot/ANoFAe+ypTHc9NOWp0H3ybaVf2rirzrSQo+0Tob085OGbN4fNcneNp3c7lMQp3KB7xK5gIQs1RkLZc2MvWxSHPmrILneQ8G2y/WQR0GzSz2rJSJ3kK7YozhhRugZep61gCi+dO/Mc4Ve3WPuHH1QwR8LFY+JGluzAhmmDwgskz5rQ7Z6vf+fcWEHmkv8283QU+Ma13iq8jQ/k0QV3BTH7zrObV0aty1S5IgA04gv7qAasAPgFJKrqfhUfbkdE+DhKQbGBoRB0c9tX4v7QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvG2WpdeI5OiqGGcNid8Tye85YyH/LiFaaeLo2szEDY=;
 b=A2pirFbvmtoidQpCrtV7vW6r3qZZr2FoxZOi7ep1ITr9ILvVhl9TcGt09CZH1Y6f8hmrWA5E4EfefUCac2wBvmDf21fAL2YFrQjsJVug0BWUP12q7GxGK/FtQFGEKBkcIpebOzwWcuf3asAM1LOQ7Xb50RmRxKxJJ27f1LrFWcU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7761.namprd10.prod.outlook.com (2603:10b6:610:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 19:26:51 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:26:48 +0000
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
Subject: [PATCH v7 21/21] mm/vma.h: Optimise vma_munmap_struct
Date: Thu, 22 Aug 2024 15:25:43 -0400
Message-ID: <20240822192543.3359552-22-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0009.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: da18d156-3e84-49d6-1845-08dcc2e05e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BO/B3KMEOczcox1nqCUmH+QP2OQiW/NrFfy/9GJBFM42MzSo5WoNxVz7YgV2?=
 =?us-ascii?Q?KXFk3TgiwXBRUhPyDxrHlgOW1F4dGmXqvWC9SnnNkX31zZNi9eS1h/ntpbaz?=
 =?us-ascii?Q?e9xsf/Q8belfcucrLhpCnyZDA1d4bC3Kxg1w4TdMfhCrQFblQSBZFbXQQFZx?=
 =?us-ascii?Q?YtmvSdTLGrD0Lt8DLmS0BleflkYjhdxg6HVXRJfPPxn7qwvXem8nGS63HGfn?=
 =?us-ascii?Q?kajuvP+4pLqT81DG9EtQ4CdJl3EMV7Mg7UpMPnkC2l1ZmIEVFWrr1OoBzX/x?=
 =?us-ascii?Q?CUZe39AynTCoOAr/utXZGM/oNPHBivxn4fK0EZPg+Z+Vu0ASfwWewZ/EApij?=
 =?us-ascii?Q?AquV4xuXujqupIMfcyzVRoe0L5YJRDp1Q5z6v8H/i6Q1CcV8KcJHNLhWEjz0?=
 =?us-ascii?Q?d5Ef9rJ+A2i6aiEB6JGGJ9RpR0fGDZ1dSv1KHymT8qa41RXH6ZprEObPnh71?=
 =?us-ascii?Q?MEt4ky2n82yNhD+/lj2MKovdq1ZTMV7o7UqnRdJq6KM51uKjcnh/ET7/lMD/?=
 =?us-ascii?Q?lGoWCMAOVvIjD+j2NmqxBdXtOgsTiIcqq0/s0ALd1D331a4vcV5PKba5ZwcK?=
 =?us-ascii?Q?Sxr2AVUoTn/KVf701+CQXslH7n/um6kaVkn2MJJ1P/DUZdFujr4mYXesqx6l?=
 =?us-ascii?Q?i/ca+koIKLYJbnI2Izwxgp7EQzBdgdzmYvflZI1cU0mf0V0UTCQI1L6hF0Wd?=
 =?us-ascii?Q?6HkJ5D3nZKxh9TsxG/0gZGWe9wdtTNk9CFTyzickeRBwfQDgx/wPHbgXwz56?=
 =?us-ascii?Q?VkijE2/w1fst9P/nBQFAazsasS2OZw9kkdIHy7nMJPtjqO75M4XzxtFUfl13?=
 =?us-ascii?Q?6OWN4sLBzYFbAEmM6kEX8L8sJdXXz5m2sxZ/FUgNe/5jyQdfJjTeqCs+j7+7?=
 =?us-ascii?Q?OH0uUmo1/gOvqZN/HtaIoBW5pR6rDveE2licUKwypEu8IaMTe/sHHHr0pwgU?=
 =?us-ascii?Q?HBl4Vq9W/Bj04AXgvNci0gicU9SuRPw3ikl2LJbU7S7G+zmurJmyisk8VkQA?=
 =?us-ascii?Q?4sF0ZX7RVtrX+TB8Z15QflxW4HI6lTZpzKIashh/FDiepsSQLZ4f69FooHHr?=
 =?us-ascii?Q?PE/g3DSTs48KwytikML0YraPPj86n94gXg4PsiQNwlK9IC6XiaCi/ON0SKXQ?=
 =?us-ascii?Q?iu0YEJ1QKOtyjDR2JbtOj+UnoaaOTqGsAQwnBWh8yyY5828tbxgs6HL2gEen?=
 =?us-ascii?Q?CSMVuqdddTWRrH3jok2a8U2zkKzRvUXW/azAPuCGtK9bqB+8GFopc0G7YXgj?=
 =?us-ascii?Q?pVdcBvt6cTe3zxmrG63JlRSc3UV9o7+l+n9bSkX9Sh5UT5Tclw8O7LHIHX5T?=
 =?us-ascii?Q?Z8TXheW/JpRmkDUMOgkPhsd8YKgSKECU9nxj3p34RBu+sw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6PdcHEXQaf6UR+Hi0262fGWC3w0gNzU9CRbbsHSE4KL9Y2P9PMp98WnhjfZ4?=
 =?us-ascii?Q?6Kv1b2VUWc5Eli87HSEQZhbLjulL5SFW8IM8gEZD6yJWUh6rcyu12Fcgf/nX?=
 =?us-ascii?Q?IHQ7QK/AwehkI0zOfoHbnpcTKYGeawwkeog1tiXSFXXTXsGE3Vd6sE8zmKbE?=
 =?us-ascii?Q?44Rrzbdte8IJF6LITa1EDEU0QN7fhjk1vsAvyYUuVyqWSMBtgAMMJoHAUH1y?=
 =?us-ascii?Q?BdYEt1im/zl/HAvZh6B5TBtCgAmrwoi/VdbufaXP8s7oEfaVVzFjf6TDW0dM?=
 =?us-ascii?Q?ayntnTrwIY02hIsfoAsnfaK7m6CmR6+1x/mV4iibFzfs1ovoMlQ59q5ikSxM?=
 =?us-ascii?Q?vGg+uQvC9xnvBCdAaX8BOsMYMoDXwxwJIl0xPEBjlvok5uBISKPJOZc1NMw5?=
 =?us-ascii?Q?zoxYKuNPxqcVwkXTn/8CuGA58YQQ1cFeX8zyXX3fwjwf1almo1oYRlYl6p1T?=
 =?us-ascii?Q?alGkRJ4aRsts7vegrso+FLvbtw4t4S6VWYbWnvt+kmXlTAsrBLh5TY9b2CuV?=
 =?us-ascii?Q?oczWmX4pMnQPbZyl6qAfi3IbsOH2aO4LV3XAi1KrODqzB9nYpf3mZg3K7g3Z?=
 =?us-ascii?Q?badjxg7CrUe8yHMX9y58sEC6J+uxEOoulKo9DexI1AGAlmO7Oh9CdhcAI5n+?=
 =?us-ascii?Q?o4MHItrwuTNC4IjcqPDT1N46I2sR10KPkYGJbfuAc4e5zxCJcySMvry0jJvI?=
 =?us-ascii?Q?KPuU9D6yqB/NLwomxiHMdMbdWcLM0NtOm8eR8cE+b8Yrq11+sjIi7LiiQy38?=
 =?us-ascii?Q?u1xNdDluOVfJcbAexvicRygy17jWf0MZJZC43KHdSqxxNAltGdmUKdkhLrJW?=
 =?us-ascii?Q?afkHq2h9KMPf9PlDPOWH/zhLeh/5epimZKzGbuywjjv/jxzQ8jwaTlOlFLQd?=
 =?us-ascii?Q?njvHnI6WjjNg0IBj6/bwo+vqbw5a6HnXccGpwP5OuR5VaZKyTDbYnsCG/b/E?=
 =?us-ascii?Q?IBfO4o9hrbMxxzUGD4l3Jssp4geqLYwvdFKsSRoL64EBCcMYFAftjzL8GCik?=
 =?us-ascii?Q?Z4aedoPHi3K3FHwJi8hYlLcBVkTqqO4WK7xMAZEbqZbtZHIFmxxOTI6oKZXB?=
 =?us-ascii?Q?K3VkpBiSN0u0u9XogFv7hGrq4wKVAWQknVf2ScMnwCaU0s4/pcgu8ndJuDIu?=
 =?us-ascii?Q?kNbBy5ONhu2+vz6X4aX36wuPuNcnr0XrGGCcX7fpGEd+r63Y6oRJ0yYLtY9q?=
 =?us-ascii?Q?0avwKM/rO2hxf6WANNJh16LzaD8ydBJsAro9zzlT8cPPN+saNLoDDAXJP5hp?=
 =?us-ascii?Q?zlEcesNMN2QJIXCTDtcYoTecrOIgAO4sz6yC18r7FOn75tB1GQfhrAbs2YMk?=
 =?us-ascii?Q?RROkHU/Aw6BlncVMJgIoAYNqeWU7fa/4FlnkauhTbONP/eC60zbjT8d0n/L1?=
 =?us-ascii?Q?GXYBJjYzWm2/lVGcxrhuD6Dedlx57i/VvjsT5FELVdU/H/jtxUlF3xEpd5ls?=
 =?us-ascii?Q?E3CA+4IPyxNEsFgu66N4En5evlPGiykLLtzg0dF4jLifB9OoJiE3v7PsELjV?=
 =?us-ascii?Q?ullLS8LZfNH/n2p60CE3PgiuNqnqcHYIxyn7Xp7AWoXxHWxT0y2D4WB1h/5T?=
 =?us-ascii?Q?kEGiUpbhzNuPWW76X0xWNNSD7wzEBayhGVRTrSaQeSkcBSnNbRVF+hqmtSU2?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DOWifhDm3kU29gBxuAFGLwoGMZOfPaANFKVLszuqFnHHgEy9aOM3yuPjKywmMRuQGSXaj/WUitshHD8IPLkhUl0OqQJmgdG9TtzxjIQMVxuW+6iKuMY9FBzIZ2/c+H50TRGQ9n+L6SsonpT69mKqSPS+spSXB9p2aP/e/js44SqzfZ0edDRysDBMEjQ8xL6CZ3aQTpRh35Q6VH/162DQDluEA6dIsyFWD78SH/uVhBoQ2lcwHSLgCMLwQ07ZMAjS/gcavhtX+CmvG55G5V7MH8yyTOgv9Wj4M3NuyaRbZ3eSPC2iu7oI52Npxvmp/jucaLWS9X+i3devu3LO6R1JuFkAquSvQspRWlxyqRLdDR1dKg+SATorBUWTEypnOl65+OfzmUkM0y/aZAZMwFhKzFdXnjgiV1scKBFzxP0cY/bulQgIEswtP3wC4Zl/tTrfsBhIYe9pRNQ2wAhSxpW3VsbByhdbvUevOeMa0Uxk9X6UdmyQugf4qWnRgEW1ZYrGjRDE/Xj7NPM7BUX6zRbPN+s4ZRv1Pg/d9zd6nC5LVnqFs8ooPtHu6NqZPW7hqH4+jljpznBu0iU92srxbNKjeAVmcaNE5blFsPBO4OWNf3g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da18d156-3e84-49d6-1845-08dcc2e05e0b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:26:48.7121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lb9kyWt/ku+l1zy0J7UoUnwPKm70khfSMLNjb2Y0PVxLK9dgr5BwSnxCYYoFHrs8abmAW/wOHJ/0KQRrpo5g6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220146
X-Proofpoint-ORIG-GUID: iE_tOlJvDGblwnownrLBgZo3KNfdEmuG
X-Proofpoint-GUID: iE_tOlJvDGblwnownrLBgZo3KNfdEmuG

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The vma_munmap_struct has a hole of 4 bytes and pushes the struct to
three cachelines.  Relocating the three booleans upwards allows for the
struct to only use two cachelines (as reported by pahole on amd64).

Before:
struct vma_munmap_struct {
        struct vma_iterator *      vmi;                  /*     0     8 */
        struct vm_area_struct *    vma;                  /*     8     8 */
        struct vm_area_struct *    prev;                 /*    16     8 */
        struct vm_area_struct *    next;                 /*    24     8 */
        struct list_head *         uf;                   /*    32     8 */
        long unsigned int          start;                /*    40     8 */
        long unsigned int          end;                  /*    48     8 */
        long unsigned int          unmap_start;          /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        long unsigned int          unmap_end;            /*    64     8 */
        int                        vma_count;            /*    72     4 */

        /* XXX 4 bytes hole, try to pack */

        long unsigned int          nr_pages;             /*    80     8 */
        long unsigned int          locked_vm;            /*    88     8 */
        long unsigned int          nr_accounted;         /*    96     8 */
        long unsigned int          exec_vm;              /*   104     8 */
        long unsigned int          stack_vm;             /*   112     8 */
        long unsigned int          data_vm;              /*   120     8 */
        /* --- cacheline 2 boundary (128 bytes) --- */
        bool                       unlock;               /*   128     1 */
        bool                       clear_ptes;           /*   129     1 */
        bool                       closed_vm_ops;        /*   130     1 */

        /* size: 136, cachelines: 3, members: 19 */
        /* sum members: 127, holes: 1, sum holes: 4 */
        /* padding: 5 */
        /* last cacheline: 8 bytes */
};

After:
struct vma_munmap_struct {
        struct vma_iterator *      vmi;                  /*     0     8 */
        struct vm_area_struct *    vma;                  /*     8     8 */
        struct vm_area_struct *    prev;                 /*    16     8 */
        struct vm_area_struct *    next;                 /*    24     8 */
        struct list_head *         uf;                   /*    32     8 */
        long unsigned int          start;                /*    40     8 */
        long unsigned int          end;                  /*    48     8 */
        long unsigned int          unmap_start;          /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        long unsigned int          unmap_end;            /*    64     8 */
        int                        vma_count;            /*    72     4 */
        bool                       unlock;               /*    76     1 */
        bool                       clear_ptes;           /*    77     1 */
        bool                       closed_vm_ops;        /*    78     1 */

        /* XXX 1 byte hole, try to pack */

        long unsigned int          nr_pages;             /*    80     8 */
        long unsigned int          locked_vm;            /*    88     8 */
        long unsigned int          nr_accounted;         /*    96     8 */
        long unsigned int          exec_vm;              /*   104     8 */
        long unsigned int          stack_vm;             /*   112     8 */
        long unsigned int          data_vm;              /*   120     8 */

        /* size: 128, cachelines: 2, members: 19 */
        /* sum members: 127, holes: 1, sum holes: 1 */
};

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/vma.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/vma.h b/mm/vma.h
index 7047fedce459..c774642697a0 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -40,15 +40,16 @@ struct vma_munmap_struct {
 	unsigned long unmap_start;      /* Unmap PTE start */
 	unsigned long unmap_end;        /* Unmap PTE end */
 	int vma_count;                  /* Number of vmas that will be removed */
+	bool unlock;                    /* Unlock after the munmap */
+	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
+	bool closed_vm_ops;		/* call_mmap() was encountered, so vmas may be closed */
+	/* 1 byte hole */
 	unsigned long nr_pages;         /* Number of pages being removed */
 	unsigned long locked_vm;        /* Number of locked pages */
 	unsigned long nr_accounted;     /* Number of VM_ACCOUNT pages */
 	unsigned long exec_vm;
 	unsigned long stack_vm;
 	unsigned long data_vm;
-	bool unlock;                    /* Unlock after the munmap */
-	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
-	bool closed_vm_ops;		/* call_mmap() was encountered, so vmas may be closed */
 };
 
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
-- 
2.43.0


