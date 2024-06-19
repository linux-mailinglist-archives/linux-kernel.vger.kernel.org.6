Return-Path: <linux-kernel+bounces-221577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8331E90F5A7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 20:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376261F23CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D21A156F28;
	Wed, 19 Jun 2024 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="q87rSGWu"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B48156C70
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718820092; cv=none; b=Q3CfDSpWo20VA0yb2LEAFoljroyRKssA9Iow6A9mBC7WxO8iX78nNFWA87TwZMKRlwjbFpmvWQM0XEtMeqJBVfpk4Hq4w5H35BwcQaAgzW2D7Bh3gqQsmgeXQo9eaef9AwWtfqXzfox75t+QPpwt5asbtmuE4Gp1p17saPWJz2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718820092; c=relaxed/simple;
	bh=U7C+pEi6igoYFQSptMMj84YTWs+bTPzv+WEqwzj88d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIkR+SpIQppatq6s59Xq77l2Mv7eGSKAAmTRhHmpaoSUG421aKGPe68D/XF5weEJ5yPQQ1jsmU3yY4PSUoLeZCYfQb6+KwyFziBEoCkSt297mfKWVaU5uhQC8x8+6FPTNRaGZL5c+VlW1pxWvzBZ3zt5pgkhAEhwyA6lZaoxm18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=q87rSGWu; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6e9a52a302dso7584a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718820090; x=1719424890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DR6ol/ebrMQTMKANWVsnvB318yzdm+hPLWyKxrfZLM4=;
        b=q87rSGWuEbzUX0bWUlq80v6eOae1T0/bHSHM35gt0OusR1q2fKH96SQAUvdXznsyKv
         zk8hFBuSqc7bghCVSd5vXzT+jlwfnPM5Q+msgRaWsDIaqAvjFC0dig5VpKtFYgxlIfZa
         fxh2zgUqqTmo1Y4mRqhz2oyf8TiIoZFgA1jbAm+Ww/VhcGBfrx8NfENb8gKo1VaL7rN9
         BfvYBQNl9FqLrKrJCetlwD3SQifBZnpzUT2zZF69IAgvG/2MKaDiyUDAcaCzVhkjdVja
         n6rQkcjaY/nqTcULqG0lyv7LLLcX9nAT1GtStjGOcQg/BcgI7S5ESZoGkOjfdvw6+1Nm
         SP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718820090; x=1719424890;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DR6ol/ebrMQTMKANWVsnvB318yzdm+hPLWyKxrfZLM4=;
        b=wRAfzzX9ElKJK+mDZsvPu6e8QfpZoXWZFxL4WLdlDuIWbL6qCXqx+mwAViv7Nih72V
         8nFwgkb0B6ZqoWezkn4YpMl3a3sLELBr15pxPE6w8c+dYPA4fUeHFn8oU5XbEMwvGBEk
         GxaO+I5OoLO0OttX66HJyWmnwCpsRoaAoLjao95Xsj/YMxVbUIw9Hv1OR5C4PRRjdJiB
         sTnoUeMKr8dkkOG+qAKYFMUU9Cqyi3d8aJpZJ/MPxCcAJC3xBiXInUuHPGqeLkAEiJWK
         q8Old7PDFl++vf0c37CKrlqY09X2Y5pmmYB1i20xYmqlITInr4Og+3lDlo2rFM7L0FSA
         CzcA==
X-Forwarded-Encrypted: i=1; AJvYcCVDcm6E3EW5KD34apGRTQzwrms7YyL4vcaN1696ERlci6wK5B947XofrWRy9pV0Nijy+MIh/hlYOlElR02rSTtgsObRYJQN0SvGRIcN
X-Gm-Message-State: AOJu0YxPsAsdKN6yTjO5Tf5Nvhkt200B2Q2nHhQ7LxvDhP1lD2os/d4K
	oDJ4xlUYexoOPirHB0jB6RnQbM8wW1hln8LXYAnAUtqEpl9YM4NPpeVg/dXQkktmKH+SWboHY6D
	8
X-Google-Smtp-Source: AGHT+IHcDic2Ne3X7+KX0Ua1mWJJW8TdCvFwCTN53gWfKbBnaUDJDqn5D3CPdvrf3jUHKbtBAwA4Zw==
X-Received: by 2002:a05:6a00:1782:b0:704:23c3:5f8a with SMTP id d2e1a72fcca58-70629c13833mr3474862b3a.1.1718820089130;
        Wed, 19 Jun 2024 11:01:29 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-70dbae52920sm3251833a12.42.2024.06.19.11.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 11:01:28 -0700 (PDT)
Message-ID: <3d984bc3-71d0-4ee6-843f-8cc47a90de2b@kernel.dk>
Date: Wed, 19 Jun 2024 12:01:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zram: Replace bit spinlocks with spinlock_t for
 PREEMPT_RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mike Galbraith <umgwanakikbuti@gmail.com>, Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20240619150814.BRAvaziM@linutronix.de>
 <51f64ee9-35fb-482e-aa50-e2a446dcd972@kernel.dk>
 <20240619175249.lK51lGOx@linutronix.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240619175249.lK51lGOx@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 11:52 AM, Sebastian Andrzej Siewior wrote:
> On 2024-06-19 11:34:23 [-0600], Jens Axboe wrote:
>> On 6/19/24 9:08 AM, Sebastian Andrzej Siewior wrote:
>>> From: Mike Galbraith <umgwanakikbuti@gmail.com>
>>>
>>> The bit spinlock disables preemption. The spinlock_t lock becomes a sleeping
>>> lock on PREEMPT_RT and it can not be acquired in this context. In this locked
>>> section, zs_free() acquires a zs_pool::lock, and there is access to
>>> zram::wb_limit_lock.
>>>
>>> Use a spinlock_t on PREEMPT_RT for locking and set/ clear ZRAM_LOCK bit after
>>> the lock has been acquired/ dropped.
>>
>> The conditional code depending on CONFIG_PREEMPT_RT is nasty. Why not
>> just get rid of that and use the CONFIG_PREEMPT_RT variants for
>> everything? They are either good enough to work well in general, or it
>> should be redone such that it is.
> 
> That would increase the struct size with lockdep for !RT. But it is
> probably not a concern. Also other bits (besides ZRAM_LOCK) can not be
> added but that wasn't needed in the last few years.

Yeah I really don't think anyone cares about the struct size when
PROVE_LOCKING is on...

-- 
Jens Axboe


