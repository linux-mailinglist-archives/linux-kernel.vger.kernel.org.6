Return-Path: <linux-kernel+bounces-188949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B3A8CE8E0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2191C21119
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9620112E1E7;
	Fri, 24 May 2024 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CT9tevJK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sYt5hBCa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CT9tevJK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sYt5hBCa"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E5C3D76;
	Fri, 24 May 2024 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716569146; cv=none; b=XZMSVHb12a+Kn+kdcvfxYGSnxS0Y6uPHPUELgG8avIJHv6E094Ghv5Yps5YF8AvspAVNW4veVOi32PuEip847sFigWSc6RQGefw5ZkHTgN7N/ihVc3PgINwLrPueeKKSv309svyQrul5aH+dWmxciCcW2QIwXgny2tPTYXMAAlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716569146; c=relaxed/simple;
	bh=59LH0mZQ1eogClfVRFpOvFUWZqVOe8OFEOllat+O2G8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W9O1I7iJtrPGos45ZqcdGzr3lLLMAlfafbqR3ZUrcJG+PPX8qixf54cQBfrcCZwgYi2Wu1F8doP9MbDyoN/POYKXDajybdsNnhUHYd3fcArbxzt6fHlNMdfXZKNnf3Xi+xsmcU4jXlAusapv+NCmcrNK1AeSk57J2a1iQbSUZJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CT9tevJK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sYt5hBCa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CT9tevJK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sYt5hBCa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0205E33C4C;
	Fri, 24 May 2024 16:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716569143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00dCD1RWG8/lY0/dkdnGlMD1lbbBwQMsAVfta7mHLW4=;
	b=CT9tevJK/Vt5jvopxK9oYFpnGFzT0T3UlR/S8BwogbI2wHaAma5MdTZ/sAGT4QJC5ZOGJm
	5AQtC1HcYf82loEmu2pP++qyJctVM7ZPlvnB1n7xN86zLE3oRbufQ5+3XwvuG2KBg4i/x8
	MZHj+FNL9Y+GIwsoXq9s/muT6lFZ8AU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716569143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00dCD1RWG8/lY0/dkdnGlMD1lbbBwQMsAVfta7mHLW4=;
	b=sYt5hBCaEUPLGQCQkJxlFpXlACSA3Lt6HOxsESLpLncAtpexAS+PkkLioUGN3F7vwaoudv
	tUdLLFNvgttYixDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716569143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00dCD1RWG8/lY0/dkdnGlMD1lbbBwQMsAVfta7mHLW4=;
	b=CT9tevJK/Vt5jvopxK9oYFpnGFzT0T3UlR/S8BwogbI2wHaAma5MdTZ/sAGT4QJC5ZOGJm
	5AQtC1HcYf82loEmu2pP++qyJctVM7ZPlvnB1n7xN86zLE3oRbufQ5+3XwvuG2KBg4i/x8
	MZHj+FNL9Y+GIwsoXq9s/muT6lFZ8AU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716569143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00dCD1RWG8/lY0/dkdnGlMD1lbbBwQMsAVfta7mHLW4=;
	b=sYt5hBCaEUPLGQCQkJxlFpXlACSA3Lt6HOxsESLpLncAtpexAS+PkkLioUGN3F7vwaoudv
	tUdLLFNvgttYixDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B5E113A6B;
	Fri, 24 May 2024 16:45:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gxh2GTbEUGY+AgAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 24 May 2024 16:45:42 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-cve-announce@vger.kernel.org,  <cve@kernel.org>,
  <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: CVE-2023-52656: io_uring: drop any code related to SCM_RIGHTS
In-Reply-To: <2024051338-CVE-2023-52656-6545@gregkh> (Greg Kroah-Hartman's
	message of "Mon, 13 May 2024 15:12:39 +0200")
References: <2024051338-CVE-2023-52656-6545@gregkh>
Date: Fri, 24 May 2024 12:45:31 -0400
Message-ID: <871q5rqhuc.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> Description
> ===========
>
> In the Linux kernel, the following vulnerability has been resolved:
>
> io_uring: drop any code related to SCM_RIGHTS
>
> This is dead code after we dropped support for passing io_uring fds
> over SCM_RIGHTS, get rid of it.
>
> The Linux kernel CVE team has assigned CVE-2023-52656 to this issue.

Hello Greg,

[+Jens in Cc]

This is stable material, but doesn't deserve CVE status.  There is
nothing exploitable that is fixed here. Instead, this commit is dropping
unreachable code after the removal of a feature, following another CVE
report.  Doing the clean up in the original patch would have made the
real security fix harder to review.

The real issue was reported as CVE-2023-52654 and handled by a different
commit.

-- 
Gabriel Krisman Bertazi

