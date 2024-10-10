Return-Path: <linux-kernel+bounces-359499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B07F998C65
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E131C2110E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E576A1CDA2D;
	Thu, 10 Oct 2024 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gLfg+uGL"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C905D1CB311
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575599; cv=none; b=i338/nXRYl7AXpfIHbTsGWM7WOBnQ0cmZ81zWcZh+oJ+Sxyzt6D8r1GNTXMaRAC/7z4MqVhtTX2ix6diFHYq0VU4NGqKfeoz7RqF6IY36rdK6mqH8cPki3Syd8Ser2d5Tuwx5t5zGFz7QOUBBGsMK67ZW9CW7X6nnYTBZHHCaog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575599; c=relaxed/simple;
	bh=OEKgT5FaXcrpIO0R1OJJHf0yvgx7y1d7mR06I8IroIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cp0YUvcjcdDq7QkQIkwWeTKC+n3XwE+9krRNdhyWnN/xwdfFA/TxC5iLriga41y2A7x8TeuvWeGayTJ1/fJOPjXX1SJ78qRfSoeQleRm2QLwD36MAnAFRnuhBenlAR3sSDq2ODZX1lzkvFQUfuCLN4P2+kl7zfYd/qvcPyEwlVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gLfg+uGL; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-45fb0ebb1d0so257231cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728575597; x=1729180397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRF7QTAhluph4t1u2jY3lQtQT6pq0IqnJy/G2sC0qKY=;
        b=gLfg+uGL9nnJXg3JX0x9h1w/z1xRq5/GKSna+PmYzrHn7KIHLxUgvUALoqM9YJ5NgF
         SDDt09uxrVVKZ6pBH8mLnC7SwqqaM0D1CinL785Ip6NAmoh2zocSvhuv6909SrLfBDvA
         laxdhU9ZKUdahT66MQIQPBhLvvV9heCvHg+zZ+jx+65FbE6kjAIKik1cWKFEWKsCqvcd
         F0hEp/spjigQSK9wMJ+SW6s5UH0EE5Zb0Haa4DQXCdvSvYE2uwro9Hwd2dkfudo7BR1Q
         HVpxPysO+/nkdQfmTwwarGpL/uTBVtenAab5dadGeU++cYr/dkk41dbbPw+3animKJGs
         87DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728575597; x=1729180397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRF7QTAhluph4t1u2jY3lQtQT6pq0IqnJy/G2sC0qKY=;
        b=qU3A3fGSuDXvks4CmCYONZb2MY84pjwL4KBh2jSzpS688WR39NpT/Y+40vg+1IMT9C
         YXRvfdS6rUu/K4NM5gDvh3QYJ4dsGKb2ICOmMLOUv7AnB10v2MDhIZkPV+UI3sUhofmZ
         rFsrqw1LCt7a+668N7OKztiTc/FKiW/QU7Y7fZKUERi5wF6rM+BWo8SEQreqF9v6h1+/
         Khzb8mkDTvkdSwdL573JNBNQAEzHONhsXr1PSZaWPs8KRQs0sGc5Uh/e9IK7rAnZpME1
         rmtkr34QhSUJJO3DvHoWr50j8Oqx+M1lloQ+JOW5chDyBQ2/WAxPW9P+t912kD44u/39
         dgSw==
X-Forwarded-Encrypted: i=1; AJvYcCVjfKarbIF7kf5tRz1gqlS6fOwLS5hr/CHgDNZy+iobHQ9E8qNi06qrx0ROOxoPXzMyQTGM4CLUmgjNJ4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsk669aszb3ktnDRAv8b+KVhKloUxK7f0PyIfjdioXIxx7Xepj
	NxQ6c4GaZYucP2KGFtMW/ebMc4uQmIDueIUM400VB/LT3dCxhSN3iO6w28uz99Sv83hCH7P0dT0
	5EmULsZ9A5ksj1UsSap9gMVvAClUIYJwLN/+M
X-Google-Smtp-Source: AGHT+IFQAlD/kyDgC4ga4+ipIjureI+CBWbmGopaPOHkfvMa2Tw2xU4vZqdtGy3/S6U22tdGXqVetrx15+hx10NVr30=
X-Received: by 2002:a05:622a:450d:b0:45f:9b3:c7d4 with SMTP id
 d75a77b69052e-46040329dc4mr4203261cf.6.1728575596483; Thu, 10 Oct 2024
 08:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <42aa307d7ffae1851b4a8787f5c276dd0b3beece.1728543368.git.linux@leemhuis.info>
 <b32f1e42-d775-4538-ba36-9e9b906a34e3@leemhuis.info> <CA+icZUUgwJWY=PWO5fQPZbUc-q=LkdHXVe4+g-LnXmQfCA3N7Q@mail.gmail.com>
 <CA+icZUX9hrwFXA-6KVT+yZ=-NqyPB=LOKKWSf77-xb32totgHA@mail.gmail.com> <a5b3c47e-5f0f-4c0f-8ad9-4fb34d150548@leemhuis.info>
In-Reply-To: <a5b3c47e-5f0f-4c0f-8ad9-4fb34d150548@leemhuis.info>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 10 Oct 2024 08:52:37 -0700
Message-ID: <CABCJKudayCsPuowkUW7_JV_2HPNp5tf_py6jjDe6Ld7oMai9jg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] module: sign with sha512 by default to avoid build errors
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: sedat.dilek@gmail.com, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>, 
	linux-modules@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 10, 2024 at 1:57=E2=80=AFAM Thorsten Leemhuis <linux@leemhuis.i=
nfo> wrote:
>
> On 10.10.24 10:42, Sedat Dilek wrote:
> > On Thu, Oct 10, 2024 at 10:29=E2=80=AFAM Sedat Dilek <sedat.dilek@gmail=
.com> wrote:
> >> On Thu, Oct 10, 2024 at 10:19=E2=80=AFAM Thorsten Leemhuis <linux@leem=
huis.info> wrote:
> >>> On 10.10.24 09:00, Thorsten Leemhuis wrote:
> >>
> >> That was wrong in the original code which you moved:
> >>
> >> +config MODULE_SIG_SHA384
> >> +       bool "SHA-384"
> >> +       select CRYPTO_SHA512 <--- SHA*384*
> >
> > Thorsten, please fix it!
>
> That looks intentional to me -- and CRYPTO_SHA384 from a quick look does
> not even exist.

It is intentional. SHA-384 is just truncated SHA-512 with different
initial hash values. The same with SHA-224/256.

> But that's not at all my area of expertise, so I would not want to touch
> it anyway.
>
> Ciao, Thorsten
>
> P.S.: Vegard Nossum mentioned in the fediverse that I could also solve
> the problem the patch is about by adding "default MODULE_SIG_SHA512" to
> the "choice" section; haven't tried that, but that sounds like a better
> solution. Will likely give it a try, unless someone brings up unwanted
> side effects this might cause.

Yes, that would be a much better way to change the default. Overall,
moving away from SHA-1 seems like a good idea and SHA-512 feels like a
reasonable choice. Luis, do you see any issues with changing the
default here?

Sami

