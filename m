Return-Path: <linux-kernel+bounces-522422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A79DA3CA44
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53EA16C3F8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B35E23F277;
	Wed, 19 Feb 2025 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="aFFf5E0T"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EE423E25D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997686; cv=none; b=dXyw8fC67nuY1OtBFapOnsaPu/7L/BFZW9p+Q7gxg7zx4zVeh2QgMUu/6Ebr3YT2oGL7plL2rZ2Z+c/+K8kNPAa6gBRj7eTN2EgjL7xsQauc3/HPFAt8rzGQ1uQYrgdfyZoQ2uoWzxvmKyPkZadSdvQoSsd6YVl1LDoUg9wsa00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997686; c=relaxed/simple;
	bh=yraqLzxeh3b7rHBkfWikDJTuU2Al31V4abfQMTxxX+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4hwefdXyonCyIVjwrVlq/1URmPsEJ0MJ6OPsHmc7eJIyQSfHOckOeZ7PmqrclSsV2Sfn/bmfdrVg8u+D7d9esjRrk+X5llUuXIEoHPm4+wcEz/G5bmRt//vaKHmGW6Z7715Yg0gz51hEm/XvMgrQUmFkFYBtE91Oe/l5qhRLZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=aFFf5E0T; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so263418e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1739997683; x=1740602483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uQWKjia1YEhq+PMd/nXG3fmWx8U4DeTtcDG7C2yzBs0=;
        b=aFFf5E0TbbeY458Z9UzEsHOuY7ODrnElgD0n6dJGfFByXQrWHVGwEpKnfSeszFKsV7
         AGRksw+ey2P6KIbO5UQnmAUBI85bLyc1XDyEz751AoAX/vFsg0xP+6ThgGmHaW7W+mlM
         B3QjmiAqzsGijt7WbPI93NjIl/OcsniAGoaYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997683; x=1740602483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQWKjia1YEhq+PMd/nXG3fmWx8U4DeTtcDG7C2yzBs0=;
        b=oDLMoO4f7Z7aejTv18072MjpL2QnJfE1lvhA+ST/aW0iYf/gsnGRUe6NSm/TjV6OhK
         VGoQgPlb2/LfXQxlBJaid92Eb4UtxMEnqU5WbCwEtmq32Bci9PwgMSrcB2GzmLIBd4Wu
         d4lvFAl2MIYYr70wCRGVnJe0u0J0C9flSwSB/aCUlQIWKXZHeWTJIcXCfIuB3uEZFV74
         zAiFOAwqL/qNdnqobNjkQ+0xT7jKo+lIsx0d+rIGgf2c22gRY0Cj8+fdksibNo3WZwkd
         6EbSYwQGI0UnqJce4x6AOK5JShiuJqbjuxzJjoKpUGWT/oItFEl2I+hNfvqnuYDYdKAl
         Hg7w==
X-Forwarded-Encrypted: i=1; AJvYcCVyoVnjID4DOiDlsQ6PEIsIGLQIIiHgUGKn0yKmuNVDE92xCIINP4X03/IlGsYOGcvUOkafpyclaBmgssE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGmoYFP81tXwSu+WUd6Pv0hWqmp18sf/PZPH0uSlXoXrcw8KpV
	IHLJxHucANDaM+pZEqP78tUlwreyaRZV3pVy9oS7lNDVO0WpF6fV66LlMmw3HKLn7JJ55tVoPfu
	+cRtcNquGKPgthUyFitxaYHzUI91PnbJVicLu8w==
X-Gm-Gg: ASbGnctx++I2gOQgYYhV4Em+x0XixVqIklYgFO1xYqwfEOzxIRtAc6cm40ds1xMssPc
	VXWXe0zH6DAk4glKqng4WDi5LInhXORw8OFO3MDrZ3/nzXWm6l6vOffZKTiZXa07WfcyneWt6
X-Google-Smtp-Source: AGHT+IENNNpeaMlkD/fiQQAYZ6iJNFdOYrpRNg7fkEna3OdCDK3VAQtFcLuzSuMXXgumt+4ZaeEHehD2gwq2A0TLKZo=
X-Received: by 2002:a05:6512:2398:b0:545:ee3:f3c7 with SMTP id
 2adb3069b0e04-5462eef4e56mr2154420e87.30.1739997682815; Wed, 19 Feb 2025
 12:41:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-printf-kunit-convert-v4-0-c254572f1565@gmail.com> <20250214-printf-kunit-convert-v4-3-c254572f1565@gmail.com>
In-Reply-To: <20250214-printf-kunit-convert-v4-3-c254572f1565@gmail.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Wed, 19 Feb 2025 21:41:11 +0100
X-Gm-Features: AWEUYZnPvEz-Qu0Q_eOs4K3mND8N5X48foEj8aBLKco5JWWCbd2AeY_UnbAb5oM
Message-ID: <CAKwiHFh52-_ssWjC3wdtZ=92AHAw7grnDugZpmf7T962VQrEbQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] printf: implicate test line in failure messages
To: Tamir Duberstein <tamird@gmail.com>
Cc: Arpitha Raghunandan <98.arpi@gmail.com>, David Gow <davidgow@google.com>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Feb 2025 at 22:53, Tamir Duberstein <tamird@gmail.com> wrote:
>
> This improves the failure output by pointing to the failing line at the
> top level of the test, e.g.:
>       # test_number: EXPECTATION FAILED at lib/printf_kunit.c:103
>   lib/printf_kunit.c:167: vsnprintf(buf, 256, "%#-12x", ...) wrote '0x1234abcd  ', expected '0x1234abce  '
>       # test_number: EXPECTATION FAILED at lib/printf_kunit.c:142
>   lib/printf_kunit.c:167: kvasprintf(..., "%#-12x", ...) returned '0x1234abcd  ', expected '0x1234abce  '
>

Actually, I'm not sure that is an improvement as-is, with the two
different line numbers being printed. It takes some thought to
recognize which one is relevant and which one is not.

Can't we have a variant of KUNIT_FAIL that allows one to pass the
file/line info when the caller has better info than the location of
the KUNIT_FAIL itself?

>  static void __printf(5, 0)
> -do_test(struct kunit *kunittest, int bufsize, const char *expect, int elen,
> -       const char *fmt, va_list ap)
> +do_test(struct kunit *kunittest, const char *file, const int line, int bufsize, const char *expect,
> +       int elen, const char *fmt, va_list ap)

This can't be right, the __printf attribute must be updated accordingly.

Rasmus

