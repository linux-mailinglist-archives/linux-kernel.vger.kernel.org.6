Return-Path: <linux-kernel+bounces-405719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDD29C5838
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9064B349D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6677E215C42;
	Tue, 12 Nov 2024 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ul1n2rFb"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A15D2139AF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409003; cv=none; b=AguYkvAZFkKkY01hMCqSMxEWvim0jd8ziP543hLPzcG0jVW+b0ede3mjX20wnF6QA74oxl/aC4aCE10rXEBfQ5BW4WNJkyU8BTRTq1sGRp3j0psSYbq3ionEb4WH8if0pAgnxRcQY4O1k3ZJcpGSQ0Jq5M4046ah7pzEPT1+Wt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409003; c=relaxed/simple;
	bh=JZxAEgGxHQWBt6q+QSSE/uiFAiC7QtIJ1zAHsyKz/F8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jpm9rDdw9HiJB6u3iXCaTnDB8+c8joBV6ll4gpoLDOEd1HV0kd6bTONbFtH7lgEOTOVmMNQ0OWOx9TzB/SBwRpEy+S5fgx6638GrtDYogJC6KgrCM1duq+yJXAZ4IqnPGyW2c0O/QrJ40ipSkKSFmJxeOOambTxvAjfD99F1nLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ul1n2rFb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso45675215e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731408999; x=1732013799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SUZb9Z1/W7ca2STbTF5/tGFSoH8Cx+ksuikIOfGFMUI=;
        b=Ul1n2rFbKAKXuugOk982oy8PQNh5cydFaE3XUKSH8kN4qg08KofsAkDQ7HSm+U/v6N
         W41R+ZDBlGer1Ef9pltoelzSqIxGA1khzx+8eWqQnehR666HrT+xhMuPj9zl0cBtGxF0
         cX8Fr0Vl3aCekzaEq/qZB4+XnetVekIw9ybGIni1FOD4KvNGRulV73yXGd0QWgATqiuW
         fbaivbmmlH4GAHUF3PMBi9tFH2/IqjD3VhuUBE/KbtjQF2TW0ZX8In6L4a/NzMoUXG/D
         gJMYYQVwgX0uD9dZLCZYOeecj+IaZ1mDZoupOvuhBOKVLgR6KlaWz09TwKulM16BKJIu
         SNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731408999; x=1732013799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SUZb9Z1/W7ca2STbTF5/tGFSoH8Cx+ksuikIOfGFMUI=;
        b=h0DuvgZ5uUjxY5WZ/VNMBFFcJiEwPpbjyQrkqxdjlaObs+sy3LpOfC5s419kymBVcw
         WA+Jb/jEelMhZPT+xi37VItJE06Rj79GN1dxNt0lRAouQrl/zeeiMI6Wf/mQj+3nZGU0
         92mTdIYe1KTk8ialjAWfp7zNkLdcyMEl0Nh8t8BlfCP6u0uxGaQ34vEcGjfMQCiQbxef
         a/84BuK0VyAc00kbpMyrmgaxoMXlIBUiSOB6xT/AQ02AnbQg7ufib+Txpb0oyylM084e
         Yx9EAjttZf/DKqIJlckLIzgQJI2fh3aDhn+UF0FJ1COek0xznBTS8judC8kEiYKO6XgJ
         lwGw==
X-Forwarded-Encrypted: i=1; AJvYcCVGMva4IHfYckQHsQP3zIdo+TcnsAQ9uJRDUZ/kzDLuDGEMFax2Cx2sYDAGODImzIJSiGd3GSszZDWA/qE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmBHALndDtDWsjwNMREpSYSv75smYt3vJHQQ/6R5SasE0d2JIb
	SOwr4ZDbzzRrIbsDOxfSQpwDL8/1ZFmhZBdfmnQ8wg+yUtE+hGx4g7QfRJXSO2g=
X-Google-Smtp-Source: AGHT+IHvq8za4ODwagi9eMCX58JHSHwa35A0vD53q9ShdqUM3Ry91k3zNmwqMO4C+mOEfDBMTSJnrw==
X-Received: by 2002:a05:6000:2a88:b0:381:f443:21bf with SMTP id ffacd0b85a97d-381f4432609mr10071022f8f.2.1731408999580;
        Tue, 12 Nov 2024 02:56:39 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed970fb7sm14943629f8f.21.2024.11.12.02.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 02:56:39 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: tabba@google.com,
	maz@kernel.org,
	kvmarm@lists.linux.dev,
	oliver.upton@linux.dev
Cc: James Clark <james.clark@linaro.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	=?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm64: Pass on SVE mapping failures
Date: Tue, 12 Nov 2024 10:56:03 +0000
Message-Id: <20241112105604.795809-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function can fail but its return value isn't passed onto the
caller. Presumably this could result in a broken state.

Fixes: 66d5b53e20a6 ("KVM: arm64: Allocate memory mapped at hyp for host sve state in pKVM")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/kvm/hyp/nvhe/setup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 8fec099c2775..cbdd18cd3f98 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -146,8 +146,7 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 			return ret;
 	}
 
-	pkvm_create_host_sve_mappings();
-	return 0;
+	return pkvm_create_host_sve_mappings();
 }
 
 static void update_nvhe_init_params(void)
-- 
2.34.1


