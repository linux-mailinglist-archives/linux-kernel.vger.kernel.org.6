Return-Path: <linux-kernel+bounces-299603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2740495D763
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C83D1F25AE4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B02197A77;
	Fri, 23 Aug 2024 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ahOe5ugA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AdV2xgw8"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5131957FD
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 20:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443668; cv=fail; b=DHhvO7v1L17onhDs01sPRigDDOiJqslQqvaxgLStuVkymtTh8jrpg7d5udxvY+gUWV1xpzNxQpTJOXBq03uztpitKZ1GPLvhAOCJuJRgmPmvBRVX7eZ8lVWAr4dzNi6N1gSgep4okMPgKBKHI6iUPkYYufg1w75Jnylez8cbqKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443668; c=relaxed/simple;
	bh=otzOhtLMotVCmhR72GswcTAn8J9IDCNDOnxTO88RrpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X9w898qPdHLujchWcl5YwePLAp6x+qUdNcsHd5HqULUb3z3uF9CE3Iko6nnKGpPMkzAA+jIgvSO0inIPkBicCAm6Ku6q/9fDdglHTHIYU+6WJclvdYRpL1Edv5f5KpwI64idaeFLdjQ/xb0JRiH4bpHhFEwv4AbxFS7cKEUmDI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ahOe5ugA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AdV2xgw8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NH0URU009613;
	Fri, 23 Aug 2024 20:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=T9/w8+JoCq4C+DFhw2QKtJGEAya5D7dvEbSvitfxAY8=; b=
	ahOe5ugAb4FbWpM6NM6zDAlFDpYPmJGjsXGgrKwTJJuUq15kKpmjibWVnT9M70Ms
	boD+eY0MXnldwPT4okFdKG6Uvbk+4if2ewbRTf/0nBDb+Q3kxqhE7du9ZQS0hqLB
	1CK5vLyJf2zo4ItYxgOnr82u0/X8ctUFc7l7rujGqgPa8QxFLoG0clYDua75Q+rG
	lqwoB7oVDBOqorsnocVgKcyYCA/0jhNatVCX1zhafIKeXesCs0N7wM1RE7Mn3Lac
	JFZHTY2B5bDXsx5hyrLa05zvTTD+WFZWdYRsRZ4hp4MtuWT7iZWsf+kymAxHi1cQ
	MBjhmE6oI2PdH84kY+HUbQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3dwh87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:07:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NJdCpZ007466;
	Fri, 23 Aug 2024 20:07:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4170s5gxw2-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:07:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaFacq0Ze7CvceZ+xPvniYpREum6GK3TAIenA3N8GAPJM4WCltJiYz1RWunbyWO66CupehEkxgYAtVz4i0W4dtMT9ayEr0qRwpISqgrJLt8ttXZRULbN+yu6Hcnhy272esmo4wTd32U+sQmVzqcARwnBncpBsvUYXDZdkQu5aX16G5euF2EmXKjLmnrPeZBfr91zaCtvJgI1d/5P6+aDgZqd4fjOIs3tF93JkJvrGxWiXGyFAI5Hcmh/yNpr4pgYKFsWUfGNTrbMyEhrYhlP2Qp2obC2tFI74AdIrxM2cFPaeI6jnd1fcgOflusNyCD8Hk74EVotQYSrYHFAmOY60w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9/w8+JoCq4C+DFhw2QKtJGEAya5D7dvEbSvitfxAY8=;
 b=K+4R5i2Z0122Eg67E8SYsQpeGbQyTIhng0ncBHWlP6ck8eNTQGYh/s5EWdz5ycRALaLgdt+/1+DM9hOnZjv0VeoXDGNjM7yXCJBH+sJFe4Cz/OTCfD6eUbEoG+Lco5bppGrjbp6BVzbGpmHANQkGu7HzlASwsFvkAGXUglnF/YXgOzQOZV9PT8RL8Tmq6m9Cicnj2takAZnFrw4tBwnMwP2ss2Nk3vsXk2JuvZPbwBYxP1eiVHvV83ruMfszsczwpAkCiD9wjM+hG3fIPGyoQzADXs768ORiNXzH6T3C1iZyM/AUGwS2q3gR3AYALFXqxT4WjQC0sxYVq4T8s7pD8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9/w8+JoCq4C+DFhw2QKtJGEAya5D7dvEbSvitfxAY8=;
 b=AdV2xgw897jltzfulXR7qaScUCcwZ9x96sFLbnyqy5uwNmC6GEoSYm9FhAXu2c04na6gZHKW5+xxm7FXQv/EPZe4fFhsCRPDMYg6C3zHmkx0VESPyRfv9p4Ad2tEotyW8w9qhjf2RQm1I0YXoTVQaugTqKcp+Y5YH124CyxYD54=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BL3PR10MB6187.namprd10.prod.outlook.com (2603:10b6:208:3be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Fri, 23 Aug
 2024 20:07:34 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 20:07:34 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 09/10] mm: refactor vma_merge() into modify-only vma_merge_existing_range()
Date: Fri, 23 Aug 2024 21:07:04 +0100
Message-ID: <16da4f8c7f1b84093a2588cbafa936e1c98b2575.1724441678.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0032.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::7) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BL3PR10MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 161e3bda-7d83-4e6c-fa7b-08dcc3af39ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y3JXB+HAPDA4CpJZts9aJNaUJ0Sb7EMcmY+q7NBDYLnw6p956F21p3oFV6Hp?=
 =?us-ascii?Q?U4FX6lznRlHqLu6Gbi4Hr3cdptOzC/SVADw61UC9p2R18yBX277jFgxrH07q?=
 =?us-ascii?Q?V93CvBz8C66oxh815TnKl22ZPubyrj2qHBIq3wyvtQtakPJ81sT79i6lG1YK?=
 =?us-ascii?Q?82Al8IBw8q58e02FSOoQrHrtSN4L1x/Qaqqa2rbddAbtxm+V+h4U/4L7F0CH?=
 =?us-ascii?Q?gWDTx9R7Xlaz3JL+FRK8GDOb4VV3nsRObFlHSA3tR7aouvOGNxY4MVWrCn/X?=
 =?us-ascii?Q?E3KC1iLqx/RBGtTcVn5tK/YWkvCXx6GUSm9Mg1fsU8MtgV4FWZxRnZJG9h+A?=
 =?us-ascii?Q?AJajwWcXKYHMRFJg7n1jXzLXAqPyiJ9QKZNgTNfUGGD/eiMKbp7k22zYKJpo?=
 =?us-ascii?Q?qFygRDwDskiak2IOmmL7lshFU4glsnL44yEQugzYdbP12zisD2oMiY3/uTdW?=
 =?us-ascii?Q?9ZMcBdlaSiW9Tboz3hqB2KHBYrERqGCIS1bpr44MXM84QP/qSj1pUWEiHJiH?=
 =?us-ascii?Q?GEFHB2CGdsEnAlSF84uBJWzBXtcXbuHKAMEGmpcx0SoaPi4oPXFVLys5XVPd?=
 =?us-ascii?Q?7ptTaf9EUzoOp33y54Vf3Xvs1wJobXAJcUcRKL/6ms58mPXhYqvjIhK8YWmU?=
 =?us-ascii?Q?XzUt6W7SZscUJ3XgvXRu9hnqM7s+Nl2tZk/J7P2AxW/AtfApM7MaDg8vFdlg?=
 =?us-ascii?Q?uMbJJpHN1LVD5dY/5Ql3SQO2PHpYq6TdTnTGbFRU1rP7Kf6hC+dc1CdbtG4f?=
 =?us-ascii?Q?AjrsqNCOLsyEZrYFdCgkb41/x4k1/la/OSrMAEc1adQuQl3OYyrxKRqSB+vb?=
 =?us-ascii?Q?UO1UokwTNUSImE0xZqakp/wSk+l3kA8DNszhc5qebkBHFbLxsNkvbXrT5B+k?=
 =?us-ascii?Q?Ut/1ys92SShDj6df8sBVZeER0HOaHkv55fKo1uxAtcLW4k3EL5aOMvr9sMuw?=
 =?us-ascii?Q?/7ZSrF+jeRbAr8e3tQ2dCOvXwCRS3bB46pf1AMAr4fK0C3oN/NpCcO0ot3L/?=
 =?us-ascii?Q?xxEyswvJD/V0EfL8TKWx1L+XuiDkDqnPcNFdB1kxNiPkzOkKFPH3uOspbXSV?=
 =?us-ascii?Q?0UkI+eyW8UTPvcZAhGddd7Vj6r1ICOXnPETTEZy9Ucigc0PINPTVbVqAlfMp?=
 =?us-ascii?Q?5/513nzkFvslzGMCnPcY3eHernr8HytPVq5Ff+76JK27wziP1QbnlBEugltA?=
 =?us-ascii?Q?9xR6rOocJqxAt4sQKkO4ct6/G9J7LJjkl+u0xxdyCdKiCYadIDbubqkS94cK?=
 =?us-ascii?Q?PkLiYnovpJKDqkKGMhZgISkGKI6JHGwFiHAOrreUvaiSpuXh63j+cX2z5vUQ?=
 =?us-ascii?Q?7747XMlYiWgywS0sZcP5Jf/3cxaDQB1d4qmBeZgQ187SIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2fxafu/G0MoDdEqUA2pAvFvOO6C0FePmSJE5QC6EXM9tExD25OCJkfBXW6c9?=
 =?us-ascii?Q?9K9t6sgOQPQ4wj7nr+7kJ00H0EOYvsjLScuJ58xZ/qavf1gcyajUYYjUuDiB?=
 =?us-ascii?Q?FzCgHnkVS92P9jBxzQnzzAjW4KE6/ozTouubAXRVeBh+oM8/h1OlcqY78t4z?=
 =?us-ascii?Q?mEg+vd3z1tExCsNfd4JgA0Zf74w51jPnXPIDoqQhBPEVxpPjIoBspa4uoc1S?=
 =?us-ascii?Q?8nspSBle73HeaMMMnAm3wzR/30XPLTJ1usULnnvrR3dMm4xOXTqTTd4np3CZ?=
 =?us-ascii?Q?2JShrP6iq3rjvWNjIyTGn2oA5N6aCz2E5yMGD3jSYAJa6+Uhj6LoA34oVd2k?=
 =?us-ascii?Q?fcjQlfcoCWN5PYueu2OVixWRg9HyLmhXh9aMPId3IfjJQSyEVnTvTNfXP56v?=
 =?us-ascii?Q?lj4f5wq4+rdo3+RunDy/dSP4s/IHJhdK3IwLzShUGzdiFwe1TpAnguyUhWwk?=
 =?us-ascii?Q?GnXC4QutSHNn+NUqLDKVaPW16SFtEVrnx2mARA91NB2MoSPHduh1XbqN2VJ5?=
 =?us-ascii?Q?yVc2LizY13qDQvbjEtWXaWzsPPW0wGxOwy+wM6Olg1G6GLhxywPjB7DObZ/9?=
 =?us-ascii?Q?UpSIiqAUmIfwyVtLgbLwm1H8JpjpGx7bJUOmixnVaaC3Bt7/ZWDz1hUaNTvQ?=
 =?us-ascii?Q?/7UeucA/asZhK31SQHkoy6FgKvkmKU05VDcIl1ke/F8aNmVMsVSwmMoiaoHh?=
 =?us-ascii?Q?wasrm6m9+6aub1wCQBT0MyYvLJZXfc0wdKwXDLmVpXc8N9I3d5LdwBv6lR/g?=
 =?us-ascii?Q?/zn4LIoZrhFrLoMW2qfGZcIx3KYbcQH4kiUsgN+zjc0nNR0z6F5u6aKIpsbq?=
 =?us-ascii?Q?fWeNMB0edRmjYovYKSlYNBPAzAqDJPlnTiI4MXbHLoPQapNFZIYbb4qUV32t?=
 =?us-ascii?Q?UNkIbHvH5S/4FyW3D8RUMzGUM3BQb8pl0HxUheR1tTPlRpJe42eZLnbHBD/+?=
 =?us-ascii?Q?4uSbQKk9104f070OReNq2Fwnzh3264konnbhyEvl6+B2lGE04UI6XOYopair?=
 =?us-ascii?Q?ZoYGTcVI2DBWYYuEgPn+P/1NQVhzum0wbP9rjabqyIH3QNqGuRRZO8JDvA1o?=
 =?us-ascii?Q?HbZpG0vgJNjWEUBk+BDeasl/35IS3H7+bWoNP5KRqPjLAvVFF9UfSP45Z3+F?=
 =?us-ascii?Q?AViCqj64yjZ9mIYVO/WbtURAU9oxJqZBvqzaxIz4SGaIHqN5jSNo4nwuRRsK?=
 =?us-ascii?Q?NeLyK9g/7snWkn2U9Cc11ncwM/dEKhwt9EVSOaeWAKSqK8ubKhtGqpERVYGE?=
 =?us-ascii?Q?i5N/fczmhJIGGtJRSD9r18u3CfO7MwHMoD7BvYn1veSIzZ2uf/aQM1UXBdkI?=
 =?us-ascii?Q?VfSvlAVjGYuknVcvtzceWnabpAShHZ5Ztp+ylTAEx6lB3sH+4M2uY72YIWXz?=
 =?us-ascii?Q?sajEib0BRNvOPo4WifhiNCsakFpxvxqiymYS+1viN7oODl/I7DcVZIx72wyx?=
 =?us-ascii?Q?/EjBcz0QwhlLLNdlznjR0AuvLGI/JVtoq3NukgAf8afIJ37c+QUPGQelxFd0?=
 =?us-ascii?Q?GDHZZp/deQFbrnGd3wx14pJOFi7RGF/n4CJXsYT1Dz6ARRosW/q8sNi5fDCJ?=
 =?us-ascii?Q?KHRZa6VMcuLeF4tVfU4prdpEut/zOgxt5pk16Fd3lNmfYuLiV55XGZf60OBz?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nFEBe9mjP1EhL87BH5dH4MoR7hig030ougmtqSYcTcaL1+QBAp8cdQ/Os5wDR7ttIQZ0pMo8K/2VdLGW4XfqSdHzxjg5OnELmwLt13HrXqlCz+DzwbCmgfGYLwCUWIfsHgde0MdG4neECONcKN9KbVBQ+P5ZP3+A39nnHrU3Q/tz0mgGb7kib9i2gSF7y+C/reZTEipgI64ol9SZBORUQTe8VPkps2OTsMrz+rKS8p/6cmhFrk38QiMrMqiIRDwmCkXM2hhEWQC+3LETnSHF7QhsWtwurj58jsSbyBj1SDwLoFc7bsdKDaIvaJzeajj7WHfepu5UIFAuXixU33i3NJBKblPMdjc+qhkSBvjWN6t/iLBXLbIuTDIQncqgg4QNK4ufXQip59ANp8cXorUdriCVOrGmo/9buwOQ3Kt8RSoz4qUfeGz4izT129YUx0J0gMmbdl3XITmUK7F95D1B7CWGytTPMk1qCmQitcZK2DCik5umYjEUsY4dK84OOKXRj+HBqpr4f4kRYSPWpUMKMoNNVVLeIo0qcHAyCiQjf049Wi/dFNd5CuK31/1pgByStsYL61oZtaaJ4sNSjpGKWLGPiBY9E4A7alOG6+Em6mM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161e3bda-7d83-4e6c-fa7b-08dcc3af39ef
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:07:34.0700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFjYLwbwMfuEwtwZOoDM2CuAbDP1EAUBBMLWNRRd0I+Ys6H2fd59UQI8G3rMT3nOJk8xlKd4QLkieYnGPzbDPZTZafOMWvSG+bXqQl7IaXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_16,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408230148
X-Proofpoint-ORIG-GUID: 4fa7QSw9MB7lBKP7mTwzLqoQx0Cg9pDY
X-Proofpoint-GUID: 4fa7QSw9MB7lBKP7mTwzLqoQx0Cg9pDY

The existing vma_merge() function is no longer required to handle what were
previously referred to as cases 1-3 (i.e. the merging of a new VMA), as
this is now handled by vma_merge_new_vma().

Additionally, simplify the convoluted control flow of the original,
maintaining identical logic only expressed more clearly and doing away with
a complicated set of cases, rather logically examining each possible
outcome - merging of both the previous and subsequent VMA, merging of the
previous VMA and merging of the subsequent VMA alone.

We now utilise the previously implemented commit_merge() function to share
logic with vma_expand() de-duplicating code and providing less surface area
for bugs and confusion. In order to do so, we adjust this function to
accept parameters specific to merging existing ranges.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c                | 527 +++++++++++++++++++++-------------------
 tools/testing/vma/vma.c |   9 +-
 2 files changed, 283 insertions(+), 253 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 8d670059e728..31c52598ee50 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -542,29 +542,297 @@ void validate_mm(struct mm_struct *mm)
 
 /* Actually perform the VMA merge operation. */
 static int commit_merge(struct vma_merge_struct *vmg,
-			struct vm_area_struct *remove)
+			struct vm_area_struct *adjust,
+			struct vm_area_struct *remove,
+			struct vm_area_struct *remove2,
+			long adj_start,
+			bool expanded)
 {
 	struct vma_prepare vp;
 
-	init_multi_vma_prep(&vp, vmg->vma, NULL, remove, NULL);
+	init_multi_vma_prep(&vp, vmg->vma, adjust, remove, remove2);
 
-	/* Note: vma iterator must be pointing to 'start'. */
-	vma_iter_config(vmg->vmi, vmg->start, vmg->end);
+	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
+		   vp.anon_vma != adjust->anon_vma);
+
+	if (expanded) {
+		/* Note: vma iterator must be pointing to 'start'. */
+		vma_iter_config(vmg->vmi, vmg->start, vmg->end);
+	} else {
+		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
+				adjust->vm_end);
+	}
 
 	if (vma_iter_prealloc(vmg->vmi, vmg->vma))
 		return -ENOMEM;
 
 	vma_prepare(&vp);
-	vma_adjust_trans_huge(vmg->vma, vmg->start, vmg->end, 0);
+	vma_adjust_trans_huge(vmg->vma, vmg->start, vmg->end, adj_start);
 	vma_set_range(vmg->vma, vmg->start, vmg->end, vmg->pgoff);
 
-	vma_iter_store(vmg->vmi, vmg->vma);
+	if (expanded)
+		vma_iter_store(vmg->vmi, vmg->vma);
+
+	if (adj_start) {
+		adjust->vm_start += adj_start;
+		adjust->vm_pgoff += PHYS_PFN(adj_start);
+		if (adj_start < 0) {
+			WARN_ON(expanded);
+			vma_iter_store(vmg->vmi, adjust);
+		}
+	}
 
 	vma_complete(&vp, vmg->vmi, vmg->vma->vm_mm);
 
 	return 0;
 }
 
+/*
+ * vma_merge_existing_range - Attempt to merge VMAs based on a VMA having its
+ * attributes modified.
+ *
+ * @vmg: Describes the modifications being made to a VMA and associated
+ *       metadata.
+ *
+ * When the attributes of a range within a VMA change, then it might be possible
+ * for immediately adjacent VMAs to be merged into that VMA due to having
+ * identical properties.
+ *
+ * This function checks for the existence of any such mergeable VMAs and updates
+ * the maple tree describing the @vmg->vma->vm_mm address space to account for
+ * this, as well as any VMAs shrunk/expanded/deleted as a result of this merge.
+ *
+ * As part of this operation, if a merge occurs, the @vmg object will have its
+ * vma, start, end, and pgoff fields modified to execute the merge. Subsequent
+ * calls to this function should reset these fields.
+ *
+ * Returns: The merged VMA if merge succeeds, or NULL otherwise.
+ *
+ * ASSUMPTIONS:
+ * - The caller must assign the VMA to be modifed to @vmg->vma.
+ * - The caller must have set @vmg->prev to the previous VMA, if there is one.
+ * - The caller must not set @vmg->next, as we determine this.
+ * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
+ * - vmi must be positioned within [@vmg->vma->vm_start, @vmg->vma->vm_end).
+ */
+static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *vmg)
+{
+	struct vm_area_struct *vma = vmg->vma;
+	struct vm_area_struct *prev = vmg->prev;
+	struct vm_area_struct *next, *res;
+	struct vm_area_struct *anon_dup = NULL;
+	struct vm_area_struct *adjust = NULL;
+	unsigned long start = vmg->start;
+	unsigned long end = vmg->end;
+	bool left_side = vma && start == vma->vm_start;
+	bool right_side = vma && end == vma->vm_end;
+	bool merge_both = false;
+	int err = 0;
+	long adj_start = 0;
+	bool merge_will_delete_vma, merge_will_delete_next;
+	bool merge_left, merge_right;
+	bool expanded;
+
+	mmap_assert_write_locked(vmg->mm);
+	VM_WARN_ON(!vma); /* We are modifying a VMA, so caller must specify. */
+	VM_WARN_ON(vmg->next); /* We set this. */
+	VM_WARN_ON(prev && start <= prev->vm_start);
+	VM_WARN_ON(start >= end);
+	/*
+	 * If vma == prev, then we are offset into a VMA. Otherwise, if we are
+	 * not, we must span a portion of the VMA.
+	 */
+	VM_WARN_ON(vma && ((vma != prev && vmg->start != vma->vm_start) ||
+			   vmg->end > vma->vm_end));
+	/* The vmi must be positioned within vmg->vma. */
+	VM_WARN_ON(vma && !(vma_iter_addr(vmg->vmi) >= vma->vm_start &&
+			    vma_iter_addr(vmg->vmi) < vma->vm_end));
+
+	vmg->state = VMA_MERGE_NOMERGE;
+
+	/*
+	 * If a special mapping or neither at the furthermost left or right side
+	 * of the VMA, then we have no chance of merging and should abort.
+	 *
+	 * We later require that vma->vm_flags == vm_flags, so this tests
+	 * vma->vm_flags & VM_SPECIAL, too.
+	 */
+	if (vmg->flags & VM_SPECIAL || (!left_side && !right_side))
+		return NULL;
+
+	if (left_side && prev && prev->vm_end == start && can_vma_merge_after(vmg)) {
+		merge_left = true;
+		vma_prev(vmg->vmi);
+	} else {
+		merge_left = false;
+	}
+
+	if (right_side) {
+		next = vmg->next = vma_lookup(vma->vm_mm, end);
+
+		/*
+		 * We can merge right if there is a subsequent VMA, if it is
+		 * immediately adjacent, and if it is compatible with vma.
+		 */
+		merge_right = next && end == next->vm_start &&
+			can_vma_merge_before(vmg);
+
+		/*
+		 * We can only merge both if the anonymous VMA of the previous
+		 * VMA is compatible with the anonymous VMA of the subsequent
+		 * VMA.
+		 *
+		 * Otherwise, we default to merging only the left.
+		 */
+		if (merge_left && merge_right)
+			merge_right = merge_both =
+				is_mergeable_anon_vma(prev->anon_vma,
+						      next->anon_vma, NULL);
+	} else {
+		merge_right = false;
+		next = NULL;
+	}
+
+	/* If we have nothing to merge, abort. */
+	if (!merge_left && !merge_right)
+		return NULL;
+
+	/* If we span the entire VMA, a merge implies it will be deleted. */
+	merge_will_delete_vma = left_side && right_side;
+	/*
+	 * If we merge both VMAs, then next is also deleted. This implies
+	 * merge_will_delete_vma also.
+	 */
+	merge_will_delete_next = merge_both;
+
+	/* No matter what happens, we will be adjusting vma. */
+	vma_start_write(vma);
+
+	if (merge_left)
+		vma_start_write(prev);
+
+	if (merge_right)
+		vma_start_write(next);
+
+	if (merge_both) {
+		/*
+		 *         |<----->|
+		 * |-------*********-------|
+		 *   prev     vma     next
+		 *  extend   delete  delete
+		 */
+
+		vmg->vma = prev;
+		vmg->start = prev->vm_start;
+		vmg->end = next->vm_end;
+		vmg->pgoff = prev->vm_pgoff;
+
+		/*
+		 * We already ensured anon_vma compatibility above, so now it's
+		 * simply a case of, if prev has no anon_vma object, which of
+		 * next or vma contains the anon_vma we must duplicate.
+		 */
+		err = dup_anon_vma(prev, next->anon_vma ? next : vma, &anon_dup);
+	} else if (merge_left) {
+		/*
+		 *         |<----->| OR
+		 *         |<--------->|
+		 * |-------*************
+		 *   prev       vma
+		 *  extend shrink/delete
+		 */
+
+		vmg->vma = prev;
+		vmg->start = prev->vm_start;
+		vmg->pgoff = prev->vm_pgoff;
+
+		if (merge_will_delete_vma) {
+			/*
+			 * can_vma_merge_after() assumed we would not be
+			 * removing vma, so it skipped the check for
+			 * vm_ops->close, but we are removing vma.
+			 */
+			if (vma->vm_ops && vma->vm_ops->close)
+				err = -EINVAL;
+		} else {
+			adjust = vma;
+			adj_start = vmg->end - vma->vm_start;
+		}
+
+		if (!err)
+			err = dup_anon_vma(prev, vma, &anon_dup);
+	} else { /* merge_right */
+		/*
+		 *     |<----->| OR
+		 * |<--------->|
+		 * *************-------|
+		 *      vma       next
+		 * shrink/delete extend
+		 */
+
+		pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
+
+		VM_WARN_ON(!merge_right);
+		/* If we are offset into a VMA, then prev must be vma. */
+		VM_WARN_ON(vmg->start > vma->vm_start && prev && vma != prev);
+
+		if (merge_will_delete_vma) {
+			vmg->vma = next;
+			vmg->end = next->vm_end;
+			vmg->pgoff = next->vm_pgoff - pglen;
+		} else {
+			/*
+			 * We shrink vma and expand next.
+			 *
+			 * IMPORTANT: This is the ONLY case where the final
+			 * merged VMA is NOT vmg->vma, but rather vmg->next.
+			 */
+
+			vmg->start = vma->vm_start;
+			vmg->end = start;
+			vmg->pgoff = vma->vm_pgoff;
+
+			adjust = next;
+			adj_start = -(vma->vm_end - start);
+		}
+
+		err = dup_anon_vma(next, vma, &anon_dup);
+	}
+
+	if (err)
+		goto abort;
+
+	/*
+	 * In nearly all cases, we expand vmg->vma. There is one exception -
+	 * merge_right where we partially span the VMA. In this case we shrink
+	 * the end of vmg->vma and adjust the start of vmg->next accordingly.
+	 */
+	expanded = !merge_right || merge_will_delete_vma;
+
+	if (commit_merge(vmg, adjust,
+			 merge_will_delete_vma ? vma : NULL,
+			 merge_will_delete_next ? next : NULL,
+			 adj_start, expanded)) {
+		if (anon_dup)
+			unlink_anon_vmas(anon_dup);
+
+		vmg->state = VMA_MERGE_ERROR_NOMEM;
+		return NULL;
+	}
+
+	res = merge_left ? prev : next;
+	khugepaged_enter_vma(res, vmg->flags);
+
+	vmg->state = VMA_MERGE_SUCCESS;
+	return res;
+
+abort:
+	vma_iter_set(vmg->vmi, start);
+	vma_iter_load(vmg->vmi);
+	vmg->state = VMA_MERGE_ERROR_NOMEM;
+	return NULL;
+}
+
 /*
  * vma_merge_new_range - Attempt to merge a new VMA into address space
  *
@@ -717,7 +985,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	/* Only handles expanding */
 	VM_WARN_ON(vma->vm_start < vmg->start || vma->vm_end > vmg->end);
 
-	if (commit_merge(vmg, remove_next ? next : NULL))
+	if (commit_merge(vmg, NULL, remove_next ? next : NULL, NULL, 0, true))
 		goto nomem;
 
 	return 0;
@@ -1092,249 +1360,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
 }
 
-/*
- * Given a mapping request (addr,end,vm_flags,file,pgoff,anon_name),
- * figure out whether that can be merged with its predecessor or its
- * successor.  Or both (it neatly fills a hole).
- *
- * In most cases - when called for mmap, brk or mremap - [addr,end) is
- * certain not to be mapped by the time vma_merge is called; but when
- * called for mprotect, it is certain to be already mapped (either at
- * an offset within prev, or at the start of next), and the flags of
- * this area are about to be changed to vm_flags - and the no-change
- * case has already been eliminated.
- *
- * The following mprotect cases have to be considered, where **** is
- * the area passed down from mprotect_fixup, never extending beyond one
- * vma, PPPP is the previous vma, CCCC is a concurrent vma that starts
- * at the same address as **** and is of the same or larger span, and
- * NNNN the next vma after ****:
- *
- *     ****             ****                   ****
- *    PPPPPPNNNNNN    PPPPPPNNNNNN       PPPPPPCCCCCC
- *    cannot merge    might become       might become
- *                    PPNNNNNNNNNN       PPPPPPPPPPCC
- *    mmap, brk or    case 4 below       case 5 below
- *    mremap move:
- *                        ****               ****
- *                    PPPP    NNNN       PPPPCCCCNNNN
- *                    might become       might become
- *                    PPPPPPPPPPPP 1 or  PPPPPPPPPPPP 6 or
- *                    PPPPPPPPNNNN 2 or  PPPPPPPPNNNN 7 or
- *                    PPPPNNNNNNNN 3     PPPPNNNNNNNN 8
- *
- * It is important for case 8 that the vma CCCC overlapping the
- * region **** is never going to extended over NNNN. Instead NNNN must
- * be extended in region **** and CCCC must be removed. This way in
- * all cases where vma_merge succeeds, the moment vma_merge drops the
- * rmap_locks, the properties of the merged vma will be already
- * correct for the whole merged range. Some of those properties like
- * vm_page_prot/vm_flags may be accessed by rmap_walks and they must
- * be correct for the whole merged range immediately after the
- * rmap_locks are released. Otherwise if NNNN would be removed and
- * CCCC would be extended over the NNNN range, remove_migration_ptes
- * or other rmap walkers (if working on addresses beyond the "end"
- * parameter) may establish ptes with the wrong permissions of CCCC
- * instead of the right permissions of NNNN.
- *
- * In the code below:
- * PPPP is represented by *prev
- * CCCC is represented by *curr or not represented at all (NULL)
- * NNNN is represented by *next or not represented at all (NULL)
- * **** is not represented - it will be merged and the vma containing the
- *      area is returned, or the function will return NULL
- */
-static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
-{
-	struct mm_struct *mm = vmg->mm;
-	struct vm_area_struct *prev = vmg->prev;
-	struct vm_area_struct *curr, *next, *res;
-	struct vm_area_struct *vma, *adjust, *remove, *remove2;
-	struct vm_area_struct *anon_dup = NULL;
-	struct vma_prepare vp;
-	pgoff_t vma_pgoff;
-	int err = 0;
-	bool merge_prev = false;
-	bool merge_next = false;
-	bool vma_expanded = false;
-	unsigned long addr = vmg->start;
-	unsigned long end = vmg->end;
-	unsigned long vma_start = addr;
-	unsigned long vma_end = end;
-	pgoff_t pglen = PHYS_PFN(end - addr);
-	long adj_start = 0;
-
-	vmg->state = VMA_MERGE_NOMERGE;
-
-	/*
-	 * We later require that vma->vm_flags == vm_flags,
-	 * so this tests vma->vm_flags & VM_SPECIAL, too.
-	 */
-	if (vmg->flags & VM_SPECIAL)
-		return NULL;
-
-	/* Does the input range span an existing VMA? (cases 5 - 8) */
-	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
-
-	if (!curr ||			/* cases 1 - 4 */
-	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
-		next = vmg->next = vma_lookup(mm, end);
-	else
-		next = vmg->next = NULL;	/* case 5 */
-
-	if (prev) {
-		vma_start = prev->vm_start;
-		vma_pgoff = prev->vm_pgoff;
-
-		/* Can we merge the predecessor? */
-		if (addr == prev->vm_end && can_vma_merge_after(vmg)) {
-			merge_prev = true;
-			vma_prev(vmg->vmi);
-		}
-	}
-
-	/* Can we merge the successor? */
-	if (next && can_vma_merge_before(vmg)) {
-		merge_next = true;
-	}
-
-	/* Verify some invariant that must be enforced by the caller. */
-	VM_WARN_ON(prev && addr <= prev->vm_start);
-	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
-	VM_WARN_ON(addr >= end);
-
-	if (!merge_prev && !merge_next)
-		return NULL; /* Not mergeable. */
-
-	if (merge_prev)
-		vma_start_write(prev);
-
-	res = vma = prev;
-	remove = remove2 = adjust = NULL;
-
-	/* Can we merge both the predecessor and the successor? */
-	if (merge_prev && merge_next &&
-	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
-		vma_start_write(next);
-		remove = next;				/* case 1 */
-		vma_end = next->vm_end;
-		err = dup_anon_vma(prev, next, &anon_dup);
-		if (curr) {				/* case 6 */
-			vma_start_write(curr);
-			remove = curr;
-			remove2 = next;
-			/*
-			 * Note that the dup_anon_vma below cannot overwrite err
-			 * since the first caller would do nothing unless next
-			 * has an anon_vma.
-			 */
-			if (!next->anon_vma)
-				err = dup_anon_vma(prev, curr, &anon_dup);
-		}
-	} else if (merge_prev) {			/* case 2 */
-		if (curr) {
-			vma_start_write(curr);
-			if (end == curr->vm_end) {	/* case 7 */
-				/*
-				 * can_vma_merge_after() assumed we would not be
-				 * removing prev vma, so it skipped the check
-				 * for vm_ops->close, but we are removing curr
-				 */
-				if (curr->vm_ops && curr->vm_ops->close)
-					err = -EINVAL;
-				remove = curr;
-			} else {			/* case 5 */
-				adjust = curr;
-				adj_start = end - curr->vm_start;
-			}
-			if (!err)
-				err = dup_anon_vma(prev, curr, &anon_dup);
-		}
-	} else { /* merge_next */
-		vma_start_write(next);
-		res = next;
-		if (prev && addr < prev->vm_end) {	/* case 4 */
-			vma_start_write(prev);
-			vma_end = addr;
-			adjust = next;
-			adj_start = -(prev->vm_end - addr);
-			err = dup_anon_vma(next, prev, &anon_dup);
-		} else {
-			/*
-			 * Note that cases 3 and 8 are the ONLY ones where prev
-			 * is permitted to be (but is not necessarily) NULL.
-			 */
-			vma = next;			/* case 3 */
-			vma_start = addr;
-			vma_end = next->vm_end;
-			vma_pgoff = next->vm_pgoff - pglen;
-			if (curr) {			/* case 8 */
-				vma_pgoff = curr->vm_pgoff;
-				vma_start_write(curr);
-				remove = curr;
-				err = dup_anon_vma(next, curr, &anon_dup);
-			}
-		}
-	}
-
-	/* Error in anon_vma clone. */
-	if (err)
-		goto anon_vma_fail;
-
-	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
-		vma_expanded = true;
-
-	if (vma_expanded) {
-		vma_iter_config(vmg->vmi, vma_start, vma_end);
-	} else {
-		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
-				adjust->vm_end);
-	}
-
-	if (vma_iter_prealloc(vmg->vmi, vma))
-		goto prealloc_fail;
-
-	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
-	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
-		   vp.anon_vma != adjust->anon_vma);
-
-	vma_prepare(&vp);
-	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_start);
-	vma_set_range(vma, vma_start, vma_end, vma_pgoff);
-
-	if (vma_expanded)
-		vma_iter_store(vmg->vmi, vma);
-
-	if (adj_start) {
-		adjust->vm_start += adj_start;
-		adjust->vm_pgoff += adj_start >> PAGE_SHIFT;
-		if (adj_start < 0) {
-			WARN_ON(vma_expanded);
-			vma_iter_store(vmg->vmi, next);
-		}
-	}
-
-	vma_complete(&vp, vmg->vmi, mm);
-	validate_mm(mm);
-	khugepaged_enter_vma(res, vmg->flags);
-
-	vmg->state = VMA_MERGE_SUCCESS;
-	return res;
-
-prealloc_fail:
-	vmg->state = VMA_MERGE_ERROR_NOMEM;
-	if (anon_dup)
-		unlink_anon_vmas(anon_dup);
-
-anon_vma_fail:
-	if (err == -ENOMEM)
-		vmg->state = VMA_MERGE_ERROR_NOMEM;
-
-	vma_iter_set(vmg->vmi, addr);
-	vma_iter_load(vmg->vmi);
-	return NULL;
-}
-
 /*
  * We are about to modify one or multiple of a VMA's flags, policy, userfaultfd
  * context and anonymous VMA name within the range [start, end).
@@ -1354,7 +1379,7 @@ static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
 	struct vm_area_struct *merged;
 
 	/* First, try to merge. */
-	merged = vma_merge(vmg);
+	merged = vma_merge_existing_range(vmg);
 	if (merged)
 		return merged;
 
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 3a3a850d951c..d31bb7bd972a 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -112,7 +112,7 @@ static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
  */
 static struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
 {
-	return vma_merge(vmg);
+	return vma_merge_existing_range(vmg);
 }
 
 /*
@@ -752,7 +752,12 @@ static bool test_vma_merge_with_close(void)
 	vmg.vma = vma;
 	/* Make sure merge does not occur. */
 	ASSERT_EQ(merge_existing(&vmg), NULL);
-	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
+	/*
+	 * Initially this is misapprehended as an out of memory report, as the
+	 * close() check is handled in the same way as anon_vma duplication
+	 * failures, however a subsequent patch resolves this.
+	 */
+	ASSERT_EQ(vmg.state, VMA_MERGE_ERROR_NOMEM);
 
 	cleanup_mm(&mm, &vmi);
 	return true;
-- 
2.46.0


