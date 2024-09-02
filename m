Return-Path: <linux-kernel+bounces-311505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAF99689F2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C621C2250D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B879321019B;
	Mon,  2 Sep 2024 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHtuGzaO"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5839719F102
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287403; cv=none; b=YzJsXdOLP8JXf3K35dKlhFDDcM8FyqYsrqiEDG+jmtEuQECnYS8acGopZvbZDaZuVRsO5J/ikR3owx7gGNlSDg92w47IsSd7Ojxj81ECF+/GrFFIBZUlzDnJaZMjjQ9E0O6awr4U6Du7uK2uzVrIRXObzIFGoG71BPznHomSifg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287403; c=relaxed/simple;
	bh=+6ZlswKxSjl4naR1G1z7zTdHG9+w6GGhQPiaKUb+7hM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mkmjxY72ymkbLRgzx6IRY/WId8iTyS32k7lKBenRGuEyfUATCraWevFv6wFwSHuf4Y23z1nUOCaiR1TJd7D7SXk8+R62NDHoQdADQs2u54pFEkz4Vlau3K28DrsvvAKLo/gkFdfSP1L8TsRmFkWMg7ZyStD3VS2O5znVdM6/VxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IHtuGzaO; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8682bb5e79so532131666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725287400; x=1725892200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DlwoQ0O0BpF32uzCFgIZvmUbRfzYX9FjPVLwNT/AjMc=;
        b=IHtuGzaO3Q4xPur13rSw7pcJy35fF66V4byr0KOVODSrYwFRCQmPEhrSus9vcKULfr
         vX/OwNlSVVFgX+Bu9VZi/ApDalKL98q1/Yl5PXwrvHXS+DdtoXrGBXmWNBU29SnZMoR8
         PMEpCsE/8zf8uH5Cp/bWldUA/EZsQj/mYXBTxLrcnrSeygHlYaNkiNQDCBdL3sUV87sF
         IOAI51i4ESAgrjnlPanGJYcmFJQFaAwjcqJshAenkPX57eg43Hn/rZ2Oklwbl6fY4I95
         nqoERXEJHT1L9j1Yp8SEibx2vp8axOmmHMVz4kbXFA+wFNCmmYpJ/s/C9jgVPurvK/Du
         7Y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287400; x=1725892200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DlwoQ0O0BpF32uzCFgIZvmUbRfzYX9FjPVLwNT/AjMc=;
        b=kocJS4usrYqPmJUWWmRldvgxpdO01xJO4DLUkDP4+Lklhe8xRkk8kRouT0g0C25ujj
         Nj2RP7OoEs0A+mRvRIit5JLGB6CPXwWQZsX/v8Lr1Om5yapoWhw1Plz0cA1aqjLqoHzH
         OWccCNwYNgd1tf2n8Eac+JgSifIg6qvw8Pdg5yY/LZOTSAeWdhdQNAZEVifzamUsF4lJ
         oERzSZU2KeJdawoOfLrheKO0ZY0rgxL9euxtCfMBxRHZyNr6FNN8sWYAUiV8I7Pc/3CP
         Y4PHqRNjHp7FKyDj8lH/RbWGidXYORRNT0ff+ZDGhQt6qOZlPKLD8ZaN63E1Em0xPdO9
         NAjA==
X-Gm-Message-State: AOJu0YyWmIMWBx/3bDeapkVeT3uC5f1nNRndfVrdnz56gUuXn1N+Yu26
	jpA2BGcK7k7mbgJOLe7XzcQqjjs1sD+yIZ6W1WO1cpjRswAnj/wXG+wlOaKDtzre4lJbta+61/g
	M
X-Google-Smtp-Source: AGHT+IHXuZQ7J6kIMzrQ8Ijj7E7aBr2WYSC2NTnvkX7q01+tfSwS8rIRVEFrffZixMnbp3L1bk2YGA==
X-Received: by 2002:a17:907:3e0f:b0:a7a:a5ae:11b7 with SMTP id a640c23a62f3a-a89faf995b5mr297699666b.49.1725287399547;
        Mon, 02 Sep 2024 07:29:59 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d80fcsm566011666b.181.2024.09.02.07.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:29:58 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/9] nvmem: patches(set 1) for 6.12
Date: Mon,  2 Sep 2024 15:29:43 +0100
Message-Id: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here are few patches in nvmem for 6.12 that includes
- updates to dt-bindings 
- adds i.MX95 provider support.
- u-boot env layout support.
- move to use devm_platform_ioremap_resource_byname

Can you please queue them up for 6.12.

Thanks,
Srini


MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Frank Li (1):
  dt-bindings: nvmem: sfp: add ref to nvmem-deprecated-cells.yaml

Krzysztof Kozlowski (1):
  dt-bindings: nvmem: st,stm32-romem: add missing
    "unevaluatedProperties" on child nodes

Matthew Wilcox (1):
  nvmem: Fix misspelling

Peng Fan (2):
  dt-bindings: nvmem: imx-ocotp: support i.MX95
  nvmem: imx-ocotp-ele: support i.MX95

Rafał Miłecki (3):
  dt-bindings: nvmem: convert U-Boot env to a layout
  nvmem: layouts: add U-Boot env layout
  MAINTAINERS: Update path for U-Boot environment variables YAML

Zhang Zekun (1):
  nvmem: sunplus-ocotp: Use devm_platform_ioremap_resource_byname()
    helper function

 Documentation/ABI/stable/sysfs-bus-nvmem      |   2 +-
 .../bindings/nvmem/fsl,layerscape-sfp.yaml    |   1 +
 .../devicetree/bindings/nvmem/imx-ocotp.yaml  |   3 +-
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |   1 +
 .../nvmem/{ => layouts}/u-boot,env.yaml       |  39 +++-
 .../bindings/nvmem/st,stm32-romem.yaml        |   3 +
 MAINTAINERS                                   |   3 +-
 drivers/nvmem/Kconfig                         |   3 +-
 drivers/nvmem/imx-ocotp-ele.c                 |  32 ++-
 drivers/nvmem/layouts/Kconfig                 |  11 +
 drivers/nvmem/layouts/Makefile                |   1 +
 drivers/nvmem/layouts/u-boot-env.c            | 211 ++++++++++++++++++
 drivers/nvmem/layouts/u-boot-env.h            |  15 ++
 drivers/nvmem/sunplus-ocotp.c                 |   7 +-
 drivers/nvmem/u-boot-env.c                    | 165 +-------------
 15 files changed, 316 insertions(+), 181 deletions(-)
 rename Documentation/devicetree/bindings/nvmem/{ => layouts}/u-boot,env.yaml (75%)
 create mode 100644 drivers/nvmem/layouts/u-boot-env.c
 create mode 100644 drivers/nvmem/layouts/u-boot-env.h

-- 
2.25.1


