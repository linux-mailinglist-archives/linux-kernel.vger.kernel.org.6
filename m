Return-Path: <linux-kernel+bounces-174752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63FD8C1480
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7090D28268F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD78679DD5;
	Thu,  9 May 2024 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IwKBi4r0"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DCA6EB62
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715278115; cv=none; b=ahPnasSyDgCBICQDPLqrW0iIyQQeAcGW5Sa0N7JstMJv9606msQsOYwj39CwQO4DzVCV+TZ8sCaj7Qts357lWhhAIT0mx1pbG3t6XLdSCf3tABkprsXX/Ug4iTOsF8n1g24H1HB7YB3DLsKY+BKMBCFH+Cw2hrw6/DeLrnTXPs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715278115; c=relaxed/simple;
	bh=B/fLZgJ1kMx5q/e/aqEvOH6JUgyuZ+Q/2hXPHkpLqEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lsQYiIM4ahhLLpOrV1N/+HpK8zjd6IGZIN/Jyi7C9GkW9UOIPZsqIYXKjo5VcUCX2f+Wk3qxoHmQVOBhv2SpEqOHDshWjARjH7WrjXzDkZhG08ZMR2BjUTWPmoj4LLH1l6aK9qlD28eAdcFl6vqhMkeBHtESRv2HNP8vn1c2KO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IwKBi4r0; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a599eedc8eeso313376166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 11:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715278110; x=1715882910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2M1QRjYBDT1Zd0NqfbgFR5skSig9YZV6L8U7l1RklbU=;
        b=IwKBi4r0DT2bnZC3xar/In+2PnJV7LJaN1eie2qTgFhmDjRZ13MDTwKaDCw2FlhKMT
         wwNbiuEaH7IrVbrtP2rxP8+MXmSzpEV8h7HUpEfKF7llk8CHCwCGUfLGpm+IOkLEsLtD
         m7mF+qBviPAQYt3g6aeryOJQXsw/bG3uFgHYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715278110; x=1715882910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2M1QRjYBDT1Zd0NqfbgFR5skSig9YZV6L8U7l1RklbU=;
        b=g2g1WqzkjdfQk7xa+LwS8o9GW5DsavLYipdVrQ6jZ9oSnkEjcJB89WUA7e/sEliKU3
         rK0AhXqC/kfDshE6W3eROXsoS6dMl7SANNPTy5eobfP50aD7ELBrJZyrCtGeXogbE5AE
         obbpvg8k3EPhQrTrrXyGtqGd83AtJZGSw0puaI4HD+dnIgXecyX51a+Gxk/6Ne9xWZ8g
         CZJNb7JkRxvhgswqjJtc/Du7T3ti0xPEA+fHzij33QzGAgQPKY5F15/QeOqQZ0QGSCvM
         wNZCONNz4cXGmrRGQtAAPZnKt0Qrte0AZ9c/tn1akKmVIEEi2IXoqmvKBpQPKomPPdhE
         tY7A==
X-Forwarded-Encrypted: i=1; AJvYcCU+DxJGOdSHBgt6tesuPYk9GT245F2QbTIUieN4pwxSJ+sbS2+PvnMXEnBNOBjHJxF7nRFwLYImaSpWpUrSk1ANnCrqiLVRRsd8QvSq
X-Gm-Message-State: AOJu0YyNQNGBkyds3g9iQiBoxP2WYD+vV3WfQSxlTYasGCOce/Rx7gae
	es5twJOaRhAGfREDWLHBmDtV/weyLDb/WwCFwGBZGGVdZd3uhnkfEw3j9d/zblfMb0SDvQZs2VW
	XPfM=
X-Google-Smtp-Source: AGHT+IGdTUsLvwp8goaa8jCEDWhBloqH8BlZs3z4DqgmM5sWInqTn1acByFn3swgncPOGggFG+y88A==
X-Received: by 2002:a17:906:81cf:b0:a59:a7b7:2b8e with SMTP id a640c23a62f3a-a5a2d5853b3mr20622066b.29.1715278110313;
        Thu, 09 May 2024 11:08:30 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781c269sm97927266b.38.2024.05.09.11.08.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 11:08:29 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a599eedc8eeso313369966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 11:08:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVU/j6t7zuskBMvoTtg9kg4DTwGHbt6fWbioDj4NpsdPxPenpSTg4mYd2+2YOoyTP2/urhmdRv5PRLwHllJbXDY6falD0NbtcRSAgQy
X-Received: by 2002:a17:907:1118:b0:a59:c5c2:a320 with SMTP id
 a640c23a62f3a-a5a2d581b19mr26210766b.23.1715278109328; Thu, 09 May 2024
 11:08:29 -0700 (PDT)
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
 <CAHk-=wgKyP2ffZPa6aKYtytzzFibiNVN5MS=D2cn7_UGCECKdw@mail.gmail.com> <20240509175417.GR2118490@ZenIV>
In-Reply-To: <20240509175417.GR2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 May 2024 11:08:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXm15gZHvt8waSFhXS9yZTfvMV95xyvNtPc6FSEA_rvA@mail.gmail.com>
Message-ID: <CAHk-=wgXm15gZHvt8waSFhXS9yZTfvMV95xyvNtPc6FSEA_rvA@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Kees Cook <keescook@chromium.org>, 
	Justin Stitt <justinstitt@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 May 2024 at 10:54, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, May 09, 2024 at 08:38:28AM -0700, Linus Torvalds wrote:
>
> > Going the other way is similar:
> >
> >         all_bits = low_bits + ((u64) high_bits << 16) << 16);
> >
> > and again, the compiler will recognize this idiom and do the right
> > thing (and if 'all_bits' is only 32-bit, the compiler will optimize
> > the high bit noise away).
>
> Umm...  That would make sense if it was
>         all_bits = low_bits + ((T) high_bits << 16) << 16);
> with possibly 32bit T.  But the way you wrote that (with u64) it's
> pointless - u64 _can_ be shifted by 32 just fine.

Casting to 'T' is probably a clearer option but doesn't work very well
in a helper functions that may not know what the final type is.

 Any half-way decent compiler will end up optimizing away the shifts
and adds for the high bits because they see the assignment to
'all_bits'. There's no point in generating high bits that just get
thrown away.

                Linus

