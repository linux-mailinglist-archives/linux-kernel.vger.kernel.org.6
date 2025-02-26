Return-Path: <linux-kernel+bounces-532724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5666BA4516B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0EB119C0753
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1816BB5B;
	Wed, 26 Feb 2025 00:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ajQVyawQ"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9345933F7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740529608; cv=none; b=SKp1SjeDOrAqsORP0g7sLyCXZa4AYzqJFPbxfXIVWXJRSHM9gtVNI21HohCTsta4O/My7xUN33fBbaZ2yW94X2me/5XgzZBRHbzt8iFfLESEjlI8Akp7ik3mY09imuNGaXhKqTY1G/Uzz4twA4a/HFd/UsZOWHojogzV29NS2bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740529608; c=relaxed/simple;
	bh=U8EoAqRFMwNN0vkZxxuJ747c1TkFoXybVwKQXTpYFNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mv/zZiPcfhLC+fnuRhwCIYI4t9LmMYexe9dSfmI7ycCsSGPH7D2RQ3jwGw051lxxs5vdborTJLN29651yO5laD8waGUWUIiFvV7vMzNaxQrzzL7cYPD81VkH9yAatKCMNtk3atafVv1+vwwEN/4vYysGckXwbPDCqh6wSJkgKYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ajQVyawQ; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f546cbf71cso310325b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740529604; x=1741134404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TtkdEm0DhE9kMHrzm4v1hwSlsrJYtgXqAtJA7aT6OdM=;
        b=ajQVyawQVJadBMDPUptySchMkqqVEJx1NM6ucacylDf+Nd6HU7JEw+KpIn8LQoCL1n
         Q9TC7gKbBXw/M3iiMMvV3g40ZQUkZlOMGgVcZTC/N+WVl/XK+yE1oVZyWVfixvNEUobc
         6csOi93pB71E1HL3ULzFP8prHxcNAa1BKh2ZBbG466jRvyBvC5i7Fe0LkjefqVFUfSp5
         d5W5E1u0Z72z1byg9+8GU5ukPeS2Exz2uVc3hu4fz5hMhi8auubwcGBYFnDRQl0Mh4cJ
         e/mSCeT+PCQjOk2P3vQFF0aw2jptNtKYfdyVVs/xPE5ScKmkiZXQK7qdeafAWiJ1MEOD
         k/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740529604; x=1741134404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TtkdEm0DhE9kMHrzm4v1hwSlsrJYtgXqAtJA7aT6OdM=;
        b=CVRp9dEad2P8t6gercVGbKN4HQZkpV1AsgFV2Pisg92lqNVfnxmhxHuQEGQiA5Om1/
         T765Jc72FDdKfol7sAbGjT0ZyfTO1QrtPD8PCswuKYgKCgunpqnGGsrLD7x7qUnBoX5y
         Q+0FNJcrmH8Hi0i/RTy0Ii/MTujgLcN9ooTrwyruvUUTpjui/JlmfIRUXpUYexIHp0Jf
         dHiGOrb+Hp/O8ahgj+0SyzpQ5UmCkJiAh3TMCF+Y97lvfFyijEnLAsT5nWNfmMdM3/0N
         6xYeRoxL8I6wgBmmQVTWKAiG2759L+dbtk0o/npKRvhaM5QxvQQbz+oUajaTu11VJa7A
         Ib8g==
X-Forwarded-Encrypted: i=1; AJvYcCWJ6/gw2WrAbg57r6jvVD4pL2z0/Xr1JhklK2tx8hy4pCiwSKN/JBMiuKEkSzFmlnH7xPJjkHHIMnGORdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy/ovT8sW+I12gndR6Y+ASDp4YEEQ2CPgPS4LGcS/KMGjg1jZn
	nKOy+DaGDLy++7Ol+gZdpqY2jMqMofXDkLSLt9PEN0RSxYkjzipxWFd2D8/djng=
X-Gm-Gg: ASbGncuiw5PvZlWQaIRnyywZhxF4TQualEh/KJ53VWKuJBAVYPZupvlX7pbKXNMRZg7
	P0d4s/CZYKXW2OwPgd3H0/Bwa9W4I8q8mHozyzH2laifNTrsFYgmloQUg7csjHEd51jv8cBIphU
	9Nv+gwvQDVQuVRpgvey+BOYW84o4WtbfeqBnS9oCrGOVtAeipD2VK7VYqTIzq6KcJ8xdh5RFlWE
	cqRwF4dT2xCBTLjPh6Kt1Ar68YIlLvR5s9GDm3yUDtxcl3irBxeMq03Aml8ZQZ9EI/yA6hKX6SZ
	fVhZsvyBhVyThzkKDYfRNrOnfyePEFIRPVRFKyR37IVJoOPN7cEX1bsqkBuCkHI=
X-Google-Smtp-Source: AGHT+IHrEzlhOgkq+zDuK43ZJTHn/TAq6eat4Ph04G840iIXAUXagf0yq5sPkcY8nyRgOxiDTjBreA==
X-Received: by 2002:aca:1a0e:0:b0:3f4:ad6:5190 with SMTP id 5614622812f47-3f547de878fmr763766b6e.2.1740529604637;
        Tue, 25 Feb 2025 16:26:44 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f541c5bce1sm510105b6e.46.2025.02.25.16.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 16:26:43 -0800 (PST)
Message-ID: <0de7b0ac-eca5-49ba-b1b3-f249655f3646@baylibre.com>
Date: Tue, 25 Feb 2025 18:26:40 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] iio: adc: add helpers for parsing ADC nodes
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa <nuno.sa@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <cover.1740421248.git.mazziesaccount@gmail.com>
 <23f5ee3e3bf7179930d66c720d5c4c33cdbe8366.1740421248.git.mazziesaccount@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <23f5ee3e3bf7179930d66c720d5c4c33cdbe8366.1740421248.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/25 12:33 PM, Matti Vaittinen wrote:
> There are ADC ICs which may have some of the AIN pins usable for other
> functions. These ICs may have some of the AIN pins wired so that they
> should not be used for ADC.
> 
> (Preferred?) way for marking pins which can be used as ADC inputs is to
> add corresponding channels@N nodes in the device tree as described in
> the ADC binding yaml.

I think "preferred?" is the key question here. Currently, it is assumed
that basically all IIO bindings have channels implicitly even if the
binding doesn't call them out. It just means that there is nothing
special about the channel that needs to be documented, but the channel
is still there.

Similarly, on several drivers we added recently that make use of adc.yaml
(adi,ad7380, adi,ad4695) we wrote the bindings with the intention that
if a channel was wired in the default configuration, then you would just
omit the channel node for that input pin. Therefore, this helper couldn't
be used by these drivers since we always have a fixed number of channels
used in the driver regardless of if there are explicit channel nodes in
the devicetree or not.

In my experience, the only time we don't populate all available channels
on an ADC, even if not used, is in cases like differential chips where
any two inputs can be mixed and matched to form a channel. Some of these,
like adi,ad7173-8 would have 100s or 1000s of channels if we tried to
include all possible channels. In those cases, we make an exception and
use a dynamic number of channels based on the devicetree. But for chips
that have less than 20 total possible channels or so we've always
provided all possible channels to userspace. It makes writing userspace
software for a specific chip easier if we can always assume that chip
has the same number of channels.

> 
> Add couple of helper functions which can be used to retrieve the channel
> information from the device node.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 

