Return-Path: <linux-kernel+bounces-245588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971A592B4AD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83041C22B4C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3662156991;
	Tue,  9 Jul 2024 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNz928wQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB61155A56
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519450; cv=none; b=VG9BP6rAWwafrJGuBUygOILn2ulSPUEGO4xaGzEtNTKBbcZLPTV99jSFdM1jO8wfXe/wOh/xlXMQ2UgxpIkKI8vaIjNTYw/z1LoBEfFTfbQBnuAKjfvFwRZvriGdW0ZuVRis3XIbjBtfIUC+j+ryLNgT4rk4tjZzj3Ub1PRJeJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519450; c=relaxed/simple;
	bh=snCPj8enqmXPG191f5IdWS+jgLOReKNRMgOU4fLIsDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgEVcK4NV1MhE0AB5hzLgmmB7nf9QfcDATh63tmDfQVDAaH6CfN4JnbYDW8SX7TPizVFXVqSF087xmNZeoww2lJPfZ4ZlnQOcYBaq8/Um9X/kdAtjOLU5Jzst866VkB/ngpqE4TioC797xbPcGRbIXK56+H9XX/Cz+pNapd5GA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QNz928wQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720519447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tpy09mrz7GMKI4NSvK7MGNBVjEFB/bqkDusvYImFW+s=;
	b=QNz928wQ+5sJ46F00zP6itWt35+VRL4xjY1/z0vjjT24kksLR+U7E0hglcYAKAEMOGhNrh
	Oh5Uwcvo0mo9u3qVFoXTlOfgR4sFaDxIHfSNs6/4qHH4vWPvDGR6NdhhpZMRG4pOCbTjLs
	sw9SW27rSbVrecz1h3gWvjzFyqu7Kio=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-S4bK16sTMO2NlxWVx1uEZw-1; Tue, 09 Jul 2024 06:04:05 -0400
X-MC-Unique: S4bK16sTMO2NlxWVx1uEZw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4265e9de046so20922205e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 03:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720519445; x=1721124245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpy09mrz7GMKI4NSvK7MGNBVjEFB/bqkDusvYImFW+s=;
        b=mBJptPql1K6//npXTNABYzRosmuoFByAsFxQM3QHz6v+Cy23w1etNg+edVaAuPgcD3
         +kJOulgiz0u4Q+IiqyFI2BjpCafGDWIOdDmG0nycEDbDhpFf/eMIHlTtHrDe32nHQubY
         AEdofGQt15hAkz+kEWzPi92frcLN7lOJ653QDSnJbZrAbkkDyywYpTuOm1rc8yaPySVV
         4NJlkQzpSeWmNMWm8ZEWqUAxI57u+RbZKAtAbAlYo8Z3hVfmr+g2HcKDhauYsBbPen2P
         ewzh1NmiSWyeBE0nKITXhPmxspVnrxNuFkAAJR1UtRCjlTwilsHIGB21lG8IdwXYA7qF
         W2dw==
X-Forwarded-Encrypted: i=1; AJvYcCWU/Tbga93XbxosKjZMoNafC98hIavGJagRw47A1mjHE5+va6PipLaeqX1UVgDd1FFPKKlu20I9VuTymV9sdXulRx4Bn2KFxdVcE7dm
X-Gm-Message-State: AOJu0Yy8FR0IO4tP8OAaqLfugDk0Kof6PZ8Ftm+YErq6vGUk7WyDgzJf
	DP7N+Sg28xba0CZViHFV6JtYLBFS5hxHZhtMisCOlQym/Z8v73Js8SQlNmn0EYJdq+iF3WULtwB
	glxKcvyT4P5RNF4TC/pW663rqVqUWv33iSip+jWhSfmR+We5DHHFN6xdse/SOdw==
X-Received: by 2002:a5d:5f48:0:b0:35f:1161:e1a3 with SMTP id ffacd0b85a97d-367cea46c6fmr1621688f8f.5.1720519444791;
        Tue, 09 Jul 2024 03:04:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3iuKpr/2eO4/gcMobO6ZU2lCVEnjdpbfxjc4M2aoAaKUj61p40UKF3EXkfLoCHaXC2OhfCQ==
X-Received: by 2002:a5d:5f48:0:b0:35f:1161:e1a3 with SMTP id ffacd0b85a97d-367cea46c6fmr1621657f8f.5.1720519444402;
        Tue, 09 Jul 2024 03:04:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367df88b1c5sm19168f8f.4.2024.07.09.03.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 03:04:03 -0700 (PDT)
Message-ID: <acd5c505-f058-46e7-9d92-620dea41d707@redhat.com>
Date: Tue, 9 Jul 2024 12:04:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/panic: Add a qr_code panic screen
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@redhat.com>
References: <20240709084458.158659-1-jfalempe@redhat.com>
 <20240709084458.158659-5-jfalempe@redhat.com>
 <2024070951-tall-effective-c916@gregkh>
 <2024070947-exorcism-purchase-2f28@gregkh>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <2024070947-exorcism-purchase-2f28@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/07/2024 11:12, Greg KH wrote:
> On Tue, Jul 09, 2024 at 11:11:35AM +0200, Greg KH wrote:
>> On Tue, Jul 09, 2024 at 10:40:10AM +0200, Jocelyn Falempe wrote:
>>> +config DRM_PANIC_SCREEN_QR_CODE_URL
>>> +	string "Base url of the QR code in the panic screen"
>>> +	depends on DRM_PANIC_SCREEN_QR_CODE
>>> +	help
>>> +	  This option sets the base url to report the kernel panic. If it's set
>>> +	  the qr code will contain the url and the kmsg compressed with zlib as
>>> +	  url parameter. If it's empty, the qr code will contain the kmsg as
>>> +	  uncompressed text only.
>>
>> meta-comment, should we by default do this on a kernel.org domain so
>> that no specific distro has to worry about hosing this type of web
>> service?
> 
> Also, do you have the backend source for this to show how anyone can
> host it themselves as well?  We can't add features to the kernel that no
> one but closed-source implementations will use for obvious reasons.

I've made a proof of concept backend here:
https://github.com/kdj0c/panic_report/

And the javascript to decode the kmsg trace is here (under MIT licence):
https://github.com/kdj0c/panic_report/blob/main/docs/panic_report.js

It uses the pako js library to uncompress the zlib data, which is also 
under MIT/Zlib licence https://github.com/nodeca/pako/

If kernel.org want to host a default service for that, that would be 
great. It can be linked with https://bugzilla.kernel.org to easily 
create a bug, or look for similar bugs.


Best regards,

-- 

Jocelyn


> 
> thanks,
> 
> greg k-h
> 


