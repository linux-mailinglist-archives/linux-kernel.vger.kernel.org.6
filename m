Return-Path: <linux-kernel+bounces-216675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A608090A2E0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 05:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB0A1F2213D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A558A208A7;
	Mon, 17 Jun 2024 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMyKR0X1"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439FC33C5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718595009; cv=none; b=m1WSVyap3vfuIXZvhuynanFG8AydTXKdidQyQlCALXBv1nTSbCG9oYjHu9ID950sNlkOhQek0OK78W8N5JkgTIa6CMzPLOC+qSkMuYRrO6mlzWwkxEzdy9rw61/S/fwZln6talIJB+14E/yecVnFuniG5jcdWT5a2+WjFYmwVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718595009; c=relaxed/simple;
	bh=mMTdcwzRx+QhcJKIaqk0t/n9ZYBKgBovH2g9ij8z/78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QvJai2bSRL9+eN0NaD/UNh0B/R3y+FOBHL2ejEKg/5v1bC0DnIRXwhGFLpo4v5cK60Co6GLK3aownTtaMVAXjFAiq+I13Px1Kv4c9zQAuhwO+oibI+ivQ+JvbcqBujW6aEXv3e5Bu4t9E6XwwrL0HbVlRvkyOOamMFobf0yju8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMyKR0X1; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-80b8fd76e6dso1999350241.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 20:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718595007; x=1719199807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVE2ZGR0YoEn9niDLED97otBK85UxDw7u1+BiRikU6k=;
        b=jMyKR0X15btfoh/dg1hgHubwZLF4gc0FrczfzGVhYddXZEfdweO8JBlg46yzGS+9Hy
         QeZUIPvUhZIm/HAofI/R6y0Zo1Z2SwqhzLi9fRO6FXhtqwjJfYJJtURKVLYeVb4nhJHm
         SCfbY2Zh3uhoFQxuO+DNQd7XZnOtCOaYAab6VbIE/sYX1uCIUVu5CK6ZsEAJQsL/fJEa
         TVrxs1pIeEWvxDoD8c4BLFHpG6UH3NTrQy8mdq3kaGJH6OGkPDdkmyIJKELyTMsMcawL
         1H4iL6SOPu+ZiBFqDQUYl4rxed4/emdGwhOhG021lzM5dRe1Ri2sqls4p8u8c/uyGyXG
         gG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718595007; x=1719199807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVE2ZGR0YoEn9niDLED97otBK85UxDw7u1+BiRikU6k=;
        b=POgWP+1377XC4+m92NsuzUWX68snMOBMimlxhakTXnu6ti35onFurqQzwOdq95CgZD
         TU6PANzmKsbs14XBp6JZiaFE4DDTcqnha3n68KgRPaaQKf6pcgY87UFkvyNLqg842Mgn
         43ILvbGZ8/j8go2G20kIId8Y7S93PqEfey5PIg/jIrT1Ajru2IfNPC4Rayu8cd5S6iUE
         eW4TQSgKIlNHED85MD493feKUiIZoEQGQ/Is7N0ktsCYYVh/dWMcdITbiAYN2TUgi0lk
         3Sg6bgUgx+fqIXMby1boXGcoCO5iToRMo5NtYx0WE80mnvEPvtV/GXdW461Z/QXP3Hcv
         G5rg==
X-Forwarded-Encrypted: i=1; AJvYcCWrcqxvxEF4zBDpt9pqevKHj72j3zSl14khGcPz8aXZmXUVCORJxQ8MpBtqck2RoVGu1Ye8ptZe5sl39zRKeBMd0uIjn8LGP3gO++/z
X-Gm-Message-State: AOJu0YymSuEyP5x4im9WqK1yGVnfMpbNfdK9hfgQZT/27uIcRzb2eoJe
	82YDdilj7GJXXEG/SHZ2R+U0BeUTskNCotSd+m4kzGl0LsrVNdjdA6NO9XXtBxpbFTheUyWkM8B
	my7wKrxOasD4aYeOqokaoUQkVe2Q=
X-Google-Smtp-Source: AGHT+IGmY7HvGHTROV0uCRoY5H4XlD16NGR2L9QNfEfcGVcqr7kRVUjQpe75i6bzfPD2d5pU8bEzFRzpvuNZQGymQPc=
X-Received: by 2002:a67:ecc1:0:b0:48e:f1c5:6408 with SMTP id
 ada2fe7eead31-48ef1c568aemr1230782137.17.1718595007017; Sun, 16 Jun 2024
 20:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614195921.a20f1766a78b27339a2a3128@linux-foundation.org>
 <20240615084714.37499-1-21cnbao@gmail.com> <87r0cw5l3w.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4zDNoQOhgx474mJrwyUbTvWYc1R77o2+DyUDxVRGtv_og@mail.gmail.com>
In-Reply-To: <CAGsJ_4zDNoQOhgx474mJrwyUbTvWYc1R77o2+DyUDxVRGtv_og@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 17 Jun 2024 15:29:56 +1200
Message-ID: <CAGsJ_4zpOgK8-rkv4LoKLDqew1as0-zzgCN=n5vqp5EYC1VUHg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mm: swap: mTHP swap allocator base on swap cluster order
To: "Huang, Ying" <ying.huang@intel.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "chrisl@kernel.org" <chrisl@kernel.org>, 
	"kaleshsingh@google.com" <kaleshsingh@google.com>, "kasong@tencent.com" <kasong@tencent.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 3:12=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
>
>
> =E5=9C=A8 2024=E5=B9=B46=E6=9C=8817=E6=97=A5=E6=98=9F=E6=9C=9F=E4=B8=80=
=EF=BC=8CHuang, Ying <ying.huang@intel.com> =E5=86=99=E9=81=93=EF=BC=9A
>>
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > On Sat, Jun 15, 2024 at 2:59=E2=80=AFPM Andrew Morton <akpm@linux-foun=
dation.org> wrote:
>> >>
>> >> On Fri, 14 Jun 2024 19:51:11 -0700 Chris Li <chrisl@kernel.org> wrote=
:
>> >>
>> >> > > I'm having trouble understanding the overall impact of this on us=
ers.
>> >> > > We fail the mTHP swap allocation and fall back, but things contin=
ue to
>> >> > > operate OK?
>> >> >
>> >> > Continue to operate OK in the sense that the mTHP will have to spli=
t
>> >> > into 4K pages before the swap out, aka the fall back. The swap out =
and
>> >> > swap in can continue to work as 4K pages, not as the mTHP. Due to t=
he
>> >> > fallback, the mTHP based zsmalloc compression with 64K buffer will =
not
>> >> > happen. That is the effect of the fallback. But mTHP swap out and s=
wap
>> >> > in is relatively new, it is not really a regression.
>> >>
>> >> Sure, but it's pretty bad to merge a new feature only to have it
>> >> ineffective after a few hours use.
>> >>
>> >> > >
>> >> > > > There is some test number in the V1 thread of this series:
>> >> > > > https://lore.kernel.org/r/20240524-swap-allocator-v1-0-47861b42=
3b26@kernel.org
>> >> > >
>> >> > > Well, please let's get the latest numbers into the latest patchse=
t.
>> >> > > Along with a higher-level (and quantitative) description of the u=
ser impact.
>> >> >
>> >> > I will need Barray's help to collect the number. I don't have the
>> >> > setup to reproduce his test result.
>> >> > Maybe a follow up commit message amendment for the test number when=
 I get it?
>> >
>> > Although the issue may seem complex at a systemic level, even a small =
program can
>> > demonstrate the problem and highlight how Chris's patch has improved t=
he
>> > situation.
>> >
>> > To demonstrate this, I designed a basic test program that maximally al=
locates
>> > two memory blocks:
>> >
>> >  *   A memory block of up to 60MB, recommended for HUGEPAGE usage
>> >  *   A memory block of up to 1MB, recommended for NOHUGEPAGE usage
>> >
>> > In the system configuration, I enabled 64KB mTHP and 64MB zRAM, provid=
ing more than
>> > enough space for both the 60MB and 1MB allocations in the worst case. =
This setup
>> > allows us to assess two effects:
>> >
>> > 1.  When we don't enable mem2 (small folios), we consistently allocate=
 and free
>> >     swap slots aligned with 64KB.  whether there is a risk of failure =
to obtain
>> >     swap slots even though the zRAM has sufficient free space?
>> > 2.  When we enable mem2 (small folios), the presence of small folios m=
ay lead
>> >     to fragmentation of clusters, potentially impacting the swapout pr=
ocess for
>> >     large folios negatively.
>> >
>>
>> IIUC, the test results are based on not-yet-merged patchset [1] (mm:
>> support large folios swap-in)?
>
>
> no. this data is based on mm-unstable.
>
> the visible impact is that swapping out mthp will have 14% regression if
> fallback againest swapping out nr_pages small folios regardless if mthp s=
wapin is there.

Ryan initially reported 14% swapout regression without mTHP swapout.
then he reported 46.3% improvement if mTHP can be swapped out as
a whole[1].

so we will drop 60%+ performance if fallback. but the 14% regression agains=
t
pure small folios are unacceptable considering more than 2/3 memory can
be swapped out on mobile devices.

So I am hoping we can find some way to merge Chris' patchset soon. though
the WARN_ONCE still indicates some BUG in v2. Hopefully, Chris can fix it
in v3.

[1] https://lore.kernel.org/all/20240408183946.2991168-1-ryan.roberts@arm.c=
om/

>
>
>>
>> [1] https://lore.kernel.org/linux-mm/20240304081348.197341-1-21cnbao@gma=
il.com/
>>
>> If so, do we have any visible effect without that?  If not, should we
>> wait for patchset [1] (or something similar) to be merged firstly?
>>
>> --
>> Best Regards,
>> Huang, Ying
>>

Thanks
Barry

