Return-Path: <linux-kernel+bounces-327872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96638977C18
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9AB5B28AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BD21D6C7C;
	Fri, 13 Sep 2024 09:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HwnCQgOd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6mZXP1fv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HwnCQgOd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6mZXP1fv"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F79175D45
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726219240; cv=none; b=qyGYKeWwI0v6kgrEXxfmom9BROyc5oL0izY3Tq2bjn5PLFK41wr48ViORar4/TSVWXgx2lttY8EaswFXPzUFRYKOlcCFUpxCgsopQPNAUCPIkyRcMvEBmU94Q0Q3f8FuH9X+9LoOIKpGSN4A5lfjxhDdn1Jf5EhwyuImw3aMEw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726219240; c=relaxed/simple;
	bh=EpwXLUTj62b6d6Gz8jWdaV2Dn7S4iRdKfckasaFDw/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EaMpO4j9dUweHv9bu7oyPN/m+j6JrIYiWJDLPorpIIcNUF0rB4g9WwTpShF3WocwwYhAjBY4hNQ6kF4+XI30B7BX7TTLIC7GMnqy8YqDQ6g8lKRw336xKoTHUuD0szVGMUBXmWvFfMRK9EIG8S2XNLlYYIsfQQb+kCswDlKyR1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HwnCQgOd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6mZXP1fv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HwnCQgOd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6mZXP1fv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9C304218ED;
	Fri, 13 Sep 2024 09:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726219236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vVcGxtCsucx7/qosy72/MyNz3WeeSZ63XSScGFyR6OY=;
	b=HwnCQgOdhnSMD3Gj79x3N48CYOX+C6taNUv3QYdE0SGzLpX6u2JpZl2463/n0vuQMltpbn
	1n8dV/+7l/FodaW+6qwvUBKe0s6K/IwE9iGcIYP0qtP93dpWK8I/UQAMDLorRH9c/IoUdX
	VWe7H6CmURwNthCSAWLwi17z7VmEJ/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726219236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vVcGxtCsucx7/qosy72/MyNz3WeeSZ63XSScGFyR6OY=;
	b=6mZXP1fvNRoyqhmtqhhttun0PKmxABYj1N69n/WMz4mrCzlrft1xu6HTRDL51zML9qcuMk
	z0VTtJF4pbfOytAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726219236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vVcGxtCsucx7/qosy72/MyNz3WeeSZ63XSScGFyR6OY=;
	b=HwnCQgOdhnSMD3Gj79x3N48CYOX+C6taNUv3QYdE0SGzLpX6u2JpZl2463/n0vuQMltpbn
	1n8dV/+7l/FodaW+6qwvUBKe0s6K/IwE9iGcIYP0qtP93dpWK8I/UQAMDLorRH9c/IoUdX
	VWe7H6CmURwNthCSAWLwi17z7VmEJ/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726219236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vVcGxtCsucx7/qosy72/MyNz3WeeSZ63XSScGFyR6OY=;
	b=6mZXP1fvNRoyqhmtqhhttun0PKmxABYj1N69n/WMz4mrCzlrft1xu6HTRDL51zML9qcuMk
	z0VTtJF4pbfOytAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EAEF13999;
	Fri, 13 Sep 2024 09:20:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MrqvHeQD5GZ+UAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 13 Sep 2024 09:20:36 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-firmware@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH linux-firmware] copy-firmware: Fix incorrect symlinks to uncompressed targets
Date: Fri, 13 Sep 2024 11:21:08 +0200
Message-ID: <20240913092122.19523-1-tiwai@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The script tries to make a symlink to the target with the compressed
extension, but it ends up with a wrong symlink if the compression is
skipped for the target (e.g. via RawFile entry).

Add more checks to make a correct symlink.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

This fixes the installation failure with the recent change for qcom
commit 541f96c0fa47b70e9bc13035f7a082064e5b2d4c

The workaround is pretty ad hoc, so if you have a better way to manage
it, feel free to scratch this.


 copy-firmware.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/copy-firmware.sh b/copy-firmware.sh
index 6757c6ce03a3..fc096dd6daf0 100755
--- a/copy-firmware.sh
+++ b/copy-firmware.sh
@@ -136,9 +136,15 @@ grep -E '^Link:' WHENCE | sed -e 's/^Link: *//g;s/-> //g' | while read f d; do
         if test -d "$target"; then
             $verbose "creating link $f -> $d"
             ln -s "$d" "$destdir/$f"
-        else
+        elif test -f "$target$compext"; then
             $verbose "creating link $f$compext -> $d$compext"
             ln -s "$d$compext" "$destdir/$f$compext"
+        elif test -f "$target"; then
+            $verbose "creating link $f -> $d"
+            ln -s "$d" "$destdir/$f"
+        else
+            $verbose "creating link (not yet existing) $f$compext -> $d$compext"
+            ln -s "$d$compext" "$destdir/$f$compext"
         fi
     fi
 done
-- 
2.43.0


