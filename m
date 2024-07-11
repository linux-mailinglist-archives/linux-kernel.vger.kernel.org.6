Return-Path: <linux-kernel+bounces-249442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C260992EBCC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDFE2858F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDCF16A93F;
	Thu, 11 Jul 2024 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="myvYcZ1x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u6ts49pY"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8062C158216
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712357; cv=fail; b=LbyazQAi/Q5IdZ0FKF6BAI7Lo055TsV8SY0LCjzn04mHvtspzP4hCui2PIcDJY43xSRTelCHU3+ITkdr1XJuzqLFf62PreXCBfHq1Ca1ikiaMeaEmKRMl+hKSdgB6Fb3TRWON58rVfWU8fsY++clZQhvvCene8Ftm9rEBkehSjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712357; c=relaxed/simple;
	bh=fGo80exa+9PUT2T43V3Snbiii8OZegVgkujpjX+BLQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lQtHgKwvU/ZcXTByA9r+kTD2vALIqG7ZYLAOwtSjXmtMt1iThHsEKw0l+QF5nO4Zbt7OHTT5tDzji7my3UWXSXEFwRZto0coQw5mMCbxO7AbiC9ZsLVmxnPgQN6GzsuiZObkGOVTKs4rYMHZM9SbPG2vLZpqPEtOFdoS1l5mbgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=myvYcZ1x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u6ts49pY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BFBXeI010306;
	Thu, 11 Jul 2024 15:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=yNuEwOan55I1SE9
	t8MUlaS1mSqT1DMFJxS+49Cw9Mtw=; b=myvYcZ1x92pJweQaTMQdVDpjCSFOIde
	4uik33Gn3KfFAKOiWU8Eqq0Z5VSty24VpxUqs6J1W+lomSG9dD+pvv64XcmoDl+B
	L4oU/fie0J26ZDyZ8f2wPfKgGOlOKhHe4q5jH3ZAfNC9W6cDLhXzj9EJ+DQnIXtg
	DdGoww+saBc2w3LmjNgACj3w1PkCnIfX0PGdQC79KmY1V+VPdgv/FiXMrGy/MVR+
	UhupM+s334FinwL/2J3DTdAoMdSLX/w6lYIzr6/8jxyY2fdTqPEbPYnKZ9nO0r1J
	xYyCCOjd6TYeaiGeYJ0YcvUQn09NmYvjpzWgGGPyQV3a9HBiABZ9oWQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8huk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 15:39:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BEeGCM028764;
	Thu, 11 Jul 2024 15:38:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv567sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 15:38:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmnzp5Pa65kAbgOGou0sDDjVrlMRU4Fjpxz8/qpxMsVqStRDjwO7bKy2dMYwu0bx/w5UeDgbfuyodEHRj8TBk9I95RQDAV12W7ST/LsPuKbsfS0F5od/bHBeg4h/pNQL4gtXgTh5RbJbOQWA/Cn7tEMG7wLc4/uoZ7esTwLNq1xJW/cuZFrbRM/espi2A7r8/cZPOJslqGOy2kbqcMok+px686p40KcPBP21uuW/MSuCCbQ4o5z0ZtW73Iqvu3nIGnXl4zZirIWFrUy32tldrs4XAodLv3gc67ZyJ2CjHE64JVnnEH0NlxNUz04VgYZPhy5aRN23Z/UKrFb27LGtLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNuEwOan55I1SE9t8MUlaS1mSqT1DMFJxS+49Cw9Mtw=;
 b=p51nXxLNutCVAQLd++WEyySJ3XuAbw+p9YD1s9b5biy1cVnKofP+QYVBu7KS1N6KvTdoiiaUIm6A3Hwx7UyJ9VTktgR+5sl7Q3pCY/NKK29vekSHfzINCr+08IR96DN/qiJTIAzygnFLXn2KxUPRyxRV2IwLQZ3033t7zrxZ9/NExeMjAH/9I+pdHplzRnisvFRcUVuEF+xgAmO2rVO/ZMi+0wIkHVeIP3bwMxU/P04pPHiiVwoOTxGqevsms8LUcbWB/SJqBcSP36GN2GHDxk3vVsMijTy8sBrpyYd0Xs50fMSgcE5oE+jo0G1pylgn7jn99KW0ulidW/2xwqDAEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNuEwOan55I1SE9t8MUlaS1mSqT1DMFJxS+49Cw9Mtw=;
 b=u6ts49pYnP+dcrgOOFeSkYuU4MdtvmnpvhIZfnSproFbjmEK4pjiRQ5BHULz7LA1NdSSPcPuShuNGRoudppojpghQ2udFjOjke2KSGfDnhK3mUaDXRlvrnVL4+YoKm2FNs3+HLvJFjf0i1nCo274YHOqk7BPIz0nrRaZL+oW+8M=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ0PR10MB4800.namprd10.prod.outlook.com (2603:10b6:a03:2da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.39; Thu, 11 Jul
 2024 15:38:57 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 15:38:57 +0000
Date: Thu, 11 Jul 2024 16:38:53 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 20/21] mm/mmap: Move may_expand_vm() check in
 mmap_region()
Message-ID: <5a2a4443-d6ef-4410-984b-9660980a7fc9@lucifer.local>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
 <20240710192250.4114783-21-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710192250.4114783-21-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P265CA0288.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ0PR10MB4800:EE_
X-MS-Office365-Filtering-Correlation-Id: 50113a9a-b23f-4a72-2ad6-08dca1bf93f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ErLC3cNUPIaC2SpxG/1yj5Qe/zyJsoLb9WBQuIrYNld3MqYCwLBb7n3E2nWK?=
 =?us-ascii?Q?wsMgNm4zoWfjufGMK1ZiEypjqmSrQoqeLCgIRo4Fqh1k5xb+/YSAcgS8l+nY?=
 =?us-ascii?Q?9KvWlowj9HAFRDXVGlbVfbRz1KmPtbnWnG5CyiyPlk5x2y6OUKTqO/SUy5IK?=
 =?us-ascii?Q?5LsnEudTfq4T5J6upjuMPdovU7oAmtozMEd4kBUKul8Y1J42JVttt8cCSAiS?=
 =?us-ascii?Q?THhkT/8twJSJJXPnTzuc1J5XCds1CAODfoPvT4KvyGrAOg6cNcSga8TbGNec?=
 =?us-ascii?Q?JMNxJEeBn6yzp4O5PUED9AMGtAuefyTxoF6CORheEjpxY28UymYgmbR/oDVh?=
 =?us-ascii?Q?JGhtEfafDXKyF08Ml6EKXqrE7Qrjf7LB8DfSaS3P6n2RIgCO5/s0yY1NtnmM?=
 =?us-ascii?Q?IfRzRXg73KaeNZvg5mAQTYIFQp8iWTWM4n4uJb/46feyQqn1L0Bt9eMd+HR+?=
 =?us-ascii?Q?EYMhk9/gzKeThefIWwDbF21wKD5XGc6dWuS6GkoYExQzYvOkgHAAAn8SzG+R?=
 =?us-ascii?Q?5JOjVjFC+OR9lLV4dC3Oql4B5N2pJppVSLCLOa8rgJs8+MmWhVSPa9XAnytf?=
 =?us-ascii?Q?Oj4Qx6Oqztt79w32JGK9CV0Ysaxj97jNOJnxM5peKJEF88IUJaB7QILog4+z?=
 =?us-ascii?Q?HnivetixYNq/OxPA3jvvm1EkAHvS9GhCSmBE9GeA8FYCRwg6oShZL0m7gwas?=
 =?us-ascii?Q?WEXpq1yPxpvBubUbEmlMh6+cZTjEzIplATbmNUZwU1JBXEo3htmfF+zOSPLf?=
 =?us-ascii?Q?1Y5bokKvt0P/xNd0oK8hkdO1WWyAyJhSJ75XSPJjAaw3IgUo1T/EdL9J/7wM?=
 =?us-ascii?Q?3vhuo4F2KS9FsRIPfsfkzIswapZVUIu5TUdUdwuZ7zSewr+t2vJm/zfCzGtE?=
 =?us-ascii?Q?orXw0mNcbG7CsiXA1JeAWi1J6g1lLEfXckH217U6hddiX7Z49pQp/nO1R+6i?=
 =?us-ascii?Q?fJ3kvAUQfwpuqGvcKmEYbMRQKuIQTVsWVhevhZvAXgg4v02dma/E3cDMag0y?=
 =?us-ascii?Q?Xe+Fm149T9O7IY94iosLhiVEvs7bDJzprfAoSz85WglmNtjfv4ptjL5zGfwy?=
 =?us-ascii?Q?rq+lwSJqA5hc87e1EdvoisN4N1a+kFCFzBx4+FW8ktASKeKaF5Of5le1T/cr?=
 =?us-ascii?Q?JUGgB0QTmzhhGpS+38kIX1EGM25bTcA4kC7DahXOCLcVAspuwMRrdt5pdn2G?=
 =?us-ascii?Q?sVgS0x4sgtaJNXNClSd+XD6e/7jnAZX4VxFPWHOCHV9BnI9craGjTJhcBfDF?=
 =?us-ascii?Q?4CPE6VlRc+xzo8SkP/vL/xs41KVe28vh7jse5CjaXSvWpmqVmpMLh09KI1dn?=
 =?us-ascii?Q?rYd77337MQbZ7r/m8IDb6A3rAy4Uxc2HtOkBUTD3tdhgDg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KsPoE7N8ZqAEZnhI0HIemu7THNpX6J5HE0EZ/kv4CDaPcfbR5rRhBNwlgk5j?=
 =?us-ascii?Q?Sy/r7qk7r9rOJ8xnp9ROfcOUlPmPWsVwiFvFqEcG+Vk1KQ9RO2PgvEo9qUra?=
 =?us-ascii?Q?Zs6901G6EWNQ0F4pn54DVcuHOiH3vWkJMR2VVH+ZfBaSMXPzxUcqyBpK189/?=
 =?us-ascii?Q?g7wmbUsLSPnmWDTsfoxr7lNL1IKQBc530Z+7ukf0/SwkrCh6rI21wJ29LVBy?=
 =?us-ascii?Q?qTbk2Xzn789DA5eYuPvVTaX35efi3MhtYAPUm4y8P/rxXZHcHvrg7lXg9mA7?=
 =?us-ascii?Q?jRlw4duTpghZTKesAgjWdo4NJPMyoYPUJnskFYxaveYnbo5hwAx5EbsZkIK4?=
 =?us-ascii?Q?b+Fws1Q2C+VkWcAfXlODvxg8p+5TsHFsdJxvOV3VWK73yHI0GCJvRtt9CAMD?=
 =?us-ascii?Q?nOQ9Xgwa41q8BsZMx9NZhenykWxUBDUv8ykjp4H87Z6xRU++tGkFUks0KEMl?=
 =?us-ascii?Q?CNjhRsCQWoqSdZrbUy5KtFg/B59CbEhbjllgYwk0ivUYxZBLUxRIixRz6o4f?=
 =?us-ascii?Q?YEd3CVWxSqCdEBeU7xQjnSdZth9GJaZjre2DTQFo/mp/zCjRgOzBTMzMdwRh?=
 =?us-ascii?Q?VxJFJoZqDaI8shj9F5aR5iZD1CeATr4icjeV7ZcRj/ldEcaZoVIXKMlYOeyK?=
 =?us-ascii?Q?JU0EQJUSzawfVcWkKE99jHC6EehgbNyMD0zL7PxCQmyRidutGPCLTzgYCIoJ?=
 =?us-ascii?Q?L4Je4+YOav6hsyadJ17wJcUm70/ka+OI9XH4jwJNL9pjQQ0fxCZHShua709i?=
 =?us-ascii?Q?0FJSzugHfxWe27lXaNA00/kcfAnj05x8wzahMdZCeAhuCYfRXaDDXJvsCUgx?=
 =?us-ascii?Q?huCIOeVklWL/h3rmrIjrylqKCNKrNs9SUqHl4LEE6M3PbSm88UV8VkllWcJX?=
 =?us-ascii?Q?VRxnmVHB1oYiWi4sRDiE/1lZaC/3UOc2GB70F//pxoatFE6y6R82QdOjwxTF?=
 =?us-ascii?Q?LwldroFK9ijpfyLgnsBG4hiRO+B/WP2qgKP8uAh23ya5LQaxJmA86wbBJezX?=
 =?us-ascii?Q?EEhmCe5zixsc6vZM8YyDJRII3XBLqRDIKCIdzxVyDAEIcCAb3+cJY4QpGRoz?=
 =?us-ascii?Q?US/mOx6bwp1TvWZvq+4mcwZJDq08wIc5UCzEulsw6sqD3vLEheng3nDIsQAu?=
 =?us-ascii?Q?9tV676bzyeH0Ad0rtkhx6h7kxlwH6pOLVrDExQVdoqELhqWh2a0zzZ1Cx0JW?=
 =?us-ascii?Q?Szzazd+srqPs6W0BWQJGkrTP+T7zrrUKql9ZIhDM93c7uLy5VNb6g1PgS2Vv?=
 =?us-ascii?Q?yZZEk0Bf/ROk3dwMmxpT80vE5xdVXWfOrZ7dmZ6FS1hyomZXmbn1zoS5u2Wp?=
 =?us-ascii?Q?8A7YSEb1HgyVaFrZSnV36BaeEKm3QyO8EJ9w8OPktChA2kltjalLvh8Z6lyF?=
 =?us-ascii?Q?djUVsfqXKbVm1adon3tBA+PRPgiBEL60aOmHuSmMD+HNxwb6YfJc1doVDi8p?=
 =?us-ascii?Q?qYjEgRsSlOYDvjMhZnSu+tpP46GxbUzApwziJtpvF9PKJUq95MRB+rxTsXks?=
 =?us-ascii?Q?RBrfqp88ipk02qbGdhW8TIxRAX083WCQDXgOqcWlJeaEoKu4yzSliehUkh1X?=
 =?us-ascii?Q?tUAQRQvNcy0ApS2pFyY8OVdCjiNLdSAZpoAwB18s7S0dIELREDw2YYz2hwYh?=
 =?us-ascii?Q?zb/b++jYAaQaT9rGowI5e8HS39rcQZkIvP12LZ+brnnUtriGatunhzrZONH4?=
 =?us-ascii?Q?m+ColQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1XKw1Io0B4DU+tBGNK+sz45vZxCcM8AYS28oxHpTcQERAehESiKACoo/b7XPM1u58aK7Z36uyAk3EKy6hoymnezSmwZjSOPCMzZFWSxXGwUPoLb1dBhFDhDql6IdU05aHvYfSyi4MvLdAuPjW+GiuW+UcboB4vQi3CFw6AKsXDEZPauMFWfpxeUvxjgWD3vJz4E0ZeusHekJEsvEKL9aA6N2rAgWPPbgnEKZjGUd85HkFRzQyA5m9hJKPMWb251zauJPKRuZ813jM1F2ZA+Y+EvOagQOqDBWZavA2qFo304luKo4t4gnk5bko3Z5ngLzowtE15G+3kCKRhPtpEovhJPSj+z556e8SobaRjxjQFJg/yfmn7CdBt8lOIeHY9eSZSIIfbSiCfB59H7D4KtiiTCWO1La+dSxdgEVK2LrzZ91HndgFNY/Lpjd5Nf9t0qLVwhr9ftuUdEykThcPPqJsvgodnQgfCbAoH7OmPxVTCNoNthPDysc9D/aNqoG9FrITQD7q/ObqZmEy8cDh/oPkunwjkIb/TnlAoGgsxcjNtq7W4/fNlVDOsW2GgDtKVCkLTTRHRHo/Y5ag982/8I8D1bEMBP5CxLlr6lNL46VTMI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50113a9a-b23f-4a72-2ad6-08dca1bf93f8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 15:38:57.4096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLx5iAwGV7OYOiSvgW5Gce3pfbJ2kEJ8xJuo+MNsp65CChMiLRyQx+2Em/SBNKOTn82j4QXJp6+LVKUsFe/Z+TUcx//vphaDpWFAv/qiCi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4800
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_11,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110110
X-Proofpoint-GUID: MX-9zCyBhg6ugyQIjdXDN4HuTfJywFa2
X-Proofpoint-ORIG-GUID: MX-9zCyBhg6ugyQIjdXDN4HuTfJywFa2

On Wed, Jul 10, 2024 at 03:22:49PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> The MAP_FIXED page count is available after the vms_gather_munmap_vmas()
> call, so use it instead of looping over the vmas twice.

This commit message doesn't explain the 'Move may_expand_vm()' part of this
change which is the patch's subject. Should add a little blurb about that.

>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mmap.c | 36 ++++--------------------------------
>  1 file changed, 4 insertions(+), 32 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 18c269bf8703..7a440e7da55a 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -401,27 +401,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
>  		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
>  }
>
> -static unsigned long count_vma_pages_range(struct mm_struct *mm,
> -		unsigned long addr, unsigned long end,
> -		unsigned long *nr_accounted)
> -{
> -	VMA_ITERATOR(vmi, mm, addr);
> -	struct vm_area_struct *vma;
> -	unsigned long nr_pages = 0;
> -
> -	*nr_accounted = 0;
> -	for_each_vma_range(vmi, vma, end) {
> -		unsigned long vm_start = max(addr, vma->vm_start);
> -		unsigned long vm_end = min(end, vma->vm_end);
> -
> -		nr_pages += PHYS_PFN(vm_end - vm_start);
> -		if (vma->vm_flags & VM_ACCOUNT)
> -			*nr_accounted += PHYS_PFN(vm_end - vm_start);
> -	}
> -
> -	return nr_pages;
> -}
> -
>  static void __vma_link_file(struct vm_area_struct *vma,
>  			    struct address_space *mapping)
>  {
> @@ -2949,17 +2928,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	pgoff_t vm_pgoff;
>  	int error = -ENOMEM;
>  	VMA_ITERATOR(vmi, mm, addr);
> -	unsigned long nr_pages, nr_accounted;
> -
> -	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
> -
> -	/*
> -	 * Check against address space limit.
> -	 * MAP_FIXED may remove pages of mappings that intersects with requested
> -	 * mapping. Account for the pages it would unmap.
> -	 */
> -	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
> -		return -ENOMEM;
>
>
>  	/* Find the first overlapping VMA */
> @@ -2987,6 +2955,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  			vma_iter_next_range(&vmi);
>  	}
>
> +	/* Check against address space limit. */
> +	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages))
> +		goto abort_munmap;
> +
>  	/*
>  	 * Private writable mapping: check memory availability
>  	 */
> --
> 2.43.0
>

This is fine though as discussed previously, though obviously need to think
about the arch_unmap() bit :)

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

