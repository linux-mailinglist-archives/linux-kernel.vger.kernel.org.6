Return-Path: <linux-kernel+bounces-437807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9D09E98E6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F71B166E34
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEDA1B4236;
	Mon,  9 Dec 2024 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H42DTpqT"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D141ACEA2
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754629; cv=none; b=GzVGfpOelnnarb7WoYxBUsepnLjM3jG0K9kNUomZITkj4f8i2jUTD+ClrVki96mKP5obpRY1XX1uYlkDOsuPF6FH18lhOe3L5TkT0jqaDyTUWxJNK3CUXkQHMALr4uyCPXgeW6W3akLb+rdo7vOOIjF08FFaVr0v9M+luOvSoXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754629; c=relaxed/simple;
	bh=2yDdGnUnN5+uDhrSEMg52oISXX5o0ZrbzReKyPKcu2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeWZ78htoB0k8DTAX6qjzNCVgYrgcy3ThzgvJHkJWQMnqwvTY8wRqfy8JuNlROQN93NcqVW2Kl3cTkwV34EqqTADSVylkWE1zW7v872MRcZHljvpuPFGXYot9+wf+Ksh44tIOye0bdbQO+DcglM+HJ3OMyjhwaEtYBnjHaQQsOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H42DTpqT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so713233966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733754626; x=1734359426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCmGrQhnqbwdfnLabY1cRyBfQOTH2omZUbnG6l3F4RQ=;
        b=H42DTpqTvITa6GI2npxUXiSrH9mjK9VdizbNtzGJiRLDqBoKR1a3XHB4yIGrsdMJDv
         n0s+Hg9UUQ+W9jkK+8GEU+YW0No0GJS0NFvfmaGaZx70qY3rNLTrqkrYwBZCtKKg8zst
         Fkm/sduNdT16dHxhuqf9Bc2iqw9vEExyuluSgfJaVEO9mPTdkqgt1v8da6Op9UOI16dD
         8KHlcIHzmgMviFOA1IpUqRPG23L7Czvoge+IPqxnZga7FS1uNSGoSwzNG9Drc1dThVV4
         JPPsjCI/OFvBDIzPJCXPADUwOTHU8NkANaJ3FfUIxb0MVqM/TZ9oqxEy9YmzcDJt+dNx
         mMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733754626; x=1734359426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCmGrQhnqbwdfnLabY1cRyBfQOTH2omZUbnG6l3F4RQ=;
        b=mRsQGiJlYop5JzV//Vnb5zpaWsFUhpgWc4nPZHOTMNROClEluGimW3GmnBY0sUPW7x
         77QPORJJt0/fUX4lVXUSKk5fn7Lc3n91LIsB4q3Ak8IA7wv1AcGkopPxJJUrsVInJNpr
         Pi+eLLIRporCEHGUKNHOZscc4sLJCmyIuiyrn0QnpO3QQA056ZyaaRETZ7ycbbzV6PrP
         ACfFow/t2w/l8CiNNeAEMWl4olfmT560ryeA0BXtQc1vOjarpxlcWWzYER8WL9zT5RKF
         uXOWV56WA8jlLvmuyXYnOBusJHjj7HWZM8bpyCU8pCVqU774vFmseQ+5xRPD3GznSCgW
         J4Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVVIMHqP7+1kbLwl7M9aWABWEv7uwoscLx35f+w6MXXbSyP3UZJVRj9fDcPNImg9BqQq0TybyDzyFw17v8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLAfsrZPJuQ2mFYgVnWdeDUBgV07m46fzHFz0zKJraFUoJXDGr
	NbzX5tZOBwsbi15kEf44PCV2KJYmqBA/lSSoi40UU0xTXEmRrthM6dUL7+2Zx46cyUfRhMZa3f3
	hYFUPgsJwj4+20JOKYhk8zCh+l3U=
X-Gm-Gg: ASbGnctrYptkUrUeibd6mDAYehw9tgwYfo1lVm32v54lKszgqTXAHmvzow76fMQV+cl
	sYz/q4u+x6hrDbS4uOahjaziZRNOiebc=
X-Google-Smtp-Source: AGHT+IH7BfwfhJzqVBOOgzpbVdst4JM+esJi2G5ZZro56SpfsZBD4q4Obu+KflviTVH+0n24ibATIi5zBt4pumvuJww=
X-Received: by 2002:a05:6402:35d3:b0:5d0:d3eb:a78f with SMTP id
 4fb4d7f45d1cf-5d4183c5564mr2221084a12.0.1733754626017; Mon, 09 Dec 2024
 06:30:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207082931.1707465-1-mjguzik@gmail.com> <94d0dcbe-2001-4a9c-a767-b337b688b616@redhat.com>
 <CAGudoHEggB=F9j7r+ndQs1WxpRWB4O5VdBo+PLx+yd1xrj4-Ew@mail.gmail.com>
 <606fbf9a-c9ba-4f08-a708-db38fe6065ce@redhat.com> <CAGudoHFLTet0ZpOkDMFBh0yBDhJ47st-aRrCLZojdrCgQKznUQ@mail.gmail.com>
 <f5a65bf5-5105-4376-9c1c-164a15a4ab79@redhat.com>
In-Reply-To: <f5a65bf5-5105-4376-9c1c-164a15a4ab79@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 9 Dec 2024 15:30:13 +0100
Message-ID: <CAGudoHGUwS_zY1KWStMtKoy=eogLigy7ucpEQXzTZGANU=35Jw@mail.gmail.com>
Subject: Re: [PATCH] mm: remove an avoidable load of page refcount in page_ref_add_unless
To: David Hildenbrand <david@redhat.com>
Cc: yuzhao@google.com, akpm@linux-foundation.org, willy@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 3:22=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 09.12.24 13:33, Mateusz Guzik wrote:
> > That is to say I think this thread just about exhausted the time
> > warranted by this patch. No hard feelz if it gets dropped, but then I
> > do strongly suggest adding a justification to the extra load.
>
> Maybe it's sufficient for now to simply do your change with a comment:
>
> diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
> index 8c236c651d1d6..1efc992ad5687 100644
> --- a/include/linux/page_ref.h
> +++ b/include/linux/page_ref.h
> @@ -234,7 +234,13 @@ static inline bool page_ref_add_unless(struct page *=
page, int nr, int u)
>
>          rcu_read_lock();
>          /* avoid writing to the vmemmap area being remapped */
> -       if (!page_is_fake_head(page) && page_ref_count(page) !=3D u)
> +       if (!page_is_fake_head(page))
> +               /*
> +                * atomic_add_unless() will currently never modify the va=
lue
> +                * if it already is u. If that ever changes, we'd have to=
 have
> +                * a separate check here, such that we won't be writing t=
o
> +                * write-protected vmemmap areas.
> +                */
>                  ret =3D atomic_add_unless(&page->_refcount, nr, u);
>          rcu_read_unlock();
>
>
> It would bail out during testing ... hopefully, such that we can detect a=
ny such change.
>

Not my call to make, but looks good. ;)

fwiw I don't need any credit and I would be more than happy if you
just submitted the thing as your own without me being mentioned. *No*
cc would also be appreciated.

--=20
Mateusz Guzik <mjguzik gmail.com>

