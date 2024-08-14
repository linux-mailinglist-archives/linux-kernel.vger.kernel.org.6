Return-Path: <linux-kernel+bounces-286407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D654D951A90
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100D11C20BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB931AED33;
	Wed, 14 Aug 2024 12:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MsnJ1lo8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XNZgkjj8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MsnJ1lo8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XNZgkjj8"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8630C1AC44E;
	Wed, 14 Aug 2024 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637345; cv=none; b=J84UMTdLflWshWylV3d6gS8wIICHJ/jOkEKR7+tsM4vMchmD4baWjtuDqEP5VP8/JzdVRo6BmwqfI+dcT2hjesSaezbSn6rYUMuqvBcIfcvPt9hDqN4xllPupjMXU2paT102hZ1IwQMHlEo9T9aGOvVdcAgUiJvWwH27v7E9QTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637345; c=relaxed/simple;
	bh=zr8orGslI/q92JWipAmtiu3y5TznN52mC6/AGAEi5LA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWHiGGCPHIUmr8srlt0bF2vYEWxe5RC3hlX/oWAlhaaUa9k+Q+9RLEyak3HaXPNgIN2P+gizhtaT1DGPx8N2hXJXZ8H/lomWPeRcgkcVgz68HZpT8EK+AseLdyPrM9dyBQkFRWnYq6mn84+TKFl0S/NVV5XDKrCnvCdTSGgOhy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MsnJ1lo8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XNZgkjj8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MsnJ1lo8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XNZgkjj8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6E9302279F;
	Wed, 14 Aug 2024 12:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723637340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4A+Kh5HoW9r9fmuGW4MDEGLJIW3jMEkAN+BzmrGgoYs=;
	b=MsnJ1lo81sNlfy7nB+yFwR9B6oaNAC9bNQ/Q4IKgeB+wPkLps7c/EqaxPDCkX5kaM4yZ4w
	bRMFMSEa86/JaI25bJRRPsB9RhArM7mBjcpRzN664/YNBzywvfCHZS9z34vHweFbWd+kM2
	MlXWA+efJ0EFx8oR9vQY1/P2Pz3WFBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723637340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4A+Kh5HoW9r9fmuGW4MDEGLJIW3jMEkAN+BzmrGgoYs=;
	b=XNZgkjj8sQO2lrxfvdoKf9tCJBNabEDk/OHu7Aw83X5FbOeIwb1YrobqRz8w17yLkvlqOh
	G+PJ7FS6Id1DKRCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MsnJ1lo8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XNZgkjj8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723637340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4A+Kh5HoW9r9fmuGW4MDEGLJIW3jMEkAN+BzmrGgoYs=;
	b=MsnJ1lo81sNlfy7nB+yFwR9B6oaNAC9bNQ/Q4IKgeB+wPkLps7c/EqaxPDCkX5kaM4yZ4w
	bRMFMSEa86/JaI25bJRRPsB9RhArM7mBjcpRzN664/YNBzywvfCHZS9z34vHweFbWd+kM2
	MlXWA+efJ0EFx8oR9vQY1/P2Pz3WFBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723637340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4A+Kh5HoW9r9fmuGW4MDEGLJIW3jMEkAN+BzmrGgoYs=;
	b=XNZgkjj8sQO2lrxfvdoKf9tCJBNabEDk/OHu7Aw83X5FbOeIwb1YrobqRz8w17yLkvlqOh
	G+PJ7FS6Id1DKRCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 476B8139B9;
	Wed, 14 Aug 2024 12:09:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p5bgD1yevGbHJgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 14 Aug 2024 12:09:00 +0000
Date: Wed, 14 Aug 2024 14:09:40 +0200
Message-ID: <87v803jofv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Juan =?ISO-8859-1?Q?Jos=E9?= Arboleda <soyjuanarbol@gmail.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tiwai@suse.com
Subject: Re: [PATCH v3] ALSA: usb-audio: Support Yamaha P-125 quirk entry
In-Reply-To: <20240813161053.70256-1-soyjuanarbol@gmail.com>
References: <20240813161053.70256-1-soyjuanarbol@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spam-Score: -5.51
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 6E9302279F
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue, 13 Aug 2024 18:10:53 +0200,
Juan José Arboleda wrote:
> 
> This patch adds a USB quirk for the Yamaha P-125 digital piano.
> 
> Signed-off-by: Juan José Arboleda <soyjuanarbol@gmail.com>
> ---
> Hey! Thanks for taking the time to review my patch.
> 
> I had a little mistake in V2, I forgot to stage my new diff for
> amending. Sorry
> 
> Attending your sorting by id suggestion, I've moved the P-125 to the
> bottom.

Thanks, applied now to for-linus branch.


Takashi

