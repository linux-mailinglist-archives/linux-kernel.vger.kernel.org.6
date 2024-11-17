Return-Path: <linux-kernel+bounces-412220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 102319D055F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 20:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67001F219CD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 19:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E281DA633;
	Sun, 17 Nov 2024 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dETFA4c/"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2D81DA619
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 19:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731870613; cv=none; b=cnxHI9u9BkOiPlggoNAxgE69nZVDo/d4Rtlz504Z/xvuxfUZ86HWBQUc/9Pn7szKuHJp6/fI2ajgRQuj0vGk0PhNBsQc7S6WdRpziwVxK73lI1S+DDgVBaAkS6fZOT4HjZgzQDWCjWXjOtNmPEDc4mBUuRC8iu6Npf7isEzK1XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731870613; c=relaxed/simple;
	bh=rKZSQWVvGhg4raZdqqnEYVcbbk/2GmORPysBvFpPh/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9uiKzIVii0feR1UFM1BkrjergEDNyVZTnVz+BtFuZBvpCT/eFFwLHpPj5qab3CLUONEHcrv95/YfNa9AwRX4JdnBgCcyVZBbo4yEjpoYYyEeEGIvskZLf6h8nKbEQBk97xl0I15mQjcP653UX13apsMLFj1OJaU8laRa+vkSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dETFA4c/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cefa22e9d5so4222683a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 11:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731870610; x=1732475410; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yTq39KpSi/XOcjYMPkfmcPZj5cLER0PBeGZUoAkDQbU=;
        b=dETFA4c/WPTKwX1LZdimub3lXlc3tuCxGLSjphYevUdjEKq4+K+wB5LuVOyjp1sEd7
         XX81zJVamra2BdIYW7IDNpmpGVwcjiznYNc0yGKOH2BuG+cpkW4QcAaaQDiIcbcs9k+q
         vC6AiqHbDz/Gt3sE/u2Zv63viRBV24qk2MzeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731870610; x=1732475410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTq39KpSi/XOcjYMPkfmcPZj5cLER0PBeGZUoAkDQbU=;
        b=UKpM/QysE+1CYnBcU2hQ8sgkeonyEmyDMqAyJnX2vj/pycrEmFrmSq9epFO2LkAEad
         JOLKx62gdMbwI3wJNB6m+r+3rqmqA5kVzWrs0zI9AVahHoXsFuWuF9CS981s7jcVN6VA
         Kl6NLzFMppxz+FuT4ljgsoN1Eb8f33NqysM45YPw6zxSCYAClG7JWKpX1xFlyFI7x1bU
         a4rRtVGPmNrlKyaJXmsayawRipb7peXO+GoG5cVStwFv1HMKO572iVZOv9IcAalMmWOl
         wBcPphPi9CWE+UwOXjboq4UQx+50TdtstsJGaiduEm6amPhQHU3RYWd2E5dSiYJBOJDm
         Knlw==
X-Forwarded-Encrypted: i=1; AJvYcCXYkvpW16dvmOYac7M58h51fW2uW+0OxXe0qNcVR94vQT/6YsNOr5fjzVIvq3eSqdbRGAhPPeUXNeXxDS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhaqM8zxb40QxGdLNO6cl3zF1P5MSG3kwN8KeItEOi59Bf7IRN
	neqcutxa9Wlmg8v2Q0TypV1UtaUr03F38JrGWJTxrMd+/lp+G3dyBbhsKFaAlGDaEiX5iIg23td
	83EUI7A==
X-Google-Smtp-Source: AGHT+IHzwqibvHnGgG+9DoQwSIcUTTWy7d0ZLE563yGcN/xngVJi3D1iEdlQSWy0ADXdw4C+0BG2FQ==
X-Received: by 2002:a05:6402:210a:b0:5ce:fc3c:3c3 with SMTP id 4fb4d7f45d1cf-5cf8fd03d94mr8964885a12.28.1731870610062;
        Sun, 17 Nov 2024 11:10:10 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79c0ac7fsm3838351a12.55.2024.11.17.11.10.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2024 11:10:09 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cfa1ec3b94so1916873a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 11:10:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVOODGcCVuslmovg85EKBXIllJ9wsokSsqbieSlK6JZH3vHAYIFsA0hSnxi4rjP07S/J1uB0mu9eZZfv9E=@vger.kernel.org
X-Received: by 2002:a17:907:a4e:b0:a99:c9a4:a4d5 with SMTP id
 a640c23a62f3a-aa483482762mr901553266b.29.1731870607652; Sun, 17 Nov 2024
 11:10:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-5-mailhol.vincent@wanadoo.fr> <8bf6922f4bb143d1bc699aadd1c84607@AcuMS.aculab.com>
 <CAHk-=wiq=GUNWJwWh1CRAYchW73UmOaSkaCovLatfDKeveZctA@mail.gmail.com> <c2eabf2786c2498eae5772e5af3c456f@AcuMS.aculab.com>
In-Reply-To: <c2eabf2786c2498eae5772e5af3c456f@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 17 Nov 2024 11:09:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=whaUtqsgLGk3a+1+SJ2+KGK+GK-WbSK0dX2JpVN3bs0hQ@mail.gmail.com>
Message-ID: <CAHk-=whaUtqsgLGk3a+1+SJ2+KGK+GK-WbSK0dX2JpVN3bs0hQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] compiler.h: add const_true()
To: David Laight <David.Laight@aculab.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Nov 2024 at 11:05, David Laight <David.Laight@aculab.com> wrote:
>
> I think everything can be built on a base if_const_zero(x, if_z, if_nz)
> #define const_true(x) if_const_zero(!(x), 1, 0)
> #define is_constexpr(x) if_const_zero((x) * 0), 1, 0)
> which gives a bit more flexibility.

The is_constexpr() should probably be if_const_zero(0*!(x)),1,0) to be
ok with pointers and with "long long" constants.

And the "1,0" arguments should have a real reason for existing. I'm
not entirely convinced any other cases make much sense.

           Linus

