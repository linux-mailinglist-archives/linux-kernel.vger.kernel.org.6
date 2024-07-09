Return-Path: <linux-kernel+bounces-246758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F4D92C63F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 00:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04411B2224E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAA8187864;
	Tue,  9 Jul 2024 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tk5nKlEP"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD3D15216C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 22:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720564246; cv=none; b=eQweFYzmUO99kl6Rz8g2s/XMpcRd0+Mk5B6uxNtkZjOr2jWSy/5KXYeusGfqQS5PgxkDxeKkZY/Lzu7519mGvTA7IV+ToWBwHOQ3gQaGEwvC2UXjykyD00jSS1VSqudr+B1nf2qHIm65+H+fy/qwDoqlL8grqpUZ/IjKEGvJJtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720564246; c=relaxed/simple;
	bh=VarFIxvxO9tjT1OVyWnV0+42yIgBzb5dd7KMpd9aQ6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CubseCRI+wcIHsoRTzDXQYaA/7cWc0oeVn6Y/8VjtAt98cqaSiPjE/5k5mLy7W+GlsUydd2JCCz092p+cOnF4NTEFfHdsCVqwj5g8h9puw6XjIHWKGYfq2v1eDFPPBmTcMPwmjlYvpnNJ6hAz/Io2MKeoI2oJS9XujUiuTD9PXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tk5nKlEP; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44664ad946eso36991cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 15:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720564244; x=1721169044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGcoQxstQZI9VHlyh4ftH4+Bg/qn65S531lrhcPLrVY=;
        b=tk5nKlEPSy1GaZ9vN//C9MNuzQfMnaVyPg/iZMXhSP9dp0Np0r7TD4AOYskvmDdlME
         8uFnvUsWAkTUjcWXzUaGiV9Br4/yWyiznB5Iv+rrKRHJ7u0IzOdImmaH/TK+KhcbHIkp
         hDpIroVyoIszi2frcYVpbvTRS1wRv9ZsBH5dlbzn4+ErPLZYJQD0PdeTKO4UmsyAhKFB
         6Y8qM3AjxNDqRe+iTpxuoeRRpFIBOt5BhZfXFfdyepRYDn43Ad7PEAvHfDMq3SJRNcEB
         00sri6CAzDcZIc07z9mwKNhP0CPLlJq/Lg/malZEnMPWYW5QdDxOMDGyPZ89169cvlwo
         rMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720564244; x=1721169044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGcoQxstQZI9VHlyh4ftH4+Bg/qn65S531lrhcPLrVY=;
        b=S0oG8jUPGjTvUlTkP1SrI4jwNXpFyOrSud9RKHUC2XGf8y4THfaDSd1uR4FYcX4gpw
         1HAXVGCzndk484Ymmma0Su6cSGZZOY4+dnM+n8WoaaQRvZf0/wH379I/VSLRctyyu4M3
         HDdALEmfXLL5iOC5DAm1v+tCXcGVo1XgXF1dD7PqoD3/wHFsAstNAs3QjVZyTxEzWyW6
         XMv3KwUm9RJBxRXE2hRERcA88kzOgSMd9oETGAB8oHQ3r1HVC6Pl4aIqu1upFmiLdz8K
         j+WkaKscWERVYAkIM+/yKBVdMsNbTHhXPzGjk+wyTsWCjSrlYqsv35KtV7CDHEjIEIdT
         BU0A==
X-Forwarded-Encrypted: i=1; AJvYcCVFfPAyRj+8WzTSEZpUjN6rwgSTBt8ETAznpSqYsaY3WrReCp2D+EV01ZAeI8K+t5FfnZFI24GZieIiHpEpA2y2Awv2yX6FEVFt/TRN
X-Gm-Message-State: AOJu0YwUI1rVPEvvkOTPyWrLxzv20zt+2/PFkXZw9uE5pBfhqdDkGYN/
	z67s2wiRANcRZnpJP3CyF3WYetgrdPFOuAHGf44s7cyrAceVbpxdd0/Ap2l5h7CU8yDjV1LA7xn
	gKJGDZDmU838j5AuBn+IOM6IR0nFuLZUQ2opiUBO7gGqZZHKB1b0j
X-Google-Smtp-Source: AGHT+IFinXKb6sb/B8zLRBy/AQDpfa2WMQ7T0fuQo4Vb2ClhStHbMg6cFDXdplbrVSNLbw3WNy44RLQEoTSing9bmcM=
X-Received: by 2002:ac8:73d9:0:b0:447:f958:ab83 with SMTP id
 d75a77b69052e-44b19e672cemr497141cf.21.1720564243653; Tue, 09 Jul 2024
 15:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708212753.3120511-1-yuzhao@google.com> <ZoxqAW5_GjbesrW5@casper.infradead.org>
In-Reply-To: <ZoxqAW5_GjbesrW5@casper.infradead.org>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 9 Jul 2024 16:30:06 -0600
Message-ID: <CAOUHufYnLeggF+34-L_Yn-UUyRb+ZnTzmByy-wL-3xrfdrycEw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1] mm/truncate: batch-clear shadow entries
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Bharata B Rao <bharata@amd.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 4:36=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Mon, Jul 08, 2024 at 03:27:53PM -0600, Yu Zhao wrote:
> > Make clear_shadow_entry() clear shadow entries in `struct folio_batch`
> > so that it can reduce contention on i_lock and i_pages locks, e.g.,
>
> I think it needs to be renamed, perhaps to clear_shadow_entries().

Yes, thank you.

> > @@ -503,8 +486,8 @@ unsigned long mapping_try_invalidate(struct address=
_space *mapping,
> >                       /* We rely upon deletion not changing folio->inde=
x */
> >
> >                       if (xa_is_value(folio)) {
> > -                             count +=3D invalidate_exceptional_entry(m=
apping,
> > -                                                          indices[i], =
folio);
> > +                             xa_has_values =3D true;
> > +                             count++;
>
> Mmm.  This is awkward.  It's supposed to return the number of pages,
> not the number of folios (or shadow entries) invalidated.

I didn't think about this much. It seems to me no callers really care
about it other than some debugging messages?

