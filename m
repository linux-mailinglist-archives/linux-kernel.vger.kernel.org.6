Return-Path: <linux-kernel+bounces-358033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EFE997976
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86888B20A47
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C623933E1;
	Thu, 10 Oct 2024 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ec3zuEJM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pbC8u3WQ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCD81CFB9
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 00:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518542; cv=fail; b=EH+O7pN/hbUxH/rBQyd/awqdq2ITI7ghvil2lGArtAzuR08Y4dyq/0BRc+eX9DSFNkeAMlxRK7+c/7KMcIqTKs5uhYpCNh2w6oyJ8YE6iTCEeRo4mICgwK06+V5vlUdJbD8DS+vm+iTfq0At49uZOjxzQg9ZNhdppDR9Ozi+PEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518542; c=relaxed/simple;
	bh=4vixgW9NuqJG7uQkqD23kd2qeneqXCeOHvRm/dbYY1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Il2qD1uk9RSTo6Hd3mh6he1IbIpBJuxWZBVtuqK2xPdoY3olhWedA8Yu5j0jsLGf2OcW32Wewc+IlypgDpQSrpo9OQ+sNEMgtjd1Nai7aRjmYbxJSqo4mlht/WBDRgJxLj5QCcmpaBnVTFb8Lpknc7TID+l/t6U6ZjpEOQtLxUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ec3zuEJM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pbC8u3WQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499Ltd8u028677;
	Thu, 10 Oct 2024 00:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=VtnoyE+D5nOqpAZP0a
	GAjz9h0bGLBtNz3/ywMHMaipk=; b=Ec3zuEJMCrOSCbkp6QDAvEhO7TeqTVPwS2
	73aDHjO5JuiWsWFrSNsilQiUnWBDZwgE7EBEIJPItCqFFr0Y0MV1Hj4hDAgirZd+
	p+zkSBGDvmUkaN1WFZWmNpKOIKPfNmIhs8oqDz10o4+EXb0caPTlY/z1yvq/Elg4
	i0P7xV1+nQKgPm0wSjX8SZM5rWfMKroxBI9wPh6OIObtrhv8o8TxEjpwYg1NckhW
	rHe/6LQayFSZxYA8ewvuBqWfEAEsVAzsXQNk3+4Fn4Fvv0kI/cH+aQgMAVMyQct9
	XRObAKN8YYjQBOSr6gPVvP46X3CAr8Pv6AeFrKIbvWFNwy4U5PGA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyv9ptk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 00:02:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499MhuIv011526;
	Thu, 10 Oct 2024 00:02:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwfn49k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 00:02:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G19nnkQv32PwsPYG9S/Zt5o9FaFSt75P4ehTHDYIlE8a/ZkJwJEVwZJP3Co/I1Cg6oh/NZNDNUIIF0M13+4F/zvNaP3pEOgwcI8UDn7vn/sQ8sYN7JZPD2yNmZHRWmoZdeQVwi0zPwm29Aw3omIu91smlJSdDQ/OvwLX24wED4GVTURLDqyu9zaoPyVr7vkgf2gZ9wcqTDY9AVW4ccYTe5VtGN82bvK73qU3UEx6CKVYqtwFQv/4/81dzB1+6kWM4zZb3kfZ2z9VPNIF6D3vHFqvE4qC0hjP2ca8Y9Tm3LPn9c+3C9fWcdOUoLOUDVsyimyuW1pPjvJSkoRw2cB8bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtnoyE+D5nOqpAZP0aGAjz9h0bGLBtNz3/ywMHMaipk=;
 b=PBSiKzAED37JidqjPvT5y6kJmg5+Fed1Xl/Nyh1UfAf0XWhmOc8G8qGKVtcJw631Ou6Io8m6StSy4vpiAlWlOBF0kj5uWTIlEvaieUERkFHB6rfCc1pzvcsLXN9ZSj1yM9inoH3NNPZNqDHn01OJtAy5alTiJ7qB93/rLkAyzVxpFUJKScYU7+jKaWyguXaTjVfVM9Plv6DwENgHCd2oO1pqM7GfSGhAEIZuC0Fw3IQRSDq6YqFvsGrA/juLcmuSkTTuAUgEjx4f3gk55C46zQ9/0Ewt0GZY8F8GrjnSg+C6YxlO5606kcCIiW7NbomCUEHGjB+YKsj6nAN3gW4kag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtnoyE+D5nOqpAZP0aGAjz9h0bGLBtNz3/ywMHMaipk=;
 b=pbC8u3WQTEENrMkh9pVS63hSdM6g2HaNcsYfyMEQ4+g76q9kIaH+PdiD9CFaiivjSijavilFBq0hrP7AOfX44oKWN9hXCpAi1HdktYbzkc5OkCnWknA2nvtcyKfqjfUzBgHBow+TdguMaElADLVmWZriFPllFW62yx4vjf19pRE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6275.namprd10.prod.outlook.com (2603:10b6:510:211::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Thu, 10 Oct
 2024 00:02:04 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8026.020; Thu, 10 Oct 2024
 00:02:03 +0000
Date: Wed, 9 Oct 2024 20:02:02 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
        richard.weiyang@gmail.com
Subject: Re: [PATCH] maple_tree: remove conditionals to detect wr_node_store
Message-ID: <qevigth7doscc2kqdnrcagh4klgruehp3x4mwo2lc5c3qrey72@6omxfs7qhk45>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org, 
	richard.weiyang@gmail.com
References: <20241009152007.2096-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009152007.2096-1-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0477.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::25) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: a0fe2243-f780-4ab7-27f4-08dce8bec5b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ya/9yrGhxwgs8OD5Ngalj/Q3JyKPCmWcu1G/12aUgnw7fyycIcKDUamix3f1?=
 =?us-ascii?Q?OEA1ZmLTtzlCHMqgbbAf5NSZdxSLrbUZGZn0xFucYZStNEZ8aeoEaN5QyyxW?=
 =?us-ascii?Q?zjH+itbCeU5v3bsxxYsWfo+NsDeIjJ6xStl9ybh+zQB8afjZg2eeAXJhUHgx?=
 =?us-ascii?Q?xObcLUeykR5qlBFwGWrAdTcEx2HPLe4qs/NyG/4XqsdQHqKbV9UCcCt+meWB?=
 =?us-ascii?Q?dlqzT+P5MmRBnNWQ3VHgvXC+rEjvBX2BjiVzFXF250XARuMe2u0lUkkspBzf?=
 =?us-ascii?Q?HjBFYofQnlAmmEV4/aQx5RKsZ5N3YFuGe8ci1HPSuMvvut2Fz86Uevebo5gQ?=
 =?us-ascii?Q?9eQIC2A+MJFcsvdjHv4e8Ow9LgnITmoi9A8AAcppiVcus0XiyLusL6rmfUK8?=
 =?us-ascii?Q?zYPzKrVt1xux3Hqx2W+vfQGr4TEFTLymED92lSsaWZ3RC6716L5b7XbJ65Mm?=
 =?us-ascii?Q?dH8bS3WVad8s5cD9rJMecnhtqQRSQKiO/O1Yvxs6UU8mqvcvpz5Yd89bQTb6?=
 =?us-ascii?Q?MQART3QWAYNuVtTJM+5tKocpX5jKMRDucDCuQpik7BXJiH+x8F9gBE11a+H9?=
 =?us-ascii?Q?8FPvYGiYfRhBJkLnFxlQqkPlaBbACtpNkJMCblC9URnMXFouKY8OmeQaLzDw?=
 =?us-ascii?Q?4nvXlq6WKL+KNUbLmuRqGSRI3lbYvbMuP6alEiCRBDnJs3qBsUgvEbo5blry?=
 =?us-ascii?Q?9AqMoZMPOEN32D4aCrp2mnrYXCygcQ5AWIfNM6umQEcNI0I3fbYiW57u3Rdq?=
 =?us-ascii?Q?VxUkCGk5Cab+YdMr0D6hM3S99pGPCKnu3LPC63mNbJaP7o+CF027nLAYcwMS?=
 =?us-ascii?Q?4L6F1H1cvCatArbigIVdbjUejnXIG5lMCb3KX17lnSF9W96omUeR8iKXd6YH?=
 =?us-ascii?Q?Fj7Uz/OxB0wTEm3/EIA4P5q8VTqfiaQMP4maCCDmDTC3qGeHIIJPvi47WSWP?=
 =?us-ascii?Q?I3KvEAp8oqFXeWQgNheDbLUP0yuTtowgStVtdtt6Rejgg70sQVJrUvAfwTTx?=
 =?us-ascii?Q?5EwejPPqFKyokQO/Q5tYDIkOqkFo54jpvzYOMmrSNrpmWQ9IQBDgtMAnXrYd?=
 =?us-ascii?Q?R8wRYMco9CqDaNBK9NVc04/Sl0Qlo6XHp+wNYPKnLuvhAxit+iIOxDUzyj1p?=
 =?us-ascii?Q?EnRsn93eWErs2o22hsWo8U7YJWs6hEN9LwqRyG5/1PUIgpvNmej9akoDFRmG?=
 =?us-ascii?Q?x8fX1Aqb41TwwQXUrytw9+PcMRSuXE/IuChQ+OC2DSwhcq4SyRgDm1kcgbXG?=
 =?us-ascii?Q?w6YA+s3Frigj2f6cUL4MG8I8hO2XcEc9I8P7VYH3iA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IfOzlqZvz+HOoa1PYJZNDpCihrfrXHnVtZRZk5s8QQ3U2RwNwRlW+TPZWK+S?=
 =?us-ascii?Q?zeCW0EJcqqfrwJAL2KtrEZJ1Ivr7m5LmeACVU67kUkbM+AY4ZWOtmBrWLebw?=
 =?us-ascii?Q?wPvQln2MvLxyuRfnI9Nc7WBCSgjkconwH2QgGZP14zHSN+wsFM6qW2SJ5QOF?=
 =?us-ascii?Q?sdVHvQd297Vx0FeliIiV4HFGitkvXabqrbnrhgi6WcG2FXrTDaYye6Ef0ER4?=
 =?us-ascii?Q?Gtb2F9MScXYlXnzA/+xnX8p5YSX+dLKMpBaLuyYe/G4RH/NshP3XYX+UwN3t?=
 =?us-ascii?Q?jOQjJAKGarrgb7zB9eJPw+r6F9REzeSrkcHWtZW/jmwD99RtjgS19Qg5f67o?=
 =?us-ascii?Q?Nmid5PQtFi9zsFS0+wiMeRi+pFoyqeQVGDoS3+3Ct1HeDZVVqbd8BbdXcHd7?=
 =?us-ascii?Q?uBTxYkUepnNHJPiv+k2eOdvhacxeInpocBEvtfSbPRLHecFLYt7ifQZd8AkI?=
 =?us-ascii?Q?uwum5Mf8vM+ey3l6f/LDuvw0m+I0vSV8Pqqlrph5sjDTGKmwe5DlzY5qwflp?=
 =?us-ascii?Q?AIGEa259cOCu/m8RljsaNQlWmRY4Rndrx1J6U7xkGb5dSOzilh3b7bFDmXMQ?=
 =?us-ascii?Q?zG2CxU+On4AnOtWwpjKQ06eSqwJREDRuvqz/yKUsFa4qdeCLVp3mx7887yRn?=
 =?us-ascii?Q?0TmFYoqVLXqezMRxZnTCh2wKfhKofFqR1cQD/WdLzuHlLy8nLugXhA52BaPv?=
 =?us-ascii?Q?sgVvg91qCnJNt0G5CEjIhjXIKAgMz+RsfCQnn7uiXjH2kmsV7JcuR0TPZXw7?=
 =?us-ascii?Q?Gfg9vgjNTD3xtfRH4L3jy9mZjGy+oU85ikRn0efec2k9O5FjL0TD8TzK/69N?=
 =?us-ascii?Q?sYLSi9LGcROCzmkxCfmhK3TfKl5c7DyEQl/Qt232exTU7y2ZSLtL/o6QgKeE?=
 =?us-ascii?Q?nENMMys9dWtRb6idBtnAvk7wuJtQkd3Wyk4r/9WiWGtVZfVBNnmFBpXgRqkm?=
 =?us-ascii?Q?aDQSufaphanEMTU9BHKa/+ZsGo/c40MkuuYoXibCO+Px0SmppSqkB3ydh6WF?=
 =?us-ascii?Q?bq4l1pju+9EnsfT2FLEMS58FZ21qE3OjC4yYjdZcRdTvSlJ/IXOazdpQ5/s2?=
 =?us-ascii?Q?vUZ3RBOE8xmOcfI48Vu6Cw3xJ993V8Xa9NkQj+fj96gleJz4Wa9Tcl2KIyZe?=
 =?us-ascii?Q?aRO8tJ7Om9nW0l8tflsoVLN6jAsIbUuRTtSTemx9He5c0IMfj2QM54rlatRm?=
 =?us-ascii?Q?nRjrBiNRzj8JUikMLrwSzIXfBeEEbHUn7EFZZs/lHZwcgzoyjlCkWP4zd6M5?=
 =?us-ascii?Q?zt/WE40sNulLcuGrB6Dd4XdUYFyFwra6dhiMcZnVe+RrZUVyh7tl3rtMw27D?=
 =?us-ascii?Q?8W+ZTRKbwGR+f0qKeLRZSFz+CkvtpKkOwLHe42je4oQ2OAYZtQmUSCklZsuJ?=
 =?us-ascii?Q?exCUi57O3J904z8tfNLtw6Vunk+eXT4nd/aqiN2zaqHpUrBmFAnuOy0LIhN/?=
 =?us-ascii?Q?jUjXMAq4Fm40gWDXmTI/KkFox6pRrdf3jDLJoTII8VoarXn9o3rKVwHkWlUq?=
 =?us-ascii?Q?DeaAD5ewCQDM7f5FhpOT2lUSjVxnkQZM0UvhY6DqvW5TXeC20abFCgHfuhWF?=
 =?us-ascii?Q?1VcfZjORaTM2WN0LUS1aKDxliPJNS+4MWi8IfMsv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	enfqJ8VL4NDPbWK9n9Hyaz8CdBAF+perHFDhtnqi2EvxN/13yhID17XijVkV+8RlhfvME/GKlEs+gCkyR0OLyU2sOQKJqhiWfwfO3Tk77t+pKL2lB+tx+gZ1k6PYSC2dn8i3JkzCZPsPKg1AMsQwJzBs/XnegOuYGtrz1mU50QM6tK+oIrZUgNU3DCfbMhG0LgaNE+ildLyue+iunas+JD3i5eCMx1WTuKbH4OQ2MtvSVTC+EZGz5Sp3Ce5jlbFS7a0hmEV3I0UTVMjX1PC1eiGlWS7c3b2XrnTVSlXn0EtcjdKQRd+knzabIfzk3n6S0iYWPBXsDAeuWL3vw+TknRlhd00FdpaE8eH4VyToUpnj2g2Q4ovYcB03H6kK9KqskkMD7uhKv3jtoyptTwJDZOTMGtmUTOBdchCeFICjfYL0BzsuMkkVv/y+MMFwZL8RbXkgYoywRkdvEQMgY5qCbphLEplMus5HNSveSpXeBCOeVMpB5FpIM4P8pXfn+eqT8W36ilgUheT3YzE6RfVgad3rJvzDwbF2N4aGlx98VEf44ra6EEb0BlsvVhOQfqvCPnKKPPWIENVvnbD+TuOPgJ7f9WVKWDnI/eoDER+gscs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0fe2243-f780-4ab7-27f4-08dce8bec5b4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 00:02:03.9197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KokkvE7iO8mGJ34hh1d6MgnSWyImXj9KAEMu+XAu1sX4ev2frjrT3O1ZDrtfs0/gZVu5yR+JyYR78iwBGjCxQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6275
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_21,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090148
X-Proofpoint-GUID: QfCOvfSxmrBDR2f7xhxZZ4CaVImj5cKA
X-Proofpoint-ORIG-GUID: QfCOvfSxmrBDR2f7xhxZZ4CaVImj5cKA

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [241009 11:20]:
> From: Sidhartha <sidhartha.kumar@oracle.com>
> 
> In mas_wr_store_type(), we check if new_end < mt_slots[wr_mas->type]. If
> this check fails, we know that ,after this, new_end is >= mt_min_slots.
> Checking this again when we detect a wr_node_store later in the function
> is reduntant. Because this check is part of an OR statement, the statement
> will always evaluate to true, therefore we can just get rid of it.
> 
> Suggested-by; Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  lib/maple_tree.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 4b423330d83c..f5a12d37b352 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4252,14 +4252,7 @@ static inline void mas_wr_store_type(struct ma_wr_state *wr_mas)
>  		return;
>  	}
>  
> -	if (mte_is_root(mas->node) || (new_end >= mt_min_slots[wr_mas->type]) ||
> -		(mas->mas_flags & MA_STATE_BULK)) {

Although this will be evaluated as true due to the new_end having at
least the minimum data, it points out that MA_STATE_BULK is not being
evaluated correctly in the new_end < min case.

That is, we will rebalance if we are in MA_STATE_BULK mode without
meeting the sufficient data mark - which is not correct.

> -		mas->store_type = wr_node_store;
> -		return;
> -	}
> -
> -	mas->store_type = wr_invalid;
> -	MAS_WARN_ON(mas, 1);
> +	mas->store_type = wr_node_store;
>  }
>  
>  /**
> -- 
> 2.43.0
> 

