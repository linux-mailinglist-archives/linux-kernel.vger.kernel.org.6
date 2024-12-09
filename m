Return-Path: <linux-kernel+bounces-436885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6664D9E8C19
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5614B162233
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59F4215169;
	Mon,  9 Dec 2024 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="HEq3srIg"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021092.outbound.protection.outlook.com [40.93.194.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B721506E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 07:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728860; cv=fail; b=tYM714NEkAqIDiyazSDeZLjjXrmd29jnM8iK0lJqqXcJDX7mhicTxIXc73IEvN5UGFo1SjLtieO8x7gFrxXzM8cu2GYoRFkE5SkYLygPqwafv7sSJOk0Th+U9MpOgWt/d5QJgktWNX/IFUYmrwo4bDZBvTQwWKuhoI12QNWaRu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728860; c=relaxed/simple;
	bh=iKMGYS2mEl+8fBtTYJBhNxYkyypyAQ5qkB6JKLwBWt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WuKPJ/+mhn9VhlOCdRrurUDGqbBs9M+Nf2BN48DkLT3NBftTnd3M0B4Y9sI5iKd7WtNPpb4NM/05ZCSajHYGW57Rpkron9zIFDX38hDcmrxEjYqqbFCdCArC3r9RfWjWPGb/uEzW5kQE2HGXjiliuLg70niDGVhQSHWQ6CxxXFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=HEq3srIg; arc=fail smtp.client-ip=40.93.194.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJH7qOdv/qbd8ZzSDx9Twdf8RcCTn2UqKU/lUJhjTloeC4oUU/l5+g+i1IGU4RWKXjY4uPNQnA1W2WHc6EcMyUbWuMpcIYzlUWZbqypp1ZBv/5MXyYsieCQtAJEAepSCN0hAA82QnhObgyG80W0ZElXmi26xMrnkONBZFQMXPNRo9BIheKBWTHvAgHiDOxi3bQhEP/29yVcmsuK3yS0rNTIDoKo+vB5CPsh3URUuyzGCUkBY62ONCTirIDaJZ5blI+/ie7dc/UEkpBh75kpbzaBFwlxqUGu4+hwKrucqi1u1/DKPj4P9CUxps0x3xuh0rUZ4fygoBIbKIfchBNhFGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rbu53Yh+kA1LS4h1xYEPR4/hP0SYV0lyQIuCr3buQy0=;
 b=ewQN/o0ikzPXhIEaU22/5nJ9l7T0hwtmmSkpdFge7nUZY0hUADa0fu/wW+ZZ98ybsY6wrYB3JHHGUXOFY/j51lzoEuzTTS9sOSUJclXX57ynuqJA7nbokE3uQe3CDvXwh9qvvxYEAAzSfTE/sT14EKvBmx2fZOagDwR0Vu7pJnt99Fyh9FuClivfwqt4WoPSiLENQgls0AdwkWP4Q27rqYs70hqfjiUPgtZiR19KxX51AAzUxNMfnftKdAa4WbRCH/gSs86+oHQbO2y6CWGZUKX63Y6B/vdxoZ8t8gXhH1wRnkEEylHyDdW5S54V/lmaP1MHamCyvCyNcSPWArkcWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbu53Yh+kA1LS4h1xYEPR4/hP0SYV0lyQIuCr3buQy0=;
 b=HEq3srIg4R87Pb0ltXCDI1oriZDuoHUJ7jGHFpZFfz38MSX9suo1COIQqT7hma7c5kEz6HKu6BvoI3F99aTXReBcUKfH7cd1YWcLi5WIUqt0H7qfcdhTUXsU09uvzwXVT/FAsEUXuasVjbta9fU/jFOSkArnEFBXSlvXOStgVSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 MN0PR01MB7876.prod.exchangelabs.com (2603:10b6:208:383::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.12; Mon, 9 Dec 2024 07:20:53 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%3]) with mapi id 15.20.8251.008; Mon, 9 Dec 2024
 07:20:53 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	anshuman.khandual@arm.com,
	corbet@lwn.net
Cc: patches@amperecomputing.com,
	cl@linux.com,
	akpm@linux-foundation.org,
	thuth@redhat.com,
	rostedt@goodmis.org,
	xiongwei.song@windriver.com,
	ardb@kernel.org,
	inux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v3 1/2] arm64: refactor the rodata=xxx
Date: Mon,  9 Dec 2024 15:20:19 +0800
Message-Id: <20241209072020.4743-2-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241209072020.4743-1-shijie@os.amperecomputing.com>
References: <20241209072020.4743-1-shijie@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|MN0PR01MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ddd485-38ff-4960-2303-08dd18220448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z25OXHCpI7f93AEvnKobBvQci/Cf0isC7xTfRl4IG0IDyYXak2cOpPYSvr03?=
 =?us-ascii?Q?6h2rRD/SJFN81kfxzxKz6cyKHddnwJqhauyRZxzUYOJdcdkpAxK/SAEYSp6W?=
 =?us-ascii?Q?pO3KdCI92j+puugl6T3tYxsaL/OUIUQs3TT4vR1bKlQXGmvB74wer2/qEdMi?=
 =?us-ascii?Q?pvBG24P01NZD66LW2AzKTIKa4NRar6y1vhRmerHAnezGZVQVHALsuFc69Mo1?=
 =?us-ascii?Q?ib7h9GjbetTDnLoPlgX+rvu27UPMMlvnfQcaE6e5ZcmvqRjCaFW0dzCdvWN3?=
 =?us-ascii?Q?BscDI+4p40rxLlYKkyinW+fc/WSJJV4NZX2NUhFsgMoOenqvuSIkGlg/r+JR?=
 =?us-ascii?Q?zIQ1X+UYo33TFEx9I191D6hY4oOe795h9hmB8bk3OcH+mQPx9f48kUIJ67Bc?=
 =?us-ascii?Q?zyXofEqUAyh2xbjuW4Ef7UDVkBH+buZM9Ef4CDqRKTdFBQ1aZdkBXN26aDOC?=
 =?us-ascii?Q?xLkiKFag6TxF9giyQ7SJpsKO5HI8rrZTRpQkaovy3cp1eCVqRY5V/ehgEsC6?=
 =?us-ascii?Q?2QO9GPsmGPyQQ4Bn2xNwlw/exCIsVA6YHyQLVMU+Hl3lEbzkQyHnTaXvZjMT?=
 =?us-ascii?Q?hvdbydWrcQD6SIhOMeVSrBaguZ7J9qUvpkm+alDLDWBsF5n8fXKQexoCcDsg?=
 =?us-ascii?Q?0RzD7p6pKXA/k1zOLxPSv0sKa6rXOXL+RqmUQr3Yyh0EmkDiKfFRUgn3fu/9?=
 =?us-ascii?Q?p8KnKnTOB2+tDZCdkKWwFx7NyWGlCOm/de21B85QPRIMigd/NQYnpTfeABl9?=
 =?us-ascii?Q?l/mQZhkCSAF3llBdtLmBpPXyxDY9kloCg8K7Nyq78NaZrmejB8bXgYhlHoCt?=
 =?us-ascii?Q?V44b1gfUjxHta72RIT/IvloTnbbxp04R7WE+BvsbR+nFlzwSQWYQFxDXxDot?=
 =?us-ascii?Q?OcGEc+jLAWiC/HNxl6LzXQgXVle/LUoZpI5yeiEQkR7ERBy5r21NBAR/3rXE?=
 =?us-ascii?Q?1p86QIIeH6+qXITC8J03hfHpzXaLMn8kJGEc6f7ABkjmjCkctPyMnm9IVTQf?=
 =?us-ascii?Q?X/CZelJsgtoShnbY5Iqve6VdAg63nXz2rpqBiBcVFKhZEQv40bCqllSKlQvW?=
 =?us-ascii?Q?OjDZb8myr2zv/pfRhlFBvC6XfVhIOsvjw27f0ZlfEnuQhok4jzJXoda0CJfc?=
 =?us-ascii?Q?BnrNrIfbuAiSbFllVQaJM2g1RgqoJxX4CJGEtumqCn5z9yVPG3x3PJMP0PA+?=
 =?us-ascii?Q?ZfHGIhiulnuCNE02+JHo+0T/Pn5Mn7aZbl3vmxQcPoOQ3Iy3jlozFrILhXcD?=
 =?us-ascii?Q?ZgZ6SKeFN62BE5psZyC6I15Z9nImi16O1HKt3F1LgTPmhzb1G8hyDH0Mu7iD?=
 =?us-ascii?Q?P5PeOhENnNmIDu7fmS3w8v79oWFQ5zPg/R9bGZrSc7bE7IIKDAuVKaV6tQaT?=
 =?us-ascii?Q?buos6Lo6oDImVazRYTG6H/M1J8H/RllU/CLG+u8X84h5C0pu5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sha5SpxLd4mCVYvPLnZs7U3mwHHGDebo/i8acwWGyQItwFH/i8cYp/YxkSAS?=
 =?us-ascii?Q?Zfr4bCkRdDUXVpPHRN+tt4Eprt1H1/4/XiF2Ipd/grM082InvEaX3e9tk9fv?=
 =?us-ascii?Q?7aO7AQM5s4NJebIiMdlJ3a7Xmpqr3Z52YsdsqEaBOFAbXGBM9JCKPiV983Jw?=
 =?us-ascii?Q?aYqvuW5qHBQpo1N9tH57m0zvQrSvOhqsUYmF0vbiV4AeRanj0fXepHw4+mUi?=
 =?us-ascii?Q?P3H3CfpZQAIj/W6zebuxAiWiavNwHZTfFqKQc3hmwxxKJ7w9M2C96IIY5qbt?=
 =?us-ascii?Q?Qfs4WoyWbNRe9+2CclXw2bSGkAJeg0/6/Q6VHnpoSJz0knKUOdRccc3jDfSH?=
 =?us-ascii?Q?AFCIxF0R1PdLrakNEl0DZetXqD1pV1YMtRU5VERj1qjghIUz8LjipI0pDcqm?=
 =?us-ascii?Q?9alakCyi33+BYvSeOFdrDbwOWt1YqUEbD/pchAEYRUrkduXPXPNhMjFy7fY6?=
 =?us-ascii?Q?TULve9Jtp+R+Dycf7yS8iRlb9pbh/Xz7MoJd+Szc/atvB4LPVMkgB3ahmAuG?=
 =?us-ascii?Q?2RoETNCz1gv6TDoqyiruf0XdKvCPvufZO8XXyPzXkTPT+C22aln9IeRmZ8LW?=
 =?us-ascii?Q?ziVuKygdtbtI7D4IK6jBbnhOKa5wNzbi6YLfngcR3XcYueE6epexEe/+od5Q?=
 =?us-ascii?Q?Fv3LoFZhPZR6T2cF9X93c0uKcVycWIUZmqn3+PLIxTW9h1ww9+kKEL6PTs6A?=
 =?us-ascii?Q?xyoPZZEwv9cJ0hbz8UjxOvL1jOB57Pcv/UnWEI4dVQxispzy19sCQW46AzOH?=
 =?us-ascii?Q?6gTG/xrZ0dXP8FtxTI9ApmNZWucbl6PvrUgrsjbwYTgcCaTTWhRr2P+lnfh8?=
 =?us-ascii?Q?YDeffWqpLvz3hmpBUJJpdFSt5BOTKlicgad8pJY4pun2nrm/7ffiPh7JabEf?=
 =?us-ascii?Q?mpcpulMXWgtQYZXC3mWep2+FJpddFnYEYLtARLwJOq8EXTCGPDw+kRmCQP9C?=
 =?us-ascii?Q?RSEZH10O9HPRlswAEbWSGa4737WkNfZHsam7hY/BHHEurzeTcwlSd1BwCM6a?=
 =?us-ascii?Q?TjOktcZyisoYYT+o8dzaqCXnsk5bhKcj7vUiwcAHYny5x/DCSJpDNDLyIk6i?=
 =?us-ascii?Q?qhFMuEkfTdpONyzRXTQXOqxn9gsZB/j75aesv6WsQmZ77tB7swWvv+VLC6Z7?=
 =?us-ascii?Q?lzAY/4do/OC+pS50iuAsP/4rxUt/OfwsfWL+fU0DJX1vAkf4GtoaegBiOqVn?=
 =?us-ascii?Q?fAR0WhIbQDc0L1lF+xG75cEWnLunnNc/cpKPIpq/aKT9rGw45Vw3Jix34oCI?=
 =?us-ascii?Q?oKF4weOo54vlvWNNy56pZ5eXGGM9o4sIwklcPirFaoJunS1zm8oN3/b7ZyGu?=
 =?us-ascii?Q?DHFgO/U6aEfaDXJc0GJChQoX6syF3p49BLj/19+3p7EaWYJABvkxGr7dr8Rv?=
 =?us-ascii?Q?z4UG+4/lYQgpBJncP7AMrsXok8ooBf4GLt34bkvzfdzFCKknXb85sky2Y09u?=
 =?us-ascii?Q?iuSERU0A1Uj2rTP3kxVa0FxAX4jQP/WPN816BuO3UeKpRVKCzLjwelTVSU/F?=
 =?us-ascii?Q?T8DLWBLaoeWmSvb6y3G5rD/YJ/3TaZSRuaDGiCKgjxuC7FG0r9oWA+alCvdk?=
 =?us-ascii?Q?pQjwJ4Z7TUZLamQV6BqqRY0ZBzBPtoRSnC6/vOXuuZMt+awPle8m6g8N3zrX?=
 =?us-ascii?Q?A+7ZwA/1h+ilTPzQEuRDF5Y=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ddd485-38ff-4960-2303-08dd18220448
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 07:20:53.8400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPCnal/2aPa9CBsHbN1xp3iAoeYEJbc0/id/8nomJFsJKRDA+D2t+cFK32Yi2x7scKqmV8+t3sFcYjhyxHihDwDCGPSaYincxuuNmWQsZAECL3eQcRKgL8ku48X41RMo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7876

From Documentation/admin-guide/kernel-parameters.txt:
	rodata=		[KNL,EARLY]
		on	Mark read-only kernel memory as read-only (default).

So "rodata=on" is the default.

But the current code does not follow the document, it makes "rodata=full"
as the default.

This patch refactors the "rodata=xxx" :
      1.) Make rodata=on behaviour be the original rodata=full.
          (Drop the original rodata=full.)
      2.) Introduce "rodata=noalias" which is the original "rodata=on"
      3.) Add more comment for arch_parse_debug_rodata(),
          update kernel-parameters.txt.

After this patch, the rodata=on will be the default.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 .../admin-guide/kernel-parameters.txt         |  2 +-
 arch/arm64/include/asm/setup.h                | 25 +++++++++++++++++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a22b7e621007..51bce7b9d805 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5901,7 +5901,7 @@
 	rodata=		[KNL,EARLY]
 		on	Mark read-only kernel memory as read-only (default).
 		off	Leave read-only kernel memory writable for debugging.
-		full	Mark read-only kernel memory and aliases as read-only
+		noalias	Use more block mappings,may have better performance.
 		        [arm64]
 
 	rockchip.usb_uart
diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
index ba269a7a3201..b3063326b79a 100644
--- a/arch/arm64/include/asm/setup.h
+++ b/arch/arm64/include/asm/setup.h
@@ -13,6 +13,27 @@
 extern phys_addr_t __fdt_pointer __initdata;
 extern u64 __cacheline_aligned boot_args[4];
 
+/*
+ * rodata=on (default):
+ *    Apply read-only attributes of VM areas to the linear alias of
+ *    the backing pages as well. This prevents code or read-only data
+ *    from being modified (inadvertently or intentionally) via another
+ *    mapping of the same memory page.
+ *
+ *    This requires the linear region to be mapped down to pages,
+ *    which may adversely affect performance in some cases.
+ *
+ * rodata=off:
+ *    It provides us more block mappings and contiguous hits
+ *    to map the linear region which minimize the TLB footprint.
+ *    Leave read-only kernel memory writable for debugging.
+ *
+ * rodata=noalias:
+ *    It provides us more block mappings and contiguous hits
+ *    to map the linear region which minimize the TLB footprint.
+ *    And the linear aliases of pages belonging to read-only mappings
+ *    in vmalloc region are also marked as read-only.
+ */
 static inline bool arch_parse_debug_rodata(char *arg)
 {
 	extern bool rodata_enabled;
@@ -21,7 +42,7 @@ static inline bool arch_parse_debug_rodata(char *arg)
 	if (!arg)
 		return false;
 
-	if (!strcmp(arg, "full")) {
+	if (!strcmp(arg, "on")) {
 		rodata_enabled = rodata_full = true;
 		return true;
 	}
@@ -31,7 +52,7 @@ static inline bool arch_parse_debug_rodata(char *arg)
 		return true;
 	}
 
-	if (!strcmp(arg, "on")) {
+	if (!strcmp(arg, "noalias")) {
 		rodata_enabled = true;
 		rodata_full = false;
 		return true;
-- 
2.40.1


