Return-Path: <linux-kernel+bounces-347288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEB098D081
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D151F22EC7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E3C1E7641;
	Wed,  2 Oct 2024 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="dPsA5hGf"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9063B1E5018
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727862779; cv=none; b=HAZxs6KlS6piKMxy4V0KnMbu55rR+Q5l8+eslonKtJbb4Cy+drtIjhkTOnP2HFVhVBKPrVk/ylvTubEBvR6uweQ7aZjdhgtrtAHwd9n0+R+c3+RR/WLRZtEq+OuEF+/vWysJxagg1IMW/bmXt/gx5ofh8JwaZsIcsyl3Gtq5q/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727862779; c=relaxed/simple;
	bh=H6Ry8DzDgTcrQT0K0auQaKpRzT8r6buftXNA2IXeF0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s96GvTg49445buOx8vdhkV48y1rLSUv+32AtKPyiKN2u38LGv9Q5+gitdRsdXDHkE7WUB3IJmpJEZeVh7bkFlDmrMstYStGVLewTAZ0mzbzWtigcNfApSDiTVBv9MVTAO/oyTQ70Xa+em+8EJ8esxz44RcjePLIgmWAV9Li+tWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=dPsA5hGf; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37ccf0c0376so3797575f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 02:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1727862776; x=1728467576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/beIsykpVwfAKQjLfhfTQcIU3bBU5wkl48+3YfYwgBg=;
        b=dPsA5hGfBTxrGS0k2n9DXFUI0ejkQLr3f0NdyBGkYxY+BjpRmGi04B/cRrfrtMXebo
         dyjS95NSbYigTqRP+nh9la7ua5eRYKD/isA9aS+ZaY3Rn5ZB3/u3qLcFFL2fL7JLcmn5
         VpBgV0QZREKGr9MXslyjswT+nN39n+OG/M4O1g6zGgKPpNO5Hq4gsNtgT7dAyrAq5j74
         LmymniDGAek81R2rhz6Ny6OhXqjn3etGnUjSAJEKPkwq4yh4UmSgV9B05fb5bbm/I+0z
         FTB99iT5XnjhUKOPyndh9rGakt7iJA90yDj3sHINGQ8G9zVj7IvHbGPJEIuamb/nTCg6
         mJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727862776; x=1728467576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/beIsykpVwfAKQjLfhfTQcIU3bBU5wkl48+3YfYwgBg=;
        b=KQYmPJIc9RbXvnyIo1Ra9LB9GJlG88mjLTHt2VGn3sncReh58STBJUaPMaLu7p7D2Y
         RJbJLhjffuAlLDJaQ2h3eybn1S6YhBie5tbqr8PFVFAyCl5WUcOe5cSB9pHMyQErtNX3
         WALa1ViqcWiYBDAClnNkBl25PpgVnQR86uWE+FKBefRFpkVdPqysq3SJNKqq6DR8MeHB
         +cHq/w7fgT/NWFIYH0NuZVGDvryw/odL64EBmaXNObtEsZruX7NxCPCzLifjW8JlAewF
         MXBg07R1JY6XJ8WX1V7rXzacHdn+BGyjslOLrbC0GZPHDCjDuX1XDLjZKVJKE5RfIUE+
         ySHg==
X-Forwarded-Encrypted: i=1; AJvYcCXeEYM054ukyX+dSD+ryEDy0plQzrWbracNhjFUOcu085TimVP+J2q6uiWBoh8NSX7IkOW4N8yjskfnyCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIsePPzl0JUUpqSw3XvdDqU4B7Ex3E9FUhMs7wGhwtQ5k4fCJe
	gf/qYyYZsS02oRvw5myLfLsyKayXXJshply6/0KNkNRFD7HhVL5b9qaCFJU4D2Q=
X-Google-Smtp-Source: AGHT+IH+tEFEpCsp8cdNS3LgWvHr2fFRE/UwiiOiTkDMnotFCG7WsaHqqWUTZyu8PAehb6UejSCfgQ==
X-Received: by 2002:a05:6000:1186:b0:37c:d227:d193 with SMTP id ffacd0b85a97d-37cfb8a30b6mr1374823f8f.10.1727862775869;
        Wed, 02 Oct 2024 02:52:55 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:52:55 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 32/37] arm: Implement read_mpidr on armv7
Date: Wed,  2 Oct 2024 11:47:23 +0200
Message-ID: <20241002094832.24933-33-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement read_mpidr() on armv7 to make use of it in generic
code that compiles on both armv7 and armv8.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 arch/arm/include/asm/system.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 7e30cac32a..94c6f8f134 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -384,6 +384,15 @@ void switch_to_hypervisor_ret(void);
 #define wfi()
 #endif
 
+static inline unsigned long read_mpidr(void)
+{
+	unsigned long val;
+
+	asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=r" (val));
+
+	return val;
+}
+
 static inline unsigned long get_cpsr(void)
 {
 	unsigned long cpsr;
-- 
2.46.2


