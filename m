Return-Path: <linux-kernel+bounces-298408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A8A95C6E1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B832BB24A83
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2494E1428EA;
	Fri, 23 Aug 2024 07:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="giS+GPXb"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB3A13D503
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724398979; cv=none; b=WcM6DgxidvRJ+MzZmQid9Tmm02e8mCDXQoZ7K31dwavj6E1SKnwtmkj9BCJqdM38i8U6mN/R3jTWOaIbVHLi8injq7BUPnZOPXR00Zf+F1ZRVVlAEfy+3nhoE0CWjvzvmZ0DtiIH/jTb3ZucZ84LhSlK9y6kQCyLDOPux452nnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724398979; c=relaxed/simple;
	bh=mXPUmP7dBm1hF9aPNvkVq73aIRnUiqmV6bxPVZB7uUQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C1TeDi/Z9Ue6wNgyoukTI+qUwjp3JyD16eUBijc/VB3UIwfmeQmv+kY26VgnCBl0XzoMq8P9NgqQn5absQIVtcUcHx7fURXRXfhn/IXQvfZ04ZV2CLo1GMYz4XMxx1ZShlMyAhcUATlz4SXSOrpMfU0AcPsMx+aHPiWR093R8G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=giS+GPXb; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3718ecfa0d6so33744f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 00:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724398975; x=1725003775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmP2YyoEl+UqZBO96Ffhdvh7XCvOn2PyzW0uvyy1uCM=;
        b=giS+GPXb0ICULjcFM+pNbCRmhhHnLwjlQm2moSjcQa/xqy1SamUZHa1/PaXDVxk4mM
         w5lyr3xZ9A5RH9DI3EVAWpTN32yJCFzspc8ASKVYEo+ThUBR2J7yPZH4mxzQoKE1sYG5
         6v5l/Bx2zmTcpeApETd4f9bbfJbzCaXD4uh5Q+koBEXpgCU4nH47Hmm20geYJEKVbKYq
         Wggfj6MrTBHyWgPPjGxxWbhmInYjmN+zNUk9EQdNv4f/IrPMZGYXH5kqqd3/tg/yG+6m
         bilMdAzg1MDrJAZlW6ZAp7QBYivq/5XqjnWqFMe01RHP2fMwZxK8xwtd2IZclUu5Ucdu
         otpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724398975; x=1725003775;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmP2YyoEl+UqZBO96Ffhdvh7XCvOn2PyzW0uvyy1uCM=;
        b=kJJ8YcLykeHgVLA/prfTNzoG6UTInFtfH72PmnJX3Jj6QribXL+7Xs8iKWDggliBfw
         79HjOb20zCDIr0dUqFWV3EetDKkfZ4ACVHiWnBpVbx333behSf9xJmmyudgse3v+pwFE
         c6lw9ePqbW5jUHfyLaNsOyv74mS9oLCKvvuDyB4HNPlkNKBtwaDJHwVH96Yg4t5lUk+c
         Uwu0eZSxP7cmWmiF/qVKlmmofNFeG/3S37HLS7oUVqF/NNT9acQ6jKH6d3VbcelGPmkT
         t3IOh9vPlOB9u77rZ0MX5tEI0ONpNQWAQoImlkf9kzrEET8Ppx90rouTkuPuaufoG6Nl
         xRnA==
X-Forwarded-Encrypted: i=1; AJvYcCVCwkAtoVLXHa0SKEST+s7/KljVSvC/I++n1RmueYR2HTBsDI5rGjHH7eEGAuruzJvRp2Ua87rLLOsYIfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaD+w+aHZD0nNZNzadMx7S7qTDzuBJu7O8G/kJ3zDxSov3eDS9
	UikYX4qHbo+etMElOa1U3bDQ5vfMftL7kq9OMKmMsu+sfylNtDbHEt11W3x4dFk=
X-Google-Smtp-Source: AGHT+IGsW2lhogX/jQQ7aTmGIukA+1KEru1fVIORs51u+vDhDGzCYq/S7fM0adWIz+lBkxatIHvO1A==
X-Received: by 2002:a5d:64ce:0:b0:371:733c:7882 with SMTP id ffacd0b85a97d-373118e9fcemr398335f8f.10.1724398975228;
        Fri, 23 Aug 2024 00:42:55 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff63esm3485541f8f.87.2024.08.23.00.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 00:42:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sunyeal Hong <sunyeal.hong@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240821232652.1077701-5-sunyeal.hong@samsung.com>
References: <20240821232652.1077701-1-sunyeal.hong@samsung.com>
 <CGME20240821232656epcas2p48fcc8ecd2bedce5cdcc7d34a0069ac2a@epcas2p4.samsung.com>
 <20240821232652.1077701-5-sunyeal.hong@samsung.com>
Subject: Re: (subset) [PATCH v9 4/4] clk: samsung: add top clock support
 for ExynosAuto v920 SoC
Message-Id: <172439897372.16898.6606319087129896109.b4-ty@linaro.org>
Date: Fri, 23 Aug 2024 09:42:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Thu, 22 Aug 2024 08:26:52 +0900, Sunyeal Hong wrote:
> This adds support for CMU_TOP which generates clocks for all the
> function blocks such as CORE, HSI0/1/2, PERIC0/1 and so on. For
> CMU_TOP, PLL_SHARED0,1,2,3,4 and 5 will be the sources of this block
> and they will generate bus clocks.
> 
> 

Applied, thanks!

[4/4] clk: samsung: add top clock support for ExynosAuto v920 SoC
      https://git.kernel.org/krzk/linux/c/485e13fe2fb649e60eb49d8bec4404da215c1f5b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


