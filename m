Return-Path: <linux-kernel+bounces-559849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E06A5FA8D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C55E7AA8AE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416AC269CE1;
	Thu, 13 Mar 2025 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Bgm7l1zC"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0816B269891
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881481; cv=none; b=hJAuq0xFCEQvwQv3F3v38HEb8T4VPcFKa/jrhIBgWf4cdXQjiTJkt3XCZxXqbZM9grcRScDLYO8Ej1thPUMuttd13t8TUvtpDC6oSAMBuxk2YbrNWXOJKi2xNyvcgGXdblLUFzMeyMKe1jjcrz1q6mlTG4MeY0Qn8AiV1l5dKbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881481; c=relaxed/simple;
	bh=9s5md+Z6F8QlGH1qmCYf/s2qQ5LvNcggSmZZuDmybgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U3QrbrsEtvgXP9wMSOV7EMGw2jFm3RKGLPlEOLS8OYkOJ8xeYqSTyk37Dkvw81JNRJFkIJduPDyBEm3mGz6E774FTzpVL634XYp8OQysuB7ZSUJCuSdZ+eUe6ZzQSse4P2dteySt2W613K3xGSthZbFBeyLpdZFdCj7JjXQL2+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Bgm7l1zC; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1741881466;
	bh=9s5md+Z6F8QlGH1qmCYf/s2qQ5LvNcggSmZZuDmybgs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bgm7l1zCr0hGGz0AYUny8hvgtqf3dz/0Y6L8KoG1K1sb/QOqEPRDijUXx/0ohDWVX
	 AkaXZ15dB9xw7jS5tAouJi/kQgj64in9XfDDQgVV3o397hHMOth0xdbMAUofjGNqMt
	 jwWCX8HvzbsrtNdO5WQ+twoDnv8QY3JlAcBzPHgM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 13 Mar 2025 16:57:50 +0100
Subject: [PATCH v2 6/6] sysfs: remove attribute_group::bin_attrs_new
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-sysfs-const-bin_attr-final-v2-6-96284e1e88ce@weissschuh.net>
References: <20250313-sysfs-const-bin_attr-final-v2-0-96284e1e88ce@weissschuh.net>
In-Reply-To: <20250313-sysfs-const-bin_attr-final-v2-0-96284e1e88ce@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741881465; l=1064;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=9s5md+Z6F8QlGH1qmCYf/s2qQ5LvNcggSmZZuDmybgs=;
 b=3QzdALUt6tpOEJM1hGt14pZaoiZUXH+D3UHlDMEvrpmLeaM8YQhe9No94BkJqlbqNvVOTH///
 3UTXRQbMdJwBpHTwINQhYWRCRnK39g52MG9JD0RMhJ3K+CRSVxlwKRJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This transitional field is unused and unnecessary.
Remove it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/sysfs.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 7544f6d81c05982b5d168624f376cd647127ab51..9a25a29116528fab77d667390dd3ef5957b86554 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -106,10 +106,7 @@ struct attribute_group {
 					    const struct bin_attribute *,
 					    int);
 	struct attribute	**attrs;
-	union {
-		const struct bin_attribute	*const *bin_attrs;
-		const struct bin_attribute	*const *bin_attrs_new;
-	};
+	const struct bin_attribute	*const *bin_attrs;
 };
 
 #define SYSFS_PREALLOC		010000
@@ -293,7 +290,7 @@ __ATTRIBUTE_GROUPS(_name)
 
 #define BIN_ATTRIBUTE_GROUPS(_name)				\
 static const struct attribute_group _name##_group = {		\
-	.bin_attrs_new = _name##_attrs,				\
+	.bin_attrs = _name##_attrs,				\
 };								\
 __ATTRIBUTE_GROUPS(_name)
 

-- 
2.48.1


