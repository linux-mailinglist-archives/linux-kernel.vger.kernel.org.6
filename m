Return-Path: <linux-kernel+bounces-522540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A039AA3CB9B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8D93B186F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC62825A2CB;
	Wed, 19 Feb 2025 21:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="bpa4Sry5"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A812586C5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000968; cv=none; b=lHNkCGcc4NyaUyuT0YhvHw3+TSgYkMbBQ5YOGXZINAgx87BPMuxwaUucUPoAPrvLClF7Bfwj9oaabsTwReWCh2m8k/5/CNFt8MtBkcrCCEGeGhX8B76zGINc6dI7NrwubKj1p8KuugDiiHjE/sue+Eicmj9zx5CaYTkiPLOhrRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000968; c=relaxed/simple;
	bh=9s5md+Z6F8QlGH1qmCYf/s2qQ5LvNcggSmZZuDmybgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VNZDI05LtZ6DfUUZR4GKqNPsxbTZ+63qbzXdXM7C7BlAf0V+lmlAxbrANVBYKBEINEJMVlMoCSzOp0BpW7bCesgX0bbtNweP0elexxydWfd35fRqpX0GtLLb+3CIQz9hyaFaJvlI3i6DjHWS40u68J+EaPsOW6pQfMdcWPVZHgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=bpa4Sry5; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1740000961;
	bh=9s5md+Z6F8QlGH1qmCYf/s2qQ5LvNcggSmZZuDmybgs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bpa4Sry5bVBvEQsMj3DWLv4zHyL1TeQFSWNl6Hv+YsQU7RNRF/ue88sRvxu8pJNYT
	 yBR2ACRXDVib4n2HnmK4mOvK6a6QS1khq/uinZiGgZ2vFFJnvJfiiB2l8n7t2CaHeM
	 LmYg2aes73ynMnCwtoMT5fk4KQ5LF4ouhJ0KSqGs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 19 Feb 2025 22:34:55 +0100
Subject: [PATCH 6/6] sysfs: remove attribute_group::bin_attrs_new
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250219-sysfs-const-bin_attr-final-v1-6-02828d86af3c@weissschuh.net>
References: <20250219-sysfs-const-bin_attr-final-v1-0-02828d86af3c@weissschuh.net>
In-Reply-To: <20250219-sysfs-const-bin_attr-final-v1-0-02828d86af3c@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740000960; l=1064;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=9s5md+Z6F8QlGH1qmCYf/s2qQ5LvNcggSmZZuDmybgs=;
 b=+u/8cVqWSazs+Iq8GA2dGkvXvP9sQx0jBRzqDOHEHqY8U5tUHVFdBViTeLKf60iQwIydhcvNy
 YUT9zk7Uk1iDiIoGN2LvZ0JaC3oxHtGl9Acin4DQwe25iZ91fyPln0B
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


