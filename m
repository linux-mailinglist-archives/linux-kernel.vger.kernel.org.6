Return-Path: <linux-kernel+bounces-211392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F74B905111
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D805B211E6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FAC16F0CF;
	Wed, 12 Jun 2024 11:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVdHn6F4"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FAD3D388
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718190353; cv=none; b=NaOUweZSccfmE3xlCCG/DSyGKJJtNVrzuVkuUVNrw4kaGlX48e/Rp8pd3uuRYcn4Qt0ACN05+B+SoLjy6a8wZ5hprXGfszy66qZFh1gRWLsbIYRLhJU6TzxsttzfM9746EkbujNRI8j9dBnhgrD7zA5z5YyJOK9vyuQtP1TNPG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718190353; c=relaxed/simple;
	bh=+wdrnx3EeleCXAS9rkEiQm2x3E1AseIhoVIT1O7VTTA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Dt7WBPNqh0bJFlX9NTPxG289XDcn2gac+tP1f4VJbB27cKoqtfsGcG12f7wNs9WIt9vqcUxbgy02aG2mAVCVFh7Mau0NiZK8GS5ZlfZItIiJxxVMh0s00/K6ezkqDTHTZXkdq+2Tf6/AIM4aYlR/JUqfEbstQydsPcwn1JBV5/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oVdHn6F4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-421b9068274so28769945e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718190350; x=1718795150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVEN4wl3rM6KP3IQiX2AC8CG+Yueqah2RH6wgyvbAMs=;
        b=oVdHn6F4izANGPK+DztmUnz3kqlcKJxaJ3sT7xDJ5BDX1ZTmnfx9g02WkY4m1D36Y1
         5OAnZTeHwzOdKNElxau1a4vlxOYYu6MvmPZYf3tc1Qnd2Ny03ULUPrb2Nh4D9W3AV9w+
         /2Zu8tscj9nPDdReresG59r4SZWlzZBUGKtOGUwIypTB+lpJkwHQ/OWF3+ECrtQoHIJD
         e1IXWCTsc8XJHTwvI37DcQCcD0gSIwI1PAuVyGvRJor/Ya9qaDerwAuN+dteUdgsDihy
         pGhGZqopWNiI1FhroLnHMoa45UKwpY/9cR2EbbxfvUadayYhgZ0iPj73GGPTLXQXTMo7
         JXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718190350; x=1718795150;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVEN4wl3rM6KP3IQiX2AC8CG+Yueqah2RH6wgyvbAMs=;
        b=vaJMJrnVk1bMIehmKQ6hVrvgm/L/TZtHPJ/IUC1GLutgAOGPMLFctcRKolOQDh/Opp
         cltIFFYr7AvcABWmM128MmPO7LbKRP2SzfmAuDHmkfQmWLYYftfKm/XlsZQUpNAs7BTb
         K+BSXOrNQrnF1meoNjGNuqIj997GVWDtvTz+5bNZj/4KXWIoqhtkk5NMowEKl+s35YxH
         YAQ+1RSi2dmIWdAlcMeX2GC8lE2/u4utC+5gO9vVK4noYXmsNyQ9OZaTPrxdHDuFmAyS
         zq0oZlDu9JvNn76WXbUF44l0Q0LWU2JKyvB2lNpXaWhpEI/eNvIQu/8hCKelV77RHDmX
         ZQTw==
X-Forwarded-Encrypted: i=1; AJvYcCUcr3Exr94pLgci+snlCCk/QXaOChMwyIiS5+p6FeF7d4UOgd+1J6zTHVpZouLFjH3jMJKOpUgg/7l4Z2eEp9TAe2R0bppG8cYhg9J9
X-Gm-Message-State: AOJu0YxTZLD9iimZQWw8HBZlCPusVEIa8hlx/V6l30XC39X/MmhVmWIk
	yV8dB1q76cebB3agViqRK/IsXpkF31fe51C7ibkMIydKwzEUXx4igjt4xScQHlI=
X-Google-Smtp-Source: AGHT+IEQ6RTTjXaKZqG61MP9ZE6kaM9KQ8Fu0PS5P9Lw9wK2R9SwWy4PHIA/zaPfHxyRpZfv03OQog==
X-Received: by 2002:a05:600c:1793:b0:421:79e2:c957 with SMTP id 5b1f17b1804b1-422863ae433mr12355595e9.19.1718190350452;
        Wed, 12 Jun 2024 04:05:50 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d69e71sm16153270f8f.65.2024.06.12.04.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 04:05:49 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240423150728.91527-1-sheharyaar48@gmail.com>
References: <20240423150728.91527-1-sheharyaar48@gmail.com>
Subject: Re: [PATCH] ARM: dts: vt8500: replace "uhci" nodename with generic
 name "usb"
Message-Id: <171819034947.101264.3434060327775586581.b4-ty@linaro.org>
Date: Wed, 12 Jun 2024 13:05:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 23 Apr 2024 20:37:25 +0530, Mohammad Shehar Yaar Tausif wrote:
> Replace "uhci" nodenames with "usb" as it's generic and aligns with
> the schema binding.
> 
> 

Applied, thanks!

[1/1] ARM: dts: vt8500: replace "uhci" nodename with generic name "usb"
      https://git.kernel.org/krzk/linux-dt/c/dd2118bd10c1e74b8f0082750bd39c4bcb5fe5f7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


