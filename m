Return-Path: <linux-kernel+bounces-308582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA030965F1B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699241F21991
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7315517C9E3;
	Fri, 30 Aug 2024 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FD45vVW/"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3C917BB0C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013581; cv=none; b=aKQ6/Y/qUTlQCaKjtdiRKqX0G1fY+y6nTGcyqYq/kPgBuq2OplA9RgArAiryB0zG1JpxYE6/cJlsf2FKaG2FSmdXHGewEE5jPEutt54goHaT6tLazLzo4ivec/S3gwuHLpjRoqdeRXEiz4Y8aoo4DxP73DICrEaEWeYfqAP2ygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013581; c=relaxed/simple;
	bh=WQ99LJYivjNjc/YxBFt3pqsTi3RuoGAipkdSws+qEm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdVMlegWbT8tMv4UBjyKjW+6y6szbI/LWz6UtIdzFRy3EgrACuCtacrMqFEnb/yMgg67msBd89BER+lQlUJpiLYj+D/3Rb7r09u2XYQXsnGpzpFV28thOKFQDo4C8k+jT9YWeQr3Gw4EwCaLEY4mMq2MwVbMFy8jIq2MStmsCWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FD45vVW/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428243f928fso18499925e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725013578; x=1725618378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wn4eD9yWatFflL2/3CKv6e2tbHrAQe8FmHkt92+sPt4=;
        b=FD45vVW/M9U/x4LU4WhZao9HoHd7uwDaRLLX7OmeKnYd1f9k3G5sEQ3iTHaC9GsuZv
         f7sizrMi3cuujDs64Cw8xyp3UUoogOCIbU7K2XcvEtda0Cspck4JnAh8aCvtEK+QNVyv
         Bhx+Wv8H7yva8o22GKfzN3ieWV/ZynWIO5tDj8hfFTsvTYCV07c0K8+6w+PGWPsZvazQ
         vKCcmAi8nSIma1yKYgC8x88WybVtWTaRsykJe34tfs8JNtEuoqHswPzkMNZaqWOmM0eh
         vB5I8rTPmSB5bN9WVofpWOx2T2GFD2ABFVY1KSuYjvc2C1h/fxnYeS18sJC5GVHOIgLi
         5uOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725013578; x=1725618378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wn4eD9yWatFflL2/3CKv6e2tbHrAQe8FmHkt92+sPt4=;
        b=u6SvYC1WoMmbWAvo+zP8RLFpi/s6UGkZaIYK4l0+cRHSGjrFh/6qFHNeRZCyojIZSO
         X6pmTZND2t6G8KW24v8/Crwj8GFZnh2d1yaLMd5kFtONV9XS5jXNJaGuKjdOEwY/JyZ5
         AXBEysjm/IQQdjo7X3zwdCT1zGULE9ODcWtAw4YmLz62mW9DInJrm8vDLat+YythoHVQ
         RRhQAYyeK96WLSt7HReGvMFWqHT8jYC7skJLFblkNmiGq8qXWe5+RcAZflJxrweY81jr
         f64pHQRmDeQD5gRlHMaSFPqLH8BJdFUiDAVbUOdecw/4VWcPgTJ3B9p7UIjubh4l5dQt
         XyuA==
X-Forwarded-Encrypted: i=1; AJvYcCU7h0wveYryh9juFNuE1+6U4dzYuPaWIbVXj0gYknzUPLKD+1dM8eCabEDshz7GHoxByY2XkFSa0toFfFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn/4FdpRjftK82LaQ3KxXR06IhDmFl7MwcvK5HTMbW973G8G+u
	p09LwVzO2XhCXhcL83iu+SitnglmjGMR7ddHzxa4ANg275kQqWKdE73KRAIbqA==
X-Google-Smtp-Source: AGHT+IHI/5ydMtgQPWhtQcchOILEP7cSDqvBil+uOoViRI+AG38bTMnFmDMcZTINUD1xJvmzIZz6LQ==
X-Received: by 2002:a05:600c:3b10:b0:426:6ed5:fcb with SMTP id 5b1f17b1804b1-42bb01ae1fbmr57292825e9.4.1725013577995;
        Fri, 30 Aug 2024 03:26:17 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba7b4271fsm70580775e9.29.2024.08.30.03.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 03:26:17 -0700 (PDT)
Date: Fri, 30 Aug 2024 11:26:12 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Sebastian Ene <sebastianene@google.com>
Cc: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com,
	ardb@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, james.morse@arm.com,
	mark.rutland@arm.com, maz@kernel.org, oliver.upton@linux.dev,
	rananta@google.com, ryan.roberts@arm.com, shahuang@redhat.com,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v9 5/5] KVM: arm64: Introduce the PTDUMP_STAGE2_DEBUGFS
 config
Message-ID: <ZtGeRNhMv1f3M2lh@google.com>
References: <20240827084549.45731-1-sebastianene@google.com>
 <20240827084549.45731-6-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827084549.45731-6-sebastianene@google.com>

On Tue, Aug 27, 2024 at 08:45:48AM +0000, Sebastian Ene wrote:
> When this config is enabled, it exposes the stage-2 pagetable layout
> through a debugfs file.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>

It doesn't feel like having a separated patch for Kconfig brings anything and
I would have squashed it with the previous change.

Otherwise:

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

> ---
>  arch/arm64/kvm/Kconfig | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index 8304eb342be9..ead632ad01b4 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -66,4 +66,21 @@ config PROTECTED_NVHE_STACKTRACE
>  
>  	  If unsure, or not using protected nVHE (pKVM), say N.
>  
> +config PTDUMP_STAGE2_DEBUGFS
> +	bool "Present the stage-2 pagetables to debugfs"
> +	depends on KVM
> +	depends on DEBUG_KERNEL
> +	depends on DEBUG_FS
> +	depends on GENERIC_PTDUMP
> +	select PTDUMP_CORE
> +	default n
> +	help
> +	  Say Y here if you want to show the stage-2 kernel pagetables
> +	  layout in a debugfs file. This information is only useful for kernel developers
> +	  who are working in architecture specific areas of the kernel.
> +	  It is probably not a good idea to enable this feature in a production
> +	  kernel.
> +
> +	  If in doubt, say N.
> +
>  endif # VIRTUALIZATION
> -- 
> 2.46.0.295.g3b9ea8a38a-goog
> 

