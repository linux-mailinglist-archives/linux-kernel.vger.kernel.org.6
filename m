Return-Path: <linux-kernel+bounces-348831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7051198EC5B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C18282FA9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459261465A1;
	Thu,  3 Oct 2024 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ygvA6RIb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z2MDkszI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ygvA6RIb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z2MDkszI"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260F3139D07
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 09:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727948266; cv=none; b=uqql0ofP7tnhh5gjSMdnBkZEHuASwKr4AvihsMqUdXka7tZra/W/jkLokRYVAAdsIn9pnF/R+xXQkgFZiv8VHBrkmSRHRNysZww5j7tcQiuXEujvU7G9Fl/sZygSnVK8OfIub6AarBwP+zFiQKb03YvJNA74HpSwXMRBhf6QlHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727948266; c=relaxed/simple;
	bh=deX6U0A0iK/kNW0WPlxTB22GQ8LiQbX7Xyjg98om3ig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxhMwsj6YLEUBEGgh6WA8wu6t5tH9s8trVv/kl5PyBMOsAJqEK7N4zCBeKskIjzh07+lnJq5SrDnlbrK6OP/stjW18mIn8jMCMTlTIxdjJhaQwmJpZN7tazORq3n/6CMXp/j1RTo6jDGQiJrO7FPFIiZcxbSKO1Bc1PIfpMVGaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ygvA6RIb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z2MDkszI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ygvA6RIb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z2MDkszI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BE8D21CEF;
	Thu,  3 Oct 2024 09:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727948263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPp9IRtXlzCRVYi9M100n3dv0JMx5lglpGmTe3/vywg=;
	b=ygvA6RIbcdQKuGKIrDr+PrDPEb1SjDDBzKSipkC+uS3leCLkFQ1ij2CDZht8+FpzaCI9qN
	OvN+wIesWi2xZ9PM6cTkqpfT0M0gpFlWSKQqqgm0yB5rAp4QsI795yZ07N1aHw2t3xeyhJ
	wIGTuMGvsCLWv8+gtDdjaROuhsbzQ+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727948263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPp9IRtXlzCRVYi9M100n3dv0JMx5lglpGmTe3/vywg=;
	b=Z2MDkszIrMt+qabkoLPDalE8yBO/BON0fmMrd9FoiqLrx6Zrof4+6l5x4XV++L9wSStOj4
	XR8abJmeILwT7wCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ygvA6RIb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Z2MDkszI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727948263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPp9IRtXlzCRVYi9M100n3dv0JMx5lglpGmTe3/vywg=;
	b=ygvA6RIbcdQKuGKIrDr+PrDPEb1SjDDBzKSipkC+uS3leCLkFQ1ij2CDZht8+FpzaCI9qN
	OvN+wIesWi2xZ9PM6cTkqpfT0M0gpFlWSKQqqgm0yB5rAp4QsI795yZ07N1aHw2t3xeyhJ
	wIGTuMGvsCLWv8+gtDdjaROuhsbzQ+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727948263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPp9IRtXlzCRVYi9M100n3dv0JMx5lglpGmTe3/vywg=;
	b=Z2MDkszIrMt+qabkoLPDalE8yBO/BON0fmMrd9FoiqLrx6Zrof4+6l5x4XV++L9wSStOj4
	XR8abJmeILwT7wCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF865139CE;
	Thu,  3 Oct 2024 09:37:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kEJ2OOZl/mZQcAAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Thu, 03 Oct 2024 09:37:42 +0000
Date: Thu, 3 Oct 2024 11:37:41 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: liujing <liujing@cmss.chinamobile.com>, arnd@arndb.de, W_Armin@gmx.de,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eeprom: fix spelling of switch
Message-ID: <20241003113741.6277cc1d@endymion.delvare>
In-Reply-To: <2024092632-perjurer-gossip-a710@gregkh>
References: <20240921134128.16870-1-liujing@cmss.chinamobile.com>
	<2024092632-perjurer-gossip-a710@gregkh>
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
X-Rspamd-Queue-Id: 4BE8D21CEF
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[cmss.chinamobile.com,arndb.de,gmx.de,gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Thu, 26 Sep 2024 10:30:05 +0200, Greg KH wrote:
> On Sat, Sep 21, 2024 at 09:41:28PM +0800, liujing wrote:
> > Signed-off-by: liujing <liujing@cmss.chinamobile.com>  
> 
> Please use your full name here.
> 
> > 
> > ---
> > V1-V2: fix title description, move cacography to spelling  
> 
> You forgot a "v2" in the subject line.
> 
> Also, for obvious reasons, we can not take changes without any changelog
> text at all.

I personally don't mind for trivial fixes. I honestly can't see what
Liujing can add to the commit message that wouldn't be essentially
redundant with the subject line.

-- 
Jean Delvare
SUSE L3 Support

