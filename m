Return-Path: <linux-kernel+bounces-318670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EDE96F170
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B1528EB83
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D039D1C9DFB;
	Fri,  6 Sep 2024 10:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGHNK+rJ"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42321C9DF9
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618177; cv=none; b=dj75D1D7ghLUHbkIM4mt6cv6Oux0ZgEdpwES71qjuEfL+DxaZBw0/CJJVo5+qv+Eav9RHRqTMgNY73KKfsrUZuhdZjVZ6aUjqKVCQBdVF8LhqQstHUgTrrP0RF6H+Rx3QJ7BRQcxB7touQsh9SaTLw11pwCHn7zJtB23gMZD9TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618177; c=relaxed/simple;
	bh=mL8Yk7l+QJugT3RK5mfr8HmET1FxTvZrfG2evGs3jMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ar4cvOo2ogQaAppg8OaoeO6YfADKDgKne1KoSSTpEgbIMB54VS++oE5y8EGbeGJLUEFGmeySFZUCn3DUXIkw6F/U57HgLK+MIQneC/vYqlOJE4z/pwXwtN7dHlvmvUIT11/DMq5bw1ab5Uxx/P6Wy/cX1QR94J9gJ+fiQmp2S+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGHNK+rJ; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-502aeeb791eso247970e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 03:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725618174; x=1726222974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SI4tsZiuC/zqvfWEy03dGcYzDneiMGwSa8jBoYh+4hU=;
        b=LGHNK+rJG7gQVss9K9+/JAebmJQn9e0djb30k32sJeupqKh8EF3F4H3hs4Qouk/AQE
         kFnEpgaLYXMuOMHsX+pgu8gO+Ptm9n2NVaqK6YE5mzkvrGuOA6U18y2ZEU7AyO/ByCa5
         ajtnckrz/1I/mKX/iU4ts/N/jBeznfzvkgVuUYAEvmjxwGC6IAqcSUnk75hemimO41ne
         Al+4nJ1Y2/p5OKyRPMRW9zmuPNvK5ah6iFQVpmbqgE/NTOtS/F1zzXQave1BmWVLCP8w
         tFap/XMNB7ACBXlJe9LJuMaQChGtyfTGQVEWwjHJEBJ5p/T76mFncCMFes88FhZkszfE
         ehWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725618174; x=1726222974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SI4tsZiuC/zqvfWEy03dGcYzDneiMGwSa8jBoYh+4hU=;
        b=JO5LZwRZpTstaW2s+66q0spzIZw+Cj63PLU7rLrGSLNlnd+0bhWxXAS9azbkTI3Hh9
         m7e1cCxqhGQq0vUuyDRZo7Ztx6fZJWBQYpsKjKNKMofV2Z/2kJ/SraR0AEO51ZwyH2ca
         +5z4iv1u1xbzXT9Sjm6YiJUriQmA8kITjG/4U+6PbxL8M5D7hZkpJ1ShJXgD1bj+4IDh
         yiTeGXgAbEFAn/bgV7l4PwAYqtqTZ1S0p5GjoHHloqaUqM7G0Pr0RR9WQ9I79PcOQnEq
         0iZrzd3n+tRAz/6kOrJ174CS/6Z9Go4KLVDrrDoPjrhaznZogOasQoAPbc2AceDKFc+n
         01hg==
X-Forwarded-Encrypted: i=1; AJvYcCUPzCkvzKA+qaZToF1UoMosLOhjtjjMQJOv9raFOznKUDuglyF4iC0n9I5twlMUZSKo1Dv1+SkcKf2Mbzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCqoPUzFpOWlxsC82rS+gN93+1bo1WA0FQCLClKOLWQElVz67Z
	bQzEOz6cWKlm6fAEPEa1vPs1djo42Xq2kH+kd/chji8nXgCeRyHWrHPA9mWVBuuDI5XhaZyynzY
	l5eAInISwsrX3iFIQ7A2in0s+RIY=
X-Google-Smtp-Source: AGHT+IFm9aMAfpE+uG+P0LzWYMzIKu+k7/7RRb3+Sarlzn3kU43FV1jekfHyOZFZtCys5nIfsC65ynoaOOtgwudCZjE=
X-Received: by 2002:a05:6122:3d02:b0:4fc:efea:48e6 with SMTP id
 71dfb90a1353d-500f6e63761mr7643777e0c.7.1725618174491; Fri, 06 Sep 2024
 03:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612124750.2220726-2-usamaarif642@gmail.com>
 <20240904055522.2376-1-21cnbao@gmail.com> <CAJD7tkYNn51b3wQbNnJoy8TMVA+r+ookuZzNEEpYWwKiZPVRdg@mail.gmail.com>
 <CAGsJ_4w2k=704mgtQu97y5Qpidc-x+ZBmBXCytkzdcasfAaG0w@mail.gmail.com>
 <CAJD7tkYqk_raVy07cw9cz=RWo=6BpJc0Ax84MkXLRqCjYvYpeA@mail.gmail.com>
 <CAGsJ_4w4woc6st+nPqH7PnhczhQZ7j90wupgX28UrajobqHLnw@mail.gmail.com>
 <CAJD7tkY+wXUwmgZUfVqSXpXL_CxRO-4eKGCPunfJaTDGhNO=Kw@mail.gmail.com>
 <CAGsJ_4zP_tA4z-n=3MTPorNnmANdSJTg4jSx0-atHS1vdd2jmg@mail.gmail.com>
 <CAJD7tkZ7ZhGz5J5O=PEkoyN9WeSjXOLMqnASFc8T3Vpv5uiSRQ@mail.gmail.com>
 <CAGsJ_4x0y+RtghmFifm_pR-=P_t5hNW5qjvw-oF+-T_amuVuzQ@mail.gmail.com>
 <CAGsJ_4zB7za72xL94-1Oc+M2M1RtxftVYUAUk=1yngUoK65stw@mail.gmail.com>
 <CAGsJ_4yBFpyA4Znfgr7V=eoHAnhuLPDTqaVOre9waTKZ+R3R9A@mail.gmail.com> <CAJD7tkaiRZ0fbPRV31bG6fnHPb2NAj_pixF1yFuyuGzsTA6zog@mail.gmail.com>
In-Reply-To: <CAJD7tkaiRZ0fbPRV31bG6fnHPb2NAj_pixF1yFuyuGzsTA6zog@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 6 Sep 2024 22:22:39 +1200
Message-ID: <CAGsJ_4w8b2TCQMPxd_uPxXkW2xGmPt74S6w3mOfRxOaJj6YXsA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Yosry Ahmed <yosryahmed@google.com>
Cc: usamaarif642@gmail.com, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, david@redhat.com, hannes@cmpxchg.org, 
	hughd@google.com, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, shakeel.butt@linux.dev, 
	willy@infradead.org, ying.huang@intel.com, hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 7:28=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> [..]
> > /*
> >  * Check if all entries have consistent zeromap status, return true if
> >  * all entries are zeromap or non-zeromap, else return false;
> >  */
> > static inline bool swap_zeromap_entries_check(swp_entry_t entry, int nr=
)
>
> Let's also rename this now to swap_zeromap_entries_same(), "check" is
> a little vague.

Hi Yosry, Usama,
Thanks very much for your comments.

After further consideration, I have adopted a different approach that
offers more
flexibility than returning a boolean value and also has an equally low
implementation
cost:
https://lore.kernel.org/linux-mm/20240906001047.1245-2-21cnbao@gmail.com/

This is somewhat similar to Yosry's previous idea but does not reintroduce =
the
existing bug.

>
> > {
> >         struct swap_info_struct *sis =3D swp_swap_info(entry);
> >         unsigned long start =3D swp_offset(entry);
> >         unsigned long end =3D start + *nr;
> >
> >         if (find_next_bit(sis->zeromap, end, start) =3D=3D end)
> >                 return true;
> >         if (find_next_zero_bit(sis->zeromap, end, start) =3D=3D end)
> >                 return true;
> >
> >         return false;
> > }
> >

Thanks
Barry

