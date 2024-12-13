Return-Path: <linux-kernel+bounces-445330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF989F14B3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544CE282C10
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214BB1E377E;
	Fri, 13 Dec 2024 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WMcjDWjC"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E3B824A3
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734113356; cv=none; b=BjY+nlYclqoEcNycikseXXYvQhd6cg9wZSwg8ZVTl4TgbKGsGeG6Y15I+1hnzlvW+0Os3zWxZlN3kwFXYQEy3a5IIRFmkcXBoGmplFrja/R1iP4sC5jTyClXYi/pl6yGnZVmHFBHtrB6lYV2fi10TXRSVpr4+9UXzdM+QdUYYdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734113356; c=relaxed/simple;
	bh=2FkUQMX1Wz7gCMohsC4is4/F6UOzBSxDPYQwoMWH53A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OkaNcnQQ2CH63Pqz8230NdTEUQFbjIk8C9QerhrT7zN8sHFHmygWDvNblgf3NBeO8Odc0Q3zJ+Y8JhKfNJ++2F7/9ZyWKygM87UwaGLwBFegWKfTjOPQdKiBfnkMHL3TU1F3Qip+AOwAJVp4yfz4flhCXvN+b04aK/VwkhqlEFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WMcjDWjC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2163b0c09afso19841655ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734113354; x=1734718154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xHvnRBAgWIA4Hg5hzc9AixQBc9yGg8x7tmWobIWOu2Y=;
        b=WMcjDWjCn3c9amKhFuko+wJEhS9p8mBaBcqfjbwIjyXHalGRrygjW8C150TGI1/W2R
         psFz+/9bzl8acM/XM+EK5c+pS91SxBJ4zs/8LlA96UhNfnTtl9jMfOEA/X0j94pPwXvQ
         /bjsfZhMmrxL+SBzKcFZHXNavbvvNTN9P2P9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734113354; x=1734718154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHvnRBAgWIA4Hg5hzc9AixQBc9yGg8x7tmWobIWOu2Y=;
        b=NczLX4bvK9qfVcoC/O2E62K++igDDirTXtmT0I9qkAChl0kc8exiHU69pA6Pw+c41B
         /By2ufXrsgV/yRUr7ZbSxeqPCWjjVR2obwu4L7P+u38tIBGJv/prV+kNO2vrpE7gEX/f
         6vooHn6bOf8EA7xYBC6qfhWW8lwxmy4jGov0F/fAUzcpR2sea0BymYtALgux9GZPyKhy
         pG7iY7lJgdHO/yRsfiE5XbpwqzLD2QJbxScFOv1DMdcqQTESY71sYWAWcIOUFiy26HbL
         ouOUEIotDTqeWndiSRtSodjQDkSuJ/ds+2zXXhF2csIQf4CSngDiu2ZjtREoUpa7mvov
         eF2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrVxBFnRie5QvowFsKmywq/mYge9kNgCS4bHnSAaIilU1HkQ7X/1dNpPGHqecE3u7y/X+vi+QlNUAOjPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCy8FcIk4lfak/Yqzb34zb55wNbiXO5sVg9AT45XcLaS1avQry
	ySM8dk/NdJRyboFxP7PwDwcnQLGgXCr6iEAkiXhT40rVmGaKkJpUQ6mgR2q+VQ==
X-Gm-Gg: ASbGncuIlE7aqWKWGJ7Lmmw3885OxMygt0b8XF2Hmg6f2Tb4jayNvxNxyZy99aDLNF9
	4Bnud1kyiWAaXKzY6x/jcRmW5Nk1kd02Ln89kuZ9kkUA/z9tEszmPmAnEzZ1YZqExGYomYa+9Ti
	4UZw27Rvfj6uPcvjXRYBAl46epFzbvC5XRaVrUsGIPg6pLXlfWugF0XzcorEyvSXDw/qcABMCj3
	768xHGGEZXFY0IIiLKZTr0jdCAvEF7YkSB+o4T8iZrcvX8k5QuNOY39iHbhtBnfhXsdXh02Ge28
	z2iy8k2soKUomTEJ7w==
X-Google-Smtp-Source: AGHT+IG1HsmkzaKGdsmHNaYqVpdfLznabnEnuLB97sA8uGNrKH90vnL20KSruZDKaLUaHNEBxjTn9A==
X-Received: by 2002:a17:90b:3d4e:b0:2ef:67c2:4030 with SMTP id 98e67ed59e1d1-2f28ffa7efamr5275060a91.27.1734113354488;
        Fri, 13 Dec 2024 10:09:14 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:356a:489a:83c:f7d9])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-218a1db8676sm646005ad.12.2024.12.13.10.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 10:09:14 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Rae Moar <rmoar@google.com>,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] kunit: platform: Resolve 'struct completion' warning
Date: Fri, 13 Dec 2024 10:08:23 -0800
Message-ID: <20241213180841.3023843-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If the <kunit/platform_device.h> header is included in a test without
certain other headers, it produces compiler warnings like:

In file included from [...]
../include/kunit/platform_device.h:15:57: warning: ‘struct completion’
declared inside parameter list will not be visible outside of this
definition or declaration
   15 |                                                  struct completion *x);
      |                                                         ^~~~~~~~~~

Add a 'struct completion' forward declaration to resolve this.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
I'm not bothering with a Fixes tag, since this only shows up with new
tests I'm writing.

 include/kunit/platform_device.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/kunit/platform_device.h b/include/kunit/platform_device.h
index 0fc0999d2420..f8236a8536f7 100644
--- a/include/kunit/platform_device.h
+++ b/include/kunit/platform_device.h
@@ -2,6 +2,7 @@
 #ifndef _KUNIT_PLATFORM_DRIVER_H
 #define _KUNIT_PLATFORM_DRIVER_H
 
+struct completion;
 struct kunit;
 struct platform_device;
 struct platform_driver;
-- 
2.47.1.613.gc27f4b7a9f-goog


