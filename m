Return-Path: <linux-kernel+bounces-420731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4C99D82DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9351B2B654
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF5D1917FF;
	Mon, 25 Nov 2024 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CR5eZ51c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A246C190477
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527595; cv=none; b=FI/vgr3S6l1lr2EXWlFJZaSiIUV2SQ1eWnFiuKaRFmFKu9oMIwq6gicux2/cA5+vrR4n2q3pS1NOriV98mc/s01PNOVva6QPfW1RYuzWH0noB6LWiSj/ml19BESBsPPVMjdv5Qs02DNmABZV6pBxuaDJTA9h7lvarKd3BwIiLi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527595; c=relaxed/simple;
	bh=/XmRtZPekwBtjrpUKtPZ8Qzt7cmYd7hNsU72jLIQ7MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bssJxm0D7QZ8T8UgPpit4Y5AmA4ioGCblk8hjSTXSVdxF9JzjRwaYjmG47bkG6b/emz58P0E8G2OeeOwCHsKeuikayjHeNjBUO4/SvUs0tiPAj6tp96dq/5hU4N7PsPY030u+CeFqDO9HekehfWwQMDMWmHIDnIpHL1XMbiYCiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CR5eZ51c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732527592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hkv+uXuHpbZj4SkgeiuTnLecSlEJeOMpyMLd4JnkUbc=;
	b=CR5eZ51cJ48sn2IhDZNS/frwFN8wZHF0IAHUhHa5tdHLhTuVYMznVh+t3UQoODBfzOPpL1
	lwYUBvpa79sG6vz3M4oE6Prpw2pYvt8IvedOl1E4n+o+GZQqQB8RrHxDyY09YJXZ3tBH8r
	ZCbQtFyG7c6IGBK+2F0wTLSYvDN2rt0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-6iLnLyw5OY6XWj7vh1SF5Q-1; Mon, 25 Nov 2024 04:39:50 -0500
X-MC-Unique: 6iLnLyw5OY6XWj7vh1SF5Q-1
X-Mimecast-MFC-AGG-ID: 6iLnLyw5OY6XWj7vh1SF5Q
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa525192412so152769366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:39:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732527589; x=1733132389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hkv+uXuHpbZj4SkgeiuTnLecSlEJeOMpyMLd4JnkUbc=;
        b=mlOveo1eK35mKM8rT2MYRI5S51Z/IkMBxxweISXRhdClxnixsCzUT6wKSH+cYC/5SB
         YvYFtshJUUERHAJE6jKNYpnEFfU2tb7V58mQRgcQ/45DCGDPqp7VzmZcaFwu7unE+aeI
         Gvge6uV4eMp1hCEObAvOjATkXWoVg88bOlKH1QBhZAQgDuX2s4iuXbK7XoIE49+NTMJj
         P+kvKklBUCHCgI5NlA3LAQs6bZw4w83VUO3mryVJkJf0EIeoDSSWi3qZ4605px7eSc0z
         ovYKADqKXJVRcJ67I+J4MR5/F1aNZqe0Rtnlf/A7VL75IccDFgZmYjm1wOC57Dim5hbb
         7NaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkVU1Sw3lujAYxKnxaFHO6lwRxgpcgDq9E0SK/rvnYaoCsQhWiqgK1tX7uZm7+Ol60YM7eHhLFkGTyp1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtYaGukUR/PFVOw31jDsJ3MvUJzWNuGzvH9zLul2rd4ASxDJDX
	IS+9L2wjnn8KO2RzzxZt9mwmiXABBI++M5al/6DKUg0bdO825MMAKDUTZUuBRXUcKT+HJvErWbS
	/84g+l31hDRYq63G92BK6B6a1zOCgmR2yKq4F8k9ivG00k9ZW498N83InSZHU2g==
X-Gm-Gg: ASbGncusA17mc6QWFcH5LjT9lDHWSJ3z9tF8oHJBllCZNfSR3NFuiThzQbyiNyXO9mJ
	HbNbpy+eH7gfwwn++7bzWyoecU9G6l2YW4Cd7uSw+u6U8ngCtzc8nY+Q26WxXM6a72IKzuqAVVt
	iUD9c1G5mWWPIHzZv9a7H+1QsCeAEkAALiAbOaBkX5qWRvAL930Hd5Cy9y4QzW3EIe7OPJ2w51m
	G1qxuIaRTTI8zxV59+ndjODYTKuRitA1xVFD4edX4boEX7ulyqmBn+cIZy1WbnFqcESlw1bP7CC
	xEeSWGr0VhYeVrTRu2perUDzcID+88FxlYdQ3pDEJAv0YXZ+KXU1h1oh4Lc1H3LBu4xbo5XoPPG
	GusECYlMhw9qbGoVHQxPn9/pa
X-Received: by 2002:a17:906:3cb2:b0:aa5:e01:1471 with SMTP id a640c23a62f3a-aa50e012d9emr801069266b.37.1732527588960;
        Mon, 25 Nov 2024 01:39:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/f1jKAAuDrIC1Zrrvx4lRzK1vd7c9PbVgtQQZlOB3tA0pjSv7qEbmVKDZG1Joh+4VYnDp+A==
X-Received: by 2002:a17:906:3cb2:b0:aa5:e01:1471 with SMTP id a640c23a62f3a-aa50e012d9emr801067666b.37.1732527588602;
        Mon, 25 Nov 2024 01:39:48 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fe50sm447130066b.102.2024.11.25.01.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 01:39:48 -0800 (PST)
Message-ID: <d48bee72-7cd6-41cd-8d1d-282e8e68269d@redhat.com>
Date: Mon, 25 Nov 2024 10:39:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] platform/x86: asus-nb-wmi: Ignore unknown event 0xCF
To: Armin Wolf <W_Armin@gmx.de>, pespin@espeweb.net,
 corentin.chary@gmail.com, luke@ljones.dev
Cc: ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241123224700.18530-1-W_Armin@gmx.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241123224700.18530-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 23-Nov-24 11:47 PM, Armin Wolf wrote:
> On the Asus X541UAK an unknown event 0xCF is emited when the charger
> is plugged in. This is caused by the following AML code:
> 
>     If (ACPS ())
>     {
>         ACPF = One
>         Local0 = 0x58
>         If (ATKP)
>         {
>             ^^^^ATKD.IANE (0xCF)
>         }
>     }
>     Else
>     {
>         ACPF = Zero
>         Local0 = 0x57
>     }
> 
>     Notify (AC0, 0x80) // Status Change
>     If (ATKP)
>     {
>         ^^^^ATKD.IANE (Local0)
>     }
> 
>     Sleep (0x64)
>     PNOT ()
>     Sleep (0x0A)
>     NBAT (0x80)
> 
> Ignore the 0xCF event to silence the unknown event warning.
> 
> Reported-by: Pau Espin Pedrol <pespin@espeweb.net>
> Closes: https://lore.kernel.org/platform-driver-x86/54d4860b-ec9c-4992-acf6-db3f90388293@espeweb.net
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/platform/x86/asus-nb-wmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index ef04d396f61c..a5933980ade3 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -623,6 +623,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
>  	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
>  	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
>  	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
> +	{ KE_IGNORE, 0xCF, },	/* AC mode */
>  	{ KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
>  	{ KE_KEY, 0xBD, { KEY_PROG2 } },           /* Lid flip action on ROG xflow laptops */
>  	{ KE_END, 0},
> --
> 2.39.5
> 


