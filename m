Return-Path: <linux-kernel+bounces-189505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9C68CF0F6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 20:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91DF1C2092B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 18:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7134086653;
	Sat, 25 May 2024 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GXPFa/9o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oXTGqGAC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GXPFa/9o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oXTGqGAC"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673099473;
	Sat, 25 May 2024 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716660935; cv=none; b=uQRCEoufSaIdIg5QQiYH5hDQ5+o1Ev9m6eIxW7atYoKuFW0MCVK9K/yZxY1WK/846TMSXdQQNdYCpnvmenTwrd8GIl4Fu1q6Vx9I8kR+41ocFUAEcAifDHqGQdqrVZDBWkO6t1GzH/lqSuhrU/KnkPZwysRdI4Pq26vnoK7gHTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716660935; c=relaxed/simple;
	bh=h9JgLrbRZjPLaX3q5EmomeHwEIM+TyOAhWwJVd8yMG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WHR+3Kp/kJsxVvsRj8vLvxspjKVcPKsnMLDxeyLNOFsZLCTPbkSPFfE5wDVLGdb0/cwsZBavoTdWmAgLs3RPz1pj1pJYJoBHzvU6PLcjzsYfuV8Z80xPzOFjTz/5B0162E1MtY4AENWlYMm3IHwUmSR9oScrMgeRpIdPFN5fU9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GXPFa/9o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oXTGqGAC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GXPFa/9o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oXTGqGAC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 95C9D5C269;
	Sat, 25 May 2024 18:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716660925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XlI/1fQUHPJ28qJv6dfQq5z4tYvrNlHxR64HTljE4Lg=;
	b=GXPFa/9oIyPkQvQFpWFuL4d796QLUSF71OVsOCoTpjm2vZL+qXWr2ZqC0vgsmavi0fS9Vf
	SteUz6k/qBZnj9tyTlOOFlvLmjH/vY1trJHPt1QSWrhdXjkyylkyJ0mRcFWqKFK5axcRR/
	CH1mCIeNksIhazpal6pW4NORHiMcUHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716660925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XlI/1fQUHPJ28qJv6dfQq5z4tYvrNlHxR64HTljE4Lg=;
	b=oXTGqGAC7Fqz/1A35U6koQPZWll0Qthqa4cZdmkakHUhHPGh3efJl30/OPiyWVPgwHKoBH
	7uYkaxLbjDEB/+Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="GXPFa/9o";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oXTGqGAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716660925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XlI/1fQUHPJ28qJv6dfQq5z4tYvrNlHxR64HTljE4Lg=;
	b=GXPFa/9oIyPkQvQFpWFuL4d796QLUSF71OVsOCoTpjm2vZL+qXWr2ZqC0vgsmavi0fS9Vf
	SteUz6k/qBZnj9tyTlOOFlvLmjH/vY1trJHPt1QSWrhdXjkyylkyJ0mRcFWqKFK5axcRR/
	CH1mCIeNksIhazpal6pW4NORHiMcUHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716660925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XlI/1fQUHPJ28qJv6dfQq5z4tYvrNlHxR64HTljE4Lg=;
	b=oXTGqGAC7Fqz/1A35U6koQPZWll0Qthqa4cZdmkakHUhHPGh3efJl30/OPiyWVPgwHKoBH
	7uYkaxLbjDEB/+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5265313A6C;
	Sat, 25 May 2024 18:15:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a8kYDr0qUmazTwAAD6G6ig
	(envelope-from <krisman@suse.de>); Sat, 25 May 2024 18:15:25 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: "Eduardo Vela <Nava>" <evn@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Jens Axboe
 <axboe@kernel.dk>,  linux-cve-announce@vger.kernel.org,  cve@kernel.org,
  linux-kernel@vger.kernel.org,  =?utf-8?Q?Tam=C3=A1s?= Koczka
 <poprdi@google.com>
Subject: Re: CVE-2023-52656: io_uring: drop any code related to SCM_RIGHTS
In-Reply-To: <CAFswPa9jR6mKAsCrdmspCARe-evk16s1t0SG9LrRLCze_f6Ydw@mail.gmail.com>
	(Eduardo' Vela's message of "Sat, 25 May 2024 17:09:45 +0200")
Organization: SUSE
References: <2024051338-CVE-2023-52656-6545@gregkh>
	<871q5rqhuc.fsf@mailhost.krisman.be>
	<d1cb0cd3-0826-48fc-8713-8648d6eb9fd7@kernel.dk>
	<2024052542-diner-snare-a618@gregkh>
	<CAFswPa9jR6mKAsCrdmspCARe-evk16s1t0SG9LrRLCze_f6Ydw@mail.gmail.com>
Date: Sat, 25 May 2024 14:15:19 -0400
Message-ID: <87fru5pxl4.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 95C9D5C269
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.51

"Eduardo' Vela\" <Nava>" <evn@google.com> writes:

> So, either I'm completely lost or CVE-2023-52656 shouldn't have been
> rejected. Forgive me for mudding the problem even more.
>
> I think we need to unreject this CVE (CVE-2023-52656) or CVE-2023-52654
> should be amended to include the dead code removal commit.. that said,
> that'll be weirder than just unrejecting this commit.
>
> The reason is that the commit "io_uring/af_unix: disable sending io_uring
> over sockets" is not enough to fix the vulnerability in stable branches,
> because e.g. bcedd497b3b4a0be56f3adf7c7542720eced0792 on 5.15 only fixes
> one path (io_sqe_file_register) to reach unix_inflight(), but it is still
> reachable via another path (io_sqe_fileS_register) which is only removed by
> d909d381c3152393421403be4b6435f17a2378b4 ("io_uring: drop any code related
> to SCM_RIGHTS").

Hm, right.  this is real for some really old stable tree.  thanks for
the clarification.

But lets agree, the above write up is literally the *only* relevant,
public information on the issue (that I could find).  And it only
appeared because we almost wrongfully rejected it.  The CVE description,
the list of affected trees and everything else in the CVE report are
absolute non-sense.  Still, the CVE report is all downstream developers
have to work on the issue.  Of course, the original commit message could
not have tracked the new information, but the analysis MUST be appended
to the CVE description.

FWIW,

	Fixed in 6.1.83 with commit a3812a47a320
	Fixed in 6.7.11 with commit 88c49d9c8961
	Fixed in 6.8 with commit 6e5e6d274956

Is nonsense, then.  We check for io_is_uring_fops(file) right before it.

Greg,

I understand we have multiple streams for security issues, including
some that might be automated through Fixes tag. But for cases like this,
where a discussion apparently happened and a human did the excellent
work of properly analyzing it, can we get a real CVE description
beyond the original commit message?  Even publishing the archives of the
original report (minus, whatever, the exploit) alongside the CVE would
improve the situation.  The old CVE process was notoriously bad with
descriptions, but this is somehow worse.

> Although that patch claims "it is dead code", this claim was only true on
> upstream, but not on stable branches (or at least on 5.15 where the
> vulnerability was proven to be reachable).

Yet, there no information about this "small" detail anywhere I can find.

> My colleague poprdi@google.com sent this analysis to the CNA list, so maybe
> we can continue the discussion there

No. this *really* needs to be discussed on an *open* list.  The CVE is
out already.

-- 
Gabriel Krisman Bertazi

