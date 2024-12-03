Return-Path: <linux-kernel+bounces-429603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F589E1EEC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A035B3ECFE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8FB1F12F6;
	Tue,  3 Dec 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6N+jodj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364911F1316
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234187; cv=none; b=jIFefv/dMSelpP/Plj+JsmkLmlq585npwsw1kwaLTHmoA1NKN45cRtLCREz47Enggcg1wm6cPq6B9Jt1a90rb/iPQTi/zRwaxFy+Jvvb9wYE26+t0tbhGdfbK8QpmZnmWMZQYXKX2FxUQkDJnbmD1a0+4xtnajqM5GuCq1oUcrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234187; c=relaxed/simple;
	bh=nAiBdJE55o5hzhahRO8NPWCPKDqwlw1S1pqrY2QhVl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RX2oKg1yyFIdFwcARkQg36lzdiOJPQDQVrzbA33DSBG+F+fVVcKo8g1VdKiG40J6psWH5XbSIVRbLPuYos6fPviBI8TpVNHF/s/tZXTl4xjhudTSNeS8/2Krpnw8nhI8TqTVQvpwPquMIWSVQFujz4cQtpOL67m1grvUg/TZbfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z6N+jodj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733234184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofnRMwIQFTb4k+7X6/uoqTm17QN8QYgSAm6WdEndwGI=;
	b=Z6N+jodjlZ7EdQm+zymb4ZQMYDml6w9RfxaxLnn3plr1HA2qP9qgid9UmAofOqAiAUDNaZ
	mIa4FyYkYq1sTGzX3IN9ae+M2DM5OCD+87z2VOl5WE2jeueL64G20pFiYgBckbAmL15WPs
	jxGDMkSgtmA53uIDQFfWDjuDesM6t/s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-JcKSH9FKP2K96X3TcpT73g-1; Tue, 03 Dec 2024 08:56:22 -0500
X-MC-Unique: JcKSH9FKP2K96X3TcpT73g-1
X-Mimecast-MFC-AGG-ID: JcKSH9FKP2K96X3TcpT73g
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4349fd2965fso52151075e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 05:56:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733234181; x=1733838981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ofnRMwIQFTb4k+7X6/uoqTm17QN8QYgSAm6WdEndwGI=;
        b=wi02TQH+DVL1wfDdBYJQ91Lxfk0a3CuM06+LQApdlVTGJg9MmvZOk7keGOTgNR935t
         CGN5X+Dz0bHtvXG3whFIA3AaZma3L+9UpLloKRq32Dxr9iPRZBpmO2UYaqRMqz5zZ7Uc
         hOi2s1grNl11zq6u8Pyf5Jn4GXzexmh6oAYC+LY5MIm/QtoIGLCgzwo9hdvyqz25l7sX
         SHt/ZO5olH5nx72y+Ol7oTOdj7EOnxwvG0cK6ALX8MOmidqwBBNRNWNqVU4lxP/AUFR6
         bNq7fxn555PzaGlbGXKxK1zpk0eE99d0Oc+Vm82a3VqJ1OrqETMlDf3cHwtruAj38pYZ
         N04Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuXN/efbNUa9maAsfRuHIOq5qrKCRtdnVaXJzKjIqUr8KLaScjcbCVolU3THc2Pi9xSVZ3N+9J2WM1Gk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmzyn/RVgRUQpQmN48sjyfGfKYpxctx/z0OrcS4+1999CxbLyr
	vg/+FMU0BRUwPbDdBNspYAci0jbNoFm+2PpGoANpOlkj5O4sqg5g3Wn9ALVkxCFvIN5h8IwrnmK
	fgepeM2Zgc47Xvspu6r7mSRMkDVsI2Tc+p6Xce+/0TP+Uh+m6uLY1Wy8Z2J+AXw==
X-Gm-Gg: ASbGncuk5uowQj6FE3Zu1880ICnL63Ugs5HrE5H+2OxOl+Y6v9G0yidosWmQS0FFl2c
	by+lp4Vtqf1ox542ZMG21/rOIlPM6OgiFr4XFb9yCWvhnhFqECZbOVVPHDHulNaD+PN7MIvU3Qx
	x4LQM/T4dVoo316wrX6LpfNC1SRzYmLPqy2eULyhpUorKreYErgm+H5U9tm2VLzayRYxBudLsO7
	MQEpZ6OeYR+gD0+1W2IIE8cdY2+jbwIs5KK2IG+9sUjp7iwoTxWDN2ACdKkcuGUdSXr57cNcNed
	DcqqhrTuyIE2Kw==
X-Received: by 2002:a05:600c:6b71:b0:432:d735:cc71 with SMTP id 5b1f17b1804b1-434d0a0e3c4mr23173495e9.25.1733234181519;
        Tue, 03 Dec 2024 05:56:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdQTYzrpTRAVfwmFeAbxgl2DVBKmVnO8fLYo0g42ay4ZV/6Sm256hFJYKinCixAGTd/lPzkA==
X-Received: by 2002:a05:600c:6b71:b0:432:d735:cc71 with SMTP id 5b1f17b1804b1-434d0a0e3c4mr23173175e9.25.1733234181147;
        Tue, 03 Dec 2024 05:56:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa764474sm218475535e9.10.2024.12.03.05.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 05:56:20 -0800 (PST)
Message-ID: <a51f2945-4eff-411e-83ad-838e69daeb6a@redhat.com>
Date: Tue, 3 Dec 2024 14:56:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/6] drm/panic: Move drawing functions to drm_draw
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 John Ogness <john.ogness@linutronix.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, Caleb Connolly <caleb.connolly@linaro.org>,
 Petr Mladek <pmladek@suse.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241115142950.1758007-1-jfalempe@redhat.com>
 <20241115142950.1758007-2-jfalempe@redhat.com> <87y10x3u0x.fsf@intel.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <87y10x3u0x.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/12/2024 12:06, Jani Nikula wrote:
> On Fri, 15 Nov 2024, Jocelyn Falempe <jfalempe@redhat.com> wrote:
>> Move the color conversions, blit and fill functions to drm_draw.c,
>> so that they can be re-used by drm_log.
>> drm_draw is internal to the drm subsystem, and shouldn't be used by
>> gpu drivers.
> 
> I started looking at this in patch 2:
> 
>> +#include "../drm_draw.h"
> 
> I think we should avoid #includes with ../ like this.

Sure, I've added it in v8, after the clients moved to drm/clients/, but 
I didn't think much about it.

> 
> Either drm_draw.h belongs in include/drm, or maybe clients/Makefile
> needs to add subdir-ccflags-y += -I$(src)/.. or something like that?
> 
> If it's supposed to be internal, I guess the latter, but then the
> current convention is to have _internal.h suffix. All drm headers under
> drivers/ have that.

ok, I can rename drm_draw.h to drm_draw_internal.h, and add the include 
in the Makefile.
> 
> Is this the first drm subsystem internal thing that's a separate module?
> Should we use EXPORT_SYMBOL_NS() and MODULE_IMPORT_NS() to enforce it
> being internal?

It's not really a separate module, as it's built in the core drm module. 
(the reason is that it's used by drm_panic too, which must be in the 
core drm module).

I don't know much about symbol namespace, but I can add that if needed.

Best regards,

-- 

Jocelyn

> 
> 
> BR,
> Jani.
> 
> 


