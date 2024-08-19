Return-Path: <linux-kernel+bounces-291927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB28F956900
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8651C218EA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2D91662E7;
	Mon, 19 Aug 2024 11:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKU35gPj"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640C0165F13;
	Mon, 19 Aug 2024 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724065620; cv=none; b=kErrNDFXl0D9QBDcyJ59vRMrLLlttabWs3iffCGD6GcWMmwQ6XUTtVIKcDSaSBUSl2k7dVfIJ+UvPNEP4X6M7gfw7KvENo7OTt8n1VXn235SWrVmVA8r6P4qP/f72dI82LlAgj8uJs70SzxSLXth+vaF+2ZwCDeI8t6RCWYRiTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724065620; c=relaxed/simple;
	bh=bgG8964DNASPGDJ1znidTq+9U2E11Zdvbk5m62zgkCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CGYM8RSqDoXDLaQfjBVsj4N7cg8xCEVeJKiQVWVbCBcC6zl5SunzbDr7XWg/zGaRoKEIPp0u21oaFy3L/6cwNk0eiTjRLAkaMqeEmg8bD/2i4TSBQwON3NtNW7C68dZzeW2KAEk9bjgxHWT8SHiMftZVWg+RM9XapLK2QpFfueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKU35gPj; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a975fb47eso487872666b.3;
        Mon, 19 Aug 2024 04:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724065617; x=1724670417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hnA4siAu/RwuaMMkHIrs/loJGQl2iwKolYcJVU8YACY=;
        b=OKU35gPj4vjW3y4Ut/nSYG8Ok/X8bJ5HWrgqNEVm9lGiLcKbBJPrXzBl88qNf7KMIe
         wPADwOZMKfrwWUqXJSedE2CF0e0dCUnTpCyD92DliRIICOKjLL+vf4RP51zQSYS+qHwH
         mUJCri2kCsIDttO8IqoIGPkBkNx6AwOQVpia6SOM0tlSbLIV2GcGCXIGqnnUUh9/fStm
         VI/fXH2c93TluFgh16vknv4Ygg67qd1znOz8vtu9KNLxRLQUXOiSa72mq9W9Q84ypsEV
         UMIQNUNE2AYDcGHPt7ziyxr4iFczD1RVETfGk/km12CnJXCTvbrRozl1aRtM22qMByyp
         wjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724065617; x=1724670417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hnA4siAu/RwuaMMkHIrs/loJGQl2iwKolYcJVU8YACY=;
        b=dl9n1Ddp7Q+GDuuzqjURA6/rtsUGzJ2jJfTskjGVrluEnM0nwjkJ6JPB3V3PAiVHFk
         YgB4Z5Z7rnlDL+TzNif14mLFm6q8u/9qV1aRh0xhz41C7HVPT2qHDcTD8Q8JZeuR0yt3
         VTPSPhLwambhRNaImAz9ru2IEW5QyefGsTRTmIR2SclYE3XBggRWNIC1z4m85m+2BxX6
         SyeoUiju/qhwqHon4bH5XxdijcKryydOIBrs3b5JOtj/eCQIonZF1brDzCOm5XsT9Iyp
         0pARQts7Joaet5oxb96L7IoGhFL4iIM6hdQAAKmbfLW0gspuKDtZMbMqkF5Ta2FX0j35
         CMQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+tRO3QVI/OxmR1wi+scwcYIV9gRMAL8MNf6QizuzbXxmQhAL69fADOC6djJnqG4ci49HOCXP48Mdrx6nC5xvAq3X9LZhFyH8S7nig
X-Gm-Message-State: AOJu0YzX+BSJlmneDHFDQ/U0SkKsF/LAxQXlXz81ocSq2wMu/uWKpz+I
	f7pRxpP0XEwOLaIlCBMPqf5YGxtGxzIPwnYGoryCHpvNSXBlVKcp
X-Google-Smtp-Source: AGHT+IHW9J1uMlv2UVi2fjNIBjdGPPyPHoEAKDAKKdP54SEP6rNGcngHzAbGZkHAH4VkoLkfY+ed/A==
X-Received: by 2002:a17:907:e2ce:b0:a7a:a4be:2f99 with SMTP id a640c23a62f3a-a839292f4d3mr641211466b.22.1724065616265;
        Mon, 19 Aug 2024 04:06:56 -0700 (PDT)
Received: from gi4n-KLVL-WXX9.fritz.box ([2a03:6880:1087:a800:cffc:b429:56ab:efa5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838d00f0sm616959966b.87.2024.08.19.04.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 04:06:55 -0700 (PDT)
From: Gianfranco Trad <gianf.trad@gmail.com>
To: akinobu.mita@gmail.com,
	corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gianfranco Trad <gianf.trad@gmail.com>
Subject: [PATCH] Fix typo "allocateed" to allocated
Date: Mon, 19 Aug 2024 13:06:41 +0200
Message-ID: <20240819110641.1931-1-gianf.trad@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix minor typo in the fault-injection documentation,
where the word allocated was misspelled as "allocateed".

Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
---
 Documentation/fault-injection/fault-injection.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
index 70380a2a01b4..9170e22db215 100644
--- a/Documentation/fault-injection/fault-injection.rst
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -283,7 +283,7 @@ kernel may crash because it may not be able to handle the error.
 There are 4 types of errors defined in include/asm-generic/error-injection.h
 
 EI_ETYPE_NULL
-  This function will return `NULL` if it fails. e.g. return an allocateed
+  This function will return `NULL` if it fails. e.g. return an allocated
   object address.
 
 EI_ETYPE_ERRNO
-- 
2.43.0


