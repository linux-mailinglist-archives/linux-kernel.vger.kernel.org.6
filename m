Return-Path: <linux-kernel+bounces-397376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B7D9BDB2B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0911C2197F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A02C188A18;
	Wed,  6 Nov 2024 01:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="JdwMvU1H"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C927E10E5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 01:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730856527; cv=none; b=QrM0mMPPt0FE+J9jD2lRVLJuGxyl35yeqe7LCcqq7FvWGEivB0ugIl1VHanvuouPa8L7OCXQh1kSD9VZ07MO7F6goSJglQofS4/nv2HMfERV9fLZNLDIVJoZuveL5o6ut9IljReeKpJxYBwWlb6teEn71n44in4TdJAgpV5dv0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730856527; c=relaxed/simple;
	bh=rAZBrqVxyNiwHW60FqsLHMyDxGagk0WGZ9OktAHc1PA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mrNALbGjljIO9zjZP6RqQMdXuL9FSei17QJFqjn4daGtYuaFN4otJx4sOPmEiZpEoOCVYrEHyZxMXXXhMuE4hlNitpruJ0xVMMIMzLMs95HnL9w6TUYFyzxVlKUiZs+oPeUWf8+Ug0YeGdm9einj5CRQ4x2CksK2USJyur+/PyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=JdwMvU1H; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f53973fdso331260e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 17:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1730856524; x=1731461324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pBdZka9S9d5i0QtaIx7xeSLqToW1qAOEU2js9aAaPKo=;
        b=JdwMvU1HXSGBxfGttSBY2o5+cOxmTy5n2GQWxrLfMi7uIuX6EJ3W8OqEMrZYabQJfy
         xhKzuoY0EMXU3Xg4UCoRsIBRpc9WXwZ3yNOnGTjVEoqnx7g5b5XY0Ij6RDPjmcsGl5Sn
         mueKsrm/NdE5hLsk7mdG6+MlTgt5hGi8YV2m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730856524; x=1731461324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBdZka9S9d5i0QtaIx7xeSLqToW1qAOEU2js9aAaPKo=;
        b=aaM0UpogLx8gOiqzbqk6q3IlUs7KDw45bDKpokPrVtOWnU+M26Z0y3qGxrWuZwzxek
         z+MDGRA4DwKOmZfKV4BYubfxWYnOAoGkIv42TXtRTCX9NfCadOF3nd8R73N5tzf1xxQO
         d9ccfvcCrk6cCIu3EJ0+itllB20RrhIJgqxucIhDJ1yTRRUadVLQIik53Ke8+b3V/6ha
         GKsdC42AkR1zSKoiQBnsdu2jmgyqfuSBicrTgQLU2s9qKn1K5B25ww1q19y5KDFVK/qI
         IubZk3DQqqLFdNrGiOzJH8GD8u8ijHCFluK3BD8azjNlQTSyUcDYj6TCS0uK8DUfAwvE
         bL+Q==
X-Gm-Message-State: AOJu0YzPPinNjsznOUm8UAoO66pmSWrTKXKTQ47yTETLzjwYSkzB+tGZ
	bh6J0HrlF4P8iGy1w/jYuS4PZyCbWNQtfuXczRH/PzOiWZnZsLJZJFDbxVP9Eqakldp5BrrE4gx
	RptU=
X-Google-Smtp-Source: AGHT+IFzrIGfp9u9ev8VFgr6Br2JbH4dP0eP1KIjuDzVZTP+7Jbzjd0rKBIhI9XrLaQpdJTUhZCjOw==
X-Received: by 2002:a05:6512:4023:b0:539:edc9:7400 with SMTP id 2adb3069b0e04-53d7cffed8amr244899e87.20.1730856523685;
        Tue, 05 Nov 2024 17:28:43 -0800 (PST)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bcccedcsm2297925e87.177.2024.11.05.17.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 17:28:43 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] setlocalversion: work around "git describe" performance
Date: Wed,  6 Nov 2024 02:28:38 +0100
Message-ID: <20241106012838.435040-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Contrary to expectations, passing a single candidate tag to "git
describe" is slower than not passing any --match options.

  $ time git describe --debug
  ...
  traversed 10619 commits
  ...
  v6.12-rc5-63-g0fc810ae3ae1

  real    0m0.169s

  $ time git describe --match=v6.12-rc5 --debug
  ...
  traversed 1310024 commits
  v6.12-rc5-63-g0fc810ae3ae1

  real    0m1.281s

In fact, the --debug output shows that git traverses all or most of
history. For some repositories and/or git versions, those 1.3s are
actually 10-15 seconds.

This has been acknowledged as a performance bug in git [1]. However,
no solution is yet in git.git, and even when one lands, it will take
quite a while before it finds its way to a release and for
$random_kernel_developer to pick that up.

So rewrite the logic to use plumbing commands. For each of the
candidate values of $tag, we ask: (1) is $tag even an annotated
tag? (2) Is it eligible to describe HEAD, i.e. an ancestor of
HEAD? (3) If so, how many commits are in $tag..HEAD?

I have tested that this produces the same output as the current script
for ~700 random commits between v6.9..v6.10. For those 700 commits,
and in my git repo, the 'make -s kernelrelease' command is on average
~4 times faster.

[1] https://lore.kernel.org/git/20241101113910.GA2301440@coredump.intra.peff.net/

Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Josh, does this work for you?

 scripts/setlocalversion | 53 ++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 38b96c6797f4..91d638234d57 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -30,6 +30,26 @@ if test $# -gt 0 -o ! -d "$srctree"; then
 	usage
 fi
 
+try_tag() {
+	tag="$1"
+
+	# Is $tag an annotated tag?
+	[ "$(git cat-file -t "$tag" 2> /dev/null)" = "tag" ] || return 1
+
+	# Is it an ancestor of HEAD, and if so, how many commits are in $tag..HEAD?
+	read left right <<EOF || return 1
+$(git rev-list --count --left-right "$tag"...HEAD 2> /dev/null)
+EOF
+
+	# $left is 0 if and only if $tag is an ancestor of HEAD
+	[ "$left" -eq 0 ] || return 1
+
+	# $right is the number of commits in the range $tag..HEAD, possibly 0.
+	count="$right"
+
+	return 0
+}
+
 scm_version()
 {
 	local short=false
@@ -61,33 +81,33 @@ scm_version()
 	# stable kernel:    6.1.7      ->  v6.1.7
 	version_tag=v$(echo "${KERNELVERSION}" | sed -E 's/^([0-9]+\.[0-9]+)\.0(.*)$/\1\2/')
 
+	# try_tag initializes count if the tag is usable.
+	count=
+
 	# If a localversion* file exists, and the corresponding
 	# annotated tag exists and is an ancestor of HEAD, use
 	# it. This is the case in linux-next.
-	tag=${file_localversion#-}
-	desc=
-	if [ -n "${tag}" ]; then
-		desc=$(git describe --match=$tag 2>/dev/null)
+	if [ -n "${file_localversion#-}" ] ; then
+		try_tag "${file_localversion#-}"
 	fi
 
 	# Otherwise, if a localversion* file exists, and the tag
 	# obtained by appending it to the tag derived from
 	# KERNELVERSION exists and is an ancestor of HEAD, use
 	# it. This is e.g. the case in linux-rt.
-	if [ -z "${desc}" ] && [ -n "${file_localversion}" ]; then
-		tag="${version_tag}${file_localversion}"
-		desc=$(git describe --match=$tag 2>/dev/null)
+	if [ -z "${count}" ] && [ -n "${file_localversion}" ]; then
+		try_tag "${version_tag}${file_localversion}"
 	fi
 
 	# Otherwise, default to the annotated tag derived from KERNELVERSION.
-	if [ -z "${desc}" ]; then
-		tag="${version_tag}"
-		desc=$(git describe --match=$tag 2>/dev/null)
+	if [ -z "${count}" ]; then
+		try_tag "${version_tag}"
 	fi
 
-	# If we are at the tagged commit, we ignore it because the version is
-	# well-defined.
-	if [ "${tag}" != "${desc}" ]; then
+	# If we are at the tagged commit, we ignore it because the
+	# version is well-defined. If none of the attempted tags exist
+	# or were usable, $count is still empty.
+	if [ -z "${count}" ] || [ "${count}" -gt 0 ]; then
 
 		# If only the short version is requested, don't bother
 		# running further git commands
@@ -95,14 +115,15 @@ scm_version()
 			echo "+"
 			return
 		fi
+
 		# If we are past the tagged commit, we pretty print it.
 		# (like 6.1.0-14595-g292a089d78d3)
-		if [ -n "${desc}" ]; then
-			echo "${desc}" | awk -F- '{printf("-%05d", $(NF-1))}'
+		if [ -n "${count}" ]; then
+			printf "%s%05d" "-" "${count}"
 		fi
 
 		# Add -g and exactly 12 hex chars.
-		printf '%s%s' -g "$(echo $head | cut -c1-12)"
+		printf '%s%.12s' -g "$head"
 	fi
 
 	if ${no_dirty}; then
-- 
2.47.0


