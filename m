Return-Path: <linux-kernel+bounces-253540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221789322A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67A9BB22EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DCC195B33;
	Tue, 16 Jul 2024 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uda/4qg6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5947B197531
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121801; cv=none; b=gQZO+MXjBDQCxyAwbhLAhDH2YU19rvCWShPyIRVR924RLo7zZDx0+KcMKKIcNgeGo+AfJgjmmtwOYXySpSaXw1YESvvQALUm4cDUFEjElRdrn6cG3iky90DPhOhsC7aC5cmWBPiWO93xdZsxlIVbOZizQFT06FDPr3PgSzTULJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121801; c=relaxed/simple;
	bh=b+LcZOsf+EgRghjCEFoPbtWpwibpaIgxMtr9ZUJeKso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AwWSo8gQlPF08xlaU0uKJ9KGo8ql8jhapMswHIDfMGFXHhsMNHttGrqcZWWY/CQlccURvR+6Nd9pZITcmZR82TY/qasWcsJccWE3MhUpC5DTA77QV/bl1wa1JyO54sEsTvlI2YhuVfbTgFuiUBofq7tvF2pmBNCEt3kP4AHdBSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uda/4qg6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721121798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANugUyElPB5pizHI+f9eYrm0/ZuIW1EZlaT5lKQ6IBg=;
	b=Uda/4qg6iMgU5t68fXWORfodoGFD47xbFKQMWtaNHnzEX5SWVBpv7BDRyXqPQ30kHQdz5s
	pSFIU3/7xGnxy4QJt4UXTIGlSIxFYLbIMWTYb2p5JDS2octlX6mnc7o2oYaJm9jFPKVv4Q
	xPAkxgOEbeMGG2LVfag9PRUsVuhzLRM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-xeXvqAgVMcKtGyANL3s8gg-1; Tue, 16 Jul 2024 05:23:13 -0400
X-MC-Unique: xeXvqAgVMcKtGyANL3s8gg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a77f0eca759so397496066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721121792; x=1721726592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANugUyElPB5pizHI+f9eYrm0/ZuIW1EZlaT5lKQ6IBg=;
        b=pQLWRZDOGssRu3c/jzev/UJ1nmlgr/STAXn97jE9E1WhCVmJZLkkb8ZQrWHMP2OIzL
         fjkXonmDGLdcsrOCk7KdYrSCUMMnNwJ2UxSLo3y4BWpOof0gU+HszMJR8OVX0xw7Y2Po
         6KVoQ2g9cVIhV7uEfwmRIXPRvYe3itiFfMraRvlddF0eH8k+kOUMT3CypJr0gmEXGjTM
         5uk6Fw4VOOavP0MP+rcW2D69nK+sma/nkZO+VrkVALh9Oacllb1l1naUA6KLgl4mEP54
         nwfikrscTQ5c8oPYVXTl88LuldsaTdDpPjcbADag86YUO9V+razoOLEvnWf3NH1vIdB1
         jvxw==
X-Forwarded-Encrypted: i=1; AJvYcCUfY+SS2T7jH+GdpXtzootNDracXaEPRI6CPMNUwD47XrIt/fOImwIPu1ELHSC1bopRerUEE3G1pfe7ws0jsfYMeZSXQqsGdQNgXMEe
X-Gm-Message-State: AOJu0Yw/CAUwSuc1SDOlEdvI567tb22Yzl1Xu3wCSzW89zpBW0PtP6OY
	Sm48wbQqbiqLKVgcKM3p6+egQGUxAteUE3Fv521DXEU/ckGRcMptrnBUUmrf2eX/Vhc6yE0cmh5
	2Cs1s87E4JD+EOkODDffxtls8xT5lvMXf+fjKrhhb+TVUvlKzhsjhlW4LQGdncw==
X-Received: by 2002:a17:906:1404:b0:a77:d52d:5c5f with SMTP id a640c23a62f3a-a79eaa304eamr102961666b.51.1721121792227;
        Tue, 16 Jul 2024 02:23:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVz6JIXFqEyDm1+K7DeOOJfZVTR0GwzFW7oY2oLmv2b5C9AII8aCAGaGqI0KbiKUrn3kFMPA==
X-Received: by 2002:a17:906:1404:b0:a77:d52d:5c5f with SMTP id a640c23a62f3a-a79eaa304eamr102960866b.51.1721121791895;
        Tue, 16 Jul 2024 02:23:11 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5e8609sm288336866b.94.2024.07.16.02.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 02:23:11 -0700 (PDT)
Message-ID: <3171ddf0-0228-48e6-8351-f4a9e56b11a3@redhat.com>
Date: Tue, 16 Jul 2024 11:23:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] platform/x86: asus-wmi: fix TUF laptop RGB variant
To: "Luke D. Jones" <luke@ljones.dev>, platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, Denis Benato <benato.denis96@gmail.com>
References: <20240716011130.17464-1-luke@ljones.dev>
 <20240716011130.17464-2-luke@ljones.dev>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240716011130.17464-2-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/16/24 3:11 AM, Luke D. Jones wrote:
> In kbd_rgb_mode_store the dev_get_drvdata() call was assuming the device
> data was asus_wmi when it was actually led_classdev.
> 
> This patch corrects this by making the correct chain of calls to get the
> asus_wmi driver data.
> 
> Fixes: ae834a549ec1 ("platform/x86: asus-wmi: add support variant of TUF RGB")
> Tested-by: Denis Benato <benato.denis96@gmail.com>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/platform/x86/asus-wmi.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 7d87ff68f418..2b968003cb9b 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -906,10 +906,14 @@ static ssize_t kbd_rgb_mode_store(struct device *dev,
>  				 struct device_attribute *attr,
>  				 const char *buf, size_t count)
>  {
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
>  	u32 cmd, mode, r, g, b, speed;
> +	struct led_classdev *led;
> +	struct asus_wmi *asus;
>  	int err;
>  
> +	led = dev_get_drvdata(dev);
> +	asus = container_of(led, struct asus_wmi, kbd_led);
> +
>  	if (sscanf(buf, "%d %d %d %d %d %d", &cmd, &mode, &r, &g, &b, &speed) != 6)
>  		return -EINVAL;
>  


