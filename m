Return-Path: <linux-kernel+bounces-236009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2172091DC44
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB08282AF2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2838A1420CC;
	Mon,  1 Jul 2024 10:19:47 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603A713AA35
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829186; cv=none; b=Gjrm/xoP5cX/sdfmR3MbOCHLzgQSa39HxB71QQUJxLTq2JVtm4VTXwtwvYzKtGnPuox2H7+Rb0O4xFjgX+nUzxxA94fTyC000AxExuN3IPkUvbyIgX3JWXHSMOfflNR+8HdxANaePIQ8m9bvziroj44TYVD5sHa5JjxPCG/Fk0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829186; c=relaxed/simple;
	bh=R8TFp0xEYuV7raeik2lyJR4VyRiUrnocL84SZk1BbBY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dpdRSbLrpgp/QjV5h5kSocE4I8A2ye1oIW66mDJW2cFXz+jKUqCn8TzR8kNLjTSgfYxomlrDnIGQawH235eORdwmQylp2gJQTWJwS3vbtdfKtwohfCXuH3aEWAmZcXr6y7JyAVSMlkQRks/lW3IvD9t7mgzilpmcqLvaCKRgJjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f61da4d7beso328881739f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 03:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719829184; x=1720433984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WB3NrFq68/M3/4CXR5WTqwWcpKGtWEP1edv5y/Wzsx4=;
        b=Elpdpa11GP/66NVzanrMqqTcl4MBMhlrzWNcLH97AJCOwgA0f16zITv/3FKB/l52Kb
         0wDXwvwdQG2K8+31/EuMOZF9yr7e2fogVup6+eBnpGt3iCKelY22sd/olS7scMqr6jjR
         Vux89JkvCALOgqRbw3vOZfA65W02YL2Tots4AE6dNDW69xHzqlPV3ltgmQC0aC8Glew/
         o1XpG8zyOStT57JhaZZsVrRHldv16E2RQP+iQE7u8lBmFBOsyurEzgGNh1GK4YKDhdhe
         saTn4jueEeLtFgL7boSXIid/TYX0gtK2cfaSKuZaMiJ7m5glOGl3+0DBPv+cWZBl9X2h
         Oy1A==
X-Gm-Message-State: AOJu0YztdFvtS0Pci6TXl9gHBo6W1Vl3vF9/j6VT/0/zxwRL7a9mHz4s
	vAQTbsfsVZv4gJ0FfA6mBno57Ddt0/WxMCsa+WdVgFDATOJgp1ktogynhN12v6z3hqcIA6q/oiN
	VZVC28NKLjxmSR8NpTyc8Xo1G5juKMKvtTg6eV379PdVDhlQL3TpXwyo=
X-Google-Smtp-Source: AGHT+IHZAhcOQG9not90fVBt5p0X91NEAQZq54SNGfOu8HdL7jHRz2emuDVsHitDYdQJ5DLf9VVfXuvXP+1zUimKxufUJqPPnt9m
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:871d:b0:488:e34a:5f76 with SMTP id
 8926c6da1cb9f-4bbb6bce7e5mr441528173.1.1719829184558; Mon, 01 Jul 2024
 03:19:44 -0700 (PDT)
Date: Mon, 01 Jul 2024 03:19:44 -0700
In-Reply-To: <00000000000067f65105edbd295d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ecd1c061c2cef15@google.com>
Subject: Re: [syzbot] [syzbot] KMSAN: uninit-value in bpf_prog_run_generic_xdp
From: syzbot <syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [syzbot] KMSAN: uninit-value in bpf_prog_run_generic_xdp
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

