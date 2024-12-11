Return-Path: <linux-kernel+bounces-441391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 291B39ECDAD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C153D162FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D742336A1;
	Wed, 11 Dec 2024 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aymncURv"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0351A83F4
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925207; cv=none; b=YjIPaet/LC0JlxTqsuD6nHMYfHk1xvwu9ZOh8Io3yZiXQlX1FEumhQKzv0tUAtqIHYhMYCUENeZTebK4JY6Z1edQa++7+jc5ABdPpbaNWTxa7cLQE7pzQu4+8SUvAM2eWjVbf4D04UZpj+vJIPSLYUwxArhHm3fpOS4Ug1w2wIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925207; c=relaxed/simple;
	bh=mLDfF6DLkAmhFafk0UNWf4nDRiuWWXkbwy0Q4hCTIFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOou/eLaA9FG3VfIr6QEnkUp/asSezPtIsK/oEeRkUcytEtXquc1viYESepuPnTJLIm6GW06CQJKQ0qm3VMGaqYDk+e81SEo08Gfxamw/hNorpTM2GLUS+wKz6WqPPAkefWmq+xlHpwi0bQmUpGgqOOvo3N0tn4YOfCdDhZEmmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aymncURv; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5401e6efffcso3543934e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733925202; x=1734530002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLDfF6DLkAmhFafk0UNWf4nDRiuWWXkbwy0Q4hCTIFk=;
        b=aymncURvUTtKMG/5/fdUIWH51hGXy+7MCPCaCViILq8vuGbBnCNVD/XZJxyEHZnJa/
         nY7oTEpG5ONfoB9XOIUomBl5zX8//3oBaadXP1scZhFdKxDzB79k+ROMaO+LNfS/zVp9
         X3s7WArWeOyP+8w0fbGnt9hipc2ABjBH5GquNSgQMeePmmjXneyqHRTIL89BDt0fqmzs
         3iJAZ+ehTUVOmF4mf9vHATQ9wfKBiYr3qssAoMh8r/oM7P+XPL1J5f/1nScQio+s3PcX
         M7BQzHrcNVcCm7WvN3f3YAHnaHwZRAn8+/DRsH8HHCpBD33VOsiGtjEu4/riQ9fMCuv3
         ZMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733925202; x=1734530002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLDfF6DLkAmhFafk0UNWf4nDRiuWWXkbwy0Q4hCTIFk=;
        b=KhLPCHxxMI1mVmEAUfFCRfd8AzDlkHSOUoQQ+LraZ0t4iwnL3fq1xlDAgy6DgJsFHN
         HZ9bIQcsb6wIRmI1tjFhOVTOHaPtH5q6X24EXSzhnJ4oL6lrY4zXSBmWQ8ZjbenZ9KQa
         jAESdpGiBsBIepz+waJuzuiTSSt0RM+N5GWKMfOu4RxowBQ+WMeV5Msl6FvH0c4txYsD
         Gwmf0hB6/xUqCR2eF25fR9O90GaMKPY2oKywM8Ylz/xcKC9UVQfWp0I+upJWCe1FD342
         pSWatfHYMmr//P3ePDCYeMK3D4hX94Ww1T12UIcpjLNZ2/fP6pOUgJ/MuR7P+t1lOSyT
         qUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7sang0WeLu/TAgzDYAR0rQVDp1hsgR/ZUaiOa0s8tS+m2tEFyl/1ty4IRi3uHHwd7vmEYqJrawup0VUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjRH3TZckwirxRYqav6i/O5AcrazMX9aJjredQC6onvC8k6R+N
	e/3gMHP3phZbdaAWBtEk+cgwcmYezJg0WHbpwi/9JWP7X0glCsC9sAQB09Nnncd4utvuIyHTXTG
	00GVm7NF6R+lGXLRcCAQXsBsSVJ9SIwpzW8O0Lw==
X-Gm-Gg: ASbGnctkEqFvP823a4XeLAMTQOfwX68A9p2FVHE7BBi/YcoYMfiDqysooXbVZqN5jZG
	TYMrp9Qan7LIiccgstKf+Dnjon0enBl9GGA==
X-Google-Smtp-Source: AGHT+IFpSpr7Oj3qJ4QCRaMyoAXW3T3Mn4cdU1emXCSwCgqqhtbRU6US3c71ZX6xXcz95RXUg/DvJ1LdvBmYYHR+JRA=
X-Received: by 2002:a05:6512:3c85:b0:53e:1c3e:34 with SMTP id
 2adb3069b0e04-5402a6056a1mr984021e87.38.1733925202578; Wed, 11 Dec 2024
 05:53:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210160556.2341497-1-arnd@kernel.org> <20241210160556.2341497-5-arnd@kernel.org>
In-Reply-To: <20241210160556.2341497-5-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Dec 2024 14:53:11 +0100
Message-ID: <CACRpkdbsN9WNZ4Fo++FvK+2xxe6VF+66oaBgs4+o3oGUfW4OaA@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: drop HIGHPTE support altogether
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, 
	Ard Biesheuvel <ardb@kernel.org>, Clark Williams <clrkwllms@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>, 
	Russell King <linux@armlinux.org.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 5:06=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> With both x86 and arm having dropped CONFIG_HIGHPTE support, no
> architecture is left using it, so remove the remnants in common code.
>
> It is likely that further cleanups are possible in the page table
> code but those are not obvious from the config options.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Mapping PTEs in highmem makes no sense to me, it's better
that we try other solutions to move away from highmem use
altogether.

Yours,
Linus Walleij

