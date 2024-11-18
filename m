Return-Path: <linux-kernel+bounces-412492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44EF9D09A8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E171F21628
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFCB148827;
	Mon, 18 Nov 2024 06:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mpg4dEce"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801A717597;
	Mon, 18 Nov 2024 06:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731911484; cv=none; b=KlxyyxjzvZyi/C8QAwbRQVG/I87fVzL3iwSZ1jslU2P5xEf8AtcDf6SMkaSFwSKLUfMg+ybICNT6NHdXhLC3pdSMONN1rYieiNu/+gK72jjTUZDviQ0aSFdwUd50kSSKznu7Lo9/guxl1vq5ptwXPXq24fs8yF9LqJFsFfxZFfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731911484; c=relaxed/simple;
	bh=zgnjFLSncn/d+6BLKPZrOrCvJijrOYmVr6Teb4gLO1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNaI8G1qs350wnsqc8Vd/h4AkM+a6R2z1nNgCMB+c4GbSXtA39EkI3gpWssClZpnmGdSKA1fsE9qilDgj5yOHdoDDB6/fuWwx7CQisBZ530Ky2aEHw+ixaPYGw9FMsisGZgThlQJB6a7X4vumNtGcMCCiir9eyK7o3ILy2vRy20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mpg4dEce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DF6C4CECC;
	Mon, 18 Nov 2024 06:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731911484;
	bh=zgnjFLSncn/d+6BLKPZrOrCvJijrOYmVr6Teb4gLO1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mpg4dEcecY49p3gvaiudMeBBA9j75emqDMMvXfCEel79Y6USLo1DeAmBfrzuI5Jyi
	 4UdPwCrW6APD9GS93fkSBvwqnMjd9/jFMgIWvZJTCKednWGUMmDqwerNPUD7FRhSfy
	 P5Zb65rCPM9zNN76Hdc/MH+lyqk02/bD1W1lOVR8=
Date: Mon, 18 Nov 2024 07:30:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Markus Rechberger <linuxusb.ml@sundtek.de>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] XHCI NULL Pointer check in xhci_check_bw_table
Message-ID: <2024111828-canon-smoking-8d1c@gregkh>
References: <b90d48df16cf74bb682af870cd71d7c5cc4a9d97.camel@sundtek.de>
 <03c1ae453f2781dbcf3a5ea607640c696b748848.camel@sundtek.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03c1ae453f2781dbcf3a5ea607640c696b748848.camel@sundtek.de>

On Mon, Nov 18, 2024 at 07:27:03AM +0800, Markus Rechberger wrote:
> This patch fixes a NULL Pointer exception when a device using the XHCI
> controller driver is not properly initialized. It's relatively easy to
> reproduce with a faulty connection to a USB Harddisk / USB Ethernet
> adapter. 
> The way I used for testing this patch was to short USB D+/D- and pull
> them to ground.
> 
> We manufacture our own USB devices and use Linux for testing, lately we
> upgraded the system to Ubuntu noble with Kernel 6.8.0 and our system
> also crashed multiple times just when plugging in some devices (no
> commands need to be executed).
> We connect/disconnect devices > 100 times (eg uploading firmware, do
> electrical tests etc).
> 
> I would rate this issue as highly critical.
> The problem is triggered via some fallback code in hub.c, a second
> patch will follow which
> removes the endpoint reset in the particular fallback.
> 
> 2024-11-16T22:14:09.701229+08:00 sundtek-UX32VD kernel: usb 3-2: new
> full-speed USB device number 64 using xhci_hcd
> 2024-11-16T22:14:09.816295+08:00 sundtek-UX32VD kernel: usb 3-2: device
> descriptor read/64, error -71
> 2024-11-16T22:14:10.006157+08:00 sundtek-UX32VD kernel: audit:
> type=1400 audit(1731766450.004:3206): apparmor="DENIED"
> operation="open" class="file" profile="snap.skype.skype"
> name="/sys/devices/pci0000:00/ACPI0003:00/power_supply/AC0/online"
> pid=4839 comm="skypeforlinux" requested_mask="r" denied_mask="r"
> fsuid=1000 ouid=0
> 2024-11-16T22:14:10.035263+08:00 sundtek-UX32VD kernel: usb 3-2: device
> descriptor read/64, error -71
> 2024-11-16T22:14:10.251221+08:00 sundtek-UX32VD kernel: usb 3-2: new
> full-speed USB device number 65 using xhci_hcd
> 2024-11-16T22:14:10.365247+08:00 sundtek-UX32VD kernel: usb 3-2: device
> descriptor read/64, error -71
> 2024-11-16T22:14:10.587264+08:00 sundtek-UX32VD kernel: usb 3-2: device
> descriptor read/64, error -71
> 2024-11-16T22:14:10.689265+08:00 sundtek-UX32VD kernel: usb usb3-port2:
> attempt power cycle
> 2024-11-16T22:14:11.006217+08:00 sundtek-UX32VD kernel: audit:
> type=1400 audit(1731766451.004:3207): apparmor="DENIED"
> operation="open" class="file" profile="snap.skype.skype"
> name="/sys/devices/pci0000:00/ACPI0003:00/power_supply/AC0/online"
> pid=4839 comm="skypeforlinux" requested_mask="r" denied_mask="r"
> fsuid=1000 ouid=0
> 2024-11-16T22:14:11.069247+08:00 sundtek-UX32VD kernel: usb 3-2: new
> full-speed USB device number 66 using xhci_hcd
> 2024-11-16T22:14:11.069347+08:00 sundtek-UX32VD kernel: usb 3-2: Device
> not responding to setup address.
> 2024-11-16T22:14:11.273256+08:00 sundtek-UX32VD kernel: usb 3-2: Device
> not responding to setup address.
> 2024-11-16T22:14:12.122162+08:00 sundtek-UX32VD kernel: usb 3-2: device
> not accepting address 66, error -71
> 2024-11-16T22:14:12.122196+08:00 sundtek-UX32VD kernel: BUG: kernel
> NULL pointer dereference, address: 0000000000000020
> 2024-11-16T22:14:12.122203+08:00 sundtek-UX32VD kernel: #PF: supervisor
> read access in kernel mode
> 2024-11-16T22:14:12.122206+08:00 sundtek-UX32VD kernel: #PF:
> error_code(0x0000) - not-present page
> 2024-11-16T22:14:12.122210+08:00 sundtek-UX32VD kernel: PGD 0 P4D 0 
> 2024-11-16T22:14:12.122214+08:00 sundtek-UX32VD kernel: Oops: 0000 [#1]
> PREEMPT SMP PTI
> 2024-11-16T22:14:12.122216+08:00 sundtek-UX32VD kernel: CPU: 2 PID:
> 15600 Comm: kworker/2:1 Not tainted 6.8.0-48-generic #48-Ubuntu
> 2024-11-16T22:14:12.122219+08:00 sundtek-UX32VD kernel: Hardware name:
> ASUSTeK COMPUTER INC. UX32VD/UX32VD, BIOS UX32VD.214 01/29/2013
> 2024-11-16T22:14:12.122221+08:00 sundtek-UX32VD kernel: Workqueue:
> usb_hub_wq hub_event
> 2024-11-16T22:14:12.122224+08:00 sundtek-UX32VD kernel: RIP:
> 0010:xhci_check_bw_table+0x100/0x4d0
> 2024-11-16T22:14:12.122227+08:00 sundtek-UX32VD kernel: Code: c7 c2 60
> 35 70 9f 48 c7 c6 70 aa 79 9e 4c 89 55 c0 4c 89 5d d0 e8 d0 c7 01 00 4c
> 8b 5d d0 4c 8b 55 c0 4c 8b 4d b8 41 8d 47 ff <41> 8b 4a 20 31 d2 45 8b
> 72 08 89 45 d0 41 03 02 41 f7 f7 ba 80 00
> 2024-11-16T22:14:12.122231+08:00 sundtek-UX32VD kernel: RSP:
> 0018:ffffc3774ebeb758 EFLAGS: 00010046
> 2024-11-16T22:14:12.122234+08:00 sundtek-UX32VD kernel: RAX:
> 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> 2024-11-16T22:14:12.122236+08:00 sundtek-UX32VD kernel: RDX:
> 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> 2024-11-16T22:14:12.122239+08:00 sundtek-UX32VD kernel: RBP:
> ffffc3774ebeb7c0 R08: 0000000000000000 R09: ffff9fcad3566000
> 2024-11-16T22:14:12.122242+08:00 sundtek-UX32VD kernel: R10:
> 0000000000000000 R11: ffff9fc9cc687260 R12: ffffc37741131000
> 2024-11-16T22:14:12.122245+08:00 sundtek-UX32VD kernel: R13:
> 0000000000000000 R14: ffff9fcad3566000 R15: 0000000000000001
> 2024-11-16T22:14:12.122247+08:00 sundtek-UX32VD kernel: FS: 
> 0000000000000000(0000) GS:ffff9fcb65700000(0000) knlGS:0000000000000000
> 2024-11-16T22:14:12.122250+08:00 sundtek-UX32VD kernel: CS:  0010 DS:
> 0000 ES: 0000 CR0: 0000000080050033
> 2024-11-16T22:14:12.122252+08:00 sundtek-UX32VD kernel: CR2:
> 0000000000000020 CR3: 000000021c23c005 CR4: 00000000001706f0
> 2024-11-16T22:14:12.122254+08:00 sundtek-UX32VD kernel: Call Trace:
> 2024-11-16T22:14:12.122257+08:00 sundtek-UX32VD kernel:  <TASK>
> 2024-11-16T22:14:12.122259+08:00 sundtek-UX32VD kernel:  ?
> show_regs+0x6d/0x80
> 2024-11-16T22:14:12.122261+08:00 sundtek-UX32VD kernel:  ?
> __die+0x24/0x80
> 2024-11-16T22:14:12.122263+08:00 sundtek-UX32VD kernel:  ?
> page_fault_oops+0x99/0x1b0
> 2024-11-16T22:14:12.122265+08:00 sundtek-UX32VD kernel:  ?
> kernelmode_fixup_or_oops.isra.0+0x69/0x90
> 2024-11-16T22:14:12.122267+08:00 sundtek-UX32VD kernel:  ?
> __bad_area_nosemaphore+0x19d/0x2c0
> 2024-11-16T22:14:12.122269+08:00 sundtek-UX32VD kernel:  ?
> update_sg_lb_stats+0x97/0x5c0
> 2024-11-16T22:14:12.122271+08:00 sundtek-UX32VD kernel:  ?
> bad_area_nosemaphore+0x16/0x30
> 2024-11-16T22:14:12.122273+08:00 sundtek-UX32VD kernel:  ?
> do_user_addr_fault+0x29c/0x670
> 2024-11-16T22:14:12.122275+08:00 sundtek-UX32VD kernel:  ?
> exc_page_fault+0x83/0x1b0
> 2024-11-16T22:14:12.122276+08:00 sundtek-UX32VD kernel:  ?
> asm_exc_page_fault+0x27/0x30
> 2024-11-16T22:14:12.122279+08:00 sundtek-UX32VD kernel:  ?
> xhci_check_bw_table+0x100/0x4d0
> 2024-11-16T22:14:12.122281+08:00 sundtek-UX32VD kernel:  ?
> xhci_check_bw_table+0x357/0x4d0
> 2024-11-16T22:14:12.122283+08:00 sundtek-UX32VD kernel: 
> xhci_reserve_bandwidth+0x298/0xb20
> 2024-11-16T22:14:12.122286+08:00 sundtek-UX32VD kernel:  ?
> update_load_avg+0x82/0x850
> 2024-11-16T22:14:12.122288+08:00 sundtek-UX32VD kernel: 
> xhci_configure_endpoint+0xa8/0x730
> 2024-11-16T22:14:12.122291+08:00 sundtek-UX32VD kernel: 
> xhci_check_ep0_maxpacket.isra.0+0x14e/0x1d0
> 2024-11-16T22:14:12.122293+08:00 sundtek-UX32VD kernel: 
> xhci_endpoint_reset+0x254/0x4a0
> 2024-11-16T22:14:12.122295+08:00 sundtek-UX32VD kernel:  ?
> _raw_spin_lock_irqsave+0xe/0x20
> 2024-11-16T22:14:12.122298+08:00 sundtek-UX32VD kernel: 
> usb_hcd_reset_endpoint+0x28/0xa0
> 2024-11-16T22:14:12.122300+08:00 sundtek-UX32VD kernel: 
> usb_enable_endpoint+0x8c/0xa0
> 2024-11-16T22:14:12.122302+08:00 sundtek-UX32VD kernel: 
> hub_port_connect+0x176/0xb70
> 2024-11-16T22:14:12.122305+08:00 sundtek-UX32VD kernel: 
> hub_port_connect_change+0x88/0x2b0
> 2024-11-16T22:14:12.122307+08:00 sundtek-UX32VD kernel: 
> port_event+0x651/0x810
> 2024-11-16T22:14:12.122309+08:00 sundtek-UX32VD kernel: 
> hub_event+0x14a/0x450
> 2024-11-16T22:14:12.122311+08:00 sundtek-UX32VD kernel: 
> process_one_work+0x178/0x350
> 2024-11-16T22:14:12.122313+08:00 sundtek-UX32VD kernel: 
> worker_thread+0x306/0x440
> 2024-11-16T22:14:12.122316+08:00 sundtek-UX32VD kernel:  ?
> _raw_spin_lock_irqsave+0xe/0x20
> 2024-11-16T22:14:12.122318+08:00 sundtek-UX32VD kernel:  ?
> __pfx_worker_thread+0x10/0x10
> 2024-11-16T22:14:12.122321+08:00 sundtek-UX32VD kernel: 
> kthread+0xf2/0x120
> 2024-11-16T22:14:12.122323+08:00 sundtek-UX32VD kernel:  ?
> __pfx_kthread+0x10/0x10
> 2024-11-16T22:14:12.122325+08:00 sundtek-UX32VD kernel: 
> ret_from_fork+0x47/0x70
> 2024-11-16T22:14:12.122327+08:00 sundtek-UX32VD kernel:  ?
> __pfx_kthread+0x10/0x10
> 2024-11-16T22:14:12.122329+08:00 sundtek-UX32VD kernel: 
> ret_from_fork_asm+0x1b/0x30
> 2024-11-16T22:14:12.122331+08:00 sundtek-UX32VD kernel:  </TASK>
> 2024-11-16T22:14:12.122334+08:00 sundtek-UX32VD kernel: Modules linked
> in: cpuid ufs qnx4 hfsplus hfs minix ntfs msdos jfs nls_ucs2_utils xfs
> usbtest rfcomm snd_seq_dummy snd_hrtimer qrtr uhid hid cmac algif_hash
> algif_skcipher af_alg bnep sunrpc snd_hda_codec_hdmi intel_rapl_msr
> intel_rapl_common binfmt_misc snd_hda_codec_realtek
> x86_pkg_temp_thermal snd_hda_codec_generic intel_powerclamp coretemp
> kvm_intel snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi uvcvideo
> snd_hda_codec kvm videobuf2_vmalloc snd_hda_core uvc btusb snd_hwdep
> irqbypass videobuf2_memops snd_pcm btrtl videobuf2_v4l2 iwldvm
> rtsx_usb_ms btintel videodev btbcm rapl btmtk at24 mei_pxp mei_hdcp
> memstick nls_iso8859_1 mac80211 asus_nb_wmi videobuf2_common mfd_aaeon
> libarc4 mc i915 snd_seq_midi bluetooth snd_seq_midi_event snd_rawmidi
> intel_cstate asus_wmi iwlwifi ledtrig_audio ecdh_generic sparse_keymap
> platform_profile i2c_i801 ecc mxm_wmi drm_buddy wmi_bmof snd_seq
> i2c_smbus cfg80211 ttm snd_seq_device snd_timer drm_display_helper snd
> acpi_als mei_me cec soundcore
> 2024-11-16T22:14:12.122337+08:00 sundtek-UX32VD kernel: 
> industrialio_triggered_buffer rc_core lpc_ich mei i2c_algo_bit
> int3400_thermal kfifo_buf int3402_thermal industrialio int3403_thermal
> acpi_thermal_rel asus_wireless int340x_thermal_zone joydev input_leds
> mac_hid serio_raw sch_fq_codel msr parport_pc ppdev lp parport
> efi_pstore nfnetlink dmi_sysfs ip_tables x_tables autofs4 btrfs
> blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq
> async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 rtsx_usb_sdmmc
> rtsx_usb crct10dif_pclmul crc32_pclmul polyval_clmulni polyval_generic
> ghash_clmulni_intel sha256_ssse3 sha1_ssse3 video psmouse ahci xhci_pci
> libahci xhci_pci_renesas wmi aesni_intel crypto_simd cryptd
> 2024-11-16T22:14:12.122340+08:00 sundtek-UX32VD kernel: CR2:
> 0000000000000020
> 2024-11-16T22:14:12.122342+08:00 sundtek-UX32VD kernel: ---[ end trace
> 0000000000000000 ]---
> 2024-11-16T22:14:12.122344+08:00 sundtek-UX32VD kernel: RIP:
> 0010:xhci_check_bw_table+0x100/0x4d0
> 2024-11-16T22:14:12.122346+08:00 sundtek-UX32VD kernel: Code: c7 c2 60
> 35 70 9f 48 c7 c6 70 aa 79 9e 4c 89 55 c0 4c 89 5d d0 e8 d0 c7 01 00 4c
> 8b 5d d0 4c 8b 55 c0 4c 8b 4d b8 41 8d 47 ff <41> 8b 4a 20 31 d2 45 8b
> 72 08 89 45 d0 41 03 02 41 f7 f7 ba 80 00
> 2024-11-16T22:14:12.122349+08:00 sundtek-UX32VD kernel: RSP:
> 0018:ffffc3774ebeb758 EFLAGS: 00010046
> 2024-11-16T22:14:12.122352+08:00 sundtek-UX32VD kernel: RAX:
> 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> 2024-11-16T22:14:12.122355+08:00 sundtek-UX32VD kernel: RDX:
> 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> 2024-11-16T22:14:12.122357+08:00 sundtek-UX32VD kernel: RBP:
> ffffc3774ebeb7c0 R08: 0000000000000000 R09: ffff9fcad3566000
> 2024-11-16T22:14:12.122359+08:00 sundtek-UX32VD kernel: R10:
> 0000000000000000 R11: ffff9fc9cc687260 R12: ffffc37741131000
> 2024-11-16T22:14:12.122361+08:00 sundtek-UX32VD kernel: R13:
> 0000000000000000 R14: ffff9fcad3566000 R15: 0000000000000001
> 2024-11-16T22:14:12.122363+08:00 sundtek-UX32VD kernel: FS: 
> 0000000000000000(0000) GS:ffff9fcb65700000(0000) knlGS:0000000000000000
> 2024-11-16T22:14:12.122366+08:00 sundtek-UX32VD kernel: CS:  0010 DS:
> 0000 ES: 0000 CR0: 0000000080050033
> 2024-11-16T22:14:12.122368+08:00 sundtek-UX32VD kernel: CR2:
> 0000000000000020 CR3: 000000011ffde004 CR4: 00000000001706f0
> 2024-11-16T22:14:12.122371+08:00 sundtek-UX32VD kernel: note:
> kworker/2:1[15600] exited with irqs disabled
> 2024-11-16T22:14:12.122373+08:00 sundtek-UX32VD kernel: note:
> kworker/2:1[15600] exited with preempt_count 1
> 
> Signed-off-by: Markus Rechberger <linuxusb.ml@sundtek.de>
> 
> This patch diff --git a/drivers/usb/host/xhci.c
> b/drivers/usb/host/xhci.c
> index 899c0effb5d3..f054e262176c 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -2380,6 +2380,17 @@ static int xhci_check_bw_table(struct xhci_hcd
> *xhci,
>  	}
>  
>  	bw_table = virt_dev->bw_table;
> +
> +	/* second line of defense, this should not happen if bw_table
> +       is not initialized this calculation should not be called
> +       any issue with bw_table is supposed to be handled earlier
> +	*/
> +	if (bw_table == NULL) {
> +		xhci_warn(xhci, "bw_table == NULL, this should not
> happen\n"
> +				"please report\n");
> +		return -ENOMEM;
> +	}
> +
>  	/* We need to translate the max packet size and max ESIT
> payloads into
>  	 * the units the hardware uses.
>  	 */
> 
> 

> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 899c0effb5d3..f054e262176c 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -2380,6 +2380,17 @@ static int xhci_check_bw_table(struct xhci_hcd *xhci,
>  	}
>  
>  	bw_table = virt_dev->bw_table;
> +
> +	/* second line of defense, this should not happen if bw_table
> +       is not initialized this calculation should not be called
> +       any issue with bw_table is supposed to be handled earlier
> +	*/
> +	if (bw_table == NULL) {
> +		xhci_warn(xhci, "bw_table == NULL, this should not happen\n"
> +				"please report\n");
> +		return -ENOMEM;
> +	}
> +
>  	/* We need to translate the max packet size and max ESIT payloads into
>  	 * the units the hardware uses.
>  	 */


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

