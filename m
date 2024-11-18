Return-Path: <linux-kernel+bounces-412798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CA69D0F94
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65601B2AC1C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAE1194A64;
	Mon, 18 Nov 2024 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="EJ4wYrli"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A35B194A63
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731927716; cv=none; b=gosM+ORt8kVoEKXDmiIlhLifo+NNkzoR0h5sI5kgDM3isUxOFrnruSeQH4o+44i1WoEC7AlacBVK269+p5n/B6xSy2OFHbNcsX5Vn4nNi5MdZkU+FmmAY//qfQlcqiNmPtMG22JJWokbLqPzyNJ6AS2j7SB1Ltgrwvw2rkUXirk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731927716; c=relaxed/simple;
	bh=/mmqxQIIBTKJU95znxubYAuwPz0Pj4FHpPgJoJZHwCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jAudbNHm+qAbAyo01eWAe7GUduT1U7pjTNp305pF8OiHIm4p/N/MeceQxCO6kifYfEPJr4TRh2tOxQYxaYIAIiYfFcZAJcymVYrqm+H+3QENCLBv0i3D7yncwl7XBLfe+4Bz02UDSkBsIybETrWlocboExXDcDesPY8zO9/0wqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=EJ4wYrli; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f84907caso4331164e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 03:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1731927712; x=1732532512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VabMAuGwTL06yr3ViS1JrPQ2en669i6+uOZedAFhYnI=;
        b=EJ4wYrliARRMA9vf5VRfq+mQ7mJfO7dPii/EvPtdP5V1Jojq/jfrHuSZE/p8qOCh22
         wu4erEmeP+vDvwk5+qB+6CtFeB9fSO5WTg0P9qG3UyviITqjpBqOldF2qujkX7AdiwoL
         OsKqczgD9stEXmEKcbyP1J13pn7ePgAWdIabs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731927712; x=1732532512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VabMAuGwTL06yr3ViS1JrPQ2en669i6+uOZedAFhYnI=;
        b=v1sCd27gQD2olLdpR5gzrPCTCZ499Xgoajbhf7zbxyRFVvdUjLhWLV/i7UQzjBMtNl
         woSfZjC6/MW1B8UhgzSFA7c7jiGgIj794EnmZpREGydLanMJBqJAyiwgMCQOPxpAEAK+
         H29qAKaq4SD6QvCi+hS8mvsZSn0HgwAl6UFcPo4gyf+Eb9qISH2SCdbhdb3z4iZokqNy
         NbL+hnaCJSE+AJZTFco3EQFIttPvhw7UIMSKJv0mMhJSv8qPAHPq0PXuSRmbaqLtAJII
         5Z1pnPTEp5pLkT7jukLO/Lzv/kj9qSJ/GP1vwuXFyZGILd+wiXw4REYt3RL+qeqQ40Tm
         pRFg==
X-Gm-Message-State: AOJu0YxeRd0/xx3xDVXwMRwZUWRP3cQjl4RTw7vlpoDoqq6ax0RNsvTT
	fs5Ri4BtxgSzaPWk18+cWcCkPOT8Qna5ieGDdVNIs7VOzOEeYzbKkD1QXwopy2PqZPUWEKwsmVq
	pw00=
X-Google-Smtp-Source: AGHT+IHGEQGWW6igmzapud9eLSNtzJT0ArhpXDj23UyLyIJqeURWIy0rpxNdqZ1XisNIQLlwCcH+vg==
X-Received: by 2002:a2e:bc05:0:b0:2fa:dadf:aad5 with SMTP id 38308e7fff4ca-2ff609b4c03mr60813561fa.28.1731927711949;
        Mon, 18 Nov 2024 03:01:51 -0800 (PST)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff69ae80fesm9176091fa.89.2024.11.18.03.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 03:01:51 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sean Christopherson <seanjc@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH v3] setlocalversion: work around "git describe" performance
Date: Mon, 18 Nov 2024 12:01:54 +0100
Message-ID: <20241118110154.3711777-1-linux@rasmusvillemoes.dk>
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

Reported-by: Sean Christopherson <seanjc@google.com>
Closes: https://lore.kernel.org/lkml/ZPtlxmdIJXOe0sEy@google.com/
Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
Tested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Closes: https://lore.kernel.org/lkml/309549cafdcfe50c4fceac3263220cc3d8b109b2.1730337435.git.jpoimboe@kernel.org/
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
v3:

- Update trailer tag list, per Masahiro.
- Drop redundant quoutes around the word tag
- Add a shellcheck disable directive

Masahiro, I decided to keep the changes minimal, in particular not to
change anything around the logic or the (unused) return values, in
order not to invalidate Josh' T-b tag. I think it's more important for
this to make it to 6.13-rc1 (if that is even still possible, given
that the MW is already open).

Since you mentioned shellcheck, which I myself am a big fan of, I
added a directive in the new code, but didn't want to try to make the
whole script shellcheck clean. But I don't know if we want such linter
directives; if not, feel free to just remove that line.

v2: https://lore.kernel.org/lkml/20241112210500.2266762-1-linux@rasmusvillemoes.dk/


 scripts/setlocalversion | 54 +++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 38b96c6797f4..5818465abba9 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -30,6 +30,27 @@ if test $# -gt 0 -o ! -d "$srctree"; then
 	usage
 fi
 
+try_tag() {
+	tag="$1"
+
+	# Is $tag an annotated tag?
+	[ "$(git cat-file -t "$tag" 2> /dev/null)" = tag ] || return 1
+
+	# Is it an ancestor of HEAD, and if so, how many commits are in $tag..HEAD?
+	# shellcheck disable=SC2046 # word splitting is the point here
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
@@ -61,33 +82,33 @@ scm_version()
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
@@ -95,14 +116,15 @@ scm_version()
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


