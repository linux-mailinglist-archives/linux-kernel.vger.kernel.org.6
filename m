Return-Path: <linux-kernel+bounces-216918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C093F90A884
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C783E1C211D7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AFB19069D;
	Mon, 17 Jun 2024 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aokhwUhP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1XMFY7XP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aokhwUhP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1XMFY7XP"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3B4190684
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613223; cv=none; b=Q40KuQAP7KPQBbt5JUcO9Psgoyc5ARDgisBk+XTB9OytSAU3Cz0GHsIVHl7XZ1o3+wVbiswdw/RM5ex6DGSf36hxPYz0BUtGtPACoN6ZXtLGC0ZMTfzcHIRB3RlBrc9ClQZCybonNtNYp7n4JAr1ATehYiTmUC95qiwQjyglKMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613223; c=relaxed/simple;
	bh=VHymT8tDoJB513hoWIwppBxh8Pj30kNWx/qsc2Ifl4I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gJz89063owuTUEDRX4Us5u/Kkp1y3SowB9LJK0Mk7zehFNeEdn8BQxwYolNk4uh7uXM/h3I0lKoAa3WWFAW7I+p8HjDooxno0Pj8DgHjADP0RpY+QH9+MHbX8THdqAvf48SnR5idHvkj+/ZKB4o2040ZXQnU+AD+ZjAip/OKOws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aokhwUhP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1XMFY7XP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aokhwUhP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1XMFY7XP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B63445FD1C;
	Mon, 17 Jun 2024 08:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718613219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IfUHy7jvC6C04xNMpt9q7GAc0YI8QU0L6ePoL2dWjTI=;
	b=aokhwUhPRMn/0hex1uFpquaVKQxdv+23yq3Shf2fml80DzSdgmTDYnOmz5ojhj6sKvVODD
	l7KwWrpkC3aL323zbF42adrPb4M6J/KhJg0BdzETMiU2AWY0GKfzcgTlHlDeKvMd8/Nz+5
	3o1h360my+RizUAsRTjozCJjU8OJnc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718613219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IfUHy7jvC6C04xNMpt9q7GAc0YI8QU0L6ePoL2dWjTI=;
	b=1XMFY7XPvQByI7XhBa0t0Fm7yRelaTQBW9elotikT3qrLkhAV4dqlIJOJ2hck64N3vDgzy
	wG1Ns0vWLs3h9EAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718613219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IfUHy7jvC6C04xNMpt9q7GAc0YI8QU0L6ePoL2dWjTI=;
	b=aokhwUhPRMn/0hex1uFpquaVKQxdv+23yq3Shf2fml80DzSdgmTDYnOmz5ojhj6sKvVODD
	l7KwWrpkC3aL323zbF42adrPb4M6J/KhJg0BdzETMiU2AWY0GKfzcgTlHlDeKvMd8/Nz+5
	3o1h360my+RizUAsRTjozCJjU8OJnc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718613219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IfUHy7jvC6C04xNMpt9q7GAc0YI8QU0L6ePoL2dWjTI=;
	b=1XMFY7XPvQByI7XhBa0t0Fm7yRelaTQBW9elotikT3qrLkhAV4dqlIJOJ2hck64N3vDgzy
	wG1Ns0vWLs3h9EAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F81B139AB;
	Mon, 17 Jun 2024 08:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gtdCHOL0b2abYwAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Mon, 17 Jun 2024 08:33:38 +0000
Date: Mon, 17 Jun 2024 10:33:36 +0200
From: Jean Delvare <jdelvare@suse.de>
To: dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>
Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH RESEND] drm/logicvc: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20240617103336.7fddb08d@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.20
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.20 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.90)[86.06%];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,bootlin.com:email]

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
Already sent on: 2022-11-21, 2023-01-27, 2023-12-02

This is one of the only 3 remaining occurrences of this deprecated
construct.

Who can pick this patch and get it upstream?

 drivers/gpu/drm/logicvc/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-6.6.orig/drivers/gpu/drm/logicvc/Kconfig
+++ linux-6.6/drivers/gpu/drm/logicvc/Kconfig
@@ -1,7 +1,7 @@
 config DRM_LOGICVC
 	tristate "LogiCVC DRM"
 	depends on DRM
-	depends on OF || COMPILE_TEST
+	depends on OF
 	select DRM_KMS_HELPER
 	select DRM_KMS_DMA_HELPER
 	select DRM_GEM_DMA_HELPER


-- 
Jean Delvare
SUSE L3 Support

