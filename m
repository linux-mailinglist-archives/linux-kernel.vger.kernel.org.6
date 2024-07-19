Return-Path: <linux-kernel+bounces-257410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58927937987
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 17:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8980A1C20E7A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 15:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B451459FD;
	Fri, 19 Jul 2024 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="zZl6K+7K"
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851701A269
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401613; cv=none; b=t4qTi0AQgVU8BpsjvmkhTLpqCQp+VgX3wryXQOj7MszSkWbm+ao1Hk01PDgNxSgsO1NQ+Gkn2ZZSoPP5a/UVyYJKavQ9h8Nh/eWECmGQD0Il7n3NWExmz9y973kfnMOVMQQfca7dt8KK0vTwrhRDqY1ZVW+lEjfuaYx+NCa8piw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401613; c=relaxed/simple;
	bh=1VRgN9E20Mz0E1cuuygk/Vt16CkssBzZL4IMwdHn5A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nw1ZwX4IZm6ObB5YKhaYMi6FgcGOkjvvkk6hYKC3cZb/UZ+3IKdPo2fAI6Xs1nnrPRelipHLV1bwQxjXmKKFQUTKVtSzMK3curHKPzpnzkerVCJnQ5nGC5/cpvvz4mg9kwnTvp1G8AxENlPMdpm2gI5DmU7FLbElWcTCtr8NUbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=zZl6K+7K; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WQY132qxMzcBS;
	Fri, 19 Jul 2024 17:06:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721401607;
	bh=OBPsO/SKaEeE/YlM+it8OhWEccms0c50naVM5DXA5DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zZl6K+7KhAbi7bYpDROj72Z4n5CgbrmipVkvzgc99i6WI8wepLoaj7q4hywJa494g
	 KAM8GT55IEH4ZTwDLJe1cqODQ0Nzt+HRzalIKzn1xbQhq2k0s2HoT6H6pWxSLVbV77
	 Z7E1pqLCdCPFCaZS+mUZ4S3Fs1D7cvlIKCJvo350=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WQY126cp3ztZT;
	Fri, 19 Jul 2024 17:06:46 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <keescook@chromium.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Shervin Oloumi <enlightened@chromium.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH v1 3/3] landlock: Document network restrictions tied to sockets
Date: Fri, 19 Jul 2024 17:06:18 +0200
Message-ID: <20240719150618.197991-4-mic@digikod.net>
In-Reply-To: <20240719150618.197991-1-mic@digikod.net>
References: <20240719150618.197991-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The Landlock domain used to restrict operations on a socket is the
domain from the thread that created this socket.

Cc: Günther Noack <gnoack@google.com>
Cc: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240719150618.197991-4-mic@digikod.net
---
 Documentation/userspace-api/landlock.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 37dafce8038b..4a9bfff575d5 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -529,7 +529,9 @@ Network support (ABI < 4)
 Starting with the Landlock ABI version 4, it is now possible to restrict TCP
 bind and connect actions to only a set of allowed ports thanks to the new
 ``LANDLOCK_ACCESS_NET_BIND_TCP`` and ``LANDLOCK_ACCESS_NET_CONNECT_TCP``
-access rights.
+access rights.  These restrictions are tied to a socket and are inherited from
+the sandboxed thread that created this socket.  Hence, sockets created before
+sandboxing are not restricted.
 
 IOCTL (ABI < 5)
 ---------------
-- 
2.45.2


