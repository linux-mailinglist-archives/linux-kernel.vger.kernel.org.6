Return-Path: <linux-kernel+bounces-220175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DA390DDC6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C97281F62
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22FB1891A7;
	Tue, 18 Jun 2024 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o0CPx6Xl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pHllqfjW"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6155317A93F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743731; cv=fail; b=FUW0Dc8y3uUQzqw1dYS1WrR3Ea/TojrkVWqVA06t51JXgZ18H0ePK7WD3jim6+MIThkkRIf3dqEhhXrdAOTUmxeajI/aKpRlBeCyUgLaBdQGuMBvg8XEOPsq1cjPSsjWoHPUi3RM4vb40c7oYwFBxFUbErI8xc/VVrNfqMnBnI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743731; c=relaxed/simple;
	bh=bP2qc4Wwgdvj0sOA5xZY/D+BmNR03ipFgS0k0L+jYTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rm89ejtc2yEOck73QpH2uKSjVb9zcix0HPvptAWGOPkGHO4sW2hldFOa9fi3ma9sPEsZTIh7erOgWLLXyoQGa7teePPPrNs5KdBN7Xldk680dW7ZNQ8HDaAxa2wHoUwk4rxeRevOiR+UR6A7FeJRiQTBpCkpISNj9rGNiiL+pts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o0CPx6Xl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pHllqfjW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IIUo5Q001568;
	Tue, 18 Jun 2024 20:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=ufcKmhI0a06m227Amm2QLiJQHiBuHSuMUYBepJaIpeI=; b=
	o0CPx6XlsYCtt165HO3NV5VBX7kL4yRTALa/lUrg0RDAUznPgUW9E6E2xJ2L2loC
	YOl6sxsA9wrE8DqNTg+AhbZu6KBKyNhtlvx8aOr2qnRf4Z6jyWhPQYwUN3segl4C
	az6U35pTRpIGG47Mh6Me2VcrjBwRkFXJlEO+yaqz0kt2ZgkK2pB7B8kUgrm0zjoI
	GUxirLKfv5b1XI8A0GwprvBx7ZF5GBLIEqeCXCQ6cT4mgMUjVXBu+7ZvoycrrYRl
	sHxlP4XjpSJIzIg3EXa1bclEOjtgTWpf3y218XQzQsn7eFQI2+HoLHZ6Zm4HGkNV
	bEyqvBC/F0dryt+YFIUHnw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys3gsnw8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IJlTIW034656;
	Tue, 18 Jun 2024 20:48:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dey4ud-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSU5upelj8Efh6gkvY4EgGvOIZw059UtCaLLChX4FCgx2Q3PMYRzqpZiLRrAR121uVYAaheKGSLTifJdtR9JQJFjdui5gQBdmxmYENAs99DIcSHLEw43YqHt5pruTRZIBEk0QoLZe37VpgJVYV1Zk+2lGwlR1+ryUYltUL2BPBmVJTwJbJXLy9GdMBC+UOPZByYjpLb0k/Eu1068t1CO3PXbVUotvDyKiVmrlmLRHWWlCmcIG6OClpxvhieA9BPMEjwgG+0jKYixdQ8lLowjEx6DT4oyEcefnLh268U3WUf16Q0WQLmUr1XhX3BNwREHOx2mPoqQG7tJlvti3J24OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufcKmhI0a06m227Amm2QLiJQHiBuHSuMUYBepJaIpeI=;
 b=OYmu4WhWM4OWmEqnXvQoQ0+iSyQr3/Lr5p6eCYVUwjCAaw79mVVUL4goAKnmYutSqVEk5dhixQd6SYg9BIUFu4DXTB2mzXSWGCpA8iINvfhrx/kYdj9PBafISepnZ4oPkRhMRMp2ElZe5C8D0HzNjmu20bFqm6VKjeIfsZCEellPaycy0S6dgOsfgbAfFczXeOsf5t7HT/ZPHk/hP6PKYYYYOLqn8ZK9d1mYBpe0PlQf/UfK4YdJERyYhpOjLNn/hmI/btX59qn7de6zTf6oCX5xPn/G9oxv2xCeLsFxLWh8eyYBGUr6qsfuQ9lTZr4EdtBd2o4AEJPWpDGSsmI/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufcKmhI0a06m227Amm2QLiJQHiBuHSuMUYBepJaIpeI=;
 b=pHllqfjWOpEyOhQdvdQGI/TOC+oJqi+gU2eG9gxRnsTM7z4zPYzXSXSkqynsLlspDuTEcOe1sfrAJdoY440CNWKlUd8HmldZQVrIOefANJQmTS9rzUfWk/FGsygxGZY4jWHTemrRWl3SvPSSZXd5oRBCwz76AM7YE2WZMXrg+JE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY8PR10MB6465.namprd10.prod.outlook.com (2603:10b6:930:63::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 20:48:27 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 20:48:27 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 13/16] maple_tree: have mas_store() allocate nodes if needed
Date: Tue, 18 Jun 2024 13:47:47 -0700
Message-ID: <20240618204750.79512-14-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
References: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:40::43) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY8PR10MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 7409078f-5286-4708-7270-08dc8fd800f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?T43cBfcq/9chhrXLe1LWXzj0cvE9GJxWyo+5JBvbuezbUoHa+bC6vM1rhH4P?=
 =?us-ascii?Q?RF1LDKAa56ivmi22y7Jr3zVYDh3C7GDoAMOim3O5kbt/dZ2uAuSflGK8LstV?=
 =?us-ascii?Q?R6RqAaxWKSOi0iVhQMLB88rVgBxyQ9nu3DL1/IuUfm14mk6gqXAnlm4excvp?=
 =?us-ascii?Q?3HgD5y2FbxfO7c3IoFyHryV+LSsAS5NmS+aTzfEqRpryyVwEjjGYxckWWiBx?=
 =?us-ascii?Q?brfXPnlGOh1lp0cE0sgeZg4egzBjPJQ5ENVd366bHWUaQmup4s0jBAt8a5BJ?=
 =?us-ascii?Q?oNry2HiS+bl+PcK22Uer6ceSXmq1K9esogF3TCUIyZfPrBOdl0YXkSbDwOrj?=
 =?us-ascii?Q?C1fzacL9cq/xvX3CYBoOysGUi3d5TUqjF5JsjKjIZorfWFV+kBH4+SUuqp+4?=
 =?us-ascii?Q?GAzVAr4ubDsiRzcWvk1JWOimqM04hskN17wXtJK+v8o9DGkMlQLMuBihS/XN?=
 =?us-ascii?Q?z34/tRujNZhP7VKaI6OU2vA9aE2Ps8eLdLCG+GZ6nkvf4i6BOQsK3N6EKWyy?=
 =?us-ascii?Q?tqcLpsqUJRaBTClRHzOGcri1wj5BtV88VucGec84NyiqslykGmDASwBfBgwE?=
 =?us-ascii?Q?RFE3KtfCh7UjOh6BrN+a8QeRoZelkTu4ipRM0xtvEF7Y8w5ipIc55hw9BndM?=
 =?us-ascii?Q?48G5mAVRS0DhU3eG3KLan1bKmAue5jP6GD2tiMMktLj7loKMwastSe45tmsV?=
 =?us-ascii?Q?UAqEgYLcROZfQxb6LbPTQgfUmlOgsHfVmpPCArH+cTi5mkH18QcL6ZOSWIva?=
 =?us-ascii?Q?efkwXXR3XEkwDWilpQyLf4ejL1vkpdgt94+npD+mCmd2O88FluF0HP8ETeNM?=
 =?us-ascii?Q?ExgtjQqL+unv7LOoTCFAAp6KG51IRFVJYr/N6lBt7in/5GdO18E1R873QUC2?=
 =?us-ascii?Q?NNNT5R//p5R7Hi20cIHakY4D6DSJyMvVZV2WsJLR0Ow+2XBfpRt6OlZaXRW0?=
 =?us-ascii?Q?0aPlV552+Wx5ggKVTxULolHa16k83zXaCeE4nnouMpMaXP8JXUcIKHQ7h8hZ?=
 =?us-ascii?Q?VrYi5E43q7sHzgJA3Zllg7vuH0ge8qXH3oaP34Ql3jE27P6fmn6Y3f6A4Wuq?=
 =?us-ascii?Q?s1UVJQTfvU4LrKVS81fFr1N11psodDiSvKtorBhOtG2opoWhehke7tAeRW7x?=
 =?us-ascii?Q?fZVWS38K5eDCs8mwEuhiSRElBiK3x0slFfM+Sv3N+x9xdXdQL98KjNP0hqXO?=
 =?us-ascii?Q?ZiqxtxU8Gjso6fJzqakWazJUMylV3sKpaNlLrcACM7RSaLadQO1+uwy+d0fi?=
 =?us-ascii?Q?KGcllH5eMSpG/u0OANlBPL+eZk1hZJ2XBegIQT3F/BFbR6vogyu4fTDQUVeh?=
 =?us-ascii?Q?5n8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5p696o8GXnaf9WuoQrkak7tX6Om1J99d0kahf1DuhttDuBcfFDI7OI+jqAC7?=
 =?us-ascii?Q?SYedihekJOjmg+jfua+ZrOEoYmFbOD8+uHZBbJoizLPEisyhY9tdfLn8dkIl?=
 =?us-ascii?Q?ww/9UVTz59saAONDWjzIFgfPkY+YCxc/e0rEW4IPHgKgi8x6sm4/4FN9x7Me?=
 =?us-ascii?Q?KV7yq3OBnLpCEjrVmFSuWfL32ywtzURM6NgMLet2k0MHlpeY2iAAcfJ43RCw?=
 =?us-ascii?Q?q5AOBkTmKd0Paf88qPT+gZK5MoilZoFjjo6CqiBG3C8bjgmmjATktEG+s7Ta?=
 =?us-ascii?Q?7iGGcwP+xYAey2yowOGpET8im07c7NV59HRu5JIhTg8bXhEFJEJlEpqxwby5?=
 =?us-ascii?Q?WkPUuER92NsPb9pQUWZrkFb9Im5BBQehF2wq6dGYTKNKB8ypLCS3+6cK6PVk?=
 =?us-ascii?Q?WynUmvS5PkTLIX+J4LDBIA6Kr0xcuqvYoNTnJAjcv+3MFz7kFZkYhM9FNVBc?=
 =?us-ascii?Q?4HOT6mWAUGmpH0bXsNTy5KIl4wtep3fF+SA9wyW9rvibDUkrGq95jz/QOhdh?=
 =?us-ascii?Q?lpyUfJsh8tSbzxFixqUy9M+7dd2/trydSNhDQck3oK/ECCfUE10kANNda764?=
 =?us-ascii?Q?ionDgzkPrTszpUxUpXfO+y5E22qJ4mhR+xoOtrcDhO5kMgJUmCPJytfzkL7O?=
 =?us-ascii?Q?sxuNnyqJSqxRlMyRlDrkgMQgHY9o8UwmN8zitCGr4bdP0Pp22OVuBtZAgxfJ?=
 =?us-ascii?Q?fyJ2os/JtsyZOdXRi2QaoYljXKCRYD67/G2qeQZCbsUPipr59J/tY4OEtvPU?=
 =?us-ascii?Q?H16eulqgDQRi57HZeCweLPPurd58/mpkvQPiIkPQs34KfOE8TnqTTqSlytv+?=
 =?us-ascii?Q?JpmBo+hXs27epZDIpWtbg0QJNtc7cTjsodE1iM9Slu/aZ9JL9g8wcPxqzMx6?=
 =?us-ascii?Q?mliapIM2F5udKIPLiDWZIBX6sPkE6t2d9HIIjvzn9ijXT+qbwTgoIAJvH/rS?=
 =?us-ascii?Q?4tY3LyGiUqBrkDpQ7O1SqS+lZHAAKjHXOkpP0pJXRzYg2N01/EMxKZZnwDsR?=
 =?us-ascii?Q?xAPaJT9JsSkCs0uoi+H57RRA1pjTp02hdJgb8h36wpmB3lweabhp2952C6m5?=
 =?us-ascii?Q?N6uUodIbHgq0C/3pJ8B9nCpQEZOHTrVWZruooTFpZG1NIMkV3eeHTeUcWIIZ?=
 =?us-ascii?Q?6xRwHVwKGypEDnjN6+s8rAKohw9PydgCgaaWRosu9Kw00GjPscyRUQByQCfF?=
 =?us-ascii?Q?XPD3iqy0w+DHLUoXKqjsDPzSQ/Bv0aj00WDFcshVnD2+ct+364/m53fWTl7c?=
 =?us-ascii?Q?dJYYyE4AWDLRkF0cod5H8ziHS6E068RSh2IrtorvR3UBcKBM8FJ2OXdq2MhJ?=
 =?us-ascii?Q?vCSaQZ3+EQZ6LUZufKMJDmKayVqTvZp2W3iw6nPOf7/eQXm+MftiiyQyuBUG?=
 =?us-ascii?Q?Ui1nyEUgZivh/Z03A6VrNgaG1p3YYlNGtFWt1YHviMsr9I+JSFBjOAYt+1mI?=
 =?us-ascii?Q?XiRsYml+gxEYuNC2qZHelRAMbG8gF8lJAEjThnv0vP6+aXXAPLPEEq2NLkBm?=
 =?us-ascii?Q?BudBsaTYVPXijqJ0CE2XkPyEZmdfJJzhzSKpcLT10SFElPmE6y0sKXDYEK5E?=
 =?us-ascii?Q?iucz4QRlO0pMvD9F1JI+2h1v4yoUNTEDgPWvq7t9gSHM/baxloCFtHWKccuD?=
 =?us-ascii?Q?O4Vnh6DAmFCnXTXMHwcFq2U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UjTfgKRNNHr4ItMgRg1icyaOv+gMetpcy4bLY2Ybn/fkBC1Z5AGO9BT8JMUplMbzg1m8XvBdNiZo0cVJhP4skK8oM9RFqmKBpwkgdSnMaDK6podiaS5+4rSm/m3NTLFFnyZe1HqKfAz0o4PyCG3hZnj4GWLxTeZiqtOyunxjroGFdWYmfyQ7UisgLRFtUfelfQpqrCb3jdkBY2V/hbWvIyjEU2KtKwYBpTSJteyEq/Zl+bUVgnTyuucyCd/kX2Kg3DM1tlJi1AiGr5K3gqUOlvY8DK4W/2nfvd6kLhTtkDGsCkDzS2I4r6io7RwA7m17HeEGhKxMf+z1j1gFvi4Pu/WxsCjRnKan+jxomrT4GMMpHg7YvZVz9Nn1glG/NPeppGRaZhQiAuZ8Ayzf25K7JiD2Ykqh7SB4CrKzdYBErV2kCbmDC7G0yvQs9ac4r41lcgYmOG3fFRvaLBV8r+YP6TD2+rbsaIcyUfbUccPGOaSbZCrQ0DMNniafVZIkkldILI1beKSruTmEtjJxcaj3u3NjDVZ/2pH1Sd64gOLT8yKhvMevaktjPeLodnMD0zLQ5IzoKNZCP2rGeMSrXrGoPpk/DvcN6fhjCPq5Bn9QSwQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7409078f-5286-4708-7270-08dc8fd800f2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:48:27.3171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58uE0oZzb83TiW2KbfbwLFySnLq/Xy5D/K902PNLOq0cy2+6ijAagLVMbFzOd9sjLTpESFAwGmFpFsP/K+aORhcbe8olABYKlLzY6TdInjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_04,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180153
X-Proofpoint-ORIG-GUID: IKVFcOnYnJ8T9Mn0Wo5s0oRaKcuoK8Kw
X-Proofpoint-GUID: IKVFcOnYnJ8T9Mn0Wo5s0oRaKcuoK8Kw

Not all users of mas_store() enter with nodes already preallocated.
Check for the MA_STATE_PREALLOC flag to decide whether to preallocate nodes
within mas_store() rather than relying on future write helper functions
to perform the allocations. This allows the write helper functions to be
simplified as they do not have to do checks to make sure there are
enough allocated nodes to perform the write.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 98c64aaedb55..46bdc4ce6662 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5536,13 +5536,12 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
  * @entry: The entry to store.
  *
  * The @mas->index and @mas->last is used to set the range for the @entry.
- * Note: The @mas should have pre-allocated entries to ensure there is memory to
- * store the entry.  Please see mas_expected_entries()/mas_destroy() for more details.
  *
  * Return: the first entry between mas->index and mas->last or %NULL.
  */
 void *mas_store(struct ma_state *mas, void *entry)
 {
+	int request;
 	MA_WR_STATE(wr_mas, mas, entry);
 
 	trace_ma_write(__func__, mas, 0, entry);
@@ -5565,7 +5564,24 @@ void *mas_store(struct ma_state *mas, void *entry)
 	 */
 	mas_wr_prealloc_setup(&wr_mas);
 	mas_wr_store_type(&wr_mas);
+	WARN_ON_ONCE(mas->store_type == wr_invalid);
+	if (mas->mas_flags & MA_STATE_PREALLOC) {
+		mas_wr_store_entry(&wr_mas);
+		MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
+		return wr_mas.content;
+	}
+
+	request = mas_prealloc_calc(mas, entry);
+	if (!request)
+		goto store;
+
+	mas_node_count(mas, request);
+	if (mas_is_err(mas))
+		return NULL;
+
+store:
 	mas_wr_store_entry(&wr_mas);
+	mas_destroy(mas);
 	return wr_mas.content;
 }
 EXPORT_SYMBOL_GPL(mas_store);
-- 
2.45.2


