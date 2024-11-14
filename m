Return-Path: <linux-kernel+bounces-408995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 794B39C8635
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ABB7B284F7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8296E1F7552;
	Thu, 14 Nov 2024 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rvmgsPyb"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D70B1DED79
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576551; cv=none; b=HVrebOPTXmRwBmNPGyeMz0rQKFh862VyE6HWxG2rCk1fwF4wsyh01AdlDp9bCTjpXK7M2aeVqYX0KGCRweuOUYmqrGL3VnVOaVB9w7UINw78d5qZVT1jKz26yhFzEN+TgLTe61V5YL4nV8YNu1pIA7/D78KBtlO8Lnp9eUpfDro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576551; c=relaxed/simple;
	bh=SunWVLxZJU191an+c75kTT6SIArlemY5vm2v+U03SGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vd32ZgApT659OiLaFmhIRUXNpaYXQ01m7dnXGX1YwJf8mWRFmj7vC6og+Fs8t9khTXtU0eADQTMqGPSJXnW+57urMw8rTDMmXZOdNXFDRvU5DdnatuF/bZwZpwerYUkocKybPcbQxX5Dj+1Cvj8SLz5PjJmYn6lpHipQzbzvhJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rvmgsPyb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-432d9b8558aso3031305e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 01:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731576547; x=1732181347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nS1EJqfWpVBxhs4KFRyVItEivrNNryuQ6Ge6sLEQQzg=;
        b=rvmgsPybBABEfCgrfeczr90Z3zLDGWvaDlGrPsDGEZ7cT+yIBwyXSQxjywJZQK467v
         LvPyGCisaSo8U87xyA88aUW5MnXzDo6ChTK9l7tjB2CeB0YH4CLcAgicWWwmaHhB6V3G
         gJsc6uPChCYdtGs1o1eZ1zt+cRblivoqBUWFendyuZd2xMF5g7dFzadY3ZxWeI8kFPT+
         avNei5N4jBFiVisYUlZZESAcKPL7sfqYYItO+O6A3WM68KoO+IgbnXGuRQ4fR3tIb+Mt
         /97rnym+1dDTZ5Y4lqBfan1m3ydiM7YjbUaaMbNPePLsfg4e/LMDDnc0XtjqNGCw0EMa
         7AbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731576547; x=1732181347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nS1EJqfWpVBxhs4KFRyVItEivrNNryuQ6Ge6sLEQQzg=;
        b=Ic8WvWUBpk1OHvdjoHP7tXrEZl/3XmQYY8kCedrcg8huvg3dCOycINywbJClmdUkP1
         5ySnb4CoqY81h3wSmnA4zfpwIIssP6oWCRe5VAQ0QBQxmK2pkD9Zj703GmN9tDn005Cq
         X3YOUCOThYKIFqhrRB83CxYDpqgkWxGnrihJEjKkFOlDiS+y8/Q2kL3jGaU0UHSb0xd6
         iduKSY5ZqmMW6HmAyEOOp0z6prd2Hzs/TORyyu1D/jWfheL8o6fZATvbTTPjGhFYid0t
         1W35ncjIYmIplgcIifTMUfVOIJC4krscr3MD9UAzz7upjX43e8Uysq7dC1wjLSJoxeDt
         xraA==
X-Forwarded-Encrypted: i=1; AJvYcCXv4aPIiGwVsuK44AGgG6hiheftPXWC44oNhelF1/SMeltOcaLuG2tRqfIX8ltj+ZcK6c13xG9xrCrhc9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDNnJ2J9pCbOvDVWFWc10VnxDXkTKPp7nRC8rVuLuP/SEDVn1I
	pTZ277XOaVQFXgyLJSWuAoy2BT8OeBPDj69S9C966U8DxSATpXr2sZCUXjjqZ1A=
X-Google-Smtp-Source: AGHT+IHa+GwPw1XMCZ+cH9jSTN1XwUkHTtzXZGQ1rcTxNIzhWEEEwnyYXS3SOYBkd1TsYzhe+styJQ==
X-Received: by 2002:a05:600c:a4c:b0:42c:b991:98bc with SMTP id 5b1f17b1804b1-432d95ad53cmr21357685e9.0.1731576547571;
        Thu, 14 Nov 2024 01:29:07 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d48a7cf1sm47674685e9.1.2024.11.14.01.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 01:29:07 -0800 (PST)
Date: Thu, 14 Nov 2024 12:29:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Max Staudt <max@enpas.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] can: can327: fix snprintf() limit in
 can327_handle_prompt()
Message-ID: <033f74e6-2706-439a-9c02-158df11a3192@stanley.mountain>
References: <c896ba5d-7147-4978-9e25-86cfd88ff9dc@stanley.mountain>
 <22e388b5-37a1-40a6-bb70-4784e29451ed@enpas.org>
 <1f9f5994-8143-43a2-9abf-362eec6a70f7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f9f5994-8143-43a2-9abf-362eec6a70f7@stanley.mountain>

To be honest, I was afraid that someone was going to suggest using on of the
helper functions that dumps hex.  (I don't remember then names of them so that's
why I didn't do that).

regards,
dan carpenter


