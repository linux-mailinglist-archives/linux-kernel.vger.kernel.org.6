Return-Path: <linux-kernel+bounces-279779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E6394C1B6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643701C2224D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1D918CC0C;
	Thu,  8 Aug 2024 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dQ8p1LC2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lB/a01y4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C961DA21
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131974; cv=fail; b=MPws3x7WxZDXO9rKTYfME01GaiK9mGudMEEsMEIt63LKs605WO922YnNXZNfZiaq6QpVL0/y8ev5THk+Bt+Y4WYooWJXmwN8hDWmL8pLFdklP6WXkm8ghIjYlL8tg+S4hnTB2V5mrl66Zrcq4k6SZkzIs8VS5qZ8lfav78N3KQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131974; c=relaxed/simple;
	bh=Q1h503LBfE+sbHWTH3x3djTAQgl2rvKc3Nf2m7mjP7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WsyJadWgRP0eXl0Izqu/sqS+sEitr8hxv/z4B3itPlyKs2N7WC269MiW3zalwBpFD3tCES+CicjLLZ60mA3VDeeOx3lLxLj7GOXt21MN9+KEdp69GuLPkEtDeaiZ0zJu8uYDjRih2TSx8VKtGK/4Ij9C0mIMmO/lKwdBpJeInFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dQ8p1LC2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lB/a01y4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478AMfWf001725;
	Thu, 8 Aug 2024 15:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=nvkyl0+jQPJaOtH
	THmV47fnHjH4AELOWKpatwltpbQc=; b=dQ8p1LC2RpOPj/fmVz3oxrg21Wjz2uG
	jxHkhspT2s98vi/UNY4XdmS/BmOm5zKCFSLjBWSHObHJ5o2jCR69NCpdwJyBZFXH
	WpPNOYfpvQkO72isTf5PHL4Qm/wQkOgzKlMyaI9ztetgiLw+yZMMw5l7cNBCBYg2
	lZUO6EUhnMh7GBmyGgW4s2bBmqhdOXzlvyIR5DrQj7WLXQ2wpKrEWsYiJMl3Y7L1
	OXNhWr1WjSPiFrjIEv4UCPtURmJZJ/169V3ZL5tGYKYW2LRRUocmn737JK4BgNSv
	4mI4KMw42gMT13a0bfQ0NYaabrfnPgVv/Pa2vVmHPpLkYpBdXj/yuSA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sb51j6ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 15:46:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 478FRTQj040696;
	Thu, 8 Aug 2024 15:46:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0bvm88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 15:46:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jqku8VfAQS9RTcczBR7zm0z1vZD62Jr6vAlJP32AVCh5emcugDyMCx6tNnNqolBOKoRliidA4gEiLQZkggICBeMOp6RxHJ++03cCRg1nW3n31seFygUR6ginX9ibuOQUe4zG/LvCwU84hgNNL71FtKNOKegXAf+iEdzOGgjED3DPPRXgxsivLzSKUNv65UmuVbfjCPC1HR2H6TACGK5ncpjp20rPZUHLD6MKxkas9neweQVpGlTi2+aHQUkzq0ojMiPCCh8oxdWvtgHlryYlg3fhe6XK8PtSN5GBQTFRUkHGYg7+AEMqRTjS4pSqNLvbeikqXTp4YNYvVxIreN1r2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvkyl0+jQPJaOtHTHmV47fnHjH4AELOWKpatwltpbQc=;
 b=m/aR3h2rH25I2FGk5WmQQF4ggS/ihannQJOMixMdpqeUlVhlFcwj+e7hFhwayoGPpf4VSAuMXu2alAXrwKN3qN23GwrrMfaE51id42/faVoT/vwWO97iDyOngLicZzE9Y0u7jVUyUIxg/zg8Rsgcp/KInEF0cX163j57HnrOC0qVFs01kzGBc+zqhSzVyOn15n+stOEyVwmUQNSj+1odTCTtn1d7sJuo/xEkju0C6XX1phdsllRlAxJ7M3WaxmqyPI8Ix5qdU49QFdl8kpnHI/M7StS0Kwc+SAA67Li6v8ih2okff6wflh9maVkbu/we2lB8LKHUmTI4nUy8V8cZIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvkyl0+jQPJaOtHTHmV47fnHjH4AELOWKpatwltpbQc=;
 b=lB/a01y4tq0b1/gaOoR9cJkt2k1F0LLeMr1YU8Y+tTwYdZCpR/dHWYCiBzdFodP7Y22csZdIE7u8Z2iB9b4Bw2HdiBUWZ+tG23p+0xfdSIrcXqzM0ludCnwy+Lc73oF0ooOPxxvT+1qnWWJ8EmtVFzYTpInY4gj41KYfFOcMMHY=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BL3PR10MB6140.namprd10.prod.outlook.com (2603:10b6:208:3bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 15:45:58 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 15:45:57 +0000
Date: Thu, 8 Aug 2024 16:45:53 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 04/10] mm: abstract parameters for vma_expand/shrink()
Message-ID: <2d85f8a8-6937-499c-91fd-7dc5deced71f@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <95292b1d1215f49bd895f1aa38f54a8274c350af.1722849859.git.lorenzo.stoakes@oracle.com>
 <f12608ec-9c40-4977-a5a6-479f86b44e80@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f12608ec-9c40-4977-a5a6-479f86b44e80@kernel.org>
X-ClientProxiedBy: LO4P123CA0308.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::7) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BL3PR10MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e942b2-81f9-4c9d-b054-08dcb7c1322d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bckAwCDgTpOLEMxfwQVpM/35UMjzweNifp6WzlVXdCYg+H1KnZVLkBiXBya7?=
 =?us-ascii?Q?i3tx6n4TQZv6dcGDd45ni7tiUin2L5UkqoXFvEC9alMeeJH4CJAzZic+RBdR?=
 =?us-ascii?Q?h+Wx5zMuZb6j+yBolXvMJ0LVm/5Du9P6pc/2aacBJYk2CCEWrl2c68NEvfJI?=
 =?us-ascii?Q?asgpsTTerys45rQAgs5ekeB8n0k9e8Ap+v5doQ1M5rRos6plNIxLQb5CUOVB?=
 =?us-ascii?Q?6VCEhrb7MNAl+gVHZEa+56h6tQJWNwt6H5sJvkoLmnbnx38RbWfTp6A5pM/E?=
 =?us-ascii?Q?pC8tl6jcbSVgigXU9pakx6c1FvJxO1aDlsK8YXMhMK7accfj8aJYNcqfOhoN?=
 =?us-ascii?Q?XOU4RoP2xysTpwRFY40EkI0FyyUxeihsY6iviw5tybHPHaxkPaF49QUtHo6V?=
 =?us-ascii?Q?WnL1Rds3AyUCLekJERUYepCK+puWC4xUtU9sw3ZEz5j+dr6MJ5FrnGByjlJk?=
 =?us-ascii?Q?OvNDYFU+D+bLMoVmr8hEGiAG75ylF6tP67CViwztk7sgNUp5CfYd1bBp78Nq?=
 =?us-ascii?Q?q5JQnL1CwoWW1q/FUGwLAnl4DfwUG1adg5zhl0Tq1Vu3ViKopfYtV3EhWnWE?=
 =?us-ascii?Q?XTARt9gAk8bPSiaV5PVIb6HeQYU2A2oQSkjpZT+OJba1aVh4WvGxEb+HRLbB?=
 =?us-ascii?Q?0ZSY4TcHZtxjIAEtWEZsz1reBn99z/AUb2G8kogPFxuTK4WKjoq7a/K9BR1z?=
 =?us-ascii?Q?D237uy7fi+FX7aeAEYFqk9OwNoBaLHacf18oLp/O/GySHfc/W7zClZ269JmN?=
 =?us-ascii?Q?TdcPS1sMyXPt6GOjQz79cWtVT/GZNPlWKigm9IKHzM4Qs+6APtHpb4A8ezf2?=
 =?us-ascii?Q?PIy8KA/CuAniyhfbyvOMgK3DfO5W6rwZsE9gSjyqelYRuPh+xotzpCQBCr5A?=
 =?us-ascii?Q?KtD3KDnqj+lvSgh4yEq1Rbszdb/ij2lo1hCUAbfFqUqfi2jSLuCuiMkJuRuQ?=
 =?us-ascii?Q?hOF8GrJX/s+NqvXYfjsIqx08paIvISdl/ywV4rpa4RJuVHfYAQ0sCr9+Q0L9?=
 =?us-ascii?Q?2jzKGXqYD5XNwh7kaG2D67Z7hofncAufwNDVQufn2sUCu7CZgSnHkW9jf2Ee?=
 =?us-ascii?Q?dlkENRJFI6VSfqInknsadmSZK+bV7N86Fk4jaP458WMvZ7pcT4rw7MXsYfxw?=
 =?us-ascii?Q?CzZAEeLSAxRJAEfnK0qVIAjKgsCqRQwkqlhj1GYDhXlFmqR6+dbZyjiypik+?=
 =?us-ascii?Q?KeItx60vbh5I2AIuMuAbRvsxaFzcbnfmN8y2OzNhM7IeAcsLpQvRjDzCByxg?=
 =?us-ascii?Q?1llfxtqeeHU4zDqUsuv8Ku8XvbqEqSEQYRsEqkOgznxlNffIQVn99qycHtO4?=
 =?us-ascii?Q?nlR90QijyffXCb8PRdYnuOXax9ysoqoW9VmUIo06JnBtaw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tMwLHCgNdyHUeQ9i0MgJnaW4DV3PX3CfY7VHzC2jhQe3sih6hU5gxVioo4hg?=
 =?us-ascii?Q?0bJZqvUrM36bfbWHCR+9ih6+JwNkbeFxD03PxYo+VRhDHGF6y7+SLO+b0bcA?=
 =?us-ascii?Q?MP1J601p/7c51G5tgVX16zF2vkMn7yCJfz9/MGPWVqkf+Zihj8dRCK5Ih7UW?=
 =?us-ascii?Q?XaXqsoKHJa4cgcHSbydO+8Td0++OounWi1qL0UBMxzy5hb2JMmiPEvFSDY0g?=
 =?us-ascii?Q?57d6X5o/2jh46KnxK017vm3JxhNs5WZ/GT4hdGJGAU0iyHjGcTZjzVRQIjAT?=
 =?us-ascii?Q?4pLZAyMQgXx6/1+ePU2zurlvQ+9S0D+AhtSH3AstKY8Cr6eYAmV6a/cAFEsO?=
 =?us-ascii?Q?Y9rFRDMyQEKnE/hbgX7hyiF2u6n582+EwkhUSwItwI5+GNAwrxa8oOfAYFox?=
 =?us-ascii?Q?hL8zx2oyf3i1bUUF8Be71sQMuV1zEt/xKP+MokO0n50HNOYGSWFvO4U7qCRc?=
 =?us-ascii?Q?W0XzrfpR7o7qxtptClUFKsy/lcJKPadeBEfwtgw80wwSOGu70y3gZQpboiAz?=
 =?us-ascii?Q?6+h3KgbMVeFDlR7wauveVTGK7d7670m4chGKys5+LDBmbEwmZUAAkXDJg+2p?=
 =?us-ascii?Q?HBhto5WHD4u2+2JuTB+r3tNmYOEIpLVtbxhKpqMqTQ5ZqmaEc4mFYsDzkDZb?=
 =?us-ascii?Q?yJ8kmvXvtAhMMvMc6grSzJMw1Oiyr5ClzmW0k89Z4WHVE2elrHFug6L8Yf8b?=
 =?us-ascii?Q?U9ze2vCLhdjXl4dL8+O+nVswSHaA5QyuwrKeriCwDfUjVunmwzaBzLvs40XP?=
 =?us-ascii?Q?OW3wWJLqJ84FAi0I5A3+Qg6tyYh23AGz2Dm0sUi1uFevKL0vH77h9rnHIXk9?=
 =?us-ascii?Q?e/Ma5P3JRYoTy/6+dxEwwwcSjPZTb1l7k+zVo3pi428lMJWoIchFcoGByYUZ?=
 =?us-ascii?Q?KsxwU3a22FFZS6s0vuoV1q3ozZuHW0aVu+h6+o6U2ucV4gvgrDn9R736lq+S?=
 =?us-ascii?Q?Ntj43RdHEn0CUut7Wc8fzXfnHMHSETumLmXQoMyIKQBvwk9MUa945M0+jeYF?=
 =?us-ascii?Q?IYA/1ag6zssvACte7D2Ax9BBlNs5jJaz2pLUerJN7JdGPHKT6YCyq8vu6V3Z?=
 =?us-ascii?Q?oOqEXiWI+KpEW7xJ8o78gAuCYh8lMW/EkNMnFEkF6ue0mgsKqc7f2X0HFoJK?=
 =?us-ascii?Q?oemhy5SCdcsqPdE06C2hkywpojBtJAb2McNJSrnKojiZbM8IDs85O5TtyQgv?=
 =?us-ascii?Q?QIXHj6eWpWw7p8EC3+8fBERybIAAYiDskpUvGitzKw2xpt/iEOv4uIf7Tq/s?=
 =?us-ascii?Q?Ldx2yBKIxyVK4u8L+rnj0/3fLEBj+y6nazpPb3Gq0l8D4Lff9l7dNBCiTCHk?=
 =?us-ascii?Q?+JpndpGmMJxbiCKom8MIKXZ0O6XlRVMlk9FPLkbhdTYdA3+57XK8omGgRMYq?=
 =?us-ascii?Q?X5DUy6uBZkbKqnc8WJTLb0EPWtLgxCSEFGZOSDxHqdbOcejrHTjjKbqBl9hJ?=
 =?us-ascii?Q?XB39CUxPQQ7oLArghpsmt2hZBkRnF65OPirO/wpx0YRKFY5fYPIAK8ZIqBHu?=
 =?us-ascii?Q?L//0ZUkMa9fGh4Kx8vPD9V++cRO5Q5OQBi6NyPIJBc7bp4sKS4VOYt1RdMNF?=
 =?us-ascii?Q?YBIplTX9IdQHCLWwY4NDYvV56w2WYO0SAPyStjEusMxmGyueD75XSIKuCFdq?=
 =?us-ascii?Q?p2PofPwEL3PudVWmJDBR6eaGNkuOjwB8ErBhTuBxLKDryJuyyul/Arh7aadG?=
 =?us-ascii?Q?jxyFtg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u4zL+85VwmSa/z2AbHJFjxnW+nQdbZXLIb73fd2PBlzT8gBjQwX/KR1fiEE6VoIfZI5DCE2S2NZTSemNelqQxrN+voRfaEtgZE8LXdJQJtn2vgJbagvs5r3YacAssoBbIqw2ieYII8ml8YcWwOtRehMdr/JW+Gf2CiEdAT5Sn1u/gA2Jy7rVEnM/TRdinUS9n7ycgSMucaz+IgKDdvwLUdx1o8l8h/hvXmpQj9Iw8NxaXJVbVGK/ozy+a/mvqmljbFPk23e0MJs4TbpEDZJ0jYqMrZgJc97Q9M4NxTTEP6JZvWPGeWVVQSYXlZIjIk3XRIG/bJkgvoFzCBVyptKUMC5L7XHunNaW7whdbjmK8xySqInrynr+rxSRXRGvOcOly5rXqigGsXpyldGIHE5hHepzz8Qq3Yb+roxx+ZTwokghF713RmwHTyOCBcGyuRYyJczcep2BmKlsL7LZMv0EYAzAC9afJw7CxHa1yKM9a0I52gSj0twVKKVEPfX+17Lx87pVuQAbHWe63hE3irMGbRe1JTzPxC6NFGQeWUYOe2nGJMulj1NWBYNrdOS+fmShU0QAOuUbDYVCyvRHpDTo1mtdC7hWgKLM8Yj4y283yrQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e942b2-81f9-4c9d-b054-08dcb7c1322d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 15:45:57.9215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWeuG5X+UPugUhAKKqWWkfXQdNa3RYszsGJhMA2NmFLyTgl7bcUQoKQqxzcTsfl/3Q8tRrzb4B/FfT3cfLWpFurR9B9n4ePwZAg9T1zh7gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6140
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_16,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408080111
X-Proofpoint-ORIG-GUID: ApJucozDOaYPQkP926uAq3zCSEVAv0RV
X-Proofpoint-GUID: ApJucozDOaYPQkP926uAq3zCSEVAv0RV

On Thu, Aug 08, 2024 at 04:20:26PM GMT, Vlastimil Babka (SUSE) wrote:
> On 8/5/24 14:13, Lorenzo Stoakes wrote:
> > Equally use struct vma_merge_struct to abstract parameters for VMA
> > expansion and shrinking.
> >
> > This leads the way to further refactoring and de-duplication by
> > standardising the interface.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  mm/mmap.c               | 30 +++++++++++--------
> >  mm/vma.c                | 66 ++++++++++++++++++-----------------------
> >  mm/vma.h                |  8 ++---
> >  tools/testing/vma/vma.c | 18 +++++++++--
> >  4 files changed, 65 insertions(+), 57 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 721ced6e37b0..04145347c245 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1367,7 +1367,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	pgoff_t pglen = len >> PAGE_SHIFT;
> >  	unsigned long charged = 0;
> >  	unsigned long end = addr + len;
> > -	unsigned long merge_start = addr, merge_end = end;
> >  	bool writable_file_mapping = false;
> >  	int error;
> >  	VMA_ITERATOR(vmi, mm, addr);
> > @@ -1423,28 +1422,26 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	/* Attempt to expand an old mapping */
> >  	/* Check next */
> >  	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {
> > -		merge_end = next->vm_end;
> > -		vma = next;
> > +		/* We can adjust this as can_vma_merge_after() doesn't touch */
> > +		vmg.end = next->vm_end;
>
> Ugh, ok but wonder how fragile that is.

Yeah you're right this is a bit horrid, I'll find a way to make this less
brittle.

>
> > +		vma = vmg.vma = next;
> >  		vmg.pgoff = next->vm_pgoff - pglen;
> > -	}
> >
> > -	if (vma) {
> > +		/* We may merge our NULL anon_vma with non-NULL in next. */
>
> Hm now I realize the if (vma) block probably didn't need to be added in
> patch 2 only to removed here, it could have been part of the if (next &&
> ...) block above already? Which is not that important, but...

You're right, will fix.

>
> >  		vmg.anon_vma = vma->anon_vma;
> > -		vmg.uffd_ctx = vma->vm_userfaultfd_ctx;
>
> I don't see why it's now ok to remove this line? Was it intended? In patch 2
> it made sense to me to add it so the can_vma_merge_after() still has the
> right ctx for comparing, and this didn't change?

Yeah, yikes, I think I was lost in the maelstrom of considering edge cases,
and now this is broken for the whole prev vs. next uffd thing.

The fact the mmap stuff is not directly testable is a factor here.

TL;DR: I'll fix this, you're right.

>
> >  	}
> >
> >  	/* Check prev */
> >  	if (prev && prev->vm_end == addr && can_vma_merge_after(&vmg)) {
> > -		merge_start = prev->vm_start;
> > -		vma = prev;
> > +		vmg.start = prev->vm_start;
> > +		vma = vmg.vma = prev;
> >  		vmg.pgoff = prev->vm_pgoff;
> >  	} else if (prev) {
> >  		vma_iter_next_range(&vmi);
> >  	}
> >
> >  	/* Actually expand, if possible */
> > -	if (vma &&
> > -	    !vma_expand(&vmi, vma, merge_start, merge_end, vmg.pgoff, next)) {
> > +	if (vma && !vma_expand(&vmg)) {
> >  		khugepaged_enter_vma(vma, vm_flags);
> >  		goto expanded;
> >  	}
> > @@ -2359,6 +2356,13 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
> >  	VMA_ITERATOR(vmi, mm, new_start);
> >  	struct vm_area_struct *next;
> >  	struct mmu_gather tlb;
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = &vmi,
> > +		.vma = vma,
> > +		.start = new_start,
> > +		.end = old_end,
> > +		.pgoff = vma->vm_pgoff,
> > +	};
> >
> >  	BUG_ON(new_start > new_end);
> >
> > @@ -2373,7 +2377,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
> >  	/*
> >  	 * cover the whole range: [new_start, old_end)
> >  	 */
> > -	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
> > +	if (vma_expand(&vmg))
> >  		return -ENOMEM;
> >
> >  	/*
> > @@ -2406,6 +2410,8 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
> >  	tlb_finish_mmu(&tlb);
> >
> >  	vma_prev(&vmi);
> > +	vmg.end = new_end;
> > +
> >  	/* Shrink the vma to just the new range */
> > -	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
> > +	return vma_shrink(&vmg);
>
> The vma_shrink() doesn't seem to benefit that much from vmg conversion but I
> guess why not. Maybe this will further change anyway...
>

No it doesn't, but it's more about being consistent with vma_expand(). We
maybe want to find a way to unite them possibly.

