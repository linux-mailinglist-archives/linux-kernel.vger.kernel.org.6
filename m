Return-Path: <linux-kernel+bounces-566197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C649BA674BE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BD067A1ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEAC20B7E9;
	Tue, 18 Mar 2025 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h0RKhyX9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OqaIcABp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kB6X7nzl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WavFJucy"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F012837A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303806; cv=none; b=path4DrASO7EbN7EAsw2V6mTA0ePoaGILUH7HUiqbILpwmvhmo5Cuvr+2/LqrO06Q67S4QskiQ65BfSZ20laUjJTlY1m3YVwFoUddgN8uD3Ef/H60fuTH5g5LM8WBdHoo2FMS3eblHusLTVYXQv16jXUanQH/xf3sUDphZh4Xus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303806; c=relaxed/simple;
	bh=BqtUf+DFXSWE3UqtxQBwe2VzQpxz3pG9EqGYeLMMDJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ksv/DM+1lXuns4L5E+UsL44TzKjqhMO8sVWRQqnUPLOROSAPC7q7ExeEbIeCdRfGjVa8vrC4YPrYtmpkhWE96hXtfZ6uwvEGIeg6Xod95HD/e/SXCi9FLLZ8/KsMzGRaKC1LA3KTKiBLXfsRF0nQcCKIBeoB5IecLf12OZfz0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h0RKhyX9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OqaIcABp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kB6X7nzl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WavFJucy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E16B81F871;
	Tue, 18 Mar 2025 13:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742303803;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3G+GJEo5sexIIa6sxNZUx/XTGYXd5RVf70C8UFpZt6Y=;
	b=h0RKhyX9ebHsYV8nsW04SXUbxLW5ZnI6YGYdYTPBbwVvfs6BVI6q3cwDLdj9fCQmAOmZ2T
	vMbAo2BNxG47OuM0lCWYmrWhkWUTJXV1LMdjX6cOxAi4gncVGaxECgYRXCZ+I1RPQuLHbY
	lZR1tdcPXE/eKP5fCDKYbMeVyrHMViw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742303803;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3G+GJEo5sexIIa6sxNZUx/XTGYXd5RVf70C8UFpZt6Y=;
	b=OqaIcABpulSRLU2lZ3LLpG219GK6CjCf5MsmQlu1Irh3DyN+dlfi+Y6VNDh66DgIPut+fh
	/hO0nbb1B37h2VBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742303802;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3G+GJEo5sexIIa6sxNZUx/XTGYXd5RVf70C8UFpZt6Y=;
	b=kB6X7nzlhNqFH49FjYAUwkuF+Cvwx3H+hW35bOktG3d1Im4w5DekvXVh+INsLb7wUEh5Ij
	Uj1uk2rNcnm0HuquoyDLOVev6fyoD5ypYKcXGsm6E4XBXgXgZOjMi0SWMxCMDFYQI61Ylj
	EW2YI9TtFLMpsEBb6VVCahN1Cy7ig/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742303802;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3G+GJEo5sexIIa6sxNZUx/XTGYXd5RVf70C8UFpZt6Y=;
	b=WavFJucyLWFrRyFdWoiMfu16kZNJlKU3JFoZeJO8LiJZZ4dp3BZSDm6DJ9u4E8Z6PW5udA
	xkut/8UNGk2FidAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBAD9139D2;
	Tue, 18 Mar 2025 13:16:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QOKHLTpy2WcqbQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 18 Mar 2025 13:16:42 +0000
Date: Tue, 18 Mar 2025 14:16:36 +0100
From: David Sterba <dsterba@suse.cz>
To: Nick Terrell <nickrterrell@gmail.com>
Cc: linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
	Kernel Team <Kernel-team@fb.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 0/1] zstd: Import upstream v1.5.7
Message-ID: <20250318131636.GC32661@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250313205923.4105088-1-nickrterrell@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313205923.4105088-1-nickrterrell@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Mar 13, 2025 at 01:59:20PM -0700, Nick Terrell wrote:
> From: Nick Terrell <terrelln@fb.com>
> 
> Since this is a large patch, I have also prepared a pull request as an
> alternate means of fetching the commit:
> 
> The following changes since commit 7eb172143d5508b4da468ed59ee857c6e5e01da6:
> 
>   Linux 6.14-rc5 (2025-03-02 11:48:20 -0800)
> 
> are available in the Git repository at:
> 
>   https://github.com/terrelln/linux.git tags/2025-03-13-zstd-v1.5.7-v1

This tag is not in the branch that is pulled to the linux-next tree, the
zstd-next branch still points to v6.14-rc5. This means the 1.5.7 update
hasn't been exposed to linux-next testing. Please update the branch to
the tag as well, the merge window opens next week leaving little time
before sending the pull request.

I've tested this patch with fstests and btrfs, no problems found, but
regarding the process the updates need to be in linux-next 1-2 weeks
before the merge window. We're past that. As this is restarting the zstd
merging I hope we can get away with that this time, skipping another
development cycle would be unfortunate but also not helping anything.

