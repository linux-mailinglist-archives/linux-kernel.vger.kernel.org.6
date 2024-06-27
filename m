Return-Path: <linux-kernel+bounces-231932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6A691A082
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367111C210AB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868A450291;
	Thu, 27 Jun 2024 07:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X65Mrvcn"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610AE6D1A8
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719473846; cv=none; b=j8mh5kDeVcKTFTIojNfOwQPWJZk0BQoiMulKD+HKlISVpl9xS2MkfkGgoUMMRufj0UwBQzAwRVQFmkfuEHq/Ze9Z1rW8KuFM9QYatWtoZtI/OVh4si0rkJ7qCubmM/CE713yRSvIAjio5+ILifVQXUGnNHDjgDxZWzhHfEhOGRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719473846; c=relaxed/simple;
	bh=hXbsKE9P+kMorDTh4PaugXdXE0+kw7EJ5lOrjKsj/I4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gh3rLqA1ebz0SxZmjnBMVPCBvQfqLjBBwr9zRKw6IGwHT/SZLI35bVZ3QLZYzxqHRYy6hCfdGzhgbFoe8z2EaWbAGWlA92AVNhXA6MwK7ZxA/u3avC02DVa7Tvezvw1uitxK87vwOOKzM+XIj9E314q2HALvFEue2djA62lxunM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X65Mrvcn; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-364c9ec17d1so4701757f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 00:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719473843; x=1720078643; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uSt7hWRFsJht1ykRpUwUhslZQwMHYadx10kyHUhna8M=;
        b=X65MrvcnUwHrZ/VdZNzA/7h+VpSnHnZY/4dkYEtIlBsVXXSuz/EEea0OGJHa/zvHhc
         Bde4ywbquV68SWfmAjWziQEBrQuWNnEhYfgCa0W6ClcdYhvsrO65jKL4jCg1+rKdpQGl
         KAJpkQ0jwJRSP+VtyZ6zMbIbS0RLfL4IJa2zrUL815eSDoC9fYM5PsWKsj5WplU+98u5
         +EE/zfhBHYs6EdZBAQVsQfX0a25qPAXk7zhxPncXPNkESgQa32LFBMwzCjvJ4ildVuQO
         /Zwqg4ZD9Mfk3dDPMpncA7c+P0cp9/MbNg9fqT1KzoYKTkiRtXk3Zhr1C5GTJIw/UBB5
         nL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719473843; x=1720078643;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSt7hWRFsJht1ykRpUwUhslZQwMHYadx10kyHUhna8M=;
        b=s+9Mfq14Vq5H4JQhtDxdOvwRyI6I7yRWV1Cgq1WL4JZv2qLVUi/EoYUQXLRRR4NOIe
         a0tVASnSAVarbW/eWRIszHuricOw8X4erQI8cYJrnlPxtxfwOOjuU/IsrAItUcx8K/LM
         o+aShNmZrk0meV6YL3j64tBZ4nzGNg6uApEpcKjjY8Lu3j96PH+QOUk6ruH3YQb4hY51
         4xCdXLcbcOdvqv8ErtQ5+9MOjTQSBekkTdJAsxLJieNDawIK6NclvNdfklnD2EdmH7Ll
         TPKNjcuvKs69vyjVd7kVvkp+iLg9sqMf5cls7pce2WSoZi3q0SQ8CfOZfj5WzuEqFumt
         dPIA==
X-Forwarded-Encrypted: i=1; AJvYcCXwRxHcA0SCT+6OUP/h28IrsM0WfiXLWF0E0vNz879rFnGP6wqY3jS4iFx/tARjaa0jb2ygAfpNX90PYOID4CIudqhxbEswBdvjcb4e
X-Gm-Message-State: AOJu0YxwYFHL0YFVDJ5KfPoREisz6VZ3BWSSNOw+FlygygvjAd0rcwo6
	dnTpwJtIW4Yf1YKxvElH+rpO9j4zHQ7u/6KqPHwvxZ6HC8QHzUN8HXhblNvchwc=
X-Google-Smtp-Source: AGHT+IFCDR3ek9WFRsnqL1Rf0E2mq3qOmsfg2MEHg+17BZ3Z6O2N+Wf9FHrf4pZsNrsp4V3hXqzOFw==
X-Received: by 2002:a05:6000:2ab:b0:366:ec2c:8647 with SMTP id ffacd0b85a97d-366ec2c86f1mr9630916f8f.46.1719473842640;
        Thu, 27 Jun 2024 00:37:22 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:fc79:19e9:c4ba:4eb2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3674357c0e7sm972505f8f.10.2024.06.27.00.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:37:22 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,  Stephen Boyd
 <sboyd@kernel.org>,  Neil Armstrong <neil.armstrong@linaro.org>,
  <linux-kernel@vger.kernel.org>,  <linux-amlogic@lists.infradead.org>,
  <linux-clk@vger.kernel.org>
Subject: Re: [RFC PATCH 0/9] reset: amlogic: move reset drivers out of CCF
In-Reply-To: <f7b13cc0-6155-4b0f-9f63-c35d73c3032f@salutedevices.com> (Jan
	Dakinevich's message of "Mon, 24 Jun 2024 16:48:08 +0300")
References: <20240516150842.705844-1-jbrunet@baylibre.com>
	<f7b13cc0-6155-4b0f-9f63-c35d73c3032f@salutedevices.com>
Date: Thu, 27 Jun 2024 09:37:21 +0200
Message-ID: <1jfrsyhm4u.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 24 Jun 2024 at 16:48, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:

> Jerome,
>
> Do you have any updates? I'm looking forward to these changes so I can
> continue my work on a1 audio clock controller driver.

You have been CCed on the whole series.
You can see for yourself that there is still discussion going on.

>
> On 5/16/24 18:08, Jerome Brunet wrote:
>> This RFC follows the discussion about having reset driver in the clock tree
>> [1]. Ideally those should reside in the reset part of tree.
>> 
>> Also the code of the amlogic reset driver is very similar between the 2 trees
>> and could use the same driver code.
>> 
>> This RFC moves the reset driver of audio clock controller of the g12 and
>> sm1 SoC family to the reset tree, using the auxiliary bus.
>> 
>> The infrastructure put in place is meant to be generic enough so we may
>> eventually also move the reset drivers in the meson8b and aoclk clock
>> controllers.
>> 
>> [1] https://lore.kernel.org/linux-clk/e3a85852b911fdf16dd9ae158f42b3ef.sboyd@kernel.org
>> 
>> Jerome Brunet (9):
>>   reset: amlogic: convert driver to regmap
>>   reset: amlogic: add driver parameters
>>   reset: amlogic: split the device and platform probe
>>   reset: amlogic: use reset number instead of register count
>>   reset: amlogic: add reset status support
>>   reset: amlogic: add toggle reset support
>>   reset: amlogic: add auxiliary reset driver support
>>   clk: meson: add auxiliary reset helper driver
>>   clk: amlogic: axg-audio: use the auxiliary reset driver
>> 
>>  drivers/clk/meson/Kconfig                     |   6 +
>>  drivers/clk/meson/Makefile                    |   1 +
>>  drivers/clk/meson/axg-audio.c                 | 108 +--------
>>  drivers/clk/meson/meson-clk-rst-aux.c         |  84 +++++++
>>  drivers/clk/meson/meson-clk-rst-aux.h         |  14 ++
>>  drivers/reset/Kconfig                         |   1 +
>>  drivers/reset/reset-meson.c                   | 210 ++++++++++++++----
>>  include/soc/amlogic/meson8b-auxiliary-reset.h |  17 ++
>>  8 files changed, 293 insertions(+), 148 deletions(-)
>>  create mode 100644 drivers/clk/meson/meson-clk-rst-aux.c
>>  create mode 100644 drivers/clk/meson/meson-clk-rst-aux.h
>>  create mode 100644 include/soc/amlogic/meson8b-auxiliary-reset.h
>> 

-- 
Jerome

