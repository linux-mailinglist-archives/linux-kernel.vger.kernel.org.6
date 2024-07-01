Return-Path: <linux-kernel+bounces-236295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F4891E014
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2BF2848E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A4D15EFB0;
	Mon,  1 Jul 2024 13:00:21 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE82215EFA2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838821; cv=none; b=UO6r7xEjTqdM+sR3p4dxPpdYuI6em5Ok4cx9KlJeAYUqCu4WrhVHLwSAMjSvEH6SmU7yxp4ZyC8YoF8IkD5hVhrLjwdWLckGLySlKqEQqSFhxZd1JyzjYDnpEqnqwJ6BwG9Yg2XSJqsdRszCU3vUVmuI0Jh6sMW6gccIlraC7t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838821; c=relaxed/simple;
	bh=DU5Rpao9sVkwftxVXiBbPjmDCfg1edojbtuA+4rU99w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bp5o0ssVDg/z8xJrZZGUNYNIV6QkH4ViH0n75tRPNRLRbw5wE1+3Jz6qc6QGJcLNZ9uqw971fB1uI/BYm+2xQDra4rMeVcjQl60FY8KSehTui+V2inETt2xkbON4ROxUGyjAT+y4zd8qd+Bxj27GrixuupsTmKsN+L3V56otgrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f61fca8c40so313268839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 06:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719838819; x=1720443619;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lKQzMVVd8JV3z0u1HLRD129oSCr8seG4wu/QgPU2cjc=;
        b=YycqUOh3sA0gJseUtQp7F17FefOJX/EF9/7YWmEbM9ryZiEWnqFoFkqO6gRSbjpnyh
         29OKG+t9ezDEJhE2v85qdgM+kIFMprVvrP4sSx+ahma5T8bXY5jOPbqMbH6ibaXTzyfd
         PWUbeSaPwat5eDf7erkGWPI2M+GRoxhiAVhpXfpTQJXJ+T3EKJLLpJaDS+Be46eGcQdr
         4SG+CM5n+RShVKqWS4bmhpJht2nOCAIfqe9duJ4lFcmUVfk1+/lUIAtdDeRUM5tDvirI
         I9dSDTSSeiqtVJ8QPK11wl+dRsH1roTiW4amRWYeEFCo8777UrWZOBXyd+EDsxVOZwAn
         HSPA==
X-Gm-Message-State: AOJu0Yxhqu/1fe/97Bu5HdKcALlZMWq+SV27v5BdvFzbwbplzcd7K8eM
	ElpPLRn/UD4g1OVmio6Cd0rZ5iQs+C+p2qPrnP13Xh7HrM4IskUGZo+qXBX2Bx6vtsGIe9hpevd
	fOchP+LQuwgALdaEFXPwloRXGStAnorg+c1VsCJ3flv2P7Rb7z6u7myM=
X-Google-Smtp-Source: AGHT+IFjfzX64Rdy84nGXFpO+a/9DdmBFIA0Cb03XfztEfHdSopox7b2rYRLwMVVIk6xuXUnH0kqit7skKw8yR7UbffZUoOxCs2j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f8a:b0:7eb:75e9:8f2b with SMTP id
 ca18e2360f4ac-7f62ee6461bmr43693339f.2.1719838819082; Mon, 01 Jul 2024
 06:00:19 -0700 (PDT)
Date: Mon, 01 Jul 2024 06:00:19 -0700
In-Reply-To: <0000000000006cbc570618c0d4a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e1f1a9061c2f2d82@google.com>
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

