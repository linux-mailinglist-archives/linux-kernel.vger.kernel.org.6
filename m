Return-Path: <linux-kernel+bounces-311669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D39968BE9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493A31C21C43
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639511AB6C9;
	Mon,  2 Sep 2024 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oboYHzKE"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DAF1A303B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725293816; cv=none; b=jeZbuKVKc/hgZ2b/w2jsk0yd4WI61rElqSKSHIjpS5bYtY0tJIwv0j7UqIwa58S4z3PlzRoUlPngDBEV/szCkA1Jlsb1WIbAgXDNCCZkKeqBMaeE5zvfcph5Z2479lU9JZeIcmfmUHIlqC5+tdgQtaiMwI3HfEYZ5FjE3QZSRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725293816; c=relaxed/simple;
	bh=279AYoB6M6LUfQWrroj3/71+NSd4D3D9x57DTZOMsl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxntHNtcV8gvpSbthakNvcGBdu/jTJHAzG+l3cibW6oVfpftQeKbEKpjNwMINbIA9yf3fkYz7da1OX4WQVg6Nt+onZVgFPfVf+Z83z9kc6xSXcmFq8F/C6Tjv+DTI2H+YbHKnPpLGksrwkayNNYkRW48vxK9qTGn0pnjhxPY1n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oboYHzKE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42c7856ed66so18938235e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 09:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725293813; x=1725898613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q8h/EGszP6xFdvE6sZAaqQlIirsRwUlWC1I0F8vKGJM=;
        b=oboYHzKEXDObutJxWvlJ0KXsvupktBkpbbpaW8yVC+AeNBh96phKjumM0oKTGB7CYh
         1NtpTkr44mwUWx2VK8khLz9TnvnhbRpHuQM4XCswGvEQBt9zimoh7ORn/G5ZlWSbKXav
         wdAkl5PfSssyh9uWxGzTVLkx2pI+XLDewUQvV6kyKFTU3OG0NHQtjXU5ppt7pTR2mya9
         rDvG5+wfxq4KIY7kIuWNrNMt8P+GsM5oNHIuUIE/k3kk7RBASsZ4Zr2EIKdAeweOXQOt
         pWgAj5ZGqPBsZJZlU1d4+asETGFKu8oaxVkMt/LE9eFokGsK5dLbS6ub2VlnbWjezOh0
         qoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725293813; x=1725898613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8h/EGszP6xFdvE6sZAaqQlIirsRwUlWC1I0F8vKGJM=;
        b=WxNFlm5NzGs01U1GFpFlB/hQZjKWWkx9RE2qoHpwDgFIdP5It22rAS599eyyLZrTZK
         2ya5qf96xKdNMV3n8IVIjAz16MrS5UbutAgB6LXV0Af61Ajl4AlfMkNWX9s3TLxPyjyo
         E8TvWJrlRd3NV1+gVmzyEWt49YGe9scsZ1kD/Dw6nO+ISmSGknvVQI6ljmlkE7fPXxQH
         aggx3OQGfyLDKd9h2n8KK2gIfuXxhbWkklMVAlv8YMSPZ2/lKl9OOlztXFLKC6i9zmdl
         Bl82ORbtXQKb9FMlV6sGz05esgqvSaU3fhpWy+6cRdSmjTb03PjDsmhEHoHphQRGPkMA
         0PXw==
X-Forwarded-Encrypted: i=1; AJvYcCVXxp+qQerIPfD8akL8QiDrJS/1cxJo7Zh00ioPO3F05gYoa2IFB+Qc+Z01OBjkdEls8NYUH+uvNGUxyAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCTq39/rD8tRwcrt2ykFFtGr+dgjuPl95lCJ+3W+0LMp+Lykj4
	asneZxl0abJ1GAYFDjjtJ/QHv/u/qvn4z//qkcZiXfOGgj485fB+K5xSmTi7b7UIheLnT0JFqd9
	/
X-Google-Smtp-Source: AGHT+IEmOkVDfJIoDWZjj/iaAv98BJrAju1GPOB28FkfzY8GNSwwTPs7KU6TSWiaChCcdpz0zMtN7Q==
X-Received: by 2002:a05:600c:4505:b0:426:60b8:d8ba with SMTP id 5b1f17b1804b1-42bb27a9ca8mr116220405e9.28.1725293813003;
        Mon, 02 Sep 2024 09:16:53 -0700 (PDT)
Received: from [192.168.0.2] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb273sm143693955e9.8.2024.09.02.09.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 09:16:51 -0700 (PDT)
Message-ID: <b305c86a-1dab-41ef-ad04-49526389dd97@baylibre.com>
Date: Mon, 2 Sep 2024 18:15:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/8] iio: dac: ad3552r: changes to use FIELD_PREP
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
 <20240829-wip-bl-ad3552r-axi-v0-v1-5-b6da6015327a@baylibre.com>
 <20240831124847.5c679e55@jic23-huawei>
Content-Language: en-US
From: Angelo Dureghello <adureghello@baylibre.com>
In-Reply-To: <20240831124847.5c679e55@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 31/08/24 1:48 PM, Jonathan Cameron wrote:
> On Thu, 29 Aug 2024 14:32:03 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
>
>> From: Angelo Dureghello <adureghello@baylibre.com>
>>
>> Changes to use FIELD_PREP, so that driver-specific ad3552r_field_prep
>> is removed. Variables (arrays) that was used to call ad3552r_field_prep
>> are removerd too.
> removed
fixed thanks.
>
> LGTM

Regards,
Angelo

-- 
  ,,,      Angelo Dureghello
:: :.     BayLibre -runtime team- Developer
:`___:
  `____:


