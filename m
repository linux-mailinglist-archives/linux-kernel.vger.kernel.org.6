Return-Path: <linux-kernel+bounces-390153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B418B9B762A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688CB1F220C0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799A5193409;
	Thu, 31 Oct 2024 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aORo0tZO"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C48516DEA7
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362493; cv=none; b=GqF5FHV5cXEO49eBlnFwv+sIsJUVAjIGMxs/ginZL3deri3c3saLbiDePLFs2YQ/fzq+6sJ44tq5QL6Xes+hQwBreSF9CjuVjtTu4OCWrWYDAA7496REacUrc9W5SrDhc8UH8Ptm2cSEj4uRacoQ4fv45KKs14ynIvsYiytRBCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362493; c=relaxed/simple;
	bh=Z3NAs2nRWoVvOWIh+RmFbHZzRV4WWeH50tMnPn/TZrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QbSCIgJ7IYxUEN2OGZA+0x0QZpT0lmH1iBDoH7RLUrSODaEn+x7p4m1hz6AIhdF97C7NdFuqVQhNe8OkfcbD4avnsho3NaRE60diSxJHjd40ZcQEMTN7AFbnJFAMdF1FBdme9xsSuYtD7OjoKlfGQhp37UqcdSfaGWdSMypG1bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aORo0tZO; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e56df894d4so500851a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730362491; x=1730967291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWdHYUgzbXn/U7M7SYCKm/NpDuEpbf7wkXka4/ylaW0=;
        b=aORo0tZOIlzY/DypYpSo7znigYmK17bi0nAr2RtUEDvE7FbJq5VmtYtwKnYTNXndt8
         vbkQgNgAasPRaehCVhDQ/g4XtZ1+oPKUaDu96dqNH26GpEXidMiJGdDnOeQ11B14w7ex
         AU5mbsTnGolLR/GR5laGttSUF0GXPe0svVhotXJGIpyOD+LiYJRPa5AOKkHpvrt3E+Tw
         GBnMu84Ekx07YGdK5TJf2YVGQrH6NSrWXjLU3LVgEdeP4bUm1LgU/gRnGGA6rK/0NIda
         Os1Szpkd3mLaE/Wu8jFPc4NIkSPUy4uyExcvn8Q2cUyO/pPQteL93q1Jf0MV+pVYFL5t
         iO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730362491; x=1730967291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWdHYUgzbXn/U7M7SYCKm/NpDuEpbf7wkXka4/ylaW0=;
        b=eZ5gTpovJTsM1GLZQn3PDsuiJ8wNKETxmQVCLey23oYZkiTBEv0ComJmhqT0ztw5Qx
         lQ4otmx1EZ9BW/ek7CyxOPI9v/52LtItaaXBhPwQNYdyEc0mo43yYlrvj40EEsFSG+90
         HY6OTFOrsBt1NI0x3vXAmKsnVrKHX7GbWDe3TSOtvKQImCDvpyiAjDU2gLe5wcImaaeh
         Cw9O2CbVJnUYnciHAPboMBLKU1Xpi8Op5GyyCeRLqQe39zvwZ/uCozVeRwHCRI3VUhvF
         zPMilgm7OVagZvXPAiz6wBtNonRI2fKx4+xwtGPi4w3abCKZ/Aerhqj+DD/AuFYJI3jl
         Qsgw==
X-Forwarded-Encrypted: i=1; AJvYcCU4h/omnC6Nq5CiQue+MGH0W+FEUhyK6sHo6SZLyMu9N7L2gmNz0n8Jk3rd49WQyglKn5CtnK/jn0ikXac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfGgbFEgTF2Ds5tg2o18doquU8OTrpoGJZl/KGJts++qlH0b8q
	X7n9GQUMpg7UVg5eL8D0J508SvBw4Ck7YPDWlgWUk7NAjt12v9sHh94eXOrHNiQ=
X-Google-Smtp-Source: AGHT+IE3rqtNftE0bEC7q6UBe3srVwCXipxTTFqti2PirnO+trKsr5sr4dmd4R0xR3d7wiAw+7f4XQ==
X-Received: by 2002:a17:90b:52c8:b0:2e2:a013:859a with SMTP id 98e67ed59e1d1-2e93c128a9cmr2763869a91.7.1730362491551;
        Thu, 31 Oct 2024 01:14:51 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9201b2586sm5163996a91.0.2024.10.31.01.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 01:14:51 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com,
	peterx@redhat.com,
	catalin.marinas@arm.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 7/7] x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64
Date: Thu, 31 Oct 2024 16:13:23 +0800
Message-Id: <8ed7cdb1e5fa5e0a357bec9178b8932d596573c9.1730360798.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1730360798.git.zhengqi.arch@bytedance.com>
References: <cover.1730360798.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, x86 has fully supported the CONFIG_PT_RECLAIM feature, and
reclaiming PTE pages is profitable only on 64-bit systems, so select
ARCH_SUPPORTS_PT_RECLAIM if X86_64.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1d194fb2f979e..194baed21ae5c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -320,6 +320,7 @@ config X86
 	select FUNCTION_ALIGNMENT_4B
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
+	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
 
 config INSTRUCTION_DECODER
 	def_bool y
-- 
2.20.1


