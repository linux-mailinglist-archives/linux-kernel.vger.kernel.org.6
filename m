Return-Path: <linux-kernel+bounces-268243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E5494221D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F105286795
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AA118E031;
	Tue, 30 Jul 2024 21:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RBeqcwWR"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D04918DF6B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722374357; cv=none; b=nEUgpoiVSiB4s0DEuses8aESOnvSkOh5nO1yLiCcEXfPCTM+xVrOiTiHyE/rVLo6vOnMS7ON57r7e5rYY/IGVfIXvvh0rWKeZ98AtPrxr1i5za/ZK/p+SKri02B3F2/PAwP73LYMVgz5PKVukTB15AjudsxbjfYB5N/cxPsQAcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722374357; c=relaxed/simple;
	bh=DIxMarJsBAsZLWNoPUxc2mcliNrW3Qg+0wlavW/inmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pjo8FcWZSDDadtKjOC7SVVpY4GoAaCwh4VdPYjYWbSJ9cw8qyXUKdsTFpI0zhyicYEQZgai49ehXXt8RgCt0Qy/VE9/WJlqHNtPcmJVxilUXwpjLAAqO9yFsbUKcP7jwCG3eIOJmCzGB2qu7SpgrX6DsJXaXJ1ElM6snM6kCKII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RBeqcwWR; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cd34c8c588so3157483a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722374354; x=1722979154; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MdIkd2pe0a3xGWOfFhFwChwsMO18vyV+cxJRBo1n2IQ=;
        b=RBeqcwWRNnMl5wsUmcDKe4ArFdAKg0IZEwUvRuK4L8TyDd9DGYYcxFcPOj9YEE++Pw
         6OIFqJOHUcVuzobmgQzP0LwbxmOpCdCFnQ2Pq4f9UzZLU5MbZ3/1mTDyHk9Kpoz9q2EU
         +rShoAaBcsAxe4Wxgxu6XptBn+JYXc2G5+BLxmm2fT1bHqQsj+ZkzgJYTw+A82QLAx+t
         VW1Rzyr8E0MsfdhUMsy2e200GOfqv3Z+V5iXdJVDvvf502M1n92+rEC/EEKt9Qal2NrF
         YSsOn7q+R4qkTlt5w7R6PrwlII4fcQ0qT66pOIFilqVyhr0giDP7G+RkurqU3tWQ4bj5
         oNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722374354; x=1722979154;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdIkd2pe0a3xGWOfFhFwChwsMO18vyV+cxJRBo1n2IQ=;
        b=WhFtdCl98F/hA7lGMqMbMsCz+3zB2DBTmbb7KWRShMn9/NsRZGIpAA+v+dAJXw5V5H
         l8YiEjCCsyN06bheexuEyK2Q0P2VA9wfjN/wLO81nSEv+O/SPGJeDopemhVoJmSFbadk
         lWWa/KvueOUGOAeYo54/FfYtcTEwcVnFP62spspkTb4jQIBhNc2mSP8TEx9sDxs6QGE9
         qCZrqXDYa+OSbXjZME3hhvfwnadyCofQmcX2CRTYm6usu9G//q2SVHCJWPvYPuGxyBo1
         3k5U4qltCE/7ok9aMgHYL16chhTsGFkAYRt61XSqpf3mlVJJHmdWB2vJdog8uCJ6qP6+
         ggDA==
X-Forwarded-Encrypted: i=1; AJvYcCXe7XEJGoEtg8E9twuuhrHriG8q/Zv++tU9B5IF7Jtip/0Usn5uiYh9HjflYeHOqOspMnoi97jJmhVtIislAgDYfibHHIdzm5CX5ynK
X-Gm-Message-State: AOJu0YzlLKrsXYfAfRI/H+3aCE1oSLsmAE1sFx0kuKbQWEAprgW7de+D
	GDyXaQBXcL3dX4z6JHlHGZxGej7GAsT5Q4+YtE71WfpH+AzyPM/UGxhtxfg8N68=
X-Google-Smtp-Source: AGHT+IH0pxifqw1gkvDTkAWMSwQ+9XO630EomiwDVY0jejimMBKfIGwo7NNOWI0vlmyhGje1eiqcgw==
X-Received: by 2002:a17:90b:388a:b0:2c9:679d:78a7 with SMTP id 98e67ed59e1d1-2cf7e2073b5mr10869519a91.25.1722374354603;
        Tue, 30 Jul 2024 14:19:14 -0700 (PDT)
Received: from localhost (75-172-120-197.tukw.qwest.net. [75.172.120.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb738bb33sm13295415a91.4.2024.07.30.14.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 14:19:14 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Tony Lindgren <tony@atomide.com>, John Ogness <john.ogness@linutronix.de>,
 Markus Schneider-Pargmann <msp@baylibre.com>, Uwe =?utf-8?Q?Kleine-K?=
 =?utf-8?Q?=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Ronald Wahl <ronald.wahl@raritan.com>,
 Thomas Richard <thomas.richard@bootlin.com>, Thomas Gleixner
 <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] serial: 8250: omap: Set wakeup capable, do not enable
In-Reply-To: <20240523075819.1285554-4-msp@baylibre.com>
References: <20240523075819.1285554-1-msp@baylibre.com>
 <20240523075819.1285554-4-msp@baylibre.com>
Date: Tue, 30 Jul 2024 14:19:13 -0700
Message-ID: <7hjzh260j2.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Markus Schneider-Pargmann <msp@baylibre.com> writes:

> The driver sets wakeup enable by default. But not all uarts are meant to
> be wakeup enabled. Change the default to be wakeup capable but not
> enabled. The user can enable wakeup when needed.

In addition to the user enabling via sysfs, this driver should also look
for the `wakeup-source` DT property, and enable when that property is set. 

> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>


