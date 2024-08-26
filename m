Return-Path: <linux-kernel+bounces-300696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E51C695E74A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 05:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BA41C2110D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 03:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23CC2AD14;
	Mon, 26 Aug 2024 03:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jcvGKvZB"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010071.outbound.protection.outlook.com [52.101.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D546FB0
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 03:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724642902; cv=fail; b=s8aBZZ2NpmDG0LWujAvcqI5+p1VYiZFHKZ3tWPBikC0qj3w2IIkPjud+t4MS66QOr7DS/cJYU7E9NhoAdhLAZba0LLqwd5dsAq9A49O4C4aC4AD+HRXyZvcyWRHmrA33TU0sVvpNpZb/Hzo52P10R1CsZYciQocNMCtzdVeJAzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724642902; c=relaxed/simple;
	bh=Zp6rcFp48DNS8GU/6V/67N+iYDezyhQQCDSWuJRYq2o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Qj+NNktph4cTOzetMlyvUkkN5xsVkV9I8hZ0cUkdM8s2h02EyYJPOHJDiUTu2zG3i348/2ncOUUWgYN4ZhWaJPXw8PIb3hMn4C8/9XuPeqxej0Hk7s/sehFOZA4LsBfooSD4C0pzzVSSR34fyzADnsbfiAZiQ+Rdzf4dl78ivT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jcvGKvZB; arc=fail smtp.client-ip=52.101.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJg13qqDt1KUaB2H3dyzv3KfjfYuIwNt12B/uqNdx+VnWhLjXrQ6AmvgfQRzx0Ec0w9jOr1Au+ftqV87/HukNnyimhYVkuu4leiqhJ6OAJBWOpxRcMVxkwSV4yJ1odPv6C5wdgoyMdb0I0p9giGG0A6wQcERNl29OX+WOFWProYqtvLm+Ib6LHmVK18bkDm9FCQjYTdZBcKFQBhRTqe4XtkOSpKGgdgAi2XL5v/rMdH3gShnGQbQHnIIh5kKpCL2+gt0je7riyfxn7zmLVygYy12eOzZi6ywjxwFsTexKfCoeQ346QU5yfYX+ubEbA83EAFtqxiL4NoW/PvzxdTmtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtLZ2KFtDslyyNHZ0N10sY+TKX/5FBkgIxBHZed/KnQ=;
 b=VjVLMxaqhZ8hdUZRn3kfdgrmUu3ETd5REqw9RbWY/X6Tv3ZS4VoS4EByz3YPzmPS7cC62lj6QnntPIcQogAlhQVsSdB+wsE+C9OWdpN7H9Bsl3ZB/6Q4fvrNZzkh1eV/S/fNHYZX/AtUs62/StQnbMj7Jvm2PFhPi+UjGAKOk0FjGnCGEJGqg1PxBPe2CNEAcP4hcGZoMQ7JANi3d44p7SECewnxJ5YAAyQwGxFz9COZips72RgWRcMMHckIn4JUIOrvrms0ni0hlvsFLo2aAJBiIR7e4AILdeDwyrZRAvwjsDg8ZniGSLu9jYF01B0bRwjUV8Dy9fuNGo+9n+24Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtLZ2KFtDslyyNHZ0N10sY+TKX/5FBkgIxBHZed/KnQ=;
 b=jcvGKvZBfEfOGGoT9IIaKjZPgX+X6Sy+41FjcYO08PJHsEO807ImM2wrjUMmwW86IqeqmXw0WPVYR0uylClxL0JSH3SZlcMNndEWbGnWhzDfI2E6cICTtBXs5CIswGjatF5pmxMt0ikpWoKV3YgNBkHDpscjX4jC8Q9dptwlrgrBhC1ZXkKGMZ2j4P8BD/BIoN3qwxxUTWiLMCDHq9Z5SFh33iUtJCRbnH4QRm59k0L9yQUGaRGI1/kNwTJNCAEAqdDhHnUMelYZ0Oj0x4NleqVIFaezMn9wZKRClCNH0K4p7js4MGKPMKH+FLZWeb8wo2KvEWjjdwkKRMh8ouhN/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14) by KL1PR06MB6847.apcprd06.prod.outlook.com
 (2603:1096:820:113::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 03:28:15 +0000
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f]) by KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f%7]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 03:28:15 +0000
From: Chen Yufan <chenyufan@vivo.com>
To: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Chen Yufan <chenyufan@vivo.com>
Subject: [PATCH v2] timekeeping: Convert to use jiffies macro
Date: Mon, 26 Aug 2024 11:27:33 +0800
Message-Id: <20240826032734.7570-1-chenyufan@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::16)
 To KL1PR0601MB5487.apcprd06.prod.outlook.com (2603:1096:820:bf::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5487:EE_|KL1PR06MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: b89464f6-6998-4684-e698-08dcc57f1f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0NIei6mswIsWtI5WJz7FUjnCoS4bD+CJ6iE7UdEs2xWF421K/dYHvq51aNfA?=
 =?us-ascii?Q?DUR/Z3d1RiidUo1XH6XyCXxMq4cY+EfnEtPNWpJK84mohGZ52tT/4ITHBNSy?=
 =?us-ascii?Q?dgXLoDZWoigqszktZMb6R034tULQ4SvmLdIS8q42ofvBMxRFa+m9Lh+5oSY8?=
 =?us-ascii?Q?cXgFmRab+A/XKioM6UX4vxnG6QfHSVOOZ1cfitCAGAxd6CLcxf+NjbY+ohzX?=
 =?us-ascii?Q?3HVQsUhOgpaITj9AmNnk7i3FR7G+PlZcJUzR0m8ER7MJQrj9u0nQ42MQSVFC?=
 =?us-ascii?Q?heux41hbupOy10btLOf6TiedNYI5s8dJT6rFjB3FytgVdFyuQ741XcX8xIGK?=
 =?us-ascii?Q?ECzOxtWZmXKITYP9wHRlurNYC0x+6o11D7EAVXZIpuNu5MO5IRuT3Ko99jfw?=
 =?us-ascii?Q?dw2WrvQhGT1r9KVFlp5//LvsY6AsUaJcNKSRMsDLZ2aTpHW2zmTBNVfu5itH?=
 =?us-ascii?Q?Bl5gPZA/xTtJYy32QGSAbmq3lQZvO662q/OYcEkLIxE246ruSI91YTm+daET?=
 =?us-ascii?Q?7Pis8rKj69c3b0Rne9T4Rrk16EKVlTiTqMKWhdADnqAJJr0V+njgPM4DFFUI?=
 =?us-ascii?Q?5OJU9ZlQxZVANmRMovvcDumX9mOv5eQcLqIx3NaGg6eJ3vD4Z1L6sHPg+tRS?=
 =?us-ascii?Q?ZlJndQnEDVC73OuVI0wWHUXTcOK/QnEtYMCStJVNlvRvT4bzWs2TuCQRHaY/?=
 =?us-ascii?Q?Rsf5rkLxTIbuIR16nVlyPk19qHLCV3itGNoeBrtxg1qNQUZbXFYChuUlm107?=
 =?us-ascii?Q?2gVAEPYSCethF3v2Ay+EjBeqz8tl+ozq/nDhMt4OcINuUbxHPU7OWJa2AcQF?=
 =?us-ascii?Q?XgygrZ1BwfFywGFd0TKdTRqb0Osk4vbcIiwODYaoCqOOI6cRoNuzgzsT9cl2?=
 =?us-ascii?Q?Z3iGesHf5Iy5cYWiE6oigW76Y3hsNlNiYRRpWVRORyxsZfdOh555+ecDSE8x?=
 =?us-ascii?Q?DETcFQfytDJKSxc/iiKlLM3bx1joloiRdoT9QaqXQe1WEPPc+U9gU/fIyaAh?=
 =?us-ascii?Q?UGZFUpJpmTOyp+CZNELQHFgPbXWtJ7qoONirOqU5cQO4xdL5Okf9FyaWspF7?=
 =?us-ascii?Q?xQvxqrmS8MbvIUhzClAT2xxNvBOqPaJKFs8vfKcWtTtPueAhLUWw30HuzrsC?=
 =?us-ascii?Q?2siSsEqawRelyP45ayn+cHW3Cgs/pWDavN4T4RQyqIP35i7PVe1cpThTwdga?=
 =?us-ascii?Q?Vh9aMqj3OeF4EgX2dKDFvGzNvWWH7XGfaXucnGdHIYibb4tVQhUKMJneM1T3?=
 =?us-ascii?Q?KAAXCxZ8Z4+hSTRq8kYvsMljmRkBGKEWnKRhXI2GwsC7++hKtpIjA5sktwKR?=
 =?us-ascii?Q?GvtrACsWVwHH20WkkWDTMvTKw6zVpvYAjVyIRc+nhbQLMgbnfDHu96W+cEzM?=
 =?us-ascii?Q?MTmBU9f6hzNUnnecLkfJmlBbFlZ10qx/oOzO8/s00PEjKt6Rtg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5487.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PPluaV3mO8omjUlpsYoxCWXPU1g+AFmFdb2ayZ+Na198to5H1PkLHs/wk7zO?=
 =?us-ascii?Q?ccq2XhB7d1642EigwxUddpf3YU8awvBVFLIlcLJGlfXUq5SJ7950c8nFZ4tO?=
 =?us-ascii?Q?zRkkCQWmBr2PxoblOCmO1B18jbN0FCoZo1SobfDfRJYPbqW2oxFVtCWQzmVG?=
 =?us-ascii?Q?vnzKl2K6tRnNRAPprRzsgOm+TAWouedag6dUAYrX5Uo55UO6U4GS3sIerWyb?=
 =?us-ascii?Q?3+CdGQPmzfwtFtIROl7UEMFAL/yY6tgWsM5Slv6T/lh72H4x1bnYsr5XTai7?=
 =?us-ascii?Q?aFOwx8brMIN9TiD9Ut9BVK9WF8NVavulEYnjCn1NrS1p3kkeqWlCPbUlc2HU?=
 =?us-ascii?Q?UK2hQ5a/xEiVIgyVRmGABRFrKkAS1IYVYOVYMu8npeTnZLJX8j26TNCejRyF?=
 =?us-ascii?Q?XQX8FfwMPLyprbf8CJS6PbPdG6PoD9c761UfF96ka2ntXBtNFFEJXhM/ZAU8?=
 =?us-ascii?Q?PljPVKK2zKdcNqwie6b/u3eP6OAmsRz9nfU0M+VG4uzu106DFGKYOSO36Ap3?=
 =?us-ascii?Q?HPqamDe1jzBJ10bAlyUlJL5l15i1VzI3J6yyjZnWOQ/2hituQKLA28Z/N9Fe?=
 =?us-ascii?Q?s/nmEQqOdTrSTnl+Ryctr2UnPOdq59qPZYYLBmygnh5dcvl2q/GP6/GDHl6v?=
 =?us-ascii?Q?cOpLbFoYa2zx2GgCu84J7RJn5HRKzxhatuIG9oFRsEgHtGfU20iCULKmgvyb?=
 =?us-ascii?Q?uaHknRsQEpVPgP5UrfRxvOZfpFxhSqO31lIEk5JCukkNIZaWfIFWQm02bloP?=
 =?us-ascii?Q?Dd4lxl6TDP7tqQBjQTcLp5RCIB3x0cooaprc6N6dSitd/fZhrVAzhIV7xGDl?=
 =?us-ascii?Q?NQEc7RN/jSt/uYvZznEu1VyoBbb11wvHehOkP0rNJYOYUmpOXvFNWr20qm6k?=
 =?us-ascii?Q?TQL05u1fkXgbMJyTmIaP+l3Pl3JrnebJXVS/9SchHqpqEspWjGumVJtRUady?=
 =?us-ascii?Q?4XiVHpgUB0lv1tWbr1rl5VSj3yamPs7dWv/5IaQ4lh1lo5weITTK4mebz/UP?=
 =?us-ascii?Q?1VhwJmYsAzB3/RMrPYrTu8QgyeoefzGJZVW30Rfl+ZVPE+g+Nxs2uMJlal/1?=
 =?us-ascii?Q?Z3kYtdk2SDhMxGkci9wHqgewSU8LaRmE7oMLlQySAi0UiftCplPAVsv4LMoL?=
 =?us-ascii?Q?LWY7TtWTJ6K12ueVbuZA46Qas+TEupqiqmVod1k9BqINyK8f+ic+SsAtfT0a?=
 =?us-ascii?Q?8lmr7gE8sp5tX+SU6ELEw+XyPGDMuH3jDbLsQHqaYAyjB9KxG6Bbb2f4yl6x?=
 =?us-ascii?Q?Uf3oqgxwFIoXa3zljTl+FqPymIGgijjYoT4earIA2yJrVJJXqScWb436VQQX?=
 =?us-ascii?Q?Su0ekkdQBDaTLvxraZrTTzwFwAt3OR7doyrj+RbzUX/cEOraToVja6cBO8Zp?=
 =?us-ascii?Q?9fF7kBEIgg309ZFjJt0ZzbjcZ54nQCwItQtTstmCga27H0nBHlwSBU+oKCMe?=
 =?us-ascii?Q?bNfV9QfKmRa0R0xOp25OL8FQFJIUrUHSdrlEqOcG1IPmo9AMEPQNgA44b3P4?=
 =?us-ascii?Q?bPs69nJUJlD0eDrL7lOghwDxQ9YtxwtIMKTwgWqXLmPjSpCap4vZk/bo/DbB?=
 =?us-ascii?Q?uMfA0iNNGcyQDWyRsRBCffB3RpWN974GQdWRqrD4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89464f6-6998-4684-e698-08dcc57f1f3b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5487.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 03:28:15.6935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yeCigiGzvkBVkdtSmVzkfdxel4SxYvhndqiZtldvac4DgKd06s6h9Xbs2I53JDzXOdT/GSP8G6rGtGUI0HcBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6847

Use time_after instead of using
jiffies directly to handle wraparound.

Signed-off-by: Chen Yufan <chenyufan@vivo.com>
---
The modifications made compared to the previous version are as follows:
1. change the type of timekeeper::last_warning to
unsigned long.
---
 include/linux/timekeeper_internal.h | 2 +-
 kernel/time/timekeeping.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index 84ff2844df2a..928a9258b7dd 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -125,7 +125,7 @@ struct timekeeper {
 	/* Flag used to avoid updating NTP twice with same second */
 	u32			skip_second_overflow;
 #ifdef CONFIG_DEBUG_TIMEKEEPING
-	long			last_warning;
+	unsigned long			last_warning;
 	/*
 	 * These simple flag variables are managed
 	 * without locks, which is racy, but they are
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5391e4167d60..6cda65dbe18f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -217,7 +217,7 @@ static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 	}
 
 	if (tk->underflow_seen) {
-		if (jiffies - tk->last_warning > WARNING_FREQ) {
+		if (time_after(jiffies, tk->last_warning + WARNING_FREQ)) {
 			printk_deferred("WARNING: Underflow in clocksource '%s' observed, time update ignored.\n", name);
 			printk_deferred("         Please report this, consider using a different clocksource, if possible.\n");
 			printk_deferred("         Your kernel is probably still fine.\n");
@@ -227,7 +227,7 @@ static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 	}
 
 	if (tk->overflow_seen) {
-		if (jiffies - tk->last_warning > WARNING_FREQ) {
+		if (time_after(jiffies, tk->last_warning + WARNING_FREQ)) {
 			printk_deferred("WARNING: Overflow in clocksource '%s' observed, time update capped.\n", name);
 			printk_deferred("         Please report this, consider using a different clocksource, if possible.\n");
 			printk_deferred("         Your kernel is probably still fine.\n");
-- 
2.39.0


