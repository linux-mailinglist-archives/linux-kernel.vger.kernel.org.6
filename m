Return-Path: <linux-kernel+bounces-271388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E509E944D78
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F88282832
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3DE1A38E7;
	Thu,  1 Aug 2024 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cq9+AXpy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD5C16EB57
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520339; cv=none; b=DRyzYummlqTiFOuliEF50vL5Xeq0V9e3qvLXq8KKN447kOdOI0NHu7tgGcVfOFubm7XGRjbPzSIIDLNdlAYxl1Tj0fjM9chVQ1HPU2CMSI7s3gS1vNnm0jniMTf+DHCRwzhiwwYskwAkk+hjhqjqsLc6RzBWztzRYUWYELh2Q5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520339; c=relaxed/simple;
	bh=RHCAEvU+qLJa+XG+OFQXDDhBRYJFqFnK5UxeTXMV6Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dCpNokEjCpPURKi0I7p432szMLGIIYTe3zhed51jb7wo8MOWDxS/hmTKcS+gln5k1T2Eu3hrTAX5efgKfgVJMzgKXoX/vzcv1aw/mb2LwRoqiyz/b28h+273AxNuttcqDu7RhYbMfqW867Ms8O7ff3Xb4mgvCXQW9nwyE3nbG1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cq9+AXpy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722520336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hd+rnQJd3iP+kYdmOOscahOzGscif18AjgksANysyBg=;
	b=cq9+AXpy7GIHo5vivoeYgdpdF36rBoE4HG+V/UwH/mXkTVkP1TxzlYDwD14DOVYqPWuAtN
	GLNvGBgwAJQnRVyOv5KB6UEklBgoiWytSO/al3K/gPzt8jyG2Rx6TURF9qYzkvVn52zARB
	lJgLFIFmRmgp4JZtrqCqwNHGwlCmtIE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-bBT6j6PJOHq9OxfQWpPygw-1; Thu, 01 Aug 2024 09:52:15 -0400
X-MC-Unique: bBT6j6PJOHq9OxfQWpPygw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428040f49f9so41545765e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 06:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722520334; x=1723125134;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hd+rnQJd3iP+kYdmOOscahOzGscif18AjgksANysyBg=;
        b=QKlW7921y3DSdWlOVRHbZxxnFHa8ociLPQkP4blILDP5UU+D7L/07e6P76ipjo2Fmv
         FC7arxsNylYtxa1jP7hOoHbYx16oKS2esq3Pd33799itW807BiSJ2a/Nbfk6vYtQ1UzA
         Rq5uz8ClmHymqXLvtuCVCNzeyhSYCXakbvOJSkE+NbRtSJUJjzREUgc/lKyw56TZusIg
         TCzFDJYywkZLxtgSUjs3ZxXOFmUeu82Q6HjLuIhXnWvg7yaeNrV62m8zcXV4SjF2+AG8
         J1onrCdW0/CUEnNiJx2z7BSdNg2+xd3/Ndg9BOPb1QwpDDsYy+DPQXDJvlAzTfYsu3rC
         UCVw==
X-Forwarded-Encrypted: i=1; AJvYcCXSVWuehmT33ndVBwa4+bR5m/ryM98lN5VvqJFuL3h2VvVGgHw/0Q+DTDlzjdyUeElmXzjkipo6O97Opv7s0ONglBfrAcEPdsWHVJAC
X-Gm-Message-State: AOJu0YxKVr8qnkrV3SMUVzAO73ckhlzxTlt01NxIDKtlh60wp7Qil6zt
	7nlZg10+HC+90np8Bc/KCT7bCCAxmrqeEeKJCCwI1nhVYUCl5UaIVUfslsWLOFfv3SIDkHVys9O
	Jmg8JS2h8v5bzo0PNg6BEU+BARBY+hRv9lpiqt/fxnA1S7qrC5GM1tq2Ob6vNuA==
X-Received: by 2002:adf:fa4a:0:b0:367:9d82:8370 with SMTP id ffacd0b85a97d-36baaf56d69mr1478948f8f.45.1722520334252;
        Thu, 01 Aug 2024 06:52:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm12m+Y9C9l9phe/+0YdpfEMjw0LYrQqwMVj1Q67GpYNuD/k/eIOyJsQ3IN0oM9cnpLl+0Vg==
X-Received: by 2002:adf:fa4a:0:b0:367:9d82:8370 with SMTP id ffacd0b85a97d-36baaf56d69mr1478927f8f.45.1722520333690;
        Thu, 01 Aug 2024 06:52:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:d5:a000:d3ea:62cf:3052:fac6? ([2a01:e0a:d5:a000:d3ea:62cf:3052:fac6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857db6sm19546600f8f.73.2024.08.01.06.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 06:52:13 -0700 (PDT)
Message-ID: <d4412d54-41b1-4671-9733-34ba1423404c@redhat.com>
Date: Thu, 1 Aug 2024 15:52:12 +0200
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
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <87o76czfb2.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 01/08/2024 12:51, John Ogness wrote:
> On 2024-08-01, Jocelyn Falempe <jfalempe@redhat.com> wrote:
>>   * It uses a circular buffer so the console->write() callback is very
>>     quick, and will never stall.
>>   * Drawing is done asynchronously using a workqueue.
> 
> For CON_NBCON, neither of the above points are necessary. You can draw
> directly from the write_thread() callback. See below:
> 
>> +static bool drm_log_work_draw(void)
>> +{
>> +	unsigned int len;
>> +	char buf[512];
>> +
>> +	len = drm_log_buf_read(buf, sizeof(buf));
>> +	if (len)
>> +		drm_log_draw_all(buf, len);
>> +	return len != 0;
>> +}
> 
> For CON_NBCON, this is essentially your write_thread() callback:
> 
> void drm_log_write_thread(struct console *con,
> 			  struct nbcon_write_context *wctxt)
> {
> 	drm_log_draw_all(wctxt->outbuf, wctxt->len);
> }
> 
> You cannot implement a write_atomic() callback because the console must
> be able to print directly in NMI context and must not defer. But
> write_atomic() is optional, so you should be fine there.
> 
> Disclaimer: Only in PREEMPT_RT patchset at the moment.

Thanks, so that means the circular buffer and workqueue are only 
necessary until write_thread() is merged in mainline. It will be a nice 
simplification.
I think I can also register one console for each drm driver, which will 
simplify drm_log even further. (currently it would mean having a 
circular buffer and work function for each driver which is a bit too much).
Do you know if there is a chance to have write_thread() in 6.12 or 6.13 ?

> 
> John Ogness >

Best regards

-- 

Jocelyn


