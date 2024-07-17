Return-Path: <linux-kernel+bounces-255101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 078CB933BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209B61C22DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732E617F4EC;
	Wed, 17 Jul 2024 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SE3AWkhA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F16217F39A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721214855; cv=none; b=H2NVjlHMIXHBEL21GrbtS2LQ13zYMIYFxgE76WmTkGnA1uArMl35hAicvnqSyWfQwGJ/3XhHqtZLrjf0lk2pAFlY7TryeoXCbZqni1EqeAaa2Scyf5mSPfQIMoEQLo4JkCwxL0bgJVsF6DgJC1hPySYni9vb+88Ujtqqyg5Lt80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721214855; c=relaxed/simple;
	bh=sQzUg2Q/1MYsGWnhU/zaTOxAtlBYe1TRtcDNO8bXWyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tap4OtVNZltXfcak9eM7v2sPCyMhaH83VPTkKDRN/Wgs4KoaNZVCfBVQikKHFvXs99Amg/ZAcn2IMQaOTy2PqYxYqkmhBfUC1194fLTulGLZ94FrW0Zo5DJvlgixxhNaXjhtLiDCWQBrMh/jV6XsdNjuKWWEgwUikRkcayOG1QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SE3AWkhA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721214852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RAGmeywEZ/JgSZ6hAqPsmz089vwWWyWA+lKvknqNmtE=;
	b=SE3AWkhA+4UZaCJekQMUNxUI9cKBoZAZXU1LGG3dxjhyaSgB06lZJDVczgpoPTNGwYLf1r
	s+8nBGvPnKI2f6rg6xfsnAfOVIYhOEP0yOX4kPdcXT6zDidvGMhkUih5aKUN9cWP2p/UoY
	go16Wgh0r/ACUqZjOL6XvY1btn+ijxM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-Hr2A37V8PEiCuaLj-8afZw-1; Wed, 17 Jul 2024 07:14:11 -0400
X-MC-Unique: Hr2A37V8PEiCuaLj-8afZw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36831873b39so372761f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 04:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721214850; x=1721819650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAGmeywEZ/JgSZ6hAqPsmz089vwWWyWA+lKvknqNmtE=;
        b=RZ4nzyq/lnwuiqOiJWvGsDD5pOwnTjGkQLdOfUZmVZMJ8u+y4lTKfmS1Ke2MUnJgt+
         ygcWRMm9JzlFyBvAI9NWheuPlbmKcS+O4lW1LQn1GyBNR7Ow5iJj7h0XJkZ/BDCcyrhq
         HrsjhZEd0qg4Hwy29YKuqEIl3STnT8j+dtlVyzk9UjwJqmPHxMWNg+eRHDABXYmz6qQX
         dj7iPr41sH9vzwF2GQZ06dOyldcakbcUo9gjrMfo/RVG6FGRCxJzm3g4KBqCE40lU+d8
         38Q0gibO5M0wbKWxR1uEPEu3Dkq07OW3uAoNJdZ2AnHhSDaXMaLo23HWFHL2S5ezWR41
         M6vA==
X-Forwarded-Encrypted: i=1; AJvYcCVDH6tBilCI+Y5ZAyZV7JQWhGcmY7qLE33Afi1BovDEkGx068rIwkmKxmt6WqovfIZVMG4UST11jhYJ1EPud5/SoIwQGlcpBy3T4z/o
X-Gm-Message-State: AOJu0YxZ6Mri2HjzWKcBL9jCIMBW3kUjH4HPYZftl0fzHWM8p6tB8O+g
	dM4HRJtAVPLWN5uHsnst7vH2QWogSghaze6f2d82KHkd2x+4t1Jsiop+v4GOGnULJrBzG10ZBFb
	RJPgieA1rE+/mMA+9c0QJreuiaR2BrwXwVvkJtIr2KSfNLK4vebnKYzShCCwAVQ==
X-Received: by 2002:a5d:5f8c:0:b0:367:943e:f436 with SMTP id ffacd0b85a97d-36831652b7cmr1395262f8f.30.1721214850132;
        Wed, 17 Jul 2024 04:14:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkv5VJxD9qI1kB5PB9WhCMM3ozFKBNBC+x5bcWuyaH6WTwCYKMg89QMw7W+wtEnk2KMCsWzg==
X-Received: by 2002:a5d:5f8c:0:b0:367:943e:f436 with SMTP id ffacd0b85a97d-36831652b7cmr1395208f8f.30.1721214849630;
        Wed, 17 Jul 2024 04:14:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbec3sm11450684f8f.85.2024.07.17.04.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 04:14:09 -0700 (PDT)
Message-ID: <f559a33a-6d2e-476d-87f6-cb1887e99b62@redhat.com>
Date: Wed, 17 Jul 2024 13:14:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] printk: Add a short description string to kmsg_dump()
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Petr Mladek
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jani Nikula <jani.nikula@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-hardening@vger.kernel.org
References: <20240702122639.248110-1-jfalempe@redhat.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240702122639.248110-1-jfalempe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 02/07/2024 14:26, Jocelyn Falempe wrote:
> kmsg_dump doesn't forward the panic reason string to the kmsg_dumper
> callback.
> This patch adds a new struct kmsg_dump_detail, that will hold the
> reason and description, and pass it to the dump() callback.
> 
> To avoid updating all kmsg_dump() call, it adds a kmsg_dump_desc()
> function and a macro for backward compatibility.
> 
> I've written this for drm_panic, but it can be useful for other
> kmsg_dumper.
> It allows to see the panic reason, like "sysrq triggered crash"
> or "VFS: Unable to mount root fs on xxxx" on the drm panic screen.
> 
> v2:
>   * Use a struct kmsg_dump_detail to hold the reason and description
>     pointer, for more flexibility if we want to add other parameters.
>     (Kees Cook)
>   * Fix powerpc/nvram_64 build, as I didn't update the forward
>     declaration of oops_to_nvram()
> 
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>   arch/powerpc/kernel/nvram_64.c             |  8 ++++----
>   arch/powerpc/platforms/powernv/opal-kmsg.c |  4 ++--
>   arch/um/kernel/kmsg_dump.c                 |  2 +-
>   drivers/gpu/drm/drm_panic.c                |  4 ++--
>   drivers/hv/hv_common.c                     |  4 ++--
>   drivers/mtd/mtdoops.c                      |  2 +-
>   fs/pstore/platform.c                       | 10 +++++-----
>   include/linux/kmsg_dump.h                  | 22 +++++++++++++++++++---
>   kernel/panic.c                             |  2 +-
>   kernel/printk/printk.c                     | 11 ++++++++---
>   10 files changed, 45 insertions(+), 24 deletions(-)
> 

[...]

I pushed it to drm-misc-next, with the whitespace change in kmsg_dump.h

Thanks all for your reviews and comments.

Best regards,

-- 

Jocelyn


