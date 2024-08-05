Return-Path: <linux-kernel+bounces-275276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 089659482A3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B9FBB215A9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBED616BE13;
	Mon,  5 Aug 2024 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EKYb2QWh"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F60315ECD1
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 19:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887514; cv=none; b=AaR1Plaseh4Knj0vihwLF8DfmJ9Pcyd0R5Xg+sF2KADh08dTrPDZYPu9yHP265UWF+IGCGIgtgsrX8i/RHiIjKYqND4XLdvKsM35y6WG9Q7bar5R3rB/Sn3vaeaRHLvTCF7IAomv8aT5H+LV2jiGZ6c5cttNDzxpnNo5ScVrhLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887514; c=relaxed/simple;
	bh=MKaEvwgxlUJbtC3vDe4rGcbwyWE4hU9fgCG9vg1wGho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+BdE4KjKm6W4qU10nlWJY4Kd5LiQdRqNr+7gzO/R7cbfEHglCbmvB99cWdakbwcxuc7572r4+c0BQCo10RejPalZsRs30YGr4rMJpl+srkE8EEQfxaFshrXJulwRYnp2/VcB4FYg7+W23tXljs8RZm6W0XTkYcNVqdx7SC996U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EKYb2QWh; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4518d9fa2f4so84771cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 12:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722887510; x=1723492310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5tYKDVZwZWnOdC/eVNfcY75U8ARXf8jOMiCRghD9qw=;
        b=EKYb2QWh99YuSsGK7a7rK0cOjir7M3c2xxXob2Z5CPjdfGWL+ezQU+qDMiGhOPkdl8
         cok9PP5pHh3Etml0wUE9N8ys7zTkNy5UnaGIhdic32lCpZnMQ/We3Zuwl1pCZSBVVMz+
         A8rEZnEZD8oYzp9uOEZE5Zhxa49DjH658fObemtYBmr7Hf5JzL33NULS/ErMoP9aJiFh
         DTar5mR086rXpzeglHawqoQ1NPlVFaQVcjjtsdkd0D4mq64z0loT/myzRhnw5pq42uNO
         byoi43O1UQ+BBMCK1sJlfsn05xXDf50VGtdSQaMSYK7x/nwGjuZekPyuSLLTZvrSww6s
         U1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887510; x=1723492310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5tYKDVZwZWnOdC/eVNfcY75U8ARXf8jOMiCRghD9qw=;
        b=qKcF7YS1X0Lxt6iXxgDd71mH4GiPcUXK8SZxd18mSgdiqjNAygqZKAGeFtqVVMLEM6
         amsGvU6Q8XdHtaCO1ijYRPzBwi86q2P/pYR6LdGy6X3TvHjbpJMsHS3BqFag2TcyonFD
         sm+Vb9GdnPfRW2vy9VZ/btHqL63onv+FMWmJPDeOUWHS3ka4pjiIhbFiCA3BhVHDdiT+
         chepi9HcqN8r6nntmcM0uk1a4dAfm7Uxq1rREAk0ZdifZaGX3avXVxFauErnGImZ/h/E
         HkkCRuNQkYSdO6x1iaMqf6RjD4RSVkUZFhuF532dch5o5Ug+CjIH3ORgfywg+8RZdcg5
         YqKw==
X-Forwarded-Encrypted: i=1; AJvYcCWOrA6AXGpUcOMph4hpIfHysSCVYsWafNRzAabRC0tp555fMyzwfVHehYOMvM8cjnEXa4SCotQKOgJ4qYsuqNdNBZuQJYvzc0RqyPVB
X-Gm-Message-State: AOJu0YzELytPGjOYfDO2Pn8npnc0Scbt4WWSWWyrWsbsoycF4gkcecCj
	tbja4yRK7P6gTVfAdgTHLoRukvVPee/jrn/8k58F4pulHi3XuL5e1FZoFyK5ONR9e4szJTxRsNu
	s7jbDvwQPdc6cb5BFXSIEamPYVX4msSSzH/1I
X-Google-Smtp-Source: AGHT+IEWYnD8zi9B/9e6rsEEFUT2DDvElQ2Eudhj+kVTkeneK2S5lMccsus0ay4fQqoaWUv3I46OXolsus2IOHEtW58=
X-Received: by 2002:ac8:5889:0:b0:447:d555:7035 with SMTP id
 d75a77b69052e-451bb9c7f0cmr451931cf.13.1722887509768; Mon, 05 Aug 2024
 12:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <CAOUHufb7z13u51VCTGZMimoCXpmfT5AOAbrUpAvJjTx5+AXwew@mail.gmail.com>
 <aea333fb-44ab-41eb-9060-472b08e3010d@redhat.com> <CAOUHufZ=Oquy_UGBC0FTjJ5QvQnhk0UipHBMfJ5yqSYn06qevg@mail.gmail.com>
 <a3e367bbb2d3f32532b54ad91facec3ff4fee686.camel@surriel.com>
In-Reply-To: <a3e367bbb2d3f32532b54ad91facec3ff4fee686.camel@surriel.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 5 Aug 2024 13:51:11 -0600
Message-ID: <CAOUHufZG1qQuA=cvG+46VwvTrn8yU8nY06vC0JLuUj2hthcSWQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
To: Rik van Riel <riel@surriel.com>
Cc: David Hildenbrand <david@redhat.com>, Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	roman.gushchin@linux.dev, baohua@kernel.org, ryan.roberts@arm.com, 
	rppt@kernel.org, willy@infradead.org, cerasuolodomenico@gmail.com, 
	corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 7:33=E2=80=AFPM Rik van Riel <riel@surriel.com> wrot=
e:
>
> On Sun, 2024-08-04 at 15:54 -0600, Yu Zhao wrote:
> > On Thu, Aug 1, 2024 at 9:47=E2=80=AFAM David Hildenbrand <david@redhat.=
com>
> > wrote:
> > >
> > > On 01.08.24 08:09, Yu Zhao wrote:
> > > >
> > > >   I would recommend shatter [1] instead of splitting so that
> > > > 1) whoever underutilized their THPs get punished for the
> > > > overhead;
> > > > 2) underutilized THPs are kept intact and can be reused by
> > > > others.
> > > >
> > > > [1]
> > > > https://lore.kernel.org/20240229183436.4110845-3-yuzhao@google.com/
> > > >
> > >
> > > Do you have any plans to upstream the shattering also during
> > > "ordinary"
> > > deferred splitting?
> >
> > Yes, once we finish verifying it in our production.
> >
>
> Shattering does seem like a nice improvement to the THP shrinker!
>
> However, given that the shattering code is still being verified,
> and the THP shrinker policy will no doubt need some tuning once
> more real world workloads get thrown at it, would it make sense
> to do those two things in parallel?
>
> We could move forward with the THP shrinker as-is today, and use
> the increased exposure it gets to fine tune the shrinking policy,
> and then move it over to using the shattering code once that is
> ready.
>
> Is there any good reason to serialize these two things?

I'm fine with whichever way you prefer: if you are eager to try
shattering in your production environment, I'd be incentivized to
throw in extra engineers and get it ready for you asap.

