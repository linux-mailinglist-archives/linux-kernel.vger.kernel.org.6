Return-Path: <linux-kernel+bounces-226114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63272913A75
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 14:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD041C208F1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 12:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEEC181311;
	Sun, 23 Jun 2024 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MjoSeGa5"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A62E7CF1F
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719145320; cv=none; b=DSIYi9Vj/eE8Uk8EMu/KmzFCX9NehFIkUtlBFm0NrLCsp7UmWQQgD75hgrPaP7G4gXPTKwG5KYpVAH5h6/8IPVQ6X6X/b1aKeX41Apo9FzJ/fDgKP7RpUOO0MzkxcM1XjQltCFlyYZ+VbZSU2WyEsYjwP5dQT6IOgmHn7IzWqM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719145320; c=relaxed/simple;
	bh=MFUzD0/KdFnQ464AqzGL00/7QkTXY9CeUtEYYEnA2Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nzBKX6xD2bMnMX6k0O19g5JisuSCTYlvrIfBl1WTSI5DkIZ0klYQDRmdOSdzy642jYE5NJpHDwvRbKfNk0b37UbmW9+2r6jV4NI659CiR1g5lr7fWmcvvr8vzGQGSenS/ILhq88kXh2DEOr3EXv90XI+MoFkwugIFd3AZRcTmLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MjoSeGa5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4248e28de9eso2922755e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 05:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719145316; x=1719750116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PZY/Iy3uaQiPl2ktFu3lGh5vdTeVSZZ/gvyI/ZzytA=;
        b=MjoSeGa5SXHcUv6+UICL/37+c5fDYbJOiNV9HLTgB3Y8z/MURkt6TvPyWm5uJNFxp6
         UT3kOi5425FCqTmW4ZXVXpJFiigWryGJ+1L2K0FKXTFjhYfF1ubD4z1dEv1H6pFUv9ed
         D/c4QPWVR/UFUdiYGixTdbREqkSkpZg/CAfQCojupFByU96N72lj1KoTQ5ZlGcfj7CWj
         pllvvf3+P4gAXix1tlhsUaS1Q1kYVJ6xQMwJ8NzmwnHyg5FD6IwJxKqSK3AYUFDM7YVP
         LOoNeQl688kkdJkbF2s2t1htsOhOLdUtBSwJP2mQQDe9V3y1KWtJiizTfrWtXOVb2Zh+
         GuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719145316; x=1719750116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PZY/Iy3uaQiPl2ktFu3lGh5vdTeVSZZ/gvyI/ZzytA=;
        b=FXTRo66QeuDVUBhSccsfnmA+I+wU9yNKGsv+zHAQoju3EQ1yu146FYHgkje7uwdHy8
         jstyu20shMSlBesnqocmukOI7UQzX92wu1dc3NWMHVZXk7upDJ0nGDvlRz1kqFGuz1yn
         T/axDcbp20Nc1+m+poHmIYksuFxn2o3iiKzgzdMdQXsmzf5Q+ivfKyP/sWRW1c1Zlo5V
         x/u/BDqbs7tl6bdk5+l8Ecti53yjgH+jln7NXJvrxriNWhgSMThHwc2e0uKi6NJpXd6v
         4UARu7Sl5cNcP+W//uCTvHUYzA5CMhF4kF3EPD4IcGHN5MYB/l9as3ISBM1dlSn1Q7Z7
         0Q7A==
X-Forwarded-Encrypted: i=1; AJvYcCXJtkQ8A9/6yEpGAxBY6E0/rUP9XBa82qRUha5mO/eA+U0aNC0+XmURS5s7Pp7VqSPIx6TI/8M7X2WfyyvRsmJaCgdh/nfKqofHnPNp
X-Gm-Message-State: AOJu0YzRhT7vm5krJTXX/wNEjY/G7wdBr25UOkD+y1APgKrvKKQKavg2
	mMS86TxPRIvFBFJpGu3fH54EN33n87cef9X6W/38ufkXbvg1LIxv97MEW0QCnCyr+udBBEW89JO
	o
X-Google-Smtp-Source: AGHT+IFwxtyju21J+vk97bXoJln3Azhbx93pTT8C9AEwQ1xhL4iSQkX2sR7qbsNZc48Zhknjqb4AtA==
X-Received: by 2002:a05:600c:458d:b0:424:781a:188b with SMTP id 5b1f17b1804b1-4248cc58a63mr16715385e9.31.1719145316376;
        Sun, 23 Jun 2024 05:21:56 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f693fsm7197553f8f.69.2024.06.23.05.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 05:21:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Daniel Tang <dt.tangr@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Davis <afd@ti.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: nspire: Add unit name addresses to memory nodes
Date: Sun, 23 Jun 2024 14:21:50 +0200
Message-ID: <171914524816.46635.12115355129399878010.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612151314.27967-1-afd@ti.com>
References: <20240612151314.27967-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 12 Jun 2024 10:13:13 -0500, Andrew Davis wrote:
> Fixes the following DTB check warning:
> 
> > node has a reg or ranges property, but no unit name
> 
> 

Applied, thanks!

[1/2] ARM: dts: nspire: Add unit name addresses to memory nodes
      https://git.kernel.org/krzk/linux-dt/c/af88df12762dab540d02c13324a0767473322f1e
[2/2] ARM: dts: nspire: Add full compatible for watchdog node
      https://git.kernel.org/krzk/linux-dt/c/c322d10fe52138b2d47e3b8dd65c20d705e1c313

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

