Return-Path: <linux-kernel+bounces-563049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE52A63635
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 16:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC5C1891AD4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 15:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9CB1BC07E;
	Sun, 16 Mar 2025 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grD4gTCk"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA9442A8B;
	Sun, 16 Mar 2025 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742138550; cv=none; b=ZBPaBKe/Jeybb7AUCY+7yUYAoE82IA/crwX0jlHHJHFaLGlvlY2sOwMK1Lef7JmNocciPVG95ih0l4ulhcgNH1dyJLS5rcQEy2RXxEPCHy4+jFFrkjW1IHAGqeaWZOv9SurKOeTDN1xgRCmm9vqe8lJ9cbmh4Cs3lVVKhkzkV7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742138550; c=relaxed/simple;
	bh=LcB3YEvnmquR7l6nScRuWNog1FjtTZb9F/jk3nOVSfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxahTcZ/TCgJaDtAR0ye5GB3uvfpSZGm00I3fJYeG0F/KlfrDAe9csefjuxZ1IcIu88ZGD7+EjGkxsZe6B5a5kXAQ9vIoMbSK6XUwcFyLnQu5iVTa8dmK8Q5P/+moT2CrgFHGZfSRjpF8cSfHB7jxYe2Q3fbDXIcUUpjnf+4Ld8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grD4gTCk; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso1358662a91.3;
        Sun, 16 Mar 2025 08:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742138548; x=1742743348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rs6Mj7NfVXAbjMAhz8nE+UkRAhB37EqocID8lRhU1pk=;
        b=grD4gTCkcSa/qF+hs/qRWvv4JcIRkxNjJmH0L0pGbfXc1+6fdVpowncKPm0KOs35HQ
         o8EVOpA1ZPfFRTA+41eljKqtBkTo7HpOZbWiyjXiNhI0Ar9c+t8HRQwLA7TDaDg4VJzo
         ClutW9pg7Vsk5zAkUr4zMeJF7OSOKtoa48v9JRky11OPMZOI8zhNkL6xHJF8MDkM/SHf
         c0WkliSMGEXQSnfD1xgVjAMZqEZYmrJes4vxir5BS1w9zadzgvKVF7k4GLJLo6RXE/0r
         4HBUqOlTuVSswM6MqGESj1+r2GFflRoMtHbEBFqvld4quFYu18PtUkFvfD/A9Sk0ZySj
         pwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742138548; x=1742743348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rs6Mj7NfVXAbjMAhz8nE+UkRAhB37EqocID8lRhU1pk=;
        b=SXT6yNKHTBgqcFMAdRZmxHAnUs2KR5FXmMKandSpM6vsduZL4U+OLflEq9jgk/L/DF
         WtbcNL0JfQdrjuY8KkO4ea6FZYdGLZgJXn5+s8iw9NV957PQ8NCFVBnMz9CT/hETUSVr
         jZJCZqwJIscETzsRF3VYwgJMBQvIrnzP/gVVd95uavtInpihdDTMYYlAd/o+SHqKc235
         vJMPZn3KGcUFt3f+Ha5rBIHNm2XE16KvTc+lvLBbLrk5CrGDRdh0Tce8vn3bkWBBLcLE
         uv4dcSEbTVd1aaOnjD4Gp1NXdhFGj9VUBuu8vfn0VOh6aTqN2t8Ts91705EVr/Lj+1y8
         J4Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUK5nLuoMk1tYKyYlqPnandNCLWGy41dRaO8muQQoql0lV5YYgKA847OjGbNIpoCYJY3gSZM2e6qiLw@vger.kernel.org, AJvYcCWB4+6gxmIAarRjOjr8xhLEG6TODaJBHlhQAo/m+JLNv3uCOHKGhOD7/MM1zeX8ejlS/K4AppSBdbeZ@vger.kernel.org, AJvYcCWkB17oec5SNrRgYGDWGZFy6GGZ6PI+NU8HElx5JDYl2XyjLms4JtONEdzjc2DTyakbBnc4gXUlHONHaAmX@vger.kernel.org
X-Gm-Message-State: AOJu0YyTSD99qST//44NcRO3/uj4pE5KfDIOjv4SHPoejwBPd+NKDLbI
	VE9tniq1DtkN+7Ktl+RaLryWUw+ZMQEm3ITDIqawLiUwdIZWXru+YHyiqg==
X-Gm-Gg: ASbGncvU20XK0qYZHbj1pGI2yrHpynTz55c4J7RHPZKkSK8JM4MAl99iM7SdYhzXuzU
	2pUb4iwkewsOWWhXS28rW0Q0AyWgrdhHNH543M/cjzwR/vWmRH9u6NspUYPk58vJkn9tn6iCktA
	qKmu2XGzasHSN4mfvVx8NfBiVeuDaw0ubNegY7fX2fuQK2JMCHph3xZAKehI/3u3WNPeAkjQChY
	JzCGgmlKbvfqJkAbolUe3zzISlH25OM53ahf6HvCvtxyo/ki9EkGOXQ9MHmoOswR+wK+wh1oFva
	4BsTE08JtJWQafmAMEqoainYHN33B5k/X6/apyUddO1EnQkHQETKHoB1cw==
X-Google-Smtp-Source: AGHT+IFLvVeQxiakJUeEJp94hVx51DL+nhXHAvzn5+RsTwsHYZlZ6rkARhi6XFqLqRlS5aibN0kBRg==
X-Received: by 2002:a17:90b:254d:b0:2f9:cf97:56ac with SMTP id 98e67ed59e1d1-30151afbc79mr13794708a91.0.1742138547819;
        Sun, 16 Mar 2025 08:22:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301539d3f40sm4308739a91.4.2025.03.16.08.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 08:22:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 16 Mar 2025 08:22:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
	yuenn@google.com, benjaminfair@google.com, openbmc@lists.ozlabs.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v28 2/3] reset: npcm: register npcm8xx clock auxiliary
 bus device
Message-ID: <536f5393-478c-4a50-b25f-180e221ef7a3@roeck-us.net>
References: <20240912191038.981105-1-tmaimon77@gmail.com>
 <20240912191038.981105-3-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912191038.981105-3-tmaimon77@gmail.com>

Hi,

On Thu, Sep 12, 2024 at 10:10:37PM +0300, Tomer Maimon wrote:
> Add NPCM8xx clock controller auxiliary bus device registration.
> 
> The NPCM8xx clock controller is registered as an aux device because the
> reset and the clock controller share the same register region.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> Tested-by: Benjamin Fair <benjaminfair@google.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Does this work with real hardware ? I tried with the new qemu emulation,
but that gets stuck in the serial driver initialization. I found that the clock
device instantiates but does not register as clock provider because it does
not have a device node. I needed something like the patch below to get beyond
that point.

Thanks,
Guenter

---
From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] reset: npcm: Provide device node to clock driver

Without device node, the clock driver can not register itself as clock
provider. With debugging enabled, this manifests itself with

 of_serial f0000000.serial: error -EPROBE_DEFER: failed to get clock
 of_serial f0000000.serial: Driver of_serial requests probe deferral
 platform f0000000.serial: Added to deferred list
...
 Warning: unable to open an initial console.

Look up the device node and attach it to the clock device to solve the
problem.

Fixes: 22823157d90c ("reset: npcm: register npcm8xx clock auxiliary bus device")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/reset/reset-npcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
index e5b6127783a7..43bc46755e82 100644
--- a/drivers/reset/reset-npcm.c
+++ b/drivers/reset/reset-npcm.c
@@ -409,6 +409,8 @@ static struct auxiliary_device *npcm_clock_adev_alloc(struct npcm_rc_data *rst_d
 	adev->name = clk_name;
 	adev->dev.parent = rst_data->dev;
 	adev->dev.release = npcm_clock_adev_release;
+	adev->dev.of_node = of_find_compatible_node(rst_data->dev->parent->of_node,
+						    NULL, "nuvoton,npcm845-clk");
 	adev->id = 555u;
 
 	ret = auxiliary_device_init(adev);
-- 
2.45.2


