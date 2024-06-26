Return-Path: <linux-kernel+bounces-230198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A099179BA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8061F249EF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261B515A4AF;
	Wed, 26 Jun 2024 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZtpRRaFf"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A0B13A879
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387065; cv=none; b=lySjw3ZpZcQJp9OiXF1CQ7vL8o7JehFWpOUk3/UMuoAbLv6MqpLZrnRpe6G2C/9L9BuG1LQ2WAoDUNpycMGbS+YrW13pg3N5pZ00EUCoW8uZeHcTmy5aymAUc7ewnBOco5zDOFoWxvGAJiSOdTUltx0CevzJZn8iBpoIjy0KBRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387065; c=relaxed/simple;
	bh=ohq5Z9TLleNSD1GmaVnLIAOighvbVZgOycmmlvM4mBY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZALDH10tRqM3tCzJFfUUaM6EUFc1M6KHX5nC/YunwPsTXPWhV+KJPvk4o1du2duwjcqzBAqlrZ0iE7W4tMo3fY6/WpKip5zacdR9N4Hafx5jsJaODK/q/SUWtzuyPN5pjQ4c5SzLFZ0sOr51bTmlgKO/j4oJs9gx33G4fLTXMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZtpRRaFf; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-36226e98370so3826540f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719387060; x=1719991860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv9djtWEOzxTaL6lh9T+uBzCSiUjvyz1rjw0jY3cUB8=;
        b=ZtpRRaFfsSbD68BjRfTwaVCWwq7V5G+QpKnwSW4WnCEWe/wKKeBKmgfTRz2qh+tE18
         W5VYGzWK1K9UkPp4SjpJmYxAwHS7xhZnKAwErCrOrPArG1HzKqYnbGgjiRcoqKCfPgj5
         WyB0qSLMin9ZkgEuNwSE75cnFb2KqIiwewSQP6OA5uzXjOKLOfmiM04nrlVq2/6Xskka
         I+DVk6h1VprrFViZt7fBSIqECoaeoui42YbvrlxqfDq8+bTInnA8veSwk1GrsTIyYjOG
         xTQzo3JsCvIXHwBVlvsnG0yFM1hlbAWd2I1wJ+ixsnBMY+AYI8dUwKk48aWX47rDj1Py
         jdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719387060; x=1719991860;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tv9djtWEOzxTaL6lh9T+uBzCSiUjvyz1rjw0jY3cUB8=;
        b=suzOGHTkX1Uf5kaNg2xRk0E2961glZ4rg1OAuY1P1jqaNIAyiLMoPhGy2J7mszL35Y
         /eO0RC0PwkCGM8pQ2QWFjvYiYOXa5Z7CBBJQp3UCm6rggLjcGFnEBABZZoUPXIrfVBKn
         muA+G3QxtY8SmyVHgvR6KknREqKfseztCIYn6XtAFVWfakjNXRrC610KnIowdL58KH+N
         hbMs7jSFoVVdop7XbnliPK8/BVTqh5yzcmRKPjTVz9mabkZtvNOMcm6p9nU59w78aEoy
         Xlbp3lQu/zdjTRfhaXC2Xt2Nej0N0tJ5QIfWQ40SPBZeGnoYFnAK0f0ANILbaDYhny8P
         5E+A==
X-Forwarded-Encrypted: i=1; AJvYcCXj+IW320qCcH0Xbl5BHmTnfuHGHuTTA/m7WAPlqS4ZXlpH32YA29dlozACAc0AmN3ulmno1EwwTrioM8EHp6XgdzIC59ZfBGjYk9oH
X-Gm-Message-State: AOJu0YyFRX6UqdBzhilChPGD1vcrpq+hQvInZVB0ANTqA2m7Zvrtx66b
	O3hBdLFzQLtChQEFGulFFd8EH3PJUSn1v1VjLl0T7f6YcfsjGN9b+Cv5/BVxWBw=
X-Google-Smtp-Source: AGHT+IFBXULLdxfeEky/0MesQJ9m6VVrSGMEmCaQc90xJfwO02ZaFbxqLfpmYopxto8Z2nDrU6fdNQ==
X-Received: by 2002:a5d:44c8:0:b0:362:4dc7:dc7b with SMTP id ffacd0b85a97d-366e965298amr5956254f8f.58.1719387059782;
        Wed, 26 Jun 2024 00:30:59 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f6769sm15081665f8f.5.2024.06.26.00.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 00:30:59 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org
In-Reply-To: <20240625145017.1003346-1-jbrunet@baylibre.com>
References: <20240625145017.1003346-1-jbrunet@baylibre.com>
Subject: Re: (subset) [PATCH 0/2] arm64: dts: amlogic: add power domain to
 hdmitx
Message-Id: <171938705880.1642577.605500417615578025.b4-ty@linaro.org>
Date: Wed, 26 Jun 2024 09:30:58 +0200
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

On Tue, 25 Jun 2024 16:50:13 +0200, Jerome Brunet wrote:
> This patchset add the bindings for the power domain of the HDMI Tx
> on Amlogic SoC.
> 
> This is a 1st step in cleaning HDMI Tx and its direct usage of HHI
> register space. Eventually, this will help remove component usage from
> the Amlogic display drivers.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: meson-dw-hdmi: add missing power-domain
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/c19f15b1e056a1ab896d54909f75febf70d98be6

-- 
Neil


