Return-Path: <linux-kernel+bounces-272674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD68945FBF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD901C21A0C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B232101B1;
	Fri,  2 Aug 2024 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yo83oAcG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ynfK7Q0b"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346F01C693
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722610644; cv=fail; b=mjX3C/vJA8ZciCtLuK62zRhoScGpw92WE4fVwcVuqw/1BgZLSY8ZfMD7tYIu1k9foru3wfbviUCt6i2S1Qy+ZKJjr5N6pO7IDDNGgOwDKWlezprsDhdN5YtAmhb4A4w+r7C/32Zomz4dKcBNiTQdOrc8petDkmGlEQ+LDdDMgoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722610644; c=relaxed/simple;
	bh=4uQypB7jkWidqtYHLAnFbVeR0iV9ei1HiGl19oESRHg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U5WBIkq4YMVfeNuqfc/2sOQFI5v+o/yG1k0JN3flIRsojspzs3hjJyPl8ThuGTRaTqfk29ryL2SpfkUxWYeWiaRwbejHCuXjtGTs+NC5GR0y+9mFIY5MDUSfRkZpKb1EQWD5SJ9gN/obTrgYfqKBIR+bACLSAQQTbjuOwE+zzqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yo83oAcG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ynfK7Q0b; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472DGT5W029939;
	Fri, 2 Aug 2024 14:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=klnYlCEF1ev4gv
	WQuh7GOws8QP8o0gQL5cqKslxwquc=; b=Yo83oAcGEjni+tIYPhYIRQVg/qhRYu
	Zb6FVJe0OKpp5feFtAPqXtT3XisloIdg+tNzB+q7CwO4Oejt6DNu2NOtA3EG3eVL
	Yi6apFB86AVPVlQ5Zk6szmpKD9nIVgA00sLr27OirEdvf+cqqOcfBQtvaMG6ZbUV
	MwZ/pJON3JmSxvePg2JcdcSSFSxEGhWkwS7/XOgMxFR8FTIPgsIyR1ZTMUUOHSr7
	xDHOgO3R0Vyj1Fw8bh7zchbYf4dQXdfQTUrH0gNmlIZjr515EzZW5U1mLwtjwqDD
	sjF66ZaTyQkK3VnT0hJ4Yj7cRcJri2trTAQ0Sl5XQLykO5eDbEodOaHQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40rjg5hcyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 14:57:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 472E9SfY002539;
	Fri, 2 Aug 2024 14:57:12 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40p4c4a02w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 14:57:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOUG/+pRT+aSc0nxOxmWNSWYMFrTOS7JYIBygBKL4GDPg341DdFdj7Vxdmp6ugvWP0IM+JD0s2wD1yzUgOcHKrGbaShEJCU28I7CRJnj/OjDFLztSu/P6/Ljo/9vSyIDAyXcD6ojowe1jMmW/qA4AB8IkvlsyC/zP3EvEPCgASj+RnEfyyfPH5Lp0yynuZHrFK8LCiNc2xNgW+oCtgUp4g3hTmvBjUD6gjOa9vdV7nzDmbzJyY6jaUHRlWs7lb8IO639rrstw55JI9LCXvb2xau4pyhxrA9RyOnNegzYtnwiRMHDPfRlaBMVubF3EkXyZTcAKh/scm2ZLSZjLwmJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klnYlCEF1ev4gvWQuh7GOws8QP8o0gQL5cqKslxwquc=;
 b=C4DBt1unJudPNoeisD4rP/NX8Zi6rjFkLtpEDCLHRSc/NE9M+ur/WuMmLMTI5YS0ATjRd/hsEq+fyEQ9duz4lZ4guG7vZaKKPYUsPncUQiqu+/j2GS8wdHyYjmaJbEAdTM8wV1Wu5PN2umAntt7GsxnmOEKf9sqBO2fRwYFV07L60wLOEgRbWbU0O2T1wBSrvKF7HfOYSnIEPnUEPutdPmIE8aP8kaGA/ftMEqPlsuWdMYJj6tpYF8CiEIkq1GkrYsB7bSzcmcUdv5U1Rx6Oj+s5mOas54dFJIWyMm1Ih3/ctNSa3JP3zYtJKSp7UG+vuM+QprqOPLBjdO7tod+XxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klnYlCEF1ev4gvWQuh7GOws8QP8o0gQL5cqKslxwquc=;
 b=ynfK7Q0bFQAU88XV9mEPD3lpuC11TkzMZadFd8kpQkW/2AKpirdFBu3XiE+diYv2j/trOdDsYu0xNjkRqmiZvKdiWGn9LMM5r4A1IY2qfFOEH0wI3nfpl14w7mq3lSv9Sl5nCkP9y4a7X8VPX/BNsgwY20eboiEe3OT06XQjjgw=
Received: from CY8PR10MB7265.namprd10.prod.outlook.com (2603:10b6:930:79::6)
 by PH0PR10MB6960.namprd10.prod.outlook.com (2603:10b6:510:26e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Fri, 2 Aug
 2024 14:57:09 +0000
Received: from CY8PR10MB7265.namprd10.prod.outlook.com
 ([fe80::d299:36f1:493b:33fc]) by CY8PR10MB7265.namprd10.prod.outlook.com
 ([fe80::d299:36f1:493b:33fc%6]) with mapi id 15.20.7828.024; Fri, 2 Aug 2024
 14:57:09 +0000
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        John Hawley <warthog9@eaglescrag.net>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ktest.pl: Avoid false positives with grub2 skip regex
Date: Fri,  2 Aug 2024 10:57:06 -0400
Message-ID: <20240802145706.1283189-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0123.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::8) To CY8PR10MB7265.namprd10.prod.outlook.com
 (2603:10b6:930:79::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7265:EE_|PH0PR10MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7c34cc-d053-4bcd-da8a-08dcb303622e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FKPa8Sh/F5FcduytZglKH3TrPVM33/QzJtGXu49XYLXlGR9WxPczzQTZT7mK?=
 =?us-ascii?Q?59hbiqOtwo2vSQ7q9vSSQO/X7JYbSYgfUt3QeeifeKrYGxmOu5usUzvEr0kS?=
 =?us-ascii?Q?MQSz+acyHhEQu1VrOuQTt/PQabzD0A/0Pf+6qGTU6NpOphRSH6s/5jghRgbq?=
 =?us-ascii?Q?WXjn0P+yxg4/WId2VuoJOozIuaKLpuc+VDKiEYSmFVi1izrjqQL5UMsNV9l8?=
 =?us-ascii?Q?EMZgMAOyeU3HLxVISpjhernAx+QaDgSXyCW8oA2eyIr5N4pqn1AApJXGJLj9?=
 =?us-ascii?Q?TN2K5I3B+YK51GwDGFN6UKOqFMym46L+qETq9Jl8qc7nlDxfdnJq+3ZVaspO?=
 =?us-ascii?Q?JsJG8AJv1TiLufiGiXVQwukOg1lvbn8ndtmfdUg7Agaamd0Z8jnnbIN1zsyP?=
 =?us-ascii?Q?Leabbe1cebVojj4dPvpcSRolsl3kGMOMMbmMRfH+jqUks8vmQj81QtcdFWcw?=
 =?us-ascii?Q?8+gR5btSL2ZrpbXehk0r9bzwzatuldnVOXjwkr1Yogn37QTojeaSA5sjSbv+?=
 =?us-ascii?Q?AmBu4nGhaMeS0HjyBHwf1XL9420Br2LCfnn+2J51bWC9eKHxmStnuzDzljn5?=
 =?us-ascii?Q?jIYo5/Wnux8DNw8DfN/YL1VHnfD9JyGok/0VPnkxwaH0WWZdt7WA3oYaCisr?=
 =?us-ascii?Q?SLZYPWPi/LqSivCB4BJTbb5uuKHT5JJCJrX3XJ/g4s5f7mLrjkcMpe7ZK3bA?=
 =?us-ascii?Q?TblyDiVzFU+OcBmkcY+bmYGNI0eu5/rMVUOT0R50J/U93cSmbXjhHkG0jwO+?=
 =?us-ascii?Q?0riIGdCpr54bK4YQ2lgbavZsR7IFnpV5ew97unCoUtNxpgnJMsyg2lcYn9s8?=
 =?us-ascii?Q?DqXdKCBOC35T+Vo4HQMnBx/n9dRhYN6zswlFGj+4/s7n3IJuhWBq0W94qzAT?=
 =?us-ascii?Q?hEh4a2wsyLzYfzaJBqi2ahB76HS9dm7KKqfKE8InnOU+uTK7fvoFH8sUf9IY?=
 =?us-ascii?Q?8svr3fPajFklTJc3YqhawFuCuOAGHg0Q7+BhZfyAJT8d4xgQBCUmGy2XyF/y?=
 =?us-ascii?Q?DLrMCRv+fduKuDSq5mn9+9ILZXCgTHmOX47M/sewgIVflfDqTg+223Y74Mfb?=
 =?us-ascii?Q?JKnWgxKVJH/4ixhOx29RUPRNOY+Kuf0WdzUMoGSf0oAak18lMIBkP12dBODE?=
 =?us-ascii?Q?bxiE2m9GZXI3p+xs7j5KVPYdPyewt1UwgJMF2ZG6ej6xiSvEo4UzGb9GpQV2?=
 =?us-ascii?Q?WRpsXzoAYtG1vvpC2idTRqwN2OC5R14t4kxyLTc47VJe0P6RQY6xk5QqCeOT?=
 =?us-ascii?Q?JzliWYe2Te0W/r9QkQL5gsCEo0l/rhrBgd/r4vLTJju/8ef2W5xBjUYTwKo4?=
 =?us-ascii?Q?Is/4FwgMuxmkCy9zrTM1JOVIcCbPgnwFK7l0m1bXIGPocA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7265.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SUERKrXF37JTxPTGjy6D/e1J1ud1LDXSMCKu+w2RWopuPxdSwOvBeWmbPGU3?=
 =?us-ascii?Q?XZaofeqElF6ZH2puReP4s6PVBBStF/Sg0pByqk3cdScjThNKFXLHHmimzBs5?=
 =?us-ascii?Q?tD2GoMZuVGgR6UhW2g17ToBGYAymSCZoS+BtZoD8yqMqVMheBdYbUT6sYRGS?=
 =?us-ascii?Q?QPb+Ibqh9F5QDIyPijRKkGZY88+F4ygCvjZxgOjLKRep5MG1UrM8rXLZxdhU?=
 =?us-ascii?Q?DApGRPWOo56QcjBj1nLGf7Z3bgJ2mYmrZH5225e8X/venkNjZd3lmyf33lF+?=
 =?us-ascii?Q?l6QWcEUD7dgxlmF1LYhKpOolUaxegFacwpoSZqphMtd903qrhy+CkZWudSLC?=
 =?us-ascii?Q?nyC0KEvvoq2snC4PO8YBw1o3yrb7JBMy6SrKiOWcsSUeeA83GzfMphhwruXF?=
 =?us-ascii?Q?OeMvIEpkpY/nu8BsmYNzw1zaGuqGGoF8mWJYBJ64IXHatTZZVBAev+l6I5Xo?=
 =?us-ascii?Q?O707IuOhGayZV8EReEnKfoUX/DxCYiJqUt8UpWWpjtp0OSDBnC6mhC0PAL44?=
 =?us-ascii?Q?x3RDlLwVZIrmwO+nNkareoongzgKesaR8pYSS332zWs0ZaOtFOOwFPE4tEmQ?=
 =?us-ascii?Q?bVR2scocNSJUWgtdJ6I5NmK1EtpJBCCViUp3yGQQiqWTpIuDiLCZyzVETIT+?=
 =?us-ascii?Q?xusrw5QboD/4SJHpKD/AFnkSWH//AFmkIWD8YI/y4EyQF8TPW6gX9qJpEUTb?=
 =?us-ascii?Q?yMgaSEhtyZ5yT4GmvyBVZa15Txg/HBZCLJYWEiF8aXY6aFQHNf/ouZNb+qEx?=
 =?us-ascii?Q?pY9AdJiPfwSCBVa6QPUYQNnFiScqfnOEi63uLLNQRUfV4Yv/LLzX3lpMGJmT?=
 =?us-ascii?Q?azvEB+kYK34bzuo/sOZerX12DvDl16T+K+AATkGbac6B9KeNYb1I1ss550Lv?=
 =?us-ascii?Q?dZA7vMhDlNdEqa2hyDH5Qp5uQ4uvDAyppzpB4q0esPlzMFTlrlmg66H355g7?=
 =?us-ascii?Q?KIAIbKJ0KsqfLYo/Tt+RMcC8JX+t+vS6Y/v1RBw3eqz1pxxqw/dkXJDRvCWc?=
 =?us-ascii?Q?iZ3GspxI1UXMyTCofzY8IOizqpew2Bbml7zND5IZn4QyCTmYsN50TZyodK2G?=
 =?us-ascii?Q?X0nYTFRygMowMIKyR7+r1HWTORH6FFrFBKgHDypd+nWtBRodch/WHzcC308v?=
 =?us-ascii?Q?bNT2wLDdVHz9f8SgJ4R2UBOPrTKrqA090W3HN4zHO4FqemVMpIIMdp7cmVl0?=
 =?us-ascii?Q?8TaVicYgHnhBwphu3VU7OWDIWWVdFDqbqeNAySsPhncTCsOPUu2SnWapHd++?=
 =?us-ascii?Q?mjoysIB0QWy1ebvgbwdRpqFcko/1cTuLV1isLdDec9O7S+ZxNuZ9Frj5eNXD?=
 =?us-ascii?Q?Sbxzig70dmv2fpGJsXk35XkPHyDHrB7LibuLAJv33koJi7Xg+mNY6oVMusc9?=
 =?us-ascii?Q?pwJuwbFxRKeBi5AksgV/R1sKPvEtqt2fOUwTxi/CJTKRHCGcnR0P3SFGyI+v?=
 =?us-ascii?Q?IqcETI8b1Rv7XwtpZ2XzoHSGnqH80hg8tQ+udR3k1JsmtJzY8V2sWQiNJr+o?=
 =?us-ascii?Q?v/N+HwC2cYnLk/5n7MMSN5OaJnUp5EMNkAh4DO8208R1F85W0IKv+QSDG2Wh?=
 =?us-ascii?Q?soTvX9T0BNP5BCtezfU4LRNfnCKh85izLR2oNZI/5Fb9kjMoeTTO8HtSKAi7?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LbRzGi8FxRFj3QEpk9D3IesECEPOZUoYw65BhI4xE37WBGVV7SfkgD8y0juChg3Od/j6AFzxZsZ2YtT88wsL9yDw+eemNzCPfavKcjW6VnIEq1ls8yphT+1sapOC78+AkzmLw6zr7/RlL1E5jBOW3njgrfmIdZKPwMc8c+hLM+ZvcJBU2HmkdR2NrvHrMZLlmO9w8qM7hhQu8/CkzKsjsy63W/pOv2REMNnlJ2OF10irWAqiLikSi/+cBp6fkp95ynD+pnbboJEKyghlTgv27kMQd5N/wU8vWjmb7BtQm/uiSV6jiXSWujtBqApEdr/fDSVSRftKTJTFxJsE3+Da0rA7RZ906MV/ixuBMZrhdDA69G5pt39rYhPgo4FCaMw6N3+wC30iVNIaoiSYSXtg/SqmwSzb1BoynVZw4IvcYJe2wCfru/gDoeNKGUbVN/REe/RXT7ELKkL37pKej9D4ox2UMgV1Sg5PEx5o2DkLjPVL89oFavNEa6pwPkZ7ogQJMtdHb+GpLhUWwJj8s/X1RfRrbPc4rQLRS1P2sXJwrp7XrJSbTT0LmcdjdLQrRDY6jUqz9Qy4J2Rcp68tgj0RdzCZUO0L+O26FnYxqDpanjs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7c34cc-d053-4bcd-da8a-08dcb303622e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7265.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 14:57:09.4687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bv7EBJOwF+W4Z7iGSR4K9qAotX/pPLKkatxuHBsRHsKXPJuxk4IIl/PIU2blAzCbCksOKYxN5xFjE7AauqSTUZAaATbQRCAIyf8s1eVC1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6960
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_10,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408020103
X-Proofpoint-ORIG-GUID: yKPu44OUl79bNUPPG1PuUQcVTAAAHm9y
X-Proofpoint-GUID: yKPu44OUl79bNUPPG1PuUQcVTAAAHm9y

Some distros have grub2 config files with the lines

    if [ x"${feature_menuentry_id}" = xy ]; then
      menuentry_id_option="--id"
    else
      menuentry_id_option=""
    fi

which match the skip regex defined for grub2 in get_grub_index():

    $skip = '^\s*menuentry';

These false positives cause the grub number to be higher than it
should be, and the wrong kernel can end up booting.

Grub documents the menuentry command with whitespace between it and the
title, so make the skip regex reflect this.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 tools/testing/ktest/ktest.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index eb31cd9c977bf..621a874b24264 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -2047,7 +2047,7 @@ sub get_grub_index {
     } elsif ($reboot_type eq "grub2") {
 	$command = "cat $grub_file";
 	$target = '^\s*menuentry.*' . $grub_menu_qt;
-	$skip = '^\s*menuentry';
+	$skip = '^\s*menuentry\s+';
 	$submenu = '^\s*submenu\s';
     } elsif ($reboot_type eq "grub2bls") {
 	$command = $grub_bls_get;
-- 
2.45.2


