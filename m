Return-Path: <linux-kernel+bounces-360287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEC29997EA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 02:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41E91C24E94
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 00:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E4A194085;
	Fri, 11 Oct 2024 00:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eabn3HjJ"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E552E33E7
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728606201; cv=none; b=hZyWrSQh2APDq1e0ygDK2DGsjOdErl7iB4h4u75x/k+BqBVuRsO1M8MFmCMvaORb6yq3RflY74M7RsZi4KcfrPT1PU8+mPI0gsvo1KorBU5ELb8lJGo08THbOU0zBgTMkgee2kEQamsZcx8R553b+zNcEoGjH9iGhtgha+W6SlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728606201; c=relaxed/simple;
	bh=IdU0NaITwVmuazq/pnPGvgKsS/eq1DvtYLNflhg9uP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxVbWZH05oB4WHyDfagmdVX/ReWK4bNjQkfjjekxmsZcZ7YMoTINf+8rnzNpJtI1XnrdGvUpjt1Mdr+5hd/QgxcEfYbfiVP6QNlLTtfSxHWCwP9XLtdqdPra1OHOjbO4U4eqHxmpisPMQ9G7pCpgr/LDufyMhvzeRocMDA6qdnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Eabn3HjJ; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-288349b5a30so119989fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728606199; x=1729210999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVGdgRMRF72j9LkSnHZOZlGd3on28rqlWSf6lpgKKqM=;
        b=Eabn3HjJsGByZktmfwlcsO/ZN51+EgTXxF+GDyS/pwXx/9Kh9q3HC0FE0y98+L8a48
         ZGdUYIB3LkG157e+rezSvZ5mTwKmA1qzTMOukLXXQRvWV1JZoGTofz8DQsraKOvT18+v
         P1o3dzu/UnkyVkhHSuXhkJh0152QP6Lllde/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728606199; x=1729210999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVGdgRMRF72j9LkSnHZOZlGd3on28rqlWSf6lpgKKqM=;
        b=fBJaqefaOdyE7TrepKXmAdZmtajszr9APu6XNfgqtovr/TShFeUNSH36tLxAoU+x39
         dMw6S6hHJtmy3n/3/dvRVuwdcQn9DIOhh1OqB8m7gmi9oAAhqD2DQd790SV6nnEk2U5c
         hH/IQ3Nrhn54p1uNUFnjtDj+LvAIh7QYeKxYkrpFzYOridHUhpwWNAPc/svfYn68bCmW
         MRylzaoiJ+In6DFXMZcTB30RArJ/bWre/c6OqPw6xok6LMTSE7Ne2K2lRKuRbPCBC5K2
         FLhezjRL9n6yQsI2Z/GmRKaQ0o7hBkwoi83wsPzUEvJ9JuiUr2x0e1FDUdLYA2IxiiCc
         +/7g==
X-Forwarded-Encrypted: i=1; AJvYcCWYNTiABHpfTZDcJrWGkPZJuJ2kDIQDiVPYq7xvr/o/JVZsriFoy9f/IQjMWOixOfVfogX3iS/9TX1sQHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUJd6LjGzxo4MvemPToCQlN1FsY2ul80QDOrv4nRRQQGR10PAw
	6lTVf0JryCZ66tNxSJdlLRAbmEMv9ogGiEfZln7006W2tCvDZoeUVlLooer49N3PECLcws91Ja5
	LIuKK5JIX2A99K72AE/wv6gRprIgNQ8GoScxG
X-Google-Smtp-Source: AGHT+IFT9pJJLCUSM/YLQyqqRxIfC3K7gw6udoC8IuTRrW138RcWE2mO/y2HCtMWqB0/IdaYqzd2MKMsfG/AmfyOKCo=
X-Received: by 2002:a05:6870:7252:b0:260:ccfd:1efe with SMTP id
 586e51a60fabf-2886ddd8c92mr182982fac.6.1728606199035; Thu, 10 Oct 2024
 17:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008040942.1478931-2-jeffxu@chromium.org> <20241008041804.1481453-1-jeffxu@chromium.org>
 <5e1ef8a0-f063-4166-9d93-cf047cdd2792@infradead.org>
In-Reply-To: <5e1ef8a0-f063-4166-9d93-cf047cdd2792@infradead.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 10 Oct 2024 17:23:06 -0700
Message-ID: <CABi2SkXecdseZBeEJOeP8boP7aEAf815-1H6eMHDy=a4d1oXMg@mail.gmail.com>
Subject: Re: [PATCH] mseal.rst additional fix
To: Randy Dunlap <rdunlap@infradead.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, corbet@lwn.net, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, 
	sroettger@google.com, pedro.falcato@gmail.com, 
	linux-hardening@vger.kernel.org, willy@infradead.org, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	deraadt@openbsd.org, usama.anjum@collabora.com, surenb@google.com, 
	merimus@google.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	enh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 9:37=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
>
>
> On 10/7/24 9:18 PM, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Change "overwrite" to overwrites"
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  Documentation/userspace-api/mseal.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/user=
space-api/mseal.rst
> > index 41102f74c5e2..54bbcce330ec 100644
> > --- a/Documentation/userspace-api/mseal.rst
> > +++ b/Documentation/userspace-api/mseal.rst
> > @@ -97,7 +97,7 @@ Blocked mm syscall for sealed mapping
> >     The first set of syscalls to block is munmap, mremap, mmap. They ca=
n
> >     either leave an empty space in the address space, therefore allowin=
g
> >     replacement with a new mapping with new set of attributes, or can
> > -   overwrite the existing mapping with another mapping.
> > +   overwrites the existing mapping with another mapping.
>
> No, that one is correct as is.
>
Ah, yes. Please ignore this additional patch.

> >
> >     mprotect and pkey_mprotect are blocked because they changes the
> >     protection bits (RWX) of the mapping.
>
> --
> ~Randy

