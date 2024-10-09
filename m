Return-Path: <linux-kernel+bounces-357545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 667FF997264
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC3E283385
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06971A254F;
	Wed,  9 Oct 2024 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Eecx3HRN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oIy553NZ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620CE19CC3E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492885; cv=fail; b=TzTfS3v28Kxi+oHD8XB79xMZIt80Wf57S5TbgTE4P3+owOQ9ziX/fZFNJZVgKitX9j3VJlKztT57/b0+dmSfzWhz/zB6BLKwDXL93oe4KyJeGJlfauusAoFO+edxx0lYQ7X4NUeCQSjjQc9M1tXf6OolmE9CihqRO68gK9o/NIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492885; c=relaxed/simple;
	bh=RJkbHfrS1G/TSSznA1a1AB3oViVqepg4+epkEf3q+B8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=si2+FYx8j/653qqn8lsuqaz4J7iC4bB19uhNkmKbOgflp5Pva4sqZmztbYRdDlGIGGH8BwIg80WIqgqymVntWCXtEuKpYPNXJlIZtkYfSBDYTc2l8vqYVyTx2xjgflTJw+9m5mmpw0q+WzL/Loq3R/juudo5UL/J4Rrxa6FaUa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Eecx3HRN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oIy553NZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499GBboP017444;
	Wed, 9 Oct 2024 16:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=AAW4gIG0qYgTUYEAtE2qco7tyQ0umIMEtJ0iXaHI+GM=; b=
	Eecx3HRNGPA85ya9dkrKkzYDhD8KRrBV2dJKcRzht4Vr74leQvcpjUw5LW30SkQU
	S3RJNACbVG3OwpL/vfiUyM2LMRLwk7BNPduL87koCYLWpQ8Gfwys7dSfMWfjow5L
	HLDj1XbWw9IdyiiQq3nE+8vekR0K/b7FVeH8P2Ih/ukw+hN0cyh+iOFcPT+52nyK
	EVYIF1IqgHGglmAvNKqX63pt1M1DC4BvO0ZI6utVaXrb/lRaWTgl3l32z2YaYvfl
	zJ9ShQsWHKn8M/4O6PeM8R1usXy2pllLxo1TzzowmHJ54iFTbzHigMVL+0zSqHCX
	VzTtIGNhrTo0bBCATX6uHA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303ygst3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 16:54:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499GqMuI022903;
	Wed, 9 Oct 2024 16:54:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw8vdt0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 16:54:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdjINULjkn0B14Bs4BhS9gUb1xcMMOpBVg5qiArLHtbnv8laSoBlbEwu9CH7uGZDfSKqw67QbMTBOwf8NqpVKMbJ8nmXSL3cJqg5GU2Q4Vk80nwCSYlBnh5rB/OYqZDgsGuW3GrS2naDpfeAObe7Td9urXbP+wT/5hTmoWHi17hISKgokqmFTp0CD4w+9J8aDCAdtRR6b3inU33j7M4Jy/fqXq1ltV4WKFkbSU6KCdfcmq62bVHzq8/tDFS5BBHV/b87ERhC0VaFpnvTwDUHt/Zc0szXOb0Ak9/Bh1/Tj6N6LCfiRz1Wbul8b7fveBrbpLJA7hG9DnSwhXf+8dz2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAW4gIG0qYgTUYEAtE2qco7tyQ0umIMEtJ0iXaHI+GM=;
 b=vwa5JNpn9vB/QQMWEk+2MIQjyIKMaa7pFB2McHBXkqAm69fgIgTadoB5HZ3dh+ZrtEgZNsIz3dkNPcBpguuq896bAZV8mJGGVp2BtiR/AXrGx5v5Aod1vnv94pSINVdBiMPbalhbRNilBqdPdJOqpVHoxoGwf5FEL4AX+97emBjGnSIEda2EdO6Cb5XIiIzXoj5X/yAji66+r52LOpdh4SDKYKvZBXscF82JXIKq8qssQyFDxUrVneoxU0G0h/3VUsi8orbNRNyOYvbh/NeL+WYqnlPezQn3xZwtNSg9O+F4GB4X5jL5Cy3S59sKYpC9IRSeggpi7cNh9dPHs13QVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAW4gIG0qYgTUYEAtE2qco7tyQ0umIMEtJ0iXaHI+GM=;
 b=oIy553NZyX9e+ZmT3srn2jIYndZ0VZflGN9FLr+izEAy8mKcnponANVZM1XhEsX18aSjIw15Dw5TjD/pfqTg2PMf88oAFzeIuL14Xtlb2ocJtW/Q9MaRfb8s7CgVsv6Qc+l+prKEmAppbpVbOsG2Yzv+URS7k+K2PBWXeZ4z7Xw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6585.namprd10.prod.outlook.com (2603:10b6:930:5a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 16:54:17 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 16:54:17 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de
Subject: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
Date: Wed,  9 Oct 2024 09:54:06 -0700
Message-Id: <20241009165411.3426937-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0145.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::30) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: ef938b00-6522-4758-799e-08dce883035e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ivA42kzOthI067pSJgzPLndWE3hj8lUMNoT7UGow2wHZsOQpcZg2Jag/H9uI?=
 =?us-ascii?Q?hXPZgBc99I5ZEV8BVdkGfMp8cizHmPJzpiAyNfdKG/nowJMEDodZHn/hnwsJ?=
 =?us-ascii?Q?rjuLf3tXwf/7DUph08WLTuLG2wtNxKNo3WgQbHtw8PDQCuR885PMx17hcBVF?=
 =?us-ascii?Q?V7Q2Hm/0It6/iwh5f0hnAEWOt7aDfvZFnm7YVoAVIMUmI/3yadPuoM1OqB97?=
 =?us-ascii?Q?Wcf7pdfYeproFV+4PeijXhAhzhLwsQfIXlLtU1P5jE5vaG5R1qDwHCw6aJal?=
 =?us-ascii?Q?4yLds8OBktBOzSZLWO4qJENwowVtLgSgqvOZj/p/JuTNI4ZtOVRaJf8HiZ+h?=
 =?us-ascii?Q?VbCqxILB1rQxKWm1uFZwpWqxhJzW3+9X+S2i1T0mNmMgGH9etTTXFmo8NVkv?=
 =?us-ascii?Q?v/iSCXJkFb0uh9CViTleA1jZmAYYs5kdIw+dIRRmYABr1wYPZWswQosRoq4n?=
 =?us-ascii?Q?RZOtQuni6mphdyUUs9GakjJZipVnP1AVnSPgoTS3ZpQpsj/MdE4iOFT95eg+?=
 =?us-ascii?Q?BANp6XHhYYbvFbvBs9W6Cio2tb9y31GoYQUg/zn9aGwOXk7Wb1UkemAAFZer?=
 =?us-ascii?Q?oDN3BkFmV3boNxvCwU3QYwdsIin+QkGN5uAcdER2EVRutmtA9mhbMRjeRnkB?=
 =?us-ascii?Q?vNH48Y8ti6MmoE2YwAi7g1afx4IgtFaYlEVM9j+TmImWHg/XFLcezlDwgUTl?=
 =?us-ascii?Q?5/1EpDSP91AiH09I6MsDiWC/q7piEq//7PivwsLi8YgoAfBD4tI26YmYQhom?=
 =?us-ascii?Q?d8H90SwkY523qrc3kUXQv1J3q5ghRJ+2bDJHcLzHldd7t1nfSK2bA3fSLwh6?=
 =?us-ascii?Q?cRQNSmRaC33xF4QjUmpeX+3r/fbxBCHsDUcW8wwtK41QreplHq0BLFgfBkPJ?=
 =?us-ascii?Q?Fe/+wynqWRABC2Al5LrncS80wGAP4qP0SqO2vpfvBMW1VX6ZfR9uvF8wmcGH?=
 =?us-ascii?Q?jXXUr4t4WKJZgZ+n7Xc43m6FNjcOvynVg5wilztjnUfhMypL+2s1ixMTAAhW?=
 =?us-ascii?Q?9cITX1Q8XjiKnaUrIHBlFYREb25hwj/PCv/cC2F+uppZgxpI/2AnJOq6yPh7?=
 =?us-ascii?Q?CQd6TfU7qznnHRI1M4BImyk0GP7lErfUgfb5PLwMWSKuHusDCImNirIA1kvS?=
 =?us-ascii?Q?rm3GjxYPJ8wg0Gcupap0G+toIJ9D2JtnkMRXs3E/j5jc6cVh3KeToy3e9Yva?=
 =?us-ascii?Q?GapgHdYEBsnxjiv02uDwVr37EjFHf28TN5opVw3fjrA8b8fq4VN/CwXS9Cmj?=
 =?us-ascii?Q?F60CMuMIHyN2VBxi5N48av9MABHlCRqz3dFq94LWmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CsHLMsOeA/d7x8r9/tK3Gz/+WROLTXMJ/8ROGNCwNuBexdAAnB0gPLizH+cw?=
 =?us-ascii?Q?m1epbZRNhIGVG/maoHJwUj2f4lbjbZfiW7+4B2ySrhFkccs6GlGbCxbrARJj?=
 =?us-ascii?Q?1qr7nuBCCFm53i7p+o/+A3ZO/6KTP6aH45eDZ2JAX04yEVzX8aoGeVzrFLGt?=
 =?us-ascii?Q?+Q03IuHq6vWK1QhiYrfUxcM3fuWUQag5veS8P95/gI3Xm+SrNmH+9Ms+SbJ5?=
 =?us-ascii?Q?R8VsnRyj+u99EpEymenSylGHV2lDmkxvBU2/De62S0fqpO02p+kYqlr99GaW?=
 =?us-ascii?Q?Z1jhAnyCeC94orux5t1W4ARR2g3mzthWXFb9OFdgw0DBrXMWTYRZS0+u9Nf0?=
 =?us-ascii?Q?efIhGS+qN59vSVcIm3i2h414PCu6CR/0lSGiz1igruc4lzYrWMSFhl39O4p1?=
 =?us-ascii?Q?2oc6WJrXZ1hsCoHPgvM6m85edwhc9YyFVyF5WYLSiaQhUa92tYPRKs+f6t+7?=
 =?us-ascii?Q?YESxovR6k8vs8QBs0MQNXT2mhyJ8g42NWYyXhD0S3iX2/oGJPnLk1Jg/dS+2?=
 =?us-ascii?Q?O+3QgltoCuBEHpx5i+LgvyWcZNG+iD1QnFpFVi4bRRBSXNfOfbrVEINPwYWV?=
 =?us-ascii?Q?4eotZINaH1AK7y/QmtXbLMU48g70yuGuQwe9CLIR5cB4Iqualg/9cYJnoDsu?=
 =?us-ascii?Q?yjVeSC7HUAg8Gwkm9BfNxjB6meLZgZAnT9/XLN+7YSvoLyIHLJaWNr8f6RIn?=
 =?us-ascii?Q?+xeqp6idTLzCtrT//wMh+JtGh9ERsE07AjOcvMRxYIEXLaom85tPQd/xcQHl?=
 =?us-ascii?Q?Ia9ZPjiZZVEveymTSButAqY03wm5Pwee6d0l8Ubl3ZJIyJnS/xlm5hpdlsr/?=
 =?us-ascii?Q?KJOBE+cULvbg87m7DpTT6OzwABH2mv0WQKV+P5jZQJYbxQOekfUYeRmMyJFm?=
 =?us-ascii?Q?YH7x9TRQK3EhxBlxUH+JMR8Fsa3QlnyQsNhGr6Rh81qiJ3PYSqh8vAPwhxyM?=
 =?us-ascii?Q?ZC5lAFbQdidtnnBTZrGmOg/usJsCHeDrs1UhsD7rR+N/cuXpvY+03Qmw4hbC?=
 =?us-ascii?Q?X5Y0nUeK9RK8kHwmKh0SEjgJPEfM7fP7htFgsEXcoD+Zm5Wlm9kv+i4qr0rd?=
 =?us-ascii?Q?yGXRoJbeOZykz8AChw3/FkeKao1oHazZXJbsTaXJAvIdQESsGaP2vlrVkwrR?=
 =?us-ascii?Q?d6tC+rMXmV56aTKu5XjRjpUCr4kH+MJDlOtFa7EKisR90Tgu0jOGsdTOAlPE?=
 =?us-ascii?Q?gn3mMbIiZWocH3849hGs3IJ0ldZTFeG4oPuxhn/CSDi7+qQlh8YDIh7MyHz6?=
 =?us-ascii?Q?WSAEolROJo4xctd8v6EdQFE6ul6ptfKLEEyQhFlp9yHiC1xM/HUag8Qp4io/?=
 =?us-ascii?Q?x6EFIHs2It8GiCcgnY/T5NIaW91y/Kj4QAzpFdpr1etfCkHxW+xaCDaf1AS1?=
 =?us-ascii?Q?EnHtoZDle4BLFwFblg5zUawlGf+49MXOr+Mo/JUydIunuu9anSatrJl616de?=
 =?us-ascii?Q?QyHOOBjK7I+cltPr7z1Lv776DSjBLmhciXCAOpgA0xJxenqX7NjkhAfw6KHL?=
 =?us-ascii?Q?vQJiMtL7/3wde9Rg9Am9DrDJMgyBmrznH+CnapTc+7jMtof17x+3ogKPnUEN?=
 =?us-ascii?Q?vDNml5I5qjdWxBV7CSlX+XYh89Z44YUi9xBi6ABxVOtA8bGG9+tk+S2NqFD2?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9Wye9Fn9ivgXR3D6O5yqGpRGygS4bKtLcX99A6y2Te4d7nGwvuHdCQ138U7ZCswBCz1j/xmmKHgzbHEYMCzHIvyC7zfPXgeF78m8Uo7kxYr6cw7zDQBwATlDEMhoRpFIRUg9+KLwwFg0azOPDUyEfnWjPvc0UvXjE8A8Dw0obIieN1aXu/hGpMTKTmtsytjgT51K4RCoh92ff0eWI/bS0SRw3GCqXwv0mH9gBKWG/lpyRxpKF+/WtOecg0g1ctxoD+uoyHJoujbkaSCvmDJQ0EsgmrgSwcmgeIQd3js3CWUvd23OBUs1o2q4TSyBSxvxX/vlC17JFClPUUVUMPfr6CBfONK08GTIvtQ+11FLwTML2ZnhEE1VQRaxwjDyuQ4X+6O84JWbzhNtGM0LNP4sVE5JYbuI8inbGdlR70I18eE4PjkKbHipq1UjanE5AxzK9S4CuljfD7sSF3WHinYBl5nNe1RdCbYGy01UxPN3+kZtouvsSsMudh9d9LjiYJOt5lfyBikM71GANRnM5OCZpQhWwjlpWuebpJb4PhEWgo58LqShUYTu2fjJblzSZ8iQMLXbvL8hZKwntlbX3YLDNIqiMkaXV3B2LRJ9v3XlawA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef938b00-6522-4758-799e-08dce883035e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:54:17.5759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZOzkYCogpuhLffXtJTMSBknEf1XbL4Cqqa8zz6PT22vU7yMh02ghecX2uJW2+rwJwYqvuDrbXUHyTYdXgaxqHRe9qjW2UU++7gaPxWBdng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6585
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_14,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410090101
X-Proofpoint-ORIG-GUID: 5V6dw8--_akcrOaHWbshektB9lEjMuCv
X-Proofpoint-GUID: 5V6dw8--_akcrOaHWbshektB9lEjMuCv

PREEMPT_LAZY can be enabled stand-alone or alongside PREEMPT_DYNAMIC
which allows for dynamic switching of preemption models.

The choice of preemptible RCU or not, however, is fixed at compile
time. Given the trade-offs made to have a preemptible RCU, some
configurations which have limited preemption might prefer the
stronger forward-progress guarantees of PREEMPT_RCU=n.

Accordingly, explicitly limit PREEMPT_RCU=y to PREEMPT_DYNAMIC,
PREEMPT, PREEMPT_RT.

This means that (PREEMPT_LAZY=y, PREEMPT_DYNAMIC=n), which selects
PREEMPTION will run with PREEMPT_RCU=n. The combination (PREEMPT_LAZY=y,
PREEMPT_DYNAMIC=y), will run with PREEMPT_RCU=y.

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/rcu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 3e079de0f5b4..1bfe7016724f 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -18,7 +18,7 @@ config TREE_RCU
 
 config PREEMPT_RCU
 	bool
-	default y if PREEMPTION
+	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
 	select TREE_RCU
 	help
 	  This option selects the RCU implementation that is
-- 
2.43.5


