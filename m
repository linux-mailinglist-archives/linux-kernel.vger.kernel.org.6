Return-Path: <linux-kernel+bounces-338311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70538985646
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD301F240E8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A861015C121;
	Wed, 25 Sep 2024 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EY4Tcl0E"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1BD15B0E1
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727256222; cv=none; b=EcSHnUd4q5BlWVu3O3SfBzNLO1EiPaubhYLVH63mkwUMgnlS7f9mCRFdaTuJc7aI1k102XR8KEFjgOdkxmKNN8um2Y3KbGBOgWYO4H5QgZS9U3WARFu580x4cucWZGZVinIMqKBgsJl36872QE2rIbpTAySbQlPbG4nK4/Htg5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727256222; c=relaxed/simple;
	bh=CsHNgHDX5NSd5k6WebfGUFU35z5a3oFsvU7LyCdz15k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbpIYYymSafqk08Ppo094O2FKlTPpj2CecpMooiEDzr5+RBckKLqFADgiDdiiwPI4U5pFvAxqlvcz1YfokFbwys+LZjmIzN3NV+tbQk8I53R/sWAaTjWZN3qvF+fyzxD5f5lK7Ks+/7nX84uSD3CfEOeQnq9fzQs+dWHc3XE7qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EY4Tcl0E; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb1758e41so53135185e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 02:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727256218; x=1727861018; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Erl2ISmU+k1lGSmb71kUBr7EKO9urA/bALpyymmkCKY=;
        b=EY4Tcl0E4q9fYrFUiO0XrAgtXK8dNs3SVxIz4qz8lgSGa2+NVp7Q09YWZqojK7ZVHy
         1tZ9J3xJrC6GDOQqQ48Y5TkZZuDsAjrQML3j7NYnekDmG/Wq8ykgxmy8KFaLWLDBqjng
         nd8kn1kOLmK8BHCTuc0gzviAj8poCmUJm3m96IfpZFmry1Lny81c0cuTCtR+0uxf9Cg0
         ANBsy3842Qq8hTaRZpNV0fpwUi2Opd0KrxcOXI+LRu+hl7maz084EMPBcH3Ao5bYSHtO
         7o7Insqkwynv+n+6p/uWIUcHd4md5M7ZrsEQkGCzA/iU8BQi5+TBWISkEe+13Ii5UJEc
         Gk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727256218; x=1727861018;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Erl2ISmU+k1lGSmb71kUBr7EKO9urA/bALpyymmkCKY=;
        b=LNoyJ0fnrpmhtdp+IRWgCZxq0DJFCBmsgRfzzRUzGv/leyHk6onVuN/5y8yeRtNOMP
         rL6DmTzQk8Towh5LpVKm0ZAbOMTHSYr6CpmXDDTjoqHqeznUNukaIKQsaZ/yhiT2cGkQ
         HIEspLOJ3cetdvCt7kUApQJwlq3pynS8OG3hvsMdxGiDVttVoKEqy/6ZTsHJKfcwnwSj
         lwezL4q4m+Krfwdn7U7lmMk8tbEmlJgMwL8xQP8yA9KGUi4kiqpHYQ4GQz0PWVI1AyVn
         74XYXTPHjEPNJb+QFZMFQQBKEqfHOahVg9zSIdQ7ubEE1KZpt2jfAuh4WG8rp0bSvan8
         bhGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfPntQP2yYh6OmJ2fwcwmdCdY1XsPeNe5OjByWXk3l6X65dKVkcKPfWoFAaXG0+4HVxaaiC7mJaiFr4pU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHVZ6YcOXpZyQeoh/ZhvddUvfv9PcGOQOS1tdOFwFuC1lxpw0i
	ZidYruwzJDiZuUjMAXj7bMTXlho0Fzn8J37wilEKPaUBFBAxfbzGcDhffqGivg==
X-Google-Smtp-Source: AGHT+IHRfauL5Udmy6C13QIxy5atPl9zt31xORaSC3ESwbQ7cvwTL7aLRZCIbVJrka2xQA7ywfRrPQ==
X-Received: by 2002:a05:600c:4755:b0:428:10ec:e5ca with SMTP id 5b1f17b1804b1-42e9610ac97mr13190325e9.14.1727256218476;
        Wed, 25 Sep 2024 02:23:38 -0700 (PDT)
Received: from thinkpad ([80.66.138.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a168bdsm12264245e9.37.2024.09.25.02.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 02:23:37 -0700 (PDT)
Date: Wed, 25 Sep 2024 11:23:36 +0200
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Shunsuke Mie <mie@igel.co.jp>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/3] Add support for Block Passthrough Endpoint function
 driver
Message-ID: <20240925092336.mf6plixpqe7fcsoa@thinkpad>
References: <20240224210409.112333-1-wafgo01@gmail.com>
 <20240225160926.GA58532@thinkpad>
 <20240225203917.GA4678@bhlegrsu.conti.de>
 <20240226094530.GA2778@thinkpad>
 <rq85odwmqryrr4.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rq85odwmqryrr4.fsf@gmail.com>

On Mon, Feb 26, 2024 at 07:47:30PM +0100, Wadim Mueller wrote:

[...]

> Okay, I understand this. The hypervisor was more of an example. I will
> try to explain.
> 
> I am currently reading through the virtio spec [1].
> In chapter 4.1.4.5.1 there is the following statement:
> 
> "The device MUST reset ISR status to 0 on driver read."
> 
> So I was wondering, how we, as an PCI EP Device, supposed to clear a
> register when the driver reads the same register? I mean how do we detect a
> register read?
> If you are a hypervisor its easy to do so, because you can intercept
> every memory access made my the guest (the same applies if you build
> custom HW for this purpose). But for us as an EP device its
> difficult to detect this, even with MSIs and Doorbell Registers in
> place.
> 

Sorry for not responding earlier. Conversation got lost.

Yes, I do agree that some of the expecatations of the current Virtio spec cannot
be satisfied by the physical endpoint device. So I presented some of these
problems at this year plumbers and the Virtio maintainer in the room agreed to
have changes in the spec to fix these issues.

But it is not clear atm on whether we should introduce the changes in the
virtio-pci transport or introduce a new transport altogether. I can include you
in the discussions if you are still interested.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

