Return-Path: <linux-kernel+bounces-242836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3458928DC0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7711F2287E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908B816CD0B;
	Fri,  5 Jul 2024 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OZONzqWk"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB6018AF4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720207297; cv=none; b=UfvF4/34vojndkHiwTHrvJOjKmTm9yR/U2jVBbEFcs0ksVRChh9U1pOx33mCwER2QRXXSBUwwvKI4tWnzHCtHoixjPgQrbX+mQVlSGhVw+jXiHctBbmrcYRLGUw8Xkfkh/58wV5xXNjkBfLGggz6rq/Bls/PMpVqzpoocdU3s2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720207297; c=relaxed/simple;
	bh=PRXnaV7MIMwf++Wdfw7SOpGoIAw3Fr8eBVKEQVN+eqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+7nans//IqaJsawT0ysL9zPdSNlIgRtbHLJGVo/OB9rrdRX99HdR255e6x9NvTwliVkh5X+K5SzJklJBTMxyCB96JP9lWvHD51knWKc8LtOv2GFJJTgXSUMo3Gc4pYRS/+4siigLfOqbsCEhIEOyv/PK1G+0oql0sUyPqTO2MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OZONzqWk; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58c2e5e8649so4454630a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 12:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720207294; x=1720812094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mLOgGG6O0l8XWVdtptUbe8WUTKcreUEv0SAn+ce8BwM=;
        b=OZONzqWkV3KSpQkbo6lab2TNmbjKlnQH6/jNZFkB9RACyIDD6pL+QYQkqvQvN80KSP
         lTFD9K5ZDD1Gmt0bYzMD65icKJF8oKtmSYEqpn7wh/0knjhWzdcpqfZ52o2yFLt7xHv/
         yYpy57QCDzKjtd4zDiswDMuDyhfH9MnWxkggs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720207294; x=1720812094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLOgGG6O0l8XWVdtptUbe8WUTKcreUEv0SAn+ce8BwM=;
        b=AsR1Ps3nu/An9uh15heKQVegJZzQ1UrbfWkcAzTYmVVev9tEqdySw7GDqE74NPHQ/t
         EU4Uma3lB/a/G+RPi5oD/YYnFgq++7TTUXBySrQcfXdSZ+7kBFhPAY/sr2My/Ooz1GE6
         bcCgTknNAOpUWqo/chiATqzpYbvbfw8NeSxt+JvHM31+5JT6HGinXlLZx0Hn+1viGN77
         z9vj2VCDvDEr85NM8xP6e1G1E3rSP2I5Egu0fW9lwbzBY4t8Z9x/9I2D1fIrIGZUmmAA
         U9uQjBEnWKaHHsRQ/zlopgjlRdkSsLDC1vMTOUR5oBopwFQpEIPbJpqXYHibUgivtkfQ
         61RA==
X-Forwarded-Encrypted: i=1; AJvYcCWghkykBJjo5DMqJ3+UCTkHov1IEuqSX/wXdE9UQWeHy9OI5Sk6D+z+15gV7Gri+mA2+9jBMHrtRGCIQw4gKxk77dqH8jmcifPLu8bC
X-Gm-Message-State: AOJu0YypdTtlDjZ22p2XYR07RILNnJqVZDDYImL2Pjd8jfym4mkHWWIc
	5FVdA1OFGF2D0HNVdH28rBuNt5n/FB3hw0SQ7SUxhlpO+BYAm72rP1iquB0lM/4qvQlMWlVKqRy
	gnM0=
X-Google-Smtp-Source: AGHT+IHpKWolX5pxxTxat/osFdROW3LfI91vtf83kyI82DRdd+7i8VIu6uW/EtQqDkyifmKRIHmyTg==
X-Received: by 2002:a17:906:17db:b0:a77:cd4f:e4f1 with SMTP id a640c23a62f3a-a77cd4fe87dmr220396566b.27.1720207293625;
        Fri, 05 Jul 2024 12:21:33 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77b8eb56c1sm155903266b.176.2024.07.05.12.21.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 12:21:33 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77bf336171so289355666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 12:21:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXs3kgBJ/MsXsNRSxRXj34bGHZjQrJnrfgoCMLwcPicF4IqKdxsW8u0YjcLQgr03GUvYO3TiwGLKZWYF0lKhEs1be0aovuiCR+6T+b6
X-Received: by 2002:a17:907:96a5:b0:a77:ce4c:8c9c with SMTP id
 a640c23a62f3a-a77ce4c8ee6mr278446666b.8.1720207292581; Fri, 05 Jul 2024
 12:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgqD9h0Eb-n94ZEuK9SugnkczXvX497X=OdACVEhsw5xQ@mail.gmail.com>
 <Zobt_M91PEnVobML@zx2c4.com> <CAHk-=wh47WSNQYuSWqdu_8XeRzfpWbozzTDL6KtkGbSmLrWU4g@mail.gmail.com>
 <CAHmME9pgFXhSdWpTwt_x51pFu2Qm878dhcQjG9WhPXV_XFXm9w@mail.gmail.com>
 <CAHk-=wjCmw1L42W-o=pW7_i=nJK5r0_HFQTWD_agKWGt4hE7JQ@mail.gmail.com>
 <CAHk-=win2mesMNEfL-KZQ_jk1YH8N8dL9r=7XOLp28_WMazpVg@mail.gmail.com>
 <ZogcxjLv3NAeQYvA@zx2c4.com> <CAHk-=whRpLyY+U9mkKo8O=2_BXNk=7sjYeObzFr3fGi0KLjLJw@mail.gmail.com>
 <ZogzJCb66vwxwSLN@zx2c4.com> <CAHk-=wgH=d8MUzJ32QNW_=KDQz7U5g_1Mm9sR9zB1iNUpxft7Q@mail.gmail.com>
 <ZohB6uPAVX03Sc96@zx2c4.com>
In-Reply-To: <ZohB6uPAVX03Sc96@zx2c4.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jul 2024 12:21:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgC5tWThswb1EO5W75wWL-OhB0fqrnF9nR+Fnsgjp-NfA@mail.gmail.com>
Message-ID: <CAHk-=wgC5tWThswb1EO5W75wWL-OhB0fqrnF9nR+Fnsgjp-NfA@mail.gmail.com>
Subject: Re: deconflicting new syscall numbers for 6.11
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jul 2024 at 11:56, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> And if we want to exceed that size in the future, then what? Just seems
> like hard coding it locks us in.

KISS. Keep It Simple Stupid. Make a sane decision. Stick with it.

This is *not* something where things will change radically over the years.

But what this *is* is something where we want to actively avoid
overcomplicating things.

If saying "the state size is fixed at 256 bytes" means that ten years
from now, we won't be updating to some super-duper fancy new algorithm
that wants to keep a huge state size - then that's a GOOD thing.

We are software ENGINEERS. That means that we make sane decisions and
live with real life limits.

We know that we don't have infinite entropy, and we understand that we
can't even know how much entropy we do have.  At some point, you just
have to put your foot down.

Leave the people who have theoretical concerns behind. They can damn
well do their own thing. We should not care.

If somebody is unhappy with the result, let them go make their own
random number generator.

We've used the current chacha state for what, a decade now? Just let it be.

                Linus

