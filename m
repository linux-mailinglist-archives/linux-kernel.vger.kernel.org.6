Return-Path: <linux-kernel+bounces-264818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8C393E8C8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 19:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045431F21C0F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3B758203;
	Sun, 28 Jul 2024 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZtfY0LcJ"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741801FB5
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722187492; cv=none; b=H5x3V1Natc3zzdI/miE7htUUT1BdeaGJahW5pdsCco5N0YLnDytIBoeGgyylUad2n7a6t0rALx4mmZLt4yua+l2uEIflZB4Antj87A3ALsLM9aXjwEZuvFl7dbS5/sHKinJZF0bHQPapgKCyOqs+aHx7+asWQEOl2kBWieFIA70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722187492; c=relaxed/simple;
	bh=LfTKmBuGl5Js/wNsuEeAu/4uP1LnjCkOgmeRYjqjLKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iqS4tG4A1VySBLcdfpGSW5+hXZ6hZpX/RqjACqSX6FKRcQ4UaE6Rd+3KzzBbuPxFK+hj5Jgw+j9ZfaJ1Xz3Gz45z3GhLdVI6UB0qQw4yBHE0mle8hnhfF4ugnChp8QR8IlfJ0O7cmGTbNM2paw2ZHhB5AcYRERExVTS8mZ40o08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZtfY0LcJ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f025bc147so3843211e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 10:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722187488; x=1722792288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mS2JdCkxSJZ3nViI33PhWYUnhFwBsNJc93+IrM3FGV4=;
        b=ZtfY0LcJKrW92R7vTpZEgyprEV1PwudAoZKqS9Gd5F0xXOrfxTXn5QWbEta7osQiFI
         HJJDUAqw0TLBI6NLwRhahbQRosjQHglvkzxwBN8nQ5DtPbDKAbfFVhlP+T4ykTAx4p7q
         AS9Ek1hu5xyWF6GTjCM7WjAP+FERYUYZC4+Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722187488; x=1722792288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mS2JdCkxSJZ3nViI33PhWYUnhFwBsNJc93+IrM3FGV4=;
        b=o0dYpzbyKY8whr8IKm1WoMCTqxdht58BXQdxzoaw0NCg6yKj8JwnmHLsrQpCBagB0o
         aVMgL2n+gko8FNLeGl8B4XdAFlQYDJ+/+k/lJc2F7FbtOZ7rnkQPYl1yqGz9BMAAkHHY
         dboCHHi7FlVve//S9LowZe0OxlwUKtfUj9hLgXgrPjCTf1DsEapqOwA2eYUO6wouLxb+
         YoZ0FvssiUEGbNcuHfMCGsRV2E7aIXEcagLur9OkDQt8Yg69hYpAQUQxERsN3gKondj8
         mICRYX9nqqf0jvlhqmLR5aESNmErhVClMbLC542FbA/6gYb9sR/yTDZrfaqDnfNQXgBn
         9VyQ==
X-Gm-Message-State: AOJu0YzE641/1sY9d6yfgly9oyGWeVBXx6GMBG3kcNyNZvW3HrP6AgHn
	9P/PI0ueiPi8W83HZPphIKQg5h8PFdiSbWtiAtgaEWEHU/E5UX7nqTYMijiBlKgET8HLSSOXlmY
	j7EQ4tg==
X-Google-Smtp-Source: AGHT+IEjLR/DBS4a0u7gwgPoETRyIRqyYq+XqqZqlxSRAL3+JZ83kMQcjtb8F/8vmuC+8FxreoG9uQ==
X-Received: by 2002:a19:e017:0:b0:52e:f950:31f5 with SMTP id 2adb3069b0e04-5309b2707dfmr2727256e87.18.1722187488287;
        Sun, 28 Jul 2024 10:24:48 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590e73sm4595814a12.35.2024.07.28.10.24.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 10:24:47 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5b214865fecso400579a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 10:24:47 -0700 (PDT)
X-Received: by 2002:a50:d59b:0:b0:58c:804a:6ee2 with SMTP id
 4fb4d7f45d1cf-5b020bc1a79mr3071758a12.20.1722187487333; Sun, 28 Jul 2024
 10:24:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com> <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com>
In-Reply-To: <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 28 Jul 2024 10:24:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
Message-ID: <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>, 
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jul 2024 at 07:18, David Laight <David.Laight@aculab.com> wrote:
>
> +#define min_t(type, x, y)      __careful_cmp(min, (type)(x), (type)(y))
> +#define max_t(type, x, y)      __careful_cmp(max, (type)(x), (type)(y))

This is unrelated to your patch, but since it moves things around and
touches these, I reacted to it..

We should *not* use __careful_cmp() here.

Why? Because part of __careful_cmp() is the "only use arguments once".

But *another* part of __careful_cmp() is "be careful about the types"
in __cmp_once().

And being careful about the types is what causes horrendous expansion,
and is pointless when we just forced things to be the same type.

So we should split __careful_cmp() into one that does just the "do
once" and one that then also does the type checking.

But I think even if we don't do that, I wonder if we can just do this:

  #define __cmp_once(op, x, y, unique_x, unique_y) ({     \
          typeof(x) unique_x = (x);                       \
          typeof(y) unique_y = (y);                       \
          static_assert(__types_ok(x, y),                 \
          ...

and change it to

  #define __cmp_once(op, x, y, unique_x, unique_y) ({     \
          __auto_type unique_x = (x);                     \
          __auto_type unique_y = (y);                     \
          static_assert(__types_ok(unique_x, unique_y),   \
          ...

because while that may screw up the "constant integer" case (because
it now goes through that "unique_XY" variable, maybe it doesn't? At
least gcc has been known to deal with things like arguments to inline
functions well enough (ie a constant argument means that the arguments
shows as __builtin_constant_p(), and we already depend on that).

That single change would cut down on duplication of 'x' and 'y'
_enormously_. No?

(You already did the __auto_type part elsewhere)

Note that this would require the more relaxed "__is_noneg_int()" that
I suggested that allows for any expression, not just C constant
expressions)

           Linus

