Return-Path: <linux-kernel+bounces-275077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED35948064
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B83281BCB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A719515EFC6;
	Mon,  5 Aug 2024 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yZkBFDLA"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D6615C14D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879456; cv=none; b=RkLYRnNLFVDxg36kVbQrszm/ob/7HHKa0p8D9haImSYjo4VJtz5VUsgZWGo/lod7UXVOs84Wes8ykfz29lwD5kzKAAo3urDKtvpz4THJxmBmI783odLlFI6vtyZmE002hpyJ0itf8lXu6Np5Rr8FBE1Ebe8k1qvU74veVIHjJY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879456; c=relaxed/simple;
	bh=dM8sp0husClYi+h0ZGKuVSqRa7NAM23OUR7RjW40VYI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kuEDq65Cc4ZrEaq6DsGD1Co5xJhXLDf/SvKv61mwE8XwdzD6Y0G8JRK7vxqvX0Xi9AHc5LlHMJINuWbMhDLYrJmmlO4/R8LoKk4e5c0OThqcFoQwjDMj8xEDifd3ZVaxF28JPtb1ShrCHRpecYMaYxunkE0TmnJ6iKcv4N/kZ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yZkBFDLA; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-260f1664fdfso5341127fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722879453; x=1723484253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pHVbhEoVEMjlU46Y+rdQzQBJK3R4JaIn8qB/k8iiR0=;
        b=yZkBFDLA0kwE4TFbrGdE4el5dCq5+I5XSfv6Yzo1PnJ3wa9AX8cPrJE/yf20rkLR5A
         Qq20H32SeClGolOu5+EHNREcj8ao0XmfprlkCqyZyRyalsf+Xg6clg4pl3jboBDKI36b
         G5aEGz49UaMWEcVCTr3H+cKgvf2a2/qxi0Auz0cIjmgv7gm0kY34ZA8cvVK9TXoYf3Tz
         b4+jQ7TWvmxchjJK/jhwftUymM4Pkjn+ReUQ0SpvciOHiG7TGlLsjWYSHAMDbhBUDR/c
         LQ7Mympyi0RGBpQHy0RE6/3JthtVLhhpyV7vT9CnDj39xlEfUWxGz7Ch4jmtASD7Xdpf
         gxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722879453; x=1723484253;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pHVbhEoVEMjlU46Y+rdQzQBJK3R4JaIn8qB/k8iiR0=;
        b=Dt1vYPrcyN4auQN61ynl8NPNhHbiYbBevgVQY18acPjIqIGRKzAi5F1OSUbvDTYNdI
         kvYbNhFY43Jqfsha94xe8yxXF4vHghlczZ6GIKKURkWWU90hLyXwgYpHwUkq8d19o7AJ
         WbhoXTV3ec0e9bud6ObcXlImgmssqgfZKAmL8B8zG/5BGe/VhQhTr/Egos7N30lqdFJG
         OLSUvQsJcM/o70P3o2Tgyv9FQCT/A5dAU/FpCOo5ZR/9JUHYXhaFda3FgkTubfxIZWBd
         r7we4Wdlc/974T+JLI685E4dVwd0QCn+k31dDLuBtFkNdqT3m5XuB5vU/RLmRGexgO+l
         nbWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWxHoIhmgPPDiS0JFCAGaWVB/6RTQoqOX5BTHERSvjQvAVpP7qwtOHJ5qjhZwbMKTp0R3tJmgJKSR5SevoH9uqIb3iiwhNJ1Q1zOZa
X-Gm-Message-State: AOJu0YyPXzvU6FRXVU3wciUMaQ1y3xucEmPCQHy/YrQZ9V6u2YnbGjyp
	lCECjpFaq6mr2df2ON5JKIgWBFYeRRQ1FpPVMLW6yWUI4LxuY+FC2znBPxxI9Go=
X-Google-Smtp-Source: AGHT+IHJRUtzcnsDnqI75o6X2Ap9E2ZssvYvQ/dHPTU1gm3UkNElVw+QddAP+HpNI1vqdUkkHvtRXw==
X-Received: by 2002:a05:6870:1699:b0:264:9484:a292 with SMTP id 586e51a60fabf-26891e92feemr12640386fac.38.1722879453369;
        Mon, 05 Aug 2024 10:37:33 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9f5cdsm5708307a12.2.2024.08.05.10.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:37:33 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240731191312.1710417-1-robh@kernel.org>
References: <20240731191312.1710417-1-robh@kernel.org>
Subject: Re: [PATCH] bus: ti-sysc: Use of_property_present()
Message-Id: <172287945269.306491.8860968743342697729.b4-ty@baylibre.com>
Date: Mon, 05 Aug 2024 10:37:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Wed, 31 Jul 2024 13:12:39 -0600, Rob Herring (Arm) wrote:
> Use of_property_present() to test for property presence rather than
> of_get_property(). This is part of a larger effort to remove callers
> of of_get_property() and similar functions. of_get_property() leaks
> the DT property data pointer which is a problem for dynamically
> allocated nodes which may be freed.
> 
> The code was also incorrectly assigning the return value to a 'struct
> property' pointer. It didn't matter as "prop" was never dereferenced.
> 
> [...]

Applied, thanks!

[1/1] bus: ti-sysc: Use of_property_present()
      commit: 0070dc29c85f0859a6071844b88fca6bce2974e4

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


