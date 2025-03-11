Return-Path: <linux-kernel+bounces-556386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F23A5C61D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA283A5D01
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA077E110;
	Tue, 11 Mar 2025 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y/f3K1Tk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MCdbE2Vo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wKEB6UkT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rMgPMNgp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3857B249F9
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706255; cv=none; b=QDtCQJ/wGWa/GLjkuDePJ5Yl7nfxgYJrewIKreQSRyQmQlwfBiA/dD6+5K9W+vvDWDvmrZ7C8htsr2aj5J5R6/3eIhVbAOZ6nPQlrNDEnT6aFsaD/zIQtF2TepNfV5upNwZVaeZFB44+i8S6wD43Fcm1x5w0ow+3HxEYPwCp81k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706255; c=relaxed/simple;
	bh=VS5nDS96Cae5AuI5jAIddvVWpVDmkdg+dL2DWK3+EU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XN2e2qpWwfM8X3W3Bbb9nFd4v18IfAAW/NMIZN6bq+18EFUT07sRPPs6n8PdDQRfxJSCaVbSDyrcEFX7HZyJLj8BX04ege5TJoiOpvsTsy1rXjKKGOGO4fgq8uk72GR7XuSTBSs6Wp+UOKTrO5rcdnbKM5K3jEqs+zodVOq/gvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y/f3K1Tk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MCdbE2Vo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wKEB6UkT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rMgPMNgp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 340B321180;
	Tue, 11 Mar 2025 15:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741706249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dms7KfDw50j2TeBALib2kafQnrtJKGKF9+qrPlXSLQM=;
	b=y/f3K1TkCzNtrnuwAWy97MgIKqmIk4tycEbxWe0pCMFfyTYRWBv+LvprLn/RvCBW6zXUmy
	7Q3oTCoe+MTBorPbJI5wWgOu8+x325ev2bf+ivfwoZV7meYKvK+w7Clq5YHoHCY9frcbsz
	EskC8XWws3D2BSfFJx5jV4HzMelTNOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741706249;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dms7KfDw50j2TeBALib2kafQnrtJKGKF9+qrPlXSLQM=;
	b=MCdbE2VowlZL0lZG7sjRNL+TGO9l4MMGcWO8CWlZTlRvpDEjvzqKThINjUu5TmQYUWfnai
	bDnV3tm1ddYDoHBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741706248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dms7KfDw50j2TeBALib2kafQnrtJKGKF9+qrPlXSLQM=;
	b=wKEB6UkTbytDaO5UV8da1u7YUebNkpn7QwyJKohN36krFZPUceRCqaL9VeVKZQ/eWycXMn
	njL9dUPgVQ51HHsPkyTSrd6B73RrQ7sWbUMoTbqoUK+V6kUT+EDjCwNOSuc4FDZKHvf/tA
	v2ek475toPsF/yjkGjKDGdm6RBOOWJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741706248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dms7KfDw50j2TeBALib2kafQnrtJKGKF9+qrPlXSLQM=;
	b=rMgPMNgpGnkOvZreEGmDFI0NN6FokIFX3LDhA5vT024MfFigVCTZ/Dt7YmpV7hbFktmM8I
	PZNaC3z9MW7MnSBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93CC3134A0;
	Tue, 11 Mar 2025 15:17:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CVGzHwdU0Gd7aQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 11 Mar 2025 15:17:27 +0000
Date: Tue, 11 Mar 2025 16:17:22 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Gavin Shan <gshan@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	akpm@linux-foundation.org, shan.gavin@gmail.com
Subject: Re: [PATCH v2 3/3] drivers/base/memory: Correct the field name in
 the header
Message-ID: <Z9BUAhnWS_ixC4-B@localhost.localdomain>
References: <20250311004657.82985-1-gshan@redhat.com>
 <20250311004657.82985-4-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311004657.82985-4-gshan@redhat.com>
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,redhat.com,linuxfoundation.org,kernel.org,linux-foundation.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,localhost.localdomain:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Mar 11, 2025 at 10:46:57AM +1000, Gavin Shan wrote:
> Replace @blocks with @memory_blocks to match with the definition
> of struct memory_group.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE Labs

