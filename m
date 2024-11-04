Return-Path: <linux-kernel+bounces-394349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9269BADBB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F101F226EC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F851A76A4;
	Mon,  4 Nov 2024 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zONYRsfk"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFABF1A4AAA
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707772; cv=none; b=hDICKca8RDKblFmlEEoCEonned8lfpfSQeOlQJiS9oYQdO4OBVvKXoibt3fXcQR/wtpj5LAwiFngKPjzxOYHlOb6+D4jumHgqHblcWjWvjHfmT5s+i/8QB1fqnZosWT1RA151OloOV1UAFmUVMbjwt0I2vnO4HZR6DhDdsgN2sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707772; c=relaxed/simple;
	bh=+smaqJgqRUBeteC0zyieDxigAF1aK6M9oaRBbBEo8h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHyVjIq2f8ur96tyocsMKgMqgoHy7La5fHFpc2IrS5d6oZTzqLvRJTZGWkIwG6W5uZoO4s0vO23MawTrcR4ztNwNWu6IIzIvCFIGsP1wHTREEHZjppYTYx+ECaaBA2/WgjoUJlWq2PQpasjMkRDiYkupCjEkzsMFiintoaHEAS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zONYRsfk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so34316155e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 00:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730707769; x=1731312569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M2TfwqW3q2rlubXI3HLqbss+F3yh9GI0LJK66jFfoE4=;
        b=zONYRsfk5yqVZJ9UOww48+ZidMmMpRk0UadJ+pATrkyPdS1/GFO35+Gj/LsGI3pFhz
         YqHPqR/0rQwIqZYcUG/3mKz9sSElt6th9G2491ZAHGYPz5MVkuIuDjGlu+1ZbrTboIhn
         kJ8qj5nlLXhhdMxAjC97pvN8WjntEVKmROS4JtHhS0orY4cI2sARFFjCFSw2lfCH6onz
         9c//5mNR+pyLrzC99xNn3+uZ+Lj1N+MqJdgT3e1SagFFYSFduyrIwDd2rAX1W57Bvbq4
         T5CqtIFYaRSZ+rGE5SFJPIi6Gdd7/Vspq+6/2nBVe1XtXg+NH1RYhuidzM1afJFuf58M
         M/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730707769; x=1731312569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2TfwqW3q2rlubXI3HLqbss+F3yh9GI0LJK66jFfoE4=;
        b=EicOs0YqUhiibI79TC3ojLygZQ3Ze/8kWfikY6z9zFBxKJooRnrqiP5f/x44Jehu7+
         xvk6kY3GCZDix2yNTCwrsvE88qRYP8y0MKDw8eH/KLCXN88Tk/KQk1PN0GYTpBJvX/ay
         IO1cOxDOw7c6YP6IDVHUCXSx/OlcFduZ80qz3OZsa9uu2ngYxnVvf8dfGXxskligcerv
         PL1MtZfEwW2s8YUMHk3gOt4w18pMVq2TzZTRcAhRxozpAaZEZei6fEsH1wkXvRBx0mTO
         tC+kZDOD85gnTfP0CtHoFoM40HW1L4FEv1VEYg/uaTIkzngJN3YKGL7I2LKC64YxedB3
         k7aA==
X-Forwarded-Encrypted: i=1; AJvYcCWcqZ906/+5x2jmXylE5k1TCCf53LkSpt432snVsul8N8zUx4ISFOdTM7PlJAUKbH8bJfXuWsqF+pP7FxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8e65Ai4WMrYd/12gX77Ez1liTyOKGQlobNzdNXGwe7WF23382
	LRXIBxm8r6MmFGG54QmRqp8iRAT4XEuqNqIi6tDq0kmvS3nWkU7OFJVAzCiCvxg=
X-Google-Smtp-Source: AGHT+IHbLx5OFNtfL02/dK6BVDvg7JZVLBymgPvgLcRyabVsXd/ovAsKFfxvs/h3o0nrWgK5+Sys9w==
X-Received: by 2002:a05:600c:358f:b0:42c:a574:6360 with SMTP id 5b1f17b1804b1-4327b820b9fmr130822355e9.29.1730707769154;
        Mon, 04 Nov 2024 00:09:29 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6984e3sm149599395e9.48.2024.11.04.00.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 00:09:28 -0800 (PST)
Date: Mon, 4 Nov 2024 11:09:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	arnd@arndb.de
Subject: Re: [PATCH 11/11] staging: gpib: Correct check for max secondary
 address
Message-ID: <d399795c-8a8d-4fbb-a645-4115cebe2619@stanley.mountain>
References: <20241103212617.13076-1-dpenkler@gmail.com>
 <20241103212617.13076-12-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103212617.13076-12-dpenkler@gmail.com>

On Sun, Nov 03, 2024 at 10:26:17PM +0100, Dave Penkler wrote:
> GPIB secondary addresses can be between 0 and 31 inclusive
> unlike primary addresses where address 31 is not a valid device
> address.  When 31 is used as a primary talk address it
> forms the UNT (Untalk) command and when used as a listener address it
> forms the UNL (Unlisten) commmand.
> The library was incorrectly not allowing a secondary address
> with a value of 31 to be used.
> 

This needs a Fixes tag.

> Signed-off-by: Dave Penkler <dpenkler@gmail.com>

regards,
dan carpenter


