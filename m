Return-Path: <linux-kernel+bounces-444452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9831C9F0713
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2364E16AA1F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B096519CC2D;
	Fri, 13 Dec 2024 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MY74L7O6"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE56185B78
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734080449; cv=none; b=asqnK+Zn5amid8J7tX56rq3PyTxlXBIXf4nHO67lwcfnPnAw6jSxqWOHlR6uuaIfv6MqRdmxfitl75l/yKFh+KxAOE+deOQHIgYz9u0NwTmDwl3HiPb4cHIcsEBz5aUyE5HnajiAOqg7H2o4PvvSvBD3NVpYC9l7p/7Ldlxyf5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734080449; c=relaxed/simple;
	bh=UQ+8aHJUcjMQiO57HSnFD5XExWuUx07RfA4t96YqoqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANNq6z1+QthjzXB0s8Cc1YcxW6fhm8FvOuExQAxCI/HaxcFPzCCKQWiTpIUi2BCN5Fz3DxWoTNkd8OFMA81sS+rArPQsuXq7wuoh7rYGWaVb8ZUtNWphxMs0cYDmHbNQQMY1hj+0DvdFHZVZc2jcXN8US4pvGy2bIJ4udXZWwGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MY74L7O6; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4afd56903b7so357149137.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 01:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734080446; x=1734685246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7S8rKd6xTzHInUsx0i7mn+ATlyAHGgIqNuk8MtwP4HM=;
        b=MY74L7O6jQ5QEXZ+cf8O2vQbJ9WA+Gmi0IjAARZk817hPYrfP+nC2kXD5VPCIGMCqo
         9VLxqOfLx2/RD5HCXoMPzGlJvJbj7g8WjBbjNfhi+dLWtP58Z9+O7S4VMUakiMLZB3SA
         /zxLEWcUdywbODwTXNstJ1OKiDPPDItVGuQQhYKryDSmgBKQa5OwQ87w107sNxvwYBCZ
         zP6OYlZzDByJvEBsuq5yTeoA+aS8lM7rqcAYfxPdVVOTYgNgJTO4Q2IAjbQwexdN19eZ
         PzOg/gI/X2QwEOyQ4lZ5+PNsx5UCE6PwY0WBqCY7H64yW6yuwiYJZgZVUJCR282RK9lw
         FNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734080446; x=1734685246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7S8rKd6xTzHInUsx0i7mn+ATlyAHGgIqNuk8MtwP4HM=;
        b=sG7Gr+Z5z/GUYjpyRVvg3A04kVCRE3pD47lKMzVqN//xM3g7nkVA7ijHyTlRXsBY4q
         lhN14WmqGijGiFOkt1hkWsd+5WJjy3aJgd/QTa3xixSSS9X+vzzIzTRHWQG6y9GvrDEG
         1Qscm37/wHtsVCaKWyUJ826IDSI26wxAd0AlNWmNzaidfbf/Gi44Xr5H3J20oQ4UzcHe
         EK63qP9uEUSYNvaLopwG8ECHoO5qXGVfzweiNdRnTM9gB3Ds+sFAbffJowdx17jVIlwp
         mjq6hI0E/qSk0sVr9DIZK/WbekH835MPrDDmqZ3JutfTZuTBDlR9xcuSXlRtD8T+F891
         GO+w==
X-Forwarded-Encrypted: i=1; AJvYcCXV/7zYB5Z68L5IWTCd7jwpZIyzBdHWFTJGFRWYLjL9n2qmqFwU2/0UHICiL07XzCiuvhbVtwCWwWbSC0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc+3nRZcBDEONYxSVYCecjaitCgL55omzUILzmoOVIPjWVwKrJ
	1tfBcZAUxvNXkj9jfeyU4zZzmlW7Pi8YXvczdEeV03STIJkyzk2Ivskc6+Cr+5Xy4QIw4inoQrC
	t4Oulyxs4POVOEP0LtvX9xgvd1tZz9A7x5XwM
X-Gm-Gg: ASbGncsuwCMTRoFdHDMp5/I6wDtqQcExfgbRi99sPyV6wDOdmQdAUiyQfS/eTpmvc7o
	fEQWOPQNv99vQGBnvcvDQ+NCIqnwFsb4MgAZIWJu/+dtZ+lGAiyJxIqs3jO+YpTxLsydgJFU=
X-Google-Smtp-Source: AGHT+IGvIL7GeKBjvBibiHP25Ku4VYCRKfZwOfk2g/lgbZa8LVfQVHPh0FwCpC8H5G2Ipv/oimRJCI9zQnuFNGZDzH0=
X-Received: by 2002:a05:6102:8099:b0:4af:5f65:4fd3 with SMTP id
 ada2fe7eead31-4b25d96b9e9mr1882465137.6.1734080446319; Fri, 13 Dec 2024
 01:00:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211105315.21756-1-lorenzo.stoakes@oracle.com>
 <CABi2SkXTSi8HKTyE1WoL3qqOTk4KDnF1-RkSOX+ne=cEFJL4qg@mail.gmail.com>
 <a2c43cfe-5c99-481a-b599-fca8b4fe1e38@lucifer.local> <CAOUHufYCF0i_aJZPceMXfcTZUcZsCY9fBuMr=25q1bROWx5nsg@mail.gmail.com>
 <e3a61eb1-2224-4700-8df2-28a93e2aa1a6@suse.cz>
In-Reply-To: <e3a61eb1-2224-4700-8df2-28a93e2aa1a6@suse.cz>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 13 Dec 2024 02:00:09 -0700
Message-ID: <CAOUHufYSQFNS16YBe1W=ZpxzT0r5yKLj-56az+fpioGf2BqWsA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update MEMORY MAPPING section
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jeff Xu <jeffxu@chromium.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 1:25=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 12/13/24 06:50, Yu Zhao wrote:
> > On Wed, Dec 11, 2024 at 11:57=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> >>
> >> > I'd like to be added as a reviewer on mm/mseal.c.  Is there any way =
to
> >> > indicate this from this file ?
>
> I don't think the format and tooling supports adding a reviewer for a sin=
gle
> file out of a subsystem. mm/mseal.c would have to be an own subsystem, or
> Jeff would be indicated as a reviewer for whole memory mapping.
>
> >> This is something we can consider in the future, sure.
> >
> > What'd be the downsides of having an additional reviewer?
>
> General answer to general question: being R: means 1. getting email for
> patches touching the files (if people use tooling properly, sigh). This c=
an
> be also achieved on the receiver wised by e.g. the lei tool.
> 2. being perceived as an authority for people sending patches, some of th=
em
> not being familiar with the subsystem and the people working on it.

I think you are saying 1 & 2 above (the meaning of being R) can lead
to the following?

> This is
> why it could be counter productive to be given out to just anyone who ask=
s.

I understand the words, but I still don't see the logical connection.
Also, Jeff is not "anyone", and I'm not sure why he can't be
"perceived as an authority" on mseal.

Anyway, I would encourage more technical contributions rather than
"administrative" barriers.

