Return-Path: <linux-kernel+bounces-181798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4E38C8171
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32B78B2177A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 07:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDDA182CC;
	Fri, 17 May 2024 07:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pl1KoZsg"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FF117C79
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715930976; cv=none; b=GgmsL/vAPTW+DERLS7UQCm0Ix2MzjT3N2NLkQZDXgqdEcdcWwC+SoCnOuOJBcaGYJN+CS2lbnXnRGaRuAdOXk76DXNvTMynTuzsLS5YLHOrtE5SI3AOqd46AqI9GrXGs00uSOFUdh+rKi1m4xS/lwyb/qCQVUxaqnsTsYGqim5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715930976; c=relaxed/simple;
	bh=UcK41LfV0WFz13Opfd9Stg8GaUSswyyK2wLkPPk/LuM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DPCS+V35xSd/3x033xupCGXBQV+QlhkF3l51hoT8uALBacJPv9K+w3pqK5aG2SmMil1s8OSE2bpBIRN8Hk0tsUuOb+RS8LoNndsQGsLCUyKEScCWWd8TQRAUVwJOyK1kdnetFP6NGl+XgM1tJ1UiMCULHNs7yK7fVk7RnVUwb+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pl1KoZsg; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51f2ebbd8a7so2052006e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 00:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715930973; x=1716535773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imQAT6qjO1VyC/YpAVCntCAOLNh9l2hiqOqHZIoiwR4=;
        b=Pl1KoZsgvvc2dOeB/vUVc8Pqt2z137zrcRz4hd6T+5X3B4jL/+Ovb5MX/8zI9GS/78
         HBCWXLK5oPIo3aFgvtPPm2dboFuBq3qNTi5FbaS2PYRb/qD1Ys9RI5sJ5lkuDBJdPdDZ
         79WwOK4hVXZ8xJzDzTzl15OXQppzH+zsFlne+O+OGCTW2+Dx68jNeQIJ0UQFioAq7v8r
         mBwj8frNTPKgpMbYNm+CQoKKdd4DL7xQL5pRD5WyyEOjmb7IkTOw6u/S/hTjM5tIQuWZ
         Jkk8Xph1EBafL1eHLiQI54eyethIOVy6Ti6XOd6c/eINvDpPbRQ3b5iSBWER6+h5PJ7n
         zOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715930973; x=1716535773;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imQAT6qjO1VyC/YpAVCntCAOLNh9l2hiqOqHZIoiwR4=;
        b=XXai6B3TntUBcKwwhiJeeJfdhC2pscdIwRjhBXgkEyuCIJhq1oYn4RBTcj0Q/vRR0b
         i+P5VFZ7KKz1Smbe0yevDFYS1+oBro+3LbdxrVaxFBWp0xgwAmFNtMq5L+zJm+nKW9rv
         X2ZPMz8I4DId/PD+L/EZ0q2SZqG+UY/3hru5sy83MQLO1CVW0PsBiy2ve4Elu3hjHncg
         Xfhs7uQ3bhDJUYGxFTzdkLf/4dXMZ0uBNJiK90aeS36takt9XiSOAM3oiCGC+N/T8WZ+
         oHiu/Za2WS2A2HtZNaXeFjcKoyHSiTNHsG6RU9wED2dzAxeaZTDO1kjcm8ID0ke5+HEQ
         pvvg==
X-Forwarded-Encrypted: i=1; AJvYcCVTCIaOLcQK2O04R3gGmntJsqRmvgReCLDXk5pAZO7pUq3qgNX0E0+oBaCfVniJoYu9kxSvI2PFlclvpO8V/GXP7LyOvLGwg8wZvMWo
X-Gm-Message-State: AOJu0YwyxFGmgrnzbS/0MYdGNVChYTjhX7qfNHwlBbNdrGtieHUcpBas
	bhJZT8NFGAUhn/C3FDcICkbHwZEWBkM9QBMcSctRygohLs7qzULrjox5h8su0Tg=
X-Google-Smtp-Source: AGHT+IFyQ5ay96Dby18r95inH3bMvJiGqJAHZgvPjwtCGLk0VqOAEXXOxTRWJUnG0hL9xFNx69TaoQ==
X-Received: by 2002:ac2:5331:0:b0:523:96ad:51a8 with SMTP id 2adb3069b0e04-52396ad5348mr4580667e87.7.1715930973181;
        Fri, 17 May 2024 00:29:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502e5e0b0esm20746461f8f.26.2024.05.17.00.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 00:29:32 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: sam@ravnborg.org, daniel@ffwll.ch, dianders@chromium.org, 
 linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
 robh+dt@kernel.org, conor+dt@kernel.org, airlied@gmail.com, 
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 xuxinxiong@huaqin.corp-partner.google.com
In-Reply-To: <20240516072039.1287065-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240516072039.1287065-1-yangcong5@huaqin.corp-partner.google.com>
Subject: Re: [PATCH v8 0/6] Break out as separate driver and add BOE
 nv110wum-l60 IVO t109nw41 MIPI-DSI panel
Message-Id: <171593097231.261191.14625926975541986060.b4-ty@linaro.org>
Date: Fri, 17 May 2024 09:29:32 +0200
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

On Thu, 16 May 2024 15:20:33 +0800, Cong Yang wrote:
> Discussion with Doug and Linus in V1, we need a
> separate driver to enable the hx83102 controller.
> 
> So this series this series mainly Break out as separate driver
> for Starry-himax83102-j02 panels from boe tv101wum driver.
> 
> Then add BOE nv110wum-l60 and IVO t109nw41 in himax-hx83102 driver.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/6] dt-bindings: display: panel: Add himax hx83102 panel bindings
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/eba54e9c4483b585f6e2b9dd2472eb110417331b
[2/6] drm/panel: himax-hx83102: Break out as separate driver
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/0ef94554dc40fbdb7e57ff90cd1e7fa71e1e89fd
[3/6] dt-bindings: display: panel: Add compatible for BOE nv110wum-l60
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/4fd07f679bebc432c72fc2c5cea23e39098e00c2
[4/6] drm/panel: himax-hx83102: Support for BOE nv110wum-l60 MIPI-DSI panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/1173db117634b42383cf5d397ddfd4d4860ae20b
[5/6] dt-bindings: display: panel: Add compatible for IVO t109nw41
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/4020c15c0fcac8d66818dceae7f39736cf9f16b0
[6/6] drm/panel: himax-hx83102: Support for IVO t109nw41 MIPI-DSI panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/3179338750d83877bbc491493032bdf192266ad9

-- 
Neil


