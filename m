Return-Path: <linux-kernel+bounces-208830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E599029AD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77341F2226B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDCA14F9D5;
	Mon, 10 Jun 2024 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BsaCejra"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47E61DDD1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718049967; cv=none; b=aIFbr6ong1TJiMf0cXupnoD4kMNVP89GHOKOixnbSQjDEO9xGnLP5GxLtwr3SJsGACGdGpxAkkwT+5qmYU+ZHVbBs7tW80mI+I6UDfuWlpSaZ8yTId8hiXQ3m1B1r2hdcZCBagpXlfnbt3GoPjFKhPgnGP5E4bvvQq+USK1F/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718049967; c=relaxed/simple;
	bh=f7o4Qays3Bp7G7fRXPGGXUPWmsl2Lhom+FJnP4EDqTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvDy4Wxl8+visZIpuxvNR1oiUEbTfaA+FnzLiZCqMGi+vhbDZIgJfiWHC0x26A3dtSjJf53mvu6THfJAKz74djKjkRKezGrzgYnNxW/U58vBhiaHAhcr9dPJ9gmX4Arl9qqttpfUDDVzH/Vj7RT55ZxKnZRxRRg5pZDdZpjmFP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BsaCejra; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a62ef52e837so618693666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718049964; x=1718654764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOwI6DcCCI12dNBNkZD00pCUv7/h5/UDISzx/oKHb3g=;
        b=BsaCejrapp0GdtUCXhTaZrxVSkYRAOvakruaAuKthx4UQb5WpqOLuxxb+zJ1ITw7Hc
         lxe/mJX7hr3ewQAg82jx74J7ceWIB8bueQ09GkSTcRxMNSrX3TAJ2y68CL+EisnoFHOs
         8YxHtqgVwqseQXkr5PK28E/Gxt1Qx9Ztgaq7/HZsFNQPvtH09QvZE4GTHhLNCzvOiOpF
         c3bnFIm9Y6wriQHyA7+LPaedLQmJoOcCK9/U7i56933qh/v0nSdeL3TY9c1T7X4seqcP
         T08MxAu3iEePJtvHekghuuIipYVTG+3qeciw4NEDhlMyGmwnAnQ3wJi8Y0UDavJYB+VK
         dCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718049964; x=1718654764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOwI6DcCCI12dNBNkZD00pCUv7/h5/UDISzx/oKHb3g=;
        b=bJ0hG+pfMkZEoXhrKHFHrxMH9+OlIVDM97BTBq+WZP0MKS4QNHGLIVboPVPRun857I
         Lmqlw2NMeADXa06RUtcp4iK776hCLAN9Of4ZAUTwYf3zocK/eEmFZTVp0rjNS8H/ls0o
         NysSQZpznakrNP2ha8D4kkf8/40+IfyMgvw9p/JBzKnzOfrp8LHVVv++GDPJaqzn+MTC
         07Hh5KXoQDY0DrT9W8SkgEmQH5gk98e6w4cLGG0TVsndVqGT8YP0TUURAfMr9pxMRZ7j
         l5c8CbJfTuueapJRPFKE7nwsEdug/imXDAtDpeWNl3Q4QFAe1BERcfquQJcGf5K1rFqY
         D17Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfxgyQ4aEzzuKyFVK6zU+fsT06s2jsSrM/xfFy58U2nuvBMoiIMMXyZ1FCeGZneS/Oj3UhfhIYNA1ZB6Li9X50WFR00Xu9hapKfD5y
X-Gm-Message-State: AOJu0YzUtpbrxgvy2AmgyQUzX7Mb7wl+ryfWLonjUgjrovnSPNe+ZtzK
	wmP7Md7sly74pkDutWZMwQtzo+xEs9oG7eTd/RgN5+AV5JnyIuUpFrpsfDkjXEFj5GixbdnZ/Il
	4ic5BNpzLZ9Z2++tGxCmsheGoDivQmmJGKGrK
X-Google-Smtp-Source: AGHT+IE03edLaD5o4NEBvXfLFP+kMiyLAjRNIwjqBu9SUSMn4dd8ukKhZoCOUCXo52b4yzosP9Ppa4fhfYlxBrh0Mcs=
X-Received: by 2002:a17:906:3b1a:b0:a6f:3763:3cbe with SMTP id
 a640c23a62f3a-a6f37633da7mr6496966b.67.1718049963596; Mon, 10 Jun 2024
 13:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610143037.812955-1-usamaarif642@gmail.com>
 <CAJD7tkYdTvfO8P+aZNmr7bF7vEetxiqQQ4ML8BcLdmKohT-+Cg@mail.gmail.com> <y7ourydoftwyfxza3a2vlenh6bzdrhtc25h4msqgq2uyg75ocf@wrfov7zflr3w>
In-Reply-To: <y7ourydoftwyfxza3a2vlenh6bzdrhtc25h4msqgq2uyg75ocf@wrfov7zflr3w>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 10 Jun 2024 13:05:25 -0700
Message-ID: <CAJD7tkYcj4Vt9cvJiNTTrjFjwub-W-VAULO9rVnUVqbU7vXn2Q@mail.gmail.com>
Subject: Re: [PATCH] mm: Do not start/end writeback for pages stored in zswap
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, willy@infradead.org, 
	hannes@cmpxchg.org, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 12:08=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Mon, Jun 10, 2024 at 10:31:36AM GMT, Yosry Ahmed wrote:
> > On Mon, Jun 10, 2024 at 7:31=E2=80=AFAM Usama Arif <usamaarif642@gmail.=
com> wrote:
> > >
> > > start/end writeback combination incorrectly increments NR_WRITTEN
> > > counter, eventhough the pages aren't written to disk. Pages successfu=
lly
> > > stored in zswap should just unlock folio and return from writepage.
> > >
> > > Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> > > ---
> > >  mm/page_io.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/mm/page_io.c b/mm/page_io.c
> > > index a360857cf75d..501784d79977 100644
> > > --- a/mm/page_io.c
> > > +++ b/mm/page_io.c
> > > @@ -196,9 +196,7 @@ int swap_writepage(struct page *page, struct writ=
eback_control *wbc)
> > >                 return ret;
> > >         }
> > >         if (zswap_store(folio)) {
> > > -               folio_start_writeback(folio);
> > >                 folio_unlock(folio);
> > > -               folio_end_writeback(folio);
> >
> > Removing these calls will have several effects, I am not really sure it=
's safe.
> >
> > 1. As you note in the commit log, NR_WRITTEN stats (and apparently
> > others) will no longer be updated. While this may make sense, it's a
> > user-visible change. I am not sure if anyone relies on this.
> >
>
> I couldn't imagine how this stat can be useful for the zswap case and I
> don't see much risk in changing this stat behavior for such cases.

It seems like NR_WRITTEN is only used in 'global_dirty_state' trace event.

NR_WRITEBACK and NR_ZONE_WRITE_PENDING are state counters, not event
counters. They are incremented in folio_start_writeback() and
decremented in folio_end_writeback(). They are probably just causing
noise.

I think for both cases it's probably fine and not really visible to userspa=
ce.

>
> > 2. folio_end_writeback() calls folio_rotate_reclaimable() after
> > writeback completes to put a folio that has been marked with
> > PG_reclaim at the tail of the LRU, to be reclaimed first next time. Do
> > we get this call through other paths now?
> >
>
> The folio_rotate_reclaimable() only makes sense for async writeback
> pages i.e. not for zswap where we synchronously reclaim the page.

Looking at pageout(), it seems like we will clear PG_reclaim if the
folio is not under writeback, and in shrink_folio_list() if the folio
is not dirty or under writeback, we will reclaim right away. I thought
zswap being synchronous was an odd case, but apparently there is wider
support for synchronous reclaim.

Thanks for pointing this out.

>
> > 3. If I remember correctly, there was some sort of state machine where
> > folios go from dirty to writeback to clean. I am not sure what happens
> > if we take the writeback phase out of the equation.
> >
>
> Is there really such a state machine? We only trigger writeback if the
> page is dirty and we have cleared it. The only thing I can think of is
> the behavior of the waiters on PG_locked bit but the window of
> PG_writeback is so small that it seems like it does not matter.

I remember Matthew talking about it during LSF/MM this year when he
was discussing page flags, but maybe I am misremembering.

