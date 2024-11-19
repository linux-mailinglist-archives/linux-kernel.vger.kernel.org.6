Return-Path: <linux-kernel+bounces-413955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 507F09D20F4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1182824BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECC0155743;
	Tue, 19 Nov 2024 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oHAdNjBO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FxbAfmAM"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B5317E0;
	Tue, 19 Nov 2024 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732002568; cv=fail; b=FE7M0Hiue1iXmkCTgJHCXf4VbDwWtIsCKTeBkoqzgt5EFVUrV58Rfj/EzAaa2jsJXPBFa1R9X3hRhl07uBaan6Dvj2J0U0r4ZGiZ37fNUmlcbaq+M4skMVXW7OKEHXqkVnFLBC8qbGj7nxchRKmWi+rpSqWVJkZw3WWDILC/Ow0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732002568; c=relaxed/simple;
	bh=ub/XTzWe/5MifuSQ5ngdx9fuXyWNuzexQhgGlYfX0C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l3ACEe/pTXW4g8Jun3AAhx/+J9nkSPsduUob9iDGw1/FsZd4fJKTZqv98MNJi96GyUMf18vNSv9eCOzUffoO8sykGxVJR7F6vwH/3XwLv8b5giW43BeqJJT5d3Lx5Y5GJA+p65xPwoxDevhwAGQ9IcZtrGn5un64XGhWSxj7Vzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oHAdNjBO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FxbAfmAM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ7fvgo028589;
	Tue, 19 Nov 2024 07:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=CaqqWmdVxKg7WtDfyn
	fVPRVp+ko55te/B0usUUNc7LI=; b=oHAdNjBOMX6Podjrg28T7U0xIkCjPFFhfI
	s2TCWLKhSi01qA1ntSDqS//Xej3SEYnyHCLUY+FMO1g93wJjsVxUkA0NRim+eOvl
	Qj2MPJW5NuLLCFPWN5k2RRtAsgBwaRzzgulpnN90QKi2hY6YxiCOFR4I2qdV3wkl
	ycPuOLUV8Uoma2csodaip5vC3i060QHpwlm/JAeoERiOWc9preWqMkQT63QRG8bS
	W1RJt7NNW4hbFEaRSm1p03idEbjHSUN0hJQLc6n6ruKx46Bh0osnnzqUMxL72XDH
	dbm+OmUHMIGOlIIT+qpzOsIBHxAg/CvuZIbDZjJ3UvJhRj+Zr/1w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ynyr2tck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 07:48:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ6sCA2008655;
	Tue, 19 Nov 2024 07:48:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu85t2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 07:48:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWtgU+m/6yu0pq03ztzMe7WvukASBSlOP+40bzimHPVOi+mOsjme97KSpa3BEY/WBdWAlPsC1sjWi8k7cKzKYyUt1GxP1iZR/8sHv+uFirF3/9/jt+xcsmlICbweM9gjo+P8tbSk18dXEB9aozKhmvHCTXM1LZPrAtUd45IaTOx6hX1TA35io8Lq332xaAmlN9WAkcAnivsCAPKnOKIriLUzQGWrfdV8xSEQMmqFi/gKgVGtg1ZCmBqwoTPyvfyQ3Zy0IjDegszTx8ExXAFFSJTtM4hYePyO5uJQzU/J6k5OlffkcS4eBnU7jIj3fWNIRh90c45CTayKe9PTML+fOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaqqWmdVxKg7WtDfynfVPRVp+ko55te/B0usUUNc7LI=;
 b=CS3v6p0Js/x6up4ekdl4BbP0yg/Za9eWdunOhjCJpKiB50dzwUy4OcMgbkmKQZ34wVOyIL/pSauW0Isr8u0lf+NG3snSXlIJjnkApSfm5k36EWElhSjvo7sqGCN4sQrVJOhf3VO6qn29u5i98kMuY7puoyHwhYc1jGtpEa9zEZwrl2/Jc0sOiK+YYT4RZ2CkbkJs6BQxJTKNlLM39ETbOJuijUcFQ4g9ng48oN/ChurMTj+YYrmcUN5IpjLF2GsXsy4UTlab+JtGxvVlKu7G5PlL9wUhelFhJKG/TVKB1BiRidZKI2wr0TojixVl0BFN8TVUH3rzrjpwYiSKzD9+bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaqqWmdVxKg7WtDfynfVPRVp+ko55te/B0usUUNc7LI=;
 b=FxbAfmAMkTOnfCHewaZP83GAZKSUgA/OxiLc5VJACcZ0GpG6ddxrZT/kMXr9HKc0RcwdXCqstYhfbXRfmKwlHwmL1WNl3nyMg/8mdS+ERPpWRnZI8uinN/63hfUDzVcZbiqcGSBdupVV69D1Q+zF36HIWB0+ItSa4X5hLDw4Y+8=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB8030.namprd10.prod.outlook.com (2603:10b6:8:1f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 07:48:49 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 07:48:49 +0000
Date: Tue, 19 Nov 2024 07:48:42 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Alice Ryhl <aliceryhl@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Hillf Danton <hdanton@sina.com>, SeongJae Park <sj@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matteo Rizzo <matteorizzo@google.com>
Subject: Re: [PATCH v2] docs/mm: add more warnings around page table access
Message-ID: <b915ff26-e90d-4151-ab2f-607f3c59f501@lucifer.local>
References: <20241118-vma-docs-addition1-onv3-v2-1-c9d5395b72ee@google.com>
 <21195425-53d9-4007-a020-8106f94158dc@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21195425-53d9-4007-a020-8106f94158dc@bytedance.com>
X-ClientProxiedBy: LO4P265CA0286.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: f1614707-5b51-4407-40cb-08dd086e9ab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K4IiB8IxONxB0fHvxrUqKYXPnyD/awT4B74k5SH4yboQgC7sqZ6gRL8ioc4R?=
 =?us-ascii?Q?oZGzbNuBJVRaorEz6fZgD1c0KaI5NAzsQt83cSeJk7rjIOrD4rFoYzR6A9he?=
 =?us-ascii?Q?9jEJbzs1LpCaz5F0wvSOxabrVdpyM3N4vPsHVb4l45IOA71YwTfS0YrjboMg?=
 =?us-ascii?Q?OP1POOhiUaUIyuOhhulyMzyCsifaySIvdMCjQCOgCHD8bme4PRhg6nukOYw8?=
 =?us-ascii?Q?CAEdOh2pa6X8OBt+ntInfmWp/mdvKstGZmlAg+9PVgZbSo8jb7ANY2pfXSv9?=
 =?us-ascii?Q?5yesxpynWL2mQCaTD4cBOmBXesvwYDrMTexOjlm86XJmuxuD/H/22aozFU44?=
 =?us-ascii?Q?vpnWIazT7m2d0QrnQymCZpvveCM+QSlSy9upa5UMfs5VWIxd6KzxJJT8Gyq7?=
 =?us-ascii?Q?HYZERlAdME9TTHkvOxzDxpIcqZLubmY3ok//4Fv7fb/hFj/1+TZfsV3+yQ7X?=
 =?us-ascii?Q?14wL9QjL0nV9jox2FUhg7orFzmmvXZYMKHOn1SK31jC39PXYCCtfawPPiAXS?=
 =?us-ascii?Q?dR9q7GLowBnwRVGzqxluEFXeQvD08UvlnfyBGgdy5HxOQPc6TnwvVGinVJqF?=
 =?us-ascii?Q?QTomUgGNkO3D2GH03cUMdnA/a1wrViPpLrbmRJqOs4DeOI2mmYhvNTP300oo?=
 =?us-ascii?Q?onvWhfb3qT8Cy/oHU44Il33TXofv4mLl9boKj8GqxhWsJN6qLrHQGke3nsBt?=
 =?us-ascii?Q?SJpjcyH8s8RFOKJX9dYtxMcEcVoJa8AyfSpnw4vq2YjvdjUUdz08wS7OmYBy?=
 =?us-ascii?Q?sOWWe8SlnvlC5ymxFh3smCTPqDH2Tqki9ZICeYa+02xtyiglrBiYY9EaqB05?=
 =?us-ascii?Q?YQ8vBZRBVaZMCW/r0arIcm0spqZvWJm1+NDZY2wI8FQgzzCD+5n5XR5NzMBN?=
 =?us-ascii?Q?1Qfmxs9EnPbGiwvKNwgvgNEGrgW4ESZy42a2KZd14uSq0Od+fCVaOG4w9t3H?=
 =?us-ascii?Q?Y3m3KbUGtm/5JTrAdzdVdKQveaodGyCpprO+CkJYjMwC3wPku6CmdeEqmwo1?=
 =?us-ascii?Q?V2s+sUjDuyt9kbB7428DAJzObc7zaLmLt4jMhL9eblVoBS5afUySSSqnJez/?=
 =?us-ascii?Q?QxC/v9OHuWCGIX/R/N87nsTN9rdluYASg65y+GPiWwY7KO4hXJJVXDqa3vUi?=
 =?us-ascii?Q?9OZGM8qimrncOQQZD0C5qst8a9NO9v7so3SxH/TsaWMfJL7xYE+DCPtyVwCk?=
 =?us-ascii?Q?B2DHsnRyh1z47BVvCqeEncIxefbAg5uFiknbPd1/Q7Gxllt8WKp6sfkVIZa3?=
 =?us-ascii?Q?pTjYDorlyA/iomKDXqfRytWVojPJGMG/O41B824y+zegNxnDm/bjTsEpdw75?=
 =?us-ascii?Q?lMW4LKkYGfKbNx3w8CJ/55z+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nwqx0ebAKdsf2hdFO1ql4SgIVTdk5MrOBfHLLlWCe2MC6mB0LgfFI5VupP3N?=
 =?us-ascii?Q?1NonJsiIp6DOtmXqfXQPNEYCBCkXAktsG6bnXjPh384HjeMJYjWj3rdqyoAc?=
 =?us-ascii?Q?N5f5lk5TqENT+OH9VONOIhfZwo7/jfoHB+Suw5u+l5vPLM3G8QRWIWWaasXY?=
 =?us-ascii?Q?aM8iL4+v8tSCBSdGd+1aP5taymF2OlxhAT3hPlc9T0XB88BGwbcL4ui2fFHw?=
 =?us-ascii?Q?X2iP6vEGc+GeXExcmpHxAh9oX6HDi9a0ru7XFvtDjzBu/cRcEBO9e7ErTeIU?=
 =?us-ascii?Q?xeIKovHh9ofP/McRsMuQI18NnO3biRYTJbcaw7MDd4f3uAGhoX6+oBCwhsIN?=
 =?us-ascii?Q?mh2n1w9z1+1TZ9JgFU7KYRro4bl4PUiEQ+iAud0n9JfJptFeruIpyVYGzQI6?=
 =?us-ascii?Q?9iEqYoLHwHfmRKOvXfyfVnVTWweijc66ka1sKbayzkGOmAZuK1qOvdRX42gy?=
 =?us-ascii?Q?p6+nZ+/enOhKu5ROPJISFi8dVec36ZiP37rJxCLKTGYky3S543ytoXSq7zcd?=
 =?us-ascii?Q?2u/mzb8/Bqmoqmq47BcUAVYMp7shU69GeN86ZxgR0Z3BiYqaJnETCosggudN?=
 =?us-ascii?Q?wvoexzd635RIeU5sQfgd0BvhOnXw3O8VXeuZqd5pbJlFAZIdH5Ozp+1Yq3F/?=
 =?us-ascii?Q?9584eQ4pyCIplsTnwh0zcIgjLCA9mqQ+Z8aBq16IaioH7kVOzTxOwP1v4ucX?=
 =?us-ascii?Q?yKqAN8MZEnERJG1SRQOIRqzB9zeq+WIzpQ2STJt2E263o96NUoob2Navsp9g?=
 =?us-ascii?Q?ypUmy9kQg7oGfsFi9xKV2OlZKxhVm88epRJO8Hgqz7PGR203WZI2cPhg4zPh?=
 =?us-ascii?Q?sFS2lFLnadVKxAiXlcV1y0eZoGpN2fDI46oFU97SomhNx+GnQXSeWtNSIVSM?=
 =?us-ascii?Q?obYL3Tx2fYtlUPlpqKuyAf3Djy/BI6rlHYCc0WsZxu4Q6xW4gekcFTl2Fokk?=
 =?us-ascii?Q?5Wkjtx7A9QbDDhXH6zMaAAkRlZX1xqK/ayZr+au9AqholjPv6aFYgayndN9C?=
 =?us-ascii?Q?OuZ2W/c2U35zYnLwlkk+xRgqJhJeFXj80cT9wx47d+zUaYpdLoTP6KdpAJte?=
 =?us-ascii?Q?TTen05tyJvPOqyVZlDUpzE50yF4jmcpLChh4yOw7KUqzoDbWNU5kSMp0t3Gd?=
 =?us-ascii?Q?9QlrLlVi5Cu4Du8AiD+yrlOub1t1Tw0SbtYkZB+rwLY9ouWq5qS6kynU6Hep?=
 =?us-ascii?Q?fRsIpbY1A72QF2pKIJchuofRpwNxzbcDyOsbG4219a4RHBPBnnMEEkEHhnjs?=
 =?us-ascii?Q?Gl2V3L7cOSr4BJq799CQaAjgq8mFrdFIS/BCaZrk1M0MJiOn+MdBN0t00IHi?=
 =?us-ascii?Q?xmP2Mqk/Kyj/pgidLeySojLLadg4mbxvtqB6mfMn+BKYvT0rdih0CcxeUeU9?=
 =?us-ascii?Q?HjQmcS4yvrnOi5w8E8TMdhYrfc8NnOxSghiJ5rcKyIO2Efbk1NvUaHJjAgpe?=
 =?us-ascii?Q?crRBk/ZN8v4uukRAzP6GMoBA3CmLm/zprRZJ1MT9pKWvqkFwvDyPyMdRr8Dc?=
 =?us-ascii?Q?19gZkt6pZL0ax/5JcN25XBKwmzb2fuhX59XNqfFPRMO4UHSzD2qIU0W4thT0?=
 =?us-ascii?Q?vUivicV0gf0ym7O1A6poUyA9Wh8IJkO+ihAO2dxl/EQkS/YX2OKR8N7mhlYG?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tDiXVn66HfX1OWL3Riv+GbC1CI82G+ZMvmtOKEqDPa/izXY7XMz68WA/Ow7eVVBxTDGlJtp6abJXemz0XlnIhk1RFl1KmMnBW560cZua1tpv/yEaILyq0J19zEOlWGF6XqmEfUFZI5MSJxjaIewO+XaHU3MxFSoBwgTFP9uHv5oa+s/lL6cVFtjGBsHwmRQY8TksJP2LKST1RYLc/v7iu44LAT5JvXAYGpuAN+Xe7DE3vdaWbdUhzUkdd/1s0D7TraQkpNk+P4ICX/wNYy1lb4BvjIB7ihSiQKFpeH2wo0x3C4SLQCF9IZ07EnCkosKtK2yorPDu4Apu7oOgHPiws529nF4kUrBqQfDPT4rwZR1/aHMm8W/B1Lzcg03nxSjFGs1UOsqeZGgDF0E+1rYK+elzcduVypXgGXNVWGvpt+jkZvJtv5yCDOcskUZosd7W7EyjcN/OT43mSduU+MbuxRp2xoGKUcPDSKIqtQ4/NZzbiDHzYuj64Yryw6yTraPHwYS9WRw2C/J6c2O0mMVNokYKDEvBy+cMx1a8RiYA3VBQ8NR5CSZaPoEGQRojjmPi3tsrHERG/taOM4s3ogKAj22fzabaNSlE7tgL9cZhyIg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1614707-5b51-4407-40cb-08dd086e9ab5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 07:48:49.2564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFcdo/If0CVuVjMAPwIafa/nOVaxvRDDiN6qL8C4p2XnD1+i4c1mmJgEey22txeBJtUI3DxHR7HZ4JF+3j4tYwGnnRwOIjNvNNvvMUIjmr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411190055
X-Proofpoint-ORIG-GUID: -J1rLP5ULl2P32M3h9-xryn3E05XYjjW
X-Proofpoint-GUID: -J1rLP5ULl2P32M3h9-xryn3E05XYjjW

On Tue, Nov 19, 2024 at 02:53:52PM +0800, Qi Zheng wrote:
>
>
> On 2024/11/19 00:47, Jann Horn wrote:
> > Make it clearer that holding the mmap lock in read mode is not enough
> > to traverse page tables, and that just having a stable VMA is not enough
> > to read PTEs.
> >
> > Suggested-by: Matteo Rizzo <matteorizzo@google.com>
> > Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>
>
> > +
> > +* On 32-bit architectures, they may be in high memory (meaning they need to be
> > +  mapped into kernel memory to be accessible).
> > +* When empty, they can be unlinked and RCU-freed while holding an mmap lock or
> > +  rmap lock for reading in combination with the PTE and PMD page table locks.
> > +  In particular, this happens in :c:func:`!retract_page_tables` when handling
> > +  :c:macro:`!MADV_COLLAPSE`.
> > +  So accessing PTE-level page tables requires at least holding an RCU read lock;
> > +  but that only suffices for readers that can tolerate racing with concurrent
> > +  page table updates such that an empty PTE is observed (in a page table that
> > +  has actually already been detached and marked for RCU freeing) while another
> > +  new page table has been installed in the same location and filled with
> > +  entries. Writers normally need to take the PTE lock and revalidate that the
> > +  PMD entry still refers to the same PTE-level page table.
> > +
>
> In practice, this also happens in the retract_page_tables(). Maybe can
> add a note about this after my patch[1] is merged. ;)
>
> [1]. https://lore.kernel.org/lkml/e5b321ffc3ebfcc46e53830e917ad246f7d2825f.1731566457.git.zhengqi.arch@bytedance.com/

You could even queue the doc change up there? :>)

I think one really nice thing with having docs in-tree like this is when we
change things that alter the doc's accuracy we can queue them up with the
patch so the doc always stays in sync.

I feel you may have accidentally self-volunteered there ;)

>
> Thanks!
>
> >

