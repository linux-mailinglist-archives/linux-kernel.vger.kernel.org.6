Return-Path: <linux-kernel+bounces-349945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA29D98FDAD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDAFA283E3F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 07:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059DB136664;
	Fri,  4 Oct 2024 07:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xz8lIaMC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8C01D5AC1
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728026054; cv=none; b=cz2PoGs1HUM8tyiMbq6gzHlM0UxJZ0qF48Cgk2/5A0y/qt9Y2cXU3QxgLbTUWztCMaBq5POcEkIQ276E8gVnx4aS6cyX7yYskapOwiBqHBA1uwt3z14zFp6fDc9Z/UDABPxbG/1abX0rkh2q6D4yEiIixVr3tNLht6JnVQdSObw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728026054; c=relaxed/simple;
	bh=1iMOmJ43CP6yXp20Vygffsp0eQ0LJHRK+2+LtCsCQqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtV4y+4opBDybnCHthBWjBBClIUF7ahZHlJRWTz6nSFBREI8ItioKQyu0cKLJZLwJDuUKESxwm0zHfgPy1bNp/y48VFKCe1BUPfp9amI6IpGBy7kHd2cXQjSyN7i0uM77DycaVIUtUaDRNd4GvMTtsECQzz42WnnSdKwaFxYG9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xz8lIaMC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728026051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hBtwnr0LZruEJbvlzvyuk1+vZcUV6rsB3LNlgkW3ppA=;
	b=Xz8lIaMCGdSjd6MC/L6xu23krO2Twlt5boqi/vp+M7oY+tMSzWtizv18bFnnmdLisje5Cz
	zQz0vwKGT+KMnMEvGLGEIoy2y2Vhuif5alhjIbOBGABD2DOUF51HSICsXfa+p7ZBpWIc61
	0IE/LjeD/v2u4V0TFJrnN1RRsxjZhpA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-4BH6ZVE_NUKmZ-YVNr_QGQ-1; Fri, 04 Oct 2024 03:14:10 -0400
X-MC-Unique: 4BH6ZVE_NUKmZ-YVNr_QGQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37cc4f28e88so1286612f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 00:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728026049; x=1728630849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBtwnr0LZruEJbvlzvyuk1+vZcUV6rsB3LNlgkW3ppA=;
        b=lbF0tc2P2g14KvLS/Mgrbdv/bNuVNmsJXUHQbCTUdUykSi+EnGakQbI7q+QhhklQ2N
         9pt8LiovZnCU/2JEDrF5vlxNBGbcJmmUsw9WdDvekqAlfh13p9ArN1mFo15ArcscN1LB
         JFFljb+3ExPkNLR+K+Ek8JKykmK2jNnilPXweGdmdT3KHNG8fBZ3GZQRzv9xNkn4tpTU
         aZh2LEQZuA+avbNDg9pRQX42fme5srX0DmdWkSk1/q15Rh26pgRfo0sbUtuouzM/mlMp
         F1AoRPg4x+N1JN/NFTnPKm6BQitzCE/0GcqvwAJkYR7Qkt9r0v4jO4kPbQCixn319N5w
         v/tg==
X-Forwarded-Encrypted: i=1; AJvYcCVl590SPvstZBMxMnzKvUImGKypzwvD1sJ44oeMDBjW3Gu//IRnlHGFu7H0j0Ss3gIzAu9FZvzimOvKNY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzqP7TlUjEl+As0AWGycCpbpnc5XiBVhdnkyNpiNkfyIGhoG9u
	oIJlIZ+NDDYTVOwWXo+ymz7wm5zoQ4PK3YizKqzDsPET/k79Er+et67GkXPPmhDk3mRbtiqQ06Y
	+YeuYCB707uOugRUAI5jH3TvepC9Qz9qxjTDRsqUIs5pichUrbvLNwTonao0cQw==
X-Received: by 2002:a5d:5f54:0:b0:37c:cfdc:19ba with SMTP id ffacd0b85a97d-37d0e751784mr2002739f8f.28.1728026048946;
        Fri, 04 Oct 2024 00:14:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5EgGjYY0JfV/z7iaa59W+QZpz8ppmjKMbpPUYbcvmPnVnctrVU3GxGrg0lDO74dDBrAfR4w==
X-Received: by 2002:a5d:5f54:0:b0:37c:cfdc:19ba with SMTP id ffacd0b85a97d-37d0e751784mr2002722f8f.28.1728026048613;
        Fri, 04 Oct 2024 00:14:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d0822995fsm2673066f8f.38.2024.10.04.00.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 00:14:08 -0700 (PDT)
Message-ID: <609cf7e5-0fd6-4636-b5b1-b63fe319db28@redhat.com>
Date: Fri, 4 Oct 2024 09:14:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panic: Select ZLIB_DEFLATE for
 DRM_PANIC_SCREEN_QR_CODE
To: Miguel Ojeda <ojeda@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
References: <20241003230734.653717-1-ojeda@kernel.org>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20241003230734.653717-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/10/2024 01:07, Miguel Ojeda wrote:
> Under `CONFIG_DRM_PANIC_SCREEN_QR_CODE=y`, zlib is used:
> 
>      ld.lld: error: undefined symbol: zlib_deflate_workspacesize
>      >>> referenced by drm_panic.c
>      >>>               drivers/gpu/drm/drm_panic.o:(drm_panic_qr_init) in archive vmlinux.a
> 
> Thus select `CONFIG_ZLIB_DEFLATE`.

Hi, good catch, yes it should select the zlib deflate.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

Best regards,

-- 

Jocelyn

> 
> Fixes: cb5164ac43d0 ("drm/panic: Add a QR code panic screen")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>   drivers/gpu/drm/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 1cb5a4f19293..cf5bc77e2362 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -152,6 +152,7 @@ config DRM_PANIC_SCREEN
>   config DRM_PANIC_SCREEN_QR_CODE
>   	bool "Add a panic screen with a QR code"
>   	depends on DRM_PANIC && RUST
> +	select ZLIB_DEFLATE
>   	help
>   	  This option adds a QR code generator, and a panic screen with a QR
>   	  code. The QR code will contain the last lines of kmsg and other debug
> --
> 2.46.2
> 


