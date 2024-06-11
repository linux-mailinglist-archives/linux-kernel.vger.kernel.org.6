Return-Path: <linux-kernel+bounces-210586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2949045E2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E311F234C9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D295CDF0;
	Tue, 11 Jun 2024 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYcbithW"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD74152189;
	Tue, 11 Jun 2024 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718138534; cv=none; b=E8liHkgZbZsZEEzAWhjOrmjnxERbV9nFENO10M8oGfH3taJE2pFGjafR0TLTeJMNdXYLpVA5uj0GpgTmySZutGal+7EEWZPJ6jF/ZJnfq34fEs/eRHLEmfKQKxiHJaaz9VIH0hEnw6B3++2a00OJW/uRCQEqz2bZE5F2mU8CsUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718138534; c=relaxed/simple;
	bh=LCCVZTF4VC4CuaRx97FoQAd69nXUhy8dxTqPn8RrFPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvQRGNgidVbfqDt6ugSX7xYC/PzFOMcA1kFGVfHpjwsmPCYb0RD4w5om+JgK9VUTnk0CvZasucd7X//z1C6tQhRxsmwyKy2Pv9qd+3h88kfR3QtUFjMhGSDVQx5t2mZ19f+dgOYpkiUMmJhdZOEydFBXnd9xIJo/lhJsKCCa7LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYcbithW; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6c702226b0aso168205a12.1;
        Tue, 11 Jun 2024 13:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718138533; x=1718743333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XkvFZ46cvbbRHaDGLxMnYMySUoXXzqZFujDfaujbw+I=;
        b=CYcbithWa5I545w1ezdv1bLB1WV15NZGGkFJXZJtdO9lMvJ6wCjgZPRS/GUnpWUNjK
         MCv3/S+bODAHN5EFG8RiB/FJKtm+1LAyYr5yF6L+A6Ss/gZNKqvFI4z1vD0OABRjJp+o
         56CC2L/gHlyGz/ZsnJfceUnHJsnpFbuxfMkBtICmf1z9yVd+lWaEqhtYEy6P5DU1on84
         x/Nltd4p+vbPwHFGctLe/K3M7V5OnKUIUzn6JpuuBB0IKknFhYHfdzqMfQVxoMLBNse7
         X8jvRuy+JNNNdBG6O6HfhB3BwO9w+o7p4v42lFHCuEGEFzPTSdpkU0P7zaNld3o8B8Fu
         Zobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718138533; x=1718743333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkvFZ46cvbbRHaDGLxMnYMySUoXXzqZFujDfaujbw+I=;
        b=w8+usMwZtS3p/1knGjiqNNCi8RN2f2Jo5a1+bAMilDt6oNxjzNq6E+G/JaLaPEe3/b
         gl/0ZxbmBgOmM1nfoXmgTIXCRMHaZX+W4sojcSIhM/eNVg6POkhNp0YEs+cvmrdPjr4J
         SqYbBfH74d7aA/y4bsOC8xQpIUFJHAfM78VRji6B0gH5GbZfJwTepfr710UuTEBcYcQT
         jWeYpVMVU5SHtlbfzVZnNcjeNaJDGDiqhzvGYvC19SNlf+tFXMvdgWxCyzxVquSHGbZU
         jhI+WgJsHQwizYRrXWJ8M7Y5aM75R2j+dI13UuZc2U4QsirnfpAHoBjrr2KHTbmk2AE6
         LbFw==
X-Forwarded-Encrypted: i=1; AJvYcCXi6dIMGAOCn4qZpAawk4Egjtfhl4CKw0EShifeQNZo7+AUCc1/NfI4DAH3mngTCRyLiZncHGddMzMmdNrRfQf0DE753gCQd71ujmoKDb5GlD70DwW/CDVHi8kWGj+IcFQICJ7Z7o69CoQ0cT22
X-Gm-Message-State: AOJu0YxSbx4YVYqX1dButlzIFnBxBaLiltT5TnYnLLPRcPLgoX0aMpi+
	2ang5U2r0CSp3mqXx5NNvZUYNCuk5dkMm0e6+acODseLD2ot7O8R
X-Google-Smtp-Source: AGHT+IF3TmoYIpSB6sGQyGS7GhdVbPilupJFPymlbUC4zyoHtECg83TvXZhj9FHm1TQd6wd0F15VUg==
X-Received: by 2002:a17:902:bb8a:b0:1f2:fcc0:66f with SMTP id d9443c01a7336-1f83b1b3195mr658475ad.31.1718138532493;
        Tue, 11 Jun 2024 13:42:12 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f7029b7d02sm55008415ad.197.2024.06.11.13.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 13:42:11 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:42:09 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] bitops: Add a comment explaining the double underscore
 macros
Message-ID: <Zmi2oUOjh5elr57T@yury-ThinkPad>
References: <5a970f32-25c0-4955-b480-a4738bf86153@kili.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a970f32-25c0-4955-b480-a4738bf86153@kili.mountain>

On Tue, Jun 11, 2024 at 03:38:12PM +0300, Dan Carpenter wrote:
> Linus Walleij pointed out that a new comer might be confused about the
> difference between set_bit() and __set_bit().  Add a comment explaining
> the difference.
> 
> Link: https://lore.kernel.org/all/CACRpkdZFPG_YLici-BmYfk9HZ36f4WavCN3JNotkk8cPgCODCg@mail.gmail.com/
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: re-word the comment, put it right next to the macros and add a blank
>     line in front of the test_bit() macros so it's not mixed in with the
>     non-atomic macros
> 
>  include/linux/bitops.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 46d4bdc634c0..ba35bbf07798 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -47,12 +47,17 @@ extern unsigned long __sw_hweight64(__u64 w);
>  	  __builtin_constant_p(*(const unsigned long *)(addr))) ?	\
>  	 const##op(nr, addr) : op(nr, addr))
>  
> +/*
> + * The following macros are non-atomic versions of their non-underscored
> + * counterparts.
> + */
>  #define __set_bit(nr, addr)		bitop(___set_bit, nr, addr)
>  #define __clear_bit(nr, addr)		bitop(___clear_bit, nr, addr)
>  #define __change_bit(nr, addr)		bitop(___change_bit, nr, addr)
>  #define __test_and_set_bit(nr, addr)	bitop(___test_and_set_bit, nr, addr)
>  #define __test_and_clear_bit(nr, addr)	bitop(___test_and_clear_bit, nr, addr)
>  #define __test_and_change_bit(nr, addr)	bitop(___test_and_change_bit, nr, addr)
> +
>  #define test_bit(nr, addr)		bitop(_test_bit, nr, addr)
>  #define test_bit_acquire(nr, addr)	bitop(_test_bit_acquire, nr, addr)
>  
> -- 
> 2.39.2

Applied in bitmap-for-next. For the next time please make the subject
prefix [PATCH v2], then [PATCH v3], and so on. The motivation is to
avoid sending emails with identical subjects as some (not mine) email
clients consider one as a reply to another.

Thanks,
Yury

