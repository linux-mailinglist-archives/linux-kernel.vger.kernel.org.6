Return-Path: <linux-kernel+bounces-361999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EB199AFD5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73631F24AD3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDD4C133;
	Sat, 12 Oct 2024 01:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="SvliBjEM"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022091.outbound.protection.outlook.com [40.93.195.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E53C8CE
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 01:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728695842; cv=fail; b=X31yxiJQT4AO18YaRjcWDu41gqfF9rLsZn40vc2lQQCtw43FCenpycjh8j7aLaBnT+zzOwC3LLZnj9SQNWwmzGWLsPpnJJhUF+SZNE8TPSw1AWnelyUMD6hEUU6TOPO/bu/14p7+uq8ygevBQt7p+sT4ttsUxDXpbrXBEbVJ3/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728695842; c=relaxed/simple;
	bh=fxyvgbCWFLNp+oGLR3k1GShksak5oIforbMNi3QUp4s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VXiFTYzCmdyVXA5yuF935gSwdw8Jv3NvGW+f7vIL+W4akW7hx50fDOQYpYnUOkObAbSpN3zSGAjpui2Fe/yFTDubVq+nWO9hzblzCK6zOhNlvOAmGSDibUp1jjCgqtf01ZCQAcR99zdnOMy/9HJlStenboAtzd7aLHmfzSBF0hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=SvliBjEM; arc=fail smtp.client-ip=40.93.195.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8fIkXNd+HmMDDM5pRhaBxhHr4f0osMWhaJuCUls1y9g3zg6C0AtfFKKFKhWkrbQhgSlkTpvsdm+i+udn4meCbAxluCHqUDeJcV67zGZK0OzT00Vk5XjJArE1twGBo80pQMOoPeFCSFTwKQQNHwv/Yxt//TiuUDfM9HukSiO+VbN2vEfe8lnF48T1pzPANORYoKjM5YdluSS9py17Od3lJSdnoiIGakUe5QCJpm2zKNbnXCzIGmXOjzsYRKfbKuHwCqQZpcILYeqgxPw4T8WeC6d0ev+heLXABkiBuRDdWPhiLh/KCICcO9Yxzj+siRpukBGxxFJ7lc7Vm2lDZ0uhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4X0o8iGl1l9Z7eG/Hruc66iObLqhFzBNEY4JGlQn7xA=;
 b=qvMqzrmCwGgqwdmc2wpe+GbZpDDGSjG7GBreODBU9Ix6XkvrKSR7EEwtxJMR3z29mABxp5VmGJKDcARUUPlzsOht1PGEPysMLlIGvjYhlpyinbpXYPKUZrUunek4NV4yialLnIgobM40HI2uVk4jn2L8Dzh77OhrMsZ89g+qoSNv+Xa3ZF2M0ycsCD70Yzr07smONtrHquf59cRxTTdw/46JAZVF1Q6Pwlz2AWKOi/fu0p/SLl/ovAzvoH7pWzB4exWxNomtmGwvjly3mHRfp6Wk8pWJSqZr00L+n6oqbE23FT4mAT1MUQ/IWYqSmw3/v2Tgr5ZZr5J2LHrdGj736g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4X0o8iGl1l9Z7eG/Hruc66iObLqhFzBNEY4JGlQn7xA=;
 b=SvliBjEM9pVfh3H51nGg7nRSSPvVsUeCn2nSB30tYWP1B8lh5TOCYhot325DYq8NL8iFHbL61Qe118E9efrEhxsd5jpe2Rq5ebgm23wLcDmswFMiXgPHnInuLatA3OahdaVl5U2WmchtgfM1FucQjSejhmkJG1beITbHLhAUFTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA3PR01MB8040.prod.exchangelabs.com (2603:10b6:806:313::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Sat, 12 Oct 2024 01:17:17 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.033; Sat, 12 Oct 2024
 01:17:16 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: gautammenghani201@gmail.com,
	rostedt@goodmis.org,
	akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: khugepaged: fix the arguments order in khugepaged_collapse_file trace point
Date: Fri, 11 Oct 2024 18:17:02 -0700
Message-ID: <20241012011702.1084846-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0438.namprd03.prod.outlook.com
 (2603:10b6:610:10e::14) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA3PR01MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: db866fc9-163a-4fd0-9877-08dcea5b9c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DVHfsJxVW7vAoyncAFFeaRgUrTU0OBJYlgWtp6srwFV1cMUG63MtJw9FRW2Y?=
 =?us-ascii?Q?VrFD64dOVy1ZZosxjyD+pxxbMjH5+IBdeHtKp+4swYkZ+wjugFnHqpzUQi4A?=
 =?us-ascii?Q?f+87q14wDxdCtC3e7m6m3WpcSrInh00gU10g6kSuKtUN8iZ/uMKrqxhwRKzR?=
 =?us-ascii?Q?FodPXuxnMiQu/ScNgOi2XGGBywxtf8vbcTK6/mEehJfanNT4yHDx1446aY6s?=
 =?us-ascii?Q?ayKWbn4IlCmPCpv1zzjyndFtMdBcrWlFKpWQCwmHHNejU5KNGroMb5pwFeuU?=
 =?us-ascii?Q?/Aygi2eNcyrnbnLncyMURMWtg/P/yOUtI+7MVQ9oN2cV7zKwTP/cgYb5lA/J?=
 =?us-ascii?Q?Hy1NlQ0FMP/juf4MFwcas8Uv7OeFGK3ZzTt3s/fCJNwc2HfWiWVFwEowEu8t?=
 =?us-ascii?Q?k++bq1WIGl7ZBuNcZ0lRsw/PCalEfCp26YNFtpyXLlpVASV1iO4U9s0UHzVS?=
 =?us-ascii?Q?exf28f3nIG1v0OUjDBUmoiAdcbt6Yl3c+I0fdSAywClZDocQ4t+h2mK92W7p?=
 =?us-ascii?Q?BfZ5hdor4U3H5wiMGpV2gT5FmlJv+KqOCWnQsY0QeYsNaO5ZHLIcZRD2tN9Q?=
 =?us-ascii?Q?RmGk28y+6GCZ6oxNJxFRymhn3iyPc96eUFpZKZpkLgmaQe3tSWPuqLhHhOE0?=
 =?us-ascii?Q?dwxtU/rxExufYbppMXKAjdGF894cVVdG0UfbSsDxgbDLvK9O+NOD5VTlqBKR?=
 =?us-ascii?Q?tVT7uPOENZJbWTt7jMAd5m8jvjnx6Srnd5rJxVLlfPyeI+GxvKs7QAxrxRMy?=
 =?us-ascii?Q?Xw4gfhk4IgRdoSixF4WEk/WPtUAWiGWbvHd62QF4HTTJpH9q5AukPIFc5YH1?=
 =?us-ascii?Q?CPNeK0l+InQiz92MXmKLjGyJcjbg7OHz/6zqR3qZSpeqg3UWvAX0hS8zK/vu?=
 =?us-ascii?Q?RmoYwVxUqseSbzOT/5J0Zy6rXylL2VuRcr/N9BRGQ13THkgdC12XTVjcX/Ib?=
 =?us-ascii?Q?bRjhN2js5hcgHoSb8AUFtHgswN9l3kRfNAAlXVN6hQfXn9GashWdnywCTS8+?=
 =?us-ascii?Q?GiH/TiH0XVX2uYgUXuJaLRXMXzl49jWzLgtBrWIkxr3VxpPbrYw2IKk/vuSX?=
 =?us-ascii?Q?2Dgesh8gVQpltkz30xutVbGlufIBOT3VPneAgAujV+o5UQBL92qT5gvyfsqe?=
 =?us-ascii?Q?p7G6NMcgFQWjFLuHPTS7hFusG66yR+ixqPY+cl7Nbml7xb73tyY4G8jQcuoD?=
 =?us-ascii?Q?nELlU7Jv3vmvGSy0ftCcYL8SMRuGpEOtfRaXz4HthEHFx7Kg7JNiUWfbS+/3?=
 =?us-ascii?Q?JcaAE6XEwsZg9YzWnSlAUEuDNdnfVcuE7IlVHXWhVjTfcWAGpv2pX9YwOaQq?=
 =?us-ascii?Q?r5Og1IBLHTojj6ZKmkerjjpHJFAPhB1m6N7qaRZVjaU1vQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7v5czzLiogTYFxVer4a1MnhCxc74nEtfl2beD9dd1H6PhvRt/qwwDWa1+Eh0?=
 =?us-ascii?Q?uYvboehu7fwOCavAHMhFXF/8yQe4YC0C3/hqZlqCwDo/7nklw7OFYD6CGYcw?=
 =?us-ascii?Q?vcwI2fp0EhNnrnMx045T3i3RJeFQH9QyTRXY1J75sS+gVichg5dfaXz24Zq2?=
 =?us-ascii?Q?X4QyXSTYjftAvH22FYpAQ38G6L0kxpHgI9HIq0CcLkbUjy0G1R16yQsveiYW?=
 =?us-ascii?Q?uUn2CLh0hil9BSi89Dre4gENn5p+nWx79gNekSveM6IftdMmZHa/3/qWabwB?=
 =?us-ascii?Q?9lRfnFsfO67EpiQeN7pPnmpxDfMVpQXHMkCO6RcEBX5emd7VixFqfuYm6AGt?=
 =?us-ascii?Q?7oL5T/Vm+bI+KoHsFOqTZu3BpnugBI/agcVl7x/i4jxBq0U/CcprbMIY8qhv?=
 =?us-ascii?Q?k6YYmr670uGk5+s/vsqQXgbYdceJBMjr7vPIYJRcpOAZulPnJo66mFSm4HXE?=
 =?us-ascii?Q?tDGjg/IUqeow6vTPtTnJ9oJPmPzAUGnEBrQVveXQ19VHk5EvoXIo0ABkALhC?=
 =?us-ascii?Q?1qCc5jvHYmRVwQNuMu8s2QJl+BhatJI0mcBO5s5FlcU1As3TpTnRrCvkpB0L?=
 =?us-ascii?Q?X35Nb/E+aHJrHR++eVGsF6o0NoGO36rUwKgqU0MXdgibT20QerX6YkBj9C47?=
 =?us-ascii?Q?K1niRltvKNmnCpjtdgmAbsscPUoEkJtY0rzucUS9blkAsGdLbgiSOJRWb2Mo?=
 =?us-ascii?Q?waTELF8ZC+IZLPdupEndukP9SgXsKZdHIecp3BOAnnohaXL20tH0izfBYGdt?=
 =?us-ascii?Q?ssnTMdnBnJYZlx8FaA/dPov1ghk4R0XfSy00EV2dNCbIifDzKjXvMsB1pv4r?=
 =?us-ascii?Q?DIx+uwt2NTNx77gIhMQ8qljQqmt+lLcLeBwtTIUbeHhhNp0E1/z4gLTrI2o7?=
 =?us-ascii?Q?mHj7l3W/AHQe4AH7yNglUXrea1rSyaPm2R1+mEs7lTYMIK1R4GanY7lv8szo?=
 =?us-ascii?Q?yi2O7W01B8SoiaqKpgZCY9iLOwKv0qojW2h+MgfYHljGUd3Wlt95V1mTkrhw?=
 =?us-ascii?Q?vZSWrC2vOu64nP0KSzU0I0cKlfbpRx82OoiWj3QyWfl+NhCXD7RT0GIwmeAy?=
 =?us-ascii?Q?cgDOiRkx5u+KdYBoRJ8BxhDw5IK0RIgczXsPaf/w6j28Z1dSUANcAoLGXB8p?=
 =?us-ascii?Q?d1vUx6U1KjfDf+rGVfv9b9e5EjGcXNBCRqH16Kc36XNZWlYSJe4NVvj2hMhW?=
 =?us-ascii?Q?VHuvz7RFFQwRXc7aYRmz27HvRVYemk4bweNmgula3dpD2q8AQsq0svqk03SM?=
 =?us-ascii?Q?0/jJuacup5n6M2QFSQtheO2kHJCan6ZBYeFZDVNCThgBl4go1zTxf4QSdYam?=
 =?us-ascii?Q?vfc1TAyZBCYoEuWUJ1rsZB0c75dtiRgdHtHc6/jB+frEY2lso98T0hBQHueT?=
 =?us-ascii?Q?XsprQn0LDPiEeOIrKheQV6Ycs/sQrraFtzfG6v8BKyaC6tWhSXkIqpRto8hR?=
 =?us-ascii?Q?f+hVhaj9H7wYx4MikZOQPZ6vx894IKukRo6s7N7Dgpm6farJEEfPPY+PKmBf?=
 =?us-ascii?Q?tPnRWZX6Gellzcp1qimo4gg3NspzsJmF22ematzGfl2Awp/SI3MdXESV8vz7?=
 =?us-ascii?Q?Ri6h0KJlirE5SONuSU1FOi431xZnezv1ZO/u6vIKsMYkyZwDhMUIGgSRGFNR?=
 =?us-ascii?Q?Fn8L8grkWz0FdmIJTEIQiHM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db866fc9-163a-4fd0-9877-08dcea5b9c1d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 01:17:16.4670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80qN0h2lxqnuN1yxiryJGQbGIRHsJJFGX/4eVYU+t8o/afDq6NoAIp1ajc2AQQZucmefd82aNkltFiEfafySdzes+9bbQUXGfvYzBWrOFq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB8040

The "addr" and "is_shmem" arguments have different order in TP_PROTO and
TP_ARGS.  This resulted in the incorrect trace result:

text-hugepage-644429 [276] 392092.878683: mm_khugepaged_collapse_file:
mm=0xffff20025d52c440, hpage_pfn=0x200678c00, index=512, addr=1, is_shmem=0,
filename=text-hugepage, nr=512, result=failed

The value of "addr" is wrong because it was treated as bool value, the
type of is_shmem.

Fix the order in TP_PROTO to keep "addr" is before "is_shmem" since the
original patch review suggested this order to achieve best packing.

And use "lx" for "addr" instead of "ld" in TP_printk because address is
typically shown in hex.

After the fix, the trace result looks correct:

text-hugepage-7291  [004]   128.627251: mm_khugepaged_collapse_file:
mm=0xffff0001328f9500, hpage_pfn=0x20016ea00, index=512, addr=0x400000,
is_shmem=0, filename=text-hugepage, nr=512, result=failed

Fixes: 4c9473e87e75 ("mm/khugepaged: add tracepoint to collapse_file()")
Cc: <stable@vger.kernel.org>    [6.2+]
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 include/trace/events/huge_memory.h | 4 ++--
 mm/khugepaged.c                    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index b5f5369b6300..9d5c00b0285c 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -208,7 +208,7 @@ TRACE_EVENT(mm_khugepaged_scan_file,
 
 TRACE_EVENT(mm_khugepaged_collapse_file,
 	TP_PROTO(struct mm_struct *mm, struct folio *new_folio, pgoff_t index,
-			bool is_shmem, unsigned long addr, struct file *file,
+			unsigned long addr, bool is_shmem, struct file *file,
 			int nr, int result),
 	TP_ARGS(mm, new_folio, index, addr, is_shmem, file, nr, result),
 	TP_STRUCT__entry(
@@ -233,7 +233,7 @@ TRACE_EVENT(mm_khugepaged_collapse_file,
 		__entry->result = result;
 	),
 
-	TP_printk("mm=%p, hpage_pfn=0x%lx, index=%ld, addr=%ld, is_shmem=%d, filename=%s, nr=%d, result=%s",
+	TP_printk("mm=%p, hpage_pfn=0x%lx, index=%ld, addr=%lx, is_shmem=%d, filename=%s, nr=%d, result=%s",
 		__entry->mm,
 		__entry->hpfn,
 		__entry->index,
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f9c39898eaff..a420eff92011 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2227,7 +2227,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	folio_put(new_folio);
 out:
 	VM_BUG_ON(!list_empty(&pagelist));
-	trace_mm_khugepaged_collapse_file(mm, new_folio, index, is_shmem, addr, file, HPAGE_PMD_NR, result);
+	trace_mm_khugepaged_collapse_file(mm, new_folio, index, addr, is_shmem, file, HPAGE_PMD_NR, result);
 	return result;
 }
 
-- 
2.41.0


