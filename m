Return-Path: <linux-kernel+bounces-298725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3436C95CAAD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B571C21506
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3170185B78;
	Fri, 23 Aug 2024 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="moNxNpsV"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31B3185B68
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724409787; cv=none; b=r3ckLv6fTLbvRt0Pl5gqBYwfCcdVwBsJrfWFZTq0UYSpPDCwylWlA4L7k04JeRop+hGFfVzYTkJvbkOAyjVuddjv965cqWHhWGob/YCKdBXZ+8jzpK4933rpH4KJWYpNSWC9kZGk4Ep+yfSyFd8LyNCBR7cDelw+2x2Pw0giLN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724409787; c=relaxed/simple;
	bh=ezDvtsnb1fCiehUl9OcgK+Ft+WLzN1m/y7ZIj8vskKg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=khw8wiH9r6jEZPHpj77F26pujs/fdp5WuTKyxeUR73WkoMdpTc3tP3gV16hxiHCZZmX5OtxN/lhtpc38hC61x62vHdEatvOAcv+wIuDeFHUteX2bvsbsXdPmSEFhS0mQfHrlS0wzG/F0Ii9vLwdnsDNxGLpIz8aGMw9JZu6yWGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=moNxNpsV; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1724409745; x=1725014545; i=spasswolf@web.de;
	bh=igxhEwgSxBzEedNNPkDTJ4aJdxNqW1BPko8ULMBx508=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=moNxNpsVa6w4CZNiHjkty7nFi+VB6NL2qAhlOOWgaJDvTWJ5uim3uu0i0Rz+H+Jg
	 PPStqo6SbXkPWkKGvUVR+GRL0v21sfkyttfPmwpDkmJZhLLoML/bRYRAYVmstcOd7
	 3xcIznuJ694vpUPePsnRUxrI3eQ3gdupr0oV67cwjCHFCYUxzpjUxvFPcsrVPJT6a
	 3wjvlpFruysAI3RelMeeBCpldbXj3kDdvFjEL6Lktr7UEu3BYZ6jdL+orTh3llPPG
	 9mDlMkKMdXPLsJwiCTtvI8fv6FL4QVK60rhJ02Jlx15emXBbI5U4PaIvqnDXs4poU
	 8uB/rSuDphmWO1eCgg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MV2OY-1saBi32yIg-00RvVF; Fri, 23
 Aug 2024 12:42:25 +0200
Message-ID: <ab9edc828156be187042cbfdba41a52f23d19f79.camel@web.de>
Subject: Re: [PATCH v7 06/21] mm/vma: Change munmap to use
 vma_munmap_struct() for accounting and surrounding vmas
From: Bert Karwatzki <spasswolf@web.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton	
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,  Suren Baghdasaryan	 <surenb@google.com>,
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka	 <vbabka@suse.cz>,
 sidhartha.kumar@oracle.com, Jiri Olsa <olsajiri@gmail.com>,  Kees Cook
 <kees@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>,
 spasswolf@web.de
Date: Fri, 23 Aug 2024 12:42:18 +0200
In-Reply-To: <f22f7367-db42-47e2-b702-06a13d41e97e@lucifer.local>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
	 <20240822192543.3359552-7-Liam.Howlett@oracle.com>
	 <b88f105afcd7d96a5306126c51ec236274780bac.camel@web.de>
	 <f22f7367-db42-47e2-b702-06a13d41e97e@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nUg7kFS/DrCni/Ie0nmmZhuxORLmiobxqU10m18B+EaC/2n5cJj
 UljyQMKeyPyls/p+o02eeSRaZIp0vk4ErWqJn70mtqyLK8dcoJncDPSwdS31sfSM0Tt/QJ8
 3IGSPzeTeA1rg2LO//9+W1p1RMJwPnprY5S0M5aiu3Sj4DrM7t2rxt92CRxek8/c0QMKkpq
 laNpmz4ztLt5L70Wv3XYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JBgQltixLKo=;mNvsrVqfQ4hs8DCQiQ0oIIpJq3f
 6FQI5a7gkuK38psw1Uh8W9iBkYHJyiSmcXX00crVEShL2SVkpmyHrX/j2J878nEdCmdM22B5A
 w22Gq60LQ+HJdT00waJHuAmfoRqSx6j8q/8Eo5CNnfZNeY+DE0JqUVMaOv+bciOfKXd6F5e/D
 IxNLG6a4JStbRAw3hp7CzZxhyl/sRDdgNntePKG3qlS/RESkdp9WZqRMM3m2QLOABpNSvFkGF
 bhUXoYg6J2hrD2msoatOFdxpBySTXjRHtuYqzM/f5s0gEmtWQo2dteRxogLIxPleH/FTGxfAV
 ZpKCGiDisA53mT5oiZs06KTiU9M7cEZ+5llcw3P/f+HCnAjJ9TbMHcvo8Y0cReJrjbOqIvMAg
 Zgw4CLSfje69aDOJlLJjOhhT+TL9C/QhPMsbnRVMFoV6Y94waLHTWt7wtqUh+k8VQIGLgQWB6
 WoObDeQajIuGPGR84VdA+YXGpGnOdcH21sBfTB+sU4HXDQ7spGLHCeCEYPqMXFrM0KWdM05DM
 TrjTOT5JLCL6lEWb2dHnluQ980EvWSUdZQN1NGfBcnzve9cO5xBSAXOKbutBVhD32TxFp2QGk
 q31QzrSC3VL5ckVgs/ARwdQw4J3WWYNHu7JVVZ8ITVxgo2JzYDtpF/Gn4JYhH230pBFoTq3WL
 AyXXfXwXEsn4xJ91w/M/D+U4lal7N5B/pthcBoJD70vUVI4pi+ND/jbl3kEsjyZyHWQDxtyIS
 S2qvt0YmIOZ2PiPCInpivMtWu98qycUMdeCnAwO0mJz07deTCvUZ9esv2mXHj1O1Ml6oz7Our
 vMmHgMe4q9oGW7fDRkcAe/fQ==

Am Freitag, dem 23.08.2024 um 10:55 +0100 schrieb Lorenzo Stoakes:
> On Fri, Aug 23, 2024 at 10:43:11AM GMT, Bert Karwatzki wrote:
>
> [snip]
>
> > > @@ -731,21 +708,31 @@ static void vms_complete_munmap_vmas(struct vm=
a_munmap_struct *vms,
> > >  	if (vms->unlock)
> > >  		mmap_write_downgrade(mm);
> > >
> > > -	prev =3D vma_iter_prev_range(vms->vmi);
> > > -	next =3D vma_next(vms->vmi);
> > > -	if (next)
> > > -		vma_iter_prev_range(vms->vmi);
> > > -
> > >  	/*
> > >  	 * We can free page tables without write-locking mmap_lock because=
 VMAs
> > >  	 * were isolated before we downgraded mmap_lock.
> > >  	 */
> > >  	mas_set(mas_detach, 1);
> > > -	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms=
->end,
> > > -		     vms->vma_count, !vms->unlock);
> > > -	/* Statistics and freeing VMAs */
> > > +	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
> > > +		     vms->start, vms->end, vms->vma_count, !vms->unlock);
> > > +	/* Update high watermark before we lower total_vm */
> > > +	update_hiwater_vm(mm);
> > > +	/* Stat accounting */
> > > +	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm) - vms->nr_pages);
> > > +	mm->exec_vm -=3D vms->exec_vm;
> > > +	mm->stack_vm -=3D vms->stack_vm;
> > > +	mm->data_vm -=3D vms->data_vm;
> > > +	/* Paranoid bookkeeping */
> > > +	VM_WARN_ON(vms->exec_vm > mm->exec_vm);
> > > +	VM_WARN_ON(vms->stack_vm > mm->stack_vm);
> > > +	VM_WARN_ON(vms->data_vm > mm->data_vm);
> > > +
> >
> > I'm running the v7 Patchset on linux-next-20240822 and I get lots of t=
hese
> > errors (right on boot) (both when using the complete patchset and when=
 using
> > only the patches up to this):
>
> Hm curious, I'm running this in qemu with CONFIG_DEBUG_VM set and don't =
see
> this at lesat on next-20240823.
>
> Liam's series is based on the mseal series by Pedro, not sure if that wa=
sn't in
> 22 somehow?
>
> Can you try with 23, from tip and:
>
>     b4 shazam 20240822192543.3359552-1-Liam.Howlett@oracle.com
>
> To grab this series just to be sure?
>
> Because that'd definitely be very weird + concerning and something we ha=
dn't
> seen before (I don't think?) for the mm->data_vm to be incorrect...
>
> >
> > [  T620] WARNING: CPU: 6 PID: 620 at mm/vma.c:725
> > vms_complete_munmap_vmas+0x1d8/0x200
> > [  T620] Modules linked in: amd_atl ecc mc sparse_keymap wmi_bmof edac=
_mce_amd
> > snd snd_pci_acp3x k10temp soundcore ccp battery ac button hid_sensor_g=
yro_3d
> > hid_sensor_als hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d
> > hid_sensor_trigger industrialio_triggered_buffer kfifo_buf industriali=
o amd_pmc
> > hid_sensor_iio_common joydev evdev serio_raw mt7921e mt7921_common mt7=
92x_lib
> > mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr nvme_fabrics=
 fuse
> > efi_pstore configfs efivarfs autofs4 ext4 crc32c_generic mbcache jbd2 =
usbhid
> > amdgpu i2c_algo_bit drm_ttm_helper ttm drm_exec drm_suballoc_helper am=
dxcp
> > xhci_pci drm_buddy hid_sensor_hub xhci_hcd nvme mfd_core gpu_sched
> > hid_multitouch hid_generic crc32c_intel psmouse usbcore i2c_piix4
> > drm_display_helper amd_sfh i2c_hid_acpi i2c_smbus usb_common crc16 nvm=
e_core
> > r8169 i2c_hid hid i2c_designware_platform i2c_designware_core
> > [  T620] CPU: 6 UID: 0 PID: 620 Comm: fsck.vfat Not tainted 6.11.0-rc4=
-next-
> > 20240822-liamh-v7-00021-gc6686c81601f #322
> > [  T620] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5=
EEK/MS-
> > 158L, BIOS E158LAMS.107 11/10/2021
> > [  T620] RIP: 0010:vms_complete_munmap_vmas+0x1d8/0x200
> > [  T620] Code: 8b 85 a8 00 00 00 a8 01 74 35 8b 85 e0 00 00 00 48 8d b=
d a8 00 00
> > 00 83 c0 01 89 85 e0 00 00 00 e8 7d 39 e8 ff e9 63 fe ff ff <0f> 0b e9=
 eb fe ff
> > ff 0f 0b e9 d0 fe ff ff 0f 0b e9 d3 fe ff ff 0f
> > [  T620] RSP: 0018:ffffa415c09d7d10 EFLAGS: 00010283
> > [  T620] RAX: 00000000000000cd RBX: ffffa415c09d7d90 RCX: 000000000000=
018e
> > [  T620] RDX: 0000000000000021 RSI: 00000000000019d9 RDI: ffff9073ee7a=
6400
> > [  T620] RBP: ffff906541341f80 R08: 0000000000000000 R09: 000000000000=
080a
> > [  T620] R10: 000000000001d4de R11: 0000000000000140 R12: ffffa415c09d=
7d48
> > [  T620] R13: 00007fbd5ea5f000 R14: 00007fbd5eb5efff R15: ffffa415c09d=
7d90
> > [  T620] FS:  00007fbd5ec38740(0000) GS:ffff9073ee780000(0000)
> > knlGS:0000000000000000
> > [  T620] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  T620] CR2: 00007fc336339c90 CR3: 000000010a39e000 CR4: 000000000075=
0ef0
> > [  T620] PKRU: 55555554
> > [  T620] Call Trace:
> > [  T620]  <TASK>
> > [  T620]  ? __warn.cold+0x90/0x9e
> > [  T620]  ? vms_complete_munmap_vmas+0x1d8/0x200
> > [  T620]  ? report_bug+0xfa/0x140
> > [  T620]  ? handle_bug+0x53/0x90
> > [  T620]  ? exc_invalid_op+0x17/0x70
> > [  T620]  ? asm_exc_invalid_op+0x1a/0x20
> > [  T620]  ? vms_complete_munmap_vmas+0x1d8/0x200
> > [  T620]  do_vmi_align_munmap+0x1e0/0x260
> > [  T620]  do_vmi_munmap+0xbe/0x160
> > [  T620]  __vm_munmap+0x96/0x110
> > [  T620]  __x64_sys_munmap+0x16/0x20
> > [  T620]  do_syscall_64+0x5f/0x170
> > [  T620]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
> > [  T620] RIP: 0033:0x7fbd5ed3ec57
> > [  T620] Code: 73 01 c3 48 8b 0d c1 71 0d 00 f7 d8 64 89 01 48 83 c8 f=
f c3 66 2e
> > 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 0b 00 00 00 0f 05 <48> 3d 01=
 f0 ff ff
> > 73 01 c3 48 8b 0d 91 71 0d 00 f7 d8 64 89 01 48
> > [  T620] RSP: 002b:00007fff0b04d298 EFLAGS: 00000202 ORIG_RAX: 0000000=
00000000b
> > [  T620] RAX: ffffffffffffffda RBX: ffffffffffffff88 RCX: 00007fbd5ed3=
ec57
> > [  T620] RDX: 0000000000000000 RSI: 0000000000100000 RDI: 00007fbd5ea5=
f000
> > [  T620] RBP: 0000000000000002 R08: 0000000000100000 R09: 000000000000=
0007
> > [  T620] R10: 0000000000000007 R11: 0000000000000202 R12: 00007fff0b04=
d588
> > [  T620] R13: 000055b76c789fc6 R14: 00007fff0b04d360 R15: 00007fff0b04=
d3c0
> > [  T620]  </TASK>
> > [  T620] ---[ end trace 0000000000000000 ]---
> >
> >
> > Bert Karwatzki

I grabbed the patches by saving the v7 patch emails as an mbox file and us=
ing
git am to apply them (which worked without error) and git pull --rebase to
update the series to next-20240823 (which works without conflicts).

$ git log HEAD~22..HEAD --oneline
a060ce2752a8 (HEAD -> liamh_mmap_v7) mm/vma.h: Optimise vma_munmap_struct
62fdaa7f747c mm/vma: Drop incorrect comment from vms_gather_munmap_vmas()
8606e70278c5 mm: Move may_expand_vm() check in mmap_region()
fada0fd73e66 ipc/shm, mm: Drop do_vma_munmap()
bc57e24e2564 mm/mmap: Use vms accounted pages in mmap_region()
26f203f001eb mm/mmap: Use PHYS_PFN in mmap_region()
efe56a49d0ef mm: Change failure of MAP_FIXED to restoring the gap on failu=
re
494d21bcde64 mm/mmap: Avoid zeroing vma tree in mmap_region()
ff688d8cec39 mm: Clean up unmap_region() argument list
862b919b20a4 mm/vma: Track start and end for munmap in vma_munmap_struct
f406d75d8787 mm/mmap: Reposition vma iterator in mmap_region()
6548fe69d672 mm/vma: Support vma =3D=3D NULL in init_vma_munmap()
2ff31a2341d2 mm/vma: Expand mmap_region() munmap call
7806ca6562c5 mm/vma: Inline munmap operation in mmap_region()
b9659761b35e mm/vma: Extract validate_mm() from vma_complete()
48fde0bebb75 mm/vma: Change munmap to use vma_munmap_struct() for accounti=
ng and
surrounding vmas
7bb7a27044f0 mm/vma: Introduce vma_munmap_struct for use in munmap operati=
ons
3b4885e2e6b2 mm/vma: Extract the gathering of vmas from do_vmi_align_munma=
p()
427cdb242d36 mm/vma: Introduce vmi_complete_munmap_vmas()
5035f0d0c68b mm/vma: Introduce abort_munmap_vmas()
717dcbdf7521 mm/vma: Correctly position vma_iterator in __split_vma()
c79c85875f1a (tag: next-20240823, origin/master, origin/HEAD) Add linux-ne=
xt
specific files for 20240823

Here's a short extract from dmesg (the buffer has already overrun)

[  206.641849] [   T3201] ------------[ cut here ]------------
[  206.641852] [   T3201] WARNING: CPU: 7 PID: 3201 at mm/vma.c:725
vms_complete_munmap_vmas+0x1d8/0x200
[  206.641859] [   T3201] Modules linked in: ccm snd_seq_dummy snd_hrtimer
snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device rfcomm
cpufreq_userspace cpufreq_powersave cpufreq_conservative bnep nls_ascii
nls_cp437 vfat fat snd_ctl_led btusb btrtl snd_hda_codec_realtek btintel b=
tbcm
snd_hda_codec_generic btmtk snd_hda_scodec_component snd_hda_codec_hdmi
snd_hda_intel snd_intel_dspcfg bluetooth amd_atl uvcvideo snd_hda_codec
videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn uvc snd_hwde=
p
videobuf2_memops snd_soc_core snd_hda_core videobuf2_v4l2 snd_pcm_oss
snd_mixer_oss snd_rn_pci_acp3x videodev snd_acp_config videobuf2_common
snd_soc_acpi snd_pcm msi_wmi ecdh_generic ecc mc edac_mce_amd sparse_keyma=
p
wmi_bmof snd_timer snd_pci_acp3x snd k10temp soundcore ccp ac battery butt=
on
hid_sensor_gyro_3d hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d
hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf
industrialio amd_pmc hid_sensor_iio_common joydev evdev serio_raw mt7921e
[  206.641927] [   T3201]  mt7921_common mt792x_lib mt76_connac_lib mt76
mac80211 libarc4 cfg80211 rfkill msr nvme_fabrics fuse efi_pstore configfs
efivarfs autofs4 ext4 crc32c_generic mbcache jbd2 usbhid amdgpu i2c_algo_b=
it
drm_ttm_helper xhci_pci ttm drm_exec drm_suballoc_helper xhci_hcd amdxcp
drm_buddy hid_sensor_hub usbcore i2c_piix4 nvme mfd_core gpu_sched
hid_multitouch hid_generic crc32c_intel psmouse i2c_hid_acpi i2c_smbus
usb_common amd_sfh drm_display_helper nvme_core i2c_hid crc16 r8169 hid
i2c_designware_platform i2c_designware_core
[  206.641971] [   T3201] CPU: 7 UID: 0 PID: 3201 Comm: apt-get Tainted: G
W          6.11.0-rc4-next-20240823-liamh-v7-00021-ga060ce2752a8 #325
[  206.641974] [   T3201] Tainted: [W]=3DWARN
[  206.641976] [   T3201] Hardware name: Micro-Star International Co., Ltd=
.
Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021
[  206.641977] [   T3201] RIP: 0010:vms_complete_munmap_vmas+0x1d8/0x200
[  206.641980] [   T3201] Code: 8b 85 a8 00 00 00 a8 01 74 35 8b 85 e0 00 =
00 00
48 8d bd a8 00 00 00 83 c0 01 89 85 e0 00 00 00 e8 3d 43 e8 ff e9 63 fe ff=
 ff
<0f> 0b e9 eb fe ff ff 0f 0b e9 d0 fe ff ff 0f 0b e9 d3 fe ff ff 0f
[  206.641982] [   T3201] RSP: 0018:ffffb05784eb7d10 EFLAGS: 00010287
[  206.641984] [   T3201] RAX: 000000000000015d RBX: ffffb05784eb7d90 RCX:
000000000000087b
[  206.641986] [   T3201] RDX: 0000000000000021 RSI: 00000000000007e2 RDI:
ffff9f56ae7e63c0
[  206.641987] [   T3201] RBP: ffff9f48030a0540 R08: 0000000000000000 R09:
000000000000070d
[  206.641988] [   T3201] R10: 000000000001d4de R11: 0000000000000048 R12:
ffffb05784eb7d48
[  206.641990] [   T3201] R13: 00007f2017000000 R14: 00007f201dbc9fff R15:
ffffb05784eb7d90
[  206.641991] [   T3201] FS:  00007f201e88d880(0000) GS:ffff9f56ae7c0000(=
0000)
knlGS:0000000000000000
[  206.641993] [   T3201] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[  206.641994] [   T3201] CR2: 000055cfbbc10000 CR3: 00000001813b8000 CR4:
0000000000750ef0
[  206.641995] [   T3201] PKRU: 55555554
[  206.641996] [   T3201] Call Trace:
[  206.641998] [   T3201]  <TASK>
[  206.642001] [   T3201]  ? __warn.cold+0x90/0x9e
[  206.642004] [   T3201]  ? vms_complete_munmap_vmas+0x1d8/0x200
[  206.642007] [   T3201]  ? report_bug+0xfa/0x140
[  206.642010] [   T3201]  ? handle_bug+0x53/0x90
[  206.642012] [   T3201]  ? exc_invalid_op+0x17/0x70
[  206.642014] [   T3201]  ? asm_exc_invalid_op+0x1a/0x20
[  206.642018] [   T3201]  ? vms_complete_munmap_vmas+0x1d8/0x200
[  206.642021] [   T3201]  do_vmi_align_munmap+0x1e0/0x260
[  206.642025] [   T3201]  do_vmi_munmap+0xbe/0x160
[  206.642028] [   T3201]  __vm_munmap+0x96/0x110
[  206.642032] [   T3201]  __x64_sys_munmap+0x16/0x20
[  206.642034] [   T3201]  do_syscall_64+0x5f/0x170
[  206.642037] [   T3201]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
[  206.642040] [   T3201] RIP: 0033:0x7f201e519c57
[  206.642042] [   T3201] Code: 73 01 c3 48 8b 0d c1 71 0d 00 f7 d8 64 89 =
01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 0b 00 00 00 0f=
 05
<48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 91 71 0d 00 f7 d8 64 89 01 48
[  206.642044] [   T3201] RSP: 002b:00007ffd2e02c5f8 EFLAGS: 00000246 ORIG=
_RAX:
000000000000000b
[  206.642046] [   T3201] RAX: ffffffffffffffda RBX: 000055cfbbc554f0 RCX:
00007f201e519c57
[  206.642047] [   T3201] RDX: 0000000000000004 RSI: 0000000006bc97c1 RDI:
00007f2017000000
[  206.642048] [   T3201] RBP: 0000000000000000 R08: 0000000000000005 R09:
0000000000000004
[  206.642049] [   T3201] R10: 0000000000000007 R11: 0000000000000246 R12:
000055cfbbc54160
[  206.642050] [   T3201] R13: 000055cfbbbeb198 R14: 000055cfbbc554f0 R15:
00007ffd2e02c6c0
[  206.642053] [   T3201]  </TASK>
[  206.642054] [   T3201] ---[ end trace 0000000000000000 ]---
[  206.659454] [   T3201] ------------[ cut here ]------------
[  206.659458] [   T3201] WARNING: CPU: 7 PID: 3201 at mm/vma.c:725
vms_complete_munmap_vmas+0x1d8/0x200
[  206.659465] [   T3201] Modules linked in: ccm snd_seq_dummy snd_hrtimer
snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device rfcomm
cpufreq_userspace cpufreq_powersave cpufreq_conservative bnep nls_ascii
nls_cp437 vfat fat snd_ctl_led btusb btrtl snd_hda_codec_realtek btintel b=
tbcm
snd_hda_codec_generic btmtk snd_hda_scodec_component snd_hda_codec_hdmi
snd_hda_intel snd_intel_dspcfg bluetooth amd_atl uvcvideo snd_hda_codec
videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn uvc snd_hwde=
p
videobuf2_memops snd_soc_core snd_hda_core videobuf2_v4l2 snd_pcm_oss
snd_mixer_oss snd_rn_pci_acp3x videodev snd_acp_config videobuf2_common
snd_soc_acpi snd_pcm msi_wmi ecdh_generic ecc mc edac_mce_amd sparse_keyma=
p
wmi_bmof snd_timer snd_pci_acp3x snd k10temp soundcore ccp ac battery butt=
on
hid_sensor_gyro_3d hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d
hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf
industrialio amd_pmc hid_sensor_iio_common joydev evdev serio_raw mt7921e
[  206.659530] [   T3201]  mt7921_common mt792x_lib mt76_connac_lib mt76
mac80211 libarc4 cfg80211 rfkill msr nvme_fabrics fuse efi_pstore configfs
efivarfs autofs4 ext4 crc32c_generic mbcache jbd2 usbhid amdgpu i2c_algo_b=
it
drm_ttm_helper xhci_pci ttm drm_exec drm_suballoc_helper xhci_hcd amdxcp
drm_buddy hid_sensor_hub usbcore i2c_piix4 nvme mfd_core gpu_sched
hid_multitouch hid_generic crc32c_intel psmouse i2c_hid_acpi i2c_smbus
usb_common amd_sfh drm_display_helper nvme_core i2c_hid crc16 r8169 hid
i2c_designware_platform i2c_designware_core
[  206.659575] [   T3201] CPU: 7 UID: 0 PID: 3201 Comm: apt-get Tainted: G
W          6.11.0-rc4-next-20240823-liamh-v7-00021-ga060ce2752a8 #325
[  206.659578] [   T3201] Tainted: [W]=3DWARN
[  206.659580] [   T3201] Hardware name: Micro-Star International Co., Ltd=
.
Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021
[  206.659581] [   T3201] RIP: 0010:vms_complete_munmap_vmas+0x1d8/0x200
[  206.659584] [   T3201] Code: 8b 85 a8 00 00 00 a8 01 74 35 8b 85 e0 00 =
00 00
48 8d bd a8 00 00 00 83 c0 01 89 85 e0 00 00 00 e8 3d 43 e8 ff e9 63 fe ff=
 ff
<0f> 0b e9 eb fe ff ff 0f 0b e9 d0 fe ff ff 0f 0b e9 d3 fe ff ff 0f
[  206.659586] [   T3201] RSP: 0018:ffffb05784eb7d10 EFLAGS: 00010283
[  206.659588] [   T3201] RAX: 000000000000015d RBX: ffffb05784eb7d90 RCX:
000000000000087b
[  206.659589] [   T3201] RDX: 0000000000000021 RSI: 0000000000000821 RDI:
ffff9f56ae7e63c0
[  206.659591] [   T3201] RBP: ffff9f48030a0540 R08: 0000000000000000 R09:
00000000000006f2
[  206.659592] [   T3201] R10: 000000000001d4de R11: 0000000000000048 R12:
ffffb05784eb7d48
[  206.659593] [   T3201] R13: 00007f2017000000 R14: 00007f201dbaffff R15:
ffffb05784eb7d90
[  206.659594] [   T3201] FS:  00007f201e88d880(0000) GS:ffff9f56ae7c0000(=
0000)
knlGS:0000000000000000
[  206.659596] [   T3201] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[  206.659597] [   T3201] CR2: 000055cfbbc28288 CR3: 00000001813b8000 CR4:
0000000000750ef0
[  206.659599] [   T3201] PKRU: 55555554
[  206.659600] [   T3201] Call Trace:
[  206.659602] [   T3201]  <TASK>
[  206.659604] [   T3201]  ? __warn.cold+0x90/0x9e
[  206.659607] [   T3201]  ? vms_complete_munmap_vmas+0x1d8/0x200
[  206.659610] [   T3201]  ? report_bug+0xfa/0x140
[  206.659613] [   T3201]  ? handle_bug+0x53/0x90
[  206.659615] [   T3201]  ? exc_invalid_op+0x17/0x70
[  206.659618] [   T3201]  ? asm_exc_invalid_op+0x1a/0x20
[  206.659621] [   T3201]  ? vms_complete_munmap_vmas+0x1d8/0x200
[  206.659624] [   T3201]  do_vmi_align_munmap+0x1e0/0x260
[  206.659628] [   T3201]  do_vmi_munmap+0xbe/0x160
[  206.659631] [   T3201]  __vm_munmap+0x96/0x110
[  206.659635] [   T3201]  __x64_sys_munmap+0x16/0x20
[  206.659637] [   T3201]  do_syscall_64+0x5f/0x170
[  206.659640] [   T3201]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
[  206.659642] [   T3201] RIP: 0033:0x7f201e519c57
[  206.659644] [   T3201] Code: 73 01 c3 48 8b 0d c1 71 0d 00 f7 d8 64 89 =
01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 0b 00 00 00 0f=
 05
<48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 91 71 0d 00 f7 d8 64 89 01 48
[  206.659646] [   T3201] RSP: 002b:00007ffd2e02c5f8 EFLAGS: 00000246 ORIG=
_RAX:
000000000000000b
[  206.659648] [   T3201] RAX: ffffffffffffffda RBX: 000055cfbbbff660 RCX:
00007f201e519c57
[  206.659649] [   T3201] RDX: 0000000000000004 RSI: 0000000006baf09c RDI:
00007f2017000000
[  206.659650] [   T3201] RBP: 0000000000000001 R08: 0000000000000007 R09:
0000000000000006
[  206.659651] [   T3201] R10: 0000000000000007 R11: 0000000000000246 R12:
000055cfbbc60e30
[  206.659652] [   T3201] R13: 0000000000000044 R14: 000055cfbbbff660 R15:
00007ffd2e02c6c0
[  206.659655] [   T3201]  </TASK>
[  206.659656] [   T3201] ---[ end trace 0000000000000000 ]---
[  212.679951] [   T3222] ------------[ cut here ]------------
[  212.679955] [   T3222] WARNING: CPU: 11 PID: 3222 at mm/vma.c:725
vms_complete_munmap_vmas+0x1d8/0x200
[  212.679963] [   T3222] Modules linked in: ccm snd_seq_dummy snd_hrtimer
snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device rfcomm
cpufreq_userspace cpufreq_powersave cpufreq_conservative bnep nls_ascii
nls_cp437 vfat fat snd_ctl_led btusb btrtl snd_hda_codec_realtek btintel b=
tbcm
snd_hda_codec_generic btmtk snd_hda_scodec_component snd_hda_codec_hdmi
snd_hda_intel snd_intel_dspcfg bluetooth amd_atl uvcvideo snd_hda_codec
videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn uvc snd_hwde=
p
videobuf2_memops snd_soc_core snd_hda_core videobuf2_v4l2 snd_pcm_oss
snd_mixer_oss snd_rn_pci_acp3x videodev snd_acp_config videobuf2_common
snd_soc_acpi snd_pcm msi_wmi ecdh_generic ecc mc edac_mce_amd sparse_keyma=
p
wmi_bmof snd_timer snd_pci_acp3x snd k10temp soundcore ccp ac battery butt=
on
hid_sensor_gyro_3d hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d
hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf
industrialio amd_pmc hid_sensor_iio_common joydev evdev serio_raw mt7921e
[  212.680030] [   T3222]  mt7921_common mt792x_lib mt76_connac_lib mt76
mac80211 libarc4 cfg80211 rfkill msr nvme_fabrics fuse efi_pstore configfs
efivarfs autofs4 ext4 crc32c_generic mbcache jbd2 usbhid amdgpu i2c_algo_b=
it
drm_ttm_helper xhci_pci ttm drm_exec drm_suballoc_helper xhci_hcd amdxcp
drm_buddy hid_sensor_hub usbcore i2c_piix4 nvme mfd_core gpu_sched
hid_multitouch hid_generic crc32c_intel psmouse i2c_hid_acpi i2c_smbus
usb_common amd_sfh drm_display_helper nvme_core i2c_hid crc16 r8169 hid
i2c_designware_platform i2c_designware_core
[  212.680071] [   T3222] CPU: 11 UID: 0 PID: 3222 Comm: apt-extracttemp
Tainted: G        W          6.11.0-rc4-next-20240823-liamh-v7-00021-
ga060ce2752a8 #325
[  212.680074] [   T3222] Tainted: [W]=3DWARN
[  212.680076] [   T3222] Hardware name: Micro-Star International Co., Ltd=
.
Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021
[  212.680077] [   T3222] RIP: 0010:vms_complete_munmap_vmas+0x1d8/0x200
[  212.680080] [   T3222] Code: 8b 85 a8 00 00 00 a8 01 74 35 8b 85 e0 00 =
00 00
48 8d bd a8 00 00 00 83 c0 01 89 85 e0 00 00 00 e8 3d 43 e8 ff e9 63 fe ff=
 ff
<0f> 0b e9 eb fe ff ff 0f 0b e9 d0 fe ff ff 0f 0b e9 d3 fe ff ff 0f
[  212.680082] [   T3222] RSP: 0018:ffffb05785b7fd10 EFLAGS: 00010283
[  212.680084] [   T3222] RAX: 000000000000093a RBX: ffffb05785b7fd90 RCX:
0000000000000877
[  212.680085] [   T3222] RDX: 0000000000000021 RSI: 0000000000000ad6 RDI:
ffff9f56ae8e63c0
[  212.680086] [   T3222] RBP: ffff9f4889d178c0 R08: 0000000000000000 R09:
00000000000006a4
[  212.680088] [   T3222] R10: 000000000001d4de R11: 0000000000000048 R12:
ffffb05785b7fd48
[  212.680089] [   T3222] R13: 00007f1474400000 R14: 00007f147afc9fff R15:
ffffb05785b7fd90
[  212.680090] [   T3222] FS:  00007f147bc6e880(0000) GS:ffff9f56ae8c0000(=
0000)
knlGS:0000000000000000
[  212.680092] [   T3222] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[  212.680093] [   T3222] CR2: 0000564415171000 CR3: 0000000223e48000 CR4:
0000000000750ef0
[  212.680094] [   T3222] PKRU: 55555554
[  212.680095] [   T3222] Call Trace:
[  212.680097] [   T3222]  <TASK>
[  212.680100] [   T3222]  ? __warn.cold+0x90/0x9e
[  212.680103] [   T3222]  ? vms_complete_munmap_vmas+0x1d8/0x200
[  212.680106] [   T3222]  ? report_bug+0xfa/0x140
[  212.680109] [   T3222]  ? handle_bug+0x53/0x90
[  212.680111] [   T3222]  ? exc_invalid_op+0x17/0x70
[  212.680113] [   T3222]  ? asm_exc_invalid_op+0x1a/0x20
[  212.680117] [   T3222]  ? vms_complete_munmap_vmas+0x1d8/0x200
[  212.680119] [   T3222]  do_vmi_align_munmap+0x1e0/0x260
[  212.680124] [   T3222]  do_vmi_munmap+0xbe/0x160
[  212.680126] [   T3222]  __vm_munmap+0x96/0x110
[  212.680130] [   T3222]  __x64_sys_munmap+0x16/0x20
[  212.680132] [   T3222]  do_syscall_64+0x5f/0x170
[  212.680135] [   T3222]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
[  212.680137] [   T3222] RIP: 0033:0x7f147b919c57
[  212.680139] [   T3222] Code: 73 01 c3 48 8b 0d c1 71 0d 00 f7 d8 64 89 =
01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 0b 00 00 00 0f=
 05
<48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 91 71 0d 00 f7 d8 64 89 01 48
[  212.680140] [   T3222] RSP: 002b:00007ffc1a6d5ae8 EFLAGS: 00000246 ORIG=
_RAX:
000000000000000b
[  212.680142] [   T3222] RAX: ffffffffffffffda RBX: 00005644150b34a0 RCX:
00007f147b919c57
[  212.680144] [   T3222] RDX: 0000000000000004 RSI: 0000000006bc983b RDI:
00007f1474400000
[  212.680145] [   T3222] RBP: 00007ffc1a6d5d90 R08: 0000000564415156 R09:
0000000000000007
[  212.680146] [   T3222] R10: 0000000000000007 R11: 0000000000000246 R12:
00007ffc1a6d5c40
[  212.680147] [   T3222] R13: 0000000000000011 R14: 0000000000000010 R15:
00007ffc1a6d5bc0
[  212.680150] [   T3222]  </TASK>
[  212.680150] [   T3222] ---[ end trace 0000000000000000 ]---


These messages aside everything seems to work (I sending this email using =
the
affected kernel) so I'm wondering if the checks aren't a little too parano=
id.

By the way: These 6 patches by Pedro Falcato are present in linux-next-202=
40822,
too:

mm: remove can_modify_mm()	Pedro Falcato
mseal: replace can_modify_mm_madv with a vma variant	Pedro Falcato
mm/mremap: replace can_modify_mm with can_modify_vma	Pedro Falcato
mm/mprotect: replace can_modify_mm with can_modify_vma	Pedro Falcato
mm/munmap: replace can_modify_mm with can_modify_vma	Pedro Falcato
mm: move can_modify_vma to mm/vma.h			Pedro Falcato

Bert Karwatzki


