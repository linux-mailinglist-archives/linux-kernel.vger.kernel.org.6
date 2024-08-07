Return-Path: <linux-kernel+bounces-277138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B141949D20
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACFC21C223C1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30431A28D;
	Wed,  7 Aug 2024 00:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCj8Qz8w"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B9B1DFCB
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 00:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722991787; cv=none; b=omsEix98E+4xY3nj6dJ7bC+K2V3ofLtQOKDX5GsdT8lPV/zXzX2xEvWJJVnUcKwZGDiXK7ugH3BGzyVPT3QD9vmgcR9974Z5Df4KhKJcV86TGUk4lrtapgoltS3rtEhrrjgIw0Tkytonh5RrkYf0ZpsnjUIakeu3Au7vvySd84I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722991787; c=relaxed/simple;
	bh=boidwi/KoN13+31J9yzEy6QwXb7YTtBUyrBOzFuBmVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkghryYorAOpte7SvB2g+ZrF7Cf6JwExCfYW66XsGg6s+1K9JcG0namsnVZfi6qZ+9T1wgt7Ua4/1c7fVfZEyBh9KUx59H0P2fDXxtosOoLPfj4ZQhoWEKC5f1FW1ZBkFW/MZeyoBtrTcAMONWgKlugJ44Vb+XUgwmN817k7z8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCj8Qz8w; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4f51af903a7so211902e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 17:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722991784; x=1723596584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boidwi/KoN13+31J9yzEy6QwXb7YTtBUyrBOzFuBmVQ=;
        b=RCj8Qz8wTM+TFXCU2iDIzAPvknL0S0o9hlpwX1T0RSLEmT0q5bhmSt8CB3lLUqQ7L+
         KWTxvX691Rk65d8X1L90qeB4recj+irJDmr61ti8LUe4JEq0cuy8CDROruArBOolWqeU
         p5myG0ebzZFDec2NauzEap9qnwls+pA0bJ8saV+mExQP+eVhz+MEWkhj4K4iIX91rmOr
         QJxbosBaI8c6XkO446DNvDMlWdHHNwRQ5v3z4tBvZytpIUaFALgU0ci7HruHG9jzpa/a
         frEGLIrX3PFxIG7c4FgXyDKj3ePgNgF1xIHsl7OrIcrhP/jUCjFNttLd+/AVPQyMVgQ4
         YbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722991784; x=1723596584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boidwi/KoN13+31J9yzEy6QwXb7YTtBUyrBOzFuBmVQ=;
        b=ebJGtcsUUs8nU9OLwK7l8TP78znPxGdv33c1IyErBlvfxlL/YGbfxuhRaoWbZ7FYNU
         qXlaq0MNGSJ1+y57f56qXGjKdDT3H1/KvETDrZW+4RQVWxp5Lu5RnGYbB4ayGZ+FAujK
         zLCFBLL88GPBi8DtQJOB64/Kyv93QneMbtszEwNTdd0cxLeAZXt0NtdxouWEzvKPL4By
         sIAlZqdrVaMw2S9akk8NvZLdwtQweLIiBotZ4s0Z0vnY3ZCZMgS5rzHPHXxFkG9Evd/w
         CkflIiifn54HPex8uom/eD6OXcWVM1QNO7heX9fUpcToB7JmGRr6yTbPB/piLhtesgI2
         c9cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWENCwhgBMWP74E27H1bWN0lAT9CP6TExcS4nflmhadka+DuoIdqkx/TKZxkqhl19ItvihpcAWM2sbW6ZOsvohfhKX13LClO8OxC/A2
X-Gm-Message-State: AOJu0YwWFQS4Kh6xS04JNgezFJbaJr+a2XVdg/nAd0igtHPciibT5Pp4
	y9TiXygGww7LXyuB9sdgBNqc2iw9S0bQQ0Agx1zBeS1R2kGPDVJy3puzN2mL4i+/WBBOvao7gVR
	VH+/k5sXJYdVVoUIX8PO6dz+hyOI=
X-Google-Smtp-Source: AGHT+IETxfvvtRgntPeMcynJ6Fu1xrzgeZA8YsI0dXd4Y+wjatMssT/Qm4odmkEj3jndmAQ0r0/ePCcCKyIqb0mRl+Y=
X-Received: by 2002:a05:6122:549:b0:4f5:24e0:26d4 with SMTP id
 71dfb90a1353d-4f8f54e6eb5mr293802e0c.1.1722991784449; Tue, 06 Aug 2024
 17:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806212808.1885309-1-pedro.falcato@gmail.com> <CALmYWFuN5SxCrkFfgeP_uFThz-a=+VExjy2eqn5tQZSyaCjswg@mail.gmail.com>
In-Reply-To: <CALmYWFuN5SxCrkFfgeP_uFThz-a=+VExjy2eqn5tQZSyaCjswg@mail.gmail.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Wed, 7 Aug 2024 01:49:33 +0100
Message-ID: <CAKbZUD1BGV5PMwtGwN1kLHTa6=bfEztrcBW7onzSgxwAAgTjXQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] mm: Optimize mseal checks
To: Jeff Xu <jeffxu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 11:25=E2=80=AFPM Jeff Xu <jeffxu@google.com> wrote:
>
> On Tue, Aug 6, 2024 at 2:28=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail=
.com> wrote:
> >
> > Optimize mseal checks by removing the separate can_modify_mm() step, an=
d
> > just doing checks on the individual vmas, when various operations are
> > themselves iterating through the tree. This provides a nice speedup.
> >
> > While I was at it, I found that is_madv_discard() was completely bogus.
> >
> Thanks for catching this!
> Is it possible to separate this fix out from this series and send it
> separately and merge first ?

Sure. This series is definitely too risky to catch this release, so
sending it out as a fix (tomorrow, it's late here) sounds ok.

>
> > Note that my series ignores arch_unmap(), which seems to generally be w=
hat we're trending towards[2]. It should
> > be applied on top of any powerpc vdso ->close patch to avoid regression=
s on the PPC architecture. No other
> > architecture seems to use arch_unmap.
> >
> > Note2: This series does not pass all mseal_tests on my end (test_seal_m=
remap_move_dontunmap_anyaddr fails twice). But the
> > top of Linus's tree does not pass these for me either (neither does my =
Arch Linux 6.10.2 kernel),
> > for some reason (mremap regression?).
> >
> I just sync to Linus's main and I was able to run the test (except two
> pkeys related test are skipped because I m on VM)

Okay. Fun bug.

I was really confused as to why no one could repro this except me :)

It looks like recently[1] glibc started consuming the new_address
variadic argument when MREMAP_DONTUNMAP. As to the why,
MREMAP_DONTUNMAP also seems to take new_address as a hint (this is not
documented in the man page, and strace also doesn't know this).
However, this trips up some checks that were always fine before
(because glibc always passed NULL, and musl still does):

if (offset_in_page(new_addr))
if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
if (addr + old_len > new_addr && new_addr + new_len > addr)

^^ These all look at the address without looking at MREMAP_FIXED, and
return -EINVAL if they fail.

So, test_seal_mremap_move_dontunmap_anyaddr passes 0xdeadbeef For Some
Reason (why are you testing mremap in mseal_test.c??), it trips up
offset_in_page(new_addr) in mremap_to, and we crash and burn.

As to why no one else could repro this: I guess you're not running a
glibc new enough ;)

[1] https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;h=3D6c40cb0e9f893d=
49dc7caee580a055de53562206

--=20
Pedro

