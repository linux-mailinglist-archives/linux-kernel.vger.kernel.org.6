Return-Path: <linux-kernel+bounces-274633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D581947AF1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6097FB21AF3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86CB158856;
	Mon,  5 Aug 2024 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i5j1v96r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BLPxSQOG"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE45815853F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860083; cv=fail; b=CZV5WoOX1DbDFtt3CFrKXjLE3V2DMS9TBlxzb3QPHEBiRudUCaaCUq9lTvizi8vKY64uyw+8fVXVUMmw/78+J2B8CpixzoPnm4GMh9NfjuGCkphN7BkzdJAbDSa8loHABmViXyXZJ877FcJ6dlxd9kp3aSPEc2JqBIDye9Fv8jE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860083; c=relaxed/simple;
	bh=zgNLIW3T/lhl4Y1D+VvXYYtuMa7zwTYbrDwQmgwignM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FaXsGdNOUXRzA8UfUfEh1Ed4YppjQiJDKGqrb2FsP8i5tSNWfLjoaIex67oqJmoP6BaJ/Ljk9KvFIeCINB3TSLwoub3jrYfAh/96mMXMPZq6SMjSymdvlGcbUM1xE9gXbZWTodq3pWUyfhBzageNrbHNPBDuy6n6VJ89dvgln9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i5j1v96r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BLPxSQOG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4758fW0E028157;
	Mon, 5 Aug 2024 12:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=iWgOVVMp2+tW0FhzdmTzuZixiBNib8oI0PxjDIzzFQg=; b=
	i5j1v96rGeohR2uDyEOe90dcKWhZ2BVCoMWZ/VndBgLiYHInjR1nrInwkeO/LyH+
	X4Zos/6i3sGkPidX6dLPBl9QvTKazAgOZiEJ1pB33fQ4OwQTsttlJ5XS48JXsy5E
	LnF1ODYimcjjUDk2Y4ZmkUtidh0AOIdRoyxJBOzpx1LwKxaFg1eHnBHc1lDw1s3X
	emWWtW7jB3c+cbz26QErxhR8+QJIOsCayUq4T2a7GxExq3ErVFkvBW6o/M7+5zIB
	dXu/8j71FjTGl14Lsev1IWvHQB204ybeLZ6DTg1s90FPvYzZLP6cB26aPYUI5n2F
	LUwIktVUu6JjNQfTU0VxmA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sd3uje5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 12:14:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 475Ao2iG005668;
	Mon, 5 Aug 2024 12:14:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0d6qbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 12:14:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQNIQhaKiGZ6s7ew0xZW3opvikekQOtH0p0Syovy72qX6a/3+e0qerB+psrSYOpNrOqTpX9lqNnM1EbWB3KiKtE1Xh6ASwfi66tMTWkWar5j50DG/8xmDgz3NkwPFoyq9G/ScF8Z3caZHPZFCFN08lZoLlUePOeLKF7mUaJQl1XTvwcWacduiaSmk5EHwou90SmzDKuJEYxzI0kJ9es8LVEjzjP5vmIqWK9V1/xvfSgb12Bx22AENceTxJbv3VLOc/Md6gIsmTLjwRJL9Pbp5Pc2ricuK548MkECF7zAF05QBJ/LAPw++rp4HK+7gbEWhIjNK/Fm48tWHmAUNBI+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWgOVVMp2+tW0FhzdmTzuZixiBNib8oI0PxjDIzzFQg=;
 b=dwU1za82vKDbaS3p0u4F4IlpMPko5ZKG9C6GV7uoe83wVQUUWDXHnOqOf00qAD5HaaX8TE7bozRq6sAg2qTQDduQ6rJfIrbWIf2hsjeqN/jlEMMLj5P3GQr8FuBFkI1izxx+cmHGpmOXaCsqtYIagZ454NRzAkTyvApNou8g+VE3ADbF730x2UutnCvHvqXTDgMQVocCKZvW22oXe70sWxxUSFfm/GAQCrfxRHwTH703GRaI4qN5bb1tPGCjL+ncXWFswCI2UT+LpkrflPi93XyvaoNUEdZrI7f4Agu3+Ike6UKQdDA1fcUTgKsc7xyg3NREOGEgngcC45m77m2Y0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWgOVVMp2+tW0FhzdmTzuZixiBNib8oI0PxjDIzzFQg=;
 b=BLPxSQOGw/PIP62QiORqppEuR+BaAhrXmGQmAGl4fn33C8SDsOCENK/rzKZ1aU60Z2hLbrIdpTxRSOgp93pQHibGSR6nrWO0y14gd/K3ZdylEVngQdX7pEnhrSnl6z5rl33kp9YThXVBTaJ9WH9Jee7uNU7HeKukg+oJi6BekIQ=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ2PR10MB7760.namprd10.prod.outlook.com (2603:10b6:a03:574::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:14:30 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:14:30 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 05/10] mm: abstract vma_merge_new_vma() to use vma_merge_struct
Date: Mon,  5 Aug 2024 13:13:52 +0100
Message-ID: <f4f4b5d441379b22f92d7cd188c2095198cdbc86.1722849859.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0137.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ2PR10MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1dba1d-c138-4570-c50a-08dcb54828ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kaux5jRHOhpecVd2nIYeD5B5yjhA7GR9q5mK4nshbSY5JZADKiCbDIYO+k8N?=
 =?us-ascii?Q?imCpxkSrR9La+bBK/GV4qmCKqPceJG7UQtEJCuBGMsm/5QBNNII0O2wVYxyW?=
 =?us-ascii?Q?MS8qqsf6q/FsT0GloWFT6ZbdUbidiragrEVWrznuZgkw9UaiI6WmhFfQRTy9?=
 =?us-ascii?Q?zQRXhfFzrv6Bm2eMIUib+8ng82vAe2RSaYDreV/AjrN5MO5S8GU6Ms7DQOtB?=
 =?us-ascii?Q?3EfxiuqUKZSV7Rk7wwHP2EJXBmjKKIDRuG9p1MRXsLTt/+BhQjvPYvgeEVep?=
 =?us-ascii?Q?TRXh39/6wHLAQo3WaS28IOf85NQhqhI68zJBXwi0iUAdwpD40c8SU1H1naR+?=
 =?us-ascii?Q?jIwOEYCIQKPN2UDEUDIfKXtGoDvSROXmqsXxpSYFylwrQ69Bo0SqIYe+HNPF?=
 =?us-ascii?Q?Ac8mtaeveU/zrIJ070o49BDUBBfS7SFf7hszLxhvqPjOkul6lxdxr5mzxcHj?=
 =?us-ascii?Q?r85MuNjxsNyDbcPPHwo+8NNoyYqj6CMs6r6lAq0r8tjO9oTPE3/EMeksJ48i?=
 =?us-ascii?Q?BWSmMMHtiKmhkpGDXV9O6ATTx/B1Gtswc3tIBXUuUKpZc6wFXANh6BPAJyPg?=
 =?us-ascii?Q?Fn7nI4tpBy7mcYD62nk2Z7AeURb4v3DSw1pw5eqmjvgxNEvbWutXRk3Dyh8f?=
 =?us-ascii?Q?UjifbMU7eWvfz7LGu8hV1IKNdrFPBm5Blwjdin1sj/OWup0O8z89l+1FCf7j?=
 =?us-ascii?Q?1gKIRviia59k7qbjEoZmkQeQNxXKk3CXU1xoqOMW3sFysBdhz65LJzhQxT7b?=
 =?us-ascii?Q?f+V55Dzm3KoVo5Q0QhrifQbBkwmCOLz+XsnRFDGnMptmUiBCj2SBYCek1Dly?=
 =?us-ascii?Q?Y0RNgXDgC4KYU4MphLIe3PQ8vJc+f9YnffDZlL6bpRLkkwQpIA+Jpe4xsjSH?=
 =?us-ascii?Q?FbY8Ll7msV3v8xKPMvdGgLSESIpg4tDVVDJWa7uQDlC1R0Ks0eDB/r7TgRQ2?=
 =?us-ascii?Q?WW1THEBUIs7SaP0GxQs1nns4+1Bv1o1DuZWqa4wBT6yQYI0yWCi/DGIKxHS7?=
 =?us-ascii?Q?972y3WBJkx2XEQb+XNvmz79W2vhgWg8W0JsD7im16f4i690lCdjmr/VfB184?=
 =?us-ascii?Q?XeDhXngmgedvUS6rgN6TvFzMgQXn+rW3XIj9zzqESWbznOxV0unVWCbX/RNc?=
 =?us-ascii?Q?v/MYD12Vq01ZFYVgsB1WVzlFfgKaAxET8r2b7eUZGasJselqtxfV+4na9Fbb?=
 =?us-ascii?Q?MueZCMquHPPBgNDRNm6bPZ8dIt1t8JYTXV1tj4Y/OXBD2BzBWNrycTYDcLsp?=
 =?us-ascii?Q?zbtZxINXmSyFWgILfFRyBS0aS3Mj3tD0Oc4QbEC38yUS7VErpQqVZz/O7+jL?=
 =?us-ascii?Q?ZRBUPNWOE3AUAoQmjEfOk0Op9gG7gesd95W41ZrUXyu9Pg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tt2Os9h9RbwXZk2oqyglKlUZkEgsSxjDksRyonFbYBSTXucUKIwfX18Tg2YS?=
 =?us-ascii?Q?WTKJka5NuSfGurajFkLCUVS4o+MIbcwFCIdz46aJL5niiH/Ap8qQ763NXIL4?=
 =?us-ascii?Q?GKwIH9eqEUzZ+5DEVtTJY0hTVcu7vtVDiU3ixtp04C2EWW76dYz6q4g8mzAB?=
 =?us-ascii?Q?xr8Kq4zkt+iHVuFDKw0t+VD7MlqjOLlURDnzlLUamaaQ4H2SAAVTnn6QvwPH?=
 =?us-ascii?Q?zfrZI1N40Nhp9pgJ7EJayCJ9yeO7rUHfXry87BONd8GQfINmgTIqj9Em15CH?=
 =?us-ascii?Q?oov4zt5zC0dawxXQ1sLmCgUgNfB2TgJ3OLhb17dzRVf5WH0a+UrAbKJzdCbY?=
 =?us-ascii?Q?K7mttCorJPL75afDNtDd6j1b6onVYG/P8FGPj8P4JfJn15ELIH+Jx2Y9fgcp?=
 =?us-ascii?Q?A3q0M2yl8RE8OLM8KUf9eFvOrGHZVLrJjGGtczUWHs/T9hKoCTG7fKo0xDHu?=
 =?us-ascii?Q?694ZkxtPt300eQSZkA8To/0hF7vxeBLi1nzxQSBLJ5j/TsXqEueB8NeTu85I?=
 =?us-ascii?Q?X0Cd1S7kRXTOn7L3T9MT+QbwOjbZJGqTXmE/JgVXN5eE7ZxIJ2ZEoeRZ5DKt?=
 =?us-ascii?Q?6A++PCRazicee/LqbSTChhw1TcEX2UeJLBWVUOgPWhIFQSo89S4lbX+qwxqb?=
 =?us-ascii?Q?YTbemU+p5w9nDTQP93Rh55vnzEqNsntwjYJEvWMwYH47vSH84VkxQqQqHZc1?=
 =?us-ascii?Q?+l8MJYw/UCIGxp/hY682zq39fqdqI+OFzqVkFc9hovktt2HRURp8GKnxvvmA?=
 =?us-ascii?Q?8la3oSvbAH8d3gSFpZ5n09aYYkDHY1HsVJL2rvlTMG2dHgrZ4pudE7SXt9xa?=
 =?us-ascii?Q?UL50rPgqyyAu0gNYVO7odNMcl/lAS99HbmP4dV7vjY4hq6T7D7Fnlre/7HwN?=
 =?us-ascii?Q?Vx7EMIMAFh4fyix5XSlQTAF7xWZZffVu6SPXmFRVf0UoNwl8i6Y6ScNijIZe?=
 =?us-ascii?Q?pfApQRnx/YfBsWiv6nWUN+uufeGIGGUYbeR2XnqI/6/+WDU/9ImJCOi0bUfJ?=
 =?us-ascii?Q?Lz9yexGKkcgXHDiinaOnoWFmwDsPkw4oVCYJ9IcJXSxGSo+oJ2cd63e31CGD?=
 =?us-ascii?Q?Q2LJkrzkPyflTgMG/Rgc2ZFFoGgqw7ydbzyFpQm/qd83xbutBAUcvKg6H//c?=
 =?us-ascii?Q?b3zgcPfmBHl//v0/Fe2JT4L86r4p6z/vONHuVUx417/lgthtwQUzzE+c/do9?=
 =?us-ascii?Q?YOIAcZeVO6KoQlt8PLJ28yM+MpD+slb8cqiG8l+7jO2VctQEXrUB7oJmiDXx?=
 =?us-ascii?Q?ZFl8k5kn9wxHlF1uMCM6oCzbuyX/qdQ9LklA5o7gFI3oJu7fKkw/PosNUdjQ?=
 =?us-ascii?Q?gJNSvQFFEgq1dtjFNas2449t4m4OF8VHX+5AQFyLyQ/EFfukq1oxBs+qa64j?=
 =?us-ascii?Q?xulB27/nmxksMX71well1v5Lub51Wr91lB38j13Dnr5YTGgBAWPe1Lk0WCNR?=
 =?us-ascii?Q?Pu9zMU79AArVNnErHZ3dn96DO4zzaAfTEutGfy7w4VKrigrcAk4wI3oqqOsM?=
 =?us-ascii?Q?WynVdKlGrpSO+Px1o/O0c0AKWXXGmwf109fO/WrWjdP8ZqutHRtefsg3KnxJ?=
 =?us-ascii?Q?ZDIP1VBHwZQxBb8IRr6Xu9o76g4JMgMsi8t3YJa0ISs+DyNNuH38nuKBp303?=
 =?us-ascii?Q?NUllpgbuAPrmoOeShhZ+a984UjfHW6TJxWvdHi8gIsRrMhq4rdDDpvtpOMBf?=
 =?us-ascii?Q?AudmfQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NXm/a4pLN0XeyAMdK6L+YSsVdNX+0cvWTu0QrfmJ8bEE+QuC3n9WdFsRefyl/+OpIzw51nEl5P5QGWfvlrOnaTr+Hv9DthC8GrnBe0cKHuglANzfylQckXIQ8MlOp+IYaMVU+TkNnfHzOIf2wkAjh9tAJFJIK5If1QnDsgM+WsSYnUDkjL7cBHqpuDGBxR6+PZdLFAZ2NkggaRoGnGF5V4BWQFhJOy49CN2r+qsHFAhTcOiY6cq0Zh4dHFKlUZcyRtAxRdhGg0vfYnO2tSEH/sLBxLKqfmLnG90a29lbOKRdpoN+S4GmxzrhKWg6TLzRutx9b6yAaeuXWHD9I41dXPrLuAMLir52sJJwhvCYZbmIwSupKZCoZu9+ORqPvG+V7po+MR07OKm3/oV9DQAVJjb8lZEIvJ7JmEHXBM59j+04K7D4iKd3ncXTg2vgqShSQfeZaHb7eGQpWGicZF9CtbgzAmBN8ND/MK0N8dt6PbiXXBW0CDwnOmgATbTYocwd775JWqp68JIJqSPx6Z7/p4vZJq1SjuyFS05oF9pdX3VksjwBlFmeH5vhGn09SRF9MOxTEkt1ns75doC3HI4yn6a7um+p704ZM4+lJZLyy78=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1dba1d-c138-4570-c50a-08dcb54828ca
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:14:30.7228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udmpVCuv+PVPkUqIyqUVRIfT8eQ1VbjvhpOy5T0UcVAnzywuuevc/9EGYW4yw/3Tm1dDCStNF+tVYNeEnDpRhyodOcY+16/wKubNw4hQEc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_01,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408050088
X-Proofpoint-ORIG-GUID: MOlCFEfnMt_JFrjzqmQIGRRNQRWk8jCH
X-Proofpoint-GUID: MOlCFEfnMt_JFrjzqmQIGRRNQRWk8jCH

Abstract this function to so we can write tests which use the newly
abstracted interface and maintain a stable interface for tests before/after
refactoring.

We introduce a temporary wrapper vma_merge_new_vma_wrapper() to minimise
the code changes, in a subsequent commit we will entirely refactor this
function.

We also introduce a temporary implementation of vma_merge_modified() for
the same reason - maintaining a common interface to the tests, this will be
removed when vma_merge_modified() is correctly implemented in a subsequent
commit.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c               |  6 +++---
 mm/vma.c                | 33 ++++++++++++---------------------
 mm/vma.h                | 33 ++++++++++++++++++++++++++++++---
 tools/testing/vma/vma.c | 12 ++++++++----
 4 files changed, 53 insertions(+), 31 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 04145347c245..f6593a81f73d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1494,9 +1494,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && prev)) {
-			merge = vma_merge_new_vma(&vmi, prev, vma,
-						  vma->vm_start, vma->vm_end,
-						  vma->vm_pgoff);
+			merge = vma_merge_new_vma_wrapper(&vmi, prev, vma,
+							  vma->vm_start, vma->vm_end,
+							  vma->vm_pgoff);
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
diff --git a/mm/vma.c b/mm/vma.c
index 3d6ce04f1b9c..55615392e8d2 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1106,6 +1106,11 @@ static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
 	return NULL;
 }

+struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg)
+{
+	return vma_merge(vmg);
+}
+
 /*
  * We are about to modify one or multiple of a VMA's flags, policy, userfaultfd
  * context and anonymous VMA name within the range [start, end).
@@ -1260,27 +1265,14 @@ struct vm_area_struct
  * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
  * must ensure that [start, end) does not overlap any existing VMA.
  */
-struct vm_area_struct
-*vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
-		   struct vm_area_struct *vma, unsigned long start,
-		   unsigned long end, pgoff_t pgoff)
+struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
 {
-	struct vma_merge_struct vmg = {
-		.vmi = vmi,
-		.prev = prev,
-		.vma = vma,
-		.start = start,
-		.end = end,
-		.flags = vma->vm_flags,
-		.file = vma->vm_file,
-		.anon_vma = vma->anon_vma,
-		.pgoff = pgoff,
-		.policy = vma_policy(vma),
-		.uffd_ctx = vma->vm_userfaultfd_ctx,
-		.anon_name = anon_vma_name(vma),
-	};
+	if (!vmg->prev) {
+		vmg->prev = vma_prev(vmg->vmi);
+		vma_iter_set(vmg->vmi, vmg->start);
+	}

-	return vma_merge(&vmg);
+	return vma_merge(vmg);
 }

 /*
@@ -1295,7 +1287,6 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 	struct vma_merge_struct vmg = {
 		.vmi = vmi,
 		.prev = vma,
-		.vma = vma,
 		.start = vma->vm_end,
 		.end = vma->vm_end + delta,
 		.flags = vma->vm_flags,
@@ -1425,7 +1416,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */

-	new_vma = vma_merge_new_vma(&vmi, prev, vma, addr, addr + len, pgoff);
+	new_vma = vma_merge_new_vma_wrapper(&vmi, prev, vma, addr, addr + len, pgoff);
 	if (new_vma) {
 		/*
 		 * Source vma may have been merged into new_vma
diff --git a/mm/vma.h b/mm/vma.h
index c464d25da120..50459f9e4c7f 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -134,9 +134,36 @@ struct vm_area_struct
 		       struct vm_userfaultfd_ctx new_ctx);

 struct vm_area_struct
-*vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
-		   struct vm_area_struct *vma, unsigned long start,
-		   unsigned long end, pgoff_t pgoff);
+*vma_merge_new_vma(struct vma_merge_struct *vmg);
+
+/* Temporary convenience wrapper. */
+static inline struct vm_area_struct
+*vma_merge_new_vma_wrapper(struct vma_iterator *vmi, struct vm_area_struct *prev,
+			   struct vm_area_struct *vma, unsigned long start,
+			   unsigned long end, pgoff_t pgoff)
+{
+	struct vma_merge_struct vmg = {
+		.vmi = vmi,
+		.prev = prev,
+		.start = start,
+		.end = end,
+		.flags = vma->vm_flags,
+		.file = vma->vm_file,
+		.anon_vma = vma->anon_vma,
+		.pgoff = pgoff,
+		.policy = vma_policy(vma),
+		.uffd_ctx = vma->vm_userfaultfd_ctx,
+		.anon_name = anon_vma_name(vma),
+	};
+
+	return vma_merge_new_vma(&vmg);
+}
+
+/*
+ * Temporary wrapper around vma_merge() so we can have a common interface for
+ * tests.
+ */
+struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg);

 struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 					struct vm_area_struct *vma,
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index d216e51206c1..4416cfa93056 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -53,16 +53,20 @@ static bool test_simple_merge(void)
 	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
 	struct vm_area_struct *vma_left = alloc_vma(&mm, 0, 0x1000, 0, flags);
-	struct vm_area_struct *vma_middle = alloc_vma(&mm, 0x1000, 0x2000, 1, flags);
 	struct vm_area_struct *vma_right = alloc_vma(&mm, 0x2000, 0x3000, 2, flags);
 	VMA_ITERATOR(vmi, &mm, 0x1000);
+	struct vma_merge_struct vmg = {
+		.vmi = &vmi,
+		.start = 0x1000,
+		.end = 0x2000,
+		.flags = flags,
+		.pgoff = 1,
+	};

 	ASSERT_FALSE(vma_link(&mm, vma_left));
-	ASSERT_FALSE(vma_link(&mm, vma_middle));
 	ASSERT_FALSE(vma_link(&mm, vma_right));

-	vma = vma_merge_new_vma(&vmi, vma_left, vma_middle, 0x1000,
-				0x2000, 1);
+	vma = vma_merge_new_vma(&vmg);
 	ASSERT_NE(vma, NULL);

 	ASSERT_EQ(vma->vm_start, 0);
--
2.45.2

