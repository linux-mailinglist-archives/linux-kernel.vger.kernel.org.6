Return-Path: <linux-kernel+bounces-546918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32619A50091
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 565203AB3DC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82435242936;
	Wed,  5 Mar 2025 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSNoeO90"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D750C2ED
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741181518; cv=none; b=OhlKAeB9tU7i+0xPe8R7Zr63kkEBS+NHaTiJ/kYzr2n0+B/2JWA4rqVcO4MbOIkih/FHcSRtBOcKkRKPeAd01GBnHt73qzxEp3409AScCWXGw2ffYgz0w3N2h9x7dzLVf/uFoH2tDRRIyUV9iPGkW5hjcSeYY4vsbZ5prWyxtVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741181518; c=relaxed/simple;
	bh=u2oWUXx1pOYjOKkp+cRuBclke+M/qTXSU/sDancxH1A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eUf0gNTTdYMJPMWmC8cmcYHHPcjvpHFVbzDAF0v8dmkO/8qiGSv7BQe5Txpq5DaLzP+7JBVAojMyQrXTbW8zdnuIen6AdERMfeHxZ4JQXVYLMuUl19IywgDFl38C8q2iQ9RGqCWhIRdvhlopRtX9oPX1uI1Px5p6lfItyq/C/K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MSNoeO90; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741181516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0dqn34a07lKcr5dJFV5JIso+d1clQqATo1u77Mk28XM=;
	b=MSNoeO906KJfcKllPxmOstquLh/F+R7/ISBl3rX27zuctZ9OYZCJWSCI3td2ckxCt5af2d
	aQcetASfmJ6oNozzkhL+ZRSzm7r5FT7mU0IM0PsO0x2UKo7g0k2YjYF1N/cgSiU+T/pp+B
	YAG60I8p6e99p5nA3IUhZ+sRX/yK4wU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-ruOJmhlKOcWyr5Ni33JG6Q-1; Wed, 05 Mar 2025 08:31:49 -0500
X-MC-Unique: ruOJmhlKOcWyr5Ni33JG6Q-1
X-Mimecast-MFC-AGG-ID: ruOJmhlKOcWyr5Ni33JG6Q_1741181509
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43935e09897so49632155e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 05:31:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741181509; x=1741786309;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0dqn34a07lKcr5dJFV5JIso+d1clQqATo1u77Mk28XM=;
        b=f+J/3MrB0ZsmOaa+diuNXqlTlLWCt5YATqZ0LPE6niyhkSCDvi0K76R4as7WkAyTT9
         RAesl931vILVvaqCKQ8FWWcoHz9/Wb5nCHeFfEs7uwnzsImxAu0wmYj6tnGbDFT4Jznb
         4JJ+ugDAtP8vZyjJ00O4IZnqTQtHfKWJTjlVdO/mU2vQBNidInBODUgMxDcuu3+rIWyj
         8a3vHPQ1f9BVW3ZzUYiOe9iOHxC/SHmuApE6yKVp78JPuu5ErFjeCjMVmhBbvnWApsZi
         28g391aRaksn3XMp0CA7FWCl1ab4YltzZ4IddFsTB7IcaGj3uNgSnpdTyFEQ1hTkZzwB
         cvkA==
X-Forwarded-Encrypted: i=1; AJvYcCWQPc1RoRQRHTblGMCAs3Qqzj9A4V8SzHdP3Y+gUOrRKUO8J/RA1PoNWzxyqAxtP0DpkMWk/0ISOom+3CY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd4K3E3eGC25Q+p9G9FNvZ78jmbQt4RrdrAFJGbVdIvleFp+b+
	nwybqbmAJf8KuXPNU7pxtr3sKdB1TyMOkw6tMOFUo7maatSmOiQXjxhqVtTiJMzVqXCtf7gL9hH
	o8xLg4KGFAexGiCKID4neR4+LPF+vE1tqAz6Bv1iw+WxvFgFwsLp7P6+n283UpA==
X-Gm-Gg: ASbGncvluuH+GZG12ihPQ4SmREZOryoOgyVcGibLk3+00aQmthD+DBqgd0+MXzuj1DV
	8N323UHbLnwp47yUw6Nx0AN55St9x8z/VxWM7gVoirO4CRjekYzf9uTeQdrof/PX9ahcy8+Fl4l
	jLs9+2L6Z6LDjN9YuZj6atPe4jmpib2G1O07dzXN+uiKG/aQqzJ8zvuJd1zn9v+pf3zd2gk2ijc
	29HAVBpeoKyU8OhUfJA5LeMwi8zvfost6rCC9w1ItEGMzQEae5mpyvtct0498xwHvf8+9DbRwEo
	03onnDXPSCYLYeGPGD9ecTmN8gmqIU0oyXAkVf+SMVgf9XA0yvobQ94Sh9TICxsi15/iTolvVw=
	=
X-Received: by 2002:a05:600c:4ece:b0:43b:c94d:e1e2 with SMTP id 5b1f17b1804b1-43bd2ae54bcmr21140255e9.25.1741181508719;
        Wed, 05 Mar 2025 05:31:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7F9v/2ONxk8xFOjzjpCwwBkyc6Bvd4KwZ9m8e5e3MHZoEGLxssf5K5UetRRU+tpmyYly/Lw==
X-Received: by 2002:a05:600c:4ece:b0:43b:c94d:e1e2 with SMTP id 5b1f17b1804b1-43bd2ae54bcmr21140075e9.25.1741181508323;
        Wed, 05 Mar 2025 05:31:48 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4795da5sm21372477f8f.15.2025.03.05.05.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 05:31:47 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij
 <linus.walleij@linaro.org>, Yixun Lan <dlan@gentoo.org>
Cc: linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] pinctrl: spacemit: destroy mutex at driver detach
In-Reply-To: <20250305102710.52762-1-brgl@bgdev.pl>
References: <20250305102710.52762-1-brgl@bgdev.pl>
Date: Wed, 05 Mar 2025 14:31:45 +0100
Message-ID: <878qpj8uym.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bartosz Golaszewski <brgl@bgdev.pl> writes:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The mutex initialized in probe() is never cleaned up. Use
> devm_mutex_init() to destroy it automatically.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


