Return-Path: <linux-kernel+bounces-189989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C70DA8CF81D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 05:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6147EB20AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 03:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8046FB0;
	Mon, 27 May 2024 03:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t547aMtr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UFaca0rA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t547aMtr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UFaca0rA"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E492F20E6
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 03:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716780797; cv=none; b=bVcWwfMCll02y7MCMV51u25Ks8XJnS//jkkjztH058s3UTnhlGCV3RCwF95lP9CqoxUfIvF3ZaSD7JAD0F+W50Z7F9DjkD6hmrRWr6RGzaF9IcIRavoo0c6du7KgsGa5cUfo6+Ro0HxHQlEEO1x7lZ+g8YqtiIrtRcg8oBUpCHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716780797; c=relaxed/simple;
	bh=jXP0S+k/rC7k2jKmWETCgnlEY8baDz5/X7npkE+HsOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zye4CeiDol8VbNBlgVVZMe0FMzuQOpXIEpfpTCaz6KXYghXWUBaWnxWQUUstw+6MGku829QBj714NGsc+j4ckL1k1DGy5F7/1RQPSLJFnjvqaNql6lwEiZft8MnAWPON9HbcqmrNACocHMHPeV5BKnmEE2OVbE47jQvsoNHaMXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t547aMtr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UFaca0rA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t547aMtr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UFaca0rA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 017CF21A59;
	Mon, 27 May 2024 03:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716780792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ULxJHakq8WrIYTmL8w/EKL+mKNfR0R9UJ7PV9piAMw=;
	b=t547aMtrVMIleC1XNtrb8vE3OfilVzHK2sGEcMgyfIgM3lHjMelN7lTpwBCuxtz/1DysFm
	HXBtbh+Kfgmi7uFL4Vz37gBFfp16vp7ehy1x4V6QI3YARuGG5jNRLWIlwIQNqNHArBlkVH
	3bqLE2KGVgM233lBUVPxPnIJ0RN11e0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716780792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ULxJHakq8WrIYTmL8w/EKL+mKNfR0R9UJ7PV9piAMw=;
	b=UFaca0rAMP/3A6sUQtFPEAIGzOzodCMNoCyBJ8S+P2e2nrtfHI5IhyCpAnJZFNRkDDMjvS
	W+iul53wtCfVqpAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716780792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ULxJHakq8WrIYTmL8w/EKL+mKNfR0R9UJ7PV9piAMw=;
	b=t547aMtrVMIleC1XNtrb8vE3OfilVzHK2sGEcMgyfIgM3lHjMelN7lTpwBCuxtz/1DysFm
	HXBtbh+Kfgmi7uFL4Vz37gBFfp16vp7ehy1x4V6QI3YARuGG5jNRLWIlwIQNqNHArBlkVH
	3bqLE2KGVgM233lBUVPxPnIJ0RN11e0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716780792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ULxJHakq8WrIYTmL8w/EKL+mKNfR0R9UJ7PV9piAMw=;
	b=UFaca0rAMP/3A6sUQtFPEAIGzOzodCMNoCyBJ8S+P2e2nrtfHI5IhyCpAnJZFNRkDDMjvS
	W+iul53wtCfVqpAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C27813A6B;
	Mon, 27 May 2024 03:33:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /Y2hH/f+U2agdQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 27 May 2024 03:33:11 +0000
Date: Mon, 27 May 2024 05:32:55 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Joel Granados <j.granados@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] mm/hugetlb: constify ctl_table arguments of utility
 functions
Message-ID: <ZlP-59ed0_JrJZzG@localhost.localdomain>
References: <20240518-sysctl-const-handler-hugetlb-v1-1-47e34e2871b2@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240518-sysctl-const-handler-hugetlb-v1-1-47e34e2871b2@weissschuh.net>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Sat, May 18, 2024 at 04:00:04PM +0200, Thomas Weiﬂschuh wrote:
> The sysctl core is preparing to only expose instances of
> struct ctl_table as "const".
> This will also affect the ctl_table argument of sysctl handlers.
> 
> As the function prototype of all sysctl handlers throughout the tree
> needs to stay consistent that change will be done in one commit.
> 
> To reduce the size of that final commit, switch utility functions which
> are not bound by "typedef proc_handler" to "const struct ctl_table".
> 
> No functional change.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

