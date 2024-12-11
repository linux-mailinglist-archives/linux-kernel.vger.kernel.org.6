Return-Path: <linux-kernel+bounces-441254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FBF9ECBDD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7347D18887E8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550A22210D7;
	Wed, 11 Dec 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMa4dxS8"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237B486331
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733919632; cv=none; b=n6W4IDl8FOK7i3twQFAHw+9OhEfsfW9N+S5QB9fIESazDsoAhJ+NCxqepelc+o+OlX+xa1D4WY4qFXsKXTYk52PBHM3iuCUFVVqxkgA3Jo30OKQC/7lqiJdd+YLwS0yZM8XU2YTeByzENIr9m0U7FooS8Ll3IXNKKhQxB8Fh+xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733919632; c=relaxed/simple;
	bh=KdVTUtg9lgsUNrUHV4B/X+qsK8DLNWUqt6KB6R/J/x4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KKjRLXUjjBiKp2qRrYMRsMpxQhqLgl8cr8H5dq+Cjdv3KR8+ww5DXDjmnGkonUfweQayGPJnBsy8d+eOmDxaGsTKsiw5QCAufUBRon/Qfy4KSZZBzvgIl6MTCZyQwiVBCwpH06JQzNQ/pM7BnYxOZEKarAcwR3+/L3A8noiRUiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMa4dxS8; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa6a618981eso323820366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 04:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733919629; x=1734524429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dZg1Qv/4mtP2MMB22o2pEVgK6OLFDKWOSAkJVQZ+VCc=;
        b=mMa4dxS8Ld0Nc8YEmMJ5HbdUEIvzuyPCBcto57ZZ0sp86x7CEEHWZjEam9q6OYZR63
         m3P2pJDXnYpYBTsPYwS7A2Ear1EyvtOsqCGjFqiiY1gaNtr3QvzFaSmonm1HHCyM+3x6
         0NaejwAYVb3syzegCPOu9VhgkHWpw9KjB9370GJraPSUInW5W65Z9BFQjLbEBKSSyMEI
         7o3UJuIsSO6mWGl1rebT2985lQYHCNY+Zps6WecsMJip1mlpfGPCP+5/c/Ge0ottSfwd
         toyXlfsuEM9IUGXzl4hSnkmedJblaEvWXiQY4NVsH49b7Qk2OBgalllHsGttKm/gjhd6
         PF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733919629; x=1734524429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZg1Qv/4mtP2MMB22o2pEVgK6OLFDKWOSAkJVQZ+VCc=;
        b=PayqW3lRZQ4hJZMdNzGr9x2IiJ0S74r1dhMhvDOjmQ8W+9DjMyMnpV/9KdiY1XHLKw
         EftCFY7oPv71QhQbOipydN6uJ2hS2uPe6p1Hr72PNorGdokKpjtM7Ku8oMPNhFlV/h01
         HKz3ztyiD7HADeaRfcLyUb1MZD6w+lm3XAoJchYknKnbsMxCu0BraokYy15nEVIo20C+
         6o15hJemFGiFGrJaI1ANyW7DF6+yqfKPuNpZz+cWPbPnsJ8q4LjOHJwl0m2815EAc3MG
         jsXgesiW7JwyhA0jbODhVdYmpr3/1zCPrH6bTLNrQdXvb4c+vBKoLFXpCI9hm7Q+5Hba
         10Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVFQFcWawwfx7lYQFnG0z8nk4kf+uHw5CVi4cC70BjQE7xhX7Qc8FNolEebdgMMfzLnsjXdAKlpxrBietM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRbxE17m6SVPM61aIqI31Srj/BHMVRyVTW8nuFMLQWyMZDJCwH
	GfQGWDblvc9sookZXxtBJbTMIq+pKXYqDL/I5BpMPBGttqxsUH28
X-Gm-Gg: ASbGnctHnvSk+B+B0Jfsh8+MfAUHXgM1PuZS+EznCN7brsEzVmCH5BSkDP8uJNCEsHT
	YmDB4agd1urcTpLCPnhGN6Rw9vVp90bFANuCUGjgdUsRySLV+097lg0beKXua/AbgsDtJRPuxkB
	qfvaRZC7+jbXGQI/WGNG/tKqQdqN3VEhQgkPfK6SZywsLPcpRzZ/5DG59BeVoW0nLYx3f62nGs9
	LRXOLGvpI82P0eKQzWmwv7+1oYj+UreLfcHPDQs4mJvh6ky8aCY+n1bhPkjUwaXNw==
X-Google-Smtp-Source: AGHT+IEcp829lZqDsm7lXw0MRlclUKlA4nHlWQBjQ5jFpBUMws73Uc9UVaybAO+Oqfzvd+n0cqJv2g==
X-Received: by 2002:a17:907:944c:b0:aa6:6ece:8eb1 with SMTP id a640c23a62f3a-aa6b13f7d49mr232417966b.54.1733919629132;
        Wed, 11 Dec 2024 04:20:29 -0800 (PST)
Received: from C-KP-LP15v.consult.red ([83.168.79.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa658614e26sm672713366b.100.2024.12.11.04.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 04:20:28 -0800 (PST)
From: Karol Przybylski <karprzy7@gmail.com>
To: karprzy7@gmail.com,
	laurent.pinchart@ideasonboard.com,
	tomi.valkeinen@ideasonboard.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	michal.simek@amd.com
Cc: dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: zynqmp_dp: Fix integer overflow in zynqmp_dp_rate_get()
Date: Wed, 11 Dec 2024 13:20:26 +0100
Message-Id: <20241211122026.797511-1-karprzy7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a potential integer overflow in the zynqmp_dp_rate_get() function.

The issue comes up when the expression drm_dp_bw_code_to_link_rate(dp->test.bw_code) * 10000 is evaluated using 32-bit arithmetic.

Now the constant is casted to compatible u64 type.

Resolves CID 1636340 and CID 1635811

Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
---
 drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 25c5dc61e..55e92344b 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -2190,7 +2190,7 @@ static int zynqmp_dp_rate_get(void *data, u64 *val)
 	struct zynqmp_dp *dp = data;
 
 	mutex_lock(&dp->lock);
-	*val = drm_dp_bw_code_to_link_rate(dp->test.bw_code) * 10000;
+	*val = drm_dp_bw_code_to_link_rate(dp->test.bw_code) * (u64)10000;
 	mutex_unlock(&dp->lock);
 	return 0;
 }
-- 
2.34.1


