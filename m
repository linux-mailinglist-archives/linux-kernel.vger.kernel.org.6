Return-Path: <linux-kernel+bounces-306329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FAF963D82
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A8D1F255A0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6124D189B84;
	Thu, 29 Aug 2024 07:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bxz9gw+u"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2041.outbound.protection.outlook.com [40.107.215.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E08A1494A8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724917553; cv=fail; b=bZKOyidvzLE4CT8lv6FGZeB36Ex/a1nzFS4pMSdCwc4C4t9uOuA5z6WRffQg+msUzzrKAq07BvrXAJVDbSkD4bOH1hGdvrK9Cf01136HAE/tI/1ljiIlC6NXqm/w1KZFcPPNeWiio2u0TaGvlnxOpvFMrgNvvEbbt/2ksDyNWZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724917553; c=relaxed/simple;
	bh=zL+qqNd+l0E9WGsylt0rdg7G28KZLE0ws3n29UZ12FU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qMYUJtKdXR49AhuBVz10ViBdu6RWnG34ZonEyjDHy97uiH5eBs+SLRuI7GN4UIZqDQuunjAKs7mVHQbjeK3N3kGkvKXO4+a24TG1mvtx1ZV2ME5yzL4MM348fNba9OOBKVH6Ge4waAe4fyW0rjP9ajwOlOW3JJOhkDa0bj0UD04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bxz9gw+u; arc=fail smtp.client-ip=40.107.215.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTwD15krjRWgdKE3n5y59JiLCGUpJNJoKZTxwF9Z76Fm+4No9SOpgFr6Q3QOsuVi31HFK+DkPx0rEezpwmafRFDG+lfmpj2p2eTzGYfy+KF+mhxeU2vDnjiHmJSF15nkzBg0GbrR/yCV59N5YhpYMic9Mawr15rsJeSVLcgq2AlQOmtsHdUw8si2rWTSa7VMV2KxBcmZchrQ6M5BOAJZqrTOEZUb7td23tRhlnm1h086DocR3ecBggORd8xsyUhXXKaPFzBcVD+tE7uCiJQpA7Bc8t6s+bejkbQ6v4a+0oz4ehGt3sG2L1Yn8ygBSNjKR2bMV/e4SRJ0oxK8cG/kNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj3bjYgaQ1RFUEw4Fstl5uFlcA2/8vEXhXHkZUMNTbo=;
 b=pyi6KkC9wAWNZ9l51ikw3exFq/dPf8Mtz+7bhr4qTL8V5taVJVu9W3Gh0+64Cuhvl7s73yHakFJB2apQpQjXQpZQG0nzf8xlNyg2OFCWKxzb038zqA3x8WJ8BJfl+srsYFxf6yK36Isd8c5XRSLFhGHgZ6mvBcElrNavrGtLGMK8MlxJYrZ5wSlI1zW9YczAT58bOBmOSmm6W416UrhQgx/TDc7c0hVoIM1nDcn+jOADj1BL0VH8AD5j7+E0Crfd33hxZqR/uP7wRXo/EK3CcUlbO7MVFQr1JxC+BwT+JA7CJ3XXDm23ptU9/9tvO7+oAO3lh4e4P/qMUHQD8GcwbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj3bjYgaQ1RFUEw4Fstl5uFlcA2/8vEXhXHkZUMNTbo=;
 b=bxz9gw+udGZ7EoagB3uAl0lBSfOIrcYiOUvDlO95CixL0QdYw8fR9mmz0qtsdqbc35fKqnOYZVWy2a2VEohENhTEU05vVO5HMxKjr66BUuSqT4KQT98cHvxKualJMgO8SGuzmRxNY1fjQsHfwOE03I42F4J3prM/i1cQ6RRp0kv6j7dbwvU2b+KO5KEuQKanpXzNQMmglookXIWdCJI6Lsw3qRDQoBzFIgkx04QSlXrunTe/9UrQigCQB7ffMXhpJIZBzOurNgpA2NPE3s6lgfyzH3qJ3tgZPKGY7lgWsJQO/DktptU3WaH7lYQ+lNcNnk0ShQHWW+Y0uqjYV6yI0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by TYZPR06MB6828.apcprd06.prod.outlook.com (2603:1096:405:1d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Thu, 29 Aug
 2024 07:45:48 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 07:45:48 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: phillip@squashfs.org.uk
Cc: linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] Squashfs: convert to use ERR_CAST()
Date: Thu, 29 Aug 2024 15:45:38 +0800
Message-Id: <20240829074538.36669-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0117.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::33) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|TYZPR06MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db91fbf-adc4-4934-7d81-08dcc7fe98ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UyX6Kw9/40WGUyH1p0rD9fcer4quU1RThyEVzfpfj2ichogcAIZGT1r1wX+B?=
 =?us-ascii?Q?fZVLICqL5VYZXRwov7Ow+yzXimLEinv564TN5vYKCNEVqx+Ue7pjf0iBpv4p?=
 =?us-ascii?Q?PMq6+nLYbsnOmOAGt3DHH0K63m/1jPhMypm8R8wIrFfoNEBvNH8yOJHYXnyT?=
 =?us-ascii?Q?lDTwjBzKNb5R7Y4bLn6/nkEoGLZHIKrZD3oADDGbt9X8qqGbXAX1HtpeM758?=
 =?us-ascii?Q?kACWP2VGzwdBYhChXuv3PqbLMV0dHiI5bwubxOvILAYBNvHp0HIetPTAVQR7?=
 =?us-ascii?Q?z2G7UHvAJyhCbTo9PLBQf+qRZ4o/xsTH6TBEiHOMIRBbw0B2rP/gip3DiF7U?=
 =?us-ascii?Q?maxlKyTl3C1TSpIqtZUwaps8fw2p4JbztviWi7GV+WA5FTyiKCgm8rTMBiVw?=
 =?us-ascii?Q?TND8jCZJLjaf5jQWfa+ttBiIj1JMdPMgdLZVJ56YAtKLDmKnkol8kalbs43w?=
 =?us-ascii?Q?baSLX4VtKeAjXVu6KBmTby9M7QxD9q6AVWAXfrjp3yjUf6Y8103zQ738JbD4?=
 =?us-ascii?Q?3oIWmzyWoM+ccyyf2TmeZrb+NXkDOk/THoIn18EfapQeG6xMfsNii/4yJ0it?=
 =?us-ascii?Q?wMHp0OAfBJj/EE5QtlmrbNnkaahHr6Ar9pum0iQFsypcegYkOGM5eC/WnvKy?=
 =?us-ascii?Q?yLlerB3rYLbMWNzd9dxPLYb7S2L1uY10PyRJh2PI6oN4ypieKAVbHYtUlWlw?=
 =?us-ascii?Q?ngpClqJSso5BcRSifzQT/OklUj5gIn9xLbwqklb7ZPqnE5mAVCAu7Wd1VIJe?=
 =?us-ascii?Q?kEjleJsbGMoFnXOHIwmSFAZX3wxitHAhQj454DNjWNQTfduz9JWPs7ApWCub?=
 =?us-ascii?Q?EmjaiwnL0mhEv4sGPBJK8QIUDb9+5vPwo5taD9mMqB/3sNEyNDkp+zZ8NB9z?=
 =?us-ascii?Q?XLrOYJ1h7DJh5h+r5iOJydQkbgkoXUBd1QVChZropspn0FbY6H/6zp7yqL+X?=
 =?us-ascii?Q?ckNgWV8l70+F1cNoDoiSgkQmH1Lo8uflu7U/0DlCCZbWNVkhX39sPCynGULw?=
 =?us-ascii?Q?FwIxO4Vt8uxQPJwBohqj4cLzDkaoYJAD6NueTLq+8Dxgy02q9XhTI7cFTO7R?=
 =?us-ascii?Q?7AjXAF7SPAsKGHYzspwb8jOuMVZBI0i9z09GImtrGoDwryIV4ZaQqzL2f2TG?=
 =?us-ascii?Q?NE9orgpzWzVLhJyppslSFFOOhN8O61oyhH37iyTSOri2SBWUCoshV+M5Emql?=
 =?us-ascii?Q?NLhgZF2NfFulbdVegru3F8goMedL2yabrnaKsjG3zQLyEsdW98jm4k2EURvM?=
 =?us-ascii?Q?j17kD+DdVNOwTQ3aFk/90nwg3SGwahUxhGoCiaTyhTq8GR1MP7fLZX5wO3GP?=
 =?us-ascii?Q?WEmWBpV2z2Zv6/az8nMEiWM3BHgGLBpB66K1NLAQvftV2FQ9lMHRr5Jio+oj?=
 =?us-ascii?Q?aiOzVAdSmOVEq3Q8GrkQRD6Mz0ajiWWlVNxXN6Vz8I+ynkpMPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4XWsGX95XreJ7YJd++uBl7MUBn9njBQ+QuJ2buu+uKM+7MJxmna2XFVJjtXm?=
 =?us-ascii?Q?QDEGp5jca++kVBLV4Izf8LZ5e09aPDOkfywDvHyOiSYDX34sMnr7g7Y3tLNF?=
 =?us-ascii?Q?TC8VX/nhHrLMJve/fqcgJOxsxOKK9iDtHFxNS6fyPLzM+b4uN86Uov0eHjSm?=
 =?us-ascii?Q?Q92gxMAmyFKwtyH5YBHfPpCWpGA5zGwmiOsHDIC95jFxJ/6/r1mt9lAhfyUj?=
 =?us-ascii?Q?7yZo6PLLyPuvgKzxK3uCZqoiAQ+w9eD141e02r+JKn3/A49IuvQYDFSYuY7h?=
 =?us-ascii?Q?AjX/mTUkmunXcNWmUE/ab7zaJZ8vFVvkO4p5vK+iJoeP7Ls59NwH8lqjHLWr?=
 =?us-ascii?Q?tBtMgnC7y3VFw+jcUO6LKjcXDZYCNlfkflsu3GcmQTLE4EwwpTdJvknQLlct?=
 =?us-ascii?Q?bOvqznihESruNxNlRIeFlq70zaLnJU/Pbz3KFX1xCAv2icAXICfkbKmaGDL9?=
 =?us-ascii?Q?/o+beQe5CIHDrP1V6Cmjw6/adoQetJ6fiLZ314LWEushYS9Y9MBsPrDgYJxF?=
 =?us-ascii?Q?pJRRM2ls71MBgUeu9/Enhp/XWJTnVqMgTjFgY9tqz0kUW/FLzK0VifcfzV+H?=
 =?us-ascii?Q?xEbkOsaRqQGSVl731NQF9mBlLN+6Ngd2VsGCIYUZPnCN2muPYXBUhQ8J48nz?=
 =?us-ascii?Q?DnVd7A5tgF5uboUMjpO3GbOoMVcEBpZL/zeTIlVYwRpQFmjwABpFVz8LDOEq?=
 =?us-ascii?Q?asUIYKFVmi2Uh619oXjiE875odP5VL5WR3wFnZshBQ5drtWAqdVzAwJjS6Jp?=
 =?us-ascii?Q?B1T8vQ46EOsMYFusSIpDu96dna/BgaKDBj2YEND+Jf1khJ9jHrM9ygZad7LM?=
 =?us-ascii?Q?D+vZgjPlnJc3YcFr/hXETfP8lj0v5dJommizgPU/ULIKJSXp47pJghUIqRBq?=
 =?us-ascii?Q?cmwKEuNLn8Uzoa+QSPCSQ/6DMbfBf2uOwTMKsghlrOMt3K5w4SfOWlokFjNF?=
 =?us-ascii?Q?Ay1C4OGgajSW0QlIKSJOAe0KZYTyUzequJPLa9dnAR4IxXqEdd6MpFNAqRKk?=
 =?us-ascii?Q?XiYR43ZGhpWHcH/JeT9ilz3hpGc9cPFVxArYM83LQ1V5xzOIb9BCE9cFYSa6?=
 =?us-ascii?Q?4GsbhA1OfTcHonRwin57wO4/2RW6+a8DJ2d7kgXGpwjcff39MDYAvsoBJNIU?=
 =?us-ascii?Q?RN615v9aTMRUhh0t863SioVl+hAupqGQtSVi50asfgbwg+Cfm8aXoVFIxj6C?=
 =?us-ascii?Q?9eMNckWx3O5gQHUv4P1HJrc7tZkMO1mXaj84bQLwcvy/nv7QkqWFezk7UEmq?=
 =?us-ascii?Q?wV0RZISVGUgctUktAbCQzYQhpy3KBenOnUat/HxzSoWj2wOoxtXeSNNv9Hpc?=
 =?us-ascii?Q?VptXa2zrorqD98aB6Y7Rd8fHxnY4NVP9IcGz4r9peuV+ncP++GPtXalvcmts?=
 =?us-ascii?Q?Dae5hWCuipwlKx4kYiXPWDM4RkTwZQh3JOvwRgEb8UO2G+iGUOfMffT9aKMf?=
 =?us-ascii?Q?0hcYJ5iU3zKLJv1bEmjeC4rKT8uI00DDfxrxrr6zU0JWDsZsg9WrnpEck4mI?=
 =?us-ascii?Q?Fpf7bWHx+aXRzTkIpj06ndNTF6exmpz9rxloBEtU3iVO0V3odncrD7ebQL3E?=
 =?us-ascii?Q?FYnjRDVElgXNYhd1mQDMixOhcIfZGmvhafTuz+Ai?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db91fbf-adc4-4934-7d81-08dcc7fe98ed
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 07:45:48.3268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8R6zfkLXCvOy20hNwoIgyCOtzJ8THtRjTpnpULBVnM/bcWEyAg2fD1aHOTudQYNz+j5sL8xaK9JC0aNm7z3+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6828

Use ERR_CAST() as it is designed for casting an error pointer to
another type.

This macro uses the __force and __must_check modifiers, which are used 
to tell the compiler to check for errors where this macro is used.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 fs/squashfs/xattr_id.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/xattr_id.c b/fs/squashfs/xattr_id.c
index c8469c656e0d..eacfdcdf56a8 100644
--- a/fs/squashfs/xattr_id.c
+++ b/fs/squashfs/xattr_id.c
@@ -67,7 +67,7 @@ __le64 *squashfs_read_xattr_id_table(struct super_block *sb, u64 table_start,
 
 	id_table = squashfs_read_table(sb, table_start, sizeof(*id_table));
 	if (IS_ERR(id_table))
-		return (__le64 *) id_table;
+		return ERR_CAST(id_table);
 
 	*xattr_table_start = le64_to_cpu(id_table->xattr_table_start);
 	*xattr_ids = le32_to_cpu(id_table->xattr_ids);
-- 
2.17.1


