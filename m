Return-Path: <linux-kernel+bounces-348013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3833798E189
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6389C1C21C81
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4F51CFEA3;
	Wed,  2 Oct 2024 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jt2nVH/G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cIVEQH2z"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A761C9B91
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727889575; cv=fail; b=bYR59MmO9PKZ9mLZ7nF1azWgn60IVic5JwmOSk2hzxOUaMNPskkYJcAQyPYrINIbHVw8bB2hgJz0BHjcD4a2/R9X8MZiBXPHPIdTbN7SZA5GvYfJgxOo7spTImyBJ5hv+2vwf+ABWGjiT35Iofz75faH1rXfLZEZCZX2Yxp8iMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727889575; c=relaxed/simple;
	bh=u9yGlclySp11k3wcX5B4XFmwK76uU5+6jNJsxVIbzKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uagFUZU3jIoMpt05AIyBl3pY1jiO6OECPT935pfWC+4klYu66xmzuvDfbYm9KbQokKuidzbS+b7pUVah1sj3uS6ZZhPe8nL1UgSooW1BS7hgtWUl4ahASGBnifGr7sMquU/ncBt7lsyCb2DZEh2GrsP8YV2mRAGUDlP/MC+QYCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jt2nVH/G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cIVEQH2z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492GMaNo028361;
	Wed, 2 Oct 2024 17:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=1MbmPUYBP5GFYvu
	+HlypFduSf5WnFlnwLqfVAEz+p/0=; b=Jt2nVH/Ga95oOi+q54MVwEtoe/VbXTK
	r6KiTZMug2yMoXtVWB5EPlgLdEwaNJrBuHG3PNzyl2Jy9XXn5s/Z2SaJVKBEMRK6
	+XPJoKBBdLOUKYXsY6IaldDsvog/H31SSQLX6zLbWKoa+O5RKQOkn9N5uuXaT0X6
	PLl4BDPMlsj9I2u/RnfPgjfyWS8zAtt/Q/80ECucQ6l773/7BmzKp0YWH3LoACas
	zdgW3K/Q/AgI8KI00npvHk6TF5tWHHvsh7DN8+XJcK5pmgJh6g0MCcDVfftdcekj
	KhptTqWXW2pZH45Mz1B8XoYXaY3tXYxWPGo5hyRzHPTWYbrUOh38K5A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8d1j6k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 17:19:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492GURsQ000798;
	Wed, 2 Oct 2024 17:19:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x8894d3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 17:19:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqmt1VbIeLR7QQvrBYET1D1ikx/5EE783T36+WeT6hLzYpgLaNU0wIzc1/iQ9I3hUYHBy0dwAj1j5d5ZcTL9ADwrNNQnbyvMcIumpunE/J1Iu7GXS/G5yl6vUixCDjl7FgM2Aw/0TJ2zquOc8n01Hf3AC0+1pllM4hJGTJToqNyI58jdNLtmRfHDK80/e40wHY59UHCsBxWqWjxruKbUn8MmAT0Lp8mLCWcyuJAOpo5A32V/AxNsg8Hyvg2HmbZI7npjNyfPXEjbIuIUWiEteqMHutEQeNmYnortHLP/Xr5xD87pXj9JNJFEFC7E20VwF7/1jlJh81wBpMwVqsqvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MbmPUYBP5GFYvu+HlypFduSf5WnFlnwLqfVAEz+p/0=;
 b=zOpPgw5UDL+gHlGUJNWHPB7Uwkmng3P2y5k1MnbivEvKZX0tGuzdJp/XTIYJq+CRvlwyRwbTHBv8BxbutOmKUUPwLQ/+JPjsP2B+YqQUWkg4YjpR65LjLs+zwyOVGXWqE1vkgJiyD3Q/2URvTvXYYKC5eqvtjkTDXLBOfaAIcACFFlX3oIup5nPnmhZvfYo7BB8uNBlpJx2m0CZhpms+YrkbYK+Z3hRWZKDOIciMWndCZU6rlJSZ3SsvuSDFVHUZZYW4Nkn2h9SBOBmOPEI65SYN1grN/0YKEZpt2JSW2l3Zd9UcF83du38SjyOA4wVeMrEPiKfzJPk58L7kkfwohA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MbmPUYBP5GFYvu+HlypFduSf5WnFlnwLqfVAEz+p/0=;
 b=cIVEQH2zebQ4kr1VBaXuylrDifSye9kdJmmAMpwvCs0HgrFNmYrpnp/PgUoK7QQpjnHIVQb8z6NS1/FZlaTDAni03IxLpO1V8GFkV9xeqefrXCihfzUS6KvkPlFfeQE1R1s6+Ft26F16cvZvLOv8dQpikDwEG4p/fyGmYfbPdfs=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB6822.namprd10.prod.outlook.com (2603:10b6:8:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 17:19:23 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 17:19:23 +0000
Date: Wed, 2 Oct 2024 18:19:18 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <c63a64a9-cdee-4586-85ba-800e8e1a8054@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
 <26991b8a-9fc4-4cf9-99de-048c90e7a683@lucifer.local>
 <32c0bcb3-4f05-4069-ac18-3fc9f76c6f7f@lucifer.local>
 <9d8761c5f32e2bad14b23772378a0a856b51003b.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d8761c5f32e2bad14b23772378a0a856b51003b.camel@web.de>
X-ClientProxiedBy: LO2P123CA0106.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::21) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f57622-aed7-4df7-e77c-08dce3065beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nQRSHBV+HCGyNCMMmWZgxCyGVWw875C/hIc3g6MOx7O8nXtP52HwoOWKYR8Z?=
 =?us-ascii?Q?a8sIWB0K8gqTt/6OgLKPdNVu1fo6ZXo0h1iZYjGeROT3mn8yrx/FSrjkKY8T?=
 =?us-ascii?Q?Rpk9HoMv1UPQdDmp6h28nF9JbbEeuGhds3PHmKAyo66BiOF7d3RYLGRofPqS?=
 =?us-ascii?Q?Q3eZjgw9eLmX8/Hejb4AJ2y5BrirQPKSeec+/CZ0yqPaFaXr5PCzNci2G5cw?=
 =?us-ascii?Q?Q5zZy7qwLGOVwLNx1FX9b66O+8isb0IQvj+HLOtPXbuGgXtW8CbFEWFwvQXz?=
 =?us-ascii?Q?06MUJPnOX/ZNQWE16cncXOls7dJ2+CqDRaZb1oYDDxnA2Ky11eO8ZAElhTI1?=
 =?us-ascii?Q?STFhO5cdrW/icBhU+2Qk1VXUjg6Rc4KqaAfOVITg0wYRTyirM8v3N42/Fz2V?=
 =?us-ascii?Q?oTmOEJBCx0Bnru64N67kNOZPS1tvdoU97tU6SNJCiTI9HFJKWxzpD/avcZGs?=
 =?us-ascii?Q?PipQMCm7Erl5Ha8lBXWTRiM0IT/uHhue83q/qLsG6+FzRtULYz3XKzufDJT8?=
 =?us-ascii?Q?DpH0R7CiQ/kFt+GdVDab89hKoIQZ8x8in9z2UHt0jl+rNd9iYR/IwSPAne9t?=
 =?us-ascii?Q?dvXm6qZS6n9eqNZC5fxKCFyf/K/6Zl6ijTbcFtsg00IfLHhE+D7nKgUah521?=
 =?us-ascii?Q?qSX92Q8SsMJ2/kFAhKnnrcXO8R9neHnQrAT0PQ4dJA++Ih5qpbiDmtxbP+3x?=
 =?us-ascii?Q?6sQRE0oGwsWiSeFDrO0Wfy8ZQJl6Xz1qvl/WOkt6TnfUE3sdyOsw6DkP9Xn6?=
 =?us-ascii?Q?PFdUjXH7Vf0VV2ZbB3Zr8GIUW02Nf7iDNVHSssFnrpnuC0utYF9P+a0y+q9T?=
 =?us-ascii?Q?RrihSBm5f3CwycnOk96X7c945BGqWyIly2vZ1JsvCE+29xtM22bOpnqzKXWS?=
 =?us-ascii?Q?3+zV4yZ7Jk6qY/Zmq55M4GvKRUPsaOxV0imFsLvFeD+BL/kz+vrC0WoqGqOQ?=
 =?us-ascii?Q?amStNLp73k6p/G19qH8nOk0EYUFIyaZnkhGnedJvbeSCd4tsrFwpA3lEK6sZ?=
 =?us-ascii?Q?cjseL1mBq251hQWSS4kUuWPZFeNUKWyuO4BPmMq9+G60Y6WqomSuNeLvo188?=
 =?us-ascii?Q?ZeSaMs9JmNqEF7Menq2GfwZU1VmbWajU187H/6GWazCOWpll6b88VKbqa6nL?=
 =?us-ascii?Q?yP1Oe+2MOeTQzEN203S0dsszmLzQw+gmo/fh6xqMyFmrYT16Lnb7DbFbXWLt?=
 =?us-ascii?Q?zuc/Bq2ldNMnSkd3Ta3m7bhTutpWY547PLhSHzAPPG49Q95tJdiRS6dOYqCC?=
 =?us-ascii?Q?E/4cp2WbfK6CcocSmfFSsxUFM4udMhXcItpgx5zoXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KLp5SoRTFApYfBo8L1pFgAERmZ0b8GAE42GLWysK1M9+PLntudXfrNJRXbnQ?=
 =?us-ascii?Q?33uKjbJID00o3xvKgnzqoKUdjNT7sqIM782TnUwyuTEXGVJNyy2IKF1nWSF9?=
 =?us-ascii?Q?OXIAft0n7myG1eopllGyonb5wy2qWVLTMOrJFrfIXlUCGEXEV6bFY/oMndVY?=
 =?us-ascii?Q?0d3LNUdCZLlmpZ268Jf8aGbD2jNqNOYQu5vLftwyPcPvv/rZKMW5VuevNiBM?=
 =?us-ascii?Q?zMu63zDQZUPZZv+Shya0SzFx8hY55mxe+jLVMMZ01uLU5OyqemwaL7Unt2aj?=
 =?us-ascii?Q?f1oiwHc1udJMJm1LMk1PQJelWX5YF6K33idRGeOBrUYFkL3WZ+LQeM+UQZ7o?=
 =?us-ascii?Q?tXL2V+n7KHP13A/GpSPJJkjXfP7EKPrarfQSKkAzw+L6k3IXOJJwzyE2kwG+?=
 =?us-ascii?Q?xsuLntvusaqAHztuah0rI8ChGbWKJHw+nD/nHczVDB904+o6oXgh6A9olnCa?=
 =?us-ascii?Q?/pTxD+QaonC8Rx8emS7tEy0RYaiKZm3V2F091JTpsCLYdCo2hWXXAKIS8kbT?=
 =?us-ascii?Q?t3wNnnozrWQ5zVjV0aMgFr/1VFC0KmNxKudxBdpwBTjeFeb71eBNzqf1DzG1?=
 =?us-ascii?Q?0GR+7C7wbkTSpvd/rCl+7fxsZfBoN4jmYuHpe3iGsBlqJL/1189ztcn2rkyN?=
 =?us-ascii?Q?gYhpSNoj6AmFPIknTLR/ukk/WViuRz2JRCzenE0aTrFbVyrBrX0Vn2WZAJPe?=
 =?us-ascii?Q?kYZjgZsHS4A+FzDQNQqLh/nxZe4669GxxSnUs3Orr1ACQH1OQJjBAUmUAaTw?=
 =?us-ascii?Q?izhGp3h+QRsZktIV8ry5nVn5jPqR9jL0aWSmmkSq5++vfnWHtp5fpxEtK6yl?=
 =?us-ascii?Q?RILJ2PbubiyrecvbIGD8T2M+I8iZvc9VAvTdedPpc6e5v01tFXSakhtNGsOX?=
 =?us-ascii?Q?GNFvlhP7RKIzk+vkFXatkVqDm1rE0QUljTahYHh+rq/LuQXQYtQXCRYXJ8pJ?=
 =?us-ascii?Q?CpDLo4FZr19hv4MRkQnwOAAJ46fc5ocfFL+QgV/QVR20Mx7e0JfVCG5QmSVK?=
 =?us-ascii?Q?t93iEx64mLCOTZWgVVH2Lr3LznhX4HuJY1ANKMQEHOulmU1rUlXjox/JkZPA?=
 =?us-ascii?Q?a85z+c4KTdbDyLY7SIzFhadzulejMul1tZvaBXvsGHhWkfx5iOMAS5go6yVK?=
 =?us-ascii?Q?ive/W21jlJbEf9Sa81zwFHIivBrFkbUpvLenXOQvUBlC6l/jdlC39X/b8nSF?=
 =?us-ascii?Q?ytW0rR7/CrehcaxUCYKWWI3AVzXwRrETF7kL1lXV6LU0x8iGwER8pjNq7Xgh?=
 =?us-ascii?Q?7GAVQ3GpwGjZbAamD9ThIlA/frc++d/zwWGUiaNOvUD+bDU7tiMzwyVAPpNk?=
 =?us-ascii?Q?OA1azjojaQLIAKATmVKLh/mF/cf9sbn1vUEynvZUURkjTfZN9KsjRo6tgGIB?=
 =?us-ascii?Q?qhG1rmfhG1qXtzmC4MzOadNufBeU3key2WbVdoq/2EQfISYpXxkPsuAStPRb?=
 =?us-ascii?Q?ZPPJN4X4CEOnfECscSSVydEn5Lo14jaNpepUdKsB5qGWw9qno9qcBlZdRYmI?=
 =?us-ascii?Q?+/7xPDmjoKDMfpAga9UxqmMoa+cdQR80a6f3HiRy1b5WOKD60As6XsdcQIsu?=
 =?us-ascii?Q?RcZ+uPwtQoJwXOPW34LQTgohA7pPz8HtHckMG150G9Yj0RLWYOOxGvlTdwfh?=
 =?us-ascii?Q?o9t3pJmDERdg+vpqhlgCHDgOfYNF4XyoVTym7nF6NwV/GKWCaT+YYNVbEpLA?=
 =?us-ascii?Q?vHEocA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i+rz8ibBVAyO7BPRvdTKjDI41uOLGcPoIK+jJenhkawRYSPbDomLezAIl3OsRb63gPy8MZ5SJznZ9Zn0r+8xvdzO6TTgaxjzZbJiRIu99bkYLGX5OlLKKfaJlmAWxyPkbuxLzvVde4fudi4T0Gd1hJ5KHDiT2Agnc3VMb+5O+foma3fINn78vs2LKUmJeSMfKgxynFYwAnIGrhFRHY79FpLC6d5l518PoA+S6JBtLRMMJd7opqfG7UsrUdSr3p9JvYnOXeXToXXFqe9O1aFe2/3yMl2kqAKRcgrcH+/6FYImdjEgEDGCvrHhBvRLQAUd4MI1pol7DMM4ga93Z1/08NK08YZWgXVQ0OoLR9/OecwyNku41XpGUGKfp0oHsRL+wv9gF9UwyEeiIo34Xld8IJ5bUHL3+93+MiLt+nSNSvY8OLb4rY2IGAtrFWBot4G+tc4Y0dOtIn1pCHyCVayoqmmId3PjoWz6uemSvf0rzXBg7tjMx4VGM6KZpqQOu0FibY+ZlMhmHZIa6mDU2V0xG20mXz8H6ZRVjX/QzDLKyC0h9WONDFcYJDVN3a1pw50fd/zIOl+ZFYvRp6a88/rJgkc2gtc8wM6xpsx0m2meAl4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f57622-aed7-4df7-e77c-08dce3065beb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:19:23.2099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKd451QmxObWxqOR2YL6O2uUz84Xs1ZGttop56W2OtTAyC60xXfs9gcePn/sHjiZd8ldbWCPejO+AT6Hp7lyY1wiz9K/NxGa4IgUZMRgHRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_17,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410020124
X-Proofpoint-ORIG-GUID: Qa8e25rMq7gW86eKChBYurQtRgQHWtsV
X-Proofpoint-GUID: Qa8e25rMq7gW86eKChBYurQtRgQHWtsV

On Wed, Oct 02, 2024 at 06:13:47PM GMT, Bert Karwatzki wrote:
> Am Mittwoch, dem 02.10.2024 um 14:23 +0100 schrieb Lorenzo Stoakes:
> > On Wed, Oct 02, 2024 at 01:13:16PM GMT, Lorenzo Stoakes wrote:
> > > On Tue, Oct 01, 2024 at 04:34:00AM GMT, Bert Karwatzki wrote:
> > > > I just noticed (via a bisect between v6.11 and v6.12-rc1) that this patch
> > > > (commit f8d112a4e657 in linux-next tree) leads to a severe memory corruption
> > > > error under these (rather rare) circumstances:
> > > > 1. Start a 32bit windows game via steam (which uses proton, steam's version of wine)
> > > > 2. When starting the game you the proton version used has to be updated
> > > >
> > > > The effect is the following: The updating process of proton hangs and the game does
> > > > not start and even after an exit from steam two processes remain, one of them at
> > > > 100% CPU:
> > > > $ ps aux | grep rundll
> > > > bert      222638  1.7  0.1 2054868 87492 ?       Ss   23:14   0:01 C:\windows\syswow64\rundll32.exe setupapi,InstallHinfSection Wow64Install 128 \\?\Z:\mnt\data\.steam\debian-installation\steamapps\common\Proton - Experimental\files\share\wine\wine.inf
> > > > bert      222639 99.8  0.0 2054868 2380 ?        R    23:14   1:01 C:\windows\syswow64\rundll32.exe setupapi,InstallHinfSection Wow64Install 128 \\?\Z:\mnt\data\.steam\debian-installation\steamapps\common\Proton - Experimental\files\share\wine\wine.inf
> > > >
> > > > When trying to kill those processes with "killall rundll32.exe", these error happen:
> > >
> > > [snip]
> > >
> > > Starting a new thread because lei is totally breaking with all these dmesg
> > > logs and I'm struggling to be able to reply correctly.
> > >
> > > Sorry to make it hard to follow everyone but there we go.
> > >
> > > I have tried to recreate the exact series of anon mappings and it is not
> > > triggering for me, so unfortunately I'm going to have to ask you to try
> > > something else.
> > >
> > > This does sort of hint at it being maybe an unusual code path with a file
> > > set (possibly...) - could you try the below patch on fresh next 1st oct?
> > >
> > > You can grep the dmesg for 'LJS' and just provide that if it triggers,
> > > mostly I want to see if this (unusual) code path triggers. There shouldn't
> > > be any spamming.
> > >
> > > Thanks!
> > >
> >
> > [snip]
> >
> > Ugh trying this locally and trying to repro now (and not succeeding
> > unfortunately), and I realise that _does_ spam because apparently it's very
> > common with steam to be call_mmap()'ing things into VM_PFNMAP (who knew).
> >
> > Can you try this instead? Thanks!
> >
> > ----8<----
> > From e69b8c05daa20921bd86ef604982297bd2ced663 Mon Sep 17 00:00:00 2001
> > From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Date: Wed, 2 Oct 2024 13:04:55 +0100
> > Subject: [PATCH] ljs: add hacky log output
> >
> > ---
> >  mm/mmap.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index dd4b35a25aeb..e513eb3721a3 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1463,11 +1463,18 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		 * vma again as we may succeed this time.
> >  		 */
> >  		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
> > +			unsigned long ljs_start = vma->vm_start;
> > +			unsigned long ljs_end = vma->vm_end;
> > +
> >  			vmg.flags = vma->vm_flags;
> > +
> >  			/* If this fails, state is reset ready for a reattempt. */
> >  			merge = vma_merge_new_range(&vmg);
> >
> >  			if (merge) {
> > +				pr_err("LJS: HIT CASE [%lx, %lx) -> [%lx, %lx) orig flags=[%lu] flags=[%lu]\n",
> > +				       ljs_start, ljs_end, vma->vm_start, vma->vm_end, vm_flags, vma->vm_flags);
> > +
> >  				/*
> >  				 * ->mmap() can change vma->vm_file and fput
> >  				 * the original file. So fput the vma->vm_file
> > --
> > 2.46.2
>
> This gives no output.
>
> Bert Karwatzki
>

OK, kind of expected it seems like at this point.

Current status - I litearlly cannot repro this even doing exactly what you're
doing, so I wonder if your exact GPU or a file system you're using or something
is a factor here and there's something which implements a custom .mmap callback
or vm_ops->close() that is somehow interfacing with this, or if this being a
file thing is somehow a factor.

Recreating the scenario as best I can with anon mappings, it seems immediately
before it triggers we are in the position on the left in the range with the
problematic node, and then immediately after we are in the right (plus an
invalid entry/pivot for 0x68000000).

The final action that triggers the problem is mapping [0x1b90000, 0x1bae000)
PROT_NONE, MAP_RESERVE which merges with A and D, and we unmap B and C:

01740000-017c0000 ---p 00000000 00:00 0       01740000-017c0000 ---p 00000000 00:00 0
017c0000-01b40000 rw-p 00000000 00:00 0	      017c0000-01b40000 rw-p 00000000 00:00 0
01b40000-01b50000 ---p 00000000 00:00 0	      01b40000-01b50000 ---p 00000000 00:00 0
01b50000-01b56000 rw-p 00000000 00:00 0	      01b50000-01b56000 rw-p 00000000 00:00 0
01b56000-01b60000 ---p 00000000 00:00 0	      01b56000-01b60000 ---p 00000000 00:00 0
01b60000-01b70000 ---p 00000000 00:00 0	      01b60000-01b70000 ---p 00000000 00:00 0
01b70000-01b80000 ---p 00000000 00:00 0	      01b70000-01b80000 ---p 00000000 00:00 0
01b80000-01b86000 rw-p 00000000 00:00 0	      01b80000-01b86000 rw-p 00000000 00:00 0
01b86000-01b90000 ---p 00000000 00:00 0 * A   01b86000-68000000 ---p 00000000 00:00 0
01b90000-01b91000 rwxp 00000000 00:00 0 * B   < invalid 0x68000000 entry/pivot >
01b91000-01bae000 rw-p 00000000 00:00 0 * C
01bae000-68000000 ---p 00000000 00:00 0 * D

It seems based on some of the VMA flags that we _must_ be mapping files here,
e.g. some have VM_EXEC and others are mising VM_MAYREAD which indicates a
read-only file mapping. Probably given low addresses we are setting up a binary
set of mappings or such? Would align with PROT_NONE mappings also.

This really makes me think, combined with the fact I really _cannot_ repro this
(on intel GPU hardware and ext4 file system) that there are some 'special'
mappings going on here.

The fact we're unmapping 2 VMAs and then removing a final one in a merge does
suggest something is going wrong in the interaction between these two events.

I wonder if the merge logic is possibly struggling with the (detached but
present) VMAs still being there as we try to expand an existing VMA?

Though my money's on a call_mmap() or .close() call doing something weird here.

Investigation carries on...

