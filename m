Return-Path: <linux-kernel+bounces-427095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 371979DFC71
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2EE3162D83
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0FE1F9F6C;
	Mon,  2 Dec 2024 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uR5R1lug"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E0A1D6DD8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733129632; cv=none; b=iXf3PxlOhtjsnWYKbn+uQrnROXWmRKODWs5pGEcYkSQBmQlm1QtNJZYAUOplhqzOWj1AdfemFJ/hm0FlnWA6eJ55rIidwXRVX8q56VHiMzvHNJ3o7XYUzXx+l6GTzkxM8WtnvPTcdZCSrP6rGo9Q4wz+4GOeJ5IqvZIJvP0rhko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733129632; c=relaxed/simple;
	bh=2i2om8Xr6XlWbPtkB4mQmhNxO61vqI/tBU/YM1EQwgQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k12iYN4pJvUkURf9uq1X0j9B4PWqs1EDnjQBgDylr/xcn7otDmrs+UrFe8EMnVemPgtuSE/lAdD9dNlOs/mTLve7sV9G/h0byEZ/DHqdKdZFgVhQAEmQ2/9sKd5c29bq2DmZw9yf+6uB+z9V3HLc+wx6fmwLQHTTyTQa9ycvaYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uR5R1lug; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a1095fe4so4743385e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 00:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733129627; x=1733734427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czYJoJVZrGDrcGrSH7xTDrifbpWsag5ZixMFLdzGQBA=;
        b=uR5R1lugf4rnAetL4C7xgydh8dmg13f3lRiOos0vHxHH2RPJIPup8/nHekMZaZGyYf
         tfdfQ6ZgaHFRsjilB9My9hncQiK+Qi+ijJi/k/nX2b8Kqt+Hsc0l1DtH/xOinPK+4h2D
         8IZrTY8xDwfO5slWmDTEvMQM4ZL6lZ4zMA2t4mUJQgt/eswes46xwQuOHgiextU/1i0E
         U1+DyTVcLnLLCH7/S/tRGyL+siGS8r/pLK/UVwHuo1k0qDG/l9rCHwRmf/51TSke1VDM
         +3IpVX6buE4cM2suayguCqi5PoUSF8TYU49gJEkhGOu2sgVIIwzmjFXtCnwbuz/4pzjd
         Svuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733129627; x=1733734427;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czYJoJVZrGDrcGrSH7xTDrifbpWsag5ZixMFLdzGQBA=;
        b=TG7beZxIr8TeWXJZPNCd0Imk59CcpaBK1PlBUTHZmV5O+5yKIN0UO/YIF6M+Su6EmE
         vlSS69oiIBZiwvNCHT+DMLYHGVHlfocSOsi+lZkW8m49pwWkk2ESZ3zfWvjCBHnBYsWk
         BorAvo1xZ7e/pxmf2s6zRtSN/j+zq+fcmjGG7jvw9gykE6ARUKF+jb5TDW0QuvF8/b+1
         qGVHC+uj6/hjizubz6SzCotlsfxBdpUheT3Zd3QQhD1GKXq64KXj1TtLfgGrmcJF1AI9
         88C/FfFEjcGnob7AQRGD1HrCYUABaPDsfulmIiOl7H/dEj5ddmPrOFOm134A7IksaIit
         GufQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpalmCAKPqplgHZLQuFJP4SQ1vNjg5cQxPdTmEdj/4mC7c910YEsQ9SoFl2LeT52bOOqJSMhWSgz5pGFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YySC8zWnr7XWxcXro6wr2ToimtXpMefkNoQSz866rjx/2cjhyHX
	wx8AL9ZeFVP9rMr8rnnidburLAloYVCY89DPE8/+dcYa1d9ij6XwIB8U/avD6Os4iqPevn+NvBm
	ucyTcjA==
X-Gm-Gg: ASbGnctylyIYOY3IiolTZ4rs65WdTJMt4Tm2lua6OOdC/bz+H0bvpcxEzNIsr98Uq1X
	hCcJ95q33foFOb3T5uCOEftmEMiHRBnbTeIIGqamlffji4qPnj0iAmFJk/rPo3KQEOGTKe/lNHC
	Diy1+7BoNpGwOoPwxKBUlGdVbPNY7bVDuMp+WxP60F/jIv7Fgvz5LTaqFIUR2NgEo0RGhdMNerx
	cvr3aGH709WBbZr3Oudb8p/KUFaPBwlpD4oP6aJYJ2sy8RC2KgfE9YuKkUQ1x5v
X-Google-Smtp-Source: AGHT+IEt2Iy6Cb3ngoq5i5atsn6oO0wODGDw8HmWj/LmUre8JQUIZCkcZBPIKWQx3wB5DyufHzMuJQ==
X-Received: by 2002:a05:600c:35c6:b0:431:4e33:98ae with SMTP id 5b1f17b1804b1-434a9de6738mr75550165e9.5.1733129627445;
        Mon, 02 Dec 2024 00:53:47 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a972c33csm140920385e9.1.2024.12.02.00.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 00:53:46 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241023091734.538682-5-ivo.ivanov.ivanov1@gmail.com>
References: <20241023091734.538682-1-ivo.ivanov.ivanov1@gmail.com>
 <20241023091734.538682-5-ivo.ivanov.ivanov1@gmail.com>
Subject: Re: (subset) [PATCH v2 4/5] arm64: dts: exynos8895: Add serial_0/1
 nodes
Message-Id: <173312962604.23906.10353059101648062689.b4-ty@linaro.org>
Date: Mon, 02 Dec 2024 09:53:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 23 Oct 2024 12:17:33 +0300, Ivaylo Ivanov wrote:
> Add nodes for serial_0 (UART_DBG) and serial_1 (UART_BT), which
> allows using them.
> 
> 

Applied, thanks!

[4/5] arm64: dts: exynos8895: Add serial_0/1 nodes
      https://git.kernel.org/krzk/linux/c/aa33006c53c9c56ecbcbbb9b5415e27000eb86d4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


