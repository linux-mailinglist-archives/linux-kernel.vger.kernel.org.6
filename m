Return-Path: <linux-kernel+bounces-229256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E53916D70
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFB21C21CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B6016FF5F;
	Tue, 25 Jun 2024 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kVtp96ts";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kItZ26Ub";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kVtp96ts";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kItZ26Ub"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4742416DEA4;
	Tue, 25 Jun 2024 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330577; cv=none; b=XRPpjT6OuJ4mtynL9LXUuUoqlvU753rk8kgSqNt4lthbdp+ugbcaZeKIOkUd9i2Wli+1ijCoHkOPg1NJWHEHSxBmkSAdwZW8ZiaIl29n6Cnajzcge6NN3v4y5dsS3kM+r9KqF3+w2EpVEz9D3L/Bjmo8RJieC+RjM5vp2qH8iuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330577; c=relaxed/simple;
	bh=sUIvPr5TwhY0q7QPahwTBtOYZADYoIVdqXPCUaN45QE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrrqHWfzT4YCLDZSRciXexbGPTP0D8huSjQKGglUC4VUB40d8r8QvkzMkMyAd+imBEQ863blRDPjg4CLPt7xGoRS1sW1gJYSkNbKPxnZxAxauOzPpVoTY5DN2XredpgalQeXk7d0v9nFO20zZnL2WRQyThbc/BEhje8VkWrIlrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kVtp96ts; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kItZ26Ub; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kVtp96ts; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kItZ26Ub; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5CE9A219C5;
	Tue, 25 Jun 2024 15:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719330573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kw99qVZz3ZF+3mnj5cm4S1a48bOPXeIsywDzO8R5Pas=;
	b=kVtp96tsZGU0H/gj4nJScyjfusw1eAFBtepiuKAQayde5rtPevqAfIpxrbDtslEAjLAAuW
	cQ5n9EvZCl72jUwlicwKEQW01UrmWCHaRU6ianbeGw247IfapbradyZthcYmhVFduZpCYY
	iSB8KyWO1ike0KhjOId2OKmVFzOp1fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719330573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kw99qVZz3ZF+3mnj5cm4S1a48bOPXeIsywDzO8R5Pas=;
	b=kItZ26Ub03uK5X6n1TRXpfeacTeUPOdu7DdUjhfzLGoM7m+7aFelGgAQzYNnXVK5FqbhtA
	kndDr4irkG01XoAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719330573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kw99qVZz3ZF+3mnj5cm4S1a48bOPXeIsywDzO8R5Pas=;
	b=kVtp96tsZGU0H/gj4nJScyjfusw1eAFBtepiuKAQayde5rtPevqAfIpxrbDtslEAjLAAuW
	cQ5n9EvZCl72jUwlicwKEQW01UrmWCHaRU6ianbeGw247IfapbradyZthcYmhVFduZpCYY
	iSB8KyWO1ike0KhjOId2OKmVFzOp1fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719330573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kw99qVZz3ZF+3mnj5cm4S1a48bOPXeIsywDzO8R5Pas=;
	b=kItZ26Ub03uK5X6n1TRXpfeacTeUPOdu7DdUjhfzLGoM7m+7aFelGgAQzYNnXVK5FqbhtA
	kndDr4irkG01XoAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E205513A9A;
	Tue, 25 Jun 2024 15:49:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gh3kNQznemboRQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 25 Jun 2024 15:49:32 +0000
Date: Tue, 25 Jun 2024 17:50:00 +0200
Message-ID: <87ikxxkonr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Rauty <rautyrauty@gmail.com>
Cc: wzhd@ustc.edu,
	Gergo Koteles <soyer@irl.hu>,
	alsa-devel@alsa-project.org,
	tiwai@suse.com,
	perex@perex.cz,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	luke@ljones.dev,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable headset mic on IdeaPad 330-17IKB 81DM
In-Reply-To: <CAGpJQTHajQnOr7Tr8cmMyjBqGw1sg_-SwSuAhnz-yFHZdPukGw@mail.gmail.com>
References: <20240615125457.167844-1-rauty@altlinux.org>
	<2c9ba341bc95d4b9010bf5f8794c0d14b1c57dc9.camel@irl.hu>
	<CAGpJQTHoBAixmxta2WuZfjHjiK9GXF=hkfPyV7PBD5rt9Z_0WA@mail.gmail.com>
	<CAGpJQTGqxEkfp003QLsp-syUgzDFCmHSmNaoOaem0ZMVf7_=bg@mail.gmail.com>
	<c0a9e15e7926e098bdea97a7d31c32427e0910c9.camel@irl.hu>
	<871q4lm9dp.wl-tiwai@suse.de>
	<CAGpJQTFF=gKN2h105dGhBOEhN0Q1Tpj5hJWpSdQ_-nCoUTzj5A@mail.gmail.com>
	<87tthhktdz.wl-tiwai@suse.de>
	<87sex1kt6t.wl-tiwai@suse.de>
	<CAGpJQTGR5WKuHUFGFUC286TUkOXYgcqigZRDb4K5deyE9uuz8w@mail.gmail.com>
	<87msn9ksj6.wl-tiwai@suse.de>
	<CAGpJQTHajQnOr7Tr8cmMyjBqGw1sg_-SwSuAhnz-yFHZdPukGw@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Tue, 25 Jun 2024 16:47:34 +0200,
Rauty wrote:
> 
> On Tue, 25 Jun 2024 at 17:25, Takashi Iwai <tiwai@suse.de> wrote:
> > Great.  Could you also give the one for IdeaPad 330?
> 
> http://alsa-project.org/db/?f=cb04b699a8aaa07e0bd992dfc92accb993dc0a97

Thanks.  I'll cook a fix patch and submit.


Takashi

