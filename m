Return-Path: <linux-kernel+bounces-186995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C548CCBA6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8A72832D5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFDD38DF2;
	Thu, 23 May 2024 05:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+sfbEyR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F9413B585
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716440731; cv=none; b=UVxrWVwbjbgae+KNQAVbr6K1lgH38oueqTvRX1YRoj+6DMvx0NNSYdjUTvxOC/uM7TRVZZRkaqqjqGPSXOi3gCP2FRkTJrfrJKaB+8adClrVUbTSji0VKm6hi3l8okE7G27yztIqf7U+luaRA7U3Ap5uU2uGE5Spby4lh81CIQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716440731; c=relaxed/simple;
	bh=iSl7KS3PS3+oGvrAX46xbBGgBquJcY7x8oR/0G0ZIdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzBwy7u3+NMBpSbzwaOpTi3FG1h2rMSoxDCHKCcHhx4PnBMACj4GVE8wTOzX2hd3M3wC3C+IkDQrDJHI0bLr8j8MnF8gqQHxCyMHw9Rjid9sj4XXzsZo1YZIuez7/GveZOWveWOk9txyX90SGLpI/rfzbVi5qUpyna+3In2ozUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+sfbEyR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716440728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgyDYqAPwEwrwLxe8ILuedZgvx3RZsbJnZUXSZSXc28=;
	b=e+sfbEyRePB04i4pD3UvlGylmHTu7I+kl1SKcPPTF4QcPoQZGQLoTv++CGxwHK2lMovkle
	dA5aP5sh4jvn+hgtfy0XsgLrmfo2NNd8+Eh819FZLLb+M6HTKh3m2bUKyQ7F2Y4/YyFElJ
	bLjV5la934awv7jzFf3DmwiUIgEVZg8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-IeYNd67fMiqA4HgWR1rO7g-1; Thu, 23 May 2024 01:05:27 -0400
X-MC-Unique: IeYNd67fMiqA4HgWR1rO7g-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-65e7c88cb40so742395a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716440726; x=1717045526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgyDYqAPwEwrwLxe8ILuedZgvx3RZsbJnZUXSZSXc28=;
        b=ZusonY8jFTi5zNV7c+Etx4VEaKGaADATdPETmaX+sIS0NIasYx4Rwb4czBbUQ4Zf53
         BrDktWiQP1qaOqleN+FH11/2jY2C+HDH909HStmcjqillgpwbyKzw1mzEkzpMvjkwc/H
         kqgAe0Z4uutzDxAo4Q5HbN/TYyogYtbGZU9vB2jnYigZy3pypZPHk8cPrJymAHCUTh88
         0a0byMouuO/U+Mw0UYC7OuCgtZmR8ZcL6+MElN2oHUmLJs+FhOVcJQSb1FeoF4FuSOVP
         +DzYxh8Fi8zfgARfy3Rm4ULcX4R+u+97dchXsPHHaUzwRhFbXqUa9X3mRzDiiUVtc8wT
         kKhA==
X-Forwarded-Encrypted: i=1; AJvYcCXnIemmO9UXzDlpcmWJ71TRtGe8u5f853lVVqdWj8GJkyYB1ix+kAe4Fto6QE6KEpktejq90fcPyHd4w53e9ZqmYXjO3VW1ONJkyEua
X-Gm-Message-State: AOJu0Yz91mCb0kIL/YGKXOjTqSECQ4M7EOdq6ZAWmFi9SMdpPAxJFFu/
	M20pRJUDDuZzxJTi7TwPQX6Tr5HP7ZuQGrWmCRa0ym7aUio2BLHiWqaS6T8JcQSmWUl6fWD5+fA
	JzHEvBRTB3uhY6V9i/rdGKAFSiuLodSEYuvI+tDVz8wt1nJ0upphQ7Oi0FFgQgg==
X-Received: by 2002:a05:6a21:2792:b0:1b1:ea57:d6ac with SMTP id adf61e73a8af0-1b1f8a749c2mr3773802637.51.1716440725499;
        Wed, 22 May 2024 22:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPjibNNUlzkGUbJC55LkT4ayzeyD3K0jDKK0WT1v3T+lpkRCBTbOfygRm48CKMedkbGJzihQ==
X-Received: by 2002:a05:6a21:2792:b0:1b1:ea57:d6ac with SMTP id adf61e73a8af0-1b1f8a749c2mr3773771637.51.1716440724853;
        Wed, 22 May 2024 22:05:24 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c036272sm247051165ad.188.2024.05.22.22.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 22:05:24 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 7/7] x86/crash: make the page that stores the dm crypt keys inaccessible
Date: Thu, 23 May 2024 13:04:48 +0800
Message-ID: <20240523050451.788754-8-coxu@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240523050451.788754-1-coxu@redhat.com>
References: <20240523050451.788754-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds an addition layer of protection for the saved copy of dm
crypt key. Trying to access the saved copy will cause page fault.

Suggested-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index b180d8e497c3..fc0a80f4254e 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -545,13 +545,34 @@ static void kexec_mark_crashkres(bool protect)
 	kexec_mark_range(control, crashk_res.end, protect);
 }
 
+static void kexec_mark_dm_crypt_keys(bool protect)
+{
+	unsigned long start_paddr, end_paddr;
+	unsigned int nr_pages;
+
+	if (kexec_crash_image->dm_crypt_keys_addr) {
+		start_paddr = kexec_crash_image->dm_crypt_keys_addr;
+		end_paddr = start_paddr + kexec_crash_image->dm_crypt_keys_sz - 1;
+		nr_pages = (PAGE_ALIGN(end_paddr) - PAGE_ALIGN_DOWN(start_paddr))/PAGE_SIZE;
+		if (protect)
+			set_memory_np((unsigned long)phys_to_virt(start_paddr), nr_pages);
+		else
+			__set_memory_prot(
+				(unsigned long)phys_to_virt(start_paddr),
+				nr_pages,
+				__pgprot(_PAGE_PRESENT | _PAGE_NX | _PAGE_RW));
+	}
+}
+
 void arch_kexec_protect_crashkres(void)
 {
 	kexec_mark_crashkres(true);
+	kexec_mark_dm_crypt_keys(true);
 }
 
 void arch_kexec_unprotect_crashkres(void)
 {
+	kexec_mark_dm_crypt_keys(false);
 	kexec_mark_crashkres(false);
 }
 #endif
-- 
2.45.0


