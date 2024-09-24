Return-Path: <linux-kernel+bounces-337316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C11984892
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25CA1F23321
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A361114F124;
	Tue, 24 Sep 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UC/VVmfH"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74E21E48A
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191460; cv=none; b=uFCuSPXhpU1HQ7prxGMPqW1jTbBwVx/unJFzhV7DmDVOYzMvm3947sxgbBKeua+F7XVh+vSFX7cj7V2ptlt0/fEWbrgK2V/gpvAYkeuEt53twP/HnSNdQKZwNPPcCUnognj38+mh2A+5jJXRju/DqJt7YUJ2I5Zwf+TsfLNZrg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191460; c=relaxed/simple;
	bh=cdd5jN0jnCc5Ky498Zgu/Qa0AFodKh648VPS/8simY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oIGhHXDZR8D2e5o2hmcNr7/KxpLaa4eugZEtBOKSgkmS1mBzADwWKtCxukvnFrkO1zCZ+CroeFQLcn4tW6lgwoqked/r1t/ZMfpifg0DnJ8MQowU/zX/NNvXPVWqNXsNezFInZGmBoq+AAyzMCKD3IA9BcVVshaK6WmNaxKyHG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UC/VVmfH; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7db238d07b3so4671205a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727191458; x=1727796258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=la0ROZ6/ROeYOykkGeLPqwIMsRkFKLZV+1MUFm5Ngpg=;
        b=UC/VVmfH9LMikvecN/MTbtG+oIoLnpac02sFA3uaD8XQbq5oEr8Bsc39J7e00wOh5g
         IqeV+Ab013BfWLZsdsi7SOn0PXkV6fQEDKJfDW8OHON/e8ozrkHc41mUZRVfygb5L2tD
         HiA1NXbo3bkTDtr2NxhBb8/JhGgtHo2bbPfFI52rGz9gF1TqwqC8RpIwWQh71BHJ5IWB
         MX6R0VoQysKtBVc2OrkDO1WBxHnDdKVsiNuPFGQCXhc814MBC9OPbJeFlNdPBYlXeXTF
         wicaVd3mrgfIVVeNbjbFiXP8uAubgmzCEY9s1a0xIClG+PjoM5x8sCnq6b2z8sNw1dRp
         fYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727191458; x=1727796258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=la0ROZ6/ROeYOykkGeLPqwIMsRkFKLZV+1MUFm5Ngpg=;
        b=ezF/s1JuWH3kZi5FnmNWMM1CmOq2CkNsJvl52HbRapdNMH8FtEIJuNg6uHDte93WEd
         r+2kZyZqzAB53T4aT1A55wSO0+HIshG5JYbPpEc4AAe91wqgJFr8IxFHF/qYqMo4v8Vp
         tyH07Muw8El3m05xYFyLENkcvX0S7Exw2Rr513PHsERcHPsldEUg+1uPjQWB7m7esfuO
         tQjjuJaO/eB1p0FvPixEv98OmB2CAzhznPkXFESyFvjCVQVDeJDT13P+fhcDAcUfMZiq
         s7NVwYSbevKnJVa/p0DXxyfhZI5k3VF8Zo7AoN5A42CpMCwx+3pWb3wb04lli2JWbTCR
         ssdw==
X-Forwarded-Encrypted: i=1; AJvYcCVBvHWQyx7ElxGqXb2BT3VIQRtIs3I4UJWK9qu66ERmazL1pgwPEuXBdaNU6pyUMqXALXlv5waQCMOUMks=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAevsYhic4FbzLm+R/6X7QHx7PWhCtW75zIFnKMSlKa2dX/Bfj
	rdA5EgVPHBsQKGPNKj6DATG0T++I6HdGv3H51+RDO4eWZwL/BROQRpyftWqj
X-Google-Smtp-Source: AGHT+IHw83MgUKtNB8fNWt4xWczMydRc1gN5hT9ACxNBnnkKpPWg0LENAkKx30iyWi1AqvdwtH3suQ==
X-Received: by 2002:a05:6300:668c:b0:1d2:e9e8:5e78 with SMTP id adf61e73a8af0-1d30ca3d870mr22064471637.23.1727191457860;
        Tue, 24 Sep 2024 08:24:17 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9c6b8bsm1319675b3a.197.2024.09.24.08.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 08:24:16 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: dennis@kernel.org,
	tj@kernel.org,
	cl@linux.com
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] mm: percpu: fix typo to pcpu_alloc_noprof() description
Date: Wed, 25 Sep 2024 00:24:12 +0900
Message-Id: <20240924152412.118487-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the previous commit, the function name was changed from pcpu_alloc to 
pcpu_alloc_noprof , but the function description was not changed accordingly.
The function name should be changed to pcpu_alloc_noprof in the description
as well.

Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 mm/percpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 20d91af8c033..7081b0ed59d6 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1726,7 +1726,7 @@ static void pcpu_alloc_tag_free_hook(struct pcpu_chunk *chunk, int off, size_t s
 #endif
 
 /**
- * pcpu_alloc - the percpu allocator
+ * pcpu_alloc_noprof - the percpu allocator
  * @size: size of area to allocate in bytes
  * @align: alignment of area (max PAGE_SIZE)
  * @reserved: allocate from the reserved chunk if available
--

