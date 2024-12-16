Return-Path: <linux-kernel+bounces-448205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4559F3CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79EB51886B45
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78221D5ADA;
	Mon, 16 Dec 2024 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fu5QZD5P"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24171D516A;
	Mon, 16 Dec 2024 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734385379; cv=none; b=CapoEg6Xg+uzywkuPH+13B4IEjEj+m8KW8Hbcq8g06WhhYqaa64gticRky2KO9qnaxR5toojoJTZZj397006BfDT6aT52G6/jmKS8VOpiDf87Ob4wbQGXNXfqBtXmAP9T27XFcAbfD9OmKLJl/FZAl84oXymFgXWDzfak9qpuPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734385379; c=relaxed/simple;
	bh=c0Jk8D2bUKM/0DMhzZRvjCUqstMsqUH8D/AjtehQYCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y7qPajZ9ki56Dx0vgXcYs6no0ckXkyFZ6CCYe5zcbz7wELHB+KPrnmzykMwC5rRY1iED5RJvsneSjJmTTJp6XDLPZFRICi2bIBUG2iBWtj+mHXnH9/4IpC5Zs2TfZ3z8O+Fa1hY/Jd3LaVjiuP49Ljr5dZ49O1zJTMpBFX1UiaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fu5QZD5P; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a817ee9936so16131585ab.2;
        Mon, 16 Dec 2024 13:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734385376; x=1734990176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DRJiV63LRq8fV+tehc1tAI/LgilDFILxKmmMTE8EzxM=;
        b=Fu5QZD5PfLzZFzGwg6gmA28z8/KRYZ2KnyUoNU9E8KCYmem7MT9HNHh719mykQo0Mm
         u5qJIWxIsOG05hMoxlupAPyJLMhoqcUwSWa3qBnPhwbjH4WGIogRaAhl1IfS/+xqd1z8
         1Hg1NtxMUu3n63SIGUOedeVSdHvDr6bXQJDlRWpt5p819tNAXEwjLQ9CvHlpeiSOpkaB
         aK6yIo0WJ3wa9vE95BT2TUgdW2adVlnWnQ0iuBMelzINq84h14aju9DK2G3+aNIWqN5x
         3/8wBeJBIAJ431D9QCMZItMiCMh6jH0nDPK7WaWminOwACbj5KqWPYFuQXzg3npY4dzb
         P66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734385376; x=1734990176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DRJiV63LRq8fV+tehc1tAI/LgilDFILxKmmMTE8EzxM=;
        b=Qow5K1PZLZuMXkG5R4yHXl4ILsq9gItXLwe5pT6yMWUzSTBAJg6H6We93BH3uerdG5
         oQ3NRBnm4d4cGvgShWVIEq/gzMYscGJzOXI78taTLqC2xnqDD7WMmIMkx5DOs8/7DaZ3
         8fnwcALMCvsBCRuETu8ld3FTYCKJOYcTblB+BtNkcSaNsELe4f1SO9KoaUBD/eV8Ax+J
         ROXEqtbCnTiG9nVTeytHNS0J3+0eFSz/MOucBtQMwLj0ElAtpMkclzWL8b1PYWUVKmBE
         f+KRvQT5onK3GPmtTutuvbVqh9bCBJZy+HOJ4YtCNgGfpuwYQ/UPRtFC1byW0Ev+jsdx
         lUbw==
X-Forwarded-Encrypted: i=1; AJvYcCVO7u2p1jk9+ishArwMIZjfZrwL5V77ydXT/ZAzgHystMBBh0wtvqLZfyUzMWdNMz2ES7KZLoyQ7ykQ@vger.kernel.org, AJvYcCWndJR7yMzqUMUyL9WROuR5WBZkA9vxdu1uIutp/JYw6BoZ24JPSUXQveDH4P6qmNIx74p7V0nvW24=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSpG9e5m8Li34HzXs2lfO4ZW4q2rKQsrCOZNOlTAbpF/XKLzJ/
	7W0JEpPG6F/bvHNfTpkwry5qyJ74r/1S20rIEgR1x+JKSeNtzY6B1bq3XXYW
X-Gm-Gg: ASbGncv4BOap6SCGwibC4KqIVft+xj3MKN3izoiwrVknp5J9Hviv2/E7G3Q5YncLDmb
	Ov9xVn/hmU6S7W9PiuRv24jXIizj7A551iZvNLJ5ThW0IJa0amxr+fWRP/zkPcR4VKT6+38o58o
	inRZDEYGA9Bw4L1vZEY1CfKWER8tL8pQ0UZUQjL8enRuNPkbqoUNpRQ6mG17Wn45aWVDZkq6rtl
	tHKjJ9RzHpECOjNL2HG5NY7Wi8E3zkxW60Kd5JtapOZ0N+d1ZszUKCHQ8AGpNIlr4bPGMt/A1HD
	VP+hBgkXi863Hxp3BeZ9FQTTbUw=
X-Google-Smtp-Source: AGHT+IFDidsqDmLm+P6RSEJBRFZE5QlyQnlF1Kd+ADUltzI0Z6Ahn4amtFa5gyQLV/DCYzsUMkU4uw==
X-Received: by 2002:a05:6e02:1a07:b0:3ab:4bea:df97 with SMTP id e9e14a558f8ab-3affbbb656fmr162024405ab.23.1734385376356;
        Mon, 16 Dec 2024 13:42:56 -0800 (PST)
Received: from localhost.localdomain (65-128-205-244.mpls.qwest.net. [65.128.205.244])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e32a342asm1426777173.89.2024.12.16.13.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:42:55 -0800 (PST)
From: Shimrra Shai <shimrrashai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	Shimrra Shai <shimrrashai@gmail.com>
Subject: [PATCH v4 0/2] arm64: dts: rockchip: Add Firefly ITX-3588J Board
Date: Mon, 16 Dec 2024 15:41:50 -0600
Message-ID: <20241216214152.58387-1-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Draft 4 for the device trees for this board. I hope this one finally
addresses all outstanding style and organization issues. Note that the
technical functionality limitations from the preceding versions remain.

Changes since draft 3:
 * Removed the rockchip-pca9555.h header and used the pin numbers directly
   in the .dts.
 * Removed the display-subsystem node in the .dts. No other board seems to
   have one like the one that was there and it was causing warnings.
 * Removed extraneous property "rk806_dvs1_pwrdn" on the PMIC subnode on
   SPI2.
 * Removed an extraneous property "rockchip,skip-scan-in-resume" on the
   PCIe node pcie2x1l0.

Shimrra

---
Shimrra Shai (2):
  dt-bindings: arm: rockchip: Add Firefly ITX-3588J board
  arm64: dts: rockchip: add DTs for Firefly ITX-3588J and its Core-3588J
    SoM

 .../devicetree/bindings/arm/rockchip.yaml     |   7 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../rockchip/rk3588-firefly-core-3588j.dtsi   | 447 +++++++++++
 .../dts/rockchip/rk3588-firefly-itx-3588j.dts | 705 ++++++++++++++++++
 4 files changed, 1160 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-firefly-core-3588j.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-firefly-itx-3588j.dts

-- 
2.45.2


