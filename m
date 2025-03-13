Return-Path: <linux-kernel+bounces-559844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 053A7A5FA89
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B749189B6CF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0687D268FF4;
	Thu, 13 Mar 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="sSREnVQW"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B785269810
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881478; cv=none; b=GqmjlffW6KebjUVvkvtMJfcbGHisk9zcRzJaV296MTSpZqwaVIDpNo/zPCrpRl9CpBZ2jI/SuFAgvwL6Af/DJlopSQmE/+xVVzcj60JZl2CoNE6dcqsnTW6HDlwF+32n2Er+rmqC8ORuDXa6dFQS7YtEsajzfP/F5vx/oHNOijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881478; c=relaxed/simple;
	bh=AoT76DpyfUVv2OctLsrdD/71kB8chHAZJqR9fipJwnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ojbguinaCd+4k1jGT5YdoP5ttofQnq3CY6ZEP9YqrDe/8MH6UNWNHajnKsX3+2+jVHYuY5QX92BPjObdpnn8Tnxn/SQw3QgWnEow1Ti53GpVQESVJ2yhFCc0xs0HFanbldy0J5L+o+F3jbA18L9mWbnmzPbZcYN1ed1L7KiPeN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=sSREnVQW; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1741881466;
	bh=AoT76DpyfUVv2OctLsrdD/71kB8chHAZJqR9fipJwnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sSREnVQWINwTHbRmvmV75Cf7VeCsnwPmwYgqJ585+6vFzSUkcuZPSAqkoEgv72aQ/
	 GXVTpCV25+6fcDQ3dkp3PslDSQBne2LngPdNOhpv9U8MUUMkmj13d1KxiqCIe42OG/
	 7HkyQ9pepeD5eG655V7o8+fW/LwPyx7EjWZw3u78=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 13 Mar 2025 16:57:45 +0100
Subject: [PATCH v2 1/6] sysfs: constify bin_attribute argument of
 bin_attribute::read/write()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-sysfs-const-bin_attr-final-v2-1-96284e1e88ce@weissschuh.net>
References: <20250313-sysfs-const-bin_attr-final-v2-0-96284e1e88ce@weissschuh.net>
In-Reply-To: <20250313-sysfs-const-bin_attr-final-v2-0-96284e1e88ce@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741881465; l=2405;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=AoT76DpyfUVv2OctLsrdD/71kB8chHAZJqR9fipJwnw=;
 b=v4thEqYFx8nP4MS9x5efRRsKLeqKcaRQZqJvwn9KVwQhfSEWMRQHBJhwjj7JjQntGa2GKBkHv
 YpcwBrDbBTlCMNFdcu0EbX3YZ4a6n7qX33YgBl192/s+C9Uc7VPbgOt
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


