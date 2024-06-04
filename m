Return-Path: <linux-kernel+bounces-200817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7788FB547
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B991F21E07
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0978413A3F7;
	Tue,  4 Jun 2024 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FnGAeiu2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A06C8C7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511475; cv=none; b=dCIuFBXWKeQ91YjsjauxZTZNv8Hz98O4FPznLtUtUZ5BAEiXxAbbm8RdcVfqZ3hPGnaQcULxuwrMzp7QtEhuLMVjRTY1hgGz6h1nY8jJVe03sCelKfT43Ncm2mefEv46dqwxtE08/wo9Ms6cG772hmQiwQeYw0f7vWmxoX6JTco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511475; c=relaxed/simple;
	bh=wyePXwAxkMqCXIcx+41jHRC/gZYDXyThMt5kNSMQuZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNkSrTkzDhnLi2MrpNChgfAQrVb+59eL0nwCyxWEPcQyzVwryW2pUCr3wfDdiPNwYwGdWKfHn83PTYV1dJkf4DCLO39k+rp9xybEAKBhF/wsUvkD4vvoSzDb3J4E6q13CPQu+1V+FvZR5tGK9kA6Vgahugb7kOXv9cPBsYPCpcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FnGAeiu2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717511472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzSWB1uu8SnFXUqQQbZ1ZdBme8dM2DhgxeTgLVp11LI=;
	b=FnGAeiu2b0kd7cpv+1+dL+GKz/zdv8QG3YYL1wV9+V5cw2YbV7zGgD7UdwYz7QcSubIOtL
	OanDNIMKqOxZRPOpM6zcG93oDdIcaBFGQ7u+q27EtMjCbLP8OxL77bsNzu7iOO9NjK3ZQY
	yDdqE/ddDOUhu8B1dh7VXjfz+areulA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-cQT_CUcOPXG0o_JYYOPp0g-1; Tue, 04 Jun 2024 10:31:11 -0400
X-MC-Unique: cQT_CUcOPXG0o_JYYOPp0g-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-57851ae6090so2328648a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 07:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717511469; x=1718116269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzSWB1uu8SnFXUqQQbZ1ZdBme8dM2DhgxeTgLVp11LI=;
        b=dpIuuxJMPYE0jmaiMsEcMfwo4djtKpMHHS7Ce7OB5jhX/Z7ON8tasW3UgE+y20FBxl
         LT9ROGkzHdrFlqtrxIk1lvWl+9rFE+hmrsqeduLXWrvONidzCv3jRVoLQjJQkP85D9m/
         ohRDr8mog36PRT82qsUHqtzGgbGr6e5TB9j3atcu4LXdhQrMDtv6/W/qgSKhEBD9yv1F
         R1I/FAGYhq+Po/Amqg27xpAdydnKsUEJcL9CNMMteGnXx2NIGoCmQ7b1iGgn/Xq05Yhi
         yz234wpJBk1/ZQ46ZZSlBv1j/oxyW0MvqOjcZkMf2iu4Odtv5de2iYhjT3+nYdYR0a3f
         Z9Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVDwxfExLXlBWEKVvS2XEqb4dXxifLV97+wFaoz8fFH38D1U9GlsSwgMJt6720zdWmUpmDiHaFmciiVe7UbSEpZ1Z0HTa2XKlsnT7eA
X-Gm-Message-State: AOJu0Yx3LFJykOFJHKgsHDkDiO0q0ScP26Rh7AsRnWe1w83nZ2V1bkRU
	E/HarCLFXhzUAFPHwz0nJ0wVKOreIeGgGYXU3sr9O8frugL5TY05ErIDtZyVkr2orgjfuP4dW6u
	5m5AXY+dByD6pDO42RebZbfUa7c0mOX0DZKRzh5meyx0P3lIe41nKPNVdAHkasA==
X-Received: by 2002:a50:f616:0:b0:572:4041:5637 with SMTP id 4fb4d7f45d1cf-57a3638f302mr7897275a12.19.1717511468897;
        Tue, 04 Jun 2024 07:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKz9ykShYqx98nKzJWNWXfA6S3FKbkIGe+3J3S5MNrtNmnUpiyilWNsHcrQEEB+GSK2sKi9g==
X-Received: by 2002:a50:f616:0:b0:572:4041:5637 with SMTP id 4fb4d7f45d1cf-57a3638f302mr7897258a12.19.1717511468461;
        Tue, 04 Jun 2024 07:31:08 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:e7a9:b143:57e6:261b? (2001-1c00-2a07-3a01-e7a9-b143-57e6-261b.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:e7a9:b143:57e6:261b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a66ed0d68sm3377025a12.63.2024.06.04.07.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 07:31:08 -0700 (PDT)
Message-ID: <85109720-0d0e-4c35-8cf5-02d8c883f13a@redhat.com>
Date: Tue, 4 Jun 2024 16:31:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: letsketch: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20240604-md-hid-letsketch-v1-1-ff38ae7b4cb0@quicinc.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240604-md-hid-letsketch-v1-1-ff38ae7b4cb0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/4/24 4:20 PM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-letsketch.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/hid/hid-letsketch.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-letsketch.c b/drivers/hid/hid-letsketch.c
> index 97f047f18136..229820fda960 100644
> --- a/drivers/hid/hid-letsketch.c
> +++ b/drivers/hid/hid-letsketch.c
> @@ -319,4 +319,5 @@ static struct hid_driver letsketch_driver = {
>  module_hid_driver(letsketch_driver);
>  
>  MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
> +MODULE_DESCRIPTION("Driver for the LetSketch / VSON WP9620N drawing tablet");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
> change-id: 20240604-md-hid-letsketch-53206a0faa79
> 


