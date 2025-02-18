Return-Path: <linux-kernel+bounces-519647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185B7A3A042
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDBAD3B6D78
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A948826A1BF;
	Tue, 18 Feb 2025 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ho9rR4tb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ElcB23/f"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A317269AF2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889464; cv=fail; b=nsyDr3aSuh+Xl8OOzy5d8RFAuEs86NG3GOH6aMRJ3uim51B04XoGPxAIJmPwAso04yZVS+oPMjnXjd0LIXXHO9MWwVAThJp1+dLQ/+T85mTmKFtR7yQy9rNmhSy9VMf2JEZKvfSzmcxjT3jEzFdpmz74lr5qSfh54GXIzLoJYAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889464; c=relaxed/simple;
	bh=VnT7i4eGdYhoSvIa5cqYuGssisvjUM/4L1EF0RVPwYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N2jMWVVxrmxNNwcG5ASQSMk92yb2GOUjYineiiG5TuInHkqR4wMS6IXp9/tV0eCUezd0mvyaBtWxtdxYNaHAw8zDQlJEWuflFZB0815SyxResjp7kVHjXGBWwVwjBeHpikkBvXYLn81t2NtLshYb4UTo0vpdKH7J1C/Qj7Eg3gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ho9rR4tb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ElcB23/f; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IEIAgL024118;
	Tue, 18 Feb 2025 14:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rHpEz1rZHwEA4PYg6I/VZibPxudOmq5OGyZwQuFWGXg=; b=
	Ho9rR4tb/TctAB2f5iHAQYZW0cQlvjFXtIW5TV3Y9Vmt7blUhbfWAo0AqR3ogNou
	fhUgM5r/SohhwA4/1NpuOan94W1NGVmg3CyST2H29XbCTYlYvNJJ4cGwDo6nw928
	/JHWk8YXWf9BNbi74zXVbZht/7eap7S+bW9TpSAIeNBuiKNEadV0iBK0w4a6AGdA
	Rx/A6jV8z19DHuvLt/mxx/22nqyXhu4dWKmmZbMsqC2iymXYZHKrgYSB2doNS6q+
	pjVN/wu0LTvTSfNsegRjRR76tDcSwWSUs3ZKWypXzflaEw5h2YM8D8pJe5NrzH8R
	SRbXfQFpQuVZ9f6/pyAtZw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tjhsenyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 14:37:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IEP02S038705;
	Tue, 18 Feb 2025 14:37:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44thc93w97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 14:37:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1SGQ1XrU1cKSuC1IoEi5rLWlmeuoEM3LXsiTnbZTX4yUDJmeTTNqR1H2dr9zqxSW9NFwB5CqYjunbbTMYKrGUJXKUqMUwDMSx2mYJ6zm/SL3jNGmhfd+8nYGLIsDHpr96sqMOutKVOa1Ggrv1M78YSiKJzrpJ7yJbd9yV1P/F4csCXTkDWsUKy6OvnkQ3X6AXstuvREPGfDAl1PaVm2jtMc7EK1OL8BWg/4Ed+jlfyEwtAwxkU5bi/JIchdvg0D3Nzg6fpSZBU3AtUyuC2YY4ufW3OKB6YK2Ne8CwOPq8WrH8MU3/n5A/NHntxZJJZQCz9XJVH3GSA2tP7IfJl0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHpEz1rZHwEA4PYg6I/VZibPxudOmq5OGyZwQuFWGXg=;
 b=tl4PgP9nKaVw3FYOt5RjOLy0Tm2tBG06o/hpwHqipfYwZ6PFhQzUVAu0RfU1YfN+IHFwbgHCDeRDLULseGGBxr9j/w0Z+2k9ozHMyapmmlMKZBSWhKY+8jI2KH6mRT/Qir3cg/Oz3q1D9fT4Tlkj8tx0PN0dpAdMggtlM7tHkHRycgv+Pb/ajklIBTAboND8dXbJUVhdnrBk81wkqoQfR7MlJErKWMgdY/9hsbyQsU49dHHBx4RwKgIKLYUpJD5awcxT9Bye5vIMNPsIB8w8ZllTdPLbh4jIGpWwN/39HJcQYkJAstD5GHA4jsco3GyDE4nz/KCjfh44Y3mKfckIbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHpEz1rZHwEA4PYg6I/VZibPxudOmq5OGyZwQuFWGXg=;
 b=ElcB23/fa1R1TaCrV5IdDVSD5Wu8e1QdNYpmo9BZ8Gje26pU4Z7vbOYLi30TPax4HHNLHxj0MksmF4qixjx04EAyUcMye3jnkVHMFZiKqix/GiBGMOC0bYLSxvF5wQu9SWRyIa5NJPi1L8jLb8djfN5XYRC9VYPkVAlPCa4402c=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by DS7PR10MB7251.namprd10.prod.outlook.com (2603:10b6:8:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 14:37:37 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%5]) with mapi id 15.20.8445.016; Tue, 18 Feb 2025
 14:37:37 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] CVE-2024-56642: Fix wrong fixes tag.
Date: Tue, 18 Feb 2025 20:07:31 +0530
Message-ID: <20250218143732.11095-1-siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025021831-sixfold-geography-c6e8@gregkh>
References: <2025021831-sixfold-geography-c6e8@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::16) To PH0PR10MB5563.namprd10.prod.outlook.com
 (2603:10b6:510:f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5563:EE_|DS7PR10MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f9ef585-4032-413e-0c84-08dd5029ca4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rIwHdvCj9GRMhhOFn2+TSpg80e5RFzIx4cY9JpW62EXprkfm5qEeXLA5DG7a?=
 =?us-ascii?Q?yKHDVr7ZKE3HXzQmr1/zyCPCZNVIZMk9/knXxtrn5EFKrx0FTJRPcr6ORDm5?=
 =?us-ascii?Q?q0HzLtyFvYUSTH75rNvqLmNDv3UG+YNZ90Brm77u/IKsqQ2+w0FX53zRDsSJ?=
 =?us-ascii?Q?N8Dg5dIa5mc2BGqrxGZgm4JHNHTwVqLUeOqycbDgd1EY5ygE+RBmgP9r5T1o?=
 =?us-ascii?Q?uowFe1PFV5WOd2djVShR8VQzrXBtEVBUygnrPkZz+E+UafiV8QzfqZflGyQJ?=
 =?us-ascii?Q?GxESnZOqHiQKmr3s/yivmZNZ1p9o6zi6QLmInYqzugL2lrD9FIIsrp1VPvNH?=
 =?us-ascii?Q?Pj2CW63yiQCuaom9051EJQqBh9VXnJxIkgUYPtQJGt9aT9NbbAy75SI35skp?=
 =?us-ascii?Q?po7mzci3xsP0GZAXal2PGTVf/zyFfKhviJLFuPo41/6orKx19PTbCMKeMIlT?=
 =?us-ascii?Q?hA9AaUXRXWBmUnbONGPiCaq7y8cCBwRdDQpk182Uk0nVJx5u2wQiUXi5zFVL?=
 =?us-ascii?Q?CarnerNlMIvgS4ioWJQ0dmuBJh5Rfbh6Gew+pChXmV1JTNcyeiWBXA5bJbya?=
 =?us-ascii?Q?bHG8GSWN9IDxRkhlpNx2Klm0JxMYT7b2Op8NYaZ2KxKFyze6j85Rzpr+qDaX?=
 =?us-ascii?Q?gAUkHVFhdRKbvta5Ar5L5w814EjcKQ4kIld+X8gSNrUfXgBCNVq//aDC3CMV?=
 =?us-ascii?Q?cdX0X9fmrk9vajLkKjJ13mP/s0R9jaGncO2NoGux0TUsKiUftCveUF6IeDHp?=
 =?us-ascii?Q?zs+rZr3jU2pPM0p9bjX0Izgl/TiX927hZqH+kGs7dUcZSyFYV9hBtiAzoO0S?=
 =?us-ascii?Q?ATfy4DrOEuJmXILPgyz5/UeV1iai0VRTrxxfpa7N5IVwpZwAF8vxCn8MMiWK?=
 =?us-ascii?Q?ykwVcYt62jl0DX3EuMPspzbvOLb/iW6vS0NxEUMXouLk8USBF+p/7wqIKp6g?=
 =?us-ascii?Q?edKcpD7zjoP03MJX0eoPUFFlyJPQWWSvnTk0aMmeMze6+s2IAAfdpwiU6/TT?=
 =?us-ascii?Q?e4PCASWKbrtRxxU8KPX4MNfZi6X+En++sQfjvn45XGV2Vj838m8LSX67eWpv?=
 =?us-ascii?Q?QiVaqtDSXLXPcq0skMo9q66yA7nlJTIC5olqnTCAuwWNuqNxX2qVYCtTWIqf?=
 =?us-ascii?Q?G2fO0+M2+phyxBTgHcR+wkPZG5MuTsmFgIGtC3JtKPRmwUozn3fXAm/fsLnR?=
 =?us-ascii?Q?6zxDfFTHocqKR9Lzp2H4oR8ImJst1A15nTcSdh64yvf4mpmZSLwgOYmVue7G?=
 =?us-ascii?Q?/HXMNjH3e/yQvrdbTD7BJ2ZBPlDh+Ym05j5h4swFROdlXMGOzJ17O8IArL+M?=
 =?us-ascii?Q?YslgxYf+EiSy0lCTMP8ISds1z2Gznp1jgt3xVxsw5JVgtRWs5YR5uCuBLdxT?=
 =?us-ascii?Q?XMiWXUDO9DBEglgzGw/gXOld/l0g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I8ylf0ksVsXhh9GP0if4KNHrUuDmZP6J8ijlYnzBT4YT32uBAfvfuK2hMV5j?=
 =?us-ascii?Q?5o21NWiMZ5+z3k5kWA69j3mX8Lz5BKdrrjVfLs6WRm5uGpsZZ+dxq66HVcDQ?=
 =?us-ascii?Q?T6qBA76pL/1YrI48z2rg38/OK+t4yT7+gHn6GdqaPGLLubAkZsE5hklDLeJ0?=
 =?us-ascii?Q?f17EfW6UHNdNFR486dnquA99yq/dvdGmbfMtmuOJzCQSfpHGKcXkSANtmZOI?=
 =?us-ascii?Q?WyvEHL7rcg8zLcgmqJWA9//Pm0dvK91OOxfbt20MLhUQjhlow9oXhFkY+q7q?=
 =?us-ascii?Q?9IyKQNL5pmzMWWYOBDF8O2eFcVraOO/Vl8DyXLzQMYWU3EQZahA37IbEMRoc?=
 =?us-ascii?Q?8w8ZStbY3uqnjXdEoNmkoD1PbzeHk9X9aq/BrpVsynx2evfTtgc0zROXHcqv?=
 =?us-ascii?Q?NJpyrwKT84pyHs2s41+TFZktl16vfRP9yUBSrghTS5ukowSlrIqDegr0Khc3?=
 =?us-ascii?Q?Iq67fUSfr6hxOOVus9ctA8iVMaXIAaLIBPF8FA8hM8Pe0CF7YJd10s6aAWou?=
 =?us-ascii?Q?zHnfhwnJVH3/4WDD2i3qXGERy8a+CExfqExw0k3LFqerWin+pR1S6ZObZeRP?=
 =?us-ascii?Q?AUfybg52nrh2KsuMigl/HJbaXY+1fq5lGoZDCVq3F2pDljWmAOQsW9Tz2tJB?=
 =?us-ascii?Q?eYc5qN6sI0U2ljsox1w9P2pzOC1VE8DPTnjXPLyg4SW10RKwramAOB90G0Pd?=
 =?us-ascii?Q?+31zLOpHtHAEG/qR+8+yfjPdvMUH73/lPVBFq2uNFJxJcfZHxGjUht5WbxC7?=
 =?us-ascii?Q?kzgPv/Vsa06LoDBBffHYM/RVFqSUqCMgp5C1gm4e3jLN7sCMr7bIyPyRXRYU?=
 =?us-ascii?Q?35sWNyPozuRNJ8xQbAzP8L5ILAvMT/n/y1CvkVv6syPlSQl4uz6XzoK0FG8T?=
 =?us-ascii?Q?fM7J+qiX/6ZxQST9zzlSVaDCHDpsb6BKZMLpna72OVRZ/p0c44tqnJDELGu5?=
 =?us-ascii?Q?jeJJy89oQJ5AHdtIvBcOptG3pHD+MgrPQ7sSG064xdXDjKnWPyqeJ3/84rPE?=
 =?us-ascii?Q?TZlauDcOOj3xZnFPuJte/GgJXubSJ7XO7L6m8IrSnzpZhQIFEXIioIDp+ByC?=
 =?us-ascii?Q?6yPF/h/aG1ayxxvKONUcU1sRqC2qO7btoSFCW3qy8qf2k5D2Gj44IAnUu2vR?=
 =?us-ascii?Q?g99ounHYMCawhEJWZUWBcrf5k+Xg9bbPPWBKUE3h4L/cSxyt8i9/aTH8PfJF?=
 =?us-ascii?Q?Cl2S9eowdEkp/Sytuh9Ffy+3GTXU4zy3uDFpmjMtsZTSvvf9XN7bp6mzNP5d?=
 =?us-ascii?Q?/sWWfoLnH5N3ry6ndQyIRb4VQuVe2W/m5237wD0yaUWUOfJpHVseG7LsosS4?=
 =?us-ascii?Q?ZzpOxASZyinDTyDsTKv+pwBNaYOmkkN4JSgg4j4Hw9gCUdv5GuYZiVGHSaf9?=
 =?us-ascii?Q?5+bXjGeaoDkxW5/BgvvTTendBjphiAn2Z6tZwwKkVk/uvL+aP3uxi9bCDUlP?=
 =?us-ascii?Q?HSvT/2VMd1h1RHnXHTuaCippYQFbz4/YxR6nG8/3Kq0k6ju5XT9CIPXCAcfK?=
 =?us-ascii?Q?SHLsTDNhRu+Zt6JbqGDiScZ/14Lh2aX/MtT7WfivQtc7DDa6vFB6LoC9l2nI?=
 =?us-ascii?Q?DtSLcCSyV3dkRm27+fVSe5zTjRf4DEJAe4vKfVLcR4iAqqEXalAgqsnVjjWw?=
 =?us-ascii?Q?JA0E0O4PTeEdNMHK0LkBPWigSBzI+ed3VxDHieiqFuErThMmJR7c5WXMtg1r?=
 =?us-ascii?Q?fZoODw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TGhoXlSRySLHgOt1A43IGWio03NHRZzMZu0V5v6prYe3JXgRR26pQKIRBD21oJO8oUA6Hw4CYCYBirT2iEpfL1wBeKCGd+7A8+siTcS4x4dM/njgCJVa1q5T0jZBpNpYwyPYhaakzHo5yzimW34gmItSMFng40tuWvplJaTB9sbrRuHn1ThUpSRnY7+j/6vZv7h7lWDru0iApXCLyJBFk0K2K9w8C67XBG5ehjXH19vEB2+3kjaCFjPFzfLxL28DOdupItu1BCAG9BPlDloaxBVXgq2EZNtJyly2cNrUHRJ80oQJ4VnardI2dz0AmWuVaziSX5lQUKXduFLv/n6Vfa8098l9nLTaGsMmU2rj8+G72cPBzH+tOSolUA0uDjClO0STHZfuQfq53hqsxwsLon8z4IvBKm6rg1oQSohIsM2dHrherAbNSux+rrEdZ7XOeByX13IqGxFBgFfocLci37cw1Z15WcxOWpLO3TjsLWVGsuD/ywLxKh6s5PC0VceqS3EWQaCdSbGNZxeEb4bV0KCycFw09EInbClX4cWOpY94cgoGD8LQdjHopNd7/6c0uhKbjNyRIAPu8m92QxDW7gAkQ19w/XFgE49KLIIMd2o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9ef585-4032-413e-0c84-08dd5029ca4c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 14:37:37.6092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6eid9DKBHig06zIeB1oM3SACrk2AtrltMa+qDKm5OJgLAYFtRD1TOZgTrgtosu1GwS/P6rHB12oAtDdJp14EBsvdTYhWnudXp3ROnQMmyZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_07,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502180109
X-Proofpoint-GUID: B8MDJ5RQiJ5EIHZUiSRJQIYlOEYN9PEr
X-Proofpoint-ORIG-GUID: B8MDJ5RQiJ5EIHZUiSRJQIYlOEYN9PEr

The fixes tag in the commit message is incorrect. It should be the
commit which adds the counter, which is:

04c26faa51d1 ("tipc: wait and exit until all work queues are done")

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 cve/published/2024/CVE-2024-56642.vulnerable | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 cve/published/2024/CVE-2024-56642.vulnerable

diff --git a/cve/published/2024/CVE-2024-56642.vulnerable b/cve/published/2024/CVE-2024-56642.vulnerable
new file mode 100644
index 000000000000..75eac70bd13b
--- /dev/null
+++ b/cve/published/2024/CVE-2024-56642.vulnerable
@@ -0,0 +1 @@
+04c26faa51d1e2fe71cf13c45791f5174c37f986
-- 
2.47.2


