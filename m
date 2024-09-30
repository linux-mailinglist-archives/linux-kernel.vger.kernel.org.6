Return-Path: <linux-kernel+bounces-344201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E3C98A64A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42DC31C20DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE261917F1;
	Mon, 30 Sep 2024 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTfpTLUF"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E3E1917E6
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704394; cv=none; b=ZXnfdztluaIwtAE1SdYgJK3KkVERjGB+WyXCbdyUsBUJMxumFhzaNOMY9Hoh9hR92E+gO5wiIPBhCEg1FkPZdPcYIm4C8hFDzRbhOfZNWPaGcz6hR8Y4OJv3+xYE8q9itCkZWMFImiVktbodcP+ILkVNvWm9o7ETsYtpLIiEFWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704394; c=relaxed/simple;
	bh=N2s+pHLeLb1AxvM/1Wtw+9oAnHeQJo0JmqUgf5gbk2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIylZECat4jDG5oePEmKAieXIM4zPZLjsUD1unbTyHobcuoK3hNrmn5djUFNbobXkZcvLzkOhrW4qtkP8xutYbUz1UicVcIU/QOAMXMt0O1jnLyfvgP+quM8lnB6Y5GuNgodhycDFd9mI9j6/q1pabwElcKqbIiCiTKhmhbw4Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTfpTLUF; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c88e45f467so2675340a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 06:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727704391; x=1728309191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//rV4yDodzkbpfHH8uwdF3JynS8r7EpTlnAkpGRydWY=;
        b=eTfpTLUFFX24zXgDfXGdqxw26rFwEDc38m5qkpYkhqANH8RLwAFHxsxwYJtSwDcE9M
         u1FbVUy6nymQqf8KWqKB/gYr/idcnQNfNeseRgIK4bfH1ibBKWJMAnYMj/PZ6O6VdpGa
         5A9em/eCN1CpWKvTU7Os+d++AcLbaygpyQgkUN9Wc5dRO3WJtCjt/t4zA0IIvrOhd93p
         y03L9ThECO79I0pYUQeOn29H/Sul5wnMadmDpg972A2bLBUyVLFoVYlXzlrtrnx+PPGy
         wc1GGNeiCHwXaoMeaXrPhdujPDEyPJINiXq18kcnLnjDmcZwLg+8I3eoSSYwVbChPpDp
         HYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727704391; x=1728309191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//rV4yDodzkbpfHH8uwdF3JynS8r7EpTlnAkpGRydWY=;
        b=F+GodplWAMaj6YYeN+P09agGsO4BWiuqFVvmZjf+71I6N6GI44kw1ns1ysAhao51a/
         hdoUmABamysAaJC1pH76a9wQhWTNqdDhh+ls0l0Tbdhvf0BXYm4e9WN3BsMRmQhe/+W0
         gzoXv2C/SjYc3SCYTBVWAPa1Gaee3c7fnoMuB8f31BaaHt+8mlOxO+RkBgKJ+AK8yhYG
         4sgjG1pozQnPJsC9xrvwFAiZIKhbFNrGJ9RYYEUNRUL6ek8FeTgz2QD7DbSsKYDezYeB
         d32qgo9pr40RvmEXUeQTi9k7Ibyyoqg3HZMBRjoMqqkdDQ3qFiwkFGy/oF9o0eXgan3t
         aiIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMGLDSHvuwfUIR2JrN+dUN4WAVG3p5eVtQCnnpJmrpaqDrDcT+CmOJyRDvGZsW9x01+QdH0F41W9nVW+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN9bXwTIGYlEHK/IoSHyNo5KueI0wj3P4bz4m45VDCw15Rsb5d
	szf1Zsc3Nzd9RA6OK+9lgTCmw/f1bnSIeOAs4sf1m6j942qWQx/6A/w1ZJHzRXIBWBhAWL2GjZO
	TgOzV0UR3RIXxEc2wMSgX3XL2bZi0lO4eokqBOiMW
X-Google-Smtp-Source: AGHT+IHnENHvUT7qUERXUtqdpcjpJye4NiSOb9lkvqtkAuNttCHB9wT0XFRwVUaEUXpFtWxzBv+6Q9AuWiT3hqlhQRc=
X-Received: by 2002:a05:6402:230e:b0:5c3:cc1c:4d9c with SMTP id
 4fb4d7f45d1cf-5c8777eae4amr15643474a12.18.1727704391332; Mon, 30 Sep 2024
 06:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66faaa4e.050a0220.aab67.0032.GAE@google.com>
In-Reply-To: <66faaa4e.050a0220.aab67.0032.GAE@google.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Mon, 30 Sep 2024 18:53:52 +0500
Message-ID: <CACzwLxj+Tbnn5Cwbezr+7VVrrsQD5Cev=o4+EkEFkp2v_QPFAQ@mail.gmail.com>
Subject: Re: [syzbot] [mm?] KASAN: out-of-bounds Read in copy_from_kernel_nofault
To: syzbot <syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 6:40=E2=80=AFPM syzbot
<syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    cea5425829f7 Add linux-next specific files for 20240930
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14eccea998000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D41a28720ed564=
c6a
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D61123a5daeb9f74=
54599
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/566995596f19/dis=
k-cea54258.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e7c506c1c71d/vmlinu=
x-cea54258.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7fcb4468b8c0/b=
zImage-cea54258.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: out-of-bounds in instrument_memcpy_before include/linux/instr=
umented.h:163 [inline]
> BUG: KASAN: out-of-bounds in copy_from_kernel_nofault+0x7a/0x2f0 mm/macce=
ss.c:35
> Read of size 6 at addr fffffffffffffffd by task syz.1.54/5558

This is due to the recent commit in mm/maccess.c and
might be false-positive according to the report.
Fix for the proper arguments' check has been already sent.

See pending patch:
https://lore.kernel.org/linux-mm/20240930102405.2227124-1-snovitoll@gmail.c=
om/T/#u

