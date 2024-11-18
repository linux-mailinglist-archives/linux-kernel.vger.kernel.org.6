Return-Path: <linux-kernel+bounces-412620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 969B09D0B79
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB3F1F21F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1460118C939;
	Mon, 18 Nov 2024 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="LX0xMMgw"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA9B183CA6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731921330; cv=none; b=uT2QqW2msUxnaRqGi6CVYxmVd0TbdLXt3W+RAWUsIitGZlv2ei5MxH2BLyuMod++3wTrzfE8OHaZUoxZ6zCNXRO7YHs5zyO06YkZFF1bo/5CLoTKv3/Qu3gBYdjq/4zEI/myYYI1dxUgFtYV64RHdkmZVAzELQ9IPq7PGrm9GNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731921330; c=relaxed/simple;
	bh=5bV0KC+Xims9Nr98anAeAn6srjelomTm/DXSTKhaYuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwOUMvgeWF5L6HFV67cq/tInbO7kJyDTd0MmaVD5qgjhrqUSZ8ENFJREyezPScBttczMdvmIyHRrtlQtJkVh9ad0TCjlRC8DWDzJFmAhFy9/YQSeLRbnU0HCita1/j5U9wGKRyBa72IspQi/v4mxFuX5d6xh1wh9QR2s3noNEPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=LX0xMMgw; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3824a089b2cso218141f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1731921327; x=1732526127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vgBc0WpMo9WuNAB3fbwxkobyvq9Qa1bYqtOSW5URvVE=;
        b=LX0xMMgwuJihVkeFTqomu8Ui7PpQKi9E/XBvJbu5HoaqmCDbxcxoYLWI25spi2qUCC
         856EGs0j7i3HuomOx/Ts7W07ca7Aw89O+pYG+KGPAy9ht65yBlHseBLGlZLob/Xt/AVQ
         3VSPTuyODfrGgjF9YGtgpX0cuwUmBrCGlpK0lInocyJur+EXLcF9crm3NoQAP0nNn/LY
         X3Iy9YjmNNOxmEBgL7Ka0HzaY/6UM6c1waEOQpBhf/P/u21NdrIqKRU3qU3FvS+lY21P
         hX+T4W7m0JWb8lOt4O4Tj6AWmmEkBcHwtMg8XzohRsw0uPLGdLnRkHdyT4fv7GJDuHXy
         NiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731921327; x=1732526127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgBc0WpMo9WuNAB3fbwxkobyvq9Qa1bYqtOSW5URvVE=;
        b=KrT0k/pNU+/HwLKQoO1oioKiAIYntoUXBAdLL7ZS+2lUcrV1Vkz1gh01+ks79JafFZ
         dUBWJkpfIq3Q8N6uMaD7QvO6MtlphFP7/dZ9eDgoEqRxumM4yEIPohDlSPSjUeoIdiKg
         ze/JgUh7Ivh1YsUDBsRyQPSMRr65YL0IIekkep4aqbZyLD23YMQ78OlHEexvE7H/u4ur
         KUuPxXp9/EZpMJkcEoJOWgjwRnhwUVfEC+Ki361XkZ+V00/X3mS74pRC6tHK5lpTsoqp
         uc/S/ENH1rUe3Fzkiqp2/F6/HV2Lu7V0l+3uJT3uRs6Wydeop/FSiVyfeqHAEmFUB4Uq
         c5VQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8AzEhz6YTBMoqhsjIXFA1PcZTiV0pDQ6zJ7lQ+xVs8hKXeQ3CcamnnrDMH4IfVe93kxJuEBnvRPTvCxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY5/aGRYaIMel5MtFZLsuPUlA4G++XXa92yTzzOVnhSWu1GYRK
	4NTPREpWfwa/WDK/GrgrQ9B4FDMI1vOErz0Tj3/pjPlyuVsXtjNn9eGK6cvO5zY=
X-Google-Smtp-Source: AGHT+IEIFBDAw5D+ahQKLZjgRDXj6yIsgMktblXupw/QSnASFZwhVB5g5FmH8LJ0iyETcG1odFzaHg==
X-Received: by 2002:a05:6000:4189:b0:382:4a66:f517 with SMTP id ffacd0b85a97d-3824a66f66fmr577502f8f.4.1731921326636;
        Mon, 18 Nov 2024 01:15:26 -0800 (PST)
Received: from [192.168.0.101] ([90.241.98.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38244220183sm3552606f8f.99.2024.11.18.01.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 01:15:26 -0800 (PST)
Message-ID: <468d41ad-9f89-4a83-8eb1-9bd7efaf1367@ursulin.net>
Date: Mon, 18 Nov 2024 09:15:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: Fix __dma_buf_debugfs_list_del argument for
 !CONFIG_DEBUG_FS
To: "T.J. Mercier" <tjmercier@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20241117170326.1971113-1-tjmercier@google.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20241117170326.1971113-1-tjmercier@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 17/11/2024 17:03, T.J. Mercier wrote:
> The arguments for __dma_buf_debugfs_list_del do not match for both the
> CONFIG_DEBUG_FS case and the !CONFIG_DEBUG_FS case. The !CONFIG_DEBUG_FS
> case should take a struct dma_buf *, but it's currently struct file *.
> This can lead to the build error:
> 
> error: passing argument 1 of ‘__dma_buf_debugfs_list_del’ from
> incompatible pointer type [-Werror=incompatible-pointer-types]
> 
> dma-buf.c:63:53: note: expected ‘struct file *’ but argument is of
> type ‘struct dma_buf *’
>     63 | static void __dma_buf_debugfs_list_del(struct file *file)
> 
> Fixes: bfc7bc539392 ("dma-buf: Do not build debugfs related code when !CONFIG_DEBUG_FS")
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>   drivers/dma-buf/dma-buf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 8892bc701a66..afb8c1c50107 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -60,7 +60,7 @@ static void __dma_buf_debugfs_list_add(struct dma_buf *dmabuf)
>   {
>   }
>   
> -static void __dma_buf_debugfs_list_del(struct file *file)
> +static void __dma_buf_debugfs_list_del(struct dma_buf *dmabuf)
>   {
>   }
>   #endif

Huh I wonder how this sneaked by until now.. thanks for fixing!

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

