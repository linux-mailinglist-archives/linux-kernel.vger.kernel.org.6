Return-Path: <linux-kernel+bounces-207996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA589901EFF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6C91C22005
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6575778C9D;
	Mon, 10 Jun 2024 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F5cUaPdD"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C8E78C65
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014260; cv=none; b=N3w6eI1fAns15wUVhDg+iRmgsP5EcARW2zLBLqM4XBqbj3QQahMffw5rYege2A9Ds2nguzZxR5Yxnpd9rdrECYbCOcwDZVFYMixZFmXBUG4iE8qJ2nssUQMsTFslMwz0ovdTFocRYSBMu7RHpdPyv9c8WD2ZiRXK9ttb6fqHco8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014260; c=relaxed/simple;
	bh=fJRy5/Wt6DoVxNkQSDMWytau/StkznaoGvSk7X31Wnc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SrTln6zaDCS0nJJHWqyIb0+M8F5fMFk2EfCQ2fi/a0Jqfke1/l+WD2MEPdQfERnMA88mivfbVdMLvoRjpn7OwQeYXHgb8z+uMr3Jlr8fV+v6/SlS+vJNFIhHG0o9HabwNzoYTlLIqTWeGhZpPQvvrTIUPp+6e97RWik1ARS/sH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=F5cUaPdD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42136faf3aeso25125175e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 03:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718014257; x=1718619057; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=q0TNoSBUeFW5avGknbPcWPlD4Jgcp9UNaKcJpQf4Aho=;
        b=F5cUaPdDuNCEqXHH0F/nyFh9ohoA33LL0xn+kdby0xnUD0LViRKMVJIA7G0JkmvtBq
         GXI/ok6YKPcWzlW063n4KAAMLh4JBmXServJIfUDtBE9iOCoLBmBIvuoUIdpYefpwPko
         lvqSNYmqhDiwAENakxtIgWRXSxxA5FjqTlE1OUbZ7IWjLe7PzNrP2zqcDjRvtx24qZt4
         s73FlcVzEd5jKbMNXFX5znSjoz++YECc+C3CHSdAm/g1QmM3rsFwyMPVtIJZY9J+PlHK
         bZL6A6hH5BU719LQwKppN70HkhNBVC3J4K8taWja4290mv/xEkhjZH0m2k0g5x0l8+bS
         EGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718014257; x=1718619057;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0TNoSBUeFW5avGknbPcWPlD4Jgcp9UNaKcJpQf4Aho=;
        b=ZE3YG/1Phumyh1HXqfvLuaMpUSlF7yO8Aj5uJt6L9EUoqGeRfwov8oteh131EAOFV4
         O0qJIMpcAvN3uD7FtNH29UTCYldqONqMDfju/GsEAfMsgkLNsg0cZZREcTNL183DXjgx
         pCr+MUVL0xgTd+ZCU2zTE6M6ntQ0BURyKkl+HcIi3e98kdu81nXp6Zn5yBv7sffx6xq2
         PQX0dq/LKm+lfB9AH2WT9DvazWwrSwpnbxatOEUzCbAwS6ih0rtTdVOzxm2ujJFOb1cZ
         XVMURVVdjvgHMOm2bHZXR+ky7gHjZeT+jRUbO8+KiLOBs1FepF6HPGW+1pBffwoBCrq1
         iN6A==
X-Forwarded-Encrypted: i=1; AJvYcCUPmtKDeVQABhVsSr5lLZxJRTOmx9k0T0+c3b7xkrwwxEENPjwVomX5koxWsR2GmpokN2D40UPIWj/bh+BkfBHpqoWz1rCAdx0dyPBc
X-Gm-Message-State: AOJu0YzYLHvNGCk/UzcsHHcm1rQIiQDu3zH9TAIeIHJvFWh8b3q7SEAM
	rE5x0Uxzm5BKfldN6x2ILXdWdLUxE9mth6yKX+xLTbv9EH9W6shNH15jfM2HQQI=
X-Google-Smtp-Source: AGHT+IEFqoldHAoJVVZTLvQOuYPmYg/HOq/+LtIbLhEkV/XKorR5ubj6rEmGhJ0i5CLz0niduiRRvw==
X-Received: by 2002:adf:fc8b:0:b0:347:3037:188d with SMTP id ffacd0b85a97d-35efed5351fmr7533025f8f.34.1718014256882;
        Mon, 10 Jun 2024 03:10:56 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:afd3:66ee:5486:4249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1aa8d4f3sm5283383f8f.99.2024.06.10.03.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:10:56 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Philipp Zabel
 <p.zabel@pengutronix.de>,  Jan Dakinevich
 <jan.dakinevich@salutedevices.com>,  linux-kernel@vger.kernel.org,
  linux-amlogic@lists.infradead.org,  linux-clk@vger.kernel.org
Subject: Re: [RFC PATCH 8/9] clk: meson: add auxiliary reset helper driver
In-Reply-To: <68518f93af68cbc0153c8bd765dc885f.sboyd@kernel.org> (Stephen
	Boyd's message of "Wed, 29 May 2024 18:01:47 -0700")
References: <20240516150842.705844-1-jbrunet@baylibre.com>
	<20240516150842.705844-9-jbrunet@baylibre.com>
	<68518f93af68cbc0153c8bd765dc885f.sboyd@kernel.org>
Date: Mon, 10 Jun 2024 12:10:55 +0200
Message-ID: <1jikyhp0pc.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed 29 May 2024 at 18:01, Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Jerome Brunet (2024-05-16 08:08:38)
>> Add an helper module to register auxiliary reset drivers from
>> Amlogic clock controller.
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/clk/meson/Kconfig             |  5 ++
>>  drivers/clk/meson/Makefile            |  1 +
>>  drivers/clk/meson/meson-clk-rst-aux.c | 84 +++++++++++++++++++++++++++
>>  drivers/clk/meson/meson-clk-rst-aux.h | 14 +++++
>>  4 files changed, 104 insertions(+)
>>  create mode 100644 drivers/clk/meson/meson-clk-rst-aux.c
>>  create mode 100644 drivers/clk/meson/meson-clk-rst-aux.h
>> 
>> diff --git a/drivers/clk/meson/meson-clk-rst-aux.h b/drivers/clk/meson/meson-clk-rst-aux.h
>> new file mode 100644
>> index 000000000000..386a55a36cd9
>> --- /dev/null
>> +++ b/drivers/clk/meson/meson-clk-rst-aux.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2024 BayLibre, SAS.
>> + * Author: Jerome Brunet <jbrunet@baylibre.com>
>> + */
>> +
>> +#ifndef __MESON_CLK_RST_AUX_H
>> +#define __MESON_CLK_RST_AUX_H
>> +
>> +int devm_meson_clk_rst_aux_register(struct device *dev,
>> +                                   struct regmap *map,
>> +                                   const char *adev_name);
>
> I'd prefer we move the device creation and registration logic to
> drivers/reset as well. See commit 098c290a490d ("clock, reset:
> microchip: move all mpfs reset code to the reset subsystem") for some
> inspiration.

Ok but if it lives in reset I don't really get the purpose served by the
auxiliary devices in that case. Why not export a function that directly
calls reset_controller_register() in that case ? 

I thought the point was to properly decouple both sides.

I don't have strong opinion about it, TBH. It is just how it made sense
to me. If you are sure about this, I don't mind changing

>
> One thing I haven't really thought about too much is if they're two
> different modules. One for clk and one for reset. If the device
> registration API is a symbol the clk module depends on then maybe that
> is better because it means both modules are loaded, avoiding a
> round-trip through modprobe. It also makes sure that the drivers are
> either both builtin or both modular.

I have checked with the current implementation, if the reset driver is
missing, the clock part does not fail. Registering the aux device
succeeds in clock but the device never comes up (duh). So it does
not crash, the consumers of the aux reset device will just defer.

Said differently, the '#if IS_ENABLED(CONFIG_RESET_CONTROLLER)' in
clk-mpfs.c was not necessary ... it was removed in the changed you
linked anyway.

(Sorry Stephen, you got it twice ... missed the Reply-all the first time
around)

-- 
Jerome

