Return-Path: <linux-kernel+bounces-229568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C92109170F8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB731F2266A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE6017CA0C;
	Tue, 25 Jun 2024 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kJ8GdHJb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b4xN6jRV"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B6017C7C8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342738; cv=fail; b=sdqcPRuHKtIFVxDwWHkm0hxuZzwKJEle9C50DUKVZV9EFlRrxlAqFMY7uV4QgY0ikQ5zGdznZJfphAFm4DIz0MTTaVjIlX2ynfSz1IBQmzHrmwtVtSJQ0NS/g4+hjGNENChJN5UQ8mqcyc/F793orSKXV4aE1SVbic4JgzmFtJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342738; c=relaxed/simple;
	bh=7oU6qNd5I1YrI+pnQ6kplIj9Locb9846FE8DwKSEQC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lqDPniISI6yAFI7doLUdydP77bICFMedA2svA7/JdmzrjkArdcVe5LjzHK+iIJQ1/VxBfWx5h7EvrI5WcLNenPwIPV5v3Nuj7crQShd2yn/BahRDV94ZMaqRGyipuDPpLUei/GF9kLHThhKVHCRmF24uRGGgljU/grpe1aIqbaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kJ8GdHJb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b4xN6jRV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PIfXCx007445;
	Tue, 25 Jun 2024 19:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=60kAsYjdha+bVEANDM89tZg/qOvXIAnhtflm3wfsjyU=; b=
	kJ8GdHJbigNqgTczOPTBabgG/RBfqbUkPAXJs4BJMM7J6xLgTvlOwz63kBItV87O
	9c9tNCcNtQy8mqVuqhvED6b5DlOVJY+HXp+BzVTT7U2eeu5rcB5MCirxPTWo2RGn
	p6sX7L3UmzQDtFfvULPr6RfLB9NuTS8fs5EpPTxRbjIpbXCDt3g/568hoV9RnKQD
	NqylEjw1AqmBZjuZ3h3xpEpGE5oNh0cnvrpMcs3PTCpmJaJb7zoC+VjmIHkylrtg
	vVMwVIGZldloeOggQHZwgf3uz4RPNJvnArEcT6V1rXL3XYpV/svowpSsiWIkTo1H
	7ErUK5YjAPXSWgSWzBljag==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn1d1dmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PIrYKr010721;
	Tue, 25 Jun 2024 19:12:01 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2egtb2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RA6RXlGaG+L8D043UXRcY0rbikkAyfMePKGiGR68GKqdVXW16VhzfVymwJj9lx45Bn39EIAN+dd6FcHGW5CIZvTDlsR90ViFTdfkN0F1vOkX8jjJYfz1pVnRa5Gkm7SdPmkMuToAmazS+lvCm5WNI7mPp+oIfVGANQwQ7wmgSQOGoWstb+h+XZym704F+EAcA0zW8PqHc+5cj1s0ZBGdu3aqfoJPpznes0ObQrk/ieZeJDbP/loaUeOH9iTMCGNHMa47l6h2vEMQpXyeN/Uh8pqyHncgAeoiwNl6bnjIn6d3znLnqBilx5tcj8jcD4sqcfKVw+uxu/Vfa4vJE3hBMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60kAsYjdha+bVEANDM89tZg/qOvXIAnhtflm3wfsjyU=;
 b=WwUQ8fqekeflwapJ492t4mAUuc/yIjol5vWExKiQyLQsLBSHyvY6SP5OcHXCJShzKEhF8g3ywuoX5Iv2cruj9kOQkzC/dMevl3FceLT77Kjg0ufP9HEZSBoGMnPTLqsJXAASFWArMx3d0LivgVHOu8mUu2dxLijUPBYjyzIi2p8+3l+YhzIrGkCWyhgqbgmq5hoWbT6Fz60krd07vMdpprlc/uVN9/iyyqidZnXU/jxiA3IMubAGnEzdJ1Gw0LkOx7yv3XAmSraLg2V5kAk7PL7wFgfYZsnlncWKC5SWnKJFmlNe8Q813pR9aFWmYF4IQciJezKz3afwOVXjYJ0aAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60kAsYjdha+bVEANDM89tZg/qOvXIAnhtflm3wfsjyU=;
 b=b4xN6jRVK/EUQbw4pSUeypT65S9VjQSTEpw1StCMPTgckV56UYnFDDvkP6SORjHOiMNWwI5rQvu9VsfhI5fxX5KbUuJXOEpfGWxn6ccl4I3XF6/64pI1CTWiKF0GamP2tsNj/0DNYP+INpWYgdCIF1YlTuzOHz1nU1w/WbbsAyw=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4707.namprd10.prod.outlook.com (2603:10b6:303:92::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 19:11:59 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 19:11:59 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 03/15] mm/mmap: Introduce vmi_complete_munmap_vmas()
Date: Tue, 25 Jun 2024 15:11:33 -0400
Message-ID: <20240625191145.3382793-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
References: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0018.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::31)
 To DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: 86905b5d-8152-41c6-6d0a-08dc954ab01b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?xpCY7NHADJYTBlJoX9Bm/GXt+xiCEK2G8mdUjoGG1rvPPgpA8uv9BEtuidHb?=
 =?us-ascii?Q?5w5DUBrz2jQkc/0PiLZQP5GFlubg+Grdh7l9QxO+ph5H7XZrxxvIT/U6WDxg?=
 =?us-ascii?Q?uhbsbli09pecmlCZyZQnWHsiSQw4Szx8fbgCfUvRwHC4PGAtqLo2cdcPcRjN?=
 =?us-ascii?Q?fqmNjnaYkNPk4e/FddkspYqE55n2Q0mrp9GHgwKzLhbarthe/2xHZSZblPSg?=
 =?us-ascii?Q?KQ4OH+xEjzt7i7ebNW6ucJBSHYahTxuvSkBQhW6wYmR5wtyJ2Vwb5qXL4zP9?=
 =?us-ascii?Q?rNVcLrKIbDiATFTPayaj2QBUYjJzSYkXgLYaMTEN6Ow6k2Q5WDqkPfynvyoh?=
 =?us-ascii?Q?Av0hD7k93OXxM9l19xQmeXT8L5E5zd8mcfWt8gvuxOo7MZvHsOuzZWhE4f7v?=
 =?us-ascii?Q?XSY8viVBkoCF3TBGR8mjIQvZy2rBOzmBvsXpPe7B063U2XRWPfpxZXEN+SI4?=
 =?us-ascii?Q?B3S5NOs8y7JziN/xoaSL9JGfJOL7tXtGIoD/yObbGJzPcRvE/3N9S0lXYxJM?=
 =?us-ascii?Q?CiwamT2Dxvl/3lUCaVMvFvRbcL9d6PwM/e9oHhQ5bVLzQf7Tq1pqzCGHewVQ?=
 =?us-ascii?Q?uDIKRSeFSlbxqeuVC+kbIUkPCvaqs2OVmY1ZcKejfhRK531+b0YnLJnQ6lfx?=
 =?us-ascii?Q?+s2mWpqlyKZjhb82M88R2rcTLitwXKwB4nxLRcb/0DF8pqnoAw3RxPK+zLQ3?=
 =?us-ascii?Q?lqn9D28x7pjWRFkPDbrPIwnyjKKI1SrwGJ+1WHepLQmk5jh1lF9/lvQIyDYJ?=
 =?us-ascii?Q?Cie4DT2gn5Ntqka9iogxurwr3O4Gbm9KKOJZ5hY7N8iJlbw5cUQJxJGaMQry?=
 =?us-ascii?Q?ND7HnE8aXGSB+dL8E853HFsoUyz8EbGRu/srUARObNuZPO4gGfijJGoLrFUl?=
 =?us-ascii?Q?aOVeK+CXDfgNO1z0+skg9lkowvX3WlqhqOGT0Ya8xDYxMrgNDvCdqlFvMmfQ?=
 =?us-ascii?Q?zIAM/Nw8TOKD7o5DGdP2QNIR6JmYf8/xV7/U6NfGUOyfzwXYu+Li2PatkDgl?=
 =?us-ascii?Q?MJ1mITbs81NGz42fS9QlvzY/QZ9bteCgsXwXJU9hvQBgLZxuW8uu+aLiqLN0?=
 =?us-ascii?Q?5p39Wb2otOgUKksWJApJ63G+X2RzIjjksPJMqNBXpYIQVntPZnvN95L0wu17?=
 =?us-ascii?Q?JohQEYm/20f7XuDgFHlfZ3L13zQCNGW8WgoooIOMEMR1zUv0H9KTQwxCzm0c?=
 =?us-ascii?Q?w8HRXCR7C41rGedh7xSIuhc9ehfXml/26mo6/icLashS0MQ6dcUGNQ1VU79K?=
 =?us-ascii?Q?fj19tmoiZwpUQ4g4lik3vn6mp5HvCBpB1dPM0i/7iDhLBQ+4oqXkLqocTOj1?=
 =?us-ascii?Q?Eajl6/1uR8ZD0wYDLYzBWpio?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Fhn6ygJHsZEFH+Cqh2uyPSzNsw7mHNyh2hcjjxB3LSx8/1wFNOdVorItwg1Q?=
 =?us-ascii?Q?dcS/PeUxx8RX336oTjd7GwYHvEbE4Q7FAPhWo3GKw7wrqEx+NWkDjGvi08rU?=
 =?us-ascii?Q?DIE0OEqFIZjyxEniHtREILLjUgaB5WsaFlxcXgxFdcLFv3UMRwwSKqiOPQtF?=
 =?us-ascii?Q?ptD5FDnnLO4x9EgPDCNMg6yhosnJyPr4wDgKd/osMRRWw9qI29VMTqghtO/E?=
 =?us-ascii?Q?SYwd9cYvkrJjP6g573fdLi0ijDeqKscLha7dXjY1uZYNcJ/rApOijUcEqVP5?=
 =?us-ascii?Q?MBmqKMTywRntRL4XAvwDyFM+n+jR+dHH9NOcCT9OSCsCtS1r+RnXJbjDJH/U?=
 =?us-ascii?Q?N7i1lWy627vyzqLQ54PSRh9RTxhi4kMTVde5ykZgdMssHssOt4Ha5Nxbuj5H?=
 =?us-ascii?Q?8rckUD0t/fNrGW4+T1aMFGyTPjgLSPztL72vOWHVfmBp9H4Gai8vSKcdEyFi?=
 =?us-ascii?Q?2FBLlTiFfTbiE0HQvITKJIGQI8AHTkot/drbtfT3jWdLsHk8t80rVXo7+NI/?=
 =?us-ascii?Q?ZvE4GXTrBqU58DjaEsOENcbuBQJJcymtDbdHE7TzpS8ifD0gHQRl0KTPg8EY?=
 =?us-ascii?Q?wq4T4QED5uL2yijFdKMJRSF0zjbrEP9saPW4sneHkgtisaC8XNf39OHQgKoN?=
 =?us-ascii?Q?ChH/bcP+dcVDKsa1ei9Pyl1VQAlL/85mHRzHrdNhZSmVdqMcx9aBlXpIuVzJ?=
 =?us-ascii?Q?Bj53mz1/hJlnTJ/qeyg9U/mxKKt/cRliV+mBtESo5DsSoXLVhryCEM5j8uZz?=
 =?us-ascii?Q?eHmLZqlgQkER5RNCvwATncsKYrkojfCkast5MRN+ta3jtSwWFXYL88FsgkX+?=
 =?us-ascii?Q?nhC7X25e58Iz7jx8mu03F16TKeLVt4vGX3QuMJ8cwa5O2rjIboJNZOKxlSje?=
 =?us-ascii?Q?7vLhIds8PK+dmYzwXEnM4a0VF7qVxk0U5OnSAsOCVIWmdorXVShqp8Kqoa3N?=
 =?us-ascii?Q?zbEJJzaqgN28LdMlD1f+/yYFnRmJxfqL2QV9mubUZGp0JJYTzdwhpqYI2hja?=
 =?us-ascii?Q?pcGu8RO5pxWSFernE2+p/IyKbz2RUXXNcfFDh5UV2fOCRe2jldRWbISlzNBy?=
 =?us-ascii?Q?1da8NXqYCd0zuKZJz6kBkNIUhaptImbNaTE6u9PdhGmVsOvs49JxdKkWAc1G?=
 =?us-ascii?Q?qv3sW9g+nmTc+zb86HIwXf6B3uKi0ISDac2E7ZhN17io2QqNslKMVtntZCDT?=
 =?us-ascii?Q?alVVJV2tvxePP6HJ8xM3NQWY4HjYRCKbzaCwV/lZa4N1xy5nzE1kCYsGtkIf?=
 =?us-ascii?Q?gLd+/iGQmajK7gRdXw4NsFSRNt9G0cJM2MqGFSP90zkYyS7e3FkwuYrp/quk?=
 =?us-ascii?Q?+DVhqvsDYDcbAYTRCDIjXt8JFI2q7nkZf2WYAd+XuF/h2ZYdXF3J8R4hNu0A?=
 =?us-ascii?Q?XGknn05j4zarRmugKfDuO4bWyB03lovGpRlbPxcw73Al2pmBnJU31g/kgBDP?=
 =?us-ascii?Q?Fqef3P+kXVhFOb2+v12KpD2yOKhtIgfg8DOuOZ4FuHTSUcj2Ga4DIStWcsTv?=
 =?us-ascii?Q?E+VRGwX+G0njCo4lchi/cWqI90yqdG02bGX+I4ndlS9VvBMeCay7j8iOqRKV?=
 =?us-ascii?Q?Ao24r6L0+AT23tbrVZqLZZESjxGgVAgqp9ZcJW9A70HF9A7yknthypA4UtYm?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BPYnE8m6tUwjBVWAaR410wjY1u+2ugLK6L9zS5egkp0akeQRYurMBL69qdKh4A4ORtQf717oNCoch5EqONA7d78AdrudbzQaCwHxC6mZn0PBvbEg/GJ/iLDSFF6Hn779nnZQ9I2bvB8ihnC3BmVq3PlyziuYLUHvtJ7U/MXbRVd6THT03X3aMbF8KKewYA9eAC38nNufBDkNLLZe2B23EahLF/eb2zF9dEwUuabGQgNdd+R0dqVe7tbtdTestbNC5nSCNPN0HKga+AWNStsSpodTNKJlDu36cSXWjcheCiK7+MDb4KIILQaOOY8FO9rrbvs0IodOrnK/VYyd2QBtdrX7zU0G/0DCmq0fVtD/BTyuXaS+4hEznO8wcMxCXLPAot4AC+g6IW23QFmnqAKe6VUlABYNIA1RcRccsYFNSLXl+vmnNK2vNvXLI21Z83hlCi1US2+lCaHCaMJu4IrPjOLBbWhp6Cn8AmIxiQaSdkEV8J6KXwrijrZhJjTHa7gEdKQaAkFca7zFGAcL2Ysk/ApgHrbhr6iaqYI/m+aTcyTrnfijYrba8yY/jbVi3ju/gnaubJjLEhZ6m4nkQoh+IWbu5qyNA+OEmRDgYt3lpBs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86905b5d-8152-41c6-6d0a-08dc954ab01b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:11:59.5390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 130V9HAdtTt385QZ6VBJGgMoVnZaGshn0tzzwAcGEXG6fVZeu6iPwZV34nfYuFt3v0xlJb5SOJbLmjeJcikgLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4707
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_14,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406250141
X-Proofpoint-GUID: vDB4gi-6sXuHqLqtcoE5JwYBXbZ3o3HZ
X-Proofpoint-ORIG-GUID: vDB4gi-6sXuHqLqtcoE5JwYBXbZ3o3HZ

Extract all necessary operations that need to be completed after the vma
maple tree is updated from a munmap() operation.  Extracting this makes
the later patch in the series easier to understand.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 79 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 26 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index d572e1ff8255..411798f46932 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2605,6 +2605,56 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 	__mt_destroy(mas_detach->tree);
 }
 
+/*
+ * vmi_complete_munmap_vmas() - Finish the munmap() operation
+ * @vmi: The vma iterator
+ * @start: The start address
+ * @end: The end address
+ * @unlock: Unlock the mm or not
+ * @mas_detach: them maple state of the detached vma maple tree
+ * @locked_vm: The locked_vm count in the detached vmas
+ *
+ * This function updates the mm_struct, unmaps the region, frees the resources
+ * used for the munmap() and may downgrade the lock - if requested.  Everything
+ * needed to be done once the vma maple tree is updated.
+ */
+static void
+vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		struct mm_struct *mm, unsigned long start,
+		unsigned long end, bool unlock, struct ma_state *mas_detach,
+		unsigned long locked_vm)
+{
+	struct vm_area_struct *prev, *next;
+	int count;
+
+	count = mas_detach->index + 1;
+	mm->map_count -= count;
+	mm->locked_vm -= locked_vm;
+	if (unlock)
+		mmap_write_downgrade(mm);
+
+	prev = vma_iter_prev_range(vmi);
+	next = vma_next(vmi);
+	if (next)
+		vma_iter_prev_range(vmi);
+
+	/*
+	 * We can free page tables without write-locking mmap_lock because VMAs
+	 * were isolated before we downgraded mmap_lock.
+	 */
+	mas_set(mas_detach, 1);
+	unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
+		     !unlock);
+	/* Statistics and freeing VMAs */
+	mas_set(mas_detach, 0);
+	remove_mt(mm, mas_detach);
+	validate_mm(mm);
+	if (unlock)
+		mmap_read_unlock(mm);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -2624,7 +2674,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
 		    unsigned long end, struct list_head *uf, bool unlock)
 {
-	struct vm_area_struct *prev, *next = NULL;
+	struct vm_area_struct *next = NULL;
 	struct maple_tree mt_detach;
 	int count = 0;
 	int error = -ENOMEM;
@@ -2728,31 +2778,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto clear_tree_failed;
 
 	/* Point of no return */
-	mm->locked_vm -= locked_vm;
-	mm->map_count -= count;
-	if (unlock)
-		mmap_write_downgrade(mm);
-
-	prev = vma_iter_prev_range(vmi);
-	next = vma_next(vmi);
-	if (next)
-		vma_iter_prev_range(vmi);
-
-	/*
-	 * We can free page tables without write-locking mmap_lock because VMAs
-	 * were isolated before we downgraded mmap_lock.
-	 */
-	mas_set(&mas_detach, 1);
-	unmap_region(mm, &mas_detach, vma, prev, next, start, end, count,
-		     !unlock);
-	/* Statistics and freeing VMAs */
-	mas_set(&mas_detach, 0);
-	remove_mt(mm, &mas_detach);
-	validate_mm(mm);
-	if (unlock)
-		mmap_read_unlock(mm);
-
-	__mt_destroy(&mt_detach);
+	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
+				 locked_vm);
 	return 0;
 
 clear_tree_failed:
-- 
2.43.0


