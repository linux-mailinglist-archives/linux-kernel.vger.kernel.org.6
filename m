Return-Path: <linux-kernel+bounces-276546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25732949589
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4522FB301C1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF01EAD2;
	Tue,  6 Aug 2024 16:00:15 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D433DF71
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960015; cv=none; b=I1i4QqQIc2Sdw3ORrGGgOggba77QPjgxCwONVirSieB4N+TfIeyqqVqSNL8frqiw6os4m40S6P9Ozf2R3+YqUdVzQyoyOHG/NCRDn7H7quIjwy3kCjCM3OhipHHn+3UPU75JXm699QUYy2L8Pmpgqfc3v5qXi6M/qoYUiibUK4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960015; c=relaxed/simple;
	bh=AJHk99JRG5OpJoSoQueFp2kEW1qBz/ld8n7MnXvLs9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cLDs4tovEJ4yKtlWkj7d+ktLmIawdNeNHdw+a3teEIELENnEZgNdXzZPvU8vLT2iWMzdEEQUpt3TZBQpSAEZqJnI8LUeuDaKTKe0dDS5Blm/L7n8LMWwPxszbit1GyycEQTE2Kl5vLNjRMIh0F2yHuZCl6fozTbc724yrbl5x8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fda7fa60a9so6490185ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 09:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722960013; x=1723564813;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0OH1lK0iyrEFjZ+sxfEDU/w6C/qIfjEuNJOJDkGoH0=;
        b=XNfiF9lT7D4R+zgRE3xxJsV++d/Ikys+Z57EvRInNTpEOU25Xdyvxspdk0btP9ZybG
         fIv72lTk4ePcMcT+ph5hBygl2ewCeg+bzBJG10PxMRQ8ZBL6KyitCflCuuLyoCglbVFn
         6vtGR0sPyHUOhaATZilJhaOJr1u1I26TM5sheoiCfR0hBWUKZi8KYTXLxu1U4s5pFys7
         vUExso+Um65jG69d7maeYg2K1pZsDI49upvJb1fNB5rYfOZ+w4/sxcE01rJQ0jqfzsZp
         VCNFCRorSt59dBlaaATAAVjyZAVo8q5itBdyvcCvL8f7qZ3xntUGCxFOLBqAoUVNVe5p
         oOVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+3LGsQjDY2TfEyC3RHVHebiPLf6Q/CuethJLFyFk0J1cuUKsyqjKzi6dm3LSYpWIend+Nd0J9amimiWYm7Pu0gVEAEGlv7Z6l70kr
X-Gm-Message-State: AOJu0YxpYxv6u0dMVF+hNiII35iZVsnFIaOJefsdQBV53HsrZ2SPWGhK
	4EkwQoglaI8HpVLtKpHID4WzLELYIJwXcAv6NbHSWDDj4RIawAlwxFhcR3/Hnns=
X-Google-Smtp-Source: AGHT+IHwXaMUruJCX9M/RHqtmhUbj4EyviX70/VCd+gvNCZm8JC044UbL01+TgvDOTnUpG7G2lRLZQ==
X-Received: by 2002:a17:902:e54f:b0:1fb:9627:b348 with SMTP id d9443c01a7336-1ff57495ca7mr237971045ad.58.1722960012898;
        Tue, 06 Aug 2024 09:00:12 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905fec0sm89249425ad.149.2024.08.06.09.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 09:00:12 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Andrew Lunn
 <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/6] cpufreq: omap: Drop asm includes
In-Reply-To: <20240806-dt-api-cleanups-v1-2-459e2c840e7d@kernel.org>
References: <20240806-dt-api-cleanups-v1-0-459e2c840e7d@kernel.org>
 <20240806-dt-api-cleanups-v1-2-459e2c840e7d@kernel.org>
Date: Tue, 06 Aug 2024 09:00:12 -0700
Message-ID: <7h1q313alv.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Rob Herring (Arm)" <robh@kernel.org> writes:

> The omap driver doesn't actually need asm/smp_plat.h, so drop it.
> asm/cpu.h is not needed either as linux/cpu.h is already included.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/cpufreq/omap-cpufreq.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
> index 3458d5cc9b7f..de8be0a8932d 100644
> --- a/drivers/cpufreq/omap-cpufreq.c
> +++ b/drivers/cpufreq/omap-cpufreq.c
> @@ -28,9 +28,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>  
> -#include <asm/smp_plat.h>
> -#include <asm/cpu.h>
> -
>  /* OPP tolerance in percentage */
>  #define	OPP_TOLERANCE	4
>  
>
> -- 
> 2.43.0

