Return-Path: <linux-kernel+bounces-389900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3C89B72A1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51749285AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B87145A16;
	Thu, 31 Oct 2024 02:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="SgdNzxzM"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C17C13BC35
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730342674; cv=none; b=kUWUFUkuFV92ZtV11D0HEighJDkbxNA+HMCXBf2EZ8sKlnYVyRLZiWHk6SNWVmqnI4akA1DmTXS6N60QFe7gZZijNWbcoiTiidBiTlOPF+VsADtAtMz3LphSStMu5dmUNvRiZSJBX4KTCAkLanYwK3NiL3Qz8HHtGlesDsXMdLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730342674; c=relaxed/simple;
	bh=i1lGRcvBSYaAkRCU3PsefBTXEi2eEGtd/RNZhauMerg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bl1DheUSFIzGu+1DpeQVS9REYaK/rJRBWWl14x7xHOG3iwsWJSDLT2jFAx77Q6gyRbyhC+nUkPhlSp1NzfYu6aDVJtxdc6776GvEHseSOuRsP/892+LIaKQpw+Botgk9m9EdF6pzmvhbSDshgxVvNgO/0D76J6PjEJBzblntprw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=SgdNzxzM; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730342670;
	bh=i1lGRcvBSYaAkRCU3PsefBTXEi2eEGtd/RNZhauMerg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SgdNzxzMiYxflEhxc4zZ09ihbZA0Xs2225NkbF5pZFnIUf6zhqMmCw0y94cdP+Rfg
	 8stulYcDDZzZ6yvYlt6ekhF7OXpCEwQk/wvM5UefSoE5UJcNEhyHCQwIC28lKkr9/0
	 sg2slJ0Wa+2Gwe64V/H6pGeBFkj4F8mhLC7QeAwM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 31 Oct 2024 02:43:59 +0000
Subject: [PATCH RFC 10/10] driver core: Constify attribute arguments of
 binary attributes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241031-sysfs-const-bin_attr-v1-10-2281afa7f055@weissschuh.net>
References: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>
In-Reply-To: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730342657; l=2330;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=i1lGRcvBSYaAkRCU3PsefBTXEi2eEGtd/RNZhauMerg=;
 b=470iQ9NDnuAKYE5QZCLHTilcvwmKlMlL3K95787QwTdoOu7rrtFzqJc1H1XZ+6Ukm+sMLYlEM
 cGiOY/0k5uOD5ZbaiCW/Jc5e6bVwcLqd5EdM71cU/F33tQJFOvCOLrI
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

As preparation for the constification of struct bin_attribute,
constify the arguments of the read and write callbacks.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/base/node.c     | 4 ++--
 drivers/base/topology.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index eb72580288e62727e5b2198a6451cf9c2533225a..3e761633ac75826bedb5dd30b879f7cc1af95ec3 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -27,7 +27,7 @@ static const struct bus_type node_subsys = {
 };
 
 static inline ssize_t cpumap_read(struct file *file, struct kobject *kobj,
-				  struct bin_attribute *attr, char *buf,
+				  const struct bin_attribute *attr, char *buf,
 				  loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -48,7 +48,7 @@ static inline ssize_t cpumap_read(struct file *file, struct kobject *kobj,
 static BIN_ATTR_RO(cpumap, CPUMAP_FILE_MAX_BYTES);
 
 static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
-				   struct bin_attribute *attr, char *buf,
+				   const struct bin_attribute *attr, char *buf,
 				   loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 89f98be5c5b9915b2974e184bf89c4c25c183095..1090751d7f458ce8d2a50e82d65b8ce31e938f15 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -23,7 +23,7 @@ static ssize_t name##_show(struct device *dev,				\
 
 #define define_siblings_read_func(name, mask)					\
 static ssize_t name##_read(struct file *file, struct kobject *kobj,		\
-			   struct bin_attribute *attr, char *buf,		\
+			   const struct bin_attribute *attr, char *buf,		\
 			   loff_t off, size_t count)				\
 {										\
 	struct device *dev = kobj_to_dev(kobj);                                 \
@@ -33,7 +33,7 @@ static ssize_t name##_read(struct file *file, struct kobject *kobj,		\
 }										\
 										\
 static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
-				struct bin_attribute *attr, char *buf,		\
+				const struct bin_attribute *attr, char *buf,	\
 				loff_t off, size_t count)			\
 {										\
 	struct device *dev = kobj_to_dev(kobj);					\

-- 
2.47.0


