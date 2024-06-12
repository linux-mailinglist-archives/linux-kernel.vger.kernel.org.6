Return-Path: <linux-kernel+bounces-211423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE182905171
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CCA028659A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53EC16F267;
	Wed, 12 Jun 2024 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ba6lO5eD"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6375A16F0E2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718192152; cv=none; b=X87U4LX4dx9mnIwb95oIuOxscVUywKt1uBHbaULvUE5xnj18jZ6MeyAAYJGN89C/Ao9NvZ2qCl2QgZTDv9Oj6OlOUGYzyDyyuyQIGe3touixciStviJHFSHlc65Lps+OnrpyP+uZzRw5IRGQHNZnbLkRcf0hNNBIq/lvAYBWUqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718192152; c=relaxed/simple;
	bh=8TUNRi0jSnoscHv/HyXuoxqOy7niHVwuVaFISNxIUNQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqwUmO8tHG7UFUpJCggXkrpdrPz3EZVfJfCuGoK77KNhakP+NPyO6WzaqFnJ3BGLhw3tnXQ/FosMQEFx3US2zrDaqnQtr+G74N7AsJev3pxhV+7Q8ejkEovZnD7s2pMQeYuyOgxD3685OcZIq+pkfIHqxTf7zVAlCI0pyjOTR5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ba6lO5eD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso33441065e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718192149; x=1718796949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5W6KNPdx2PHuRGHUQ4zzYKRlb/OTlAEe/zv7YTen1wc=;
        b=Ba6lO5eDraympkvnguk24xJCBHKJaMxlMgcBa2z0qhzivJDmD4S5OBGXPtvRNBvarh
         nQ7ihPr0CYHyEDyxfiSJo8H1vjP3eteISltZWVolANOf5EmNa7HH43Or6yQQukHFgsaR
         o8xZ4o4vk1xnOi+IYOnN+PB/PjulCxhBYWrGYz1vRPn/QcEq9+ymnxdOkDc/cKzOdlTI
         s0YrR0CqrtSLDmY7yeJQSQSqm5ZdUwsmVE0fuYt6uRz6kKcpF+CzmtM5tiEUMCPaS87j
         c99zIEgkdCH6JKjI/0+5jA1c6n2IhJ8Zxl3TynNnHra2abTmXcjgSO513kJTJmdNdedP
         TLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718192149; x=1718796949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5W6KNPdx2PHuRGHUQ4zzYKRlb/OTlAEe/zv7YTen1wc=;
        b=LM113kRDu7SPhgIhisVWgwubWQTghVDZFaCwQGufgvxVufWwa/bWH5W4uY7ciAH81Z
         c74E5OW52nIwzxsKSjIJRrzP1ucEKs4xXR/xzIrtNmCgmqweKuCBa5TNVhOJVHGvrVPV
         /FFBx53/hxN4VHudPgT9gxkFexJAuWfhlKCnmEpY5THdcKuB+TAEAWidc2l1Vym0kaVX
         Bq+o1DDGEhzEaLOyIdP/52xPB7CxFZtKbZ4/aA/VWq2FQIiNxWwFLcXcX7gBRuRewn68
         rX3ume++JgVRQlIGgPEa7v9uV39w+lOdgYNc99jxRWqnRDW8BcFxxfinV7XMFuzscz98
         wbqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0pjfic9+TKW//ox4Nva9Lz/OkD7tW5WPcMg+ZKlguSJLhyICeRosTnHdCpvgc7eQD09mqDPn8LrBlG3rO66OKBpI6q2DJ3g13ewD9
X-Gm-Message-State: AOJu0YzTXijFoWljDR3BTmtSSRu2/y8XXZLZSRr+E1g15YSE8RuWxlH2
	R8PBnEszl/0J0eX8Q6IrtW8mw+3AIfmaE3wZ7eBNiLiVUcFuSiiHXK3F0QDgCAc=
X-Google-Smtp-Source: AGHT+IFY6eOGc1xazKEVxpvuj5uTRY7O7gqMpBLZjRs62uuaT+fX3AHvmERtiOFMNwPjseP/EICqGg==
X-Received: by 2002:a05:600c:a14:b0:421:f4db:6e0 with SMTP id 5b1f17b1804b1-422862b3e59mr16107465e9.5.1718192148774;
        Wed, 12 Jun 2024 04:35:48 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e7060sm22909765e9.40.2024.06.12.04.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 04:35:48 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: dts: cirrus: align panel timings node name with dtschema
Date: Wed, 12 Jun 2024 13:35:44 +0200
Message-ID: <171819214237.104758.18100345249888595536.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240509104825.216696-1-krzysztof.kozlowski@linaro.org>
References: <20240509104825.216696-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 09 May 2024 12:48:25 +0200, Krzysztof Kozlowski wrote:
> DT schema expects panel timings node to follow certain pattern.
> Linux drivers do not care about node name, so this should not have
> effect on Linux.
> 
> 

Applied, thanks!

[1/1] ARM: dts: cirrus: align panel timings node name with dtschema
      https://git.kernel.org/krzk/linux-dt/c/f3ed3b126a3653c7dc21bcf9a22ed2d7a62f83a2

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

