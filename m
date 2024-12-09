Return-Path: <linux-kernel+bounces-437064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638D29E8EAC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561EB1630D0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58509215F61;
	Mon,  9 Dec 2024 09:26:03 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF54F1EB3D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733736362; cv=fail; b=eFbAXIVxtzR6QM234uwvo07UxlkYT04Jq++Ff70/iN0Qp8We9b7wZQtH7TmMIkEchfSPf4HdVdduVmL2/Od6qKluabE4nqwX90TosrgOle6LZASFaD4m6ZFD0kj8YkzC1YoB5qnA9gNoXu8CwdZ6nsIhVuIoDcdAFwhNoayXE2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733736362; c=relaxed/simple;
	bh=gGTZmLU/l+hiDv+OAFOy4lNIeYAdZ68q/NBroaWisxU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pJRaTTQ6CN35gR4xvPcRatl++jFgZUta0P2M/JxQWOv6kGRhsX7W+fHUCvq/MhaOVuDcq8+AmEXXe4j7F40oq1dIyxa09ZG4/UrNdU2znWxdcz3NbcIsPTMroXx1bCNtK1AP6wwWMRLMvpb6VknTj4jN+9XeXNn8AM4MLILBatk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B95H08W018151;
	Mon, 9 Dec 2024 09:25:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy3h68r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 09:25:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPsEN5mYfRRvOA1ZjCTHOSRc6aZ1zRDN6Nv7caYmhV+p6+hS4pMN39x1NAC21YlR3fZwtD0rVzZm1f30YcwDvyq1OZTKsm0GBIBXl9hw+dvi36yhax3kVhgtgkShvQ85UTGTS4AJIg9bp3a/GEWsibnz/LpYT7qwxlruqOOq/C7zCr84B6zVbINAE/G7cWQvkn+ukIllZh/irGyrEXTmbDdqOPPeX8MhxPHmtJICx8TUkTYFJONcwy9ZqZA296sD6eSwJCI2Ocn8aqJZnTI4nbrkh9YFJhYvliaZlC4c4h0w2pVdxzwo8LRtw3duqQ+DjeMKklt0Jt6eiSXHl5+DkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Qm8Qa9AEy/XQgqVAKnNfrYeba8ch7cyhvvMwN4kyuA=;
 b=s4JqiuHT18cFJ5D5YEQ0pAaYCmgYWB9GYewIu/mQ244AN+O3+ZCGZEp1V8vxm7xMsMZA2CBn317ZeXSvNwts27xJhDaTCsx0pOmk5Vz7Vgr51bdYk0bycHCp52LAhQmetJK93qWT87m/yDGBVU2uML/a0taoejLF7NPUfvy28RgeftkFHtCAkoFm0AD0S1+Oc8LBEwTJvtJFmLfrnO9n0ppAUYhBYsLyg+WXKRbZU/6VD/s6w+MJgKd8PvMCsNaccpEBXqP3BZBAwdAYCJjmcD6q8yQ0by8v8D8p+gTG0ykdWJov1kooZLETjujGhRA2cQSISxbX3N4gUvw8BUbetA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2671.namprd11.prod.outlook.com (2603:10b6:805:60::18)
 by CY5PR11MB6164.namprd11.prod.outlook.com (2603:10b6:930:27::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 09:25:40 +0000
Received: from SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326]) by SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326%4]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 09:25:39 +0000
From: guocai.he.cn@windriver.com
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Skip inactive planes within ModeSupportAndSystemConfiguration
Date: Mon,  9 Dec 2024 17:25:14 +0800
Message-Id: <20241209092514.506660-1-guocai.he.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:3:17::14) To SN6PR11MB2671.namprd11.prod.outlook.com
 (2603:10b6:805:60::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2671:EE_|CY5PR11MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: e006fd9f-c42a-48be-e5f1-08dd1833723b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gkh5JTn/IYmOV4f8Wcu+6owInSOUONM8PBLATKtErI+ii7Q6QQjCq1GahRFt?=
 =?us-ascii?Q?uSpaldCw3nS6KieZdjGuBa2FfRx5Iv6TDpsIm/jtn+oKjDIAIWdoVh7Q023M?=
 =?us-ascii?Q?UoQaUGm1cJjKOfDaruiEYuk26Mk92Z1LBdE45WojNiSsj7KGG2NzjBfeKRku?=
 =?us-ascii?Q?yjO/4B/DeDJeNHe8EVEKJGi/+9FZONOJ0OvbZ6guwV01Bcg75KlC4qsD5dA+?=
 =?us-ascii?Q?S/AYIIzmgNPFsHLNZp0yiJD03QGdrht/peVZDfDmD3nnI3maXBpLa1QWaltV?=
 =?us-ascii?Q?T8x6yqWrWG5eH65pCO1vyAMwoZ4QD+YEwTUdZ1gm5wdunNm7JrN/XBi04m7x?=
 =?us-ascii?Q?1nNqvae3ADgpX7ejrr1XdGNc1k9Xq5YZL+iKuPgkrXY7czAS3m9cXgug+SSW?=
 =?us-ascii?Q?4DKy330nelxEpdfkknzU94eMEL1XVj1Uj/q8kT7gb+4hRyKHRF/b7mZCRntR?=
 =?us-ascii?Q?+aNy1CpHWjFVXixwon0H7uEKplNIy7QmbOVglQY5cd51pwYWcpPAzp1NQhKl?=
 =?us-ascii?Q?ffWiS5+fQks5GzUzu1a5bzUqziahJeJ8NqwTX9Ej41UeoFuNX8ImaKeuORi3?=
 =?us-ascii?Q?FpKoR8ZzKlEqkhoDcOBhY4MmaAZT+BXF0v7dEep+/ZakbUxLIveTlCOd/NUP?=
 =?us-ascii?Q?JocmErclU/9ATRtHt2Uv7uzKG5Xd7NH/dwAWOTRSbmyd2r5Pmu0b8ylMu/I6?=
 =?us-ascii?Q?mboHZhN1IY70n2B8OwKUOaGNkDsIbkR3ponh9NaClx7o6PI05vl1MNC7kZX6?=
 =?us-ascii?Q?nRfdXEIC5Wdn5ETITOWQ61HcigUmQxzbGvzq5ik9N/EFD0ccggV3oM2xGkEM?=
 =?us-ascii?Q?pe1knFHrbUjk4ncp9tz4/E4cNP+dw5bfimK26n8ytl/qsTV2Wtl3iEVPo66U?=
 =?us-ascii?Q?4pXTxBzb6SgCjAcK/738NdcIOrSuXEh/yVnwV2STEE6t2/qFD+xVfISGuhBC?=
 =?us-ascii?Q?2UXqskvJvutEcEc3Qt2v0dyqoJ9auK4jGVdTvqOTjRIR5QRHjbtKqaM/y+jE?=
 =?us-ascii?Q?HWnUWMcMnmGaTIGdEDcT3RPD39m6z+jHppMjw8oLhMAtiD2XsabDIhTWOUOk?=
 =?us-ascii?Q?na5hcDNTEYHAb/bkQ+a3kdc01Zk4+74z3NzWZahd1cm05hrB6KDxmg55rMOK?=
 =?us-ascii?Q?Vyq1q4dylo5/HhhyIShyJkWm/hQtx32sVcDrKWvjmKmE/vf4R0z6qiyEUG2u?=
 =?us-ascii?Q?Qr6zG6SmW1wettMKjw3/m+6LLAD+onHgFPohndefiIZfj6GZVEIwWku1/Dhq?=
 =?us-ascii?Q?T6eHWezg9dLVbsVLAYXxYDZQ+JbEGx2fI5CYzHJ/IXQTNTljU6p/hmjrDuob?=
 =?us-ascii?Q?J0li7IxMQ6MUQXhLp5WyGp4/gq5TMzOxhXrjulx0oCYSzGL4Nnh5T7sJGvUW?=
 =?us-ascii?Q?Ezj9EpXHxJuC+wzEuCqbcabGpSJqJD+qxx/cJzSdfa7JxSUJPA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TFp2+O5sp6Hw9BAF/N4Z9ujaLdVr/ok3JzilCDgDtDb/Xf4aI9iCt9upG3Ab?=
 =?us-ascii?Q?L7mX9P8m+a5BdtuqonZ9PBOyjbfmiFtwtueDEyZ/nPscdIT62A5N135TV2qV?=
 =?us-ascii?Q?3/v2wqavNz85EX7xQzJipIFBU/rKqNRR92ppTea9QQI62PlCFnFvQGT9baR5?=
 =?us-ascii?Q?NxfjV5qyjIgGDu/4KbDmLKyoEa3RrF3zbcypraBqOkgApdoaHLvWktUFrQES?=
 =?us-ascii?Q?39scXnk6DSoaSlFKhWM2VRpCnxMX3e/Jcf2aGlMJ1caX69AAZosfbi8DskYn?=
 =?us-ascii?Q?sYh/2drgXoThYZIyOYsXFGHIjE4fsrl0E+9jN6Nc6mNb8Rh1vWPlOTMPm3zv?=
 =?us-ascii?Q?0mhZPuEhxQlcIuO3Nk2IE3qffg1hcGohU7UAjlokyQ0kYPn3S1dCJgryraBt?=
 =?us-ascii?Q?LdEnx/Af3HkpOaUUOI1FDX4DrlWMwKoos6i8Z2kgC11EGo4bRHviH/qp6mpn?=
 =?us-ascii?Q?x/A0kA7lx0koKcIytb13AdmbSWsNA03cqvoWKO0bC8KXx8e4JTK8TsBagkRK?=
 =?us-ascii?Q?gLT1l+T40SQ5QCUI9adIY21pfqGSCyCIq2zaUdEgL3P9WrPAsbIXQ/FPDstM?=
 =?us-ascii?Q?MKp1YrjDS/BmqZC1BwPMEd9OS3xloZXRaNOyEiXapfz7vGiDn0GGcZmTVSfh?=
 =?us-ascii?Q?eGtxYb7DNAtc1P2cAd3ZP1xkq2/LdtUi++NwDGZj/8yXX2NivU2kniVx7KoD?=
 =?us-ascii?Q?hRzuJPoAnr4LTvR/ZPg0S7ZS+1HWqTUbIB5j2hr4v8pv/+kfAO6kWS6uzTzw?=
 =?us-ascii?Q?lWaGym1eoWD+10wmOhVcVdCCGDcQB/GV7BvYmGTVADxJC+fAPspLLPDI/JqG?=
 =?us-ascii?Q?DnewVswrRv8o1ferfKLXdWSUKn8nzkbCInrwv0gBjZAsvdFXm5f5MtsjzoJq?=
 =?us-ascii?Q?8RTdetshRH7KDagwnvw4LpsofGrvUrmZ2w05pHdFEx1t+gg9rc7+H/LoUuW6?=
 =?us-ascii?Q?uVcLi7TwspiDY8TBwYDgJEamYtet5aeK7qJAJTjzM9V7a/zSYkC+qOpjhm/8?=
 =?us-ascii?Q?MZmaKdF12qXcZNowaZ3o/vrIuPcIDCtev0987i3WG2hpX84+QpvDi/UQ2GZ0?=
 =?us-ascii?Q?/KKOX+rBrUQaFl+uEFX6UMhioo+qYsXwqj3B9Y2Kzn6tLrj53jHQvfx17/Fv?=
 =?us-ascii?Q?dnc//eLnR0VV4ZfF7/JZDh6aelkbK5pNVoE1xleHxJ3gk+0hzgfxrrV5f46i?=
 =?us-ascii?Q?//jUimbqkSh//ze0OAP6RJNEZVbrz8o21KdzhEu5em3nX+EXSY6VVypDfQJI?=
 =?us-ascii?Q?EHQuiog0xfXLFXy/TbtNBCABz3G4J4W23y8gmOKqG7CYh7oMaIwk204n2VCR?=
 =?us-ascii?Q?g/z4wfEdz4v2vhwVXCJrFVxhv/dSTkmacxBiSzKQMiGUFh78GX7rXPlnmBpe?=
 =?us-ascii?Q?c0CpmmNv8S5UblLjrPqZwjFN5lJ22KbiXJNSsn1YfaR4J6YxCkhXudIdNm5H?=
 =?us-ascii?Q?z3tCCVdfKRJFMqP2OZehK6zjJE5xXNBBCxtCmmqPQj0oKfLyXNk9D/xgqSwQ?=
 =?us-ascii?Q?NNws/djlWQj5O00+fbci09CWHOKjXmWG5YbZQmE90byq1nxRwZ1LRKIPiKQy?=
 =?us-ascii?Q?5K1loBaiU4k1GHdC5QjPUjfj+uUzb6nU5S9vUosQafotVu4cXhu7Z8QpGeTr?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e006fd9f-c42a-48be-e5f1-08dd1833723b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:25:39.7378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKVz1iap0Ujk/LCjXfOT+w0sfd5TzJEfdSqlPYuK5/TYR6dBQ9GBJfwGVNMaFXDLsVCoMyUqSAPeBuV2HUPO5fgnfzleF3C4sUwxXnA2A7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6164
X-Proofpoint-GUID: cIaAoZsA4rmGhg49KzywkKNfLYnyWjuc
X-Proofpoint-ORIG-GUID: cIaAoZsA4rmGhg49KzywkKNfLYnyWjuc
X-Authority-Analysis: v=2.4 cv=D7O9KuRj c=1 sm=1 tr=0 ts=6756b799 cx=c_pps a=+kc2f53xTGsvuL7uaCOpcA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=t7CeM3EgAAAA:8
 a=zd2uoN0lAAAA:8 a=fDayMfVfqWylvvLTMjUA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_06,2024-12-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1011 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412090073

From: Guocai He <guocai.he.cn@windriver.com>

commit a54f7e866cc73a4cb71b8b24bb568ba35c8969df upstream.

[Why]
Coverity reports Memory - illegal accesses.

[How]
Skip inactive planes.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Cherry-pick from a54f7e866cc73a4cb71b8b24bb568ba35c8969df
CVE-2024-46812

Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 0fad15020c74..b5ce2a8f4f1c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -892,6 +892,11 @@ void ModeSupportAndSystemConfiguration(struct display_mode_lib *mode_lib)
 
 	// Total Available Pipes Support Check
 	for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
+        pipe_idx = get_pipe_idx(mode_lib, k);
+        if (pipe_idx == -1) {
+            ASSERT(0);
+            continue; // skip inactive planes
+        }
 		total_pipes += mode_lib->vba.DPPPerPlane[k];
 	}
 	ASSERT(total_pipes <= DC__NUM_DPP__MAX);
-- 
2.34.1


