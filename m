Return-Path: <linux-kernel+bounces-554587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D22A59A34
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A191884AB7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A9222D7AF;
	Mon, 10 Mar 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YQ0/P1FO"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937E622D4FA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621268; cv=none; b=IU7zSQUY7T59yPmSUPRPefN89pG136xsNP0CidTRSj7uab8Y6XarilKn1v/KHkPLPP+wVN22Z5qetJjZ+MzqBpvZQHyHNHhvoWMrrHy8oPaQybdGGyfzj3XF1+zyrfBI1hBzdBQos075HAnYuZTsTGex+Ibr5fTrHn/QR7KPrfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621268; c=relaxed/simple;
	bh=SiSYBMtitncv76R++Rvdfnd/5GTxkby/K+Y+pHo4VFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VbPVdPergVPybXJZOC5KLYlAdzBIE9JHaa0gXHpRC4lce0QDW88aqHzhYa2GlKQPHnYcRYrEKv8nFK0j1m6xjm7CdQY94Z0vEUSsXSsg8J0Rd/PkaWvgnaG/hymVFYORxTew2NGaXNcUf0qQTEDPJPYbk5WjmUmyMAyJCy70H4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YQ0/P1FO; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39127512371so2459303f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741621265; x=1742226065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4DcQn3+I0jIkpf3ZBvexKFO6QcwbDbsZfCGjmeAilYo=;
        b=YQ0/P1FOgLtnKJwGzKdrHdKAX4TNkcXOMSXbGeIJS1f6kzqt7pIvlGQX/PEywZ3oMz
         yk4b5kyYSaCp7jlEt+YlaRu2fTv05yXZ49zv5hVoEzdt8EJb+vacPZics1TAHjeWaN+v
         MfcOy1NcT0NQrdPgtVgAeh3ybjAnIH0rF8PQcYbqj3x7h4nVk3CK0Vgwx+pooDOJiB9a
         39io3uTIc6KQ0aXvKxety5Hgfd6ssr4oaapzqJ9rXGHZe2m+1jdTRyV+10KEMao5ROgD
         7osNuEJLqmLYqDlUs75AEz9FVQH1PJHeTCKX85Lm90PYEZWTduYxg5QVsKLvsPMrslK7
         Be7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741621265; x=1742226065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4DcQn3+I0jIkpf3ZBvexKFO6QcwbDbsZfCGjmeAilYo=;
        b=cS5RD8md4sCSxqBnmtQ4cMfGQiUbc2YjVj4q36Y7vzjr4FYsiNjVWU25C4tYU1aLPh
         VfcAJNZYadrIJ+yzMjAIX7kthmU3pMjm5aDGpVQY74S88EbxjOjREHWghhkqMTvXF3Bb
         eCoOsLc9aWFGfqATTSG32qFdh7TptxF9eWxUHV6qNG361OtryjkIzUkYp9OHt2Qgv+Ax
         qXXpBybVzpkENRnqKSxMapi9E1LM0FN/Jehk/4BzItsvGPo6tDEmMgFmel24uw7ml9E4
         Nvlhw6pxIZIQhYCXUaejAZolZBl4JhGNNcnpByN03xL+ls432o/7QdjPVNHpmGImKqIK
         baXA==
X-Forwarded-Encrypted: i=1; AJvYcCVb424QPanYNwaGyYuo0EXYb6xsb8wEX9cEIwwReY0ngcdn6Bah2h9Cy/cywGjBbED7Hd/K6KJdhnx1+ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyExTzEtECMzaVXfwutSJCsRpuMJOKE0wXo/RXUnrW8aoj0R2bs
	Dg9HcHR3+FJkDIDUeNJx8o17kDEfII4HVleqQyeQ+vK6Mfwg4RSoSAN816OtoZI=
X-Gm-Gg: ASbGncuzrQbLZCf7X0CtEWU3mme4b/dg/J81J0Aw3OrCvIgDHzhRM9gLJOvTkRPtbWy
	8UwvKlXwtXOWhTTjbTOmbeQxmnSi7FuZKsjvmPlQbTbMiI/VLdC5OFBMJDS0FtGfQbhSAqsn3Ks
	iYFnCAi6H1as0LKtvz6MHeB/S+WgvBZAE0dzmZ/wpC1DR/iCOvYqnLHc4mnsRLyNJUOJumsDp0k
	bFZL6JmFNmoIyCtGD7Dv82dlp9BOWmlXXaUE7G42QIOEUGDuuMqwm/RdnrErJybzhRrOWbe7mSj
	cwLc4iAsnocs2QJUiB9FjQ4PHtcD8vO1QLKR7hFBdFpTyghoh5LuTTdGWPkY9n5kfRHQxcgrdiw
	Sh8iZWqRZ
X-Google-Smtp-Source: AGHT+IFTM9dXcEZw51WkmRY68H9XVcAqrdb0vR4We3kH39AbYRJBbyFLPPSlwgwvD+LzdOV/7amBMg==
X-Received: by 2002:a5d:648f:0:b0:38f:2b77:a9f3 with SMTP id ffacd0b85a97d-39132dd6934mr10735927f8f.43.1741621264831;
        Mon, 10 Mar 2025 08:41:04 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912c104acesm15499409f8f.98.2025.03.10.08.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 08:41:04 -0700 (PDT)
Message-ID: <9dc5dadc-7ff1-484c-88a8-461d505cec03@linaro.org>
Date: Mon, 10 Mar 2025 16:41:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] thermal: bcm2835: use %pC instead of %pCn
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Liu Ying <victor.liu@nxp.com>, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250307-vsprintf-pcn-v1-0-df0b2ccf610f@bootlin.com>
 <20250307-vsprintf-pcn-v1-1-df0b2ccf610f@bootlin.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250307-vsprintf-pcn-v1-1-df0b2ccf610f@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/03/2025 12:19, Luca Ceresoli wrote:
> The %pC and %pCn printk format specifiers produce the exact same string. In
> preparation for removing %pCn, use %pC.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---

Applied patch 1/2

Thanks!

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

