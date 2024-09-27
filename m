Return-Path: <linux-kernel+bounces-341397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF697987F77
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB531C2230E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01D3186E3E;
	Fri, 27 Sep 2024 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJDGVUo4"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA57170A27
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727422309; cv=none; b=DEyV+qfTNeRK7L/5iUlyj7iPs0fQW5aHcXHlyOZyxrJ7o8UaQWwkrNe0ICOn+nT67ZTPYY1XciaIb8xyDJqELdjBbm7f0CntYoKHJ61Pw17MsQjdreBkBDgAxpygGPEikCwH+nwocIWAyWhWrqGoRCWijDxmfKeJRqqUoP90ur0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727422309; c=relaxed/simple;
	bh=Uy4tL0PqPFDhK96Kj3mnXwSCBSdfpL26nnqRfG1rP/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQ+K6uqSocKlMVHVPdypFydag6YWwK6ysZNhghbw75tcxFJZNW7sQsoafo5sl8NTEjv3RCzGOxT3Vq8cq1ooBJaAscm43A88+Yo80P9fFNKOpolR/zy8L1E4wehN00OnGULgQmP5qjIeHtdXhWAjAsHtVeP9ukaSeSll12r/USE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YJDGVUo4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so16803245e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 00:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727422306; x=1728027106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CARlbOQ4FmC/9vY1epkLbqmUBoOe6yHrpUpTFdvHe8c=;
        b=YJDGVUo4ecK3QXHj009CUUoDMmWPJVZVIHpwAHBQn0/t8JeFW1GzcY9fVBJakggF+R
         19wbNgfaX5fKhSF8Xl1td2fVXICQKszdEft4U1wrJQ67DVOGO2sLcm9bLVub1G0Fr6Gg
         WoUQcY5UkV5ccLIfFRCf4m/XTZYTMnLTBlc6oKxLc+Wau3Afw/r02S2rjSfA/2Fh+Vdt
         nUMwrcJNYdIGgUvj0i0HFdeohr+ibwLJKO3sETuGo/iRMcwNRFJB36PEdo65u0uifzEp
         OnuISoJho8jkifdoNyySwGEtBBFH8zxrtddfXr8lFjbKaYlaD2U4uhHLZ6yyRK7wXdWS
         gcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727422306; x=1728027106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CARlbOQ4FmC/9vY1epkLbqmUBoOe6yHrpUpTFdvHe8c=;
        b=BYTaTD2O57EwJxpMhMxav6Jf/3hE3RkFA8u+hd1ZAF0QKDORrIjdKxOE3zQOdYe+4R
         Gr6YFlyHyzhcxD2vlqTOqNxv8EZexYqv2cR45vejekQGjTFteMIxvJIl17rkTet9nOPJ
         tTRJFd+g4VrQnAdvAi1biSz4g7r2nzY90bOMQDK1jgYGUJCqcAG7jCQdWNltETX/4wha
         2yMpsk+bCnauvNW525eRNM0d1/Az6GtHSZf2K2K6mTswoefxYPH+d25SedzNVZGQnRLw
         tODq7IncgT+MwEIiMghqIuXRZeobfNFbDpNBMHCXeoF5owyRUbysnIWvImBDXw45QZ45
         0W3g==
X-Gm-Message-State: AOJu0YzR/GOTo421DDWTk5i1d6ZVHI8aMIxKXGuLMvks9rCqk+LlgyRj
	Z8rXbTSOJz3iyDL+7lLPnh97Wzls5rn5mk/4gE4D/rSjR9Pt+jebra8KBKv+8BU=
X-Google-Smtp-Source: AGHT+IF81JpWowwb9D5kWOGhGgC/ac8khItY3F3XOGFkdslwMZr2KkOOfjfGAElFjyyrmN2pecwNRQ==
X-Received: by 2002:a05:600c:4f01:b0:42c:b995:20d9 with SMTP id 5b1f17b1804b1-42f584981b0mr13389735e9.28.1727422305796;
        Fri, 27 Sep 2024 00:31:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969f1a76sm65422405e9.12.2024.09.27.00.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 00:31:44 -0700 (PDT)
Date: Fri, 27 Sep 2024 10:31:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [RFC PATCH] cleanup: make scoped_guard() to be return-friendly
Message-ID: <10515bca-782a-47bf-9bcd-eab7fd2fa49e@stanley.mountain>
References: <20240926134347.19371-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926134347.19371-1-przemyslaw.kitszel@intel.com>

On Thu, Sep 26, 2024 at 03:41:38PM +0200, Przemek Kitszel wrote:
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index d9e613803df1..6b568a8a7f9c 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -168,9 +168,16 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>  
>  #define __guard_ptr(_name) class_##_name##_lock_ptr
>  
> -#define scoped_guard(_name, args...)					\
> -	for (CLASS(_name, scope)(args),					\
> -	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
> +#define scoped_guard(_name, args...)	\
> +	__scoped_guard_labeled(__UNIQUE_ID(label), _name, args)
> +
> +#define __scoped_guard_labeled(_label, _name, args...)	\
> +	if (0)						\
> +		_label: ;				\
> +	else						\
> +		for (CLASS(_name, scope)(args);		\
> +		     __guard_ptr(_name)(&scope), 1;	\
                                               ^^^
> +		     ({ goto _label; }))
>  

Remove the ", 1".  The point of the __guard_ptr() condition is for try_locks
but the ", 1" means they always succeed.  The only try lock I can find in
the current tree is tsc200x_esd_work().

regards,
dan carpenter



