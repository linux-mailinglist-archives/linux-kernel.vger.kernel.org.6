Return-Path: <linux-kernel+bounces-231153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A7F9186E2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2D81F21211
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FACD18F2C9;
	Wed, 26 Jun 2024 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cPaeS9FU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IaeOYPFL"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DAC18F2C6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418016; cv=fail; b=W99fjFdyJbigv9/er2/RAWnA1+p81Jio5H2LcFu9SSrsC4mZEgRoacFuASkxLeHFcPYw2yzm11o2yP2/Wkp8HSV8wXakqhGpuUqy1ZImJ5eOT1QkFymA63LDpGy5qVaxG91UG5WYRmlftBmQKbnMA697ubx9TV6TkeztWprCgJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418016; c=relaxed/simple;
	bh=eJ4DtGwjQ+8+7B7DjQ0XTk9lMPcTCCgiFDnCcIB5wH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CIge/rPI9w92KHC6IsQCQL2CL9X8PX36XgxGpR554uUPCs8ieiCr1NNEGDRtqEOa7zL9GtxMfmIDbwVXKynRcIORmShrglLDO0iIvkNbt986618HT5/wg5X02F+H7OMcXPCteXfRpzoEfeBYL8py2zyoa2YZx+Lc3bBen+4sdyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cPaeS9FU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IaeOYPFL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QEtV7V010974;
	Wed, 26 Jun 2024 16:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=gM6p7keAHnECOjt+PKvFW0zRiB40kIEnG7o+UPDsALw=; b=
	cPaeS9FUI9ESi5RHpyQRtpa1hlU3Dx3eTKbYzLcFA+qxZZ/uaK+pSsmvlcZ9z/9t
	r1NE0ZZgC5pCKek4NLtCrd230iBC4McnHBD63dB0t/xjbVC3z+GivQdUK73bYGO4
	RFZ6Nzi+u5rwDpbtIN58loT7p5ejdi4zxLIBF0P4KRm/6+LpgOBC1Tr1aUvmKMZM
	khfsFlHnf6wPdWvxWrPi819rvNdR3cQOUYFJs1MMQSyW7jfL6VlUvE9Y8bL25CnV
	UnWKvbNJ7BEULWLUspwuu+JGU6XFR4j5iNhI4YIKfE4wVfYDNEHTxtwfzhaf511t
	VS0v0AOrnRtultHIP1cTyg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpncc0wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 16:06:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45QFlvKQ010721;
	Wed, 26 Jun 2024 16:06:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2fr8my-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 16:06:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+OBVLwMNGUyrSiMvlUW7ts/AMMPZRIwvwrNR2hcq1w8c4af4PMFAUMRvnb8wXukbcYcDZujC8dBgk37OXHCaBMvmkK/w+1BbSAngOErdhhHkLo3ODCZfza21auqjiAmDlxhV6Ev7RXMRZR9um1GMBWbiav5AUb3IgTGzyctiWb1CeXDUmoYJHYoUKjrl7w5hFZm1J5cktz49BgJkSqLrHVoFkAbXZZ+66/tIzpfLjAopde5bI8JQfy5eQl9Io6EmYEeWaMbeh6uIzh9Ri2GHuy0h5NjQbtrAAgWQCGvFl16QaLv9b8kLF/f04/xYP4TkQAvoFeJLsB/IB4YVQNEjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gM6p7keAHnECOjt+PKvFW0zRiB40kIEnG7o+UPDsALw=;
 b=lUA0vUOH9ZDoW3AKjB7XyaMKoUwLX1exevaGXnBdRvQnThpY8/VOwDIHci7JKz9BShVrcfvY4ruFO8dqXmZeCuwgZJlgbwmCuVa8REj+Vc2vCHZMi4hTveld8q9p5cTZ28D7ond9emGDSMNPp89zc9CiBL18VxjT61oIf0WnOQs25rAxrNo8ox/T9CjukUDJ7sMAytBPA/a+VyGkgo/TXfqyiAOZZ5TmvAb038jKKr+mqd/3C8v4UuGPnsuqS5ZR4uVg3z9xKQqMgo5p9Q9xS49c/yCZ2o1Gt+nG5ZFBRLEdO837RX6HZM3frXBMM2a69NaPfEPNBGvOVOKusK5aaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gM6p7keAHnECOjt+PKvFW0zRiB40kIEnG7o+UPDsALw=;
 b=IaeOYPFLVGre+GUnT4mCkyabO7zcLou1OZFSMGLPD/hm780QREgKM8PyQPefU+YHJ4jTIp/xadiRppD+ncR6J7vp2nlGS+Uav89XxSmMlcmJocMNKBel8wm87jLwyeOHRGwnTTcojoryOAdhxbTbHu3oXzbFtrEjEccSmtp+kOo=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB7225.namprd10.prod.outlook.com (2603:10b6:8:ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 16:06:38 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.032; Wed, 26 Jun 2024
 16:06:38 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Jiazi Li <jqqlijiazi@gmail.com>, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 2/2] maple_tree: Add some alloc node test case
Date: Wed, 26 Jun 2024 12:06:31 -0400
Message-ID: <20240626160631.3636515-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240626160631.3636515-1-Liam.Howlett@oracle.com>
References: <20240626160631.3636515-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::25) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f3741f-c87f-4005-8e73-08dc95f9f56e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?JhxLO+qk7QlaND0efNs/eK1Ha7oP85FI/9zQPkhwLEOASFWUAEU98dzqb4lx?=
 =?us-ascii?Q?QVfAi2ZtpAQHrtOd8AO+vAEZByVOgEiXtCm+J6eLH/FNCRPn+F7X2zXcFLoZ?=
 =?us-ascii?Q?cQTvz/wz1VlZrB5ZWV5nGq8zTnD+lvPOenIqsYv5i1/NFxNtFyP/ainjgjxq?=
 =?us-ascii?Q?ynqedXLqjRfEeSD0lGFXIMZAmzOVjE3FWhzOWozCjAT00gNPx7Qns3zLD2/k?=
 =?us-ascii?Q?saNsnYMGiIKmbVIafvYlcm/7p9vOn1JVxfduPGiIKUrW23Iy/ouXKs2Lw4v6?=
 =?us-ascii?Q?PCGZnepB6Yg+BYG40r2uwpsE0DrYft9blMQxAnauk4wJ5jvCxyC2Fcpi02m6?=
 =?us-ascii?Q?M5fv1VWQGbzGAS68x/EHwl35eGsfdDsihlJy8+HpKBayQNktsQMO9nsewDDa?=
 =?us-ascii?Q?J/X6QptnZhzrhSwukpvoenZhRZt7jcM0n+JbJ4/36aDEn0N9bJyhorc/75Kf?=
 =?us-ascii?Q?aRqVXeOKbdRlmM8srAdUHCDyjfvMBZzaqbCo4URQu+1FZkOoeHzdYhPGbsMy?=
 =?us-ascii?Q?6/puj9owbFPO3gd1RLADKt3JVsYzfQ27YZ1sysL+6BgADGA1le+pIg6UHV1I?=
 =?us-ascii?Q?/BEohhY2mKIvWAa5xRcEBmUddHKkuN4A5vZJNtHuStERTFYI4/ENMmnSKNAt?=
 =?us-ascii?Q?FJFmM17NhwAMP2nsZuIbgvsjjPYgJPjqJ1Q0bqcy+vzs8eoT2sd9JTIIdKgo?=
 =?us-ascii?Q?53ne+DuGCkVMpK6euLOXkO3RXxuscgJEJGsqXdoqafs59AJY1MGbmeVz9Szv?=
 =?us-ascii?Q?cCwlthlI9/D/9krlCPB4G6gM8hav87xV3WmTCOcmvRQyjExc1Dmpgb7mWsoU?=
 =?us-ascii?Q?dejort/xvybDOPd0o7RRjN9VnrWurxG2R+Z+IneoI/VfPJliUbPBt6QNtnH0?=
 =?us-ascii?Q?JcVK6KuGz6eQJQvAnZcMgDHLiQdTBWEMGFBCyV+G8txiBTyZZakWuSR+eISI?=
 =?us-ascii?Q?9RsbVBa060xnQ+QL8qkTzAGd3cSvT4DP/9uoKzSgj3VRRQGyrUANwPZgpIqL?=
 =?us-ascii?Q?MAfmIc/aFfCiXS+xTkjbbzEMhaZAP1pTVs79Xy0vtrs5DnYud3YMRtU/uZGr?=
 =?us-ascii?Q?db1x17TxgdH3T5glFdqp35rm4JzdL71Sme+2G8ljE6s0/frPWsNETh+onn1m?=
 =?us-ascii?Q?UlC7HS2h0VX4eUPrKhyP2myYrEW8nLWWIdWhhpn97X0YESFkMHA/1mRY+eev?=
 =?us-ascii?Q?HMQnVvKW5/ltW5sDuf23Bz9KffTvpzoIehAzh78yBLfu8tr7OhfQRogyx6L5?=
 =?us-ascii?Q?WKJYAvXeTlcmSvwyZ5gPbg41fSOSwMCX9t0mF10dbPcjC8R7LKc74NEArp4d?=
 =?us-ascii?Q?FAobxKfeYrlTfu7q2sCsdv1IJ5S1ywXHc440dImg1eIApw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Nd71TbzdR6WMzO6Lh+RELeuJRfxR94OBzX4GZ/U77mK8U7GP0CtOfaqI+JkM?=
 =?us-ascii?Q?k/S8fUo1nWBNBiBoo2Eza5qxQrNrHWjCwf0bDtiWP4Q+J4io/XlPP4LOE2r+?=
 =?us-ascii?Q?RWKaLaXYYEYM5I4Zo9o8KlQfyDsXSkwQeDV4B8VAltClzJjAUZclqoMJ3PZ4?=
 =?us-ascii?Q?Df+3nQajTMke/WCFuDUfHEY+tVqBuIJrCs0j75g0P3byLBqXR/5NWdqU71kN?=
 =?us-ascii?Q?43Qtbs3dDV+Ox0iZuxDJxkAtGca016REe7xhqlJwR6enH9qfl8X0l9PCwWuy?=
 =?us-ascii?Q?/Oin1pCuvCwAczC5nZCOsyQ+mRusOCesLRBIfmDe8sI1ItzqhRNfXEv30CP7?=
 =?us-ascii?Q?qIwYc9zsIoUY026ThaqnFnGtPnvKd3mLaT3cV77m3fLZfN1y5YYH3Totne0d?=
 =?us-ascii?Q?YjmcCLP11jtXJVaPat2EcruwtT77QdVlOrzpgRzBmnpZFnMeLIz9AtGDJikR?=
 =?us-ascii?Q?maDINYeoMx1Ue1G+2Cw01+63YFn/HWvQ6WqYmDBIbJZI9XIWYismHS9ZPIVZ?=
 =?us-ascii?Q?UsTOc9n2HhawyWgzNlkve9aIv2rjG6exoZ7LNNT7VEvG9NckiwgkdLNz+7y3?=
 =?us-ascii?Q?og3m6FkRBJZuwmQCNoMQxV8lxoBQYC8oT67bFZ3rxUKwtHU9LZcx+9pbGlfC?=
 =?us-ascii?Q?jaOpNnoTuVVbbW6zzm6VDStWYMsB2FFsI9tNQJ8A1EcA8dUF5bDjZ3hquD5U?=
 =?us-ascii?Q?XJrLqi5dSWNSBzGr7nwShcdj/3VtqSS0GDQI/2m1UX7x3f1UC27QftybgNfz?=
 =?us-ascii?Q?qcUb9Bkj1N53JcZ6rdp0ctneh2kSjNEyjrVA0d67pAp3E81P1Gw07cjCTi/z?=
 =?us-ascii?Q?9yLJteD/evrWno+KVaTGdkIuPU0ilSi9rReeJLJYaBm6KiDiv1MxWsQGs4+X?=
 =?us-ascii?Q?qW7wH9Qgoo3uHehdytgEqn1R1Vik5hAx18al7tFPnX//BkmU1TLtMnAemr/1?=
 =?us-ascii?Q?+blnItD3sr0vUl9NP5y2kc2Tfu5VDqJugUeY4nHScdKJiQILEqytMIfmrCk2?=
 =?us-ascii?Q?SrRzsJq+4mNZwh8Gpz7IXesJ23b3PWutQmYPinfcY2CNEvkFwzTMceI8dG2z?=
 =?us-ascii?Q?/yWbRjAK0w2n/k+xvx7GWtkvgbaCSpQNJLD/wwLTzNOBgvTwBChKVT/1ZbDo?=
 =?us-ascii?Q?kLxEPhKDEkeFS4OCejHQSMZ2cIVbWnZ0Ot9OchKNJqYygAZsRUyoI8a3HmOp?=
 =?us-ascii?Q?1OxYnMcpS4mfI9S5X4s6EuBVOS6fwigXGSzTqzrWXVG0SrLWRGSlxIL3+cbh?=
 =?us-ascii?Q?mvFNbt5aqoHGblPkcQfgacQdwUGaZxQ3ez1fWW2BeSydqYCEHtSMV3Hqo4lG?=
 =?us-ascii?Q?BOhd2wSmGtUtlUM1W0HNZBpMiu1F4bC/zkvWqzwJmEYKwzc9qkA9HfEukYWo?=
 =?us-ascii?Q?w7R1ggitOrz6aIYjGg32pg2gjlYmTc93vl4AGSnXPSsNtRt5QG6OX7nULm3Z?=
 =?us-ascii?Q?fcfE294Cfo1g4c6Milu6ZREtfsLNTM5h05A8Sjmud2ugu8tpr4ghRzLos6WG?=
 =?us-ascii?Q?W9saB2cdbbcUuhg9b6cGdb+JovAx06lukgVq7n+wC+DqfvlyWphe4x5NoSYb?=
 =?us-ascii?Q?TP17PekduuDZagtAwTNB8UpqnVNVv53T5OVPt9tvSVnyQDg5Y7XscAWDxUvy?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JwAWr0E6h3GqB9RYDLjuLjsXFekYbajOQvRALH6eaagUvZHm0tRSK8m99GGlWHKOmJsMApLi6LYUYwxPbjp0NddWDfZePbsn7crhFizrV6dIfgxB8A19qMrY4yHO07+oNrmo0LrVpp4FNQ1GcqHgJSNDmX8P48/h+D9NXFnr86feN8h5TkCl6UG2fqSHLa8HKyTVkkzCVgVKACs8ZHTT0CyMDRBpLFz05rfhaVDtotkJhfg0dNCuH3xLm1zmGS5VLaZ0fFQLQRSc+3SIPWZjtXnOGGRNeJg1ME2PA310biG9+DfwsDm1VweUmZkWTTKI/73zA01exX/ud7uoznA+jUFyhHFJTeIVzNR495tB5OxhGAxFZognq883+JCCTYMSEkWuGFzQNynGk7F+0+YdKDBWsLruyk4SjoEf1dgiYlFIKBVfBRb5d4+x2Qz1ieD4vZ846u9bHm8FmDFglcuLS1XNekcLcKlBvo4mtM4vhR222XPsMT1yAOqmwsZK6TkzvaPfKBR6avhd51DPQiZnmJ9ogyOIbsQHei8drQQy9fajxdGb77FQ84Qh62mZyRvIbYtnQpO7AUXRBs9g+dZOwcr4roY7HRn7cpG/kZ8zFec=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f3741f-c87f-4005-8e73-08dc95f9f56e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 16:06:37.8233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7IHVkWfzr7nmOFTP7mfDAr5bXemAMDgtnFDFvTL345n0RBw+syNrNKec5sQnxfTf6cFXe8aqbb/3v+iGGSn5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7225
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406260118
X-Proofpoint-GUID: BCFNCShGgLd85aV7t1zCBKS4zbIaVWF2
X-Proofpoint-ORIG-GUID: BCFNCShGgLd85aV7t1zCBKS4zbIaVWF2

From: Jiazi Li <jqqlijiazi@gmail.com>

Add some maple_tree alloc node tese case.

Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 tools/testing/radix-tree/maple.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 11f1efdf83f9..b4b5fd9f294d 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -462,6 +462,28 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_allocated(&mas) != 10 + MAPLE_ALLOC_SLOTS - 1);
 	mas_destroy(&mas);
 
+	mas.node = MA_ERROR(-ENOMEM);
+	mas_node_count(&mas, MAPLE_ALLOC_SLOTS + 1); /* Request */
+	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
+	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS + 1);
+	mas.node = MA_ERROR(-ENOMEM);
+	mas_node_count(&mas, MAPLE_ALLOC_SLOTS * 2 + 2); /* Request */
+	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
+	mas.status = ma_start;
+	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS * 2 + 2);
+	mas_destroy(&mas);
+
+	mas.node = MA_ERROR(-ENOMEM);
+	mas_node_count(&mas, MAPLE_ALLOC_SLOTS * 2 + 1); /* Request */
+	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
+	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS * 2 + 1);
+	mas.node = MA_ERROR(-ENOMEM);
+	mas_node_count(&mas, MAPLE_ALLOC_SLOTS * 3 + 2); /* Request */
+	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
+	mas.status = ma_start;
+	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS * 3 + 2);
+	mas_destroy(&mas);
+
 	mtree_unlock(mt);
 }
 
-- 
2.43.0


