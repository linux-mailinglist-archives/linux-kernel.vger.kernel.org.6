Return-Path: <linux-kernel+bounces-566344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11E4A676A3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D7547AC18B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2EF20E33E;
	Tue, 18 Mar 2025 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNn77fAG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC37A20E336
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308765; cv=none; b=Zp8VcAr4pFhpj3wKCN8Sa2uYBH/3H7f28A7HHVMZsaBEqxfcbwEHNpqE7s7JzwTAIIxTzE842EHLQlKfbJqVPn6S//oc0ZMw4JX0rosUA0A0dDGv6uEqPPFr4aLe3V6dGhJkvfqr2R7UnjUQo/WU+Ebv0Ptz6Mmh4Ic4/iOrX9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308765; c=relaxed/simple;
	bh=VlmrhLeJPUEFA+lzg8T6jHkvVs+Rt91krv8MHtKaYng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FwkJJ94diXBj3nkffzygOpuO6EcwKN6bQQiS3OYhvb8VkvC6/rIzXxOjTZaTVZtLNcw6TF2m1P41gdIvITE6VRPF8c+He6xp6j5AQD8KC3a/IMuqeaKVS1SMiSRtlyAgVh0hEBEox3P4OQhZlaEugz5XjahD8K0LqnftuHRnmhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNn77fAG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742308760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PsQlwRAe+Vfyt5oYdUWSq8JNPzE0Apo55NHwyi1kdq0=;
	b=DNn77fAGG4/WWx+1iiId+pmBXY7yRNNQ3Kvw5dr1wN32bypFLQqNNJP819zbNewp7AeJy+
	+ON5itX/38sdu4uWYlF/6tMSOkuirZv4Zbfy+r1BDVsyvxkm53bsv+BcWzLn14PU3mfI2G
	Hbs2lwdL4xpcTkLov3b4MfZdQzg9L6E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-R3Az7oHOM-CYW13tBjDB1A-1; Tue, 18 Mar 2025 10:39:17 -0400
X-MC-Unique: R3Az7oHOM-CYW13tBjDB1A-1
X-Mimecast-MFC-AGG-ID: R3Az7oHOM-CYW13tBjDB1A_1742308755
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d3b211d0eso4739065e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308755; x=1742913555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PsQlwRAe+Vfyt5oYdUWSq8JNPzE0Apo55NHwyi1kdq0=;
        b=wHsHV65QoDm2Xu4q09WxJ07mISEXefI5B3xf54s+6m/2F7EUbYrDKFphTOghuL6y9Z
         yXg26d/VOGrHx45MwGMTUTeaH5FeIQglEgtXT42eZaEucqbLSHckICqrTJZzQ3Np1tu6
         mybbVkx7AH9abpM+uyLjhOCPLiISnxgdyuAN9QH6vXKKKE27gRg40BYMrjLWMFOTeGS1
         xSXncXTgKtFH4jqUmM19JxIrOvHO+LoNjKunphdzHOuvj6pntQnkDG8lC81IIxRza34P
         a/EAnS981Xvhp8FhAD2QeCBAn4VnZskuJruS71/PA5lTSDGEUaD0EOn3ah+HCMjoj1ag
         6HwA==
X-Forwarded-Encrypted: i=1; AJvYcCVtgvySO+9mhsRcL8hznYAlQX8btZc4R4kWXZfduQAJiobKPYopKo9lLASOanjqGYnFnGKhRyeHnkpVzP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXysUZx+pBpTD8P81ShJ8iL7vuAaqnKsAAaSTkRhxc9HLz8Dfu
	7Mgn0FlV4cleQ6uVmsEIzz59fMqyvsk5ns/GRef4NkAy1TWLhnM0KvDvoF8kHhHApKEMIXXEhTT
	kd5cUNm3zQYJPnoR5q+oSjAWBwWYAKVgDsWbyLswqXNwjSDVP4ouRqGl1DRFP2g==
X-Gm-Gg: ASbGncuJepphFKSoz16bIbmPfNwzxbpwpKCbhOTf9WoNW1b3LMxodp/lwFtP8bhsYBB
	z2qWOUD+frXwVDayRQQykjMwN1DNaMEIvDgrchpI0vpo6m/aw8bEd59By6ENAjJd8ttj/7x55YG
	yGGruOwIgWr7CzJPFLgHRSnwQY8HUmYvZqe863FP30skfu7WTqrzhRF7HeZ40W1DcXEPPUoTXmm
	Sxw28QPPigq+J6SG9vaFSQ5+IzDzSkCP7fpHATSiPlDLTZ4g0dFDidkYHrcIS2+O/GE3YRqwr4z
	c0RL6U9iqMbzv8UGRR3riOwqJ20eqamoOUq3SLYHehafDA==
X-Received: by 2002:a05:600c:138a:b0:439:873a:1114 with SMTP id 5b1f17b1804b1-43d3bc12751mr24184715e9.6.1742308755378;
        Tue, 18 Mar 2025 07:39:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWUKBTOZHulBPKccJIMkih2ejX9HgOTZC6YQk6IraOUM0a3ImJsw3fgLjtFZUV+DmHGg37Vw==
X-Received: by 2002:a05:600c:138a:b0:439:873a:1114 with SMTP id 5b1f17b1804b1-43d3bc12751mr24184395e9.6.1742308754930;
        Tue, 18 Mar 2025 07:39:14 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d393bb288sm27247155e9.29.2025.03.18.07.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 07:39:14 -0700 (PDT)
Message-ID: <d67a6f99-3d67-4843-8a32-83b086952ab2@redhat.com>
Date: Tue, 18 Mar 2025 15:39:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: remove sb1000 cable modem driver
To: Arnd Bergmann <arnd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
References: <20250312085236.2531870-1-arnd@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250312085236.2531870-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 9:51 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This one is hilariously outdated, it provided a faster downlink over
> TV cable for users of analog modems in the 1990s, through an ISA card.
> 
> The web page for the userspace tools has been broken for 25 years, and
> the driver has only ever seen mechanical updates.
> 
> Link: http://web.archive.org/web/20000611165545/http://home.adelphia.net:80/~siglercm/sb1000.html
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../networking/device_drivers/cable/index.rst |   18 -
>  .../device_drivers/cable/sb1000.rst           |  222 ----
>  .../networking/device_drivers/index.rst       |    1 -
>  arch/powerpc/configs/ppc6xx_defconfig         |    1 -
>  drivers/acpi/acpi_pnp.c                       |    2 -
>  drivers/net/Kconfig                           |   24 -
>  drivers/net/Makefile                          |    1 -
>  drivers/net/sb1000.c                          | 1179 -----------------
>  include/uapi/linux/if_cablemodem.h            |   23 -
>  9 files changed, 1471 deletions(-)
>  delete mode 100644 Documentation/networking/device_drivers/cable/index.rst
>  delete mode 100644 Documentation/networking/device_drivers/cable/sb1000.rst
>  delete mode 100644 drivers/net/sb1000.c
>  delete mode 100644 include/uapi/linux/if_cablemodem.h

I'll wait a little more before applying this one, to possibly allow
explicit ack for the ACPI and powerPC bits.

/P


