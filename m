Return-Path: <linux-kernel+bounces-279218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4A994BAA1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8E11C21C6F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D8318A6AE;
	Thu,  8 Aug 2024 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F1VcoxOd"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06FA146A7B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112122; cv=none; b=hudINvMnFG2gPZ0Z4hwOA31vtaceZLPUzOwtUYQp+B5ZGp1PX8iWDjnucltbKbI8fap1jLdBuPqgpIdH97pkocQbBUNluKMrDWdwjHBvYIcXObTOOjmssFFfmigkqzctUQ47Wc2B1Be4uS7PdDXtiDeY7htaH8ezyAHoRIShSm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112122; c=relaxed/simple;
	bh=h9yni8FP8oD8omveTs3RhzoPgoL+8M3n2GqB/6DS6rY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k2rylUMo1uG2lacMghproPXdXKkidlQ3m6G+OBfW427+7ZArF+TXrH97UtIZEA3PSNH65FxglrAL21wsBwQ4CVOwra07OVOdSOCb29qUxI19i90aoSLB4IIpi7/WB3e36fmuQV8EOxRMuVb2B/gsvNB2HtOeF3VJX1tpW+yKhJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=F1VcoxOd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso5575245e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 03:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723112118; x=1723716918; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uHKU+qWDGf01eQdWksVZpo4JSdzafD6OrXnwsvy06EY=;
        b=F1VcoxOdaFycAyc9yFVYr/rrjAcDH2KrWkmDgqjQojsxdoZMElbLrsOBR4dZQqc1xb
         E73qnw/yvKBj1GF2Eb+gIr/s2+X2WGbyK2M07owdrZ/sZwK04LoqQwb672b9X6HyGh+c
         XlljnWcgwcHdG3ShxxR43U+jgQsQqXal7KQS05JkItYPwO5s8g3JmrCEpFYlmkoBkqSh
         MlwcHn1nBSwu11INjD4QJ26bgMfZVW8h7PviiBy/GVBy13Owocz/lH2tPF9stEZbHRI8
         y7LkHBVKBcCqZCxydYdbk4IAV67rPEyBFEGpBYCUVXorUzGxmvBQmuncUMEhTRIUbZim
         8KuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723112118; x=1723716918;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHKU+qWDGf01eQdWksVZpo4JSdzafD6OrXnwsvy06EY=;
        b=OoSMX/IOL5eYz1ppR+fk0jHm7V0mtOy1ItaD6xHc8tOuakhbEb3VHPaTZ5SB5xeraS
         1hhlNgAcyKN9UaJBfc6C/yMmK/QBpAehd6muYIqys2xj9XS7vVSYt5s/pAuYMaz6Ln14
         bvyN+SX8KpScDjyE2k82AhxvYMlf1sAjwibzFQ/npwbkh/SWN0N63xiaXKwnqZ+jVXKh
         xfeo+UjctTSkm5L89Nzr4zovJzGThDe5FLdVgVnmKoQ3mrkhdOz9tAtBshVvpPXNyMqz
         H4GvFrAxvM2hcZZ09TRsDaCMFl8XaoFB6xnHKyjA2Mpl3NvfGzH3yD/mVDASn8Lp8Zb8
         FB5A==
X-Forwarded-Encrypted: i=1; AJvYcCWPY20n0hWao6S/N2RuIQth8ih+Ap4PxxpVSZUAcT3iIOJOCoDYzeAVNRw31dsFn6c4HBeav0wZAKbcaInPdC9mHM1Pivk02JkwF1pH
X-Gm-Message-State: AOJu0YwHTOANy3BYbe4GOZX8aEecxCe8z+ov6KoSxHt8JZpPnrvPLxwT
	fPjBKRWTAREA3+Usyz389wwwX9Cy+ByTqCMHrC96wY/7qO+mBBDPcwD00SDIiSQ=
X-Google-Smtp-Source: AGHT+IH20/85w4Ip7Pzi8RePzbDVoqHc01uOa2goRjWmjwxMDR86wk62jwXwrKpXG/AxjdYpn/0xog==
X-Received: by 2002:a05:600c:1d05:b0:426:6e9a:7a1c with SMTP id 5b1f17b1804b1-4290af0fc7fmr9739075e9.25.1723112118023;
        Thu, 08 Aug 2024 03:15:18 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:ae7:4e79:8821:15db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c74a96bsm15015415e9.24.2024.08.08.03.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 03:15:17 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Jan Dakinevich <jan.dakinevich@salutedevices.com>,  Philipp Zabel
 <p.zabel@pengutronix.de>,  Neil Armstrong <neil.armstrong@linaro.org>,
  linux-kernel@vger.kernel.org,  linux-amlogic@lists.infradead.org,
  linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/8] reset: amlogic: convert driver to regmap
In-Reply-To: <11e8dd92e07674133d8a291cc016c314.sboyd@kernel.org> (Stephen
	Boyd's message of "Thu, 18 Jul 2024 12:29:13 -0700")
References: <20240710162526.2341399-1-jbrunet@baylibre.com>
	<20240710162526.2341399-2-jbrunet@baylibre.com>
	<b12ac6b2-cb46-4410-9846-86ed4c3aea1f@salutedevices.com>
	<1jv813makr.fsf@starbuckisacylon.baylibre.com>
	<f5bc9590-f37e-491e-9978-c1eab8914c30@salutedevices.com>
	<11e8dd92e07674133d8a291cc016c314.sboyd@kernel.org>
Date: Thu, 08 Aug 2024 12:15:16 +0200
Message-ID: <1jle17xqvf.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu 18 Jul 2024 at 12:29, Stephen Boyd <sboyd@kernel.org> wrote:

>> 
>> Full analysis is following:
>> - using regmap_update_bits() instead of writel() is incorrect because
>> this changes the behavior of the driver
>> - regmap_update_bits() should not be used here because default value of
>> regs isn't taken into account and (_apparently_, the doc is terse) these
>> regs could be updated by hw itself.
>
> Maybe use regmap_write_bits() instead.

Actually regmap_write_bits() performs an update behind the scene.
You'd still get the undefined read value making a mess AFAICT.

I'll stick to the usual regmap_write().

-- 
Jerome

