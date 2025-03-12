Return-Path: <linux-kernel+bounces-557358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9957A5D7BF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7134617643A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7169E22FF58;
	Wed, 12 Mar 2025 08:03:28 +0000 (UTC)
Received: from smtpgw-1-2.nogo.comp.nus.edu.sg (84-20.comp.nus.edu.sg [137.132.84.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064B622CBFA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=137.132.84.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766607; cv=none; b=EYbA7jZeM5MiMdHIpthrSk0vkI0xz6ug3K7w8iZZpkwuAhKAlJjUCpqG3Cwrc8fONtJUu6zYFMJAjyR6erhHdSINdc7gpIyGHzQefCtkKzuyAPurSet6ixokUHDPeYm/pykWwoX2UTO5p/INF15B+pQL0Pz9khZvFUuFNdjiaoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766607; c=relaxed/simple;
	bh=oJU4djKrm9Rm6ioU+tMZU2+PzdPdSVktRvsfMCG6txQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SX+BMYfaQ635JKUS1gRQ9jM02F9KCdjgs/J4cVHKq1enmQEEZAskmV0jB2Fb2kImlJToBruHEKIm67KmmuPVHhUQTXshm3ZUSyv9pv/c1bhjEfkDJ2lsXBZxLxdOKAfXLyV7TU+kjRrMC+Ck3FNDuu5aBFPonIYKv0xRKf/sRO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comp.nus.edu.sg; spf=pass smtp.mailfrom=comp.nus.edu.sg; arc=none smtp.client-ip=137.132.84.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comp.nus.edu.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comp.nus.edu.sg
Received: from localhost (localhost [127.0.0.1])
	by smtpgw-1-2.nogo.comp.nus.edu.sg (Postfix) with ESMTP id C257E1606E6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:03:15 +0800 (+08)
X-Virus-Scanned: Debian amavisd-new at smtpgw-1-2.comp.nus.edu.sg
Received: from smtpgw-1-2.nogo.comp.nus.edu.sg ([127.0.0.1])
	by localhost (smtpgw-1-2.comp.nus.edu.sg [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Vl6k9jMBAa9 for <linux-kernel@vger.kernel.org>;
	Wed, 12 Mar 2025 16:03:15 +0800 (+08)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtpgw-1-2.nogo.comp.nus.edu.sg (Postfix) with ESMTPS
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:03:15 +0800 (+08)
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39143311936so1429186f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 01:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741766593; x=1742371393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgJ9MVn1ZDiCD6dpQHQCxc25xA/00pK9v/ReT0rqFBw=;
        b=g5TCELsf6LV6L57yOYQo780FD9lbfad8CKSm6Mpy7QCcfFe6Pg5QxFuiVok+yMFQRk
         fpVcF3ijLqRAvjT5WNbYWNNUk0UspzRzi/oySQ+RZwHGtkWhtllugT2COFKB25Qbe9vt
         IQ8uNx9me/lg07VSPz5E+GgKcTgMOhLcCkTqJeXX0KgALT27RYtplR+IlOIrNBoTAWwY
         O8bHlJeudDLUUAbRvfSziORPfBKdIiqxduAbSQHkQqZdDlcei28SgTxCvu0YIMWpyRY6
         Itl6+EN8rFvVqyK9/XHz3MEQn/heVjTDtZVnMAyTf8sDJzZRxINXM1CEIPpen7Jgr2Qd
         3C1w==
X-Forwarded-Encrypted: i=1; AJvYcCW11eBYY+F9o8Mfk8F01QSRODobkTylFX57qFvzwKdRdH6hagQRvJoQc7HFVzRKFI/tF86eoGzmeMx96Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzggs/PUqwblIdcfebFLTyfKO2MH30UM7O4ym56No8iWd9Va+JY
	vt5RoUVI2LcDKr7Tw61D21rnJNbFn+DT7CUgFAxUd3cd7bJ5XRVePvbp7GSAHS3RXptpZTC2RG6
	Wy5Dx4oJ+20ZElqFlYV2jkDbNlEu/yZbe41DhnUw3q5ZCKXn58TfeX98e0w3eAaYou74ec2hlpQ
	UKjOSPB8idE2xST740xc+/j94iVO/UycwVyiGDm2hA7O0VEdIIuw==
X-Gm-Gg: ASbGncsxliF8IKOlmlnwwHfXfrYlubGaQrc6Be1hOz1sk+IcoCia5l85x7vDHKWf+61
	dbTeuvhoTmASsIStr1f4f2+gi0s4d7eoW6riJPN04oK+3KkiqGwjZagh1oZRniC24HBXOIL/yLb
	M=
X-Received: by 2002:a5d:64c5:0:b0:390:fdba:ac7 with SMTP id ffacd0b85a97d-3926c78f683mr7006689f8f.51.1741766592644;
        Wed, 12 Mar 2025 01:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBswwxBkt61fInFIN+2crJHiFOHtDmeeiTykeA+k3ejtaulGXNgAefuFsq5nZ/fSLbNJrFTD6UFi9/AmwPPbU=
X-Received: by 2002:a5d:64c5:0:b0:390:fdba:ac7 with SMTP id
 ffacd0b85a97d-3926c78f683mr7006630f8f.51.1741766591627; Wed, 12 Mar 2025
 01:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJeEPu++aAiF=ybq+XHEdGad+RsxR8d=tmEe5LxCOnDjWY_OFg@mail.gmail.com>
 <CAJeEPu+0EttQaFYKhGUbn2j=_nLvT-wfdBS0wQjXDkBq962g6g@mail.gmail.com> <8548e6ad-c21d-481c-b9c5-bd0403ee26c1@oracle.com>
In-Reply-To: <8548e6ad-c21d-481c-b9c5-bd0403ee26c1@oracle.com>
From: Dylan Wolff <wolffd@comp.nus.edu.sg>
Date: Wed, 12 Mar 2025 16:02:00 +0800
X-Gm-Features: AQ5f1JoY0LHi6ir44pClC7s__0tqkS8pYVqPGO6TWj3-ijmKdL--v9C9Srsz-d8
Message-ID: <CAJeEPu+AgjJD--boaj79Hp-QKskOm2AMqVwor_k+cwqUg_X2BA@mail.gmail.com>
Subject: Re: General Protection Fault / KASAN: null-ptr-deref in jfs_ioc_trim
To: Dave Kleikamp <dave.kleikamp@oracle.com>, Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	Jiacheng Xu <stitch@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Shaggy!

I've included a summary with sign-off below. Let me know if I am
missing anything else!

Also, we aren't sure if there are security implications for this
issue. Is it possible that induced load could result in Denial of
Service? Could you comment on whether we should initiate the process
for a CVE?

Thanks!
Dylan

```
[ Syzkaller Report ]

Oops: general protection fault, probably for non-canonical address
0xdffffc0000000087: 0000 [#1
KASAN: null-ptr-deref in range [0x0000000000000438-0x000000000000043f]
CPU: 2 UID: 0 PID: 10614 Comm: syz-executor.0 Not tainted
6.13.0-rc6-gfbfd64d25c7a-dirty #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Sched_ext: serialise (enabled+all), task: runnable_at=3D-30ms
RIP: 0010:jfs_ioc_trim+0x34b/0x8f0
Code: e7 e8 59 a4 87 fe 4d 8b 24 24 4d 8d bc 24 38 04 00 00 48 8d 93
90 82 fe ff 4c 89 ff 31 f6
RSP: 0018:ffffc900055f7cd0 EFLAGS: 00010206
RAX: 0000000000000087 RBX: 00005866a9e67ff8 RCX: 000000000000000a
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000001
RBP: dffffc0000000000 R08: ffff88807c180003 R09: 1ffff1100f830000
R10: dffffc0000000000 R11: ffffed100f830001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000438
FS:  00007fe520225640(0000) GS:ffff8880b7e80000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005593c91b2c88 CR3: 000000014927c000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
? __die_body+0x61/0xb0
? die_addr+0xb1/0xe0
? exc_general_protection+0x333/0x510
? asm_exc_general_protection+0x26/0x30
? jfs_ioc_trim+0x34b/0x8f0
jfs_ioctl+0x3c8/0x4f0
? __pfx_jfs_ioctl+0x10/0x10
? __pfx_jfs_ioctl+0x10/0x10
__se_sys_ioctl+0x269/0x350
? __pfx___se_sys_ioctl+0x10/0x10
? do_syscall_64+0xfb/0x210
do_syscall_64+0xee/0x210
? syscall_exit_to_user_mode+0x1e0/0x330
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe51f4903ad
Code: c3 e8 a7 2b 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d
RSP: 002b:00007fe5202250c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe51f5cbf80 RCX: 00007fe51f4903ad
RDX: 0000000020000680 RSI: 00000000c0185879 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe520225640
R13: 000000000000000e R14: 00007fe51f44fca0 R15: 00007fe52021d000
</TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:jfs_ioc_trim+0x34b/0x8f0
Code: e7 e8 59 a4 87 fe 4d 8b 24 24 4d 8d bc 24 38 04 00 00 48 8d 93
90 82 fe ff 4c 89 ff 31 f6
RSP: 0018:ffffc900055f7cd0 EFLAGS: 00010206
RAX: 0000000000000087 RBX: 00005866a9e67ff8 RCX: 000000000000000a
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000001
RBP: dffffc0000000000 R08: ffff88807c180003 R09: 1ffff1100f830000
R10: dffffc0000000000 R11: ffffed100f830001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000438
FS:  00007fe520225640(0000) GS:ffff8880b7e80000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005593c91b2c88 CR3: 000000014927c000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Kernel panic - not syncing: Fatal exception

[ Analysis ]

We believe that we have found a concurrency bug in the `fs/jfs` module
that results in a null pointer dereference. There is a closely related
issue which has been fixed:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dd6c1b3599b2feb5c7291f5ac3a36e5fa7cedb234

... but, unfortunately, the accepted patch appears to still be
susceptible to a null pointer dereference under some interleavings.

To trigger the bug, we think that `JFS_SBI(ipbmap->i_sb)->bmap` is set
to NULL in `dbFreeBits` and then dereferenced in `jfs_ioc_trim`. This
bug manifests quite rarely under normal circumstances, but is
triggereable from a syz-program.

Reported-and-tested-by: Dylan J. Wolff<wolffd@comp.nus.edu.sg>
Reported-and-tested-by: Jiacheng Xu <stitch@zju.edu.cn>
Signed-off-by: Dylan J. Wolff<wolffd@comp.nus.edu.sg>
Signed-off-by: Jiacheng Xu <stitch@zju.edu.cn>
---
 fs/jfs/jfs_discard.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletions(-)

diff --git a/fs/jfs/jfs_discard.c b/fs/jfs/jfs_discard.c
index 5f4b30503..4b660296c 100644
--- a/fs/jfs/jfs_discard.c
+++ b/fs/jfs/jfs_discard.c
@@ -86,7 +86,8 @@ int jfs_ioc_trim(struct inode *ip, struct fstrim_range *r=
ange)
        down_read(&sb->s_umount);
        bmp =3D JFS_SBI(ip->i_sb)->bmap;

-       if (minlen > bmp->db_agsize ||
+       if (bmp =3D=3D NULL ||
+           minlen > bmp->db_agsize ||
            start >=3D bmp->db_mapsize ||
            range->len < sb->s_blocksize) {
                up_read(&sb->s_umount);
```


On Tue, Mar 11, 2025 at 11:48=E2=80=AFPM Dave Kleikamp <dave.kleikamp@oracl=
e.com> wrote:
>
> On 3/11/25 1:47AM, Dylan Wolff wrote:
>
> Hi all,
>
> Just checking in on this report. Is there another email list I should be =
using for this issue? Can anyone confirm whether or not our fix is acceptab=
le?
>
> This is the right list. Somehow I missed this one and/or forgot it.
>
> The patch looks good to me. Can you re-send it with a Signed-off-by: ?
>
> Thank you!
>
> Shaggy
>
>
> Thanks again!
> Dylan
>
> On Tue, Jan 7, 2025 at 4:53=E2=80=AFPM Dylan Wolff <wolffd@comp.nus.edu.s=
g> wrote:
>>
>> Hello kernel developers!
>>
>> We believe that we have found a concurrency bug in the `fs/jfs` module t=
hat results in a null pointer dereference. There is a closely related issue=
 which has been fixed:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3Dd6c1b3599b2feb5c7291f5ac3a36e5fa7cedb234
>>
>> ... but, unfortunately, the accepted patch appears to still be susceptib=
le to a null pointer dereference under some interleavings.
>>
>> To trigger the bug, we think that `JFS_SBI(ipbmap->i_sb)->bmap` is set t=
o NULL in `dbFreeBits` and then dereferenced in `jfs_ioc_trim`. This bug ma=
nifests quite rarely under normal circumstances, but is triggereable with t=
he attached syz program. We've also attached a trace of an execution that l=
eads to the crash (thread id:location). If needed, we can share our setup i=
n detail which reproduces the bug with very high probability.
>>
>> Here's a proposed patch:
>>
>> ```
>> diff --git a/fs/jfs/jfs_discard.c b/fs/jfs/jfs_discard.c
>> index 5f4b30503..4b660296c 100644
>> --- a/fs/jfs/jfs_discard.c
>> +++ b/fs/jfs/jfs_discard.c
>> @@ -86,7 +86,8 @@ int jfs_ioc_trim(struct inode *ip, struct fstrim_range=
 *range)
>>         down_read(&sb->s_umount);
>>         bmp =3D JFS_SBI(ip->i_sb)->bmap;
>>
>> -       if (minlen > bmp->db_agsize ||
>> +       if (bmp =3D=3D NULL ||
>> +           minlen > bmp->db_agsize ||
>>             start >=3D bmp->db_mapsize ||
>>             range->len < sb->s_blocksize) {
>>                 up_read(&sb->s_umount);
>> ```
>>
>> Applying this patch to our kernel locally appears to resolve the issue.
>>
>> If this looks like it might be a security vulnerability, please let us k=
now if there is anything we need to provide for the CVE process.
>>
>> We would also appreciate attribution for the discovery / fix if applicab=
le:
>> >Reported-by: Jiacheng Xu<stitch@zju.edu.cn>,  Dylan Wolff <wolffd@comp.=
nus.edu.sg>
>>
>> Environment:
>>      Qemu (invocation attached) running a Syzkaller image on an Ubuntu 2=
2.04.4 LTS host
>> Kernel:
>>      HEAD commit: fbfd64d25
>>      tree: upstream
>>      compiler toolchain: clang-17
>>
>> Thanks!
>> Dylan
>>

