Return-Path: <linux-kernel+bounces-235996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B654091DC34
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5305D1F22003
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DD612C52E;
	Mon,  1 Jul 2024 10:17:49 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ADB381D9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829068; cv=none; b=ZU/kIFTQpGiw3XgwFy1pxXxtCLcZEih+DSl7PV2kVe11srV53wMaG3368MTWEWXrZrNL6rE/Ubw3rV2ErhCPu1WjtDCz0mct12MxUY7TuTOZ1SLakgk95ezawbjdLCsasN3c/z3XK6d2x1ggzqZmD3pn4BKEj0PMYbRljsGX+m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829068; c=relaxed/simple;
	bh=gD5VNciUmya9nnktxztF3YVxZqyKDZW7Eo+EKHt/dOI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZQmfFaMUFYCqPADcc+5s5+t86ZHeZOICZhGzA3bmZmvLJPFrGXP21IzpBpvBV5NEDtH4wqbso4fgakoM5A9UafTKrt6dZ7zGcPiTITnkG1l1s7PrQM6y+7EDICX5hRzlr9FN5vPyaw+lPW9tqIzlDbQzNZ9OFk5nwrdkNRPKQns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f6218c0d68so321644239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 03:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719829066; x=1720433866;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brX9ipQBvZqJcUy+uAGuKNo04VrHpo2fWqw9e458zqU=;
        b=iyiWxS1W16hZvoVzxmgti1OhWHhzbXA6cYKhUSCy993L51trJqibLBNhGhL/z5mY8g
         31KTs7xlwLbweHPxjxZMYkRf+zl6nsWF8AF3j5U/aa0KXxwgK3zdtImjc+VFq33pWhtg
         FpzQwmWv6ee2rteb9++d0q/+YREuDacENdCP8HARpJkFQWl34cLUv3RW+L46Xm8aZCMS
         WyDLGQCg72LxsD5Vtz6xItpPESIXD7T4rmy8dC2HfMQ1ISyB3gOvwnP+ONMegkmHCWRO
         m93mcwjhIvx4tN6cwC2W67LrhVvy20Dh+rx8dqUQFEzTYqq5rF+83rMQY/0cDypvEAg/
         4kZA==
X-Gm-Message-State: AOJu0YzwJdFgx0ffhmd5Xe7jPNAEd+QC9MoO4zNH7oJI19MaUNlgKFOf
	gBRoLlLJSBUjrIWx5n+kZ+2QW/C0o0nWApJKEyaZFcbeF2pwnz5ZveNKKFb751Lp7sf7LMN3kFE
	xK3xAzsaAtS1W4u0QavvtWBy4DE9zaqC69Mybke2JSfZVvSYHeZwpi5A=
X-Google-Smtp-Source: AGHT+IESwWqAFL0WRbaHYTHTs5/LZCYswVwyly+ZCxAmQva/cgh8xqdYM1LnCtyXF26nEVhuR+4CwwjD47E8sPyfHZAPgwRTeNi8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1511:b0:7f6:1b69:a0cc with SMTP id
 ca18e2360f4ac-7f62eeab21fmr29792939f.4.1719829065732; Mon, 01 Jul 2024
 03:17:45 -0700 (PDT)
Date: Mon, 01 Jul 2024 03:17:45 -0700
In-Reply-To: <000000000000fb15d306134ae036@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089ab17061c2ce84a@google.com>
Subject: Re: [syzbot] [syzbot] [bpf?] [net?] KMSAN: uninit-value in bpf_prog_test_run_xdp
From: syzbot <syzbot+6856926fbb5e9b794e5c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [syzbot] [bpf?] [net?] KMSAN: uninit-value in bpf_prog_test_run_xdp
Author: wojciech.gladysz@infogain.com

#syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux e478cf26c556e4ab572ab0ab2306c986901dcd61

---
 kernel/bpf/verifier.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 36ef8e96787e..13a9c2e2908a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7146,8 +7146,8 @@ static int check_stack_range_initialized(
 		 * reads. However, if raw_mode is not set, we'll do extra
 		 * checks below.
 		 */
-		bounds_check_type = BPF_WRITE;
-		clobber = true;
+		clobber = !meta || meta->raw_mode;
+		bounds_check_type = clobber ? BPF_WRITE : BPF_READ;
 	} else {
 		bounds_check_type = BPF_READ;
 	}
@@ -7230,8 +7230,7 @@ static int check_stack_range_initialized(
 		stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
 		if (*stype == STACK_MISC)
 			goto mark;
-		if ((*stype == STACK_ZERO) ||
-		    (*stype == STACK_INVALID && env->allow_uninit_stack)) {
+		if (*stype == STACK_ZERO) {
 			if (clobber) {
 				/* helper can write anything into the stack */
 				*stype = STACK_MISC;
@@ -8748,6 +8747,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		meta->map_uid = reg->map_uid;
 		break;
 	case ARG_PTR_TO_MAP_KEY:
+		/* always mark read access */
+		meta->raw_mode = false;
 		/* bpf_map_xxx(..., map_ptr, ..., key) call:
 		 * check that [key, key + map->key_size) are within
 		 * stack limits and initialized
@@ -8763,7 +8764,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		}
 		err = check_helper_mem_access(env, regno,
 					      meta->map_ptr->key_size, false,
-					      NULL);
+					      meta);
 		break;
 	case ARG_PTR_TO_MAP_VALUE:
 		if (type_may_be_null(arg_type) && register_is_null(reg))
-- 
2.35.3

