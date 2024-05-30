Return-Path: <linux-kernel+bounces-195770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 282428D51A7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 20:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93A72827D5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2024A4C62B;
	Thu, 30 May 2024 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuVH/o/m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE96D21A04
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717092954; cv=none; b=AeRenPYO61znbzmoAKcLm6ujWb+PfkeX1gfjY0hx80gY11a+mUxLMOuZ+zF4XAC7qrQBtaOMuTyk7EVrcM6+k1wl4iAP2aoDyWfjW2sR3GJRFx6G9IJofnaRErIIOBSJjQHWgzjKezm39B2B5f7BqbFQ9GrCcrL0r226b/YFZsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717092954; c=relaxed/simple;
	bh=LC2LFASKLycCWwgWib7+As2B9QvQG4dAU80ivl+WCiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=qL0ACclzf1Qf7s2QqPRrxTg18gk3+BTk62Bx+Xt1fTpkA8CZRY0ly5/TTYpA6DFVFK01ELeONfN9ILr77k59uY0FjoQbuaIeHA2nDBGTyfkcnNHbU1WA5InxKNbq0vBZnDaFcp929KshvG0ysqxZeh5kTxtKV+fcZGGj9F00maI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PuVH/o/m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717092951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kln2C1eGajhL471DTyFoWZmkDHGttOID0nRSwMzuGL4=;
	b=PuVH/o/mO/y4L9EGB+kYICPhZly6zfECeEGHsyQrkoA2e2lh10ajfUaE+9AQ13mqY5/pEF
	xFlZGvSttkag7/CBUequwUNLM2VuuLjK5e4ER/wgx5uORTl/th9/Mm/V4+1aoombBHJbje
	Kxtcgme1hykum2jsXXxM9gJejNcaKkw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-Z3vdj78hOWuoOR0G95K5VQ-1; Thu, 30 May 2024 14:15:50 -0400
X-MC-Unique: Z3vdj78hOWuoOR0G95K5VQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8E00185A780;
	Thu, 30 May 2024 18:15:49 +0000 (UTC)
Received: from pauld.com (dhcp-17-223.bos.redhat.com [10.18.17.223])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D1A641C0D100;
	Thu, 30 May 2024 18:15:48 +0000 (UTC)
From: Phil Auld <pauld@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Tony Luck <tony.luck@intel.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH] sched,x86: export percpu arch_freq_scale
Date: Thu, 30 May 2024 14:15:48 -0400
Message-ID: <20240530181548.2039216-1-pauld@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Commit 7bc263840bc3 ("sched/topology: Consolidate and clean up
access to a CPU's max compute capacity") removed rq->cpu_capacity_orig
in favor of using arch_scale_freq_capacity() calls. Export the
underlying percpu symbol on x86 so that external trace point helper
modules can be made to work again.

Signed-off-by: Phil Auld <pauld@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: Tony Luck <tony.luck@intel.com>
Cc: Qais Yousef <qyousef@layalina.io>
---
 arch/x86/kernel/cpu/aperfmperf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index f9a8c7b7943f..b3fa61d45352 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -345,6 +345,7 @@ static DECLARE_WORK(disable_freq_invariance_work,
 		    disable_freq_invariance_workfn);
 
 DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
+EXPORT_PER_CPU_SYMBOL_GPL(arch_freq_scale);
 
 static void scale_freq_tick(u64 acnt, u64 mcnt)
 {
-- 
2.43.0


