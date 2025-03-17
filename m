Return-Path: <linux-kernel+bounces-564108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBC5A64DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672B0164D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E00238D43;
	Mon, 17 Mar 2025 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1GVNBtK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD443237702
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742213209; cv=none; b=g3JkL0dJFeybMd+zBjlFjELivCRgz2kUyPDZLuPkmO22FxBLgkl0kh50uGDeg2zAMyZoVTxECmztbcx3koWS7EW8HnfwZupxAWbvXt1qb8ZjvVSpiK2rVTQ0/r3mAQXpCr9sz5/wQxKoUskQZFN8D5nA2fMgrOe8HTdmJn0gmOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742213209; c=relaxed/simple;
	bh=OdhP8xqEt2iM7IROoka4dd5M0pkY/P6CneVm+XNjuY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BpJcHd0oaf9oKEW7B57Utdaqvhcb3miBNOt+5pO2U/5S6JX0dkPa96bhkIxmjLL3ejGN7kKzBulkwkcE1oabdJOjOAmsSlW+05VFuUhkS2qLDMNYZ5TY8sfhvJlpuu0fQS6ko62w6JEQeDmcUjYACObOcqaqrOwpHZYgH0QIUVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W1GVNBtK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742213206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FsJOBNIkT+IrsuxSgC3fs8kWA8Vn7b/lsGkqVTldQws=;
	b=W1GVNBtKi6pQ+EuIl1J9Ond2jYeHh4Jw6WEYrz3WjiBsre5XCpydIrySBCNOdll5yjwAD1
	PkWVQlgt89bvmYC/ZpUBhEW7UXKPcAyC3IEP7fwdwO5rtd9RnoqmPfTlAGYQ+RvJ1/YoMl
	d8FLxc1Yd/1ivjmif9ndFzWnhwAWquU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-J33KV07KMeKaEYBE9re9BQ-1; Mon, 17 Mar 2025 08:06:45 -0400
X-MC-Unique: J33KV07KMeKaEYBE9re9BQ-1
X-Mimecast-MFC-AGG-ID: J33KV07KMeKaEYBE9re9BQ_1742213204
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e5c76fd898so3819375a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742213204; x=1742818004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FsJOBNIkT+IrsuxSgC3fs8kWA8Vn7b/lsGkqVTldQws=;
        b=eCy8Et2k5Ax7mUmAqnCzik/Ii3Bu3d6LUqiP2JdWWlC99SsMu4gTN/ObZ1KKfL+azS
         TB7N8LrTYu3zgGmrptpQezId8zoyd8DsB/jdHB4IGVg3BqcCe01eZfWA8B3LAuW/zaCy
         PNhGTcAVtj8etIL5NdbKk4TP4gBnOoPFsI+m6GRiOtNOQS9fvMu6XIo1kWVf8ouyn53f
         oSr+Me0u6OGV8LMzQ6BoWDjZizlwwTNVcI3Ms8eSfTcJPj3hd2qxZpC8/ZpMCFtDGIOI
         +zAZM0p/Mxw62aBrIzieNOD0/ykPm105r2ldGaJxxWkVwE86ra7KFjF9y0FqYzJnjB1e
         CLNw==
X-Forwarded-Encrypted: i=1; AJvYcCUcgMOtnNKLoo4FNXoNbbXPpz0mqDoq1T4d/9DgWlA6yLi4TYSjjjPbwUNOBNXy4WrJW3YnfGfGZrrWklM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/FYpX7gj6kylzeh5+1hagGNxUKrjoEwnX5VRt7ZU/IM2ReO+q
	0VR7k2cqFL8+dtZrjVELfvDfHlkBoNXBTuTWHKVhNkk5EY+uxnKQroGwXvDoA8B62RLFJziF5LN
	auDuJQBXSXuXVHQ/kqdsT27r/RuBA38Rjg2Nhuh5MqKZNY8b/shhE1dMInNoj7Q==
X-Gm-Gg: ASbGncuQds4WkPaGXtFvxHO3UMBIGH4GtTf/4wLkTeSQrTTIWAr07vDbEdw3y/nW2+v
	MToH2R8kMVKtOBt43tUZazNDFzXvY3cy7makpGXobchzBPL7B5C/F0S8axQQkB2vzAqmsiTZeAz
	VDmsfVkg6y2a7PiABuOW5SXDDVEB35xZg8A5GSp4gevVZmYSik9493LErXCx4lXkLv57mKz00QP
	EihXGK9+o01v75pqZHSEvuBlCA51FqluIWRSDqZnf7lMJQZnE6D27GMw3+GFx6QHMoNeATM0UZf
	E5F6OS0qyzyR6VAlOUo=
X-Received: by 2002:a05:6402:1e88:b0:5e5:dea5:3eb2 with SMTP id 4fb4d7f45d1cf-5e89fa27ff5mr13019756a12.11.1742213204084;
        Mon, 17 Mar 2025 05:06:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmQMtOckCF+PJyW0evnswjVRpHzbUIJWSKU6Yez1QrIPqUxHyXtbiMkkXYeWU68iPbIwfbAA==
X-Received: by 2002:a05:6402:1e88:b0:5e5:dea5:3eb2 with SMTP id 4fb4d7f45d1cf-5e89fa27ff5mr13019703a12.11.1742213203664;
        Mon, 17 Mar 2025 05:06:43 -0700 (PDT)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e81692e6d4sm5761290a12.9.2025.03.17.05.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 05:06:43 -0700 (PDT)
Message-ID: <45fff318-7925-4328-9dca-999c00e271d2@redhat.com>
Date: Mon, 17 Mar 2025 13:06:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Input: atkbd - Correctly map F13 - F24
To: Werner Sembach <wse@tuxedocomputers.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250311180643.1107430-1-wse@tuxedocomputers.com>
 <20250311180643.1107430-2-wse@tuxedocomputers.com>
 <83ea44f6-c0ad-4cb0-a16e-dd4fa17b63c7@tuxedocomputers.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <83ea44f6-c0ad-4cb0-a16e-dd4fa17b63c7@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11-Mar-25 19:10, Werner Sembach wrote:
> Hi Hans, Hi Dimitry,
> 
> resending this too on the v2 to not cause confusion:
> 
> Regarding remapping KEY_ZENKAKUHANKAKU to KEY_TOUCHPAD_TOGGLE:
> 
> Am 11.03.25 um 19:06 schrieb Werner Sembach:
>> Currently only F23 is correctly mapped for PS/2 keyboards.
>>
>> Following to this table:
>> https://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/translate.pdf
>>
>> - F24 and Zenkaku/Hankaku share the same scancode, but since in real world
>> Zenkaku/Hankaku keys seem to just use the tilde scancode, this patch binds the
>> scancode to F24. Note that on userspace side the KEY_ZENKAKUHANKAKU keycode is
>> currently not bound in xkeyboard-config, so it is (mostly*) unused anyway.
> 
> I think what the firmware vendor actually wanted to do was to send ctrl+super+f24 upon touchpad toggle. This would somewhat fall in line with, for example, the copilot key being implemented as shift+super+f23.

I agree that that seems to be the intent.

> Following this, my suggestion is to do this remapping and handle the rest in xkeyboard-config

xkeyboard config already contains mappings for F13 - F18 and F20-F23 in
/usr/share/X11/xkb/symbols/inet

So all that needs to happen there is map FK19 -> F19 and FK24 -> F24.

And then teach KDE + GNOME that ctrl+super+f24 means touchpad-toggle.

We could maybe get away with also dropping the weird mappings for FK13 - FK18
and map those straight to F13 - F18, but we need the special mappings
for F20 - F23 to stay in place to not break stuff.

Regards,

Hans



