Return-Path: <linux-kernel+bounces-537257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F328A489BB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030B7188D618
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269CB26A1A4;
	Thu, 27 Feb 2025 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="f9b2XkW5"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84141D6182
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687743; cv=none; b=d8vZhnyCXT65TMxDr72yOX0ns3ZEe6wW+vwmS2lUxXgYV9shZj0GaUXUO3zdRMt94hDQWgk9/hVFwCfcGcNxhWS8dy8L0uLo0l2dl5jHGzJctewuOqoKwJDBUi2CeBLqMk6wPJmkMzGAgLv8i8I2tjCRF4GRkdgfZAXC208klrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687743; c=relaxed/simple;
	bh=4JO84e2/jyvgpbFbferhNXNJSfOzWDotZb4WwEXenb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHYMU7yA8fLJ859a9Fqfu0S0ZRlSYvFMp9eAbVJAM6mhItLp2EQGjw2awPV8NOlmI+FzmLkkcz2nmLbxU0rLqT+L7QEeFzHD9MjoJmgpzmaW0kuCceX+FX9TkOkVnkHs+KmKS0bOxdaTmDTcAYk6oKWjZR4jB3KkMhmcNwon9Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=f9b2XkW5; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 075E33F278
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1740687739;
	bh=SiQZ4Rq+0GqJoxx2KQxyIG0Xut74ShpYg+ijgenLnUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=f9b2XkW5a3CXE4JkI7KICaqXcWzB40jn/BB0ClCLQXgCMA0v+gjJw5Sl9hJgD4P2B
	 Cjxxm/jXFXz+A583hPIfYSwnuSSReZEzIeAd13S4bVJ+kv7DgR8MhqjdYQOZzAwAAk
	 cEY17Kee4sAsJko7/g49qfcKt+xkkhm/F65YvD71R6JDnRDWcB5mkl4gM/ZL1ECCqO
	 JaTDirOZBpbYLRJhDk9EqPrKqAV95tDrnPdOn0UI2aMfBVabcFU1a3FycPJZm6MW6S
	 utcbZJUrpqkRQPjANSqlh4RhjmUCTikrjwXd1d1apr8FJ/uHEMGNafqd2m+JXYRPkC
	 Z9gWL1eWOPJmQ==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e4cf414a68so1296123a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:22:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740687738; x=1741292538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiQZ4Rq+0GqJoxx2KQxyIG0Xut74ShpYg+ijgenLnUA=;
        b=j8zu1wh0w8SOf4/CNcdjvWTAhfBN3VrROSZf54qDsOqhrBbudSDna5wwC8Y/jyGtgG
         Ixc79Fw/Oti1Wjrx3FHSW11C6njC9eiDuKZX0ufMAaRvYptezrjd5JmXTGhXe12cO2ME
         g7bRpaMwh4b0D9rZTo5BeojIEFio++fuzYumFExp076G4NFefA7KR8RBZR9ostZ9aq22
         yRwfikNpgJ8ZDQLRtvkdgLfXZvjCtYtF17NhcaZLOLzjEolQUVWHPHBQoRa2ApVZmMLs
         /eBdSA/aGSob7/Hhak/xSffj7gF3dl9YcTqY5+QWhVxYmExI74XBsqK+QRau8bILG+CR
         w7xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj6kbnT1Mul5Tust0ayd7YobS33uGzFOYm4sOZa9EQ2gOu4gCdeo2Dk59XyOnFEHN4AELBLx2B2XJ3ufA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfWmA5jBs5H0N0kA4a8hSIe7JCI9G5gAVDD2l6OZxACnJA2Y+t
	XwJ7uueFtbgydbyz9eVHCeWs2csgBUbPC70+5NzMV8fkumR02wit11u4+1kUCS7NMrSey+wpLy7
	BUdZNv+OmmMTnrsksuuY4URfC5DIhn59YtuQCs4sbZpq4/2eiGmusi7UmlTgKNrpv3+68GAMu3A
	PDXcJTUXfB/p9H/0RDyrgW8HhCWZy0X9396Yh4py7Kr+ZIGUab0XlN
X-Gm-Gg: ASbGncuFfPIEmpYWaM5iW4geHs2i8rhAZT5o7OXffBGFBKIUY42hH4DR+pNa3M1NYRg
	wBrJPZ9jRoVHQGL1+ZgV5Ty321KwBaMbNA0dI+9ZfyHeeOdXRhhG4qypAXHdqEJ26N6yNUZE=
X-Received: by 2002:a05:6402:350f:b0:5e4:9348:72b4 with SMTP id 4fb4d7f45d1cf-5e4d6921bd4mr402494a12.0.1740687738517;
        Thu, 27 Feb 2025 12:22:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjN7GoLizYN8AYUswkeK50Pl1lF2BJudLqy3J78FpZbhUAfHe4ulxGizo03P2ZzrkYYxtjIXX1SIy4cdHOVZg=
X-Received: by 2002:a05:6402:350f:b0:5e4:9348:72b4 with SMTP id
 4fb4d7f45d1cf-5e4d6921bd4mr402477a12.0.1740687738203; Thu, 27 Feb 2025
 12:22:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218222209.1382449-1-alex.williamson@redhat.com>
 <20250218222209.1382449-7-alex.williamson@redhat.com> <Z7UOEpgH5pdTBcJP@x1.local>
 <20250218161407.6ae2b082.alex.williamson@redhat.com> <CAHTA-ua8mTgNkDs0g=_8gMyT1NkgZqCE0J7QjOU=+cmZ2xqd7Q@mail.gmail.com>
 <20250219080808.0e22215c.alex.williamson@redhat.com> <CAHTA-ubiguHnrQQH7uML30LsVc+wk-b=zTCioVTs3368eWkmeg@mail.gmail.com>
 <20250226105540.696a4b80.alex.williamson@redhat.com>
In-Reply-To: <20250226105540.696a4b80.alex.williamson@redhat.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Thu, 27 Feb 2025 14:22:07 -0600
X-Gm-Features: AQ5f1JrZ1oPBmSEga4Ppqksx7nR2-OUM5LtfazwlWAiz0Eh4H51tt0_skrEMiXg
Message-ID: <CAHTA-ubjxqs7Rh8ERXqFXCRAm7WoMMRQftSPLmrK61jra7+gYg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] vfio/type1: Use mapping page mask for pfnmaps
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	clg@redhat.com, jgg@nvidia.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Alex, that's super helpful and makes sense to me now!

-Mitchell

On Wed, Feb 26, 2025 at 11:55=E2=80=AFAM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Wed, 19 Feb 2025 14:32:35 -0600
> Mitchell Augustin <mitchell.augustin@canonical.com> wrote:
>
> > > Thanks for the review and testing!
> >
> > Sure thing, thanks for the patch set!
> >
> > If you happen to have a few minutes, I'm struggling to understand the
> > epfn computation and would appreciate some insight.
>
> Sorry, this slipped off my todo list for a few days.
>
> > My current understanding (very possibly incorrect):
> > - epfn is intended to be the last page frame number that can be
> > represented at the mapping level corresponding to addr_mask. (so, if
> > addr_mask =3D=3D PUD_MASK, epfn would be the highest pfn still in PUD
> > level).
>
> Actually epfn is the first pfn of the next addr_mask level page.  The
> value in the parens (*pfn | (~addr_mask >> PAGE_SHIFT)) is the last pfn
> within the same level page.  We could do it either way, it's just a
> matter of where the +1 gets added.
>
> > - ret should be =3D=3D npages if all pfns in the requested vma are with=
in
> > the memory hierarchy level denoted by addr_mask. If npages is more
> > than can be represented at that level, ret =3D=3D the max number of pag=
e
> > frames representable at addr_mask level.
>
> Yes.
>
> > - - (if the second case is true, that means we were not able to obtain
> > all requested pages due to running out of PFNs at the current mapping
> > level)
>
> vaddr_get_pfns() is called again if we haven't reached npage.
> Specifically, from vfio_pin_pages_remote() we hit the added continue
> under the !batch->size branch.  If the pfnmaps are fully PUD aligned,
> we'll call vaddr_get_pfns() once per PUD_SIZE, vfio_pin_pages_remote()
> will only return with the full requested npage value, and we'll only
> call vfio_iommu_map() once.  The latter has always been true, the
> difference is the number of times we iterate calling vaddr_get_pfns().
>
> > If the above is all correct, what is confusing me is where the "(*pfn)
> > | " comes into this equation. If epfn is meant to be the last pfn
> > representable at addr_mask level of the hierarchy, wouldn't that be
> > represented by (~pgmask >> PAGE_SHIFT) alone?
>
> (~addr_mask >> PAGE_SHIFT) gives us the last pfn relative to zero.  We
> want the last pfn relative to *pfn, therefore we OR in *pfn.  The OR
> handles any offset that *pfn might have within the addr_mask page, so
> this operation always provides the last pfn of the addr_mask page
> relative to *pfn.  +1 because we want to calculate the number of pfns
> until the next page.  Thanks,
>
> Alex
>


--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

