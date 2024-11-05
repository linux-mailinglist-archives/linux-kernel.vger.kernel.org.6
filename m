Return-Path: <linux-kernel+bounces-395744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C57A9BC24C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E009D282864
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D8840849;
	Tue,  5 Nov 2024 01:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="34/BF39G"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A531E17736
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730768782; cv=none; b=I7g+/ZcGvC/nF54uxzBgeEmKxw8sNYJWESzfFhDdGOStEwCBafaJ3fWok6MTstRWZzW580Hq9LZfaWHjmBxDwDi8ivH50ExCGcq5gO6a1vlmQm2BCSIEFCFtGCczqGIdqs2oIYUfA49pHTcW4Oj4a932aV483Lh7erKXU0auTjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730768782; c=relaxed/simple;
	bh=F9KsuGNfRVaWfy5JiXCjGWEVPTbN7HvrwzW6WxTawKo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q1jIOC4196NF27qgt4MFIb0uRr4BHdEc1elXZfjPBCFZ92ScRVGNBGLsvARiRxUftuJCOwFpwvxCnYbBTKXSZWWeLbZq3AwyKKoByiXY8RvnP2RU/p3yaHGk0+SxV7zt/VbJGIr98iZ5zNsryk2De6ZJs5MuUMnwZiWvXZnuDHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=34/BF39G; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7202dfaa53fso7241005b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 17:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730768780; x=1731373580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sSiJYSmRus7fZQi7bKuuG88mQ3M1Tyd9T7ICanZnujY=;
        b=34/BF39GrdQqIvBFEQknx+3qUhuhHqy3GOd8NI0Hpmrs2Wmki2nxJj9Jfvs3E4Iql+
         uTsIpnU5sjUUCyrwdAjryA1LP6Ks+ID3bO34cD91W/urM3UTYBqqbLKCj2FPj6VAtPbP
         XzrLoYeQNZOGUB6Uuf46702+fV9PFU66ONbBkLFYQlWmgMUjk2aAXipqFr/4Luj2AOxr
         UM6fYZZGvZJ8NAG8J7DiLMyy7ZG8xzohpKlTdYu6gQqGPEr/9liuaVUm/soJYqmjllUS
         Qg981tYfzxVXpMLM2NA1K7UdiNcytCF3T+Ri98gsPbyZsfFDizkiLHjFjLmCstqn2Svl
         Y7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730768780; x=1731373580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSiJYSmRus7fZQi7bKuuG88mQ3M1Tyd9T7ICanZnujY=;
        b=hZEP9yOjf3YQ5x1Kg6Z47nR/kleeIBpOh2ISCe1yDReZXFMuV4Ntm2yKaUnuNXCesh
         ZcpAHo6gTAyOv1EgLDk5jnV/hY04k99rGW2Nk3nKrsV6fK1v8jkcThBqIE9wYbF4alio
         DRxBGZ/AHxhGgxm9vS89IYr+Rje7REGH34pXb8vfpabHMzS0rM0yoYq06qO0sB/Yyiqt
         XNbWbYzF/cTT2EVl/JymRm4IbD+jp987EaTbdSXRq4eEvugvXmZfJaHlcfCg1pnaxuDC
         UD+UK2IKonrUWARnccMF16qeodjBtXKOc30V69FxZl0wzntWnEhKk4vvGZgbp/DErhp+
         JkVA==
X-Forwarded-Encrypted: i=1; AJvYcCWcaanGqQKdvdeT+22cBFmjhL7O5t6rnGhegzOuetxEa6wtlgrRxeccYcMD4F4hNWwwgEH5xcN/FLqA++I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtFipUjCJW4cx+WAJlibIeWeT7McJqhVx+eCMOt0Cg0XDRuon4
	C2In2/YPkBfrIDeNnlmi2qv8ssBtburK64199AKkb5HAYTK0tEXZshR7Jgrj6cCjfbSZvarbTT5
	7CBKpQYuACOcdPZo3KUh5oA==
X-Google-Smtp-Source: AGHT+IFLF4Fik6CdpaAMrxPSEyun3E3Cq49ZTRi1Eu86gyh4Xr32sstzk9KoDgqUTqbcNbqhbH6ss3ymBzn4bF+eEA==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a05:6a00:8581:b0:720:2db7:c7e3 with
 SMTP id d2e1a72fcca58-720b9a200fbmr155886b3a.0.1730768780089; Mon, 04 Nov
 2024 17:06:20 -0800 (PST)
Date: Tue,  5 Nov 2024 01:05:51 +0000
In-Reply-To: <20241105010558.1266699-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105010558.1266699-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105010558.1266699-5-dionnaglaze@google.com>
Subject: [PATCH v4 4/6] crypto: ccp: Add DOWNLOAD_FIRMWARE_EX support
From: Dionna Glaze <dionnaglaze@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	John Allen <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>
Cc: Dionna Glaze <dionnaglaze@google.com>, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The DOWNLOAD_FIRMWARE_EX command requires cache flushing and introduces
new error codes that could be returned to user space.

The function is in sev-dev.c rather than sev-fw.c to avoid exposing the
__sev_do_cmd_locked function in the sev-dev.h header.

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/crypto/ccp/sev-dev.c | 66 +++++++++++++++++++++++++++++++-----
 include/linux/psp-sev.h      | 26 ++++++++++++++
 include/uapi/linux/psp-sev.h |  5 +++
 3 files changed, 89 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 9265b6d534bbe..32f7b6147905e 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -223,6 +223,7 @@ static int sev_cmd_buffer_len(int cmd)
 	case SEV_CMD_SNP_GUEST_REQUEST:		return sizeof(struct sev_data_snp_guest_request);
 	case SEV_CMD_SNP_CONFIG:		return sizeof(struct sev_user_data_snp_config);
 	case SEV_CMD_SNP_COMMIT:		return sizeof(struct sev_data_snp_commit);
+	case SEV_CMD_SNP_DOWNLOAD_FIRMWARE_EX:	return sizeof(struct sev_data_download_firmware_ex);
 	default:				return 0;
 	}
 
@@ -1597,14 +1598,7 @@ static int sev_update_firmware(struct device *dev)
 		return -1;
 	}
 
-	/*
-	 * SEV FW expects the physical address given to it to be 32
-	 * byte aligned. Memory allocated has structure placed at the
-	 * beginning followed by the firmware being passed to the SEV
-	 * FW. Allocate enough memory for data structure + alignment
-	 * padding + SEV FW.
-	 */
-	data_size = ALIGN(sizeof(struct sev_data_download_firmware), 32);
+	data_size = ALIGN(sizeof(struct sev_data_download_firmware), SEV_FW_ALIGNMENT);
 
 	order = get_order(firmware->size + data_size);
 	p = alloc_pages(GFP_KERNEL, order);
@@ -1645,6 +1639,62 @@ static int sev_update_firmware(struct device *dev)
 	return ret;
 }
 
+int sev_snp_download_firmware_ex(struct sev_device *sev, const u8 *data, u32 size, int *error)
+{
+	struct sev_data_download_firmware_ex *data_ex;
+	int ret, order;
+	struct page *p;
+	u64 data_size;
+	void *fw_dest;
+
+	data_size = ALIGN(sizeof(struct sev_data_download_firmware_ex),
+			  SEV_FW_ALIGNMENT);
+
+	order = get_order(size + data_size);
+	p = alloc_pages(GFP_KERNEL, order);
+	if (!p)
+		return -ENOMEM;
+
+	/*
+	 * Copy firmware data to a kernel allocated contiguous
+	 * memory region.
+	 */
+	data_ex = page_address(p);
+	fw_dest = page_address(p) + data_size;
+	memset(data_ex, 0, data_size);
+	memcpy(fw_dest, data, size);
+
+	data_ex->address = __psp_pa(fw_dest);
+	data_ex->len = size;
+	data_ex->cmdlen = sizeof(struct sev_data_download_firmware_ex);
+
+	/*
+	 * SNP_COMMIT should be issued explicitly to commit the updated
+	 * firmware after guest context pages have been updated.
+	 */
+	ret = sev_do_cmd(SEV_CMD_SNP_DOWNLOAD_FIRMWARE_EX, data_ex, error);
+
+	if (ret)
+		goto free_err;
+
+	__free_pages(p, order);
+
+	/* Need to do a DF_FLUSH after live firmware update */
+	wbinvd_on_all_cpus();
+	ret = __sev_do_cmd_locked(SEV_CMD_SNP_DF_FLUSH, NULL, error);
+	if (ret) {
+		dev_dbg(sev->dev, "DF_FLUSH error %d\n", *error);
+		goto fw_err;
+	}
+
+	return 0;
+
+free_err:
+	__free_pages(p, order);
+fw_err:
+	return ret;
+}
+
 static int __sev_snp_shutdown_locked(int *error, bool panic)
 {
 	struct psp_device *psp = psp_master;
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index 903ddfea85850..6a08c56cd9771 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -16,6 +16,15 @@
 
 #define SEV_FW_BLOB_MAX_SIZE	0x4000	/* 16KB */
 
+/*
+ * SEV FW expects the physical address given to it to be 32
+ * byte aligned. Memory allocated has structure placed at the
+ * beginning followed by the firmware being passed to the SEV
+ * FW. Allocate enough memory for data structure + alignment
+ * padding + SEV FW.
+ */
+#define SEV_FW_ALIGNMENT       32
+
 /**
  * SEV platform state
  */
@@ -185,6 +194,23 @@ struct sev_data_download_firmware {
 	u32 len;				/* In */
 } __packed;
 
+/**
+ * struct sev_data_download_firmware_ex - DOWNLOAD_FIRMWARE_EX command parameters
+ *
+ * @length: length of this command buffer
+ * @address: physical address of firmware image
+ * @len: len of the firmware image
+ * @commit: automatically commit the newly installed image
+ */
+struct sev_data_download_firmware_ex {
+	u32 cmdlen;				/* In */
+	u32 reserved;				/* In */
+	u64 address;				/* In */
+	u32 len;				/* In */
+	u32 commit:1;				/* In */
+	u32 reserved2:31;			/* In */
+} __packed;
+
 /**
  * struct sev_data_get_id - GET_ID command parameters
  *
diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index 832c15d9155bd..936464d4f282a 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -80,6 +80,11 @@ typedef enum {
 	SEV_RET_INVALID_PAGE_OWNER,
 	SEV_RET_INVALID_PAGE_AEAD_OFLOW,
 	SEV_RET_RMP_INIT_REQUIRED,
+	SEV_RET_BAD_SVN,
+	SEV_RET_BAD_VERSION,
+	SEV_RET_SHUTDOWN_REQUIRED,
+	SEV_RET_UPDATE_FAILED,
+	SEV_RET_RESTORE_REQUIRED,
 	SEV_RET_MAX,
 } sev_ret_code;
 
-- 
2.47.0.199.ga7371fff76-goog


