Return-Path: <linux-kernel+bounces-386320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8459B41F0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 06:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE2D6B21EB2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 05:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE615201000;
	Tue, 29 Oct 2024 05:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KA7obbYp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBB17464
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 05:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730181153; cv=none; b=h8Xc7llcNwLmeNKdNoR3CCWWLkfBNE8FxiwKZyIvsPjLKR4beF/PVGeJCeFeX8AoUbwz82Kjz9hpTx2aA00zZuxpN+HPgUn6JzIjLu8FqOyPoxwDCEyUNlct+C3vAKzQ0vlPKJib+w90gdz1T7t70o3CCa8Mxsr6OhhzG26uMb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730181153; c=relaxed/simple;
	bh=DWK0l/j5BJA1Oi+trdy4n5sIFVm6HW7HAAwWhcaHbYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M4mJoX6QQehudd4B6fiIrOSpxp7SCliPnCGm+VBJ8lrYO5jUoh15kx46E3A/m6pqVvyTVi76GbcvjeQahk21WP6kEG1EEcn65rW6FOrjbt1B1txCQuktKWEYZpVmAwAWn8kg22HdspWbZHTbDPOzMFqtxkyFmWir2HvFf6n3yjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KA7obbYp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730181150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KHFzZGQ/l/fVuX++kisaiN2+imX2gKbLVuuJBqEl0bs=;
	b=KA7obbYprjxVw0CK85DcAyNtKosm39hBK0ZlFSDmR8uCOYMG0w7H+BA3M0C4dxRKnPzGVi
	9xs8rMLpHTNoQ0Tx/hqustEffkHn08Xmur1howI34TeDXoVGkFWkYQC3ZYR9IHBPfilmPL
	aV1ccYf4BxDQ5M2g6QqinOzaOo3yIJ4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-gxARE71yMBKHrAuiiUGI3Q-1; Tue, 29 Oct 2024 01:52:28 -0400
X-MC-Unique: gxARE71yMBKHrAuiiUGI3Q-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-71a122bf521so5060742b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730181147; x=1730785947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHFzZGQ/l/fVuX++kisaiN2+imX2gKbLVuuJBqEl0bs=;
        b=qwDUa9zw0vMxrGSTTT+IDrthy2iwzRwMS8CXUvWS8zHS2stGu/zTwsJIgwYLW5eDMg
         mzl3VpkKesq6rzGeHgxbQUA8ler1QAcyhrow5JdMITDtz/n7NwlNK/vGAKpQrcBOIdBX
         vPgdZIkWYdHGU1Ubcwd1vf37CymDqIpPrQ4C0SE4nt1sjVF0fAtuNLKWLLEW1drng2LK
         IXysJo/ZrGVTT3CXR9pcyZrtew3YNR7p516JRf0zG/sTzGxpBzVK0szivfjXwgW2xVhO
         jkWu2VFjqtBwROpnHO3JPjL8VHnFe5rh+yrgmFMeFAKjE5c5lglILj8ktjup8mBhb1mV
         MwzA==
X-Forwarded-Encrypted: i=1; AJvYcCVVicFGXTM6yYBy24gCLNv9eLkrYdcsWg0pF9pNt4ZyXEF7qgcDeOlHF6yYFoBuQpNeZ6xj13NhbIPprLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBx1MFp3QOyeLzNWgj99OQqj+TggKleaJgFVouxJJn2U17Gbdc
	QIBaaZCOrylm3rJxH6BTNzwDa4OUDj/GhfZcPSWH1dujSoWMzGmCaI/Uo37iUqQOFyX6CrtWqQ+
	/X89PqHo86jTcJvWmcgDJEPeXpnJE3tiamnFnRHT4IGlEBQ+Ks0mYEpTftLPEpg==
X-Received: by 2002:a05:6a20:e30b:b0:1d9:d5e:82a6 with SMTP id adf61e73a8af0-1d9a85169f1mr14915287637.45.1730181147189;
        Mon, 28 Oct 2024 22:52:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERMRnwg6+rCeT4sm+GdXmtiDFz6kCcFzoQbpi8rS797KAdLgYtmsTcK+8odUIfl52A+GuuQQ==
X-Received: by 2002:a05:6a20:e30b:b0:1d9:d5e:82a6 with SMTP id adf61e73a8af0-1d9a85169f1mr14915268637.45.1730181146786;
        Mon, 28 Oct 2024 22:52:26 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc066d6bsm58682855ad.278.2024.10.28.22.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 22:52:26 -0700 (PDT)
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
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH v6 0/7] Support kdump with LUKS encryption by reusing LUKS volume keys
Date: Tue, 29 Oct 2024 13:52:13 +0800
Message-ID: <20241029055223.210039-1-coxu@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

LUKS is the standard for Linux disk encryption, widely adopted by users,
and in some cases, such as Confidential VMs, it is a requirement. With 
kdump enabled, when the first kernel crashes, the system can boot into
the kdump/crash kernel to dump the memory image (i.e., /proc/vmcore) 
to a specified target. However, there are two challenges when dumping
vmcore to a LUKS-encrypted device:

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
the box i.e. no manual password input or custom crashkernel value is
needed. And it doesn't make sense to derivate the keys again in kdump
kernel which seems to be redundant work.

This patch set addresses the above issues by making the LUKS volume keys
persistent for kdump kernel with the help of cryptsetup's new APIs
(--link-vk-to-keyring/--volume-key-keyring). Here is the life cycle of
the kdump copies of LUKS volume keys,

 1. After the 1st kernel loads the initramfs during boot, systemd
    use an user-input passphrase to de-crypt the LUKS volume keys
    or TPM-sealed key and then save the volume keys to specified keyring
    (using the --link-vk-to-keyring API) and the key will expire within
    specified time.

 2. A user space tool (kdump initramfs loader like kdump-utils) create
    key items inside /sys/kernel/config/crash_dm_crypt_keys to inform
    the 1st kernel which keys are needed.

 3. When the kdump initramfs is loaded by the kexec_file_load
    syscall, the 1st kernel will iterate created key items, save the
    keys to kdump reserved memory.

 4. When the 1st kernel crashes and the kdump initramfs is booted, the
    kdump initramfs asks the kdump kernel to create a user key using the
    key stored in kdump reserved memory by writing yes to
    /sys/kernel/crash_dm_crypt_keys/restore. Then the LUKS encrypted
    device is unlocked with libcryptsetup's --volume-key-keyring API.

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

v6
 - Baoquan
   - support AMD SEV
   - drop unnecessary keys_header_size
   - improve commit message of [PATCH 4/7]
 
 - Greg
   - switch to configfs
   - move ifdef from .c to .h files
   - use tab instead of space for appended code comment
 
 - Process key description in a more flexible way to address problems
   found by Ondrej
 - improve cover letter
 - fix an compilation error as found by kernel test robot 

v5
 - Baoquan
   - limit the feature of placing kexec_buf randomly to kdump (CONFIG_CRASH_DUMP)
   - add documentation for added sysfs API 
   - allow to re-send init command to support the case of user switching to
     a different LUKS-encrypted target
   - make CONFIG_CRASH_DM_CRYPT depends on CONFIG_DM_CRYPT
   - check if the number of keys exceed KEY_NUM_MAX
   - rename (struct keys_header).key_count as (struct keys_header).total_keys
     to improve code readability
   - improve commit message
   - fix the failure of calling crash_exclude_mem_range (there is a split
     of mem_range)
   - use ret instead of r as return code
 
 - Greg
   - add documentation for added sysfs API 
   - avoid spamming kernel logs 
   - fix a buffer overflow issue
   - keep the state enums synced up with the string values
   - use sysfs_emit other than sprintf
   - explain KEY_NUM_MAX and KEY_SIZE_MAX
   - s/EXPORT_SYMBOL_GPL/EXPORT_SYMBOL/g
   - improve code readability
 
 - Rebase onto latest Linus tree


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
  crash_dump: store dm crypt keys in kdump reserved memory
  crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging
  crash_dump: retrieve dm crypt keys in kdump kernel
  x86/crash: pass dm crypt keys to kdump kernel
  x86/crash: make the page that stores the dm crypt keys inaccessible

 arch/x86/kernel/crash.c            |  20 +-
 arch/x86/kernel/kexec-bzimage64.c  |   7 +
 arch/x86/kernel/machine_kexec_64.c |  22 ++
 include/linux/crash_core.h         |   7 +-
 include/linux/crash_dump.h         |   2 +
 include/linux/kexec.h              |  32 ++
 kernel/Kconfig.kexec               |   9 +
 kernel/Makefile                    |   1 +
 kernel/crash_dump_dm_crypt.c       | 459 +++++++++++++++++++++++++++++
 kernel/kexec_file.c                |   3 +
 10 files changed, 559 insertions(+), 3 deletions(-)
 create mode 100644 kernel/crash_dump_dm_crypt.c


base-commit: e42b1a9a2557aa94fee47f078633677198386a52
-- 
2.47.0


