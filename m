Return-Path: <linux-kernel+bounces-529725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22837A42A44
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CFC8188A2D5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A1D266B4C;
	Mon, 24 Feb 2025 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IW7AmgjR"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514A62661BA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419125; cv=none; b=FbmXulDnTFQDjL/fKCi3djLBdl/meB1u5nU0K2uIHqrIKcqUqAQyID/nmKN+XtceYWixBGtNrpAB64g4T5NYUDOC0pT2QFf8HEG4zmeTGUqa5pMuRFn+aHy2I0h4S+FOuEL8l2/GryJdOM/HWExlxCYPpqzKocBcKU35vR6xTYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419125; c=relaxed/simple;
	bh=GaZ3NHGqOhxDUVbP3LqTaXZumX7Y4lZDhfizHB7R2Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPLLcJCepkq0VNYPOD4dfU9+i8tyLLSRvS0F+oUCYm514WYFmTewvTVGiwTd3cOxpaHP82KQxzx6a4LRilFTBwuG81ysqPTojiKUl20bLQ8Ec36MBpKHUd+w76ZxD8y/ngrAfyUC5rptE++ZFLMbOorr+YXw+CvAUcbWmyv/uPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IW7AmgjR; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fc0ab102e2so1225580a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740419122; x=1741023922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPTxJ+9VApNW1wIyXAimG9WYLhdSeBQuD2wh8D+5JoY=;
        b=IW7AmgjRUZVUtX8De3//5x9KrWT+xqHCNPoU2YkjrQjBwYZu+RifIoaJxuGmoTQtg8
         UzNJTuFt+9K+fFb0SsyrRrSHrOOSMDJafEfDFs11KuishRJa7NT5f9KjHtYkWPM9EMU8
         sHnoZ9xpj1OKDf/eEBI68ks7w4g1Jh2bCgwdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419122; x=1741023922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPTxJ+9VApNW1wIyXAimG9WYLhdSeBQuD2wh8D+5JoY=;
        b=BoHwkq6L6LhHaErbxr1bFtkDElsH1CEYjtINs9RyhU4MOfwJc8k075LikNH8h2JbZX
         trv2aK1+R4iKqjh5MBjBQlsUWtUTwTdgafPjnPk0oy7BamgTaJ5ynSM/2YxA1kjLAq+Y
         5Y1yO4ZBrlLUtu/30zXYZI61YWLIYHUfbKI2Vzkmfs8hf/EiLIzA9YDmuenjlRnW/tuP
         6bx2unMBSEBSMML5RBK6s+QUyc0ZGLGD+kBNTywYQs+rluZwCipoYliGHrWQHpgR6snq
         46Gsyp5i22fZty5FNz1Nga+HUP05aT9HplUWmLUaGOPacUD/Hs8JExBhjx2dl+kFLBCi
         T6Dg==
X-Gm-Message-State: AOJu0Yy1YvpdI68A58EjkvWJGoX0DIGPuLuze/Ju+tagOjn1WSkCL6Sj
	QR5a76CE++NM6wRjoIENzEVgvaev7e659Grn7Kr7fR7SiGQXgRW2rS0EViihvw==
X-Gm-Gg: ASbGncuTyxTrUw5Ky4LYuqz8pSKAHwwAXTL3+R7UsD1bN5DCmPLE0ZyX0l6jX00pw7T
	xFmrjYigKtiG33NPFYv2Mt11zEx33C39R7M6HW6WNQ8Uij85PT70cuY19BKGirsbwNUdcECYIgg
	A/cs/LMuJ6YCkHFSmUVl5JLNMNg/MRoN13cKsZVlaQxMJJvHDWI6TjBdEEkkMDE0OyrA9jf8sQy
	fBcY6DAyDVMy/j1Zv2nY7hugjLqpLPIxtNxwncTuJea2BmhgLc4KrtmvheVttwTEwKqNNiI++w6
	0a0kYUeuHXIAL1uTzzoUFwpfsL1yUThOPNfGwxoSeGFAM+44IM4sHX1Xmn6z
X-Google-Smtp-Source: AGHT+IHP5BJhLkG1y5WlyMonne7HfrmaKX102f8M0T9GVc1W+S/OC3k6B6HWY8ssc4OyfR7EtUf+nA==
X-Received: by 2002:a17:90b:3848:b0:2ee:cbc9:d50b with SMTP id 98e67ed59e1d1-2fce7aef973mr9370465a91.4.1740419121838;
        Mon, 24 Feb 2025 09:45:21 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fceb02d9b4sm7708790a91.6.2025.02.24.09.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 09:45:21 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v6 6/7] mseal, system mappings: uprobe mapping
Date: Mon, 24 Feb 2025 17:45:12 +0000
Message-ID: <20250224174513.3600914-7-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250224174513.3600914-1-jeffxu@google.com>
References: <20250224174513.3600914-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Provide support to mseal the uprobe mapping.

Unlike other system mappings, the uprobe mapping is not
established during program startup. However, its lifetime is the same
as the process's lifetime. It could be sealed from creation.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 kernel/events/uprobes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2ca797cbe465..c23ca39b81ac 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1662,6 +1662,7 @@ static const struct vm_special_mapping xol_mapping = {
 static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 {
 	struct vm_area_struct *vma;
+	unsigned long vm_flags;
 	int ret;
 
 	if (mmap_write_lock_killable(mm))
@@ -1682,8 +1683,10 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 		}
 	}
 
+	vm_flags = VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO;
+	vm_flags |= MSEAL_SYSTEM_MAPPINGS_VM_FLAG;
 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
-				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
+				vm_flags,
 				&xol_mapping);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
-- 
2.48.1.601.g30ceb7b040-goog


