Return-Path: <linux-kernel+bounces-300592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5CF95E594
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 00:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6B41C209B8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 22:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC19276F17;
	Sun, 25 Aug 2024 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLEQaVok"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EED47A6A
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724625802; cv=none; b=qMWlerJwrbNp6APTQGUDUPuPbz0jlc0vSOK27ggihynV89Q/N4je5frdMYJPXD+hk9pEZznoJ1Nkr7vcQkq+I5hG1tXr3nzDvRXBuKFQlG2/2pNE1anphqdPbhSIhLdkq3xx49frQSdvMmal0zpvvSMci64p6uHS3a1fINehl+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724625802; c=relaxed/simple;
	bh=jngaTFMZPFu6vow30Ivlh/fYRC31JZ6x6YVe4xH7/qw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=YbmmRMR4ed+ZW2Emri0wYYxMe8qq/CwrnoCkwYxVHafGKRSCQR+jS05T7RekEHrHVq37PyC8ke6chIu2Ltl3cgfT36ya+ZBY9N1/A7V5F2cUvtqHgaXHAiTgwl2mhbuxzxO67/gc/+EXe84e5s3e2JZNsk1d163PlMXPVW7vtbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLEQaVok; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7142a93ea9cso2512970b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 15:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724625800; x=1725230600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9clC3OC/WS5+W1S9lzwSe4wn+WbVo8I74kkv+luY9g=;
        b=mLEQaVok3lgt7/C6cIIdTcDCZqWpepGtCP8SWC0aGSGGxk+MMoWl+ErSzOrO+t0cqW
         xib4za6zCUJNbFZJbiP9SH8oO1G6Z3vUz9ekEI2VWN0qWcVe95OTj++xKJoKteZJxZgQ
         3xJO166CSM4/hK1YrJPvLnzt2P9FhwyNPmhV8asORbGx09SQsrPT9P8JAkIC+uPP/tym
         GAowuOfQ9JpN5JIJ+ZatU9taeF2IsO2jjvTVG1fTcPzIagLbaCOGwg/fqli0aJUFB2t6
         ThDYP+s3ZGT48kZ3u2v8W7+EHU6J7yWe2BcCcH1u+WjbvQTYit61UeidCptJAHkrg16J
         5nYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724625800; x=1725230600;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9clC3OC/WS5+W1S9lzwSe4wn+WbVo8I74kkv+luY9g=;
        b=WWpBklqWgab1pr5VG2RUkBMG2bBBqre5z86ibPWRJ5c9RIWZWChqHsUpFDweekFyjA
         3L3Uwb9/DZZviWkmF0v4JRdBHDshMcwl1DFhuCGXuZzd8NXoAnmxFiDkq2/BQLmOPtfy
         faAvH78lmonzcHMi9DhI7RD3U5WGx85Hbahc5RVR+kmLRVYf365MLmMG/tb8zKn4agMj
         swXcI9bqNGTYbzy52+KQdfyjFiQisQAKxTZYONGY7Zvp84ywM+gNGaQEY8PBkmSmhyFO
         VEqrRonKB9/yNFRsQrgxH2Jj36u5EJWeoIO9atkclEkZrqImjb+cS6f/22hF2D6J6htA
         6mag==
X-Forwarded-Encrypted: i=1; AJvYcCWyYXzf2Wh4WzBCwgNxLDn3DjVQt8x/jRD5A2XCx29X8JmGd6ek+wbXbJTMf3PXVgsQU3mbFvrSA4EgIEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZS0ShoWog4I01aCrXThwkBAYLlafg+OhGq2AQbVfR72bmkLX3
	fiU6HgwX/cgsA986Q2TtV4P6pZE//ZVJXIwVxztUN2zNpfDoSc1+
X-Google-Smtp-Source: AGHT+IEh4IwWngx7WZaiCUY9uaLglxb6SYoHnJ7dMB74dC8VqAEV00ht36d3ocYW2SJlQeCM4oNJ8A==
X-Received: by 2002:a05:6a00:9148:b0:714:3153:ab4 with SMTP id d2e1a72fcca58-714458b7d29mr7845008b3a.27.1724625800095;
        Sun, 25 Aug 2024 15:43:20 -0700 (PDT)
Received: from ?IPV6:2804:868:d047:ced3:41fa:c7cf:e733:9f1d? ([2804:868:d047:ced3:41fa:c7cf:e733:9f1d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434236aeesm6062201b3a.30.2024.08.25.15.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 15:43:19 -0700 (PDT)
Message-ID: <324c34e3-3471-4cbe-aa6d-b14244ca48eb@gmail.com>
Date: Sun, 25 Aug 2024 19:43:16 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8192e: Fix multiple assignments in
 rtl_wx.c:529
From: Alien Wesley <alienwesley51@gmail.com>
To: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht
References: <20240825214612.49254-1-alienwesley51@gmail.com>
Content-Language: en-US, pt-BR
In-Reply-To: <20240825214612.49254-1-alienwesley51@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry folks, this was supposed to be a v2.
[PATCH v2] staging: rtl8192e: Fix multiple assignments in rtl_wx.c:529
> Separated assignments for pairwise_key_type and group_key_type
> in order to silence the following checkpatch warning.
>
> CHECK: multiple assignments should be avoided.
>
> ---
> Changes in v2:
>      - Removed two spaces in front of "=".
>
> Signed-off-by: Alien Wesley <alienwesley51@gmail.com>
> ---
>   drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> index 47f1adf30ab4..67c4793e0fc1 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> @@ -526,7 +526,7 @@ static int _rtl92e_wx_set_enc(struct net_device *dev,
>   	mutex_unlock(&priv->wx_mutex);
>   
>   	if (wrqu->encoding.flags & IW_ENCODE_DISABLED) {
> -		ieee->pairwise_key_type  = KEY_TYPE_NA;
> +		ieee->pairwise_key_type = KEY_TYPE_NA;
>   		ieee->group_key_type = KEY_TYPE_NA;
>   		rtl92e_cam_reset(dev);
>   		memset(priv->rtllib->swcamtable, 0,


