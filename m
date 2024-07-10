Return-Path: <linux-kernel+bounces-246925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4D292C8F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9DC1C21177
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F511A28D;
	Wed, 10 Jul 2024 03:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="SKxlfXqY"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2048.outbound.protection.outlook.com [40.107.255.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A17C2576F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720581035; cv=fail; b=sa9Ilp2d1AE7IZiriFNbnnFfqMOOw6s6j/0/FxUi4m0mdzssKMK7ycK2V0m/7y/w7IBXaXpIPThWVl6+cskU7nV0R4Jl5//3ZOB3qKIVgUbNrLpsKdv4/qs9STexl2DrilXYk7Bl/yeIPrxOxnzzC0l7vkfOgjcCT2+lcXGu67w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720581035; c=relaxed/simple;
	bh=fHNSFYdlVVxtFjYMqyoCLTznMZWE6bQy3HQAZRriSZU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tbimlnIzFBZLnfJVmehqRgnkIMkHejDteeRClVIOVXgnrpcCKCybhWIQIZkb1k4Fd5e/fPWC8aHnvECVQakAYlrfyqGuOsdOu3JlbceEu5zQk+K9QLcjG2Pow5XqOYrE/BKbXYfyKuLt2pg2Vu8o5kmPV+2RYy860znKZoGkzyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=SKxlfXqY; arc=fail smtp.client-ip=40.107.255.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOQ1D79OyZaxUkRSwLpAmeL9K2jPP2O/ekYO7IgOkzR4Zk7I2SXDvhtazoIDnxeEW4XjKoSXBfxrZ0ocYszwJ3qwe5gdwvDNRvd3jCHx1JKXCv4cemnayo3atZVy8B44sYUl4WcbTrxeUXN1PBz0r8BY5oBd94bRiH7HmvtwiMSaZk8DU4v5qzEbgsLGOdbVwKm3tJPy4nBkJRJJ/rR3pGIOxRrmXcuGcwXi5NNlT2HJ2f2Dcd3trGw9rDnTPOGISuxLV+QPfmAsEuJUCspYqzQocM9LkLucPnheSZoRAJYE4YTAPgUaUy3QCp5OM6I84pFENBXF9uv1/nsXQMUpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3PL+S5X7q8r2qnDC/7FUZ7Gmw/iWimRo5Vyc54plj4=;
 b=jMp652Ck58Tv8Ahwg/3NcLb4NdlelbVPgK47Vm2dfdbjxTHLpiwsd0spZXPWHl94M4QY39dg/IZYIqKu1EAJANr02mbdn+SjSwvKqwLXsOMYp/qAuvFda9yvr9346b7aLGIXMkoVM5iDE4fBep8h+GQCrJZ5iHrD5zNOGLGGgmY+AP7coprb0+/uDFjKEMj8VmUe0WxXME4c8FPmlAzOEciiCim6yAmxaw/I5KZzpRFMiuzNlrZArGkMcpTQrQMtTs1TxPaoa5dpIX+aeQCe0L0Nd13pUYxPheeLCz7h2NUAnl6qLFyUnWOI8y5bXmvlMMh/06l/4cgY+CIOsuPiAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3PL+S5X7q8r2qnDC/7FUZ7Gmw/iWimRo5Vyc54plj4=;
 b=SKxlfXqYRhUMF//gPmzTfba/NNJLQhjHRXQ8FkFy3bki8+ITDKcAxMptvgKBd9Wzrxh9kqX29USlY8leIge9Xfv6XaqVkKqqh/m3oXdAO5om+Y0/7bdRVuYwcYgYqpLyoLQb0OATB6p7m3V3y5rwRjNA+4/dFmGEbwxPuSuibPHnIV2lmeXCj7aWjmBGbE/uI6cBBLIz3vOunY6D0x9xXkwBZUz5+mi86uyXjjqOpPVJ8xjYLKlsv1zMrmf/zyzuaXfk+sbzNofIf8bRBek1s1Dc9dfK2rag1XUfH7kFvVbWd+C7Sya1RvMiQf6LD6/Rm+fQYbhcdVrCLDA0FAQh2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SI6PR06MB7146.apcprd06.prod.outlook.com (2603:1096:4:251::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Wed, 10 Jul
 2024 03:10:29 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 03:10:29 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v9] mm: shrink skip folio mapped by an exiting process
Date: Wed, 10 Jul 2024 11:10:20 +0800
Message-ID: <20240710031020.1681-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SI6PR06MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b4e277-a227-43fc-b125-08dca08dda51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OWad14J4apFlyZeDILaTQ+NU3F/E2YUFj8mpYKlSxlDDh/F7byIQ42i7KW9w?=
 =?us-ascii?Q?Mtg71RBw61op6jhNpE+lOXCVnDqgzbj+Klth1mMgybnO8INhzjL56Qgv+wMz?=
 =?us-ascii?Q?yMc+u6q6qKWMLqGBDJTxLOrZQAbUAu2hTT8yH1+/Su8akded5TDn37UGS999?=
 =?us-ascii?Q?f58Rl8RPw5MFlAA2SJrqtHyfgv3JDLf6FvCT6Qf12knSnLvQmx4FSQKd6t9B?=
 =?us-ascii?Q?XeJ4v7tRjxoWsaLKUwztcssHMSJUar7DU5KMMhT6hijrEpWpGoTmrYURfe+2?=
 =?us-ascii?Q?lU+DS8ZEok10BamEU1sGUVesiHPvTtk4qcNG1IStrGXaVW+ifHA3hphyvKGU?=
 =?us-ascii?Q?/Og8F6pjwr+iu8FtmdC/vQslmORF9nIIovxJm4M6wMeTgcjIe5WFU0XcNwU/?=
 =?us-ascii?Q?zHt0nwJ2K4r/b3lYHhx70LY0uqKd7S5+mQiCvw/O3hC01R8zA9dnBB9qR3ZE?=
 =?us-ascii?Q?rKVXlQ0l0xA1ANkkUEsels/qQSzIVTy8cOXwa20l/MJp8+XD7NB3nXGvsB3l?=
 =?us-ascii?Q?RnIQO6dbm1dTWqfCPl0LS6Hch7ExPmnItmXJGaZWB8ZovrXexcX5bJJRARk6?=
 =?us-ascii?Q?bdgduxAA99gHRqW0sEjukuDKM6dQf9TWs1Lb+bZgcaxbmjthZcSRzSzZptYY?=
 =?us-ascii?Q?iqUNaM0Q65/vYfCjCfXE0Zf32LlfbRAHbcgbDU6lkFdn7X9pOXhSWF08YyVh?=
 =?us-ascii?Q?BjUgxDzfQeldTbnZc7hxgcF26R5SG1NtBqdE5tOpTdZFVYZ8si/GQ+KCUZz3?=
 =?us-ascii?Q?Gni2b5ZjlrFBwxPMV6c2csMRMkq5UaKju3GvV1oVOsPEnwD4TMNZFE+IJAGo?=
 =?us-ascii?Q?nt/zSAtYFkzsV0jHOprMMRPjysJVa88UZMeJeV6Rvak9xmNJvk1NDvwuVn4Q?=
 =?us-ascii?Q?lFln3hid7Rsjjs1FJwG7HYIxnREG04aF/q44JszzHT5+APbBghkejHutG+6E?=
 =?us-ascii?Q?WLu+O9h0HjJCQhnRutkEmS8B199i0cQrPzFe2VDOf5qCZmzSZDtvDCTuuek1?=
 =?us-ascii?Q?3JuisTr49UfayEs5BGZPKoHm1ZG+zw7dN5pD/a2uXJWfTDA1UEHXFQ+F35GY?=
 =?us-ascii?Q?OMIQuozakBnCOPIl6XSsznjvQd6A/XnJtiiNmKe5jiwuaiYOM0lNgcJ6kZox?=
 =?us-ascii?Q?E+T22HZ+fFrz64EkRkNk7Z1GcytWehwtquhDeNX0VguHWz46oCUq/0LpdPel?=
 =?us-ascii?Q?5JDXNkXHgS6YIdcQZbbcV8S7UXCf05gnwcCkR9r0EDGNCzBBKXaqGTxqNV4d?=
 =?us-ascii?Q?EwROCRjrKkfThN0g+Cyx8+Ja3jpve0YNU3uF2bzJrUQZKizRWK+JokUhnQSl?=
 =?us-ascii?Q?KDvYbQ/aehEkUtF0UiFoDJycVNbm+TSY6KewUFn3TBRclOXzl0eErYLp4Iz/?=
 =?us-ascii?Q?ACMYFr4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BiYYEledBTB4NZh72PlArONYTM9oK5TDc9/qgemhGZbXB3KUb8rkN/Q5tL5N?=
 =?us-ascii?Q?gYYi5letucimUNoCyyxsGrOipk5sxIZQfeqApk1RvdHKVEmWg/b8XFRVRAKU?=
 =?us-ascii?Q?YhUyNrD2YckBUI3f53ITK+ZEfgc8w8xmgFGH5YEACdRFPLigMAqX6yOVw33+?=
 =?us-ascii?Q?8hskWINv5fVFmvWySKIjAAWotGr8LFjjrAAksJKfQ+yxkYNgV+UWNoimb6u0?=
 =?us-ascii?Q?p1XRLWVBIUoLHRVWwF01WqSLNGfBBhJww9VNR9I5BHpil7bMmc/LwZhzwLDP?=
 =?us-ascii?Q?XORpvFBQMWXbljQcZNvaBBzH+NUv2QqekKWGA06Ybxi+d5Vj7/LA8bkzx7et?=
 =?us-ascii?Q?u0AReCs5OpZyOE4HT8Uz0GYvb508wQeofPA3WY8g1EJDD12LTLsYG/+guyH6?=
 =?us-ascii?Q?TKV7jb57PNgWbZ1DGSLzXd0pQrf0PfIQgtusKZOzmFwD/fD60BSHwr/nUOp+?=
 =?us-ascii?Q?T8QtuPWZ5aDAc1qK1gxLi8XOp4ayL0/HquoDQLslBxrgibPntYd/26Yf3PU9?=
 =?us-ascii?Q?xaznCiILoSVslzUa7ClvojY7lRe6USav1kaiPzgPIkL81RIGIs75alIl3FmZ?=
 =?us-ascii?Q?px5bo7EorQYln33jQaZXsLFLDDYwEBOIk8zMRIc0xI3QilxcD+UxAbb+PU6u?=
 =?us-ascii?Q?a5oweBrVNTGTIhJytU4PKGQlTNNE5sO3T9gPXNfUckMqturpNis9Z4XuDWng?=
 =?us-ascii?Q?tWS9aCcnEooCIrv8f3W9w7UdtIUhRxh4XpzMR6e58y1QWB5nCLLN7JaCqxXF?=
 =?us-ascii?Q?4Qgf5VsDz2RVholoRXA00NKwzI/gq9AaGER/c+Zuk5z7ktOxyzZv5YFD4YWh?=
 =?us-ascii?Q?2nJZv94s5pNo6knj3ihF1fomcsMrfRawkOdgXk9EayOLUlEDrAOQx/Pm7clg?=
 =?us-ascii?Q?G6b2UzOTdwvfex1/ZSrP05TX/U+zfDGp24CTCmySf9kD2s+pRtnv7d8JubZk?=
 =?us-ascii?Q?H9k5necFw3PRHS5PZs8p8+bcZsQnLUbz2c/OG3fIRHH4fMFFIMXK9w1IB+eL?=
 =?us-ascii?Q?Djrvjaq+dSYH0hGv6pPa458TtjlcPbMLiM87LeLFeQhQrDzCcQpUB6n674t9?=
 =?us-ascii?Q?hzHU1u1vkel/5Wx+5/svUFlXxDszvrETjgKhgDJA1pvEG1ajX7N6IGQtNvxM?=
 =?us-ascii?Q?U3vn27ToBGl9KDAVf8vvyEQoTd0FbVcKgfqz9dqjW++vaNYXuFkIlNaV826v?=
 =?us-ascii?Q?EuHYc4B2sBJ0X3KSMWzMY1EuNKf7JV2+2g61/bGdU30fX6WSmYUdMHE9FQq2?=
 =?us-ascii?Q?eFWTFSSPF+GV+giDn6Iv77jFACb+RAekOUE4xPjhu509e2GJZcvlEawZKNOx?=
 =?us-ascii?Q?iqtkyqDCPaAb05iTEps/iD3IKAkfw9eEX+MwNugS9kzViOSk8Od5IuyaoUN6?=
 =?us-ascii?Q?A6YtEbM0cCUjZh1vs8jgbVoiVE9uM9ale1rLbsX99pB4cv6h8dsghXfz6K4q?=
 =?us-ascii?Q?C5YN9iAStPzlJgqe39RMWGIieiwE6MfaE8ILKH5HK3EopG3fNBzp1FtaOPhZ?=
 =?us-ascii?Q?0F9HSPVj216FfQ81M6dDZaSr6U73Bw26RlMINA6kWE+/PHAP/xS/ZVygn+tY?=
 =?us-ascii?Q?K2aMYSuifkHErvg81Hh+1Bl1T/+wnv+yLHKC3DQ/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b4e277-a227-43fc-b125-08dca08dda51
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 03:10:29.4712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IyIJn0lK571+Xrb+YMV/zHTwTgDd6U9zbVPj11TTGhXGr+VNiUSbislQV74mzc4O3bdyZb8Yp/LhBhKrjLwkjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7146

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

Acked-by: Barry Song <baohua@kernel.org>
Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---

Change log:
v8->v9:
1.Update Reviewed-by tag information.
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
[v8->v9]:
1.Barry Song <baohua@kernel.org>
No, this is a disaster. Please ask someone for help before you send it.
Neither Willy nor David has ever posted any Reviewed-by tags.
Please do get someone to help you. Stop posting like this!
-->
Update Reviewed-by tag information in v9.

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


