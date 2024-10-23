Return-Path: <linux-kernel+bounces-378619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5D99AD341
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1BD1C2203C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808511CFEC8;
	Wed, 23 Oct 2024 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2XGSpU4C"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFDC1C9EAF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705715; cv=none; b=alWxXUdzEQWLmOTS2WzcibksX6GjVKVOvgDEHFy1XEkUXPDK3cvB5PlKf7vX6k/9UarnLZRRI2CgqQx4KlXbiOjFJuWWDaVgGKKocG7ASMW+hs06ZIDQTTmc1ALA8Cyx2qvlAiMag5RRIq2+ZoLzBK/PyPMZeMSCLBbylQII7Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705715; c=relaxed/simple;
	bh=FkIbVmjmGIcTzhG0qGekVnBH4zwusmD5xdfI1M4eVoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrPLF1pzgcMUnM4GxhJx4iGzXdSg+6UW9LkyeD5sF7hlN+ijeUTMMejFVGAKzDrGS5YpojUgUocOtkIV1BF0S1bwguvjDjqEOdwwgAyBo8gcNCkrlTckV/l+KjPF4XBZorY5QlFK3hMzF9//WVYwSCZMbDu+uGJueO+flqHECkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2XGSpU4C; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315a8cff85so322265e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729705713; x=1730310513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmdWUQBcQAY3nAqTIo9l9U7SbGU//y7aKjDJylKE1oo=;
        b=2XGSpU4CIB0k+zi2bWwvhnsgTPcxUmCyr7M+OPspHlIFf2IOLRiwPLdZdHSxzdT5Z+
         RYkmbWfWMZovJFU6BVmmNYF7SXLq+vr+C2zW3BuqMDedVDMqIPx5wsPtxVDF6NLwAJbg
         k/Dc0dlaJrfN0WMCJJhjgEIr8uiCCxoolXzmB6qFhVFKcInEpFA8fz1xOtV9xR6ZOhAj
         PN1HFMXlvH22tek2gnZtyrdA6C25vhPAHOkbYY7n6CdgAxflL6F+KzzQn+NtmjIAzxWR
         JALAbOfPzlDlU1NrJFayD31ZyDtBPOvGXRrSJwYinpGFJ4t1t443Zu3X1Pu3fFwhNn7F
         6oHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729705713; x=1730310513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmdWUQBcQAY3nAqTIo9l9U7SbGU//y7aKjDJylKE1oo=;
        b=ORH6MrUsAgyySf41bl1lr+dJwbdtbCmdMo9APpzwRSVOW3E62a3ZCJCxiMe9iXsuEL
         5K7N/5Mr66i1jFi0VeD/8IlOlA1S1kxvasrJni9EFo+BwU2Q0JeElcSQJNhOyto36TWl
         C1SVZIDFeqqOtr88M8LgInuQa/kyJTquWEtWtR3FmuQx17KdvtCiS6T/CCIPvE96vbnB
         ciJaJMmGouKGdMgPvbClxB2eSFus+Wzj5/lwQDUMOWQBMcp7C5qLjrT0fS3OsY3H26mZ
         gsk03jcVpdmGcHCIuHrUwOSJZsCSbuMnBYCBK9ZQGg4QWzvjUHW+esEsKFOqgXbcUXTZ
         ywVg==
X-Forwarded-Encrypted: i=1; AJvYcCVnm6HFtRA5P9KPkH/Q/xfC5m+dKd3r9ql1nknREJNbrwlSaMkj5K0nTTfFT6WeSlGJEReTsT93SX7aC6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG+PR7OxqygtvwewbK6J7Tqglm06vsQH4fC0psMdJwiLVgy8f4
	CzhUrx14Tjwqv4rfkRKJ+d6QvezX1CivFjNIqVJPRD4wuAAJ3l/TlSNhwS3oY9+GahHsYXi2hnT
	4m0NV5WElhWNzpx+ybkufwd5RNYNihbdfhhe/
X-Google-Smtp-Source: AGHT+IG0BkWH9huLxAbcocB6UbaPhZ8uKL24LXDKmU6qhYTIHrvkI6QqSZM/PNXQdPdfOAWmrvv5Co9w8y6YcLQGbFA=
X-Received: by 2002:a05:600c:a00f:b0:426:5d89:896d with SMTP id
 5b1f17b1804b1-4318a5a4eeamr68805e9.1.1729705711389; Wed, 23 Oct 2024 10:48:31
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008183823.36676-21-samitolvanen@google.com>
 <20241008183823.36676-35-samitolvanen@google.com> <bf2b3e3c-904b-43c9-a9eb-ab710ff6e7fc@suse.com>
In-Reply-To: <bf2b3e3c-904b-43c9-a9eb-ab710ff6e7fc@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 23 Oct 2024 10:47:54 -0700
Message-ID: <CABCJKuejz2snUN12d7rA7-nNMXjUx9BKYmp86c43E4gJCjZFbA@mail.gmail.com>
Subject: Re: [PATCH v4 14/19] gendwarfksyms: Add support for kABI rules
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>, 
	Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 22, 2024 at 7:39=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 10/8/24 20:38, Sami Tolvanen wrote:
> > +/*
> > + * KABI_USE_ARRAY(fqn)
> > + *   Treat the struct fqn as a declaration, i.e. even if a definition
> > + *   is available, don't expand the contents.
> > + */
> > +#define KABI_STRUCT_DECLONLY(fqn) __KABI_RULE(struct_declonly, fqn, ;)
>
> Nit: s/KABI_USE_ARRAY/KABI_STRUCT_DECLONLY/ in the preceding comment.

Thanks, I'll fix this in the next version.

> > + * Verify --stable output:
> > + *
> > + * RUN: echo -e "ex0\nex1" | \
> > + * RUN:   ./gendwarfksyms --stable --dump-dies \
> > + * RUN:      examples/kabi_rules.o 2>&1 >/dev/null | \
> > + * RUN:   FileCheck examples/kabi_rules.c --check-prefix=3DSTABLE
> > + */
>
> It would be useful to make this test automated. Overall, I believe
> gendwarfksyms should have a set of automated tests to verify its
> functionality. At a minimum, I think we would want to work out some
> blueprint how to write them. Should they be added to kselftests, or
> would something like kconfig/tests be more appropriate? How to write
> tests with stable DWARF data that ideally work across all platforms?
> More tests can be then added incrementally.

Different compilers produce slightly different DWARF data, so we can't
necessarily guarantee that the output is the same even between
different compilers, let alone architectures, which makes automated
testing a bit more challenging. If we want tests for simple cases like
in these example files, it should be possible to work something out.
Otherwise, I think the best way to test the tool is to do build tests
and ensure that there are no warnings or errors, e.g. for missing
versions. Did you have any thoughts about the kinds of tests you'd
like to see?

> > +#define KABI_RULE_EMPTY_VALUE ";"
>
> Hmm, is there a reason why an empty value is ";" instead of just ""?

Not really, I can change this to an empty string in v5.

> > +
> > +/*
> > + * Rule: struct_declonly
> > + * - For the struct in the target field, treat it as a declaration
> > + *   only even if a definition is available.
> > + */
> > +#define KABI_RULE_TAG_STRUCT_DECLONLY "struct_declonly"
> > +
> > +/*
> > + * Rule: enumerator_ignore
> > + * - For the enum in the target field, ignore the named enumerator
> > + *   in the value field.
> > + */
> > +#define KABI_RULE_TAG_ENUMERATOR_IGNORE "enumerator_ignore"
> > +
> > +enum kabi_rule_type {
> > +     KABI_RULE_TYPE_UNKNOWN,
> > +     KABI_RULE_TYPE_STRUCT_DECLONLY,
> > +     KABI_RULE_TYPE_ENUMERATOR_IGNORE,
> > +};
>
> Nit: All new KABI_* defines and the enum kabi_rule_type added in
> gendwarfksyms.h are used only locally from kabi.c, so they could be
> moved in that file.

True, I'll move these.

> > +struct rule {
> > +     enum kabi_rule_type type;
> > +     const char *target;
> > +     const char *value;
> > +     struct hlist_node hash;
> > +};
>
> What is the idea behind using 'const char *' instead of 'char *' for
> owned strings in structures?

I mentioned this in the previous response, but it's to make it more
obvious that the contents of these strings shouldn't be modified by
the users of this struct.

> > +static inline unsigned int rule_hash(enum kabi_rule_type type,
> > +                                  const char *target, const char *valu=
e)
> > +{
> > +     return hash_32(type) ^ hash_str(target) ^ hash_str(value);
> > +}
> > +
> > +static inline unsigned int __rule_hash(const struct rule *rule)
> > +{
> > +     return rule_hash(rule->type, rule->target, rule->value);
> > +}
>
> Nit: Perhaps call the two hash functions rule_values_hash() and
> rule_hash() to avoid the "__" prefix?

Sure, I'll rename the functions.

> As a general comment, I believe the gendwarfksyms code overuses the "__"
> prefix. Similarly, I find harder to navigate its code when, in a few
> instances, there is a function named <verb>_<object>() and another as
> <object>_<verb>(). An example of both would be the functions
> expand_type(), type_expand() and __type_expand().

I suspect this is a matter of personal preference. I don't have strong
feelings about the naming, but I'm happy to accept suggestions!

> > +     scn =3D elf_nextscn(elf, NULL);
> > +
> > +     while (scn) {
> > +             shdr =3D gelf_getshdr(scn, &shdr_mem);
> > +             if (shdr) {
>
> Isn't it an error when gelf_getshdr() returns NULL and as such it should
> be reported with error()? If this makes sense then the same handling
> should be implemented in symbols.c:elf_for_each_global().

Good point, I'll change this, also in symbols.c.

>
> > +                     const char *sname =3D
> > +                             elf_strptr(elf, shstrndx, shdr->sh_name);
> > +
> > +                     if (sname && !strcmp(sname, KABI_RULE_SECTION)) {
> > +                             rule_data =3D elf_getdata(scn, NULL);
>
> Similarly here for elf_strptr() and elf_getdata().

Ack.

Sami

