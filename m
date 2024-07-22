Return-Path: <linux-kernel+bounces-258683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51471938B92
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07589280CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E174E1662FA;
	Mon, 22 Jul 2024 08:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIbmPCbJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D9011CA0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721638489; cv=none; b=KhI026ncT8OzNyXxa0IwTWaD6mWnUPhRHCGtpljQkuCc8biltlQajw5+Y5+b6DLKaHVJ6Q7aZx56eKvylKq/YE4jD2bkXn/HV/53ALTlIAElQ+Pl4timAOvszFhAVIe7PbCqkLqgtPYdgSGO18ubFZ+lf2YrCRlUf+pmxvMcxWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721638489; c=relaxed/simple;
	bh=Bog4r9e4a8HTt0tdJ7Ud1DKFn+y5jKu+1ziEoOqlgG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qKJ3NFTRrmBGkoM3Msdd9LLhHwn91CRw9J5j6RysoEK7fmaUxzxS40+So2iSnI+OGB93hbmiPoMi9a9c8rDquoVyV/P4uy5jkYeAwTjppwVUAxJ0kUzXO6vV+Y4hFwoupApXml+fRTYbU8L7naLaLA+GNuTrfMkumhBA5LE+mlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIbmPCbJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721638486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxI9qiM4lzIxZVwtwjzIK8T0OrMcooauWHayA/UpE+g=;
	b=JIbmPCbJfJWhkvuPTc0b9Or9MZ5ESQSGLjyavL1DGtdsvGeGSZeTswDSD+dcwIcms6PAU4
	pqdQuoLpSZJF0j4ILdcU9bywRJZ267/QMfiC1Ftw5Tsmyjnzau7j/INVnpJnCm5RekEjTS
	DpkM4mqdzG3zsCUc5OeaXt9PZj86kMc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-TsnRGIiPOkKGgvnKVe333g-1; Mon, 22 Jul 2024 04:53:05 -0400
X-MC-Unique: TsnRGIiPOkKGgvnKVe333g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42668857c38so30496785e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721638384; x=1722243184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxI9qiM4lzIxZVwtwjzIK8T0OrMcooauWHayA/UpE+g=;
        b=qHa2v8TaGRwxAee9c7Ss4qt3UeoBq7X1S+cHKTY+jNP/fWsoicJSvlSTCtILv5tob5
         oeJiT1EHCfzQeuDX1IzSlWAbZrLucizhvV1AqFW71mFWoPSjW3uTq8LmKFkycE9AkrC0
         FtmtLMqgZymPtpgZcykjVSV4YJLnuGE/wVgBgHu8gQW4bh/twwDZz3Jf+ZY27wdIuJTA
         aMyE/UDL19xX/AEXhpW+Ounfnux0do+sb7zeAKiP5BL7D/uPbohY522FVXRXVeKyRHPd
         oG78zWFGq3PpwU/A10ifSefb/LP2RWlgduGQNguuwW6eapCU/SyE05dl5rqV/MDtehNK
         Kr8w==
X-Forwarded-Encrypted: i=1; AJvYcCW9KvD+ckapW3Mmu+NuCb2mLH4xNEDW5Zf7uLoaq2k6PKlZmRbYIpo0ggnZEYtSUGPtA2OLHevs0Y0ww0sWMBI/jACjZ6SXr/3le9Si
X-Gm-Message-State: AOJu0YyzvbdSoMBCEgJLPytjIM+OKE1Zcbm1bIZ9zHqQKMMuxgLjj2Y+
	fTRAFT96f2YyUYs7uXessglmRQAcQuCszqGnXE9eBrbOKYEJp+NicpxcNu+l9v+W+i/iMBHpLsk
	J3hg6VS2e5c0J0cBRnD6+mtv7JFS7qB+N3IE4H+RR/INL6oq8Q5IkkSWDnLhA5Q==
X-Received: by 2002:a05:600c:3553:b0:426:6765:d6b0 with SMTP id 5b1f17b1804b1-427dc51d30amr38064665e9.15.1721638383823;
        Mon, 22 Jul 2024 01:53:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQt0t4NSssP8bkkisHsnA8tLq8Iv91Jr480NjPHTYPZZEWC+ZnVhrLtxhOJzzrDG86YKQ7uw==
X-Received: by 2002:a05:600c:3553:b0:426:6765:d6b0 with SMTP id 5b1f17b1804b1-427dc51d30amr38064325e9.15.1721638383386;
        Mon, 22 Jul 2024 01:53:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:d5:a000:d3ea:62cf:3052:fac6? ([2a01:e0a:d5:a000:d3ea:62cf:3052:fac6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a63c8dsm146615265e9.20.2024.07.22.01.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 01:53:02 -0700 (PDT)
Message-ID: <8803e15d-3531-4384-b641-25845176ded5@redhat.com>
Date: Mon, 22 Jul 2024 10:53:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] drm/panic: Add a QR code panic screen
To: Mitchell Levy <levymitchell0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
References: <20240717142644.1106060-1-jfalempe@redhat.com>
 <0bad8507-22f3-38d2-5724-0aa6433990cc@gmail.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <0bad8507-22f3-38d2-5724-0aa6433990cc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/07/2024 20:50, Mitchell Levy wrote:
> I am trying to test this patchset on my setup, but I cannot get it 
> working. In case it's relevant, I'm running under HyperV. Any 
> troubleshooting steps/suggestions would definitely be appreciated.

First, make sure you have this in your .config:
CONFIG_RUST=y
CONFIG_DRM_SIMPLEDRM=y
CONFIG_SYSFB_SIMPLEFB=y
CONFIG_DRM_PANIC=y
CONFIG_DRM_PANIC_FOREGROUND_COLOR=0xffffff
CONFIG_DRM_PANIC_BACKGROUND_COLOR=0x000000
CONFIG_DRM_PANIC_DEBUG=y
CONFIG_DRM_PANIC_SCREEN="qr_code"
CONFIG_DRM_PANIC_SCREEN_QR_CODE=y

drm_panic is only supported by a few drivers. The easiest way to test, 
is to use the simpledrm driver, that should work on all EFI or BIOS 
based system.
To check the drm driver in use, run:
sudo udevadm info -a -n /dev/dri/card0 | grep DRIVER

If it's not simpledrm, you should blacklist it, and make sure you boot 
with simpledrm.

and then you can run:
echo 1 > /sys/kernel/debug/dri/0/drm_panic_plane_0

On a side note, looking at the hyperv drm driver, it should be easy to 
add drm_panic support for it. I will look into that when I get some time.

Best regards,

-- 

Jocelyn

> 
> Thanks!
> Mitchell
> 
> On 7/17/2024 7:24 AM, Jocelyn Falempe wrote:
>> This series adds a new panic screen, with the kmsg data embedded in a 
>> QR code.
>>
>> The main advantage of QR code, is that you can copy/paste the debug 
>> data to a bug report.
>>
>> The QR code encoder is written in rust, and is very specific to drm 
>> panic.
>> The reason is that it is called in a panic handler, and thus can't 
>> allocate memory, or use locking.
>> The rust code uses a few rust core API, and provides only two C entry 
>> points.
>> There is no particular reason to do it in rust, I just wanted to learn 
>> rust, and see if it can work in the kernel.
>>
>> If you want to see what it looks like, I've put a few screenshots here:
>> https://github.com/kdj0c/panic_report/issues/1
>>
>> v2:
>>   * Rewrite the rust comments with Markdown (Alice Ryhl)
>>   * Mark drm_panic_qr_generate() as unsafe (Alice Ryhl)
>>   * Use CStr directly, and remove the call to as_str_unchecked()
>>     (Alice Ryhl)
>>   * Add a check for data_len <= data_size (Greg KH)
>>
>> v3:
>>   * Fix all rust comments (typo, punctuation) (Miguel Ojeda)
>>   * Change the wording of safety comments (Alice Ryhl)
>>   * Add a link to the javascript decoder in the Kconfig (Greg KH)
>>   * Fix data_size and tmp_size check in drm_panic_qr_generate()
>>   v4:
>>   * Fix the logic to find next line and skip the '\n' (Alice Ryhl)
>>   * Remove __LOG_PREFIX as it's not used (Alice Ryhl)
>>
>> Jocelyn Falempe (4):
>>    drm/panic: Add integer scaling to blit()
>>    drm/rect: Add drm_rect_overlap()
>>    drm/panic: Simplify logo handling
>>    drm/panic: Add a QR code panic screen
>>
>>   drivers/gpu/drm/Kconfig         |   31 +
>>   drivers/gpu/drm/Makefile        |    1 +
>>   drivers/gpu/drm/drm_drv.c       |    3 +
>>   drivers/gpu/drm/drm_panic.c     |  340 +++++++++--
>>   drivers/gpu/drm/drm_panic_qr.rs | 1003 +++++++++++++++++++++++++++++++
>>   include/drm/drm_panic.h         |    4 +
>>   include/drm/drm_rect.h          |   15 +
>>   7 files changed, 1358 insertions(+), 39 deletions(-)
>>   create mode 100644 drivers/gpu/drm/drm_panic_qr.rs
>>
>>
>> base-commit: e1a261ba599eec97e1c5c7760d5c3698fc24e6a6
> 


