Return-Path: <linux-kernel+bounces-243928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE05A929C88
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A06281507
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C601CA96;
	Mon,  8 Jul 2024 06:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PXVuP5iC"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919181946F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720421576; cv=none; b=UBU+OKoVkgJ75ojEix/JJJn+5Bf2jGCWLSR2ml1WFZaleQ5biGFVf/+Rh9BS5GAuI9yh3X8VKOpG/Xs1TiGceT4c/puawcIlQjAKnkwhovTCGD7lMahladXIzCYjgD2p/1XujCpIJPBhJjPLa08lGtoupNQY9pLCcm59wnMv+/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720421576; c=relaxed/simple;
	bh=AEvwklKkahMqU5NTDzmQKtCMtYWlnzq3g2SsYFh0OP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJtD0B1C3d1yDX8L0BBGxAG9MCpWJXpuM+IDlve222QsKYozsn2CUfSXsH9A78TEzDgaNvLMMLi9nP34Ss8xeO+TawMXnZqwz9jnslAfL9IiyZ9HGvArzhB5c5uOrxTaQFCyWZXorOOOQRX5iaBu29Yot4IfzPdGJl+2dLYKgB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PXVuP5iC; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58ce966a1d3so30413a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 23:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720421573; x=1721026373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9whkwrmVJ5LTYmQjDX1Dcp6xV4ICCXH4l+UXuqVSVG8=;
        b=PXVuP5iCT9zjIADZSIEaZQSfq0gMpRTiur0fUk5yhBqZIIfGwh4HoTN517r58sm1Y8
         N4A5eIbabSge6Ntc1p1l3B74qtZhOgBLHHVrQW/necgudNwJtj4XqQU+LQLTREd6/p+i
         xjoYPnF0hYAGeT6/jmSQwANSOcDDT+PsKzHdQn+O0H6Nmn2nz0vxb+3rRTq5iNBfv4OU
         EuUvNyHH0iTSobcQpH7aQanszSxCyPWR9voPYoKtL2mGJWeigvtK9sPPytoVPqx+4GUs
         Wjd+U5hgYmKT1voWkxsofVzZNJy7g9UbenVrUTlL91LurGzWspAx3It2XznLRn6IRN8/
         xmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720421573; x=1721026373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9whkwrmVJ5LTYmQjDX1Dcp6xV4ICCXH4l+UXuqVSVG8=;
        b=SdTV1BFa4kGkT5EuCtQp0PAI05ID+uyV92IOSoRdaiBLNRva1/XL2XUmGMIy6kR6fe
         Ph0N6WG0l6xtOUZ8owLmLteniW/916Aor5tPnnkxQ4HM/elOYWMZZE6KW0rQmuZSzDU3
         n2QQIyi7Qqlst+bENImQsadmBudCx3zH4evYwdK3GuVTOEPmA7WhHmsyKxMRZkUOfvy+
         b7yuL6s+Hx5ZIqzlq4rQToBAiAJRp1KG2bgo+Kww6dhXqXBxO/qu2lSTyQZgznfzhgMO
         uYIyGgHDtMBgpeGGlq/l3Pn+4DGtDnOUwxUbJNPdtB3mu6RbxA8KFi8Zarl+D034gP1C
         X3bw==
X-Forwarded-Encrypted: i=1; AJvYcCWjU8ejcuED8+SsYZdJBX0h/BSwVL1JeS4b/I+qSQdbtKaPEFNLPQVP6+krFcipdK4/tQodIZeCZO7BMQeFZIRXpvH880TSx6T0Jr44
X-Gm-Message-State: AOJu0YxhOLiUUu4ivQAx1/YUCpzqcut5aAi0Ii71X6tvI+PNWJDcXEkn
	usL4xpLVOi2hLe6fbFLzHfXavKrCmEvbZZ2U7CE0SHTBiySxFxwkEg+A4dlDyvI/G64vfI3fbGW
	fVr8Dtj4f1b6PmPoTDM0R4XIPwn9SgZvLtaVa
X-Google-Smtp-Source: AGHT+IFN5kJ6GOce4aE1Yj+jUNSNYIaA8MJOELU5iBuuDRasF2YS08Shp8PeHvRwpV6zyoqz/feShY8ANBbLonjV3cc=
X-Received: by 2002:a50:8d1a:0:b0:58b:b1a0:4a2d with SMTP id
 4fb4d7f45d1cf-58e28e6929fmr420362a12.1.1720421572714; Sun, 07 Jul 2024
 23:52:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000037162f0618b6fefb@google.com> <tencent_8BBB6433BC9E1C1B7B4BDF1BF52574BA8808@qq.com>
 <172021445223.2844396.7059951310501602233.b4-ty@kernel.org> <20240706-wucher-gegossen-ed347171f1f0@brauner>
In-Reply-To: <20240706-wucher-gegossen-ed347171f1f0@brauner>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 8 Jul 2024 08:52:41 +0200
Message-ID: <CACT4Y+aZ=pBg7sOMmMojM6-gOsxk-e7Z91VaqS9cyjN40ZFirA@mail.gmail.com>
Subject: Re: [PATCH] hfsplus: fix uninit-value in copy_name
To: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <kees@kernel.org>, syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com, 
	Edward Adam Davis <eadavis@qq.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Jul 2024 at 09:20, Christian Brauner <brauner@kernel.org> wrote:
>
> On Fri, Jul 05, 2024 at 02:20:54PM GMT, Kees Cook wrote:
> > On Tue, 21 May 2024 13:21:46 +0800, Edward Adam Davis wrote:
> > > [syzbot reported]
> > > BUG: KMSAN: uninit-value in sized_strscpy+0xc4/0x160
> > >  sized_strscpy+0xc4/0x160
> > >  copy_name+0x2af/0x320 fs/hfsplus/xattr.c:411
> > >  hfsplus_listxattr+0x11e9/0x1a50 fs/hfsplus/xattr.c:750
> > >  vfs_listxattr fs/xattr.c:493 [inline]
> > >  listxattr+0x1f3/0x6b0 fs/xattr.c:840
> > >  path_listxattr fs/xattr.c:864 [inline]
> > >  __do_sys_listxattr fs/xattr.c:876 [inline]
> > >  __se_sys_listxattr fs/xattr.c:873 [inline]
> > >  __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
> > >  x64_sys_call+0x2ba0/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:195
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > [...]
> >
> > I've taken some security-related hfsplus stuff before, so:
>
> It's in #vfs.fixes to go out with the next vfs fixes pr.

Oops, sorry for creating a mess.
It's just really hard to understand a random patch status.

