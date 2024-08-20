Return-Path: <linux-kernel+bounces-293559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52399958152
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E651F25195
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BE118A6D1;
	Tue, 20 Aug 2024 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5OnvxZG"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE92C15534B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143681; cv=none; b=RbpqdIuG7olfWB9n6hKRkR+DUI98i2VTt1E8uYAwvAAIBawywhopj1gvD8ZoobnrgGN7JlluhVoHDKwQI8FowQpt6BbGFMvkwwGhoUXWDjxGNBk12JY7ETserj2uo+2V3dGYdqxKcZpOYmklGiUPRuBwPP+8PEjkPozrGTIk3aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143681; c=relaxed/simple;
	bh=00wl0nkd07OknIyfJ2N//nkqCT6W5z1A8tsOpMYLcuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWLyGYUV0S5YnSTUml/c4hfGLP4UTmwy+Ji0CnQ3SEFiH4d6Yg4SBGOWXteaQwgPlhGS5vVlrIIlh5k9HZJTgkBqjPAf7zpRXgpAP+a6qhhOegxDXwRv3D/NrMinH961ujXhUG8/mG8mn6dNkWC8/mDIpR+kjO5AfKh2ldx1phg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5OnvxZG; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f0271b0ae9so64299961fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724143678; x=1724748478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qXpflYNT5XpQOIvf3DmgQ5O9cWtK4wyjnX6n23eJHks=;
        b=S5OnvxZG3V7BMdjD5zGxJk6s7bi8HjgwuSrmq7KE02QS4zX9SIdIKH3N3C6YZ7L6gH
         rgOsE6LSnH6pNBshnOsoJCjm6LWCI/fBdr45c5bFNLDrGG9C2OLaKoBvY9Lr992DuuZH
         DcIFlm6fbLcG2Svr4WKKOHM4HYJyANewzTsuMNehLObZii5Y8e5+GTcZ6NkCMzkiefxm
         0BncBfp2Ocr/6pyFs4tD2SNT1xCelrQfK5ngeDP2S3WwOuhij16/LDQ+uH4fjKX/PwAS
         mnhCUltIOe8CCUV7xIvuZcQnf2zKgwb3MLOA4ImnUi38fZ0CLkNh92yxH/tVQXgh6b+E
         2Kow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724143678; x=1724748478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXpflYNT5XpQOIvf3DmgQ5O9cWtK4wyjnX6n23eJHks=;
        b=p9fuXm8d9zct2JBEmvZAZc30RnFNnCjEAfNqUy/w5xlzXLSYiaesbLZKzUuThMlY6Z
         mmN9ANS3yrS1n8F8+E3RrlMHPwqLzM4RLr96o7Jx3RaPlOsupKbma7J5FVPTzTX/Yes6
         7AKQMDD8A9yN+abtSpYi4QqJxv0gnx2Zgyk3A5xJMAthQoBpuDlULVswvo42q7h7pfux
         TnSZbXaMmFFPVbojVwSsbtNTiO6XdiNB5K3haWBRS5EtFj/SOdX+nJjg3EcIgRwqzxf9
         LOUR+yEqqI7jCth+EIypnUuqjnIh40buGSleShUSCYaiF1CxUzNuJGrS4MKGAEKf3lW/
         yPqw==
X-Forwarded-Encrypted: i=1; AJvYcCUcPq2JejwjrnRG9jdVPTpair5deT3PohTV8GRhtU6UW4q5yd7nvYaYuogGpqSNdPGfOKGRR4jvY2EvocZlE0Xj9M5wg2C6Y0hr37GK
X-Gm-Message-State: AOJu0Yywep/aawKBVU5FUEOxpNb7DFrtj7g4iHQ8RaPbc0PrwqEWi/Ux
	jwSMLcxcXNgd9iHwW4uukWm2UIWsd4fVgNF4y0QevWM2zaHceRvynX/+aeCRFB6BPnhNQmIr8Gw
	pnLX+YrJfIKgj2x/FXqsn5LRQGdY=
X-Google-Smtp-Source: AGHT+IE7iYPj7x4Hx3ouqLLIAKXJcRs4joy4slu2AqtYASi/eHNM4XfQtbLYyKHoRZISSfQiqSLUTi0gUzC4fp+iG8U=
X-Received: by 2002:a05:651c:a0a:b0:2f3:cbc3:b093 with SMTP id
 38308e7fff4ca-2f3cf4caf48mr61950241fa.43.1724143677342; Tue, 20 Aug 2024
 01:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000060cf79061fd24ca8@google.com> <CAJD7tkYWMkcFeXKA2S71PoZAubS+0R29G5qbhTSLLCcd7DfqkQ@mail.gmail.com>
In-Reply-To: <CAJD7tkYWMkcFeXKA2S71PoZAubS+0R29G5qbhTSLLCcd7DfqkQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 20 Aug 2024 16:47:40 +0800
Message-ID: <CAMgjq7CaCEZN2hf5pPR4N6BLzUEiMAA7Ax+G_nv4CyHVukxCNw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in zswap_swapoff
To: Yosry Ahmed <yosryahmed@google.com>, Barry Song <21cnbao@gmail.com>
Cc: syzbot <syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	syzkaller-bugs@googlegroups.com, Chris Li <chrisl@kernel.org>, 
	Ying <ying.huang@intel.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: multipart/mixed; boundary="0000000000006e2a9e0620197bb4"

--0000000000006e2a9e0620197bb4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 4:13=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
> On Fri, Aug 16, 2024 at 12:52=E2=80=AFPM syzbot
> <syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    367b5c3d53e5 Add linux-next specific files for 20240816

I can't find this commit, seems this commit is not in linux-next any more?

> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D12489105980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D61ba6f3b22e=
e5467
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dce6029250d7fd=
4d0476d
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/0b1b4e3cad3c/d=
isk-367b5c3d.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/5bb090f7813c/vmli=
nux-367b5c3d.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/6674cb0709b1=
/bzImage-367b5c3d.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 11298 at mm/zswap.c:1700 zswap_swapoff+0x11b/0x2b0=
 mm/zswap.c:1700
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 11298 Comm: swapoff Not tainted 6.11.0-rc3-next-2024=
0816-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 06/27/2024
> > RIP: 0010:zswap_swapoff+0x11b/0x2b0 mm/zswap.c:1700
> > Code: 74 05 e8 78 73 07 00 4b 83 7c 35 00 00 75 15 e8 1b bd 9e ff 48 ff=
 c5 49 83 c6 50 83 7c 24 0c 17 76 9b eb 24 e8 06 bd 9e ff 90 <0f> 0b 90 eb =
e5 48 8b 0c 24 80 e1 07 80 c1 03 38 c1 7c 90 48 8b 3c
> > RSP: 0018:ffffc9000302fa38 EFLAGS: 00010293
> > RAX: ffffffff81f4d66a RBX: dffffc0000000000 RCX: ffff88802c19bc00
> > RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff888015986248
> > RBP: 0000000000000000 R08: ffffffff81f4d620 R09: 1ffffffff1d476ac
> > R10: dffffc0000000000 R11: fffffbfff1d476ad R12: dffffc0000000000
> > R13: ffff888015986200 R14: 0000000000000048 R15: 0000000000000002
> > FS:  00007f9e628a5380(0000) GS:ffff8880b9000000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000001b30f15ff8 CR3: 000000006c5f0000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  __do_sys_swapoff mm/swapfile.c:2837 [inline]
> >  __se_sys_swapoff+0x4653/0x4cf0 mm/swapfile.c:2706
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f9e629feb37
> > Code: 73 01 c3 48 8b 0d f1 52 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e=
 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a8 00 00 00 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 8b 0d c1 52 0d 00 f7 d8 64 89 01 48
> > RSP: 002b:00007fff17734f68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a8
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9e629feb37
> > RDX: 00007f9e62a9e7e8 RSI: 00007f9e62b9beed RDI: 0000563090942a20
> > RBP: 0000563090942a20 R08: 0000000000000000 R09: 77872e07ed164f94
> > R10: 000000000000001f R11: 0000000000000246 R12: 00007fff17735188
> > R13: 00005630909422a0 R14: 0000563073724169 R15: 00007f9e62bdda80
> >  </TASK>
>
> I am hoping syzbot would find a reproducer and bisect this for us.
> Meanwhile, from a high-level it looks to me like we are missing a
> zswap_invalidate() call in some paths.
>
> If I have to guess, I would say it's related to the latest mTHP swap
> changes, but I am not following closely. Perhaps one of the following
> things happened:
>
> (1) We are not calling zswap_invalidate() in some invalidation paths.
> It used to not be called for the cluster freeing path, so maybe we end
> up with some order-0 swap entries in a cluster? or maybe there is an
> entirely new invalidation path that does not go through
> free_swap_slot() for order-0 entries?
>
> (2) Some higher order swap entries (i.e. a cluster) end up in zswap
> somehow. zswap_store() has a warning to cover that though. Maybe
> somehow some swap entries are allocated as a cluster, but then pages
> are swapped out one-by-one as order-0 (which can go to zswap), but
> then we still free the swap entries as a cluster?

Hi Yosry, thanks for the report.

There are many mTHP related optimizations recently, for this problem I
can reproduce this locally. Can confirm the problem is gone for me
after reverting:

"mm: attempt to batch free swap entries for zap_pte_range()"

Hi Barry,

If a set of continuous slots are having the same value, they are
considered a mTHP and freed, bypassing the slot cache, and causing
zswap leak.
This didn't happen in put_swap_folio because that function is
expecting an actual mTHP folio behind the slots but
free_swap_and_cache_nr is simply walking the slots.

For the testing, I actually have to disable mTHP, because linux-next
will panic with mTHP due to lack of following fixes:
https://lore.kernel.org/linux-mm/a4b1b34f-0d8c-490d-ab00-eaedbf3fe780@gmail=
.com/
https://lore.kernel.org/linux-mm/403b7f3c-6e5b-4030-ab1c-3198f36e3f73@gmail=
.com/

>
> I am not closely following the latest changes so I am not sure. CCing
> folks who have done work in that area recently.
>
> I am starting to think maybe it would be more reliable to just call
> zswap_invalidate() for all freed swap entries anyway. Would that be
> too expensive? We used to do that before the zswap_invalidate() call
> was moved by commit 0827a1fb143f ("mm/zswap: invalidate zswap entry
> when swap entry free"), and that was before we started using the
> xarray (so it was arguably worse than it would be now).
>

That might be a good idea, I suggest moving zswap_invalidate to
swap_range_free and call it for every freed slot.

Below patch can be squash into or put before "mm: attempt to batch
free swap entries for zap_pte_range()".

--0000000000006e2a9e0620197bb4
Content-Type: application/octet-stream; 
	name="0001-mm-swap-sanitize-zswap-invalidating.patch"
Content-Disposition: attachment; 
	filename="0001-mm-swap-sanitize-zswap-invalidating.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m026an5b0>
X-Attachment-Id: f_m026an5b0

RnJvbSA3ZTA3NzM2ZGViOTU1YjZmZTEzOTBlM2M2Nzc1MWRhNzc3OTZiNjYwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlydWkgU29uZyA8a2Fzb25nQHRlbmNlbnQuY29tPgpEYXRl
OiBUdWUsIDIwIEF1ZyAyMDI0IDE2OjE5OjQ1ICswODAwClN1YmplY3Q6IFtQQVRDSF0gbW06IHN3
YXA6IHNhbml0aXplIHpzd2FwIGludmFsaWRhdGluZwoKRnJvbTogS2FpcnVpIFNvbmcgPHJ5bmNz
bkBnbWFpbC5jb20+CgpaU1dBUCBkb2Vzbid0IHN1cHBvcnQgbVRIUC9USFAgeWV0LCBzbyB3ZSBh
cmUgb25seSBpbnZhbGlkYXRpbmcgb3JkZXIgMAplbnRyaWVzLiBCdXQgdGhpbmcgd2lsbCBjaGFu
Z2Ugc29vbiwgc28gY2FsbCB0aGUgaW52YWxpZGF0aW9uIGZvciBldmVyeQpzbG90IHRoYXQgYXJl
IGZyZWVkLgoKU2lnbmVkLW9mZi1ieTogS2FpcnVpIFNvbmcgPHJ5bmNzbkBnbWFpbC5jb20+ClNp
Z25lZC1vZmYtYnk6IEthaXJ1aSBTb25nIDxrYXNvbmdAdGVuY2VudC5jb20+Ci0tLQogbW0vc3dh
cF9zbG90cy5jIHwgMyAtLS0KIG1tL3N3YXBmaWxlLmMgICB8IDQgKy0tLQogMiBmaWxlcyBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9tbS9zd2Fw
X3Nsb3RzLmMgYi9tbS9zd2FwX3Nsb3RzLmMKaW5kZXggMTNhYjNiNzcxNDA5Li5kN2JiM2NhYTlk
NGUgMTAwNjQ0Ci0tLSBhL21tL3N3YXBfc2xvdHMuYworKysgYi9tbS9zd2FwX3Nsb3RzLmMKQEAg
LTI3Myw5ICsyNzMsNiBAQCB2b2lkIGZyZWVfc3dhcF9zbG90KHN3cF9lbnRyeV90IGVudHJ5KQog
ewogCXN0cnVjdCBzd2FwX3Nsb3RzX2NhY2hlICpjYWNoZTsKIAotCS8qIExhcmdlIGZvbGlvIHN3
YXAgc2xvdCBpcyBub3QgY292ZXJlZC4gKi8KLQl6c3dhcF9pbnZhbGlkYXRlKGVudHJ5KTsKLQog
CWNhY2hlID0gcmF3X2NwdV9wdHIoJnN3cF9zbG90cyk7CiAJaWYgKGxpa2VseSh1c2Vfc3dhcF9z
bG90X2NhY2hlICYmIGNhY2hlLT5zbG90c19yZXQpKSB7CiAJCXNwaW5fbG9ja19pcnEoJmNhY2hl
LT5mcmVlX2xvY2spOwpkaWZmIC0tZ2l0IGEvbW0vc3dhcGZpbGUuYyBiL21tL3N3YXBmaWxlLmMK
aW5kZXggZjk0N2Y0ZGQzMWE5Li4zMWNhOGIxNWE4ZGEgMTAwNjQ0Ci0tLSBhL21tL3N3YXBmaWxl
LmMKKysrIGIvbW0vc3dhcGZpbGUuYwpAQCAtMjQyLDkgKzI0Miw2IEBAIHN0YXRpYyBpbnQgX190
cnlfdG9fcmVjbGFpbV9zd2FwKHN0cnVjdCBzd2FwX2luZm9fc3RydWN0ICpzaSwKIAlmb2xpb19z
ZXRfZGlydHkoZm9saW8pOwogCiAJc3Bpbl9sb2NrKCZzaS0+bG9jayk7Ci0JLyogT25seSBzaW5w
bGUgcGFnZSBmb2xpbyBjYW4gYmUgYmFja2VkIGJ5IHpzd2FwICovCi0JaWYgKG5yX3BhZ2VzID09
IDEpCi0JCXpzd2FwX2ludmFsaWRhdGUoZW50cnkpOwogCXN3YXBfZW50cnlfcmFuZ2VfZnJlZShz
aSwgZW50cnksIG5yX3BhZ2VzKTsKIAlzcGluX3VubG9jaygmc2ktPmxvY2spOwogCXJldCA9IG5y
X3BhZ2VzOwpAQCAtOTU2LDYgKzk1Myw3IEBAIHN0YXRpYyB2b2lkIHN3YXBfcmFuZ2VfZnJlZShz
dHJ1Y3Qgc3dhcF9pbmZvX3N0cnVjdCAqc2ksIHVuc2lnbmVkIGxvbmcgb2Zmc2V0LAogCWVsc2UK
IAkJc3dhcF9zbG90X2ZyZWVfbm90aWZ5ID0gTlVMTDsKIAl3aGlsZSAob2Zmc2V0IDw9IGVuZCkg
eworCQl6c3dhcF9pbnZhbGlkYXRlKHN3cF9lbnRyeShzaS0+dHlwZSwgb2Zmc2V0KSk7CiAJCWFy
Y2hfc3dhcF9pbnZhbGlkYXRlX3BhZ2Uoc2ktPnR5cGUsIG9mZnNldCk7CiAJCWlmIChzd2FwX3Ns
b3RfZnJlZV9ub3RpZnkpCiAJCQlzd2FwX3Nsb3RfZnJlZV9ub3RpZnkoc2ktPmJkZXYsIG9mZnNl
dCk7Ci0tIAoyLjQ1LjIKCg==
--0000000000006e2a9e0620197bb4--

