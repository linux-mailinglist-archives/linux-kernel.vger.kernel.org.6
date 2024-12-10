Return-Path: <linux-kernel+bounces-439748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5075D9EB37D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA5018898B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55781B423F;
	Tue, 10 Dec 2024 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKgBtVfC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8686C1AA1D0
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841305; cv=none; b=nTu0oCjVT4xby+k5evcshZum1k6gyHiww6bdX+2QkSIAfFC7V8FBX/gKqZa3z0uBoXvagRH8R/+BEGWQfKQ21f2hS6TPrb3CpgvTKlyXfJ+6wa8lTLeJd/3WCUt3JOqUqQlZJ/EZxfMs85m/4S8IVSm2kWfGy8Xw3x8nJ9mApls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841305; c=relaxed/simple;
	bh=I3+OgVND3ovs3EabmzXGFURX+i4WzYcd0zLU7C8kE5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNy9nH3J+7KaXwvJP3qjQ5hydpxtBoAMfJkzvrJOfJNe/oewziuvKRiVF3lAjYmrAHAly4L6tsCXy+bs/a4hY+zrdJyaRNCKNIOZ6gknNrRA7qbLbF4MNEd3dpBB9dYiNu2oq21OQDF/H/7KrWQChDXefJ2L3yPWKPYlCj25xHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKgBtVfC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733841302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHZJG01hNeaIMCFXcC4aAtIq9wGcVNYKpI5sbt4iaAs=;
	b=GKgBtVfCPB2ewoxJC60wp6o/0QVjZsbEJz+7A5pbmGZdscCmHYYOt/WzbWwuFd11L8UwNC
	E+lFBAFeYiIjgOQIwsAfvbXDQvjflY+cAxcmqq3jFXTVjwVHVmmZDUCGtvmO49hvSQgYtg
	3bRCC7STY+QgzhzEi59lHaK5iViZGK8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-nLcWp9tUM9-nUIsw2CvGjQ-1; Tue, 10 Dec 2024 09:34:57 -0500
X-MC-Unique: nLcWp9tUM9-nUIsw2CvGjQ-1
X-Mimecast-MFC-AGG-ID: nLcWp9tUM9-nUIsw2CvGjQ
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4667e12c945so83593681cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841297; x=1734446097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHZJG01hNeaIMCFXcC4aAtIq9wGcVNYKpI5sbt4iaAs=;
        b=U709DXp1HrCZcJEVUFdHtniWByUj8EiS48R8ZJtxpyGI8QgcPsdLuBEj3IhIXGDbmA
         fLmK39RD7jo6P2y/7yn7ppB6OiusCULNCWq2g22/pQE7owYV2PQ+AVodkKUXFTAqvhfA
         ee45aEf7ZVT6Eg0KNeoYd46XWFr377zyK08Y+/buzxiuuIF43mp2pUtqg4drRGTjNDUN
         nEa9lOcrfRJ7nrei6jyHpf4N1LirfP7SpaLRP+vgeOU/GVtDbbRb0LPGFaVJXCWWMoYN
         3vxUWMC5G/BPPNVHAbQteqHG10a56BMQQwPW+PsZKk4rWnisFLcrrPQfVhk+l9NwokAu
         ig3g==
X-Forwarded-Encrypted: i=1; AJvYcCVt477U0skPvHGS6qdkVzHyrBzW/3LFx57B0hcDM6mSzz8QVdh2rvSdpBhohpPuQG2wwCps0QlJwDBeAa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZHJdpCURtET1qVCIAKcQfxwFbcbFtqGexFJTBAwQLfC2gBeOY
	zuCGlEuqYTLTdg/7GLkAwp2xPrjmK1lwiSdwQQteC9CAr7a1OLksuu/16tK1Letkc8lC2CbidtR
	JLg40upxs1q1YEQehYdJb7oBcvn7Ckoj3fyCDZ7cjxt9wOX7Zj3mfDQHCdjaGbA==
X-Gm-Gg: ASbGncsWyXzoPtNmxfeFKei/HBbSe++5lmsgLyp5ve5p4P16y9iXr/QiHYOo9UYsh5l
	JeimT8IGbvsXW+a/KALuQmHtY1r3PsGyaBc5Un2sovY6kpDLhwM9KfkiVfoAnX7QqO8zIkxkJzU
	OY/zNbJTetfKQWrxSjZEKlPHgHfWU/vjKVjvUbA6+J0iGkQNmBszYmRknv0T3hy56CQztqWXGzj
	qg1VsuWz4NnIehiE97gFRTKJ8cnVYKhc9jsYsUKs58xNSiCqbB+1vH8KAuOAUgeXckqX31bcmme
	QPGPQ7oVxeSDa+sX4Mt2SkbMmepx3fc=
X-Received: by 2002:ac8:5fc6:0:b0:467:6505:e3c with SMTP id d75a77b69052e-4676505132dmr138668301cf.24.1733841296844;
        Tue, 10 Dec 2024 06:34:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWTua5aJb1pNQFOVrnxFBRlJAcVPzKgg25Q3AMf1JLy1jJEt2pslYht0E+7saMZCCbUW+bWQ==
X-Received: by 2002:ac8:5fc6:0:b0:467:6505:e3c with SMTP id d75a77b69052e-4676505132dmr138667721cf.24.1733841296367;
        Tue, 10 Dec 2024 06:34:56 -0800 (PST)
Received: from step1.redhat.com (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4675d0d9039sm27218631cf.22.2024.12.10.06.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:34:54 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: linux-coco@lists.linux.dev
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-integrity@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	x86@kernel.org,
	Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Dov Murik <dovmurik@linux.ibm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
Date: Tue, 10 Dec 2024 15:34:23 +0100
Message-ID: <20241210143423.101774-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210143423.101774-1-sgarzare@redhat.com>
References: <20241210143423.101774-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Bottomley <James.Bottomley@HansenPartnership.com>

If the SNP boot has a SVSM, probe for the vTPM device by sending a
SVSM_VTPM_QUERY call (function 8). The SVSM will return a bitmap with
the TPM_SEND_COMMAND bit set only if the vTPM is present and it is able
to handle TPM commands at runtime.

If a vTPM is found, register a platform device as "platform:tpm" so it
can be attached to the tpm_platform.c driver.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
[CC] Used SVSM_VTPM_QUERY to probe the TPM
Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
[SG] Code adjusted with some changes introduced in 6.11
[SG] Used macro for SVSM_VTPM_CALL
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 arch/x86/coco/sev/core.c | 64 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index c5b0148b8c0a..ec0153fddc9e 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -21,6 +21,7 @@
 #include <linux/cpumask.h>
 #include <linux/efi.h>
 #include <linux/platform_device.h>
+#include <linux/tpm_platform.h>
 #include <linux/io.h>
 #include <linux/psp-sev.h>
 #include <linux/dmi.h>
@@ -2578,6 +2579,51 @@ static struct platform_device sev_guest_device = {
 	.id		= -1,
 };
 
+static struct platform_device tpm_device = {
+	.name		= "tpm",
+	.id		= -1,
+};
+
+static int snp_issue_svsm_vtpm_send_command(u8 *buffer)
+{
+	struct svsm_call call = {};
+
+	call.caa = svsm_get_caa();
+	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_CMD);
+	call.rcx = __pa(buffer);
+
+	return svsm_perform_call_protocol(&call);
+}
+
+static bool is_svsm_vtpm_send_command_supported(void)
+{
+	struct svsm_call call = {};
+	u64 send_cmd_mask = 0;
+	u64 platform_cmds;
+	u64 features;
+	int ret;
+
+	call.caa = svsm_get_caa();
+	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
+
+	ret = svsm_perform_call_protocol(&call);
+
+	if (ret != SVSM_SUCCESS)
+		return false;
+
+	features = call.rdx_out;
+	platform_cmds = call.rcx_out;
+
+	/* No feature supported, it must be zero */
+	if (features)
+		return false;
+
+	/* TPM_SEND_COMMAND - platform command 8 */
+	send_cmd_mask = 1 << 8;
+
+	return (platform_cmds & send_cmd_mask) == send_cmd_mask;
+}
+
 static int __init snp_init_platform_device(void)
 {
 	struct sev_guest_platform_data data;
@@ -2593,6 +2639,24 @@ static int __init snp_init_platform_device(void)
 		return -ENODEV;
 
 	pr_info("SNP guest platform device initialized.\n");
+
+	/*
+	 * The VTPM device is available only if we have a SVSM and
+	 * its VTPM supports the TPM_SEND_COMMAND platform command
+	 */
+	if (IS_ENABLED(CONFIG_TCG_PLATFORM) && snp_vmpl &&
+	    is_svsm_vtpm_send_command_supported()) {
+		struct tpm_platform_ops pops = {
+			.sendrcv = snp_issue_svsm_vtpm_send_command,
+		};
+
+		if (platform_device_add_data(&tpm_device, &pops, sizeof(pops)))
+			return -ENODEV;
+		if (platform_device_register(&tpm_device))
+			return -ENODEV;
+		pr_info("SNP SVSM VTPM platform device initialized\n");
+	}
+
 	return 0;
 }
 device_initcall(snp_init_platform_device);
-- 
2.47.1


