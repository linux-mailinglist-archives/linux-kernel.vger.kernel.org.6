Return-Path: <linux-kernel+bounces-249874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B978692F0F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC22B236AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F64155741;
	Thu, 11 Jul 2024 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtewKqpo"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94316D324;
	Thu, 11 Jul 2024 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732647; cv=none; b=i7jAwD0kuRDd5IxWZbIHjjisf+WEzFZFoULTpI2zQqn9LBKB9BAh8a0ErNOcxgAFSQL+mVSNc21MOKAtoJF6/lXY+0AyusWs9MODW5jKzhxMGrSvc0mYEJzHEC/nbivQtYBchXm+8Rzc64xOEYKmJgm/nSGk1Lm6Di4Jz1WYz/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732647; c=relaxed/simple;
	bh=RpjRG8g1/F7J1W4iZNeHwl9ZfrXytIdknIVJmm5AHfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzT1cmczf/oVTtRB73o2ukDgyoBqQA9GacI9xqsP7bGzaZIr6PXDfs1df6itKopXrsvQzwpQ/xgC9txlM1hPaZTht9B7UhMDNh83s16j8fLVbFSi34/oASkV5urhqRgwb5Bm6dwxADHIc4He+YOK6SeBOiXWQeIrUgcsxtPtHcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtewKqpo; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58ba3e38027so1534768a12.1;
        Thu, 11 Jul 2024 14:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720732643; x=1721337443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZcaI5+6z82r9vq6pp4cVgvJLD8/+zJh4wg+noG/zTM=;
        b=BtewKqpoQWHUPL99YOuzLe+fcBTVSfWtajLloqCZxuRan2gf4A/ypmw81Ki90H4edQ
         XgmiwV8eaAhvwcbM5R1anfloamqfeYsnXZjAzMPr0Tn3K2QYnAVkyunV6y3y0W/19/Pb
         m+/Xnwei05wMyzJRXnT+YuiCz3Rr5w1bcN9coAX1q2xkjmj+lbDCvLWrGQ36ZZOr6gws
         iC0rBYc0CpD53qN1bmNiWOB0El3zN/PXBHbPPCYV+4ZbOMbtqUC0JUOOpGQsxebKtRO4
         5HBRf8vvOPJutTorTA/K0XRlw97aIT8FNfFCGC+i0azr5xwxG7aEEmcK+EWsoxwejLUt
         tHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720732643; x=1721337443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZcaI5+6z82r9vq6pp4cVgvJLD8/+zJh4wg+noG/zTM=;
        b=d5pHbVuGBQwWdfHKkI1aqyU1SdroHTPjcVDrUqpkN1C4XQB3Jc4p1FxQbKNNoh9nos
         1ywGKmPnXu6LsfVkemh69v/Wta2F1d8P1jIwYTGMePY7MJiYC+nz+Z/K4tIdw2v51Mgx
         jo125we4GeHiuNqIOgozPJaKsMkwBt2Jqrqb10ItPC+AJXw8UPUQI9vrPmnEMOyiubmQ
         kraKq/uU9JewyYVzYhMtF4raOe251rRNsNKduUDwPcqQ2Cc0qwpUSwbkUVb3lWjNToAM
         TDBQtFQCBtrWAT0D5pUgk++iBr98GpjUTR5OLOsa4BNABUam00LKzEP4vIfjNGnFv/mJ
         9m5g==
X-Forwarded-Encrypted: i=1; AJvYcCXtl6NPinKE18zsVJnycf0iLQW5+VLGBH7heH0QYPlGD30xLovj6lm9OB9w9zGVTNBWgC6GQ/mAcWXS5VFA1aG2xyhafDryfYjhuR8P/WluaxcpRP6fM8ixItzLPCRYqfQz3agylFc6ygs=
X-Gm-Message-State: AOJu0YwdgWCkdCZGkEoR9/0Bvlm0xxje5m9/KEcRCh7a6OlZCQqHqV7r
	UkfuxEnVFF0CJeN3o9+1AcNc0VxV48K7ZszfXPYEJdb8roku6p9S
X-Google-Smtp-Source: AGHT+IETl+vIg7IhxTUhL4uj8vO5jfAtMX+OC788CD/RERkRMNUie3Oga3XfiHTBxFlvuuJR2sL2zQ==
X-Received: by 2002:a05:6402:2354:b0:58d:d1d5:da65 with SMTP id 4fb4d7f45d1cf-594baf91407mr8936223a12.11.1720732643086;
        Thu, 11 Jul 2024 14:17:23 -0700 (PDT)
Received: from [192.168.178.20] (dh207-43-148.xnet.hr. [88.207.43.148])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bda30b18sm3829176a12.95.2024.07.11.14.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 14:17:22 -0700 (PDT)
Message-ID: <0ece317b-74ae-4f15-bc28-d85972ef18b7@gmail.com>
Date: Thu, 11 Jul 2024 23:17:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PROBLEM linux-next] drivers/hwmon/aht10.c:224: warning: Function
 parameter or struct member 'data' not described in 'aht10_interval_write'
To: Guenter Roeck <linux@roeck-us.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
 "Johannes Cornelis Draaijer (datdenkikniet)" <jcdra1@gmail.com>
References: <851b86f1-5757-4f4a-960a-2d4ecb840734@gmail.com>
 <07955cfb-aae7-4a97-8222-b9c235e7c8c2@roeck-us.net>
Content-Language: en-US
From: Mirsad Todorovac <mtodorovac69@gmail.com>
In-Reply-To: <07955cfb-aae7-4a97-8222-b9c235e7c8c2@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/11/24 19:11, Guenter Roeck wrote:
> On 7/11/24 09:57, Mirsad Todorovac wrote:
>> Hi all,
>>
>> On the linux-next vanilla tree next-20240709, there is a lot of complaining about
>> code like these, which is not an error, but it seems like documentation lags behind
>> the [dynamic] source development.
>>
>> If you  are interested in reporting these to the respective maintainers and developers,
>> give me a ping.
>>
>> drivers/hwmon/aht10.c:224: warning: Function parameter or struct member 'data' not described in 'aht10_interval_write'
>> drivers/hwmon/aht10.c:224: warning: Function parameter or struct member 'val' not described in 'aht10_interval_write'
>> drivers/hwmon/aht10.c:235: warning: Function parameter or struct member 'data' not described in 'aht10_interval_read'
>> drivers/hwmon/aht10.c:235: warning: Function parameter or struct member 'val' not described in 'aht10_interval_read'
>> drivers/hwmon/aht10.c:244: warning: Function parameter or struct member 'data' not described in 'aht10_temperature1_read'
>> drivers/hwmon/aht10.c:244: warning: Function parameter or struct member 'val' not described in 'aht10_temperature1_read'
>> drivers/hwmon/aht10.c:259: warning: Function parameter or struct member 'data' not described in 'aht10_humidity1_read'
>> drivers/hwmon/aht10.c:259: warning: Function parameter or struct member 'val' not described in 'aht10_humidity1_read'
>>
> 
> I'll be happy to accept patches, but plain reports like this are just noise.
> 
> Guenter
> 

Hi, Mr. Guenter,

Thank you kindly for your reply.

I agree with you that it adds a lot traffic to the channel with little "signal" when compared to the "noise".

However, there is about a 100 such warnings from 26 modules, and I do not feel competent and equipped to
analyse all of these:

      1 arch/x86/entry/common.c
      1 arch/x86/kernel/apic/apic.c
      4 arch/x86/kernel/cpu/mtrr/amd.c
      1 arch/x86/kernel/cpu/mtrr/centaur.c
      1 arch/x86/mm/pat/memtype.c
     13 arch/x86/mm/pgtable.c
      1 block/blk-merge.c
      1 drivers/firmware/efi/libstub/efi-stub-helper.c
      8 drivers/hwmon/aht10.c
      2 drivers/hwtracing/intel_th/core.c
     10 drivers/hwtracing/intel_th/msu.c
     17 drivers/memstick/core/memstick.c
      2 drivers/pinctrl/pinctrl-aw9523.c
      2 drivers/tty/n_hdlc.c
      1 fs/bcachefs/io_write.c
      1 fs/gfs2/glock.c
      2 fs/gfs2/super.c
      6 fs/nilfs2/btnode.c
      7 fs/nilfs2/ioctl.c
      3 fs/nilfs2/super.c
      4 fs/ufs/inode.c
      2 kernel/reboot.c
      2 kernel/time/tick-broadcast.c
      5 lib/842/842_compress.c
      4 lib/842/842_decompress.c
      1 mm/page_counter.c

In particular, those are expanded as:

arch/x86/mm/pat/memtype.c:708: warning: Function parameter or struct member 'pfn' not described in 'pat_pfn_immune_to_uc_mtrr'
arch/x86/mm/pgtable.c:652: warning: Function parameter or struct member 'reserve' not described in 'reserve_top_address'
arch/x86/mm/pgtable.c:701: warning: Function parameter or struct member 'p4d' not described in 'p4d_set_huge'
arch/x86/mm/pgtable.c:701: warning: Function parameter or struct member 'addr' not described in 'p4d_set_huge'
arch/x86/mm/pgtable.c:701: warning: Function parameter or struct member 'prot' not described in 'p4d_set_huge'
arch/x86/mm/pgtable.c:711: warning: Function parameter or struct member 'p4d' not described in 'p4d_clear_huge'
arch/x86/mm/pgtable.c:728: warning: Function parameter or struct member 'pud' not described in 'pud_set_huge'
arch/x86/mm/pgtable.c:728: warning: Function parameter or struct member 'addr' not described in 'pud_set_huge'
arch/x86/mm/pgtable.c:728: warning: Function parameter or struct member 'prot' not described in 'pud_set_huge'
arch/x86/mm/pgtable.c:754: warning: Function parameter or struct member 'pmd' not described in 'pmd_set_huge'
arch/x86/mm/pgtable.c:754: warning: Function parameter or struct member 'addr' not described in 'pmd_set_huge'
arch/x86/mm/pgtable.c:754: warning: Function parameter or struct member 'prot' not described in 'pmd_set_huge'
arch/x86/mm/pgtable.c:781: warning: Function parameter or struct member 'pud' not described in 'pud_clear_huge'
arch/x86/mm/pgtable.c:796: warning: Function parameter or struct member 'pmd' not described in 'pmd_clear_huge'
arch/x86/entry/common.c:211: warning: Function parameter or struct member 'regs' not described in 'do_int80_emulation'
block/blk-merge.c:220: warning: Function parameter or struct member 'len' not described in 'get_max_segment_size'
lib/842/842_compress.c:479: warning: Function parameter or struct member 'in' not described in 'sw842_compress'
lib/842/842_compress.c:479: warning: Function parameter or struct member 'ilen' not described in 'sw842_compress'
lib/842/842_compress.c:479: warning: Function parameter or struct member 'out' not described in 'sw842_compress'
lib/842/842_compress.c:479: warning: Function parameter or struct member 'olen' not described in 'sw842_compress'
lib/842/842_compress.c:479: warning: Function parameter or struct member 'wmem' not described in 'sw842_compress'
lib/842/842_decompress.c:279: warning: Function parameter or struct member 'in' not described in 'sw842_decompress'
lib/842/842_decompress.c:279: warning: Function parameter or struct member 'ilen' not described in 'sw842_decompress'
lib/842/842_decompress.c:279: warning: Function parameter or struct member 'out' not described in 'sw842_decompress'
lib/842/842_decompress.c:279: warning: Function parameter or struct member 'olen' not described in 'sw842_decompress'
arch/x86/kernel/cpu/mtrr/amd.c:61: warning: Function parameter or struct member 'reg' not described in 'amd_set_mtrr'
arch/x86/kernel/cpu/mtrr/amd.c:61: warning: Function parameter or struct member 'base' not described in 'amd_set_mtrr'
arch/x86/kernel/cpu/mtrr/amd.c:61: warning: Function parameter or struct member 'size' not described in 'amd_set_mtrr'
arch/x86/kernel/cpu/mtrr/amd.c:61: warning: Function parameter or struct member 'type' not described in 'amd_set_mtrr'
arch/x86/kernel/cpu/mtrr/centaur.c:28: warning: Function parameter or struct member 'replace_reg' not described in 'centaur_get_free_region'
mm/page_counter.c:400: warning: Function parameter or struct member 'counter' not described in 'page_counter_calculate_protection'
drivers/pinctrl/pinctrl-aw9523.c:562: warning: Function parameter or struct member 'awi' not described in '_aw9523_gpio_get_multiple'
drivers/pinctrl/pinctrl-aw9523.c:562: warning: Function parameter or struct member 'mask' not described in '_aw9523_gpio_get_multiple'
arch/x86/kernel/apic/apic.c:2138: warning: Function parameter or struct member 'spurious_interrupt' not described in 'DEFINE_IDTENTRY_IRQ'
kernel/reboot.c:234: warning: Function parameter or struct member 'cmd' not described in 'do_kernel_restart'
kernel/reboot.c:965: warning: Function parameter or struct member 'poweroff_delay_ms' not described in 'hw_failure_emergency_poweroff'
kernel/time/tick-broadcast.c:1026: warning: Function parameter or struct member 'bc' not described in 'tick_broadcast_setup_oneshot'
kernel/time/tick-broadcast.c:1026: warning: Function parameter or struct member 'from_periodic' not described in 'tick_broadcast_setup_oneshot'
fs/ufs/inode.c:398: warning: Function parameter or struct member 'inode' not described in 'ufs_getfrag_block'
fs/ufs/inode.c:398: warning: Function parameter or struct member 'fragment' not described in 'ufs_getfrag_block'
fs/ufs/inode.c:398: warning: Function parameter or struct member 'bh_result' not described in 'ufs_getfrag_block'
fs/ufs/inode.c:398: warning: Function parameter or struct member 'create' not described in 'ufs_getfrag_block'
fs/nilfs2/btnode.c:175: warning: Function parameter or struct member 'btnc' not described in 'nilfs_btnode_prepare_change_key'
fs/nilfs2/btnode.c:175: warning: Function parameter or struct member 'ctxt' not described in 'nilfs_btnode_prepare_change_key'
fs/nilfs2/btnode.c:238: warning: Function parameter or struct member 'btnc' not described in 'nilfs_btnode_commit_change_key'
fs/nilfs2/btnode.c:238: warning: Function parameter or struct member 'ctxt' not described in 'nilfs_btnode_commit_change_key'
fs/nilfs2/btnode.c:278: warning: Function parameter or struct member 'btnc' not described in 'nilfs_btnode_abort_change_key'
fs/nilfs2/btnode.c:278: warning: Function parameter or struct member 'ctxt' not described in 'nilfs_btnode_abort_change_key'
fs/nilfs2/super.c:121: warning: Function parameter or struct member 'sb' not described in '__nilfs_error'
fs/nilfs2/super.c:121: warning: Function parameter or struct member 'function' not described in '__nilfs_error'
fs/nilfs2/super.c:121: warning: Function parameter or struct member 'fmt' not described in '__nilfs_error'
fs/nilfs2/ioctl.c:120: warning: Function parameter or struct member 'dentry' not described in 'nilfs_fileattr_get'
fs/nilfs2/ioctl.c:120: warning: Function parameter or struct member 'fa' not described in 'nilfs_fileattr_get'
fs/nilfs2/ioctl.c:133: warning: Function parameter or struct member 'idmap' not described in 'nilfs_fileattr_set'
fs/nilfs2/ioctl.c:133: warning: Function parameter or struct member 'dentry' not described in 'nilfs_fileattr_set'
fs/nilfs2/ioctl.c:133: warning: Function parameter or struct member 'fa' not described in 'nilfs_fileattr_set'
fs/nilfs2/ioctl.c:164: warning: Function parameter or struct member 'inode' not described in 'nilfs_ioctl_getversion'
fs/nilfs2/ioctl.c:164: warning: Function parameter or struct member 'argp' not described in 'nilfs_ioctl_getversion'
fs/gfs2/glock.c:1277: warning: Function parameter or struct member 'ip' not described in '__gfs2_holder_init'
fs/bcachefs/io_write.c:1584: warning: Function parameter or struct member 'bch2_write' not described in 'CLOSURE_CALLBACK'
fs/gfs2/super.c:735: warning: Function parameter or struct member 'who' not described in 'gfs2_freeze_super'
fs/gfs2/super.c:803: warning: Function parameter or struct member 'who' not described in 'gfs2_thaw_super'
drivers/tty/n_hdlc.c:140: warning: Function parameter or struct member 'write_work' not described in 'n_hdlc'
drivers/tty/n_hdlc.c:140: warning: Function parameter or struct member 'tty_for_write_work' not described in 'n_hdlc'
drivers/memstick/core/memstick.c:206: warning: Function parameter or struct member 'host' not described in 'memstick_detect_change'
drivers/memstick/core/memstick.c:222: warning: Function parameter or struct member 'host' not described in 'memstick_next_req'
drivers/memstick/core/memstick.c:222: warning: Function parameter or struct member 'mrq' not described in 'memstick_next_req'
drivers/memstick/core/memstick.c:248: warning: Function parameter or struct member 'host' not described in 'memstick_new_req'
drivers/memstick/core/memstick.c:265: warning: Function parameter or struct member 'mrq' not described in 'memstick_init_req_sg'
drivers/memstick/core/memstick.c:265: warning: Function parameter or struct member 'tpc' not described in 'memstick_init_req_sg'
drivers/memstick/core/memstick.c:265: warning: Function parameter or struct member 'sg' not described in 'memstick_init_req_sg'
drivers/memstick/core/memstick.c:295: warning: Function parameter or struct member 'mrq' not described in 'memstick_init_req'
drivers/memstick/core/memstick.c:295: warning: Function parameter or struct member 'tpc' not described in 'memstick_init_req'
drivers/memstick/core/memstick.c:295: warning: Function parameter or struct member 'buf' not described in 'memstick_init_req'
drivers/memstick/core/memstick.c:295: warning: Function parameter or struct member 'length' not described in 'memstick_init_req'
drivers/memstick/core/memstick.c:366: warning: Function parameter or struct member 'card' not described in 'memstick_set_rw_addr'
drivers/memstick/core/memstick.c:513: warning: Function parameter or struct member 'host' not described in 'memstick_add_host'
drivers/memstick/core/memstick.c:549: warning: Function parameter or struct member 'host' not described in 'memstick_remove_host'
drivers/memstick/core/memstick.c:571: warning: Function parameter or struct member 'host' not described in 'memstick_free_host'
drivers/memstick/core/memstick.c:582: warning: Function parameter or struct member 'host' not described in 'memstick_suspend_host'
drivers/memstick/core/memstick.c:594: warning: Function parameter or struct member 'host' not described in 'memstick_resume_host'
drivers/firmware/efi/libstub/efi-stub-helper.c:613: warning: Function parameter or struct member 'out' not described in 'efi_load_initrd'
drivers/hwtracing/intel_th/core.c:866: warning: Function parameter or struct member 'drvdata' not described in 'intel_th_alloc'
drivers/hwtracing/intel_th/core.c:866: warning: Function parameter or struct member 'ndevres' not described in 'intel_th_alloc'
drivers/hwtracing/intel_th/msu.c:168: warning: Function parameter or struct member 'msu_base' not described in 'msc'
drivers/hwtracing/intel_th/msu.c:168: warning: Function parameter or struct member 'mbuf_priv' not described in 'msc'
drivers/hwtracing/intel_th/msu.c:168: warning: Function parameter or struct member 'work' not described in 'msc'
drivers/hwtracing/intel_th/msu.c:168: warning: Function parameter or struct member 'switch_on_unlock' not described in 'msc'
drivers/hwtracing/intel_th/msu.c:168: warning: Function parameter or struct member 'orig_addr' not described in 'msc'
drivers/hwtracing/intel_th/msu.c:168: warning: Function parameter or struct member 'orig_sz' not described in 'msc'
drivers/hwtracing/intel_th/msu.c:168: warning: Function parameter or struct member 'iter_list' not described in 'msc'
drivers/hwtracing/intel_th/msu.c:168: warning: Function parameter or struct member 'stop_on_full' not described in 'msc'
drivers/hwtracing/intel_th/msu.c:168: warning: Function parameter or struct member 'do_irq' not described in 'msc'
drivers/hwtracing/intel_th/msu.c:168: warning: Function parameter or struct member 'multi_is_broken' not described in 'msc'
drivers/hwmon/aht10.c:224: warning: Function parameter or struct member 'data' not described in 'aht10_interval_write'
drivers/hwmon/aht10.c:224: warning: Function parameter or struct member 'val' not described in 'aht10_interval_write'
drivers/hwmon/aht10.c:235: warning: Function parameter or struct member 'data' not described in 'aht10_interval_read'
drivers/hwmon/aht10.c:235: warning: Function parameter or struct member 'val' not described in 'aht10_interval_read'
drivers/hwmon/aht10.c:244: warning: Function parameter or struct member 'data' not described in 'aht10_temperature1_read'
drivers/hwmon/aht10.c:244: warning: Function parameter or struct member 'val' not described in 'aht10_temperature1_read'
drivers/hwmon/aht10.c:259: warning: Function parameter or struct member 'data' not described in 'aht10_humidity1_read'
drivers/hwmon/aht10.c:259: warning: Function parameter or struct member 'val' not described in 'aht10_humidity1_read'

These do not break builds, so maybe there are higher priorities, but I will trust your judgment
as if a senior developer's ...

Best regards,
Mirsad Todorovac

