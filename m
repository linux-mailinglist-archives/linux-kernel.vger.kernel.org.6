Return-Path: <linux-kernel+bounces-378560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487C39AD245
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E490D1F2245E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC09B1C9B71;
	Wed, 23 Oct 2024 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K34B8m8s"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6941BD03B
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703595; cv=none; b=BAWMXNqrpTkhvWtBUc9OMMpnjfgB35J+rJrBgLjXcZpBfMZ8IN9I8NPbmFRBEvcvNcaI2179NvP+DKA2w0eRZFTth3Zt+Qh3gkP3MAJzXQVeH2PZfoic40si1PnqyYihpy3u66WRkgoWu1z0JHM1VS/C6HXG/aAq0QIGyrhFqsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703595; c=relaxed/simple;
	bh=XMx0iVOdnev2yY5IXdQu8voPni8J7VGilJV3stcjywM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DiawiE01yMe5Y5LCK2w147abFWWFdvBAArF9nmmYeffcfZSWEsD29kGcReD8b5b/j1JChJZEyFdggWnegneQlFkh3TTkg1C86I58SYTdmiGLu6T/zP1eolNZ2s9LDYVCCq1r3Mg2vAVU6e7Zr1UBl7RfOYm4Ri28w//ethvBmHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K34B8m8s; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28ef71f0d8so68037276.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729703592; x=1730308392; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sjJwOqBa6AK8/TR77kHwHcznf7IiYMoRphf6RMACy5Q=;
        b=K34B8m8s9AIcMVPLdniUuTotXk5+Tj2CiiUeaIj/C8jscB+lJz2N6j9yirWIONhKVQ
         +4vpwK5o6Y6dDoVg/8rouyK3TRIBGzSuuAv34ThBB1Y3KcEcr3ZeBsKWo4wgVo+xvuOd
         jmaA/LQeEPdfxdfU7Ucttpf4RpJ0VtoEtRaQoCAosc9vi5sMal7tY9EG9yACUfqjKdVY
         QceyOkdmOfrGkKwiSwST2KTVeZTdHu0jjzAtzlO00RS+9lT4+gLDu5IbfZ3U/3FICD4l
         V95MfRoZYkVrO7cXtJf13ScDHDk/K8x43fMg602DVm1UpF6h1pLtEbVIUAyPORnzoUhN
         jmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729703592; x=1730308392;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sjJwOqBa6AK8/TR77kHwHcznf7IiYMoRphf6RMACy5Q=;
        b=MnUv47F3l0kjpbPb1wC7vfzbZVgb6yz0Uzed2V1IgKZEZg4UYJ5TRGGn/cGE1kBAA6
         boS7mR1ua8O9J92aX2gMDpuCXHkYaSaCWROD3cBucacZWRc5W+mjgqj3U7NV1ty0Ke93
         2k1eruXOEcu5pYO6hUOBnAWvTqrQmky2/MbAgrSnPFsSxcWA55/yA64+Q/pNNXT5HwJZ
         6Om/4Hc76JH2C3quRNPk0vOPv8+Qr4i9iXSvVPuWUajmDP5A+4fHBHiNagUGFsRNzrzU
         ifLoElqm15UDm6eUFUr7ziuC6Vexs7LbD3Ed/OJWHixAiwItHQPrSwF7JDaN2yR7tlx7
         M5iw==
X-Gm-Message-State: AOJu0YyDB1hcWecULkpVHCvgq50/1Smm+5DCehoyKe1X7F5KTXcs2uAI
	wVp5PTWjLfAsOIddmdxHhDVowfEjyitJME0cjoup4SFl7fvClX4J4RSlQ17481rPLhE9Wo1aCYj
	tATiQreuLtLE4Q8Jxl6/WWYPIdFjWdSWr3LrGeC62GZwdU+iJBuUpFe7tdQcMnFrtVJF545/euW
	a4SBAZCm1mvwSV0CyssqKj2+99xfoQvXelEnspsCtzEisVT+Ixr/Y=
X-Google-Smtp-Source: AGHT+IFzj+UPbqIngfYZg8jfoSUOtJUbhZmymzy/LpsBgzX9feIS82Pp9ab/ElSPVxx+P987jYpoPGCk3MktKg==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a5b:b90:0:b0:e27:3e6a:345 with SMTP id
 3f1490d57ef6-e2e3a6dd19amr1836276.10.1729703592399; Wed, 23 Oct 2024 10:13:12
 -0700 (PDT)
Date: Wed, 23 Oct 2024 17:12:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241023171244.4031151-1-smostafa@google.com>
Subject: [PATCH] Documentation: Update the behaviour of "kvm-arm.mode"
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Cc: corbet@lwn.net, Mostafa Saleh <smostafa@google.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Commit 5053c3f0519c ("KVM: arm64: Use hVHE in pKVM by default on CPUs with
VHE support") modified the behaviour of "kvm-arm.mode=protected" without
the updating the kernel parameters doc.

Update it to match the current implementation.

Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bb48ae24ae69..59a0dd7e2de6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2723,8 +2723,12 @@
 			nvhe: Standard nVHE-based mode, without support for
 			      protected guests.
 
-			protected: nVHE-based mode with support for guests whose
+			protected: hVHE-based mode with support for guests whose
 				   state is kept private from the host.
+				   In case hVHE is not supported in hardware, it will
+				   boot with protected nVHE.
+				   nVHE protected mode can still be forced on VHE systems
+				   using "kvm_arm.mode=protected arm64_sw.hvhe=0 id_aa64mmfr1.vh=0"
 
 			nested: VHE-based mode with support for nested
 				virtualization. Requires at least ARMv8.3
-- 
2.47.0.105.g07ac214952-goog


