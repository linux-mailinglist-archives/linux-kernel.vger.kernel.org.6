Return-Path: <linux-kernel+bounces-380499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 258319AEFAC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55FE1F23793
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307D72003DF;
	Thu, 24 Oct 2024 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJ4naE3Y"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9343A16DC3C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729794460; cv=none; b=M+jY3+E3KA4d5XE1W5EFXCHAICz2SaadF0UabemfHfKVQ1uWdqIkohvDlP7ageJHpBiwklwH/zvoW2t/+SCsx0UBYQSzKl4hv0N0v3v8Jh7qKd2530jRtchwrKKClH1ONvj92zveXwwIVd10lmhZdmE/g66m9QRUeyiUBfP39GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729794460; c=relaxed/simple;
	bh=sS7XEftG8NwIg0jvOsxy+xf/DVgTuOwDySgcJpjgz04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d51MBoW8hCkez1rWvM0eXS7s6lfFhqFdwRbhuhjIn9lrlcRfScdKb3qS/fJctJZXhclIjalws3KQ9hRHFGniJBHeSnxfHBTd2G1G2KAisthOFCkPKKnr99UwrZVMcbIowddVXqIyO93vKv1tNH0YvfFWs5v6Ml7I1OTRxDbg07M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJ4naE3Y; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cb6b2b7127so1496480a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729794457; x=1730399257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnCw1JhVMlHCUGTY3kum+p0Q1aFqVM0KcNSrF8JwsPI=;
        b=NJ4naE3YDtwdek4ZbLDQHARE4WVYCprlCX5G9mRwnbPmmWGi9fanw+RlYySgEyKLpi
         bgGL74DhQqK6vz5CVbTf5v2HFRKtSBS3mpY6CxRLBNfVwDGwAai+oeyT48hWPV14GLhh
         9WJbMl/ZrNU2IESaCkqvfmtbZez5P+2BFknbzJOEccRchDrfOPDuPk+FJvVPBizMC7Cv
         0lajmXehV1pP9R7iq2aUjmjRxijVYiQ7SDFmjmxcFcQUmKZmepXHjQyNW+cwML0AgqqH
         wJvBoTclDH794fu2pOidzHPMYQPdBQe5VsPA+YGuVk0uSz4musSdcditGXVzpPXifcxS
         iB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729794457; x=1730399257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnCw1JhVMlHCUGTY3kum+p0Q1aFqVM0KcNSrF8JwsPI=;
        b=j4GRI0G2vb/q+XA2aohcH1iVSTBJVdv4Ld0Qv3kRc0fVzZePrP63nFwNI8SNHCSHii
         6KMa/vigs5KQEEYn+6YdHjYc5oW+/EHw+7ApFONHkkQgBfqH5o0Wycf5pIb8eW/U2fP+
         1ZLZDLOpsc70jtk3xrTOVzrsnixK+nupICpd0iYoNjE4BGLsOcdszkkIEKCsDSNTe+6n
         iY0bJOH0tIUcOaFFu/464Fy3jQjuNyuWFMIpq7XYQqMd0BtTkFAoh6MWoyofyapUiL4i
         J0icvqO942MweLcI6ZR8Jni6RPN6VQrSOFubcm/JPES3vUvaKYBxweCduOPt+riD6l6J
         UXgw==
X-Forwarded-Encrypted: i=1; AJvYcCXY4QPKfjnksoV1YxMYfjVPgnczFB+7aoaSss8YOXsWtB+6U8wFhDvs0wdexsG2aG+2N+/jGEZOTXlw+/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1+UW0llkjEjTq4XTdTav53ru38SoVtUbbC/W5vCbF/2XkvFNv
	fXBMHxU+JD0qVA1kvFF3UKPBc2eUH9oTQy/djSl5o7c6zg6ZG77l2MRyow==
X-Google-Smtp-Source: AGHT+IEBPBCFA4h1dCF6M6Hf06zbdyffRIp7Hmj/DaJV8EgbELZs/3lyfSNGnkzlVPPs3rqm+iq3zQ==
X-Received: by 2002:a17:907:7ea0:b0:a9a:1437:3175 with SMTP id a640c23a62f3a-a9abf92f2cbmr646570166b.51.1729794456697;
        Thu, 24 Oct 2024 11:27:36 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a915979c8sm647277366b.198.2024.10.24.11.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:27:36 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/ioperm: Use atomic64_inc_return() in ksys_ioperm()
Date: Thu, 24 Oct 2024 20:27:10 +0200
Message-ID: <20241024182725.177961-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
to use optimized implementation on targets that define
atomic_inc_return() and to remove now unneeded initialization of
%eax/%edx register pair before the call toatomic64_inc_return().

On x86_32 the code improves from:

 1b0:    b9 00 00 00 00           mov    $0x0,%ecx
            1b1: R_386_32    .bss
 1b5:    89 43 0c                 mov    %eax,0xc(%ebx)
 1b8:    31 d2                    xor    %edx,%edx
 1ba:    b8 01 00 00 00           mov    $0x1,%eax
 1bf:    e8 fc ff ff ff           call   1c0 <ksys_ioperm+0xa8>
            1c0: R_386_PC32    atomic64_add_return_cx8
 1c4:    89 03                    mov    %eax,(%ebx)
 1c6:    89 53 04                 mov    %edx,0x4(%ebx)

to:

 1b0:    be 00 00 00 00           mov    $0x0,%esi
            1b1: R_386_32    .bss
 1b5:    89 43 0c                 mov    %eax,0xc(%ebx)
 1b8:    e8 fc ff ff ff           call   1b9 <ksys_ioperm+0xa1>
            1b9: R_386_PC32    atomic64_inc_return_cx8
 1bd:    89 03                    mov    %eax,(%ebx)
 1bf:    89 53 04                 mov    %edx,0x4(%ebx)

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
v2: Mention specific code improvement on x86_32 target instead
    of register pressure issue
---
 arch/x86/kernel/ioport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index e2fab3ceb09f..6290dd120f5e 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -144,7 +144,7 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 	 * Update the sequence number to force a TSS update on return to
 	 * user mode.
 	 */
-	iobm->sequence = atomic64_add_return(1, &io_bitmap_sequence);
+	iobm->sequence = atomic64_inc_return(&io_bitmap_sequence);
 
 	return 0;
 }
-- 
2.42.0


