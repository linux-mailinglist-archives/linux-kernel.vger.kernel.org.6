Return-Path: <linux-kernel+bounces-319206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C750896F945
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4174B1C21C3C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A285D1D363C;
	Fri,  6 Sep 2024 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJOADixo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999AD374F1
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640161; cv=none; b=mB1JaVPkYSEPkyAnSodZsEERIEE7wILuuZcbITAQzdS+jknp+CgkuP4sy34mUPuyYFpQPGiyJa5rC1WwBbHkFYDE740XCws3haUevPBocKDX6YIeyZIzU0+qYMyyeLcWd4gZi4GnPnWif/sbkiQLb5D3ayJ0v0Um5EXBItmlbPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640161; c=relaxed/simple;
	bh=zL1hQBAwH9cjTxb30JMyPPh4ASwEHc17U1m2yvqJP8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z6nTUTb71YUt+WHVnZGoVTG0OAajrTonvdWXnvTJk2x+l6d0XyMtMBJTVGFjHPdHkYveCAt+EVvoSyR4wHq9s7uAnMrTvO0NPkCk8y0ZXedFmkTS/GvI8FZWJhSlueQoM7E1+LOOyBKg+WqbwIMjpVX3/r7a7PKgrtFuZyOL0LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJOADixo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725640158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTF/nKjKqx3JSmZJNOkT6LhQPRYiMBga9bgFVidxPTg=;
	b=BJOADixo8v4yRlf/rbFYDri9kkRtG+04fP5F+FiMaeZuy6xhLAjzyIguh/dpTF74rMU82t
	9ad16RjvbnHiybq5ZjxaesHJcNKaF+mroU2R/fDK3+nCPkrpNL3okq9jXFupvMlXptvHlq
	j+LZhQfyaC6tYGwhCfK6skthxmF+T3U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-aoWscZadOnacfsmZqAG9gw-1; Fri, 06 Sep 2024 12:29:17 -0400
X-MC-Unique: aoWscZadOnacfsmZqAG9gw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42c7936e4ebso18064815e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 09:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725640156; x=1726244956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTF/nKjKqx3JSmZJNOkT6LhQPRYiMBga9bgFVidxPTg=;
        b=NqaEzm5Bf7BjJ159xOaNbxiEzhUt1oQ0TROVZFDYvlzjzCWu6KtLVlcIFVfVktj7wi
         YGIqwVuvcqmpM1/q548kKyXZ3yM2WXKqmxOLjFN6Fxyy//BSfQvN05S7e1N8El/K4b3p
         ZeH8S62Jl586Gdp6uR9440bMXbmLPo/EVY4rCON3pRnjnTsx1uOH89gUFp8X0N0M3vsK
         GLYYapr56crs6KtqfRf68xfCmFTWdwYwi1VDjdsmOb6Q7AN644fWetHz7TPfiMVDQdDq
         bFm12K/MzzLp6MS8L7VWBKdlRpNuVGqiy19xKo0rqSdKlk3WyFGxtZO5CFgBGMomKIAm
         eFxw==
X-Forwarded-Encrypted: i=1; AJvYcCVFIKUx2RAu/zvHP3d0CoMdWSeGFJh895nRXmdd0Zyhz0BL4DgL2G06OpseJswKT4yELQh026EXGnToh00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqcol53oAmLxiCmMjHxA8FZnHoKAqdrPBryoogYZGaprYS1eeQ
	LftMse/J7kFad08icgpo/ugiTfH70a5TZ0jME5l38CTL9IbMK2MtHV5V898hkCdBIqUenvOiXqI
	eo3PSXMJJiolYjC6ZUBg6ARO7c0of1OojAepZhCk4nRGjubiZ1tzBePLQ5BgSBg==
X-Received: by 2002:a05:600c:45d1:b0:426:5e91:391e with SMTP id 5b1f17b1804b1-42c9f9d6d1cmr24597865e9.26.1725640156045;
        Fri, 06 Sep 2024 09:29:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE01F8H/WdLhuKvK4CLUhFcSQZEx27sCPQ1eZjRPgcGIGX7GfL6OJuouynXnk+joG/+G2USSA==
X-Received: by 2002:a05:600c:45d1:b0:426:5e91:391e with SMTP id 5b1f17b1804b1-42c9f9d6d1cmr24597655e9.26.1725640155569;
        Fri, 06 Sep 2024 09:29:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cac8543dbsm3587525e9.42.2024.09.06.09.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 09:29:15 -0700 (PDT)
Message-ID: <c02de5fb-1daa-4afd-9887-96087ee4eb43@redhat.com>
Date: Fri, 6 Sep 2024 18:29:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] drm/log: Introduce a new boot logger to draw the
 kmsg on the screen
To: John Ogness <john.ogness@linutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Javier Martinez Canillas <javierm@redhat.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, Petr Mladek <pmladek@suse.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240801100640.462606-1-jfalempe@redhat.com>
 <20240801100640.462606-4-jfalempe@redhat.com>
 <87o76czfb2.fsf@jogness.linutronix.de>
 <d4412d54-41b1-4671-9733-34ba1423404c@redhat.com>
 <87zfpwxqpc.fsf@jogness.linutronix.de> <87a5gm2khw.fsf@jogness.linutronix.de>
 <a421b31b-53ad-4f56-88be-66a7d4c3bb61@redhat.com>
 <87seudchlu.fsf@jogness.linutronix.de> <87plphcgo2.fsf@jogness.linutronix.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <87plphcgo2.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/09/2024 10:47, John Ogness wrote:
> On 2024-09-06, John Ogness <john.ogness@linutronix.de> wrote:
>> Your device_lock()/device_unlock() callbacks probably just need to
>> lock/unlock your mutex @drm_log_lock.
> 
> Sorry, forgot to mention that the device_lock() callback must also
> disable migration. Since you are using a mutex, you will need to
> manually do that as well...
> 
> mutex_lock(&drm_log_lock);
> migrate_disable();

Thanks a lot, I've done most of the conversion, and it's already working 
great. I will send a new series next week.

Best regards,

-- 

Jocelyn


> 
> John
> 


