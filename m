Return-Path: <linux-kernel+bounces-292756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 363BB9573EE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7684B247D5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E287188CBC;
	Mon, 19 Aug 2024 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H87TzjH9"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFF426AD3
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724093210; cv=none; b=kEBZ2uWd1V0nTiPNV7XBgYOqyTzwAlcRtkcE37DQs3LD5f6QMmY7glM3t7XjPY/kPV4YnjyCKBIhpiEwq/JBF7rN8M4zrvrVOnf9h7IPQBCSoR742hiQLcjtoqMpPyOHMk8vVbFMoJYyYkkwouhre68IP1mTa1/Q47pdrk02uYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724093210; c=relaxed/simple;
	bh=kyiNnJaXJx4E/rdeVeG4cgmmOpe6ZpAgGgGSNwpC5Vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5gNDEFrJAnwnqLfLwBWgCPzeEkfMzplEJt/aD9Hrh3PX9UvU4AIcLHp85QfcLNym821Ol5sgktZjBS1vBGvqapygG8GlkDjXUAzk6hPUAtS8tPPyzHnC2VJnSEk0s2tQ5qPdDUqdx+mPAvSdg0YSz+jffKvME3/rTK4l8Rmym8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H87TzjH9; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5bebc830406so1476a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724093207; x=1724698007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y51dIf6Nc9jS2PsiVafQefSFQO48+Q7aOrp7xHNd1WU=;
        b=H87TzjH9WZqFkotvGqQUUjKB5NIP12cj8Z0MZ7pGN/NlA4j6bUPPqx3CQEKOmEYPmV
         Byxl4+OiAKQ00jSVS+7eFfNSvv626xIdzMna757nyoZaRA4zDgrHVwuJ10ThkvxFDx5E
         CIF5TH5CDG0z6/Ms6zJjL0VSmeIKhOpS9Ner/4THcqE9T0JEf0Iym8KKp9KujI7/sVh5
         Tut5hEmkuOHwOO4dT9WdLgc5f2fMfyj/W54K8jNtnIJrp0peFIi0udb8sfUHSgBVApkq
         xVN5WD/sF3crlVAwBmJMP2THY7blBuuDpx0n76OFYCotqxUPZKzE8ge8zlMQ/l21BKZN
         k/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724093207; x=1724698007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y51dIf6Nc9jS2PsiVafQefSFQO48+Q7aOrp7xHNd1WU=;
        b=CoMWbtr5Ry24KZB8hXzP8kaWt3KweJIVoZ36hRkkA3zbiW1Av777PW8h2leO8L836a
         YVKAuZjKWzoZz45y6FRviFTOJ721/izyxIPWJnKGuDdZw2wCAL6Qx7YbhPTW6YFB3IU0
         oO+QXQVfeUo7RU9VnDaBE0SUA24dzbxrCKNz6ZutZ1+pvSS6DWalEB8HE0uS80+T5Dpm
         8yHx+sEEtbP+fKsvNDrUUeWcpZCD1bNmx5Apd6ojCjTPBKYCt/dhx9KLJxFfR8hizHA4
         RZ2ZSwRygDN62DWdbegSloruGocdQFqzrrDoE/S12ugNeoQ5cokV6PaLDX1TvZ2Nfb6E
         7eAw==
X-Gm-Message-State: AOJu0Yxf92Ozx9OosXFRDJItDhQOslAClLFLzMMS+JrhO3FrzilLDR3P
	i6ukw2mdZ6kKXdyiyyNwn+eDmkcoj70tZ5LWorl024IzeLLn7v2dD7ePdI4vNUMNW7MtcVG4hAt
	oWmXhHXg98baG0hlu3VqEU/wbcmorh+3o9zQO
X-Google-Smtp-Source: AGHT+IHGyrw4ppuXQs+Ix4XJjG6GmLafWxNKCsWLnSoyTNB7TwMvjAoIf2VSsRB+F0laxTLGBLorjke5egWsMJdRpF4=
X-Received: by 2002:a05:6402:26c4:b0:5be:c28a:97cf with SMTP id
 4fb4d7f45d1cf-5bf0c5cf9bfmr6774a12.5.1724093206617; Mon, 19 Aug 2024 11:46:46
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813234755.3615697-1-maze@google.com> <efbb6394805f11de27cace9817418744d8e69506.camel@sipsolutions.net>
In-Reply-To: <efbb6394805f11de27cace9817418744d8e69506.camel@sipsolutions.net>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Mon, 19 Aug 2024 11:46:31 -0700
Message-ID: <CANP3RGdxrKHsERYG+yW5fpRUrahkBJbHCKD24v182ZNKuJgfwg@mail.gmail.com>
Subject: Re: [PATCH] um: make personality(PER_LINUX32) work on x86_64
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 5:23=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Tue, 2024-08-13 at 16:47 -0700, Maciej =C5=BBenczykowski wrote:
> > Without this patch:
> >   #!/usr/bin/python3
> >   import ctypes
> >   import os
> >   personality =3D ctypes.CDLL(None).personality
> >   personality.restype =3D ctypes.c_int
> >   personality.argtypes =3D [ctypes.c_ulong]
> >   PER_LINUX32=3D8
> >   personality(PER_LINUX32)
> >   print(os.uname().machine)
> > returns:
> >   x86_64
> > instead of the desired:
> >   i686
> >
>
> But ... why should it work? UML has no 32-bit compat support anyway.

Well, that's certainly a fair point.
On 'native' x86_64 this works even for 64-bit processes though.
I wonder if that, in itself, is a feature or a bug...

In my case I was writing some debug code (to print the environment
some test code is running in, since I think it was failing due to
running 32-bit code in PER_LINUX32 on 64-bit arm) and testing (the
test code) on x86_64 UML.  I was surprised to discover the difference
in UML vs my host desktop.

> johannes

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

