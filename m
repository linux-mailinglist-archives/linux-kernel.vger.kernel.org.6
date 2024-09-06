Return-Path: <linux-kernel+bounces-318378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575B296EC94
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9743BB21D79
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C355114AD3A;
	Fri,  6 Sep 2024 07:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7JGZger"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E16912EBDB
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 07:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725609203; cv=none; b=UQbmvRQFnuVIji2CeFArWdiP+ajo2hJFDOyEyqV7vEDSMWs9Q89ZcU5uPUAT0pDCtzq5JpJWDjCZIuAY378R5ofy4qz5M6vH3TemnpdB2EBWNAXTPlQQ9gTlIPMZ4FNxFdKCHooaYsF6/FeTpVn9E+2XShkiMjuzaVhRY4vfz+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725609203; c=relaxed/simple;
	bh=7qjZG9EDOOoqyEBA/4jjZCMd9X2HAUeybu3XiF7z1zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mUMy6aWCmu0o4SjqQOSzz5Qe6rxofDOBSPX0Wp48hU67f+eslq+lI+2L1PS2MYo+UxytCO3xW828l3Ynjni16BSIMzOFLmWLvb1fuWPebj0ZZ8N7EFqLJ2jMXMQsU0cyAsr+mz/JnEF/MkpQpfPfCOIszkCfdnxITPQJKIIaxzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V7JGZger; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725609200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EfrBxnrPzLfQTGlaHgnw9vHVUirecSOPfSNaim1PSDQ=;
	b=V7JGZgerA+LmkLAbx+VnygsWnFwHawWnYTG2fudOWW+jz3Bw61tlnFQQ9eefDd/18sPAnu
	vyUOH+fsXvZeTegXYjU1SKyGZ6EpEwVKtgnbRZRcv4nAKxs/q95xdkUEHza9cYdno8IF9f
	9QM07X3jo/kBAkbS/BH5dlSK5uKFYEQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-LkmGs2C0Mya9oVkMrfaNRg-1; Fri, 06 Sep 2024 03:53:19 -0400
X-MC-Unique: LkmGs2C0Mya9oVkMrfaNRg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-53658eafe8eso480619e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 00:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725609198; x=1726213998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfrBxnrPzLfQTGlaHgnw9vHVUirecSOPfSNaim1PSDQ=;
        b=Cb+6uaJepxdU+45jz6xQPBFiLzsjfxCF13aBGwel6K2nQOk6P2+Pu6IGcqGSc4CK2x
         ad+C3V4TmSl0x9ViJ1o4pQrZusR8OvhTqMinvTHVqluoNIdDEJkxCk6wkTuAx+bqaRvC
         D7ZBkg8uJjjplGfh5l8aYmxJ/6zvY/Tx+osSbbogKNyFes0dOHtBCCHfM3XnwUYLIKWq
         AWhq2542PKw9I5D4C+WGYKuHBvbzgBrCWZA6cEGCcTHQT72DPdqUphQJoONgYdFk06Iz
         yOfVmhLJHJ94OOCPEgOhOoYC0W/BMNray6EDFKA/TjuQiqVJYEeAUQuUWIwB/OKfVrpj
         QrxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoSsX9egkR4gh0lw2hR5sHOYBaz45cvtd5+8JgVHh+bywZIah3gQQWkqUL3jBvhkKBEV6ddTQ/5aOxO80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA9a1RiwI/AkdlBJ2Zra48gDg1OuLL2wo3cpeeyDrG8ic+LiHg
	6lJvJ+KxKTk9OB7FWLPc+2uFwqVK1PZC8OI5Dw4bkP8uPtmHOOjEfAQ9iBnL+YkXF6e4K1XdZ1P
	Tf5sjwYkEWZ1SEtjkLevT6M28IAkrUdE/p4BsiBZedFo2e1iD/XtlIL3fIT9g2Q==
X-Received: by 2002:a05:6512:10cf:b0:535:682a:b6c0 with SMTP id 2adb3069b0e04-5365881a531mr837728e87.61.1725609197610;
        Fri, 06 Sep 2024 00:53:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOLErZd8sK7pmLsqp9q/TRsiLkxNVpjYLAzoIT78SU68/uGnRWKBXr6Ut84g/XznDsuc7ZtA==
X-Received: by 2002:a05:6512:10cf:b0:535:682a:b6c0 with SMTP id 2adb3069b0e04-5365881a531mr837705e87.61.1725609197009;
        Fri, 06 Sep 2024 00:53:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca2cfc296sm5949135e9.36.2024.09.06.00.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 00:53:16 -0700 (PDT)
Message-ID: <a421b31b-53ad-4f56-88be-66a7d4c3bb61@redhat.com>
Date: Fri, 6 Sep 2024 09:53:15 +0200
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
 bluescreen_avenger@verizon.net, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240801100640.462606-1-jfalempe@redhat.com>
 <20240801100640.462606-4-jfalempe@redhat.com>
 <87o76czfb2.fsf@jogness.linutronix.de>
 <d4412d54-41b1-4671-9733-34ba1423404c@redhat.com>
 <87zfpwxqpc.fsf@jogness.linutronix.de> <87a5gm2khw.fsf@jogness.linutronix.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <87a5gm2khw.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/09/2024 17:22, John Ogness wrote:
> On 2024-08-01, John Ogness <john.ogness@linutronix.de> wrote:
>> On 2024-08-01, Jocelyn Falempe <jfalempe@redhat.com> wrote:
>>> I think I can also register one console for each drm driver, which
>>> will simplify drm_log even further. (currently it would mean having a
>>> circular buffer and work function for each driver which is a bit too
>>> much).
>>
>> Indeed.
>>
>>> Do you know if there is a chance to have write_thread() in 6.12 or
>>> 6.13 ?
> 
> FYI: The full NBCON API (with write_thread()) is now available in
> linux-next.
> 
> It would be great to see a version of drm_log that only implements
> write_thread() and does not do any of its own buffering with workqueue
> and also does not need to track multiple graphic loggers at the same
> time.

Thanks for the head-up.
I will rebase it on top of Linux-next, and adapt to the new 
write_thread() API, it should be much simpler.


I also need to adapt to the drm client rework 
(https://patchwork.freedesktop.org/series/137391/) so that it will be 
possible to choose on kernel command line between drm_log and fbdev 
emulation/fbcon.

Best regards,

-- 

Jocelyn

> 
> John Ogness
> 


