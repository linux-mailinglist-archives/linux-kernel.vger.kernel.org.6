Return-Path: <linux-kernel+bounces-561660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FCBA61495
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84EEF1B6311A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15051200119;
	Fri, 14 Mar 2025 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBdE7JvL"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8A92036E0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965171; cv=none; b=CPNVTaztREK2iks/pogzRGvTg3uBVV1uVqlTylpa9U/dc/ZbLaHPhRvZL7Bkxl3JnzbCrtWK3k4xqkwtigCFL6pvL5OvwR0XTJdwES0zrOBMkGEN7NzzrCPK3jWTE2wc3wPh1+r/Dg4zRxQMxmgIRJqHLyqjhadiIpPLAU2MNYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965171; c=relaxed/simple;
	bh=DGaQ8KNqj5JX+vu9aJ/q2g9z8GN4HJfBRJSib5L7PVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzQQYVV3mjugeu8PQFRNd6Xu7/0bG1mLK7mhrA19zvWhXbYYBn9+EZRwDf76GuiBzPAhO6CVC8fx2lF1cvfdbFw2W5FnAuKJn5RoRr1ttnjddMZmRCo/xQ8BQPyLycuCC3rOSQTJSyx/lcnzjFNaoUhQqZNOCvh/kTPE+8l3p9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBdE7JvL; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2bcc5c887efso1830265fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741965169; x=1742569969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPkJbM+LB7smtMlLHqRxnuiLsZ6gkfVdWfSfDGioiKY=;
        b=XBdE7JvLT1ULBph+kYl0nLJcYgdy7PX+5KCE7ax4/HxWQ88+BZ7IFlJhCabL/hCcIV
         fBlErBJrrA2A29Kww+DFgQdePS3bhn+g+WIOSHZaeX88dHjfywEFU9q85tdO+1Kx2GqC
         iTnCiTRHnNf9FdBCConGGOGLO6Sps4n8lIQlgCISDsYG44a/xVvkWOVqUeN6Xr5TW5Z1
         w3MrYnFEssD3zL8X97020BGvU0ST4Ojdd+Ac74NeHXfiUwDsBcBBG2VLqqhezhenXX8q
         u1iK/tHpY/EJZHTWXmUukueXhPj475CuAUde1qcPE9/jIrlOfYfWCXzpMmslG1Uy1F8B
         1ZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741965169; x=1742569969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPkJbM+LB7smtMlLHqRxnuiLsZ6gkfVdWfSfDGioiKY=;
        b=UGOCacBBXTKNlEmKDv3Wm5RssGtw/KaGfT10qV0dZsMyIOq6gCUCgXRh+7OEnpPgTg
         a6dLY+CREdUyiYbTIB9qcGwD9errjsHyi3StDkVKqC8ME5qw6sCwZNnDriu8DXiPwlLz
         LP8nD2GylTcTQXUnhv1t8g0ifkFSmcOUN+B9Py+C2gpSuBa/ggsAjMLws75cVfoT1yx9
         yi3pL7UvdIVyBlwqDTAZbR3EKiYVzT10Aaqp2wwCprdNRvjliDBO3wNVpex8PtSNfczl
         OS+dPAAqS+3GTGxPJECkBEWYpdBvLlR3iMQ+T0rZFO6fjmctMk3bHHQ6HU0ayxZV+xW/
         HJYQ==
X-Gm-Message-State: AOJu0YyTsTqw50Pi62bcV4sOBKuJ3xVQS/O2OFXx8yGmeqEUMNB32sHU
	W7QuuM7ffYjCxbYoeQKQJPijILOUfMvnA3K73mAYG6BK4NDHXnTDsj0L
X-Gm-Gg: ASbGncu9Ig/81NgjfKUEzMcNRcVteXWmR17hqcjGdQDpgjPgkNTSR+swRtdqk75xcxT
	YuyAelDoq6Fe5C3eQcPjZptlv+LsacMMrPKoTYPnFi9PGKsRQlzO0BsrjQkhnmpEEBMC669NgdX
	26O8SN5cPYP8qFT+rYkk9NfqhJhrX/u6+L5kuiePm0vGAkzIICBRPf23XxIoJRtw9CwdBD+0CVJ
	SxAVGJbiv0t75yXSfNlNwz2b1GBX/5+GbQo75j/6IvDnD3WQ3UdLd6xxcTQTlAC0TT8pF8PYj7k
	pLcvhRXnm/+UQRk0CmvsTM5emFjkE2HDfvz4
X-Google-Smtp-Source: AGHT+IEpS/x4kN0eYs37tl0L+r0Fo7v65AtFdSROcUeGHnZ9j2RneAV06uq5ofBr8TOzT+2shiIMCw==
X-Received: by 2002:a05:6870:9126:b0:2b8:3d8c:15ad with SMTP id 586e51a60fabf-2c690ec979dmr1476448fac.1.1741965168643;
        Fri, 14 Mar 2025 08:12:48 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c6710f21efsm883026fac.30.2025.03.14.08.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:12:47 -0700 (PDT)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	Sohil Mehta <sohil.mehta@intel.com>
Subject: [PATCH v2 7/7] x86/syscall/32: Add comment to conditional
Date: Fri, 14 Mar 2025 11:12:20 -0400
Message-ID: <20250314151220.862768-8-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314151220.862768-1-brgerst@gmail.com>
References: <20250314151220.862768-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a CONFIG_X86_FRED comment, since this conditional is nested.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Suggested-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/entry/syscall_32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 993d72504fc5..2b15ea17bb7c 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -238,7 +238,8 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
 }
-#endif
+#endif /* CONFIG_X86_FRED */
+
 #else /* CONFIG_IA32_EMULATION */
 
 /* Handles int $0x80 on a 32bit kernel */
-- 
2.48.1


