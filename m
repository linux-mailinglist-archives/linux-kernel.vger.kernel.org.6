Return-Path: <linux-kernel+bounces-238013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB23C924220
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7763C288DB2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5B01BB69D;
	Tue,  2 Jul 2024 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dvaxlk0Q"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E50515B0F0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933436; cv=none; b=igEWj9mUf+24qLFQZ8rUviUrXjReDfNs+Rqvy3Q1Tc6k4H1w6SwqAJPeStA2tENmIo/8YN//N7Pojx+cOBVYTeaoDI9sZ4xsI9vJP7Xs+RR6afZaRaF7XzcoHIwbauWganiWaCiGsi2FU8GmO3mc7RX+GzSI3ISzurTFSH2GcWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933436; c=relaxed/simple;
	bh=qddjwouc8RoAj7jr51rFqx0fiYtDCviRjv/0qU3grIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=in78Y1gp+axcw1mASM1Kyy+gz2lYFKHB+tQ+KKe/INyO3OOQKdsTvipYMDT0bthJAEbLfBbq2GMTjBPcv5/VDJsoxFMWrc18ggGkfLPcpyeAs++mF10YAEQzVfmeagHow5WKu8jwmbVky4x8DUc65L6Gxa/d/2fvozwUxx8yZug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dvaxlk0Q; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-64b9f11b92aso36511097b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 08:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719933434; x=1720538234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qddjwouc8RoAj7jr51rFqx0fiYtDCviRjv/0qU3grIo=;
        b=Dvaxlk0QhXXNbgd/zaaKAE0a7pMQ86cUpwPuDIgnnvUzuwRp4lOJhf94Y7xU8Q9duW
         qTG39x/lvo4L1E3Dj4GELLVgLy2GUhf6Vo4Yfx4kU2QxQk5W30zZRP7/LLDIFz3I14ku
         cc623bFEKKCQmyR9EJXhMlB6yuaZZck3rKaowM78VvNhnFc36doyS5ia3GudMfWrOznh
         thPZtd12Sio1w0dsq0aT7DhkDhowKvq9tDfaRpUFvNWSPpcl8KBQs77CeywzL3Q0m9gf
         f+RUOrEURZEpVs0tX8TPFzGOXFQSnxgdmHSm+3qgPcSW9XR7OzuQiBMEsVnJqqFLYwkx
         qZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719933434; x=1720538234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qddjwouc8RoAj7jr51rFqx0fiYtDCviRjv/0qU3grIo=;
        b=qLZI6tkXRt+XX2SHdZm0uSBEC/XACd5Amn/4Hf2K7Z0wO1IbRxcIqwNIazInwQw5A9
         VYVFT1E5Yt1/X9yeteSvK16EHclcRp8Sx6Q2cYo9aKk7IEZFxMIP7G+W6If5citq/3qE
         HYUTZDnYR2rxuX8VF2IO8Q9uoNz1QhnjbFkITZ8ZfsARNaxuvHLB+bbHY3Mu5IAziZAS
         xLvutbbwDFY3VdvWId0fZXf9DLcwe5LCGI6MKDWkqKA0Jza+cPGLkhcBfvgtDPDiIOdh
         n2IFwk9gkfwUdm6769U7Z+ccwrH7IxHv7tHRmMmi/Qyt3DAAwGxRiYWqqixbdUnfUyGv
         zuvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhLWWiAweCCWNq/jtxzIX4sIA8dUMydfs/O7SSKkJu5V8qcesIUVvkBiJEZjy45jHV2sNuaRyEvF1+292wOy3P8z6YLTiKrDJabazP
X-Gm-Message-State: AOJu0YyXVz3zGjlufP0CJwOsyfEpAgPLnUIJg2uj4LDeFk41Rdn1H0Yn
	aF/Bo0/a2WHRdO9WvhEGDKHz0AsuLw93rCSpTElv0zrx6UtxNt9NpkuBBVMusWqJV/+Amelp30G
	+awFFBTOCpUzixeU/NcSffJTBcBcrdvM+kbzU
X-Google-Smtp-Source: AGHT+IHTVy9xRk6hLI42ekUGvCrTb7U3Xsmwg9IJIsH6OufqdQn7BwisVIKm95gEyqpji8U4ax/lBvGKgz5K5iZrHPU=
X-Received: by 2002:a0d:eb89:0:b0:627:dfbd:3175 with SMTP id
 00721157ae682-64c71144366mr108441827b3.10.1719933433867; Tue, 02 Jul 2024
 08:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614230504.3849136-1-surenb@google.com> <2a0ee369-12f9-401a-9179-82bd659ae201@suse.cz>
 <CAJuCfpE+ae8VSZFEsy0rp19dCFHgT4fOR3MnSWORYa3ORJOjqw@mail.gmail.com> <c5ef58f5-5ccc-4726-a92c-cc9e0d8bc27c@suse.cz>
In-Reply-To: <c5ef58f5-5ccc-4726-a92c-cc9e0d8bc27c@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 2 Jul 2024 15:17:01 +0000
Message-ID: <CAJuCfpHXOP9-Zd1aYhtXjy7hOHZ-ZFdOXyoRpGQwFvvBFxj-CA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: handle profiling for fake memory allocations
 during compaction
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 9:32=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 6/30/24 9:17 PM, Suren Baghdasaryan wrote:
> > On Mon, Jun 17, 2024 at 1:33=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> On 6/15/24 1:05 AM, Suren Baghdasaryan wrote:
> >> > During compaction isolated free pages are marked allocated so that t=
hey
> >> > can be split and/or freed. For that, post_alloc_hook() is used insid=
e
> >> > split_map_pages() and release_free_list(). split_map_pages() marks f=
ree
> >> > pages allocated, splits the pages and then lets alloc_contig_range_n=
oprof()
> >> > free those pages. release_free_list() marks free pages and immediate=
ly
> >>
> >> Well in case of split_map_pages() only some of them end up freed, but =
most
> >> should be used as migration targets. But we move the tags from the sou=
rce
> >> page during migration and unaccount the ones from the target (i.e. fro=
m the
> >> instrumented post_alloc_hook() after this patch), right? So it should =
be ok,
> >> just the description here is incomplete.
> >
> > Sorry for the delay with replying, Vlastimil.
> > Yes, you are correct. Some of these pages are not immediately freed
> > but migrated and during migration the destination gets charged for
> > them. As a result these new counters should still read 0 most of the
> > time except for some intermediate states.
> > I can amend the description if this is considered important.
>
> The fix was merged to mainline already.

Oh, didn't realize that. Ok, will have to keep it as is then.

>

