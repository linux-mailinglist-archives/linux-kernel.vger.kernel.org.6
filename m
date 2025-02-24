Return-Path: <linux-kernel+bounces-529500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24580A426FC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9212517F311
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171FD261398;
	Mon, 24 Feb 2025 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b="VkZScC5I"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32802586E8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412266; cv=none; b=RCJT0608OnqhmSzCY9e50eCTjx9Wz5hvngoZ6EDtMqnwWU3gcMRGNTx8Ov7zreObLPb2Ow9wfy+nVQrOaA5msGsW4KtqcZRMTTqlpr71OMgCQ1HLq2nzmW9wKHWq5KssEbuugi8tYD8PCb4Ih2x1JOX+sv1jTx6N7JLXxLSr5R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412266; c=relaxed/simple;
	bh=urNcMCOkBjYvvIoGcK0YzOhzgaamAKhLhgVqydGZQaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XchzdRdl3rPujqJjWZXSvabPN8F34/MPKYzD69Gzp/sPokOfo5s5jeFFNDNtX4Rg0koGZ8ovzaT6QJud6JYg7Bp6MMJRu5ts/2p8F/DrBj0EWsKnMoPRj4ydhuPNgNZSlH+KRRaFlGQ1uxq6wbq7NQsYrxSnc/UusFpzvTrLWH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com; spf=pass smtp.mailfrom=scylladb.com; dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b=VkZScC5I; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scylladb.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fc0d44a876so7348356a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 07:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google; t=1740412264; x=1741017064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVE5zIf7xhMQy/EVfU5iI/JQVcppTl6NRC/QrFSALCE=;
        b=VkZScC5IWVJVKLavnNA1FYU++DeOzmhtV3MApAyk2Bx5TJvvmq71HYzVShaixYtFP8
         hc9g4hO+JMp+eqR9qEDlCExqT5ZSQR6i7MKzUdOaXNjU2QgIsCJdrmJwySoQXUQKk+mG
         4rI28NBoBl95Q4nPH6ziK/y+FjYfD4Iy0ju16xIcB4y3gE0SjgYuQ0MEHGVICm5zzPKk
         jPoI2HQRrHtiEfvWzaObIsBX9qQwA9QFe4o1joZWPO8iy6ebDBHcR8XMgrammnfEXaWi
         Ba89cLXW1GDiGBAkJjRgnUrhsCvLF93yGBcvY304+g7HgpxHAssih9RIeR9q1zuSr4V0
         pxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740412264; x=1741017064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVE5zIf7xhMQy/EVfU5iI/JQVcppTl6NRC/QrFSALCE=;
        b=ws1fQ2Y3W7IC7R6gmahtbTMmNSTztTrSdborV2XHeNO94RuC36CYCDB/6g8q121Jw6
         6/10t6/2XIbCjK6cFpLL+2ttDzZ7hTFeL3/p3NwfvePO/fSyaLxkGXqAN35b1Ne8Xrle
         HUv4CchxkbxjM5JcDZ0Dn3jyiFf3AOEWVDzI27jSysYH59X5JHlyUEf7TSzEPlZJlC4K
         By99Z8nFQPh4eJeNrMLq5FSeTdfOmlkwlSrcWX2ZWE6AO34HpRyfY8N7oJdkLDJKB4DI
         xjwDNK7w8jfVhwnpWBDoHqyvF20Z1iBZxJZeCxekGvhVMpP9dg73o9I3a+I/xcvLYn26
         f2ow==
X-Forwarded-Encrypted: i=1; AJvYcCU7633w9elaYpxtQd1DUZ/KLEaWoW9INEQqOrHCOiUlsmLrT+eYh4jQoRRSb5V1rn2TUMPFz8eCia4DZ78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy22b/CErlf7Woc7SlU0Mje87wNxNJuekfxm30iaZvmxtMDL02I
	sii/zsMYArYLnWsh+GpAt+7FIbqimB/SFgxqbvC2apfNSKrPpTAFLn2C/gIxSmTNLLEM1eY3asA
	4ABZl6nNuaU+v+iry/vtKYnXvpjVA0IfmQ5vh0lKT+hyGFF37yudtRAZWeET0jmRdx/t+kzsavX
	YaJAYxHQsleCpcH2HlHpblTXt5iK1HyS3C/aNzqmloKfx7HpH/+K2a1xJg41S6Kb1Wiup73Qcez
	CCBAwmvXstG3sRKaEsk1dtKGcctuRzg5fEgQ/mYtnF4izimk1ByFXMOhGVt4tz63BwOPcxLttwT
	CbKBUeMaS4YCiLrdfAuV0PaR4bc3AkrO5JJqjHKNPTExUwveNDX4DhXG2ldZGaKEfiStnpQEMb1
	73xsNTMEQryIur6sYVCZrhsrM+6vi/zphZg==
X-Gm-Gg: ASbGncuBSbjSz9nOOhqfToZgTaqgSbfUnjmLWM935YQe77+MZS8EaNX1O9HTX1iBtKO
	Z0g+SNXSuEj1PQLvVrnszVW3bLw2p92IUslUVOpKBTtZ1W+apY4MC30SDhA5RfIn3koFznTNVmw
	aPDWQI4zGL2IoI5rKhDZVs6A==
X-Google-Smtp-Source: AGHT+IHsCvINcnxQOW+o8QVQCqF8jaKtkYNtzFqeavOaYusjaInUVxxswqCBiGDf3YmqmSw3z9D/HguiBZIpB3uQlwQ=
X-Received: by 2002:a17:90b:2252:b0:2ee:4513:f1d1 with SMTP id
 98e67ed59e1d1-2fce7b2caf9mr19601973a91.23.1740412264171; Mon, 24 Feb 2025
 07:51:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224081328.18090-1-raphaelsc@scylladb.com>
 <20250224141744.GA1088@lst.de> <Z7yRSe-nkfMz4TS2@casper.infradead.org>
 <CAKhLTr1s9t5xThJ10N9Wgd_M0RLTiy5gecvd1W6gok3q1m4Fiw@mail.gmail.com> <Z7yVB0w7YoY_DrNz@casper.infradead.org>
In-Reply-To: <Z7yVB0w7YoY_DrNz@casper.infradead.org>
From: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Date: Mon, 24 Feb 2025 12:50:48 -0300
X-Gm-Features: AWEUYZmCaVei4AAfqe3vnNodRbnQHoRP0SLFpgUKuQd_na8KPtvHoJlGT8fEx1Y
Message-ID: <CAKhLTr26AEbwyTrTgw0GF4_FSxfKC2rdJ79vsAwqwrWG8bakwg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Fix error handling in __filemap_get_folio() with FGP_NOWAIT
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, djwong@kernel.org, 
	Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

On Mon, Feb 24, 2025 at 12:49=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Feb 24, 2025 at 12:45:21PM -0300, Raphael S. Carvalho wrote:
> > On Mon, Feb 24, 2025 at 12:33=E2=80=AFPM Matthew Wilcox <willy@infradea=
d.org> wrote:
> > >
> > > On Mon, Feb 24, 2025 at 03:17:44PM +0100, Christoph Hellwig wrote:
> > > > On Mon, Feb 24, 2025 at 05:13:28AM -0300, Raphael S. Carvalho wrote=
:
> > > > > +           if (err) {
> > > > > +                   /* Prevents -ENOMEM from escaping to user spa=
ce with FGP_NOWAIT */
> > > > > +                   if ((fgp_flags & FGP_NOWAIT) && err =3D=3D -E=
NOMEM)
> > > > > +                           err =3D -EAGAIN;
> > > > >                     return ERR_PTR(err);
> > > >
> > > > I don't think the comment is all that useful.  It's also overly lon=
g.
> > > >
> > > > I'd suggest this instead:
> > > >
> > > >                       /*
> > > >                        * When NOWAIT I/O fails to allocate folios t=
his could
> > > >                        * be due to a nonblocking memory allocation =
and not
> > > >                        * because the system actually is out of memo=
ry.
> > > >                        * Return -EAGAIN so that there caller retrie=
s in a
> > > >                        * blocking fashion instead of propagating -E=
NOMEM
> > > >                        * to the application.
> > > >                        */
> > >
> > > I don't think it needs a comment at all, but the memory allocation
> > > might be for something other than folios, so your suggested comment
> > > is misleading.
> >
> > Isn't it all in the context of allocating or adding folio? The reason
> > behind a comment is to prevent movements in the future that could
> > cause a similar regression, and also to inform the poor reader that
> > might be left wondering why we're converting -ENOMEM into -EAGAIN with
> > FGP_NOWAIT. Can it be slightly adjusted to make it more correct? Or
> > you really think it's better to remove it completely?
>
> I really don't think the comment is needed.  This is a common mistake
> when fixing a bug.

Ok, so I will proceed with v4 now, removing the comment.

