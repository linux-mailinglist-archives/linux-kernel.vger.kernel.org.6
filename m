Return-Path: <linux-kernel+bounces-543797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313DEA4DA01
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872C53A4425
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2081FCFC2;
	Tue,  4 Mar 2025 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="kDssL4N8"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020126.outbound.protection.outlook.com [52.101.193.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E431F8720
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083573; cv=fail; b=qkTNIl85G45M3es93wwkaa5bQVKaBJKGthR8eZkfkjiQYlt+lrbHAthuVzlFdvZZK/aHLEVqWwTAvyIK353tz/DnVYFV2wXVjokK8jgE/tUFN2EXYV6WGHlHvMGK15a+UTn7YOhgdqyA1Wbtb3cqUY5V7w2IcuxHGbWk7MPB0l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083573; c=relaxed/simple;
	bh=CvgprK6Azr97e+/ug+CS97a1FuTe/kwYwSfFn8/kqbI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KeAwdTHjbtLv4/5kUrOU6QI+aWCFm9CziPv7APbAY7YUAX9iz35QM6A8Q8/UFwOADhifim00bc9KX3MDbrjs+Z6p9SrzL3boG0Z6R51dyQIBo0FffKhrsjA8DJJ8sNoHt5kjikKsE6BjIt8ucsiZ3qMop95ACBq6CGwKY7m/IUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=kDssL4N8; arc=fail smtp.client-ip=52.101.193.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojMpafBStb8puH8mpDcvnRPB0evDPPTtN12xjBjIdOTX/6xIHVT+TgsozjNKL50uEnH55FDKIrfxAVHhmrk0CvnZemQEUcOwdqH2IZoi/46kdXHmFhLaPPXiFkdxVYzxUXDpqdMGqGE5b32lUXSOMVbsO7m6t4Im3BpB2fViGJUBsLHEmggBdN+ZwFCXe4+XH43cOe/jYbiNSrdiQiOR3QjROTEl8+/XyCt5umr+fN9EzMb+P5VirBiFf5G730/EFrNm7RQpgVe6rSZvSpn/DIb6VqemAdUF6HsuWnGeg4VCM0/9zCQMXggYhuh2+9ISylOpi2QWC48f7vX+McCK7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCeFzyriY26j96qACozwoZVBtZVGdvcE2m48fXxpZME=;
 b=XToDkVwokYJ9y92M9HsNxFomE+TF8f4Pi3wJzFqsjggF0oOVD6+evasHh5t72fxJcawtzjNvQNfxFygrQuk+WaCBvcehASgWhPPOsx3gWCNvAvxBJro3CyZyZNuA0RswJ/+BEaVks6soZHxE83v6yeR+glOXQ9UYT0iihTdtTTea9JbCNGO/8dDE1LoayNacu2rgwiYffWUOwVmqC8Kcorl3BHc83IXOxlygH3zvPMSJGh+Pz/sWESKvB8KktJVl0dJY+vBbFIUUkaRBCVvWGp3zgX+/4rOTsxUES+2dxDr2v1kBTQaRdDYcLTASaLYs0/0/DGMLfUWCk3euNptnFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCeFzyriY26j96qACozwoZVBtZVGdvcE2m48fXxpZME=;
 b=kDssL4N873/tIevPtOkaKrfqNpvgqiC93Npr6x/BYXTdbiCLBP5Tfa8v218mocYvNBO/loPxHt5taY3BdNum46De+WxH+Bp0+3/QWwix1UED4yer1Kdj+M+r3WlBO+1rsPCNZAiQPCTKK+RuOxzZ/oF4N1eQu3Cpwd7tOAek4SE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 SA1PR01MB8088.prod.exchangelabs.com (2603:10b6:806:330::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.28; Tue, 4 Mar 2025 10:19:26 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 10:19:25 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: rostedt@goodmis.org
Cc: patches@amperecomputing.com,
	cl@linux.com,
	yang@os.amperecomputing.com,
	mathieu.desnoyers@efficios.com,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	linux-kernel@vger.kernel.org,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH] tracepoint: Print the function symbol when tracepoint_debug is set
Date: Tue,  4 Mar 2025 18:18:43 +0800
Message-Id: <20250304101843.12562-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::11) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|SA1PR01MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 96175f27-aa6d-486f-511e-08dd5b0609d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QbhvKTuex3gfPlR/2qBJyRNe34k8bQSGAWWNYzMhFpZ5zuKfSrPWuFlwsdbc?=
 =?us-ascii?Q?zYr5IoOqyYdBMRWejtn0r1ySuoxFW/+fFi/+SJwUc5+/zTURTHAHsZbBi0BU?=
 =?us-ascii?Q?yL/n8jgv5GjXQtb9143GGX3OQpxETj1Jgm2slO7uPybcVdb4/5vRN8csw2MG?=
 =?us-ascii?Q?pIe/RqEMoVO9y7yFhPJEqVM4wzznshdRCQbJ5G4ojDlXXjWEX1hvmYDoAdGs?=
 =?us-ascii?Q?/npUVXkMIV5G0YulXClOZ6PeVh9zgl1pOyoSx3TYKxZmUk/mXCwYSPsfpP7z?=
 =?us-ascii?Q?Rg/5BC2nOPy1DHRHuowxJlBbF4uOsen+VDryq+/KYNUBxbmgMEULBw4iOzuG?=
 =?us-ascii?Q?bd9FSlmSk0Nyr3mDtpTjlrT/5/4zq73Ez+0dGzF7UGkNUNeRR4+vFpwVye89?=
 =?us-ascii?Q?xgsjoytY8zsj3f7Ggc5W/JrqTypBK76HXY9MgnKFbR/9CXOI3ShjjbdCTDZY?=
 =?us-ascii?Q?bLgPoAQtEkn9p5eCzg6C6lgL3iHJM4wNOPJVc6GtZYXZ4stuhIw9BdjxQWND?=
 =?us-ascii?Q?DbO8ntsbUPEJ0xO2JoTHagARJo+BCFZzPghF4IIwckWG4A6QW8POnthEXAR/?=
 =?us-ascii?Q?6ccQoD6KHOR7aZosE0F2JBD2nvdhEniRlACVNKAc+F5smw1yqst6aTVp9xun?=
 =?us-ascii?Q?BLSnz0eojDxP8CVut0rjRP4bQC8qqxySk9sbspaiGTDvqPQzZLjXZhHm6vvF?=
 =?us-ascii?Q?kXcyrfFkY8b6IzQbuEahQopYySClPufTUaoKH7blfu1RSuylA1vSb0oZND9N?=
 =?us-ascii?Q?IcTWTY8CTN3vi0JHnf/iq8kBErT0WMivESNl26zVIMM6W1jz/8cwg4pSXnMW?=
 =?us-ascii?Q?17w4mcs9siTOijEm9sOfF0/L+26h/xX09ZvOnKOHL1OpT9Y2wvcy95FcxPCv?=
 =?us-ascii?Q?Vsp733OL40Oh+NRImxkmOB7pa0JV1wGln6ufWH9EF1xUUQX+K45cy5oaQF9v?=
 =?us-ascii?Q?DDfwnvWqwUoVNdzbIy1omRCVpLbB3K6A11b1AVLrRxe2Jv9jVEZ9XQm3jyWC?=
 =?us-ascii?Q?aCG7M7PaFr9FE0T5xV8QlIzVdVu2pv0jf28Q+DLhZCyB4UCQKstI0r/yD9E8?=
 =?us-ascii?Q?buM965TCze1p/7ZVq4e2rheCdBaiA9u1uBOZ3RSW8RIryioFBKao4NKBdCDI?=
 =?us-ascii?Q?9SpfWj6tjBqeGi2eTFE9rrOPOJuGZr+vVbcNStJ+Q2TrZWe9cJH71YBYP9Dl?=
 =?us-ascii?Q?jD3Z4pnrQ57NO1Kfjaa4APPL1jZN6hjUBBo7eNLQOeKXoSiIbdQzYo9JB4aI?=
 =?us-ascii?Q?UFLbDUlLM7SmqIzdGwvScD8fp//qsUx5wjb7LYFKBAJuKdS/tUud9UcUSE7d?=
 =?us-ascii?Q?MnR/iGufUPMVdOe2Wl/CJoIP3Ocip2IBcGfPcNcL0Otpn5cIGMB+w13BKhHg?=
 =?us-ascii?Q?JsyCUAIvQLDsSK0jFMZHiAPjpoUMekYGEencC1HWXEQmSHnbNzVG2JYhuEqX?=
 =?us-ascii?Q?/cpnyJYrrjg7OVWMWCUL8kd7I9RzRAz3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x3cItzB7UAWbFfEYa1jwOlKmoj5aQkAP5NXNT6hkGyqwnXNVQNF6g/EIoNsS?=
 =?us-ascii?Q?mfmeHdhof+z8OlWDIYkfahK6iG2XqItvQAEcHlTLiE5Z8QfXuAK5nHQev/+y?=
 =?us-ascii?Q?tgVMYYSQwk7RPmKUzBFfmBNDFYzuw5ec/x2FIojldgJ1uPmPRPpMb0l68GJD?=
 =?us-ascii?Q?yB5UqTWX7eyMBlEgjRzRSbzU7RdDTHcq0DpHqnW57rblqDsuZ0BMWPjFoY7W?=
 =?us-ascii?Q?mdKpZmTtcwlDX95OmruHBasS1IMJGZGkpUrK2b15VxsUJH83RckfImDv2axg?=
 =?us-ascii?Q?fcsjEPSpmD3LzihISNntytunUrCMqG/+bTWhq0m73ckJJ+v1hFpKncx+MmvV?=
 =?us-ascii?Q?FcsdVj1CqcElS1Ck3aOOFBQoo6ttLNNAj+IbyrkmuZsC4k3AHhRuF/UBz0de?=
 =?us-ascii?Q?EdBclvkx+6c/fH0MyN/j0i2oikQ+IsWzyWT2Ue8IRq1vfpMlMYgwvIVXdYwG?=
 =?us-ascii?Q?jVdA4566Gtdee3KtC7n0DUiQ1mP/lWfDtCyNCVF3OzNnDv8FHFs7Wf+77Bfj?=
 =?us-ascii?Q?OEIBy4LvkXWFlKS777Th1po20872I0JKgjSsaelN9pj+2uM1SykXnpnodaU5?=
 =?us-ascii?Q?F5lpc4z2gp93cWFzvlB2BvupOPgXziqEc4UWqPzz+RuH4JpYgeLCFpWMEyis?=
 =?us-ascii?Q?GL5lTwTRYGDwRwLILNZEKEM3G4JA1SdpJOdWGdiZawKP9rOs0aLsIuYFz3VE?=
 =?us-ascii?Q?x5Dz6wKcA9IO0XPVG/LcMJFRTCu0zJKlfmfWiXzab3RMFjGcubZxT+RWCEdy?=
 =?us-ascii?Q?MyhKaaB17xMTzBf6HI0NPW50hKoK1wSMItQDXcipNPV4BFTHHnPsjeyFAWpA?=
 =?us-ascii?Q?X/vOpAPCVrfr1BzdNMCktpaUMEaLyV59vMO9OTYmLLV0UekMiWt+lpS/CPqs?=
 =?us-ascii?Q?6RdMbTYPT3nofb0f5yxRKat8cK0f0qWOclLr2tboYnQBBJgnlribcuGHvUfJ?=
 =?us-ascii?Q?hQYvPkuvO/g5zlAfWm6Lx/bNYnuHPy2Whg6s1SizPBVIHnjocImd8/6zBlPw?=
 =?us-ascii?Q?HkqaCvBea6PnoS4vS6id8cYtZ+3AKZblvTDfn/KsiSuYEazPtIsZdWBULsrf?=
 =?us-ascii?Q?zWTyAu0ML1NyaAqff8k8PaVQAoJpx42KFo1ovKVFr4T6Ao7av9S75yVEHVBV?=
 =?us-ascii?Q?3Lm9+2roybYQFcn08oQTbQ34i/dwRAOwEsthCYHj/w0/n08aw0mCpcV/DVQx?=
 =?us-ascii?Q?6AtVyTqkn+o1flqZf7p3ruOI8Yugv1xN5I+ju3VS8AJbxdOv3lF+wzAXvDjw?=
 =?us-ascii?Q?HVzAavCtWLJi393o3jiX2px7NSuKrAO0JD1zZf5UtIu5+xTYYef8xCdpyIku?=
 =?us-ascii?Q?Podtk5MbY+SAFXW56OVl1vI6DORf4tG9NM2J0kSarzMqc3O7tfixUz2TwSB0?=
 =?us-ascii?Q?5jTpL4+CecPQCeGBqf72hNWs6eqLuIQscLXf4nIQFa1zWtXjnnv/Wjiav2qM?=
 =?us-ascii?Q?MFhMlcvNUK3Ax6bDKKRnoBlbaGvnWgoGzAB4Ji37zqyQguBuiWXwUywoy6DB?=
 =?us-ascii?Q?0CKpRtNTi5ttfRSLnwceRRqWc2/7Uc2hPUXnKYwGBKUuPQTIsQ8BXvTBZ1Vh?=
 =?us-ascii?Q?IK5jydgqJeXQ7gRTIizPwcgcHyb5BINLsPMhHS840ZKBTA0/ySO6tZG/zt8/?=
 =?us-ascii?Q?6ZyniTF4qx9kOgI2f5dzHoA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96175f27-aa6d-486f-511e-08dd5b0609d2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 10:19:25.4351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwzZRPTXp567644mssKGnUh5P1r56BU8pPqZsp4G6wcglcn6EFDJo109/25fg6sG+VfgMnr0qSqbZMRwE5hUdJCw7bPqj7FT4rZzwZVSyhB2/oOFX/tQ8HlA95ae17wa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8088

When tracepoint_debug is set, we may get the output in kernel log:
     [  380.013843] Probe 0 : 00000000f0d68cda

It is not readable, so change to print the function symbol.
After this patch, the output may becomes:
     [   54.930567] Probe 0 : perf_trace_sched_wakeup_template

Reviewed-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 kernel/tracepoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 1848ce7e2976..82bef4b9400a 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -127,7 +127,7 @@ static void debug_print_probes(struct tracepoint_func *funcs)
 		return;
 
 	for (i = 0; funcs[i].func; i++)
-		printk(KERN_DEBUG "Probe %d : %p\n", i, funcs[i].func);
+		printk(KERN_DEBUG "Probe %d : %ps\n", i, funcs[i].func);
 }
 
 static struct tracepoint_func *
-- 
2.40.1


