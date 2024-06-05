Return-Path: <linux-kernel+bounces-202587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92C68FCE49
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0466B28A602
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EE21BBBD2;
	Wed,  5 Jun 2024 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YzOtL8oh"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1CC1BA89A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717590079; cv=none; b=f1R3PJvIlb27e285mmLbD9EWHhVptSQlUtVPUBLisIAdMGWtZLGQC8ovPspwe5cfnlCqhQNvargkD3eKaZNNXyMoYZpazdW9pCHrXtGdM2X6RRrDkOcw9kSCAJFA/8v3UWUFF4pyxhrnTuV+9IhLQqolTzGUpV0cSSFD23yxOVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717590079; c=relaxed/simple;
	bh=ZuXkpQMdBYPnSjpL44UGNK9p02wpao3earR10+aZjbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ev0MOL2bfl4dkc9ryPfj+Gc+K1WTzSfi+ts4z6OtzEgNUZN4nUqjVfgw5R3XiZMWDHLnVf3LT0l5qkGoUNS5rhBcICeUAQrfyM2IdnENybmc5tjtNXuLycEza7de6CD6xeGYLF2wVbibUOWUi5htZEuh6sZOhKgbpI0GqR8BxNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YzOtL8oh; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e6f2534e41so62243011fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 05:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717590076; x=1718194876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G+Nvyhb30jMRTp5MAcBR0DPyo3QQwWDlaTstXDQ5DSE=;
        b=YzOtL8ohU59o5as1AIFitfb6w+U9dD6UIwIj/xhsHVtC41atF0tb/ptgG0yKeLsWif
         kVrN0AMc47QDp/69CjJTZjXMZPv4Y73bAWnhhuSI09q7rgpCEEXrPvfwFG0kUWqi6Y7I
         cy9qMISWyU/BfhcAZq8Uw6D6kktoIEHyL+yeVLo1cQqNo5ilFoMeSE3Rb9iUcB8vndFq
         +gj4eXTBbXm/PHabyx+L96a5uAlgYhdBnFmZyFgs+QdnPRdPBxftDnClvSa7Fz4ghH9v
         kUmexT5zF9+YwRMeFv0T3m0qbbEWDcKS8z7hFuxVyZ6bWcrwO4BDInimdt5M68e/BwAj
         zThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717590076; x=1718194876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+Nvyhb30jMRTp5MAcBR0DPyo3QQwWDlaTstXDQ5DSE=;
        b=Esj9PTIIevoTTFCrFzy89Pr2lBHLFKmIP7O013mxBdDaOZrlFsGLGTLyjlTcYXqeHV
         1nspibSBF9HYQGF8H8NIvW+xX+ufXxTXXPGk5KPEaQmwJ8+WWH7efOwdDtGF2gMmMDCk
         nuV1Md1gSOOYpAmv5EbyLpAn0sOqIKL7+UKoKlUDTupNjYLYFkKGvrMJH+/HiIkWA7rY
         m1EGasg2nOe2FjWyZyhRBNSeMHqYVehp6bHF0OkhGxQwHWvv07JNnqqVOWmyOHRTfagk
         0ZL24j5/3cJSa+eqx9qUqjCi1eOfqJ8tzt+LZURA8LN+A9BNTBCHlAFJczG97QTCJ/jl
         NYqw==
X-Forwarded-Encrypted: i=1; AJvYcCXcy4D1/2wWDDrNsPI8RBn3Fi1OzDJD4/Ou6KqzULBw5DK+20zBKTZefMzJC0t+vOk+rCUtPwOD0qdZMH/H1EUvpKTrpMT4BBKkrYBZ
X-Gm-Message-State: AOJu0Yxz3MrteA7nZF/pagApK+yarJhsM5kMscaEm+feq2+71ZxkMSVu
	DAJABG98nl8urCf9Auv+S8Tqo2p2i+WCOj9i5vfIaluoRDwlhD1qDAqTbmC5rJQ=
X-Google-Smtp-Source: AGHT+IE21RURyt0kYC+Jz489gsL7lhhTmR21aXYTlyuWI/0yvyEIMAOFWs8jF25IHJtn2FVRLjKUsQ==
X-Received: by 2002:a2e:7c0b:0:b0:2ea:772a:ddb4 with SMTP id 38308e7fff4ca-2eac7a526f0mr14280681fa.34.1717590075844;
        Wed, 05 Jun 2024 05:21:15 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:d3dd:423:e1eb:d88b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215813ce64sm19634485e9.44.2024.06.05.05.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 05:21:15 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ath12k@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v9 0/2] dt-bindings: describe the ath1X modules on QCom BT/WLAN chipsets
Date: Wed,  5 Jun 2024 14:21:03 +0200
Message-ID: <20240605122106.23818-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Here are the two dt-binding patches from the power-sequencing series
targeting the wireless subsystem. To keep the cover-letter short, I
won't repeat all the details, they can be found in the cover-letter for
v8. Please consider picking them up into your tree, they were reviewed
by Krzysztof earlier.

Changelog:

Since v8:
- split out the wireless bindings into their own series
- Link to v8: https://lore.kernel.org/r/20240528-pwrseq-v8-0-d354d52b763c@linaro.org

Since v7:
- added DTS changes for sm8650-hdk
- added circular dependency detection for pwrseq units
- fixed a KASAN reported use-after-free error in remove path
- improve Kconfig descriptions
- fix typos in bindings and Kconfig
- fixed issues reported by smatch
- fix the unbind path in PCI pwrctl
- lots of minor improvements to the pwrseq core

Since v6:
- kernel doc fixes
- drop myself from the DT bindings maintainers list for ath12k
- wait until the PCI bridge device is fully added before creating the
  PCI pwrctl platform devices for its sub-nodes, otherwise we may see
  sysfs and procfs attribute failures (due to duplication, we're
  basically trying to probe the same device twice at the same time)
- I kept the regulators for QCA6390's ath11k as required as they only
  apply to this specific Qualcomm package

Since v5:
- unify the approach to modelling the WCN WLAN/BT chips by always exposing
  the PMU node on the device tree and making the WLAN and BT nodes become
  consumers of its power outputs; this includes a major rework of the DT
  sources, bindings and driver code; there's no more a separate PCI
  pwrctl driver for WCN7850, instead its power-up sequence was moved
  into the pwrseq driver common for all WCN chips
- don't set load_uA from new regulator consumers
- fix reported kerneldoc issues
- drop voltage ranges for PMU outputs from DT
- many minor tweaks and reworks

v1: Original RFC:

https://lore.kernel.org/lkml/20240104130123.37115-1-brgl@bgdev.pl/T/

v2: First real patch series (should have been PATCH v2) adding what I
    referred to back then as PCI power sequencing:

https://lore.kernel.org/linux-arm-kernel/2024021413-grumbling-unlivable-c145@gregkh/T/

v3: RFC for the DT representation of the PMU supplying the WLAN and BT
    modules inside the QCA6391 package (was largely separate from the
    series but probably should have been called PATCH or RFC v3):

https://lore.kernel.org/all/CAMRc=Mc+GNoi57eTQg71DXkQKjdaoAmCpB=h2ndEpGnmdhVV-Q@mail.gmail.com/T/

v4: Second attempt at the full series with changed scope (introduction of
    the pwrseq subsystem, should have been RFC v4)

https://lore.kernel.org/lkml/20240201155532.49707-1-brgl@bgdev.pl/T/

v5: Two different ways of handling QCA6390 and WCN7850:

https://lore.kernel.org/lkml/20240216203215.40870-1-brgl@bgdev.pl/

Bartosz Golaszewski (2):
  dt-bindings: net: wireless: qcom,ath11k: describe the ath11k on
    QCA6390
  dt-bindings: net: wireless: describe the ath12k PCI module

 .../net/wireless/qcom,ath11k-pci.yaml         | 46 +++++++++
 .../bindings/net/wireless/qcom,ath12k.yaml    | 99 +++++++++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml

-- 
2.40.1


