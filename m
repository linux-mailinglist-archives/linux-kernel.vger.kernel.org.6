Return-Path: <linux-kernel+bounces-406739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5342C9C630D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94041F247F8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2964821A4C3;
	Tue, 12 Nov 2024 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="P4k1jOqj"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469CF20BB4B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731445499; cv=none; b=Jyzqi+1/d9IA02sEdVCK6S/CA7yhCCnt8AiZpgVSTfjJdnTIjfXCXIyEQydFlQ/aPW6FRpPCKia3jri07cQaeYy6JxXOiIzdWgJC2lOWGuWTdezldJW3hHSLgX+bO47h5GceDhjGsWSqOeUH7imTbh3PuWPOoBtgZo/1PUDGsCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731445499; c=relaxed/simple;
	bh=FoS6mKJ4QYEkCPVvnFJ7XziCjZTMJd6wKkNqNuTngdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ouQRehI/jVnmUdcCE/SJFdiGL53JRPVj7puwiknfjUSGVoY8r/cf4T2NqznYG+9NP4xSgySIXgxbst56yjOijfmfCedumbGkbCLUtoMHiNfEsuaz6nEpqRLfX/hWwSex8lrbyoq2D7ewxSak73yPJfNiGvxld+gmbLvUfLknqz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=P4k1jOqj; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99f646ff1bso920715466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 13:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1731445495; x=1732050295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B4tt3FPTBKGUI9N/u9zyu/Mn7wKwRgvQ0xoN5SDOL+0=;
        b=P4k1jOqjQSZBDEomzGLSqTxTWSmSaRJGLKUqjDkp4zPb88VEbrkC0xx0zoSen6zGDr
         U8Gy5pIHZIw6Ni2QviwRcOyAeI9P/IvaKoY+YvQJqgjb+lWNT3QkWfSnm1Yd3fXylA6X
         sW80LGsK7szQ4rEKXURxxH43KTzGE+r4f+1JU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731445495; x=1732050295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4tt3FPTBKGUI9N/u9zyu/Mn7wKwRgvQ0xoN5SDOL+0=;
        b=iYm6nS5NM/5UM5vS4R9e6fM73hDSd6SB2u07SIBiOgs3CAaLhitLrzBBdskYAOR/qs
         1HVpN6v/lAZJKJEBArO1Jkh6bPqrLr2Ui2MDns/9Myl4+30sBfSQv+9Pmu1eLuCJ5tX1
         S6Pe2WiIYoVLYxYstNbmby/5phwy7hR9cUw8CVRx8F9OriqBb/ujv1Zr1eVwz4y3SUWY
         csKZBy+lTsfO9JiekmKQV9g8hKHFcVIG2We29TFQSBXB/UE+uWHCZSB8pKqFIi415ruT
         vMupqJQPubseiveU/Q/70/wq7VbcBnwHl73eXDrDC6+ZdRR6VrcnXXcumDrACr6txFD8
         6urg==
X-Gm-Message-State: AOJu0Yxb4IffpMdEtUNe55yAwntXxNPXW3ejwHucoWijY4B4oIdmzNSI
	ZmR/YfU6Y1z3Em8qHqSUiQUp6NDtvnhC1qlAKWAWAiID8ymuzGOv460PmQcs9Ag=
X-Google-Smtp-Source: AGHT+IFAth2VPwPjh+p8is6GciMPk9cenlRwc3eBPnOWrQMwlg3eG8DP58S5jEhpIwUF8emf9eP5yQ==
X-Received: by 2002:a17:907:5ca:b0:a99:374e:f3cb with SMTP id a640c23a62f3a-aa1c57ae760mr358957266b.46.1731445495232;
        Tue, 12 Nov 2024 13:04:55 -0800 (PST)
Received: from localhost (77.33.185.121.dhcp.fibianet.dk. [77.33.185.121])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a17635sm766028966b.17.2024.11.12.13.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 13:04:54 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2] setlocalversion: work around "git describe" performance
Date: Tue, 12 Nov 2024 22:05:00 +0100
Message-ID: <20241112210500.2266762-1-linux@rasmusvillemoes.dk>
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

This has been acknowledged as a performance bug in git [1], and a fix
is on its way [2]. However, no solution is yet in git.git, and even
when one lands, it will take quite a while before it finds its way to
a release and for $random_kernel_developer to pick that up.

So rewrite the logic to use plumbing commands. For each of the
candidate values of $tag, we ask: (1) is $tag even an annotated
tag? (2) Is it eligible to describe HEAD, i.e. an ancestor of
HEAD? (3) If so, how many commits are in $tag..HEAD?

I have tested that this produces the same output as the current script
for ~700 random commits between v6.9..v6.10. For those 700 commits,
and in my git repo, the 'make -s kernelrelease' command is on average
~4 times faster with this patch applied (geometric mean of ratios).

For the commit mentioned in Josh's original report [3], the
time-consuming part of setlocalversion goes from

$ time git describe --match=v6.12-rc5 c1e939a21eb1
v6.12-rc5-44-gc1e939a21eb1

real    0m1.210s

to

$ time git rev-list --count --left-right v6.12-rc5..c1e939a21eb1
0       44

real    0m0.037s

[1] https://lore.kernel.org/git/20241101113910.GA2301440@coredump.intra.peff.net/
[2] https://lore.kernel.org/git/20241106192236.GC880133@coredump.intra.peff.net/
[3] https://lore.kernel.org/lkml/309549cafdcfe50c4fceac3263220cc3d8b109b2.1730337435.git.jpoimboe@kernel.org/

Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---

v2: Drop odd here-doc, use "set -- $()" instead. Update commit log to
mention the git.git patches in flight.

 scripts/setlocalversion | 53 ++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 38b96c6797f4..1e3b01ec096c 100755
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
+	set -- $(git rev-list --count --left-right "$tag"...HEAD 2> /dev/null)
+
+	# $1 is 0 if and only if $tag is an ancestor of HEAD. Use
+	# string comparison, because $1 is empty if the 'git rev-list'
+	# command somehow failed.
+	[ "$1" = 0 ] || return 1
+
+	# $2 is the number of commits in the range $tag..HEAD, possibly 0.
+	count="$2"
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


