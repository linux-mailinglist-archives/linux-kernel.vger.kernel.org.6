Return-Path: <linux-kernel+bounces-516548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A22CA373DE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 12:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADEB4188CE5E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 11:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D69C18DB33;
	Sun, 16 Feb 2025 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oq2Y+Ggp"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E16C18C903
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739703589; cv=none; b=Zdjgj/5Mg1oUZBkX3B2GgqZ/UM2mnAT3sLN3lwBEiKc8zysH1l6xpUrf7xH49h+e4Qc1dZ2xcjnOF4BjsLtnwKqCM3/ZkQpXuZHbWz49rHELRLoI8FpB8JMWArzccZBW9sFl4KFyzNRxOhQoD4GNAPAIRez0wEbL91ew4WVjp40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739703589; c=relaxed/simple;
	bh=LrTPNkbzHbVWVKeLoyuVqqR2fLoUWxZ3lfDMYLwSTAo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ONZ7psz930kDC4BPgZ63BiVlG2bimDMjfE1TGQ177znKgJdWv4HbwMAhqTq7v1ZyZhZRqR/ZzBpC/zwNH4MJstUzGcUA4vtN5dYRTYG+eJioIxJ7nA8gsu9HOamZm7p4Sil1VkcPMBjK2hGfljz6THRqovli3zCrNp7Wak3IiKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Oq2Y+Ggp; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7d8953b48so60060466b.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 02:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739703586; x=1740308386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1AyJU2SefZmjgW51aej4VtriM7oYS4pHdsrSQl/DNw=;
        b=Oq2Y+GgpHCdm3y5cQkdOnI3q9d9KO+crbDaDVOUTz9zrlu3u00Q+cr+p9HnTcLnwnA
         7KXzMmegIrvpWvCX2gphAuAbSV/2AyEIbKl/rPWJhixp11WlkGrvs+oxjo2e9cm2UEFH
         AWCJnAJoeI8qxhFxZt3ioX5JCjpo3hdAjCi9MXp3TiPb6WP7nB5HA5fXe6OKkmnU83sT
         D5tEahy+BWTDBLnXogkoULx0FP/0nsWDWq4HNc90ltgnOeHj34b0AmfE6awjUp34usoI
         i4qGZVnakqnUVmqoCcojLryKLlft7g+9qzSfryTTMquX/iv/eYgvl6f3v4Yasdo1DKXu
         9jwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739703586; x=1740308386;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1AyJU2SefZmjgW51aej4VtriM7oYS4pHdsrSQl/DNw=;
        b=jdlycaig7dnwJLh/v4azAxS2vxtFZNX618ve7FSJSFYvzZjWc8c/636C0R71/Qes/P
         O+yIw/gVRK6HdZjWGhLXaMZ5TB63y6g6p2M6WAvUxgM4OpiIaFEMtWOdRL5ycagszWE8
         Et05V7GlUlHUqc6UbTlSQLvCh0reJQ2kN4XhMtyYFjpeyGtrLmUEmy0U1uaXR6px0Eze
         wgbDmRWIerlhyrZyjJKCwXslT+804MP3ksWSPmxHEpNyCMiDWX9SLrkPfGIgWAcS/d7f
         ma/JAfGSihAXo44GO2vUMBiVjRFeNNHD3EF7VQO3EzUVKrBSd4dE/3oTrTdn1/nf//E9
         TOxg==
X-Gm-Message-State: AOJu0YwqlO53MEAAfRSYtKVpfykiR0EaEitdr4sqc7vwocXfopbU5ii1
	+1ZN647/hGocQbW5KfsMJ97fSpHdYefxO8XMsApQc6s7oNXugksi9cBQDC9bzZE=
X-Gm-Gg: ASbGncvU7/AqIBaPAwapgHPVyjsfYzrh1D9QkDkWo6QkOx/bTaTSZbP7oqu6tbnAJ7N
	O/dshAfJ1sGKjElbJMqfCwdbgMVsRf1pTc5hdcwgwFv/Rj640ipGUyKcJ/q70M79qPtVmz7WX+f
	Jy0+NNWFRkBpMgpdGqSSXBHGlw0xYjyYnoBJWV7bVEF9oVyMLkZIflKoZ4yrvQZMznKyLUvKMqH
	kf9N1LoqKmIe1PAxW5VpKLqQGhpnUpkOxM65shesiSzUNn24H3tYmCnYo0wgwd1x/cteaJ0cHez
	jmYMwDxwKp5zfSCXTNvRpa4KHtVbEZ4=
X-Google-Smtp-Source: AGHT+IFefTV39A1neLhgECtLBQWnWdC3L7ZVJ1cd5nkHx/8W7pKyxsOQB1ZeilaYCi+pwtC4N7wgZg==
X-Received: by 2002:a17:907:d8b:b0:aa6:6792:8bce with SMTP id a640c23a62f3a-abb709319d6mr218337366b.3.1739703585852;
        Sun, 16 Feb 2025 02:59:45 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb6f13b11esm310849266b.71.2025.02.16.02.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 02:59:45 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
 peter.griffin@linaro.org, daniel.lezcano@linaro.org, 
 vincent.guittot@linaro.org, ulf.hansson@linaro.org, arnd@arndb.de
In-Reply-To: <20250213-gs101-acpm-v9-0-8b0281b93c8b@linaro.org>
References: <20250213-gs101-acpm-v9-0-8b0281b93c8b@linaro.org>
Subject: Re: [PATCH v9 0/3] firmware: add Exynos ACPM protocol driver
Message-Id: <173970358411.40124.822612928338453939.b4-ty@linaro.org>
Date: Sun, 16 Feb 2025 11:59:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 13 Feb 2025 13:05:13 +0000, Tudor Ambarus wrote:
> Alive Clock and Power Manager (ACPM) Message Protocol is defined for
> the purpose of communication between the ACPM firmware and masters
> (AP, AOC, ...). ACPM firmware operates on the Active Power Management
> (APM) module that handles overall power activities.
> 
> This protocol driver provides the interface for all the client drivers
> making use of the features offered by the APM. Add ACPM protocol support.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: firmware: add google,gs101-acpm-ipc
      https://git.kernel.org/krzk/linux/c/97b9ee2972bc0060cfb4d456118699942a6847ff
[2/3] firmware: add Exynos ACPM protocol driver
      https://git.kernel.org/krzk/linux/c/a88927b534ba18019b0440cf3d7f068407b5250c
[3/3] MAINTAINERS: add entry for the Samsung Exynos ACPM mailbox protocol
      https://git.kernel.org/krzk/linux/c/8e9faeb642511ac90b8b4f6a136ca1046958a1d2

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


