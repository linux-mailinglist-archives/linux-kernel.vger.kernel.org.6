Return-Path: <linux-kernel+bounces-425677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EF69DE8F6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0C0281B57
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8323413B2BB;
	Fri, 29 Nov 2024 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AVZPrnmC"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4BD1F94A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732892022; cv=none; b=bovjo/9kInczYxCn3X8+OxVISNbUYEpLTTd1CWSBPsWP3aULavR2ETEaQ2aRUxyrxZKq0qruq6YQOgcIh7R0s24vrDCMurcXuJM3pIXYdWLT35OQxkZyMdi/gR08d24iv090XTEssqtraAp9y2dXCcf1XTJTgu8lOFPeCbzs2gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732892022; c=relaxed/simple;
	bh=qQRKHxdVhtRTuBlPJigpNhwOkk0DSpbeCMf+b8d6ko8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UozWl528x5wAtgwf8GIQBlDfrqn8NpuRs7+STFoAQAhz3DOCbwZGQd1YT4sFxaxh8QoDfONsBNQEeilh6fXaDNVAPQELxwdYDaQsO7jEvIAHryo7t8PhAgvTSQzdcEdSvOXvCrMg/DWaBLFIstPlgVUeLHFSqDelvEY+U6qyvpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AVZPrnmC; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3ea55c356caso1017983b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 06:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732892020; x=1733496820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZKaZ7N0R4VUPd9DsYfN09abKTlMIIX2S7i/GCAnFpd0=;
        b=AVZPrnmCrr6x8OfH/H2bcuDClGQC9KSvstIOm4aatNmxgM+74OYuj7OuSNXlIv9snT
         AA+a3ABHIroTV2gYhVTqwVl9RCECvr5090RFij/sjaDEDL+sKXB3PTvuvWUAgL23eEq5
         2ocOYIu0sw9AC+gS+vtsQ0BGpBMShjfzNc95wAEt4GlZiETFNA4x4SSxrj9s7rto2uJK
         IOD7oUQU407yxW5l4QZeC2Q3EMdbnsQuuh8onbMDqwAP7D1F21tq/gyxBCR8MA+EcEPH
         nbbp5vUWTMGciZPg4XhSTOFY+bWZ/Fl5KrgRc76yuuc/TET/cUNIBj6TxNdd5CZIHM9K
         VY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732892020; x=1733496820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKaZ7N0R4VUPd9DsYfN09abKTlMIIX2S7i/GCAnFpd0=;
        b=noZqKcgfY7Qzo9EVz6Bt3IJw67hjeXrKKVRGSe/W2vMlqx5wyp6GFgxV5/zjNQDKKz
         E3E+XbCkDTcLDaDiTOyueCqsaoztLD5rbkBEuX61gNoybTdksIzMVuMw8KZOsvubDPP/
         O6BadvybQZ1a0WUCJRNW4mASMu3cBCL1nEcJ+F6K6aHwVKXt9bqXqwAC7PXhnrCFpRKe
         zJ/VCB0n7z2jy2AEHAMOGYHkgQ7l7fi4BynPzfoUpDMPNX6mQkl1FDL9MGRm6z3HPMZf
         3cOfmqNV6ZqcDKnlEKgtCCYirS6dslt7jVuElnXOq2ycYkeo0gGxuC/PcLuIeGggj+F5
         mSZg==
X-Forwarded-Encrypted: i=1; AJvYcCVlyDn7rVorgU4YFGSG80gPkSeAlgd7hxkUJ3kATv5i1t3HWc4nVpBa+q+SvuA9ga+hOEmjp6ULpIvMskk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGS71RC56hyk/wyNUnWPolpHFsgy/wyCTAKzmv9i1MRD2M0DEG
	SFg6PDSP4d6sIz/7B9PXjI/WtjwGbpEU6CVRS5zd8NwmKyQwzV1kFgOCEDPJTMk0uXs8MOEoNTL
	b
X-Gm-Gg: ASbGncsNTbtkXH3dCBlKqpnETKZ86ladW+pbSN32VMKH2shho/otT6lbPo0clr5qtm5
	c7gcmLROHS5OusA1AOUnn6YKFymSZXw2Rh2MgVxKrUvKE3nTsUAS2LYMSc4TAAIaeCU+q6sJ3n4
	MebMmmcQEPZsvImE/d+USMM2UmCjPtFz2tnlPM2VWOkga5v5npsU2ODKB7L2OuIUl3i5FCeuq6L
	HXawgWPcRHIAEZDezs6CrYjTCK6qYau4KNiI832S8H9KiGmSp8/VFMTblHokYUw9iP3iXZUrLz7
	StEcvPUOSEE=
X-Google-Smtp-Source: AGHT+IG26hEFasdm9mwT5xwvmPQUNmvasTkJOtP5JxOl97dPKY6Rs57GtDzI43nVLseP6IREK3j3Gg==
X-Received: by 2002:a05:6808:2387:b0:3ea:4b5c:60a5 with SMTP id 5614622812f47-3ea6dc223ecmr7774692b6e.23.1732892020455;
        Fri, 29 Nov 2024 06:53:40 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ea86036a2dsm744423b6e.9.2024.11.29.06.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 06:53:39 -0800 (PST)
Message-ID: <4d26fff0-d5db-40b7-bd5f-14cebc96abc3@baylibre.com>
Date: Fri, 29 Nov 2024 08:53:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iio: adc: ad7173: remove special handling for irq
 number
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Michael Walle <michael@walle.cc>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Guillaume Ranquet <granquet@baylibre.com>
References: <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-0-b6d7022b7466@baylibre.com>
 <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-2-b6d7022b7466@baylibre.com>
 <CAHp75Vc9BGu5FnUTcRkNuNSjtS5+tqXwOm-BND72v2_C2Fm8FQ@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAHp75Vc9BGu5FnUTcRkNuNSjtS5+tqXwOm-BND72v2_C2Fm8FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/28/24 12:47 AM, Andy Shevchenko wrote:
> On Wed, Nov 27, 2024 at 10:02 PM David Lechner <dlechner@baylibre.com> wrote:
>>
>> Remove the int irq_line field in struct ad_sigma_delta_info and all code
>> that referenced it.
>>
>> This struct is intended to be used as static const data. Currently, the
>> only user that doesn't uses the static const struct directly, namely the
>> ad7173 driver is making a copy of this struct to be able to modify the
>> irq_line field. However, this field is written and never used due to the
>> fact that ad_sd_init() which reads the field is called before
>> ad7173_fw_parse_device_config() which writes it.
>>
>> The runtime behavior does not change since ad_sd_init() was already
>> (unintentionally) being called with irq_line = 0.  But, even though
>> this could be considered a bug, the behavior was still correct. The SPI
>> subsystem always uses the first interrupt in the interrupts array from
>> the devicetree and the devicetree bindings for this family of chips
>> specify that the RDY interrupt is always the first interrupt. Therefore,
>> we don't actually need the special call to fwnode_irq_get_byname(), so
>> it is removed in this patch instead of moving it to the correct place.
> 
> ...
> 
>>  struct ad7173_state {
>>         struct ad_sigma_delta sd;
>> -       struct ad_sigma_delta_info sigma_delta_info;
>> +       struct ad_sigma_delta_chip_info sigma_delta_info;
>>         const struct ad7173_device_info *info;
>>         struct ad7173_channel *channels;
>>         struct regulator_bulk_data regulators[3];
> 
> Has this patch been compile-tested? Because I don't understand this
> change and how it's going to be compiled.
> 

I did compile test each commit, but it looks like I might have
squashed a fix into the wrong patch. :-(

