Return-Path: <linux-kernel+bounces-298517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4025595C851
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B5228422B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC91145B05;
	Fri, 23 Aug 2024 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="uz1y3bzG"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCC432C85
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724402636; cv=none; b=ndSU7RuliCq4/eErLlj7eFfrpkEd/LCzYravAFtVBe+fCJA+4pp89xAnOKZwYUYJCA5asUUQMCxvAQCdmeE9yqhl625JHGi31ZauS0irb85QR+aKNQBkBcKA+1Q4tfbu4kmBaToKdgtjGQ8yL5wojk9DSbtYgNd85OeT6fI0VO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724402636; c=relaxed/simple;
	bh=8J8JJovoPIpl/Gb8l8xbXZGLrNayQD7fptptkg4ozBE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K8sWAppP6FzNMojXsnTESyjppFP88lK9tJmJZRwWLpF4RFllxLalS5vRx/Gz+2jzeXSyBDpIu0Br8f/s7r2tyvILtX0EAoLIJXrQCkgjEYgJxP1Xa9c3zno74dSDjI+Mo5P3v8txu+zUzaiTXL/U6r/Jhbl00N27meErP6GWlGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=uz1y3bzG; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1724402593; x=1725007393; i=spasswolf@web.de;
	bh=3y3L5djLa4xTRbpB2wAQil77rg1iRvJ4SBipeOZOuOw=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uz1y3bzGShD6KEAOrfyNy/cRe4Or0YWj95IzS1fGUZMATRgIXM3qT4Y61tv5IFKY
	 oROADtl8IgVioL/Bs4YG0ko6sc//DQyNS9d3CY/sulodj7JP7if7t7JtLmpQ4JnNn
	 VA1k8mID+F1s+cbobXmllifKHYMkXXyJvy1nakGlpClbXp48b6Fd0sFygfinLjDJu
	 kBN13xusGGBgkx89bA26RVme4SgJMVOfkT1C4QEBaLVlevCcuUkfB5FW/i5OMRnZb
	 oJn2Tkc29wWlSeRqGWR0WpLS/j4JQ9gE1EqFoQd0YdoMAse0GVufsl1NfQ/LvXoeh
	 Ch0T/2bNHv4n83AhrQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MfKtb-1sBNzm0lSN-00fv99; Fri, 23
 Aug 2024 10:43:13 +0200
Message-ID: <b88f105afcd7d96a5306126c51ec236274780bac.camel@web.de>
Subject: Re: [PATCH v7 06/21] mm/vma: Change munmap to use
 vma_munmap_struct() for accounting and surrounding vmas
From: Bert Karwatzki <spasswolf@web.de>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matthew Wilcox
 <willy@infradead.org>, Vlastimil Babka	 <vbabka@suse.cz>,
 sidhartha.kumar@oracle.com, Jiri Olsa <olsajiri@gmail.com>,  Kees Cook
 <kees@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>,
 spasswolf@web.de
Date: Fri, 23 Aug 2024 10:43:11 +0200
In-Reply-To: <20240822192543.3359552-7-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
			 <20240822192543.3359552-7-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A5kiJHoYNWGFpzGQ+IDER1atQqN21m/kQ1l2XDKBhHHEXVgihwl
 jaCxftqL07fIMhT8z7FzGdG9FOYFVYBNHSYuzVsyoG8+TJlaU2WScgehoXfR+OT8yRgu66m
 pD/8VQQoEbXT/jbzAtbY8cfDAncnlje1kvdlDXoVuXQHQ5wrIS2YU5oGY09vRQgj7zH1pZD
 IyMTZiEp0kf93Hkisrj8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:70/EzBxz0wA=;NqlFMzso3aLoi6Rc+8DSpBYY+ut
 zgU11qG+9puQAxbPPQI0OP2GyBi5zOuSe42LeJlDMv+p41xhet4n5Aq9t9ybw6IE79ZvNnEDN
 h+V2d3Sd5pUYH6xGmSR0up0h9Y6VLyc1cUyXs4c0WAbw5YstpgDz1YKjso2a95vxNnWtkcP04
 9+c251V0U+3yvhk1pBQsPlLizpeSOrAAo/08b9zFHPp6XGgqtoYOkwAvNw0f/P/oTpvrOoV+5
 eEUdned1TNjmjxVWGY5dvfh644O/AIKUzuXTu+9g3SXX241OWHrHKXTTXr7GegbRDbksaWrjT
 xid4KgAMrVpojmWnMxI6TUKdZM9ERiuF2y8q05sheQ93/Ld3Zs9MPwEJjNubsNKbGTrc+z4QE
 KajUZh0BlJzZKs0wREDpbHzYJpsI1UGzs+K2a/Q4YN2tVoDWxlepBKvJeEldoDxQTYegoKKzF
 O5u1kNS8Y6B1351f30O48D0ttB+aUjICouoK+933zLYACReZnMkBX0SXUazt2ojkRTkB8cvM+
 +Q2bs4sF/707w774lqGA9koC+i+L/wGdlOFd0Ci2URMaTgWrT528XYAqscq2oBP1HUUnFwRhF
 zNFdJ/LJhphRHdXugVqOK/IN9N61t++fuhX5Al/IZ6AWFXU3zi7Ft5lnpO5iUlD1Kge48abQK
 QopRmPOV0hHNqeXkFjQm15kvsNZOfi+ENQEsIH4dE5I+9tJ55rFdsmOOUH64SJwXr0fV7G2Tm
 HIWkf0li6iNWhtP+7B6AbllnFzMaepy1/gXAFZPSJa6Am1tcZxRDFn0X929kArPWmk/E9tueS
 OgVzPw2o6JhX6K8SyavFprJA==

Am Donnerstag, dem 22.08.2024 um 15:25 -0400 schrieb Liam R. Howlett:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Clean up the code by changing the munmap operation to use a structure
> for the accounting and munmap variables.
>
> Since remove_mt() is only called in one location and the contents will
> be reduced to almost nothing.  The remains of the function can be added
> to vms_complete_munmap_vmas().
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/vma.c | 83 +++++++++++++++++++++++++++++---------------------------
>  mm/vma.h |  6 ++++
>  2 files changed, 49 insertions(+), 40 deletions(-)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index e1aee43a3dc4..58604fe3bd03 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -103,7 +103,8 @@ static inline void init_vma_munmap(struct vma_munmap=
_struct *vms,
>  	vms->unlock =3D unlock;
>  	vms->uf =3D uf;
>  	vms->vma_count =3D 0;
> -	vms->nr_pages =3D vms->locked_vm =3D 0;
> +	vms->nr_pages =3D vms->locked_vm =3D vms->nr_accounted =3D 0;
> +	vms->exec_vm =3D vms->stack_vm =3D vms->data_vm =3D 0;
>  }
>
>  /*
> @@ -299,30 +300,6 @@ static int split_vma(struct vma_iterator *vmi, stru=
ct vm_area_struct *vma,
>  	return __split_vma(vmi, vma, addr, new_below);
>  }
>
> -/*
> - * Ok - we have the memory areas we should free on a maple tree so rele=
ase them,
> - * and do the vma updates.
> - *
> - * Called with the mm semaphore held.
> - */
> -static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas=
)
> -{
> -	unsigned long nr_accounted =3D 0;
> -	struct vm_area_struct *vma;
> -
> -	/* Update high watermark before we lower total_vm */
> -	update_hiwater_vm(mm);
> -	mas_for_each(mas, vma, ULONG_MAX) {
> -		long nrpages =3D vma_pages(vma);
> -
> -		if (vma->vm_flags & VM_ACCOUNT)
> -			nr_accounted +=3D nrpages;
> -		vm_stat_account(mm, vma->vm_flags, -nrpages);
> -		remove_vma(vma, false);
> -	}
> -	vm_unacct_memory(nr_accounted);
> -}
> -
>  /*
>   * init_vma_prep() - Initializer wrapper for vma_prepare struct
>   * @vp: The vma_prepare struct
> @@ -722,7 +699,7 @@ static inline void abort_munmap_vmas(struct ma_state=
 *mas_detach)
>  static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
>  		struct ma_state *mas_detach)
>  {
> -	struct vm_area_struct *prev, *next;
> +	struct vm_area_struct *vma;
>  	struct mm_struct *mm;
>
>  	mm =3D vms->mm;
> @@ -731,21 +708,31 @@ static void vms_complete_munmap_vmas(struct vma_mu=
nmap_struct *vms,
>  	if (vms->unlock)
>  		mmap_write_downgrade(mm);
>
> -	prev =3D vma_iter_prev_range(vms->vmi);
> -	next =3D vma_next(vms->vmi);
> -	if (next)
> -		vma_iter_prev_range(vms->vmi);
> -
>  	/*
>  	 * We can free page tables without write-locking mmap_lock because VMA=
s
>  	 * were isolated before we downgraded mmap_lock.
>  	 */
>  	mas_set(mas_detach, 1);
> -	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->en=
d,
> -		     vms->vma_count, !vms->unlock);
> -	/* Statistics and freeing VMAs */
> +	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
> +		     vms->start, vms->end, vms->vma_count, !vms->unlock);
> +	/* Update high watermark before we lower total_vm */
> +	update_hiwater_vm(mm);
> +	/* Stat accounting */
> +	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm) - vms->nr_pages);
> +	mm->exec_vm -=3D vms->exec_vm;
> +	mm->stack_vm -=3D vms->stack_vm;
> +	mm->data_vm -=3D vms->data_vm;
> +	/* Paranoid bookkeeping */
> +	VM_WARN_ON(vms->exec_vm > mm->exec_vm);
> +	VM_WARN_ON(vms->stack_vm > mm->stack_vm);
> +	VM_WARN_ON(vms->data_vm > mm->data_vm);
> +

I'm running the v7 Patchset on linux-next-20240822 and I get lots of these
errors (right on boot) (both when using the complete patchset and when usi=
ng
only the patches up to this):

[  T620] WARNING: CPU: 6 PID: 620 at mm/vma.c:725
vms_complete_munmap_vmas+0x1d8/0x200
[  T620] Modules linked in: amd_atl ecc mc sparse_keymap wmi_bmof edac_mce=
_amd
snd snd_pci_acp3x k10temp soundcore ccp battery ac button hid_sensor_gyro_=
3d
hid_sensor_als hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d
hid_sensor_trigger industrialio_triggered_buffer kfifo_buf industrialio am=
d_pmc
hid_sensor_iio_common joydev evdev serio_raw mt7921e mt7921_common mt792x_=
lib
mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr nvme_fabrics fus=
e
efi_pstore configfs efivarfs autofs4 ext4 crc32c_generic mbcache jbd2 usbh=
id
amdgpu i2c_algo_bit drm_ttm_helper ttm drm_exec drm_suballoc_helper amdxcp
xhci_pci drm_buddy hid_sensor_hub xhci_hcd nvme mfd_core gpu_sched
hid_multitouch hid_generic crc32c_intel psmouse usbcore i2c_piix4
drm_display_helper amd_sfh i2c_hid_acpi i2c_smbus usb_common crc16 nvme_co=
re
r8169 i2c_hid hid i2c_designware_platform i2c_designware_core
[  T620] CPU: 6 UID: 0 PID: 620 Comm: fsck.vfat Not tainted 6.11.0-rc4-nex=
t-
20240822-liamh-v7-00021-gc6686c81601f #322
[  T620] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/=
MS-
158L, BIOS E158LAMS.107 11/10/2021
[  T620] RIP: 0010:vms_complete_munmap_vmas+0x1d8/0x200
[  T620] Code: 8b 85 a8 00 00 00 a8 01 74 35 8b 85 e0 00 00 00 48 8d bd a8=
 00 00
00 83 c0 01 89 85 e0 00 00 00 e8 7d 39 e8 ff e9 63 fe ff ff <0f> 0b e9 eb =
fe ff
ff 0f 0b e9 d0 fe ff ff 0f 0b e9 d3 fe ff ff 0f
[  T620] RSP: 0018:ffffa415c09d7d10 EFLAGS: 00010283
[  T620] RAX: 00000000000000cd RBX: ffffa415c09d7d90 RCX: 000000000000018e
[  T620] RDX: 0000000000000021 RSI: 00000000000019d9 RDI: ffff9073ee7a6400
[  T620] RBP: ffff906541341f80 R08: 0000000000000000 R09: 000000000000080a
[  T620] R10: 000000000001d4de R11: 0000000000000140 R12: ffffa415c09d7d48
[  T620] R13: 00007fbd5ea5f000 R14: 00007fbd5eb5efff R15: ffffa415c09d7d90
[  T620] FS:  00007fbd5ec38740(0000) GS:ffff9073ee780000(0000)
knlGS:0000000000000000
[  T620] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  T620] CR2: 00007fc336339c90 CR3: 000000010a39e000 CR4: 0000000000750ef0
[  T620] PKRU: 55555554
[  T620] Call Trace:
[  T620]  <TASK>
[  T620]  ? __warn.cold+0x90/0x9e
[  T620]  ? vms_complete_munmap_vmas+0x1d8/0x200
[  T620]  ? report_bug+0xfa/0x140
[  T620]  ? handle_bug+0x53/0x90
[  T620]  ? exc_invalid_op+0x17/0x70
[  T620]  ? asm_exc_invalid_op+0x1a/0x20
[  T620]  ? vms_complete_munmap_vmas+0x1d8/0x200
[  T620]  do_vmi_align_munmap+0x1e0/0x260
[  T620]  do_vmi_munmap+0xbe/0x160
[  T620]  __vm_munmap+0x96/0x110
[  T620]  __x64_sys_munmap+0x16/0x20
[  T620]  do_syscall_64+0x5f/0x170
[  T620]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
[  T620] RIP: 0033:0x7fbd5ed3ec57
[  T620] Code: 73 01 c3 48 8b 0d c1 71 0d 00 f7 d8 64 89 01 48 83 c8 ff c3=
 66 2e
0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 =
ff ff
73 01 c3 48 8b 0d 91 71 0d 00 f7 d8 64 89 01 48
[  T620] RSP: 002b:00007fff0b04d298 EFLAGS: 00000202 ORIG_RAX: 00000000000=
0000b
[  T620] RAX: ffffffffffffffda RBX: ffffffffffffff88 RCX: 00007fbd5ed3ec57
[  T620] RDX: 0000000000000000 RSI: 0000000000100000 RDI: 00007fbd5ea5f000
[  T620] RBP: 0000000000000002 R08: 0000000000100000 R09: 0000000000000007
[  T620] R10: 0000000000000007 R11: 0000000000000202 R12: 00007fff0b04d588
[  T620] R13: 000055b76c789fc6 R14: 00007fff0b04d360 R15: 00007fff0b04d3c0
[  T620]  </TASK>
[  T620] ---[ end trace 0000000000000000 ]---


Bert Karwatzki

