Return-Path: <linux-kernel+bounces-568971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D27FA69CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 00:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB05D17DE40
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387DD22371F;
	Wed, 19 Mar 2025 23:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pJ0B8x2I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T26ql54T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pJ0B8x2I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T26ql54T"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0F1222582
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 23:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742428381; cv=none; b=DE9FuOeWgLj7oEsJ/EGIhNbYaa2uw7NweFxfisfPJbv4CLThdYYoqb06WHSvbVR2JySV0JHjsVDbNkWZEurMFs3V9UNUHFEHZSuFHS5lfMFr5Lo0lCHGXRy4mu4sjks8S9Kf9CBi5AWZhDCkRUHEkxsMSb/Dmadl27qYNxer8j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742428381; c=relaxed/simple;
	bh=UAB9YwSCWng1v4QMb/myZVc/+nz24hJ9x2NcfZeVep8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pn47I/l2fucWQT/Zn9NbqUIZ0N8tHkKf4+MR/+3pKdk7qnm3ayR50MPIkKxaUkHMZV2WeSFEQDqzXjRnMmKc7ViplCq/Ba9XuvKoAVApn+Wtin8mccylzg/uz+1Ngdqjef/2XP+vC6xQl2TdynailGrB/3qBHsndsPorTFQfWdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pJ0B8x2I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T26ql54T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pJ0B8x2I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T26ql54T; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 922571FC0A;
	Wed, 19 Mar 2025 23:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742428376;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j4mFhc59YILvmPd7WYVBC6c5CxHPubDjgdUmxo4kHBo=;
	b=pJ0B8x2IPFTo9N46B5+rWVhbYk2CjQRlXDNvr5x4gIgH+BoAbwEqp8rjHQGlhUujkBPDvj
	hQ5Femh+k3WGxGjC5YO252XHt6eEtHg5lTqvQD8VG52Ckp6cwGQ4swQ0KP1ejcuR9dj9p6
	X6/LEyL160f9cD0RLdH5165EvfZZVhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742428376;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j4mFhc59YILvmPd7WYVBC6c5CxHPubDjgdUmxo4kHBo=;
	b=T26ql54TXC4p7zfKN9rvVJvaB+5UQ7Ad+BBqQIxqqAkelEzEZUqItRES/dlTQci72d7eQB
	Dw+h6HO2tELLEhAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pJ0B8x2I;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=T26ql54T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742428376;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j4mFhc59YILvmPd7WYVBC6c5CxHPubDjgdUmxo4kHBo=;
	b=pJ0B8x2IPFTo9N46B5+rWVhbYk2CjQRlXDNvr5x4gIgH+BoAbwEqp8rjHQGlhUujkBPDvj
	hQ5Femh+k3WGxGjC5YO252XHt6eEtHg5lTqvQD8VG52Ckp6cwGQ4swQ0KP1ejcuR9dj9p6
	X6/LEyL160f9cD0RLdH5165EvfZZVhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742428376;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j4mFhc59YILvmPd7WYVBC6c5CxHPubDjgdUmxo4kHBo=;
	b=T26ql54TXC4p7zfKN9rvVJvaB+5UQ7Ad+BBqQIxqqAkelEzEZUqItRES/dlTQci72d7eQB
	Dw+h6HO2tELLEhAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EDED13726;
	Wed, 19 Mar 2025 23:52:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8optGthY22eAWgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 19 Mar 2025 23:52:56 +0000
Date: Thu, 20 Mar 2025 00:52:51 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Kimmel <kernel@bareminimum.eu>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, linux-kernel@vger.kernel.org,
	Calvin Walton <calvin.walton@kepstin.ca>
Subject: Re: [PATCH] btrfs: correctly escape subvol in btrfs_show_options
Message-ID: <20250319235251.GS32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250319214900.25100-1-kernel@bareminimum.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319214900.25100-1-kernel@bareminimum.eu>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 922571FC0A
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Mar 19, 2025 at 10:49:00PM +0100, Johannes Kimmel wrote:
> Currently, displaying the btrfs subvol mount option doesn't escape `,`.
> This makes parsing /proc/self/mounts and /proc/self/mountinfo
> ambigious for subvolume names that contain commas. The text after the
> comma could be mistaken for another option (think "subvol=foo,ro", where
> ro is actually part of the subvolumes name).

The subvol= option was intentionally last so the path does not mix with
other options but yeah it still can be confused if it's parsed in a
generic way and not assuming anything about the ordering.

I've checked util-linux/libmount, seems that it understands the "\," as
part of the option value so it should not break anything.

> This patch replaces the manual escape characters list with a call to
> seq_show_option. Thanks to Calvin Walton for suggesting this approach.
> 
> Fixes: c8d3fe028f64 ("Btrfs: show subvol= and subvolid= in /proc/mounts")
> Suggested-by: Calvin Walton <calvin.walton@kepstin.ca>
> Signed-off-by: Johannes Kimmel <kernel@bareminimum.eu>

Added to for-next, thanks.

