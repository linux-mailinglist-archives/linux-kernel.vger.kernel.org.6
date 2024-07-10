Return-Path: <linux-kernel+bounces-248174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AB792D918
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AEFEB24573
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE8B19A875;
	Wed, 10 Jul 2024 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HkDpNiZv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CVj0QTQ/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DE6199EB0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639441; cv=fail; b=GHC5KFKx6kL9BXmShHxpaX32KE3MO6BJ32ixjgkDGAROmiSjd0hV/xZOy5YqJsmFKj8r/kOa4wIKX29rHsU/H8RaqBFcDk/NQMgOXECle5dGnrznDjIDsqXBPawaDS9fumCJynU4YyzPFd+tu/YqtxZJvN4qfqF5K76+r3EtYTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639441; c=relaxed/simple;
	bh=07i3jwQFSibzX/qVQbZ5TzR6u+LZCfNIXvmON2B7WBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OUC26jjs9/YW3wjzobYH+o5ys2zcIMDuEreGtcAGGoOJal04ktqbtFZ9Cjyn3YuAqQfaHj00MCAUbRovB7/J0QnoHl9dbhAXGw/o/fb9KrsVe7wNYPbTgoTuuvj6mbpUzo/ouhO99OxXcahsnDcmxLSKqkQEXFw8CyTXHN3lDbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HkDpNiZv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CVj0QTQ/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AG2MZ9017489;
	Wed, 10 Jul 2024 19:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=Bpx+5nt3hJiamwLBX4gv68ojQ6NnvKXOC8koNrrVhow=; b=
	HkDpNiZvoTyS0ci1plBmRso2yTmEUNSEbkD+K3dLWtSuIJ/PKr+PXrl3oaKrKW8u
	tV9Os/oD91STb3pRfMsmjDKy349PGaD2xX+WAVkXwBnHw3wqDY6DT+H5O39oikD0
	RnNF5ZY35xAHfvMwkPnNjEa3n47rpso9kpe6JOuo17vjp4KCxbSvKNVxcm2lKe3X
	W93Nywt9m36xGn/j7lctteYwM9KVOPkRbH7qlVlDDhYEmBEJ2xefjw6Dh+XfQwPS
	rWToIrCp1M1clBEmmPKmnVgBC9porL6FnZ+/3+F1Kkp/JqjPC4FD8jzazEkhc9RF
	tdS04gcSH3SCKCap8zBhPA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybr4dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AIlfXv010839;
	Wed, 10 Jul 2024 19:23:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv4s3w9-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiP3JkxSgxHqvBCsSZz1Q+y9f7XVs3gyphSdRcPmdI/Osp/DyCHL7F4PnZ4uF6DQ/Ikck8wI1hKedwpmiqb/ExwMfZowtxC90II5YqXjl+hovgJEjIVBXLDGrPYTNo7OT3AQwqsM7D+nNLDWPPQTrD4tFbgV9X0b8MdbPJKibc+91Kn/j3AAVZgO1H4vJehHnkl1YG8kOFKr09+PAJHZQN9XMZ74o2KUtnQoUMlAAq8HM04zXlxGlzOSPu+0iBStFQm75NLVy+YMlnUbzjuGv10TVrkPjJY2K7aqSoVesTYYpEksDmzCyMTep2OhIfsbpBAc3GLeJhV95q47vFCt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bpx+5nt3hJiamwLBX4gv68ojQ6NnvKXOC8koNrrVhow=;
 b=CwvlxWfn9YJ0e8K2GLYHZa+q80kKHYBxbtGzA9TkA72qtNX/9OnCvQu32/KmaPcQ/cxNRed1jLnq72zCaxSnh52utP1XthNQ5ZXHVPI2xqWxk3dpLvUBmzyUCjrkPfFCcY/L5hwJOkfD3LavhpiNYfjT8KwjWwOW1NnlkqRMmlCiK07EQ4tKU8RToA/TOjB/EfHCPB1IHw7zJ3f1KSX/+xAEWhO/SMrN7hSspzIRP6tkO62NmFtUW1auFiLFZ8ydURy33Hu0KaQX4SswwxCmZ0S4i1SpGFYLKzmHxx6WULv2j14AUoeW4FHz4a40cHHl36g1Qm1jH6QtBZVXuRloEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bpx+5nt3hJiamwLBX4gv68ojQ6NnvKXOC8koNrrVhow=;
 b=CVj0QTQ/NtNtmscxE/mQ667xCaZ8are3W9P6GiU3lhExOXTF/Q8unEOaTfWzyNNro3Xn1YUjfl1kKbMNx4vfaUZaeAtH3PWOhGPULyeP0TXs/J9MVbXUMDr9mH3qsPuqrKaVB9FNlCwO5LUC1VD039HX/7igpSyHYDTuBue2fKE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6106.namprd10.prod.outlook.com (2603:10b6:510:1fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:23:38 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 19:23:38 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v4 19/21] ipc/shm, mm: Drop do_vma_munmap()
Date: Wed, 10 Jul 2024 15:22:48 -0400
Message-ID: <20240710192250.4114783-20-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::32) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 3413d912-e0ec-48c9-e5b4-08dca115cc90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9U1Whxo0UgPiBfA6sW1y61ZXXAUtRIVQyLrS5IF6+S2wblEoXZmn9vxdtVJu?=
 =?us-ascii?Q?GdSo/pCD3QU8nhqQSvNcwjSSQMKXScVuW5guuVgLWg1m5N23uWZxQoP1tgMF?=
 =?us-ascii?Q?32hXBIdyIfVY5NHb+BGf30Xhwtu6ArhbYbJhdhvoEKYYs0DUc6hcqXK9w9De?=
 =?us-ascii?Q?uOXcQWAHzq9DgH4/Mmgv2yScAUTbtB4htGiKKjwzbPRj6GqM0L0NKJDf+RHe?=
 =?us-ascii?Q?zfSsCcw8MyaKpAlMgC+oqToyD0SBY2uZPBI96oym9w9YKCbwlhjckx1Pp9wO?=
 =?us-ascii?Q?lNyP1YYZUHXgAD9SAyxc3zl8NIEukxC5Ua6ykR8gRQdIGGmrDnjU7DQX9w6k?=
 =?us-ascii?Q?W+cIeCWEN8YINMDDVD7BvIBCWJevsQs7oUMl2tOA3mMQzqYCycTCQBGwoO/f?=
 =?us-ascii?Q?2pvsNdNd8qLkwJq40TfKEqkw1k4Qt7bdSd579FsiMZhoRvCk8Yt/B1VhGpqe?=
 =?us-ascii?Q?KIjY1dzRJl6z0w+inFp3iHIIpaYK/UDDaPxAl09bGLdpCtTwyydcAaELO0RY?=
 =?us-ascii?Q?LgLnmkeln72j7FvnkNp0sYk3bvmhLzdZgvHY+cyac7tdgR4+I1RPb9pIh8pS?=
 =?us-ascii?Q?N6WX1iAi3h4w+PwAuARz82kTzHVBcJFwNqF8hpOvonLvub7FJIv/ktU9oYkN?=
 =?us-ascii?Q?3uYUbyQULXX704mob0wyrjPQKEYJNDltePqNglwxkBP1zFpls2EwtVqW3Wej?=
 =?us-ascii?Q?y2V951/nQV980NkoaZkSgSsdKGZ0oxF+XwMhoGPEh/TZYmx1PGKYhivk7qib?=
 =?us-ascii?Q?yEf+7lCZNvZSso06PK9AjebLhsIKQeXYRRygSzf6rcXlvEwnKBIwfB2Y4hN5?=
 =?us-ascii?Q?pCX2pBM8orEP2rgisPBP24rrLMhZZ6BA8VDbr+5jTxLCy4T46aAYonK8pIWc?=
 =?us-ascii?Q?1VprzHVBzte02lYNfNhSPOmSj5Iq4QJdyB4e0X9rSc+Frm8KfX14NeavSdWz?=
 =?us-ascii?Q?fO5L7p9EGqfCjG58a/013q0iwhO0W3+EcPuE8L0BnlSnF9z7EkA/Ji4OBIze?=
 =?us-ascii?Q?RsL9/7Z+3AfyN7BlQeW0FVZ8Rb7ITPT9hUxI6K3hGjkUwR5LYrUnJVcgyU/P?=
 =?us-ascii?Q?dGgv/5ez2VN1M/qLi/xNC2mM8bqSy+DXT5c/yMyH85LP048vgPSzBI2GtYFv?=
 =?us-ascii?Q?rB506TChQ3QeBW4omklKLSQ8GmF6eLBmN83VJcGUQZtpQZ0loU3hEqwi+2u2?=
 =?us-ascii?Q?JDnYzipmlzeFJkimghGYUcNDO58Myt7CnVfSEc6O0nmdQXFSYTHSKAjMtrxp?=
 =?us-ascii?Q?juBXHt5XCNfq8Wqk2TPIal+JIlQF/8O6YfZh730SSb/8SCLexhDCXmWsK9il?=
 =?us-ascii?Q?GHxkjqM5G5t0QTIR+UPJ8f1fAOHPL0KAnVAfflbu9Z0kQw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iFsWf90qc9YJ7vBAasN5sgryyf1ltZ+ab4nzeIc55mg/3BZU/iS5P1HzDny6?=
 =?us-ascii?Q?9c1QY7/ey7YfHSZ/0olTFXqFnEEtii7V/+3++XzPYGHldWxDyIt2Rf6Qv4KI?=
 =?us-ascii?Q?sF0ZyzaXy/djFQQqjbKSVzVzGnKlUsnwzXEXsELvGQR+caCtyfSWxGscJ50F?=
 =?us-ascii?Q?sqO6S8BhBkHMI68c7RYBD/hvWVdmLQiwJwzkcZ9MTq7gJ+zj1RfoVAOO4ug0?=
 =?us-ascii?Q?EWShzHSYzzw/HGOxZn021hgmNS1hOu6EDPL9Ur5nvoSrJjtKWQV6QmuuZVYG?=
 =?us-ascii?Q?w+X2PPKPkxE23Vqjq7BnlSwC9Lf4eaxhyAwippxB3RkCWlZIII2Pq5EcQz1G?=
 =?us-ascii?Q?OFkGAyjX1C47oi2szYEsIemVPx8B+7R+mmE1ImNbnXhyspXfB73j0u6p6erw?=
 =?us-ascii?Q?9edw6GElHD66L47SEq+KuPcVEVdxof3huKKbV8qLa55ws1ewddxVtyvcOS/+?=
 =?us-ascii?Q?mZLjNWSiGjmCMw7cMV1l7w9Ab7DrE1/0grARwy7Uc2rfUImrxbert5YxWDNI?=
 =?us-ascii?Q?+s40tO9zRFmqJQ4WpDRgtj1e2gj+iIyemUL6GAbhOD4epW098PqLwIugrpQY?=
 =?us-ascii?Q?ke1UNxlO2TVHecZqh1sFZ/PY04q13yfmMXBXtLyj6C/iumdP8DXtQSLhSE1F?=
 =?us-ascii?Q?b1xeN7bVrcXhwveTLMpVbTUPc81RBHQpR+P12yVIksbPyNLO6C4y7ZPUJz+A?=
 =?us-ascii?Q?YJnW6ctlJQrIjCgjgdHdg3mUBvL8M2K0aK+dYz6mZ+YzXsSQpec6peAw5cpf?=
 =?us-ascii?Q?IhYVViCbHLjhieVg6uumQ9+oYN8acT3WyCBZwGRXu6t0T5Y56lTJ2LOewtbt?=
 =?us-ascii?Q?lTDJQdP1LxVLmqDOTcpMdUXhXNkHTQCZ5J2VqOdHAPuv+mTnwm0W8lO6nGNy?=
 =?us-ascii?Q?+fxJEOx1KUagUo1D/ySdYZDFyjTHubcr5XyvD6UTVGl4F2DvUZEzdHFAC3LH?=
 =?us-ascii?Q?EXgqLpGlY7KWyx3cDmmwNVIEA5gJq0ZFmZDrDJuHezF22rR6EUVIb5NDuaqw?=
 =?us-ascii?Q?Dvc02dYlYdMrnWkdSDGM0q375MDDoZvJIt5AIDQcluTZXVZCXaPSjOkaqozv?=
 =?us-ascii?Q?d27p+6EUZkEkVcw6MWqH3iGcInHW2emaXKHDLM6hlHY+2JO8LDc9nqOkmX+P?=
 =?us-ascii?Q?4TkHwL9w5y0/TyuHJ6Q5qywtXYn9nOWgYPkZ+iIn39TG8WeRLXe2INx5FM6g?=
 =?us-ascii?Q?6BfdA2iWCkJAO8F2Hxr5MTU1V9w2ZKOv4nteyoXPXUCSO6S77cwI0smFGC+N?=
 =?us-ascii?Q?a1CbvkskfcQdJ3Ll82YsMIgK7SJgi2QeJl3vM9xJ61mVlsbfJcX4pCXtS2nc?=
 =?us-ascii?Q?1ZEsrxiSRo3ayZKUmo56W/nVD8/tDFYtFkGtoPM0ucnX1zF6md9uM+7tmUvp?=
 =?us-ascii?Q?5YpeC0bWkRb+o5GB64+u7YjlQM3Hew/JJLSxj9LXAGewl9QpZGZfI888Rp8L?=
 =?us-ascii?Q?36bC5gokaGps4qiQniBKRmisM2/Z4ugIzLYmvnpLPRUEZsJbsqb3qVVjWWkS?=
 =?us-ascii?Q?a8SnBvL/JDDN4pAWU1elz2+I515KlopLPWBl78N5PnGi//co+0obqrIONdqJ?=
 =?us-ascii?Q?fToFgT3Gzda51Puj/IAGBP1G0l1uFbdcZ8DngXlevNAqU1e9xeqVFiYOBGUI?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QsRfH5p7mAWDoFgLiUMLQUCn0vL/VDqGqgk7AqtT3ma32t82UtE791hGfNLpFbqM5J089Dpr4rD7nOPFyUVcDA5y40fwlYATTj/GcP3oU6fnaQ4zW8SwR3v9RQWNl6Nkm7SGTsGVpeklqFq/Cz2QAt1Q92Q0LExG9bgbsb36HEFdTAuR0VebAmVbHqtNlxcnFlbPdny3+HYf7C9a0Dyqg1o0mh3F8l5Hn40lqniLa/wsM2t52Rb6QG+Egrw24cp5T5RHFZgmwoQshNFy33DJNJInLRtab3f739jYp1U5HI9GDpkpgLz6kt2h8cSXGkQZB48LOaZvV97oeR6TsJfuflTy9ir2yxU3Kf58rYCERzny2e3KKh5UieMOIc1s6GyRiJGP4A8CtBG41UFm7CChHwkXCI+E0wP7fOebJFmRgluSXPuptrAZ/IQlTy7BNCFu3p2gyS8m+yXM09bWvHPEOrCL4purYZ+Kw1PjJCc/ElUsshakg6IqfHqPqeKw9sRbiB9ldTsaDigpKZv1m4VSLXjZdB2oFapXmiTqaK0FxZag7RJAEQC1DKWn+IjD0/HVLycFIAWiZ/1NzE4L8zlF1ZZHf9XU/8G6CGuylDBa4IA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3413d912-e0ec-48c9-e5b4-08dca115cc90
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:23:37.9389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2rQz9TCfj3FZY/eQ/mPhd40nm/fs7HyDlHFIFP2cbIvjfPI/sk3YPwMo1TYlx1SK98j7a7zj3pnjpC7qhCHZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_14,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100137
X-Proofpoint-GUID: 1FcKdfosRXhYOwXFQVBbYeag7KEW4t-q
X-Proofpoint-ORIG-GUID: 1FcKdfosRXhYOwXFQVBbYeag7KEW4t-q

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The do_vma_munmap() wrapper existed for callers that didn't have a vma
iterator and needed to check the vma mseal status prior to calling the
underlying munmap().  All callers now use a vma iterator and since the
mseal check of can_modify_mm() has been moved to do_vmi_align_munmap()
and the vmas are aligned, this function can just be called instead.

do_vmi_align_munmap() can no longer be static as ipc/shm is using it and
it is exported via the mm.h header.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h |  6 +++---
 ipc/shm.c          |  8 ++++----
 mm/mmap.c          | 33 +++++----------------------------
 3 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e2140ea6ae98..40f1db1fb233 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3400,14 +3400,14 @@ extern unsigned long do_mmap(struct file *file, unsigned long addr,
 extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 			 unsigned long start, size_t len, struct list_head *uf,
 			 bool unlock);
+extern int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool unlock);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior);
 
 #ifdef CONFIG_MMU
-extern int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
-			 unsigned long start, unsigned long end,
-			 struct list_head *uf, bool unlock);
 extern int __mm_populate(unsigned long addr, unsigned long len,
 			 int ignore_errors);
 static inline void mm_populate(unsigned long addr, unsigned long len)
diff --git a/ipc/shm.c b/ipc/shm.c
index 3e3071252dac..99564c870084 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1778,8 +1778,8 @@ long ksys_shmdt(char __user *shmaddr)
 			 */
 			file = vma->vm_file;
 			size = i_size_read(file_inode(vma->vm_file));
-			do_vma_munmap(&vmi, vma, vma->vm_start, vma->vm_end,
-				      NULL, false);
+			do_vmi_align_munmap(&vmi, vma, mm, vma->vm_start,
+					    vma->vm_end, NULL, false);
 			/*
 			 * We discovered the size of the shm segment, so
 			 * break out of here and fall through to the next
@@ -1803,8 +1803,8 @@ long ksys_shmdt(char __user *shmaddr)
 		if ((vma->vm_ops == &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE == vma->vm_pgoff) &&
 		    (vma->vm_file == file)) {
-			do_vma_munmap(&vmi, vma, vma->vm_start, vma->vm_end,
-				      NULL, false);
+			do_vmi_align_munmap(&vmi, vma, mm, vma->vm_start,
+					    vma->vm_end, NULL, false);
 		}
 
 		vma = vma_next(&vmi);
diff --git a/mm/mmap.c b/mm/mmap.c
index c343366b3ad2..18c269bf8703 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -268,11 +268,12 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
 		 * mm->brk must be protected by write mmap_lock.
-		 * do_vma_munmap() will drop the lock on success,  so update it
-		 * before calling do_vma_munmap().
+		 * do_vmi_align_munmap() will drop the lock on success,  so
+		 * update it before calling do_vma_munmap().
 		 */
 		mm->brk = brk;
-		if (do_vma_munmap(&vmi, brkvma, newbrk, oldbrk, &uf, true))
+		if (do_vmi_align_munmap(&vmi, brkvma, mm, newbrk, oldbrk, &uf,
+					/* unlock = */ true))
 			goto out;
 
 		goto success_unlocked;
@@ -2837,7 +2838,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
  * Return: 0 on success and drops the lock if so directed, error and leaves the
  * lock held otherwise.
  */
-static int
+int
 do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
 		    unsigned long end, struct list_head *uf, bool unlock)
@@ -3319,30 +3320,6 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	return ret;
 }
 
-/*
- * do_vma_munmap() - Unmap a full or partial vma.
- * @vmi: The vma iterator pointing at the vma
- * @vma: The first vma to be munmapped
- * @start: the start of the address to unmap
- * @end: The end of the address to unmap
- * @uf: The userfaultfd list_head
- * @unlock: Drop the lock on success
- *
- * unmaps a VMA mapping when the vma iterator is already in position.
- * Does not handle alignment.
- *
- * Return: 0 on success drops the lock of so directed, error on failure and will
- * still hold the lock.
- */
-int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		unsigned long start, unsigned long end, struct list_head *uf,
-		bool unlock)
-{
-	struct mm_struct *mm = vma->vm_mm;
-
-	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
-}
-
 /*
  * do_brk_flags() - Increase the brk vma if the flags match.
  * @vmi: The vma iterator
-- 
2.43.0


