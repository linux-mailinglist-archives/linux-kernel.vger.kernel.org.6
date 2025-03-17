Return-Path: <linux-kernel+bounces-563557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ECFA64418
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A4BE7A23E7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE9218C33B;
	Mon, 17 Mar 2025 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S94YBgtX"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20512664C6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742197529; cv=none; b=DDmcZYu4YvKuOURZyDQFKolXgleU1SUBZyRNnQ//o21C1vqgGO483U4675tbhVN6GzoXDpZXMI5oBnwhUGZQyirErCpCHtqmsfBumBGVXQRJ8qBwu/VaBOLacqPIjIobRCn4YJ8Yv/yoAhrM6wMSRZnlS2r9/99chcXqmij0hpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742197529; c=relaxed/simple;
	bh=FndBGzuNT8Gm1jDepbhawwofxANfeqR0ZG/3Vxl00nU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=od68Oq5gzkcTBW+Fa/wkes2Zsm//cVcu1+GoQqpKZk+0cYR6sKCkCO/9kY6fRLBOQIjp2k14d6X/MT+ocByXBKG2E4CrM/QQzKTZpTInaBkwRPXQlKneeEpGe6BAizWKFN/KXg19rPNqGu+S9aGeh9ioS7Hkq2DsoOJ04SbZKPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S94YBgtX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so2354912f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 00:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742197526; x=1742802326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vk8FOGphjAtBrbDVk0JfE+k0FaInbVBLe1YsUYKxuMQ=;
        b=S94YBgtXsi3LfWcB3tTpIEchZGOHAH2o7T3LpYee/ZNEJrldHVJ2ff5ZXrffs0ug1Z
         EMaAcwJyOwPwMkGX/g2kG57Zkn/XSYsczSQU5D1JM7tdqrsicL+Pu5j21ip879zMcOUa
         gLc66E9PVkbFGH/gImJ4OeRlxIcIHO2dsve+hLGBf87WS0MtYA/cb6WuYVVU3FhM2noh
         LtX0JQAQF54E4SErKF9Kxq9HgF0QpuwwSvjmj3aO0C9JDieuuKmqgwX0OmfE+/BhBphH
         n1TM7aioDLQGWE11YEEabiFsRNBV1f5xM3tuhRtdVds1nhlJ926I486Ocyy+RfWo6SzI
         3CgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742197526; x=1742802326;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vk8FOGphjAtBrbDVk0JfE+k0FaInbVBLe1YsUYKxuMQ=;
        b=G2JUp36EOF/YTS5ATdbnT0+iuBThZtWDWblGzS2cvAxv7l1lYm+nq7b0c0CHF92sKY
         PdBpaR2kLyXxkl7iMUV+/Z8neXWrzht6Omou3BjI1RUuoWAPbycOfmQVD5F5KxFFuHEI
         EYCOeN2J99opVUjWWBW8U5LIyNAfdjTdyNtIzhotd6e5/Oh17fx5tjZBCeHQTa9pBtDU
         x+IS2pKel9sW0GQbWjCK9BFFqHDDk3rnKghhjYb9ePU7UZ8PdAmsdI3PTrlVK4Dy+16K
         fMo/mkoNr5FDIkMbrLoblZGjk6fPuydp9J0HP2WLbDOoUyQRB1gtHXWUQisbY/M7q7nX
         GEyQ==
X-Gm-Message-State: AOJu0YxDi3XTwcqFVNL7l6SMDMX9iO7Uc42BpdL1PP+6bPBzSBfWV/I/
	+Rh2LFVjb+GvZknTomPSzo6IPWgywkaSt7pwXinOeLQjJEQ1ksozHnZJ/jPQat4=
X-Gm-Gg: ASbGnctG1VuF3jXYU1uO/c+WBGS30Y9fIZLwF83stT6M2GZYN6JJ7KmMvxS6iY+QAan
	8Ib2WLrVUXawanUeCyP8gAGylHWdkJ3INDIRroHHxIrdZ/WLZe9m4i4FimvcICExpH/+dUXsZRc
	zSLyLcPtwLGjhd/GE/TZDFyBerIVlHMF/hvfc4WVy1c1bdsziVN6ONjrIK2llnmiLs4CRdWUXHs
	6dcgM4KDtn4RtGEh6+LXOePacXqKjxPDzemkBbPySaP4mQZZmAotOnDQ18f6rnhcm+7qLYyIgS3
	NNazALvOACPtWFg5dMXFgbZINFr6MjN7zXZDKKQc8lXSibEWI94wCMAuxvksA/TwHg==
X-Google-Smtp-Source: AGHT+IG6OwIB09eeL1gfs5VuJzC5+gQBxu1FXFMWxkoy1MNMXoRRCuRseYNCRtOrnhIHeZxIA4bArA==
X-Received: by 2002:a5d:598d:0:b0:391:3988:1c7c with SMTP id ffacd0b85a97d-3971ddd6086mr12870277f8f.24.1742197526437;
        Mon, 17 Mar 2025 00:45:26 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df33aasm13884756f8f.2.2025.03.17.00.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 00:45:26 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20250311-irqchip-gpio-a4-a5-v5-0-ca4cc276c18c@amlogic.com>
References: <20250311-irqchip-gpio-a4-a5-v5-0-ca4cc276c18c@amlogic.com>
Subject: Re: (subset) [PATCH v5 0/4] Add GPIO interrupt support for Amlogic
 A4 and A5 SoCs
Message-Id: <174219752573.3092000.16919170480596322661.b4-ty@linaro.org>
Date: Mon, 17 Mar 2025 08:45:25 +0100
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

On Tue, 11 Mar 2025 11:08:26 +0800, Xianwei Zhao wrote:
> This patch adds GPIO interrupt support for Amlogic A4 and A5 SoCs
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.15/arm64-dt)

[3/4] arm64: dts: Add gpio_intc node for Amlogic A4 SoCs
      https://git.kernel.org/amlogic/c/31c6bc1948b5a0a0d7679cf948351156608ec148
[4/4] arm64: dts: Add gpio_intc node for Amlogic A5 SoCs
      https://git.kernel.org/amlogic/c/454e0353b226a47f3c3369b17c7a4893f74e29cd

These changes has been applied on the intermediate git tree [1].

The v6.15/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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


