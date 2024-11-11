Return-Path: <linux-kernel+bounces-404778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 875F99C47FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB71282D43
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27AF1B6CF2;
	Mon, 11 Nov 2024 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O1KEnqfe"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EB31A76C7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731360334; cv=none; b=Skr0V30n8yetMKaE/GQ7orO9HmCRfYlJ+oY1sVZ2bu0iQESY7E+0CzgacxpvJMWerlfFKw6CLkkXgWRLOy3FT86CxIm85dN4VfjE0sTRgbb0xGIN328TTAl+hx90CdoqFbZ346tDT467yVnP4ZYcSXbKn2N/iut1ibrr0q7GibY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731360334; c=relaxed/simple;
	bh=sUypRFuKyDC3ccplI6D+lk94/olM1n6+Cw2OKVnu6eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kN8Dk5rIL0KeJIPqGQBjiyWq2Pe3Z5zkDgZkpOWcxDL7ZWUYO7RS+DDPs+Qj6Pa7SgRAH7LGuY0qGCGB7z3EXOrnMWp1P0UD64cy5tTXc/sx213vtLplXRMOoiVYyn7H88x0gTO+wrLkJYRmH8Cgj6Mj3iubPY98GmDP44CZo4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O1KEnqfe; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-84fd764f6ddso3845526241.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 13:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731360331; x=1731965131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/7vDq8uNGhIx2OZW+Hh/oYjDBUjC9lge4OdRMQaeGQ=;
        b=O1KEnqfevvfewkc2zEr57OI+QfbLUxZy95NWOzFktWoXncHjxqs15j9dWJcEvUCsJ8
         HhYIPBcRA4VSy9BaFNrzPpgEhu6ncUdJqcpAVeIVXTTCFtGY8RDJP6Tu6WAfAoLM1vU2
         /XF41Ff5zsIHe8usmfyouR/wouiO+9Kw+vcx8ApFf5Hb3pbCVp+UhrvIgc0To9iq7g7D
         0o6UlZgY1pYUR/GHiVjaCY2a1Nx3f/bnFFvbAj27QdTNQ8xX9lhBm5S+4bHceJTlkSuy
         Ak9Gjk7bOeD36KmaDcchPmZ9/a5QvoVA7RQkp5KEh+BC31Gr/zRQj1BiMpeh+pWeXiZr
         YV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731360331; x=1731965131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/7vDq8uNGhIx2OZW+Hh/oYjDBUjC9lge4OdRMQaeGQ=;
        b=CXPPfFS//70rz+fk2QgboFqAnsn6ieNOE9nkdvkvVzFFv2vQQQ4udkk/omuLV9DUNp
         X23tttQAdpFY4N9ui7Ep/s0aei2GYVwg7xoN2iu9ABYbC3G1/GNI8PX74sLYrcYNZzR5
         pbprLtYqaxvnTbghR/4AfBYdwB7KGw5m7Td2m6YFdcuk8s00Xspr8sGb+v83SpW2/W4p
         8eURL5fyrEgFLPbjshsa0oTplQ+ZOgD5n5eKNpxASL1A2fpanzlEdyicQUjgRnvM06q4
         UJY/XBw6INQTzVaB5CJtjU6Z3uoAKc2cgY2XwJQj7fFK4S/Kjvvxx0soP1TllGiGVHc+
         d1xA==
X-Forwarded-Encrypted: i=1; AJvYcCX//U6o+DD1n2Gwr8/CDjpffPD3I6xJBIplbL8N+uAfsHU1yPtJy1pMaQuK3RHQcO3Gp/OveLsSypCxWus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl6kxvqv36hnKfsNe8/L672mvihCBqGNBJyriGskDqJo8BoAzn
	nFKn6etqimrGw6KUfj6KbqFtgMUrnfkjVz1tX223JLy/d0TxYiaKTn0UQWc+6reNJNmWW16Xexk
	u7gs9rlO0BkHu87YZrEY8dtGt7fLt0woqZMst
X-Google-Smtp-Source: AGHT+IF7AQF9Mar4X4qUFxz/YoINSoZLiVPTxutJwA00vLLJ6hb6ZE8S+bHh9y8FEf0ygejfzW3ddHacI321UaFgOhc=
X-Received: by 2002:a67:f997:0:b0:4a4:7148:85d9 with SMTP id
 ada2fe7eead31-4aadfc18b03mr10710213137.0.1731360331278; Mon, 11 Nov 2024
 13:25:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110152906.1747545-1-axboe@kernel.dk> <ZzI97bky3Rwzw18C@casper.infradead.org>
In-Reply-To: <ZzI97bky3Rwzw18C@casper.infradead.org>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 11 Nov 2024 14:24:54 -0700
Message-ID: <CAOUHufZX=fxTiKj20cft_Cq+6Q2Wo6tfq0HWucqsA3wCizteTg@mail.gmail.com>
Subject: Re: [PATCHSET v2 0/15] Uncached buffered IO
To: Matthew Wilcox <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 10:25=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Sun, Nov 10, 2024 at 08:27:52AM -0700, Jens Axboe wrote:
> > 5 years ago I posted patches adding support for RWF_UNCACHED, as a way
> > to do buffered IO that isn't page cache persistent. The approach back
> > then was to have private pages for IO, and then get rid of them once IO
> > was done. But that then runs into all the issues that O_DIRECT has, in
> > terms of synchronizing with the page cache.
>
> Today's a holiday, and I suspect you're going to do a v3 before I have
> a chance to do a proper review of this version of the series.
>
> I think "uncached" isn't quite the right word.  Perhaps 'RWF_STREAMING'
> so that userspace is indicating that this is a streaming I/O and the
> kernel gets to choose what to do with that information.
>
> Also, do we want to fail I/Os to filesystems which don't support
> it?  I suppose really sophisticated userspace might fall back to
> madvise(DONTNEED), but isn't most userspace going to just clear the flag
> and retry the I/O?
>
> Um.  Now I've looked, we also have posix_fadvise(POSIX_FADV_NOREUSE),
> which is currently a noop.

Just to clarify that NOREUSE is NOT a noop since commit 17e8102 ("mm:
support POSIX_FADV_NOREUSE"). And it had at least one user (we made
the userpspace change after the kernel supported it): SVT-AV1 [1]; it
was also added to FIO for testing purposes.

[1] https://gitlab.com/AOMediaCodec/SVT-AV1

> But would we be better off honouring
> POSIX_FADV_NOREUSE than introducing RWF_UNCACHED?  I'll think about this
> some more while I'm offline.

But I guess the flag isn't honored the way UNCACHED works?

