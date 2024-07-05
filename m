Return-Path: <linux-kernel+bounces-242231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF48928531
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890171F24BEF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7D8145B29;
	Fri,  5 Jul 2024 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzK9d9ow"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA4B145B27;
	Fri,  5 Jul 2024 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172122; cv=none; b=PyX3XothUTqOTJeleq/8Z7Sn4PScQXx0sm4n6IaBhFm0zV3AcLx1XlBgKHtzdf3nuDesmW7vyy2zxSSoscUk4ea4yfXVCVR6c9K/lLjw20V3sJpsggSW+XN1OqGD4PsEr0w2b0Akjjh0nIrnT+P3nS/vaXa77QDrXp9ZkO8K1S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172122; c=relaxed/simple;
	bh=FDara64FF9ECO9bHCenn3pnCx2HKHF4XUZ1yut09/YE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D5ekO50UOIHoTfzZRvwK2awF8/dt7L9ySO5GEmXtwt0VIe0YFnFvsz7jvk803yxBS15NqaRcodHiixTAkpCIhRZA5zD8Iqd54mLWcUQyRh9Tw6wWCeZXxrfuJ9ZgCuGvQjIkV+d/2ynFGYhJAUybYCvS2I0u/MCDZAKbwELNkFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzK9d9ow; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6bce380eb96so838111a12.0;
        Fri, 05 Jul 2024 02:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720172120; x=1720776920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nE8UIWRoJ/aeBHjinkzqbMC5u9B5QJJxla+VRssQHgs=;
        b=mzK9d9owgT85WIQMriUvUGGos48Xp9wnvb/Q53Ac2mxDXLyG3oXaAcD8awEhAhGEkC
         ew2Z2zZzgmhlKB0+omtF8kdpwMRNlbQTbTcvWsf+x2Ecw6CwmxD9Uy+Jmmro4JohHm5Y
         EL8ewqyLw9gLMuSzPn7/M1zk5sZbnJZ1wlSuD7jEzJJGOSmlR88l8DiYa6vckZgualt+
         ndxtILjCXtzFlFFt1lQp813Du9+gTXSXUvkF5hP1L76x8PtmtTXvD5ZQ3iX8O4uoO4n2
         u0lRwrK7qge57LBAcvTT4OhhtgzRleqyevrxcFntkdETHbd/d+69dsoDivVR5JjqIq04
         clzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720172120; x=1720776920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nE8UIWRoJ/aeBHjinkzqbMC5u9B5QJJxla+VRssQHgs=;
        b=jU06W3P4BNlUIID3Y4EEiRHsfa4LIMaBBjbi9dtbiw9Lc5QjNP8C6+9Wz8MP430wLt
         qM5GZy9kQ8qCYfH0ENlBETjhVJoLaCOlYFAIISGtr0oBOjexq+sQkhEpMJyhD/pXIxyW
         SZk2V2WmIIrPPzcsiVxYZgryCQLhtGBXQ96r/ImuUpGbGHH8ippgoWVD+u6QPdU95PGJ
         Cr+f5uuvFe7bS0GDucRamW1Eths53FoGebTsyB6zY8f6sndNXtwYTTnsrvAePFrJPtJH
         8LaqCJ/KQoaTQZPi+dr0VaFuhtIuvts0ReHbXfacmZoot1943n+Gnn1u1rVykJN3Pfd5
         wyjw==
X-Forwarded-Encrypted: i=1; AJvYcCVpoJEDo7820JKkPHVxgsa6b0A1l/wxiHVrNqnUXGYw5SpAw2KGNNbL82LMxDCJHyqxoxdE+tk8VsvlQv+30Q2fdBSZ7wSYQjge9IUbVgWxxhgDsmJVjLW1Pzam3tyu/3gUvt4QdwKLmg==
X-Gm-Message-State: AOJu0YydyFU9GwtUR5D1AH+LkJGJOfNplHnhZBMcPM/7wEJ3nlyOHM90
	wgeZBf5czxAmrowVJ71YFCTNkguYxoBGz3biy3KvHmgq91S8GoAeAjZlEw==
X-Google-Smtp-Source: AGHT+IFYV0r/a2b3+xBZzBhYajORt+43xY24FXI3ptcmw2M+JtT31VHqtIMh8rJdbxD6jVFNEcM0FQ==
X-Received: by 2002:a05:6a20:2583:b0:1be:e265:8201 with SMTP id adf61e73a8af0-1c0cc75c761mr4311404637.28.1720172120307;
        Fri, 05 Jul 2024 02:35:20 -0700 (PDT)
Received: from ga401ii.. ([2401:4900:1c28:7740:14cd:cbce:fd61:6413])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fb167dd71esm48552005ad.238.2024.07.05.02.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:35:19 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
To: 
Cc: Kanak Shilledar <kanakshilledar@gmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] Add basic SPI support on TH1520
Date: Fri,  5 Jul 2024 15:04:58 +0530
Message-ID: <20240705093503.215787-1-kanakshilledar@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implemented basic SPI support for TH1520 SoC. There are two SPIs reserved
on the LicheePi4A, one on the SPI Flash pads that are blanked out on the
back, and one on the pins. I implemented the one connected to the pad.

It is using a fixed clock of 396MHz. The address and clock frequency was
referenced from the TH1520 System Reference Manual [1].

I have tested this on the LicheePi4A.

[2] Driver Patch discussion
[3] Devicetree binding discussion

Changes made in v3:
- Dropped the driver patch as the generic fallback compatible was
  working properly. [2]
- Removed the devicetree binding patch as it got accepted and is already
  in the linux-next branch. [3]
- Arranged the devicetree aliases alphabetically in the DTS files.

Changes made in v2:
- Changed from single patch file to a patchset by splitting the single
  commit into dt-bindings, driver and the devicetree.

[1] https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
[2] https://lore.kernel.org/all/20240701121355.262259-4-kanakshilledar@gmail.com/
[3] https://lore.kernel.org/all/20240701121355.262259-3-kanakshilledar@gmail.com/


Kanak Shilledar (1):
  riscv: dts: thead: add basic spi node

 .../boot/dts/thead/th1520-beaglev-ahead.dts      |  9 +++++++++
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi  |  4 ++++
 .../riscv/boot/dts/thead/th1520-lichee-pi-4a.dts |  5 +++++
 arch/riscv/boot/dts/thead/th1520.dtsi            | 16 ++++++++++++++++
 4 files changed, 34 insertions(+)


base-commit: 22a40d14b572deb80c0648557f4bd502d7e83826
-- 
2.45.2


