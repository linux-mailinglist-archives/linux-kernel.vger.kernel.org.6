Return-Path: <linux-kernel+bounces-445981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E98C9F1E24
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 11:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286831888B75
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6BD18B483;
	Sat, 14 Dec 2024 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cjJI0uiN"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C08D188587
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734173405; cv=none; b=l9WgHyOaPVr5rp0YmnIi3s4WIcxtxdk6JZkdAq+OPG7mR5JuXcssZMyYzC+pwRR6nz5GTeQ0k8xi0OcBdXrZmFvc6027cSO9qUAGX/tSm+wiYJUcWGk+EnajZOHMn8+M2qjqUNNEDJWflvwJkkSfAnnk2Y5zlr+2LVXhDI0dwTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734173405; c=relaxed/simple;
	bh=WgLZ4Sqpo845875rVbQWeq2Ll+Yen4xIdn1IlHpXYyE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MVEPjskTYYpc5Gox/qC4zFylw5tMv3/fuqHrpJII9D+sp1z8WAwgnrUMfqOQ3pnQs1/HHvTOAOmxx3wHaLGWxnIS+dHwDkt6Fv1sr/tkJ6LKbM28NL3NWhs7XaP0ut25Oh0gfr9bk/pDpPPNVbdz4D6oc1RKydUwtr9d4+Ua6oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cjJI0uiN; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385db79aafbso232946f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 02:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734173402; x=1734778202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFeeaOwVLNJyk8KG2PAdcvU43PbcoLuXwqtb4WTqOv8=;
        b=cjJI0uiNjz7O/fYdAgBrv9ECxsSbgvy+VWaJNIhb4+tgxxoutRIWkLRCQ56V6YQaDA
         phHZx6T/RcIqIYp9BB6mVzdyqEw6sqIgd12qtOBFYodQ1kLg5D+gULmhJ6NvsTTlARk2
         jqGv/3fe7+yhkPWmLnJh6jI12hGiskK/XD8Tl/n5IVAdx9kitqdEm0xAed9dSTJLxVAz
         D9dR9wvkVY46/7eE2IS58PljGEBBv1ue1CcnHSXnieEBehuU3wqL8ap2kEv3YjVaDjQZ
         MRLnmKhvwycsi0e4KNt05pc72CzNzYPXsEW+BwWnxVDEq5BQU2nwJi7Syu5ZLLUrZDht
         zdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734173402; x=1734778202;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFeeaOwVLNJyk8KG2PAdcvU43PbcoLuXwqtb4WTqOv8=;
        b=EC5cFylA2HQGUbAj9D7/nCZS3jnRGt4KwY3O7AVTCWya9j9vXt4v5x3AxumqeuI+lR
         lPl6+NI3EkL4llDGcLOH296jiRlRNcUYSwwylHRdwLEFynPM66G193Rpcegk28NykCAX
         I1oT4EqgrVXbbFO6+XI30y3amOrie5ICosiEZD9WnXmIARVBC/6jz88iyVoClBrKknpU
         nGuCVZtYWg+KNqYP/XDDQn5SqWs7v+lws2nnlPhhMvneMFyYydu2BpkmqDhpn98ZfKLg
         G0c1WyaLgqtDNeBXyROmjs7xf4gI8c1AG7b6PpoXsNA92w6SORl2yF5M8xf5aoykerVS
         ZFwA==
X-Forwarded-Encrypted: i=1; AJvYcCVNqyj/S7m2/tO0H9kIWbBC5mggMaCuYPtlDF6OI7G5S6K6dFUdoS81nPpnKyB1CzcaZjdItt4SY6Ul65U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoomxsZPw/1l2pj7akQbDNgjiKqYGOOQ8b2zCHJOsvU23Mu7Qf
	KvL+nm+xYH3EwgHGNuy3phf0VmkhWRTXS+vlQdKnXPgtPUK7jpCugjCyk2Cf5P4=
X-Gm-Gg: ASbGncvkSSHKOrLkzh7ZiWT6tmXDxlCRNGAAvP9Mt40dRefMu4iED+Q3OMO5cbTY7Ff
	I2Gie5qwoCQ7eKRaZ37mC/PlmfHwwj0Jj9ejVkqf5FVtMUE2zLozV5fvYDJI7+9YJOz2h1KMgWt
	i4T+jr7GApTSXQvhhTlw9VoAPJgnuTTR0I+y36NduYC7BzzKWiOsSjyVNcFKiH64qHKsBARwmGs
	1udNq9a4un3FrzyatDOQ1Hy6iEVXuUY6i2aovtgrr6w5xTolip1FH4SmKzwLPZveZWqi/r9
X-Google-Smtp-Source: AGHT+IEBLZqoOYrW6nHUXJ7egvcj+Es2bL8Vmn9thwbGb2lLB155RAHbaFGiiw3uqE/wHQ/4XmtxzQ==
X-Received: by 2002:a05:6000:4b0e:b0:385:ef39:6ce3 with SMTP id ffacd0b85a97d-38875fc35f2mr2104047f8f.0.1734173402032;
        Sat, 14 Dec 2024 02:50:02 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8060848sm2209905f8f.106.2024.12.14.02.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 02:50:01 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: rogerq@kernel.org, tony@atomide.com, krzk@kernel.org, linux@treblig.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241211214227.107980-1-linux@treblig.org>
References: <20241211214227.107980-1-linux@treblig.org>
Subject: Re: [PATCH v2] memory: omap-gpmc: deadcode a pair of functions
Message-Id: <173417340096.24704.14642309670774788266.b4-ty@linaro.org>
Date: Sat, 14 Dec 2024 11:50:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 11 Dec 2024 21:42:27 +0000, linux@treblig.org wrote:
> gpmc_get_client_irq() last use was removed by
> commit ac28e47ccc3f ("ARM: OMAP2+: Remove legacy gpmc-nand.c")
> 
> gpmc_ticks_to_ns() last use was removed by
> commit 2514830b8b8c ("ARM: OMAP2+: Remove gpmc-onenand")
> 
> Remove them.
> 
> [...]

Applied, thanks!

[1/1] memory: omap-gpmc: deadcode a pair of functions
      https://git.kernel.org/krzk/linux-mem-ctrl/c/5119e6b44f8ada5f5cea19935a7f005fee062aef

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


