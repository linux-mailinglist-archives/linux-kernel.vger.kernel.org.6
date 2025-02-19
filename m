Return-Path: <linux-kernel+bounces-521796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC0EA3C266
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60501888DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D101F30A4;
	Wed, 19 Feb 2025 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pnOOdhmR"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27FF1EB195
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976223; cv=none; b=TnPQvsnjIdi8tLmhBFEGUd+aufRy7/B+0s7WpHLpAOWvmFJp082JussKiGxgblTUrIpxuDYawlo8TEX7QweGgsfoF59yToFPzCzy3+GmZBUZ5Ra/8lkCZqXL0WYTV6gYwwngyJ6Zvl3hAkYJplUR+0xWN4I4ZERQSgGY0493dx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976223; c=relaxed/simple;
	bh=XXJzkYspgnpCWCcrBdndAxSLHrm5YJblVEb/RtSh968=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DnaQnMa+aLzfV2UpiPf4t2ufkYWe2niOxSd/BWKsNECyDnlZIblmO6p7hLSdiV2gRvh4cegPCrnrCqd25aQGJlAogbWYbaZPanwT5m+3HvEyyHFpt3Q7LvLkb2SiMgzmaan/fdulEbQDDju/V7zzS42/1KFxtdYeimmgIRCjk4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pnOOdhmR; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4396f579634so27804725e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 06:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739976219; x=1740581019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CB7D/FiNY5baVQEMZN1/IzSqi1RBp0oVyn9FeISCPkE=;
        b=pnOOdhmRlMo/WlZGZDnxvr+T4F8yUMF5xRSVrM0+8zV8AfNKuyikLBzaSir99kif1V
         cBloXPgwQEY2h05qHFbRKmqntdSgmbeveArYEdqE81hUIPba1qpyAg7P1f2csBgtkGcG
         dGr/FH4448npeMtIo+ICVsxCL/SUzuNr2kUGuxPZjMmpvc8EA8MFfjs/xY0qHbqrpRJV
         gtUA7i5gpPVq/u3r1XmlUmpyxOL2PiQSl+d3PKgbw39BZCk+BEL7DXiq1zAeuQWh6rDa
         eJ3HuG9tjjM00f9Ipekxefzox+3KQlXXPsy+79R29Qxg71ya3EJhQgDXYrlorLBmpwyz
         xB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739976219; x=1740581019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CB7D/FiNY5baVQEMZN1/IzSqi1RBp0oVyn9FeISCPkE=;
        b=hTSIrxqBPQSeH41GKZ5CkhEze8ABxlP54NNt921wxnW/xG8nkyye61Ua28tWdy9Y/P
         FggCryGsLqEIJ99/3Vu0WcvZXxj8cK7VDgOLv5L2LokEbRlsxG3A8MpXCkCgogaumQRR
         NWvrcbQMvXwaVGAjS8nPxBL4CJeCPq98LfxAidWsTgxoq+UUIBBTmViBQBUdMnNKngCP
         Jjs0y9QeL8SK6pnK4kX+sR41jEr8q7BYFqGzmuut8xjgREOYh+eLp6GVcrR76ohL1THL
         dtm7bvHh1dXRfto9b0UY+xYO39HfII8+eLx0aHhivu9mHL8LL0k9MhB1Hpuf+Q7iq0Je
         /gGg==
X-Forwarded-Encrypted: i=1; AJvYcCUQBqqmNcTh6t0QqkYVFpq137xu9VVQWWE5bi1MgFPDngj1wtYbpX20kiPlZvFlv3yDsvwWaA4+lw+1lgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9jqqI+xvo1I4t2f+7v4i2oPtcsQ33aZy4M3LS13pJGLBAkHdn
	g96MEk8fPPWPCSDrAzZaZpCCo02Gl49sP+e/M7626bYe/jDIjrNfRXgmDYShUVBxlU+Ymi/7mVf
	Cg8c=
X-Gm-Gg: ASbGncut9LQcPYl+1oo6k9w84/YZMokWNWV4gcag6tjvpMJsg5NBdnXCzEEj9S2WCfo
	SnE/c+eZD4OZx6ocFUChxIRSq8/wyhytRB+svbC8Ps+Fp4GmJYhjPIWlbF212IZqURqt/5I1Y5n
	j3aJ7IeQwl7JHUkay6W151354hoECA5CWd8vaoIWnkKIWdiioUe5A1C7HzILpFQTI6dbvRXw1NV
	XCnIGDfveglnOkPD3+JQlXK1PBFYk9bEk18Vehl8ODFMLpzWHx3DMBs4BGpspiYlym7vQL7N2yA
	yAb2xu/T8dOe1VSCpJkBarEIRGZ5/EI3hiJ8/AaTjmqsWUuUDzzJw5Q=
X-Google-Smtp-Source: AGHT+IGG9It8D+g9Z+h38+jTAPsXA4RAxVB1cY9lICrXMt4960TT9OySBuKZmnHsRJt+WQCSqCRTvQ==
X-Received: by 2002:a5d:47a3:0:b0:38f:278f:58e4 with SMTP id ffacd0b85a97d-38f5878c88dmr2421933f8f.12.1739976219017;
        Wed, 19 Feb 2025 06:43:39 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4398a64febasm75324215e9.1.2025.02.19.06.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 06:43:38 -0800 (PST)
Message-ID: <d7484ab2-6da0-4bb9-a2ae-9388dac15038@linaro.org>
Date: Wed, 19 Feb 2025 15:43:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] irqchip: clocksource: fix jcore-pit irq request
To: Artur Rojek <contact@artur-rojek.eu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 "D . Jeff Dionne" <jeff@coresemi.io>, Rob Landley <rob@landley.net>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250216175545.35079-1-contact@artur-rojek.eu>
 <20250216175545.35079-3-contact@artur-rojek.eu>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250216175545.35079-3-contact@artur-rojek.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/02/2025 18:55, Artur Rojek wrote:
> The jcore-aic irqchip does not have separate interrupt numbers reserved
> for cpu-local vs global interrupts. Instead, the task of selecting this
> property is being delegated to the device drivers requesting the given
> irq.
> 
> This quirk has not been taken into account while migrating jcore-pit to
> request_percpu_irq(), resulting in a failure to register PIT interrupts.
> 
> Fix this behavior by making the following changes:
> 1) Explicitly register irq_set_percpu_devid() in jcore-pit.
> 2) Provide enable_percpu_irq()/disable_percpu_irq() calls in jcore-pit.
> 3) Make jcore-aic pass the correct per-cpu cookie to the irq handler by
>     using handle_percpu_devid_irq() instead of handle_percpu_irq().
> 
> Fixes: 69a9dcbd2d65 ("clocksource/drivers/jcore: Use request_percpu_irq()")
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---

How this patch should be merged ?

It is touching irqchip and clocksource at the same time.

May I pick it in the clocksource tree ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

