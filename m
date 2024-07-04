Return-Path: <linux-kernel+bounces-241691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8E9927DFE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A416285706
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D112113B2A5;
	Thu,  4 Jul 2024 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mHVHTpKr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aop8aYZh"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57582F23
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720122678; cv=fail; b=tMHAXfVS1MYOW3ErhsX5M18Hd/VxgCrwIVbvQtGum53aUDhRtkCJy0HaCwlmkV1Srce0XUEqszJor0oLFh6T79lXU1z/uITwjYqu9yTIlJ1Mj/PLsSU2Oe2O3GZVfpbm5/oQ6P/x1gUi/aBWCGiJWG+Iq2mPQtCib1oLCTiG3kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720122678; c=relaxed/simple;
	bh=7oU6qNd5I1YrI+pnQ6kplIj9Locb9846FE8DwKSEQC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KxZYUpnmaHNTsUjaPJLbGkW5kNxiFsr/lxzZ0KFthUd+0hTES/GA+WlXFwb+XEpTzX8t7tQIm4J/y08/03u6gCREmMGOXbPkzKqvJCouTNwbFaFwarp0p2h8l7akU8AYWogA9WMkk4hQQ9g9AgDR1zdnKWEauhCuI8ZlrFUqiyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mHVHTpKr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aop8aYZh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464DnZxW031278;
	Thu, 4 Jul 2024 18:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=60kAsYjdha+bVEANDM89tZg/qOvXIAnhtflm3wfsjyU=; b=
	mHVHTpKrVn2BTB9Uys9lUjDxy+THHK41/Qg958ObkVgi2vw6WVzBl4AzHuk539wi
	x/Xp+/kw/HstyZLVlwDwnK7RxChky9PHl2jgPzRtYoySB1/hpdjfmSI3z3w/zh/8
	zwE0VuDl9ghvmE3D//GpdMG0sTylCdMicdmEMm9/SIYtNjLJV9HJlkWdhwgs2/XS
	IC+po83gnb3KVoAeOaZ40c6hzjhZa84dvBcds3SMhD/h8IJb7iKTZZIbZIdnupYV
	MUWYecgKLMckbImiABPQaBCOU7xSNCu77blnCPzdfivkIfPrkT/87xdeMWA+DIUk
	M+R8No+zd8UGbxMZFq2HyA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029vstk3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464FBeiL024727;
	Thu, 4 Jul 2024 18:27:31 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qb2gxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ob2NUXeRpCNm0DdHF7sZJHrU8S1Lb9GguhKds/7EEWa2pQvooRYLxKlfauFWE5GCDv4oHdytFgS5Hr/EMKY2fEaexWwH3IElJOICMr7JagjM9MaSjmya5eRCR1FKVhCHiLqNaygzc9MIJBFPDQmBPI3W9Iw9PVcq/OPCn3HCNLuWgc7M/wPQBm7RaGsHPg/j4emcCtkJt3TxFCOzrmAPL3eWfvij1H8/HhzDXxhPiTucRmM+ruF5TZU8JmCDp+fuH0Ji5L4vDf1pxXG7BcMz8ZYe8TfzUczoltUCj+XzIp0ubUn6CLT87TbIO/PXQlP7levz6rwOlqAnQO6HnW5jqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60kAsYjdha+bVEANDM89tZg/qOvXIAnhtflm3wfsjyU=;
 b=T4ZZB0XFgR167TI0fwzCRQKAt3t8NrJYMvueOcCqBTbMC3LMf31TZXA4dJzhyFoKERccveZIVQM5NJ2bjI/+zIkBEfR6JcIjcazxVkKg1Tp2mFpaBDiAB4Kmb9UYPflrD8YQk81X7NzM0sTIJ6IX2CvBJBWxEcsxCVviVnGRioXCQDrcVVVhm2p0FAjRBMKu5WWFQZFRTKdwPgn4JO7SHNkMGNX7s37QSZk3Lvm3hpjw2WIgM7eJFC4zKCPh74eYMIlEToZFg0YGUY7YdeU28Zj4NtkV9/2I2Up6P8xLyL5vmuz18j9nBs8r/5rk9SmWTwxCmfZ3ngf6YKl/o7rfiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60kAsYjdha+bVEANDM89tZg/qOvXIAnhtflm3wfsjyU=;
 b=aop8aYZhsEZG5xlU2yqoJ+7LmdFDGrOoD91RSXYUH8XXdMNPnT67jh8ExQxj9j/raceX2bMT7+wYsQb0spi111o7cclIdQpF+EFIFVf03504gwaJMXWGFJmZpneDCSjUVD9xatT9ZkDb9xK9NWv6GH9ZiddaH3Go6CxkIC0MVbw=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BY5PR10MB4242.namprd10.prod.outlook.com (2603:10b6:a03:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 18:27:28 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 18:27:28 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 03/16] mm/mmap: Introduce vmi_complete_munmap_vmas()
Date: Thu,  4 Jul 2024 14:27:05 -0400
Message-ID: <20240704182718.2653918-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0349.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::24) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BY5PR10MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: b85fd3c5-05a5-47ac-dc97-08dc9c56f5f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3J5MDAt+JC442yZu/4nAwjR2i2/qgtEhaoHHcP1D4K0pE347ekdsct7KuIM9?=
 =?us-ascii?Q?SxjmicWQPV+6apyZmx8n89cVkhnQtuCk12N8+LCmpY51AimFN4hTpJQ5gdvT?=
 =?us-ascii?Q?LY6dnEAXKe6wIwnIuVVP9gLF2XUyBxNf39BWeV2S3DWHdJmB4z4VlhHISVO0?=
 =?us-ascii?Q?qzi5XSzBWGXisZK0Y7kC4blS/qrrdGyq5QChmTXDCVeqsJZS03a/cd4nU4ml?=
 =?us-ascii?Q?LJMlEmb8Bfi+u4SsA2ka7MddW06WzZY+6r32gEkNnUL1fNA6i8GHXUnbRs6v?=
 =?us-ascii?Q?2taVmh8ueikTy3IGcm3sytkMm9AIPvav70TY+re1iHtX3bfDULSyrn5U031l?=
 =?us-ascii?Q?EciBpDvEwpe1Hl0olPPC2dUoV9nC+DNg9iQBaahFHoqvGrAzYDEnpHveMO78?=
 =?us-ascii?Q?zAjEwTeP2hjzLFn6u+aQtilgyaBAV5sfcGWxdOl9KPhU1k53naedKy085rA7?=
 =?us-ascii?Q?QWHbz8skKQU0wtxXZUHb1cAvVccslDlQw0tycmYiWfyzrQm9EGqyHnchCImt?=
 =?us-ascii?Q?q/diwc25DqzPEPk29i141CW8XotvO2Iu7Uk51XuWZGbYMt7Ted39oiBae+Vz?=
 =?us-ascii?Q?Ym7xf2/QkyWwU/KLY29ADTN4cDPsJ5lTlnD2vOUVDS/U2drytx6nC1q4T9u9?=
 =?us-ascii?Q?tySfZROAJ8Mk15NHShjzqCAg+4DmW0IvE9WLzZf2yT+8YdFCJPTeWP8WsYnp?=
 =?us-ascii?Q?5dGsQbYs82t8hejoK1fU9wJX2OjpJBN8tDhxWSuIoN0ZU8JmP02ES7DgnfM3?=
 =?us-ascii?Q?Vw1B1fi+q3REXafjrDGLy+oZYfogRCbf3g6pXGWUQVZgwQ32ftUIPUDwftR5?=
 =?us-ascii?Q?tFB7wMTI5IYtUSNuNmkyGmhz6BhUOT+qhXx5cogp62d3dBTwUoDw0wMWdRZA?=
 =?us-ascii?Q?XQP4BIZQdM91uPoRzAu6wWeU4OVocjtvaTbn3pE3oCPcP4t695aNshvawBmr?=
 =?us-ascii?Q?3Ee5lqi8HNngktgNSHWpwVRrGY8NBUfmAj78NYWTlRjhZKmUxBpkDVsmgSSD?=
 =?us-ascii?Q?v6n21OFaCXfVYeIWid90ZVlMplOTEHxs3LIyprHpSijb3wYcA8u5qJqFEvsY?=
 =?us-ascii?Q?y9KY44T5Z9Ar9Lk1R3kC88kjrfd6hbmEWLhgmUDqIrFbyziTLBDYmpvsgfXQ?=
 =?us-ascii?Q?wyOx/ESxoJ7JbqZQPwKXx40vjHdI+NlkLmRwB6mBd9RWAuXoATe5oHk7YOyq?=
 =?us-ascii?Q?mRBomC1QDL/Wjv7ejebATaiGSm+M/f7ECvVIiR5ff2665srPWTXhuCEiIpAY?=
 =?us-ascii?Q?zioKjJlctgXRAlF2+nXO7ZaglwIs+ejV0I1lnNB+Rs+rPNOnOBxD3vc8ltXU?=
 =?us-ascii?Q?Gdh9yKbB3lh8SZbK1LRS3Nwm+V8sMUN515AtpR2ztRJrUA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cBXxe9ape6UyPm9DTIcH+/BK8ScJ9g3v9bKYV0RTB0zHowJU9xJhZDfsO7nV?=
 =?us-ascii?Q?JVFue5SkpfNipHdfOYD5GnsejhErjZzx0AJlgdWNud76+OHJhALqFAbKbwo5?=
 =?us-ascii?Q?uWHU9JsKtFuP9hUwnxJMsjEBD5OSaOAKthzwCzYASvQfFra722Q4fDdSQZfR?=
 =?us-ascii?Q?5I1B6IA1lL3U83lTx/WvmmXLVr+xuLEm5lMqQ11UfRGHcAojWv5RQnQHQfD9?=
 =?us-ascii?Q?aEBrXY01EnO6r1K56xFT6uGPpp/1drApufhLbqi6IWbiZqjuCdjv29HFQG+F?=
 =?us-ascii?Q?wm/7Ik0Lq/qFAA2azYcLljvb6X9HY2jvaJKYukCaICwOfw+jUvyBULNS+AQB?=
 =?us-ascii?Q?XyO3rZLrfbQK3Ijf7LaFD830o/Vb5/vUosXedB/H/yo5eY+US3AXpf4u4ym3?=
 =?us-ascii?Q?c9i0wfVL27eMC+u/NKOIoF7WK9Gv/OULWcVXsy3v4ntAPQVgRS/8tYa02HQC?=
 =?us-ascii?Q?qfhOi0MYOHY/9eIjs0+cJo0UPiH9nmV+UlPFh85WezGk9L4/YAJG/VvnJ10t?=
 =?us-ascii?Q?5vkOEZDeiKI8H6wwyFSSdeDbVtpjufxmcLDe5uwFTtkfqP7m7n8q4bV4WM8I?=
 =?us-ascii?Q?MNxApPYyk6o4PLZJEdivnKuCgfQdrxb6JE/YSFxi6+BT5oKdhDTl7CCYW67I?=
 =?us-ascii?Q?F1cDaqCEDyDe8yRRGd60f9GBnqhwUvGDD69GBAa9L4FP2QKz1idYtpXZcMeO?=
 =?us-ascii?Q?qzctx0gsS8Dv3iDcZ4b98zkYxdYFIfrsDQNlp8w5HQePegPqLD1AkM+7nOzw?=
 =?us-ascii?Q?Bcosx9RKWvM4hx6wLwL9bVr/WfGmlVlbppaGAM85S9roU4KjItIIfyob2GYM?=
 =?us-ascii?Q?MiLPyjwNNykSlAcwbG+NBW3LnWIbAbmV5tcVXQHd1kNOVyrMeprMtRD4uZfs?=
 =?us-ascii?Q?j8bbZIQBjSuQHES8OPhQ98GurhFiPBY4O14L6W+4RBcLHZ5leAOSYHfCUgOF?=
 =?us-ascii?Q?FjLbUPvxYeKUfo6swwV6fZpKBn9jP4A7sWSUEBOAey14NHZ7cCMzYMbrL2+0?=
 =?us-ascii?Q?tGGbiLSXAEZMQ/SyOXV1wVEMC26iaXPL7xYWFaqzhXgKBWv9v5SUIuxWjma4?=
 =?us-ascii?Q?bq68heO5AKJ21p3vvEl68G1l2M4cXSjv07T/RLSTHwqLIHDZN6yvnw1BT5/o?=
 =?us-ascii?Q?oAR8m8qrfWFbiSVFxTyEjWqRgrbw02xoWcjOgSCPCHp/meneGTnNa3baKoN9?=
 =?us-ascii?Q?X/xvri0QAuMwy0WsOstOos07i5PoZImIPNbxCv3cixU4an9LyajVSz1S8/bZ?=
 =?us-ascii?Q?N334xJlQzB9DBb7c6poSXh/YbLWkydUhAu8RkJnDVBb2d/QkSdibGa0ivcSJ?=
 =?us-ascii?Q?98mxRWaVyAbOzc00oHP24rqwe1QjKHmgtSATrjeqet338PzVn3DV4nUqKCAh?=
 =?us-ascii?Q?bS2TZyoMK4gLhZuOA93jUMkqxO9MqEnDWoHrZ8+xjXktPVQ/MQRiu3GO6ShW?=
 =?us-ascii?Q?aXJAD0D8mxnxuhkRrYujcyoh/YPVDohTvUTmj2gEYEzLgmD4RQWwEdtaYVZF?=
 =?us-ascii?Q?idi/sL7oW76xzyjCojDJvitgB7DiGXxJ6Kq5s+S5OS/qDlCKs8VzrgIf/hQl?=
 =?us-ascii?Q?AnN49/vJj4hNdFV59AKzzM9rldTZX7skiixz7+Q6blI1JjSIA7bxyP53tfxG?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	y/uA4k4PNF/fMxZ7r8XZybH+KhdL6N7M64U9BB7P3hWOFIaoz8s2vWSo7HqqwIKSA3xgRhLhQt1YkJaNaoCpF0bs4dUpe6GpHQSeI8TxHvdqiCp+5Lr7JTS9kBhsyj61lwHrq4srWL8wMatDG2vvLZm+6BkplHvoCbSQLXbj/vfd+0a52KFgM8uEgaBlIlwNqsRN197ANIFFv8tXMa6T/YyAHy4YIbkMzOxz+Ikpnp8wNeHaKflUu0aYW1Bnd1TFI9Xe2sq8qz0zY/IP5B4obsemNBGsdT9gP4oNN1c2qDPr0374PVAeE00HpZr/p5X9v8NaG7l5RMcdkXdREZXUYTvh84GoPeRXmT7xRC7iAypD79rSjgFvTlKRk5vU+gm3uGLBm3qth7VWQmseza/H2/db9PBTAKNcXuoUvJQajhxRerJudzLWtNbKKXADTqe5YDAUZtBrb94infpGtXCUmjffVMhiQZFNE2ewllNajp5nnyN6eVoRxdFMv0Zay33naDrpvC+ID1HNTLB4zbW7tlaPvMw30csPfBTI8UVwv0vTfx7BqIp9Kp9RJ/cZfFGglGEPFU1JtjPIhD/AS8LSsgHhS28mG4DbH0q7ZUx5V4w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85fd3c5-05a5-47ac-dc97-08dc9c56f5f4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 18:27:28.8034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4p6IgJ64JAsJ5WjVYB0nsFsEv2MQIYqOhq6Z2L3mpNcbh9JpKIuAFU5Ns6+hFXWSKxO1IxIlTWuzccr0oIzD0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_14,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407040134
X-Proofpoint-GUID: oESDTas6LM9Adzs7KUK2zW1Qrv6ZBH0F
X-Proofpoint-ORIG-GUID: oESDTas6LM9Adzs7KUK2zW1Qrv6ZBH0F

Extract all necessary operations that need to be completed after the vma
maple tree is updated from a munmap() operation.  Extracting this makes
the later patch in the series easier to understand.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 79 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 26 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index d572e1ff8255..411798f46932 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2605,6 +2605,56 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 	__mt_destroy(mas_detach->tree);
 }
 
+/*
+ * vmi_complete_munmap_vmas() - Finish the munmap() operation
+ * @vmi: The vma iterator
+ * @start: The start address
+ * @end: The end address
+ * @unlock: Unlock the mm or not
+ * @mas_detach: them maple state of the detached vma maple tree
+ * @locked_vm: The locked_vm count in the detached vmas
+ *
+ * This function updates the mm_struct, unmaps the region, frees the resources
+ * used for the munmap() and may downgrade the lock - if requested.  Everything
+ * needed to be done once the vma maple tree is updated.
+ */
+static void
+vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		struct mm_struct *mm, unsigned long start,
+		unsigned long end, bool unlock, struct ma_state *mas_detach,
+		unsigned long locked_vm)
+{
+	struct vm_area_struct *prev, *next;
+	int count;
+
+	count = mas_detach->index + 1;
+	mm->map_count -= count;
+	mm->locked_vm -= locked_vm;
+	if (unlock)
+		mmap_write_downgrade(mm);
+
+	prev = vma_iter_prev_range(vmi);
+	next = vma_next(vmi);
+	if (next)
+		vma_iter_prev_range(vmi);
+
+	/*
+	 * We can free page tables without write-locking mmap_lock because VMAs
+	 * were isolated before we downgraded mmap_lock.
+	 */
+	mas_set(mas_detach, 1);
+	unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
+		     !unlock);
+	/* Statistics and freeing VMAs */
+	mas_set(mas_detach, 0);
+	remove_mt(mm, mas_detach);
+	validate_mm(mm);
+	if (unlock)
+		mmap_read_unlock(mm);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -2624,7 +2674,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
 		    unsigned long end, struct list_head *uf, bool unlock)
 {
-	struct vm_area_struct *prev, *next = NULL;
+	struct vm_area_struct *next = NULL;
 	struct maple_tree mt_detach;
 	int count = 0;
 	int error = -ENOMEM;
@@ -2728,31 +2778,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto clear_tree_failed;
 
 	/* Point of no return */
-	mm->locked_vm -= locked_vm;
-	mm->map_count -= count;
-	if (unlock)
-		mmap_write_downgrade(mm);
-
-	prev = vma_iter_prev_range(vmi);
-	next = vma_next(vmi);
-	if (next)
-		vma_iter_prev_range(vmi);
-
-	/*
-	 * We can free page tables without write-locking mmap_lock because VMAs
-	 * were isolated before we downgraded mmap_lock.
-	 */
-	mas_set(&mas_detach, 1);
-	unmap_region(mm, &mas_detach, vma, prev, next, start, end, count,
-		     !unlock);
-	/* Statistics and freeing VMAs */
-	mas_set(&mas_detach, 0);
-	remove_mt(mm, &mas_detach);
-	validate_mm(mm);
-	if (unlock)
-		mmap_read_unlock(mm);
-
-	__mt_destroy(&mt_detach);
+	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
+				 locked_vm);
 	return 0;
 
 clear_tree_failed:
-- 
2.43.0


