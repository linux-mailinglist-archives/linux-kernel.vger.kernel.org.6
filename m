Return-Path: <linux-kernel+bounces-522534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA66A3CB93
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC03517864B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3727A2580E8;
	Wed, 19 Feb 2025 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="OmlGeFtS"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06A82580D8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000964; cv=none; b=Nj8GW22vJUnaKBHVQSYsvainUhYWzgj0tplgalEoyAn1SufHAKUWhjBWFzAZIq+QMMOy4QFmpRxlBJnBMLz5KZ1ljOCyoN5o6uznN1CnEL+TSVRiBaSz0k/Q1O2lCKxpMSBxJ25F/ELBHkErEM5hQdDsymx74Sz6xp4ZbTvCDXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000964; c=relaxed/simple;
	bh=AoT76DpyfUVv2OctLsrdD/71kB8chHAZJqR9fipJwnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MfvYG1Vug9JwNb4+LpuGAo8L06oIl4DN/Spng/Dh30YBhRNaLQM9TbokuUmMXPz1VsaP8rQ/bCZli+iSZ40+Ir6MjxAmwDTyfYZMK4m/wDbE0K//splz7ld9ft2K49tOJU7RUE0pZavNGd4B6Ilpj4TrPrvCsVYf7KSTKSgHdWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=OmlGeFtS; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1740000960;
	bh=AoT76DpyfUVv2OctLsrdD/71kB8chHAZJqR9fipJwnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OmlGeFtSSM74FczFPZ9DNj5REDvMjYqWdYd9/aq1FLx85qddDue8h/v8rsoygMSi9
	 SmQxy54xK2zkxvWciNfeBIjXv3/aACMHYQHGHc/rgeMLz1bSlLkJhDFcmpjKCvA+v0
	 DktwotYab82qtCjUtl4D1jZeQQDlIwFOTB5ZABSY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 19 Feb 2025 22:34:50 +0100
Subject: [PATCH 1/6] sysfs: constify bin_attribute argument of
 bin_attribute::read/write()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250219-sysfs-const-bin_attr-final-v1-1-02828d86af3c@weissschuh.net>
References: <20250219-sysfs-const-bin_attr-final-v1-0-02828d86af3c@weissschuh.net>
In-Reply-To: <20250219-sysfs-const-bin_attr-final-v1-0-02828d86af3c@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740000960; l=2405;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=AoT76DpyfUVv2OctLsrdD/71kB8chHAZJqR9fipJwnw=;
 b=1KaZPCRc095NddnKCjA1TpV/shRCSRBDqGyt26ET0b3ZKk8SZSJcUSgXo2vll9FNHSrnBOTYV
 +ojHEgCNhh+B8Qk6832/fi8VK5c6vjCghWWRHDmBTL0vroZOu7QH6wY
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

All callback implementers have been moved to the const variant of the
callbacks. The signature of the original callbacks can now be changed.
Also remove the now unnecessary transition machinery inside __BIN_ATTR().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/sysfs.h | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 18f7e1fd093c9179a86aaa16f3f8851338778b0b..576b8b3c60afb382e4ce18247fd5a3d50f08d579 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -306,11 +306,11 @@ struct bin_attribute {
 	size_t			size;
 	void			*private;
 	struct address_space *(*f_mapping)(void);
-	ssize_t (*read)(struct file *, struct kobject *, struct bin_attribute *,
+	ssize_t (*read)(struct file *, struct kobject *, const struct bin_attribute *,
 			char *, loff_t, size_t);
 	ssize_t (*read_new)(struct file *, struct kobject *, const struct bin_attribute *,
 			    char *, loff_t, size_t);
-	ssize_t (*write)(struct file *, struct kobject *, struct bin_attribute *,
+	ssize_t (*write)(struct file *, struct kobject *, const struct bin_attribute *,
 			 char *, loff_t, size_t);
 	ssize_t (*write_new)(struct file *, struct kobject *,
 			     const struct bin_attribute *, char *, loff_t, size_t);
@@ -332,28 +332,11 @@ struct bin_attribute {
  */
 #define sysfs_bin_attr_init(bin_attr) sysfs_attr_init(&(bin_attr)->attr)
 
-typedef ssize_t __sysfs_bin_rw_handler_new(struct file *, struct kobject *,
-					   const struct bin_attribute *, char *, loff_t, size_t);
-
 /* macros to create static binary attributes easier */
 #define __BIN_ATTR(_name, _mode, _read, _write, _size) {		\
 	.attr = { .name = __stringify(_name), .mode = _mode },		\
-	.read = _Generic(_read,						\
-		__sysfs_bin_rw_handler_new * : NULL,			\
-		default : _read						\
-	),								\
-	.read_new = _Generic(_read,					\
-		__sysfs_bin_rw_handler_new * : _read,			\
-		default : NULL						\
-	),								\
-	.write = _Generic(_write,					\
-		__sysfs_bin_rw_handler_new * : NULL,			\
-		default : _write					\
-	),								\
-	.write_new = _Generic(_write,					\
-		__sysfs_bin_rw_handler_new * : _write,			\
-		default : NULL						\
-	),								\
+	.read = _read,							\
+	.write = _write,						\
 	.size	= _size,						\
 }
 

-- 
2.48.1


