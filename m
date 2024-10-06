Return-Path: <linux-kernel+bounces-352413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4256991EB9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 16:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4283F1F21AA0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 14:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903F63612D;
	Sun,  6 Oct 2024 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=timo.grautstueck@web.de header.b="vXepDVlw"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B306A1CD3F;
	Sun,  6 Oct 2024 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728223426; cv=none; b=WIt+vANwycmUXmyODYUNQtlwgbHnIoItihh0ys83FY76FLI/m9AMZT5kDib/HmOYDFYN7st68CRiupjqhJRL+wED2kf06j8y9/36gv+JbhbNnPvl0t76zSI5ZInL28HcXdwBLjR9Oed1jMF9uPc1cg9qFOyk1/ubtXAQTXH7ic4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728223426; c=relaxed/simple;
	bh=prHIkG6lXZ+f0rbKF3HO/23UrfF983phPqFvJlj0WxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7NzInFjbFJ9bsyMUwyMl1oSpkEqghdX07S6Fo5J82g2mfaJxh9LiZokpXCulE4CNsomQPLv/ui8UC9pnTUNoH3/xK/sJMgZw8769OxDUZtXgXZQWTrMEuE3ru6ZSkTHTDirl9yhmI0vuTk0yAtI2BomCbYMLRszMImOa6QK41U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=timo.grautstueck@web.de header.b=vXepDVlw; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728223409; x=1728828209; i=timo.grautstueck@web.de;
	bh=RhobfjPRWKGv5pI2wAc+H65bQLf+Dqu1BevLF2wvBEA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vXepDVlwAUXZhOtdSoYF+EkVDFgHOGY+p2Hq3iB0LL0Mt2UvVKcFjFdp5h3Mf/bS
	 4Q3XFBN0lOnEzUl6wPlxzDqrnbLyHETuMfk/oCfhdqRb8xTDZRRjpEXqxFX+wo18v
	 jLqe2YcEDrrGMGGyLXjS1Cq0hI+KT6u5rX4Orc6rq1T6/H4UeLnVjgi+9TvcFbzzu
	 f/70/cjhs2paaj4T+lFdHQG03cP2GfbZL0e919TenQmYmgyJCOf3vk6Ydjc68MRgs
	 M6ff1GcQNDcGZvjd7sXKsR/0GSfUcyJlutgda/ejHqX1bQU0DGK8dKv3HloaKGwwe
	 k2iRADrhYHdqHClfNA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.78.106]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1M76bb-1t4r2k1kEB-006z8z; Sun, 06 Oct 2024 16:03:29 +0200
From: =?UTF-8?q?Timo=20Grautst=C3=BCck?= <timo.grautstueck@web.de>
To: miguel.ojeda.sandonis@gmail.com
Cc: linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	timo.grautstueck@web.de
Subject: [PATCH v3] lib/Kconfig.debug: fix grammar in RUST_BUILD_ASSERT_ALLOW
Date: Sun,  6 Oct 2024 16:02:44 +0200
Message-ID: <20241006140244.5509-1-timo.grautstueck@web.de>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <CANiq72na=RqV=vhKZr8iZMdvKZXxqX5r7bDgo84KnPWddc4Z1w@mail.gmail.com>
References: <CANiq72na=RqV=vhKZr8iZMdvKZXxqX5r7bDgo84KnPWddc4Z1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d3+35liRFHS3uz7tGtX9X5gKRWzw8rryytmcivuFt/j/IDHguft
 bvoLq1AZcAc833qAVsyZEmFBYLJXzzbfrgTOgT4aDSgaHZj4V9dXj9g2+Zui2QFpyO8dliZ
 JBcBAjAh9z8ETMfaeGhs/QSlphHsGwObGJnhwx7gFHH/XbDmB1w1iDQxzHL9JNV75rKX6zJ
 roIa6gCTBSPMc77IL47oQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y56AicibXF8=;N3cX+M2dIWbmN5R2GucQKQRp9zH
 iFCcw7119yecnfWnSMvypNwHrLyvCrH00USkY3ViaI6AQ2oUMctSRcL/2v0E1j0Jb3T2drZoO
 4VIzGUSNqunxpY1bR8HTNP+thvZnW3sJZ0Lh1QjOncU1V14NvgMdoTEESD9C7xqoZL+/gXs8p
 lTC9hFKmN5CNF8M7ZKZtpYqW6FyihVN2wgHDEno4z9AX2B3dLoOhbeZiE1s6lXjs5DPHe8n1P
 LqPIS2vmVtQQTmvNbX5TDgiquGtJeJ4MeUaLz2R8NR42aUiBPkSZ5fRM9aSwgFXDlm2MzOcQa
 xZu8tJJQ7SyQkScMpp8J68WTo0IMOEoJLacuL8nqQ4wq2prLtqM5jkHT7sB3wtZw6yJIhRZNd
 5QA3P2oxIRxaLnKqkMwmfLNRGTyRB8f2/B8btSmViaY8RKxOUtCvz7Y9n9olqf7E+J6Qkwfmf
 s06wWhh4LzX/s6NiGG0a/5Ew6Bs1c1PhLkWJTCwsWQxwJgcavTcfqdf0/pPWfyrQFyzp2zNmh
 TvQ8WgUupiN9yEOZx6v41mSHjdb6lH5NVL/EmyGaauNgh34OfU1baFikrmXf6FL6JXvs8BEHM
 OApqVxKA+jQ0EAi/Nx4Ps4gnI7ZwTbXzY6bCj6H8BRx0Av3+N0TdZFbQ2863R7mNhLeKZZotS
 CrgiTKKQdAW7UUIEMUWwVp+Tpd052Sko/ExIIv3phHaOkHV9dtazDkyC0BoxdLCxH3r7VBSQ3
 kH52jDbV1UHJ99R7PdROdf/rchRO2S+VYzr0fRHwF4+BcGgn2OltTsHuxJnBorXPcvUajnCgj
 ymPuxmxF0iX+4ce7gSLGUShFAfyzHLjtI3eIAhVnvBqns=

From: Timo Grautstueck <timo.grautstueck@web.de>

Just a grammar fix in lib/Kconfig.debug, under the config option
RUST_BUILD_ASSERT_ALLOW.

Reported-by: Miguel Ojeda <ojeda@kernel.org>
Closes: https://github.com/Rust-for-Linux/linux/issues/1006
Fixes: ecaa6ddff2fd ("rust: add `build_error` crate")
Signed-off-by: Timo Grautstueck <timo.grautstueck@web.de>
=2D--
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7315f643817a..7312ae7c3cc5 100644
=2D-- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3060,7 +3060,7 @@ config RUST_BUILD_ASSERT_ALLOW
 	bool "Allow unoptimized build-time assertions"
 	depends on RUST
 	help
-	  Controls how are `build_error!` and `build_assert!` handled during bui=
ld.
+	  Controls how `build_error!` and `build_assert!` are handled during the=
 build.

 	  If calls to them exist in the binary, it may indicate a violated invar=
iant
 	  or that the optimizer failed to verify the invariant during compilatio=
n.
=2D-
2.44.0


