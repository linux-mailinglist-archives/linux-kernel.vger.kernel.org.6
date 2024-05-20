Return-Path: <linux-kernel+bounces-184025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FAF8CA191
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39FF1281EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304C1137C28;
	Mon, 20 May 2024 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b6p4PhkO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2VNd7vNE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b6p4PhkO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2VNd7vNE"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246D41EA84
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716227535; cv=none; b=RlcV0M3OiFUg0LRZEfczwn5F5eZv2z3B/+tZEKpQGLIvoDsjcdwKFReNLXDQDXXTvYWHXQpPf5v/Nr12jTjhcuIGJy+B34jMet0H46ysvkkVr/SRZeQ+zhmKdnB8RfYzB32WEKkaMb9mQmiPC0PnCLS6kVrdUTd+WhTWo/s/h+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716227535; c=relaxed/simple;
	bh=dskuNHGafOpghIxTrA4VB0MntkGNf7WMNyoJFmo9/TY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n37ztB41qhd6DPMfbIvw3DeDPmj0LCuiWTM3EwIqoQkjC9zRnR+kDBMYX79i/BT1uSCQFb3cU7+7y12CDBn5bdQxOeW0wrXvAksjeH4RBBvHJdtuAtLij5SvrMOZhrj0QG2VcrWDI5W/49CYGLo0h9Kkoa98QekU6Xv2JZ09bvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b6p4PhkO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2VNd7vNE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b6p4PhkO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2VNd7vNE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0976B20965;
	Mon, 20 May 2024 17:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716227530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvCwQEI1j75fjDxDg8tBDx3T5EYmK65YDg1SZMaOtiQ=;
	b=b6p4PhkOBgk6SrXAIstbQhSeg9WnkOaOIF0Pc5H5vinwioUMJ3IetEtqztWO3IaBURnQP1
	6hGlOzAGabGpndRfhTZdGwkimnaLU8w16JaB8FMA3qR2wo00ZJnUdn75+qPEyBXbObb4Ft
	L43qQ/inWPtrFl+nW5Baw3gwh5BOMI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716227530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvCwQEI1j75fjDxDg8tBDx3T5EYmK65YDg1SZMaOtiQ=;
	b=2VNd7vNEoTqCZuN9eXJOgppg/4CdWw8+iDipRL1E6Xi3JyRWq2/seH21igcVESQaGtt5DF
	yhzXFSrVRiYW3NBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=b6p4PhkO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2VNd7vNE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716227530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvCwQEI1j75fjDxDg8tBDx3T5EYmK65YDg1SZMaOtiQ=;
	b=b6p4PhkOBgk6SrXAIstbQhSeg9WnkOaOIF0Pc5H5vinwioUMJ3IetEtqztWO3IaBURnQP1
	6hGlOzAGabGpndRfhTZdGwkimnaLU8w16JaB8FMA3qR2wo00ZJnUdn75+qPEyBXbObb4Ft
	L43qQ/inWPtrFl+nW5Baw3gwh5BOMI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716227530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvCwQEI1j75fjDxDg8tBDx3T5EYmK65YDg1SZMaOtiQ=;
	b=2VNd7vNEoTqCZuN9eXJOgppg/4CdWw8+iDipRL1E6Xi3JyRWq2/seH21igcVESQaGtt5DF
	yhzXFSrVRiYW3NBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89F8913A6B;
	Mon, 20 May 2024 17:52:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lVjaGsmNS2YzCAAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Mon, 20 May 2024 17:52:09 +0000
Date: Mon, 20 May 2024 19:52:05 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] dmi update for v6.10
Message-ID: <20240520195205.0a14f8bd@endymion.delvare>
In-Reply-To: <CAHk-=whxtT0O7yGX2n=Y3LQ0zJ0c8ZeYZDcbHfFOEiWHFp+qrQ@mail.gmail.com>
References: <20240520101221.463a1ec8@endymion.delvare>
	<CAHk-=whxtT0O7yGX2n=Y3LQ0zJ0c8ZeYZDcbHfFOEiWHFp+qrQ@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -6.33
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0976B20965
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.33 / 50.00];
	BAYES_HAM(-2.82)[99.23%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	HAS_ORG_HEADER(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On Mon, 20 May 2024 09:27:41 -0700, Linus Torvalds wrote:
> On Mon, 20 May 2024 at 01:12, Jean Delvare <jdelvare@suse.de> wrote:
> > * Bug fixes:
> >   - KCFI violation in dmi-id
> >   - Panic on broken (short) DMI table entry  
> 
> Well, I wasn't going to pull that based on the description, but it
> turns out it's not a panic at all, it's just a "stop decoding".
> 
> Because panicking on broken firmware would be horrible.

This is a list of bugs being fixed. The bug was a panic, the fix is
stop decoding.

Likewise, the other fix is not adding a KCFI violation.

Thanks for making my day :-D

Joke apart, I thought it was clear enough, but I take note to word
things differently next time.

-- 
Jean Delvare
SUSE L3 Support

