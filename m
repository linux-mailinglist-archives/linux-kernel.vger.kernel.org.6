Return-Path: <linux-kernel+bounces-351527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 367EF991288
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 00:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2DA52852D3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0875314C59A;
	Fri,  4 Oct 2024 22:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1bz6KL8l"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3D9146A68
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 22:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728082572; cv=none; b=sGjd4BUglRawAvoCd3otjx30wH9chWkYNJzrsuLgUmFtvJteuSEE8v4f8JRKNMct+/+BM8K9HxWE9O0GHuGnGJ8kV3Bkbm5JxQojuNIo4bDHgt+WinkAJMaf4jDRiMwC96HuM84Eep32YRCxWIP1tlzk6e0wiuKsHK7vQsLwJQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728082572; c=relaxed/simple;
	bh=VhddXDVJd8X7TlNOLaduuvcjH/uviWU7nxc+sB0oa1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0kOs8MqGilxvJDTzI5IPHaUYYHXQQN9zjINeRHtgns9MhXAu/PK+IYIgVbq2ezXJxv5BVvb5T44CUXPcvyZJ7huEif1VmMgZXjLTyit3FrdceV3b5sujUMPiS8riuBoC1+yMLmmszi0psGo+39kvRoImxjV8DaWsgfGBjZ6wXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1bz6KL8l; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c87aebabd7so9053a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 15:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728082569; x=1728687369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQLY/bzdHQr84xbdr5RKXt6HWhOcNV2GLWNFgYSMKcg=;
        b=1bz6KL8ly8/G1NVSZDSl1U0k3ls0IGNeyQh2J6Tq4IWNpg8u6MGmprrhHEVTWGIF6q
         0i4E7eMrIO6Po0SI0TLE7xP4QntfvfHQq7rZ3uUF9VYnTyAuN+bNHUUh6mXYQFIh+IKA
         kmWrHESaLqNwcAvWAuVE4oDSvmyY0XANmyMEAsrdAgXWaQrTiZh9JVF48A1kzfzB6qVx
         uWXTUJWCZ9wfkbNUIXbEudXg3bK3I+KbdwtmGyxpRiqqDsaEOEoM21nEjVzEJh78eIKY
         E5ETtF7pQAKIiO3EKTCzEycrU2rj3XDyAapYuU3/TR+aiPamPjVRNuqQ4xhKBFUZxP26
         2jGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728082569; x=1728687369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQLY/bzdHQr84xbdr5RKXt6HWhOcNV2GLWNFgYSMKcg=;
        b=ccBeVhUNPGoHGH+I+agUH93QrAZYEN9IVCXFWIUeOJ5a/U7ISsOfml7e4x9VOUvpzU
         BSbtonCm/PPXnOjy5rJOaXCDF8Lnk6WA405xriXLWm7/xglcWmN3IUXkTERE1PnhmIVr
         WQ0FBbQvzZNOinXTK/l7H8rWZ4v8P7SWMOFnmbeCPOeAJu8lvoQUe6tAOO2p354pSq74
         IFRqTE86Q9X5qr0KpFVEG5Oy+mLKzvDz7CupTTYC6fY/OqGTyzy3D0pIwbSYDSUo/uQM
         fhxWFAtZrRCT8Hfw1R6ErE4EDPNYiaAhxk8DhEXtkAZ/hE/EOu9bLopLhT5e/vcwZRRj
         j1AA==
X-Forwarded-Encrypted: i=1; AJvYcCVsHuB27mr8oRRyaEdHTmHXEcK5xcjVHP+q50HTN2TZ9g/3RinaEDKPM36lHlfhgN87gpkyW0+ItRCWkxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaF2VfvwbRjHnIfYjuaDxiNzVIkqZm8eOCqQPm2w1RNZmvYN+p
	nhPBi1csvg4iTSExEQHZWsj+Lh6NSPTMVJF4F8fKkUNdH0D6sDza9pS7ThsdBio0/mzGNBOY+EO
	waRHovIpLRVJUuJ01ONRpbhG1/Uw6OO2Kinzy
X-Google-Smtp-Source: AGHT+IHSO2el5qL9P674iQY9ZloirwLUiBzDbJUnWRKjEj5nvXFcgHqvTMo05KadChLcVL5eF6f3PkKFz/T79PcoJqY=
X-Received: by 2002:a05:6402:4301:b0:5c5:bb25:5a9c with SMTP id
 4fb4d7f45d1cf-5c8e1e989eemr51685a12.7.1728082568844; Fri, 04 Oct 2024
 15:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929032757.404707-1-gxxa03070307@gmail.com>
 <f8dde346-8a81-4cca-8497-987f6e4b5e58@redhat.com> <CAPTztWY-CD9REdJq_-HeELJ+dX68+OZC76T0F+YMyZKMc-DHug@mail.gmail.com>
 <2a7b7fc3a48d4bb9a6394e51af074017@xiaomi.com> <20241004153947.43c5b16b7f75b0f60e918019@linux-foundation.org>
In-Reply-To: <20241004153947.43c5b16b7f75b0f60e918019@linux-foundation.org>
From: Frank van der Linden <fvdl@google.com>
Date: Fri, 4 Oct 2024 15:55:57 -0700
Message-ID: <CAPTztWbTieT1St6QRR6dJAPyVrZHU4GVW8F2j43whMdf3+Vu1g@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW0V4dGVybmFsIE1haWxdUmU6IFtQQVRDSCB2Ml0gbW0vY21hOiBwcg==?=
	=?UTF-8?B?aW50IHRvdGFsIGFuZCB1c2VkIGNvdW50IGluIGNtYV9hbGxvYygp?=
To: Andrew Morton <akpm@linux-foundation.org>
Cc: =?UTF-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>, 
	David Hildenbrand <david@redhat.com>, Xiang Gao <gxxa03070307@gmail.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 3:39=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Fri, 4 Oct 2024 12:23:30 +0000 =E9=AB=98=E7=BF=94 <gaoxiang17@xiaomi.c=
om> wrote:
>
> > > > +static unsigned long cma_get_used_pages(struct cma *cma) {
> > > > +     unsigned long used;
> > > > +
> > > > +     spin_lock_irq(&cma->lock);
> > > > +     used =3D bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma=
));
> > > > +     spin_unlock_irq(&cma->lock);
> > >
> > > This adds overhead to each allocation, even if debug outputs are
> > > ignored I assume?
> > >
> > > I wonder if we'd want to print these details only when our allocation
> > > failed?
> > >
> > > Alternatively, we could actually track how many pages are allocated i=
n
> > > the cma, so we don't have to traverse the complete bitmap on every
> > > allocation.
> > >
> >
> > Yep, that's what I did as part of
> > https://lore.kernel.org/all/20240724124845.614c03ad39f8af3729cebee6@lin=
ux-foundation.org/T/
> >
> > That patch didn't make it in (yet). I'm happy for it to be combined wit=
h this one if that's easier.
>
> That patch has been forgotten about.  As I asked in July,
> "I suggest a resend, and add some Cc:s for likely reviewers."

Indeed - I certainly wasn't suggesting that anyone else forgot about
it, it's up to me to follow up here, and I haven't yet.

- Frank

