Return-Path: <linux-kernel+bounces-416288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A0F9D42D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3541F234B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5BB170A2C;
	Wed, 20 Nov 2024 20:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TRBGvpMc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dvn5ijSg"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA252170A30;
	Wed, 20 Nov 2024 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132985; cv=fail; b=EvZNHlkGxrG2IY/BBuTWJQhzzFBvuOruqaSgezHnxgbOXQjM9IiI3oNZ+7LiRKD66752rfA0NEw3l39c1fGRZBO7OXkzHULNM7OVtL3Yu9kQlv8JvLaGu9z2S0smyx7Dyuugo4nXFBdBTdUwWUYAUv0lG3V8scRC9Uy8w+zdloA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132985; c=relaxed/simple;
	bh=vdUEl0LGtICWQxlud0uP4ch/z2uWLOpJ72koyYuBF+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M1jFivU6DvpHFjdxM4B4Hhn5uBIuwdu16/KMbT2NeUUmqooo0vycAXx2p7IoH/PA1EjXCyYkLKe1lGHtxzCZjoMMHwy1Wig/cNSIyBH/Hqi0/r1czn04nFKnyv3PXt+mBLdnmxzVAy2Tt6QYwelmumss5T5NskNl+2vtPY8RVyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TRBGvpMc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dvn5ijSg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKFtZiH026627;
	Wed, 20 Nov 2024 20:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=iehF7aVHuFhGwwOfmn
	lff1amk5BcpMOLl7dNNiMhUJw=; b=TRBGvpMcTZWo/3lpz4vglxxlGqVC22YbyX
	FVrZXyGGX4wzNByfSPnVMGtQdc6qLebwzT1KAXFUjlVI4y7X0vbizqkieF0eIFCS
	pmBodVVg+IYk4ZJNY1uArBrdoO8V4mkbKaSWuEZ+jvfeOuOMP6JpdyCe90IT+aXb
	RunVUcG0y2qDYVOHE4DS3/dMMVR++U7g1jKHTEjs7QZK7XrUhDXP3w0RtiLYmDQp
	6A5CrSsyhXk3fp1bQZgHQQbuzPNAlSe2eMIsX36GCRHjy6RA46HMq7Rs4VbvIt/z
	x0NjxFt4yK4dHkxa2IykCTaf37rrO728fVN0vQJ/upGt6nRkrrRQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtc8962-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 20:02:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKJPj1X039203;
	Wed, 20 Nov 2024 20:02:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhuahm26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 20:02:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySCx905e1XGZa7tvTu7jp0O3zoV13QaFK930JCni4try+GceEUfZ+GhehA6DmcQGdeT6d5MtA+m4lWAgfpur2c0VYL8726h/psWLJaampDRbJ/r61BHAMGVXvBbuO1Gkkb75Ja7rnSeBE+f60g72GZpCDnvt94FSUv2RkCF0A/yS/s/8sd3QDvhagKFN3UBLRSRIIbgivug81QUsW05fov4pQINbg5LLD/XtTyUIac9otEkshMmFzRsdJZDJxmhWN3YcYr2HpCgAwTfLXmKuZJA61OKCKwzI41NnuzyTefvK0Yv9wTJXNa/uswS1ml43+T6ryJMiNSlGcXiMymiCuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iehF7aVHuFhGwwOfmnlff1amk5BcpMOLl7dNNiMhUJw=;
 b=Hg8Q3SCP7ysGWeu9LLyEBUWkc3afEyW9nCLjWrbWZ3hUWCnv2ohH/mGB3jAah67BEYX1vdChKk1KWWNxX4DpBdOIlaFfHTHt17s72y7okAeKQCnpXPEBXRCFYfdGYDJjN2GmULJEpSQsdJ/RzEPj0InCLjNHEqowzmDkYzmNQIseEb6Q3Ppx2A5Tg1h3LvnLmlxhREp1Yiz/WszVCPzNCogBX7caiQfczRvWic2n7f2FD7xh/L8Buwmc+w08n2corc1TLQEsAPRq4JUqZWKlW6SLt6ANUEI032iOrE8t/BwsB86QFRTikuvOkLV71xWT8y6+5TawMoyogzpB3dQjGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iehF7aVHuFhGwwOfmnlff1amk5BcpMOLl7dNNiMhUJw=;
 b=dvn5ijSgXv4UOjYR1UlCl2hIfLZ+8xR22fQVFrL6O/QrL3lqY/W62CWmQfp/pcVWQwCD6A0Bwtrtlpt1RlFf1iU7sGcRCzyw8i04Fj0gY+KpuDzddczve/y6rGUOKb7cDFLwkHzht44HEK/JPtO4U3CeTMMKYmUZ68yAwzxLEDo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH2PR10MB4167.namprd10.prod.outlook.com (2603:10b6:610:ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Wed, 20 Nov
 2024 20:02:32 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 20:02:30 +0000
Date: Wed, 20 Nov 2024 20:02:28 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v8 6/7] mm: rust: add VmAreaNew
Message-ID: <8755851f-de55-4411-9a8a-80ff69f35905@lucifer.local>
References: <20241120-vma-v8-0-eb31425da66b@google.com>
 <20241120-vma-v8-6-eb31425da66b@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120-vma-v8-6-eb31425da66b@google.com>
X-ClientProxiedBy: LO4P265CA0091.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH2PR10MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa7be7d-899f-40e7-685a-08dd099e4406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZUPvbDdmTFU+vvEVzbJ92BrQjcSHuECBOQ35CmXmz+l1IcuNzwry3PxiKXOa?=
 =?us-ascii?Q?dPDtiKA3hQxjGJX4q7dHrp17Rv2g8nZG5V8LwkelnCJwm/CECru4uTxoptwP?=
 =?us-ascii?Q?qXksrzN4pgqqYPOiHWbT2iXQH0p9UnCHBROKcSeMnWF9nJ0/hkG9A1M968Bp?=
 =?us-ascii?Q?6W7Ui894C/E4zYun59H3qWDoUaUyFfdT9KVpRzSd0CtuNRPxK+xoe4PQvr4C?=
 =?us-ascii?Q?3YJwBHn9pDBdFVDR299FTg0bmMxNGGHWTIQYyT0/djRsQ2frM4s+uAo//geT?=
 =?us-ascii?Q?wyDU2h2ukLMk0pMxlRd3NDXu/cG7YGCtPrCFzn6ejOp4vn/RiFKViAKGpvv/?=
 =?us-ascii?Q?F4KYyYf/IiyU04qU6p/Rv0OVJ5L/rQ8m83JYAe/GCJ4D9+qSNp3yLZM0c4zN?=
 =?us-ascii?Q?4oT6aLRfk5q++UreNV+wAnJIvrpmPWLGax6dFxL8SshI5x/sHRRDAOOISq5c?=
 =?us-ascii?Q?LGhBqTSDVXF1Nqe4AIncvQXPMIixOqbtsd5j17FiOIU0gU0XbnGpP3ADXMqg?=
 =?us-ascii?Q?HzT13silnQEMds2LyhlVyQZ3/V2aZZdHh7/6X4bsVfgx4ZOgERguyLu3l1Lb?=
 =?us-ascii?Q?hwV4m6+0mmVELyx7+sGEIby2tY/z8QEPv6wFoBWCObfN7i43s95zA8YF1Wc5?=
 =?us-ascii?Q?feomlGSuSw/Db562by/lxwPi0jiRYYUcfbKnMxMJRROpE9KgB4QbWMs62KCs?=
 =?us-ascii?Q?AEnVUNsWul6vCbikye038haOS1qMuQ9t4RyeF8n+metuGXakw/JDf7gTJ0te?=
 =?us-ascii?Q?2yF0Fc8izy9sMM7BtEz6V9SwnnvAQcYY7wIKr03dO8dt3eOt/F0JUrhxQbzr?=
 =?us-ascii?Q?95xImkUy5xYwKdQTI4KhDZAWgxm0SWxK4nF0QVAo9kITlSMSu/bJeDXmvdVv?=
 =?us-ascii?Q?m/3OEkBnpkRQgYJBjNqcNEYI4xgd1xjXtvw6JNLPEVSfBxR0FhoP4nN+BLJ/?=
 =?us-ascii?Q?jLjKszV85wWaYScfHcJRmnOXqePzZyv7OBic7pEUgzENpJNNtLMqV1Eye79S?=
 =?us-ascii?Q?ed/6IvQVydocyrhHA3oTHGQ3KVdL1T5Fj+wxT7CyEAIkB4eLXJGUs96MIcxG?=
 =?us-ascii?Q?V5AmREEHLIghWNnLF3+i+h3onYwhmo7cwqQdJHf/E3262XYOJlVP8yMsGCjK?=
 =?us-ascii?Q?ySdIGXkmfChiL53NSXIRdT9Ikg6V2EbwFLzp1CSNeU4vnfKGZ0z3aDuVnwvY?=
 =?us-ascii?Q?ulLMmL2y9/1lJxoGW93y6/pLn8HIxkqqXa90DRGslXZZzDC6j/Cf5rjR0HxT?=
 =?us-ascii?Q?L/hGRYI2xCaYqWrCRpoQY9e+Z5M0LWv0u33wpIVhG3u4iBhmXAtX4V7TgzMd?=
 =?us-ascii?Q?YSqvMv0wvhLrYx5xdoP7WaQz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cpoQ3R2MEgElP5UygkH1EA+ras2P69qIB5d4MbxKQtrn+tKAw2zL5C2IE7G5?=
 =?us-ascii?Q?0L8mjmpz6yKoWT5DqFE1PuZgkH1bqmcyHPpj9ZqiwB1fia9kuIdF6y9JHicZ?=
 =?us-ascii?Q?JxH7Ay/AUsSuaDmqMXsz0YoSRed3b3qnqt8lemf7XGFJI700MJe2Fp7l2/Yx?=
 =?us-ascii?Q?6LxJ1pPDuXvfRSsy8JmDY/p+hN40oQ8kVTtjoX84jF5hnZkvFpyhM4AMBUuu?=
 =?us-ascii?Q?prLvXm19a9No7Ovi83A1tg9PXXEvvWKj/+MYDpe3DduONHw/mizQpat3t6ge?=
 =?us-ascii?Q?rDmwiL2y31nEGUk25QEU8/xt3IVMPTm3QMNBs2SQv4yjfPsPye7yOiI78PEr?=
 =?us-ascii?Q?PRY7ncqI8pABzyzXxEUyA140jrJp1XqV0JJDlehtV24ug1pp99OGm9AU/Po2?=
 =?us-ascii?Q?jImnWzYmjuEoIq4cub6chz6JiJrlgaz9MSnghK1Jg/7fd+dNEcFhZOLT27/H?=
 =?us-ascii?Q?xHM1NCU12YnENYeBX04WRNzInd37H8Q9C/N88IJReu9Bw3jt23W+9qhUUeaJ?=
 =?us-ascii?Q?60rPNI2nvfEJ19R85sQ3Jqt8+qpotVCbQV2oRLf9NwApBs401EPn6Q9/3P6t?=
 =?us-ascii?Q?R+vCYt/NFsLGvO2/r3RnTfx+b1sPths+M/S37RUiFK/PzA5UcUUPeAJadHwU?=
 =?us-ascii?Q?Hgnc7XbGuZdd4uuiWDFPD6CqpVKB/5pi0lOEF7ptXpBMJmbln0tOjK6yuOyv?=
 =?us-ascii?Q?NKKPzWgH56WFjZufMjYg1JbtSYr6zsRdrKfAmaQhsywKUI5qMxCosw5WTWgz?=
 =?us-ascii?Q?CZH9LOilQNdKcDZIqsFd2eswX8WqJ+zRcl8Os9OG6f7D5kzm/NaXJpICgT8t?=
 =?us-ascii?Q?nnptwSfa8Yknxysz24raTvKdpzWAAu/IXjz9RAWumisCIbbLzPvtfMMeUqWn?=
 =?us-ascii?Q?79rF0XR6pk3dWUUh44dAZ90TmdRexaI1xhDZXsxdn8o02wnAx1cFo5ddiIwJ?=
 =?us-ascii?Q?V1oguIbbV3B1JUtU5beJaAIiLKh6EHNxLoMGuFkoxPEmi7/7OvzGzEAi+Lkl?=
 =?us-ascii?Q?PgujTNcyJH+dUFj3NsOrHUfT0TOGQDuEN6A7FyP76JEVgV3BzKgrbdmnicYR?=
 =?us-ascii?Q?qSyLzh/O0yvSFxW+APruKHSFsxAYvgzgrdZC2GyvWZ5d6xih4acKUxY/bKRS?=
 =?us-ascii?Q?8nrsMdebsg0pFyo42In+lBaikW9z09jfAsVsm6HnCIecQV36Gq5RigcshpM6?=
 =?us-ascii?Q?Y7ADSatbsDVX9CHZC+/ozN+cp+1Xx0J+e+U3VwFiJdjBosX59TR58jG626aP?=
 =?us-ascii?Q?ULjGN463Qkyzo5bfm8zTQ9lTtiwi/ZYGzpP3Kqo5TRHMIP1LKjXtO1A1M/1s?=
 =?us-ascii?Q?XBV8vByVuRZaiE+lpuaWEQ0KGd8dJBnLwh9IbpFHr3tXEmifjEsoP5DuG2Ux?=
 =?us-ascii?Q?O45Dm4c562w/zLxpnvQXpPZkvv4oD0u8oE4I4y2yn/OTlkqrWNFoTm8f+Qqs?=
 =?us-ascii?Q?Q6i1JBm+2YFs5HMSWehJ4IiOMthyejui5oL8f/KDRT0x6JNaisM091+sgjRs?=
 =?us-ascii?Q?6kQcCmaBaS2gOxkqvjuM7hBQk0H/wNROoql711oSLtsI9RSsh2kDhJWNSRJe?=
 =?us-ascii?Q?T422BtMpL/FIQjRDXlgpgzGcCX64EGhP0uX/z/Pk8x8hRT1HgiXfmXme9EfD?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZmpA385fikNT6QxN+f5mbrDElFjYZIQAZmP0KIsTEeknJOZyWRWME/5f2rY9pqJNLWEXZMouaAQFdiIvFdN9WNoIB4y1p423JY5NVJroy4ORAdrtp3BnXLDGObPyXwGaiHImNSzV6s5EfYI69usIqX0zNqDZzEMx7DvGApTxrhMrmtmpdIDgE98WvElJXM+6Shho1ANqfbI8T2ryr01OU94JpD/y55vQrgbqO75kvnzhhDjqaw2sKJR7m9g/Gytp13IY0GRS7Wa05+76RypvcHaydELwecx7fuSu4+g/nQQAPmjCU+Nxh2d37L/nEIhjgzEHcxR6Qmg2ovbzV+1yrfPhFjNnVfVMwvPdub+SKLcPj1uYrd7dvFJA6UGdgYs+qh8o1Zxn3apweE5fQmZIkqVxsfRJGgsArA7tunfO4gTkWHMCUsWp36h85ly5zHjYBqsCOLcXm2Y1lTAA1W5ixSXvwAfde+pahh3LUs0KLP7T1gTGRk3qVBTqcS95vx3QL1Rni/lEzjH6gp8SLf0LV62NDm16WaIUXfAZesicxXTfV1ypfs62dl2KRx+pPm2NjoOGzqKHQnpFf06Kis5kjyG2bQzSbsWP2wQCHKIxmOo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa7be7d-899f-40e7-685a-08dd099e4406
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 20:02:30.8602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+EtmhO3mpsCHk5Um9Pf6jXsh1+pWoS8XHbrE/ad8RJJz5TwiHiyd0YccEziLdmLJkyCjWzqa8OhuSNqi1XX96Tk8YP4NNJwUd0cA/e7xdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-20_17,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411200140
X-Proofpoint-GUID: L67w1R5WkClqdY5sPzXSoqFsJpt79Cdh
X-Proofpoint-ORIG-GUID: L67w1R5WkClqdY5sPzXSoqFsJpt79Cdh

On Wed, Nov 20, 2024 at 02:50:00PM +0000, Alice Ryhl wrote:
> When setting up a new vma in an mmap call, you have a bunch of extra
> permissions that you normally don't have. This introduces a new
> VmAreaNew type that is used for this case.

Hm I'm confused by what you mean here. What permissions do you mean?

Is this to abstract a VMA as passed by f_op->mmap()? I think it would be
better to explicitly say this if so.

>
> To avoid setting invalid flag values, the methods for clearing
> VM_MAYWRITE and similar involve a check of VM_WRITE, and return an error
> if VM_WRITE is set. Trying to use `try_clear_maywrite` without checking
> the return value results in a compilation error because the `Result`
> type is marked #[must_use].

This is nice.

Though note that, it is explicitly not permitted to permit writability for
a VMA that previously had it disallowed, and we explicitly WARN_ON() this
now. Concretely that means a VMA where !(vma->vm_flags & VM_MAYWRITE), you
must not vma->vm_flags |= VM_MAYWRITE.

>
> For now, there's only a method for VM_MIXEDMAP and not VM_PFNMAP. When
> we add a VM_PFNMAP method, we will need some way to prevent you from
> setting both VM_MIXEDMAP and VM_PFNMAP on the same vma.

Yes this would be unwise.

An aside here - really you should _only_ change flags in this hook (perhaps
of course also initialising vma->vm_private_data state), trying to change
anything _core_ here would be deeply dangerous.

We are far too permissive with this right now, and it's something we want
to try ideally to limit in the future.

>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/mm/virt.rs | 169 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 168 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> index de7f2338810a..22aff8e77854 100644
> --- a/rust/kernel/mm/virt.rs
> +++ b/rust/kernel/mm/virt.rs
> @@ -6,7 +6,7 @@
>
>  use crate::{
>      bindings,
> -    error::{to_result, Result},
> +    error::{code::EINVAL, to_result, Result},
>      page::Page,
>      types::Opaque,
>  };
> @@ -148,6 +148,173 @@ pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result {
>      }
>  }
>
> +/// A builder for setting up a vma in an `mmap` call.

Would be better to explicitly reference the struct file_operations->mmap()
hook and to say that we should only be updating flags and vm_private_data
here (though perhaps not worth mentioning _that_ if not explicitly exposed
by your interface).

I'm guessing fields are, unless a setter/builder is established, immutable?

> +///
> +/// # Invariants
> +///
> +/// For the duration of 'a, the referenced vma must be undergoing initialization.
> +pub struct VmAreaNew {
> +    vma: VmAreaRef,
> +}
> +
> +// Make all `VmAreaRef` methods available on `VmAreaNew`.
> +impl Deref for VmAreaNew {
> +    type Target = VmAreaRef;
> +
> +    #[inline]
> +    fn deref(&self) -> &VmAreaRef {
> +        &self.vma
> +    }
> +}
> +
> +impl VmAreaNew {
> +    /// Access a virtual memory area given a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `vma` is undergoing initial vma setup for the duration of 'a.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
> +        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
> +        unsafe { &*vma.cast() }
> +    }
> +
> +    /// Internal method for updating the vma flags.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This must not be used to set the flags to an invalid value.
> +    #[inline]
> +    unsafe fn update_flags(&self, set: vm_flags_t, unset: vm_flags_t) {
> +        let mut flags = self.flags();
> +        flags |= set;
> +        flags &= !unset;
> +
> +        // SAFETY: This is not a data race: the vma is undergoing initial setup, so it's not yet
> +        // shared. Additionally, `VmAreaNew` is `!Sync`, so it cannot be used to write in parallel.
> +        // The caller promises that this does not set the flags to an invalid value.
> +        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags = flags };

Hm not sure if this is correct. We explicitly maintain a union in struct vm_area_struct as:

	union {
		const vm_flags_t vm_flags;
		vm_flags_t __private __vm_flags;
	};

Where vma->vm_flags is const, and then use helpers like vm_flags_init() to
set them, which also do things like assert locks (though not in the init
case, of course).

So erally we should at least be updating __vm_flags here, though I'm not
sure how bindgen treats it?

> +    }
> +
> +    /// Set the `VM_MIXEDMAP` flag on this vma.
> +    ///
> +    /// This enables the vma to contain both `struct page` and pure PFN pages. Returns a reference
> +    /// that can be used to call `vm_insert_page` on the vma.
> +    #[inline]
> +    pub fn set_mixedmap(&self) -> &VmAreaMixedMap {
> +        // SAFETY: We don't yet provide a way to set VM_PFNMAP, so this cannot put the flags in an
> +        // invalid state.
> +        unsafe { self.update_flags(flags::MIXEDMAP, 0) };
> +
> +        // SAFETY: We just set `VM_MIXEDMAP` on the vma.
> +        unsafe { VmAreaMixedMap::from_raw(self.vma.as_ptr()) }
> +    }
> +
> +    /// Set the `VM_IO` flag on this vma.
> +    ///
> +    /// This marks the vma as being a memory-mapped I/O region.
> +    #[inline]
> +    pub fn set_io(&self) {
> +        // SAFETY: Setting the VM_IO flag is always okay.
> +        unsafe { self.update_flags(flags::IO, 0) };
> +    }
> +
> +    /// Set the `VM_DONTEXPAND` flag on this vma.
> +    ///
> +    /// This prevents the vma from being expanded with `mremap()`.
> +    #[inline]
> +    pub fn set_dontexpand(&self) {
> +        // SAFETY: Setting the VM_DONTEXPAND flag is always okay.
> +        unsafe { self.update_flags(flags::DONTEXPAND, 0) };
> +    }
> +
> +    /// Set the `VM_DONTCOPY` flag on this vma.
> +    ///
> +    /// This prevents the vma from being copied on fork. This option is only permanent if `VM_IO`
> +    /// is set.
> +    #[inline]
> +    pub fn set_dontcopy(&self) {
> +        // SAFETY: Setting the VM_DONTCOPY flag is always okay.
> +        unsafe { self.update_flags(flags::DONTCOPY, 0) };
> +    }
> +
> +    /// Set the `VM_DONTDUMP` flag on this vma.
> +    ///
> +    /// This prevents the vma from being included in core dumps. This option is only permanent if
> +    /// `VM_IO` is set.
> +    #[inline]
> +    pub fn set_dontdump(&self) {
> +        // SAFETY: Setting the VM_DONTDUMP flag is always okay.
> +        unsafe { self.update_flags(flags::DONTDUMP, 0) };
> +    }
> +
> +    /// Returns whether `VM_READ` is set.
> +    ///
> +    /// This flag indicates whether userspace is mapping this vma as readable.
> +    #[inline]
> +    pub fn get_read(&self) -> bool {
> +        (self.flags() & flags::READ) != 0
> +    }
> +
> +    /// Try to clear the `VM_MAYREAD` flag, failing if `VM_READ` is set.
> +    ///
> +    /// This flag indicates whether userspace is allowed to make this vma readable with
> +    /// `mprotect()`.
> +    #[inline]
> +    pub fn try_clear_mayread(&self) -> Result {
> +        if self.get_read() {
> +            return Err(EINVAL);
> +        }

This is quite nice! Strong(er) typing for the win, again :>)

> +        // SAFETY: Clearing `VM_MAYREAD` is okay when `VM_READ` is not set.
> +        unsafe { self.update_flags(0, flags::MAYREAD) };
> +        Ok(())
> +    }
> +
> +    /// Returns whether `VM_WRITE` is set.
> +    ///
> +    /// This flag indicates whether userspace is mapping this vma as writable.
> +    #[inline]
> +    pub fn get_write(&self) -> bool {
> +        (self.flags() & flags::WRITE) != 0
> +    }
> +
> +    /// Try to clear the `VM_MAYWRITE` flag, failing if `VM_WRITE` is set.
> +    ///
> +    /// This flag indicates whether userspace is allowed to make this vma writable with
> +    /// `mprotect()`.
> +    #[inline]
> +    pub fn try_clear_maywrite(&self) -> Result {
> +        if self.get_write() {
> +            return Err(EINVAL);
> +        }
> +        // SAFETY: Clearing `VM_MAYWRITE` is okay when `VM_WRITE` is not set.
> +        unsafe { self.update_flags(0, flags::MAYWRITE) };
> +        Ok(())
> +    }
> +
> +    /// Returns whether `VM_EXEC` is set.
> +    ///
> +    /// This flag indicates whether userspace is mapping this vma as executable.
> +    #[inline]
> +    pub fn get_exec(&self) -> bool {
> +        (self.flags() & flags::EXEC) != 0
> +    }
> +
> +    /// Try to clear the `VM_MAYEXEC` flag, failing if `VM_EXEC` is set.
> +    ///
> +    /// This flag indicates whether userspace is allowed to make this vma executable with
> +    /// `mprotect()`.
> +    #[inline]
> +    pub fn try_clear_mayexec(&self) -> Result {
> +        if self.get_exec() {
> +            return Err(EINVAL);
> +        }
> +        // SAFETY: Clearing `VM_MAYEXEC` is okay when `VM_EXEC` is not set.
> +        unsafe { self.update_flags(0, flags::MAYEXEC) };
> +        Ok(())
> +    }
> +}
> +
>  /// The integer type used for vma flags.
>  #[doc(inline)]
>  pub use bindings::vm_flags_t;
>
> --
> 2.47.0.371.ga323438b13-goog
>

