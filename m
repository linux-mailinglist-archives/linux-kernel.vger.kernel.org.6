Return-Path: <linux-kernel+bounces-295413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B7B959A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918EB1F219FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4051B2509;
	Wed, 21 Aug 2024 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ttied4kT"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3F41A4AC0
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239742; cv=none; b=U7zmQRK6gtuy087Hg0ajJ7j/ADrbNcg/p5IEjfPt9R2d4YBDAJn8XvT4rDrXUn0ZKAFMqKnkuFAWUBo1Y+dAfGUcECBDpskWytrLx3cU3SQrsK0Z3Qz9EBwI3pGCGr25upLcJV4XcSmPwaf5NEp6oQbVhPFvY/P+FnWuozpLX8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239742; c=relaxed/simple;
	bh=M0Ooxo685v1POc7S1dTi/xgY7XnRXJDx1Ns73h4LP4A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fR5baWHtNL7xulnzNyb42ZZQPki6wvAo5p+/P1BaYdZu/2blqV5ar8rGSJBghb3FZ+HmNE2A34avzW/tSre485+Tb1In/nBWKd/4FhVBL19uYBHAJq1B5UZl/Q/vek4vQdu/U+9A96tdvACoCOZcrvqk+vMnCaBkPNY1uV8A26A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ttied4kT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4281e715904so9134625e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 04:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724239738; x=1724844538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2U98PhHfsQe7q0eoibYZl509/CH1f8+DFvvWpqdj0Cg=;
        b=Ttied4kT1+lfu/pbXW2WlALfx6LV1sZxy96Ei1ukPpSUXEaWyBAq/2oWLRBz4qj1rx
         mBb9uUiQWMid7rTeCJljTvdNWzxmNasgQsZCaZCOcnfKdBm8R007hNSuacD1c2pt8XkS
         q94dYBYrOHHQ82fSbvmvouUAMC2sBa1MkrYAyq1sRTdm5rPgXms2KsiG3D+Zd1vHKUjs
         1YlcLlFIjYnOzZJIVhBF+SQBHEl/ESSpAidq/2cPPbK+rsrqhpGORhJoc/5VxU55Y1FZ
         SKV78G5jueEci5fc8ExB4d6ECKnOwNNWRGhpfjwsH78cpk7P7uc7Bt/U5+rKQry/nK8d
         9miA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724239738; x=1724844538;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2U98PhHfsQe7q0eoibYZl509/CH1f8+DFvvWpqdj0Cg=;
        b=WlewvMyzlmyA7EKdP/5aJl+ACOdbnAjqAdetIobOrZN367/WWtjUMbnZ5jT1Sno4ph
         kN8U7JvU2jzalnLV7Vf5kwdoVRFsceG5N77jUuxSkOPSTzqLhabsgh6pWn+gjLRX26CO
         OspE+qvA/HGM01xNTZvw4VrXL8GawxDJWrcQe5/0UTvhcISdiMu1fisU/sAzkHUnZGyS
         4zRdSpy5wCGymIFyfRVSAeVgZNU2TAdrvelDtwOkql5aUVybytFDXy1oYh24VLkidInF
         /R5mbxdAz5wxRscHHtHRaM17FSsxC1mQ8Dq3GTRUVzw30xtbTpRsNL1ujt7/OeScfJBn
         h8Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ4AlePcdJbNgTOKQB7OMadiEARO3+rMfzHAUY1OpJJENogle/9JFg19sABI+aZy+GRajUeMnNJf9Tnp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWYnHsnu0O8G/lsj0d5o7ug4rNW8pzozxsxn4i8XzhlWp9BUp5
	0kzNPT6Qm55GSgAH1v00khH6sxPIkTBLH5G4MuXTKhfKC9blzd0ggI0u9Ffuvpw=
X-Google-Smtp-Source: AGHT+IEIuQbc89lIhEz/EoJLwbR+11BG8ia7GTtZCJ5M/PeGK9/JE2t6rDDT3qG5CyMk8VcRiLyGDg==
X-Received: by 2002:a05:6000:154d:b0:362:4aac:8697 with SMTP id ffacd0b85a97d-372fd4d1195mr817938f8f.0.1724239738366;
        Wed, 21 Aug 2024 04:28:58 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897926sm15446926f8f.87.2024.08.21.04.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:28:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, David Virag <virag.david003@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240816175034.769628-1-virag.david003@gmail.com>
References: <20240816175034.769628-1-virag.david003@gmail.com>
Subject: Re: [PATCH v3 0/2] Add USB clocks to Exynos7885
Message-Id: <172423973629.252925.10167794996873239462.b4-ty@linaro.org>
Date: Wed, 21 Aug 2024 13:28:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Fri, 16 Aug 2024 19:50:30 +0200, David Virag wrote:
> This set of patches adds the clocks necessary for USB on the Exynos7885
> SoC.
> 
> Earlier versions of the set also contained some fixes for issues with
> the existing driver/bindings, which have been applied now.
> 
> Changes in v2:
> - Split from full patchset.
> - Added Cc-stable tags and fixes tag to update CLKS_NR_FSYS patch
> - Blank line fixes
> 
> [...]

Applied, thanks!

[1/2] clk: samsung: clk-pll: Add support for pll_1418x
      https://git.kernel.org/krzk/linux/c/4e39e5b84361924006f4d7cf81e049a2793079a6
[2/2] clk: samsung: exynos7885: Add USB related clocks to CMU_FSYS
      https://git.kernel.org/krzk/linux/c/011a9de99793c3a2ee612ff3e0ce293dcbea6df0

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


