Return-Path: <linux-kernel+bounces-423904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F5D9DAE17
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997F5167B01
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E11202F9F;
	Wed, 27 Nov 2024 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1D8+9cL5"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4D9202F71
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732736675; cv=none; b=a2ka/kvo+Lv5lo5cQhWay81I3SFx3SDIkMN96/4xkdl1tpVi7EZXBRib1sv5nuk8lCNbCtbSaQCmrZ/iO4v8tlC9K//kmc9T8KKgbfwnWHB1kaG21xpxtPsCmMeWVT3zV/aLNjC6EhUf343fuitfxWMILSW8ucCCIGrccbWdYb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732736675; c=relaxed/simple;
	bh=RM+XcEDlaulXmf6Ae4T+/BtpyHJhEChbGBi8TeWGhWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mm5y6S2JrPCHiyH1Ba4WjDYrtocZv/ddyAqhrcCx5vJhMcGRQUVO8iR3v1/Q4n0dw4g59x6rP7JHX506Zf/vyrKKs1jca8E6cFx/mIMOB2063xLMZeZsB6RCykb/2QsIxPFDCD4ZWZsIYujGXflygRAG5kELjBEB8fl8WX41WQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1D8+9cL5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-211eb2be4a8so6955ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 11:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732736673; x=1733341473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RM+XcEDlaulXmf6Ae4T+/BtpyHJhEChbGBi8TeWGhWg=;
        b=1D8+9cL537GQia7Y1vxyiJxLh/2ffrornYNRxBgqRax45NqSlsmPIC1C2e2q8rf5st
         RHNfxyCFTT5VxoVKImywtzCufryWYXtYE1iMdnBytuj2GlxmdXRZZSBGEQfK7UvsAV9R
         tFQcPS+heLFcAo5IhO+Ue4O7tXfwxu7vmvs9y5Z4WZwQL5AkEDTGUHfrgfeznUYfSVJ4
         TYuqdT0TO60QMSJGSfcDC+7Ef0czCOf9oME31UlucZtbtZJuCSwBChe8EWzG0y4WCAAQ
         lP80mQjq03Tsi/Sn8cOIKhGAfEcBDxaZhIclGghSqi3kF9XvecwmPnPrwo8XMb/LISe2
         V08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732736673; x=1733341473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RM+XcEDlaulXmf6Ae4T+/BtpyHJhEChbGBi8TeWGhWg=;
        b=Ak5PrjMTsgrqz7nZf457SgdRp6YQSi7UPSuR0ZPOlTb4OMGM44sP+1E+2g5WiQ+SFb
         e1ElFwqLnfLLE0HgBl4TMfofB2oq6d+rgmHXxPXe9GNc+OLDuEu9zyRwAoeuRCO4Wyit
         5qZabaxZbQnm+M7R/jArmH5hdM7fICrHN7YpqTJkOBKOFpZHzMx+C8P2v4v2tFiPNS0C
         VVUHJz9WkrvGdJ9XfSDsYFfujA8DLZk7dEP0jR1+/kuvGLPRrhMat1uvHfS9OXY0AIHF
         GKlh0bMO9xBzwSF6FJBgqd1/wc92LVO8j7FztVJRB4ID6yYKGMGkAHnzxqMqfsxe/9Xo
         Ycdw==
X-Forwarded-Encrypted: i=1; AJvYcCXfTpP8B13co9czf+gGwdgzw/7oQOunNuE4rjdBhGKLaZO8TXW7IPTrc62vC0tx47U95tGv1aE8s+yR3WA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY3fXHDWg6BnQgiS8za0MxtKA4KG5myfh48/1NY9suvRYqmW6G
	Krn0MvFULZNDNLRQ0D4NPO2yrHZeE8yHc/pypTi4XyptN8/ouICiYjRjHi2ui4YFzWk1i1WW+wk
	6nZRbR6odyfJJM/npVvygEoRALHGX+xYWmriT
X-Gm-Gg: ASbGncs+TaeHaFyWJZTqr5BRztTcZxbc6SpUweB/bHGn6pTIpmZV/xEXmnQ0gTa0Pa9
	4e7O1uoBkOJp3iZRbcaujMQgAJs3QTzTkhU9CViHWiDL1LuCLnSH+JFmRe/Y=
X-Google-Smtp-Source: AGHT+IFtyQYRshrM5u+HXvUiRw4FYBGSFJku+93YIfswxV69/nOHH3wa18GZc0KaZ3hQyV8/86fX4kBzxP3+Ak5fT3g=
X-Received: by 2002:a17:903:2b0f:b0:20b:bc5e:d736 with SMTP id
 d9443c01a7336-215205d19c2mr144495ad.11.1732736672714; Wed, 27 Nov 2024
 11:44:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez21ZtMJ6gcUND6bLV6XD6b--CXmKSRjKq+D33jhRh1LPw@mail.gmail.com>
 <69510752-d6f9-4cf1-b93d-dcd249d911ef@kernel.dk>
In-Reply-To: <69510752-d6f9-4cf1-b93d-dcd249d911ef@kernel.dk>
From: Jann Horn <jannh@google.com>
Date: Wed, 27 Nov 2024 20:43:49 +0100
Message-ID: <CAG48ez1ZCBPriyFo-cjhoNMi56WdV7O+HPifFSgbR+U35gmMzA@mail.gmail.com>
Subject: Re: bcachefs: suspicious mm pointer in struct dio_write
To: Jens Axboe <axboe@kernel.dk>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	kernel list <linux-kernel@vger.kernel.org>, Pavel Begunkov <asml.silence@gmail.com>, 
	io-uring <io-uring@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 7:09=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
> On 11/27/24 9:57 AM, Jann Horn wrote:
> > Hi!
> >
> > In fs/bcachefs/fs-io-direct.c, "struct dio_write" contains a pointer
> > to an mm_struct. This pointer is grabbed in bch2_direct_write()
> > (without any kind of refcount increment), and used in
> > bch2_dio_write_continue() for kthread_use_mm()/kthread_unuse_mm()
> > which are used to enable userspace memory access from kthread context.
> > I believe kthread_use_mm()/kthread_unuse_mm() require that the caller
> > guarantees that the MM hasn't gone through exit_mmap() yet (normally
> > by holding an mmget() reference).
> >
> > If we reach this codepath via io_uring, do we have a guarantee that
> > the mm_struct that called bch2_direct_write() is still alive and
> > hasn't yet gone through exit_mmap() when it is accessed from
> > bch2_dio_write_continue()?
> >
> > I don't know the async direct I/O codepath particularly well, so I
> > cc'ed the uring maintainers, who probably know this better than me.
>
> I _think_ this is fine as-is, even if it does look dubious and bcachefs
> arguably should grab an mm ref for this just for safety to avoid future
> problems. The reason is that bcachefs doesn't set FMODE_NOWAIT, which
> means that on the io_uring side it cannot do non-blocking issue of
> requests. This is slower as it always punts to an io-wq thread, which
> shares the same mm. Hence if the request is alive, there's always a
> thread with the same mm alive as well.
>
> Now if FMODE_NOWAIT was set, then the original task could exit. I'd need
> to dig a bit deeper to verify that would always be safe and there's not
> a of time today with a few days off in the US looming, so I'll defer
> that to next week. It certainly would be fine with an mm ref grabbed.

Ah, thanks for looking into it! I missed this implication of not
setting FMODE_NOWAIT.

Anyway, what you said sounds like it would be cleaner for bcachefs to
grab its own extra reference, maybe by initially grabbing an mm
reference with mmgrab() in bch2_direct_write(), and then use
mmget_not_zero() in bch2_dio_write_continue() to ensure the MM is
stable.

What do other file systems do for this? I think they normally grab
page references so that they don't need the MM anymore when
asynchronously fulfilling the request, right? Like in
iomap_dio_bio_iter(), which uses bio_iov_iter_get_pages() to grab
references to the pages corresponding to the userspace regions in
dio->submit.iter?

