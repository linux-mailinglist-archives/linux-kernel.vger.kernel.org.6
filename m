Return-Path: <linux-kernel+bounces-346594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A4E98C66E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BCC285D8B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A7F1CCEE2;
	Tue,  1 Oct 2024 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CYpoLCwr"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC721CCEF7
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727812823; cv=none; b=DiwDZSEsz9oG4WDb28WuYWCKb2E4f+BO6eS9nSxl4KsSUF9YWVit6OLQG+PdrdKhpWYtlFY+MfV4VTU6+4uX/7p/AijS8s5aakTwxd2Yz9LzUQpP82hQZrLhkqmZtBwSMoT65aHcRXVobilYpJGcegm1q3Pyknzi8th15/kVcFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727812823; c=relaxed/simple;
	bh=VL0l4sPNS0mOMjxTEFTSAHFrJ4U5svO0/PuUWHPX07g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bewCy1h/H+C7MJkU621PlYnUEfTEUxBTmVxC9+YSZwC1+sGj61zUujYx3RM2KQ3olum3EtOX36ll/H+D37i7wH4B79cGuefhsuM4c7MT2rSAKslmmW2L2grT4ozDh3AOlq9TcZpINtgvwHZpWgLLx2TAO04lQnyLnyeOIrK1MWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CYpoLCwr; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4582a5b495cso10401cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 13:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727812821; x=1728417621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlQiQmTz7qfWsv7PpI2QITFBokfWCFh4vX/E9hXbiOo=;
        b=CYpoLCwrJfUcQKRV49GkjsVolNgB0K5lXP5Byuau9PDyP/niYmeWifZouNUuvABhKp
         UcFgj8YcBoTilGNF8GE4sEljpTYJ0WRJWaPfrDDvsK88Tnwz4bj5KwUyvq6y9aGOno/U
         FmX5Tp+HvcRErno0QtG03ZDe+g5eZe/cr/ULCtGIeBdS5QUgfA60brMQt7YMp8wttKyu
         X3dDl2JMF9cCmbhS2o/3EqUcmXiHMK76EW6CZ1yAAfry9lR2zG6owUwUa3ks6wdBRVf7
         a3o7SC1laoMZ7SG22Tj6az+vx9PKkjb/0VMOP3NmEwnfC+mLiVqMBGBZk4n6js/WBKa1
         4U1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727812821; x=1728417621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlQiQmTz7qfWsv7PpI2QITFBokfWCFh4vX/E9hXbiOo=;
        b=bE8adC1oU+D2TCOP6puE3zKmmEuy96BS9CjPQGohMNkEyX5iKXclmdGpHA2E6RTGdC
         vLbA/u5FfDJMCvE1bzAGVmdwzkWHwwQqvmfALqFpwY5/TnMqCb9k6zxh/vIWqwIQgYJU
         6F+H8zdGXG7Chkmj8SNPlwpr20R48W9mOJoA2TgV1k62CFdDl6HYEqGvsBouoO7jmMdr
         RmCXoXouj6K5/JS7SRGxhes5qQNiss81qH3fi+UiHSDeyOMlTRCsdpY3ZWLtOdMpnnG2
         ElAWEOtbbnLqpY345MHDOy+B0Cui+qfLfVBIq0q7GNGPBBjdi0a/l3/PmKP5CBk9Nsuq
         GbWA==
X-Forwarded-Encrypted: i=1; AJvYcCXpisRkXuZSEI1rBWN9SkYSQUnRrRBzM4oi4kQ4ZlXbOE9EfytHrBktdZEb90BcRev1CDc42eurlCclijI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFMpsuR48uT2n5f/gCQTwhRebExTwQAKdK5PXpt8MUDJX6z0+s
	3yZRs3P/VU/cPDbC17V+5kwJGX5+o3zvLZpzOCWVKlIdw+EPhngoTOgW7dLiuggVkyM9x6XlLWD
	SKZeky15zUBRD91VJlupJ1+OVBvF4Tem8yJKi
X-Google-Smtp-Source: AGHT+IG5DNxtgJ83kOVslFoZp1Jab7wENr6j0mMJJ/eOFoYyywnCYznykoqwwy5SBfvCNFKR9FwGagz5mBemuN73jts=
X-Received: by 2002:a05:622a:4e96:b0:444:ccc5:f4c0 with SMTP id
 d75a77b69052e-45d82060a56mr551191cf.15.1727812820872; Tue, 01 Oct 2024
 13:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923181846.549877-22-samitolvanen@google.com>
 <20240923181846.549877-25-samitolvanen@google.com> <03d36fac-a808-4794-a442-11fa6fa18ad8@suse.com>
In-Reply-To: <03d36fac-a808-4794-a442-11fa6fa18ad8@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 1 Oct 2024 19:59:41 +0000
Message-ID: <CABCJKuf-_B1bH3YbiUS6r1-k5VLMHmYYWuCMpoV3jP-G5uHtTQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/20] tools: Add gendwarfksyms
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Neal Gompa <neal@gompa.dev>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Petr,

On Tue, Oct 1, 2024 at 2:04=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wro=
te:
>
> On 9/23/24 20:18, Sami Tolvanen wrote:
> > +             if (dwfl_getmodules(dwfl, &process_module, NULL, 0)) {
> > +                     error("dwfl_getmodules failed for '%s'", argv[n])=
;
> > +                     return -1;
> > +             }
>
> Nit: The four error() calls don't need to be followed by 'return -1;'
> since the function now calls exit(1).

Good catch, I forgot to clean these up. I'll fix these.

> > +     for_each(name, get_symbol, &sym);
> > +     return sym;
> > +}
>
> Nit: The code inconsistently checks for a potential error from the
> function for_each(). Looking at the whole series, the value is checked
> using checkp() in functions symbol_set_crc(), symbol_set_ptr(),
> symbol_set_die(), is_exported(), but not in symbol_get() and
> elf_set_symbol_addr(). It would be good to unify this, or perhaps even
> make for_each() return an unsigned int to indicate it never fails?

True, there's no need to use check() anymore here. I'll change the
return value to unsigned int and clean up the error handling.

Sami

