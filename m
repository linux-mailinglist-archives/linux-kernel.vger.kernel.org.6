Return-Path: <linux-kernel+bounces-566500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC56DA678E6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17F119C2D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F22211472;
	Tue, 18 Mar 2025 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Q02HUP6q"
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C20197A8A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314503; cv=none; b=TNIDjQ5zzTLWhfeihx8/y+M7ZHE0zmzf53p0QIdVXzQjBg3KnX6jI+6dENsTj+JKcilVYgvScfEqED7ZwtWz5QppqIH2kzo6cczyyiZHFcjcuXIhlfy7wtcLklc5QtAo0CvVq2bM3J97bUb2ft/sizUsMEBfFIRJBg2ngQmHPvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314503; c=relaxed/simple;
	bh=/fE7qseGju2TMqWFuKyjlpp63PRsN4eYb5EwM78duLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRoAbtLGlkindVrAGNgMY+TozMswVOBTyLiHKDqgPJpoGz//7trbJy69DhpW6pAMMQ0el+aH8TO5l8EgE9HZX0nVmCS+IU6CYe9vXbCR4MqpIfySOO1u2papdlZ+r+fUgPcqYbtBPCuWl3v4tUeQzHfvQFPIcp9EcQPMG0BrQe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Q02HUP6q; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZHH3y4hbtzLN8;
	Tue, 18 Mar 2025 17:14:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742314494;
	bh=+j0LtoVt3OIepcXloA9LXUklWtBjzkuGwi8atd/2Zjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q02HUP6qI21NCNDU/VSar566Bv0FCf8Y7TPP/lR500B89bwKszx3ZqO02PDskma+K
	 +SSy589eYK0C/6rq7PI2AwFiitRk7CIhvAfU5/FNcrDVCHk/xCjIfBR0qprQs9lWdS
	 YP6SbmyKVaIhIqdgh9PE6Ewt1dhlVJUMV1jDn39M=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZHH3y0863zy9;
	Tue, 18 Mar 2025 17:14:54 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/8] landlock: Add erratum for TCP fix
Date: Tue, 18 Mar 2025 17:14:38 +0100
Message-ID: <20250318161443.279194-4-mic@digikod.net>
In-Reply-To: <20250318161443.279194-1-mic@digikod.net>
References: <20250318161443.279194-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add erratum for the TCP socket identification fixed with commit
854277e2cc8c ("landlock: Fix non-TCP sockets restriction").

Fixes: 854277e2cc8c ("landlock: Fix non-TCP sockets restriction")
Cc: Günther Noack <gnoack@google.com>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250318161443.279194-4-mic@digikod.net
---

Changes since v1:
- New patch.
---
 security/landlock/errata/abi-4.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 security/landlock/errata/abi-4.h

diff --git a/security/landlock/errata/abi-4.h b/security/landlock/errata/abi-4.h
new file mode 100644
index 000000000000..c052ee54f89f
--- /dev/null
+++ b/security/landlock/errata/abi-4.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/**
+ * DOC: erratum_1
+ *
+ * Erratum 1: TCP socket identification
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This fix addresses an issue where IPv4 and IPv6 stream sockets (e.g., SMC,
+ * MPTCP, or SCTP) were incorrectly restricted by TCP access rights during
+ * :manpage:`bind(2)` and :manpage:`connect(2)` operations. This change ensures
+ * that only TCP sockets are subject to TCP access rights, allowing other
+ * protocols to operate without unnecessary restrictions.
+ */
+LANDLOCK_ERRATUM(1)
-- 
2.48.1


