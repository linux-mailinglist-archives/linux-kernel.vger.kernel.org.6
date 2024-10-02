Return-Path: <linux-kernel+bounces-347318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164B798D0FB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDAD02826FC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733CC1E5034;
	Wed,  2 Oct 2024 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnwaB8+8"
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0F81E2031;
	Wed,  2 Oct 2024 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727864045; cv=none; b=cE54JbMNwXCLfbIHRs+GHHvIRtVShcajnpUi9eyUW1ZRMSyogp3xmReVTlnmPUtAsNfwwHdAq5c+Qzmo/DavhForwfP1EPEdjwTeL9RtDqBZ3wMvnxrAnGVGJ2hp+cCBexjFCYtzwmw55hiNj5CRhCqdizOTQb27wts5POjzYfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727864045; c=relaxed/simple;
	bh=bjX5BW4PZGgqqyzaNaKxBrOYboswD+cgERp2gI8XsCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7TSIxhkjKR9lPUut00A0HDMaEgDSs5WzIspI9ka0iDQUEWgYlwEAyU0S7GO5I/AK37dxpfNXaOXSVTc/ZsO+RVTQdEcrQ0IZ16e/m9AUxf4mmrBwiiZu+b2xRqWD23DGXBJ4VJ3o++rfBf/jbpcv2NFNnWueecqMW3RB6+zbyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnwaB8+8; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso4410846a12.3;
        Wed, 02 Oct 2024 03:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727864044; x=1728468844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ITkNe+vNpHw1xzRexboVGuwiuVidOEjpkGuzCecQoQ=;
        b=hnwaB8+8Gxbol9JSb9Ow6OXMz1Ry92XVPENOrXAqT8tZ0PZI0/ewZT5d1M9OcH7Y9X
         E7TNGbMtfdkDSiyG1S3KcIscI5jevjtLDty+PC43IMKCO0+bRbZyV483FdxbYdDiSf43
         P7Km3UyQVNF7voWkO7BdZ+cY+Hry/iDRttmt+U+nfmqVPAYtRpqvCcYeQcoEItzaJqCr
         AIzyABp6My3vje4wdjHybJrWHLFoCUl57rRMePAlkvXwu+TpCiko2NL7jxpqTIOwpw4Q
         TE8LXYNhY8NOmH61i7bNc9jiG6Niv9EOxsU+w0HStCLT2S3zvA5v6ZRmZmPntF1l6/ij
         o3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727864044; x=1728468844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ITkNe+vNpHw1xzRexboVGuwiuVidOEjpkGuzCecQoQ=;
        b=WaH4hOlTCeDZ7USix2Gdn8plSf1WCa+zy0K8B7oLrlnnHzo/mRlnqkLWRBxxnHIMPL
         PMCc/3oC8wwTP72tAQJKGeVrVw2XlQzuXWu6mLFtzSmG0HAlxSjn/ZPCAexK6wRKHsej
         u0xGLdHn4X8SNlKgqMV9s6lEhbLFGJviBZMjf/pVEsxnPYI+rj6eU+tJSODz+EqrKk+6
         rFACgm+JMJZNQBQM23oZvRXLcWO96yKFE3rpIds95Lvf/iXJzbExotVnvpt68ci65z8q
         9y/h7pv3YRb6OXkP46dkv3TAkPY0Oe2Lfdw/OAJxzDpd82h/L46hzcQnou7QbmJYCy+M
         Ymhg==
X-Forwarded-Encrypted: i=1; AJvYcCUYPClW7zD6C0PthiSJ0Z0zt0hxI8kJzE4BRbjLiRUvyc80g6RzGMCl+4C/kbgx1BAHnJjn96GxRhFBOCK0@vger.kernel.org, AJvYcCUwQmlNhlaS8yMJsiqzcoLzXs4mi0v3ooQ8l13ZWT2Ns+Z6E4sFpR7ao+UsFFIK4JDW29IzsCe2KX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw42TMVdnuQwbc0fH1hL9w9hFNa+k/GPiLAu80BPRol/Lk83Z3Z
	aBnlRQ0gRCN+z3Sp5RODhHm9sh64M4nIhjUdGNa1n0ek+diwFSxu
X-Google-Smtp-Source: AGHT+IHsEpxiZKr1A+amXk6qtyBogBEtwHQBxLPLnv6JkIZs9mofhd/Q4z4wixB8pY4oRE0ZobmECQ==
X-Received: by 2002:a05:6a21:3417:b0:1cf:4596:d486 with SMTP id adf61e73a8af0-1d5e2d42f0emr3893725637.47.1727864043756;
        Wed, 02 Oct 2024 03:14:03 -0700 (PDT)
Received: from Archie.mec.ac.in ([210.212.232.142])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9c4e5ad46sm352374a12.36.2024.10.02.03.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 03:14:03 -0700 (PDT)
From: KK Surendran <kksurendran95@gmail.com>
To: maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	corbet@lwn.net,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	KK Surendran <kksurendran95@gmail.com>
Subject: [PATCH] docs: Fix typo
Date: Wed,  2 Oct 2024 15:43:44 +0530
Message-ID: <20241002101344.137636-1-kksurendran95@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo in Documentation/gpu/rfc/i915_scheduler.rst -
"paralllel" to "parallel"

Signed-off-by: KK Surendran <kksurendran95@gmail.com>
---
 Documentation/gpu/rfc/i915_scheduler.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/rfc/i915_scheduler.rst b/Documentation/gpu/rfc/i915_scheduler.rst
index c237ebc02..2974525f0 100644
--- a/Documentation/gpu/rfc/i915_scheduler.rst
+++ b/Documentation/gpu/rfc/i915_scheduler.rst
@@ -26,7 +26,7 @@ i915 with the DRM scheduler is:
 	  which configures a slot with N contexts
 	* After I915_CONTEXT_ENGINES_EXT_PARALLEL a user can submit N batches to
 	  a slot in a single execbuf IOCTL and the batches run on the GPU in
-	  paralllel
+	  parallel
 	* Initially only for GuC submission but execlists can be supported if
 	  needed
 * Convert the i915 to use the DRM scheduler
-- 
2.46.2


