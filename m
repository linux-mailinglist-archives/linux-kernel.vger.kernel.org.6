Return-Path: <linux-kernel+bounces-252632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C19CB93161D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F341F22184
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BAD18E75D;
	Mon, 15 Jul 2024 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ufxi0dwY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B8E1741CF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051547; cv=none; b=AbGWI4B/zTo5Riryqv9dlAUVgSM3hyUOeEPxDsyQ2Hq5nnVaMqbqBEMDhSYpPQfulehAq3giQgcTzDnBOjvoJqVIXgqxMBF6m6L1vWlZV1XK+ubXaRXeUM0iLVXdC19P8ZekEy7LaK87/ABR58eIlXrEKzp52RQmr5xn5TUwgPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051547; c=relaxed/simple;
	bh=iYjP3Qa8Si+xq4gyqb551hIpGdJk0F1N8bfgGruW33c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hmKfnWB6dOvhHKNZO+ZLa1gyqi+QGy7w32A/dWAgmvBW71zA3KebGGyDmT/qRwDfZ8qdDPvvXYv1tUCVR5sqUQg3bBHAwSHNmZ43j72aNSEhekAWmHB8V3zL0K4zfX9Hpet7jziiS+nhNUd+u4CWY5Tz9uRSeJmsESxVrRNK94U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ufxi0dwY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721051544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CMRK0FAuRn48/f8vk7h8IrU23AJ1MPeYBe5TQ+OfZZ8=;
	b=Ufxi0dwYXcyrXZCwd0MGkuqurUM2NC5TBZsd247pBdXR2Lwg3oypEdrLEKpxgN5K2GLZ7B
	Re0cEeu5ZOMVWd4BKMb4mKf61ZbdseVYX9HG5CQFPYn4xFbrPy7sJhPCpG8EWqvETMrnTL
	0hQtdTtVUZeTdB3SOJeZbzodr6eoyEI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-SUrlEBWGPuabFZdtWV9kBQ-1; Mon, 15 Jul 2024 09:52:23 -0400
X-MC-Unique: SUrlEBWGPuabFZdtWV9kBQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a77dbdc2cf6so346500866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721051542; x=1721656342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMRK0FAuRn48/f8vk7h8IrU23AJ1MPeYBe5TQ+OfZZ8=;
        b=GnSfvqDQWxevBZg8849v8DJPFFA90N0cshuKdeJiMw/ZV8jy93SVOrG+vYhPATekw4
         nSKZRrxLHKRegepiSqdtb33xX9SqZCV8S7dcx9WtopPrvG3CoFCxkmIPb35WMvHhAmae
         cu3t8g3i0Fqz3zZSgo/dgeSAjXgUjaFkIysTbPkWnP0IhgXj/b1Fyy71Vk02AcX78Abr
         fyhrV6QGd/bPMSNrWrzs1Rh8eyR/SBdVNUNcrGHjr2ygk74E3M9H5kPk/xV1RtaEHINh
         lxBZF6+774Lx574XqePK8GIMhMcEAvx9E3D7E1ym4cuIXQKFSAWvkcdnT10Mn7mGIS3R
         GfZQ==
X-Gm-Message-State: AOJu0YyCeqKLrGdyBABqQfvFzb0xzqPJQWgiWNefUsEoIT39hX8gcUtj
	ipGX/4jIQBnJtYGR4Zw4HnpRZctstqV9sKkFzpixz8kjthCdKtJ19Xu4/mqSzgU8g05fsD4ECIf
	psJO3ESqLcTviDXFw7MWN2EqD67rTluzJ6htU+n+CJ8jKhmyBRwYvEcEljXvKkw==
X-Received: by 2002:a17:907:9711:b0:a72:6ff6:b932 with SMTP id a640c23a62f3a-a780b8844a1mr1653845766b.51.1721051541849;
        Mon, 15 Jul 2024 06:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHwjV8KRnnz7iEjDpqsJ3D7PuPRD+rt8CqWAu8VqRYuDBEHehNYKk7YfxnNje69qgJqdGDIw==
X-Received: by 2002:a17:907:9711:b0:a72:6ff6:b932 with SMTP id a640c23a62f3a-a780b8844a1mr1653844866b.51.1721051541493;
        Mon, 15 Jul 2024 06:52:21 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:a4d3:4896:56d4:f050])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5b48dbsm212469066b.57.2024.07.15.06.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 06:52:20 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Danilo Krummrich <dakr@redhat.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH] drm/gpuvm: fix missing dependency to DRM_EXEC
Date: Mon, 15 Jul 2024 15:51:33 +0200
Message-ID: <20240715135158.133287-1-dakr@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In commit 50c1a36f594b ("drm/gpuvm: track/lock/validate external/evicted
objects") we started using drm_exec, but did not select DRM_EXEC in the
Kconfig for DRM_GPUVM, fix this.

Cc: Christian König <christian.koenig@amd.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Fixes: 50c1a36f594b ("drm/gpuvm: track/lock/validate external/evicted objects")
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index d0aa277fc3bf..d08d79bbb0f6 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -254,6 +254,7 @@ config DRM_EXEC
 config DRM_GPUVM
 	tristate
 	depends on DRM
+	select DRM_EXEC
 	help
 	  GPU-VM representation providing helpers to manage a GPUs virtual
 	  address space

base-commit: 833cd3e9ad8360785b6c23c82dd3856df00732d9
-- 
2.45.2


