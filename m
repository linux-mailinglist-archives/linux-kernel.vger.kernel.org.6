Return-Path: <linux-kernel+bounces-276727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B002A94979A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C63B1F2340F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6177BB15;
	Tue,  6 Aug 2024 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W6ujq1Qx"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE87361FEA
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722969213; cv=none; b=oMA14Rr0r/0/VHfuCAJSQ2rDqsorA4KjX9+ug4C9IOQDFuS2G8ykdlyLHhNBfxo382n7lLVj35ILsM0Z1TA2PAgRL5LCnfHUjQkDraOIRfHJLkBFevNvB2loN/8CTfcc+715BMRexpKtgCDKNQG9AjMYvqa/OzxfKab1yp7eed8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722969213; c=relaxed/simple;
	bh=zasWR6zw0PGiFl5giUz4J/s3nZol4hptXlqOgdgsDiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIflNZB5yJMSrS5fwtQZan1kqrxI2xDcOsQRC7p0eczq3d90P+f96ootiUpJDSjDgjym5OYUucss56U/cYPvGBfwps0+G6UYbc3CEUiJxL4HbfX/GxxwezVE/9HDgaSJN6iYQA0fqV+f8jlwhG3YYQRDRKQ6q1HUgjWjSuYqJyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W6ujq1Qx; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso14666491fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 11:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722969210; x=1723574010; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ms28GEaZtsEeVLD5znVUMcSsrF85gVuP0sxo+Yw2Xgg=;
        b=W6ujq1QxGMweHUqBpOJfRpLQqQIpQN8CBF/k1l4vmPFOnv6pQjZoJuluna6AFjEZBX
         jSZGHLLlqs6n+5Pftk9Y8YJLo42cFomW9bnWm4S75Kru6GeEDz3R+pIriy7X0HLsjtGn
         y4f38xLir1iknN7vLAEEf2AqGd7GFXJmew4EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722969210; x=1723574010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ms28GEaZtsEeVLD5znVUMcSsrF85gVuP0sxo+Yw2Xgg=;
        b=koRY5mnxZsxq9fEslf82dBeTZBo3/ZkBz8CY43zhyOjY0Syszb6mZ+vsNW3qcH86Ze
         ETu+ZfyabYmn56quDs4P/zC7aPQXltifxMK8FauK5AyFEcI2BiPDjtegqwBsXGdDHBH6
         elsvySWovz57+aXR92AGDLtFLWw/DD53/6w+IQBKM/9YTO//u0nyJvFnoLUJkrQ2/pZk
         LuE2+YkDMDFDf1p4vxG2gLDE0i1KUOTjoYN7Qzy3ODZBOdpLr5ZX0nAzm/vgFXi4Jrjr
         pPvJ7HmJuWUvhLRGvGAvTz+xYFuf5ZU9jJdEfV8dQbdqT9DKJnaOA9QASLGQx2U+F2zT
         IP7w==
X-Forwarded-Encrypted: i=1; AJvYcCX2lhaRbbNCSO6CR9OrJczK70Bi99m4DnVe8Bm/r+4OShhUzyoAZkZ7SW99fZVeSjPAuUxZy4hVe3tShgteifpk3XTlUd1iwqxNMHPo
X-Gm-Message-State: AOJu0YxOO2Q+ARiiNnKXOVgeR6aNFGXu14EFI3rnXt1nFbt0CRUZI6ME
	iOW6g5Aw3hsewkHn2oFuO34cE6AKnGIObhH3Vu7Jn2m5GW9VnGs0vscAq7SRvLgMHMT7D9Yj0Ou
	WQmTTLQ==
X-Google-Smtp-Source: AGHT+IH+WCgdX00lXUgxxo7IvkYleLtORi0TbbHRcc76T1ePB9wP3srFO9mHviSEpiDY5IfmI1IyYw==
X-Received: by 2002:a2e:9845:0:b0:2ef:20ae:d117 with SMTP id 38308e7fff4ca-2f15aa88cc7mr132046291fa.10.1722969209529;
        Tue, 06 Aug 2024 11:33:29 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e25092bsm15363361fa.77.2024.08.06.11.33.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 11:33:28 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef248ab2aeso15798311fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 11:33:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUd9ICsSEGJeOGeXaBdIahSXe8+X6r1nBJGFJI5heDlHqmFzw1R1y5KV2qZV0SJPSjQ2yB2jRS2ocEQnqH3qREK3BZBZIowbKKjxrd2
X-Received: by 2002:a2e:9cc9:0:b0:2ef:1c0f:a0f3 with SMTP id
 38308e7fff4ca-2f15aa88b76mr128814961fa.6.1722969208425; Tue, 06 Aug 2024
 11:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
In-Reply-To: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Aug 2024 11:33:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_P7UR6RiYmgBDQ4L-kgmmLMziGarLsx_0bUn5vYTJUw@mail.gmail.com>
Message-ID: <CAHk-=wh_P7UR6RiYmgBDQ4L-kgmmLMziGarLsx_0bUn5vYTJUw@mail.gmail.com>
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
To: Brian Mak <makb@juniper.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Aug 2024 at 11:16, Brian Mak <makb@juniper.net> wrote:
>
> @@ -1253,5 +1266,8 @@ static bool dump_vma_snapshot(struct coredump_params *cprm)
>                 cprm->vma_data_size += m->dump_size;
>         }
>
> +       sort(cprm->vma_meta, cprm->vma_count, sizeof(*cprm->vma_meta),
> +               cmp_vma_size, NULL);
> +
>         return true;
>  }

Hmm. Realistically we only dump core in ELF, and the order of the
segments shouldn't matter.

But I wonder if we should do this in the ->core_dump() function
itself, in case it would have mattered for other dump formats?

IOW, instead of being at the bottom of dump_vma_snapshot(), maybe the
sorting should be at the top of elf_core_dump()?

And yes, in practice I doubt we'll ever have other dump formats, and
no, a.out isn't doing some miraculous comeback either.

But I bet you didn't test elf_fdpic_core_dump() even if I bet it (a)
works and (b) nobody cares.

So moving it to the ELF side might be conceptually the right thing to do?

(Or is there some reason it needs to be done at snapshot time that I
just didn't fully appreciate?)

           Linus

