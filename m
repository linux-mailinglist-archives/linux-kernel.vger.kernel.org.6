Return-Path: <linux-kernel+bounces-194837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E137C8D42BB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 03:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6C028584E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 01:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DC0FC18;
	Thu, 30 May 2024 01:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DIUV9itN"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD2EE57E
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717031352; cv=none; b=pjfpaux9XMRFjiZnwekp4ceeyuL6nDL9k353RW7Ex647RCUN8HAz3ZDv+KW863slMMishbD2huZOTiqkcvlo7QrekQBqPWoCm/Nkx9phxfp+g95hv6KlQBwUzCkgInNMWSCYUTRBWcMKS5/5NNpithilh8AKWVrNcmOKP5S4tVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717031352; c=relaxed/simple;
	bh=r1WLIYqwEcFl1zxpSruq17uincpEIe2QAM/Tkg8t+yY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKo3J3Gk/quwAw96RZmw24w00QBBKtAAI89ojsFjf6nv5NA0/5oTJALjacKK20IR56tKckql9kd6TZa38FflUQBv093naenvL+oWJoaF6Yc1Q9QSVebM56QKYpXppkZFcBxvYROtRA4CuDbX+YP18G/bvBb/tOASbWHWylpmYVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DIUV9itN; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59a352bbd9so47058666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 18:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717031348; x=1717636148; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pc8AzCw2itqlchY2iNLylrW0HG92I3q/DnK9Zsb7BQY=;
        b=DIUV9itNhbg8EfKLtpnHuKH1pEUDR/trubtVF2Pcu4Z2lDAl5gF9rVTS+Ts6Kk8+Eq
         0PnNYawFbqcd7oo1KeIFL9Mq7uc98o7+69ELep2M+FKQDxUE7PHC0gPRNrOdoflb4CyU
         dJkWdqUo/ovPZPD+gjAyrYMac6zoBKYhanCvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717031348; x=1717636148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pc8AzCw2itqlchY2iNLylrW0HG92I3q/DnK9Zsb7BQY=;
        b=KrFGxtPnqAhgDSqQGzF1XPpkNIG8cejKCWDiZ/muRQg08CAqFxdBMYkIbp7dl8urqT
         NI3RHNbCJnZzqIrbE7d+IMC2BlodFUfJSzi338C+AQG/iPqqn46pkypWm7gJrWuy1rDy
         SrAfLcy8gvep8Tx11zK3TT3RhVgZbjmx8s4Upz/4e5k9aM3OsRP6RmGBn1RFSXZMNrPV
         Li4Q1j0ODLM+gRYqCimfEdAhSAcAjcjmt9RYW58DOwdUKWvRQ7CJGY9erXin9Dxy8FtA
         YLOO8KajP7v2bKrFD8g+YygOWNU6sGM2rIqDMED32Ay9QFJxEmcZLB+prp8q5mIqPD5h
         Y57A==
X-Forwarded-Encrypted: i=1; AJvYcCUfV9d2bwe8178Ek9eJPQQbOrrLlRibBjf0gAtD3EE5I2GlQGMfTUbQ9ZNt6mX9xETVcsxSTZMKRpgiV5+NAoytxyDKtj0SofGUZYt4
X-Gm-Message-State: AOJu0YwL27HUT2AS16Kh8r1ID/RlePIzQ6Icl2JKIIWcaE7NrPr/4WX7
	onBMQuMDJwEtO0O/F0eG3uIQmKdf49RaZ3Y843HAWuKSYZhQSx0LFzkBzuhBHp8rFQbdhtssoOR
	0cFh8yg==
X-Google-Smtp-Source: AGHT+IH32JF9eGSOVtjZd87FyZ7+H5u6pRkZ2ANtmLMi39Durq2GeB5GvevK1lGpSp6lej4m9TuLFQ==
X-Received: by 2002:a17:907:384:b0:a59:ccc3:544 with SMTP id a640c23a62f3a-a65f091103emr30767166b.2.1717031348393;
        Wed, 29 May 2024 18:09:08 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8d606sm778026666b.176.2024.05.29.18.09.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 18:09:07 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5789733769dso926838a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 18:09:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVogebV2cjGLs7Ya1tqhtACTnOTsjJHbGhevtEgpM8/P3+hW0B/dHQSUvepvJXolMxHQfV/8pw3H7OeIwO4jp5bmVxAUq8SJEeTQPZ6
X-Received: by 2002:a17:906:cb90:b0:a5c:dce0:9f4e with SMTP id
 a640c23a62f3a-a65f0bd7b2bmr31381166b.28.1717031346663; Wed, 29 May 2024
 18:09:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503081125.67990-1-arnd@kernel.org> <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de>
 <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk> <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 May 2024 18:08:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7WfDSfunEXmCqDnH+55gumjhDar-KO_=66ziuP33piw@mail.gmail.com>
Message-ID: <CAHk-=wi7WfDSfunEXmCqDnH+55gumjhDar-KO_=66ziuP33piw@mail.gmail.com>
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Arnd Bergmann <arnd@kernel.org>, 
	linux-alpha@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
	Michael Cree <mcree@orcon.net.nz>, Frank Scheiner <frank.scheiner@web.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 May 2024 at 11:50, Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
>              The only difference here is that with
> hardware read-modify-write operations atomicity for sub-word accesses is
> guaranteed by the ISA, however for software read-modify-write it has to be
> explictly coded using the usual load-locked/store-conditional sequence in
> a loop.

I have some bad news for you: the old alpha CPU's not only screwed up
the byte/word design, they _also_ screwed up the
load-locked/store-conditional.

You'd think that LL/SC would be done at a cacheline level, like any
sane person would do.

But no.

The 21064 actually did atomicity with an external pin on the bus, the
same way people used to do before caches even existed.

Yes, it has an internal L1 D$, but it is a write-through cache, and
clearly things like cache coherency weren't designed for. In fact,
LL/SC is even documented to not work in the external L2 cache
("Bcache" - don't ask me why the odd naming).

So LL/SC on the 21064 literally works on external memory.

Quoting the reference manual:

  "A.6 Load Locked and Store Conditional
  The 21064 provides the ability to perform locked memory accesses through
  the LDxL (Load_Locked) and STxC (Store_Conditional) cycle command pair.
  The LDxL command forces the 21064 to bypass the Bcache and request data
  directly from the external memory interface. The memory interface logic must
  set a special interlock flag as it returns the data, and may
optionally keep the
  locked address"

End result: a LL/SC pair is very very slow. It was incredibly slow
even for the time. I had benchmarks, I can't recall them, but I'd like
to say "hundreds of cycles". Maybe thousands.

So actual reliable byte operations are not realistically possible on
the early alpha CPU's. You can do them with LL/SC, sure, but
performance would be so horrendously bad that it would be just sad.

The 21064A had some "fast lock" mode which allows the data from the
LDQ_L to come from the Bcache. So it still isn't exactly fast, and it
still didn't work at CPU core speeds, but at least it worked with the
external cache.

Compilers will generate the sequence that DEC specified, which isn't
thread-safe.

In fact, it's worse than "not thread safe". It's not even safe on UP
with interrupts, or even signals in user space.

It's one of those "technically valid POSIX", since there's
"sig_atomic_t" and if you do any concurrent signal stuff you're
supposed to only use that type. But it's another of those "Yeah, you'd
better make sure your structure members are either 'int' or bigger, or
never accessed from signals or interrupts, or they might clobber
nearby values".

           Linus

