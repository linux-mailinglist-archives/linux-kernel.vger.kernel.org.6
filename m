Return-Path: <linux-kernel+bounces-445298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEEA9F1453
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1CD16A24D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3E61E0DAC;
	Fri, 13 Dec 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SmaQdNIT"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437C117DFF2
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112229; cv=none; b=KWHwfqNQqTYaUl3jQ/lL0ydQ+ve1Ofxq8cLrgbeTCN8PC6r2wju2mRQIsrHuXGEPOIQqxg/zlFrO974nVlD1TtRyL2o4CpW/tK2cQG5SKnxQ+1TYFrs/IpW5tgHPQy8M/ULxxdrggVEENNZgCIG0npQwV+moTv980ZeY9ofSmMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112229; c=relaxed/simple;
	bh=Djylv9F8tywainvff5k2EtKJPF0tmivJOjhfTKasg6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMydVsEDPlLLvQFZ9su04qHkulW2doG1q5PamM9E7J6je42OZd4C5BrCVUX8cdPWRmTd1yEoESTSjJ6HmFDk+fD36dAsdWhaf0+4n8HzBAlO2DPk30Ep/IzGqXZSTGVQYQocUKsJ95Dy7JylckreiVBNKTgJjF4PSyM2bTIi6kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SmaQdNIT; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4678c9310afso2261cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734112227; x=1734717027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Djylv9F8tywainvff5k2EtKJPF0tmivJOjhfTKasg6o=;
        b=SmaQdNITYYXqfjbdDZPfPpK5X4IZLXR3qURAxuhHLo5MYEhqQu1ulktkJkN29KX1BV
         zOWEdb8Rg2PVWXJ/4srs2mSW2digDqd5mWjXGzAWmBs1dxBd1OSF3zQtPvySCIhuIlL2
         pkLtrwkOMYAp9gwVidzO99gwxEfrIwNG+Pv2w0kaOBoOMa44P1xa0sELzCWsdrw/u3B0
         wwb394TDXttIOzpzLzLiW2cDCIU/12BmHZAsE5nDn6hNqHE5M88RZ49viXhLJUIIx6rs
         Y+gnzTBQ/oo7VoL59xIh+3noR4sUMUVzdZMdPyGxNb9ZF15KUGVgi+8KB1DjkffIqH+n
         /YDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734112227; x=1734717027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Djylv9F8tywainvff5k2EtKJPF0tmivJOjhfTKasg6o=;
        b=dhVGAFf0FQ1NMw4dijbYyJUWpIUnhFCONhhoJx+N+mFbwk00wMz/1jla6t+GZu1DXO
         DOFfpZTXToOq6MbqYfOHU0yIKgOHe0k97IPTPT/Cc5xn7BhQuU8g3v0TLQXH2RZSXJ3S
         SwQGrKBBZwP9qObWBoAckeBLMy/c0to4JCKeZHh7pwkp7W/W5rU5KfC7ImcMx7Onm2Cs
         +Q0XcYVm8AKgvICRuDKFEk1dlGA8RgXac3bA5fT+QuM9UCJBxmDsK+VZaz621D6ihxA2
         2tw/xsOeuHt18OFth+/myAZTW+S8Dq/VFbvGSi2l/qhr1pRuVexrTEH8NzERUS+cKGpm
         lfgw==
X-Forwarded-Encrypted: i=1; AJvYcCVg9epVI8zpzJWfROKwiNDuMzlP0CkKF+pUGtwYzSIH6R25TSZIewJ9ygVZislNggBfaLeLfdgWu2t6Bos=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP1ri5SjuTfbqzfQdgQ1tVavU6HQ703ouLZcAm4d2mWUIdIPZB
	CgcCTKcFkwj6fDkfifgKTola4j70xj+rYAjLr3SGY5QTPVYDlE3pff2JQO93T53V4pXy6hcT5xw
	vvHMGCEsU8aw381gMrQ6OnejiycoC1HXjXJEF
X-Gm-Gg: ASbGncs35rzxwgthQQPLIBFZgxVOb7HfC7mvZ8m1Octg947J+fxVhaaXgVSkDit0dDw
	EDbuayRw8OcHhUZg68wOK7oCR5c5q+LA0N59OPA==
X-Google-Smtp-Source: AGHT+IGSMO8zA0jUSoUVkBiSa/a2+eUBQaIEGDaJyWLq1DM/iNvCaHfDBGc1H2AIsmpq46WzgQc7IWV2n1YjCglPVY4=
X-Received: by 2002:a05:622a:4d8a:b0:467:84a1:df08 with SMTP id
 d75a77b69052e-467a59ccc94mr3694131cf.23.1734112227024; Fri, 13 Dec 2024
 09:50:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209172308.1212819-1-almasrymina@google.com>
 <20241209172308.1212819-6-almasrymina@google.com> <20241210195513.116337b9@kernel.org>
 <CAHS8izOHfWPGaAF0Ri6sN5SVbvD9k_u2-_WmHJHcwu4HDEXj-Q@mail.gmail.com> <20241211182813.789616ce@kernel.org>
In-Reply-To: <20241211182813.789616ce@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Dec 2024 09:50:15 -0800
Message-ID: <CAHS8izO0ELODoGJCz49q-9y1EF0fEauo2h7y177D_vL6x82VVA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/5] net: Document memory provider driver support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 6:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 11 Dec 2024 09:53:36 -0800 Mina Almasry wrote:
> > Drivers doing their own recycling is not currently supported, AFAICT.
> > Adding support for it in the future and maintaining it is doable, but
> > a headache. I also noticed with IDPF you're nacking drivers doing
> > their own recycling anyway, so I thought why not just declare all such
> > use cases as not supported to make the whole thing much simpler.
> > Drivers can deprecate their recycling while adding support for netmem
> > which brings them in line with what you're enforcing for new drivers
> > anyway.
>
> IIRC IDPF was doing recycling based on the old page ref tricks,
> without any use of page pool at all. But without using page pool
> the driver will never acquire a netmem_ref in the first place.
>
> > The specific reason: currently drivers will get_page pp pages to hold
> > on to them to do their own recycling, right? We don't even have a
> > get_netmem equivalent. We could add one (and for the TX path, which is
> > coming along, I do add one), but even then, the pp needs to detect
> > elevated references on net_iovs to exclude them from pp recycling. The
> > mp also needs to understand/keep track of elevated refcounts and make
> > sure the page is returned to it when the elevated refcounts from the
> > driver are dropped.
>
> No? It should all just work. The page may get split / fragmented by
> the driver or page_pool_alloc_netmem() which you're adding in this
> series. A fragmented net_iov will have an elevated refcount in exactly
> the same way as if the driver was stashing one ref to release later.

Ah, I had not considered that the driver may recycle the page by
holding onto a pp ref count, rather than a page refcount. The former
should indeed just work, although I don't have a driver that does
this, so test coverage may be a bit lacking.

But you mentioned you like the rule above. Do you want this removed
from the docs entirely? Or clarified to something like "driver's can't
perform their own recycling by holding onto page refs, but can hold
onto page_pool refs"?

--
Thanks,
Mina

