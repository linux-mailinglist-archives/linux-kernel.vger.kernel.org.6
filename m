Return-Path: <linux-kernel+bounces-314061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A95D396AE6C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EAE4B20D83
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEE41A269;
	Wed,  4 Sep 2024 02:07:44 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF27D529
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 02:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725415663; cv=fail; b=EMPC2+I0lFYmYuBDEzNNMdlLAZ29R6cciIYxHXHqeTqJw3/2wtDH/342M1Row3Kshy4WrXwuwBXJl5wErv2spEUlZTHtS7ePJeS4D/XWgNZMYy7xdfHH+1d4E+6ucrCM3EO8wnF2Hf7GCzLszgHbmg96VAWt1h142R7deHIpVRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725415663; c=relaxed/simple;
	bh=AkVGIvnxBKt88cKZCfDgdwQLtjizTfLeedVk0/kHPl4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ipj/D43WtZlG0WgWOHGX4XAYh2/lctpdY55jrVLl9e9kWyWTHKRxVajw7CtsxySGAWiJYLbdVQTr0L0BP0b9u5wdCE882c+MHDWqT9zowXcqz6oiWi26FzXrf60r9TmbU9rt+XUpdM/0iul8fjcrheT2C823FsWp5ZZx0CRhxxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4841PvgD011008;
	Tue, 3 Sep 2024 19:07:29 -0700
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41edurr11u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 19:07:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUuzRgyhfzSYK8PZR4taCT0KT0C+uEZu+9MyoM//ieLDtciBMc8qoLFx6ObW/DkUsLsmg7dBJ8u2QjKhWRUqVLOYQQpvFXDGySWmv5ucxgqX/iAB4UVfhk3U2lp3I8i29CXzJcbjqQMtdRIEcZiJGpWDvPKuO2kX7WAAzkIrjp7cJvtVzxg3/hJckkoRmDgmgOXf9uRtKFabKFge6PoSj1oobIfyB0PuvosvbZUy7RZ+caTp08F5YRdxdFD/yqXSjG4iZmZNWfEvbLMygnBPMW9wsbKFz3y+pJVrGWdOeH/YMuYULOnRB0809VDyZEZcQ/SS+AKgmXTJtAiiLLcSNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TPRERr6GLBsdSW9b76Wf43wKIgZBjCA8yGCX0UBWAc=;
 b=IjpvRW32t2zMComSoGDjfWQt02nR4VvJnzY47h/5bSg8WqdYhPNLnL3ZEt+cn7WWMw4Qij789sPS5XYjG4udwHODwuWquop9055rsqfFcivN1KjeKWqmhg8nW0aa4PKQD8DqP+BBUh+lImI50SuuBwSLdL9bnua2NhA7z2KggcbF5Fa2xmLlG8//aRnJRtYc/SPLaBRFFranfjGAZknesBN8wuXVw9jbBaUhnz1+Q2XezWxRw9Ozjo57Y8JaT5a9S+G97w9ghel5ExVEqm3Q9I9QJmfiRc8hhNo4WnMWH81gY0HfbmH6mblQqGoOJVa1x0OEhRsXzcac+iNl4Drmng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM3PR11MB8758.namprd11.prod.outlook.com (2603:10b6:0:47::15) by
 SJ1PR11MB6177.namprd11.prod.outlook.com (2603:10b6:a03:45c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 02:07:26 +0000
Received: from DM3PR11MB8758.namprd11.prod.outlook.com
 ([fe80::2155:376e:163:d377]) by DM3PR11MB8758.namprd11.prod.outlook.com
 ([fe80::2155:376e:163:d377%4]) with mapi id 15.20.7897.021; Wed, 4 Sep 2024
 02:07:26 +0000
From: libo.chen.cn@windriver.com
To: kys@microsoft.com
Cc: haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Drivers: hv: vmbus: Leak pages if set_memory_encrypted() fails
Date: Wed,  4 Sep 2024 10:07:06 +0800
Message-Id: <20240904020706.1778130-1-libo.chen.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0137.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::15) To DM3PR11MB8758.namprd11.prod.outlook.com
 (2603:10b6:0:47::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8758:EE_|SJ1PR11MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 317fa822-dd89-4559-5a5d-08dccc86525a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XjsWz8O+Z05oG0Ag+2x51Akv8+X0oxapHt0XYNBaj6aQ+5MGLXTB6VEURXkk?=
 =?us-ascii?Q?YGpcA2OAgdoF7dB45ZqZz/2zTEQXVlO1o6sPYgLTjJ/rSiedTuJVN6eduqZW?=
 =?us-ascii?Q?I7eP7hX+ag0sHnlBqm6/gHEKnzzadqWmP9y2bn8PpR+BwB7W2U67tJn2J+s7?=
 =?us-ascii?Q?9xOZJTky9FYnEjIa1xWtPNAJfUYTEX1gLXsbhfSq/ic4mH+Fnzj6iFx0hWqv?=
 =?us-ascii?Q?nd8DccZJd/hlILMGjlwEZ7QRLsagJvagMg3laDFT41jTOZ8hh6XU4LukfBF7?=
 =?us-ascii?Q?RTXOuIJVukuU5R4JfnBDrW67yM2c7tR5Tgg58jRRDuf6NEMR3cHYaGbaFp7C?=
 =?us-ascii?Q?4Td0gynyg4eWiP7+hJZrFnpN4g93niP6wd1UVaXUDFXkKdrGUfE3WuGQnir+?=
 =?us-ascii?Q?DYv5xXCWQVu8J3/ypoYq2IUhOk/WahiPH1tMYDiY+/1RqRa5j4S0tklbgOaD?=
 =?us-ascii?Q?afXV/VlThK75r7wW2cIxAsBMse6/4YRSpfzukfWdyzho4e/EbN7mOdg6hm00?=
 =?us-ascii?Q?uR0LXLJMZmo6f7cDRha/y5nvS5Grj+1q0ZO9m1KBiuOkc79Q0n3/AWdZi23f?=
 =?us-ascii?Q?ufna1xZoCCzuSPQda7WVyy9Pfr8b5yP7OtQTnvHKnZq0fgExEHUhiM4Lz8B9?=
 =?us-ascii?Q?fnwJ/yj2yPBREUG6OH1M737nKkopzfqodhYEp0jc29K4wiTRy/O/oxstcxXt?=
 =?us-ascii?Q?NETyctwKYzq3INZuFlbew86xtatkuYcQu3DA/ZXMuc8gejDKlBD5uyBpoqW6?=
 =?us-ascii?Q?Hje2LCXi+LuiLjcQa6fk0NcfwsO1cdOWf9zfZ57PS9KGLZhkb+PPAZludoHS?=
 =?us-ascii?Q?E5vN0az/yZGdvQ5du6XwcpCQOakCpiTfjJUitJpNvKv4aNE+fxGX7K8I5aCK?=
 =?us-ascii?Q?2I9A2Q/4bxi7FIIhUxupKnIaFS4prD93B0yW89eH1aWaUvrBeTBmsSXBpqnF?=
 =?us-ascii?Q?htaft1cIPpLLQp2oZMrJnFeF+7rjPmpWxqWtqHb60yIo1YNKbRssapL8cDBP?=
 =?us-ascii?Q?1P4vdg0nt/2Q1Atz0/rf18Nc5IChl7l3ui96sHgzjgHBUdrXpF65qceBd95Z?=
 =?us-ascii?Q?hJgSTX/SMRrJuL+mPdGIAnxmdxisDIdmChDrMK8M6ZSqhFdZb4lBI575alyD?=
 =?us-ascii?Q?ve4cIOotjIJIzJ/O530FVDcr14BkFDV1nelLZsIKHufoLLAhp5dA2ou+I/wW?=
 =?us-ascii?Q?el5S6p872Gvj9c2PirmXvkJsATy2bTuYDtdCrrhVgyLgtrofagnrHiRx309j?=
 =?us-ascii?Q?2jzM/C1vPNQUeU06Kz8QSVEZsY0wM2g092zSvspfU/RwTKy5CtD+vBe7NYt4?=
 =?us-ascii?Q?cOyXEr9SCQc3KYFNibxF4HWT8n/2njsruuV9/c6IiI/qwBzunY7GH1xczHRm?=
 =?us-ascii?Q?h91LG8RBvOVamTtNq2kLbAy5zEtqjZf+XgISwL7YUOA/EDMxcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vsrGES2jlBWK1Cz6cApuvLIHu0+G8LFfZJKy0Sp4mc5k+xmJ98GNbAuxEnJV?=
 =?us-ascii?Q?a8eXxSqGQQd+0AtFT5c8ERTLS/aRyKqQ5aX4TfykIRkCGMuBFb3+a27jED0P?=
 =?us-ascii?Q?O88qSXs1dx43uBfy2ItOQfmHPUzMZYfzsx2FhWm+FoCjL/7uxmPKL3zrGncD?=
 =?us-ascii?Q?y64RiZHyQjXGkn2DjwvTbIWEcB9AldeQTbCczV0pidW4BnmlO+USwIWbYfUF?=
 =?us-ascii?Q?Zo7QPoYMcMGytnQ792lP6WFZxUqXvgixYCbfuKWnVHiKLZuyRWhhw77jL/JO?=
 =?us-ascii?Q?H6k0+8vwkrm4k3a372wEQua2LAucleQ8LFwTwfbiWW0qEMoU468G1NTB53UX?=
 =?us-ascii?Q?uB99Ob3XRVs0EX+PWw3q5zRLPODXVdN55PsdwxTP27I2EMqWXs0HOjHa8pNn?=
 =?us-ascii?Q?rQtP0VFy6lvgVPgujzQlmbEyA1P7B8KVYL1nXsrNL+RkebupXAt25qQ8bLTO?=
 =?us-ascii?Q?vXiIShA5UuvzjYeUq7XA76vOC3NDiauPLyn3B8E5Fy/mQEGXbEdaf4sVaW7W?=
 =?us-ascii?Q?uZW536Hx2LR3NVgjeVpcuhehCXeGrPOUC76wOve+efMCjqcSGixMZZnky/ZL?=
 =?us-ascii?Q?qfD/+EPT4fmpL0uufPdlQsT4YCWcsNwn/luH0cfcFQ+psH4BeR/LDJCoDrcA?=
 =?us-ascii?Q?yo6XC2ilRj4YnkVfyC7WWvxqBMOmO5rjOxQjNzzdbbmSGXWg8O8kXmF4yPrM?=
 =?us-ascii?Q?AjqN/GMSfCl2dCQoyAfsCj5hq2DC+bV7ilNDyyGdXkylFPdMmkEuGp7nV/OQ?=
 =?us-ascii?Q?eW5p2vc2CUDpm5+7qE0m2YWHjOVBCflNYLBlmrto98n8ClaxqgHRR1aMSljX?=
 =?us-ascii?Q?bV8B5dj770Fk2FNiCeLyb7o14im11kRV1xPYkFnxv0TMxeEuLkjNISa4CP/2?=
 =?us-ascii?Q?BJGayvEq5Jv0MNJBTXHxBZx4+EvKXLFHoayZHpXHHNSCBbS9G9Mdy5n9+ggM?=
 =?us-ascii?Q?adoJElK0dMmsW4OluhNKaI7ysDzSHhTa8RDXgywaXSdxFWUrVsul2JQwfhoB?=
 =?us-ascii?Q?AMseMKml36mPxr42kE33M60KF79cfs1Tb4JC4hU0+dcKLf3b8MzLqesouqEf?=
 =?us-ascii?Q?s4nnitRDOM+gX1QczNJ9TfBoz9nww3pjvsHXqlTF8XpplxC8MsLu3d5AFSo5?=
 =?us-ascii?Q?wT66GXnZgYWSTodF0uK+YlqxF1oiC/bBZDJDzaMWJYibo5l3enwbRpWEmggK?=
 =?us-ascii?Q?iy2dzTKfMc+GUTkHsrcjgosrEXBK2aAnHc6gB8+VRxoFgXB0Sm59+swpqg4L?=
 =?us-ascii?Q?+kJewVEob7IBhUvHENNECbXz/UgC6qmMdQ0SzPWHzlWxy0fbWqoNXLRrux9k?=
 =?us-ascii?Q?4iS874KRUms3XDfutNjSK9f8x7vqsRHWqfeLscJXhir2d6gneeYypn9/pkgN?=
 =?us-ascii?Q?Afib8sK5aRVjQNfjgHZ5kNxbmSxHaIhpzZS3Ji1INKsRFWoj0ACChb6rBi5S?=
 =?us-ascii?Q?r80KjNHZgOptArFXVD8nB+qqkUDC9D5O2NbrtHhLH2GHa0ehkmPdJiZwSEu+?=
 =?us-ascii?Q?7RE0JyxjyOJxi5E0IJg/VliU3vsJIDuv9ar9T7vfttb6n2fvXvWlC5hsT6an?=
 =?us-ascii?Q?JhEaFvsmpjIBFiun5H09fOKm69EdIQfaOyjOphkrTsy+XFqZ1/xTPLpc5uyK?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317fa822-dd89-4559-5a5d-08dccc86525a
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 02:07:26.1171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGnPqsURXvdHVrMLzYcp92elUIxHMxVgjH/Xc1ouay65UqTQ3lyKPRGz2xjOt9kpwoiObzIU0EHP+SLpsAAS6ISMiaW3x+lLiYQhtUyU3zA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6177
X-Proofpoint-GUID: Q7UppJB3ODZFWfXWlXnj0f7GT7FVKg4j
X-Proofpoint-ORIG-GUID: Q7UppJB3ODZFWfXWlXnj0f7GT7FVKg4j
X-Authority-Analysis: v=2.4 cv=FbFlx4+6 c=1 sm=1 tr=0 ts=66d7c0e0 cx=c_pps a=2scX5b6JGDBY9+deG5t9BQ==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=EaEq8P2WXUwA:10 a=bRTqI5nwn0kA:10 a=QyXUC8HyAAAA:8 a=UqCG9HQmAAAA:8 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=TATMwWlPqHHbbuS1RdkA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_13,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2409040013

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


