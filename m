Return-Path: <linux-kernel+bounces-428089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E919E0A0B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8F5281488
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F75E1DB540;
	Mon,  2 Dec 2024 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LXxoGrUy"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EB71AB51F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160855; cv=none; b=PIWvGE9YAYJaf7qPydzTtEzAzY7LMyYqh3yEvQfl4jSulzV8uVr77wtNPSzbikvNtFKsPAzFZUnqy4dQsunNLkpuRkEfLNQo3C0BIzWG6c9QrRhfmFNiLUAAD4yr3Im65ZjxRMghm3XLie/MuROUCzAWTFH3N9Qf9CrLh0LsH74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160855; c=relaxed/simple;
	bh=ZcWhmQeTdhzEQEyezGlnWtKSJ1aRtj36eMfuAb5qXpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfSR6T9AYl9WRvuHgpQqj2W+k27XaydSHBTap81OaHA9QedMdRYdJ4UyDwPtV1R1Ao3TZh6RkPUK+2elhXVLbSZ/P4Z4uv5f0LIBDPhX8Wyx85dRa001hHrFbyPw8KLT4Re7tsYBRzr1pzWidv7QsoC2CYoVpbZb5cfRKDqDrSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LXxoGrUy; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-723f37dd76cso3982027b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1733160853; x=1733765653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/KBVkQ9WDET0JwE7JbXDlQw4ch/b8XOKIUlHGNDkFw=;
        b=LXxoGrUyVYux4eRfCJPVkd9n9MDdCmUyo/RtxN2bMmr+E2mm70sKBPJ4BHiUMYDiYS
         d/5+SM9usrJyH/4YWn+rruVhNhvvuMWD5B6pDskt1rxBJ1CRvRXyA6CvTwecI9F5/Mft
         vBXvwsVYAtlAS02Zv9DkxEfGKEcU7g3iHWB8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733160853; x=1733765653;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/KBVkQ9WDET0JwE7JbXDlQw4ch/b8XOKIUlHGNDkFw=;
        b=bUljBinJRC9aEiqqPW0AcoHvfsgTYM3WzkKOqj1yBj35/MYhFRHUuOK77xMUcz8+yH
         FzwfXMdO+ELjEM2VcDvHS5qDZdagGXwBhuyeQfvvFIYm4SNI18i3kEgfQAQCuEtKlCgx
         011V/Skm4KzKdiKMa0cBpZbwNRBFX51Wh71yXLuQz8z3zhsYYEI4p4eliTJzTPBeuLTf
         BTCNSGcP0I7MhoAA0ozyhliYgDt4wrizp2YmbDpv5Sp6ZAXH6We4nKE4LOHeRq+Khjlk
         i+4EzDeSqGOIOqJU8/EFzumdYSvgj6DMBRro5nLxYo0KkvJfDyKSGpqMsRlWJi6WeW3K
         yepg==
X-Forwarded-Encrypted: i=1; AJvYcCVTOH9YsUB+vTnS4idjq8/ZP26F1sZuY5xQHu1E0NYhanv4Riv4ecaeFHYZ+rH95+K/o6Vn3PAKDWnEdh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz63H073Rfe0bVW7ig7wcRQdqp5Z35FJ7ltois/5Q/ofQMelB1b
	iIQBWYFeQeW5p6Is6QUhhqIr6bhAyYP2ZboO7oy5qpPua7ayS/F7qAIc19PdORo=
X-Gm-Gg: ASbGncuNAdyBvj07ZST8BbLI8vlzrGWpYbdl9okucfGS6z0gUTb6mdOsBF35DtrOMEt
	N9kZ9jOOqAgvawkE4YrZ9P88N/jsyy5gtQv32IzubcJuKnpTdBojyApfLCIgugjIvBSugglBGbf
	l5J+xSND9cXt4qtsZAFniSmgtfrmqEecDCQwtRFNoZHIhJ/MaU2HF4yuq4lnXnyMxd7KzXVkoSu
	s6oTDeutnMh2YsgIuwMm2KxIGtx6B5Aj7TtYwsjXLaiLyvX4dnsjtziTGkAipyQl7P8vbZJeYxY
	ID2paUXht9Wx5Tss
X-Google-Smtp-Source: AGHT+IGdA7xHbfKmPdaYXg5efPm8iMgRtys8b0yolqaF3S0/bsz6LSFec8vyOdG86Jxh0+jRfA07Mg==
X-Received: by 2002:a05:6a00:1390:b0:725:1d37:ebff with SMTP id d2e1a72fcca58-72530141196mr32222598b3a.22.1733160852632;
        Mon, 02 Dec 2024 09:34:12 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c31164asm7042249a12.42.2024.12.02.09.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 09:34:12 -0800 (PST)
Date: Mon, 2 Dec 2024 09:34:08 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	edumazet@google.com, "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, pcnet32@frontier.com
Subject: Re: [net-next v6 5/9] net: napi: Add napi_config
Message-ID: <Z03vkLXa-wajZZ8T@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	edumazet@google.com, "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, pcnet32@frontier.com
References: <20241011184527.16393-1-jdamato@fastly.com>
 <20241011184527.16393-6-jdamato@fastly.com>
 <85dd4590-ea6b-427d-876a-1d8559c7ad82@roeck-us.net>
 <Z0dqJNnlcIrvLuV6@LQ3V64L9R2>
 <Z0d6QlrRUig5eD_I@LQ3V64L9R2>
 <20241130124501.38b98030@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130124501.38b98030@kernel.org>

On Sat, Nov 30, 2024 at 12:45:01PM -0800, Jakub Kicinski wrote:
> On Wed, 27 Nov 2024 12:00:02 -0800 Joe Damato wrote:
> > CPU 0:
> > pcnet32_open
> >    lock(lp->lock)
> >      napi_enable
> >        napi_hash_add <- before this executes, CPU 1 proceeds
> >          lock(napi_hash_lock)
> > CPU 1:
> >   pcnet32_close
> >     napi_disable
> >       napi_hash_del
> >         lock(napi_hash_lock)
> >          < INTERRUPT >
> 
> How about making napi_hash_lock irq-safe ?
> It's a control path lock, it should be fine to disable irqs.

Ah, right. That should fix it.

I'll write a fixes against net and change the napi_hash_lock to use
spin_lock_irqsave and spin_lock_irqrestore and send shortly.

> >             pcnet32_interrupt
> >               lock(lp->lock)
> 

