Return-Path: <linux-kernel+bounces-206038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2748B90038C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D68E1F27BB7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B84F19750B;
	Fri,  7 Jun 2024 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVFo9jbD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E542F194C79
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763230; cv=none; b=rD0qTuY4VI921ffjOS8UQkHpwM+yaomNUAjSwpP16pFpYGyqr3Exs1ofSkhRGxrevfJoULURmrWmJHGBX46RvdHENVO3N5tmW+tzUb32dESugxeEYUMw7qAe2TDcpZKBX0Mmv1aUGVQtkc6hm6jUjjvDorW9NNsi+fo2UBNNsSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763230; c=relaxed/simple;
	bh=P6k/4n5U39byFzD6jzSNBEigVT6mMplCDkSAxVn4NZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijmnHBfDYL0prZqJpTmTznVfBY4RJj12phKFmupIBRvxujWBlsuu+pVPgSphpGV6rhgz46yiQDllTREemsp0iNAlu8b5f0dEy+Dievddx5SmqITdyZITQGL8iD0e5OC4OULaPqE0LnJj1IbfeLTVY7iAzHYcxxzky0HiFkHCOAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FVFo9jbD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4ZPJMKNqAKs+WSkD3sNi4S4EfGxm9XkiKd+CksFrl0=;
	b=FVFo9jbDx8/SWQ6vlzNnHE3LK80SPqRjSlSYEvgbfuWh6q2wtAXtQofFIVxEySEgOPdL6q
	dzlI5L8oVpXxxEzt5Lfts2wFk/P+FbMoxeZOJ5BaJ2dfNREnMiZ6Pb9FJZi9rTfJChd6CI
	AYkQfqmDNPIhXZVO2e4W54rfN1G38d0=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-1TUaR7ivODeX6ebTvadgkA-1; Fri, 07 Jun 2024 08:27:06 -0400
X-MC-Unique: 1TUaR7ivODeX6ebTvadgkA-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3738732f988so19796875ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 05:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763226; x=1718368026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4ZPJMKNqAKs+WSkD3sNi4S4EfGxm9XkiKd+CksFrl0=;
        b=HAbmTCMnWxx3/dq+bd9IjPyTJuKy/S7MS23xvyVfVGIeM3iaaGNyw86r5sp6J4J28v
         zoqM23ZkkREMuWxy9P/TvxDjIy/w3XUUpmOkBJMThed8jIwIfwf68W/Xkty43ZvQUQiA
         R1HXGxRXlIWvEhmnCexEaSqjY8yvHyo9Qnl2Cviw4M4dk5fsqzZE2kKxL5KI3YXwGQ35
         N9U69hvZD5IzrNz+zDg+7jyMAO0jCWODseHcjUfGE1UXK1QkBDZDT47AGVatlbtgbg3c
         HkHSw/xuEsKNRKv9xuhTmVCQFRTzSxIbbUDAc4AGeP2yz3igaLi7uaspe2XsE1W6fTLJ
         2VeA==
X-Forwarded-Encrypted: i=1; AJvYcCWWlRxLSWIGTWGHpLykE3UvklZRsZd58ISEht+KICTJVrztmYAPRaikLAPRpmWknNsdPz5Geb0XbB2C/bajLanJjdqiI9UxB7udBPlY
X-Gm-Message-State: AOJu0YykJ/t1T1ECYfos/zIxzE5ckPxDfRZOvMLqSyAfsHYCGOYiFr8i
	WwJo473ARyirSkIJz3MyLbmKQaSjcX/TeYoHM6BQd/x1THHAF5Xp+sI9MlszTWrIKXfDtz+Tli+
	iI2PAFpOkFtjh3ycznOGqNto1qM8/VPWDasL8yWRZXvuH9UeUiepEGL2yEHdU7g==
X-Received: by 2002:a05:6e02:1b0f:b0:374:a738:818c with SMTP id e9e14a558f8ab-3758030b7a4mr31967565ab.12.1717763225500;
        Fri, 07 Jun 2024 05:27:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8pU+tOy6cV80EfkDwgc4VbW/L5pJTETaDXD3l4vJiIFc665Y5KIiucld1brAK/XJ5qcivgQ==
X-Received: by 2002:a05:6e02:1b0f:b0:374:a738:818c with SMTP id e9e14a558f8ab-3758030b7a4mr31967195ab.12.1717763224612;
        Fri, 07 Jun 2024 05:27:04 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e4d8db18c2sm397294a12.29.2024.06.07.05.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:27:04 -0700 (PDT)
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
	Greg KH <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 7/7] x86/crash: make the page that stores the dm crypt keys inaccessible
Date: Fri,  7 Jun 2024 20:26:17 +0800
Message-ID: <20240607122622.167228-8-coxu@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607122622.167228-1-coxu@redhat.com>
References: <20240607122622.167228-1-coxu@redhat.com>
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
 arch/x86/kernel/machine_kexec_64.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index b180d8e497c3..aba50ec641e6 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -545,13 +545,35 @@ static void kexec_mark_crashkres(bool protect)
 	kexec_mark_range(control, crashk_res.end, protect);
 }
 
+/* make the memory storing dm crypt keys in/accessible */
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
2.45.1


