Return-Path: <linux-kernel+bounces-232084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 423A491A2F0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20F61F234FC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB3C13AD09;
	Thu, 27 Jun 2024 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKHsppYI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9392B6D1C1
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719481621; cv=none; b=Hq9uVPyaH70M3dYpa8IDsR4Bn95wCQLFnEi8vpWhGjEfCnXDVH4X5EKZItwM8InjE0Ujqs/Ift/xqDiD+1XinjWcY12ctdSgtJgSq8F+1Ny1EDNI/snbRWX98gqLIM7OzMB8AUP+V2f+7T7jm8E0eyT9tXTON9MgstxRDeAaW0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719481621; c=relaxed/simple;
	bh=1LihxitQAcSiCHxHIeZv1YeeSfyAPFANIj4xYf5HbCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fkDx61ccPpEKs4usqnDxmsg2pfkrpvdwJX3g/UXVzDLP0IjhU42RdGi/2uNL0P3Mqreoc8FdntUVRnARbUGytMcwqHhie5K/lR0WjmzqEP3nWXENH4Q/1maffx8GAWHQRCe0FAFG0p1ECc5AasnxHg9JX15vQpZnl1CFF+RqLU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QKHsppYI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719481618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/aRbMqnFPqElcujOpfk6cQ/iT5TUsEaniaGLjqKo9qI=;
	b=QKHsppYIeJLrNqaxytIF+pX/JrYKiEDE1YeUK2Iq38tkjeCDAOZCfYKyalG19GLvUgJBqx
	qSy9kjqE1QOc0xNmmS6eXAnbtlacl62BLEirh8LNlpvfiuJjBdMElWF485/Skb//4YCrAu
	mpyFBuJnABVjDVYqVw27jPOnHmyxFnI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-p_RBVBGcNSKTkp7ZzBvmtw-1; Thu, 27 Jun 2024 05:46:55 -0400
X-MC-Unique: p_RBVBGcNSKTkp7ZzBvmtw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52cdec8a6a7so3764532e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 02:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719481614; x=1720086414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/aRbMqnFPqElcujOpfk6cQ/iT5TUsEaniaGLjqKo9qI=;
        b=w2nJHyjUF1Tn2rTxjXG/qqVTjVrzRVjJQZLhOYr8nieE9NeiM+KwS3EVjhksoBd3Ac
         tPoFRBIxh6thSeAfj91ZN9kaSzZfOJf3ltB5CeUsFvtCI5pdjdPGJwvjeivBWKusdIZb
         XvaHh2UqtT55oPhlCNH+vj9LTyYA14gar7AF5svvIR/HhV1RMnLP7DxouavIawM+N+dl
         oe+9uWdj4ep//DKn/D5CGJ2bdtLXsKqIFFyulShzF8DlRbtUFmE1ZYaEk5Mh6mRYoz9L
         NPFn80ISxiWBORFUbrYRL15tv5MXMiiYu9Tjz1pThdztIvHm5H4kGeQLDqWJPSF4uLfo
         F2Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXNa3ruESsRh567Z2UNzQxI+RH2XGeQhKrn+gtqqYn3ism+4qbDsxNwdCXp7gv4BW83HUDKVUM0raTezGDRa0a/VzVCX3SW9AXeVfs+
X-Gm-Message-State: AOJu0YymyHp9aeqsGOdsjsTaDcMCucYCJCnFpx+btjhZGfUDNjlJbb/v
	bbGideP3Xtv1Fy3mMq5DjJF9OqG1Q/cNopzrUcee/hLeTLIsYjR/tks6jbg1PbHNkv0bFFHBlGi
	MJy1FcWOIbHOd0Vr5Lvd2eL7sT3/WroVKmZJAoimq+GjxIOvrOd9cu4zOug2FZg==
X-Received: by 2002:a05:6512:324a:b0:52c:9e25:978d with SMTP id 2adb3069b0e04-52ce185e46amr6953676e87.45.1719481614263;
        Thu, 27 Jun 2024 02:46:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNBRY4osLL4QYw4x+YKt8+rUQooLZRv8TYqrLSEg+HIfJ8udA+56TenAyL15Sctcq9KkjLag==
X-Received: by 2002:a05:6512:324a:b0:52c:9e25:978d with SMTP id 2adb3069b0e04-52ce185e46amr6953664e87.45.1719481613904;
        Thu, 27 Jun 2024 02:46:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e? ([2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b66fcfsm18056315e9.18.2024.06.27.02.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 02:46:53 -0700 (PDT)
Message-ID: <f85405ee-12ce-49a7-8c44-c4c4915d999d@redhat.com>
Date: Thu, 27 Jun 2024 11:46:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/panic: Miscellaneous fixes
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <cover.1719391132.git.geert+renesas@glider.be>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <cover.1719391132.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 26/06/2024 10:41, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> Here are two more fixes for the DRM panic code.
> 
> Thanks for your comments!

Thanks for your fixes, they are now in drm-misc-next.

Best regards,

-- 

Jocelyn

> 
> Geert Uytterhoeven (2):
>    drm/panic: Do not select DRM_KMS_HELPER
>    drm/panic: Restrict graphical logo handling to built-in
> 
>   drivers/gpu/drm/Kconfig     | 1 -
>   drivers/gpu/drm/drm_panic.c | 3 +--
>   2 files changed, 1 insertion(+), 3 deletions(-)
> 


