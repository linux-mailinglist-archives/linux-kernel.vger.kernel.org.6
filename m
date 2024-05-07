Return-Path: <linux-kernel+bounces-171585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 573CF8BE606
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43E228BA5A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BEC14EC53;
	Tue,  7 May 2024 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnXk4B34"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5E415ECF2
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715092472; cv=none; b=Q/BmAO6ee4A2ZdkrZ+nJSbXf1u7+Y707YMoh/luPIBqxZXXn22HBwmZDOIEp29CTLaVDOnjEh/D+UngPr+6NCV4lOWjuPB9d1Bwjnd5w3f8b5uWgQzgZfiIU4PtNL48XCOOStksIhpmLWeCli8XGubK5Q5IRfKv6NZwiPNXGWCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715092472; c=relaxed/simple;
	bh=HNtKzgl9HwI6J7a5I/qX+lgiBT0k9lV+t79iUHomqQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjpuIj2d9o4/++9XKHBEuTbrrFi9kAFGjzll34j0VpdgGWJz+twsXmevoEpvpdqZWZfJrNCp3Dt53ve2noJIkuNQ6L2Bb0+q2puOESOk0xgtUWCxw1TWE5vCqnfd6to/IYll9AkTfGDH+0XlJiJbFt43z11c2dERL+M+bx8CaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TnXk4B34; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715092470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dxfYA0kT/oiCPR8P3ZGYKwq4gr+a/9ebQZcuGC0TkRM=;
	b=TnXk4B34dhbCSpeZR1BDKde4rBhXL2x+t+1G+2ZvVZHRwXDLVAjvjamllRohyYyyjkBOvH
	UFD60ZcLyD0IyRdXfS0OpFHfKpMEqFL4OjYgaJGBIhLpKvMDzFulY0XpHi5Lc96APthpWI
	vacJYmC6AYLk4GM6mcDXjZ15/uT7l80=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-8nxCPunlO8WPIhI4QpIfXA-1; Tue, 07 May 2024 10:34:27 -0400
X-MC-Unique: 8nxCPunlO8WPIhI4QpIfXA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-51b1a65c68eso2829827e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715092466; x=1715697266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxfYA0kT/oiCPR8P3ZGYKwq4gr+a/9ebQZcuGC0TkRM=;
        b=opJRSgvf5YLm2z0fCr38bYkh/R9xpD9aI7MybylFHM5ek5PFlCDMVybgCWW6GM5zQ7
         dS6FWDzGkilCqo0M2+V8Mp+4y7Ibuk09z9PT2wEnMyg7ii08j7MjcW/v49hmIt3R4lzG
         /hOQusHdBwbLSbG7fNPyWhBFZiH21sT3VWe9ho4TgoYPyIlNaMr1OSMXMQHN1cNpt7w3
         t8cONv5QlKCGFJSNlc82NwNtVwKdPU9ki936GUZXxvbOPaeb5qcB5Q9+KAZ+m6mF7ce0
         wLhZiPzaUo/Po6KZ0Bzsnw8g8t93l3kVPYPrdJXHbGSGO6Zu1DU03t2pcREiJvdYT48K
         TSxg==
X-Forwarded-Encrypted: i=1; AJvYcCVGMx8kKD+s/OQ6a8MrjL5ran+TVZC2nqfldgYg/V4HCeSFFDoEpgE7gWDyYIBLggd7fcgkLQEEWh+8x9eREMwbVmbwRaZ8wJlu27Hd
X-Gm-Message-State: AOJu0Yzxzwn0TtR5JPObNpyiNuir1Ga66SNHxdInpQIOi3eMgb3iaesz
	y3Nlav8FPaBM6Y/+kjbR8UcN/Dgr+n6ha/tbWjyDSkpUGX2BbJxi5+sSRZm42w2xbxOZaL1pPYa
	iGQ7KuzSwaTZsBYnixxxvNAyLeIP1Cnzak+LVGsFWCCaDTB22jGt4VtOeDMJ80A==
X-Received: by 2002:ac2:4214:0:b0:519:1e33:9d85 with SMTP id y20-20020ac24214000000b005191e339d85mr8206480lfh.36.1715092465996;
        Tue, 07 May 2024 07:34:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJf6M7/XK+2/GfqsOz3VPdKfvdQSS9fpgAz3ojdSlixZ5gK65wQW/LGj1l0TFGD5KOfhLbVw==
X-Received: by 2002:ac2:4214:0:b0:519:1e33:9d85 with SMTP id y20-20020ac24214000000b005191e339d85mr8206456lfh.36.1715092465580;
        Tue, 07 May 2024 07:34:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:e7a9:b143:57e6:261b? (2001-1c00-2a07-3a01-e7a9-b143-57e6-261b.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:e7a9:b143:57e6:261b])
        by smtp.gmail.com with ESMTPSA id b19-20020a1709062b5300b00a59a05a8030sm4709239ejg.25.2024.05.07.07.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 07:34:25 -0700 (PDT)
Message-ID: <3c0c7e7e-1530-411b-b7a4-9f13e0ff1f9e@redhat.com>
Date: Tue, 7 May 2024 16:34:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Safety of opening up /dev/dma_heap/* to physically present users
 (udev uaccess tag) ?
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
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
 Milan Zamazal <mzamazal@redhat.com>, Maxime Ripard <mripard@redhat.com>,
 Andrey Konovalov <andrey.konovalov.ynk@gmail.com>
References: <bb372250-e8b8-4458-bc99-dd8365b06991@redhat.com>
 <ojduxo54lpcbfg2wfuhqhy7k3phncamtklh65z7gvttcwztmhk@zkifewcy4ovi>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ojduxo54lpcbfg2wfuhqhy7k3phncamtklh65z7gvttcwztmhk@zkifewcy4ovi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dmitry,

On 5/7/24 3:32 PM, Dmitry Baryshkov wrote:
> On Mon, May 06, 2024 at 01:49:17PM +0200, Hans de Goede wrote:
>> Hi dma-buf maintainers, et.al.,
>>
>> Various people have been working on making complex/MIPI cameras work OOTB
>> with mainline Linux kernels and an opensource userspace stack.
>>
>> The generic solution adds a software ISP (for Debayering and 3A) to
>> libcamera. Libcamera's API guarantees that buffers handed to applications
>> using it are dma-bufs so that these can be passed to e.g. a video encoder.
>>
>> In order to meet this API guarantee the libcamera software ISP allocates
>> dma-bufs from userspace through one of the /dev/dma_heap/* heaps. For
>> the Fedora COPR repo for the PoC of this:
>> https://hansdegoede.dreamwidth.org/28153.html
> 
> Is there any reason for allocating DMA buffers for libcamera through
> /dev/dma_heap/ rather than allocating them via corresponding media
> device and then giving them away to DRM / VPU / etc?
> 
> At least this should solve the permission usecase: if the app can open
> camera device, it can allocate a buffer.

This is with a software ISP, the input buffers with raw bayer data
come from a v4l2 device, but the output buffers with the processed
data are purely userspace managed in this case.

Regards,

Hans


