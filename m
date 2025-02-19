Return-Path: <linux-kernel+bounces-520849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E42A3B00E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 04:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6E887A5CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BD81A317F;
	Wed, 19 Feb 2025 03:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RLn71sKu"
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A20A136A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739936094; cv=none; b=MFIKYUFanQIgDNuFzQT4ZiFZwo3kV8qqvk19qodTVrmfyiHINi0ayjjetzCPvgb1Sxz/6k4u+h+rq2KbdvmW9ipLqtqrt4UNn9r7Be2qPK+tcfD/eNqvmhacthArbebe6Vj6o3cC2riyMfPXhbKl9P/DyoGauja421f20AXgoFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739936094; c=relaxed/simple;
	bh=nps8bhqqW9C31UMiIA1K5irHfRijgaCUHJE1SPI3/+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RuXlyDXxCDipbfjsStJo/43pXEbayyxHViO9T1EK10GsOhpdh3VrU//S0P8i3u4rFHbji2OZtKErozHznNV9//+vr+LNWWm+rHThafXtt8S0hVPs8+5GdXzIFoV+p4wlJoUg+BNwnHzkaBVQiq1EkAkjfZwQPm8LTQVvS+EfNww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RLn71sKu; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2217875d103so78585ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 19:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739936090; x=1740540890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oWmLSi2mB7M9yGiVBZcQbkxr3CzoST/Pj74hRTCGb30=;
        b=RLn71sKu3iTdBbM0nEP92OSgoR2tQ7Fa1alGlaAB9sS3Mw+agmv39e8w6mLL3HTvxP
         EojBv5C2t6yTofKhXJZipxiCmOqo1CYaPIdm8vw2WaZzYzIUjTfjbz71o4EpjM1cgFKy
         rdMoJktL5qWvDrnY25tUCKDQXweGjvPgGLFa96Z1rqw6pkBQjQ8J4TEYHdB+ylKu03Wh
         reNEEDyACUNgOaOYEcjr1NKMMIe9xy/n1gyEalj/pxCDVinge/y3M/4NlqFhCQvcQxAS
         jlwCbSZRhFXZtaWt7fuczXtOAYyV81z+SsoLe0rZgbfe/hBmFvfdvUdq7W+dgM1tuRnT
         sYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739936090; x=1740540890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWmLSi2mB7M9yGiVBZcQbkxr3CzoST/Pj74hRTCGb30=;
        b=A3qOxEHoLFtcsTWWFe8EOR7UaWczawRyb1L5xCvZikQv0X8jA6765QKe1O+mVTqlhs
         6OGKMiJXC3mzH6Rr8mmDK7AVdZaUGNnz1fsPrrISUCvBl68OXnsVXZqkX9WJRdpBnGD9
         txW5KTEcQBdx5yRAw0ou4GY79TdNp81wF/a+e70HPeylaIikFxEHlmVP506sFg6RE1jP
         STZSpwS+bST9Y5yOO66lGhE5zaLWAu7I+ml6WJ1TTJ5S9kAqfLcmGMGZOZsPoMew2A6r
         fBS+I1Shp2l+k0ReUNGphovg7i/SL6u2yXhMgf3tlXWtGcOSxkGjFD91zz5HOdGYLB4P
         O+xA==
X-Forwarded-Encrypted: i=1; AJvYcCUNpagXe+w+MD9xgCeagACUh5rXFRBBoKXrs/hzRhvZV8qZPF/WDBtKYwQ99e6xln/OMoeXDocAH5+vs1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTV6SBQdcg0P4Kx2sxpS5xVpu7aXuMoyv13a8FVBsF2N5fIphE
	IYMSNdiIc6vVYbKybxv5kTcu8Xr9ptQ+vu13FFjUjtfw/nfWa+99Wp/wrQePenacY9yXPhCxcv8
	2+9mH5a9LIn9Wraqzgvgsf6f6/W0sIiBAwaKsIWe2OAk7587R
X-Gm-Gg: ASbGnctleTJIQ80fMUgLpGSE3YNx1oc2IV/k3/oiTmozWX+xTQOp9aS5Gjkp5SFbDBx
	EUAVJyxspwHsJ2IFel8WQcL5h6GgEvj8bbR4kWSmRBu7U1/BwD9ahwr88QZ9DDo8czLgYgBoyxp
	t5Kj4+2jxcSt3o/05Dh3u9b3GMkRyAGGh2rP1s1jE7RUmcpTueZ4umAsSEp+F28IjCBNt54W1As
	lR0+zk22EEvGnnCLUmmf9vIDBpxRRaahn7fuCaPTCFz+4TNwgHIV1D0RaHhqddaCpSCLzfmwIHE
	ZNbbYawvXjROKyaUXvCxp5c=
X-Google-Smtp-Source: AGHT+IGSnWI6/oo0pSCxMy/XF1XplpCCogXqJteEhB5BWQPqOLmP54GMkGp0qkgHp8tJhMhpxzRxr1dnG5jd
X-Received: by 2002:a05:6a21:6da6:b0:1ee:d621:3c3f with SMTP id adf61e73a8af0-1eed6213ceamr1083705637.0.1739936090265;
        Tue, 18 Feb 2025 19:34:50 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7325b336950sm708046b3a.7.2025.02.18.19.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 19:34:50 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A6765340643;
	Tue, 18 Feb 2025 20:34:49 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 9FD0EE410B7; Tue, 18 Feb 2025 20:34:49 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring/rsrc: remove unused constants
Date: Tue, 18 Feb 2025 20:34:43 -0700
Message-ID: <20250219033444.2020136-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IO_NODE_ALLOC_CACHE_MAX has been unused since commit fbbb8e991d86
("io_uring/rsrc: get rid of io_rsrc_node allocation cache") removed the
rsrc_node_cache.

IO_RSRC_TAG_TABLE_SHIFT and IO_RSRC_TAG_TABLE_MASK have been unused
since commit 7029acd8a950 ("io_uring/rsrc: get rid of per-ring
io_rsrc_node list") removed the separate tag table for registered nodes.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/rsrc.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index a6d883c62b22..0297daf02ac7 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -2,16 +2,10 @@
 #ifndef IOU_RSRC_H
 #define IOU_RSRC_H
 
 #include <linux/lockdep.h>
 
-#define IO_NODE_ALLOC_CACHE_MAX 32
-
-#define IO_RSRC_TAG_TABLE_SHIFT	(PAGE_SHIFT - 3)
-#define IO_RSRC_TAG_TABLE_MAX	(1U << IO_RSRC_TAG_TABLE_SHIFT)
-#define IO_RSRC_TAG_TABLE_MASK	(IO_RSRC_TAG_TABLE_MAX - 1)
-
 enum {
 	IORING_RSRC_FILE		= 0,
 	IORING_RSRC_BUFFER		= 1,
 };
 
-- 
2.45.2


