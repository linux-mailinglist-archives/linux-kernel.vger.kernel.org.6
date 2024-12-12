Return-Path: <linux-kernel+bounces-443001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BDB9EE569
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F552828BB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3AC20B806;
	Thu, 12 Dec 2024 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GxbTGs5J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zv3TQGuz"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33733158DB1
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004152; cv=fail; b=QOzhg0MOnTG9zOhJocA3I1AbYnwVZTzY+kjV4H+uAPvgiYftIZfBlJoQxtCYU28420FNyuhHIrcyg2C0y/n6kSUTqCcGWn2Xia3ZP+nhAd0pZD3l1a6WKSeaJMVQK2xXFoE07GL6ovfUBKxjOhKECDSULXGAhDQd2zStBT2iIes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004152; c=relaxed/simple;
	bh=wFbPSuOG/wGrAeTpU/L658s+4MSfDW1HNoePOs3PbsY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a4tgwXh3zR2Fb/ZMG/2Wy2dXY6scfxqPLZuYj02gNTPOj3sHQ4dQYOATtJIVvhmhgyhXDp2ZZFBf4kno98oL5mk0CRfnE42grWo2bLaGI6mmADTi6Oc8dTY3gJJBeAM7qUKGSnsyMyDFBKtY6ktlauT2Jz0YU2AdJtxl3lyUIyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GxbTGs5J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zv3TQGuz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC1u0xQ021240;
	Thu, 12 Dec 2024 11:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=W2uLSHXMw078tB8O
	TV1MU7tLCv8PsaCUdzR2MTKnMjk=; b=GxbTGs5JPpA/5H5uqg41EuHi/XB2Qg2u
	3UdNXIP5i9674t5Dhpq+ldsZn3y7T4bBiHl/bYQRBFoUCBkwkJK1MKlbQMCTcUU0
	Tx6A5Lf4OjO2p4/XXFZgiOdL/1gz1ni0PY3nL56UAfqDhMUjcZQrbDbWZOXWKLlO
	dCBOTUuNjvaXMXnOPEwvQ7f/JqqxkuaiIRuSFrm7tBklT58GVJXCY2+PX8pKwfmv
	x8foSbXTr4v0p3w/KVHtZtt6qumDB8mfa6EwUB9XV81Z09nWHdHpPuhJKLMHLPBg
	BFI/jcFdBbu+/eEpSf5XYHPb/uENBGLf8Kt/cSEfjgUlu91kILxkKg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ce89ara3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 11:49:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCAvEd2009463;
	Thu, 12 Dec 2024 11:49:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctb1jh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 11:49:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrXTbvY+urzrf5Efeun16LPiiMs52qROhLtHKr/k76MVzhVO4uy7PR7aaD8zMh8tWUX8g/6NWCfDFU5Sv3a55iJdGexTeFugKA/hLfn3040xSl5VFuj9JWU68U4KhUSNUSbpGfpSsrSvgFdqyP1ACf5cXxolMyJKsdX1I7fbAsYGk6Y6iDIAJVC97D28SdpKuppt8++t8efadFbLzEx1w6Mw5uLcUJnAN94dQCTy2Nx1iVkZgofhNdH0FO6BCcTEuSf1Lmyg3xX0HnSdF7CHRLkkwx6tZ3cNbLcHuujD/tf+vhIbWnhD5uwbj9xE1qM9JNwSCbW8U1VmwS5MfWKGHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2uLSHXMw078tB8OTV1MU7tLCv8PsaCUdzR2MTKnMjk=;
 b=y9J5S3NiBrSRzm1uL3qPOd7IvFHhWND156/LehdckW6wZSubsnu4Q/y3cX5qrMGLRwk8c/NJggbTQNpDEtDQWSaMp9i8JK7ObTbs7lrmwPX5+3xtsAU7o7lSF7//jVTdH+MStUqKLxkKbiNWHwc1gBeiy9RDdJ9F1Wh3F/bW5CfpcJsWHzAaTNDrVAnPhN6lX4f9ZJzx9kFz2Y79pTNLd3Y/tUH2gi3GAENF866cNauhmU+si1dXVocAuLgCNbASHyoMzjnrbXugnRb83LcO5+KjOAxl5UMY2j5+N7IfYy7aoI0r8C+T1OHqeEuPqdMZsExcrcl9jHSX47wDW1ICSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2uLSHXMw078tB8OTV1MU7tLCv8PsaCUdzR2MTKnMjk=;
 b=zv3TQGuz86cz8Wvy+mz9vQo21HWUgZn1f+SXt74lg5L9fJ7dHhn+CcDWL8qM4tEIaiF3JebeoZcdHhYhmQai8b+aYJEiaC85SlBKWv7LDEpuLl7A2DxVkODZSFvy44gOUriAackvqA3cie7n3gpuinQhkVb/BSwKQFQC/fPjffk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM4PR10MB6741.namprd10.prod.outlook.com (2603:10b6:8:10f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 11:48:58 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 11:48:58 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: assert mmap write lock held on do_mmap(), mmap_region()
Date: Thu, 12 Dec 2024 11:48:41 +0000
Message-ID: <20241212114841.55185-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0086.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM4PR10MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e23780-c847-4dba-5c25-08dd1aa2f687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GjLyMqfZdiBifFIqJYud/qrMPjcHzTmaGz7r4hj3Fv/EzgrQOJBSIida4unK?=
 =?us-ascii?Q?i99zJ/UYyjtrvXdFRjwL3sW0hf4TVvHIj642jxZhhIlnAdPkaNCr7KgqEZ9R?=
 =?us-ascii?Q?9u7ZN71PAQfxL4TiG8XbrLHdEJqs2WsRXfi8iC6A/x4KeJgjwBHPAEwGfpZv?=
 =?us-ascii?Q?3FzsmAWXFl48eBlfUgh0CMYlW42BiO8+qG32o5lt000mXM9Te4h1t/h/z+DU?=
 =?us-ascii?Q?E2c7vzhq7eBck376KVBgFh2nVSi5PXBW99fUfKjW111saUkWyBCQl3ebxZRl?=
 =?us-ascii?Q?vcqZKOGf8WenCv2h/nahDatxbQiBNM0F0emG7Cy4YYkEn/e7OKqMqJDlPMHy?=
 =?us-ascii?Q?DHTTi/binqRcpvoeF/4EGbYVGDXRHkxuMJErkrM0APrsXSRCSqL7S4fMjqQe?=
 =?us-ascii?Q?tyIltnFLyDkIXMq9Ffih0POonj+lruBvKrGqPanlsSvZ9DPqsYPhStwm8xtn?=
 =?us-ascii?Q?E9PMfUFXqeU6ayj7F/m6qFOcgogCPQSMSkKrxNYRSkXjM2eDvGS7hQ3kGky3?=
 =?us-ascii?Q?6PRTsvsWpH1ixa7ekXXKW9l1BWT3FdieHmOsNgI/+ClePDkyOLCg6ULikAyL?=
 =?us-ascii?Q?mnjw2W/hD+BeUxwU39S/ARmDSkIyK8sPqj6F84JfEzl0NzJ1P2hT7Scz+Oo4?=
 =?us-ascii?Q?T2p+2zh53kjY40vs8nKKrSA6A0PiVg3kXXZ8/3vRFzMquN90CRMMlOsiHFml?=
 =?us-ascii?Q?Lr1Bi0T3WJptNf5FjYADOmrY9vNJ7fo6C9E4+/DRm63h0hkhijVNNBHU5D/2?=
 =?us-ascii?Q?YqEAE9R3D5LhRvtGIYhE16TpU3XnB06tLVJvdbtKQSHA3xLZ6k6ASmPL/CxP?=
 =?us-ascii?Q?hPsFlgNxtISZj1d7uYSFpG3OJOGbh7ZdfyTcaE6sa9TC9A9A9qOp4P/ieqpM?=
 =?us-ascii?Q?FyC0fNwrb10npQYOvgxTn+j4Dp+7viCN8f1Bjejfs9gYd3DDgguWTQTlsNZo?=
 =?us-ascii?Q?Dv6he0sr3e/GNwgkijR3L8/AnpScv6Lest3MMkPWjyOIn8rkMeR0xXiTIWYs?=
 =?us-ascii?Q?wOFUB/gtoGr6oCZ5XHuKr1t8cfKmJrHYLRKfTcbdu9ZeLN5VNuqXVn3TOqhr?=
 =?us-ascii?Q?qGY7t/WdmcMzoOdwlw4jxismS9/Uf7akxs6ZW4SHJiHl3Y6lrb0DJpmEAN2z?=
 =?us-ascii?Q?3RfdF+9vmo/44R7Q+O7pjLo+zbR6gXTk4uQCiHUE/EL0lTmqlWs8oiioN3B8?=
 =?us-ascii?Q?/dl1w1VlM29hMitLDYP5qQbkA20Q+KNYR8Igc/6RTOd6otXons1VxGEgSkgy?=
 =?us-ascii?Q?YthtJ3Lv7hghHjSiJgUO7ym0C7dRqGthe6uc0PeuJXgsn7XEGPUaUhmtyxpV?=
 =?us-ascii?Q?Fi2xVayv8+2JdHjVWIFK0VXLOL/GeP2YNMgofLp41wTgtQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y5EX+8v4/dgZGxhBHE7emS6EDu5s7ojnrgF3vjTrf/qdWnDRZJc4m2NQXctS?=
 =?us-ascii?Q?H6JTnWzYFPWxNXq420tlW313vkB+QhI9VPF938rgxjsX4Gs0fLy3LCdU1gs2?=
 =?us-ascii?Q?eg/RI2PHHLDvGOZCbEu3hnZGHKVFJugSo9criw/eY3WH8YNdOB0B+nRuWXF1?=
 =?us-ascii?Q?qJikyPWtgQH9v9peLu2iXkLAjtqbArPgJTNPeJOF1TVK7lXIQVruGN3+PZFk?=
 =?us-ascii?Q?1fKlVRdrMevfmH6VK+yyYVH0EaNEIfUJvgneJsORmv0oDO+6PujnNTUyF0f8?=
 =?us-ascii?Q?BIkQ4gRuwflCxYvSunpN1JbW/l0+beR94oOwDaD7W9RL6unUzkoY8oMSKUmX?=
 =?us-ascii?Q?pEuZo2kj4+CmmBXcSHwXkl+PEva+9GY+tLEO6CvXoCkK8sZfVQQOugeMvpkG?=
 =?us-ascii?Q?czY8wbdlIIMlnxG1LiZEnQBgqphUpNLOmxLMtpwcej7OgiKiDPCGiGDmTrK4?=
 =?us-ascii?Q?04+tBHshKsjMk0tETxD6YXEjwzUZh/XLnvC2iYaqK+3kZrK9mHAGEZeJpDLE?=
 =?us-ascii?Q?zDmV927IoXfzGEW7zCNKz8Q2uWv6beM1rF9LWL5/9N8EF95ID3EDVLy6wd9O?=
 =?us-ascii?Q?hDX800DQoxJIAnaOSCs0Yb0WtnepCjBW/VcZGdoWrcHKlxbVajiOOL5GuOeJ?=
 =?us-ascii?Q?zt/nYbT0qVUCGtzxt1jqiidZQAyOnn8yI5jHB3jFjX5QO4isrXyC91foaTYO?=
 =?us-ascii?Q?v2RsKBLyhpR8gFvFK1ms+K9i1ZCE1y5LRS4+JnKMexR+QkHFDWZvEqPsXF5G?=
 =?us-ascii?Q?JpP7ZMa/g+mcJciotWntSR4SHPb/fz7ZOLtz6Sj48nWWZe784RFAACSmXvPq?=
 =?us-ascii?Q?rLiEvVKqT+zY7odjU7oBsrKD1azgIcXZVnH1MblvV261IdJFRkKsl0KD5faT?=
 =?us-ascii?Q?FZMHlasod6Y0+mN44kzl93Yi0rXY/lZ9VDLaUMLw5O8D465teDt0xGxx79aw?=
 =?us-ascii?Q?2YHVOHMWBLkzkO6vk/qX6I6r9Ft8y6Nk3uRsTjPc8vcHXUDeHarCYiIRu8Zk?=
 =?us-ascii?Q?Pm34PO35ZT3x9Biw/HLYh/4wvF8xK3wyBY4/d6XR+C0A3oY3JeLJ4R0HhtNv?=
 =?us-ascii?Q?YyCCCTBszjDfmV31shWB9BYajonXaGV2B/jUmNjVWLsYoPj7zPS1luz48Xrq?=
 =?us-ascii?Q?o4M4cRlKMgnGxtF42Isrp+CLgQ9aYCsyqBYJbnNl088S1fZdjuwL2l47pr/W?=
 =?us-ascii?Q?jfqwayMJgU4llaAYKaNKQ4jGErHA8b844U5LOdQj5qzzY8vw8F/OFpKr6iFk?=
 =?us-ascii?Q?MNEHZeT8mrwwCwU9Har08BwDdzibdiiZ53zg62t+RQqGsWv2VT4ChQ0UyrA6?=
 =?us-ascii?Q?ljMZRFiScHKPnNRGWMFXZSpDiGjYrwWAhYV8LNlZVfOb1HUPJv9A/1Dujxu8?=
 =?us-ascii?Q?N89WoFe1iyGsvplkuX0A+zPGSyTfjdB1smtdN3gIvOTSc6Y9lewiWCKhRtdf?=
 =?us-ascii?Q?5fshHZiRShaXIuduUMYzhkaAbmZsfplpgTJ2q1u9wmOksEMlFT+6DI1QBvnx?=
 =?us-ascii?Q?V39tdAsqP4J+2LSXEFCfuyxrc4qa8xamycNPuFkAf7p6zPstOEj4bcAQtup3?=
 =?us-ascii?Q?sXCchdqCRYsRpTDqZTkZXOSXCk+9Jhw93Fc7jeunOYH0+XkC0HC+BwTaFjVe?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g+tTSXlFd7l29+VAgUKr+KcqjuHcOXMukYxsTkwUZk+1dlZDka6vkNBNCz4ywgMZHPvDVwq9qgaXRM7MfqZyoCOeTT5wg46sfnfgIDeJwbEzwcpEu/D8jW6Rc517EHv+kj8b2RajqMRJwat8N8lqZ2PIBXvHkTUtl1zb0LIcdPbwtM8ioZ+w6pP2Y3GjR3QvYrcq6I6i8WdfmfdKCVYXqml53AxyOlrjD87XAtGnA0AOXwUnTLuDSymekwr8WqdNiwbfVBgIwnHGNk6nmJetpDb4cUpanbtZYhRlrhOi8PJ4pmCM+sDd007HkXguTd6qiZi6Xs7kXjZ9xlZMHZMjMxpSpeiXFh2ll3wppFkrm1k6gktQ1/TypNLP49FUJzv+p+aGSIwsUxHO6ISLlv+nQ4B5DyunSg8mMvaOinWY+90tpgWTdpH4eAMPoslGYkcxubbogtU8yTiv9F1oru0kxgFrAgMpfMmGRwpL7AQiMVA7g45/npM4X+xUuJQ/Rg1GH+ZRmcr1DTo9lIdYnNktuuJL2ZvFpG561NtOpPeD64vzt0/YKRMD3qhpDVXicGuSBVyt9PTIXScLStGQcyX27E3qgnzkChWSRJwaE4KRTa4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e23780-c847-4dba-5c25-08dd1aa2f687
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 11:48:58.0646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYBJLm7Ms4c5LmfL0NHcCVSWWP7Bg923yW6uVdYECWkU+tyVsAOK0SZs1+/IPBC1FKv7DuDHXKIeVrcUCPT05Xn8voqgJDcIPEWiYGfeHZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_06,2024-12-12_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412120084
X-Proofpoint-GUID: DqyLRFrbGjOqiUfcLxlx8cLLYKBLoIjp
X-Proofpoint-ORIG-GUID: DqyLRFrbGjOqiUfcLxlx8cLLYKBLoIjp

Both of these functions can be invoked outside of mm, so it is probably a
good idea to assert that the required lock is held.

Will only have an impact if CONFIG_DEBUG_VM is set, otherwise this amounts
to no change at all.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index df9154b15ef9..43ef85028921 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -291,6 +291,8 @@ unsigned long do_mmap(struct file *file, unsigned long addr,

 	*populate = 0;

+	mmap_assert_write_locked(mm);
+
 	if (!len)
 		return -EINVAL;

@@ -1023,6 +1025,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	unsigned long ret;
 	bool writable_file_mapping = false;

+	mmap_assert_write_locked(current->mm);
+
 	/* Check to see if MDWE is applicable. */
 	if (map_deny_write_exec(vm_flags, vm_flags))
 		return -EACCES;
--
2.47.1

