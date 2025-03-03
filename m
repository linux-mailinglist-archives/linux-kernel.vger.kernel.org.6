Return-Path: <linux-kernel+bounces-541516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D984A4BDC9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AB661893F56
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088181F8EF7;
	Mon,  3 Mar 2025 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fSYIRZ0T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fCyoSMB9"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE941F55E0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000148; cv=fail; b=Bwr0/Vx6qliMiN3j6rHgfwqhqaJg9o4sYuN/bF7vjrMdj/9L65DFH6io0uldcfdwFP47SloK2eTvEfuIf8Qi86YN1OTgwP8/WUTy6Lc6K/PHtEiWq9m9bdf2jW0OgpV9eZrSZbSOoKu9GNdSc/ORA5GS0iaDS4u2sk2akYpwJM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000148; c=relaxed/simple;
	bh=l+S3ATL6T2jKHoQKglVs84vPDW3cdJ0QU+rEn5fXt8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SGgnrUBUHq3Rpra983sKbDMV7znHgSKPoibX+ThH7vb3EBaLXErlnCz0cpC4LLZ7z+v/S/lqr1FnS00QelELja18iPMW6jg9wDELAFQDQocgGDTT945CyX9pOq72RbLGWSZuuCR06bDj87Ef5PhgN6ZjqP3vNUgdv6SwhabIcQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fSYIRZ0T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fCyoSMB9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237tv4m016064;
	Mon, 3 Mar 2025 11:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HV0nA8fVEHBYsnfvmnLWo4AORBJmffnzXGZGvQs9WUw=; b=
	fSYIRZ0T3RIM6ANPjCBIgy70z9BDwUEbCIHz6OLQDGyX5RbgVimNLzQABxYwWBl4
	mDPfk2WuRQuFkaIVJOkHrz3QaLpHqQ7xyeuiVyfO6blbrbDNix+srBuYUf7oHGru
	Tsw8cf0rZPVrXfSHQytcXdbbKOCoWNaxrPfGLNzhiJ9Dax8T/OLF2GXjyJXAUrHQ
	LibSLMYrOiVzv/TCWquhOgTFFaNIeWZokHSWNNjxvzMoSZIRzTKi3rywbwuMD9Vv
	fMsXiNcyAdUAGUoJ3Z6XZ6oAolURqomdoVfICj9oAVms3vhQ70pnhgzE1pZhwbyy
	+/JwjZdOQ/5jqRq1W59zoQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453uavtcb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:08:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523B8Vn3039757;
	Mon, 3 Mar 2025 11:08:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp82hk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:08:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpItDKORp5aiONABgX+TShqtDtEqWJUBIM7pHk4W/cAeId0Byy35AG6fe0helJ61ZwVdyVLbPH+vIMeJhdmm4h0tzVni7MveZFnR66+9cZZZphfE8ViFKBTyxpUe+Ojl/tAj+SFlH+RMXh/u3IcCYcvtJbhSydWuhlZoOswIbBZqs9LzydAblcz0dq0woASntVAONCllpGNri0qNzedJ9hovr1mcNf7BsT7Hz5uitVQ9gZR6JPMuhWFSIsjQQB8avDnUnLsxbOwqEl524fQ+Ptm5Uweulk1Wn8sou1vxqV0ysGCU2YEMVRmjkZ4ThjRdMRSH5tMp/S5xDPmfsElQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HV0nA8fVEHBYsnfvmnLWo4AORBJmffnzXGZGvQs9WUw=;
 b=LOfBKXWWh3pmlca2sDWh2fbImO4v1KggiZ813UVI6iOPQgDk0RaUxNdZ5TmGgFlHCky5AfqzmubZUZOF8v4Yu5PX2JWTju2Cs5iujDV0C3oS3GEuujWF+4MprWfsWCbDTT4EyxT2nb5FM2LCA794uzwXrbWiZY4yInYDbFyzL63omB7bxjEjep2Lgql8phxYB8p9VJssU9Vo6FdQnq4FQsyhy5zyskD1qRDGv1pukB1RkFWKO9QIr2ksBG9PQ1vpzvaJEIstER8rKzUZrSQuIId/KbEloYW7/qTvXxCsvGbcdUtpygSp1r5qm7gRo5iLQ8gP/ThFuM2N8nrFwr/dDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HV0nA8fVEHBYsnfvmnLWo4AORBJmffnzXGZGvQs9WUw=;
 b=fCyoSMB97goD21xqdLjpNkBLCU9AqE5H6UcD122r/vvDjGfenhLLfzU+Ikdd23DtxUJxB+muV1g5VeBOsFNQtTccPa66jBP6aB1pOE1ritztIkaHt4IrlvPEGHymQUxgflqn9YkA0mmtYWY4DwC4bVjtP0vKByN1vc8q/fn4qyc=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 11:08:49 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 11:08:49 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] mm/mremap: correctly handle partial mremap() of VMA starting at 0
Date: Mon,  3 Mar 2025 11:08:31 +0000
Message-ID: <195c3956c70a142b12465e09b4aa5e33a898b789.1740911247.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0504.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::11) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: f92b301d-c69f-42c6-7d6b-08dd5a43c66d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T6y5E6EJqmOSlFMiEdXEIfbL8LvCF7hRm5lwAZ70ucvDWLqKAttDBL+h/fCr?=
 =?us-ascii?Q?9uj8qkF3ETuKvxHRrSC8tfxYsHetQxTxQQvopLY1g5z19fPCCRk5rz7Fio4a?=
 =?us-ascii?Q?AAIJqi++EZFPLlGEf6Aq4lO7xUw1AwjYwYMKBgW/DiKEuSU/9QMPpvo9XOaS?=
 =?us-ascii?Q?T7KIeYeVST4t7j1OGkEhP02PVj70N8vynUWAHr8mZYjBdGMLSgEa5dPyZpbm?=
 =?us-ascii?Q?hRXAmSNp1+mSEG8B4CXk4zJ7Vcx2EAM/2+B6BsXr37Xfy3CRi7giz4Mq9j+Q?=
 =?us-ascii?Q?gj8+DFKmi43OVeGjKBcE2Vqll3dUH9sQcoBH3Y6cEo0s7Oz/s0zIRw54g1AO?=
 =?us-ascii?Q?mGwO0z6J3D3Vg+X1MTTFEkgiGhYn5gNq+SewpYFp81Q2SIR77NK2z8EdfGoj?=
 =?us-ascii?Q?/cB1fAu8i1AvIQaoTrySMbylmGA1xJkufrB4ZxUo08yO+15xyXMXI0yJSwmv?=
 =?us-ascii?Q?4IHt6XzqKq9abLJjnrhUzv66bQrbLjpgD27Az3Om3uMTNkshWdvRuoj2tXDe?=
 =?us-ascii?Q?o5MS7/e0t0iqkzlMY36RIEXHh/gotSfpZpLI8LqjwKwaM4zdHTXVMA0f2sdJ?=
 =?us-ascii?Q?b6RjF5cRi2vkXsmxNbdObsM7log7e/JszrWQ9Wa01dcoMb8Z6GOh39dx3XuZ?=
 =?us-ascii?Q?89SuFGeVYJp5/sI1jOGdyvT8E4DiITr5Z12OemtYG5DU4XeBqp/leA5RUXml?=
 =?us-ascii?Q?b6RCumCtvRwxb/mmPANJWyKvk2ycg2sQ90ogsRz12cLEwxp8jH1dxPw7Rnu1?=
 =?us-ascii?Q?M/4FVdfvUleND7JqyYt20uXYO/lafrabflXuVtprGR5K+Ea/KlEKKj/UenjE?=
 =?us-ascii?Q?kLv/ki/CYNPehLs67hql+6euJ/OJhCLGWk2m+gFrItrpFgGymi/Af+gRBC9u?=
 =?us-ascii?Q?TKruXtYUTkj1+QOcOlwY3/weKP7lUfjdv5Bzu7aMm/7soGIvHP9nIcsyfrxX?=
 =?us-ascii?Q?FxFDrHLaVYFx49u1dcXBDMW5eLnMayPT5WNuaqxWbryOiuQ5L5fZwnTU8Tn+?=
 =?us-ascii?Q?D8LKjcNRSsNNS+iWiRIEe0tKm3eEsh13AwR6LQhpFqAEnjWKYIHoXIPjhAzm?=
 =?us-ascii?Q?tIYrLCho7keshx2JOgeZPqk+wgq8cAaSJu/BDPvYiw6MzVuqdG4wjj7iYwJ7?=
 =?us-ascii?Q?sngAmEysz/6ZWOlZ19AHKCrHF43r3L+WVh+2AWLfWIT89+uFl3ix+KNaIwCu?=
 =?us-ascii?Q?BQ+tyoby6gXkbWt3aeZS1OkGaWnqH1LNBy/uXWTk4kikFOoJnb7mRPGfvylZ?=
 =?us-ascii?Q?2fpLpuGyFQjita05nM4fkObCIxMN6ePCen8GRs3QdAxIvihPMABzGDt3a90N?=
 =?us-ascii?Q?WEmzVKjjeQa1lqjvxa48iscjKckHR8Y0EuKOfXpheEtsuRuWj3vAoraSebgr?=
 =?us-ascii?Q?zFo/o2EcRR2oqfORjKPRoxh4Ll0U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hSBHCYHVUEYlmMiYa1gjpFdhR/6W4s7R7TYpTv6gQrDpmqA0x81P+UIrZeeE?=
 =?us-ascii?Q?gsGlBYa/KbbF6mfz45/xt51PAY/2RQL2XafaNMylcNCmIwneW8Qp37/1/XUF?=
 =?us-ascii?Q?LjU12OikzXYlWkOJWUUw6Bx5grG3G3hYZPql8/WfV8JVRO3oDVS/+N0CiA2/?=
 =?us-ascii?Q?VH4EfFUcsQsnBs3Hn+6gD8SmNikRmcXx6WBa5Dni+X/Bo4ouXyIcnwJsh1K9?=
 =?us-ascii?Q?sIFh4cDgSS8i6Lz0w8g5Z3fSY8fOxIA1gnZ6HKwu9E8sWchvy2Rnp04WRHXr?=
 =?us-ascii?Q?r+DWZXnSkEZY3BMg2qIGCiuQRbUJtXW+kqtG+LjHX6wsMuV1QbARD7nE8N0s?=
 =?us-ascii?Q?Ug4ZPgKA4vqyex1YSmHCabUbCwgWnSff76yVpNNL7TzZn3uQrNAilNKQ2GGn?=
 =?us-ascii?Q?ySdrxnHDwGeveHyWTIhyFE25/1FoJi/tMp2DY8/PzC3EiQYjzTdLEhvw6Vnl?=
 =?us-ascii?Q?jcjOT0eiMvxh4H3yiVAyeZr1Vx6cs/uxDXyQcIIto7UebV+3pVX3XQO1XgRq?=
 =?us-ascii?Q?+JgDzw023rFVkBj6fBsXjPuU84xWdxDLXTrrVgrR8zyfyIW6YJzXLSZglzfs?=
 =?us-ascii?Q?Bjv4lOm1w4PbkZpPweKhrXi0HKlkP9dzFpWCr00XiCzxwikUSI0zPSyrextM?=
 =?us-ascii?Q?GawdByyYtp0fNZnoaXOh9vAekDo5IZvDA65EmA3uUjEGn4/hX8yDCLew6tNL?=
 =?us-ascii?Q?sKdWVq6346g87kMVMlV8xqE2OsIHu5RskkTSZabxjKkX9AEzywijjCi60DLW?=
 =?us-ascii?Q?gdQYUfg8xPOXGHf3zQ4ijB6BmYlLmkzabzyFTwYyWRtMQyvrdyr+phn1TiN7?=
 =?us-ascii?Q?ZHl3Q5X4EpvsmmuUrnUFCXUc+gXC81tVddiBllUmHDBqf7Nho+vHT2X2C7sJ?=
 =?us-ascii?Q?gwHuioFOmZtGhhQxquucp8m8bfqjAIfby3svkx4S4JL3LQRyIJGhpZ2Q1FZV?=
 =?us-ascii?Q?iox1JoFrQ7Xwlt2g8+/BG7CeoayIKEz4sPPh+F4WXL+i+9K+4BM0yJQRhcIr?=
 =?us-ascii?Q?6v1QGFupZlhMC6ZvIP3S+1PPlgzRauCu8vOxjil2PoF9xEKnJzEHxLPMfTsl?=
 =?us-ascii?Q?3EBuy+IuhvLPuHeLCv7XVM9n5mW2BQQnFJ02uwmy5cO+X1uch5S0LiefDKHA?=
 =?us-ascii?Q?dWGYjECqNNlQTrH1ziSw8J53bXgWWF2LYBHdVAAWFpDcZr2IfZ6c4zYUdbEz?=
 =?us-ascii?Q?eZYcq1vBSWTFdjDfHUccgI7SnbGgUczxNMeMP5QIPU1xHLtFsGziRPDelOo5?=
 =?us-ascii?Q?K90urTYrifaEwodZPJwnIDS1ZBBx+aFByIlv7kfNOLZGPFEw/qrXV+bQiOA5?=
 =?us-ascii?Q?iTpIrDBKm5w+93YHasR8VwhKivms2axf8h7MLqxs6uLnaGl1r6SbZJxMpTmw?=
 =?us-ascii?Q?upC4VDnw1QLVr2sWi0qkyNyWsjGDoFvf8F0l51IBNMfRbZgR8rIHdGxNv+pj?=
 =?us-ascii?Q?lqzrW/mCv8xvE9sL7lKNzqm0y/cI/N7ZSar48magb5mfhH+ygGrn4fvDLt9h?=
 =?us-ascii?Q?bssbUA/icQk5hv4CnDSTVKTmpa2L5JRo39hSuH9p/kh/FmpCCk0c2PUZf+XG?=
 =?us-ascii?Q?OKXic5CBW71rsXglEa0wrGI24bkw/mZ+d0SnAnGNExKaUt9NeXuu0dNG1ZDl?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TWBlRyQuYgbYvJYXVUYFy9wfgEU1o7ki/yjbEzhc6TB7uM3WClxYSN2zf3VNOCP/gs0f1/ZuLe/gok9PTb5DbA4jcXgCm2PVKPurF061k9EsBPc/gXmuSQYpQJ8qIrdnw7JrMw5X13p1h7cekBw76h6mUBbDrwtDBT+1mwHMzBwI5imG6WjfHYDZWkiyFjN3o35AJ+jEZoqU6kR27EO+bk/jhHQ5wyfQd0H4dGNYIxUcPEwcE7LuOPuTNqNar37Tc7s0XjIMCQB9HKBMw6ycufXpAiX8ucpsJuRP+jByxbg9IT089q2xvTruwUX7ZxBwPMbsjuvpkg968qJRuty+bXqC7dv+K3/3DN/Eq/Tu4S7m23pzdv2vYrWQOp1xAHi9JIbztrceFsXB/VedLYiIyQ3Mph2gH0qe8/Ovm5lyjNC8Q3Zy2X0OuC8aSALcZh8ZdYIMMDU+YhAhQRza37KE2KLnI0afFrtEaJX/KmKJW4v58kKSnFEj8hzO6XdRwS6YzXqy0YYRvTfXDMU427LdSgan7KkJUaqRJ0U7fnF5vypTVKsGDVekNZ2biTl5nm9SIlXPxN/hKk7lYyHzDvuvSR1UoO+eaN6svYB4cU7gsnI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92b301d-c69f-42c6-7d6b-08dd5a43c66d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:08:49.6883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wm+aMh6Sdh+emjnIjAn8XP1KWc6vfSvbfPLPlO/vQUnRkKMPMaRjgxFE62IJzNzgdWUqjmsQqKjqzbfeHpno9vLdA/78C5frbxgG711TcBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_04,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030086
X-Proofpoint-GUID: _WMfokXnu693j8rvK5mCMsElVSLfoKoy
X-Proofpoint-ORIG-GUID: _WMfokXnu693j8rvK5mCMsElVSLfoKoy

Consider the case of a a partial mremap() (that results in a VMA split) of
an accountable VMA (i.e. which has the VM_ACCOUNT flag set) whose start
address is zero, with the MREMAP_MAYMOVE flag specified and a scenario
where a move does in fact occur:

       addr  end
        |     |
        v     v
    |-------------|
    |     vma     |
    |-------------|
    0

This move is affected by unmapping the range [addr, end). In order to
prevent an incorrect decrement of accounted memory which has already been
determined, the mremap() code in move_vma() clears VM_ACCOUNT from the VMA
prior to doing so, before reestablishing it in each of the VMAs post-split:

    addr  end
     |     |
     v     v
 |---|     |---|
 | A |     | B |
 |---|     |---|

Commit 6b73cff239e5 ("mm: change munmap splitting order and move_vma()")
changed this logic such as to determine whether there is a need to do so by
establishing account_start and account_end and, in the instance where such
an operation is required, assigning them to vma->vm_start and vma->vm_end.

Later the code checks if the operation is required for 'A' referenced above
thusly:

	if (account_start) {
		...
	}

However, if the VMA described above has vma->vm_start == 0, which is now
assigned to account_start, this branch will not be executed.

As a result, the VMA 'A' above will remain stripped of its VM_ACCOUNT flag,
incorrectly.

The fix is to simply convert these variables to booleans and set them as
required.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Fixes: 6b73cff239e5 ("mm: change munmap splitting order and move_vma()")
Cc: stable@vger.kernel.org
---
 mm/mremap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index cff7f552f909..c3e4c86d0b8d 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -705,8 +705,8 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	unsigned long vm_flags = vma->vm_flags;
 	unsigned long new_pgoff;
 	unsigned long moved_len;
-	unsigned long account_start = 0;
-	unsigned long account_end = 0;
+	bool account_start = false;
+	bool account_end = false;
 	unsigned long hiwater_vm;
 	int err = 0;
 	bool need_rmap_locks;
@@ -790,9 +790,9 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
 		vm_flags_clear(vma, VM_ACCOUNT);
 		if (vma->vm_start < old_addr)
-			account_start = vma->vm_start;
+			account_start = true;
 		if (vma->vm_end > old_addr + old_len)
-			account_end = vma->vm_end;
+			account_end = true;
 	}
 
 	/*
@@ -832,7 +832,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		/* OOM: unable to split vma, just get accounts right */
 		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
 			vm_acct_memory(old_len >> PAGE_SHIFT);
-		account_start = account_end = 0;
+		account_start = account_end = false;
 	}
 
 	if (vm_flags & VM_LOCKED) {
-- 
2.48.1


