Return-Path: <linux-kernel+bounces-433865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B209E5E22
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0AF2886DD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D83F229B3B;
	Thu,  5 Dec 2024 18:17:02 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA93E224AFE
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733422621; cv=none; b=V3OYkrUZeZen8WJgpx3HMBjicwGwPlmBq89dmMFaVDnSDlYy0f2FBfaW2UTqFJQ8Txkr3AhK5YMc36k1yWN1EMAY3OInJi+SGkWVfW0VuObaKfeYYhTSDOv6eb7KpFG9m+l3apuPJ6jeevdm11WMLuzS3tX1zZ8kwcDINsda0sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733422621; c=relaxed/simple;
	bh=war1YBA12ktdBAB8QK/R71NCwgWsaH853s9u8/FO7Ug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mRWwtPtggbp0mIaNBZ8+FeQ1NC6W0ApgzAMqcA1X+i5z2QqaKPjzZf0tzVrtaPx3ubhm6CXz/3JH5DmhMXNa2Ops3HnduwOB+PnnF5pRJJuSBUPrtrKmjX67/0tmXsZ+AJIp9ZSn0hEL9jrxZ/+pEghsDFyOeMFKH8vbQLb3uNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b16a:6561:fa1:2b32])
	by albert.telenet-ops.be with cmsmtp
	id l6Gf2D00C3EEtj2066GftB; Thu, 05 Dec 2024 19:16:47 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tJGP0-000LwZ-AJ;
	Thu, 05 Dec 2024 19:16:39 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tJGP1-00EUTW-1t;
	Thu, 05 Dec 2024 19:16:39 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Andy Whitcroft <apw@canonical.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
	Simon Horman <horms@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/2] Increase minimum git commit ID abbreviation to 16 characters
Date: Thu,  5 Dec 2024 19:16:35 +0100
Message-Id: <46b320b91b8d86fade3c1b1c72ef94da85b45d0d.1733421037.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733421037.git.geert+renesas@glider.be>
References: <cover.1733421037.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of v6.13-rc1, a git repository with all upstream and stable versions
of the Linux kernel sources contains more than 13 million objects.
Local development trees contain many more, approaching or surpassing
sqrt(16^12) = 16777216 objects.

Hence according to the Birthday Paradox, collisions of 12-chararacter
git commit IDs are imminent, or already happening.  Indeed, patches with
13-character Fixes-tags have already been seen in the wild, due to git
automatically increasing the size of the abbreviation when needed.
Note that this need is based on the current repository of the creator,
not on the (future) repository of the receiver.

Decrease the probability of collisions by increasing the recommended
minimum number of characters from 12 to 16.  Update the guidelines and
the examples in the documentation, and all checks in the checkpatch.pl
script.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 Documentation/dev-tools/checkpatch.rst        |  2 +-
 Documentation/doc-guide/sphinx.rst            |  4 +--
 Documentation/process/5.Posting.rst           |  2 +-
 .../process/handling-regressions.rst          |  6 ++--
 Documentation/process/maintainer-tip.rst      |  6 ++--
 Documentation/process/submitting-patches.rst  | 12 ++++----
 scripts/checkpatch.pl                         | 28 +++++++++----------
 7 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index abb3ff6820766ee0..592812c6eabad43a 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -599,7 +599,7 @@ Commit message
 
   **GIT_COMMIT_ID**
     The proper way to reference a commit id is:
-    commit <12+ chars of sha1> ("<title line>")
+    commit <16+ chars of sha1> ("<title line>")
 
     An example may be::
 
diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index 8081ebfe48bc045f..7e4ea14686e107be 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -441,8 +441,8 @@ Referencing commits
 References to git commits are automatically hyperlinked given that they are
 written in one of these formats::
 
-    commit 72bf4f1767f0
-    commit 72bf4f1767f0 ("net: do not leave an empty skb in write queue")
+    commit 72bf4f1767f03869
+    commit 72bf4f1767f03869 ("net: do not leave an empty skb in write queue")
 
 .. _sphinx_kfigure:
 
diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
index b3eff03ea2491c88..d396d0f051b9c1e3 100644
--- a/Documentation/process/5.Posting.rst
+++ b/Documentation/process/5.Posting.rst
@@ -199,7 +199,7 @@ document; what follows here is a brief summary.
 One tag is used to refer to earlier commits which introduced problems fixed by
 the patch::
 
-	Fixes: 1f2e3d4c5b6a ("The first line of the commit specified by the first 12 characters of its SHA-1 ID")
+	Fixes: 1f2e3d4c5b6a7980 ("The first line of the commit specified by the first 16 characters of its SHA-1 ID")
 
 Another tag is used for linking web pages with additional backgrounds or
 details, for example an earlier discussion which leads to the patch or a
diff --git a/Documentation/process/handling-regressions.rst b/Documentation/process/handling-regressions.rst
index 1f5ab49c48a480d2..cde4c663b379f567 100644
--- a/Documentation/process/handling-regressions.rst
+++ b/Documentation/process/handling-regressions.rst
@@ -31,7 +31,7 @@ The important bits (aka "The TL;DR")
       list in CC) containing a paragraph like the following, which tells regzbot
       when the issue started to happen::
 
-       #regzbot ^introduced: 1f2e3d4c5b6a
+       #regzbot ^introduced: 1f2e3d4c5b6a7980
 
     * When forwarding reports from a bug tracker to the regressions list (see
       above), include a paragraph like the following::
@@ -82,7 +82,7 @@ When doing either, consider making the Linux kernel regression tracking bot
 "regzbot" immediately start tracking the issue:
 
  * For mailed reports, check if the reporter included a "regzbot command" like
-   ``#regzbot introduced: 1f2e3d4c5b6a``. If not, send a reply (with the
+   ``#regzbot introduced: 1f2e3d4c5b6a7980``. If not, send a reply (with the
    regressions list in CC) with a paragraph like the following:::
 
        #regzbot ^introduced: v5.13..v5.14-rc1
@@ -100,7 +100,7 @@ When doing either, consider making the Linux kernel regression tracking bot
  * When forwarding a regression reported to a bug tracker, include a paragraph
    with these regzbot commands::
 
-       #regzbot introduced: 1f2e3d4c5b6a
+       #regzbot introduced: 1f2e3d4c5b6a7980
        #regzbot from: Some N. Ice Human <some.human@example.com>
        #regzbot monitor: http://some.bugtracker.example.com/ticket?id=123456789
 
diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
index 41d5855700cd4f83..12edc8e06367e3f3 100644
--- a/Documentation/process/maintainer-tip.rst
+++ b/Documentation/process/maintainer-tip.rst
@@ -270,7 +270,7 @@ Ordering of commit tags
 To have a uniform view of the commit tags, the tip maintainers use the
 following tag ordering scheme:
 
- - Fixes: 12+char-SHA1 ("sub/sys: Original subject line")
+ - Fixes: 16+char-SHA1 ("sub/sys: Original subject line")
 
    A Fixes tag should be added even for changes which do not need to be
    backported to stable kernels, i.e. when addressing a recently introduced
@@ -284,7 +284,7 @@ following tag ordering scheme:
 
      Commit
 
-       abcdef012345678 ("x86/xxx: Replace foo with bar")
+       abcdef0123456789 ("x86/xxx: Replace foo with bar")
 
      left an unused instance of variable foo around. Remove it.
 
@@ -295,7 +295,7 @@ following tag ordering scheme:
      The recent replacement of foo with bar left an unused instance of
      variable foo around. Remove it.
 
-     Fixes: abcdef012345678 ("x86/xxx: Replace foo with bar")
+     Fixes: abcdef0123456789 ("x86/xxx: Replace foo with bar")
      Signed-off-by: J.Dev <j.dev@mail>
 
    The latter puts the information about the patch into the focus and
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index f3508b5aa4ebab96..4c8e0f9c8fbbd83c 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -106,7 +106,7 @@ Example::
 	platform_set_drvdata(), but left the variable "dev" unused,
 	delete it.
 
-You should also be sure to use at least the first twelve characters of the
+You should also be sure to use at least the first sixteen characters of the
 SHA-1 ID.  The kernel repository holds a *lot* of objects, making
 collisions with shorter IDs a real possibility.  Bear in mind that, even if
 there is no collision with your six-character ID now, that condition may
@@ -143,25 +143,25 @@ also track such tags and take certain actions. Private bug trackers and
 invalid URLs are forbidden.
 
 If your patch fixes a bug in a specific commit, e.g. you found an issue using
-``git bisect``, please use the 'Fixes:' tag with at least the first 12
+``git bisect``, please use the 'Fixes:' tag with at least the first 16
 characters of the SHA-1 ID, and the one line summary.  Do not split the tag
 across multiple lines, tags are exempt from the "wrap at 75 columns" rule in
 order to simplify parsing scripts.  For example::
 
-	Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
+	Fixes: 54a4f0239f2e98bc ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
 
 The following ``git config`` settings can be used to add a pretty format for
 outputting the above style in the ``git log`` or ``git show`` commands::
 
 	[core]
-		abbrev = 12
+		abbrev = 16
 	[pretty]
 		fixes = Fixes: %h (\"%s\")
 
 An example call::
 
-	$ git log -1 --pretty=fixes 54a4f0239f2e
-	Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
+	$ git log -1 --pretty=fixes 54a4f0239f2e98bc
+	Fixes: 54a4f0239f2e98bc ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
 
 .. _split_changes:
 
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5b57f0306a50046d..80cde0aa1a3115e9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1246,13 +1246,13 @@ sub git_commit_info {
 #		git rev-list --remotes | grep -i "^$1" |
 #		while read line ; do
 #		    git log --format='%H %s' -1 $line |
-#		    echo "commit $(cut -c 1-12,41-)"
+#		    echo "commit $(cut -c 1-16,41-)"
 #		done
 	} elsif ($lines[0] =~ /^fatal: ambiguous argument '$commit': unknown revision or path not in the working tree\./ ||
 		 $lines[0] =~ /^fatal: bad object $commit/) {
 		$id = undef;
 	} else {
-		$id = substr($lines[0], 0, 12);
+		$id = substr($lines[0], 0, 16);
 		$desc = substr($lines[0], 41);
 	}
 
@@ -1320,7 +1320,7 @@ for my $filename (@ARGV) {
 	if ($filename eq '-') {
 		$vname = 'Your patch';
 	} elsif ($git) {
-		$vname = "Commit " . substr($filename, 0, 12) . ' ("' . $git_commits{$filename} . '")';
+		$vname = "Commit " . substr($filename, 0, 16) . ' ("' . $git_commits{$filename} . '")';
 	} else {
 		$vname = $filename;
 	}
@@ -3230,17 +3230,17 @@ sub process {
 			my $tag_case = not ($tag eq "Fixes:");
 			my $tag_space = not ($line =~ /^fixes:? [0-9a-f]{5,40} ($balanced_parens)/i);
 
-			my $id_length = not ($orig_commit =~ /^[0-9a-f]{12,40}$/i);
+			my $id_length = not ($orig_commit =~ /^[0-9a-f]{16,40}$/i);
 			my $id_case = not ($orig_commit !~ /[A-F]/);
 
-			my $id = "0123456789ab";
+			my $id = "0123456789abcdef";
 			my ($cid, $ctitle) = git_commit_info($orig_commit, $id,
 							     $title);
 
 			if ($ctitle ne $title || $tag_case || $tag_space ||
 			    $id_length || $id_case || !$title_has_quotes) {
 				if (WARN("BAD_FIXES_TAG",
-				     "Please use correct Fixes: style 'Fixes: <12+ chars of sha1> (\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr) &&
+				     "Please use correct Fixes: style 'Fixes: <16+ chars of sha1> (\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr) &&
 				    $fix) {
 					$fixed[$fixlinenr] = "Fixes: $cid (\"$ctitle\")";
 				}
@@ -3330,7 +3330,7 @@ sub process {
 
 # Check for git id commit length and improperly formed commit descriptions
 # A correctly formed commit description is:
-#    commit <SHA-1 hash length 12+ chars> ("Complete commit subject")
+#    commit <SHA-1 hash length 16+ chars> ("Complete commit subject")
 # with the commit subject '("' prefix and '")' suffix
 # This is a fairly compilicated block as it tests for what appears to be
 # bare SHA-1 hash with  minimum length of 5.  It also avoids several types of
@@ -3343,16 +3343,16 @@ sub process {
 		    $line !~ /^This reverts commit [0-9a-f]{7,40}/ &&
 		    (($line =~ /\bcommit\s+[0-9a-f]{5,}\b/i ||
 		      ($line =~ /\bcommit\s*$/i && defined($rawlines[$linenr]) && $rawlines[$linenr] =~ /^\s*[0-9a-f]{5,}\b/i)) ||
-		     ($line =~ /(?:\s|^)[0-9a-f]{12,40}(?:[\s"'\(\[]|$)/i &&
-		      $line !~ /[\<\[][0-9a-f]{12,40}[\>\]]/i &&
-		      $line !~ /\bfixes:\s*[0-9a-f]{12,40}/i))) {
+		     ($line =~ /(?:\s|^)[0-9a-f]{16,40}(?:[\s"'\(\[]|$)/i &&
+		      $line !~ /[\<\[][0-9a-f]{16,40}[\>\]]/i &&
+		      $line !~ /\bfixes:\s*[0-9a-f]{16,40}/i))) {
 			my $init_char = "c";
 			my $orig_commit = "";
 			my $short = 1;
 			my $long = 0;
 			my $case = 1;
 			my $space = 1;
-			my $id = '0123456789ab';
+			my $id = '0123456789abcdef';
 			my $orig_desc = "commit description";
 			my $description = "";
 			my $herectx = $herecurr;
@@ -3383,11 +3383,11 @@ sub process {
 			if ($input =~ /\b(c)ommit\s+([0-9a-f]{5,})\b/i) {
 				$init_char = $1;
 				$orig_commit = lc($2);
-				$short = 0 if ($input =~ /\bcommit\s+[0-9a-f]{12,40}/i);
+				$short = 0 if ($input =~ /\bcommit\s+[0-9a-f]{16,40}/i);
 				$long = 1 if ($input =~ /\bcommit\s+[0-9a-f]{41,}/i);
 				$space = 0 if ($input =~ /\bcommit [0-9a-f]/i);
 				$case = 0 if ($input =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
-			} elsif ($input =~ /\b([0-9a-f]{12,40})\b/i) {
+			} elsif ($input =~ /\b([0-9a-f]{16,40})\b/i) {
 				$orig_commit = lc($1);
 			}
 
@@ -3398,7 +3398,7 @@ sub process {
 			    ($short || $long || $space || $case || ($orig_desc ne $description) || !$has_quotes) &&
 			    $last_git_commit_id_linenr != $linenr - 1) {
 				ERROR("GIT_COMMIT_ID",
-				      "Please use git commit description style 'commit <12+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herectx);
+				      "Please use git commit description style 'commit <16+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herectx);
 			}
 			#don't report the next line if this line ends in commit and the sha1 hash is the next line
 			$last_git_commit_id_linenr = $linenr if ($line =~ /\bcommit\s*$/i);
-- 
2.34.1


