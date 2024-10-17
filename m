Return-Path: <linux-kernel+bounces-369375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FD89A1C8C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A25B7B26FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733AB1DB37A;
	Thu, 17 Oct 2024 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TY+IwGkP"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683B51DA624
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152215; cv=none; b=WmIUBN7Di+puWK6/NJ4fB5wXcRTnhZP31mIjxx1bvSbrQSVWHuaNbEKkboO33/hIUMpNhIBpT1BOB8Nux0jJo1hkIaGywLRkQp9Ps0xA20h0XZQRcw9QP4FRX/VM7HUFdBzZykZitP0px4e3YHzXMSXMDmUVmM2BNMVz21rIlUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152215; c=relaxed/simple;
	bh=83Dd0h1px/j5ajoCG4zVpqu1+In9jyu17dpSI+y3J5k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dYXnpZcJjdC+4lDZQ2Dke1svT4uYMZCjR6pPGDcehc5QgFjKyrGYtmPXTRvi1VRGpBP9VBWsKzJyhLtoFQ5v+4yw1/xp/GzAflNT4EkGA5gc2SCr2Q25NlPARQ3eRXQEslspMo1dYvVojkndyz29sT2R1VD4HPxcxlrPrbc5N44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TY+IwGkP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43054ddfd52so1097765e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729152210; x=1729757010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXsd7OwDazZFDqhWrK2bvttfQ59ruGxGdVAPrWSzcns=;
        b=TY+IwGkPAKVf6gSp04CMoJyk/S2f1TYIAmGRkgxDHbinSstGfgD/i8D+K5gxrpylmP
         hjrtVkWApzu6243hS2zr/HSJl1f4AVyWHvAzaqO3xT42h/QXVIHBtaDThu9KoK01HBxZ
         9CMF1mRAR+FVcLn2ivvdRX5Tb5nehOXHrzBYNK4l6pLJwYbT6F9ITFmtIHM8AEMfi/PF
         NgUKhB0XVzvB2ERF9uqNrct3Fj0OK3+e/YObLJAssB/EATyf0h3LQQuP5SqDoZMAugHW
         JEgtHFDFpBl5XEka/L2ycpSyHl6MN5So+olD4Zmg5atSdGkNWYLHCGgD+pqkQU5vVhfq
         nrzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729152210; x=1729757010;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXsd7OwDazZFDqhWrK2bvttfQ59ruGxGdVAPrWSzcns=;
        b=DJLlClbt0Mv+AcafC7h+y+PYRVkG6bfc368djowyTEzjkJFivZngENIO5VAif/YOIE
         fsNals2m1MPn/F4BVRda/Bh+a5LNAZwHEbNYBsI6XYn+RP2CEle8moO6Wj79ins4gPUD
         PptkazWxsOQVqBU//Ep9OAU21C3Zb6g7KXoWLIQGeQVBWZeSF/iK/uqCyMFZKrqLLd5Q
         ODQkam82Qj4k5uoNoHlkqfGQSFgP86t6aYpC6qkAGWStUxyAagwE8/1OUfR5fswQxFIZ
         29XOip0Veh1LiBHfGM5nUxzNKYxy16Msm0wwJ5vQgBiouRkAMUU6yeeOdot+1nrE/47e
         pLig==
X-Forwarded-Encrypted: i=1; AJvYcCWxjXpEYUYApw6kb6hSoReDqNoyjxDbPmYNgXhvik73n6wpo6EoJy5eZDkzX7MPMwaTmf7JX78z6wZx1hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB/KhkLMh4eO8udOvXhLsQqQ1vWzf/scumPxKrv5yQc3oP7K5h
	ptjCz4l+LB4PTJLbzcwkTsZH6st4AIGCUCKycY4K4xaCuAswZzLMcaT1jSGmNug=
X-Google-Smtp-Source: AGHT+IHr1OcjFahO9alclfAwT/WY6QFt68A+u/zlKpWaJcX2JRHqW5bckWKzwqLpuoosFBGXYQ1Bbg==
X-Received: by 2002:a05:600c:4f10:b0:431:558c:d9e9 with SMTP id 5b1f17b1804b1-431585e4aa1mr7672805e9.5.1729152209621;
        Thu, 17 Oct 2024 01:03:29 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c61aedsm17631915e9.43.2024.10.17.01.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 01:03:29 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
In-Reply-To: <20241016154747.64343-3-igor.belwon@mentallysanemainliners.org>
References: <20241016154747.64343-1-igor.belwon@mentallysanemainliners.org>
 <20241016154747.64343-3-igor.belwon@mentallysanemainliners.org>
Subject: Re: (subset) [PATCH v3 2/6] dt-bindings: hwinfo: exynos-chipid:
 Add compatible for Exynos 990 chipid
Message-Id: <172915220833.18392.17035280597662284700.b4-ty@linaro.org>
Date: Thu, 17 Oct 2024 10:03:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 16 Oct 2024 17:47:43 +0200, Igor Belwon wrote:
> Add a compatible for the exynos990-chipid node, used by
> Exynos 990 platforms.
> 
> 

Applied, thanks!

[2/6] dt-bindings: hwinfo: exynos-chipid: Add compatible for Exynos 990 chipid
      https://git.kernel.org/krzk/linux/c/c6dac8443dabe7a9215f00025f78a9c55a0651e6

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


