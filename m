Return-Path: <linux-kernel+bounces-530184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997DDA4303F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438ED3B1228
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945C1206F38;
	Mon, 24 Feb 2025 22:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R1ri7RxR"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968471DF73D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740437412; cv=fail; b=BSCBfmsy9BRHh1SLOgLcEOSytVwanC8XrwiMFMFn/XoYuhaJthjIOy8PvZXuFCxn15m4f5wdfuvavVFT5DSEWKwA8Lp3k3MEKiAnX2HYADissj8YPd+DdrQuU6sTRAkZwg7Sje2fTpY+L4/oXQ8ZmCoh9qUF9S/4iayObAWlYa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740437412; c=relaxed/simple;
	bh=rpPfhDJGzbXignRZ4/L761seZwwD66rSh4Up4nwQdWI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Z+2+0NK/pSQH7NvaVtksEkoD5wgRlJpyO4MCfxEBJZLXCu5KzCT5W3zvjx5P26UoSfz4ZFCtT3pg4HpLrwxt6AZtHZ+IsijCIY2OkXdHOwqKEJKc+V9IRw+p0phrEN5ofhaAGSZzmg69t0kpdm0CIeetYXp9gSNSJhXLi4rGPiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R1ri7RxR; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yylpKlRkbxbKG8WSVaJ/tgwW479TAmL98IGt2GJLFOl6G+OhJZcFBg/ChSNqnP76uMPWlgnBd613VegxBkOu5sS2NbmqLjQU3mpSPy2jADFRV8GPzVAye+ft2sw/xtjovcSsdXmuXkJeOjSzpEttpg6NlEWX18sxqBzsFf5Qy/WjGTYNqXw296mWm/SODzTVZPh1iMOq/McxOjoIEycB2xCV+w/Ol2HKlvboGXiIU8oBobn0DGFovPj91puClmwpr5KWWvpWJJf4iy+MiWXYeJk851HoxDSeQSa0PxM3NX/LZIXJvjnckzt/78IAU3BSQf06xPPVPubEIsbadoz4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPBk1X9DXR/Uc0t8gJfpEhkB/T7mTLNC0es176ElDWM=;
 b=Wdw+XR4Td4M2t1Sav9z0SLud5h95xbEKrrjyOD1uElI/loRrq1R6Z/Ct7928iYZ3d/u0RJEJIuunipABxmzjDpa4Py+6PPgZOEDJnaJNeS1FQkKBD/w09sZDiHRJTW9jhSRlwa+Gr4f1cy9jffh01MjBq89Nv4fjpqPvqeVRIKy680tSRuEIm7T7gNF6Rit8LpZIS+l3sacgeh7XQnqRKK2mpO8Xz6PmK9xXNHJdA1umb0ctGl90zU7o/iHeA5RgKJkOG8xQUuQh/ihyDZovffiIsJhI4SsH5JpQ8OSfvlLpip+OPwG+dfKzqkhmWf9rch4AChtFocEXy/2mSf4G4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPBk1X9DXR/Uc0t8gJfpEhkB/T7mTLNC0es176ElDWM=;
 b=R1ri7RxRhiviEkCk/akZfoBeHW18EAyRHo8UdhMqZqx6pTxhN8RXGLuwnaWdjORPi5LMAqjbTIjSQtwKBKm5moGcTXqnnK+Q076lRvY96LlYaKhm6w66ki9cGAshbbcBpvnMoQ6wo59nMCaHE6cV5ELky2GAdazMtwvt556H3CkfzqM1nGEY4w1JDLLVRqpL/JTX135tnZy1ntTc+RtsE5G12WWTxynYXRS6hicpkAU4+/6QQD6QuL1rmKvkYxL52TCz7lmRhMrGk4pkCMik68Xj1TXPPjh/gjXspPxTxGkW/j2EJFZstIrDxV3KhKnOfi7whI6P4MJRlpGYXHWDuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 22:50:03 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 22:50:03 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] tools/sched_ext: Provide consistent access to scx flags
Date: Mon, 24 Feb 2025 23:49:59 +0100
Message-ID: <20250224224959.264808-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0249.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: bb26afe7-680c-438f-7d32-08dd55259391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lQU6PdK8K+DSdBf4dSeytHG8EvKoPRHIJjzHq7CJYea/GVkBUJovorpAyIZK?=
 =?us-ascii?Q?B86XKDPohfiZnhyB/dDBk4j7fYrmp8GMq44tyGknkZvKRlg/eVEB6Q78b+Ky?=
 =?us-ascii?Q?iB6tLuJk1Kxe26oWwweAqm24DO3mczCpxsvpxksysdR6HRxVg9TCOiUjfEOe?=
 =?us-ascii?Q?rYi4RGr5FWXkidCsXsaoBz2KZMPUGknq7B5LmgZS8Zi0eBF/zKRk5YaCF04E?=
 =?us-ascii?Q?AMCj4PO4floqBKtquUgTCV8rmYVGx8Sjx9W1f5fwj3y7KpLyM0sUY373/+2b?=
 =?us-ascii?Q?i4mU/15Jas+oa81uYjT0j1Y+aWey5iHD0UTQlgDdB9kKrxhW+j4M2//wEd17?=
 =?us-ascii?Q?BpVWuhaJZh9YVmqWWUX8BrGyCTpyb6dOkeb1/e9qAYfl1mFJp90jQ/Tv7rPP?=
 =?us-ascii?Q?AXz6kMCsAQul6B9qYRihF+u3up2XIMUYoIZTxOnXP7khhmMtYgO9URozu9Yo?=
 =?us-ascii?Q?QleiTGPTZHDwjj2Zj8mclCK3FZdJJ3e1nbKkr0hroavhMpguA/vDJVuK7LXW?=
 =?us-ascii?Q?KcLhhSnYb1VhVk3lbv6dsV2TE6XJFFPZMd8XVQtIvLIl69nspiFwn5+Q+RWw?=
 =?us-ascii?Q?oEHbsoABqVzxyJSe8/CGVoejSzLUnuXCzRW4BPYBePSZuOUU0H75pGeJ5ToM?=
 =?us-ascii?Q?JnQZRvuh3PvDs6MVRc90zv/jYO36Ucl61wrGhfg/d4EGUaEkrtSsNDfxC/3t?=
 =?us-ascii?Q?mh9NoyonSBS4xzjZyusPqnOJlDupORTY1A4Kx5u0qQHASRNGoamuxmix7b3Q?=
 =?us-ascii?Q?Ds/5AGsVFcAGyCGT9U3XORksKK4D5E7tJWni+1RMwopDllYWRmk+ifezavwD?=
 =?us-ascii?Q?pOkwvU0Yx2//KdwGe3ydMxFK3Tzre+m9O8EJug5EZ79wVOMfRU50olesf7J/?=
 =?us-ascii?Q?WoJxXnDb/wyFoQ16OIc9ATb4njcACaYzD3JWuEHyYsHWPfwygfJt0jfyqFZR?=
 =?us-ascii?Q?1oVAcYBxT+F+zgIX74eumQkquZWbAYFMjHzKgZtLt8rI38u602hXQFlyTy+M?=
 =?us-ascii?Q?icccTlXpJERTjDgdI9ytiwYOiqjrZ1xkAjJPnQFqp8/xtqUhgiCtAX8egBLQ?=
 =?us-ascii?Q?ZFQzFIUm3u0X8AhzRsI3E31lu3jCFreX6iI3zVODF1+7m4KwNd5rPMdnhsne?=
 =?us-ascii?Q?+GtfhHEX8I7Qt9F9rTTMOb8MqznYwwwgCKLHno0aAmSqwl0PeLwYo2E0Mria?=
 =?us-ascii?Q?T3YSQ31lyHmRjrlYXRzv4HFPZKw3BuWQ/vUjzxh9rZmtg1f6u2H4djJVg9ar?=
 =?us-ascii?Q?M+iFCzlLUnttteqLM6ANBYVX1qkrQfy3ao3QuU1g6TAQfnW1GyOitP8SETIs?=
 =?us-ascii?Q?8iLu2HVoXUSJvScy/hf7TVCASgyJWGAdeAy2Cq54BYVWpCpQvVQZjY9fWxmW?=
 =?us-ascii?Q?4dfye4giKeSo8eiHQdHmXFKj4Lho?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5M9+uLh19PJiUK77mJjL5DL/vNlq3NRe9WOuUTrLq6uO1zgmJTzDfAG+m3EK?=
 =?us-ascii?Q?9GarU7TIvnEAfmoRj+CRnYwP3it2NRjr97m2REowIjYrT/HUBikZkJv+/ckW?=
 =?us-ascii?Q?RfTmhVWXqOZKXr2fzzp1BW+Cb5rnmZWS1aNjBciYoVuUazmQTofxmLYgW/Vi?=
 =?us-ascii?Q?eBrBBBQUgzbQMbv3ptVO4WGk3lCqEp+/nivxlWbqw2bwG2DBeKUl5UMjR0Mb?=
 =?us-ascii?Q?O5N5IVSsIO4IcDPdmGdLumDEvChm8BshtJIOCWpHTgk8vtt0nyq8//+2fmIH?=
 =?us-ascii?Q?5AKzLdmTGAdo0EjVqJa0SG+2/1DudNOkwmTg1Pd0z8hBuMdtfHY2yn1CL5y6?=
 =?us-ascii?Q?GRBBf2Ad2ZUlM9GJm9TwrvDcKj6adP+iUDyKGJBSf0Szn5E3gX2/XcE7iY5O?=
 =?us-ascii?Q?ufR7jsrHqwwcBWml2s9RBXZaFnV1M9AXRNhwMsewwGJLzbWepMbGI+jjgBYd?=
 =?us-ascii?Q?WNSyA8JC55bXXAR/RMPl6rg7t6xEN0I6Y1TMPn750BWersWe67gI49F/LMUt?=
 =?us-ascii?Q?ZQfNDUyQaiv4IlmUcSIuifOq4rjITk8+iR/1RJmW0HLzWYw7upPSgkeR5LSs?=
 =?us-ascii?Q?h9lkjK02HGFWyOqeIJce7HZFl21c2us6jZfF7jyLlwP6/q0slHqWMAnEfR1j?=
 =?us-ascii?Q?aAdlPuufkPie1r8C81Z2HWNT0fKa0POSZYyfXwXTbKe/IE7fBoFw1nlFH5Uz?=
 =?us-ascii?Q?+V/UF9Xxv5zhj6G2lE4eLo/ufDnkIS+dGiNjjviFclRDl80DJQoixEX5jU9z?=
 =?us-ascii?Q?SkWafINQNuteH8vzTaXqvP49FvVs0Isiv+OCBoFxCna24XfQ0doRzQRlqEjq?=
 =?us-ascii?Q?ckgMEsW9jsGmrfBsB3+kmJsa186g1S30I2Ab2anUlieLT6STJV2LYB5Ks5nj?=
 =?us-ascii?Q?lmA2/BHpsHS1+uPQhmGaCqapoXyzWg48EwOYivNCPlBJ/ZC1nFMDJon2ipnJ?=
 =?us-ascii?Q?w/lnkEbqi5brUPS6eJMMsdc9s+FlzDg+tnTTvl8DZCRLLv0cBrxh27kyo9Ae?=
 =?us-ascii?Q?hE5F66O+RbkCmwxRXJ6lkfFh25t8Nb/YlFVru31BAbYhtsllBzZ3p28bTIJl?=
 =?us-ascii?Q?3HUIxIWWLl/+LR3HW33cJHYjqG/OvjTQlMGQB54O1xnxcx4Si4EfdXncsm/m?=
 =?us-ascii?Q?IUPZsmD2r51i//wYyQIU5ic2uLd4hT1kAFOc5o5uNuVEbMlquKLeKcIDFf3N?=
 =?us-ascii?Q?8KEIVdXCKvJVG4+v5O9ptNYNAbZyFQjinwbYPfl+snZi7NJc7g311b8vgaf/?=
 =?us-ascii?Q?VmAcqiE7V3c0iRcpXQDmiXQaZ3vsVCDiYYBd+cxgfpMRXkV40eEbiB9xPsCZ?=
 =?us-ascii?Q?ETTg08Jcg+gmEKXVU7TLUsJyrA2LqeATnfK1dr6HdOpnHU4D8lF8Rc5oXbtc?=
 =?us-ascii?Q?KpQVwH5Xnmdv7tt55rj031/n5qX3ucqQlza/gixBRluuHdP6oM0vSYKqkDHv?=
 =?us-ascii?Q?e8C0tRm5lbT7DxVZbT/hgIMFx5V8icweux8Z/8NRfZAJ1s+KYa+y0liN9bNc?=
 =?us-ascii?Q?xpAeBNF7G/9nFzUIYxQBcvWONDhUN5X8nGc+rVhOeqn5+ZEn5AOzxrkW3iWF?=
 =?us-ascii?Q?Pb+oJcmuuJQ59frYpMfS43p9Ov3EZqKXuzONaVX1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb26afe7-680c-438f-7d32-08dd55259391
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 22:50:03.7127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96pN140038Xv61LFjfVKV7OF+mzYRSYgbYOfUDc2Kj+KIPcEwi37Lfc9YRMkJO9g3ZF6pJoXtRebrzNQXMyjLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039

Make all the SCX_OPS_* and SCX_PICK_IDLE_* flags available to the
user-space part of the schedulers via the compat interface.

This allows schedulers / selftests to set all the ops flags in
user-space, rather than having them split between BPF and user-space.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/sched_ext/include/scx/compat.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 03e06bd15c738..35c67c5174ac0 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -106,14 +106,20 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 	return false;
 }
 
-#define SCX_OPS_SWITCH_PARTIAL							\
-	__COMPAT_ENUM_OR_ZERO("scx_ops_flags", "SCX_OPS_SWITCH_PARTIAL")
+#define SCX_OPS_FLAG(name) __COMPAT_ENUM_OR_ZERO("scx_ops_flags", #name)
 
-#define SCX_OPS_BUILTIN_IDLE_PER_NODE						\
-	__COMPAT_ENUM_OR_ZERO("scx_ops_flags", "SCX_OPS_BUILTIN_IDLE_PER_NODE")
+#define SCX_OPS_KEEP_BUILTIN_IDLE SCX_OPS_FLAG(SCX_OPS_KEEP_BUILTIN_IDLE)
+#define SCX_OPS_ENQ_LAST SCX_OPS_FLAG(SCX_OPS_ENQ_LAST)
+#define SCX_OPS_ENQ_EXITING  SCX_OPS_FLAG(SCX_OPS_ENQ_EXITING)
+#define SCX_OPS_SWITCH_PARTIAL SCX_OPS_FLAG(SCX_OPS_SWITCH_PARTIAL)
+#define SCX_OPS_ENQ_MIGRATION_DISABLED SCX_OPS_FLAG(SCX_OPS_ENQ_MIGRATION_DISABLED)
+#define SCX_OPS_ALLOW_QUEUED_WAKEUP SCX_OPS_FLAG(SCX_OPS_ALLOW_QUEUED_WAKEUP)
+#define SCX_OPS_BUILTIN_IDLE_PER_NODE SCX_OPS_FLAG(SCX_OPS_BUILTIN_IDLE_PER_NODE)
 
-#define SCX_PICK_IDLE_IN_NODE \
-	__COMPAT_ENUM_OR_ZERO("scx_pick_idle_cpu_flags", "SCX_PICK_IDLE_IN_NODE")
+#define SCX_PICK_IDLE_FLAG(name) __COMPAT_ENUM_OR_ZERO("scx_pick_idle_cpu_flags", #name)
+
+#define SCX_PICK_IDLE_CORE SCX_PICK_IDLE_FLAG(SCX_PICK_IDLE_CORE)
+#define SCX_PICK_IDLE_IN_NODE SCX_PICK_IDLE_FLAG(SCX_PICK_IDLE_IN_NODE)
 
 static inline long scx_hotplug_seq(void)
 {
-- 
2.48.1


