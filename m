Return-Path: <linux-kernel+bounces-308870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB299662EA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800AC281650
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACFA1A4AB3;
	Fri, 30 Aug 2024 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gtK2TRuS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WSdYe/f0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F7413635B
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024556; cv=fail; b=K6xJnUZMw8Hy5uBwuOwQNB8mmt1/mTP2HEdVf2fH8T90DGN7XU9cFOL3h5hkefZ86c5U/DoLhGt3Ivlw0xq+K4YxsAYbiEyOHS67dE0YhcF4QqwgUq4kTUqDqPn4WncazURcvKDNkw1oEg7oq/xfC5I0revNlIulzFHo28CgOg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024556; c=relaxed/simple;
	bh=TpSx8bayxB1P+rNjgEh++t1NqweKw4dztJvbHnJ+OgY=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WuJx/U9F41o29pHop+zyKK7g42lAbMhlQAhkmw7hZnKPfkk2QlohOWBu4uCampE/bJIw0e06w427R88vCRvSFKME2xKsQLv260DfJNmAvaL/ETcKk79PbIii7JYaCflDSQkaDnjsXWSIMgQ5qwsR8qrSpV9+tF5lH9GGN4rvYvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gtK2TRuS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WSdYe/f0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UDMWVR019211;
	Fri, 30 Aug 2024 13:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=jSoZmVXALlJAWS6
	HNr+Ia0yZeoeHnoa6s1VIIXr4sO4=; b=gtK2TRuSODm6PR5jADSPFuLomwTwPcO
	9sZHPsa1nPLlo9Zo4mLD4w88XCCodVyPegzi2C4bHKniANSsN8LWAr2EVguTFV2g
	aLvK2m+eblbDPP4g5ZXTeD0/7x2FjWLLrWcLnFKsq7a2B/bBgfBuRUee6nc2VYnT
	xtex15cTZ2TVaGfsk5oXK75LWadfqSSw1wKWxYzb5NIzXcL737uqanKDWqs3XXVO
	3xwydt2GLUL+/CQqZ5iBMe+KjAYxiC2OvxAE0MmAJzwZrq6rEOpsQEOSTWHI3Slf
	xuTGNrx4/r1SooaEXd+RxBs19eaVk1HUoug9LtGyQTakeoGS1WTZtnw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bd1107kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 13:29:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UChkLv034856;
	Fri, 30 Aug 2024 13:29:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189sxd96f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 13:29:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBKuqjsrGmWItZ3Xd0JB4YcETRIdsT0A/+7esw1po61I7llEooBW9KKC/4AC8t/EOf2dS8UmrIFsmfnCnR2IG1+OZ/iNfP/wZynzW2ToiXzg7SiZ95Q6dIrrw6wzlvnWKTy0bF3sErDPcSpaw4w1LimxePRPKLmROm0hQUpTO7ginWW1Zj9OuVXsIpyiQIG9yaVMgoSXmhpTkfnjLSepcW8UVoXqL7mgWPPtZaJ8Fm+WAP4kDm7s5nxyDg3n8JgdqpYMD+itw1EZGT22xAwPYHJpnP8HXA15t9gksXwpEOjni5ABm7diIq+6PKfRYmNay0eqHFiCzEXeUaEKWyYv6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSoZmVXALlJAWS6HNr+Ia0yZeoeHnoa6s1VIIXr4sO4=;
 b=ldfDKnunxzXgi/75hnoA8K4vHAAulVwY5sMGGDd0YPxhXXXOryVx2sHqaTsW4rpEt+ka9+tYDDUu6S4nK960lBjb2u31xcq9NRpHZDZFtFPUCaM1ea4UNkZJfE+Q54+W+fDjarVwRD9U4o7vpChEh3jhdCICDx/K0yVUbYk7q5idveTzpOdRU238lnJ4TNXJkB+ND2zkqdwEaomsonF4Zaox2xNzOwsqfJYf4O565ynXIcTg9nvjdpiCSqktl2DykCKmWZ1uJZG2PBmesmfMYNytNLTta//KAeaACWdzwAM9HVSn1iXz19YbYlak15PpUM5MqhgHAto7oIE3j61XKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSoZmVXALlJAWS6HNr+Ia0yZeoeHnoa6s1VIIXr4sO4=;
 b=WSdYe/f0tD0yifSGBDMx8FQ9TdcmqVhxtfogJeOIKmKotiAnhsxXygIg3wGVSKj1KI5VMIoEHj1/3FsQA3JyyogD6HJvNPxtS59ketd/1rwIMQUmqTDwd+R0DLInyJQIBoUBk/mbiyu+xZR2CVjI6vw9z88ilCiLFtGfgR8QPFM=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB7320.namprd10.prod.outlook.com (2603:10b6:8:fe::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.20; Fri, 30 Aug 2024 13:28:59 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 13:28:58 +0000
Date: Fri, 30 Aug 2024 14:28:55 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 03/10] mm: introduce vma_merge_struct and abstract
 vma_merge(),vma_modify()
Message-ID: <e6a1d727-b65e-4ffd-8ce7-00ea12316553@lucifer.local>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
 <ecce1383916a978fba6b75dcbb74132d8bb1eaa6.1724441678.git.lorenzo.stoakes@oracle.com>
 <mly5jrnbqstukybd75wse3toj4zgb2s74rcdqausorkphtfigz@oo5s4oqtia7o>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mly5jrnbqstukybd75wse3toj4zgb2s74rcdqausorkphtfigz@oo5s4oqtia7o>
X-ClientProxiedBy: LNXP265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::26) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: fc076e5c-4448-40e1-bfcb-08dcc8f7b42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gzL9psFNRMDqnblzILmQMDzLhhMdJhvAbL7qGQ1kcBJHBCZEkYjBV9leGMZH?=
 =?us-ascii?Q?90S13XpktNNwDKBh/Oi36YOhNcNTmFP09lY1AdNR0CXvjeZxxQgQpl103a2T?=
 =?us-ascii?Q?+2Tielzj4I29CJXT7r1TAV22FdaslXJQ77PoepJjXZuwZPgwnyzrxf9aLYM8?=
 =?us-ascii?Q?rTcw1FPaRg3iuO/iD2WnyfMBD8R70mgoML3X9cwJm3hoh09ZqqyacaPNELLQ?=
 =?us-ascii?Q?n+Miv9AP7cscovtS21ErkyxNl0hCj4HkNfCB9o+UebdoJ4ViAcD4JHmi1E6b?=
 =?us-ascii?Q?q/xRKHYxDKLfO5BGx4DorWG/ons1G2++hKs4ugBJ6JJp6hJUvVQD6ssr6CEt?=
 =?us-ascii?Q?vUmCbfPau3gNZn16Mf9WfIKlQafBrMXL2SMdCVc7ha6AVj6097IorDcW+5cz?=
 =?us-ascii?Q?37jgkgVZdL/drPTqXFlsmr1XO9na+QvFOo+Ul354mahb5wP4DqjIGkn+XnO5?=
 =?us-ascii?Q?Cq2719fA2y4XBxGoMlpFCE6djS07PcriMp/U0atJIz1z0bbiJkdYX4gibRWq?=
 =?us-ascii?Q?zlKxFbnq+giC51xlBPl0Ub1WV+o/g2TRMfbhwYDBRrI1cdGHG8zVCGNIF3XV?=
 =?us-ascii?Q?YpBYs3uxA52tIU1EX/FvfR6fMRdSPPTKbr7nQFFjYT9h/cA7U9Rv10bdiWuP?=
 =?us-ascii?Q?5kwUyYzBd2zygjWe1XH4fLYdaqg5/K9lO6KlXb9duWIy2G4m7HacNTi8nwSM?=
 =?us-ascii?Q?YiZxHL7W9PvtVF2G504hCT480kWR+/jJkUdzQMnSohXZZ3uG77tV53+DBIRU?=
 =?us-ascii?Q?7SNSZ96fe6Dc//ihVJIRrugteOyKG0sQU9I6t6VMikz30CQu5qiPbcRZrABi?=
 =?us-ascii?Q?7R1rGv/Hs9ssC6xHGk8Tktvt1Q41PnTwwVzhzmq9e0EiXzwx1cFY5EHTCt55?=
 =?us-ascii?Q?/MWN3RkuDgUxFkOm5uZI2gGtpmJ/+wStM5gUM4BqfbLy0c8sP9E8dWDH2v/u?=
 =?us-ascii?Q?UYshmPX3EtWW/eymB8MWvVqKuPQ3ArEttCe7suEl/D36xJnPYyt6nGR4kUTP?=
 =?us-ascii?Q?6VgviMijxyO2mDznREKPcY9H3XA7S/o7n0k4wzuhnn4jheBiBc2hGpfFpnOj?=
 =?us-ascii?Q?TVT9DM/TVG6E3gSuGkurI8Woc7RyZOl9tgzxJACHyodSa6adr5MuHax4q7GG?=
 =?us-ascii?Q?5v8vg2/qkXSOSWE2csClGf3/DUhu+ntiPPYDYMVYWOl27ZVpQPcVyGlFghCH?=
 =?us-ascii?Q?VfNczknFbvwh51BWnR1FC9TN/AqaGcJ7RhFWUZJZfHKmWQCixxpZbtKc+g7e?=
 =?us-ascii?Q?xXBUzbsl35JVEAFBosjNJnGeVtpglWodTKfIWw0X8+17mSbijK4zOms0F7Ew?=
 =?us-ascii?Q?BjZYa6f0fBeK7aeEnLnZVb5+2rXucQf5/Pj0oS4O8IBGqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jWjv12RzaembPWOHxez6hdVzb+JvwovzOLjEaf3jsiFFKKEiw7xuvTyWUC5r?=
 =?us-ascii?Q?ZrCr3bXK9l7/mcGzzIokmxJCn817fW/sfl83nlbOMmt3XzUIFCPfWlxwnCHm?=
 =?us-ascii?Q?B7b0bHFygWjLd5z6C886o8VYWi6khqswvsloHLXzOlre4BZMJG5QnkEDJLP3?=
 =?us-ascii?Q?XDJCwbS0ajpZll+yqxFKCNVq9JPH1u04vgMWyigOv4kzYW+UfLmWsdXFu9xO?=
 =?us-ascii?Q?0FTOMJWzhYSKra39GICxOhCRcB7D0B8r5LMRhUlTjku3C7DAkxwpp+uGHnKT?=
 =?us-ascii?Q?Ygl2bITwalv8WtwOUgcyJRez0xC0/rCo3Kn9oA2HG7i3+UyK33w4/gENNrRx?=
 =?us-ascii?Q?7U+VdECFUAZFNpu+DXKobtnJ0+pH02lVpQ4YT8syecEXyIrCygVJRA8ft8TA?=
 =?us-ascii?Q?OTI1LfKltGqgmhRHtJPTYmFbAyQFhKDgm/Cis4GKK14JPQlzyk9PqkaT0FLm?=
 =?us-ascii?Q?+J6rxf1m5tfwpzOyF4o+0UC2SBL5AX1wtRFq6MtcS6XDhb/XeeUIB5AzQiUg?=
 =?us-ascii?Q?bOoKjx3T792Qh2LAyjDu+w7Sr6iqTs4I6AAgJGwkvpnKe80wfHEWrYCtRbX+?=
 =?us-ascii?Q?rhmO9O5KYwrokRDOWVU4ewMrKWYrASi55+HLo3hkOKE0k8pD4QBo2jDvzwTI?=
 =?us-ascii?Q?U/Ki5urj3TNl4Jrr+ug4a4Az28EvCyMUnAp+vt8qVVOFJjFQbndzvp7pU2WO?=
 =?us-ascii?Q?R0kWbrpRiRBHCUbz6l7hzjM0KnBKTk9XSTy77mks21X3LxRXqEBKZC9+1TMX?=
 =?us-ascii?Q?FwjN8l8fdqY7vRuuut5zEv+ABCyUq9iUklXXaQ5xuEz8awnHBeJt31xHFx5A?=
 =?us-ascii?Q?6CeITYTDi08509QNO5NUAGwSJ91bhHtVDypQgmy9GTuagC+ytzOUy/t5A8Pc?=
 =?us-ascii?Q?csClTNK95zE/g+ZPJrPqTKyT5jvLJOTJ7697mifyIIsC+lcX8wHvKbHXxsBB?=
 =?us-ascii?Q?uHE7SzpEqlWHLUwlIAxEz+BQWdlzEpLlT1ABFZiIMfomKDKbqVdbi1QRepF8?=
 =?us-ascii?Q?yl6l2NXxg/4kAy2BgfnzrDeRvp3R6yX1KEsWQR/aa3Cu8v7FWlhlBwQyEOD/?=
 =?us-ascii?Q?M+u7TJ184B8ou2NT+2p+aay9lRq0IZvD9hMPDN9DN+dtvgi5szazpQahxzXl?=
 =?us-ascii?Q?/D2Z1gJUbTs0ngT8SD+MQGaj1EMIJrg8ocKVWl/C6ghuONsmDtuH1eLKIWxS?=
 =?us-ascii?Q?BsAf0EyKHrhdh8GQpvh4QntBUaCHqB+Mcx/736Yc3OwPbtN0XA2DtVn0YvZA?=
 =?us-ascii?Q?z06nap4myNBUVahQjHmlafXCjKQlX/35XRJsr0Wuc9qA3CBUBwx97qoOslUZ?=
 =?us-ascii?Q?jBIe5IncBbIK7bFGAKe9zTqS6vJOCKDt26dQvIuy6rgJVtZDIbv9whvoINZw?=
 =?us-ascii?Q?ChCvtF3PgiNkPTK+RAONeLza0QntS2Qt2vlFgcOmko2/Q6u+MGd7NYC4Qf8C?=
 =?us-ascii?Q?VaakJCh8Vz03Uls35LtnNQM+Bh6MhUSl0mWhw12W5Rq8pmQRKXO9zOimEfdP?=
 =?us-ascii?Q?qMQaAjUUeCXA8G1NIAHyUwx3cpcb5fCAtUOrFdXyySMrPts5dRHUGhhybnPs?=
 =?us-ascii?Q?SnGgnyDSNzV1WWTJVpSqoPca7TtR3nDFGEVdnPTTd/DqiHZ3amR2igMuJ5C2?=
 =?us-ascii?Q?97+MA1Wrly+Xn7sZ4jgaQcmFezDOprpSA3wyx+yjRUNSrqLICF/XEYMsdoGO?=
 =?us-ascii?Q?8cJmqA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ee2rFj4sFmQmjrLIcXK9VAbB9aWbU3M8Mc/z8fP2czj+PfCVlcdU7kXKqSHZhX2GlTNPfYLSkPegwNqXlZNDCQmYkh7WEkgOdnNAeBY2Lm6i9pgPLb5Be2OKh074FCblTJPaaXqFXg0eCfk/mQwjPNUe2DO3C+qp02m8k0G6i8hUYJVQ2l6DnlZX4pLHS+vgbdxii+xEYOvjnSBGUFq2xe147Jt2D7FIMA5Aiz9AvCXHUZWPGwj+Pc+MXLqgQWlL/kQ/JMVN4oH8mpVNKRikvGWuARJl/9hJtRz759JeC7Yql+/lVJ4hG/XxBYoUlkEohwkykDfCkEBInelzyTQ26wv9NCEs8neH7VblxELFlQgqvkXeB1yTkn5kJotzzCoh3blpGuOIE6LRLCvfG7PrhRK5mLZXiZF8MBQCJkJDGRIhJvTuQPi3m7XllV5PKbjAexdbxd1C0BXXArKIYnYa/ZJZaATjcQpeXCFr75wLOGM7oS5EtsUCebZzX1tvb9igT+eGOtly9x2QIEgOBFy8nuH2j4xrPFo9bdFkkFu8XjE3fk7U190nUesmZ4ByMjByd+NQINW4zUpQozW6yMuc6ZcK8B4q9P440qLwEgzuLZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc076e5c-4448-40e1-bfcb-08dcc8f7b42b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 13:28:58.7431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+9GWScpKr1N4+xRPQn2lz/DMUQVEKRmqzE687IlpbciVhM6gLrfRUIYJbbg7c2nuPAc88QANNPj9dBTxiR8FFrJFSGvn9QagVkVmUC6m9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_08,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300102
X-Proofpoint-GUID: KXKm1lMUeynF923vyNgh98J_mv6ukjs2
X-Proofpoint-ORIG-GUID: KXKm1lMUeynF923vyNgh98J_mv6ukjs2

On Wed, Aug 28, 2024 at 03:35:06PM GMT, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240823 16:07]:
> > Rather than passing around huge numbers of parameters to numerous helper
> > functions, abstract them into a single struct that we thread through the
> > operation, the vma_merge_struct ('vmg').
> >
> > Adjust vma_merge() and vma_modify() to accept this parameter, as well as
> > predicate functions can_vma_merge_before(), can_vma_merge_after(), and the
> > vma_modify_...() helper functions.
> >
> > Also introduce VMG_STATE() and VMG_VMA_STATE() helper macros to allow for
> > easy vmg declaration.
> >
> > We additionally remove the requirement that vma_merge() is passed a VMA
> > object representing the candidate new VMA. Previously it used this to
> > obtain the mm_struct, file and anon_vma properties of the proposed range (a
> > rather confusing state of affairs), which are now provided by the vmg
> > directly.
> >
> > We also remove the pgoff calculation previously performed vma_modify(), and
> > instead calculate this in VMG_VMA_STATE() via the vma_pgoff_offset()
> > helper.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Some small things..

All addressed except one thing, see below...

>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Thanks!

>
> > ---
> >  mm/mmap.c               |  77 ++++++++-------
> >  mm/vma.c                | 209 ++++++++++++++++++++++++----------------
> >  mm/vma.h                | 128 ++++++++++++++----------
> >  tools/testing/vma/vma.c |  43 +--------
> >  4 files changed, 249 insertions(+), 208 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index e495b0381265..4066c0444495 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1373,9 +1373,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	unsigned long end = addr + len;
> >  	unsigned long merge_start = addr, merge_end = end;
> >  	bool writable_file_mapping = false;
> > -	pgoff_t vm_pgoff;
> >  	int error = -ENOMEM;
> >  	VMA_ITERATOR(vmi, mm, addr);
> > +	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
> > +
> > +	vmg.file = file;
> >
>
> Extra whitespace here.
>
> >  	/* Find the first overlapping VMA */
> >  	vma = vma_find(&vmi, end);
> > @@ -1388,12 +1390,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		if (vms_gather_munmap_vmas(&vms, &mas_detach))
> >  			return -ENOMEM;
> >
> > -		next = vms.next;
> > -		prev = vms.prev;
> > +		next = vmg.next = vms.next;
> > +		prev = vmg.prev = vms.prev;
> >  		vma = NULL;
> >  	} else {
> > -		next = vma_next(&vmi);
> > -		prev = vma_prev(&vmi);
> > +		next = vmg.next = vma_next(&vmi);
> > +		prev = vmg.prev = vma_prev(&vmi);
> >  		if (prev)
> >  			vma_iter_next_range(&vmi);
> >  	}
> > @@ -1413,6 +1415,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >
> >  		vms.nr_accounted = 0;
> >  		vm_flags |= VM_ACCOUNT;
> > +		vmg.flags = vm_flags;
> >  	}
> >
> >  	if (vm_flags & VM_SPECIAL)
> > @@ -1421,28 +1424,31 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	/* Attempt to expand an old mapping */
> >  	/* Check next */
> >  	if (next && next->vm_start == end && !vma_policy(next) &&
> > -	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
> > -				 NULL_VM_UFFD_CTX, NULL)) {
> > +	    can_vma_merge_before(&vmg)) {
> >  		merge_end = next->vm_end;
> >  		vma = next;
> > -		vm_pgoff = next->vm_pgoff - pglen;
> > +		vmg.pgoff = next->vm_pgoff - pglen;
> > +		/*
> > +		 * We set this here so if we will merge with the previous VMA in
> > +		 * the code below, can_vma_merge_after() ensures anon_vma
> > +		 * compatibility between prev and next.
> > +		 */
> > +		vmg.anon_vma = vma->anon_vma;
> > +		vmg.uffd_ctx = vma->vm_userfaultfd_ctx;
> >  	}
> >
> >  	/* Check prev */
> >  	if (prev && prev->vm_end == addr && !vma_policy(prev) &&
> > -	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
> > -				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
> > -		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
> > -				       NULL_VM_UFFD_CTX, NULL))) {
> > +	    can_vma_merge_after(&vmg)) {
> >  		merge_start = prev->vm_start;
> >  		vma = prev;
> > -		vm_pgoff = prev->vm_pgoff;
> > +		vmg.pgoff = prev->vm_pgoff;
> >  		vma_prev(&vmi); /* Equivalent to going to the previous range */
> >  	}
> >
> >  	if (vma) {
> >  		/* Actually expand, if possible */
> > -		if (!vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
> > +		if (!vma_expand(&vmi, vma, merge_start, merge_end, vmg.pgoff, next)) {
> >  			khugepaged_enter_vma(vma, vm_flags);
> >  			goto expanded;
> >  		}
> > @@ -1772,26 +1778,29 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	 * Expand the existing vma if possible; Note that singular lists do not
> >  	 * occur after forking, so the expand will only happen on new VMAs.
> >  	 */
> > -	if (vma && vma->vm_end == addr && !vma_policy(vma) &&
> > -	    can_vma_merge_after(vma, flags, NULL, NULL,
> > -				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
> > -		vma_iter_config(vmi, vma->vm_start, addr + len);
> > -		if (vma_iter_prealloc(vmi, vma))
> > -			goto unacct_fail;
> > -
> > -		vma_start_write(vma);
> > -
> > -		init_vma_prep(&vp, vma);
> > -		vma_prepare(&vp);
> > -		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> > -		vma->vm_end = addr + len;
> > -		vm_flags_set(vma, VM_SOFTDIRTY);
> > -		vma_iter_store(vmi, vma);
> > -
> > -		vma_complete(&vp, vmi, mm);
> > -		validate_mm(mm);
> > -		khugepaged_enter_vma(vma, flags);
> > -		goto out;
> > +	if (vma && vma->vm_end == addr && !vma_policy(vma)) {
> > +		VMG_STATE(vmg, mm, vmi, addr, addr + len, flags, PHYS_PFN(addr));
> > +
> > +		vmg.prev = vma;
> > +		if (can_vma_merge_after(&vmg)) {
> > +			vma_iter_config(vmi, vma->vm_start, addr + len);
> > +			if (vma_iter_prealloc(vmi, vma))
> > +				goto unacct_fail;
> > +
> > +			vma_start_write(vma);
> > +
> > +			init_vma_prep(&vp, vma);
> > +			vma_prepare(&vp);
> > +			vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> > +			vma->vm_end = addr + len;
> > +			vm_flags_set(vma, VM_SOFTDIRTY);
> > +			vma_iter_store(vmi, vma);
> > +
> > +			vma_complete(&vp, vmi, mm);
> > +			validate_mm(mm);
> > +			khugepaged_enter_vma(vma, flags);
> > +			goto out;
> > +		}
> >  	}
> >
> >  	if (vma)
> > diff --git a/mm/vma.c b/mm/vma.c
> > index e5a5e418c7cb..74c627ff0313 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -7,16 +7,18 @@
> >  #include "vma_internal.h"
> >  #include "vma.h"
> >
> > -/*
> > - * If the vma has a ->close operation then the driver probably needs to release
> > - * per-vma resources, so we don't attempt to merge those if the caller indicates
> > - * the current vma may be removed as part of the merge.
> > - */
> > -static inline bool is_mergeable_vma(struct vm_area_struct *vma,
> > -		struct file *file, unsigned long vm_flags,
> > -		struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > -		struct anon_vma_name *anon_name, bool may_remove_vma)
> > +static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
> >  {
> > +	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
> > +	/*
> > +	 * If the vma has a ->close operation then the driver probably needs to
> > +	 * release per-vma resources, so we don't attempt to merge those if the
> > +	 * caller indicates the current vma may be removed as part of the merge,
> > +	 * which is the case if we are attempting to merge the next VMA into
> > +	 * this one.
> > +	 */
> > +	bool may_remove_vma = merge_next;
> > +
> >  	/*
> >  	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
> >  	 * match the flags but dirty bit -- the caller should mark
> > @@ -25,15 +27,15 @@ static inline bool is_mergeable_vma(struct vm_area_struct *vma,
> >  	 * the kernel to generate new VMAs when old one could be
> >  	 * extended instead.
> >  	 */
> > -	if ((vma->vm_flags ^ vm_flags) & ~VM_SOFTDIRTY)
> > +	if ((vma->vm_flags ^ vmg->flags) & ~VM_SOFTDIRTY)
> >  		return false;
> > -	if (vma->vm_file != file)
> > +	if (vma->vm_file != vmg->file)
> >  		return false;
> >  	if (may_remove_vma && vma->vm_ops && vma->vm_ops->close)
> >  		return false;
> > -	if (!is_mergeable_vm_userfaultfd_ctx(vma, vm_userfaultfd_ctx))
> > +	if (!is_mergeable_vm_userfaultfd_ctx(vma, vmg->uffd_ctx))
> >  		return false;
> > -	if (!anon_vma_name_eq(anon_vma_name(vma), anon_name))
> > +	if (!anon_vma_name_eq(anon_vma_name(vma), vmg->anon_name))
> >  		return false;
> >  	return true;
> >  }
> > @@ -94,16 +96,16 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
> >   * We assume the vma may be removed as part of the merge.
> >   */
> >  bool
> > -can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
> > -		struct anon_vma *anon_vma, struct file *file,
> > -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > -		struct anon_vma_name *anon_name)
> > +can_vma_merge_before(struct vma_merge_struct *vmg)
> >  {
> > -	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, true) &&
> > -	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
> > -		if (vma->vm_pgoff == vm_pgoff)
> > +	pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
> > +
> > +	if (is_mergeable_vma(vmg, true) &&
> > +	    is_mergeable_anon_vma(vmg->anon_vma, vmg->next->anon_vma, vmg->next)) {
> > +		if (vmg->next->vm_pgoff == vmg->pgoff + pglen)
> >  			return true;
> >  	}
> > +
> >  	return false;
> >  }
> >
> > @@ -116,18 +118,11 @@ can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
> >   *
> >   * We assume that vma is not removed as part of the merge.
> >   */
> > -bool
> > -can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
> > -		struct anon_vma *anon_vma, struct file *file,
> > -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > -		struct anon_vma_name *anon_name)
> > +bool can_vma_merge_after(struct vma_merge_struct *vmg)
> >  {
> > -	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, false) &&
> > -	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
> > -		pgoff_t vm_pglen;
> > -
> > -		vm_pglen = vma_pages(vma);
> > -		if (vma->vm_pgoff + vm_pglen == vm_pgoff)
> > +	if (is_mergeable_vma(vmg, false) &&
>
> I started putting /* merge_next = */ false, so that it's easier to read.
> Not a whole lot of arguments, but it is still useful to remember what is
> passed.
>
> > +	    is_mergeable_anon_vma(vmg->anon_vma, vmg->prev->anon_vma, vmg->prev)) {
> > +		if (vmg->prev->vm_pgoff + vma_pages(vmg->prev) == vmg->pgoff)
> >  			return true;
> >  	}
> >  	return false;
> > @@ -1022,16 +1017,10 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
> >   * **** is not represented - it will be merged and the vma containing the
> >   *      area is returned, or the function will return NULL
> >   */
> > -static struct vm_area_struct
> > -*vma_merge(struct vma_iterator *vmi, struct vm_area_struct *prev,
> > -	   struct vm_area_struct *src, unsigned long addr, unsigned long end,
> > -	   unsigned long vm_flags, pgoff_t pgoff, struct mempolicy *policy,
> > -	   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > -	   struct anon_vma_name *anon_name)
> > +static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
> >  {
> > -	struct mm_struct *mm = src->vm_mm;
> > -	struct anon_vma *anon_vma = src->anon_vma;
> > -	struct file *file = src->vm_file;
> > +	struct mm_struct *mm = vmg->mm;
> > +	struct vm_area_struct *prev = vmg->prev;
> >  	struct vm_area_struct *curr, *next, *res;
> >  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
> >  	struct vm_area_struct *anon_dup = NULL;
> > @@ -1041,16 +1030,18 @@ static struct vm_area_struct
> >  	bool merge_prev = false;
> >  	bool merge_next = false;
> >  	bool vma_expanded = false;
> > +	unsigned long addr = vmg->start;
> > +	unsigned long end = vmg->end;
> >  	unsigned long vma_start = addr;
> >  	unsigned long vma_end = end;
> > -	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
> > +	pgoff_t pglen = PHYS_PFN(end - addr);
> >  	long adj_start = 0;
> >
> >  	/*
> >  	 * We later require that vma->vm_flags == vm_flags,
> >  	 * so this tests vma->vm_flags & VM_SPECIAL, too.
> >  	 */
> > -	if (vm_flags & VM_SPECIAL)
> > +	if (vmg->flags & VM_SPECIAL)
> >  		return NULL;
> >
> >  	/* Does the input range span an existing VMA? (cases 5 - 8) */
> > @@ -1058,27 +1049,26 @@ static struct vm_area_struct
> >
> >  	if (!curr ||			/* cases 1 - 4 */
> >  	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
> > -		next = vma_lookup(mm, end);
> > +		next = vmg->next = vma_lookup(mm, end);
> >  	else
> > -		next = NULL;		/* case 5 */
> > +		next = vmg->next = NULL;	/* case 5 */
> >
> >  	if (prev) {
> >  		vma_start = prev->vm_start;
> >  		vma_pgoff = prev->vm_pgoff;
> >
> >  		/* Can we merge the predecessor? */
> > -		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), policy)
> > -		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
> > -					   pgoff, vm_userfaultfd_ctx, anon_name)) {
> > +		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), vmg->policy)
> > +		    && can_vma_merge_after(vmg)) {
> > +
> >  			merge_prev = true;
> > -			vma_prev(vmi);
> > +			vma_prev(vmg->vmi);
> >  		}
> >  	}
> >
> >  	/* Can we merge the successor? */
> > -	if (next && mpol_equal(policy, vma_policy(next)) &&
> > -	    can_vma_merge_before(next, vm_flags, anon_vma, file, pgoff+pglen,
> > -				 vm_userfaultfd_ctx, anon_name)) {
> > +	if (next && mpol_equal(vmg->policy, vma_policy(next)) &&
> > +	    can_vma_merge_before(vmg)) {
> >  		merge_next = true;
> >  	}
> >
> > @@ -1129,7 +1119,7 @@ static struct vm_area_struct
> >  				remove = curr;
> >  			} else {			/* case 5 */
> >  				adjust = curr;
> > -				adj_start = (end - curr->vm_start);
> > +				adj_start = end - curr->vm_start;
>
> unnecessary change, if you respin.. but it's temporary.
>
> >  			}
> >  			if (!err)
> >  				err = dup_anon_vma(prev, curr, &anon_dup);
> > @@ -1169,13 +1159,13 @@ static struct vm_area_struct
> >  		vma_expanded = true;
> >
> >  	if (vma_expanded) {
> > -		vma_iter_config(vmi, vma_start, vma_end);
> > +		vma_iter_config(vmg->vmi, vma_start, vma_end);
> >  	} else {
> > -		vma_iter_config(vmi, adjust->vm_start + adj_start,
> > +		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
> >  				adjust->vm_end);
> >  	}
> >
> > -	if (vma_iter_prealloc(vmi, vma))
> > +	if (vma_iter_prealloc(vmg->vmi, vma))
> >  		goto prealloc_fail;
> >
> >  	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
> > @@ -1187,20 +1177,20 @@ static struct vm_area_struct
> >  	vma_set_range(vma, vma_start, vma_end, vma_pgoff);
> >
> >  	if (vma_expanded)
> > -		vma_iter_store(vmi, vma);
> > +		vma_iter_store(vmg->vmi, vma);
> >
> >  	if (adj_start) {
> >  		adjust->vm_start += adj_start;
> >  		adjust->vm_pgoff += adj_start >> PAGE_SHIFT;
> >  		if (adj_start < 0) {
> >  			WARN_ON(vma_expanded);
> > -			vma_iter_store(vmi, next);
> > +			vma_iter_store(vmg->vmi, next);
> >  		}
> >  	}
> >
> > -	vma_complete(&vp, vmi, mm);
> > +	vma_complete(&vp, vmg->vmi, mm);
> >  	validate_mm(mm);
> > -	khugepaged_enter_vma(res, vm_flags);
> > +	khugepaged_enter_vma(res, vmg->flags);
> >  	return res;
> >
> >  prealloc_fail:
> > @@ -1208,8 +1198,8 @@ static struct vm_area_struct
> >  		unlink_anon_vmas(anon_dup);
> >
> >  anon_vma_fail:
> > -	vma_iter_set(vmi, addr);
> > -	vma_iter_load(vmi);
> > +	vma_iter_set(vmg->vmi, addr);
> > +	vma_iter_load(vmg->vmi);
> >  	return NULL;
> >  }
> >
> > @@ -1226,32 +1216,27 @@ static struct vm_area_struct
> >   * The function returns either the merged VMA, the original VMA if a split was
> >   * required instead, or an error if the split failed.
> >   */
> > -struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
> > -				  struct vm_area_struct *prev,
> > -				  struct vm_area_struct *vma,
> > -				  unsigned long start, unsigned long end,
> > -				  unsigned long vm_flags,
> > -				  struct mempolicy *policy,
> > -				  struct vm_userfaultfd_ctx uffd_ctx,
> > -				  struct anon_vma_name *anon_name)
> > +static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
> >  {
> > -	pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> > +	struct vm_area_struct *vma = vmg->vma;
> >  	struct vm_area_struct *merged;
> >
> > -	merged = vma_merge(vmi, prev, vma, start, end, vm_flags,
> > -			   pgoff, policy, uffd_ctx, anon_name);
> > +	/* First, try to merge. */
> > +	merged = vma_merge(vmg);
> >  	if (merged)
> >  		return merged;
> >
> > -	if (vma->vm_start < start) {
> > -		int err = split_vma(vmi, vma, start, 1);
> > +	/* Split any preceding portion of the VMA. */
> > +	if (vma->vm_start < vmg->start) {
> > +		int err = split_vma(vmg->vmi, vma, vmg->start, 1);
> >
> >  		if (err)
> >  			return ERR_PTR(err);
> >  	}
> >
> > -	if (vma->vm_end > end) {
> > -		int err = split_vma(vmi, vma, end, 0);
> > +	/* Split any trailing portion of the VMA. */
> > +	if (vma->vm_end > vmg->end) {
> > +		int err = split_vma(vmg->vmi, vma, vmg->end, 0);
> >
> >  		if (err)
> >  			return ERR_PTR(err);
> > @@ -1260,6 +1245,65 @@ struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
> >  	return vma;
> >  }
> >
> > +struct vm_area_struct *vma_modify_flags(
> > +	struct vma_iterator *vmi, struct vm_area_struct *prev,
> > +	struct vm_area_struct *vma, unsigned long start, unsigned long end,
> > +	unsigned long new_flags)
> > +{
> > +	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
> > +
> > +	vmg.flags = new_flags;
> > +
> > +	return vma_modify(&vmg);
> > +}
> > +
> > +struct vm_area_struct
> > +*vma_modify_flags_name(struct vma_iterator *vmi,
> > +		       struct vm_area_struct *prev,
> > +		       struct vm_area_struct *vma,
> > +		       unsigned long start,
> > +		       unsigned long end,
> > +		       unsigned long new_flags,
> > +		       struct anon_vma_name *new_name)
> > +{
> > +	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
> > +
> > +	vmg.flags = new_flags;
> > +	vmg.anon_name = new_name;
> > +
> > +	return vma_modify(&vmg);
> > +}
> > +
> > +struct vm_area_struct
> > +*vma_modify_policy(struct vma_iterator *vmi,
> > +		   struct vm_area_struct *prev,
> > +		   struct vm_area_struct *vma,
> > +		   unsigned long start, unsigned long end,
> > +		   struct mempolicy *new_pol)
> > +{
> > +	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
> > +
> > +	vmg.policy = new_pol;
> > +
> > +	return vma_modify(&vmg);
> > +}
> > +
> > +struct vm_area_struct
> > +*vma_modify_flags_uffd(struct vma_iterator *vmi,
> > +		       struct vm_area_struct *prev,
> > +		       struct vm_area_struct *vma,
> > +		       unsigned long start, unsigned long end,
> > +		       unsigned long new_flags,
> > +		       struct vm_userfaultfd_ctx new_ctx)
> > +{
> > +	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
> > +
> > +	vmg.flags = new_flags;
> > +	vmg.uffd_ctx = new_ctx;
> > +
> > +	return vma_modify(&vmg);
> > +}
> > +
> >  /*
> >   * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
> >   * must ensure that [start, end) does not overlap any existing VMA.
> > @@ -1269,8 +1313,11 @@ struct vm_area_struct
> >  		   struct vm_area_struct *vma, unsigned long start,
> >  		   unsigned long end, pgoff_t pgoff)
> >  {
> > -	return vma_merge(vmi, prev, vma, start, end, vma->vm_flags, pgoff,
> > -			 vma_policy(vma), vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > +	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
> > +
> > +	vmg.pgoff = pgoff;
> > +
> > +	return vma_merge(&vmg);
> >  }
> >
> >  /*
> > @@ -1281,12 +1328,10 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
> >  					struct vm_area_struct *vma,
> >  					unsigned long delta)
> >  {
> > -	pgoff_t pgoff = vma->vm_pgoff + vma_pages(vma);
> > +	VMG_VMA_STATE(vmg, vmi, vma, vma, vma->vm_end, vma->vm_end + delta);
> >
> >  	/* vma is specified as prev, so case 1 or 2 will apply. */
> > -	return vma_merge(vmi, vma, vma, vma->vm_end, vma->vm_end + delta,
> > -			 vma->vm_flags, pgoff, vma_policy(vma),
> > -			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > +	return vma_merge(&vmg);
> >  }
>
> Many of these are small and can be static inline, some (all?) in the
> header.

I don't like exposing the raw underlying merge function, so this is on
purpose. No indication of perf hit.

>
> >
> >  void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
> > diff --git a/mm/vma.h b/mm/vma.h
> > index c774642697a0..9060a1a1edfa 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -52,6 +52,59 @@ struct vma_munmap_struct {
> >  	unsigned long data_vm;
> >  };
> >
> > +/* Represents a VMA merge operation. */
> > +struct vma_merge_struct {
> > +	struct mm_struct *mm;
> > +	struct vma_iterator *vmi;
> > +	pgoff_t pgoff;
> > +	struct vm_area_struct *prev;
> > +	struct vm_area_struct *next; /* Modified by vma_merge(). */
> > +	struct vm_area_struct *vma; /* Either a new VMA or the one being modified. */
> > +	unsigned long start;
> > +	unsigned long end;
> > +	unsigned long flags;
> > +	struct file *file;
> > +	struct anon_vma *anon_vma;
> > +	struct mempolicy *policy;
> > +	struct vm_userfaultfd_ctx uffd_ctx;
> > +	struct anon_vma_name *anon_name;
> > +};
> > +
> > +/* Assumes addr >= vma->vm_start. */
> > +static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
> > +				       unsigned long addr)
> > +{
> > +	return vma->vm_pgoff + PHYS_PFN(addr - vma->vm_start);
> > +}
> > +
> > +#define VMG_STATE(name, mm_, vmi_, start_, end_, flags_, pgoff_)	\
> > +	struct vma_merge_struct name = {				\
> > +		.mm = mm_,						\
> > +		.vmi = vmi_,						\
> > +		.start = start_,					\
> > +		.end = end_,						\
> > +		.flags = flags_,					\
> > +		.pgoff = pgoff_,					\
> > +	}
> > +
> > +#define VMG_VMA_STATE(name, vmi_, prev_, vma_, start_, end_)	\
> > +	struct vma_merge_struct name = {			\
> > +		.mm = vma_->vm_mm,				\
> > +		.vmi = vmi_,					\
> > +		.prev = prev_,					\
> > +		.next = NULL,					\
> > +		.vma = vma_,					\
> > +		.start = start_,				\
> > +		.end = end_,					\
> > +		.flags = vma_->vm_flags,			\
> > +		.pgoff = vma_pgoff_offset(vma_, start_),	\
> > +		.file = vma_->vm_file,				\
> > +		.anon_vma = vma_->anon_vma,			\
> > +		.policy = vma_policy(vma_),			\
> > +		.uffd_ctx = vma_->vm_userfaultfd_ctx,		\
> > +		.anon_name = anon_vma_name(vma_),		\
> > +	}
> > +
> >  #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
> >  void validate_mm(struct mm_struct *mm);
> >  #else
> > @@ -208,80 +261,53 @@ void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed);
> >  void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
> >  		struct vm_area_struct *prev, struct vm_area_struct *next);
> >
> > -/* Required by mmap_region(). */
> > -bool
> > -can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
> > -		struct anon_vma *anon_vma, struct file *file,
> > -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > -		struct anon_vma_name *anon_name);
> > -
> > -/* Required by mmap_region() and do_brk_flags(). */
> > -bool
> > -can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
> > -		struct anon_vma *anon_vma, struct file *file,
> > -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > -		struct anon_vma_name *anon_name);
> > -
> > -struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
> > -				  struct vm_area_struct *prev,
> > -				  struct vm_area_struct *vma,
> > -				  unsigned long start, unsigned long end,
> > -				  unsigned long vm_flags,
> > -				  struct mempolicy *policy,
> > -				  struct vm_userfaultfd_ctx uffd_ctx,
> > -				  struct anon_vma_name *anon_name);
> > +/*
> > + * Can we merge the VMA described by vmg into the following VMA vmg->next?
> > + *
> > + * Required by mmap_region().
> > + */
> > +bool can_vma_merge_before(struct vma_merge_struct *vmg);
> > +
> > +/*
> > + * Can we merge the VMA described by vmg into the preceding VMA vmg->prev?
> > + *
> > + * Required by mmap_region() and do_brk_flags().
> > + */
> > +bool can_vma_merge_after(struct vma_merge_struct *vmg);
> >
> >  /* We are about to modify the VMA's flags. */
> > -static inline struct vm_area_struct
> > -*vma_modify_flags(struct vma_iterator *vmi,
> > -		  struct vm_area_struct *prev,
> > -		  struct vm_area_struct *vma,
> > -		  unsigned long start, unsigned long end,
> > -		  unsigned long new_flags)
> > -{
> > -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> > -			  vma_policy(vma), vma->vm_userfaultfd_ctx,
> > -			  anon_vma_name(vma));
> > -}
> > +struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
> > +					struct vm_area_struct *prev,
> > +					struct vm_area_struct *vma,
> > +					unsigned long start, unsigned long end,
> > +					unsigned long new_flags);
>
> Does this get better with two tab indent?
>
> >
> >  /* We are about to modify the VMA's flags and/or anon_name. */
> > -static inline struct vm_area_struct
> > +struct vm_area_struct
> >  *vma_modify_flags_name(struct vma_iterator *vmi,
> >  		       struct vm_area_struct *prev,
> >  		       struct vm_area_struct *vma,
> >  		       unsigned long start,
> >  		       unsigned long end,
> >  		       unsigned long new_flags,
> > -		       struct anon_vma_name *new_name)
> > -{
> > -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> > -			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
> > -}
> > +		       struct anon_vma_name *new_name);
> >
> >  /* We are about to modify the VMA's memory policy. */
> > -static inline struct vm_area_struct
> > +struct vm_area_struct
> >  *vma_modify_policy(struct vma_iterator *vmi,
> >  		   struct vm_area_struct *prev,
> >  		   struct vm_area_struct *vma,
> >  		   unsigned long start, unsigned long end,
> > -		   struct mempolicy *new_pol)
> > -{
> > -	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
> > -			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > -}
> > +		   struct mempolicy *new_pol);
> >
> >  /* We are about to modify the VMA's flags and/or uffd context. */
> > -static inline struct vm_area_struct
> > +struct vm_area_struct
> >  *vma_modify_flags_uffd(struct vma_iterator *vmi,
> >  		       struct vm_area_struct *prev,
> >  		       struct vm_area_struct *vma,
> >  		       unsigned long start, unsigned long end,
> >  		       unsigned long new_flags,
> > -		       struct vm_userfaultfd_ctx new_ctx)
> > -{
> > -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> > -			  vma_policy(vma), new_ctx, anon_vma_name(vma));
> > -}
> > +		       struct vm_userfaultfd_ctx new_ctx);
> >
> >  struct vm_area_struct
> >  *vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
> > diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> > index 9b272633ca9e..b12f72979478 100644
> > --- a/tools/testing/vma/vma.c
> > +++ b/tools/testing/vma/vma.c
> > @@ -22,26 +22,6 @@ static bool fail_prealloc;
> >   */
> >  #include "../../../mm/vma.c"
> >
> > -/*
> > - * Temporarily forward-ported from a future in which vmg's are used for merging.
>
> the future is soon.
>
> > - */
> > -struct vma_merge_struct {
> > -	struct mm_struct *mm;
> > -	struct vma_iterator *vmi;
> > -	pgoff_t pgoff;
> > -	struct vm_area_struct *prev;
> > -	struct vm_area_struct *next; /* Modified by vma_merge(). */
> > -	struct vm_area_struct *vma; /* Either a new VMA or the one being modified. */
> > -	unsigned long start;
> > -	unsigned long end;
> > -	unsigned long flags;
> > -	struct file *file;
> > -	struct anon_vma *anon_vma;
> > -	struct mempolicy *policy;
> > -	struct vm_userfaultfd_ctx uffd_ctx;
> > -	struct anon_vma_name *anon_name;
> > -};
> > -
> >  const struct vm_operations_struct vma_dummy_vm_ops;
> >  static struct anon_vma dummy_anon_vma;
> >
> > @@ -115,14 +95,6 @@ static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
> >  /* Helper function which provides a wrapper around a merge new VMA operation. */
> >  static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
> >  {
> > -	/* vma_merge() needs a VMA to determine mm, anon_vma, and file. */
> > -	struct vm_area_struct dummy = {
> > -		.vm_mm = vmg->mm,
> > -		.vm_flags = vmg->flags,
> > -		.anon_vma = vmg->anon_vma,
> > -		.vm_file = vmg->file,
> > -	};
> > -
> >  	/*
> >  	 * For convenience, get prev and next VMAs. Which the new VMA operation
> >  	 * requires.
> > @@ -131,8 +103,7 @@ static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
> >  	vmg->prev = vma_prev(vmg->vmi);
> >
> >  	vma_iter_set(vmg->vmi, vmg->start);
> > -	return vma_merge_new_vma(vmg->vmi, vmg->prev, &dummy, vmg->start,
> > -				 vmg->end, vmg->pgoff);
> > +	return vma_merge(vmg);
> >  }
> >
> >  /*
> > @@ -141,17 +112,7 @@ static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
> >   */
> >  static struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
> >  {
> > -	/* vma_merge() needs a VMA to determine mm, anon_vma, and file. */
> > -	struct vm_area_struct dummy = {
> > -		.vm_mm = vmg->mm,
> > -		.vm_flags = vmg->flags,
> > -		.anon_vma = vmg->anon_vma,
> > -		.vm_file = vmg->file,
> > -	};
> > -
> > -	return vma_merge(vmg->vmi, vmg->prev, &dummy, vmg->start, vmg->end,
> > -			 vmg->flags, vmg->pgoff, vmg->policy, vmg->uffd_ctx,
> > -			 vmg->anon_name);
> > +	return vma_merge(vmg);
> >  }
> >
> >  /*
> > --
> > 2.46.0
> >

