Return-Path: <linux-kernel+bounces-324033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC5F974706
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472171F2260E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49751ABEB9;
	Tue, 10 Sep 2024 23:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xKqx0FvM"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BADA1AC452
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726012315; cv=none; b=LlZH6TkWuD9isRODB2ErA9tgbFOl1Yqefm6GYTQgVtdsN2b/nmhYXYf9lEY9F6tak34sOQawp8zPmmAlOdvVA6KIGKsnzlZyDcp0rlGFCnVden8TnL+1G3EhPLc4uHxK5ZrHsNT2QwcsgkcCUAv96J0CimtkoEpI7S8y+cG8F8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726012315; c=relaxed/simple;
	bh=TaA6LtOkaMdzDDJLahf0mqw/Pgw5pmUHh2JeHaA8+w8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k/od2jF7CoMmmrv+0c1KgBfk1UtDWn7A6YkrmZVLKZeNSks77P0+Kvpd2IKt55FBb6hn3XunrzSdfzOH8u3rs+QiryWVx+5k2fwkqUy6g2KTjxH+eH9D/iaC38iX8s9GGBKG9abj2CQYuJgUgadm/xlkjNSnQCacYSLgFVAIxNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xKqx0FvM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-718da0821cbso3853678b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726012312; x=1726617112; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ObeoPBsB3Hucf4NtGoVRcxoG7r9sePIgIowfBO8T26o=;
        b=xKqx0FvMxRhYFL1GzrYUqNMCbtCNC3FSCMR+L3Y/hriipEyZcpJZvZ5GcOpczYDw+q
         6AMgc42hIq6VJPPx4ErRKbvpXWReP5/5NMlcMH0hGpbigiOAQbC/RKp/kIJxk/7goFMu
         px5a3NtlY/L19XZRvI8YUZuR6ArTM2bQlJsVojgPN7crHN01R0jrDNueuR+tFEq/tP8N
         m1NM6+b7r9itTEXRNC9hpfuX7x96f9gCsz9JgJMCu7+gzxw/OuSwtcTLE++EBMNtkWpO
         yvabSgzyJpDC8y1/owLaixCiltlhL59CaRDqHXE+pTrNr+jWuaiHpzJp2B0Fu9CUYL8a
         8HtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726012312; x=1726617112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObeoPBsB3Hucf4NtGoVRcxoG7r9sePIgIowfBO8T26o=;
        b=CfTo0rpKtiODEV1qk+7khGnJacpGC8DjmdQQ8oWBeJSBhVx5JlCXGF4XC3YmZYli4R
         Nm812DbEc8S3PR9RkYexPemdS2vFp2Mjq9GLPNID/VeBDcGPMvlxzdjy2ojBlVUj8yO7
         6ViT3oqrx/f5oRknE0WYEvQ9lX4AbjFJVE+W8IuB8rtVC6H2puZHTddWIEG106uN8pLZ
         BvrFGqUaMOgDZfgj/tFUQRcZMOlcRPDAKwlJsYpg5UgYpKYTBYEsrYqPDsSmnA2H6SxK
         iC2uQWZb/F9vBAX/9Q4O4XAa7QMMTMSWQwaRUqvehkUz4XW2YsS72iwgq2YlyBlTgufh
         JpJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEkF6Wa+Yz5Hiq5RtZAfnkdxVWeSPi5tEAFZEF8fbyaIHKEas2n7zwU3v9zrJOgXSrLB76nFKum0ouD2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWz7/ZR+NPsliNc8TD3JNcy83oevZUdOHQwj/ylys3CMAN2AdY
	LpxQ4ysXhvrD2B3hmBT96WNatLhp5CSgelIF06icKsoXrOsJSaGdWaB9/zJt0HQ=
X-Google-Smtp-Source: AGHT+IHsS35HDIcTQPwf6dzkSG+kKpt/cCY7Dj6LN88U4ZX8TthbEYmUyeoH840rDgYNG9UCB07f7Q==
X-Received: by 2002:a05:6a00:2296:b0:717:d4e3:df21 with SMTP id d2e1a72fcca58-718e404ba5cmr19877655b3a.23.1726012311811;
        Tue, 10 Sep 2024 16:51:51 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71909095124sm1896787b3a.103.2024.09.10.16.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 16:51:51 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>, Nishanth Menon
 <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
 <ssantosh@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Pavel
 Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH v12 1/5] PM: QoS: Export dev_pm_qos_read_value
In-Reply-To: <20240904194229.109886-2-msp@baylibre.com>
References: <20240904194229.109886-1-msp@baylibre.com>
 <20240904194229.109886-2-msp@baylibre.com>
Date: Tue, 10 Sep 2024 16:51:51 -0700
Message-ID: <7hbk0vukx4.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Markus Schneider-Pargmann <msp@baylibre.com> writes:

> In the ti_sci driver we would like to pass the resume latencies set on
> devices to the firmware so it can decide which power mode is the best to
> choose. To be able to build a driver using this function as a module,
> this function should be exported.
>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Rafael, if there are no objects, feel free to take this one via your
tree.  Thanks!

Kevin

> ---
>  drivers/base/power/qos.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index bd77f6734f14..ff393cba7649 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -137,6 +137,7 @@ s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(dev_pm_qos_read_value);
>  
>  /**
>   * apply_constraint - Add/modify/remove device PM QoS request.
> -- 
> 2.45.2

