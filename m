Return-Path: <linux-kernel+bounces-539017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA75A49FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 788D17A4904
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2915B280A3C;
	Fri, 28 Feb 2025 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVVr/aAL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D04B2777F4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762467; cv=none; b=FIVa52XtiZdfs+NDIcajulSGHZw39jLlQhIpUQUDdK/vTwwUu6sFTp6JipNXmgTdfnvp3GxTFapNI5YJ2aIsWSEq1M3k21DZFODcoEfYVasm3LgVLEJ07D1tkCqXiuwDjdZIsdh/0d/1XyZF8Y3xCu9MC5c4BD47XFt/r95Vx6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762467; c=relaxed/simple;
	bh=isgbJApTlCyBGPxQFjLRsJbEwGToiMAg7wsViEvYcmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SK401/4I73COhu9HTzNcZ0T1A6Y47qmlafQM1e6w4rN5BzrxSUCsy3YILeJjgoxyEpLj7u0XAFGyPgZkociuJY5oUTnIVI8DfphIUPo22tlGCD705s52v02/1KHXhp+ol24d8BYCT6HxgvGr3y7RZG0Fs6eXomjHUagdlfoU9VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVVr/aAL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740762464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eRRsXwQ9b5BVtkXOCbQvcRoNNZrcFjbeyN4c0+Tojs=;
	b=CVVr/aALEvSXmtQUhS9t/OakErMgsj72vPqIH2ray6IYxHsH56PFeixTttZLze7Kdy7qat
	5rRN0JG0IkLcAvJc3j2g28bEQpcbJKszcsEnvYuTBNBj0mO4RFIzqTOKHZLdjuYlKCgkcU
	RfLabSseSwhQc8QAwvAH+uPRsXL55vo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-tk6EE9euNyOJ2Oi-0pgSzg-1; Fri, 28 Feb 2025 12:07:43 -0500
X-MC-Unique: tk6EE9euNyOJ2Oi-0pgSzg-1
X-Mimecast-MFC-AGG-ID: tk6EE9euNyOJ2Oi-0pgSzg_1740762462
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390f6aa50c5so110082f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:07:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762462; x=1741367262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7eRRsXwQ9b5BVtkXOCbQvcRoNNZrcFjbeyN4c0+Tojs=;
        b=E63q/rpmBlOA2sHnQSP3hg5pM26rx54aHa5fyaQbnNimT+UgmGcFDJLVhDhWfqepv9
         cLFORPtNyRHgbxVF3sqW1vESE5Z7Uw3aELcg7gv6nZ/QAGsuC97HLUHH35lEhXUIYCk7
         FgNnWZ2wsX4L+SpNN8+amSUq1xqapUEOd/YA2Ap6CZro9zw6e1SqobfiVqHq0rPIon6E
         MXxtKW71BhNbFchSTGznqKgOxDOmWj7yGIgc1c26X3njhLbTxwVQFmrq7xyYMxZFhyK/
         U8bk0LqEWgfQrZrjzhUbdLssPaJmYfvgl7DYAoOo7vngZaonyZUdcFXn+8qRtjB76BJG
         ARlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3GBiF1Xcdnmp/yKNcxIBydLPGz75wA7YSJkTG1Rde4Hibp4IHwuZt9VOoqjslYIN3tUFO1C+ImbtMoZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2fgjTUB0q0NjuOik0FrP9cZe+vhJNzg0ffjmfWWdiC2BYEBDC
	3I8skjqtk41g8SCXUVxOw0UJArvEWD9xxFwFRTOBVSPqtGgO9QPx27vigVzOQYE/8fO6JZedlKL
	sLlENI9lDsSf7OOJ+xAzG+z9NzPuutWvdT9NTIEVp92B9Ow+Lpc30DKFu31AEzg==
X-Gm-Gg: ASbGncv6DH7xL9pjmXqGGI1JdTbAPxGlmEyCLrn1x0gm6KC/fjNqOW8YKCNDcbc6YTV
	zY2Q2iJwxAdsenx+wYYTQMB/WowJcXbPG1LO0buRvwjKZ9bRhFh//R/Kpxf0DX//WfyQqg/g5Y6
	H9rUv+ItIc+vPv8h2AB22/U45E7HmFN41f/Y98/me/nId6x6bSbgxox4lOUQcpAJbTz3PcNf6LT
	+gLDOLScENF/1pMrKFgN0ECWLXrYRRpfhZLyRXFzGDrtyEZZyU+VHCFcVzhrUeoetNy8/XBqMMb
	kZsBrRi86AQOg9Q0WAoe
X-Received: by 2002:a5d:64cf:0:b0:38f:30a3:51fe with SMTP id ffacd0b85a97d-390eca53071mr3032887f8f.42.1740762461814;
        Fri, 28 Feb 2025 09:07:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUfCkTRPfiaBO1sKSMwjiWtyLlnIdvMfWDewKknFvnz/aj1uQU6OJDIxFqKk7dZj8v3YEtog==
X-Received: by 2002:a5d:64cf:0:b0:38f:30a3:51fe with SMTP id ffacd0b85a97d-390eca53071mr3032826f8f.42.1740762461199;
        Fri, 28 Feb 2025 09:07:41 -0800 (PST)
Received: from stex1.redhat.com ([5.179.147.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a28bcfdsm62305695e9.40.2025.02.28.09.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:07:38 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>,
	linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Ingo Molnar <mingo@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH v2 2/6] x86/sev: add SVSM vTPM probe/send_command functions
Date: Fri, 28 Feb 2025 18:07:16 +0100
Message-ID: <20250228170720.144739-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228170720.144739-1-sgarzare@redhat.com>
References: <20250228170720.144739-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two new functions to probe and send commands to the SVSM vTPM.
They leverage the two calls defined by the AMD SVSM specification
for the vTPM protocol: SVSM_VTPM_QUERY and SVSM_VTPM_CMD.

Expose these functions to be used by other modules such as a tpm
driver.

Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
James, Claudio are you fine with the Cdb, Sob?
The code is pretty much similar to what was in the initial RFC, but I
changed the context for that I reset the author but added C-o-b.
Please, let me know if this is okay or if I need to do anything
else (reset the author, etc.)
---
 arch/x86/include/asm/sev.h |  3 +++
 arch/x86/coco/sev/core.c   | 47 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index f6ebf4492606..e379bcdddf07 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -485,6 +485,9 @@ void snp_msg_free(struct snp_msg_desc *mdesc);
 int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
 			   struct snp_guest_request_ioctl *rio);
 
+bool snp_svsm_vtpm_probe(void);
+int snp_svsm_vtpm_send_command(u8 *buffer);
+
 void __init snp_secure_tsc_prepare(void);
 void __init snp_secure_tsc_init(void);
 
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 82492efc5d94..4158e447d645 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2628,6 +2628,53 @@ static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_dat
 	return ret;
 }
 
+bool snp_svsm_vtpm_probe(void)
+{
+	struct svsm_call call = {};
+	u64 send_cmd_mask = 0;
+	u64 platform_cmds;
+	u64 features;
+	int ret;
+
+	/* The vTPM device is available only if we have a SVSM */
+	if (!snp_vmpl)
+		return false;
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
+	/* No feature supported, it should be zero */
+	if (features)
+		pr_warn("SNP SVSM vTPM unsupported features: 0x%llx\n",
+			features);
+
+	/* TPM_SEND_COMMAND - platform command 8 */
+	send_cmd_mask = 1 << 8;
+
+	return (platform_cmds & send_cmd_mask) == send_cmd_mask;
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


