Return-Path: <linux-kernel+bounces-248169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3068292D915
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92A69B25006
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75B619925A;
	Wed, 10 Jul 2024 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PhNxe6Wr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t1uZ4w07"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4808A198E75
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639433; cv=fail; b=ZXPPua/xy44NFwG3usyLevwvCk/xHk/YiM/oghoiDanxAwaGSqI16YNRCXMcw/gMBUS4ESMH+m01Uv5Xo4ndpwfgaND8vNPuv/tVFj9nbzhWy+CibDptwNCfJPdEiDEIE5cxG2MmlGgn3pXtO/PEBB39ZLS7ZYrJNAb7J8MQvcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639433; c=relaxed/simple;
	bh=LRr5Qp5g578MIQeoqcd3VHi2/VCpxWdNp89F2/ElgMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t8CFEbPB8dTZHC3r64Bh2PwxBIyAHuNFPKxmvSpeD0SHgZOAwW6twYVIffR6tPtKKKFbYXUpcXj3gncn7FXddP3PaCjIVR0McglZZph1hwYh4mSjClK0Rb+8c23R12GY3LwbZ5vHvH/j7SbYGSbzLK2Q5IkyF5Hj5XODhakgDfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PhNxe6Wr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t1uZ4w07; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AG6eq5017502;
	Wed, 10 Jul 2024 19:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=l1bikM7qDZXJmibT+K9xa3k5hYIYZogr/swJJwrXmuo=; b=
	PhNxe6WrhJimgdDnXMYCE0iWgRt1v9klUnXJ6sJqAycID54+T9tszT2UOq3SXQpw
	o5zooxJuye5+gVu4DWYBt6xv2W91v16Veuhu52UVTcKrhlSeE6r4DEhCBiPo+4I/
	ztAcREaIkKpwuNMqBmZH65M0ne1m1vFwEyYNkKrlrhSHObOBI09wl7v5gJJfBQyL
	A6l73xqIFEdSxz/7FS/lL4Y0hgAdXOLXOVcy+vN8AKQp6kTu/iYjNEWdklYO8PCG
	WSQyCuen7e4mT6eTtDeNI50XGA3vrd16xAD+Z5S9rdkkwFUuM1eg8+/Rs5/+cVUS
	OpQiFd4mDdYsy6nkoanceA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybr4d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AIihMF033699;
	Wed, 10 Jul 2024 19:23:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv1948k-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMgvQAPapRX9JonYseuxzWf5u21EWFMbeCSURODDHH0Yr1YPgOX9iOFkmEufqZEvqYrH4NsotnKkE6RoXoQ4fGXE89PDvGpxoHUf6Lnp3GQh7QdtPF4j+/3iecH7XzBIMLlXYC2JNEvXzXHisQETwo2um+XqyaB9JXQIpxFvUoZpsRbCv82nBhG1hysT2J+kIx/wka1Ik5AlSdICGp9zZYJz0XLa0uKl/9pnLaTHqmBVlm/vdVxDBeuQ7Opj6Vzt8jqYBWhhpWPOk15W7pP+qdp8mXGVzQQ08cCeSna4SzFIUo2e71K2p+h1hN6Tjlae30ARFhYqUcI0IQLZ7gYR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1bikM7qDZXJmibT+K9xa3k5hYIYZogr/swJJwrXmuo=;
 b=IxNvpqP0y252vjoc+DKo6HfYwPHplLN34f0YqjAfNlJcCelmaxlCqzpGF80tub6/OXH9RL7LTvbNGh1XsAS/hNXK3w4/5liVtsALGwZLPKGEN3AXVPVx+3j5Kz74HielRKL+Xs3Tb/bytP7XIjQo4l4rh0oZ1rlUcO5kUtUs/0GLmXjtte378HV3uFDI+b5lk8pIqoy/oeo0ORGHUkM4WcdJCNetmvwUN+XfrjiBe6qLEUQTXyVF9Y+opCI7yx5YrSacBdOqs8G/fJKr3F/P0+VSHaPeSkw+breDzE7w/LkBWkXSnj3Wo0VF1vzLtFtTCmJX4OapyG4Txfutc9pQ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1bikM7qDZXJmibT+K9xa3k5hYIYZogr/swJJwrXmuo=;
 b=t1uZ4w072K6lQeI0nI1gVC8yl51YhDNFOS+DGUAiVz9iBsksfr9ZD33q6A2yX/879Zw1+rKv0Fnbjev2zvlkCBxDRL+VXDNckhOuNAjrHMUivxGx4lK3DC5a2Ek9eQqhD4eni1SOYp2+56j9kBX8GQr+5B//99/w7aEhFqg5Jus=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB7295.namprd10.prod.outlook.com (2603:10b6:8:f7::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.36; Wed, 10 Jul 2024 19:23:09 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 19:23:09 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v4 05/21] mm/mmap: Introduce vma_munmap_struct for use in munmap operations
Date: Wed, 10 Jul 2024 15:22:34 -0400
Message-ID: <20240710192250.4114783-6-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YTBP288CA0001.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 96bc9b43-5ea3-4725-c629-08dca115bb4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?II+BAusK9PAuxsHVAN0kVVzJzDe3V3V5romBY2yyH9nrOTuhDRHopjsOn3Ht?=
 =?us-ascii?Q?Ky4f+49rUeWbDIsn0qHcSEC8bYOglbFiIUCYjTsF0O8g3TcJwmQ2zX02JtY9?=
 =?us-ascii?Q?Ea12sRPRYt/CnCL52dY1+kBPE0UiraiF8s0PWhX9QhEdlr30vG3Xvwj/HykV?=
 =?us-ascii?Q?vq1m+v5DHFQMMPJp1EueGadtalrH3NufnMW/1aFjF6kCsVH12Vc4daUhjLN4?=
 =?us-ascii?Q?0TSSFpgZ1W7Q8xpd1u7sfQO8lGPhjI1OfgMjzj7TtrshLkYqiItYN9uRAijR?=
 =?us-ascii?Q?rcBOFQ9Wck//CwvLVGPK6K0C4knmEY46lxW6fU/ZFYULQAdS4MXj3QnZT8za?=
 =?us-ascii?Q?61PKz8HxO4+tfcXhXAHK9qm3Fn+Gdj3U54I4uO5eWbugWHAkTNRPMblW84kX?=
 =?us-ascii?Q?VWtAG1BGwJZo0/u4dAJej/QT3EAB/zDG67JRfrPXsy9Tbt4Qhn4ei1gxkWVT?=
 =?us-ascii?Q?p4mlkfasXHfllJKzsrvqi56SXxbU2ESHJwsu7EDQlYz6r0eRI68yuQhilYSY?=
 =?us-ascii?Q?LqAX1MuEUf9y7JB9og0yZY6WgZumyrNB5n3m7b9PWDvunL6tw9SJMkaFIz6q?=
 =?us-ascii?Q?yiByVdYoJxwbJDoqqrOXiCRhC0D7SWgZa7yPIrOIflKNHMy8aNl9T4gEB620?=
 =?us-ascii?Q?khuPFKd1eTnDZCZ1dDooOeG3xAuKCfhQoxad+Xh+u58jsoiFlhU7S2PcWVAG?=
 =?us-ascii?Q?P+SWS5zgLQ5214yP/7M40bAkXQA3oSs1eekGjaIpwlGli0xxrwbHUSht0+tl?=
 =?us-ascii?Q?Xo6HGMSXv03AdLog+6UD82ywBw4O6us5JvyH2FmdlkJIdT77Igkp+YUOhqwK?=
 =?us-ascii?Q?W7u7ViSZY0JF/9mcUCYIHwY4LDuuJhJsQEDEOuBA8Uy16vwneyuzZbT1i6kc?=
 =?us-ascii?Q?ah6BJUnC6jdCFl8nIqDnNNWs37xrMkmw/GZZezN3ScYdPuDPjR5sZPbNzGOh?=
 =?us-ascii?Q?HN+FUJHpagP22irkf+CkVdyH54k9ALTKC+ruH4PCGYCGJTiyd3D/uHVd0qYa?=
 =?us-ascii?Q?VHAISjMaEU90Y7DNBJofXfL2Yf9aZywHs301EatvQ2cie7LPUkfMfsbrwqlK?=
 =?us-ascii?Q?vjGKCdKiCoE+QJGu+eZSKQ6b5+51bjVB2FslKYgd6jfaJuKYdfZ67r/r6tQe?=
 =?us-ascii?Q?ikpDsm5ODjvYOHScHf0ZGuCIzOr95SmDMLtwet3H0AfaiJOWf40+irkkJFKJ?=
 =?us-ascii?Q?atKve7FOpHD2dB6ue7v8+eP+BvmtCZUXLdIAvWNNYusiOKUCfsF2kKv5t+sR?=
 =?us-ascii?Q?fRWZwmR95CPhpFw2TUmtBHgoS1k6j9A7OQfx95YX4nKUi0VTbz60RqGtpebu?=
 =?us-ascii?Q?/Aj983tlfAZIXa0wYqYDVSxWI+E/gaF+v5Qe3yxOnlSbpQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bS6TzQ/LMTLvoAbmH7ZegUf50gV0WK/ePWk/SJ6YKMna9d508/7JcGCc6J1l?=
 =?us-ascii?Q?jfe/J34/mQCSPXByxGN+0oh3I67H/ZwupJTam3nL0/pyDbL6OkrShOjH4vk1?=
 =?us-ascii?Q?E+q2U5LbKHEamoqXcu38E1oMiPmV5kfGYAr/dPoaIFoj7TgOCuarDzzMqfZy?=
 =?us-ascii?Q?3CiBSi3ZGZb/H1JkMHFfr7rpVp0jBW38bmeJh0AkyrNAh/OnOk/CypYx6a4c?=
 =?us-ascii?Q?GvWQp0L7mdiXL1By8xAS1a2TQ27YwCVdAo3zvGHmXZy4DyZumi26xHm10Z+G?=
 =?us-ascii?Q?eBRi958kJUV4Uji3nuwcUGnLfsmKtX9+tYx+uf+nG4HnTs9ebNYfc50lQ3BM?=
 =?us-ascii?Q?tL8kHH+JmHM7DG9W72/i2rrdtgAZopz1+8FcOdTHjlo55sRH+cl8EiyjuZb/?=
 =?us-ascii?Q?UQhcpJEKeCdPThcLm2426eOnuud8ACgJWx7YVSgntoTrhRVahQvPLAKDJywX?=
 =?us-ascii?Q?E3GbDssaKZ5Aj6rVvKy2rRGWrQfRE9waWQVBJBvn1Fh9zn9HkRxBfca/BMrH?=
 =?us-ascii?Q?+b5HMeASY0N5oauIVZNnbIHqmtpQHp7LQsoWYzmOdW0sfDt+yuNr/zEASDiy?=
 =?us-ascii?Q?4QuGcWS9lYMnulYo9XAq+/sOCpv9GPaUYXTaUovrSNeldWtDtgxptmpUYVTG?=
 =?us-ascii?Q?CFUv9CegKzOALTMHuC5tPkPQFhDWid/HVdWEQni8xnyFGTs8cELJ8nZEf+jy?=
 =?us-ascii?Q?0lXCP3nWge/PXNjRKhLB4USm7bFcWAW97Kwg7kklf7r4Ly3/B7QpDqfHmQEX?=
 =?us-ascii?Q?72B/rN5IYUfyfNH8Fvn3SKXJNh4fJd/1m9wGCJ6IP/KQjnPE8463X8U5VmRF?=
 =?us-ascii?Q?qAVtcVX/naL+1zW/NAbBg0BQl2Opq991wA96W31cc3mmnfBK7fucipLrnvB+?=
 =?us-ascii?Q?P+hWz+Rm58L13pqe6XWVVO0jrqyMN7n8swn9mN0xyoP35knX7NCQqLcuDGbc?=
 =?us-ascii?Q?IgOO2eZwftu3mm9RnHF6iiWeS/cV+JICmhoZNQha9z8ttB4Bh/WmMLzoHNmS?=
 =?us-ascii?Q?DRDZ4dqfqJSKr4tLJAM5j/5anOXj4TcKcpmRVccLUn4U8HoLm28ABOyIjTq2?=
 =?us-ascii?Q?+pujiI7taAshoauKDSDNB26xshwE0U1dM4FVDVzGuMPhr+X8hRhkddafN9gn?=
 =?us-ascii?Q?22+eH6siFyvRYTSN7C+/OQyQi8BddfQBHAeBOXhuiWCauMeg9CHf2dXPR0eG?=
 =?us-ascii?Q?T6EANILBkInnUeZla8h7dvOpSgCNM1dzGzH83eYfd/fQneh9yJFiKdzaa/Ol?=
 =?us-ascii?Q?I8A8Y1DYw+kDKZ9hEfZpEysxWGGHMQYd8yiIPUqZAphTlH4ddEJbsEAyU3ro?=
 =?us-ascii?Q?Jxmm3HFIiIIgSRTxL6qN6rI0ZoRf/TnZSbkEMLdYjwGujyYCvVd5QWkXTToh?=
 =?us-ascii?Q?F7HXrtqB9v/1Cvcm3ryP/TisYxicHTfJQOfWrm26v39Rhquc4eXLVCFx7kDW?=
 =?us-ascii?Q?xwG5FOXedrYfB8+ZAQQhY44xjwdyG4v4K3PhDFMwpbeUXkhKHep9VyaOhV6P?=
 =?us-ascii?Q?c24xwSVLDjVwmIuwweV4BuPlt3Ku4UspPvpOCNbeS2qnlG7E9TxgABKVIWFu?=
 =?us-ascii?Q?6S6EtD0PG+tw452VWFPBtQiWpNHw8ullBDbQiYyuIMNS8CeC4Xto2+dZBSOK?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Y4lz4BfC6GTQ6/XUw6FTkyD9XJsrV/DfWqWUFTjfQRVOYGJkcaYE86U/UrsAMTtx9GNp7edhaBzBN4uZU/LqwGRjc/xAdQN6MXCM9Uv1j9H1jkyXlFWg/Wh13KUf7MZtSYuGT7urrPNMCE6+MS27ZTcYns3PWNw+/ttrvi2veD3ptKlXDA8Ldbhx5X+qJslAcvy38wrhBMfrBM7OctgBgLE5x3JxZ4hGJ1N+TrAycoQXXuJjVT/0cJSuAG4IdFioC2zqHJJnTt4mevvBy9quBOnuLVNNbgFZhOEF8rX13qoOO1YdT2fSRj43h49THqojzl4mLo4jlU/xg4mQgbgaEQ0HC0qsDoI+SW/mh+5m7TocQbuze9WWpIf4bJ26AJ4SpvI6qgLQnYtP6er1BfGv3cSNzQTjGKfraSHjP/5Pzy2Jlk7yKPqh3nccnI/H8pGECaFYMqWdyCKodvLjwWcph/ojpzsBdnXuyPwziQGAUa0wpZH2iMTOua9xNUDXFMYeayIclad9UW7zXNhsI63/T8at1ztY6GVHoW1YLjomc90BGAiFHe/6BNKI+3bJcuZBXV6Iv5SpH+IXbaONMQKjBoTLi1+YLSwUO63Y5iYZY8w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bc9b43-5ea3-4725-c629-08dca115bb4b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:23:09.0085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ftYL95aoAmEhSzOOgCSHo/VsrE6StNAxTNIgbr2vMcm0CLHuVnSlBzCpBZgzJPPJnES4T3meTL/uy9IncMPPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_14,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100137
X-Proofpoint-GUID: aSbZQNEFBktszQSSddDGRI6RXCAPM04t
X-Proofpoint-ORIG-GUID: aSbZQNEFBktszQSSddDGRI6RXCAPM04t

Use a structure to pass along all the necessary information and counters
involved in removing vmas from the mm_struct.

Update vmi_ function names to vms_ to indicate the first argument
type change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h |  16 ++++++
 mm/mmap.c     | 138 ++++++++++++++++++++++++++------------------------
 2 files changed, 89 insertions(+), 65 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 2ea9a88dcb95..43b3c99c77ba 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1481,6 +1481,22 @@ struct vma_prepare {
 	struct vm_area_struct *remove2;
 };
 
+/*
+ * vma munmap operation
+ */
+struct vma_munmap_struct {
+	struct vma_iterator *vmi;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;	/* The first vma to munmap */
+	struct list_head *uf;		/* Userfaultfd list_head */
+	unsigned long start;		/* Aligned start addr (inclusive) */
+	unsigned long end;		/* Aligned end addr (exclusive) */
+	int vma_count;			/* Number of vmas that will be removed */
+	unsigned long nr_pages;		/* Number of pages being removed */
+	unsigned long locked_vm;	/* Number of locked pages */
+	bool unlock;			/* Unlock after the munmap */
+};
+
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid);
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 0d03fcf2ac0b..1ed0720c38c5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -500,6 +500,31 @@ static inline void init_vma_prep(struct vma_prepare *vp,
 	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
 }
 
+/*
+ * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
+ * @vms: The vma munmap struct
+ * @vmi: The vma iterator
+ * @vma: The first vm_area_struct to munmap
+ * @start: The aligned start address to munmap
+ * @end: The aligned end address to munmap
+ * @uf: The userfaultfd list_head
+ * @unlock: Unlock after the operation.  Only unlocked on success
+ */
+static inline void init_vma_munmap(struct vma_munmap_struct *vms,
+		struct vma_iterator *vmi, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, struct list_head *uf,
+		bool unlock)
+{
+	vms->vmi = vmi;
+	vms->vma = vma;
+	vms->mm = vma->vm_mm;
+	vms->start = start;
+	vms->end = end;
+	vms->unlock = unlock;
+	vms->uf = uf;
+	vms->vma_count = 0;
+	vms->nr_pages = vms->locked_vm = 0;
+}
 
 /*
  * vma_prepare() - Helper function for handling locking VMAs prior to altering
@@ -2603,81 +2628,63 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 }
 
 /*
- * vmi_complete_munmap_vmas() - Finish the munmap() operation
- * @vmi: The vma iterator
- * @vma: The first vma to be munmapped
- * @mm: The mm struct
- * @start: The start address
- * @end: The end address
- * @unlock: Unlock the mm or not
- * @mas_detach: them maple state of the detached vma maple tree
- * @locked_vm: The locked_vm count in the detached vmas
+ * vms_complete_munmap_vmas() - Finish the munmap() operation
+ * @vms: The vma munmap struct
+ * @mas_detach: The maple state of the detached vmas
  *
- * This function updates the mm_struct, unmaps the region, frees the resources
+ * This updates the mm_struct, unmaps the region, frees the resources
  * used for the munmap() and may downgrade the lock - if requested.  Everything
  * needed to be done once the vma maple tree is updated.
  */
-static void
-vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		struct mm_struct *mm, unsigned long start,
-		unsigned long end, bool unlock, struct ma_state *mas_detach,
-		unsigned long locked_vm)
+
+static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *prev, *next;
-	int count;
+	struct mm_struct *mm;
 
-	count = mas_detach->index + 1;
-	mm->map_count -= count;
-	mm->locked_vm -= locked_vm;
-	if (unlock)
+	mm = vms->mm;
+	mm->map_count -= vms->vma_count;
+	mm->locked_vm -= vms->locked_vm;
+	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	prev = vma_iter_prev_range(vmi);
-	next = vma_next(vmi);
+	prev = vma_iter_prev_range(vms->vmi);
+	next = vma_next(vms->vmi);
 	if (next)
-		vma_iter_prev_range(vmi);
+		vma_iter_prev_range(vms->vmi);
 
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
 	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
-		     !unlock);
+	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
+		     vms->vma_count, !vms->unlock);
 	/* Statistics and freeing VMAs */
 	mas_set(mas_detach, 0);
 	remove_mt(mm, mas_detach);
 	validate_mm(mm);
-	if (unlock)
+	if (vms->unlock)
 		mmap_read_unlock(mm);
 
 	__mt_destroy(mas_detach->tree);
 }
 
 /*
- * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
+ * vms_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
  * for removal at a later date.  Handles splitting first and last if necessary
  * and marking the vmas as isolated.
  *
- * @vmi: The vma iterator
- * @vma: The starting vm_area_struct
- * @mm: The mm_struct
- * @start: The aligned start address to munmap.
- * @end: The aligned end address to munmap.
- * @uf: The userfaultfd list_head
+ * @vms: The vma munmap struct
  * @mas_detach: The maple state tracking the detached tree
- * @locked_vm: a pointer to store the VM_LOCKED pages count.
  *
  * Return: 0 on success
  */
-static int
-vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		    struct mm_struct *mm, unsigned long start,
-		    unsigned long end, struct list_head *uf,
-		    struct ma_state *mas_detach, unsigned long *locked_vm)
+static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *next = NULL;
-	int count = 0;
 	int error = -ENOMEM;
 
 	/*
@@ -2689,17 +2696,18 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 */
 
 	/* Does it split the first one? */
-	if (start > vma->vm_start) {
+	if (vms->start > vms->vma->vm_start) {
 
 		/*
 		 * Make sure that map_count on return from munmap() will
 		 * not exceed its limit; but let map_count go just above
 		 * its limit temporarily, to help free resources as expected.
 		 */
-		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
+		if (vms->end < vms->vma->vm_end &&
+		    vms->mm->map_count >= sysctl_max_map_count)
 			goto map_count_exceeded;
 
-		error = __split_vma(vmi, vma, start, 1);
+		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
 		if (error)
 			goto start_split_failed;
 	}
@@ -2708,25 +2716,25 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	next = vma;
+	next = vms->vma;
 	do {
 		/* Does it split the end? */
-		if (next->vm_end > end) {
-			error = __split_vma(vmi, next, end, 0);
+		if (next->vm_end > vms->end) {
+			error = __split_vma(vms->vmi, next, vms->end, 0);
 			if (error)
 				goto end_split_failed;
 		}
 		vma_start_write(next);
-		mas_set(mas_detach, count++);
+		mas_set(mas_detach, vms->vma_count++);
 		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
 			goto munmap_gather_failed;
 
 		vma_mark_detached(next, true);
 		if (next->vm_flags & VM_LOCKED)
-			*locked_vm += vma_pages(next);
+			vms->locked_vm += vma_pages(next);
 
-		if (unlikely(uf)) {
+		if (unlikely(vms->uf)) {
 			/*
 			 * If userfaultfd_unmap_prep returns an error the vmas
 			 * will remain split, but userland will get a
@@ -2736,16 +2744,17 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			 * split, despite we could. This is unlikely enough
 			 * failure that it's not worth optimizing it for.
 			 */
-			error = userfaultfd_unmap_prep(next, start, end, uf);
+			error = userfaultfd_unmap_prep(next, vms->start,
+						       vms->end, vms->uf);
 
 			if (error)
 				goto userfaultfd_error;
 		}
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
-		BUG_ON(next->vm_start < start);
-		BUG_ON(next->vm_start > end);
+		BUG_ON(next->vm_start < vms->start);
+		BUG_ON(next->vm_start > vms->end);
 #endif
-	} for_each_vma_range(*vmi, next, end);
+	} for_each_vma_range(*(vms->vmi), next, vms->end);
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
@@ -2754,21 +2763,21 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count = 0;
 
-		vma_iter_set(vmi, start);
+		vma_iter_set(vms->vmi, vms->start);
 		rcu_read_lock();
-		vma_test = mas_find(&test, count - 1);
-		for_each_vma_range(*vmi, vma_mas, end) {
+		vma_test = mas_find(&test, vms->vma_count - 1);
+		for_each_vma_range(*(vms->vmi), vma_mas, vms->end) {
 			BUG_ON(vma_mas != vma_test);
 			test_count++;
-			vma_test = mas_next(&test, count - 1);
+			vma_test = mas_next(&test, vms->vma_count - 1);
 		}
 		rcu_read_unlock();
-		BUG_ON(count != test_count);
+		BUG_ON(vms->vma_count != test_count);
 	}
 #endif
 
-	while (vma_iter_addr(vmi) > start)
-		vma_iter_prev_range(vmi);
+	while (vma_iter_addr(vms->vmi) > vms->start)
+		vma_iter_prev_range(vms->vmi);
 
 	return 0;
 
@@ -2804,11 +2813,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	MA_STATE(mas_detach, &mt_detach, 0, 0);
 	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 	mt_on_stack(mt_detach);
+	struct vma_munmap_struct vms;
 	int error;
-	unsigned long locked_vm = 0;
 
-	error = vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
-				       &mas_detach, &locked_vm);
+	init_vma_munmap(&vms, vmi, vma, start, end, uf, unlock);
+	error = vms_gather_munmap_vmas(&vms, &mas_detach);
 	if (error)
 		goto gather_failed;
 
@@ -2817,8 +2826,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto clear_tree_failed;
 
 	/* Point of no return */
-	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
-				 locked_vm);
+	vms_complete_munmap_vmas(&vms, &mas_detach);
 	return 0;
 
 clear_tree_failed:
-- 
2.43.0


