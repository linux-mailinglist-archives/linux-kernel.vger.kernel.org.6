Return-Path: <linux-kernel+bounces-412151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C510E9D047F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 16:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6585228253F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 15:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8C717C200;
	Sun, 17 Nov 2024 15:32:45 +0000 (UTC)
Received: from sundtek.de (sundtek.de [85.10.198.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713ADCA64
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.198.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731857564; cv=none; b=RprK/kqNvzFjV0czmBDbfx+MKB3HQ4yKQvDsZHl1iyiovwN4XvcTi6AFoyMpWhnY3TChiMI7cwQP3JC9Y+raYSkwakCdB2zSDYH7jQqUSdny/Dv/jK8A/1LB1ItwI/lcxf7fhraSjjblSJpaD2+56CTh9klqFF87rNjlgNu4BsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731857564; c=relaxed/simple;
	bh=aQ6LtKJnxbyp3esVAl7rZ1wdgzMJRNIxU8TDzWwPXrk=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=J+jwwmEHYWWoICP8lhyEJJZshwZY3Axv+t4+SNe5HL9B+S60op3WMxUK8pAEQvMYi0YHptnkbunRqe8ipJb+nWws9y2VHyUhhuYBLWiMsrgRSwjKG9ixs8jkXSGLL+7HztwDRHVqWf6Lp+FRrjCoBiJH+qnREm6qaW72WcgY+xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sundtek.de; spf=pass smtp.mailfrom=sundtek.de; arc=none smtp.client-ip=85.10.198.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sundtek.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sundtek.de
Received: from Debian-exim by sundtek.de with spam-scanned (Exim 4.95)
	(envelope-from <linuxusb.ml@sundtek.de>)
	id 1tChGQ-005HVo-Os
	for linux-kernel@vger.kernel.org;
	Sun, 17 Nov 2024 16:32:40 +0100
Received: from 1-175-135-24.dynamic-ip.hinet.net ([1.175.135.24] helo=[192.168.2.197])
	by sundtek.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <linuxusb.ml@sundtek.de>)
	id 1tChGQ-005HVl-6L;
	Sun, 17 Nov 2024 16:32:38 +0100
Message-ID: <b90d48df16cf74bb682af870cd71d7c5cc4a9d97.camel@sundtek.de>
Subject: [PATCH] XHCI NULL Pointer check in xhci_check_bw_table
From: Sundtek <linuxusb.ml@sundtek.de>
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>
Date: Sun, 17 Nov 2024 23:32:35 +0800
Content-Type: multipart/mixed; boundary="=-uhUJ2fBZmepiOIZViUqL"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: linuxusb.ml@sundtek.de
X-SA-Exim-Scanned: No (on sundtek.de); SAEximRunCond expanded to false

--=-uhUJ2fBZmepiOIZViUqL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch fixes a NULL Pointer exception when a device using the XHCI
controller driver is not properly initialized. It's relatively easy to
reproduce with a faulty connection to a USB Harddisk / USB Ethernet
adapter.=C2=A0
The way I used for testing this patch was to short USB D+/D- and pull
them to ground.

We manufacture our own USB devices and use Linux for testing, lately we
upgraded the system to Ubuntu noble with Kernel 6.8.0 and our system
also crashed multiple times just when plugging in some devices (no
commands need to be executed).
We connect/disconnect devices > 100 times (eg uploading firmware, do
electrical tests etc).

I would rate this issue as highly critical.
The problem is triggered via some fallback code in hub.c, a second
patch will follow which
removes the endpoint reset in the particular fallback.

2024-11-16T22:14:09.701229+08:00 sundtek-UX32VD kernel: usb 3-2: new
full-speed USB device number 64 using xhci_hcd
2024-11-16T22:14:09.816295+08:00 sundtek-UX32VD kernel: usb 3-2: device
descriptor read/64, error -71
2024-11-16T22:14:10.006157+08:00 sundtek-UX32VD kernel: audit:
type=3D1400 audit(1731766450.004:3206): apparmor=3D"DENIED"
operation=3D"open" class=3D"file" profile=3D"snap.skype.skype"
name=3D"/sys/devices/pci0000:00/ACPI0003:00/power_supply/AC0/online"
pid=3D4839 comm=3D"skypeforlinux" requested_mask=3D"r" denied_mask=3D"r"
fsuid=3D1000 ouid=3D0
2024-11-16T22:14:10.035263+08:00 sundtek-UX32VD kernel: usb 3-2: device
descriptor read/64, error -71
2024-11-16T22:14:10.251221+08:00 sundtek-UX32VD kernel: usb 3-2: new
full-speed USB device number 65 using xhci_hcd
2024-11-16T22:14:10.365247+08:00 sundtek-UX32VD kernel: usb 3-2: device
descriptor read/64, error -71
2024-11-16T22:14:10.587264+08:00 sundtek-UX32VD kernel: usb 3-2: device
descriptor read/64, error -71
2024-11-16T22:14:10.689265+08:00 sundtek-UX32VD kernel: usb usb3-port2:
attempt power cycle
2024-11-16T22:14:11.006217+08:00 sundtek-UX32VD kernel: audit:
type=3D1400 audit(1731766451.004:3207): apparmor=3D"DENIED"
operation=3D"open" class=3D"file" profile=3D"snap.skype.skype"
name=3D"/sys/devices/pci0000:00/ACPI0003:00/power_supply/AC0/online"
pid=3D4839 comm=3D"skypeforlinux" requested_mask=3D"r" denied_mask=3D"r"
fsuid=3D1000 ouid=3D0
2024-11-16T22:14:11.069247+08:00 sundtek-UX32VD kernel: usb 3-2: new
full-speed USB device number 66 using xhci_hcd
2024-11-16T22:14:11.069347+08:00 sundtek-UX32VD kernel: usb 3-2: Device
not responding to setup address.
2024-11-16T22:14:11.273256+08:00 sundtek-UX32VD kernel: usb 3-2: Device
not responding to setup address.
2024-11-16T22:14:12.122162+08:00 sundtek-UX32VD kernel: usb 3-2: device
not accepting address 66, error -71
2024-11-16T22:14:12.122196+08:00 sundtek-UX32VD kernel: BUG: kernel
NULL pointer dereference, address: 0000000000000020
2024-11-16T22:14:12.122203+08:00 sundtek-UX32VD kernel: #PF: supervisor
read access in kernel mode
2024-11-16T22:14:12.122206+08:00 sundtek-UX32VD kernel: #PF:
error_code(0x0000) - not-present page
2024-11-16T22:14:12.122210+08:00 sundtek-UX32VD kernel: PGD 0 P4D 0=20
2024-11-16T22:14:12.122214+08:00 sundtek-UX32VD kernel: Oops: 0000 [#1]
PREEMPT SMP PTI
2024-11-16T22:14:12.122216+08:00 sundtek-UX32VD kernel: CPU: 2 PID:
15600 Comm: kworker/2:1 Not tainted 6.8.0-48-generic #48-Ubuntu
2024-11-16T22:14:12.122219+08:00 sundtek-UX32VD kernel: Hardware name:
ASUSTeK COMPUTER INC. UX32VD/UX32VD, BIOS UX32VD.214 01/29/2013
2024-11-16T22:14:12.122221+08:00 sundtek-UX32VD kernel: Workqueue:
usb_hub_wq hub_event
2024-11-16T22:14:12.122224+08:00 sundtek-UX32VD kernel: RIP:
0010:xhci_check_bw_table+0x100/0x4d0
2024-11-16T22:14:12.122227+08:00 sundtek-UX32VD kernel: Code: c7 c2 60
35 70 9f 48 c7 c6 70 aa 79 9e 4c 89 55 c0 4c 89 5d d0 e8 d0 c7 01 00 4c
8b 5d d0 4c 8b 55 c0 4c 8b 4d b8 41 8d 47 ff <41> 8b 4a 20 31 d2 45 8b
72 08 89 45 d0 41 03 02 41 f7 f7 ba 80 00
2024-11-16T22:14:12.122231+08:00 sundtek-UX32VD kernel: RSP:
0018:ffffc3774ebeb758 EFLAGS: 00010046
2024-11-16T22:14:12.122234+08:00 sundtek-UX32VD kernel: RAX:
0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
2024-11-16T22:14:12.122236+08:00 sundtek-UX32VD kernel: RDX:
0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
2024-11-16T22:14:12.122239+08:00 sundtek-UX32VD kernel: RBP:
ffffc3774ebeb7c0 R08: 0000000000000000 R09: ffff9fcad3566000
2024-11-16T22:14:12.122242+08:00 sundtek-UX32VD kernel: R10:
0000000000000000 R11: ffff9fc9cc687260 R12: ffffc37741131000
2024-11-16T22:14:12.122245+08:00 sundtek-UX32VD kernel: R13:
0000000000000000 R14: ffff9fcad3566000 R15: 0000000000000001
2024-11-16T22:14:12.122247+08:00 sundtek-UX32VD kernel: FS:=20
0000000000000000(0000) GS:ffff9fcb65700000(0000) knlGS:0000000000000000
2024-11-16T22:14:12.122250+08:00 sundtek-UX32VD kernel: CS:  0010 DS:
0000 ES: 0000 CR0: 0000000080050033
2024-11-16T22:14:12.122252+08:00 sundtek-UX32VD kernel: CR2:
0000000000000020 CR3: 000000021c23c005 CR4: 00000000001706f0
2024-11-16T22:14:12.122254+08:00 sundtek-UX32VD kernel: Call Trace:
2024-11-16T22:14:12.122257+08:00 sundtek-UX32VD kernel:  <TASK>
2024-11-16T22:14:12.122259+08:00 sundtek-UX32VD kernel:  ?
show_regs+0x6d/0x80
2024-11-16T22:14:12.122261+08:00 sundtek-UX32VD kernel:  ?
__die+0x24/0x80
2024-11-16T22:14:12.122263+08:00 sundtek-UX32VD kernel:  ?
page_fault_oops+0x99/0x1b0
2024-11-16T22:14:12.122265+08:00 sundtek-UX32VD kernel:  ?
kernelmode_fixup_or_oops.isra.0+0x69/0x90
2024-11-16T22:14:12.122267+08:00 sundtek-UX32VD kernel:  ?
__bad_area_nosemaphore+0x19d/0x2c0
2024-11-16T22:14:12.122269+08:00 sundtek-UX32VD kernel:  ?
update_sg_lb_stats+0x97/0x5c0
2024-11-16T22:14:12.122271+08:00 sundtek-UX32VD kernel:  ?
bad_area_nosemaphore+0x16/0x30
2024-11-16T22:14:12.122273+08:00 sundtek-UX32VD kernel:  ?
do_user_addr_fault+0x29c/0x670
2024-11-16T22:14:12.122275+08:00 sundtek-UX32VD kernel:  ?
exc_page_fault+0x83/0x1b0
2024-11-16T22:14:12.122276+08:00 sundtek-UX32VD kernel:  ?
asm_exc_page_fault+0x27/0x30
2024-11-16T22:14:12.122279+08:00 sundtek-UX32VD kernel:  ?
xhci_check_bw_table+0x100/0x4d0
2024-11-16T22:14:12.122281+08:00 sundtek-UX32VD kernel:  ?
xhci_check_bw_table+0x357/0x4d0
2024-11-16T22:14:12.122283+08:00 sundtek-UX32VD kernel:=20
xhci_reserve_bandwidth+0x298/0xb20
2024-11-16T22:14:12.122286+08:00 sundtek-UX32VD kernel:  ?
update_load_avg+0x82/0x850
2024-11-16T22:14:12.122288+08:00 sundtek-UX32VD kernel:=20
xhci_configure_endpoint+0xa8/0x730
2024-11-16T22:14:12.122291+08:00 sundtek-UX32VD kernel:=20
xhci_check_ep0_maxpacket.isra.0+0x14e/0x1d0
2024-11-16T22:14:12.122293+08:00 sundtek-UX32VD kernel:=20
xhci_endpoint_reset+0x254/0x4a0
2024-11-16T22:14:12.122295+08:00 sundtek-UX32VD kernel:  ?
_raw_spin_lock_irqsave+0xe/0x20
2024-11-16T22:14:12.122298+08:00 sundtek-UX32VD kernel:=20
usb_hcd_reset_endpoint+0x28/0xa0
2024-11-16T22:14:12.122300+08:00 sundtek-UX32VD kernel:=20
usb_enable_endpoint+0x8c/0xa0
2024-11-16T22:14:12.122302+08:00 sundtek-UX32VD kernel:=20
hub_port_connect+0x176/0xb70
2024-11-16T22:14:12.122305+08:00 sundtek-UX32VD kernel:=20
hub_port_connect_change+0x88/0x2b0
2024-11-16T22:14:12.122307+08:00 sundtek-UX32VD kernel:=20
port_event+0x651/0x810
2024-11-16T22:14:12.122309+08:00 sundtek-UX32VD kernel:=20
hub_event+0x14a/0x450
2024-11-16T22:14:12.122311+08:00 sundtek-UX32VD kernel:=20
process_one_work+0x178/0x350
2024-11-16T22:14:12.122313+08:00 sundtek-UX32VD kernel:=20
worker_thread+0x306/0x440
2024-11-16T22:14:12.122316+08:00 sundtek-UX32VD kernel:  ?
_raw_spin_lock_irqsave+0xe/0x20
2024-11-16T22:14:12.122318+08:00 sundtek-UX32VD kernel:  ?
__pfx_worker_thread+0x10/0x10
2024-11-16T22:14:12.122321+08:00 sundtek-UX32VD kernel:=20
kthread+0xf2/0x120
2024-11-16T22:14:12.122323+08:00 sundtek-UX32VD kernel:  ?
__pfx_kthread+0x10/0x10
2024-11-16T22:14:12.122325+08:00 sundtek-UX32VD kernel:=20
ret_from_fork+0x47/0x70
2024-11-16T22:14:12.122327+08:00 sundtek-UX32VD kernel:  ?
__pfx_kthread+0x10/0x10
2024-11-16T22:14:12.122329+08:00 sundtek-UX32VD kernel:=20
ret_from_fork_asm+0x1b/0x30
2024-11-16T22:14:12.122331+08:00 sundtek-UX32VD kernel:  </TASK>
2024-11-16T22:14:12.122334+08:00 sundtek-UX32VD kernel: Modules linked
in: cpuid ufs qnx4 hfsplus hfs minix ntfs msdos jfs nls_ucs2_utils xfs
usbtest rfcomm snd_seq_dummy snd_hrtimer qrtr uhid hid cmac algif_hash
algif_skcipher af_alg bnep sunrpc snd_hda_codec_hdmi intel_rapl_msr
intel_rapl_common binfmt_misc snd_hda_codec_realtek
x86_pkg_temp_thermal snd_hda_codec_generic intel_powerclamp coretemp
kvm_intel snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi uvcvideo
snd_hda_codec kvm videobuf2_vmalloc snd_hda_core uvc btusb snd_hwdep
irqbypass videobuf2_memops snd_pcm btrtl videobuf2_v4l2 iwldvm
rtsx_usb_ms btintel videodev btbcm rapl btmtk at24 mei_pxp mei_hdcp
memstick nls_iso8859_1 mac80211 asus_nb_wmi videobuf2_common mfd_aaeon
libarc4 mc i915 snd_seq_midi bluetooth snd_seq_midi_event snd_rawmidi
intel_cstate asus_wmi iwlwifi ledtrig_audio ecdh_generic sparse_keymap
platform_profile i2c_i801 ecc mxm_wmi drm_buddy wmi_bmof snd_seq
i2c_smbus cfg80211 ttm snd_seq_device snd_timer drm_display_helper snd
acpi_als mei_me cec soundcore
2024-11-16T22:14:12.122337+08:00 sundtek-UX32VD kernel:=20
industrialio_triggered_buffer rc_core lpc_ich mei i2c_algo_bit
int3400_thermal kfifo_buf int3402_thermal industrialio int3403_thermal
acpi_thermal_rel asus_wireless int340x_thermal_zone joydev input_leds
mac_hid serio_raw sch_fq_codel msr parport_pc ppdev lp parport
efi_pstore nfnetlink dmi_sysfs ip_tables x_tables autofs4 btrfs
blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 rtsx_usb_sdmmc
rtsx_usb crct10dif_pclmul crc32_pclmul polyval_clmulni polyval_generic
ghash_clmulni_intel sha256_ssse3 sha1_ssse3 video psmouse ahci xhci_pci
libahci xhci_pci_renesas wmi aesni_intel crypto_simd cryptd
2024-11-16T22:14:12.122340+08:00 sundtek-UX32VD kernel: CR2:
0000000000000020
2024-11-16T22:14:12.122342+08:00 sundtek-UX32VD kernel: ---[ end trace
0000000000000000 ]---
2024-11-16T22:14:12.122344+08:00 sundtek-UX32VD kernel: RIP:
0010:xhci_check_bw_table+0x100/0x4d0
2024-11-16T22:14:12.122346+08:00 sundtek-UX32VD kernel: Code: c7 c2 60
35 70 9f 48 c7 c6 70 aa 79 9e 4c 89 55 c0 4c 89 5d d0 e8 d0 c7 01 00 4c
8b 5d d0 4c 8b 55 c0 4c 8b 4d b8 41 8d 47 ff <41> 8b 4a 20 31 d2 45 8b
72 08 89 45 d0 41 03 02 41 f7 f7 ba 80 00
2024-11-16T22:14:12.122349+08:00 sundtek-UX32VD kernel: RSP:
0018:ffffc3774ebeb758 EFLAGS: 00010046
2024-11-16T22:14:12.122352+08:00 sundtek-UX32VD kernel: RAX:
0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
2024-11-16T22:14:12.122355+08:00 sundtek-UX32VD kernel: RDX:
0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
2024-11-16T22:14:12.122357+08:00 sundtek-UX32VD kernel: RBP:
ffffc3774ebeb7c0 R08: 0000000000000000 R09: ffff9fcad3566000
2024-11-16T22:14:12.122359+08:00 sundtek-UX32VD kernel: R10:
0000000000000000 R11: ffff9fc9cc687260 R12: ffffc37741131000
2024-11-16T22:14:12.122361+08:00 sundtek-UX32VD kernel: R13:
0000000000000000 R14: ffff9fcad3566000 R15: 0000000000000001
2024-11-16T22:14:12.122363+08:00 sundtek-UX32VD kernel: FS:=20
0000000000000000(0000) GS:ffff9fcb65700000(0000) knlGS:0000000000000000
2024-11-16T22:14:12.122366+08:00 sundtek-UX32VD kernel: CS:  0010 DS:
0000 ES: 0000 CR0: 0000000080050033
2024-11-16T22:14:12.122368+08:00 sundtek-UX32VD kernel: CR2:
0000000000000020 CR3: 000000011ffde004 CR4: 00000000001706f0
2024-11-16T22:14:12.122371+08:00 sundtek-UX32VD kernel: note:
kworker/2:1[15600] exited with irqs disabled
2024-11-16T22:14:12.122373+08:00 sundtek-UX32VD kernel: note:
kworker/2:1[15600] exited with preempt_count 1


This patch diff --git a/drivers/usb/host/xhci.c
b/drivers/usb/host/xhci.c
index 899c0effb5d3..f054e262176c 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -2380,6 +2380,17 @@ static int xhci_check_bw_table(struct xhci_hcd
*xhci,
 	}
=20
 	bw_table =3D virt_dev->bw_table;
+
+	/* second line of defense, this should not happen if bw_table
+       is not initialized this calculation should not be called
+       any issue with bw_table is supposed to be handled earlier
+	*/
+	if (bw_table =3D=3D NULL) {
+		xhci_warn(xhci, "bw_table =3D=3D NULL, this should not
happen\n"
+				"please report\n");
+		return -ENOMEM;
+	}
+
 	/* We need to translate the max packet size and max ESIT
payloads into
 	 * the units the hardware uses.
 	 */


--=-uhUJ2fBZmepiOIZViUqL
Content-Disposition: attachment; filename="xhci_bwtable_check.diff"
Content-Type: text/x-patch; name="xhci_bwtable_check.diff"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS5jIGIvZHJpdmVycy91c2IvaG9zdC94
aGNpLmMKaW5kZXggODk5YzBlZmZiNWQzLi5mMDU0ZTI2MjE3NmMgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvdXNiL2hvc3QveGhjaS5jCisrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS5jCkBAIC0yMzgw
LDYgKzIzODAsMTcgQEAgc3RhdGljIGludCB4aGNpX2NoZWNrX2J3X3RhYmxlKHN0cnVjdCB4aGNp
X2hjZCAqeGhjaSwKIAl9CiAKIAlid190YWJsZSA9IHZpcnRfZGV2LT5id190YWJsZTsKKworCS8q
IHNlY29uZCBsaW5lIG9mIGRlZmVuc2UsIHRoaXMgc2hvdWxkIG5vdCBoYXBwZW4gaWYgYndfdGFi
bGUKKyAgICAgICBpcyBub3QgaW5pdGlhbGl6ZWQgdGhpcyBjYWxjdWxhdGlvbiBzaG91bGQgbm90
IGJlIGNhbGxlZAorICAgICAgIGFueSBpc3N1ZSB3aXRoIGJ3X3RhYmxlIGlzIHN1cHBvc2VkIHRv
IGJlIGhhbmRsZWQgZWFybGllcgorCSovCisJaWYgKGJ3X3RhYmxlID09IE5VTEwpIHsKKwkJeGhj
aV93YXJuKHhoY2ksICJid190YWJsZSA9PSBOVUxMLCB0aGlzIHNob3VsZCBub3QgaGFwcGVuXG4i
CisJCQkJInBsZWFzZSByZXBvcnRcbiIpOworCQlyZXR1cm4gLUVOT01FTTsKKwl9CisKIAkvKiBX
ZSBuZWVkIHRvIHRyYW5zbGF0ZSB0aGUgbWF4IHBhY2tldCBzaXplIGFuZCBtYXggRVNJVCBwYXls
b2FkcyBpbnRvCiAJICogdGhlIHVuaXRzIHRoZSBoYXJkd2FyZSB1c2VzLgogCSAqLwo=


--=-uhUJ2fBZmepiOIZViUqL--

