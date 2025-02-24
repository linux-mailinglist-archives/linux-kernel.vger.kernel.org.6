Return-Path: <linux-kernel+bounces-530192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243BDA43048
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFAE53B4CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3B420CCEA;
	Mon, 24 Feb 2025 22:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eK1raW8J"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FE120C006
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740437574; cv=none; b=KLw72HAYIStqx4TE+/1gRf+PVOeXZvx9eDRqpMmpT/ekqRPC6EsA06h3ydoiF0NhgmmE6VoRXE2HGg+Ygt21eZtsuYniNwOYzs+pQ3iqerNdEJXQYQ97yA1rk5/mHLzzStG0pnXzhhXVucb5ZZB58r1073k3EHszKVLptzuty60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740437574; c=relaxed/simple;
	bh=3yyGx1/qbWOwaz7n1P3h6mE9HnHTR0hKpDC/6427r/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUDouMl4PQLor3uua0rJHrLOa7dqnfjFVPeSUF4mqSL9H9Oe7uzwpzF+j7xiGtTGN85bBO/5tiWR5NCpp/KMu+nssAjHq/ETXDG4NILgIwc8KetMe7WdAx04xZHNLgntItZ/nZqjWKhaNKMlDAirWgG+zu+Jbm3sywn23v9WWs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eK1raW8J; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220cd9959f6so12644925ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740437572; x=1741042372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JxfqC34JK5pAuQi2kIh7I1xgd0YTjcXZqYM95ZHnLw=;
        b=eK1raW8JNsYOQOtcpNo0y2Imk49/hd//ZKeYo0qEeTEbAoLvYeBopRePA2dTkIR+th
         bHV7fzfm2WKbKqKsCAK3NX1PnIraL9MVvSA4Vy4XPDNNK+jo0Vbau4vI/Kz43QvB5FKN
         AUMG9ppnJIUKX1gvDi5yKNHGQzIHT36+9LnJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740437572; x=1741042372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JxfqC34JK5pAuQi2kIh7I1xgd0YTjcXZqYM95ZHnLw=;
        b=p6zzdrUUiua99ZFxetCs+p4/bQ3Keb9ejMi8K0HXcOftOK61ve4JO4Xp96SGPB7fZ6
         t6VurLPoSr8B6Mm1slry+i2JOEjmHXcvtyNhEFWf797b+Lyy/WbEOiG+hENiUZrJmHHg
         Xfn2Dzo+vTe5itj3YG/13s5RE5rP9kDsQeuEDoLO+sk5g7JT9eY+G9JEWTpUxM+l0Rk6
         Ml7MlVF9c64gTD1qurzD+gYr4o+w7Mkfnmap3iRGRGvSl/lG+3yjrnjcEv3oZOP1Udhf
         kPp1ub7ObABOylyAZGE4EYH6z8pc4NKEOg3e05jUnCOkkjGITHttZAsSbUdzvop0WpsI
         eObQ==
X-Gm-Message-State: AOJu0YzWa/B/blhQFN3rLpYw9fUORNIVl9p2Ih/z5Ffo+0dpYJ9oNigF
	wH8uF0EwTQ03EVhahPvfA2zyGTQE9IL5AcHd+vGaE03gepqlmpCdT1KwhnEHbw==
X-Gm-Gg: ASbGnctJUmpdeVszf4kapfUs9wQ6F6IzKBf/aEqvgrKf/TIk6V0vd1o3hKmNjacKzdk
	UesiAOFyB1Rf0/CyK1ALZNXsGNss8TKNIpWGW436fVM8cvaumPe7TTxGyvcQbD1K3Vimdb4uXuE
	+6g+b1qDcGbxjucLqs2zIQhik89zq6IxYNrdg7ayoQ54cb94QBBBrBwWHqDn4PNS4mKk/GEPweq
	C9XT4N3IE8fpcp7KhgAcWHdiZxI/qF+XjDf6lHJ66OOkgB5EhlgQXufwuFDeHZhjQVZ+GMu+VHl
	ZRrim3wZ7t//d4armzThKDWJbSJzH8mycPVlwpdcHRXV53uQ8L0G/zateDvg
X-Google-Smtp-Source: AGHT+IF5qFqZ2XMAkd11tZhw0TNlD5KvpPShH7QiyA0ymh3azQkuml1yZnRKVOO/3ENETx0NVF9uNw==
X-Received: by 2002:a17:903:18d:b0:220:f181:4e70 with SMTP id d9443c01a7336-2219ffdfa48mr97695445ad.10.1740437572458;
        Mon, 24 Feb 2025 14:52:52 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a095f02sm1313475ad.152.2025.02.24.14.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 14:52:51 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v7 5/7] mseal, system mappings: enable uml architecture
Date: Mon, 24 Feb 2025 22:52:44 +0000
Message-ID: <20250224225246.3712295-6-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250224225246.3712295-1-jeffxu@google.com>
References: <20250224225246.3712295-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on UML, covering
the vdso.

Testing passes on UML.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Tested-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/Kconfig        | 1 +
 arch/x86/um/vdso/vma.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 18051b1cfce0..eb2d439a5334 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -10,6 +10,7 @@ config UML
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
index f238f7b33cdd..fdfba858ffc9 100644
--- a/arch/x86/um/vdso/vma.c
+++ b/arch/x86/um/vdso/vma.c
@@ -54,6 +54,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
+	unsigned long vm_flags;
 	static struct vm_special_mapping vdso_mapping = {
 		.name = "[vdso]",
 	};
@@ -65,9 +66,10 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		return -EINTR;
 
 	vdso_mapping.pages = vdsop;
+	vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
+	vm_flags |= VM_SEALED_SYSMAP;
 	vma = _install_special_mapping(mm, um_vdso_addr, PAGE_SIZE,
-		VM_READ|VM_EXEC|
-		VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+		vm_flags,
 		&vdso_mapping);
 
 	mmap_write_unlock(mm);
-- 
2.48.1.658.g4767266eb4-goog


