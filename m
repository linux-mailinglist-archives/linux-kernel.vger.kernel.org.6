Return-Path: <linux-kernel+bounces-236530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D49991E394
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D28CB291D9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C830916CD09;
	Mon,  1 Jul 2024 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRc7l5ly"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6960516C874
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846651; cv=none; b=T5DrAwPjcGk4x6neEbsNtiL7GKmwo98Bl9Rr0XbQr7k6g4gypFqDMMQJEsTbaWNYPw083/6IVOMKiPqe5Sib+Q1QrtzvThJt5kXwDsXj93lErDDOJAr5jrdR0bMXmNkW+NsZArIhcNgpc322CWcAbf8t76eKgaQ/eShW0yAUHoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846651; c=relaxed/simple;
	bh=1HolEjilFhG0cZWk4znpWDFprkOwLOateB7fovQBbFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSyw/z7sUqCRLoU04qghCCwnnQFTbUIrKU0pdwxEr2KfmiPsHHvbbL83Ewc/gEPpAHqepuUBS94YcKLtMz4D/zFq3p5P81THUq7A1Lu1AKCLl6e5bqfomJTQcpPopZNWC6PyqglBG9O97fPs9T19tKGH2or/ZgdMHCvwvsOPgmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRc7l5ly; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3629c517da9so2562063f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 08:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719846648; x=1720451448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uoqJDE8Nxw1jtvx0c3KsBxMhbzIR8G4P8HBgB5+rOM=;
        b=CRc7l5lyWZKONRxxaBShT7m+hPwE6dC8nfwFs6LGqFKPDWcgITkcSAutpCAIUt8vy/
         oJfa3UXnPCAQWRLjtAKA3xqeYaiKgwiynB7gNCTGjUuXCKTkQkPd3xm1nOGK81g6bMCU
         oet9Zfmit9dVWbckZ15d5bV1LcRA7F0BST/Sv9qwQbNVbQdBDbiYhueyUo3yHXvKrAzm
         nxts8P4TX7NWkzf0YO0Bs3x6N+pJ4nNB7hH4HRaurTFEPWKw5MVhssy3s6crYkANFJTb
         3SJbq2Ss9Bpdk+O792n4x0pWPSOU+buzxiQ0hmEvbRYfgwBTL/oKiCqvLh2r6wUGHwhm
         H9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719846648; x=1720451448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uoqJDE8Nxw1jtvx0c3KsBxMhbzIR8G4P8HBgB5+rOM=;
        b=LlCr2JJArOEQQO4PGBSDnCVv0osNz0qi525+ZXXcreAZOS0Y6azpRLcIcOklwQ2cVo
         GLQm7oQ+lv8wxvLJoTaYkCAz2Eqn86RJCFd031hEWpYR1IlS6k9mDUnoGP16oIMOIvUX
         lgr0MGkHz0xlm3s57NVGO6NhSL8F5ZLhYPb4mgop+46mpDGJJozWBIytu5OiSFMIn7bN
         nzfM6wMVZaZ31DcqCezLIZNIt6tXRKVJ72kaPdoGRTRmM8cpNzbdEY+2LoH/VEo442Uc
         zwlOCd791c0dMf0W/6hut4HQkZcY1niY3TJCQsq0oAF0WzKu/S+jzONidh2/1QNQPmQz
         2JTw==
X-Forwarded-Encrypted: i=1; AJvYcCW6J6aiPRKx4iB4uvllHw3INEsYal/rlKpozbcrf4bKB2XtCFNW8ul/wIudMyjZmjAzi4c+PPRMZatmfAYWTtnPox218/iyOaJuhr6H
X-Gm-Message-State: AOJu0YxMoPKePCrjacxLbE5MVlcveCCCVMw826GCKcGLRh34+1LStCjs
	3bXPvxOUibcDlq3hhYEWVjf41c/HO8d0s4BGxv8nHY87AdKQnIzw3LVHQrfLt8Oyzx5ErbYvvAh
	knEZ1QAYHFLgyiPe1eWJO9bcw5Ws=
X-Google-Smtp-Source: AGHT+IGc72XD55WEl/AAXhjjPb5Fe8Oc4tulGp5x6JseNK/GEV+axbzxLrfzaoTk40G738LiOZMa7egHbSVz/yhpWzo=
X-Received: by 2002:a5d:598a:0:b0:367:434f:cab8 with SMTP id
 ffacd0b85a97d-36775724938mr6201368f8f.43.1719846647160; Mon, 01 Jul 2024
 08:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000a8c856061ae85e20@google.com> <82cf2f25-fd3b-40a2-8d2b-a6385a585601@I-love.SAKURA.ne.jp>
 <daad75ac-9fd5-439a-b04b-235152bea222@I-love.SAKURA.ne.jp>
In-Reply-To: <daad75ac-9fd5-439a-b04b-235152bea222@I-love.SAKURA.ne.jp>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 1 Jul 2024 17:10:36 +0200
Message-ID: <CA+fCnZdg=o3bA-kBM4UKEftiGfBffWXbqSapje8w25aKUk_4Nw@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] KASAN: stack-out-of-bounds Read in __show_regs (2)
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot <syzbot+e9be5674af5e3a0b9ecc@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	kasan-dev <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 2:43=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Hello, KASAN people.
>
> I suspect that KASAN's metadata for kernel stack memory got out of sync f=
or
> unknown reason, for the stack trace of PID=3D7558 was successfully printe=
d for
> two times before KASAN complains upon trying to print for the the third t=
ime.
> Would you decode what is this KASAN message saying?
>
> Quoting from https://syzkaller.appspot.com/text?tag=3DCrashLog&x=3D119fd0=
81980000 :

[...]

> [  229.319713][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  229.327779][    C0] BUG: KASAN: stack-out-of-bounds in __show_regs+0x1=
72/0x610
> [  229.335174][    C0] Read of size 8 at addr ffffc90003c4f798 by task kw=
orker/u8:5/234

[...]

> [  230.044183][    C0] Memory state around the buggy address:
> [  230.049816][    C0]  ffffc90003c4f680: f2 f2 f2 f2 00 00 00 00 00 f3 f=
3 f3 f3 f3 f3 f3
> [  230.057889][    C0]  ffffc90003c4f700: 00 00 00 00 00 00 00 00 00 00 0=
0 00 f1 f1 f1 f1
> [  230.065961][    C0] >ffffc90003c4f780: 00 f2 f2 f2 00 f3 f3 f3 00 00 0=
0 00 00 00 00 00
> [  230.074059][    C0]                             ^
> [  230.078915][    C0]  ffffc90003c4f800: 00 00 00 00 00 00 00 00 f1 f1 f=
1 f1 00 f2 f2 f2
> [  230.086983][    C0]  ffffc90003c4f880: 00 f3 f3 f3 00 00 00 00 00 00 0=
0 00 00 00 00 00
> [  230.095056][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I checked some of the other syzbot reports for this bug, and this
memory state part in some of them looks different.

Specifically, for
https://syzkaller.appspot.com/text?tag=3DCrashLog&x=3D14293f0e980000:

[ 1558.929174][    C1] Memory state around the buggy address:
[ 1558.934796][    C1]  ffffc9000b8bf400: 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00
[ 1558.942852][    C1]  ffffc9000b8bf480: 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00
[ 1558.950897][    C1] >ffffc9000b8bf500: 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00
[ 1558.958943][    C1]                                      ^
[ 1558.964569][    C1]  ffffc9000b8bf580: 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00
[ 1558.972613][    C1]  ffffc9000b8bf600: 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00

This is weird, because if the metadata is 00, then the memory should
be accessible and there should be no KASAN report.

Which makes me believe you have some kind of a race in your patch (or
there's a race in the kernel that your patch somehow exposes). At
least between the moment KASAN detected the issue and the moment the
reporting procedure got to printing the memory state, the memory state
changed. As this is stack memory that comes from a vmalloc allocation,
I suspect the task whose stack had been at that location died, and
something else got mapped there.

This is my best guess, I hope it's helpful.

