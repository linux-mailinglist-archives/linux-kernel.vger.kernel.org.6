Return-Path: <linux-kernel+bounces-329261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C60F978F52
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCAC2863C9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C1913FD84;
	Sat, 14 Sep 2024 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="en+8GXsv"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4066C13B280
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726304473; cv=none; b=nMUT5VofnkQSpBoCjLZmr5QowdbXwlJjyaSy5KAU3riXErF4UXzarNdPMmYM+sCqua1swEaEJlAgHrpIu2zcEdTcxO4hO1hruoASDeBj27jmQqyQTmTYxFu2rRWVPzNPjnVHkrHvLB0WO33dC3rXyfNx9/rYG3c4x6UL1ghJqUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726304473; c=relaxed/simple;
	bh=WXFTPPQH1FDQYund8Z/7xE4I674AOlbBzgJ4AgKeRs8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oc9TXzXTIvYGkCoqJ9AIoXE6yPCnzWrwj75cvK2ogJaWq5vyYa4o86umACaa41SR9hdJr9qLMd7r77qd2YD5KyvnTMzcHAurQZJRjGAKMDEG5Y0jJbPgi+UDRNZuDnIEOXBv6ULJJ26JWPiFz5McOEwOworja1VDsAI6D5PiEc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=en+8GXsv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2059112f0a7so15612745ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 02:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726304471; x=1726909271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=80gUEy4Xpou+IbrhU/9l3MOOZ3f+Iwp7Qlf1giy0P58=;
        b=en+8GXsvUsL0WWxeoQx1FLaQ9P+BUBtPURMnGHuwSCNAp9oOEub0tZ9t6iWXLCjCEu
         fpH9HXXvq4al4bdprib07XGbngxpMhxT/xJ4p/EDb+Gn7p+2SRFTzMYVV2Fj4Q/48pVR
         IsCSnBvNJ7ZMk/3E2Stusx5qpX7t9He3GI+eosWT58XaGBr7j5url1vJVcguRpcw29U4
         0oNTtNoNZG9tqH1lkkKfY62HznrTmpFwVGMcrM8mvajYXTjpmyH/cHhA5qH/nLjZgaUA
         3ZLHW/CqzzP9HwijwO3hhdYwlZaTO2OEhZjuz0n9vw/lAxiEU8mZNdnciwwwB2Abmlon
         ut4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726304471; x=1726909271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80gUEy4Xpou+IbrhU/9l3MOOZ3f+Iwp7Qlf1giy0P58=;
        b=m8j5b2wVrJl4L0N/58tbjjmgCxN1fnfpdmv2HEqNh1JnyarKgvqn6dyum9s3+TOSR+
         zWug+woQ0GUe0npT3iD4hcMWQylY1SK+161r+nZHnytbogBhwFBewF4uUY/wFnhvpBk0
         ZDix90gLUdvVkmAFZ1MqM9aOF5t+1Xaa98K/CwcbkgyDJ4b78RHFztVMSVnRk8+UjQuP
         g4XPo9decR12kk//xX60939JdtMIMSbZR9xH2PTRdOY5zS2IpWRCze/Xyb7mubTeoU3P
         IdTpkGo8FfR5IuEZQHzVmpta6Xf36IIr4lHPNXMqfxJJ6OCLDrdwYJQ6IzI0qEY6Vnx5
         LqSA==
X-Forwarded-Encrypted: i=1; AJvYcCVdznuqZAOJo2lqHjRsqJvFlhQOJw1XIZ+viFeSb+UqUJc1TxXQ8We9Qy0QdjNWz5H733gQhgN0XnqJTEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YylX8rnIzs7OvdL2HjewvUbBf469yFarfM4kgglaba2jtKl0PT+
	+0qrcgo/KP3R09hOjWONO9imec+/uZIHSo6MP5v/+mVrOj+H9YQ9
X-Google-Smtp-Source: AGHT+IG1DBSrsAg0ikSLradEKrt+4UxO3yKqee0CzbioY1UzBOJiyV9ahXp6yXnodFqScK6Syx2T8w==
X-Received: by 2002:a17:902:ea09:b0:205:88bf:bfe9 with SMTP id d9443c01a7336-2078284bf3dmr86790815ad.15.1726304471420;
        Sat, 14 Sep 2024 02:01:11 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p10213112-ipngn20001marunouchi.tokyo.ocn.ne.jp. [153.220.101.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794602f36sm6587175ad.83.2024.09.14.02.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 02:01:11 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	broonie@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH] arm64: Remove the check for CONFIG_TINY_RCU
Date: Sat, 14 Sep 2024 18:00:40 +0900
Message-Id: <20240914090040.166671-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the commit 4b3dc9679cf77 ("arm64: force CONFIG_SMP=y and remove
redundant #ifdefs"), arm64 defaults to CONFIG_SMP but TINY_RCU is cofigured
only for !SMP systems.

Remove the check for CONFIG_TINY_RCU as it should always be false.

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
---
 arch/arm64/kernel/entry-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index b77a15955f28..a9765364fc67 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -40,7 +40,7 @@ static __always_inline void __enter_from_kernel_mode(struct pt_regs *regs)
 {
 	regs->exit_rcu = false;
 
-	if (!IS_ENABLED(CONFIG_TINY_RCU) && is_idle_task(current)) {
+	if (is_idle_task(current)) {
 		lockdep_hardirqs_off(CALLER_ADDR0);
 		ct_irq_enter();
 		trace_hardirqs_off_finish();
-- 
2.34.1


