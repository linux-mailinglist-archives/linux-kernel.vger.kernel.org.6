Return-Path: <linux-kernel+bounces-364055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED9A99CA9D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B230A1C22B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A48C15C15F;
	Mon, 14 Oct 2024 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXdA3DBh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F8D1A76A4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910117; cv=none; b=ToT3qftvf1nmZ7aWsZA/7q5sZcALEgfnfeqwfnXM0xBbN5z7tJa0QuHOAiaXuNzhiaBgBe0CycZusSlI3vZd92PpjlVQ4aDByDTD8SrFo6siznvUq3VcaiCJDvzLZud951mqKSExgu7XpBOTDzC4SkDR9MprFmx0PjShlrq+Vbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910117; c=relaxed/simple;
	bh=MhLSQQZS4zqkgAHrN17LB8PubEgDApvdabVlLEP6zsc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ICtouDymsiOUsfZwK8Z8rY3TI6QyYNT044F82GywhQzaAGgPXhktj463cJbqQU+TttnJZj3Bk3g5s/Ch8PymHr9qO+IWcKXkl6z2dCnf/8zZ0h0hrV1EdHTwBZfrb9OR+BkoK1SYvk9awX5N7nfwQLxhAaChsxcCwXYxgvLUzU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fXdA3DBh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728910114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jz+O7ng0GFJAWN74rY5sF0aBksxpe7VRWGO4WN6Z/Hk=;
	b=fXdA3DBhiYOBT/AmQBIuyTlGSV9atxLbSuNJ76mxfnC0TbxAjiMzSyW1j7p8e5pJLjDLsE
	FPu5r99C4g50hMLKWNfVuakzgzhfvlPj2ujGmlpY6do1d6d+fWNJCMHgfl+PJhCHTao5MO
	/BXQotfTg5QPO2qKET9dajsTBUMmeqs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-gd6cIE5WM8eLNaXmN-j2Kg-1; Mon, 14 Oct 2024 08:48:33 -0400
X-MC-Unique: gd6cIE5WM8eLNaXmN-j2Kg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d4854fa0eso2059716f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 05:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728910112; x=1729514912;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jz+O7ng0GFJAWN74rY5sF0aBksxpe7VRWGO4WN6Z/Hk=;
        b=nFMvuwkhgh/U62c0GsqKnTBnucf7qPfv3l28jW0hMdqtCf47FsWPCSEJXFqLyIzhO/
         Aw1ld5cwmhmdXoBoLHlp/m/sAA4A9jYc5p/Ll+s3VYRwu3fdgSCqV2uHMFhWXajPz60M
         DA9NQKC8jxzuIq4XkC8CzTG24QVdXyA42eoLp+U3mil7xIIMA0gGkeZVGW8PKcsunmtD
         DgLa4bj42R9pSVjpRj2dfVzuOaOd3LErYnE5F6SpOgFFXTIYf2PriFNFaBF7RDAnq3V5
         SA8ZoQ3pQygyW912/VjacYf+VKUirGqZiy2fphtyaZqT+RYZPWWkqiu3IiJmdeewMQHA
         uONA==
X-Forwarded-Encrypted: i=1; AJvYcCV50TuEKkFGfAQAHvlVdkR9lIC+DktPX6zZ2Vkp4ocx00cL/1IDVxxv+EVccxxYatV4R4ckIDDdN4duqWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt6h5eJyUoxuMq3g60UHCZvNhtU5Z39gAbAmUcin5zbu7wOJxM
	8nKQpngConef+/wB5UEHoRba+yFVk5XwnXByXXnXcDrMQoZ0rg9mgeiziJb+goFcpSU5ddo5PDa
	folxyrREyhAh+ApyMIfSUTpnzYfmCflb9KaNxPtv/vPWuXIXvneytGzLgQCxKBA==
X-Received: by 2002:a05:600c:3b13:b0:42c:baf9:bee7 with SMTP id 5b1f17b1804b1-4311decab14mr92387655e9.12.1728910111953;
        Mon, 14 Oct 2024 05:48:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNKMVr8mP2u3/Zc4ug5AuewCTZ9DL/dFTdj/lE65CnsD7NnambyLw3qSxBo5sKDk5QAfMgnA==
X-Received: by 2002:a05:600c:3b13:b0:42c:baf9:bee7 with SMTP id 5b1f17b1804b1-4311decab14mr92387475e9.12.1728910111614;
        Mon, 14 Oct 2024 05:48:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ee4aasm11245969f8f.95.2024.10.14.05.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 05:48:31 -0700 (PDT)
Message-ID: <e8b90d70-d5dd-4ae9-8088-ca940d1fd9fa@redhat.com>
Date: Mon, 14 Oct 2024 14:48:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panic: Select ZLIB_DEFLATE for
 DRM_PANIC_SCREEN_QR_CODE
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Miguel Ojeda <ojeda@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
References: <20241003230734.653717-1-ojeda@kernel.org>
 <609cf7e5-0fd6-4636-b5b1-b63fe319db28@redhat.com>
Content-Language: en-US, fr
In-Reply-To: <609cf7e5-0fd6-4636-b5b1-b63fe319db28@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/10/2024 09:14, Jocelyn Falempe wrote:
> On 04/10/2024 01:07, Miguel Ojeda wrote:
>> Under `CONFIG_DRM_PANIC_SCREEN_QR_CODE=y`, zlib is used:
>>
>>      ld.lld: error: undefined symbol: zlib_deflate_workspacesize
>>      >>> referenced by drm_panic.c
>>      >>>               drivers/gpu/drm/drm_panic.o:(drm_panic_qr_init) 
>> in archive vmlinux.a
>>
>> Thus select `CONFIG_ZLIB_DEFLATE`.
> 
> Hi, good catch, yes it should select the zlib deflate.
> 
> Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

I've just pushed it to drm-misc-next.

Thanks for your contribution.

-- 

Jocelyn

> 
> Best regards,
> 


