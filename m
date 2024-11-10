Return-Path: <linux-kernel+bounces-403160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259D59C31C7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 12:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455CB1C20912
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 11:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C94155A34;
	Sun, 10 Nov 2024 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5S3tM1l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5142D1552FA
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731237533; cv=none; b=NHBTWWGFW5a4ssBB4FgTcbFUHuGhZBvBygZ2Rp9VXp/tSOSVXmxSSwZzwiomKXJbIBLmrysaPKyGlMcvcedBhfaStxIO9UkFi1FqhDIBpWp1bm9txRcjRGEPd7f4ckQwrL/oshJnFAmKvOi+ZEkBTJ6zaJtvJdJNol7HA1uIsNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731237533; c=relaxed/simple;
	bh=/lMG+5g03379UopIA04C55AAjOc39fSz6Yzbn1N93L0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRn3SMJT4DCsdFJlvt7ExjKLo8s5Wt8Ag54z2Iss7a95xv6yFE2Yp5/cOf095aV5nOL7K+mvqiNBXH/qCON25xewIhdXzlx/11Bo8VkxJWN+IkxnBEU27yZb01i+hPCF3QEEwPQMtWGZzu2AHK7/RtA462YAgYd8rPAww+qZM2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5S3tM1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F24C4CED6
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 11:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731237532;
	bh=/lMG+5g03379UopIA04C55AAjOc39fSz6Yzbn1N93L0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u5S3tM1ltEDRTZba5ZrZ86GWu+VTrBBNtU9Qvdf3Cvik9c2TY//2WbI6OQh/sZxlB
	 Q5AqFoYzhEB1zM0MM5fDhHSHrx+h4VI+CHUKQuY0Q2CuYYxsTWQxqlWz9NC0t+aXne
	 /mGnO5zlOEuPnTZnZQxFuCPBXWyhBu6eZy5KV8W+0iNucuF/xWJiDUO7AqBEoocJSq
	 fod+cYWtnb8lHreBNGzpz/BJJDJCWxsYo4cl3nfVo04xvFP2z8tQFn21i78ftEcWrw
	 Bzq1i8QQcLcPgbsPwQjwUwKQJb4u5SqA++naunWLksR+er+meDUtsv1jsMokkUvGrW
	 k2KNRZXvx4mwg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539d9fffea1so3609484e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 03:18:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4xVBhRgb723rp3xiljCkyXiBYO7H5KiJkiHc/WCXoWVqctY2QwNWh8egPDFXDuhoFCINO4rC3FgqJf7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztam7Nr0r1qRYQMSWszIdRA4FdA/G/q52S4pH+ZonYsx13yZQi
	ocnb8Qr4IRipALKK7zwnrw5Wmq1kNWlgUxLRNUj+G3y8c2FkQchgBzrQR+Fp/TBVJMEcgLwsJbH
	3IP9wMad/U2CPjool8yUPJPF2MYw=
X-Google-Smtp-Source: AGHT+IFYUUNlEuIHvUUfRlARzotjIl+5aXWcePhSkAQhdQ4g2psZItk2oZyLxSGd8YtUQ4jgf1S0Wg5I/9UL2zGH4YE=
X-Received: by 2002:a2e:ab0e:0:b0:2fa:bb65:801a with SMTP id
 38308e7fff4ca-2ff20268538mr37323351fa.26.1731237531414; Sun, 10 Nov 2024
 03:18:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107005831.15434-1-elsk@google.com>
In-Reply-To: <20241107005831.15434-1-elsk@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 10 Nov 2024 20:18:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQFk1UNARu4HMcAfpykpw6u3ex_PHOLzfnAo2CoOzBT8w@mail.gmail.com>
Message-ID: <CAK7LNAQFk1UNARu4HMcAfpykpw6u3ex_PHOLzfnAo2CoOzBT8w@mail.gmail.com>
Subject: Re: [PATCH v1] kheaders: prevent `find` from seeing perl temp files
To: HONG Yifan <elsk@google.com>
Cc: enh@google.com, ccross@google.com, Miguel Ojeda <ojeda@kernel.org>, 
	Matthias Maennich <maennich@google.com>, kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 9:58=E2=80=AFAM HONG Yifan <elsk@google.com> wrote:
>
> Symptom:
>
> The command
>
>     find ... | xargs ... perl -i
>
> occasionally triggers error messages like the following, with the build
> still succeeding:
>
>     Can't open <redacted>/kernel/.tmp_cpio_dir/include/dt-bindings/clock/=
XXNX4nW9: No such file or directory.


I tested this patch on Alpine Linux
with "for i in $(seq 100); do" loop.


[Without this patch]

  CHK     kernel/kheaders_data.tar.xz
  GEN     kernel/kheaders_data.tar.xz
  AR      kernel/module/built-in.a
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXKO=
EPLf:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXFEJdaa:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXdcljBm:
No such file or directory
Can't open /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/=
linux/XXlLaJJF:
No such file or directory.
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXEL=
BDIO:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXoHheAk:
No such file or directory
Can't open /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/incl=
ude/asm/XXeMGhpj:
No such file or directory.
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXbJmIOD:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXiH=
iAAd:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXjmiien:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXHD=
jNNM:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXlOHclm:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXbO=
Gokp:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXfiMojG:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXhj=
fhgd:
No such file or directory
Can't open /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux=
/XXiHbNEg:
No such file or directory.
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXKiEgne:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXLNlene:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXmKpBbk:
No such file or directory
Can't open /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux=
/XXdgokkN:
No such file or directory.
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXDpfMGd:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXhAMmbc:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXpaKiKk:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXJNPgAH:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXlk=
CjbB:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXmkfeAA:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXFF=
bADB:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXEJlBBd:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXPH=
MiNP:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXei=
MaiG:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXpfopfE:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXLOHHKc:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXiaBiIc:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXJainoG:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXJF=
hLEI:
No such file or directory
Can't open /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/incl=
ude/asm/XXhPACEf:
No such file or directory.
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXpM=
haAc:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXNdoMNL:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXgKMLkg:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXaKkEKh:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXmd=
OFEo:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXmjKioE:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXPeEhNj:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXJCnpLp:
No such file or directory
Can't open /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/incl=
ude/asm/XXHNOiKd:
No such file or directory.
  CC      kernel/kheaders.o




[With this patch]


  CHK     kernel/kheaders_data.tar.xz
  GEN     kernel/kheaders_data.tar.xz
  AR      kernel/module/built-in.a
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXeDFldH:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXLJMCah:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXckkiOH:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXNggIFH:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXnj=
OibB:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXkH=
OnGO:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXMogCin:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXogNJeJ:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXBAgJfo:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXfgFjJH:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXKiiEfj:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXkOEknj:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXjbddCE:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXDHGOlH:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXMGAdak:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXhfAChH:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXmG=
oEnP:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXGJ=
EpaH:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXkKODpJ:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXDEfBDk:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXmgjJkj:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXBjhcbB:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXHo=
LKEE:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXOg=
cfAB:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXdjoEEc:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXFdEDFO:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXiN=
pHAN:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXopbKfc:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXlJnGkN:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXKfPIJB:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXDfbPkb:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXEiOgDb:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXdCdCIK:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXdo=
CePE:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXnD=
jKlh:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXEEcAMM:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/uapi/linux=
/XXjlDBLj:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/include/linux/XXEF=
PFLj:
No such file or directory
find: /home/masahiro/ref/linux-next/kernel/.tmp_cpio_dir/arch/x86/include/a=
sm/XXpoFkCA:
No such file or directory
  CC      kernel/kheaders.o




Indeed, the error messages from perl were fixed, but
I still see a bunch of error messages,
which were presumably emitted by 'find'.


Do you know how to fix them?









> Analysis:
>
> With strace, the root cause has been identified to be `perl -i` creating
> temporary files inside $cpio_dir, which causes `find` to see the
> temporary files and emit the names. `find` is likely implemented with
> readdir. POSIX `readdir` says:
>
>     If a file is removed from or added to the directory after the most
>     recent call to opendir() or rewinddir(), whether a subsequent call
>     to readdir() returns an entry for that file is unspecified.
>
> So if the libc that `find` links against choose to return that entry
> in readdir(), a possible sequence of events is the following:
>
> 1. find emits foo.h
> 2. xargs executes `perl -i foo.h`
> 3. perl (pid=3D100) creates temporary file `XXXXXXXX`
> 4. find sees file `XXXXXXXX` and emit it
> 5. PID 100 exits, cleaning up the temporary file `XXXXXXXX`
> 6. xargs executes `perl -i XXXXXXXX`
> 7. perl (pid=3D200) tries to read the file, but it doesn't exist any more=
.
>
> ... triggering the error message.
>
> One can reproduce the bug with the following command (assuming PWD
> contains the list of headers in kheaders.tar.xz)
>
>     for i in $(seq 100); do
>         find -type f -print0 |
>             xargs -0 -P8 -n1 perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!SP=
DX).)*?\*\///smg;';
>     done
>
> With a `find` linking against musl libc, the error message is emitted
> 6/100 times.
>
> The fix:
>
> This change modifies the command so `find` only emits .h names, thereby
> skipping the temporary files. Another possible fix would be to store
> the results of `find` before feeding them into xargs; I didn't take this
> approach because the current approach appears marginally more optimized
> and involves a smaller change.
>
> Signed-off-by: HONG Yifan <elsk@google.com>
> ---
>  kernel/gen_kheaders.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
> index 383fd43ac612..271e0145f406 100755
> --- a/kernel/gen_kheaders.sh
> +++ b/kernel/gen_kheaders.sh
> @@ -84,7 +84,7 @@ for f in $dir_list;
>  done | cpio --quiet -pdu $cpio_dir >/dev/null 2>&1
>
>  # Remove comments except SDPX lines
> -find $cpio_dir -type f -print0 |
> +find $cpio_dir -type f -name '*.h' -print0 |
>         xargs -0 -P8 -n1 perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!SPDX).=
)*?\*\///smg;'
>
>  # Create archive and try to normalize metadata for reproducibility.
> --
> 2.47.0.199.ga7371fff76-goog
>


--=20
Best Regards
Masahiro Yamada

