Return-Path: <linux-kernel+bounces-557998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7D0A5E030
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6C477A2CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E56D258CD8;
	Wed, 12 Mar 2025 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iEG9dvLh"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524602512E7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792853; cv=none; b=VfIzCjHar1oGnATIXvE784q5RVJDpCM9qB8o+PJgrNa3lZWcutedCchbv/gYGCUDpRsff187otE8+x2h3Rc8KFWx8leCNEmruzNhPIBVl35z47WoYTWiYArIA49yAlyN3FXhk+MeoSIOCYg5Gk/0HM76e8LPfODBAooja6nVfIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792853; c=relaxed/simple;
	bh=vFO5RejfroO3/QCBzMpZapYOLh4Wu0SP4ltEFH9/5V8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRmUqMbPWLSji8N67e2DJp9LKomUvr+qZUmZJsTLAxSUP41wIuxmWOjebwubh5dAkZAilJ8aRAzrKcnzLYHNd686I32RPSAbNmsCfmhXHaffPFdEp6rcsS+2F/28jVGkit68RPKFA7+mnTxjAapSvjRST6gFz9OFDhAijSDXW44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iEG9dvLh; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf3192d8bso53675e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741792849; x=1742397649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGxZkF5t/1wrFPJ00FERNaK3N3Q0WGshExeLmGRXwks=;
        b=iEG9dvLhmd0BrnthMwEu0OzD2RHaNIgNqI9g/+nhDui/skVHhKYblZeY0fzLxORBL8
         FrV3UvyNHMzRA7qNTHWAuw1Aq2tCBnTq6lNbE9Xqm+pP3rEGoq3c6TjqBmaQFfJ2CNvO
         aKRrrKiO0Xbv2Z0QYCY5QNzGxQm2ujnD7M++Wwsnpul33P7q/PKgGkT2meQ0SnozOiGg
         M5VrZIm1skS/GXq2cOWPaHqF3R6xxiJUJ7zST7u07RL35DM4ZQXljoTq34KDISozB/oW
         Yd4NpXUg/aPXdPkbt7bCgIAY8GGNJ/gyFEKokmsk8Sz/dpzXy7ihWLhCFyplOYkhaSgU
         Ujyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741792849; x=1742397649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGxZkF5t/1wrFPJ00FERNaK3N3Q0WGshExeLmGRXwks=;
        b=twn92NLiToJhtTyHTStNM3XTA2fG8MP4P++g+qQBv+xIKAL49zdRSYTvZB6dC0Pz7O
         KqqIut6jv5YcJBFSP0ekeKgRFHedh5EWaqGbOY9mRlYBUWTm1bY2uwEYAE9LlozznMUS
         x8B33WMbnu9I/hFEiwt0GMJyKjBgI4aY5IwouJi+stwYOdiAQ8I6EdX27G0XgF15clMq
         cEMh7FrfIM0mtJ7QvC1X4JWkwwUnm3Jz61Zlquzr6L5kIaJoPESwVNoSY1ZnxgDZUuPt
         ULo3Uobta66KKdV7g3kyPQ2dBcIUTuWxPrjnNUPt9kGj20wUON+UunMIL1ZglRoAJc9L
         PRgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn6oRCzEM0BtxZyFGE0X16rq+26iiuJgGpsKikhCx9sL6qoelg/gaeFRkaIgv/4KSYo/E7l2wP51XaWwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywskod8dXhXrJV7lARN0z4tE8DA0yOShJcQ3bgChhvxIIS5PiKP
	XfMPfM12l6fdCZkqhMa8REzSfhuJxBpPg2KfPrsH/WsOtMmDyYGlvhrKs5Oa2/OP3zxMuenO3TT
	/vv9F1ZeinJS5v/S4Z8FTYpa472i8rrh3Eyh5
X-Gm-Gg: ASbGnct48LrdB6T98y7qhQn2KoR7y+MlSES9/G8VgCZGnAfJ5i1oauJpkUlMMigePQU
	KrhGliDJuUf58PgdsL7gPrglzz8nI7YY+5eWdsPuXnGHXffd34Ro/aG80wEf0Xw5R071dwHCIEJ
	8Tdz0GRN+R7OZEQvAjQb5chfUbGHIUdLmja2fLuyb4vnF1c0fsCI0d+2pe
X-Google-Smtp-Source: AGHT+IHD2nQKbwusxnJ80KAjLgbQAOF0EvyAvqqHHVna5q1oZeuBFrEiEEKAahgMMiR6eRSYCFMQhm6AYgZVdiouPL0=
X-Received: by 2002:a05:600c:4f49:b0:439:9434:1b66 with SMTP id
 5b1f17b1804b1-43d15f8df65mr69355e9.1.1741792849400; Wed, 12 Mar 2025 08:20:49
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f@epcas1p4.samsung.com>
 <20250306074056.246582-1-s.suk@samsung.com> <Z8m-vJ6mP1Sh2pt3@infradead.org>
 <CAJrd-UuLvOPLC2Xr=yOzZYvOw9k8qwbNa0r9oNjne31x8Pmnhw@mail.gmail.com>
 <848301db8f05$a1d79430$e586bc90$@samsung.com> <CAJuCfpHjV=nRmkAGrf-tyCxEEygZ0CuW-PRp+F_vHwFbfYS8dA@mail.gmail.com>
 <Z9Gld_s3XYic8-dG@infradead.org>
In-Reply-To: <Z9Gld_s3XYic8-dG@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 12 Mar 2025 08:20:36 -0700
X-Gm-Features: AQ5f1JoRE6F00aRF8p4iMy0O_p5G6IwsOeM_xmMCWwyYOphS5VP-BnJT1SNFaJY
Message-ID: <CAJuCfpGa43OQHG9BmnvxROX1AneCvkuLxFwM+TdxAdR1v9kWSg@mail.gmail.com>
Subject: Re: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for direct IO
To: Christoph Hellwig <hch@infradead.org>
Cc: Sooyong Suk <s.suk@samsung.com>, Jaewon Kim <jaewon31.kim@gmail.com>, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	spssyr@gmail.com, axboe@kernel.dk, linux-block@vger.kernel.org, 
	dhavale@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 8:17=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, Mar 06, 2025 at 06:28:40PM -0800, Suren Baghdasaryan wrote:
> > I think this will help you only when the pages are faulted in but if
> > __get_user_pages() finds an already mapped page which happens to be
> > allocated from CMA, it will not migrate it. So, you might still end up
> > with unmovable pages inside CMA.
>
> Direct I/O pages are not unmovable.  They are temporarily pinned for
> the duration of the direct I/O.

Yes but even temporarily pinned pages can cause CMA allocation
failure. My point is that if we know beforehand that the pages will be
pinned we could avoid using CMA and these failures would go away.

>
> I really don't understand what problem you're trying to fix here.
>

