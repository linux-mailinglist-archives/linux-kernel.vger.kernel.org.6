Return-Path: <linux-kernel+bounces-269985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2F39439A8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B751C208BF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5DD16E87D;
	Wed, 31 Jul 2024 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LAxUHptm"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F8F16DC31
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470130; cv=none; b=FvqD3xx8nTXukyM4qdeO2IFyWfdgPjib1A42SESmwstvZp5hcD9DrytMbWWq4Dztt1gP0MJZfkrcoM9j8c5Z/MRY1awIYHNg2vZHeFP/1agkWVIwIduYP9N0UyTKVaWR0ShUoczgJOo4ONpZKnkrDX4E2pZvcAGvnT8i4TnBQHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470130; c=relaxed/simple;
	bh=xa90za8ap4kZtbgIb/vEkrdsRq3O8fT5kqQZJ5RcLas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJbKHY77CplCXzpSseWSFqtffEzRW33SE9ZSzzMdqIARgKmEbYjKrwSkGsoiQ/WEo8Ze9/m5tbK9RnPA2K1GEqofg5TH0YHlZeW4tg7hsa/o1h9oSH5fVYWioZVPxA3uY6EBAAx7NvBVsDR3PginVU6Bnm0y8o4zN/x+WQlfexM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LAxUHptm; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef20c3821cso12338491fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722470126; x=1723074926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJ3NULCzkwiCC2Hepk8G5amN9VNikpjxRbG+tpF7zHA=;
        b=LAxUHptmt5CamYLjVrrFNpWTfJYyk3PDEUwx/W4A6UKHR2p+HmROfqmG6UFxat5TlW
         IgC8W1sUXsi8qrepOERtZen6L8PBj+bMCrljeYbucN1m/22FLKstUIt2pwst24wvqFC+
         f1futCWS4Klia8spOBy4vO1/0bzVEgNZjiBrgG6/9bglCmSfX5jKXkejMHGN21eME2sO
         364x/NIirD3rSn3Qo7McU1eg3rZi4CF2P2qARNflC4gA/YTA/ZeXwani9OkIHBUzTxjZ
         uqBFz3oLkFX/r0gz2gWyhPlDqO1dcl0wDd6vGh+Bd2EJe39gYbdjU8TG+Gd5UiMa3ntQ
         OhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722470126; x=1723074926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJ3NULCzkwiCC2Hepk8G5amN9VNikpjxRbG+tpF7zHA=;
        b=MOuFg0lJV/+QGT+uqVjeCfJxKxibf6iiyt8lwmTVJjfmfVTDgMrJ79yLe7GYr4tGvW
         9xg8hw5ghF75o5Cs+A9X/06gAxM+yDnspAKqlDBvfy1l6dky5htMZYI1k2CTECb78UCs
         SQiiEdjBrUzi4WA6EvHbh5MsXgwRrfjwy4xO6MtESFsgt+xPzIECZFnot5SbgVMt58x+
         s2+9ErsrwHmhaMi7Dhu1loGOTHmjGTMI0fVrLAu7QLweNWcfGGForBYglS40YrBCsy3t
         +Glxz4IUlRs+z4wvOZ8Xsco0SQyBe3zGW0hejDy87BnMlONoKwODszBNYpI6/aRMaeUw
         74Mw==
X-Forwarded-Encrypted: i=1; AJvYcCU1CBvlW75vtQBqGLxR241Yn5Jaem3mQmxy9TK/yACFu0VtPNG1JpXe0xheuDoKr7kQCe+W+I/f9/K0l/1PmWIlFyZBvrNwTSOQV6VG
X-Gm-Message-State: AOJu0YysvrMZV0WixRKrKPoKjiFOK6OF5YXoNW818uaaanbaHiaoWZc3
	bt4hCixP5tbweWntcZy+hmwOlcfi/sv+J7NT8F/EofLXzt0PONOVa10SxawO3Qo=
X-Google-Smtp-Source: AGHT+IF6eRxek4PxWOHk6Y7e1bIUu6GosnxevnqznvnaV3O3UEpj3faiBC9UP/AMMW67lO/QHf44xg==
X-Received: by 2002:a2e:a7c7:0:b0:2ef:17df:62f9 with SMTP id 38308e7fff4ca-2f15329fdbcmr3852471fa.7.1722470126358;
        Wed, 31 Jul 2024 16:55:26 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03cf3020esm20778791fa.33.2024.07.31.16.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 16:55:25 -0700 (PDT)
Message-ID: <4fdf4f1c-fac0-4c85-8154-45f797c6acfd@linaro.org>
Date: Thu, 1 Aug 2024 02:55:24 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] media: qcom: camss: csiphy-3ph: Move CSIPHY
 variables to data field inside csiphy struct
Content-Language: en-US
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, bryan.odonoghue@linaro.org, mchehab@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240709160656.31146-1-quic_depengs@quicinc.com>
 <20240709160656.31146-6-quic_depengs@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20240709160656.31146-6-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryan,

On 7/9/24 19:06, Depeng Shao wrote:
> From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 
> A .data field in the csiphy device structure allows us to extend out the
> register layout of the three phase capable CSIPHY layer.
> 
> Move the existing lane configuration structure to an encapsulating
> structure -> struct csiphy_device_regs which is derived from the .data
> field populated at PHY init time, as opposed to calculated at lane
> configuration.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>

in my opinion the change is good, still it might be reasonable to rename
.init to something else and/or get it out of hw_ops.

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir

