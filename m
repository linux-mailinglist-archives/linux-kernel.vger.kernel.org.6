Return-Path: <linux-kernel+bounces-343053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C04989646
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 18:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5B21C21243
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 16:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D0417C230;
	Sun, 29 Sep 2024 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFpgYBDO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E2E2AE90
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727626873; cv=none; b=GwKFa8gHrECWUglQ0bVCofbYGVtCyTHGt/ovFBHkDqTMFQTSxGtwj8RBk/MUiYQort3n6v+pcs2sXF3G0rS5irZ3vbR0INgdtT4XgzaPUgWjaVeIozCRz+WrBKM5lo4Qz9tcTWMNUAmkl9PYO3AqZozqpi6PAI8wrFky8vTlIUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727626873; c=relaxed/simple;
	bh=4hmc4lYUM+Hq0Weh3U5JDS0v+teBgb/Kwnav8gETdek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkvsyJAZT38sCSyyzT4YNu1wlpHdtRR1Eg/yfTZuvhl+chLSBMzVjSqqICBJWnB0Vy2H6M3CUvTAr92Of2okj5Or6z6+qK2hj/eYUV53ch8/tvS3LRNg7OcEG4pb7Z9eKfwTm6cNiGnAkimcR8Jpm/EVy6bi3z9Z5BNtkZrQcHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TFpgYBDO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727626870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GpMbFhlJr+HtugTYjdYpFr0NxbT5DfOWztdS3TGbU7w=;
	b=TFpgYBDOBvepu7nAQ3Ew7N+wuWM/C4PNxqYqfGbosTV22M/qV+S13RuW32uPBzJzXr91kI
	zVQQb7xC/xEeVo70ihBTpOpZxAlaTGjscltUdipZwP/kQct3iyisIn3JJYJDQ5ozKzSMh6
	uFQvPHtZUVNSlCzKvpNTVPMQT87SDUA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-a69PBJbZPk-QzP2I0kaQAQ-1; Sun,
 29 Sep 2024 12:21:06 -0400
X-MC-Unique: a69PBJbZPk-QzP2I0kaQAQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 451D0195FE13;
	Sun, 29 Sep 2024 16:21:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.44])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 47BCF1944B22;
	Sun, 29 Sep 2024 16:21:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 29 Sep 2024 18:20:51 +0200 (CEST)
Date: Sun, 29 Sep 2024 18:20:47 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	"Liao, Chang" <liaochang1@huawei.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] uprobes: fix kernel info leak via "[uprobes]" vma
Message-ID: <20240929162047.GA12611@redhat.com>
References: <20240926162901.GA9716@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926162901.GA9716@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

xol_add_vma() maps the uninitialized page allocated by __create_xol_area()
into userspace. On some architectures (x86) this memory is readable even
without VM_READ, VM_EXEC results in the same pgprot_t as VM_EXEC|VM_READ,
although this doesn't really matter, debugger can read this memory anyway.

Reported-by: Will Deacon <will@kernel.org>
Fixes: d4b3b6384f98 ("uprobes/core: Allocate XOL slots for uprobes use")
Cc: stable@vger.kernel.org
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2ec796e2f055..4b52cb2ae6d6 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1545,7 +1545,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	if (!area->bitmap)
 		goto free_area;
 
-	area->page = alloc_page(GFP_HIGHUSER);
+	area->page = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
 	if (!area->page)
 		goto free_bitmap;
 
-- 
2.25.1.362.g51ebf55



