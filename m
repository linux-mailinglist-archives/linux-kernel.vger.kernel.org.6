Return-Path: <linux-kernel+bounces-415206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D73C9D32E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 05:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208F128420F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 04:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1658314F9F9;
	Wed, 20 Nov 2024 04:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LevWA8xf"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196181876;
	Wed, 20 Nov 2024 04:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732077296; cv=none; b=V/p+reep/N0GkbhXEenrfhoinUzE5YhTJctaKLP3Q+JgiTvI2JeJmprLPc7Isu1oLD0XFmi960kADn6I/Qker+N4FooXAfVVXCzAEpVSw3E485s2eKduuPyyuG9ckCQsthTS8pONcl2TBzSyiyx/ZhZ6OFAQhEA98pJfBjlAa8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732077296; c=relaxed/simple;
	bh=9wCqL94QV2W0zgMyjrtj3hoZ3K1kai7uFZGPeiZJUhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T6IBAV8ehSE3Vay6ITKos/ISFPaKoUPD2RZ8oh3EHrzTGay/RjroFuDm28tvTJr1jpR2Wc0bosMqPcDGCUuW6BlpwyRrzapPO+N7lLr6TQqowDSpWSNrki/TG6VbxFyMelQFu59zpzgfOTjcfMLHfXgDU0Ib9oMe8w0Z5HMqxm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LevWA8xf; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a789d422bcso559035ab.1;
        Tue, 19 Nov 2024 20:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732077294; x=1732682094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+jBJ1TYKbV4zN+jYWbN7guI3voUYIaz3agm8n04fwCE=;
        b=LevWA8xfBOrFTzEaa2Yrkdt0Qf2rlmsdLttcofAqQmQWxk21FtyLfxMVfbefjmUjiH
         QjT0dZiQYM7ovMfVZRgtnx71ti8grJDPojQ1VlLj4Qj1ZzzOov8qEWWBgGjmWXuFYgPV
         RMfOBdpElVeiU5O8ozi2OffufZHu7Or9N4AZLDVh1bBr2STNWFHdWeWvN55HPhLDRSHH
         0Y+5lle7cedoVYz1IXK3Oa1X3kXoDZBwXeJTdfHKIPQRnnFe37cWtwYhyaThGpQKuL0H
         c4veTlo9L+bR9FG2fyNU9zSsrzCXgqc8f/a4plcY9J9iRwCeXOlLh5cT98pscTmi6DSJ
         pjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732077294; x=1732682094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jBJ1TYKbV4zN+jYWbN7guI3voUYIaz3agm8n04fwCE=;
        b=S+O56njIa8ppcP+uSdUoSVd8deFgS8mQGxX3LGBqAaTy0jSvMwNEDt/rSe83O1IwiJ
         VxjqkfCdb17g+mSLiUsB/W6jchvdwzb2FioYk+cUWkh/7ObOliq1L2U3Vvv5vP7Uqrug
         1Emp0swUjVTzjFO9hYiE1CX2K7OzSls8F+OtNFHFF0rzPe89pSuZ9zHt8fSDYmOpLaym
         jBwGCP8aL7uW1NU02cl7FM0oo884VlX/w3AeV3JzFjia9Qku95bp+rhmDtK5hMH19i5l
         bAGgS5yJ20gUDZuymZJUE3jrLYOuQq6BZUDjNdq88B/YrEngUrAGpMG5hkrMUX1e+BUp
         v2SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdtOD6B1SN4YRdbSIunzlEs3seNFnc18Wly0d1dj6VuKwaJ/91UtrK8r/FDBRk2OHHZqmnBwrqrwdk0J6M@vger.kernel.org, AJvYcCXjca8Fa+gDMF4nZEkq74Jv/qCe2aHLqWibSBsv2bg3Apo1PmKCFxKzHfyluEF7LWMD40VXNC6MJrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoQpEsOLq0MVmKFl4GlRLMvI+vd/OGHmQL/Gb+MoIG7l+At+W0
	b53zUBpEa4we4/QiuEclwlcECYCgBxQue4Bu15NkOgaSVWSWfvXre6VqTg==
X-Google-Smtp-Source: AGHT+IHn6wEKXryAmMdOQtowc9nRrXQ2sQDm8qS4PUVPfvJ11yc7lE8TSDVWjLDAAVAGWH1WjU/KEQ==
X-Received: by 2002:a05:6e02:20e6:b0:3a7:4e3e:d03a with SMTP id e9e14a558f8ab-3a7865a8914mr12588235ab.22.1732077294102;
        Tue, 19 Nov 2024 20:34:54 -0800 (PST)
Received: from localhost.localdomain ([175.112.156.113])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1dac1e3sm8499383a12.57.2024.11.19.20.34.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Nov 2024 20:34:53 -0800 (PST)
From: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
X-Google-Original-From: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: remove duplicate word
Date: Wed, 20 Nov 2024 13:34:13 +0900
Message-ID: <20241120043414.78811-1-RuffaloLavoisier@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Remove duplicate word, 'to'.
---
 Documentation/admin-guide/sysctl/fs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index 30c61474dec5..43b128c0225b 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -41,7 +41,7 @@ pre-allocation or re-sizing of any kernel data structures.
 dentry-negative
 ----------------------------
 
-Policy for negative dentries. Set to 1 to to always delete the dentry when a
+Policy for negative dentries. Set to 1 to always delete the dentry when a
 file is removed, and 0 to disable it. By default, this behavior is disabled.
 
 dentry-state
-- 
2.46.1


