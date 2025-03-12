Return-Path: <linux-kernel+bounces-558591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD58A5E847
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE133AD54E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C9E1F152E;
	Wed, 12 Mar 2025 23:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbE9NeWK"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89531F12F8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741821713; cv=none; b=FSrOHTwbtWYMGnCZh9374K7BY5rrx/EtVlg+w6G+CQpolFHsmF43hb4+f5iArSe5Dud6pgW86TGzayEcZMTnLkjGfw5Dv0oHvp+1wwT0o8XvCBJEw0DjDqnsWFH6FfYnGrgIlcod6vgQjEgC0dRvZnOd8PSv+/YKTtwov5raTJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741821713; c=relaxed/simple;
	bh=KO5+hLhzIN8kvpj0M8Cwc3VnNOjAqYesBx0JGoOsFa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nrRqFMce4uxLmcbK272UnsTLwpquvmpE5qEcWKNOHfLTnkocZwoAWl/Byfz4G/+mRRh4QfWCRzb6HEoAuxqk+Rlkk79SYQkrj5BDVmFbZ3xewDkTFrOjjG/vDn6RKgKAWDLTRYhZu8joXk0UCXw2eEKfbgE2CNN9NJzrWvwpdmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kbE9NeWK; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so2326a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741821710; x=1742426510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+b6fdIPax+pzIkRD3BnHujwRfnqX8wKkJzQB9q9UFM=;
        b=kbE9NeWKT5WsN9wxzUrMeg2ANgKc9VmzVsyXKl/uWLof8AE9txxjc/bJYn6f+EHi/C
         y1XCGM+eYGQfHuM4YXjEqwep7hkkbxpijCR2QyVLrZODPOXrs9z7tM6KdYqGMBEBJX8K
         9O/i35g+bDqzRAgpi59jshEFn2VIu596Fn0oN0O0+XO1O7ruKSjmJ1QtpUeI7x1B4b7E
         YsO0kc1AAQDmvgTFbVVgZm70R6gptpgAZUuO4RhSt5cjNCaOjMAEMHCT7aYbfybo68Zc
         3URz2btxd8bqK8hTh9NrWVxTHvNteI+eU1CNFCSZLSddxU/a5xNcZD23KzyujzGoqonl
         /aMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741821710; x=1742426510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+b6fdIPax+pzIkRD3BnHujwRfnqX8wKkJzQB9q9UFM=;
        b=OWIPWWGSk5H3TEj50PxyLEBG2nVbEs5qsznSLT+QLfGV0s+XEay30P4nooRGFfn5vt
         KjIdiUXsj3HERlAtqHuQRDUuTjnpyKYKVvfOGZPzjMcRrH5z/d8LysoNle/v/KXNfTto
         2jVRua7bIe+ArucFTt9WqVSAvLttLD0BfvubbtpY/D0/3YU65m7HISfjFNTBvQvc6+M9
         PsTmMlAF59bo9b1bsFIHyJfj7WC9H3tdDUJW2otRdxz204QR7maFwJgpnrhmn8lNZAQu
         t/mTQ3VIGslF9aoC3QCiTsfxo91xQ82P5Q2tYOqhSuXVe1HaMcf5aGUdCNDDHyfGd/bM
         d43g==
X-Forwarded-Encrypted: i=1; AJvYcCUwZwpm6HBtb+IghxSfmiezT/8dm8iw4E/5LOLUlK/Ys6uEwyUl+hKLG6yDSfeDpEyj9yaJBmkx4Kaqpcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5cJE0AUk9AK7UWzYVOgISwAVzVeHXHH2nz7P5YdL8QTbtloVK
	CPoQPUV6prlRpICTMVt4okUBYMdJFYLzGYiSw+cfFCAG0X2XCe1qsqsW9OOoSEXzwOIC8ohxU+y
	fooi7CRSh5Ih/ggxw7Z/LtGnvQXLWBLPz+r9h
X-Gm-Gg: ASbGncviSqHoGZsmDPN+ur2IvFUekW2qBqmDEugZiM7JtvpStEd6yZTvCRYS0bgBpLp
	Ktt4SZ6KulYdhaTwQ7TFvjmOL2AiSFQmetWrfUW3sKp36JkWKqTbRcKojd1IKxNDRwOPfETxWcF
	+xjlzqZ+b350b87yRpfIrXWAk=
X-Google-Smtp-Source: AGHT+IH79vozYd4/WLqPX8Goq+GK4FfkzqzmlxJ3W5zNK+xmu62XVxLg5WSlxN4V7nHHFtpmI1I1d+oCy92duCht4Zg=
X-Received: by 2002:aa7:c144:0:b0:5e4:afad:9a83 with SMTP id
 4fb4d7f45d1cf-5e80ca2adc2mr28084a12.2.1741821710118; Wed, 12 Mar 2025
 16:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306131430.7016-1-petr.pavlu@suse.com> <20250306131430.7016-4-petr.pavlu@suse.com>
 <481a3ef9-6d4e-4e29-9d50-a6338604c873@csgroup.eu> <20250307001256.GA2276503@google.com>
 <3ad23825-d249-4108-b5c3-693e359fd12e@suse.com>
In-Reply-To: <3ad23825-d249-4108-b5c3-693e359fd12e@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 12 Mar 2025 16:21:13 -0700
X-Gm-Features: AQ5f1Jrul7dK96zz3eAp-8XZZFpc7URZPt6V3a2TFr60XJn20E8S6oxTA8N0_kU
Message-ID: <CABCJKudevAT5PK09Gu_j_m-oaULumwXab4EkPdv=ZdSu6-PpJQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] module: Make .static_call_sites read-only after init
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Luis Chamberlain <mcgrof@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Petr,

On Wed, Mar 12, 2025 at 5:05=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 3/7/25 01:12, Sami Tolvanen wrote:
> > On Thu, Mar 06, 2025 at 06:28:58PM +0100, Christophe Leroy wrote:
> >> Le 06/03/2025 =C3=A0 14:13, Petr Pavlu a =C3=A9crit :
> >>> Section .static_call_sites holds data structures that need to be sort=
ed and
> >>> processed only at module load time. This initial processing happens i=
n
> >>> static_call_add_module(), which is invoked as a callback to the
> >>> MODULE_STATE_COMING notification from prepare_coming_module().
> >>>
> >>> The section is never modified afterwards. Make it therefore read-only=
 after
> >>> module initialization to avoid any (non-)accidental modifications.
> >>
> >> Maybe this suggestion is stupid, I didn't investigate the feasability =
but:
> >> why don't we group everything that is ro_after_init in a single sectio=
n just
> >> like we do in vmlinux ? That would avoid having to add every new possi=
ble
> >> section in the C code.
> >>
> >> Like we have in asm-generic/vmlinux.lds.h:
> >>
> >> #define RO_AFTER_INIT_DATA                                           \
> >>      . =3D ALIGN(8);                                                  =
 \
> >>      __start_ro_after_init =3D .;                                     =
 \
> >>      *(.data..ro_after_init)                                         \
> >>      JUMP_TABLE_DATA                                                 \
> >>      STATIC_CALL_DATA                                                \
> >>      __end_ro_after_init =3D .;
> >
> > I like this idea. Grouping the sections in the module linker script
> > feels cleaner than having an array of section names in the code. To be
> > fair, I think this code predates v5.10, where scripts/module.lds.S was
> > first added.
>
> I agree in principle. I like that the information about ro_after_init
> sections for vmlinux and modules would be in the same source form, in
> linker scripts. This could eventually allow us to share the definition
> of ro_after_init sections between vmlinux and modules.
>
> The problem is however how to find the location of the __jump_table and
> static_call_sites data. In vmlinux, as a final binary, they are
> annotated with start and end symbols. In modules, as relocatable files,
> the approach is to rely on them being separate sections, see function
> find_module_sections().
>
> I could add start+end symbols for __jump_table and static_call_sites
> data in scripts/module.lds.S and use them by the module loader, but this
> would create an inconsistency in how various data is looked up.

That's a fair point. Perhaps it makes sense to keep these sections
separate for consistency, and look into cleaning this up later if
needed.

> Another problem is that I can't find a way to tell the linker to add thes=
e
> symbols only if the specific data is actually present.

You can use the preprocessor to add the symbols only if the relevant
kernel config is present, similarly to how STATIC_CALL_DATA is defined
in include/asm-generic/vmlinux.lds.h.

In any case, the code looks correct to me. For the series:

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

