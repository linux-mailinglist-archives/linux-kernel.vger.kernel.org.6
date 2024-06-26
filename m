Return-Path: <linux-kernel+bounces-230202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 744659179C7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E22285417
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036F315D5AB;
	Wed, 26 Jun 2024 07:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HkTfHAS9"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B132D158211
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387158; cv=none; b=TfHHE8DoFu3OfgdIIfJkfPGLhG2AlLxp1OU3oUGOPPJ7T+uxSzmjwcf8lsd1R/KswO4ttFqEQ/Wc3M3fRTGJVdt1NDs/NX9YMMaK3MgqZDxq6m4jAzueyEwfzI9yEBKyNP9PmUsJFnJCPNy8qcRnsezgYIPNu3zrhdz5yVDAfZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387158; c=relaxed/simple;
	bh=H3n1860AWJmkkJABeUH25AQfZX7As2YkB3in/1fhWy0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IacVU76W3OUXZWDN1NMCwp4ZzrFM8q1/Yj44KUCJlyf+2Q68f66K6Hob3Uav1lX7qzrC87Q2d83s+V2AEGmina99yTwFuBtGjMAUBmNJkEVK9aitUNVQrEO5cYpxCJM/89bYC8EsivPcOccz3nJqZw2Ml31sgRDod70Hkz3g8/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HkTfHAS9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-35f06861ae6so4893053f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719387155; x=1719991955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7W4OioQKN0eIBHViOR9QZ+vNRz4LIKL+fXoMKffOCkw=;
        b=HkTfHAS970W+fkqjuokvpKOmj6YJ4mwuV8PU1DWJph3r5w0Lu/305tYWnviMD8b4PI
         oq/qSwGjG3tYTDVaNI33ooQr3Qa1qRNDq8K4FxFjZ0+Dgj8oDq7I0J4F0WKsDw0UGz7C
         OcX16WlwT71wz26d5DMEoYb3VdFmA2WjU6FtC3/QGY9JaUmetntOyQDgEtdxVhiGnpbe
         qduoUxdsWRWhp28Q0l25rwtxahfkW8UDeoIjCIfAD7KS74pJKIJQpPX+AjusPc19pxpf
         gf9xsDaiJkuAABX1BANJyxNZlZ4ZP2qtsxabCmixqe5Wp9ZLP+gFshEbWgLIgoA4Yb8J
         TDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719387155; x=1719991955;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7W4OioQKN0eIBHViOR9QZ+vNRz4LIKL+fXoMKffOCkw=;
        b=ret+HMGGe44nbfFxl0i5l+DYcssuK/MW1quNYAFgiuDkfhHeTSVb1giCPHzBqD+I43
         Jej7zRMr8Tp8waWdePpBWeEPw9050c3Wgrwz5a62zjF8GTapKMb9+C5T0cm0+sC5H49H
         kc7JVqHc9nnLhq11hByhn6CAORb9HCXgK+WRoaEz4dZT8mydfo4mEkPk9O669gh6wfvl
         d5UWNZnqer3WTQ3BPeRWVQXMz+dohu2cuuAhHGWNlofpsVmebr3+OPaN7DZbh3LbudPQ
         7TdqtnS7GeorLXZDkxVHh51n+R8tBS6jrZS4gEzbKQdUug0JupGlNgF9kzy1e8KuF/qb
         uL2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWItnjSd8LkBjGvMl2YARqA8OioKZTuF5yyXHr7nu7mz0N1Hjj/Hr9db7xPbAG4EIzzlwhwiU3TFDTX27JJedB7pC0OSx7Q1j+cgpxU
X-Gm-Message-State: AOJu0Yx5HkWG/Vppcm714WXHeew/AFNAjZNH/YYXcy2S+rd8a83AxAkl
	KKNl8Tdrb6TaZiKIgwIVnFFkwfzTOzVQorl1+XHNjTE96pUSWfSWA1lGR6HbD+4=
X-Google-Smtp-Source: AGHT+IHkStzMgEtlbhfEd3vr7XWwRbdJYImOIKudj1b47ahck4Suw5YJPuzNImYmMu5zR3rIDZJ4Eg==
X-Received: by 2002:adf:fc0d:0:b0:355:143:b5f5 with SMTP id ffacd0b85a97d-366e96bf096mr5830496f8f.64.1719387154733;
        Wed, 26 Jun 2024 00:32:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c8f07sm14962150f8f.110.2024.06.26.00.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 00:32:34 -0700 (PDT)
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
Message-Id: <171938715374.1644768.9308792407844880407.b4-ty@linaro.org>
Date: Wed, 26 Jun 2024 09:32:33 +0200
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

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.11/arm64-dt)

[2/2] arm64: dts: amlogic: add power domain to hdmitx
      https://git.kernel.org/amlogic/c/f1ab099d6591a353899a2ee09c89de0fc908e2d2

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


