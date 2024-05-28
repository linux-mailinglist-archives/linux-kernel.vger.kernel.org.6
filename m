Return-Path: <linux-kernel+bounces-191795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8906D8D142B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A45EB21C53
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78824E1B3;
	Tue, 28 May 2024 06:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/QUI741"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9631FDF6B
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 06:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716876354; cv=none; b=kUWwb9Zp/uCCOqDEnEhzJxkJTdRBXNvdplE57crUqPMS4gAn9itCCt/BFSwXgutczAT8Cs6sCdpb8W0LprpvkuDxK9SyZzf3KRV0GIOxMsectldO99X52FoGeLgtx5zBOuSKz+eUG1NN8xbKHtbzqKKAsolJ1///hyvdt86yDLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716876354; c=relaxed/simple;
	bh=LK4aIVorUxhjfHB4IO/40AXc58GaNVdgkIX6xbON9Mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tH8XPAq7WVFgP2pfbNeuZWBQlzRRmOtDAnxpP/eTiIE7HzBZgc9tEdG+AtGH9QyMXmCduTVnGSeizjWo/UR/wG4L4U4BeGMWzBVphFKR00dfnL9ALfs3xl93C4opU65r550Kwlqd0tYvDZqP3XH1gUxE3JRcdEitS8jIZzJC4qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/QUI741; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6ab8f69be57so401966d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 23:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716876351; x=1717481151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLFtm7iDX+a6rVpds8FrN2saOZK3oTtjNBWhdje4pfI=;
        b=Q/QUI7410tC5fjQOB+E7bvc9O58VNAIOz/wyNvp4gGH6BS+1Z4Laii3qDIvZ8Lg4Nc
         EeLZ1XUqAWIyD0lI/HHCnCwXW0xerMOBmP4ZR4GlgkSSUemgDLqUEnirnz6aLAjk5eaP
         a7yjR35XqxaQ2LhZGJH1pC3RErBGpCzJZiQRRP9eQQZtdFlHNHQ7qcudT3nzjZ7jFg4q
         Qd6y3vOV1ZTDjzrfCVdLkJv9995OsZ8C5Wp0yiuh3BTf8Dbyvkh8CQPVjPoYmFbd191V
         w9ciIueQcrC+Jjw4Ctatb6mDEVudVOch8Ex8LPtl5ErfC9+mWYAz3/9IOqanap9KVCC3
         ee2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716876351; x=1717481151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLFtm7iDX+a6rVpds8FrN2saOZK3oTtjNBWhdje4pfI=;
        b=rYTM+FPfBjqw39qDYgMAZgUgvMvw7Sfb5ZRd3mBybMQkJpQH0f9oEsSStbipwIliqs
         KC+a0XZRly5MZnwaBbaLBsb2HnaRCE2DnN+X65HrVhotrPorOM9mqsHln41Pg2W5gORV
         eM6t++Jm0uKeVb26QOP3CnRmk+xw0XsbfTDoh8eKu80jIVSwjN/Oczh37l16pHQMt9bf
         lvnIytn+l6jaeOjDHgF/fZ5lS6CMoX9IFF+z9VgNBcEZmP1KbRMQKB/UTP8jwyuC/t8k
         08a8TFhTvoLQkQvM1NcMez2P+nav8RRCr4fmWrtL+WKqvAtPMglsCj4FUzavn3wWDykK
         +zNA==
X-Gm-Message-State: AOJu0YwtCIDxakTzbuS0PsumM3383koKt2AbPIH24UrWPFO/kOcmJZmh
	hDKhnh8cLrnxrPshNgYMdO3VUKzzqzVO/vkFzYMnrXoZ+vaHGvDcczJQxTVePH65Hu/1pAdxaRI
	FOYrV2v6A8YzN+ACrLsX+yIg97EQ=
X-Google-Smtp-Source: AGHT+IF2PA8jXS+bEJ5emheNpUmONCjjSukKcU+Ei1UM2/UjkU9V3pZeMT5KUqfe8OSNiN8sehggaqmqnMTbwBkFOMo=
X-Received: by 2002:a05:6214:2527:b0:6ab:8c3b:9031 with SMTP id
 6a1803df08f44-6abbbc24a30mr118596666d6.1.1716876351137; Mon, 27 May 2024
 23:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsPktcHQOvKTbPaTwegMExije=Gpgci5NW=hqORo-s7diA@mail.gmail.com>
 <CABXGCsOC2Ji7y5Qfsa33QXQ37T3vzdNPsivGoMHcVnCGFi5vKg@mail.gmail.com>
 <0672f0b7-36f5-4322-80e6-2da0f24c101b@redhat.com> <CABXGCsN7LBynNk_XzaFm2eVkryVQ26BSzFkrxC2Zb5GEwTvc1g@mail.gmail.com>
 <6b42ad9a-1f15-439a-8a42-34052fec017e@redhat.com> <CABXGCsP46xvu3C3Ntd=k5ARrYScAea1gj+YmKYqO+Yj7u3xu1Q@mail.gmail.com>
In-Reply-To: <CABXGCsP46xvu3C3Ntd=k5ARrYScAea1gj+YmKYqO+Yj7u3xu1Q@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 28 May 2024 11:05:40 +0500
Message-ID: <CABXGCsP3Yf2g6e7pSi71pbKpm+r1LdGyF5V7KaXbQjNyR9C_Rw@mail.gmail.com>
Subject: Re: 6.9/BUG: Bad page state in process kswapd0 pfn:d6e840
To: David Hildenbrand <david@redhat.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 12:05=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Thu, May 9, 2024 at 10:50=E2=80=AFPM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > Do you have the other stracktrace as well?
> >
> > Maybe triggering memory reclaim (e.g., using "stress" or "memhog") coul=
d
> > trigger it, that might be reasonable to trey. Once we have a reproducer
> > we could at least bisect.
> >
>
> The only known workload that causes this is updating a large
> container. Unfortunately, not every container update reproduces the
> problem.

Is it possible to add more debugging information to make it clearer
what's going on?

BUG: Bad page state in process kcompactd0  pfn:605811
page: refcount:0 mapcount:0 mapping:0000000082d91e3e index:0x1045efc4f
pfn:0x605811
aops:btree_aops ino:1
flags: 0x17ffffc600020c(referenced|uptodate|workingset|node=3D0|zone=3D2|la=
stcpupid=3D0x1fffff)
raw: 0017ffffc600020c dead000000000100 dead000000000122 ffff888159075220
raw: 00000001045efc4f 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: overlay tun uvcvideo uvc videobuf2_vmalloc
videobuf2_memops videobuf2_v4l2 videobuf2_common videodev rndis_host
uas cdc_ether usbnet usb_storage mii uinput rfcomm snd_seq_dummy
snd_hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables qrtr bnep
sunrpc binfmt_misc snd_usb_audio snd_usbmidi_lib snd_ump snd_rawmidi
mc mt76x2u snd_hda_codec_hdmi mt76x2_common mt7921e mt76x02_usb
mt7921_common mt76_usb mt792x_lib snd_hda_intel intel_rapl_msr amd_atl
snd_intel_dspcfg mt76_connac_lib mt76x02_lib intel_rapl_common
snd_intel_sdw_acpi btusb snd_hda_codec mt76 btrtl edac_mce_amd btintel
snd_hda_core btbcm vfat btmtk snd_hwdep mac80211 fat snd_seq bluetooth
snd_seq_device kvm_amd eeepc_wmi asus_nb_wmi libarc4 joydev
ledtrig_netdev hid_apple snd_pcm kvm asus_wmi cfg80211
apple_mfi_fastcharge snd_timer
 sparse_keymap platform_profile pcspkr wmi_bmof snd rapl rfkill
soundcore igc k10temp i2c_piix4 gpio_amdpt gpio_generic loop nfnetlink
zram amdgpu crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
polyval_generic amdxcp i2c_algo_bit drm_ttm_helper ttm drm_exec
ghash_clmulni_intel gpu_sched sha512_ssse3 nvme drm_suballoc_helper
drm_buddy sha256_ssse3 nvme_core sha1_ssse3 drm_display_helper ccp
sp5100_tco video nvme_auth wmi ip6_tables ip_tables fuse
CPU: 17 PID: 221 Comm: kcompactd0 Tainted: G        W    L    -------
---  6.10.0-0.rc1.18.fc41.x86_64+debug #1
Hardware name: ASUS System Product Name/ROG STRIX B650E-I GAMING WIFI,
BIOS 2611 04/07/2024
Call Trace:
 <TASK>
 dump_stack_lvl+0x84/0xd0
 bad_page.cold+0xbe/0xe0
 ? __pfx_bad_page+0x10/0x10
 ? page_bad_reason+0x9d/0x1f0
 free_unref_page+0x838/0x10e0
 __folio_put+0x1ba/0x2b0
 ? __pfx___folio_put+0x10/0x10
 ? __pfx___might_resched+0x10/0x10
 ? migrate_folio_done+0x1de/0x2b0
 migrate_pages_batch+0xe73/0x2880
 ? __pfx_compaction_alloc+0x10/0x10
 ? __pfx_compaction_free+0x10/0x10
 ? __pfx_migrate_pages_batch+0x10/0x10
 ? trace_irq_enable.constprop.0+0xce/0x110
 ? __pfx_remove_migration_pte+0x10/0x10
 ? rcu_is_watching+0x12/0xc0
 migrate_pages+0x194f/0x22f0
 ? __pfx_compaction_alloc+0x10/0x10
 ? __pfx_compaction_free+0x10/0x10
 ? __pfx_migrate_pages+0x10/0x10
 ? trace_irq_enable.constprop.0+0xce/0x110
 ? rcu_is_watching+0x12/0xc0
 ? isolate_migratepages_block+0x2b02/0x4560
 ? __pfx_isolate_migratepages_block+0x10/0x10
 ? __pfx___might_resched+0x10/0x10
 compact_zone+0x1a7c/0x3860
 ? rcu_is_watching+0x12/0xc0
 ? __pfx___free_object+0x10/0x10
 ? __pfx_compact_zone+0x10/0x10
 ? rcu_is_watching+0x12/0xc0
 ? lock_acquire+0x457/0x540
 ? kcompactd+0x2fa/0xc70
 ? rcu_is_watching+0x12/0xc0
 compact_node+0x144/0x240
 ? __pfx_compact_node+0x10/0x10
 ? rcu_is_watching+0x12/0xc0
 kcompactd+0x686/0xc70
 ? __pfx_kcompactd+0x10/0x10
 ? __pfx_autoremove_wake_function+0x10/0x10
 ? __kthread_parkme+0xb1/0x1d0
 ? __pfx_kcompactd+0x10/0x10
 ? __pfx_kcompactd+0x10/0x10
 kthread+0x2d2/0x3a0
 ? _raw_spin_unlock_irq+0x28/0x60
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x31/0x70
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

--=20
Best Regards,
Mike Gavrilov.

