Return-Path: <linux-kernel+bounces-246900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AE292C8A9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 04:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DAE22840CD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 02:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387D6171CC;
	Wed, 10 Jul 2024 02:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="EUoGfd3k"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2072.outbound.protection.outlook.com [40.107.255.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5AB168D0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 02:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720579159; cv=fail; b=MaQ1cJAFn6zg55TexNLcZn2mQelEPGUTtBaJH/10UorlpzHxcWa3Ee013JgfTBd7mZ1GMz1M+8sVtgevtw/Uj+B5V8mew/Nlp1PLAXgYBuUNjLYYEz6bT1MQie+7APkhsv0CCGvF+uXGx3HOMPoIhf+RpcXMij2+QOgLI2FFRII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720579159; c=relaxed/simple;
	bh=4gsnA01ObWdw1iVSbrw7DisW+iWXifgeH7Cvy2r489M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=W9DMn68IyiJSjj2ZY/oZvEOJS1juGxHFV/8DUB0ZbiIBygvudjfOHoQFMWFrP3CnatjWZ5YcOmX97JVgXMQ3Su+ljBYK5HKYRcPsWNmW9UENW1x5i76FejOsjs3/D53vmbh9RuccyE2qN7eUMPi+5s3/W1fAzKvKZfL06iFanTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=EUoGfd3k; arc=fail smtp.client-ip=40.107.255.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T11D/0G2zA92m2WQ4zY4+HynVIMqyEzx70wbEnhmX+O/PEPt4tJG5SNWhI++8CQKqS4DynVAKQVlZylHuLciuAtA+KxVsNbFmSVQbNZhdU4R2ov7xJRxcG8qMfhYXZ2KUuvh15PNEyMTwp5mMujz4uBmiKGkfMo5aBKhPl6gvcFmJKaNCyozcZsrxbJGq+4gqTtU+puOPcgzwNLkpIhiCV97Yp1oNLeuhnJmn3SePP+K4c0c2rspuPBGAwSVnurI9f+OH8ed+ARltvX8vZ2odcUjsSGaRgpQYhEQIEQTgoQ0aX+wfrvQygqnIsdG8kTTCrxjraHCzTHeeGM7hN9p0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YfcWV1cLYZZGBfl+rcTNOxnzJhMYUdjYgJih5N7VBY=;
 b=RQXRSClGb8Q+3v1Ipalb4qK7oYvbc33XrRjys6Ck9DxAtq31Ik1U2yJcyRIOkxphvj/4ioBhahvMh6aocFLBs2gpCcWzYjVszARt/RO1RWATMg1Nqg+6LytNXUk8Px8lRMns0pjkiPrQJcTs1sU/HLA5JxlYHfjaHtWRD2jptj8i5gA4uKmFhVj2rXeMw0ib3rzXETmR4LaJ9ME83/4dIOWpyMItahobauJQTJMoR2wcAIY7M+MDK+8nE5AEyKqGMQdwzu5laZ0jw8eBXeI8OGtH1AP5Zir98N+GFxLo6HiorP2RG0jAlh1T0GC9EzmIT/MwWu8d761HAKXOhghX2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YfcWV1cLYZZGBfl+rcTNOxnzJhMYUdjYgJih5N7VBY=;
 b=EUoGfd3k37ReuqUXx7BQg4U0Hr1aHPSk/1WAEv0928/C7jdI97TkCHBvfinmkvSRHnF6hvTLxidS2rQ2nfPmaQGHvYpZYYM2xAiz/0u3+Rn55Taa8FnjTKYXITKItEXsSkqsz5mLS0Th2zva9lzcHBtjLnHQXKcXBeJwvd5tZ1DU+dGmv3anfdv0r4Wzs7A/l49G5t7eNezDKwcpqKcSn3Gvt0NZwpugU/PeNB3fKkU9HP0ekxoGYptcs8hiK0ItfHHG+Cdy6SnYRP6fDdLSybKsiizVk/8GRmqwlIuucMSKpXyK3f1pC6Wj0YSFqBiU/x1rTqJ/g6ufx9U23Ar3CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYSPR06MB7305.apcprd06.prod.outlook.com (2603:1096:405:99::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 02:39:10 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 02:39:10 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v8] mm: shrink skip folio mapped by an exiting process
Date: Wed, 10 Jul 2024 10:39:01 +0800
Message-ID: <20240710023901.1624-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::17)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYSPR06MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5e0c9d-846b-4112-80a9-08dca0897a1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wHmbe0jD0Snf8AE957UfNfgz/rAeOYZnOhQPzbxBrYB8e8ByrD+4kR9Hodt8?=
 =?us-ascii?Q?12l115Vm6y8wzN87VnTG1lEceYALPEpnd1gbfPAprQL5syydJPJK5GxtVQcl?=
 =?us-ascii?Q?ND8SlsNtRU81+vQNkCtQvPKLW/pi4XWJ/DM6fBWN2QacS40mtrumiz6fOjoI?=
 =?us-ascii?Q?cq+ssYCUnino9SoEAZNMDi5tysRgkZFksCtqQIdFCLjcJvQSg7dIqo0lmAql?=
 =?us-ascii?Q?KYN9AxWmy7GXVS7PGnLQU54jHwDRX19HEWdI4iKIJ8cLErT5XjnwDop/6sRV?=
 =?us-ascii?Q?9dbcszwqnZDyr78aTm882+RSX+2xxSGwqMvY1KmrkQ46Ih2TznACIF0cPFcy?=
 =?us-ascii?Q?C6m5PJkMXfB2hJ15O6sZJaozCiri/7LR7evP2twMFq41QXHhYLSGEgH3fr6P?=
 =?us-ascii?Q?pI1es3OyZf534H/ZUcutWLP4I6TvGGbTeReEVxV7SrdWxbkC7qeSbab0FfEb?=
 =?us-ascii?Q?hWRwCb32LMO+b70/jXHYZoT1iVxmks6r1Jf4L7VXn+AUVZmmbQWuk7XO6JJz?=
 =?us-ascii?Q?rAafyOoxE8RY9VlO7zf1lxxBjdhpyEQVGb8V9rUuoVlh9SipPnWektvOlCGq?=
 =?us-ascii?Q?4KQ8s4Z3t0VpY3irbOTIVLlbSmGoih2B/KCHvgzV81FcU+a+Z9JQcl2lKu2F?=
 =?us-ascii?Q?vBD7vmXc15Rm3JNtwZFd3YDXN55CQsGMquyNMIsi/1vQPfJvUPtbkzynh1Hd?=
 =?us-ascii?Q?DD6gCWgHw3Xrxv4FuRTfZfXcFba0Zr6MxyyA1772zI3/lTEFxn+k3tRS6WRe?=
 =?us-ascii?Q?uk5FlC37MkrSo7W6XmovGmXersdu6QMJAh/ysn2XQXtJ+u7I+n/mm3v4mQKC?=
 =?us-ascii?Q?ijnd1MVxIzDG/VKoI0QfWi+LhQoPIjJKeqwDBbAkBbdXSSpfC5Iqfe6M2um/?=
 =?us-ascii?Q?4Lfd4UgXotlhxiSflA0wsrndKlI0yN48FV7I7ZfqCBepMkr5Cx/RSDGMuZ51?=
 =?us-ascii?Q?J4zs9JlKcvJ8n4q9sZpPD9d5Ve+uA74Ozk8ZpvHkWJH7rnmH11Sp/yylAAzB?=
 =?us-ascii?Q?sDJLMVeHmXc+zjBb33IZppE8V57mocqE2AXdkCWQ9FMjZS65tLZP9+9A2CME?=
 =?us-ascii?Q?rWQyB4NJqT2p7potZC6r8wvixNWe9ImXh6LjXWvr27dMCSSPyXFrhZ1enArI?=
 =?us-ascii?Q?Mj96jc1RVISNXdBQvDtsAYOv4TH4J+4xVl64BVAPMN126BZUMw7VJLwVekXV?=
 =?us-ascii?Q?/dH3uqqI89cHMQsEGlBmOXl4KOXGwq06oSd86OaSqwOmch+uF8VY896EhdGv?=
 =?us-ascii?Q?XXfKnpWodQqZzSPvJV0PqQcR3/oYVT/2v2ApqXAwfwp3G0P40520u6kHMMVm?=
 =?us-ascii?Q?1TKOyfGVrkzGO1p2dynw3o5EU9jq4b3j2EA4dgam0zybqrlWLWBK8khN7puz?=
 =?us-ascii?Q?VOoGNYA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sONw9Hi+iNusIo0PHb/b5/AWQvPKNIRbwfqz679uwyiks4AC+dzchquYTuUN?=
 =?us-ascii?Q?sFQnA4NCfHf6C/L1VINC/zD4muhojEW2z7+MXCbz7T/9VvItT4xovXBMxcBn?=
 =?us-ascii?Q?9BfABnBySut/dwebFxBgKPJYD0s7+qHaI4TSSfEb5S0NYeS90V7Y3MjqyWfn?=
 =?us-ascii?Q?BN7/CBbtRw9lABV3N3/2ocXVPW9p/rNAeJ3Y5Xl7VA19UD+KKDheVyLSWmCF?=
 =?us-ascii?Q?bM5RP3H2jKPy6Scl9Ti6sd4XgyhDeAaGIX3hc5/VN6oFcv9M2W4dMeHGcmLD?=
 =?us-ascii?Q?JwzHACtJ8wStTiqhUdHWoVVhk2Zf2B2U+fBUGXzkX+sRWOBZky7Mf6zxaovr?=
 =?us-ascii?Q?zaOAd8ORvgiQWZ1AbnEUP4RXC0cONszJoH3OQJv7YQA7+fK/CBGf3M8ENmGe?=
 =?us-ascii?Q?bh/JiO6ay8pSJAX43lFgnF+mOLTosDmocszvmbTUIkwYGnqhDzx/OcBSGZPe?=
 =?us-ascii?Q?vYVf+WPDBP3Y8KroHieiY1QY5ghfAhtTMDg75WnFJDje07e87WnwDDhMvYcq?=
 =?us-ascii?Q?z1gT8R0+fpAR6tIaUT0xTCYCN6s5068OYE/8K2yMXwX0oWH2je8XNiTNNXTU?=
 =?us-ascii?Q?FIlqPlj4pmEbQqFVPj7p1fqwNS05L/f21jvb6Hp1Y/ou3Okku1k0CW0blEWr?=
 =?us-ascii?Q?iA9VGEirS0Vxop/kgA0KCEVe56ztL7ob4/wFgQMCkX83supyoD8Ef53+RKGX?=
 =?us-ascii?Q?ytuUT4v4+20RR9s04bW2XqhG/azEAWNH0wtKtg2ti+gkLNAbKF/uVrG/ILET?=
 =?us-ascii?Q?o444SdyIdG/g4/YLS1/0GRZaXqyHHo+Dpj9VpU9ytLq2GeTwV/+AmjKIPO9e?=
 =?us-ascii?Q?wojHdrQCb2Bt8a3iI2sGzhst2Rt2yUVQCP7DYAniFMiq/fgB4RnM0+/AJe7I?=
 =?us-ascii?Q?rEje1XtNV3pT+/fiyhklYiqyzHp14s4pTcSZnv34/53QzZ+sAb+JgQpnyKx6?=
 =?us-ascii?Q?gOSh9GdoldJuMUHY6rDweHxdb7fk2OLCgj62z4R8Ku5Vf+DKKMKFd5yUZAK8?=
 =?us-ascii?Q?+VtTBsereeokH5YK8mIYLjQvA9hdMIcnLxbdYUVL5DVIRawTVoKW/tofxY+p?=
 =?us-ascii?Q?+cyo4oUNM9qquyQxER2NC7sglzIWbcmJTbz0qoi0l8WK2mQ2uG5H205EBVVv?=
 =?us-ascii?Q?Tm2IvzyZweFmAmQD3pDN6Ov0W/OheS0Eenkii8ypZzRR/uDSn6Epp1fvP27q?=
 =?us-ascii?Q?oZoeyLR1NWfwGYaw3tqqWn6sglFTr/QoHIipbG+PRB/KiuV9sJNUuOcFzZQd?=
 =?us-ascii?Q?H2EeUdMxd4foF9B/gDgLLjxC5pVrs6wQblPbxiRV0YzWj3faMMhicuLJlUaf?=
 =?us-ascii?Q?K2R7MqqW7ifgv1hEYUcx+V72F3AZK2MxI/wtDCziFB/IfZRxACJxD+nYsNtu?=
 =?us-ascii?Q?eqPszdzazyx9G5e6S6fnoq+KXhXO809xIaSaUH3HtZIgfi4fGxwPTwlaZrVO?=
 =?us-ascii?Q?Hzntw6B7L/G7P0fWxXopuZZhpOh6bBswF/qewTEJVGapp0PUX6Bd+Rd9bc0M?=
 =?us-ascii?Q?DJR5gqoWx1SF0uJbD6ccfug489jjnbz51OS5TaLZtjS9pcDCizzNaL+WW4Lq?=
 =?us-ascii?Q?0G5N+cuGATrLPz5STnl/WFHZOvk915ZGcn5DciqH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5e0c9d-846b-4112-80a9-08dca0897a1b
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 02:39:10.0675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlVHIZ3+AZ9pIkWaex6hIN3M9Wpq0zA+nvLfbIqZdEqUWXgwhXsxyktx48kVsvj/LXLrFgmB6MwLxpXWes+02w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7305

The releasing process of the non-shared anonymous folio mapped solely by
an exiting process may go through two flows: 1) the anonymous folio is
firstly is swaped-out into swapspace and transformed into a swp_entry
in shrink_folio_list; 2) then the swp_entry is released in the process
exiting flow. This will result in the high cpu load of releasing a
non-shared anonymous folio mapped solely by an exiting process.

When the low system memory and the exiting process exist at the same
time, it will be likely to happen, because the non-shared anonymous
folio mapped solely by an exiting process may be reclaimed by
shrink_folio_list.

This patch is that shrink skips the non-shared anonymous folio solely
mapped by an exting process and this folio is only released directly in
the process exiting flow, which will save swap-out time and alleviate
the load of the process exiting. 

Reviewed-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Barry Song <baohua@kernel.org>
Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---

Change log:
v7->v8:
1.Add tags of Reviewed-by and Acked-by.
2.Add #include <linux/oom.h> to solve compilation issue.
v6->v7:
1.Modify tab indentation to space indentation of the continuation
lines of the condition.
v5->v6:
1.Move folio_likely_mapped_shared() under the PTL.
2.Add check_stable_address_space() to replace MMF_OOM_SKIP.
3.Remove folio_test_anon(folio).
v4->v5:
1.Further modify to skip non-shared anonymous folio only.
2.Update comments for pra->referenced = -1.
v3->v4:
1.Modify to skip only the non-shared anonymous folio mapped solely
by an exiting process.
v2->v3:
Nothing.
v1->v2:
1.The VM_EXITING added in v1 patch is removed, because it will fail
to compile in 32-bit system.

Comments from participants and my responses:
[v7->v8]:
1.Barry Song <baohua@kernel.org>
You should have collected tags such as reviewed-by, acked-by you got in
v6 while sending v7.
-->
Added in patch v8.

You didn't even pass the compilation stage because you're missing
'linux/oom.h'. It's quite disappointing because I believe in your idea,
but you didn't even build it before sending.
-->
Sorry, I overlooked the compilation of folio_likely_mapped_shared() added
in patch v5. Compiled and Updated have been compeleted in patch v8.

[v6->v7]:
1.Matthew Wilcox <willy@infradead.org>
You told me you'd fix the indentation.  You cannot indent both the
continuation lines of the condition and the body of the if by one tab
each!
-->
Modify tab indentation to space indentation of the continuation
lines of the condition.

[v5->v6]:
1.David Hildenbrand <david@redhat.com>
I'm currently working on moving all folio_likely_mapped_shared() under
the PTL, where we are then sure that the folio is actually mapped by
this process (e.g., no concurrent unmapping poisslbe). Can we do the
same here directly? 
-->
You are right. we might use page_vma_mapped_walk_done() to bail out.
(Barry Song)

2.Barry Song <baohua@kernel.org>
By the way, I am not convinced that using test_bit(MMF_OOM_SKIP,
&vma->vm_mm->flags) is correct (I think it is wrong). And exit_mmap()
automatically has MMF_OOM_SKIP. What is the purpose of this check?
Is there a better way to determine if a process is an OOM target?
What about check_stable_address_space() ?
-->
Sorry, I overlook the situation with if (is_global_init(p)),
MMF_OOM_SKIP is indeed not suitable. It seems feasible for
check_stable_address_space() replacing MMF_OOM_SKIP.
check_stable_address_space() can indicate oom kill, and
!atomic_read(&vma->vm_mm->mm_users) can indicate the normal
process exiting. 

I also think we actually can remove "folio_test_anon(folio)".
-->
Yes, update in patch v6.

[v4->v5]:
1.Barry Song <baohua@kernel.org>
I don't think this is correct. folio_likely_mapped_shared() is almost
"correct" but not always.
Please explain why you set  pra->referenced =  -1. Please address all
comments before you send a new version.
-->
Update in patch v5.

2.Matthew Wilcox <willy@infradead.org>
How is the file folio similar?  File folios are never written to swap,
and they'll be written back from the page cache whenever the filesystem
decides it's a good time to do so.
-->
What do you mean is that the file folio will not have any relevant
identifier left in memory after it is reclamed in the shrink flow,
and it will not be released again during an exiting process? If that's
the case, I think we only need the anon folio is skipped here. 

[v3->v4]:
1.Barry Song <baohua@kernel.org>
This is clearly version 3, as you previously sent version 2, correct?
-->
Yes.

Could you please describe the specific impact on users, including user
experience and power consumption? How serious is this problem?
-->
At present, I do not have a suitable method to accurately measure the
optimization benefit datas of this modifications, but I believe it
theoretically has some benefits.
Launching large memory app (for example, starting the camera) in multiple
backend scenes may result in the high cpu load of the exiting processes. 

Applications?
-->
Yes, when system is low memory, it more likely to occur.

I'm not completely convinced this patch is correct, but it appears to be
heading in the right direction. Therefore, I expect to see new versions
rather than it being dead.
You changed the file mode to 755, which is incorrect.
-->
Solved.

Why use -1? Is this meant to simulate lock contention to keep the folio
without activating it? Please do have some comments to explain why.
I'm not convinced this change is appropriate for shared folios. It seems
more suitable for exclusive folios used solely by the exiting process.
-->
The skiped folios are FOLIOREF_KEEP and added into inactive lru, beacase
the folios will be freed soon in the exiting process flow.
Yes, the shared folios can not be simply skipped. I have made relevant
modifications in patch v4 and please help to further review.
https://lore.kernel.org/linux-mm/20240708031517.856-1-justinjiang@vivo.com/

2.David Hildenbrand <david@redhat.com>
but what if it is shared among multiple processes and only one of them
is exiting?
-->
Modify to skip only the non-shared anonymous folio mapped solely
by an exiting process in next version v4.

[v2->v3:]
Nothing.

[v1->v2]:
1.Matthew Wilcox <willy@infradead.org>
What testing have you done of this patch?  How often does it happen?
Are there particular workloads that benefit from this?  (I'm not sure
what "mutil backed-applications" are?)
And I do mean specifically of this patch, because to my eyes it
shouldn't even compile. Except on 32-bit where it'll say "warning:
integer constant out of range".
-->
Yes, I have tested. When the low system memory and the exiting process
exist at the same time, it will happen. This modification can alleviate
the load of the exiting process. 
"mutil backed-applications" means that there are a large number of
the backend applications in the system.
The VM_EXITING added in v1 patch is removed, because it will fail
to compile in 32-bit system.

 mm/rmap.c   | 15 +++++++++++++++
 mm/vmscan.c |  7 ++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 mm/rmap.c

diff --git a/mm/rmap.c b/mm/rmap.c
index 26806b49a86f..5b92c3dadcc2 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -75,6 +75,7 @@
 #include <linux/memremap.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/mm_inline.h>
+#include <linux/oom.h>
 
 #include <asm/tlbflush.h>
 
@@ -870,6 +871,20 @@ static bool folio_referenced_one(struct folio *folio,
 			continue;
 		}
 
+		/*
+		 * Skip the non-shared swapbacked folio mapped solely by
+		 * the exiting or OOM-reaped process. This avoids redundant
+		 * swap-out followed by an immediate unmap.
+		 */
+		if ((!atomic_read(&vma->vm_mm->mm_users) ||
+		    check_stable_address_space(vma->vm_mm)) &&
+		    folio_test_swapbacked(folio) &&
+		    !folio_likely_mapped_shared(folio)) {
+			pra->referenced = -1;
+			page_vma_mapped_walk_done(&pvmw);
+			return false;
+		}
+
 		if (pvmw.pte) {
 			if (lru_gen_enabled() &&
 			    pte_young(ptep_get(pvmw.pte))) {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 80f9a486cf27..1d5f78a3dbeb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -863,7 +863,12 @@ static enum folio_references folio_check_references(struct folio *folio,
 	if (vm_flags & VM_LOCKED)
 		return FOLIOREF_ACTIVATE;
 
-	/* rmap lock contention: rotate */
+	/*
+	 * There are two cases to consider.
+	 * 1) Rmap lock contention: rotate.
+	 * 2) Skip the non-shared swapbacked folio mapped solely by
+	 *    the exiting or OOM-reaped process.
+	 */
 	if (referenced_ptes == -1)
 		return FOLIOREF_KEEP;
 
-- 
2.39.0


