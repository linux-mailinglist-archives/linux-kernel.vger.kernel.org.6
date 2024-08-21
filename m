Return-Path: <linux-kernel+bounces-295108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F029596E5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0281C20358
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E041A7AC2;
	Wed, 21 Aug 2024 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GLUuoRwc"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5623E199FA3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228394; cv=none; b=k3TGwqsbPBNuv1yK21/O1+jizQUA0K3exUBcuVGBfA3IYAEyrFonyLnUhiUMG3urNxne2rZsUXVTzlf5tMUECtxz5QzaJIbWCS3FX+GjX0u7vZ27C37dUqBpbb+TVEkHDd9vWaTydFu8p1vzUZd4PjZM9cu6wEu/jEHdazXFFj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228394; c=relaxed/simple;
	bh=e1tBcpkPCPYCjJVE5fYukBveVHFGvsGMgvqtXeHa2/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o2NGZKhfJuWr2ZY9G8qpYmZtyWHuYlRcigQlqHspEKa3cSeFXBdCMbK5lpXr6WHKDCUOwQNpv8lpKv3bo7TRxD/6QGv1CRVkQHRWH1yJz/Dl304Xz53JzfSG3rsvTxpGa3Sovync3I2lN0p0+tTnSm6oRl0cK8SCHcppVFJf0JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GLUuoRwc; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d41b082ab8so2511403a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724228392; x=1724833192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHfDnFSOmlgsN5ypR9SiqdvWOZgzK74sPfUFdgGElDM=;
        b=GLUuoRwcR8/rzdEMCh8SCEAyaQaHQbCttJqbwM4neB3yQKsX6XVasXn5WQGXV8yEbl
         gFdhC66Ac5sG5hutzdKySwUtGzpxiAEbnHv/HgLFvIcT29jCobQ8tVZ3MeEvMMV548nY
         sh9KwbxkPDmNCXqkIc9EQow3skmuPHW9142r53eBBT7+L7G96YUNcEbQCsSuAudH18q/
         PqN2Sqskvq2ctCeEQTlYi17bU/8W4atHRCbh92iLkDqOh1cLY3INGrpgHDp0Lf01NHyS
         m9NYDPhomB6h3suTE/XuiO2hhe7/KABYT/jdnmeTEzTbxQqPCXaNcGNepdA5wxXKOiRm
         tpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228392; x=1724833192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHfDnFSOmlgsN5ypR9SiqdvWOZgzK74sPfUFdgGElDM=;
        b=Ya+gvSmWV8jvSDtgDzmT3+oGj+ocZwrBr9e3cB5lCHiqj4+067BmGR5IqqMEiq1Mja
         MZ2AR92X9I6AteDDyFXzcfxN1wik2fbVnOjTsyu9GT5ZKPZBDgbApc/T6I2w9wcM9fL1
         WpqkWu7Ir5f3NGrAo8elNhmWE2+TOspeXM0rvHLcBCKNIrLCVRk3NM2qw+Q+CqI5bCDQ
         F0uA6SY7PWnV7lI+8akeNnEjJBfJ72LqRfDISRD0p9bwjRXQSpj0w7cPks/STrlmpysH
         Btz3cLpGUnNxK7n3hPbAFwSe0H0nsdmijeP/X11zFQGtY7T/0rAWLBsfi5I+ZFN4ysAl
         Rc/w==
X-Gm-Message-State: AOJu0YyKl5KJ/tydAuXXlZa2lqb2zGlgyZdOKEt1PfnQnTKCezuSfVJt
	5oQgVEiUO/A0EPFCM1ihzlVuW7IqgG6aqo/BlrJflso9OSUOFWMTUA5TTKxXx/c=
X-Google-Smtp-Source: AGHT+IEDKdhDrkAt8Xw9HjhxvAn16yLBj0ykk9gzeBgjUCoqqbqdejlnt+3gntiVrRuxkT/2XR+s6w==
X-Received: by 2002:a17:90a:d98e:b0:2c2:c149:ca4 with SMTP id 98e67ed59e1d1-2d5eaa9d141mr1321075a91.43.1724228392525;
        Wed, 21 Aug 2024 01:19:52 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb9049b0sm1091453a91.17.2024.08.21.01.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:19:52 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	vishal.moola@gmail.com,
	peterx@redhat.com,
	ryan.roberts@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 04/14] mm: filemap: filemap_fault_recheck_pte_none() use pte_offset_map_readonly_nolock()
Date: Wed, 21 Aug 2024 16:18:47 +0800
Message-Id: <c1dbbc9022c9d8d4736d1751678076a2afa1366f.1724226076.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1724226076.git.zhengqi.arch@bytedance.com>
References: <cover.1724226076.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In filemap_fault_recheck_pte_none(), we just do pte_none() check, so
convert it to using pte_offset_map_readonly_nolock().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/filemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d87c858465962..491eb92d6db1f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3228,8 +3228,8 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
 	if (!(vmf->flags & FAULT_FLAG_ORIG_PTE_VALID))
 		return 0;
 
-	ptep = pte_offset_map_nolock(vma->vm_mm, vmf->pmd, vmf->address,
-				     &vmf->ptl);
+	ptep = pte_offset_map_readonly_nolock(vma->vm_mm, vmf->pmd,
+					      vmf->address, &vmf->ptl);
 	if (unlikely(!ptep))
 		return VM_FAULT_NOPAGE;
 
-- 
2.20.1


