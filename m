Return-Path: <linux-kernel+bounces-361956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0941999AF51
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2AF285ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000AA1E7653;
	Fri, 11 Oct 2024 23:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QFeQxSeV"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070121E5727
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 23:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728688981; cv=none; b=eEqPuHZu3X0UXcMnE6y072+RKXUZpL9l9NU99a+QKC3eyFlOdYvfJZC/cR5ZXwCOsEsQ2hzlCL568ZP4O7KUQ4g6pWfIUJIUaqWxc+RHnKkMOJbu/4Hz/gdk/FEhvtVYJCIA5iEsEcBMjT0+Zq+QETWA0D1xcvhzq0Fnoa5jl+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728688981; c=relaxed/simple;
	bh=+kciZjkG1zgQ1GzAf57ieD5PgpdjTvBx38Optd1M2hQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bg/d1TIWyEZkimbiWdIuzXqIWgPbmLjWd+85AVZJl3+Cy7/kRs8AyyJmJSaJT25bLziJ7RznkPJl4P7oCjsFIz4uaZ18N1/cOtNRqIsU5Xmrm17qX32XC7Apy1N4LniOipSrthD1iOpv9WoYYwwQckUJ8RooHdvh7T/3ao/ef6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QFeQxSeV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e2e2e02817so1628112a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728688979; x=1729293779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zQ3fy9ApFdIx/13nHC/ZJce/ALnWJIL4G1B3hOB5L24=;
        b=QFeQxSeVEBx321Be0evGhZ9VfxvjE/1G1QeEZF9DARRTe7wSJEg+S7sjxQM80Wb5tl
         VARpmbLPx/WCq3uK7F/QXsumccw/eT8C/xkRbgISxezYE/1rSy0N7LC18i2GeN/cXEF8
         GjFLod/pERL9s9Ukm8v49bk90u5Rin596StEETKxWziVpTxU2U9z7wYq6gerZzNrwQ4U
         BKmQRxf1uPYptDrlBOjUU+YNvQzOBcioryq+kThVXGdoQ6JGFMkXS48XnDIMZvld4+RS
         ILjVWMNMwa/vKg9sPzMFMfxnrCplPmGcBkmWtlyfH9NjWoXauHsE0l6PhXI44WbK4ICr
         vekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728688979; x=1729293779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQ3fy9ApFdIx/13nHC/ZJce/ALnWJIL4G1B3hOB5L24=;
        b=UrvdOOkcIAreYnrUigMAnRy3IHpicLY5DkOnCoDy9lack8hZUahY/y+dOMe4npkU7x
         lECwlfGM4IWOfLYmZUfzxtr08RyTmbYvMnLwEh6XMMNF5UW1fUco9zBuzwcZqj654pmP
         DOOvCKN42LkpT74MyrrX/C/KoxZte2AzlvbTaB31ae32uzAlYOB4gXUuhej3M3xVzok2
         em7tv1SIs6awmVJv1Mr7N2gbOG9W9lMjUGXOuAPnOb1QEMctSrMCBt5jdlZknVr4ULPw
         YDrKpZsdcS8yap5rBRGBlyi79uo5ImgkcVvJKqXPOWNXcGzXy4PbeP6kl7wAkiwxe49l
         YBkA==
X-Forwarded-Encrypted: i=1; AJvYcCXhQlxelVU8WvGjfpelNWm5ce4WQcT29ClKxfP2vLXP/SYVpW9ertfbQH34DmebqzMyOmiZ/wVK3Y4AcYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ1ShZIV7Au/KREonx1c/dTob3lkWBDC45QF4BCka2iuABBSME
	OrZFXVd9+lAfXa2fDYnsl7oqYaG5s56G1Q7XGrq5+j8RzzHHjREhAz5+jBLnzkD6vbtGivsoTl5
	5+MRipOs1IzWDvXeEwqNpHw==
X-Google-Smtp-Source: AGHT+IFr0sptcozt+ZrAH3WS4hJI40RdtRwKwkDb7kVtF/SqVh1nyxpm+MDJx1CARv2yQw1qWp7ccQL5vo9X2qDvGw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:146:b875:ac13:a9fc])
 (user=ackerleytng job=sendgmr) by 2002:a17:90b:3109:b0:2e2:9984:802b with
 SMTP id 98e67ed59e1d1-2e2c81bd68cmr13813a91.3.1728688978977; Fri, 11 Oct 2024
 16:22:58 -0700 (PDT)
Date: Fri, 11 Oct 2024 23:22:38 +0000
In-Reply-To: <cover.1728684491.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1728684491.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <5d0ededd93c4cd33a78c43c12d5075be2eea9674.1728684491.git.ackerleytng@google.com>
Subject: [RFC PATCH 3/3] mm: hugetlb: Remove unnecessary check for avoid_reserve
From: Ackerley Tng <ackerleytng@google.com>
To: muchun.song@linux.dev, peterx@redhat.com, akpm@linux-foundation.org, 
	rientjes@google.com, fvdl@google.com, jthoughton@google.com, david@redhat.com
Cc: isaku.yamahata@intel.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, tabba@google.com, quic_eberman@quicinc.com, 
	roypat@amazon.co.uk, jgg@nvidia.com, jhubbard@nvidia.com, seanjc@google.com, 
	pbonzini@redhat.com, erdemaktas@google.com, vannapurve@google.com, 
	ackerleytng@google.com, pgonda@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

If avoid_reserve is true, gbl_chg is not used anyway, so there is no
point in setting gbl_chg.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 mm/hugetlb.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 47c421eba112..a2e2b770a018 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3009,16 +3009,6 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		if (gbl_chg < 0)
 			goto out_end_reservation;

-		/*
-		 * Even though there was no reservation in the region/reserve
-		 * map, there could be reservations associated with the
-		 * subpool that can be used.  This would be indicated if the
-		 * return value of hugepage_subpool_get_pages() is zero.
-		 * However, if avoid_reserve is specified we still avoid even
-		 * the subpool reservations.
-		 */
-		if (avoid_reserve)
-			gbl_chg = 1;
 	}

 	/* If this allocation is not consuming a reservation, charge it now.
--
2.47.0.rc1.288.g06298d1525-goog

