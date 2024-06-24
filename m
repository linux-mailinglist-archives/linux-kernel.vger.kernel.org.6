Return-Path: <linux-kernel+bounces-227528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F4B9152B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D849F281A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB619D89D;
	Mon, 24 Jun 2024 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2nt5naGp"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D819D062
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243715; cv=none; b=EuaVMtCSU5MpJ4uZfey4K1cQylsgit7yLMqj2x1G+f8WWp+2Rjs3XtZRInGzZz/gn8BtYuN6wbk9g24A4tczrBdbO2mBd4LKsphdEv8FzN37POlnSf33dFrAybZGrIjmcJyGfsZgtX22Hdbr/7wNzjTDQQW/Z/o3GChFrh9tk2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243715; c=relaxed/simple;
	bh=ZF0XxN8KntgJA+IVilUh/38LJzSDeR5q7xJSolLUjpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvbI2qEPbKjY+aEOoQ5LJig1kv4zHJEL4jM4XZhr/ILKdDl/HaqCoZ+hDkC6Mk0WzfwLzlloPxYF8z1Ufi600E+w4bm02OwBXVrftXIW/Oxd/3YdPwT25aEAVDH+xK5XChZralTya+IyzI8lJ1tKMs1OU3Akus8yqTQxWZC6UFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2nt5naGp; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-48f409bd157so815961137.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719243713; x=1719848513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XgB/DwN9cphENzre81i4QwsnPfETm68iWHx9Hxb0Rb4=;
        b=2nt5naGp9oxCa/XLwgmwcjxgFaXjYWSB8SZP0UZcCgYgndMvLhQOdPIwSN2ix7iJc9
         Iv0vfwYAUQ+u6pQhOWeTfhPNBzvO59h39OK2aV3dSJGeB8uejhLqA4eQ2R2XOmYd7k7O
         BrG/+C8UljmcU0NlGeXLlA+juZFKZW5ULhhQVUNkhKqwwHP1wEyMbNHsrGJcttUEXxdY
         L0Yr8B7+o4JwGR3ZfZyIYvjShk9RM7fnql+jIV2Dkeqaw0ft6PbgUqSbRfoGnjZYV0cO
         6ynWLb11O5eldiuLuble748m0Yu90QeOTpryw1Vd7BsD+z1UDvVeKU7PIJfApJptQRjJ
         /QfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719243713; x=1719848513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XgB/DwN9cphENzre81i4QwsnPfETm68iWHx9Hxb0Rb4=;
        b=C1o3pmAi6Kb12Y5BD5wy1TvACFahiixwU/ThSMU9GXHghbgWBZ9MhHqaYtrDZIyqlG
         2MgOk8PUTOdupsFB8XcxfZI3e9qldsYK/KJh/Flbx4m6XJWCiR78vG0pAmms5U9egp4E
         FMDHRp0hRg6+7FZrgZyUFSQgxrc7jFVxsBECG707szgyCNDDQjPUk85608WoIucfXIHo
         yGDFjVJgNm7jEaQ1tFS3WuoHCkrrgBWQ3B1Oe++/ANApnSjo3Y1DEw43qfkdqmeys4Is
         6XSSRxFtEEKGuVi2mb2IdGdtrH9jfue4cuxHW5SuJdZDZE0vSuZMT3zPsIFEEgScHjSe
         BUew==
X-Forwarded-Encrypted: i=1; AJvYcCVClszDB+WBBdUraCSWxI++3ARWgaQlCocftE/qf7i/0r7i7YZO80tiDqZyj6vZiVU7TJg6bqydbnRpaQMcQIjqs2Hv3iCOrlmSn6cb
X-Gm-Message-State: AOJu0YwifCIrlrxT+8AII05oeibPRIn4KwIAkNq1Ac9jbx4zMzBX4XlG
	Bpc0nEBnqC8LmrYj6DsLGDNgpgAJr20VYpK8lSmHiNMlg5cSmPSRN2RCsWB3kLuqmwwMcHGCKtX
	AronPLKJphUaYJVNua47lliG4v8xzz3fdfoV4
X-Google-Smtp-Source: AGHT+IGnuWw7iW2l+BtMoSMyKLPH1RIsnNPbQ5cNHSWZt2as3tbAnI2PoOeCh4RRwK6qwksnQG83NrdZXDBBrVL/jv0=
X-Received: by 2002:a05:6102:34c1:b0:48f:4580:ca67 with SMTP id
 ada2fe7eead31-48f52b8daa6mr4256576137.32.1719243712596; Mon, 24 Jun 2024
 08:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f214f15e-4a0a-4f24-9bd7-8f84cbc12e5a@p183> <CANpmjNO=zv6D807cNLAQ3eGLrigUs9xtYNxoHhyuYvHkhhSUWg@mail.gmail.com>
 <2aab04d1-c16b-44e4-a283-7bbf8cba28e7@p183> <CANpmjNMZU=T6J5OBpELxB=ZqOnrkou2iRG7zaqoNy7bCGgH9hA@mail.gmail.com>
 <fb62163f-ba21-4661-be5b-bb5124abc87d@p183>
In-Reply-To: <fb62163f-ba21-4661-be5b-bb5124abc87d@p183>
From: Marco Elver <elver@google.com>
Date: Mon, 24 Jun 2024 17:41:14 +0200
Message-ID: <CANpmjNMbLBLgy4-BGQYLkDcYO+vOzgq3ht41xzasEJ=x=o18Kw@mail.gmail.com>
Subject: Re: [PATCH v2] compiler.h: simplify data_race() macro
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 17:39, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> -Wdeclaration-after-statement used since forever required statement
> expressions to inject __kcsan_disable_current(), __kcsan_enable_current()
> to mark data race. Now that it is gone, make macro expansion simpler.
>
> __unqual_scalar_typeof() is wordy macro by itself.
> "expr" is expanded twice.
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>
>  include/linux/compiler.h |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -200,10 +200,8 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>   */
>  #define data_race(expr)                                                        \
>  ({                                                                     \
> -       __unqual_scalar_typeof(({ expr; })) __v = ({                    \
> -               __kcsan_disable_current();                              \
> -               expr;                                                   \
> -       });                                                             \
> +       __kcsan_disable_current();                                      \
> +       __auto_type __v = (expr);                                       \
>         __kcsan_enable_current();                                       \
>         __v;                                                            \
>  })

