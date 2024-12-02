Return-Path: <linux-kernel+bounces-427054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A469D9DFBB0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF8B162708
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4E61F9ABF;
	Mon,  2 Dec 2024 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="uI9m3wC8"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CC71F9427;
	Mon,  2 Dec 2024 08:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733127268; cv=none; b=QBsWICv+Dz1xMHhXKvG7lQNgO6f0cvowvtaHIDX98thRijpV540N/todgdp524PNfeCZULk211Am2yeq+r3hsvga04TPDbYHVSWRO88yD1HaIygj2gOPW7Ye+d/q3McTx9CsXm+gTOCDpcE6gHwwhYT9fKfPNaiFDZ+z2nt4LHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733127268; c=relaxed/simple;
	bh=gGOM1graJ0R1M1BWJ0QpiFtQvq735McYl9nYRNfUUh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GvL5Tuw3emt7tkFSNXRmF+LjJ7YKpftTdzNlSl4TogtdT8MrKnRrLoH+buCqLLuWtsuFnoiJ96POONFSet5/q3j7DYCeCwZ8RePzhxwItad4EV84NaIh5pj7AiNbbqZcAnp7I/ZAtcBlLo9FtmYS8539zqjR3+Gr69epwdSMJuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=uI9m3wC8; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=8KSUebvw61biUpporSek1rMki7LDC7BhSfjDNhILlj8=; t=1733127266; x=1733559266; 
	b=uI9m3wC8X5yzrag5d6DHGwGh4ABhE+8635imP0KTD8D5/Z9xeY4V/5hzqPrTxyGvnucvNQ2LiXo
	dfeqKqLOA07rXGSjFUmPZM3ETm/1Et4OC9BUGuGE77Fh91B8mreFDL3wm1mgudxPrbG+kaiJVGo6o
	sk9a0efetQK3S3pvFsnXzMWG2BvKnkv4zzpdHrOnLvOlMl9N3GBmPmDnrB3IhZh98yus0ap1zbYjT
	9olm48rxlDwys50Z1EO1Vxdk1K4p+a+2Uel6r57dSwMY9eOeW6kVpYtDAwsIGwUj4xgbjb3GAkb6z
	1S/76OlX+fh7diSqbqR+XhKLM2Vgnz/zab4A==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1tI1ZT-001A9z-2x;
	Mon, 02 Dec 2024 09:14:20 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 DONOTMERGE] docs: clarify rules wrt tagging other people
Date: Mon,  2 Dec 2024 09:14:19 +0100
Message-ID: <c29ef5fa12e37c3a289e46d4442b069af94e5b05.1733127212.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1733127266;b720a150;
X-HE-SMSGID: 1tI1ZT-001A9z-2x

Point out that explicit permission is usually needed to tag other people
in changes, but mention that implicit permission can be sufficient in
certain cases. This fixes slight inconsistencies between Reported-by:
and Suggested-by: and makes the usage more intuitive.

While at it, explicitly mention the dangers of our bugzilla instance, as
it makes it easy to forget that email addresses visible there are only
shown to logged-in users.

The latter is not a theoretical issue, as one maintainer mentioned that
his employer received a EU GDPR (general data protection regulation)
complaint after exposing a email address used in bugzilla through a tag
in a patch description.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
Note: this triggers a few checkpatch.pl complaints that are irrelevant
when when to comes to changes like this.

v3:
- try yet again from a slightly different angle which loosens the rules
  slightly. This from review feedback to earlier versions is apparently
  what other developers want and from their "no lawyer" perspective
  consider to be okay. As IANAL myself I don't feel totally comfortable
  with this and have no idea if this legally is sound, so tag patch with
  "DONOTMERGE" for now; will remove this for v4 if enough people add a
  "Reviewed-by". Otherwise the story of this patch might end here, unless
  someone else submits it for inclusion (you are free to do so!).
- remote patch adding Suggested-by: tag to 5.Posting and submit it
  separately

v2: https://lore.kernel.org/all/cover.1731749544.git.linux@leemhuis.info/
- Retry differently. This slightly hardens the rule for Reported-by:
  while slightly lessening it for Suggested-by:. Those in the end are
  quite similar, so it does not make much sense to apply different ones.
  I considered using an approach along the lines of "if you reported it
  in pubic by mail, implicit permission to use in a tag is granted"; but
  I abstained from it, as I assume there are good reasons for the
  existing approach regarding Suggested-by:.
- CC all the people that provided feedback on the text changes in v1

v1: https://lore.kernel.org/all/f5bc0639a20d6fac68062466d5e3dd0519588d08.1731486825.git.linux@leemhuis.info/
- initial version
---
 Documentation/process/5.Posting.rst          | 13 +++++--
 Documentation/process/submitting-patches.rst | 39 ++++++++++++++------
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
index b3eff03ea2491c..73961565040ed8 100644
--- a/Documentation/process/5.Posting.rst
+++ b/Documentation/process/5.Posting.rst
@@ -264,10 +264,15 @@ The tags in common use are:
  - Cc: the named person received a copy of the patch and had the
    opportunity to comment on it.
 
-Be careful in the addition of tags to your patches, as only Cc: is appropriate
-for addition without the explicit permission of the person named; using
-Reported-by: is fine most of the time as well, but ask for permission if
-the bug was reported in private.
+Be careful in the addition of tags to your patches, as all except for Cc:,
+Reported-by:, and Suggested-by: need explicit permission of the person named.
+For the three aforementioned ones implicit permission is sufficient if the
+person contributed to the Linux kernel using that name and email address
+according to the lore archives or the commit history -- and in case of
+Reported-by: and Suggested-by: did the reporting or suggestion in public.
+Note, bugzilla.kernel.org is a public place in this sense, but email addresses
+used there are private; so do not expose them in tags, unless the person used
+them in earlier contributions.
 
 
 Sending the patch
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 1518bd57adab50..9d26a4b7ca8ba3 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -481,10 +481,10 @@ list archives.
 
 If a person has had the opportunity to comment on a patch, but has not
 provided such comments, you may optionally add a ``Cc:`` tag to the patch.
-This is the only tag which might be added without an explicit action by the
-person it names - but it should indicate that this person was copied on the
-patch.  This tag documents that potentially interested parties
-have been included in the discussion.
+This tag documents that potentially interested parties have been included in
+the discussion. Note, this is one of only three tags you might be able to use
+without explicit permission of the person named (see 'Tagging people requires
+permission' below for details).
 
 Co-developed-by: states that the patch was co-created by multiple developers;
 it is used to give attribution to co-authors (in addition to the author
@@ -530,9 +530,9 @@ hopefully inspires them to help us again in the future. The tag is intended for
 bugs; please do not use it to credit feature requests. The tag should be
 followed by a Closes: tag pointing to the report, unless the report is not
 available on the web. The Link: tag can be used instead of Closes: if the patch
-fixes a part of the issue(s) being reported. Please note that if the bug was
-reported in private, then ask for permission first before using the Reported-by
-tag.
+fixes a part of the issue(s) being reported. Note, the Reported-by tag is one
+of only three tags you might be able to use without explicit permission of the
+person named (see 'Tagging people requires permission' below for details).
 
 A Tested-by: tag indicates that the patch has been successfully tested (in
 some environment) by the person named.  This tag informs maintainers that
@@ -582,11 +582,11 @@ Usually removal of someone's Tested-by or Reviewed-by tags should be mentioned
 in the patch changelog (after the '---' separator).
 
 A Suggested-by: tag indicates that the patch idea is suggested by the person
-named and ensures credit to the person for the idea. Please note that this
-tag should not be added without the reporter's permission, especially if the
-idea was not posted in a public forum. That said, if we diligently credit our
-idea reporters, they will, hopefully, be inspired to help us again in the
-future.
+named and ensures credit to the person for the idea: if we diligently credit
+our idea reporters, they will, hopefully, be inspired to help us again in the
+future. Note, this is one of only three tags you might be able to use without
+explicit permission of the person named (see 'Tagging people requires
+permission' below for details).
 
 A Fixes: tag indicates that the patch fixes an issue in a previous commit. It
 is used to make it easy to determine where a bug originated, which can help
@@ -600,6 +600,21 @@ process nor the requirement to Cc: stable@vger.kernel.org on all stable
 patch candidates. For more information, please read
 Documentation/process/stable-kernel-rules.rst.
 
+.. _tagging_people:
+
+Tagging people requires permission
+----------------------------------
+
+Be careful in the addition of tags to your patches, as all except for Cc:,
+Reported-by:, and Suggested-by: need explicit permission of the person named.
+For the three aforementioned ones implicit permission is sufficient if the
+person contributed to the Linux kernel using that name and email address
+according to the lore archives or the commit history -- and in case of
+Reported-by: and Suggested-by: did the reporting or suggestion in public.
+Note, bugzilla.kernel.org is a public place in this sense, but email addresses
+used there are private; so do not expose them in tags, unless the person used
+them in earlier contributions.
+
 .. _the_canonical_patch_format:
 
 The canonical patch format

base-commit: 83a474c11e8cb59e230a43365cb42fa00d3bddaa
-- 
2.45.0


