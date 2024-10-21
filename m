Return-Path: <linux-kernel+bounces-374274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5606F9A67C1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474641F224D5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41791E410E;
	Mon, 21 Oct 2024 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYKG4fR2"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EDB1E49B;
	Mon, 21 Oct 2024 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512994; cv=none; b=ToertbUyVtYEiOutqPFJmzwvtH64vDZDT/4XUItIlRGWlB3E8NzEB48HXv9usQQX/rCptUH+LmUMS96tSnnjinS16g6ab6IuGcdCiyUWYtziy4y+wkdHMW07X5oLYvta/wOMZ9aC/sF+xUWPxbGJB6zceYsqT3MnrFSeJC4tiUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512994; c=relaxed/simple;
	bh=fsZPms+Xu6Pn4MLCPPidLYbUkDqNto6t1mxmBXbRzp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CtruzLTTf98B6XwlcM3pEhReTkJJDt4O1X7yCOZ/KiCPI5Lp6kg6i0dYkw8J5yqES5Omjw0sftVEzBYO8WeiHP96+qvd8QY58omaMebR6bfQUBz9C97A9gRS1EaMtGovp8FzpYZODDzvJGmYLa48JhbdbdUhZKyObw/6yd99Pvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYKG4fR2; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so5881975e87.1;
        Mon, 21 Oct 2024 05:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729512990; x=1730117790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H/1MCTmxbUO44rwyL5iC5PLrKibwoBMeTpyT0L8eV+g=;
        b=KYKG4fR2w99r3q+lOzh3Xtz/+GkjX7A7Bqo2S0PJ0DC7TLq4eBleQEJKzzwK1YbRBb
         2Qr86g8HN+mzzbSS+tEP7dEcKWRtW4Zmry6UHpQUWJyPyM/qtrPWhRmkGsfedrWbvC1A
         eG2DA6NHvdvUFcmI6d4Bz++zS7cKz2/pMi4pZyyg3a+fr1bA28vAhsH9yicUKjQdWptF
         ytKWMEJebMvxDiwbwMvEKKGVSBZuFY93sPzugiltkGLXOgh7QEqhhdxfahwfjDcT2hIQ
         fWTM5t6nJypyDTAvNe/iWnQdBV8oV9M0HKKzSnAnO5cFI37Mj3T84LbYrcXh56v5LUQY
         qPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729512990; x=1730117790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/1MCTmxbUO44rwyL5iC5PLrKibwoBMeTpyT0L8eV+g=;
        b=IJPnw0rtZ5CpYsS3NFdIw1ssIMcLulBm1AxlNznerqkBImZvyZha+88Pfg+/IAWH1P
         fLA94nws75KwGhqf5BRf2c8zFodkhW+90PsoRbf6CAQnokrhERfZJIIEM5158KrQ3uBb
         IfhFxkbJPGys6Ku2qTeM04OFEfv6ReMwOyLxL1+01f+VsYpsehtuHBkj8/njqB1pz6lJ
         U0N7Ny+UzDfsShTArBhYQOCMjridoHNxn7CNGjwMKhaNUJfHNAxkmZo96T/aMFBKYme1
         zfNrNAgdxtPuo98Sto+sxy4cASMGBrEreC4zoFEofB6ZrKg4iiakBV30uW/b1aIHzGLh
         dyLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEJE7pSTCmwKgvuMO6IMALeJrQbvTQ9VDe9U7htnUGROB+wN6GhSFPtsHoK/0nTOp6fop8qTHwuGieTW0a@vger.kernel.org, AJvYcCWjfKkdIXdBYun4h7P1z/mJKrhWC70Vi4hVXNQUkLJ5tqKyrL7GFKWaLs+x5SpIPsS9/XE6J81Dq1ov@vger.kernel.org, AJvYcCXalVnIqB33xprjCLTQbYjmJanD8tDuwNMt60rLDwXbbJ1oHGwrDtUjah+Nxa1epp61+jFiVUvVwS0y@vger.kernel.org
X-Gm-Message-State: AOJu0YxAilq1QdYiBI3Vzr++ipbFZsvVJ+COszkpW0EELs9RLhnomWBM
	MrsrlR1N4xlnQZ0kq1ZQs4QUqTdc1OtIQXYZtwxabADgXVS9nh9W
X-Google-Smtp-Source: AGHT+IHR6MsGMRBzU5JPSi1HY55LtpEFaaIUqbCyIY5gOO8fE50iJxRU2yRt/DZvTwuMoUyyjo0iyg==
X-Received: by 2002:a05:6512:1304:b0:539:f760:6031 with SMTP id 2adb3069b0e04-53a1520bd73mr5457779e87.4.1729512989592;
        Mon, 21 Oct 2024 05:16:29 -0700 (PDT)
Received: from zenbook.agu.edu.tr ([95.183.227.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6ee6sm197068966b.4.2024.10.21.05.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:16:28 -0700 (PDT)
From: Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Sam Shih <sam.shih@mediatek.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>,
	Yassine Oudjana <yassine.oudjana@gmail.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] MediaTek MT6735 syscon clock/reset controller support
Date: Mon, 21 Oct 2024 15:16:14 +0300
Message-ID: <20241021121618.151079-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yassine Oudjana <y.oudjana@protonmail.com>

These patches are part of a larger effort to support the MT6735 SoC family
in mainline Linux. More patches can found here[1].

This series adds support for clocks and resets of the following blocks:
- IMGSYS (Camera)
- MFGCFG (GPU)
- VDECSYS (Video decoder)
- VENCSYS (Video encoder, also has JPEG codec clocks)

[1] https://gitlab.com/mt6735-mainline/linux/-/commits/mt6735-staging

Yassine Oudjana (2):
  dt-bindings: clock: mediatek: Add bindings for MT6735 syscon clock and
    reset controllers
  clk: mediatek: Add drivers for MT6735 syscon clock and reset
    controllers

 .../bindings/clock/mediatek,syscon.yaml       |  4 +
 MAINTAINERS                                   | 10 +++
 drivers/clk/mediatek/Kconfig                  | 32 ++++++++
 drivers/clk/mediatek/Makefile                 |  4 +
 drivers/clk/mediatek/clk-mt6735-imgsys.c      | 57 +++++++++++++
 drivers/clk/mediatek/clk-mt6735-mfgcfg.c      | 61 ++++++++++++++
 drivers/clk/mediatek/clk-mt6735-vdecsys.c     | 81 +++++++++++++++++++
 drivers/clk/mediatek/clk-mt6735-vencsys.c     | 53 ++++++++++++
 .../clock/mediatek,mt6735-imgsys.h            | 15 ++++
 .../clock/mediatek,mt6735-mfgcfg.h            |  8 ++
 .../clock/mediatek,mt6735-vdecsys.h           |  9 +++
 .../clock/mediatek,mt6735-vencsys.h           | 11 +++
 .../reset/mediatek,mt6735-mfgcfg.h            |  9 +++
 .../reset/mediatek,mt6735-vdecsys.h           | 10 +++
 14 files changed, 364 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt6735-imgsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-mfgcfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-vdecsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-vencsys.c
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-imgsys.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-mfgcfg.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-vdecsys.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-vencsys.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-mfgcfg.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-vdecsys.h

-- 
2.47.0


