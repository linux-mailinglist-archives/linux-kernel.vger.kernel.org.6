Return-Path: <linux-kernel+bounces-298791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3766A95CB89
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B7228738B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45AD18754E;
	Fri, 23 Aug 2024 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h7CAsY6y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JOodnWVz"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3118132C85
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724413064; cv=fail; b=mM1aCuuhl+nkkY9KepQKTL1cNY78ahoaXhPtm2RB3rfuTvFjIWExrY9T1Gx22pvsJCIvDqrZyDTrZs1QGJ98KDy5cO4U4ZgFDVPZu3BqFcz4/eozbZC6bwiloNMP5JTc4jiawzLzDGijHLlwFLEiMadgR/x4kFLGvA3pVWIt/A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724413064; c=relaxed/simple;
	bh=4Rxluoh7CqPWwqJjmmftG9sU+bpbCJnjDyfItSTPJw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dPbho9nhT7iu4bkfbgn/30FrloUSht57jUOyJFOxsJNxeUZGoNqMCmAN+eFCXtxnTnXOxpLm+WVkdF05/snAnLHOwFUUbB7rzeWGLs/m7BffomiACbOe9aUq4NevB2/C0wlnCut617+rslCeQmp2fqR2uF0m3ED4BEp6bn/KPl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h7CAsY6y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JOodnWVz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NBZCIC020118;
	Fri, 23 Aug 2024 11:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=U5PEgw4KQsEhuIB
	rJohpSCd9tSAfRqd+VjdTKteQTsY=; b=h7CAsY6yjDTbwg+FXp9MOvnAtcMp1+s
	sW9nVHGAxowR9YZ6G8+1QQgpc9ePl1k+zTUEywUPabc11ToNg6IB8hHeGsLZ6HL3
	W82aHz6WXRo01Txpdy2AQfrQIoOXOhMZgzGDFrcnXOA7aXH6ahsQ1a+nm2kK54CW
	CHNwTkGPrYDKG6NPGzLwhlbLOfFQ8Zuy5EQwqq5iRTZOe+qm6N34h37aLkrKOilU
	ehSL67QP3eGvJyw3ix0jWExAIoTbws+y3vmkUAXhbkd8Hn0FZ/FkRoPw6yi8VVEG
	t808FhUOxZvRakhAn1d3XGRe1e7bzJb8dIXmgmZ6SbEe/8obacM94JA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m6gm77e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 11:37:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NBRmZb014086;
	Fri, 23 Aug 2024 11:37:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416sjtg8qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 11:37:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWquzR4ld/RzcLV2hBPVbDPmvP3cdFqNEdxrADWpMjHQanolatbsQPEPUrkA0RFfpJtK4FPAZRSOD2UcqApffyLwq1JV2TDT1bajuIHZ0wUtZhlBEcgXRwLq81WYmJNMZMlzmSUnY3DPR+rkVJpDe9+tLQS025GD8Gq0Bxlgk+uRc2xBKNzl1byPjsySnRv1aloVIQeckvp6aHvF707k6NfBpob3a+AHX70bAMXeEga56kgPyBJkNi1HIIFKWKZ1Ze5+FPupN++BtYHMaP3TCHwMcUa2ues9Lr8uGmylPsAtVxu07M5f5gWtuy8OPXkt0IPd1Lx+gnCJKdbI+WwGbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5PEgw4KQsEhuIBrJohpSCd9tSAfRqd+VjdTKteQTsY=;
 b=KUApnG5nETkWDe68dehpddk0OG9QCyTbvVBbNGWs2l9GZeMT/O28b1ZMkITDv6GOK/NR10GHzm6VCB6ILDCE6xcPID9ao5gS0dJmF6m28ovwMHJ1XbiYzh7MsLy/vaCMJ2Bgrkf4cMNwbMs/9qsi7xzDLDdHFubF4kZdPahAIK8C7srHv8uWok2KkoH9a+Hk60vusGfdkU8lDdX5m1Bq4/WVoHgVVAG0Ul9upVEh9z8KXQkNc7jZizNxfzQIyPjxAoAHngxM/yUc0+bgHi7BlEjB0oBxHH+9DCdxLlh1/zrmsnVZSn5YAXasmMIUlSh5WwYk4qzwtRRoqBP0BTStHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5PEgw4KQsEhuIBrJohpSCd9tSAfRqd+VjdTKteQTsY=;
 b=JOodnWVzo1Rf0bco0/JVAnZry5APw5QDNYrgkwV9AcNd1fxntNGmjQjZ9r6MnVFcQS8O7CUg1322oMZDGr9asKfpIXJ7DifUY8m5aZXOBshDQRU/gbMFv1P2PEQLO3sFIuvKPMPQvjW3p79z/mXwjw1VANXbkm7Ha0Cei9z0KlY=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CY5PR10MB6119.namprd10.prod.outlook.com (2603:10b6:930:35::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.9; Fri, 23 Aug
 2024 11:37:23 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 11:37:23 +0000
Date: Fri, 23 Aug 2024 12:37:18 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Jiri Olsa <olsajiri@gmail.com>,
        Kees Cook <kees@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v7 06/21] mm/vma: Change munmap to use
 vma_munmap_struct() for accounting and surrounding vmas
Message-ID: <960730aa-d015-417a-846f-4da20965145d@lucifer.local>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
 <20240822192543.3359552-7-Liam.Howlett@oracle.com>
 <b88f105afcd7d96a5306126c51ec236274780bac.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b88f105afcd7d96a5306126c51ec236274780bac.camel@web.de>
X-ClientProxiedBy: LO4P123CA0243.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::14) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CY5PR10MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 28bb2b75-2da3-4d39-341d-08dcc367f4b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OIAaVTB6Bv+0Jdl55ER1Azr7kB85H0/KMebupjT5lQewTf9VPmOEt93K0Pk8?=
 =?us-ascii?Q?wvvZfB8ZbvJTr7m2ohOvTOFILwlZV6zlMt6xnDxbdnlzTkQa642Dwi+XSUmy?=
 =?us-ascii?Q?EQvsgqrA/Y/n8utqwZYdTt0Pm6VRJLb1DYBVJhBDFj59gUEJhB+fq2sKK8zY?=
 =?us-ascii?Q?NonFJvqZJoOjZMI7rnkyGEcKnNSmBU4cIuF0/mzG5AuhmBz9glZjyaHc+q4u?=
 =?us-ascii?Q?4RuFEe2BE2WC/jDOCIJRegorhFzSg+vrVadfUPgEUhNP7G1X4PdzFIa2JS6R?=
 =?us-ascii?Q?79XQwG8dpbGgO8TfSJifphjGMGcIMAL14RKaspsQURtnNq5r3vTGIa5vdpcm?=
 =?us-ascii?Q?JFN+K5STT3PYTEkvIm+VkpiXLRjHh+26MszklZSmZ6PxG2wvsIUfdAqWFRtY?=
 =?us-ascii?Q?LI4y8jfhBNOS574FR8ftcAFRcNc3p5tOPV+/slZ56FH1ijFZixkJG3qazQbb?=
 =?us-ascii?Q?PC6Z+xXHBX9xwBhNMnlFjrXpg1xbzkPetB0PCsLs7pKU9F3fPW2IJXm4e+0U?=
 =?us-ascii?Q?kiHGyoK7Xg8X6/JcnMqFmjvaWVKWMbjo89q+bZ8pKIBI9QnoVg8LAs0r9dPc?=
 =?us-ascii?Q?UsQhb/ZdhauVQpMgwB0gy4EqlQMI/xuxwB+q/i/i+VgFNKYzJlqB5lPJRPgf?=
 =?us-ascii?Q?BRQwXfJB9R/9b/Fb63bSGHTfuupLW5r0pjR1zJm17SZ57GWxKuLsWCTXLfPr?=
 =?us-ascii?Q?LAxNHYznnluCaUkGbNc1lTGCyUioOIv7/+riatGWthXs+2Qxy7NAiChQuKiB?=
 =?us-ascii?Q?aClfy2bLG4cAp1ho+JKMWSBAXACMYk1gZPZ5LV2GwmI1cBPCHpyVZNo0Yb1W?=
 =?us-ascii?Q?c9ZBAk1+PXYd9jAhAM7Ri7AnydEecBKzdntbZQkNmFmv5AluPB/Is6zEtMJd?=
 =?us-ascii?Q?4/FobhhhZD6n50rQp+/WfcjVj3SzwjHXlfhUZWKB2YBH5QwOdpEbsJL1WUIA?=
 =?us-ascii?Q?fPuZb0ADzQD+zS8TA4i8FbNTmAnqQkxbBJb9+Ri/YJo5K3uPqPmLNSvD5Rsx?=
 =?us-ascii?Q?hjmukDSgUJZqB/jtAs/jA3GRAq55xJAFHkt4X0ktFFk1zI8wNFYcH+0K4eVj?=
 =?us-ascii?Q?ApFqcBPeThwZDQX4r0z/DO+6SN1iCScreIQO/iEjBxjU3KcjluLo8XSMBnTa?=
 =?us-ascii?Q?AgyY5zLMTknTP+uS1uEH57wGmTT4b2NspPpci0yPbRTGUMp5emCeXWrvJLmU?=
 =?us-ascii?Q?vf67T/cV/LMsQQlCrZtOrAueQGHiAbZNm2lyd36cjfwWbGsCTN5+pZBmsG63?=
 =?us-ascii?Q?NJqNMEYal5XtPW/ezUSbqUBk3HHUd0tVTPhU1/FJ0ukaR9ubg0nNflrXKzvY?=
 =?us-ascii?Q?mdU639NtCKxcfwMcGWoTI+HKVaq5XBgUSXBOOP9jGHCKQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Izc/tYqiRkAECz2g5gnAp/v+TsYpCvGuHrGPl0th1LpuFPrUf4pjPXTnmvf1?=
 =?us-ascii?Q?MAj+MMR8/nMQFRBnYigOYFQ7lFohypqUqdVURe03Cnu+86p0jLR82wHfmQNR?=
 =?us-ascii?Q?79Z6jLflcMcdwFE+2wghjT9yGQqaA8AeFPSQKs5Cwy1AU3boIKptzkNHgKKY?=
 =?us-ascii?Q?oh4de5d9rJ72qKNeoU9v1kIkyxj2uUXh16aU1FdsskpOnWJ0VtX6D0GvENa7?=
 =?us-ascii?Q?N0Efkweoe6YPPgm3EBbddv5ybhnbW5tSJD8jmEmnMYkKbSoXYk6vkN3jBHyn?=
 =?us-ascii?Q?hSreJ3d8BrJ2SPn+JBU+lY+Vqj4oEG1p8YKPu5av7laIPkIfzx+xCk16MbuO?=
 =?us-ascii?Q?tDRjPD0se76cyK59llo9pGNaKaLGwfyfjmWCumHGmCyQ4wtIBCKlLM4LWCvc?=
 =?us-ascii?Q?b3Ge2GvNhGUO3KTmvRzUccRaDg2dnMEm7i+Z1MmQFmFv4Hg9Jj4ZAjS1/CpR?=
 =?us-ascii?Q?TrW+bLgJIp51jqha7GcUAdK+jaYvcIK41iy52yl1r+fb8pj8VqZb1s5UUZ2Z?=
 =?us-ascii?Q?2d6UKyIaB7rpAfK0XYpClOMm/jRkVlDuubXuuqOQ0fUuL/K6uQvHJYDZnzv5?=
 =?us-ascii?Q?2vgKao8zmeNfnjyw2w9uZX85vvB7Xu65cZeAmkmHZP3ctUxTRlPh1V747GYk?=
 =?us-ascii?Q?YoEKat8L57l3d0dnVAhNpmDRy8M924co5GgTZHCOUXaBd2kmk/iXrM4nHIh3?=
 =?us-ascii?Q?Xcw9C5XOrKiWw4DQLDsoyrpH+MN0Qh43PmGPTEEt4nI60J8bKoUSUP5Vg2OG?=
 =?us-ascii?Q?CkHQVOegmahrn8zDVzlR8cBN+Xccqj05F5EbMp/Uiq7c5a6b4xK981OaznYi?=
 =?us-ascii?Q?VqAs6FrkO6mXttaApFwbxAZ6kihkb0U2Z0IE4AXuuM6eDkt/+gP33Ijvuqjn?=
 =?us-ascii?Q?mBAUshwVtFXumiTqN9QseZwwPWNDeCOmbwQbxgkQNFH+rhXSiLy8VuHG2XCy?=
 =?us-ascii?Q?SH4ieKkRpQZ6IqnvYA5cuoV0Y3YXVyRfCjxZCNG5GY8X0RwPCdV9jGR+IzYT?=
 =?us-ascii?Q?sj/HO0lfVUQvCDonDGtAP8xrNzxwkH/SXNqoiAuvEHNt4H0VCSFqvBLlutea?=
 =?us-ascii?Q?+ffnDYwNVCfKvQJKUjiQ+m1LlNXAsRzwNALmwyHFC+ENS4mqF2wfk3lSLIzM?=
 =?us-ascii?Q?GnHEXtbwa/g8BYbxesijSXjxujiS4mHz31ZX74ZhbR103hWZjWWnIVtVm2/R?=
 =?us-ascii?Q?vhRdsStTn/1lIjTNmCzSU4q8e3TDqULSdHLnVabdkWIZqF8zNDIFBl3m+TSK?=
 =?us-ascii?Q?rs/DfOmDSfEqSnMBTtmWzWe9fJU6BFMVxSCHrynrXhewxdyQZbv9SpMZ6DM2?=
 =?us-ascii?Q?DPsDgu+zRbLvhv0QEvfo7zeJ9wfOg3Bb4woL4RHnzbhXQW3qA1jeYyT8smym?=
 =?us-ascii?Q?k+cHyEbGRh+FfsE3Qtmvtgf/h1kzyN+zAwv84VPrjdzPe1v9q9R8bpUHtppn?=
 =?us-ascii?Q?1hQX0y7Yw5YxS87pejj+jB0HxLPPNMpmI0JAbhWCUgF6G9QDHDD3DKAAbG7I?=
 =?us-ascii?Q?HvJtJCfA08c0t9I01g61HSdKlL660SJMYXO4vLbSAioinBnBgwakD1PvHO7a?=
 =?us-ascii?Q?kjg3UnA7NHXY5AHLRlH7de9wddcGiChmTwwhIse/naNU9zoA1OJ8z9Sm9qu+?=
 =?us-ascii?Q?WJxNGhptvYP+SwqHWMkx8zm6Fwr3ZDVBiKc75Us1/eQXpco7fNqtCWGTRdh0?=
 =?us-ascii?Q?p4dkmw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fFnShJRWXELo7ZzOmDkqqM78PSrHPn8kkB/4kmc9jfloXsXcFPasN4sLk7l+1v4ZZJ+1PK5Rt0U2mfwCBVdVl4YSsXi/CfXxeXw1sxwb/M5QmUsE4E/eCLYLGSR1QcPK7+6TY2ytbNITeCvYyFs28ilnuBpKSfcJjhpRcZi1e+SroQrD5BSmOqhGl6SOHNmlAi+/y7NyWe8/s1FJekepHIzunCqDu6xIlFzPLMzq1vdZwo0IzDOrT9r7R1BeWWd+S3Qc56wvYp9hPrf/BA+16ElVTt+8a+Uf1ZmDkLVo60xb/5EhqnGfo7kTRiRMIFi13MaJhuC5jT+Bnhjw2relkKRVU2EkpFZczEDJVl6pOSJZT1c8+Rs4zRuL3zeHdb4xcRBYtnNxpn6Vaea2vfCYc35JJeY21laow1csURzH6oynxdfbvkO4F2+UmylHf16vDoFe/iaNZnXAJ1L2f2z+KPIkQJrOteVjTr35BAibgJrCqz/sqCj88GCgVxTf8Dw2tgTiJjJNfq0O2AzvN9FAav6SpIUqt42XiVHMw77oHgza4AbBFtgYszwKSa4sajlpJa0aS8todrCGT3gSdrqFsxDVa5UdYsJ+i63oiYv2UMA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28bb2b75-2da3-4d39-341d-08dcc367f4b5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 11:37:23.7027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6cke6Wv8W3FNIB6dYYqYXW2TxowxuslBylEVAA+gCHsUPsdXxW+kxyvaAPSzypMhxI3PMnVGdIhjB4lGlWuW1LAl+XY41Kb1Kh0ugDaQFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6119
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_08,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408230085
X-Proofpoint-ORIG-GUID: 78fXpGn3d7jkImwqhcAWbyWTXx3_o9HH
X-Proofpoint-GUID: 78fXpGn3d7jkImwqhcAWbyWTXx3_o9HH

On Fri, Aug 23, 2024 at 10:43:11AM GMT, Bert Karwatzki wrote:

[snip]

> > @@ -731,21 +708,31 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
> >  	if (vms->unlock)
> >  		mmap_write_downgrade(mm);
> >
> > -	prev = vma_iter_prev_range(vms->vmi);
> > -	next = vma_next(vms->vmi);
> > -	if (next)
> > -		vma_iter_prev_range(vms->vmi);
> > -
> >  	/*
> >  	 * We can free page tables without write-locking mmap_lock because VMAs
> >  	 * were isolated before we downgraded mmap_lock.
> >  	 */
> >  	mas_set(mas_detach, 1);
> > -	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
> > -		     vms->vma_count, !vms->unlock);
> > -	/* Statistics and freeing VMAs */
> > +	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
> > +		     vms->start, vms->end, vms->vma_count, !vms->unlock);
> > +	/* Update high watermark before we lower total_vm */
> > +	update_hiwater_vm(mm);
> > +	/* Stat accounting */
> > +	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm) - vms->nr_pages);
> > +	mm->exec_vm -= vms->exec_vm;
> > +	mm->stack_vm -= vms->stack_vm;
> > +	mm->data_vm -= vms->data_vm;
> > +	/* Paranoid bookkeeping */
> > +	VM_WARN_ON(vms->exec_vm > mm->exec_vm);
> > +	VM_WARN_ON(vms->stack_vm > mm->stack_vm);
> > +	VM_WARN_ON(vms->data_vm > mm->data_vm);

Hang on... I didn't read this closely enough (clearly!) we're doing these checks
_after_ we decrement the counters, which is... not correct :)

Your processes must be reducing their data_vm value to something less than what
was reduced during the munmap operation.

Liam - I suggest we put these checks before we decrement.

> > +
>
> I'm running the v7 Patchset on linux-next-20240822 and I get lots of these
> errors (right on boot) (both when using the complete patchset and when using
> only the patches up to this):
>
> [  T620] WARNING: CPU: 6 PID: 620 at mm/vma.c:725
> vms_complete_munmap_vmas+0x1d8/0x200
> [  T620] Modules linked in: amd_atl ecc mc sparse_keymap wmi_bmof edac_mce_amd
> snd snd_pci_acp3x k10temp soundcore ccp battery ac button hid_sensor_gyro_3d
> hid_sensor_als hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d
> hid_sensor_trigger industrialio_triggered_buffer kfifo_buf industrialio amd_pmc
> hid_sensor_iio_common joydev evdev serio_raw mt7921e mt7921_common mt792x_lib
> mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr nvme_fabrics fuse
> efi_pstore configfs efivarfs autofs4 ext4 crc32c_generic mbcache jbd2 usbhid
> amdgpu i2c_algo_bit drm_ttm_helper ttm drm_exec drm_suballoc_helper amdxcp
> xhci_pci drm_buddy hid_sensor_hub xhci_hcd nvme mfd_core gpu_sched
> hid_multitouch hid_generic crc32c_intel psmouse usbcore i2c_piix4
> drm_display_helper amd_sfh i2c_hid_acpi i2c_smbus usb_common crc16 nvme_core
> r8169 i2c_hid hid i2c_designware_platform i2c_designware_core
> [  T620] CPU: 6 UID: 0 PID: 620 Comm: fsck.vfat Not tainted 6.11.0-rc4-next-
> 20240822-liamh-v7-00021-gc6686c81601f #322
> [  T620] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-
> 158L, BIOS E158LAMS.107 11/10/2021
> [  T620] RIP: 0010:vms_complete_munmap_vmas+0x1d8/0x200
> [  T620] Code: 8b 85 a8 00 00 00 a8 01 74 35 8b 85 e0 00 00 00 48 8d bd a8 00 00
> 00 83 c0 01 89 85 e0 00 00 00 e8 7d 39 e8 ff e9 63 fe ff ff <0f> 0b e9 eb fe ff
> ff 0f 0b e9 d0 fe ff ff 0f 0b e9 d3 fe ff ff 0f
> [  T620] RSP: 0018:ffffa415c09d7d10 EFLAGS: 00010283
> [  T620] RAX: 00000000000000cd RBX: ffffa415c09d7d90 RCX: 000000000000018e
> [  T620] RDX: 0000000000000021 RSI: 00000000000019d9 RDI: ffff9073ee7a6400
> [  T620] RBP: ffff906541341f80 R08: 0000000000000000 R09: 000000000000080a
> [  T620] R10: 000000000001d4de R11: 0000000000000140 R12: ffffa415c09d7d48
> [  T620] R13: 00007fbd5ea5f000 R14: 00007fbd5eb5efff R15: ffffa415c09d7d90
> [  T620] FS:  00007fbd5ec38740(0000) GS:ffff9073ee780000(0000)
> knlGS:0000000000000000
> [  T620] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  T620] CR2: 00007fc336339c90 CR3: 000000010a39e000 CR4: 0000000000750ef0
> [  T620] PKRU: 55555554
> [  T620] Call Trace:
> [  T620]  <TASK>
> [  T620]  ? __warn.cold+0x90/0x9e
> [  T620]  ? vms_complete_munmap_vmas+0x1d8/0x200
> [  T620]  ? report_bug+0xfa/0x140
> [  T620]  ? handle_bug+0x53/0x90
> [  T620]  ? exc_invalid_op+0x17/0x70
> [  T620]  ? asm_exc_invalid_op+0x1a/0x20
> [  T620]  ? vms_complete_munmap_vmas+0x1d8/0x200
> [  T620]  do_vmi_align_munmap+0x1e0/0x260
> [  T620]  do_vmi_munmap+0xbe/0x160
> [  T620]  __vm_munmap+0x96/0x110
> [  T620]  __x64_sys_munmap+0x16/0x20
> [  T620]  do_syscall_64+0x5f/0x170
> [  T620]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
> [  T620] RIP: 0033:0x7fbd5ed3ec57
> [  T620] Code: 73 01 c3 48 8b 0d c1 71 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e
> 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff
> 73 01 c3 48 8b 0d 91 71 0d 00 f7 d8 64 89 01 48
> [  T620] RSP: 002b:00007fff0b04d298 EFLAGS: 00000202 ORIG_RAX: 000000000000000b
> [  T620] RAX: ffffffffffffffda RBX: ffffffffffffff88 RCX: 00007fbd5ed3ec57
> [  T620] RDX: 0000000000000000 RSI: 0000000000100000 RDI: 00007fbd5ea5f000
> [  T620] RBP: 0000000000000002 R08: 0000000000100000 R09: 0000000000000007
> [  T620] R10: 0000000000000007 R11: 0000000000000202 R12: 00007fff0b04d588
> [  T620] R13: 000055b76c789fc6 R14: 00007fff0b04d360 R15: 00007fff0b04d3c0
> [  T620]  </TASK>
> [  T620] ---[ end trace 0000000000000000 ]---
>
>
> Bert Karwatzki

