Return-Path: <linux-kernel+bounces-169935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F268BCF93
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81C0CB23A31
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C0E8120A;
	Mon,  6 May 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPal3w38"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D807E7C6D5
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004109; cv=none; b=BGUzM2dszPQcUlkrpnY2xkaJd/d7MKhEk2Q0z40o/xzwxwz7fEDUm8E/vuEf2qiIhULJeSUJ2+s9jURdCvsjDpLdkIXnjmNCyJzlIXL4A7zVvayvI8UKgqmzkz6dWVX7WcuMhwK+xuD7h0mPvD3/NVFLO5dv4FsXMXBhc6kJwRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004109; c=relaxed/simple;
	bh=QdBWMUSn7gZXmXCHj2RcAdJODiJKBW/D4uMUKrPsQ9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lk8xgvMvRZhnKVbpiqE5Uhq0oAHVYR644fy1I6weAAp7Glwyye+wKH2sD+W0tgVt+drFekFOslH4LJprs5yt7Wn3ZV2zpm8C1VG8lU6NA4WlX5Abw0c4230ORKsvNJlJW78foYS8ZTPHSG4OMxhLFQxxmjs9XKAQL2JV67nXP7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPal3w38; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715004106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oa4YbBmlzkI63abCw2z4fEd9n5o3yLiXeNXHymLCUuE=;
	b=iPal3w38+4DU6qX+Ax8iDGoxGS1THKcmg2kBY0r+x/tg2cQ5JrX/9tIF3thwJkzOdk//pG
	Xlg9fgfatbX4s6oc1I0SpPFFQ+ce8tbj4cLeXYeF/6NgCLG4257QCI9VGquvM9MwmN2ztv
	1Vi4KBdoJNn+fh5Sr6iN1QDUwF6oruc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-KbedAPxNOdSoUoqaBG7FWw-1; Mon, 06 May 2024 10:01:45 -0400
X-MC-Unique: KbedAPxNOdSoUoqaBG7FWw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-571bdbca3c8so363688a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 07:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715004104; x=1715608904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oa4YbBmlzkI63abCw2z4fEd9n5o3yLiXeNXHymLCUuE=;
        b=JIcr2eZNi8X3pCNCFUvEC61tVwzGCuwIQWaKNZa0JSiQM7P0RI4t9Ca46qvLnVUH6d
         vs6ExvKcytQmprLBlVpkLI34ISbuW1+sWMJNpI79SAcuvhezXu5PyT9cuY9QrIecLyS9
         JKXAB4oJcChBMbjeBK5wQEUdPiBxuY3ezv1YXD5EK1S0FhrFLWaw6l0PWUtVEr5scYVx
         zCpQfGx9Q1axIOXPHUu8e4MrRhpEaiKAR5zxsMdVZRyNx5v6r6OkIsF79fyS9R8g3T0T
         bgPyxfRZlCinglFCFDDFfpP9bw/kY8JaTnq0KvcBDKVq7yNwrDGdkjLC2lC5HroqF3ML
         EKgw==
X-Forwarded-Encrypted: i=1; AJvYcCXv0TPgJs8AIxV7Mi3ZcqeSfhUvsZ/yD9/BjcbQCsj68YGI+uycNmLZTDIQek18OYtwrJPaVdpWc//AFGBSj4HVric7MZF61ybppTAO
X-Gm-Message-State: AOJu0YxDipw5r2hiHy+b92J/d1TB9VvBxilhsurxso6EFUTlC5N2/tLV
	gC2+wHiN6r2kXDvSMzC1RoK6rJ+wjv1s/GVK5B/XrWK2CF5pyzV3aM54QJxFhGUidNuS2MhukeO
	cCWLwAvOUxguAdLOMXbRcQHBT1cD30UbVcAkitpVKoVJmsJBYD4Mi07U5GYiS1w==
X-Received: by 2002:a50:9513:0:b0:570:5b70:3407 with SMTP id u19-20020a509513000000b005705b703407mr8444055eda.10.1715004104189;
        Mon, 06 May 2024 07:01:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqtTHezMetmGx7QkF/7UHxNmAFJAxewY94xyi4UnLpcMz8eE3WVuF2BLvBhkQkOqr8E1iw4Q==
X-Received: by 2002:a50:9513:0:b0:570:5b70:3407 with SMTP id u19-20020a509513000000b005705b703407mr8444031eda.10.1715004103794;
        Mon, 06 May 2024 07:01:43 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id z5-20020aa7c645000000b00572b0a44e42sm5224207edr.26.2024.05.06.07.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 07:01:43 -0700 (PDT)
Message-ID: <cbe5a743-d8be-4b0e-99c4-e804fbadc099@redhat.com>
Date: Mon, 6 May 2024 16:01:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Safety of opening up /dev/dma_heap/* to physically present users
 (udev uaccess tag) ?
To: Maxime Ripard <mripard@redhat.com>, Sumit Semwal
 <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Lennart Poettering <mzxreary@0pointer.de>,
 Robert Mader <robert.mader@collabora.com>,
 Sebastien Bacher <sebastien.bacher@canonical.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 linaro-mm-sig@lists.linaro.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Milan Zamazal <mzamazal@redhat.com>,
 Andrey Konovalov <andrey.konovalov.ynk@gmail.com>
References: <bb372250-e8b8-4458-bc99-dd8365b06991@redhat.com>
 <20240506-dazzling-nippy-rhino-eabccd@houat>
 <ZjjdUBYYKXJ1EPr5@phenom.ffwll.local>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZjjdUBYYKXJ1EPr5@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sima,

On 5/6/24 3:38 PM, Daniel Vetter wrote:
> On Mon, May 06, 2024 at 02:05:12PM +0200, Maxime Ripard wrote:
>> Hi,
>>
>> On Mon, May 06, 2024 at 01:49:17PM GMT, Hans de Goede wrote:
>>> Hi dma-buf maintainers, et.al.,
>>>
>>> Various people have been working on making complex/MIPI cameras work OOTB
>>> with mainline Linux kernels and an opensource userspace stack.
>>>
>>> The generic solution adds a software ISP (for Debayering and 3A) to
>>> libcamera. Libcamera's API guarantees that buffers handed to applications
>>> using it are dma-bufs so that these can be passed to e.g. a video encoder.
>>>
>>> In order to meet this API guarantee the libcamera software ISP allocates
>>> dma-bufs from userspace through one of the /dev/dma_heap/* heaps. For
>>> the Fedora COPR repo for the PoC of this:
>>> https://hansdegoede.dreamwidth.org/28153.html
>>
>> For the record, we're also considering using them for ARM KMS devices,
>> so it would be better if the solution wasn't only considering v4l2
>> devices.
>>
>>> I have added a simple udev rule to give physically present users access
>>> to the dma_heap-s:
>>>
>>> KERNEL=="system", SUBSYSTEM=="dma_heap", TAG+="uaccess"
>>>
>>> (and on Rasperry Pi devices any users in the video group get access)
>>>
>>> This was just a quick fix for the PoC. Now that we are ready to move out
>>> of the PoC phase and start actually integrating this into distributions
>>> the question becomes if this is an acceptable solution; or if we need some
>>> other way to deal with this ?
>>>
>>> Specifically the question is if this will have any negative security
>>> implications? I can certainly see this being used to do some sort of
>>> denial of service attack on the system (1). This is especially true for
>>> the cma heap which generally speaking is a limited resource.
>>
>> There's plenty of other ways to exhaust CMA, like allocating too much
>> KMS or v4l2 buffers. I'm not sure we should consider dma-heaps
>> differently than those if it's part of our threat model.
> 
> So generally for an arm soc where your display needs cma, your render node
> doesn't. And user applications only have access to the later, while only
> the compositor gets a kms fd through logind. At least in drm aside from
> vc4 there's really no render driver that just gives you access to cma and
> allows you to exhaust that, you need to be a compositor with drm master
> access to the display.
> 
> Which means we're mostly protected against bad applications, and that's
> not a threat the "user physically sits in front of the machine accounts
> for", and which giving cma access to everyone would open up. And with
> flathub/snaps/... this is very much an issue.

I agree that bad applications are an issue, but not for the flathub / snaps
case. Flatpacks / snaps run sandboxed and don't have access to a full /dev
so those should not be able to open /dev/dma_heap/* independent of
the ACLs on /dev/dma_heap/*. The plan is for cameras using the
libcamera software ISP to always be accessed through pipewire and
the camera portal, so in this case pipewere is taking the place of
the compositor in your kms vs render node example.

So this reduces the problem to bad apps packaged by regular distributions
and if any of those misbehave the distros should fix that.

So I think that for the denial of service side allowing physical
present users (but not sandboxed apps running as those users) to
access /dev/dma_heap/* should be ok.

My bigger worry is if dma_heap (u)dma-bufs can be abused in other
ways then causing a denial of service.

I guess that the answer there is that causing other security issues
should not be possible ?

Regards,

Hans


