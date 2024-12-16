Return-Path: <linux-kernel+bounces-446778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0349F291F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 05:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22EC81884B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717291C07C1;
	Mon, 16 Dec 2024 04:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rKNRcGOq"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DD51885AD
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 04:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734322072; cv=none; b=CdjmEnDwlIcOJq7QFItSeJLrv+Dm3JpYTLYyifwF7iV/G65Z0c4EHeAp6vxSl5NiM9ctJ7GbOwR96PIZ3W06IshusQaDox/uLVKMgh8AkIisjfj37WPLTSnb/BFlUdP0/h+Cd7VgJXxm54JLRiPdJDKIMgo7zqdtBTTaefSBfIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734322072; c=relaxed/simple;
	bh=Jn8gj5ETLfAmg0J0FzeVMFzW8y4Al5TBi0L76/poVeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZQfOnA+du3/zt67+4Q64hiz9tm1j0kJixv8EF5jE0jJkb2UCbUWFS5G1TEiaArZMSW3KX9avIZkrB7cc6Ks/k9+ZAn5gw95iAbB6KK+DEPxucNRRoETJwg9xykNIXOw/234u2N7I7mgP5TmRkUe0zCRsWwmXvt+ie/0M/EI6MxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rKNRcGOq; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734322066;
	bh=Jn8gj5ETLfAmg0J0FzeVMFzW8y4Al5TBi0L76/poVeY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rKNRcGOqDyGxIYNM6sGZypbYnUnRhbQsV3FSVJNv/Lud70FZlizhYzCTa0WaOykWm
	 eHv6szvSHrftwF35djHryS1bvs5YDc3G4wVzKvPXqabtkn6xYcKvAmEbee245Zn8g6
	 d+/J1OBw4dROLzbQidPJzXElYXPymhqLhHaUrFfU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 05:07:43 +0100
Subject: [PATCH 1/5] powerpc/secvar: Mark __init functions as such
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-powerpc-v1-1-bbed8906f476@weissschuh.net>
References: <20241216-sysfs-const-bin_attr-powerpc-v1-0-bbed8906f476@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-powerpc-v1-0-bbed8906f476@weissschuh.net>
To: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734322065; l=1924;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Jn8gj5ETLfAmg0J0FzeVMFzW8y4Al5TBi0L76/poVeY=;
 b=o5LTMX942/pTgvjJuj+3fewCjW41uN7ZEzdZrygLYHNpJhNVyIR79PTD79v0ctAOfgC45j8mU
 1vBsP3mrbdUBir6cn6QYNshbLXlDwNTuDsJ0EiLiAweMAdo1SY4aZEb
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The setup functions are only called during the init phase of the kernel.
They can be discarded and their memory reused after that.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/powerpc/kernel/secvar-sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index fbeb1cbac01b2c575cb7a71b16d214f2f822c489..b7536fbe8c4f43fa0f523c64685167b8b9dfd5ee 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -130,7 +130,7 @@ static const struct kobj_type secvar_ktype = {
 	.default_groups = secvar_attr_groups,
 };
 
-static int update_kobj_size(void)
+static __init int update_kobj_size(void)
 {
 
 	u64 varsize;
@@ -145,7 +145,7 @@ static int update_kobj_size(void)
 	return 0;
 }
 
-static int secvar_sysfs_config(struct kobject *kobj)
+static __init int secvar_sysfs_config(struct kobject *kobj)
 {
 	struct attribute_group config_group = {
 		.name = "config",
@@ -158,7 +158,7 @@ static int secvar_sysfs_config(struct kobject *kobj)
 	return 0;
 }
 
-static int add_var(const char *name)
+static __init int add_var(const char *name)
 {
 	struct kobject *kobj;
 	int rc;
@@ -181,7 +181,7 @@ static int add_var(const char *name)
 	return 0;
 }
 
-static int secvar_sysfs_load(void)
+static __init int secvar_sysfs_load(void)
 {
 	u64 namesize = 0;
 	char *name;
@@ -209,7 +209,7 @@ static int secvar_sysfs_load(void)
 	return rc;
 }
 
-static int secvar_sysfs_load_static(void)
+static __init int secvar_sysfs_load_static(void)
 {
 	const char * const *name_ptr = secvar_ops->var_names;
 	int rc;
@@ -224,7 +224,7 @@ static int secvar_sysfs_load_static(void)
 	return 0;
 }
 
-static int secvar_sysfs_init(void)
+static __init int secvar_sysfs_init(void)
 {
 	u64 max_size;
 	int rc;

-- 
2.47.1


