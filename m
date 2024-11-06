Return-Path: <linux-kernel+bounces-398366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9CD9BF05A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFC9281F0F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2224B20371C;
	Wed,  6 Nov 2024 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NjKhA5Au"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24522205AB7
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730903387; cv=none; b=aU3znxx7aOzAtOmolIALLTeJ9gg5k5yWGll7NoKlkqDcxJDcC23ncjFr5AOKiVp3oktHhuLd8qZPvJdRs5drxT2Zf9BBZemNtRaIKTEnPqww61oxVllBqrSf+JMdObNbE/pWrhkzHBI/NBZDoUNANWT/p3TRMLGERnye1XFlHgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730903387; c=relaxed/simple;
	bh=H2Ic6zSvZGlj5DycCh7tigRI0HlDeEXPrDJoxTox+Hw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DpVdgCgHMX9jD7ef3ZyuzATjKokSKIMfih6L1GIP/6GX75tLlTQwSjojq2mOdGvpDbKqTmP35WeRsdCmnH20Hn81QJ9PDyh2rl+3jjvsIqeqKYxJPfbW2NYswXGX/lqXAga6rBlpos/ztZ04g3Fq3El1mskQkBpz3gHG3wGwREo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NjKhA5Au; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso58469245e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 06:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730903383; x=1731508183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wp/RzZ8stukEUo9vqkhB7XdERuVBa+d68xrEXXOPDY=;
        b=NjKhA5AuxxXITmiqj2Mdwov9P/6FAoRQ2cTN7lHWSXWZLm9Pkj9fksz1978jxsSr7V
         GXtkDJMLVnc7sM1+fPE+SzNU/6w6yOXpikTTe7XzWX7ifrQ9h9mf9c1wfJrr37xrZphq
         VXIeuMBLKf8tQyusC8dNJQmy3pLXwb0m139SsKjr3DH25DYncooyM9jE0nYmAtMHXf0l
         48DC0rBF9UgHU9HWOqBXNM1a056bVF3npCL1oEcnO02S0SIuvfVESazbFhLSAbvikTkP
         ASaaCXUx3wPfxlXaNvVquHTc6HmBYn0ijdZte867HVIwxqO0Yi0RVGa467PQpzH/HIpA
         J7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730903383; x=1731508183;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5wp/RzZ8stukEUo9vqkhB7XdERuVBa+d68xrEXXOPDY=;
        b=njaonlGBxOCAYCaTo2bXAS5LL0PmQPtLiGIMu7liWMI1b8Oe78UJ6azouJ8+hAJK8b
         8pVhIJZGScqZMzJMfuIaIQYtu+45qsjZxjUlxKw4NmVzXYLougpeN1kK3zxfGRQyB98g
         8EGSzt5eKiknvXN8U1cn8LyLzDDq5EazXoUjCf61STF73gf2TKgbNm602L7e5gm8A8Xz
         B6bPuotojffiPqjBqlkxxCndzNXedX4cgAMtysM94fKFcxrv3s8oXb5Qn4CDg5q4Nb3a
         0FRzc2xTdWHNvIhjtYEwGdrQOi52X0GTq4oXUOnZQJFiJ2qRQPFrdmTN/wzfDVvA4Ihf
         RnuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz1x17yKdFSkEM6Io3zuMe8z3/UHDSq/IO0nVLp07onqgNQ3DLj9e1QvTFBuIdkUP/o8fxPiiPh3c5rqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6CGriSzcGzbVepkZNbBv9/dodN9uZ50WkTdI+2aIZkX6V6CnE
	rP6uUjF90PK6qnMIva1Mlnijt8l9dwNKrJurSzSA4ejH78siUqCzk+fv84LV0Zg=
X-Google-Smtp-Source: AGHT+IELNJgIAqVQvwG4qRFfS/gSb6bYG5A4GC+lnpGy7OGO7TJ8U5AU50yDvrEQMVx/t2tbxFlDww==
X-Received: by 2002:a05:600c:524d:b0:431:1d0a:38e2 with SMTP id 5b1f17b1804b1-4327b6fd392mr210183985e9.21.1730903383376;
        Wed, 06 Nov 2024 06:29:43 -0800 (PST)
Received: from [172.16.23.252] ([89.101.134.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6c655esm24752315e9.24.2024.11.06.06.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 06:29:42 -0800 (PST)
Message-ID: <f56bbe18-dee8-44f7-b168-76b8ddab584e@linaro.org>
Date: Wed, 6 Nov 2024 15:29:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/7] dt-bindings: display: panel: Rename rg35xx-plus-panel
 back to WL-355608-A8
To: Hironori KIKUCHI <kikuchan98@gmail.com>, Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
 Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ryan Walklin <ryan@testtoast.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20241105055239.1577275-1-kikuchan98@gmail.com>
 <20241105055239.1577275-2-kikuchan98@gmail.com>
 <20241105141900.GA3110982-robh@kernel.org>
 <20241105-maybe-chamomile-7505214f737e@spud>
 <CAG40kxGhaY_i9_zX_tM4MtCGwUUC2hwpJBAT7XF4Oe6STzA1hw@mail.gmail.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <CAG40kxGhaY_i9_zX_tM4MtCGwUUC2hwpJBAT7XF4Oe6STzA1hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/11/2024 05:56, Hironori KIKUCHI wrote:
> Ok, Thank you guys.
> 
> Could you help me how to name the new panel YLM-LBV0345001H-V2 for the recent RG35XX Plus please?
> - Use `anbernic,rg35xx-plus-panel-v2`
> - Use `anbernic,rg35xx-plus-panel-new`
> - Use `anbernic,ylm-lbv0345001h-v2`
> - Share `anbernic,rg35xx-plus-panel`

I guess you'll need to use the hw revision:
anbernic,rg35xx-plus-rev2-panel

Neil

> 
> For the last option, I need to use another GPIO to detecting a panel within a driver, but I it isn't robust (depends on the board and circuits).
> 
> Also, there is another panel YLM-LBV0400001X-V1 for RG40XX H/V:
> - `anbernic,rg40xx-panel`
> - `anbernic,ylm-lbv0400001x-v1`
> 
> Any suggestion?
> 
> Regards,
> kikuchan


