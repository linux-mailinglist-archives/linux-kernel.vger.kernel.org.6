Return-Path: <linux-kernel+bounces-194275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF7E8D3954
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4B01C21090
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1FF159216;
	Wed, 29 May 2024 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVPyv7hF"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082FE159912
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993173; cv=none; b=BobWypbRxO/XeOFGB8KbEwErKV+Mp+FH+eSC+StFwYLnAOGG1QpRzTkRMezgX0laqMjYhjNNDreBvcZZ0QeY4jQCCXpm+55j1La37aZwetkXxgu3wHkF4HWUblsEt2UTbRfERsORs8er3rqu5hM7oTv0Z7OByLbGSI6gt0rGKwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993173; c=relaxed/simple;
	bh=dVJ+EvwFT4Heb4Cx07/uQgdH1ZEbjDU3smi2K9tnUTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxeAsCkEfZryDhDO1xZQq6de8TXTFwwlL68kvXWwI9OBYM5q0tkdf/TzQM8Keiu43TQ7nsmAHpARz8WsDpI2llTi2a7LbMh/VTYdoTIG1Lx+T0Bhm7Sf7/vaAjszi8HvhzNcCcIE8ridRFYUESMTuWbg68uYHuDC+E2pET5CZ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QVPyv7hF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a63036f2daaso269240166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716993170; x=1717597970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yhL9Q7EwnBs27v2LEV5NKZLimYfj6QTltIE7lVekQTA=;
        b=QVPyv7hFYfdvAge+P1PhDzAXHKd+67lYDtTRoHHNdcF+875YFuFvobBl/b5gEBPuP6
         RnS3xscoIzaN1GpPMq0ffn5DWQO62n2Uo46UY5cMb1wnPzcvohesmZLzud1bbHl0Bs9z
         fyN+0uK78T5qUfFyUaxUcKjY77cYlTvECJQcRJk7RuQIEBY29gRhBGgHEBI9ZhjwGnrk
         lJuLVktf1QXIWcKFxBXtLYEJn6H8DbwVYj8GMcE4lhPWOQpOlVy5v5NHGEsbiuDXYZYq
         qtdjGb4YDv0I7guJFg4eJmLyBx28JqfNwMVd2CrdXDcn3uMV+KXzZFyUjxM5oLucxaeM
         aQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716993170; x=1717597970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhL9Q7EwnBs27v2LEV5NKZLimYfj6QTltIE7lVekQTA=;
        b=LgNMTNim3vBONO7D0OpCd0bCV9Si/diQyNQa4ccafPoEyO75JyngCJxbzjnUwbno36
         D+iYFWrj95DCNplneP5lhxpA0NetbAM28xqGC0bEIa0a/5T5qADWVYUG0raYCuDxcpIM
         beDXpzw3Ryae1q5q9ayKJV6PkrDmPR/OMPnS+VD3gaLD7/06gkbulNnWPRM5lR3rFXVj
         Q811waEEiDbIqn6lrINBQhV+4GGWMPcmN5GkBPzJoRpolZWDXw81tWu6f4t2a3OHD3fm
         0rxLhvgkug01RE75Ymb9eKCuAKy/SjAFJfdCHbbWGxry1CEp5Hn2ChbLojCIoNiuZmpI
         OFeA==
X-Forwarded-Encrypted: i=1; AJvYcCWKXtjYljL80bkSgsDreODQ+B14y9v0CtbLzIikQsyj7TYrjCPT1BK7N+tFHeb8d9Bpj3mwpGt7c8gEL+VTPxNX4evMBPkhT5fT/sBt
X-Gm-Message-State: AOJu0Yxg/Bgy/3Q2n55f//6mbcLs+qroWkeUC8HIOQPLe/NN//utxAc2
	fgCpzNc7vE58Ut/06fQWFhVrl8z96n0iU/fAVWYrdlGVZahO5X6WxBhK0Tm7d3I=
X-Google-Smtp-Source: AGHT+IGfQCqqRfxMIiISzvS9/g8UPvhr1QZ45ocg7vu1MZ6Ig+gY0oCIAZ6h2UT5aAvZRkeeCfsndA==
X-Received: by 2002:a17:906:379a:b0:a63:41d4:ca86 with SMTP id a640c23a62f3a-a6341d4cbe1mr320147166b.24.1716993170311;
        Wed, 29 May 2024 07:32:50 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6590d02e53sm40275466b.119.2024.05.29.07.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:32:50 -0700 (PDT)
Date: Wed, 29 May 2024 17:32:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7] gpio: virtuser: new virtual driver
Message-ID: <c5799a51-b39b-49b7-89ef-9cec2509330a@moroto.mountain>
References: <20240527144054.155503-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527144054.155503-1-brgl@bgdev.pl>

On Mon, May 27, 2024 at 04:40:54PM +0200, Bartosz Golaszewski wrote:
> +static ssize_t
> +gpio_virtuser_sysfs_consumer_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t len)
> +{
> +	struct gpio_virtuser_line_data *data = to_gpio_virtuser_data(attr);
> +	int ret;
> +
> +	if (strlen(buf) > GPIO_CONSUMER_NAME_MAX_LEN)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is off by one.  strlen() doesn't count the NUL terminator.

> +		return -EINVAL;
> +
> +	guard(mutex)(&data->consumer_lock);
> +
> +	ret = gpiod_set_consumer_name(data->desc, buf);
> +	if (ret)
> +		return ret;
> +
> +	sprintf(data->consumer, buf);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
It results in a buffer overflow here.

> +
> +	return len;
> +}

regards,
dan carpenter


