Return-Path: <linux-kernel+bounces-299960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFE395DCFF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 10:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA734B22693
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 08:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410B11547DB;
	Sat, 24 Aug 2024 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="UYtmiSWh"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D7B5680
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724488787; cv=none; b=oeu2pdRKsVIpEDVDW3z17vc84wPm+yuY5u7iG8t0OFSfgShHQebxGAQP5gRl5I/2xGtVNGguPFpet5EsfodQK+ExT1GDIRBHZKx1bPvRu79NHcen89/P9jqHDC9j9aJIQAtVJ6Lt0BHfgFoKGqzxBiRcy2I0T+AwYG2SpNzNFb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724488787; c=relaxed/simple;
	bh=vMKObzkUEEoqMKU8RXSyMlhpNcH5CxpRElgvx4nGK/Y=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=u3s2e6jEP03x2bZwY4FvlM3RCLTOg27XhHP6N3mGYsMerivA3uMxmaFf3A3jPdvLlRF+gbxtLmLJFhN9MXHFRWwC4dkWYVFzgOv3nPqsONSJYPa4sDEzzcXeKyi8NWNzh764NSCd3nHBDuB1u4EzaeQ0bGzsHv3Wz/FQKQtQtVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=UYtmiSWh; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1724488479;
	bh=Nr5CwV8SDFTHEbQ4fOfilDtU2d/P9Nj2M/Pw6Z9L6I4=;
	h=From:To:Cc:Subject:Date;
	b=UYtmiSWh9J3SHK4OOVHyE22m2o8uTaj7pUzju5za0DbWbCEoNGRmYDtwCpik2096o
	 jDcb2sE4iISt/Y700UscnzSJlo0dAwR1Uud+uw16qR0C4efY5oedGgWgal7qXPg9I0
	 q8d0X7hsf7PgW/SrpKKv/tErXfWiSJ4G6FAgFo/M=
Received: from localhost.localdomain ([171.223.167.119])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 541056CC; Sat, 24 Aug 2024 16:21:01 +0800
X-QQ-mid: xmsmtpt1724487661t6xau541p
Message-ID: <tencent_6EF2603DCCFAD6A8265F8AAD9D6D5BCB9309@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeW02xbhina/QJPzUrVbZYEy0kN2bsN7d6y24gh4666/EdO6aIh6
	 UgwBC14RD5+UupUY+zdWlpYq23z+y0mvb8mzP16HKEViSrzCvv20RGf59V4+YNkHX5Zoa4EY91TL
	 h5vPBXASMTItgda6Iy3Xr2PjHcLaIOVDiihgCOuWn/TBbAboXJR0Fu7Ocf3SGeCJaA8cAG0qa2ep
	 EgAhLyHCKeBkNjkGPrbLlqtgRb84qbIDnzv94r97G4UvoAjvxdoQkEu/fe6ehfE6kpWo1puVX6le
	 Mo9/8uAJgbnIzWIOaY2tL0F6CTF89lmwRQPdpbB7hZEy9mjg7jHkKaUa5KLaDZ4WZfYe5yoIdyFM
	 5OIW3VHvd+ycNbZdHMzTCaCApbs3BHgMOgCgORnbz6aUckKut7MEf9AV2GyJw1Z7juL89NsVZEZH
	 PDdFUe8+zX9LN05voOfjavOuqN87HPHwm93csQ5GR3PYCNmg7VC5n0jrvYaaf0AE/rW2X2+Nfmkw
	 hMeOB3tsaC7oO7Ghpl9O1ecx1QjVtJWOrdTd2Hopnlbgfn1IR+/7/6RojGQjKOWRHy+zWgPyARxP
	 bmYHhm0KBQHdGIRV6vQ3dqzyFF4YJN9julMWlILRUkMaVTZEVK0jD42Wrz7vMf/0aYNiQa1gkDN2
	 F5vGQSwyXQ7WMVG/mM7S6I1YpTi/0NwEthI+BzxjGN5nfSm6b8NXuRN2+BPgm5gncY/iMDpyxoG5
	 5ky66007Pu2wOxLKUnX6IrfByjL5eiIQ/Nsx0uB5qSTMc8KGiQVCI+TGsBX1UxHFzuVywrr4OPKZ
	 uQNwPz2Y5zNiuj+sRjvDeCaHlDzwQ9D3bsA1FMkgeu+pUsyVR5pZaK/0D3oRYcr9psbRpO9ckzK0
	 LpZyp8RziWuhpT8mUweeONVzeZ9XwrRpq8buGgMI/pPJVUTUp25A/BfYhIzZJMGpHg4+hrjMdTn2
	 PTss6a7WBA2w8KwB4OmxWlElUDUF4IEFsGi/Bo2m0+TThxpGIGBzRTREydwDV2psT3ECeJ08E5D2
	 YxE/MvRFmwkExMXgiT7zX/CwRnQ5j5uoWkA+DOyeblUcIfJtKvC1yhV9hLYf57GUvmdF+WyMyfS/
	 5bZI23pIzmJhb6tv8=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: renjun wang <renjunw0@foxmail.com>
To: maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	renjun wang <renjunw0@foxmail.com>
Subject: [PATCH] drm/atomic: fix kerneldoc for fake_commit field
Date: Sat, 24 Aug 2024 16:20:14 +0800
X-OQ-MSGID: <20240824082014.26004-1-renjunw0@foxmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the context, the function description for fake_commit
should be "prevent the atomic states from being freed too early"

Signed-off-by: renjun wang <renjunw0@foxmail.com>
---
 include/drm/drm_atomic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 4d7f4c5f2001..31ca88deb10d 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -460,7 +460,7 @@ struct drm_atomic_state {
 	 *
 	 * Used for signaling unbound planes/connectors.
 	 * When a connector or plane is not bound to any CRTC, it's still important
-	 * to preserve linearity to prevent the atomic states from being freed to early.
+	 * to preserve linearity to prevent the atomic states from being freed too early.
 	 *
 	 * This commit (if set) is not bound to any CRTC, but will be completed when
 	 * drm_atomic_helper_commit_hw_done() is called.
-- 
2.39.2


