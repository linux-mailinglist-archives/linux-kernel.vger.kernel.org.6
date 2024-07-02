Return-Path: <linux-kernel+bounces-237712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8362D923D08
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1106428575A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F0D15D5B8;
	Tue,  2 Jul 2024 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yYIkmgoc"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C5E15B96F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921528; cv=none; b=NBEulwZxs7MZj5LofWY3c/jwoH1s0vPrKhulv9CmkEDWqZWBumGNCArzllrniYL6ELLPCjRNhuOc7KiTXjudpD94NrW79gN6TTqSqJSBvg0MmaLzY5erMWYDQ6gu0psetWgU/QAgMDatedWV9aY27PoSaEH9oOMVB/QKtthsJIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921528; c=relaxed/simple;
	bh=6HBcDvUYgc7G8pAGE5H3ShPPqC5EVGedKJgNxCTIbPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXuTjPu+FVACHEeSp9b0EwtBdK9aVY7IpGOEJ0yityg+r3io95GBjqsYBUQgUBHswjqt9HZwI2qooprxS7ztWjh0H0ZsQgI+UmuM4Oy5zr2vbDqDukPRL7o76A0+5k2doKzyFaqYDg2zJY51XaOjimFcQszIq+m5LaKCUl5KV/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yYIkmgoc; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a727d9dd367so440426966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 04:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719921524; x=1720526324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJE3RjkR7P6xLKXHqEeA3UnQKhR6h3J7+TbtG/HNlPw=;
        b=yYIkmgocA7z+ey6mx/G1aq0yqFXJyxU6FNbcFFAP5Sdkjwj1ph2XcFKtGCk9JhMT4y
         /JcB1JmSIDxsDRu+oi6WXHYcwsdC4iIXQPeKWWIbNoJO+ctP9gxg/oXhj9Qkb4LwkrF5
         5kl6KdMmXiz+6pkdsF4+5M0PIJKZSl7plIg4lBy6h2uelx20ivbdeBpGdPsvS928J94D
         Oiv0D+N3XvO9RXDfH2xUZkZK2sHIaWg+jseCkGWApsj7Ut1elXkzp5Oo6bl4h7UfyFwD
         3CP3j9Nrmhp0MXB05fRJVdQc0udCyp+OcmjN0T7EpfRL5XJEf94IofSVVkEbbXrAb8h0
         uCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719921524; x=1720526324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJE3RjkR7P6xLKXHqEeA3UnQKhR6h3J7+TbtG/HNlPw=;
        b=dboW9bJAWCljaHwqCqn4nTLmg1o/Wx1/4lsUMCxyMcOuw7Su2/oS/YQpEsN+GEHuUK
         rGO1Hw/1IgIP7rU/GPXqqdtrGFK6S6eIuNrODcI90ylsqb0lXr8/s0y7IxyIh5Etw1L0
         2ShQ7YpsK6XvXd7wwxalkW/v/dk5Dn7bxrYXdRmK47/6REErebscRQgnjJJk2H3E5RV8
         6OFB4HAx2ETLUzCnDzu+3/z3ee3EvTtfOSN5zEQrcQdTzBCNuZI6qVeB9hW9+MJWtbEq
         vTtKDb48/D46nOoTs8a+/ANcLipcI/7Kx25dfjK3Yab+zghQ5cr2YHTZkDldgqNToOsz
         sE/g==
X-Forwarded-Encrypted: i=1; AJvYcCWup1HXx+GELmymTsHMPtUtFkeDNY5RaUPSbzzxzYNS4Zxq2gDnCT97TS1LXJBTjo4oODWiR4X4xKo5Ye+lvvOjvpDPVkWFtiNaraNQ
X-Gm-Message-State: AOJu0YwRi3pfBl7Ucz7IV9FgVpaMl/RPqDC78Qx8R7x5f095WKjWNnuN
	gpU8GI9ZTUEm+gpO6y7ZL6shdp1srnxY8pz4kp8NpsktLH7A5htLUxEAYiPfSszt4snLFiVMdbh
	NavH1wQQXtuZaZLNLEEfYcN+X5UB7k9Vp8ujDX7rvzhoW3tcIJYz3
X-Google-Smtp-Source: AGHT+IEgm5z95cSGFxQ3V0ayY7Ai0asCW3V+jsOOSHTXOTWqh+9MPajWk+OvayBaKI3FNgoXefKdwE6XKrFDcgHdCBk=
X-Received: by 2002:a17:907:724d:b0:a6f:b84e:8454 with SMTP id
 a640c23a62f3a-a751443c63emr627377266b.11.1719921524083; Tue, 02 Jul 2024
 04:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629232231.42394-1-21cnbao@gmail.com> <20240701235210.5c187c85aa225292d034cafc@linux-foundation.org>
In-Reply-To: <20240701235210.5c187c85aa225292d034cafc@linux-foundation.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 2 Jul 2024 04:58:05 -0700
Message-ID: <CAJD7tkYJwRF5B2-vQGkmEhgw9t20OcVbB7MNrQqvmTor8Vjptw@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix zswap_never_enabled() for CONFIG_ZSWAP==N
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 11:52=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sun, 30 Jun 2024 11:22:31 +1200 Barry Song <21cnbao@gmail.com> wrote:
>
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > If CONFIG_ZSWAP is set to N, it means zswap cannot be enabled.
> > zswap_never_enabled() should return true.
> >
> > ...
> >
> > --- a/include/linux/zswap.h
> > +++ b/include/linux/zswap.h
> > @@ -68,7 +68,7 @@ static inline bool zswap_is_enabled(void)
> >
> >  static inline bool zswap_never_enabled(void)
> >  {
> > -     return false;
> > +     return true;
> >  }
>
> Well, that code was as wrong as it's possible to get.
>
> But what effect does this have?  Seems "not much"?  Perhaps we'll
> attempt a zswap_load() which later fails for other reasons?

Actually zswap_load() is a noop with !CONFIG_ZSWAP, so it doesn't have
an effect there. The only effect is that with Barry's latest large
folio swapin patches for zram, we will always fallback to order-0
swapin, even mistakenly when !CONFIG_ZSWAP.

Basically the bug just makes Barry's in progress patches not work at all.

