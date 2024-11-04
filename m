Return-Path: <linux-kernel+bounces-394209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9589BABE8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 05:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23CFD1C20AC4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991A018A92E;
	Mon,  4 Nov 2024 04:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaAfuPFS"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0E5290F;
	Mon,  4 Nov 2024 04:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730696355; cv=none; b=XYuMO9oWvU8p/p8gP8+qn0JQSxfpFhosaJxlVXwWWtdat+BAYvLiJ3J6AuE8WtxcfNB5hLByOh/Fbl7/RNWxW2SlTfYQUZmugLPBko3/PmmJOvJlwLHp/2ciVHCEuJ0dw9LBhObOKgz8eYYVtBvQLkr7iiGIt3GJYMCtcMbnsEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730696355; c=relaxed/simple;
	bh=Jt4RcuHkOj5IeNvPZBqpHJRxypJtJBa9YJbPuHFS7Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bXT+YKizlts1nHjhnV1sb8X2vscxWR9+PEjzr+OG0dvRHJu8oLZCzb0Uv5xld2yWQQI2zNY1Bz9QsrEd+fDGYSpLjKnVfVCXIriNXjN1PysPi/7ll/kuWbDO3aMnTJyA+JCOwezDzEGzvrIE0TtApxjgR3/H75SSV6bYHquTxEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaAfuPFS; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-288a90e4394so1651512fac.0;
        Sun, 03 Nov 2024 20:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730696352; x=1731301152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DAe1wmm4BkgGKm7wP48Ig8w9IoXg1CatWh+ffievHIE=;
        b=kaAfuPFShzQdiabKCwJv0tIEnyQHXaTc+nsPhR1/s7/tg+Vgsm2bU3r/FjUWZy07In
         j0QTfiRfz+TCl5Ok5ABWuvZV3o1mCBJQIq4TsD8/BFdziKnnoS/bMwQSBdsYO1jItgxr
         VsFr+hkDdQaHd6QHqdLQlLhrnpdd/PmVPjufQLmAj46unXqPtrDIzcrPOTzbDIvdxTZP
         jeJdi1n4BcWA/Zc9F8AEynbGLcwzbpMFTdw8svyIpbO3KJWDD/kJaLMaI67QCjYX+WWq
         oT6NKCysbTv2HNeR9KdWtSeGZ9USNvNjLYHAmwlpdE1K7fbzwvjQjy6NhjRYsRItyukp
         xMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730696352; x=1731301152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAe1wmm4BkgGKm7wP48Ig8w9IoXg1CatWh+ffievHIE=;
        b=iQ/D3pse3tdD0Y3Jva9GDHUF9xYqj7x98VSYrrXpIuDEMFFnLKsx3DybkxssPHjFCl
         t1CAC98OaBt9Wf6YVqtADgcX++EcW5cbRS5enR6LL//g3WD/YgSOF9r154ySSUixFKCg
         vLk61DZ0SH3yEqFM5243un13tFbNUfqegC43MaUqYjJd88aoLbUgi/IxBN1JarXwdC9H
         dMQHJFOrGX2n+tmBREiBbHYbJWuwZPAbCoY2wCfKcbIF/KoT8CykOYhBGq5E/sK+yJkT
         wN+hQw8N2ZuXuU/7UDi1D2itP+x2UnFvUsplWspa5zNd4BhDkREF9bv0An1YXKIZ5zD+
         d1Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVXpu4OWZiV52lIQh9tyTapwI8gUf9u+/TacKB6TN4gj8iDkVLCnLMCMmXGNYGSY6+HgRvpE7in5Fw=@vger.kernel.org, AJvYcCVwS2xUAawXIf3N3QCfQQ2bVZbVRtb7zKf5Fr9sYcdlp9dqpI9XGGH0DwAr4eXdzLBcrf2LkTAGSKaJik4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE8f4i1hIgz4BY7sjL/avDy/S6L0nMv5FePngdh8sf+ljsNkDF
	OPZNfROunHiJB+xdyq4Ae0LJn120CY7iWMGR3TJBO80t7LQ1C1PY72M3D+wG7iM=
X-Google-Smtp-Source: AGHT+IHm5OFis4N7IDgOVt2Y/qM9YbNq3zg8pPv8AEQHKHkQuMFKLcdlocqXa0gnydejahaQ/trD4Q==
X-Received: by 2002:a05:6870:31c4:b0:278:1863:f4b6 with SMTP id 586e51a60fabf-2946470bedemr16282036fac.15.1730696352506;
        Sun, 03 Nov 2024 20:59:12 -0800 (PST)
Received: from anishs-Air.attlocal.net ([2600:1700:3bdc:8c10:b556:ea07:1094:f018])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2948771706dsm2783077fac.45.2024.11.03.20.59.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 03 Nov 2024 20:59:11 -0800 (PST)
From: anish kumar <yesanishhere@gmail.com>
To: srinivas.kandagatla@linaro.org,
	corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	anish kumar <yesanishhere@gmail.com>
Subject: [PATCH] MAINTAINERS: add slimbus documentation
Date: Sun,  3 Nov 2024 20:59:07 -0800
Message-Id: <20241104045907.76298-1-yesanishhere@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the commit 202318d37613d264e30d71cc32ef442492d6d279
slimbus documentation was added but it missed
the update in this file. Currently get_maintainer script
is missing the main maintainer.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ad507f49324..5e1d00d7043e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20951,6 +20951,7 @@ M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/slimbus/
+F:	Documentation/driver-api/slimbus.rst
 F:	drivers/slimbus/
 F:	include/linux/slimbus.h
 
-- 
2.39.3 (Apple Git-146)


