Return-Path: <linux-kernel+bounces-219807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0784990D7F1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD2E282CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678BD46435;
	Tue, 18 Jun 2024 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ugL/8yd4"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A334596F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726383; cv=none; b=o1+sPWSpYeUC3ENXK0n2+xk5kw4zjTNELoeZmR9Vl/nTDVO/YLw+ZwwPtu0pcXk5RO9yZCAQxGREtH14puWgT06r3sq/8ZPajrSYc8oNtmm1RCHujGMzrtuxSjIdy1wfYVLkNTFFB0p4l2iVCDC6zO0vbW/0Ynkdm9BazwlBkPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726383; c=relaxed/simple;
	bh=cCY+Z9WivXsDOXzXQEezmM6C/lb8JINVV72i9++S2Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djC9SZYMJQfvPaNqbc4DQ2OfEsCG1GnENM7RGJDBZpo6bYPAkmD8cFhDTA/5h9Ym3UjOuryJzIu7tYGfFOhxU3FNopPIjZJr0GKXKYpX0MtUVPxx5KMaUoU9OIMMGucQXVhpLZpdIlkIl2gCHyRD8nJqleOBQEH9KyA6ZzdkJJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ugL/8yd4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso58593685e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718726380; x=1719331180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KW5CYpn36l//7aM9dysfyiIEFCEnSC7/zTj92FzcYsw=;
        b=ugL/8yd4mkLuD4QKB/MuhEzE5pekZD4b44moHQ8lWQsTg7IYij8NnLOcOfslzCwsJu
         N9zaFknV0wZbCy4/sSib/JYf0zEFOnYStrQX5NXpOUum37qjTt78vmQik1h6swkRKoDZ
         kal0NUgAeMa1zHcfEc8C4ysk54nvm2oFHNDfBIKiZN33YYsosOEZWUtLRkoL+XUMBjJd
         IgkcoTuNUeDpbFYWa/qa6nAWh6hAXspJsO1vGr7HjwHK4RrA1NjP+823vYc5evRZ2Uzq
         T7aX7wJ6+Oq5ONf2/CFX+4wIwFYfETIkMtUgbVhPno8WhPrgCZJyldTSRfGu/4pn9/Bg
         n9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718726380; x=1719331180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KW5CYpn36l//7aM9dysfyiIEFCEnSC7/zTj92FzcYsw=;
        b=Aay8x+2Go6n82cE0hV7FEOWCX17rv8xH7MCu/QcabWfpkPB5P1+jlUo7fGKjfWcD3T
         wEtgm1xWV8bANblTnIE2u37/13zKvtSIseI9egLSDXJIwCpiEUug98D1dURL/AneyRUL
         CGXoTeolshkw9VmFQw3SdZmDE1iq3R9J8vUSOQ97eznSuStT4FisJnQb7utala5FM4My
         vnWKd/WByMJLKSVX6PiMfhjVK1gpwXpBjMn3I9lG2P0sebIqunHP2S4xnUAvX23uNkFC
         w5hjvSjJw3OVjBNWzDrWyh08yxQvHA7j8OwjiO1nj/39cmQrXCRy5qosk/O4tp+Bvw23
         fLIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjV821ZT6vBTiHmSiPR+CAQ3IvPoOUAEAD1u35wjNA4ItiqV9LinVhvtEAB40QfQesQRNa0XnnsOWQVnMWkBvuqjACRWlbY9tq7NSI
X-Gm-Message-State: AOJu0YxvMhFK26AxHOSTDUe0BydXhmR/Z/kJ+5vZwhzQzBo654YQRfPh
	Y4czEGsG/PAqq2bMJZ5zs4jgOQoV+zIZx3U7frHnT1htQDguidgrXeZZfAgSuOQ51Ir9T2SOsSx
	KvSI=
X-Google-Smtp-Source: AGHT+IEOulskKK0DQifFRFKsJWs4iBdG02SkiZn2is5YgIwx6kR6gYve5+eWcIIhl+AbQIyMYcD69A==
X-Received: by 2002:a05:600c:474d:b0:422:178b:bedd with SMTP id 5b1f17b1804b1-4230481a0bdmr116566685e9.1.1718726380384;
        Tue, 18 Jun 2024 08:59:40 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e9590sm228819345e9.23.2024.06.18.08.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:59:39 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:59:38 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jason Wessel <jason.wessel@windriver.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] kdb: Add mdi, mdiW / mdiWcN commands to show
 iomapped memory
Message-ID: <20240618155938.GG11330@aspen.lan>
References: <20240618003546.4144638-1-dianders@chromium.org>
 <20240617173426.13.I572fb3cf62fae1e728dd154081101ae264dc3670@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617173426.13.I572fb3cf62fae1e728dd154081101ae264dc3670@changeid>

On Mon, Jun 17, 2024 at 05:34:47PM -0700, Douglas Anderson wrote:
> Add commands that are like the other "md" commands but that allow you
> to read memory that's in the IO space.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Sorry to be the bearer of bad news but...


> ---
> <snip>
> +/*
> + * kdb_getioword
> + * Inputs:
> + *	word	Pointer to the word to receive the result.
> + *	addr	Address of the area to copy.
> + *	size	Size of the area.
> + * Returns:
> + *	0 for success, < 0 for error.
> + */
> +int kdb_getioword(unsigned long *word, unsigned long addr, size_t size)
> +{
> +	void __iomem *mapped = ioremap(addr, size);

ioremap() is a might_sleep() function. It's unsafe to call it from the
debug trap handler.

I'm afraid I don't know a safe alternative either. Machinary such as
kmap_atomic() needs a page and iomem won't have one.


Daniel.

