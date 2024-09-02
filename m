Return-Path: <linux-kernel+bounces-311359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37216968803
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7152B1C2215C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFBA19C568;
	Mon,  2 Sep 2024 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="fQ0m3Y0T"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4F113F43B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281714; cv=none; b=BtHVsTmHwtx1fzpKmUJ1d6o2a3BUYNr7LcpF1Glb/X2ynYVWNT9fnerwo+Pjy9t5XIBGGkmoysbsQGUqta0DDV71wPcstRMMDMAouWf4cAS+QPn2uXdPSfrX5VxMF7odctCd5JDu6gsNo4+4G9VZPO9myRxIVhtzr2THheKkDIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281714; c=relaxed/simple;
	bh=NQilyP7wSAA2j+Ki3ENk2C1yBNz7P3bhLYUFecekNIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IlOdxRQh4be4Pl2bSWQxrAg3olcI8x38G4yWRoaYp51YRTVZSkKYqXRPAwr9UNhE0hGp254XxX+XzhGa5Go3X7Gv+Ai0blvz5eHa5uPzmp6vgdcaG+4Fd38uN4pp3DJE3xHeCT9UK0HTm3AwZ5gQnXKaIY4UdQ3UAG+iaMQHUj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=fQ0m3Y0T; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-656d8b346d2so2454281a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1725281711; x=1725886511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ThRWljmoH7Hb4Hd8MB1zdTAbR9SpnQuP38bmtHqE+q8=;
        b=fQ0m3Y0T/qMXYFZP3Q8ubHEosDR2WxLO+/qHui5nDye76VGb3FLwt57nfAqlYs+bFp
         x+bFpn68cxxW57EspQgvrurqO1czH9leKlRYJDAY0fPLThWlYXablFMwQ5U2/CGG4dFi
         lkYrIyzrpRs8IaCm7lT70mdJ+C+15Ca2TYrCyKdp/vVFs8MDkg83i2tJLroJp8+O+jrJ
         +T9c+CKyhDkH5McZw1KxxsIdn0eLbNnjVKkscRyVaQV/P6qEmc4wlDzvZeHhUoha+vfD
         iocQ/uE/F49jup31gK5/GJZt6eNH05cqO2hf7DmmkaIJ46hijzXnukHXa5AZP/zyLNNV
         tEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725281711; x=1725886511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ThRWljmoH7Hb4Hd8MB1zdTAbR9SpnQuP38bmtHqE+q8=;
        b=N9D2MyWVNfJybU58YPne3qB9Eh+h/600aI/9RsIlnneSsJuNN8184MsIO3OR+67w6Z
         84gYWhPxnzbkV9PXvxcoYCAdb4/shc/kZlspmHHq7R4SyZY2xQg3Icr33CRG1I+D9s4d
         OEg/6L+PQ1IkC0iezf3lCbHJE8xy6o2I7A8VfHvNnSsEcLXHoeIwv3V3aQZ+tq0+xX74
         Dyl3dv0jwNbecIizq9ivHZ7Q8+Ko8ke+BAvAhfYqdkUADxJEARnYcpNeuRQ7h+B4mhbB
         Qx0/8J0Ufo5V14leLbHhcOsILXtwQgqWj7+okB5v8hiT8ye2IulFtIt/zeQcM6pcYXoq
         9WGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ9dc5vIyyAuKk9TWz9dVHVTpVHD1BEBojUmM8MBay+PBksIEq7E5Hor8KRvfRGvb7/fG8wxrmCZE0a40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3WddZGGN4AOySXEHb0EjLjaZ+gsmE3xT+ymL7l2Qd2fuqmTq2
	MB2V25xG+sQPtPkYifq4TMQ52FCLnSaJamWIxUiBPuHPnrgmdPDdz5gRc9WNeCE=
X-Google-Smtp-Source: AGHT+IFWYfklAZRYA4/RL84tZfC0b6rpcrS93I5FeoZ5eC3ChpSILTafiqClMF2uMDYki1jXpxc+PQ==
X-Received: by 2002:a05:6a21:6b0c:b0:1c3:b1e2:f826 with SMTP id adf61e73a8af0-1cece5d1548mr6768179637.35.1725281710762;
        Mon, 02 Sep 2024 05:55:10 -0700 (PDT)
Received: from zjn.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a99eesm6773955b3a.50.2024.09.02.05.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 05:55:10 -0700 (PDT)
From: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
To: angelogioacchino.delregno@collabora.com,
	matthias.bgg@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	knoxchiou@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
Subject: [PATCH v1 0/2] arm64: dts: mediatek: Add MT8186 Ponyta
Date: Mon,  2 Sep 2024 20:55:00 +0800
Message-Id: <20240902125502.1844374-1-cengjianeng@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v1 of the MT8186 Chromebook device tree series.

Jianeng Ceng (2):
  dt-bindings: arm: mediatek: Add MT8186 Ponyta Chromebook
  arm64: dts: mediatek: Add MT8186 Ponyta Chromebooks

 .../devicetree/bindings/arm/mediatek.yaml     | 11 +++++
 arch/arm64/boot/dts/mediatek/Makefile         |  2 +
 .../mediatek/mt8186-corsola-ponyta-sku0.dts   | 24 ++++++++++
 .../mediatek/mt8186-corsola-ponyta-sku1.dts   | 27 ++++++++++++
 .../dts/mediatek/mt8186-corsola-ponyta.dtsi   | 44 +++++++++++++++++++
 5 files changed, 108 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta.dtsi

-- 
2.34.1


