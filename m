Return-Path: <linux-kernel+bounces-555766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5031A5BC82
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E147A388A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C0C22F177;
	Tue, 11 Mar 2025 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEB7eq7n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEB522DFB8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686163; cv=none; b=Z6K4JoLYl7SRfbglocW0oeADokdQNfWELe00ET8shcmEIuUWybY+ei6LDbKKQjtC4d+B5HlBC9eV1RBkV0+V7YraF7NU0Uvgwh5jZTGteyZBNzJ5nIApg/zQFDMlj5Ney9huFJjr+YqjbXm1etdWD3HV4SKE4pOh9xcL7jR6+1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686163; c=relaxed/simple;
	bh=s48TuCB7hx4s0XQbfy+bStqom7rSsuzABfR49ZEXiRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhPh6l2ClmC1CyfSDkpCCGUVfWNlmGHiMgRKTVJcJY+cQshvvlu/CpNBpVyY3Rf8nV+XxsVBKg9nKHCDI9gqnxUxkO7T2EKU+UdsETbRlb0NaBQIXwSXYhUCGCH5OB42UQL1K5hPyA0VsD/DZXuvB4VXixKsM08YUAVuDpvedwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AEB7eq7n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741686160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gWbgBYfOGia6Jpo6dySuLR4cc3OA1mqpDszmSXqcblw=;
	b=AEB7eq7n35aecm87RGKKvEllubHo/eWLvyxtq4EMqLdtiCdBwsH7q35WMpag0tBfZGo5OO
	7BkUxiB3+7vmBLbxpt10EtAP7mNd8P/HNLV1R2nr8aL4/zqmWT2WSLSISmdXwFQ0BGc8pC
	E51fUjxiX/ziJ2lmoczkVPZGFUw8ctM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-13DnmO8BOK-Zbj8i73vaGA-1; Tue, 11 Mar 2025 05:42:39 -0400
X-MC-Unique: 13DnmO8BOK-Zbj8i73vaGA-1
X-Mimecast-MFC-AGG-ID: 13DnmO8BOK-Zbj8i73vaGA_1741686158
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e4b6eba254so4671687a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 02:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741686158; x=1742290958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWbgBYfOGia6Jpo6dySuLR4cc3OA1mqpDszmSXqcblw=;
        b=A1ccfTR8OdnCqM4oqbex8ONpjQI45txz2lY3D1H5mKRgZUfDh+b5ylNUNX9HVcUZ/l
         vWEiTNZ2cbhIHWPG6eFrTa8ZQ8USP/7j75uB1B0VNuKB3AfFiSWA9IMvMmtBIP9bUaTL
         v0x8V+m1TTyoMsFo1B10QwLO+weOziJKApFd5jjNOCZ6s2j5HgSjuxaqO+FE0GbfHX8n
         DsRNkfYnBd0WYqLUechWGVCpW83AbXcMmb/j6k11q3dvVLKsruHCyX7Zl4pzaF3vK34b
         trVZVYGOdCsUU4UnkjoAY7cTlDx7PbreRrMJS5O+O6FCfmgLsp8n2hD5tACejVKXFHjT
         QAMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3lud153RkOqpndmNmGqOgwohV2UTzv9r2chkoN5MzgJNVZ6gU+LrS0nHbKJ+SUeAOpt5R9zvtprNC7ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaJukc7ivA4yprhQIfXa+C4lIO5vgRFWhfXjdAZuZd5F1snEIV
	GqhzZMZYQuZ+PCE0szYN7HEyg8hJHtawsI1FdA1EXNTVB9AIgkS3OOHi/y4yCkTxts4UsFbwVAC
	f3TddQGWa1DoZLss5fuf92s2R8j8jTCsK1C0dpgk0LBi0hs4/mo0iytpaUSTsRQ==
X-Gm-Gg: ASbGnctINfK7s63JvlgScliJ/F00NxqhNN5P/0b95T0upW068OJ2U6JLfC/UjC0QUmB
	CqL6R3UOxZhHGK+8McIkS06dSHdhIJSvyBZtMALjaFMqfWIEe7fxCv5E1lJzEZvspUC6QWW4RWD
	qCjWF3k8uZyPQfKGdGSbXn2Jp+74K3cdwFnZw+Xap8M9MaH2RZeEuxtL3K5A6vvK4TfiS1LLjyC
	ZB0Nbp3Hz5vCfSf5m8jGExRl0Rl33DHviVwGdsQjxgIRYDgN4guBdHTucryRm4Ruj96zX8a59r7
	XBSavRX1bf3xz8I4NnC2mAXC5RBuP4W5qy81jJOIRCh+YfGfum2QhkMYZ1ce75QbOJ/4kDRZ
X-Received: by 2002:a05:6402:254a:b0:5e6:1602:bfbb with SMTP id 4fb4d7f45d1cf-5e75f984412mr3427191a12.27.1741686158200;
        Tue, 11 Mar 2025 02:42:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPkM6rVc1QOWMePtECn1wZste/fTBV6MwarFwJ8JBd8XyGWLzR60WZC4WklV0jI8qfpX5GoA==
X-Received: by 2002:a05:6402:254a:b0:5e6:1602:bfbb with SMTP id 4fb4d7f45d1cf-5e75f984412mr3427137a12.27.1741686157633;
        Tue, 11 Mar 2025 02:42:37 -0700 (PDT)
Received: from localhost.localdomain (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c7472169sm8085277a12.24.2025.03.11.02.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 02:42:36 -0700 (PDT)
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
Subject: [PATCH v3 1/4] x86/sev: add SVSM vTPM probe/send_command functions
Date: Tue, 11 Mar 2025 10:42:22 +0100
Message-ID: <20250311094225.35129-2-sgarzare@redhat.com>
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

Add two new functions to probe and send commands to the SVSM vTPM.
They leverage the two calls defined by the AMD SVSM specification [1]
for the vTPM protocol: SVSM_VTPM_QUERY and SVSM_VTPM_CMD.

Expose these functions to be used by other modules such as a tpm
driver.

[1] "Secure VM Service Module for SEV-SNP Guests"
    Publication # 58019 Revision: 1.00

Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v3:
- removed link to the spec because those URLs are unstable [Borislav]
- squashed "x86/sev: add SVSM call macros for the vTPM protocol" patch
  in this one [Borislav]
- slimmed down snp_svsm_vtpm_probe() [Borislav]
- removed features check and any print related [Tom]
---
 arch/x86/include/asm/sev.h |  7 +++++++
 arch/x86/coco/sev/core.c   | 31 +++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ba7999f66abe..09471d058ce5 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -384,6 +384,10 @@ struct svsm_call {
 #define SVSM_ATTEST_SERVICES		0
 #define SVSM_ATTEST_SINGLE_SERVICE	1
 
+#define SVSM_VTPM_CALL(x)		((2ULL << 32) | (x))
+#define SVSM_VTPM_QUERY			0
+#define SVSM_VTPM_CMD			1
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
 extern u8 snp_vmpl;
@@ -481,6 +485,9 @@ void snp_msg_free(struct snp_msg_desc *mdesc);
 int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
 			   struct snp_guest_request_ioctl *rio);
 
+bool snp_svsm_vtpm_probe(void);
+int snp_svsm_vtpm_send_command(u8 *buffer);
+
 void __init snp_secure_tsc_prepare(void);
 void __init snp_secure_tsc_init(void);
 
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 96c7bc698e6b..2166bdff88b7 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2628,6 +2628,37 @@ static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_dat
 	return ret;
 }
 
+bool snp_svsm_vtpm_probe(void)
+{
+	struct svsm_call call = {};
+
+	/* The vTPM device is available only if a SVSM is present */
+	if (!snp_vmpl)
+		return false;
+
+	call.caa = svsm_get_caa();
+	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
+
+	if (svsm_perform_call_protocol(&call))
+		return false;
+
+	/* Check platform commands contains TPM_SEND_COMMAND - platform command 8 */
+	return (call.rcx_out & BIT_ULL(8)) == BIT_ULL(8);
+}
+EXPORT_SYMBOL_GPL(snp_svsm_vtpm_probe);
+
+int snp_svsm_vtpm_send_command(u8 *buffer)
+{
+	struct svsm_call call = {};
+
+	call.caa = svsm_get_caa();
+	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_CMD);
+	call.rcx = __pa(buffer);
+
+	return svsm_perform_call_protocol(&call);
+}
+EXPORT_SYMBOL_GPL(snp_svsm_vtpm_send_command);
+
 static struct platform_device sev_guest_device = {
 	.name		= "sev-guest",
 	.id		= -1,
-- 
2.48.1


