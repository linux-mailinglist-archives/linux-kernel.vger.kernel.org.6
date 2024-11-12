Return-Path: <linux-kernel+bounces-406671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E20F9C631C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ACC5B37FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30982194A1;
	Tue, 12 Nov 2024 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ts/mEbFx"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9004020ADEC
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441735; cv=none; b=aTUodQqFyvwkJ9Ra8hLkJrUgFpCQfDGPBzyr4isox4+jIItbArspzP6Y79lcVxverTg9hNPYJFWyNG6Gm0bFuJQizvZk94kNZHRSM7EqP6tjGPS05F1obAi7kowJCx+7cWj5m64KboXatp6Szn51bLBt0ev/83ggsFYuoAU9Kc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441735; c=relaxed/simple;
	bh=DsjL5XWtMu7LOlZcx8scvAGiiIKiZ9tDUiuwStI2eok=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c0GnLgMU6H141aYCfucKWb8njUHBm9YSy5w8kgofDVqMfg4OerYpohQU0oElKvJaQB2RX83DyLNgX7YUivJFLMLM7RParTjDlP3D24f2A+o8h4Xe7AibSppjuwvMhi4T1MWCgHpoQaCgEWUTvyLhHJAl5WAam6xLi7FXtA+gd6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ts/mEbFx; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5ee763f9779so1399837eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731441730; x=1732046530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7sig4extPJZ96lJvrKPLyrOLWEJSmKbg3dopfHgQP/c=;
        b=ts/mEbFxY8PajthwxUh0SHvXAjC9tAF3NkrqRnP0XeLjkumrBKov8OYfg6+Rz76+C3
         gq2QcSd+T4V905cGYxU1wlMsaXIlTXgXSJT9tcv3nX1BOdhnZQrLpwOIp5C3kvIQhauH
         Q/Y+bMo/fV9SnWxH3TUiTRetqIUgjnG4Bag9n/iXNNc+gPgqqtW2SR2xb7365Kn1A7bt
         iiziYyv2LXIw19KIUMRFWPBeqBQ8gv6l8uKtwCfxy6vy8S+jdq7+9CTiVqjuUd5iGyLm
         ZyPBcQwV0+PABObdLkMVqy5R5sc0MyufZeQpxERWhyRRqCzc7goyPhLDDg2XFMltHhbP
         HfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731441730; x=1732046530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sig4extPJZ96lJvrKPLyrOLWEJSmKbg3dopfHgQP/c=;
        b=LkOeZt6VciyAVD/H6Ug2oTzadzzJ8MGEd3vac288MNlvo+YBiSB6m4iX/e3vKVTm+I
         I30Nb1TPVLaZGJvHnFqqAbWJKfDuuMplZCcrK++Tg4d3mEQ5apXbHrCUF9xYRNF9J3ds
         FUQ8N4l9B/h8hhpKLUKB0vSbCNz5BfurxfsJBowdtztf7Uy309xl57iN9BLqmPYuXT3L
         3m8+XlPRn1GDkYTVv3JffH/bHaFWuNB1HduXskf6H7WMBPOTH4ckzMz7y9NZAnMTIfUR
         vlKkjOF6oWn8T6TUmV6J4dcurNGmPj3oR42uFzSDD0KlCwYI9MASnJWfM0xONmGcFbBQ
         4dWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV4hYq+ZKXCMQk+7pPwEjnikHFJCk62Zp2W4I6UJ799gXYx5E/y6xoYCmwqAI7BzPId4hhgo9v9KvXvfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjii6yyTj6AGagHp9FROb0p4oxhVy4lUovwiS78KXvq61YlKm4
	qwDqlwFn2OsL4Sb+yXYxjFYvz4UCAG6sIJwb4NqDRWCa7h205h5Nz1Zrkly7qUk=
X-Google-Smtp-Source: AGHT+IHvgnmHiHHXULfY05GGiY7fOLLPMb5a5l/JeZR/daEqHCvkzI6U/0uYYnu+Fc6sEEFJ3gXDJw==
X-Received: by 2002:a05:6820:4c89:b0:5eb:821c:df23 with SMTP id 006d021491bc7-5ee57b96a9bmr12114816eaf.2.1731441730645;
        Tue, 12 Nov 2024 12:02:10 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ee494fb9a2sm2503376eaf.1.2024.11.12.12.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 12:02:09 -0800 (PST)
Message-ID: <4b48ae8e-4eba-4d86-af8b-2b749c53639f@baylibre.com>
Date: Tue, 12 Nov 2024 14:02:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] iio: adc: ad4851: add ad485x driver
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241111121203.3699-1-antoniu.miclaus@analog.com>
 <20241111121203.3699-9-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241111121203.3699-9-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 6:12 AM, Antoniu Miclaus wrote:
> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v6 (implemented most of the review comments in v5):
What is the plan for addressing the rest of the comments?

I don't want to keep making the same comments over and over again.

