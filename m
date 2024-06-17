Return-Path: <linux-kernel+bounces-217899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3F890B5AC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62BBB1F22E97
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC671304A2;
	Mon, 17 Jun 2024 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="buORgrmU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="buORgrmU"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B3F1D951F;
	Mon, 17 Jun 2024 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639974; cv=none; b=YfU9b/vbrryeOC/60WBFH79SeRfa7S7E5KUqLptpQeCfVdaLeC1HNXbBeRdbEKKzoXp4zWe4K3Ny2oS2M2AmhaekySJspT+XtR4TL6V3TVFOSwSvfNeiC6dxtJDaIscSjUAmqtXGjKT5I+TKhUoJ2y0S/05Owzz76CZ1UrcY0nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639974; c=relaxed/simple;
	bh=Qekc7wXB/5w0fCpw5k0Zli4DN1p8NVGDp7wGjjVCyrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHu/eLOGYZcZ13b0k46whIEDDLdUUndHCWKMrh6Ap8+cRklB9/ihmgwF5cbhJYXbZNl4yMHgTKmK1YTolzO2JG3Fx87jw9EBpSxYqKnpirMuwiA3DQcBan4daVKBGZIhPjNdQpBJK9MMHdfGLh9lnG6ipKng0D0vYmmlLP5AWSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=buORgrmU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=buORgrmU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E031383DA;
	Mon, 17 Jun 2024 15:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718639971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JJ7hHeLskSF+6pTMJwgoLumHvoTplWnrosrmu+lLGrQ=;
	b=buORgrmUFjULG6osc8E5Dev1w5JjgEIqNzmZqyqQOf5m7YkInJyc9npt1O7ng+v7vV2psE
	onWQSDpM+v/rMUSm69TROkAjhuPbmk19ur4gl861R4ko6+gdXeo+elHKWBjrf3IwJG2y85
	OGUgwcdijivq0tId/FXFgV89qeGE1H0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718639971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JJ7hHeLskSF+6pTMJwgoLumHvoTplWnrosrmu+lLGrQ=;
	b=buORgrmUFjULG6osc8E5Dev1w5JjgEIqNzmZqyqQOf5m7YkInJyc9npt1O7ng+v7vV2psE
	onWQSDpM+v/rMUSm69TROkAjhuPbmk19ur4gl861R4ko6+gdXeo+elHKWBjrf3IwJG2y85
	OGUgwcdijivq0tId/FXFgV89qeGE1H0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1298139AB;
	Mon, 17 Jun 2024 15:59:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HaUuNWJdcGawdQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 17 Jun 2024 15:59:30 +0000
Date: Mon, 17 Jun 2024 17:59:30 +0200
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35840: mptcp: use OPTION_MPTCP_MPJ_SYNACK in
 subflow_finish_connect()
Message-ID: <ZnBdYv9Dls8CTm0G@tiehlicka>
References: <2024051756-CVE-2024-35840-99fa@gregkh>
 <ZmFtaijTs6mOpB5B@tiehlicka>
 <2024061750-glade-overstep-7759@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061750-glade-overstep-7759@gregkh>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]

On Mon 17-06-24 17:43:10, Greg KH wrote:
> On Thu, Jun 06, 2024 at 10:03:54AM +0200, Michal Hocko wrote:
> > Hi,
> > what is the actual security threat here? As far as I can see, the
> > problem that the commit requested here addresses seems to be rather
> > functional, rather than responding to an unexpected packet options with
> > a reset, we actually establish a connection with some garbage parameters
> > (likely unpredictable). Which is unfortunate but I do not see any
> > security implications.
> 
> Sorry for the delay.  I'm pretty sure this is a data leak as the
> "garbage" is coming from other kernel data, and as such, was reviewed by
> us as a vulnerability.

This is not my area so bear with me, but isn't the garbage coming from a
remote side of the connection so it is just a garbage? I would
understand that a misbehavior on the receiving end could be considered
problematic but I still do not see this happening. Or am I wrong?

-- 
Michal Hocko
SUSE Labs

