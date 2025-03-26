Return-Path: <linux-kernel+bounces-576724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA6DA713A6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70ACF3BA91F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AE31AAE28;
	Wed, 26 Mar 2025 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdRgcl9J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F04DF59
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981046; cv=none; b=RU0JAUUWjGlXlWd9phMVlkDZGqh1IiE3l9NC2GQDjQgF1Gp2uc34NW20mmo5fiPjQt1Bn6qyEYvsD+Tky6VnOVynpXgUvY/1BOH14MY9MJmgX/BRdcSSHh1DX9+bPVJF+z7yXRTZz66EcyHk81TdiWkrDptDxKj+TX5hNBhOe8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981046; c=relaxed/simple;
	bh=qf/sgisAQcKaZRDABaj+IQx31SpuvMLofAX/b03cC9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXbpVE7dLTfKUgu8AyCFltMozKPSbpUlhs/0R+mA8heuwwvLZ8I5Is7uxuzUTOYoDO9agd8b9+cNMArIoHoEGUsGL0xS/jIitCKvfzj1h6Wsj74NWUSbB/8Ma5zMcm0etn4Yb9LRloqvL+RngB8xuwrkybLm7FFN+i7mfeMPjtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bdRgcl9J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742981043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQ6QhNnfLYXbZdIZx/vDMwupBr33SbF8nWAPHqeeQvg=;
	b=bdRgcl9JP5dorwY5CPcy3VdaUEZOEVjwBSe3BXNa7Y1Hd//goSejdj3b3EK3a1Ey8LoVtg
	bi4IXSguhkDn+K7gVJA2nNNWauD4/Ta63PvNEraMJmoMCJ7Hqe2HedHDYJ1KyiHe4F70iY
	3xtpoqjhFe+/XWBVPZX6dHE4QLKwUSc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-uzBQJzlWMlaIOQ1BweZCWQ-1; Wed, 26 Mar 2025 05:24:01 -0400
X-MC-Unique: uzBQJzlWMlaIOQ1BweZCWQ-1
X-Mimecast-MFC-AGG-ID: uzBQJzlWMlaIOQ1BweZCWQ_1742981041
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac3e0c13278so534072766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 02:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742981040; x=1743585840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ6QhNnfLYXbZdIZx/vDMwupBr33SbF8nWAPHqeeQvg=;
        b=uplsf9M1xwQG953XSiF/QzPwuVtorxlmQQ6Bada/MKYIsvbn9CmmQHsmmxwQ73k7Vv
         JW0IVq2sTGQyjABMOHp6XMr7g+SkT+tppytUCfEstb6uxfOGvi6tsp1uJ67fJ7hYSaan
         KeLEu4kz18XVRtLPEOupfZyKGGPbPcyjuVYzuebPX6G1s0n4QgVZouj6DGrFLREgp3e5
         Cq5uHjMoByEmX/W3GeJCsqrkuImL2eYPqXPVoI08PmlWfoHxpho5S1JC5WHtq+dMdg6l
         +GBLurhxCiU6Mg7qMzearCBLyznJ9q9LJKRQ+HcouyTMv7Fc7RcNVb2BJISb+NudM4s3
         sOow==
X-Forwarded-Encrypted: i=1; AJvYcCWkQDg58CD8QZTlNUEgjMjlqiCUSqyLasBDRrykFsWMvBJQ2PIgNwM5HQc37pcl7jnhR2lxoNAZgn3cmiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeRG510gOspnu/mKZCIs1XYZqVyZeMpwvDF6t7HxXIN5NLFeeu
	hH+UhUYBKeSXby4c1y/IVCvhTphpB1l0UP+OExXGd6+K22eu3nDubDHwcFmoaVQ2zlNmglqpFi0
	mdrgN0FggurWthVDrNyOzv2c8hYFRTLjswRr4a7je/zfP+d63FbWxCHfVm9p9JQ==
X-Gm-Gg: ASbGnctvX6VkG/CNCC4HK3b2qIEKSH9nltCkh1s4Dnb8hoPI0gT2sgNUrWdXp80NAm6
	MsXEt28G3nPjVe1ip6zU4JoklOLdzz0Kx6SPoJqGqKHxbOAPFSk2xrHytinqv03ZCmvS6LXeCdY
	7RYT3TZu+YzELfvmXDeBvfhNHaUaG+EZqGhDVC0aE2JqAq3XIlMMWKIRhJAiq6u7cEui+LD3dvp
	z5EQyl9hufc6q2FpvIcA8BBULcrz3YgWFqcBtrf1N4vleya5WjluxdKvoJP5VbPuZsXBZZU4JL/
	6kTLIBsnCGamZYcjSKPdnbKV9dm/YBkEkfm5MzIy1zb/MoGcm2iY7EVSrK0zFzq8eHV+rPJTqS3
	qLln88S5Vj2FIuBmY5sSBGmYu49nfTHY2K261XsEmW29RLfHM2JXPM78D0JVyf6QpmA==
X-Received: by 2002:a17:907:3d92:b0:ac6:ef94:3d9a with SMTP id a640c23a62f3a-ac6ef946332mr54918666b.4.1742981040471;
        Wed, 26 Mar 2025 02:24:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgfGOSw/fuBqgO1O4PO8WqGxGVs32QYzEOSqRxo/94jTXehX2juoFoGt/m3XlXvnmLeU9OWQ==
X-Received: by 2002:a17:907:3d92:b0:ac6:ef94:3d9a with SMTP id a640c23a62f3a-ac6ef946332mr54916466b.4.1742981039951;
        Wed, 26 Mar 2025 02:23:59 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb658e4sm995169166b.87.2025.03.26.02.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 02:23:59 -0700 (PDT)
Message-ID: <c487c00c-2900-42cf-b83b-08c5e1b866e1@redhat.com>
Date: Wed, 26 Mar 2025 10:23:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Added support for a some new buttons in ideapad-laptop
 driver
To: =?UTF-8?Q?Ga=C5=A1per_Nemgar?= <gasper.nemgar@gmail.com>,
 ikepanhc@gmail.com
Cc: ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20250326091632.23644-1-gasper.nemgar@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250326091632.23644-1-gasper.nemgar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gašper,

On 26-Mar-25 10:16 AM, Gašper Nemgar wrote:
> Added entries to unsuported wmi codes in ideapad_keymap[]
> and one check in wmi_nofify() in order to get wmi code 0x13d to trigger platform_profile_cycle() but only if dytc exists.
> 
> Signed-off-by: Gašper Nemgar <gasper.nemgar@gmail.com>"

Thank you for the new version.

> ---
>  drivers/platform/x86/ideapad-laptop.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 30bd366d7..cd8c38dc8 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1308,6 +1308,16 @@ static const struct key_entry ideapad_keymap[] = {
>  	/* Specific to some newer models */
>  	{ KE_KEY,	0x3e | IDEAPAD_WMI_KEY, { KEY_MICMUTE } },
>  	{ KE_KEY,	0x3f | IDEAPAD_WMI_KEY, { KEY_RFKILL } },
> +	/* Star- (User Asignable Key) */
> +	{ KE_KEY,	0x44 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },
> +	/* Eye */
> +	{ KE_KEY,	0x45 | IDEAPAD_WMI_KEY, { KEY_PROG3 } },

> +	/* Performance toggle also Fn+Q */
> +	{ KE_KEY,	0x3d | IDEAPAD_WMI_KEY, { KEY_PROG4 } },

The above 2 lines should be:

	/* Performance toggle also Fn+Q, handled inside ideapad_wmi_notify() */
	{ KE_IGNORE,	0x3d | IDEAPAD_WMI_KEY },

otherwise this version looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> +	/* shift + prtsc */
> +	{ KE_KEY,   0x2d | IDEAPAD_WMI_KEY, { KEY_CUT } },
> +	{ KE_KEY,   0x29 | IDEAPAD_WMI_KEY, { KEY_TOUCHPAD_TOGGLE } },
> +	{ KE_KEY,   0x2a | IDEAPAD_WMI_KEY, { KEY_ROOT_MENU } },
>  
>  	{ KE_END },
>  };
> @@ -2094,6 +2104,14 @@ static void ideapad_wmi_notify(struct wmi_device *wdev, union acpi_object *data)
>  		dev_dbg(&wdev->dev, "WMI fn-key event: 0x%llx\n",
>  			data->integer.value);
>  
> +		/* performance button triggered by  ...  */
> +		if (data->integer.value == 0x3d) {
> +			if (priv->dytc) {
> +				platform_profile_cycle();
> +				break;
> +			}
> +		}
> +
>  		/* 0x02 FnLock, 0x03 Esc */
>  		if (data->integer.value == 0x02 || data->integer.value == 0x03)
>  			ideapad_fn_lock_led_notify(priv, data->integer.value == 0x02);


