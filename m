Return-Path: <linux-kernel+bounces-368702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D69659A13AE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DAAE1F224AD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF792144B1;
	Wed, 16 Oct 2024 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YGvzQ+Qj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Boo0BOIU"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6FF18BC33
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 20:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109887; cv=fail; b=qV4Pueyt8x6vB6IASuNUPYUXVpU3GtkJ/SWuxuW6laqHi1j5rTHoy+HbcYPBnPGpcGXc1d6YI8S1gAGZdshIS9PcvIiOAy8Qrq8yyJvXBE+egm8tlyXCDF3Xw1TOMbVXhQV2SHUHCZhMF3G0sfAlyoh91D2+YaRDrsvJ2ySo/eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109887; c=relaxed/simple;
	bh=OvXEBcy/b3GPKLiqHpgGHA2d7xthMcaKeANfiU65Szs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eGXmbrg7sOiYFAWw7T6/l4cO75nFyhMhUtUkPahvxrSDlleECAB7ZA7uJ4DAxUvY7rJgXG6CjOFWkIl1f7qUotvlbUqjYLx1m1zqPdRPZYVKpKd+mw8gUtxF9hCt8nhYBJuaf+21gQYaqwaHto3Bji1E5NrXqJ+gnvcy+gnt6iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YGvzQ+Qj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Boo0BOIU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GHtfTB027341;
	Wed, 16 Oct 2024 20:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=l3FXzpj5Oxzaq/uDBOwGSH/4JCCCag4pwr8pw0P2YRg=; b=
	YGvzQ+QjaYhVP6gOYCI4hjPpylG93N2bIT0KaNNxr3/P8wohZzroNAFTwxSHW4mY
	1ce+SR2ZioIER7vV7AVd4qccrGXC6/7469dOe213bEv0jZAsCi1mNNC/VITNjwJl
	MqvRGSaOXLtZ6KVvsH9OQwHYgI71VUc85m0xg3HhT+CaVX/pxoKUEpSWNh6oRke6
	+SmAklVXexJppAR6P2iopqKKF4K+PLwBPh+WgG1coMa53CL/foxYMn6YWF+uq5x4
	/SvMxU5c2OgskRrk37NyyBvauC5AfdhmfZ0kHlDOjyJcET7/A7zmhd8n14Cjnkwo
	WHGH1hPx0Td7lSKkTnXR0A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt4snw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 20:17:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GJQOOv027123;
	Wed, 16 Oct 2024 20:17:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjfwk05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 20:17:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePcuh1GPiDAXISjLGRWYrD8B6UVMGoRYwBUt8cL0zCcGMbdphib11J6bVdZOGFU5aomrR3HOq4grLXAbvaQ85/I9U+9ELhd/QKVKaF+xEtGuuHyXwF28FkTx2th+OgOB/GWjLFTYgWf8ojvzNYi0HUm7eLIJwdgpCNxKRY187+pw+nVtrVaSsdNd007RL7pRjkQDMW9WtseV+9zdnseHzipFdaXLrXq71KmOdVWHRwMIEgL/ZbrTqL55zETUaY12Brc7blGOqbfzC5ck8Zeaj9WCvSkJ3QEcXbvABLHxZDgSyPva1FwD0t89lB5c84QTNrhtbEocGQVY2X7uVSyyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3FXzpj5Oxzaq/uDBOwGSH/4JCCCag4pwr8pw0P2YRg=;
 b=zVZUvjqOnfic66nHNeIpnFk3grjVay3OTlDvvNxQGKGvBqRQD89IttVDGOBVFpy2BQLzFSwf+KXbH24CcagJM8L/1eR5SPbCe7BgciYOCCwBfbe0/sKdXPFsjdioLTSS8ZCU4qdmLqEWya0Z92k+mkRNMeFLdZwyjcRytIB4qjPlTOG1K5EbRnalCI5D1nAJ1/vyHKYGCHDWXqbGLz8em0az1Ev4bSD4/iwgp5W/X4MJIOnEFg8d3D3RKTUI9VLeRN9VFJd4Zfiu37HgswHPELd+jWoMVboKuCrL16qIp5Yn7Jba9NfAs/OcoSsARTg44KMfGAWsoJYMJPUoJNV65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3FXzpj5Oxzaq/uDBOwGSH/4JCCCag4pwr8pw0P2YRg=;
 b=Boo0BOIUEP5edjKt/OydlNtMvYckk/ro6868BsDwcj7YUfBPIoZCOu7AJ574utZ1hthbeR5rNJ7H3XYat4Y8WxOR8NfnxsomkDVpV2TGcmzo3izz4cvD4H4Djn84en0Vhpn/D7GoQd9u7yBXphFFCWVMdjHuE7oNyOqf8xsEd4k=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB7579.namprd10.prod.outlook.com (2603:10b6:208:493::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 16 Oct
 2024 20:17:41 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 20:17:41 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jeff Xu <jeffxu@chromium.org>, Pedro Falcato <pedro.falcato@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH 2/2] mm/mremap: Remove goto from mremap_to()
Date: Wed, 16 Oct 2024 16:17:18 -0400
Message-ID: <20241016201719.2449143-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016201719.2449143-1-Liam.Howlett@oracle.com>
References: <20241016201719.2449143-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YTBP288CA0006.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b512ee-24ed-4995-e0f1-08dcee1f9652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H/5ooc7ENFAPaGsVkUHYMhkXRAe3zuW6H/76Le9wwPcWBcZA0eGup7uTjpp+?=
 =?us-ascii?Q?tVWTpHWrOvsq3YSVhOKW5o6gssjQs9wE3Fx3wp2MHUjawBl1YGUwZcE4D+cs?=
 =?us-ascii?Q?Unmj5+PXM0CE6iLal1FyuxGxzIoO49BIbfebQ3grE3EaQ5/JmtxUme+noFFD?=
 =?us-ascii?Q?h8MrbQPUSe/8vGB7XNF3BbV/u9C8PnDvNYMPPzN6Hl2hZbMWpn1ooW68TVdX?=
 =?us-ascii?Q?rg7khjzasGMXc7vnU601Ups+5i6/9ieRgzvvpXs9xdZy3GpbwjCs95hv1Jeq?=
 =?us-ascii?Q?Z9xmXtA1fxNXhNyirh1Cxe0vzpGAPF1Qk4PIk+25pgq7T61tksmhIxyNwWak?=
 =?us-ascii?Q?vNvyuhL1leF8sowOLl1TAcncwxqYxVCb8a5lx9zq0qacHnPp0uKcFU+EgtBP?=
 =?us-ascii?Q?hixfhjQTuKAhiB/vwwKK/0MIVODkruIEVkbFwIs4ry/hvKLHplU1gr8TtVcS?=
 =?us-ascii?Q?emd7a0o+9fdxBKdXxNNJvCrfzOFATPcu7VhfugVHrF7lwPOVMcbxLL1K4oQM?=
 =?us-ascii?Q?8lF4nKNh0P1n0R8uPSDGroq+fR5HSsCsNRZPoG7SFUw37p0pcfV7eaNEuTWZ?=
 =?us-ascii?Q?SdgGgRbRuHMn2lH5y0eGwsEirby9Hy2lEPF0aJNvpjDk7KJ3W29CGEW5c9zb?=
 =?us-ascii?Q?w73lCruFGieyNY+xrLixqFLUim7CM7ctGQoXvQ9MDpek/fYIY550Zx53/6Z+?=
 =?us-ascii?Q?zpADhg/n3FH3VP7umXT0/AHYFY4UdM8AEQYWvt1VyHs4iXnqlXnZ3Hc99o5N?=
 =?us-ascii?Q?IiCShSYwMeX9RV0f5syq6qC1Pcy1v8CZhdlD1Yg9VPsrtT0tfGcYDLi+tOWU?=
 =?us-ascii?Q?UrIPW/CFZQGihKs2f09GobcBTpUmCjJz9JUp0JbthVbiodefTE3l/xGCufQA?=
 =?us-ascii?Q?tip/EYPa+0+c07BX6LcZEiYyNgpPfdjSScNsMVeO7DmEGRsg3BzghwYTkqcv?=
 =?us-ascii?Q?I/jUfKwQ0MP8h19hZUHKza4UG/BHX3gXQbt8C92bZKWK4HUYS7rfCQDrfF4Q?=
 =?us-ascii?Q?uA9HetVwjmRwoPziHO2FwId/gVql5qDEfQ3ouFJaOwRzE+KirtNdZzD1Smwu?=
 =?us-ascii?Q?1IrogspAyVERcw9JyE9DqU0TzUTnEzg2AL1v4IpuaxdT3A8kObIe0UDyCYoi?=
 =?us-ascii?Q?nkOYhJ4BkmwvbfxG2cdgaXKGZnfC04uF25wHxEAyJY4om1GezRLmskEVi1nH?=
 =?us-ascii?Q?qMEVws4ooVP8I9O1O+m7EIEWbr/1v3oRDmN3V2jcpNf2IaS6yHVhG/pVp+Rb?=
 =?us-ascii?Q?yf0ix+fNY5kgl/jRB5TG7ABfX1fJiOcDDXaToUQh/WKhm9yi/ZKR+5SOePyD?=
 =?us-ascii?Q?OuWbyAtAGZPGJFXLm64OdOR2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oCq2DE7sdj+r6KqJ3Xzj3nrSe7e/8DeK0eWXSXT9K/m49pKP8WuVuYpmAaI0?=
 =?us-ascii?Q?nBLxvCI+Ys2hK103GrQsqoi/4WpkLnfyitUxm7Ph+j0d5tNmtZTAP/wOOlow?=
 =?us-ascii?Q?ImLVF6/bSCEDi+sfzqpJbgE2J29lTF5WEtPp2evp3bBunCrp9QtIl6ilhRcG?=
 =?us-ascii?Q?+TiXdbavmzaOAPiIeKU4uSu6HE6O6rfQlL2O2QXdY3HwZI1rDRIepplBjcV8?=
 =?us-ascii?Q?Qm/FwiIBMA/IYcBPeD/0W6IIr7rqvX7t52SlES5vXIh1a/QwArMXFHFvEW6q?=
 =?us-ascii?Q?jSonvZl65NXuzL55GN5E9v3uePazJ/RHF3vxulHkkrZhxsf3aF9h9ZNAxUMm?=
 =?us-ascii?Q?5DphnZLODrc1XOLpaw3CpCUs8usKaOz2VxkCRXW7b4faRVsYN9WfCMLVJ1ze?=
 =?us-ascii?Q?ij8wK3tKHGT7zZvx+G1KcTvIKMCKrgkvE7WdRC8J34sSoaoavP02VGOu0+F5?=
 =?us-ascii?Q?081X2+t1D7tW/Ds2sFYIZb/rkHV0NSe10gvi+Cm52lqPsykyMzDgtMMn+HZ5?=
 =?us-ascii?Q?Lf1bRAPzVnc2hDon/ySwDrSQurm0PYYuj5D4bU1+s3VOfIo9w9fJPvbn/s4z?=
 =?us-ascii?Q?QipSSImyEeIDY/iOG/xu/BCQTKFF8ji2nRvNrpzUCqNVCmlkm8bSvh6fUa3M?=
 =?us-ascii?Q?puh+8I28rg2r7dJZG/5qv5zwAkhiQhVJZPcrebYNwhvObndQH4xsxLu2VWBu?=
 =?us-ascii?Q?NCrQD5kU4emPl8ZSCbYjONImvHSS1akBceqIh30HjPi6TTU2huw4Qd/ir+0S?=
 =?us-ascii?Q?8sRNR0ek9tjWpyOkYxMPEKNDGpCY0UkPk4/KIBDdJmo4wk+fHTCMiXwDRf/C?=
 =?us-ascii?Q?Tti0M7UKvLTi8d+n28vBWt5PHwTg7W0ov8L+MogPofwfi1yn3m4aggbSbove?=
 =?us-ascii?Q?iW5jt2njhRnqOZBWIWv9YMzT7YWEzMJFTLoo13Qg0zpbweiFnfrlg3LNetYQ?=
 =?us-ascii?Q?FqlKwJA2rozQ96aGzUNwGfRfn/cXJi28wE9MsvKVnkgd7ABNKAuy3DVbtwDf?=
 =?us-ascii?Q?rJRBw6Z2WfGyFE/glzy1LGhVSdXeteKmtFj4mkCA0fCVo+ye2r7tUx4qcZAS?=
 =?us-ascii?Q?33SoHZMPMcS4EwfcYncTLLNfkBc2+UQNQbpfoCPZzEeohMjYebD9J7ndws5N?=
 =?us-ascii?Q?dUtMTnE4I4vYJu2LqNU9GSCL/MlgYNa1Mz8YtBPbESkLWj3LoXiJUL679rBk?=
 =?us-ascii?Q?gkEwkL9JbkLsSBxLQIIWRGUnrU6VhwIh58R7KIHg9HeNYpRA2rDH88tdXIPL?=
 =?us-ascii?Q?KHznwrXf/6RX24fBgm7xFDC40Iqd7ymYds5Hvg/UF+v/esK1oSE2p49LSZuy?=
 =?us-ascii?Q?Ex1/OCSlpwN2zmzUS038Y264byn8GgFV8j4g38MAsiJVNB3NQlWlyIqnrK5p?=
 =?us-ascii?Q?S4ejH1ZcvHJuJK1RdRcj1yixHMWo4yltx+YExO8j2wv3kZtrDhPUpkA07jKM?=
 =?us-ascii?Q?EDal67CrTBB2jB+Pf4KcVQwRecfYk9trXVW8ysuA7eM5B9WpbJBVGXGH62mO?=
 =?us-ascii?Q?wLnztpZk0vwErUYO7M0wxHhCfN/7S8WfyyLsNYLQBOosdWN+1XJFpGgM7K4n?=
 =?us-ascii?Q?zrS2rlW1S4xmQQcDpPrMFDWQioRiGhTob7n2ocv2yHM8n5vFGD7dltUyCz6s?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e4vjIhshNh/Co8yQir3VEnhqoPFFvxx/GQj9chvJza/OOC7+sSgym4iO1YVNCIxgq/RaVtw6UyDC60jbBD6a1Z31h7jjEqno0ZboH13rLl5s6ouFMtyPQnwHHvcBQsliswq3k9TJNQUg9+syYrc9MRTJ/+nuytDHrz+UFhbTVNaSGd0eAaQ4378YVzfL2KsNMFAVjUtpjtZh6oeQ7pUW82yQpZi8lMGuPZj6S6XzloNc6V0+PvvteSBCAfB7zYH0AXm6NhlfZnEhunygMqcP9NPoCjwlERsUIxATo1Hlb2n3WQF5z+bHg45PIjGlesVxn8GdHY4zHL7lFfAvrMilKCjXzdfgrcuwSkOI5jayWlERtodBPF6HavblwiOiKOZAkqboMOMVp/TC/fUaexvkyls4iQBdwf+l9zA+H8ZdIPdgXPqQyK3QoQrE28lE4b7xH9ra2rE38UNQ5TK32qpvGNiRnd60nqWgxsMugQHhaJxDNOiTHH3nNyRLNQDpWqyktIEgFzJkpfIMjXdNtM8dwRgAtaTTn7KfgrCaa5IB3MFifS9HwiTS8+TSvk4OLfm7k0iW3fo7VQxyA+nERtKYQlp3gdNN+GjBG9LVKgemWWg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b512ee-24ed-4995-e0f1-08dcee1f9652
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 20:17:41.4040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/rTvBxze49jguMUuZ9AWCP87yAQMKh+hKnvBrfOxPN9bQCiSgzDxeiW05rwFyZP8LmsTEN5QzQPiLCzyprmsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7579
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_16,2024-10-16_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410160128
X-Proofpoint-GUID: WEE5SXNHBXo73NwsSxnWiw2GK66SggP-
X-Proofpoint-ORIG-GUID: WEE5SXNHBXo73NwsSxnWiw2GK66SggP-

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

mremap_to() has a goto label at the end that doesn't unwind anything.
Removing the label makes the code cleaner.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mremap.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 648c29f568af..5a1eb3da730d 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -883,18 +883,18 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	unsigned long ret = -EINVAL;
+	unsigned long ret;
 	unsigned long map_flags = 0;
 
 	if (offset_in_page(new_addr))
-		goto out;
+		return -EINVAL;
 
 	if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
-		goto out;
+		return -EINVAL;
 
 	/* Ensure the old/new locations do not overlap */
 	if (addr + old_len > new_addr && new_addr + new_len > addr)
-		goto out;
+		return -EINVAL;
 
 	/*
 	 * move_vma() need us to stay 4 maps below the threshold, otherwise
@@ -921,33 +921,28 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 		 */
 		ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	if (old_len > new_len) {
 		ret = do_munmap(mm, addr+new_len, old_len - new_len, uf_unmap);
 		if (ret)
-			goto out;
+			return ret;
 		old_len = new_len;
 	}
 
 	vma = vma_lookup(mm, addr);
-	if (!vma) {
-		ret = -EFAULT;
-		goto out;
-	}
+	if (!vma)
+		return -EFAULT;
 
-	mremap_vma_check(vma, addr, old_len, new_len, flags);
-	if (IS_ERR(vma)) {
-		ret = PTR_ERR(vma);
-		goto out;
-	}
+	ret = mremap_vma_check(vma, addr, old_len, new_len, flags);
+	if (ret)
+		return ret;
 
 	/* MREMAP_DONTUNMAP expands by old_len since old_len == new_len */
 	if (flags & MREMAP_DONTUNMAP &&
 		!may_expand_vm(mm, vma->vm_flags, old_len >> PAGE_SHIFT)) {
-		ret = -ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
 
 	if (flags & MREMAP_FIXED)
@@ -960,17 +955,14 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 				((addr - vma->vm_start) >> PAGE_SHIFT),
 				map_flags);
 	if (IS_ERR_VALUE(ret))
-		goto out;
+		return ret;
 
 	/* We got a new mapping */
 	if (!(flags & MREMAP_FIXED))
 		new_addr = ret;
 
-	ret = move_vma(vma, addr, old_len, new_len, new_addr, locked, flags, uf,
-		       uf_unmap);
-
-out:
-	return ret;
+	return move_vma(vma, addr, old_len, new_len, new_addr, locked, flags,
+			uf, uf_unmap);
 }
 
 static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
-- 
2.43.0


