Return-Path: <linux-kernel+bounces-256624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23377935134
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 19:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90CB1B22939
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26CC145359;
	Thu, 18 Jul 2024 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Enq21rKn"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D01E143892
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721323150; cv=none; b=rM0qiy97GTErx9UT7Pj1q5+/cdiOxc+KjL/sr/EPYCUzuGfvrWKEcbRNWmyt/q8uHgMflww9GN0tBQqzc+fPxn93l9o1zrLI2yEn9Ia6mhhVEMZg2AJYEaoNxuUgQRoQhiOpRKdp7042FD3QbcXdH2qH4cEXGT/vJm6H4mWNyQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721323150; c=relaxed/simple;
	bh=BzZMlddkgrR7Vo48D78akGTXFNhJuilL61KLAQ3hDog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ktqswNrZkT98xJXgUwLmXIo+NFfDJNpokwt4yBUFF8JLSxnymcml0VIgNL5U/gOGkaDBl7aeHahh1CNa7G/3pKW4eSUAXsYR4wry7gEGCeCiIbxo9DJjWPtxGmHiFKmzEfNRKw6kGlBr2i0fsJEntWzWKJts0hrbVhl3LWH+RhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Enq21rKn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4279c924ca7so4771735e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721323146; x=1721927946; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7uR+g2yKHQtKWUoZd9oU/bblecyRnWgI3idxDPFwBF0=;
        b=Enq21rKnM+iRVH0jYK1FAus6D0Y//hS0KZYlPQef9utdVcxYFPXYlM+NI2xjQYOG5B
         04GdY9bFebOZMgLojMEYlAbBVR0ud93x1Y8xZ/Vw8uS3u5gzmagrxqPlns4xpxxxErpF
         xa+0muuV8pLU+ZVA/NanyWV9Ann9gzZT005fkBmsARlvJApCyz9WcwkrNDz+e3+Mv1WA
         OfvQggIhAXD0SQ6TlbC8+h2TYcGR7lvqfHre41uUJvnLMvwXWDsdqssrgio7UI2t4EKX
         fYDDvzateraB5OEwll6LVRGezv/4yTwuZ0RZeh0HRUFBYZ+QUGgqYAWJLRcuJY0kydgy
         c9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721323146; x=1721927946;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7uR+g2yKHQtKWUoZd9oU/bblecyRnWgI3idxDPFwBF0=;
        b=VuUGhL6qubxapIDNwJu9S9jHchDnMInxFEsMig6ZEtmoNrC9AlO1qdVMosroC4IcmF
         CSfWpOgi/QtlGAKb1+PL9h0hM7nvPtZSBxvIOnrPizdEcmseXCZXg355QtNz5jgpTiHT
         XAB7DxmUy44LhcDeWLNr8cPrhfJbhHz1PTkhhz49KO/dEpOe0VEto+ZQqnwLXOoPMJv6
         bAL+X5z0tgWopILudBvbkBoDVl7JToGdZMJgfi2ke8p3Okj0rLJ099uBBzRoLD4WcSG+
         dHGqt3tW4az8eTDWvJ6aLmpILnsGvfcbv0A4YvtQ9qHUVM9mrZ45Ty4fIHGrKX6G28wl
         qwWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVspW8ms9cLokEiewc76dcEMwriudWOByg5Rv0bbQPGucRgvqfzvrDipx+hyxuloCjigNy+lm4MPRwMLAdgFB6tSXND12QWzu5rB0Mg
X-Gm-Message-State: AOJu0YwHzvyXblUwdzyis+uQ5kikTLEInIOBfGrYxb5Uy7wuNkU/0YCi
	NLHM/vDefTtguX0VCkQu/Cozqwzp7QwyLutmd9XwEu1jIWoSHNqZOlNMMDyfPwc=
X-Google-Smtp-Source: AGHT+IH5+9L9pwlWaj+Zw1XCZJjBadwkEba4ZohfVAwFN+aRmCq+OzHkIaw26350GTJ565KkhbpaZA==
X-Received: by 2002:a05:600c:3b0f:b0:426:5ef5:bcb1 with SMTP id 5b1f17b1804b1-427c6ba30b4mr30710845e9.6.1721323145735;
        Thu, 18 Jul 2024 10:19:05 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:bbf5:bf25:4f46:2ec8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a5c34bsm22577015e9.16.2024.07.18.10.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 10:19:05 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,  Stephen Boyd
 <sboyd@kernel.org>,  Jan Dakinevich <jan.dakinevich@salutedevices.com>,
  linux-kernel@vger.kernel.org,  linux-amlogic@lists.infradead.org,
  linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 1/9] reset: amlogic: convert driver to regmap
In-Reply-To: <2f094b21-aa55-4a81-b9af-ff06c34c5a67@linaro.org> (Neil
	Armstrong's message of "Thu, 18 Jul 2024 14:45:35 +0200")
References: <20240718095755.3511992-1-jbrunet@baylibre.com>
	<20240718095755.3511992-2-jbrunet@baylibre.com>
	<2f094b21-aa55-4a81-b9af-ff06c34c5a67@linaro.org>
Date: Thu, 18 Jul 2024 19:19:04 +0200
Message-ID: <1jr0bqmxdj.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu 18 Jul 2024 at 14:45, Neil Armstrong <neil.armstrong@linaro.org> wrote:

>> +
>>   static int meson_reset_reset(struct reset_controller_dev *rcdev,
>> -			      unsigned long id)
>> +			     unsigned long id)
>>   {
>>   	struct meson_reset *data =
>>   		container_of(rcdev, struct meson_reset, rcdev);
>> -	unsigned int bank = id / BITS_PER_REG;
>> -	unsigned int offset = id % BITS_PER_REG;
>> -	void __iomem *reg_addr = data->reg_base + (bank << 2);
>> +	unsigned int offset, bit;
>>   -	writel(BIT(offset), reg_addr);
>> +	meson_reset_offset_and_bit(data, id, &offset, &bit);
>>   -	return 0;
>> +	return regmap_update_bits(data->map, offset,
>> +				  BIT(bit), BIT(bit));
>
> Here, you're converting a:
> writel(BIT())
> to a:
> reg = readl()
> reg |= BIT()
> writel(reg)
>
> so indeed you should use regmap_write(data->map, offset, BIT(bit))
>

Ok the trouble is this particular register which is write only, not
some writel vs regmap problem. The read value is probably undefined.
I should not have changed which the migration anyway.

Thanks for pointing it out, I'll fix that in v3

-- 
Jerome

