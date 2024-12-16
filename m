Return-Path: <linux-kernel+bounces-448008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F029F39CC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7D11643E8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F6020CCDA;
	Mon, 16 Dec 2024 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aepi4bD+"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30EE20C48A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734377090; cv=none; b=nR0on2jfAAjWdbq+63pWkOh6BIgWfOogZ3MUr1eT3sVpUx/mG4MqAM2aOMI/vAxxGRHXwMKpzKG9C9TcYdWX7QuWOuJ6Atcf7HGoi3/jg2AtyQnJjyJ34OlPbcZHmAWahsluYAmb8rCqmA6ocEcv7enDriO5gMJ9gzRs4QrF/Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734377090; c=relaxed/simple;
	bh=meptwdKdQlQfWYK30tfEjRISvkkyMSxm37GbBTGDJNk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ln7jXfrFaLox0GcD93L1Zl1DqF+TbOHy1eWPOa7T6QGeN1NCv7rZtinP96slPvKyw2VXovDGOAAzO+QMAQ2Qi+y1juP3maTTnpoCOM2RvSMAXMFY+BplthHugH5KcN/p6h6F9hqREhDckrtazu50CMWDgWbZTdYdqzxxmzbHe3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aepi4bD+; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-725c882576aso3306955b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734377088; x=1734981888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wSQ3mT4u4m7ofM+stpYMvUJpeXhYChT7fq9/vjKfHLA=;
        b=aepi4bD+deWNr6HmgUvSPHEvKqqWUVn+rm0wh60KGTZu/rH8ASHhhDsUYOsmkhPaEu
         nGvr99iWzLWuwdxFcWY9uQPGop79fbK4iqnwv0gPBQKDhEn5F8KiHB+SClo9Ck92Wq+8
         mVIXpjuucYYiUeFBCBgiQVvzfrQPdbDMNrVS3Se+fsOzDm0QMNrqtKc1qd2CApXt09ds
         NDSHv97a7ud4qLCkIL3bBCF415KJi53eVVjgiYAXlhBpeds9hY22TLkjCdx0Bz2ho8FE
         vDmP2BQqGngaCjGcupdp3FwRmUUZ+ca/EosLeoBqOaxiE2RsDx/N3qH1FYPUOihOGyWT
         +99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734377088; x=1734981888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wSQ3mT4u4m7ofM+stpYMvUJpeXhYChT7fq9/vjKfHLA=;
        b=lP881TYTs5ZgOyTmlv+Vd40CieMhQgL58qFzYyXtb/C0HteaEMcNG5LhKVNGInQI+F
         KLGr+04etRfdOr/23mIVZA5m9mVjkewwmcmMLjKDK9qfhq45Vy6eUfzKjIH5NAaZVQii
         SWUm9MSEmfcMVNOHaoVZVYhNN7UIXxXr8M0v+qVgfuFSVhiR7kJpeMcHhn0B/b1v9gFn
         E2ZKW8ZBkhDBuPyv7qofHGrkRSJSiq5IGGS7ChaSNBAd/0F9+nhPzGfIw+8jeKHYUN85
         k2X/RZtFRYzfBIycxoSHnWO4z2UQWUE1vou0V0Szud3DSaHCHAtjLWJf5seh+nqLxLtq
         I6mA==
X-Forwarded-Encrypted: i=1; AJvYcCXqgaV/n80B30IqUuzViZmf2VSFFiMS+f18yiIeNgPxIwZ2+8fwN39AuKjdGc6HHCKyC9Ujk1871j4K2+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy9mqk6yyXob5rgiM78GAMy+3KiQlXAGyHGojICADEc8yKiIy1
	D1MKJxA9qosCGiUywu18RvMAoKpHxNUenH1MnQMOARJwH402PN+ivg1TfuMkoMUJVlyxPok8p6d
	ZsQ==
X-Google-Smtp-Source: AGHT+IE4pawsfAUH9TLKs+lZMgX1XervLrLNUWY+S4QjAFjLPVQLu5/+TUucSp06ogqQfpKVSrSRx/CLyDw=
X-Received: from pfop18.prod.google.com ([2002:a05:6a00:b52:b0:727:3c81:f42a])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d8a:b0:1e1:b12e:edb8
 with SMTP id adf61e73a8af0-1e462d60708mr1104953637.30.1734377087952; Mon, 16
 Dec 2024 11:24:47 -0800 (PST)
Date: Mon, 16 Dec 2024 11:24:15 -0800
In-Reply-To: <20241216192419.2970941-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216192419.2970941-1-surenb@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216192419.2970941-13-surenb@google.com>
Subject: [PATCH v6 12/16] mm: remove extra vma_numab_state_init() call
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	lokeshgidra@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	klarasmodin@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	surenb@google.com
Content-Type: text/plain; charset="UTF-8"

vma_init() already memset's the whole vm_area_struct to 0, so there is
no need to an additional vma_numab_state_init().

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d9edabc385b3..b73cf64233a4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -949,7 +949,6 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &vma_dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
-	vma_numab_state_init(vma);
 	vma_lock_init(vma);
 }
 
-- 
2.47.1.613.gc27f4b7a9f-goog


