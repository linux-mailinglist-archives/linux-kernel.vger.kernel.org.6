Return-Path: <linux-kernel+bounces-545580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C63AA4EECF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA1F3A9A81
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBA525F794;
	Tue,  4 Mar 2025 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJMjCtrz"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6A0204F60
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741121619; cv=none; b=UZCkN96g+Ca/Qq4w1WVpXiBp/z8K1hdUdNxAqQ8cCrrVDt/trfKH325eWbOTelhdZVCwF64J0eDftvGDjY0/0PfUY1TUv6nHwl14tYgrndWWcJM3TkasTUwBZJSA5p6QI4AmSqqgYMqqR1Er3mu+yLAYDdCgvX2T/K8YDHAHcIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741121619; c=relaxed/simple;
	bh=mA9+PHMFooGUyVvalwOoDEUqK2suH4DsantGUVGZXnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GyzOx8lJi98yxy+12Oq3HyKW/B75kKY1+HkUTFXdCqqCwXdx0rnRqOIQ1sAoQYQ/LYHXIjz/7A80yxOUXsolVwW+4y8HbHangVQ3V6UiRUKqggWGHZmVQU+SvpsTloeHZ0cjfoDvhPV2jF+II1XVWwwNr7V3zAB6qnQIer1wD4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HJMjCtrz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43bc4b1603fso16450165e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 12:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741121615; x=1741726415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=176IuqL2nIlbQWs+xZpdvtDLv40PZdssJr6NxTnMxrk=;
        b=HJMjCtrz92EkgJLzorNpDYsG0yE6F2mcoPxd0fmXN7n8I8Phv0+hUQg5kpLQJ0G3Zg
         J5YRbNN1eMVIwXqx8PGoxz6HdyzwlnBsF2HWH8llXwzdyLAi8/fjnnm8Xa7aFU1eLlh8
         nElVop2DoqzOqLgajiu4J29r8m05jX3k4zdHvw8Wo8SebCTF0hjaaTk5en5UE0em0L19
         9yFInDMCVMlnbkpKiryAcUeWFS+Qnf18kTjZOSGCg8sDswS7GR3LnwSCz1dgJm/FLtxu
         DkmcW98px8ngRb2YA9bjNztnK0LFHAp4sYYivhK9Amwb0CEuY/jCx42B9BfYLH7Fcra6
         CSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741121615; x=1741726415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=176IuqL2nIlbQWs+xZpdvtDLv40PZdssJr6NxTnMxrk=;
        b=RTYX640++aJo6NyejyXcpi2hoAkc05L0uwv7XsN6YbB2o9HCJW+BJd7El9DHhwoMNf
         g6DGVM2KOrB3E7vOZDlV8zLXsrp/ZjuCFIY+fn9y8Zy/F5wcjEhxyxxWE05GVLrRxq1h
         nEfKK8Ez4n5n1nt6KajK5uVtCqDHDOoWXkIZGR9iAn4Z+VBCrJGDeOFcskl56TEqjZKm
         2rYERMbC5K1AfCCZ9xlu/+zvy/6h8euxyt37bDfV+EPUfkdLHGRjX+9QJZPv1CDAaCCf
         47RO7iWJ1unAYNH9Vhq2Qos4qriQ69O84K5Sf7/p63bEQwbDMEk4RUmTfPfS5B4OaAzS
         zaPA==
X-Forwarded-Encrypted: i=1; AJvYcCW+gqVBTGzJNA/jrZH9VvsA/PYYEyMrFVW9yOE9Sos3ru4yy0kKfF3ZkZ+LMgSfuDTRZHAlSkTnzCBhOWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+0RgjEf8E1bE+WsFYH7+bBNMwZr6hs/IdzrP7cQyJ84q1Nn1V
	fd1eJhy0ySKAQ0qR/QopT/eJ56li3k/RdYSM0cqMLwOHAgVzjuvT2BSzIUupvU0=
X-Gm-Gg: ASbGncvjpP33eUqnldgnkRuzRtV/Nj7m3RiYDv7qT8yQWDz23O5HnUpcu2MgUJ6FFJN
	/gDQAiOfoPal3yRnjKSerYgGn78RhBbfhAPUY0tVIEaCmJPqnKpQ9EYCHYrs0OWVnK4g/6oQ1J2
	0RpG9ozZeVfCeh5oG9hXYnL33XTHlFxRz72CP5lV7PFs512nfmPwuqfOyYiAITuc4W4e490mdZE
	zK2VH8R/3W5vAO3sZFDUH0sfIKRatPtfhu7RzRyHWWsDSpa+PjrRSy++zZzRM6cxw3Vwe4h54S1
	Guj41N6272VRP93u5yw1612dzJuyIETrXe+szUEw5uOWcqyzNyImEm/m2OY9LLqSnINGeVoBXxk
	eUGWee+UN
X-Google-Smtp-Source: AGHT+IHhKovBOGFwFyaMynqny1tpm16dU4paY7VQpBoQd3lyWxB3vCi+8HoCRDPxtR6V4y3DexBtBQ==
X-Received: by 2002:a05:600c:46ca:b0:43b:cb09:13e9 with SMTP id 5b1f17b1804b1-43bd299e4bemr2641735e9.17.1741121614932;
        Tue, 04 Mar 2025 12:53:34 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43b736f990esm217057765e9.5.2025.03.04.12.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 12:53:33 -0800 (PST)
Message-ID: <c1e3da79-045c-4761-999f-b76e2d480e64@linaro.org>
Date: Tue, 4 Mar 2025 21:53:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: exynos_mct: fixed a spelling error
To: Anindya Sundar Gayen <anindya.sg@samsung.com>,
 linux-kernel@vger.kernel.org, tglx@linutronix.de
Cc: aswani.reddy@samsung.com, pankaj.dubey@samsung.com
References: <CGME20250228135411epcas5p1c1bbaea7cec83d32ac8f032817e558b9@epcas5p1.samsung.com>
 <20250228131138.9208-1-anindya.sg@samsung.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250228131138.9208-1-anindya.sg@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/02/2025 14:11, Anindya Sundar Gayen wrote:
> Fixed a spelling issue in driver.
> 
> Signed-off-by: Anindya Sundar Gayen <anindya.sg@samsung.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

