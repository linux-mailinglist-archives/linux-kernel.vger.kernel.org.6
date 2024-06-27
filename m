Return-Path: <linux-kernel+bounces-232361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F3E91A79B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7132885D9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC0A187544;
	Thu, 27 Jun 2024 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="ZZX0jrmn"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B6188CDB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493929; cv=none; b=Rkca3pKdezJ+150R62DHVtd9Qq8ahgAy9uKQTWKoz6lZN8BQbBLQPFGIwUMFxrfKSGj/HU0iKkMUNU4AWxFhyR7QalfwQw+caDJPbay6Z0A3zzkh70EiE8s8rLeSLDtOqUDlRDnIn12MwibqUfEIZtfHbOfuWmVU7Z+P0vjSGgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493929; c=relaxed/simple;
	bh=bh574OC0hfnfP2s+XmATt7Z/PY4du1JCkROQcPySJVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4rGp1a6jGvOJ+lN9IBHg6x9M+tq7vBbRCIxbHmfcptDgoDYjN6JBaXKxltLR03tmuexRaFkFGIa9ibczVd9w7XLV16xtO+iADAM6rGOf0ZOJScV8VF0sSvN8Oug3rq559n1Ll9vbTHBGDZq2vgUgdaRuME+FSPzfHW+Wow4uNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=ZZX0jrmn; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so7875627276.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 06:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1719493926; x=1720098726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1YNOJVqJAnO5y/qedAP+u6aRxm7l8CEybZJa45UdrI=;
        b=ZZX0jrmnoRtTOym7GoEQZQqlZhEw2SfnwkGAetZ9LfAqxu9Hhq3Wr9+HiLigOFlURg
         BNz00LuD4tfvfkV+6N6XYHpJ6tdaAJvNgGsFP6oh57Q5eyCw1Ix9FM7/5ROyF617zL64
         WFLe3qlH/xx/CyW8kJU6K3oUDT0kPC4hRFkwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719493926; x=1720098726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1YNOJVqJAnO5y/qedAP+u6aRxm7l8CEybZJa45UdrI=;
        b=cfJfCfWxAF/9TowxUm595oIS0u7SCOQf3No3W9yAcms79n0aLOPAZBH1vIjCiHbV3m
         oFjQdb7g8mKC5dfipxHQ1THA/sDm1Iq/m32IB7Ki8RYnJukdxypqdTF/67qrXW8Eafmo
         ST7AgGcIPaFLuahwa59hxL0Lm+w6w2zOMzQ77Z7NZydWReNTZdQcRUp52Ow57n3vpD7b
         qD+WcaZfyq4Nxlj3ZzgUQYO4ViHKWbv6cl8OgLwiGyrQJnY9ouEli6txOrrNF5oWbfds
         17IDbblD1n+Bh5izmsnGVq9aIE4NcEifDrla6zBIOQ6NSn4HI5+s9LJD5nbqQwyH6Ytv
         +N/g==
X-Forwarded-Encrypted: i=1; AJvYcCXFJ0F2xeOeFDPmOGcwaoXrS5S/df7QXJqecyYEXD21zEh2CdVp6De108t6AvBWU4O2NAcT5Owv+3hWozIETSuu2i5cS9lav0WXaSdO
X-Gm-Message-State: AOJu0YylAunqzmA47FjcYjRTSACABfC5i3+VQiON3r366pbVVNrkVn0+
	sLJUAnu2JE4UuqOihu8gACkiwj6Mb+lhcvyNhkDa6jk/CgoZHBHU+QRvxn04VUl4mtuXuMTZ8tw
	25U+lzcF6XvqoeBbHIBrJ78ofHVpGpGUKQBcOrIXbglP1zvMc
X-Google-Smtp-Source: AGHT+IFZ5kE19qmzmCXBIGk/Hhbs3ZSOZ/xYjtZTolHKpYipi2Qke2/1LpvEWAUHAsfxGm6LLw8z6UQUBjV6NVbgHi4=
X-Received: by 2002:a81:e204:0:b0:627:a7ad:ba64 with SMTP id
 00721157ae682-649db4f85eamr11128717b3.49.1719493926401; Thu, 27 Jun 2024
 06:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1718966972-17507-1-git-send-email-skappen@mvista.com> <20240627065309.e_MPmlKm@linutronix.de>
In-Reply-To: <20240627065309.e_MPmlKm@linutronix.de>
From: Sam Kappen <skappen@mvista.com>
Date: Thu, 27 Jun 2024 15:11:55 +0200
Message-ID: <CAJ9FNxuWXSDh70W-944+e7mD3g05RvOs-WxyMc4Bhy6vEAQY5Q@mail.gmail.com>
Subject: Re: [PATCH RT v4.19] tcp: md5: Add a serialization in tcp MD5 hash functions.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tom.zanussi@linux.intel.com, zanussi@kernel.org, sam.gsk@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 8:53=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-06-21 12:49:32 [+0200], Sam Kappen wrote:
> =E2=80=A6
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -93,6 +93,7 @@ static int tcp_v4_md5_hash_hdr(char *md5_hash, const =
struct tcp_md5sig_key *key,
> >                              __be32 daddr, __be32 saddr, const struct t=
cphdr *th);
> >  #endif
> >
> > +static DEFINE_LOCAL_IRQ_LOCK(tcp_md5_lock);
> >  struct inet_hashinfo tcp_hashinfo;
> >  EXPORT_SYMBOL(tcp_hashinfo);
> >
> > @@ -1224,6 +1225,7 @@ static int tcp_v4_md5_hash_hdr(char *md5_hash, co=
nst struct tcp_md5sig_key *key,
> >       struct tcp_md5sig_pool *hp;
> >       struct ahash_request *req;
> >
> > +     local_lock(tcp_md5_lock);
> >       hp =3D tcp_get_md5sig_pool();
>
> Instead of this, could you please move the lock to within
> tcp_get_md5sig_pool()/ tcp_put_md5sig_pool()? That way it will also fix
> ipv6 in the same way.
Thanks. I will update the patch and submit again.

Regards,
Sam
>
> Sebastian

