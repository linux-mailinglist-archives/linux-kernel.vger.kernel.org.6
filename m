Return-Path: <linux-kernel+bounces-412943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C7C9D1191
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75F1282380
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBD519D890;
	Mon, 18 Nov 2024 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xiBGgtxs"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2F719ABCB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731935588; cv=none; b=B2NAUGCUoz1M64SAyoujfZczm3qIQTXQcheSa1GqsAVYe8DqFsDq2Drab/0im6zRp8jgJlRWgoHqXk9rIxHHjeV5fVH1+OoJ7JNmLS+C8hU3N7deoRNK1Bh3H2fJhED7lisv5Ax2WYUGXNuPsfGKDp1XCE/TU3yL1bLZ8gm2FVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731935588; c=relaxed/simple;
	bh=/gzVhyDLUGrlIGlmX0rVo4eduJypNngYJXly2qfBgSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=L0okQzdYK6Wz6pwU/Jm/ajwu250HaX8OlTTcO3KrmoiG8pg+i3mrvyXrDhWh7n6QhEVKk3JE8T/PY0pKdRywb7vtah+2qIq8ktSCN3f94ePhbFCVf9IoEsTUuTiGRxLNjGw3QQJlvfxSVrHSqcoYdPptEWPilXH2LrzEEdyaxAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xiBGgtxs; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea7e2ff5ceso3089053a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731935587; x=1732540387; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjD22ed1DQ/Cky3/dMr2TNInWLiX8LJlYP9yWVMv3AQ=;
        b=xiBGgtxsbH/1xwinwDCVjN8SCwMS5uXu2hrfD3l05E3Pz25foduas6Cgg4/uMzzBsZ
         W3NrEmBKR2F2alsMBsNceQ5GUsgqYJPiTcygKCnDl1mngiCLpItrDe4uBEzn/H5AtMQ8
         QQk1eVJWkOnxMgXVs8MZq26gzrBLEBMF8eav2ZF/Q3hsmWH0xMNiIbM9SbaUAr4q0WZK
         OMWXNf7dcyWAfTmUBhDmChZafFx4veV4PWgrNZuMU8hD2lUinmPjx4exsVnF4dTGlQjC
         ElUFHkJ3sJmxa3EIz2nVDiMK5xyt4Uc62KG78NvZI0RQsw69fZST8dpJTQ7A/zX3d1Fx
         +D5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731935587; x=1732540387;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjD22ed1DQ/Cky3/dMr2TNInWLiX8LJlYP9yWVMv3AQ=;
        b=vsNZkAUApqRg7UvF5IehfX2i0rRcaNNeARrjG7CO36YURd5xeoz3zd98VQ2hfjXgU+
         ygeUh9Xsz+MEepL2YELuFwQf6WVANXJG4FOqsfr24D8QA74EdQHZUeWj6d3K1QF8KVCm
         wj6yn9qv4DI6OPBiZmo5gmNHql7S3cLrbaljrdLmvdLygdii6CgzqzrC+prrNRm3jyZC
         t0gJL5+4HTAR81vV6qi6umIRE/UcORdjzk4G1Rw4v0nRhqyQSXC++P9XNtGIHsTo2NT7
         ZOklnrhRMArd9hq4dvEhnT39YuxYpRkNv1oSSS6gmFiySslEwWileTxmJBClaBNJWO+r
         Gecg==
X-Forwarded-Encrypted: i=1; AJvYcCVqxl/xLl07BWQaGUoIthP6ydVTKoCATqYjwKsJpDLRHiGofkml/GLXBXulMJaUt0XOdYLMFKJlv6ZXlkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YybD2tMGsfFgWGccA+g14MJDdSYF+iFZvpUx/8lf7i/oZW5WSVr
	HQZT89ttvpVXdA44h8W6JMSW1bByi27bZ4n5nMHqznEMOAOl0iiFG3052AvQ96bqafk+GAUz8DA
	nZEuMxcHGQl+XSCE2UqPnXNktCqPiemJ5i+oV
X-Google-Smtp-Source: AGHT+IHfjoq1ktjUPs+hcA+Bukrt/keBfIi4zzuowcoaoVnZ39XvkrU9DCu5qOXzN8o6rrz4Sy1xQPbgU3kVsT8F39k=
X-Received: by 2002:a17:90b:2403:b0:2ea:3f34:f190 with SMTP id
 98e67ed59e1d1-2ea3f34f37fmr9172616a91.25.1731935586513; Mon, 18 Nov 2024
 05:13:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6739c892.050a0220.e1c64.0013.GAE@google.com> <ko2rebsgpuw3akuwnsghjsjokhh2m6jshbr2ahsipkyk3txylr@3xpad7pj23in>
In-Reply-To: <ko2rebsgpuw3akuwnsghjsjokhh2m6jshbr2ahsipkyk3txylr@3xpad7pj23in>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 18 Nov 2024 14:12:54 +0100
Message-ID: <CANp29Y4YHHXQJ3qyd_bnDT_xz8Hkwpsckj_YM8v0XswyeBuObg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] general protection fault in mas_store_prealloc
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	syzbot <syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, jannh@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Liam,

On Mon, Nov 18, 2024 at 3:49=E2=80=AFAM 'Liam R. Howlett' via syzkaller-bug=
s
<syzkaller-bugs@googlegroups.com> wrote:
>
> * syzbot <syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com> [241117 =
05:42]:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    8e9a54d7181b Merge remote-tracking branch 'iommu/arm/sm=
mu'..
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/lin=
ux.git for-kernelci
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D17b0ace8580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da1eb85a42cb=
8ccec
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dbc6bfc25a68b7=
a020ee1
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > userspace arch: arm64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D147521a79=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D102e14c0580=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/ad658fb4d0a2/d=
isk-8e9a54d7.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/1b7754fa8c67/vmli=
nux-8e9a54d7.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/50315382fefb=
/Image-8e9a54d7.gz.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com
>
> I was unable to get this reproducer to work on my own image, even using
> the config and compiler specified in the report.  The injection was not
> happening at the same location as the crash reports.
>
> After using the provided disk (which was tricky), I was able to get it
> to work.

Just in case: did you follow the official syzbot instructions on
reproducing the bugs from the attached assets? [1] If yes, what extra
information could have made the process simpler for you?

[1] https://github.com/google/syzkaller/blob/master/docs/syzbot_assets.md

> Booting was painfully slow, and makes me wonder if there is a
> better way for reproducing issues in the future.

I guess that unless you run it on an arm64 device with a nested
virtualization support, this bug's reproduction will be slow anyway :(

If you recompile the kernel image without CONFIG_KASAN and
CONFIG_KCOV, that should speed it up to some degree.

>
> I've been debating just abusing the bot to debug, but it will spam the
> entire list, but I have it reproducing now.

Syzbot only makes sure that linux-kernel@vger.kernel.org and
syzkaller-bugs@googlegroups.com are included, both are not really
assumed to be closely followed by human beings. So I think it should
be totally fine to debug with syzbot if you just Cc those two lists.

--=20
Aleksandr

>
> Thanks,
> Liam
>

