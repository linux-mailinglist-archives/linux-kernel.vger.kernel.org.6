Return-Path: <linux-kernel+bounces-379354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615E89ADD81
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1950F2819D1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD5F18BBA0;
	Thu, 24 Oct 2024 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="09FsMYjg"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5751B16DEB5
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729754610; cv=none; b=Ax5WJNaMxg14+TTjMSBkt/0VYvNaRh12/4xBW5b8+uaL/KrYNLi6pHNNo0/csc844V2CUZehA5SJJgZC0THXyCk6ysJsnWCoI38FgQiszAxd7Z1iBxgNkg329HGgWgGhvMwsrSUGElgtyR6R14QVjqVPhEmfdALDJbmc8v5k7zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729754610; c=relaxed/simple;
	bh=NUf5vsCqWDPm0OIwNmgUWaqxky2gzOkGmBQ9DnUdAvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1vMFybVeddW6gfrg8d4Yzre7cWJCZuJL1AbF13Nzs2Mtjd2lWu+HnUhQK/wWI3eNoOor/R4FUBwZ+DG8CevhpfmDm9uO53ZamPDzDE5d2UBH9mZvN2v3hWp30x+rf36lmsr4C/S98waDqSIJ8euRYn09MsaEr+u/rUYX0GNYqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=09FsMYjg; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d4a5ecc44so378392f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 00:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729754604; x=1730359404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjQ3VSBcMbvoBOSbq+eLgFcX/NE3MbB3Xfds4RRtWEk=;
        b=09FsMYjgvgBsIEiWW/vtHBHh5TIUSbn8zPPhZyzihXqsn/ZyXzAi9PRewaF3lhjRht
         Tm/pwXi0GXND7HPnRDAI1y80IA5hke2b/8X7qhOy9SLfVDLRf6opMxKhmvNCTcPu2HE0
         TXavI+SiDIY2VomaHtzGiHcKZnmkLDmodcvmiSMe2jhL5Jci4KaKXB4Oa84BnBreLQR5
         JhlAraTeipn7YRJyqIB/8DKbDGtYeeSR478FFpdDUgP6z75D6H7rU/5+hUxLpO7yPpiN
         bkhoOfQ8psELbawczECUvPZiBQuSkvQ3ly+vkP+wWFvrhFESeiymZ6+RgwTslzitkIth
         DR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729754604; x=1730359404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjQ3VSBcMbvoBOSbq+eLgFcX/NE3MbB3Xfds4RRtWEk=;
        b=Uo9Cl6T8RImKBH6M+HegpBYpz4teXclNOAHLrky7b8NbQ28lCjjxG6GLxyoq6nYnjk
         6XnvcLfe/gDBqGHA20Qrt/dmdjZhbej/6mQEzMGW/9qwUjZ3sJi1rxE+k9gWM54oT7nb
         5afio00y+FdvRgmk71dvmWA7EgZqDuK8Q3Cv9BEvUw9a+PgmzOdEE1ECxVUOxcO9IF8y
         oT+pyrKibpJztejOYZxbqJX636h8x2zywQwWpqFAxj6W/QNNDOxgJFByWH0Db/uuIZMB
         RYqSTPwNkgE02qacAmglPCKGWKHZoXaaSpZeAFyaHakaE75VtNztBm0fjw4qJ5i0VvdP
         g5Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXWkGA3ZVt6o86sXCTXXq3U3jJAPw3nfXUJz1jInrl3vMRmJlLS0zr5maLjb1BXLTWJ318Qpa2vSvn6/Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxlkDcZojNXfNcHjyFDn5weXgo878fcEnMM7/fLBUAG1w/SA4C
	inSC+xHxxoLxY8bAILvvSxhlzYWz4UEeuwmNhsvL5Oh69H08bRCJchj6wzthDJz+BKP3fjWQX2Y
	dGvl9w8fn5X0MHgAPvZFZSH3SJZxBpLIPOyB2
X-Google-Smtp-Source: AGHT+IFp0poCfIXUOQkUrqqum2pObWFIoUI99VN6TmYo9C67y3qDw5okBA7a2XjhtCZ3e1knqSnV+zbEnXoFxGZ2bgc=
X-Received: by 2002:a5d:69ce:0:b0:37d:51f8:46fd with SMTP id
 ffacd0b85a97d-38045868bf7mr757387f8f.22.1729754604487; Thu, 24 Oct 2024
 00:23:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
 <20241022224832.1505432-2-abdiel.janulgue@gmail.com> <CAH5fLgjZ91xFo4hV4dPnDXLFr9jX3na60tVt_KuNU_c6WhhzAA@mail.gmail.com>
 <b154dd13-8cd8-4066-ba3d-6597959ca5c5@gmail.com> <ZxkPC-dLRBqBKZ5J@Boquns-Mac-mini.local>
 <CAH5fLggEGMVspJoO6CE-gTa3-OHfkUnS=L1X-VNC8Cp57GYVkA@mail.gmail.com> <Zxk7Tf-jhSse51AS@Boquns-Mac-mini.local>
In-Reply-To: <Zxk7Tf-jhSse51AS@Boquns-Mac-mini.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 24 Oct 2024 09:23:11 +0200
Message-ID: <CAH5fLgh1zXRA1dHBEtiNxWW8kNMtO47bBnaFLVhpzgxsnS1ysw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] rust: types: add `Owned` type and `Ownable` trait
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, rust-for-linux@vger.kernel.org, 
	dakr@redhat.com, linux-kernel@vger.kernel.org, airlied@redhat.com, 
	miguel.ojeda.sandonis@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 8:07=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Wed, Oct 23, 2024 at 07:52:23PM +0200, Alice Ryhl wrote:
> [...]
> > > > > > +impl<T: Ownable> Owned<T> {
> > > > > > +    /// Creates a new smart pointer that owns `T`.
> > > > > > +    ///
> > > > > > +    /// # Safety
> > > > > > +    /// `ptr` needs to be a valid pointer, and it should be th=
e unique owner to the object,
> > > > > > +    /// in other words, no other entity should free the underl=
ying data.
> > > > > > +    pub unsafe fn to_owned(ptr: *mut T) -> Self {
> > > > >
> > > > > Please rename this function to from_raw to match the name used by
> > > > > other similar functions.
> > > > >
> > > > > Also, I don't love this wording. We don't really want to guarante=
e
> > > > > that it is unique. For example, pages have one primary owner, but
> > > > > there can be others who also have refcounts to the page, so it's =
not
> > > > > really unique. I think you just want to say that `ptr` must point=
 at a
> > >
> > > But then when `Owned<Page>` dropped, it will call __free_pages() whic=
h
> > > invalidate any other existing users. Do you assume that the users wil=
l
> > > use pointers anyway, so it's their unsafe responsiblity to guarantee
> > > that they don't use an invalid pointer?
> > >
> > > Also I assume you mean the others have refcounts to the page *before*=
 an
> > > `Owned<Page>` is created, right? Because if we really have a use case
> > > where we want to have multiple users of a page after `Owned<Page>`
> > > created, we should better provide a `Owned<Page>` to `ARef<Page>`
> > > function.
> >
> > The __free_pages function just decrements a refcount. If there are
> > other references to it, it's not actually freed.
> >
>
> Then why don't we use page_put() there? ;-) And instead of
> `Owned<Page>`, we can wrap the kernel::page as `ARef<Page>`, no?

I don't think there's a function called page_put?

Alice

