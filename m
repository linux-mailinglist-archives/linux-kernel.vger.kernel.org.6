Return-Path: <linux-kernel+bounces-569740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4F4A6A6E9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E159460ACF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654011DF27C;
	Thu, 20 Mar 2025 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bJynYEbo"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF02AE99
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742476403; cv=none; b=kVbp4iVgrF5KzReVaFxY/5v++pj5pPg5IPOGWNZaHzxBJK115T5VYtjiqcE5ak7A7eXA56WJJdy12+pM2HWRVAxeUkFaSMhDM3Ma/HyYse1/SwoEEcAvBP7pmW9azLdz/NvViVSBHOu9q8Ft7t3m/sRxUaUv1a5FDgTjJbM375Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742476403; c=relaxed/simple;
	bh=XZm5F3XNZhIwlOrdjUlExuCp7zU1bFU/Qi3fHM4Ybu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVYaeCdCqgwFeRxh3S42+U6kj3YfBjtFMkWI0DCLPz+/fK/uKnQfkTzPEh2UHm+WpKIsLq8zXaCa37IArh2Hz1JcMOcN8doic5auR9cLPjp6iK/7863S8ij2Nb+xMJPpQZ+JVTPmBYS/tpoQlUxlXEpEjFIVPBOheQrl7MO7CMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=bJynYEbo; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-391342fc1f6so551700f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1742476399; x=1743081199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v48XcGCXr1VN5yM2ip52zsfw94KneamZu91HpkgNdOA=;
        b=bJynYEborPNxyyxkfAcZegZLTX6DSa2gAahRl0TW9qp4p05vedyj7FA7GHPSQjHiyK
         JzBU7eEZlcgCco7hScEnFP8UpRO6K4/yCCNtIuBEMbIWODv4Cb6yDBViWaGsUvBrr2/w
         iv0pQloteQEUtiS8Ee0YDiGRCsrjZhepVMN8aR6cuh3PXI+BcKaUqq3pQztvT1esqJNv
         T7qVkmn4cm2UbzigvDULTp5TYpTr8L7pQol5ZPVAjIoneuRU28XXObra+QK1EtK0akmz
         Kx+NSHb0Uz/VxJpe9QsmYRaHMLDYSLVOVHlVNXGPspLI2cL0oXrYL8aio10M2ATwRx31
         +mDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742476399; x=1743081199;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v48XcGCXr1VN5yM2ip52zsfw94KneamZu91HpkgNdOA=;
        b=Aj+/F0+dSGC4m7kcgffV6/jfF56VYRSj6q92pV2y7BktbHAxQIPqbsoBzsz7eIjWFH
         NixyCvkATT2L8qoD/6aBemR5YABnUo34RiBsz+UPAwxT4VnEoc5DJFXhrLbOTzu5DMOR
         Nlu5DaES0DfqljPz0AfqS77WmV4pGEb1Icb9aGsCFUcWLOSbz0o1OG7dDSbGdbY62Dqg
         aW0sbQVJJXu7/KbP2XPeEwNOcm1lvi+E6HT1Z53IYlXxJUeVmZuMtBISYl8kAeijdFWk
         X4QF06yPHc540st5N1fz6hZQoRXUum0x4L92Eu8aT5jOq61cqq9b/YeepB09Jqw59Ra0
         Ig8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgOBQDFjz+wl81QMEOqW+Ey3ZVfrxK/av/yVKjRV6fF6fQJldNF/K6qdXxAVGlSB8yBPyyrYO+bcUfRk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOrXFaYsP0BMA3O73IJ5PUSHD/XlxxazzLIN42z0M/3rUseWUd
	HAvCIsyhPvhwaYodVkVR93ZdNYUddV0fC3or7KhvUwMBckMtSMDyWRt4yR4wa9o=
X-Gm-Gg: ASbGncuSBYYslMRdGtbwDjjnh3C0q8XNUlxaGziDwdZYL7HxxmJvjsA93l7FsY8m1Iv
	7/4qIcJQ7iewnakjtxLPXzYZpo5lMxpJcRgRPiXtUncaLdKgXY8v/GKIYFIteyEyMUCPr39w1Bm
	UQtw7SnLFWtQtJwtE6KUAmuPwA3xTCQ8qq5slmkEIL3raRt7CnCbziZq8Dg/5evrpaxJsd70zTF
	sb8WQCaBjnYqEsrr9g/79+aBTlj08o+MbuUPC9zJeYXitPJQRBPGP7uFvoXmOoWzl5kcRC96sA1
	DskVxY4kOkd3635URQ5K4mhl+sV0oOqU8X/b360/eW0j+wpPPYMd2w==
X-Google-Smtp-Source: AGHT+IEl5veUunthB+o/ItpiVJl8NBc233c3fSE4ra0y5VSm79bnxcvguGhe+n8pCn3Yf22GVAAyvw==
X-Received: by 2002:a5d:59ae:0:b0:398:9e96:e798 with SMTP id ffacd0b85a97d-399795a8cb5mr4010723f8f.13.1742476398470;
        Thu, 20 Mar 2025 06:13:18 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3978ef9a23bsm19575491f8f.15.2025.03.20.06.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 06:13:17 -0700 (PDT)
Message-ID: <d55ed22b-7a13-4037-9a11-1a65040f8a7c@tuxon.dev>
Date: Thu, 20 Mar 2025 15:13:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/8] iio: adc: rzg2l_adc: Use adc-helpers
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Chen-Yu Tsai <wens@csie.org>, David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <cover.1742457420.git.mazziesaccount@gmail.com>
 <9a3a11561dbd3d5023da2da05cf2190793738242.1742457420.git.mazziesaccount@gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <9a3a11561dbd3d5023da2da05cf2190793738242.1742457420.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20.03.2025 10:21, Matti Vaittinen wrote:
> The new devm_iio_adc_device_alloc_chaninfo_se() -helper is intended to
> help drivers avoid open-coding the for_each_node -loop for getting the
> channel IDs. The helper provides standard way to detect the ADC channel
> nodes (by the node name), and a standard way to convert the "reg"
> -properties to channel identification numbers, used in the struct
> iio_chan_spec. Furthermore, the helper can optionally check the found
> channel IDs are smaller than given maximum. This is useful for callers
> which later use the IDs for example for indexing a channel data array.
> 
> The original driver treated all found child nodes as channel nodes. The
> new helper requires channel nodes to be named channel[@N]. This should
> help avoid problems with devices which may contain also other but ADC
> child nodes. Quick grep from arch/* with the rzg2l_adc's compatible
> string didn't reveal any in-tree .dts with channel nodes named
> otherwise. Also, same grep shows all the .dts seem to have channel IDs
> between 0..num of channels.
> 
> Use the new helper.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

