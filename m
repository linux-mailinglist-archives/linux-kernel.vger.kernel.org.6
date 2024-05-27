Return-Path: <linux-kernel+bounces-190748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA4B8D0211
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C1F1C21365
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54BA15EFAF;
	Mon, 27 May 2024 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e9lGSbVd"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCF115ECEC
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817499; cv=none; b=d6sOKzUWHKYCSN/6lYdesQXK0lqYhTq3fXy6vS2DP9nCfEksz1RQs7WHV0v8qQlPz6rJt2V+bxgi0BJMbFFjS8Ph5oBsbWQwwjX5VD7F9rns+Lmy35xUinK6pjoVLioVa4KAWgu4a/mx4kLb80/MXNPeB/DbgUE4iJIwsS3B0To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817499; c=relaxed/simple;
	bh=fwXZJFB4nkMzHi+97DNTbv/zQhYOdEGJXF+z0FAofVA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t9M3CMxwfCqxCL3poQXGcIPocyvf5362hPXLshcBXyeS/s97R0QSI2kwLo17CFUV/GmLIMfulWZ4pv4s8edyQBoecl6hAP1Oj5JF0lddZksUgmlecTgZI8U8TvEjb+nMti12Bdu0H4201gigWWXZBp/w04G7JB3qyTteOqWmPE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e9lGSbVd; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3588cb76276so636073f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716817497; x=1717422297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOPePvII73dyzyHk15m4pOPTJxMdXeXMFiP5kpq9p44=;
        b=e9lGSbVdDpdFXgNm35duyPuVOM/s1buSjbwUS0K5ZobzfaSjZuLM3Hw2899t4KI3MG
         bq3HSGk/Ohwf12avPGDex6UGjcJIcgKb05oaesFmqiWy3EC3a4zPPayUfAGE7KV0ypJy
         e1hPM+laFVLGmnj53y62u4rJCj1XixGIkwjmyOmpja6880dIQUWnpMCFah/YnFQOVgUg
         fiHx7CS2dM8XjFWEGaFGuYGZp6PKfH0i5fUugxS8AhWDATtQCnKJKN3YXJAnGfp5kXAI
         sbt2cBs88sZAdWNRwbLNHVcZjd1rGLPwJ8+z6c21vI0ic78NiN/Aw7VvrWXxMWZO/bGo
         BP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716817497; x=1717422297;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOPePvII73dyzyHk15m4pOPTJxMdXeXMFiP5kpq9p44=;
        b=eH8nUSzBC9+jUfQhdo0/ghC+fPQdfo76b6fnrsCt1EeZLWTLnuHJcWD8G/ZvIKADsZ
         3MhLq8x4VkIqROrTgTwrDu6yv+QYoC4YnOtS+B66TPxx/BgCrX5Gm2hPVJodhGJQMwIl
         Mw/kqs5wyHJm33dIVQb/yfEu7p8QblCBWopp4OGGjRBSvGGKJBZ0zjeFbabdzABY+aMG
         4oAu28oVovcrcHM41ARmHGzL4YAG61LNqXLf5S8GlPcxLxZ33+XjxRzRdb6s+Zs05Eq1
         sjnIrNsSW0VyatoAdqiIh1mXR5jVNhLXyAFNWJ5IqqMrJ3XvmOYD9GuuzU0K3j2AlfKj
         eRFw==
X-Forwarded-Encrypted: i=1; AJvYcCXjs2GF7N/voZtOijws3TaNaQ3OD+DJeEvurstYv+ovG/qMr1scEwVvoJCvU33XgOatM1l5pvJs99q0Gt4MAbwqL45LmeFhfLvEt1Mz
X-Gm-Message-State: AOJu0YxTv/tAo/WS47knUsRVEQnUzLEfUk3kJG695c/q5ZBhMMYfc5xU
	9emtRg9CMEVsfSKkzny28+e1s04tnV4OeEixL1Wo5oh2Qa1kWxG2YiuZNp+mD8s=
X-Google-Smtp-Source: AGHT+IGwS0/nDa3ITAcmca/nsJyVuSykEMrLjJDamCmRirIOzO7crmASNfLCNT5BvQ9XhxFkMcLswA==
X-Received: by 2002:a5d:598a:0:b0:356:4cd7:d3ac with SMTP id ffacd0b85a97d-3564cd7d4eemr7776462f8f.12.1716817496449;
        Mon, 27 May 2024 06:44:56 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a091051sm9114549f8f.61.2024.05.27.06.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 06:44:56 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: jbrunet@baylibre.com, mturquette@baylibre.com, khilman@baylibre.com, 
 martin.blumenstingl@googlemail.com, glaroque@baylibre.com, 
 rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
 lukasz.luba@arm.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: kernel@salutedevices.com, rockosov@gmail.com, 
 linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240328192645.20914-1-ddrokosov@salutedevices.com>
References: <20240328192645.20914-1-ddrokosov@salutedevices.com>
Subject: Re: [PATCH v2 0/3] arm64: dts: amlogic: a1: introduce thermal
 setup
Message-Id: <171681749543.2905422.16742406814394221719.b4-ty@linaro.org>
Date: Mon, 27 May 2024 15:44:55 +0200
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

On Thu, 28 Mar 2024 22:26:34 +0300, Dmitry Rokosov wrote:
> This patch series introduces thermal sensor declaration to the Meson A1
> common dtsi file. It also sets up thermal zones for the AD402 reference
> board. It depends on the series with A1 thermal support at [1].
> 
> Changes v2 since v1 at [2]:
>     - provide Neil RvB for cooling-cells dts patch
>     - purge unnecessary 'amlogic,a1-thermal' fallback
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.11/arm64-dt)

[1/3] arm64: dts: amlogic: a1: add cooling-cells for DVFS feature
      https://git.kernel.org/amlogic/c/947bde9069c8241afe401433a6eff276595bb073
[2/3] arm64: dts: amlogic: a1: introduce cpu temperature sensor
      https://git.kernel.org/amlogic/c/049d141161903e656d9475950bb976240802c01c
[3/3] arm64: dts: amlogic: ad402: setup thermal-zones
      https://git.kernel.org/amlogic/c/593ab951232be4779e77f5b1bee0bef4e6fc1022

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


