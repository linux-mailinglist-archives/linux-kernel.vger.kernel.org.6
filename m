Return-Path: <linux-kernel+bounces-266670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A362940484
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 04:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC90C282B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 02:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D986241E7;
	Tue, 30 Jul 2024 02:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LokoxqXu"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643CC1CD25
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 02:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722306150; cv=none; b=c0Gciv+SNim5+HFD1sgnjkTO5VL/uT0R6mySPRsoucMwQD9fa5OiKneoobX2dUFG13mJ7+oloF8uZklMJ7eQe9J0tEqMhbZfFGclMX7q+sJJdtXhvGEoqBSnchQsyyG8NbEmNFXQ25i3+9dToD3fZcxjfyQHKf+txC0L1+Je7dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722306150; c=relaxed/simple;
	bh=fWmYaF9LNeV5FW8d5vwTch1vutMiQtNfswPciAKVK+g=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=pbY+PHRJogJjxJAC65UxpNKAUk+m51M08G8Soh7RV4SacjDkM3nVnLLKp9+SBFy16yDL4zioGK0ho2d93aHcvg+UK8NYQabByfO5nR7/PKaHnz0IUPOTqkfUbyr25PN9FZovvAqHg9vzmIWuIx9EvT0xu1Rdwd+meLg8xpm1qMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=LokoxqXu; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722305837; bh=e4BiddygiMUEciWjr58qt1r1xdeE6sTI61E9qxkAXeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LokoxqXuOeBz8nBKfdDq8X5qsanL5dIkBuXvXBzcLr9+Oe+ZSP8IHG/D+kNWFY01r
	 QBNI1BwJO5GXebG6mNqUVg2LH0Ez8lqOO0wR9LZ6zLJ3QEanfJptW/Wj0ve32zT3h7
	 uq+jV2YBgxtbl6PFNvR8mgZitMhBcJDNUeyrjkog=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 44FBEA3D; Tue, 30 Jul 2024 10:17:15 +0800
X-QQ-mid: xmsmtpt1722305835t34e8a7fw
Message-ID: <tencent_DAEC5ACEE079366E9C2C516E6C9568E9AA0A@qq.com>
X-QQ-XMAILINFO: MuOYcNghSeIL/OqnOI88FTgoRq9tZ03YsJL5d5kMFNOjiya8sNzVOk4vRfsQwb
	 Ga/yNLsCV2POFDnR0xWb0tzuvzJytGM5QTQm/7z5E07e2VF3VLB+JmYkmKG9xAgZnX05b2t5Xdrq
	 FbcKExdwoRZcqoV5P7t4rvyCjsM5yJn+stAswpyU/2bzpQmeBOhk3NEG8/3oSjXBQMLiEdOeIQf8
	 xQtq5+8A7XrK4qepIdyDZ66fMwWEC1kc3ctK+0SyWeiHS8RGWDR5lp0xHdbtTujFD9ZQEX3jMU9p
	 ZSssthk8CNIFiLf5xQzzl9/GtsBcKWd2vCahS7l0Cmaa8fZNvijmW4qEm0APUaRPf2VJD53hXCTN
	 DvbMqgQ+6jUKpcZ5AjfxUOZ3ZkMgvU6dF5rpjRm8ieehCAlfC80pHOHInNx1m/WqcjU9emCwfkZa
	 iYunzDWPTi7kcKlMDM8cav/tXYBu0wW1GurLRiaXO1F7hIosNy5PMbXQNXhnzUwLON5zf2u2uk7o
	 kJrOGgt1tO1HnTHzOrunyR7EfOWHOCt5b3HBbMXe+pOKjtPeGpmmxkQcLCWZF9/22L6bEN3+TZ2H
	 0Y4O4GTPoUGzq9ix/EPmYkvmu3ag0lcxNFqyPsjuwxLxFruOBMqyEQRa1SjLpTzWrkmc9AYpFamS
	 U36eM4Cgvdk0yn7oBSa1hwKxIqbplWnUSH860JLMht6phl09iWzyBZHnV2kEqsMz6dEdu1aVzK5d
	 tOoycvxBh9gU/Lrz7hIRAm7UZn3aIO6BdNVxkL93zFiPntzE3+8iFcTmD1U/bz0kDkJdDSl3deHZ
	 VLStuOuZDgruOPtDg1V+VUwHBObB8ElZXszqbTutstyT8Q1YNj0dQqHHJZdyfBplfwg22O06MP8Z
	 /fYt8xTB1xJlexTxY3b5wQx0dEk7W3JTRYVjR2KReT
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+05d7520be047c9be86e0@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Read in journal_entry_dev_usage_to_text
Date: Tue, 30 Jul 2024 10:17:16 +0800
X-OQ-MSGID: <20240730021715.4172442-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000b2c0fc061e6cb26b@google.com>
References: <000000000000b2c0fc061e6cb26b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

entry bytes too small ?

#syz test: upstream 1722389b0d86

diff --git a/fs/bcachefs/sb-clean.c b/fs/bcachefs/sb-clean.c
index 47f10ab57f40..a10d3e6e8119 100644
--- a/fs/bcachefs/sb-clean.c
+++ b/fs/bcachefs/sb-clean.c
@@ -303,6 +303,7 @@ static void bch2_sb_clean_to_text(struct printbuf *out, struct bch_sb *sb,
 	for (entry = clean->start;
 	     entry != vstruct_end(&clean->field);
 	     entry = vstruct_next(entry)) {
+		unsigned bytes = vstruct_bytes(entry);
 		if ((void *) vstruct_next(entry) > vstruct_end(&clean->field))
 			break;
 
@@ -310,6 +311,11 @@ static void bch2_sb_clean_to_text(struct printbuf *out, struct bch_sb *sb,
 		    !entry->u64s)
 			continue;
 
+		printk("entry bytes:%u, jedu: %u, %s\n", bytes,
+				sizeof(struct jset_entry_dev_usage), __func__);
+		if (bytes < sizeof(struct jset_entry_dev_usage))
+			continue;
+
 		bch2_journal_entry_to_text(out, NULL, entry);
 		prt_newline(out);
 	}


