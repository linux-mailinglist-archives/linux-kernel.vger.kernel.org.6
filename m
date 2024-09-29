Return-Path: <linux-kernel+bounces-343041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A53989623
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05549B22FC5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 15:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657EC17BB07;
	Sun, 29 Sep 2024 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fqo1V1hU"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15239178CCA
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727624165; cv=none; b=jjumTDJQ/AJCyXBG26Z3h9MU9Me+0Wl88Qa77917AQtjRcfULYUJIPAso+YIW6qE67duFBOCdOBU8H+cteaycMkKorZFqmJpgn80Ps8tIjJOCCLDDsBteQCmhJkFEg5aUQtmR1dCTR/IBf8Isbvu/VY+3pMJkBi/CBqcC5Y2Dbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727624165; c=relaxed/simple;
	bh=Z24+oNbwDBYDjUFeXrH3yiHjyPp8DkpOlh8f85DEeEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRoLnSn+BV4PV2DR5YxkqccC4YwxorKiX9VUyiTW1q6UIrkBxmAbSOL9/WWn1P1gggxkn6SEFTjOCyQgQP2Hvp/jgtKgENWXGrGbdgqaJ2Tilzhpqi++NFASFJFtrPgRwk++yw2zFvpFnlGE552V/EmkKPRTPGUOPqncllTbK4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fqo1V1hU; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so578649466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 08:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727624162; x=1728228962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7aEO2yZHG3E/MlCpO8gpWwrr+WlYuH7Zy33FEPXBtWU=;
        b=fqo1V1hUfxbJqSzJxUGEcLRxrvSPEX5uFlgKrS3cSqCvu5f4rlHl8/Z7d03nIaLuGA
         +4HBtebXlB8YAAEI+3v43wq/kkxSYudsZVKH3KJ879EK67mDsTVcnCyLhLftb73fvtoA
         v+/fgneKnMGYeDHpWsxgEBqxN10oQRSIak+Y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727624162; x=1728228962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aEO2yZHG3E/MlCpO8gpWwrr+WlYuH7Zy33FEPXBtWU=;
        b=e8ciR4x5wub34ShyuJPBVHU0AJ7S1v3imuzM/q7Xp9nhAjHrqXdqHc9WL4/VPtvP1K
         1BHQjwcssqBCVTzGClmgQHNxhmuoUVqQ+cU85uGhGXySIQodpNCyHGVjtG8wJ9aJW6b/
         KKQklw7DbJjCxPtlqNzokUlkFhIUte+57k/mH/xTjlkLBahFbbeTdWW7c69OZcZKCdTD
         Wyxl4qQu4q6kKPIgKNxP2x8KnZZnTAiJWzMlJ4oVI2ACFEiKz+nhqzvk1u+KpH1h8+5M
         8QeXRj3AE78qbXcTUlX6Uy9F1YMcecdnzgLJeotb32OW3GDCdWgsFvh6uLYiWkXb0fUC
         8QEA==
X-Forwarded-Encrypted: i=1; AJvYcCUZVBAsDUyKoRgbSMS8wWwFlrrAF9sQM53ua0cXR5jLZLKwSCXUzQ501VO3iMgqigDFi1G4LwPiuLTvqBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5osNeE3ZbTz1UOh3edgRgxgH4pf9cZKHr3DXQ/8ngdzXEFYLX
	z1NoeZIYpjORi5rH7sWZE2icYqbUR4qT9ZKAmuxoYvrZ9M1K8MGxIAuE0ebjUs2Orscl9gqU0+l
	1CP8=
X-Google-Smtp-Source: AGHT+IHPvrfGwpdmL09SALHOR1O4kQp3x/Dzyq6tUijxrPTQBf2jLl9zfY4qKkDf30ryjO00uXUlwQ==
X-Received: by 2002:a17:907:1ca2:b0:a8a:7027:c015 with SMTP id a640c23a62f3a-a93c4ac9388mr945191266b.56.1727624162053;
        Sun, 29 Sep 2024 08:36:02 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2776debsm386708266b.34.2024.09.29.08.36.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2024 08:36:01 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a843bef98so504949966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 08:36:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxcRyOsAgT8ZRtbTAIrSCUew3Cbl7GU7FTocTUGue9Dwv7tDFOjEHw7HnA/OehhzdOG3BacGsdcoE4S7Y=@vger.kernel.org
X-Received: by 2002:a17:907:8692:b0:a8d:44a5:1c2f with SMTP id
 a640c23a62f3a-a93c48f089bmr904801366b.6.1727624160624; Sun, 29 Sep 2024
 08:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928-fix-randstruct-modversions-kconfig-warning-v1-1-27d3edc8571e@kernel.org>
In-Reply-To: <20240928-fix-randstruct-modversions-kconfig-warning-v1-1-27d3edc8571e@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 29 Sep 2024 08:35:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdQ5TjbXX0D568GZebYnt5ZuhTW5-ffeim-aoyT9LnbA@mail.gmail.com>
Message-ID: <CAHk-=wgdQ5TjbXX0D568GZebYnt5ZuhTW5-ffeim-aoyT9LnbA@mail.gmail.com>
Subject: Re: [PATCH] hardening: Adjust dependencies in selection of MODVERSIONS
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, 28 Sept 2024 at 11:13, Nathan Chancellor <nathan@kernel.org> wrote:
>
> MODVERSIONS recently grew a dependency on !COMPILE_TEST so that Rust
> could be more easily tested. However, this introduces a Kconfig warning
> when building allmodconfig with a clang version that supports RANDSTRUCT
> natively because RANDSTRUCT_FULL and RANDSTRUCT_PERFORMANCE select
> MODVERSIONS when MODULES is enabled, bypassing the !COMPILE_TEST
> dependency:

Argh. I should have checked, but I didn't think anybody would 'select'
MODVERSIONS.

That's such an odd thing to do in general, but I guess for RANDSTRUCT
it actually makes sense (since a plain version check is nonsensical).

Now that 'select' statement is truly crazy and another level of odd
duck, but I guess it still makes perfect sense ("give me the build
coverage, but this is never going to be run, so don't bother with
MODVERSIONS").

So Ack on the patch. And now I did check that there doesn't seem to be
anything else with odd MODVERSIONS Kconfig rules.

            Linus

