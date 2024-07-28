Return-Path: <linux-kernel+bounces-264811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D36A893E8B0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 18:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845A32816FF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 16:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EB858203;
	Sun, 28 Jul 2024 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hg5xyTC+"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F0C6FD5
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722185846; cv=none; b=PuEdYaXs9cPjRyZd4gfJkl+tQ6KXkZG0EqJQH4VXJLvZ7Y2UvI0Y69uDZ9+ochJ6QbtJU8K8UMw+UbQfkGjN1jaRnT6Yl0XYX6vE1xqoZnlZJ1hMMmg0OROQNfHKMaeCIusoEZx7rHmcaAlYbMkyhohH4BzMwI+175+VJXQWZvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722185846; c=relaxed/simple;
	bh=x8snrZvy7qqfWcPL4D+4iazHY+cNsrtO96qR2r9AZxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFIAVSErqQ3LInRBnZRWGa27YEDheUFZ7bDkohvcsNxjQ5S3LutRYtHkzXeaIPoHf6plZDrPdWiJ4z38VvdVTgBkMZVBtaPo8AwAu0cpKXcHzZoOdZJob6EiJOTR60a3eN+KLRfPrZcroIzSsWXiNlAIv9DCyn5ADZCmEATwVqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hg5xyTC+; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so43517381fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 09:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722185842; x=1722790642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g9SevfUKt73kXPb/ImW5YVNB1cegaWMrvDCx6UH1DIs=;
        b=Hg5xyTC+HXbrpnfVE0XMhEWARRtX4vKqLxgMYwZk4e8tIdCUoTDxp4xpPjLGFpFwND
         u/A/2hZEzqXFwAJaqazXDBJAdxh/Ww8SOfxXw9jDOq5LzMU1InywVHMVkqS8xUF1JXDP
         FFNRPNg4r/pnI7ttjGORcpLUlCd8JyIz5z7+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722185842; x=1722790642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9SevfUKt73kXPb/ImW5YVNB1cegaWMrvDCx6UH1DIs=;
        b=n3ND6BeTCehFv7I7ieeJrleXbqTdiOPYE07dPNW2e4aTT9aNtKgP0JVfGvEJYeJ3ka
         86O0ujCFV/I+/bnxOvvjosZKK9tVbVEbxhWDu9jccOu9gyLTpyC2Jm2Svt4ALD6R6c15
         bLm69vgSHzxDv7FPCvgHTFM3Qo2f2N+6gC4axI/S8DcJ6mRtSk+q0Nj5NI/khpfwdFSr
         MsjS4LGQ2F0u25oU88tB6ag4U2qwD2cnmySHIZO6E3l1xf/TnrwEAOnxRFGqpylrCmGy
         JbSqoOlWX73riPgT5/gjmh+LwvQfPZ/um8Jn6NMdhuVO6sGyudq+pClB0XbWRv3ZSfv4
         yu6w==
X-Gm-Message-State: AOJu0Yyfs08eQp4l+yfs4014uczyNaR3gZ4+sr2STb5FlVQERZdeBgxI
	Ea4Rv1WYC9815uJetOTDTLsYV9XeXHAe6g7yRv33P9t8UX/8pGZcx8BIr2wc8Vx7u189/tCfiTq
	r7QRQWg==
X-Google-Smtp-Source: AGHT+IFSiQTk3Yykm5FaAUq4930enILDf0xksJbeiHLcAm3sMIZwQ21TsXQqcxDBIafbtuztS/iCfA==
X-Received: by 2002:a2e:720b:0:b0:2ef:2658:98f2 with SMTP id 38308e7fff4ca-2f12ee1bcacmr37245001fa.33.1722185841456;
        Sun, 28 Jul 2024 09:57:21 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590aa3sm4552951a12.31.2024.07.28.09.57.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 09:57:20 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a10835480bso4258425a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 09:57:20 -0700 (PDT)
X-Received: by 2002:a50:a41c:0:b0:5a7:464a:ab9 with SMTP id
 4fb4d7f45d1cf-5b020ea8da9mr3235857a12.21.1722185840503; Sun, 28 Jul 2024
 09:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com> <74e0b027a908461da879b69b0e12c0de@AcuMS.aculab.com>
In-Reply-To: <74e0b027a908461da879b69b0e12c0de@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 28 Jul 2024 09:57:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjbP7cTOYWusAS-Zg8_YbVBGrNLmJBg3wrhKN7C09CsbA@mail.gmail.com>
Message-ID: <CAHk-=wjbP7cTOYWusAS-Zg8_YbVBGrNLmJBg3wrhKN7C09CsbA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] minmax: Simplify signedness check
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

On Sun, 28 Jul 2024 at 07:21, David Laight <David.Laight@aculab.com> wrote:
>
> +/* Allow if both x and y are valid for either signed or unsigned compares. */
> +#define __types_ok(x, y)                               \
> +       ((__is_ok_signed(x) && __is_ok_signed(y)) ||    \
> +        (__is_ok_unsigned(x) && __is_ok_unsigned(y)))

This seems horrendous, exactly because it expands both x and y twice.
And the "expand multiple times" was really the fundamental problem.

Why not just change the model to say it's a bitmask of "signedness
bits", the bits are "signed ok" and "unsigned ok", and turn it into

  /* Signedness matches? */
  #define __types_ok(x, y) \
     (__signedness_bits(x) & __signedness_bits(y))

and __signedness_ok() simply does something like "1 if unsigned type,
2 if signed type, 3 if signed positive integer".

Something like (very very handwavy, very very untested):

   __builtin_choose_expr(is_signed_type(typeof(x)),
        2+__if_constexpr(x,(x)>0,0),
        1)

Actually, I think that "__if_constexpr()" could very well be "if known
positive value", ie 'x' itself doesn't have to be constant, but "x>0"
has to be a constant (the difference being that the compiler may be
able to tell that some variable is always positive, even if it's a
variable):

  #define statically_true(x) __builtin_constant_p((x),(x),0)
  #define is_positive_value(x) statically_true((x)>=0)

and then use

   __builtin_choose_expr(is_signed_type(typeof(x)),
        2+is_positive_value(x), 1)

and yes, I realize I count zero as a positive value, but writing out
"nonnegative()" is annoying and we never care.

I guess we could say "is_unsigned_value()"?

       Linus

