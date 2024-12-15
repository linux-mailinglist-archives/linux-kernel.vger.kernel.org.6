Return-Path: <linux-kernel+bounces-446297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A13599F2241
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 06:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C471663FB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF5710957;
	Sun, 15 Dec 2024 05:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VJ1PgtmM"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607EC79DC
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 05:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734239964; cv=none; b=W+ckXa/qjXPxH2tZLYdIQeunX7cT5a0/B5tXGo17Dkk8yl8rj+cF7CB0ZdqRuwbxjSt61Ah/SRYrtqqxYbNNfeDHdSSUTksl1isnpjSh9vcwTKttGxLBSJOQZHvdWDcrzJEzl/u+2qX26w43up2wOQTjozHbfYxPnbJMQa39kDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734239964; c=relaxed/simple;
	bh=plRPBq7ASTDvAPVhEFqMLnmfkdr9J3nRihvlX5aA/Dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9Udjpa6mKA6RKBv1XS5tOahW3XOdAUORughcc5qbSKGfjMep4hyjmigyYymFVnjt58x7DqtiZLq6w77uVbkF0nlwz/L4FhHqTM/ZdhHpJkdt8XV0QEePSRAq91XKitIfTzW7TpWEqX0YeDeQUupBDfVccp4SQcX3yYt/4bjM0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VJ1PgtmM; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d437235769so5205209a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 21:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734239960; x=1734844760; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+GtrjhtrZa8UpJ/3eJcf4PBIGLhAtNPvkgEuXPSYFaw=;
        b=VJ1PgtmMd2A0Qk8IrIdgLEyrWVU4SWSQb1JciS43wgp8DLbLt3KWnutxKgk7oWR0nG
         NhqeTbLpBYQqZuko2JHbtxHrkhIR86JZsyXKT7PZUp0SsUyfAAN69CKjJVAae6QoBa9Y
         4wy9vnIW5T7n/UJg+G8G+Itn/XoUWC0bjNLZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734239960; x=1734844760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+GtrjhtrZa8UpJ/3eJcf4PBIGLhAtNPvkgEuXPSYFaw=;
        b=amUXmQiKhncCT9eayDFlDrv08xL8j7TqP9CejNA5yd76Ijf6m6fTgfKCN/zEUY81f6
         c3np0kDMykOSK1ASQKe/bj08fxOYpqqEO0b1Z3CeKAbYA1w+5B7lhVFLJRgKcoHcDuX3
         tVUJLrupWCq3fKpOfcQ3P54Dl7DZP9B4N1VlvbHUd/CJ8KxP5dfW9GmymUsEbq4741le
         0Ecl+jXf1Z1TeGZhlcRsKv6QGcxe1qV0+ZXXFMSQiMSVzZ7Txn6TR+PxBaIHAbIuDTzH
         1xg1hILjwtN7DyQjZ7WcCCn8DKM6Psib9y1iJyo1EW4dqHkiTuvqjtHHjwORxAHzolb+
         iwFw==
X-Gm-Message-State: AOJu0Yzbq6DwhgsxTiQ9XJuOGXoqXy7t+YWhWVz8BxcCLW4q9QfX4gg8
	vc0xR23JV3FzaKPX+/jrQOtM04+llsmPiItAYpcolOxxEmrmbol6/uA52C3lesasmejGKabSfyL
	0PWs=
X-Gm-Gg: ASbGncugdEE2PgpbcQ8vA42g9n+AwDHaY8QQwf41j2Mj7N5yQdgbq2XolhK5yqkP1EC
	4dS49HJdzGxUUxAe77tcvKlKDJiklXqtMqbSJlgUyunUfD3Cj6LzsOF5Qy2cHantgM47v1lrbRq
	rWrlBvwOn2YBXEhHZlVarlcEnfJW/wP1dMGdlBZfFa1oVjT66MKEfDkeuElZAAni0TtnKsl8T0C
	tooUktad63aCSMg9Nee5wQeevYkk/NJarZioujr8V9K94OtboNpTJ5Ixf90ZZYlFBKOpgbbr3gw
	c8b3BnL8WmSHGKDu7xv/yUz5epO8w8c=
X-Google-Smtp-Source: AGHT+IH3Wg1YKXyB/aSXT+fuOLWBu05po28T10cqmI69WYgWvURZDiTr1J5hrwbkWZ9P/fNBSoV+1w==
X-Received: by 2002:a05:6402:1d50:b0:5d0:bdc1:75df with SMTP id 4fb4d7f45d1cf-5d63c3b3bc3mr5936216a12.24.1734239960411;
        Sat, 14 Dec 2024 21:19:20 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ab5114sm1736913a12.5.2024.12.14.21.19.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 21:19:18 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa543c4db92so612197666b.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 21:19:17 -0800 (PST)
X-Received: by 2002:a17:906:c142:b0:aa5:4672:663b with SMTP id
 a640c23a62f3a-aab77eaf931mr789801366b.55.1734239957671; Sat, 14 Dec 2024
 21:19:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214182138.4e7984a2@batman.local.home> <CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
 <20241214220403.03a8f5d0@gandalf.local.home> <20241214221212.38cc22c3@gandalf.local.home>
 <CAHk-=wiSdtNvq_wUtq7f3oO7S7BYCeXh7a707HKvK9nVkxR=jQ@mail.gmail.com>
 <CAHk-=wh3cUC2a=yJv42HTjDLCp6VM+GTky+q65vV_Q33BeoxAg@mail.gmail.com> <20241214233855.46ad80e0@gandalf.local.home>
In-Reply-To: <20241214233855.46ad80e0@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 14 Dec 2024 21:19:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh3uOnqnZPpR0PeLZZtyWbZLboZ7cHLCKRWsocvs9Y7hQ@mail.gmail.com>
Message-ID: <CAHk-=wh3uOnqnZPpR0PeLZZtyWbZLboZ7cHLCKRWsocvs9Y7hQ@mail.gmail.com>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Dec 2024 at 20:38, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> So what are you objecting to?

I'm objecting to "we wrote bad code, so let's hack it up some more".

> The current change, or the code that's already been there?

Both.

The current change looked so random that it made me go "WTF?" and then
I looked at the code it's changing.

The code is literally making assumptions about how va_list arguments
even work. It calls trace_seq_printf() and expects that to keep the
"va_list" argument in sync as it walks the argument list.

The code even seems to *know* how hacky and wrong it is, because it
does a RUNTIME CHECK for this in test_can_verify(). But that really is
just testing one random implementation. The whole approach
fundamnetally doesn't work on some architectures at all, and on others
it would be broken by seq_buf_vprintf() (or vsprintf) doing a
va_copy() and using an internal version or any number of other things.

So the code IS WRONG.

It's wrong at a fundamental level. The thing where it modifies
iter->fmt in place is just a detail in the bigger picture of that
function being completely broken.

It's literally hacking together a really *bad* version of KASAN
checking, re-implementing 'vsnprintf()' *badly* by trying to use the
real vsnprintf() for the heavy lifting and literally hacking around
corner cases. And when I say that the "va_list" handling is buggy, I'm
*not* asking you to try to fix it. The va_list bug is just another
symptom of the deeper problem in that thing.

This is why I compared it to the tracefs situation. It has exactly the
same pattern: fundamentally misusing core kernel infrastructure,
hacking around it to get something that "works", but that is wrong on
a fundamental level, and then adding more hacks on top when some new
issue rears its ugly head.

I absolutely believe that coimmit ff54c8dc3f7a fixes some behavior.
But I'm looking at it and going "this code is not salvageable". All
you do is add more bandaids on top.

Do it right. And honestly, "right" in this case is almost certainly
"get rid of trace_check_vprintf() entirely".

The fact that you basically disable the thing already with a static
branch when 'va_list" doesn't work the way you want is a BIG sign.

Just disable it unconditionally.

              Linus

