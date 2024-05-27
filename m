Return-Path: <linux-kernel+bounces-190201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C548CFB1B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866AA1F216F2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951CC4594A;
	Mon, 27 May 2024 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MZcbzZ9u"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5AB2030B
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797770; cv=none; b=GiR8BItK+pGCYuvtwjY+ZjlM74Rd2MFRB6HMEsN2YnWZfsyDKYd3f0WpTXLfZ1BpbGTSrCXT0VJ9ElKN1SLJZ+wob/2urVXN9Vxd+0qfge65UU/fPPGGiK2eJtF7UW1Zylr2ezYLC1273FMZg+miAT8GjOLFMs5dagcpz15k7mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797770; c=relaxed/simple;
	bh=im+llKHRV6/OLwUXArxx3xlTY46nqAVvEgvK+7QBrq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXW6S9CnR3QGXJeW5laWBeOMfudue01dqpAgHi1fnwulTdJuWPSxHFfGX0lifB+kTHg2uxpvHVpJfa149g69q4xOQfHhwKEq7i46XankbjCozJza1S2PBlokM/uXrO7Lse+Ro0I4kppOlGtmbEsGDfUmHSEYOqFr4eJU36crLKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MZcbzZ9u; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-578517c7ae9so3459196a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716797768; x=1717402568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti6BQ0nZTqoUPvV5Y4Ffa4XsuHRMzdkHsHYxPtpQMhU=;
        b=MZcbzZ9uDrTLeiiGl7sQd46M4w61vd2ICl8feR1Z+7bcM/DEihU01MZ2dMtsMf1XPo
         lGGbCW7PBcObzPMm7xvD/WvBYwDJpf7/yYYqivQV74HsFvgI+DGtH91teVWEZM2XgE3p
         Z+5wKbqVxokdRMHpBjk8KQgrmtVyGWPKkvWH5zNWMjCenyXeZ0mL8ktkZ6laPaD3pwf0
         o7DqIZYlOb30rUzRlrVfhCkMnxDrBdDsT3GNEA9jhakZ4XjyHIFbwvLC3WLmUaeLDa9x
         RG00fnRdV13MZ9YUPsS3dvAh1sZuTaQT49OZ/u5KenDufEXIOJpBi3NqhJqXBIHYuIyf
         Q2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716797768; x=1717402568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ti6BQ0nZTqoUPvV5Y4Ffa4XsuHRMzdkHsHYxPtpQMhU=;
        b=Gc6XgDEtOZXaIt+F9QsOgqXzxVGx4C2NqODp/rMnHgFcR9Ns7o9XWmHPWxgOq6VtoM
         iQOkWIJrl4GyidT80Z2ah24kSemHkHQpFU/WI2hhK5fJvG8AXmypmxPxA8lHJVn7Fr1A
         irxEVBiSJ4H++rI/oxwnR6y0XYWKWWMNV09m1BW4CH7+kRkHak6Zl3L8HooNVLSuS+sx
         yVszR0XywMwaE85u7GLF2WK9JCn26NT7Ccth1pWWqgD3EB4U7mlCGSgzAJJ8vksCM8VI
         aKwtSl44Cy3/diWaElrxkaeejASM6QJmjl3dpjuAaLv6ouTWPyQlIKu9G44H45IPAu7P
         RcLg==
X-Forwarded-Encrypted: i=1; AJvYcCXJj/1E4Qukr6Rij9LtAAIxf6HhAmoNAZ2LJ4/OtunDvZALWHw03KgriNKZYK63QUor6a7hkQQV5zeBOB75BhlSUGMtnPZL8pZPrF5Q
X-Gm-Message-State: AOJu0YxwjB3qplwZXEQvXTty+qInEdwHkdalYKCQAAo+tW4maTHZh/0t
	keYG+k7p1XIF3zkreFKT2kYKFgk7gOoM1GPI5cKdF2hKT6uB2zkeCOjlIB9cjoA=
X-Google-Smtp-Source: AGHT+IGSR3D+cVueBrqe8m9RKJMLR/YZi8ejwDS2zj+FbDq+GuOv+ZeKHZ/hsVXQtzgukx5feH5U8Q==
X-Received: by 2002:a50:d751:0:b0:579:e283:d2a4 with SMTP id 4fb4d7f45d1cf-579e283d715mr125928a12.36.1716797767681;
        Mon, 27 May 2024 01:16:07 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5786c0dc384sm3234417a12.75.2024.05.27.01.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 01:16:07 -0700 (PDT)
Date: Mon, 27 May 2024 11:16:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: atmel-sha204a - fix negated return value
Message-ID: <28dfdd52-e72a-4465-af7d-7b10c635b150@moroto.mountain>
References: <20240526103128.14703-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526103128.14703-1-l.rubusch@gmail.com>

On Sun, May 26, 2024 at 10:31:28AM +0000, Lothar Rubusch wrote:
> Fix negated variable return value.
> 
> Fixes: e05ce444e9e5 ("crypto: atmel-sha204a - add reading from otp zone")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-crypto/34cd4179-090e-479d-b459-8d0d35dd327d@moroto.mountain/
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


