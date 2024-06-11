Return-Path: <linux-kernel+bounces-210152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 962CD903FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5A51F2471D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D8A28DC1;
	Tue, 11 Jun 2024 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ouftaKNP"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E3E219E7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718119740; cv=none; b=TeU/OYAKn1s9kfXTX68S51Hp3WNHjjMR3z4wgSLl46wELQpGomy9BSYA3G3RAppEIWyxQ1N0VLeA5tM4Mok9/EUjujwhIq5+VrBGnZF9wUR/qK6rXT8SucRNie8JxcgKxQ1UA31iezJ7HHbMK8K690wZT9OElCnIqLOvKmr1wm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718119740; c=relaxed/simple;
	bh=2WrLQnRkJJW8PIvN+lSkf9M7nln0JfBNhjWZYvJKsAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ey5Gfnn8wqEOlKNLbYpA58konKwmnZKgctbwj47ZLJun8Ejj0/JxMke83POp6K/T3fZM8YfOdSxCM/rBMwRT+H0dOHxRGf1oE42wm+h/fsjZiCAhIZqnCWClo9SnGFWlmgg9fFkDi/LOJuPLFvE8QRd49ch3tmdHCyOxUzEvdUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ouftaKNP; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52c4b92c09bso1599747e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718119736; x=1718724536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vX66emLSPsiCozjYEcIgCjpS44vD4TxBAyFyr2wQO6Q=;
        b=ouftaKNP7UxCOE4g6sSn40JDBRbIK0YL9awoFAbYsdjwKS/hhDYcHouLxtKcQRf/qM
         E2fDhUjdidGA9FEQ9g7KOX0htmyuOygZSmXU+ok9HuODZdxExOQGc5xI2FOi3xK7xfTb
         rmwsPDg7+/k9CZSSi+T0SxSmKUa2F1UBbLnMUsauFGx3RbcAoqZsdwMUiYYKsDBVfJne
         PmkwpZHAupjL9SouQgOyuGGIYLCZzqZUTdxkpTBI4NVmUV6D+zzzL7+0lH0s5TOVxfLD
         o87O2DJgVvc2f/0CD1ktq763UTtavEG1MhYA8dVa4sVMaxL8i+D7Q9JwXYlKW396CEat
         l1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718119736; x=1718724536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vX66emLSPsiCozjYEcIgCjpS44vD4TxBAyFyr2wQO6Q=;
        b=hVUqnuBIjK+196skVLcvLCy3mDdMQtxsO0jeBycsVgWZf3E3tn3LILJbpMIgBUhsyH
         ICqw2F4PGQbkG6sESAyerd5zHPwJXHeAEMsOOz5iIAeg94fgrkTOGG9+WyGzA2irezUb
         0De1QtN9MlR9ZWD9WhwbU8Tc0xUAU+wkvTwJgo3dupmepn0GhrbhqLLLpByCYmzjJBW3
         pTfRu/mJGDli5uq3zAwKvs5Orl1Cpbg0dlG9GKx93qsINYosePgWxdLJcgwqO4Qc1jUl
         QH2X0y3rJsOzTxnpuZ6lKSBB0WZCsIqOFGw+2eoz9XATEx3fn8GvSxwKK9DMvSB4vhzA
         gT7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqccSi6MB/X+pJwCTpzUIesTkn0HtJaVzfZqPp8QHohh/Xuto/EOrxRetVaCe7dQntCMmQrpe5Q4SY/CoEg/w5zGdgxtStQPYA1mJ9
X-Gm-Message-State: AOJu0YxHlp/RTfa7Elib+8U/Fk9FKcvaEJiHvdsEo098M2xajBPpDz2r
	jiWrFWtBX4t0p9ngCEXwvlgD9UnGYBHQRBOXWqsTTsLxybuEun9t8UZR868wAqk=
X-Google-Smtp-Source: AGHT+IGvxWpypN+Q4GZLa8CZIb81/7RUuQZpYfehnYfxA1SgUhq7yrpOBlMV7ZeMcH30jRNwKRSigw==
X-Received: by 2002:ac2:4644:0:b0:52b:c10f:995d with SMTP id 2adb3069b0e04-52bc10f9afemr8727418e87.67.1718119735587;
        Tue, 11 Jun 2024 08:28:55 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2c7e8fsm182702335e9.38.2024.06.11.08.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 08:28:55 -0700 (PDT)
Date: Tue, 11 Jun 2024 18:28:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joy Chakraborty <joychakr@google.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmem: meson-efuse: Fix return value of nvmem callbacks
Message-ID: <b730de08-6d92-4667-810a-613d5f2855b8@moroto.mountain>
References: <20240611145524.1022656-1-joychakr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611145524.1022656-1-joychakr@google.com>

On Tue, Jun 11, 2024 at 02:55:24PM +0000, Joy Chakraborty wrote:
> Read/write callbacks registered with nvmem core expect 0 to be returned
> on success and a negative value to be returned on failure.
> 
> meson_efuse_read() and meson_efuse_write() call into
> meson_sm_call_read() and meson_sm_call_write() respectively which return
> the number of bytes read or written on success as per their api
> description.
> 
> Fix to return error if meson_sm_call_read()/meson_sm_call_write()
> returns an error else return 0.
> 
> Fixes: a29a63bdaf6f ("nvmem: meson-efuse: simplify read callback")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joy Chakraborty <joychakr@google.com>

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


