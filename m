Return-Path: <linux-kernel+bounces-250851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CAA92FD9D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4C81C20B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B9F17107F;
	Fri, 12 Jul 2024 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNYUBMXJ"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A085256
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720798279; cv=none; b=fE/QqMKmL+JI6B5ZWAtnl8I7GpzjQSF7ovoBQYaD4BS2S65VDObaPpFRgBeywIzyIjU02n8JXsZ41/HlH70bQpivS0g5/bCAaBDuWUBl3cH52VpYFUjslW7SW+HgGCHqCwlQRWrW5CRHshbRBGZr/kMTxXwP0Bb/admXFBybMv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720798279; c=relaxed/simple;
	bh=fxT+bOfiyP6lMl9D/ZxbBbEhTvwULS07dK6DtYz/Lnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQoNe/FoHds021y1A9fF/+nFiDjEk59g1C6vT5uI77ICFfjZOkz+wzh7zvthby/43CGRJV9OVRwMGne1OrqaJfH+yhutSWC52hQFVU54CIr/zgh+JiIIzjn+B2fge5D8Fup6rQayAw5yGAmPnhK9A7geiYjnn9rtGQpkvl39lLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNYUBMXJ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57d05e0017aso2879975a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720798276; x=1721403076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8ApIoZLrTCReZSKKI4weCLSWhQdEbq1c8nSmFnk/F8=;
        b=gNYUBMXJD2/GbyXqdiLPEzzH7+rDrnshbZQPTx5egdXBuDVM8PGjh1z4C/YNvODcd+
         5DxJ2UZ1RL3IZxjKPzvxg0Qdcgc+NRa92QF/TNe39G1k+otlpw9Ge9hKLvA1vVro7bpG
         2FKm6PdZDk0zrhx+Nh5EKcDm5VdDDyGe5PBRb3Y7ZZH9G8g67gcbAqxKB1JQeLEtiLep
         CKcNcapAZ5Ls4mpmUEe5Hi28bKEPCHnPR5kzntJG8GE59Bq8DdQMEI2M4bt2UvYvTsEg
         mIUH2zC/WIz8CwNzmG6tuaNxuws0Do2TLB1gOIBZUfaRcC6ocHpfsqk1d5MkiN7l4/Gi
         g+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720798276; x=1721403076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8ApIoZLrTCReZSKKI4weCLSWhQdEbq1c8nSmFnk/F8=;
        b=Th+L3voeG4e1pg4m2t14cwm27QX5/Jop46r9OX2QV+C72K16rZKCJ+d76VqDBR3MMw
         3oj8Ssd7MBHcYNLkh9NFsbgQWQ9c0ijBu3ddxtWC0uFwG1oASvMPimgPN+/WzSTP/Kn2
         kDOCF1K8nPkmcOvLa8ojKXCRYlcYNZiNtPuGk9shscXH0BUeq6XRUlJ2c0hPl6x0GdX/
         elpP6J8W/tMmSru/qM35WbuTdPIN3JR2+GiBKSZ0SMQbv6fGkuvFriRp/yT7937Jx31D
         cC+tjE3bQZxLzHLfYxeXN5hKIFKc9vYGJEwqCRdARuY0okgX6cLSnsPyp7xGwDJofLp5
         +5FA==
X-Forwarded-Encrypted: i=1; AJvYcCV8L9rqU5is/D421zUDSNBY118+C927rI2GgjuJ7uLgWINzy/qza5OVHWOgPJsjRxZdaY81mJ5qEZLIgWwE3acs5XpWa1HS6mJ86RpI
X-Gm-Message-State: AOJu0YyLFneRcyHrg2pWBy0qykd2pDcECLYqd3uWx65mgM58SpBsvKlm
	hrjgT/1o2VfnHPQT5nP6RWo5Jq7Xp7h5SEgBfQVEL9Mop5XOigFWuR4cCEOrgtx082fqm8Pe7Lf
	udKEGMNU6/dAtLROy6QIZGR8GC4MQFQ==
X-Google-Smtp-Source: AGHT+IHW6bgxiPp+ikEfLCczpHOanG7A6v2Xf9yn4cokyZip30mOrT/z7TOmpNN8hw8IzgP7O5CrZttxImjpv233EDU=
X-Received: by 2002:a17:906:6804:b0:a75:2781:a5c4 with SMTP id
 a640c23a62f3a-a780b6b2f3cmr744849366b.29.1720798275357; Fri, 12 Jul 2024
 08:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118133504.2910955-1-shy828301@gmail.com> <2d7bd8b2b9736d4a7d0a26169978372b5e002a62.camel@debian.org>
 <CAHbLzkr1LwH3pcTgM+aGQ31ip2bKqiqEQ8=FQB+t2c3dhNKNHA@mail.gmail.com>
 <ZpBFjzIEpq6RIM8I@casper.infradead.org> <CAHbLzkpitWRK2q3JidRdyQxajz+MixiO1bX08btVu9Ch0i6Kxw@mail.gmail.com>
 <ZpFAt6ha2KbFRoFn@corsac.net>
In-Reply-To: <ZpFAt6ha2KbFRoFn@corsac.net>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 12 Jul 2024 08:31:02 -0700
Message-ID: <CAHbLzkq_NHZdxNcWD-WXLEP+DRUGcNsavH6uMTAGdgXrwjX24Q@mail.gmail.com>
Subject: Re: [PATCH] mm: huge_memory: don't force huge page alignment on 32 bit
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Matthew Wilcox <willy@infradead.org>, jirislaby@kernel.org, surenb@google.com, 
	riel@surriel.com, cl@linux.com, akpm@linux-foundation.org, 
	yang@os.amperecomputing.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Salvatore Bonaccorso <carnil@debian.org>, Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 7:43=E2=80=AFAM Yves-Alexis Perez <corsac@debian.or=
g> wrote:
>
> On Thu, Jul 11, 2024 at 01:53:04PM -0700, Yang Shi wrote:
> > On Thu, Jul 11, 2024 at 1:50=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Thu, Jul 11, 2024 at 01:47:00PM -0700, Yang Shi wrote:
> > > > +++ b/mm/huge_memory.c
> > > > @@ -857,7 +857,8 @@ static unsigned long
> > > > __thp_get_unmapped_area(struct file *filp,
> > > >         loff_t off_align =3D round_up(off, size);
> > > >         unsigned long len_pad, ret, off_sub;
> > > >
> > > > -       if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
> > > > +       if (IS_ENABLED(CONFIG_32BIT) || IS_ENABLED(CONFIG_X86_32) |=
|
> > > > +           in_compat_syscall())
> > >
> > > Why not:
> > >
> > >         if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall())
> >
> > Nothing specific, just didn't think of it, sigh...
> >
> > Thanks for the suggestion. Definitely preferable way.
> >
> And I just did a quick test rebuilding a kernel with
> !IS_ENABLED(CONFIG_64BIT) and running on an i386 Debian sid
> installation.
>
> I can confirm it seems to work as intended:
>
> Before:
> root@testvm:~# uname -a
> Linux testvm 6.9.8-686-pae #1 SMP PREEMPT_DYNAMIC Debian 6.9.8-1 (2024-07=
-07) i686 GNU/Linux
> root@testvm:~# for i in {0..9}; do cat /proc/self/maps |grep libc.so |hea=
d -n1; done
> b7c00000-b7c22000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/=
libc.so.6
> b7c00000-b7c22000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/=
libc.so.6
> b7c00000-b7c22000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/=
libc.so.6
> b7c00000-b7c22000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/=
libc.so.6
> b7c00000-b7c22000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/=
libc.so.6
> b7c00000-b7c22000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/=
libc.so.6
> b7c00000-b7c22000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/=
libc.so.6
> b7c00000-b7c22000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/=
libc.so.6
> b7c00000-b7c22000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/=
libc.so.6
> b7c00000-b7c22000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/=
libc.so.6
>
>
> After:
>
> root@testvm:~# uname -a
> Linux testvm 6.9.8+ #1 SMP PREEMPT_DYNAMIC Fri Jul 12 15:23:07 CEST 2024 =
i686 GNU/Linux
> root@testvm:~# for i in {0..9}; do cat /proc/self/maps |grep libc.so |hea=
d -n1; done
> b7cf3000-b7d15000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/=
libc.so.6
> b7d7a000-b7d9c000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/=
libc.so.6
> b7d8b000-b7dad000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/=
libc.so.6
> b7d4b000-b7d6d000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/=
libc.so.6
> b7d64000-b7d86000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/=
libc.so.6
> b7d15000-b7d37000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/=
libc.so.6
> b7c9e000-b7cc0000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/=
libc.so.6
> b7d68000-b7d8a000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/=
libc.so.6
> b7cf6000-b7d18000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/=
libc.so.6
> b7ce6000-b7d08000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/=
libc.so.6
>
> So:
> Tested-By: Yves-Alexis Perez <corsac@debian.org>

Thank you so much. Will submit the formal patch soon.

>
> I didn't try on other 32b architectures though.
>
> Regards,
> --
> Yves-Alexis Perez

