Return-Path: <linux-kernel+bounces-257463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D6D937A72
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9390BB217C2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3141487E3;
	Fri, 19 Jul 2024 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="PBL5/cXy"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22C7146583
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405388; cv=none; b=c+DdnQ5U5VRcGd6812DJg2Hlr7e85C0N4ojs1LDkI8Ud/37bKpRL4wHV7Kn+A1SJqIg/6wT2c4yu10XbjsF+gqNWDC5CsEWE2F6Rzorvq5OwDasW/4fVgN/GyQk7leBNYXH5+DXybl7lGTYD4i1KyUABPnQOnelXZBvcqRAA9lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405388; c=relaxed/simple;
	bh=CayvJpwqAvJdfQdSd2Y5GdFSxQA0Pu7twwYIv0jlrp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fVCtxVTqsJYjdWPOmrdWLZM2a0T0S8Xnyngxxp/ccnM9rfRj/r7E88+jFNQ4bJ9fuLbbLwooHvsOrruAf1T4S7Ep1RG7pYGD3BTl6xp0ELX2Xz0EH0bPDvA3qt0QjADxxY9p5v923r/FH4P91r9N4ER7bNfsSgyZFQ8zShL2TBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=PBL5/cXy; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc587361b6so20373525ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721405386; x=1722010186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvm3hpKvRW81Dir7XpGK5V4AZ1ZJAiyVeCH2mMtrPq8=;
        b=PBL5/cXyoJdgHAe1hd1FdcVUlVH7rxUpcu2w3RoG00+yF08qmh+ijS57I48AgHAvJ/
         5ROcpbyXyZeBLByCvMyzQDv3rF0xcDryRvgX2bgE+160GRKUJlUwnFmE2/50+GMDVcOb
         OI94QjJirW84Hv1ppslMcoHUp9NHF5J77DT2OfYaC+3bwVUeWpXkR89s0AY6OgxIQCo3
         Zv01ur/1PqkQsH+MCfBnOzubLlQTkyXzDBZtzOGRgKjXGGnBZkdsw0CnMHwKnuqDpPv1
         35woNReeoSZLGPPZyqEwRiOzRc0ycrfYDq9t3+nXLjLG8yUEWNsxV5uXpZ982Vi86x4r
         n03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721405386; x=1722010186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvm3hpKvRW81Dir7XpGK5V4AZ1ZJAiyVeCH2mMtrPq8=;
        b=PYR3jJ+0sUmMqWWCj9SCBj62X4+DwgbKdjKZgqk8Ng2Qcqi6lK4Z1QCvSJJx868BKb
         2+p/3dCEkMt7BnuZ6nBxT/RlpGS7v7zZR5XpGEYcNtecld8Bcn6cccnXVbtkQ6pWh20l
         nlriKgFXg7vs+xZt/55MC6GJZbSwwhR9u477zUeC5rKqm4x/3xu/14jkSKX5C7Zcx2Mr
         k5bQ9oCDqfcqp39vsYQpstmTiihLHFGaBWHpb4Mmoy+7A/qsgQ/ThhtYwG5Nt/V1ia7o
         spka19yYBNKtDU7QpaClEW1YFCJqILFts8xX0Od2GfIgsOihZDIGFKnZZuVbtenN3TMV
         SkiA==
X-Forwarded-Encrypted: i=1; AJvYcCX/r0AstOrkG06wBo8T/x+ZVQVHS3PhmGeLwz+u91ebMRZMlHmk/u8F44gLAQqRnFRLZmWj3bGx48bYwS1yuYZdlzfzqIKQ6sRC1xtn
X-Gm-Message-State: AOJu0YyHs92/T9A+g7B8vYUbcKOce8iK2Tj+XdVuv4illUteWx2CpXbc
	kWXRKbKNenmc6F1zJ3xcSEtvYMwGw0V88l65BhShsG7jBvESR9nbiVujS6NDWaM=
X-Google-Smtp-Source: AGHT+IHTBp6zlsH1hrlMfviNDvDhBwVMm6bPyuRntoKMRuaLAxmrocV1MrWIWDQcyMq9zx2+n0JCxw==
X-Received: by 2002:a17:902:dac8:b0:1fc:5e18:f369 with SMTP id d9443c01a7336-1fd7459dd67mr3483245ad.23.1721405385835;
        Fri, 19 Jul 2024 09:09:45 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([223.185.135.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f28f518sm6632615ad.69.2024.07.19.09.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 09:09:45 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 06/13] RISC-V: KVM: Don't setup SGEI for zero guest external interrupts
Date: Fri, 19 Jul 2024 21:39:06 +0530
Message-Id: <20240719160913.342027-7-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240719160913.342027-1-apatel@ventanamicro.com>
References: <20240719160913.342027-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No need to setup SGEI local interrupt when there are zero guest
external interrupts (i.e. zero HW IMSIC guest files).

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/kvm/aia.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index 17ae4a7c0e94..8ffae0330c89 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -499,6 +499,10 @@ static int aia_hgei_init(void)
 			hgctrl->free_bitmap = 0;
 	}
 
+	/* Skip SGEI interrupt setup for zero guest external interrupts */
+	if (!kvm_riscv_aia_nr_hgei)
+		goto skip_sgei_interrupt;
+
 	/* Find INTC irq domain */
 	domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(),
 					  DOMAIN_BUS_ANY);
@@ -522,11 +526,16 @@ static int aia_hgei_init(void)
 		return rc;
 	}
 
+skip_sgei_interrupt:
 	return 0;
 }
 
 static void aia_hgei_exit(void)
 {
+	/* Do nothing for zero guest external interrupts */
+	if (!kvm_riscv_aia_nr_hgei)
+		return;
+
 	/* Free per-CPU SGEI interrupt */
 	free_percpu_irq(hgei_parent_irq, &aia_hgei);
 }
-- 
2.34.1


