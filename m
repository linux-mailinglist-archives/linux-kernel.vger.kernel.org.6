Return-Path: <linux-kernel+bounces-569330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF933A6A18A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4539B1891353
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CC421420B;
	Thu, 20 Mar 2025 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwZoD52B"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9255E17A30D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459860; cv=none; b=J8Yu7rEMalC/V3vBhALDLeg0e3hZ+BrN+MUZHSKuwgZoSXDDVfCKm8L/mBEnA0JMSuoFC2FRQ7z3OBiPkyGpzr6BJ16Zo0vQVog4MCkeDqv7uSZks6XxzsO/3mL73w7a4gHXpE6Y3ngNbvmEa8yb+MUTK5t0vg+YxF512q83iig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459860; c=relaxed/simple;
	bh=z9r8meh0NzbtC/Ll1jEvPOwu0hkTD9rkCIvmFvhQZ2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p/iBB+ndfnLEvpivQCyAG6ZizrfwdxAKJIsbsxQd15iCb++D4LSyq0rxtQ9vdQ6/QPvmM4TUC3M4HpgoH+CGX7kyci3NFw/u9PJfRbQ0QQXTBrSDEIm1QUEmCuMYQPBFp3TP5qB3Ykpl7pVwyMlY/qMv+exNVg0g6m52K8kDey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MwZoD52B; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d0a037f97so2488925e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742459857; x=1743064657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3IvFwJiPLPPnFezSv+6PLZb4l+UlMIDvs7uHWAbnitM=;
        b=MwZoD52BkyPHwciKwDjpc3FprRrAroNmikrhvBsGxeZOrKQUt8Cus/Esz+/U5j2M3e
         viPz4EQ9Ecb6TnyCb/b3uCVFp4mvqw3Io3f1XTTTNrFToGIu5wVMsW5S86dvPwQnRl47
         x9uCsBlZifEq3hGuaTOrWiQFWZ3f/jnWw8bPM0BMPrVzr62pDO52QqRGYmxyePhbthYO
         /jsEaQKuL7aaG6D4PWIJR0sIzqQXl8agw924pvuE+gy+cjt6ahue16SF1S5AaFZzj82v
         WIR9TnsTVBEBJ9zTZIzsxZkowbTsPsb97YqAn/fy5E1n0bvzb/FQSK6ltU+Zkqjn97lT
         7NTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742459857; x=1743064657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IvFwJiPLPPnFezSv+6PLZb4l+UlMIDvs7uHWAbnitM=;
        b=UlKlUvy+XE6k7bQjZNcnVBqE6c5iJPYR7L9hH6tHpphSxl4OaXdxfJbzmdkoAf4UlB
         5lnTAez4itnKQ0eU7hjXHXmxO7IqZXKql+++MW1JfLZgH4Us99vjMKbvTesJCs7/qwmQ
         aTJVugSgNikVa2+a+KoX9aGHlI7zNr80Tr6UykitKGKKNkcEN8wnlqETCKvkhIlvkJOh
         nEaAH2KCE+HBiv0puR/FBS1sBF0EU9BLe9PDdDh/m2jOZRNd2Aez6AW6QhjSbHA/0kD9
         7fxoQi2ZXswxSvbhRaCqh9hCmKQnyReds9+VQ0NEMQjgl2txRY34CtzS4eIiH5DzzTU/
         Hjww==
X-Forwarded-Encrypted: i=1; AJvYcCWg3eO4PtpqL6VmsEO6rcIeMr8lM7ORRSCc7Nk9+kLBVmtMcKzTM/ISFuvh1heS5MgQ+TWIzUG5QPYsgHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpW+Zru7lYFm9DC22vD7unPMLwsm5QK1d0KtaiPpmT+P8FL2e3
	tZWBDEDtizipkDK3+WjPwYNnuWPl7iS8naKTdtaQCR50KrccUVuxWlmx9YPR9BSWwUu2OH06PyA
	dOQEOkhXX29Ze/g==
X-Google-Smtp-Source: AGHT+IEA9JIfP9CQWSGhyoB3BjdlQ0FArnJ2ndDNSq2WykCFcYDd0LfhBm9kmYyl0NNA5bn5glJhDKHgKPpYGPo=
X-Received: from wmbed10.prod.google.com ([2002:a05:600c:614a:b0:43d:7e5:30f0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fc6:b0:43d:677:3a8a with SMTP id 5b1f17b1804b1-43d4378d082mr61128705e9.10.1742459856970;
 Thu, 20 Mar 2025 01:37:36 -0700 (PDT)
Date: Thu, 20 Mar 2025 08:37:35 +0000
In-Reply-To: <20250319203455.132539-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319203455.132539-1-dakr@kernel.org> <20250319203455.132539-2-dakr@kernel.org>
Message-ID: <Z9vTzya716bkk4bt@google.com>
Subject: Re: [PATCH v3 1/5] rust: types: add `Opaque::zeroed`
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@kernel.org, 
	tmgross@umich.edu, airlied@gmail.com, acourbot@nvidia.com, 
	jhubbard@nvidia.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Mar 19, 2025 at 09:33:53PM +0100, Danilo Krummrich wrote:
> Analogous to `Opaque::uninit` add `Opaque::zeroed`, which sets the
> corresponding memory to zero. In contrast to `Opaque::uninit`, the
> corresponding value, depending on its type, may be initialized.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

