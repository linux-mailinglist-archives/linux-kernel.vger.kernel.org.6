Return-Path: <linux-kernel+bounces-573520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D6DA6D89E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4573B2CC7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DDB25DD15;
	Mon, 24 Mar 2025 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dppOvNLF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E0925E468
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813242; cv=none; b=tZWbk3SA3gl/SJlpmfcSvf9/0lb5xctZTl0BAL46na4viKCrZ5QJleJa9th1hFr6cGljx9lbALwMrLs0aiQUnq+czJG+X/eJv1Ex4/RbZLMvRGj2vskCkEOiJYJeKkQWYoaNAzq99SZLeWMPvbyj/PcMoX+SgkRgjODiV9ZkzK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813242; c=relaxed/simple;
	bh=9z0RxKjeC8RwUmLb5SarlKv6HJUVpqk+rJh1s528L40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLeNeipVPEhZCBIhljkymk5knCY4Bw7AftOeGByF183OcelthrjL9BObO6Vvar4s8HNX4hChZAHb+AsX8j3OP5P2C8MVNBou69xNWVhPQNBwKobCwFxeltVUsCmh/F3A2ZuyLNuq9mS1P5z9/q5VIBT8LtOCX96p7Stjphh9yWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dppOvNLF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742813239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILxEYoeVE+MpXO0Glj+Y1U0EAxeFxdsejgciRSsrwF8=;
	b=dppOvNLFItHM6qTB60vUOhBgJMsV8FETTb9bV01Ww0ZI82zMbYT5R4f/wJ6IG0yxxFuTn8
	4Rg+lDQ+6JTBZbbcQXoWZQxpawLEVuzdtTLNB6ocBDjW8rS98grEAz6rRf0h4LXOwa0joO
	2yxk7Zi0IypmlxPXpWAjeKtlUOFzSHk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-5p0Q9gH5O6uT1alkYX8gsg-1; Mon, 24 Mar 2025 06:47:18 -0400
X-MC-Unique: 5p0Q9gH5O6uT1alkYX8gsg-1
X-Mimecast-MFC-AGG-ID: 5p0Q9gH5O6uT1alkYX8gsg_1742813237
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d51bd9b41so25044545e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 03:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742813237; x=1743418037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILxEYoeVE+MpXO0Glj+Y1U0EAxeFxdsejgciRSsrwF8=;
        b=MXmpLgvCp/Mo6jDCHIXmlvkgsloO3D7yW2QufAHjVA9lz+X3IyICCYIerg++ET81Q8
         1EJfe5LjmxFMw3hAr3d1JkBAptFsJ1Ual1V7H0lxFBTGCEWY2ff2JWnWpLtNBNtNe1UA
         4yIdRovDae4vjtN+Vq57mULH8GkgWdeJ7x9o2mvv3kFSmgH0PRijwlGq4o0azWIdqEiJ
         RB1DwOMe9geOsNYbBO0J164sFpmLvhC23gxdCu0X87iz4TjdTnna72nnwF48SC785a74
         3oecHvlY13wMQ9fbIIDvwtJXx3rSs2+WT4p1pckUnWlbiFfL88r2d7/OIDTs9jpC9X8J
         Gihw==
X-Forwarded-Encrypted: i=1; AJvYcCW6RMi8fWN+ZJYUWR96Ht4WsBiGDJ1nWmw/GxSc09SVxG1DzmQ3KtInGL2fg5oppkRBr1xAsQQF8hIsr+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFrcjlVZRnIHN1mXNeYxR9aIQ5lRod7O5syrHRVjTiPuKwsrPF
	EwSW3zT3f8XpkjNqiB7MHyvaLUfJQsRKFMXSzfvm/3ZGr7jUJgk1JglYl0vml9TsvA2NXhu35xC
	d9YSzMacqmVi33wOHFwzYA2bFG6hF9SoQECf9BSynxxcvRDt6LIs+i88f1q3srw==
X-Gm-Gg: ASbGncs7Q+1tWvVuN6T7tR4mMTC3fftJIMvGXRJv8CXLDThGjLltDn0IzDo8YWGEwyI
	2FO85TlsPXl/NNMgrMrOKveRyKcRZaOXwSHkFnQxMFHbwjwYxLZ3YcJNZo9CHO3vf078eg9xtZM
	C3SORlBNOd75Ba22PdDASDGBN98O0LCKYw3efLS+KioyLZQx+PXhkrN2jT6vzgYfnSfcPGPW2we
	k3wnD+xgMeLhiCmP6yGVEfzS4FS8+IC6r0iFn97sl6dbk+dqK4iovUiYRL+cuoSsGx99lOIaOKg
	iJNyTF6kYUR7sEJ8a6B5DT2IU2b9Ue9M42I4ywWqwSlgq6BHR6HoFrtpK9pTIG1rQw==
X-Received: by 2002:a05:600c:1d9f:b0:43d:83a:417d with SMTP id 5b1f17b1804b1-43d509ec5d7mr113154335e9.12.1742813236957;
        Mon, 24 Mar 2025 03:47:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWZa9wuN2PTDGpTipt3fq+aoFWpOBqvRgoGNR3/VEGSUJWm0DGpVCjLokA7c7167YRmdsfkw==
X-Received: by 2002:a05:600c:1d9f:b0:43d:83a:417d with SMTP id 5b1f17b1804b1-43d509ec5d7mr113154055e9.12.1742813236335;
        Mon, 24 Mar 2025 03:47:16 -0700 (PDT)
Received: from stex1.redhat.com (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd9e96bsm118452815e9.25.2025.03.24.03.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 03:47:15 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-coco@lists.linux.dev,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	linux-integrity@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 4/4] x86/sev: register tpm-svsm platform device
Date: Mon, 24 Mar 2025 11:46:49 +0100
Message-ID: <20250324104653.138663-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324104653.138663-1-sgarzare@redhat.com>
References: <20250324104653.138663-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

SNP platform can provide a vTPM device emulated by SVSM.

The "tpm-svsm" device can be handled by the platform driver added
by the previous commit in drivers/char/tpm/tpm_svsm.c

Register the device unconditionally. The support check (e.g. SVSM, cmd)
is in snp_svsm_vtpm_probe(), keeping all logic in one place.
This function is called during the driver's probe along with other
setup tasks like memory allocation.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v4:
- explained better why we register it anyway in the commit message
---
 arch/x86/coco/sev/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 034aab7e76d2..0abcac87af89 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2692,6 +2692,11 @@ static struct platform_device sev_guest_device = {
 	.id		= -1,
 };
 
+static struct platform_device tpm_svsm_device = {
+	.name		= "tpm-svsm",
+	.id		= -1,
+};
+
 static int __init snp_init_platform_device(void)
 {
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
@@ -2700,6 +2705,9 @@ static int __init snp_init_platform_device(void)
 	if (platform_device_register(&sev_guest_device))
 		return -ENODEV;
 
+	if (platform_device_register(&tpm_svsm_device))
+		return -ENODEV;
+
 	pr_info("SNP guest platform device initialized.\n");
 	return 0;
 }
-- 
2.49.0


