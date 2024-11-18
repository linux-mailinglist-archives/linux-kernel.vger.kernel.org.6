Return-Path: <linux-kernel+bounces-412963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA069D11C6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6611F230BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90E11A0BFB;
	Mon, 18 Nov 2024 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iX8dIX61"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9001D1BC085
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936140; cv=none; b=rg2IAdoESizukpPRbjFeifgLlRmmGvLhDm/bEzDu2uhvqyhodsZixn9xduXWAEp5/Qw53lmvq0HgQewrElFcS9pU6KJt2zJO55Afey5UmlE53yDFvqzmsWmLUAybQFXJJfcvDFDYpunbZLzK7iu4etlZROJe/SmkE13rf+IVtps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936140; c=relaxed/simple;
	bh=ESSG4Jj7FxqGyEig0Jvf7BJtg5tXT9+TXdVz5teABfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qIzbVRPEkU3vR8nYJnGzlIWNyURJ6x7fzHvs76j/kWti3gHgqrCkNzqfO3hDV9bBorv1LDIbdRQKmlDWaTQzd0wNe6Uc1uTfmTVjMr9vCGWo28/Z3ml5/a/+RYxlbA5rrsAjhHMfQmw/L+tt956nGzNKnEGe501KSwqnKg+k1wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iX8dIX61; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so29505245e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731936137; x=1732540937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zMaEJ9Sd/GnLr8UWiwxXSZAacCs33/2tfIwDNrN6hF8=;
        b=iX8dIX61ZTD3BXJGc8V/ICi4/cWYWTLiKbt2IMzotDpPnFBCiE107kM5WtzlMe7gjL
         VZDD3aKMceOS4YU1haIimxKkKpO36bZrjNY3GkhtH+/el+NH61K8Q8atNi4EpobI3WWx
         /1WHYJzMFJRHb3DfbbJQnaJ3nMd110wBk4jhPIR0GLWpg7lYbNebNa51V1dmydUPDvg/
         yBpPqozqok766sUlH800WpKY191Ah7Z6C5RO7ij6ddRGYl+Js7+hIJbBk9MYeQGiBA3L
         Ty9CcTpAJ9A02BC9BV9K9KmAMe8M8/kmlORYOzxlK8Ogf3+xTsy8m6LAUNCXKnmUJCKN
         DqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731936137; x=1732540937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMaEJ9Sd/GnLr8UWiwxXSZAacCs33/2tfIwDNrN6hF8=;
        b=E0Nu1yJtr6827MLL8l7giW9Xv4Hky59Bhi9ULbKEjTu5+zwThuUqygGW2liORqWl3r
         u0VjcDQ1OLuKaOYuooQiZLaYahcERsi13D5kNRo3IA6DFrd6+tG7eINifdcZJMCEg4rJ
         3hauaZLEk7IMelI1u0dWQU7Miu9KWrlrOhg1/NoDSrr3eeIvrLZ6IU8ovXw66/rDrju3
         GffGQZdi1TVtk8ZeuAIKPLCrWzbVpIgw1bwjPh97Xjd0SoW5w1XpfZIYS9ngO2Zpq2M9
         0aoJ18vrExKdTpwFf2zhepzkLDiZudpHtwCQrja8ViagMEMMmpalSW7Hnqp9A5TffhAM
         1OoA==
X-Forwarded-Encrypted: i=1; AJvYcCX7lL8FeLDvSFNamqXg+PZ0yvTNJZICcfOx68OrAnzgX0RJsbZM+cXZZERa82RPlN54sMkHWNnbn+mUGZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGAFlOqGjJK8jkLTBfqh52D1ccLFJgDfiIZiRxzsorENy7x3uv
	BfDF9a7eYmOjeCyYG1SUpG+OOE6UD68W3Algw9mJPCRYTgPgVNLiNeyw3h0wzv8=
X-Google-Smtp-Source: AGHT+IFWnZuICcQfYd9OsfPN5uKgimr0iEncaQ0yhH8YtgnUZaUryhBBQ+OQ+MhH1O/KiSAnMc28oA==
X-Received: by 2002:a05:600c:501e:b0:431:4847:47c0 with SMTP id 5b1f17b1804b1-432df722c63mr122864995e9.7.1731936136986;
        Mon, 18 Nov 2024 05:22:16 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab806e1sm159426485e9.20.2024.11.18.05.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 05:22:16 -0800 (PST)
Message-ID: <3ce358b9-6a65-4141-ad3a-bbb826082470@linaro.org>
Date: Mon, 18 Nov 2024 13:22:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] clk: qcom: Add support for multiple power-domains for
 a clock controller.
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-0-b7a2bd82ba37@linaro.org>
 <cl4u42hzdwaj4dt5bponhnadou3uecaodtr7iopfu4vhmvttif@bxxvmwmzu5u2>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <cl4u42hzdwaj4dt5bponhnadou3uecaodtr7iopfu4vhmvttif@bxxvmwmzu5u2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/11/2024 13:15, Dmitry Baryshkov wrote:
>> On x1e80100 and it's SKUs the Camera Clock Controller - CAMCC has
>> multiple power-domains which power it. Usually with a single power-domain
>> the core platform code will automatically switch on the singleton
>> power-domain for you. If you have multiple power-domains for a device, in
>> this case the clock controller, you need to switch those power-domains
>> on/off yourself.

> I think the series misses the platform-specific part. 

I don't think I understand what you mean by that.

It is hard to
> understand what kind of power relationship do you need to express. Is it
> actually the whole CC being powered by several domains? Or are some of
> those domains used to power up PLLs? Or as parents to some of GDSCs?

Well for example the TITAN_TOP_GDSC needs both PDs to be switched on.

We _could_ do this just for the CAMCC on x1e80100 - i.e. make it just 
for the camcc device but then, the next clock controller that needs more 
than one PD will have to implement the same fix.

---
bod

