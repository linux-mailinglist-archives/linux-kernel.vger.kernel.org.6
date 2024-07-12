Return-Path: <linux-kernel+bounces-250754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D968492FC4D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070FA1C2162F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563BB17164B;
	Fri, 12 Jul 2024 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkQjljxl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2938716B3A6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793506; cv=none; b=OBwIXKAWUS4WxFyRQEz9Yz2MxGZHyPh22y2bfJ1rqXlhK4ppc/2m0e0YERXB+GnPvqhXEXsMqvyKMxJG4VWked/JSWyeeCl9jdvCQ9lupKPnnMWHsKCmGrAP2Owo8pRuX8ER1qNmedjd2Ah+1Ry82Syc2AOCJOe5//pM/Xa3fy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793506; c=relaxed/simple;
	bh=VYT4EUbGnMCQC1n9ebq+pDVC9xpjFj7DYFt7QmAktps=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rb9um3+z/5xmlJQmDmnRJHRWNKY8f19su+/VioQs5lD5Liak2XK1ikwSudpx1ZNMosc0OpUwBV9gSwRPNidSsgqbg23gFwnc5/qbcUuwwiRvR4U/qC/gwOEZraJ8zYZZCDrT0NmVQTlAwVwICW4kJJA1Qojdjb7B2/39Jz+xwC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HkQjljxl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720793504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2DwS+N+WpDe9hXUlwXatDaB5K36zULgGVjjk0aits0=;
	b=HkQjljxlILzTzV1aj+mMzoq99YUaImdsbkQj5kio7EJKjoJu1moa6thlhUZw6ARtpFljpm
	K37lKQDd5fQkMQ4p1bUUzeA4RJNz9vVieSGSlgA80oi/UGUzDFuLKQZosvebsgWdYp/VHK
	TAyvSPCBZi/LxcNRpcxUQtAfUgfcLQM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-nsWCdpwlMqmcP4QelKAusQ-1; Fri, 12 Jul 2024 10:11:42 -0400
X-MC-Unique: nsWCdpwlMqmcP4QelKAusQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-367a058fa21so1144418f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720793501; x=1721398301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2DwS+N+WpDe9hXUlwXatDaB5K36zULgGVjjk0aits0=;
        b=ERIQNSLqD6EQ1ChEjPZjYmOKgD3Z1PftTJ1Q1+RYOBd50FqWv34dzr9QIpVAM2Bdyz
         rezUXkmxG50p2y+2zUje3PzvfL7SL9Yzv+iuGNhVfTHvpcW5msXxD46H5AYE6O12Qs0H
         sie7rAp6tMljtORhCX9/qW/mf0HcKBv+9iU2VRFbxwq4svMzeUNBJjlfriMZ3AbHLW09
         0a1HqsLzYg7tk+iKeiw9OLEadvvQ7foBW5EE8c24RQ89t71TFlxWwIBJnPgeW6dTpktM
         WU5aRg3AGwMUnhs/PPK2SOtRV3C2dxfNyGDPbCAphWcXMu6/prFihTdiDjo6z7goVu9O
         3wbg==
X-Forwarded-Encrypted: i=1; AJvYcCWxJkBpZDcBhnRpcGpG2pOOciudmYRgO1I7biqrx3z71FBGmTpLrx5+FxGxzacEOepuP4eEogqrmPOYsXWKrqaqsdekpaqMa99CyZwW
X-Gm-Message-State: AOJu0YzsnJsbcUlg9iXXMjYpn93Rdnuvgx1iAsqvx+4iqrpAsnK+PT2d
	9Vs4oKfcid0ZJ20jlHnZ8kPik3S8NiZWlDFNEg+u0ZFwLFhU8UheAabXu+m6n7Bg3U2+hhPLJyp
	i2k65yHrjEDQZeq9LPEnPaDzupJPbK66RB+/UcgmM0wx1pNdlxr6uM/av6RKTww==
X-Received: by 2002:adf:f8d2:0:b0:367:40eb:a3c3 with SMTP id ffacd0b85a97d-36804fec57emr1911294f8f.34.1720793501790;
        Fri, 12 Jul 2024 07:11:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf3U4d9gFM4veykTOQEiy8D2ryeNYD+ff/pVMiWh3YGrTu6bLAg3UO2081Jf+2o1pI3Alwgw==
X-Received: by 2002:adf:f8d2:0:b0:367:40eb:a3c3 with SMTP id ffacd0b85a97d-36804fec57emr1911266f8f.34.1720793501451;
        Fri, 12 Jul 2024 07:11:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e187sm10376600f8f.21.2024.07.12.07.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 07:11:40 -0700 (PDT)
Message-ID: <a24ea2d7-9f48-412c-9a40-9624f6c4f9d9@redhat.com>
Date: Fri, 12 Jul 2024 16:11:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] printk: Add a short description string to kmsg_dump()
To: Kees Cook <kees@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jani Nikula <jani.nikula@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-hardening@vger.kernel.org
References: <20240702122639.248110-1-jfalempe@redhat.com>
 <2d886ba5-950b-4dff-81ea-8748d7d67c55@redhat.com>
 <277007E3-48FA-482C-9EE0-FA28F470D6C4@kernel.org>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <277007E3-48FA-482C-9EE0-FA28F470D6C4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/07/2024 15:34, Kees Cook wrote:
> 
> 
> On July 12, 2024 2:59:30 AM PDT, Jocelyn Falempe <jfalempe@redhat.com> wrote:
>> Gentle ping, I need reviews from powerpc, usermod linux, mtd, pstore and hyperv, to be able to push it in the drm-misc tree.
> 
> Oops, I thought I'd Acked already!
> 
> Acked-by: Kees Cook <kees@kernel.org>
> 
> And, yeah, as mpe said, you're all good to take this via drm-misc.

Thanks a lot. If there is no objection I will push it to drm-misc mid 
next week. I may have all required acks by then.
> 
> Thanks!
> 
> -Kees
> 
> 

Best regards,

-- 

Jocelyn


