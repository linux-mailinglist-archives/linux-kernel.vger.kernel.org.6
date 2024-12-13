Return-Path: <linux-kernel+bounces-444688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2375C9F0B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B211889E33
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5D61DEFE2;
	Fri, 13 Dec 2024 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J9TzfDFQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Nvrmho5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J9TzfDFQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Nvrmho5"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297551AC8B9;
	Fri, 13 Dec 2024 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089497; cv=none; b=RaMt4T5j3/0z/f7Ocp4/y9sNNmFM9nOSRZylewt8LaWuU/+y3hS9O9vjAmHQ6n8TLOkBH74P66CYHczQplTDJakuCgFko4C6BgsQ1ztO5VM7OBYfrYIKdnrmD5xsxW4t3vYqrn6d9+mGiNDu8fQ3mpxQRt/uFjTa25+ldUn0nBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089497; c=relaxed/simple;
	bh=2kZDUN0oXZxDltOM76SVSzHfd2+bJipUkD4hmTp2BeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYqoH6moUfKUPi1wpoKCkINMFBZW0dAp3zHBvzP6GHcpYFx8AbfRP8PrRF0kRzGuxanmJq5ZSai4z7T30Mb0dKFyR2cfaLewmsvk/ZuC6vArtGTkhis8vYXWE1ZEgBBc8LrGhdfX+r4w4sNNqqg27f1SWP2U52aNLJk+5bvNTY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J9TzfDFQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Nvrmho5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J9TzfDFQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Nvrmho5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2BB4B2118F;
	Fri, 13 Dec 2024 11:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734089493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3Otja/V8iVkjpbxSaRwfSQ2uR5NuRiE8gnzz4GB7804=;
	b=J9TzfDFQJaQGpszKnpoeWtB9HMxPxbkUZwXtyC/yqZA1c6gWsVemNteLK9oaMKXy0DjEZS
	rxEL9V++NAQLoiNPHnmvImav4+YcFNQZ7Q1BtCWpxOkiSg7pxqV0pw14Eean/kdJI+KQ21
	dZ4w80/dxKU7VPqcDSgGuBB3ddln0Hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734089493;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3Otja/V8iVkjpbxSaRwfSQ2uR5NuRiE8gnzz4GB7804=;
	b=0Nvrmho5UfUG22FOsPdU1jkCeeDFix5kXjVD4X1H080PPvSnp0bVKSiOYbWCI7iKXv/ls7
	rzfQVdjOCUsJaFDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734089493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3Otja/V8iVkjpbxSaRwfSQ2uR5NuRiE8gnzz4GB7804=;
	b=J9TzfDFQJaQGpszKnpoeWtB9HMxPxbkUZwXtyC/yqZA1c6gWsVemNteLK9oaMKXy0DjEZS
	rxEL9V++NAQLoiNPHnmvImav4+YcFNQZ7Q1BtCWpxOkiSg7pxqV0pw14Eean/kdJI+KQ21
	dZ4w80/dxKU7VPqcDSgGuBB3ddln0Hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734089493;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3Otja/V8iVkjpbxSaRwfSQ2uR5NuRiE8gnzz4GB7804=;
	b=0Nvrmho5UfUG22FOsPdU1jkCeeDFix5kXjVD4X1H080PPvSnp0bVKSiOYbWCI7iKXv/ls7
	rzfQVdjOCUsJaFDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1113213927;
	Fri, 13 Dec 2024 11:31:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pJ7ZAxUbXGdfYAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 13 Dec 2024 11:31:33 +0000
From: Vlastimil Babka <vbabka@suse.cz>
To: Joe Perches <joe@perches.com>,
	workflows@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: [RFC PATCH] get_maintainer: decouple subsystem status from maintainer role
Date: Fri, 13 Dec 2024 12:29:22 +0100
Message-ID: <20241213112921.180978-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The script currently uses the subystem's status (S: field) to change how
maintainers are reported. One prominent example is when the status is
Supported, the maintainers are reported as "(supporter:SUBSYSTEM)".

This is misleading, as the Supported status defined as "Someone is
actually paid to look after this." may not in fact apply to everyone
listed as a maintainer, but only to some of them.

It has also been confusing people to what "supporter" means and has
required updates to the documentation [1].

Thus stop applying the subsystem status to change "maintainer:" to
anything else, as maintainers are maintainers. Instead, if the subsystem
status is not the most common one (Maintained), indicate it as part of
the subsystem name. So for example, instead of "(supporter:SUBSYSTEM)"
report "(maintainer:SUBSYSTEM [supported])".

[1] https://lore.kernel.org/all/20221006162413.858527-1-bryan.odonoghue@linaro.org/

Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
I have been confused myself in the past seeing "supporter" and have seen
somebody recently wondering what it means as well.

I have read the threads from 2022 that in the end resulted in adjusting
documentation only [1]. I very much agree with Ted's points about taking
the subsystem status and applying it to all maintainers being wrong [2].

The attempt to modify get_maintainer output was retracted after Joe
objected that the status becomes not reported at all [3]. This RFC
attempts to address that by reporting the status (unless it's the most
common one) as part of the subsystem.

The patch is not perfect, as with this approach, the logical thing would
be to do the same also for reviewers and mailing lists. In fact,
subsystems with a status of Orphan typically only have some catch-all
mailing list and no maintainers, so the "(orphan minder:SUBSYSTEM)"
would never be currently reported by checkpatch. It would be thus
logical to report the status in the same way for lists (and reviewers).

But I didn't attempt a full implementation as I'm not fluent in Perl and
would like to see if we can get a consensus first. If we do, I don't
insist in this particular "SUBSYSTEM [status]" syntax nor on
implementing the full solution myself - I would be happy if somebody
else did. My main point is that maintainer is a maintainer and the
subsystem status should be indicated for the subsystem, not for the
maintainer.

[1] https://lore.kernel.org/all/20221006162413.858527-1-bryan.odonoghue@linaro.org/
[2] https://lore.kernel.org/all/Yzen4X1Na0MKXHs9@mit.edu/
[3] https://lore.kernel.org/all/30776fe75061951777da8fa6618ae89bea7a8ce4.camel@perches.com/

 scripts/get_maintainer.pl | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 5ac02e198737..a2f578f2d93b 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -1286,6 +1286,7 @@ sub get_maintainer_role {
 
     my $role = "unknown";
     my $subsystem = get_subsystem_name($index);
+    my $substatus = "";
 
     for ($i = $start + 1; $i < $end; $i++) {
 	my $tv = $typevalue[$i];
@@ -1299,21 +1300,10 @@ sub get_maintainer_role {
     }
 
     $role = lc($role);
-    if      ($role eq "supported") {
-	$role = "supporter";
-    } elsif ($role eq "maintained") {
-	$role = "maintainer";
-    } elsif ($role eq "odd fixes") {
-	$role = "odd fixer";
-    } elsif ($role eq "orphan") {
-	$role = "orphan minder";
-    } elsif ($role eq "obsolete") {
-	$role = "obsolete minder";
-    } elsif ($role eq "buried alive in reporters") {
-	$role = "chief penguin";
-    }
-
-    return $role . ":" . $subsystem;
+    if ($role ne "maintained") {
+	$substatus = " [" . $role . "]";
+    }
+    return "maintainer:" . $subsystem . $substatus;
 }
 
 sub get_list_role {
-- 
2.47.1


