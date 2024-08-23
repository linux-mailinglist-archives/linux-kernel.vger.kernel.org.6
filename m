Return-Path: <linux-kernel+bounces-299457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2026495D4E2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AAFC1C22A0C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F273191F64;
	Fri, 23 Aug 2024 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/rI0KwC"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0AC18E057
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436427; cv=none; b=a5ixSf6ixtXdW58o9Sp5ceN1sVINDU0wncKwdmkZeMVtYCzqoNDhls3U1LBj+U53dl4l2wX2YMEEfdmyYIkNcTEtzY/IYPTpvDt2YUDs/JytDZTR3g2EcVkSUlfaQdPgLXEzzq/wILWgQcV4vvFNaGNcifFeGZp5KF7v9gPEmZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436427; c=relaxed/simple;
	bh=ggtneU6z29BiRV+s2RizZtMl3ppNE9PzWM10CsVlabI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUy2JrCtSJVBSK8qlHPG8BBZkoNbwxLdFDR7x3sevApDCUroDAYoy4J075aqkzlW56eLHsvXmSDUOdn8XpEaDcWbJ7zqeetKJbYdvHRLb7bG8ICbeUjmDnPIWJeYjm9McU0UpwvN1R4np4DXnOVEFjbOe2VbCCxKEgbYBTq4HG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/rI0KwC; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5dccc6cdc96so519781eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724436425; x=1725041225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpgh31z9NlGdlITa1fFDfgoc4AKpZdcCLAm16vs4/MM=;
        b=c/rI0KwCCb0Oix1VzfSbDiBc9UseU/+4+LzCe4ZhBLNewQlQw3uQLRTu7L316fcaFt
         7WTlDAEtWCIBXkvyAZ7n4z3O/9jatvy580ohdzj4KnNlPx6ueastR0ErKXC2sRz2aHdA
         biS0/Fz4zxfAulIQDYhJLiEPf/9rJnLZ1Qzfgp5to9NvrlXfjsamdUAFgLFDXBjNHBwN
         MBg38NIHbvg3vHfBIsY4N/8Rr2mfRJvnhZ5/CfBSBeq2SaREtpfSxhirRKnQibGQKt1j
         Zn2R813wpoGyjSOagbQKQIYmFFPR+iR0s+YDsna5LMLw2OL5E2Yu2Qyx92G3Q/J8T97f
         uKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724436425; x=1725041225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpgh31z9NlGdlITa1fFDfgoc4AKpZdcCLAm16vs4/MM=;
        b=crtyMkZKuFPQzOROn8tSRESY+rFYrEsJBXOWLoNm5mJG20do+K6jpzszAs5IxPrYML
         ybl27WvBgnqYzhl2Y+/d5TwUr6t4EIde8UmGMYvlBP4Vv1Ray6bkqcOZpi8xXZA4sz+s
         Poege0lzHH45O1KsmmcMHSbgYLEp+QOzfDz828ldHwdyZDZGHGBCDI9n556vV7tS/O1m
         U8suApS8h6+DlTOSFlvQq7dGJfkFoNsPncKvIhJLgB7d7uL9eimaZaLYmH78+TZqxIkG
         NcbyfTt7TzNTFZw+me42xrIB1rzTuA87vOGieF69lUcR7veej6W5aSk1qv/qFbw+xbp/
         eKCw==
X-Forwarded-Encrypted: i=1; AJvYcCWWe0CMyG0anrkfOccJraeSMkYnQY8YiYlRn/0A/Fk9tdvzTUlkBNVacDp2eO6VV9911SqIe8YhDZUXA98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl+ITTNmRr3nEU6efLyPZFFDiP+NE/0c1Y1GIfJ3zvXLWm8vey
	RF030fyE1VRrwfAJEIYwH9CJQhG7zx2TFuCI0KQFvJF9350sZDVNyQfGZV8IICat7c9NV/E743g
	mF7RnbXcAHptp6S6dE49Bi5Brf7nR43i/
X-Google-Smtp-Source: AGHT+IGEXqYJ4XE5UaIgMWPe4gXgslzxa2GlWa13l20lAXEX1G3nCklEFxaTPJ4BX5NEP4cBklJ3DR9np92KXeFhKNg=
X-Received: by 2002:a05:6820:206:b0:5d6:ae6:a852 with SMTP id
 006d021491bc7-5dcc62754c8mr3354442eaf.6.1724436424921; Fri, 23 Aug 2024
 11:07:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info> <ZsiLElTykamcYZ6J@casper.infradead.org>
 <02D2DA66-4A91-4033-8B98-ED25FC2E0CD6@gmail.com> <CAKEwX=N-10A=C_Cp_m8yxfeTigvmZp1v7TrphcrHuRkHJ8837g@mail.gmail.com>
 <9793DBCA-13F4-4B47-AD57-12A62F7DD8DD@gmail.com>
In-Reply-To: <9793DBCA-13F4-4B47-AD57-12A62F7DD8DD@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 23 Aug 2024 14:06:53 -0400
Message-ID: <CAKEwX=MZo4qTED6gtQYSGxgY6CBJYREhgbhTOqvsjhnFt7YwdA@mail.gmail.com>
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 1:24=E2=80=AFPM Piotr Oniszczuk
<piotr.oniszczuk@gmail.com> wrote:
>
>
>
> > Wiadomo=C5=9B=C4=87 napisana przez Nhat Pham <nphamcs@gmail.com> w dniu=
 23.08.2024, o godz. 18:16:
> >
> > Have you tried with 6.9 yet? IIRC, there are two major changes to
> > zswap architecture in recent versions.
>
> No. But now building vanilla 6.9.12. Will install and see=E2=80=A6
> (This will take some time as catching issue needs days of compilation)
>
> >
> > 1. In 6.9, we range-partition zswap's rbtrees to reduce lock contention=
.
> >
> > 2. In 6.10, we replace zswap's rbtrees with xarrays.
> >
> > If 6.9 is fine, then the latter is the suspect, and vice versa. Of
> > course, the minor changes are still suspect - but you get the idea :)
> >
> >>
> >> btw: we can go with elimination strategy.
> >> So what i need to change/disable to be closer to finding root cause?
> >
> > Could you let me know more about the setup? A couple things come to my =
mind:
> >
> > 1. zswap configs (allocator - is it zsmalloc? compressor?)
>
> Well - I=E2=80=99m not using zswap.

But the bug happens in zswap path? :)

Could you do:

grep . /sys/module/zswap/parameters/*


>
> [root@minimyth2-aarch64-next piotro]# swapon -s
> Filename                                Type            Size            U=
sed            Priority
> /dev/nvme0n1p3                          partition       16776188        2=
94164          -2
>
> >
> > 2. Is mTHP enabled? mTHP swapout was merged in 6.10, and there seems
>
> I don=E2=80=99t have used config at the moment, but /sys/kernel/mm/transp=
arent_hugepage in I see:
>
> =E2=94=82/hugepages-1024kB
> =E2=94=82/hugepages-128kB
> =E2=94=82/hugepages-16kB
> =E2=94=82/hugepages-2048kB
> =E2=94=82/hugepages-256kB
> =E2=94=82/hugepages-32kB
> =E2=94=82/hugepages-512kB
> =E2=94=82/hugepages-64kB
>
>
> > to be some conflicts with zswap, but Yosry will know more about this
> > than me...
> >
> > 3. Is there any proprietary driver etc.?
> >
>
> Only 2, both ryzen9 monitoring related:
> https://github.com/leogx9r/ryzen_smu/commits/master
> https://github.com/ocerman/zenpower/commits/master
>

The reason I asked this is because I've seen proprietary error
screwing with memory in the past - it was an NVIDIA one though.

https://lore.kernel.org/linux-mm/CAKbZUD1-kqfuV0U+KDKPkQbm=3DRwzD_A1H3qk_c+=
bw92CqtMbuw@mail.gmail.com/

Also decompression step failure (albeit in the writeback path)

