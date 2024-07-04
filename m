Return-Path: <linux-kernel+bounces-241047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A77927644
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50170284376
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5701AE843;
	Thu,  4 Jul 2024 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IQnGSDSe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZFGryK0h";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k7lyz6lc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pWb2af+o"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57D826289;
	Thu,  4 Jul 2024 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097264; cv=none; b=u4Im+7S2VvAYh/mqvwGnqRQODyruM93fN0zuZQKDG0bpox1Ko8iUy5PbBilqmgogqvhbVRzUV76+lCAckztrU4+HA2iLw1GYUa/IwNi5IvwOSKlhIPH+Xqph1g+jRoPS8yJysIyB4iYK0XW7XLW25nakxQF9PF59uqTRKFzk0Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097264; c=relaxed/simple;
	bh=kdfPgfLH2eKr1DB40Cao0am5YIfhG3zVoKyzwH1q/To=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2OK0kZUQMVUYFji6ckFYCPyuGEjovDRMTviaZIbM2cS+VtuYfue+H4X6JtOnwJgzQLBqnKA9xEId37xPN0EJ7/ml8Fl1Rqn92jVkvytQAkWEOlwYuLbWPAly1alpDXGLaJ0yRg+ianbSA0bMkOAMfpek1XwWl9/jRmUZJOfoxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IQnGSDSe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZFGryK0h; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k7lyz6lc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pWb2af+o; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED5D71F7BC;
	Thu,  4 Jul 2024 12:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720097261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vZvUaSXnMBp8WbLMLQCJEmFkGGzth3JwyEnW4gQ1isA=;
	b=IQnGSDSedRuHGb7MdcH7ELAXpgJ/NTpBt639jlx5jdHvO0ncrgfngHhL/MvDhHt0r30xWY
	//HSwtiM2kI7JQC5Tn9FRR9IrExQ13RhHyvDzUjAqNdtEADv27Z5FqI5TKzgf3AVBt+Azr
	ef63YITuSmen8Xis9jVcs6wzwq6xzs8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720097261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vZvUaSXnMBp8WbLMLQCJEmFkGGzth3JwyEnW4gQ1isA=;
	b=ZFGryK0h+R4aQgeGvn4d5Ii5/8tBTAMMYlRpX2SgusrIBBqGXNiLh0ddM+nWqLyEkoAvBE
	SDfk6bcFHk8QtuAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=k7lyz6lc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pWb2af+o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720097260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vZvUaSXnMBp8WbLMLQCJEmFkGGzth3JwyEnW4gQ1isA=;
	b=k7lyz6lcurJ/+feJ2ukA9D23VUjr0wHCUdOA0nRcGvS0TNNco7peL9NfOLZNBdZpm4zCb8
	19Z0YQezbtLFM2tdr3SPPo45SJB3P3j3W7p9YQ+YTHrExTVBmOfUEMWodjy2OM1IejolzC
	qG5n6khQCkid42jCpSw2iMn9wTejp98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720097260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vZvUaSXnMBp8WbLMLQCJEmFkGGzth3JwyEnW4gQ1isA=;
	b=pWb2af+oLw1PGlWdEbflp2uPXXY4gKO7Dak8y/fa8Lr45xFGMkep0navrn2MbzbLyV5z1a
	0gIVYP3em7jTAhDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B951013889;
	Thu,  4 Jul 2024 12:47:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C3DwK+yZhmaXEwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 04 Jul 2024 12:47:40 +0000
Date: Thu, 04 Jul 2024 14:48:10 +0200
Message-ID: <87plrtiar9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH v1] ALSA: hda: cs35l41: Fix missing Speaker ID GPIO description in _DSD
In-Reply-To: <20240703140802.27688-1-sbinding@opensource.cirrus.com>
References: <20240703140802.27688-1-sbinding@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: ED5D71F7BC
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed, 03 Jul 2024 16:07:28 +0200,
Stefan Binding wrote:
> 
> Laptop 10431A63 contains valid _DSD, but missing Speaker ID
> description. Add this discription, but keep the rest of the _DSD to
> ensure the correct firmware and tuning is loaded for this laptop.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>

Applied to for-next branch now.  Thanks.


Takashi

