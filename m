Return-Path: <linux-kernel+bounces-414037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE6F9D2236
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02721F24B87
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE8A19CD1E;
	Tue, 19 Nov 2024 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ktg3ebvZ"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAD44087C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732007412; cv=none; b=jb+NQrxtM6Ip6RdekRQYA36NNKMgpUyxmNNtWan+3TfFLEvHT0HicObp1+7mxuGAx9d3YzoLm+9XrhV9f9swW0NrbfmHMKEnRl+OxOiyiDBNh2LPMQoXRhHdYW+Oyg62QFSGmPtyUJfrX8hvr6yFQ6yJf+ecLIGwwtouKpIPEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732007412; c=relaxed/simple;
	bh=l60Bts7dCNMvzFZ+oUsNv6bIRmCPlkqKhy/AMv1qh/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sH05uLKCt7TbJNPaBn/mV7oAGEeoSnKmukpgZ2nQnTksgRuJESecyKorKXLAgKUJP/zzjvv9BPISh+/DbG33I/woe8ZySzLDMGhyTu/Df/ahDGoF4lu3GBbmRuqqUQuuCC5ukBVuF0K0ZMQOWDhEFfoIHV+ZFptQCg48qZd20f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ktg3ebvZ; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5ebc0e13d25so1394098eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732007409; x=1732612209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IzLEhxN+4asFK9Bs4e0Mnm9KxvFCRf0oHSjev/+VhzA=;
        b=Ktg3ebvZJT6/EmjJXLhKOu8xVQ68JP7g185wRT7KFNuuei5s6Lt7VHUW+uYAqHY89S
         1d5Lzqng0Gv92FJcjgR554LgQa3NHWwjkkBxrQYJ0n6t90DV/a/dwY1obz5VkSY4p23D
         jl0XKp9mC83Rn3CiEv2OgsH8/jWlN1nBIzzxoKJqsQztgWqOhzpiM8z/dzY/pQ/eI8kt
         9McTsnww9DGUbh8CkYh1xFz759HkbUALMYNGL9Zqkt0VS+fe/9ajLso7fFf7RTuASugU
         +FOKFn0uawETxUgaxs5j2ATLJumwvtnhEm0QyILFwefbRFaqtr5bihD9G34COYBEFnpv
         zmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732007409; x=1732612209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzLEhxN+4asFK9Bs4e0Mnm9KxvFCRf0oHSjev/+VhzA=;
        b=VttHO6o+WgXsBjXQlR+EWaMwspL1H3gvdyH5GF2kg4Ru841KoDcpfQJ4CWfmVkkxvj
         GuM+VX/oMGTKzqaUOiV6KpNomOOkz7c8Cz4ht7ldWjJ2F4pHJ4E8AHENEqj5W/ZTbIjS
         M4juOis8ulhzJwpLsL4yLtpuDg3hvqTGKkyZUFjhx7fgwEvhIhnM2KjisGS9loQ2J5CH
         62QkesXc39C8c3v6ggfI/2pa71Zhq2qmWn6RZBp3C9veS4UGAHYSEloPwV9aoxxHIuxb
         QfPD7OpNGYR8/Or9M76UVr1f5MxDGYq7En6ywrNS8n0GJ2OBELiwlMJq/r6aqc3O1k9I
         yVgg==
X-Gm-Message-State: AOJu0Yx5ZQTYbzqwZzRHdUkwsmwcM8D4j79PG0IZh/a/1WVp0Mkjs/kh
	nwhQD1+NZDFtnA+UcWcWi4uyz16riXQ56mM28JK30J16wni1IcFcZ5K8SfypaaI=
X-Google-Smtp-Source: AGHT+IGyGuiGMKlRiaG+HiYwFMl/Y5ShneMQY9hcGlp/IVUKhWeaDcz7mbY8/6SkHUeL9OGTgdF5pw==
X-Received: by 2002:a05:6830:370a:b0:717:fe2d:a4e4 with SMTP id 46e09a7af769-71a77a09ab0mr12374401a34.19.1732007409238;
        Tue, 19 Nov 2024 01:10:09 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c644c8sm7223522a12.47.2024.11.19.01.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 01:10:08 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: pasha.tatashin@soleen.com,
	tongtiangen@huawei.com,
	jannh@google.com,
	lorenzo.stoakes@oracle.com,
	david@redhat.com,
	ryan.roberts@arm.com,
	peterx@redhat.com,
	jgg@ziepe.ca,
	muchun.song@linux.dev,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH] mm: pgtable: make ptep_clear() non-atomic
Date: Tue, 19 Nov 2024 17:07:40 +0800
Message-Id: <20241119090740.65768-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the generic ptep_get_and_clear() implementation, it is just a simple
combination of ptep_get() and pte_clear(). But for some architectures
(such as x86 and arm64, etc), the hardware will modify the A/D bits of the
page table entry, so the ptep_get_and_clear() needs to be overwritten
and implemented as an atomic operation to avoid contention, which has a
performance cost.

The commit d283d422c6c4 ("x86: mm: add x86_64 support for page table
check") adds the ptep_clear() on the x86, and makes it call
ptep_get_and_clear() when CONFIG_PAGE_TABLE_CHECK is enabled. The page
table check feature does not actually care about the A/D bits, so only
ptep_get() + pte_clear() should be called. But considering that the page
table check is a debug option, this should not have much of an impact.

But then the commit de8c8e52836d ("mm: page_table_check: add hooks to
public helpers") changed ptep_clear() to unconditionally call
ptep_get_and_clear(), so that the CONFIG_PAGE_TABLE_CHECK check can be
put into the page table check stubs (in include/linux/page_table_check.h).
This also cause performance loss to the kernel without
CONFIG_PAGE_TABLE_CHECK enabled, which doesn't make sense.

Currently ptep_clear() is only used in debug code and in khugepaged
collapse paths, which are fairly expensive. So the cost of an extra atomic
RMW operation does not matter. But this may be used for other paths in the
future. After all, for the present pte entry, we need to call ptep_clear()
instead of pte_clear() to ensure that PAGE_TABLE_CHECK works properly.

So to be more precise, just calling ptep_get() and pte_clear() in the
ptep_clear().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/pgtable.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index adef9d6e9b1ba..e59decd22e1cb 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -533,7 +533,10 @@ static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
 static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep)
 {
-	ptep_get_and_clear(mm, addr, ptep);
+	pte_t pte = ptep_get(ptep);
+
+	pte_clear(mm, addr, ptep);
+	page_table_check_pte_clear(mm, pte);
 }
 
 #ifdef CONFIG_GUP_GET_PXX_LOW_HIGH
-- 
2.20.1


