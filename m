Return-Path: <linux-kernel+bounces-314093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 370B796AEC3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC461C23A86
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9BC2E859;
	Wed,  4 Sep 2024 02:46:07 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4F714A85
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 02:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725417966; cv=fail; b=Ly4Fe7lgtFhV6TQf7HKwxN9b3myUPPM8qub2WhI7lxYLaanLZdhwTEE+z01Z5efq/5IvWpE1wz3H1rkf7HY+YueXpFqkhwwuZuAC3x+bO8b5L/4sfYjD9s1lsb6k4im2mEwWQIv1pVqxsEz+WZJprixTEsn6p/V/+uy5Lta32hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725417966; c=relaxed/simple;
	bh=AkVGIvnxBKt88cKZCfDgdwQLtjizTfLeedVk0/kHPl4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SO5oK7KiVglYNdIUR//32sQS6ggZATcd/g2UnhGGwZ40OABIEnjHgdCQaFvRqpwuDubu9cdc/G/clRvsOqlF5bHAq5vG4Vjh+RRlMExVE1NUy9vfFnxmqIrnNdgk5JSs0o9/VZLyiUai/J3bSGjc0HaZCZeGyLgicBHYzkasRoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4841W4JA005271;
	Tue, 3 Sep 2024 19:45:53 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41edyd01nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 19:45:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qei3WQd3wfCOfG8H1ybL0t6Sn1WdFpIcHIcJXfvrrNCZt+tNkBJ7+moa/id3/yJEvh3APmMhOJVvULCNvDRZfIila7SM8vQrImKd1vIBgZ0cmSwp4ULlQ4QmMhuHus9x11zej+PXQSsIKnsc9PHwU4vf8tc3eIkWNqp3c5d75uw1jYSylLWSOFqek9WiN7MhXiWLWFXKlWJ4f1Im5SC5UtyUzL2J+oAdd9YNY+BWrYYvrwmRLjgxrCHH0fWQ4G3+WpVgki2Op3PHqJLqdTlN6mNiI1LUK8So1f9Cs5mf+4whWqQgHc5HmJs4LJmCsIAUVMf4x0HWXWQeZ3BW1NxMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TPRERr6GLBsdSW9b76Wf43wKIgZBjCA8yGCX0UBWAc=;
 b=ryQQRUdRqPkgKDdBq/TaOykDf+aFmqXBq6ekFlenHljW7DmUvsuiRga2It5pTvby7+vQHMIpY5+ITrKMzRqAFzhmZF3GwtVq0ZOd7gnTtZey9twyUppveLlryijx1ibVI7GYVnkgDZJCL1nJZsTXXD6WnVX4dj+/fTdz0p000udW9/ZVI+qFVXtf1myv6nlnI5tEDGFHgg+75TwQLm79mECaqXk7jWoWepYsF/KJU+sVObR8LJwSB9dRab2tKHVTdgQAB3tMGUcH+U7ybh6DBQ5AXoQwcduY4ENdhHT/i0ce8jlSvAbEdFZSNKcCvMLSdftcwGn20SrlVR2pXnuEiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM3PR11MB8758.namprd11.prod.outlook.com (2603:10b6:0:47::15) by
 PH0PR11MB7471.namprd11.prod.outlook.com (2603:10b6:510:28a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 02:45:51 +0000
Received: from DM3PR11MB8758.namprd11.prod.outlook.com
 ([fe80::2155:376e:163:d377]) by DM3PR11MB8758.namprd11.prod.outlook.com
 ([fe80::2155:376e:163:d377%4]) with mapi id 15.20.7897.021; Wed, 4 Sep 2024
 02:45:51 +0000
From: libo.chen.cn@windriver.com
To: kys@microsoft.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Drivers: hv: vmbus: Leak pages if set_memory_encrypted() fails
Date: Wed,  4 Sep 2024 10:45:32 +0800
Message-Id: <20240904024532.3446053-1-libo.chen.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0181.apcprd04.prod.outlook.com
 (2603:1096:4:14::19) To DM3PR11MB8758.namprd11.prod.outlook.com
 (2603:10b6:0:47::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8758:EE_|PH0PR11MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 6842e710-6f61-4202-17a5-08dccc8bb03d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LNv1f5QaTpPle2qNTOlAsSrGyafkqC3UufAiCV4+F9QLa7TcLjztClonZ3vG?=
 =?us-ascii?Q?BeciR3iXY5PUkQhYRwux7gvxlC0T1urjZgei1haS90z/9jYvVK3cXbTPXbd3?=
 =?us-ascii?Q?jZ1DW9ETzDtLj7CzKG/wUfGeG8oZDblVF3ByZAUJ21PFZZFwqfY5fWk7FguM?=
 =?us-ascii?Q?hP5wgPp6OFK9poox7ncBjtyP7juAccbtX6+o0hhMF0basNa324duhrd8xDHK?=
 =?us-ascii?Q?zPcoQzv4gsH9wgFxnbPV0uN1jG3gf4adKlV94iB5AzWxcdpil1Pfve/7pFEF?=
 =?us-ascii?Q?m62Zjzsj8ujycoXyvTVssWZaZom1oeFtRNXZTOpAmyt/BNFW+6CWgUI77Ly1?=
 =?us-ascii?Q?plPokHuMikPrBhjJKWI0zGwFvj6Dvu6Y0RzfImPb4GB56Ptx+koU8yvbnljf?=
 =?us-ascii?Q?Tb23JByMBWFL+5vfeXzs5bPSIlOiy+FUIGp98Pi6bdcLerTkL6B696BfyjYx?=
 =?us-ascii?Q?8fYJwD2Thb8A4gEDY7VeJD7aDIsVAG62rLlpkD9v3mNgE89NTB5OGWQLPlrW?=
 =?us-ascii?Q?erZJzaHpeBhzVt5zjG3eTmYajz8+MTPYBRxqE/D5vgtZgV7PimGzhGOu7wAW?=
 =?us-ascii?Q?nw2lVdqOIBNDNuQXDSV0CdLF419cLiZMU6/sMb+dkC9gc1R3wD/pedi9lVii?=
 =?us-ascii?Q?yhZCwngm/xQI+xYlcEfySGxaiNRG2uhuWq1IGur/Lt5N4lTL5pjJ0tBnswr9?=
 =?us-ascii?Q?TUMpdXCXDu7WfcrPUtTE7xp0HZgP6gvI0yePIvNyfMZ56yiZpiMRIvfDlZu+?=
 =?us-ascii?Q?4EKYiCCbOWerF9cSFrTbsFVHDmu/0z4M2/ey47UWEsThsMCf/x0ryVxVauw2?=
 =?us-ascii?Q?OGDoJJ319nbGp3bw0df7eFbj6ZVnqHDzWBgCJy0CuJdZk6W79mMcNb5f3RwX?=
 =?us-ascii?Q?dA5WKc4lzmdxbmG4AZhimt8Fhw0hoj9Lp7+viqaBKCyfAB1bSVOLB3EoEASc?=
 =?us-ascii?Q?gUO+yYGL4RFtApcnw4h2XPq78WMAiN+I8rH74HM6No6qzk1mp3dje6g2S8b8?=
 =?us-ascii?Q?CrDYptroiQERrzhzUlHLITB7AerWwkSq5DaRFUhSVt6ECwl4aOnaOCwN+uLX?=
 =?us-ascii?Q?jpJxTTkNCIzmr5k7cA/AkkOSc7a91o0iN7dlGOI6kn9g4aKgV9PDWGabIbAD?=
 =?us-ascii?Q?e5hbj1+C2KLMm+B0uQbg17xhnbj9Be/juXRr73SknzaYq8MceM9+3BuMcUL7?=
 =?us-ascii?Q?PioZKUmXZk6mEhph2+b97wX032PDYJ56bX2UddIuF3cm/2REW9gLFtB0j4/w?=
 =?us-ascii?Q?1inFN0twbMCyrgOo8fQDw6Qx8s2kujd9zlDLyuQF+Y9gLAZpYgceAu3NfP+/?=
 =?us-ascii?Q?YxAmmc/1JzogoHn/JHQ2XiZL35cXUFB5bMuQBgrLjc+IYLjpYzrdK5d6Upd3?=
 =?us-ascii?Q?VplgL5nLDOzrPnoTXSYDiUy+qLIECHbcSr2vVOiKQwEeMZ/7Dw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RobPhfhw9CTDWmdhUoSl5PMBxCV2o+DksxvboIB2qI0184u36nNgqUHTidmh?=
 =?us-ascii?Q?viEr5MHwMFTA9Ha6Rd/6qKkN3kaH4+oGVkb8SJ7W+AML7MZcTInxep6qaAjo?=
 =?us-ascii?Q?oI82stMyRHwJyKdZQT8bUmuy/Mb2UGv6ijvSlKcJJs/tzLKw//RR5AGuP2kB?=
 =?us-ascii?Q?sScQYni1qzLSNWUmJ0iqVEC83xV4taNVWnW9IG3j6C9BSG3jw6XoQUrIqL9R?=
 =?us-ascii?Q?p2z+/VMaA7r4yh36OHkyOZQGkeK9tGLK+DPcrIXSsXx0IZr5PWl+iw4YxaW3?=
 =?us-ascii?Q?JVvCYP4PBXTTXMgiJLz1AzykiCJcBVdT2+COaaqgAIJU/cbCfcsbdEzQjoFi?=
 =?us-ascii?Q?PcXuGhA0jeRRJZrBXiiDjcRPYD6sCrEvC9EEcUIMnBuzUFxLEuTKrHpazmNu?=
 =?us-ascii?Q?kgQokEhfva7bGGJ1bW6O8HMjfdbRkALdhotQlRyAsBNHVo9feBiJAvF76eHu?=
 =?us-ascii?Q?URgoGOdhZJbPHM5koSYSLrkbCr6IeC2sx1jBzXzQ8gEUMDn1rPejTHiib3ih?=
 =?us-ascii?Q?aw+utcaomPBclB2bhACKlISKJJJxAQAl/vVXJhgPnZgpKHFE4/fGEMQFlVWP?=
 =?us-ascii?Q?7cZgGF+IO90r5XP/Caq3SLcV9+AzyX9pSzAOqzQlxzk26SmMZt3YPIIO5oyb?=
 =?us-ascii?Q?HO54BzrL3T1Vawe3mLWwXf+z5o53cf3lssx/TG2waEJ+1V3eYwk0z6s5C6Qd?=
 =?us-ascii?Q?k322cgwAZCHE691+jW1a59QxRG6OJ5Me+wf2WYNYBcxc8NgsJLhUkcN43oJS?=
 =?us-ascii?Q?08AHdgOme51BPthm1LRHcBAQiv1F5FWd974Jqs7/iLItwiFBEVjYGhTMzWjW?=
 =?us-ascii?Q?v3TC3ZTymn3CWNfz2s0xkk/YXKToQ5uSo5NOrtu4mF4yLtG1LvbkslQRMfbQ?=
 =?us-ascii?Q?SepVGZexzKgndzZX1PMSxs69/X1G47jNHgy6DWpYZspU998oQlCYlYLYq5O9?=
 =?us-ascii?Q?m/g3cQn2087os+bpvrc6VgFcdRiucPHkVJlDRTRTmU8WIX0bZW3604YwUAAb?=
 =?us-ascii?Q?doyumqvofLJSL8pcfpTXOFmXIDiYRUe3CO/8xlt5I5U0ymPXxaOYOLNerLbo?=
 =?us-ascii?Q?rtD/M9uJONyek2muTkcz8f17c64Dihw3X8K0UgBOjM/JrmmkvMm+5k/YyrTd?=
 =?us-ascii?Q?fiQBk2FZKYUbFTAvJtTAs8i3daU6L6cnC1uN7vRYkcIlg2TW6rymj6U2GGBo?=
 =?us-ascii?Q?PevzN4p/UnL7LwNN/PcA551N8cgiOGnTl6OdYgIuXn9HnH8N2TVQwdaJ86EP?=
 =?us-ascii?Q?Ir42ZwBwvaGqv4/o+HE2msovkUWi2Hs9SBOCcUSODdDG2fNLnsCsQpGDOLKJ?=
 =?us-ascii?Q?6QivGlGOs/3chZsM+F6IQ4gaplcV64spmzlgPUb6ndolNsDCZBq9xX8SBDpz?=
 =?us-ascii?Q?8Hlys9lmrki4Gg0YAV6qW2guu/lvrk6Zu2QKOmYW9pKpO3iRhcv0MgiLUGZC?=
 =?us-ascii?Q?wO3F+0Dztw29d8uI6QkhYEv2NdrwfBPRjKDnXORXMuiX7ktlEE6FQt7zYYIA?=
 =?us-ascii?Q?KYx/0zlvLOb2QWhbfVVd3JMts+XD+oY51ITdIc2oiExfLNzD4E16EL0fczkA?=
 =?us-ascii?Q?NpjqF8H4EEouEo/PQ2YsElsendXra5/E5q+vyhS5NDxPe8McdoSXCPps/CAm?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6842e710-6f61-4202-17a5-08dccc8bb03d
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 02:45:51.0762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhRS+f/i5O9WyxQFXfT18MpwGKNj1FvzpEueY1aY3NFDujUgVH6MqpejHljvIXJb2Bbl2M2JiT56397HrjVrq0M4N9AI4k/B6eUWj2ZRl2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7471
X-Authority-Analysis: v=2.4 cv=af0zngot c=1 sm=1 tr=0 ts=66d7c9e1 cx=c_pps a=gaH0ZU3udx4N2M5FeSqnRg==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=EaEq8P2WXUwA:10 a=bRTqI5nwn0kA:10 a=QyXUC8HyAAAA:8 a=UqCG9HQmAAAA:8 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=TATMwWlPqHHbbuS1RdkA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: rBNsTNNVGwesYxobe23CapruUb2l10tU
X-Proofpoint-GUID: rBNsTNNVGwesYxobe23CapruUb2l10tU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_01,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2409040018

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

commit 03f5a999adba ("Drivers: hv: vmbus: Leak pages if set_memory_encrypted() fails")

In CoCo VMs it is possible for the untrusted host to cause
set_memory_encrypted() or set_memory_decrypted() to fail such that an
error is returned and the resulting memory is shared. Callers need to
take care to handle these errors to avoid returning decrypted (shared)
memory to the page allocator, which could lead to functional or security
issues.

VMBus code could free decrypted pages if set_memory_encrypted()/decrypted()
fails. Leak the pages if this happens.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/20240311161558.1310-2-mhklinux@outlook.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20240311161558.1310-2-mhklinux@outlook.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>

CVE-2024-36913
Signed-off-by: Libo Chen <libo.chen.cn@windriver.com>
---
This commit is backporting 03f5a999adba to the branch linux-5.15.y to 
solve the CVE-2024-36913. Please merge this commit to linux-5.15.y.
 
 drivers/hv/connection.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 47fb412eafd3..8283e7ba156e 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -19,6 +19,7 @@
 #include <linux/vmalloc.h>
 #include <linux/hyperv.h>
 #include <linux/export.h>
+#include <linux/set_memory.h>
 #include <asm/mshyperv.h>
 
 #include "hyperv_vmbus.h"
@@ -216,6 +217,29 @@ int vmbus_connect(void)
 		goto cleanup;
 	}
 
+	ret = set_memory_decrypted((unsigned long)
+				vmbus_connection.monitor_pages[0], 1);
+	ret |= set_memory_decrypted((unsigned long)
+				vmbus_connection.monitor_pages[1], 1);
+	if (ret) {
+		/*
+		 * If set_memory_decrypted() fails, the encryption state
+		 * of the memory is unknown. So leak the memory instead
+		 * of risking returning decrypted memory to the free list.
+		 * For simplicity, always handle both pages the same.
+		 */
+		vmbus_connection.monitor_pages[0] = NULL;
+		vmbus_connection.monitor_pages[1] = NULL;
+		goto cleanup;
+	}
+
+	/*
+	 * Set_memory_decrypted() will change the memory contents if
+	 * decryption occurs, so zero monitor pages here.
+	 */
+	memset(vmbus_connection.monitor_pages[0], 0x00, HV_HYP_PAGE_SIZE);
+	memset(vmbus_connection.monitor_pages[1], 0x00, HV_HYP_PAGE_SIZE);
+
 	msginfo = kzalloc(sizeof(*msginfo) +
 			  sizeof(struct vmbus_channel_initiate_contact),
 			  GFP_KERNEL);
@@ -303,10 +327,19 @@ void vmbus_disconnect(void)
 		vmbus_connection.int_page = NULL;
 	}
 
-	hv_free_hyperv_page((unsigned long)vmbus_connection.monitor_pages[0]);
-	hv_free_hyperv_page((unsigned long)vmbus_connection.monitor_pages[1]);
-	vmbus_connection.monitor_pages[0] = NULL;
-	vmbus_connection.monitor_pages[1] = NULL;
+	if (vmbus_connection.monitor_pages[0]) {
+		if (!set_memory_encrypted(
+			(unsigned long)vmbus_connection.monitor_pages[0], 1))
+			hv_free_hyperv_page((unsigned long)vmbus_connection.monitor_pages[0]);
+		vmbus_connection.monitor_pages[0] = NULL;
+	}
+
+	if (vmbus_connection.monitor_pages[1]) {
+		if (!set_memory_encrypted(
+			(unsigned long)vmbus_connection.monitor_pages[1], 1))
+			hv_free_hyperv_page((unsigned long)vmbus_connection.monitor_pages[1]);
+		vmbus_connection.monitor_pages[1] = NULL;
+	}
 }
 
 /*
-- 
2.25.1


