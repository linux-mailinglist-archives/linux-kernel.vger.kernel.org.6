Return-Path: <linux-kernel+bounces-537247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0D8A4899B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C11027A7140
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1707A26E962;
	Thu, 27 Feb 2025 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JPb6tUCB"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7BF1AB6D8
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687382; cv=none; b=pggsPHdgfRHJ/iMbjzrnRU5ouXwDF/KbdrPFiALmJ9zKycKrriGyQvVf31KxXN3/9J0CgmLP5g5LRUOJsZdwlpy066FLT9Lgd/R2QvApshe6faTo7CVf5f/YS2VaOe23mXGGuE8bdmykiywqZWKNCYc0HEMPjBKdGZW9jtNGDZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687382; c=relaxed/simple;
	bh=84h/RFLZWqWFvHRkgj2Eu5xJJkjpYWE2cje3cUPANmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1yu5Di/iTqjpPix6XyiQuekmBKpyIiPkr8Ztqp4ly0qyM1iWzA4tskPIaI8w8+/6yZpsqBiG0mXdzpOThXFtpaa25lrfhGfDxcOCDTNvusmbfpprDwQee4HftnOk9rn8zbMn4jYN+OQyhwwAmG53C2CVWfnA8JldbXpnK75iac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JPb6tUCB; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so1938978a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740687379; x=1741292179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXJZXOlj8RS1CWCL6FlZJfuUCxngSMS4ulOS9DCvcgQ=;
        b=JPb6tUCBvSy/ZnRCx3SUCN4rRmGuGgZPARCgj8O8/97I7p0JYXwc6kxqKoEwZ5QLj+
         RAFP2Q7qMVbByfbAJ41a7f0/l4jyQZsl5Au6/r9ikU9iVgWNJhfLKpA67G6vYmZus568
         HZCo+WzE/og2N8XJo/rR8NFGlfi9WBPi8GPGD7BycXx3ihfOBREVP5lrXtnEIsMuulc2
         4F1ctBD2QDq2sZDNupzzhf4Uvqcyo8Uv9ITEs03TFfC/YO59gjsLv2d6JoM6wwViEtoR
         gxik6bUHHLRjQaRO9tv6slYIMuWRdTJ/Wpg0U9F93ken1NskvVlvO/qgHncC28V6D0UF
         q7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740687379; x=1741292179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXJZXOlj8RS1CWCL6FlZJfuUCxngSMS4ulOS9DCvcgQ=;
        b=mIibZG3TvNsqhIS/66HQcA0YfyxzMlBqd+xhEHh/HfMkTo9Y/k9TZH4kprTkIznMaF
         Ep0d6/V400pbgtF26xgMkPjGqedF04F3GtRSCqRbaY7twbkjmlpqr8ybI6Q7Q3PWV/zH
         3zkceed72rUjNFsfN89sj8meGjpmv4Lln3voUNDffj8j1ptU8Tny6CPPL/MEUwDbY+tz
         hZdl2zSkUA0AZtIARTWgmfGbx3WcHzEOyG5B3yX5lE/6fWkZP7OQB8ePsttM2TmvuTKw
         Fe8rpuFBcDhvaP8X4qm6E1imnjFRTJND9aEtKv9j3XLx1ZqpcAXNgYEkFrvzqD5T4q6v
         seTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjOcnvqKsOqwqu1ze6gFNS9DGdiSlhn3xrZGPTsvmePqf+4M0k/SCbnl+PlFxT3/JTg9P34xmuh6b3OvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM7TJFIqdoodQQMKqqIYJXwqAIGm7CbLX1NIWc8wRgPMswzTLv
	Np6bh7/V4VDyN+bVLMf25j+5Kx2Ns/l/m8xpV1/UCOcw1HBxLHXJFExdKE+G0HM=
X-Gm-Gg: ASbGncteEleHWwe5cRBb2pw1McZQZgxtQfq95sSizBUs4UhQNlAo/L4Z4xTuiSUk9Nb
	m/HoJWxtjS2K/QpGs/KupmMqywovkTjN1ARPT36rr1eQSYlMYL83sD69vnsY/KoLQfnHg+P16+E
	SCSwZXkup2e61espy49pfQZ/fg4xXi1k19laOU2ZyhcFdc6AytjFc4HAh9LWdpwHKekH+c1490y
	wivHRBsCVp3/awnwtvclDXW9Ax+Pxm6av6GMCo0fvvinzogJoB17JJK4IJNjF25TsU1Lb6vgAqI
	Ev0joDWJ9jV412B/X99HOw+HKB0QUBg=
X-Google-Smtp-Source: AGHT+IH/bEmEblcXab5Tj8A0iK4TBeBn4mn3wXNDIIFNA5wM6pq+whn3pw/0Z2EMocbp0uIvyh267A==
X-Received: by 2002:a17:907:94c7:b0:abb:cdca:1c08 with SMTP id a640c23a62f3a-abf2642b53emr72174566b.16.1740687379227;
        Thu, 27 Feb 2025 12:16:19 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf0c75d8e8sm173381066b.146.2025.02.27.12.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 12:16:18 -0800 (PST)
Date: Thu, 27 Feb 2025 23:16:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Abhishek Tamboli <abhishektamboli9@gmail.com>, mathias.nyman@intel.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xhci: Fix bcdUSB initialization
Message-ID: <150a2fb5-f1f1-44c3-8923-e23589d5dabc@stanley.mountain>
References: <20250227193400.109593-1-abhishektamboli9@gmail.com>
 <2025022757-extrude-carpenter-5bec@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022757-extrude-carpenter-5bec@gregkh>

On Thu, Feb 27, 2025 at 11:36:24AM -0800, Greg KH wrote:
> On Fri, Feb 28, 2025 at 01:04:00AM +0530, Abhishek Tamboli wrote:
> > Initialize bcdUSB to 0 to prevent undefined behaviour
> > if accessed without being explicitly set.
> 
> Is it actually accessed without being set?  If so, please explain it and
> also how the compiler is somehow missing this already?
> 

This is a Smatch warning, not a compiler warning.

regards,
dan carpenter


