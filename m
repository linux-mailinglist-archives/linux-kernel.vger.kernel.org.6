Return-Path: <linux-kernel+bounces-420969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 502B19D84EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1415B289E46
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33D6199FB0;
	Mon, 25 Nov 2024 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YSjOOpef"
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DB9156F5D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732535843; cv=none; b=L27UMSBn6mPtKHlWlKuHDqJQExYmb/QpPi9GfEYxWGf4shU37TPd/jTtw1O9OkqMHCDQ4ZcnpokyO8i6ceiyE6cWj21ZvOVYXTku7wIQksrj9+lvfGEXARNX0mJp1y/2AdWggPl1AHdGHTsDda9ygBR8aRvcaqwUD4PAkGtZJbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732535843; c=relaxed/simple;
	bh=kILxfPL3dcoFTEgvPSkAfQOYtmQ0dsIeqD86prk+2I0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZqyASAUL0bTBAQhrqvgmtDLCnCBxfibOAHqLiYakXjn3YCql2Wx+bHuBaBEP2ruclYEW0B1NFab8VjXCn+VIY2+4PyZ/tvrs3ylGvk96uAMJFpMkY74rmU91Rftwx4YZrl7+DY2qT8WDBmKUUbb4jBxqX2aTnSlgmyEo+LGK3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YSjOOpef; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-2ffbb62e0d7so611101fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 03:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732535839; x=1733140639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+KtFQm4yfSYkfhhIvB8KFwyzOv3qtl4+nYPNp2E79ho=;
        b=YSjOOpefg6dAE9GktTl6ZKktdSE3Ks5OOWDHPdtKyyaORZnVz7cPHZ9ZWvzZnT7TuT
         YObqDE0EpKIxQ6Zz8g5L86JcqhHQmaEZfEFBP5EcnW6SjKeVxYICUtpu9ykdC5MQX3M1
         QrNRLS2mNY/jFdYR3up/xk85Zz7DnyHIApgyrhjfKz+aLW3SpcLqHPoTUPG4KpWYcFl4
         CQbfVJ1fyEicU/zNYMO/y1H22wl2MZLxaWgpc7y8jU6Qork5LB6GrojyiIF6nUUjSoe8
         2lwDqd60haY3Lp1hYYd098n6jJNk6YrI8yrzGWH28CwZCcnAU+4U/zdOpmVpjjT+Gc/4
         WRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732535839; x=1733140639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+KtFQm4yfSYkfhhIvB8KFwyzOv3qtl4+nYPNp2E79ho=;
        b=HU9eEGUtHpJtQz6XN6gHD5nKUGpbYDQAwzpXI9WjucjX0VNz3n1t10cKM/bEhiLyS9
         H5H664zLS4BH/R3TAuHz2VbgolJ/BAb60Pn263ls5b0gpO7Zl2a4GY3sMx2kPsF/HpdV
         bA8M+gqaNjLmH0iX5b/MbQMiDn8WvjhhYrbeTURVwBc1+nD/h2LLB7ImTCcbahkvUbsK
         RGOo5GRuuiiw6upAhXQ0LJElmGnL/5xbkj7AIoc3zIvrHSfULOVy/x8zNJ8huW4zqTGs
         A8QVRgkaQA8MjmRUaBSVQyBc0hMPjpxhsVtOBfbmD92SXih077pJTYLlblBIic2cHsI8
         eOpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvt49ayTAiiQ9eev9QC7EeKceMvB5Y3DVDpC5TrXg8ehgKyYuazeI3L+d410cE1UJju/l+1MAKEz7b3F0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb64UigoswShyIl18Y/x6Lx3LI0zCkLUxcFdl3ONo/11b3WpLV
	eg7OLE8c7OyWuxxg0gDZJx7Vnr9SykaVLHtDPRQiDA0g6O/dFwAU9TdQ+uY4Wuc=
X-Gm-Gg: ASbGncvdq59ELu1Fs9naPMuuW1uUGb4ImKQ7nvTCGUIZ3IY7e8sVF2HhzMC2ovP/x6U
	Zx712dltvBZSljfF7hiXosorT+HOyAbP0IyAhZh8BZRLokMiHG04g3o+5DQwV/E5gwi9SuxkFon
	HO7Rcj+GG1U0yVFtsymNF1Ht37TXpN98R0ICUPRtIZgZMkMCbh6ZSU2Nxb/Fi3EDgfHUvUBfQCx
	AAOoOSXbkaX2wxa6KKk7w7jtUupqSvIVVNkQTn5vRX2rKcSD4IiBEGVBwc+RLxKgjs/3Y4rdVed
	ooqH6Ggsqr7Yv3v2EATiOtMYNd8j
X-Google-Smtp-Source: AGHT+IHNiHpUib9cbIEp9vFtClnvik1BHvDf3MMHQDLa/wfG5jjn9JO3VfQWjVKdCea/NjqKmbaD9g==
X-Received: by 2002:a2e:b891:0:b0:2fb:4ad6:a5fb with SMTP id 38308e7fff4ca-2ffa711f089mr18571851fa.6.1732535839297;
        Mon, 25 Nov 2024 03:57:19 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffb8180bddsm7991461fa.96.2024.11.25.03.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 03:57:18 -0800 (PST)
Message-ID: <b27fe267-c722-4133-ad7c-bdb1ff573ee7@linaro.org>
Date: Mon, 25 Nov 2024 13:57:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] media: qcom: camss: Re-structure
 camss_link_entities
Content-Language: en-US
To: Vikram Sharma <quic_vikramsa@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, bryan.odonoghue@linaro.org
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@quicinc.com
References: <20241125103457.1970608-1-quic_vikramsa@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20241125103457.1970608-1-quic_vikramsa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vikram,

On 11/25/24 12:34, Vikram Sharma wrote:
> Refactor the camss_link_entities function by breaking it down into
> three distinct functions. Each function will handle the linking of
> a specific entity separately, enhancing readability.
> 
> Changes in V3:
> - Broke down the change in 2 patches. first one to functionally
> decompose link error message. second to restrcture the link
> function.
> - Removed the declarion of camss_link_error from header file.
> - Link to v2: https://lore.kernel.org/linux-arm-msm/20241112133846.2397017-1-quic_vikramsa@quicinc.com/

as I said last time I don't see the value of these changes.

Since the changes are non-functional, then hopefully there should be
no issues with them, however I really miss the point of adding 65
lines of code for a questionable reason and at the price of increased
complexity.

Is there a good reason not to drop the series?

> Changes in V2:
> - Declared variables in reverse christmas tree order.
> - Functionally decomposed link error message.
> - Link to v1: https://lore.kernel.org/linux-arm-msm/20241111173845.1773553-1-quic_vikramsa@quicinc.com/
> 
>    To: Robert Foss <rfoss@kernel.org>
>    To: Todor Tomov <todor.too@gmail.com>
>    To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>    Cc: linux-media@vger.kernel.org
>    Cc: linux-kernel@vger.kernel.org
> 
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> 
> Vikram Sharma (2):
>    media: qcom: camss: reducing the repitious error message string
>    media: qcom: camss: Restructure camss_link_entities
> 
>   drivers/media/platform/qcom/camss/camss.c | 195 ++++++++++++++--------
>   1 file changed, 130 insertions(+), 65 deletions(-)
> 

--
Best wishes,
Vladimir

