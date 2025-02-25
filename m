Return-Path: <linux-kernel+bounces-532158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C1FA449A8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55393B6673
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB15620F097;
	Tue, 25 Feb 2025 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aC4Gvb4u"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC5B1A0B0E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506399; cv=none; b=XTpsNfLCGDhxLXUQVPb7Ay5LYV8BtJYLSQiqRWnHJGLi1S/JaiwqKTsQ32BTtJT1SpluwuDGqJ7NJqHrSnZe4ENbcXoVhrH1mPfJePugjmgncND6PILNtU1Xaw4QdfjdBK2S3H5hB9QEsMktMP3SxLYLPjFyn84FTFIB7XhvHkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506399; c=relaxed/simple;
	bh=Vi+uu/h5Zd8rK2aatFelcFPD2hYQTWMEmZWHarVSvJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kohlSTd4T7+n00ZOW3PkSB0sQ9VUPV321lSeYwpByfzQSPr+ebSDdkxSRE+pQkQry3a8twNR3ucnSEDEq+5ab3TchNDnvh1pq2HdXeXtFFCdMKWb7QDm0xGE5R2Ornri73ZKkkALDFVEU5koJBQ+xPiDxZnQB5/PKHyBarXxjAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aC4Gvb4u; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f24fc466aso4380622f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740506395; x=1741111195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2I+AKiUaGilJvwS/f5X1LlsvDutZk3cs9KHKo4vYS0=;
        b=aC4Gvb4u8nH8jm2nMgXFGRwKhKjBOwvGiBzQEZdYGYqCnVb3YlMExELOZ4VqzP3mBi
         CYGG1PPP4NcS3CbcvG9+yXIBxJgW0u2E9vIZAEWlnFdgCGqkf7To85XvArffFZwIsc8g
         p9nI0YvjhtHv9c0YmytOWVaLGhqJ8vBfvsgSx14c/CbdomsCRZ+nSMdeFspmz1LFCA47
         B7p5FbOwmB51w31lH60+3d+yI938x2joC1q+tVOUQnCMmO3zW7plpTPkkR3hAHLGfIMj
         7mV21bfev/iwP/CksENS/ukhys33fCBXC/XHvFVEGPp0zHncZ0War58qQKkTx90pTOdX
         L5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506395; x=1741111195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2I+AKiUaGilJvwS/f5X1LlsvDutZk3cs9KHKo4vYS0=;
        b=YuSuEq2nHzyImfnn7ZSt2/sK1gJtCZEAsFp3KBwe1uz5LQV+MUO7nqD0KgUaUiRwqR
         akcAhaROkd4iul/o+IFmZd75Bw2QqB21TxC9I5CYSwB0QhBTCONMClUxVHBz5HdQw+2p
         vfCWwenfeyH1NwlLAem8XISJ3K5j5Epz7qjYy8btrEhZGbvMiVRUTw8vKHxODwnX3KJs
         ZLNLTJBVBssPw3QJ2namQYBLk8g9nU4adC4xY5b9gqQNDfD8j0Wr5AfHp87FhXNn5qkZ
         sBO2XVss9ehlBbm0BKj3MEdcsRjp06GvyPBsZncl/mV9cr6qdk0lS9hAwrIR+5Jp1Ut1
         Iddg==
X-Forwarded-Encrypted: i=1; AJvYcCWJOZW83AC+Tlwbvn8R5HcZ0LvzWLqtBkuf4gRdCm5O6P9p1n0MM1UDbaY39/PsooPEEO5JcswuXxVLRDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwskNDG5ECx4FmPG6qALglGBwdfsX6T2Xyp0g+Na6Mxy/Bd2N2o
	a290SvzZb5Uu1WLjv8M9aONMnuECvbxsa/R6F/0RGLGVE5kWLwAM
X-Gm-Gg: ASbGnct/Q1L0Dqy3CBydyMyIWUOijP0l3XR3L38cOnI020sBRgRsWvo0U1xtuVlAZqE
	dFn7CTZOf5fr0LGEBGEPZ/pP5dVzeyW5LPwFtHVDOrnA573rqmYHp+LjqYlgxgiWWgvHogKa6zz
	5yjuxX2Sb8TpFX79VZi62DJRynqphLIrtRh/Plv6QlAgUusO26Asg/1lRapmChtW07wPraJR6uv
	QEHKkvNnyH8HnUy+3Nd2ZTN6UFhhn6NHNpTlePVz/2DT6tJZnWYRpBFu/ZZiFb6mCBJzPshZHnG
	jUFC+w6orGzf//ecuJMXDbW/xsFj
X-Google-Smtp-Source: AGHT+IFXeUWeTF6dXkp/wlfC8bPpRknIuSG+G1DBxyLoGn/dLvboeFM7RCjs+ZLYjnsXSSYydGev3g==
X-Received: by 2002:a5d:6dae:0:b0:38f:2481:a6a3 with SMTP id ffacd0b85a97d-38f7079a3a9mr16896866f8f.18.1740506395455;
        Tue, 25 Feb 2025 09:59:55 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02f3e15sm149063655e9.22.2025.02.25.09.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:59:55 -0800 (PST)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 13/16] drm/vkms: Remove completed task from the TODO list
Date: Tue, 25 Feb 2025 18:59:33 +0100
Message-ID: <20250225175936.7223-14-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225175936.7223-1-jose.exposito89@gmail.com>
References: <20250225175936.7223-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove the configfs related TODO items from the "Runtime Configuration"
section.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 74126d2e32e4..c551241fe873 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -222,21 +222,14 @@ Runtime Configuration
 ---------------------
 
 We want to be able to reconfigure vkms instance without having to reload the
-module. Use/Test-cases:
+module through configfs. Use/Test-cases:
 
 - Hotplug/hotremove connectors on the fly (to be able to test DP MST handling
   of compositors).
 
-- Configure planes/crtcs/connectors (we'd need some code to have more than 1 of
-  them first).
-
 - Change output configuration: Plug/unplug screens, change EDID, allow changing
   the refresh rate.
 
-The currently proposed solution is to expose vkms configuration through
-configfs. All existing module options should be supported through configfs
-too.
-
 Writeback support
 -----------------
 
-- 
2.48.1


