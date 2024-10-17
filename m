Return-Path: <linux-kernel+bounces-369418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A499A1D13
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1338C1F23D7A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0711C2447;
	Thu, 17 Oct 2024 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uB2Bl6RC"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5104414E2FD
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729153330; cv=none; b=BqrJ/xuQTh5KPFhqn0vDMqQcZ3BhU4k5pKU36AQzhxzKbFmXlh/N9hF1fZcExVv7I45ZqlKb0yFP0RPNehjnB/FEBSAGPh3YlWwupCuFx/AUUr1RhaQwg0dfX0e3kTOQHn8htHLYKuLuPAXoLgRvmKvVD+exeYI6U0g3u/Q3mhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729153330; c=relaxed/simple;
	bh=DmBxfQyFN+fiNm0iNQX13SLFWIudRU6BYTK/xRZkNhU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I0H4pmPrBE80JlT52ju5K8+eOXyZYBH/naLIZX9pWLR7PR5J7X4/8t4D6GWsO4gd9QG/ozFUQH3DmDAOixYeIkOTgV9AnsA4AhcskP7yLClyaibTfyOR7hJB5Akbh3Pb77opSqtJb85/YtneegySBP+ZKUkWmVmsR+ghicGBjEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uB2Bl6RC; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d6756659eso411091f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729153326; x=1729758126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+o161Gg5qEIBbD/Irkt8zZ7lwsNP+yatDJyy3MG9Sw=;
        b=uB2Bl6RCTMu6jmQS6Vo3vs7bDcnKof7nTm/7TM7C5S0HUQLs4AHGFgt5mXE+WNB64M
         zwdjWzHDm5UzSXA0woDjUX3X1donEN5Oi5+YjNehe0rb1eTVp+KjK9SfJCLXfqGRTT8x
         7WiWlcBcHtF2nC/3Ip+d28lnsW7JQvphLgaSkWWNV+8NfglPUgsZMDgzb83l48+pYI1S
         Cj5pmKLWATkD0BouEBA5oV7ct+VLTvyBl88P6RJHiV/4Q/V/zOFKDbz2mx2b2XJhi9X6
         3Owous6DhLZdlQCXBbvM66xyWpCjUhFuK/VCF0hihRS6PcwtqpClv9+I9JbmmaghXj8I
         qvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729153326; x=1729758126;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+o161Gg5qEIBbD/Irkt8zZ7lwsNP+yatDJyy3MG9Sw=;
        b=cHkjdfUoBWifQjEU8wPz97przyOiSqmycSQVonhU4SmZFVN7cIQQ40U7mJ+6cPDonF
         mARBkna2e8WDhTpZWEoIGjC3ylimgIamVCceD7GxH2QhXBFrOY0+DzEgG+rRREVdpif+
         4RgPE/TOfnDtom7ucwRBzoFrfW+vfinHclI4e5XDyT8Epyb10aJP1eo6jg4helvd85w3
         4D2mFUA7A80hk6kSAsOXdOYxRcuzPOdBSKcTJsSADB3YHVpWwVyRKVxYTa1H6byXxz/T
         WX3gY2ZO7E0AIdmHuQUlucoxJKu3DuTGAoOpywWqyhedCkml5r9k2x88Y8hmObRVv+W9
         YaZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAgBpdPnr1CYFcziOoWny7TdPIpeK8k5PuozgHD6rtzBeN8raQBw8K3H0nKkpWEX1QdzNJQl5rgg77zN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM4hVXvGi+SjlsjKURRxsfHdcrtQ6IPJUBseHA9DEC5aPj9Hmn
	froZ1bfCPLuicE51rBwyv7ZTW4do3hKS5VFhhqAjax38SI+e6iPWn0UuuvN/CMo=
X-Google-Smtp-Source: AGHT+IHtsgU6ukQtSJeOkmPtLxn9d1+7JFeyM7WZp79bJmJ9dLCMy+8OJEeHqNpJw8LWr8LrqN9mng==
X-Received: by 2002:a05:6000:118c:b0:37d:2ceb:ef92 with SMTP id ffacd0b85a97d-37d5fedbb12mr12179177f8f.27.1729153326514;
        Thu, 17 Oct 2024 01:22:06 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fbf8567sm6511645f8f.76.2024.10.17.01.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 01:22:06 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241015-topic-amlogic-arm32-upstream-bindings-fixes-pinctrl-dtbs-v1-1-c7291f17063e@linaro.org>
References: <20241015-topic-amlogic-arm32-upstream-bindings-fixes-pinctrl-dtbs-v1-1-c7291f17063e@linaro.org>
Subject: Re: [PATCH] ARM: dts: amlogic: meson8/8b: remove invalid pinctrl
 reg
Message-Id: <172915332568.1203867.12350138706735239328.b4-ty@linaro.org>
Date: Thu, 17 Oct 2024 10:22:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Tue, 15 Oct 2024 14:25:19 +0200, Neil Armstrong wrote:
> The pinctrl aobus/cbus was originally here to configure the
> GPIO interrupt, but it was a bad design and was moved to a
> separate gpio_intc node because the GPIO interrupt is actually
> separate from the pinctrl/gpio registers.
> 
> Drop this reg entry, and fix all the register offsets with a
> proper range property.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.13/arm-dt)

[1/1] ARM: dts: amlogic: meson8/8b: remove invalid pinctrl reg
      https://git.kernel.org/amlogic/c/2b901e9ef05d84e99582607e85393a6eba0e2363

These changes has been applied on the intermediate git tree [1].

The v6.13/arm-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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


