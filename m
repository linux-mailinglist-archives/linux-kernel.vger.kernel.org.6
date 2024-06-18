Return-Path: <linux-kernel+bounces-220167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D4790DDBB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450551C22F81
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF6A1791ED;
	Tue, 18 Jun 2024 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F2sbfQE2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NkIiNNJB"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BFC176FD6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743726; cv=fail; b=NxbFrg0wMcZLUinEPaDf+DxhD/mWx1OWhcUEOr8/3RnUqBETSRPw0bTkOvNCmN+qfvwpGMy/rYcMWvRXMt5r4OTdd5lr1uKmODiErId864Gz6xr4VCsmNsPZMjsdk14lGFSdWR5kUkNU7ywMzU1uvElNSNrzINF+j3wGgKx9CyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743726; c=relaxed/simple;
	bh=mQ3ge01/xqP5ZNvLqnLPf26PvI0gd4zI9XZqH3y7p5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S/epr60V7/sX/P8v1WMBxg3G+vd0BqtPagKC4kQKUKT3pQupuoxVL9yKfDaDzWJ1p9Bl1b79FVIcHNQK/o+4hYY3t/4R/ttP7rkEZiYRGFYuaKM8ntCPEdqFWp9ktsW72f6QFSXAVwZn8+MXbiAtmhJVFoQ+bcOLfWRMsetgclg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F2sbfQE2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NkIiNNJB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IIUxvX029821;
	Tue, 18 Jun 2024 20:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=aXmVafrvMKS4PjtIoLGPmCZF41DcIZM3Vethint/D/Q=; b=
	F2sbfQE23/Djbel1sXOVF0pMOzc/UtfrP47/oZyw8RMWc7p2r4hSV5hwCDXh8pt3
	Y24Ux5O+KEelLyuoZXbL9itv7kulkTrZNlVUO3W0VIr9RWrvnqk0daPhe9x6Nc0o
	x6WkIsyuDgR8XxQjovaloam0qCPj45eSrU+zAA0+nZfla42V97HG4za/hRLMh3+B
	HBo/a6pBzhuIakrsM9ZyR0RKMcwtFzDxphQxfGFVeYbEauylhySKdkXMzwktnJk1
	2SpH9gGH5iDH7s5r2yA2hd6Tzdr+kkc/3elwa/d3JJsX+/Hny+W1zOFc3tED3zkh
	cggCynK9HwRYg6707VKI7g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys2js5tp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IJeuRg034707;
	Tue, 18 Jun 2024 20:48:35 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d8p6p6-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRUIkU2m8CBGAlC+hQcuAe1O3v4WB9gD9WJHkrfb63v6tuMEDcqvpBwWoBx037MywY2UID1qlQhRcR7Xpb2HeoDokHCuy7/FS2u6Z4xKH/5bQ5uWQWnn/r+9ZC3/16lHO5dNaW3juv3H6thpXRVOQYNCYwP2uF3s3DDX2ivDgvOqaccKNHmVDb+Gc/K5Hushlf2R57A2swxks7/wBDyjmo1YLG7V5oIn7LgCb0PvmCC8cQ9nvGIdhqR7F3FOFpjaZmtx7ZWKRwQlubU5ywIVZasDhn1wO23r/lTSV1e6of4yvQsA5i303HrTJ+WDuYVI0g6M2tFZHRMopq18qnC/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXmVafrvMKS4PjtIoLGPmCZF41DcIZM3Vethint/D/Q=;
 b=E7dxgr6W3U+pmk8vD04w2Io+y+gxA6sV5vrD+8xiMuWxpOufM6RmV6eQizD0RboiWawOnwPGUGWh4tDgFsHFzwgz2JX3rCfwnRxO+rLudHO67sW/J+22xTDNyhIXBQ80eP/cXdtAy59V3oMBwWapRijVWWu7Vs/Bzw4K+YyFjxBY6hSwi75V022ZjesZuuPspUNJMn122e5LrS32vs5bN3PSkc8FKqPv1LD1DMCE0Qj2H59Ba28kvt4aDYyB45FC+a/cwxeaRAdSdioalyL4cRymqLHxLbQTIclQx2vspuVviuHqYJVm/9kmlLsBY8AXC+Sh/T4u8C2akPjsophVpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXmVafrvMKS4PjtIoLGPmCZF41DcIZM3Vethint/D/Q=;
 b=NkIiNNJBq9pqbyt/oACdRG/B6bDXlPJjUavDsssroD+5K64uwwD398Py4hN/gSJpFEzpfRSujVVE6R9Ej2ltNpsUViBAqMBJILl73yEFSIB6cwjZtAA8HO723VKZLfe8yxj/5aX0ZqdjkIb4Hf5gHRF+6tiso9XH3px9idYrkPU=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB5785.namprd10.prod.outlook.com (2603:10b6:a03:3d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Tue, 18 Jun
 2024 20:48:07 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 20:48:07 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 04/16] maple_tree: introduce mas_wr_store_type()
Date: Tue, 18 Jun 2024 13:47:38 -0700
Message-ID: <20240618204750.79512-5-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
References: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:a03:338::9) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d3583b-9d08-4097-33cc-08dc8fd7f556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?cvJJKWxWcqk37KfFFIGef4CRs/cQJeRDqoEV86b8i07Uj773sYfa4JheMVXg?=
 =?us-ascii?Q?h2LFGx7gAa8V4IqVQat7o6RpmKHnQuW5mzf6SNRqlRJhS3E+nJv7rw8P1NWb?=
 =?us-ascii?Q?5f5ttHKKdoILkKM4tRl9LLR/6enuINz6gIMwO4phqVAf0yJm1KEqUS34cXPQ?=
 =?us-ascii?Q?rVjSNpNo50NM6FcmakQrx/Op6ZUEP/C6lQKh26pmrFB++i2+detOdTgNb7MS?=
 =?us-ascii?Q?c1LWbtdOdsAKoDSXpcUiMTXEXNeMw+ImKnAq8g+vBRGG7h2T6YL1wQdmF6dL?=
 =?us-ascii?Q?AVyKp7j9BBR6OgFvt7J/H4ImtfDWkdB23Q+5yFOtwnr2hps6TdovykKV/t7w?=
 =?us-ascii?Q?7VZQn+3VQKZweKuxo5B11jhx5ZT5yqmcqLM6sZoAK+epRn3V+y7viUb2IWY1?=
 =?us-ascii?Q?a1CH40wMWGaFkAVD3ehrMFLvta7cSeUbIZKtLOxTfdwA4AylkcJwYrjpulks?=
 =?us-ascii?Q?H7pv/XQwYmzDiXsEIghqLjOTTaIEyDhDYSLA5u2ycsGHbaZEooqrjDaR6Nzc?=
 =?us-ascii?Q?EPZ3PeElOA5AXsnz9+7Av4ur9Ivzk+YntTbzZRrmRXks1VCvbelayf84WfJn?=
 =?us-ascii?Q?lG+h20cUC79GnD4kf2SGH7imXhElU3/TLn85jz1oW63iFrppTmZzOgd6yCLi?=
 =?us-ascii?Q?98foZ6EEWRpg4DjWONpFlsv55rkRqhSySBiopraNpMLjPKr2LxY8H3fcMwNH?=
 =?us-ascii?Q?wihZA/8OOqPiiSqOt3km/hJW8AJ9XwdW50ZVh2iq1vgi948Jqw45pWZbFtwj?=
 =?us-ascii?Q?QoGMlYAUKu2ZaD+44DVYLJdMOwOAgrbkX4Du4TBgwXFVqtSX8VxSP9XAG2ft?=
 =?us-ascii?Q?REaSHMeTTf3VIw8e9USBUEVbaBR9VQ2jZtS+eXvRk14UaJTnAwN+o6bmQWfH?=
 =?us-ascii?Q?q431D8AxGDUCY0zU6zyJgiY7do9mflWUkn4vsy/dzH/PI4Y51VS0bMQkKmAV?=
 =?us-ascii?Q?3THbCXgSyKM5F28BFQxecTQFpZd4W/UWEdfZXIKBSvU7yDcu/A83vM1hc0Un?=
 =?us-ascii?Q?+Ab2bC+9d3XkaChdtv2VkqcsAIqwFXglE6+jtdoHWQG/a9s9/yRNzfvxWmFE?=
 =?us-ascii?Q?rslwnqp/QfhaZA/26olMfY5xGorQFG2+RkfnGcgEd1o6vDu/mi/45NG3edjO?=
 =?us-ascii?Q?Q7Hkluduln38Aqe5YwhrVR4ix7K5TSwRMbgBIIK+wt8yu/mYXiIjW8Ww4Uzw?=
 =?us-ascii?Q?0jkpA6n8XRpnbw1zRWJZOlL7pABSEDZ+G3IXdUZQO+zE4KQLpfeXraz3+MEp?=
 =?us-ascii?Q?V1EW9J+0mCYARzVnp0WN6tRUr+ro/4noCFMA/f2dIkvRYNVP9d3Vehhl3Wof?=
 =?us-ascii?Q?i1hxjvxRgvHj75lPRe6DLRZh?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?En6L1ZgQHHFA1fPnQtLn6uDOIzpK/+kQmRcCO9kSeSS71O68/AzKMbupmCYL?=
 =?us-ascii?Q?KU2hbJBnE8vbTsRu1WsivWHmdGM/9JotiqSiRgrlV42Smg0Vt/HsGTOJ0lbs?=
 =?us-ascii?Q?Xf8AXV5i2zDiGZ9NSuI8Nt3vQb6JvEz/5N2Cm2tlfFeqsAReWL/0L/SU/ddF?=
 =?us-ascii?Q?kxiWHHCcg9YGrz31Tl65mAIwsVrPQ0dl/BM1lI8zhc/4ZSFDVKfZIPOaDwpM?=
 =?us-ascii?Q?t55mncbNLTJpxBo+zFPNpECR9QtPWexjmOL6707RNAwrQqMQHt86G4iS6QvP?=
 =?us-ascii?Q?ZSLozVMdze/DtdBQjZp8I8kXuPFCYsbvFjCer5iIFNKXjAYS86vIGpM0RpTT?=
 =?us-ascii?Q?m3rbfnbXWhFQv7wYpVtS3zeiK+rHQTfc0DXP+kX/Yz+8DxkM9AZf3dKkgix2?=
 =?us-ascii?Q?XGe0r926jETvjJQ9YjlNWfT0LhNu1kg3RjwJ/5Gzz2cyDqcfrWlVH60icOiE?=
 =?us-ascii?Q?DmD1GDo5/yj72o4LgJVi64oqbrd+5agwBMa2uPB3qU/6QxZehmgHCBS9JJuL?=
 =?us-ascii?Q?Mz+RTuJImLOM5m46g6HvmlyzuiFCRqZ3X/nXo150DtrGO8ko62+0OQS09JJQ?=
 =?us-ascii?Q?Qn6J4hH/3piaFHqrRKpgS8d0Q7ih8SyEwmm+DV/kMCS3C2t8Q/JlG9A8AkR1?=
 =?us-ascii?Q?sLEFcsZJXDylx7aKycSGO6r+O5Tz34YuTTPqL+bTQuOExEczVZCPs/cbep8K?=
 =?us-ascii?Q?33w6nq/hIKTe/of05lytTKPfoIo0y95eEbWLpbjMdT+uS+Dh+oweF9EwnehL?=
 =?us-ascii?Q?J9vCdp6mj8je43an9Kv5GfCNgOnz4BgRdU1FIfNJbH2TDhiKZf0ytjXH06WE?=
 =?us-ascii?Q?1uHH9enmzMDPnbNyVHLUXn9UZk40gE305dGDJEjld74vxR5tr6hTiky/LG/A?=
 =?us-ascii?Q?3YvBzHdkr6XrvHc35JM0M8TVyvay0gG8RksMo4lsWwNmGwzHE6vlIQ9owdB/?=
 =?us-ascii?Q?QiriYEHlDMOylxVqq3J9zfIcDrMYZOu8oXAt2KfIcrHguBmyk/qn/T5URuxk?=
 =?us-ascii?Q?g9sKtCflAXUkprI/nmdYFkbuDCDC9MuiNPf9RY7BW9P/L1CKTYZpxF04QvI/?=
 =?us-ascii?Q?Ce3z9nfrtvXOdtEkeUkYyUQ331O1hRJTRo55rQxrVpWEINcOsduU0KFUdINV?=
 =?us-ascii?Q?ZmNSp3QjurF94+plp7BQjKigqJa8n3RKWwgd072XU6SSjXTho/zD62vwtWDq?=
 =?us-ascii?Q?/wNVGHI6Dj0wjyIfpI7gEMb7Fl2o5t/E6axBXa/cYQ/LbUzvTemk6L61oBqc?=
 =?us-ascii?Q?UZzcRAYbkgS8iDK2cT2UtD0ZXzhsNYPBJhbN+BcbtHE/fAtV892TIiubmUY5?=
 =?us-ascii?Q?/aXPxzJTyFT9CxlDd1g2eOfAz07u8a8nCE4zKNuvTLuaYqSHFUdilnJfpOBt?=
 =?us-ascii?Q?0MtC+KmK09rT0jZoVl2e96mOa8D5cZbFnuTRz5XJx4lvTYNl0KxQCvvPPBHw?=
 =?us-ascii?Q?+jYV2m+O7cJEIVHUXITm1h6bOAHrbvujduG63zcDbLkozS2NallXtMqy8cGw?=
 =?us-ascii?Q?D3vFRN/2fWctjB6WIz1NorQrJr/i9s4ozszJt70L91Inz0wjqGAb4jNe8T15?=
 =?us-ascii?Q?oZ4iNhxAQN6XvY+OuMKLSCEbpMfwZVKr9fMDiWofUAnIcCKEQRBOHoMRENiZ?=
 =?us-ascii?Q?nks704iMNxUo+jZt6mwjleE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SiAQF3kLcY4CmdHHXwPRlmqVgs4Wu0aKEwEX3PEkQexK5TeNhwLfOQ4rS6Kk4RXY2e6JWKSrUaRqua04NhSqdUylc1hSQ0/TmzdKHEWVaTleGBpbPAOlf8BOvU8SjWhvS1eiymsJQ9SD5FzEoZkCgyex07hu5TBcYqg+o0pOT5l8Lbj1EaFvw8E7BpakcSEbsRRac6NYUcHsqohoP2bGW35w66u/TOmBlqiT6k8Bzmd2J9kpjINAqIwzVF7s1yMohwkUCXA4rYkk7ynojhtocr+z2vXhkuIefW3LLc74f2HUiaJZx456aPfEB54j4o+0u96nL0SWh2yjRyxqIXalEQpHcfLxuftzbQgh1yHeX+tB0NpemwTlSHvMwgKVm8SV6Iez+8gZ0VHrMJPFpMhf7HuUatu7u5mlctte4R62BV32p1vp9K491/lnRLL5G86J5SS0x/ujP/KVYrKvPUYIOdNbxLYr8ZMWexWZzVka4RZdSGx2GqsKZq4lHNvo1OUFIj0QH1jRmc6WX2gvCiBF5dOnSii2N0eea3vymWjks955QSeYyemG/NrNyqkNJDCW6yGsvsUod+8eszc/wIw8sJOfjkkEYDREzNghBmSspPE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d3583b-9d08-4097-33cc-08dc8fd7f556
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:48:07.8410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lwbZLRZ9gyMaI6tC9Hf+PElH9eQXt6jc1/4qaBIPYTILyVtgOtEG5kccIuofCFguIaQPo7vgithLqzH6lO2ze/gSvlfpqNiwJyc1ccReog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_04,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180153
X-Proofpoint-ORIG-GUID: lSLopz7xQU6NG444sDHcpoAQNzAKjmka
X-Proofpoint-GUID: lSLopz7xQU6NG444sDHcpoAQNzAKjmka

Introduce mas_wr_store_type() which will set the correct store type
based on a walk of the tree.

mas_prealloc_calc() is also introduced to abstract the calculation used
to determine the number of nodes needed for a store operation.

In this change a call to mas_reset() is removed in the error case of
mas_prealloc(). This is only needed in the MA_STATE_REBALANCE case of
mas_destroy(). We can move the call to mas_reset() directly to
mas_destroy().

Also, add a test case to validate the order that we check the store type
in is correct. This test models a vma expanding and then shrinking which
is part of the boot process.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c                 | 214 ++++++++++++++++++++++---------
 tools/testing/radix-tree/maple.c |  36 ++++++
 2 files changed, 190 insertions(+), 60 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 62b465f0d97d..5187f0b19742 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4275,6 +4275,151 @@ static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
 	wr_mas->content = mas_start(mas);
 }
 
+/**
+ * mas_prealloc_calc() - Calculate number of nodes needed for a
+ * given store oepration
+ * @mas: The maple state
+ * @entry: The entry to store into the tree
+ *
+ * Return: Number of nodes required for preallocation.
+ */
+static inline int mas_prealloc_calc(struct ma_state *mas, void *entry)
+{
+	int ret = mas_mt_height(mas) * 3 + 1;
+
+	switch (mas->store_type) {
+	case wr_invalid:
+		WARN_ON_ONCE(1);
+		break;
+	case wr_new_root:
+		ret = 1;
+		break;
+	case wr_store_root:
+		if (likely((mas->last != 0) || (mas->index != 0)))
+			ret = 1;
+		else if (((unsigned long) (entry) & 3) == 2)
+			ret = 1;
+		else
+			ret = 0;
+		break;
+	case wr_spanning_store:
+		ret =  mas_mt_height(mas) * 3 + 1;
+		break;
+	case wr_split_store:
+		ret =  mas_mt_height(mas) * 2 + 1;
+		break;
+	case wr_rebalance:
+		ret =  mas_mt_height(mas) * 2 - 1;
+		break;
+	case wr_node_store:
+	case wr_bnode:
+		ret = mt_in_rcu(mas->tree) ? 1 : 0;
+		break;
+	case wr_append:
+	case wr_exact_fit:
+	case wr_slot_store:
+		ret = 0;
+	}
+
+	return ret;
+}
+
+/*
+ * mas_wr_store_type() - Set the store type for a given
+ * store operation.
+ * @wr_mas: The maple write state
+ */
+static inline void mas_wr_store_type(struct ma_wr_state *wr_mas)
+{
+	struct ma_state *mas = wr_mas->mas;
+	unsigned char new_end;
+
+	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas))) {
+		mas->store_type = wr_store_root;
+		return;
+	}
+
+	if (unlikely(!mas_wr_walk(wr_mas))) {
+		mas->store_type = wr_spanning_store;
+		return;
+	}
+
+	/* At this point, we are at the leaf node that needs to be altered. */
+	mas_wr_end_piv(wr_mas);
+	if (!wr_mas->entry)
+		mas_wr_extend_null(wr_mas);
+
+	new_end = mas_wr_new_end(wr_mas);
+	if ((wr_mas->r_min == mas->index) && (wr_mas->r_max == mas->last)) {
+		mas->store_type = wr_exact_fit;
+		return;
+	}
+
+	if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
+		mas->store_type = wr_new_root;
+		return;
+	}
+
+	/* Potential spanning rebalance collapsing a node */
+	if (new_end < mt_min_slots[wr_mas->type]) {
+		if (!mte_is_root(mas->node)) {
+			mas->store_type = wr_rebalance;
+			return;
+		}
+		mas->store_type = wr_node_store;
+		return;
+	}
+
+	if (new_end >= mt_slots[wr_mas->type]) {
+		mas->store_type = wr_split_store;
+		return;
+	}
+
+	if (!mt_in_rcu(mas->tree) && (mas->offset == mas->end)) {
+		mas->store_type = wr_append;
+		return;
+	}
+
+	if ((new_end == mas->end) && (!mt_in_rcu(mas->tree) ||
+		(wr_mas->offset_end - mas->offset == 1))) {
+		mas->store_type = wr_slot_store;
+		return;
+	}
+
+	if (mte_is_root(mas->node) || !(new_end <= mt_min_slots[wr_mas->type]) ||
+		(mas->mas_flags & MA_STATE_BULK)) {
+		mas->store_type = wr_node_store;
+		return;
+	}
+
+	mas->store_type = wr_bnode;
+}
+
+/**
+ * mas_wr_preallocate() - Preallocate enough nodes for a store operation
+ * @wr_mas: The maple write state
+ * @entry: The entry that will be stored
+ * @gfp: The GFP_FLAGS to use for allocations.
+ *
+ */
+static inline void mas_wr_preallocate(struct ma_wr_state *wr_mas, void *entry, gfp_t gfp)
+{
+	struct ma_state *mas = wr_mas->mas;
+	int request;
+
+	mas_wr_prealloc_setup(wr_mas);
+	mas_wr_store_type(wr_mas);
+	request = mas_prealloc_calc(mas, entry);
+	if (!request)
+		return;
+
+	mas_node_count_gfp(mas, request, gfp);
+	if (likely(!mas_is_err(mas)))
+		return;
+
+	mas_set_alloc_req(mas, 0);
+}
+
 /**
  * mas_insert() - Internal call to insert a value
  * @mas: The maple state
@@ -5503,69 +5648,17 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
 int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
-	unsigned char node_size;
-	int request = 1;
-	int ret;
-
-
-	if (unlikely(!mas->index && mas->last == ULONG_MAX))
-		goto ask_now;
-
-	mas_wr_prealloc_setup(&wr_mas);
-	/* Root expand */
-	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
-		goto ask_now;
-
-	if (unlikely(!mas_wr_walk(&wr_mas))) {
-		/* Spanning store, use worst case for now */
-		request = 1 + mas_mt_height(mas) * 3;
-		goto ask_now;
-	}
-
-	/* At this point, we are at the leaf node that needs to be altered. */
-	/* Exact fit, no nodes needed. */
-	if (wr_mas.r_min == mas->index && wr_mas.r_max == mas->last)
-		return 0;
-
-	mas_wr_end_piv(&wr_mas);
-	node_size = mas_wr_new_end(&wr_mas);
-
-	/* Slot store, does not require additional nodes */
-	if (node_size == mas->end) {
-		/* reuse node */
-		if (!mt_in_rcu(mas->tree))
-			return 0;
-		/* shifting boundary */
-		if (wr_mas.offset_end - mas->offset == 1)
-			return 0;
-	}
+	int ret = 0;
 
-	if (node_size >= mt_slots[wr_mas.type]) {
-		/* Split, worst case for now. */
-		request = 1 + mas_mt_height(mas) * 2;
-		goto ask_now;
+	mas_wr_preallocate(&wr_mas, entry, gfp);
+	if (mas_is_err(mas)) {
+		ret = xa_err(mas->node);
+		mas_destroy(mas);
+		mas_reset(mas);
+		return ret;
 	}
 
-	/* New root needs a single node */
-	if (unlikely(mte_is_root(mas->node)))
-		goto ask_now;
-
-	/* Potential spanning rebalance collapsing a node, use worst-case */
-	if (node_size  - 1 <= mt_min_slots[wr_mas.type])
-		request = mas_mt_height(mas) * 2 - 1;
-
-	/* node store, slot store needs one node */
-ask_now:
-	mas_node_count_gfp(mas, request, gfp);
 	mas->mas_flags |= MA_STATE_PREALLOC;
-	if (likely(!mas_is_err(mas)))
-		return 0;
-
-	mas_set_alloc_req(mas, 0);
-	ret = xa_err(mas->node);
-	mas_reset(mas);
-	mas_destroy(mas);
-	mas_reset(mas);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mas_preallocate);
@@ -5591,7 +5684,8 @@ void mas_destroy(struct ma_state *mas)
 	 */
 	if (mas->mas_flags & MA_STATE_REBALANCE) {
 		unsigned char end;
-
+		if (mas_is_err(mas))
+			mas_reset(mas);
 		mas_start(mas);
 		mtree_range_walk(mas);
 		end = mas->end + 1;
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index f1caf4bcf937..2c4e69591235 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36223,6 +36223,38 @@ static noinline void __init check_mtree_dup(struct maple_tree *mt)
 
 extern void test_kmem_cache_bulk(void);
 
+ /* test to simulate expanding a vma from [0x7fffffffe000, 0x7ffffffff000)
+  * to [0x7ffde4ca1000, 0x7ffffffff000) and then shrinking the vma to
+  * [0x7ffde4ca1000, 0x7ffde4ca2000)
+  */
+static inline int check_vma_modification(struct maple_tree *mt)
+{
+	MA_STATE(mas, mt, 0, 0);
+
+	mtree_lock(mt);
+	/* vma with old start and old end */
+	__mas_set_range(&mas, 0x7fffffffe000, 0x7ffffffff000 - 1);
+	mas_preallocate(&mas, xa_mk_value(1), GFP_KERNEL);
+	mas_store_prealloc(&mas, xa_mk_value(1));
+
+	/* next write occurs partly in previous range [0, 0x7fffffffe000)*/
+	mas_prev_range(&mas, 0);
+	/* expand vma to {0x7ffde4ca1000, 0x7ffffffff000) */
+	__mas_set_range(&mas, 0x7ffde4ca1000, 0x7ffffffff000 - 1);
+	mas_preallocate(&mas, xa_mk_value(1), GFP_KERNEL);
+	mas_store_prealloc(&mas, xa_mk_value(1));
+
+	/* shrink vma to [0x7ffde4ca1000, 7ffde4ca2000) */
+	__mas_set_range(&mas, 0x7ffde4ca2000, 0x7ffffffff000 - 1);
+	mas_preallocate(&mas, NULL, GFP_KERNEL);
+	mas_store_prealloc(&mas, NULL);
+	mt_dump(mt, mt_dump_hex);
+
+	mas_destroy(&mas);
+	mtree_unlock(mt);
+	return 0;
+}
+
 void farmer_tests(void)
 {
 	struct maple_node *node;
@@ -36230,6 +36262,10 @@ void farmer_tests(void)
 
 	mt_dump(&tree, mt_dump_dec);
 
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN | MT_FLAGS_USE_RCU);
+	check_vma_modification(&tree);
+	mtree_destroy(&tree);
+
 	tree.ma_root = xa_mk_value(0);
 	mt_dump(&tree, mt_dump_dec);
 
-- 
2.45.2


