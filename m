Return-Path: <linux-kernel+bounces-284925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 937C09506EB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C631C2295A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EED19D074;
	Tue, 13 Aug 2024 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXBUM+8v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D5E19CD1E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723557273; cv=none; b=DyqlKoYPEfgs6mPtdKMTF7ntuunWGLUDLNU3rYmXrQscsXI5/90SML+qU5VMrR2NzwLEpXtCxPqFkxZ+yjqiHGN/FbYY0QJG36jrDmqMfNl9O4FJSKtLUFtRzVYU5ttjKLJZ17/hKY7qyoKeCN/cAlQIhofRasr1nG9k5aQINyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723557273; c=relaxed/simple;
	bh=VXxCCJXPNv8rAnDPDBR/EdsEcMV2Jfe8Wu2+Nlrny5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UC+J70vqY5V//ei1IFmarOPvPRZGVaLks6+1JsKTXzFLmX7qcJNeoSJ/fzPgJW3kg8VKWW7/pBJZT6FzhhygzdtfM0AJiRyMNTSjM5eyAhgUCBLnNsd7l9jKaIiE6eaQ74/yNw+AEEtHiGKzbzVnqcao6wUyGzU1yrCw3iOS8Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GXBUM+8v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723557270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftSvgbnin9t8+uyc0Qyra1ua6IsRzeg+RnvJFpXFr3Q=;
	b=GXBUM+8vHbhpyoHmQgjnBGUVUmbk4i07PHTzIo8aQK5kvqCojd5LgiouFrNPuaj79mB6oF
	Kf48muJoz6/ug4NGYyTn0MbTnZ0/w6ZteU2jALFSuurTGSk5PgSKBeNg7GKZVmbSI1U71o
	FNZl0VSWXO4x10OcBiEc0/e++G01ww0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-hr4vTleQM9CioUgZFzc2sA-1; Tue, 13 Aug 2024 09:54:27 -0400
X-MC-Unique: hr4vTleQM9CioUgZFzc2sA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42818ae1a68so10508765e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723557265; x=1724162065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftSvgbnin9t8+uyc0Qyra1ua6IsRzeg+RnvJFpXFr3Q=;
        b=T9lHxFVJIQ50kNq28jKA1HWlvg1JmLl8uBMACxxr7FOB0nlV+IFqQUjR6y79CCedtr
         Y5IByYoytUJUXTF2NA3LN07r8vr8t8wfjiZ67ERRdC3YIqhCGK+Q36bMTJ73GRMLa9dW
         YjLy1lQFCvrzL6UiafqE/5xbT9EIgf5xt5lFhH1hLUDWlTg8ml7FWdyreMk+0llKCpPz
         YUT4rfIiLFYgQbz+R2Rzy3v9Xenw4OleWe+2uPOsGvsrnTNeh8ZYvEgz29lzf82pQlXd
         no79dSYSCC2IPyvlqcQ0Poluga59GZqO3VuYX7QdwxzZAMBYog7Bt7qoWs69gCdZ9Al7
         o7ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrxAOT2ELjHr7Hi3tRKcsQzP9AHqmFbg43ZxlSipPoQfJOcFbK95XhQekNU/z+ZVNUlwHGJEU5GrwUK7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf2HN6TC9vvd2I+uC3kqJj6kXxas6r560GAJYpqVsyi2VDjsBS
	zGjoeYLHP73s/K2dhNSYsqQSqf7210oiA+hwXUgbtBhjJEA1aieutauXDrjecTjzffsUglrTLF7
	yD8krKPGSIMwTLQJJzcsl5ZJwNgsWFfFoDq1hJWplIZh4pRx39+LF8y8vpvTvnQ==
X-Received: by 2002:a5d:64e7:0:b0:368:4c5:12ec with SMTP id ffacd0b85a97d-3717028178fmr1083054f8f.8.1723557265263;
        Tue, 13 Aug 2024 06:54:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkGXvuWmr9Mw17RK3kt8FwYNiZEJrqhn5ZvawfheaNNHSvSGHpYTP6xuawTq17tPof0GuX2Q==
X-Received: by 2002:a5d:64e7:0:b0:368:4c5:12ec with SMTP id ffacd0b85a97d-3717028178fmr1083037f8f.8.1723557264732;
        Tue, 13 Aug 2024 06:54:24 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1708:9110::f71? ([2a0d:3344:1708:9110::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51eb47sm10459247f8f.88.2024.08.13.06.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 06:54:24 -0700 (PDT)
Message-ID: <8dfa7ffb-f40b-452c-9c3e-6bb500e1a46a@redhat.com>
Date: Tue, 13 Aug 2024 15:54:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: dsa: microchip: Add KSZ8895/KSZ8864
 switch support
To: Tristram.Ha@microchip.com, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240809212142.3575-1-Tristram.Ha@microchip.com>
 <20240809212142.3575-3-Tristram.Ha@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240809212142.3575-3-Tristram.Ha@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 23:21, Tristram.Ha@microchip.com wrote:
> @@ -542,11 +545,11 @@ static int ksz8_r_sta_mac_table(struct ksz_device *dev, u16 addr,
>   			shifts[STATIC_MAC_FWD_PORTS];
>   	alu->is_override = (data_hi & masks[STATIC_MAC_TABLE_OVERRIDE]) ? 1 : 0;
>   
> -	/* KSZ8795 family switches have STATIC_MAC_TABLE_USE_FID and
> +	/* KSZ8795/KSZ8895 family switches have STATIC_MAC_TABLE_USE_FID and
>   	 * STATIC_MAC_TABLE_FID definitions off by 1 when doing read on the
>   	 * static MAC table compared to doing write.
>   	 */
> -	if (ksz_is_ksz87xx(dev))
> +	if (!ksz_is_ksz88x3(dev))

I think that for consistency and readability the above should be:

	if (ksz_is_ksz87xx(dev) || ksz_is_8895_family(dev))

Thanks,

Paolo


