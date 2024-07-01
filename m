Return-Path: <linux-kernel+bounces-235859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0AE91DA7D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 656C4B225EF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE34414BF8F;
	Mon,  1 Jul 2024 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="V+qLUZ4G"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD13214B95A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823717; cv=none; b=pxXF+M6pj0xnWAUEAMehfXcZvL6unQ9kyCSFGs+t7n2bH3VTjv5KsFqVgxRL1aMJQWPTg/5/RsgXmDyv5ii+mwmZ8QtLZyTKlCAditMqU7FO6pyPTMD0eH7vLSk2eZCowQadz0gEnqUQmh0szodnJw08CaT7IrE6Nwo0FBqBQ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823717; c=relaxed/simple;
	bh=fcyiPkvEEKdWecEuJOIrUfCCsRSKdwvcoilRZcmvGGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V64rj+Y6kUd/cXr1cb8KZKUb1DF7s+WJQitoLcWlirPcxReCcPibX/8Pd2ASsEtWcTVM9vrEhWt+oBomaXc3KQwkAsG9XTDDOz4RgzIyNjcdkA14h6eqRB9nz7hUTcIRlniBH9LaH02zd2osGgC+rRcc15qunbZGvpYtpFG5tJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=V+qLUZ4G; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-25cd49906aeso382642fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719823715; x=1720428515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StMJ2RtFXCKaoVJqaHkGOtRFp2kjcwvK/9x07Wn8pQQ=;
        b=V+qLUZ4GIIrF45F6iucTWm5GCtC3/JlaRVHJV1mluKhVd3fH9gOzvL5rd4ib8DKX7L
         ExYdNg9vjeOteHZM4NZwnx4kDVY7LKpHedblkfyAhuqTduhUvhbLQ+aTN1zpDuIRo1Ma
         As8MZsThRMwALvnMcQ89JK2xiDKkMNkIi47mT0b1hH1ADKKgZWRyyVtLppwan9rL+oCh
         mVCb65Brq4oVsshm4bk6RWTPwcqPLiR6dOa1QzbRuA1EIolPOiXu/SiezFcZZfAVHXaK
         1bQVcYIg55vO0om8sSbNtycD9MtR3IJ+hDQls0zhX/yMdXro4aVMGYmItwB0OHYgtvQf
         A0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823715; x=1720428515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StMJ2RtFXCKaoVJqaHkGOtRFp2kjcwvK/9x07Wn8pQQ=;
        b=qaXsqrErUY+lszf7F8BjztIQps29Zq9XvNqcY92uJyHIRySwyrXCFlElKg8ieD7Slq
         EFKZj8UOSZT5nHpsWigGPnSpammhWxNaiEqiXPDS0ntrS6TAvZ+ynNu7F7oBn/F/rDt6
         rNLaAFrIyt9PTn9wpNOEbk8cYuxmD9Vfc+jlhVjDKgSstPFBildxla3VK3eprqBKJeKu
         mBhI/o4Wr2vg1ONwiAW5m59OLRLrEAAfCi5qewIX2bHtu3d3vMPbKQYshG8DYnHBWP/+
         707aFT+r/sKTYkafqMSrVJJLsReOMsIvg5ZXSIMVRMGkhQWINbYAiNplucAUAOEWUoLe
         uZjw==
X-Forwarded-Encrypted: i=1; AJvYcCUaDMVhTx221eQhQwQiwVjbyf+pAbeKSeVWe0DsNzPD1luemE92fzk2NrBjYP8wfaeWK6H9q39SyDMFr0ARqrLW8YK4YqaRFpuRHjrv
X-Gm-Message-State: AOJu0YwGSgALiMZQeXNCqTvfiySipcm4nbjqLTDjyOj40rvjQT2qv2PI
	amhTUDZ1CLkTaUCZRv9HcUtDKdFL39ROucdSar0uB647B0dVEO9mI2kC5kYshpU=
X-Google-Smtp-Source: AGHT+IFE3dKI9Tgl7EIyomU4IdVHY+PmwvfXhSbglMPZKAPvgX4/lADNKj6dPhxAruv+7V80kKXCBw==
X-Received: by 2002:a05:6808:1a2a:b0:3d5:65c7:c26c with SMTP id 5614622812f47-3d6b549a9fcmr5659724b6e.4.1719823714723;
        Mon, 01 Jul 2024 01:48:34 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a7e7e0sm5932374b3a.204.2024.07.01.01.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 01:48:34 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 7/7] x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64
Date: Mon,  1 Jul 2024 16:46:48 +0800
Message-Id: <0f3aacc9707da962398de71c127e7771c6798062.1719570849.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1719570849.git.zhengqi.arch@bytedance.com>
References: <cover.1719570849.git.zhengqi.arch@bytedance.com>
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
index cbe5fac4b9dd..23ccd7c30adc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -313,6 +313,7 @@ config X86
 	select FUNCTION_ALIGNMENT_4B
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
+	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
 
 config INSTRUCTION_DECODER
 	def_bool y
-- 
2.20.1


