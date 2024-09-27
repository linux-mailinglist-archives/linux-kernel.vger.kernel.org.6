Return-Path: <linux-kernel+bounces-341886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 983A39887C5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86C71C21133
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AB41C0DEE;
	Fri, 27 Sep 2024 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3oYqpsW"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F156B1C0DE5
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449157; cv=none; b=DE3waeuB8R8eYAe1IjfhsKAyLEoB6H1XKM3JqFcdtN/OCkDG8K1h5lLBYip9kLQDHYghXt0gCRHdFrqKNI9qVpp8hP3pSgu6jiO7v7UjUvbbN8tmb0P/X3EjIAJkTToN7cnPrQG16YIKmB/aoVmblM5ChJQY99d2x/qO/Q/7FTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449157; c=relaxed/simple;
	bh=gkoei6OgN54yVCf+cyyAM/zfmvw774bSPn9IHPWu3Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T00/JbR6ai6Zuwn+cwSonb+d6n1c91sP7UrZkrENs8QeXh0iOzMR0Opig2bSeprswGDi7zkiFr9/80vigUhtRj7QDSJrVWTjMt0+YOx3t+i/ueSYHvGX5IDMlWawAsAnKQWE4bwWGiteiYhUK7RiEm2W+vaxBBjaj+U0ldjfeqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3oYqpsW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37cc5fb1e45so1526071f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727449154; x=1728053954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rvr+aAeqYc0TS+uRT5fh8X+vEgn01CkzNarTSi6yaX0=;
        b=I3oYqpsW+090vvxIH8aUfP2CWC/OZ+4dbrYqlrkNsY3HVY+BHgCvbaJklWrlAGsFRn
         Muzbn+W3dHnTqh7k/tArZ0sJSQgvPIsf0+CvT4rdhBtkBlPgQ+u0QCXRXZviQsqaFmUG
         noRgbspMpN+iyTIhGRhjbfpZOM3DumvsCRMVB7J42NS9YnF0wMmMwVpxzhH8JsRic9Na
         +4JLQIBKxWcdEwZr0T6NYxavCX1mw5ccMy0KHftxZVpQiyVkarDqaXCDgdQMNcTBxsnb
         5fzED3lEYVGooXY9lDIBEK4xJ43z+axN18F1tnJCInXeLHfdkEmsn4E0zXYwss6k2ZQU
         RNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727449154; x=1728053954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rvr+aAeqYc0TS+uRT5fh8X+vEgn01CkzNarTSi6yaX0=;
        b=G4x4CFuBPSAzEE2Jz0mhyj2HGdDYpkwRV63E9TiWV6ljFCRVf9Hvslq2BwYbkarV1C
         USC85387P7dmgTEJx4KcRLXpmL6A5SFgL5EKEVOiY+XId6zF9rK1XpIM2CR+grIFr7+t
         XQzBuCvQ2ix9JpCM+v8udJUpGGLX/0hMjJNbHxbMOKBXzRmROeZ2YUEhcpl9Ux8xbI+v
         OpyjJYxS/4lE7KS10Eq/Oya1Eu+yVZjud2xJAEC1Munjwu4EaLmrmAqqDsh8WXQU33Qt
         jB0Gmc6vLwAd91eBUXnlE0L+Z7dF82woeqRpnd5Pt/H+lWedxz3DrdUayDkbKIKJEGvF
         h//g==
X-Forwarded-Encrypted: i=1; AJvYcCXGRDnNbfabxYsjDFtY93qvqrxBl8WGAsQPhD1mKY66ZbpVgv5ugfT6JSB4QI5UmN6zWdoJjXUno5g8fh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWRthBOkO+MyAANuxqFmrHce0UFyJX6bpThQdtLkaj1lDZtRIW
	7UNugPJl/Fw4jxs3lHjjBW1XnLELmUtrmkRaGZq1PO7fH3oFPMR9
X-Google-Smtp-Source: AGHT+IG9q2laExEP0nsChGhvAMrYqjDALDI9tG5cQ+2Watn0OQHwMhGGs32p7wB6IkqKrPQQjaahxw==
X-Received: by 2002:adf:e589:0:b0:371:8e0d:b0fc with SMTP id ffacd0b85a97d-37cd5aec227mr2291360f8f.35.1727449153857;
        Fri, 27 Sep 2024 07:59:13 -0700 (PDT)
Received: from WTFRLVSE288987LL.home ([2a01:cb15:8444:4a00:ec33:69ba:5260:d1ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd57424cesm2668397f8f.91.2024.09.27.07.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 07:59:13 -0700 (PDT)
From: pascal.eberhard@gmail.com
To: Richard Weinberger <richard@nod.at>
Cc: miquel.raynal@bootlin.com,
	Pascal Eberhard <pascal.eberhard@se.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] ubifs: xattr: remove unused anonymous enum
Date: Fri, 27 Sep 2024 16:57:56 +0200
Message-ID: <20240927145757.347630-1-pascal.eberhard@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pascal Eberhard <pascal.eberhard@se.com>

commit 2b88fc21cae9 ("ubifs: Switch to generic xattr handlers") removes
usage of this anonymous enum. Delete the enum as well.

Signed-off-by: Pascal Eberhard <pascal.eberhard@se.com>
---
 fs/ubifs/xattr.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index 3db8486e3725..32927bf98306 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -48,19 +48,6 @@
 #include <linux/slab.h>
 #include <linux/xattr.h>
 
-/*
- * Extended attribute type constants.
- *
- * USER_XATTR: user extended attribute ("user.*")
- * TRUSTED_XATTR: trusted extended attribute ("trusted.*)
- * SECURITY_XATTR: security extended attribute ("security.*")
- */
-enum {
-	USER_XATTR,
-	TRUSTED_XATTR,
-	SECURITY_XATTR,
-};
-
 static const struct inode_operations empty_iops;
 static const struct file_operations empty_fops;
 
-- 
2.43.0


