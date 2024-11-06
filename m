Return-Path: <linux-kernel+bounces-397771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7200C9BE01A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9B81C2279A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9631F1D6191;
	Wed,  6 Nov 2024 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6gzjtXi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658391D434E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730880834; cv=none; b=rLxU01qm8KxXjINq5f1SU1gaqk22a7VxmFHUjbPLZvh3JAxyIogyV3yGr6BXi/R865Qq0KWyzYFWvyaGC2Kw0cZcy0/I/157LJ0zMBI1Tcuor1PzxF4rwmp7NjjwWFncl/luSYaS5ZjENlAKUQDzlzdbY+jA+axAMFvy32cOq/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730880834; c=relaxed/simple;
	bh=IiVxXzi6cf1LmPboJPt94NJr13UCP0qfsLiOmx2zt5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZmcW4NPhMiplzqH7pXlvKy1tEpVcY4arN1TFCfLxHtWexPKuJ4kWHiOZWGQLneavfk7KQ7zX4mPkbRGxjCqfSXeK28kjH+F0CsvMdXSDJtXE+7kiIM3It6lRuPMrgycJUUmQP8DCo08rkY9QKHg8S/FqHAhGQdRwtPe69q3dYPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q6gzjtXi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730880831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u2secMimeI4+f4dvxa0WxHbdFtZeWJOJ8zwpB2N9L3U=;
	b=Q6gzjtXi9OYw1Fu/gCA3w1uow4IslOmy8aoSVPokDFSlVf+xmoo98AVKvy9799auOWD0ar
	UjpKJ4R0YdUw8qTb/CinC6JJn34MVoUDY3CYHvJDp/8/kvXgwYG6MjJwxbgzGUJ8R5csRL
	pfm5KhNL7X3oNKBtPLQSfWmo1dsx4Hg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-5YMQu-xEOUqVmRA0wwKGDA-1; Wed, 06 Nov 2024 03:13:49 -0500
X-MC-Unique: 5YMQu-xEOUqVmRA0wwKGDA-1
X-Mimecast-MFC-AGG-ID: 5YMQu-xEOUqVmRA0wwKGDA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4314c6ca114so46988105e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 00:13:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730880828; x=1731485628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2secMimeI4+f4dvxa0WxHbdFtZeWJOJ8zwpB2N9L3U=;
        b=iCYu3ff2cKl0B/7NN2kgI6IIfHSS3AkyDnTBWgDQENWG/UDW1MojxcbFfcTz9IgLcU
         iUl6rHtJyzxb918sk3zgeKhWWhCZyWJvsXh0H9nzru0n+P6YELQSAA+rKsUMaYAjqbp3
         +32eI9QH8SsA6XZ4AiCtNNxwbfFqDwBWlN2WCoQEJkeAAQtuoeo63KvIpZ4gOWzvA0B7
         LhnBDfNxK0athDwkgZ+Ze2+QvOalDejSa34Pd3Z+jsNhVcUT3YWQPxaJattsK4GGAh5v
         Yrs8jku4n4MgeZoWMOkQ7OeczI2B+m15M9FcCpfLDyTspRmrNgwGJHVehwpU+r28khb8
         qvBg==
X-Forwarded-Encrypted: i=1; AJvYcCWhrw3oYceu+PmomrZ7NMP0Bzcxd+AFkfhCQIQ3lA21VAejP2s9qnLBdZSw+HWRc4w6KVzduy5sfCNdTd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVbD/MapOx2+FMv+glYELkgCrOEpZ2CWnqHMdGbjr5Bi0iMvkl
	9+VCtn8+gg0rhtMONsm3Ixn6Ekiuc7ZGyRt05e+zBc133Otptl5Ihn0LxcS2rbNQBx/PXmYVhzi
	hLFIG+tnvhojVYYsKAqm2QtGhRjW6rLr5NrOF6txn4QjyT82BF/lcd9EeRZJbjA==
X-Received: by 2002:a05:600c:5115:b0:431:7c78:b885 with SMTP id 5b1f17b1804b1-4327b6f954emr187771665e9.4.1730880828394;
        Wed, 06 Nov 2024 00:13:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEDbzGtgbC+limkqrDb3bgxn8MtUgaok9LxE3/Aqw87YDkCd2Xwwy8yw7eixK0KNLGFNgNJg==
X-Received: by 2002:a05:600c:5115:b0:431:7c78:b885 with SMTP id 5b1f17b1804b1-4327b6f954emr187771455e9.4.1730880828017;
        Wed, 06 Nov 2024 00:13:48 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7c2bsm18387226f8f.23.2024.11.06.00.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 00:13:47 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] hwrng: amd - remove reference to removed PPC_MAPLE config
Date: Wed,  6 Nov 2024 09:13:43 +0100
Message-ID: <20241106081343.66479-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 62f8f307c80e ("powerpc/64: Remove maple platform") removes the
PPC_MAPLE config as a consequence of the platform’s removal.

The config definition of HW_RANDOM_AMD refers to this removed config option
in its dependencies.

Remove the reference to the removed config option.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 drivers/char/hw_random/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index bda283f290bc..446c2def055e 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -50,7 +50,7 @@ config HW_RANDOM_INTEL
 
 config HW_RANDOM_AMD
 	tristate "AMD HW Random Number Generator support"
-	depends on (X86 || PPC_MAPLE || COMPILE_TEST)
+	depends on (X86 || COMPILE_TEST)
 	depends on PCI && HAS_IOPORT_MAP
 	default HW_RANDOM
 	help
-- 
2.47.0


