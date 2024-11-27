Return-Path: <linux-kernel+bounces-423845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B399DAD81
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26033B22605
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD402203715;
	Wed, 27 Nov 2024 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VrHBbErr"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83F1200119
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732734246; cv=none; b=fu/ND5UAxpow73Zvx9y8H7lV2x9ta7ervxzIDF64wNa+q4fNvMI/PWZmaDq09Cw30GOugEaTJsGTxp7Lpts7qAkAXxJ+rsaf6UeYVIog9watEFis0A3wL/OYQ9lJ2B7l4ZS5XkvmaXa7WxasVN288NQnP4KMJsL0oYGZk4T/fPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732734246; c=relaxed/simple;
	bh=HZMzJO0ERgKBSdgHCinISLLLJ2P1/lAUKPmv9/37Fgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SaxrlgbeORZgfHfePh+32JWfXI1+tZyyiZd069EMUI+ks3zJaxJ9yHk/aQi9g7VtvT8YciEzcder6pOJJ7RBPJ7nGIAmdGeDNOJrywslwnoyWFWGw+J2Kf80nZy+Bu4oFqQrUJgQwI0vhuxQesq/cQ7IDWH5fMpYi4TLsudMFP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VrHBbErr; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Bu60bcDvZzloSAXCkbCegV/lwySuet3eE7e1Gl1k8gk=; b=VrHBbErrDgCmTebG6pTRQKsfBK
	ivsQF0WiwGKvaxQZGgicLI185iWwM2QVj8/ROA7y2WScYLTbph0q18oXEO2OatPjYIhgSanOUz7HX
	Svp77FKyy3Kf4VVhhhBsOVQjBo4Cy9312AyQtAUhhN+oRmOrHI4xzvnR5leyRr/JvIh7Vf3zHLqIb
	vGKcgWfxCi/LpZfXsivlNV1T4PK/JQfQmQ2hnX8Oefd10fC+dPDNpOstaoL2ngUnVL3VFrd5EL8Nw
	YsuNGbO0n+yomlabePM85oSU8+FQFF4e62vDjOOk+KckKN3na2wgx+sAqhQKBS6jF2phYum+dJiYd
	Dkc8Q6BA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKF-00000001Sug-18A7;
	Wed, 27 Nov 2024 19:03:47 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKE-00000000Bj2-28rJ;
	Wed, 27 Nov 2024 19:03:46 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [RFC PATCH v4 14/20] x86/kexec: Mark relocate_kernel page as ROX instead of RWX
Date: Wed, 27 Nov 2024 19:00:28 +0000
Message-ID: <20241127190343.44916-15-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127190343.44916-1-dwmw2@infradead.org>
References: <20241127190343.44916-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

All writes to the page now happen before it gets marked as executable
(or after it's already switched to the identmap page tables where it's
OK to be RWX).

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index c9fd60f8f806..9232ad1562c8 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -323,7 +323,7 @@ int machine_kexec_prepare(struct kimage *image)
 
 	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
 
-	set_memory_x((unsigned long)control_page, 1);
+	set_memory_rox((unsigned long)control_page, 1);
 
 	return 0;
 }
@@ -333,6 +333,7 @@ void machine_kexec_cleanup(struct kimage *image)
 	void *control_page = page_address(image->control_code_page);
 
 	set_memory_nx((unsigned long)control_page, 1);
+	set_memory_rw((unsigned long)control_page, 1);
 
 	free_transition_pgtable(image);
 }
-- 
2.47.0


