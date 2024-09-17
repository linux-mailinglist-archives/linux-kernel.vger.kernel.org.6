Return-Path: <linux-kernel+bounces-331683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7F797AFF8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 14:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB9B2868A3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B377616C696;
	Tue, 17 Sep 2024 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlFImtM4"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943719443;
	Tue, 17 Sep 2024 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726574941; cv=none; b=eIVkNq+JQWIxA/Ft+mfpJXU3O2aWPu8fBVNJ862XOmqWfmHUtcwJwyWUl+adB0kaguFMrAoXcyNwhucUVLe1kaRpY4es3Kkm4I/Dkg4ZVCdm5aMdMe/pvCZQvZC1Sv2iG4hyqBOjGCrt9gfAi9K+9rKhXhZsUPHRr7sqYc0CC4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726574941; c=relaxed/simple;
	bh=m9P0g+OHRlEXXA1SYsQBasXPpwOp2IbtjhMPJlYpWkE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qoQ6PFQxhv+4nVnIFBrZW4KMivjnbvNtEcDPjkAez0ngACOr8aZbMQl7F6Spw/yt/4yYJhnUs3XEX3KKqL/Y3ZzOMRBT1AxOdDvCxAB+woso65CHTCS2w/EpYOnchTMT+yh7WhZfk5JluvDpeh/7Gczm1hDgQcsbFDIqkGjXXcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlFImtM4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so24392435e9.3;
        Tue, 17 Sep 2024 05:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726574938; x=1727179738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pH+jWoS8flWyNkqg8Mnuurwbq9hALr+uwaafQVN/R5I=;
        b=nlFImtM4ttlGQgx/ZaGKv25A0z2A9pAih5XlsQWcVtuONrXq7UQ7ZGLGVQwzHQnArR
         4EP5xjuIzaEVjFHwteMVWcChEcOxcEgzhzDP2ghdX5+N/jsPQ/42Q7AeQPFmXrV62KS+
         RTz17sJ6Gw3aVxuEUDUXZf0ZjyhSQ1ChKABHP6sysDMOlzdNwaCihfLYg60CfbCiL+8W
         nl/g7KWW5HkWIzM5drfWgAfbSTB7r0EPQjbK8uUselb+VoUt1X+wujABIDP6ZgyAHwBA
         Kn2kRbmJox6a1vwH2iPakQJWs+iQ5QPsCtUKHjlEULwEAABflFI3fSfghHBkC7HPYZMv
         XJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726574938; x=1727179738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pH+jWoS8flWyNkqg8Mnuurwbq9hALr+uwaafQVN/R5I=;
        b=In1wN/DVAgEzs4DeLUX9DZ5i2VPPuHW4QPfrEz34+N2Wr9OSNRJgEK887ELr+LB75D
         vozpJ/mERv3q/ONeBG4/zh2VqDkKZeUXdY+GA/tfyNAC+EKwbZduEQpN8NcND2FAzjos
         Yf3psoiKM0+IhtISatNhsf+DIz5z23aT+nkGL/Se/JC2b7jLm51nyr4a9b4yVmwO4Q9l
         +C+vqX8Rywl+I9WZq2TsZ+iDlct0fAbSdn6mkye+1Da33s7mq4NIAMZw2A/0hHgeBaqb
         goavEr5b+Jlz2Ado+NWxwvojHlyRVxxysiaQJbfeNfjGL5vyIXtwuxA3Vy3LKQ/6gue9
         3jpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+be2IuMMlrMIIpxDWQpzIRPJnsOgDqb1IwXr5ZSmHvnIUNnr6ISCzHiTaaH5LpzvsAv6dKOh1Oth4xwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/5YPuZHyLlD6OcFhEd+ZAwrW/Y8HIK06+3/O6fir0BR9HVn7N
	236GrWmJEDgSOLRubNodM0YtQJmiK/eKCSDQAMAGzJ0U3O4HVhxC
X-Google-Smtp-Source: AGHT+IFoV/GynBdMrloJuKhB9PFQ2VToiezwKU/krQ84DC9QRRrz4ERZNzhlMoDWpSd71SLM4d6iOQ==
X-Received: by 2002:a05:600c:1d24:b0:42c:bf79:78f7 with SMTP id 5b1f17b1804b1-42cdb591224mr138614105e9.32.1726574937547;
        Tue, 17 Sep 2024 05:08:57 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22b8b65sm102132515e9.8.2024.09.17.05.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 05:08:56 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Ben Skeggs <bskeggs@redhat.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/nouveau/gsp: remove extraneous ; after mutex
Date: Tue, 17 Sep 2024 13:08:56 +0100
Message-Id: <20240917120856.1877733-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The mutex field has two following semicolons, replace this with just
one semicolon.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
index 9e6f39912368..a2055f2a014a 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
@@ -210,7 +210,7 @@ struct nvkm_gsp {
 	} *rm;
 
 	struct {
-		struct mutex mutex;;
+		struct mutex mutex;
 		struct idr idr;
 	} client_id;
 
-- 
2.39.2


