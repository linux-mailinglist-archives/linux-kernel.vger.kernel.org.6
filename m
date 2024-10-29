Return-Path: <linux-kernel+bounces-386552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3419B4500
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59E04B21C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9707620408E;
	Tue, 29 Oct 2024 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WyJFokw9"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284B72038D4
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192151; cv=none; b=fcJR72ZBJvv+Xe/t3L3+A7OPfEfvENzkcMPbvN6HiZ4O+lqMO8VplKJQqzHwopIO4pCUdtanJtZvCryAkTPmbvZVtihwJUnggjm3FIBw+JLsZP7YNzU1DtWI7zwdwUiGaSSkrLT2ZrQ7muyt1o2aPbD1YBLTV+Mg5qfJi1Om2bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192151; c=relaxed/simple;
	bh=4gFt5SNrfp0SWXU5+NH1gVt41zrxB2+OF6ksw2y669E=;
	h=From:To:Cc:Subject:Date:Message-Id; b=uRgIYF9rU8eYda34E1MvSVsgevUQ3OR1EoZUCX3f2Qk+7HwDPH27s+GO/V4fq7TRhP1Nq4fY5oEa0eQZg4L7J4rOF0RzGUTEaMdh2CdwVZl35ybXBqNbihv3bPXuYyHdazEbnugz6QsnsgHDMyt7rLd2n2dHX/zokYSETBhxkkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=WyJFokw9; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ea7e250c54so3860806a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1730192148; x=1730796948; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuWnhLJQw+PAY3xEBfJ+QJn2JlieNeFBTgX6ZFMdL84=;
        b=WyJFokw9U1deMTx9dGui8OG44BfPiimFXzDnt0Z08OGppSUaI2Q+LkO932iw00AVKf
         btX/W56kQOdabMb9XppMfxLJgYdgdeH7yusmYB6l2dtXT1xaCIISSY4r+m2QBp809V5o
         wNrD6lTqEw8wKkx/MwAwjCENTxFRDyoMGMqyGeWetKZL17t4vUoE5AjDgCmk4gjfVj1Y
         mX5iHJgm4ckT/jg6GlHOt6gxw9M+wer5ZQEOKKY7CYb45wCsj7XxUr5y63f6+U66g3z6
         CTUFGUTWoNEKiKuppzP8J1qDnM4zzOi8xC5vfS5P5eo467V8Je+CHenuTT+ZdKW2WtTX
         RB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730192148; x=1730796948;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xuWnhLJQw+PAY3xEBfJ+QJn2JlieNeFBTgX6ZFMdL84=;
        b=f7oNtzi+3gC6dUjdQgrNYz5JV7HrkfCb3Jn8natrV35PSyyT9fNvEBfOBliFhRO6IR
         0FaG2C81kfAOEDxkvhV/1FtYoqtq+8QHOcgo9N2oOP7W1GXToLzt9eIUJ9y4iSnFp3Tp
         y/jYPykkRzoinVKham22t61jE/utFp7kmnjsbbn9ogENaNw8ouzjvCBzR4du0F67gXzu
         5OY1hDQMCptGS4Vd5OBYi8+YovlikE2Bdcrkazisx0tL0sNkUS6w27qwVB7iCqOPoAqh
         GYRQEOQiKxJUbpCmL3oYzi5L8An1lp5tvniMV5SUrLcz42wydIPjsUZh92quwmD33Uzj
         3MSA==
X-Gm-Message-State: AOJu0YyWh4XvjmBX+1C4aNGPGuiS7tZZSGr98wKy94Ea7ammDveRzpT8
	wYXyPu6JVkOzJdF5IhtVS2tFJT/BrZM9Wy4a3NQ/aJI2ybVE8sFOKFE14b1tYdywgc8EUYwW9LU
	Jc93dq7yN1xayajKcBbSVrk+YPBko3PdDEjMffD6AwuvdTATavaxSV6kJA3x6jwhwYg22DtJN0b
	GnSbe5v0LvY80eSPXeH1inyNnRc7XlVZrscJ8pP5bQYIX30AZCbLqUrQ==
X-Google-Smtp-Source: AGHT+IHf0YC+Ea5Ksx4oBfD4ogAxvHzzwCrdPrdXaYrCaa9GKLqYlspwFnf6XIm9UGsHOjhUqPUyrA==
X-Received: by 2002:a05:6a21:a24c:b0:1cf:2853:bc6c with SMTP id adf61e73a8af0-1d9a84de0a3mr14026908637.33.1730192148007;
        Tue, 29 Oct 2024 01:55:48 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057931a06sm7054189b3a.55.2024.10.29.01.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:55:47 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v2 1/1] RISC-V: KVM: Fix APLIC in_clrip and clripnum write emulation
Date: Tue, 29 Oct 2024 16:55:39 +0800
Message-Id: <20241029085542.30541-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In the section "4.7 Precise effects on interrupt-pending bits"
of the RISC-V AIA specification defines that:

"If the source mode is Level1 or Level0 and the interrupt domain
is configured in MSI delivery mode (domaincfg.DM = 1):
The pending bit is cleared whenever the rectified input value is
low, when the interrupt is forwarded by MSI, or by a relevant
write to an in_clrip register or to clripnum."

Update the aplic_write_pending() to match the spec.

Fixes: d8dd9f113e16 ("RISC-V: KVM: Fix APLIC setipnum_le/be write emulation")
Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Vincent Chen <vincent.chen@sifive.com>
---
v2;
- add fixes tag (Anup)
- follow the suggestion from Anup
---
 arch/riscv/kvm/aia_aplic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/aia_aplic.c b/arch/riscv/kvm/aia_aplic.c
index da6ff1bade0d..f59d1c0c8c43 100644
--- a/arch/riscv/kvm/aia_aplic.c
+++ b/arch/riscv/kvm/aia_aplic.c
@@ -143,7 +143,7 @@ static void aplic_write_pending(struct aplic *aplic, u32 irq, bool pending)
 	if (sm == APLIC_SOURCECFG_SM_LEVEL_HIGH ||
 	    sm == APLIC_SOURCECFG_SM_LEVEL_LOW) {
 		if (!pending)
-			goto skip_write_pending;
+			goto noskip_write_pending;
 		if ((irqd->state & APLIC_IRQ_STATE_INPUT) &&
 		    sm == APLIC_SOURCECFG_SM_LEVEL_LOW)
 			goto skip_write_pending;
@@ -152,6 +152,7 @@ static void aplic_write_pending(struct aplic *aplic, u32 irq, bool pending)
 			goto skip_write_pending;
 	}
 
+noskip_write_pending:
 	if (pending)
 		irqd->state |= APLIC_IRQ_STATE_PENDING;
 	else
-- 
2.17.1


