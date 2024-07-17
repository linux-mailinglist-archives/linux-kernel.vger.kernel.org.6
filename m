Return-Path: <linux-kernel+bounces-255654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1293D93433F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4CA2834A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF0A1849C4;
	Wed, 17 Jul 2024 20:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V7luiNLk"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51501CD3D;
	Wed, 17 Jul 2024 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721248571; cv=fail; b=Vm/GGz+QSp6L/PUNSLXR7K1h75uIhmoPXcv9UeZ72KR9hs+lLGazYfmM3FVVaAmmsaB4DCbbRlhbS8ARnJitem/Iegv0iHIqXM+ZnFGPqiNYcRWD5QEi0f5GJzFCv1q6oZZ523te/l7UU3vJsdd/ZfNzHOLrQ08SmAUX31A09/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721248571; c=relaxed/simple;
	bh=Y+C0R/bAZUqZ6x+dqUN5PzomqR4RrP/GmYtCdWwO9ug=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=X7A57CB2NYLGL+NHsadsc8vL4MxYcWHTaaCYTrvS6ixrEsgx07R36+rUrDfwt12GVgRiyQpSwK8YA+joDzDqj2HJiPMTp5Eeib8DBcBOYiBL5N9VhSYK1eAkxWJUoBvPNZitLGjHsjIxDxGgJ2/kgekfarhLnVvAmHY1fWXgHEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V7luiNLk; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChjG7vUMewNWXAYVRPm+7FhxmYlQWRCjhlkfDt2HIEkZl6/WoXqtVRU+1dFls52QWb0u3nnYZFq0psV991CTEw2gXa1L/uCMKCIPeKpgG1p5gzm5hxhhFP2TjtYjjqcHjYKr577/IGhL+9Szr/HAeVwCOxQPakpUMMxDiZ7lcEViolhcs6wIA7G4omsfpmWOU4TIoTsP0SpvnqqgTnaq8cV5cSVW+aL3h/N5gpRUjg5wuwFFvaQ6e55HfnGjBB4evgOLWKw6lBU7HzWM5oRD8nzpM+04X26L31pJjO3sh36VtnFdYo3hy6Zrox95AifZEqLDwYUea6FMHXMar3YUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iX5oClJbmzThQ3+CbJd1l69msMWpX7vpS4OrW/HwBoQ=;
 b=l45295JjQKr16OSogvBpHWjf+B3ylGVjuQhObrm+aVZVQdgAfNB7UETdUrh03KE3BXsB+roqU/kVCw5BLTWcBQRq1uYela+Li+Wt/LunvRvmq1OAqdUMg0XiQWcY7h8VMMUhh5yuar77n850fX3qPZpw4V8Umuoqza3YkvrvQgetgtufntNOPmBJXR+4+sJu6yue/4ZiQaVl3L5hV3ZyMLIEmotg6gUNqP8l4blHj3DvhbJxZ1St/BVECYCe/vGxh8aXVde3aJq1RR2VIoX7SQG6iyrCxd0veKq3CreJWUsbfPmuYjH2d1qqAksamzkGqCB5ZQhp8RC3CCtfjNlB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iX5oClJbmzThQ3+CbJd1l69msMWpX7vpS4OrW/HwBoQ=;
 b=V7luiNLkhG60LfU0yt1forVYoQqYGMdxZMRMONyIMvVHUjKCvM++7Bocar2yMdOWQ4x7Z2N+QoRTxr2DaOMyx54vSEKLUwSIonM9a3XkEIsGVh//s9WWMiKJqFgY+hUoABhmmxuY41jp8+aUQLZwqrj4OuwgMReIPP8+ERKWUR6mD5OeJn4QRPczyob2Pw/edB0BkVgkuipLR/HIsCgg26E80BnwcFifXGyuSVDEOA6TH6TlRi0U0oHklapCqQ6vCZO9cWJb23uvrYZoa+QQwUTUAn6XhF7n3ZmVG1vFUechAsZX65skHeQb3SvFrAjl0L1bXiwJtaElc7Iet+/zig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by PH0PR12MB7931.namprd12.prod.outlook.com (2603:10b6:510:289::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 17 Jul
 2024 20:36:04 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::fa75:d0d9:e989:8bb]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::fa75:d0d9:e989:8bb%4]) with mapi id 15.20.7762.030; Wed, 17 Jul 2024
 20:36:03 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Thorsten Blum <thorsten.blum@toblux.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Add detailed explanation for 'N' taint flag
Date: Wed, 17 Jul 2024 16:35:21 -0400
Message-ID: <20240717203521.514348-1-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0338.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::6) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|PH0PR12MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: 7800a848-d654-43b1-bc05-08dca6a013b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?stWY0T22l0eFGk20nSYGSsq828rcZ4TJAHtnHtp9WkMMen8XHTpju3gYUi+E?=
 =?us-ascii?Q?w2N65E656XK0RvjypizxIyxUgwdWlGdY1Y9x7pR79PC/OWMt6ZQBiDT8pPw2?=
 =?us-ascii?Q?iY1LU/Jqetz3J/1Z60Blcmki8Zt2QIip7GuC/pQCbf/cjXjwT6Y5QuM0emRt?=
 =?us-ascii?Q?oCbYW4UZYWPCsW9G5vm9XcQNNWYkrtyLuW49Q/3jxfGXi9DdjLkQFbsp+uV7?=
 =?us-ascii?Q?BMUpcuxsoeEIqCdyp+L5uIjUeVkTzCuNLMrRVIfEizxEWvHlpdAuOwEJGCMd?=
 =?us-ascii?Q?i6m3sdccPN8qKeIEwqafpnDsSVcFjF2ywzduJS32IqqZyW26tqNzJ1/QBozR?=
 =?us-ascii?Q?VBK33rCuakwtQ+TMjA1bikfxejnphByhbgRgxyb7m654pJL2dDyr2SwTR31E?=
 =?us-ascii?Q?2drHBIiXxyi3UicklG400OLRUnZrLY/+Y5MMpYz6K74UYS4q6IZrlbll9wqb?=
 =?us-ascii?Q?r8QUvFqAKjN1oGI8oqMjebDoMqDF5nYvWd9Ymvvd13pNbswQgcMBXmqV7Ree?=
 =?us-ascii?Q?uBswmiqFlC7oXzo3MoYz7/Tz60k+JRJaNcyH4FW0jFu03D9kPox1YqmRy0k8?=
 =?us-ascii?Q?Wip0/szRG+H1zuA5d+McZsjZYmLp8KeNOvaKE4HA2Rig0qKKpkA8/nMEh5go?=
 =?us-ascii?Q?nfwbF93andOm+JxdSQ8mJy1OMxaKlpBUObTLX3Gu9s4iaxA6QLAvfEGK78x1?=
 =?us-ascii?Q?EZNm5Xw45CJqDaEHJENWaRZX1Bom+W5pUCLgrOtGlGSxz1FmR6jswmIrvTbb?=
 =?us-ascii?Q?BJm0HzdswFwSmDHwtJUeUdWJVmoTnh/OqmvrOWxz0l1hcWIBUaaYPWeXbG5R?=
 =?us-ascii?Q?zZZZNwsIqL6dOl5JSdDYW+P4Xq+0ASUNU8+XCwEvQh46yjPiq6+Ra8PJIn8b?=
 =?us-ascii?Q?yS6Gy80+Jg2ByrM1nb79hpu04DyR9D0/eXCw6FE7FRyj7HmsMJ8WJ8+9SMhR?=
 =?us-ascii?Q?dnqHFlfSLuDvlJ61atQUYygpF6sHd44vqT67k5BiHmfKILTpW8jGbAYSv9L8?=
 =?us-ascii?Q?HgJnSuqq+qogqkvHE9z1kc2AIcjDvKInRFZNmej0oOy0WW/70vYvOVxuUQfT?=
 =?us-ascii?Q?7hhc2QFSs6BT55eTsaHtH9s4xvg1y8nZpmCiM2yMTUqUt5VzIFO/XMgf28f+?=
 =?us-ascii?Q?TVNOXRRXL0RGL1RQSectlwxr3VGNjM7OleL2G9KpkvOYrvVT8mppgbkx/EsK?=
 =?us-ascii?Q?l3CCHRVb4xdUoiizFrCg4Cg3nSz7Q6lrDAzzBsQMuYMDEcKISW6NaohbA6gi?=
 =?us-ascii?Q?cfWBVFosDLq4KwEa1t3Zkk564aWFm4bN4Ak2juBJ3QtTfHm4Iq1AYlrNGWHx?=
 =?us-ascii?Q?Z0JCU1M5uVoPEqEjMW616yN7633hDqwj6XmgwWVo0065Vw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M0X3fHEy7xaaxdykhcW5g1qcpirRFlO5cNJo68bC+YTk97E9bcbwmtW1d5MV?=
 =?us-ascii?Q?RhbZEzpqp/0P8OJu4/4JHD3KKjNnuU/kChd/V8Si8fAmS92j3OSxyVbdXs/H?=
 =?us-ascii?Q?T/kHGhU2joGnQBANlVKuHqA7MyZCXslEMQ2z0TSR3m05B3+9JJT+7JbiMw6D?=
 =?us-ascii?Q?izE7JYdAnGFziepscWoneKtQsX6HLpEjhJp91MdF0kmvzY9NEbuNtINaZiBs?=
 =?us-ascii?Q?2cN/LRaDMbbIvhdrsCKzzgo3T4ljh0PHVAAGhkW93yjMhMj+teZPb3zhY517?=
 =?us-ascii?Q?2mP575taezKa4sRhdyly5dT8LqKdhRBdgiUe88lKMh3L2f1+Of0h7wgfsa2x?=
 =?us-ascii?Q?P7eJV2uI2kiz7Gk5quhGw17b1bcmdv+8mcNsdOV4nK0I/mG0X1EUHgr8Dj1X?=
 =?us-ascii?Q?aRcp/L0a9JDnO3VRSxGz5eBDtI/xYw+bJ1q0KxeBzBP4DnF+BuwmjFvua0QW?=
 =?us-ascii?Q?/Aj27WfXv1dRAGAAHlfO75n8oQ+UJGfeQ44CrGKSTM7Zd6mXkL/OJ26qdwuh?=
 =?us-ascii?Q?w9msrItJ7j+SdmDYbLrTFYqBhzVQpAS+BHxjkKjA9V8jOY8WuF8KR6+Su1Rz?=
 =?us-ascii?Q?uZYZCCrMSPat2KtcuQzJ7G/JuBtCltxs8MZAIdAiYZNiNMdC1Khz6qRcrZhR?=
 =?us-ascii?Q?a5/DCjlxsRUd2GQGKM3d5VTmuJMBiLR7IOI9axMKWQrPrjSUb5mK3QdsmWs0?=
 =?us-ascii?Q?N2jAM4U1YKCKwvX43o5lTxJbIapVVhgYQLRN7jrx6IULbmRGxKMcbFkjG5bD?=
 =?us-ascii?Q?oXx9XyJdRiaNFvsNzZbI25eVP2IvbAUhCQvG9Q9LrOe44zBjDZwnVNmPXejo?=
 =?us-ascii?Q?8kBr9JhjMLLIc/DF/hQXeHa7WCiSyAtClGsQQ7xSxidvFZCDHzymb8f1WRbC?=
 =?us-ascii?Q?qLAtY/X7HldC/JdvinydVn+/v7lZxdTNoeBg1s6R9H7BA0u90TSQnfxvgDI5?=
 =?us-ascii?Q?ieMCuq5g6Sjuc8dSPECZ2BunbDF9XsfjfR1zxaUOmT73ESwVh70s58wIJ/fh?=
 =?us-ascii?Q?LqhwOYNkA0TF9T6QmVljdTg/gX7wCFlp9279fE9rwuYH5P9r7MjZJH299Cet?=
 =?us-ascii?Q?oUSm/Mf+Kgb0EdCsqMUsJz/QtweSM6XEXmEWJ4fCOlE9qCoB/YcOw1FriSKy?=
 =?us-ascii?Q?cPe0GFGuZ4ueKuTdMuJvE4CnihTiqwUVPGXXLaJnG/WryhFXmoP1YthtfIYi?=
 =?us-ascii?Q?HC1BzlShYpv7LfqTUII4wHTcH3O5dWUhbDohEvyMeNx5FhQA4mxo2jpB39Cz?=
 =?us-ascii?Q?QDLnLYgrg6CGhMQ2vnStCOukOUZfgAiFNEvNuhrYeZ1rKUF+hy8+4d6KMtq0?=
 =?us-ascii?Q?FLUOwif98kLWfX2H644RysODR1s8M2TVNzhy/G9Qox085xfrfVLo715mSOU9?=
 =?us-ascii?Q?AphCkW2PFeCoK9mCnPRaOeeckte1ZSsAxxTVIcpmC212dxQMG5l61B8a6UHm?=
 =?us-ascii?Q?o7iLpcyfdhlXMwksa9pRA5KYL7hX+M9zUYt2+ZuY95gF2D31yx+FEAa72hcc?=
 =?us-ascii?Q?khO5R1oJngNJMUiThfz2LYzRYakgigmtzrvnIKke9Jmas2pwgPabmv3339aN?=
 =?us-ascii?Q?S45pQABV8sqcSRYHdFrMxJMCMfuoT+R5dSxOCjnO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7800a848-d654-43b1-bc05-08dca6a013b4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:36:03.6953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HXoos+NuG+OnnzSNweTUAXsPzjad7z890A70+qMkKgyQwnG0SikBiAmL3my4l2kLRymkF7klNevnBcRghuNVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7931

Every taint flag has an entry in the "More detailed explanation" section
except for the 'N' flag. That omission was probably just an oversight so
add an entry for that flag.

Fixes: 2852ca7fba9f ("panic: Taint kernel if tests are run")
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 Documentation/admin-guide/tainted-kernels.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index f92551539e8a..700aa72eecb1 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -182,3 +182,5 @@ More detailed explanation for tainting
      produce extremely unusual kernel structure layouts (even performance
      pathological ones), which is important to know when debugging. Set at
      build time.
+
+ 18) ``N`` if an in-kernel test, such as a KUnit test, has been run.
-- 
2.45.2


