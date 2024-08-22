Return-Path: <linux-kernel+bounces-296761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898B395AEC8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460EB285C24
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2811607A5;
	Thu, 22 Aug 2024 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aFpAFeMD"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D73018453C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310853; cv=none; b=KP3lHigjUUhDo3kCxcygeTlo9mI21JMvLNAPO7MO2TumpuJg6idocW7v60o4jxhITHVgM1S/YXGlTP82yVXmvkkuFa1xNbKn6yXZgqeONjhWgWD7eVWyr0Ua4ZVrvX6IKVVSmpJTPCV0nFADuA4jPj4wCVrU11hDkwhNxezXg4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310853; c=relaxed/simple;
	bh=0V1622YwpCIkpKRqBh1KtWCMlB3fK7JnnpQBbFUsUac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cH+QHGDlfiRaQubrcQ+RVvKbcLSQz4cw6iBMf397alEbbo3p+ajaVDgLi2swCgJwnrDWAb8vPFM8czAzOsLTQrbaMDrr93FszyNUYrEiLR/QfDU6+f1P72/cXyLF44U2PIZd9CdY6JS+jI63VwrFrCE011JiKRzVCuM4UEHbvkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aFpAFeMD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-714186ce2f2so440656b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724310851; x=1724915651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnbwyZ8nm7OA7xAj7wrWrabgK1t5zgYyH3DelQTt/t4=;
        b=aFpAFeMDhecsz/zCeeHYgrRIVIr5hDA3oYXwIXTYMGsugD5Sf7VVB7vV3iuyndPkq9
         jdI6qKWAi6Rc+ocw13a7a8Kj0WLKZRVuvlLQxHOEoIh2Tav16omKYBbtfRuSG2L/Tmfb
         iBMzYxWG5jgg6XZjybsk1S51/+oLJq2AxZSTjgQEB7+njd7FoHqnFheOP0JmG47tkR8T
         Ygk8eqgTgUgEe3a/G6tQql8o3JAmEMna5Ut/thZmjt0XlUZL5jidKJX02mGZRNN+Zt99
         gtqv+QVZ6ybuO2ZKtTzpldBl0q1H0QDQXmcM/Gtp64ZwBeiLU9+kUQODP/+OlqyLML61
         OmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724310851; x=1724915651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnbwyZ8nm7OA7xAj7wrWrabgK1t5zgYyH3DelQTt/t4=;
        b=VOeukT758vGb3cRXJhiuhMqjReeZc4+Gzfnfn99qLGNoEpLGjAafvO4k8lGeLN6YLD
         rQ8VoNcD88Yq5k6EoVM2fB238U0TQe3zCzrkZKGYblyUHU9TYGgato1xwLB8tiAUAebZ
         OpfJtT0Mhnw6AW+eCYMbMro+qvfiK9+PuArRO5hn6V5TuAJ2tSMdVgr+NlqmiZENYZdQ
         GDZzbRTCX+yH1/FmJ6AMxK5K/BLQMN95CBl/FcMGsSgXwuOPkLryEGjPS8QlD5QcUVI+
         VG13WtNC51xTqiRw9sjppHlSkqCZb/htB0gbX6O3U4knWUlplPLVR8PhrhSqZQ/fNshS
         Oeyw==
X-Gm-Message-State: AOJu0YwEFclybC3YJEUqty/mkytN+k3fK5Dco7dAAQs5agMCTs0TNkcy
	5ouDY3yFp2qcS4ckrryGKUEZuk4o5mnmAJdX8crO5/UsJyEsLB+RNxFZla/NLWY=
X-Google-Smtp-Source: AGHT+IGXmNRuv+mQEijx6lEwkmYjHk6XirTogWRG+N5Gk1h3xzTz9eMzqUkZv9fzF0cNQyeHFRUhTA==
X-Received: by 2002:a05:6a00:c93:b0:70d:3777:da8b with SMTP id d2e1a72fcca58-714235a5404mr6267050b3a.25.1724310851578;
        Thu, 22 Aug 2024 00:14:11 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([240e:473:c90:f96:d029:ea8a:4e6d:d272])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac994a3sm695095a12.16.2024.08.22.00.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:14:10 -0700 (PDT)
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
	ryan.roberts@arm.com,
	christophe.leroy2@cs-soprasteria.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 04/14] mm: filemap: filemap_fault_recheck_pte_none() use pte_offset_map_ro_nolock()
Date: Thu, 22 Aug 2024 15:13:19 +0800
Message-Id: <d5d4744c87c759a53b5e115a0d59326232696f61.1724310149.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1724310149.git.zhengqi.arch@bytedance.com>
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In filemap_fault_recheck_pte_none(), we just do pte_none() check, so
convert it to using pte_offset_map_ro_nolock().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/filemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 0f13126b43b08..c98da9af6b9bd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3234,8 +3234,8 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
 	if (!(vmf->flags & FAULT_FLAG_ORIG_PTE_VALID))
 		return 0;
 
-	ptep = pte_offset_map_nolock(vma->vm_mm, vmf->pmd, vmf->address,
-				     &vmf->ptl);
+	ptep = pte_offset_map_ro_nolock(vma->vm_mm, vmf->pmd, vmf->address,
+					&vmf->ptl);
 	if (unlikely(!ptep))
 		return VM_FAULT_NOPAGE;
 
-- 
2.20.1


