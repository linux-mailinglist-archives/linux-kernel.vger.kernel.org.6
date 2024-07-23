Return-Path: <linux-kernel+bounces-259839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC825939E05
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6CC1F2272A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F1014D439;
	Tue, 23 Jul 2024 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrEa9IF4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D42B14D2A8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721727506; cv=none; b=Y6n6xawlxhjHtH8QLf6VSTgHzSOT0lvV9J2DWolUCaC9Wtrp89gMiEmQhDBO1Z+qNlI7w7T6sFfmeSFoKP2eLvNor6d1BiUCm4HGYbg00xcXiGgBtb1/xmzswjd+Aluuryhq3iXLJLaEXl7hxcYi+B+d1Z4rLBhaLrT5UQCWjYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721727506; c=relaxed/simple;
	bh=qi1U91OHpmnZJssEm2/ypmTtBAiRYwVO8jtb7pd6rvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2k8dQWWEBaNcBaWm+u1Wt573sce71jSMliaBB4fFvW7bbU8ScQyC3EUY0E/6nNSNDoWkDbCldcWcgsjubLyq9/qU5POhJJVf6XrpsDrDAxkj9pesWyUiWRI2XfOuDW00YJWa/yZRVxy9rRuQwHXH0u9/eKXequdshRg+TuIxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OrEa9IF4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721727503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpS43/XZvd0F+qWhTK9rMYXMOwLc+s9XDg94VmWtwJU=;
	b=OrEa9IF4dJqaWZEKPyhm1b9UUhNXb2mDO8Bp95GSZs/o3p78+4vnbSJHCLtAHIVohTr8n9
	V8looN74BVhycS3r2gUJVCsF4n2w5+cmCp//vsAqXpVOCYOJGjbJyg0uwQrEMae8eC1rJb
	WgYG1LigYTn8ntg/DOvzBkeARL6ifHA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-QfHqkp7PPMKJaL4IvNG6Kw-1; Tue, 23 Jul 2024 05:38:19 -0400
X-MC-Unique: QfHqkp7PPMKJaL4IvNG6Kw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3685b7bff66so686426f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 02:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721727498; x=1722332298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpS43/XZvd0F+qWhTK9rMYXMOwLc+s9XDg94VmWtwJU=;
        b=vEG4JzqYGzsvjsYG8m9kn72/KC1JQlxmTcSB4TpxRA+SxlMGKE5y8tq6kGrak5JsVl
         wYrzCA1Xwjcxy3llEtkAxCfwGx5orwWV/EG/tCLyij5JxHlSh22OT2mmiPEZmXzZmMYi
         ss5g+5nHTNM5Lldchc7s9qd5t0uEAiefgT9pRX1TbFMFbhU3T4Cm8cn2oytlx/sT3ots
         XXJqiSA6t1MJXCDW8gHI9zQWdHNF0qdr1tvqce6ULFiKJ3YKD6U/T/Tjlnr93M95PLKX
         ZWQmDei2bnNW6vRjXlGKll0ry2TMwL9BC3liVzxhqUuFthusRNU6UkNOBTbvYbEYhZFi
         JMGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQaM6Dy+rZJoaD/aEbPxiFrw81BTtS8whlKOv2hkheLSfXcR+++/AVCU0LvloIFY+pFDdBeyGeqXPOc/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8c27zYCstbRNY0A+sp22gj+Emwr5c5NIQH833amFE+NPnfAZK
	gRjDpkqFfZ3rGX2humOM83W9rCRWd4TJWYKGhbEyurIJ5QcPgDnsjd4hPgibsFKO9sHJ4GGTZQu
	RMbLeTY8h6ltw7KX/P8pFhrDIi94MPoPSWsX6P9km07Ow5bQxfQZ9PW2S9LBm/g==
X-Received: by 2002:a05:600c:35cf:b0:427:9f6f:9c00 with SMTP id 5b1f17b1804b1-427daa928admr45701015e9.6.1721727497970;
        Tue, 23 Jul 2024 02:38:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhM4uOFxMDco1bb25xqWFLK8WcRMoSn2Z6vzwdkNy8MM3JEf6KEfSsox257uyK8/FDBGMvkw==
X-Received: by 2002:a05:600c:35cf:b0:427:9f6f:9c00 with SMTP id 5b1f17b1804b1-427daa928admr45700895e9.6.1721727497551;
        Tue, 23 Jul 2024 02:38:17 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:173f:4f10::f71? ([2a0d:3344:173f:4f10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a724fasm188539965e9.26.2024.07.23.02.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 02:38:16 -0700 (PDT)
Message-ID: <1fa043fa-2406-452d-8078-636679428a1a@redhat.com>
Date: Tue, 23 Jul 2024 11:38:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH net] net: phy: aquantia: only poll GLOBAL_CFG
 registers on aqr113c and aqr115c
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>
References: <20240718145747.131318-1-brgl@bgdev.pl>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240718145747.131318-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/24 16:57, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Commit 708405f3e56e ("net: phy: aquantia: wait for the GLOBAL_CFG to
> start returning real values") introduced a workaround for an issue
> observed on aqr115c. However there were never any reports of it
> happening on other models and the workaround has been reported to cause
> and issue on aqr113c (and it may cause the same on any other model not
> supporting 10M mode).
> 
> Let's limit the impact of the workaround to aqr113c and aqr115c and poll

AFAICS this patch also affect aqr113, I guess the commit message should 
be updated accordingly.

[...]
> @@ -708,6 +702,25 @@ static int aqr107_fill_interface_modes(struct phy_device *phydev)
>   	return 0;
>   }
>   
> +static int aqr113c_fill_interface_modes(struct phy_device *phydev)
> +{
> +	int val, ret;
> +
> +	/* It's been observed on some models that - when coming out of suspend
> +	 * - the FW signals that the PHY is ready but the GLOBAL_CFG registers
> +	 * continue on returning zeroes for some time. Let's poll the 10M

Please address the typo above as noted by Antoine.

Thanks!

Paolo


