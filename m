Return-Path: <linux-kernel+bounces-266434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AD293FFDE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21AF6B215E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234A81891B8;
	Mon, 29 Jul 2024 20:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ebesWIuc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OXS47I/Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="voSem+vf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WYVrhlH0"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E1718D4A2;
	Mon, 29 Jul 2024 20:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286510; cv=none; b=SSA9IrVJAz+y9N8pTuLgEWkOcM65DVTfbVGO8KjllkoqxQXXJE/CpHBv252lf+bSbuZuBghdpMT8TuaFCtq2VKJDa1dpDWLca1LbpD3tTOkLI/lGGL5qQCbtETtEBdsACDIxTWMkVhTya3hGVdJ0JsknSfs1gw84oPKdUTzMOdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286510; c=relaxed/simple;
	bh=e2vueFmg0RlqKjBsjeyf+u3Ms90LOD6pNHrIgplDljo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXXHD4gBaE0j4mvgj0MuQZdhFp/MT2X0dLC0kn3TNV3gCyuMfRByCeYzf6T/p4PyPenepRQTfG8LVR48s6wg693HP1B+T1HfJ0lJivdHavaSvQd5pJwV1zCMgw1lW4peiqgyLSVFT5lBpNObSPQAdHESpGE+EW6NTBU+8Kliajk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ebesWIuc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OXS47I/Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=voSem+vf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WYVrhlH0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D922E21A47;
	Mon, 29 Jul 2024 20:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722286505;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3oBy0L+5qRJ/bohtI7+Je9Ik7QHAuM+6OqGs9Vu+xw=;
	b=ebesWIucjjfxiJNLhTs2gRriRC+fBIu2kHQ0r2kbj72R1nOXY7qFK00kqpCgvA0nOTJz+j
	DkZQTuti1fkMXbxeq1IitIJ+C/rMIsqMOYA2KR7aT6h6MdPPbZno5t7Rdz4R1L8GsgdLun
	qGbMtCjuf/Qbmh0kFYH+kGETEUucB0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722286505;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3oBy0L+5qRJ/bohtI7+Je9Ik7QHAuM+6OqGs9Vu+xw=;
	b=OXS47I/ZWxUUjzjRU3ec1557R3JEbvf+LR1kA0BlNmprmbtScuJQL5GNUgXiao8FzH2n30
	m6nN7naahpQooCDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722286504;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3oBy0L+5qRJ/bohtI7+Je9Ik7QHAuM+6OqGs9Vu+xw=;
	b=voSem+vfoe+4sXpiU7//1PDQ1/XRT3WYtGQGEKm8M+sZWF0x4RUjiFlO2RAo1X4TN3eWgd
	/9D3eXxLzSsKMz6zr3V91Qj+PCXofYD7NX3mHtu0xbX08KB2jgcbPCgFvmiASGiCWi+E2b
	8kQ24t7oYyXjiRkTancyfQ9XS31X6Hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722286504;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3oBy0L+5qRJ/bohtI7+Je9Ik7QHAuM+6OqGs9Vu+xw=;
	b=WYVrhlH0MfTdJxvrbWatL6OJ4G7rsLH0JFfj+3m5KUTQL0VP7L51pjud8NQxn8cHJFgncM
	kZAvr5EuGebl+4BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B42B3138A7;
	Mon, 29 Jul 2024 20:55:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JB56K6gBqGZBUQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 29 Jul 2024 20:55:04 +0000
Date: Mon, 29 Jul 2024 22:55:03 +0200
From: David Sterba <dsterba@suse.cz>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2024-41067: btrfs: scrub: handle RST lookup error correctly
Message-ID: <20240729205503.GT17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2024072907-CVE-2024-41067-bc18@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024072907-CVE-2024-41067-bc18@gregkh>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon, Jul 29, 2024 at 04:58:13PM +0200, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> btrfs: scrub: handle RST lookup error correctly
> 
> [BUG]
> When running btrfs/060 with forced RST feature, it would crash the
> following ASSERT() inside scrub_read_endio():
> 
> 	ASSERT(sector_nr < stripe->nr_sectors);
> 
> Before that, we would have tree dump from
> btrfs_get_raid_extent_offset(), as we failed to find the RST entry for
> the range.
> 
> [CAUSE]
> Inside scrub_submit_extent_sector_read() every time we allocated a new
> bbio we immediately called btrfs_map_block() to make sure there was some
> RST range covering the scrub target.
> 
> But if btrfs_map_block() fails, we immediately call endio for the bbio,
> while the bbio is newly allocated, it's completely empty.
> 
> Then inside scrub_read_endio(), we go through the bvecs to find
> the sector number (as bi_sector is no longer reliable if the bio is
> submitted to lower layers).
> 
> And since the bio is empty, such bvecs iteration would not find any
> sector matching the sector, and return sector_nr == stripe->nr_sectors,
> triggering the ASSERT().
> 
> [FIX]
> Instead of calling btrfs_map_block() after allocating a new bbio, call
> btrfs_map_block() first.
> 
> Since our only objective of calling btrfs_map_block() is only to update
> stripe_len, there is really no need to do that after btrfs_alloc_bio().
> 
> This new timing would avoid the problem of handling empty bbio
> completely, and in fact fixes a possible race window for the old code,
> where if the submission thread is the only owner of the pending_io, the
> scrub would never finish (since we didn't decrease the pending_io
> counter).
> 
> Although the root cause of RST lookup failure still needs to be
> addressed.
> 
> The Linux kernel CVE team has assigned CVE-2024-41067 to this issue.

Please drop the CVE. It's a fix for feature that's still in development
and is not enabled on production kernels (requires CONFIG_BTRFS_DEBUG).
There was even a recent on-disk format change (mkfs required), this is
not really for environments where security matters. Thanks.

