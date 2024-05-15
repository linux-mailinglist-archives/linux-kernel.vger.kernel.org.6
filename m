Return-Path: <linux-kernel+bounces-179348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4568C5F19
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2CA1F22313
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 02:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42120F9CF;
	Wed, 15 May 2024 02:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c+de57/h"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425C68820
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 02:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715740156; cv=none; b=QWL8IRanA+s1qzLIqKXuq0j7BtM90QF7OLe0z3Iedb6Q8MJ8LQdOlGd1vPPN3YV8xRGRlBLIGmCXmqu+zW0lx/Y4eI5wadPk3xGTiwuWsZCQRmopGvYrjzfuiDOcuIPGc/1NkrGM5kSjvRk2cE7hM7nJyOFg0WD9nW9d5aWdsjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715740156; c=relaxed/simple;
	bh=uIVALT8fMTxGKl7HLSAvodUgkyb/d8KBVovit9yBBdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyl1fGaFfYREoh2ng1buK1Nujd7OAKPJ+0X6UR+10xfiRUVG95MJEobXtU4KQ4UgTwX7jArHd5L+I6/eZHOnyirJdZxTaLEJPRExMTO3sKPvLqoEy+tPulUIUi4cUxhmGOb3eNWHFkwnCJXBzMDVEoiOUMfCggWEQBqQ1Ew3lAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c+de57/h; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59a5f81af4so101847766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 19:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715740152; x=1716344952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HhWK/QjBhcq/4T9972QoRB3M6/JeMKBp9jipg24+Woc=;
        b=c+de57/hq2U/+YBIWKXyyEmgcHoqbPUQMBjr9atZPLcDL5hk3DgPoFVY39W1Q8kGJQ
         eTeN/wzXjI17cEZwYVs3+8Qzu+ZPLWIZ6Qs/mFAFthUPb/e9xjNu2x2GdQfLlOFeuJCI
         Aq6rIRj8DKgjdUzEAoxhtFu2uqhwOHQipXccs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715740152; x=1716344952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhWK/QjBhcq/4T9972QoRB3M6/JeMKBp9jipg24+Woc=;
        b=BOg0fyG6uBcAw1XNTru3RDirLBDCDVDkBA2upbsDt5pMY02ARWMzAgjgscFLD+Zz3X
         Ty4ZO8HJISsXnGuytXNS4liJF8bM96c7tBx/gxL/TuZBeJ7MXRaFQfIbjemeLQ0sTH6U
         ouoPqPwmkTZ80hlzbT6o5X9lrlUMBLvqRAzjX0umLV8s6R28X0IVBW4vvwRtJOzHMijQ
         Ip8wVy9OQjvo57PLdSAvG7T4x2qR95jmGApyqWZa6O0tyaQw72TTnywMqAE5EiEY1KGO
         FS5I1Btpn26GUU4iOhwWuRfZmFeiMoa3oyIuB2OLhO43Cl4qQNe90tuQkk2oA+CSh+Yn
         Wv3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWU7M9mCeGBqTNElAmNcCLqGDLhjf7fmUQRXFEPUOrjDxmscP/LBTSAyO3j+vIax1e2NdeFtR41oEZXTBPHyiX8zXE4rFxQCOBI32Pd
X-Gm-Message-State: AOJu0Yzvkmx2+Qi5LOZM9qBAPp8AY9gs11zIylXv/VuCPXCknEOv0l56
	l6aVvUoDQ8MKdGkdyJz6udMRwNIwAoo3VjbgW4Jq2y1POONUb2uaRb/f/c2LvSeOk5fdWWikFhb
	9zsppfA==
X-Google-Smtp-Source: AGHT+IGDd4qfgG45fLbwmQIyDsy++B8lSPyEqm7V5gBvc9vclv/ntYQifvEm8U0poSdJEHYqTYHvFA==
X-Received: by 2002:a17:906:d7b7:b0:a59:9c58:763f with SMTP id a640c23a62f3a-a5a2d5eeabbmr1017886966b.39.1715740152554;
        Tue, 14 May 2024 19:29:12 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cd7asm802150866b.10.2024.05.14.19.29.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 19:29:11 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5a2d0d8644so116212466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 19:29:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJnLd0aqp8RFGU9HLztvhAjRoqNqqMtt1rqsDwPZ6OnENb9Hzcf2Cmndt5n53oc3Uj5T/UN/dExDepn9Qu2PKal+8Y9MgTsYMSjFMT
X-Received: by 2002:a17:907:7f08:b0:a5a:63bf:5175 with SMTP id
 a640c23a62f3a-a5a63bf5227mr784689766b.10.1715740150546; Tue, 14 May 2024
 19:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <871q646rea.fsf@meer.lwn.net> <ZkPXcT_JuQeZCAv0@casper.infradead.org>
 <56001.1715726927@cvs.openbsd.org> <CAHk-=wgsGCKvN0Db6ZRZqJwXQrmhZyWB6RmABaOp4DiZbXgNew@mail.gmail.com>
 <16982.1715734632@cvs.openbsd.org> <CAHk-=wi04ZCm3vTtkcVnAUdiOpX3a0hBZ-aQWONwCubOJQEdXw@mail.gmail.com>
 <84192.1715737666@cvs.openbsd.org>
In-Reply-To: <84192.1715737666@cvs.openbsd.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 19:28:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=Yb1r_g=geQe8YDGv-TA-UQBQe6-OVhA8FOGjWKnQmA@mail.gmail.com>
Message-ID: <CAHk-=wj=Yb1r_g=geQe8YDGv-TA-UQBQe6-OVhA8FOGjWKnQmA@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, jeffxu@chromium.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, gregkh@linuxfoundation.org, 
	usama.anjum@collabora.com, Liam.Howlett@oracle.com, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 18:47, Theo de Raadt <deraadt@openbsd.org> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> Regarding mprotect(), POSIX also says:
>
>     An implementation may permit accesses other than those specified by
>     prot; however, no implementation shall permit a write to succeed where
>     PROT_WRITE has not been set or shall permit any access where PROT_NONE
>     alone has been set.

Why do you quote entirely irrelevant issues?

If the mprotect didn't succeed, then clearly the above is irrelevant.

> When sealed memory is encountered in the middle of a range, an error
> will be returned (which almost noone looks at). Memory after the sealed
> region will not be fixed to follow this rule.
>
> It may retain higher permission.

This is not in any way specific to mseal().

Theo, you're making shit up.

You claim that this is somehow new behavior:

> The other previous errors have been transient system effects, like ENOMEM.

but that's simply NOT TRUE. Try this:

    #include <stdio.h>
    #include <sys/mman.h>

    int main(int argc, char **argv)
    {
        /* Just three pages for VM space allocation */
        void *a = mmap(NULL, 3*4096, PROT_READ, MAP_PRIVATE |
MAP_ANONYMOUS, -1, 0);

        /* Make the second page a shared read mapping of stdin */
        mmap(a+4096, 4096, PROT_READ, MAP_FIXED | MAP_SHARED, 0, 0);

        /* Turn them all PROT_WRITE */
        mprotect(a, 3*4096, PROT_WRITE);

        fprintf(stderr, "Write to first page\n");
        *(int *) (a+0) = 0;

        fprintf(stderr, "Write to second page\n");
        *(int *) (a+4096) = 0;

        fprintf(stderr, "Write to third page\n");
        *(int *) (a+2*4096) = 0;
    }

and what you will get (under Linux) is

    $ ./a.out < ./a.out
    Write to first page
    Write to second page
    Segmentation fault (core dumped)

because that mprotect() will have returned EACCES on the shared
mapping, but will have successfully made the first one writable.

End result: this whole "transient system effects" is just not true.
And "mseal()" isn't somethign new.

If somebody makes random mprotect() calls, and doesn't check the
result, they get exactly what they deserve. And mseal() isn't the
issue - bad programming is.

Anyway, you're just making things up for your nonexistent arguments. I'm done.

            Linus

