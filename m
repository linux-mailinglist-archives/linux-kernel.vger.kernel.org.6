Return-Path: <linux-kernel+bounces-235986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E2C91DC16
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C6A12817AA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A35512BEBB;
	Mon,  1 Jul 2024 10:08:58 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA5F38397
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719828537; cv=none; b=M7x9pNcTyC3cm86i7ppVsN9o6Yc/pjQBgqZXs3s0n9M6HNkRTKOwJvyqbYMXIDsr3cZUQfPcQX5n2xrn7vTPfbhnMeoulh/PdDDCW3i+UwQbtwU5sDeglGBHoUc8uC8Mi5X4ZrssqF4a82C+WxNj8ObsmNKlaEhvsgT+qpJRlMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719828537; c=relaxed/simple;
	bh=DBE7iAf6douD2ekCMunjZ6GvuaMCKlqv3UvoSJdfo64=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sEnya9qlk3Xq/CMmiAgbt/snV49qSvMl7IZ4QYtXXhB3P2yLBrfRHmZxB0mke3QGZNRgBiurbFUqUkpDe5YrnkmWEsJWyON6Gu/n0E0Sbg6C3Cppzze7bGlC1z5bEseYPb+k+f/9EmUk5rn8zhHXLaEYFI4GMZ09KKSmwmrs+G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f3c9b72aebso307290439f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 03:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719828535; x=1720433335;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2P3DiKTRhPXgRbdLfmRBRDpp1MsjZKjZ8JgmQvxrVMU=;
        b=Q8KKFF4M1zdCaVR/L/g6iiuLp52ydNoTMoV+57txJl1DeQ2v9ZU3atoTG+DvlLmJid
         0AMCV1uiuUQ2nJ4thO3fJPEt5FTKrGZIKacDqLt+Z1eOZoeizarvkfQKf9xONACIggK+
         x7tZYwOYvOxeMk3ytHV5wYnEqre5ZuT70g5qqho7Z3DqZADGqPGmdQYhVP+zBAE2ech6
         EmZnBEN2ypmPsO65vPUBe6CJVZ1BOW93q3B6Nz3fQKurbvXzrV4InQRIyaawKBWCciDa
         haDLGHp1ligC9F+9gz6fTFMR6thRvWcyCJIL/lA57qEevpzImgS5etWx30WoTxbN3A9z
         HQUQ==
X-Gm-Message-State: AOJu0Yw83o2fKZ86veMAl54ewxt/aUgGtxTbz+xybEgou1CYwKGlTaFM
	DI2DkipvGeU9dGZNxSoa1IrEueLyMIbZIAZYexU/IP1DW1X3jkMlYyb8QiidA1cJBAw2R+M7dLG
	yY1bsi/nnRwc/LETGHWW4FsohsrDEIZ02Zfgx3Nq80uYtQ7ggce9xAIM=
X-Google-Smtp-Source: AGHT+IEdfNicUut4M3jlEVimVVVhwNk8nA4O0ohYD8vGaqHdcXsx10hHJ5UtgfyNHyQUBxQBIS2EXZ4vimAv4rpf20W8IEfnGivj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d8b:b0:7f6:28ed:efe5 with SMTP id
 ca18e2360f4ac-7f62ee8869bmr45896939f.2.1719828534415; Mon, 01 Jul 2024
 03:08:54 -0700 (PDT)
Date: Mon, 01 Jul 2024 03:08:54 -0700
In-Reply-To: <0000000000004cf0fe06160c8d71@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de633e061c2cc882@google.com>
Subject: Re: [syzbot] [syzbot] [bpf?] KMSAN: uninit-value in htab_percpu_map_lookup_elem
From: syzbot <syzbot+0a079d6ef3831217a230@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [syzbot] [bpf?] KMSAN: uninit-value in htab_percpu_map_lookup_elem
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

