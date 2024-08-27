Return-Path: <linux-kernel+bounces-302997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602069605E4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A9E1C20AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F0C19D8BC;
	Tue, 27 Aug 2024 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tu4XGYHf"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EB419D8AC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751616; cv=none; b=lUnNxHv5JR7OnARbAZ6/FME+y3RtulHewkhDydmsStoglmIAgQYLDBe8S9wGZ1U1Yrcf9miQ4EwTBZZmkQ2Oe/vqFpNxJt4OrLkGqH4zSlZW7fcb9edhvzGpSxAGQRJ0HJFEs59zxn07AlkqBUUfm5gYu0rADcGivQbMnVVblV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751616; c=relaxed/simple;
	bh=rrhP1PJhRFNbPZg86UtXjsM1GS5cNc+09BMtm6+FURE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNSQFqWxl6Y9Y5TBMgXXGj5IkEQhP3yhIeuvbwD9t17lCuk3pmQTUiLAWgcFsauQ8f1BLmtuUQM0nwi3bllACdUYIDDCJWHDbDU5F/hZkJHVNeGDeqO9ckgnd20qAaaL+4zPy5i1Z2Inkv77nLXXBaNdGIuk8bWXHLY5GliHHv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tu4XGYHf; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a86cc0d10aaso258231266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724751613; x=1725356413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldndHumggBrbQJSDmdgBSMjYlY2eQp+iUiifjPouSHE=;
        b=Tu4XGYHfaYIlj1GIHPlkxWJbCE8DB6kMCeFFgI+157JU7APdltyTkslCXiKyHJcHu4
         cgN+ScbCVzY/mQN7UrlAkstjdHU9+jiIjPncvqLocd1fYOyrsM40AmZou7oMXSsspUt9
         8gvbRXNBcOKO7NHv83SmQd9WmNqn/lx3Aa+OLEfLh/y4eTelTBr/4GlPvFaCiPnURB5z
         ecxZUtg7KePfKQ0Z1b8CaG13efPEYlazKHqbODqVjbXbFSiQIcXpBrtQ5rGV4WM/7hqs
         SjRNYTLIUbjkHYfrYZukJnhmTztuOm8Lp5xzwr8n85fDgBU5MeznNI9klbz2Dt89PYvE
         DOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724751613; x=1725356413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldndHumggBrbQJSDmdgBSMjYlY2eQp+iUiifjPouSHE=;
        b=jIJuSrH8vFu8EzBtYX1OVwttucHxv/AHrr+jD3P+QCGb2M96LJ3D6zmr1R2ztvBeJQ
         ByGS4i2iT6CXSkkZMwJr9WARWnpZZlOj/wFGrTjmuQq7+X3HRqva0lxEA+0r9JbtH1r7
         r56UJf0lgAPLwMU52QjQJVe+pGPc/GXaJC+azzKWCmhNXko5oenIJELXhrOqkUbwQ433
         Kze8fyZTlVp/w9XqcVIrnlpvhy1Mfj1C3OHoR8pLkSZmVAY6u6CdBd/WDehYF9pZ5GHr
         EdJQkaXBBaaFfkA3x/nuiQQWhC+9ScnWKGB4brLT5tXYi+eh1cle10PyWQWyVGhwSO+9
         9ivQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEha39m2FjnquxYORj68SM67LG0NEsUPAMwiXIV45pCFEs9GVaYhBePN3WcPB24djyaekY5+Qj46CkSAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNKPFaMeNjv9RqMUMgdc3Kl7eZh0XwSpN/q9xf0CuOd6dY9qbk
	96SVFw9UcdVpqUv6Wh2QQN6n6JvYS068raNkSgI/A30n2gYRqngLPZEaMWY82Xs=
X-Google-Smtp-Source: AGHT+IG+v1ID4ZFZEz2+wjMGRYJdpV7LXyoi0ftk+VTr/ru0isRlQcH8e4PR+lFzE8yLPyP1L00MNQ==
X-Received: by 2002:a17:907:f786:b0:a86:6e5e:620d with SMTP id a640c23a62f3a-a86a5198ab9mr955145866b.27.1724751612977;
        Tue, 27 Aug 2024 02:40:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549cb8esm87762166b.67.2024.08.27.02.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:40:12 -0700 (PDT)
Date: Tue, 27 Aug 2024 12:40:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: added bound check to geoid
Message-ID: <473fe1f7-33c5-43ca-94c6-b874a1a60f59@stanley.mountain>
References: <20240827090955.49339-1-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827090955.49339-1-riyandhiman14@gmail.com>

You need to put v2 (v3 now) into the subject.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

On Tue, Aug 27, 2024 at 02:39:55PM +0530, Riyan Dhiman wrote:
> Added bound check for geoid in probe function because geoid will
> always be positive and less than VME_MAX_SLOT

Add a period to the end of the sentence.

But also add that "The geoid variable is a module parameter which lets people
hard code the slot number."  It's important to mention that it's a module
parameter so people know that it's root only.  Maybe mention that explicitly.
"The geoid variable is a module parameter so it can only be controlled by the
root user.  Only values between 0 and VME_MAX_SLOT make sense.  Invalid values
don't seem to cause a serious issue except for perhaps some weird error codes."

> 
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
> ---
>  drivers/staging/vme_user/vme_fake.c   | 7 +++++++
>  drivers/staging/vme_user/vme_tsi148.c | 7 +++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
> index 7f84d1c86f29..d8f4ba29da0e 100644
> --- a/drivers/staging/vme_user/vme_fake.c
> +++ b/drivers/staging/vme_user/vme_fake.c
> @@ -1059,6 +1059,13 @@ static int __init fake_init(void)
>  	struct vme_slave_resource *slave_image;
>  	struct vme_lm_resource *lm;
>  
> +	/* If geoid provided, validate it is positive and less than VME_MAX_SLOTS */

This comment is obvoius.  Just leave it out.

regards,
dan carpener


