Return-Path: <linux-kernel+bounces-539168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F1CA4A1AA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4803BD81B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263E0279E40;
	Fri, 28 Feb 2025 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pEbPEGqa"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2769E279E23
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767420; cv=none; b=ZrT0+x8CF1qGn7jMgblrvzdf6yCvioA/EaNP+b8sJKGh4ap47eLnoBGFNDrO2TMMe50HAoKD2IEhx4jmpnHh0g1fjloVZ9+IqE3t3w12bbJboQKGpVI5FUCxeCzCDaIqwEwaHsxnFgM4Fcukjj09fcrrTk0llkRKAMtH3+Es2ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767420; c=relaxed/simple;
	bh=Uqx2MOddIzEVhMima1zUgs2wFsC4jYaiHH85/DCq4E0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uIJ5eWMBN+Jec9ao4v8tBldlidTG1NlIdJUG/WMvNvymO2+W66cSfYXfF0MU9aL5hr4WL5M9mFhPNqeMkFEy/G1h2QsqaJOGcT+JOOhY8MJTIBUH8e6yrXguUq4XP+22fxS1CchYWqGyFLm1cLHQir2qWSdkiRJ5tIE2dVSprw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pEbPEGqa; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2feb47c6757so3223055a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767418; x=1741372218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I2OTsio8sZEwb/RU9cVLVK4uXYnO7HAAoJEXN+XoPAc=;
        b=pEbPEGqa0zPz2WoLhjcUStXE3CPVqeG9uvat3L6wQ/IZXrKxPZyzWBZcgDIdHMsoZN
         mRh+01QrnxQIayxpHUZdKj/wt9MVkt8A+GfikvVgLZGwzyXp/GRJtPf0AFNy7KhpYMb/
         12UT/fqI2jNZzIREs9ZjtVQBJM4yUNQyp5TSSjM/AtX/0pv6aKuPn3F78bcZAfpeOFFn
         XkD+yozqf+jwqtjuErmqrZvOgpcpWzNfqymAookBLw2xDQYG0xWAmDGVrpZD8DX7MfoN
         hytK4VMNrpZe7E+JV/MiHS6NRcbU+XoEpRp7bjsOjG6hmA+vKd5LesmyTHikpzjCBzla
         1riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767418; x=1741372218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I2OTsio8sZEwb/RU9cVLVK4uXYnO7HAAoJEXN+XoPAc=;
        b=R6coicnXkjiM4geIJA7k3iC6oGvvnsWw+4d6qsG6Qi7u3xX+vObbb3Di2adKOzDCyq
         QHS9/0FoLeT7tjdPwx0jbYxyV154OPZm5AIagOu2HU9OD25Js/PimsyiEO02Lsd/RY4Q
         ugseAWmsEo1yG/pVXaKcUyoe5uETVJlTc5TsSU0YZRF2+T06VY9xlnlAg5ArLCTwZs68
         vn6kRpFRQ0f81D5v7FSYGT8XtywlqFnnlBSr0+bB49/AkZbmFqSxEO9fB52aAR/1qCVH
         VGozfiJHfsKweNElnrVlv4w/WA21+f7UzXmBBQ7cG/yiEEEvFRFvB2k1pJEndAwmTVPS
         Y+xw==
X-Forwarded-Encrypted: i=1; AJvYcCUcbJY+wvEkGxMuekRBGZOrGyeg/5AW5fUGXwQ6ArDhgnAZi6d+kjsM67m3ne8MIoy1P3harPEO5g52PRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKjsbqXXBcRVBnt31ESMJxwRPYsb4Gqpaou0BSJN+uomaNvk3A
	tYzOm5eo92YYGYRbX7rsEQBfG6EfQLU4YZ8ERaZ+4ao3feOOAfk43vpaONTjBLZll7IdUg==
X-Google-Smtp-Source: AGHT+IHUnBifXScpSNr6SZNgKx7X+v++q78gepOk2a+w86P9LcvmPk5lA9HV6vO/w06pUMljs+USRXb+
X-Received: from pgwa13.prod.google.com ([2002:a65:654d:0:b0:ad5:57cd:8f91])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:789a:b0:1f0:e322:45
 with SMTP id adf61e73a8af0-1f2f4cd6fdbmr7693779637.12.1740767418371; Fri, 28
 Feb 2025 10:30:18 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:19 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-19-fvdl@google.com>
Subject: [PATCH v5 18/27] mm/hugetlb_vmemmap: fix hugetlb_vmemmap_restore_folios
 definition
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Make the hugetlb_vmemmap_restore_folios definition inline for
the !CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP case, so that including
this file in files other than hugetlb_vmemmap.c will work.

Fixes: cfb8c75099db ("hugetlb: perform vmemmap restoration on a list of pages")
Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 mm/hugetlb_vmemmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 71110a90275f..62d3d645a793 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -50,7 +50,7 @@ static inline int hugetlb_vmemmap_restore_folio(const struct hstate *h, struct f
 	return 0;
 }
 
-static long hugetlb_vmemmap_restore_folios(const struct hstate *h,
+static inline long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 					struct list_head *folio_list,
 					struct list_head *non_hvo_folios)
 {
-- 
2.48.1.711.g2feabab25a-goog


