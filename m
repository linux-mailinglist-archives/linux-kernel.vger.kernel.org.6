Return-Path: <linux-kernel+bounces-276932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06962949A2D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B27B1C20D29
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3B3171E55;
	Tue,  6 Aug 2024 21:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRPnC2oO"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067F516CD3A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979737; cv=none; b=cuUOHYVyEkr1HTszcrne4m6jMrVUzVImpa5LPdiEWSrNDc0xUrPMgWbB3aQvS45c93M2YJOf2m/UUKDOn1eWKa8xlIoMDAC7pipRtp6PfbLhKBf6JhDOu0AcayCGOAcj2/PRPv99/KhDWiG3qiKQlZwzfS6bPfvjqy/EuuBMFRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979737; c=relaxed/simple;
	bh=J3RsfOXy0wMCd4CO+SuDFXD7Ne6CHmH7bPS7wuF1LZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzqwLPBkywLvAk8iKiFJnOqYAoVpqnQohhnOlQPCKGsw1hhwS29R+qA6/XX5ZLt8wBVGxyGO8t/ywoMO3t4VsWGCvrLOuhxT6AQzKAm2sARAqUiyj17ejDOkzb0CE/LdcVmMdltXfbfEOQNo2xz7fLi2dj1OFVn631ivjtP45SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRPnC2oO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4280c55e488so1595285e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 14:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722979734; x=1723584534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2+YFPOHRh49qf0SxMlXaqe1DReRnNNIKrNBJS++4hY=;
        b=PRPnC2oOyDocR16LTY6Vko8s9V9wVgwQqNk/S9gT+bWBfXSvs/nWmELfu5GtNGCtrb
         ebYsNBSACQ07k6cu4atM7fLUc3HxOZvhRMYwQX4Use8dLFqg4/IR/U1TkQ/7Xx7kFirW
         SnF2hEYSeKlraMBUHcLxfuyWfPrVMEIyOs7B3FgvhXl/JvglP/N7DXXdBbab6KKmvm9l
         DBN1THCyeHCn1Hmtd8Hcyj8ywrfCb5SmBCeajDD5Egg/CFu64fZ6XcMja0YVsk+c68wC
         6O1OCMaP9dMNDvjrtQw8NGD8H8B3kpQuwHZXyz1ktGvay+J3KH3XVli6RorsfwYyubqv
         ei0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722979734; x=1723584534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2+YFPOHRh49qf0SxMlXaqe1DReRnNNIKrNBJS++4hY=;
        b=XPWXQTs2Nhe6FbUPPxfnRmu72OTi7Q8cbC9JpfG4ZFjuyAntys7+8gBh/tszZ8/PPd
         /Elqu+uDbV7L/plshArsbkcZ7s3uCX082Vt+FUhuCY9E0rOfIct9SNNu+IQ4MGTj918l
         uc62o9uCB8UKPE77TTrPx0wH74AtLlHG3YkKdh2XOvzvRGGFjAuwxe+oDOhTdX7VIE/e
         f49ZJ53nXJ82xB5PtjrsubvzYbBIew/qdZhoR2KiWBU4fpefKoP56QHmHjKyGy79o0Sa
         LEI2KHxGkHTagx8fVsF14zzqxBHHt7so7raaJsQ8dQwS4FG8SzOvTTnS1nxkcBb5/r2r
         BVgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUszieDbqemjdn/cIRMYTyjClqeAuzoDCutggYxBPTKoHmyBx+ANIDSUgKZtyhSlM1BRDhyM8OoC8OEmdaJBd0u8vd7i5Fj5/TRIajw
X-Gm-Message-State: AOJu0YxpIh14FSV6kSAXdRAvHWfb1VCol4zidBa8hnRf82y8D4iqP9QW
	z4bGCGI3Vz1h2GdqR78p2Hi15xE8nFwKW/HWWmH85Yeni7+yYUY4
X-Google-Smtp-Source: AGHT+IH6Xr9SYyBvEv8fSy53cCmNf9TVkU4nZGyjvO57KE0CLwbkZFyi/Yg4WH8MbnlrA53Ir0lSgw==
X-Received: by 2002:a05:600c:19c7:b0:426:6fb1:6b64 with SMTP id 5b1f17b1804b1-429050c2b96mr821895e9.7.1722979734120;
        Tue, 06 Aug 2024 14:28:54 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290501f0d5sm1858545e9.31.2024.08.06.14.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 14:28:53 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	oliver.sang@intel.com,
	torvalds@linux-foundation.org,
	jeffxu@google.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH 3/7] mm/mprotect: Replace can_modify_mm with can_modify_vma
Date: Tue,  6 Aug 2024 22:28:04 +0100
Message-ID: <20240806212808.1885309-4-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240806212808.1885309-1-pedro.falcato@gmail.com>
References: <20240806212808.1885309-1-pedro.falcato@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid taking an extra trip down the mmap tree by checking the vmas
directly. mprotect (per POSIX) tolerates partial failure.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 mm/mprotect.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 222ab434da5..b1980ea1cc3 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -589,6 +589,9 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	unsigned long charged = 0;
 	int error;
 
+	if (!can_modify_vma(vma))
+		return -EPERM;
+
 	if (newflags == oldflags) {
 		*pprev = vma;
 		return 0;
@@ -747,15 +750,6 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		}
 	}
 
-	/*
-	 * checking if memory is sealed.
-	 * can_modify_mm assumes we have acquired the lock on MM.
-	 */
-	if (unlikely(!can_modify_mm(current->mm, start, end))) {
-		error = -EPERM;
-		goto out;
-	}
-
 	prev = vma_prev(&vmi);
 	if (start > vma->vm_start)
 		prev = vma;
-- 
2.46.0


