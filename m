Return-Path: <linux-kernel+bounces-400793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D18539C1277
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3881F23A31
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DDF21F4CE;
	Thu,  7 Nov 2024 23:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YtI7IYWb"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E7B21C191
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731022143; cv=none; b=OQV7gjE8jnkzs5jYIaszEgMfi9spWoSfxDigSojTuJL+djtnY7G8CkKpADoK7G4ds6hY/d1oNKT15Z2Fbcmz+1PEHWw8TmBRDlgm2tlCyxO2ttZkDLlOq0IQ/eAklnRePpJSgP7dDLNJuGx0/U1JktBVlXRqZC6Lj9Y566+91nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731022143; c=relaxed/simple;
	bh=6WWSW1vJ35TJDlbJJB5qq6nYTs9fwiNRbSVBdPgx3NQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uu1tBT+1QkiCCZNq/1dbB11wQaF3qldRhx9EUoFlsJQlZUKdin+4ResL93axc0o1hW2FO68sZcUdN6xBD6xaSHTO2FmIRfOi1pF8cB7yohRCQNadc1YUwxjMNLgsc8tanj9/Y6C3msJD3foGzXsW9mq25fhZlvEdJ1XVGXEXSHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YtI7IYWb; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e467c39a4so1434212b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 15:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731022141; x=1731626941; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vd/jtJnQGf9IB3+kXNQoV6T2je6UfO6DAehiOVa2s+o=;
        b=YtI7IYWbxz0wp037eCTsyTBErWdpDANmiVWnweA6SzI4EL1AopONYPddvWRBUrLTAn
         SVMnTFRU/TWyudTp639uodx21lM5cweJImyamx1MwunPYAWRIqG5AyPgZIi4IZ/Mzcmz
         +W0NJ/rX1kD6v4J+WvRFCiA7WpGtqcgJM/l8x0vUcO/rko+/ic3MywTCdScx8h6Z308X
         uE4GIEJ0ZbZA+pxrJ6hJZrf4BcnFPEkK4xqSYfcE++WJZDstNFxndFDjQyW8knxEPcEL
         Osf1OP44WWRiy0K8+5fPOgCz8rjZOb9QpbZGHhFug13/5Tyz/3rcaGga/ScvZGXNl07+
         daSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731022141; x=1731626941;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vd/jtJnQGf9IB3+kXNQoV6T2je6UfO6DAehiOVa2s+o=;
        b=tRrlNXovRVdkJUX0anca/0VZLNUpAri1h7Tuf7y9g2kRmwRrHHQ6jHvEAbpckmKlUR
         xt1JDGhirK+4NVRoNdRba4+anfhqePCF89Ln3qHDLVvdvTsG/xqw0Bv/inWk0uJMGM5u
         yz4gi56lpp4XVj5MkGCSDVBaalbScDI9qFs32UDATMjRkFW9qmOfqCqydhgHsQSTmv5b
         VQkok7RAsKUVr1ogAdc0tzvrUdmkHI2fUi+jFVhchq62FkTMhXKWzCm/6jW6zAsp093i
         HL5/qn+gOTo1uzEJZUH96g1mq7t3aMKc6MugDixomNR79C6XCFoq0BX024JbUjxP2bdg
         pKJA==
X-Gm-Message-State: AOJu0YwPSZyzvQ0Vn9AMzAnKCDLHLNg7k3AD4nEt3h3+TBZ8ThCKfJCj
	fPfprc5b3svnhCOPfrXc7ZFHSZxGvOubX9eXHJ+fBIVXWfadH0o43blk+ePzgxClxyDq/BC4zNj
	SD8BlZ/H/J8TV5KOVuOzcyjitrd2REyWWIb+Js9fJKTF4Uz0kvLR0Z30F3mEsAt53bHjCufs/cs
	Moescd6YBVfUvQ7lDMVE9dLTg3+5qjnKQ5WFo7iYZvRWNDeZYOwvkqmsXeaciDntCM2lI=
X-Google-Smtp-Source: AGHT+IG3FN+utE5DtZk1yqn4OdrPXgq7d6fljLLlDC+Gkt63/91sIHkgMPRqozoEz65kcTQskewlqi/wialMoW0yqA==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a62:b401:0:b0:71e:5f55:86f1 with SMTP
 id d2e1a72fcca58-724133cd470mr5045b3a.5.1731022140524; Thu, 07 Nov 2024
 15:29:00 -0800 (PST)
Date: Thu,  7 Nov 2024 23:24:48 +0000
In-Reply-To: <20241107232457.4059785-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107232457.4059785-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107232457.4059785-9-dionnaglaze@google.com>
Subject: [PATCH v5 08/10] KVM: SVM: move sev_issue_cmd_external_user to new API
From: Dionna Glaze <dionnaglaze@google.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	John Allen <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>
Cc: linux-coco@lists.linux.dev, Dionna Glaze <dionnaglaze@google.com>, 
	Michael Roth <michael.roth@amd.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tianfei zhang <tianfei.zhang@intel.com>, Alexey Kardashevskiy <aik@amd.com>, kvm@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ccp now prefers all calls from external drivers to dominate all calls
into the driver on behalf of a user with a successful
sev_check_external_user call.

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
 arch/x86/kvm/svm/sev.c       | 18 +++++++++++++++---
 drivers/crypto/ccp/sev-dev.c | 12 ------------
 include/linux/psp-sev.h      | 27 ---------------------------
 3 files changed, 15 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index d0e0152aefb32..cea41b8cdabe4 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -528,21 +528,33 @@ static int sev_bind_asid(struct kvm *kvm, unsigned int handle, int *error)
 	return ret;
 }
 
-static int __sev_issue_cmd(int fd, int id, void *data, int *error)
+static int sev_check_external_user(int fd)
 {
 	struct fd f;
-	int ret;
+	int ret = 0;
 
 	f = fdget(fd);
 	if (!fd_file(f))
 		return -EBADF;
 
-	ret = sev_issue_cmd_external_user(fd_file(f), id, data, error);
+	if (!file_is_sev(fd_file(f)))
+		ret = -EBADF;
 
 	fdput(f);
 	return ret;
 }
 
+static int __sev_issue_cmd(int fd, int id, void *data, int *error)
+{
+	int ret;
+
+	ret = sev_check_external_user(fd);
+	if (ret)
+		return ret;
+
+	return sev_do_cmd(id, data, error);
+}
+
 static int sev_issue_cmd(struct kvm *kvm, int id, void *data, int *error)
 {
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index f92e6a222da8a..67f6425b7ed07 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -2493,18 +2493,6 @@ bool file_is_sev(struct file *p)
 }
 EXPORT_SYMBOL_GPL(file_is_sev);
 
-int sev_issue_cmd_external_user(struct file *filep, unsigned int cmd,
-				void *data, int *error)
-{
-	int rc = file_is_sev(filep) ? 0 : -EBADF;
-
-	if (rc)
-		return rc;
-
-	return sev_do_cmd(cmd, data, error);
-}
-EXPORT_SYMBOL_GPL(sev_issue_cmd_external_user);
-
 void sev_pci_init(void)
 {
 	struct sev_device *sev = psp_master->sev_data;
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index ed85c0cfcfcbe..b4164d3600702 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -860,30 +860,6 @@ int sev_platform_init(struct sev_platform_init_args *args);
  */
 int sev_platform_status(struct sev_user_data_status *status, int *error);
 
-/**
- * sev_issue_cmd_external_user - issue SEV command by other driver with a file
- * handle.
- *
- * This function can be used by other drivers to issue a SEV command on
- * behalf of userspace. The caller must pass a valid SEV file descriptor
- * so that we know that it has access to SEV device.
- *
- * @filep - SEV device file pointer
- * @cmd - command to issue
- * @data - command buffer
- * @error: SEV command return code
- *
- * Returns:
- * 0 if the SEV successfully processed the command
- * -%ENODEV    if the SEV device is not available
- * -%ENOTSUPP  if the SEV does not support SEV
- * -%ETIMEDOUT if the SEV command timed out
- * -%EIO       if the SEV returned a non-zero return code
- * -%EBADF     if the file pointer is bad or does not grant access
- */
-int sev_issue_cmd_external_user(struct file *filep, unsigned int id,
-				void *data, int *error);
-
 /**
  * file_is_sev - returns whether a file pointer is for the SEV device
  *
@@ -1043,9 +1019,6 @@ sev_guest_activate(struct sev_data_activate *data, int *error) { return -ENODEV;
 
 static inline int sev_guest_df_flush(int *error) { return -ENODEV; }
 
-static inline int
-sev_issue_cmd_external_user(struct file *filep, unsigned int id, void *data, int *error) { return -ENODEV; }
-
 static inline bool file_is_sev(struct file *filep) { return false; }
 
 static inline void *psp_copy_user_blob(u64 __user uaddr, u32 len) { return ERR_PTR(-EINVAL); }
-- 
2.47.0.277.g8800431eea-goog


