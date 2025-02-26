Return-Path: <linux-kernel+bounces-535104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD54A46F00
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18340188C3BF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1AB25BAA6;
	Wed, 26 Feb 2025 23:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KveEzsr2"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA5E19597F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 23:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740611253; cv=none; b=U8NzkDc0E4eQNao9G56gQ22FOmw7lL6xj/+ar7Od+CJL9a3nRqjOjLFyKScPzUSlsY/d6qWhAwWrd/C54I7Vl5he7jKkfKZEen6zo2zvTb0wn/zRzDap8H+5Z2cvEGaauzUaQZSwFcUe6zvvzjlgHLuzdtvoLFRirYbpq/Gzr0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740611253; c=relaxed/simple;
	bh=pRoo4kt1j3t3xYS1cGP1drmXvTtaQO/4Q2bHSnftOEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXkOLFXMGX6aovdIGjrvuRwJYQsyU6TiHhFs3ef/Nz+ylQSktrdMJiFE+ukwVN0e1bKQk6bKdT0x8hdPI83Hw3s98Ugfwxqd8Iw47wCWGf/96zeRSYnAXan/MvZ9k9SOv3FqsA+l3ekzpnejnj7J7fqr9Iik3TOclalAa1jnknc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KveEzsr2; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54298ec925bso405916e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740611250; x=1741216050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6EFFgter9gAlebiFMms2NvzaWeJFYWFjYw0olSs4d0=;
        b=KveEzsr2qELuw9BoXej6iff2qoCkSw+zea4oGkjD2TZck4/Gmssfn24Cy2xYdkBlHx
         RKoMbsUgMNMIaCgDPVTw35qWsxZ54BSSizBs8yBxpq778k56+Xlnokra0APCJkWpquWl
         V+wJcRMe/lNQiQObLpXuWxJ+lIv+M1CKdNcbyrBLWy9E8eTDsSrhEuuh3pN7d+1lgTrA
         4RqdlTrMu86qAaxtzYv1nlHMbQS4WJQbN+AojjZkyJYKXrI/vmzjjKg7yOYx3xDPwa1I
         f1XfydUwBq87UOqOagcp/ows6ZtYFki117zeSoE5cNSxsvHCOHOAtRbLZL66aEVakb15
         iruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740611250; x=1741216050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6EFFgter9gAlebiFMms2NvzaWeJFYWFjYw0olSs4d0=;
        b=knzE4JLKfJKWCJ21eDxrvRteYhJSq8yp+gWVGZuZxBv6sk8YH/VLdsTYnjhRQs2DpC
         DwR6FrT9rdECCs8OIJbxc5e2HWnKmRhtaVkTSGn94R07apMWyUw7JbaiOJ3ZOq4FbRky
         WaVZNnTSVYiMvBrDQEvyE3NSsha3h3bxUGvR0qg25t7FsI/Ypq94g6F7asHv8swIGm1e
         3WriqDxHqClKU7X364ghElp1eiWj6DAXLXVjZGupSX7cDhjFbiHB9I1JL4h+X+hsVhhO
         Vq7TKOvHHJHwabbJg7ajVGmXvNvlyd19cfyUhcGuYMftAhci5qIBjTw+BTz+peE9Bgys
         yMiA==
X-Forwarded-Encrypted: i=1; AJvYcCXN+4EVbZVffwG+81JsLS+J7hI3PQkV49DWWpaMPOqWTNh0fT36KFt49YEOcbJjMc9nGw7PL76Xek+BM8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfAah41R6djRb8ZkH+fjTL2ZmYPu5YZjE2D1drMd7oZz08h/cx
	bLrofHEk7InTHWeJEvYcfaVruI/cP5KNIiEQBFUlq4p/1wlcb5XygAICxNm1AA6+D1ONhuiG6m0
	xjVXgSsgYkaOuqjsI03Ygf8nrZpk=
X-Gm-Gg: ASbGncuZ1upKibSX2rC6UNmtFGojkl9/2160eUiZpPf4eRedjt0n2osckC03i/zmveg
	5/EWes80NfaVo4nfssG1MU5ZgH6zv44a3ldNpDTvZCgHk23xw3tEHizXdBenMghJdtK5INsEcsY
	Vf9l8a/7s=
X-Google-Smtp-Source: AGHT+IEuqB4IJ3OP9zoL3qsGgFn5WgCkzYkJqBEXvTaf6Vi7/Ve1nDsh1ZOGXPkSvwiNAEYISejaABGjP4jGd1d8vDQ=
X-Received: by 2002:a05:6512:15aa:b0:545:944:aadd with SMTP id
 2adb3069b0e04-5493c5aebadmr3654432e87.37.1740611250067; Wed, 26 Feb 2025
 15:07:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226133703.3c9775c9e50e198abc9b9f6e@linux-foundation.org> <20250226225605.2000-1-sj@kernel.org>
In-Reply-To: <20250226225605.2000-1-sj@kernel.org>
From: bus710 <bus710@gmail.com>
Date: Wed, 26 Feb 2025 15:07:18 -0800
X-Gm-Features: AQ5f1JpzFvrGUf0R0qU0JfhyEu3jv6eTcZL62UzJE6wu__9AYfAiLdLM7x0iDbc
Message-ID: <CAJGd785Eu7iuVwYnewaUm38NJcKzB-xkZwdRiYR9Yo9Qwaoffg@mail.gmail.com>
Subject: Re: [PATCH] samples/damon: a typo in the kconfig - sameple
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 2:56=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Wed, 26 Feb 2025 13:37:03 -0800 Andrew Morton <akpm@linux-foundation.o=
rg> wrote:
>
> > On Wed, 26 Feb 2025 10:42:04 -0800 SeongJae Park <sj@kernel.org> wrote:
> >
> > > From: bus710 <bus710@gmail.com>
> >
> > Full names are preferred, please.  Actually I think it's "required".
>
> Thank you for letting me clearly know this.  I'll request full names to D=
AMON
> patch authors from next time.
>
> bus710, we could still update the patch before it is merged into the main=
line.
> If you could, please let us know your full name and if we can update the =
patch
> with that.
>
> >
> > I'll apply it anyway due to the patch's minor nature, thanks.
>
> I agree this is a simple enough patch that the name doesn't really matter=
.
> Thank you Andrew :)
>
>
> Thanks,
> SJ

Oh, yes. I was a little worried if I added too much noise for such a
small work, but I shouldn't miss this opportunity to leave my name in
Linux history.
Let me prepare a new patch as soon as possible.

