Return-Path: <linux-kernel+bounces-305849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53823963535
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B231F25A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9459F1AD3F0;
	Wed, 28 Aug 2024 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H4Mzj55Y"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621421AD3FB
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724886566; cv=none; b=EVF4PZ4LzaQhKubMmEubyjbcrc/T9EMJYKUjj7QV0KQcggMUZquejTK2v6nRNFk7IPTHi9xHuNqTL1uR7y8nfzYbX1wu5437NSMJ+47n0HNXQV9Cp2Yic1ERIMUCqajzfemuuFxAh4cDlFjUH3Q01F4MMPU2eMTJZfQx0xEItyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724886566; c=relaxed/simple;
	bh=RZmcXzwnrRhYwDoAQj1Jxhe7OhhEeGVabMOYn+OKJEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNruQ1fm/2BmbqiLSK6RfjT1NRXeukfNtnlPLeYu38AuzR1xpzn9CHvVQo3bElUcwmCpZnAQiTuoPHirGLplmi5k+d4JOo2ElPYGtSNZm9QR/u97u3V8Rh4d6HCP4DH/v9rH2YcXZe3yf6Ngy5uVdv2ffMFdNLbDDMkXtJD61go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H4Mzj55Y; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20353e5de9cso72065ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724886565; x=1725491365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bF9tb8hwDYR6xa7gB1x7sZNbhUYJUgSYOVOAb5zjrCw=;
        b=H4Mzj55Y4gMWJjD1yLPZX94RAzWQmOtv7QN7sKScGjy84ZXuLZl7MRRSW+5n14ADLp
         1mv1DSXKXTcK9T4lsvGpZsPosjeUN3M+jNiiBszsGLZTfRzDKl/VC8U0hvjOuRLwfQBP
         Hm1h5BOIZfPcb7Mrk0/8ENbwdZEijPzrw/qWtU9d8Q8P8np7DcjyDIzVMn+eCsVS9rqY
         XgrsEuQX3KS7KTat6SaZ1TNqgHSjKoMKtpXROs9+3lDy47NoTCfcQzh7c6oUYckFX8Ah
         l5fYnYM+0oqAS41V5b59z6BSEwP7RvB186VBIGi5eNx23qGQO5LcFTdj4w+3vvCA4Vih
         kNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724886565; x=1725491365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF9tb8hwDYR6xa7gB1x7sZNbhUYJUgSYOVOAb5zjrCw=;
        b=SmM4NRi4VuTXww74usqBrqqst9fyyyzjqaY7TV5T1iPcuVsepy85SpESumKQpOdJa4
         ukP5OIHYhhCyih7Wl9U6hTsQ37P+catrepFMPx7sQ/o6viaIHMtzwJxB4d9F1O26Qiap
         tC+8PRsSMmzeeSNmkpzlojQ1yUyQcZfVRrl7CB2CUFXlN+KIZqpJYrRNiyF0/bgdKUFr
         B27QHq+1qRWQmPU9W1Qf7q/e3jc40quhLgRbSpwb1s/+UqlcwAwRW4ee68Ar336/VXba
         QWOtjkaICjFdgkZujK+Rn5vdSQCpd+U0D2s+27CNwMtET8jSUCET2B3Qov1+gu7HNCYK
         FH8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnDNkiI6i0jtCItvjLxttGsQeT0IV0j1VTiUSqEXa4LeGqsTzHqj3TBKyt32/vWNwyEnRc293NXygvkK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyOMauIp9kHg1jb5SEcaM3H0DLM45EMbtfuUGPGFPc/q5gk/OC
	DscyyTxvsBaduUBip2h8+04s+EVF0FN6tAbHbKTsRGS4ksjP03/GM0PQwVQIGw==
X-Google-Smtp-Source: AGHT+IGefsWlldxzVDyfJdh6ODHqSR4DIkOY4bryKmhorJbglzA63HVpwHsAO+Qawqv6PlgLxud4xg==
X-Received: by 2002:a17:902:ce8a:b0:200:7d11:e8e3 with SMTP id d9443c01a7336-2050d1f0c57mr1140385ad.14.1724886564314;
        Wed, 28 Aug 2024 16:09:24 -0700 (PDT)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a5b56sm5350b3a.57.2024.08.28.16.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 16:09:23 -0700 (PDT)
Date: Wed, 28 Aug 2024 23:09:19 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthew Maurer <mmaurer@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>, Neal Gompa <neal@gompa.dev>,
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 02/19] gendwarfksyms: Add symbol list handling
Message-ID: <20240828230919.GI2130480@google.com>
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-23-samitolvanen@google.com>
 <95db3178-a2ce-421e-8024-afd7fa3359a3@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95db3178-a2ce-421e-8024-afd7fa3359a3@suse.com>

On Wed, Aug 28, 2024 at 02:35:29PM +0200, Petr Pavlu wrote:
> On 8/15/24 19:39, Sami Tolvanen wrote:
> > diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
> > index 65a29d0bd8f4..71cfab0553da 100644
> > --- a/scripts/gendwarfksyms/dwarf.c
> > +++ b/scripts/gendwarfksyms/dwarf.c
> > @@ -5,6 +5,48 @@
> > [...]
> > +
> > +static bool is_export_symbol(struct state *state, Dwarf_Die *die)
> > +{
> > +	Dwarf_Die *source = die;
> > +	Dwarf_Die origin;
> > +
> > +	state->sym = NULL;
> > +
> > +	/* If the DIE has an abstract origin, use it for type information. */
> > +	if (get_ref_die_attr(die, DW_AT_abstract_origin, &origin))
> > +		source = &origin;
> > +
> > +	state->sym = symbol_get(get_name(die));
> > +
> > +	/* Look up using the origin name if there are no matches. */
> > +	if (!state->sym && source != die)
> > +		state->sym = symbol_get(get_name(source));
> > +
> > +	state->die = *source;
> > +	return !!state->sym;
> > +}
> 
> Sorry, I don't want to comment much on function names.. but I realized
> the name of is_export_symbol() isn't really great. The "is_" prefix
> strongly indicates that it is only a query function, yet it changes the
> state. It makes its caller process_exported_symbols() hard to understand
> on the first read.

I see your point. How would you make this more obvious? get_ doesn't
seem entirely accurate either. match_ perhaps?

Sami

