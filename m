Return-Path: <linux-kernel+bounces-375569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702999A976A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9CF7281F61
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1B812EBE1;
	Tue, 22 Oct 2024 04:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dn8raYlI"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A8212BF32;
	Tue, 22 Oct 2024 04:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729569768; cv=none; b=Ai4uC37SF5Kq5DXyjLStfFKgj3eo7xXBg0P/D9SP2idfn3tYQO7ZuBpoM5iBG/GGNWk72esHISxzKCSflnmRJIkQiAiUBNZ/a7LDHoEBdUELJVgnda4Te96wrb1LN9ksBXwoN54rFik43Zv6aMzdSmOi88+VUS+0HSlLnHz1F4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729569768; c=relaxed/simple;
	bh=Q9CnyF7t//8HC8h6F6lh1zeH9rMHPCikrgtfjgJg+a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JN8ysGCa7zmqqirpOlxEUd2fMSPjo/AK8NpyZ6ftq8uP7Iz9C3XxYK1Nnh5QCECDCUnfnTGXhv81phx0nbBAVe1wYMACmp3F+HLkI4byR3vOP1LHSFMfoJHw+0MLQf4OAR6EMfuYuf382/Ix6IHxMuif9MLGH3uVjHjFbmud0fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dn8raYlI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cb47387ceso45931535ad.1;
        Mon, 21 Oct 2024 21:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729569767; x=1730174567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncgmlyGfcrqHCYKyqt0DRpGIqa2UXUmRq5v7oAb7ZpU=;
        b=dn8raYlILxt6ZGIjxFehKdu+a/5Q7SuV9ZHpdKCey4BjPkf3GoN7WQWe82R6cRP5h+
         sTkIkdaU5HqKu93qYFBuZqGWL3rCLyPQsRNAIRuwirmbWIjyAvFJfjKaLdFwO6fb/0Ir
         BkvuoaZ2N/89FC7WvEYVmWFSD0WD3pXzAv2WE+tkCgId31nuDNNcc8Q77YIAsIqVuyC6
         WNqq0g2tuIrm7A045VphtABoO9FswR6IWlWOeh5ckx0vswC/TytKXgn7eKzkYA9rWhHu
         Cnd+gA3oklGyK2dTka8vVG5eyMqw7mwQKngvFXlC6VUdQv8LyPAFfEq/8Qy5S8dK4g5D
         So9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729569767; x=1730174567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncgmlyGfcrqHCYKyqt0DRpGIqa2UXUmRq5v7oAb7ZpU=;
        b=lNSi7Ru4bhKUfnpu5uTPWQn8BX8CllNlcGwrunGrdOqPs/ktbUR+8hUvpUwE95hz/A
         WDo2rG3unt1FeZoH7jKlIHnKnNBwK+xnrj4TT0jfbOQBVdf1VohnDUqvZ53CA7oVSTCS
         aAB51QW7r872yOAHu6sqRRGPS6qG2EMLIcI1657NxD+ksrIRaW3zU9htgo26QbO3VpPe
         rqZAJxk9broGUuYVoVch8OH0FXqx6skUBsrQzDaoWFuSRpvaXi68vSB1xoUbFXcf92Ny
         198vu+lrrl3ZnHmi3FUOQ5e6gC5H0JvLtLvu+Gm33YJL3Eil3oFr7EOVfDsUN62FU+10
         jgHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2+/IhOQxh2oK8Ch1JaRRxZp3EYR0Vq8UwOWvOBSgwRiJMU3nPBIhLghNl69niCddkY5EIhoDauFa9@vger.kernel.org, AJvYcCXJSSuMPfcdEIFzSRE/omBIMmRyT9JwK9oMD2o7Jdn+/xKZUtgz8Th4M/fhsg+UTSeRUoorsqfodsdg4zzI@vger.kernel.org
X-Gm-Message-State: AOJu0YzYRPFQn0xMgeCh7Ry++sevWxdhpSHLAq+9xwPq0NOp39kqtkae
	GgzY4W1uvy4FMP0M1X/36Xv5xc3t6rlXoWajS2WpdfkSeYPyxHg7
X-Google-Smtp-Source: AGHT+IHPcCzAx+iiW8df3gz3gZtXUxLdDe9DNtEZZmDqrW9DCC3AAd2AKq1gArxRGkZyiZRD4OwkTQ==
X-Received: by 2002:a05:6a21:6282:b0:1d5:2b7f:d2f8 with SMTP id adf61e73a8af0-1d92c4e05b3mr16504132637.13.1729569766739;
        Mon, 21 Oct 2024 21:02:46 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabda3b2sm3924281a12.83.2024.10.21.21.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 21:02:46 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v4 3/3] riscv: defconfig: Enable T-HEAD C900 ACLINT SSWI drivers
Date: Tue, 22 Oct 2024 12:02:17 +0800
Message-ID: <20241022040218.450573-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022040218.450573-1-inochiama@gmail.com>
References: <20241022040218.450573-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for T-HEAD C900 ACLINT SSWI irqchip.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 2341393cfac1..5b1d6325df85 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -256,6 +256,7 @@ CONFIG_RPMSG_CTRL=y
 CONFIG_RPMSG_VIRTIO=y
 CONFIG_PM_DEVFREQ=y
 CONFIG_IIO=y
+CONFIG_THEAD_C900_ACLINT_SSWI=y
 CONFIG_PHY_SUN4I_USB=m
 CONFIG_PHY_STARFIVE_JH7110_DPHY_RX=m
 CONFIG_PHY_STARFIVE_JH7110_PCIE=m
-- 
2.47.0


