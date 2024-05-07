Return-Path: <linux-kernel+bounces-170548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D629B8BD900
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8341F22CA9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8C34C8A;
	Tue,  7 May 2024 01:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="olns2BJJ"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7C49476
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 01:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715045724; cv=none; b=mfn2vELwWO0+QEXVBt2nFJxgfsaloBWYxdJgt+WMVAdb+rfQ2Ssk35omvFnAc8JoH8qU6MhXIIfAdMajlgyZvuxLyfWNw8Y2j793kUB4Q6c0Tf/nMkSlkOtqCMY7lM4m/hX3PFywgjf8oHvCwZVQiiKsxpsgXM8tblUeVkaZC1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715045724; c=relaxed/simple;
	bh=yHji+jPlK5HtGbHDPaiRlIeWCMB1WW7gh1Mb0zcd+kE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OTcZYIdyHuTjddZkq+dqLhDqlEPMx2bB8/fIUYfCmVJGDLlmgadOLMSztgInHMUQ20k5uTSnFqJSvBtZ986ARb8boIJf+XRv0oP6Gq5QpY6JfatIlDxEkGX1JhyXzT8uusAatbvlgXlu924cSWEiBj0Qh6IeKLVq7mVzXidmHBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=olns2BJJ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f43b7b8d16so1306334b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 18:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715045722; x=1715650522; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R/bnzbSJAXZFgmEbPBHDVFaqHmMct6aExezW7/txLIk=;
        b=olns2BJJDxjIhYKFEbB2K/bFOhEnZFwEKiBgVCkmMWoRFU+hBKNzfFhksHIrNTgVTI
         p6yHPJbNPQDSOK5qthz3bGwjpgUxAxwWu18t/K3WobI1V8yz2AsPI5xn1dVAwqKzoMvA
         djPJAfM+LmgeFmRYajH9jGqrGrnEoGuhCBqj8knWud0I5tT4fB+Wiep6DoC7UIBceUv3
         E/u8j1gdv2tdZsoWjOrrw8B0AQJAO+8UM+AfpAOIfYTUvRDwtn/SCtWpzx7Hl2KjkV+n
         eiHS2BVlYb4/AZ9lgDXc9fZuyDWVEBKI/64YL/tQFuKNeJfaY9ECz0ZeHlAidFpxsK5Y
         9Njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715045722; x=1715650522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/bnzbSJAXZFgmEbPBHDVFaqHmMct6aExezW7/txLIk=;
        b=VHWkLhzRTe3jb9LTDq561RPCJk+JPwXtnS2exbH+4Y9bIziMKrgF569y+kyyhxjsR1
         xIDoxtDU9CJVZCoKYt8vEeoWjk67dEuUhoHHX0LZXem//JWVGgn7SNMNKLZQ5AJ8tDWo
         fQ2uA2b0JhxJPvVB3A6SMGWtcX/9U1vg7xSe1vlHnRrrEfx4x0pQKj7JoLtz1lOoLoFv
         NxTfUUaphX7N2C9dORLDlssp8k1C7UCjqHkDhJKOYswoTCmcGkPca+kiHJrVr4uSQEkv
         570W9hhC+wzcp63syZYwi/gOCHxYusUdUfYt4KwmINGGaP0Ylff3YK6byhNeRyfKuMYe
         15CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcq/jk6iWWSNTBCRcWEJNdevbK4A4f1PRBG7EBzIJDB/plR7wC0G946WhSZj71cSmhjTf0UgHlpkk7mYacjo1uUFCAqq24wTAPxMv9
X-Gm-Message-State: AOJu0YxVgiXWXRmyjGIEn2VBgggnNAR5xnB9dXqABpxuFHGm0Nl3S1qt
	rE0QqYcAjJs8qOqgflB6mPIxisXcfpT9bgZr8HVJ1J94ejuRzwHBP3gO2OultSeUPSmZqlCKDW6
	YlhY3klRY797dfQ==
X-Google-Smtp-Source: AGHT+IGGZ+NstWXq7egCt4Q2X3ou66u+vMwg9taUXdD3duDfaf4EKELaL9mU0nvKTJASn8m7peD6L9yTHllTAZU=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a05:6a00:4b4f:b0:6ec:f266:d214 with SMTP
 id kr15-20020a056a004b4f00b006ecf266d214mr204791pfb.4.1715045722260; Mon, 06
 May 2024 18:35:22 -0700 (PDT)
Date: Tue,  7 May 2024 01:34:59 +0000
In-Reply-To: <20240507013502.3095744-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507013502.3095744-1-tjmercier@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507013502.3095744-2-tjmercier@google.com>
Subject: [PATCH v2 2/3] doc: swiotlb: Document SWIOTLB areas parameter
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc: petr@tesarici.cz, mhklinux@outlook.com, robin.murphy@arm.com, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 20347fca71a3 ("swiotlb: split up the global swiotlb lock") added
the ability to specify the number of SWIOTLB areas, but boot-options.rst
was not updated as part of that commit.

Reported-by: Michael Kelley <mhklinux@outlook.com>
Fixes: 20347fca71a3 ("swiotlb: split up the global swiotlb lock")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 Documentation/arch/x86/x86_64/boot-options.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/x86_64/boot-options.rst b/Documentation/arch/x86/x86_64/boot-options.rst
index a37139d1752f..18161657b301 100644
--- a/Documentation/arch/x86/x86_64/boot-options.rst
+++ b/Documentation/arch/x86/x86_64/boot-options.rst
@@ -287,9 +287,11 @@ iommu options only relevant to the AMD GART hardware IOMMU:
 iommu options only relevant to the software bounce buffering (SWIOTLB) IOMMU
 implementation:
 
-    swiotlb=<slots>[,force,noforce]
+    swiotlb=<slots>[,<areas>,force,noforce]
       <slots>
         Prereserve that many 2K slots for the software IO bounce buffering.
+      <areas>
+        Number of SWIOTLB areas with their own lock. Must be a power of 2.
       force
         Force all IO through the software TLB.
         Hardware IOMMU implementations can use SWIOTLB bounce buffering in
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


