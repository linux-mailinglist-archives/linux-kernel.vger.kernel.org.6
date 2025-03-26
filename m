Return-Path: <linux-kernel+bounces-577574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF766A71EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08A53AF3F4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7648624EF73;
	Wed, 26 Mar 2025 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C7JjcTQ9"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F3315990C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743016744; cv=fail; b=PrUC5LpQtITCZ+3CxK1iHxJiPgMsvSFjqz9QslS58S4hK3Oc7klM3hjsF5/OjPHXNu/g/hVPL6i9pWolUaKmcO8tEkRHLyVlWDLOdNJZRCfSUVJ1z8Ec0SPdUJArQQ1TnI3Q9Kki8iLo8bOOS4dfgAh8AubuhGgxvMjKoRaoWGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743016744; c=relaxed/simple;
	bh=E7i+uMB5+29Xp7saZd2ouf3hOPczxh1IvXN5og6tHxw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=M8H6u38azhV8YMDbob1b1nMZ/3qVz+jwnk4dYg6/kX1F79tdcb4dNFeEHWCHPswPQoVW7a7KldnkwAeWRzFahKaH9ZG1acSDBMNu1t8qnQtcdVjEbCx2sTn6/fZUxitwfft7entcwFvrW8gvFlfjKXqskEyocigT478BlSZrZu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C7JjcTQ9; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0ibEe0WRLQ1dgv5vfiTPmImBQCRsiJeu3EW06s0fK9VWQz07/wT3fNDpU+taYp1RSAGs0Bhuki74sjPQOeC3e8FrOSocfjkntAAEFXcXYETchhG4QwsJsudERrHw3zhve9xwOGtXDia1dbeWE7ozba4/ulgVcmqR2n/Ya6Rgfgj1QArwfsxsO3rq5WAHTdm37mZzxbZjWE/I1gE92wlup12EFXMabn+Nsak26s4h2w1CJ24uCF58Jug1Y5Iy9zkMDBW8tFHRGTwJWbjHou1gcnqz2ABtav6H+M0/iOqKg2dvZo5onZfXMzmEJ8iJH6ZyajAbFQT/UjQGhmyIg+eDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHIBbo8ZDbSeCmpwO41HrrbFB4gPtaJUkY+5xfNuQNI=;
 b=LvbVnN+zf0QIvICR7uEAhpF82RA+y37SwGWzv+Kpblk9Plxws77M3Df3Rukqwg5pca10d6B4AvV7EunM0dCBm0H3o0dlqYPBUnWgYuBS2oKD6MqR15X0hUAtufCH6x91xPCVthKDeFMG9bKjBrAYwyPXpUUJXx8hmzZfjxXCu1BWvRfGenR5x/c7xfo6q7+w7P8+K5AA7iLLpSb8pupS9i5/ICaNWYSir32/T2ZgWteakp5lUyj4hUVrskkYge76opeK1FwLf0z8Ml0j00tun6/A7Po32n0+6XtwKGZQgQJ3KOpxrRvj8Jm/K9ZnSukei9KoWFqRgYlhrLIMC3UhUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHIBbo8ZDbSeCmpwO41HrrbFB4gPtaJUkY+5xfNuQNI=;
 b=C7JjcTQ9U3A2QqtBlyssSNml9mVWZg0zVQTN+HrMKB0pM7KRflouk6dcKrDWoauFoTvge91GwlTZwoDJ/3C2GDIESDIQZHvbkXGwBrl6gAIHkLABSXyUoDDamouKLDy2Av78xLYOjAnUVaiB7SfICGf46v2gOJRlW1q+CrIVDmH3j4X3JJRgx7CqQO3BQYqQtr6hJls1KWv+FDW3o2wPwhXN6CjhCwqLyp9VyNp+8Znfyd2wDh55jjdC1uGIB7bhiUKKxfFGurSi0+hCOoMXs3pQF1pVAeGKeN/qub8kYhdwLRPvqcXjeTYXtSOox53kuZCCpU5bEixGfvtE9Kh16A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CYYPR12MB8889.namprd12.prod.outlook.com (2603:10b6:930:cb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 19:19:00 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 19:19:00 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: idle: Fix return code of scx_select_cpu_dfl()
Date: Wed, 26 Mar 2025 20:18:49 +0100
Message-ID: <20250326191849.195303-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::8) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CYYPR12MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: c5da177e-8309-4dd3-81f9-08dd6c9b1001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QckmfS01ry5Y+ks9lGx/f42EvztPQHXL0ZGklqT+n8sD5ssGFDYInJYKJZ8C?=
 =?us-ascii?Q?UPnVcfEbmk9dyCNGGUQc3tnHb7P582pFTwYAPQnunkW0pYDO2jKvIXeq/IKD?=
 =?us-ascii?Q?k/Jzfc3KVGpIKtR+JjNYBegw41XHJTOUEUy0hfjj8iGKy6ZlEzR4THZdnQi/?=
 =?us-ascii?Q?5Z5kE533SRTE4vCo5Tbj7GginUvRAGpB9DYX4UseZUTj0UVN/WpCAZtZTuRp?=
 =?us-ascii?Q?JdVoWc0T7IbqnJqk04p4M8Tc7/IIuMGBFqmD/hRZ5C9xKoUu1HabCWrBvZrw?=
 =?us-ascii?Q?npGCEZxu01rCIV87qXKHVgRbKSm4sCBG2AfimCOZaxciqq09cGdlLnNOwx1q?=
 =?us-ascii?Q?RDUuWW5mX7RcNK9foANOJ5zFPxWjA8RebFFOXl1XzhPKZOM3q8njWKWQHrlM?=
 =?us-ascii?Q?cvIJ826bRKUlw3ev9V3tGwC9OCj58CCTkVMTSOrVgSD/oVZ0Tvt1BpifXzzI?=
 =?us-ascii?Q?38Xi0kc4hJbV8xPOLdoEF8hgCY80+/2urIK8AqjpAITEChAb8aFwdknyy2sx?=
 =?us-ascii?Q?v8cdrLVJKfD9TayscwVGJL6Vur07qt1v09ApmPkfE8OEd5pncTTtexJ9BQd5?=
 =?us-ascii?Q?YTmPrGtfTfwwVnDS1TxVvqpeUB25o7bW+d13/Pfg3PvlQPEfHUJaps6eJVv+?=
 =?us-ascii?Q?EmecqYFn6joQYWXAr+371Y42crgTn5lY4lTBNQyLWTlCi+St9UODRMm/fHGL?=
 =?us-ascii?Q?5k+2Q8B5n62yW8Hf2yNEcMdozoopfe9LVQgVGXg1pSSs714mEz2gqLykRPr2?=
 =?us-ascii?Q?+VyuIxHTPRFYygfWRQ2cfS9MfKnrYocieeUx/ZqpJUP5rO/DiHGjWbwntDif?=
 =?us-ascii?Q?1+TwQm0vnDKwF4QaqTr/3HWQY7xNZKl6Jcsh7v0kbC7oApKh35jH6le8t7yV?=
 =?us-ascii?Q?JNgcZ3PJCbZXGp8QDeqS+Wrr/qmFZLuStMxAdVOM00Zz69vLVp1kWRTGQ44c?=
 =?us-ascii?Q?z/2Z9GBsjbFahBMhBvlhgt/TGUwRHKFGg4vPr8bAaqwLw22yEtOZS0J87ro0?=
 =?us-ascii?Q?5WqlQ2dxCGISoKrmtIvnEm/GTLf4sTUWIHTuBytWXWaKWLGsSAdCj8uEu2/u?=
 =?us-ascii?Q?vrT92dAVzDu3OuLp0ovg3+VBIsgZ4tkdzHho5l7+otuy1Hjv0XW7GvcVKpbm?=
 =?us-ascii?Q?NteyZTSiQWpJX7IckFah+lvw3W2Z+2llUKP8VvVfKtf8JNUjsoPUw09i9ERf?=
 =?us-ascii?Q?TL6VdujgcYF4t5bF1hVhw6zU2nMAQAjl8OK8kk0pTwFwuM2jH2hPWf8aWsVH?=
 =?us-ascii?Q?T2uqvnr8ro+gx8RZi6tjrnu+XXRnkH9PXumia7ae0Wi6p7J0KikQFL3qkVBR?=
 =?us-ascii?Q?coPiZfybE3QxAeadHFjxfu1Qpc04kvQ22FYs5o61ZNTULMUPu4ZzUuKaLQjl?=
 =?us-ascii?Q?r6Z3VvEw6sNCd7WtTLZfCRAnw9od?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PC12p7a31iDAoV8fl8HQ7mixERCbNMPJXwMWyPOJl5/NGJsP5mHItU+4B/b5?=
 =?us-ascii?Q?XwlnikgYWRaBNdBQcefeHD4IlNWS4kI2OQgheoWfSlcYKYZLT7Br7Wh4cpH/?=
 =?us-ascii?Q?DpcTlLUyu4ho2H2cN4wGvCLid42sL0SLpb03Dd7ba1bCelgFkVOPW1cARDZq?=
 =?us-ascii?Q?j8mV2ZFkeBKw1gyoiua/I/U/eoL9+RyyEvjc3axTk6KdWghrgKJqQD4GeWlP?=
 =?us-ascii?Q?JZ83UqcaVa3t2titP5ihcbuIu5WSdIgiTY1Si6Bn43MWuFK3h0oyJL6Lw01O?=
 =?us-ascii?Q?3OH49TRJNsmt+NjDwQZ+zfqhVgXURibIX2tNIr8DwjR/92tvfJDUnnf89h+Y?=
 =?us-ascii?Q?V+4PycSjDXBS8UcO0A2kwfq34IU4jyYu3cDaMJdO3tA9fegbapkFm8p7Upso?=
 =?us-ascii?Q?2s2nzgIjV9t5c53hZF32iljfYrdyKbym1V+fk4esB5YmF4Cdr04Hv/M2mkKX?=
 =?us-ascii?Q?SIErzxPuk3Nvf1S2n72ku6DtVHddXGGYUVVvB+nttG7yGsaLZtLmjoYXt0xy?=
 =?us-ascii?Q?6GM5HAZrT3D3yXXimo+ImZZq1aUGWZorj136wWtinw6+B4BFTweF3m9+qFaG?=
 =?us-ascii?Q?webTrhBRZ2xyKp5z0aVOPunnpmbBt8N6HVooV5TWNsvtJ5Y3csXNnWC5LWW5?=
 =?us-ascii?Q?g3bzlRhZnKVu31O6FwyTMVKBQYHOWcqACDd1pDwxAjCzqXYQHtaaj651QXvR?=
 =?us-ascii?Q?N+R3Flm2RLaXm0mrrv5RW89HIyQMFRcWhY3ol7sygIVBLhdJEz97SdHvLGS3?=
 =?us-ascii?Q?rUXMrcJeyCFkp5agQbviKGnq50oCaRCtYkw0BfaxUBQMpQgljP08yaucj2KV?=
 =?us-ascii?Q?Vq+dgWTVGVhK3Iuvzy9SzxpDmAZEHAO6jaTylY3Rjff92vMcgsNyFLkai0ii?=
 =?us-ascii?Q?epeO+v5rCZmShtftfnVpQ5gSkNndp3IoQWFz7G4t7a2gJytSyt4VJU5DBY+5?=
 =?us-ascii?Q?bXJ3Rnt1Vm9Mn7bmX8O+60OER6UVk+UBvkXr8q0z0DZtcrEqcA/FI9AsIa9C?=
 =?us-ascii?Q?Opog2Ls+/rrfnpN+CtootLzH3GLlOvMkCF9sA/sHtRoOo6xd5tzpnWnU+Zw6?=
 =?us-ascii?Q?YgSrLKvRSnti2QbECEi6lJkjGjpumGCR2XyPsWTTqvObzEaow2rqFX3kGlnO?=
 =?us-ascii?Q?Ax2bSZ8Tp5DFV7mULd63EVlzLa9CWdKPbiGTyxZ9Amj40k1Vi9849pkS0JmJ?=
 =?us-ascii?Q?8jE6YDSbQBXBQJ3+QH64DX27Iy0izcmL0wJ+Zbu6s0d0+iwit9crG9UpLQT0?=
 =?us-ascii?Q?bdM+KoAiF3iUrQpbCcdchxbsqG0xMWUmJExiHAVC7puwR+H6O2jZEUIeNVOw?=
 =?us-ascii?Q?Ig0ajG2OLBxFDJig1aAoo1mWgx4SiADpbuDQpupieKvfI5we4Z+YyzTe1CCw?=
 =?us-ascii?Q?6UwihuotbdYZekPMz3wvw8rL2JSMKVaN/nucVLW3gXDB3kSM2yEh6uGeC18a?=
 =?us-ascii?Q?49cbjcpedO19+jPJ8eqzceoMzxTM42Asso/lVmkfxyx6UgQTIdHF422MAhsM?=
 =?us-ascii?Q?tQ3YYaIbDmRKAhutt9goaw1n8HOTMb3+QMvFLdogfjWdA/rzg0Kj1Hnt9Is6?=
 =?us-ascii?Q?Kx6s3TS8MlBsfglmYbcJVCwcpiYxvucaFNuRng/f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5da177e-8309-4dd3-81f9-08dd6c9b1001
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:19:00.1987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8+2w7bIk210q0TpbxxD17oubjfwrsCWCySw1fOQQAZEK+ktK5cLdzcY6spAV2UYJnAJUaD3Ej5+wNJEopQpUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8889

Return -EBUSY when using %SCX_PICK_IDLE_CORE with scx_select_cpu_dfl()
if a fully idle SMT core cannot be found, instead of falling back to
@prev_cpu, which is not a fully idle SMT core in this case.

Fixes: c414c2171cd9e ("sched_ext: idle: Honor idle flags in the built-in idle selection policy")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 52c36a70a3d04..45061b5843806 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -544,7 +544,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		 * core.
 		 */
 		if (flags & SCX_PICK_IDLE_CORE) {
-			cpu = prev_cpu;
+			cpu = -EBUSY;
 			goto out_unlock;
 		}
 	}
-- 
2.49.0


