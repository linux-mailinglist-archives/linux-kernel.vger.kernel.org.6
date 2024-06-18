Return-Path: <linux-kernel+bounces-220083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F090B90DC7F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D4D2853FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E66116CD04;
	Tue, 18 Jun 2024 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gBnwL37w"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC32B16C845
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718739208; cv=none; b=e6wsEK0x2t/P2N23OlOR4eYKwRnKl00J04DNSrAhuYHtCoo3p9kDW/xnAOJ7ZjZKmnBGApFpH5vEYVXQk6+ed0ogNvrHI64FlSH/oEwWgA4DYWZD9obZny4mhrLJm7yfZeH3EsCjhgT7jTJXVibsFwhBZrDmr+XSRFL6zuxFRGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718739208; c=relaxed/simple;
	bh=gLuMz0+DxVsiE1/uSjDCNrlZgg93hvCvS5rcTKlESfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUCKibzcBe+yY/e2qBugrdjrs0s50UVl2QVB8bvzKq+xbcLcXuBqqsrJK6jUTBhXP8ANY3HCTUXAU4ytaRYXJHxEiww8hTFNY830ebc5T5Aw/SPfmlB3thNCRx2+DKBpcifEy9eSJjJsiOINdWJ6c3BcsboEvXX0ZvjFVaQoe+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gBnwL37w; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4405c2263eeso29046001cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718739204; x=1719344004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjbV2Qzy50FvElTGCdfHDo5Cwkx902dlsw8DvDAu3gM=;
        b=gBnwL37wDNTT9J176lf8unHNiu9ABWP6Z8VUed4vWhMzzWX9qcvS9qZIA7hvS/mi7z
         TrJ1A1thyzql4Qr88VOqbB4oiOVl/XlLH9icebMUJwKYeyZzBTFNSSaoze8TJNmAuNOO
         fZnNqdqOjgN7SPSkFrycaWqvbJoJRrDA/xPjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718739204; x=1719344004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjbV2Qzy50FvElTGCdfHDo5Cwkx902dlsw8DvDAu3gM=;
        b=xHItKIaatLIpCpj7dgWU+QXuXO1irnQYueq90LEcKy9+cgSyerTuC2qhFMrcxAQwti
         OBYqyLClDnR00JrJxaWUSEydwaUo/RvMOx2it/kuSPg8Z2Fh3MGC1aOxArAqLcXKVRM6
         aLFycAkZuqYCdXxCnRJUKkwOB7PiX6ZYnLWuayClY685HSC9Vfh0x2ea6wG5XkpZU3XC
         EP6HMz9MSvQvJ9FxSI96X9dxPQx7iVyv/HZVNF6w7Cl0xA7QXB+Y0HzvoRZsQ9uNuE/V
         aSPLowGRhLAkwG/+GUzzKwKK9Ul98w6NQZztxkhwl1F60S+fCCghlXW/DMnaC6bIWK0O
         rK3A==
X-Forwarded-Encrypted: i=1; AJvYcCUL/bI3VgmZZVvRa/JXhlL2t9XS5Fcbmb1ZuivoqHyrzpZEA0JPrrA+8im5urLBlcleMa5OyabWpb8nrEqDxUT0MhCG31Yfi81+7f/B
X-Gm-Message-State: AOJu0YyyFmO1Yy+XcyCSdRETqcEwNZJXOg8MTV5jOWyFlhrqHu0dT+89
	Dtfx0gQbRG7p/ONqrR9hkr3K0yedMuzNtJt8LqA4WyIZ0OZ2L0JYXj+qftrQ0FI63wy2/dWiIow
	=
X-Google-Smtp-Source: AGHT+IGFYfAli3uDTKHH3SD86N7hdCBoO2T8Qngy/vov1Vze3p/8AEBUHqYcXEpsXK+ejW03QqV/mA==
X-Received: by 2002:ac8:7fd0:0:b0:43e:a91:e8d with SMTP id d75a77b69052e-444a7a48198mr6935841cf.54.1718739204373;
        Tue, 18 Jun 2024 12:33:24 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441ef4f9a9esm58958711cf.31.2024.06.18.12.33.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 12:33:23 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44056f72257so72791cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:33:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVj36g9gAcBvxUjdhSt0Ib+NyqDVteiEEf0YDRbnRENDPj26cT/ilNYtAiaKCcOxJPKWIIaDB2yUcIb6kmYboJvzgS8iJNDH4cLZVCg
X-Received: by 2002:ac8:58c9:0:b0:442:1bc4:8fb2 with SMTP id
 d75a77b69052e-444a8fcee3cmr465821cf.20.1718739203008; Tue, 18 Jun 2024
 12:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618003546.4144638-1-dianders@chromium.org>
 <20240617173426.13.I572fb3cf62fae1e728dd154081101ae264dc3670@changeid> <20240618155938.GG11330@aspen.lan>
In-Reply-To: <20240618155938.GG11330@aspen.lan>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 18 Jun 2024 12:33:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VTegKBcHY9pgfFUs7T1Ug5r1yg+CxLE6sBhBBt4csfkw@mail.gmail.com>
Message-ID: <CAD=FV=VTegKBcHY9pgfFUs7T1Ug5r1yg+CxLE6sBhBBt4csfkw@mail.gmail.com>
Subject: Re: [PATCH 13/13] kdb: Add mdi, mdiW / mdiWcN commands to show
 iomapped memory
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Jason Wessel <jason.wessel@windriver.com>, 
	Thorsten Blum <thorsten.blum@toblux.com>, Yuran Pereira <yuran.pereira@hotmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 18, 2024 at 8:59=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Jun 17, 2024 at 05:34:47PM -0700, Douglas Anderson wrote:
> > Add commands that are like the other "md" commands but that allow you
> > to read memory that's in the IO space.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Sorry to be the bearer of bad news but...
>
>
> > ---
> > <snip>
> > +/*
> > + * kdb_getioword
> > + * Inputs:
> > + *   word    Pointer to the word to receive the result.
> > + *   addr    Address of the area to copy.
> > + *   size    Size of the area.
> > + * Returns:
> > + *   0 for success, < 0 for error.
> > + */
> > +int kdb_getioword(unsigned long *word, unsigned long addr, size_t size=
)
> > +{
> > +     void __iomem *mapped =3D ioremap(addr, size);
>
> ioremap() is a might_sleep() function. It's unsafe to call it from the
> debug trap handler.

Hmmmm. Do you have a pointer to documentation or code showing that
it's a might_sleep() function. I was worried about this initially but
I couldn't find any documentation or code indicating it to be so. I
also got no warnings when I ran my prototype code and then the code
worked fine, so I assumed that it must somehow work. Sigh...

Looking more closely, maybe this is:

ioremap() -> ioremap_prot() -> generic_ioremap_prot() ->
__get_vm_area_caller() -> __get_vm_area_node() -> __get_vm_area_node()

...and that has a kernel allocation with GFP_KERNEL?

I guess it also then calls alloc_vmap_area()  which has might_sleep()...

I'll have to track down why no warnings triggered...

> I'm afraid I don't know a safe alternative either. Machinary such as
> kmap_atomic() needs a page and iomem won't have one.

Ugh. It would be nice to come up with something since it's not
uncommon to need to look at the state of hardware registers when a
crash happens. In the past I've managed to get into gdb, track down a
global variable where someone has already mapped the memory, and then
use gdb to look at the memory. It's always a big pain, though...

...even if I could just look up the virtual address where someone else
had already mapped it that might be enough. At least I wouldn't need
to go track down the globals myself...

...anyway, I guess I'll ponder on it and poke if I have time...


-Doug

