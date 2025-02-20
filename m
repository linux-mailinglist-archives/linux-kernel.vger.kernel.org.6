Return-Path: <linux-kernel+bounces-524331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B707AA3E1E0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A83C18994B6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5309E214A7A;
	Thu, 20 Feb 2025 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbxPtleo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0447A2144AD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071186; cv=none; b=kwGtjsR6GDQkOWsPhJ2iyf/LFmnotI7J7Io77rOqG8ZnopO0Q3hhcacLDQ2V0mGO12kgnoktwZaslm1uJabkkGwxkxXlXZUnYsBftW9VUroiEKYAe6J4EsIo90QZZeDaTX5BX2FIeZDJshdtCQBEwZaEqiPQoVxs1Eyz1jguHVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071186; c=relaxed/simple;
	bh=7o4MI2SWfvup5UD+qqNq6pDUDm+stiy6rOOP3Q809Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0UCCskbFz7UBLgrkcsBkl/D/8SCvIpcnVNp6xHt7Wu67+M/zXjcLbVdOkVsPTjEyhoHNExnOwOG1KKbVJFGlhJVqAyYMfXUJ+yuQG2LXlUZhNrT29gyDUkGoBG0YrRbzgCp3M9POUbI2bYSg/KzeTTb6V5qrNaZQKKPrK9J/Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MbxPtleo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740071183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKSKOdbW5lvB/N/H9qi5+SwkOKNYt+M8QNhPBs9dcO8=;
	b=MbxPtleoUCzWkhApusw7/HRWdhV4X+XaQFN7zlDNMqDhkWnwduuOsL76zD3bHV5PE/dguk
	xy0G0HtBCAK5LmhzIFAkgJIxk2W2/0+RxX/Zvu9GX3terQErVxmJFVt2mDYvbcxS/W7wH9
	ia0NOd9uYXK3VEo+nnUoJTJaTxL6Fyw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-T9jSxB5VMDKS2aKHpEQtYw-1; Thu,
 20 Feb 2025 12:06:19 -0500
X-MC-Unique: T9jSxB5VMDKS2aKHpEQtYw-1
X-Mimecast-MFC-AGG-ID: T9jSxB5VMDKS2aKHpEQtYw_1740071178
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFEDD19560B9;
	Thu, 20 Feb 2025 17:06:18 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BABE81800D9D;
	Thu, 20 Feb 2025 17:06:17 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Yan Zhao <yan.y.zhao@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH 07/30] x86/virt/tdx: allocate tdx_sys_info in static memory
Date: Thu, 20 Feb 2025 12:05:41 -0500
Message-ID: <20250220170604.2279312-8-pbonzini@redhat.com>
In-Reply-To: <20250220170604.2279312-1-pbonzini@redhat.com>
References: <20250220170604.2279312-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Adding all the information that KVM needs increases the size of struct
tdx_sys_info, to the point that you can get warnings about the stack
size of init_tdx_module().  Since KVM also needs to read the TDX metadata
after init_tdx_module() returns, make the variable a global.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 369b264f4d9b..578ad468634b 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -53,6 +53,8 @@ static DEFINE_MUTEX(tdx_module_lock);
 /* All TDX-usable memory regions.  Protected by mem_hotplug_lock. */
 static LIST_HEAD(tdx_memlist);
 
+static struct tdx_sys_info tdx_sysinfo;
+
 typedef void (*sc_err_func_t)(u64 fn, u64 err, struct tdx_module_args *args);
 
 static inline void seamcall_err(u64 fn, u64 err, struct tdx_module_args *args)
@@ -1061,15 +1063,14 @@ static int init_tdmrs(struct tdmr_info_list *tdmr_list)
 
 static int init_tdx_module(void)
 {
-	struct tdx_sys_info sysinfo;
 	int ret;
 
-	ret = get_tdx_sys_info(&sysinfo);
+	ret = get_tdx_sys_info(&tdx_sysinfo);
 	if (ret)
 		return ret;
 
 	/* Check whether the kernel can support this module */
-	ret = check_features(&sysinfo);
+	ret = check_features(&tdx_sysinfo);
 	if (ret)
 		return ret;
 
@@ -1090,12 +1091,12 @@ static int init_tdx_module(void)
 		goto out_put_tdxmem;
 
 	/* Allocate enough space for constructing TDMRs */
-	ret = alloc_tdmr_list(&tdx_tdmr_list, &sysinfo.tdmr);
+	ret = alloc_tdmr_list(&tdx_tdmr_list, &tdx_sysinfo.tdmr);
 	if (ret)
 		goto err_free_tdxmem;
 
 	/* Cover all TDX-usable memory regions in TDMRs */
-	ret = construct_tdmrs(&tdx_memlist, &tdx_tdmr_list, &sysinfo.tdmr);
+	ret = construct_tdmrs(&tdx_memlist, &tdx_tdmr_list, &tdx_sysinfo.tdmr);
 	if (ret)
 		goto err_free_tdmrs;
 
-- 
2.43.5



