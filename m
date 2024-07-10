Return-Path: <linux-kernel+bounces-248011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7456D92D764
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE6A1F22659
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A68194C79;
	Wed, 10 Jul 2024 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNcOwtGB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B050A192483
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632443; cv=none; b=um/cVqsZcPe6WI6LwR6ARhD186d7lAEYPvxg23w48G76MwGyUiX9EcWOvfKcgf+fa+LoiCiw232h4tW+UyEiM8Tf+LQrXUldLXd78XjQe/YNcMuSZruE9rx+YS1bNrLxpcl1ATcGxPGf07HZTC/YE2BPZcdFnv8JC3q7fLJS4zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632443; c=relaxed/simple;
	bh=N+6nP24X2D6S+4HtySYOmSBVHZCaJaPE+LuP8o4gdBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EInxxMJjqKZ5gls/MtpzComVKPhTe0YdEeROaUgq1MGALuBnelWWSENOBsY5/BcYIn1GfPQu4L6ZA3HcYnaSZ8xNGKuoldfaTQCotgK8P2fqwD4+omdzJzK46/4t8jWBKMfVMRYbzBVKMDt1rG94f0k8TUoylCKahNd6I6Cqz54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNcOwtGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9F6C4AF09;
	Wed, 10 Jul 2024 17:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720632443;
	bh=N+6nP24X2D6S+4HtySYOmSBVHZCaJaPE+LuP8o4gdBA=;
	h=From:To:Cc:Subject:Date:From;
	b=TNcOwtGBvZKQtWGf63CHbuqIAvWyb9RhCVRd6Hh8494D9I/Jn4l7ZkUBGxh+n72z2
	 t7mf1QsACZJFjhubmxfTwN/8oNFY/wFPwauPyyHJc+4G7Gr6h1P2LqXYpXW376c4sw
	 Klxlri58iQ9gUiSTEvvGsCY3Wukc+PCDYB5u2HDM/OSnjxf93zvKfA9bneVY6zIJZE
	 hiI7/9hHxuFJZ+TmuTIZK9d58GimT/xGPSUbqW4g7jdyy9uooEWpSLP+/Hln4PXqjq
	 upnUXFvWhMuYhl5Csm7mT4AiQoZhA9V6pV+o+6hEuAUCuLhcldIKqk56Y919M+sU2L
	 H52swwg7eO6JA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sRb68-00BI6M-SC;
	Wed, 10 Jul 2024 18:27:21 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: deb-pkg: Fix build error caused by lack of positionnal argument
Date: Wed, 10 Jul 2024 18:27:17 +0100
Message-Id: <20240710172717.1346194-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, masahiroy@kernel.org, nicolas@fjasle.eu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Since 8ef052389f7f ("kbuild: package: add -e and -u options to some
shell scripts"), building a debian package on my arm64 box fails:

$ make -j20 bindeb-pkg
  UPD     include/config/kernel.release
  GEN     debian
./scripts/package/mkdebian: 138: 1: parameter not set
make[2]: *** [scripts/Makefile.package:98: debian] Error 2
make[1]: *** [/home/maz/hot-poop/arm-platforms/Makefile:1538: bindeb-pkg] Error 2
make: *** [Makefile:224: __sub-make] Error 2

Applying the same pattern for substitution of undefined variables
seems to paper over the issue and brings the script back to life.

Fixes: 8ef052389f7f ("kbuild: package: add -e and -u options to some shell scripts")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
---
 scripts/package/mkdebian | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 196b14e8ad47..de8b460a46b4 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -135,7 +135,7 @@ else
 fi
 maintainer="${name} <${email}>"
 
-if [ "$1" = --need-source ]; then
+if [ "${1:+set}" = --need-source ]; then
 	gen_source
 fi
 
-- 
2.39.2


