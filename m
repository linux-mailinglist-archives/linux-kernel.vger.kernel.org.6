Return-Path: <linux-kernel+bounces-431606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FE69E3F55
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93172834EF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A35120C49E;
	Wed,  4 Dec 2024 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bk6By/cp"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6631320E013
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328526; cv=none; b=FtPRv5pQ02Hiw9l0DbjnKACF7cmWd9FrCbY7pDBZNniSiLhNDxpUR1KFrIqbUgOKmjKUE54BZyUlgov+rmRwMf+rqfLeq41XAY07zipK61aV4QsvLUXaOLSCxia3J7rmEixbP3XTO7L/Hsq7m11/SCesjWLiYlCYsVbBTPNccTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328526; c=relaxed/simple;
	bh=VrhLbO+EEZuoacKLzq664QF9Xuc9/3r58NxP5QOagaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6EzBXci+L86BCEjFooQXExu828Yb003Oqq52og0rjISRifGFAGwUn93L5lMuXtQI1L1Q6Ux9zW6uhBxNoAnr3g/qzH+bsi9mSII4oAIQO1UQNr9gJBf9Dfn6QGmPNVdGxbdux4vfvBQ3XG6+HEDnSZJm5rzWWP5Ylmh88z5nWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bk6By/cp; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d0c5c8cb5cso8650a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 08:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733328523; x=1733933323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnMUx5ZxepC8/TuU6UxU43komWhGup4ZMyqTd2FagEE=;
        b=bk6By/cpmYYr6J52k/QadXwtlCp3cbX9kdqkpzsPwRgnQoRFAnVDrA5qFVLQ2l/rsE
         iGIzSBCbqtsbu0PeRfnrLrLKD4aXbY+L3Jgv1tqk0qvq7X2g2BX3+AFQy3TjKrsEfP6X
         OETK++56VdxK0VWrq2tLWSS8zt4UcP5UQvba+WPlaivdHcVZFgqd2HrtJgq8A+bSTHUc
         PFb73mqs5HkAjSWVb/nTAZHHsJkXflmOLWk4V73MuoWlbX4+NY3lN9Qyx1fNgBAkozRo
         CI/0N9YHWBKJ+C5u/UgZaY2w3VZiFMF8vj+Qx0G5Y3bJhpLzmsMrUIdymFG1wJ0e33Et
         YojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733328523; x=1733933323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnMUx5ZxepC8/TuU6UxU43komWhGup4ZMyqTd2FagEE=;
        b=igNX6Xn1GBiyVF+qnZhwHJlU2V6k8m5irI+j7r6YyH5fyDzmxY+Wf1yFgLcnEtJG6K
         s5bbPg8tQICgHSTSO3noG5uqPa1Slc44UigBtYtQYiwrhbOA8dbqNcfTOwn0oLcpoM25
         GCJvaPy3o7EVXnOYO0uGg0RW2rOAF7E+RO4DSvP8NlPuSZHhpwXkz9Fd7Y9qZHLJ6+s9
         YegD54yAoRR6JEbBoQltqiE8NJejd+wO8WVd0IJZSj1Ype8S5Df3DCeReQyU5x1cwGje
         uNwAjP/Rtfpd0nwNYYoyu2ZM/Hf4z4uk7G5617znmgmag0a9Tr1Ct6eA7E3YAZMfRj7L
         7+8A==
X-Forwarded-Encrypted: i=1; AJvYcCWhkU94z+C1057Wmu1pIMlpFiDbOrlUQ3M7vRJDUgxeesxRnbGIihozSbKOXdZqM2QeyyD6V/Ef7mP3SnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzXZkKsD1hzOWsx1mxvSHlkOatFUTSUwU1QHuaYj4s1q73qdrd
	ykM17vDfnTAR9GxbNdvV16/8870amOIrxT3TUNND9IaxNFzX3/vh/r2UlTyXHdQ401GSp6Bbuxi
	6Z/+macI32yswm7nV8camd5CiTZFHQHMDDgGO
X-Gm-Gg: ASbGncsE01Gc6Ga2NpiVYXKC1BkvfREIeSTRnuXioOFec4w9fWoQmHj55hrLc3YK16P
	96dFFR70WDSCzfkkDTqHVF3+gtBZ9GIeJKIlHsf1A8vhov5356Lky2sy6Is8=
X-Google-Smtp-Source: AGHT+IFosrGSGc6Y1n5WPmV+g9HhEBiIwlEUrd3FP6QrHjGIXnaUTQYm3ZtZGZUztGRrGfdimPyGzebvo7kNc013Nzo=
X-Received: by 2002:a50:cdde:0:b0:5d0:eb21:264d with SMTP id
 4fb4d7f45d1cf-5d118ec95a2mr76865a12.1.1733328522131; Wed, 04 Dec 2024
 08:08:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-udmabuf-fixes-v1-0-f99281c345aa@google.com>
 <20241203-udmabuf-fixes-v1-1-f99281c345aa@google.com> <IA0PR11MB7185EFC7E59546204A617DE9F8372@IA0PR11MB7185.namprd11.prod.outlook.com>
In-Reply-To: <IA0PR11MB7185EFC7E59546204A617DE9F8372@IA0PR11MB7185.namprd11.prod.outlook.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 4 Dec 2024 17:08:06 +0100
Message-ID: <CAG48ez0VJr=nuWciFZPLgUFOVca=Sac+4-_8Amqorv9WsBF6vQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] udmabuf: fix racy memfd sealing check
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Simona Vetter <simona.vetter@ffwll.ch>, John Stultz <john.stultz@linaro.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	"Joel Fernandes (Google)" <joel@joelfernandes.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Julian Orth <ju.orth@gmail.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 10:09=E2=80=AFAM Kasireddy, Vivek
<vivek.kasireddy@intel.com> wrote:
> > Subject: [PATCH 1/3] udmabuf: fix racy memfd sealing check
> >
> > The current check_memfd_seals() is racy: Since we first do
> > check_memfd_seals() and then udmabuf_pin_folios() without holding any
> > relevant lock across both, F_SEAL_WRITE can be set in between.
> > This is problematic because we can end up holding pins to pages in a
> > write-sealed memfd.
> >
> > Fix it using the inode lock, that's probably the easiest way.
> > In the future, we might want to consider moving this logic into memfd,
> > especially if anyone else wants to use memfd_pin_folios().
> >
> > Reported-by: Julian Orth <ju.orth@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219106
> > Closes:
> > https://lore.kernel.org/r/CAG48ez0w8HrFEZtJkfmkVKFDhE5aP7nz=3DobrimeTg
> > pD+StkV9w@mail.gmail.com
> > Fixes: fbb0de795078 ("Add udmabuf misc device")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  drivers/dma-buf/udmabuf.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> > index
> > 8ce1f074c2d32a0a9f59ff7184359e37d56548c6..662b9a26e06668bf59ab36d0
> > 7c0648c7b02ee5ae 100644
> > --- a/drivers/dma-buf/udmabuf.c
> > +++ b/drivers/dma-buf/udmabuf.c
> > @@ -436,14 +436,15 @@ static long udmabuf_create(struct miscdevice
> > *device,
> >                       goto err;
> >               }
> >
> > +             inode_lock_shared(memfd->f_inode);
> I think having inode_lock_shared(file_inode(memfd)) looks a bit more clea=
ner.

Good idea, changed that.

> Also, wouldn't it be more appropriate here to take the writer's lock inst=
ead
> of the reader's lock given what we are doing (pinning) in udmabuf_create(=
)?

I don't see why that would require taking the inode lock in write
mode. I am taking the inode lock to provide exclusion against
memfd_add_seals(), which uses inode_lock(); in other words, the
inode_lock is to protect the sealing status of the file from changing
(which is a reader-like requirement). I'll add a comment in v2 to
clarify this.

