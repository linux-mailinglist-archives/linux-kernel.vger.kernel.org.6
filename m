Return-Path: <linux-kernel+bounces-190584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4EC8D000B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D2F284762
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBB615E5AB;
	Mon, 27 May 2024 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rsIexbuJ"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143A113BC31
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813116; cv=none; b=hMuQKBD1NINyV3ayv+PbjxQddoOAhvvkwve+Dph91q+kKdRazrBywgsKw2NjSXjA3mqOumLUWM7HTB7j3NR2CXDI2yBD8HpuSVDMDZw9H+yDm6vaSDGnkX1EizKR6dxmWggzdokqrF7hTbCZl8cW9W/Z0cesZVkhZKfApBL2/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813116; c=relaxed/simple;
	bh=Pg81kNExncHYgEH65vSq7ojtlVX7662uOZgf0mLJfUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQtaAC7+QOVZ4Rqfl69NEX+fK6BDrYklv0V/1/EkwE+ecGfqvrP2+8kL1LgBKsbWcR+yjKm0Bas9kcI4n/ej2Vgc/LqWZvKqedxgu2vEaPelCoZrl9gbsd4RgvUlcq3khf8Pnt/ejDzD2FUICCgz4WBGbh3+BDw6RDcIbwAS7QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rsIexbuJ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-354df3ee1a9so5225718f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 05:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716813113; x=1717417913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XqjqewY/IWqR8PihupcnQhLFobAiXFGUHx0dGRIGDiE=;
        b=rsIexbuJjyNEa/dKDfM1aRwhZGAtmS5ZClYc1zegIOXlHOVE7QuNCoSsXSr7VRKRLw
         GefYKXyHyEZT8KCVRLzM5lwAJzgUPsHK8cSkLw+CiCOpM9ENBUe2SO7BZa8lOepAa1Qb
         I7EixgpxRQQ8Bd3elXEcs2Em9w6BDOe1WTni3iFb+6/0s6kKC7C5X700RjBURAm9XOGG
         PROYpSDrqWJU0fNXghfj4Lu0mbSHUKPlrLO6+rQSe/9Ury54n/n4WC5gVD5EJqiQtNb/
         /VQ7WEI+oTW8xatO7yh9yFi6ACxFZbfTIripFQ5wBQD+E1t+18f183DrX3IO9ca4KbvK
         AYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716813113; x=1717417913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XqjqewY/IWqR8PihupcnQhLFobAiXFGUHx0dGRIGDiE=;
        b=D1Q0kUPNhjiBlfxZdrPEx19IFXBJEYRx2cPaUPIbkQ3jFAsHbOHZvjyniI5FXOrP2a
         1CWch9TOvz9FMqGz+jGj2exQ7+7Sr4+Dpwwyxf1bZ3eQdTLZfjby1XyxR2SSWfU9nIOL
         16Q4MTgmVM2UGyDIcJz8fT/vViX+/Pp2J/IZHZxsiH/eJw9aobqc0CylxcSlD3DD6t8W
         mXjD27z8oBcizzcf6NThFqEQA827ibiheB/8CaUM6jM/YKazPny1Ze0Nbzx5SPnoK4Gg
         GsgVQ5SEsHxQ3wzJlFAWXmnzV5Zl/nq870mSifZXK+EMq9DhPTmrBQ3mT6gAkhuQjACP
         GYOw==
X-Forwarded-Encrypted: i=1; AJvYcCXLlwHYx8RI0n94S3BizjWm66Aqbl2Ro8ojdCJFJxZBI1+uilzCs9sQmJIDxRRESDYnnSXbPMTMUrXC2ExhzuX1UXeaPVCypVwD6FQs
X-Gm-Message-State: AOJu0Yz31Fiwh1j+v4Gl2iFB/3YIxfePsEYimOr4Y61biCTxHLTz4Zjy
	UTaEqVaSLJ1Y5QN3vMBB6T56IloBQg84JlNU0pDl3cDuLAWitqwS7epf9Mx2S+stMmgV9K//RQu
	Rp34=
X-Google-Smtp-Source: AGHT+IH4Kh0h4/Hczoc0Zp0xPOSEe6v0ZhamuCceNxDEYLUCUwyJEorjIWlpkcHWZTjNRoyxbVymmg==
X-Received: by 2002:adf:f801:0:b0:354:eb62:3653 with SMTP id ffacd0b85a97d-3552fdc8090mr6257038f8f.53.1716813092584;
        Mon, 27 May 2024 05:31:32 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-356c8daef27sm6814638f8f.115.2024.05.27.05.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 05:31:32 -0700 (PDT)
Message-ID: <06b06b65-8eb7-43f6-8fb5-e5663876edb5@linaro.org>
Date: Mon, 27 May 2024 14:31:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/14] clocksource: mips-gic-timer: Enable counter when
 CPUs start
To: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Aleksandar Rikalo <arikalo@gmail.com>, Chao-ying Fu <cfu@wavecomp.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@kernel.org>,
 Hauke Mehrtens <hauke@hauke-m.de>,
 Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Serge Semin <fancer.lancer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
References: <20240511104341.151550-1-aleksandar.rikalo@syrmia.com>
 <20240511104341.151550-9-aleksandar.rikalo@syrmia.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240511104341.151550-9-aleksandar.rikalo@syrmia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/5/24 12:43, Aleksandar Rikalo wrote:
> From: Paul Burton <paulburton@kernel.org>
> 
> In multi-cluster MIPS I6500 systems we have a GIC in each cluster, each
> with its own counter. When a cluster powers up the counter will be
> stopped, with the COUNTSTOP bit set in the GIC_CONFIG register.
> 
> In single cluster systems it has been fine for us to clear COUNTSTOP
> once in gic_clocksource_of_init() in order to start the counter, since
> with only one cluster we know that we won't be resetting that cluster's
> GIC at any point (ignoring suspend/resume cycles which would need to
> handle clearing COUNTSTOP in the resume path). Once we support
> multi-cluster systems this will only have started the counter in the
> boot cluster, and any CPUs in other clusters will find their counter
> stopped which will break the GIC clock_event_device.
> 
> Resolve this by having CPUs clear the COUNTSTOP bit when they come
> online, using the existing gic_starting_cpu() CPU hotplug callback. This
> will allow CPUs in secondary clusters to ensure that the cluster's GIC
> counter is running as expected.
> 
> Signed-off-by: Paul Burton <paulburton@kernel.org>
> Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
> Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
> Signed-off-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> ---
>   drivers/clocksource/mips-gic-timer.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


