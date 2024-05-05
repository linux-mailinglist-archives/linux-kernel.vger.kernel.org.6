Return-Path: <linux-kernel+bounces-168852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7F98BBEDD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 02:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95EC11F21845
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 00:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239FE620;
	Sun,  5 May 2024 00:03:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5874D365
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 00:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714867386; cv=none; b=aPLyrBYQ2UturNkyxmDowRPABBI7MJ7KJG2UlwagA03yzyxmXpbaD6sYtXtF8iXtFyDTZlvlMXT7JyT0ZUdhZAgpgtZ92/CYIMFJ43ZrZU++qqgdGgd5klZxzjLva3FrpXxEtf3mGwsdJGdKUfUZGGAnJjUEetEJHYpSVrKqIwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714867386; c=relaxed/simple;
	bh=jsSNkU2zZXupwaepQb1WMOS6XmMUEZuXmj1Thb6JCyw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MKz86T0efUctjr/N318ccU9TdYD7Kr7HWwLrEmudA8WD/Of8X3XWi9VMnh8X49ze585k7FuJ+EhPyvBVt12D4+cj52Mjb+7IJ+mThV1E7h15DNqTeSHUHZV7ZbOgteSAKjbKcvl/f8J5pwEAwB+oRjY6xrTGAb/x06xynWdhFxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d9d0936d6aso112488839f.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 17:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714867384; x=1715472184;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnNBQ81h8k7ERV5ebtkWtaibg41xlLVn5+ny9JkHZkw=;
        b=RkbnyXxcYbeGahLjN+PN3LLbR9Diypd6HKrKGcpqUJzJt700vyyYTB5TSQ/sMSupbx
         oT160x3PtYnAE7dHFBYrpBehDjvGMt00yWU4eSyMOFbqKJ0QD5zJnaoQTzbLApUjkq19
         R6ig54QjqIc9hCKcJnCfYQityg7QcCDnZ+FNzAQT3Po54mhTh5qLzF2khEmpGi9tDCSy
         rPiGA9+6DDmoNlR62oIAv128Ky9jprppeRiYfhccxC63UbqxtMk3OFBy1fM1Wf/zf0fX
         VrhAGlAogzmn/oXm/a4OwAQrtvAZZxl76QnakgzAfxhR0vvFXJl26tN6FS63pAKBb/Rt
         P3kw==
X-Gm-Message-State: AOJu0YyVLRdjcF5q3UUZify6Tq/RqWCOv+BVY9sJlbn2ya7qg87R9H66
	wzEwcwej94fy5KSaplTXy85LmQlZ3aAI4/n+yd9mfi7bUcNNBbShr5OxhBVG7Oyd6uPqS2QndG3
	boOrBMzwaOcoUSzbeyV2Tdndm3aCQHBCF3A1vt45K/HNMnqaOGBlGAMk=
X-Google-Smtp-Source: AGHT+IEdgbmIHEsQk+c+bas+ycdBwCH40Zw5lP14tS8kddZ8dH0uZixAXWCztrBKCly6ElXi5PXTNSMS4KBxP8lz6Mnzu9sqDy7H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:870c:b0:488:62c4:9b41 with SMTP id
 iw12-20020a056638870c00b0048862c49b41mr89327jab.0.1714867384534; Sat, 04 May
 2024 17:03:04 -0700 (PDT)
Date: Sat, 04 May 2024 17:03:04 -0700
In-Reply-To: <0000000000000f823606139faa5d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004adbe80617a9add6@google.com>
Subject: Re: [syzbot] [PATCH] fix array-index-out-of-bounds in bpf_prog_select_runtime
From: syzbot <syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] fix array-index-out-of-bounds in bpf_prog_select_runtime
Author: cam.alvarez.i@gmail.com

#syz test
The error indicates that the verifier is letting through a program with
a stack depth bigger than 512.

This is due to the verifier not checking the stack depth after
instruction rewrites are perfomed. For example, the MAY_GOTO instruction
adds 8 bytes to the stack, which means that if the stack at the moment
was already 512 bytes it would overflow after rewriting the instruction.

The fix involves adding a stack depth check after all instruction
rewrites are performed.

Reported-by: syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
Signed-off-by: Camila Alvarez <cam.alvarez.i@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 63749ad5ac6b..a9e23b6b8e8f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21285,6 +21285,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret == 0)
 		ret = do_misc_fixups(env);
 
+        /* max stack depth verification must be done after rewrites as well */
+        if (ret == 0)
+                ret = check_max_stack_depth(env);
+
 	/* do 32-bit optimization after insn patching has done so those patched
 	 * insns could be handled correctly.
 	 */
-- 
2.34.1


