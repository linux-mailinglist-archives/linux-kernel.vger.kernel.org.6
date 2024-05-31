Return-Path: <linux-kernel+bounces-196341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5508D5A74
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3A02835CF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73D97F7D5;
	Fri, 31 May 2024 06:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=danishpraka.sh header.i=@danishpraka.sh header.b="PEm6Wu8y"
Received: from out-06.pe-b.jellyfish.systems (out-06.pe-b.jellyfish.systems [198.54.127.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EBE7F483;
	Fri, 31 May 2024 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717136406; cv=none; b=UiTs3dRUMekkclp39qz3kY0DvksamAQUTTfI42N7BAovfT/WdGzXOi2ZMK305yu4ZTZBebhPrLlPrxx1JNYTCbD1k7JwQpdJYTydy8uqK2Z7JHnij1tCoigtC/XaI+7ZKsoohPUrlX7BmmSey0cEWTx61x9w9YP7Aw/X+PrQjXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717136406; c=relaxed/simple;
	bh=2iZUbMs4Le2i9kPGbGkkXd46wq54CuJ1IfgZTgoXtls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h9H3swUrkkyHVGyoBwNJon5NVuez6uyiZqc8OWy1gWatOEBIauMT/8C17lDr0cm8uJPGV8jvvsw0YssnicTso2KrS5LZl0Y6g0HxhQju571qgNpKVOVSF3tY1HtGYe24TmOb7Vc+v3kRP8UyKZygRgBmVL39JFXbAJdJeUyvC6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danishpraka.sh; spf=pass smtp.mailfrom=danishpraka.sh; dkim=fail (0-bit key) header.d=danishpraka.sh header.i=@danishpraka.sh header.b=PEm6Wu8y reason="key not found in DNS"; arc=none smtp.client-ip=198.54.127.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danishpraka.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danishpraka.sh
Received: from output-router-d5c465c44-45n78 (new-01.privateemail.com [198.54.118.220])
	by pe-b.jellyfish.systems (Postfix) with ESMTPA id 4VrCdv6QNkzFphv;
	Fri, 31 May 2024 06:20:03 +0000 (UTC)
Received: from MTA-05.privateemail.com (unknown [10.50.14.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01.privateemail.com (Postfix) with ESMTPS id D041618000D3;
	Fri, 31 May 2024 02:20:03 -0400 (EDT)
Received: from mta-05.privateemail.com (localhost [127.0.0.1])
	by mta-05.privateemail.com (Postfix) with ESMTP id A10421800180;
	Fri, 31 May 2024 02:20:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=danishpraka.sh;
	s=default; t=1717136403;
	bh=2iZUbMs4Le2i9kPGbGkkXd46wq54CuJ1IfgZTgoXtls=;
	h=From:To:Cc:Subject:Date:From;
	b=PEm6Wu8yMEmcaTKq+IIbxA6umS37NaUdkJt4aj/ds/OqgzTjdGPgEuMjJVPM40BEx
	 a7Go5K3qjgy7i6pdVXWZRC4P5t3fttsQ+Cex0BvO+r87KQh7SBTh87vVmvdTqXfToy
	 eKfEfpo8IglF9Jbv4eFG0eUeYIDy66cKzYyYDLO8rzPG2cZHEUwYatfwRlPPfERACb
	 cWknY6KQHYj5fkdzaNsrq8aBXS0ijiPzrA1FDY99xH/xP8TPHefMHsK+xEyKVjgn3j
	 UQQy5PtZtvyVkFm+XA4rffxNMNr/cE0+otgnn174sV5b/2P3jJPvHsXLLJP4C4CgMR
	 mojf8NcDJaGzg==
Received: from localhost.localdomain (unknown [106.196.30.82])
	by mta-05.privateemail.com (Postfix) with ESMTPA;
	Fri, 31 May 2024 02:19:55 -0400 (EDT)
From: Danish Prakash <contact@danishpraka.sh>
To: 
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Danish Prakash <contact@danishpraka.sh>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] scripts/sphinx-pre-install: fix incorrect package names for openSUSE
Date: Fri, 31 May 2024 11:49:15 +0530
Message-ID: <20240531061941.9607-1-contact@danishpraka.sh>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

openSUSE made some changes to python package names in the recent
past and hence the current information on installing the relevant
doc-related packages yields no output when run on openSUSE distros.
Update the package names to the correct ones.

Signed-off-by: Danish Prakash <contact@danishpraka.sh>
---
 scripts/sphinx-pre-install | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index c1121f098542..56bda8b43a44 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -465,8 +465,8 @@ sub give_redhat_hints()
 sub give_opensuse_hints()
 {
 	my %map = (
-		"python-sphinx"		=> "python3-sphinx",
-		"yaml"			=> "python3-pyyaml",
+		"python-sphinx"		=> "python3-Sphinx",
+		"yaml"			=> "python3-pyaml",
 		"virtualenv"		=> "python3-virtualenv",
 		"dot"			=> "graphviz",
 		"convert"		=> "ImageMagick",
-- 
2.45.1


