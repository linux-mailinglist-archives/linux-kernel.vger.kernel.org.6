Return-Path: <linux-kernel+bounces-376935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 737EF9AB7CD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5FB283C38
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578471CCB4F;
	Tue, 22 Oct 2024 20:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BZrx4mew";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wTJ/5LRb"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809301CCB36
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 20:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629687; cv=fail; b=X4ew1SL/f+LptPWFopGCFxW678PkSQkzLz7AxBIgXM7+5RA0AClRMdytBBRCzbKsYggaZvlfpN9s9ad/oprfRzDeUSYuB+nXlc/k02jl6OOtMtSAJd6K8bAQrM3KzlmFMljSDPPbZ6NX+ZbC81VTqARcuyQ6BO7aEwcDHsqwj9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629687; c=relaxed/simple;
	bh=Ty3qdli2iJOzZBFUaHrtKxy9P1Tb22fCbh9E03n9xLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aV1DatH6aSb5WwljJVMvllbXusIVkSivDyAbgfJlTYnNntonRjRN1X9m/2QJPy4wJdzTQX9d3bwlKTDRRqBfr7OsEGlT8K8Tzap62GO7bLqCcknBZVXcVeuQ2bxp3v2SbTh+9w9b7/MNUjswscp7Lm6e7gXb6dMkuERKq3vT798=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BZrx4mew; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wTJ/5LRb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MK3YdY013268;
	Tue, 22 Oct 2024 20:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PjHEtf0t6dnYaFIMePzzq4ewJmFLT/0zq4zRJVRV9/w=; b=
	BZrx4mewpVIUcf7/MShtRvUhM6W6speBCmot8W2Rk7zoJh2UGPMnkW8N4H57pe1n
	PnYWVoAVOyDgcM+R5SQpTeWqSSgFAjspJe7Bffd1deJrxDdKt1xZ/8BEufwTlJMe
	S0zlro2jpBk6RinPjMo/AiXYvK6cCx0yfHUQU6hfqtBHsx5O7bU61M+LHKzut4PJ
	DV9C1SMQo/eAQnvKQyeSKudNXl5qkX4psXY9xiv+CWeCHUlIAYl6rkJdTU7wkFy8
	hzdz5v8qY+2kTNxBF6daRmixLlDY4UaQlUMecRfpdMZvCG5Pn3y+omvCBBFodhDl
	yGBHTl94lvzC8s7FB4JYeA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3dsuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 20:41:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MJWbiV019683;
	Tue, 22 Oct 2024 20:41:15 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c37ef3fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 20:41:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ch4x8gcGhoeXmO00w/f4rd1FJi+f5FqTwJX8shzylK1q7QlwYiS/6rskbynSX5h44MNCbhd0X6GehO0DSxcEZOvauBDR0rg7O+CSWd1SHHeM5iIaw3twg/rn9qJGGsbHwYeKjmMY34yV9krHoMm1d+yFKObg9CAJx5xXgbPbygrF2oD65UIK7I6Xf3lAiXJmJE2KZnpd10gG09iksKWsk8bjJMq7ArotjSPxIJ9f8X9PWZizjYUW7EEWVEWAFqEKghLp8LgmQwk59Nrcx9somUlym3eT8Q0VqjykWYykDsZcVx2EPDgoPvv99ZLRpK4XJVVntWgjHY+5xKByXUnnXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjHEtf0t6dnYaFIMePzzq4ewJmFLT/0zq4zRJVRV9/w=;
 b=EV5p5tkKOojlQQR/XsK7XE7TpZ91vZaCT/NSP11Xktu4ElwG00gPXE7VXfoJFIwK/50DhNAVBweTJfL/rS4ywziHtHQUVn2qCyH8C0WF8DQwW16QCrEYx3+KLDOlCdv3BxRs4IGwuz0hw/OE2IzxwjtyL2gZGC2m5QCHoRcxs4zQ+oS1HMdasz4yQsFRuy46A1f5TTxs1RyfVrXUCMfOu+Trjf8RCnY+/U6pYhZw1uW1IqwoG+e2VjXroV9bZynLnFKRzjDionTFvYHqC7uQU5me21G8zbO6sFh0xYj7U2BQCX87Vv25J+Rg71vXWHA8dShSsuSx5ZTGB1FzyfnV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjHEtf0t6dnYaFIMePzzq4ewJmFLT/0zq4zRJVRV9/w=;
 b=wTJ/5LRb+dP/Y2llETdj8rZBm77kKWWRg4Dw8bmBbFMmaRPkyw+uBVDQbj1Knd6HD9J3snP5rPOflqdfillGPoM7yVLtWoG+I/VKUKgLgq344kGwgI8FcD1xC3FmXDE1R3xKDd2c9Mwqgh/gvOl3zopxFUF2EAbbOYmNsuNp8Fs=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB5879.namprd10.prod.outlook.com (2603:10b6:510:130::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 20:41:12 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 20:41:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH hotfix 6.12 2/8] mm: unconditionally close VMAs on error
Date: Tue, 22 Oct 2024 21:40:53 +0100
Message-ID: <9a84bad9fdebbdb0adca2b5b43ed63afceb5bacc.1729628198.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0416.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::7) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f0d0b3-f308-42f4-5329-08dcf2d9dde2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eGQrU38wwzwvye5J79bqpxCOdaQFFaRBEdscKnT+DtSl5jrczs7IJq2i9CIi?=
 =?us-ascii?Q?YVaGeKpEjrh08NqL+g2ZvtWkdg/qyfY8XPEgxw83d49hhnC3OUTvaubNoaPH?=
 =?us-ascii?Q?5o0beGzPh0NhKg61MmY0DOiXOC9qC7cKeXeNzS3Vvry34mUx33bbH0k7JSRv?=
 =?us-ascii?Q?fpidlufZSsacTgDy5/YyHGSLy4PEYWezDD92yrbrxvpJCFM8nCf7b4wuysW4?=
 =?us-ascii?Q?ARjsm/U3Dvqf1L9kPBJaayXhjJVG3UFGJEYZqYh1MJebc/Y57OfXc/9IuDRt?=
 =?us-ascii?Q?mDO6l3C0QiA1ETTsefSFitCKbGsgRhZm8wxoawiQxJaBEi3+dkcBlLE7S+EI?=
 =?us-ascii?Q?ipyJJE3OCpNZH52/FxNTNUYceqE793JDqLumRPVfjjBq0/daK7PGVvXpHlCM?=
 =?us-ascii?Q?y7tgK043e2M7QKE728FtV9uZqsVRi6o53hKtsFR1GxYdssexkbpaYwmy1e5H?=
 =?us-ascii?Q?32Z+sJWxHACER0+6JvhyQlm2nqucpVUnforkoRV3I8XsXy25iMNBWeWIhnxD?=
 =?us-ascii?Q?VlpAZ9zpslWA1L5ddwSf3RVQVaH1dBl+8uQJGHDoncVly03UtzoKZvOaM8sU?=
 =?us-ascii?Q?h07/wz7J6ugnRDMyY6Jd6kj0WEuBkpg+U2vEU4WEeY1BWXCj3nxFzTKbgPC0?=
 =?us-ascii?Q?D89nbA3Wu3it5C8+xeElzyVOZRr2aA10GHMyMz2nk2LZkJy9nhGeeVrX+C7T?=
 =?us-ascii?Q?4sb8L3TCwWH6nfNEXjqCAYU3iSCe3ssuq949iy6i78cHpJf2S3fwaWyyz5Vd?=
 =?us-ascii?Q?YrBps5iaDxgSFZ0aAwPjfh6x8leLVOM6HfBpaYx9HE0IGaPOZ1TvXD3smLtE?=
 =?us-ascii?Q?+DchjBIgP5KGnC/vsyBTWuXWaFyPBOcRD1DWrBBQ3ZrAVmJEUa5o0uxsWU9I?=
 =?us-ascii?Q?crfaEPdGgfOEyH3BPxq/Sv0w3bBbbAyL5tFOys38uQHRfbqXDid6YwnAlRDI?=
 =?us-ascii?Q?dE3cTyg7LPjRMLQP65dQJVH8Rui5d2tlvFEN+GzpT1A6WEsejyxT1fvJWmOm?=
 =?us-ascii?Q?wsfkjZoi3GN801v4NscAfxqiAost6+tvOBg8WgxuLpCkast1GrOxCTKykQFK?=
 =?us-ascii?Q?mGXZjojsw4HGkStSMWbnIE2wLkJ0yv7I1/eB87CYuqWNz/brbh+h8lBdx8Op?=
 =?us-ascii?Q?GxdHSZufaYMBf7MBOGrsNEVpDf+Y0MNnbtXsMgmgiR158m9+8vgLLsmVX7R2?=
 =?us-ascii?Q?bhH08d2QPySfZxGn4SD2OMKJnAKgtjWzPoJ/dxYUmbvO9V3XCEVK5nEEE7kH?=
 =?us-ascii?Q?uxyIu7kUtT0fhHmY+mUJ6crex4VdV8bdNjW4U0zjeL9KugnYENILz2cAzo1M?=
 =?us-ascii?Q?wEFQTa1FuTQ52SCI9FhXGXO8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wZhTIblHJBDgKuzUokAtWHChDA3BPO0gbqyYX3P/wEpUFkaDkWSiAPLdoCqm?=
 =?us-ascii?Q?FhyUIwq8M7Ll1QF16GWdhsg4ZmssJxFHBupYgYEl8gnPBuvdGpqLbsrRKVVR?=
 =?us-ascii?Q?ACtKij9rNGiYYQd/msXKQ8pH13yqX1cNdRVDzSEIiUCnEa90kGmO7B2dxgXn?=
 =?us-ascii?Q?jR1cBi+IFToCAkJ6zWK1VyUpbfrkqEGi0GchjP4JIwtKHpaEuE45RA59TppF?=
 =?us-ascii?Q?nvPGJAVGkkjzmXId01o4uMC794UbQrfzPJJgtRKCsGm6bd06hOL9ltiX3cqy?=
 =?us-ascii?Q?LWehzh/dTVZPsWHnbTs4wP7xakMRygLc+ucjcXXUmc7NRp2EGLGXnUaf2Y3v?=
 =?us-ascii?Q?RwohMwVgfzHuW4I70rMap9AOth2VhhTAIWAVGUUMGjDCpI9gP5g+yk9XlnC8?=
 =?us-ascii?Q?tn/p9yj65BAB+B/GHgjXeXUshDZB/wD3Iy0WH5P4uO1gSfOzpSIUY71w+IuD?=
 =?us-ascii?Q?jeC38lEElgTTCDpwqX1Z9ynG/5NKAKr+RSjmwUoN7reD4Sw3C8UL7Qe8Ki1V?=
 =?us-ascii?Q?rnfteZKvJO7xs0PDUKu5xf0FKe1iRu0KmIxhD2RioiQ+MFEq0Ix5LEmOHLUy?=
 =?us-ascii?Q?+yK4u8Uc0Tqohj/89eK3TECfH5BFCgZkaCoCCHZYhG3g2pEY9W1Mws7XqAQ/?=
 =?us-ascii?Q?QaQElZOtvEa+fs2+RP742nVT9naP9E6rhLkUyoVprtgT/pwgaLQBPGmX1gLy?=
 =?us-ascii?Q?vAxrKuwM9CXCbChTawJ2t0bqDsI76jyoclZmh31kLiRS31Llq4hrlrzOP1Yv?=
 =?us-ascii?Q?UJgvh4cZi1AeisQoT1j0/ckLmSLA9sKdKJU06vkca0kKMun6da9iptjhTm2R?=
 =?us-ascii?Q?2AuOPDDADFAOe6Ry60gZsNNVbKvcXanAfhdsxkb8y58rjnSFfufUZPrkAgSs?=
 =?us-ascii?Q?11dQ5ZokILSCubf/aP1fcLrZ8n7edMHTZXVrwyjah0o7rsPO8rtKzO/cZcya?=
 =?us-ascii?Q?zu1Ccn1ML0OwNCe6KZ+vRL3HeU1W+7jbbQF0APMn0HVQhH93y6u98lmjPgRX?=
 =?us-ascii?Q?2F38YUC4BpZQ0gBlp5bYZxYJHWOy59LXupLeIUcJFOJ17xhEqgSgdiyeH+7o?=
 =?us-ascii?Q?SsBw49J175uMBaI51m/gEJ/Ueh6ob3ecBohoy8TLPZX1SIvQEmObJlje1XbW?=
 =?us-ascii?Q?34zQAjfGgOlfhreH5BWnzQXqecraXsLa+NzgeqNji14HW1nqTYGdfSEV8mrr?=
 =?us-ascii?Q?RK91eUnTG4pw+LVEaJC4bdKcv+L9igVTmSYl67w317y91OQnc1+8O5LgQHUH?=
 =?us-ascii?Q?Lz6/b96rbU68PwZ7Zf349ZoJADuFhp1rEO8UQ5Ozs6rWOjGBHPBP+EElcEFp?=
 =?us-ascii?Q?hG41hOQOKxiw7LFS3hz+7MQILy5I80UuSS99Wm5LO1QvPL219T3PtX/HJK53?=
 =?us-ascii?Q?qsE3OSn+MdXRlfv6AK++z3AH5NNtmu7xiPW2Hj9mwkBFLExZEZO++l2Q414g?=
 =?us-ascii?Q?nqP0k7L/4+EufkV2uP06QxODwjNTjH80X5Y1TjeToIOmXn7B1ydq8tz+BJ2N?=
 =?us-ascii?Q?ptlfde4g50wVS3BWlpjw64WQO+IyBxvVVzYG+BmPMSm11anwQe4Xh9s4Oos7?=
 =?us-ascii?Q?KIf6Fw2ZLgK52ibEX+fOBdlNZuyZvCOjkeTJus9jKdOZmfd/RA8jHfJga5WF?=
 =?us-ascii?Q?Cv+RTmYTBA4V1chemUqUOzfSOl8H9L2b19UzKzQlTbNGfl4Ofar6CysjHRHU?=
 =?us-ascii?Q?cUdQhg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CB+/3eOtNrnw3NeH5cO3Y9t2vNpwc25OegDmla78hYOHI1MVtLRMk2TUnEsYamzRk/4BSlPDd07cEaJuln9Mxz9ifrq49y/fy4v8Xm4dhRZ70m3DiCpsPiRjTujriTaFckm7LkRvxc5fxdl+QqZuP6LQlOkZUkuSHP1Pv9kAqSG8uBYlN0MIOlR35bcKq773ncZZb1sH5UfCc6kA5IokeJoHFYZsi63PwIswdgaAEJMTQ9GfRUSXJsDIIKbpzUtrU0hPVPebqaiGcgZtggpDUGM536hY8ozZ5fgeSicNfcA+1LW2hmy7FY3+4+4dKdn2dxP2B767EARem5rUun/kdHALam65pRmhfuTypIsaTJCwvvvLVeJ+1KazO0HOW7PZH3o+J8I2uSr+Fo32TruXo7Qpubzp0oKZ0LY/Gqo6Bjjym0kIfTwU3uMBonQUUgh3R0L1socXisWlWfL3vkPAtFNkguJ6TtGPQef9w4yttKfI+AJliaLOZ4QLbs53GzRbBneSVgfbWeH866XaB1WhBWHddmEx37f9oxxcP/BB+/cWlxoaYl6AQ+sfy9kBN5GQJhev6ydfOTjpiRlkkK7c5IyVZMO7jy8Pvd8unW8OHsk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f0d0b3-f308-42f4-5329-08dcf2d9dde2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 20:41:12.6586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCx1MzieMdI2YlRHT4ddYf438j+3cI83iFpPEuKWPH2sib+DhX+4gvpGseuDq1g81XevfjzTKXgQIrWwzYyF7kSeH4NoRZMnTlY+dKQcTIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5879
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_21,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410220134
X-Proofpoint-ORIG-GUID: W2EFi4ZGfqTeh4WURatfCC1aiD82zXZK
X-Proofpoint-GUID: W2EFi4ZGfqTeh4WURatfCC1aiD82zXZK

Incorrect invocation of VMA callbacks when the VMA is no longer in a
consistent state is bug prone and risky to perform.

With regards to the important vm_ops->close() callback We have gone to
great lengths to try to track whether or not we ought to close VMAs.

Rather than doing so and risking making a mistake somewhere, instead
unconditionally close and reset vma->vm_ops to an empty dummy operations
set with a NULL .close operator.

We introduce a new function to do so - vma_close() - and simplify existing
vms logic which tracked whether we needed to close or not.

This simplifies the logic, avoids incorrect double-calling of the .close()
callback and allows us to update error paths to simply call vma_close()
unconditionally - making VMA closure idempotent.

Reported-by: Jann Horn <jannh@google.com>
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Cc: stable <stable@kernel.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h | 17 +++++++++++++++++
 mm/mmap.c     |  5 ++---
 mm/nommu.c    |  3 +--
 mm/vma.c      | 14 +++++---------
 mm/vma.h      |  4 +---
 5 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index af032e76dfd4..3a45cc592fd0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -135,6 +135,23 @@ static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
 	return err;
 }

+/*
+ * Unconditionally close the VMA if it has a close hook and prevent hooks from
+ * being invoked after close. VMA hooks are mutated.
+ */
+static inline void vma_close(struct vm_area_struct *vma)
+{
+	if (vma->vm_ops && vma->vm_ops->close) {
+		vma->vm_ops->close(vma);
+
+		/*
+		 * The mapping is in an inconsistent state, and no further hooks
+		 * may be invoked upon it.
+		 */
+		vma->vm_ops = &vma_dummy_vm_ops;
+	}
+}
+
 #ifdef CONFIG_MMU

 /* Flags for folio_pte_batch(). */
diff --git a/mm/mmap.c b/mm/mmap.c
index 10f4ccaf491b..d55c58e99a54 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1576,8 +1576,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return addr;

 close_and_free_vma:
-	if (file && !vms.closed_vm_ops && vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);

 	if (file || vma->vm_file) {
 unmap_and_free_vma:
@@ -1937,7 +1936,7 @@ void exit_mmap(struct mm_struct *mm)
 	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
-		remove_vma(vma, /* unreachable = */ true, /* closed = */ false);
+		remove_vma(vma, /* unreachable = */ true);
 		count++;
 		cond_resched();
 		vma = vma_next(&vmi);
diff --git a/mm/nommu.c b/mm/nommu.c
index f9ccc02458ec..635d028d647b 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -589,8 +589,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
  */
 static void delete_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	put_nommu_region(vma->vm_region);
diff --git a/mm/vma.c b/mm/vma.c
index 3c5a80876725..bb7cfa2dc282 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -323,11 +323,10 @@ static bool can_vma_merge_right(struct vma_merge_struct *vmg,
 /*
  * Close a vm structure and free it.
  */
-void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed)
+void remove_vma(struct vm_area_struct *vma, bool unreachable)
 {
 	might_sleep();
-	if (!closed && vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
@@ -1115,9 +1114,7 @@ void vms_clean_up_area(struct vma_munmap_struct *vms,
 	vms_clear_ptes(vms, mas_detach, true);
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		if (vma->vm_ops && vma->vm_ops->close)
-			vma->vm_ops->close(vma);
-	vms->closed_vm_ops = true;
+		vma_close(vma);
 }

 /*
@@ -1160,7 +1157,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	/* Remove and clean up vmas */
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		remove_vma(vma, /* = */ false, vms->closed_vm_ops);
+		remove_vma(vma, /* unreachable = */ false);

 	vm_unacct_memory(vms->nr_accounted);
 	validate_mm(mm);
@@ -1684,8 +1681,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	return new_vma;

 out_vma_link:
-	if (new_vma->vm_ops && new_vma->vm_ops->close)
-		new_vma->vm_ops->close(new_vma);
+	vma_close(new_vma);

 	if (new_vma->vm_file)
 		fput(new_vma->vm_file);
diff --git a/mm/vma.h b/mm/vma.h
index 55457cb68200..75558b5e9c8c 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -42,7 +42,6 @@ struct vma_munmap_struct {
 	int vma_count;                  /* Number of vmas that will be removed */
 	bool unlock;                    /* Unlock after the munmap */
 	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
-	bool closed_vm_ops;		/* call_mmap() was encountered, so vmas may be closed */
 	/* 1 byte hole */
 	unsigned long nr_pages;         /* Number of pages being removed */
 	unsigned long locked_vm;        /* Number of locked pages */
@@ -198,7 +197,6 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->unmap_start = FIRST_USER_ADDRESS;
 	vms->unmap_end = USER_PGTABLES_CEILING;
 	vms->clear_ptes = false;
-	vms->closed_vm_ops = false;
 }
 #endif

@@ -269,7 +267,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 		  unsigned long start, size_t len, struct list_head *uf,
 		  bool unlock);

-void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed);
+void remove_vma(struct vm_area_struct *vma, bool unreachable);

 void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
 		struct vm_area_struct *prev, struct vm_area_struct *next);
--
2.47.0

