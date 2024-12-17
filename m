Return-Path: <linux-kernel+bounces-448825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2989F4616
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A2B97A4C93
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1E91DD87C;
	Tue, 17 Dec 2024 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X12dvhtf"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C0F1DD872
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734424263; cv=none; b=qPL3NPtg4oA17iMwKhnninpK6Y4UqCULdy1G6CwKrgCqf57/02DINg2yeOBMhqTD2iCH49VBdb2qonmxXaZyfawo7BAL3mqyPBGLH96FVy7+alenJx2Ij6MJThMERIXj7I2YpKCNPjYd4FqhtcLzJ6IDhsJu6AqTcWV6unKYI3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734424263; c=relaxed/simple;
	bh=abvY1+wffYOIG9PpDbyRle3MZ/J0u8mmXSBkIQOkRV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uo2/g8e5etkUCt8Wo5Ckew5Ao7DUWXFe5KfRw92lczpL5JD1TSxCcVuUCsYN3EGZEqJ8obqtUgiu8FFQ15GGIf/4TN15EMddwgKe1OZNpTnfHzy3L0zQ5wn1zzdeVMzFGWXLESDAnr7x7RTvrq+VDcJUk7ZLhREmhkWhpGnzKL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X12dvhtf; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso3440913a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734424261; x=1735029061; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=saEqunEX3TYOKQAwnsF0CjMAlS0gmeVDyn1k5hQP5xQ=;
        b=X12dvhtfePzbbS5Pbm3wVN79S672q3ra1lXvZPo1w3RpW/3wqpBz0/V3H50ZZsjM4H
         duKepskAA2R9LI97W9Zsmvtb4ZdQQihzVGwrZhzSErjoi9b787Vq41MD2pJnZNLjdXUu
         InEpZjmm22iLF1haK71F8/gSt+yAF3mHEt7KkK5NgesvNRe302P8Ndut+S8b82czJD1O
         BftshBffl533vQT/5MRoXXvvW0GGYbaDxI5KitNVujoGyxaYL2Wj3vc5yAfBm7UYIuuD
         OKEZcmpzTSuzyrv9PHgbR6t67rba7IjbcS4RgZvUHT4c1+BmRqxKuA1aBArolm43qIpp
         e5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734424261; x=1735029061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=saEqunEX3TYOKQAwnsF0CjMAlS0gmeVDyn1k5hQP5xQ=;
        b=cHEcWqfD22j1vMBsZZRQ9siQlUbV05ag8EY+bmxM7FvkqzWvpZwfPlWol4jfIGGn0L
         neId4iiQCpukviL40woIQ4Ts6SbNOmfrcNBvPc6jorj1YqjjKcnOWaKOuvDiltqrNpPl
         X6E86Oo2Zy5w+9roHWHOmgaOr7FEbY2uUXrtvjzuaangsTiAtV1KfmbHg9FraYRM4t94
         aJPZaRvVABEZMXx8dpVokCg5yBQioRdtpKQgAsV02dCvR2zZlwHsrU4/rp56Z6fCW2wm
         GUbD1Ra4AYLh0mdfiVzRVivCL7p9/26FqS9EZLFGmXCb2hJrjJuNFeVFFykdFRvXqdE/
         CuyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhAIUv9FH1wUcVkb9T2H3PUo1jpUmGEeOkTPG9bfNm1O16Z3yYfR25uIZ4GNrN3N/vOB+oZMgqD7uyX/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNKX4kxRQCp0CNaYTYBS4ZstWe2GumKz00SuCt0GK7345tOuTF
	NN+nlhFXmSkXtXzfHPAnCOMLoo6oNNZo2Qy1revx4xQEJH/EC+tKnyouIxVbRqLuFPEeLmv4c0A
	lex4ldjJ7sDPtMs8oNWTQRaJRQOwPiaPLzkZGIOP1OESNTN3cyVPodNg=
X-Gm-Gg: ASbGncsrCR9pt/p/bZeDDGyUeoWXPqq++qSVaoGNJ0SCYJNwVieH0QxfwuSEKFFOxnA
	Wsz4f0XCTm5kBPBUVAD6jkcrBo9lAs5q0aR8fYYuZ6OhhEekNx04MlvqFn7NkiWUFaHVIfA==
X-Google-Smtp-Source: AGHT+IGtjTwFhGJnFNLMLDet8Jpesm1DRqM/0SxZjPBi8thpDlxfIJBVXo2+YlA14mzTB1n9zfVP9EF4kPfA3J/EBNY=
X-Received: by 2002:a17:90b:6cc:b0:2ee:a76a:830 with SMTP id
 98e67ed59e1d1-2f290d9876bmr24674940a91.24.1734424260980; Tue, 17 Dec 2024
 00:31:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217071814.2261620-1-arnd@kernel.org>
In-Reply-To: <20241217071814.2261620-1-arnd@kernel.org>
From: Marco Elver <elver@google.com>
Date: Tue, 17 Dec 2024 09:30:24 +0100
Message-ID: <CANpmjNOjY-XaJqGzQW7=EDWPuEfOSyGCSLUKLj++WAKRS2EmAQ@mail.gmail.com>
Subject: Re: [PATCH] kcov: mark in_softirq_really() as __always_inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dmitry Vyukov <dvyukov@google.com>, Aleksandr Nogikh <nogikh@google.com>, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 08:18, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> If gcc decides not to inline in_softirq_really(), objtool warns about
> a function call with UACCESS enabled:
>
> kernel/kcov.o: warning: objtool: __sanitizer_cov_trace_pc+0x1e: call to in_softirq_really() with UACCESS enabled
> kernel/kcov.o: warning: objtool: check_kcov_mode+0x11: call to in_softirq_really() with UACCESS enabled
>
> Mark this as __always_inline to avoid the problem.
>
> Fixes: 7d4df2dad312 ("kcov: properly check for softirq context")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

__always_inline is the usual approach for code that can be
instrumented - but I thought we explicitly never instrument
kernel/kcov.c with anything. So I'm rather puzzled why gcc would not
inline this function. In any case "inline" guarantees nothing, so:

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  kernel/kcov.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 28a6be6e64fd..187ba1b80bda 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -166,7 +166,7 @@ static void kcov_remote_area_put(struct kcov_remote_area *area,
>   * Unlike in_serving_softirq(), this function returns false when called during
>   * a hardirq or an NMI that happened in the softirq context.
>   */
> -static inline bool in_softirq_really(void)
> +static __always_inline bool in_softirq_really(void)
>  {
>         return in_serving_softirq() && !in_hardirq() && !in_nmi();
>  }
> --
> 2.39.5
>

