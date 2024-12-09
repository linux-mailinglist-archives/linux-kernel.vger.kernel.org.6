Return-Path: <linux-kernel+bounces-437288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F6D9E9147
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28D5161D72
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EB621883A;
	Mon,  9 Dec 2024 11:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCbItoKL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD1C21858B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742083; cv=none; b=uqnb+UvPs+5KwcAMWyyhMl3KmT/BBLznAX3QTlMzqIVBWfPDIKcL+yoeTNCnkd256wF+ej6OtswAtq656SdeijD3wgoqrvPT7TfbcRI9/Dc5e1zKuCWK7GlXQO7+SzUoTOMrOj84n++CvPRTMqVfzXZ1bdRB994INBEEdnJNIx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742083; c=relaxed/simple;
	bh=T+YxWHS3C9ZSiHc+chPHEh+AeP96E4yR7QuzR5ljdKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pICGdCdeFMseDpVX7EAKMx8QFdksfBma7VRz5qFNS2RjMJOOkPmz8DFzg4zBMUMmpsztWZiQQORPrTL0N2nuUXAetqbWBEwJ4ugO8zWGdYWw65gk3k5fgU7q5sCm9QizwBBrZksV22NO/p5o3SxY4oAd20IrUJR8TVovlPBExV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SCbItoKL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733742080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NO6ec67okvv9M56zFhDtp0FFmwC2iQhXha5CQcXffcY=;
	b=SCbItoKLlyv42iSW0V33izv3sOHlvtObHCZ+xUf21QJ0FQTBfQaQfwO++6M3eVxx+slYZM
	3evj0dzbKNxA6DHk8IfmnG0dAL7eIh1ogmD8TT3HRT5h3PNyq7LncdgVXCU/7iF7CyV6Cv
	qyC27xxG9eocy7CyfQynSJObrUOvAX4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-1YtI06cfP269-1om-2ARqA-1; Mon, 09 Dec 2024 06:01:19 -0500
X-MC-Unique: 1YtI06cfP269-1om-2ARqA-1
X-Mimecast-MFC-AGG-ID: 1YtI06cfP269-1om-2ARqA
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa63b02c69cso341173266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:01:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742078; x=1734346878;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NO6ec67okvv9M56zFhDtp0FFmwC2iQhXha5CQcXffcY=;
        b=gh6YfwR9egSi4iqMCF3RwJH48whdGSgvNK/ZE8iaOI4dYCUG5hHW/Lk73AzOULOU3U
         cpHZTE4hnkOM5PxvrZYKCPQupJckDyTxb5LVviVr+pDLQ75JvXLYqWETfZkEgwTUoxdE
         TeJKi/pPYpLDF00J3WgERzgqoxpqkOgHsAUNNXUYUBRgYr5c3uJ8Pc2ZyiTPX2/wEhJq
         cuyQFTZ9vKSIu+SgZ6VmBhm9vPogW739ZluUrbpzBfrlYz9jPw+mUgmzLxc9/gv41Xsw
         jrcvpQx24rutqmnTK6KI8nT+vqzi8ck7+aNeaDcWzlPAl20oXjfgliQaheNMWs80/J0q
         cJyA==
X-Forwarded-Encrypted: i=1; AJvYcCXE4OBJBLYsk6r/2moqZ5947fKogDXzYwp0lmuaJforBNGNzBVh/EIG0EB0pj4D5TxcsYZ+9IaIUjb7XMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxprbwsUAT9jPrVBAfaOYAOGU0752uzkInkeVgCC/Lum9T5M2T+
	3JuvkjxE1tCzcqXUpTBkOwwYF8RVSgJvPvYRXsALpXsYSmqb8yJ/XFa4KWgzN27lqlqVGBEouql
	D0ifUdFQRTcTnKTTj7Kll0lmFbKF8kmYaFyWVzM2AG5qBydX0T82r22LiyFELqQ==
X-Gm-Gg: ASbGncuQh/1cp94cq8hcnJTFK4mTJwZtkSXNpWV2GDknBRyXwDW1G682lkhQ+IeQgGr
	9RM6+N/nM3j1L4D3SghRnRfrFhHILz+sP91Kv3Xw03PhqqOnLAP/ApfRdoYa/OPf67ATBBWV2qy
	R5LjidH05kRbGX6Yb9gIN1/7algEc3v/eACXDEji7WC+8JES/bblkGieONAx1N6y8MkQaQtlFgp
	HeNf2R6taa4noLtqZwqN88unhfERAfHhuWosPm0XBTjn4xVfRH3IQ==
X-Received: by 2002:a17:907:7854:b0:aa6:79c0:d8ce with SMTP id a640c23a62f3a-aa679c0dd17mr431692466b.1.1733742077714;
        Mon, 09 Dec 2024 03:01:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn/LCpkxsb9dv/71P5EH3sArKezZObZ8yWTt35AHgOIcEPgweUp9Z0CUhOTo5YwwEpuOfKYw==
X-Received: by 2002:a17:907:7854:b0:aa6:79c0:d8ce with SMTP id a640c23a62f3a-aa679c0dd17mr431688966b.1.1733742077280;
        Mon, 09 Dec 2024 03:01:17 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa69448304asm65009866b.45.2024.12.09.03.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 03:01:16 -0800 (PST)
Message-ID: <e3316372-d109-4d2e-ad2b-8989babdf546@redhat.com>
Date: Mon, 9 Dec 2024 12:01:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] media: uvcvideo: Two +1 fixes for async controls
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241203-uvc-fix-async-v6-0-26c867231118@chromium.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241203-uvc-fix-async-v6-0-26c867231118@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3-Dec-24 10:20 PM, Ricardo Ribalda wrote:
> This patchset fixes two +1 bugs with the async controls for the uvc driver.
> 
> They were found while implementing the granular PM, but I am sending
> them as a separate patches, so they can be reviewed sooner. They fix
> real issues in the driver that need to be taken care.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Ricardo, Thank you for your patches.

I have merged patches 1-4 into:

https://gitlab.freedesktop.org/linux-media/users/uvc/-/commits/next/

now.

Regards,

Hans



> ---
> Changes in v6:
> - Swap order of patches
> - Use uvc_ctrl_set_handle again
> - Move loaded=0 to uvc_ctrl_status_event()
> - Link to v5: https://lore.kernel.org/r/20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org
> 
> Changes in v5:
> - Move set handle to the entity_commit
> - Replace uvc_ctrl_set_handle with get/put_handle.
> - Add a patch to flush the cache of async controls.
> - Link to v4: https://lore.kernel.org/r/20241129-uvc-fix-async-v4-0-f23784dba80f@chromium.org
> 
> Changes in v4:
> - Fix implementation of uvc_ctrl_set_handle.
> - Link to v3: https://lore.kernel.org/r/20241129-uvc-fix-async-v3-0-ab675ce66db7@chromium.org
> 
> Changes in v3:
> - change again! order of patches.
> - Introduce uvc_ctrl_set_handle.
> - Do not change ctrl->handle if it is not NULL.
> 
> Changes in v2:
> - Annotate lockdep
> - ctrl->handle != handle
> - Change order of patches
> - Move documentation of mutex
> - Link to v1: https://lore.kernel.org/r/20241127-uvc-fix-async-v1-0-eb8722531b8c@chromium.org
> 
> ---
> Ricardo Ribalda (5):
>       media: uvcvideo: Only save async fh if success
>       media: uvcvideo: Remove redundant NULL assignment
>       media: uvcvideo: Remove dangling pointers
>       media: uvcvideo: Annotate lock requirements for uvc_ctrl_set
>       media: uvcvideo: Flush the control cache when we get an event
> 
>  drivers/media/usb/uvc/uvc_ctrl.c | 83 ++++++++++++++++++++++++++++++++++------
>  drivers/media/usb/uvc/uvc_v4l2.c |  2 +
>  drivers/media/usb/uvc/uvcvideo.h |  9 ++++-
>  3 files changed, 82 insertions(+), 12 deletions(-)
> ---
> base-commit: 291a8d98186f0a704cb954855d2ae3233971f07d
> change-id: 20241127-uvc-fix-async-2c9d40413ad8
> 
> Best regards,


