Return-Path: <linux-kernel+bounces-543922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0465A4DB7E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329C83B3554
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D1F1FC7CA;
	Tue,  4 Mar 2025 10:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Ts2Fhy3N"
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141A21FDE2B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085620; cv=none; b=SctUCPBZ8ZGCeqkI/X2o1xWZXYBnxAv9T5Jk2vjv4pBV050SpJlE1RDcfKlIOtHAUktSf0gynWt6VRJTkSWXhX5MPM0K+LfljH75If6lz/XelRikdyN4J/MNDD6T1CRpPwugmq7j5bLhyyiM8EImJsu08XtVGHYT3Zh9ceklvSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085620; c=relaxed/simple;
	bh=VCfucskRC2cvY6966shLxXr2SgNODQiP9tZAsdqtyxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZnr6fCieKAb5ZVdz+5F50OskXg6mFEPNGCg1CRu8Ko2PQaAtCpGZSM9Gi+TW024akDhcewTeHQGFNZuLriZw/AUhJbp1IWpR8NcAtSvW6ZFv8Uu862BFKC45hE9Q+9mKvTe+G14mWGrjvIytcVeZuBAVKaqvaGCngdWWqcNjqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Ts2Fhy3N; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1741085590;
	bh=J+AbzbeKk1TMOXRqPTcIrGEKxdHexrILpO1xrigQbXw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Ts2Fhy3NoH798WqrPYgtOydEju0evau98tXJ1IcAbU4cuiylLRseMKescOf3WlPhE
	 oyLAfB8UYhRvL0QjSScIzgyJY7m1jGSmihi0TCEBJzDuoAFqH9ZB9373YxxwZ+E3MX
	 /h4DuYyPhrZulqLU6WzzDy/B0JJSNqJ9grysGQ58=
X-QQ-mid: bizesmtpip3t1741085573tvc43m9
X-QQ-Originating-IP: jfMFLMqo6HvurF85wH0TBlAZWnlJjGgvU5j6z2Ly9Yw=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 04 Mar 2025 18:52:50 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6603146197274234106
From: WangYuli <wangyuli@uniontech.com>
To: chenhuacai@kernel.org,
	kernel@xen0n.name
Cc: yangtiezhu@loongson.cn,
	maobibo@loongson.cn,
	guoweikang.kernel@gmail.com,
	agordeev@linux.ibm.com,
	ast@kernel.org,
	usamaarif642@gmail.com,
	jiaxun.yang@flygoat.com,
	wangyuli@uniontech.com,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	chenlinxuan@uniontech.com,
	donmor3000@hotmail.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH] LoongArch: Fix use of logical '&&' with constant operand
Date: Tue,  4 Mar 2025 18:52:46 +0800
Message-ID: <EEBE30D1ACFF646F+20250304105246.766404-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MauZFeUCNtAMjs4gQDc9KQ/kWf+xVva34SNCoNnMK7/7sQaWFIrBYpA5
	HL1Q4iENEyRRxZH51pT4+tO+uG+pXnCqTVEFak/0Xgc43czIRYtWGHZfQORD0FASWngEBdE
	Otjbbc4tqQGw9lpPx5TXnI+JHsc53l3CsslykATMboYMWo8u+uKh1jeg9IZxzt8pfzNzS1f
	0D45DDGlFPHG4wTmhmr1bVpRpjZX5IK54qarxJMsVJbJEfskfvcb+yaU0eyS0as3egWLMDC
	WM7wEMFb40ctD/efTwZYZhbA2ItdsClfq7e7PUrUgTnU3ousuZdWu9SCjGRi1xbVs119i+o
	KYr2IIYCg5n1+iOksVVrxYpYiKNGPe5GhDOjDozkyW6AWe0X7aGwC94ufrq8RffxePVgcQ6
	AI6pwCFWC/pvlaPorKRcix1HNMOEczxOpwVmoWi26NhviWs6NPlB4jN5ncd9Qp5T/NwGnvW
	iSrMopauie1/5Z9scU2MJ3xmsGcgkCdCVv8eUzQ5+Qybw+FS0WiIYaWK/DcOficwQhiYVtI
	Zte1B8CToruvzJ9jMQIF5DXMOpr/MoDcJ6fYrJZ7Ay5B7e/wBi8nEjZgNtSHAAJ7qF5qupd
	a4FOR/Y1lXIF8QTd225uR2OtKqgxcT/ofzdGe9iuGFLsBcH07iK7LOpKbF5aaOxFGUUJ2Sc
	htMiFOYPXQ1U/iRQlbtCR/5tHmNct7B4TuUe4Qr/X6aOgYo6jFOz4vLuQoUZz4HzDVKQSJq
	m17nTrm1tTV/966XdWc4/4kJQt7oemSziRDyQ7+rLAwCBAwOAfAWdHJWEEXi/KOYX+zipx4
	edTfs4TYTzNcA2y4MHHDxR6CHQGmPy+zca+/QAZBl6z+3Bs2zmfhwa0haM5JCYOQYwuzGah
	ed/aksx9PFczs51iQrDosJpvSxjwB4ssmmO6NrlGeXH/zu2BO0WB1AwBRtiS0T+ldziKWcH
	BW2NgU8FdDxFSapyByN7BpCw+QO/l50rSN5YDDt1ipceq31sGYyyXCi44AnHcQzOc8Vt+Ww
	dhjGr2nHi6Qf/gfbwmKFo5YMTmejY=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Fix follow error with clang-19:

arch/loongarch/kernel/setup.c:335:40: error: use of logical '&&' with constant operand [-Werror,-Wconstant-logical-operand]
  335 |         if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) && CONFIG_CMDLINE[0]) {
      |                                               ^  ~~~~~~~~~~~~~~~~~
arch/loongarch/kernel/setup.c:335:40: note: use '&' for a bitwise operation
  335 |         if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) && CONFIG_CMDLINE[0]) {
      |                                               ^~
      |                                               &
arch/loongarch/kernel/setup.c:335:40: note: remove constant to silence this warning
  335 |         if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) && CONFIG_CMDLINE[0]) {
      |                                               ^~~~~~~~~~~~~~~~~~~~
1 error generated.

Fixes: 83da30d73b86 ("LoongArch: Fix CMDLINE_EXTEND and CMDLINE_BOOTLOADER handling")
Co-developed-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
---
 arch/loongarch/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index edcfdfcad7d2..834bea7f42da 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -332,7 +332,7 @@ static void __init bootcmdline_init(char **cmdline_p)
 	 * Append built-in command line to the bootloader command line if
 	 * CONFIG_CMDLINE_EXTEND is enabled.
 	 */
-	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) && CONFIG_CMDLINE[0]) {
+	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) && !!CONFIG_CMDLINE[0]) {
 		strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
 		strlcat(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
 	}
-- 
2.47.2


