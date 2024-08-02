Return-Path: <linux-kernel+bounces-272764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7609460B3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 066EDB247F3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDA01537DF;
	Fri,  2 Aug 2024 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYwOpl5k"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C53136347
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613397; cv=none; b=mXp8x0lhqgRqzZOq5bjguTYW958W+omy4AXqc972Jf7mVMkvGhN9Ag+7J3xgNT0SZtHAQG+nlPWpCXGTn0DESQBEJM6aOOiMB7JTrOqlUExgmGZ0jO5mw2V4YcQqjWdD/ZCH63JIe1ml22va9IRE8TErwip5Y+eiD7WMLSWea38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613397; c=relaxed/simple;
	bh=EqR/rpz7oq9VBrXSHcKnBUykK+vFbaFRYtpsnhSlSw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GW6mdQsiQxGYjPThnPE148h6bMTu3dgztS38rEWgCoNDWsUOC7HaeOfFMdWItQ+4b3Gi5A2hwcklPB6//RQqH1Ue5m1PxNabfaE5NW/Hi0kNkzEUhacQcL9aBRbb3OKfKDz+WYnmbLh4DxXPtJVxGtNm/+veD8gMONfxyU8aoRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYwOpl5k; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef248ab2aeso119349611fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 08:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722613394; x=1723218194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFNIYIFjB2AmuXlLvStwmFyqpy3qX3Ss144m6qc6S24=;
        b=gYwOpl5kvIlMaSMUv3DBJujH1p1na0D3GTBRqwoHQuCzncLk79pl0mbBSayj7vk082
         hnmV/vroo2Oz33vSiHWBqqsPoV/qJHs221Exa9UitKDb445LSfa4GHvQrzxLu8pEprEX
         udAGnd+sOAVs81F32Ul7Pj0gb9Bw+7hx0GL0g5+gI/42cUvpbMVTSozPAGlK5Ai5qkwP
         LjBTO3kkYyE2Oc2lzbbHW9zzwOxAnHAtL/+vo9bziJnmUo9qP79LoEGlG0SXxDVertH7
         4plQr+rlgWh2gFKd9fjzbD9vEEKq3JUTA1Y408NCt0QKWYFn8sird/DK8KfFEoWh7CAY
         DV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722613394; x=1723218194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFNIYIFjB2AmuXlLvStwmFyqpy3qX3Ss144m6qc6S24=;
        b=VwDtqfdufx0h2YbQ6dWNha5ejeZooDHE4fxR5lgdAI5059zR1vgGMN6Qj1fJSHtcNc
         P8pOWTLs5uxsx3qwj4WJrpy6epJToPm2J4+2vF66C1IWwHUkSH7OcUDatSA2pkzTSKDn
         CMApF12A/fk4cGH0ogDkMcdaG1gOrNn6K6QoYZVUj/A5h2Rp9tLMHYwl03uI2+ZEQQ2o
         FIUaEseFWE1OgI/5M+95nsrrmNXeUu45Z1CycGltZuYCkvfdxMxAbmJVn2I3xSMJ/41K
         Wj4CuhQdaeHrhiar+KswpSuEkZmzdSPfs4ncf3xRAGKkUrxh8LhZtU8YQcBJDX4NqUcq
         n0mg==
X-Forwarded-Encrypted: i=1; AJvYcCWRzYIDM4u1LIDuwFQp66FezYPG3eTeBpfqCd6N09WpS+xJV2kX1d+PWMYTQoL2ivLYdiCJ5l+gOhVXydB4wo38NCD/UDBlpz1sayai
X-Gm-Message-State: AOJu0YyfLSyy9VthtKHozbAqsXWiNmosvofawaIQXC4RJzGMqh9YPjzw
	vqZLXTh3aDj5fV8nMLhfbOBBiTDDj9l7nYixkpyqmQUMVB2flo6JkEYm
X-Google-Smtp-Source: AGHT+IEoOp83pcnug4N7zz4X2qV6bxZ1iAtTPT44ohiy01gk4yP+9/2CUySCVksWSGpAEUg57OGFBg==
X-Received: by 2002:a2e:964a:0:b0:2ef:2c86:4d49 with SMTP id 38308e7fff4ca-2f15aac460fmr33456361fa.22.1722613393804;
        Fri, 02 Aug 2024 08:43:13 -0700 (PDT)
Received: from p183.Dlink ([46.53.254.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b723e6dsm1239492a12.65.2024.08.02.08.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 08:43:13 -0700 (PDT)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: jgross@suse.com,
	boris.ostrovsky@oracle.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: adobriyan@gmail.com,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	hpa@zytor.com
Subject: [PATCH 3/3] xen, pvh: fix unbootable VMs by inlining memset() in xen_prepare_pvh()
Date: Fri,  2 Aug 2024 18:42:53 +0300
Message-ID: <20240802154253.482658-3-adobriyan@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240802154253.482658-1-adobriyan@gmail.com>
References: <20240802154253.482658-1-adobriyan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If this memset() is not inlined than PVH early boot code can call
into KASAN-instrumented memset() which results in unbootable VMs.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 arch/x86/platform/pvh/enlighten.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/pvh/enlighten.c b/arch/x86/platform/pvh/enlighten.c
index 944e0290f2c0..2263885d16ba 100644
--- a/arch/x86/platform/pvh/enlighten.c
+++ b/arch/x86/platform/pvh/enlighten.c
@@ -130,7 +130,11 @@ void __init xen_prepare_pvh(void)
 		BUG();
 	}
 
-	memset(&pvh_bootparams, 0, sizeof(pvh_bootparams));
+	/*
+	 * This must not compile to "call memset" because memset() may be
+	 * instrumented.
+	 */
+	__builtin_memset(&pvh_bootparams, 0, sizeof(pvh_bootparams));
 
 	hypervisor_specific_init(xen_guest);
 
-- 
2.45.0


