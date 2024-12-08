Return-Path: <linux-kernel+bounces-436452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE4E9E8607
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D9016482E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 15:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D0F156230;
	Sun,  8 Dec 2024 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="nYhKgJ7v"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858F913B2BB
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733673145; cv=none; b=hTqjyQjbQeAAXI0iI71OzaELNzVWmNVUK36QIdzqXOaYFiCZV2df9VSyWiis+Cnl6rA2nEBfsmnYNkf2RdF/soU3S2Q5w6qJBiqWvGzyH9LdU96+i8yWnVGHvFiEiGWrMviCg5LnZILNtRGEczRmxK6qD8bKIDesQaGt3xbgOv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733673145; c=relaxed/simple;
	bh=aqq4qS6Tr08Q7jMD0p8Zt1pKPFUhYxdI01HHpOTiCUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQuy410EjmxMsQzkdOCIUWkE70CxJ+pEv4mKcRB/wjUqTbYMyF3DLLJD5bw94tBmTyruQC3xdrFdW7qyk3Ag1rHMprWobTUimiUGZOrl/AyS0QtuHHN2U2KGMvzHAH82QfTaTHJlD3U012biMMmNMm+Dc5mLyc0WV1e62mBhXQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=nYhKgJ7v; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434e84b65e7so13084145e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 07:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733673142; x=1734277942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kx3jh0GE1/Dropfvo1pElPZ7xo029DSJLEgY7NpRbHo=;
        b=nYhKgJ7v9GBVIFTbmkzLwoZdngtGIBD9cBbv1iU8+o8B36wgZG7vALbaPUa8X5mUGT
         tRncAZoytzzSThyBxtPVv45euwfo2zDoSL+TIjq9uMfEOGT5U5wO1ogujio08ddGk76K
         NMmSZH4KGOPOiPDtWLDO4+YHVFsUF4lHE03JPOneuOYNLnIpPVtZZKmNcxy8A27cNqAY
         MDT+VmQcbnwcajEPn7FZbJm644VVT881/KWYBZJk4dDt+1p8eTsfA+i0Y+lgcUo5CYng
         JlzomyY4ZBiAxd5GgCgZC+BWRR1qwkyqMkddd1n9Zm0b+feMozSkTjyyY4+5bGilM73L
         7Crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733673142; x=1734277942;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kx3jh0GE1/Dropfvo1pElPZ7xo029DSJLEgY7NpRbHo=;
        b=h0v71+a0dNwBhQI+e0ZAR8SSUZQLOkqfsCclepgW/q6sF+FlN0znobh9FUSimtQH1Q
         LVeCEuVtl++aOQKfPd/L8KxErpBRKOzEy8rYsngxTl6pZO+irjsFNKqVKPtwyaExZpXb
         Cn9GDXb5VwEZfEGIUCJ0EMEDRdDVLDckyjIdXpAebrTRTtof0AEVSAi+8AWJBpE6BzGp
         KOME2sEiT45oeRRTnCauIb6OHp9tpNWI+EHNkStFgxfLMk+w7sVOaeGGsYdDaPZ+yoij
         6hVZvFjMu/pqUUW47JcXmVzjLl8YTwTff8puiIu5sZuVcZyHjzcmj2AopERvSZHhyu+M
         311Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTsqbaJKwV9PpQqJ3NGI6CKnvq0qrL8PsC4E5OHPLe/OlcDUz+9s9bXIrQU3ZCJFpgK8K0Yc8dXauWWJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg/FytVFosoEYuLg5iOZgIOqmXaQs96xMVU8j3a0F0F+sXgXND
	WyZRDryL/XxMqSpsvexKonNL3p31k2pca+u5FsEZPGpbDJfv+HCmgAdZXcgQHpHzL7HUXCk31as
	6
X-Gm-Gg: ASbGncsVJrNONXxDw18Ysq2VOTsJo/BcOsC+i3LUbrsLY8y8kXofxW0pGo1Xac/QdZo
	j+wbTCDuZyfxjUTxjQuVzf581ndL1N32rkIx4FyOU9tEf1MNm1rc9Xk+kk453G4LqTS9AhDaBYX
	ZplJ/nve53G6JApI4MfhadKuxXKBOWujuV9H/+TvqzBm7r/SG+Zj78a/pIAiEDIgWLOubIQFEJp
	4n5jSW3vP95iJxmknldlhbTxPB6m7KSxavdYVvz5yIEfKK+wLzAv+WK0TI=
X-Google-Smtp-Source: AGHT+IEHWXmOO6Qhxy2IR+e2zwqSa3oqeBDMkFmhJ9xKhEy7pcBF/DqwbtBN0uvcQlGuz1FIpzs6uQ==
X-Received: by 2002:a05:600c:35ce:b0:434:ba13:e52b with SMTP id 5b1f17b1804b1-434dded2bedmr89096995e9.31.1733673141783;
        Sun, 08 Dec 2024 07:52:21 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d527eeedsm157997545e9.19.2024.12.08.07.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 07:52:21 -0800 (PST)
Message-ID: <afac0fe8-2854-43eb-a4fb-bcf5b6d194d0@tuxon.dev>
Date: Sun, 8 Dec 2024 17:52:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: atmel: fix device_node release in
 atmel_soc_device_init()
Content-Language: en-US
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241031-soc-atmel-soc-cleanup-v2-1-73f2d235fd98@gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20241031-soc-atmel-soc-cleanup-v2-1-73f2d235fd98@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 31.10.2024 14:33, Javier Carrasco wrote:
> A device_node acquired via of_find_node_by_path() requires explicit
> calls to of_node_put() when it is no longer needed to avoid leaking the
> resource.
> 
> Instead of adding the missing calls to of_node_put() in all execution
> paths, use the cleanup attribute for 'np' by means of the __free()
> macro, which automatically calls of_node_put() when the variable goes
> out of scope.
> 
> Fixes: 960ddf70cc11 ("drivers: soc: atmel: Avoid calling at91_soc_init on non AT91 SoCs")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied to at91-soc, thanks!

