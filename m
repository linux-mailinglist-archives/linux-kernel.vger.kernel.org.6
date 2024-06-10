Return-Path: <linux-kernel+bounces-208168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 748E79021D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB0E281E95
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8118063C;
	Mon, 10 Jun 2024 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfDHDdes"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942FA1CA9C;
	Mon, 10 Jun 2024 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023551; cv=none; b=gw9RZlnRMgCL5bCN/2ciucVhX+8qhIFeeDfDbPQv4W7EXS9ml02lhkkTwQ7E6zV3xQMnyWt8r4E4hYJEq6NYsi35OQ7XMFazpKD+NT/neAxlgw9PtWoKCgxwtyo4Fh6/vEo+C3NiVYR1VuKyDAzzHqjSDWf5j78HQ0HX1Flq154=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023551; c=relaxed/simple;
	bh=cNaDqeqmIi3VO+7ctZApDz5I8zuTFFtcGQE8rQxQtDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olmXsR/vVw86COveLOBPJRTWD6sx26LMHR0MbLov6Qe0KZ+fOKxT1XzLhLcwQrCJDsBJRcvfcZKnWwIXc5TuLgC8ivvCJ65oDPsyI9pVNXrE0OQBST+dcRQ3U5FBF8ahTKA04tyT8DuNBKJ0sJbvh5GTYfIH+OaNFaPsOnCmvbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfDHDdes; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3747e9f7cceso18299745ab.1;
        Mon, 10 Jun 2024 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718023548; x=1718628348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n0A75YsLNDrJAEJU2+SJLrYo4kR3xTnfzowYUQnBPb0=;
        b=KfDHDdes/7wyhssYYg9/8JXj5SRqOQYMFq97X69/isw2HqHcvcHxnig8KWOTbcPZMa
         1DqPErML4Koe8I9z7CdQCWuZ01d3LcSPEa873QGerGe2XIJicFXoh1Zkd8ToMJNraE4s
         xe82rrHtySpFRrJcxtj3QMQwYPStYqE40qJfeplJxt9j1GVfhIkz/WtFrFrrP1CkQIxn
         92XXB9B2j4d3iWcVRKL0izRlYF5xN8w5TyitXUSNa/O8yt30s5VtQO7OUh55u/iWcKkw
         44PkgkKu33n3tzwSO6cSHat8jvPPD7u3fUmQJ2g6OYBy1O6Ba0c7vNhWqpOEB4WPp3o4
         dRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718023548; x=1718628348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0A75YsLNDrJAEJU2+SJLrYo4kR3xTnfzowYUQnBPb0=;
        b=dR1udOo3dO8HX3ZnBciuYie0zo9aLr2xmv1QuzVheyMUiZ4OJRR4HgBN/SWtDyy8XF
         uQ+62+dOmNy8TpOvLsYiRHFJzWs+I2/GeXlWNs6H9KOvSuD1vXAvSzWR0vDgLYKCw6Yo
         8MnQDuauZJnUYcGlvvr2aiYAc2AjMxxEmdg+tEkAW2ueIELmr0yLpiSxeFJaGJAk0VJf
         9DFycmXApz6yjeW5CaHSww/PjET3opJBRuzVi0xpnn1W3lsiJ8EOI5l/NSllzRmOeJfx
         UfUdZlA86YKfyvHB/UHyjmrsBPJ+NEwNf4YSUY76oxp0Km40c0PmVeQvtVv9R4qOfLAm
         S/gw==
X-Forwarded-Encrypted: i=1; AJvYcCVR7NO6dQDd/9qEKHcjsoMfuXdjyX45BC9m5uftkSI23odVAE3hFpCuaH80Jw1XBZNrTIZfC6EAQa1pWra908qaYJdUe8SDrANJ8QjkLT4Gzo9NtoaHF/ogd5F5BMRNK2po/RbOFqzA3DB8LOQB
X-Gm-Message-State: AOJu0YzbX7IT4fx8fJkSqYoaSC5Ql2BAm0xTjCWyt7UmocXmqdnmlpSH
	Pn5jUGBYMAH9jzqeE+tafz+wfbCmtvfmyAskNVyZ3eUxmXTf/g4CCdmGnA==
X-Google-Smtp-Source: AGHT+IHTM833lV6OsHrly3ysPhFOMZdmeZVVyI1hx+v4oDA9dM5v3kPoB1RZoB18IwYl3Mi2qfSflQ==
X-Received: by 2002:a92:cdae:0:b0:375:adcd:e6db with SMTP id e9e14a558f8ab-375adcde918mr9181985ab.9.1718023548614;
        Mon, 10 Jun 2024 05:45:48 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e9a52a3012sm2907114a12.30.2024.06.10.05.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 05:45:48 -0700 (PDT)
Date: Mon, 10 Jun 2024 05:45:45 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] bitops: Add a comment explaining the double underscore
 macros
Message-ID: <Zmb1ebn3HWPZc6Bo@yury-ThinkPad>
References: <0ffbc9c3-7a7c-4cbe-bdb7-1041df44ce53@kili.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ffbc9c3-7a7c-4cbe-bdb7-1041df44ce53@kili.mountain>

On Mon, Jun 10, 2024 at 12:18:03PM +0300, Dan Carpenter wrote:
> Linus Walleij pointed out that a new comer might be confused about the
> difference between set_bit() and __set_bit().  Add a comment explaining
> the difference.
> 
> Link: https://lore.kernel.org/all/CACRpkdZFPG_YLici-BmYfk9HZ36f4WavCN3JNotkk8cPgCODCg@mail.gmail.com/
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  include/linux/bitops.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 46d4bdc634c0..b35a5c3783f6 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -29,6 +29,9 @@ extern unsigned long __sw_hweight64(__u64 w);
>  #include <asm-generic/bitops/generic-non-atomic.h>
>  
>  /*
> + * These double underscore __set_bit(), __clear_bit() macros are non-atomic
> + * versions of set_bit(), clear_bit() and so on.
> + *
>   * Many architecture-specific non-atomic bitops contain inline asm code and due
>   * to that the compiler can't optimize them to compile-time expressions or
>   * constants. In contrary, generic_*() helpers are defined in pure C and
> -- 
> 2.39.2

If you find the underscored notation confusing (everyone does),
and want to add an extra notice, I'm OK with that. But...

The comment you're prepending relates to the bitop() macro, not
those individual bit ops. bitop() is used to generate test_bit()
as well, with is not split to atomic/non-atomic.

Can you put your note on top of the actual macro declarations, one
starting with '#define __set_bit()'. Can you also please use a more
neutral language. Maybe something like this?

        The following macros are non-atomic versions of their
        non-underscored counterparts.

Now that you explicitly mention non-atomic macros, and for test_bit()
and test_bit_aquire() there's no such separation, can you add a blank
line to split them out and make it clear that the comment is not
related to the test_bit() guys.

Thanks,
Yury

