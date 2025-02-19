Return-Path: <linux-kernel+bounces-521528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDDBA3BE7D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5D116C7FB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764D61E1A16;
	Wed, 19 Feb 2025 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ouU8aSVl"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEA41B4253
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969292; cv=none; b=ljEPm6rK9zd0uLkycQf5IWiS7Sr3f+uDEvPGIbyCRNdSxh57yWCLdiJ8QWe21blDehic1tiILjTV35pQeOoqa4pM92Hnus/HsVnbAAJIvLud59JAPEeBSDBThUlL7xcNGfQLA9Qw6Bxjn8880WQ3WARXD5UfG2EVoJ9Av2lRC/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969292; c=relaxed/simple;
	bh=ihsmHbHtlp8rHfijbF9nkzXRjxqvKEgU6AvFBEVJ0HU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P8vDIpU05ba2rLoU4Q8UOLegpoJsnDxE3kMDgUhi7w7v8ZiYnwswTY+2H7xiP6DlvTfjLSrcNvftHxRCon0gWlpqqopSEpixZD1QqclSZFsY1bHxslI/PDPTqSdqaj7Kthly7zkJhAKUGaCmUVSVBLLgfl5sBYBwjeAE7bAR63Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ouU8aSVl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4399ee18a57so2458285e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 04:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739969289; x=1740574089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TuTGzKLu5tsMdHN2Wdxs+98eJFE7Ctu0kJ3iax7fM+Y=;
        b=ouU8aSVlmRGOJFcY3CbB27UEJCJ9YkQBg/Tiv/8TP/4/+cnQr4HjoOHfrCpZTCTdCZ
         Syl6RV9hOw54F+eABlfEYx+mZwxKLVT1fe1is0mop9xLrpj4OEu5BeyFWf1ChvMu7J7n
         JajNbvbBoNMPmBzot2tM5eMd4wU+5gwH6tlP5YlOIAYpFP7KRYLqZag0EbrJfhqbinuQ
         c/NYnjlBdp+Sf/MFwzi3H6IHF1lWlkBVTJiThQNx8U9T+juA+eGNM7hnNRhHRYdYfNO1
         ozTOhfO3FpCePbo/LhtFsM+jAXruNPwSyaNv+VgL0lX8nn+koR/U7dr+f7l5a8BEsPOx
         UtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969289; x=1740574089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TuTGzKLu5tsMdHN2Wdxs+98eJFE7Ctu0kJ3iax7fM+Y=;
        b=f7RCKK4opZKb84FyFP/dnhlIUbAK2pa9x4HmtodzRQ1WDwqXSAbHov6TVVPsgJN5RP
         NITNekO0ujrqssgjzRsyinSv1ZBK2xDe4LMPaRikzve4r+DTUAURJWpbWoBAMdQtsfTp
         ihs5VIxKrbaLuPtkVIE4MpTGizUMyEHacqoD25VGDhGovdDHNy9C9mTXh9JWdnWfH2w8
         uhmDfD5pN1gOoDTVvlm8O58tZGFMKrLbDKjoX+z3VAsbKp4bkI7SYJRUSQgu9RGVOoR+
         Q/FYmxYALvl+OzXaoru8kuCCUVjmeEuFgONPGoGY0p6dqxWLhsuIw+WxfiQOYIKWx+Jz
         ElXQ==
X-Gm-Message-State: AOJu0YxBbqA4ItSLtU3+hFnSNAT6Lpou3C8TDOPzzlXjU3/ajb3HIlnX
	+KwXAtAqjk1KzppqaC+H4K53ZCKfJgSGX1md583IQfs73UZfavC4J4jtJMWkf6c=
X-Gm-Gg: ASbGnctsyZ+89VCdPtuI73mdZQKgxRKWWOxW5+AlUm5FCK+QVMuEepFXAxtdLsqTMxi
	dFmQaM/EB8K4ROwR5/51oTX/gZA2M6He7UTOOl1f4qB6qmWPKfnGkgxoybdfzIZQTMsiDESPNC3
	70Ytr17TowBiajhJnIl45+6a2vBDIbn/wRYnJeM+p1/3OSdMNfgcREUeNJbyrjnLflZRCy0iqHz
	72wa+IN0DHBQJEorY9SJT8Xc0DWEZuwo11UZCCNe4PHIs4f8qpSKK6+uzpeMkQWc7P8apIPScAl
	+EOCTIS07rBluSDQyTZkVia98U89A2HnM9LD3lwVMWxiz1bKlzyHcmo=
X-Google-Smtp-Source: AGHT+IHKkZm1mWTjnxrw0HpjWwHwD+t1a1Q2QYShVARWCw/jMaNlFT4FqF6ALJVnKaxZoyWJrSlOlw==
X-Received: by 2002:a05:600c:19ce:b0:439:5fbd:19d2 with SMTP id 5b1f17b1804b1-43999b44505mr32310105e9.10.1739969289321;
        Wed, 19 Feb 2025 04:48:09 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f2591513bsm17965134f8f.55.2025.02.19.04.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 04:48:08 -0800 (PST)
Message-ID: <993f6d6e-a352-4397-82df-8db05cdfc18e@linaro.org>
Date: Wed, 19 Feb 2025 13:48:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] clocksource/drivers/timer-riscv: Stop stimecmp
 when cpu hotplug
To: Nick Hu <nick.hu@sifive.com>, Thomas Gleixner <tglx@linutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20250219114135.27764-1-nick.hu@sifive.com>
 <20250219114135.27764-3-nick.hu@sifive.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250219114135.27764-3-nick.hu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/02/2025 12:41, Nick Hu wrote:
> Stop the timer when the cpu is going to be offline otherwise the
> timer interrupt may be pending while performing power-down.
> 
> Suggested-by: Anup Patel <anup@brainfault.org>
> Link: https://lore.kernel.org/lkml/20240829033904.477200-3-nick.hu@sifive.com/T/#u
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

