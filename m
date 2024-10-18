Return-Path: <linux-kernel+bounces-372353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C82579A478D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F082870B2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8477C205AA0;
	Fri, 18 Oct 2024 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GX5q05Rx"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26481DA0EB
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729281700; cv=none; b=OXKQ6akgu3/v8afZ4e3xlOW3z06dkic6AOdfJkK8rJNDvtMlkpaKvz1P9sH5YJIorcRn0BYwm3onr2rMcPVTurYuRJHloQsroakjbOf8HuxiJ+3D/nO9b5r/yu9q6tOXvhadp+gaC8ZYYOvKhkTCDnbhIj3E5m1sGdTvS7JlmME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729281700; c=relaxed/simple;
	bh=sUBKmlDtMoYiytQnckCrthBdRK/nB5wINOiMqIcsP7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbMvhwp6IDuEgszhZBQLbyMK8TfzR3IjGYxVMdIoBdzduUJCgEdK3DnstRJcDTGRtj3a30Zk1WQs6yt71SvhXUCCqHqTVQGGyH/tqdDvew6SK09Jkw93fEd6SKkmVXhPqat4mpKX+i1WgwOs24aKAoulGPlkgJ9wBCz/cQMZ3MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GX5q05Rx; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb518014b9so23118141fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729281697; x=1729886497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moCWFw6SD4CNOWNlmwaed+/ZD9C8MhoXUiWB6DB9jCE=;
        b=GX5q05RxGxQzqDf/ATo9Lc4k9sU5/inhbEpZUAvKbPGE1sEkgQk1vrTWSB+KL98eQu
         hBbo6RkTkr/j458lzXgiHjEgHMP6sZT4vSxh6MhQWWyXV7aqOFNl9WRzCRb2C5JlHlT0
         VTJ3cpsLQbIzit5qa1yKwdAzwO0gHMGalQcmO/3A/Ux4e+APup/vbfuO5dtnaQTl1Jb7
         ptB9xhXHAVhgjXf1fBpM5Nv5UcVzhpcyYI/oM03+Vv73QRdRAuM75uMZww+jrh3gDeYZ
         MG2hOqws61hEkYhp0XrgulTuQGb2G9vycMWCpxSMy3sfmCz7oxndgDNsKsROLT+WnpyB
         jjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729281697; x=1729886497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moCWFw6SD4CNOWNlmwaed+/ZD9C8MhoXUiWB6DB9jCE=;
        b=TC8eaE075xzn2Ba4jFR3Bg4lj3b+q4p33wKyMd+xmyVqj3Z7hkEdA7z94CW5EtDfDw
         oTgrT16GVqQQ65ag1jo5o4hRl8vlp/GOq+7mFusZd5NLCpSsjv6slvgtQpusG9s/bfTH
         rD5hoQ2nKAVTn7076ZLjmOy88EOH2l6uwNzMtAu3mzCefxYdKhKkNElvoSRgoBPUyTGG
         vcI8VVnoRX1g5J8MDNBYUebUOiW/cfPnmGtpEcFXGCWZ4Ng3N4aq8S69qWgB2fjLcGFL
         Z3x3+qYcQs2kBt2Ho4YJn+r/BFl5GuIYZZq7AX+HdG0z9nAbCrRIJ2kcu00hge1r/lSM
         g8eA==
X-Forwarded-Encrypted: i=1; AJvYcCWLE1T5c7AsgXQfuqxsPr81IMqnONEgXGMcyTfOPZ/ZzEKt40bWFyBMAeDiqDFDKT5OiF2ydzcXTQMvkuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl0xuaTp+A3YO9bW2rs4GbLiOh2wQRnMGnkRyF/+VnzFpVZ6y/
	uj0xtma//x+7cWXRvbHqyZqRLW8trdyN0VNPzO9NrEHPdxm0+zv3eL8ar/nBM/UpZCaJlmqLQko
	BtKT6XUGVdGXWXRbOK3w98ilvRCI=
X-Google-Smtp-Source: AGHT+IHLXLOgC6jg78xVbKIpouOB/nxUtWgrWkrm/R7V41QdCoMpzzpqBu0xvZYl9Td7VAjzkAdn31CByDsvBvJ8mV0=
X-Received: by 2002:a2e:851:0:b0:2fb:3a78:190a with SMTP id
 38308e7fff4ca-2fb83262a78mr14324981fa.29.1729281696452; Fri, 18 Oct 2024
 13:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018192525.95862-1-ryncsn@gmail.com> <ZxK7G3S0N42ejJMh@casper.infradead.org>
In-Reply-To: <ZxK7G3S0N42ejJMh@casper.infradead.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 19 Oct 2024 04:01:18 +0800
Message-ID: <CAMgjq7AjBMJAE-rj2MmB53FrQKcsARK5tZ3sKB4+uhWhkQ=EGA@mail.gmail.com>
Subject: Re: [PATCH] mm, zswap: don't touch the XArray lock if there is no
 entry to free
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	"Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 3:46=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sat, Oct 19, 2024 at 03:25:25AM +0800, Kairui Song wrote:
> >       if (xa_empty(tree))
> >               return;
> >
> > -     entry =3D xa_erase(tree, offset);
> > -     if (entry)
> > +     rcu_read_lock();
> > +     entry =3D xas_load(&xas);
> > +     if (entry) {
>
> You should call xas_reset() here.  And I'm not sure it's a great idea to
> spin waiting for the xa lock while holding the RCU read lock?  Probably
> not awful but I could easily be wrong.

Thanks for the review. I thought about it, that could cancel this optimizat=
ion.

Oh, and there is a thing I forgot to mention (maybe I should add some
comments about it?). If xas_load found an entry, that entry must be
pinned by HAS_CACHE or swap slot count right now, and one entry can
only be freed once.
So it should be safe here?

This might be a little fragile though, maybe this optimization can
better be done after some zswap invalidation path cleanup.

>
> > +             xas_lock(&xas);
> > +             WARN_ON_ONCE(xas_reload(&xas) !=3D entry);
> > +             xas_store(&xas, NULL);
> > +             xas_unlock(&xas);
> >               zswap_entry_free(entry);
> > +     }
> > +     rcu_read_unlock();
> >  }
> >
> >  int zswap_swapon(int type, unsigned long nr_pages)
> > --
> > 2.47.0
> >
> >
>

