Return-Path: <linux-kernel+bounces-367354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B39499A0140
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DEA9B233DB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB11718C926;
	Wed, 16 Oct 2024 06:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tkLtLy4R"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA27B41C69
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059581; cv=none; b=avhwsLt26htwRLorYNJKYwW9BhE2na7fkBR0X3KahP7j26UdCdpOif2bRKkiBm6K0cc6/d3Ds8MZL/2NnVCeE/KocZCI61u1stm1QS5SqPZ+vmiYxLFxcv05jG7UVhZJ55yIDeKHsw4FSEj2BLjm1RphAYMl1D3BW4sov6bB0aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059581; c=relaxed/simple;
	bh=j3DRb4fAUXg2O0u1R4GmE3iICoNy/FyIRWOy5jr7WMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHppZz3ryM6xF79Dn19wPi1b+fKbiL2Sz1AAOJfQothdtRWGVMMC4P8ndYGwj49uYWFE1uCbN/+8gfovFNLRQObqBQx/X8l4gaNEKdNoZ5IpCyuxhqhkxWAD2D9dPxRucdiMNGMZuQ3lwqStFapq7y6JagKBDDobC/QDNALgPIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tkLtLy4R; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e221a7e7baso4134578a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729059579; x=1729664379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnAP7A1wGyXXVKhgOcNRmKHIX2ZgMMeYE63QwFBQshM=;
        b=tkLtLy4ROOqWmsxJMACaJDoNj+Hzaz/FN7y1mnGf4jB/C2FUoJ772Z/dqak4DXjJop
         m/7tqqXxS2kAQeMPT4qAXpfdKasr6tBXff1VWJtyzQTzBNW9BrSDlDIft2uXzse7mxLl
         WwyC7FyvKKZaL3898MhRKO13fDQgE4+8Sp8i4TFHKq/kogbV6lNb/Tdsz51aKR/CPwkI
         DB+UoojPtFqb4FU2ZUS426t4Qh/JlzPHa1C9BXlXScj4PczWdRzl+KD5UuRd96a9tyQ0
         0bpFi7El/ODA1SzJzHyXHFebNJTDXKASnQYxoOlE1g6Ssmn0wqWkcBrG4W9Ij4dQRYZS
         SgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729059579; x=1729664379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnAP7A1wGyXXVKhgOcNRmKHIX2ZgMMeYE63QwFBQshM=;
        b=cKF/Clg7whgy/grYWmIdHZZ1kHxrgPSwD/qflgDs8G1xHBgqCBJ9f4mEuZh3JngiYs
         lhI0S2SqZcx2fux3vjN04yiZGfvgGKj0u+S/L4HDMECfvPHEleuVuN6zvLn8dHdPsYcu
         gVvLJSJM5hB0/MuT/PUkyMkzVm5noIOU/1i79CySdGqieFuFfVKp8nDNGC64e34iEGFR
         TVZfkRsEZlNdQYbkfTg7sz2K+MdVw2OeE+2LKpqgtM2KuCT8c9g70TPRx4B6BzuxKdn8
         M1NnmArOAfdX4jtOA0sDOWNUjmfuuhzXRa+bFXtjvUq1CE9wcl5WaVVDFAO3OUnyzDiR
         he6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKbC/gKyvlpKwsTYHwyjaF5os//nM7iZ7vz0a4e8527OpshyljVSyf1eiABheUDFcBEGhHrcHwNhSOTNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+OUstsJuWyoOXkkT+rzO1Gz17HfvH37LJUAbExrWRE/H5kVyo
	eW83VYf8oNfpCx9DZH85g3lYrkSQf+tmbNir5OwWUFQNpRIkkSvaabm1Q1BpfgEKGNFkyoNnvaN
	UKlf7vy1J2/pypJRJVXvl3IeBjOnELP3V1MaX
X-Google-Smtp-Source: AGHT+IFCm0c+eSMR7U26pdR/KPHZMfITwX2EJEYegRfvo1tCCI/MOHfg8gTXS6VabJqTvEoPfmIk/zOLbOmdcjK2OqU=
X-Received: by 2002:a17:90a:7c4d:b0:2e2:e545:82c5 with SMTP id
 98e67ed59e1d1-2e3ab7c4dabmr3281306a91.3.1729059578875; Tue, 15 Oct 2024
 23:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000c6b91e0621a312f4@google.com> <670e81a9.050a0220.d9b66.0153.GAE@google.com>
 <20241015153958.df4e735274e389999de60d2e@linux-foundation.org>
In-Reply-To: <20241015153958.df4e735274e389999de60d2e@linux-foundation.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 16 Oct 2024 08:19:25 +0200
Message-ID: <CANp29Y6czU3c-9FhdcyjfJtWrnaHJZ4o3WyY6TUeGo7TnP0KtQ@mail.gmail.com>
Subject: Re: [syzbot] [mm?] BUG: corrupted list in add_to_unbuddied
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+30eac43568e2b3d65728@syzkaller.appspotmail.com>, 
	linmiaohe@huawei.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, vitaly.wool@konsulko.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, Oct 16, 2024 at 12:40=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 15 Oct 2024 07:52:25 -0700 syzbot <syzbot+30eac43568e2b3d65728@sy=
zkaller.appspotmail.com> wrote:
>
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    eca631b8fe80 Merge tag 'f2fs-6.12-rc4' of git://git.ker=
nel..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D14d0845f980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcfbd94c114a=
3d407
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D30eac43568e2b=
3d65728
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D16df4c405=
80000
>
> Something seems rather wrong with the "syz repro" page.
>
>

What exactly looks wrong? :)
The repro mounts an ntfs3 disk image as the first operation, so the
compressed base64-encoded image takes quite a bit of space there.

>
>
> # https://syzkaller.appspot.com/bug?id=3D6b5f76b3a3783e6b1876d25b2d7a981a=
c0e0131f
> # See https://goo.gl/kgGztJ for information about syzkaller reproducers.
> #{"threaded":true,"repeat":true,"procs":6,"slowdown":1,"sandbox":"none","=
sandbox_arg":0,"tun":true,"netdev":true,"resetnet":true,"cgroups":true,"bin=
fmt_misc":true,"close_fds":true,"usb":true,"vhci":true,"wifi":true,"ieee802=
154":true,"sysctl":true,"swap":true,"tmpdir":true,"segv":true}
> syz_mount_image$ntfs3(&(0x7f0000000000), &(0x7f0000000140)=3D'./bus\x00',=
 0x19c6038, &(0x7f0000000180)=3DANY=3D[], 0x1, 0x1f231, &(0x7f000003e780)=
=3D"$eJzs3QmYTeUfB/D37Pu+XLvBWEO2RLLvsm+pZAvZyRalGhJRSSWpFElCQqhUEklEsi8JSZ=
KQVEIS/2fu3JlmufOvadf7/TyPOfeee877nnu+94z5ne0ebz25edsGbRISEhKIzZAU50gGSSSJX=
Iq9xsfGXYoNmdi/EZ3nV9ttftQreZxZcOVtoxYUXjVUa7/MfEsim+xOx09VOLwp3JT7+MW2vXoP=
Seg9JGHAwKEJXRO6DRw4tGu3fj0Suvce0rdsQst+PboO6ZHQe8CQHoMzvNyz38BBg0YmdB3Q3VA=
HDe4xZEhC1wEjE/r2GJkwdGDC0MEjE7re2rX3gISyZcsmGCqB36jd/H96CQAAAAAAAAAAAAAAAA=
AA4M9x6VLaoX0AAAAAAAAAAAAAAAAAAAC4TDVo3LR+OaKkPWcIQxoRhsxlCCH2L9OlXvfPZdNO8=
qRdoo9yRX82Sn10um/5fuf
> <and a huge amount more>
>

--=20
Aleksandr

