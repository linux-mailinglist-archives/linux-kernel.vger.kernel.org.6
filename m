Return-Path: <linux-kernel+bounces-409498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153799C8D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39A78B27DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB3614E2D6;
	Thu, 14 Nov 2024 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sY1fuPqZ"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E57213BADF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731596897; cv=none; b=SJQkAPfBksNdZlXZnZuzit3tj3840hlxf78GtVTrbMvYyD194QCGjd/J0uagUL2du7GQ5uCBuS3jXztDxHKqOmExpiFZSykcfIEoG2JHLBP7Fvrhef4ePjuj5p0Z0AG4XlTCaJe9MKJKoGMWyPcU0xJSR6lM4GjNVwwD8Xu/jbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731596897; c=relaxed/simple;
	bh=/BYQNd++hlfPbuOhq+QHwO6NZMZHHVCL1uTzzD2INQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUy5fxRD3IE29oLaSCj9P5v8m6wIUL6ptbTeXvNjrsCCcMiE50nqZ7QMTrwgsWFpqohSf8Z7lDdyl4ZOziXC6VA/jhJAjHPPCdpgshA6rXdjgsrCY7buJ6Jgu1q0n9o/Al9enMWO7c8ObEAS6oEbhR8l0PNgN/Gt1e/juRHN6DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sY1fuPqZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38221306992so221484f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731596894; x=1732201694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AgEfLtq8i/M2M75YOJzjdmjGGJwIKwjUcYodGngqvzE=;
        b=sY1fuPqZue0E6O7bT01aq2X5PjRR/YvzITyxTf8csOImt089a3WQirDz/qZgi1RIFr
         DNy7gakNkL9rhjoFnXzHLVmHOHnWpLEraryNB70x5AYQFg7C/Lll+op2wzr0Iw76u+5G
         lzrRxl/eIP1L8IqFqX7ju+lg04411u1bVSRvd3jHT6MYdfrYXo4JPuY8L2ciWQvYSnlH
         DWlx84gCumhHv/peNcDZXV4it8ARmFfBqhs5uTJ8uos1P1qJYSVsreT0hmf5nnjeqjBt
         xcqilkJ8POSkn3SbxuLXXX89DV+BUE/QjDqAAXJZykx65b7gCG+KvSolnCgNJqd+r5oG
         xIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731596894; x=1732201694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgEfLtq8i/M2M75YOJzjdmjGGJwIKwjUcYodGngqvzE=;
        b=uM4kBzOmH2FNQZCPj8u7AyGegL4fQpyrkwlT48pmlMoM5p3Lra5ugITjgb856Xczrh
         bIclar4yIG6FBenytorkHo0CrfDL2f5WJzVzvr+TfxT5BUrF08l7hWPG0bhr8hJoxfSr
         qBeZiKHKHWdUduoFEdNgU/w959VrkO69h0EQ6up5qV+f2rb5QiHD8LEcPxHGLdsiQzQA
         SKpO8CSiX0Ebmd8Wv1ZCSvYUxp3Z0nCtB5yVHhMcNml35kzg2U0X3qi8jZoLeChmIp47
         VwTHtJeinLK53aRd5Ro0orQGwh8RkJFnEwOEyM+uMY7bQizZRKmRlnDMQSLRJvIm9r8D
         BtNA==
X-Forwarded-Encrypted: i=1; AJvYcCXO2ESyKbLDGUrtuSCcmJY+cqlYzjfmKu4zFROk68E0571YZnId5WveBtkqzwugW5LA6l2zAVOXdC4HMF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT9XQBbYSPCWbuDeFTZkDPHg5Twfr1Ki1NELXZjF7FMOXyoM4W
	cI6Hu+VCzs0VB+pKPlyMVF7R/Z7G/uyq9P0v+OXKuC9cUD3Tedg9jrsxrqIDNA8=
X-Google-Smtp-Source: AGHT+IFplMK03X58NbalioWaxnFldro9DAQmBOQt4nnGHdoMh9Yy1lXTcO15M41+5hv7LNH/if3ZJg==
X-Received: by 2002:a5d:64ce:0:b0:381:f5c2:97c9 with SMTP id ffacd0b85a97d-3821851c110mr1743132f8f.25.1731596894541;
        Thu, 14 Nov 2024 07:08:14 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adada8esm1703155f8f.36.2024.11.14.07.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:08:13 -0800 (PST)
Date: Thu, 14 Nov 2024 18:08:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Max Staudt <max@enpas.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] can: can327: fix snprintf() limit in
 can327_handle_prompt()
Message-ID: <0c4ebaf0-a6c5-4852-939b-e7ac135f6f32@stanley.mountain>
References: <c896ba5d-7147-4978-9e25-86cfd88ff9dc@stanley.mountain>
 <6db4d783-6db2-4b86-887c-3c95d6763774@wanadoo.fr>
 <4ff913b9-93b3-4636-b0f6-6e874f813d2f@stanley.mountain>
 <9d6837c1-6fd1-4cc6-8315-c1ede8f20add@wanadoo.fr>
 <20241114-olive-petrel-of-culture-5ae519-mkl@pengutronix.de>
 <7841268c-c8dc-4db9-b2dd-c2c5fc366022@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7841268c-c8dc-4db9-b2dd-c2c5fc366022@wanadoo.fr>

I'm happy to re-write the commit message.  Changing snprintf to sprintf() makes
me so much less happy...

regards,
dan carpenter


