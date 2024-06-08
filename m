Return-Path: <linux-kernel+bounces-206870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5478D900F18
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 03:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADBCCB23DF4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 01:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E059A4C66;
	Sat,  8 Jun 2024 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DH+gZ5jw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7DC3233
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717810241; cv=none; b=KWXDqqlrsY87A4Ei7wXwyp6oDnDPhMgAAJtG1zdMQjZQ99joYJkXjjJVAwGZrEmC1grZDAFTvSv8q6fTaQsaOpNV8aNbmRd0EoYWCGs57Fq56R+At3x/DKZXUYwJllbrkrkfTUab3FgTEN933P4Ue6soehFdJOoApDis38eo4tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717810241; c=relaxed/simple;
	bh=hjCP01qKnJF8j+l2wZ4Q6TKDW+o+AnIizpbon3uG6H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKSk/GN1ksWb9yWWCvM+SLTVrRBLU/Q1buyyMoXPzfDRKNcBsPE1UjO/D3VpAFcZvl5Yfjz42hj2lQb4+HnvE37vgEPzPoysX1pW1FMyNbMaTgF7z/skGrmQwRt0MkhGvdPohqbEuTgWpTtTYzEgqEQdGYSfhuzO97yA1TteptM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DH+gZ5jw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717810238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Il+x7mPxkybxlGmp96omLuhvnPqHbzJs6J/7vrJ884=;
	b=DH+gZ5jwGLwVk1tIhvwUu9K5w/gl8Z9AQuETd6t/0TltEgMoizB0E55+1XWiMllryk/IP5
	woyBnmsNsbcvcxw+tsCAsEZC+T2oYDD4JsOY+JIB0OqbjpAUwfKtL8p83rVEPezhgypaKX
	JivWapn7aueWIq+vVzkpQuLBhYiW+eY=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-gL236XnyNNGiPgJJhwYnXQ-1; Fri, 07 Jun 2024 21:30:37 -0400
X-MC-Unique: gL236XnyNNGiPgJJhwYnXQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-704231a9953so358077b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 18:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717810237; x=1718415037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Il+x7mPxkybxlGmp96omLuhvnPqHbzJs6J/7vrJ884=;
        b=V/rAZo2I3WvoNLcMCojYGvFGDreesuaqdZE3BtpA0WWy6hw4dhrpVcvBPINdiruXLD
         +suS5KMyQo7MDGrvrAZBb0MFbc7/Ts6147mexOx3LDnE5d/nmRfjg6iEI1d/7HsZ5eKL
         lB4cFUr4BoMtQGSXsGEap3qyVL1/adDr9fDxYUTrzvK5V6o81QhS+Lq5ajfGcDUEy1jB
         AJFtgxzqNA5NaTEb5Qs2loMnOIR23k/3AfGFJ+ZDdagqnx3scnQZ9OAvwJGCBOzdCCJx
         Iw/h/SS5dqXIhw4Om2T0GSga6hVBhOxpyqWA84Z1nHDPFFl+1idlQMFR0+XqKXZXqdk8
         uekQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG1uAO68qPz4lI04Y6BANbd3RtjUTPNn9ZD6NcPUaSC/owk7DCE9g7St1UbTs/OI28zstuhdmpRMQLpeBX4WxULF0nPgYli+AVysOj
X-Gm-Message-State: AOJu0YzRHeqTsm/xpbIWewDaNjw45XGcbCf8O0qwI4UYCG15dHF/Ww5I
	ckKqjM08idgeAAdsnlbe+5jC737W/odbLFjK4ExhcEEXZo1jFQTFUFGUoOQGPjV81QICbJEOUfj
	Brf9b1NKaiHZ93qHLul0N/IM49Ud4LyTpjzF0wL+QVGGI389KzeylqHNWujmcNA==
X-Received: by 2002:a05:6a00:2e9c:b0:6ea:bf1c:9dfd with SMTP id d2e1a72fcca58-7040c737a8bmr4548035b3a.27.1717810235835;
        Fri, 07 Jun 2024 18:30:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf18qDxBKvh63AOJgteBoZ+l1rs1vBq/RxFyokdqBxSXDxTeJ/VWO2OgmN/pBacP7VyFcMzA==
X-Received: by 2002:a05:6a00:2e9c:b0:6ea:bf1c:9dfd with SMTP id d2e1a72fcca58-7040c737a8bmr4548005b3a.27.1717810235042;
        Fri, 07 Jun 2024 18:30:35 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70423a7f217sm251223b3a.206.2024.06.07.18.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 18:30:34 -0700 (PDT)
Date: Sat, 8 Jun 2024 09:26:43 +0800
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>, Milan Broz <gmazyland@gmail.com>, 
	Thomas Staudt <tstaudt@de.ibm.com>, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Jan Pazdziora <jpazdziora@redhat.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <26jkoqavu54xo4ctbpxfibhdlbc5kezu2kkyl5fbb7r6oizvo4@cmq5yaeszfqq>
References: <20240607122622.167228-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240607122622.167228-1-coxu@redhat.com>

The subject prefix should be "[PATCH v5 0/7]". I'm sorry if it causes
any confusion.

On Fri, Jun 07, 2024 at 08:26:10PM +0800, Coiby Xu wrote:
>LUKS is the standard for Linux disk encryption. Many users choose LUKS
>and in some use cases like Confidential VM it's mandated. With kdump
>enabled, when the 1st kernel crashes, the system could boot into the
>kdump/crash kernel and dump the memory image i.e. /proc/vmcore to a
>specified target. Currently, when dumping vmcore to a LUKS
>encrypted device, there are two problems,
>
> - Kdump kernel may not be able to decrypt the LUKS partition. For some
>   machines, a system administrator may not have a chance to enter the
>   password to decrypt the device in kdump initramfs after the 1st kernel
>   crashes; For cloud confidential VMs, depending on the policy the
>   kdump kernel may not be able to unseal the keys with TPM and the
>   console virtual keyboard is untrusted.
>
> - LUKS2 by default use the memory-hard Argon2 key derivation function
>   which is quite memory-consuming compared to the limited memory reserved
>   for kdump. Take Fedora example, by default, only 256M is reserved for
>   systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
>   to be reserved for kdump. Note if the memory reserved for kdump can't
>   be used by 1st kernel i.e. an user sees ~1300M memory missing in the
>   1st kernel.
>
>Besides users (at least for Fedora) usually expect kdump to work out of
>the box i.e. no manual password input is needed. And it doesn't make
>sense to derivate the keys again in kdump kernel which seems to be
>redundant work.
>
>This patch set addresses the above issues by make the LUKS volume keys
>persistent for kdump kernel with the help of cryptsetup's new APIs
>(--link-vk-to-keyring/--volume-key-keyring). Here is the life cycle of
>this kdump copy of LUKS volume keys,
>
> 1. After the 1st kernel loads the initramfs during boot, systemd
>    use an user-input passphrase or TPM-sealed key to de-crypt the LUKS
>    volume keys and then save the volume keys to specified keyring
>    (using the --link-vk-to-keyring API) and the key will expire within
>    specified time.
>
> 2. A user space tool (kdump initramfs builder) writes a key description to
>    /sys/kernel/crash_dm_crypt_keys to inform the 1st kernel to record the
>    key while building the kdump initramfs
>
> 3. The kexec_file_load syscall read the volume keys by recorded key
>    descriptions and then save them key to kdump reserved memory and wipe the
>    copy.
>
> 4. When the 1st kernel crashes and the kdump initramfs is booted, the kdump
>    initramfs asks the kdump kernel to create a user key using the key stored in
>    kdump reserved memory by writing to to /sys/kernel/crash_dm_crypt_keys. Then
>    the LUKS encrypted devide is unlocked with libcryptsetup's
>    --volume-key-keyring API.
>
> 5. The system gets rebooted to the 1st kernel after dumping vmcore to
>    the LUKS encrypted device is finished
>
>After libcryptsetup saving the LUKS volume keys to specified keyring,
>whoever takes this should be responsible for the safety of these copies
>of keys. The keys will be saved in the memory area exclusively reserved
>for kdump where even the 1st kernel has no direct access. And further
>more, two additional protections are added,
> - save the copy randomly in kdump reserved memory as suggested by Jan
> - clear the _PAGE_PRESENT flag of the page that stores the copy as
>   suggested by Pingfan
>
>This patch set only supports x86. There will be patches to support other
>architectures once this patch set gets merged.
>
>v5
> - Baoquan
>   - limit the feature of placing kexec_buf randomly to kdump (CONFIG_CRASH_DUMP)
>   - add documentation for added sysfs API
>   - allow to re-send init command to support the case of user switching to
>     a different LUKS-encrypted target
>   - make CONFIG_CRASH_DM_CRYPT depends on CONFIG_DM_CRYPT
>   - check if the number of keys exceed KEY_NUM_MAX
>   - rename (struct keys_header).key_count as (struct
>     keys_header).total_keys to improve code readiblity
>   - improve commit message
>   - fix the failure of calling crash_exclude_mem_range (there is a split
>     of mem_range)
>   - use ret instead of r as return code
>
> - Greg
>   - add documentation for added sysfs API
>   - avoid spamming kernel logs
>   - fix a buffer overflow issue
>   - keep the state enums synced up with the string values
>   - use sysfs_emit other than sprintf
>   - explain KEY_NUM_MAX and KEY_SIZE_MAX
>   - s/EXPORT_SYMBOL_GPL/EXPORT_SYMBOL/g
>   - improve code readability
>
> - Rebase onto latest Linus tree
>
>
>v4
>- rebase onto latest Linus tree so Baoquan can apply the patches for
>  code review
>- fix kernel test robot warnings
>
>v3
> - Support CPU/memory hot-plugging [Baoquan]
> - Don't save the keys temporarily to simplify the implementation [Baoquan]
> - Support multiple LUKS encrypted volumes
> - Read logon key instead of user key to improve security [Ondrej]
> - A kernel config option CRASH_DM_CRYPT for this feature (disabled by default)
> - Fix warnings found by kernel test robot
> - Rebase the code onto 6.9.0-rc5+
>
>v2
> - work together with libscryptsetup's --link-vk-to-keyring/--volume-key-keyring APIs [Milan and Ondrej]
> - add the case where console virtual keyboard is untrusted for confidential VM
> - use dm_crypt_key instead of LUKS volume key [Milan and Eric]
> - fix some code format issues
> - don't move "struct kexec_segment" declaration
> - Rebase the code onto latest Linus tree (6.7.0)
>
>v1
> - "Put the luks key handling related to crash_dump out into a separate
>   file kernel/crash_dump_luks.c" [Baoquan]
> - Put the generic luks handling code before the x86 specific code to
>   make it easier for other arches to follow suit [Baoquan]
> - Use phys_to_virt instead of "pfn -> page -> vaddr" [Dave Hansen]
> - Drop the RFC prefix [Dave Young]
> - Rebase the code onto latest Linus tree (6.4.0-rc4)
>
>RFC v2
> - libcryptsetup interacts with the kernel via sysfs instead of "hacking"
>   dm-crypt
>   - to save a kdump copy of the LUKS volume key in 1st kernel
>   - to add a logon key using the copy for libcryptsetup in kdump kernel [Milan]
>   - to avoid the incorrect usage of LUKS master key in dm-crypt [Milan]
> - save the kdump copy of LUKS volume key randomly [Jan]
> - mark the kdump copy inaccessible [Pingfan]
> - Miscellaneous
>   - explain when operations related to the LUKS volume key happen [Jan]
>   - s/master key/volume key/g
>   - use crash_ instead of kexec_ as function prefix
>   - fix commit subject prefixes e.g. "x86, kdump" to x86/crash
>
>Coiby Xu (7):
>  kexec_file: allow to place kexec_buf randomly
>  crash_dump: make dm crypt keys persist for the kdump kernel
>  crash_dump: store dm crypt keys in kdump reserved memory
>  crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging
>  crash_dump: retrieve dm crypt keys in kdump kernel
>  x86/crash: pass dm crypt keys to kdump kernel
>  x86/crash: make the page that stores the dm crypt keys inaccessible
>
> Documentation/ABI/testing/crash_dm_crypt_keys |  35 ++
> arch/x86/kernel/crash.c                       |  20 +-
> arch/x86/kernel/kexec-bzimage64.c             |   7 +
> arch/x86/kernel/machine_kexec_64.c            |  22 ++
> include/linux/crash_core.h                    |   9 +-
> include/linux/crash_dump.h                    |   2 +
> include/linux/kexec.h                         |   8 +
> kernel/Kconfig.kexec                          |   9 +
> kernel/Makefile                               |   1 +
> kernel/crash_dump_dm_crypt.c                  | 338 ++++++++++++++++++
> kernel/kexec_file.c                           |  21 ++
> kernel/ksysfs.c                               |  24 ++
> 12 files changed, 493 insertions(+), 3 deletions(-)
> create mode 100644 Documentation/ABI/testing/crash_dm_crypt_keys
> create mode 100644 kernel/crash_dump_dm_crypt.c
>
>
>base-commit: 8a92980606e3585d72d510a03b59906e96755b8a
>-- 
>2.45.1
>

-- 
Best regards,
Coiby


