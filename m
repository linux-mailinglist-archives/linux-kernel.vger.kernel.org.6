Return-Path: <linux-kernel+bounces-539484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FED5A4A4EB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9ED189AD40
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865751DB14C;
	Fri, 28 Feb 2025 21:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6BNZnuf"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B01D8E10
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777722; cv=none; b=rOICNlNgtF7THn3GW0qEODmt+6/4v1+sDX1z/EVEc+0OLpKF4sCg1yEP4FSFOAWTtaK0HfjvI+oLHhnSE/ltjLyA+TiTse56itWhesxailDRmMnGjmBnP6jYdp6RdzD5POo/2zbCEdAYMMVo/kBthlnP81kRqdWKMbaKOUDWorE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777722; c=relaxed/simple;
	bh=pCMIRHkcA6YzDHXJByuX51TTRjCk2oBGI7ANXlxd+z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZTcB0tbARMdJkuzkMKvyaj7rplYNhJzuPfPBuZ9mIBWarv+167PV9enyKIbhLlxBDEAwiGaIXynoPGIdpgmmSScI8tLSnap09KajjBBZqUG28LSG/+jkAted+a9EDxmoPqe4QqSsTlwaWTAQpyJ74xiJQUMolNh+T31aK+NLhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6BNZnuf; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6f4bc408e49so24361557b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740777720; x=1741382520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PcCKf2vQjE3H4ps6lNORm4N0nTYQNrHLGbX+LIFyoMM=;
        b=c6BNZnufFhHqa9ToaFipAOL+JAtHIUMzZin0H8w1PMC5uYnK/uacjZX1WlR7gWVi8A
         xU2CO5lD+X+w2GqwO5llNPyeUXHE1TaUsIzR1UcraR4VUZTY54tx5guNf2FvMC7XysyL
         q0V5sKxH14MDH9YEpCzoOsLs9B0FSmI1uVybO6ZguuiyiNo/0zwolS4497e3GpiWWFNZ
         tf6KWB6rOoJvpRxCNMvI6I635MYzGnsqXkIKi6hkrFqiMSUX/qa1v34zyJfBDXWkEO7w
         0uzwmXRxiAtvvbQAiMCMQOZrLL6RzlheneYmMs8xR8WBy3mhGTrX2mLRdp7zg43RSnQj
         pu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740777720; x=1741382520;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcCKf2vQjE3H4ps6lNORm4N0nTYQNrHLGbX+LIFyoMM=;
        b=kMj6ZP77bBSSwcLPzirSYl0+7MjkPvccZxSDF1z02rSkH7XFSMzrfEutvSF0m+1Ti2
         yl2K0g8WF3+FhrNv2+oKmRwhLOzu3oNP2BIM808TBD8rGSc2qo/K/FeSFhTRP/TDx1D9
         Lv99BUNwH0TN17BGC5KK27SscVK2yNuE9ytiHTVmkhBNVhyo0rfCSYyqF6zIeAjB7PoV
         NSqiuSd0FnWqT7E8RFqEpdwKW5a5TlcrQK+hMERoYVE7ErlTPxZ2/DZ49r7aOGJ2TQ95
         KHcMBrTihPNxC5welsHqU9YJM3OwlmpYi97ZoTyzKYj0gcdW7x6C1EQHrdZ8AiK7N7Ua
         1dSw==
X-Forwarded-Encrypted: i=1; AJvYcCVTTKd+nZ+kN/PY9cg7xYu9Bi0iwRV13g0DAGjmA9w20I7n/ZGFpRLqMSZKr+/BHHL9hXUZtId2YNtGjuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyFn96qtUg2yr/cxYN9c5bC93+DyKMjcRfR6AaAV6Jx1b/9xQR
	Rm8Lg8N3KK7IKaeS9KiRouv6m7OtsnAbR9idIPsl/IirJb0MBeT3
X-Gm-Gg: ASbGncs31W7rqAIvhGjpF+GB9B666I/KYKM3DJOxCo75eXpmNKQ1y2LPOQojLWY4DMa
	fqlKAVwh2kfElt+b+ks/5yviqjS3wO1ybYhrQq0PlUruIx7VLN/PKHfZt4wVpBtq7A0fEeFh+kD
	NoX528Ts1uS5xXldvzytnCcwFy+iJ2MxxHEt64LqeGjRIg1B3UIPma3fUpCoqe1xrIbbPIze3vW
	NTxa5HN5SfAeTbyYIpnnJCoWAiQ1mxib74EKh5Z/ygXDgw/RwFgI0nvJ/4/kRTyk0zvU10x9sfQ
	q6ll5he278esgX4iTceFJqzO8zI7wQ==
X-Google-Smtp-Source: AGHT+IHV8+BalWjQQ98R2YG+axIWdSnQZGCo2W2tqEj6EZziT6FUzgu+VloUaTcDIlnVMEjvpHuDfA==
X-Received: by 2002:a05:690c:360d:b0:6e2:1527:446b with SMTP id 00721157ae682-6fd4a08e916mr65064037b3.3.1740777720274;
        Fri, 28 Feb 2025 13:22:00 -0800 (PST)
Received: from [10.138.7.94] ([45.134.140.51])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd3ca679a1sm8891797b3.62.2025.02.28.13.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 13:21:59 -0800 (PST)
Message-ID: <cd9f85a5-0d99-4007-bba2-d792ac9d84da@gmail.com>
Date: Fri, 28 Feb 2025 16:21:58 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] virtio-gpu api: add blob userptr resource
To: Honglei Huang <honglei1.huang@amd.com>, David Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
 Huang Rui <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20250228053650.393646-1-honglei1.huang@amd.com>
 <20250228053650.393646-2-honglei1.huang@amd.com>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <20250228053650.393646-2-honglei1.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 12:36 AM, Honglei Huang wrote:
> From: Honglei Huang <Honglei1.Huang@amd.com>
> 
> Add a new resource for blob resource, called userptr, used for let
> host access guest user space memory, to acquire buffer based userptr
> feature in virtio GPU.
> 
> - The capset VIRTIO_GPU_CAPSET_HSAKMT used for context init,
> in this series patches only HSAKMT context can use the userptr
> feature. HSAKMT is a GPU compute library in HSA stack, like
> the role libdrm in mesa stack.

Userptr should not be limited to HSMKMT contexts.  Userptr can
accelerate shm buffers by avoiding a copy from guest to host, and
it can be implemented using grant tables on Xen.
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)

