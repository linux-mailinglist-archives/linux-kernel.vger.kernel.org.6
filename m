Return-Path: <linux-kernel+bounces-331035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8213097A77C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 20:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C093B2BC13
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FE815B57D;
	Mon, 16 Sep 2024 18:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VF8d7hGn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6CD10A18
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726512843; cv=none; b=lEg2Rj9jinvfX0F6RaoP7CKEGztOhOH3GfneNIkaPQ6GksVW4qQqfMrnPY/7BqWvZ7CUlLmFtNBcZKt2v0mUUG/HWsWaBQDdeG1VL+Ni7fyXWxuyy/lotgf7Ltpz/b4Ea3Y3RXuGB8n+ctmf3wRa8qlLYrKd04xjq0sQWBmS8cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726512843; c=relaxed/simple;
	bh=jDEwedYry5vDfiJ3o3bz2P2SDM5zwGd+yjrRY8syZ0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cp2Bvqf0/AXeGGeuJ1HT/7OUZL0se/fk2Op4bMw8NJ2hYwAo9v7kdyLO3lsUFMdNtkrUfN5Qn/pM0WgqeJFWNUKY0/V2DIoAOvPKKFiUwfQafJfUxiUKK7cSjfC6WNelhz4dZ1xMM4lYjVnOWk4iR3y4bEgl5ta5+XU+f+Juqz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VF8d7hGn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726512840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DYdRLpzqdM5bU62s7LpHvB1TMxzRZjAddlyxLFaKST8=;
	b=VF8d7hGnx+CR6yfIFLIASUMegPM4u0G+vKySTteD06mSL9VUKVHhou5yX0uhHbQJm0KMr6
	n7BihoXiToZPof9HOb8KL0VEoYQNvqKspp7ZG/q7QXp/XCxxW0MmN1luo6DCITliCEyMT+
	DTkvqaf0qB9x+EgW2A+nrOI2U0d4reA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-pBLrM8YwMIyoI3bMT-JzqQ-1; Mon, 16 Sep 2024 14:53:59 -0400
X-MC-Unique: pBLrM8YwMIyoI3bMT-JzqQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3730b54347cso1673724f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 11:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726512838; x=1727117638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYdRLpzqdM5bU62s7LpHvB1TMxzRZjAddlyxLFaKST8=;
        b=UXri4WBKDtkk+dbq8I/cWj5+QrO0w9shufFpZLlaWh+VW8qPlPLEZngzklFI3dkQT2
         +QAtGDL/xykwqUThy2g3cUwqn6r6niBcQ2xz6h3IP+DwdP8gt3tsF2/NoIG3H0kiaPmu
         0M7Cef8hZKZlJOXtTnp5xCzN8iToVColK4fzRweGcoIHYKUkcfCOcWDdYKJz0FmqNf4L
         7GSIf+TRNiMe91z+YRrnnBvlYZvng5BUDOVuRGL1lENCyBm2AjgBLD551qiqbKeP9tjX
         VEeG2n4PbigZSnlNuPchHF3FwLmwzpddGGArvghHbBV9LGebNT27FAOzfIbO9W4gRJas
         Qjvw==
X-Gm-Message-State: AOJu0Yy4dwSVPJs3B8dF8CreFmpyi5KEiVaLFw6atYgVjQxMQ9IaS3Sp
	msilskRjUj+uBhVdCawwLzAQMN01901IPZ0f7XZyFuRtVvoMZbvnoGvLoC2lkKmo4upqt83Ug10
	Glx2D1Opv9yMw6fqO+OUyqow8o9jn14LOC6ny+NJ0OMtNHqjVTVOXu4a4sRirwJPczVrOLXgeG0
	LtxaXF2GnCocOnpEzJt5Y0pApvvvoqw7rZEuIx2I0SLWVmlA==
X-Received: by 2002:adf:e7d1:0:b0:375:c4c7:c7ac with SMTP id ffacd0b85a97d-378c2d6165amr8395048f8f.49.1726512837997;
        Mon, 16 Sep 2024 11:53:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6Mf8ZQb0gRzRUbhnp6yMXQHaZVE9FLP+6u6Z95QWtbSt5GCvcc315G0IA/oD5oam7X041aA==
X-Received: by 2002:adf:e7d1:0:b0:375:c4c7:c7ac with SMTP id ffacd0b85a97d-378c2d6165amr8395030f8f.49.1726512837448;
        Mon, 16 Sep 2024 11:53:57 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d97:9600:c4de:e8e2:392:1c61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b05c984sm118962265e9.11.2024.09.16.11.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 11:53:57 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Philipp Stanner <pstanner@redhat.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH] MAINTAINERS: drm/sched: Add new maintainers
Date: Mon, 16 Sep 2024 20:52:00 +0200
Message-ID: <20240916185159.35727-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DRM's GPU scheduler is arguably in need of more intensive maintenance.
Danilo and Philipp volunteer to help with the maintainership.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Luben Tuikov <ltuikov89@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 10430778c998..fc2d8bf3ee74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7710,6 +7710,8 @@ F:	drivers/gpu/drm/xlnx/
 DRM GPU SCHEDULER
 M:	Luben Tuikov <ltuikov89@gmail.com>
 M:	Matthew Brost <matthew.brost@intel.com>
+M:	Danilo Krummrich <dakr@kernel.org>
+M:	Philipp Stanner <pstanner@redhat.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
-- 
2.46.0


