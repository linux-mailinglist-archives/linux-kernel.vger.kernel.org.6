Return-Path: <linux-kernel+bounces-421697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 996499D8EA5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 23:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C94E283559
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6771CD21E;
	Mon, 25 Nov 2024 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0q4IW0jM"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BC71CCB20
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732574592; cv=none; b=rrf9MVx+EZke6T1bGEc1zdW+MM5o4G1SK6SdAddzq9S/Xy6dSvKMboOf4sBpRU7d6Kx8VbMGgxVQ8dYILW5tvAORDrN21AVoH3vsWqCFeJ8Wgt417Z0iUwjnNteYViid/ekFpH/E84SMNfJLMdwNQ+F66HyRXa4ZViRr1lGfSsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732574592; c=relaxed/simple;
	bh=V6+H4eKbaQhCSZgN3j65rncOjdbtaxUeMJHPdFeg54M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMfDKfx0QfuhqjcHytxMVGUeZEl6XuaiUhlGL7jhKfCPbS7ajqe/FbkvEX02EWHI4EquaD5sAo4vJ1ZI/fmPSQpGD+ztrHajoTxqzhv2BRB1PClkQn3QkN0OqsLraBxsFK66yLfjWf07IsCmm/VTWZc/PsaxH0vc4lxMSv7+O2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0q4IW0jM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4349c7b6b0dso5405e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 14:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732574588; x=1733179388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/EChfWz4TKZywi3mKncP0WWHvFeVl+jJhUOSEjnMxA=;
        b=0q4IW0jMpplXZ/WmL9mUCT+7fZDaZjiOOUQLklEYiTvscoTG197T+JLB/GSdKJvMBx
         9aetIvbWWYHEWKsISROW95ZhvWGfovAmbOIWYUHIjfwl6PQvImKcQqjrCD9W4qouiixX
         nmuWTmPdHaDi930KAbIBsIiQ0IFfg6MnOeKEW3VNTJVbIhEFrL8bDMEQtHD1R0PmFz1/
         B6xGQ7O5BOqIHfymyBMqJH9yOKPBtMPC0aGHouULOJdMbpac2Pd1CYHuq5rz1uTizi09
         +3VHyOEJBAN28knBAgNSmFwKOfxTbi/ptUbcu2uhzxbNEA3DINdhouwHWsK0Tuudwy7q
         qEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732574588; x=1733179388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/EChfWz4TKZywi3mKncP0WWHvFeVl+jJhUOSEjnMxA=;
        b=JC8CoP9fv+mZ6DSGI4giUw4ZQyUApid2xx6bpe5NX6WGTguwxw4C9ggfa0FU7giWPJ
         /YHTW+JjUvVxFRduqKHjQWikya/yXYpHiUvDGGOUl1XudNOA4uDIXjjSFkxAz0TVtVFL
         ss63dq0NhnsSEEMo8XjZPVxY0rhawB9VX6GnOj2aspMhr1e/DjHotjpr90i6GzjJU9DT
         biY92Lo3KgyqWFhGKwvq991U2tg1bhDhF2LnliWg2dnxXcxd978HottUXjkbUlMLlvYx
         erDc0v6KxftxCWvx+h52m4k1sxc6clvFAVIL62ucnBNMMUYx/3W/9xGWmFOOn3A8F/2R
         TQpg==
X-Forwarded-Encrypted: i=1; AJvYcCVfzxW9oR4jYxRyfejt7QN/UGwCned5Sy6Mk/YWfT673ua6zjcXgPgIiKI9EMf0ZgltybX8HfVIxSs09ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPk2a84lJzLcrpuNYclPK3oqfEHPLCDBnibE1VrxwKVZxY+Yjf
	ihuOWjUq2eMk3kcSaluO4H9iHVYOmJP3GjQBGZEVaSx0ws1WKkQij3FgTq3UoYyxoGn7Pmj/cK1
	eLru0lPnq6oUhTD4R14AtpE1VNC9uhKKkD58h
X-Gm-Gg: ASbGncvQ8IJ9No+AGZE/akkQnxVxveq4FHRmqQnzGAPz5lMGvexi2dEeVzzlB+FXMqP
	IR0dY9Wf8w5WRalBneDuJ5o5yBWNSsA==
X-Google-Smtp-Source: AGHT+IFbGMaIeQ5j1E6TiyVsds/nHNyc/6V8bUkhmrKk0Q3Qvn2ku1k2G73HDk4B0vhBEsgx6wDurjMgfQ674aHzuRw=
X-Received: by 2002:a05:600c:5708:b0:434:a0fd:95d9 with SMTP id
 5b1f17b1804b1-434a65b8a29mr106305e9.5.1732574588289; Mon, 25 Nov 2024
 14:43:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2d35e5f7-2edc-4ef0-b71b-82186c0627b0@yandex.ru>
 <Z0Se4BuVfqwjeCWV@x1n> <b0818813-5a4c-4621-9810-dc7443a23dd1@yandex.ru>
 <Z0Ssq15MQd3rimBr@x1n> <da978e8c-2a72-4b7b-ae67-41e6ff0d5089@yandex.ru> <Z0SwOILi4R4g9JBa@x1n>
In-Reply-To: <Z0SwOILi4R4g9JBa@x1n>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Mon, 25 Nov 2024 14:42:31 -0800
Message-ID: <CAJHvVcgLPhAS583Hp_To1McpvZL2U9cXt+=LKRNcikat3JgMAQ@mail.gmail.com>
Subject: Re: userfaultfd: two-step UFFDIO_API always gives -EINVAL
To: Peter Xu <peterx@redhat.com>
Cc: stsp <stsp2@yandex.ru>, Linux kernel <linux-kernel@vger.kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 9:13=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Nov 25, 2024 at 08:07:34PM +0300, stsp wrote:
> > 25.11.2024 19:58, Peter Xu =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > On Mon, Nov 25, 2024 at 07:15:10PM +0300, stsp wrote:
> > > > Man page clearly talks about
> > > > "the userfaultfd object" (one object)
> > > > when mandating the "two-step handshake".
> > > > I spent hours of head-scratching
> > > > before went looking into the sources,
> > > > and even then I was confident the man
> > > > page is right: people should always assume
> > > > documentation is correct, code is buggy.
> > > Hmm yes.  I didn't pay much attention initially, but then after I rea=
d the
> > > latest man-pages/, especially "UFFDIO_API(2const)" I found it looks i=
ndeed
> > > wrong in the doc.
> > >
> > > In this case we can't change the code because we need to keep it work=
ing
> > > like before to not break ABI.  We may still update the doc.
> > I wonder if some non-ABI-breaker
> > is possible, like eg keep the current
> > behavior of "features=3D0", but allow
> > to (optionally) override that by a
> > non-0 request? Yes, I've seen kselftests
> > are trying to double-register after 0,
> > but IIRC they tried to register wrong
> > options, which would fail anyway.
>
> Old kernels will fail with -EINVAL, new will succeed.  It's already an AB=
I
> violation, IMHO.
>
> Not to mention I'm not sure what could happen if uffd feature flags can
> change on the fly.  Your proposal means it can happen when anon missing
> trap is enabled at least.  That's probably unwanted, and unnecessary
> complexity to maintain to the kernel.
>
> Thanks,
>
> --
> Peter Xu

I agree with Peter, we should just update the man page to mention
UFFDIO_API can only be called once, so probing requires a second
userfaultfd. I think not mentioning that was just an oversight from
the last time I updated the man page.

For what it's worth, I still don't like the two-step handshake design,
my preference is still an API like this:

1. userspace asks for the features it wants
2. kernel responds with the (possibly subset of) features it actually suppo=
rts
3. userspace is free to carry on with perhaps limited features, or
exit with error, or ...

But, I think at that point the ship has already sailed. I think to
maintain compatibility with existing programs there isn't much we can
do at this point. Also from the last time we discussed this I think I
am somewhat alone preferring that design. :)

Also I agree that allowing > 1 UFFDIO_API calls is potentially tricky.
Calling it with features =3D 0 isn't just for probing, it also gives you
a fully initialized userfaultfd which could be used out of the box (if
you don't need any additional features).

If nobody else is interested in doing it I can send a patch to fixup
the man page at some point in the near future.

>

