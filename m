Return-Path: <linux-kernel+bounces-293378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA35957E8E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554BB284E02
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA5218E354;
	Tue, 20 Aug 2024 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hOOStMiZ"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2073.outbound.protection.outlook.com [40.107.117.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2544A18E346
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724136183; cv=fail; b=T7PuGqs/HcTTyU3qa4fRjZw+LFuGTYY7EsfqEDrgqIaA8YzRvIeF+PdlDWoBvXhKeCPQFOXLLpvPkJkNL/NoQ67/Y/Gp54+/PKyhu7NDFv4TNUMXAkgeE2NZZ9dcb1mCa0Tc81U94ADUR07gOSrKGSkdO/MCCG22//YBk+/1RjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724136183; c=relaxed/simple;
	bh=JkjxomTQ+HBdPpRia3mtnB2USVloVaSarrAc6eezriM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sFQAKLjmfaVIiwdL86+ZL4ihMw4AswcIYbx2oxAP94sPYuTnfvOcGURGwezlRIoQijdAFA8PzjdN+7ALbV6gerA8yTmthfsc/SHLDZiN4+oFguZeX4dznL7e/sVDFNWGou6IOloGLQ0nVu51G+d8i9HoAAKGAQeJQOq92U2Xm7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hOOStMiZ; arc=fail smtp.client-ip=40.107.117.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijh2fL9qkT9JGWiKwVF9z/1OlLhhKqIm346eTZZut3FpjQ8BdP4FcF7yZEOwPQ4W9kQw8Ui4BT15kpLE/+bSTo44yZI+WjGjsspkWIj2mygLMu9ycN8gkQWJYKxkYmudtmI1zmMFJZIQxWXbVFIIxCEX1WgBO3P4lOrmbxHOqaWX2PMuLttcT0crQeQqrckoUZl6ct09qSFnM/UcB70LDkud8nhcfw5UopiZDVey3Dgvjqxy9WHAmHeFDfeWVTbQ9kzmWYSwqjwDB+NPdW3y0/NbrRlXHPH/SLJr8R6BPUmLSoxzwtFcFQSecRplart7E6yfNu87xbNloHsIGQLixw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDtYRxj1vgh8jRL9ZCrNcNkk4x3k4XCRrZ56Aw1uFeE=;
 b=NVPhy9Z1y1f2NoTbERrlOg7GVae8Wy8QiHK3fDLlWOWkqyh6EdxPzUIhXIqvqUaHlMyfwF0j6CJIAp3oyZV0S6fLRY6Sb3oWvqJzVG3ADQ97PGKgWRk1CpXR045NiBVaIvbFHr9u/eXRhpK7MXZ5XNqrZUQEAYMmrJTNNKSKha4u2xTnMLgBPKv6VY1pl+2cAKSBtXqAeZZDBFnToTfxUKtXYvIt9RKUktPk0QiKrxuT8rAr9EnqxaVi6X768op0R7DMxLGBUmtxVCMXZYACrxGZzipXdWrD/7Nf7WVUUo6Kc9QKsBJf8zGrINzfiAnKYL+H6SCPYr3caE/4zLWaiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDtYRxj1vgh8jRL9ZCrNcNkk4x3k4XCRrZ56Aw1uFeE=;
 b=hOOStMiZYDZhX6rzDrYdjtb1khkPNGDlWG7ua8JoT8WyYsP8PP8sIOgtli9v7KmsOefaaID+1DfngC3n9OtJwfLOIW0od5iE21nMCWxsnIssiWn4wICw4QOAdYWru8AnNy5MOP/LNxXdrRezE1FA5HwzaGEA6HFfkuSTcY3jhx/bYlg7Dcox5QWFewuvzYs/vd4NUjCDolRC9+3/E9zWrjz4sI5GQJQz/Ltz2l1pVImdFDsSzCAyNLS9CCWyJEBRNvq7KYGLwuEJwJkH+aPRTLP+Rb3e+4uR0a/lnG8o1+nArlp7Gt5iN+j/8PzIRbo+9l54JWCXy3nHdmr7+yliBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by TYSPR06MB7100.apcprd06.prod.outlook.com (2603:1096:405:83::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 06:42:54 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%6]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 06:42:54 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yu Jiaoliang <yujiaoliang@vivo.com>
Subject: [PATCH v1] drivers:intel_th:Switch to use kmemdup_array()
Date: Tue, 20 Aug 2024 14:41:48 +0800
Message-Id: <20240820064148.2722239-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:404:a6::28) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|TYSPR06MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b25354-6995-43a3-7d08-08dcc0e3518e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yATWwvYCtEDnm2CWFhG+urvqI4wmPRe6Iz4HzSJVZbPFDmIBQ7wDcKKLmNY9?=
 =?us-ascii?Q?d3dpsSB2EMuWrL/uR/LiuuGreUUPQnYjufILmqMMI7WxE1q6QhawD5nIY428?=
 =?us-ascii?Q?ct0TVPO5kTbc7U5+S5XlEXP3SB/xOBn5d2ydlDHbjPGkEauc8mQlXK0yTPh7?=
 =?us-ascii?Q?2YgHyzR2JGEx+UBBvynDvhzNaYLhaBDX2p/Zt8GkgXL70ySRlHyb1cQ2Is3H?=
 =?us-ascii?Q?YyExfTMvv8O2N187b9zDYbUpJ7gub4gbYCja1uL4eVN4ippkVpNk1xC0+ZWN?=
 =?us-ascii?Q?+e/9q+y0XNfhgjzrLfEPUbnpxycmZPuq29V6+Z+4nc0LHonjIJNR6etY09is?=
 =?us-ascii?Q?48+KOMsArxaTj2eFxQ3C0fZIBBUlAEhSkNVNDWecWu4C4JWW/hNZ4pLxhVlO?=
 =?us-ascii?Q?jPKEpRwKo1ODJ73MKDMUL6SRRwGNk9bKetY5yLk/E/va62uAR8cFkh/NqRRK?=
 =?us-ascii?Q?5JttZbZ9SPvA7jjwCC9Hj9oMESAsFnKFtO4BlIUMgvNLiQyAbWWa/HNNxWiD?=
 =?us-ascii?Q?KQJMOJk7B3OFhCSn+0Qdb7EuVLiaX6AJLfa5JUXnsMUd7i0r4qlfQYY0syZR?=
 =?us-ascii?Q?ZH/Bt9sSGcsq3MK00W32KAhBlQECxrt0zUDrI5R3s0sI9wVFn2PPblDvM7mY?=
 =?us-ascii?Q?BhgAKi7xVwmHVAJL1QySzaa5V52o1La6LXn8jcHls8q1PL8EZrs1/sr//C5A?=
 =?us-ascii?Q?bhf44wv3v8WceEuZ12vWWQvwgv/sdkctz8xbA6tNLh8fCas44DVVkjsmMiAc?=
 =?us-ascii?Q?ORcRVIKIqdjlZ6eZ1WoF8BT6fX+QZKh63zkQ8rgbxOFAbFO2SP2NGByZRcMN?=
 =?us-ascii?Q?mJiI03gRlnmk/0OpkvM4YbsyfhdrX/CS04Usan91jz2MQiWMBypEzTCAhL3t?=
 =?us-ascii?Q?TdiYsHZJoh/EwU/5rghDyrJ3w5WxwjTu5I0h31Pe9dEuybJ5IIxkH2wFu9Zb?=
 =?us-ascii?Q?OK/Jjr872lw0CPeXwzM1R5cFZCyfehH5NFwyal5vdwxeBS+udX7007kncxx+?=
 =?us-ascii?Q?63s0apK9JuWb4JZ6C3lFxulQr63kiz9O4dAMCKvUq+RYtfuYsDr+3XKybUW7?=
 =?us-ascii?Q?gAbpwdsxhaljYuN4F7PZTIWTjYh8F7XlgtqicRhe9RbsM38pQhGveQrYn+uI?=
 =?us-ascii?Q?LP6hQUsFS9PrFyVQ1Ila+i0ZWFnsjJiWqUTrxrowDFMThtC78ppuy8cFPefl?=
 =?us-ascii?Q?GUHlwKCBwPGDVn8cP1K3ebUOYIZtnSePFAfUJ7hOAwZhVoIQgdgP4X6K8dN8?=
 =?us-ascii?Q?AXpdDJj/0RNNtjCUBV/y/kygmkB3krFRdc8aA8ec/J5kN3qD1UgfbyfQrRy9?=
 =?us-ascii?Q?EhhWZkey5kmaBXH0B6WGy74LdUeqbOpnMKUPIUFr8eJbHIGiRCjjUJB+/3Vf?=
 =?us-ascii?Q?jKb8u0YSW/A05BfClL630ZkK85SJlpxEq3spHl4S6Dkchxnz3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B2dS1cSq2ZiL6+jtc6FOG0Ft7p1NlcAq1X+6wLUjARd03cb8y1zYXMWBEE+J?=
 =?us-ascii?Q?03+W7ZdTWJKminS4lvUtQu1L7Q/YxmD8e92X3imSA6BQE+e3hC1t9UP+fO/r?=
 =?us-ascii?Q?U+SH00glwAaAU14trCEP1o1VYKz/k6abz9qyO9roXqnEI4P7+9ClTXjkj03J?=
 =?us-ascii?Q?xu/9ufJlkcamqGCCIwepDuzkFQL3YIkkSeQExfNAm5u2wU5jNgRf0UhaPD+W?=
 =?us-ascii?Q?0jvY1k/YqPl6yySqNUHiFm/wIf8kwDRU/R3T0Gr/iN0Y+V9RYkT4yPVNQ0nm?=
 =?us-ascii?Q?dayud+B3UGUMkymsxQZu+AUnU8/IkBGaJuI1Jm5qlZG9cf9tkAzC2x4Okh41?=
 =?us-ascii?Q?rnwM6gXSJY/hlutF2w5DYnkNcRc7Ez1urM0u20TptxAmswePG7hYhvNY520J?=
 =?us-ascii?Q?tWLTQ5Nzkk9CxL4NnW9gDm5yrEBBWkNgWEFeChO+ql3x6L8zUeMc0TcgV4yj?=
 =?us-ascii?Q?vMHvGJ+k3jExCCZn8vi5dtDYcsVu535Z0HLYfGCEKG2DsoAcV4VNoJddmgQO?=
 =?us-ascii?Q?3s9nm7Us4BVZ8PM3vU/Pzhh1XYNO/5MhyCHNnxagijCdTMd8Pmu9vX03hshg?=
 =?us-ascii?Q?F0GkPmPIlKkcRayizceFYg/R+tqQigFsG4v/Q+SGcd7D9QQIXdY+phB9TZHI?=
 =?us-ascii?Q?b+N/J23g5Sj2hjWoIdRarrpnh9yVKNjZyaxb5Jr6uFzAUTLNAATuFnHOByB9?=
 =?us-ascii?Q?G1n/zlcROvtyHv0uT8hyh1p+a+iV6wAxnNkV8bEbARotxU6R8bxTeDe2kr4t?=
 =?us-ascii?Q?PEq7d56mMFqkspK3ODT0QvONoKX+N3iUb/rHEfgVpMkgzOvvoCKG6uwl9f5L?=
 =?us-ascii?Q?JXmycamnORQQyR9Nd8Vva0TOLejUVR6Nt4q+kf6lZiFR2xQ4TIcREVvi9ylk?=
 =?us-ascii?Q?qkmL+m7Rxy6TBOJvqiMre/TUTSax0m2X3lyHulkzYhE7CTIeMs8Tk8Oo4hmH?=
 =?us-ascii?Q?aYekUKMP7ZxuC+Ny7TW/HMKdPRd1QdVs51uX91hQt9lotovpSSAa1+uTlGth?=
 =?us-ascii?Q?fO7B79kL+zxcT/0Nc1pxTPm9rGFNOEh/hbYnmrGQAHCjRzMRXJN7nSaQKtHv?=
 =?us-ascii?Q?M+iq/iITmLWOhqapc2nr5KFu5HdulRBxBcA5bT92HMA2ChKYSsfhDVfWP+Fm?=
 =?us-ascii?Q?ue2PL1S6m8f4ewx/TZXNCwM6iAkG2VW6PhUm5l7ENgbDjiTjXrHvSP+SrfZk?=
 =?us-ascii?Q?Wab/D9df5o1Fm1GDBMq0tUMzQgPwR+kTXpp+T1+V5qbojbyS4iro2Kmmzjrd?=
 =?us-ascii?Q?LAat1REyWIxA27lN5lFbdylkQ8BGiyVkjDz8eXPs08N1/brpwnIl+/ID4Nh/?=
 =?us-ascii?Q?RHyE7ys8qugMGfzcj5Cl3V6KYknwYFiDqW/h/rJp+xtw6G8Vs4lBekTITh3o?=
 =?us-ascii?Q?RYXC5OamSB2dN8+ywYke6/9wU9f8NqRLuJLxSRKbn0JtkyDC400A+hv2JBKr?=
 =?us-ascii?Q?qJKX7XJKCH11D1b5RkVCb2RcrETcz6PGpxZBnBUl2yYCSXz8UN0r9yJxaJ/O?=
 =?us-ascii?Q?ITWyYKQiyR7cBFsw6dMULX2ZCapqU31hkd7g+zQqj/qPI8vccJpJU3oQo6Ad?=
 =?us-ascii?Q?ZjpUNJV/eiiRY4ovASYZt+yW0IPO+FMz4PGMq9Jw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b25354-6995-43a3-7d08-08dcc0e3518e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 06:42:54.0075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOVBy8JAW3Ix7W9H7npTEnmbpb9hVAJmF2dU6dQzVP8PXrQlS2phwUIePjJTcPL1ukqYVF1rXSONLuv21XeioQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7100

Let the kememdup_array() take care about multiplication and possible overflows.
Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 drivers/hwtracing/intel_th/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index d72993355473..df72037c1c86 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -408,7 +408,7 @@ static int intel_th_device_add_resources(struct intel_th_device *thdev,
 {
 	struct resource *r;
 
-	r = kmemdup(res, sizeof(*res) * nres, GFP_KERNEL);
+	r = kmemdup_array(res, nres, sizeof(*res), GFP_KERNEL);
 	if (!r)
 		return -ENOMEM;
 
-- 
2.34.1


