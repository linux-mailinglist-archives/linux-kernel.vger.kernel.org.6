Return-Path: <linux-kernel+bounces-408340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FB19C7D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341B2284A55
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF701C9DC9;
	Wed, 13 Nov 2024 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zT8k7raE"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F10918A6CC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731533071; cv=none; b=BTdHx2cZwRuAEttipRQDPiL8ckUWvnu2aEfjSSmw7jfdZMS4wvRblWKUogPBQxSWGpUscFA1V3PdICdLuJnZ77BqNl2DMDlT1Z5YwNC/f5gNjItjpVyY8SOoR/nxaN8HFg9ks+iOUgMpboNO4LdXX8MH4mt3gJYnnVDFNdIYJoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731533071; c=relaxed/simple;
	bh=XCqA9wKC12t3gjM94B4qJ2dyxdJcIMdG+sAgDz3MJuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JrpQMuQ1PZ1kQ/TBkMZwIs9p9UggdgnYgFd+tFBImYllCdFWa75yGP4oiPldNH6dG4+TLl+FWaddfR7xlzgfdlLCsMjtUFB9ANyXgm8UXOySjIIoLTI42Ufm7iNUJuLh3XJyb4mrgZrikCqdnFI+qaI/SCksf3BnrZoGbKxhhF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zT8k7raE; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c93e9e701fso2947a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731533068; x=1732137868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WALPwj00gB0ma8t1qi9YCWEzgMiAXx66M8d65obtXCQ=;
        b=zT8k7raEEL+pr65voSSRiznFxdBW6uYudLtI7iHuj3ag30huvhSVcDpxANXoSKIxYT
         J7zPFA0b2KPR78OmlHaAeBsBkmg93s6uEHMQOPYhft5+9wqeYyY+XJzOEfaPPToKfoeM
         FG1cm7yS5bsXUGqZ1S52PmhH3J2e3/VjxlGALgIzcq3AcvDxARpJqm+YxKLAz36a3tax
         6j3HRIA5m9fgJKUG1/BcOJCHfcL+R+txa3+s6ErlL+Vm8p3c94O5mxzy3e/rajI6HNqG
         el7PmMlkTMRGhMRoMiMg1KEiOehcu8ocQx6fa0nPFyr+S16B9BM+kuffuqKXdK+qMtL+
         igSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731533068; x=1732137868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WALPwj00gB0ma8t1qi9YCWEzgMiAXx66M8d65obtXCQ=;
        b=j7oTY/Jdmkqs/zCbX2gGiHbjjyuM+gi8EWRRXmMohlPHFv/5TfN7UrhsjQmYyKNJeB
         fgoIKsGXdDnswlaZHiqZ4u0YA5wUWKP+UpZ1WDOxA6E+ODz7XWGYWTZjJIfhnmHGGRCo
         fhu7wX6J/AP3BY3IqE6xCrshBOUR75eij8PfzBIczly597vfwSmpkPpUesTb6klbQY3a
         XfRTqOmktNNP3Rt0gJh/4krCnF31f45ozcqedx1C/sJE75D/gnGdAq2hIhGzuAmO8Ic6
         mNocXTm9mXMl9H1zqy5RToMn7WTMvYqpXxYBnpFKXAw4TnyPw4/Hfck/tqGuybm8ChQM
         WKdg==
X-Forwarded-Encrypted: i=1; AJvYcCUmoRGsK06PFI1Z4gpEdthia1gD8CUFmKmRssrnWOV58866dWdMG7UkHscZX1JpIsz92q2/NnKwO75AKpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxs3nVtumirVz+zyDdXua++EnltDb2FMwL1KiLnbCMZoNsm5aX
	6+IySw7neETsob54Ik8/o0N14TM/D5QD+2nkEbkMWo+aFVUj7y544GCGKJ1IakC2URUyi0jPNJS
	2vWnwwIczoo8+Ot5PvuzonpoXzhLllT8a3Tb6
X-Gm-Gg: ASbGncvBycW3dtUaBKd5xJlaQvSH7fIWJUMZ/R/71ddNBsJEKEzbLpOINJcGGZBnvUf
	AeozSKLmof2zy3cYdR2pB8WLaz+lmMQdDJ76cI7opCKGKXvqMqM61OKMg+mOG
X-Google-Smtp-Source: AGHT+IFfLNMBVXixSLINqFDfIpRoTPK96jE6ghQ+OIDXRzVy5SViDkAaMVqzB27iNuyze13HZhhc94KsZh47a2fZZoU=
X-Received: by 2002:a05:6402:543:b0:5ce:c7a2:fe71 with SMTP id
 4fb4d7f45d1cf-5cf759092edmr106413a12.0.1731533067298; Wed, 13 Nov 2024
 13:24:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112194635.444146-1-surenb@google.com> <20241112194635.444146-5-surenb@google.com>
 <54b8d0b9-a1c7-4c1b-a588-2e5308a977fb@suse.cz> <sdfh56itaffzhpk4rft2tsjm7r44auhjomfthzgxzrmj5632eq@noi2uhgp3a3h>
 <ZzSwM5qwStadOZvv@casper.infradead.org> <k26pa6fhn2j6bgfwtcdp6u5vk25mkclitzvqqeqvji77k4lqop@yowwrqusmdyp>
 <CAG48ez29OcD=NL0EqW3hO+3VNzkZce5REcYev5-M09-_HOqsDA@mail.gmail.com> <ZzUTMw-RajUTcOgS@casper.infradead.org>
In-Reply-To: <ZzUTMw-RajUTcOgS@casper.infradead.org>
From: Jann Horn <jannh@google.com>
Date: Wed, 13 Nov 2024 22:23:50 +0100
Message-ID: <CAG48ez0ZLoZno_ov=ZO3vaQnGRT6ddo6e7NmS8TpQTmy7RzmJA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
To: Matthew Wilcox <willy@infradead.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, minchan@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 9:59=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
> On Wed, Nov 13, 2024 at 05:44:00PM +0100, Jann Horn wrote:
> > Something like NULL or (void*)1 is fine with me but please don't do
> > pointer-to-itself - we shouldn't unnecessarily store a pointer to an
> > object of one type in a pointer field of an incompatible type, that
> > increases the risk of creating type confusion issues (both in the
> > memory corruption sense and in the Spectre sense). I know MM already
> > has several places where similar stuff can happen (in particular
> > page->mapping), but here it seems like unnecessary risk to me.
>
> Hm?  I don't think page->mapping can ever point at page.  As far as I
> know, we have four cases, discriminated by the bottom two bits:
>
> 0 - NULL or address_space
> 1 - anon_vma
> 2 - movable_ops
> 3 - ksm_stable_node

Oh, I didn't even know about cases 2 and 3.

Ah, yes, I didn't mean it can point at itself, I meant the pattern of
having a pointer declared as "points to type A" ("struct address_space
*mapping") while it actually points at other types sometimes.

> In fact, we're almost done eliminating page->mapping.  Just a few
> filesystems and device drivers left to go.

Ah, you mean by replacing it with folio->mapping as in
https://lore.kernel.org/all/20241025190822.1319162-4-willy@infradead.org/
?

> Would it be halpful if we did:
>
> -       struct address_space *mapping;
> +       union {
> +               struct address_space *mapping;
> +               unsigned long raw_mapping;
> +       };
>
> and had non-filesystems use raw_mapping and do the masking?

While I think that would look a tiny bit tidier, I don't think it
would make a significant difference for page->mapping or
folio->mapping. In the context of the VMA field, the question is about
whether we make it possible for the same memory location to contain
values of different types, which I think increases the risk of
programmer mistakes or speculative confusions; while in the context of
the page->mapping field, the same memory location can contain values
of different types either way. So while aesthetically I think having a
union for the mapping field would look a little nicer, I don't
actually see much benefit in making such a change.

