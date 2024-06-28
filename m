Return-Path: <linux-kernel+bounces-233563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7528F91B98C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8AF1F22700
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98068146586;
	Fri, 28 Jun 2024 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lc+D3vwQ"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2A74436A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719562334; cv=none; b=Y2Mp2xBQRDB6MuFISnXwNtZ/xNCb4SndIB0rJpYXmjisr9teV7pTT7/3/Q7qne2TmexSoR+rd7m8ayWQS0O2pJH0SMSjyUnd2bPGJDEk6LFupvXIlQPvrbT69OPMWM8kw2JgyAYu1PHnufcEsgT3tHcB5iKbILaUCpPohrWSZss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719562334; c=relaxed/simple;
	bh=VfMZ3EyZOT/+Dlgo+TPCcRfEdLOwVwZ6yf9Azc6a5no=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QIOV+mZWKNQQclXc0ZHtlq0Xz8mG0Wnm7gr5WNVMMHqyKzRfeRyNTqGGSWYGWXREC98HweyVpkPd/XnmOtAE468nqmz226Zr4m54WVtfDXKRd820yIEAi7nliRS1bdHcz0ZToZEhiLz4h2tcgo+7F0zXmNjhctqgHW1XClQz2dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lc+D3vwQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4248ff53f04so2744295e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719562331; x=1720167131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Za8GJzSQvEWguBnhsVgMgbxpdx2OWPVe0QVMP4Zex7M=;
        b=Lc+D3vwQEKwwhXXBSCHzQImzDMqy0Fei/UstJEGLOw0wJkUgcQCS6IcrDs77WOv6sh
         E7cXy8JBzF2B3awvqkjuvcrBNpNvcEesPGhoegfEBs24I6VK3JNQz4WNzhoL2XC1Rtqg
         RLmrH/h57bfNAF5f3L34wo4ndM+4BWXd+dAhCGclUAc9V1XeDCAkk7cqYc5monBlyN+D
         j1dOEnpICyzWz/q7p0fnhkBEUR5NSglFYnUKUFFPzJEGafWGgW14L1tXuseOmKh/Ce+I
         JgOjvSP0y/JACynIim6Bi84AlPcKMN897HzTY2ZLeLYbNDd92hLANX7XT63LkKWHJcWt
         7tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719562331; x=1720167131;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Za8GJzSQvEWguBnhsVgMgbxpdx2OWPVe0QVMP4Zex7M=;
        b=vH4F2JpXxMHw3L/y95pRRBwlczm+Op3PQGSikVEGmZc4nYDzxPXj6Whv4XLa/8H2p4
         ygB95yz0OYj+nPlb/VeI2iAksYtOvzeJ3TNO4OEBWwfSLc4Of5A5Ny+mSeh4LiE8x8NR
         8hBT/HTTf4yTcOcW/Yt4Aes4INQ6mxG/hjtcWioUjRnmvI6tvJqZNffY+TY40r5JJ9E0
         Y0Zexwhi3lzd26X0dGRCrFQznAXIcfd9U46nZlAKP5ZpJE6zKKMbXZXJpK2xCRsMbXTN
         z8xbDt+2hnHPBAcJOoCvUibZBn4fwqbbhttPr4SkQovmah8qHpi6Rpoy9bFplS6zDmzT
         viLg==
X-Forwarded-Encrypted: i=1; AJvYcCWgybji0nkJXCrHwC+NgKZ2UqQnvqrEKejHIOyRulJT2bfEXj2BY6yS6Gb5z3xvqtBuq4rR1XOz3JbsVGQpUSohx5fXBI8S79z/5Bt0
X-Gm-Message-State: AOJu0YzQGtsml6t25Jfn05fT/NO1GKQ0WqoYjfLSUBtzOh/ptOze6h2v
	nGNx9C/xcsXn+aL3YTrptV+APamFGFbagnAjGLrgq0cQMqBngRGXM9CFH+1hFSI=
X-Google-Smtp-Source: AGHT+IH1Ga8ve4A/0au2rmwtSixHp2ho56UaJ52/y9SYN40XIU8gYHAdzQXzwMD6SK6QXmXie5tssQ==
X-Received: by 2002:a05:600c:56cc:b0:421:7bed:5274 with SMTP id 5b1f17b1804b1-4248b95d0edmr124015215e9.10.1719562331060;
        Fri, 28 Jun 2024 01:12:11 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256d664052sm12589185e9.27.2024.06.28.01.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 01:12:10 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240626152733.1350376-1-jbrunet@baylibre.com>
References: <20240626152733.1350376-1-jbrunet@baylibre.com>
Subject: Re: [PATCH 0/2] arm64: dts: amlogic: handle hdmi system clock
Message-Id: <171956233006.862799.7789348204436390137.b4-ty@linaro.org>
Date: Fri, 28 Jun 2024 10:12:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Hi,

On Wed, 26 Jun 2024 17:27:29 +0200, Jerome Brunet wrote:
> This patchset adds the setup of the HDMI system clock for HDMI Tx.
> 
> This is another step in cleaning HDMI Tx and its direct usage of HHI
> register space. Eventually, this will help remove component usage from
> the Amlogic display drivers.
> 
> Jerome Brunet (2):
>   arm64: dts: amlogic: gx: correct hdmi clocks
>   arm64: dts: amlogic: setup hdmi system clock
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.11/arm64-dt)

[1/2] arm64: dts: amlogic: gx: correct hdmi clocks
      https://git.kernel.org/amlogic/c/0602ba0dcd0e76067a0b7543e92b2de3fb231073
[2/2] arm64: dts: amlogic: setup hdmi system clock
      https://git.kernel.org/amlogic/c/1443b6ea806dfcdcee6c894784332c9c947ac319

These changes has been applied on the intermediate git tree [1].

The v6.11/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


