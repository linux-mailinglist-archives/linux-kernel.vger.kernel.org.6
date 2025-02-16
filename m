Return-Path: <linux-kernel+bounces-516549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C5BA373DC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 12:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66EEC16EC77
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 11:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26CC18F2EA;
	Sun, 16 Feb 2025 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BoKTQZBD"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9267D18DB29
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739703591; cv=none; b=BF7kvi3ftyJkqh09M/qwFY7FWhsEoU7UXD3m1RBQamg9Rq2n+Bg8LdDYk3ytOfGFonx8sqgSqLaw60+PrmHxfxxc5bJGIJfw8gZoQ77I4Gc30Nkoffz8JxqHOf0avQGM7mLVWkNg/5yeqlye4z6FjDis2VPbXtZW+M8+THUClMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739703591; c=relaxed/simple;
	bh=Tplj+Tt8O0+ujUEM8C8Kdrv030eW3cyPPKhRugB/xgI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qqB2J4/kK25x/R3xs8bRhjdgoPg+6D6ddI/PyS2PwBnlxQtb5C+sSPOXlkdVRIGkq8LS6l2tloLoQJGQYQrmo4zmRUls/rphS204ccMNfdjOUocOYId02WIgJlWL/lxrjvUrZR+PW+r5z5XVRiVIppV6dCMLLpocCRjeciOpuUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BoKTQZBD; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abb4944fa73so22090866b.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 02:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739703588; x=1740308388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+isfF1av2MEN7dZuPePQNIg6D59LIEPS+5Xwxezxio=;
        b=BoKTQZBDP9UYQHGw7Mg8MdqRHEMUzhRChpjsKd8P4wOKmaoAgrXD4naVB0/xEvcL4n
         35oih7HNBJGUe7RHLcwdc58tl5QXFH3Pa0VCy3IIDyfJSBcqRw0tc+L2i5QoTCAr3Zgq
         iHQbQaAxaeXowXMh9Bgu/RR3wSIB3CSr0YH8PswEJK8FrJ8Bmu0Ber7jxOpHssxWxCeB
         2TsPXSSyswLjknZFJMPspWCg4LcZd8OjOJAHR2O79HccP2ubVSAxaKgPG46nkG/eWpdO
         JLge8CzJch4zV0zFuurzccPZFo1KW59wdyb/TEfROZJj3EH1yykfGubq+xyZlOiAcm8R
         QBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739703588; x=1740308388;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+isfF1av2MEN7dZuPePQNIg6D59LIEPS+5Xwxezxio=;
        b=WCTztnWCl/PvuA+Zl5jKjE0QzKacZnNX+NNngf6JqfSJLGpz/qhVhf5M1d9z74wui3
         9YR0g58mIkakUi8P4Ga9mE0vJYldwSPV36wAfD2piG0DTD9FZMT+y3y/Zei2pO63ywpN
         dQgw1qB4pSjPk6AnJ/571egVEughyTt5OseiXUnvLsvG6/0V5ABw1TNut4vgPUUoWVvy
         7LRNPFwaBF6lCKc4ciG/iWdmlv/EotB4N+Ldmz8i0CiVlj3MiQO/mSkYkbqYRHqxRzvl
         2LlR4x/BLpZh4d+qRXuLQci6chxwe8V5hax3U9Y65IVsb0+3d2Tx/KpWvUKLAkoSNi1k
         tYJA==
X-Forwarded-Encrypted: i=1; AJvYcCVYCwZFe2DDTwXdmtV8GlS2aW4nLv0cwy7jYkWgIMPCQ01r8SMFd/eIm/kwvqQVbcg9T0S+NuxSAXoWOP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx10co5sUMI5+k17f2314/77UjqBjATee5mWGsd1LexWS9Rzf62
	/xdj8Fpbwy007bOTpvZuoHYFa7sXzJekpRp+8MYN4bdD61eO/IqTLhScp/++Wjg=
X-Gm-Gg: ASbGnct+ok50UYKqclkXEw074P2BBktQHYr+XeUV9Cie6ZH/qmrgZQcdFTujIATigvY
	0aIiygRtR4CWN+WsfQGK33zggXrMBi7xUV+C8K7rBwmFz92kBDLIdcL0qWDE5WI45FkiAMWSS24
	rtk5VZGCK6h3MjT78o0+r0Y+0DWD4/A5ot1hUxEOPZGRe/yM01ROHZyz+sl/OKf3PP1+380Z1kY
	ymgXmfED3WsTE0mIwMHxSqU2c27vBE0Lr7QawoMo/PiQLHd7/3girCvrRF/DBZHQzseHikKoP3a
	DsEB4GD7C+fiykyNfG3KYL6mEYXCjWg=
X-Google-Smtp-Source: AGHT+IFXNLvXjNtIwPOLaCkCItusmH2cRIwO8DowYwkSiG5W1dJqPaqeLLtJQtE9GmDO3bjyfv9zLQ==
X-Received: by 2002:a17:907:d8b:b0:aa6:6792:8bce with SMTP id a640c23a62f3a-abb709319d6mr218340366b.3.1739703587756;
        Sun, 16 Feb 2025 02:59:47 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb6f13b11esm310849266b.71.2025.02.16.02.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 02:59:47 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
 peter.griffin@linaro.org, daniel.lezcano@linaro.org, 
 vincent.guittot@linaro.org, ulf.hansson@linaro.org, arnd@arndb.de, 
 Jassi Brar <jassisinghbrar@gmail.com>
In-Reply-To: <20250207-gs101-acpm-dt-v4-0-230ba8663a2d@linaro.org>
References: <20250207-gs101-acpm-dt-v4-0-230ba8663a2d@linaro.org>
Subject: Re: [PATCH v4 0/4] arm64: exynos: gs101: add ACPM related nodes
Message-Id: <173970358595.40124.3478053371340167838.b4-ty@linaro.org>
Date: Sun, 16 Feb 2025 11:59:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 07 Feb 2025 15:56:42 +0000, Tudor Ambarus wrote:
> Define SRAM, mailbox and ACPM protocol in device tree.
> Enable the mailbox and ACPM protocol in defconfig.
> 
> Bindings for google,gs101-acpm-ipc are proposed at:
> Link: https://lore.kernel.org/linux-samsung-soc/20250207-gs101-acpm-v7-0-ffd7b2fb15ae@linaro.org/T/#mb557ee342de628b1a8e462d4fb7c3ac6eb8be4e4
> 
> Changes in v4:
> - rebase on top of v6.14-rc1.
> - describe in the cover letter where are the ACPM bindings.
> - Link to v3: https://lore.kernel.org/r/20241220-gs101-acpm-dt-v3-0-642d64daa5d1@linaro.org
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: exynos: gs101: add SRAM node
      https://git.kernel.org/krzk/linux/c/48e7821b2690428a40d16567b2fd3784591f36b3
[2/4] arm64: dts: exynos: gs101: add AP to APM mailbox node
      https://git.kernel.org/krzk/linux/c/23159ccf60026f9c510bcc422f75b2a74af79f20
[3/4] arm64: dts: exynos: gs101: add ACPM protocol node
      https://git.kernel.org/krzk/linux/c/f64fdd3c592dfb45d9c2be4b2506230467ebd27a
[4/4] arm64: defconfig: enable ACPM protocol and Exynos mailbox
      https://git.kernel.org/krzk/linux/c/8ba2c48394d4f9291d2fa3e108bbb192ac0e5f32

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


