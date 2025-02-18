Return-Path: <linux-kernel+bounces-520063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5112DA3A531
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C32F3B1AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948001F583D;
	Tue, 18 Feb 2025 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gmVTIokZ"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F57E1EB5FF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902657; cv=none; b=AKg2/SW7SCG4isYYmIddJnySa/f/YeLjnWnOiUpVpLYIEKv0/q6CipCjmfGuIpu0ZffHYOjVDlMn27DGHCcQXj/DmomX2bFGU0qAKhBZEK63qi23X3mwD2+26sWXGYbc48RsoM/53M/jQG2VcQo9EbE6gQtbEBUkzPKZppM94JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902657; c=relaxed/simple;
	bh=Z8s7mu4pu5GOjR/ncJt1qOn/WFj8MKtOB6E8/gE19JY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GA9aKNHKonxl0jW4WhnpImy+rw4LTDIyOVTVy2JCZaWcK8DmrvXVRxfuqUUU2F1Fem2nkDTNs2gidmUjcl0ssJyLjee2ojWsFXR9ZDUK2JIrWkWaffgTq2d635xR7IdR3pPsi4EzWPSz1S1vSLux6zKjD+gSood3cJZ52jsW/yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gmVTIokZ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1a4c14d4so10827944a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902655; x=1740507455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MVW0ADe4T+7DvYpJ3Ja4Izq9wFlQZ3y1S7kL9Nh/bk0=;
        b=gmVTIokZs8f6msCoSMLfjNhrikuoEpWrvPyWMMxCDZ62J8gK10S6SxqT1rW4ZW8GK6
         /ixREFdYIXM+25TbDPQzLu5a25I0+lbcivy6ZF+De3d0TNpZfqoZCKzdhdV/Kelqs/bX
         F31e/xTk4FPO57YpwxGDGEGD1hFVbpg8kM1Z5Twsa2sDchC4b2r995RCghWJFhjbGrj2
         iXdelHyFIZ2pOnSBUCBDqGSdkC8k0qHkfjq4DERqhk4UmnMJbjIQk7l3fDpf1xBnQeBH
         9Bqay3OkuAThG03SpP6nzWKBG6qNa36odPQQL+V+iaeGHiYHeUaneZtXeLySHwW2+hQp
         4wJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902655; x=1740507455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVW0ADe4T+7DvYpJ3Ja4Izq9wFlQZ3y1S7kL9Nh/bk0=;
        b=ekl8SFHbzVbEZBObBcd+80leQWBzj05LzRFtZ1UNAvoEIXFfZs/hYtmjIxi/agf3UF
         Vfc5v/bRlcVkL1pKFbmDq8EXw6erUSX7iQZKhlhQJNo9Bx1ODS6kOQO/lvq0kWWQOYO4
         j/Sv53B2b4HOAHM8jUMET2OIib8wt6r7oIpX+PQaLo84VlTmtdmS9dOtbHSdLGgiE8Vm
         4hMrWdtzcANjyapN3Z1t8pxwQjnKiLTnt7B7gY9tg9I8u0FGIIuFcddU+r6ArC1saUyr
         hgiv3L7IV+ZISJjLdZjTXvU3lGgMAn7lJhhyCfGdfxVu3UOzvfetUaC8Z4eaEecVnWAH
         NAWw==
X-Forwarded-Encrypted: i=1; AJvYcCWUu/jBscgkcOY1RBul1qHdE5D0Grrhh735NW0iqe+LDhLVT3Cy4yeUJolZKSMWsAH++hwoeGSLM91cnvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyexARxUgdasS4fTeGYGd8JK1EYY/0+hXCWdS2ThunB9tdSIDDX
	tcF3GhyxJ3urbLLuiaBGQr/S6kzCT9dZ5ZvMLx7AMcvarN9MX+YGx6u5QzvcVStkAmFJbg==
X-Google-Smtp-Source: AGHT+IGDKpSRe1oPu/VwRhWRHLOrhJKjIiM4oVbIlT3ZgWhE4plh+LVQZ2SzbJxbPpAJwZR48LTP+m6K
X-Received: from pfaq14.prod.google.com ([2002:a05:6a00:a88e:b0:730:96d1:c213])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e82:b0:730:9567:c3d5
 with SMTP id d2e1a72fcca58-7326177cbccmr24337762b3a.4.1739902655036; Tue, 18
 Feb 2025 10:17:35 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:46 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-19-fvdl@google.com>
Subject: [PATCH v4 18/27] mm/hugetlb_vmemmap: fix hugetlb_vmemmap_restore_folios
 definition
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>
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
2.48.1.601.g30ceb7b040-goog


