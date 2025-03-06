Return-Path: <linux-kernel+bounces-549977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5CBA55966
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1676176F45
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B34227C177;
	Thu,  6 Mar 2025 22:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEHa04lx"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A99B1E5B86
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 22:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298926; cv=none; b=K5i/U0vnsiU555QSNBC0VEtgntJvDNRaHyYCkscNcwT5HNbZ6QT40mZsRCyP4YIcyvj6hdqoJBtH+nh7EsbDWFLX0m3SuLBYBrMiuQ2fy2Mrq8TWGjHH/UBGIiaE8W94t2pW57EX6VnogPUwMde9/Ts4gWmYy7n+RkPjS1rMC4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298926; c=relaxed/simple;
	bh=8mEWwVG+dPM0ev8gGGZOXwZ9bc5Q8c6LbREPw2UcnYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A12qtQa9bcsFZbxBLiianylcVd7VsiCPPjU2Nq5+X72cTIPob+twU/Z60PJLoxQ7ORmHXejdXkIGVmpto8j9d819hlQoq2jRo9V66AIn1WQ6rHqZZD3IvDOr1z36FE7IzHljtCEIxwGf98hariB+EwPZkEhqfWBY6/ncXXScVQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEHa04lx; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7be6fdeee35so229776585a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 14:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741298923; x=1741903723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEE7NsftkQUqXiTUuNy6G99jpfQ/qqsTMCdl+H0vwQQ=;
        b=NEHa04lxopeVp4NMd4s7ehsuRL42Ire/hHFvb3vZVxUKHjyGwtfGs9RM9+ra53i8Nh
         /eoktvd5th2fackBtqXstsh3m9kpIE7IWUE2q9WIJYWfZIfsyn1p62KmChq2EkHk+AR2
         1baCnYKtXGw9LIpgucJ1WOrIbDVsj4vc8JO4OeCn9UFx1bv7jR01F26ZjlxwjWEAUnbN
         X7QttA6yCHEcb3mn00qjw1YqvAM30GeIKk5as4ZETmKk4iNjEmOoCJhk7//s2xzV5Of1
         kNIxaXIZ6es6hZFMj8nsberbeQKT/jOdbqnxFhNU1HOxOr51c0vB9AXAbUOMBvDZ3E27
         prjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741298923; x=1741903723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEE7NsftkQUqXiTUuNy6G99jpfQ/qqsTMCdl+H0vwQQ=;
        b=iEUjp6I5Ger2CVQBZ8kRY2H7NUtYaXtK0z3L95TzLqVCJiNg1MPftx0wPP8MD8gvq+
         0Agv+eO6lnZLzePEROmXt/8SDs25+5EJYprGDAG84LFpGOaXBLFXnOrh3mpMXtsLzZnY
         XMoSzARYZ/IcdCMGbKcVXzLF7REs3JVjkBko91z+DQLQg55osgy3hLqde1YwXJ1onXBX
         x8PaRTjtkH6YebbkXpzgKL9rn5b1iOW4X+qo9HT+/RlsW14gcGsdEh+LzLjx+h/GQmbT
         J6bb9oQ6eQrOuEuq3NEiUX6S8UyZGymwP3i8SxczS5sVaMWRDV4wdqok1XaiWU5E3Fhk
         682g==
X-Forwarded-Encrypted: i=1; AJvYcCVq88kJu2ap4e1MMT6Qh5bn4woCPq3GTO0fsL5kyO9Uhl455MNJlx6pihcKi650VP3uZQXBe64TRA95DTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRUZHx/auPd/xJ9/OckMbmHcxgMrn8LcOx5bsJg4sdEHLRtbp/
	ADKAGNF+tmK7luMHpQTkbWjwyN9gGtxYTLaC4iU+3cabXgOvp2lGdQKD4+s1llGEL+syP6O6YPe
	WDz9qFfOIDHmcuXSzLHcnaMh8dSkV3ppH
X-Gm-Gg: ASbGncv/4vQsBtcoEeDRAC7S5kiA8As1AsoxkYXU5+aLqzZ5297lNvlwdkWm8kuy2RO
	89k6Wcv8WqxfYEVbaAVjJpxoki76ttZiQsEIMk7dsV3IwozK+2nOnqxO7NuY+mm0ZrQ9ZAFicpo
	J6lo+Ncis9tOPMKT3y4i3vHjz9Xn+YAKWeGMjja/+Wrsbuejl/Lb4zg/v+BA==
X-Google-Smtp-Source: AGHT+IFS53kcenQGBfnzTlvVjKHX9DytQE+sWxJfhIpYHAPPf3CBZ0Dddj3dsQErG50SQvPWw3rea+2+sKx5Akv5pfY=
X-Received: by 2002:a05:620a:284e:b0:7c3:d280:a67c with SMTP id
 af79cd13be357-7c4e168b415mr130976985a.17.1741298923332; Thu, 06 Mar 2025
 14:08:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306205011.784787-1-nphamcs@gmail.com> <Z8oUbUQrE5zlpezC@google.com>
In-Reply-To: <Z8oUbUQrE5zlpezC@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 6 Mar 2025 14:08:32 -0800
X-Gm-Features: AQ5f1Jr6gfeWC2e7UeBsnVNZE9bBatA0QhkDQY4YC0iMXHH8TKPQbnXqksG86Ek
Message-ID: <CAKEwX=OtUGzTnP3RMz3hG2v3AKqG2LJ71_w5sQL+kxR1wnAGKg@mail.gmail.com>
Subject: Re: [PATCH v4] page_io: zswap: do not crash the kernel on
 decompression failure
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 1:32=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.dev> =
wrote:
>
> On Thu, Mar 06, 2025 at 12:50:10PM -0800, Nhat Pham wrote:
>
> Couple of nits below, but otherwise LGTM:
>
> Acked-by: Yosry Ahmed <yosry.ahmed@linux.dev>
>
> (I did expect the swap zeromap change in the same series, so if you send
> it separately make sure to mention it's on top of this one because they
> will conflict otherwise)

Yeah of course. I actually have already finished that second patch,
but wanna spend a bit more time proofreading things :)

>
> [..]
> > @@ -1606,7 +1628,26 @@ bool zswap_store(struct folio *folio)
> >       return ret;
> >  }
> >
> > -bool zswap_load(struct folio *folio)
> > +/**
> > + * zswap_load() - load a page from zswap
>
> nit: folio
>
> > + * @folio: folio to load
> > + *
> > + * Return: 0 on success, or one of the following error codes:
>
> nit: Maybe worth mentioning that the folio is unlocked and marked
> uptodate on success for completeness.

Will do!

>
> > + *
> > + *  -EIO: if the swapped out content was in zswap, but could not be lo=
aded
> > + *  into the page due to a decompression failure. The folio is unlocke=
d, but
> > + *  NOT marked up-to-date, so that an IO error is emitted (e.g. do_swa=
p_page()
> > + *  will SIGBUS).
> > + *
> > + *  -EINVAL: if the swapped out content was in zswap, but the page bel=
ongs
> > + *  to a large folio, which is not supported by zswap. The folio is un=
locked,
> > + *  but NOT marked up-to-date, so that an IO error is emitted (e.g.
> > + *  do_swap_page() will SIGBUS).
> > + *
> > + *  -ENOENT: if the swapped out content was not in zswap. The folio re=
mains
> > + *  locked on return.
> > + */
> > +int zswap_load(struct folio *folio)
> [..]

