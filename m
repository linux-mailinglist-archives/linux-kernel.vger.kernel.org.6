Return-Path: <linux-kernel+bounces-565315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B57A665BD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD203BBC6C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5101A8409;
	Tue, 18 Mar 2025 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LB7wCTIa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wxtHntEG"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785A318A92D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262473; cv=fail; b=jiAFdlqLkenz++oN2tv7d+Z24x7pbsiTL2O0/36SBBwNJZw2v9myyI3+RW93H6AMMh1awrFrz6ErbVh6BH2dxxFs/HJlbpxZgU0Q2QRDuTJxBy5F0x0bgj1JLIg/AnSEXIQj5aes/aRGup56KRIo6Z0sO3lcMbl79rlSSnpRSLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262473; c=relaxed/simple;
	bh=H1i5W6HhnD/QWPIuPpNJVqDx64SQeePi0uJ3piThicA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KNkSWOYxzjnuMr5W3QYfT2j1egq0dDM/PrawzV9+biaj3W6vVOn57EC2ADmmdt/f9nPv6xRdlAsPK9dacofPK0oliAXg4nt7CZ68CfFXZb4VXaWhcFsLxLvy04iQN4TeXlr3WLn77T73yt0Imm9OjSYktxZWBv368Jqe7Ctm6Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LB7wCTIa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wxtHntEG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HLttQO022521;
	Tue, 18 Mar 2025 01:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=oyNOyLK1+VvPmTDU
	b9GF9He3HvKCw3PjjaDcdth47RE=; b=LB7wCTIad72L9wUythNAK42B04qLTlwb
	HEm5Q3urhno7zH2ekrdiN/57Lzr1JUlwrRfGrbSIlrT3iCFve0noq/0eQ5QdTD6r
	De1OvUVo5rkmVvlrRGiKW13cznkiMglQoqjx0cdyTXcJI+pugBvJTqn56ZR7H65a
	k/fMLyHU58ZhrnjN9FQ1232WBFltzJqRhg+RXYNUIxSjOZsN1NxFVlT6H7d6qDVj
	UzOzqMTEU+02H0L717rGM4dWXMYpJvIOzJIicko7VfihH4ATiNOrdxf+K7i5P2cK
	BVrht41AybIaulaYsU1uSJTfGhr1XqU16OTV9AccUPxwOCngIAGy7Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1n8c5p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 01:47:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52I03F1U009485;
	Tue, 18 Mar 2025 01:47:47 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxkxxtjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 01:47:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3PP0oykzE/4BLbn/ZocL8b9Bk5NllaAeaBFmTZqox9W4mq6xdUbOadXlGrBepQ6WUuPcQgIErzNrIcrg26JA/uMAzTvH7NJP6/6zDBJ+aa3KMScq0Xk4Q9e2EoyU6qgg7vpOS/bKMiHVyi8r235PyQm7jwZDv5zlDgYMKFlVxDMCzq9s2x0OfnQCQQ4qn9DDTwQBab3KtfmsLCoHWx56taaybeK80jhKDXIbmr/nQTT1BSv4m7Advj9CfKvyGQFcI6lbQv+SsheDp5iJc3w+YCIKbsfQBB9o5qzETfeVoualHRIjMN3p5jfr6feiRW1rzhxaUh/syxbvYflj6peBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyNOyLK1+VvPmTDUb9GF9He3HvKCw3PjjaDcdth47RE=;
 b=bZvB1PThUVPkxB1X5ZEjbFhEijG8VTychq9jOATdw5j9w1cwCIlxiyPS4mdKpQGcV0YVvBiM0BByN+e9k9rodL9fGMwlu0sg29gcT+fH/PFS81ph6Ip1Nha44ICfvf28LnmvAhWtZXrLlslMnmjrsB6hwrfseKYvCKj3M478OS6ct+GhQ/TSr4Jy7fGBdyeP2ZzAB+kVE82YpO8u2KCLtgpXr22NHJzxDjLK6rg4hb9+IuoCSVbYwsRFnAD5Om756Ae4U087BPOKyqMdWsvo9lSCgGRCWexkTGumJomJQ8zjBS0j1Xo39Ag0GYAcD1Eapw0ka3v7rSP0iuo3PgC0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyNOyLK1+VvPmTDUb9GF9He3HvKCw3PjjaDcdth47RE=;
 b=wxtHntEGmgjQyy54AOWcDWY29fz8fTIZYotpKNC2Lp0RcJbdGZlulJfHpfE2rdNThX3BeDYn7483Wc7gV3gxP4FEivXlFnlQ2L+oieS2OZk+7LpKCcWK2yENC2krKbeKgv+LMi+UBGQq7AiIZi05C529nkFA2p+AzAW3Ad47j0k=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW4PR10MB5839.namprd10.prod.outlook.com (2603:10b6:303:18f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 01:47:44 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 01:47:44 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH] lkdtm: use SLAB_NO_MERGE instead of an empty constructor
Date: Tue, 18 Mar 2025 10:45:33 +0900
Message-ID: <20250318014533.1624852-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2PR03CA0019.apcprd03.prod.outlook.com
 (2603:1096:100:55::31) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW4PR10MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: e29875dc-14c3-42c9-0c50-08dd65bee096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EeTYfZDHYlSsBxx8JrMbR2c3H5arJ8Zbn96NArA9DtVdzfVi/wZm59iRUG9n?=
 =?us-ascii?Q?A2z3fMG1C0GXxmBtZeKk5pN2xqgSYhR+mi2FImERxe3aorpSD3B2FFzxXXdJ?=
 =?us-ascii?Q?SCDoRXPZccUzeEpQ+yA07NtOmBhpjTsIJ3v5bClLyH2TzjEB2fbn4l1jqLCO?=
 =?us-ascii?Q?PWh/QKBWyJ+b/O/xQuOwWdVF/hAQhf+oZ+AfcBj/dQo+5mLee1H6F7LUPJvq?=
 =?us-ascii?Q?ZcGbm5lB7CJdomSvCVJ1qBSu1VaEBa2vlHIxh7xZ6bcflUDsGyWTyi0njftZ?=
 =?us-ascii?Q?yRO7YVR3HnsDztzP7V747aZY0Bur0qOlYPSXAq+/yba71WZuYnEP0+MXbDkw?=
 =?us-ascii?Q?Rwu3QM/89cGhx/Xx/8moSFdmxp/9g/DYTXziEF01qw6GvQabqdz+FpNId9F9?=
 =?us-ascii?Q?oj7GT/1g1aKESmk9EVcIFdjFSxRymoS/ckSuS/nrDGh/TVCR6LNtqRSQDWko?=
 =?us-ascii?Q?9sqMAlKsaFO9vK/6rw3XDYvWnZ0e9aqXwPLZK17LzBeS0ywY+r2YVVf7S9Mb?=
 =?us-ascii?Q?TOLg+GV+puJWtBkjXUHR7IWejGf61NUkKzedpneCuQMRzpb2XSfukq17Lpc8?=
 =?us-ascii?Q?hj030c9fGxexvYv7tR5yYFUzdmXuJb3cPHrPy9PjQz/02MUs+B6Mh2A4LkRI?=
 =?us-ascii?Q?B6W4hhV8EbpXapkKSdGwydJQHoPwTqD+2GWM48TLFBGeCs3R+UT20VDJl4ys?=
 =?us-ascii?Q?2eeiSXzmOleHnHZASt7SpyUWpw4rdxcuRSqgW4h0sCJHYInIFKKZustc0A6f?=
 =?us-ascii?Q?APZcM4cDk5P7sdP/xfi5Bx5TQeTWGTMn4DmaBcbLwELAFwqitz3IaCkwoDkZ?=
 =?us-ascii?Q?ex7ezuNqlu5crWuLGoF8OIy2dT0QxY+6tZKAck8rs4Uv+7hprA+8iSVjKjU3?=
 =?us-ascii?Q?RCfehxDobVQLgJWkn9PkPvfOooUN19yIAlC6H4jiyuLZjVaODsZQV5eNgHMh?=
 =?us-ascii?Q?7UC0u27CTWgjiksDnHv1Lz5GxgAHjZqXL9xHFLVIUI62rQ8PitKTbuFh9TPd?=
 =?us-ascii?Q?s8WRc5yvbDeicrUePTzVgEKloxl24KtVizYzTkIdPXJwubkQUxkNZZmItgVN?=
 =?us-ascii?Q?OV8OBZXEDeLtGAqnY4GlVGvYmsgiJBEzAmJ0Qd+Z7noMufS8IPeEmXPw2Oaq?=
 =?us-ascii?Q?9hvU6e6EAIrgP87vNcegUIWfbyNl7QJDoqpWWrgOHOejdKYOjGzw1fRdcoWS?=
 =?us-ascii?Q?JZVVq4fgIIFMcSyZJbeCFdOSuWCTys8HVe57VzJKbFZrMaMmbbYYcBxSWAkd?=
 =?us-ascii?Q?EwxLzpNh0Ji5LZ66lsh6Fru+debFj/MEOF6u2DTTMsH7FQHyJv9DquUMVHb2?=
 =?us-ascii?Q?T8EEpCaUs0qkdCBaxE0sLQnVSHzHxe+nOFDZ2b+W1b9ep9szNn2GEc5OaGN4?=
 =?us-ascii?Q?OKcXbT3AgaWaAtUA7YYDtEZtgUjk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M133RHs6kquySavJsqc9iXz8AArprnpvTW6EMSqHBgWDJiHNFiPhaNQRJcQu?=
 =?us-ascii?Q?BOVvlB8CMrCEaeTTLW3If7Y26IH0vo8ZlhRcT4HOxfLRh+M1+kkt/jBG8HUT?=
 =?us-ascii?Q?DdG0Ud8DyZny7S0Xfffwc7YchxR921QvD1vHtPPiigNfdUFrhBqHwSMiigmS?=
 =?us-ascii?Q?RVX+D0BgLNxn83M0emI873cBUpSnFURgZY5x/uKKNvMMTg4ZDQmNU18SjT2s?=
 =?us-ascii?Q?pPirl/vupkkQeqF8iGGt05+s1umBPhyFO9WaxNTOcHfbbqAcPsXarJ+ON1ml?=
 =?us-ascii?Q?SwzHbHZiv+9WQAmB6IL+aanqYUKhDU2kpZbCryBay6ST6Y4yR8kWwd53KsG+?=
 =?us-ascii?Q?0r0Uju7TmUpLchFFpE9u9+UjBkUPfMDgX1DP6n9paHtmI5jskUIAp99do0Bb?=
 =?us-ascii?Q?0DEaHZIdRZPwnZHlyVRIENbmh53XUZ4ntoQ+00OnANm+152CUXWhuKZxB8uW?=
 =?us-ascii?Q?oM22xu34pRnVTklpfbdoT5YhdG5kDmrzcnZkcy/bmh6GIf30qO2ApDl5o+L+?=
 =?us-ascii?Q?bbaxgahzUbpC4HR9A1U8fkvTerknAtbp+7p00CR3Vev1/lUMsMyW+GykBxcI?=
 =?us-ascii?Q?mbfGmRSd9NX0tg04E7HICtsLuLHiktTrKV+vKTm/sMLrIPMYBh32xNwtxRsV?=
 =?us-ascii?Q?mhAo6HisiK0AofbEw5R8VPIeOGQavI2Hv9G8cU0nx8H2QpHksHKc/IeXixaM?=
 =?us-ascii?Q?2+8AeSVu/aTie2KCYksYHI5GhBhgLSJ8iHP9/lJ5W1Sri7L6LTvLesk4vzqa?=
 =?us-ascii?Q?61Tm+TfvO+S3sLYXEx7YzmqYPoZkX2Mf6cicLqtqwYSUgO99+Rl44zzqZxG8?=
 =?us-ascii?Q?IniMdYZVjW2sBiRoZL3oMSygVTObmPz3j2DhqQ/5Tej3vbRP0iNDKIwz4xuY?=
 =?us-ascii?Q?8M+LprCOXOfL+/NSA4yfCHUBVkKfpeEt0fS0kkNCGpPd00mV7tO6sR+OAivH?=
 =?us-ascii?Q?/dKxdt4EU1FrNbi+mWvndsN0pR1hDQBdX9UIN478hFuF2EaCUxdCiKy33ZpO?=
 =?us-ascii?Q?Tl1DQMmFG3yeJL+dSLaHIlliACFDfzbTXeS1zndx9C9TTzj9BFTRq7JSuxa3?=
 =?us-ascii?Q?ct+YNHtzcbRJWWcIzUNsQFg5zFTTJTCEP5FuVKXKWTFWbV7VKFZY9G3AfCKa?=
 =?us-ascii?Q?fBCNUapVoE8m0/ke3I9brAwEEbaOCEMl8lXXzQwyAbl0fJHt5bqlCBLrgMbO?=
 =?us-ascii?Q?Oz/6Z9GGKaQAgZKZF5oCM26JDo/zy/uhWCrh9V4/UstK1kFZwM/B0L+4cxMR?=
 =?us-ascii?Q?/g6N89WkrJkPVUshrirdFbajnAR/94RBUQWaEyUO51hg9DDoGHvT6biOQUpf?=
 =?us-ascii?Q?UFDLFIpG/GDo39yZp4HqGylYCrrq+f3GCMUzJSgh7Y6B/ww45sbGhplpwXjr?=
 =?us-ascii?Q?dIhcyXn73a8zWn5i0NHjrtSl62vbLAier/FJP7H4QhVkPePT93x4JlEm/Dl1?=
 =?us-ascii?Q?Q9INLKXs2zWH2I43MT7YCBOP5iNkbx1xjxrF0YHPdv4kTvbnD4OKGaVtvLOm?=
 =?us-ascii?Q?15Zk0ZEdv/WcOJakOQlxvC5DX+7XRRjDfVwyGzaIXEk96PbWqPJ0yqg1prO/?=
 =?us-ascii?Q?/vwlFiQebzkoufuAY04CTyvyCoGRf4ZPUdvo4Pzx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F7p/gSXV9goQA4NHx6xf3UYy3kMF2bdAPDZruRhhhFdoqPrjZzJr4RqMt3p7gg38n6PNvsb1GYHiQlmQCkOkGwf+3I9TI3DX0pRhfW3VWMQrV5nka+poqOw509AWPuKHzLuMQaHobemVXQSUC+nEcFO9fpd7lDLDjvD5wfceHAwYLAL0XqK4ltZ17DIqToNM9w5PdayNp2We4+lHPaSx4mZ3jmu2NLYHT2+dMevBjZe8vxvdxFecCUAcF1jN2zAg9T980SKKTRTG7JR7iywXlgCsT6KTUAh/f12c8rrGYrKSc1BelhVU6KWLos5443X1Vcb/fLFHvPeGhp9RJgAZT0GztxJrXpvHQolGNMfhryT14NRsThl73JG9AEkT2tuLU8Ly0c7P1xvsBV3FzWX61NG+w5zZKbrqr/GjaIUEKv514qfUl/4HRDnUtr41NOsoZXXskFdqLrH5E+8Rx8XfPKqxde+MCp+1WWle3fYAqnmginVMr865DHLEAH8uMHXGmVnwqVTlZUUsdn9tXuYzNEQET0WDsX3vEiwJA7jB0OSgCYqb/0BLzjbBbYlWOBuKTpcexDBohl0hSKUE+f0DvHWMmmWGTqMv1qJs2I7//7Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29875dc-14c3-42c9-0c50-08dd65bee096
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 01:47:44.6002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCeZQkKZ9c8PyVBmTHwcJSSjCNi0SkoYrlWfVDZhQbZePh2oivsmvxJoOdcW/LVzhMKuaSKjlgmKsXGTgBG2Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5839
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_01,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503180011
X-Proofpoint-ORIG-GUID: lMDUVig2Ovu1jbJP6cqIgMeUQWMeZ71Q
X-Proofpoint-GUID: lMDUVig2Ovu1jbJP6cqIgMeUQWMeZ71Q

Use SLAB_NO_MERGE flag to prevent merging instead of providing an
empty constructor. Using an empty constructor in this manner is an abuse
of slab interface.

The SLAB_NO_MERGE flag should be used with caution, but in this case,
it is acceptable as the cache is intended soley for debugging purposes.

No functional changes intended.

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 drivers/misc/lkdtm/heap.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index b1b316f99703..c1a05b935894 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -355,23 +355,12 @@ static void lkdtm_SLAB_FREE_PAGE(void)
 	free_page(p);
 }
 
-/*
- * We have constructors to keep the caches distinctly separated without
- * needing to boot with "slab_nomerge".
- */
-static void ctor_double_free(void *region)
-{ }
-static void ctor_a(void *region)
-{ }
-static void ctor_b(void *region)
-{ }
-
 void __init lkdtm_heap_init(void)
 {
 	double_free_cache = kmem_cache_create("lkdtm-heap-double_free",
-					      64, 0, 0, ctor_double_free);
-	a_cache = kmem_cache_create("lkdtm-heap-a", 64, 0, 0, ctor_a);
-	b_cache = kmem_cache_create("lkdtm-heap-b", 64, 0, 0, ctor_b);
+					      64, 0, SLAB_NO_MERGE, NULL);
+	a_cache = kmem_cache_create("lkdtm-heap-a", 64, 0, SLAB_NO_MERGE, NULL);
+	b_cache = kmem_cache_create("lkdtm-heap-b", 64, 0, SLAB_NO_MERGE, NULL);
 }
 
 void __exit lkdtm_heap_exit(void)
-- 
2.43.0


