Return-Path: <linux-kernel+bounces-517343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0040A37F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A844B3AA01D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC0C21884B;
	Mon, 17 Feb 2025 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J22Q+xZQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F532217679
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786817; cv=none; b=A09LdtRMwL4XrYQloSd4Ir8aa7t4KGvwmDWRZk524KJRKXiyJC2NTuHEffSQwu/6K4wiwOtBMdXsTlYIL2xgRygd9obO790bD7LqccxNmji5/pq4WCEJq2KFa1eCH6H4yKepenwpBOYV6wo6cwGBu3SZrphkNtYSShTsCs0XrJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786817; c=relaxed/simple;
	bh=Biw6DUxzk939fJknAJPcsYdiS9No9FiyXZeyYUMpkmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z8EKYoVTHkebZcQ9OPEbEoI35OjdTeSkJIenf+6afGPQz6ccPodGjKwtzsZFf/SejDFFWhXrGP57fRv/UYnadz/bnjt6CGFPQQHiZMMnH6+IbudS8XZUoQdzI6crwd98/9bjMVL8M9lKdplknPyjkhiX09wte8RnhOXhe04sz3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J22Q+xZQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739786813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7uYWhEd1/c+mNMCq30U6Kc7sDjWCoVhIrgohc+6hGoc=;
	b=J22Q+xZQ3vOyF6bsHnE58G3RsyEsQ9eHT22rkXJoXGR9jNdQJetfsfRobVMQPsQQLNMO6H
	E2HuUi1ykCGDR/pbKU0Xv+P7tYSvwF1ICnRtPEeZRfG+sNW+k/Lp5xkjqQSZCAQ9nO9nau
	nMsVuSGgFL8O0aiFiLEePEKZhXWp4qQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-p5jhmzO0NS2W1Zp9RXPLxA-1; Mon, 17 Feb 2025 05:06:52 -0500
X-MC-Unique: p5jhmzO0NS2W1Zp9RXPLxA-1
X-Mimecast-MFC-AGG-ID: p5jhmzO0NS2W1Zp9RXPLxA_1739786811
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f338525e1so864068f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:06:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786811; x=1740391611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7uYWhEd1/c+mNMCq30U6Kc7sDjWCoVhIrgohc+6hGoc=;
        b=NwD2yZhCgayRg2PGvQULpeGXpIGKo+EkxxB58SzaHBKMzVLai4G0MJ8efB08HMfRIN
         THWq9KGwhiDXYAY5tSOqwaS9O98f1uM029w3mokw9XJ4vpaP4ypoLiHa+CixtN/MwoRd
         lqbbLjr2FKrH5cgOXjD1xbwas/+IuswrlUo0LYyvSCXWG+RzokxB4DSjmKyDG2Skzbmt
         XYbTDw2UGNozJgYJeBv2MSh+umUfjCk6/XF5wAFDs+Zk7GjFgKEo0KFYh/RyV+1s/zYU
         XvSuYPYYIjkVVHM1z50hr9yNt7eQoMXtzV6CTmS48HAaFGl9v+sSCl5t8dO/eXWd4skC
         XIjw==
X-Forwarded-Encrypted: i=1; AJvYcCVbbWLAH1X4lKycAvxHPrnEn8JVpnoXfKTqgkvGLijqC8kQmJo9qJozyPyRlFtv/dl7AA0voSIgV5KW8nU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwERwphkM8dAsfQVmvH0CfIWjaMQpkemKHNRfUW/55447wgnyaU
	DxuSWbkJilEFqA7YjqT2lBIXePtQVPHYY3DUtCyq0SEKRIpzxQ89i+voF1JXAekJwES05adSkLb
	FknTtMIJD56ZUXRG0juFOsgW8S9VaRhL/+wlsbXnGX7s9agw0Z75bXY6MVA05zvgHGmwxIbn7
X-Gm-Gg: ASbGncvPq+b45i+T/tXUP0Sck3l/S0d2cB0e1KjsRgHD4yikc+Kzdn8D2lEtH8tukoc
	QYNqt3lR+mvAMQdiNpPuV7eQJm1E96JWSO7Zvk48R+k0rNs6PZv6vkd9lqRx8Z+8mxRRCfmJLBV
	QWsiZZRYDlwpy/h3Qs4MckNXEo8yyl8+BSOLhh2Soo1zTTtluJJEeOmiFFj0gV9pyeBhODbiDiZ
	s/o8fwGKI17Awf5ZXLEUzy8Fx7JO3VbEYsVQIw9xVFFzM70jSVl36or5OZ3BSFfOtaP72QfCee+
	gDlhTnjNCOwhpwzMml/F63+3N6b+DRR+KZNGY/o/RhkpqmytgRcq
X-Received: by 2002:a05:6000:4025:b0:38f:4176:7c25 with SMTP id ffacd0b85a97d-38f41768063mr2940023f8f.2.1739786810971;
        Mon, 17 Feb 2025 02:06:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF17aX5wN9RpvCFSTEz6ASI7aS8LQfB/Yvz3pfn6bQCqV1ymw293EC3qwrkdzNkvfNshhjdBA==
X-Received: by 2002:a05:6000:4025:b0:38f:4176:7c25 with SMTP id ffacd0b85a97d-38f41768063mr2939994f8f.2.1739786810613;
        Mon, 17 Feb 2025 02:06:50 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dcc50sm12020780f8f.34.2025.02.17.02.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:06:49 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust entries in FORTIFY_SOURCE and KERNEL HARDENING
Date: Mon, 17 Feb 2025 11:06:43 +0100
Message-ID: <20250217100643.20182-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit db6fe4d61ece ("lib: Move KUnit tests into tests/ subdirectory") adds
a file entry to the non-existing file scripts/test_fortify.sh. Probably,
this entry intends to refer to ./lib/test_fortify/test_fortify.sh, though.
As that file is already covered by the entry lib/test_fortify/*, there is
no need for a separate file entry. So, drop the unnecessary file entry to
the test_fortify script.

Further, this commit misses to adjust the entry referring to
lib/usercopy_kunit.c, which is moved to lib/tests. So, also adjust that
file entry.

Fixes: db6fe4d61ece ("lib: Move KUnit tests into tests/ subdirectory")

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 53cf3cbf33c9..15632a34b740 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9070,7 +9070,6 @@ F:	include/linux/fortify-string.h
 F:	lib/test_fortify/*
 F:	lib/tests/fortify_kunit.c
 F:	lib/tests/memcpy_kunit.c
-F:	scripts/test_fortify.sh
 K:	\bunsafe_memcpy\b
 K:	\b__NO_FORTIFY\b
 
@@ -12613,7 +12612,7 @@ F:	arch/*/configs/hardening.config
 F:	include/linux/overflow.h
 F:	include/linux/randomize_kstack.h
 F:	kernel/configs/hardening.config
-F:	lib/usercopy_kunit.c
+F:	lib/tests/usercopy_kunit.c
 F:	mm/usercopy.c
 F:	security/Kconfig.hardening
 K:	\b(add|choose)_random_kstack_offset\b
-- 
2.48.1


