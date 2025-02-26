Return-Path: <linux-kernel+bounces-533949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 649D1A460A2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7907E3B0863
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABFA1552FD;
	Wed, 26 Feb 2025 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/59mtJJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A2B21930F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576184; cv=none; b=ApU0okvoYqeBcjO0LD2jMAjOymDBDv3glFRw+LzAiMNN+uVf7Df8364MPr1Zf3dZMwFLVEeLZcP85oxAtT5H8z0itg82hg13IIXJ0KXeBSsldsqup+nM9P5p9etiscJ23MYF1HzcFiam97IiVUy8q6w5IEQyyoBoQq9RgA+N5JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576184; c=relaxed/simple;
	bh=tLkaQa4cfAIJbGo+O9NomPzt44NtjxVBQYhijZ1Y1JU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qYpKTZy4HoHr+XOilqWbga2tyaKI3SMOqZSx49l1CbDNNW4ihedv09fNjaS9AEJqSeDhOu6Y05p7PdxolvUvHv4Ku49o0RyZ9Rk9SszVkLjZ/KwJ2XKa9G6cCPDAq62EUn22iraDiTpAjRnoFd05b/0uK1095KLYZQBcoLZpHgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/59mtJJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740576182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0KIzQ88nSJEUkvPD/1MUYrSo7xR/JdvqjXJ/Jvu0wOc=;
	b=R/59mtJJm8QmOXaE7ucfwTPC9VJpYCS2wiKTc31nu0n/MNKCwdcB11NbArHjvg/8xhVypC
	OAleIpg/vLPYIKWdT63NXJfSo3hf0NE0fnNKfOmkXJqDbcDU4/hCW1clAHflu+ru7Owv9R
	U2pUV8kZX3h0MT1+14ruhL/VBK3oB/U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-zoZleFxePzCBl9WYWsNksw-1; Wed, 26 Feb 2025 08:23:00 -0500
X-MC-Unique: zoZleFxePzCBl9WYWsNksw-1
X-Mimecast-MFC-AGG-ID: zoZleFxePzCBl9WYWsNksw_1740576180
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4399a5afc72so34377755e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:23:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740576179; x=1741180979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0KIzQ88nSJEUkvPD/1MUYrSo7xR/JdvqjXJ/Jvu0wOc=;
        b=KAAiWVpnhz5JljDYohQyAZCYGjscD/gR/FjHCHTattH4Bogr+XqrgoU1QPeC+IFq/L
         G3/qHv5jswuWuPJQ/ClR50CdUiHi5qvn+YXngBtrwmkwqEi6XJkuZEhX13eQDRu4usc+
         l+jpC8yb+BG4A7aBZ0zudjKCfE/egIKGJpAytuchktbJ/o068ZdaTfqIxwE/jajw5yiH
         27s6/HWISo+dBoitNGNU6VaTZ3TfSxefa6QzBCc64+R2Sx2exsCyEnsj4WkGrXh5WezZ
         AgZbM5Ugk2MSJ3FIMVLnYo0hJx0dpcN7G85+7SwNo9lwFFoT3p0/iHXgY4KWdxU1AmdZ
         alTg==
X-Gm-Message-State: AOJu0YyyzO2h3BfUG7JESTbXoGBofRT7HTueYzK2zDYcetQ7Ps43RRdS
	10HhpwZqT7lHQHVYqoq4A9f5TWdYanEnJfpfk3WE7IP1OjngJSebzFyc7UFEO9mR2jvfo4HZqJA
	NRBni6HVVK5IFBu5vC3130XHUkvZ7BVQ7DS1XtrHEzBJEkodeeb1hsZpVhvKIuwx7eCMF7J/GFs
	28MA1KO5gNHQXAhSyTBrBC/hnECCC3tbj5rIj33ZNZoHUY
X-Gm-Gg: ASbGnctG82yY9n1Y1/G+eDVeQbclpMxGVrReioVdGU+gMXhgcGDMFqKcjq+A5L+6OwQ
	HZeAfZx/Wlqxm7wuAS1ZLjOJH8NEqGD1dN11w0wFkzDFpVHLAhp8tzYAVW9buiCqaM7yMuvv8+9
	jXJWSsbgmqhzj44NpXK8dYZUUieQqT3cZcElMZ396G/CVgZo3kGy1EMnkKyD3lHI029BvjFJtAz
	ZBwxmXwhzH0CBcdIdDnXUtDL8R8P0BNkWXA2pPqQSZWW0Juqk3ojIUiOuIkWjs+n9WdhrwxnDJ9
	7VEElclMiSQX8Au99b1aSQnwDWf8hwWJGFXpgGGQ4tbwEWPMsZ2nk+GrsVdgGfdD+1+zcm5Nv4e
	3
X-Received: by 2002:a05:600c:1547:b0:439:884c:96ae with SMTP id 5b1f17b1804b1-439aebda78fmr163974925e9.27.1740576179649;
        Wed, 26 Feb 2025 05:22:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYmafSYOsvhjIUXUgOdRtbAha8lg9dhbnpxUsrIq8hUAH0/uonO6MpAq39RzjuvyC9SSC1fA==
X-Received: by 2002:a05:600c:1547:b0:439:884c:96ae with SMTP id 5b1f17b1804b1-439aebda78fmr163974685e9.27.1740576179160;
        Wed, 26 Feb 2025 05:22:59 -0800 (PST)
Received: from localhost (p200300cbc747ff009d854afba7df6c45.dip0.t-ipconnect.de. [2003:cb:c747:ff00:9d85:4afb:a7df:6c45])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43aba532c32sm21210325e9.11.2025.02.26.05.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 05:22:58 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 0/5] mm: cleanups for device-exclusive entries (hmm)
Date: Wed, 26 Feb 2025 14:22:52 +0100
Message-ID: <20250226132257.2826043-1-david@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Based on mm/mm-unstable, which already contains [1].

Some smaller device-exclusive cleanups I have lying around. Tested
using the hmm selftests without surprises.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>

v1 -> v2:
 * Rebased on top of [1]
 * "mm/memory: remove PageAnonExclusive sanity-check in
    restore_exclusive_pte()"
  -> Added
 * "mm/memory: document restore_exclusive_pte()"
  -> adjust/clarify/simplify documentation
 * "mm/mmu_notifier: use MMU_NOTIFY_CLEAR in
    remove_device_exclusive_entry()"
  -> Use MMU_NOTIFY_EXCLUSIVE only for a single purpose such that we
     always have the owner

[1] https://lkml.kernel.org/r/20250210193801.781278-1-david@redhat.com

David Hildenbrand (5):
  lib/test_hmm: make dmirror_atomic_map() consume a single page
  mm/memory: remove PageAnonExclusive sanity-check in
    restore_exclusive_pte()
  mm/memory: pass folio and pte to restore_exclusive_pte()
  mm/memory: document restore_exclusive_pte()
  mm/mmu_notifier: use MMU_NOTIFY_CLEAR in
    remove_device_exclusive_entry()

 include/linux/mmu_notifier.h |  8 ++---
 lib/test_hmm.c               | 32 ++++++-------------
 mm/memory.c                  | 60 ++++++++++++++++++++++++------------
 3 files changed, 55 insertions(+), 45 deletions(-)


base-commit: 598d34afeca6bb10554846cf157a3ded8729516c
-- 
2.48.1


