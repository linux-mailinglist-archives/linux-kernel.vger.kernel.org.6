Return-Path: <linux-kernel+bounces-545570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32432A4EEB5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84DBE7A9249
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112E82673BA;
	Tue,  4 Mar 2025 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6YSuyLD"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECBA2641DB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741121188; cv=none; b=QaLpL0XJBP3u2c9aUgt4ohBienSU3PBrqAFvACj9GjBi4iYHpWOgpeS1qRypVRaLm3JOfZvFCwJrNB5z/AGzhihAC1xxLq78jbS2gM9GSK3XHFbRXvMCYru+8LkvVEJ3jnKollkE0DlHb7HAwI7tEXeOdAabtTnQiTq4xt1Ru2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741121188; c=relaxed/simple;
	bh=4DsSSbRPes2SZLckXDril/HZgQnvI0Cw/siCq5iE2Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZIOd/rXdDHN/3enaZlzS/EWr5LSrGPPA+k1Ox33PXqdkRVKLLEhsADFmgJa1FnOyXTl4cF4Fg6gioNnli6eXmSLadvHanecenrq7uVY02aj2r2wsbPaEOj7wEWDrnyWqTX/+fLS05H8dy1Bcj8s3MSV+Dc449urp9NjE7xztrmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a6YSuyLD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394a823036so56727985e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 12:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741121185; x=1741725985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xe0gNALudh5AKNVpnsc99NpQysntPABXDZxfVbJ2638=;
        b=a6YSuyLD2uYSTv9J5qWjTdukTS41jpnvCCQHXE4iBOkymfupV7iOKunNM1nhRA3ako
         XtpJrTr7isvgTA8mhZgPJcN03SR5BbQEsIUUynZK1btDTbdzkvDa0wUJZX07gkjqk6fI
         E1w8zVDQJFEjp5HSmawSbjHIasF1eDQezP9ILKR98vOUVPosloflJNuGBX3p61Vcmxun
         iBPFZCD2BmXOBFboUtwdo8P2MZRoKhXZoighkIx/SRWEelHN3hH2F5f+S/1aTCD4sAEw
         TPK0Fm7oPGzitv5Xbygq8CwaBWes0XXT8CQaLmhslJf9cmEbzTRKEUNf61eK1STFZoZ0
         LlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741121185; x=1741725985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xe0gNALudh5AKNVpnsc99NpQysntPABXDZxfVbJ2638=;
        b=qnkx0NQylcvhz0NMZcdaWguAhaWZ5V1yaYrJ5D0f+LYlUGJOO/sFzwsGXNTJqO/Qjf
         V5HdlotG4ZBZAR7kaPCk9ex4jp8dhgT+J50K1dv76yyZOar4tIrtg4YduTg0UK0OAAmx
         6g32dFq3m7DFQyu5zZSWR+BeKTQ9yAjSdUbmnPTQyhAGWJO0IRsvj182AH5x2mgsvyHa
         ZwLIMP7nO6V6jKaQZ2cMy0SWjOXg7wiuKZX5rWnRfCOh35JknUIq+AMzzaxpanlVcuw5
         yaslSJ3pg1yaUg3pW/g2ZjZc5XcVP/vTyVgJfwT8NXJyIdN8QwjscyEh0LjnYVXract/
         Ht/g==
X-Forwarded-Encrypted: i=1; AJvYcCXwSHpoAQn/iu4Prh8moYvrdQe888sd0XVQUW8pP95jNTHm1sLeS/5e+QGZ/pZZ03bCTmCQlw0WMaopdGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxi4QVozOUxCSLxUZJsvAczAYBVunb5cFJVTAfsAPyiZcSvS0y
	l9YhgGf0Uz9EOO63Bp5QphmbJd7+DLUVAykeIV6CQdmiDDJQG5k6izMrr2fFsxomamYOuwQv2RC
	nxnI=
X-Gm-Gg: ASbGncu7sCeo0BkO8a3CVrYusJsV5nXy292f75oh61ytwc6P9eX/3ZMGyahA5zEVQg4
	bfhkdLtCuY8a3xrdCwVEYja9CmpwmqEQAYkUAkr7fclxnHrVLAAbBGgvn8EJbVIrsnUYebjUkJi
	pbHGGiYR6TaTssYHcm444tqUu8W/bwdb6ICIL49Q5EvX5FybImqipWpZBtNyP7fACdefq9cIhiT
	oLiFkF4vSe367uV9PupAqIydQ4nQb30nW3ree0wXX0ZK67+ci+WO4xPOwfpD+v8zAyiVEqrRnLq
	pTXHuaII8PPj+CXGqlLMBLFFfGU8ueSFgp9dWL/5rV5YORhs2XXKvRgzukBBYOvd6M/fSQ+VQNJ
	l9Zoy78f+
X-Google-Smtp-Source: AGHT+IHjEcU8uO80EjIqMe2Us3DZGx4pspSob8gq93Xc/2SwZ46ezNtIGH7ewMTX9XjP3bW/4xIyWA==
X-Received: by 2002:a05:600c:46c6:b0:43b:c228:1ec8 with SMTP id 5b1f17b1804b1-43bd29463b9mr1995375e9.1.1741121184670;
        Tue, 04 Mar 2025 12:46:24 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43bcbcc53d3sm21750535e9.0.2025.03.04.12.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 12:46:23 -0800 (PST)
Message-ID: <e4dc9c1a-bdf2-45c9-950a-69f647f6283f@linaro.org>
Date: Tue, 4 Mar 2025 21:46:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: stm32-lptimer: add support for PM
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, tglx@linutronix.de
Cc: alexandre.torgue@foss.st.com, olivier.moysan@foss.st.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250224172101.3448398-1-fabrice.gasnier@foss.st.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250224172101.3448398-1-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/02/2025 18:21, Fabrice Gasnier wrote:
> Add support for power management on STM32 LPTIMER clocksource driver:
> - Upon clockevents_suspend(), shutdown the LPTIMER, and balance the
> clk_prepare_enable() from the probe routine.
> - Upon clockevents_resume(), restore the prescaler that may have been lost
> during low power mode, and restore the clock.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---

Applied, thanks



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

