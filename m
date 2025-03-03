Return-Path: <linux-kernel+bounces-542480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE8FA4CA09
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B41B1883E4A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3744824FC03;
	Mon,  3 Mar 2025 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0KstmVA"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D4A24FBE7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023065; cv=none; b=l3zEdeaNvYoaOZdViWbalfRE79plZt6smIE8VB1Qk6Rz0/xqxePPdyfaLY0qfT3BLxmXJkHB3zLMmLuYki/dSuxXjOnKnvPY5hDNgPE+1KzFFq9+Wk+AOyROEHFDM3m/q1Uq5n17ESW4DSKa1fe4Q81N+/cppecDXaCYVpbfkLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023065; c=relaxed/simple;
	bh=EwUNeYrjXw4Abxl4Ekempi49OOEBziqDKshlyOT2j2Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=de9EGqg2Tz5Ku8OuV2rwvKk3WQIqDZ3VT5Lw/q4WCNLQgTmIfZOPBdXHP6bAQvVpBgjA52zAgU7jYBgcRGwqHb0+BFXpVGUI07cuKc2jPRzaX8HBFbzhWxZ7YOAE0EFYVR4Pu8N6P2zzkms1l0XzkPu/MvXxMM9aPjO4DMJqy80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G0KstmVA; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaedd529ba1so539654966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 09:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741023062; x=1741627862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tn2H88qy5fJsuv2JITum7avWFZmr0OiLNZ9SxsUWXM=;
        b=G0KstmVAT1uQfwQA2OGbyrUwar2gw8eIrzzaL+AHm7pohGGHI+1kv6IWw7arrPfDXq
         hBfZXvYc6p4O+QOIxs5pGiTMKX7XvUhsRSdN7PRR92yNMzdL8/B2YyiBosgjRwRQTFb/
         mOzokQDIz9670FZzJtz6d8cIL5EFHoAp1kmbS+82DEirEeYb3ZjhSJgD99UwmOlmfiZe
         ELsTiY0Ytp1RXFQNoEmp8M9xKsJ2mu7yHRmgm1glygffkgogdxi1UHhajfoOUb+/ouJ6
         fTP9Qwjivo32xCT91bfHM4pDTW/wtPXmgr2z9CsmZAhZlXtMfCWws61duuTSZgyplc4l
         ec1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741023062; x=1741627862;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tn2H88qy5fJsuv2JITum7avWFZmr0OiLNZ9SxsUWXM=;
        b=FMHvNA8AkLKuxhjBL74TwredVNPYGCcNNr60urOG4sl4f8Xo+G9TRaWzqQmNAWvZP4
         2mhWe9bb8+hF/Sp/yvBJ1N/thNBW/SwA1bHKBZAoUsHO5HGGN0CqDErI5o9q+b4cO+Od
         cLnifuVGOtiPiMRhugG9VGr8RtdTg0cLo7pnGk3u1TfIZJ/Vy5neiGxlryanHwrw/2gj
         Pw3rqvYXzdpZpKHROhX30axyN+YW5wCKa+Y+RAMah2+ENZYzhUh8VRMCGwcWf9tb4hF0
         AzwYBupT7aa2P+zNwHdhBwErrD6qUNzj2xvFuLlmsYkXhyfIXsj40a8ndnrana413JGy
         2Dgg==
X-Forwarded-Encrypted: i=1; AJvYcCVF+6ZAmhua3qTfBtrbzGUCS5HvdRFpB5cTZR2wJnckf1l+gcwuT/SybG/4Ni4L8ooJ8cWz42tZxXtXi1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBnBRM+q8YXN8lS08i8J67uyS/HwXLlJZRFlbv0Zisl+skBEh7
	FO08b8PM7Gm0C68DyMnYnUG0eyQlZCQcpg7+CusSpoREPw4iowYK1Olm9vIxGQY=
X-Gm-Gg: ASbGnctHicf0Jafvqj84vOTl70B/8fT4/+eV5eb0x275jp3/3uUYMucEBiBf4KPEi7h
	qPoj9uPMXhkOnOu9R01uA5q99hq82pu4dXy1113QpGckZXWGqlI/KQCdVUa6ocq0GkB3sPFMGDT
	qiarlzIrfsu+hZcz7sZyqLojSr0bKUlv+ctk983bpDqLc9/9ytjos8yTBI8Exy5dswMs1iH9Z7p
	67552NtKDZ0JpxOiOIRXGEbseWUZe3olXh839El7BiazFHgcHS2lwsGrNhUFA9FF7ZLWoT65Ok8
	W/4Q5JOnlCMKDwQzYyClka5GmUbeRKZ5xruuLuqJ408=
X-Google-Smtp-Source: AGHT+IEDCHbXJFeVr35xZXSASXjjlWalAgEpW0iSBToGQqWlsuonpEUcEGYcVr4M4CEdy1EY0ZamnA==
X-Received: by 2002:a05:6402:42c8:b0:5df:25e8:26d2 with SMTP id 4fb4d7f45d1cf-5e4d6ac58fdmr34237245a12.5.1741023062067;
        Mon, 03 Mar 2025 09:31:02 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6d26esm7085355a12.20.2025.03.03.09.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 09:31:00 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>, 
 Stephen Boyd <sboyd@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Adam Ford <aford173@gmail.com>, 
 Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, 
 linux-clk@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226164513.33822-1-laurentiumihalcea111@gmail.com>
References: <20250226164513.33822-1-laurentiumihalcea111@gmail.com>
Subject: Re: [PATCH v3 0/4] clk: imx8mp: fix parents of AUDIOMIX
 DSP/OCRAM_A
Message-Id: <174102305899.2928950.8837177294161174759.b4-ty@linaro.org>
Date: Mon, 03 Mar 2025 19:30:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-dedf8


On Wed, 26 Feb 2025 11:45:09 -0500, Laurentiu Mihalcea wrote:
> Correct the parent of the AUDIOMIX DSP and OCRAM_A clock gates by setting
> it to AUDIO_AXI_CLK_ROOT, instead of AUDIO_AHB_CLK_ROOT. Additionally, set
> the frequency of AUDIO_AXI_CLK_ROOT to 800MHz instead of the current
> 400MHz.
> 

Applied, thanks!

[1/4] dt-bindings: clock: imx8mp: add axi clock
      commit: 2471a101938b0d1835b1983df08daeb98eef1205
[2/4] clk: clk-imx8mp-audiomix: fix dsp/ocram_a clock parents
      commit: 91be7d27099dedf813b80702e4ca117d1fb38ce6
[3/4] arm64: dts: imx8mp: add AUDIO_AXI_CLK_ROOT to AUDIOMIX block
      (no commit info)
[4/4] arm64: dts: imx8mp: change AUDIO_AXI_CLK_ROOT freq. to 800MHz
      (no commit info)

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


