Return-Path: <linux-kernel+bounces-571509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2A1A6BE23
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F3537A6500
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B28D1DE4E5;
	Fri, 21 Mar 2025 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="hXkiOk/i"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4703F1D95A9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570318; cv=none; b=S5u14gKLlvr2egEQKkuU0avlWQ8kvDW9Jtsk6TSVBVadPWmKRxgeaxp8LX3sqnC6rqUCvXu2iFXA0gvqXfpZZ4VRswA6Rm9Ehbzsg1lZ0ALeLVbKT1Z6PUzu888oKLOsyKOIlwcfjSQV/sO5hPOJhBxwn0V358Jf2PdEi4VXeo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570318; c=relaxed/simple;
	bh=zhaML4Pm1m+KgXGzKB1u6T1c5KY484O/gyZwJl4YL/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ckveQNHeeiph5mZSsRgMSWR2Q6uBs7w49YvQ14WFB1Iw7R4jMD8J60chEligRtLwCn8251x/NsYOe3hq+pIKfk3Dwx/fpv/hK6WbxQ9OHRgUzNGswDMnV4IZYLtJGMPWXyzXqDCHUgFrwV2ete75BUqDX8M8irleTrPlqsQt6mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=hXkiOk/i; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85b515e4521so63892839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742570315; x=1743175115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UTantLRj2g1pI/nv2rQCu8piWojTNSsUaDvPh+ZcZxc=;
        b=hXkiOk/ihh6uAQp8bV1d4GUG0/Shih91SHUOWa3E+gxKndxMWJT7xTfkhqDVlypUiw
         QFI/Kmdi4a0DnbOBkeql/WVhXSrhT8rjeW9OljzsVNWuETVUVVbNn2YfL0PDoQ4/IaE0
         qiCrzO7QBiOdYWiDPNGnORRmaN04WvUOQ8EFN8d2Lez1uxcahG2pgXOL3HdsLdb6IZ5w
         pJBOzZlGZ6c2bZ//x7S0fzXICfi1EAtY56Ec7tPYew9UkLq87oY5L2te/Az5bkCR5grI
         4xQkyOge3+qq1ryui2DbbG0vX3jJ9vJxDaz3JDCK4HgZY6FHjAmZJwuQqWf6YhZd9vcf
         ABHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742570315; x=1743175115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UTantLRj2g1pI/nv2rQCu8piWojTNSsUaDvPh+ZcZxc=;
        b=o0+LTKIz1VjpHVygLHKsyggSqD+Z8KY2gS42v6WuO6Js95OdX8rmEkXT7j2S28s6jP
         +BZjXXC/Of8Ej4asqbhy3hL/3CqBNkmAaW3swfxQ6UnwQDwVaIAq6TQ6UBcw1NUk0A5n
         WjBbvN9pzfs7wV5+RBwiLsaxtubvf5SSK0SfPqJahBW3lU3EZSx8Gr9crTVDiq080nVE
         ZDZUB0wuD2WdGMuPEysp7YJfV1g6nmohtugCs0FE2wr/Rmhf+cosBjbPti8DIo/5MPwE
         MuwQTquiNRLyR5peTc6/DyW1wlxfkexOYjXVrL7KBUZ8iKaL1rRBNuQKUyi9rk7YrnRI
         SViA==
X-Forwarded-Encrypted: i=1; AJvYcCUaE8WPsuXIGd8QNETQAr05dwQRyBzMnj/4KTGdIvCjKal75fWgdNHtyKU9nfhacKL+c1/NMB2Am7dv4Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKNt4yj9SXKf2fn+VmAGDTFgM/v988D4juYg21Jqy430j4ewAM
	J4BYNkk9R0JprEilfXt1R+EFyQ5yohm274Izp1PVvOU8NVzYwB/GIlyuLB9mgmo=
X-Gm-Gg: ASbGnctG3miGFflSf69RIKelkt/xSmiaJOrYfh8PCMyNw+eVMNhxNKJ3Z2XskAl07RZ
	t0ltHOru8oLqNJwhntQAaJcOdXZmDkz3sqEvLY3yn7Dl6aIyx4Y5xlUO5SvWFV1MTE4JfKkwPHh
	3bNtoifbE9f+LXBlQ3jtaAF5yzkHBYQiG1PikXVYo9dbZjS31yf/RwygjdDaoi/ma0PqYMy97H0
	Ho+5c/PPyfUDBq4ULh3Zevmxaql8XI4MJ1zCe6ufRqG7rIVx+P0yHd9wKdS27Av66hQwXss0rDI
	B6TZELq6g6FsVCi+AtNN4SG9dRKuhd/ow0cPi8RU1coRW2/uQ2bU+l3Czf1cKHiJ6VauaJJdgbX
	LDshrCxmcIKqxccXb3DA8dalX4OasXIxQjhQ=
X-Google-Smtp-Source: AGHT+IGSab75MXOOp0j710KIm4LrkQU9r7YtJUQHaFEL9MotB5UuhKhBeVLzh5RSsEP9NerpL6ljFQ==
X-Received: by 2002:a05:6602:3998:b0:85b:46d7:1892 with SMTP id ca18e2360f4ac-85e2ca1895amr415643939f.2.1742570315183;
        Fri, 21 Mar 2025 08:18:35 -0700 (PDT)
Received: from zoltan.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdd0a21sm475553173.41.2025.03.21.08.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 08:18:34 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: p.zabel@pengutronix.de,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlan@gentoo.org
Cc: heylenay@4d2.org,
	guodong@riscstar.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	spacemit@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/7] clk: spacemit: add K1 reset support
Date: Fri, 21 Mar 2025 10:18:23 -0500
Message-ID: <20250321151831.623575-1-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(Resending as requested by Yixun, this timing adding the SpacemiT
mailing list to the CC list.)

This series adds reset controller support for the SpacemiT K1 SoC.
It is based on Linux v6.14-rc1.

It is built upon the clock controller driver that Haylen Chu
currently has out for review (currently at v5):
  https://lore.kernel.org/lkml/20250306175750.22480-2-heylenay@4d2.org/

It also depends on two commits that will land in v6.15: 5728c92ae1123
("mfd: syscon: Restore device_node_to_regmap() for non-syscon nodes")
and 7ff4faba63571 ("pinctrl: spacemit: enable config option").

The first patch adds three more system controller CCU nodes to those
implemented by the SpacemiT K1.  The second updates the existing clock
driver with a structure used for OF match data, allowing both clocks
and resets to be specified.  The third provides code that implements
reset functionality.  The fourth defines groups of reset controls
implemented by the CCUs that have alraady been defined.  The fifth
makes it possible for a CCU to be defined with resets but no clocks.
The sixth defines three new CCUs which define only resets.  And the
last patch defines these additional syscon nodes in "k1.dtsi".

All of these patches are available here:
  https://github.com/riscstar/linux/tree/outgoing/reset-v1

					-Alex

Alex Elder (7):
  dt-bindings: soc: spacemit: define spacemit,k1-ccu resets
  clk: spacemit: define struct k1_ccu_data
  clk: spacemit: add reset controller support
  clk: spacemit: define existing syscon resets
  clk: spacemit: make clocks optional
  clk: spacemit: define new syscons with only resets
  riscv: dts: spacemit: add reset support for the K1 SoC

 .../soc/spacemit/spacemit,k1-syscon.yaml      |  13 +-
 arch/riscv/boot/dts/spacemit/k1.dtsi          |  18 +
 drivers/clk/spacemit/ccu-k1.c                 | 393 +++++++++++++++++-
 include/dt-bindings/clock/spacemit,k1-ccu.h   | 134 ++++++
 4 files changed, 539 insertions(+), 19 deletions(-)

-- 
2.43.0


