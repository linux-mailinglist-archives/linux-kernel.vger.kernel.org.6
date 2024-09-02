Return-Path: <linux-kernel+bounces-311715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 033EE968CA4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5FD1F21E4D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E6D1C62A0;
	Mon,  2 Sep 2024 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="W9XMgBNt"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEF81A263D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725296641; cv=none; b=trwm6YtJpsrbRAvUlisMi7tK870yMedCv7Ymx9/HqgCCUzr6QC1EXB1VeBiJLedUUdAacF4IWoedcxQgl8WM3KrdlorAd/bm1qGVFxrr4TGVWOEX0RF5V0S9w8b5de7Fxc/KLBibUHJ0nvpm3qDV0pTSbslPkAllUA6I+bGoaYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725296641; c=relaxed/simple;
	bh=9wT4eK6i4oRyeo8ESmVM6UAdh0mGMkMy5q2Pm/qg14g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7hjteFVba1qNRFw78NcEzRw90ae4ypuYXiWzVB9ZyVGe9RXWFALQqW37MOIwJUoP4PSgrY6pPdfNv6CWTVoG6wk5ejVSroU5JdWsH/YNGXCIhNwYRF53iNRb3CWX73cxFf3dFZw5uJogNKHBDAbWqOviZkkgrSckuTCnXqrVow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=W9XMgBNt; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53346132348so5495364e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725296638; x=1725901438; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eVxlP4RyKCk0u7iRGxclgYQWGFkYbyTH0ZYWhwSGXng=;
        b=W9XMgBNta/BvjH45JJxKxV0mYQ4JbK33cKSBz4VkzaZBWNA763lZ2ye4SUSY1id3iN
         zPfd6DWrt1GWwokqQcr5jEeblcJtg8XNKmjkXxss01P76KS4mTS+I+pqcXqz1agiGlCE
         9oy/2D/Vgd/6wHFtkwaA/4vbkM8P1UYlcB6MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725296638; x=1725901438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eVxlP4RyKCk0u7iRGxclgYQWGFkYbyTH0ZYWhwSGXng=;
        b=R05jQZwUldgIU9CjAzvY86pZjvYwxc43ViZQoU8xIfKLgmyEUXn5kifBazlzNfC5zJ
         jUbRJgv/k/vF45NaQR9Z57Vj/hBLNSCZYBJixj9u0Z5xVasMK9s3Pru4gsBld71JBmBN
         XlxIHgAW8HlsNwNbWVBRvLkAwK8DH5ZQv/3s8nV5pJQmpLQT42SrrC5ThNdfM2TsCLLv
         keiVNJQQzfb7Nylnre0WYBhbWPLGb+6d87STAgTZEkRhpddQCLSVjpaN2MUIvgX4Lofh
         wApWP7LzT0UM8vrA7sVtc0ZjsIghI1zaitb079if4sGF82PvxzDlsmoSXnRYtbCM3QiN
         6ZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkQZ0n8eOEPw5khEyLYPdIhXxj3fhlEvpQxSnlMR4k934dlMmSrdWNWqTavMeUhcHjZYkswXILiTM9vfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8go4vUGbD2av7+QJ5lUZGGF2p2d9f8IgmoW4uOw3t30yWfgor
	02CS81yTpGWQ/fYzUjftX4tik2k1VoOWgfdT7f07Qen8KTYhgFWNKSf+u3UO82Y=
X-Google-Smtp-Source: AGHT+IFsIwWYLr4k9FC/e54AWYYLHAUzwqeRipuDwNOUraca5ExOev4/1PLhg++PWnCr4gnV/rpzWg==
X-Received: by 2002:a05:6512:3f03:b0:52f:c14e:2533 with SMTP id 2adb3069b0e04-53546b91c02mr7693393e87.48.1725296637468;
        Mon, 02 Sep 2024 10:03:57 -0700 (PDT)
Received: from LQ3V64L9R2.station (net-2-42-195-208.cust.vodafonedsl.it. [2.42.195.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d86b5sm587968266b.178.2024.09.02.10.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 10:03:57 -0700 (PDT)
Date: Mon, 2 Sep 2024 19:03:55 +0200
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: napi: Make napi_defer_irqs u32
Message-ID: <ZtXv-ywidT58IyNj@LQ3V64L9R2.station>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20240831113223.9627-1-jdamato@fastly.com>
 <CANn89iK+09DW95LTFwN1tA=_hV7xvA0mY4O4d-LwVbmNkO0y3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iK+09DW95LTFwN1tA=_hV7xvA0mY4O4d-LwVbmNkO0y3w@mail.gmail.com>

On Mon, Sep 02, 2024 at 03:01:28PM +0200, Eric Dumazet wrote:
> On Sat, Aug 31, 2024 at 1:32 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > In commit 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
> > napi_defer_irqs was added to net_device and napi_defer_irqs_count was
> > added to napi_struct, both as type int.
> >
> > This value never goes below zero. Change the type for both from int to
> > u32, and add an overflow check to sysfs to limit the value to S32_MAX.
> >
> > Before this patch:
> >
> > $ sudo bash -c 'echo 2147483649 > /sys/class/net/eth4/napi_defer_hard_irqs'
> > $ cat /sys/class/net/eth4/napi_defer_hard_irqs
> > -2147483647
> >
> > After this patch:
> >
> > $ sudo bash -c 'echo 2147483649 > /sys/class/net/eth4/napi_defer_hard_irqs'
> > bash: line 0: echo: write error: Numerical result out of range
> >
> > Fixes: 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
> > Cc: stable@kernel.org
> > Cc: Eric Dumazet <edumazet@google.com>
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> 
> I do not think this deserves a change to stable trees.
> 
> Signed or unsigned, what is the issue ?
> 
> Do you really need one extra bit ?
> 
> /sys/class/net/XXXXX/tx_queue_len has a similar behavior.

Sorry, Eric, I'm not following.

Are you asking me to allow u32_max for napi_defer_hard_irqs the same
way tx_queue_len does and avoid overflow that way:

include/linux/netdevice.h:      unsigned int            tx_queue_len;

dev_change_tx_queue_len(..., unsigned long new_len):

  if (new_len != (unsigned int)new_len)
          return -ERANGE;

