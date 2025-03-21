Return-Path: <linux-kernel+bounces-572019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6D8A6C57F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3973B189AC81
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99D4233155;
	Fri, 21 Mar 2025 21:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AGaLxbzk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rYvna223"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B59231CA5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742594105; cv=fail; b=ubU6kJnsbSmxVg9Xj/4v9MjvWU8pZju3VjbiX4S2Tf7hy/BiiEzqfNEYlodv39KTGmkYeaDZh3opfEhC0QlxX7oC7uVyNqsUCyOhUe4k0Et2UUPN29ECd3mpKt+T0zocBUfeveM1Nz27IA49YbO11AfcWG6gsIWt4eHhRL6+2AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742594105; c=relaxed/simple;
	bh=V3nQZpLX7jAnZojXftggsaAd6TGcUzO0g3O6x+O41iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a0f8tr1a8U40Jyd5wAQ6FOhMaffRRacOv5/sQWVeb+BISVSgeJSjCE3qdukf2ariUPJwrpO6h3+yjHs3rgrlzlTc1hHjNo/qvUK86kkA9i2GFzhgUaNCiw9mkFiTRcJy2w8sPddFnG/j7vjzNd3vPzXtgl/dkvr9j2a1eFLuy7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AGaLxbzk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rYvna223; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LKg7IO002478;
	Fri, 21 Mar 2025 21:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=UK3N7z9rS5OUy1NsR+1LhyzbuT9Y2t80AOpNHR8/GLY=; b=
	AGaLxbzkYCCjCsmGjSqHyQtOU9td7AmC2vjFh0sTWkFz106njqKMZbqYh1YFqimc
	zwfRBnZ0leyjf3e56clHC3ZsQi0YfPZC2AqMNhLW91XO8ZLTE+WPGuWici2bVced
	NWc6xB5EN6lmeYfd2seQ6JRqXI5oqAJG7AuswiV1L4vtR2+BsF75875ZDBEGr8fu
	kBtmSlq3ZskSPObMm8v87pEqnZQWM2VN6gVrwii/nsgoN7yVu4IlaVPcDWctgWd7
	RGGs6qDCpSMOdMif1gvDQTTaY12NABaHIx0kxvb7+XjyPnxOGSTeUbItyt2o0kCQ
	VoOLP321vRDhILz2kV1UoQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m19qq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 21:54:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LJjRlX004553;
	Fri, 21 Mar 2025 21:54:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ftn014px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 21:54:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGrE0qwI9HlCMOPmAuntz6wRrJZEd2LUf+9Gwy4BpAMlnNvQgG0BHYtRv3mJi99/snrnlNP0qt9MblJ/X2yGOi7FnoI/rwWFqJvG3D8soz3PAILFrL9w0VwI8V2FHvlSn7kqkASaJaLh0zZtBF9Jr2rXeU4ZC02zo0Sgh1Rkukry+vFlBOirgQEq635Rly91ovYBGr9dbhunk6Vf/fp0taaDfgo9CUlMtYnoU33faGNxmujzi6/j8qEW7XYy96y36JKYtWQAsajT3+pn6P+1gQx4PG7yq9aFKmxtgXfMlHCun7vwQXXYlDNFseSbeZf1TWjtsJqmOmxEtmy6QiFT6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UK3N7z9rS5OUy1NsR+1LhyzbuT9Y2t80AOpNHR8/GLY=;
 b=WJMOLpJkF35R2nbsgUfPux51z1Ye3PCVSRJh5K5H8ulbpRw4/FbAKgmsifGkvrKDkU/wJF/FlrXIzXD6+Psa1DSn1MLWVk3Tn/ac3fA/w/mI0ShnK5366LI9L5CdMdzqM2H/UBtHhqHeUa9YduPm/yG3g/3VtOnGSUj/U8D723jEI7aWeDkuu1O+YQhQLwQiCXFfs5lqjN37ll83S8q/OKVVcJrvxwdyLo+u+RLLw/lYeVDE9tOZ/t2ET9c3tASiXLOsvnhXO9QIj9hP+QlyIs8N0l7ebj8CpYO83ieGf3GwRSeItrIAqmqF9aOran80/ok+M+2TnplRK94oMKWOtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UK3N7z9rS5OUy1NsR+1LhyzbuT9Y2t80AOpNHR8/GLY=;
 b=rYvna223JvmE0b4DIzXFuQo1qTM53Dq1C5CxiYm6hhv/lta0qVGbHXhgjEAaHeTVnWMkuSz7YW6CbLf2H0QXY9u+1Dk5ktguOZRURAfp6l0ViX7JS4VktcRxGZxLv9o68D8leJCXW4z1FFU0WfwuZadY6PRtnAvx5eCJqQuXDIc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY5PR10MB6144.namprd10.prod.outlook.com (2603:10b6:930:34::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 21:54:45 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 21:54:45 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/7] mm/mremap: introduce more mergeable mremap via MREMAP_RELOCATE_ANON
Date: Fri, 21 Mar 2025 21:54:30 +0000
Message-ID: <d10037699391c42a4943f578c2a0bca890640f30.1742478846.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742478846.git.lorenzo.stoakes@oracle.com>
References: <cover.1742478846.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0344.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY5PR10MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 7176d18d-1bca-46e2-0246-08dd68c2fdf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DfNEdLfPST5K4/kA5GnGAyf4yxopBkVtQFsmbtt7ou0DZMb1Zpcqv1e7ZBjy?=
 =?us-ascii?Q?qruCcq/RY2qxK1ZU98AAM9geIjE1FwDCvDbuW9e+fxoSHPIsWda1wNl1uClN?=
 =?us-ascii?Q?VvzuqAyszbgGJ7a5qFm8pExYjWwkSuCr84XcyhCCxjYTGkQr3ziWXwhuU0d4?=
 =?us-ascii?Q?Ue9S4dgW6oa6PNYWhqz3zjt3iNgLxJnbd8RcPtIhKu7mgMGOdS3678k1J4Ub?=
 =?us-ascii?Q?c5LK2VvprDHqqLsYDWsPa3wobK9LI5SjUGGQVOyOGxU5PMmBJKCAJjaRcek+?=
 =?us-ascii?Q?YG+CAAQTF0uYniSd4lo5n237ixzqHF6vlPz7oPSPif2cupx5yMCm1qpPjvkX?=
 =?us-ascii?Q?FmBfznSJ5GoixJ5EcM/CbeOYBjIL3sNmgX+pFZJW3lDWcliWwKcokJ9z4yim?=
 =?us-ascii?Q?l8oUDc3JiDlmPba7gZJBNMc3iSBYLHyFYre17d4PX8DVlY2nW8ZniDelYDnd?=
 =?us-ascii?Q?3zKpc6/B7xwI4/GSaPdvrgLTK1DCgfiK1sjK8cwOydeBvw+IEMROPMU2mPt2?=
 =?us-ascii?Q?6UkEy9WMpLBOHysMvHq6fTnuLh5rdLSd+EcPTUvCHk1pdnwf/UXDLL1CjxQq?=
 =?us-ascii?Q?w/LJQP3lhrh+FTG9B5C3SshdugznpCTRWataFAr5U6E+iQ0w/Z/zHd4c2mNZ?=
 =?us-ascii?Q?uWGhr/1N33K+AVPRMQ0QCxc4lDuHm+rOFPe/d4s7AYZvzZFY5WdnoBxR5ho8?=
 =?us-ascii?Q?v/Bzx3ifGZVT12z4oWG6ceuqk32xX0pd1HjGCkg53LJG/01iYv8XdJcKNcuS?=
 =?us-ascii?Q?TKDAjnW6LC8e45Q5VCn9o3Y4HV4S6UoDo/7ZZL865Ea13o2aziSsISWCQ3zj?=
 =?us-ascii?Q?gZdqk+Qd3ANXutKfGou+Jt59/3NHc7afJGVOe3ldl4+3f2zxrEVg3D3TY/pk?=
 =?us-ascii?Q?Gi4HWoRK5/+FPQ8EyejxF8edfEUYL9SJbiVWAicfVwj3ClniVfIs9BZII1In?=
 =?us-ascii?Q?KUPzndKKy6gZs/+TZwxcPOQHN8Ml9Dz4HnpbhhZZTURgWtz7MUuZ+YWu0fYF?=
 =?us-ascii?Q?NpkMM2X+r0nBJtsIvq/mtEG5tw7CvsS2ZSyxScIFMx6GR/LsHr0M+wUbwCWH?=
 =?us-ascii?Q?6SMH3KVrV9bAGl7SocW4W/MNCfclingOuAQXbPMm34lQWNnv6Oh9I8aW/oD+?=
 =?us-ascii?Q?r/lYgrdRNTRZW3jxqU2GnTiUj73mj5Ee6KpoP28a9nuR8MKNaOSD6jv2/CR3?=
 =?us-ascii?Q?9l8Aun8dm9IpqrNxGCZyoaz2W8KtdYSeM36aw2E+zwMBn+LvCSyHZiq00O//?=
 =?us-ascii?Q?TyFo9eddA+bsMXZcT58MwUt8ZfxpVx1TmiyyT52USwAmUrPhlrQSummVhho9?=
 =?us-ascii?Q?wY4YxeZ+cwzXCLkqLxNJcNR5Nekh2z5mfP0Bl6q8MqFhoi4JqB+uWxYRxvi0?=
 =?us-ascii?Q?nmbBCBah4lFqK3O1fEsxd0LIJ8gc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MuzzvHtR/Dtoiv3oTQVbG7Vs4d1PsGvJNcAor70/5o1p5EWZiwkqRBNcaE8y?=
 =?us-ascii?Q?YMuGolDuS9yL0YiP8kOOrYeJBvXJJRrqJ/0G+KkPSG1ai5Tz8TjL02qUkE9A?=
 =?us-ascii?Q?eZv8duSH377wd0eDXGBnqQ/AudFIf4EhIdOubPzxQ5BqD26a34UTjnj4+APn?=
 =?us-ascii?Q?rFCokMORicvKI21TNIugJ/t8bNWDTTRCOu9jpsaXrv/KyfJkgchBX27qPM9S?=
 =?us-ascii?Q?12xRQvYer/xtXj8UzOqoEFyBdyukSEmaSIQSGco1B5+pfHn8w/fLAx7dVj4C?=
 =?us-ascii?Q?0mRTqjzkKR2trJaAi9WdV0uLq0UxpGrZGU19gj1Xbhba1fv3+mRE/ED3ng8V?=
 =?us-ascii?Q?fdpdF+AwbzROGlNhgcGxMNoVNLXgubG2ayPEx6Yp6WCBPA/ybARxJJM90Hn+?=
 =?us-ascii?Q?H+zwunwiZpNYcCkxFT88XD8E9d9omHsJzuQhakWmpaF3Vn7kYYTfl2jiNCQh?=
 =?us-ascii?Q?OHCOvzZG820urpOFJycx7+8DCkCgqkBnCgKygHpOHrjHx2Es1HyHksP8TQD2?=
 =?us-ascii?Q?cqun9qRpk8N3XreM7wtbQcJ4SnyjkD6+S2DWB8HJqNc5UA5/YwYJ7/d6P0JC?=
 =?us-ascii?Q?2KE5VfJKJwN4+ID7x7Ss/P7KK1e0e7QRpBgBAjk+YRv5dNRvYz2UUWcPTznD?=
 =?us-ascii?Q?q1tuZ6U+1KIlAQNHJu7jXROOqObWnQ/+RHC1XXCoDEY8DOLvFlbuvSRiDcep?=
 =?us-ascii?Q?xwfQWXtrKBGwETckBNCPEKz7/uaky+irbk/ApmWHxqBoJNQcaw6GVwqPuBWM?=
 =?us-ascii?Q?F6o+T7y9WRYSOhgIC5HhysBkIRE/YJAokEHq5UKo3ocTqr38toslUamQ+3QD?=
 =?us-ascii?Q?xb9pmGfRb9kg9f3b/ubttfSKGWNrJIRxDDZG306V89ycnPpwykoLOnBtD3Gn?=
 =?us-ascii?Q?vuCJ+gPONIsAflFQIRVPj9u8moLPYA+onEjzvBVeM9Dv5COOFpfuGPbZuHbU?=
 =?us-ascii?Q?u9ZmKgj9d2/C/j2sIIvR/JC8l0Yjc5fJSOncrJS8wAnI/2AOLpWTT93irWE9?=
 =?us-ascii?Q?DuAX+Q40r96gZt/Rthipr5Iwnd3jHme7LkIqtuc4F0BPXcrgs7IFfdBrfBqn?=
 =?us-ascii?Q?pUDF0ppY+AQZFYZDx54J8hF/Uj1RCYm++9u/WVmPe3NzMwmsVxgOkW05sR2/?=
 =?us-ascii?Q?vHmhHRFoyZMpsk1fcJwry84VL9gBatqeQHsWF+p89fvDaeZiTfPCtb9eAjlj?=
 =?us-ascii?Q?U9TwpfuMLo1/FmIM3mhnR00wAO/qICbBE9tV7Bn9bvkE+p9yTh5FetyQDNC1?=
 =?us-ascii?Q?SIfIn9ungT4yAD6E/ZOQjyyyoTAB6jxtPi1HHEOYdetMuI+kY16zmVMoJ2kN?=
 =?us-ascii?Q?Jr624SLoHZugJ/HqX6KhbXoh16IpsQ6DN9wMysTK2qheM+MST9bR5I5ilZn1?=
 =?us-ascii?Q?+pKeidRsQ8/616AhCG8gCJuvm7JIkTLSzRvZk/gM5SWhIMdj1jVa2XBMzh0j?=
 =?us-ascii?Q?Ruxj965lIiXuH+YH0M7j8JS2Sq7UKG5R6hdULdwyzomQ03C311hw62hwKm4J?=
 =?us-ascii?Q?KGK5EVoj0D8Na7EF8bXDYJ2rH25jGj+BppNedBTS9EDUExVSnoYyLah43INw?=
 =?us-ascii?Q?iXFlxgB2+r4DNWqgMKHCBBDq4Oz1vqtxhKTaLiUxBz+QkfTA4KhcShr4gjyq?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UtdsmovZunmHnwMXzNZiABChcURXq0M7ngzLBWzb85jMdEsna97H56D80TaDzdI2QE7JoWeGhG3jeztCCWCvspDAa/EjzpB024sMulf6pWwvF2wAhRrbULYvdA7opR1urBx+V01dgq5i6KgeghrtILukWTh3UxFlYoaXzfEXSAD9fuptWtXZ1QtaFQlrXGCKdykvhAhAdgC4lTl6lw40EVVW18+Ld6hGDjoe3SFCqFMOictE5uJpjLg4JwNhXQGFvIHUzWaNzJ0KjKaWprujiW3dDxZ0dUX1v1YhneU2n5jtwHDmVRUqhEuqAM+LGqJRSvMinXsNAy6GGryDn7NxsCdMQiFpX2cPSpNr83mHT/D9cIsI+MR6wsLBU3I2cZONvgu30Mtnm8GUpEw6cyNPhBrbblLJQ0PrGbZ6Li+X5cT32DAh1gBTgmJJZSGuyg5KpRL+314ls9eJtXlYkEsp4kZFLEj/w+AwuIt5PvxDBYHGTFHXHR38QWpLpoS3AF5+uj4dDD4yMaSbl5ip55w+DzmBUxSJfPGtBcwtS9sMpz79DxY52NGXUcs8TfYphsW3KPPy9+jw4XpbNWg+MSYu8LuxHXUSFLk2b2Zh8yEv6sk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7176d18d-1bca-46e2-0246-08dd68c2fdf1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 21:54:45.2495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAQVfwsGkkLZWGOgILSc0+eOHrbj3FqqrWWW2sVEaNOrzHILbi6qhPzfo3kL9c+21ZnI6pTus3svcL1bxJxRF3xeFMbOn5NBs/PcGRSel4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_07,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503210160
X-Proofpoint-GUID: 2dgXcV98jOr72PT695mSlOtlXD4TXQ7f
X-Proofpoint-ORIG-GUID: 2dgXcV98jOr72PT695mSlOtlXD4TXQ7f

When mremap() moves a mapping around in memory, it goes to great lengths to
avoid having to walk page tables as this is expensive and
time-consuming.

Rather, if the VMA was faulted (that is vma->anon_vma != NULL), the virtual
page offset stored in the VMA at vma->vm_pgoff will remain the same, as
well all the folio indexes pointed at the associated anon_vma object.

This means the VMA and page tables can simply be moved and this affects the
change (and if we can move page tables at a higher page table level, this
is even faster).

While this is efficient, it does lead to big problems with VMA merging - in
essence it causes faulted anonymous VMAs to not be mergeable under many
circumstances once moved.

This is limiting and leads to both a proliferation of unreclaimable,
unmovable kernel metadata (VMAs, anon_vma's, anon_vma_chain's) and has an
impact on further use of mremap(), which has a requirement that the VMA
moved (which can also be a partial range within a VMA) may span only a
single VMA.

This makes the mergeability or not of VMAs in effect a uAPI concern.

In some use cases, users may wish to accept the overhead of actually going
to the trouble of updating VMAs and folios to affect mremap() moves. Let's
provide them with the choice.

This patch add a new MREMAP_RELOCATE_ANON flag to do just that, which
attempts to perform such an operation. If it is unable to do so, it cleanly
falls back to the usual method.

It carefully takes the rmap locks such that at no time will a racing rmap
user encounter incorrect or missing VMAs.

It is also designed to interact cleanly with the existing mremap() error
fallback mechanism (inverting the remap should the page table move fail).

Also, if we could merge cleanly without such a change, we do so, avoiding
the overhead of the operation if it is not required.

In the instance that no merge may occur when the move is performed, we
still perform the folio and VMA updates to ensure that future mremap() or
mprotect() calls will result in merges.

In this implementation, we simply give up if we encounter large folios. A
subsequent commit will extend the functionality to allow for these cases.

We restrict this flag to purely anonymous memory only.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/uapi/linux/mman.h |   1 +
 mm/internal.h             |   1 +
 mm/mremap.c               | 354 +++++++++++++++++++++++++++++++++++---
 mm/vma.c                  |  29 +++-
 mm/vma.h                  |   5 +-
 tools/testing/vma/vma.c   |   5 +-
 6 files changed, 367 insertions(+), 28 deletions(-)

diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index e89d00528f2f..d0542f872e0c 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -9,6 +9,7 @@
 #define MREMAP_MAYMOVE		1
 #define MREMAP_FIXED		2
 #define MREMAP_DONTUNMAP	4
+#define MREMAP_RELOCATE_ANON	8
 
 #define OVERCOMMIT_GUESS		0
 #define OVERCOMMIT_ALWAYS		1
diff --git a/mm/internal.h b/mm/internal.h
index 286520a424fe..7c120a6b0018 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -46,6 +46,7 @@ struct folio_batch;
 struct pagetable_move_control {
 	struct vm_area_struct *old; /* Source VMA. */
 	struct vm_area_struct *new; /* Destination VMA. */
+	struct vm_area_struct *relocate_locked; /* VMA which is rmap locked. */
 	unsigned long old_addr; /* Address from which the move begins. */
 	unsigned long old_end; /* Exclusive address at which old range ends. */
 	unsigned long new_addr; /* Address to move page tables to. */
diff --git a/mm/mremap.c b/mm/mremap.c
index 0865387531ed..bb67562a0114 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -71,6 +71,14 @@ struct vma_remap_struct {
 	unsigned long charged;		/* If VM_ACCOUNT, # pages to account. */
 };
 
+/* Represents local PTE state. */
+struct pte_state {
+	unsigned long old_addr;
+	unsigned long new_addr;
+	unsigned long old_end;
+	pte_t *ptep;
+};
+
 static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
@@ -139,18 +147,42 @@ static pmd_t *alloc_new_pmd(struct mm_struct *mm, unsigned long addr)
 	return pmd;
 }
 
-static void take_rmap_locks(struct vm_area_struct *vma)
+static void maybe_take_rmap_locks(struct pagetable_move_control *pmc)
 {
+	struct vm_area_struct *vma;
+	struct anon_vma *anon_vma;
+
+	if (!pmc->need_rmap_locks)
+		return;
+
+	vma = pmc->old;
+	anon_vma = vma->anon_vma;
 	if (vma->vm_file)
 		i_mmap_lock_write(vma->vm_file->f_mapping);
-	if (vma->anon_vma)
-		anon_vma_lock_write(vma->anon_vma);
+	if (anon_vma) {
+		struct vm_area_struct *relocate_vma = pmc->relocate_locked;
+
+		if (!relocate_vma || relocate_vma->anon_vma != anon_vma)
+			anon_vma_lock_write(anon_vma);
+	}
 }
 
-static void drop_rmap_locks(struct vm_area_struct *vma)
+static void maybe_drop_rmap_locks(struct pagetable_move_control *pmc)
 {
-	if (vma->anon_vma)
-		anon_vma_unlock_write(vma->anon_vma);
+	struct vm_area_struct *vma;
+	struct anon_vma *anon_vma;
+
+	if (!pmc->need_rmap_locks)
+		return;
+
+	vma = pmc->old;
+	anon_vma = vma->anon_vma;
+	if (anon_vma) {
+		struct vm_area_struct *relocate_vma = pmc->relocate_locked;
+
+		if (!relocate_vma || relocate_vma->anon_vma != anon_vma)
+			anon_vma_unlock_write(anon_vma);
+	}
 	if (vma->vm_file)
 		i_mmap_unlock_write(vma->vm_file->f_mapping);
 }
@@ -204,8 +236,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
 	 *   serialize access to individual ptes, but only rmap traversal
 	 *   order guarantees that we won't miss both the old and new ptes).
 	 */
-	if (pmc->need_rmap_locks)
-		take_rmap_locks(vma);
+	maybe_take_rmap_locks(pmc);
 
 	/*
 	 * We don't have to worry about the ordering of src and dst
@@ -254,6 +285,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
 		 */
 		if (pte_present(pte))
 			force_flush = true;
+
 		pte = move_pte(pte, old_addr, new_addr);
 		pte = move_soft_dirty_pte(pte);
 
@@ -278,8 +310,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
 	pte_unmap(new_pte - 1);
 	pte_unmap_unlock(old_pte - 1, old_ptl);
 out:
-	if (pmc->need_rmap_locks)
-		drop_rmap_locks(vma);
+	maybe_drop_rmap_locks(pmc);
 	return err;
 }
 
@@ -537,15 +568,14 @@ static __always_inline unsigned long get_extent(enum pgt_entry entry,
  * Should move_pgt_entry() acquire the rmap locks? This is either expressed in
  * the PMC, or overridden in the case of normal, larger page tables.
  */
-static bool should_take_rmap_locks(struct pagetable_move_control *pmc,
-				   enum pgt_entry entry)
+static bool should_take_rmap_locks(enum pgt_entry entry)
 {
 	switch (entry) {
 	case NORMAL_PMD:
 	case NORMAL_PUD:
 		return true;
 	default:
-		return pmc->need_rmap_locks;
+		return false;
 	}
 }
 
@@ -557,11 +587,15 @@ static bool move_pgt_entry(struct pagetable_move_control *pmc,
 			   enum pgt_entry entry, void *old_entry, void *new_entry)
 {
 	bool moved = false;
-	bool need_rmap_locks = should_take_rmap_locks(pmc, entry);
+	bool override_locks = false;
 
-	/* See comment in move_ptes() */
-	if (need_rmap_locks)
-		take_rmap_locks(pmc->old);
+	if (!pmc->need_rmap_locks && should_take_rmap_locks(entry)) {
+		override_locks = true;
+
+		pmc->need_rmap_locks = true;
+		/* See comment in move_ptes() */
+		maybe_take_rmap_locks(pmc);
+	}
 
 	switch (entry) {
 	case NORMAL_PMD:
@@ -585,8 +619,9 @@ static bool move_pgt_entry(struct pagetable_move_control *pmc,
 		break;
 	}
 
-	if (need_rmap_locks)
-		drop_rmap_locks(pmc->old);
+	maybe_drop_rmap_locks(pmc);
+	if (override_locks)
+		pmc->need_rmap_locks = false;
 
 	return moved;
 }
@@ -752,6 +787,186 @@ static unsigned long pmc_progress(struct pagetable_move_control *pmc)
 	return old_addr < orig_old_addr ? 0 : old_addr - orig_old_addr;
 }
 
+/*
+ * If the folio mapped at the specified pte entry can have its index and mapping
+ * relocated, then do so.
+ *
+ * Returns the number of pages we have traversed, or 0 if the operation failed.
+ */
+static unsigned long relocate_anon(struct pagetable_move_control *pmc,
+		unsigned long old_addr, unsigned long new_addr, pte_t pte,
+		bool undo)
+{
+	struct page *page;
+	struct folio *folio;
+	struct vm_area_struct *old, *new;
+	pgoff_t new_index;
+	unsigned long ret = 1;
+
+	old = pmc->old;
+	new = pmc->new;
+
+	/* Ensure we have truly got an anon folio. */
+	page = vm_normal_page(old, old_addr, pte);
+	if (!page)
+		return ret;
+
+	folio = page_folio(page);
+	folio_lock(folio);
+
+	/* no-op. */
+	if (!folio_test_anon(folio) || folio_test_ksm(folio))
+		goto out;
+
+	/*
+	 * This should not happen as we explicitly disallow this, but check
+	 * anyway.
+	 */
+	if (folio_test_large(folio)) {
+		ret = 0;
+		goto out;
+	}
+
+	if (!undo)
+		new_index = linear_page_index(new, new_addr);
+	else
+		new_index = linear_page_index(old, old_addr);
+
+	/*
+	 * The PTL should keep us safe from unmapping, and the fact the folio is
+	 * a PTE keeps the folio referenced.
+	 *
+	 * The mmap/VMA locks should keep us safe from fork and other processes.
+	 *
+	 * The rmap locks should keep us safe from anything happening to the
+	 * VMA/anon_vma.
+	 *
+	 * The folio lock should keep us safe from reclaim, migration, etc.
+	 */
+	folio_move_anon_rmap(folio, undo ? old : new);
+	WRITE_ONCE(folio->index, new_index);
+
+out:
+	folio_unlock(folio);
+	return ret;
+}
+
+static bool pte_done(struct pte_state *state)
+{
+	return state->old_addr >= state->old_end;
+}
+
+static void pte_next(struct pte_state *state, unsigned long nr_pages)
+{
+	state->old_addr += nr_pages * PAGE_SIZE;
+	state->new_addr += nr_pages * PAGE_SIZE;
+	state->ptep += nr_pages;
+}
+
+static bool relocate_anon_ptes(struct pagetable_move_control *pmc,
+		unsigned long extent, pmd_t *pmd, bool undo)
+{
+	struct mm_struct *mm = current->mm;
+	struct pte_state state = {
+		.old_addr = pmc->old_addr,
+		.new_addr = pmc->new_addr,
+		.old_end = pmc->old_addr + extent,
+	};
+	spinlock_t *ptl;
+	pte_t *ptep_start;
+	bool ret;
+	unsigned long nr_pages;
+
+	ptep_start = pte_offset_map_lock(mm, pmd, pmc->old_addr, &ptl);
+	/*
+	 * We prevent faults with mmap write lock, hold the rmap lock and should
+	 * not fail to obtain this lock. Just give up if we can't.
+	 */
+	if (!ptep_start)
+		return false;
+
+	state.ptep = ptep_start;
+
+	for (; !pte_done(&state); pte_next(&state, nr_pages)) {
+		pte_t pte = ptep_get(state.ptep);
+
+		if (pte_none(pte) || !pte_present(pte)) {
+			nr_pages = 1;
+			continue;
+		}
+
+		nr_pages = relocate_anon(pmc, state.old_addr, state.new_addr, pte, undo);
+		if (!nr_pages) {
+			ret = false;
+			goto out;
+		}
+	}
+
+	ret = true;
+out:
+	pte_unmap_unlock(ptep_start, ptl);
+	return ret;
+}
+
+static bool __relocate_anon_folios(struct pagetable_move_control *pmc, bool undo)
+{
+	pud_t *pudp;
+	pmd_t *pmdp;
+	unsigned long extent;
+	struct mm_struct *mm = current->mm;
+
+	if (!pmc->len_in)
+		return true;
+
+	for (; !pmc_done(pmc); pmc_next(pmc, extent)) {
+		pmd_t pmd;
+		pud_t pud;
+
+		extent = get_extent(NORMAL_PUD, pmc);
+
+		pudp = get_old_pud(mm, pmc->old_addr);
+		if (!pudp)
+			continue;
+		pud = pudp_get(pudp);
+
+		if (pud_trans_huge(pud) || pud_devmap(pud))
+			return false;
+
+		extent = get_extent(NORMAL_PMD, pmc);
+		pmdp = get_old_pmd(mm, pmc->old_addr);
+		if (!pmdp)
+			continue;
+		pmd = pmdp_get(pmdp);
+
+		if (is_swap_pmd(pmd) || pmd_trans_huge(pmd) ||
+		    pmd_devmap(pmd))
+			return false;
+
+		if (pmd_none(pmd))
+			continue;
+
+		if (!relocate_anon_ptes(pmc, extent, pmdp, undo))
+			return false;
+	}
+
+	return true;
+}
+
+static bool relocate_anon_folios(struct pagetable_move_control *pmc, bool undo)
+{
+	unsigned long old_addr = pmc->old_addr;
+	unsigned long new_addr = pmc->new_addr;
+	bool ret;
+
+	ret = __relocate_anon_folios(pmc, undo);
+
+	/* Reset state ready for retry. */
+	pmc->old_addr = old_addr;
+	pmc->new_addr = new_addr;
+
+	return ret;
+}
+
 unsigned long move_page_tables(struct pagetable_move_control *pmc)
 {
 	unsigned long extent;
@@ -1132,6 +1347,42 @@ static void unmap_source_vma(struct vma_remap_struct *vrm)
 	}
 }
 
+/*
+ * Should we attempt to relocate anonymous folios to the location that the VMA
+ * is being moved to by updating index and mapping fields accordingly?
+ */
+static bool should_relocate_anon(struct vma_remap_struct *vrm,
+	struct pagetable_move_control *pmc)
+{
+	struct vm_area_struct *old = vrm->vma;
+
+	/* Currently we only do this if requested. */
+	if (!(vrm->flags & MREMAP_RELOCATE_ANON))
+		return false;
+
+	/* We can't deal with special or hugetlb mappings. */
+	if (old->vm_flags & (VM_SPECIAL | VM_HUGETLB))
+		return false;
+
+	/* We only support anonymous mappings. */
+	if (!vma_is_anonymous(old))
+		return false;
+
+	/* If no folios are mapped, then no need to attempt this. */
+	if (!old->anon_vma)
+		return false;
+
+	/*
+	 * If the old VMA is a child (i.e. has been forked), then the index
+	 * references multiple VMAs, we have to bail.
+	 */
+	if (!list_is_singular(&old->anon_vma_chain))
+		return false;
+
+	/* Otherwise, we're good to go! */
+	return true;
+}
+
 /*
  * Copy vrm->vma over to vrm->new_addr possibly adjusting size as part of the
  * process. Additionally handle an error occurring on moving of page tables,
@@ -1151,9 +1402,11 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 	struct vm_area_struct *new_vma;
 	int err = 0;
 	PAGETABLE_MOVE(pmc, NULL, NULL, vrm->addr, vrm->new_addr, vrm->old_len);
+	bool relocate_anon = should_relocate_anon(vrm, &pmc);
 
+again:
 	new_vma = copy_vma(&vma, vrm->new_addr, vrm->new_len, new_pgoff,
-			   &pmc.need_rmap_locks);
+			   &pmc.need_rmap_locks, &relocate_anon);
 	if (!new_vma) {
 		vrm_uncharge(vrm);
 		*new_vma_ptr = NULL;
@@ -1163,12 +1416,66 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 	pmc.old = vma;
 	pmc.new = new_vma;
 
+	if (relocate_anon) {
+		/*
+		 * We have a new VMA to reassign folios to. We take a lock on
+		 * its anon_vma so reclaim doesn't fail to unmap mappings.
+		 *
+		 * We have acquired a VMA write lock by now (in vma_link()), so
+		 * we do not have to worry about racing faults.
+		 */
+		anon_vma_lock_write(new_vma->anon_vma);
+		pmc.relocate_locked = new_vma;
+
+		if (!relocate_anon_folios(&pmc, /* undo= */false)) {
+			unsigned long start = new_vma->vm_start;
+			unsigned long size = new_vma->vm_end - start;
+
+			/* Undo if fails. */
+			relocate_anon_folios(&pmc, /* undo= */true);
+			vrm_stat_account(vrm, vrm->new_len);
+
+			anon_vma_unlock_write(new_vma->anon_vma);
+			pmc.relocate_locked = NULL;
+
+			do_munmap(current->mm, start, size, NULL);
+			relocate_anon = false;
+			goto again;
+		}
+	}
+
 	moved_len = move_page_tables(&pmc);
 	if (moved_len < vrm->old_len)
 		err = -ENOMEM;
 	else if (vma->vm_ops && vma->vm_ops->mremap)
 		err = vma->vm_ops->mremap(new_vma);
 
+	if (unlikely(err && relocate_anon)) {
+		relocate_anon_folios(&pmc, /* undo= */true);
+		anon_vma_unlock_write(new_vma->anon_vma);
+		pmc.relocate_locked = NULL;
+	} else if (relocate_anon /* && !err */) {
+		unsigned long addr = vrm->new_addr;
+		unsigned long end = addr + vrm->new_len;
+		VMA_ITERATOR(vmi, vma->vm_mm, addr);
+		VMG_VMA_STATE(vmg, &vmi, NULL, new_vma, addr, end);
+		struct vm_area_struct *merged;
+
+		/*
+		 * Now we have successfully copied page tables and set up
+		 * folios, we can safely drop the anon_vma lock.
+		 */
+		anon_vma_unlock_write(new_vma->anon_vma);
+		pmc.relocate_locked = NULL;
+
+		/* Let's try merge again... */
+		vmg.prev = vma_prev(&vmi);
+		vma_next(&vmi);
+		merged = vma_merge_existing_range(&vmg);
+		if (merged)
+			new_vma = merged;
+	}
+
 	if (unlikely(err)) {
 		PAGETABLE_MOVE(pmc_revert, new_vma, vma, vrm->new_addr,
 			       vrm->addr, moved_len);
@@ -1486,7 +1793,8 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	unsigned long flags = vrm->flags;
 
 	/* Ensure no unexpected flag values. */
-	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
+	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP |
+		      MREMAP_RELOCATE_ANON))
 		return -EINVAL;
 
 	/* Start address must be page-aligned. */
@@ -1501,6 +1809,10 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	if (!PAGE_ALIGN(vrm->new_len))
 		return -EINVAL;
 
+	/* We can't relocate without allowing a move. */
+	if ((flags & MREMAP_RELOCATE_ANON) && !(flags & MREMAP_MAYMOVE))
+		return -EINVAL;
+
 	/* Remainder of checks are for cases with specific new_addr. */
 	if (!vrm_implies_new_addr(vrm))
 		return 0;
diff --git a/mm/vma.c b/mm/vma.c
index 5418eef3a852..09027448753f 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -774,8 +774,7 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
  * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
  * - vmi must be positioned within [@vmg->middle->vm_start, @vmg->middle->vm_end).
  */
-static __must_check struct vm_area_struct *vma_merge_existing_range(
-		struct vma_merge_struct *vmg)
+struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *vmg)
 {
 	struct vm_area_struct *middle = vmg->middle;
 	struct vm_area_struct *prev = vmg->prev;
@@ -1756,7 +1755,7 @@ int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
  */
 struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks)
+	bool *need_rmap_locks, bool *relocate_anon)
 {
 	struct vm_area_struct *vma = *vmap;
 	unsigned long vma_start = vma->vm_start;
@@ -1782,7 +1781,19 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	vmg.middle = NULL; /* New VMA range. */
 	vmg.pgoff = pgoff;
 	vmg.next = vma_iter_next_rewind(&vmi, NULL);
+
 	new_vma = vma_merge_new_range(&vmg);
+	if (*relocate_anon) {
+		/*
+		 * If merge succeeds, no need to relocate. Otherwise, reset
+		 * pgoff for newly established VMA which we will relocate folios
+		 * to.
+		 */
+		if (new_vma)
+			*relocate_anon = false;
+		else
+			pgoff = addr >> PAGE_SHIFT;
+	}
 
 	if (new_vma) {
 		/*
@@ -1813,7 +1824,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 		vma_set_range(new_vma, addr, addr + len, pgoff);
 		if (vma_dup_policy(vma, new_vma))
 			goto out_free_vma;
-		if (anon_vma_clone(new_vma, vma))
+		if (*relocate_anon)
+			new_vma->anon_vma = NULL;
+		else if (anon_vma_clone(new_vma, vma))
 			goto out_free_mempol;
 		if (new_vma->vm_file)
 			get_file(new_vma->vm_file);
@@ -1821,6 +1834,14 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 			new_vma->vm_ops->open(new_vma);
 		if (vma_link(mm, new_vma))
 			goto out_vma_link;
+		/*
+		 * If we're attempting to relocate anonymous VMAs, we
+		 * don't want to reuse an anon_vma as set by
+		 * vm_area_dup(), or copy anon_vma_chain or anything
+		 * like this.
+		 */
+		if (*relocate_anon && __anon_vma_prepare(new_vma))
+			goto out_vma_link;
 		*need_rmap_locks = false;
 	}
 	return new_vma;
diff --git a/mm/vma.h b/mm/vma.h
index 7356ca5a22d3..fc4f8352ec6f 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -260,6 +260,9 @@ __must_check struct vm_area_struct
 __must_check struct vm_area_struct
 *vma_merge_new_range(struct vma_merge_struct *vmg);
 
+__must_check struct vm_area_struct
+*vma_merge_existing_range(struct vma_merge_struct *vmg);
+
 __must_check struct vm_area_struct
 *vma_merge_extend(struct vma_iterator *vmi,
 		  struct vm_area_struct *vma,
@@ -280,7 +283,7 @@ int vma_link(struct mm_struct *mm, struct vm_area_struct *vma);
 
 struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks);
+	bool *need_rmap_locks, bool *relocate_anon);
 
 struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma);
 
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 7cfd6e31db10..3d19df8fa17b 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -1543,13 +1543,14 @@ static bool test_copy_vma(void)
 	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
 	bool need_locks = false;
+	bool relocate_anon = false;
 	VMA_ITERATOR(vmi, &mm, 0);
 	struct vm_area_struct *vma, *vma_new, *vma_next;
 
 	/* Move backwards and do not merge. */
 
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
-	vma_new = copy_vma(&vma, 0, 0x2000, 0, &need_locks);
+	vma_new = copy_vma(&vma, 0, 0x2000, 0, &need_locks, &relocate_anon);
 	ASSERT_NE(vma_new, vma);
 	ASSERT_EQ(vma_new->vm_start, 0);
 	ASSERT_EQ(vma_new->vm_end, 0x2000);
@@ -1562,7 +1563,7 @@ static bool test_copy_vma(void)
 
 	vma = alloc_and_link_vma(&mm, 0, 0x2000, 0, flags);
 	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x8000, 6, flags);
-	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, &need_locks);
+	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, &need_locks, &relocate_anon);
 	vma_assert_attached(vma_new);
 
 	ASSERT_EQ(vma_new, vma_next);
-- 
2.48.1


