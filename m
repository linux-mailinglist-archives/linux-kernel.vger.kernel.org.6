Return-Path: <linux-kernel+bounces-530193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A88A43049
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A732174603
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A1820DD52;
	Mon, 24 Feb 2025 22:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lFKRnTU2"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337D42080FD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740437576; cv=none; b=psIwLi/Wx4try5IMco0udM5kIVnexaKHEyJmBjT5/40uSnpM9AE0IBp6rEbhNDHIlkij1YRw60P4v5GbeysbzRCuty7iqHB2ow8LQYO8CzCd9rfI79ZkJC1TpJdnbKaf5unIEcGiYqjRD0GieIamkJoSfjL1meN5TzGc7ldt1ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740437576; c=relaxed/simple;
	bh=Ahb37i8tu8vEzrUDVo47OFw93L7v5pGugTT95nDEeAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncs92rWvKC8Bxm4YszBbqPqT/R2FoE35+F0TaTvPOeI/ScYERFH9b6Ev3zoxbxC17sfuaGJmEG5vW+eXiYVt1ZUd4FR59gEwxARnKB3bJTofuFe15ZZ+kz4cV82cU/hTU30pSdn1bh/IXQy1jqAp+F4rzacwUDy/gofbfiLtZiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lFKRnTU2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22134a64d8cso12091355ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740437573; x=1741042373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iZa0J3oai+8Welu6Zi/1CRi8cf0vv3kefTwVSjChmA=;
        b=lFKRnTU2VEXw8ze8n7zxtER7TYsFf4YXSgxUkEN+WdHmqBHUXjBX+hArhvqkM9zN/C
         pVS18QyJJBeVw/cGnVrZecni44Uai/VvIqOX+viJJLU4MoqPWAcY9U11OgaX/V6guPtT
         horDiJetuuVa7hb3bh03czXSe2svzc3WsLUZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740437573; x=1741042373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iZa0J3oai+8Welu6Zi/1CRi8cf0vv3kefTwVSjChmA=;
        b=N4shWTJ/P6W1KvSb+aJQKYTZzBUDt8olsrtSiM+3TaMjSm4Qw7f5v4RINr4X7ykHen
         N6L6MMQyTYiQvt7CEpj4Igqnq286GjBzLrl4vlr1gIpy4UWcgjKJdvoJwH72MCHbobSe
         e97y6cg3x5J7xTEjM2JlcMk4QbA76oSogOPoc43EHmLtC2cr8kU+PyXGWhD/b3qQeLhw
         eQVEjfb9T/EEPmlB++JwFFi8MLeCSDraiAKuHXSqM9+DGb0dyK2t0lqb2Hpxzwhb/Rbp
         hIpjJG2mjMyQ7C0EZYCv0wTIbHZVh3/GApXphe5Nroikrv9BXetB5xm5vdQmhrE8OJOi
         zudQ==
X-Gm-Message-State: AOJu0Yw/ItDfl04Bs+WiSqkczrveODB1TM0oYJPHcYvFYRboK3idizXB
	aiEVtJqUlAJ9GMW9vY128KfKwlD8UUGnpXe6UUNtNS6myKId0v3NzHM60Bs+EA==
X-Gm-Gg: ASbGnctd/IRc4CiSlR7ICnAl1ieS7EbVrEcBqSv6GaPGvrEGDB4RGO4YJ2bE7RdjiTS
	twkrNZdTQM/sUNVNvDt/kuShQhhuHF6MDv0JPP+6mRQ6ZL6oUQQiqkVB1gHaGXVDGEbj3M2spAe
	eOzuYcTp3eepj/4bOYCEBQaVxBwXWhPtYRKg8PCth0j0IY0RxJJUuCZsq4nYnu3I4bdseLppimZ
	MdOGLGnicSaXin6FeD4TzpQMd+FT2OHQ4/ROK4OXMTYd4o/EHVDr25GhlkIrxPQsIwUQwT9gK6k
	L9iey/eGwSrm0BZN/gb07D5nW+9oJ1jDhaBDUlQcmRi3EhA7yVAuG8SE0Rci
X-Google-Smtp-Source: AGHT+IFg6PbCJykgEIaP4RauSlaTrid3Wz+OgE4C+L+jwZ9u9/LvDrktm5eCC+LrKCajBp0j3msv1g==
X-Received: by 2002:a05:6a00:3cd4:b0:730:96fa:bdb5 with SMTP id d2e1a72fcca58-73426d9b38dmr8599645b3a.6.1740437573573;
        Mon, 24 Feb 2025 14:52:53 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7347a839dffsm173674b3a.172.2025.02.24.14.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 14:52:52 -0800 (PST)
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
Subject: [PATCH v7 6/7] mseal, system mappings: uprobe mapping
Date: Mon, 24 Feb 2025 22:52:45 +0000
Message-ID: <20250224225246.3712295-7-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250224225246.3712295-1-jeffxu@google.com>
References: <20250224225246.3712295-1-jeffxu@google.com>
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
index 2ca797cbe465..8dcdfa0d306b 100644
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
+	vm_flags |= VM_SEALED_SYSMAP;
 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
-				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
+				vm_flags,
 				&xol_mapping);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
-- 
2.48.1.658.g4767266eb4-goog


