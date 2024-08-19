Return-Path: <linux-kernel+bounces-291735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C4495660C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B62E1C21CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C020D15B560;
	Mon, 19 Aug 2024 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy2nHaH9"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9900C14BF8A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724057569; cv=none; b=Jxd4MpNj6ysgr67uxsUC6jB1myRZPINNItrbXckq5UwcQE0863c4nKBdMrSllZ4LRiGfaDBtxb+1tB05jMKwxfiJdEpOLuEUrQ6qDnDJGUjlx8uwXN52dsFHLUM53U2EwM83vbdq0TnJfFnvdmOjXu4kutowrlqkfihIF64IBmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724057569; c=relaxed/simple;
	bh=T5chdCGstKz2GQrS2kG/64adcjjI1jnaYsuqfnGBHws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlseA3s744osnmuhyew8TVfztovXLZf/81T/ykvq2fcckEYIqzlVsBvt/nwS3oQTg1qooI5ILOU7YSQtp/atHWLuT2ueWOfrCZZpV01E/25fUL/Bi4Qc0L9dCABm9bDeEuI08KccJSc4nLdm3fRwOlKEYE4ot3i+Evy2zwqmX+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oy2nHaH9; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4f6c136a947so1929265e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724057566; x=1724662366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5chdCGstKz2GQrS2kG/64adcjjI1jnaYsuqfnGBHws=;
        b=Oy2nHaH9XooYX65Nh4m2efKaZUgsbXOheXJGV3o78yvOJnwHa2WRUCzZnB01e4aawV
         UR0aVU3wbSUxXKK2VI6MgyuAWrV/XKwMk9LdiaWkLyqekb0ANfYmU8GCYTEHO5MYhWwj
         Vd6w25iYMAF+hFGq5nbLbQG91AnQoGsjoBVjH3WIS0zu+C3qDLOoDvRoqj2EjCuS9Pin
         IIgjqL1P1dUnnRiuYgvZTnJUt5uCDUbQq6KcrP1otecHmm1HgbijCbEuAiW31C24hSjr
         rknXVmShXXAUFvv8IAWwD1AHYQT3lZbZRFyaXYnEeFccZ6AtZaJCOxngH9TuhcFj1Dn5
         4X1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724057566; x=1724662366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5chdCGstKz2GQrS2kG/64adcjjI1jnaYsuqfnGBHws=;
        b=vpngYS2k+5lR4nUA0ZH/VCVgHwayerpKG2t3GrDPDXKFtbiWC5pKbVzOX7hHj4qqBD
         lsCv9qSXenE95n1/rsMRrA48uF+COzPKndvgAfhJVPQRsBxjWQWvI9Uq13fyCjGKukJA
         iDIquCgkz8ffN3pz6E+AtNKOnPa/i9hh7BJkDL3e5AHECqzJVV00CrWXuKCnkzKPoCeO
         8gUmHB5i6HBeiGJ6xcukpWwyYHXTakF/YlYFaqMMpwtrR6guk3bjky/9eAMEi0wunMnR
         lDpy9ZkLegtPZgBSEJ1bWDQHShsoGYzCSwei9SGx8qEKdK3wfNygjCXD2ZeA8JD/sFGU
         /RAg==
X-Forwarded-Encrypted: i=1; AJvYcCUINOL0iqsGudmt5spOh/O92QW9TpjUM2XZTId3amuDgqMO74eCbgTxeaVfLSVGzYtGuZzNa6FOgdowWjnD40LcVX17g91sesJbRz7F
X-Gm-Message-State: AOJu0YxVYyzLVb4OkYOUOU4yqosk0eaeckGdz0iDmDiTm2jr2dYk+oGJ
	zTSgLvG3i0p+Jl0G/iwJX+vcXN1+P4vcAxd0La92c0agj3rp6dS+kApKAAzkZ4UvgVAHCSSU1Ki
	8OxDfHfBd7IqJM13JSaoKfzetCdk=
X-Google-Smtp-Source: AGHT+IEpHyWNl04LZuaLolZ85bfdEpT6t4WsvZXZV5km2djGlvxgDnpQ3AwcVCe+cguEt27JTvZVvjECqMan+18xDK8=
X-Received: by 2002:a05:6122:291a:b0:4f5:2aa9:a447 with SMTP id
 71dfb90a1353d-4fc6c9f26c5mr10666129e0c.11.1724057566337; Mon, 19 Aug 2024
 01:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811224940.39876-1-21cnbao@gmail.com> <CAGsJ_4yMu=aaQZEXtcwCdMgrxUuqQ-9P1AiqyyVLfehD_-my9A@mail.gmail.com>
 <c817bf05-a9fa-4fb9-b8c6-a1de5a44e59a@redhat.com> <CAGsJ_4xaTSu2_F3VaR7Y3bOz2+W9XRU9kS3j7Hatojc6ocpOWQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4xaTSu2_F3VaR7Y3bOz2+W9XRU9kS3j7Hatojc6ocpOWQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 19 Aug 2024 20:52:35 +1200
Message-ID: <CAGsJ_4y30MVPDrE24okwxi5MYwM6o1ZnK0Vdub+DoEgWnM6+FQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mm: collect the number of anon mTHP
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	Usama Arif <usamaarif642@gmail.com>, baolin.wang@linux.alibaba.com, chrisl@kernel.org, 
	hanchuanhua@oppo.com, ioworker0@gmail.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, ryan.roberts@arm.com, 
	v-songbaohua@oppo.com, ziy@nvidia.com, yuanshuai@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 8:33=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Mon, Aug 19, 2024 at 8:28=E2=80=AFPM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 18.08.24 09:58, Barry Song wrote:
> > > Hi Andrew, David, Usama,
> > >
> > > I'm attempting to rebase this series on top of Usama's
> > > [PATCH v3 0/6] mm: split underutilized THPs[1]
> > >
> > > However, I feel it is impossible and we might be tackling things
> > > in the wrong order.
> >
> > Is just the ordering suboptimal (which can/will get resolved one way or
> > the other), or is there something fundamental that will make this serie=
s
> > here "impossible"?
>
> i think it is just the ordering suboptimal. Ideally, mTHP counters can go
> first, then the new partially_mapped feature will rebase on top of
> mTHP counters.

Sorry, please allow me to ramble a bit more.

The nr_split_deferred counter is straightforward and simple without the
partially_mapped feature. Each time we enter split_list, we increment by
1, and when we leave, we decrement by 1.

With the new partially_mapped feature, we can enter split_list without
actually being partially_mapped. If the MTHP counter series is processed
first, the partially_mapped series can handle all cases while properly
clearing and setting the partially_mapped flag. These flag operations
need to be handled carefully.
Currently, I notice that Usama's series is clearing the flag unconditionall=
y
in all cases.

In simple terms, mTHP counters are just a counting mechanism that
doesn't introduce new features. However, partially_mapped is a new
feature. A better approach might be to handle the counters first, then
ensure that the new feature doesn't break the counter.

>
> >
> > --
> > Cheers,
> >
> > David / dhildenb

Thanks
Barry

