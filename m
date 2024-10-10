Return-Path: <linux-kernel+bounces-359382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABC3998ADB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9691C223DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18281CB324;
	Thu, 10 Oct 2024 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q9FN5kap";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uUEfZJVt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q9FN5kap";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uUEfZJVt"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589291D432A;
	Thu, 10 Oct 2024 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572318; cv=none; b=XQ2SCMHs5PUBxrNF1FqGL945tFAPKHDMnA5DMLoVx58nG8v+xTbq5+HTiaZISrGjjcE1PqEQ6ND7d55Oo1x1bh6M7kKgI+hH7t0PvpVm6uqvpc2gRwkX1lZ27YDn9fAY+CRosEeDOkkRAN8agn0S02tutyD40aFmMTU72+we+bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572318; c=relaxed/simple;
	bh=pYQo8clkJjegnIiz4TeOcbmRn3oFTYkfTcPqUpevkCU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcxMm5nYSb2/r5JCV972GleppHoeok+iZcV+8b9VzwBBMmtGbuuYejQ8tGbfaY8SUpwyu/dAfEMYfW5Z8z6KMAWFl8lWJZ3Hptun5Y1PI7IYJ3zwxoVQgKQ8qzQRwFay7m3jBbKNgB1CwMdJMImU+znKawuKHXPdAAfQNN4FYpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q9FN5kap; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uUEfZJVt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q9FN5kap; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uUEfZJVt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C4A61F7EC;
	Thu, 10 Oct 2024 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728572314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mb1IeCNGwz0RKcAN2v9gOKGnWubIRg0qTq39mv9DYTM=;
	b=q9FN5kapEJWm0mEjcEmIDgq/vrgPxIY+RN9JJ/nydZBFKpkaxPc18uR5FFdr2a2Gsbbi6c
	nW7d4soJgUA1//fwNajjB8DwEhjF4/ne0FHu4RV1Vt+GmzRO2yJxlkpMF6/o+98KEWrGpj
	CpspgbJjDEFsJGf7OOwumVPu5CBMzyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728572314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mb1IeCNGwz0RKcAN2v9gOKGnWubIRg0qTq39mv9DYTM=;
	b=uUEfZJVtE3avURb7KJbOtGVahQEbBsueRa9M2U02ijYMMv2ICK3b1sZsbnLYOxBZuhpyrZ
	b979z0Brebrsu5BQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=q9FN5kap;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uUEfZJVt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728572314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mb1IeCNGwz0RKcAN2v9gOKGnWubIRg0qTq39mv9DYTM=;
	b=q9FN5kapEJWm0mEjcEmIDgq/vrgPxIY+RN9JJ/nydZBFKpkaxPc18uR5FFdr2a2Gsbbi6c
	nW7d4soJgUA1//fwNajjB8DwEhjF4/ne0FHu4RV1Vt+GmzRO2yJxlkpMF6/o+98KEWrGpj
	CpspgbJjDEFsJGf7OOwumVPu5CBMzyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728572314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mb1IeCNGwz0RKcAN2v9gOKGnWubIRg0qTq39mv9DYTM=;
	b=uUEfZJVtE3avURb7KJbOtGVahQEbBsueRa9M2U02ijYMMv2ICK3b1sZsbnLYOxBZuhpyrZ
	b979z0Brebrsu5BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25DE61370C;
	Thu, 10 Oct 2024 14:58:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I3T4B5rrB2fhcQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 10 Oct 2024 14:58:34 +0000
Date: Thu, 10 Oct 2024 16:59:30 +0200
Message-ID: <87zfncypf1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Julian Vetter <jvetter@kalrayinc.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yann Sionneau
 <ysionneau@kalrayinc.com>
Subject: Re: [PATCH] sound: Make CONFIG_SND depend on INDIRECT_IOMEM instead of UML
In-Reply-To: <ac39c5f3-4ced-449e-8a42-45641b8243c4@kalrayinc.com>
References: <20241010124601.700528-1-jvetter@kalrayinc.com>
	<877cag11zb.wl-tiwai@suse.de>
	<ac39c5f3-4ced-449e-8a42-45641b8243c4@kalrayinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 5C4A61F7EC
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Thu, 10 Oct 2024 16:53:48 +0200,
Julian Vetter wrote:
> 
> 
> 
> On 10/10/24 16:12, Takashi Iwai wrote:
> > On Thu, 10 Oct 2024 14:46:01 +0200,
> > Julian Vetter wrote:
> >> 
> >> When building for the UM arch and neither INDIRECT_IOMEM=y, nor
> >> HAS_IOMEM=y is selected, it will fall back to the implementations from
> >> asm-generic/io.h for IO memcpy. But these fall-back functions just do a
> >> memcpy. So, instead of depending on UML, add dependency on 'HAS_IOMEM ||
> >> INDIRECT_IOMEM'.
> >> 
> >> Acked-by: Takashi Iwai <tiwai@suse.de>
> >> Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
> >> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
> > 
> > This is expected to be applied via sound.git tree?
> 
> Yes. At least I have abandoned this patch as part of my big patchset
> for the IO memcpy. Instead I try to integrate the different parts
> piece by piece in the different subsystems and archs. I thinks this is
> better, as suggested by Arnd.

OK, now applied to for-linus branch.


thanks,

Takashi

