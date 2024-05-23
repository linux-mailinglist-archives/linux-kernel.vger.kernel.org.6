Return-Path: <linux-kernel+bounces-186988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9C88CCB9E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839CB1F22EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612B84437C;
	Thu, 23 May 2024 05:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RaH6BGHB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F33017F6
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716440702; cv=none; b=JRboyVK7HqLPbTiGKVkTYCBYowVzwBnFncZ/jX9ft0dMXNkcEcPqE1+kqkW5hZL38tmB4f28JKmV/lBHaVE39CpkzJ1ztB7usGDmzx/fNTLr+1gnR9o8Ra8Zh807KDU8SLSNstZy9njsnGFLXXJJEmrtuUaEU/lWVfksMcBO8G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716440702; c=relaxed/simple;
	bh=zyo+bdDZ/N4/djYtySqHnjirGhVeeIsejhfBljnEiJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bYxQLeY5eZWg84d/y065Ffs0gMN5f+CVEwp7J9+5ty7KTguSwA0yTUUse1LhazK4OWXsDLqSK01GsnmAHs5B+TD1+XK64R1Ari+LhaNCXEpQSLDFApQAqFzJ6jGEgzCijYSVtb17lk5+nAwi3U92nZia2opd6u5XUTHRVynVzRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RaH6BGHB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716440699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A6LQSflM3pR3q8h/egcBZjfFQkSwg8BugxkzeSq0Hfw=;
	b=RaH6BGHBRuTb9csvewPDWmAp0VRgRs7sQvXRCouQqBE+EvIaio6ytWgtPmDH7Xl8HSH8rb
	ZKXf4KVr+Cuwp3jjleq9R9pfqMUnBpN5ZxgXe4FvtfmIXnuD5IFb82AMawMIdLRX/p0WRn
	Ua4l2pSMhzoxBoNAiLCZskcgLnUKAoY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-ZmTR9C-eMaayKYC7_WiKPg-1; Thu, 23 May 2024 01:04:58 -0400
X-MC-Unique: ZmTR9C-eMaayKYC7_WiKPg-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1f09617bc59so85584805ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716440696; x=1717045496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6LQSflM3pR3q8h/egcBZjfFQkSwg8BugxkzeSq0Hfw=;
        b=nfmcT+WbuWBRPuAnbX3cs8r5Rk+geSbuOi+MwUDNLDow67BNm7V8CXOhID0gBtVfM6
         yuCJOKylEKf/o78IvqGaLIp8vOb94Bu2bJcp11U7o44WpzSx9Lop63yZGbXNDf9QSxSZ
         PrlSQfpAigK01xNOAeiT9GQgZk7W2Y6Q4FJHCnwy4R/K5yxWTFttOqHR8YmZovtKUgzl
         XdbDi7oRd0mEkb9X13bA+ijYeQ+ayPc/Z39vXFtQK7H3cLVljYNkP7ArVQkahRRLt/cf
         /99o7dNRmTFCtgPhRHA2SA/y2MATHmyMFyeT1Fl05kuF2UXImejP2kPUNPzyZZ9YrtRt
         Hd9g==
X-Forwarded-Encrypted: i=1; AJvYcCW9XXmie/Ewt1njIQS7ur3jsR2MmgTr0NNNmFWDDbSx8hENtkwezJKMCERTsa2x+i0eEcr3UiJf4psF1FiC/rsGMmSyKTXO8YDjI70s
X-Gm-Message-State: AOJu0YwhZd2MOsdT2MNah/9mPBhK8Yq2xag/joE643KeVFaXiyiSJzyI
	0nALIXSKIxFV7hOlq/zNgEGZyCz3s03Zni95ntlp46In8perxl9QM8DifD5o1bKeqz04Hl7Xg01
	78qvdu8g2qzbrZw5xAqzofH0lxa4VygpykClIFjt6GMdSAwhn+RQNcc4EekVnI6GBC/BPcX7h1E
	U=
X-Received: by 2002:a17:902:eccc:b0:1f2:ffca:87ae with SMTP id d9443c01a7336-1f31c9f8b2cmr58843535ad.61.1716440695866;
        Wed, 22 May 2024 22:04:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvYOJLV1NN+/ltuXghvjIaiwVQ9rZZdHDWAALqHVUxL4bK0WWsLcXf2YSuPMSFTcU+jdUshA==
X-Received: by 2002:a17:902:eccc:b0:1f2:ffca:87ae with SMTP id d9443c01a7336-1f31c9f8b2cmr58843035ad.61.1716440694938;
        Wed, 22 May 2024 22:04:54 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f333e051ecsm10154345ad.73.2024.05.22.22.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 22:04:54 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v4 0/7] Support kdump with LUKS encryption by reusing LUKS volume keys
Date: Thu, 23 May 2024 13:04:41 +0800
Message-ID: <20240523050451.788754-1-coxu@redhat.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LUKS is the standard for Linux disk encryption. Many users choose LUKS
and in some use cases like Confidential VM it's mandated. With kdump
enabled, when the 1st kernel crashes, the system could boot into the
kdump/crash kernel and dump the memory image i.e. /proc/vmcore to a
specified target. Currently, when dumping vmcore to a LUKS
encrypted device, there are two problems,

 - Kdump kernel may not be able to decrypt the LUKS partition. For some
   machines, a system administrator may not have a chance to enter the
   password to decrypt the device in kdump initramfs after the 1st kernel
   crashes; For cloud confidential VMs, depending on the policy the
   kdump kernel may not be able to unseal the keys with TPM and the
   console virtual keyboard is untrusted.

 - LUKS2 by default use the memory-hard Argon2 key derivation function
   which is quite memory-consuming compared to the limited memory reserved
   for kdump. Take Fedora example, by default, only 256M is reserved for
   systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
   to be reserved for kdump. Note if the memory reserved for kdump can't
   be used by 1st kernel i.e. an user sees ~1300M memory missing in the
   1st kernel.

Besides users (at least for Fedora) usually expect kdump to work out of
the box i.e. no manual password input is needed. And it doesn't make
sense to derivate the keys again in kdump kernel which seems to be
redundant work.

This patch set addresses the above issues by make the LUKS volume keys
persistent for kdump kernel with the help of cryptsetup's new APIs
(--link-vk-to-keyring/--volume-key-keyring). Here is the life cycle of
this kdump copy of LUKS volume keys,

 1. After the 1st kernel loads the initramfs during boot, systemd
    use an user-input passphrase or TPM-sealed key to de-crypt the LUKS
    volume keys and then save the volume keys to specified keyring
    (using the --link-vk-to-keyring API) and the key will expire within
    specified time.

 2. A user space tool (kdump initramfs builder) writes a key description to
    /sys/kernel/crash_dm_crypt_keys to inform the 1st kernel to record the
    key while building the kdump initramfs

 3. The kexec_file_load syscall read the volume keys by recored key
    descriptions and then save them key to kdump reserved memory and wipe the
    copy.

 4. When the 1st kernel crashes and the kdump initramfs is booted, the kdump
    initramfs asks the kdump kernel to create a user key using the key stored in
    kdump reserved memory by writing to to /sys/kernel/crash_dm_crypt_keys. Then
    the LUKS encrypted devide is unlocked with libcryptsetup's
    --volume-key-keyring API.

 5. The system gets rebooted to the 1st kernel after dumping vmcore to
    the LUKS encrypted device is finished

After libcryptsetup saving the LUKS volume keys to specified keyring,
whoever takes this should be responsible for the safety of these copies
of keys. The keys will be saved in the memory area exclusively reserved
for kdump where even the 1st kernel has no direct access. And further
more, two additional protections are added,
 - save the copy randomly in kdump reserved memory as suggested by Jan
 - clear the _PAGE_PRESENT flag of the page that stores the copy as
   suggested by Pingfan

This patch set only supports x86. There will be patches to support other
architectures once this patch set gets merged.

v4
- rebase onto latest Linus tree so Baoquan can apply the patches for
  code review
- fix kernel test robot warnings

v3
 - Support CPU/memory hot-plugging [Baoquan]
 - Don't save the keys temporarily to simplify the implementation [Baoquan]
 - Support multiple LUKS encrypted volumes
 - Read logon key instead of user key to improve security [Ondrej]
 - A kernel config option CRASH_DM_CRYPT for this feature (disabled by default)
 - Fix warnings found by kernel test robot
 - Rebase the code onto 6.9.0-rc5+

v2
 - work together with libscryptsetup's --link-vk-to-keyring/--volume-key-keyring APIs [Milan and Ondrej]
 - add the case where console virtual keyboard is untrusted for confidential VM
 - use dm_crypt_key instead of LUKS volume key [Milan and Eric]
 - fix some code format issues
 - don't move "struct kexec_segment" declaration
 - Rebase the code onto latest Linus tree (6.7.0)

v1
 - "Put the luks key handling related to crash_dump out into a separate
   file kernel/crash_dump_luks.c" [Baoquan]
 - Put the generic luks handling code before the x86 specific code to
   make it easier for other arches to follow suit [Baoquan]
 - Use phys_to_virt instead of "pfn -> page -> vaddr" [Dave Hansen]
 - Drop the RFC prefix [Dave Young]
 - Rebase the code onto latest Linus tree (6.4.0-rc4)

RFC v2
 - libcryptsetup interacts with the kernel via sysfs instead of "hacking"
   dm-crypt
   - to save a kdump copy of the LUKS volume key in 1st kernel
   - to add a logon key using the copy for libcryptsetup in kdump kernel [Milan]
   - to avoid the incorrect usage of LUKS master key in dm-crypt [Milan]
 - save the kdump copy of LUKS volume key randomly [Jan]
 - mark the kdump copy inaccessible [Pingfan]
 - Miscellaneous
   - explain when operations related to the LUKS volume key happen [Jan]
   - s/master key/volume key/g
   - use crash_ instead of kexec_ as function prefix
   - fix commit subject prefixes e.g. "x86, kdump" to x86/crash

Coiby Xu (7):
  kexec_file: allow to place kexec_buf randomly
  crash_dump: make dm crypt keys persist for the kdump kernel
  crash_dump: store dm keys in kdump reserved memory
  crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging
  crash_dump: retrieve dm crypt keys in kdump kernel
  x86/crash: pass dm crypt keys to kdump kernel
  x86/crash: make the page that stores the dm crypt keys inaccessible

 arch/x86/kernel/crash.c            |  15 +-
 arch/x86/kernel/kexec-bzimage64.c  |   7 +
 arch/x86/kernel/machine_kexec_64.c |  21 ++
 include/linux/crash_core.h         |   9 +-
 include/linux/crash_dump.h         |   2 +
 include/linux/kexec.h              |   6 +
 kernel/Kconfig.kexec               |   8 +
 kernel/Makefile                    |   1 +
 kernel/crash_dump_dm_crypt.c       | 319 +++++++++++++++++++++++++++++
 kernel/kexec_file.c                |  15 ++
 kernel/ksysfs.c                    |  22 ++
 11 files changed, 423 insertions(+), 2 deletions(-)
 create mode 100644 kernel/crash_dump_dm_crypt.c


base-commit: de7e71ef8bed222dd144d8878091ecb6d5dfd208
-- 
2.45.0


