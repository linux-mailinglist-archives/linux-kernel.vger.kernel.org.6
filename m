Return-Path: <linux-kernel+bounces-524733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A827A3E673
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BA5701515
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1517926561D;
	Thu, 20 Feb 2025 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XFih8IMd"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBAF263F54
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086200; cv=none; b=btTtvG3YcjU1ZAmoC6ugHv5AWzkzie80VCUDVVKR09WcwgdqCPPm+M0LW79Myq8RI7ahWoh35wQNhHmT/cG2EKfd0kThYPQyWgd3928AafpFeR02DmFa2a3fk/TpHyrjVl49SfZc3SujjrwCGxIlsUAkYbMCzRFc4uTICLOgk40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086200; c=relaxed/simple;
	bh=+PPj/zrzjSYqXXCy96C5yaPEmwdaRWz6IyB/osiEhO8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sxEO8a028SmmhT57DRHQ0LOFljxrE0hKMVXiU9Q2wnnXdG5CRVz9KOYuFTDRnAFl/WeExmpu0cw3xHbSuHWEuSZbO9jj1CMpBfHNtoylgymZHc0+Y2lTjpjzKdh2oX41abAxZwD+90UbL/f+PFTUliRtpP4H0nS5XF6Dvn3IKHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XFih8IMd; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220c86e46ebso24940635ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740086198; x=1740690998; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M+TBBWdBjfmJP6Y5X3+NqIMZIzXEuRVkUfogK9DAPAw=;
        b=XFih8IMdkLaBonSUGeQ8vy8KL9murhxyhMMBuwiHqyiwsrj9wkgV1GB+w6R8iO3BGI
         Gxwj5GM7nF6BTGyHHsQq3MVTnhaK5OOKJ0xm8YsxTd0Ot1yjSZz7fLkQEVoU/SZ1hjCb
         QM8Gwejg2P4wB2I4CtHEfvIOSX8++lgBoO/n+xYnb4cSw5QzcMYi8WVMDN6fEg3tkgXE
         K3v5Ga+9fqJLM7mnzE/afQq9euA/JkZC4z+bI3Q6uSIXAaEmRvqfGA3F1WXMCGia5Hdv
         WfwI4HyyC9ohO2h+Ewfu8bxGwI1sjhIjLe8wD7uQVAbAznirDO761QXIr249RMHUM6wU
         gICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740086198; x=1740690998;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+TBBWdBjfmJP6Y5X3+NqIMZIzXEuRVkUfogK9DAPAw=;
        b=V9wREAF9L6uCln1ByS4/wanv8Uoa9/0CEe9pX6K2mbZnjFZ0lUTaBtBB/T3kgKEVYG
         h0x9MFh0/yYm8Mb19fHZZVXkkTVEuNY8O7EHWj0zPmi8hzNLr2Drws7aWGnMtCnUOZMC
         +JWytih/xsI+0xx0qj0D8VIMDkDOnSS8qifizE7AIqkftpQXJEowVl9A/mjlFk2joavO
         hLfNUoaJSraFvVYaFb6gy2JApaClyfYbxnoZnwQLqTwU8+EiW1FySS6TDJaThUF3csa9
         F/JWWiC0aXb2iFVDg+lnN0FgAx79Ggy6RHFik9KX7/ytuwnUrA2pw5/536ugGaLfBbMZ
         bznA==
X-Forwarded-Encrypted: i=1; AJvYcCXfJEp5F1FWmv8bMLKTzTjxsk3AguIHYE8v09aD2CLXGGiuHUNpt9gtCbc881blE5QFzKjMR2FBD4IfqcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL2l9JShIwVSa83aXhUySemI1JEw1K2uM3rbwjhHhEAA6P6G5w
	f4sfhtvFjDKC8OhJaAYB8KVHIJ7FrBM5SOyQQmqZTStotnCn1yNIelDgr0t8EysNxGqVBEwIGcU
	+jukR8/DtJ68X1QxDFg==
X-Google-Smtp-Source: AGHT+IFBNlC2O2lCqWhKeQbyAtagcsPixzHArx3alpasUksoCuLOtkF4bpyxaKtp+sZkIRPUeSQUbnmVmkWHtYVc
X-Received: from pgbfe4.prod.google.com ([2002:a05:6a02:2884:b0:ad5:4620:b05d])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3989:b0:1ee:dee8:5a21 with SMTP id adf61e73a8af0-1eef52c9126mr489345637.6.1740086198423;
 Thu, 20 Feb 2025 13:16:38 -0800 (PST)
Date: Thu, 20 Feb 2025 21:16:27 +0000
In-Reply-To: <20250220211628.1832258-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250220211628.1832258-1-vannapurve@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220211628.1832258-4-vannapurve@google.com>
Subject: [PATCH V5 3/4] x86/tdx: Emit warning if IRQs are enabled during HLT
 #VE handling
From: Vishal Annapurve <vannapurve@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev
Cc: pbonzini@redhat.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	pgonda@google.com, kirill@shutemov.name, dave.hansen@linux.intel.com, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, jgross@suse.com, 
	ajay.kaher@broadcom.com, alexey.amakhalov@broadcom.com, 
	Vishal Annapurve <vannapurve@google.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Direct HLT instruction execution causes #VEs for TDX VMs which is routed
to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shadow
so IRQs need to remain disabled until the TDCALL to ensure that pending
IRQs are correctly treated as wake events.

Emit warning and fail emulation if IRQs are enabled during HLT #VE handling
to avoid running into scenarios where IRQ wake events are lost resulting in
indefinite HLT execution times.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/coco/tdx/tdx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 7ab427e85bd3..16ac337df9fa 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -393,6 +393,14 @@ static int handle_halt(struct ve_info *ve)
 {
 	const bool irq_disabled = irqs_disabled();
 
+	/*
+	 * HLT with IRQs enabled is unsafe, as an IRQ that is intended to be a
+	 * wake event may be consumed before requesting HLT emulation, leaving
+	 * the vCPU blocking indefinitely.
+	 */
+	if (WARN_ONCE(!irq_disabled, "HLT emulation with IRQs enabled"))
+		return -EIO;
+
 	if (__halt(irq_disabled))
 		return -EIO;
 
-- 
2.48.1.601.g30ceb7b040-goog


