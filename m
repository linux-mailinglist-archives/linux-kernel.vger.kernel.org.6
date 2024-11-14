Return-Path: <linux-kernel+bounces-409944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E35A9C93D0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680AA2871DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9FC1AE001;
	Thu, 14 Nov 2024 21:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="CeKpmkQi";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="qeSB22SA"
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38AA1AD41F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 21:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731618707; cv=fail; b=FVsoM2cXq8ZvQNuWMMuRpYukmUQD0cO5VQs1i+2CFB8wMaF0odvP4iVR18x+zGmiKmSbuw3w1sm/8w8wr5lV4RudHgxGe25XMTJ03UACfM6vHcQDJiFQDVVvWOqpkVvHdUi5R4hjS/MVpkxlKIoj02k8p77gRID92pNNvfTkwnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731618707; c=relaxed/simple;
	bh=2q8i1R3g29B50PRMiBlX/G7NfYpNJd+5QPPOBHHtiKE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=G1/Ulvh0sQY9kSVtJsn3WVEkBT46MzFyWmZHsQFRFUYaZnMxuUAyP/TpDvFUVEOXma/KIBdAGU8Scl/LArdUOOzuVZe3Eg+w2OkR9Fo6b5UphU8tCc8PNGjqPePGtaB/RBUEbHoUgyncQWCTGv/rRUxbq3yJB2tzOXsUIV908jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=CeKpmkQi; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=qeSB22SA; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AECTGg4029828;
	Thu, 14 Nov 2024 13:11:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=yxAR/gzB+Cq/3
	tE4CIsGPstIoVmGka54c8MwwhwXJRs=; b=CeKpmkQiM72gcOI/GjsvOkLhQ+1UT
	r2L1U978dL1fQnhX44PZS24/sZXvHnw/8yJNrGiLlTR++kju+mg84ybjgUwX2X15
	z76ybTly8QCGd7K0nXQ69HStq6w0X20G0c5Iglv6RMiILONGlN/BDmrfNEMBEs8o
	9u6p89i9I85xBY858iu/8EE0pnJI1Uk//hzkA+sJbb03PwEXxaIOq83h0Q2TWIHz
	8vT/axAtnyLVt59GroJsKuMGNpTrVAoI5SHyO2Ab6RuS0uWQgsDFnWMrCFneWthy
	u9Sqo2tDJ7Qsd2yCa8+sn7rNjXzLlfDU2rmS0rGWIVLT7vcc2PpvxhI5g==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 42w6qbags7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 13:11:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nowtps8kbP2S53YVvt+8/+Fg8lAzR5Vg5t4IqOwW33Bxtncpb2m+1V/BBjPLyzx2baPdbxMlgq6bAvtEpOa5dM8X1xEnYyL7F8CB0ieiUiwRIMOagFHRP2sgyr0iIt6St/cJ15EXU8ryNBzDFHszEl9zZTJxNKTgZcDWzb0MKCdorDxV1EHzCmVvYXLJQW0WNnSdZPsThB/ARTuoZWZi/haYyKNfFlYdWxIT4LakhnN5dBq8h5R1xatDYTX580lIZ2s1dQaCZ6iKZ/m+SF35CDkzJsQZWt8bZGqRqrHqxXKcIpqFdW/SpRSSTKVry8lGjGVnqGQ0dnNCnASQpuy84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxAR/gzB+Cq/3tE4CIsGPstIoVmGka54c8MwwhwXJRs=;
 b=kdkBwecL3vqXaagRzJ0g18RldzablznQEvB2qPVpc1WFh7tn3vN6cFiohpfdUl0IyY0feTF9NbJWe2JaoBfqFqrZvJYd8OstLGEGTz5OExKBF2n343cBUP0BRgSbInESX/xn0wSWz9N8qjlL1CIU5zGVs3nS7ruLEuqFra6MpCkPm6p9zZfIWQEzsr0COMhgXHrl/IMyLE92j6tLnoxL9vBUtjEPdlGWS5FFKSZ7ADhMDI5CRM7YZLZZPOec4ThA9FBRGyyMe4+BS7FvF0Dnq58tqIVV7syJpmYTodMkfS1r+KQe4paVRlM6hIH4nJTtrhj1w4PB6+PvOjznZNWdiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxAR/gzB+Cq/3tE4CIsGPstIoVmGka54c8MwwhwXJRs=;
 b=qeSB22SABDaCLvl5yZrQ9uzWl4KN5OE0Jdg4vmhrHm1rp0EztHitHdhLIS2XX0vO0pGq65NinTj24ZALtyu9rVj0SFzTaNBGiCM0xayK5iTIRJvC4DPE+6QiVFVztwujZRaKlMe9U90Dswlfs05kYtd0IV4zVk1WtYFmckEZbaZayz+xUIb74Y+nlJS7N/+TMLoiPDKXPG74lHpM4VLWPnf8paNXHib1mT6ZyVt5qaT+ncfg+oCRlpwJ+m+yo1XoGkfQsY9rXizcMKZFrPwq6vj06CAUeN+ZRyvnIvva0QjdIBPT0aOdgomk21fACpWciPZmIaxTivcv/eEqXz3KDg==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by SJ2PR02MB9822.namprd02.prod.outlook.com
 (2603:10b6:a03:546::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 21:11:23 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 21:11:23 +0000
From: Jon Kohler <jon@nutanix.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH] sched/rt: use smp_wmb in rt_clear_overload
Date: Thu, 14 Nov 2024 14:31:56 -0700
Message-ID: <20241114213156.1839644-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::22) To LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR02MB10287:EE_|SJ2PR02MB9822:EE_
X-MS-Office365-Filtering-Correlation-Id: a87a9d21-14fe-4dac-301f-08dd04f0e4dc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zlrfH5P4B3bpe5cowh8bqRFKNxj7/VuEID/6qors8vWbfshuvCWxyiGBsn10?=
 =?us-ascii?Q?dUmSTHRbuk1n99LH3Xr6czv24r7wtMzoYc7tg4w3SxlCx1wjcLOburKnpYNk?=
 =?us-ascii?Q?oJ44qp8taQtGfp8EZNpqD/cAuYIVAYOh2tuX7fuJfn9XbnnDonsld2ZDxQDw?=
 =?us-ascii?Q?HQYVmgiJ2ZXdFHEsvONd2C7Zk+h0m9u3LBkFkZvl9S089r73bdZIU6eaLIG/?=
 =?us-ascii?Q?bSqElWAzeWO6N44GC734K2rvKLhC1TO2BLB9IwHyEQIWXwOYnc3kuuNrzJRu?=
 =?us-ascii?Q?ryuiJyPgmbkm7Bjc8ntPzDeCpjtGpw7fLwXBxNAELjYMcFia0zmsTc9BI2FL?=
 =?us-ascii?Q?xj+JMgu4pKBSIWlT50oy5iA71awziPh+257Eyb0ie5GId0EJMNk/XxplPlEE?=
 =?us-ascii?Q?0BOcfpXL42+xFVEJzadoI0xxjrHymJZyWGmFHSGM/HRdzIz6B9ygYmDTNMkk?=
 =?us-ascii?Q?k8KjOx67PLQjCUXBs2mWwMuhc0Xpdmg2kB7PIvRAvC5qG9cAGBDgjWtes7eY?=
 =?us-ascii?Q?pCDwnIIwGtx/8D3zztHwVyvww7kDSq0lGfmDKQVmoFXwAi2QhxawmSKn1JPO?=
 =?us-ascii?Q?aAmvDCJYKqu+CCSyvrWDS8SSU4hiI5vs4uPMEfhf59CS0XMVFUXwH7GKN6AO?=
 =?us-ascii?Q?FnXcKuEB5It4Ag3dHTGSSVWVCraMAlFsdd7/J5OiuQBXB064z5y+ClHr4aAI?=
 =?us-ascii?Q?zvPvMAqYsaO4jz2nLSWD3FQkrwIqjTwbq/QWkCoIyQjRpVjFkipHKxJIuJ0M?=
 =?us-ascii?Q?4GDqQJu7bwK5DaM4asjvFL4AkvUOqu2PNn+BQR2ANG4mbPdigYse3LCJzJhD?=
 =?us-ascii?Q?cfmmxarfczPDLiggtUiYywaLe/L6CF02pprDZpi7+rUF9ZnnKtgY8WeWOy+p?=
 =?us-ascii?Q?8EuyypN9wdRFJQ7219Om+iXtQ/SvFHKUuNMQlf13PQUNmGlRuLMdL9Is86Ms?=
 =?us-ascii?Q?VPxMQW2Hl204GAMli8dCjpNb84iyIEf0AFz3Aq94xnH4g/osqwiKmjqMJtZ/?=
 =?us-ascii?Q?FRipL/tBz9pnnFr9M1w+W+0ZOLe6Grsei5bHueUrVUSVOz+3EWoD8UlBV3vr?=
 =?us-ascii?Q?YClLritfQqUu5H4i2JRNT8fceXSy8pmZ/kHpYpEVE/ayz1gF5BenXuQEVZNa?=
 =?us-ascii?Q?oVFxP1a/o2kzVOE9wigZPsX8pu73L2rPAEfSSlHKYKagKv5mX1KeJxNNWqy+?=
 =?us-ascii?Q?ltXeQQfxNWHyps9gKS0J0zuisjR8xd6kVTNuT1zQETCAsa49kMZsIZgJdl+I?=
 =?us-ascii?Q?fh6NIiM6G1vXKRriklZiIabQuChxntnUvWrtlOv6PInOf4z9zaUZX67nBpiu?=
 =?us-ascii?Q?aG8EoS4X5u/UvecF32Hn5sAKBN8fCy6WlDnFimoL+z5pbw4xiMVangN9DsJs?=
 =?us-ascii?Q?pgY6IPhQoMnkpv6sVwNSIOAomYT5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lFjF1SJ4SDrxC99tB3pdhjY5yDNifvUMdNmLkRYjC7Gth6psDNI45kLi+lp5?=
 =?us-ascii?Q?aC4pgtUOuKAqxauZZMo2Wb7QSBaftZydJjQldMwhZrwjtZ4dFMSXlXsajMLr?=
 =?us-ascii?Q?Pj0C8Nqk914ng8CM8nI8orr2k5sv5OH+HUaDWnWbap2pVsslA2ld2HP2vo12?=
 =?us-ascii?Q?cJLoBYYZb3VroMAYxeeMQZunt+i5/vGHweX8pug4W7Q5OeUDCgmTVHWRs9uk?=
 =?us-ascii?Q?47nzF9TibXtGTUFX5qiNCkpPg0qFKVfaOQoT+vdF1L89ffz/7pQ22Z3ogxT/?=
 =?us-ascii?Q?m6og0l2kTj+5/HHy3yeTGTYwDobo7n/+YoUEYJq3F45k+l7s+oWyTx/1+EuS?=
 =?us-ascii?Q?76QxwCzVUOkb/ziiWSwaRp9iVS/lP4scUdagzz84fGZZixy7LpiUcBAiEEKY?=
 =?us-ascii?Q?H6CkXqFfQzKHv/tqsJnC33+eH8mRWWRtj/SNi+7h1SYvK03qHYNTbzv91EHe?=
 =?us-ascii?Q?3Wj4pKOXNrQfYjrwXTWjp3GvIur8C8ihHy4Q20bBUslSMiY0Ibrwfeui7MRT?=
 =?us-ascii?Q?JtWG7PHQqIgc0G7OWpiYAzUUW9Xcw7xs19bqFOfLbzOiCIWaQND0BodQzB3W?=
 =?us-ascii?Q?TkurASd8nP4oDXAfjfmnko9sghpdwJNdDNQPiQ/7YzdREdAVouRChaw/D2H2?=
 =?us-ascii?Q?2/T5Red1rATNcLjjooUIIxOtVLmED2SwQmp6wQYV7VcFMiPdsl0KBz0lCEfo?=
 =?us-ascii?Q?TURMj16pLOz4cOzTJgs9bVdTqHh5xksWOcWCoDm8S+AwgCfyM/FhD10Ajxg6?=
 =?us-ascii?Q?UGTRcOOMe8NztjO8id6xLu51VJUPfTQzaKZP+h9MqrJBjE0PeJlASrOBkE50?=
 =?us-ascii?Q?3ytOgRecglN5hfzGY/gENT/bREmARweztNtc/8BnIHDTsr16ORNhp16LNY9z?=
 =?us-ascii?Q?gegTb0e/UyZOu4OqcQL3cnrjVaUUQNvLfTNf9wBRSDyN70xjlDhr4K94ZhcM?=
 =?us-ascii?Q?jH16fMyqMxnOf5KjNOwNDHd/1IcWmTo4HGdiSG3hUTq/AhT3SnudlyDtFWic?=
 =?us-ascii?Q?fa2swa6SPrq4D0Nc8fUEzj4a+7bCujJS5HiPWXrnY5YzyabwI9wrIkenWBEd?=
 =?us-ascii?Q?alkpG3i4joN5DE0FdRIwupcsM4+gntSjAk0981o7Kb40sKso8KDF6As78pz9?=
 =?us-ascii?Q?nUcdyK6W/OS9o5ZCVOIPcZ5rzLkNtyuldUhIuguP8fk8wBJ1gOrzYl11OdCe?=
 =?us-ascii?Q?2dV1TtQYTWYesCRsZgRuKiUz17YCl5Ffz31184vivor/dNaAFiFF8HcWCUS+?=
 =?us-ascii?Q?EIpcKvqH5aJ8prS9+5Ol3m6I7/fkX050I/PDuo4OpUCYJ7HVVKVWNq/R4lJ+?=
 =?us-ascii?Q?gknu6o2KWifzY/xU3fhF7EYR5yqIW7OI8mAzLx4Gq9ez1eTBZjlsPBCHXIK1?=
 =?us-ascii?Q?8bsKmEYkviReM8kc9OhPH2YXclBf8qzsm/aJ4js7Bk1bQ++iNxn66W+sXRJ4?=
 =?us-ascii?Q?O3Qxdm30hiVc8Zk6eGKW88SSCG3VW2JxrAgjyhKp0ltZRbHxOX5lMwdXDIPh?=
 =?us-ascii?Q?6ED9GTGq2uRoy0v7hmw5CGSyzAhx6CQH1VXhSjk9mIeiseGBRy7NUxkEcyzZ?=
 =?us-ascii?Q?GHjfZBK5Uy5HBSGVcXrisbR/E4DZ81GcYPfwuOCEka9gEpIFh1PU3NVbRShx?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87a9d21-14fe-4dac-301f-08dd04f0e4dc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 21:11:23.7537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkXc1V21gDYVnwAXUzdarMigpswRYaMODgAGV2ByUfTExoAetg4fu5r07eCCrKjl/p+qtmMiCz6uFPdxwjQRbGtaD3iexJVAQRb/Nfpl31w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9822
X-Proofpoint-GUID: VfR-Wi1eYJD7BMZx7U2KgnXiThH7qeL0
X-Authority-Analysis: v=2.4 cv=NeO01HD4 c=1 sm=1 tr=0 ts=6736677e cx=c_pps a=VzeH2YOhhDlPZ0WtbyP6yA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=_aYr0uzb565y12tzYnAA:9 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-ORIG-GUID: VfR-Wi1eYJD7BMZx7U2KgnXiThH7qeL0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Reason: safe

Add smp_wmb in rt_clear_overload, which ensures that the cleared
cpumask bit is visible to properly iterate over any remaining
overloaded CPU(s).

The smp_wmb pairs with the smp_rmb in pull_rt_task(), ensuring that a
thread will observe rto_count and the correct cpumask.

This visibility is important for NO_RT_PUSH_IPI use cases where a
thread may iterate over an outdated view of rto_mask where target CPUs
are no longer overloaded.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 kernel/sched/rt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 172c588de542..f68a454bb0e3 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -354,9 +354,13 @@ static inline void rt_clear_overload(struct rq *rq)
 	if (!rq->online)
 		return;
 
-	/* the order here really doesn't matter */
 	atomic_dec(&rq->rd->rto_count);
 	cpumask_clear_cpu(rq->cpu, rq->rd->rto_mask);
+	/*
+	 * Barrier pairs with pull_rt_task(), such that threads will
+	 * observe the correct cpu mask for any remaining overloaded CPU(s).
+	 */
+	smp_wmb();
 }
 
 static inline int has_pushable_tasks(struct rq *rq)
-- 
2.43.0


