Return-Path: <linux-kernel+bounces-282952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C0494EB33
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA051F2113A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B897016F907;
	Mon, 12 Aug 2024 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MS531Hdv"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F75175D26
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723458793; cv=none; b=HZxDEDL4ucbcxRljO/YqMNZueGJoxOvrkNDowpcUsiAkjj/GYq5UfZ6rdeLuEue1N4HnncE0X6xmuVLcGzkcRvMz54tLd/mccqV1yEOzdyN5sP5hNoxGNTGbUvZF/wtEFKZhUS2pmb4RTDJ97IXtMz3WSJCelPbfw3EFsB9MiT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723458793; c=relaxed/simple;
	bh=EGnlU3srb2PH2cn+2rBzVIhPw/GkZ2+RBbqJk77lmxY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u6ecSMbjdOhxcbN0rtxCr9oXs3vRo7Hr1GVPxeVA2yuN+7DwKFDY+KDEMSZJwSVjXL2kFjKm/Ap3CSYpjBIekDNIIg9mwG1F1FjKdvP+zpzvWjr9dhja1xUA9PvgpPPaFgddxOD3bWB0izmJSnSLjvGKBqMXZZisgf1Pk/eeIBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MS531Hdv; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f189a2a841so40182641fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 03:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723458789; x=1724063589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+O2jEU7VQzCCDwlDvaDxOPZOWf256RVxVkJq/bzZGgg=;
        b=MS531HdvqQFIWNIYKM1YSftn59dYY1UlfdINwc/BYbkJc/gJsMJx6Y3GAT+YijhwFd
         rTliO99e3zUsMjCe++mFl6mHnTUdQIM5xkULidnNczc0cAVKUOHcAUW3/AfgufrAwWTM
         R//Sz1oWZCZyezE/EvF/hSr+m441SwEj5bMnCZryeLZbVeQSUv0jgJ6eEmXeDtBPBTwO
         chtQ1nYBEtFn/PUg3FzkKpnjF9645Q/AMlzgQi/CwShXD+466DrUZvv/wg7y00+3Spcb
         K+DL3K+y52ZFNlidrQM5OrZiKtHZZZzjUQOABS3p8PeDHHFrA1GHs4U6X3V05G6svwFx
         TJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723458789; x=1724063589;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+O2jEU7VQzCCDwlDvaDxOPZOWf256RVxVkJq/bzZGgg=;
        b=qXxU5XiL93eQcollXu6lhJt78ecgcyHoI3CUBuR5AU+PayPGw2Jdo7gVn3mKY1LXnQ
         GiV5ZY2da8HhLBMoJFTlKVREIX3r81JiptwcYBgz9y6wj3o3KRDfrsXMXBDdoeTm0VnY
         v5ty4LY2Z3G0U7T9msDBA9vz1mVDCg2Un/SgvoZdqZcu13exEYbwKmMLRinjOlJWOdx6
         PGmXTrbFwQUKNg+H13GwonjeXevwA+SQ4TUUwsNTkauNgj6PuDDVJep0IWPAsmuE4/JH
         RWP34GsdG+yJ2e9zHP2vKQOZx6x/qr/9Ur47EkbascNuG3vzBvvKrSHnzSO0Aw8xunUV
         ABDQ==
X-Gm-Message-State: AOJu0YxdotOzOf6h87DlVxD5AmHL3BBV3lbjftjuP8WwFW8SOqanlnn9
	SYVY34It/LGS3roMLduH50UheeWAl9bYOeKPTtAHHo73cf6swbZgiO6qDsWrpbE=
X-Google-Smtp-Source: AGHT+IGy5a46Y1wcO4SwOLwsNuPEhnEij8flfsYPhHBigT+Y+o7JsnRnPuko/G7HeykoRII3zMWL+w==
X-Received: by 2002:a2e:b5ca:0:b0:2ee:494c:c3d3 with SMTP id 38308e7fff4ca-2f1a6d04600mr55015031fa.43.1723458789351;
        Mon, 12 Aug 2024 03:33:09 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c7bf87fsm184437065e9.48.2024.08.12.03.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 03:33:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Santosh Shilimkar <ssantosh@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
In-Reply-To: <20240809-ti-aemif-v1-0-27b1e5001390@linaro.org>
References: <20240809-ti-aemif-v1-0-27b1e5001390@linaro.org>
Subject: Re: [PATCH 0/3] memory: ti-aemif: code shrink
Message-Id: <172345878844.106150.5555548130271543132.b4-ty@linaro.org>
Date: Mon, 12 Aug 2024 12:33:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Fri, 09 Aug 2024 16:15:53 +0200, Bartosz Golaszewski wrote:
> Here are a couple updates for the aemif driver that result in a significant
> code shrink.
> 
> 

Applied, thanks!

[1/3] memory: ti-aemif: remove platform data support
      https://git.kernel.org/krzk/linux-mem-ctrl/c/8c38617722bdf57a90e6c77ed9ee5ebb60958d2a
[2/3] memory: ti-aemif: use devm_clk_get_enabled() and shrink the code
      https://git.kernel.org/krzk/linux-mem-ctrl/c/f6ae541cc3355fe872d4c942dc47d67877951d17
[3/3] memory: ti-aemif: don't needlessly iterate over child nodes
      https://git.kernel.org/krzk/linux-mem-ctrl/c/23a641d5c2bce4c723fff9118a5d865ee6b9d05a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


