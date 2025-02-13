Return-Path: <linux-kernel+bounces-514026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F91FA3517B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB1F3ACE68
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12762270EB2;
	Thu, 13 Feb 2025 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hFvHVQTv"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE7C271269
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486832; cv=none; b=l2oRZPpJhGFMZ9EB/nHCIAHWAqgzET1l5XYMZxuI6Pa5ud3vPvJfoI5x3KoGqh8dEX0vSnR6lNOnXSAswPv51G8+EM2/s3pdwEM85Lqa++HsT58d7rK6QL+U3IG5/2//hnaAhrgvhgj4OD3/0iaxM+vIkLiLDpRzjIMDuiSuyuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486832; c=relaxed/simple;
	bh=ATtmJB9nahc4mob8MkIy5UZyQCyWqmMlFiBDBX7j9Mg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gufAjavZCRb+rxJAJBXI0G7Y/cGW2KLeBvUOCLyFmmPjEVABzW82VxB0olEeJgZ/m5tMhC1KEH4e03yBixjtxNKkakX+/azrxqWdURFwtkzeBN7gEVsu0iCGzjhTZ9mHPf6cLsd8Kiz+Bl2QUCZMj/ZYf1bxgjNPTOesKMwaxYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hFvHVQTv; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f9da17946fso4901763a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739486830; x=1740091630; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hOJYwLimtWGBUdGEfM7iYC8bKir+nyDvGIJQLaOGSbI=;
        b=hFvHVQTvWUSO/aAQy3R4NQszie9FA13Hd0K1EPjbSaoHwdNZMaoGYMqGwkhark0DRV
         HjwMxd12IWRds+Sq2FjbBkTr7Gse4aGCFcGU9wxVkKUaQ0V06QR8i+WZyNiVTKzkezPM
         406oihRqCTWkEwpUYvGDHuGr/S2GmKCmoFQsqxUOJiOFqv9ZnapzTHhbJ8+GP2HKcpFn
         QrBIl7eCowm1M8GRpuFkqe2nu6Cb+7X7C74lOU8xiMRSI9u2Ar1ZKE9OB0gQb0OYEwvg
         8p/ryhPBbKBbqccAqVkPStz586qen0q9YQj3HBPXMHE/FOZZELuf7WTdjII+1wKZDndC
         VihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739486830; x=1740091630;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hOJYwLimtWGBUdGEfM7iYC8bKir+nyDvGIJQLaOGSbI=;
        b=a8fi6DPpwDNkUA+kDP7IO+x6CD80eFH13TmFNM2GaZybmOeqqtyqmhzsJ28VxT0Y3u
         /IfaesyjNnvqMmm2wvT2v1JVjsqwfj2SbBNQPAE046KAGvIkO2vxB3OapTANg1Y5jR+s
         3fBFaqfyHDkQe4qCfQ/zhkPkilTdoMgjlbG2KBpCN33sPUjmiV6crQ+Ki6o0+EH/M2+C
         usbwerdUV3WnQEkH8CVYmtxvWK+z9i8kxindfa2s21SHguvI0VQospd5At5RTALDj6LQ
         g8KUBnvTn/yKiXWXTrhYYZhwgV6KWPfJa+MS9eF+y0UpOGLBmgyKXhskirJrISEAnDdA
         s3zw==
X-Forwarded-Encrypted: i=1; AJvYcCXL6yg5oWuzdkRvsj5J7akuFQyBONnyub4Gf3PP7oeMsCfQedpSVZvdFpKCKE0DINAxCS+IadRo/ku4Ofw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRzLIfa3gAtxRKgu7bu8jNywlk4ZbR/szJ3fHfL7e29E1YiHeI
	XnlidMFm1vU244xdsJ71Q1Dwc/IKgQK/BGO/o/DL4Y3TxjYccWv91G29zkMc166OzNwAMyFGX1a
	aNQ==
X-Google-Smtp-Source: AGHT+IEOMdpbXGqVMbthd+OaRfeUWGsGbBZNR4yGOFrRj8/MuVDw8EpNm8XS12LJXdTQ6lIEpIij678/S+8=
X-Received: from pjur3.prod.google.com ([2002:a17:90a:d403:b0:2fa:27e2:a64d])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5245:b0:2ee:f687:6adb
 with SMTP id 98e67ed59e1d1-2fbf5bc1df4mr12403072a91.3.1739486830202; Thu, 13
 Feb 2025 14:47:10 -0800 (PST)
Date: Thu, 13 Feb 2025 14:46:42 -0800
In-Reply-To: <20250213224655.1680278-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213224655.1680278-1-surenb@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213224655.1680278-6-surenb@google.com>
Subject: [PATCH v10 05/18] mm: mark vmas detached upon exit
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david.laight.linux@gmail.com, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	lokeshgidra@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	klarasmodin@gmail.com, richard.weiyang@gmail.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

When exit_mmap() removes vmas belonging to an exiting task, it does not
mark them as detached since they can't be reached by other tasks and they
will be freed shortly. Once we introduce vma reuse, all vmas will have to
be in detached state before they are freed to ensure vma when reused is
in a consistent state. Add missing vma_mark_detached() before freeing the
vma.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
Changes since v9 [1]:
- Add Reviewed-by, per Lorenzo Stoakes

[1] https://lore.kernel.org/all/20250111042604.3230628-6-surenb@google.com/

 mm/vma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index f72b73f57451..a16a83d0253f 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -427,10 +427,12 @@ void remove_vma(struct vm_area_struct *vma, bool unreachable)
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
-	if (unreachable)
+	if (unreachable) {
+		vma_mark_detached(vma);
 		__vm_area_free(vma);
-	else
+	} else {
 		vm_area_free(vma);
+	}
 }
 
 /*
-- 
2.48.1.601.g30ceb7b040-goog


