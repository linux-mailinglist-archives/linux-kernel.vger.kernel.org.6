Return-Path: <linux-kernel+bounces-246356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 996BC92C0D2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5036128BD0A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F00F18561D;
	Tue,  9 Jul 2024 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ArsdhXo7"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CF4185601
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542288; cv=none; b=D2Zf3pthXMBvorWODHCnriY6RExFS6y71VqnRvxCusmrbMNNZI1KnM7sWLfHtakNQhf7mUR9CNQoOLsUyjEvMPH23i89rBAul4AyBA5LYkG30Up3FperA/QqlEYn528O3TxEDMFslAwttKMa2LoN5CAUpl/G1aW5zvwx+h21fMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542288; c=relaxed/simple;
	bh=GQWEaiUiwKONAlIFbIU4AqVczL/Fs+cS33mEhUh4nww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hi00WOaYjKxWeswkSbIemRh5Cd2grYIv4AzmHsDXOipK+iclRW/GlClHLrpdYMynABA/1L+Ht8jYR/oe7xf3PXuRo7l0u1IliE2ShYoblKSd23hVcQlHKHtSDn/tIrpRyJAVbcXKAfgJlksCWBv3BrPh8yopRjcszGV48pKVYgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ArsdhXo7; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77e6dd7f72so367620866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 09:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720542285; x=1721147085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8dI++N7oMKnriEvMop9NM+PwKTIvjTbwj0rulahrYm0=;
        b=ArsdhXo7B/MMDfzSd3XmJo9nuwURQSylhqXUdQrc8uIwVk4PyOIN6cNIDFbWLAn0aL
         bdKFFexIWjQVIWNueN0y7WPVEL3LR1/RiMko67vmXjYgloFTil2uXmvKuXlAsb9d62Av
         P2Cs+12Qa9tZ/kX8F6TqIjbKQeCP8B+MZ4jTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720542285; x=1721147085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8dI++N7oMKnriEvMop9NM+PwKTIvjTbwj0rulahrYm0=;
        b=FCv7Pu7Kxvgu9yIKm63tKLqy0V39kxSfeF/CscjctUXJdMoIheY09AMyV5XnQrkZG8
         b4CvpcJ/A65ZNC465FLWGLa5pXMte527cIMhMyTBK+HVmQw4erAcJA1Z5KRhwHt051o2
         wJ5iaUlD4kddKNu8vKRkmhtpcI/7vq/AszuSltSWY8Mt75y/0qwiHEEbM64En8kdRehl
         So2+V/ivybIdb5ZlzoXRtmhZ11ISGNSiwLUCkJVnDzD49N46ERtLzSD4ao8bFZVNmV9w
         NHMGree2/GCnrSsRYYG5YqxFhooOxC6/X28VBKS5lfGWmnU7yon99iF7wCUrsCcNBYqa
         zluw==
X-Forwarded-Encrypted: i=1; AJvYcCWMXNdDiYQgZYDlsHVTfr2IOTIJtNUHQ0nGfPUvM6hng6Ww6Y9jfNcMgm9DJR73p0S8A5lm0ObuhJ6q02P3fYyA9Ndd8fS115TKqUO/
X-Gm-Message-State: AOJu0YxOGHObKu1+HHCgeGt5zfXrFM4ofelcDwWl0UXDyUjYUe3dl8BR
	/vgQWR8LeLgZ+ykXpfxz7Q0mHMhn3YbNpD8xh2zcr+9SDfYdf+NYsiWwVHsUx8de6HCcMwngJrY
	l6zc=
X-Google-Smtp-Source: AGHT+IFZNObGvvm8yCvlD8vA7JuvD+xx6IG/88AxLjAHw3TI9bSUlDUUIp1AXNuzW5tjE5SI0+EZHw==
X-Received: by 2002:a17:907:7759:b0:a77:c364:c4f1 with SMTP id a640c23a62f3a-a780b705189mr181196366b.46.1720542285088;
        Tue, 09 Jul 2024 09:24:45 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bcccasm90088866b.12.2024.07.09.09.24.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 09:24:44 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-58ba3e37feeso7276251a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 09:24:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURonU4MJoUL5L+11PBETdxUZrbMJyCSp+zUdMs05zOHH3iGZVQyiL3RbUZiYDCDVyzJPUBUgpp4tdtcf1XOfp8c12gHXRFJEyd9NIB
X-Received: by 2002:a50:ee12:0:b0:57c:4875:10a9 with SMTP id
 4fb4d7f45d1cf-594bb674a54mr1638342a12.24.1720542284159; Tue, 09 Jul 2024
 09:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com>
 <Zo0LECcBUElkHPGs@J2N7QTR9R3> <CAHk-=wgAKfXySpKFcJUdv97Rqz7RxPF-uc6xsue6Oiy=tP65oA@mail.gmail.com>
In-Reply-To: <CAHk-=wgAKfXySpKFcJUdv97Rqz7RxPF-uc6xsue6Oiy=tP65oA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Jul 2024 09:24:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKCppvYcjHRivLbw2uPELEuEdythi_bkK9P7oF0wJ4Yw@mail.gmail.com>
Message-ID: <CAHk-=wiKCppvYcjHRivLbw2uPELEuEdythi_bkK9P7oF0wJ4Yw@mail.gmail.com>
Subject: Re: FYI: path walking optimizations pending for 6.11
To: Mark Rutland <mark.rutland@arm.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 07:28, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> > For the sake of review, would you be happy to post the uaccess and
> > runtime-constants patches to the list again? I think there might be some
> > remaining issues with (real) PAN and we might need to do a bit more
> > preparatory work there.
>
> Sure. I'll fix that silly left-over store, and post again.

I only posted the (unchanged) arm64-uaccess series and the (fixed,as
per your comment today) runtime-constants one. And I only posted it to
the linux-arm-kernel list, not wanting to bother everybody.

I have two other branches in my git tree if people care:
link_path_walk and word-at-a-time. The word-at-a-time one does touch
arm64 files too, but it's pretty trivial:

 arch/arm64/include/asm/word-at-a-time.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

and really only involves a better instruction choice. It really only
matters if you end up looking at the generated code of link_path_walk
and strncpy_from_user().

The commit message at the top of that branch is a lot more verbose
than the actual change, because I ended up just explaining the
different phases of the zero detection more than the actual trivial
change to it.

All four branches are available in my regular tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

as 'arm64-uaccess', 'link_path_walk', 'runtime-constants', and 'word-at-a-time'.

But unlike my normal mainline branch, I still rebase these based on
feedback, so consider them unstable.

IOW, don't pull them into any tree to be used: just use "git fetch" to
look at the branches in your local tree instead, or use it for some
ephemeral testing branch.

                 Linus

