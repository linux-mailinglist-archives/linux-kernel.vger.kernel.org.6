Return-Path: <linux-kernel+bounces-255687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAFB9343C0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 23:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF9D1C21BDF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520A91850B5;
	Wed, 17 Jul 2024 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p6V5sUKO"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D80F181B90
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 21:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721251246; cv=none; b=EqzJI++iv4LXSb0oS7OkpO6L31rlXVvwYPWoz0GyJFpsqfYmy16G4DFWbROXjxm+7SGp4D5CXLYXfNuYhVjcIT/niRIpEAg+9jSMFrxVPolw1bAyeRNZ/4qBPiq3TgHz6pB6vbc3+OV5/CyunkNfS8dZlMTMfGvKkAntTxNP9G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721251246; c=relaxed/simple;
	bh=iDomwZb/fc3YsUCpbkqYfZvOlKX/5b5hghEnjDL2cek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7JGSDMG68lG+11P8OTelzhOxfoPuMmEXjBRTx3fAx3L5BU3EqjaS7Vzkbx6PvdjRQUfSHlHEEsxWl4xoX62qYhvwgHVOtNsv1j1Zu3W5MAEU1cwdMz87QI1avfdtjtlLizK+Vxi6vk5BK+UO7HDOnAn1lm7f/jRZIDM3JaxftQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p6V5sUKO; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-654cf0a069eso967257b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721251244; x=1721856044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDomwZb/fc3YsUCpbkqYfZvOlKX/5b5hghEnjDL2cek=;
        b=p6V5sUKO45rRQiURHfUBR7lQC21vxy71GzYyCoMwTMg0eKdsDp1JMnv/YuFUvTVEIU
         31yF+hfLNflDr0Nih68ncoa2byaAYkRSB9z04/ELiVVHMeKsvWi9HJokILO7LJ4K9f/j
         yf5V3cOM2zuL6WD3/xY1qIpWyahZkyJnMhzAvhuMPdXM9/Md6g95L8/fFfmsLwfcFLAp
         nN98y48iDldHgtEAMZVZ7bZjbYlupW7f865mFZ4gisPNv4AeXu3g5SisdulwJjPkjRpx
         6TMGXWviqpPV3kHLmZoJ/WtLQsCUD1Sw8f16gpaLM2LRTJvOOHkNwT12Id/DlUYcYGnE
         9IPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721251244; x=1721856044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDomwZb/fc3YsUCpbkqYfZvOlKX/5b5hghEnjDL2cek=;
        b=hAVf1G6yulddj2VBliHEcxwKbWUdHuGRXcxsrRvBIJkIpYfFdMHY6kZkjCnuOtOtwl
         KXcgwuLILlFxDMXVdXAa9dC5IfWAM5HyLQys1KXP00RUBebHZ3Kr5dlJx3m3WDTYP42c
         VhLbpYj3E6GcJLthhIyGEprqe4FzoTLe2zt5PMjsVlRkMByXvwKcW+bu1AeZXt/lt5LW
         QwZFiCt5PgFZnQcVOoN1zmS+L1X5nkVBAOetAkzMsZ65XN+A3PcIrR46XMsnKNIBwzNK
         0E04Yry1O6Bkv2YEn3oyuIkTyNSIOWnVJQ5UIRkQuI75DuFtEG36Tdi2igVh/OHAcmLS
         GkyA==
X-Forwarded-Encrypted: i=1; AJvYcCX3+FTPSE9wCmBlLbPKl4pJjmRRsMIWoOhvkGM+IdUlbURhG1JS5goKjJR3QLVDDrh5enjFhKmH0kB7mx1D83LSoTR/QWT1oXXhTua1
X-Gm-Message-State: AOJu0YzH854gKlD4YKfc1XbX/mQoAAE4wdz3jjwj0clcWZqEHoqVV/pU
	xI4z73zWAKtkMNiIacmwwJfJ7d2qZebRIJoXbktIxDJYmjOLnz5cFgZCDZcaSE4qmQ7bMgfQTco
	fzJG5k4OqIGl7RyHJpaZcasfGs9tJpr2MDtth
X-Google-Smtp-Source: AGHT+IHvh+zZptdIi7QTNMIlQtyKdeLrO9w6heg5nNqbR+6kQu+2nSZ0aayp9MC02kdU+AFI0BgHhA8AB6eUBgbTawM=
X-Received: by 2002:a05:690c:6d8f:b0:648:3c1d:36d6 with SMTP id
 00721157ae682-664fde7f6aamr42200297b3.10.1721251243681; Wed, 17 Jul 2024
 14:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717181239.2510054-1-surenb@google.com> <20240717181239.2510054-2-surenb@google.com>
 <16286915-1350-4e6b-a0f6-deec02b7fa92@suse.cz> <CAJuCfpG2uNicytRYhfqAKrfkxJoNLUUK_o066D=yKggsoc3wKQ@mail.gmail.com>
 <10865b0a-175e-4b90-9042-7b63b1ea19f8@suse.cz>
In-Reply-To: <10865b0a-175e-4b90-9042-7b63b1ea19f8@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jul 2024 14:20:30 -0700
Message-ID: <CAJuCfpEnLGi8754DQeumLz0t+d6aXmEPEV64BMC0oRRqr9UX1A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] alloc_tag: outline and export free_reserved_page()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, hch@infradead.org, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 1:19=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 7/17/24 10:04 PM, Suren Baghdasaryan wrote:
> > On Wed, Jul 17, 2024 at 12:36=E2=80=AFPM Vlastimil Babka <vbabka@suse.c=
z> wrote:
> >>
> >> On 7/17/24 8:12 PM, Suren Baghdasaryan wrote:
> >> > Outline and export free_reserved_page() because modules use it and i=
t
> >> > in turn uses page_ext_{get|put} which should not be exported. The sa=
me
> >> > result could be obtained by outlining {get|put}_page_tag_ref() but t=
hat
> >> > would have higher performance impact as these functions are used in
> >> > more performance critical paths.
> >> >
> >> > Fixes: dcfe378c81f7 ("lib: introduce support for page allocation tag=
ging")
> >> > Reported-by: kernel test robot <lkp@intel.com>
> >> > Closes: https://lore.kernel.org/oe-kbuild-all/202407080044.DWMC9N9I-=
lkp@intel.com/
> >> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> >> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> >> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>
> >> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> >>
> >> Are these two patches now stable@ material as 6.10 build is broken on =
ppc64
> >> with alloc taging enabled?
> >
> > I tested them with that specific configuration mentioned in the bug
> > report and with several usual ones I use.
> > Yeah, I guess from now on all such fixes should have
> >
> > Cc: stable@vger.kernel.org # v6.10
>
> Right. BTW I have just realized that the way you did Patch 2/2 and outlin=
ed
> the whole free_reserved_page() (which is fair, it's an init-time function=
),
> mem_alloc_profiling_enabled() didn't stay inlined so Patch 1/2 is in fact
> not necessary anymore?

Yeah, I think you are right, currently no module has reasons to use
mem_alloc_profiling_enabled() directly. That might change in the
future but we can add the export at the time it's needed.
I checked and ppc64 build passes with just this patch. Let me post v3
with just this patch and Cc stable@.


>
>
>

