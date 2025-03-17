Return-Path: <linux-kernel+bounces-564165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB765A64F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2CE16B192
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E7B23A990;
	Mon, 17 Mar 2025 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AcFD3wzT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ln5XHnjL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AcFD3wzT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ln5XHnjL"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B280218BC3D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215106; cv=none; b=HPMQPWj6qyJmVw7M1ndeBQMmiTbUdgw8QGGlMNEYmkevsyrN3dVashyQGdlh54jt2ztpltQRCprylZ7Ns/CbtX1rbRMlSo4vDJULdb/RUcXW+TW/3LPFJx3L+bDTtv/7eFsBf0BRmgpINAU2akkeduB2Folc4hbGIfEq4ue5aog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215106; c=relaxed/simple;
	bh=lB47WChGNg07JMf4LpwMyjmcS+EqjTZNpPm7Umu1TTs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=saoNNpjTIvef3tBXkEgPMClMi/eFChitkoQGp0e+omuj/Ih5m0zxGcCDnSfICNfga7agALaMAZHkvZMORzH/7ok0YSSuoK7O+ETm7J2gnPgnOirDphjOi6ZyNs0EueRaDrmg0/9y7GxhKLz9D3p072NMNrDy1/S2Fepb1WHleQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AcFD3wzT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ln5XHnjL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AcFD3wzT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ln5XHnjL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BCEFF219DA;
	Mon, 17 Mar 2025 12:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742215102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5zc+c7jw+++AMP7JdcQ5gYjT0S2ZMDIAtMr/+nT1J24=;
	b=AcFD3wzTAWB2b6zarA0d0QFVb5pZaq40IYWPltH4uJE/ptns2AxIinaMkIqUTjS2bAw/ep
	eTRK5m/kR9RHOn6Ineyq84WKJFvm8Ro/z4FoDr+hCvzT6ItFP8c6FT27kk9JscpL/h5ieg
	TEL9/jobvVLJOpkqlz66igS0NGfiDw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742215102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5zc+c7jw+++AMP7JdcQ5gYjT0S2ZMDIAtMr/+nT1J24=;
	b=ln5XHnjLd3julyqqAQwPmXJALYCNFXLmu97aOSPBTS9ztzgCO178BsJQo742rBGBG6I9RU
	D7lqiiIdjXPI3NBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742215102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5zc+c7jw+++AMP7JdcQ5gYjT0S2ZMDIAtMr/+nT1J24=;
	b=AcFD3wzTAWB2b6zarA0d0QFVb5pZaq40IYWPltH4uJE/ptns2AxIinaMkIqUTjS2bAw/ep
	eTRK5m/kR9RHOn6Ineyq84WKJFvm8Ro/z4FoDr+hCvzT6ItFP8c6FT27kk9JscpL/h5ieg
	TEL9/jobvVLJOpkqlz66igS0NGfiDw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742215102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5zc+c7jw+++AMP7JdcQ5gYjT0S2ZMDIAtMr/+nT1J24=;
	b=ln5XHnjLd3julyqqAQwPmXJALYCNFXLmu97aOSPBTS9ztzgCO178BsJQo742rBGBG6I9RU
	D7lqiiIdjXPI3NBg==
Date: Mon, 17 Mar 2025 13:38:22 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
    Peter Zijlstra <peterz@infradead.org>, 
    Brendan Jackman <jackmanb@google.com>, 
    Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 08/13] objtool: Upgrade "Linked object detected" warning
 to error
In-Reply-To: <8380bbf3a0fa86e03fd63f60568ae06a48146bc1.1741975349.git.jpoimboe@kernel.org>
Message-ID: <alpine.LSU.2.21.2503171337440.4236@pobox.suse.cz>
References: <cover.1741975349.git.jpoimboe@kernel.org> <8380bbf3a0fa86e03fd63f60568ae06a48146bc1.1741975349.git.jpoimboe@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi,

On Fri, 14 Mar 2025, Josh Poimboeuf wrote:

> Force the user to fix their cmdline if they forget the '--link' option.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  tools/objtool/builtin-check.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
> index 36d81a455b01..79843512a51b 100644
> --- a/tools/objtool/builtin-check.c
> +++ b/tools/objtool/builtin-check.c
> @@ -198,8 +198,8 @@ int objtool_run(int argc, const char **argv)
>  		return 1;
>  
>  	if (!opts.link && has_multiple_files(file->elf)) {
> -		ERROR("Linked object detected, forcing --link");
> -		opts.link = true;
> +		ERROR("Linked object requires --link");
> +		goto err;

there is no 'err' label in objtool_run() at this point. It is introduced 
by the next patch.

Miroslav

