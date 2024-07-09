Return-Path: <linux-kernel+bounces-245147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A79292AEF5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25571F224AF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363F25FB8A;
	Tue,  9 Jul 2024 04:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="YaEyeLka"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2069.outbound.protection.outlook.com [40.107.117.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D112BD05
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 04:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720498265; cv=fail; b=eWzqbvws8jlAW1zlIRdUPdPerIFdalkoIiupF+gbX2SvbOn3SKsjZCrPPLnCuPlR4pSnS9MLbX1viPTLB4Bho54Oc9HQyVAO3XswzGSplV0IjOO3vqqPqvpQTZa6ebQjpZBwLM9KU0r2UxgiEihAva99gTakK7HnL6ue/euph4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720498265; c=relaxed/simple;
	bh=SoIh3yoDnbcanEPfBGmH9f504x211vNkLxUnLhvsPYs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AlU71EjBCRURXZ8IDf8jOrR7vtH5mryD6ZZoAmEMfepGV3XjS7HThX3WVxPIYXM3zd+HcrJTFlO3KV/YOVFLVvUheJcV3brCMc8Anc/IIb5Yd1bxz+3lOYlM1DkWEdnl1rFP/1uonLi5Bdh4nA9UVizRUrqXvX5tjzETALQDELA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=YaEyeLka; arc=fail smtp.client-ip=40.107.117.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djLXL416JMi+dSwgB8gOyacLm3dB6UfNGAAN7ih9Mipi/RV16plw9a/URM8VvAEcV43BGEf6v9lZZO2HqLInDORugPpUMQ+LNUn1tG/aZ61VVaBS6xNcS4dE41rh2nhIDO0BbrehbPIebI324d8baNdjYxl7khSGbMXuZ8ZnFGrcaESxY+5sgJ16Ly4o4CwlRnqvjP6qA6x2o00oimbMnwQL3MxHB0jsMIzSx8S2ul4WYypDeqDkF1XQ37PfzVQh6G9VYyrcrxw5CP3yiLBDxXCVdAVefENdTIQ32uXDDWHDCriClLensU/JHWX0zFMO7JrFMtujMt8LcJ9S7aYAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSE+Z7snhemgJUCez7bCHzdJpkIGTdU+MGuPUJHhqqU=;
 b=XnGh9a3tQnMGCcuYGHS/4RQCV4+rcq02En0xxBkbpSHdPb0QYY+11HtF87jlhukJXA7hEUR5czXiQyC/dwchtQ8+X8nU8iPv97TJdPIu4R6Rt5yFg/F+cbKEi428DY1EGUZ36FlvsegNT1XBMVHYEXBxCpj6E0oWdolQxICVeoTKX1VY4EuMfYlIVfgDCM5I4UpAxOlpjf3gjkOzihilDe4/yDZyJynx0wALYFCDa4NOe/967JS4ZmSI9iNdMJORalAwK85Fx/ass6IWrs26FUAj40LSdEHaEm3a3q5zaZKeYYilo72PURXYVF1uFCzaU7HBOtjsifD8nBtwVShnqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSE+Z7snhemgJUCez7bCHzdJpkIGTdU+MGuPUJHhqqU=;
 b=YaEyeLka3wVKOJyqBFPbtOz03Og1D9gkw0huqMwsPkq+JksML/zApuJ/iAxBGuU7rSMwnWEq24wOBFvYMd1Xk/9GvvxFUQT/rGS3O6XFdNzy9ZX+BBtsoPgtwEyUGPukYOpJEdUxFk8mAhQDbIsq7lHzK0MWAlRX0+tBwX7t1RTNxSNL1IQb0RY10ACYZ+KJstIx8dSHOilTAc6uac0FxVx+7oM/9Xqs/fMQl0ldWktQ1DUzPLjc5hJOd3t7MKQdwFnADmbchyspIKL8a4ZRpv8nvHvPIG1taWo9OQhZbyNFbSkvlf4NzxVfxwxpdkWLDS0E9jYvsFrxmF7Kj3+T7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR06MB6942.apcprd06.prod.outlook.com (2603:1096:820:129::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 04:10:59 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 04:10:59 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v6] mm: shrink skip folio mapped by an exiting process
Date: Tue,  9 Jul 2024 12:10:50 +0800
Message-ID: <20240709041050.619-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR06MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d119cf9-33cc-4d7e-d249-08dc9fcd2356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3YeTQFzrYCciczpV0gk6ye2dherikCTKnr/gOOBgg1/OjtitsdvGCIcpUp9I?=
 =?us-ascii?Q?E/TCfm+PYnnMP91DOpqVZXtjq8wXsEPjiwHhwRJGtqz+LKdDtabfKePGVD5x?=
 =?us-ascii?Q?Fcyo5hzkiu3rbXNV6lZqhZHK6AShb8GzKPK2YuDkUESKPMRbzIttIxS0OUcW?=
 =?us-ascii?Q?3fnZ0p9ZdQSqqcIzoLRrZksOCZ7z4UJ31l9uMPAonix24Amc13hqOYfdaOlJ?=
 =?us-ascii?Q?jjhi33kMEYfFXy+nCO7Yp9M2QRBaTOmT1WIozkhKr6q+T2umnhoNN7NFoMhd?=
 =?us-ascii?Q?q872AeQ8AJYHekpqQse08nORWFc1W4Hrqu9leCA/4LIdQpc55eYe2zBeaw6u?=
 =?us-ascii?Q?OqZwiLyD0OUW/Z5oZS0hJunVARtlxiO9/b7K3ytTGdzKcpaQmk+WNWUGmrXA?=
 =?us-ascii?Q?7Qh14UT4TNE0QJLHUbrspPtFWK+8vZmWSKGI1iwImBR8WOWVaFheAXQhJnfZ?=
 =?us-ascii?Q?t+eH7wiX5r0dCzQtLiXs/xDkJySs8qT/bHlcoZN9Ny3lKHV5ShkpeTLMFUsK?=
 =?us-ascii?Q?t9nbS6gFqFRMMmwFvWnUBV6+eVgWsKPxO3khUxFjlHUx06ck/r1AP7uFY8jJ?=
 =?us-ascii?Q?OBGcat+1BXOQLgM4L9slfVxYhp97ENJ0Jsx0o8+qsfadImFTdQEOuD8UoEQy?=
 =?us-ascii?Q?Jf6LiLmbqI49e9Bkdfpd3PECd8jjp0n76aC0mtH96l7sTahod/FXdcprWtiQ?=
 =?us-ascii?Q?WCERkX0MPhpOf5bqqg/mvLFgTSdnXFGb/GTuqnsobTWP+eLvaG9XgkwTUrfS?=
 =?us-ascii?Q?e8QM/CmdvQX+zNYx7QCUVT1rXgx2XguHJgRhTV3LocauqCOu5E7oLwBnpdbW?=
 =?us-ascii?Q?noPJiu6dDgZ4frBYidxnvV+RdlIrGLdzK1FxRACGXfJFabHYvGAqKhCCfhqm?=
 =?us-ascii?Q?llWSLgcWOfvMUwneXViejK/joCmJknuF9RpVgBD9DXYHmMdegEeXAyOIlslv?=
 =?us-ascii?Q?KSUu8Y6dj1zP0lciQc3ajFElNN1HZXyAXyDSfalpWRmUjU+0+ChMUs/L7aMH?=
 =?us-ascii?Q?+APQxIKQi5aYxqkZ4aUFT777s/76Onh8u4bJ4XGIvNcsd2A1wXUJbOTGmE/z?=
 =?us-ascii?Q?lN6Od87uux/tthlrJegb9zHg7pjld7+8ZDMRZyycsqVBGDGzKjLe2NdyAA1I?=
 =?us-ascii?Q?qyJ7nSk6GHPj8joZAAO1HYlujY5v/KLOe6h/n+8QhEsNdIgFJ1gdgHfsZb89?=
 =?us-ascii?Q?fWGSWEcryAcE4d2HVTXVYdmaVmpggXwI5Ba1TBmkntC1jg9kn7cTrWAVfMsv?=
 =?us-ascii?Q?DhXeTAFwe4CMAFdtghb9HBvuipp6Sp6K1+yYwk067EdaClh2L++rYJX+AT5J?=
 =?us-ascii?Q?hvs+5n/AHRyWcn+vcPFsNZWDYApylUIBTfv4o0sVY3kJZaUyeJLK9gbZYQcC?=
 =?us-ascii?Q?gjUfwBM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xdMRAXxtkykJxA+JBxym8ZF1cvfmYilYPK81cuxhO8jCX04xKLm9t4CcoonD?=
 =?us-ascii?Q?JG+jSj+rxmnALkZWwgiEssA6BXnCDBH1wNqv7OkzgJdBwm1G544+1oPOHE2Q?=
 =?us-ascii?Q?vP9tMIvBLtzpgnOi5iWRJVQVgD5SWwFfDVp5bS94lA3bcJT6KR3DUH4kLnnr?=
 =?us-ascii?Q?hstYGdv1QWf1B2IvgbafGo2LRaH9H91d8BIGI+xeymGMofymQCS84RwP3OCj?=
 =?us-ascii?Q?zf+zXr1OLVRkbq/9JWiV6kv3aLDMjDXuYn083V5uMxQOMZAW7/MH9wSVvWs9?=
 =?us-ascii?Q?IAI03If7wSyykB2Na18Rx/pn71EAbPKNTiAIspDGut7zOiM+fiR6iC4ZlT69?=
 =?us-ascii?Q?mGpBIke/FoM7acraN+q533gOAdksv9kfEOMIkH0+3Fg8FW0NzKQSXRqclwg5?=
 =?us-ascii?Q?zLgFNoSnua7HILiPv80Z+Hl6zLXx6mGFr9+DGyr6vmtA8tKYZISfOYMG9Vlc?=
 =?us-ascii?Q?f6EF1BKHOnoG+JpxrpxpoRZrgd2IjfeCmk3kFQwDqQ+srYCwZqyU+Dk9R9Ju?=
 =?us-ascii?Q?Ij/qk6Rl5pW7M8KLG/cojyUZ192kXujh/KPnKUQ3hlEdu4D20MdqA1+Ux2bl?=
 =?us-ascii?Q?ALMRRv1B87QYncub8Tu/ME0HhQ3bGJHVfzPSGy+kVeCpZiL53SXXfCBqSO5j?=
 =?us-ascii?Q?hChdrQIbfcJ5CewykXf5QrsCuqEvZ2dVd0zO2rou2xCG5Te6I2eydw0pzf0z?=
 =?us-ascii?Q?ZfeYDnYGJuNuYiUD1e84HY7g7bCk8/ToXy3GLtQUKxC6y1rvv8GT+NwJzzJN?=
 =?us-ascii?Q?9rVtBRRl6FMj2vsmzSGK1sHJR2UJ9B3vkoq83hJ+2PKXwffjEGEfDVPfRYic?=
 =?us-ascii?Q?EhKHK0G/mrXS0yIvWZwu5R/T5OydcRViBI66sCL+PucMWfSN8zNxB+wsIKoO?=
 =?us-ascii?Q?V41boD+rRN88gAahEJf51mdixgjt12wWhXfn1XLiY1lXRT+nCrLyN280v+7X?=
 =?us-ascii?Q?kzGS3Yzbs+e/xaDZWCanzJ2uqZxuWT2WWjt1+or6aqNqI2MNxTcAhP8gDrIk?=
 =?us-ascii?Q?97+qPoV0Ta+HVUrNsw55aNbdkOeMH2Xw6w0RADzps6D3ITqIFu19xXrUkkq0?=
 =?us-ascii?Q?HAq4bOTnPtpjLGa4QtRyOmV9+w+XbKoj31OJWR9iszyEoB8n9bDZ1qf+uGGF?=
 =?us-ascii?Q?TNJOiMeNDxAWnBIXorOBcaH+g/La/yy40psvH9E3C6P/KElZWR7lM0V3ivkO?=
 =?us-ascii?Q?6HiJFIHMhi2ifbIwDPLjaU5/gqC/CyOWBUNDLSIiVPML7fm/9iVHzDMaMMDD?=
 =?us-ascii?Q?jeKsTs5upn84lhuq14cEXrPEoJzHlEIZ7Uz1xQF/YtfRR3e1ClNQcJ3aEJbr?=
 =?us-ascii?Q?oBWx+JrNMZkYyxqn3YvxkehvYAhHEpRrsGo1LEuuoFV3cNkEsF/c/wd7JY7X?=
 =?us-ascii?Q?YRJkSOtnWdialfhH5Bh0x8noPjRwRhZPrCgWd3jJGj6V6zib5FY+TWHgObEz?=
 =?us-ascii?Q?YohKN/silXQre+ai3JMJzpTGROdo4CW3R4gybQWwerW7UE4udwPuqji8gw2B?=
 =?us-ascii?Q?S9m6RrZo7/J/oty59Pe/ofn/sYFuvLVugbRotseeWybK3+kBY8YiKR+a+HKM?=
 =?us-ascii?Q?UYnchNwxD9b2o45pcemShM8VG+1bg0g7MQjaRM1k?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d119cf9-33cc-4d7e-d249-08dc9fcd2356
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 04:10:59.1258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IkYUUvvfn2mLXOXSgd/tm01c8Obe2OjuHhy1jhOdz7K9n4q7ewjGzeNs0nXZHDF1uM1I3Dq2OJYOKAGPxdEnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6942

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

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---

Change log:
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

 mm/rmap.c   | 14 ++++++++++++++
 mm/vmscan.c |  7 ++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 88156deb46a6..55fd54c33582 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -877,6 +877,20 @@ static bool folio_referenced_one(struct folio *folio,
 			continue;
 		}
 
+		/*
+		 * Skip the non-shared anonymous folio mapped solely by
+		 * the single exiting process, and release it directly
+		 * in the process exiting.
+		 */
+		if ((!atomic_read(&vma->vm_mm->mm_users) ||
+			check_stable_address_space(vma->vm_mm)) &&
+			folio_test_swapbacked(folio) &&
+			!folio_likely_mapped_shared(folio)) {
+			pra->referenced = -1;
+			page_vma_mapped_walk_done(&pvmw);
+			return false;
+		}
+
 		if (pvmw.pte) {
 			if (lru_gen_enabled() &&
 			    pte_young(ptep_get(pvmw.pte))) {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 80f9a486cf27..f31068f799fe 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -863,7 +863,12 @@ static enum folio_references folio_check_references(struct folio *folio,
 	if (vm_flags & VM_LOCKED)
 		return FOLIOREF_ACTIVATE;
 
-	/* rmap lock contention: rotate */
+	/*
+	 * There are two cases to consider.
+	 * 1) Rmap lock contention: rotate.
+	 * 2) Skip the non-shared anonymous folio mapped solely by
+	 *    the single exiting process.
+	 */
 	if (referenced_ptes == -1)
 		return FOLIOREF_KEEP;
 
-- 
2.39.0


