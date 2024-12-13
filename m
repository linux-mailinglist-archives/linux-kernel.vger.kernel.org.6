Return-Path: <linux-kernel+bounces-445462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0CC9F16B3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6884016C1B1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB03190661;
	Fri, 13 Dec 2024 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo2N9yUJ"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA0F383
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 19:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119156; cv=none; b=ktMGwxpsrcUfSICJlzY7u5mAnwyk2g9CIHY7+vHLiHElwhJQQ5PVN2oeYov+yttY14L0RjPm1kJ6INb8mbm8Qx+4xdk1+4dixWmYvRt1Anb5FW7dVIaGyNTpnNvwzWJBuHWf+/cC2KxpzTefgXKrJ6mNNNbytx4RmH3I03CAcVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119156; c=relaxed/simple;
	bh=C45oS/l3TMjrzyNFmdEFlaeWkp4K4nkYHgXrHiEutt4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=t1JklJ4/lGEVFS8Y8j7Qit04I4/Mmedeilej6GksxYgun1/Z/L02gz6mHqSyuYiZs0/p01rVlcF+5PPVbdxd8w8ggBuv+HVPe7vKT3WDBYn7hyYPQRRHGCL37SJKOmrJIkqE/DEAQlSPLXxu+xfkk1LxShOj1bUkbEtQ213P6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mo2N9yUJ; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3eba783ec88so63756b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734119153; x=1734723953; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0vbTY4Hgki2VPY0Js9xYK7VSk929u3ZYFaX7VD85rXE=;
        b=Mo2N9yUJ5YaT6mayGICNjZ/+VncwUrU5GhPz3pFdL8NZ7kQT9F96cUp7XCZl1VQIco
         2kuFxn/xGoQV0dYTuKPcJ/gPaLYGM5Q7Z2W8LqHo1p72SPbU2AZmPkv8IGCnPIq82kxB
         uaejZTZ1ilNb0FPpVFLsHFIWMHsarlAe09LZq9d/8OxjAYDOmZYCzJILMUkLmyJsFezp
         oF2JEbXirh1rnOJK97OEM+1MA7AjXFfHRpKzOrC/PLSK3DKHtdOlt0D0N5h95MC+fif7
         yCqB9cQxqO9irwcph82szkouRqIibdd6LvGD1cPkp4xFUVNG+JMAW7IMR1W/fI+KPWWA
         W2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734119153; x=1734723953;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0vbTY4Hgki2VPY0Js9xYK7VSk929u3ZYFaX7VD85rXE=;
        b=QjleeMqpPO0d62h5loqwQkKMrhRMjJGDA1qUUj2VRM0lYyf/Ax+H1mfI7cwvEuznMQ
         TPsYeX/86BaEXC1MwqVmlMWVSfk9L3d/Foh/afzKhMK6tSvsBLrHFTfLoZgkeK77tbPx
         uk/koZw8n9B9qM2qYiH+80cNW1Xx7iUxXbc5lEWPiSre3AVPGALNPub93D/tW4S9yuLQ
         xRWbzObdNmBhqPm2klwYWZs42EGlSKnHVP7CAxEJYdmUqs/Ac3QQ4v3Hf7atoEcWBH5d
         kTg3ltZeLLn2yL0fjRdE1YLM0+ra9k2o4ng5yiS+UvE66Q9+qwPqNJkcsAmlUlbuHhjt
         qlJw==
X-Gm-Message-State: AOJu0Yyfhdhetxm1N3Vb6H/b26Fl/UO3R6m2XuLxowGRaAowGbG7t7z/
	NfrejQTryW2E1aWyed21gxeKtQJs4AmKXPY81sSFp2FaHant/CClwGEJYYbmz/KYjVr9vfnvvQT
	krvC7d+Vq7XJ7/jNXp7bjfD/GoUDdKzT+
X-Gm-Gg: ASbGnctczr+pMaQBG6Blt+1AVt6iZj8+sfexycvAsaM2w69hV9rt/67xyOMX00L001R
	dXqL9fDv+KeUSlz66fNLfSioxVOdtyQ8TETbjcg==
X-Google-Smtp-Source: AGHT+IE9h1AU4ma9XxmCA9XgEBIyNhTCl7f4XJSJhEBRf56CPLMJ3IHKkAWMQXJ1OVVl9okMD63saD+v+3JAFkYl7/k=
X-Received: by 2002:a17:90b:4ccc:b0:2ee:a558:b6bf with SMTP id
 98e67ed59e1d1-2f2904b6227mr2251154a91.8.1734118772104; Fri, 13 Dec 2024
 11:39:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jeff Chua <jeff.chua.linux@gmail.com>
Date: Sat, 14 Dec 2024 03:39:20 +0800
Message-ID: <CAAJw_ZtppNqC9XA=-WVQDr+vaAS=di7jo15CzSqONeX48H75MA@mail.gmail.com>
Subject: linux 6.12.0-rc6+ hangs on mkfs.ext4 on USB microSD
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I tried to run 'mkfs.ext4  /dev/sda2' (usb microSD) and it hung the
whole system.

# dmesg
sd 0:0:0:0: [sda] Attached SCSI removable disk
BUG: unable to handle page fault for address: 00000004145cf5ce
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 7 UID: 0 PID: 15287 Comm: usb-storage Tainted: G     U
 6.12.0-rc6+ #26
Tainted: [U]=USER
Hardware name: LENOVO 21FWS6UK00/21FWS6UK00, BIOS N3ZET33W (1.20 ) 02/29/2024
RIP: 0010:xhci_ring_expansion+0xf3/0x340
Code: c2 48 83 c0 10 83 4a 0c 01 48 3d 00 10 00 00 75 ea 48 8b 49 08
48 3b 0b 74 05 48 85 c9 75 da 48 8b 53 08 48 8b 85 78 ff ff ff <48> 8b
7e 08 44 8b 4d b8 48 85 d2 48 89 c1 0f 84 34 01 00 00 48 85
RSP: 0018:ffffc90000787978 EFLAGS: 00010006
RAX: ffff8881089056c0 RBX: ffff88810484b780 RCX: ffff888139b2d000
RDX: ffff888104845680 RSI: 00000004145cf5c6 RDI: 0000000000000000
RBP: ffffc90000787a10 R08: 0000000000000002 R09: ffff8881458bd000
R10: 0000000000000100 R11: ffff8881088ce228 R12: ffff888102cd7250
R13: 0000000000000820 R14: 0000000000000000 R15: ffff88810484b780
FS:  0000000000000000(0000) GS:ffff8897ff3c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000004145cf5ce CR3: 0000000002a2a000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? show_regs+0x5f/0x70
 ? __die+0x1f/0x70
 ? page_fault_oops+0x15a/0x450
 ? apic_smt_update+0x10/0x50
 ? exc_page_fault+0x2d4/0x500
 ? asm_exc_page_fault+0x27/0x30
 ? xhci_ring_expansion+0xf3/0x340
 ? xhci_ring_expansion+0x6a/0x340
 ? ktime_get+0x35/0xd0
 ? xhci_dbg_trace+0x55/0x80
 prepare_ring+0x11b/0x2e0
 prepare_transfer+0x82/0x150
 xhci_queue_bulk_tx+0x11c/0xa30
 ? dma_direct_map_sg+0x9a/0x290
 ? psi_group_change+0x138/0x360
 xhci_urb_enqueue+0x251/0x290
 usb_hcd_submit_urb+0xb8/0xa90
 ? schedule+0x22/0xe0
 ? schedule_timeout+0xda/0xf0
 ? sched_clock_cpu+0x10/0x1a0
usb_submit_urb+0x24c/0x5c0
 ? usb_alloc_urb+0x34/0x80
 usb_sg_wait+0x7c/0x170
 usb_stor_bulk_transfer_sglist+0x7c/0x120 [usb_storage]
 usb_stor_Bulk_transport+0x215/0x3e0 [usb_storage]
 usb_stor_invoke_transport+0x39/0x4f0 [usb_storage]
 ? schedule_timeout+0xda/0xf0
 ? wait_for_completion_interruptible+0x17f/0x1a0
 usb_stor_transparent_scsi_command+0x9/0x10 [usb_storage]
 usb_stor_control_thread+0x1e4/0x2b0 [usb_storage]
 ? __pfx_usb_stor_control_thread+0x10/0x10 [usb_storage]
 kthread+0xdc/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x35/0x60
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Modules linked in: uas usb_storage snd_ctl_led bnep
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component
snd_hda_codec_hdmi snd_soc_dmic snd_hda_intel
snd_hda_scodec_cs35l41_i2c snd_hda_scodec_cs35l41 snd_hda_cs_dsp_ctls
snd_soc_cs_amp_lib cs_dsp snd_soc_cs35l41_lib serial_multi_instantiate
pinctrl_tigerlake snd_soc_skl_hda_dsp snd_soc_intel_sof_board_helpers
snd_soc_intel_hda_dsp_common snd_soc_acpi_intel_match snd_soc_acpi
snd_soc_core snd_compress snd_pcm_dmaengine snd_hda_codec snd_hda_core
ac97_bus snd_hwdep snd_pcm snd_timer snd soundcore snd_intel_dspcfg
snd_intel_sdw_acpi intel_lpss_pci intel_lpss idma64 iwlmvm iwlwifi
mac80211 cfg80211 ax88179_178a usbnet mii usbhid btusb btrtl btintel
btbcm bluetooth ecdh_generic ecc
CR2: 00000004145cf5ce
---[ end trace 0000000000000000 ]---
RIP: 0010:xhci_ring_expansion+0xf3/0x340
Code: c2 48 83 c0 10 83 4a 0c 01 48 3d 00 10 00 00 75 ea 48 8b 49 08
48 3b 0b 74 05 48 85 c9 75 da 48 8b 53 08 48 8b 85 78 ff ff ff <48> 8b
7e 08 44 8b 4d b8 48 85 d2 48 89 c1 0f 84 34 01 00 00 48 85
RSP: 0018:ffffc90000787978 EFLAGS: 00010006
RAX: ffff8881089056c0 RBX: ffff88810484b780 RCX: ffff888139b2d000
RDX: ffff888104845680 RSI: 00000004145cf5c6 RDI: 0000000000000000
RBP: ffffc90000787a10 R08: 0000000000000002 R09: ffff8881458bd000
R10: 0000000000000100 R11: ffff8881088ce228 R12: ffff888102cd7250
R13: 0000000000000820 R14: 0000000000000000 R15: ffff88810484b780
FS:  0000000000000000(0000) GS:ffff8897ff3c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000004145cf5ce CR3: 0000000002a2a000 CR4: 0000000000750ef0
PKRU: 55555554
note: usb-storage[15287] exited with irqs disabled
note: usb-storage[15287] exited with preempt_count 1


# git bisect bad
fe688e5006133b2609c136f599e120a95cc450cb is the first bad commit
commit fe688e5006133b2609c136f599e120a95cc450cb (HEAD)
Author: Niklas Neronin <niklas.neronin@linux.intel.com>
Date:   Wed Nov 6 12:14:40 2024 +0200

    usb: xhci: refactor xhci_link_rings() to use source and destination rings

    Refactor the xhci_link_rings() function to accept two rings: a source ring
    and a destination ring. Previously, the function accepted a ring and a
    segment list as arguments, now the function splices the source ring segment
    list into the destination ring. This new approach reduces the number of
    arguments and simplifies the code, making it easier to follow.

    Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
    Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
    Link: https://lore.kernel.org/r/20241106101459.775897-15-mathias.nyman@linux.intel.com
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

 drivers/usb/host/xhci-mem.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)


Reverted the above and system worked ok.

My best.,
Jeff

