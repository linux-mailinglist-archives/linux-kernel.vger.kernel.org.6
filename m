Return-Path: <linux-kernel+bounces-347097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2AF98CDBD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87BB1C2120E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA13D1940B0;
	Wed,  2 Oct 2024 07:26:27 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DEB193434
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727853987; cv=none; b=LoFBi8xSCDUUdW33Gc94a69/AkkV8dpmZlyzmK6XEjiW50BIPi1E2Y/iCu0w9WuPaXVKmuF2uC4wP/2WOLdx0TB8mIRdjtTb4plQVVEE5uy6LXY0EfG5raOh3ogcEnPOrC+QWt04ZBLtxTGUTcX6P9Bpe+GReafmz5AKqyfGfWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727853987; c=relaxed/simple;
	bh=IrHwWxktE1hMLlK28Z0VR+xQqHalinF3owSiDPlj+rA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YD8X55c6zjHNTK7dP7a5VFZXUnGwWQPEOiMuy7Hai9TXkPmzQ1rywx9cXXd/bSpw0fjc3lVlfQapCBFQNTs8qY6ASEztKI6LKE01zntA3t0CPW2Fy3aqvD67wcluRMc+t/g09kHOF7EwdHTZVzeglwRc0pdOxh0X+FfY5h5gsyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3466d220dso71261925ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 00:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727853984; x=1728458784;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mmfOnKA4yWsX4usxPdfZKtdaVhLYNgvlJYK5xZzYXMs=;
        b=Gkm/0Ti4AF4OPy8+aHCJ7y7+dp0TO/MQr5GglpUvut47pQScpq8LStjs4/CCZjrrgl
         e41bybLnwUfq26f4zZUvQiOkDLn9ekKMiXGFuaChDcCW3qnSX8sVsvECvJY8XlUX2etB
         pemfKGyzSD7PuuyJGTUSUmgpChAq+811gZgP/BSRDgLy8JPoOvBlGIHUqlSxdTFYIwy/
         6zNa7pQpU42P9VC9cv2EL3AsYlg4Uxi3mBx8WnTMKg+PzKtASE6GkRLfhDnLDxS6mMHl
         pjr6h6sZHLlBOTVYSZa709Kxl7lcRZhloVb6WVdRS0hv51zWyGX+jpnjYuNC9oP1Uy7J
         EZUA==
X-Forwarded-Encrypted: i=1; AJvYcCU7CiceR3QoziFlNL0I7LAXFH6elTEkU7C5JVH/8Atz4GRJzpCm+EuzW+TQ7wOm1bI3NrdP2lEJntutuq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1R8T2K05Gcd00WNFK3Z2J6FFBhqDFiCTI14XeX7YoEWj/AAub
	/o+a1Zxjw7HS6kI9serVEuo2dUwhWKNXUhXtj5/kWhqzTYsoqH9iE7/eEJP9B39a5CQtdIDGpq0
	jaKxUtvv8BV8+nqPgYWHMC7j0MLCP9JG3C2n+mM9j9l2DxqDnB1UpBdI=
X-Google-Smtp-Source: AGHT+IFKF9RvYr10okN/1f+tU+zYgN64nsHBe4pEZycM5f4Vpom45/XfDI2tQLsqQSkgsJLar+Msoj0mdCnb2inrY7dwiFmbnhVC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cd:b0:3a2:f7b1:2f89 with SMTP id
 e9e14a558f8ab-3a365944725mr18725245ab.18.1727853984155; Wed, 02 Oct 2024
 00:26:24 -0700 (PDT)
Date: Wed, 02 Oct 2024 00:26:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fcf5a0.050a0220.f28ec.04f9.GAE@google.com>
Subject: [syzbot] [integrity?] [lsm?] KMSAN: uninit-value in
 ima_add_template_entry (2)
From: syzbot <syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com>
To: dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ad46e8f95e93 Merge tag 'pm-6.12-rc1-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1177d507980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85d8f50d88ddf2a
dashboard link: https://syzkaller.appspot.com/bug?extid=91ae49e1c1a2634d20c0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=106026a9980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/265feec46ffa/disk-ad46e8f9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d0f41ea693d3/vmlinux-ad46e8f9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/45082d33d192/bzImage-ad46e8f9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5b5b4e4b4ff9/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ima_add_template_entry+0x52b/0x880 security/integrity/ima/ima_queue.c:172
 ima_add_template_entry+0x52b/0x880 security/integrity/ima/ima_queue.c:172
 ima_store_template security/integrity/ima/ima_api.c:122 [inline]
 ima_store_measurement+0x36b/0x8d0 security/integrity/ima/ima_api.c:383
 process_measurement+0x2c11/0x3f30 security/integrity/ima/ima_main.c:380
 ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3127
 do_open fs/namei.c:3776 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3933
 do_filp_open+0x20e/0x590 fs/namei.c:3960
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_open fs/open.c:1438 [inline]
 __se_sys_open fs/open.c:1434 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1434
 x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:3
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
 process_measurement+0x2948/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3127
 do_open fs/namei.c:3776 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3933
 do_filp_open+0x20e/0x590 fs/namei.c:3960
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_open fs/open.c:1438 [inline]
 __se_sys_open fs/open.c:1434 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1434
 x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:3
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
 process_measurement+0x2948/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3127
 do_open fs/namei.c:3776 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3933
 do_filp_open+0x20e/0x590 fs/namei.c:3960
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_open fs/open.c:1438 [inline]
 __se_sys_open fs/open.c:1434 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1434
 x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:3
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
 process_measurement+0x2948/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3127
 do_open fs/namei.c:3776 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3933
 do_filp_open+0x20e/0x590 fs/namei.c:3960
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_open fs/open.c:1438 [inline]
 __se_sys_open fs/open.c:1434 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1434
 x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:3
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
 process_measurement+0x2948/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3127
 do_open fs/namei.c:3776 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3933
 do_filp_open+0x20e/0x590 fs/namei.c:3960
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_open fs/open.c:1438 [inline]
 __se_sys_open fs/open.c:1434 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1434
 x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:3
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
 process_measurement+0x2948/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3127
 do_open fs/namei.c:3776 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3933
 do_filp_open+0x20e/0x590 fs/namei.c:3960
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_open fs/open.c:1438 [inline]
 __se_sys_open fs/open.c:1434 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1434
 x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:3
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
 process_measurement+0x2948/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3127
 do_open fs/namei.c:3776 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3933
 do_filp_open+0x20e/0x590 fs/namei.c:3960
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_open fs/open.c:1438 [inline]
 __se_sys_open fs/open.c:1434 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1434
 x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:3
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 memcpy_to_iter lib/iov_iter.c:65 [inline]
 iterate_kvec include/linux/iov_iter.h:86 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:306 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 _copy_to_iter+0x124a/0x2b30 lib/iov_iter.c:185
 copy_page_to_iter+0x419/0x880 lib/iov_iter.c:362
 copy_folio_to_iter include/linux/uio.h:189 [inline]
 filemap_read+0xc13/0x1500 mm/filemap.c:2696
 generic_file_read_iter+0x136/0xad0 mm/filemap.c:2833
 __kernel_read+0x726/0xd30 fs/read_write.c:527
 integrity_kernel_read+0x77/0x90 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1731/0x3c90 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
 process_measurement+0x2948/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3127
 do_open fs/namei.c:3776 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3933
 do_filp_open+0x20e/0x590 fs/namei.c:3960
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_open fs/open.c:1438 [inline]
 __se_sys_open fs/open.c:1434 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1434
 x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:3
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4756
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x1db/0x310 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xa6/0x440 mm/filemap.c:1010
 __filemap_get_folio+0xac4/0x1550 mm/filemap.c:1952
 block_write_begin+0x6e/0x2b0 fs/buffer.c:2226
 exfat_write_begin+0xfb/0x400 fs/exfat/inode.c:434
 exfat_extend_valid_size fs/exfat/file.c:553 [inline]
 exfat_file_write_iter+0x474/0xfb0 fs/exfat/file.c:588
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xb28/0x1540 fs/read_write.c:683
 ksys_write+0x24f/0x4c0 fs/read_write.c:736
 __do_sys_write fs/read_write.c:748 [inline]
 __se_sys_write fs/read_write.c:745 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:745
 x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 7910 Comm: syz.2.975 Not tainted 6.11.0-syzkaller-11728-gad46e8f95e93 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

