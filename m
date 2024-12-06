Return-Path: <linux-kernel+bounces-435005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CE19E6E5F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8F516C366
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB0B20D516;
	Fri,  6 Dec 2024 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNFG/23r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE12B20DD58
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 12:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488364; cv=none; b=iivU+1S2XAy+N6vaBNX/3tfi+TzEeHp9yW0rxOR8KJNDGcdWu8sjEoo7L9CzL3U5efM1sQprZS4T9s5iRV08UFRAHb+KMDBYRw2ppzvfbQXXEnUN3GT2m6HQhGqBAVAFK/LWdIJOk4qTKu4703/rJGDZ+NNiX/lfMhTEBdqz998=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488364; c=relaxed/simple;
	bh=jhLpLzAPUF+XA3KSAhJKbSpjZOfDHbrOg8VaYiFZMUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcH35049DCBui2nCWMt1l6LhBwgPPYuTaCLKLEqZmjBqQewmO05JxQE2Klxahbd8lMWus0Cl1p3ybwzK6HhAxJN4MmuI6QfFiXDgbzQG5oFe5KKsvAcVmudIc6vtM9MkZZtF3MMZSyp+VZIAkSqaqwAN7ZjLfTwwbiqP/XL8uAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RNFG/23r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733488361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IAUli4UsTo3vNvkRGl479rru1WQuKkigkASVaArPxOU=;
	b=RNFG/23rIeJs4+D7Ur14OCKZlLjawV3FpcdvWyl5dpLjjK5AZIG8bYLgBcvrsPWj88yH1U
	JUNO61JUDz+7PuFQT9v+C2h073TUg1XfWMFF2kRe66rUDhkj2cvGuBN9cYMs3Eq3MQNCZN
	tnjSJUiFRp5Dn9sMUNmnnNVMO4dOdXM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-lVytOQ0DN6-pY4XBVMRnig-1; Fri,
 06 Dec 2024 07:32:37 -0500
X-MC-Unique: lVytOQ0DN6-pY4XBVMRnig-1
X-Mimecast-MFC-AGG-ID: lVytOQ0DN6-pY4XBVMRnig
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51F15195605A;
	Fri,  6 Dec 2024 12:32:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.103])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id ABC851955F3E;
	Fri,  6 Dec 2024 12:32:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  6 Dec 2024 13:32:12 +0100 (CET)
Date: Fri, 6 Dec 2024 13:32:07 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org,
	Fangrui Song <i@maskray.me>, Nathan Chancellor <nathan@kernel.org>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] x86/stackprotector: fix build failure with
 CONFIG_STACKPROTECTOR=n
Message-ID: <20241206123207.GA2091@redhat.com>
References: <20241105155801.1779119-1-brgerst@gmail.com>
 <20241105155801.1779119-2-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105155801.1779119-2-brgerst@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add the necessary '#ifdef CONFIG_STACKPROTECTOR' into
arch/x86/kernel/vmlinux.lds.S

Fixes: 577c134d311b ("x86/stackprotector: Work around strict Clang TLS symbol requirements")
Cc: stable@vger.kernel.org
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/kernel/vmlinux.lds.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index fab3ac9a4574..2ff48645bab9 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -472,8 +472,10 @@ SECTIONS
 . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
 
+#ifdef CONFIG_STACKPROTECTOR
 /* needed for Clang - see arch/x86/entry/entry.S */
 PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
+#endif
 
 #ifdef CONFIG_X86_64
 /*
-- 
2.25.1.362.g51ebf55



