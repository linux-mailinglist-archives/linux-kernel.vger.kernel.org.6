Return-Path: <linux-kernel+bounces-223982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA530911B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632BD1F242D4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6336B16C858;
	Fri, 21 Jun 2024 06:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ofgm5gtE"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99ED152DF7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950685; cv=none; b=BpFB5TZUGqGs3Mae8hABCg6hFiqvzXMu1TFa2RgcDiRfZwOL9Tjf+yJItgI67ZljLXK46Na5NpPTp5Ni+cpRUF1trBfwPDX6mvlquH+qHEEjhzZ0uK8fNBMMD/rki3ktMe4NDcFj5pO7H0KYDbBePysMuhcacAOhlajOaY+WfIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950685; c=relaxed/simple;
	bh=gsCxHz0NnDo414oRCn1OhO+A1Kd5SBw5weSt1z8Z5xk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K30LjWgOQG/lKcWv9lWfFNcMv1sMbHhdTsmA5Oi4RfZxGEgYIelS2depRkAdUa9kA/+oWH5OQOYfNgrrBDwBrj6jY502l1yVsT7GeusaKgjzztb/tmxO8fLUKiekSRnB/xwLOxSeXlo0HD0+Y/jYbK+ESE584Xj9Z4Jx/yt1t6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ofgm5gtE; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so16188211fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 23:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718950682; x=1719555482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8v/aKYe+JxVI3CfS2FvYP2HrkFepPdOtUXTcrjF4Iy0=;
        b=ofgm5gtEYUTfXQNaqYyJtUoNghcyX5rq7o6gpyTxqePpoPKeEVxEx2b8lFk25qiyNN
         YsEGb+J4fpXg/sCVH4xVITjT3Kj0p+b4jirPE30Exn89c4aZiyZYPFIGrBUbSq54ukuU
         K65/BLEfCkdmKasOBmobARyDx7quJ5g566Sl88oRzH4YLJQOYaFB+wbss6M5+KX1ErTw
         vgPu1NOlUnepuP7grHRQhIp7vw/QUTn95alTepTiCdmv8kEhRhZCLgwTw4ZZW8lovuf8
         jZYqwjvCHU3RdFDEiHoFv5/oK0M2mdzOHbryGbQ4pfneIPwmKDKe/CXdlvMKhWu014xv
         YLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718950682; x=1719555482;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8v/aKYe+JxVI3CfS2FvYP2HrkFepPdOtUXTcrjF4Iy0=;
        b=o3m0Z8BujFuE++Wlu5zAwfab0TbC4og+6g3I9W4aXWB+FcKH2bLhpYy1rAhNMfpXTy
         oC5QhGTssYComZb8KcQG/cW8mnWx3pfFHwOS8AEg1iB67vnUy5r5QbCB82//z6MdOmNA
         p+a0iMz3qQTkA4m0bQwXqlsFn0veJd8fNdPvp7LbaJxkLDKsB/1rREdgG3qnwKJjKTuJ
         7AdcrCEGnMBCzvp7Z5dhPZN4px9Vzyrr/zw9xhzD5WC2JkEezojYwnKrQAFuLOvuLr85
         1/UpSLsPw+uaJGJrZk6XQVYTCmcraZbA1Px4yZ2oeJh0moV3pGrwHiJ+NS4EjNpjP0H8
         vzPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtAUzGoWK3oKYXDmHm6VseSrotd0XHFvA1UlsBtwyfYGB33sFz8FIZy6cDsmV/SNbH1vqCjo0kMPAKWbhuqZIywLVX15/N+yl/mhYA
X-Gm-Message-State: AOJu0YwbJcVvFpd4DjqVIczz+ZEFDJ20QdNZd7i+/jQPdSUVz1yWLQL7
	NrChCQ1AxVdIOtNJM8wcjB6yJkEwgvRyeWwOW5aTHMeVWRUDeS++QFPsPgyosJc=
X-Google-Smtp-Source: AGHT+IGponEudPSsJyTnvE0/1vxRs81b4VCjNl2TJlLRqh1PuPPhoub4NIgzenIurozR+Yc7M8Yv9A==
X-Received: by 2002:a2e:a710:0:b0:2ec:3d2e:2401 with SMTP id 38308e7fff4ca-2ec3d2e27dcmr38061871fa.40.1718950682006;
        Thu, 20 Jun 2024 23:18:02 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42481910fc9sm14075635e9.33.2024.06.20.23.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:18:01 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-nvmem-v1-1-ef6f10c86a63@linaro.org>
References: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-nvmem-v1-1-ef6f10c86a63@linaro.org>
Subject: Re: [PATCH] dt-bindings: nvmem: amlogic,meson-gx-efuse: add
 optional power-domains
Message-Id: <171895068013.13708.3381966388951279908.b4-ty@linaro.org>
Date: Fri, 21 Jun 2024 07:18:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Wed, 05 Jun 2024 11:35:22 +0200, Neil Armstrong wrote:
> On newer SoCs, the eFuse hardware can require a power-domain to operate,
> add it as optional.
> 
> 

Applied, thanks!

[1/1] dt-bindings: nvmem: amlogic,meson-gx-efuse: add optional power-domains
      commit: b654441eed93946538b5cb3801a5a6dd58b5d692

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


