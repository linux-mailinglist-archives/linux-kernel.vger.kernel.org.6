Return-Path: <linux-kernel+bounces-518913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234C2A39626
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13E53B6D22
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC873209F49;
	Tue, 18 Feb 2025 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaZ8fGuI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCED209F3E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868443; cv=none; b=it3OwaWwszHLBpFsaPJ7yKxOD5diuUku9IUrWaHEtpxX6nRdt/x+VjiDVXaGBK8t45w88fyGJdKdYeGKeMxAyg/4/I4ExwD1AyQowyl2XysPCI/mt4ThEQdGpVqFtd9j0rePyaBV4lfiZVi2c06JOx4shJCsKURTsjqXeEPpuHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868443; c=relaxed/simple;
	bh=Ol6Iq9UCjeAQQT7E2W7DOZWLnUvYdgICD+RFi7UcYug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sBT5nGN9HbHCIM0Uy33cyspqBH4b0IPYUhqutlF9TS+03lYic8XUdGqVYe3IQc28+KkCh5A4ma7nwyAPMxVwQEE7mvFKpMKgqH0NKUQI4v67rA8EBtM1wAVUTQTsyd/3S6bRdfCRulhyHCTZOEW3QDi5KADyLFcrAWK4mHn0Um8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iaZ8fGuI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739868440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f0PPk91R2OjqODZtBQUNypPkAhjqPhzDO0Zl4X5trlM=;
	b=iaZ8fGuIYK66PD6TUa33qwS+j/AR8XwuUq52Zdi164BZak2qvaz4tSLcjyGW8DHTJCCkvq
	8KgCpEFe8HIn6ap+ZYH/30v2K26Eoy/Nxd6UpwBZ0rhqXox3C66DdbiFbWaSzW2m8827GP
	eWht96J4i/Rhwo5CC5Y7AMQ/GyD/UeU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-nPhYJlwDOaK4AhWM1uwOMA-1; Tue, 18 Feb 2025 03:47:19 -0500
X-MC-Unique: nPhYJlwDOaK4AhWM1uwOMA-1
X-Mimecast-MFC-AGG-ID: nPhYJlwDOaK4AhWM1uwOMA_1739868437
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f28a4647eso2827178f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 00:47:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739868437; x=1740473237;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0PPk91R2OjqODZtBQUNypPkAhjqPhzDO0Zl4X5trlM=;
        b=OiAwLb1SSdQmppG/mmjX9XKDwABOCNKVc2kqc9XkW7ywZGdZm/8aZ/gesY2fUuCsK1
         DELqt+fvx7PolShmPqeebDK6EWp6q+TiwMTYoKD9L9fumJ+bJ6l7UvFuc2tmBUyw3XAc
         JIKP6tvGvpVCTikX9tzwZL9WiBlwuWuHkj+zXyVkC8sqe2W+f99jqeYtH6j+Rg/D72T+
         CoanH2gcvtlrgpACjPYHh3tRbBallmKmZn2XjkwP1yu7icHRI5bscI/Odzpo7UznHsmK
         pQBE7bEjLhDh99xw0Hr/ZdvKDI+/ehhoD1qYdXcB08RNJQP9IoJQpa1n04RxmK3hnC1c
         ovDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjHqmSkF2N02cdsdLH59nwvcfPgvHwO0zF7swZmotaivCEJ2HDypGwUohiMTXpJN9SQlU8TjAXEbiTH8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuZJJTXrUkisyA9dZx5F1ZcDhDby7PLnZANIpkBuB83N3aDk6j
	otifjmTn+Zrnq3iSvYCY4zMB/Kmy5E2hJhRXRKrTWH1wXU8MT1gJ25owpvipkUm5ciGokm2vNLI
	laYIR+z1HiXN2RJSp3vUiPn3oij+NeDl/pMjpRiB/psE29z4P1XGKnIwOuTz+9A==
X-Gm-Gg: ASbGncvHRl92xaWa8yGHzE6lWCYz46k2tE77iGOffNv8XzlU93JOqb/Pmmj4/HD37Lo
	8ZQeKCrtgp2TCSYP+bNbn+DSBj1U/EQhOQa1kUO7LHQtUdKkjAz+rH6oz5Y5r+XbpcTWRMaM1p2
	ElidhHpmgNSqVYZUJd4x5DKoIJOih9pFuJhWh5BJTVudEDZWTD7PW9+sLZY2qDuLYFJRlmigZOF
	d10TYTH2FCjvFxofDIp0m/CKfL1o7KlbwRnOHzrt+L3lmZ+/5m2a7bE+aZCiq3BJ5DRRosWnfmU
	ev/QQH84k4or6TOKGID81dYKWsGJTxvhdorRTZBXF8G9AFr0cS3cneCaaY/S6V0=
X-Received: by 2002:a5d:6ac1:0:b0:38f:229a:b48 with SMTP id ffacd0b85a97d-38f33f34e0fmr10212219f8f.32.1739868437042;
        Tue, 18 Feb 2025 00:47:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSbylPudXx7pB2i6xYLZO/0No55k7fxSLecS40C+YqWkkI3E7XGgL5gcPSu1DOJPV7vKQsoQ==
X-Received: by 2002:a5d:6ac1:0:b0:38f:229a:b48 with SMTP id ffacd0b85a97d-38f33f34e0fmr10212191f8f.32.1739868436746;
        Tue, 18 Feb 2025 00:47:16 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4398a8007easm36991295e9.21.2025.02.18.00.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:47:15 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Yixun Lan <dlan@gentoo.org>, Linus Walleij <linus.walleij@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>
Cc: Alex Elder <elder@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 spacemit@lists.linux.dev, Conor Dooley <conor.dooley@microchip.com>, Alex
 Elder <elder@riscstar.com>, Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH v3] pinctrl: spacemit: enable config option
In-Reply-To: <20250218-k1-pinctrl-option-v3-1-36e031e0da1b@gentoo.org>
References: <20250218-k1-pinctrl-option-v3-1-36e031e0da1b@gentoo.org>
Date: Tue, 18 Feb 2025 09:47:14 +0100
Message-ID: <874j0rr65p.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yixun Lan <dlan@gentoo.org> writes:

> Pinctrl is an essential driver for SpacemiT's SoC,
> The uart driver requires it, same as sd card driver,
> so let's enable it by default for this SoC.
>
> The CONFIG_PINCTRL_SPACEMIT_K1 isn't enabled when using
> 'make defconfig' to select kernel configuration options.
> This result in a broken uart driver where fail at probe()
> stage due to no pins found.
>
> Fixes: a83c29e1d145 ("pinctrl: spacemit: add support for SpacemiT K1 SoC")
> Reported-by: Alex Elder <elder@kernel.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Tested-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
> This should fix problem that CONFIG_PINCTRL_SPACEMIT_K1 is not enabled
> when using make defconfig, thus fail to initilize uart driver which requst
> pins during probe stage.
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Tested-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


