Return-Path: <linux-kernel+bounces-170547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D93B8BD8FD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53409283998
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975E34411;
	Tue,  7 May 2024 01:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JedWn1rF"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C318BF9
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 01:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715045707; cv=none; b=soYYXuBG1fBsHPLsCIAKyjlB3j/Uwsc8Ey6h/7GsLLitkEFxawojGYgRsjqe5pUExl3NRbkjJbwTZZb6h4y77zpQDYnwaL3RifTMd+zIerYOXIskexht89miKFT7xrAJCW36idCPmrzAkSXbTZhCHoS20IzSDddaoDPeE3efLhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715045707; c=relaxed/simple;
	bh=3sFQ3oorN2sYH+TRgu6JQoQN4wat1gdTAxjHx6Ix+nY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lz4bH+oDedXRDvmyBBoO7kscOa7efKBk713mjUF1OtlpG1qPw1+uCOKNgQIMA6m0oceVUSQyHke5+b9Q8hBXFUIhvTcLJkjM9nc1PQ7lrapcAwlIfsd/H+DrPnBDjk8ZHbeSG/cbvK9+SED3kZp+V1Ga4Vy2FpU01TQQUPFmj0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JedWn1rF; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f452eb2108so2240593b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 18:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715045706; x=1715650506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wWPx0hbS4Fx5dUBb1jNRCKK+9py33z9FzaPCsuqEbdI=;
        b=JedWn1rFE58npJ5Osh9TmFRO1jAPxeK/AdwMpOd3ro0rCcF81yBixBwAxDk6d+Gdkd
         tws7QTjPt/S8y3DtxBeNPehHViR0Y0jI3wQEx1rw5VCvRqKSmG4FIZ82DaCSctu2i5g+
         A876pf9f4PtimzV51CbJU6Qs/ToOlCvkjFRUHKhqALu77gwwfGTSzPF0Fgudkl8Tdqyu
         pQIDo3jbZ9mw0OyW4J3D+7zFtCEaiXid4x5TpcXPBZ4a5ruu8mtHGDvffo1n+rS0nyV/
         VVKKn8SN6nnXy1VWjdljYYH6Unvnw0TzjDP9+43u1vwb23mJCSdb2wGCO2HoM0OHbM7C
         gJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715045706; x=1715650506;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wWPx0hbS4Fx5dUBb1jNRCKK+9py33z9FzaPCsuqEbdI=;
        b=Il9tixcyBMkTqoZdUJgCMqKrvnFFsGdZ/v63+wOeNTCrFRECufPQuB5nJ3ceTJqrzo
         l5mjf7OlRbtWquQ+J5CdlW/K6+lwrmP9hNk1I3XpCTVrvApVihoWY1ja0FAl6B6cV58K
         ec7v4L42qdhTVkOHSaSTcsV73beSMI5G5cAGiTYGCBG1I1yUovVqr6pIM7AA1wiG5p9m
         ns+OU00YlXeGfJdY08Bbu6GXiLANP8B4I+Ck0tSH0dGsGeGru0ttzvgkrXZDTsI+emCH
         vEfe0ajBUdqkHwSCFWo9wRzPL3nK6veZFRFtK/KuH8O1aCrFmtNJzOZyTFcBVPSEgjuH
         CE/g==
X-Forwarded-Encrypted: i=1; AJvYcCX4JS4OMS46bF8URPlEczoOlLUy3vXpHrZwNQOut2EQ4sn23T2pQo91EK9bxCZa5tU5Yajnf9h/gd/3DU0aNoOrI89qYzFpj/E/k2yy
X-Gm-Message-State: AOJu0YzLNAS+V+z3oZ3VDOh9FVg+8rMLXw+X+FawG88Vit2kxdLqRiq7
	v1u4RKJUSrSpac9V0u6aA/4UfAEALTuYgfltzpEXhx/Uc8EE6SFKjXIZrbYhMXq1nNZbzztqKST
	c3j6TMcXqfuBvVw==
X-Google-Smtp-Source: AGHT+IEcNGcBy1L8PKzmea9STRs3PMKy69OXcUxT6Ds2uK4v9u5RPZi+uYX90I/FYh4HTG8zHGuwfmury0PL9Lw=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a05:6a00:189c:b0:6ea:f425:dba2 with SMTP
 id x28-20020a056a00189c00b006eaf425dba2mr10498pfh.0.1715045705743; Mon, 06
 May 2024 18:35:05 -0700 (PDT)
Date: Tue,  7 May 2024 01:34:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507013502.3095744-1-tjmercier@google.com>
Subject: [PATCH v2 1/3] doc: swiotlb: iommu/dma: Clarify swiotlb=force option
 applies only to dma-direct
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Cc: petr@tesarici.cz, mhklinux@outlook.com, robin.murphy@arm.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

IOMMU implementations now sometimes bounce memory through SWIOTLB to
achieve cacheline alignment [1], or prevent DMA attacks by untrusted
devices [2]. These uses of SWIOTLB differ conceptually from historical
use which was a solution to the problem of device addressing
limitations that prevent DMA to some portion of system memory
(typically beyond 4 GiB). IOMMUs also solve the problem of device
addressing limitations and therefore eliminate the need for SWIOTLB for
that purpose. However as mentioned, IOMMUs can use SWIOTLB for other
purposes.

The swiotlb=force kernel command line parameter does not impact IOMMU
related use of SWIOTLB, and that is intentional. IOMMUs cannot be forced
to use SWIOTLB for all buffers. Update the documentation for the swiotlb
parameter to clarify that SWIOTLB use can only be forced in scenarios
where an IOMMU is not involved.

[1] https://lore.kernel.org/all/20230612153201.554742-16-catalin.marinas@arm.com
[2] https://lore.kernel.org/all/20190906061452.30791-1-baolu.lu@linux.intel.com/
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 1 +
 Documentation/arch/x86/x86_64/boot-options.rst  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 213d0719e2b7..84c582ac246c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6486,6 +6486,7 @@
 				 to a power of 2.
 			force -- force using of bounce buffers even if they
 			         wouldn't be automatically used by the kernel
+			         where a hardware IOMMU is not involved
 			noforce -- Never use bounce buffers (for debugging)
 
 	switches=	[HW,M68k,EARLY]
diff --git a/Documentation/arch/x86/x86_64/boot-options.rst b/Documentation/arch/x86/x86_64/boot-options.rst
index 137432d34109..a37139d1752f 100644
--- a/Documentation/arch/x86/x86_64/boot-options.rst
+++ b/Documentation/arch/x86/x86_64/boot-options.rst
@@ -292,6 +292,9 @@ implementation:
         Prereserve that many 2K slots for the software IO bounce buffering.
       force
         Force all IO through the software TLB.
+        Hardware IOMMU implementations can use SWIOTLB bounce buffering in
+        some circumstances, but they cannot be forced to always use them, so
+        this option only has an effect when no hardware IOMMU is involved.
       noforce
         Do not initialize the software TLB.
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


