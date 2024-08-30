Return-Path: <linux-kernel+bounces-309301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CD69668B3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2A128496B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CE81BBBF3;
	Fri, 30 Aug 2024 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ObaODdsq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0ESL5jkn"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6287714F135
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725041454; cv=fail; b=HWCcuIXww49qEN6mvyViGtyuBihT6VSSuCRVNLMts5TdZdHickMaflZHYOfII9tNOJAFOhDU7rAudM2CP6MS04kq5oqe/pTWorX0vtBTEOATty7YRTve+/SXIR28pNq2M9Z9S7YefoXX/3qergKzwDo0iwc3/SchQSWJ9UjAHoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725041454; c=relaxed/simple;
	bh=VUKYQfJi8enTzVZNhAa4mp0YMzVctFqGPfKVL44odC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hxkQuo5EgDTvphbH3QyGn6Og4nTvuexUEckXa5Me0skxuKRmj7qz12a4JZYXK/bIjsdkLWg3i5NNiGMbcGaWlpX8jQAYQjM8214APm9sOdxFsDRIhpK3l9e9Mf1VTbXnW3bA74tXEvm7kv4PCoJ0QVycHRYwy0ezDYb731CwjV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ObaODdsq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0ESL5jkn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UI0vqD014643;
	Fri, 30 Aug 2024 18:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=KkDCSnLOZ9k4Q/SaEpmKIFX3tcyvYD+Phu0byEbcyYA=; b=
	ObaODdsqOdT+0LmL2C8swKHhZPJlAbMDHHZMHiu7RasxWoIIYj4/rBbyHMCwKGOm
	x3wmwwV0bkA8gLtOZ9XZQSLMjsWuoQMfR/qq/pt4z1uPJHFud1gAGLoC7Rk0bitN
	j55FUqNHzgCAxQDhHOdj2snSq3RvdZ8g5bANgnU44XgUIUa+e4+eTKdTVzaNNUZd
	QBpqaU/exGy/8mrCRkQMoMThGtMDNpmPADIamVWjlxCcAK53wQucGWaEUgLrDFz9
	ColA4UM73NLgUDmb12jca09aXpMsF/90ztYam4UuNmgOF9B9fr8QL10U69LNYzT+
	a9oxLqq+mJftkuONfMuiSw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41baa916xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:10:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UH3YL4017019;
	Fri, 30 Aug 2024 18:10:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5wru36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:10:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIo3O3aqF6QfDCkECMRlCJdr9sbKHTP3Ud+F2d1BTo+jw+TbnX4YzFsHEuhWJ7PehRcJgJEAo1Cbw9pi3pGCpRmQFx2vyvzCRabEHYW4VR9JvC1gTanZdVPthv2WNLOaMr+yT5xRtC17gKZEQGjeHdu/x7l2XhmKo/qqK5borALlbu3TtHrzx43FtQdud5BIfyCiXJcXATCg45QPuveE4HCVd5eKunlhj9veqX3eZ/c5DW3GGK3RKv1pRzAje8IgTOZ3OesR1EZutgUfXbkN22N4TkjSOciSQafX2gPpF4e3LcAo9dq6vjbLVRUGB+5eILQZ875hbQN8KjZPACz4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkDCSnLOZ9k4Q/SaEpmKIFX3tcyvYD+Phu0byEbcyYA=;
 b=rzi57gSfvBQyOEyUeYiWZH3Bijkbogxmuz5X6c1Krn6HWBo1HmdHGaqv9a7fYOdR4ZzALqpw5ZJk+KDYvDO/CcXdlyG1bDwTNpi9WQnJcRUr6UUjnmol5s1YSV9d6brbciZv8qPttzUdxBqhhTQySj636epSMyfiFFjudP+tm+5qgvT4J+r9FyRJuL6J27Ee83/9HkLrzvR8BgewDjqjqtaChl6J+c1cVaoNniN5pqhxgZguX2DEAPOlQABz8mQtpCg54/i9jzWr3C6Ydp0Xx0CKRugcgT7S6sV3iJ3ccEEazSOj6bVTGAV6OvY3vauJ22bqIMaCHy/ZeHif5i+ekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkDCSnLOZ9k4Q/SaEpmKIFX3tcyvYD+Phu0byEbcyYA=;
 b=0ESL5jknKBJWqJuST8CURoMl2MEMaFk59FVKKj9J5LEuPT7Gzm/kEUZi/xSgT25o6LlfuAq5/hMEC2NnRofazzwNe81jZ2ub0gx3MKrHqJt7jV3yzY+bL1SSoEXuahq0Sw1S/+eIVzv1JoAjr0lMxXriivnx4HkvPlqi/O5HLp8=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB7151.namprd10.prod.outlook.com (2603:10b6:8:dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 18:10:39 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 18:10:39 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 04/10] mm: remove duplicated open-coded VMA policy check
Date: Fri, 30 Aug 2024 19:10:16 +0100
Message-ID: <0dbff286d9c4988333bc6f4ff3734cb95dd5410a.1725040657.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725040657.git.lorenzo.stoakes@oracle.com>
References: <cover.1725040657.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0229.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: 791e46da-238a-4b2a-7db1-08dcc91f0da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?//7WldP5RQ2O9S4elLNi/OlSfbEMdOOXsOpZKi82X28rXH6hcFivHKbTrHQP?=
 =?us-ascii?Q?2Z3UPLJRTMG0Le63roNf8YBuJur3MCSqRPTjAHd2LbvYstdsFJODfbgS2vxq?=
 =?us-ascii?Q?IvjjsSacOAV9ChKymF/vGHxu7kKI0SrcUCDvd1XPD+JTdsSbbTb5+HxaJQFr?=
 =?us-ascii?Q?F2ysH6wTvhemje18IRMLUHyDG/8qkxaQxz1KE02seGF+4kqY4EdhS8uZYAUe?=
 =?us-ascii?Q?0uV86Vr1tbCS06zINv71mCgQQTI6mp2EXn+Kjd/x9tH1sPcCn8rYF4WHB+HL?=
 =?us-ascii?Q?URQnKcnBe1qVtBFdmdioK4CzZ1bIWaUu6lB2D9UKLFKNQij/Unpq67nTnnv4?=
 =?us-ascii?Q?ezStzIBuCXzjDPOc9yLlKWKHO5qytoL/2oz/7hTpp4hV2UzRhmCq6yUywOlb?=
 =?us-ascii?Q?KWWCj5HgF946HoaO6Ap6KFRYkWJ2nb2qkW95rJma1DEpSwcQ3NfdT8XvgvoO?=
 =?us-ascii?Q?g7DPyDc4Eb9SmlnRLYiscvhqLvnVcDaQ/GRDBlT3dAnhffqQRjtaKrU1Ho42?=
 =?us-ascii?Q?m6FQkXbNuR+XKbTzCjFiNEG/fFi2OOZRqwhM8gLfvOf90IB6U616YlYSHug3?=
 =?us-ascii?Q?02nv6TAstmVEkXj2antRylvBwuIdiPvukEzA+Piml4rhgGDLN+fEQS4zYinU?=
 =?us-ascii?Q?W1/GxnHe99+TLvYVUABwmCFSrZR/4Oqg+dzRpaEXn1wsY6+AV3Zc1SmOLBoN?=
 =?us-ascii?Q?Zbfn+kvRp81QGBzynqRNhVoXeu7DZ1hecCYHjmxe7NMQ12K8B5suP3OuHhhw?=
 =?us-ascii?Q?hpW7HKuh77QIv2xnW+gt7nIBYq6NuJvW73E/NER+5N2SZPGj05S59prWOhR1?=
 =?us-ascii?Q?a1SuE1u0H3/ICwGyoX0+dLl76tvdPOV3iARH7VXFi7JxvQpO4nyPMxhUmPVb?=
 =?us-ascii?Q?+DIk3s5SupLGm6KV8ytu5ZIgXn2m+C0bPLJ+p0ufztsE9ViYuBKDVDjOm/Gh?=
 =?us-ascii?Q?oU6WZAO/Xg8VP1DYdFw0iPdnHBN71HMJ4HlUZngw6DHoY0p4/VqGZX63Ix9l?=
 =?us-ascii?Q?Rv0Mkn/z3r2idADNpeAnyY2N2tlRbhX7wpMSJHIQytbWpmet8QTL/i4CiFGx?=
 =?us-ascii?Q?85LKN/QgHOpA9/dQYZYqt7HG3O/aiM90elURqlfwTU+5jIIDT2gvpWGcgoh3?=
 =?us-ascii?Q?4707/pY2srGNi6KOfZD56h9yXHsF/KnMlx9msjI9waSpU+dLvybEttMQuZEH?=
 =?us-ascii?Q?i8k0Qjw49VccLLs82oZEfWtzDH1S9VOdwi+SEhKzHRLAja4CcS6YktN0NpcP?=
 =?us-ascii?Q?XDUjMDC4PplPZeiuOC9yDoB+YcB9OuwDBLg8qHsociuXrsjZdzA/WGRAeeOR?=
 =?us-ascii?Q?3sn9JCNDHXUptMr7oN8jtGW1LvxnwmPj+e8LzCPZqRpCZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jp6TOHKF1/8bw+TDFQjAJ63xT0y5CEecbs0QR9yP/P8eGwy92O5Dambmwhu5?=
 =?us-ascii?Q?b/at/7pvsY+oYMM5fZ03fDU/wPvDojB8L5x1hyNhI2+KZXBXKpnJsbSO30cl?=
 =?us-ascii?Q?aLFprRjXPHGkUg3nKcb3Dl9ycGAegRGTRNRLQCbpiVPOZZ54t4t3HeZRN2PQ?=
 =?us-ascii?Q?eOa0cWxQz4wjtTCMqDENIYmK4i59XQX+pWzku624vw01+TS7de76MkGGPTn0?=
 =?us-ascii?Q?Uxyf4VqWM58zF1yfYfP54ur9FcPj1dNML08uI3fp013gsW+kuGscHm7lmhZL?=
 =?us-ascii?Q?Ljb2h2bxkWDyvwWTjCzxVFHRBAcHp/Crrzzk0QA9ZqM6klB8xCLUbYlCnxIL?=
 =?us-ascii?Q?Vzm5tHVCZYPIONSa+wsbA+w82/0OtNh2oaKqtSgqlN5dTg6NT17hxF+OHiQ8?=
 =?us-ascii?Q?n+xFcxkg8GvksGP8z7omUrAbS8Vq/UaXSxYQRgW+3py4OUXU9Cc2Oucre4QH?=
 =?us-ascii?Q?iF6cU5Qz7mv8TjTSc75vs8EFE4O+1Lq59vzOzEfSvAp1YoPC9e0/s59oMbpM?=
 =?us-ascii?Q?O0iLpEDAcHSxemed1Zv0+RLZnnzHCDM2wLw41biblDU/vCPhz7Yq9APpJaxl?=
 =?us-ascii?Q?jAjt7kHfjISPUHn0f9HSuYzVFSTHyr6ARy9/wtUvDmTrmeddedvNHof3ae75?=
 =?us-ascii?Q?Gwoz+cdhoT+mJNIF99i1NZfYEQqIV59fbF7oiFKX2Cb8xhd5R7OzVtbh7HIk?=
 =?us-ascii?Q?NuOEuw8g7FQH6TrBfG2hgR0vYbDoLn37lJClF/IJp6ZtbRsWDDK9iIAoSs/8?=
 =?us-ascii?Q?Mstz3NK+JVcscfPPwsFedhP1D7sjnv6uvSSYdfguY40FeeqmQIt+LJQqnOfn?=
 =?us-ascii?Q?0Nmch1PZ4zSAevH3XEhCJuqHX1GbcNfH769Le5NkWdprNEz7l6M4mvlqOi6g?=
 =?us-ascii?Q?pSv1tvL0PepgG9lFLtqHTpmZjtA9eG9qAZ7TEqsJcc9I5syA7SuESCeNd8f5?=
 =?us-ascii?Q?jwvXV5hrAObvuu7XtS01M/OwR3d2PWK0QDAjFANSvsD7ElVytyh9S0/nBF5K?=
 =?us-ascii?Q?5sTOafCFZAf6+F8YRoMpsyXzt0Kabo9cSsawKoSGtZ3mNwg4L58RIZ6DSqn1?=
 =?us-ascii?Q?9TomcgjSHO7WnSxg6IxiFr0myPjHysoPSO5pWtLUwLOUz+e0om223s9N1iZT?=
 =?us-ascii?Q?xzLZ2tG26Ml35dWpEJiUWEYbCxiOG4kxVrnMCHxB14cGZ3BzkR+RtMZUjZTc?=
 =?us-ascii?Q?e+O4j/Os7tE2eW02HyGOb8pyzC4ytl7PqwHDc7yD/MRc/LiKOXhaTScFmvnB?=
 =?us-ascii?Q?pp0Ar8MD/kHfdagv30Br98lf9XDgZx9uflRvzv4pafokAII54KKYvd0Hh3IQ?=
 =?us-ascii?Q?2hjWbwteFEQuLgMdXQLO+IdGLkAwg6+zSDuOOId+4ZyyvyqrIcr5QU2U7Y7n?=
 =?us-ascii?Q?mM6p9IgccK/PM/9nl0/agIEXeIjDWLLDr7ZIiw8N+dLKSRNqh74Aiy3kfwD2?=
 =?us-ascii?Q?elsdNh1AtYhcWnbxZeoj86ycZZmvv4MEZy049SE+yhYEcBkNW8WelbTQFqqJ?=
 =?us-ascii?Q?6h5i0IJwOJCzhu776e/xCfj2VumaB9d6HOMGHWFnwdtks/Nc0Kx+jyFoyzGc?=
 =?us-ascii?Q?uBssa3p2OJ0+VhYt859t1ofdKrOsnS+uVNkKe6F2L0bXIK+tKkMENIlJ4nhm?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NOcC/j9dsoUUiC0f1NIhEPLCvW9m//3VDhYtkP1jT8wmno9b4NF8UodGrs7NUOYzcsCtYu58U6RBnXwOHdxu7H0lEiYiCTiEIdbMewQ8mpITVBR3IJyXh/yNQ5qU/3FW7u+KXRwu3qRJXtUh6fOLle6OMekN8IvylGqzd18JB5RqpzG6eqbq0bWZ6wxs7j00D9vSsx5bdpB60zni7WAVhU6OKjQQxRajN2dgFpSu7VlJd24jQW+IG+3HNBCt35tBwIvuzMQg8OOo4vkWrZpaAnJcBONbkVUEobUtkpk+bAG8Gqm4Q0hh7YWoVDFkSOMmXSC6eedyRDg+AElmmSYa0z8+++IJfl0EXdMWteZnoYK+3g+D7av2mUvPgU0fM3pgQltCwBPf4b5nCNKUCL4CrG1FCQ03Lh+uEfM90cLUcC1NhEf9moF194dMuK+I5FrJlhFr1R0ODWPXOgZNdDAcxjEPVa0mt98+NE94et5Z8W38LvbgkVO07hGjEiYyE313R6kJ4VsUWqO69+wv75Huug0YnfxgAIIvIjC6MYBBfrnYsa2j9ffCyiq9B328NDv79NY822iRs4xfz8jg26OjjaDhklhxDa+uEhcLUHjveG8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791e46da-238a-4b2a-7db1-08dcc91f0da0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 18:10:39.0422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtIFoaOHw/DDE12UGDnM+gQFQnNAOXujArwJXiRolpOkEBAGwpLaK16KZ9l3hobIuXZ4R0i223gizZKJnDoGrZ+SI+VboDVlR8kG1boNy2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=975
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300138
X-Proofpoint-GUID: 8pg66UQPYmTG5BwSIPdV5amyHXcM3zSd
X-Proofpoint-ORIG-GUID: 8pg66UQPYmTG5BwSIPdV5amyHXcM3zSd

Both can_vma_merge_before() and can_vma_merge_after() are invoked after
checking for compatible VMA NUMA policy, we can simply move this to
is_mergeable_vma() and abstract this altogether.

In mmap_region() we set vmg->policy to NULL, so the policy comparisons
checked in can_vma_merge_before() and can_vma_merge_after() are exactly
equivalent to !vma_policy(vmg.next) and !vma_policy(vmg.prev).

Equally, in do_brk_flags(), vmg->policy is NULL, so the
can_vma_merge_after() is checking !vma_policy(vma), as we set vmg.prev to
vma.

In vma_merge(), we compare prev and next policies with vmg->policy before
checking can_vma_merge_after() and can_vma_merge_before() respectively,
which this patch causes to be checked in precisely the same way.

This therefore maintains precisely the same logic as before, only now
abstracted into is_mergeable_vma().

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 8 +++-----
 mm/vma.c  | 9 ++++-----
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index ca9c6939638b..3af8459e4e88 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1423,8 +1423,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	/* Attempt to expand an old mapping */
 	/* Check next */
-	if (next && next->vm_start == end && !vma_policy(next) &&
-	    can_vma_merge_before(&vmg)) {
+	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {
 		merge_end = next->vm_end;
 		vma = next;
 		vmg.pgoff = next->vm_pgoff - pglen;
@@ -1438,8 +1437,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 	/* Check prev */
-	if (prev && prev->vm_end == addr && !vma_policy(prev) &&
-	    can_vma_merge_after(&vmg)) {
+	if (prev && prev->vm_end == addr && can_vma_merge_after(&vmg)) {
 		merge_start = prev->vm_start;
 		vma = prev;
 		vmg.pgoff = prev->vm_pgoff;
@@ -1779,7 +1777,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * Expand the existing vma if possible; Note that singular lists do not
 	 * occur after forking, so the expand will only happen on new VMAs.
 	 */
-	if (vma && vma->vm_end == addr && !vma_policy(vma)) {
+	if (vma && vma->vm_end == addr) {
 		VMG_STATE(vmg, mm, vmi, addr, addr + len, flags, PHYS_PFN(addr));
 
 		vmg.prev = vma;
diff --git a/mm/vma.c b/mm/vma.c
index 6be645240f07..3284bb778c3d 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -19,6 +19,8 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
 	 */
 	bool may_remove_vma = merge_next;
 
+	if (!mpol_equal(vmg->policy, vma_policy(vma)))
+		return false;
 	/*
 	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
 	 * match the flags but dirty bit -- the caller should mark
@@ -1053,17 +1055,14 @@ static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
 		vma_pgoff = prev->vm_pgoff;
 
 		/* Can we merge the predecessor? */
-		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), vmg->policy)
-		    && can_vma_merge_after(vmg)) {
-
+		if (addr == prev->vm_end && can_vma_merge_after(vmg)) {
 			merge_prev = true;
 			vma_prev(vmg->vmi);
 		}
 	}
 
 	/* Can we merge the successor? */
-	if (next && mpol_equal(vmg->policy, vma_policy(next)) &&
-	    can_vma_merge_before(vmg)) {
+	if (next && can_vma_merge_before(vmg)) {
 		merge_next = true;
 	}
 
-- 
2.46.0


