Return-Path: <linux-kernel+bounces-409609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 852399C9092
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B212B3D515
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A622D05D;
	Thu, 14 Nov 2024 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="DHzAChuh";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="TmRZk+/Q"
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56765149C7D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600499; cv=fail; b=LHO6yNnXo+vsDZ8Mt6nHf6uEBHeAB2CyQS4tHn5uXCDKex9thYtmj/hcoXSIUGUktXs4O9yfPmhiF9XhUAQiKCtZ3TbAxjR45g//Anp0APKu8C4RSSsxl0v+kzXlTTUEzKaasrQYizKs2Xui/w0qqUfddLaLhwHE1Ir76RUNNDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600499; c=relaxed/simple;
	bh=6XlKeR7mkX9jgBYRYD7v1LzxKXZZyGoe9YJa+TW7/WU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Rei0ZYMA06YGMMV+GcHbadeT2Re9eanRQSWIvKYdS0mHPJ4aOUV04oxGlHMwwpUkEGdSYzGL/booa0UDZtSSxl1b+EHL0otMTdDnhTbMiMEvenszIdZnCwuCIndGr7Datcy7aJsTU3MTWuUgqXK9NWVdE2sDFlhwAzz0fz2Dp64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=DHzAChuh; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=TmRZk+/Q; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AECMbeN014262;
	Thu, 14 Nov 2024 08:01:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=vB7cg2tC1GmcK
	d6BdMiKx/TRVzxDEaoLzOBIW+oG+Xw=; b=DHzAChuhX69o3Lkop30Usu3POGS/2
	ZE5cEdUWclEP94n3Xg9sJA1GrPbBWzxsbRLcOGR8cGF/U269w6+LLZbgnR7wdS1/
	KTrt7SM1xOJdmwZnZ7DqyJ6K9yJPlj1hx25o4cv3/4B/sXxa1vVdHEy3NWFdpCbn
	80D63f3vY3uecekUHoyBnHOtRrtjkHtn20wnt+bHFQCokh2nuSMsMJCrCPSVmo6Q
	atYiMKI3fuMybS4wBEk8WsOl6tAxHCgY0oQKUuYtbiKKjFXvchZMI7Z0D2SvFZ0Z
	bqH0lOqLAXB+BLmTs/huSUyPR+GTq9CwFT7sqRNOuJZydFP2e5SG318zg==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012038.outbound.protection.outlook.com [40.93.1.38])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 42t7xf56b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 08:01:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ls8rK3P9vEFfK/7zqx8wkcBLBPTr++d/nSDafp0+d1uW9EGe8vvqEbfgkCnaGY1NqBYYUosO1GC0w4/dGG8KA/Y+v/gUB1UHzKVx+4EGAp+eFW3TiXhNUTcg+m5Os7AgGgYDyuk6jWvurOYRT6BossR4w/g8UGj/LUPNqkG8V3A5Y0Q4+eTUN8fcDBccGk0nqMczZ4UPh0Z4J+XkpsKQ8xCQV9qPDb4SvWrtYAagn2DBzN2PnsjYH2hKTuqenY4Idd28cj1G4M/w+x9qqPqpnxha2wWE/dzXWTO0IsHEvPVmi1zP5Qxzzo+CYJ6ZSC18EYPH9nOcQmEIV9uyEdPUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vB7cg2tC1GmcKd6BdMiKx/TRVzxDEaoLzOBIW+oG+Xw=;
 b=dLSIijlE+I3935u1zWRUvN4FihLtz78aJZ+bln1Q1jKXvTZZobN93GwBghiLQ6+b8PMMzyHq9o1exW9vpbfaBecD7R6+edSyi2fyNt1KRURv5VEr/anmuw8GQhWPqN4PnYMzFILiACuBCD7ZM0d4ojWhlSSp5LHTjLJlZn0Eo9OsWOD+LGNokY7kmC7xWJLZ7doIEGiSzLQoYvQ+NQD0Ol6PjyuSn1F8NAMlEFbknPP8t993cA60K/1qmXR0GwMe4gx52Z3A22EWU/DomIkcxP++zSDfq3S7h6eCUoRU3dMJeluliScnXzJp9PQ4SZpFIvcQih0aqPM3u+8i+10YuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vB7cg2tC1GmcKd6BdMiKx/TRVzxDEaoLzOBIW+oG+Xw=;
 b=TmRZk+/QvsVF58asqzQ2JIscSZYVMOTFZPR3COzi7DxZIvpo3VqTrV8R/Wa6EWBZwbJA85VQLfS4V+U70l8nuqUNSo5NJrguwB39VTBXS0dOq+Bm/lYlAt9MQFSNnwVyD4Tv6K/aXUveSi/JbVIMwYg2WSmossq889FU6cjgDexjd1PPfbYgVGJmM7ytRMST7FcUpTdQlIgCY3hsmGrka+RHsSp07V1yMFq6ispXxHSLCh0+9Gj4AHgu737dxEAxehOiHvnGfRntT8P0g7I+ESCIGAX1TcnIZO6//GhstqzLn30nJvfqYP/v9DlmWvVlZr/Kaw9zFb6Tatl5q1FIzA==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by BY5PR02MB6535.namprd02.prod.outlook.com
 (2603:10b6:a03:1da::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Thu, 14 Nov
 2024 16:01:02 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 16:01:02 +0000
From: Jon Kohler <jon@nutanix.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH] sched: add READ_ONCE to task_on_rq_queued
Date: Thu, 14 Nov 2024 09:21:28 -0700
Message-ID: <20241114162128.1818680-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:208:32b::31) To LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR02MB10287:EE_|BY5PR02MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e951f74-abf4-442c-d10e-08dd04c589c2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?abXzFmlMnopQQMW58wuaz/MHP9vyJXsJt9AClIyxez7Ldj6WTL0e+tVEV6O3?=
 =?us-ascii?Q?5lGvIO+WvS8WbcqxGsawDJZoSllLScUlFEvDe8hl3Ez+GkwGuiKu0UvbiBxc?=
 =?us-ascii?Q?KWFwgwTo213N6FOOqeOFskV1xKvMmt4M4GLmE9nfsFl5tOA/IPiIJDAR4ozK?=
 =?us-ascii?Q?c0X8Kk5x5BSDteNCdRFpeXJuJ/fpJUt1gDjOzIp0Wml38jYKrNWQ06CC1Ihl?=
 =?us-ascii?Q?A64meh89DbQ3DnONbnBbLOX3lUsXJzHPNKCXNa4cspdGchfaOhlZ7/+5M88o?=
 =?us-ascii?Q?jXfzoRP9J+N00E9BqsHp1MLPkGT27M5R6i1OlepPM7nUjpAz/VJyIyKmoLwe?=
 =?us-ascii?Q?5Dr96ZsKPNVIak/OjGqcezLOU1XHHihx0uUiwq5JaWNAF2Nek2fu2s+qA1x4?=
 =?us-ascii?Q?Ua0O0W1X64zwgn0mW5ew4cJ8cNNfaIk1BOvap6LN7FF1xtvnlLDVTFuXqh7g?=
 =?us-ascii?Q?2n4i6vfsDzyRoC3WUGDzE7xBsgZuFTL8FmxAsemSZKPNZlhllSzTDu4Nal+h?=
 =?us-ascii?Q?YESZbcbGoDsJTKJStSXy8qEiN7RCqmCwL75zVL+3Qpac598xYFSk/HKSLVvp?=
 =?us-ascii?Q?GVZbc9XMak57wmaSyHkIQY3lLGBuNbflN6sBIOtHrx+yd8d/CP7jhgIL57V9?=
 =?us-ascii?Q?CvNKDXU4AAimyFfyzOHWKzIXv0w3qWvdiegbIfCuux+YzFnTcLhUQ7MWuP+J?=
 =?us-ascii?Q?HIqKDxhcjYW6YhDJGLzfafs5c6aE5S6sPujGFXovO0DFeK9BasiaLRj8I8HV?=
 =?us-ascii?Q?SLLIyuFThEuJexwl9PWSV287GSKKfLDesV+p2QWDJ1MhzoPmHSnqgB6LgpUn?=
 =?us-ascii?Q?40wwN/gDr1Dz/ulQAzRttXAZN7ysuIYVMz5QFfEG3UlSxEssjpZtGeonwRZ0?=
 =?us-ascii?Q?6veB0MUr6s6AZPI8DqmvQucI2BJcJw6cdEaolULV4Y4KspB3+U+K8MjUBIUY?=
 =?us-ascii?Q?Bz2RfKqE9wpbmNnKAeXq528VX2knzB86DH2CkmRxIPp6cDK8XfC/JAG2ZEyj?=
 =?us-ascii?Q?NpbI6d+m4LDs6CooAb0LIilN/QvEWiUg/xyC7E/u7PQsFpE5p/NqriSM8YlO?=
 =?us-ascii?Q?G8r3RnpQ6t8ODKXTB8NNokjyG7T0QfxF1p6XzIbINiRRfpeD6w5SAlLHlmUR?=
 =?us-ascii?Q?a8duMXxec6aJ7JH2aXBf8ShHWkEwZlh/IdbEJMETfVGfgXeBk4Z0iQ3bl6Dd?=
 =?us-ascii?Q?V8j6Kbs/BZVaTwC3cRo+uMh/aCu0g+btIpgCKCLouBF24h2Wbpa7V1+iod1f?=
 =?us-ascii?Q?2Pywis8hABrsDiq8NSSCLYUus7MHMeoOzKjd+cMwS2bsGO3r/dOmUmhfBq6i?=
 =?us-ascii?Q?HGu5i3u3t2gZuuuo+Z9UrTkdFy/kqdVeyO5xNNDduoQhOlPvhwQpngPpvzdS?=
 =?us-ascii?Q?K9JG/GRn+7V0R8LSLVuDj1UsMPuF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KseLui/t1x8krjn1hSbWZxzHIfUyAtJ0rVcTM/Ssj9fcXFQQwrFhOJbhBUvQ?=
 =?us-ascii?Q?yKnD+5WP90D79LyGw1oVrB8MP3hXyr1XquOAr26sZpsOWXrZcxlnFS1FCQ4a?=
 =?us-ascii?Q?5dKpxjZh7GQe4vG9eQ8n+2UZ+USFEoLZ3V+5ig03nXw6iKLBMYm50EHvQ20o?=
 =?us-ascii?Q?JRuTWEWa8rgBHVFUrhtvTtBYoj0TeA2yqhs5QzvBuo4Wn6kGtuvJGf47Jykf?=
 =?us-ascii?Q?C9fQro0v6md4Xo3U9DbnPO0eRKJsucZn5P+dOI7q63kNe9uNPu0gksuK/xJE?=
 =?us-ascii?Q?Uq5HuXs29oVjylsiqLGvLB1AIOWXNpaanYFbbfRtO7qhXUECGfLymUwuKErl?=
 =?us-ascii?Q?XgsRiNRVW9TljMGSPUQ9kcpQQXO6crGGajlA/gn1cNf6Dc4yRmkq1lBPVh40?=
 =?us-ascii?Q?TLlzJeAkiCEcaj4C0gXCEKDUc1/Cu0WZTE6Utog0ulLy1aumoSjLCnB3IAGY?=
 =?us-ascii?Q?p/4nkODLvRPil7RCx8jg3V+DtG7zMLYwvFwxZ17HJSVpngmumIhuNdiLESjX?=
 =?us-ascii?Q?1/HV+oaau0pVH5FSm+21OHpFIznk2cfcvuzxqeCoFIa51Oh0vplgxTeM1MIO?=
 =?us-ascii?Q?fiVVA/sYC2xI19/6MFaKz4f2Hz5a+FOkLAajOM0YWgYoSQtq4bb09M/ov78V?=
 =?us-ascii?Q?RiipTvFxqOVuRHO2VvZehxjoFcb4Aun2mI7hIawZ1o01q7fgYOhFcyj1101v?=
 =?us-ascii?Q?kGv0Z5ZuQQyBOZ++go15WrzrA+P4p0+LdYw8mUP6m10VwoOLJu235PDBYqNS?=
 =?us-ascii?Q?OrRhko140X2dmnYNq+0wOXPBhg5hoH0JYHcBLxU2O8SKhF/sR5y1nJVwV36R?=
 =?us-ascii?Q?g6WTlBVEz7NP+N5EgEjbDanLH33uuAj1Nzpg4Z1aGlteJyaCSTg5YA+TSOSI?=
 =?us-ascii?Q?0UB6J9fmrbyQ9SBVus6SNAJNgxvzAuJfiEPlY6guwrRQL07SmwkvrANWxolh?=
 =?us-ascii?Q?INAv7XOfGOhOJJAs0UkW/2O9lyX5d7Jw8Xyid1Hyk0fe4pMzd4cIPxQK41ix?=
 =?us-ascii?Q?DmA3AaFijKttOye3SfmX/pLe20L73Yq+oRxPAaFtK4fDhPpYhjKWD4rqtCfZ?=
 =?us-ascii?Q?pUcOeES5PvOEoPvWv8e4rGz2REdrzX7m7OoABeClX9SE6B5lxxlTMUkQ50G3?=
 =?us-ascii?Q?PTj+Ky9zqvOfjPQu0atMl+6qiKhf1dpuALemsLYmohCLRV4Gktphjy9mObYO?=
 =?us-ascii?Q?gKFVWgQoRTqviT0RgJZ4Rs8DqM0bDo8j/2isiGI+cpovDfzkf2D32vqG5bhp?=
 =?us-ascii?Q?gqSaMPUcYcqO7E2a2dZiVwfbX1jSMq+r108VUZ1VzMTVDhjZyHtFOP/A9Gzh?=
 =?us-ascii?Q?xA+z1nk6iCjR152WMXEfKyrplVe/8NdBFBNHjRGTC6ryPQMeihdD8TJCR4Zh?=
 =?us-ascii?Q?j91CDjhVvrACoHzj4n87kXc9F816CDq+01ExParGT+QIbtCJ7BQ1U6pUXAtM?=
 =?us-ascii?Q?LgXL0MDUiyj82G1z+0XR5PwSfO/YGr9u1K2V4zDv3vwjPawCADDb4Qm8cCx4?=
 =?us-ascii?Q?rF7OwrkT0mQCl0aMGJHKVa1UDUJboFSDLZqEAtPW756laeBy8AJ86nUiMVcA?=
 =?us-ascii?Q?CN4ehjUZl2NRHfEAP5pCvWBIR8mxAH478MKTvdnO5CpNE8X+sntH/4NNG8Cb?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e951f74-abf4-442c-d10e-08dd04c589c2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 16:01:02.6747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJnU6ogri7Cx1frg8s9yPxkVK7xWy9pyQIbJYap0j0TlJxyTRL74k0tCl4BfpqJH2iiB7FOl5f/tgwjADZt3aPj7zdVAfSbW4K/aEwqJP+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6535
X-Proofpoint-ORIG-GUID: mn8Y9lzRk4RG873Jy6j66CS_ZkOXDdmE
X-Authority-Analysis: v=2.4 cv=C6C7yhP+ c=1 sm=1 tr=0 ts=67361ec4 cx=c_pps a=a0mreH8AhMfks3Nq6fhO9Q==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=ECgXYxPxKqS9VgJvJZcA:9 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: mn8Y9lzRk4RG873Jy6j66CS_ZkOXDdmE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Reason: safe

task_on_rq_queued read p->on_rq without READ_ONCE, though p->on_rq is
set with WRITE_ONCE in {activate|deactivate}_task and smp_store_release
in __block_task, and also read with READ_ONCE in task_on_rq_migrating.

Make all of these accesses pair together by adding READ_ONCE in the
task_on_rq_queued.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c03b3d7b320e..dbbe5ce0dd96 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2277,7 +2277,7 @@ static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 
 static inline int task_on_rq_queued(struct task_struct *p)
 {
-	return p->on_rq == TASK_ON_RQ_QUEUED;
+	return READ_ONCE(p->on_rq) == TASK_ON_RQ_QUEUED;
 }
 
 static inline int task_on_rq_migrating(struct task_struct *p)
-- 
2.43.0


