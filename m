Return-Path: <linux-kernel+bounces-237360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D9B91EFAB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CBC11F23841
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 07:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D82212E1E0;
	Tue,  2 Jul 2024 07:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Os8lLpZj"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E94D3EA69
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 07:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719903739; cv=none; b=YLUY11YT9VM2TxkjDxh/ojwbg4mM8k3VvcJrh9jnFfOsOr+4jSi6JiapDMCt76Oj2oAXmr3PKyO0VrmKd/CH+hyh/qMqNu1ExPK87tLHjweK2AsxbYo1eJSjvHe7zKy8wXWDFeNgDNgEQja+SpbXvxkTHZATfW3QoFCn9WRukGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719903739; c=relaxed/simple;
	bh=brjrtb/254RYuidh0bC755K6Gqmo9N5E80a03kEGDPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AX46pD4japc++pWGgx8VGVSUISOLXlohajN3GWm07b57QKtPEe/Y3Iy47yWxaiy5Wq/jL4uxxrrfS9lO3a5dUqbT9WcaRSDOdxiBv0l+nrdh5omLgnEBP0WS+YjaHIudY20kNk6F16nMcUE+lSaG3zjbj6nQtXNKZbHBfSoKkz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Os8lLpZj; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d106e69a2so1648269a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 00:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719903736; x=1720508536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=moeg6p2Cr0TRpJk6nyYDG3v7JZXYvVo7+RJpJIy+brg=;
        b=Os8lLpZjSCHNHftunp9MTLA2cb+4Hiz27NgmdO2k2xAmMYq0wWwaIwCIdBue3YXh5d
         ev20S8UsXjj670044mh6ikQlK8o8e/qcO+en7ZZHNczWadZL8/jWFYiuQA7+6CIUTLDB
         E98SocqqseQExNkhFcGtEpWy5o0gZgbOavGHnVw/lV1aJ+dVWXRmATzA/bZ4NyGJO1Y3
         3VSWW2WhMm3Cyp34QdKPFeBVv0OLii17ZFyEBHmdCnMJU+kQKiH+02bQIYs+WFbbhoE7
         6YVQICtSJ/bS41OWU8d69Pe5K86ea4o+R5tQf/9R9HBnQEV/BLllZ6RCAdnQqPqy9cZk
         cTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719903736; x=1720508536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moeg6p2Cr0TRpJk6nyYDG3v7JZXYvVo7+RJpJIy+brg=;
        b=A1BaAml/rofFCVNavM+dGTqZpF1r8dFBLddbbpGmNCXAMjmJ4aSdbNodwISsoVFvYW
         EI5JNK4jsyHmIGwv5JfOSiyy9BeiyiQA8zOf6NsGOEC7rbR7AObwScdUu/rR4V2qrqAF
         q6lSMAahxJHK2QeZ+vp5s7LuVI6vL/J1z17jlyLrXtGPQ/Iz2NKT+9xB8JlJzmfmXrcS
         H0639BBeDXL6HJCYZZ3PuxXTiowfssVXCXqvuDuATi1voaj+tdHLTenh3Xje+De7kcDk
         37L7uLqhl/ZKcNDSikerOApchQXWqoKmhl/Xu6mQJcd4eQasvvfRndrg5T8ddiVevXLd
         gOmw==
X-Forwarded-Encrypted: i=1; AJvYcCXLA6iIOuIgwFyjX0UtQ3oSO5VN0rOtYo9NYvDr5DmbDPPJ3ymBvLpAqz0w9I3P/a5Me+nkP0pRXNGp7DZAwFjOw3Rr6pZH8OgYm4uA
X-Gm-Message-State: AOJu0Yzofjb+eVOY8nfo5egpfzSkPscBAbeKQafQ/f+Bsa4ZXIZ4iZi/
	zf3YoVzyj9CXXsuB1+VBAiY2l7CloZWB1KRrp5B6A5sO9KxtAE4+oReFdP9CPkU5SAVZkY1c9SI
	K
X-Google-Smtp-Source: AGHT+IEKONPWZ+8D/q/t2TBdiXcUYTaSAFslH9nunnkv5ol2qrFre9FlsF2WrkD/IGowWt1RbI/Xng==
X-Received: by 2002:a05:6402:1d22:b0:57d:40e3:2a71 with SMTP id 4fb4d7f45d1cf-5865bb399c9mr8071259a12.6.1719903735813;
        Tue, 02 Jul 2024 00:02:15 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58b4a97b1f3sm560000a12.18.2024.07.02.00.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 00:02:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	arm@kernel.org,
	soc@kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers for v6.11
Date: Tue,  2 Jul 2024 09:02:12 +0200
Message-ID: <20240702070212.8291-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

If by any chance you can also pick up:
https://lore.kernel.org/all/20240530-fsl-ifc-config-v3-2-1fd2c3d233dd@geanix.com/
https://lore.kernel.org/all/20240530-fsl-ifc-config-v3-3-1fd2c3d233dd@geanix.com/
? I was planning to take them with this pull, but eventually forgot...

Best regards,
Krzysztof


The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.11

for you to fetch changes up to 815cc7715ab183701de42b570a28b4e3d877ef6c:

  dt-bindings: memory: fsl: replace maintainer (2024-06-17 08:07:35 +0200)

----------------------------------------------------------------
Memory controller drivers for v6.11

Make the Freescale IFC driver selectable because it is used now by two
drivers: Freescale NAND and generic NOR flash.  The patches adjusting
defconfig are waiting on the mailing lists to be picked up.

----------------------------------------------------------------
Esben Haabendal (1):
      memory: fsl_ifc: Make FSL_IFC config visible and selectable

Michael Walle (1):
      dt-bindings: memory: fsl: replace maintainer

 Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml | 2 +-
 drivers/memory/Kconfig                                                | 2 +-
 drivers/mtd/nand/raw/Kconfig                                          | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

