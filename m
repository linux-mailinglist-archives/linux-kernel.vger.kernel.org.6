Return-Path: <linux-kernel+bounces-442005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9F69ED6BF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99799282054
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B357B20127C;
	Wed, 11 Dec 2024 19:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p1Gt0BMo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uV2GEkDk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p1Gt0BMo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uV2GEkDk"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082B31DE3C0
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733946360; cv=none; b=bAmocd0FLi69+X5jT6610U6l2e+nFTIOzgtFxwk7VcRFSLhR8lZSItzjgsNuYIyCrPTCagcTSSryhSY3rdTPHszxd9Am2y/EJjMDk1ss94qhwdac+AS3IUF+p/9XL+MA2hhHJhZxTLlilD8dPsLOv9BcctLcG1qtYCB70QyViL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733946360; c=relaxed/simple;
	bh=924aZzizko0aU8CLlyCFsUIoWb+nEVtW+bDNMX9Pomw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HayLTT9ZLNBLihaeBFVZuR/cDtOPooUoR3NgaOBDwpkCWmwyJauhVoxV2QRZvhjR1buqJi9n/TO/n8ceIslyfwCXJCnIEbRhmEG5wSkV8FHa7C3lxDrRluHlw8PI/ZhqVgmv20VC/pV9VSCj6QbSEB7gUyACoMNYaM6fzxdc1SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p1Gt0BMo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uV2GEkDk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p1Gt0BMo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uV2GEkDk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 378891F38D;
	Wed, 11 Dec 2024 19:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733946357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8OrGjd8V05kU8sW3+usnPdy6Ph16o9wcMZjh9kKN8X0=;
	b=p1Gt0BMoNegn9/bsi/7F04zMVbAUtcYk8s1pLSyZXLbb1iA5A6SyHQiumY0Y8Mg//sSdZt
	gL7wckfXzX10mN1UuxizzP31aqDtF6BlAU7TjlMkyB77Rh0fAm1sBikv8sL9Rc0eDmmr8h
	RAsnAMFsa6H9kSGWJ15Ixc4s7tj7FAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733946357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8OrGjd8V05kU8sW3+usnPdy6Ph16o9wcMZjh9kKN8X0=;
	b=uV2GEkDkTMVGB7AFJIrhj9OnE6gYAVosHOSre4v1s2YdUYsYpdcDXhSHv9P+dB/CeOy5bU
	4FJTPRmUJKywKiDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733946357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8OrGjd8V05kU8sW3+usnPdy6Ph16o9wcMZjh9kKN8X0=;
	b=p1Gt0BMoNegn9/bsi/7F04zMVbAUtcYk8s1pLSyZXLbb1iA5A6SyHQiumY0Y8Mg//sSdZt
	gL7wckfXzX10mN1UuxizzP31aqDtF6BlAU7TjlMkyB77Rh0fAm1sBikv8sL9Rc0eDmmr8h
	RAsnAMFsa6H9kSGWJ15Ixc4s7tj7FAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733946357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8OrGjd8V05kU8sW3+usnPdy6Ph16o9wcMZjh9kKN8X0=;
	b=uV2GEkDkTMVGB7AFJIrhj9OnE6gYAVosHOSre4v1s2YdUYsYpdcDXhSHv9P+dB/CeOy5bU
	4FJTPRmUJKywKiDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED7F51344A;
	Wed, 11 Dec 2024 19:45:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xBW+LfTrWWfLEgAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 11 Dec 2024 19:45:56 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,  Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>,  "hanqi@vivo.com" <hanqi@vivo.com>,
 "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Unicode conversion issue
In-Reply-To: <Z1nG-PSEe6tPOZIG@google.com> (Jaegeuk Kim's message of "Wed, 11
	Dec 2024 17:08:08 +0000")
Organization: SUSE
References: <Z1mzu4Eg6CPURra3@google.com> <87v7vqyzh4.fsf@mailhost.krisman.be>
	<Z1nG-PSEe6tPOZIG@google.com>
Date: Wed, 11 Dec 2024 14:45:51 -0500
Message-ID: <87cyhyuhow.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Jaegeuk Kim <jaegeuk@kernel.org> writes:

> On 12/11, Gabriel Krisman Bertazi wrote:
>> Jaegeuk Kim <jaegeuk@kernel.org> writes:
>>=20
>> > Hi Linus/Gabriel,
>> >
>> > Once Android applied the below patch [1], some special characters star=
ted to be
>> > converted differently resulting in different length, so that f2fs cann=
ot find
>> > the filename correctly which was created when the kernel didn't have [=
1].
>> >
>> > There is one bug report in [2] where describes more details. In order =
to avoid
>> > this, could you please consider reverting [1] asap? Or, is there any o=
ther
>> > way to keep the conversion while addressing CVE? It's very hard for f2=
fs to
>> > distinguish two valid converted lengths before/after [1].
>>=20
>> I got this report yesterday. I'm looking into it.
>>=20
>> It seems commit 5c26d2f1d3f5 ("unicode: Don't special case ignorable
>> code points") has affected more than ignorable code points, because that
>> U+2764 is not marked as Ignorable in the unicode database.
>>=20
>> I still think the solution to the original issue is eliminating
>> ignorable code points, and that should be fine.  Let me look at why this
>> block of characters is mishandled.

I was struggling to reproduce it, until I copy-pasted the character
directly from the bugzilla:

The character the user has is =E2=9D=A4=EF=B8=8F, which is different than j=
ust =E2=9D=A4.  This
is a combination of:

U+2764 + U+FE0F  (Heavy Black Heart + Variation Selector-16)

Variation Selector-16 is an ignorable character with zero length,
exactly what we wanted to ignore with that patch.  What I didn't
consider in the original submission was that, differently from other
ignorable code-points, this block might be used intentionally in a filename.

> Thank you so much. If it takes some time to find the root cause, may I
> propose the revert first to unblock production? The problem is quite seve=
re
> as users cannot access their files.

We have 3 ways forward.

1) The first is to revert the patch and fix the original issue in a
different way.  That would be: We would restore the original database
and treat Ignorable codepoints as folding to themselves only when doing
string comparisons, but not when calculating hashes.  This way, the hash
will be the same, but filenames with Ignorable codepoints will be
handled as byte sequences.

2) We keep the original patch and add support in fsck to update the
hashes in volumes like the above.

3) We regenerate the database to Ignore codepoints in the code-block
FE00..FE0F.  That would be the simplest, solution, but there might be
more cases that need fixing later.

At this point, I'd be pending torwards 1 or 3.  Both of them can be done
after reverting my original patch, so I'm fine with that.  Thoughts?

> Thank you so much. If it takes some time to find the root cause, may I
> propose the revert first to unblock production? The problem is quite
> severe as users cannot access their files.

I don't oppose this, considering the case at hand.  I'll base the new patch
on top of the revert.

--=20
Gabriel Krisman Bertazi

