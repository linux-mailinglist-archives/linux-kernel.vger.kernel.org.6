Return-Path: <linux-kernel+bounces-332771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C315A97BE90
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84009283975
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21538188A13;
	Wed, 18 Sep 2024 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="hddctL80"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99731C8FD2
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726672990; cv=none; b=eylZDWD6m821RBX47XytV5YjsJxeh+TPWcTUw9QphMUBH0s5LIKfsT4OtYfPBRyvS3oHQCXDVydLMSgCLwg37Aq5PsSqI5aHhsZShCOHD0M6R9NlWoAWwuZQdmNT1iQIxG6bT3KXrCwnjQpWLKjAq9+eHtBxKyr2QWUer8bkqls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726672990; c=relaxed/simple;
	bh=M2A49kfdqyAWZvRJrIP5wKhFHwSlLuqKRlxMXsj6zv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcOUu+qY9mqLRyU4bRGVHRRsHyTzWGkWCGF5XT4OuZR08eZYKquE91rMYOOzSJE3mmDH4PTIYk43bK6R5Obvxk8hdZMuA5bpqf2zs0aDclC4TYe7adyQDRSAm2i2oPss/pKsIX2MwmbsXYrWxFV7VSv6mFCXPfRCigwKyQytFFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=hddctL80; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a843bef98so753077566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1726672987; x=1727277787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GKGe/hWzpQA7CxmPNU6MTXkgQYFW9SlpLsnQTn498s=;
        b=hddctL80jV9O+aCO+lTJPRfR2Wjm9G717TtSU6wIyG4zJD/Rnn8KaC6w+Ocr/ZbEwd
         q68v8rbsDj43sFx0zsGdzcSyF9PKIjP65n1RWMiryaSvydzLSQ/SbHX+pfb/r6BzUU/S
         wP5mZjQGpZrV0dDULezu9QfmdaL3p8cpbgVt/JQ7rtkTYCuLF825YO8MoKTYHNGj5IYJ
         SVpy6X3lm0nLx22Yg+j19O4qjyP6uhsBiFP/bo/Cn3NzK82ywDTwBcURcDhQ0PLoLg1m
         WRz1vguu1ntNG/kd6gi8Ra5UXefwCSZzEtWgt4rR+pDND3M8Lhg/j0GuwfzuadcRJO6p
         85XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726672987; x=1727277787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GKGe/hWzpQA7CxmPNU6MTXkgQYFW9SlpLsnQTn498s=;
        b=apKP0DKUfRzS+vK34vgvjff4Gc7raouc92KdnKsM3HeryzEz3upHe4jNErwkXkviSK
         FUVv8jBQoGz4Ir68RJ4o6UwlZSUd3ePVygP2TrLrNSHP6pvN6suMpPprhZYvZgJICZZ+
         gFbvrDUiOnVuafpqRcuemcQGfBGE1FnTUzggo6CvbEq+7IyzQrXjZ71LgkYqZI19VYh/
         /6MG03OC9r5oIcezB+Chh9mED39uCpg86hDk47/1qMO5ic4NIIlm5TMG8ElYB8JHtpVx
         nhNHsSdNPkW83tkYvUxdh4EDeOaE5TSK73W45vKgFMy/1sUwpMXtLs2aJRXDyFmQGXCJ
         wEFA==
X-Forwarded-Encrypted: i=1; AJvYcCW+1vRZLRNJ2J/j5lJAPe3i6rCfxJNGDqrHli0baFqQS8slmn9ABZPiPwpyUFn3dINQ5HLGQpy82YL4W8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+hF8sRVxqkM3JIe9fTQoKDgozduRTrFQSL92aKPwpZ2DUCoCX
	AL7FRmezl9h/l4Tx/UdLBItLLLDH8MjykS5gPJvRoVqRjRtNoSr1j73I/7Ym9+g=
X-Google-Smtp-Source: AGHT+IF27oxPM4gwWIjWaGLhEuTY+DzoBkiUWe7zvlHUcynBEODFEkD9+WkQ+qhTyttimMbGk2RgrQ==
X-Received: by 2002:a17:907:e9f:b0:a86:8953:e1fe with SMTP id a640c23a62f3a-a904810755dmr2029019966b.47.1726672986922;
        Wed, 18 Sep 2024 08:23:06 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 08:23:06 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 34/35] bloblist: Fix use of uninitialized variable
Date: Wed, 18 Sep 2024 17:20:38 +0200
Message-ID: <20240918152136.3395170-35-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize addr to zero which allows to build on the CI
which is more strict.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 common/bloblist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 2008ab4d25..cf1a3b8b62 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -499,7 +499,7 @@ int bloblist_init(void)
 {
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
 	int ret = -ENOENT;
-	ulong addr, size;
+	ulong addr = 0, size;
 	/*
 	 * If U-Boot is not in the first phase, an existing bloblist must be
 	 * at a fixed address.
-- 
2.46.0


