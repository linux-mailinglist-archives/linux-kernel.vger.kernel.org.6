Return-Path: <linux-kernel+bounces-190119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB8E8CF9B8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7409B20DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5988D17996;
	Mon, 27 May 2024 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TbfDjzsr"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C948168A9
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716793589; cv=none; b=TuQN/riw+ch9nuAVEEvxTmna5bMAtd8xPUjEfDL/aFnkOfXX+lWTcIaRn/KK4qg4uE4S1OYnT/Q4oyhlqC6ta63fjp4ftI4EVL5yLX7rJSV33B5SqY/aaMEmOm1+eDhqcQlm5mBtXs+jRPcGhA/OoGZt2exXOLr8qjuJdm2GRhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716793589; c=relaxed/simple;
	bh=vD/fI/si68FnOskGxoweJMK9vp7Gw+FaLiLMBcj+XIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZ3kE/RgyKuzx7KIhAXpvTXNg6k/XaJRQQ4vIXey1YQ62I5q6xiCymgl2XaJFk9hNP+ur6SaAhGfgSjUJvkh517POdNKNM49UAzfqO+/D8kLoud2NxoM63UUAyGA2bvG+XnBZlXHZ8PnKuxyMmF0EtPSZYlOl29c4AI+qEBnK/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TbfDjzsr; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59a609dd3fso880635466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 00:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716793586; x=1717398386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9iiWAsBL4sUAAyXN1wW7ThRR/ve5l1Ot65zaK9TenVg=;
        b=TbfDjzsrsw4GRTuu7QPj+vyd6u9vkxRR6RLRbas+yr11UjySiarwsiz98XEuwWab3G
         Aey2XYrBAcr6ox5QIPwW8tgf95sbqsALQc/FC4ii9NmHtb8ulY4KIz/yetJx+gKZFPoL
         J5idHrSnJiZcBZCryAeW5Hn9PAlYUKpE27eDIp5eYPAwymbvbFeRyOavmC9QimuIUOjt
         AGi4kA3w8uK2k/XoHsf6TEcYnOypq2Q+/BZwrSXVzRpo9jSfcOJxSJXH7Oz4XXZML236
         sbBxTKs6AMqcUZ1BZ8mgqvvglqB7GGynERAjCbirN+HrKbUK2qanHoZOOs/4pYkvva7d
         Pj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716793586; x=1717398386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iiWAsBL4sUAAyXN1wW7ThRR/ve5l1Ot65zaK9TenVg=;
        b=dnzQvw0kapalZC+j7nJfUH5ZjnAuAhl+YNsDgQBpdE2HgQORTYyBhCmNyx2zRHNH5o
         99qj4HjtdL3hMfg2PJtZ2eGZzfphRVP8R3BdvnM22Kyms/hOQ7X+QKig7xjw/CZA6bqc
         71ABpXvRUa5k2hlShN7igAvs2mjqpa+MnRrL8XUj8qd0zvpnghWIv0PzdyuF/WFOlu86
         2IWPkSjExim0Ijv5HeLJ81O5rNBdBmJzoedPMS/73Bm0KNEVXKYwQIqMKcUI6nuadrVL
         dG0M3A60Yud0fuuzFjOybKDpZyWKqUl7VH0FqfPUPDRQBk9WJ5wpImdqoJhmS24IFhht
         p1tw==
X-Forwarded-Encrypted: i=1; AJvYcCVy/GKtuz6XlI1dV4DoZ/rx1H1OqU6vRL6nFxSayvvdII36LuIPJsK56g0Mzh0BnCKWDYDdFCYmlLN6vhChKonkGcHgD/y4zUHi3zKi
X-Gm-Message-State: AOJu0Yxm1KQN+tccZtzitC8lL6BKONgTtYoLCL2IsIYhm5ZH6AqMX4IO
	JwC7XlycAMfs8ZUU25Fj1navpAXr9txyQKuAOF51WhfcCDQks5Jlr5qsqvWugRU=
X-Google-Smtp-Source: AGHT+IHyaeq4wv1RvLBXozqFAsVhATzJUUONek4ppAnjG7f+qKPIvRzF6NbSHVgqGiOXrsqQqZ6oKw==
X-Received: by 2002:a17:906:459:b0:a5a:8896:73de with SMTP id a640c23a62f3a-a623e9d51f2mr923081066b.26.1716793586266;
        Mon, 27 May 2024 00:06:26 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc514f4sm457491966b.108.2024.05.27.00.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:06:26 -0700 (PDT)
Date: Mon, 27 May 2024 10:06:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
	Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	syzbot+83763e624cfec6b462cb@syzkaller.appspotmail.com
Subject: Re: [PATCH] staging: rtl8712: remove unnecessary alignment of
 pxmitpriv->pxmitbuf
Message-ID: <92412c38-8fb0-4a81-9205-7735ae21459c@moroto.mountain>
References: <20240525073229.4144612-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525073229.4144612-1-namcao@linutronix.de>

On Sat, May 25, 2024 at 09:32:29AM +0200, Nam Cao wrote:
> This driver wants pxmitpriv->pxmitbuf to be 4-byte aligned. This is ensured
> by allocating 4 more bytes than required with kmalloc(), then do the
> p = p + 4 - (p & 3) trick to make sure the pointer is 4-byte aligned.
> 
> This is unnecessary. Pointers from kmalloc() are already at least
> 8-byte-aligned.
> 
> Remove this alignment trick to simplify the code, and also to stop wasting
> 4 extra bytes of dynamic memory allocator.
> 
> This also gets rid of a (false) warning from kmemleak. This 4-byte-aligned
> buffer is used to store pointers from kmalloc(). For 64-bit platforms,
> pointer size is 8 bytes and kmemleak only scans for pointers in 8-byte
> blocks, thus it misses the pointers stored in this 4-byte-aligned buffer
> and thinks that these pointers have been leaked. This is just a false
> warning, not a real problem. But still, it would be nice to get rid of
> these warnings.

Are you sure it's a false positive?  I've always wondered what happens
when you do:

	p = kmalloc();
	kfree((char *)p + 4);

regards,
dan carpenter


