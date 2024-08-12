Return-Path: <linux-kernel+bounces-283109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2633394ED51
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9161C21925
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FED517B501;
	Mon, 12 Aug 2024 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESuMW3ac"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4001917B505
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466906; cv=none; b=gt3tKdQK1s7ldzaMECGFKizTfm4Vwjbs4V9AAyt+QeZwoPR3ic/y8wF8mbw7FwTerbSi+spSyJWDkBnV/OlJjk33ozB+n3+bfwuHEUBwPmuobsvbh89IMLTuWzsfpqnp3HXIy7uIk/ntEWnMhzb+bvkNKdw2a85AntLyuLyQQxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466906; c=relaxed/simple;
	bh=8bo8xpp/6vJwbHGAAvw+1pSQFYWA+0dCEVeKlYLVTqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wwss0Gqahb/+AavIIK9tVVgkFHFQxoDZ4+UZy1gwhhcPfG011Z0OkH/bQFbqOsyjOnq+VR84LJ4AcZIVaIgh1KiInLZFhALSZMWj0YPDCQueo/amyHxtdqprYNK8u5uEbjdSCgtdg6WXSNihPXrc4uul9KYbRVblvDdBqWNPp34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ESuMW3ac; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723466904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8d8haasheAsFVThGjhEYRKDinSaCWYMQj8ax5D0rh3A=;
	b=ESuMW3acoes/eq9X3v7DMNmq0sP4s8gcGnjq1t7ONlaPdoTWfLmfwWTOCqMimWpUNWUW4A
	3WYxRzmI8l5ysJLiKo8BVjDtbyVyT+SJ+Z8nswMRU7qxQtA3GYIBjiApmstOCu7vkK9qKv
	U4mZMlg9gG3CogmJlV/TFh34chZ8XP0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-h2v_IkT7MwSEOVYMdMoLHQ-1; Mon, 12 Aug 2024 08:48:22 -0400
X-MC-Unique: h2v_IkT7MwSEOVYMdMoLHQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52efce218feso5375601e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723466901; x=1724071701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8d8haasheAsFVThGjhEYRKDinSaCWYMQj8ax5D0rh3A=;
        b=v3Ljs8xtAcKh56AU4UUUPrfHF/ECQvntAMwegwUVtpDNq4DiCD6LLxnnTlM/2EvMis
         aveKDYrnkP7W5eNsFTO2ZeDWMcddKCT/jtkBwkUrQ221/Jx7DRxMFqkn2ktrqneoTa5Z
         uyAvHTxI5iO1i09nOxPhsQFEWl7AsLTQ0hdW0Ejx6fzvWGhw5VnEFGTskUCYjJs9u7q/
         FdNH2nP0YjSOQJudd61XvZN/ExBTwQZdDJ53Q6KGkBJwrCe99L2XLUKVvfdOziuLFmw1
         9R3ybla9YGspDzPcgFYQ7WGVVwKZtCa33Hn/mt7lMNNRHib7J4tsnh4LLvG5uPxt2M4H
         tBug==
X-Forwarded-Encrypted: i=1; AJvYcCUlRTwmB8uvznGQdzX8jMlYgKRKtDB6XzAJAflViGmqKF53F6Gvtlx/vI/VnaRIlj2mViHAmOk9WfeW/0ZjZYCahai7V3Zo+jiHkdrl
X-Gm-Message-State: AOJu0YxJ9t6ZXbsWIm0iSC6L4WZ/alykBGfKdUccBSWHyWbAftGMejqe
	bZvkLtT8Txz1keeSWfBFn2YTpowxiA653IqC7NzhyWESixlKq9WmVeRFdgz954RyLODwFF96Kr1
	wlqSZLYAUamTdnwDvfOdUibmZYFFVuB6eZ7iHirlpf+tW/3uEMicPbub4SML8+Q==
X-Received: by 2002:a05:6512:3e0c:b0:52c:e07d:229c with SMTP id 2adb3069b0e04-5321365d338mr7202e87.22.1723466900844;
        Mon, 12 Aug 2024 05:48:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHejkkgyA0azZvDT/mX1/XOZpJaecJH2R29rXxfhob07pjKW9TXVcI9hlTBx8S42862SP10xQ==
X-Received: by 2002:a05:6512:3e0c:b0:52c:e07d:229c with SMTP id 2adb3069b0e04-5321365d338mr7163e87.22.1723466899980;
        Mon, 12 Aug 2024 05:48:19 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb243c3dsm229614366b.225.2024.08.12.05.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 05:48:19 -0700 (PDT)
Message-ID: <7bf12e39-8956-4cd3-a90a-871291d84370@redhat.com>
Date: Mon, 12 Aug 2024 14:48:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] HP: wmi: Add documentation for the LED API naming
 scheme
To: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>,
 ilpo.jarvinen@linux.intel.com, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>
Cc: mustafa.eskieksi@gmail.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Linux LED Subsystem <linux-leds@vger.kernel.org>
References: <20240719100011.16656-1-carlosmiguelferreira.2003@gmail.com>
 <20240719100011.16656-3-carlosmiguelferreira.2003@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240719100011.16656-3-carlosmiguelferreira.2003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

+Cc Pavel, Lee, linux-leds for review by the linux LED subsystem folks.

Pavel, Lee there are 2 pdx86 drivers for control of zoned (3/4 zones)
RGB backlit laptop keyboards pending:

https://lore.kernel.org/platform-driver-x86/20240719100011.16656-2-carlosmiguelferreira.2003@gmail.com/
https://lore.kernel.org/platform-driver-x86/20240806205001.191551-2-mustafa.eskieksi@gmail.com/

both of these will use 1 multicolor LED class device per keyboard zone,
using the naming convention documented in this patch.

It would be good if we can get feedback or an ack from you for this
userspace API before merging these drivers.

Note the first part of the patch documents the already existing naming
scheme for single zone (RGB or mono color) backlight keyboards. This
scheme is already used by many drivers and by userspace consumers like
upower. So this is just documenting existing userspace API which so far
was not documented.


Carlos, Thank you for writing this patch.

For v2 please change the patch subject to:

"Documentation: leds: leds-class: Add documentation for keyboard backlight LED device names"

and this should also be merged through the LED subsystem tree, so for v2
please send this to Pavel + Lee with linux-leds + platform-driver-x86
in the Cc.


On 7/19/24 11:59 AM, Carlos Ferreira wrote:
> This patch adds documentation for the LED API class-device naming
> scheme practice.
>
> Signed-off-by: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
> ---
>  Documentation/leds/leds-class.rst | 40 +++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/Documentation/leds/leds-class.rst b/Documentation/leds/leds-class.rst
> index 5db620ed27aa..8e74a436ca9b 100644
> --- a/Documentation/leds/leds-class.rst
> +++ b/Documentation/leds/leds-class.rst
> @@ -116,6 +116,46 @@ above leaves scope for further attributes should they be needed. If sections
>  of the name don't apply, just leave that section blank.
>  
>  
> +Keyboard backlight control
> +==========================
> +
> +For backlit keyboards with a single brightness / color settings a
> +single (multicolor) LED device should be used to allow userspace
> +to change the backlight brightness (and if possible the color).
> +This LED device must have a name ending in ':kbd_backlight'.
> +
> +For RGB backlit keyboards with multiple control zones, one multicolor
> +LED device should be used per zone. These LED devices' name
> +must follow the following form:
> +
> +	"<devicename>:rgb:kbd_zoned_backlight-<zone_name>"
> +
> +and <devicename> must be the same for all zones of the same keyboard.
> +
> +Where possible <zone_name> should be a value already used by other
> +zoned keyboards with a similar or identical zone layout, e.g.:
> +
> +<devicename>:rgb:kbd_zoned_backlight-right
> +<devicename>:rgb:kbd_zoned_backlight-middle
> +<devicename>:rgb:kbd_zoned_backlight-left
> +<devicename>:rgb:kbd_zoned_backlight-corners

The -corners zone was based on a misunderstanding about
the Excaliber laptop's functionality, please drop
the "<devicename>:rgb:kbd_zoned_backlight-corners"
line here as well as below.

Regards,

Hans



> +<devicename>:rgb:kbd_zoned_backlight-wasd
> +
> +or:
> +
> +<devicename>:rgb:kbd_zoned_backlight-main
> +<devicename>:rgb:kbd_zoned_backlight-cursor
> +<devicename>:rgb:kbd_zoned_backlight-numpad
> +<devicename>:rgb:kbd_zoned_backlight-corners
> +<devicename>:rgb:kbd_zoned_backlight-wasd
> +
> +Note that this is intended for keyboards with a limited number of zones,
> +keyboards with per key addressable backlighting must not use LED
> +class devices since the sysfs API is not suitable for rapidly change
> +multiple LEDs in one "commit" as is necessary to do animations /
> +special effects on such keyboards.
> +
> +
>  Brightness setting API
>  ======================
>  


