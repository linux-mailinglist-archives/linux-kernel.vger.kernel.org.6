Return-Path: <linux-kernel+bounces-444348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F2A9F0522
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1AA188A1D6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8301418A6BC;
	Fri, 13 Dec 2024 07:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w1wEXffi"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B05126BFF
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734073333; cv=none; b=KwsJeOuNa9Sc5o5N+eEmmIGOcfQy8w1II0h0pJbpactu4IBkmhLy22890c2WC2ZstqdH2pGiygWNXetcVcxeFBsJY3pEZeGgkaBG6+E23PJqpxZA6QViksXaf44JUy0ygZteuuxMziSzfhOc8AwWvjj9nVQeO/9RaFSrgsMrqms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734073333; c=relaxed/simple;
	bh=UjhnknRyDJNzYPOotnxU7GzyFJZx+ejiEGfMpctiaRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnW3krjRLFkns+Q1SHgFtRo0R6MR9asZsEeEKTZEUR+rxTzhLeGEOyU/Lt2sgkNuSK74drHgKOtm4REgajnlvOIFTtnHkqeMd8MfpskREqOVEiQjeIoI9doUwbAU8hxg6UXRLo74LBGodGGrheJeXWXkxVPInNHkdhgotWg32WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w1wEXffi; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so1924789a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 23:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734073329; x=1734678129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhAnuKdh/c/FDEIjNH1nfvyxGXfQoHAQpf3lf/9fwIQ=;
        b=w1wEXffi/7vWMCFDBGEI8/YGTIxY2EtNOvcgQ19zd3O8fLFyobsn5ECyzQLXRqeenw
         c8T4nGlSIeP/wIk/YQRbgT/EGH7ho3qbFq45SY4PWiXpoqTNb6mGNLu1bT81ERi/7Cgz
         mT5wkfOJNLvRlbA6iR/B8rihpFT01gG0gPNwRFg+LWTxKeqRZw094nGgGSyZ920F7bXZ
         H3wT9VbN+z7v1d+zj0J5Po4Jsn0I6LEejlJa3wIkPtWxJ0P+YtevcSoXM88UZibH3hDt
         b52CFnyuCXXJhraaAECWknoBtBR0ttcG4ckgtAdKJVxOgbTFWZ2/M3bXPQtRD6h6Kah2
         FTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734073329; x=1734678129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhAnuKdh/c/FDEIjNH1nfvyxGXfQoHAQpf3lf/9fwIQ=;
        b=mhOQrlIiXBTNEg7jN5FiMZFyFq3nf34qSK0BezbCzQcaR9iBrVb3d1kJ16X/b/W0Py
         rj+e0jMnAxcusof48O9g/DF+QuxrXiVJEiho2uGSVHTY9bxdFuXPQBJRKA35B8c87ANC
         QNOR14IblKVl5I3V94ysXtT68sCrWpaW7ynhTY1IVIAkO5OKTZhm4QKfOKt2VpnOGkvk
         TVG3h0sr/O8Bq6F9R7ufrYPhw92rDzuWCga/cBAwTQj9kAC6ZvZf8YIt8fYtEgUDtS4a
         YZJYGwukIwQC6JXPJyJBNsWurRDze8rUg3KMdMMBIgecFsx5SxloXZTF6cKqlWDxpFkG
         GLyg==
X-Forwarded-Encrypted: i=1; AJvYcCU+Wa0gPpSAQLkUHwlea9UQltT0504ttueinyGLeImffZVMDI9NyUi2kmxnHXzixQLN2Tuwn6MHfSBtfyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgThCVjSNcyAd0fKRY2Z5Gp+LHftK1pa1GPIq4cyrrduGeiNon
	5gk9qLpOakZQBDURZ1aDB+emX9+UvpbUm8Vf7xq/5P93zg/RnKu2SXuQEzMZWKc=
X-Gm-Gg: ASbGncvMkj3uuE7WN9IOEtHvOCt3lNcbCQGIhBoAZIb67abmq/N4zgHuPX8w+mzi9GZ
	AZ53L487Neye0k5NMHTIIxZmHFX753bb3Tkv0eqYFBsMwUGwzhWNSRgZew4ILhR8FHlbBLKL8ab
	qf+a9yvObmgJTJuM+dA3Y1C2tSY+R/umPc7FObn04h8G7nrXCTLNTDyfeoizrTR22lQ7bbOAlu4
	AxpMxqxo7IA2o42CydT6K9LoJ2WdHNJ7qproivRGRTok2wzcONjKjO+OoJCqg==
X-Google-Smtp-Source: AGHT+IGnFALcx3AK2oJWGNjVHqlmqxe7d7X/VuJSfnDCsCITz+vzufCQ7Qs0N6+tbf4icQ6Bd2wWaA==
X-Received: by 2002:a17:907:720d:b0:aa6:93c4:c685 with SMTP id a640c23a62f3a-aab7799a226mr147669666b.23.1734073329413;
        Thu, 12 Dec 2024 23:02:09 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68c4b52b8sm640634466b.52.2024.12.12.23.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 23:02:08 -0800 (PST)
Date: Fri, 13 Dec 2024 10:02:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: eisantosh95@gmail.com
Cc: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Everest K.C." <everestkc@everestkc.com.np>,
	Kees Bakker <kees@ijzerbout.nl>, Arnd Bergmann <arnd@arndb.de>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gpib: Replace semaphore with completion for
 one-time signaling
Message-ID: <675aedb1-b7dd-4565-b028-1a718fe3fb09@stanley.mountain>
References: <20241212162112.13083-1-eisantosh95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212162112.13083-1-eisantosh95@gmail.com>

On Thu, Dec 12, 2024 at 09:51:04PM +0530, eisantosh95@gmail.com wrote:
> From: Santosh Mahto <eisantosh95@gmail.com>
> 
> Replaced 'down_interruptible()' and 'up()' calls
> with 'wait_for_completion_interruptible()' and
> 'complete()' respectively. The completion API
> simplifies the code and adheres to kernel best
> practices for synchronization primitive
> 
> Signed-off-by: Santosh Mahto <eisantosh95@gmail.com>

Looks okay to me.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter



