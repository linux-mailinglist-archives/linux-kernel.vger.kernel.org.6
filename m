Return-Path: <linux-kernel+bounces-337392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE90984974
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CFC628665C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A161AB6C8;
	Tue, 24 Sep 2024 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="BZYbLwpp"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D52745B
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727194883; cv=none; b=CRSptoI6GpBHVpIMs/1tus2Zj0OSGgau6XDnApsVrjSTQBKkCljGARodC4Qpe0lSzOCPvNzV5rJRTLwMLkUF5bGXHBRDB6DJA9ymhmBV8sHG1MXGhMHubi56fwm9tc3H8K23gJdnlh4Ta7GXDuXDYgtnm4KRFDn7jx6987kBkUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727194883; c=relaxed/simple;
	bh=E/gaXjcWfQoJb1wQcf4GOby1GTNe9l3MYSenfHyrMSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+XA57OXpy0y7ubf4rRWVgqU+73yzbV99HXJazxrDzIzeiKgLnI7ZNdpV4DG3TMJx3Hq835TsJDgOmWrPFqxPXdBxDl/Xy8FoIBEd6vIWxhYEUiin7TFEhWfHzaf86Q+r9uy0rL3THtYwL6OwC4NWBCOI7VRTB9IxclryHaBSYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=BZYbLwpp; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7F0CD3F4BE
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727194872;
	bh=EQCi9fW2dWTk233xr7e2blQ3sARsO2oDdWlfuFkrMuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=BZYbLwpphZO0/eqPj3wlcrdym7BaUAvKHe5auWyjIQZVfLxRn+MqNzNzEdA1+KvSF
	 rDpskDMSGF5E9VEwwankh2240+juHnAVBXekUtIBhjhWkCUybjvAZ/yuUty7U9NHk6
	 4JK82nNijwx5n1c9BFjfC2m/IOhUa6JJ6m9mVhkZZqaKQBk5ikAMm8Ms4IK3c0CFQh
	 dsUrfl6xLzi0Iavz9hLAce2VTc198iBfwH2yX/1SaWV1GKdky5VKr505ly4NuYQiMC
	 BtQ39QzvCyqL2OPes7njYWxakTH7KzmdGqmuU7kN78A700iZVsH+i7w6ONkpQ+xtnO
	 JpPSB3RDlUYLQ==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c5b83b6718so2816997a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727194872; x=1727799672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQCi9fW2dWTk233xr7e2blQ3sARsO2oDdWlfuFkrMuM=;
        b=ZDkAl9JF7J6Ql6v+UTaEoCFTnx3tuSDycuK3cVUmI9Pn+2Y/YuFE/oygawBRLwvqq1
         7VlJTXJTlMbkwwrkn/uaXBAtGtzOLr8Ia1QUs4zp+Ov2MRU/GFIescto/il4HhNVfrAF
         FUh4vYi3vgEPLXz6fOcM4tCBeQDrb6bQVfq1XGhLPEjU/NXot6Ei3coYzgNzQ4LCNbY7
         Kq7Yqogu3Qu4OGczmomZcrxHIhtycnmXKsiEGZ3xo6UPL6/FAYVifrTUg/dXM/qoNc/o
         /KGArHVIgL+m0i22I3AIJ+sVzLWgX5FVt+FZVaHGi179HKs+3GKwuVWWZDBpPgQkVDBQ
         zNoA==
X-Forwarded-Encrypted: i=1; AJvYcCXp8yOVmhb6wqOIPnnUlbPP2fNYSOuUh1GLhsrCShBnZpIatIUGTxvsEQ1A/6R47DLvr8P7SY0/iB3sYFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6B5qQW56/RDsAZl+psM3zOLNVJIGTKjCBysMZcV+V1yc3wNx1
	ua1h975rTAoL++ijMoGPxv0QFS0QTF02/c1G8VNvU8WIUNOMq1M4Q5QTvT2hSpFNalEWuREuCSj
	d0/vOSRzXDcRR6Lnu7VKcfFECtR5oL9+mVPJaVTbwRJV9gPshNj549smtqYzzWr0hfNynKXsQKn
	Smh0yXhVxO3GPBBAcR1Vskfr9yRpy1aNiyB66L5+/xGjMZEJggw9rq
X-Received: by 2002:a50:858b:0:b0:5c4:6307:d971 with SMTP id 4fb4d7f45d1cf-5c464a43b24mr12209524a12.18.1727194871984;
        Tue, 24 Sep 2024 09:21:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAvsosFo/e8/9HuFV/tCMLWiEdNBe7QIHix3xfxwiz0r4TlGqYFEicCdSj5wBrYx+tp52hWqYAxR0OoTX1d0Q=
X-Received: by 2002:a50:858b:0:b0:5c4:6307:d971 with SMTP id
 4fb4d7f45d1cf-5c464a43b24mr12209499a12.18.1727194871583; Tue, 24 Sep 2024
 09:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHTA-uZDaJ-71o+bo8a96TV4ck-8niimztQFaa=QoeNdUm-9wg@mail.gmail.com>
 <20240912191306.0cf81ce3@kernel.org> <CAHTA-uZvLg4aW7hMXMxkVwar7a3vL+yR=YOznW3Yresaq3Yd+A@mail.gmail.com>
 <20240913115124.2011ed88@kernel.org> <CAHTA-uYC2nw+BWq5f35yyfekZ6S8iRt=EYq4YaJSSPsTBbztzw@mail.gmail.com>
 <CAHTA-uYxSzp8apoZhh_W=TLFA451uc=Eb+_X4VEEVVZNGHaGjw@mail.gmail.com>
 <CAHTA-uarCi84OTPNJKG2M6daWi=YsWFgf_wd0gKMULeeOvBwXQ@mail.gmail.com> <CANn89i+bZY8vseiWQb6gye=YayDzgrMeyrk1k5Ex_ux-NcMRnw@mail.gmail.com>
In-Reply-To: <CANn89i+bZY8vseiWQb6gye=YayDzgrMeyrk1k5Ex_ux-NcMRnw@mail.gmail.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Tue, 24 Sep 2024 11:21:00 -0500
Message-ID: <CAHTA-uZK_U8_0t85Z3xdJJ-mih7WovgXzXkT1k2VygaXP48AaQ@mail.gmail.com>
Subject: Re: Namespaced network devices not cleaned up properly after
 execution of pmtu.sh kernel selftest
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jacob Martin <jacob.martin@canonical.com>, dann frazier <dann.frazier@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> As I said before, we were aware of this issue, well before your report.

Yes, sorry - to clarify, I wasn't commenting on the state of the bug
itself, just asking whether my reproducer is helpful in exposing it
more easily/reliably and on more systems than other known methods, per
Jakub's original request.

In any case, thank you for the additional context on the bug itself though.

-Mitchell Augustin

On Mon, Sep 23, 2024 at 3:14=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Sep 23, 2024 at 10:01=E2=80=AFPM Mitchell Augustin
> <mitchell.augustin@canonical.com> wrote:
> >
> > Hi!
> >
> > I'm wondering if anyone has taken a look at my reproducer yet. I'd
> > love to know if it has helped any of you reproduce the bug more
> > easily.
> >
> > Patch w/ reproducer:
> > https://lore.kernel.org/all/20240916191857.1082092-1-mitchell.augustin@=
canonical.com/
> >
>
> As I said before, we were aware of this issue, well before your report.
>
> We have no efficient fix yet.
> https://lore.kernel.org/netdev/202405311808.vqBTwxEf-lkp@intel.com/T/
>
> You can disable dst_cache, this should remove the issue.
>
> diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
> index 70c634b9e7b02300188582a1634d5977838db132..53351ff58b35dbee37ff587f7=
ef8f72580d9e116
> 100644
> --- a/net/core/dst_cache.c
> +++ b/net/core/dst_cache.c
> @@ -142,12 +142,7 @@ EXPORT_SYMBOL_GPL(dst_cache_get_ip6);
>
>  int dst_cache_init(struct dst_cache *dst_cache, gfp_t gfp)
>  {
> -       dst_cache->cache =3D alloc_percpu_gfp(struct dst_cache_pcpu,
> -                                           gfp | __GFP_ZERO);
> -       if (!dst_cache->cache)
> -               return -ENOMEM;
> -
> -       dst_cache_reset(dst_cache);
> +       dst_cache->cache =3D NULL;
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(dst_cache_init);



--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

