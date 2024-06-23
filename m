Return-Path: <linux-kernel+bounces-226116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A28913A7A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 14:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9146C1F21996
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 12:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1AF181B89;
	Sun, 23 Jun 2024 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dwj3cyPh"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E86D180A9B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719145322; cv=none; b=Z3OApsHb77w2qxUTEmeH7H2Cs3o6lTw4RK/o+FDP8labI7Ub1+v+A7GycHREP//0Z6BvRNRvf7YFMxQLYi72njt6cjCbfqa0reUArkyK0bcZedGsDWhVPml1R0vp/cWKQI9aTpbv8fQLnor+e9FJY+4FnviuMwJ/livv+CXJfuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719145322; c=relaxed/simple;
	bh=+YGQG0spIEY6BX8fp8IB2Zt8B3O2zosJkofUl/9HmX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5rQUAOG0FYv66GIkRy6lDgA32C6bSFrB6QXjUPkxb0l1h+Ez7Dqaj2mA2MAVpkzMlHqOoC4lMVnw3c5Dhq/3ehJ/vLQ+n9fZ3rfGOpwvsz2rJR7TL0kqfRvncnYPXDibBOy5UHvifBw4NDMccO4nf/d1Oo+TK3xWXrYh0aByLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dwj3cyPh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4248e28de9eso2922925e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 05:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719145319; x=1719750119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xJyUiMAg6Wu8/Ka0Q7n5MWSVJTNOLPxK+8fKjiZSBI=;
        b=Dwj3cyPhtiudiLIBNIyCRgT286bYDcEHmurqfVPwMBdaI0EvP7NOJZegIniH5QtY3L
         SpL7/3FiFtLzKGg+tqAHFDxtLEMAWjWMIkKYytFg/mIzK5tUECMOGiRRLnCGDNM6yK8K
         Rkx9Cef8PWz4mNzroGnBlrtkEn2ghbaf4TBLot1HQhlb1yGS/BALN5PBQ3eNkcmb1GBp
         hYLvvwCvTf85YKRdD+xPs1quml8xm8+OpLsPO2Q6KepYfi1a5khTtv4yZc6wcy0M5s8k
         Y4l5U6Z1duUi7Bfs+eeji/5M6+jdnSSsXbpa//3V5bUN7GBLVi3pIvPRpPqeoWakVnSQ
         1ahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719145319; x=1719750119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xJyUiMAg6Wu8/Ka0Q7n5MWSVJTNOLPxK+8fKjiZSBI=;
        b=Ky3qZvqSbQtibOVJZfWHFry/sehLbkL4LLOdSBZcQjRYGzSGKzsncHR04cxRgEHFPU
         3DJ6oZRt6pLY0HSYrFd9WhKdTpvyEPsdbbWAyD5DzBH15tFWtkI5CGtANtW/9WZpoUDz
         z3zAYOdEvpp7lZWfTT2yUE1m8ghwbExK78em7duO0bVXS32hMFz0YjwvkSyLgMAuusD6
         SBBSP3WEgDL5k61cyrYpmcDSOCuBoXlvq082Ri+gDAGfGHmnHmyd6O5fWjKHR1SiBsX4
         KtcwdTcHx25+B6hBotV+Lk2AmIYPRH3MxkBHZNRN6Qrg31SS5DsNL4qbKWQCaoqX0FEz
         IcZg==
X-Forwarded-Encrypted: i=1; AJvYcCVTpxglQ6dfmHAwQLbAdjjegxhbfA7ai3YxT9iwtw70g55nUdPJq+4bRz8UkdJTfi/cvAJflTU9xBlF5lJQIXBpKLK3Jk7uWvqmHLs+
X-Gm-Message-State: AOJu0YwMhd75r9oScyZ9s4Ry3kaS76Qxo9oQ4F5WkCtInL/YIi5Ym7L4
	Hp9jfNaPls9z8e3eRIGRaskxJWVnRADgaQZlGgzz3iCPRHpwE5A+UwhMX+E4OVI=
X-Google-Smtp-Source: AGHT+IFPLL8eCdHVFuOLDW1xXL1QPUIz6sBz0E+klp2OdhebFWnLznYwiSHr8z6KUgEdq8oiR6S9kA==
X-Received: by 2002:a05:600c:5686:b0:424:798a:f7f6 with SMTP id 5b1f17b1804b1-4248cc1838dmr15911535e9.8.1719145319639;
        Sun, 23 Jun 2024 05:21:59 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f693fsm7197553f8f.69.2024.06.23.05.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 05:21:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	openbmc@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: dts: nuvoton: Use standard 'i2c' bus node name
Date: Sun, 23 Jun 2024 14:21:52 +0200
Message-ID: <171914524817.46635.6976704270027238495.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531193104.3814663-1-robh@kernel.org>
References: <20240531193104.3814663-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 31 May 2024 14:31:04 -0500, Rob Herring (Arm) wrote:
> The standard node name for I2C buses is 'i2c'.
> 
> 

This one is waiting for 3 weeks and I think it wasn't applied. Let me know if
someone else should take it instead.

Applied, thanks!

[1/1] arm: dts: nuvoton: Use standard 'i2c' bus node name
      https://git.kernel.org/krzk/linux-dt/c/f873f24375c6d46bea92a2ed8ffe55b2f9d5509c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

