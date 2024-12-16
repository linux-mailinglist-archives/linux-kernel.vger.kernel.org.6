Return-Path: <linux-kernel+bounces-446907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E939F2ACD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2845E1614E5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3F61B87D6;
	Mon, 16 Dec 2024 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="lulfp9QZ"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD441B415D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734333608; cv=none; b=PhG8K7eYvH0z/wdfA8IiyNAQ/tnKH2IRe6tKblsHEkXU9Vl5mQPthphjw4d9LpsquQ9U2zcuPKVM0SFIM6CQsrJ9PJsBKquZruJ53wNVu2mvk+CWFrNolAcTgCDhxPyB1UdUv+/7v3sOeBxNwa5FxRTrTiI1A0H2XVfwAifj0KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734333608; c=relaxed/simple;
	bh=M0m6mS0qvuOgK4pqKWi4YcPmsudiy3imB1/B4ess3Lg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FxY2PHqBEyFlJw8HzYSOKRenSKXFaTaIXVUFCK4szvJzQUdfUYb4Iwo7gYwcfRmmDTvmXP62tNJkvRsirCTLsSS+2R2S8t/IQSHPSoB+RD9EVq3Wk5gaVTB7tNBckF3mbvgNDc2cytMvU3WmIU2gtzs3sPgdEuMJfPIZP6z514Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=lulfp9QZ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-540215984f0so4336824e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1734333604; x=1734938404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=saNfM3LJ/gXWUseFK7OkXZwpRXxJnebLh8Q4+xjWzoU=;
        b=lulfp9QZ5gsZQUCFTbmmzaAmRD0jU5ABrhB82MXxf7GSwH9w3XUeC5ZaP1zpWeA2h0
         34zmDPb7totrsm1Skihz4Mtjs2UMebq+xJn15xi+mIKJ9os5fVHccj/mFr/zzLtgdgkE
         NC6J1Acs6mAxHmXBAER7EgjO/Xb/aZQDy7vr/OtyVQYUC8zZZgpjPnZkl52ywgwQbhzB
         qLAhNW2Fs6PKXQb/zbnB0je4cvAs4FfdEq6T56kQH22sYw5zFsEcxaEtMXOyfSIeZuIC
         RP7zC1Gw4x79L5fOMubSXptnyCEGbGYZy5ObturcY7FckfrIJOzs9g5nFyZIxkM3tpS+
         BVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734333604; x=1734938404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=saNfM3LJ/gXWUseFK7OkXZwpRXxJnebLh8Q4+xjWzoU=;
        b=Hz7a4MyL1XUAF9y35NCG4G5mopK7sh9Z0M4flQouWgnqb8gWH1TDNHgnU1/EWJmJpN
         JJqM0OzGao1GE4U5M4AWFwh/lhZ2UaMF795C0u95zK9bZFXrNXEA/NjHr+Bsgo2RLIBh
         GGFn8JGGu+bLP/C5bCJHe3HKAax3ZUZm9JysKsBiX+o1phX/beeSUzlGRnEbm1wYMHGS
         miNXq1foWiL04C+ZcI1iM8m2VTh/5u5p64ooHRiaURe8l6EGYfq9QF+wUZ1jSVJbInRt
         xi3S/J055eVsNQdKhFR67/ha4TsRXsC+wPF97pZQWl6bb+IhG5G+TO22C2IlrUyg8d8Q
         5ezA==
X-Forwarded-Encrypted: i=1; AJvYcCXiaMfi8DqcUDSg71HyyHIGW7Cy/X4NTZdZEmdI8iPnFQvHdhwjmUVV8+n8kXp+5sf1ijT7eeaPGaRVV+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjiC/L/sOvhiqtPjhU1Mp7mRAS/QbXR2ccc9CDZQZ+4oIP1IbN
	ycmdKNmXXxnAocB0uHxI0+FpEKKbmsioFmtb+IxW9KdjtCQDVIyJfFuRMhMGBMw=
X-Gm-Gg: ASbGncvHFTVQcNk3oXXgj7+MANKLmr5fEcplTjS/8nezif1xC31KfWg17pjXGoEXwmD
	HIc75fgOGReyqjvp77oaorUCV9e/T4tl8SFUHJEa8lWnDKQ7Xcq0g+8twH/rkq8lvXdriOA+ZfM
	YqtVV7u/0gHvJDqtS5B3gBdkzRos2LQijguYmzKQ4wgqLZcj1OO+BU+gSgAOlG+bIQXdwvQ8Ce/
	9VkYdXZHKIejLZQx4gJg+h68kfGJ8Mok8vUC4DZZ9G7m0A61Qbjb57ERD1wmmeFxjSZLKA=
X-Google-Smtp-Source: AGHT+IGDnuBu4pD61786Xbqg5/sZ4XzdhAFZbPTySRoKaH33YM2xTlfYrZazJwFQUY+JIVDFd/RY+Q==
X-Received: by 2002:a05:6512:238b:b0:53e:350a:7294 with SMTP id 2adb3069b0e04-54090595736mr4004062e87.37.1734333603800;
        Sun, 15 Dec 2024 23:20:03 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120ba9b2bsm748930e87.94.2024.12.15.23.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 23:20:03 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net-next v2 0/5] mdio support updates
Date: Mon, 16 Dec 2024 12:19:52 +0500
Message-Id: <20241216071957.2587354-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up rswitch mdio support, and adds C22 operations.

Nikita Yushchenko (5):
  net: renesas: rswitch: do not write to MPSM register at init time
  net: renesas: rswitch: use FIELD_PREP for remaining MPIC register
    fields
  net: renesas: rswitch: align mdio C45 operations with datasheet
  net: renesas: rswitch: use generic MPSM operation for mdio C45
  net: renesas: rswitch: add mdio C22 support
---
v1: https://lore.kernel.org/netdev/20241208155236.108582-1-nikita.yoush@cogentembedded.com/

changes since v1:
- rebase against net-next/main as of commit 92c932b9946c ("Merge branch
  'mptcp-pm-userspace-misc-cleanups'"),
- remove no longer used definitions for MMIS1 register bits,
- add patch to use FIELD_PREP for MPIC register fields, to keep the same
  style as in already merged patch.
---
 drivers/net/ethernet/renesas/rswitch.c | 84 ++++++++++++++++----------
 drivers/net/ethernet/renesas/rswitch.h | 33 ++++------
 2 files changed, 65 insertions(+), 52 deletions(-)

-- 
2.39.5


