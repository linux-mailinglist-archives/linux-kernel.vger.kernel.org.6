Return-Path: <linux-kernel+bounces-406854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 927DD9C651B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234D81F253EA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B82F21E128;
	Tue, 12 Nov 2024 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iojx+zxy"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4D321E11B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 23:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731453797; cv=none; b=hosUwCNvCUosJUox7ovDOeOHDETwfn8JIpsKWEboFYKFIMyxL6/vfPWGMcjBX25vc+fKHozuxaIXNp124yEN6/gd0bGQcLswX3PLWuAllhnNed0X/73oxRfZhAaiT1ZfXQswGvYEwkoPfppUj8MQ7RlRvU+AcbmVhpTE8q9s350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731453797; c=relaxed/simple;
	bh=ZYnveSnHe3FkDFRVZnrqkrTHNRmt3JMbLrbNeGvJt08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ktcRJFHnmg4/jXqoWcIMFEoGI30habGHR3r8TMiSTxp9prcIY2KZTRUDdsknk3t5hpprIfW7pOKHi0V9MniJMEZLeqwHDwTC6eQdCv5fs0aYevySCJj4AbhId70DxJaTcjmSwP7cHWu6XweOztdpDe3KrXesZ3XzyavSXKXgUeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iojx+zxy; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7eb07db7812so129969a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731453795; x=1732058595; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=USTo4YL/VPH3OMlRJlDOB1h2tpzzB/FL1xLG0AeYaEg=;
        b=Iojx+zxyLPJwHn9zLs0TnkQyBcHblD7qndeFZb0TCPeYfIfPh2mJlGUMh49odVcgN2
         /wxY3UCBspTXUPJJ+SGHNELwpTcoA7SiaJ4stri0R7aotQc+EmxWWV6Z4DQx8enlJnRp
         lldgqT/b/IyHHsCm8wpwM304elbEGFCTK2BI/jEqvOt9UHaOHIxUVIZbug/ZIIeR8iFm
         QNM/ASoX3m+05MfNGiWGuh1BmL9BRkosLgi7I9cy6l4nNiw8rE9vEf5MAkkH6wHIIUTR
         rD2htol9LYJlLd5qFkY5cL5xLJnj/Yfxw2P/hZg67jQebO9Q/fq2yYRVuyhGcO7YVnrE
         gOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731453795; x=1732058595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USTo4YL/VPH3OMlRJlDOB1h2tpzzB/FL1xLG0AeYaEg=;
        b=nNCc92rTUQDwcMqGlTWH2zZ8+3OyNa2V9Sz0GiyGW4h/1nuJPE2PZSAy3s84XZl7ed
         gk5x9V5NKcY9KSAo8m0OTo08KisyorBX3jdRZH6sxuG20X9jJj3RWhEZVTflipkYUyRn
         EJstqFnhGRGQ5FOggx3unQi8nD7UkYsnqKfAIJ84l4mnB3g+a/uIDyQsWQjZ8QAkvY7a
         yCD1CYGHrVmq5wk4iQ/FYUbRaTJ6TDSRHxo+EUxUP7tHdkBhJ7MtUwQLTcBINDCtGcLN
         Sw9dKqIkrJfd/28ChUDdNwaC2vayM/4lVzm1ngEROSpxLJSJHQ4iPNHDHFgs8pJHrmlo
         FhIg==
X-Gm-Message-State: AOJu0YwRIAiv2NEbkxaUJsV11uO9Ki93EYfT8oc7llu2x/knC1DYxWj0
	6JGLOf8NT/k0cIj6c3ezBwmVBdHA0AN6MtHdrpkrzQ/TI5A/3f2SVhB7EALV8XszckrchD2flSt
	sCo6fBVplQ5dN7qhORLiMqmMakGTe0VNWGLP7QVrZa4qsQN5c5ZaBjNq24SsvuyEfXqIiD2G0qF
	SEX4L/TszXhG641bZfmFPtApVOmlAj8pmq+gxKI6yZbdQBta779bzP3N7LXYSpCCZTkAY=
X-Google-Smtp-Source: AGHT+IEby86KOt7jOT5/DEApza0kwwIhq4p8JxRYX4qy2k+CNTUtIUvHeGv7sbHFOyCcpJ8TgiN/weldRpPBkDTfbw==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a17:902:e809:b0:20c:6764:6681 with
 SMTP id d9443c01a7336-211821273camr1743295ad.2.1731453793410; Tue, 12 Nov
 2024 15:23:13 -0800 (PST)
Date: Tue, 12 Nov 2024 23:22:44 +0000
In-Reply-To: <20241112232253.3379178-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241112232253.3379178-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112232253.3379178-6-dionnaglaze@google.com>
Subject: [PATCH v6 5/8] crypto: ccp: Add GCTX API to track ASID assignment
From: Dionna Glaze <dionnaglaze@google.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	John Allen <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>
Cc: linux-coco@lists.linux.dev, Dionna Glaze <dionnaglaze@google.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Michael Roth <michael.roth@amd.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Danilo Krummrich <dakr@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tianfei zhang <tianfei.zhang@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In preparation for SEV firmware hotloading support, introduce a new way
to create, activate, and decommission GCTX pages such that ccp is has
all GCTX pages available to update as needed.

Compliance with SEV-SNP API section 3.3 Firmware Updates and 4.1.1
Live Update: before a firmware is committed, all active GCTX pages
should be updated with SNP_GUEST_STATUS to ensure their data structure
remains consistent for the new firmware version.
There can only be CPUID 0x8000001f_EDX-1 many SEV-SNP asids in use at
one time, so this map associates asid to gctx in order to track which
addresses are active gctx pages that need updating. When an asid and
gctx page are decommissioned, the page is removed from tracking for
update-purposes.

CC: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Ashish Kalra <ashish.kalra@amd.com>
CC: Tom Lendacky <thomas.lendacky@amd.com>
CC: John Allen <john.allen@amd.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: "David S. Miller" <davem@davemloft.net>
CC: Michael Roth <michael.roth@amd.com>
CC: Luis Chamberlain <mcgrof@kernel.org>
CC: Russ Weight <russ.weight@linux.dev>
CC: Danilo Krummrich <dakr@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Tianfei zhang <tianfei.zhang@intel.com>
CC: Alexey Kardashevskiy <aik@amd.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/crypto/ccp/sev-dev.c | 159 ++++++++++++++++++++++++++++++++++-
 drivers/crypto/ccp/sev-dev.h |   4 +
 include/linux/psp-sev.h      |  55 ++++++++++++
 3 files changed, 217 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index af018afd9cd7f..d8c35b8478ff5 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/file.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
@@ -109,6 +110,10 @@ static void *sev_init_ex_buffer;
  */
 static struct sev_data_range_list *snp_range_list;
 
+/* SEV ASID data tracks resources associated with an ASID to safely manage operations. */
+struct sev_asid_data *sev_asid_data;
+u32 nr_asids, sev_min_asid, sev_es_max_asid;
+
 static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
 {
 	struct sev_device *sev = psp_master->sev_data;
@@ -1093,6 +1098,109 @@ static int snp_filter_reserved_mem_regions(struct resource *rs, void *arg)
 	return 0;
 }
 
+static bool sev_check_external_user(int fd);
+void *sev_snp_create_context(int fd, int asid, int *psp_ret)
+{
+	struct sev_data_snp_addr data = {};
+	void *context;
+	int rc, error;
+
+	if (!sev_check_external_user(fd))
+		return ERR_PTR(-EBADF);
+
+	if (!sev_asid_data)
+		return ERR_PTR(-ENODEV);
+
+	if (asid < 0 || asid >= nr_asids)
+		return ERR_PTR(-EINVAL);
+
+	/* Can't create a context for a used ASID. */
+	if (WARN_ON_ONCE(sev_asid_data[asid].snp_context))
+		return ERR_PTR(-EBUSY);
+
+	/* Allocate memory for context page */
+	context = snp_alloc_firmware_page(GFP_KERNEL_ACCOUNT);
+	if (!context)
+		return ERR_PTR(-ENOMEM);
+
+	data.address = __psp_pa(context);
+	rc = sev_do_cmd(SEV_CMD_SNP_GCTX_CREATE, &data, &error);
+	if (rc) {
+		pr_warn("Failed to create SEV-SNP context, rc=%d fw_error=0x%x",
+			rc, error);
+		if (psp_ret)
+			*psp_ret = error;
+		snp_free_firmware_page(context);
+		return ERR_PTR(-EIO);
+	}
+
+	sev_asid_data[asid].snp_context = context;
+
+	return context;
+}
+EXPORT_SYMBOL_GPL(sev_snp_create_context);
+
+int sev_snp_activate_asid(int fd, int asid, int *psp_ret)
+{
+	struct sev_data_snp_activate data = {0};
+	void *context;
+
+	if (!sev_check_external_user(fd))
+		return -EBADF;
+
+	if (!sev_asid_data)
+		return -ENODEV;
+
+	if (asid < 0 || asid >= nr_asids)
+		return -EINVAL;
+
+	context = sev_asid_data[asid].snp_context;
+	if (WARN_ON_ONCE(!context))
+		return -EINVAL;
+
+	data.gctx_paddr = __psp_pa(context);
+	data.asid = asid;
+	return sev_do_cmd(SEV_CMD_SNP_ACTIVATE, &data, psp_ret);
+}
+EXPORT_SYMBOL_GPL(sev_snp_activate_asid);
+
+int sev_snp_guest_decommission(int fd, int asid, int *psp_ret)
+{
+	struct sev_data_snp_addr addr = {};
+	struct sev_asid_data *data;
+	int ret, error;
+
+	if (!sev_check_external_user(fd))
+		return -EBADF;
+
+	if (!sev_asid_data)
+		return -ENODEV;
+
+	if (asid < 0 || asid >= nr_asids)
+		return -EINVAL;
+
+	data = &sev_asid_data[asid];
+	/* If context is not created then do nothing */
+	if (!data->snp_context)
+		return 0;
+
+	/* Do the decommission, which will unbind the ASID from the SNP context */
+	addr.address = __sme_pa(data->snp_context);
+	ret = sev_do_cmd(SEV_CMD_SNP_DECOMMISSION, &addr, &error);
+
+	if (WARN_ONCE(ret, "Failed to release guest context, rc=%d, fw_error=0x%x", ret, error)) {
+		if (psp_ret)
+			*psp_ret = error;
+		return ret;
+	}
+
+	snp_free_firmware_page(data->snp_context);
+	data->snp_context = NULL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sev_snp_guest_decommission);
+
 static int __sev_snp_init_locked(int *error)
 {
 	struct psp_device *psp = psp_master;
@@ -1306,6 +1414,27 @@ static int __sev_platform_init_locked(int *error)
 	return 0;
 }
 
+static int sev_asid_data_init(void)
+{
+	u32 eax, ebx, ecx;
+
+	if (sev_asid_data)
+		return 0;
+
+	cpuid(0x8000001f, &eax, &ebx, &ecx, &sev_min_asid);
+	if (!ecx)
+		return -ENODEV;
+
+	nr_asids = ecx + 1;
+	sev_es_max_asid = sev_min_asid - 1;
+
+	sev_asid_data = kcalloc(nr_asids, sizeof(*sev_asid_data), GFP_KERNEL);
+	if (!sev_asid_data)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int _sev_platform_init_locked(struct sev_platform_init_args *args)
 {
 	struct sev_device *sev;
@@ -1319,6 +1448,10 @@ static int _sev_platform_init_locked(struct sev_platform_init_args *args)
 	if (sev->state == SEV_STATE_INIT)
 		return 0;
 
+	rc = sev_asid_data_init();
+	if (rc)
+		return rc;
+
 	/*
 	 * Legacy guests cannot be running while SNP_INIT(_EX) is executing,
 	 * so perform SEV-SNP initialization at probe time.
@@ -2329,6 +2462,9 @@ static void __sev_firmware_shutdown(struct sev_device *sev, bool panic)
 		snp_range_list = NULL;
 	}
 
+	kfree(sev_asid_data);
+	sev_asid_data = NULL;
+
 	__sev_snp_shutdown_locked(&error, panic);
 }
 
@@ -2377,10 +2513,31 @@ static struct notifier_block snp_panic_notifier = {
 	.notifier_call = snp_shutdown_on_panic,
 };
 
+static bool file_is_sev(struct file *filep)
+{
+	return filep && filep->f_op == &sev_fops;
+}
+
+static bool sev_check_external_user(int fd)
+{
+	struct fd f;
+	bool ret = true;
+
+	f = fdget(fd);
+	if (!fd_file(f))
+		return false;
+
+	if (!file_is_sev(fd_file(f)))
+		ret = false;
+
+	fdput(f);
+	return ret;
+}
+
 int sev_issue_cmd_external_user(struct file *filep, unsigned int cmd,
 				void *data, int *error)
 {
-	if (!filep || filep->f_op != &sev_fops)
+	if (!file_is_sev(filep))
 		return -EBADF;
 
 	return sev_do_cmd(cmd, data, error);
diff --git a/drivers/crypto/ccp/sev-dev.h b/drivers/crypto/ccp/sev-dev.h
index 3e4e5574e88a3..ccf3ba78d8332 100644
--- a/drivers/crypto/ccp/sev-dev.h
+++ b/drivers/crypto/ccp/sev-dev.h
@@ -65,4 +65,8 @@ void sev_dev_destroy(struct psp_device *psp);
 void sev_pci_init(void);
 void sev_pci_exit(void);
 
+struct sev_asid_data {
+	void *snp_context;
+};
+
 #endif /* __SEV_DEV_H */
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index 903ddfea85850..0b3b7707ccb21 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -942,6 +942,61 @@ int sev_guest_decommission(struct sev_data_decommission *data, int *error);
  */
 int sev_do_cmd(int cmd, void *data, int *psp_ret);
 
+/**
+ * sev_snp_create_context - allocates an SNP context firmware page
+ *
+ * Associates the created context with the ASID that an activation
+ * call after SNP_LAUNCH_START will commit. The association is needed
+ * to track active guest context pages to refresh during firmware hotload.
+ *
+ * @fd:      A file descriptor for the SEV device
+ * @asid:    The ASID allocated to the caller that will be used in a subsequent SNP_ACTIVATE.
+ * @psp_ret: sev command return code.
+ *
+ * Returns:
+ * A pointer to the SNP context page, or an ERR_PTR of
+ * -%ENODEV    if the PSP device is not available
+ * -%ENOTSUPP  if PSP device does not support SEV
+ * -%ETIMEDOUT if the SEV command timed out
+ * -%EIO       if PSP device returned a non-zero return code
+ */
+void *sev_snp_create_context(int fd, int asid, int *psp_ret);
+
+/**
+ * sev_snp_activate_asid - issues SNP_ACTIVATE for the ASID and associated guest context page.
+ *
+ * @fd:      A file descriptor for the SEV device
+ * @asid:    The ASID to activate.
+ * @psp_ret: sev command return code.
+ *
+ * Returns:
+ * 0 if the SEV device successfully processed the command
+ * -%ENODEV    if the PSP device is not available
+ * -%ENOTSUPP  if PSP device does not support SEV
+ * -%ETIMEDOUT if the SEV command timed out
+ * -%EIO       if PSP device returned a non-zero return code
+ */
+int sev_snp_activate_asid(int fd, int asid, int *psp_ret);
+
+/**
+ * sev_snp_guest_decommission - issues SNP_DECOMMISSION for an ASID's guest context page, and frees
+ * it.
+ *
+ * The caller must ensure mutual exclusion with any process that may deactivate ASIDs.
+ *
+ * @fd:      A file descriptor for the SEV device
+ * @asid:    The ASID to activate.
+ * @psp_ret: sev command return code.
+ *
+ * Returns:
+ * 0 if the SEV device successfully processed the command
+ * -%ENODEV    if the PSP device is not available
+ * -%ENOTSUPP  if PSP device does not support SEV
+ * -%ETIMEDOUT if the SEV command timed out
+ * -%EIO       if PSP device returned a non-zero return code
+ */
+int sev_snp_guest_decommission(int fd, int asid, int *psp_ret);
+
 void *psp_copy_user_blob(u64 uaddr, u32 len);
 void *snp_alloc_firmware_page(gfp_t mask);
 void snp_free_firmware_page(void *addr);
-- 
2.47.0.277.g8800431eea-goog


