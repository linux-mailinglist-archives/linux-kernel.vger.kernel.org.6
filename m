Return-Path: <linux-kernel+bounces-174776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB45F8C14D8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D4B1C20F43
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89CD7E107;
	Thu,  9 May 2024 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="adTeBkAR"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2498D1A2C09
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715279966; cv=none; b=isn0eC4VAKZPGGbAf5SQFp49VJv2PvTZZRZBKUWjm6ejoY6IZCa/6TLysXPkf110/8KJohnVEmzsuyjzzLfUDweK4y6j50z/1nz+dIDcPbxHX5eyQwn4bIYCmfEa8odpzbQIIU7VLeKkLoUyTZjhH9xKpZTTX+7qpOOhCdfCHUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715279966; c=relaxed/simple;
	bh=eJ9IVERHhky971S0DcjHHKpGh5uHfCRuKvsYihoB6wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mui9PgOFXYGBNO1L+3dZS7dcAWZuakasB7v4z/jUKq9laWYrXqxhNJPmRB24687cb7b/UTCN2V8MdP1FRJ5OJDUtfe4aLssclnLUwPy0BNJCz+9scB2gnJij2PGu9GtDO7rMaHF0HkiehVrzpzkpFx5CIPpDnqnPkk4dr25AXCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=adTeBkAR; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-573137ba8d7so4261873a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715279962; x=1715884762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fqOAT+gv91pKFh1YCYnEhtgE7NzT8BCjrBwFy+U+dzg=;
        b=adTeBkARsSZ8vrx3Vyx4gqT32PUH0y3/Cu0hZ/rADfmbLwfYUxtZLfakmVAlaHRCLu
         K5RChHRpa7IocyFLXGra2qQ66uJe/9nH/+Mge9Qq1XP9cQX/6JwkfGj5VtYzi3rq/vnt
         XYdSx4XWSfRBYBQTv+uhN/LkV0H5UJXcuSkY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715279962; x=1715884762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqOAT+gv91pKFh1YCYnEhtgE7NzT8BCjrBwFy+U+dzg=;
        b=g9OpOo+emhd4KrfMUlyu9DJMaP1HlxtCmBrEKuoIeVRfh0t3J5VPgz0iSRmiCwN62L
         fNTqcs3Lc9gz9O2FrrM9XauSzph5W5DYU6hXhChLIc1eJYWpwr9Mx2kP7hkWg7W33BCY
         qYyMM72pm4RLoecaqhF8BCoMHuBk0BDWBL2r4q4hEPHA6wnh//6NfZxHQW58tNPf+3af
         ik1qH1uAvdDb8eNDy9Up4LkQ0qidNMcVEs/xOSEnWrQuLthcec6ag07+QsWiwzdr/17M
         0pKLL2NRltxuY1xKu7CjoTsswk1FzGcmH7It9ZJ/Ehwzyi/mIAdCTOM7I6BvmOVy7KDJ
         PYtg==
X-Forwarded-Encrypted: i=1; AJvYcCXZMMuh8phoTnGBQny74r74cR3XGqtZUFPx9Bpfj0iNUgRuXMsznUzk3Hpog/Mms/jseo8IkYyGDU5tNuyXijluGYiY3MOyCenZYoCk
X-Gm-Message-State: AOJu0YxFZVXoxSqgso0yGGkH3yDRqEfNmoEiQTJcR4yfiVviBOFff7RA
	IV2G/Rnoq+oKw69l7Ypde31waiE2+lJUqqC17Yb4cn9weUWRWd6Lw/HrlBrM4x/xw2Cz5PONgKQ
	00vw5KA==
X-Google-Smtp-Source: AGHT+IEWqxsjOSJpVfX4hYURgHe+ICN9y3VD+H4kzYAnwhmf/fwV3KngLCJEf9e2Xs/g61F/+QOWyg==
X-Received: by 2002:a50:a6d7:0:b0:572:d4de:ed08 with SMTP id 4fb4d7f45d1cf-5734d6f3317mr470729a12.16.1715279962351;
        Thu, 09 May 2024 11:39:22 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c32710bsm945978a12.93.2024.05.09.11.39.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 11:39:21 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59a352bbd9so216847066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 11:39:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUK7LWmFBgHEE43RxK1nYcD0A5ZlWHSlhyEon/DZVlVzFSDt4IWqgwMmryAciki5tG1zUea9EvlfWB1jvi5JeDcgPlnHYeVwbfXGepb
X-Received: by 2002:a17:906:410b:b0:a59:ad76:b371 with SMTP id
 a640c23a62f3a-a5a2d292a8amr45358966b.26.1715279960933; Thu, 09 May 2024
 11:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404291502.612E0A10@keescook> <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook> <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook> <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <202405081949.0565810E46@keescook> <20240509140854.GF3620298@mit.edu>
 <CAHk-=wgKyP2ffZPa6aKYtytzzFibiNVN5MS=D2cn7_UGCECKdw@mail.gmail.com>
 <20240509175417.GR2118490@ZenIV> <CAHk-=wgXm15gZHvt8waSFhXS9yZTfvMV95xyvNtPc6FSEA_rvA@mail.gmail.com>
In-Reply-To: <CAHk-=wgXm15gZHvt8waSFhXS9yZTfvMV95xyvNtPc6FSEA_rvA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 May 2024 11:39:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBprh=8Us-MtwH9sVNELZK2hdOkFn3EoauwecYgtXOCQ@mail.gmail.com>
Message-ID: <CAHk-=wgBprh=8Us-MtwH9sVNELZK2hdOkFn3EoauwecYgtXOCQ@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Kees Cook <keescook@chromium.org>, 
	Justin Stitt <justinstitt@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 May 2024 at 11:08, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  Any half-way decent compiler will end up optimizing away the shifts
> and adds for the high bits because they see the assignment to
> 'all_bits'. There's no point in generating high bits that just get
> thrown away.

. it might also actually be a good idea *IF* we were to have some
kind of "implicit cast drops bits" warning, in that the compiler for
that case wouldn't remove the upper bits calculation, but would
trigger a warning if they are non-zero.

So there are actually potential advantages to just always apparently
doing the full 64-bit arithmetic.

Without debug warnings, it's a no-op that the compiler will just skip.
And with some hypothetical debug flag, it would be a "you are now
losing the high bits of the time value when assigning the result to a
limited 32-bit time_t" warning.

             Linus

