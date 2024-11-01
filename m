Return-Path: <linux-kernel+bounces-392322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2080C9B9274
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FDD1F22607
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4291A2651;
	Fri,  1 Nov 2024 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DDXHq8OD"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1631A2C21
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468958; cv=none; b=HT0DcE6SBBgZ9hJDm5SMNNyHN8FEOCKfPYbFMh9Lw3ekT+kwoSmfDB0S6L9aEAEMhq7DHEZn8r2QzMgkGfajqBjBuhBXPrrBJVZo2Ljy1PM3dASEjrDnVYHDToenZHRcMYwAbCGIIGYv+vUVvvPf2lh0KHs1Ol95VsCmsw60N8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468958; c=relaxed/simple;
	bh=fBoe2HkvZiBkNwysnrfNCF/ZYFjLG7Kr55DZ36MBq+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMAkPlowHd37OxasDEv9TVQxM45Rd/Ncz8P6NCCDMFeXWIWQ1+tVFJl4LsTmBBU5tpDPs0XMMkt16r9nLaOuGzwDsi90F1+vqBzuNr0q1ueCDFz8+RwtsasIgI47GxvOuoD9IaCgTidzICMfOdjPeiZrsRtHjD+2B/ZqhdDX3pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DDXHq8OD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d4c482844so1209895f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 06:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730468955; x=1731073755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBoe2HkvZiBkNwysnrfNCF/ZYFjLG7Kr55DZ36MBq+k=;
        b=DDXHq8ODN/KvV2qsNX0ckLivdlgh5e1mvAJQNo8XQ0VUEsQQDxdX36QurRAZEO9aW8
         BHU2LU+P+GTylciT3fD/kKDAWzxBP4TWFVMFxyOH2py/dJltAinYnF5LMB+/s0koHhJU
         fWbaBxgow2k4n87wl5msNGL78mhpHGT/1Qxs6OPfD0ZZfml+G0b14ltyQhmYve1i4d1m
         qXfRwJshOJQgmKBhXzAPZhqYObt+1NuxSx8zEXrrPYHYgzmtmSLlhPMWjObk9hOmQbZI
         V4G7InZPWeXo3qgbBpkN6+Xst/o1vYgrAD+M4YFR/xH1cjDIR6Fk9rrbMBWne3j7qHuC
         jLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730468955; x=1731073755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBoe2HkvZiBkNwysnrfNCF/ZYFjLG7Kr55DZ36MBq+k=;
        b=Z3ysOJyCpmcQvLZVH+fqNBg2sIsQ+9wBCrA7v/SkGL2iD3W6jefiQ108tQ0jRSeavA
         N+/yXHWE62PomCQAsC3HDpD0qKlp/7BK0obxKT5IeyhiW5Dks27bQZiHxZRIHYLTBWWR
         IaOQE3KQLzz+1l5XIYvOmOJces5TaZDUkgLZcf+YQrlVUgMBpP/NHJrwqluA48CM5AZ+
         LD0fX8K07h+LUcC3+jrbdFCxrHlJljc/ZfAjGn0vlaqBn8xRjc/9h9LbtI/crLo2KeYN
         bixUPv8teFvxdzrzeVeqTJOted6NNX+Uv/8WDnhXjivNrvKZS6emFg2nCC8ZrWnrj93a
         KZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVovkLx7+GPMZNI87NgjBzTLCpqdU/c16PkmJFBV7HaoUXkjIcnDBus2+1qmTu9GXMuGy9NnYdAuD4daTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylMgVICRLmHfxkokSKMp27C7C7uouffGa+ZlQ4y8Rs7DKs2Q4i
	5PAcXpPF0sNMmtlF17xLMI+jn0sxkah2MYMo111kNgYkw0Ihuo2Z+hBnr2AJ2aSFASziANHJRlA
	Ny+wQ9N73rsWJft4f1bKazzAFs8+U1TZyRIgg
X-Google-Smtp-Source: AGHT+IFOlrIU29li+WwDu+4hXa3QZCTXxmxnhykRkU0LcY5/UHNkfik1M/kZo8wH2HFLuTni65Nwv/ggU7fipxM3zns=
X-Received: by 2002:adf:fb85:0:b0:37d:5047:76d8 with SMTP id
 ffacd0b85a97d-38061205e66mr15059343f8f.59.1730468954573; Fri, 01 Nov 2024
 06:49:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
 <20241022224832.1505432-2-abdiel.janulgue@gmail.com> <CAH5fLgjZ91xFo4hV4dPnDXLFr9jX3na60tVt_KuNU_c6WhhzAA@mail.gmail.com>
 <b154dd13-8cd8-4066-ba3d-6597959ca5c5@gmail.com> <ZxkPC-dLRBqBKZ5J@Boquns-Mac-mini.local>
 <CAH5fLggEGMVspJoO6CE-gTa3-OHfkUnS=L1X-VNC8Cp57GYVkA@mail.gmail.com>
 <Zxk7Tf-jhSse51AS@Boquns-Mac-mini.local> <CAH5fLgh1zXRA1dHBEtiNxWW8kNMtO47bBnaFLVhpzgxsnS1ysw@mail.gmail.com>
 <CAH5fLgjLouU9ZRabJtP9qK6RWNLHZvW6dtUqbCkzFqZO+9skTQ@mail.gmail.com> <fe25c0a4-7e1b-45f3-b413-c52d033c7906@gmail.com>
In-Reply-To: <fe25c0a4-7e1b-45f3-b413-c52d033c7906@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 1 Nov 2024 14:49:02 +0100
Message-ID: <CAH5fLgjdhSgsEkknL=w6cW2OhL=FnxwdZq66BXf-PWs+BzjnVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] rust: types: add `Owned` type and `Ownable` trait
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, dakr@redhat.com, 
	linux-kernel@vger.kernel.org, airlied@redhat.com, 
	miguel.ojeda.sandonis@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 2:38=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> Hi Alice, Boqun:
>
> On 24/10/2024 10:33, Alice Ryhl wrote:
> >>>>>>>
> >>>>>>> Please rename this function to from_raw to match the name used by
> >>>>>>> other similar functions.
> >>>>>>>
> >>>>>>> Also, I don't love this wording. We don't really want to guarante=
e
> >>>>>>> that it is unique. For example, pages have one primary owner, but
> >>>>>>> there can be others who also have refcounts to the page, so it's =
not
> >>>>>>> really unique. I think you just want to say that `ptr` must point=
 at a
> >>>>>
> >>>>> But then when `Owned<Page>` dropped, it will call __free_pages() wh=
ich
> >>>>> invalidate any other existing users. Do you assume that the users w=
ill
> >>>>> use pointers anyway, so it's their unsafe responsiblity to guarante=
e
> >>>>> that they don't use an invalid pointer?
> >>>>>
> >>>>> Also I assume you mean the others have refcounts to the page *befor=
e* an
> >>>>> `Owned<Page>` is created, right? Because if we really have a use ca=
se
> >>>>> where we want to have multiple users of a page after `Owned<Page>`
> >>>>> created, we should better provide a `Owned<Page>` to `ARef<Page>`
> >>>>> function.
> >>>>
> >>>> The __free_pages function just decrements a refcount. If there are
> >>>> other references to it, it's not actually freed.
> >>>>
> >>>
> >>> Then why don't we use page_put() there? ;-) And instead of
> >>> `Owned<Page>`, we can wrap the kernel::page as `ARef<Page>`, no?
> >>
> >> I don't think there's a function called page_put?
> >
> > Sorry I confused myself. It's because it's called put_page.
> >
>
> How do I proceed with this? Should we use the page's reference count to
> decide when to free the allocation and use put_page() instead of
> __free_pages() in Page::Drop?.
>
> In that case, there would be no need for `Ownable`, right? As we could
> just return ARef<Page> in both vmalloc_to_page() case and in
> Page::alloc_page(), letting the kernel handle ownership internally.

Yes, it seems like we don't need Ownable for Page in the end. You can
use ARef together with put_page() and get_page().

Alice

