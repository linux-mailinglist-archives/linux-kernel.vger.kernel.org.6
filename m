Return-Path: <linux-kernel+bounces-397672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6A29BDEDD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3190B1F2219B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CD41A00FE;
	Wed,  6 Nov 2024 06:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="bZiU3vFw"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90E4192583;
	Wed,  6 Nov 2024 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730874550; cv=none; b=G51UVKQt+i2Rmz1GrI3pVZnyc1S54Sfay8zg0ukxBvvgssVievU57Hw43sHLu7j5Nqo9rfhoJAYl+V2mYJYrBUjGeN0diGmbC68NVNyY/8gha1h2d5H96gF+3NQApZyqlfCj/X25L7NEdteAkxUyuG5rYf4YtkKrnqTdYN3KKhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730874550; c=relaxed/simple;
	bh=bc7z2TrjPCemYNFXMKTXgqZ9s5+UAL9PCibzgFBB7FM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gQa2+1KnpwFeDt12Rl1kp8ln2t9qUvW3fO1LQnoNfwZYsYrQYn+rJ60EaOby++HNMLMxRS6qQymSY6aO1rWqS7mSN21h/gdd7XRChkKEB/+hAcRoNFahqs+Rm4Bud3AcJe6ofnQeV/YYU++rslr/gaHyUMA7Ym3hNxv9J8ViWUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=bZiU3vFw; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1730874539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6VQYF4EfyDGrmwUI4CX6ZEqHhlwwOz819w7ZIjm6cY=;
	b=bZiU3vFweT+js9yvjgn8q2+cUPtfCqqdgYzh7tAT4SX5AaOHyqZm93Z5P4VfJ3Lonf0O58
	ltpiroQhmyJSPw/h+pd7g2vT1fAMCGh2/47COxtSgrPFOuhmbHd112PK3ETvAVmZ1goivU
	NZiYvgeXmKNrWvUwim4H0NM1wmrdcw3zCAcOClS9E8IlbEHyqGPWTmiD6HjTzVsKn/3BlN
	r0c1Tg4YwevuDRcqj2mgMmdM4ULpQdE0POk9rq9vKxc+DGY04NIW3B5PxG5mA9gW59qlLj
	eIH3oSBRd5I3ZFVSk/8Yh9U7ELNYLxGGCPue8xQZJQYEHdZ+GQ3+LaPdTspbAQ==
To: apw@canonical.com,
	joe@perches.com,
	corbet@lwn.net
Cc: dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	workflows@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	wens@csie.org,
	dsimic@manjaro.org
Subject: [PATCH v2 1/3] checkpatch: Make Helped-by tag supported
Date: Wed,  6 Nov 2024 07:28:40 +0100
Message-Id: <0e1ef28710e3e49222c966f07958a9879fa4e903.1730874296.git.dsimic@manjaro.org>
In-Reply-To: <cover.1730874296.git.dsimic@manjaro.org>
References: <cover.1730874296.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Providing a Helped-by tag fits well to indicate someone had helped with the
development of a patch, to the level that still doesn't warrant providing
a Co-developed-by tag, but is much more than it would've been indicated by
providing a Suggested-by tag.  The Helped-by tag been already used recently
a few times in accepted patches. [1]

With all this in mind, let's have Helped-by supported in checkpatch.pl.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=Helped-by

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4427572b2477..b89e62e9c2dd 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -622,6 +622,7 @@ our $signature_tags = qr{(?xi:
 	Reviewed-by:|
 	Reported-by:|
 	Suggested-by:|
+	Helped-by:|
 	To:|
 	Cc:
 )};

