Return-Path: <linux-kernel+bounces-257165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82847937617
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21AF3B2282D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008C6824AE;
	Fri, 19 Jul 2024 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YszVuqlS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C9957CBC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721382495; cv=none; b=BuGJtmWJwJTRO+hFXycK4LF4QMiPmmrQo51XhiiU4/8YdHm9g65X7yUV+DDYkr+N9x+rJi6OlU7i6iO0jw5ffTZBvDf2oU1E/xRV3lvwlVwjezfp0qkYwLHq7E3mE1/4QKRmwlDPtTORNCCDIKEcW5sD6FtJVroKCgekXxaO9HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721382495; c=relaxed/simple;
	bh=h3l2T5sEp2By360+/5+5liuYMkniFkS4ZoyWnatVDmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vCxMxD4fnXQo5gjzYIW+xRr0t1t/9evNdSUcstZtMS2wJNjsIwcNYuBI/SimQGU2yRIh79OagmlUYBQER0HBJOowDco+C+tOIoPibtmDNEoqpBaCIyG7/nttKCvZK2/R+b0TQxKCvTYiW64rbN/wurU7REI+cIRX+C728xmn8rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YszVuqlS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721382492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wrXqc6+BI9y9N/9R3c5HOJPDPGVypzLRzTKRBdzUEf4=;
	b=YszVuqlSpR+XvWp6qrCM13UaFLB6vBxeJkPBlm/bUBPe30BcalImfndjTyVBRXl/7E7UtL
	BmTYr4DemD8V2o3A3+wQmGPxxs0all9wdlHHaNaFX8NQPNp09bq6VgUwWXfA6EMzxzJCyi
	GoZeLErKujU9JzNF6dSbx9/zjfFRobM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-TK5SVdEfPb-pwV-W7eccgQ-1; Fri, 19 Jul 2024 05:48:10 -0400
X-MC-Unique: TK5SVdEfPb-pwV-W7eccgQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-368448dfe12so320569f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 02:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721382489; x=1721987289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrXqc6+BI9y9N/9R3c5HOJPDPGVypzLRzTKRBdzUEf4=;
        b=sVziid9bOGaYHn4ShDjI3t1oKo4HG8y+0/dnB/IDEVipyca3qIEEYCbr35e4SYmhsM
         gPmxQ5MR7GgFs9phC/e/E2z1Bd8wTNBi8YFewMhCjfdPFOgBVeKd1Gns5mZ01MJoHYPo
         LWhxETGk+Xa2ZH/kiuXD0U1xmS+J+gRUpnQe14lh7ts7Anh5eH/WD9D9Tzvftwz1KCER
         LLO98MH9CKlfmExZ9gWhCqkYzbVzoWJDmwzI0Vv4/2UGkcp3WZVnomrGeb617cL2QP+w
         TCOsq/f1wcZs8b9q7+ncqPVYdcAtVbx2q21ldl52AmbTS0Hfql7ZUY9wL/imgBusl27s
         my7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/jNIMs3bDB7bkm7E0p9qucHWfgi+REg1wdUbgxfMvWCyWpMGYLfh6RYAEjSUNRrhgJ5EFiiH9sZmLYEGQBtQy76uWAArlVfpGfzvO
X-Gm-Message-State: AOJu0YycAuF0LdEI/a7j5onIHxgmkLW4gUWHADUO9/MrkNnzprEmwZ7z
	qPkxCULVFVGb4K2sCDCW2aHBTlCNto83+TpXPu620753IaYZlPOhTbQtSQElWVXEKbBUEHyaDRR
	ItdIwvzRo2DbWw94qz4yNNmjFWjOjgyqknywxEQN5DdbPH9ijFFCcLmAbFXvcVA==
X-Received: by 2002:adf:e650:0:b0:368:3562:7c76 with SMTP id ffacd0b85a97d-368742a29e8mr1315309f8f.3.1721382489197;
        Fri, 19 Jul 2024 02:48:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK22G63JIRPE2xIFnYosHW2rA1aTs4UvzPTnx79Ujjp4yRSq10kKEZSH+bF2E+A1zNhnULEQ==
X-Received: by 2002:adf:e650:0:b0:368:3562:7c76 with SMTP id ffacd0b85a97d-368742a29e8mr1315291f8f.3.1721382488767;
        Fri, 19 Jul 2024 02:48:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787cee03sm1119215f8f.76.2024.07.19.02.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 02:48:08 -0700 (PDT)
Message-ID: <031ac173-412c-4d14-ad07-52e438f86790@redhat.com>
Date: Fri, 19 Jul 2024 11:48:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] drm/panic: Remove build time dependency with
 FRAMEBUFFER_CONSOLE
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Helge Deller <deller@gmx.de>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
References: <20240717090102.968152-1-jfalempe@redhat.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240717090102.968152-1-jfalempe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/07/2024 10:48, Jocelyn Falempe wrote:
> When proposing to enable DRM_PANIC on Fedora, some users raised concern about the need to disable VT_CONSOLE.
> So this is my new attempt to avoid fbcon/vt_console to overwrite the panic screen.
> This time it doesn't involve any locking, so it should be safe.
> I added a skip_panic option in struct fb_info, and check if this option and the panic_cpu are set in fb_is_inactive(), to prevent any framebuffer operation.
> Also skip_panic is only true if the drm driver supports drm_panic, so you will still get the VT panic info on drivers that don't have drm_panic support yet.
> 

Thanks all,

I've just pushed them to drm-misc-next, with the required changes.
(splitting patch 2 in 2, and moving function prototype to 
drm_crtc_internal.h).

Best regards,

-- 

Jocelyn


> Jocelyn Falempe (3):
>    drm/panic: Add drm_panic_is_enabled()
>    fbcon: Add an option to disable fbcon in panic.
>    drm/panic: Remove build time dependency with FRAMEBUFFER_CONSOLE
> 
>   drivers/gpu/drm/Kconfig          |  2 +-
>   drivers/gpu/drm/drm_fb_helper.c  |  2 ++
>   drivers/gpu/drm/drm_panic.c      | 20 ++++++++++++++++++++
>   drivers/video/fbdev/core/fbcon.c |  7 ++++++-
>   include/drm/drm_panic.h          |  2 ++
>   include/linux/fb.h               |  1 +
>   6 files changed, 32 insertions(+), 2 deletions(-)
> 
> 
> base-commit: a237f217bad50c381773da5b00442710d1449098


