Return-Path: <linux-kernel+bounces-555770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBD9A5BC8B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E49B174A66
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224F4233D85;
	Tue, 11 Mar 2025 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTLKMVqi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2EC233D98
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686176; cv=none; b=kXrbA92rP/4/3Iyc1Wf9y0IHcCPrFYcceK4iBBgb+VFjZf7CD3XJxhi0hNFgu3mNk/HElXVVwstXoEivELkQ4FVt2J0YywiRB7QK3xgkt6ZMOayj8NyigoOmFV+LW9CefO+rpkDE77wjihBh9slTLOT058ayduFxQ93qfOcW62o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686176; c=relaxed/simple;
	bh=7ofinKFlIYAPL0uFGFVvSScK4HwNUlqf6CGOFX+txk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJfHY8cYBwbMjFM5Ck6OKnMnyyv9RJYhnPH2Z8ScvncEVvKW4JvWTovVm0qpDlJ2MlapgmAGcOtGW5seuSRl61Aop8jNalNgeR3278BcIbRc+8AjoXv0HM81BG1fbWZ9+8YUtOUYgVXBUDRMp3HkYMqDtbVQlcilTmImqc7g8g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eTLKMVqi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741686174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Hg6I6nIDb7vIFIV7ygI8oxn0FMZLdQaKjCFJAirlRo=;
	b=eTLKMVqiEJ/uM3bfCPoNZuwLUwwX/9QlV2/PEbZNI61cVSlybAVmNOAZ6UqWdzwvpiN+An
	2nuAu+8ezG8X5Z59uccVnhA8B4xdS2EHyI4xwBdROVCB3IrkzJ2P+OL3coFH1RuOHugJkT
	9bZFQSmeAKVIQfipGf6MJrk3W1JtY50=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-G4M-Hwr7OVmxEFL8lgX91A-1; Tue, 11 Mar 2025 05:42:52 -0400
X-MC-Unique: G4M-Hwr7OVmxEFL8lgX91A-1
X-Mimecast-MFC-AGG-ID: G4M-Hwr7OVmxEFL8lgX91A_1741686172
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abf4c4294b0so562780266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 02:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741686171; x=1742290971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Hg6I6nIDb7vIFIV7ygI8oxn0FMZLdQaKjCFJAirlRo=;
        b=IeGyr42ObqKlFYIk67ozTJ5TVE3rkQgLuhJUKRMnXgl2HH7k7tF56gvFwgxECwLGfN
         VaYdD6AoEWxpYVUdkqv/W85FyQ5evqxM8BR8LOkpAtTeTWPDQYhn/4v05au3nPKo3xNa
         zRIjhg6ucK6gs0ePPRPvke4+Z5B66S84Jm3wFWDAOkumX6kITfG6ASjobc5KDH7eqGu5
         mgYQHaE7z5hey3IS7+3sFFjt1yliCeeoqlWxlx5m4Otdj+RLec5o1duyTF9QFZdbjCby
         RqLUPcEZ25tPmFwcAg4tN9jkG/pcjCWqnbXSkAVnVQU+WnA0i6WK8wGakI+fXyyRAB1f
         MDSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYX3fxOtD+Bz+15BiUqE95hRYSb6SEKrSQaMxqynT8r3cgbWBc8YjtVmkKVIuWlZdwWmsQezxZcR8srgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK1XkFUVTs5uLcrWxPfLC1GNUs9yjOEEJabdDtI0vL0UdQ0O/b
	utW0n1mItt6wC5ILfRXaRjJE4C5cbZ2P8TxjC77Yua381t4nOa9GFERt8dUcqLyAiz62vSKZULw
	b1Vp5vG1a+U8Tz461AQVnptCOCU9bWYcipBPUAyoMT1pbL5GcRKhoCdBJUSFnx3V2Vvh9sg==
X-Gm-Gg: ASbGncu2AfTbaFafYAz6S48MLTXC1ZF79Sfgrh/+Ft1OK0IXcqmn/ME1eviLCLu2iT1
	67uJUGLhE0Ue/TFivxeOTGx2QWCJvkWXlC4Sso5WY3VsRnI72kNIxHuFAOD61bV2rMa5H889YxA
	oyZ58T/VrB5O7mPpabaRMDOgeDZGcdgsRnZ8bJF1Yyx3g6QXEeax1iD1dGBLS4m5Sxr2PyggLcy
	CebMCJIL0VlCkjsu1dlIEJa1UPN33AxKSgtEzmM83sdsxTfqzwatKpymnerfrjx5975BA26hPuP
	u7whdoxdChaK8TCwcNSWnEWdbNY+UQ04LRQU+c7cH8TVCI7zbtUUP7OKZ7gGo2ClEEzxL9qw
X-Received: by 2002:a17:907:a310:b0:ac2:6fc6:b93d with SMTP id a640c23a62f3a-ac2ba473173mr370178166b.1.1741686171318;
        Tue, 11 Mar 2025 02:42:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkmP0r13TRekW78HkAFefp5cjLkHl6Mq2Ghd/8jrWtGCOF1SbwGI8W62TAbwjYfxllk7Faww==
X-Received: by 2002:a17:907:a310:b0:ac2:6fc6:b93d with SMTP id a640c23a62f3a-ac2ba473173mr370172766b.1.1741686170721;
        Tue, 11 Mar 2025 02:42:50 -0700 (PDT)
Received: from localhost.localdomain (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239485bf3sm903753666b.63.2025.03.11.02.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 02:42:49 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	linux-integrity@vger.kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	linux-coco@lists.linux.dev,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 4/4] x86/sev: register tpm-svsm platform device
Date: Tue, 11 Mar 2025 10:42:25 +0100
Message-ID: <20250311094225.35129-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311094225.35129-1-sgarzare@redhat.com>
References: <20250311094225.35129-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SNP platform can provide a vTPM device emulated by SVSM.

The "tpm-svsm" device can be handled by the platform driver added
by the previous commit in drivers/char/tpm/tpm_svsm.c

The driver will call snp_svsm_vtpm_probe() to check if SVSM is
present and if it's support the vTPM protocol.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 arch/x86/coco/sev/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 2166bdff88b7..a2383457889e 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2664,6 +2664,11 @@ static struct platform_device sev_guest_device = {
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
@@ -2672,6 +2677,9 @@ static int __init snp_init_platform_device(void)
 	if (platform_device_register(&sev_guest_device))
 		return -ENODEV;
 
+	if (platform_device_register(&tpm_svsm_device))
+		return -ENODEV;
+
 	pr_info("SNP guest platform device initialized.\n");
 	return 0;
 }
-- 
2.48.1


