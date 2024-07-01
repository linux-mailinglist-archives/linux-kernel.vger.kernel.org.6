Return-Path: <linux-kernel+bounces-236240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A60B91DF3D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312CD282354
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9126914E2C1;
	Mon,  1 Jul 2024 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivgC0FqG"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4510F14D431
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836888; cv=none; b=AEirQLY/WdtrpZP4J/xYlnGqhSopKwsrtzBR/4u3qPHYpPL5Zzgybl3XrlgBDN+xgrY4ExpOQJk82IRjFugZhCBe40ATagDsPlye7SO54AKu6ttqNhetXH10Y7I7cjlfXKHsdI8ZKi7/yts+bjh08+ArHDviriqKvLC/dR1fzlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836888; c=relaxed/simple;
	bh=wddqOgP5X6Nd0uGbWi8PVMBIffCdslQXYU9lQCWuL9I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tkcPjJlA74jjNL3oEqjECPBrwC84JX5px0jEmq5kLfhlc3CdY/7yAkSh1i9mmaccVEezUNYkFdRB/dO1rjoGBF6h1IvCR7DlZAvFfq0swy1K0p7qOispgKg/HTt/fWJQkcFogpPdyn2nC+RorxXlRzucv6jnsUJKV0eh5s+SLVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ivgC0FqG; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3672aec418cso1602700f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 05:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719836886; x=1720441686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwZDlMy7YMEN79I98JoEsPlJGk4fswatitIH/0EpuGs=;
        b=ivgC0FqGk2ayXWGncjCRoKJa4vT2mOG0ydmT+5I8FbSv6XzOGVw9Wle+zMzQZ5CM8I
         lNg2AoV/Fj1o9vl00dEByTOPIFNol4TQL/p330sTZ+orLk96Qe2rdEurfeqFcPAW+L4f
         +/rhhvu1qoEA59EPXKWjTx7Gz1l+Yk2dZltZknUhWbUgBh8GptXMJWEUl/D/aFj5xUWO
         oK3qEl16l1ZqynRp13Du2Vc7BK7o7BEFUfKSEnu9BAnA6Av3w9XrN4/R96omGWaEsHJS
         u3SmG1IXBPJznJexqOuQqd581Bn142DnfBBlcRT0dKDpd/+gNbF/Y7Yjl/hlV6TF23V3
         qP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719836886; x=1720441686;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwZDlMy7YMEN79I98JoEsPlJGk4fswatitIH/0EpuGs=;
        b=BZLNH3jMLxE4uSQzrf9DH0t8bsyV86FEsZCum6sqwTEQu699pZHq5H/WE4SQCuZEv6
         lpUB/CrZ4kPgX85XET4wOUBF6o/f0WGIWcVPfVokgoHj+8/YwDxZlO6t0O4nbzyDJ3sJ
         XxBZ0p187VolM548vmOCNWxOfr0P4zU52g7XFAiR2T34KAbwrTrb3q9ZI3sD0Mu231o2
         1fOuVyWOQRqAc8rniAIneBw5Ka7noB0/kv/fFN21JRZAYQdJS+E4ZB0eskyBx2W5Pp0h
         uGrO0c8y9DHPV1e/gAfXAswt7aBfsqS9+1W7KyjQS8rD+9tMv6UOd/Xj4c2CQNElTpU4
         wduw==
X-Forwarded-Encrypted: i=1; AJvYcCWUsJwUFrWR36AFIOSRL1+RgV99/ozbISfrfuXW9hII3lErw0wLJFEV2N+LgE2z5f0C3deADTv9OA+MAj14PiC9dEwEuL+9GdfYl7eL
X-Gm-Message-State: AOJu0YzK2hWH1by/j+dfKoHIpAmLYkUF31K0oNvumTU3d33otLffRtoO
	JFu3P13Ng+eeU7/suK0V1C6tdUoWrGl034VYAprfL12zGrFg0uqVBugTz6PYxV4=
X-Google-Smtp-Source: AGHT+IGqEZmEE90TYNOiPCo7w0bcsxoYscQUTNwMQKXhPLvoptUJufWQICqaND9lUfNV8NxH7ole8A==
X-Received: by 2002:adf:ec0b:0:b0:360:7829:bb93 with SMTP id ffacd0b85a97d-367756a826dmr2911042f8f.21.1719836885666;
        Mon, 01 Jul 2024 05:28:05 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd5fcsm9860697f8f.11.2024.07.01.05.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 05:28:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 alim.akhtar@samsung.com, s.nawrocki@samsung.com, cw00.choi@samsung.com, 
 mturquette@baylibre.com, sboyd@kernel.org, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, tudor.ambarus@linaro.org, 
 andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org
In-Reply-To: <20240628223506.1237523-4-peter.griffin@linaro.org>
References: <20240628223506.1237523-1-peter.griffin@linaro.org>
 <20240628223506.1237523-4-peter.griffin@linaro.org>
Subject: Re: (subset) [PATCH v2 2/3] soc: samsung: exynos-pmu: add support
 for PMU_ALIVE non atomic registers
Message-Id: <171983688356.414803.3620253719378845523.b4-ty@linaro.org>
Date: Mon, 01 Jul 2024 14:28:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Fri, 28 Jun 2024 23:35:05 +0100, Peter Griffin wrote:
> Not all registers in PMU_ALIVE block support atomic set/clear operations.
> GS101_SYSIP_DAT0 and GS101_SYSTEM_CONFIGURATION registers are two regs
> where attempting atomic access fails.
> 
> As documentation on exactly which registers support atomic operations is
> not forthcoming. We default to atomic access, unless the register is
> explicitly added to the tensor_is_atomic() function. Update the comment
> to reflect this as well.
> 
> [...]

Applied, thanks!

[2/3] soc: samsung: exynos-pmu: add support for PMU_ALIVE non atomic registers
      https://git.kernel.org/krzk/linux/c/85863cee8ce0c3f4d0010e78feb664fb26c35e95

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


