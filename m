Return-Path: <linux-kernel+bounces-219007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD16A90C8B6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0BB1C21438
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8866C20C5C7;
	Tue, 18 Jun 2024 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IlYU1xWQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WjnYU5Lx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IlYU1xWQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WjnYU5Lx"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7647820C5BE;
	Tue, 18 Jun 2024 09:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704761; cv=none; b=ClTEtHMM9g5Vaj3TTPeipmwSMc+aKe8yUoKKWDYtRLvWRQYNZU67YirVV3hg/VoejBHd+jKgPOsVu1B1LsqDMj965kXT6qsgrvd/An4kk+IKwEznGzqsCav0yWgrW39QFa58Hkc3O0vCht784coRDPl5QKtpObD6KMpjyYC+CdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704761; c=relaxed/simple;
	bh=L3qeKQQRK6Iprq9subFYFaensWSCe60F3QVCEp9Kunk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kq2g/piKA1dNhv591tK/LhPYxzRkSQ8kJDbeCDvUQlA6lbCVscZdTbN9cY7rP3k96dWV9RHfOxGKz+Ds8dowjwvMzfFGC0P8Cump8drV4QaENaJVWQT15kAfETpgKvUGlqyY/SeYPTiA3/bchCDHY+JSKxzt82mvPfHzSGtlZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IlYU1xWQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WjnYU5Lx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IlYU1xWQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WjnYU5Lx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A3D4F219C0;
	Tue, 18 Jun 2024 09:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718704755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NUFX9xaFe7q6ArFtxXLJLomzd++uGohwBj3p9L5MCOs=;
	b=IlYU1xWQ000RPsC/f35+4KSMztTsMoOpCmJk1kCjsSEOrgJpDTljZZAL+egVQuSNh1nlNn
	zyoP162320n5/4kGuK84CACAaI2dCLH+k/lZ1bKDI/yQN9TH9z5+soLb/FsqCv2cebMUqa
	ihMtgosWUjg1godMbvafMlE7BpAPg2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718704755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NUFX9xaFe7q6ArFtxXLJLomzd++uGohwBj3p9L5MCOs=;
	b=WjnYU5LxXd0O3ybigaDFe1ibPT9BPt0mG3G0UUhwDs/UxyU/9zg6cqvQkXKrN6lPqQszZ4
	oRPj1FAcAJiuKLBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718704755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NUFX9xaFe7q6ArFtxXLJLomzd++uGohwBj3p9L5MCOs=;
	b=IlYU1xWQ000RPsC/f35+4KSMztTsMoOpCmJk1kCjsSEOrgJpDTljZZAL+egVQuSNh1nlNn
	zyoP162320n5/4kGuK84CACAaI2dCLH+k/lZ1bKDI/yQN9TH9z5+soLb/FsqCv2cebMUqa
	ihMtgosWUjg1godMbvafMlE7BpAPg2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718704755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NUFX9xaFe7q6ArFtxXLJLomzd++uGohwBj3p9L5MCOs=;
	b=WjnYU5LxXd0O3ybigaDFe1ibPT9BPt0mG3G0UUhwDs/UxyU/9zg6cqvQkXKrN6lPqQszZ4
	oRPj1FAcAJiuKLBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D89A13AA0;
	Tue, 18 Jun 2024 09:59:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AiHtIXNacWaHIgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 18 Jun 2024 09:59:15 +0000
Date: Tue, 18 Jun 2024 11:59:41 +0200
Message-ID: <87h6dq7er6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: bo liu <bo.liu@senarytech.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5] ALSA: hda/senarytech: add senarytech codec support
In-Reply-To: <20240618010121.67335-1-bo.liu@senarytech.com>
References: <20240618010121.67335-1-bo.liu@senarytech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Tue, 18 Jun 2024 03:01:21 +0200,
bo liu wrote:
> 
> Add initial Senarytech codec support for SN6186. Note that this hda
> patch relies on the configuration default registers to be set correctly
> (normally by BIOS/firmware) in order for it to set up pin widgets
> properly.
> 
> Signed-off-by: bo liu <bo.liu@senarytech.com>

Applied to for-next branch now.  Thanks.


Takashi

