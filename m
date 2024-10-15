Return-Path: <linux-kernel+bounces-366009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EBC99EFA4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C50D0B2293D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DA41C07D1;
	Tue, 15 Oct 2024 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gfeqcZ2C"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80AA14A4E0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729002788; cv=none; b=dxskelj0bKwXoPgdObvr2XhXd8FrvQwbrWsJBXhS4GBTiAKrLhaR9MLlugG+6iv4sY8alRXdhzJEt4FvswnWaoWiXdLV6nlJKTIKBxQuMIXm+98evMF524XKq2sOYRnbMfDY0XxB4JTboh/5td6/cSGQ0IeeufFv0Sg/r+rywsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729002788; c=relaxed/simple;
	bh=cispWMbOcCPkOtixYU/J3EAO8QBZS+85mmwIXWPTglI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4cL5jgKOJ7QArvfKfgEsU70ipXyNSLSwBAsTe4quL/VC2cbMdVlocYQb0RTRcXgXmM7f5dqo7LOzJjELQ5I8f/1BuGBj4wVkIC4YslCVow0a4jYBaqOdnUlWXHIdHyGOXB0Z3PubrLRISdP3ZL//RxxoL4xNiqcccADmWgPEIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gfeqcZ2C; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e2915f00c12so4194712276.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729002786; x=1729607586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYbi5gZJ4OrZjgdOZozfnDl/MQxnlNPVWNQhf6fR4f0=;
        b=gfeqcZ2CWvVbAasFznspjOcugD28srEpnDEuLEYIcm8bREJtkzERKBlbivN6L+E/PE
         6ZqR0uNdEJG7qaYupwOWSGpZO2coweQ7CwYdX0aNSETBnmNo1JWDz1Bx+7hB02pms/yq
         Wb5DBAUV6yFmGgBjWAqlS7widg42xq7ylrDOS954MSU7oxPqLT4h9emAg9K7tcaOHkYL
         x1LdhH09+SAM/7cCG2zAet00frpQhWOcE+NG+FoUgR4cbLRQn2yhsORTNJOofPKv/+Lq
         GtO/pCXmVVxfQ/K2K63zS5NT9GBbn19prflIKaryXKyQXunGI5H0932OKJh/WPKVHYF0
         GBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729002786; x=1729607586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYbi5gZJ4OrZjgdOZozfnDl/MQxnlNPVWNQhf6fR4f0=;
        b=xLWYfMZih9js+Hq4pRG+nvGe5H0WcP6+FQOBOL4PGfMSsogDr6A5+Sgm3oDp8G5kUE
         4IkBXk/3imAvBpIXL2fyII2nlCaWHM93RzbYCnPIGSLDteHhLcgac94ZgqsUTyRovXeT
         7pXMe8Oy2TcqR9RcHh4S4qGcDA/WoXdJeV6j/9PSZOMyAvvXe6sPqv1Pd6CcLBaESlzK
         nfSqY7pTV+al8AZVIatO9q/jKfWzz5Sotd3TJdZDlUKGmfcVIdCU6FwStc12TalYNGJg
         Llj6aYRy0DfTtP1uisfhUPb+h39+5ae2ZGhkYBO0dsL+2K1xrRLVahP7vNZ17+LodzIC
         4esg==
X-Forwarded-Encrypted: i=1; AJvYcCXJbc2bfqUGWX3iYQxJN9ILyQU+Vlb3gQyzvkP4AU78INZB5yRCPfVRodkqG/11eQVANV3lJjpBFOmwCfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLsk+UqxIDgrnvCrRgql5jJSnRSKjVNznqb/MhqE4isSyfEqiO
	2sPyINn9wbVDRUFr1GUrvfqWZxVftBEcEttc0dhAhkRUME73RuAtoeOYGMmMZ4khybnCpaeTPh/
	pmjVVqZmpyft7kevCMV0tN6D15LqbsZfA4yVP
X-Google-Smtp-Source: AGHT+IFZs56aAHhGD7Dtb0kDtkQdr1ZZUSIQiPFpxpiO5HWv5d7OB4424EZKwAZ4IMnzuRzHa4IKV/3BReaO30E2D7I=
X-Received: by 2002:a05:6902:114d:b0:e29:3923:9934 with SMTP id
 3f1490d57ef6-e297830bb05mr532299276.26.1729002785701; Tue, 15 Oct 2024
 07:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015140159.8082-1-tttturtleruss@hust.edu.cn> <CAD-N9QWdqPaZSh=Xi_CWcKyNmxCS0WOteAtRvwHLZf16fab3eQ@mail.gmail.com>
In-Reply-To: <CAD-N9QWdqPaZSh=Xi_CWcKyNmxCS0WOteAtRvwHLZf16fab3eQ@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Tue, 15 Oct 2024 16:32:27 +0200
Message-ID: <CANpmjNOg=+Y-E0ozJbOoxOzOcayYnZkC0JGtuz4AOQQNmjSUuQ@mail.gmail.com>
Subject: Re: [PATCH] docs/dev-tools: fix a typo
To: Dongliang Mu <mudongliangabcd@gmail.com>
Cc: Haoyang Liu <tttturtleruss@hust.edu.cn>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	hust-os-kernel-patches@googlegroups.com, kasan-dev@googlegroups.com, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Oct 2024 at 16:11, Dongliang Mu <mudongliangabcd@gmail.com> wrot=
e:
>
> On Tue, Oct 15, 2024 at 10:09=E2=80=AFPM Haoyang Liu <tttturtleruss@hust.=
edu.cn> wrote:
> >
> > fix a typo in dev-tools/kmsan.rst
> >
> > Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
> > ---
> >  Documentation/dev-tools/kmsan.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/dev-tools/kmsan.rst b/Documentation/dev-tool=
s/kmsan.rst
> > index 6a48d96c5c85..0dc668b183f6 100644
> > --- a/Documentation/dev-tools/kmsan.rst
> > +++ b/Documentation/dev-tools/kmsan.rst
> > @@ -133,7 +133,7 @@ KMSAN shadow memory
> >  -------------------
> >
> >  KMSAN associates a metadata byte (also called shadow byte) with every =
byte of
> > -kernel memory. A bit in the shadow byte is set iff the corresponding b=
it of the
> > +kernel memory. A bit in the shadow byte is set if the corresponding bi=
t of the
>
> This is not a typo. iff is if and only if

+1

https://en.wikipedia.org/wiki/If_and_only_if

Nack.

