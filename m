Return-Path: <linux-kernel+bounces-443500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC729EF25D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3FEF290954
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D20222D6D;
	Thu, 12 Dec 2024 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDgLeLlp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7877621CFEA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021478; cv=none; b=bGr+Lsh+nqjYPgblDiPGOkLVaBvzyNsczVh6AyZGWAJgsqRy7nIDNgWZzEq08wxWpCfv3dcn7mYmcXTCiqzBQWmVx3+hQtw72OUxXFi5U3IPDn5jMdPEQ0/fCBOVaeXBf4BSlLLosO6ekzKUazaSuJzICbBDgwOay1OKLil2d/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021478; c=relaxed/simple;
	bh=xZTwFG5FLgiskzYbaYyz22Fpos3eeBfumtIPuyDJaDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9TxVbvu0D5KbkxTHGjxqRLyZgVvHKte+Kd7jjUFPVzFAk4vxRckIXw8tdD9bI34M5pwAHpkmDDNri4lrkQ2ehaMUb19EVAFL+Z1fM4RQqfkuqifqsTeYuxCRs8E5+Z8svWvvzk+UmCsnuTQWwOtRWVlaSNL/GbZfRKpftNPBhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aDgLeLlp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734021475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/JWnOJW6U543Vpbg6PAvnRfuu/1KbMmqtG+gC1ifEE=;
	b=aDgLeLlp+lVhmibXtwArbI3wK7QHyy8invECR7GoXrjE3qh8HcDmVl2O9IFR0SY4GTMc9B
	cg+Kyclh9Cd5L3T5EBKpPVcaN2fgFPQGb2/Kobx51tc06aCE8WIAUZ6ZH5yCBU8NxNbdN9
	MmdaWqK/+QbaNJoV2bV26IO3fVMhaCA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-vY5cGxwbO9q4_rDisyuqBw-1; Thu, 12 Dec 2024 11:37:53 -0500
X-MC-Unique: vY5cGxwbO9q4_rDisyuqBw-1
X-Mimecast-MFC-AGG-ID: vY5cGxwbO9q4_rDisyuqBw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385d52591d6so492017f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:37:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734021473; x=1734626273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/JWnOJW6U543Vpbg6PAvnRfuu/1KbMmqtG+gC1ifEE=;
        b=ggETa7/QVs81l5eqQMtCQ9MJlfYtvq1GfJysQwB7CgtC10zst0KMzl2L4LTXiQdXPx
         kyqtljbcLdJso9c78gvyCO7R7SHQKln89xeEsbp5iCQjh4Onj9xCvW1d5ZldEv1JP5Ci
         /TDdk8zQDzZiweZrvxEahHnIlL9TabdoMBnSDo+P630qX/+kLVTnuIbYFbq1V8E1je35
         Xjq10s+QP63BBqL7QlnLiI+fq1zVKR4k3nuk97phVC8WvAdcHvnlR+teB8Yta32NOf45
         /RVFwkWJARJSn9BLcN6cMOOJIEXNDD/E6l9ttb9x0BKf7dl1Rsa9dBkiScGqJzou/0YM
         NpHg==
X-Forwarded-Encrypted: i=1; AJvYcCUo9fYDLhrfZwU62fb9mhb2Rs1sBq0hQLEFcCYMpqilz5etdz6AXbsds96MYJMI6ymqrCINzIrlvA8oK+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Bo3I7TpCmEQ91Ehj3pP2GyZaZrJiGwSAmn3mgYylEfoXzCZo
	rGHr5WSJ0ZHtaDI4zCdwFBanLPJlviT8Q0MD0zKhS5voC84vlg3ZiC+epoFzv+adTD/sg4HUjeQ
	fnhqtQTa5DCsFlXW2CxP78b0U7jiN6g2aaUZ69ijek4mDF2NdeTJ8H8pzpHqRSQ==
X-Gm-Gg: ASbGnct6aIGO4HGDOlxLBhPzpUp719Exd7GjaT1ZZg5yOuUdXtZTyEw5FmofZvJeRD9
	h4ifRSJzI7+3ABo3f3UC+5ve5q4IRmem/P4BMdtBT5Cz0eQvjBbaQi0qrYgJhZjpkUi1v6Mt8gx
	ZPzMtMW+gDG7hY/tw+Ks0DlYTSFYEXBvblZriNPqxr69IsSe1d/XQS26Rkqy+9oZ80G/IBlorKH
	gJJ4LPGoKTKSQRZP4bg8nzvUG1pkwjEm1On676j7oEU8nCneDzCywU4RVAOndnDyC6dDZoreD6o
	4HuoyEtEaSELUMEWQV6q
X-Received: by 2002:a5d:4249:0:b0:386:4a16:dadb with SMTP id ffacd0b85a97d-387887df18amr2620127f8f.11.1734021472709;
        Thu, 12 Dec 2024 08:37:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCqlzDJSGcOyDg622o0aLIqYnr1Qin7+BQ7+u2XkYPDbcqPlEzDuaHUAQTIOSWuZs3wfMVew==
X-Received: by 2002:a5d:4249:0:b0:386:4a16:dadb with SMTP id ffacd0b85a97d-387887df18amr2620105f8f.11.1734021472309;
        Thu, 12 Dec 2024 08:37:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362571776asm20890445e9.40.2024.12.12.08.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 08:37:51 -0800 (PST)
Message-ID: <eaffbf5e-ecb0-4aa3-8d05-da090494f8c3@redhat.com>
Date: Thu, 12 Dec 2024 17:37:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/log: select CONFIG_FONT_SUPPORT
To: Arnd Bergmann <arnd@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Ogness <john.ogness@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Andreas Larsson <andreas@gaisler.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241212154003.1313437-1-arnd@kernel.org>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20241212154003.1313437-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/2024 16:39, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Without fonts, this fails to link:
> 
> drivers/gpu/drm/clients/drm_log.o: in function `drm_log_init_client':
> drm_log.c:(.text+0x3d4): undefined reference to `get_default_font'
> 
> Select this, like the other users do.

Thanks for the fix, I'm sorry I missed that dependency.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Fixes: f7b42442c4ac ("drm/log: Introduce a new boot logger to draw the kmsg on the screen")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/gpu/drm/clients/Kconfig | 1 +
>   lib/fonts/Kconfig               | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/clients/Kconfig b/drivers/gpu/drm/clients/Kconfig
> index c18decc90200..7b81fd0f4cae 100644
> --- a/drivers/gpu/drm/clients/Kconfig
> +++ b/drivers/gpu/drm/clients/Kconfig
> @@ -77,6 +77,7 @@ config DRM_CLIENT_LOG
>   	select DRM_CLIENT
>   	select DRM_CLIENT_SETUP
>   	select DRM_DRAW
> +	select FONT_SUPPORT
>   	help
>   	  This enable a drm logger, that will print the kernel messages to the
>   	  screen until the userspace is ready to take over.
> diff --git a/lib/fonts/Kconfig b/lib/fonts/Kconfig
> index 3ac26bdbc3ff..ae59b5b4e225 100644
> --- a/lib/fonts/Kconfig
> +++ b/lib/fonts/Kconfig
> @@ -10,7 +10,7 @@ if FONT_SUPPORT
>   
>   config FONTS
>   	bool "Select compiled-in fonts"
> -	depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE || DRM_PANIC
> +	depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE || DRM_PANIC || DRM_CLIENT_LOG
>   	help
>   	  Say Y here if you would like to use fonts other than the default
>   	  your frame buffer console usually use.


