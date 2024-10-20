Return-Path: <linux-kernel+bounces-373118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22799A526A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 06:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B3FCB21945
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 04:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AB0B666;
	Sun, 20 Oct 2024 04:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K8sCFTf+"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB41BE4A
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 04:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729398140; cv=none; b=IUyJyx/xpp1vyTkiejTUhGmGyRTa0Sh7lK6Nyt83W6+siQHkyp8d/kXXbnADcpfec78sHthwGMSxAIlJo2C2XPfsHfNMZjkyVIFfMfpDdsjP+C/PfSeyB0/LELVJ+LvbEN6AlpL8fzblQ3ZfJgiBrXdDQJ+0hFFjZTRGwhvwChY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729398140; c=relaxed/simple;
	bh=XaCuofOydV2xR3Tg6aOIIGLypo6I2Fmon7MLCN+dBzs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aQ6vQ6Z58h9j1++9G7TlGoNg0wUuuw7PuMA+ULKwuOS2hXbmZDgjPFAsLbh8F5lDIDL38PknwfYbfplCfu07Pyby+o7fCjOTmQf1FFwta+WvMYOC56YUg0T0IGB+HPBuoAdrI49OXdKs8mEoJZuDrp5K2eOdZ8gcbTN9NVepST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K8sCFTf+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e383ba6763so59409317b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 21:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729398138; x=1730002938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hunIrxaAZBKXG3dXiSGVda8Y0C34IOSFspIj4rrZhK0=;
        b=K8sCFTf++DTB88Zvo49KOyZE4XeEv99eNq/w8TAG1tGaj9ny9bTWOt1XrUq2eYqrjj
         JY+PMU+wrx75bw3BwPKfMUjGORJVLNUg0tdY8xsjNe1wYOO/WPe+tnHKZyvqWz/8bU5Y
         Lj9I5g4jCdS/WIOdwxagPzPuQOCceqjhxwEfw/hvuJnO4rOmP6rg3KwFrMATNgUal3Nx
         l1KOxrU0CIOI9lhXQyijQ6ly1RNZ4aoISBFp66T7bpqh7ZWcsvqJDZFBfWFG+fLkTTPm
         UJSZhA3tYf0mAUCi+y6iFcEU60Xx/mYmFjrPnBJP1w3l4QmvHbbScEqUWSm8emtnorPV
         M6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729398138; x=1730002938;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hunIrxaAZBKXG3dXiSGVda8Y0C34IOSFspIj4rrZhK0=;
        b=QGkx4advGvoLf45n50zh/SGM5JdanRXtuWfqDdO+hg+KRk2I6ipaLOKh2z4l4me4HQ
         LJm5bj/RV/XMQyXeV858946c1x9eo+S/KIU84mX6adbcnl4qMEpcdMii1yaN+g4ygGUp
         ANJanlvWBR4Yz22rpCN1Chs12pKXZmYCOUOnR2N7JJzCPR5Fg4iGA0Z+vszuQ6alIDGg
         7t+/Wx4wuEib/i7DrtyO4vLbdDcXzNS0iZzG4S4/NcDVXR2u5hT26rsAxdEawTtDTLbS
         b7xUhmySW/N11bUu9uKzWszCIM8AqhLkfE1a+I07tgFb80Jwkh+2ZhMnombvSeJ/D2cg
         pyqw==
X-Forwarded-Encrypted: i=1; AJvYcCVvirEhEHBeiZzhfWPvOra+nui15nrpXrQUrxy43h7pCakRsDZIFmMzWzB/mvPM0pU8Sn6UhSv02A25itY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfd+AZTmG9cyNCDDHpDxgMps+XBce7qaYyjodos4JdNDOiB/qI
	F20CTI/IZqPMTcq8mL5/nlfTLHg56b8aTm5RenCan3dGKNTnz1fh9LTV5LwMhmK3lCDGAAav7Jw
	pMw==
X-Google-Smtp-Source: AGHT+IFifeZ9dPCzrp2wsmyKhCEmFpT64OFwbRHZPKpAAxcfKYugj5DI1/4Uq3aosY7cj+7jHzLwU352+Fw=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:882f:cbc3:2127:9e93])
 (user=yuzhao job=sendgmr) by 2002:a05:690c:7010:b0:6e3:1023:3645 with SMTP id
 00721157ae682-6e5bfc56d11mr1792447b3.8.1729398137687; Sat, 19 Oct 2024
 21:22:17 -0700 (PDT)
Date: Sat, 19 Oct 2024 22:22:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241020042212.296781-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v1] mm: allow set/clear page_type again
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Some page flags (page->flags) were converted to page types
(page->page_types). A recent example is PG_hugetlb.

From the exclusive writer's perspective, e.g., a thread doing
__folio_set_hugetlb(), there is a difference between the page flag and
type APIs: the former allows the same non-atomic operation to be
repeated whereas the latter does not. For example, calling
__folio_set_hugetlb() twice triggers VM_BUG_ON_FOLIO(), since the
second call expects the type (PG_hugetlb) not to be set previously.

Using add_hugetlb_folio() as an example, it calls
__folio_set_hugetlb() in the following error-handling path. And when
that happens, it triggers the aforementioned VM_BUG_ON_FOLIO().

  if (folio_test_hugetlb(folio)) {
    rc = hugetlb_vmemmap_restore_folio(h, folio);
    if (rc) {
      spin_lock_irq(&hugetlb_lock);
      add_hugetlb_folio(h, folio, false);
      ...

It is possible to make hugeTLB comply with the new requirements from
the page type API. However, a straightforward fix would be to just
allow the same page type to be set or cleared again inside the API,
to avoid any changes to its callers.

Fixes: d99e3140a4d3 ("mm: turn folio_test_hugetlb into a PageType")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
---
 include/linux/page-flags.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index ccf3c78faefc..e80665bc51fa 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -977,12 +977,16 @@ static __always_inline bool folio_test_##fname(const struct folio *folio) \
 }									\
 static __always_inline void __folio_set_##fname(struct folio *folio)	\
 {									\
+	if (folio_test_##fname(folio))					\
+		return;							\
 	VM_BUG_ON_FOLIO(data_race(folio->page.page_type) != UINT_MAX,	\
 			folio);						\
 	folio->page.page_type = (unsigned int)PGTY_##lname << 24;	\
 }									\
 static __always_inline void __folio_clear_##fname(struct folio *folio)	\
 {									\
+	if (folio->page.page_type == UINT_MAX)				\
+		return;							\
 	VM_BUG_ON_FOLIO(!folio_test_##fname(folio), folio);		\
 	folio->page.page_type = UINT_MAX;				\
 }
@@ -995,11 +999,15 @@ static __always_inline int Page##uname(const struct page *page)		\
 }									\
 static __always_inline void __SetPage##uname(struct page *page)		\
 {									\
+	if (Page##uname(page))						\
+		return;							\
 	VM_BUG_ON_PAGE(data_race(page->page_type) != UINT_MAX, page);	\
 	page->page_type = (unsigned int)PGTY_##lname << 24;		\
 }									\
 static __always_inline void __ClearPage##uname(struct page *page)	\
 {									\
+	if (page->page_type == UINT_MAX)				\
+		return;							\
 	VM_BUG_ON_PAGE(!Page##uname(page), page);			\
 	page->page_type = UINT_MAX;					\
 }
-- 
2.47.0.rc1.288.g06298d1525-goog


