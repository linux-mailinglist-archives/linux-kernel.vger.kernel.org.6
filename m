Return-Path: <linux-kernel+bounces-249936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B7992F1E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF8A1F226E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F601A0B10;
	Thu, 11 Jul 2024 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVQcbup0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBF31A0711
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720736885; cv=none; b=Sf7fEJxWDTKtIHXFsBaXEZy8AyXqyRLIj2A2ss/4AapN53XUuADNYvw8vlAnsJc3HKrenZXeVyAwmdRMU07TS0FdGISyROM9yO2QwVCxPyUYULJDQQa7FnkiIwVxZ/O2WQAiNiBDG/SQbayqtAQ5mGqPbhFJsuM1CK/PYwf8gYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720736885; c=relaxed/simple;
	bh=BoNFTMNodlsB+PzOqqm9FaRQDDjFEoEodW/SZ/JxIgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=numPhHBTw/4rLcEjfCSuzOVwGIiutJPSoUgo9H8bcdt9EQbhffmAMp7V5iLEe/ikMZf+LJPb0huU5dnEFQeosFCc25VywDiIVijb4gKae+iFAWnVINv1Nf/a86pjDau6cGWma7NUgwuyCueJfUrXFUc2it3BiMWOjr9XFeWCszs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fVQcbup0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720736882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eD20AnLzqduoYD1gk5YMqXZJv49fFs5h4FT96ZIsKZg=;
	b=fVQcbup0avwjFhXr2sE+QRQbSM6t5+wQFS8EpOkkTWkJYFVA1gv6MiciQSI0MVw12jd8ia
	KOQPUBiL/cyQJzkhqUsDi+2XcUT3AqZXr7f+Cd7VRmwGymW9Lu1AMZXOCqeupmBOlQ/sXa
	yYFdbvM0HC2Gyu/vnpV+t2dY4cvZFAU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-llKx0sUsNyaWHEDP-qGuUw-1; Thu,
 11 Jul 2024 18:27:59 -0400
X-MC-Unique: llKx0sUsNyaWHEDP-qGuUw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C219196CE01;
	Thu, 11 Jul 2024 22:27:58 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B2C9619560AE;
	Thu, 11 Jul 2024 22:27:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	michael.roth@amd.com
Subject: [PATCH 02/12] KVM: guest_memfd: delay folio_mark_uptodate() until after successful preparation
Date: Thu, 11 Jul 2024 18:27:45 -0400
Message-ID: <20240711222755.57476-3-pbonzini@redhat.com>
In-Reply-To: <20240711222755.57476-1-pbonzini@redhat.com>
References: <20240711222755.57476-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The up-to-date flag as is now is not too useful; it tells guest_memfd not
to overwrite the contents of a folio, but it doesn't say that the page
is ready to be mapped into the guest.  For encrypted guests, mapping
a private page requires that the "preparation" phase has succeeded,
and at the same time the same page cannot be prepared twice.

So, ensure that folio_mark_uptodate() is only called on a prepared page.  If
kvm_gmem_prepare_folio() or the post_populate callback fail, the folio
will not be marked up-to-date; it's not a problem to call clear_highpage()
again on such a page prior to the next preparation attempt.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/guest_memfd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 522e1b28e7ae..1ea632dbae57 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -73,8 +73,6 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index, bool
 
 		for (i = 0; i < nr_pages; i++)
 			clear_highpage(folio_page(folio, i));
-
-		folio_mark_uptodate(folio);
 	}
 
 	if (prepare) {
@@ -84,6 +82,8 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index, bool
 			folio_put(folio);
 			return ERR_PTR(r);
 		}
+
+		folio_mark_uptodate(folio);
 	}
 
 	/*
@@ -646,6 +646,8 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
 
 		p = src ? src + i * PAGE_SIZE : NULL;
 		ret = post_populate(kvm, gfn, pfn, p, max_order, opaque);
+		if (!ret)
+			folio_mark_uptodate(folio);
 
 		folio_put(folio);
 		if (ret)
-- 
2.43.0



