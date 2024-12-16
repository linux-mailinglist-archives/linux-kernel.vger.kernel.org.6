Return-Path: <linux-kernel+bounces-447190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBA99F2EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 937177A1FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5529203D7A;
	Mon, 16 Dec 2024 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JzhUlFdk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AC3203D77
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734346796; cv=none; b=SuUZe917FJUSVveyiwexcAYwyPs31TITz8XU/dnHN1NNfBoDo+lX4gCDxDrg8PwMqpGA739L0KE4TBAAtfbb8n0vfR/tto38275d5HSk2899XCdvDwnab6Qy3irmKBnTRdbCDpyD34qLhZXl6icxat4OiMH8lYnyH3aXF/Rqeqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734346796; c=relaxed/simple;
	bh=iorA5OYNQm4hA0zZ5bMOFM/kAOGJ1SyiTmmaMahAhCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8NzpvxFqafOXQZQuJ/vr5KKdfaTN8W6iRi0+aX+XwGUi7mflYQmk+OzaJZ7Y4EreOUX7nDeZRicm74mwqlmt1wQf+Rbof2uFCUYsg2QH73RN6tg470ZKdyLhDLgGm3vOBVMkuJExpHGBrsag2H3KlXJ0tEDIGK1i83fEZwNnQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JzhUlFdk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734346793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lkpo1WbWSh48AVx54wAJmJO7g1QHhOlv/ZWr/VtszTw=;
	b=JzhUlFdkIn2Jxv5g4/j+mwsQG3xJjzige9fdzSYKxu1tFhSgizEIydsFtxwHphljp/nIc1
	URBxPEiTr+idZDUnWO1nRQ0XylMH0/UXtV91aPfJmqS8IhVKTbQeLc0aOKazdVB6g0xpw+
	5wG0oqhlOWNBbb8/WiLZ0XzjNVDF1PE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-1Malz-QlM3aTEYbfXI2Zfg-1; Mon, 16 Dec 2024 05:59:52 -0500
X-MC-Unique: 1Malz-QlM3aTEYbfXI2Zfg-1
X-Mimecast-MFC-AGG-ID: 1Malz-QlM3aTEYbfXI2Zfg
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa67f18cb95so436614966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 02:59:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734346791; x=1734951591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lkpo1WbWSh48AVx54wAJmJO7g1QHhOlv/ZWr/VtszTw=;
        b=rb7Erd5ytEVCLmEIZReRQGoF1VdtrQbF/MG8oTQcvDf5IY4NznyoPUuF6YO82AnoWp
         62fyaQSJ1gn7y/fexPNgCh8v9zv+HKlIXMWX60QesKTsXWcCRaFUmwb/8zrzSnRW15N/
         qQtAQOYIYdv7XJj0DgBzlyVgq1wRa3gY4uQ6MyklGp/p+csu9jfs/w1QrnZVZONQSP5T
         F0zbUEGsA/YadtWYsRwkU0f6FWrcaEJE/h6tHHPiL2zN/Km3wdXC8rou2c7ioZmHudtE
         mg0gaZz6exrWrk3VHVjHsXh1y6Bb9AhJGtJi238jY52qmCxSwPBaLQTboKUOhkqeqWdg
         1AOg==
X-Forwarded-Encrypted: i=1; AJvYcCUcD4KrkSDThRwN6wFK3jQrct4usyNkz/fVWu6C6z6c1ehe8SL9cFU3bNH1b2eesFv0lo4QjhVNhFsAzy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpBF65ihUGLKKBU3mLtKQaTuT+gxbli0ldbqVRSd1DQIZZAwV1
	MQdn8Js6YWXuywzeOwtZLWxywyaYeoIO+nB6y1a6kdmNz3b97Zcoi9fgz7CAy3M5HWbbKrTTbjf
	unuqiCNlVKyP1GdLJ/F1CcDQfjluS9tBqwrxqNw00SyuJ5pfYAYr63SH5A7ge2A==
X-Gm-Gg: ASbGncuNrG6g7hrnnQ9Vq3tbqP4TG+KCo3u85m0hEZTkytD12erMsubQw6KOkoBKw5I
	q/lbc7QAXbjNZgGv1XVJ4itwlU9ipe2VS7ZXsR0pVuVMYFGwrpy7x25Nch/BWKkiGTFR2fEZIcS
	TUe6ZH1dF3tpa+EZMYTBb8j1TJa6VMaRmkUnxFrc76qniQc9h0qdnCyY6nGsbZLUbdY6qjG8+YF
	6ll3fPVu8TC5yLdN6r4qQ26k8BWgqvqCqTD58yOVnyAb0No487Td+Y1K4thU2uGp3P3vEN7gw0n
	s2vzBeeOqn8gE2IXBfjuNMzCwD4X+6qHpkljIOyWMOpxsvbEDOpY6D3QDsSieVA2kDJrF7At7Mx
	KAR1PBr7PtT5Fyh+9ktChSkYJYXHT8bk=
X-Received: by 2002:a17:906:6d0d:b0:aab:8a24:d5a5 with SMTP id a640c23a62f3a-aab8a24d827mr951284466b.30.1734346790858;
        Mon, 16 Dec 2024 02:59:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+h1sNFs/8Xo5nQoGNANlv3qvetEY/2jgpTfhAT6zKt7fDhepc2lAMagxKx/TVYIH3kB2ShQ==
X-Received: by 2002:a17:906:6d0d:b0:aab:8a24:d5a5 with SMTP id a640c23a62f3a-aab8a24d827mr951281966b.30.1734346790529;
        Mon, 16 Dec 2024 02:59:50 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638a12dsm315155966b.134.2024.12.16.02.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 02:59:50 -0800 (PST)
Message-ID: <2513e942-6391-4a96-b487-1e4ba19b7aeb@redhat.com>
Date: Mon, 16 Dec 2024 11:59:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vboxvideo: Remove unused hgsmi_cursor_position
To: linux@treblig.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de
Cc: airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241215220014.452537-1-linux@treblig.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241215220014.452537-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 15-Dec-24 11:00 PM, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> hgsmi_cursor_position() has been unused since 2018's
> commit 35f3288c453e ("staging: vboxvideo: Atomic phase 1: convert cursor to
> universal plane")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/gpu/drm/vboxvideo/hgsmi_base.c      | 37 ---------------------
>  drivers/gpu/drm/vboxvideo/vboxvideo_guest.h |  2 --
>  2 files changed, 39 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vboxvideo/hgsmi_base.c b/drivers/gpu/drm/vboxvideo/hgsmi_base.c
> index 87dccaecc3e5..db994aeaa0f9 100644
> --- a/drivers/gpu/drm/vboxvideo/hgsmi_base.c
> +++ b/drivers/gpu/drm/vboxvideo/hgsmi_base.c
> @@ -181,40 +181,3 @@ int hgsmi_update_pointer_shape(struct gen_pool *ctx, u32 flags,
>  
>  	return rc;
>  }
> -
> -/**
> - * hgsmi_cursor_position - Report the guest cursor position.  The host may
> - *                         wish to use this information to re-position its
> - *                         own cursor (though this is currently unlikely).
> - *                         The current host cursor position is returned.
> - * Return: 0 or negative errno value.
> - * @ctx:              The context containing the heap used.
> - * @report_position:  Are we reporting a position?
> - * @x:                Guest cursor X position.
> - * @y:                Guest cursor Y position.
> - * @x_host:           Host cursor X position is stored here.  Optional.
> - * @y_host:           Host cursor Y position is stored here.  Optional.
> - */
> -int hgsmi_cursor_position(struct gen_pool *ctx, bool report_position,
> -			  u32 x, u32 y, u32 *x_host, u32 *y_host)
> -{
> -	struct vbva_cursor_position *p;
> -
> -	p = hgsmi_buffer_alloc(ctx, sizeof(*p), HGSMI_CH_VBVA,
> -			       VBVA_CURSOR_POSITION);
> -	if (!p)
> -		return -ENOMEM;
> -
> -	p->report_position = report_position;
> -	p->x = x;
> -	p->y = y;
> -
> -	hgsmi_buffer_submit(ctx, p);
> -
> -	*x_host = p->x;
> -	*y_host = p->y;
> -
> -	hgsmi_buffer_free(ctx, p);
> -
> -	return 0;
> -}
> diff --git a/drivers/gpu/drm/vboxvideo/vboxvideo_guest.h b/drivers/gpu/drm/vboxvideo/vboxvideo_guest.h
> index 55fcee3a6470..643c4448bdcb 100644
> --- a/drivers/gpu/drm/vboxvideo/vboxvideo_guest.h
> +++ b/drivers/gpu/drm/vboxvideo/vboxvideo_guest.h
> @@ -34,8 +34,6 @@ int hgsmi_query_conf(struct gen_pool *ctx, u32 index, u32 *value_ret);
>  int hgsmi_update_pointer_shape(struct gen_pool *ctx, u32 flags,
>  			       u32 hot_x, u32 hot_y, u32 width, u32 height,
>  			       u8 *pixels, u32 len);
> -int hgsmi_cursor_position(struct gen_pool *ctx, bool report_position,
> -			  u32 x, u32 y, u32 *x_host, u32 *y_host);
>  
>  bool vbva_enable(struct vbva_buf_ctx *vbva_ctx, struct gen_pool *ctx,
>  		 struct vbva_buffer *vbva, s32 screen);


