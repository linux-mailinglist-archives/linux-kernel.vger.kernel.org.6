Return-Path: <linux-kernel+bounces-523168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB13A3D2FB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C833B17D3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36601EB1A3;
	Thu, 20 Feb 2025 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QIg+LWj+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eKrGz0YL"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4BC1E5B7B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039667; cv=fail; b=ptyM0d4Mnyy0hyeyC3W78mHTv5/DpEgjeVoOKKKFRed1VHDl/BK1MaNVNpVzjLRsU0LjBaFWdsB9vp3auf8oL2+Q+8yNdHEtZWQogsJJ9IRRazloyvkxWYD2cy1jPfFI03//ZOCGrT1TW/eEH21477tcAPFxzP6FYlggq/mFOtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039667; c=relaxed/simple;
	bh=rndphdznWFdNS6j8ukw0katWrk9QQ6cqMDg3a1bD/s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LkdCwTQUJFb/YMkPbONj0tvPvMrXQFiRtRe2jbXUIIqxJkGxgMGnkib1rSgbFO6Z0N52dcOnDWo/SemuCBDgHHjy1iYIsh77p7yMpETNWOjEwH85FVcXhdcixEore0N0Thq1SUN/Z+BDNZY9v0ij4XVJjJLEL5sUtOizZJIPF48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QIg+LWj+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eKrGz0YL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K5fb7r012026;
	Thu, 20 Feb 2025 08:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=eKJow/iLdwHBGL6Xrt
	+p45rH4F65miZVJkPE7qodWo8=; b=QIg+LWj+DTT5ler/watGWREHNtsl/GGR9L
	AWBjEriTYYLpf7PBsoVZz+wOvhrjjFVQ2KCuxWWpIYXb7o32NX4PB96oqu8rfMjl
	wdzx2bOxCi+XjSAvxrjdbvgeo+PYNFvFp4yu4hlyGa/LviEPqyhZ4e7TiZmDMRUz
	I4INm9nxAb1sbpl8CfQLH34Wvs9pdr1NDyECeZETgnJrPw/5oaCZGJ67M2LQkYLK
	vSydxv52k/46nIc5s3RVUv+MVpiYFNDK7C7ORxlbf+N8aOj5Vse+9P1GIVreZAlz
	Gptgax8sPjDLLdwK2GRxwzSFBNR+rebGl8q9BznQaH1U0pMCfFww==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00pujp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 08:20:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51K8EqfG025255;
	Thu, 20 Feb 2025 08:20:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w08xk523-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 08:20:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/yDKl2GTIn7FjCRam5Mc0kI8GipKfc1zFZ3jv8E2yQW/uumauXa2XhshZ2d2dJ2fwvm+jyvZCNzdTfk5JkHSL4cFna87ZkHfm+LDGGz0kme6S8kE3abARawUmBwkB03bEEL/1nyRkIOKaKpsu2oVMIPGkg1KWDOwI9kG4VMbBwuW1xQS57Z5+ZtnuMEl7avL2MBDKilrToPgvU0Y8E+o+H5/PiCMyfAB+DjsqqhPfw3YsED2iI0JrPVhUHEwE1frhRw+WnDpaM7rKsX+hhHPJDBeGxyz/Lw7fGZPuAHjheyxBm/t6UFR8k6xLpz/zzJBDSHXjEBmrLKbzVXZFpa6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKJow/iLdwHBGL6Xrt+p45rH4F65miZVJkPE7qodWo8=;
 b=FOGiJPm24nfUOA/weHCg+hvRCg7EsKMmnlgeW1eHnTojlpsd/YXTjNK8IGLQxB+vWnrfkQ0i75JoEkUSgEoB9D+bBB7ZYcekDWSEyidthyJYLVInVUmVToEPBguWae5vI9nSnoqwk5A+LPsI6s1SCIO58lW7DOt+GEDklGjxUhlm5CS1wXZSz/a2nudbcNDDxtqxOYllGFN42pLsoZibZyhDyFjVPF6HbDRuPbRYgqCxeD1rl9w7h0K1GXNr7Wznusx9LF/NW09LfEzzTPDFJ6rABKDVRFV5sQjNEiV1xXyQupLxfDDdPGoXwz1265JFuR2Dsd3djCDGEMLqRrTRgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKJow/iLdwHBGL6Xrt+p45rH4F65miZVJkPE7qodWo8=;
 b=eKrGz0YLQiDpmRDTNsGNNsceZNyNycVFDb94er9tDv+r8KNeDpYsWAKiSkcBP74HUbByCq4PsohhWDV0byWSi5zFAXFnM+X0F7BCDEFB/IUnRMwR5ahPqmPeXyg9sPMhrAJ1Z/r6ZYjPoi2VJyDdUUjooJrHEvOjlPHmmgpR1dM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW4PR10MB5809.namprd10.prod.outlook.com (2603:10b6:303:185::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 20 Feb
 2025 08:20:12 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8445.019; Thu, 20 Feb 2025
 08:20:12 +0000
Date: Thu, 20 Feb 2025 17:20:00 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Lilitha Persefoni Gkini <lilithpgkini@gmail.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slub: Fix Off-By-One in the While condition in
 on_freelist()
Message-ID: <Z7blsPJiOPTFWEL2@harry>
References: <Z7DHXVNJ5aVBM2WA@Arch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7DHXVNJ5aVBM2WA@Arch>
X-ClientProxiedBy: SL2P216CA0206.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:19::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW4PR10MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8ac8dd-f435-4227-97e4-08dd51876554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zJ4/XihyLTQ6qSczQIdIeIiCiZwsR9/4y0OUnwyBT4DCBVk5A9XX2BHzSw3A?=
 =?us-ascii?Q?KdcLy8nHPawrcocvr/vrKiCUKbSTy+q4+tJTp7pAqnG183NB2F7n65BEpAVb?=
 =?us-ascii?Q?FW1J3nRV7TCE5NwEjnrpYhKFZg4YZLCujO2NIlwHGdVUYYWHDYn9ETiwmsRw?=
 =?us-ascii?Q?mZEJN7lTdzxhoOj6fnVaQsdAEo9lg/XZ2dcLvaeNmXLLKilN/YMExu4HurO9?=
 =?us-ascii?Q?I2k+xAm0hCCMUWXfvZreVY9qScXVTEmvPVv+CxeteW5xzIoretcB2atdgbBe?=
 =?us-ascii?Q?07WZn3DxTFiG/11sVjPx62eLBS2wFcQjdYUroGxiALO8ypPu77CcRP4WXu2L?=
 =?us-ascii?Q?MLMaZKiDcrAlQW+3kJk4zrt6fYCjAa0YBgvCZFEdD1D75qtmVnScRSMImWZD?=
 =?us-ascii?Q?PkliJUKiETjbPe9kuwJ3yyOffp12pwipIBCuZxdJEmmJavK2nv70BJ26X6Mm?=
 =?us-ascii?Q?wnV+ioPj2swmL5hkmTY9Sx34MOkAVbWYU9/RxrqrQN6QN5pPh9a2L1dHU1hR?=
 =?us-ascii?Q?xzIpme+HW+vp9yRaGIseCFQ/9AR0S88h14DDAu+ZxLCPJxBEWy6zwB15Fxpz?=
 =?us-ascii?Q?fNaPdCkCzthVbkgZvTjKyjSV6kAFQCpAvfqtwXicxYAIM4u1lasPw3GyGDzH?=
 =?us-ascii?Q?tzhZeJe1bZnNAdb2ak998vyHJLg2Q6ipHkCD3/LB1r4BTXgMXC76wCOU7+bh?=
 =?us-ascii?Q?2E4zTRH+uQwpNgDDI7n0lZ0MoEClDxzUE2uGY3Sd96gYpJ2Fbu6KjAZCH+gk?=
 =?us-ascii?Q?ksjLbTlJbOByNacLeqrfU9iIVeosy6fsyRjvaglE//mHsp1d+gIUDA9xOWdN?=
 =?us-ascii?Q?MUW0tqt1/jlg84ToLfqBtHqaeztJ2+4aM4uRZNqoy3BviRRiPa7eUi94VcCO?=
 =?us-ascii?Q?9fj29f1kVM8kziFjCDK78g38JQ+JjexmVGSILEiHvsS2fso+URfD5L61WPyP?=
 =?us-ascii?Q?kJ7lWk3ItYgDmsyuSYMnaSKCGlKImssybq10iupIzqdnSPANa9l5c/Hl2RUh?=
 =?us-ascii?Q?2+mYINS/fZ59ZM/rOPkei+qsmQbLa4gBgvqf3L8V/vXBVgxBCjtwagF2Gp2g?=
 =?us-ascii?Q?dDLz8O0MlHmGHW0I2pcCYqMZ9/CMerzrK4XQWm+5rowGkk1RpjIPqSbXbjdV?=
 =?us-ascii?Q?VWT4+5SDp4hYAAZGCAzVBX1VibZSmHtIHKkdX1SX3KNe3VXcCkqfwxoXu9fv?=
 =?us-ascii?Q?cNzVJIStneVwLBCHbNic7p/jNInDWQfU9282wSDwG+029shn7s+gJ9qwpNOZ?=
 =?us-ascii?Q?uqoCZX8CdZwTY6Lr85GlsJtPnuJaP365BRGgV+Przydfw0L3MYtpyuYQXUaB?=
 =?us-ascii?Q?Jy5StZnlKz4q0e4di82qtFroJ3QTb4GxiumSWooNiwbP8Z7kMLKnYJ7vC1Tg?=
 =?us-ascii?Q?qDB8I0WsUGtET3kJIyYC6c4ojYEM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?forAEXR0wrmACJLdfyINudattx0+16XKtYNcRjD2f8VpGUgakdclAZjWIxi7?=
 =?us-ascii?Q?XLvO1ZVoUV4UKMsWFdVul1hcdrYP8hx4vtVVw2qY43hfQE9ManLppaW7Uq+y?=
 =?us-ascii?Q?mEouKDQtD88tZU87l8cVMzOo4PPn6uyjviABsomsJAOnXXO6FtpZu7vqKChI?=
 =?us-ascii?Q?IQDQOANgOvHobRoJoMIcbRtBqjdoP+d1c7QWndCHe/yA6zlJ28xcWt8qf+k+?=
 =?us-ascii?Q?HWQPkarlJNGWgPNmcL1738pB1lHdhcO5wMwbArdLp6XKEApQKKSLe8mAldFY?=
 =?us-ascii?Q?Oh6K6ay4rlpyJnS2mhb9uIrZMLIneml2evr/U44h+mX4lSc5hQAfoD6O3lZ4?=
 =?us-ascii?Q?NrTKFHgViIFKsW6aYMAT97lf3suSkfTU7Mf2g5I/iRu5ap8dsiungpvamZJE?=
 =?us-ascii?Q?xntMMMClTE+lxxLPBgdrQ2RwIX9bHtZjaOS9V69N7FuFZ2P41N2VCfCeluH/?=
 =?us-ascii?Q?SchgpP1rRuF5bqAWxCbhf2dOlau2L1xD0LI7KHHozJ+dZJ84qysOtZnwU+k4?=
 =?us-ascii?Q?iHOeB9VY4Zz8mUMt4PmqJn6zy9uYbFwpWUZ0pMBh+PAgmEqmNkpAo9mjMshf?=
 =?us-ascii?Q?uBoIxMtH7a38JDk/Ko/uN+uWA4akf+NfUplQ6GUAZWZr8bcXPP8TkxLTs/g/?=
 =?us-ascii?Q?9Xv3+OZUxf4oeuCNUbnOPtj/b2K311rcRMQfduvKGuC2KGjdQRag6298hT8p?=
 =?us-ascii?Q?2QVh8109jEqPIs64Q8U1FxI5xPHPsT6+qfbr1pY5iwRsVqlPSxypQ7gi+8XN?=
 =?us-ascii?Q?Rwzv/qbl9vZyx0d5Gl6siwjXrsXXgNTLL3Te78PTjczdAAgMCOzBYEOrAeq1?=
 =?us-ascii?Q?vgtj7bvD4MUg5TX4EujqBZDfYIIoCeBjujKYTMjtUpRyWBOARG7qpHpPySsi?=
 =?us-ascii?Q?15VXE34EC/eXWFJN65kf+kiLl9VIzD0ZQV6txSTR9QlJDh/EdI7+mjX5Ubhg?=
 =?us-ascii?Q?7Gmv7GMYS3Sx+gsgOOeOlSQ+DsNaM6Sy9fc+RYDDk0DrAVsL27QCe25hyHsD?=
 =?us-ascii?Q?CNbo1CsTIMwCB9EYw8p+0EM+zBnDDX3YSfbxmFbw9onKHIsylK1TNvStx2k6?=
 =?us-ascii?Q?t0lNy8QdUjvPAIMeGYSY7d5UiAw1ttXeSJji+krSVJ3Z9SLKO1qWXtx6qdHQ?=
 =?us-ascii?Q?dhUMQ7OSJSvFELL5nG+HTtoI9g4zrfkG/7xYC866CcP83M8C70WLrax8hF97?=
 =?us-ascii?Q?KHpyMc952CpRNPGE6qkOQZ6UCAwcX7muXWQXH3uB2AqwCj0Oer+OGDmyWg4u?=
 =?us-ascii?Q?dqXQdqg414ARlZahp6MLObPH4G735jTgS9yDBxjeg5fa39rr6hYOzq/j3bWB?=
 =?us-ascii?Q?ZT8kFQdGQqOG9JoW67f6C1YJTsnlXNnOsEQemfv/7RXZzisX/5TcU9bvE7Eu?=
 =?us-ascii?Q?vryZv12J2pTxR2QLrpotqEtVwgPLxe5rD5KofdsQe2nEhVaEEcxhWyoBIG3I?=
 =?us-ascii?Q?+CkiGAG/FW3NjUcot8tRlyxByN2hHiqXjnjXy7xLPlARCofmiEF9rfOkwR56?=
 =?us-ascii?Q?8R4yBk774JjD7SsY1Wn0XlBUe79fhzo1dkzvrNyhhgx4r/X0LacEtJmk/hnP?=
 =?us-ascii?Q?UCjOYSdBwviw533RCCEJtfpH44tbtRHcBwAMgjjaw/kWeImHZQa5b5e7G0F9?=
 =?us-ascii?Q?fdnqe/AFxzYxqAMNzAb8zQuOdNOJ6R+fNmU+nTSzvI2+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l80GQoJ23DxAFdpTc4p1TsEzZn3mEIldxW/UlctqTiJ13O3wcUxi08VS3dH2kSrFcE8jnemDGqYewifWnMxVM8ZIVwdS5YYxhborTGGGrLfVRQ+OGUv+/fLcVKXHneOqVFeSJ5h0x0qS/YaT3JkDZHTzYjR/P+V2pgG50JDd56LcfU5QvALL9em/o2DRSvlee+gKtHL8w3SC26hl9Edox8zjLhH+FCXpOdlmKV+ExEdbZuAQ5VEuiIkGWYCe2YcFaH/UFwUW6mHoqnXfmGTmuMEjwbY0cIM3wDMGg5FRfrNDD72JhwMnZCofjtKJ04ChQdlMNvAXpEJ5DQVINar4mMyAMg7GlSLTyMoVC4AOxAuduJg2dpptm/RmEjfWMisTsMt6IipM6a7/iG+RixK5+/XXefT8LjK1Sdp1JzdobmS3sQOOL3CJ2rQNnCyBuaXanzcZwNYoecDyauWi32camrrZ+SYJorOVZ2yw+s41gsAYkrjeVZr94u1MjTu8VRb9rja6FVyPNFwxh3PoMzObL9puaVupP1g9FEpmb9Cl5yDqRZvMI1mvY1Ny6BTkUVCfIMWk0fdF0zpszvGinkEskjNRfOpi54iwgWJtKiPS+cU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8ac8dd-f435-4227-97e4-08dd51876554
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:20:12.0543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: himQhiuQG+09PAJGcqNGqfmc6dN/hj5zq+ERW0n3ywmuJw1g+xEjbcrsf1yyXUBSqFR3n9e9MlKHR9XoIJCzwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5809
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502200059
X-Proofpoint-ORIG-GUID: zO9Du8LjIEisu7JBwZ6UYdBwtwW2xZjJ
X-Proofpoint-GUID: zO9Du8LjIEisu7JBwZ6UYdBwtwW2xZjJ

On Sat, Feb 15, 2025 at 06:57:01PM +0200, Lilitha Persefoni Gkini wrote:
> The condition `nr <= slab->objects` in the `on_freelist()` serves as
> bound while walking through the `freelist` linked list because we can't
> have more free objects than the maximum amount of objects in the slab.
> But the `=` can result in an extra unnecessary iteration.
> 
> The patch changes it to `nr < slab->objects` to ensure it iterates
> at most `slab->objects` number of times.
> 
> Signed-off-by: Lilitha Persefoni Gkini <lilithpgkini@gmail.com>
> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 1f50129dcfb3..ad42450d4b0f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1435,7 +1435,7 @@ static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
>  	int max_objects;
>  
>  	fp = slab->freelist;
> -	while (fp && nr <= slab->objects) {
> +	while (fp && nr < slab->objects) {

Hi, this makes sense to me.

But based on what the name of the variable suggests (nr of objects),
I think it makes clearer to initialize it to 1 instead?

--
Cheers,
Harry

