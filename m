Return-Path: <linux-kernel+bounces-361953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8C299AF4E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76C32B22458
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D211D175D;
	Fri, 11 Oct 2024 23:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZfgvBRX"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27831CFEA9
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728688975; cv=none; b=CEaTBG8rUi3QitV50nGx37+akrWZ2J8908RAkMXHviQ5nvvyJbf0pFJtA1askpM88qjWKKWdmFfUjPYGOYlG4J6QnpF01basZ3MC0gYWNh4PVbfv98XiAc5At9iovddVBAY/zP7C/SPXl+eFOfeBAgNkB5SSphS/IpPyOy2G7KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728688975; c=relaxed/simple;
	bh=feGH3rWgHuOV94nab+KilLLBOQvb8EXRLRBqqoT3Zd8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jos6fWBMUoDWbgWqdEFeiHrXVIU5A2+p9fhFfxh5eDzDP1RvPwZqrcGUQlDkkTlQ1s0/enb5llj2nLa7+TO9M65D47i2bfhazp7efLvnHQAxn6Ag2xzPW1tMYtj+7dr0UpKlGp1Hc87m1irnB89+f8sXjtF8GO7+nCl3t+Gspyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZfgvBRX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e355f1ff4bso14316937b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728688973; x=1729293773; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bt/q6lVwMuPfkVr4eqRPloLtMZQ7iAniDEn2+RLnOtI=;
        b=QZfgvBRXiTmxhIjmLfSJDC4Y96jTbDECiVrc7H08b5/imwoUvWEiq2RTZpDqTpRN5o
         WTN3sQVRDzyJ22AWbW7GdINFZzQqqAAV41D8y0/pnh+pYQCDhm4nIGXYP/5J+WjgM/4M
         ohVFRQjJGeNo0mw5mKFp5rxMMbv9Fx9QyFT4CNM7t6lbbrbJVlSIkxpd2VTOu2WFMkHJ
         Hkut1LEETFayoLSN1gDQPqBPQHMvs1AnPsaUN+EAm8DTp5pTl+JhyOf09HioTBz/3OD5
         Gru0fO5x4vVVGki4xz81rmIaPRvfeP2c2NOE3Pf0LHyS8byrSuRqBixLzhv8c3AngZ9T
         fALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728688973; x=1729293773;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bt/q6lVwMuPfkVr4eqRPloLtMZQ7iAniDEn2+RLnOtI=;
        b=VtWBS8Y1i4FYoKvizerePMDLkzy2epmpcs2LoFdirszDzzNN5VY+aIcRXUsbWvceYR
         6LzojL44XQcUk2nGv0nxLJ8dfdxi76MBfEaB5rV+osR31Vl4F7NkiNdwDYCjb3p8my7m
         dc+/pN+WTGnE8g5msFwR10adLAMxdFS2tjbBRqWkRUFwtRAZzCqDLocyRBHToufxWgsD
         bthHSp8XeHmKlGAt37NqlbWFIs3QIcS2svNqNDoLCqyDuyLXZVLWJ7muJ4IVe83owYrj
         K2JJ4fi0+zW92uLEddz7WpHPpwLqiyjtlV5ZqNMFyOcvAiPFGDQhzpuVAEeLXZ5i7EFf
         maWA==
X-Forwarded-Encrypted: i=1; AJvYcCVDVW+lZcJHGtFbl/cex9aifEuGs5pAlWPLpwmE3Uh/edSlWjw6/Rh8RdZegVS0BNknMx8fgQObIfvAJAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH9s6xCCNhRWlRCV2Keoz2Qg/BzlJjarzNXofWYCrSraDXY9pR
	tLshX54scTSOvpETj2dVUWyxKLwdwkLKy2FkS1dZbJdy4qxPlDDzT+RFAfkoc6thPfk1O3OgWjP
	GIy+XY+UWQI6dZ47XpNij5Q==
X-Google-Smtp-Source: AGHT+IG8lUZjFQAkew/PUffXX1Gv9YN7WjmIker4tw4oJjNyQyJVSHDEY+AvIFQh6DZ3lgAyQc6M0IQdvTU1Ndvldg==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:146:b875:ac13:a9fc])
 (user=ackerleytng job=sendgmr) by 2002:a05:690c:4383:b0:6db:c34f:9e4f with
 SMTP id 00721157ae682-6e347c8c372mr160117b3.8.1728688972926; Fri, 11 Oct 2024
 16:22:52 -0700 (PDT)
Date: Fri, 11 Oct 2024 23:22:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <cover.1728684491.git.ackerleytng@google.com>
Subject: [RFC PATCH 0/3] Reduce dependence on vmas deep in hugetlb allocation code
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

I hope to use these 3 patches to start a discussion on eventually
removing the need to pass a struct vma pointer when taking a folio
from the global pool (i.e. dequeue_hugetlb_folio_vma()).

Why eliminate passing the struct vma pointer?

VMAs are more related to mapping into userspace, and it would be cleaner if the
HugeTLB folio allocation process could just focus on returning a folio.

Currently, the vma struct is a convenient struct that holds pieces of
information required in the allocation process, but dequeuing should not depend
on the VMA concept.

If the vma is needed deep in the allocation process, then allocation could
become awkward, such as in HugeTLBfs's fallocate, where there is no vma (yet)
and a pseudo-vma has to be created.

Separation will help with HugeTLB unification. Taking reference from the buddy
allocator, __alloc_pages_noprof() is conceptually separate from VMAs.

I started looking into this because we want to use HugeTLB folios in guest_memfd
[1], and then I found that the HugeTLB folio allocation process is tightly
coupled with VMAs. This makes it hard to use HugeTLB folios in guest_memfd,
which does not have VMAs for private pages.

Then, I watched Peter Xu's talk at LSFMM [2] about HugeTLB unifications and
thought that these patches could also contribute to the unification effort.

As discussed at LPC 2024 [3], the general preference is for guest_memfd to use
HugeTLB folios. While that is being worked out, I hope these patches can be
separately considered and merged. I believe the patches are still useful in
improving understandability of the resv_map/subpool/hstate reservation system in
HugeTLB, and there are no functionality changes intended.

---

Why use HugeTLB folios in guest_memfd?

HugeTLB is *the* source of 1G pages in the kernel today and it would be best for
all 1G page users (HugeTLB, HugeTLBfs, or guest_memfd) on a host to draw from
the same pool of 1G pages.

This allows central tracking of all 1G pages, a precious resource on a machine.

Having a separate 1G page allocator would not only require rebuilding
of features that HugeTLB has, but also cause a split 1G pool. If both
allocators are used on a machine, it would be complicated to

(a) predetermine how many pages to put in each allocator's pool or
(b) transfer pages between the pools at runtime.

---

[1] https://lore.kernel.org/all/cover.1726009989.git.ackerleytng@google.com/T/
[2] https://youtu.be/7k-m2gTDu2k?si=ghWZ6qa1GAdaHOFP
[3] https://youtu.be/PVTjLLEpozE?si=HvdDlUc_4ElVXu5R

Ackerley Tng (3):
  mm: hugetlb: Simplify logic in dequeue_hugetlb_folio_vma()
  mm: hugetlb: Refactor vma_has_reserves() to should_use_hstate_resv()
  mm: hugetlb: Remove unnecessary check for avoid_reserve

 mm/hugetlb.c | 57 +++++++++++++++++++++-------------------------------
 1 file changed, 23 insertions(+), 34 deletions(-)

--
2.47.0.rc1.288.g06298d1525-goog

