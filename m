Return-Path: <linux-kernel+bounces-540460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68D4A4B0DF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 10:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8CAF16ACFD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 09:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7554A1DBB0C;
	Sun,  2 Mar 2025 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IsG5o3An";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/ytnCkaS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IsG5o3An";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/ytnCkaS"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544BF1D7E37
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740909577; cv=none; b=nIZazYO30BbPzyPPLoz7FERtr8he1q32LttVPfckXwUgESOd/OGVgVa+Ghwz8IkD3QDDIUBGO7bxHs1Ihj3d7n35rPx1JH3XWGgX8zkztH1M9QbgAnx35yLDb/FeLmwjEBqv6ugFg2ioDX9pZtC2bOAoqHp/8N4F4+y8Dfxkk90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740909577; c=relaxed/simple;
	bh=N+YX5cL/z+WJEMi3jfYDU8pJcZKbbP5EunEvRudn7PE=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=honEmxQso6Xwc8gnbNUtkuE9pSqQ6WsmIt/yTP5a9G9tRZklNki8wmW/shnL6LWaz9LhgGCkYXvQaA2ovGJtDi7MuxJW7wVXNlMmTahkvXEWrv3yJk0YA+zn1DQaCoZC4fg6pRgnjDSJKwOBA7Isoogwi9L9ShoRQibWNt+yUWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IsG5o3An; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/ytnCkaS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IsG5o3An; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/ytnCkaS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 51C4C1F770;
	Sun,  2 Mar 2025 09:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740909574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=fH+YcOiwHIZRGS7otWc8ZDXv79Isns7wggIg+WWmGrk=;
	b=IsG5o3An4NIewTkzS3KdaSW3Hxxgz+z9tjJXix4Rjd7p6y5YBSbXRrAgem2UBxJ9RCrxXA
	TK/LdQ842tvVttXOTtwqK6zMoX0RUSr5MBMU6UV8YB9PKy37YKzD7w4WAcnNOTrSEwg6ml
	jMrUK8gnP7DBNCZzutmmUHYGhhoIBco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740909574;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=fH+YcOiwHIZRGS7otWc8ZDXv79Isns7wggIg+WWmGrk=;
	b=/ytnCkaS3S/YlJIltSRwcKMyZGiR/LLtFiAH9aDe9nTrNIfS3kjKUWjiyBVzmbtxIjAwy8
	s2kom5eC6vKnz/Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IsG5o3An;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/ytnCkaS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740909574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=fH+YcOiwHIZRGS7otWc8ZDXv79Isns7wggIg+WWmGrk=;
	b=IsG5o3An4NIewTkzS3KdaSW3Hxxgz+z9tjJXix4Rjd7p6y5YBSbXRrAgem2UBxJ9RCrxXA
	TK/LdQ842tvVttXOTtwqK6zMoX0RUSr5MBMU6UV8YB9PKy37YKzD7w4WAcnNOTrSEwg6ml
	jMrUK8gnP7DBNCZzutmmUHYGhhoIBco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740909574;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=fH+YcOiwHIZRGS7otWc8ZDXv79Isns7wggIg+WWmGrk=;
	b=/ytnCkaS3S/YlJIltSRwcKMyZGiR/LLtFiAH9aDe9nTrNIfS3kjKUWjiyBVzmbtxIjAwy8
	s2kom5eC6vKnz/Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28C661395B;
	Sun,  2 Mar 2025 09:59:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u7rnBwYsxGfeCgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 02 Mar 2025 09:59:34 +0000
Date: Sun, 02 Mar 2025 10:59:33 +0100
Message-ID: <87a5a3ah2y.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Is commit 4d94f0555827 safe?
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 51C4C1F770
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

[ I posted without the subject line mistakenly, so resent again;
  sorry if you have seen already read it ]

Hi Luiz,

due to the CVE assignment, I stumbled on the recent fix for BT
hci_core, the commit 4d94f0555827 ("Bluetooth: hci_core: Fix sleeping
function called from invalid context"), and wonder whether it's really
safe.

As already asked question at the patch review:
  https://patchwork.kernel.org/comment/26147087/
the code allows the callbacks to be called even after
hci_unregister_cb() returns.

Your assumption was that it's never called without the module removal,
but isn't hci_unregister_cb() also called from iso_exit() which can be
triggered via set_iso_socket_func() in mgmt.c?  Also, any 3rd party
module could call hci_unregister_cb() in a wild way, too -- even if
the function still remains, it doesn't mean that you can call it
safely if the caller already assumes it being unregistered.

In addition to that, I feel what the patch does as a bit too
heavy-lifting: it does kmalloc() and copy the whole hci_cb object,
which isn't quite small for each.  If the callback is still safe to
call after RCU protection, you may just keep the hci_cb pointer
instead of copying the whole content, too?

I couldn't find v1 patch in the patchwork, so not sure whether this
has been already discussed.  If so, let me know.


Thanks!

Takashi

