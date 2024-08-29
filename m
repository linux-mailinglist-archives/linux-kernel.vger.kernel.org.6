Return-Path: <linux-kernel+bounces-307438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1F6964D99
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570F51C2230C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A3C1B86C0;
	Thu, 29 Aug 2024 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuOWmhFb"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EB8198E75
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955764; cv=none; b=q7nRiD6PpA6F0+vw/B6yeiv1C1TssoYmr9z1p9/kL/XPlsWcVMw+UlUBW2rd4c/PJTqxGxM59+uY8UO0C+GE/4Cnbf1Y+lB/ztRcyXVnthreKGGB61qzaHfN1QINE02BPCoH5n2lSoYWPH9FSZCvgp8i2SPK3hWeA26EaWrsHBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955764; c=relaxed/simple;
	bh=EdRezSjvoAtG58LxdU0dSUr18k/NbN9lOQ5debIepA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R7WWgvGm+a/kWRpqjF5CZhtsaUzVvatRLcenIicZGeaWTVhboAgJdw/1V73twyxnYEVrlCWJo+MwaO9NsC3ij1Ti7cy+Ko+JZ36Q8yoSxsxNL2bUbmW1CnAt2cuysF5K3uTwLDLc2r80capRBiOLqgY1BQuWfEu10kJyL9Gttog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuOWmhFb; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a83562f9be9so115543066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724955762; x=1725560562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M5+cpBem0eisErPmZiRKMOQLcSQZBq+r0irTvKnUIhU=;
        b=JuOWmhFb34HXUtu5U5h3a6lz85uWXajikUPFucCuTsGpnbE5kc1n5B5a9siyv4hA/+
         4LGv7PbwzWBMQhQhiNhHG0mKgCnQNe7OHaAQNrZhYVcQgIrMtOyuKe9rIMPeb41AU7qg
         qIllIOCDNT3QxY2fR97b6AnzeTrjkXuZ+Dcz/g6UF2tpM1ilO+vtg08qZjR/yP0CBbpK
         kC/YF8jinIC9R55bwCTE1tjfFhkxQ1ekxL8yWwJZQrM4OLB7vn+gNJtsKbYCS3D4BLXM
         C0wEKL2bH1Kqd3rXvlGuAPuLXRPAHTUUWctWGbfPO/tPnrOF3eEfmuZQXOUf6/osgAVn
         IdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724955762; x=1725560562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5+cpBem0eisErPmZiRKMOQLcSQZBq+r0irTvKnUIhU=;
        b=umWr1c5xp/K5wM96VAXU07EFz/BktG/oLEsr6qw/1LrhFHHGkhPwdsHKc/IxBwp3KP
         9wo8QmoMWPgJ/2OaliF+Do6UThLgSlxe4uN8Tym4o2Qrm1uuOZtXOv6OZKGebUedNyNR
         LGVpXDRj+qGiUupUa6hl380538e73o0nc+wczIm+Nd7AQmfqrKCoo2mCN7X+HV4BcCti
         yNTXts9UYITqMVZ3IL8yO8hTF5TSJ6PPnVKeSDN4adP0P4cIc8KFxU98F83g8MiXhSTq
         ppxPUhixRNMSaUm0DuZaGJd7AJUKCFqf8VHPPZod68SQQh6N4M01JqSPENPgmOLwJD5E
         r/DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdSRddXuU/hmu6BacjovICizpvR1jXJNCu8/swy/hJuCHszjml0xmWmBpZhplhXV8BHhsnNZ6bU0vLe2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5r0UnFmLuHnwCSIOJg5jAxQ/jxFYP2m5cFtDaI+RVQdx8NIJd
	s6azgkm09n6IsdF9wmljTbvtp1DzWELG2x2DVlSed5JNSalkzxE+
X-Google-Smtp-Source: AGHT+IFbY9vzwDNgQhEOwDhJKdStZC58QmdTc4mRGUxHrxcpQTg9GSjmUTPlBm+qE6BKB0nNEPkPnw==
X-Received: by 2002:a17:907:3ea2:b0:a75:23bb:6087 with SMTP id a640c23a62f3a-a897f8bce19mr339988066b.29.1724955761281;
        Thu, 29 Aug 2024 11:22:41 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8508:ea23:888c:e220:647c? (p200300c78f2a8508ea23888ce220647c.dip0.t-ipconnect.de. [2003:c7:8f2a:8508:ea23:888c:e220:647c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89892225dcsm105961066b.208.2024.08.29.11.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 11:22:41 -0700 (PDT)
Message-ID: <486ebba1-751d-403b-a686-e5cfa31e132d@gmail.com>
Date: Thu, 29 Aug 2024 20:22:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: rtl8192e: Fix Assignment operator '=' in
 rtl_wx.c
To: Alien Wesley <alienwesley51@gmail.com>, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 ~lkcamp/patches@lists.sr.ht
References: <20240829123251.83574-1-alienwesley51@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240829123251.83574-1-alienwesley51@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 14:32, Alien Wesley wrote:
> Separated assignments for pairwise_key_type and group_key_type
> in order to silence the following checkpatch warning.
> 
> CHECK: Assignment operator '=' should be on the previous line.
> 
> Signed-off-by: Alien Wesley <alienwesley51@gmail.com>
> ---
> v2: Line number removed from subject
> ---
>   drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> index 47f1adf30ab4..2d42e7a5bcdb 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> @@ -677,8 +677,8 @@ static int _rtl92e_wx_set_encode_ext(struct net_device *dev,
>   
>   		if ((encoding->flags & IW_ENCODE_DISABLED) ||
>   		    ext->alg == IW_ENCODE_ALG_NONE) {
> -			ieee->pairwise_key_type = ieee->group_key_type
> -						= KEY_TYPE_NA;
> +			ieee->pairwise_key_type = KEY_TYPE_NA;
> +			ieee->group_key_type = KEY_TYPE_NA;
>   			rtl92e_cam_reset(dev);
>   			memset(priv->rtllib->swcamtable, 0,
>   			       sizeof(struct sw_cam_table) * 32);

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

