Return-Path: <linux-kernel+bounces-235990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FA091DC1E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129A21C21323
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4778612B169;
	Mon,  1 Jul 2024 10:11:32 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714AE53804
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719828691; cv=none; b=cHvd0AhMby/EKtpmwDzxvpGcxZLT1tt4ASF/zCjZnSyZLCygT/WsSvuzqgx9Jn5ZjZXOW9gnmHpTpm5B9RMAXf0vDksuk4xc1YBSwxClaHYcLML8X0raZhvl0PTvSv5f6GVSK0Ci42NXCzkPw7qmsJCt6kx1SytHU1MF2FhgntM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719828691; c=relaxed/simple;
	bh=DU5Rpao9sVkwftxVXiBbPjmDCfg1edojbtuA+4rU99w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=P+BCzbGKwfGw8BJe0Ztxjp6CPg2YUiScxs30CwYCwmBOhhPUwXb3pm2BFPT/I4yI+c2giT/GsMpcnXMmWN6x31MftBA/v2D3CY9EstkoddqMee3grl47MS+l/xE1cVTlnbKs2IJVF4CIq9xWFAQYr4FsiKDz9oNisaG8fGDBbwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f61f43caa9so262350439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 03:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719828689; x=1720433489;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lKQzMVVd8JV3z0u1HLRD129oSCr8seG4wu/QgPU2cjc=;
        b=mpGT/0xzwVDUOvABvuqhVKO2lY/n+D3G/+ix1WkaV8mRS/tb6M/eWe7twll3kZ0G8i
         81Cz/f3+zqTCznkHNweKcD2RSxtQFEBLP7nXkUJ+UtW7j/Dmb+/MYAIf8eBN2Dn0V2bp
         bCLmzEHct7S0ovIVL/D9z8ZAH+ex+NOQ4ELL273AukKahHSLnENKX7EqeCNDiY8teQba
         0RjhY6pXqM8KUDmebtSkHsd4h+eqLyHhp+hyDzLxH1ujxsdJEBhbEzDFE/Jlp4UcmDZ+
         1BEna/A9mdriV0HBY/ss91URXJf3Ez/0Of7KEHnTtWfcEEoUH9qc/6zHisAbrWO0ynXJ
         hJ0A==
X-Gm-Message-State: AOJu0YzINQvv2eeQpMqYDYKfnnpuKXsACiOJlLMxcCIf8Oqp47D2+SLe
	R1V2bGI80Me11KUDrRYE6Y0LqZbwmTihWNE9mEOHm+7AeYa4sCpmt164d5nOzbmz1q0YSY2Pz2b
	Nrj14EP7craUIbrbd62BiDa0g04ZehuuBVnSVRySlerYB0c3fv9ebRF8=
X-Google-Smtp-Source: AGHT+IFdvoaQ4N19pW4uwmTvWryuN2R0PZgp75Rd0gT5L0KFj2GUbNiyYG4dX69q4OBLBnMDIwbJn1gPhqM0p0CoGhubh3W0Nv6N
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:271e:b0:4b9:80a8:3cf3 with SMTP id
 8926c6da1cb9f-4bbb6f21bb4mr288572173.6.1719828689559; Mon, 01 Jul 2024
 03:11:29 -0700 (PDT)
Date: Mon, 01 Jul 2024 03:11:29 -0700
In-Reply-To: <0000000000006cbc570618c0d4a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001db3e9061c2cd20a@google.com>
Subject: Re: [syzbot] [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_hash_lookup_elem
From: syzbot <syzbot+80cf9d55d6fd2d6a9838@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_hash_lookup_elem
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

