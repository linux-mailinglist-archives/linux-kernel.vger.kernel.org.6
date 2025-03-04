Return-Path: <linux-kernel+bounces-543506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FF6A4D665
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8243AAF74
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535EF1FC7E5;
	Tue,  4 Mar 2025 08:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H03S3QAs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I479LckR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H03S3QAs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I479LckR"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B3D1FC7DC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077005; cv=none; b=RoGxrOoQglh3OILAjU/5pL9oVhlig/JArdi33fPDlTUGC/Ht9zmogkbZMWOWEiG+peUgD8eRbsujYGCHFzcBHw7tOg0FbFTUvhtqq9FK3YsuTOXBao2Lc2w8TbSOucjIHIkq3CTBDRJUXHR8QNFWMIWZ6083DsI5lRFL6MY6gf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077005; c=relaxed/simple;
	bh=qZX/k7rR1550QFMgP/CAN3hwJDiPhHLLlqueXHPu1cM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h93fhps/+9ai6pwktXtf2ROPoktQyhICbf719WJlxYV5rndp5Y2X+4rdHw/04ceoU5izfDcD9qsgFDUv9O88nD7dRnW3cx0hX//WyUKeaRoGS6AtMXn8TWZQdBkdnNZapbFZsvp2DZjplnBrCbdLmXRFXhJT1nauFXEiKLQ+4f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H03S3QAs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I479LckR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H03S3QAs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I479LckR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73C291F785;
	Tue,  4 Mar 2025 08:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741077001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXFuYCyGgWo6k+7zwMgSpre+FC1SzKnV4NZeUKEHMwo=;
	b=H03S3QAsxYKA8a0roejVW0ctVuvaE/o2+YOApxmUdyjJaalgLE+wA15sdMnKxPAqLbZSx8
	dMSibUeYtaF2tpwm3ZFC73nmT6fZOX2i3w8hZNdTF7zoDYdSrEgnxB5B2HS6s3QdGWi4Ol
	cOoNrOAnqvTi44oLEwquejvFSsNmDKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741077001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXFuYCyGgWo6k+7zwMgSpre+FC1SzKnV4NZeUKEHMwo=;
	b=I479LckRDFRdScattXtAM3u3TiVi/AXXdtfRWaObLKmPQp+avxUfVKc119rZBBHM8jzjvG
	wpI9Q5yRP5Ynx4Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741077001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXFuYCyGgWo6k+7zwMgSpre+FC1SzKnV4NZeUKEHMwo=;
	b=H03S3QAsxYKA8a0roejVW0ctVuvaE/o2+YOApxmUdyjJaalgLE+wA15sdMnKxPAqLbZSx8
	dMSibUeYtaF2tpwm3ZFC73nmT6fZOX2i3w8hZNdTF7zoDYdSrEgnxB5B2HS6s3QdGWi4Ol
	cOoNrOAnqvTi44oLEwquejvFSsNmDKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741077001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXFuYCyGgWo6k+7zwMgSpre+FC1SzKnV4NZeUKEHMwo=;
	b=I479LckRDFRdScattXtAM3u3TiVi/AXXdtfRWaObLKmPQp+avxUfVKc119rZBBHM8jzjvG
	wpI9Q5yRP5Ynx4Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 341911393C;
	Tue,  4 Mar 2025 08:30:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ge/VCgm6xmdvOQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 04 Mar 2025 08:30:01 +0000
Date: Tue, 04 Mar 2025 09:30:00 +0100
Message-ID: <87a5a1ci5z.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kailang <kailang@realtek.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	"Maciej S. Szmigiero"
	<mail@maciej.szmigiero.name>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable PC beep passthrough for HP EliteBook 855 G7
In-Reply-To: <31416b81a4f646239d8a17a0fbc71e79@realtek.com>
References: <7461f695b4daed80f2fc4b1463ead47f04f9ad05.1739741254.git.mail@maciej.szmigiero.name>
	<87jz9o99ef.wl-tiwai@suse.de>
	<a02344f2-3b99-41ea-af64-8d2bcb01e435@maciej.szmigiero.name>
	<87h64s972a.wl-tiwai@suse.de>
	<6224620265674b09b5762f908b5158f9@realtek.com>
	<2fea9fe8-312f-45a0-9bed-455c910fba43@maciej.szmigiero.name>
	<87ldtme10m.wl-tiwai@suse.de>
	<31416b81a4f646239d8a17a0fbc71e79@realtek.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Tue, 04 Mar 2025 07:26:13 +0100,
Kailang wrote:
> 
> Like below.
> 
> Acked-by: kailang@realtek.com

Thanks for confirmation, now I applied to for-next ebranch.


Takashi

