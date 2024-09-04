Return-Path: <linux-kernel+bounces-315464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C9D96C302
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500B8282866
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E681E2015;
	Wed,  4 Sep 2024 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2XRkFuJ"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3771E132F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465082; cv=none; b=gVrxf6mQqyraPpy4qWTIgRhERnusXTIEEMHUQ0PVNHyLWGet8JGMUiX3UayQUviH97OYMnvyC4FZa+M1MtFhPAn167tzrckwgynk9hwTwZaekf2D2seB5F5wNN0XyJ5AUFynT/pxjOQ4Z+0ITzg1QA3bYTH2+cYJQ6xCJaBqsK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465082; c=relaxed/simple;
	bh=7xBTui12bEiRcxX8z3A7P6Ugy7cEjEwdbVDSyMYHets=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qh2aLcPCXG2FDKOIoQsZlssQyZhOytBnZypoab8MNZWNXiogYn8wFyJjNNH9zpAMaJX0w4NnldTVJU+A8QkAxrw8VNzYQ15FIj8xfcg0QT86qoocIZhAxAAAxGCEp4RpPh+kvtBL16YUqKQQ6sUUTUn+yLyF/Nv/KGwQ+HwyQgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j2XRkFuJ; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70f6bb5630dso374399a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 08:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725465080; x=1726069880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKMS4rvdXYfWNZhahV5vA8q9IrV0MiwByhfPud5Mz+I=;
        b=j2XRkFuJ+ihkNFqwe8gnUq+f85NrGE/pExeWguPYGy4yW16TU3chDJM/zI5jMO/Kx0
         zoq3Tdq1qtgnMNHfHqJEJPmyV28m8aMdM8R5UzzGQXaHXKfSrsmmwzns76Imwj9bTXWc
         zpn88vtGZyxK+6xswl4xBiQ4/xx5EhLNgej9mmpAkMostvuA8LVZjKLCh454I1yP+zeX
         BtqLAxUKHn2H+ZYCTAq674ZeP4hiRTrsshcHWk0a5+cJfkCcjnOj8Qkp1lK4Uf4hxrQV
         kZQhzSemQ2j35r9Cwh/bB5dFe+CdLn5qivRZTfVvktnNw0KYkGTLfLb1qfnJULfASzNX
         /D2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725465080; x=1726069880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKMS4rvdXYfWNZhahV5vA8q9IrV0MiwByhfPud5Mz+I=;
        b=g677hSj2iFX7shp60nISccxTjLf8Orn/lgztzUj813LgUUHt0iAkXJNMAt8TJluY8T
         qvvner/6Vqe42u7lrNLMfnD1BI7RIWdMLT419Ig9Du4skDlUuChhkw7bt98NDg+1ES+c
         g7uKnHQX4YBCfSw3MyORyEX3sICSz49aqJ69CQhC8VSpas5VDZOKilzhTcIKv5jzqAdb
         irdQUdSwMzYvtDTGX5MWA5AdvXyZGPJ/AnRqUmzON0BsQw8STRy7CDzfAI7n9qMmvmfy
         2frX5XHC9l0mYqzr5O/25EkzVvAclD9D4VlkTC2fh6svTanqn+EKbnrtg94RB2eKz5wz
         Tv0g==
X-Forwarded-Encrypted: i=1; AJvYcCXbf5bqCtkyMIPW+mOLx2YYjCOzA2EbgcJPaCsR8USbic/PLbOVGxAmzcWvGU6egZSQhWONLK6eP+5MBPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFAUeLWrcb47SXdkB/8TwStkK9YFYGqti+KAdM2/1U1TVQ8J8G
	WaUGsoDLWxW5v2jsU6tQXlsVgRVZIEtOP0pXYHwFXjz9kt0LQRPEIbNe3ZvrGdr1ZIil0D+ArD9
	F3lxPdiiSxQqhNXlTUzmy1/kXYQphXDTYXm3lAg==
X-Google-Smtp-Source: AGHT+IHFEca56n9mOvv4LLooYyEvcZfkC1nHeTPqDpSwSqfjsY+MFpRuBtREaLkDBbM7XTkZms/F3Yb/3SaX9HtKA3Y=
X-Received: by 2002:a05:6830:6c16:b0:704:4987:2342 with SMTP id
 46e09a7af769-70f68671388mr10684065a34.3.1725465080286; Wed, 04 Sep 2024
 08:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADYN=9JBw6kq4E9aA=Pr1rFy-6tY-j-XOthQVYVw6ptmj11=HA@mail.gmail.com>
 <f3fe6be4-723e-45b8-baa6-5c285cc5c150@redhat.com> <CADYN=9+xONPg=UrApM9xsKs2Um3VDMCi5X0684k0idJv-th82w@mail.gmail.com>
 <273ee480-76b4-4b57-a95b-2849fe394bc0@redhat.com>
In-Reply-To: <273ee480-76b4-4b57-a95b-2849fe394bc0@redhat.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 4 Sep 2024 17:51:09 +0200
Message-ID: <CADYN=9Kic5-7S2yg6xuuG1TSthC2A0yaK7SsHXxw+TM5qh_n0w@mail.gmail.com>
Subject: Re: Potential Regression in futex Performance from v6.9 to v6.10-rc1
 and v6.11-rc4
To: David Hildenbrand <david@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, dvhart@infradead.org, dave@stgolabs.net, 
	andrealmeid@igalia.com, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Sept 2024 at 15:47, David Hildenbrand <david@redhat.com> wrote:
>
> On 04.09.24 12:05, Anders Roxell wrote:
> > On Tue, 3 Sept 2024 at 14:37, David Hildenbrand <david@redhat.com> wrot=
e:
> >>
> >> On 03.09.24 14:21, Anders Roxell wrote:
> >>> Hi,
> >>>
> >>> I've noticed that the futex01-thread-* tests in will-it-scale-sys-thr=
eads
> >>> are running about 2% slower on v6.10-rc1 compared to v6.9, and this
> >>> slowdown continues with v6.11-rc4. I am focused on identifying any
> >>> performance regressions greater than 2% that occur in automated
> >>> testing on arm64 HW.
> >>>
> >>> Using git bisect, I traced the issue to commit
> >>> f002882ca369 ("mm: merge folio_is_secretmem() and
> >>> folio_fast_pin_allowed() into gup_fast_folio_allowed()").
> >>
> >> Thanks for analyzing the (slight) regression!
> >>
> >>>
> >>> My tests were performed on m7g.large and m7g.metal instances:
> >>>
> >>> * The slowdown is consistent regardless of the number of threads;
> >>>      futex1-threads-128 performs similarly to futex1-threads-2, indic=
ating
> >>>      there is no scalability issue, just a minor performance overhead=
.
> >>> * The test doesn=E2=80=99t involve actual futex operations, just dumm=
y wake/wait
> >>>      on a variable that isn=E2=80=99t accessed by other threads, so t=
he results might
> >>>      not be very significant.
> >>>
> >>> Given that this seems to be a minor increase in code path length rath=
er
> >>> than a scalability issue, would this be considered a genuine regressi=
on?
> >>
> >> Likely not, I've seen these kinds of regressions (for example in my fo=
rk
> >> micro-benchmarks) simply because the compiler slightly changes the cod=
e
> >> layout, or suddenly decides to not inline a functions.
> >>
> >> Still it is rather unexpected, so let's find out what's happening.
> >>
> >> My first intuition would have been that the compiler now decides to no=
t
> >> inline gup_fast_folio_allowed() anymore, adding a function call.
> >>
> >> LLVM seems to inline it for me. GCC not.
> >>
> >> Would this return the original behavior for you?
> >
> > David thank you for quick patch for me to try.
> >
> > This patch helped the original regression on v6.10-rc1, but on current =
mainline
> > v6.11-rc6 the patch does nothing and the performance is as expeced.
>
> Just so I understand this correctly:
>
> It fixed itself after v6.11-rc4, but v6.11-rc4 was fixed with my patch?

I had to double check and no, on v6.11-rc4 with or without your patch
I see the 2% regression.

Cheers,
Anders

>
> If that's the case, then it's really the compiler deciding whether to
> inline or not, and on v6.11-rc6 it decides to inline again.
>
> --
> Cheers,
>
> David / dhildenb
>

