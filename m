Return-Path: <linux-kernel+bounces-247669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0987F92D2CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97275B2651B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B7D192B83;
	Wed, 10 Jul 2024 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d56iI1PX"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5373D192B8F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618200; cv=none; b=V8H1iVpRaIYyOShpoCzJm65u/AYebD7Oa8njcGdpmshVvVvlwdv9tOroY3Epj6BMWAbOF7O+n0zeaJ7zzMLCdtpWnQEruiVtsSu3tNMYZf3Lz7meXRo4PS3/W1Xc55GtHOKB9rGfgageYoZ6lSNMz6mXans7hQmzZa92KVGDlJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618200; c=relaxed/simple;
	bh=IGZDEaWyCwAa3u7RjvzRimnYIXIX4fHQIBThRXlSSLs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QqoFWjEzR9PZuDebifWZhUJGZQ8W+ZytSatVQgecpV0ahReWxD+zDmn5pNkBQao0G2pfUU165K+iBQ4YkKg0/APMqo5zHDebbkGMbJiqWw26JHsu/9bzyjwLNQVlYUvg4k3zhdVLhof1HYfNeE6omFAQffubtF7SQq02L5vuMkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d56iI1PX; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52caebc6137so4661107e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720618197; x=1721222997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60aav+xK4jpl7xG8YPKnbprg8tIY6Nqk/IZH7bl4w4w=;
        b=d56iI1PXKTwQdF2N6PtnK5BnF9MX8HZgC0AGsfIAT6RSrsAnZGkYCHgZJ/JdMsOsOS
         WvpHUb0UaLswWIy8MMOSKHDOsnl8aO0ahfpoOP0zqPmi4Ch2zadu1GDoL1hAIXLn9qbL
         VqyZjsX71C2YdyfQ1MM3MoFlmBtckPT/9VUxxE8MIXS6aypqF4veQMuCDiKYzzBb7JwP
         +9/fjBWOU4u9Bcqa4+/KL4qp4agHbtVa6glqLB0E8Bc1WV4GWGimHV2AF8y+A5F3Aekr
         LL6fzCOekvS6ii87TKi4uV2XZIr8x81jvhBwjce5p+g0IiwkJZyAh7+7nz0GcZTOlD8Z
         8UiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720618197; x=1721222997;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60aav+xK4jpl7xG8YPKnbprg8tIY6Nqk/IZH7bl4w4w=;
        b=i3pmzd2IZlvahvhQoNMPJ0oEKvhxHQn6iXkOBcfM8MMs31Cp0K6k/94SA8dAIjubEE
         tYUrAFYjc3TnmSjzeJ93+eGQWPAsalQAj8IFq3lX6T3MqNfbQDoVMbzSw5+5Tb74ge3d
         0iRPi3oTHOdhrykjmuf29HXpJdOHy4kMYCnx1mA4oK3cHq1anX+KSSwh0ZvW7Ycp1Acf
         DHiLF+GRcmPS0Eksou7+weAJW0PW2kSYuBznHWUNTA0qwgwPBOrlfmZGc2fooLbiRdxZ
         CdZ8tK56+ByOqwddgQT1j0mbb649zT9V8Zahcym4G7pV+bta9cINXGA42HweOQ35kKkW
         2erQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8jzvyn4PxGyP9/C8Iuxz1mWH5thkERnbUgZgeDIEa+46li19DKhBHpZZFuybuGTcd7mX/FHvDjHUILivdX2vaVfnvdFv3+KUOc2Cm
X-Gm-Message-State: AOJu0Yy5GK1K682lFbebx2o6KvuCNva36SS68vkY05UTja/4Om/maaTr
	l3Npi1j1Cu6HkOqSC/sLrv8nxjq68+mIfaFhzZO4QQ1Gqc9vzuuDvsmvrH29hbE=
X-Google-Smtp-Source: AGHT+IHBHuYCCPwlgq5edN/L9l0kJT3pRxlv0eRV0p1+UE+pPGfeFREyn6CNWYa3giyYGhc2Ub/T0Q==
X-Received: by 2002:a05:6512:1285:b0:52c:818c:13b8 with SMTP id 2adb3069b0e04-52eb998fc87mr3918196e87.4.1720618196964;
        Wed, 10 Jul 2024 06:29:56 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e07fsm5304369f8f.17.2024.07.10.06.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 06:29:56 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 airlied@gmail.com, mripard@kernel.org, dianders@google.com, 
 hsinyi@google.com, awarnecke002@hotmail.com, quic_jesszhan@quicinc.com, 
 dmitry.baryshkov@linaro.org, 
 Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240709134754.28013-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240709134754.28013-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: Re: [PATCH v6 0/5] Support Starry er88577 MIPI-DSI panel
Message-Id: <172061819595.1968965.12553404194809762882.b4-ty@linaro.org>
Date: Wed, 10 Jul 2024 15:29:55 +0200
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

On Tue, 09 Jul 2024 21:47:49 +0800, Zhaoxiong Lv wrote:
> The Starry is a 10.1" WXGA TFT LCD panel. Because Starry-er88577
> and boe-th101mb31ig002 have very similar inti_code, after
> discussing with Dmitry Baryshkov, We will modify it based on the
> panel-boe-th101mb31ig002-28a.c driver instead of using a separate
> driver.
> 
> Changes between V6 and V5:
> - PATCH 1/5: Corrected the use of "->init" in struct panel_desc, and modify indentation
> - PATCH 2/5: No changes.
> - PATCH 3/5: No changes.
> - PATCH 4/5: Modify the commit information and "reset gpio" binding.
> - PATCH 5/5: Add two lines of init_code (D1 and D3) to modify the internal resistance of the mipi channel.
> - Link to v5: https://lore.kernel.org/all/20240704072958.27876-1-lvzhaoxiong@huaqin.corp-partner.google.com/
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/5] drm/panel: boe-th101mb31ig002 : Make it compatible with other panel.
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/24179ff9a2e4524ce83014b8827a73ad03a25c13
[2/5] drm/panel: boe-th101mb31ig002: switch to devm_gpiod_get_optional() for reset_gpio
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/7f58ebaccb67cb22b2936ba79c844f1e446dc73b
[3/5] drm/panel: boe-th101mb31ig002: use wrapped MIPI DCS functions
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a16b680a2140e6cbda41ac144564696c3ee2815f
[4/5] dt-bindings: display: panel: Add compatible for starry-er88577
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/3808a15e3248820c0859d9b8a0f2c7e5c8259044
[5/5] drm/panel: boe-th101mb31ig002: Support for starry-er88577 MIPI-DSI panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/e4bd1db1c1f771983393bf5574854dff26ca7532

-- 
Neil


