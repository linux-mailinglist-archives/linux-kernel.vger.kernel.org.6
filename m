Return-Path: <linux-kernel+bounces-408307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8EE9C7D38
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71993283DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A792071E9;
	Wed, 13 Nov 2024 20:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="u/iQyRSi"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D32515AAC1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731531540; cv=none; b=MWbxDurIK5uOy2O+A0+QGHMQSHuKiYO+RuE49WQTP1Z6+MHXesTj1dgFdCyM3c9lkiGXd+4nGlNECtQJ/3q3S/MbscHpgNMwL4I7FHglDB4CyOrCCf4bMjhKkhGsQzHVOneIBZRohBBFaon/4ZgUPZrxUetsCtKa58KriY4f274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731531540; c=relaxed/simple;
	bh=H3iT72KAJqpp+BDqqpjohjw+E1OXEnw4DduGcnR8JhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pglm9DQMZNkYmXJixGcmi1Rx7UgHkt8DownJ1Kvms9aY4d0dGHIoDSytJVJUIjwtFaGYtNiBfZ1E4CbQZ6pPKZfQ2NjqHmIjoIk2f3YrFkSUrhujIuoDXsYc5ZsiMe78KgRKaNHTx5aPfD8GEeL4UaKetSqli+wi/2PyXAB7yb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=u/iQyRSi; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-288661760d3so3363478fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731531537; x=1732136337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=83v/a7/p9Dx4wQKNzWHghWcROrTy7x/lk4BkJYfzHno=;
        b=u/iQyRSiHpk9QMnd1IKpTAyFFv6GkHSVyirmoS/AgdfGHXBKlLm1CTWAVOS8e5Eslz
         jMAzRMlEVk66duU0ThGwb2AjJY7/ogL9mowcSN+7gJgiUF0iwXvWpd+S7wWWEcPFm4Yu
         o+J0viJRZHDeSorAASZBNUxTFaOEYvGX7vXmedwjjwIh/H6VgMRDyDmugiui/AOL7PC4
         Yje+ifuBHIR7bhx7iTNQXo09rW6S3KkctMjJ/8ZQ6bnhS0umO2rJiu/nPQ46m5RaiDvH
         q5rhQtAbnhG9k6uD9dMnvMAD59c7ZlSUMoL/I887CHuL/ItN+VhZS9GouMGcTnuX1f0Q
         RWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731531537; x=1732136337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83v/a7/p9Dx4wQKNzWHghWcROrTy7x/lk4BkJYfzHno=;
        b=v5vyRHy2eBKgADxtjWZtlpbPBiG8aOPPjUALTij7FiyrMsSC0Z+Tn6clvo2G1JA9Nf
         Ywx75MGmbtAj3W7cs/+9LSM1DqyaYVAgP9L9mEcepRjThwzbRNIA10fZFoRWVU/7V78T
         sbqo3jpfI09BJJ8WIZwN1b8gz+DYIwtSWd6C2GNtQHS2n07EJA2PL6rWONaX+ST7EWOp
         bNqdVTF/43NqQ0JGdMAKumUs+IPCRXz9Wfew6dg7ScBg2Wzcu6oKXWKCO+NC15/V6hey
         PlQYeBy7St1nHkb6kKP3GEHbZsmpANIOEIy0cQ9uBmwZGnLDsIoxwr/YaOQm86jiJuCD
         2+mg==
X-Forwarded-Encrypted: i=1; AJvYcCVghXoBddO0AXxnemEsC8acauA9sH6yhVdq3wURqPvy9OPp55RCbNJPZbkpWkxA0bLW4v99h3y+Q8kPX2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV9tMAmU1B5x3fEJXGlqiw1LeBkoxub3U0z21lnhj7eXlPoaR5
	g6hoB2UB17Wxs5g6Bzm4gs+J+uzqSm8SUoQUOFyfUMT6zG6aGDJlXfl3b8sE3yk=
X-Google-Smtp-Source: AGHT+IH8Iu1gM3sGqu0PCCaBVFuc0424eQizn9/MUPjj53FJxCRIz3UZvZM/I4j/Wh380SZXsy1dTQ==
X-Received: by 2002:a05:6870:808c:b0:260:e713:ae8b with SMTP id 586e51a60fabf-29560129840mr15819915fac.20.1731531537135;
        Wed, 13 Nov 2024 12:58:57 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a600a2af3sm935949a34.67.2024.11.13.12.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 12:58:56 -0800 (PST)
Message-ID: <1390b66e-a9dc-42ee-a692-34a98146213f@baylibre.com>
Date: Wed, 13 Nov 2024 14:58:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] iio: adc: ad4695: add new regmap callbacks, timing
 improvements
To: Trevor Gamblin <tgamblin@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241113-tgamblin-ad4695_improvements-v2-0-b6bb7c758fc4@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241113-tgamblin-ad4695_improvements-v2-0-b6bb7c758fc4@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/24 2:52 PM, Trevor Gamblin wrote:
> The AD4695 driver currently operates all SPI reads/writes at the speed
> appropriate for register access, rather than the max rate for the bus.
> Data reads should ideally operate at the latter speed, but making this
> change universally makes it possible for data to be corrupted during use
> and for unexpected behavior to occur on driver subsequent driver
> binds/unbinds. To solve this, introduce custom regmap bus callbacks for
> the driver that explicitly set a lower speed only for these operations.
> 
> The first patch in this series is a fix introduced after discovering the
> corresponding issue during testing of the callbacks. This is a timing
> fix that ensures the AD4695 datasheet's timing specs are met, as before
> the busy signal would sometimes fail to toggle again following the end
> of the conversion sequence. Adding an extra delay in the form of a blank
> transfer before every CS deassert in ad4695_buffer_preenable() allows
> this requirement to be met. The patch also makes similar changes in
> ad4695_read_one_sample() (while also tidying that function somewhat) to
> make sure that single reads are still functional with the regmap change.
> 
> The second patch is an improvement that increases the robustness of the
> exit message in ad4695_exit_conversion_mode(), this time by adding a
> delay before the actual exit command. This helps avoid the possibility
> that the exit message will be read as data, causing corruption on some
> buffered reads.
> 
> For additional context, see:
> https://lore.kernel.org/linux-iio/20241028163907.00007e12@Huawei.com/
> 
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>
Tested-by: David Lechner <dlechner@baylibre.com>


