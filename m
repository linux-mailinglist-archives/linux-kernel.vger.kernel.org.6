Return-Path: <linux-kernel+bounces-522001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0838A3C4C0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E7C169DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB6F1FDE3D;
	Wed, 19 Feb 2025 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="BH/R74WP"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6A31FDE02
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981858; cv=none; b=QVy0gl/UedXXJ1MJwYSTsJNf5TxyMfI9P3g8nUfVNKYjEk27iFDD5mh/n06DDmnDU1I1M9+m/H9okQJftveE+5fV60nnjQtB2Nxuwu0LdQ2njfxnSLdUs1BU87ozSiB+Qnx0Tr9DGy0o4pGSPkjziZstN3jc3pPlVJdyFwTDLA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981858; c=relaxed/simple;
	bh=ceLVZIQiEmcQitphSISYjez4ESWwsr0B6WSI8k4wTLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVX7rIKE7ZARBJ9GFb/NBrKuejLwK+5q12AeJp/zjWr02Up6+mOoCZ798scq9g4CNjtWFtMj8l2olvqBOBbWsLLT7MtHrrTviNA5PuW4XFSLRJP6+5AtwoLKBiyc6rnDSL5vkKpv6nNHIEaU81fre7K1KwQXST74hvW7KmdSu64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=BH/R74WP; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abb999658fbso429846566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739981855; x=1740586655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HejSJgJQcfFFAzTEJQMkHvtlK7Scumc9KiDgQ1jWL0c=;
        b=BH/R74WPzt/8LYuGelhyLub63/d3Ert9KHNdGwjutcpyNYwDxKjr531dgFjymRhN64
         GHX9koymmfOEvIE7sS709/rhGRrd/WnHqtr3ZagPXwLzwndxVmU4OufskSAw6orkoOLU
         UgFjeoMenY0WKYvytrefwNIRSFnQ9IBz7DUT7xb3z0mjocPCIdld0lMRKzYJB6kJoDLW
         mDnburCLMy9F4jDBbFVgJQDaYsVUH0n0uVJSlvERHsi3zMURpv6l4as+B7jljDhOPq9h
         L9+VbWe+OVOWAKEx0yx9SS+WJg4CevhftOXS/nSF5uaDmS2o4X4H6io9g0inYa/fe7wY
         twLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739981855; x=1740586655;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HejSJgJQcfFFAzTEJQMkHvtlK7Scumc9KiDgQ1jWL0c=;
        b=DYRH3cnNUjZpiE9965X3Uqc8whhHowSc5jZY2s/BLGZQ8/k/gVFx+Hu+mN6j4QrrFG
         K7kvyW17n6VmMDAzeSfIeTxZRfeYDrnYaoULsOcYJWSD6fUbUhu9SMbnPyQrG1qJiplT
         EDvsU19KzlX3hbFnxuMP3yQ83K3Sd0Kb5M0bIouHQs3Jq2Gsmk/+ojAIUfCtnWY8JDzP
         PejlRDnaw8eaWpqxZjOVf2NLb+Y41xvShNpWBHzWX80nMxKVcdoBQ3JEmgqcFLfQiY/O
         kVaOAaWdWle3sx4BmP4/oIDdsxRLHeI5dVBUCJoBgUir8JfO9WhmuO20T+j8SnNpL4dP
         7p5A==
X-Forwarded-Encrypted: i=1; AJvYcCUpaL6IbEqu5V1PDhFssH7rixBFoRqQJYgh4vh2OZfGPJpAQIXBBOujTY3qFUmvXUqBVIQXf5jhIg6kXQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHTiu+Iq1AUJeE7TTtktumR8kRSTLCvgQV+v5YzjULuId/t7Yf
	vZDFxxpqZem/RtweBx+1UKvWHR1LRvEX6NFT8xWe61MKN364sjCQkOhS+qLYpQY=
X-Gm-Gg: ASbGncsNnRHzpxjsWlGNIy8A3/BoA+7X+9x8WJB189UfJXfEQSBPXiGNZl6DHZUkMR/
	SnMJR89SsAkSmN8EuoG1bTIWNr6gXIzveLNt4IaRSi7/Xb7k5JLr/37aBnQbo258RrdKcW2wf2v
	kMm7OevCj9RgLgiHqNE1aSMjtsXj/CWm4QLBHRUt9uL6YEweHaW+sxJAVAD7K4GZYVKOAbJecgj
	KRG0dfN+bIflzrpZxeazlL42b4Z0dzfGYaCKL41eVSmqMMB69t2P1lJL9bB9U0XlDwVvT/F03Gq
	XFeTg5F6FJ0ErDl/DfqI62I=
X-Google-Smtp-Source: AGHT+IGfUVTc8q0ff+aqRcU4u7qX8iIkWfV/1/hphxf4aJV7O0tPiAEGukjDGHF4YsVK3fbVAZBivA==
X-Received: by 2002:a05:6402:2347:b0:5e0:8c55:50d with SMTP id 4fb4d7f45d1cf-5e08c5514bbmr7648059a12.14.1739981854600;
        Wed, 19 Feb 2025 08:17:34 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb96fa4d79sm652128066b.126.2025.02.19.08.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 08:17:34 -0800 (PST)
Message-ID: <4a7c7a87-b293-4522-961b-d6a45f12542b@tuxon.dev>
Date: Wed, 19 Feb 2025 18:17:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 0/3] usb: renesas_usbhs: Fixes for renesas_usbhs
To: gregkh@linuxfoundation.org, biju.das.jz@bp.renesas.com,
 geert+renesas@glider.be, yoshihiro.shimoda.uh@renesas.com,
 laurent.pinchart@ideasonboard.com, phil.edworthy@renesas.com, balbi@ti.com,
 kuninori.morimoto.gx@renesas.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250219161239.1751756-1-claudiu.beznea.uj@bp.renesas.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250219161239.1751756-1-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Adding reference to the missing series (see below).


On 19.02.2025 18:12, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> Series add fixes for the Renesas USBHS driver identified while
> working on the Renesas USB PHY driver (series at [1]).
> 
> Series (with [1] on top) was tested on Renesas RZ/G3S with consecutive
> unbind/bind and data transfer tests before/after the unbind/bind.
> 
> The unbind/bind was also tested on the devices with the following
> device trees but w/o checking the data transfer (as I only had
> remote access w/o USB devices connected):
> - r8a7742-iwg21d-q7.dts
> - r8a7743-iwg20d-q7.dts
> - r8a7744-iwg20d-q7.dts
> - r8a7745-iwg22d-sodimm.dts
> - r8a77470-iwg23s-sbc.dts
> - r8a774a1-hihope-rzg2m-ex.dts
> - r8a774b1-hihope-rzg2n-ex.dts
> - r8a774e1-hihope-rzg2h-ex.dts
> - r9a07g043u11-smarc.dts
> - r9a07g044c2-smarc.dts
> - r9a07g044l2-smarc.dts
> - r9a07g054l2-smarc.dts
> - r9a07g043f01-smarc.dts
> 
> Please give it a try also on your devices with [1] on top as well.

[1]
https://lore.kernel.org/all/20250219160749.1750797-1-claudiu.beznea.uj@bp.renesas.com

> 
> Thank you,
> Claudiu Beznea
> 
> Claudiu Beznea (3):
>   usb: renesas_usbhs: Call clk_put()
>   usb: renesas_usbhs: Use devm_usb_get_phy()
>   usb: renesas_usbhs: Flush the notify_hotplug_work
> 
>  drivers/usb/renesas_usbhs/common.c     | 6 +++++-
>  drivers/usb/renesas_usbhs/mod_gadget.c | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 


