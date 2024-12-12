Return-Path: <linux-kernel+bounces-442788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BE49EE1D0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4DE188470C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0EB20DD62;
	Thu, 12 Dec 2024 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaWypF4k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DDC20C499
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993368; cv=none; b=dVjNIXgLcZTEFoZ9yLNZbA0Djv1tSz5TVPNZgLurrUIMzBgNNB/wKdiDiKJGLH1+q94I6WWTEVY1sQzaDW5ghAplKt+nNWNSL0dG2+wjKR8jtN3CcwL9Es3xhGf4ZvKuYLI0Bfwj4ivQsP47A36mz4QBTzrm4eeQvF+NktK+8c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993368; c=relaxed/simple;
	bh=My4+O10zZY+zc2eNcckP2SEJvvE0kb6I+L8NgI30psM=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=J+WaIXW/51/bmMLJ6gTqe/aiABcjw/JnWFwbRUhi26IfxtHceFKyJcogyomCrBNBqeAu9pau9gERuLXrnIYBagKk1CXSdyW31Vu5W2KHCbnr3gvpHHIIo2J6yeQ6VVLrsajpniHPi2E0Z0+Z6vNLUkUTSzY+FuZ+cRd5RPdmHxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aaWypF4k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733993364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tQG/d6LCdm5MnHjpzF5a9Rw3xf3uLuwTNQjfLc7RcAs=;
	b=aaWypF4k96GM/RoyD5br9WX6jEN64wvXTjWjpXqQA5/k8sl/6ZB7l5irH73VYdFWlzCZNC
	42SY+eQ/2BFvsU35P8ujS1kpSGNfa1BpjXIeO6t1QTKkev90t+9R4IWhTOo/o9u0ElkmAw
	XA6tZ496tBv1H9zrDA6dTap49WJ27Sc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-1hn1iNP9OMyFQhK_R9rsGA-1; Thu, 12 Dec 2024 03:49:22 -0500
X-MC-Unique: 1hn1iNP9OMyFQhK_R9rsGA-1
X-Mimecast-MFC-AGG-ID: 1hn1iNP9OMyFQhK_R9rsGA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-436219070b4so2120495e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733993361; x=1734598161;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tQG/d6LCdm5MnHjpzF5a9Rw3xf3uLuwTNQjfLc7RcAs=;
        b=AbKfukTSZ9V/gZ1dwd9vjmjqgKlL/cjr/afZMVM4s41OI1r22+5bXHjtP98lMqJx1K
         g/R6MmiTinIL0J90VJrWYA3L5wlUs+Og9NeNlu8lkbvlc3BnDlt4rd98PEV3I5Hw0UdL
         W9taR/fLGPR2sYikxYJxGrTuzxzANRAK6Vy0k+Jbq0FggJEBLCLrDz6dLOzwE6G646oH
         yaTq+niAbDDFpUt6rFNSKPVlOl9MyVHw18mLxo2rm/btdb0k0Vu72qGQrq1HgoJIlWyh
         fKxDH8sm5K+wxUPaTRafJcwT59RMRdDMsaPZPQh7n3wlMETqfKH3JR9XqNv6kSkOr/NR
         UMfA==
X-Forwarded-Encrypted: i=1; AJvYcCVBB5qA+1IkHZJ4q9wO9fOuVcZlBXKBeLs4NGuNVQbqisLpGVisQdm4kutL4fFjJqrgfWEcNRk2iHPW1iY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8u9AR147r9erUxiZFuCCKK3RPptlef9ezPSi3RydRBxDtKz/r
	qY8egYCIKo6MydpJzFvHV8IsvHNDUdGKkTssWpqyNef38V0Psg6mL+PtYXtqPz+5ZUHrJtC68Bp
	8rUrOt8nqWH3Z4PYP5/20uiUwFl/rlzbSu9XMUlP+uPV+fla1D6CayCc0RutOfg==
X-Gm-Gg: ASbGncv75uxaDjOK+fx8OmpywKMg/9fzLz085vGVFke8pgxSQtvF1HkK888t/E9KA8D
	42GGlpzzZRCsDRCNTbjT+aH9bCYjcb1Je9Zel9VwxkVwchJ8IB/yHiRjX+5fxcU5ISMyIylNZp9
	xRISRFndItq9xBPO/Xp8Zxq7oy5+SDqvvH5yh6E6GEql4j5/wpsTZaBW7S3RZDQaYjr03up9++W
	8fz9CX/ZX6aUJNHvjgQubjd8CmGzjV5+EvV5NtbUUjfeNQWaKd6Cl8hQqOhf5zPlhZQLXNO8hJy
	G6Hvz0vJ7i0y5QwkvB9I
X-Received: by 2002:a05:600c:3b09:b0:434:f270:a4f0 with SMTP id 5b1f17b1804b1-4361c3efb35mr42150545e9.21.1733993361251;
        Thu, 12 Dec 2024 00:49:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEB6QdZdXrc112M0bqVQaI5blGw1L3V/M9+BdeTOSPDeyEKt8uVRKpOiPA28hR1LdRdi1BaKQ==
X-Received: by 2002:a05:600c:3b09:b0:434:f270:a4f0 with SMTP id 5b1f17b1804b1-4361c3efb35mr42150255e9.21.1733993360853;
        Thu, 12 Dec 2024 00:49:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361ec97d13sm23140765e9.1.2024.12.12.00.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 00:49:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------ZU9FrtAleaOJic9fVaCBFZ4I"
Message-ID: <88abb273-13e3-4969-96c3-c7d677a082d4@redhat.com>
Date: Thu, 12 Dec 2024 09:49:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/6] drm/log: Introduce a new boot logger to draw the
 kmsg on the screen
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 John Ogness <john.ogness@linutronix.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, Caleb Connolly <caleb.connolly@linaro.org>,
 Petr Mladek <pmladek@suse.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241204160014.1171469-1-jfalempe@redhat.com>
 <20241204160014.1171469-3-jfalempe@redhat.com>
 <816f862e-762d-4880-9285-5a803e657e66@stanley.mountain>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <816f862e-762d-4880-9285-5a803e657e66@stanley.mountain>

This is a multi-part message in MIME format.
--------------ZU9FrtAleaOJic9fVaCBFZ4I
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/2024 08:41, Dan Carpenter wrote:
> This patch breaks "make oldconfig" for me.  It just gets into an endless
> loop of:
> 
>    Default DRM Client
>    choice[1-0?]: 0
>    Default DRM Client
>    choice[1-0?]: 0
>    Default DRM Client
>    choice[1-0?]: 0
>    Default DRM Client
>    choice[1-0?]: 0
>    ...
> 
> I don't have to type anything, it just spams that forever.  It's weird
> that it's 1-0 instead of 0-1.  Does that means something?  I don't know
> much about Kconfig.

I can reproduce it with your provided config.

It looks like it happens if DRM_CLIENT_SELECTION is enabled, but none of 
the client is.
The attached patch should fix it, can you try it ?

I will submit that shortly.

Thanks for reporting it.

Best regards,

-- 

Jocelyn


> 
> I'm using this arm64 randconfig as a base.  I type "make oldconfig" and
> press enter until it gets to "Default DRM Client" and then it starts
> scrolling endlessly.
> https://download.01.org/0day-ci/archive/20241212/202412121555.Fp663tyH-lkp@intel.com/config
> 
> regards,
> dan carpenter
> 

--------------ZU9FrtAleaOJic9fVaCBFZ4I
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Fix-endless-Kconfig-loop.patch"
Content-Disposition: attachment;
 filename="0001-Fix-endless-Kconfig-loop.patch"
Content-Transfer-Encoding: base64

RnJvbSBlNGQxOTdkZWJkMmMxOTljOWYyZDhlMzVlNDFlMzZjMjgzNjkyNmI5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb2NlbHluIEZhbGVtcGUgPGpmYWxlbXBlQHJlZGhh
dC5jb20+CkRhdGU6IFRodSwgMTIgRGVjIDIwMjQgMDk6NDM6NTAgKzAxMDAKU3ViamVjdDog
W1BBVENIXSBGaXggZW5kbGVzcyBLY29uZmlnIGxvb3AKClNpZ25lZC1vZmYtYnk6IEpvY2Vs
eW4gRmFsZW1wZSA8amZhbGVtcGVAcmVkaGF0LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
Y2xpZW50cy9LY29uZmlnIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vY2xpZW50cy9LY29uZmlnIGIvZHJpdmVy
cy9ncHUvZHJtL2NsaWVudHMvS2NvbmZpZwppbmRleCBjMThkZWNjOTAyMDAuLjgyYTdkNGU1
ODRkZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2NsaWVudHMvS2NvbmZpZworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vY2xpZW50cy9LY29uZmlnCkBAIC04Nyw2ICs4Nyw3IEBAIGNv
bmZpZyBEUk1fQ0xJRU5UX0xPRwogY2hvaWNlCiAJcHJvbXB0ICJEZWZhdWx0IERSTSBDbGll
bnQiCiAJZGVwZW5kcyBvbiBEUk1fQ0xJRU5UX1NFTEVDVElPTgorCWRlcGVuZHMgb24gRFJN
X0ZCREVWX0VNVUxBVElPTiB8fCBEUk1fQ0xJRU5UX0xPRwogCWRlZmF1bHQgRFJNX0NMSUVO
VF9ERUZBVUxUX0ZCREVWCiAJaGVscAogCSAgU2VsZWN0cyB0aGUgZGVmYXVsdCBkcm0gY2xp
ZW50LgotLSAKMi40Ny4xCgo=

--------------ZU9FrtAleaOJic9fVaCBFZ4I--


