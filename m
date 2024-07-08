Return-Path: <linux-kernel+bounces-244466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0826B92A497
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F721F21E78
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA59713D61E;
	Mon,  8 Jul 2024 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="J3/tH7Vo"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2127.outbound.protection.outlook.com [40.107.236.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67EE13212E;
	Mon,  8 Jul 2024 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448777; cv=fail; b=Yje64iQRLrbNs3tMmdjv8JQrD5qji7t1jYj6mPImmRQtC87mNSnwLinjSdDeFXf4J0W0KIzcmUSjYaoIZIyCGbIzODURgRF23C5A/ujGc6lqmJzcVn0UmTtlXQ80lNKyNEz6KiJIcsToK9/YegmSbAIT7KxLe/Ju4++0M6Ks4E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448777; c=relaxed/simple;
	bh=XGRkpcz0Hav5kSoXeGAoe8jCScSZajiAyy9nMi0GL5E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tkOzwJiz1kFDKfe1amyM5T4oT0XRVlWrX0Q1PUFmke6KTZKdMW25JAeb44A+J7gRixuL4lgQ/KCe+oRpvZoKtBgL7IUqh6A08c49VUyGvgpV5DsyWEt4BMGqfRIFceI6Is1Jpw4lYNnl+AKdoe9tEI63+DS8jrbS3AEXh0KqoW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=J3/tH7Vo; arc=fail smtp.client-ip=40.107.236.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awqmPOwAaqfDdjLhCCpP3SsJYWXYWiFCX+9TYLjTwp/7KNgF1zf6hd1yT9BDUXuKMQ9uwmUyhQtCFe0e6fnT4zRHcVPjSbTKA2AeeXpno0cqTooSWbgFIlML/eNvdAZAyvMP4itkM02hoVPCnTuml6fu7C4TLx81DHaG2BIfyBEQxWIdf3ca4iBzwqfDyCwWe2qZLa/YwQillvAdhVVMqiw4EyLjuBKxcAm/ujFquSQcAINwK150rF0qMJ5kh3c4DEBrdGqhxpGiJCp1+i9Q5yyXg4SsK3y8VJYFEc2iIuK9uETPTm8ABLdw6TsX4gjZ+tf+JOJN2tZ6zC/NOmioww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7nZhON1bZcbOJ5hw5DYyCyV2KhxkFWn8Yi3XLhNvdM=;
 b=H8t23KVljqdjHdFmqy3WWd9JVq4v0gRjIf9B6I5R+NrN5D/MbLA+CUxa5k5emFPd8530q9XJIcjBo2ZUe5rQg+whduKNCtRRc6qz/WTOJPi6Wf45ZdJ+SjDoD3xYwEKYP9GNrGRwIoJnyzUxxiIO2LRZfKMHHtRGjSkj6azgn0ly9DH6PaqFqCnrpMo6EWckqEVVztQjZs4ZK+taIZQ5/kW47oOs2zjsK/jAg/vtjXKaXtlG9SSuCNBQA7lImXrzWTQzW+iniNZjKZQO1InW50yzzj1G9MCPRyLNos9S8c3ZxK9V5t93AHrkXzc3BMJs0lwjM/bXC+s7BqstAQmLpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7nZhON1bZcbOJ5hw5DYyCyV2KhxkFWn8Yi3XLhNvdM=;
 b=J3/tH7VoZ85wc6KG01GQQTQy8FwePS7qBqiTzJDVyumJ/b9dkkzBULtxq5zMhzESYkGESMDGLNpgL4t0ftCPkhXVGEomfT9FAuJyvY46qbk6MavgqYKzuwjPhrBggnpfzV2GQxdHJjayrt5e0LOWx7d5xj5S9pEX0NPbjcYK02Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by PH0PR08MB9838.namprd08.prod.outlook.com (2603:10b6:510:336::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 14:26:10 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%6]) with mapi id 15.20.7741.031; Mon, 8 Jul 2024
 14:26:10 +0000
From: John Keeping <jkeeping@inmusicbrands.com>
To: linux-usb@vger.kernel.org
Cc: John Keeping <jkeeping@inmusicbrands.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: f_uac2: fix non-newline-terminated function name
Date: Mon,  8 Jul 2024 15:25:53 +0100
Message-ID: <20240708142553.3995022-1-jkeeping@inmusicbrands.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0162.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::20) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|PH0PR08MB9838:EE_
X-MS-Office365-Filtering-Correlation-Id: cef57cbb-0933-4b9c-8b67-08dc9f59e976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ekt1gokQIGAuq8e5PUhrXNgmLOwRJSMkqdhuGYXZIdLpOlV7pjLwJnjMi9U0?=
 =?us-ascii?Q?7o6yHUSUXdX7ERCIRrpyDw+21VYAV/+vUovGICccmiCfzcqPpjLIRr0XItgN?=
 =?us-ascii?Q?vYKFQ5lzaUyxMNYI2DS8nOjO4Bm9E9PUG5epzbGMrrGdEU/z6LF0HqINtYBT?=
 =?us-ascii?Q?T3J9kh4FyL3jMpSfWsklhDQ9n13rtzJMSL+XI5QZ0rDmB4Y10gxmzekOtJk3?=
 =?us-ascii?Q?IkT55dPtRTXX6nYgdjAQazMzy5L7vCFjiujJgnsL96qYjFDiPAuNiBdx8tGm?=
 =?us-ascii?Q?dM21R5XAk5AbkYSpWLh5OeeRIWasbI3E6iGHRoGEBbzJV4mF/Fft+5rn4viC?=
 =?us-ascii?Q?JoBF2XUmidMN/iUepmKbQfMpV8MHO5/vKKSbmUijaGuOFCpLW9QP+c9XdyGM?=
 =?us-ascii?Q?yc0PhoMe3DeRaArqxsFcTsySB8Z3GTlaMjzbsp5z+Zmo3MFLLpcgn43nQ7hx?=
 =?us-ascii?Q?8E4gUZWtegNH9qLcO+RIfowWYSIx+LAhtEnKA23eLkThwrIfa9ZIcM47dsCS?=
 =?us-ascii?Q?OjkdbChyPC4J0635wWSR4hvzsg9lvq0nkZuKrT1DHpfS2GqX5fjqopUL0rXH?=
 =?us-ascii?Q?6NGAKc3eJyDHKCViGYCWH7a8kaznoGgFuQL28tPFnU0lD6jZZ0euPtV2zlof?=
 =?us-ascii?Q?6BYZP+fFkIZfWi3XBZtuokWiNK2ME85LGYvWco4aXP/vMOzy24pk9OI6dAsK?=
 =?us-ascii?Q?tP31wPcjPYgDFI70pi3XBp9+DLkHD4R/wHG6q1aVkE+b8SXa0HCNX46FhPep?=
 =?us-ascii?Q?QOO8co3sJrAB2jkXcCiQ4BaMbV5B5u6B4xGTSphftI5yViVYDM1mXpqWeq/I?=
 =?us-ascii?Q?fOgrSilOonFd+ikmKQS0galeTBqzU3+Jw9tQD76BVGTdVTSStxyoxEIIVrSS?=
 =?us-ascii?Q?Ip0xsds47yAe+L9dfMB/jAA/YYerPFYkl5/tl7NbITtIgcOGvCURRrlJP1B/?=
 =?us-ascii?Q?Kf7/awVYCH9H7QBJGydQNzyQSSeuoQUxxmOX2cEUZIPQmPujI5kRJK/A1vGG?=
 =?us-ascii?Q?GzFkS41v2aBNs4qWSRjnfXFcQB/DIfFsFjZIItzkzsmPtHlJfrgAbNsfRjH+?=
 =?us-ascii?Q?VFuJ6tfkx+cnfsF5axYRUSESpTFLLhU48fpbnwNmk+uRToizY/mIhKUv+8M1?=
 =?us-ascii?Q?AqckztfVxdAPVtv2s2JH/dvrG4OXF3fdGaHoPC5m2LpqqsKOBbeoMR1r7opm?=
 =?us-ascii?Q?jKHqsDBZWXMpLXQ44vKs1NGFofl2hk7J/PculEXNJBI3/bejkW1kwgRJd7b0?=
 =?us-ascii?Q?degW+ZsAIIX6CrUIC7JDX9MM0IlR2/usjKAVNMxVBnHUJKwui/H3vwVwYw6X?=
 =?us-ascii?Q?qG60updl2d2Be1PoHqinLvMqP2qADD5JCPS92spuxsjiHqNw6cGeFYP9Kgj/?=
 =?us-ascii?Q?KoxHvN7LQJcWUVUQ3Pza4ol4+K3ly1Tcd1mz7PfesNQ4JTnXsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5uHFFrNnQsL+ZFlouNYEspTo2Th72gZmR6GZFeBYQUuZjQyrmMWQjBFLA3Cp?=
 =?us-ascii?Q?NXBcPlRGGBqjrTxjV4BBpSVI+j2mrYeNmLRccdOZDKPouBN2wHvts0/Rfg5z?=
 =?us-ascii?Q?UVowqBS5Cj/ODnqOhDaeJf6cMs8A1YpVHot0klhp3Nc65XnmXgVjaCZ1nJqk?=
 =?us-ascii?Q?uU6J/tnC+jKBE/aaDXAaE3aEk3Diui3KHdESATjxcx7sIzfWhznPNQ7LeMNw?=
 =?us-ascii?Q?bj1aZrECv/DDywQE8azUuEwg7HT5Sbj27vTeU22oTK8me7WFCK274uLcOMK8?=
 =?us-ascii?Q?Huobttzu5cvAv29EFZp8ZdNYtlfo4F0KT7vUqqmROi9daMGDkSF79Mi4HBaF?=
 =?us-ascii?Q?a3tUUsqLBncT1fPGru8J0WJrp6NJVAp+zkdFijuhYPBPHEQu8x/M/LarKhJ+?=
 =?us-ascii?Q?I2oAg1cm7/6Me+0M7ykceAmLkbTVamOAYiRIXNqTg0tpQrHh9e+5WY7z5jBM?=
 =?us-ascii?Q?lJYT3DB4c2J7s3oN0MHlpx/WasEoRU1IKJn22X/uXpX3G4oraX9oFNoXJgBU?=
 =?us-ascii?Q?vVeNX/szimllL1Aw7CqTVwYYCymYA/LkxPNVMr043t3EJJ8BjBb+3WK5miA8?=
 =?us-ascii?Q?pRQcVdF08jhBJYZkx3OBdLCeLbZouhl/SI7RCv6gZiriGX3nT1VXISAdKcm4?=
 =?us-ascii?Q?wup81uvxFv2wJh8zkV6SGNkKdB5Bde1S8nAbdimXMzWVkNBm1kPFfWf03toP?=
 =?us-ascii?Q?D43BiQVCF6TVg68l8XjxsgoI1aHR/hSqPK2t8Q9DzVkIEQgWirpDYTWb8by8?=
 =?us-ascii?Q?WyuqOLdejFyBx4BUWBHe1kxfxl68DRiyejwIzDTB1fHKJWrwIqd378NGbWUs?=
 =?us-ascii?Q?4VSEs45BAce4y+5Lx01NU4T4FCDLXFNl1NYqk2GncUVLj8tED9cuFlrUS2AA?=
 =?us-ascii?Q?hOlYyL2kMSQlF8AmhnZOqSsjh5i5MlmoBnbAhwcwkjslya5ygbBHHkky1pWY?=
 =?us-ascii?Q?GCrRPTQQNoXiXWGgEDYscDCYLPk/z7Ovkoixtw0GfIXoLDuhuJ7Ium7AnEf3?=
 =?us-ascii?Q?Vo/CXj2x3gPrZiZKnGDy4RIk6qEvH++MUygjB4P9EeA9BeXGSSiX0oFY92+q?=
 =?us-ascii?Q?Su6g7IqO9Ou2FH89s1+Qe7KBo0ksFcRRIaUlj7BHhCmVdi/yAIzuwD2Mh1h+?=
 =?us-ascii?Q?crwG/OTTakU35Z8256M7kTlrEP4udOU0yPYycY/vZ4TZryWn5xrYGPhhoAZC?=
 =?us-ascii?Q?NyEYuB2TnXbWkxsq1pxtZeS4aVNEVg4ZQ7IID/viz91Oxvx+cfiuTQxwdE2k?=
 =?us-ascii?Q?dN+jGWuvCa8eVIOvncyA8+IjbdZ7ReEn7XYvrvoHWpOTumo/ZOAFDRpyUo+w?=
 =?us-ascii?Q?Q7bbKuuu011jwvG/rW4vpJ67Zuj3LL0tanhf8pJePrwNoPxIhCU/hYgZ0OtV?=
 =?us-ascii?Q?4GxwCVdRtUZsvQJ6vY3qa6NBOezXBzu3s2XeDWcOHvOo6JkbwWXndEIt55Ri?=
 =?us-ascii?Q?D7I31uwHEfMsPffTs4sVy/1tWq1XFtXBcwORfumsJW75paPrdr6e2+8L0GEM?=
 =?us-ascii?Q?hhQf0R3aj22zrNkSIxecBr1Y9PHth5Nhu/GxSv2etkQzzzuoaIKTItSlhsvg?=
 =?us-ascii?Q?0GecBNRtNHnYri+/x04aUG9d+FHBuyr66AubdtmbuE6/A9v1i8Rmujar1kZN?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef57cbb-0933-4b9c-8b67-08dc9f59e976
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 14:26:10.0736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3qM8SmArwktyT3+O0oIhlqDC0K2hpTONVhm6mYJ7/KVkwRMByZq56+pHnsbElznYJOlzKnANkSTg84GSh+IGSinejGJWOZ83iqwDF/rXSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB9838

Most writes to configfs handle an optional newline, but do not require
it.  By using the number of bytes written as the limit for scnprintf()
it is guaranteed that the final character in the buffer will be
overwritten.

This is expected if it is a newline but is undesirable when a string is
written "as-is" (as libusbgx does, for example).

Update the store function to strip an optional newline, matching the
behaviour of usb_string_copy().

Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
---
 drivers/usb/gadget/function/f_uac2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index f85ffa24a5cd5..2d6d3286ffde2 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -2063,7 +2063,10 @@ static ssize_t f_uac2_opts_##name##_store(struct config_item *item,	\
 		goto end;						\
 	}								\
 									\
-	ret = scnprintf(opts->name, min(sizeof(opts->name), len),	\
+	if (len && page[len - 1] == '\n')				\
+		len--;							\
+									\
+	ret = scnprintf(opts->name, min(sizeof(opts->name), len + 1),	\
 			"%s", page);					\
 									\
 end:									\
-- 
2.45.2


