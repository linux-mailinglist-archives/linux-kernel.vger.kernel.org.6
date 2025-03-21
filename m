Return-Path: <linux-kernel+bounces-572024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AACAA6C584
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF0D3B3C27
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B7D23534E;
	Fri, 21 Mar 2025 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ajg+Lr72";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zUvQxknq"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5D2233129
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742594117; cv=fail; b=t8agMRYUDsBLjFMH1B0NAETQT37PN3yZx1SE+EvwvydAyEt3ndAltTUIYtRoeTlGDB6yjANKYWJI5gswwQ/1G8xUBh+5HJvWSNP764HNqjb2fAi+1HwQ06cWjy4/zMwPtVyQ/O9jGT0B/l7eytGApgfevmGQ1WzziFl+rDvge2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742594117; c=relaxed/simple;
	bh=Xv6JJkA0DZgH3UaoRs8o70eroh/DpJJrHdwERX3eJUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YYRcdjGp5nbBzuM6CHPu4AXj9l6PQk6scTt9ZLtCL1SdnP63ste8K+hE/pRANYT+zyigpDKgjVdSjdOQK9nQ5LkO3Kg3NQ9Rx0lkofaUei3lK0HM6pNfo/rw3CRVWvJ4eAAh9Sfw9d0VY23TMzxd9tMOe34GFS+bePrsmsKFAOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ajg+Lr72; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zUvQxknq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LKft0H021302;
	Fri, 21 Mar 2025 21:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=egGtESki8KL5HAPZex5IRhZqtYZyfYRDstcRYfPi7TU=; b=
	ajg+Lr72kEVLGWtd6rvmjS7zc7qu1Y+TPGIKtjjVJGR1R7DPDlJ0Jqb9iHWNUwlW
	E8ttJau8oBDeBduFI3t/zsjg7z415GGq4bkqMMffY8neJgxZ7pHURcRIfy/HZB9K
	/cF/ItgRg+W2mvdmSMNwbM1PD8euGaIhPrKO/9E5app4OHYkiR+HMp88zDzT5j7S
	VqY/aOnR+ND+wIfmW8Bj/QtBfySRYI5XiLN2EHDpu/O6tKrfyn9T2Ibb8hq6L1uA
	3WwnPlkkqNGQ0FNtyu9HXuW1OFm/zDZ4lvCxthn5X2cy2zrGEhdasmmb96dDNwaA
	Nap0ZsYazpDJpTBiu/kkGA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1n8sgb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 21:55:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LL3Bxs022365;
	Fri, 21 Mar 2025 21:55:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxem9n1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 21:55:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+/HlfYdM4x/LDKC9R4LQjcpFxqKJ4iBycd1hAbe0uF4xabcR+V29uYwEkq8YSD5pwrCFDYi7lW8QmTTKZlAXICwYu5s/3c2Q8vMpmMmPnH+zFQNISBHuIT42W0FOLHQN8K7i/BjHLvw04kA/00lqHRJ/ZmGwZXtz2QQgUqEWwiIggvViNBFEIy1EpRjBiaqU5mCQvVvRpYaXwaQdP+/R6z3kXTSoEGO3f2RyhxlV9hyF7+1Ko4edCD9YzMgwXVVZbNMGlkO+iAN0Tc2eY/ctw8WPeNcDSbJqyS1jFOHLKKycGdzi2bY14CIyWeKeQoKrwhf6UieF+FPhDNBOlVXBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egGtESki8KL5HAPZex5IRhZqtYZyfYRDstcRYfPi7TU=;
 b=aWGz/LPlATQqTpgWdZTzJSBmDGuugEZFXm7B+++1Cs1kzQukxKNGfxuqPbezr+d4kn9RMDZ9u9p99et+M2T6RlnRh3V7C2pWJdjBHGiPqS+fyZbT0kk5ZPEWLufqjli1zq2IHxag4tC8+ZgundctRkHT8BqR5b24y/JrjfuTuDfEJDCnU7TF9ZZtL3R5ccZOieY6X07XvVbskFKcFH4Qjive1IVwbuD7LcJfPbL+8BZ7E0VpQjVANna0HnMhuN5vtrHtmXEiJZ5BTuvD7YXgoj+eLA6qFM1zF5EXqow6INSQQaGLTPL5PTVTovxsz7SzqxtfGDYC5AQ9mk+ePlViOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egGtESki8KL5HAPZex5IRhZqtYZyfYRDstcRYfPi7TU=;
 b=zUvQxknqzQGDhWgUw36+Wr8PCdcCCoipL9/KyI1OJLJDBZtRbuIDBXL5H9D1l4Hm25T9kTG4F6kse4M+VwkrDCvwdsDyZDaGijm5L1dvq3F/MK8CUYMpS0vhUGnIcQx/L/wAmQIMu/HwhKIe4aBswTH1DnHQHFP/u5GUW0MHv4g=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY5PR10MB6144.namprd10.prod.outlook.com (2603:10b6:930:34::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 21:54:59 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 21:54:59 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 7/7] tools/testing/selftests: expand mremap() tests for MREMAP_RELOCATE_ANON
Date: Fri, 21 Mar 2025 21:54:36 +0000
Message-ID: <82fc24b357b76f6f8475425f9fc99d0d15d9078a.1742478846.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742478846.git.lorenzo.stoakes@oracle.com>
References: <cover.1742478846.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0326.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::26) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY5PR10MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e994ea-3c1c-40a0-c161-08dd68c306ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BcAYMJSFC5yGVRccCkZx9yDIWkYE5HmyXo1k0GaNyCqiTpdaBNSxCwOZaxN3?=
 =?us-ascii?Q?BCIx/lkbUmjSS42zdIL11EmvcA2NI6AyMGDHL68F3CUTfV7qzhkPwORI+CAx?=
 =?us-ascii?Q?j663mBCYSGjr1rbN8mqkCsQzXArVaBmWIliTjRpC5U2mTSoqHbZFXIG1HJju?=
 =?us-ascii?Q?nw9hYk8VemwVzf4Gg8tpMn+LKv8jV3LuUuFDzFCU773nKSX+GmOewuOH+G5K?=
 =?us-ascii?Q?pKsUQbEnw6tS06SErtOYgRxDedikCZwzUoSNV0oZ67c9PkSmaSgEfvm2VoaS?=
 =?us-ascii?Q?HdYxdKlx+C0+bf9V2JSDzLeUC9ZQm5chijdkP7ryJpKmaYzYxtKzSQj1EwBB?=
 =?us-ascii?Q?Vnp+PG26GpMVHSnslcO7B4CsWmkFi5gigoWZYdfKbd8sUoAcPbbQ3hr8BN5a?=
 =?us-ascii?Q?wEwnEW/+ClJkXn7DtA23ZxUPnigd9EIgr+cO7Y47lPUbMFunZyurCZANiTdp?=
 =?us-ascii?Q?ydTBuy/hkMFyw75/UoP8WulC8VaMbiaZlnNWUKvnGfhhvTGpq7yWrCJTdvjl?=
 =?us-ascii?Q?+4KbdPyIncNkemcqOAEX+h2CziwOWyGsBt83+crxC1f03VlQcBEOtZgtNKgz?=
 =?us-ascii?Q?zRrNAoBXd1ITC7dZ/Pmvi28aSo3ODlnAJYqStQS9S+H6QMMz+xEpbgEkfO/F?=
 =?us-ascii?Q?8vwNCDDh7PcbAsy/2ztqseR/OG75PKL73Rm8xpmGtf2dfcp5a6NUninXv8Ka?=
 =?us-ascii?Q?i2Dqnn03mILE6CXCzCh74hc4ApQbqB8eWuQnwQUMI/pCM7KCSv6ynLhDCSzZ?=
 =?us-ascii?Q?s1meLDJXMn3GYAxzQLe+Qfr60vRmZfqc/UTahHdFszkjJxY5TTA8kZ92J2s1?=
 =?us-ascii?Q?/5JDHQh8dcWOkE4yzJiQM3HTyGSEJJrMQChevcLnkAZfCEbQSKTbbAtL6nNk?=
 =?us-ascii?Q?UxcybLdWTZf8XltKWi5c7yN5/2WOc/5i/EOGsHUPiP4L0M+BA5yDoikchtia?=
 =?us-ascii?Q?BH50Lxu4JnGRu5OOrOnvrY851w5mHuNYBTUN8hzMCYklShr6AGNltHBjDN4H?=
 =?us-ascii?Q?7VquSOyQ72aOv+SQH8QmZpqBXYRc1G0vphKttx75mgDHlSNZFGO4N27kejtE?=
 =?us-ascii?Q?7/62VYs8lG5ddGDfN2FmIlmW1Eo/eHKd9fSqN4yvYGjHpROCUm86ITYFuhxT?=
 =?us-ascii?Q?KNc9X1f6yQ9KDVApTWCUcMocZnQofTbnTR9ATX84XDCP4R/BddFkbHrCZmLx?=
 =?us-ascii?Q?hAYy/krwfNx+5e3avZrABDazDGMoEpC+1h3f8Rk5+SPaoWkKAJm7EBaHYjVX?=
 =?us-ascii?Q?kTo8lXoMABno/p6fdM0PIGnfZMXp6frqbNaVGSpmzrZ4E0CtN9+bWWql/gQG?=
 =?us-ascii?Q?hPXLHfs1eBfO5dTLnQcER+gPEqpfjFQfCZHaUAst0UYlgM7rRoAcJ8NItDvj?=
 =?us-ascii?Q?opQldTpCr5iQMst4wwkOBWi3MSqI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DaBm2je/lRI0YckcIkCifSvglKe0HldMe/+N9ZVdFU/R+E8iPUqhEKM2/3jy?=
 =?us-ascii?Q?r8tMCdX4NGVOc0J3UAP1eWGWq7sUzcxH6LLlRJYzFQh2CA191hhtzvOKIQOV?=
 =?us-ascii?Q?QE/KyPkSCcPCc99tWzo/qocVpZ5AxkEWc3dADkFDkHXiV4b9P3JAGkwh+WNx?=
 =?us-ascii?Q?dKhiITT4pSK0gbYI3h5oyWlOgcdl0DA5tVxaAI+hcNwvXHRsio9uEJ14jc6D?=
 =?us-ascii?Q?TtUq0LPjk8rbTSq4EKwrBdY8wRpfPLWHM1Kbdcr+c4fdJcvy/wQSM7SpSWqp?=
 =?us-ascii?Q?5R0KM+TmYA2aF8CSl1NDYtFwdIpBFe44YJm7Ui58yQKU5/sMIaHhB0iIKQQV?=
 =?us-ascii?Q?vxBKI2/3lVGFvHHwQ6Aw7/SHaII05dt2aP5fgTKLq3WIlj52XYRnA7VpllQQ?=
 =?us-ascii?Q?aXbs0FPZ6sxO1HUE6Y3rfhp3PpheqJF5g4oeL+VKsJQgEEozejU9iSDqCFMd?=
 =?us-ascii?Q?fplExi/YZtLTIuvJaa6NF0s2kiAihasUynxr7F100H+3+ka/im5Z/8H3zZw/?=
 =?us-ascii?Q?OTaJbkUiOdg8tLM1/ik+PQW5wQLrNHjLvU0IWHisevTdc+KRTF0UIv2PJw4u?=
 =?us-ascii?Q?B8ZdvNJOnDXE4sMK+lSBLFHUkQ00ujzzRQ6wzEbSJgSvvkbUplken3CG3nFJ?=
 =?us-ascii?Q?We3FZy2DQQ6CYJ+cVlhbX4Osrh+40NvmoEI3DNwIeSNDpFgWjGFKq55sv5h6?=
 =?us-ascii?Q?31kzCFsvRyVj5p60s7BOcooVS5mCHowRWf6pN135IWYUKa+H9PQ/CDPjzagj?=
 =?us-ascii?Q?0q/CPxapio88gxKMf/tyXr/VJth50+UfmMs3EKcHg3s+1DGDQzJyUUeyKghg?=
 =?us-ascii?Q?rpDCTf/bxLw0iwdLFvl4VqDmljRqPZ06MSb4HVgbys3J3RyCYjcPopSe9CtT?=
 =?us-ascii?Q?l6GUC1U26wAxxg58DPGID2PR4x2Ey1mP7mRtQ2HwlaG/b7L+MFEAJLhTWAo7?=
 =?us-ascii?Q?GIElTv/d6Uo11tb3gjtSli5pkOMyfr9xjeFjA0WrCb9OFk6WwA9b5SpJ5/Eo?=
 =?us-ascii?Q?C5PKQ85UYcIMxDfMt4yGyFze7Vcxk+2I1XdVR/jMmptb/1TdC1WkCmCWhI7S?=
 =?us-ascii?Q?AjXH+x27xOKaMm7vEUY8Ft0DYDtXAwfyqsZsTRGN+hgjELTt1bn6qRHqshGQ?=
 =?us-ascii?Q?65F+C1paeowcMVor8W/4Vr1gfIv/AdQeLHFZLDmX4gg0AkLsYG+n+nMlqnBp?=
 =?us-ascii?Q?tYdqfPpgL1XcPvBR9kaPblahHub5qWvVWd8J62WRSGbid/CadTUMbilAVuRZ?=
 =?us-ascii?Q?KdAEqKVb2gQV1FaOU8mh6bmYJQVtmDDZmCFHlNpX6brL/r+Z1IbIhIAQJiqE?=
 =?us-ascii?Q?CWc7U1viWG8Fqugj3qJNhzwOQ+OZ99ZiBDCLyjGdN1x/XS6WAwrRHDZvDX2K?=
 =?us-ascii?Q?yIXI/7X8FPjidUx4GTFwCAe6xE+tcg7lvLqIn+Q6Mti1P7ovOmciKL+Hy//B?=
 =?us-ascii?Q?pUuwC6yF2MIf9ofbCMN4hCYa/8/7z+zEWmRcVRXMP6P+8eMHctK1vDHZIssy?=
 =?us-ascii?Q?qc1FGH18B7OGlsQGkBvqRwd7ZYptUp/Ka+dZfPIqAYJfbovm7vp/Lrw6g28E?=
 =?us-ascii?Q?HlBbDfRhCXFlEukEz+oP7VK1vLamEiMfHHkqMmI0qm/ltC6+OeO8W5acRwoL?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	doL9wY4ohkW3UTlU4nmIhnfdLLTauVjBiqJnskkqUiwUCoBlK2soe8TmrABJYcPLB2B1rCvFuZ9iS5TVsmMDxDgnedvqh+U6YuP1AoOyxUGORoFbRNVOrDM4hTdvzWIW5ASLKL59CX6CHxqGbWJO9oqijcyXNRTv8lfJAwGGJRer0HRhbcGjO96AiTVo7cUIx+IDVJa8wsNN2hIMoFUjtZ2DYv+y+KTwXxQns0rQLu7IIS6Wo0mhO0XCTqbTwuQcOJIgrkAELSYq3E63jMkyM1Fz/a1LBA3VVay8XRYzAOuXDMCzPmrI/hLkLS47QJtHYSO3UadFOCE8IRXQS5kcIPyyt+qfwjZtAmRKiw4nhdiuOHBn/1RUM0i3KfsGFgr11SETWC/+KOM4aS9HtQcem7iD7ZrvzFhcRB9C2U1c85fJn4a7o9uewJ7xZ0td11zGa6FeRar3EaV+mvnlRyi6laJLItb7XwPnDeHRK/eLWFXSqd7o9TW4Qh9kz/9kJm0MoNeKzKgnxN5S1dCNzXujvMSIE9sgBrKFFC/lJTcuTd6Jo/Ro6jiqJwz0huwQcXNcbYaSu0c+S70qIt2Skaw0POEjbLk9QPPHnWZu7BsqzyY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e994ea-3c1c-40a0-c161-08dd68c306ae
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 21:54:59.8551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41oqi6QXuXXrrcSGYMRyq9UWMIvxvlKxgWdVEUATq+U72opqNNly8NIuorx8zgQCeYBnM2IISUBRdTHMERkS45AkiznxBUM3N0zAt9K/Mvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_07,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503210160
X-Proofpoint-ORIG-GUID: Ron0i1Eeolkg__5vTMM1kB6_QDIiL2OS
X-Proofpoint-GUID: Ron0i1Eeolkg__5vTMM1kB6_QDIiL2OS

Adjust every relevant test (that is, one that moves memory) to also perform
the same test using MREMAP_MUST_RELOCATE_ANON to assert that it is behaving
as expected.

In order to avoid glibc not being up-to-date, also move to using the
mremap() system call direct, and import the linux/mman.h header, which will
use the tool linux header wrappers, to get the latest mremap defines.

Also take careful precaution in the instance where we might unexpectedly
fail the 'mremap move within range' test due to large folios mapped outside
of the range we are relocating.

In these instances, if we test with MREMAP_MUST_RELOCATE_ANON, we ensure
the folios in question are not huge. If testing with MREMAP_RELOCATE_ANON
we do not - this asserts that this correctly falls back to non-relocate
anon behaviour.

In cases where MREMAP_MUST_RELOCATE_ANON is used, we attempt to immediately
trigger reclaim to also assert that the rmap state is uncorrupted.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/mremap_test.c | 270 +++++++++++++++--------
 1 file changed, 176 insertions(+), 94 deletions(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index bb84476a177f..2d155f2ac1ba 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -8,9 +8,11 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
+#include <linux/mman.h>
 #include <sys/mman.h>
 #include <time.h>
 #include <stdbool.h>
+#include <sys/syscall.h>
 
 #include "../kselftest.h"
 
@@ -29,11 +31,20 @@
 #define SIZE_MB(m) ((size_t)m * (1024 * 1024))
 #define SIZE_KB(k) ((size_t)k * 1024)
 
+static void *sys_mremap(void *old_address, unsigned long old_size,
+			unsigned long new_size, int flags, void *new_address)
+{
+	return (void *)syscall(__NR_mremap, (unsigned long)old_address,
+			       old_size, new_size, flags,
+			       (unsigned long)new_address);
+}
+
 struct config {
 	unsigned long long src_alignment;
 	unsigned long long dest_alignment;
 	unsigned long long region_size;
 	int overlapping;
+	bool use_relocate_anon;
 	unsigned int dest_preamble_size;
 };
 
@@ -60,7 +71,8 @@ enum {
 #define PTE page_size
 
 #define MAKE_TEST(source_align, destination_align, size,	\
-		  overlaps, should_fail, test_name)		\
+		  overlaps, use_relocate_anon, should_fail,	\
+		  test_name)					\
 (struct test){							\
 	.name = test_name,					\
 	.config = {						\
@@ -68,6 +80,7 @@ enum {
 		.dest_alignment = destination_align,		\
 		.region_size = size,				\
 		.overlapping = overlaps,			\
+		.use_relocate_anon = use_relocate_anon,		\
 	},							\
 	.expect_failure = should_fail				\
 }
@@ -184,6 +197,12 @@ static void *get_source_mapping(struct config c)
 	unsigned long long addr = 0ULL;
 	void *src_addr = NULL;
 	unsigned long long mmap_min_addr;
+	int mmap_flags = MAP_FIXED_NOREPLACE | MAP_ANONYMOUS;
+
+	if (c.use_relocate_anon)
+		mmap_flags |= MAP_PRIVATE;
+	else
+		mmap_flags |= MAP_SHARED;
 
 	mmap_min_addr = get_mmap_min_addr();
 	/*
@@ -198,8 +217,7 @@ static void *get_source_mapping(struct config c)
 		goto retry;
 
 	src_addr = mmap((void *) addr, c.region_size, PROT_READ | PROT_WRITE,
-					MAP_FIXED_NOREPLACE | MAP_ANONYMOUS | MAP_SHARED,
-					-1, 0);
+					mmap_flags, -1, 0);
 	if (src_addr == MAP_FAILED) {
 		if (errno == EPERM || errno == EEXIST)
 			goto retry;
@@ -251,7 +269,7 @@ static void mremap_expand_merge(FILE *maps_fp, unsigned long page_size)
 	}
 
 	munmap(start + page_size, page_size);
-	remap = mremap(start, page_size, 2 * page_size, 0);
+	remap = sys_mremap(start, page_size, 2 * page_size, 0, 0);
 	if (remap == MAP_FAILED) {
 		ksft_print_msg("mremap failed: %s\n", strerror(errno));
 		munmap(start, page_size);
@@ -292,7 +310,8 @@ static void mremap_expand_merge_offset(FILE *maps_fp, unsigned long page_size)
 
 	/* Unmap final page to ensure we have space to expand. */
 	munmap(start + 2 * page_size, page_size);
-	remap = mremap(start + page_size, page_size, 2 * page_size, 0);
+
+	remap = sys_mremap(start + page_size, page_size, 2 * page_size, 0, 0);
 	if (remap == MAP_FAILED) {
 		ksft_print_msg("mremap failed: %s\n", strerror(errno));
 		munmap(start, 2 * page_size);
@@ -324,20 +343,35 @@ static void mremap_expand_merge_offset(FILE *maps_fp, unsigned long page_size)
  *
  * |DDDDddddSSSSssss|
  */
-static void mremap_move_within_range(unsigned int pattern_seed, char *rand_addr)
+static void mremap_move_within_range(unsigned int pattern_seed, char *rand_addr,
+				     char *test_suffix, int extra_flags)
 {
 	char *test_name = "mremap mremap move within range";
 	void *src, *dest;
 	unsigned int i, success = 1;
-
 	size_t size = SIZE_MB(20);
 	void *ptr = mmap(NULL, size, PROT_READ | PROT_WRITE,
 			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	int mremap_flags = MREMAP_MAYMOVE | MREMAP_FIXED;
+
 	if (ptr == MAP_FAILED) {
 		perror("mmap");
 		success = 0;
 		goto out;
 	}
+
+	/*
+	 * If THP is enabled, we may end up spanning a range which has large
+	 * folios not enclosed within the mapping, which will disallow the
+	 * relocate.
+	 *
+	 * In this case, disallow huge pages in the range.
+	 */
+	if (extra_flags & MREMAP_MUST_RELOCATE_ANON)
+		madvise(ptr, size, MADV_NOHUGEPAGE);
+
+	mremap_flags |= extra_flags;
+
 	memset(ptr, 0, size);
 
 	src = ptr + SIZE_MB(6);
@@ -348,8 +382,8 @@ static void mremap_move_within_range(unsigned int pattern_seed, char *rand_addr)
 
 	dest = src - SIZE_MB(2);
 
-	void *new_ptr = mremap(src + SIZE_MB(1), SIZE_MB(1), SIZE_MB(1),
-						   MREMAP_MAYMOVE | MREMAP_FIXED, dest + SIZE_MB(1));
+	void *new_ptr = sys_mremap(src + SIZE_MB(1), SIZE_MB(1), SIZE_MB(1),
+				   mremap_flags, dest + SIZE_MB(1));
 	if (new_ptr == MAP_FAILED) {
 		perror("mremap");
 		success = 0;
@@ -375,9 +409,9 @@ static void mremap_move_within_range(unsigned int pattern_seed, char *rand_addr)
 		perror("munmap");
 
 	if (success)
-		ksft_test_result_pass("%s\n", test_name);
+		ksft_test_result_pass("%s%s\n", test_name, test_suffix);
 	else
-		ksft_test_result_fail("%s\n", test_name);
+		ksft_test_result_fail("%s%s\n", test_name, test_suffix);
 }
 
 /* Returns the time taken for the remap on success else returns -1. */
@@ -390,6 +424,10 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 	long long  start_ns, end_ns, align_mask, ret, offset;
 	unsigned long long threshold;
 	unsigned long num_chunks;
+	int mremap_flags = MREMAP_MAYMOVE | MREMAP_FIXED;
+
+	if (c.use_relocate_anon)
+		mremap_flags |= MREMAP_MUST_RELOCATE_ANON;
 
 	if (threshold_mb == VALIDATION_NO_THRESHOLD)
 		threshold = c.region_size;
@@ -431,10 +469,15 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 	}
 
 	if (c.dest_preamble_size) {
+		int mmap_flags = MAP_FIXED_NOREPLACE | MAP_ANONYMOUS;
+
+		if (c.use_relocate_anon)
+			mmap_flags |= MAP_PRIVATE;
+		else
+			mmap_flags |= MAP_SHARED;
+
 		dest_preamble_addr = mmap((void *) addr - c.dest_preamble_size, c.dest_preamble_size,
-					  PROT_READ | PROT_WRITE,
-					  MAP_FIXED_NOREPLACE | MAP_ANONYMOUS | MAP_SHARED,
-							-1, 0);
+					  PROT_READ | PROT_WRITE, mmap_flags, -1, 0);
 		if (dest_preamble_addr == MAP_FAILED) {
 			ksft_print_msg("Failed to map dest preamble region: %s\n",
 					strerror(errno));
@@ -447,8 +490,8 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 	}
 
 	clock_gettime(CLOCK_MONOTONIC, &t_start);
-	dest_addr = mremap(src_addr, c.region_size, c.region_size,
-					  MREMAP_MAYMOVE|MREMAP_FIXED, (char *) addr);
+	dest_addr = sys_mremap(src_addr, c.region_size, c.region_size,
+			       mremap_flags, (char *) addr);
 	clock_gettime(CLOCK_MONOTONIC, &t_end);
 
 	if (dest_addr == MAP_FAILED) {
@@ -549,6 +592,10 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
  * subsequent tests. So we clean up mappings after each test.
  */
 clean_up_dest:
+	/* Trigger reclaim to assert that adjusted rmap state is valid. */
+	if (c.use_relocate_anon)
+		madvise(dest_addr, c.region_size, MADV_PAGEOUT);
+
 	munmap(dest_addr, c.region_size);
 clean_up_dest_preamble:
 	if (c.dest_preamble_size && dest_preamble_addr)
@@ -565,16 +612,19 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
  * down address landed on a mapping that maybe does not exist.
  */
 static void mremap_move_1mb_from_start(unsigned int pattern_seed,
-				       char *rand_addr)
+				       char *rand_addr, char *test_suffix,
+				       int extra_flags)
 {
 	char *test_name = "mremap move 1mb from start at 1MB+256KB aligned src";
 	void *src = NULL, *dest = NULL;
 	unsigned int i, success = 1;
-
+	int mremap_flags = MREMAP_MAYMOVE | MREMAP_FIXED;
 	/* Config to reuse get_source_mapping() to do an aligned mmap. */
 	struct config c = {
 		.src_alignment = SIZE_MB(1) + SIZE_KB(256),
-		.region_size = SIZE_MB(6)
+		.region_size = SIZE_MB(6),
+		.use_relocate_anon = extra_flags & (MREMAP_RELOCATE_ANON |
+						    MREMAP_MUST_RELOCATE_ANON),
 	};
 
 	src = get_source_mapping(c);
@@ -583,6 +633,12 @@ static void mremap_move_1mb_from_start(unsigned int pattern_seed,
 		goto out;
 	}
 
+	/* See comment in mremap_move_within_range(). */
+	if (extra_flags & MREMAP_MUST_RELOCATE_ANON)
+		madvise(src, c.region_size, MADV_NOHUGEPAGE);
+
+	mremap_flags |= extra_flags;
+
 	c.src_alignment = SIZE_MB(1) + SIZE_KB(256);
 	dest = get_source_mapping(c);
 	if (!dest) {
@@ -599,8 +655,8 @@ static void mremap_move_1mb_from_start(unsigned int pattern_seed,
 	 */
 	munmap(dest, SIZE_MB(1));
 
-	void *new_ptr = mremap(src + SIZE_MB(1), SIZE_MB(1), SIZE_MB(1),
-						   MREMAP_MAYMOVE | MREMAP_FIXED, dest + SIZE_MB(1));
+	void *new_ptr = sys_mremap(src + SIZE_MB(1), SIZE_MB(1), SIZE_MB(1),
+				   mremap_flags, dest + SIZE_MB(1));
 	if (new_ptr == MAP_FAILED) {
 		perror("mremap");
 		success = 0;
@@ -629,9 +685,10 @@ static void mremap_move_1mb_from_start(unsigned int pattern_seed,
 		perror("munmap dest");
 
 	if (success)
-		ksft_test_result_pass("%s\n", test_name);
+		ksft_test_result_pass("%s%s\n", test_name, test_suffix);
+
 	else
-		ksft_test_result_fail("%s\n", test_name);
+		ksft_test_result_fail("%s%s\n", test_name, test_suffix);
 }
 
 static void run_mremap_test_case(struct test test_case, int *failures,
@@ -640,13 +697,17 @@ static void run_mremap_test_case(struct test test_case, int *failures,
 {
 	long long remap_time = remap_region(test_case.config, threshold_mb,
 					    rand_addr);
+	char *relocate_anon_suffix = " [MREMAP_MUST_RELOCATE_ANON]";
+	struct config *c = &test_case.config;
 
 	if (remap_time < 0) {
 		if (test_case.expect_failure)
-			ksft_test_result_xfail("%s\n\tExpected mremap failure\n",
-					      test_case.name);
+			ksft_test_result_xfail("%s%s\n\tExpected mremap failure\n",
+					       test_case.name,
+					       c->use_relocate_anon ? relocate_anon_suffix : "");
 		else {
-			ksft_test_result_fail("%s\n", test_case.name);
+			ksft_test_result_fail("%s%s\n", test_case.name,
+					      c->use_relocate_anon ? relocate_anon_suffix : "");
 			*failures += 1;
 		}
 	} else {
@@ -656,10 +717,13 @@ static void run_mremap_test_case(struct test test_case, int *failures,
 		 */
 		if (threshold_mb == VALIDATION_NO_THRESHOLD ||
 		    test_case.config.region_size <= threshold_mb * _1MB)
-			ksft_test_result_pass("%s\n\tmremap time: %12lldns\n",
-					      test_case.name, remap_time);
+			ksft_test_result_pass("%s%s\n\tmremap time: %12lldns\n",
+					      test_case.name,
+					      c->use_relocate_anon ? relocate_anon_suffix : "",
+					      remap_time);
 		else
-			ksft_test_result_pass("%s\n", test_case.name);
+			ksft_test_result_pass("%s%s\n", test_case.name,
+					      c->use_relocate_anon ? relocate_anon_suffix : "");
 	}
 }
 
@@ -703,8 +767,8 @@ static int parse_args(int argc, char **argv, unsigned int *threshold_mb,
 	return 0;
 }
 
-#define MAX_TEST 15
-#define MAX_PERF_TEST 3
+#define MAX_TEST 30
+#define MAX_PERF_TEST 6
 int main(int argc, char **argv)
 {
 	int failures = 0;
@@ -721,12 +785,15 @@ int main(int argc, char **argv)
 	char *rand_addr;
 	size_t rand_size;
 	int num_expand_tests = 2;
-	int num_misc_tests = 2;
+	int num_misc_tests = 6;
 	struct test test_cases[MAX_TEST] = {};
 	struct test perf_test_cases[MAX_PERF_TEST];
 	int page_size;
 	time_t t;
 	FILE *maps_fp;
+	bool use_relocate_anon = false;
+	struct test *test_case = test_cases;
+	struct test *perf_test_case = perf_test_cases;
 
 	pattern_seed = (unsigned int) time(&t);
 
@@ -763,66 +830,71 @@ int main(int argc, char **argv)
 
 	page_size = sysconf(_SC_PAGESIZE);
 
-	/* Expected mremap failures */
-	test_cases[0] =	MAKE_TEST(page_size, page_size, page_size,
-				  OVERLAPPING, EXPECT_FAILURE,
-				  "mremap - Source and Destination Regions Overlapping");
-
-	test_cases[1] = MAKE_TEST(page_size, page_size/4, page_size,
-				  NON_OVERLAPPING, EXPECT_FAILURE,
-				  "mremap - Destination Address Misaligned (1KB-aligned)");
-	test_cases[2] = MAKE_TEST(page_size/4, page_size, page_size,
-				  NON_OVERLAPPING, EXPECT_FAILURE,
-				  "mremap - Source Address Misaligned (1KB-aligned)");
-
-	/* Src addr PTE aligned */
-	test_cases[3] = MAKE_TEST(PTE, PTE, PTE * 2,
-				  NON_OVERLAPPING, EXPECT_SUCCESS,
-				  "8KB mremap - Source PTE-aligned, Destination PTE-aligned");
-
-	/* Src addr 1MB aligned */
-	test_cases[4] = MAKE_TEST(_1MB, PTE, _2MB, NON_OVERLAPPING, EXPECT_SUCCESS,
-				  "2MB mremap - Source 1MB-aligned, Destination PTE-aligned");
-	test_cases[5] = MAKE_TEST(_1MB, _1MB, _2MB, NON_OVERLAPPING, EXPECT_SUCCESS,
-				  "2MB mremap - Source 1MB-aligned, Destination 1MB-aligned");
-
-	/* Src addr PMD aligned */
-	test_cases[6] = MAKE_TEST(PMD, PTE, _4MB, NON_OVERLAPPING, EXPECT_SUCCESS,
-				  "4MB mremap - Source PMD-aligned, Destination PTE-aligned");
-	test_cases[7] =	MAKE_TEST(PMD, _1MB, _4MB, NON_OVERLAPPING, EXPECT_SUCCESS,
-				  "4MB mremap - Source PMD-aligned, Destination 1MB-aligned");
-	test_cases[8] = MAKE_TEST(PMD, PMD, _4MB, NON_OVERLAPPING, EXPECT_SUCCESS,
-				  "4MB mremap - Source PMD-aligned, Destination PMD-aligned");
-
-	/* Src addr PUD aligned */
-	test_cases[9] = MAKE_TEST(PUD, PTE, _2GB, NON_OVERLAPPING, EXPECT_SUCCESS,
-				  "2GB mremap - Source PUD-aligned, Destination PTE-aligned");
-	test_cases[10] = MAKE_TEST(PUD, _1MB, _2GB, NON_OVERLAPPING, EXPECT_SUCCESS,
-				   "2GB mremap - Source PUD-aligned, Destination 1MB-aligned");
-	test_cases[11] = MAKE_TEST(PUD, PMD, _2GB, NON_OVERLAPPING, EXPECT_SUCCESS,
-				   "2GB mremap - Source PUD-aligned, Destination PMD-aligned");
-	test_cases[12] = MAKE_TEST(PUD, PUD, _2GB, NON_OVERLAPPING, EXPECT_SUCCESS,
-				   "2GB mremap - Source PUD-aligned, Destination PUD-aligned");
-
-	/* Src and Dest addr 1MB aligned. 5MB mremap. */
-	test_cases[13] = MAKE_TEST(_1MB, _1MB, _5MB, NON_OVERLAPPING, EXPECT_SUCCESS,
-				  "5MB mremap - Source 1MB-aligned, Destination 1MB-aligned");
-
-	/* Src and Dest addr 1MB aligned. 5MB mremap. */
-	test_cases[14] = MAKE_TEST(_1MB, _1MB, _5MB, NON_OVERLAPPING, EXPECT_SUCCESS,
-				  "5MB mremap - Source 1MB-aligned, Dest 1MB-aligned with 40MB Preamble");
-	test_cases[14].config.dest_preamble_size = 10 * _4MB;
-
-	perf_test_cases[0] =  MAKE_TEST(page_size, page_size, _1GB, NON_OVERLAPPING, EXPECT_SUCCESS,
-					"1GB mremap - Source PTE-aligned, Destination PTE-aligned");
-	/*
-	 * mremap 1GB region - Page table level aligned time
-	 * comparison.
-	 */
-	perf_test_cases[1] = MAKE_TEST(PMD, PMD, _1GB, NON_OVERLAPPING, EXPECT_SUCCESS,
-				       "1GB mremap - Source PMD-aligned, Destination PMD-aligned");
-	perf_test_cases[2] = MAKE_TEST(PUD, PUD, _1GB, NON_OVERLAPPING, EXPECT_SUCCESS,
-				       "1GB mremap - Source PUD-aligned, Destination PUD-aligned");
+	do {
+		/* Expected mremap failures */
+		*test_case++ =	MAKE_TEST(page_size, page_size, page_size,
+					  OVERLAPPING, use_relocate_anon, EXPECT_FAILURE,
+					  "mremap - Source and Destination Regions Overlapping");
+
+		*test_case++ =	MAKE_TEST(page_size, page_size/4, page_size,
+					  NON_OVERLAPPING, use_relocate_anon, EXPECT_FAILURE,
+					  "mremap - Destination Address Misaligned (1KB-aligned)");
+		*test_case++ =	MAKE_TEST(page_size/4, page_size, page_size,
+					  NON_OVERLAPPING, use_relocate_anon, EXPECT_FAILURE,
+					  "mremap - Source Address Misaligned (1KB-aligned)");
+
+		/* Src addr PTE aligned */
+		*test_case++ =	MAKE_TEST(PTE, PTE, PTE * 2,
+					  NON_OVERLAPPING, use_relocate_anon, EXPECT_SUCCESS,
+					  "8KB mremap - Source PTE-aligned, Destination PTE-aligned");
+
+		/* Src addr 1MB aligned */
+		*test_case++ =	MAKE_TEST(_1MB, PTE, _2MB, NON_OVERLAPPING, use_relocate_anon, EXPECT_SUCCESS,
+					  "2MB mremap - Source 1MB-aligned, Destination PTE-aligned");
+		*test_case++ =	MAKE_TEST(_1MB, _1MB, _2MB, NON_OVERLAPPING, use_relocate_anon, EXPECT_SUCCESS,
+					  "2MB mremap - Source 1MB-aligned, Destination 1MB-aligned");
+
+		/* Src addr PMD aligned */
+		*test_case++ =	MAKE_TEST(PMD, PTE, _4MB, NON_OVERLAPPING, use_relocate_anon, EXPECT_SUCCESS,
+					  "4MB mremap - Source PMD-aligned, Destination PTE-aligned");
+		*test_case++ =	MAKE_TEST(PMD, _1MB, _4MB, NON_OVERLAPPING, use_relocate_anon, EXPECT_SUCCESS,
+					  "4MB mremap - Source PMD-aligned, Destination 1MB-aligned");
+		*test_case++ =	MAKE_TEST(PMD, PMD, _4MB, NON_OVERLAPPING, use_relocate_anon, EXPECT_SUCCESS,
+					  "4MB mremap - Source PMD-aligned, Destination PMD-aligned");
+
+		/* Src addr PUD aligned */
+		*test_case++ =	MAKE_TEST(PUD, PTE, _2GB, NON_OVERLAPPING, use_relocate_anon, EXPECT_SUCCESS,
+					  "2GB mremap - Source PUD-aligned, Destination PTE-aligned");
+		*test_case++ =	MAKE_TEST(PUD, _1MB, _2GB, NON_OVERLAPPING, use_relocate_anon, EXPECT_SUCCESS,
+					   "2GB mremap - Source PUD-aligned, Destination 1MB-aligned");
+		*test_case++ =	MAKE_TEST(PUD, PMD, _2GB, NON_OVERLAPPING, use_relocate_anon, EXPECT_SUCCESS,
+					   "2GB mremap - Source PUD-aligned, Destination PMD-aligned");
+		*test_case++ =	MAKE_TEST(PUD, PUD, _2GB, NON_OVERLAPPING, use_relocate_anon, EXPECT_SUCCESS,
+					   "2GB mremap - Source PUD-aligned, Destination PUD-aligned");
+
+		/* Src and Dest addr 1MB aligned. 5MB mremap. */
+		*test_case++ =	MAKE_TEST(_1MB, _1MB, _5MB, NON_OVERLAPPING, use_relocate_anon, EXPECT_SUCCESS,
+					   "5MB mremap - Source 1MB-aligned, Destination 1MB-aligned");
+
+		/* Src and Dest addr 1MB aligned. 5MB mremap. */
+		*test_case =	MAKE_TEST(_1MB, _1MB, _5MB, NON_OVERLAPPING, use_relocate_anon, EXPECT_SUCCESS,
+					   "5MB mremap - Source 1MB-aligned, Dest 1MB-aligned with 40MB Preamble");
+		test_case++->config.dest_preamble_size = 10 * _4MB;
+
+		*perf_test_case++ =	 MAKE_TEST(page_size, page_size, _1GB, NON_OVERLAPPING,
+						   use_relocate_anon, EXPECT_SUCCESS,
+						"1GB mremap - Source PTE-aligned, Destination PTE-aligned");
+		/*
+		 * mremap 1GB region - Page table level aligned time
+		 * comparison.
+		 */
+		*perf_test_case++ =	MAKE_TEST(PMD, PMD, _1GB, NON_OVERLAPPING, use_relocate_anon, EXPECT_SUCCESS,
+					       "1GB mremap - Source PMD-aligned, Destination PMD-aligned");
+		*perf_test_case++ =	MAKE_TEST(PUD, PUD, _1GB, NON_OVERLAPPING, use_relocate_anon, EXPECT_SUCCESS,
+					       "1GB mremap - Source PUD-aligned, Destination PUD-aligned");
+
+		use_relocate_anon = !use_relocate_anon;
+	} while (use_relocate_anon);
 
 	run_perf_tests =  (threshold_mb == VALIDATION_NO_THRESHOLD) ||
 				(threshold_mb * _1MB >= _1GB);
@@ -846,8 +918,18 @@ int main(int argc, char **argv)
 
 	fclose(maps_fp);
 
-	mremap_move_within_range(pattern_seed, rand_addr);
-	mremap_move_1mb_from_start(pattern_seed, rand_addr);
+	mremap_move_within_range(pattern_seed, rand_addr,
+				 "", 0);
+	mremap_move_within_range(pattern_seed, rand_addr,
+				 "[MREMAP_RELOCATE_ANON]", MREMAP_RELOCATE_ANON);
+	mremap_move_within_range(pattern_seed, rand_addr,
+				 "[MREMAP_MUST_RELOCATE_ANON]", MREMAP_MUST_RELOCATE_ANON);
+	mremap_move_1mb_from_start(pattern_seed, rand_addr,
+				   "", 0);
+	mremap_move_1mb_from_start(pattern_seed, rand_addr,
+				   "[MREMAP_RELOCATE_ANON]", MREMAP_RELOCATE_ANON);
+	mremap_move_1mb_from_start(pattern_seed, rand_addr,
+				   "[MREMAP_MUST_RELOCATE_ANON]", MREMAP_MUST_RELOCATE_ANON);
 
 	if (run_perf_tests) {
 		ksft_print_msg("\n%s\n",
-- 
2.48.1


