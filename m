Return-Path: <linux-kernel+bounces-214443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E5A90848D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11B51C248D6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F8418754C;
	Fri, 14 Jun 2024 07:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="VCdJFOfq"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B53187544
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718349617; cv=none; b=c3/eLtyi8pQ/E4rn97655H8n7DHFjouQa/KxjB8XzTvHBGmEwgtbm3vtqZ6v1HrBZ5eU/3XSigJUmfqbJ/nbca/8UHsKYiqLz0CioWOXeF3Mv20MzuPR0EcMuXzJwulDZoNqfYcr3SMA1RoZOyEklWb8wANyJbX/2Mnqyexk8OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718349617; c=relaxed/simple;
	bh=KAFnvdRq+2pR7azMtu2K0xo92UGOZLfO30BelL+InbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bo+PWu9puuOd0jZuPAMwwmu3S0Pxk0B5V+dWrCtkG39akdKe42T+fAHvCYo5rkR75Mhau2OtWqt1uD7IGcQJV+HL/ZSPoCGGzYHLyp/u1m6MsNGLdLCQ02MVNywYIbVx1GMsBvziplr2HZNWj2i87FXqV4Q7b+ilG0yMioi5gFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=VCdJFOfq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42281d8cd2dso13290665e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 00:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1718349614; x=1718954414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBQryArzwC0pcpfTb6INLK/D8vEzmJaod3AONhND7ow=;
        b=VCdJFOfqQgPTTiObcJs5/lSR5gIhPVm+FegjQBYw3EzGQXAKh5v3SkhcXxgM/K/hJN
         s4qhWo6ezeBjucmDZTgJor3ZbAPe7b1L5hYNf9l/mgbm5GrklXdDbadFl9r1anR8bcME
         a3uX0sgJIrVT1S3+i13ZbCCfps41hzJdp2T6vFyBaKKR2mDxJGTwnDe4x4Wtg+IENvpp
         w5QqnRDFii/fZMEaAxeNzfYZhJ61cWMIcKswoXNgyrEVqcIXbdlFymNnPW4QnlLEci9T
         iVT4wzPASbIpo/qf2K6VpcCbJG7Rnq65dLus4d6ZNBXuNunhWjGUO77kf4WSct6NTLVG
         wVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718349614; x=1718954414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBQryArzwC0pcpfTb6INLK/D8vEzmJaod3AONhND7ow=;
        b=ksEh0b+Yt0lI5ZkaQwRy4XOb9XI/7dqjdvc1lv4QRVRgPaQbMT7yy+QqTg3Jg4ws0j
         8c/etvKAQ4Wczs91Dm1r5zQ2F3nIS+94GHIqFsKpON4ieB16gmIx+nk37B1WQd5g6YNS
         5hs7sSU1iCkHR6m3Mkl9yUFlQech3YRVM9gD8Knio4BFTxN6ZhW5NG2jExUO+0U5fkrD
         66o2na1vU97Wh5/DD21TxoggA0AUoxrB08lRsyG0e9WSOVvoSONS3+fxyB7fmdkVsCDu
         OwWW8ASWOYzaVoZcb8HfUfoEeZyIlnIbwKJh+6E1fpvj1AV0D1JdskS25ll07JRYaNoM
         m1BA==
X-Forwarded-Encrypted: i=1; AJvYcCWGFx8fevSre+4A8UxT4kwWTpBu5VJXpEUe1vz3hhAbELkSMOAUhzRcPQ6Yyrk25UsbOebU+MH9Wdo3HnzyK1zpb9BUeeQWN+XqxztL
X-Gm-Message-State: AOJu0Yzo6T1W17ndAcD9yw0PXtSKBERO+TO7kS+v2H1MkSbjapUcQ6Ja
	DLXUBUgjfQI0je3RjE092IR4uMAz0hvBZmoZbuwt3PX2Nmcmft7FezpVJviEgrdTLMRebq4L/PQ
	A
X-Google-Smtp-Source: AGHT+IHPaQD10DLPhpZ7aY3WCufuA4Kxyjs3R72r9aYkAI7AVznPL9Zts5GX/ZtfATd4xeTNB6QBsg==
X-Received: by 2002:a05:600c:45c7:b0:422:727c:70b1 with SMTP id 5b1f17b1804b1-4230481f0cbmr18120785e9.8.1718349614367;
        Fri, 14 Jun 2024 00:20:14 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef9eesm87272555e9.9.2024.06.14.00.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 00:20:13 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lee@kernel.org,
	alexandre.belloni@bootlin.com,
	magnus.damm@gmail.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 11/12] arm64: defconfig: Enable VBATTB clock flag
Date: Fri, 14 Jun 2024 10:19:31 +0300
Message-Id: <20240614071932.1014067-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240614071932.1014067-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240614071932.1014067-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable VBATTB clock driver flag (CONFIG_CLK_VBATTB).

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 05abba0a0209..fcb0c7ee8769 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1348,6 +1348,7 @@ CONFIG_SM_VIDEOCC_8250=y
 CONFIG_QCOM_HFPLL=y
 CONFIG_CLK_GFM_LPASS_SM8250=m
 CONFIG_CLK_RCAR_USB2_CLOCK_SEL=y
+CONFIG_CLK_VBATTB=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_TEGRA186_TIMER=y
-- 
2.39.2


