Return-Path: <linux-kernel+bounces-299520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9157495D5D1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8FF283D59
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8DD191499;
	Fri, 23 Aug 2024 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hd/DgigK"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC49191F8F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439949; cv=none; b=t8oVX9HgcGzfhLZBH9hgCA6PUg5rQzzwxKKrxqJpRKrwFy91HsUmPj3UN2YifXet6sRYD8DmSLFiIvoDqOjnfSeAfCRXoj7HVOwb98nHRuegk1sE1lPssIix9w82f08AgdACKC9PzFZ7PU3eyeCP4PtPo0+CcaYjcKt6tCx94Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439949; c=relaxed/simple;
	bh=I/+R0tj/p4+lUQOaI9N3YLR79rfM4ugynbTz8CoiJI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tIx3inRi3qguFLiU88ph6AEHIMIe5laHnxWVnDKJvKZD7xj2sLR8Gaq7efKmQXrzW8dQKJu4f80fQ1iif92A+f9AlLX2ZM9acE8hq+P1M277Sv+xuWnq+3XLoc81LzLg6jFtLH3GF5RXKoXCgwmeK2uz3KCFgtQ7+PpXJ1UXEL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hd/DgigK; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6c159151013so11171966d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 12:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724439947; x=1725044747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7hnXBn/fKymsE7ALq094qlnFebrZeS47F69tb04fyWg=;
        b=hd/DgigKeVhE6p9MlKTJ2tBXq9a+DXFt1Vgx246oB9jKTw4qRxYiH7EFILUGvyTMNW
         KXuGfbodQ+tAeCJi6gro7aUe7xUwQdM63vC4edGG5vgjGCw3Zbb47qmRucw1Sam1zFdM
         4Bq1jGj4tN5Hkedg5f/pt+zehoNF05BwItxGwzSxMMO9NP/Z8sTeN5CRjYLr8ugNyFMD
         2eAtd3KVTkUrb5OCh3SHnGcg9Mf/2w20TaZkX9lAT7/2+fWBrfcQSXXcSbXQ5fDqQTqq
         0IiQJMk1UFUSBHiXofzU1q0LnE8tmcObHyELV125g/nMk/3ADXIPbio8WlZM+ZusqKr3
         RYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724439947; x=1725044747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hnXBn/fKymsE7ALq094qlnFebrZeS47F69tb04fyWg=;
        b=aVOluL1JXFYv9Fj01F4/kVS4vRJT3EsKlrR6qYjQNwgdgoCqpYzrxKwMSfDmEeXbvv
         EzT1P+KQjIf+fztfFnWmjAValdNedvoWn4WVcx+4JBT8TwhnT1RbTGCoTFr2xjAHh7EZ
         BacbyfA86INp9Lsjq7dxVrQoj+psNkGGCQFApc+bu7CF6JR9Xrot1oc1Ql6IH2D7fKUE
         mXJGUt0Fya96B0uDCCMVnPxaD8W88HISqx5GbAJQHFE71+9chlyhnGkVTLp44VCIg6rD
         u0Jhlbh1AkspdUJb15KjE5R3VvD1N/A+kXRfEBPEIU9aChMKMFz4SCIMTOD5EmoNAGRF
         /f9A==
X-Forwarded-Encrypted: i=1; AJvYcCUp1VitFrnZ04mmdzXwpluSkGz5NjsICBXNmGvd3wtirzGxho1R+SupFCEe5OSKp0q2zbXOigPxKZkovfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI5P4g4cwQ8nKf21gL6Dls7MMFSrUyTyFIW4fQVXFQ3Tj3MZrN
	ZUMBq/hxVHgppaqSOuBAKPT4hHHbLRF52s8agAzvjoAgpzLIuC6t
X-Google-Smtp-Source: AGHT+IGb6uozWgs6YOOHYAREygi1zTfCuWtkYKG4WQ1tsg+5T4m5Gugr7+luUwVK2XjE0PY/2ER+kA==
X-Received: by 2002:a05:6214:5bc9:b0:6c1:6f9a:17c6 with SMTP id 6a1803df08f44-6c16f9a1a0dmr30087866d6.54.1724439946739;
        Fri, 23 Aug 2024 12:05:46 -0700 (PDT)
Received: from localhost (fwdproxy-ash-009.fbsv.net. [2a03:2880:20ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dcd5bfsm21345086d6.110.2024.08.23.12.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 12:05:46 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	david@redhat.com,
	ying.huang@intel.com,
	hughd@google.com,
	willy@infradead.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [RESEND v8 0/2] mm: store zero pages to be swapped out in a bitmap
Date: Fri, 23 Aug 2024 20:04:38 +0100
Message-ID: <20240823190545.979059-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resending it, as the CC had "Huang, Ying" in one of the initial patches,
and it was rejected by git send-email because of the "," in name.

The original series [1] was almost merged, but was dropped
due to a last minute bug [2]. Resending this with the fix for it,
by handling zeromap in the same way as swap_map and cluster_info in
enable_swap_info, holding swapon_mutex and si->lock, hence avoiding
a race condition between swapon and any point where the lock is held. 
This is the safest way.

The series had already been reviewed and acked by all maintainers.

Hoping that this attempt goes better than the initial one :)

This patchseries is based on mm-unstable from today:
4926e8348e10 - (akpm/mm-unstable) mm: optimization on page allocation when CMA enabled

[1] https://lore.kernel.org/all/20240627105730.3110705-1-usamaarif642@gmail.com/
[2] https://lore.kernel.org/all/202407101031.c6c3c651-lkp@intel.com/

Usama Arif (2):
  mm: store zero pages to be swapped out in a bitmap
  mm: remove code to handle same filled pages

 include/linux/swap.h |   1 +
 mm/page_io.c         | 118 ++++++++++++++++++++++++++++++++++++++++++-
 mm/swapfile.c        |  38 ++++++++++++--
 mm/zswap.c           |  85 +++----------------------------
 4 files changed, 159 insertions(+), 83 deletions(-)

-- 
2.43.5


