Return-Path: <linux-kernel+bounces-571893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608C5A6C3F7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C949467CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA0722FE1F;
	Fri, 21 Mar 2025 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEhrZuKf"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1571E7C0B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742587856; cv=none; b=EfQsMUZlfmhfi+6BImZHzF0EtB66MQ+8pJ/GI/VL3FLOLHHkAChMDik6YemrlNGTuW57YJ+2kHBA5wwcNtyatQhZYyTEVeLzXMGshdVpNbvt0plvxtlBmqjruaAGPunO4I1DDMJtRaX0JYWgCMXMJ1Ksh3MiSwAjWUWEv0vX4tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742587856; c=relaxed/simple;
	bh=oBFmbXLTCOlolb4HJN8KpRNx8Ol2RR9NblxDlUHFW9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtVrWPath0ev6Zfs0IfPz5eKuGyeCg4Q4sZDWazrmDaoD4LXo0sfPPqk2ASBHxzfZ1yv7Gz3ndVq/HhX1GajjlP29tnqA0NeKMz9HxjxAtTwWXpTC5YwWqQcxDcgJkWoCgTuZbbElYMOP0TSkZXtquqoiXvZueXMPM2kiLL1iFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEhrZuKf; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso4172686a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742587853; x=1743192653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIXEPjm+bWQMQJYnXAQ9zjO/eTYMnsh8kj9KsEqXiMk=;
        b=fEhrZuKf8p32T+fyUdJ+/tFFLedGM6VKnkmpCk4mxQd+n/+WxqTdFsUGwaA/cDV7wK
         ZgT9buJKKPOa4Bk4/CrXhMbP+wk1hvahKUmJVEZ9B0JXbrXAcQGvCmREkwfWPZ+AUcoC
         nlIG0zrccW1BEAmwkRRRFd6i2Qu/dxhvp7eYGjvSr7gMk5FxltGB+KnMPw6L+Srdaemv
         uB3TF/E8PfoUOxesRVpErd2ruiUNGFGHJHJ1zRU1bWnrz+fAVOkjXzWLzZWWALsIEO5V
         j2liSZJIlt8wDviKUMoPbvWhW7pN+wvBXh6YEL/weLGKXq9EEDz3S+ZCIMaNYpn3+S7g
         1PKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742587853; x=1743192653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIXEPjm+bWQMQJYnXAQ9zjO/eTYMnsh8kj9KsEqXiMk=;
        b=cHo0Uk1C1VWpLqnJNm+qONWOjJAd5yNezIbZRieIdXMDQhv3gGGTn8qJl7OLd/nvf3
         neWK4DNxltxLcB/MJ5BHwlKXWd4L82j2s3/c8HHWxuh2Z4pWf6ZUKy1BvVJcF32u9+KY
         EbUJ2Mfiz/fHxKPDbqiOd5//P9rdiQS3WZV7/Ig7hUctUuREStD/a0sGA3JxOXSpi2vM
         +JKKIciCE4reHHaXEFjrN8/DrqrxhATr2yrhR5aLO/xkfMIvmK9ULdWeIz1R2CL5ko/5
         nVgnEtg6sON6T6g1K7URGzdmJPmKDEQ79i91BQukQBKHK4gb17gH3WYz/Sf7FaOojZWH
         Gejg==
X-Forwarded-Encrypted: i=1; AJvYcCUHtHb/3icbAXUuiE3wTIbSpb0SopJqKNByNmdPRZ6vpmYeNG5xbkTbmIHgAJ6XkULNkxJuDSrJ41PqId0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMVZATR2ilT7GcTiXdhcxarockyZq3H8sy4G3L/Stj7OhchWmf
	UeBcpWh8pfylu2VOXWIqsYbXZwyZ/H4RRW315fZpmCCU+eftKLJOwDig4Pt0cU4M6xcJHOCcqvG
	mEzDW8gQIx34WHIZFnc1jUBK6QHk=
X-Gm-Gg: ASbGncs+N/+rk/nPaSrxDrVOfARuTtyTnIr/No7SerMxs3dcRm7zjvPrl9uZPkmdibe
	H2PpCiwQMtt0O8eLic1Q1AyPUKM91PDtJSmzoGECIflhkb3fur2eU1RHFBckeSSjlK85ZgR41hH
	Njh7aJLXVDtAHbHYwdits+PFuOTQ==
X-Google-Smtp-Source: AGHT+IH30x1YkLwjN2HebhAwoyQ5GpENDgh5sMfBLXNJzGCiHLIlXgrbOS+6f2Q2h3VuJKHwht93h61HlX8RX21MmIY=
X-Received: by 2002:a17:907:7292:b0:ac2:88df:6a5b with SMTP id
 a640c23a62f3a-ac3f251ba1emr468617766b.42.1742587852719; Fri, 21 Mar 2025
 13:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320190514.1961144-1-mjguzik@gmail.com> <CAHk-=whd82fzhEbFRw9d_EMtR1SeefOJabjCHcm4-6jzeqqd3g@mail.gmail.com>
 <CAGudoHGNFT+LC24842ZKLWBxD3vvvddBqDKa6gkixN4Esor+RQ@mail.gmail.com>
 <CAHk-=wjo__Bj3JNw_7E8HhTDUF65LVOApvN0D2cofgotJoqpmg@mail.gmail.com> <CAHk-=wjxi0poUzCd666Kx5wCjgOwN5v=-zG8xSAL7Wj_ax8Zvw@mail.gmail.com>
In-Reply-To: <CAHk-=wjxi0poUzCd666Kx5wCjgOwN5v=-zG8xSAL7Wj_ax8Zvw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 21 Mar 2025 21:10:39 +0100
X-Gm-Features: AQ5f1JqHE84S56Y_JvE-pFKA7cyBgBi1agxUj7cy2UZWE968t64_VPNtPP2j_Wc
Message-ID: <CAGudoHHjk6PXU33CqAX6oitbEED-jzs2p=Dfm5-q_xMy5Cy_Uw@mail.gmail.com>
Subject: Re: [PATCH] x86: handle the tail in rep_movs_alternative() with an
 overlapping store
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86@kernel.org, hkrzesin@redhat.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, olichtne@redhat.com, 
	atomasov@redhat.com, aokuliar@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 12:53=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 20 Mar 2025 at 14:17, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, 20 Mar 2025 at 12:33, Mateusz Guzik <mjguzik@gmail.com> wrote:
> > >
> > > I have a recollection that handling the tail after rep movsq with an
> > > overlapping store was suffering a penalty big enough to warrant a
> > > "normal" copy instead, avoiding the just written to area.
> >
> > Ahh. Good point. The rep movsq might indeed end up having odd effects
> > with subsequent aliasing memory operations.
> >
> > Consider myself convinced.
>
> Actually, I think there's a solution for this.
>
> Do not do the last 0-7 bytes as a word that overlaps with the tail of
> the 'rep movs'
>
> Do the last 8-15 bytes *non-overlapping* (well, they overlap each
> other, but not the 'rep movs')
>
> Something UNTESTED like the appended, in other words. The large case
> then ends up without any conditionals, looking something like this:
>
>         mov    %rcx,%rax
>         shr    $0x3,%rcx
>         dec    %rcx
>         and    $0x7,%eax
>         rep movsq %ds:(%rsi),%es:(%rdi)
>         mov    (%rsi),%rcx
>         mov    %rcx,(%rdi)
>         mov    (%rsi,%rax,1),%rcx
>         mov    %rcx,(%rdi,%rax,1)
>         xor    %ecx,%ecx
>         ret
>
> with some added complexity - but not a lot - in the exception fixup cases=
.
>
> This is once again intentionally whitespace-damaged, because I don't
> want people applying this mindlessly. Somebody needs to double-check
> my logic, and verify that this also avoids the cost from the aliasing
> with the rep movs.
>

I think the code works, but I find the idea to be questionable.

I'm worried what happens when the consumer has a nicely aligned target
buffer with a nice size (say, a multiple of a cache line) which this
is now unconditionally messing with -- are some uarchs going to
suffer?

That aside, this executes for any size >=3D 64 bytes. The start latency
is pretty high and the 64 byte limit is probably too low even without
the patch. For the 64 size in particular there will be only 48 bytes
handled by rep movsq followed by 16 bytes of regular stores, largely
defeating the point of avoiding the regular mov loop. If going this
way, I would bump the threshold to punt to rep movsq by at least 16.

I would bench it myself, but don't have appropriate hw to do this sucker.

All in all, for the time being I stand by not messing with this bit
(i.e., sticking to just my patch). Serious benchmarking effort should
instead accompany rewriting the routine to begin with (along with
sorting out memset and memcpy to both use overlapping stores and rep
as needed).

However, if you are looking to commit this thing anyway, you can feel
free to roll up my change into it without credit -- it is kind of
stock standard for this kind of work.
--=20
Mateusz Guzik <mjguzik gmail.com>

