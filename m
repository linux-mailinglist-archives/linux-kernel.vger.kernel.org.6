Return-Path: <linux-kernel+bounces-310855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2063B96820F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 954C9B225F4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E9E187329;
	Mon,  2 Sep 2024 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HMMw1CeK"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1A716EB76
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266074; cv=none; b=m20//khmRfh3uG7ehZQdIsmOcRDP4Vd8pkvYg0RW3Ip9y6REBAroUdb6SKXhJVBduZEzo5qCqWavr+8Ipy5i7w0zw0VWTnya9IQJDnq9Ybl9TN5ZqidRv0sUXHrXCA14n/Z8hSQP6d7c/E2gRSI304U7RwNJS0kF55N7t5oydoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266074; c=relaxed/simple;
	bh=MnDoeT7vCt952wLfteYkGvY6GHFHpBb0+PURR7QujnE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qC6Y+eTMoSWRq1J4ORa5R9pryXX2CqB9GZNxZT4BWTN3WcHm5lUgrGrL0X0uQC20mso8JZ11Xt6rcJtTkWCdVs+Dee/TGUaDrWR3Mlqa6k24zM/JthAgcVU67h0IyVn+tNuzOdEf6LfBHIRf/tmdXmhCVxwxcRut5lBrclpAAtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HMMw1CeK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42bb81e795bso31959065e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725266071; x=1725870871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTtz4aJ6WOg0pDCld3WKbgJIlmwIlok5mPiJNkSVlqI=;
        b=HMMw1CeKvRNBJJm1dlqbzXmZGOlsOk3Ba9wM6hGO+MSDYJDTEGM2TTBM8adUpSC083
         53212+AaO8wcMDgP4/XSHpumemJraFlJsf46xeBL3D8/cPbJfEV8E/7f7O1MHZJtEwjt
         rr1/kG3dSKqCHd/CbfO1lJhjJfCiXtQxnTj+1ZuMR5OmRjotgQNDhw9RqgXR+Vkek3er
         1fZIUy4ViG1Iw723xsZ9xQMF2cImDlelkX56XhzVoXIY2bvhZxiB7XSZ1EHAjp2XrIaH
         +2bA2qXyiND3Mqsr6fyd/t/JNUM0CoR0/FJhspzvlKPi5uwoxUJABHTUG9O+mlZpevmP
         jcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725266071; x=1725870871;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTtz4aJ6WOg0pDCld3WKbgJIlmwIlok5mPiJNkSVlqI=;
        b=ppOr9SDEXheEVOrsb276Tx1JnK2uovOi1GcYj2rvG+++ZpGmKT2TaynsRKGf1HpcRz
         qQ71n3qBFlUiqD51qc7UO1/LvlqAxnaNp8Y/KzzdEjXLIhbeuTp5anXTVGLSHxIJ2MBj
         lJFZo94IAIJKVqhar7XGSADAmjD4XvUMK+SRPXZ9bwLtfRZ0roc6h6aUIiq+KG2WCQlh
         LC3vx09Jd/pguaqzWlTPcFpEvYxRb1wxRtta//rTlxUFKnljrnRWAn5N48nXEKnR5MmO
         8J2v4XqkYq20MQK3mOVCXZzQjZNXI9u5VGmccVVXY6sGlnlABVjOwY0FXyCyrzJAFk81
         qjTg==
X-Forwarded-Encrypted: i=1; AJvYcCXpUCxnabmIEzXrE8m9cvwlKa7FLdo0iuEhNn2RIYQZO00b3oEQBOxspEa1xbURjcWKD/upzc98ZAieIWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+98eCq1EgZJqT3rJj72s18ZECPx8FP7OYKkYistt+u/s5sZYm
	Tm+tETc5gBtIPfGI7SG+XoyQRZaShhomYaRMj9vVg2o7j8VzUO8v36EqtepOQiI=
X-Google-Smtp-Source: AGHT+IEW/pesy5OKJ0IGSRRTNmo3lQ2HG8HktgHM07V8Q3+5V8e1ooBtP7Edf8e8UGZ5iZ6agRXHgQ==
X-Received: by 2002:adf:f4cb:0:b0:374:c03e:22d4 with SMTP id ffacd0b85a97d-374c03e253cmr3159185f8f.1.1725266070437;
        Mon, 02 Sep 2024 01:34:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374bfbfc7b7sm5807456f8f.88.2024.09.02.01.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 01:34:30 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
In-Reply-To: <20240828-topic-amlogic-upstream-bindings-fixes-audio-snd-card-v2-0-58159abf0779@linaro.org>
References: <20240828-topic-amlogic-upstream-bindings-fixes-audio-snd-card-v2-0-58159abf0779@linaro.org>
Subject: Re: (subset) [PATCH v2 0/3] ASoC: dt-bindings:
 amlogic-sound-cards: document clocks property
Message-Id: <172526606951.2176850.4026983419764013991.b4-ty@linaro.org>
Date: Mon, 02 Sep 2024 10:34:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

Hi,

On Wed, 28 Aug 2024 15:53:53 +0200, Neil Armstrong wrote:
> Following an off-list discution with Jerome about fixing the following
> DTBs check errors:
>     sound: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
>         from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-sound-card.yaml#
>     sound: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
>         from schema $id: http://devicetree.org/schemas/sound/amlogic,gx-sound-card.yaml#
>     sound: 'anyOf' conditional failed, one must be fixed:
>         'clocks' is a required property
>         '#clock-cells' is a required property
>         from schema $id: http://devicetree.org/schemas/clock/clock.yaml#
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.12/arm64-dt)

[3/3] arm64: dts: amlogic: add clock and clock-names to sound cards
      https://git.kernel.org/amlogic/c/9b5d25117985e51faf61a808c4b3e15432d55f85

These changes has been applied on the intermediate git tree [1].

The v6.12/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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


