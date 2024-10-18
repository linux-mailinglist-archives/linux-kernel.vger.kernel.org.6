Return-Path: <linux-kernel+bounces-372419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F95C9A4847
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56BD1C20B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6103120694D;
	Fri, 18 Oct 2024 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WWRlyEMU"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFEA18801F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284059; cv=none; b=ZoeKffj63XykQZUDNJ5JARmnOoPMjdBhGdQMivQD0TN5RiioeoV3oBY0P8KXg2MkVL9w1mRcuelWd33APB1eZ0JFS4biflaKFLZZzkklykxS+W0PlcMFVHX0KfWr96MwGQOvZkHQ0TLi/k3MzUiv8gvuvz40hbCDzEEqXErkqZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284059; c=relaxed/simple;
	bh=rSnjIWOxnfjZmSHXJ873M8GM9fBXADwXGfjdWqVKQe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+uMBnn80/odEOsFejH+HK57iIAn8bK840ml9wKuBm1+Uv9bJ4t0kUukNq6TXq+HWIJCaINQlXoS/dPl7Aib+q7CK3vetRMtRIpt6xYnWoILoGJPDpsNB0QPAN0fhnOvuAp7CO6MkKz8Dx7FHavzsHIpBYkvoOeiqu4PRPepJcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WWRlyEMU; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f7606199so3024602e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729284056; x=1729888856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htuQ6Fkdyy+fM986uZCUwobTiIqwyPS/bkEyY4ioUA4=;
        b=WWRlyEMU4416JxSbcCeeGPEhTAWexp9OcJtlEfD5M2kL/ayHDZR7H9qu6mSMoBG0Un
         kCUyLx/k6PPo7fjmZIPxFPNoadUhhThJhZ8wMewJTTwUADubeLHVrriMTsXHEGiQnb+s
         wHWCoN5CFT1HyzlpBHS9ksXqNgiR+rvINraQ1dRu2PkBV4RjEFOerbkxGrBm1V9A8jg/
         jdCGDLCIepScKYwxNCpiUie8ZzxGWBFIZPookxkUllktLLP9WZqyvD3ZCsVIgBboiD1c
         URCprJv6xx1SZtUNqDvz+qN1V6vAHsM9oP0pEWxhtXtpAD61DpSzhTEB096uzkqUcaKr
         MIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729284056; x=1729888856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htuQ6Fkdyy+fM986uZCUwobTiIqwyPS/bkEyY4ioUA4=;
        b=OHV0HuOFr43ef1MEAIcvriEIwve/4wG8qJePV6ChOBVqGn+x/td+0Jvbh7BAHwtQY1
         oTyF0+wX8Pce8Exs0iAonfBkUoZxu+ECAnUFcgMdRAOBNRj7pdUQyc4HJ5sW+JqTbtuy
         QPcvc7GTDc2+HLbwVRmoj8cGRAhse5znumHHOBDuM3KJXQPNgcc3r8viJrSDv+/ouEMG
         WIBcZI0rTCxzdpf2FJ7F4Ic/nOtvXTAfUMO8h2UhP//ZfINWBD1VlgjdU8EKneVRAEma
         UnFWmzYyMWXpDOv76nlWhvY1G4dd7jlhYzlMQMYXTY1vqPvvHvkQEEQBABR2X1HF8Blw
         Mkvw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ2nR3uvLEsuB6srhGmYr+caXobePgL54OHFg9vdqWAaM+UzrHfrDVUxRtDNtyGs45KW9wp60TFXZHHf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvVksxrP9Zn+80vqVk9akwKYa8UfhA1xtUKHS4WMBu2COI96yg
	l5tWVXHQM8AmxZNYztJxNaYIhLSS0YNeFQ/ZoDj3qEVTROl5nPQMkVuhAtpyscMzq5cSMIg64Fj
	s1C5vVijL+5jOszKr9UsVGJfSs4AobAuO342n
X-Google-Smtp-Source: AGHT+IGG4ckJnR/P89yT/YqDqPaZ69UYHlnK5W2i22Qmdt+BY29V/dv3SueOaylo3n8+Y9lyTyKiq+N7ELER2ObfcZo=
X-Received: by 2002:a05:6512:3b12:b0:539:fcf6:5d24 with SMTP id
 2adb3069b0e04-53a15471efemr2566878e87.59.1729284055416; Fri, 18 Oct 2024
 13:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018192525.95862-1-ryncsn@gmail.com> <ZxK7G3S0N42ejJMh@casper.infradead.org>
 <CAMgjq7AjBMJAE-rj2MmB53FrQKcsARK5tZ3sKB4+uhWhkQ=EGA@mail.gmail.com>
In-Reply-To: <CAMgjq7AjBMJAE-rj2MmB53FrQKcsARK5tZ3sKB4+uhWhkQ=EGA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 18 Oct 2024 13:40:18 -0700
Message-ID: <CAJD7tkZMTJKYR+au2rjP1v+c8PvdP4D39j86tHg=o2riKGYynQ@mail.gmail.com>
Subject: Re: [PATCH] mm, zswap: don't touch the XArray lock if there is no
 entry to free
To: Kairui Song <ryncsn@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	"Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 1:01=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Sat, Oct 19, 2024 at 3:46=E2=80=AFAM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Sat, Oct 19, 2024 at 03:25:25AM +0800, Kairui Song wrote:
> > >       if (xa_empty(tree))
> > >               return;
> > >
> > > -     entry =3D xa_erase(tree, offset);
> > > -     if (entry)
> > > +     rcu_read_lock();
> > > +     entry =3D xas_load(&xas);
> > > +     if (entry) {
> >
> > You should call xas_reset() here.

Oh I thought xas_reload() is enough here to check that the entry is
still there after the lock is acquired. Do we have to start the walk
over after holding the lock?

If yes, it seems like that would be equivalent to the following:

entry =3D xa_load(tree, offset);
if (entry)
           xa_erase(tree, offset);

>> And I'm not sure it's a great idea to
> > spin waiting for the xa lock while holding the RCU read lock?  Probably
> > not awful but I could easily be wrong.

If we end up using xa_load() and xa_erase() then we avoid that, but
then we'd need to walk the xarray twice. I thought we could avoid the
rewalk with xas_reload(). I am not sure if the xa_load() check would
still be worth it at this point -- or maybe the second walk will be
much faster as everything will be cache hot? Idk.

Matthew, any prior experience with such patterns of lockless lookups
followed by a conditional locked operation?

>
> Thanks for the review. I thought about it, that could cancel this optimiz=
ation.
>
> Oh, and there is a thing I forgot to mention (maybe I should add some
> comments about it?). If xas_load found an entry, that entry must be
> pinned by HAS_CACHE or swap slot count right now, and one entry can
> only be freed once.
> So it should be safe here?
>
> This might be a little fragile though, maybe this optimization can
> better be done after some zswap invalidation path cleanup.

The only guarantee that we are requiring from the caller here is that
the swap entry is stable, i.e. is not freed and reused while
zswap_invalidate() is running. This seems to be a reasonable
assumption, or did I miss something here?

