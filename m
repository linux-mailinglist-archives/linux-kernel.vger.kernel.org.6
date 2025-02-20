Return-Path: <linux-kernel+bounces-524832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E61A3E79F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC7A3B90CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2F5264F85;
	Thu, 20 Feb 2025 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fNKlmkCe"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0D51EE02A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740091112; cv=none; b=EOh47k4QC5SXdQgTJX+UaqXNaclsNMytbRO/rPSJVSiuBSOGT+rhqaso1/NfEJSV40j5AmFPSlwJcEzFdzH/xijGi5XQndi5dq6dSLdrMuKBwxVEuKxX7Q+WAoxVeaKl5MrVy52EflkACLjuvJ69+H2eqK87cmqHT+C4kMVVIrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740091112; c=relaxed/simple;
	bh=sWMtMJhIGgZDkwBs1wdeFaJJtPcHRts5l/4w38T2rfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fU1p6AU2XUhUwBTNr5B+oxvWIzDZrvJotZf59wX92aZqzBL9akCrgJ4/tNaic3FZU7QEpnoJ35/95aomiEHmZ8nFJ0kTy9WPG09rQmZKxhvorxNlyPhTNwP34/AurSv/dmTDIIQKbFCbsFjgdsnUV06PWTDz8dhgZZhiDAemDL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fNKlmkCe; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72716c75f20so434847a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740091108; x=1740695908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZvnme7tRdTD63uQFjHp0iE5fgweZwPuVbaZo06CSNU=;
        b=fNKlmkCeOyqBMIADau+YNglc76AOrOmhQDFNSz2eaZF1tODfP5NcxSn9gfc5fwfgMD
         Tms4gc6lkuE/ydOWKs8DhFxgfTUKg3p/61QmC7O1hQEK5bgc/Ds2Xfja5RFoLWDJavBk
         HL9KtkCTtVF3G+xhkZFWO/MMm/8rl098PrckC1+GDDeDkl3nIQ+4VzLAZIIM4BE+iDsU
         Ugkn6xnCwlGdjYyD9WsbS+E484CBFJ8PFWg9l4uuxPP8/JZNdxwr1oHGYgkg8JQ1yKRs
         Br+9AYo9lhx+akioUQnaKKeeznxd1NYjE9t6uI1auOEGFAxjTmO4d4t/QwrSOkHxzARw
         Dr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740091108; x=1740695908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZvnme7tRdTD63uQFjHp0iE5fgweZwPuVbaZo06CSNU=;
        b=MuZz9hx/EqNJo9BPLSJGNkQaE3zy2TF5MPkmDVhc7EOwU+BSQnLrGyhuwxnDuNRtSs
         ezBUf0tRyyHYUmwMOv5DCXQr0C1TUg+0v8V+87cR2KNm09l8yxAEXUcshU802nIUj8Bg
         t6crxIlG1a+kPwbgireqYIzKWYQotqohjMR3Hf07J/srn6TCMkWleO0aEmiHCMWLhNjE
         YKBXT/Slv0N4XyulQbDi47oO5c0kL2ryMDqWcP8fDx1Kz/OoVKXSHAo/C2DOqu+4n3IL
         PwtGlrV+OKbtL8O7gbRG2EQGEmlgEU5Ak7Z3jE7GybillqbaCHNkw/32hnzoKOucnmF4
         OxzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4DRAO8cdVfIURjxoZD0gbGgwhYXAxgIvVfni9/4ul+50JfDBBQsa//dcJss1DpxNIgHU5KRZujefuKuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHYiK7SMzdKTphjtrtScV0yDb75ERnFunxcrAC71eYPWNyBS9a
	q/N+40HHXqywCJOIvb7hWMiKcs9TfaKL98ug4u9tk9tj0o6b5YDa84CciCgvni4=
X-Gm-Gg: ASbGnctFV0eDjL7A/z55vn5AdcgunekjlZ/i6Q77RPqFZpRtiX7drtYSZY3DTNU+h0s
	H394A79PpIdy5aC3D1v5Hlrx7+wZBGJTuXWvfq4eBJirLU8Sz9Pg5xniM7+BS6dlU/x1VP/AiFQ
	X/nelsTdjWaeHleJh2IZ7KYJps/HTFkYsQ7Sk/2uP3n4TOvg24dzcERlo8Sl/wdpNHo7n58Q14+
	y1fpRdHOj6g3qkGqJWj2xN3XDGuJXNVdinOwH7gvJ8Y8744x2GrKzMjep4KHmaUsxrWeP4U3SEv
	Xbu21ENhJ/gaC1/Zn8k53IWpzsiTGC15DyYb3rRbZj4F1ryMzRNV
X-Google-Smtp-Source: AGHT+IEzdfjmrp9J+sxTdexLYB1VUUUSlpEgBRUKFEO5q3qrJomkJEMgCb7UY4Y09D1Vyk3fevqGpw==
X-Received: by 2002:a05:6830:8d2:b0:727:2751:6b93 with SMTP id 46e09a7af769-7274c25bcedmr785372a34.20.1740091108688;
        Thu, 20 Feb 2025 14:38:28 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72732331fe0sm1729171a34.43.2025.02.20.14.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 14:38:28 -0800 (PST)
Message-ID: <3c54045c-6001-4f13-a421-f7f4844b6ccc@baylibre.com>
Date: Thu, 20 Feb 2025 16:38:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 13/17] iio: adc: ad7768-1: add multiple scan
 types to support 16-bits mode
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, jonath4nns@gmail.com,
 marcelo.schmitt1@gmail.com
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <854d64a0b431e66e70dcfeaf75bc6e40c4c25a78.1739368121.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <854d64a0b431e66e70dcfeaf75bc6e40c4c25a78.1739368121.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 12:18 PM, Jonathan Santos wrote:
> When the device is configured to Sinc5 filter and decimation x8,
> output data is reduced to 16-bits in order to support 1 MHz of
> sampling frequency due to clock limitation.

It would be a bit more clear if this said that x8 is only possible
with sinc5, so we don't have to check the filter type in the code.
At first, I thought the code was missing that part of the check.

> 
> Use multiple scan types feature to enable the driver to switch
> scan type in runtime, making possible to support both 24-bit and
> 16-bit resolution.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---

Reviewed-by: David Lechner <dlechner@baylire.com>


