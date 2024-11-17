Return-Path: <linux-kernel+bounces-412240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C209D05AF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 21:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1BE2822B9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 20:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A553F1DC197;
	Sun, 17 Nov 2024 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K69H4zL+"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36BA3BBEA
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 20:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731874367; cv=none; b=pQeKmUacDaYkEQtdHLor9YpM7Xk2bAEoY1r17yeEcd4GGZDSQ+Yfgq8ipNY73BZzCIp3RWJ1XkJAHXySFdTbkK8OOgG2FmUKcPhPVJuHCFIApiIoABloZDAeFYw0cbwdrZ77YISKDxuecBb0NhRk71/iT8yLXlpFgfjKbQR5dTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731874367; c=relaxed/simple;
	bh=lM4U6ZLxdN3VnshIyoKyM2sOLvlQlZEzMP31+1XpynE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9j2w7BLix8mck6AtzYCIWn+2HodnWJp/5AbKuwfl4R/ma9qPCmwRvm9ahE3Cyaywxw3jvl3vUerA+MciPqZmDipD9391XYaI6X/usJj0IupwDCMDpibgQ06vn1EpApueQiUYexHt6d/EEMmoO+RQZPEg7/Y/rKmg5boEOufpWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K69H4zL+; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cf9ef18ae9so3289271a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731874364; x=1732479164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iVwnG+ZIZFKobx5Kvb+VdCEhnAlm8t8yGOsPLjE743Q=;
        b=K69H4zL+BNB9XPB1Itepjwc/0m1tkCZq+0y1ukDfe/CIjvEUYGQcbFeDFza3y52o6R
         eue+m1YOiEzCo/uNVgA+hucwNZVXtbPiZKOMGMT2Ly8nJgb+MgUc8SyV7CkeflmcQRUg
         qGVYM8uzqTuQ9C3sCuqM4beUTXPSyBoX1DjNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731874364; x=1732479164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVwnG+ZIZFKobx5Kvb+VdCEhnAlm8t8yGOsPLjE743Q=;
        b=luMeVHtbySNRvBnBk0e6bG5HRW5mRxHrKyhxsg6CU841Mp45m+T2UqfHYZ3Nj67GET
         2oFqhj26MZcG8fT/RaOOrP4xCsRCq8ZS5cJXyeShsDUn2zlnZdYYQSkBEhHPJrT6fvqg
         6MLJSX/dK753jzAga04QeOGoa5hGrzvaYwiPq8x3Vc8W5ByqVX9Al/asitnMczL41lsW
         OKHerCeUcjS3t0jIEw1QcGA4kLNx/JyzvMYsEnsOC33P+LVFqHmgomEHVcOYmCh1jfDx
         tWGfttDoLEgkiq3iCfckKxGb6rsC+i3hoy6/G4Itdkm/F8eoYK141gXjNzhXe8NmPW3P
         /uZA==
X-Forwarded-Encrypted: i=1; AJvYcCUv4tZyx56k0xt1H+dUB9+g6fCBw4IZsHqaPoM7E55KvtSLKjNqltrlQfdRnGnbwAQAKT+9Ka2NTaN6kw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7eR8BGZQSre+yGqHdnSk5m02JlxrC+QSMp+/zV/de4uoYIhSS
	ohTPoiexowGsJ3WgDC0Y8Rz+6WC2q5MexPqvRgYWCEmyM4FtfX1XpnUqaaaQqNUQi0jZbLKEXLF
	r5PTmxQ==
X-Google-Smtp-Source: AGHT+IGu9A1NAw7UQ3U+8GtP0dHgFXdtEj8Hc5PyJUOlsjEveOFe+xnA8EV2+oCVYM4mZLIEMAcR1w==
X-Received: by 2002:a17:907:e92:b0:a99:ee26:f416 with SMTP id a640c23a62f3a-aa2076eb6b3mr1400464266b.14.1731874363868;
        Sun, 17 Nov 2024 12:12:43 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e00172dsm458180866b.120.2024.11.17.12.12.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2024 12:12:42 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa20944ce8cso640984066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:12:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW+ZDdPGr+Epf706/lQ1ae77AJQVB1H4r5X2yk3smvcoK+V/SL5NleOLlzx12CYYzQgPzqd65H4xuEHZdI=@vger.kernel.org
X-Received: by 2002:a17:906:9c84:b0:a9a:eeb:b26a with SMTP id
 a640c23a62f3a-aa48185c8afmr827341266b.1.1731874362328; Sun, 17 Nov 2024
 12:12:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-5-mailhol.vincent@wanadoo.fr> <8bf6922f4bb143d1bc699aadd1c84607@AcuMS.aculab.com>
 <CAHk-=wiq=GUNWJwWh1CRAYchW73UmOaSkaCovLatfDKeveZctA@mail.gmail.com>
 <c2eabf2786c2498eae5772e5af3c456f@AcuMS.aculab.com> <CAHk-=whaUtqsgLGk3a+1+SJ2+KGK+GK-WbSK0dX2JpVN3bs0hQ@mail.gmail.com>
 <fab10eb9e70041c0a034f4945a978e00@AcuMS.aculab.com>
In-Reply-To: <fab10eb9e70041c0a034f4945a978e00@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 17 Nov 2024 12:12:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgfpLdt7SFFGcByTfHdkvv7AEa3MDu_s_W1kfOxQs49pw@mail.gmail.com>
Message-ID: <CAHk-=wgfpLdt7SFFGcByTfHdkvv7AEa3MDu_s_W1kfOxQs49pw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] compiler.h: add const_true()
To: David Laight <David.Laight@aculab.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Nov 2024 at 11:23, David Laight <David.Laight@aculab.com> wrote:
>
> Since 99% will be 1,0 maybe saving the extra expansion is best anyway.
> So have is_const_zero(x) and add if_const_zero(x, if_z, if_nz) later.

Ok. So something like this seems to give us the relevant cases:

  #define __is_const_zero(x) \
        _Generic(0?(void *)(long)(x):(char *)0, char *:1, void *:0)

  #define is_const_zero(x) __is_const_zero(!!(x))
  #define is_const_true(x) __is_const_zero(!(x))
  #define is_const(x) __is_const_zero(0*!(x))

and should work with all scalar expressions that I can think of (ok,
technically 'void' is a scalar type and it obviously won't work with
that). And should work in all contexts.

It does want a comment (in addition to the comment about how NULL is
special for the ternary op that makes it work): the '(long)' cast is
so that there are no warnings for casting to 'void *' when it's *not*
a constant zero expression, and the '!' pattern is to turn pointers
and huge constants into 'int' without loss of information and without
warnings.

Compound types obviously will generate a warning. As they should.

The above looks reasonable to me, but I didn't actually test any of it
in the actual kernel build.

             Linus

