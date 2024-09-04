Return-Path: <linux-kernel+bounces-315581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 754C696C46A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3AA1F23C74
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766CC1E0B9B;
	Wed,  4 Sep 2024 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtImJO88"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1CC1E00BF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468663; cv=none; b=GRHnCG5F54qACHiVEhPIj8UFQX1ubC0UIbetHWppJ3i3+U7XalaFu8qU+sGyGrsv8RWYcvQP9Bakqw2oF0Em6GR1g4BlId2bwyoXwsgFg6a49XkWWrR+KVvJH8XLqGS3s6nCA4DmmLtVHejLjcb3ep+01F/fI1WK3dgj8WFzDLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468663; c=relaxed/simple;
	bh=CUtfXQ1B6p2l1L3MA7cbM5MtZSEFPbDf5NcansRUX4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7DDybXYCWnp/kDBj8wTbtDOlK5+FfylRD9W4I1/C42KYWRkZ75Y17DRQYrT/kEBS3Mjvktt0qCNqK657pjUb22ehlKrBCdhVmLVYFYeRENkvJ+zDn8nCmnjS0VYOL7GCrwNYqfMWUnUuGVDeWD7kZR1j5Fx0UGNUJHq3m8LmP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NtImJO88; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725468660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S8pGxyzcxGWcC4nt9060uzK/gS2uCUTjlUvcNDqFhoA=;
	b=NtImJO88iN4s6pYGLnuRS2m0blmHXnNrHDRYIjGo4LNAGgGzxuY+RbUfrrJJwVvW4QqCRg
	TUPGTVN7xlLtWwfL7H3XIaFTuzQUTW/N6HcbWwJlfxsjy/WkDov2+Jvjo9jntfe8PoIBx0
	uHc7ZJW9v7jiPInMPbqESQroJzuD42g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-3DhV8EuEMi2UqGIlCJa_yg-1; Wed, 04 Sep 2024 12:50:59 -0400
X-MC-Unique: 3DhV8EuEMi2UqGIlCJa_yg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8685464a7dso502594366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 09:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725468658; x=1726073458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S8pGxyzcxGWcC4nt9060uzK/gS2uCUTjlUvcNDqFhoA=;
        b=GJ+R7kTbE6dvfRXAmz3LZBonN1L/wn0BTMCKaMQ/LE7Xqt7QjQ+RZxvbneo3AeaHur
         mLx5mH/cgYSdEUMwclIs0XZ6FeB+Tt4IriHBOnNMqWYRiqP97WyWJvqUll9PoIdInik+
         PrGh3vawqUBtxz5ZNuyGEV/2T2e0IY9rWNeyKPFGl1oNXzDWhM0p31K2ryFFLCJQz5ff
         zHe1D0Cn9iNuAqiBprrfY7nUfkSlzpE0P4MPaHW3NJ75CXG5t8atF/rtg92ymKcUwmOd
         3BC6BFVsMHO208ly0/LB73tP8RDo8b78D8JMD62GRTKDMNjWwHTjRLn4N0Y06TaVeBrk
         wxUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Nuyl/MZs5OmeQx82d8lX9XU8eP68ONEnVzqlvwdg/aI3iRs4Eq8eqavrQjxrDX30IHGSteD7TcoV+e0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvmk9cBrh3c9YTqayPaXzQdxX/fNlZCoUNeNuGmVlM9+pNmUAw
	Z/QyS5q2tE7LsMdWcltu0j0NgpdIQp8C/OzXtNoEMg4HBAkwgjTnBwC8sQAfQGQObrLcMyl1g+/
	CuH/IxcE/HGAL+YeBP+2rAw9rDb1porHy3gq4W7YOKs+/Y6vDZZg6YEWa1UUv7YKtL82t9w==
X-Received: by 2002:a17:907:d8f:b0:a7a:b781:60ed with SMTP id a640c23a62f3a-a89a35a1159mr1199036266b.17.1725468657822;
        Wed, 04 Sep 2024 09:50:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNlLQI1pTSzTtxafIiDTHzKaXWQOEr+CPrhNnxxSy8ePy+AijsaGEzMJhS0/uJ9tT0iGpd2A==
X-Received: by 2002:a17:907:d8f:b0:a7a:b781:60ed with SMTP id a640c23a62f3a-a89a35a1159mr1199033666b.17.1725468657240;
        Wed, 04 Sep 2024 09:50:57 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623a6dddsm13093966b.166.2024.09.04.09.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 09:50:56 -0700 (PDT)
Message-ID: <f7f69a3d-45cd-4d56-918e-572ad960c183@redhat.com>
Date: Wed, 4 Sep 2024 18:50:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] extcon: lc824206xa: Fix build error of
 POWER_SUPPLY_PROP_USB_TYPE
To: chanwoo@kernel.org, linux-kernel@vger.kernel.org
Cc: cw00.choi@samsung.com, myungjoo.ham@samsung.com,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20240904164325.48386-1-chanwoo@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240904164325.48386-1-chanwoo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/4/24 6:43 PM, chanwoo@kernel.org wrote:
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> commit 364ea7ccaef9("power: supply: Change usb_types from an array into a
> bitmask") changes usb_types from an array into a bitmask. Fix the build error of
> usb_types variables.
> 
> Link: https://lore.kernel.org/lkml/20240831142039.28830-7-hdegoede@redhat.com/
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks, patch looks good to me now:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
> Changes from v1
> - Update patch description with correct commit
> 
>  drivers/extcon/extcon-lc824206xa.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-lc824206xa.c b/drivers/extcon/extcon-lc824206xa.c
> index d58a2c369018..56938748aea8 100644
> --- a/drivers/extcon/extcon-lc824206xa.c
> +++ b/drivers/extcon/extcon-lc824206xa.c
> @@ -393,14 +393,6 @@ static int lc824206xa_psy_get_prop(struct power_supply *psy,
>  	return 0;
>  }
>  
> -static const enum power_supply_usb_type lc824206xa_psy_usb_types[] = {
> -	POWER_SUPPLY_USB_TYPE_SDP,
> -	POWER_SUPPLY_USB_TYPE_CDP,
> -	POWER_SUPPLY_USB_TYPE_DCP,
> -	POWER_SUPPLY_USB_TYPE_ACA,
> -	POWER_SUPPLY_USB_TYPE_UNKNOWN,
> -};
> -
>  static const enum power_supply_property lc824206xa_psy_props[] = {
>  	POWER_SUPPLY_PROP_ONLINE,
>  	POWER_SUPPLY_PROP_USB_TYPE,
> @@ -410,8 +402,11 @@ static const enum power_supply_property lc824206xa_psy_props[] = {
>  static const struct power_supply_desc lc824206xa_psy_desc = {
>  	.name = "lc824206xa-charger-detect",
>  	.type = POWER_SUPPLY_TYPE_USB,
> -	.usb_types = lc824206xa_psy_usb_types,
> -	.num_usb_types = ARRAY_SIZE(lc824206xa_psy_usb_types),
> +	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_SDP) |
> +		     BIT(POWER_SUPPLY_USB_TYPE_CDP) |
> +		     BIT(POWER_SUPPLY_USB_TYPE_DCP) |
> +		     BIT(POWER_SUPPLY_USB_TYPE_ACA) |
> +		     BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN),
>  	.properties = lc824206xa_psy_props,
>  	.num_properties = ARRAY_SIZE(lc824206xa_psy_props),
>  	.get_property = lc824206xa_psy_get_prop,


