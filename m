Return-Path: <linux-kernel+bounces-524676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB36A3E5B3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DAC117F133
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D60A2641D0;
	Thu, 20 Feb 2025 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VATQUrUp"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1881E2845
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082827; cv=none; b=S3yvQ2nh31eZ67mh9nuhyjs4+p2fXB2qbxLc377eDYf7Ov/fHB9zrxqrAbg/ME+e78n1UOodoxlEp7wTnAmD5MHatRjt9/Z2LhUHFk9bb2OXEZhvbvaFOJaHJz5rykIxiMjV+BTo/7+GS/S2d6YeJAY4turViafxbYRPw2FCyhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082827; c=relaxed/simple;
	bh=9AJ8NJ3fQ71s31AL2ReKVKY4uz5K/1w53C9zcgxtO+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BzUlXVuyQagshsj/9YcpCl8Z/oVb72FQSOK1kdiutjWc5L/G6pDsbVrLbQKc86koAizV0HNDQwpb9jcaDuWXWX07t31VKzm3gz9xMVmgVkmdAbBKZFMpE0pRLfF+B3xEHc1D2sVdRP7R/Pmf1HwOCGuLqdzbEvnj+FiRfFkNmtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VATQUrUp; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5fcde65241cso948979eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740082823; x=1740687623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3YA0S6DeTYDLSFKZ0z+n+MPKwXA/ZHvwCQOrhZShsds=;
        b=VATQUrUpyhnfA/wKRR5imajWPBWt/CitSu1NwmIu5xZMmmgvi51TsTD3b7iDHmreTd
         fW397KmI+vuS8Y9unSiTWOvpzOClSXH8q2ytMJgrFUw8q7BIP4KZ0coUzZbxUfhPXExI
         6BdGBuc+E5IMnCfkHaYCH0eOnRdzL5x7RcShAYfzG1BvoxW5u2cwevhvYUdHkl+Ag1O/
         +dVjnqYOIKPjSMVHQefpq39AW4lhAicb8MPuAmeoeEj9iv8AQWQSTxxPuvUPwZ42Zz45
         33ykJ1otFBQixPV8p8jj0Nm2mHIcycNW7rZntb1SguOMqaxszLtC5gu/kvSiP6At7gDC
         Zq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740082823; x=1740687623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YA0S6DeTYDLSFKZ0z+n+MPKwXA/ZHvwCQOrhZShsds=;
        b=OgBbh000BlN7AxwtNeGnt65CpeFG/SEcMFRXhgzhN1/sWyzmTOsxaRvqwSkQaf0WwT
         01ynzcy7zNJQ1C6jteVrYAJ3s2tXHdIHeyrQn26PSLBvrjvEJB2B2NrUEpxPGXIjULWc
         n0zNsVjzsNu+ErfczqGG20Y6NtORZftxPEserV2y8uu6rhMN4gxnVASZP9loKPFbuvVp
         5X82+M+379py91JgDz5mgwe6CEGx2vEaHaRYN9ydD+4p7tgGvnLm+RSx2pa5xQb1Ej41
         71HGFH09+Pq+Ww6S9Gc2Lisa0dYmI47YXDH3KvSM1qw+093p+JEA5AUwYxiZuieNS/Oq
         yA+g==
X-Forwarded-Encrypted: i=1; AJvYcCUZgeeUFxIfuWct8FTSrpvlmS9FmjTORTjhD/aksRPDs97GxE0JY4z2ONSJcjYxkF5PiwisMpJ2rdqMEJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqohmY4zLJyOLXsReEvOncLZiU+NG4GRbiGgMUWVDCc0kk1/lF
	/qB5N74Hf83xFWEw6yaFrnzcB+p69LkzlkLZzEEO+cOQ6RPGe6b7M3/G0vUU6Zw=
X-Gm-Gg: ASbGnctPTR9yr4JP6cB++f15OxmcZUpWrY5QTbgZLeq7udgIf9DP3KtifK7NmoWSNiS
	Orpzdc91f6L5R+662+wGNnWyfstsx5KO4fcWoOtmgyOXuahQtnwNOx127+4WB2nnekwupxnqpmK
	Fg4wINz9/aY5FtcDtFG/b2Vz+9M/HedtCNOw8QmkO4lyAbf+eLZe/S1xKHoqwsMH3LqQfx/Fl23
	sW9noJh3CMWADVyNwELOFpicJXuYl2DBvSJ35lIE83+d1uS6iIn05VOQb9YimyRyCJ9iyFTu1U5
	rAxR7QsclS4exmhHiekxE9211CqifOPvHw6tfCVhRP1ugS2DbtV/
X-Google-Smtp-Source: AGHT+IGSPaTaOucH2dLQqzNmLsQTf0sq/ili5Qrkv0KGKys857Oj5ka28XQilT2mB8kbG8XY9mj4fw==
X-Received: by 2002:a05:6808:2112:b0:3f3:d5a1:a928 with SMTP id 5614622812f47-3f4247c1ef4mr590369b6e.32.1740082823499;
        Thu, 20 Feb 2025 12:20:23 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f41a6fc550sm504082b6e.39.2025.02.20.12.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 12:20:22 -0800 (PST)
Message-ID: <13c5e420-a3ca-468b-8810-3528b24d8664@baylibre.com>
Date: Thu, 20 Feb 2025 14:20:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] iio: backend: add support for number of lanes
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250220135429.8615-1-antoniu.miclaus@analog.com>
 <20250220135429.8615-6-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250220135429.8615-6-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/25 7:54 AM, Antoniu Miclaus wrote:
> Add iio backend support for number of lanes to be enabled.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
This is why I was pushing for a similar function to be an iio_backend
function in [1]. :-)

[1]: https://lore.kernel.org/linux-iio/94efa413-5fa9-4014-86c2-331442e9d42e@baylibre.com/

Not sure if that changes what we want to do here, but just pointing it
out as a similar case to help us decide what the most useful generic
function would be for this.



