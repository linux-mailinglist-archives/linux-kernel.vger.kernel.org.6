Return-Path: <linux-kernel+bounces-524656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C7BA3E57F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D3C16412C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7C9264608;
	Thu, 20 Feb 2025 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="emRDzpyd"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30166264605
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081734; cv=none; b=UNYhoY+6FQ3IvQq50RS7FOGcFtVvhe9tM2kCGuugsikrbT7iw6zAah0nBoz0K3ae6p8+Jy0j1qtYlRMSLj7YKdmk9m+7hgbs/AyL8CogVHf+diesHHbhJNO2C0aPh99n7ElQOGCA6FmCFHGRIqIXs2O882gHHo+IePHmzhaLrWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081734; c=relaxed/simple;
	bh=0zUHcZLj6mDGJ5NV4Z2Bhyp+UHOT0+5i4Uzdr6zWfAU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QJAC3tlLSYg/szebEVaEZ8q1+CLEcCaaqd3qsZXBf/ufX5QvwJ4HES/Yb4bZVVfZJt2MhgLJxLOy7poBLDNoOpS8201V3lHL6n8Pk9RphIJZ05OhkF3L4Tgauu1zZs5T/g8Pc94RZfAAPpRjex768DeiG5zX49K3mDFfhNy/Frc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=emRDzpyd; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2217b4a48a4so26801945ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740081732; x=1740686532; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bs4ICV92lNNA+t7itNY/GyIOuvUFwmfXCBMREBnAmzs=;
        b=emRDzpydxlA4C1GuEuMboXXaqwWV1bsdYeAwaFQ7lMwEG9UmKfPWMGatzXT3nEnqkk
         WA2EdDUFDBk9heUXpf6WV1f3wIJWkMLvyd07bC3VfZBqfIOhl2itHmTx7v5KGsbGGZiO
         RSD/2iDnwBI6uMhrr9A2ZTBBgNKckoxXD4S3LBSVCdoi+4nCoyAI4rh0RndmAtd0tJSa
         N9d4WOvqk+aTipKQV3tRC4uwk98SU4JwaCmcybDIdtbYQ+Fz5Cm0llsXUuu/CSKp/9Jg
         4uYkdA8zwdAQ/6B0TtrDh605KLVLSgJ1Jbh1oVJRqzdRjCDXP/pOrKIJJrVdmQp4684l
         JAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740081732; x=1740686532;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bs4ICV92lNNA+t7itNY/GyIOuvUFwmfXCBMREBnAmzs=;
        b=RNIaCq1xbZjTjqv+4qnujAneaS6uUEUhvY73KSfqeXMQlWX5/qiPBlnx4VMwiGhi+B
         2LjqaFe3gqDdY/zUDhjhdZYQKIFlajB2xt26gk8QgHqfowYQtnMW9Twss2mZMdYoNyP9
         RoHubuyI7Tmfo3RhsG7YQ329PcKBaSKkGXjVb3mSqNnyyp/13ZYGFjnXEMNRqni9s+vL
         n1fboDWNjJJ1BhUbnehM7hzh6+02ZLYd54uAq51pCpUbHYFa9/SGxPNvkYxos/RqkdG6
         1et2y++1W/Aa8ZzH4AD7vQ8n4HfIzpEQq4FXsen4nExTXl16KTH2TxQQyfhpNwdhRkLG
         9jxA==
X-Forwarded-Encrypted: i=1; AJvYcCUP771MEjyaP7IQ3tTEj++XXtONInoJmlEHnXDVw1z2DzQqm5Avwy1MNEq9WioVAlVOkMIRSmDWGn3+iaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVoILrd6RuB3ZYcneSUE/Xta6k481Tq/L8901+P04WLYZUpbDK
	jsnEQzfQXxUM78wFIePcVAmkBVbGb/0LSUF8vE35JBnz1EbzrZf3TuvWV058JC30/Efs4hS8WQH
	yJw==
X-Google-Smtp-Source: AGHT+IGhnv/b9NKb1nCWT3Dat4UCewxN6QZHqaa7b5Lzmmmpxs45FNSKjTV31tV543Sx2LCzk8TNaJay418=
X-Received: from pjbnd6.prod.google.com ([2002:a17:90b:4cc6:b0:2fa:284f:adae])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c8:b0:21f:6dca:6932
 with SMTP id d9443c01a7336-2219ffbba1bmr6717575ad.43.1740081732407; Thu, 20
 Feb 2025 12:02:12 -0800 (PST)
Date: Thu, 20 Feb 2025 12:02:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220200208.323769-1-surenb@google.com>
Subject: [PATCH 1/1] fixup! mm: fix a crash due to vma_end_read() that should
 have been removed
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: sfr@canb.auug.org.au, hca@linux.ibm.com, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Handling a vma lock failure due to vma being detached from under us got
changed but vma_end_read() in that path was left untouched while it should
have been removed. Remove it.

Fixes: 758f7664c3d1 ("mm: replace vm_lock and detached flag with a reference count")
Reported-by: Heiko Carstens <hca@linux.ibm.com>
Closes: https://lore.kernel.org/all/20250220185304.8313A7d-hca@linux.ibm.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/memory.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index cacf6d53bdf3..567b45e5d149 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6496,7 +6496,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (IS_ERR_OR_NULL(vma)) {
 		/* Check if the VMA got isolated after we found it */
 		if (PTR_ERR(vma) == -EAGAIN) {
-			vma_end_read(vma);
 			count_vm_vma_lock_event(VMA_LOCK_MISS);
 			/* The area was replaced with another one */
 			goto retry;

base-commit: f7ed46277aaa8f848f18959ff68469f5186ba87c
-- 
2.48.1.601.g30ceb7b040-goog


