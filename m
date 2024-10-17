Return-Path: <linux-kernel+bounces-369971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6759A2514
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32FCCB26AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC171DED75;
	Thu, 17 Oct 2024 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WhiK6IpH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SDYGDIHs"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7677C1DE2DA
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175531; cv=fail; b=Bo8Bg3LbDzdRsNVZNGT3BSQrqpivSy+nK3w7ZVlLGzDsyChP9u58eNV4VVSWcMks5CgVdmVBRUsECeX5Q3UBoa1xiRsJtj2bf9ciNccnxl+yCKRKtW7/vbDe89opVsh0/F1I8zmn94TOCIF7vCxvVTsmGcbU678wUcBnZRI/+V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175531; c=relaxed/simple;
	bh=5Vl/3Pe/WM0/Su0/0zotAZg6rkmIhyIsDaJXaZNTV1M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JxNLMQWY9aELybLZj+tof/ODpaN/P6ZfQycuBUvp0OQ8HUpW7zbkn3xlPU4OTY7mBbrQlXC+BVUWC/V+vmQhebEcHy02lsFUXmLVonoRrXPNXG+8sEHzjmhCmsygZRmkyF3RIz8kpJe46oW7RFu+fbMDlBbfo/myLcvOkan/U20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WhiK6IpH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SDYGDIHs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HEBgIk006099;
	Thu, 17 Oct 2024 14:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=NPDPeb3MQChUhN/w
	QYNsqmGkW4njfmUu1kC87EDQu4A=; b=WhiK6IpH9mf/89YDcmA3Q2n3ol+FXdEY
	gInqkTWtUcmgfVYyHeKqXSZsWcecMnFo/gqUcQqReChO0YcEOp5UPIclUKDNqdLV
	BtA2UDPQ+lCmU69PHlS0LcZQSvFRkcjtZlfbo6840AeIEjJPPBQ/25v7A1X6345T
	Wx9QVVSFNlkPo1lx/lqtauZYRmvi6vwvKRvjwz16V2fpHUS0Y37beJHEagvj1Han
	8woGp6sVAXu+FUIj2hJsQyFB27hGFD9kjRZS4jrY1hvfLe8+lw1QKY3kP76z24GR
	R8BwliBss3m/HiWJ/jxiuHo6TqqJT0cia7g9w6DxH9kvBDaFsHP7Yw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hntek9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 14:31:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HD7B1e019986;
	Thu, 17 Oct 2024 14:31:56 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjaag0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 14:31:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkFhkEtZ8y14i/rP6g7ODSlZj3xlO1VY6II8jZCIh1vUYixfNGIAMRNHR4JbHUlqiMEgQSgq2rBsEL0qoAdC17aQk1Ez3zUYpguGgxCcfHt16XQX7nHXFD4gOUldv3sI2hOGTtwGx6aeM6zKIUhox3/t2I3JC8INTLjBWb1qyFlBylNaHxtXpp2swheo6UoBnUFOHN/oYp827QdNqE10oRk6FzUkqZvdCWDC0H/qvAXAIIecjh1tQAxz6/iHIHHeH3ah+ug+nv1bBdKV+iwsnsnHV9ONtyJ0y3Zyaqc8dGYsiRngME4VjCfDUgG1eduBTdlDFCOQ8b0wzO2r4DVZxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPDPeb3MQChUhN/wQYNsqmGkW4njfmUu1kC87EDQu4A=;
 b=iiTxObmY/cMdS8tSI8Js3HxdvMUqOnw8uSpMiCBRrgpRjE2HwUeLA9Zs+ad0C60sSKPLOo3RdSIIbm2QkRBWbjgECR5Y+t92qYAh2/OwSPGmO02C7qiQ+5NoM+5baHwh9VFqsJevaQuhtFsh8bWArGArd1iCIj73vqA2e39LJnrY66Ig5UFpyhd9pXOKFKCVBG5e/gdutrEcYelo0RXR34LbX083D05LUBIBSpLitSeuM704D0GsQ/vRNa0bZVBJ16urNQxJ3ybF5xLHozshPtCcuQQ2GOGIsHG7ma2GN4I3tTGmXxXiGkrlhiT+Ffmh/ooNAScrt8AoHYmXMQWa7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPDPeb3MQChUhN/wQYNsqmGkW4njfmUu1kC87EDQu4A=;
 b=SDYGDIHsMlFo4RN3q87LdRGuc5TIQVs8RyFS0GPJQneFh1Fow+PYjv/9y+irLt4xdr9iAwRTEom2SOIeJ/VFlxFt5tPk8Iet1DUERspZVjrWRgYkMJLylo0+067E12TS22JvgpojsAzedW57G5FO9I7UqvnYY9zypOQ6DxADuzo=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH7PR10MB7056.namprd10.prod.outlook.com (2603:10b6:510:275::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 14:31:51 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 14:31:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oliver Sang <oliver.sang@intel.com>
Subject: [PATCH hotfix 6.12 0/2] introduce VMA merge mode to improve brk() performance
Date: Thu, 17 Oct 2024 15:31:44 +0100
Message-ID: <cover.1729174352.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0158.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH7PR10MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: dabe83d0-64f7-43ce-2d5a-08dceeb870ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AXLflbXGqF7/Nucfnoy20oIfuTt9/4lOB1BeW1NueE4N+qbboHHIT+zKkby7?=
 =?us-ascii?Q?0wuI75oZsVnSZUtW3XSKAImrtXRrEoLMnluWepDctxoWZ9V/ScoruHsIsbdA?=
 =?us-ascii?Q?WeiD1eYcWQE6KWSuKeDg89k+2IJYDWG95wjKAMKnVYyA4wGuXKSAGXMMvrhp?=
 =?us-ascii?Q?rogZ0rBwcOMeFHD1pv6b09cZbj2k+wWJ72uu89OzRSq01PZuFNUQTj+uujAX?=
 =?us-ascii?Q?jrHe4poP/fK8GbEDSFgT1Ujgymwt2Es4+UQ5N3Tvqn3d7ZCOC0vlLAbDxogk?=
 =?us-ascii?Q?E3r5lzazfvQqj4BBHHlvcMG2Ntppcgl1DKVfYEbbGjhYo51P1t0wUmveBcdY?=
 =?us-ascii?Q?mHu/QE0Ic38kElqlnO3fHXYNQVaCjcSeZPYbK/5k1bfleTyxV1Ht9HKgmh14?=
 =?us-ascii?Q?QDELLqthhqqSU0RpAM+0JVaFEbQYdhFsCqWeDEQyckzMzDsRfsmmdQbMA+ik?=
 =?us-ascii?Q?tl3wPS9rl0HjeQX74QC3+T1JaCzmLPRIsdZYXRYDOu8Xmqm/EjoKgmD8o7jD?=
 =?us-ascii?Q?c0jhS/aK01bUZSFcYsLgxBOx9ZfNVBOEBDI61LfZgwcKvwjdd7sNuG2vKp+m?=
 =?us-ascii?Q?E3FHHRYrUN8KaAoP4HiNSwtz8aUgzFepCNiihyOPAnlXAhB6WsPqA9WAVGXb?=
 =?us-ascii?Q?arq8cUks1mcJNZeE0hNnqFdR7V4519Yp7nkacrELdqi8gr4ASK56o+gSmqSy?=
 =?us-ascii?Q?7G7PAD8ib77gD/fa/k26hsL1vIkDanzWjgmTXuDv0NSRsvUk8Q+TDuHeLWwg?=
 =?us-ascii?Q?4MS0JQpHh9eLPGTUGxIk3w/jsfChibdMfD0nHhPu0s/Zf/NA3LX3M0zZk/ep?=
 =?us-ascii?Q?t3GRKhpl9KeAm8TfDBQdxfDNkSqmRy3OKB0IiVWQl+JMDoo5JKv1Cjpd1dBZ?=
 =?us-ascii?Q?34jD2duw1dfHrOHDF6jhm4fPWT3e+0DLZx0nYshQ7NT7mY21/c2Z9wfXUuDO?=
 =?us-ascii?Q?d0jP/IbTnQrtNISmQpRiDN3Igu7BWug9CJEwE10iNYgCjlA4FYyDMecksfVo?=
 =?us-ascii?Q?E43KRpTu90P73HcKvvGQ+WOBy0U5Rfqg1KgcvaG4MHA+rT8RdBZvyBKA48y9?=
 =?us-ascii?Q?t9b7jMhsbPtVDKif1ozv/h+laFTSOX9I4FdI0ZsfEgNJGt+njXQHBdQM0RF4?=
 =?us-ascii?Q?WMs2PZ/Y9R2hXCEJ6WtJ9ywkk4UnbiLUwQJ1U8BtKHmz7s2ndih0kcZN1UMQ?=
 =?us-ascii?Q?lDr/2Wt1IwZm6SUJkd6Q7+pMVPVz1F0yeeAJcLgbttPnAff3LRwodR0YM1WW?=
 =?us-ascii?Q?AhC9HztaroJYvx6JPxnI65ccAHPIRusuq4iUV/87/ZZUqqs8P5TzMmEOs3C3?=
 =?us-ascii?Q?V3MolGaw6fOntY7V30mV0kkA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S558ulAUFPrrTlABzJV23PxtlkInMvEl0uWlprIBJ0zq3LrptYQ375vieEsV?=
 =?us-ascii?Q?EUTFTIG2F+nI2oRaDmhUxqgx8+Kr4sB/+Gu6wwQFMtPMt7TzOB3vnkvvg1I/?=
 =?us-ascii?Q?uYEIXhfxLtaw7hXIhrfsVCkjTI9zbNb5gacg568EigWdHzqR4qYOKLi3vHYg?=
 =?us-ascii?Q?w5gvqOXmAHpvaSErsXVjRaaoBa/B/eMt1LLLfBMQvYXeM6dWR9Fs//ehzjxy?=
 =?us-ascii?Q?RVMTMbpo4KVlg1OZx8Qx8sCh6iR1Oqf/yZaOJ3J9cyDATaPqcyHmmEIF5XHT?=
 =?us-ascii?Q?su6LzjvSL2eQHXpBJ7jVesBPgPKvvxdlWJ+mQsEkuOkpE4x2uF3sQOgIiTtg?=
 =?us-ascii?Q?GgdxKIVObSolNkm/HmNN5ee/m0FjOPTvYr/BqGClxInCEpERlZu2nW54Y5cY?=
 =?us-ascii?Q?AZshEfCXFP4nXO5COTAoHI6NREbDupS7Bu/agbpnt7vncFXcWmBYrRiiHhB8?=
 =?us-ascii?Q?uM7GENu7MW6f9OLTRf9KDaRRZMOCKdmQwPzSEWQ0Y6zHPHAuyVKqixnPdG6T?=
 =?us-ascii?Q?nwoRUr3Od4xsjcTfC4Zj14UtmSUlMQckERuc8U06lMNthnRttx5bEBku1Dbz?=
 =?us-ascii?Q?84DUon+pnbm4bMzsJ1TQs4W9agOVqdqaK8bvT7Stmrw/GTM7WlH6v/E0YCOt?=
 =?us-ascii?Q?LGkqsmc3PKzAC6YcC1068X9CDRrrQ1k6sGEpKvSkDCOaReu9x09aiJSC6yfw?=
 =?us-ascii?Q?qlp2qIbdO5v8NDwPraUhXyPyKOtIxgGfHQXqNgsdTWBnXibWXSsFfeQscycP?=
 =?us-ascii?Q?WP6XhXk27E7HdXxSXJ43F6Z27AUPX/BihW0t9AA5JxKLxh1HifIP/swZxYva?=
 =?us-ascii?Q?zrmBC8XLXA7O27FDpJhbtmoj4wNPrwij/4wuZxGjFqpF7j98B6iK0z90QGYT?=
 =?us-ascii?Q?4Br7B1ril1ffa32V95EaLHWFjEudTz7N1v2jVVDLGXZFxnc7l1qJse57QNua?=
 =?us-ascii?Q?GIGDEzX+ufguFyHmC1YMQbA+famUv5gzgo6GsrXrMS8QKbuR04x/tk7BrmU3?=
 =?us-ascii?Q?s0D7V4dVnkEBSjbW1CjFKP6YqlLOeqzArBhLzbzPzJirIHk9JX6suqaR3MVA?=
 =?us-ascii?Q?MjTtILASRq7qBLqyPnthhb6sClfwbWdQA74XilvkFAqvzkZTEyj1X431M75F?=
 =?us-ascii?Q?x521GhdJcXM2dyUxhvGZEGuysJ9/bzsYMqDWPR6E42NUorRw5s5HQruDp3Zg?=
 =?us-ascii?Q?5Lehf56vZ4XA93p/dhXp/AjRIFjEeRvYMs39gCu26b9QepcnO6mRzmkPZduC?=
 =?us-ascii?Q?Ff41krnRHrFp0gNCj3mId7TOix/dZ14faaJrHN5Ri8iMvrCTruPUM9UaFec4?=
 =?us-ascii?Q?9mxrL9EXNzTdwWZ6hWO8k4I5+9u3pbkv/YpdUTwuVl1IJ52Gna5i5K2oxrHh?=
 =?us-ascii?Q?KX48oOyddEv5h+BF5kJdUwlOuxvjdkqgry9iCflAjNlrwOdZKMVatTpEPLh1?=
 =?us-ascii?Q?TiHW2iIyByIJd0C5Ci+jmIImN+ryQLULGwy4SKHSKyjzkmdeGjJDb8pgVE4d?=
 =?us-ascii?Q?GMQbtH4jVdNd7UcQ5Z7wwHMUr38UCOTSEaUWwNaHwk4tYDE7oFnbRJ+LCi1f?=
 =?us-ascii?Q?8S2R4BVgnDSNqscpmStk9ydW8+mozyKFqIrzIaowhjaZcyN857579a+cN31t?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YqESrLvSQCLOWr17yPwLQsr+kuoqK8sFYtHI7Ly47qn5TN15ofDfB9nHwoqZAYyUyHlqJa7rur9Oo56FEs6RVdND0EHURXbelNjXQIUMxW89uHLLndySyWqusfOknHuSMKR3LkXprBS4fO6rseTvTkTJtLPhhKE172ldPNUaqAR3mpHlx5n/HFAtD4VlkE23mx1ALzq7pD3TFLc8KrG82d2C1CzXOxPfufAedBReYrV+ak69yolm4qU0mhnlImGmu2YAr2ZRlcjPcwZq/HjwkRncNb1htlI/Bkl8G3NYEI7ev8i7BF8qNfLLL4JFJ24sYX+TT4OcZxiz2ASNVDAzYToib1EHrFlrHHdY21xt79zeCB1GcP63laIIAIrdiYosP73J8678QeFOmLX9B1PkZgvr1gn47fxmI7Pdu48pdmhLJa/glMRkuCsWqIACtHgf78owSRkH3KhlSQ3F0ILh3zyhsnOsfF6kzDFBE/9lrjEEFIeLH4RDKn8NOYT9/tpWLGTDvz4lHLdVR6grFAc1LnGQt9JxXz7bhBURuYplR9ibm9i5VawKnjEBscAK70JueMa2WUFzvOLT0Z7kefu8zklMLtcK3JKOaQ4WA9xFA8w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dabe83d0-64f7-43ce-2d5a-08dceeb870ad
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 14:31:51.2578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMhqaZtosXv4yJqckyZ0/VzO7HFKmBmF8E+ArdGnfAnTPHO1SNdNr6aJy1oHxUPOw8By7aEwdXNEjtP035C6JhFpsGt/C3OV614qz82vb1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_16,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=772 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170100
X-Proofpoint-ORIG-GUID: Ni58F4JX85wjCo0OzfZ44jfM-V6fktVc
X-Proofpoint-GUID: Ni58F4JX85wjCo0OzfZ44jfM-V6fktVc

A ~5% performance regression was discovered on the
aim9.brk_test.ops_per_sec by the linux kernel test bot [0].

In the past to satisfy brk() performance we duplicated VMA expansion code
and special-cased do_brk_flags(). This is however horrid and undoes work to
abstract this logic, so in resolving the issue I have endeavoured to avoid
this.

Investigating further I was able to observe that the use of a
vma_iter_next_range() and vma_prev() pair, causing an unnecessary maple
tree walk. In addition there is work that we do that is simply unnecessary
for brk().

Therefore, add a special VMA merge mode VMG_FLAG_JUST_EXPAND to avoid doing
any of this - it assumes the VMA iterator is pointing at the previous VMA
and which skips logic that brk() does not require.

This mostly eliminates the performance regression reducing it to ~2% which
is in the realm of noise. In addition, the will-it-scale test brk2, written
to be more representative of real-world brk() usage, shows a modest
performance improvement - which gives me confidence that we are not
meaningfully regressing real workloads here.

This series includes a test asserting that the 'just expand' mode works as
expected.

With many thanks to Oliver Sang for helping with performance testing of
candidate patch sets!

[0]:https://lore.kernel.org/linux-mm/202409301043.629bea78-oliver.sang@intel.com

Lorenzo Stoakes (2):
  mm/vma: add expand-only VMA merge mode and optimise do_brk_flags()
  tools: testing: add expand-only mode VMA test

 mm/mmap.c               |  3 ++-
 mm/vma.c                | 23 +++++++++++++++--------
 mm/vma.h                | 14 ++++++++++++++
 tools/testing/vma/vma.c | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 9 deletions(-)

--
2.46.2

