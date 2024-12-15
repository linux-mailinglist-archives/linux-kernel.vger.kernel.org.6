Return-Path: <linux-kernel+bounces-446248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C117E9F21AE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 02:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE7FD7A0841
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 01:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A66440C;
	Sun, 15 Dec 2024 01:25:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EA036C
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 01:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734225907; cv=none; b=uAMCbCrEt4XI4s1KBfztaU6H7Tzf6P/BHj5BYBMVVQ17Hub0CXHsLS9GIdu/fSXN7UB+9o+7lhGMldso0r6J6lUgjXbvNS2Y5zPOxZN4MzdNbUmGRqVQkykRD1js9LCaFOesjQooBa8WIlmoSpV5vVvZreTBiu3tUDyUx7q7R9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734225907; c=relaxed/simple;
	bh=r8Gdb9V8rVzIQJFA2wZ3sStVoHApA0fPZHsTP6FiKS4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kkBiZ+dUqV6L3FKzQqa1hxvOQLIG60+f3B/OTH2KfNPL4ujXOFjf91sk+3AwpuXNzZWoEmIRXA07UDH3S8xae9yPqbcDc8qqD+JCt/hK6IO6LLKcgO0D8xCthetVINXXvMtCpbhi7iLAXXaiB5oLvFr0NH7/O2bYmXFkjwjrlRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7e0d7b804so29235865ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 17:25:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734225904; x=1734830704;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hanG1C8q6kWzOHkryKQ0719XhkO+EZf3/REdqeJRe0=;
        b=lGXmYrGy1xxUioxegBKDrCSBUhIKhI3Kg4INlnWruFWW/Q3dRLoEUmX6iJBJ6Ra/qY
         pmirR3wdvkzmxsTnhH5yGpZkicOZ61YmmMkIIM3AbKBTxApPPVpBzE6OSQ+VVakbgbmw
         U712oWjNmSqqQlst96Z5vgaogyg+DeSg07+g0gzWIMBqvOlun5p3njaftiQiLoY+Yg2/
         c5CXyCwpAP9Fiddt/q6ZD3xo7eessTJ/n0N9Xqj9vqM1FS43tS6q/nrp96hZ8MqF6ke6
         w8g9BtuyBbKFWoErxzxQYBCSGrPF25AV2EBSbptIIN4BvzA6+2UzKs59pWBag6E+jjLd
         mKHQ==
X-Gm-Message-State: AOJu0YxJc8oaa9r+Bduk0m09/30s8L7RG1dnukMuTSL39S+GCxrcrD6P
	HhRYT2Vs03Qhu8tJVctGvZFX+i85rTR0nLXo4cvLhaQCq+wTD8Zejv+AGjN1c4Q8+iaeHoOhXPZ
	MZVl47zMAGNVH45ElxrOnZGgD6tPv6+dr4Yc39ag3TN+RHa8QiCk7Ymc=
X-Google-Smtp-Source: AGHT+IHY82hC9En/+804A2tSM42vEFRX+VNltVl6EHJhKgVnFARQzSbij5Fp8UH4HgBAuECH+xI4yRN7wIO0WAytj4AB9clirqlf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c569:0:b0:3a7:172f:1299 with SMTP id
 e9e14a558f8ab-3aff794e4a0mr92238705ab.12.1734225904338; Sat, 14 Dec 2024
 17:25:04 -0800 (PST)
Date: Sat, 14 Dec 2024 17:25:04 -0800
In-Reply-To: <Z14pz0DuFTwSr-Ia@qasdev.system>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675e2ff0.050a0220.37aaf.00e1.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in LZ4_decompress_safe_partial
From: syzbot <syzbot+3c88ea590c13f5f92152@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, qasdev00@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in ima_add_template_entry

bcachefs (loop0): stripes_read... done
bcachefs (loop0): snapshots_read... done
bcachefs (loop0): check_allocations... done
bcachefs (loop0): going read-write
bcachefs (loop0): done starting filesystem
=====================================================
BUG: KMSAN: uninit-value in ima_add_template_entry+0x52b/0x880 security/integrity/ima/ima_queue.c:172
 ima_add_template_entry+0x52b/0x880 security/integrity/ima/ima_queue.c:172
 ima_store_template security/integrity/ima/ima_api.c:122 [inline]
 ima_store_measurement+0x36b/0x8d0 security/integrity/ima/ima_api.c:383
 process_measurement+0x2c13/0x3f30 security/integrity/ima/ima_main.c:380
 ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3121
 do_open fs/namei.c:3830 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3987
 do_filp_open+0x268/0x600 fs/namei.c:4014
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1428
 x64_sys_call+0x36f5/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

<Zero or more stacks not recorded to save memory>

Uninit was stored to memory at:
 sha256_transform lib/crypto/sha256.c:117 [inline]
 sha256_transform_blocks+0x2dbf/0x2e90 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2ff/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x79/0xa0 crypto/shash.c:52
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1804/0x3c90 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
 process_measurement+0x294a/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3121
 do_open fs/namei.c:3830 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3987
 do_filp_open+0x268/0x600 fs/namei.c:4014
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1428
 x64_sys_call+0x36f5/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 sha256_transform lib/crypto/sha256.c:117 [inline]
 sha256_transform_blocks+0x2dbf/0x2e90 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2ff/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x79/0xa0 crypto/shash.c:52
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1804/0x3c90 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
 process_measurement+0x294a/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3121
 do_open fs/namei.c:3830 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3987
 do_filp_open+0x268/0x600 fs/namei.c:4014
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1428
 x64_sys_call+0x36f5/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 BLEND_OP lib/crypto/sha256.c:61 [inline]
 sha256_transform lib/crypto/sha256.c:91 [inline]
 sha256_transform_blocks+0xf33/0x2e90 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2ff/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x79/0xa0 crypto/shash.c:52
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1804/0x3c90 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
 process_measurement+0x294a/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3121
 do_open fs/namei.c:3830 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3987
 do_filp_open+0x268/0x600 fs/namei.c:4014
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1428
 x64_sys_call+0x36f5/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 BLEND_OP lib/crypto/sha256.c:61 [inline]
 sha256_transform lib/crypto/sha256.c:92 [inline]
 sha256_transform_blocks+0xf7d/0x2e90 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2ff/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x79/0xa0 crypto/shash.c:52
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1804/0x3c90 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
 process_measurement+0x294a/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3121
 do_open fs/namei.c:3830 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3987
 do_filp_open+0x268/0x600 fs/namei.c:4014
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1428
 x64_sys_call+0x36f5/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 BLEND_OP lib/crypto/sha256.c:61 [inline]
 sha256_transform lib/crypto/sha256.c:93 [inline]
 sha256_transform_blocks+0xfb5/0x2e90 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2ff/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x79/0xa0 crypto/shash.c:52
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1804/0x3c90 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
 process_measurement+0x294a/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3121
 do_open fs/namei.c:3830 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3987
 do_filp_open+0x268/0x600 fs/namei.c:4014
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1428
 x64_sys_call+0x36f5/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 LOAD_OP lib/crypto/sha256.c:56 [inline]
 sha256_transform lib/crypto/sha256.c:82 [inline]
 sha256_transform_blocks+0x2c35/0x2e90 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2ff/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x79/0xa0 crypto/shash.c:52
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1804/0x3c90 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
 process_measurement+0x294a/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3121
 do_open fs/namei.c:3830 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3987
 do_filp_open+0x268/0x600 fs/namei.c:4014
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1428
 x64_sys_call+0x36f5/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 memcpy_to_iter lib/iov_iter.c:65 [inline]
 iterate_kvec include/linux/iov_iter.h:86 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:306 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 _copy_to_iter+0x1248/0x2b30 lib/iov_iter.c:185
 copy_page_to_iter+0x419/0x880 lib/iov_iter.c:362
 copy_folio_to_iter include/linux/uio.h:189 [inline]
 filemap_read+0xc65/0x1560 mm/filemap.c:2697
 bch2_read_iter+0x1a90/0x2010 fs/bcachefs/fs-io-direct.c:208
 __kernel_read+0x726/0xd30 fs/read_write.c:523
 integrity_kernel_read+0x77/0x90 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1731/0x3c90 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
 process_measurement+0x294a/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3121
 do_open fs/namei.c:3830 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3987
 do_filp_open+0x268/0x600 fs/namei.c:4014
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1428
 x64_sys_call+0x36f5/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages_noprof+0x9a7/0xe00 mm/page_alloc.c:4774
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2269
 alloc_pages_noprof mm/mempolicy.c:2348 [inline]
 folio_alloc_noprof+0x1db/0x310 mm/mempolicy.c:2355
 filemap_alloc_folio_noprof+0xa6/0x440 mm/filemap.c:1009
 ra_alloc_folio mm/readahead.c:439 [inline]
 page_cache_ra_order+0x893/0x1250 mm/readahead.c:506
 page_cache_sync_ra+0xed1/0x11a0 mm/readahead.c:612
 page_cache_sync_readahead include/linux/pagemap.h:1397 [inline]
 filemap_get_pages+0x5a8/0x3860 mm/filemap.c:2546
 filemap_read+0x613/0x1560 mm/filemap.c:2646
 bch2_read_iter+0x1a90/0x2010 fs/bcachefs/fs-io-direct.c:208
 __kernel_read+0x726/0xd30 fs/read_write.c:523
 integrity_kernel_read+0x77/0x90 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1731/0x3c90 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
 process_measurement+0x294a/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3121
 do_open fs/namei.c:3830 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3987
 do_filp_open+0x268/0x600 fs/namei.c:4014
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1428
 x64_sys_call+0x36f5/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 8047 Comm: syz-executor129 Not tainted 6.13.0-rc2-syzkaller-00362-g2d8308bf5b67-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
=====================================================


Tested on:

commit:         2d8308bf Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=171c4344580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95d0bb0535bcaca0
dashboard link: https://syzkaller.appspot.com/bug?extid=3c88ea590c13f5f92152
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12b0fbe8580000


