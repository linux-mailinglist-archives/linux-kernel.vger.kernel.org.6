Return-Path: <linux-kernel+bounces-357974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 149119978A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A17BCB239F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEC61E47B9;
	Wed,  9 Oct 2024 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzoRIw/W"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FAF1E47AF;
	Wed,  9 Oct 2024 22:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728513884; cv=none; b=NQulxIen7cC8hhUYmgZfR0b2/IB92NwMy8igYK+ynCqqqMy5yFWZwc6tyvaB7+wm3ZOk4JNE0wEZmhlreG/rfX+eegE2f+0W2tsPzqSf2CoQklA21vGDOM+xEHa4A8vsMaveJ7YTAz86spLDyUAFapFivM4/lNn0jAc3rG3XeZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728513884; c=relaxed/simple;
	bh=Q9CnyF7t//8HC8h6F6lh1zeH9rMHPCikrgtfjgJg+a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvS8I3Xy9XZw5dCFgYjoI8kZxzctVToElHCF3SUQu23lWJ+IFRrdBqq1GEuBN0tIa7u6xkOkPLCFHvqadTPSRagAY3V3Yq300FGXfnW23NbwJPQVqTuTaNCOZ+NLYzNsYVD7WFhgtVVGF6hnRyNaOSAej7oLOgz1KqvvAHFyJ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzoRIw/W; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71df67c67fcso239912b3a.2;
        Wed, 09 Oct 2024 15:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728513882; x=1729118682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncgmlyGfcrqHCYKyqt0DRpGIqa2UXUmRq5v7oAb7ZpU=;
        b=EzoRIw/WZS6yAkAIfpDJMkBo5VQREEoLU0Jk3eKsaF2cDxjCJjXgj0OxhEBab2AzTr
         ujZ+76CLJyB1pyP2I/fowh+r5BRJRjm7fEFI7r+iRCIr+0UYLVjFeAqvecAiZS9uTfrp
         Gq/D3C//piS/ctYRMDUeKtv2ZFa7yzzkzpNPkJNzFFCZfXe6nJYDMgT/n0Ml9+NiLLIH
         jC3afJu4xSEyunPg6RwrhQzIa1z/jOxeqnq8RWYv0sFUM0PD9uHbjEofbeMD3kLplhAd
         qz+Mz+A6+t34Tv5eZvV3co8HO00TER6V0fnxb3LhWQ6ANLB0bEYeOh16smFh8KoVQAuh
         8KJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728513882; x=1729118682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncgmlyGfcrqHCYKyqt0DRpGIqa2UXUmRq5v7oAb7ZpU=;
        b=YoP00PNGh95Mv/MCUeE3jOYa7N7ju9GIGEVCbR5A+dV8bJnAnT+QAbryM/jzOV5E8i
         zEe+eLQ0TItXaPDuMMGh0wE6XoJEfAy+6g55/YyIUldbjMZ2EXKo8vcdfwLYCnOvNhol
         mJ6XzkPKUJ3L1pSHZzA4HNSWRR9flHXMXaLAmtFNL1tPGRUAAUL9PK9H1V1hkv9IciQk
         EmDVQN2ZR1Z+yfMju8x3NnpcNrTIFp6TKWPOyr8LBLkQUzh1B6NG1PB05LZ3qaUAUZOP
         wX1JOxRNF8k34eymiqHU8PNu/5LN5POBL2gUGQKxIKyJcYsMPwvu0EcQBWn6OCQRzi3x
         deHA==
X-Forwarded-Encrypted: i=1; AJvYcCU64sVXD9Y/UYnTMar48fesdLVF3WNhUoGeARRUUODpMUSVLnIGm2QL5gjPlaBjXfY0jr+tPWFxaJdZdTBZ@vger.kernel.org, AJvYcCVMAc/OQcx02hY4I7+WVXAEsEqpx3CaX8WeGkdAAwM44SpuR8/NOLOOihorSiOAJCP3rMo8V1o8Pv6M@vger.kernel.org
X-Gm-Message-State: AOJu0YxFWWv1j18GBY7xXSrsmd4mIgYgkXco/drYcNsPaQbJq29H5060
	S8DCq3cnnR3OQAgMpAp0p2hnq+ZkfN2da9Hngk8IeY/Rs7ca6SdZ
X-Google-Smtp-Source: AGHT+IEsegox6FAk/S37zA/g3uQmNQ5/YPSSLpXd7JDYIf6OoXCPh+Lo3bP5Hwajxkcu1U6ZdNlXrQ==
X-Received: by 2002:a05:6a00:1396:b0:71e:233:9537 with SMTP id d2e1a72fcca58-71e1dbc98eamr6521856b3a.28.1728513882195;
        Wed, 09 Oct 2024 15:44:42 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccdb93sm8265778b3a.55.2024.10.09.15.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 15:44:41 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Guo Ren <guoren@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Jinyu Tang <tangjinyu@tinylab.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 3/3] riscv: defconfig: Enable T-HEAD C900 ACLINT SSWI drivers
Date: Thu, 10 Oct 2024 06:44:09 +0800
Message-ID: <20241009224410.53188-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241009224410.53188-1-inochiama@gmail.com>
References: <20241009224410.53188-1-inochiama@gmail.com>
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


