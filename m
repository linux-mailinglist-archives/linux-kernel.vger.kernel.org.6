Return-Path: <linux-kernel+bounces-246616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E17792C45C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C83A1C223AD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B64146D7D;
	Tue,  9 Jul 2024 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yq2Gq3BT"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A764A1B86DC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720556241; cv=none; b=JYqGKsaqV5p3/TJagdKyJHUPfE2MlFMmtea8bHkm1DLF788lLTOsOTmOHSiH4ulKaeHij1rQYppgjuX9GxmxdL18N+TTdjU8GCg8RctYbX/YAUR8/AjU+O/8zJxsbfVxaOsygRH7jH/GtAjsKdM8AQcNy1TTHMoAmKl/o84y70k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720556241; c=relaxed/simple;
	bh=XdTm0EPaEhKmbAuEtfLmVqPMsTMOrR8EVu/el1RU2Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UemdkjkeWWfC16sxYeC0FOIQSO1b+ZSGXkiuIlzUlwRMKBYJ1vxZEd8vc8jr4lsEiuFi4EYNnPE0/U7uixRLER83iw2fYFDAxTei8NqTfRzt3/brAPH6FlzOt7io8qARji8eY5ei6N3g96RLTjY+2IiNVnzNoHQpRmjDv2ot320=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yq2Gq3BT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4266fd39527so10954115e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 13:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720556238; x=1721161038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EXHxrC/luHFKOt8/7OLM5HjDIKDd5blPn0cUkiIy97M=;
        b=Yq2Gq3BTpODz5TtMihBJhBWWBiOkgaWTwrKUNuOzqKgSnemCf5u9mTvrnCVbd31ff7
         ptsjwVmDyUJ33qA1mIefgNSQATqUN39MwC+vYgP4/v87pTE9rj08Gek2lu7LDxRejP3M
         1l0Gv+Ra3hyYtpKBN0632PTQ3m4dwhWAEIKZg3fuNkOjiaxdBJpSnHIQeWNk1nDH7FCn
         QO1cV7CbIac0ymfJNJx3aoszDEBUo81UthhvLiBbZiq47e74OCnnYT2SN+TAort03Tdb
         +QV3t3nPMA+qEmYyH5v7oyT+ynxbGe4CNNFFpBj1+2OWRY8LY2mVfSCywINQ1SVknNdn
         v2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720556238; x=1721161038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EXHxrC/luHFKOt8/7OLM5HjDIKDd5blPn0cUkiIy97M=;
        b=rrYrlG7sDDvngTARQFHO+Ws/zUL67etglcaA+c65QCcu66gXZMVhZ3AoU/y6vdrVWg
         tYttM7ht6hugpgMJrH2zsi7TXEs4PU0uC5vhMDLZphIbjR4xCNbskRKx8x2vsce9NRuJ
         GgIYTGZIrKxBVUw6Ru0HE+aAK10coHorlhHjPj8lNT9+m5Ib2Toa1gTgvIhqiFwC6Vaa
         TTAS+XNbc1TaryrUUkm90pR6bV+cylrQ3UjlQiqKbUrrwKg7/zn97xYXh1qcDHEPAPIw
         ZZG2eV/JPGpAYemsVvQhAfAGuVhLPVDJyrXSVEntD7RYrKu1h5OW/UIPwepYHOPSsNDH
         xx+A==
X-Gm-Message-State: AOJu0YwITdGfpbIcfRAVsGL4nHGxtV1EwQZqkDqTczK3qw8YArQs8SsA
	WrYVnP9pXdakA5dNBpFjxOMDS/0tuYqLkpz7KlKlwkhshSbZ9aLs
X-Google-Smtp-Source: AGHT+IHOb1az36jkAJmIB78p3YoPZuizKhT18QzcHxzqAQfDXBCqRFxIMk/L1NU6CA+UPO2yENzLUg==
X-Received: by 2002:a05:600c:6a17:b0:425:5eec:d261 with SMTP id 5b1f17b1804b1-426708f1999mr26644295e9.34.1720556237509;
        Tue, 09 Jul 2024 13:17:17 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f737b1bsm54058325e9.32.2024.07.09.13.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 13:17:17 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
To: David Airlie <airlied@gmail.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] MAINTAINERS: add myself to DRM/STi maintainers
Date: Tue,  9 Jul 2024 22:14:28 +0200
Message-ID: <20240709201428.132612-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In lights of recent events and my will to participate in the Linux
kernel development I see this opportunity to add myself, and help Alain
as maintainer for the DRM/STi drivers.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 71b739b40921..0e583aae590a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7477,6 +7477,7 @@ F:	drivers/gpu/drm/rockchip/
 
 DRM DRIVERS FOR STI
 M:	Alain Volmat <alain.volmat@foss.st.com>
+M:	Raphael Gallais-Pou <rgallaispou@gmail.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
-- 
2.45.2


