Return-Path: <linux-kernel+bounces-207362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB89901625
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 15:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52E31F21511
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 13:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F15C40851;
	Sun,  9 Jun 2024 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="WXbHhIcy"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5001374D4
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717938042; cv=none; b=f3CgGYgL1LtPVNUPIXzfd3B6Q4U0L2eoXepq8PQvrYR+KXm0S0ERtbsudKCzw13kAAQQlSJgN/zKT3fB6YpiikEyguyWtOr4v0KUQLxfXhRbphhgmmxqmWCpF/ilM4cE72+bd3fvcHx1u09YfXFlZUPrLeLiT8Ru0rEIzvfUNHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717938042; c=relaxed/simple;
	bh=QigNoW77ClCeqfOYTx4Et4Hd7mgkHkgVnWWc6yIPB28=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YX9CatcQ2Q4O80VrHcW5fIyM9x2tbboZSKPgBea9FyX65nnDAPcwb2Td9cUb30UYxycAIWptj5colG56rBd4rNGpPAdeAvcMb5Zs2ZE4zov/jhNpUy0M5Wxk47hYGAzG/adlEFOZMG+HauhjC3+YMeUMSgC4EVmK6MBYLmKopsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=WXbHhIcy; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35f14af40c2so705493f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 06:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717938039; x=1718542839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ky3F7lrTtIDOfgJFvUgAjHSa1goIJaZDc94U4MqRHYw=;
        b=WXbHhIcye1J5VGA88ZU+HCGB4TDtGMCfeCSgt1FJPs0Ma5WkenDIMhwrH7hoFa/MuX
         gy3AQjZsZNbLIrpOE+30hshDbePRnpoW9ok0pvjj/Us+lzUe4J1t5miCtQjxwG/1DjcV
         ZckRz1Hs2aQZeDEHdjH+6K5z7nxvupGLf7SBTbA8LWiJkB+SiROlqjSMJfDojBdkKRRW
         DbakHmW9v8edYQAegsTOlB5TJ0NUcKhjVPfwrX2WnhDU45VWNteqv2yy8fEU+8CImadg
         l1nI/bkz6ZxPIBiPJD7u4SDsM85zvt0QZ62Nt6m92AuRlDZ+7gtWM3sjvJrMkm+ewl8z
         84Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717938039; x=1718542839;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ky3F7lrTtIDOfgJFvUgAjHSa1goIJaZDc94U4MqRHYw=;
        b=TrHrc+DzF+i65TI8V+t8ozz1jq5oB2JwjhuCT7fsYYLuAmMt83dFhiK7E89j1qfE+O
         mMlMsJAhkwpQRWZgwQlOzCGsxmPIylRqDHwnJmJzEfgbkBXhjZj1AbUB3U51SQNddDdD
         judAJOSZELmyCN2WYwGGRCfzrO9nDPL2vp+/iWqOw7+E6dJih3nkP6nHypwGnWS8IjD5
         CJ6JxoZe3paSPX9zfPSFE8N2LBg5hpPx6uaB6KZEnlbHAHmrAuKL/yK4zrF/6rILzeid
         jWB5YEk17R/iq5hNcMTeLpbP3Vmq6lIJiEnUMMSjltl1qfTA13cPlo2o4jcZBW5sjOSQ
         bJUA==
X-Forwarded-Encrypted: i=1; AJvYcCVNgjkzDP3xuG35BBzIGMRw1oY9+FZA7hKywthLjdsv/YCX/6/p8wSXcC2Bf6j9d2DaXarExe4hQb1qKfElIG5Mg43xJ42ibyzrE9E/
X-Gm-Message-State: AOJu0Yz692vd3pWajCBJnrazUoqwV2gF1sQkWERVCTRkzRh8IE0A39bo
	Coia3TWerGSdon/DkXR6vmLRloKlD660hQC5CSKZlzz5XqNALzqsarK+fNz4O08=
X-Google-Smtp-Source: AGHT+IGRsbqTVIFgZ6p18PEJuNiLJHAflv0f2yiem7/+NmsB7nGwV1Zbdr6NLv9+xKSWGMAW3A3S6A==
X-Received: by 2002:a05:6000:184d:b0:35f:209b:c10f with SMTP id ffacd0b85a97d-35f209bc1bdmr870170f8f.68.1717938038958;
        Sun, 09 Jun 2024 06:00:38 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d66cf6sm8521473f8f.49.2024.06.09.06.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 06:00:38 -0700 (PDT)
Message-ID: <8412fc44-d3c1-4283-aceb-7aa4b95606be@tuxon.dev>
Date: Sun, 9 Jun 2024 16:00:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] ARM: configs: at91: Enable LVDS serializer support
To: Dharma Balasubiramani <dharma.b@microchip.com>,
 "dmitry . baryshkov @ linaro . org" <dmitry.baryshkov@linaro.org>,
 "andrzej . hajda @ intel . com" <andrzej.hajda@intel.com>,
 "neil . armstrong @ linaro . org" <neil.armstrong@linaro.org>,
 "rfoss @ kernel . org" <rfoss@kernel.org>,
 "Laurent . pinchart @ ideasonboard . com"
 <Laurent.pinchart@ideasonboard.com>, "jonas @ kwiboo . se"
 <jonas@kwiboo.se>, "jernej . skrabec @ gmail . com"
 <jernej.skrabec@gmail.com>,
 "maarten . lankhorst @ linux . intel . com"
 <maarten.lankhorst@linux.intel.com>,
 "mripard @ kernel . org" <mripard@kernel.org>,
 "tzimmermann @ suse . de" <tzimmermann@suse.de>,
 "airlied @ gmail . com" <airlied@gmail.com>,
 "daniel @ ffwll . ch" <daniel@ffwll.ch>,
 "robh+dt @ kernel . org" <robh+dt@kernel.org>,
 "krzysztof . kozlowski+dt @ linaro . org"
 <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt @ kernel . org" <conor+dt@kernel.org>,
 "linux @ armlinux . org . uk" <linux@armlinux.org.uk>,
 "Nicolas . Ferre @ microchip . com" <Nicolas.Ferre@microchip.com>,
 "alexandre . belloni @ bootlin . com" <alexandre.belloni@bootlin.com>,
 "Manikandan . M @ microchip . com" <Manikandan.M@microchip.com>,
 "arnd @ arndb . de" <arnd@arndb.de>,
 "geert+renesas @ glider . be" <geert+renesas@glider.be>,
 "Jason @ zx2c4 . com" <Jason@zx2c4.com>,
 "mpe @ ellerman . id . au" <mpe@ellerman.id.au>,
 "gerg @ linux-m68k . org" <gerg@linux-m68k.org>,
 "rdunlap @ infradead . org" <rdunlap@infradead.org>,
 "vbabka @ suse . cz" <vbabka@suse.cz>,
 "dri-devel @ lists . freedesktop . org" <dri-devel@lists.freedesktop.org>,
 "devicetree @ vger . kernel . org" <devicetree@vger.kernel.org>,
 "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
 "oe-kbuild-all @ lists . linux . dev" <oe-kbuild-all@lists.linux.dev>,
 "Hari . PrasathGE @ microchip . com" <Hari.PrasathGE@microchip.com>
References: <20240421011050.43265-1-dharma.b@microchip.com>
 <20240421011050.43265-5-dharma.b@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20240421011050.43265-5-dharma.b@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21.04.2024 04:10, Dharma Balasubiramani wrote:
> Enable LVDS serializer support for display pipeline.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Acked-by: Hari Prasath Gujulan Elango <hari.prasathge@microchip.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied to at91-defconfig, thanks!

