Return-Path: <linux-kernel+bounces-210052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E147C903E8B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6BA281A47
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B5417C9EF;
	Tue, 11 Jun 2024 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RjPZV+j8"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76747AD2C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718115538; cv=none; b=I0jsQQT70HG5K5ODJQMa3DrZlsQE6Yt0SGCYr/GppC3r22VqE0HgGfvxWa0jnHOOFD2LYColuCE+mA9exoARCfGHy4WrpevaA2jBg/M2LZa/gHt0/lNR4ncnu48sYFRikTBJuiDt66aJr2SR3WvmP4CXUQ5tmXe2U6Tkyaa7hic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718115538; c=relaxed/simple;
	bh=48A12XiAizf5ivaXm/ItCX5v43URFWgNq24bhnS1Hk0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DIEyNGYIuStb1Q4Ez6lnfYXCXS8bwwNOsyZ+jjp/2OCCZLnTFYnBU4C2FPbZDz7C4wvNqHbHHG8NHA3k/ZTCiTPF01R09QTMVgSaWoWQjoaack6yZ/so72IDcdv51RKyIhslOXtkJudsCSO0jETwSJhVzuWXzA5iP1rbSFPCPXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RjPZV+j8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70423e8e6c9so2699728b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718115536; x=1718720336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U+svzFPv09IAh78MJbo2+Q8Ke4k/S7OCitpiigdrQT0=;
        b=RjPZV+j8DxFbf00BwHKEqG92GtPLpgDbldsD2bWzpa2AjAutjRdTaU/3APbEcvbLce
         CyydYzmvXrCdu/t+0RfVGEYpQHvsn1MJjJ4287h2XQTi0cw4GqKYShLDPM+CphBJT0lL
         k5PYeebWoz1zU3+nBkd8M8NmoL4ANbbJO5/flQuSHDv677WnY0ev4kbxomhzUgdFxP0x
         Ge8/WBV3nLhUYYv3DB6KjyYr1P+wxZ3n5epibm8hMQrTxuFpxcICgl0I3FgJRglCsom6
         tpJJ2nt2glz6Yb8XH4ckrq1zCYrxo7y45Q/jhNXPBuu2c0RjVIhhZqAr/krIgQ2YWo1y
         MEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718115536; x=1718720336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+svzFPv09IAh78MJbo2+Q8Ke4k/S7OCitpiigdrQT0=;
        b=Tnb9QBUoGsHEemUkbYtksGKOVqm0PagxriEGdqwpindD0o/hl9SiKjILHBPLn5GFim
         xoDapCVeZu1YgO1VOrAR+xnalc0krcxHOjPkQ2X1V49mqL+QFSwid6QGWY4MQenOJ3yP
         AZU3+dw4/xQp2gibdb6pR3zm1QRJFJGzFHBrkloKf5arAyUzqF53j+J2/FWhGUz6I8EG
         U2usX6t3dt4P6F6tzGA4P5phkLbzF28W7E/maBawmRdEQKYaU3692rr05e9KTLelIO5m
         B77FqOHTrLgT9zPZhw4sxfWRaKnd8jatm1eCnBNm1AlJpVTxEIvGfk1cjqdLUx7SIJCL
         2MYw==
X-Forwarded-Encrypted: i=1; AJvYcCVvpGDfJF+23hXOh7p4Ct0mgyD0ShQrZemqndMrUD7oGTJZUTWqrGNwljeDnoTKAvwTex2/O9DkGWlJAJve6ptq6zGSupflzP/NSw2w
X-Gm-Message-State: AOJu0YwDjx89um4RiyMJA01krIC1I6XN8VAcmaE9b7ktpPIaiHeWk7u5
	/i0uVijQt4rJoSu8Zb8j6nyeG830+lAZ8DL6dkWjcPbXE+BhpUIqr26EXX91K8c=
X-Google-Smtp-Source: AGHT+IGYxJsDoNyWM7n73ubF3vkMjuX85Luyysgea5l4SdD71aAbXiKU2P3ylYXH+RtHuOgnM9v8Xg==
X-Received: by 2002:aa7:888e:0:b0:705:9992:d8ad with SMTP id d2e1a72fcca58-7059992e592mr5653046b3a.19.1718115535620;
        Tue, 11 Jun 2024 07:18:55 -0700 (PDT)
Received: from abrestic.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e3bc701a75sm5842641a12.75.2024.06.11.07.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 07:18:55 -0700 (PDT)
From: Andrew Bresticker <abrestic@rivosinc.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Bresticker <abrestic@rivosinc.com>
Subject: [PATCH] mm/memory: Pass head page to do_set_pmd()
Date: Tue, 11 Jun 2024 07:18:49 -0700
Message-Id: <20240611141849.2788693-1-abrestic@rivosinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The requirement that the head page be passed to do_set_pmd() was added
in commit ef37b2ea08ac ("mm/memory: page_add_file_rmap() ->
folio_add_file_rmap_[pte|pmd]()") and prevents pmd-mapping in the
finish_fault() path if vmf->page is anything but the head page for an
otherwise suitable vma and pmd-sized page. Have finish_fault() pass in
the head page instead.

Fixes: ef37b2ea08ac ("mm/memory: page_add_file_rmap() -> folio_add_file_rmap_[pte|pmd]()")
Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0f47a533014e..f13b953b507c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4764,7 +4764,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 
 	if (pmd_none(*vmf->pmd)) {
 		if (PageTransCompound(page)) {
-			ret = do_set_pmd(vmf, page);
+			ret = do_set_pmd(vmf, compound_head(page));
 			if (ret != VM_FAULT_FALLBACK)
 				return ret;
 		}
-- 
2.34.1


