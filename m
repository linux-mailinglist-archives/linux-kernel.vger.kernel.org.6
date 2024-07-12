Return-Path: <linux-kernel+bounces-250339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706D992F6AA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A168C1C22370
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288F113B5A5;
	Fri, 12 Jul 2024 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjpGG0kV"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D168D3BBE2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720771484; cv=none; b=gpW1M2QwjFuaOBJRUr63V0NnJ4LVu2joaF8vomT633PT97tTYBhz+1j4iXZd2qzQY2nktzaLEOGJeW7IT/kyJ2N/oxnQ69clkTREIpSeuUlOiaKU/6586HM8YMJy3THZyGgBNBZ/koHglj49AsE/XstBCxESVu+FOcR/Fr2/2so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720771484; c=relaxed/simple;
	bh=hj2VG2Q8d9319KAMG4IfhYrlDB52h7Si/pjHysrh1e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgCEpAGl2L1dXqqdS9U8RAIHA9IpYnrc9dnUfmwmg8e+DGvY+4PV72xTouFyT385COZZbun689c/cWsxYrTqSoTGIKeX+drJtZT+48NghKNjUV/EUFelK5Nk9WDip+4vwqPE8O0/6KJSOUV2RIcfWZ2qRlwYSapu7EquE2c08Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjpGG0kV; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52e99060b41so1810331e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 01:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720771481; x=1721376281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DzpNgmhLJVBu5qe1LjZ6WkA9IlvA+byqn+kY68Fw58=;
        b=BjpGG0kVR1i4P540h8nPHWJMp2V+xsJdKgca1KypULcgnL6uMDXVcxJTXuKWuZnxMB
         0YmSZxHFWOvvqe+DWULZm+CHy54+LLoBWHjSrsxIe+AFm/CZIUIrSr+TKwCDDT4QUmt0
         pBRHG8W56fJwIEy787M4eNDPtlm0K2l1UH3A6TmwjGkBfjkOttIIAiPjSOGmEFkwlI2f
         +wDQgYDGON0Hpkc5KmxxJufCBkLIl3kf7k3jNiW4PJu5og1ZYR5ycEdLkxAfkH8nukhq
         X21KBC4aVEyf60ildrW69q6tcS9x+DY2GSIsmx+KSQzzxXdu/+yWHjBqqqyKP0XPCQWQ
         5Geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720771481; x=1721376281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DzpNgmhLJVBu5qe1LjZ6WkA9IlvA+byqn+kY68Fw58=;
        b=OUE5KRmYJkfI/hMu5RhAc+gv6dSTrUz+N4BGH2xnZ0SqhX18fxiIetgxIBqmU9JsnN
         Fqr8wVfEm+1E+yZ9avfRx+oxKhDNoGyS4loNqxyea4KqLAfD257QAc+C+vKaTOHjtjT6
         2sXKh2/1r9H7SsMBvtr+H9v8f3FwQhy+C7DzCuAro1aDf6W8CXxk9FtXYnMqYlsX5SzJ
         XB+CwJCWtZAfnZHKNigSlslaRsm44+ajgm2WtajN/5tmAT6CpoiD68C3+uu7DKoqk+OP
         6sH9+koeH/Z2Hy5+L0zHT/hO5Fhv/21Hq1MErASxwocoXDjIl44HK95Yu/k1QyfnNpOT
         CmDA==
X-Forwarded-Encrypted: i=1; AJvYcCXdS6hzfXF7e0PqoxNQFGm9MixdC4PpEMlw4GqF0zUXd886MIs2p2kq57mRsYsH1Wma9saSJK0S9oSRJzOOWypfNPS2FvzaL7fSss53
X-Gm-Message-State: AOJu0YxQjRdU7KBWx7biO3I5WM5LgpaQhnLODJRAfxM/n0KbONwOAHIr
	HBJE6tUAxyshSaHYKYlpGayDNB4CgHEaOeXaP9bs51xJI6ICnPA2MlEyw/vjpd/gx9VWzOdkh+I
	NNHH1dzNiOjD5aVsEy7Sg6faZo8Q=
X-Google-Smtp-Source: AGHT+IEzGpTobVaTkEb3+i5LAPU3czDFriS9G7PWIRglcmKBHYVGpdf+/uEgEfJdKuMf+a+GRig9hdCn/WRpD20tp1M=
X-Received: by 2002:a05:6512:2252:b0:52e:bdfc:1d09 with SMTP id
 2adb3069b0e04-52ebdfc1f65mr6202809e87.18.1720771480680; Fri, 12 Jul 2024
 01:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625121652.1189095-1-lgs156412@gmail.com> <Znug8e2cUzuA9qGu@kernel.org>
In-Reply-To: <Znug8e2cUzuA9qGu@kernel.org>
From: liangxi Liu <lgs156412@gmail.com>
Date: Fri, 12 Jul 2024 16:04:03 +0800
Message-ID: <CAPRrSS-MTfoeKkbOMdtCMhVjxE8HDQu1Jt9HaY2RHBHUF-DrLA@mail.gmail.com>
Subject: Re: [PATCH v2] memblock: export memblock_free() to free reserved memory.
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, liangxi Liu <lgs156412@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes. we have a reserved memory used for display the image, which needs
to be deleted from memblock.reserved list(memblock_free
()) after display and then released into the buddy system(free_reserved_pag=
e
()). Should I use memblock_free() or another API?

Mike Rapoport <rppt@kernel.org> =E4=BA=8E2024=E5=B9=B46=E6=9C=8826=E6=97=A5=
=E5=91=A8=E4=B8=89 13:05=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jun 25, 2024 at 08:16:52PM +0800, Guanshun Liu wrote:
> > On architectures that support the preservation of memblock metadata
> > after __init, allow drivers to call memblock_free() to free a
> > reservation configured in dts. This is a hack to support the
>
> "This is a hack" implies that it's not a proper solution, right?
>
> And anyway, memblock_free() will not actually free the memory after __ini=
t.
>
> > freeing of bootsplash reservations passed to Linux by the bootloader.
> >
> > Signed-off-by: Guanshun Liu <lgs156412@gmail.com>
> > ---
> >  mm/memblock.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 6d18485571b4..20e7f81fc076 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -848,6 +848,9 @@ void __init_memblock memblock_free(void *ptr, size_=
t size)
> >       if (ptr)
> >               memblock_phys_free(__pa(ptr), size);
> >  }
> > +#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
> > +EXPORT_SYMBOL_GPL(memblock_free);
> > +#endif
> >
> >  /**
> >   * memblock_phys_free - free boot memory block
> > --
> > 2.25.1
> >
>
> --
> Sincerely yours,
> Mike.

