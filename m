Return-Path: <linux-kernel+bounces-432997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 479DA9E52C7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71EFB1882D1E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A603206F1C;
	Thu,  5 Dec 2024 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M79Uz546"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B82D1D90A7
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395330; cv=none; b=ueXxqZ2RFd4bfiCAFLERyWKa6KUh9O1W0afpMt6+AQwGLcfBS0XwCvvWwN0iX5Ijj1zVyLg+aCNEDlitAhk1Xz9OQnCFZAFEu0YJBpjle9f/eUKxxc+KOTZrNENp1UfFTuta9/jeWzO1/Lszq7WV9G9jNDec+rPvyN0y6eufd+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395330; c=relaxed/simple;
	bh=InyyJ5b3p+cMV6PwTAk19hDK9hyyw6Af0BJu9ci/YHs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gL5U5YifCUjqEQPp5ScpCTkR+anwlebqvnToKITyfwHCymuKRHSfFKe4ENzTVEywsUhSBYfdn+c40fLO7SGzMImO9X7VHoZ6DtNg3g+QPoOVbyby5PwO1FJqSsiQSi+w3sEWp4gU8srG1bvmqhZiwCqSDSSZ4wPvQl9HgL08l50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M79Uz546; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385df6d7493so20595f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733395327; x=1734000127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KIDC3qcWfMKcz6d3c6ytjMEzqjSJwAXK2JJVWX96Zw=;
        b=M79Uz546CUBxrXyRUh1HooIXM0NGWphtJqZ/mJU11XlhM3L09z+7XJVxqk2s6ljBZQ
         sWW3QoP99PsZu2bY/fMSVmGNZnQVtdE9bsuOO+JDh4LJbgtSAirYMLTu1Scb7QkJ38SL
         dZMhgNlpDHv/6tEmk3f3STXLrMDhrCpbxhliyVArOg0PYZWtGIe9WO6TdeY79xWZaC6c
         lcyF4s9PKjKwEt2ZfeJMU2GZeiCf1swSQsjioH8t1XPFL6bwMBOj4Y235NvdMysG2p3Q
         DzC1bZXP2gxOOSZVLoyTY0iP2KJHqbE71HVEr4Q/WPSG2VWOeFmFUh19IAqQkWkQ9TvC
         SEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395327; x=1734000127;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KIDC3qcWfMKcz6d3c6ytjMEzqjSJwAXK2JJVWX96Zw=;
        b=fGK5eqflxMTCWMMy4/iD5GPuIndPwE21uM52n0UmOsu922Ix/YRHAex933P65Np7VK
         tY3xi+yuVVn6WJbI7Wy9mwc6IjO9lglB8i879d9ZZqFOjkt8f5AH4z13cfLe2CDH8xmh
         ACP6xA5Cq3vhI9wLc9VpVQ5bwnxuvxnyhn5P2UWTogPpGFjoKlvLfiK3nvGPdispAg68
         J43qz4b1op8WR2s/raGcYFtb3EsFW6Kr0uCSrMykqASvy0+fol8G0XF5HM0JMozbF4VQ
         6G9xfcpUhJgO/XNC6DKayC3WWlhNsCJJfDf93N63uohqHfAKxgGxZDsNy6FMsGNjfYJP
         lb8w==
X-Forwarded-Encrypted: i=1; AJvYcCWJGhxcDLiPz2aLeV9hF9GLkpMbyeakc060SKRv7MDTjMgN82LmQchpnMrAa0/TtQHiWKJjiJI3POguCkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyry3JwGu79gmVFKHNXJzsuaAt/kWmPpwpLhR6pM7bxWJKkaF07
	wt6esUl26hKfA5rSRknP6txB+tn01eiC8McaX060fKfQR8nQf8CP4HjJTQpl8cY=
X-Gm-Gg: ASbGncudxkUAWdXzpNUWGwqyimH/a2/CEUkfy4jjimh8iak9N5K5WfTODR01WVzzPaT
	TfyXNokGj9xLRuqrii9QpFNPYup7qyY08IAy0iHSFbCSDuAjr/OEABQy7dxyxHbdJYMLdTiZ7T5
	0dFargDKJLdDlXmG/bCuZ8EpAm2AjeSnhV6f/lkQG66LCDxAqiRfRpqaxLymqJ6zoPMQpKyb/Vx
	0MqVZ5SmFFtU2vAYLUu3rmUGfguHBVFJrl/n1kQfogz5V3Vy+vyXedqkfWEr1e3ig==
X-Google-Smtp-Source: AGHT+IEIGJejMyX78O7Y5nPwUxTR92b8MmG1gEAzs8vepMTJTKVucanlx+rtoPz82m9AIVr178e/lg==
X-Received: by 2002:a5d:6d02:0:b0:382:41ad:d8e1 with SMTP id ffacd0b85a97d-385fd42b9ddmr3240841f8f.14.1733395327461;
        Thu, 05 Dec 2024 02:42:07 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf406csm1662701f8f.3.2024.12.05.02.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:42:06 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <cover.1730918663.git.stano.jakubek@gmail.com>
References: <cover.1730918663.git.stano.jakubek@gmail.com>
Subject: Re: [PATCH v2 0/5] Cleanup Spreadtrum/Unisoc ARM64 DT (part 2)
Message-Id: <173339532634.70936.15343238064427564768.b4-ty@linaro.org>
Date: Thu, 05 Dec 2024 11:42:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 06 Nov 2024 20:05:19 +0100, Stanislav Jakubek wrote:
> This series continues cleaning up various issues with the Spreadtrum/Unisoc
> ARM64 DeviceTrees.
> 
> Changes in V2:
> - dropped original patch 2, as it was split off into its own series [1]
> - new patches 2, 4 and 5 which fix some issues found by Rob's bot
>   and/or CHECK_DTBS=y
> - rebase on next-20241106
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: sprd: sp9860g-1h10: fix constant-charge-voltage-max-microvolt property
      https://git.kernel.org/krzk/linux-dt/c/367d31471c3272b87a7e842355b2aa4bc688add8
[2/5] arm64: dts: sprd: sp9860g-1h10: fix factory-internal-resistance-micro-ohms property
      https://git.kernel.org/krzk/linux-dt/c/e864e215ce2197cd5d5c0e9229b4bb83379a5186
[3/5] arm64: dts: sprd: sc2731: move fuel-gauge monitored-battery to device DTS
      https://git.kernel.org/krzk/linux-dt/c/ec87fd9f66bb8196ce4c80b6f9a02a8fdb452821
[4/5] arm64: dts: sprd: sc9863a: fix in-ports property
      https://git.kernel.org/krzk/linux-dt/c/a34907f484949e3a550a54a19d71e8616d812d7e
[5/5] arm64: dts: sprd: sc9863a: reorder clocks, clock-names per bindings
      https://git.kernel.org/krzk/linux-dt/c/49f4ad82f031ac390ea4571a5bf7d58ee27ce4f2

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


