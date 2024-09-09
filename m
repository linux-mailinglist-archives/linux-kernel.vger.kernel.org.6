Return-Path: <linux-kernel+bounces-321488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00CC971B1D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9491F2294D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4E91BA270;
	Mon,  9 Sep 2024 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="eweiLZKm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="q2nOikWe"
Received: from smtpout42.security-mail.net (smtpout42.security-mail.net [85.31.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807D21B7901
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888747; cv=fail; b=F8d/zAGGCHDWjWYzoSytthFqtinmU+vSGpdMTfbNPoK8stgQO2L1jiF50VofrxZjzuz+p9+ADU4pDRJfHDI3GPy1RYgD2aChoPQBGNJGXyovBhhCqoVpGPUXheklAXZuuS4fbQwh6pjlW6R/uhQCS2ofX/NyjW+vREhzWhkkXLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888747; c=relaxed/simple;
	bh=DlBtsP+yHL6mWeXFHedZo7xJcnsxHLkO3HTJki7kIVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDtFJX0huJZ0PlCTtKgHRq0Plq9rjxq6QybR8c9Fgxj2H9YvFTZXi7n0nAzDB7Pcs5G0vIecp3deMlVR7M8o4VIute7XHQ9PAklU8E7cO9L3SN79TMU/zOo3pnZDOTSmbybEjrzFxh8BhbSv/5PzpdkPA2bPlMdsxHydu2RiBwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=eweiLZKm; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=q2nOikWe reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx302.security-mail.net (Postfix) with ESMTP id 2C12FBFCE3
	for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 15:32:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1725888737;
	bh=DlBtsP+yHL6mWeXFHedZo7xJcnsxHLkO3HTJki7kIVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eweiLZKmpbQUqu567lva0xyrIiOEjDtWZ/eyEYbkdXAgLr8Wh8Dw539wv/Qx9t7be
	 dPmCROSDt9oR+26xLISoyGVuWvZGA+Afog+TPjuglX2JQDvKn2s/YttV0aRcR/xhM5
	 p5ymEfYi0PJ8VLxLbYNNMGBinEsYoCWLkNfib1cE=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id E1617BFDD0; Mon, 09 Sep 2024 15:32:16 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012051.outbound.protection.outlook.com
 [40.93.76.51]) by fx302.security-mail.net (Postfix) with ESMTPS id
 5AC92BF8C2; Mon, 09 Sep 2024 15:32:15 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2580.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 13:32:13 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 13:32:13 +0000
X-Secumail-id: <bde6.66def8df.59cfd.2>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyJ5hM2/8Ag4B/ws8+sfPAgo/Cfj6C5Tkddz0dfpQwBtpFqueezh7qtJl/oK1SbTmzEqz8mt0oigq8OGVFq68tMtHsBy0e7/P6UPIBCgIZC11+PuOYiuoJYyItS2Ia8IQFOlmRDy/ufJuvPbHyD6yewKlK1KaTd9mKAw+zts1XH7NTf9wIqFAmkXAoM+H/amS753OLZWj0Edf/A4yh5Gan7HrEjIhDwORxR6o5kQV4C5/iExItgX3YFPf6q+1l812DZiKEKSw33brtNgkH96e++R5QuhDJCk/MVx0jbdqZylsTJKEoY43GV7XCsIPBCYW7d+phhngzp/hG75wCWoxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DveJr7zsBccpWvAJKIk+kTDfNX03apt1gxEBBsrHIOA=;
 b=pvkejmH+JTu62tCGkrxAGoU/I7f2zWJTzuswrKajC61bcq5otV4NqIYt7BUOz1LoCqUG6QxCaVaNW3kg05j4Z4jBsv3LW6V/o80pKKZAnchbRbD1OYM932Dd8bcVYYPB7UY2h2xpuiDNpmSPi47dF6XFTBwd8O2gg1El+NQ3SbtaouMzFYy0LBGBGn9C4TJDu2vtLuXdCnJEjXFPE0zhOBlfHuzA4S6Cob1EYL3dBqKk9IPqR5pB1419gD77ibKSvWDBB6++XxbHfWp7E8o7wixr+3v8rwMBC8MxakqhZgkTGgpC3eCoeY2hOIS6YZwQrCjms9opthrdo6xR82uHhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DveJr7zsBccpWvAJKIk+kTDfNX03apt1gxEBBsrHIOA=;
 b=q2nOikWesCSR9cmoy3xUOeDS7gNf/I6ZICjalPAhE2vOn9Ak5HpGfwYjHSI2X7tI8tgsZhFuL3t7z0SiPPUg2BayO3cd/0MRCxrzXG35oENIg+71Lwh47m1iaz5C+3DnNMzZTPTbTao1NmU0xQM3Xu+It0k0Y4fDH1AZgENRWefHOVL88uzF3UYFo1j4ZEHN0uzUIinv79corbSm/OwEX02Is1UFteswYnCaSzMm5GfT/5T0GzQmjMPUTbrVgVVnc/kZToq+nIWRgho8y/FMmzKylKbE30BOk12TB3+xwgtdP2eRw5fNCcTThM7xxif/BDkQQuktvRefGhMf9T1EjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
From: Julian Vetter <jvetter@kalrayinc.com>
To: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren
 <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev, Yann Sionneau
 <ysionneau@kalrayinc.com>, Julian Vetter <jvetter@kalrayinc.com>
Subject: [PATCH v2 3/4] Use generic io memcpy functions on the csky
 architecture
Date: Mon,  9 Sep 2024 15:31:58 +0200
Message-ID: <20240909133159.2024688-4-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909133159.2024688-1-jvetter@kalrayinc.com>
References: <20240909133159.2024688-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0106.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::22) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|MR1P264MB2580:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d01f4b2-6d83-499d-ff56-08dcd0d3d047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: rowxQE88TECXkVp4EA/z5eMLyz9/dhdBh5a4+szikOVsg5v+BMomlYrkHOoDqEGVcHuX7RuBw/VCZy6/U/Bsrc2e/+kILtJp9HrMgZRY6HFWAtY7+fmv8z0T/2KjbyHBKHYML47WyD8j+Uh9ncbMLHnvoJclurFllQrFjxM3KVWLHGLVASEJSngiBIlRgQtDfzy2E3LdwPlSwL8JGsrkXe33N1ksUktKJc3IFnwOFAF2byyFzU9PiK1zo8RJjuCvr/OmOmHnzlnpOLRz/ocdn1imTnQDpQzdXyeEpgen7+t7Gtiy1IROgkDw+x7Ny16nnFlQ9oY1N/XrLBoxE9zwalAN4Y6opP3bUe3KDK6ukYrVWSvf0V8s0V71p3GNfa/4ZGXOVu4ZS0R8OSG25IKujTufdCQp7IaILbWWAC6ZONRlMslOw3rPWHWQpupkPDwi6c+W0vceySZVUhV3aYOi6wA+gOOyw3lNZTvz6Is4V4++qfRbWzxduiVSsygG8kNYc/i/77mvZQ3RfKKqH4noIOCbbWJhG2xoKjfmxNFbRaNhp6hLpeCPcyc56XKgUsKiNIUylKnYomCbA+0vLapkJtT9LDC+o+FWB7z67MORydFGx2L4qBOp4fPJkwXYO+MbfLNqZPSC2Eq225qTS2IHyCYfX7BpCCix/DuzbGysP4yqCMLPglyrWojoJL3HyWY07Jc3+0n91Sh6VE3jnkF921ctt6Guj320AL6ywm+vI/vZ+Kaov8sJX8qU3BP+APYqq0LY10oGdE0WRMXRmsGFMA22lXyT/0kGA4Z4/WOOskV2gn3y5qPSHuiQWV1oxlL5+K1PCdBjRe4ao74SSFYXhaw6DFQD6QEtoen76I0UxNDqtiB7OBiBADs8ehEEbIe8rWItu7O1pYgUYOC4M9zeXeFaeu6XqRipGHN/ZrX3f7KYbUFwT0MdnMDrVN9Oq0Fzbuu
 XOAEtvarjw+hOt4KLTHbrAEpUNBtR1zS/TsTTP0F+Zx2r7T/qNVzSrw8tHYS2B5zwG1XHS9pkWhQNwfeOsy8nyz4sSt2qswC1I/TBB5m4Uq7jxOtfemjvTLu+CsuvYi3Ye1jih/k4aO/bbgAvR4aLmIaLJbv9CtVdzAMH323ga+GtUjwiFtJ6xbjm2XCUKA77NtH6ynC5Qf7g0odH8BmCfUsQhdiCWxVS3Xgx/RlG4IUWxMYDDP5b8vAjZC1mZje77lNBXNTehl1EdgjYffI/oZcolOCo4OSx33ybDmo4IEYV7BaHrPfQJsXMk0tYlr9laj4YET3wGftiKG6wewqYmwD06zAqiWyOEMKhDoxv2uJiavGA8jcM09ZDSzd0nYbzfdSoiqg79baQPVm+xo3ksOECVfhwGbYSSj869FitLEzIpD4/QgsPUtqMEErJHX1PRVZ87YTIgr6zCgqhlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xljaU2FhCyBG4JtkCPqX7RxlZMGS3I8kXS+0iEeN+r/un5e6yYJMGmAv6PobMdq+L8QlOBKWn+uc8Q9vC4fOB240FVc31uZiW08115i7O3eQU5dv7o7ZAkrIrwiML0F/3pv8FbPwngHPab5dq0a7H0pjA4RHa6+gW6Ow+AIfZmjjR+5feAOLbEMHBomzJYC3mJNsCWj4UAy9B7W5sbtVL0SltNUp89KNaSB5R5FembJhGlyd1YaGz7BQI9HEB/UrJjz2J5wx6M+gpi5SLlS+CgPYtNc+g4b/P4KmYefjB7bwRy6tYa+4L6vDRF+otyKSOkohNvQK9C1K/FqrKVmjqhXzV0YH1KsIeotKL0syetFt39ZvZqYxMufDKu08/UtjQg6BbH2Lgg4BR2n8T9q6b+e+6vBAMOBM3ZyG/IXU4sCmxnsPaJQdKdfqCDSQnGF+dMDy8xOCjIcG5nVZIUbQASXDQthH20Oliy/OnesPaKieweO4yhXVwRmas8PTRmzJBCkluFb8FI5vAR1XuLLqAs4DI/mi2Qke2kNDJ5mrb9ho90Fws3FIQfBbrdK17AE27xHoHtoH3GqAWp77DJZvn3+JDfL4Bgb6fnTGC5Ke19mrKfFnGfx9a6I7pzrG5a2YpU4OXBUcVd007Ay6v52sirWkGlJg4AtHd7gG0iCJJ7Ca1WxCgGiRN2Iy7hlpwEypKI7nIfvr/4ZTfeRpZb6EipLW/PEDjq9qe7W/te423M9aaUnzCCbKY0MI6nFPG3bSYnbqkkdnbX5nBF6oQls7voe5Xu6I3wYONpUTuZ2TLe0z8GbR98l2twFZozhlM+RMvKGxrXC82UBCDObpp1K1oa1Yb8k01ufNWwGaXAnrcNFMWOuZMYIMjhev3Bm+m5EWOfVLDn5jXx62kwh2FkeBrgFxD1tJmRI2vYLlT7qI5E8uQ9Z1K+GllOCENXr4apPv
 NUbCFc8cw5RjRFHdfG7OtQwzDaLcdEyZic564nQMudb1opTZlM4Mo46sTrlJf6DF1OYRNoBzyDXJfsGqxCdYr6OD4NS/7WLzdbopuJuzUgAjVy2k2yGQd4hqydMnfxJTTvs/polqdnLUPhhqaIwQWSh3Atj25ESLsAy41ROsIVXOtAFBtPJ+GNWDoTv4JLv6D7QxGN2xbLWwc+WnnznDc2bv+FyjtOCHWG3KQCa+LZzJ3Kg7T6m1EGbAdz12siv5BymEAbwNqf8XRKACnQROovc2vk3qiR8wQcKCZ+kytMP1ii/egWTWRHzAwufpVY/DTc/3M5eE+g8zIprVillA1AvQk2hX4JCVXn1V02CyYj7qwPJeIjM5fxHutjOfLpjtUCQGSzZeSl/y8gK4Afe19OV/3QMJ/kpVLcIcd2rBBMBGinXB9RL4hQ2uJgk/u6ljRhydmItWbeVIza3iu8nGfn6NWqKulEwvxkeVGXQswgm5Cu5iQux2HaAq6mguOGZlupo1RLq1NFvdYir3XNnToiWM/8z9xNe3eBXdhfS8N8cN57PSDr6FtDftcvOh01hkHxOTi7C6TJD1SDzzjpue1uiPa2NHyFOdcGlDmJQVbI96jOA8gH+Pfka9AcjgMJbM
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d01f4b2-6d83-499d-ff56-08dcd0d3d047
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 13:32:13.1993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJ97Xy2DjSY5m5Cqrb+xVSk5PMgvlTYZnJJST1jEVAA6objdgLrlyL0cwZLRn4HXXnechdFdxcPvciw6hAl0rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2580
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic __memcpy_{from,to}io and __memset_io functions on the
csky processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
 arch/csky/Kconfig         |  1 +
 arch/csky/kernel/Makefile |  2 +-
 arch/csky/kernel/io.c     | 91 ---------------------------------------
 3 files changed, 2 insertions(+), 92 deletions(-)
 delete mode 100644 arch/csky/kernel/io.c

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 5479707eb5d1..59d4051b2a83 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -48,6 +48,7 @@ config CSKY
 	select DMA_DIRECT_REMAP
 	select IRQ_DOMAIN
 	select DW_APB_TIMER_OF
+	select GENERIC_IO_COPY
 	select GENERIC_IOREMAP
 	select GENERIC_LIB_ASHLDI3
 	select GENERIC_LIB_ASHRDI3
diff --git a/arch/csky/kernel/Makefile b/arch/csky/kernel/Makefile
index 8a868316b912..de1c3472e8f0 100644
--- a/arch/csky/kernel/Makefile
+++ b/arch/csky/kernel/Makefile
@@ -2,7 +2,7 @@
 extra-y := vmlinux.lds
 
 obj-y += head.o entry.o atomic.o signal.o traps.o irq.o time.o vdso.o vdso/
-obj-y += power.o syscall.o syscall_table.o setup.o io.o
+obj-y += power.o syscall.o syscall_table.o setup.o
 obj-y += process.o cpu-probe.o ptrace.o stacktrace.o
 obj-y += probes/
 
diff --git a/arch/csky/kernel/io.c b/arch/csky/kernel/io.c
deleted file mode 100644
index 5883f13fa2b1..000000000000
--- a/arch/csky/kernel/io.c
+++ /dev/null
@@ -1,91 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/export.h>
-#include <linux/types.h>
-#include <linux/io.h>
-
-/*
- * Copy data from IO memory space to "real" memory space.
- */
-void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
-{
-	while (count && !IS_ALIGNED((unsigned long)from, 4)) {
-		*(u8 *)to = __raw_readb(from);
-		from++;
-		to++;
-		count--;
-	}
-
-	while (count >= 4) {
-		*(u32 *)to = __raw_readl(from);
-		from += 4;
-		to += 4;
-		count -= 4;
-	}
-
-	while (count) {
-		*(u8 *)to = __raw_readb(from);
-		from++;
-		to++;
-		count--;
-	}
-}
-EXPORT_SYMBOL(__memcpy_fromio);
-
-/*
- * Copy data from "real" memory space to IO memory space.
- */
-void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
-{
-	while (count && !IS_ALIGNED((unsigned long)to, 4)) {
-		__raw_writeb(*(u8 *)from, to);
-		from++;
-		to++;
-		count--;
-	}
-
-	while (count >= 4) {
-		__raw_writel(*(u32 *)from, to);
-		from += 4;
-		to += 4;
-		count -= 4;
-	}
-
-	while (count) {
-		__raw_writeb(*(u8 *)from, to);
-		from++;
-		to++;
-		count--;
-	}
-}
-EXPORT_SYMBOL(__memcpy_toio);
-
-/*
- * "memset" on IO memory space.
- */
-void __memset_io(volatile void __iomem *dst, int c, size_t count)
-{
-	u32 qc = (u8)c;
-
-	qc |= qc << 8;
-	qc |= qc << 16;
-
-	while (count && !IS_ALIGNED((unsigned long)dst, 4)) {
-		__raw_writeb(c, dst);
-		dst++;
-		count--;
-	}
-
-	while (count >= 4) {
-		__raw_writel(qc, dst);
-		dst += 4;
-		count -= 4;
-	}
-
-	while (count) {
-		__raw_writeb(c, dst);
-		dst++;
-		count--;
-	}
-}
-EXPORT_SYMBOL(__memset_io);
-- 
2.34.1






