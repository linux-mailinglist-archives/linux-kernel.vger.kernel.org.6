Return-Path: <linux-kernel+bounces-266840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F35940859
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EAF41F23E29
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73FE18A951;
	Tue, 30 Jul 2024 06:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spwhitton.name header.i=@spwhitton.name header.b="SSBixUhb";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="RWNx1rlH"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353CD15ECDB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320701; cv=none; b=bTLfqStVyKSTyX2xqHLG9Q/xLxPJs8DSVR85+dKxSVoL3t1NF5VEpbwO56Mez89hDN9dVCCNIvKVNgVroqcz3y1DuyT/By8dEB6pSv67znZYTMI9AQNCFHaYqsczXnyw3+uKNEXEF4ED20tmsgs1ZsgMz6K4UmDoPU/pZDWQAao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320701; c=relaxed/simple;
	bh=dUyy9LcCFJTUHFoF7o/LnN7dB2UmsNlAkEA8N/x9jek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CvBioeEOPeToqL2iN1u9sfoYTA5WY+tnk6PEY9keCN19YJwP0PGKH+GUZjKONaveALluObR9rnyF8GfOyoPKBxBk+xDEGJ+XgEN0hkgSn1TDNkfeZtrl3XFzYbHnqI2UOwWtBtcUCK1pXbH0hgDHoWXlAfNQ6/OzthToImRnM0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spwhitton.name; spf=pass smtp.mailfrom=spwhitton.name; dkim=pass (2048-bit key) header.d=spwhitton.name header.i=@spwhitton.name header.b=SSBixUhb; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=RWNx1rlH; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spwhitton.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spwhitton.name
DKIM-Signature: a=rsa-sha256; b=SSBixUhb7S2CgiznJlvGrZVOycI+cIJkQHNByx4651Z/uAEXyw+Rq9THk/8fUMtbs5mb5sf5W6XTEz+TYliVH49qG1RTjNvtcQtzsbyh9K6RAaVVfZipon0NLGQ+CL+O8+KBwDJoN0eF2CrjwN09hBfPKFF3Lxe9vsN1ScPOb1Svsl10iOow82WKpzevf5SDPYyNeQ1kmlLhJj/adO9gkOVU0WCicQKGisl+G/BE6prZUuxjRaBP7mJ6zQ4q1zAMjc//Z84taBXoCrTs0klzy/QBQDSOzDeEZoh2LvmWT8hq3mqvIN79yb3x3q+jjxrEE6roCxg+bElK6DJtgHmg/Q==; s=purelymail2; d=spwhitton.name; v=1; bh=dUyy9LcCFJTUHFoF7o/LnN7dB2UmsNlAkEA8N/x9jek=; h=Received:Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=RWNx1rlHomrhXHPn7h4uw89thkp9gLp5yc7K3xster75q5LE0lBlPlJO56uX9PN1LZd3qkJe8bsN1c6AEtueNo9L9Y0IOrBE1SwgBkVyOV3SaO95t2MCgztKS2F3Q4+bGNjua0qoz9tcG5LP82SFJrReFBGLxPhgY4RgsT+VqJRSxhXYxwVhsqeUJDWFhsUdxiTvPuutUN8Oag/nChDpYBQtfKJbYwe6S69Uq2q2o5YpClplTF55lWzEjds9FaVk7QR3iC4b/53EjL6803dxgKiPrbQhKg3kJg9pSAWV65D0x1z/yshKrHKK3DGWU5TtVxzbfUhGP4Cn9qDc/hCn4A==; s=purelymail2; d=purelymail.com; v=1; bh=dUyy9LcCFJTUHFoF7o/LnN7dB2UmsNlAkEA8N/x9jek=; h=Feedback-ID:Received:Received:From:To:Subject:Date;
Feedback-ID: 20115:3760:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -579794942;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 30 Jul 2024 06:24:21 +0000 (UTC)
Received: by melete.silentflame.com (Postfix, from userid 1000)
	id 7FC1F7F30E5; Tue, 30 Jul 2024 15:24:18 +0900 (KST)
From: Sean Whitton <spwhitton@spwhitton.name>
To: 
Cc: ~lkcamp/patches@lists.sr.ht,
	helen.koike@collabora.com,
	Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: media: atomisp: Add parentheses around macro definitions
Date: Tue, 30 Jul 2024 15:23:45 +0900
Message-ID: <20240730062348.46205-2-spwhitton@spwhitton.name>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Fix checkpatch error
"ERROR: Macros with complex values should be enclosed in parentheses"
at hive_isp_css_include/sp.h:41, hive_isp_css_include/sp.h:42.

Signed-off-by: Sean Whitton <spwhitton@spwhitton.name>
---
 drivers/staging/media/atomisp/pci/hive_isp_css_include/sp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

This is my first Linux kernel patch, from Helen Koike's DebConf24 workshop.
Thanks!

diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_include/sp.h b/=
drivers/staging/media/atomisp/pci/hive_isp_css_include/sp.h
index a7d00c7bb8bc..128109afe842 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_include/sp.h
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_include/sp.h
@@ -38,8 +38,8 @@
 #define STORAGE_CLASS_SP_C
 #include "sp_public.h"
 #else  /* __INLINE_SP__ */
-#define STORAGE_CLASS_SP_H static inline
-#define STORAGE_CLASS_SP_C static inline
+#define STORAGE_CLASS_SP_H (static inline)
+#define STORAGE_CLASS_SP_C (static inline)
 #include "sp_private.h"
 #endif /* __INLINE_SP__ */
=20
--=20
2.45.2


