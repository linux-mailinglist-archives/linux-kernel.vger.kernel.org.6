Return-Path: <linux-kernel+bounces-429503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE90B9E1CEB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CEAC283E07
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543881E009F;
	Tue,  3 Dec 2024 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nk8t79Yp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gcQxrPHy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YPyMd442";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jiutT6P4"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C961E47C4
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230869; cv=none; b=tAnX1Qc8KmbAhXBinNuJ1Y/KdaLxwMwOhbLqPl+T2SGotsaqqdajZxxFbqJ69VY9uvKD9k0t1h/1icTmIfAJHTW9vJhgU4kSsAzI8eR9KYkMMXotpdZKGBfTkGoSSa4X54sVmvw5St86jZ8UntscZxZBwryXxn7foZTiXLGZM5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230869; c=relaxed/simple;
	bh=6/fvOgPrTLYamwnv1Zth5SmXTM1ABQjJxkbcKyPz05k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xvu/Y8PAhlBAWnCHRd5v93qCq/OIH3TMorwOQaKHsXHJOzHxozVON67SlLPksIkhfmHEnHPe3J2kmImZjCGw07HJ4M/r1THE7xs+2hAKujNEvi5WOQVjbR7ewdwsOGIegGp2wbJYo6F3YOeqE6eOaHNdu2EZfy2CvnQqL4gVu5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nk8t79Yp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gcQxrPHy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YPyMd442; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jiutT6P4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B71D21F445;
	Tue,  3 Dec 2024 13:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733230866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s9Nh0QOVGExhLfgNwBaGCf61xjMRo7aLosWJrB8D6S0=;
	b=nk8t79YpHMkBYNLGFKHI0c852nDsrq7RjqXXrRZhp8QR9bEDfdfRUFCf62uynRtwZrByJh
	/HOB+d8ImO5x53OaJju1kUCds1vS4uc+QzJop6vpy6rK+/hqAHuBe+fb274bBQKat0JKOu
	Dl74jVnvaBYdvevjU5r6wA/AcwSQ0jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733230866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s9Nh0QOVGExhLfgNwBaGCf61xjMRo7aLosWJrB8D6S0=;
	b=gcQxrPHyusGeGVNiPyN8B2StUvqeSz9r4KZwctsCPavoZ4JvB1o+7QkGUPmQM18YuWOxMK
	/Vp2EyOVMLLzZxAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733230864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s9Nh0QOVGExhLfgNwBaGCf61xjMRo7aLosWJrB8D6S0=;
	b=YPyMd442WpD7vxZlmn0m/7s0wv7k6txAwCZkAQZQHMKqW2TdzjOWHINP2Lg2gVIXwVHHpj
	siwHCd+0GXzrM8VegkkUSX1bDOnUBUoJLL4oSp6UcHID0ofLHWBRX4g/aw9viAmQnlZs/1
	0A9Flke3J+8sNW0sAtAm/aGgA68D8LI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733230864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s9Nh0QOVGExhLfgNwBaGCf61xjMRo7aLosWJrB8D6S0=;
	b=jiutT6P4nRv68TugVn7IXmBHEIVr/JZ2GvVum0Au+opLT9+dkqfFxHMnJ5lrwkhoSJVTU5
	eK5mkW8zxYepBVCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC4C3139C2;
	Tue,  3 Dec 2024 13:01:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WeoKKhABT2dKFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Dec 2024 13:01:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6851FA08FB; Tue,  3 Dec 2024 14:01:00 +0100 (CET)
Date: Tue, 3 Dec 2024 14:01:00 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+d472c32c5dd4cd2fb5c5@syzkaller.appspotmail.com>
Cc: daniel.vetter@ffwll.ch, jack@suse.com, linux-kernel@vger.kernel.org,
	mairacanal@riseup.net, mcanal@igalia.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [udf?] possible deadlock in udf_free_blocks
Message-ID: <20241203130100.vgqav3cs7pvvyk5s@quack3>
References: <67290b04.050a0220.2edce.14f8.GAE@google.com>
 <674efc5f.050a0220.48a03.0035.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <674efc5f.050a0220.48a03.0035.GAE@google.com>
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=91c852e3d1d7c1a6];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[d472c32c5dd4cd2fb5c5];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,igalia.com:email,goo.gl:url,appspotmail.com:email,syzkaller.appspot.com:url];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 03-12-24 04:41:03, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 7908632f2927b65f7486ae6b67c24071666ba43f
> Author: Maíra Canal <mcanal@igalia.com>
> Date:   Thu Sep 14 10:19:02 2023 +0000
> 
>     Revert "drm/vkms: Fix race-condition between the hrtimer and the atomic commit"

This is obviously bogus. Apparently the reproducer is not quite reliable...
But I can see where's the problem in UDF code.

								Honza

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13dbe80f980000
> start commit:   cdd30ebb1b9f module: Convert symbol namespace to string li..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=103be80f980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=17dbe80f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=91c852e3d1d7c1a6
> dashboard link: https://syzkaller.appspot.com/bug?extid=d472c32c5dd4cd2fb5c5
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117440f8580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1659b5e8580000
> 
> Reported-by: syzbot+d472c32c5dd4cd2fb5c5@syzkaller.appspotmail.com
> Fixes: 7908632f2927 ("Revert "drm/vkms: Fix race-condition between the hrtimer and the atomic commit"")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

