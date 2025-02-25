Return-Path: <linux-kernel+bounces-531440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF9AA44090
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42ED17ACA4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29012698A8;
	Tue, 25 Feb 2025 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGYYAI1B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524AE268FCD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489385; cv=none; b=IAGVpf45FOnGsTe11FMsu1ELCn7SBpu09Z4JvzVbyq3MnqzgaJ12GnGr43MEncdGG0Ee1Xqf4IvUDFCHAx8VIhWSurKwWlcuniozZfvTD5OuoBovpwk6/k6YnSujeGtqkkWFKeepYzbiRrw80AAINl2J+V/S+bAbpkGZuYPkOKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489385; c=relaxed/simple;
	bh=qOXC1JCfflloHvFEyhnlYF5k9jijq3i5BPgiH4ZFlUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6qXlmUF90bEp+/Ut5FKPnPvl2Jygcf6bJgWmvdZ7xwF3zP64YA3Ih+OPX8C9I/STt9BnKmwz0zTTSVVHr8Su1YWqd+L0YtP0LT9H5S5L8+PrTIhSbs/PghcUngXtbvyU+bSDEQ4nHRthyk6FzmAdRyAu/76Dn998iR0GOPRoUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGYYAI1B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740489382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDdQ5865PcUkpASowBEaf7MEBhJrkqmHB1ewBf2p/X4=;
	b=UGYYAI1B9Cj6GguVCp8J6kcJ3jq5ryZ8edhhd5FRY9Gk4llddr5n+BHcp9E/qlEE5YXQgb
	Qw7QgWkqJX/AO3luAczsp1LeXHbxXmEyXf/koYzvc4OD37ChLHRNR1kaPqojryc+WLMr6Z
	q/Jh/J0NIYu3NfDAJeE+5q3GEhBKsng=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-ydGdtgc9P76vnXOnQay50Q-1; Tue, 25 Feb 2025 08:16:15 -0500
X-MC-Unique: ydGdtgc9P76vnXOnQay50Q-1
X-Mimecast-MFC-AGG-ID: ydGdtgc9P76vnXOnQay50Q_1740489374
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-abba6d94ae4so983670566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489374; x=1741094174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDdQ5865PcUkpASowBEaf7MEBhJrkqmHB1ewBf2p/X4=;
        b=WQlpIo6Dr/jd68JDsqAXiuHr8K0OLo91kHSWNZj+VpIfR5qY8+7rDn9ql5UWMdzwHo
         HHKKs/uDvtTjh47PNA3q6odbvF6MC7tg2BAr/iasSaWw2eZ5D4i7kKlZy33NpFycUDcG
         mkynXTRVrdh+QjTas84xITNPoSslgy35tIvwaST2zpe4B/ReoJi5Ynp1OmlGXbx+y7Xo
         B93FAdyM68V4m8BzTNTNzKKV7QjICFdRG+raZofAcOqxauudwIohMz7Sub80IVm8bz7Z
         St5cCpSn8J484O7fjdbNPDmdIFoKSBd0nmJ3pWmgJZH3st9Od9WGL5kzDRCKHSyIUmzp
         BpUw==
X-Forwarded-Encrypted: i=1; AJvYcCWAiphPiM0CQRcvqzSUNstmeKDnmWP30OcmIRaX/CcuG476M2LOOYX7Bfq1bCGQu2lwCP0kTK+5/liYB5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpagJo38uSw/vhNkTvsm/PNqq0sdmZMN6MxQONTLEzslkGBLbk
	adaVLujw1v/JQY7AO4ZVCXtXCoWvuEf06V7g4dL4eF6lKM2+9RK8in2WPseXp2nSuAQl24wej9u
	DLjBwvxQV9zFFugH+U4lHI5ee1kV6oAj19sc/AvS4aWI+DY6tCbuA7yXfJ5X8eg==
X-Gm-Gg: ASbGnctMGVZ0XBkt8in1ITduiH6oMlybz72Y78v2x7cniIeND6732S4Nk+5ZpbC70iY
	D55nvTGRQJNTq7/ekOR+qLSfvzwktJnR7MmmbAkxWgUx4tA88KaCcXS49zDkcjOyry36qWzaNwM
	vHTDbfmPS51u6iWT9vLcaF7fbpcNSddLH+cD3yvsE/qz19jlbYVndv7ETu6JIdiEDB9BBIeUyOb
	srDNea5/Pw9Vnd5F0EqtDEtM468EuTcK5Bs7zaQYEi03/ITcquYEDoCkboI6Du3xLyTq5l9+7I8
	+lLoIMFZdYzhKGEXOewSS2rRbHOw/IvctMDzua2oNrCvLgH6Yj/kifIqWagu2PHeDOEodV2Nh3H
	/5L10YEmJYDuzVV/ethXl4shmOyuyeTCjHVYYvMAtXNmycApf6OdKSktp6wQI6tTDMA==
X-Received: by 2002:a17:907:96a5:b0:abb:c647:a4bf with SMTP id a640c23a62f3a-abc09ab0c3cmr1650992766b.23.1740489374204;
        Tue, 25 Feb 2025 05:16:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8Huvoo7UhuX++Bwcz+4yYSyekZGfuo2owJoX/ZLlbS2CDtchThnK8UMzHdJHp9qhhK5TgUQ==
X-Received: by 2002:a17:907:96a5:b0:abb:c647:a4bf with SMTP id a640c23a62f3a-abc09ab0c3cmr1650987466b.23.1740489373819;
        Tue, 25 Feb 2025 05:16:13 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d5529dsm143348466b.53.2025.02.25.05.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 05:16:13 -0800 (PST)
Message-ID: <a98547f0-f125-45dc-8bb6-a154ad78f672@redhat.com>
Date: Tue, 25 Feb 2025 14:16:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] power: supply: core: convert to fwnnode
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 Samuel Holland <samuel@sholland.org>, David Lechner <david@lechnology.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
 Purism Kernel Team <kernel@puri.sm>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
 <20250225-psy-core-convert-to-fwnode-v1-7-d5e4369936bb@collabora.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250225-psy-core-convert-to-fwnode-v1-7-d5e4369936bb@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sebastian,

Thank you for your work on this.

A few small remarks inline / below.

On 25-Feb-25 12:21 AM, Sebastian Reichel wrote:

<snip>

> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index a785742f97721e7e70d0e4c17a1ded7b985acb6d..9afde8c04efc72691c81a373d8dd03477b4efd7e 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -805,7 +805,7 @@ static inline struct power_supply *power_supply_get_by_name(const char *name)
>  { return NULL; }
>  #endif
>  #ifdef CONFIG_OF
> -extern struct power_supply *power_supply_get_by_phandle(struct device_node *np,
> +extern struct power_supply *power_supply_get_by_phandle(struct fwnode_handle *fwnode,
>  							const char *property);

this function now no longer is DT/OF/open-firmware specific, so I think it should be moved
outside of the #ifdef CONFIG_OF block now ?  The same goes for the devm variant I think
and the implementations of course also should no longer be "#ifdef CONFIG_OF" .

>  extern struct power_supply *devm_power_supply_get_by_phandle(
>  				    struct device *dev, const char *property);

Regards,

Hans



