Return-Path: <linux-kernel+bounces-226290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E11F913C7D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEDDA1C21B23
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 15:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893871822D3;
	Sun, 23 Jun 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FaeDNicD"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED8E1802C0
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719157360; cv=none; b=KLOB28iUYFQafBQwmW2P/sHi/3AC1syGiDmvw16gs3JbyhI4eIk/p2/oBABq0tBi1xgW0axxdVY56+xU35XZVRHjD4Hzx6OflABqM29og1zZtyJDgfzHF2g/YjObvey+5olPuXkqBUthRfypermLOKPPb6s7yQlGcOltfUe3LjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719157360; c=relaxed/simple;
	bh=iFXcoknjEWe4avEoLfa0XtaegaueFZ48+goiOQFuMR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGjgKVQTqwXm0wmb0eLMReUIcM9FWpKvtYvYuFSqC+lu8KEyH0QGE40nyro1x7LfPQRQL8La3p7MFJHhExpAaUJSUola+aelv10hyAGZZc1INRz9686AneffK26kINsjPzMntar+yvnocFNYAzImKQRnLgQPXOXtolWhrFs+kOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FaeDNicD; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso37993161fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 08:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719157357; x=1719762157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bwkVEJXxyiArkV9Jcvb+VVmKUfhm5RmA00AhRtW/JHw=;
        b=FaeDNicDknuJ+QMOOjoGkFEy6zzaQR1q8iOZfi5T5q9/lAqtSxlbR/wVkLov6/Mkq4
         JIPNsEu/E3HoqVLKb6xg4xWE6Ppa7Igg1DSFDtKrjAEzxWTfPbJAVR7W37jZBa63O943
         +8oOdLXXoGUlVdiCkvVAr2uQTNNEWki4zgsD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719157357; x=1719762157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bwkVEJXxyiArkV9Jcvb+VVmKUfhm5RmA00AhRtW/JHw=;
        b=qg0J1cNjncxKWLm4nQ34FAVSaRfORJZlnY0Pv147bmy6nK8aqDu8ddreZ+z6kOWPGc
         OuM2lWbpvp2eQ9kRFiuWGkNvci4cW2aChaBdFrzk1dI/tiba7yAx8XNl3ZPMu2DVLhKZ
         aJvK/l/VLlWylftcoUlgQOEF0D7kvmRh+2FxcQQPqoThJ/BHt3ouJaV9lFxlr4NV7noE
         5v6scaujxo1zI87IzuOdAE59k+mIc6EAzDrwTSo9lp+BTqsKyhiR5kutuL4JPdnjQF9q
         duLzmhlY8K2QC76jpWF7wsQjy99qFvPQLrIFg4RxYGeNZJT7gG3MroDkc7fxnSTNTEOO
         5sPw==
X-Forwarded-Encrypted: i=1; AJvYcCXq/fA2UAl/hW3Z+j5u2H6LFUZ7XzHcfpZs3oV9EmaPjRv9wN+2GECPZHjYfaMy1IfUa7VnW2YpNZuSmTqeGdr0GY0ibWxF72ROO8In
X-Gm-Message-State: AOJu0YxaLutsBRh49vx4TcAi8ORWrEgnkVA46lbv43cpdl6NxXmuAImJ
	wo3j5sO+S60GmkvmBgDs3CYuCr/uxAVcmWx/Hc6XBB/3oGtiF43kHmw2wA3/l8RUoPK7bC2JTa2
	6NFkQ1g==
X-Google-Smtp-Source: AGHT+IGfMTWKPSjFJC+KeAcPrPv9sU8+1HGzJWurDwbxweWJ1PXkFCpXg2tGU9U7r5Cz/cqQq2E3Nw==
X-Received: by 2002:a2e:9209:0:b0:2eb:ea62:179c with SMTP id 38308e7fff4ca-2ec59587b4amr16313221fa.53.1719157356645;
        Sun, 23 Jun 2024 08:42:36 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30535010sm3630739a12.59.2024.06.23.08.42.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 08:42:35 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a724a8097deso44507166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 08:42:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEsuxARZzuysdpwNsgegE1S03Y4BBo3/BHlGXkm1mieDC/Kfsyx4UXRHuzrJ964bLqXLYEvweOO1oGhdi+SFmMnBSJZQ7mo8YemLOC
X-Received: by 2002:a17:907:a4cc:b0:a6f:e8b4:9e59 with SMTP id
 a640c23a62f3a-a7242c9c1e4mr147616666b.24.1719157355462; Sun, 23 Jun 2024
 08:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406230912.F6XFIyA6-lkp@intel.com> <CAFULd4YVOwxQ4JDaOdscX_vtJsqJBJ5zhd0RtXXutW=Eqh29Qw@mail.gmail.com>
In-Reply-To: <CAFULd4YVOwxQ4JDaOdscX_vtJsqJBJ5zhd0RtXXutW=Eqh29Qw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 23 Jun 2024 11:42:18 -0400
X-Gmail-Original-Message-ID: <CAHk-=wg1h4w_m=Op1U4JsyDjsvqG0Kw1EOVMQ+=5GX_XytdorQ@mail.gmail.com>
Message-ID: <CAHk-=wg1h4w_m=Op1U4JsyDjsvqG0Kw1EOVMQ+=5GX_XytdorQ@mail.gmail.com>
Subject: Re: arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly
 requires more registers than available
To: Uros Bizjak <ubizjak@gmail.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Jun 2024 at 06:14, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> The referred patch actually mitigates the issue, as explained in
> details here [1].

Clearly not.

It might help things in theory, but in practice it clearly just makes
things worse, and causes problems for clang.

And the thing about practice is that it always trumps theory.

> So, without some interest from x86 maintainers, the issue will remain
> unfixed. If they want x86_32 arch to die then inline locking
> primitives involving cmpxchg8b are one of the nails in its coffin.

What? No.

That commit will get reverted. It caused problems, and now you are
blaming others.

You can't just go "I caused issues, but the x86 maintainers aren't
interested in this area, so it's their fault".

And no, "improved code generation with one compiler version" does not
then mean "other compilers don't matter".

Now, I do suspect that the issue is some very random thing that could
be fixed by massaging the inline asm a bit.

For example, why does that 32-bit __arch_try_cmpxchg64() do this:

        if (unlikely(!ret))                                             \
                *(_oldp) = o.full;                                      \

when I think it would be simpler and more straightforward to just do
that *(_oldp) = o.full unconditionally? The "dereference" is purely
syntactic, the intent is that the compiler will just use a register
for this all (well, two registers on 32-bit), and making it
conditional makes things worse, because now that "oldp" register
cannot be the same as "o" itself.

I didn't look very closely into this, but maybe that would just fix
code generation. And maybe it wouldn't. If there's no other fix
somebody comes up with, we just have to revert.

                 Linus

