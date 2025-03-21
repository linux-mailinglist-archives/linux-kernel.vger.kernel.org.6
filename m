Return-Path: <linux-kernel+bounces-571152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3D0A6B9CD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B33E17A7AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D58222592;
	Fri, 21 Mar 2025 11:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVPwABOl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021B4202C27
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742556309; cv=none; b=hCI1J4nOgrBhdXQamVDky1negqnjStg97jW/DnwTEdrsaWm4rQzc3ru2NuIMIo/e1QpjkMEFyhOntUgKM9/CGmcdRhp0Ae7eupp4X7WhExceC3IpEXbExmF1V2P5OlAiKRBLJJ4xFVBdqhtqxcNeUNAQIF30wjvQHpFFs3J2Y/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742556309; c=relaxed/simple;
	bh=u0EjgSJifflexR+35I81JttJpVm/rb4jI7wc9Cthm88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p/1XLoWf1nWmgbIp/9r/yLvCBo3q8jsVUjPyUnW9T60I68a4BK8EvgEPQf/KXP+voZRVtog4nvaSAseLJmes2Uc8KbCON2Pihq0bxrRUTO4DdsozacqBnHulpisimr0iZacOoBx1MDBCnMsejbFcXBBLGXkSz40pPJ9MDY/Aong=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVPwABOl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742556306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q/45+X0nz6DYq9cPSKysVGVnJ9IivWVYXHf1OYLZvh4=;
	b=CVPwABOlnS0zbD4spgIPVfNQ+yhu+Qg671r7QP2smtk86N2xVt59MKtkJ/HA/mSgJOsz/M
	XzXyhGq5CSvrhQlHDXeS/0zw63B6jPMOMAycYoyrEumQrWLef8Hky0MnRJWrjAXGvr6HCS
	4RyLmWgUmsEuVJCRIP9KzayrG63hEkE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-H-lpW1u0OrOjg9GoXfw0Sg-1; Fri,
 21 Mar 2025 07:25:03 -0400
X-MC-Unique: H-lpW1u0OrOjg9GoXfw0Sg-1
X-Mimecast-MFC-AGG-ID: H-lpW1u0OrOjg9GoXfw0Sg_1742556301
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC655196B36E;
	Fri, 21 Mar 2025 11:25:00 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.44.34.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2DD171800268;
	Fri, 21 Mar 2025 11:24:54 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Ryosuke Yasuoka <ryasuoka@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-mm@kvack.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH v2 0/2] drm/panic: Add support to scanout buffer as array of pages
Date: Fri, 21 Mar 2025 12:16:54 +0100
Message-ID: <20250321112436.1739876-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Some drivers like virtio-gpu, don't map the scanout buffer in the
kernel. Calling vmap() in a panic handler is not safe, and writing an
atomic_vmap() API is more complex than expected [1].
So instead, pass the array of pages of the scanout buffer to the
panic handler, and map only one page at a time to draw the pixels.
This is obviously slow, but acceptable for a panic handler.
As kmap_local_page() is not safe to call from a panic handler,
introduce a kmap_local_page_try_from_panic() that will avoid unsafe
operations.

[1] https://lore.kernel.org/dri-devel/20250305152555.318159-1-ryasuoka@redhat.com/

v2:
 * Add kmap_local_page_try_from_panic() Simona Vetter
 * Correctly handle the case if kmap_local_page_try_from_panic()
   returns NULL
 * Check that the current page is not NULL before trying to map it.
 * Add a comment in struct drm_scanout_buffer, that the array of
   pages shouldn't be allocated in the get_scanout_buffer() callback.

Jocelyn Falempe (2):
  mm/kmap: Add kmap_local_page_try_from_panic()
  drm/panic: Add support to scanout buffer as array of pages

 drivers/gpu/drm/drm_panic.c      | 142 +++++++++++++++++++++++++++++--
 include/drm/drm_panic.h          |  12 ++-
 include/linux/highmem-internal.h |  12 +++
 3 files changed, 159 insertions(+), 7 deletions(-)


base-commit: f24d1d4a7a425e67551ca8d86a89df7102766ac9
-- 
2.47.1


