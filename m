Return-Path: <linux-kernel+bounces-353582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61228992FBE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B45CEB223F0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CED81D5ADE;
	Mon,  7 Oct 2024 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KEtWZswo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NQz8Q4RE"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BDB18F2C3
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312482; cv=fail; b=qFEZQYzu6FiKEuYzVjK0T2lbpTCTTO+gcouEnhGrOb8YP2XGXCwWQzIWAt9tuaj5QX6rfgUDFpPfAMa9qBILpwiWf/fAkypjwjKHxDVvHsqepH7fzKZu1B+VABGzXY0RCLw2kLOYNz4WiQfSikdbNoYUzF2OQv0qbMIGaa4OMXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312482; c=relaxed/simple;
	bh=OqO/7k8rlByGrNn75bO5x5Uo3MgX2h1es+WqSIXjvuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LhfcS/Fts6xDLzwVjisvq6/IosSy8QoCdddv85fp283nkBMg9jTMmM6d01EDaRziFfv9Zv0NAD+j/YkpR0J6HM/KYEz06OHmknPXYfpLWqf2lPKQjP7HnER2VuIYOPnN33OdLrjC+9mu91PQqPIsGVHA/wr2xGF04LoPtTFwR6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KEtWZswo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NQz8Q4RE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497CD4oU012405;
	Mon, 7 Oct 2024 14:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=8QRa82jR7lqlTkSWKE
	y4EHY+0Dvte7I5Ptf2bzFEeA8=; b=KEtWZswor5sqJ8Z04yIxOU9XhPlJsgQhSw
	vellohdFHbaOlyIKNNdJSQpciHh31QEE+aSzP5f9ATzt6GqGdbVJmwGW9N5Qd5qJ
	uGTSasmbS4loNcHQVgPbDtd8WtU9wxPhJBfrrvAoa+24EJBdt1kkC3UFaaHJBxPr
	JA2CsU3UL27ZH/NhRgdGNti5rbTjdSwokNGQThK8Ez66juX+988m4VGoxmQlXBWo
	pUKVSnFI99m2vxWNonBaVaHXUOQj7uePE1DCj/C/wh8LWhRuygkVHxDit6ikY+Ud
	OlTKUiPHqUmVo34yfrzF1NvsN1cQGUThki2dCFQr3SWDn2ztHyQQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303ybk2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 14:47:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497Dl6Et004738;
	Mon, 7 Oct 2024 14:47:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uw5wb9m-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 14:47:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zN5PPwBY4R8ua80+Pe8bgh2XeEEvVln0G0czOeXla/Rmg5YHpVjFfzHcY2e1hCBshfUMym3XFWWt58Oe+xCt37c0DInRWEiHT9uxBatV7fBflUSuMqEuSBN02Fxw3hNW/vY5z9nQ+MpmM98++mJTXhDFna2/YakuaOkgHZrLL1hcOavMHGGinzAN5QAgH24NnbymVw+VhebUG6fDAXpfiBr/JF4dmVpriwDgcbKkBng378YW0PEhv76ZAh3CfHzIYAU1Onhrfgw41m6taMlG9GNKrH7G3nunrmA62bv/ad8+Vs6XHz72Tc7w7dcrRCl5unhH2lzi0ZTObPRHeLg+tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QRa82jR7lqlTkSWKEy4EHY+0Dvte7I5Ptf2bzFEeA8=;
 b=NqlP1K93d8K9hric6g7WTxSE2Cjh8V2nVGL+Fe5XE8czBINSl6pBmATFn6cCHeiz46CIuVvesVcqoNamalzZQfmCmkXNwejS/fE0INQ+s+kFdauHofZPuylcad9zV8t/uwjCcrQQG+uyOPbKC6a0EixKJ78sOok/UwoYKgUIH/4utaAD5nSfcUtpL78JeeVV8RKnjfINPVpBnIg8hhqbKaMT2CRc0BRENF0lCNdD7SaoeCuwt/Ko0HYNqnFvTe7sbJdFInIkQBa2M9SL5aSdLGExfrUfiYBv+BMTx99eYo9ls0e9Zs6CpNmGdKSBHxSO2bUyVaJ9v56bNWYiqvnyMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QRa82jR7lqlTkSWKEy4EHY+0Dvte7I5Ptf2bzFEeA8=;
 b=NQz8Q4REcCHqNrzRGOEdvOMY2PZ4JkVCy5SvZ3WZbRTqJPqQ2TJA0rqEtlcjwhGgiYKnzOtvU+u+ZuNYnXVQbeG12s8StSkITlc3bPAN2VGktFACaDHYmBDHuHqIGl98cau/G60YMtizWHEp155hzH1lS6n3wRJPnuZD3frvc/w=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6578.namprd10.prod.outlook.com (2603:10b6:510:205::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 14:47:06 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 14:47:06 +0000
Date: Mon, 7 Oct 2024 10:47:04 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Bert Karwatzki <spasswolf@web.de>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH v2  hotfix 6.12 1/2] maple_tree: correct tree corruption
 on spanning store
Message-ID: <eydfju7fth4hxyucwz5ani4qyrajfgzkjj3voiszam6d7tu3w4@hsef4adjoodq>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>, 
	Bert Karwatzki <spasswolf@web.de>, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	maple-tree@lists.infradead.org
References: <cover.1728223996.git.lorenzo.stoakes@oracle.com>
 <964860c315780cf3a5b8929a34b68d8208333c16.1728223996.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <964860c315780cf3a5b8929a34b68d8208333c16.1728223996.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0247.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: 11094657-2e0a-4aef-4da6-08dce6dee9ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k6Xvr3xzdzoKxEHISIuHf6uaGAUkzlfWc9K4U5Mv6KLjf6xXUmBegw2Xh/gq?=
 =?us-ascii?Q?SxRRPlq7cOVqJV01C9KoBfe0QS7kFEY5/5geh6E5RZgOolwWL/LqKEWS2T/S?=
 =?us-ascii?Q?RD3qlSWPSo7J2RxFOw8+1/6+Bo6bm8Voj4lVIVMnHmQQLjBTy5KFeofu2L/8?=
 =?us-ascii?Q?FJ3W7hcSRBzKzwJHLOMNhPMwgBFCiM9w8Irp+oQCawpviJpu729rF2DXUNim?=
 =?us-ascii?Q?mWrYJ7xsduSFY1QXHwuwykUP9+TQ57/7adrebO1V0bpOU+BRsTWvoyAcTW7/?=
 =?us-ascii?Q?ZEh7luOd4i9Lzs7p/QZW3ANlQWFi/QySBLkMuUB/poUmgBzozuiypa4HNfUT?=
 =?us-ascii?Q?QiuBKu4OFBDZIOwZfgimQ/iY9mnuEiJJb2IkLRDHnzuBaMG7VmgwGes/aatq?=
 =?us-ascii?Q?FJMAfaSWD2ssQisxHzSTt7yXpHNvH2cxotiDInla+jhUp4FIdAlSltxZILlz?=
 =?us-ascii?Q?Jsrw5dDn/rWNHY7GE+Ut/YHux02bZaWRikyaLzAEeItrguj7WFXMYODCoFB6?=
 =?us-ascii?Q?uiIyjFb0GZOReiASrGVbtWgBKUDcwVxyJIxzcB7Carv2xBPdVJl7clhNfoU7?=
 =?us-ascii?Q?Fn39kxnLOO7F3cT6us9XT5PNPj17a/yF6F32ciC6L92+68tQRwa4C9d9zvSe?=
 =?us-ascii?Q?ibnP361c/HsTmOihK3ES702+vabHfEJA4K+jTYT/Y5HwQ5Jf4OMD4la5h5ZB?=
 =?us-ascii?Q?m6UHugDTdgY6Ogbb1o6wD44mtwS1/GV83kTizIQxDjwCx59tseqd6iUzQmC1?=
 =?us-ascii?Q?SCXLHE7A7QvZsC8oLac58dmCANOO6JwU2jTa7MKO7YgR8V1HeDlQ43FAlaM8?=
 =?us-ascii?Q?RCUJd+G2ETj1FcQYcOIkueLAeF3YEjaEV8Ii1AiXK1pGuQsMN9E3zrTsoI8R?=
 =?us-ascii?Q?rU/x7dKZL/5wHlXs4t1MuY6dn1wZoVvbxPfZChcrbLzcH8daVtBuicM/8/zd?=
 =?us-ascii?Q?4723EveDoQKJo/p9e06qhpw5mdJPPoNbw30sIdGtA6tNWY+ez/OMgI4qAd2D?=
 =?us-ascii?Q?8/XYW5z/qhRzegVbQFuXlS1NzDqeDd5dWvqzF1s1UvWbbEYMQV9h883x/fgc?=
 =?us-ascii?Q?tndp4SJMstkgj8Qz7EChqaoUTxl3nuCYsAYWPoniPAEzYpxaluRykr8p58uo?=
 =?us-ascii?Q?7oz829g19pI7HpLZG4BTtSy+nanC0SAKBc0IjbgEFuVJkugSTY7+luYh4sak?=
 =?us-ascii?Q?q1pD81RWbIZwUqO99E4yt7wuP7qN/bH0BwrHAZYj96LQ/qa3VUYGmKIs+m0?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jYUAwcX7veX4Cf/V9ZNnnjJ6WquOhqBPmsqNCnMvqu+A7yzl3AKEis2QzSks?=
 =?us-ascii?Q?jF8yjYSz+ZFASjjrmdHp/xChTDwryrbpPZ/Su0U+PmUINwOBiWjIQ04o9UOs?=
 =?us-ascii?Q?IeYMgnw8Qdcw8Wxye2z0VWt8k7Za5gPyyhlL6Qly8hrgFTbLiy8WjXAgF1Fn?=
 =?us-ascii?Q?iDamSXPEOQJv5LdOKvXwPT1+K2gZmau7Z/1n9+Nui9CMVYFK08vP+pHqkisb?=
 =?us-ascii?Q?XlYTdMHxqbkmFyTvNZqxUWvZinf10Y7U6REYWMN650+pgT9zvYZqr/zaDPzh?=
 =?us-ascii?Q?RdO2EnpvNJUWR+3ME7AewhFqiwbP2Sw43xKjGz2X+EzrNRGQ7Ko+dV2Seo60?=
 =?us-ascii?Q?CgkeOzWM7yassNX8TdfXuQjly8Rp3LEh7hvKO0wlaJve1oNGFEk1jfuZO5uL?=
 =?us-ascii?Q?Jpe0AgSGVeMnE0CdTlKjgClUzd/TdarqlXxDUKy851vXIO6qwavM9qPT2XLo?=
 =?us-ascii?Q?S2S17fvIK20z+b1H386TM1LynL/yq2q7RIiFfyV9CYYGCvv2kotiEunOc4PS?=
 =?us-ascii?Q?PFhiWOlcLIvCR6Rq+GEtetOBE1K0TSe3MRfDw7qOG5ApPfvsQrSI6hdgsynI?=
 =?us-ascii?Q?aqOcmgQukCKrNWjuvleZCbc2r1SV5rxQXnZsn2lmoYVVISbI2TuSsgSCbxrT?=
 =?us-ascii?Q?2KPZcao5sDKu1eyWOvu3ehSSMADm5wpAgMmSjEYBr4k0+kq5oF9AbcdIBq8o?=
 =?us-ascii?Q?c/5gDInCG4xIPuIIQwzAyjsQrbp1/+HzeEsk8ZJz7IQmyufOOjEWsS9MU0uV?=
 =?us-ascii?Q?5Zr2aJB9EpmhlFD9/oKvbv29u3aWGQe4NooaNmeN4l5joHn07tPMLn8SjQII?=
 =?us-ascii?Q?3RMwM2Ad4CTrh6t69kqbi3ZTFSunVlnYfbHxSGBf0OFqtEbzjW3zNk8/hDMd?=
 =?us-ascii?Q?aeVXPYsMAkkmmA0ISOX19MpLDrOXpfQ5m+ab1frA4LrghKcS14ybMU5EFwDO?=
 =?us-ascii?Q?BU/pxUAPhBOS1i01uEiGrRxoPIoYNaZlE/V0MGuWSONsSO7xPAZr6dcRXr8Q?=
 =?us-ascii?Q?Cd0nb7Lo+WjF/Ml4StbLh6TBBOvGWkyHP4gZXH/VBY7nijaIjhiZ7ASKp/rH?=
 =?us-ascii?Q?LOwQU20SU/J3K39sZ3Ku2BtQJONURqU/EgsA/Li9S3TF95s9jOMahyF51/ox?=
 =?us-ascii?Q?j0++IAqr4talpUuLSgM2p6EA6FISIcgiH4ulnLno4AX9XCWvJODxO+4VE7K7?=
 =?us-ascii?Q?gw/b66jUmZxVuIzzRR8aMzrFl9GlxxmYmcnOZO7pFKPpm4JwvLJ+oZhNi6Wn?=
 =?us-ascii?Q?s7LjSgRwfLnml6DvE6YafOK8y3CuzBrJU99xW2iVcvkdLC41cMyYII2LwnJa?=
 =?us-ascii?Q?6xXV8JGnSy3n7FkreFOAoCrxgT2CzjADMsDcHxaaPdz1TxcySex1M1XjXaNA?=
 =?us-ascii?Q?cbPryp7/uVd6ae/vDpI/OjrcBklhf/nPBG9ukoh+sBOtTRza3wH7PVW3A7wn?=
 =?us-ascii?Q?38py7ykFpMFM+rzczLYd7Bjf8rFmDAsnNOYn8kVDrJ+bsSoESb8RsibcGhbs?=
 =?us-ascii?Q?Mx4luRTmodPq0uw5phuDEFPSttsejdZMbZMp9IrcLUy8ojKXv9mEkO/uFZQT?=
 =?us-ascii?Q?X73dxq7k1X8UvmV3UazzFWqIy2QDlkd97A+XBacu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FPcl7dvw7gqbGu2qUnKQEprwrX3ufSTW1IULr/mMTAfGDRvJ0QWg70wWzZmXRaOG7bGRV5Y3FFHjUMalpMEITlgJwznvaFYV6qf0X1NZRJI9O08uxb5zt8zCq6x2tIgr8iblRVWjHlEAFC7m75KIiq6UFUvtI2/pwLjapYFYILTiA1/JTccBWXPHgjQABorw5uSFOaeO6FKsWKdB6JS/2K59h+BxqMNxdVNxrmxudsAQyQMTet5wBaZl7GPaAOJUG15bHEKxL+oTCd+9jeQDzOtgLLFn/GInfBSkos3c/mcYQ/EKl1vQ0C2wlbHQI3XT4KTTCauowHBgLGj/H2B8W21TNWnjd7l7x0/DZ2GfDuSwZuj+3FHb/HTyylPBndX4bCavyw7Yywxbru8RYnWaqDAX1EsTyYsdGPBqz+QiI66bw57eIWDYUbe4dEssjvvlSUwkapxzS6KCt3NMavTJ2l4dSgJGx+tOli8D7NjhXnZkm/Vq9RDy5PUMqbIEJLs/CsOD1muGNuSGhe1dyXVEQDUFHFrgucvFppSaXYTN07QAJ7fC76xyGv/wzLSioz+4xKuRRISlkfENp+dFqkudo7a7Ha7t9MxyMuUjXsXRouc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11094657-2e0a-4aef-4da6-08dce6dee9ec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 14:47:06.3675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbfUToCB/DkKg/IH8gtRzBdfZrEFs/XWf4G5iJ4YHqt1C8MWexGjBlP7wRlX1Ts+WuWJHFTuxV6gggKQSzU9Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6578
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_06,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070104
X-Proofpoint-ORIG-GUID: bPe0pkbk181H3CmxJkpIAyatMDToAXdJ
X-Proofpoint-GUID: bPe0pkbk181H3CmxJkpIAyatMDToAXdJ

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241006 10:31]:
> There has been a subtle bug present in the maple tree implementation from
> its inception.
> 
> This arises from how stores are performed - when a store occurs, it will
> overwrite overlapping ranges and adjust the tree as necessary to
> accommodate this.
> 
> A range may always ultimately span two leaf nodes. In this instance we walk
> the two leaf nodes, determine which elements are not overwritten to the
> left and to the right of the start and end of the ranges respectively and
> then rebalance the tree to contain these entries and the newly inserted
> one.
> 
> This kind of store is dubbed a 'spanning store' and is implemented by
> mas_wr_spanning_store().
> 
> In order to reach this stage, mas_store_gfp() invokes mas_wr_preallocate(),
> mas_wr_store_type() and mas_wr_walk() in turn to walk the tree and update
> the object (mas) to traverse to the location where the write should be
> performed, determining its store type.
> 
> When a spanning store is required, this function returns false stopping at
> the parent node which contains the target range, and mas_wr_store_type()
> marks the mas->store_type as wr_spanning_store to denote this fact.
> 
> When we go to perform the store in mas_wr_spanning_store(), we first
> determine the elements AFTER the END of the range we wish to store (that
> is, to the right of the entry to be inserted) - we do this by walking to
> the NEXT pivot in the tree (i.e. r_mas.last + 1), starting at the node we
> have just determined contains the range over which we intend to write.
> 
> We then turn our attention to the entries to the left of the entry we are
> inserting, whose state is represented by l_mas, and copy these into a 'big
> node', which is a special node which contains enough slots to contain two
> leaf node's worth of data.
> 
> We then copy the entry we wish to store immediately after this - the copy
> and the insertion of the new entry is performed by mas_store_b_node().
> 
> After this we copy the elements to the right of the end of the range which
> we are inserting, if we have not exceeded the length of the node
> (i.e. r_mas.offset <= r_mas.end).
> 
> Herein lies the bug - under very specific circumstances, this logic can
> break and corrupt the maple tree.
> 
> Consider the following tree:
> 
> Height
>   0                             Root Node
>                                  /      \
>                  pivot = 0xffff /        \ pivot = ULONG_MAX
>                                /          \
>   1                       A [-----]       ...
>                              /   \
>              pivot = 0x4fff /     \ pivot = 0xffff
>                            /       \
>   2 (LEAVES)          B [-----]  [-----] C
>                                       ^--- Last pivot 0xffff.
> 
> Now imagine we wish to store an entry in the range [0x4000, 0xffff] (note
> that all ranges expressed in maple tree code are inclusive):
> 
> 1. mas_store_gfp() descends the tree, finds node A at <=0xffff, then
>    determines that this is a spanning store across nodes B and C. The mas
>    state is set such that the current node from which we traverse further
>    is node A.
> 
> 2. In mas_wr_spanning_store() we try to find elements to the right of pivot
>    0xffff by searching for an index of 0x10000:
> 
>     - mas_wr_walk_index() invokes mas_wr_walk_descend() and
>       mas_wr_node_walk() in turn.
> 
>         - mas_wr_node_walk() loops over entries in node A until EITHER it
>           finds an entry whose pivot equals or exceeds 0x10000 OR it
>           reaches the final entry.
> 
>         - Since no entry has a pivot equal to or exceeding 0x10000, pivot
>           0xffff is selected, leading to node C.
> 
>     - mas_wr_walk_traverse() resets the mas state to traverse node C. We
>       loop around and invoke mas_wr_walk_descend() and mas_wr_node_walk()
>       in turn once again.
> 
>          - Again, we reach the last entry in node C, which has a pivot of
>            0xffff.
> 
> 3. We then copy the elements to the left of 0x4000 in node B to the big
>    node via mas_store_b_node(), and insert the new [0x4000, 0xffff] entry
>    too.
> 
> 4. We determine whether we have any entries to copy from the right of the
>    end of the range via - and with r_mas set up at the entry at pivot
>    0xffff, r_mas.offset <= r_mas.end, and then we DUPLICATE the entry at
>    pivot 0xffff.
> 
> 5. BUG! The maple tree is corrupted with a duplicate entry.
> 
> This requires a very specific set of circumstances - we must be spanning
> the last element in a leaf node, which is the last element in the parent
> node.
> 
> spanning store across two leaf nodes with a range that ends at that shared
> pivot.
> 
> A potential solution to this problem would simply be to reset the walk each
> time we traverse r_mas, however given the rarity of this situation it seems
> that would be rather inefficient.
> 
> Instead, this patch detects if the right hand node is populated, i.e. has
> anything we need to copy. We can do this easily in mas_wr_walk_index() by
> detecting if the pivot is either 0 (shorthand for the end of the range) or
> the required index is less than or equal to the last encountered pivot.
> 
> This change is made in mas_wr_walk_index() which is only used by the
> spanning store so it has minimal impact.
> 
> The work performed in commit f8d112a4e657 ("mm/mmap: avoid zeroing vma tree
> in mmap_region()") seems to have made the probability of this event much
> more likely, which is the point at which reports started to be submitted
> concerning this bug.
> 
> The motivation for this change arose from Bert Karwatzki's report of
> encountering mm instability after the release of kernel v6.12-rc1 which,
> after the use of CONFIG_DEBUG_VM_MAPLE_TREE and similar configuration
> options, was identified as maple tree corruption.
> 
> After Bert very generously provided his time and ability to reproduce this
> event consistently, I was able to finally identify that the issue discussed
> in this commit message was occurring for him.
> 
> Reported-and-tested-by: Bert Karwatzki <spasswolf@web.de>
> Closes: https://lore.kernel.org/all/20241001023402.3374-1-spasswolf@web.de/
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Closes: https://lore.kernel.org/all/CABXGCsOPwuoNOqSMmAvWO2Fz4TEmPnjFj-b7iF+XFRu1h7-+Dg@mail.gmail.com/
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  lib/maple_tree.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 20990ecba2dd..f72e1a5a4dfa 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -2196,6 +2196,8 @@ static inline void mas_node_or_none(struct ma_state *mas,
> 
>  /*
>   * mas_wr_node_walk() - Find the correct offset for the index in the @mas.
> + *                      If @mas->index cannot be found within the containing
> + *                      node, we traverse to the last entry in the node.
>   * @wr_mas: The maple write state
>   *
>   * Uses mas_slot_locked() and does not need to worry about dead nodes.
> @@ -3532,6 +3534,12 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
>  	return true;
>  }
> 
> +/*
> + * Traverse the maple tree until the offset of mas->index is reached.
> + *
> + * Return: Is this node actually populated with entries possessing pivots equal
> + *         to or greater than mas->index?
> + */
>  static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)

Oh good, I'm returning a bool that was never used.

>  {
>  	struct ma_state *mas = wr_mas->mas;
> @@ -3540,8 +3548,11 @@ static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
>  		mas_wr_walk_descend(wr_mas);
>  		wr_mas->content = mas_slot_locked(mas, wr_mas->slots,
>  						  mas->offset);
> -		if (ma_is_leaf(wr_mas->type))
> -			return true;
> +		if (ma_is_leaf(wr_mas->type)) {
> +			unsigned long pivot = wr_mas->pivots[mas->offset];

If mas->offset points to the last slot, then this will be outside the
pivot array.  That is, there is an implied max pivot from the parent
which may not have a pivot entry.

> +
> +			return pivot == 0 || mas->index <= pivot;

What is the pivot == 0 portion of this?  The pivot should always have a
value, unless it's the first pivot in the tree of range 0-0, but then
there will always be more content to copy.

> +		}
>  		mas_wr_walk_traverse(wr_mas);
> 
>  	}
> @@ -3701,6 +3712,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
>  	struct maple_big_node b_node;
>  	struct ma_state *mas;
>  	unsigned char height;
> +	bool r_populated;
> 
>  	/* Left and Right side of spanning store */
>  	MA_STATE(l_mas, NULL, 0, 0);
> @@ -3742,7 +3754,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
>  		r_mas.last++;
> 
>  	r_mas.index = r_mas.last;
> -	mas_wr_walk_index(&r_wr_mas);
> +	r_populated = mas_wr_walk_index(&r_wr_mas);
>  	r_mas.last = r_mas.index = mas->last;
> 
>  	/* Set up left side. */
> @@ -3766,7 +3778,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
>  	/* Copy l_mas and store the value in b_node. */
>  	mas_store_b_node(&l_wr_mas, &b_node, l_mas.end);
>  	/* Copy r_mas into b_node. */
> -	if (r_mas.offset <= r_mas.end)
> +	if (r_populated && r_mas.offset <= r_mas.end)
>  		mas_mab_cp(&r_mas, r_mas.offset, r_mas.end,
>  			   &b_node, b_node.b_end + 1);

We may be able to leverage the information contained in r_mas and
r_wr_mas to determine when contents needs to be copied.

Perhaps r_mas.max > r_mas.last instead?  Where r_mas.max is the node
max and r_mas.last is the end of the range being written.

>  	else
> --
> 2.46.2

