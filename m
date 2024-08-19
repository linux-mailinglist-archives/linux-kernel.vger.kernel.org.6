Return-Path: <linux-kernel+bounces-291514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 093A4956382
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21F11F21AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 06:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F07F15622E;
	Mon, 19 Aug 2024 06:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Gribi53T"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADCA15534B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 06:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724048042; cv=none; b=QoKt5f7DSzfYD+L3cwFiOYXUOkY50S774/P6zxcB0nkkkAEFElML7n7Dx8+K1bIokBJJVO8AsBywL+rBg8rdGqbK5nB2k9nhJdIQ/2pYsMdAvHjAAZBizxPvt2UayTXVgL4wgh3MLhgTTfdB5029EHQnV2J+18FptSY4RF9EwSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724048042; c=relaxed/simple;
	bh=lJN/wi/y13j7OPNXQVR6jT982u709Go38p1K7gpYR6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WA0gpN5hRKxVz01ja3VQ7OgdJ3TYpVyWLFjamQ9lCj2YyvbJXtS6Vgc4LeklQ9L1gthWZ0BA5RWkYVnZPbNbWr8F7NmfjpDStrO9WGhvjmcfw0FxQA41QLUgItOfgolXVkVpSETTjL4CuuSI6SWdurz3TpV+FvLsVisj4IkXSKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Gribi53T; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5314c6dbaa5so5289888e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 23:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724048038; x=1724652838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bUzBY94YxIEfhjxg5zqeXsZ0LIm0u1E4JMphgh/qV8E=;
        b=Gribi53T02X+zDkIM2Dx1tdzh8XdkBqVEIKTm/tqgGe3PdDcdH/gV7IKdbYxi1/eZi
         2QE84H/p2/InnSs1W0m0tdaIb1a+AYaX500qSvD29gYnv4KPCPvzNN/GKwCTsHZBtT+x
         05Y8Y4V7jZGa1fGwMYp6mdx2I0oQGgoGMIkk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724048038; x=1724652838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUzBY94YxIEfhjxg5zqeXsZ0LIm0u1E4JMphgh/qV8E=;
        b=YmqXPEOHJ4yzilfH2A3SePIQSTfUKOKmB4GCRUHUabqCjHIeLWO2a2LgwRipt1K4Ot
         K9xf9Eg19fCKIhy6FuD3FAyKFs6PhvtICxDYLUtFpzeqHJ5mOoQyOMsTJ61EWFwcINfU
         rE9CJCPIzMDY2WgM4btl0FFnJUuwc9C8Wthu62KLTCgz6i9ECyFUW1emXjONY2KHjWCb
         +dx6KgifqBr4dVTsK5xh9L8+lGBdhpXHwMEgkAIcHX6FkWuB12tZ4Ij8AYcI18cdOyuZ
         5KrF2kcklttms4YA7Wj/Am/qUKuUEFUgcSBcf2tBTWFsyerFJB99OkGGaeuC9iRRknOa
         Bgzw==
X-Forwarded-Encrypted: i=1; AJvYcCUxyjZf4rBkznAHiny3LGdWhK6VPDPyOtfk/QyodrT2D1KhbZ/5LVLcIVwBlt8tqvHE5XO0jgrPegnn1O91/FdTno/OSR1x/00CbrCR
X-Gm-Message-State: AOJu0YwpnltWZzoU7xlp1mClulg9Bnra4hWvWW+/DWM49qRL/sXcaBwR
	27ruGTWXHkCuAPBBmKlyPVgOD5tq0eiMIXuQWRd5IAs5jfSL4weS0DLUZYcrWYLrs6QPVtO+Mkk
	6S0JQRg==
X-Google-Smtp-Source: AGHT+IHxV7jW6gRz7VajILxJCjZsOPqfvjvSYySQjRZmNXNrF+vEZ10VrxKTf8DxGXbqc5AgHyasng==
X-Received: by 2002:a05:6512:1150:b0:52f:cd03:a850 with SMTP id 2adb3069b0e04-5331c6b0a4dmr6182003e87.32.1724048038037;
        Sun, 18 Aug 2024 23:13:58 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5330d424a79sm1386062e87.268.2024.08.18.23.13.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2024 23:13:57 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f025b94e07so44253741fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 23:13:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHM+HIhpcLDO/xvtlxRM6h4pE9KU/jYOJL4EKSfNc6wJMzwHLN2vOROClC6nkH2yfsVZsJ1i313l6k48ZU/9j8xxouZQIaPv1oGG2U
X-Received: by 2002:a2e:2418:0:b0:2ef:2b06:b686 with SMTP id
 38308e7fff4ca-2f3be596304mr66389161fa.17.1724048036887; Sun, 18 Aug 2024
 23:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819053605.11706-1-neilb@suse.de>
In-Reply-To: <20240819053605.11706-1-neilb@suse.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 18 Aug 2024 23:13:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=widip3Dj5UWs8MVGgxt=DJjMy1OEzZq9U8TMJAT3y48Uw@mail.gmail.com>
Message-ID: <CAHk-=widip3Dj5UWs8MVGgxt=DJjMy1OEzZq9U8TMJAT3y48Uw@mail.gmail.com>
Subject: Re: [PATCH 0/9 RFC] Make wake_up_{bit,var} less fragile
To: NeilBrown <neilb@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Aug 2024 at 22:36, NeilBrown <neilb@suse.de> wrote:
>
> The main patches here are 7 and 8 which revise wake_up_bit and
> wake_up_var respectively.  They result in 3 interfaces:
>   wake_up_{bit,var}           includes smp_mb__after_atomic()

I actually think this is even worse than the current model, in that
now it subtle only works after atomic ops, and it's not obvious from
the name.

At least the current model, correct code looks like

      do_some_atomic_op
      smp_mb__after_atomic()
      wake_up_{bit,var}

and the smp_mb__after_atomic() makes sense and pairs with the atomic.
So the current one may be complex, but at the same time it's also
explicit. Your changed interface is still complex, but now it's even
less obvious what is actually going on.

With your suggested interface, a plain "wake_up_{bit,var}" only works
after atomic ops, and other ops have to magically know that they
should use the _mb() version or whatever. And somebody who doesn't
understand that subtlety, and copies the code (but changes the op from
an atomic one to something else) now introduces code that looks fine,
but is really subtly wrong.

The reason for the barrier is for the serialization with the
waitqueue_active() check. Honestly, if you worry about correctness
here, I think you should leave the existing wake_up_{bit,var}() alone,
and concentrate on having helpers that do the whole "set and wake up".

IOW, I do not think you should change existing semantics, but *this*
kind of pattern:

>  [PATCH 2/9] Introduce atomic_dec_and_wake_up_var().
>  [PATCH 9/9] Use clear_and_wake_up_bit() where appropriate.

sounds like a good idea.

IOW, once you have a whole "atomic_dec_and_wake_up()" (skip the "_var"
- it's implied by the fact that it's an atomic_dec), *then* that
function makes for a simple-to-use model, and now the "atomic_dec(),
the smp_mb__after_atomic(), and the wake_up_var()" are all together.

For all the same reasons, it makes total sense to have
"clear_bit_and_wake()" etc.

But exposing those "three different memory barrier scenarios" as three
different helpers is the *opposite* of helpful. It keeps the current
complexity, and makes it worse by making the barrier rules even more
opaque, imho.

               Linus

