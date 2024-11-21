Return-Path: <linux-kernel+bounces-417077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6F39D4EB3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0E12826FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2064D1D9350;
	Thu, 21 Nov 2024 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZ6qoYJP"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF95020330
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732199511; cv=none; b=mgg/u/r40WFP0NHr/0T4pqqpo0UGc24pm72Pe/1/DOxNiFaRJ48ni/2uLYAO3Fa0rd5FnDkBIk0e9z2Dyn/F+rlldsc0gxbH+2+cYA5vo8wsFrnXmuQAn7t+4OuMnk2OWRlshlF+u6edpsxkB+zwCRvuBjH/GM1LbevWkleFGo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732199511; c=relaxed/simple;
	bh=xuIhtgaMlUOIv9x7NYBJIVaGk7rVNEaXmCZRykzFVDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/tAygQu/6LLVNfnVnBj8PbCQzvlAXdqB1aSsBIiNgsYqmJdh/GTRyz+P8C/Ut/oC5miLPFbXxO6tDRvFT5IFFptKa0JGvXtZcHIC8PXOtG3qAqWTcu/CPliL1lfQ5uQwuikXPn/SK3Qe63k2pwtuQ/uuQB85NIrOL/2pXz/C9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZ6qoYJP; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d41ac03343so7940916d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 06:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732199509; x=1732804309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKPZc/x77KFHTZg9A9aYwVBIztc4o+fw2bfEVf84FTE=;
        b=AZ6qoYJPEzMwV+2qbX4zZ2oaJNNhz6P5ZS5YkD5S0iCQ+WKry38l4T5KGa5s6dvA/K
         vlTMbrQ7bXf8t3rDV7fNomHdHySigJKla0nFpPCu6k66j0lNBuwX/5ud0KtL+EKfiZew
         zv8Dbx/W3XCtVSjaVbQ0J8Oc8GlURKfGwU2BKrkOmzh40pdsOxk+RLT7tmLJ3vvQkwu3
         v9bgqXRdrnhJxZZWhN63VuLCBGYMdXiL/SQvJCPwCsKUhN4XB6LW99v+vrYeLDnPn+H7
         w9+IAr1lAzcHUOOdYVlrfAWPe9Ka5jm7icIOFHTVZcTwh6fjXVHLNs0uBKTHZSlKGwQh
         L8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732199509; x=1732804309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKPZc/x77KFHTZg9A9aYwVBIztc4o+fw2bfEVf84FTE=;
        b=TkZrph/VYXtFpp4JVt0uMGe9Ra2kYyzWg1e7b0fvUbWyOwoWOA3AJc4nsc/Od7dGB4
         6jrHvtTbdd0JfOfmcsdMTQ0rAPqWn3D82MY0t6IWsuj0rnAoCXR14bQmfCWAKtUc+cJm
         Kk7wHoDtMVLK+Vgd5n/VO1wSgUTXTpt8fN99rxEecKtM/pI0TWgC2AMQh5Fqq91zTjjO
         4dETRTSju/eRZh9FhCGUkUjmTC8EV+5OrNq87Y5HDARJAPilL9j7eVhJLo99EU9sAjQm
         woIFf6EexsohDj3G2au2D2du3ZLAGJhx7ksvGl0uUIkwMC2x7j8yJziluYJ5EPl14zs6
         nUrA==
X-Forwarded-Encrypted: i=1; AJvYcCWwR3eZ75Igd1rjnrxguQz4L2jbg9kzYU+MG2ZmVB9Gf5YEE97dt471w9LopeNgLv0nJ9GcZLA6HtoHPp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YziwIOmAJWQhMbeMGAL6mx1SHhcwJ8QfD7dAjNdRcR0hKDIrgt0
	7y3xGNeByyj8xyFPCqP34Z/uxbtAdYdHpBhswsnBKRXZdYi3j50jQdGl9FIn0kJwsw3BLgQd/78
	71cYAWnOtMCuwYeYndQPaSRaw8T8=
X-Gm-Gg: ASbGnctc3CylLVu7YbFD+pMsr4awcBA7PKFD8yIHCslN2ll+4kM14XQrJ0VmHeIflVu
	SqLuNhuUy/CohzskONo1Xg1DARJD6uvxZgA==
X-Google-Smtp-Source: AGHT+IEDRn19JVPzduaMlA53SHNv33NfKcP24Uwn24a5w8PfzF1BQXNgOH5nTnVqGO8X4gA/fjpu1bWfMxBetS1S+0c=
X-Received: by 2002:ad4:5fc5:0:b0:6b0:8ac1:26bc with SMTP id
 6a1803df08f44-6d4423c8204mr52416676d6.14.1732199508839; Thu, 21 Nov 2024
 06:31:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120122858.22190-1-laoar.shao@gmail.com> <0aa9f3bd-b1b6-4089-b9eb-5b72d7a1541a@redhat.com>
In-Reply-To: <0aa9f3bd-b1b6-4089-b9eb-5b72d7a1541a@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 21 Nov 2024 22:31:12 +0800
Message-ID: <CALOAHbBMebKtsRnfOFvNKorQk_4KGoCzKd0JcYv2p6pXhJqYbQ@mail.gmail.com>
Subject: Re: [PATCH] /dev/mem: Add a new parameter strict_devmem to bypass
 strict devmem
To: David Hildenbrand <david@redhat.com>
Cc: mingo@redhat.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 4:51=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 20.11.24 13:28, Yafang Shao wrote:
> > When CONFIG_STRICT_DEVMEM is enabled, writing to /dev/mem to override
> > kernel data for debugging purposes is prohibited. This configuration is
> > always enabled on our production servers. However, there are times when=
 we
> > need to use the crash utility to modify kernel data to analyze complex
> > issues.
> >
> > As suggested by Ingo, we can add a boot time knob of soft-enabling it.
> > Therefore, a new parameter "strict_devmem=3D" is added. The reuslt are =
as
> > follows,
> >
> > - Before this change
> >    crash> wr panic_on_oops 0
> >    wr: cannot write to /proc/kcore      <<<< failed
> >
> > - After this change
> >    - default
> >      crash> wr panic_on_oops 0
> >      wr: cannot write to /proc/kcore    <<<< failed
> >
> >    - strict_devmem=3Doff
> >      crash> p panic_on_oops
> >      panic_on_oops =3D $1 =3D 1
> >      crash> wr panic_on_oops 0
> >      crash> p panic_on_oops
> >      panic_on_oops =3D $2 =3D 0            <<<< succeeded
> >
> >    - strict_devmem=3Dinvalid
> >      [    0.230052] Invalid option string for strict_devmem: 'invalid'
> >      crash> wr panic_on_oops 0
> >      wr: cannot write to /proc/kcore  <<<< failed
> >
> > Suggested-by: Ingo Molnar <mingo@kernel.org>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >   .../admin-guide/kernel-parameters.txt         | 16 ++++++++++++++
> >   drivers/char/mem.c                            | 21 ++++++++++++++++++=
+
> >   2 files changed, 37 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index 1518343bbe22..7fe0f66d0dfb 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -6563,6 +6563,22 @@
> >                       them frequently to increase the rate of SLB fault=
s
> >                       on kernel addresses.
> >
> > +     strict_devmem=3D
> > +                     [KNL] Under CONFIG_STRICT_DEVMEM, whether strict =
devmem
> > +                     is enabled for this boot. Strict devmem checking =
is used
> > +                     to protect the userspace (root) access to all of =
memory,
> > +                     including kernel and userspace memory. Accidental=
 access
> > +                     to this is obviously disastrous, but specific acc=
ess can
> > +                     be used by people debugging the kernel. Note that=
 with
> > +                     PAT support enabled, even in this case there are
> > +                     restrictions on /dev/mem use due to the cache ali=
asing
> > +                     requirements.
> > +             on      If IO_STRICT_DEVMEM=3Dn, the /dev/mem file only a=
llows
> > +                     userspace access to PCI space and the BIOS code a=
nd data
> > +                     regions. This is sufficient for dosemu and X and =
all
> > +                     common users of /dev/mem. (default)
> > +             off     Disable strict devmem checks.
> > +
> >       sunrpc.min_resvport=3D
> >       sunrpc.max_resvport=3D
> >                       [NFS,SUNRPC]
>
> This will allow to violate EXCLUSIVE_SYSTEM_RAM, and I am afraid I don't
> enjoy seeing devmem handling+config getting more complicated.

That poses a challenge. Perhaps we should also consider disabling
functions that rely on EXCLUSIVE_SYSTEM_RAM when strict_devmem=3Doff,
but implementing such a change seems overly complex.

Our primary goal is to temporarily bypass STRICT_DEVMEM for live
kernel debugging. In an earlier version, I proposed making the
fucntion devmem_is_allowed() error-injectable, but Ingo pointed out
that it violates the principles of STRICT_DEVMEM.

Do you have any suggestions on enabling write access to /dev/mem in
debugging tools like the crash utility, while maintaining
compatibility with the existing rules?


--
Regards
Yafang

