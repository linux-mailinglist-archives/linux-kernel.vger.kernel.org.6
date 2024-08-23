Return-Path: <linux-kernel+bounces-299601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5266395D761
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E641F258AD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F4E195FEA;
	Fri, 23 Aug 2024 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qd4sBxLi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fxTyG3pn"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E861957E7
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 20:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443667; cv=fail; b=Hw5XxYu+isOcO8AQvXCryN0HZFDhyEw7zoNEoezKIZ0oqHfRU0zGzqwktzAjcqoWJ7AjJIIg5ryUsXDcor0YIQd74nB9Ss8/hxQXF0qzevZmOXtzKw8bSagkk2FZrMLtk8xnNcxe2Kvf6O2zyK3q2xjRH/xCz5IcAD5purtEtDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443667; c=relaxed/simple;
	bh=iWTqhHVYricBBLbTvocf3jXftd18z/pPtxeOABeWM0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i+lHhSzwDyTmV3sIg62TF58aUyU5BoxvqvFu7kaxoi50VCCowDF93f9EbeF7Vnw6XlRbs1/d+jDgpoJfS/cTZjfTKuGBAA0ixJ9w7kcD7XRY/4dMcr3doedKTZUQmDtUWssG6zFdQ8Tg0mTHzUR3BjpbC6amjpuVfRQ/XFvy61E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qd4sBxLi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fxTyG3pn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NH0Uvk028392;
	Fri, 23 Aug 2024 20:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=GqWVfQYfbej3Jam2dL9UX9I4S8UA+aoiCAwVhcWe/jw=; b=
	Qd4sBxLiDu6jPS7Cr1sb1OPHvS+FmxNndyNXkmcl2emL6y9dgPAkYpV5evvGUxos
	gEbLclA+PhBwD17cVvfCON1oHbuQPZl1gwXgCRQ8YBP4+TTY7RiVMnHkxl/KK9xV
	ucZ58e1UC0vFtiOuklXiTZzwEZG2kFi85xj0gXhh93N7sq0kU0EQib16XWICXgQk
	+TXw61MDk+ZcBEHkcWClTTF8o0B7c1+ZjXXuPiVgfoD65Age5ZhScnqqlFnUTYcW
	5THWLFDyStwIY4mTnrygdTS+ad3LSyiKD/Au6Yk6bumjWOTtcKkQ0tsOTDD5Ltb1
	BlnZB2TCddQ24KCxb7QJVg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m2dn8yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:07:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NJdCpY007466;
	Fri, 23 Aug 2024 20:07:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4170s5gxw2-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:07:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ronr7znJQYGFIArD/lXEZnWM9hJPdVEGZhT0z2RARfl1LYYdkadhScERF9jww9CBWzA95yExpfL4On0gLNdO51c9y74jIekbFr/1wgT+1rI7F5V87BzwE7J89Sf1v+N4tSmgOiVUsSHNevT2HFd/oIWkx6r0uJncrxRzrsu/Vb6I2vlGmwP3iFkA3LhjORQf0QoaW94sffCgZNoETOVkSPVk8K4eAfLva5H6iBbReIVrC2UxVAE4XA+0+PdT3ukCtCttOzZJsrNhKcHt1aFNs9gvDvFoGii5y3cgdFyei0PKkGDvQmMqlAg8PH3nps0lEpTvh+L4vgBf1tvJzbJ6FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqWVfQYfbej3Jam2dL9UX9I4S8UA+aoiCAwVhcWe/jw=;
 b=DARdRiO6F8yjRdYoeKVefPoCYXI7mFrdVplvMYnqdACeXPyNcQtt5KTaLPfzbrqJkupJ9/lgJt+keBemht5WCQrfmptFM9FsjxCv5BUZXJf8iqab5gAlm3WSCIDRXS1t11P8S19DKSmGuY4YGDuHRrn0gqLXawmsdZmt835asHdyAtnS+qgQQDJUcSlShqNLaSdDkU/4CObrNi5wEV5SY2xXYdOiKdxVzxRH2UdJ7iHLUgb0xYlGF7FrgLqaunnriDncyoGfdokU/+j/3Nqo29Rf+GI/+PXhWbfs8dOmKc4uughXGmN8RvRNVYJL01vLBpIlk5KriTlQXPr/2gq5rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqWVfQYfbej3Jam2dL9UX9I4S8UA+aoiCAwVhcWe/jw=;
 b=fxTyG3pn7i2sxxMQKw1rHk68AcE7zmKHHlV6JxQVIxZWB7Og+eS1a1XSRJbSvxA3Zz0FDumf8joHCokmhtfrkoVRVV+CFb9tZyXoTNO/CfucJSTogC3ADJ6FJRi5BpP4VhZjGw2VTe1qQ6BwyMC710j+q7NdC2sHCDXSpUgjL8c=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BL3PR10MB6187.namprd10.prod.outlook.com (2603:10b6:208:3be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Fri, 23 Aug
 2024 20:07:31 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 20:07:31 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 08/10] mm: introduce commit_merge(), abstracting final commit of merge
Date: Fri, 23 Aug 2024 21:07:03 +0100
Message-ID: <1574f1e878da4dc2f23be611f318c4f5eb82ef01.1724441678.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0065.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BL3PR10MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c6f6306-11e5-4038-9d6b-08dcc3af3854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iT3r6nft2Mi2mqx/3/x0sEfTW3o86z86j1CH27j1pXw4N9WLV2S5xui6GeOJ?=
 =?us-ascii?Q?G/uabZGtq/f2xCxNT0IBS+bS7KuM95VAX8ypgFTRhM57yRtoo4im6w02qCFl?=
 =?us-ascii?Q?ssqgCTgpwQ0cGUjnITJT7U1GlzaFHP7vDPFY/NTBCQs6tlPsB2BljFqxoFLV?=
 =?us-ascii?Q?F1a8UAKU5Mw6K1OJygHpHy4PbbwfkW0wDVcRKICA4flnJlHlUeet3LIAxxDT?=
 =?us-ascii?Q?8x7tDf1MthJMmHq826OwNSkSIWr16HkviAcWmPZ9xRtpI7kut+I/N1w6Sl+h?=
 =?us-ascii?Q?qMJGAHmfE1EysEt0/QM8ENyd9j5EEtQ7ClRy3QZSQfayhutB+oyaodbUc0M4?=
 =?us-ascii?Q?YY3qrSJlUNji/koKmH+UBG6Hb8FiY03FSG/WuOwnRWOgF9geXSZUrZhE8lT3?=
 =?us-ascii?Q?w3WMzGTl6Asy0DAFbRVWsZLNATV3nTba+x5WBaXTxFgHjDS+grPg58nzlnPO?=
 =?us-ascii?Q?v0dcKK7H6ngvRSyUfJWo8XlH5Y7K+y2XgCD4QCfZC9ZnRB7BoriyGpF5lWYD?=
 =?us-ascii?Q?Vmt9WF9tBs7FLkhRDXolYeGoS/JCO8XW5vjBofu76a3hlTi+x7PYmYY1fWFn?=
 =?us-ascii?Q?iHeKjvyOT/xeCp2Z3AJNWc02kJjUw6wG+QAK7FS/zoCAYSuRpLSmKAxCsGAc?=
 =?us-ascii?Q?liT51mB5CSnc9juCTnkolgt5QSDnf9uMuqas+Din+nEympmF1S8Wuq7AFduq?=
 =?us-ascii?Q?zJnuyy/3WFFF3ygSh3w6FZ/vyFBMu9jDaG41MoFXw3e5XghgKWS6R5Xv0aJw?=
 =?us-ascii?Q?k2s/xoi4V9O4PhSV/WM2JedciHdM033SseoiaH1Y9mkq2v+FaXkt4SvEDBP3?=
 =?us-ascii?Q?AOOwnVxqn9WGT7C+JuKRrbP3/Udo07tpUCDIAVGpzHZ2IXTi0BQneyGPVLpG?=
 =?us-ascii?Q?3GdCTvTXYD12NBcgclQNb7XPqKARtH4RuR+iYQuzzIo9ZnHM5OSY6NNsFBsx?=
 =?us-ascii?Q?2SUhWjoYMK+y3oBujRtBHZVJwmaIywJeJp3+uaPjBeZrOAKaBwkIN4fAAxqC?=
 =?us-ascii?Q?0uInuQ/BnbTgwMoYY0RnB5N9qvYkJusJynYQT0jVTx7dvzJMPl12/pcWvozo?=
 =?us-ascii?Q?i8t++6AZMnZvda/fH906Fmc4X0rh5NcKhAQJInkJa3b2j2I+Xc7ql9vav4Uv?=
 =?us-ascii?Q?mIgdYCMibZNEx314UPfG3bFev+Bh2lT/iK0RoLfl6PYh/I0kymy5GtWhY8kr?=
 =?us-ascii?Q?FgsDI+iFZHdf/LGvZvlwTAUmY5Jo+KHJRZAT/iwXBu00AfN7uHjfJGjMv2W7?=
 =?us-ascii?Q?0tZTVNSO1thMKc5h8sPyfu0b4bMyeIBwpI+fAX+Pkw1JJ6CwDxE8qLB38k6Q?=
 =?us-ascii?Q?Q4RgcR1XGF8GvH7t9n1oNZVMKnkdyMyKoXxJ2fLHO3cpVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VsNKW+BvUHMfb8uP1D8HAhCrUqacBezyI7Jo+mm8UhUIZ+Wzp17MGra+6HKd?=
 =?us-ascii?Q?lzCYp5KfUOQyzS5LUvSt7a7BnVN+kusFT+Mh4KO/Se+7woRfYRjhUozRDa+i?=
 =?us-ascii?Q?qXEC7cFGyczmTSrqg3ThUfHyuh8oVPmSotAcWtxGUd4at0MPYQj1bu4+h8rx?=
 =?us-ascii?Q?uUdW1CVZwnDwH38gdWypNvnKgbWnSyWZ0IGRs+bghrNA7lJHbshV46XjCz8J?=
 =?us-ascii?Q?4jrinwhZldKw4HYiaSipGoKJzD9qm91aJIqKc4jl5tPCusZFSH3m6W7/5iB5?=
 =?us-ascii?Q?tsXL4iEc3E4mAVk5S/RL151hhtWMUguHHD50UbDGuaJtDN/Bc3VEdKNSY56J?=
 =?us-ascii?Q?/noZ7QmfZ358RowNnsK72BiLHafdAwvDIKNRfkt4vyyg5g6f0nsvAZtBVcyA?=
 =?us-ascii?Q?b7OmAQhFPXZ48QULUmsYynSwwHusSVRbj+CZlDlS/OWWcJRCQxCYsnbkkI6m?=
 =?us-ascii?Q?kPX8vGH3Xzbhtanjp9Iu++x1BHAx4694dfTBZjBi6CwViWRN+3vqq1Osbn5Y?=
 =?us-ascii?Q?iJpdCtuWvUCxTq0Fyos/1gNv8zcbZ2/jJcWotaBeYpPeBpvWLWNq35UzKPGN?=
 =?us-ascii?Q?OxRjpRO/BrbNgyQBrKgT7MxteztI6XWaF1eqxKdUtDVSTFSc8B57PIVFOU0v?=
 =?us-ascii?Q?Rzx6wa3nmSWKfYSeqGtaIIkcN4B9Isn4IYBwrWIhWpgVt5+tNEZcnFjALxLG?=
 =?us-ascii?Q?e60gCGQxnU0JXbT5lE8j6ty7W3q8cFr9JUi6x233hN1JIteRzO04SmS5srmw?=
 =?us-ascii?Q?UJtPLzQm1AifA6DKOTBLqKfFa8ghblaiH8tRE/RtvvKyjR+MJODRRbiHJZ2I?=
 =?us-ascii?Q?E2lRZVNBOaM/iSoJNcf5OOB5BWJu+LyFW0N43auSDErVwiplkF9Gd+EgSQDg?=
 =?us-ascii?Q?9NpsV4F9UEOugPdW79PFnlY7IatIqRl1+XDURpcai2vIDqnx50nyBJiokgNY?=
 =?us-ascii?Q?Uyfem0SsFU98Sb6JbWn3LyEZKRMN8x/Vk47IMOdEAYqntS46rTLcXoNiA/h7?=
 =?us-ascii?Q?yY6jYolJxrpT74a6E9nxOOvaDDVmvPmQ04k4JyHS+BuTOkyhCG66jYKisg0G?=
 =?us-ascii?Q?zIJa79AsCrvnSew/OIxvlarDIAQUm9OU7r0hh/IZqGojC+rvfgR/7NvRfXwE?=
 =?us-ascii?Q?8LaFo+5rZGegqj4p0XItkEcrjQfjDA76YS8DkLdk/3q/3VUREvXYBZ5J4NKY?=
 =?us-ascii?Q?0jYl+Fw7qqAYhg+un22Qyh7sruKy8i6TjixidDhcZhL3PSiGym4S/UDRfs2g?=
 =?us-ascii?Q?6BiuFIi9pXsFDEdpI989mDo9nQ5pdcZDpezyVBXmYYGRYBAWCmAZMG9XyMp9?=
 =?us-ascii?Q?3GmUMuQmPfKxxHNA5BvCV4x8nEVa6whTFlOIvVSmtwfiT3MCsokkr+wfwu8Y?=
 =?us-ascii?Q?0p7fyY/9MEW/cZbV6d9xSDdk7XLZOrD7XTBqmU/Mj3DkUkeVLtn1UwmiqsqT?=
 =?us-ascii?Q?ry+/fLIpfOLHviTwXSvy/yHM1PZv61+wrEfms2uE8z0UykT1Ymgs0FTQeIMK?=
 =?us-ascii?Q?rdCfI0BE23CE3ZddRQ+nrZ0J/hnsrZmbAWYPIwouQPJNN3N/fS4uU6lCW2Ei?=
 =?us-ascii?Q?NBz/rFCAl667MOI5/Tb7ZUl8+8TGtVAMglkW7cHWXGmZ+M/6DKv2/U3FhfDt?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Am3OaSbMjcxX/1ddSKmmfnKUCHCzpGutbI+EfcjgT0GYOK4kDV/gQMZXbPIX5xj5u5zmQLomFRxZLoN9yX11MAQ4EgNCaRPXRfpUpIXRtquI6qcASidSoc+icW3evKpFShvHF8uucPzijNNe2cz1BMh3GstMeJe/sc2sWOYzTOeOQ/rNLgG1qQVQ7+TxL9h+ESjaqB2x75dbuYOkiQgjj7gJnFILHwHLqG+taSvfv0HPT4K1IVTSGEoS/K8y8u3o+BPPNezF+32HJg64t+ETF7tFwq7Y/BYuuJmnNq2lInhDi6ikpAX0lBs1Heoq7Ye0g3pO1DYmsn/Yq7oaxrQMCYG3CZO2jZHUgdJPphBqmwNL+AXDB6wwdxOQWqw5PJ62QaGJC1OTz1YKLC0bOlCy6YvlUFBabNpfv1VUk7jhILYMeCI090cENfO4tTRcubbnfxH7+UA9y7IoeauDFZHLqzyJhvTj8ONGOsKjD8NzYljJPZVUVGYFXroxqDP25lBZ2l6nI8xwcNyPgk2bSC7o3d6Cwpp17KKBhhXE1rIZIa0Sd9eM/FV37oREQehopbHijHi1p/MDlR2F7bFs7TbdT0DJrRzWqfvFxwpVirwZgJM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6f6306-11e5-4038-9d6b-08dcc3af3854
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:07:31.2415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khkVzmAFles6akgoRVTD+x3itjYYHMDKLmGGpoShtlEwtHT/OcJlOHXuhOPtCsM2uJzJ3dMFtLy80Vic+54QWhTLYQasUChetTQSRVppQBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_16,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408230148
X-Proofpoint-GUID: KEiFXoQzgtWJ11dP8LGvbfOqES83DRL3
X-Proofpoint-ORIG-GUID: KEiFXoQzgtWJ11dP8LGvbfOqES83DRL3

Pull the part of vma_expand() which actually commits the merge operation,
that is inserts it into the maple tree and sets the VMA's vma->vm_start and
vma->vm_end parameters, into its own function.

We implement only the parts needed for vma_expand() which now as a result
of previous work is also the means by which new VMA ranges are merged.

The next commit in the series will implement merging of existing ranges
which will extend commit_merge() to accommodate this case and result in all
merges using this common code.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 07df0d5fb3d2..8d670059e728 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -540,6 +540,31 @@ void validate_mm(struct mm_struct *mm)
 }
 #endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
 
+/* Actually perform the VMA merge operation. */
+static int commit_merge(struct vma_merge_struct *vmg,
+			struct vm_area_struct *remove)
+{
+	struct vma_prepare vp;
+
+	init_multi_vma_prep(&vp, vmg->vma, NULL, remove, NULL);
+
+	/* Note: vma iterator must be pointing to 'start'. */
+	vma_iter_config(vmg->vmi, vmg->start, vmg->end);
+
+	if (vma_iter_prealloc(vmg->vmi, vmg->vma))
+		return -ENOMEM;
+
+	vma_prepare(&vp);
+	vma_adjust_trans_huge(vmg->vma, vmg->start, vmg->end, 0);
+	vma_set_range(vmg->vma, vmg->start, vmg->end, vmg->pgoff);
+
+	vma_iter_store(vmg->vmi, vmg->vma);
+
+	vma_complete(&vp, vmg->vmi, vmg->vma->vm_mm);
+
+	return 0;
+}
+
 /*
  * vma_merge_new_range - Attempt to merge a new VMA into address space
  *
@@ -672,7 +697,6 @@ int vma_expand(struct vma_merge_struct *vmg)
 	bool remove_next = false;
 	struct vm_area_struct *vma = vmg->vma;
 	struct vm_area_struct *next = vmg->next;
-	struct vma_prepare vp;
 
 	mmap_assert_write_locked(vmg->mm);
 
@@ -687,24 +711,15 @@ int vma_expand(struct vma_merge_struct *vmg)
 			return ret;
 	}
 
-	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
 	/* Not merging but overwriting any part of next is not handled. */
-	VM_WARN_ON(next && !vp.remove &&
+	VM_WARN_ON(next && !remove_next &&
 		  next != vma && vmg->end > next->vm_start);
 	/* Only handles expanding */
 	VM_WARN_ON(vma->vm_start < vmg->start || vma->vm_end > vmg->end);
 
-	/* Note: vma iterator must be pointing to 'start' */
-	vma_iter_config(vmg->vmi, vmg->start, vmg->end);
-	if (vma_iter_prealloc(vmg->vmi, vma))
+	if (commit_merge(vmg, remove_next ? next : NULL))
 		goto nomem;
 
-	vma_prepare(&vp);
-	vma_adjust_trans_huge(vma, vmg->start, vmg->end, 0);
-	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
-	vma_iter_store(vmg->vmi, vma);
-
-	vma_complete(&vp, vmg->vmi, vma->vm_mm);
 	return 0;
 
 nomem:
-- 
2.46.0


