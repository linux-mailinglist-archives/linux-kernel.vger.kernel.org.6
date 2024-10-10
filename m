Return-Path: <linux-kernel+bounces-360178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A76999591
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 01:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4141F243A1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 23:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424081E7674;
	Thu, 10 Oct 2024 23:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="F+51F/1n"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAEC1E47CE;
	Thu, 10 Oct 2024 22:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728601200; cv=none; b=QruvRmfZSyr6KOM1gEl3lK5d8LgntYnlUyK4EYyw+ZKzrdJ3J3m80dk+V8yyqX8Z5VBsoFMiFSfX7B+m3fOEnZ2gcAHTxAxDmhHGpBr5uhGBCfPgA9NisH1aTbw7ZjPZxu7LXO3/2y0oSluiUtOUIxTqbtmhj+sn3ZX8sz3t7FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728601200; c=relaxed/simple;
	bh=30TjkUnFC9NWsJW4eTg9Q4PVPyQNuG5h8K9SFWoGZRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MkCe1UoLrIYNXvJ/D3ntXxpnMJR79xn69HOHjWAK8aaBsKpLJzFYlHMfzbOsKD+HMz1BWDXrMOlSK6oGjkNIyOCLhqER4uTu4j8hTwZyB+XWeo8GKSWxfSiVsvm58GDL4yAdhY45V+TJgH9mDYDV5OItHk1wl6gCmFtpnecsAtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=F+51F/1n; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LPu33S0orkaUAmkd+MSXAPtkkiO+jfzDP7G30SiOOEs=; b=F+51F/1nGFvJb79wRvZD4IJzTY
	6/tB0vDamr41QY4yZWSWiVcD1TpRI//pFhXk6e6juXCAJABFsk7P9xyqhSasQNUFvj4BpftjOlkBm
	X34UtnM4jFrFrVEiiZagAyQD+Ak5+UPoKYQ28W3xGH5jgvG1ZimcmwyHsEcqRUTTcr3xvyyWg83fJ
	mnccdhRlm/8tqTBNjemboibZR3C3gzl9/2jVmMLEwPpBL9xVCado6HpcA8Xp7wuVSsiBTLTLcHP5/
	o/i8zIh2U1BP+TucMlHvTLwIXmAe/mxcATNGLvvR9LYsCU3v73gwtpjbjOeiW3fnrPBYeHJikK8OI
	A/8fcG2A==;
Received: from [187.57.199.212] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sz28B-007W4G-SZ; Fri, 11 Oct 2024 00:59:40 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH] scripts/kernel-doc: Fix build time warnings
Date: Thu, 10 Oct 2024 19:59:33 -0300
Message-ID: <20241010225933.166436-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As stated at Documentation/kbuild/llvm.rst, to make usage of ccache one
must set KBUILD_BUILD_TIMESTAMP=''. Setting this together with W=1
will trigger the following warning for every compiled file:

  date: invalid date ‘+%s’

This comes from kernel-doc script, that produces the following command
when KBUILD_BUILD_TIMESTAMP is empty:

  date -d"" +%s

That triggers the warning above. Add a space between the flag `-d` and
the string argument to fix date command and remove the warning.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 scripts/kernel-doc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 2791f8195203..8728f9824c65 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -160,7 +160,7 @@ my @export_file_list;
 
 my @build_time;
 if (defined($ENV{'KBUILD_BUILD_TIMESTAMP'}) &&
-    (my $seconds = `date -d"${ENV{'KBUILD_BUILD_TIMESTAMP'}}" +%s`) ne '') {
+    (my $seconds = `date -d "${ENV{'KBUILD_BUILD_TIMESTAMP'}}" +%s`) ne '') {
     @build_time = gmtime($seconds);
 } else {
     @build_time = localtime;
-- 
2.47.0


