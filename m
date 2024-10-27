Return-Path: <linux-kernel+bounces-383779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3518F9B2024
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659171C212BD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3780917BEAD;
	Sun, 27 Oct 2024 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d9j2F0mB"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D866157E9F
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730059368; cv=none; b=KjSHJFBeJQ9exsvQytv8qxXO5mDpgYyQCra94V5TBphxUqnCqL+UNJ00mBdTBiKBuuF2nhFK7G9rBrKTOLyVltyXUGzsaoANlD8hZnYkviXsis/Rd1gZb8fJA2KfICaV6yZG7uelv5CMF4+ydX4NGN+et+FE5yMgVAnRAcUmfS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730059368; c=relaxed/simple;
	bh=3AVyA/se0XipGvqkqlpBMVTYiNS2aTG35lDnIJItl10=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c6uDUYgfbc7BQFLSQcW8myjAHpAScgpApiyLiMJCcOwckzdS7r5XbzO2PlGBA1Dnz5gPj/tLKppj3Q7wfvrflhYHzM6c7eGcAVj0BwRsIoyGrqp8XaPKMABiTWoOuRUDoki4pkQ6hnj4HYGGnfw9ZcYfL4aAgMzEwcvAkeWc8sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d9j2F0mB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4314c006fa4so2930905e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730059365; x=1730664165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HZ8JFZi2Qkm6YYcM8grPf+xKDycxiruU8bzTj89xR0=;
        b=d9j2F0mBdclhx17skaMH0GL0D4w79H69JRIpDQ5m+iwhBDsB0MS8kzHFG/x2yuYP74
         h+6p1O5OqAbdQ4+L83cjAkmeWQv69TS6MqO4RY5GmxEXl1mUoUoNwUOYf2LfI/kDRWDO
         KSu4FR3/iyDfErseMwD3dDu/Uz2oPZCrCe+u690HSxA3i9RUlN1NiMmR5j7951tqeNrZ
         I0pR3EU+4hz5WKvL0C7QpDWEAyp1tSAV2LrMLUIpDkspXAD6VCFU55kp5fTZh7dGZSXc
         2KR38oAXb1c0tKYGUwOA/JVwDcvGqdWc6qOmNn9N58rOIKqRqy6/ILDXu4bvph5ge/fK
         0RLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730059365; x=1730664165;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HZ8JFZi2Qkm6YYcM8grPf+xKDycxiruU8bzTj89xR0=;
        b=N5KN1h6laiWjqlfi8JmzkZZX9VuMGLPFturnSPi3oVVuCwLOORRvkTiWMKPIQiPrS/
         YWhE73pL0ldlv9Py/dQPR13Ku+ywmdeDsoQklI6vEZTXY/XwxL9vnshqaPzpi6pcsHa6
         SRNzbYj55U6Ns7d25sO278o7Tu6WpBPUfdgveBqJa8XP5QVyHYH0q0lKCSyHDledh2I7
         ZpovT2XDSLNj5T+9XQlU/QxujPmL78HEjcxc5n8jSJehJvkwYqf8uxsXX8H0uIT1/AHz
         +/vg3UGKO7mn1PhWwfh29D1EQ3fjRBhBfUILA0pHvuCBJsoNikpa1rZeDP3ZOqKI0UMF
         aIoA==
X-Forwarded-Encrypted: i=1; AJvYcCXmeKu6lgRffWhH2+oi1vc57psGvc5nmhlmQZPqXcpccE8a27AvTw2FU9w1DpCNJqj3oKlnr/R/E/mgzWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwtf6wpwFwViTeOhAokyX5ERZiZspfeLQriLtEJGffbfkuEnB0
	ZjRQf74R/6QLj36w2etvvK40+2+9nMbxwEz29c9g5G8v4kIQUhg8EJK9rQm5T1Q=
X-Google-Smtp-Source: AGHT+IFgnBiCHLNXbHaeTelv/smyfonWFdeYQPVBe7DCFjNAD+D14LCW/y5lKgfEzzsZaSmBZVCK6w==
X-Received: by 2002:a5d:6d82:0:b0:375:bb30:6525 with SMTP id ffacd0b85a97d-380610f07a3mr2058258f8f.1.1730059364812;
        Sun, 27 Oct 2024 13:02:44 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70d50sm7526833f8f.76.2024.10.27.13.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 13:02:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Tomasz Figa <tomasz.figa@gmail.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Markuss Broks <markuss.broks@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, 
 Maksym Holovach <nergzd@nergzd723.xyz>
In-Reply-To: <20241026-exynos9810-v3-4-b89de9441ea8@gmail.com>
References: <20241026-exynos9810-v3-0-b89de9441ea8@gmail.com>
 <20241026-exynos9810-v3-4-b89de9441ea8@gmail.com>
Subject: Re: (subset) [PATCH v3 04/10] dt-bindings: pinctrl: samsung: Add
 compatible for exynos9810-wakeup-eint
Message-Id: <173005936184.12757.5255123384293459280.b4-ty@linaro.org>
Date: Sun, 27 Oct 2024 21:02:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 26 Oct 2024 23:32:35 +0300, Markuss Broks wrote:
> Add the compatible for Samsung Exynos9810 pinctrl eint block
> to the schema. It is compatible with Exynos850 EINT controller,
> and doesn't have a dedicated IRQ line.
> 
> 

Applied, thanks!

[04/10] dt-bindings: pinctrl: samsung: Add compatible for exynos9810-wakeup-eint
        https://git.kernel.org/pinctrl/samsung/c/e830431e0ad0501c2e6dcb3c65dabc053e3ce5e4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


