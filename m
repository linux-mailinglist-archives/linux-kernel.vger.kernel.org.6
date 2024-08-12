Return-Path: <linux-kernel+bounces-282703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C177D94E7A7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3CD1F23909
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43267154C02;
	Mon, 12 Aug 2024 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jjN8SK0l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t6U4kexQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l3ueS+Uz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dGJ9A0t2"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A901537C8;
	Mon, 12 Aug 2024 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723447336; cv=none; b=atbITF6dSTecleWC79BTQIdEFOdOIpYyj3CyAvmVkSx5Z37DDeXW04HNAnIBHrN2HdELLpA2d5ZcUXNGtTfK9gJuibaIkjB+n3BKpYltfk4vojOxKw2wNXxt38FMygE2XcRfYpIO0ijYE5WlSKfZjTgu4tUnhApVBVaDkAMLF5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723447336; c=relaxed/simple;
	bh=A2rG0fkoaR9v1JYsr2IqK/lB76jhyMnLAI9KsP0ivyk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbf+pQj65lLb8YJN7p6HFKa89snwtop8WhdsQ3kppQseHS5OwbkDatVqGDhypGSR+0spQf3zFoz423mut0i/O9DeS1IxalynXKdL5QuT3bVzdjbb6kD/8rB+InalHLQMuw5vxBB9FhsP8K4Y1FbmAGBgutMxevEulywoPEpzyl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jjN8SK0l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t6U4kexQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l3ueS+Uz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dGJ9A0t2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 34BFA2022C;
	Mon, 12 Aug 2024 07:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723447333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZrrEswf3+iR9+haBuX7DPZRPFGCMATARm8eopRURJI=;
	b=jjN8SK0lUwxKa0zMcC2NehlFKHbP0S4bu4fC6gwZEdMNeFkGENFt19D3xnOdYceuDR7Dc9
	PQ80ha1ymgCYgDANEvEo5uMPjoXmuOvhdOAWAQ5mmzLIncwRNYlNZsYjtPn5Pc/zgRfdxq
	x4p63Lx3ygl+pqF80w4U0KzQsem6up0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723447333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZrrEswf3+iR9+haBuX7DPZRPFGCMATARm8eopRURJI=;
	b=t6U4kexQyyXvUW0s98tM9cYN26Yt8r9gr8mbNOSOsDxLOQeoxd7bdTKsZElDDMX3InIF22
	MjeD07b+N6N4LtBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=l3ueS+Uz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dGJ9A0t2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723447332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZrrEswf3+iR9+haBuX7DPZRPFGCMATARm8eopRURJI=;
	b=l3ueS+UzAfHF1J5qe6m2JfKXmExkere4KuzpOTtaNkq2KPLQIJdiDZd8P426Jj7Rb2iRaJ
	i5zoJ48bQmrtiesf09j9pO7xa8ZrFDvUm2bZxvUQ2iwDFEqgkgSeM5h83tbxOqs0Ese8d3
	/ICQch+wfLiB1eLqlAEY6x+Rjh79FgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723447332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZrrEswf3+iR9+haBuX7DPZRPFGCMATARm8eopRURJI=;
	b=dGJ9A0t2TSXgufUGWYLpnNr0i0W8x2Thv/zjA1hGDhOd47gyuwfRzNRmXLkwzkBQsjvdr6
	+yfoGZxGoDedENDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD3FA137BA;
	Mon, 12 Aug 2024 07:22:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eInMMCO4uWYoDAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 12 Aug 2024 07:22:11 +0000
Date: Mon, 12 Aug 2024 09:22:52 +0200
Message-ID: <87h6bq2oj7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?GB2312?B?uvrBrMfa?= <hulianqin@vivo.com>
Cc: "perex@perex.cz" <perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>,
	"mbarriolinares@gmail.com" <mbarriolinares@gmail.com>,
	"wangdicheng@kylinos.cn" <wangdicheng@kylinos.cn>,
	"sean@mess.org"
	<sean@mess.org>,
	"alexander@tsoy.me" <alexander@tsoy.me>,
	"xristos.thes@gmail.com" <xristos.thes@gmail.com>,
	"knuesel@gmail.com"
	<knuesel@gmail.com>,
	"linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] ALSA: usb-audio: Add delay quirk for VIVO USB-C-XE710 HEADSET
In-Reply-To: <TYUPR06MB6217FF67076AF3E49E12C877D2842@TYUPR06MB6217.apcprd06.prod.outlook.com>
References: <TYUPR06MB6217FF67076AF3E49E12C877D2842@TYUPR06MB6217.apcprd06.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,gmail.com,kylinos.cn,mess.org,tsoy.me,vger.kernel.org,vivo.com,linux-foundation.org];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,vivo.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 34BFA2022C

On Sun, 11 Aug 2024 10:30:11 +0200,
ºúÁ¬ÇÚ wrote:
> 
> From: Lianqin Hu <hulianqin@vivo.com>
> 
> Audio control requests that sets sampling frequency sometimes fail on
> this card. Adding delay between control messages eliminates that problem.
> 
> Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
> ---
> v1:
>   - Modify the code position and sort by ID

Thanks, applied to for-linus branch now.


Takashi

