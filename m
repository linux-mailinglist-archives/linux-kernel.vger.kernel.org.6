Return-Path: <linux-kernel+bounces-374984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 848609A72CD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 046CAB21A34
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E8D1991D6;
	Mon, 21 Oct 2024 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NlqA4F3G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="el/jxD3G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NlqA4F3G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="el/jxD3G"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0D22209B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537349; cv=none; b=lLtsEkA4FumTKFmQcP7I45M9tkrIeccKaEU/qm2HUN3N7dxLs2ySMehrr1LJbrmYXcwWBDCFdiLgzU6Dy1zYXqZ5oEpMVaBAM6L/ShNGnPDLMdQ7y7MyJzpfdVjnEmA/OHvsMx/uRy65wuqKtUE4ncI2Wecd/k+Lp5wBaC24rzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537349; c=relaxed/simple;
	bh=T432hUS2Ba7+7lbynICmsgcTAxMMVJ1KulC+dN9VFb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQUAxF9rrB5mWd8GsiZU1Cs8mP1lGPi04ju8VxXs74r7+KeyGF7SpVOlSrkLGpACLsxiNhnTwkgPHIYxNEG9Gv4Jl6BjUXwFCN+SMIhEW9FKV5oQVhN8WphvX0SD+hnwq4WPVd6vrnbQeCaff3CBcdzR/hBhQYm6Rl01nqI8ubs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NlqA4F3G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=el/jxD3G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NlqA4F3G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=el/jxD3G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E5C521E12;
	Mon, 21 Oct 2024 19:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729537345;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HK8ypmYN8LtwdDGvon4+aWyemAihjhAIW4PoOaEhs+E=;
	b=NlqA4F3G4NjNV67bA2BO1yGFeOWkoNnfx12uKhAWnAdl2s+FkksnTBDv/tSRTo70B9vOFr
	9xoc5hQW91+EK0/5+mlTUo66/J+y2HPFR6d5h+Zr/nlDbk8zByqGYDHEatLr5GHWbY61Zg
	CyPeXCMcK+pBcIWVYY2nBjVdyQTg9QE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729537345;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HK8ypmYN8LtwdDGvon4+aWyemAihjhAIW4PoOaEhs+E=;
	b=el/jxD3GcMLXjDH4zfXK/dGeIOed6+JP+tEubTBXkdROWR/XjEI+EtRk7IRfjeMKeM7Vec
	hm0mtULU1DdIOACA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729537345;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HK8ypmYN8LtwdDGvon4+aWyemAihjhAIW4PoOaEhs+E=;
	b=NlqA4F3G4NjNV67bA2BO1yGFeOWkoNnfx12uKhAWnAdl2s+FkksnTBDv/tSRTo70B9vOFr
	9xoc5hQW91+EK0/5+mlTUo66/J+y2HPFR6d5h+Zr/nlDbk8zByqGYDHEatLr5GHWbY61Zg
	CyPeXCMcK+pBcIWVYY2nBjVdyQTg9QE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729537345;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HK8ypmYN8LtwdDGvon4+aWyemAihjhAIW4PoOaEhs+E=;
	b=el/jxD3GcMLXjDH4zfXK/dGeIOed6+JP+tEubTBXkdROWR/XjEI+EtRk7IRfjeMKeM7Vec
	hm0mtULU1DdIOACA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BE8F136DC;
	Mon, 21 Oct 2024 19:02:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jX7BHUGlFme4KgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 21 Oct 2024 19:02:25 +0000
Date: Mon, 21 Oct 2024 21:02:20 +0200
From: David Sterba <dsterba@suse.cz>
To: kernel test robot <lkp@intel.com>
Cc: Naohiro Aota <naohiro.aota@wdc.com>, oe-kbuild-all@lists.linux.dev,
	David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master 4259/5321] fs/btrfs/bio.c:132:17: sparse:
 sparse: cast from restricted blk_status_t
Message-ID: <20241021190220.GD24631@suse.cz>
Reply-To: dsterba@suse.cz
References: <202410180159.O8S1AyaN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410180159.O8S1AyaN-lkp@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Fri, Oct 18, 2024 at 01:17:15AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   7df1e7189cecb6965ce672e820a5ec6cf499b65b
> commit: c87222d18145c93b0ebd860ae9166afb1457129c [4259/5321] btrfs: fix error propagation of split bios
> config: microblaze-randconfig-r133-20241017 (https://download.01.org/0day-ci/archive/20241018/202410180159.O8S1AyaN-lkp@intel.com/config)
> compiler: microblaze-linux-gcc (GCC) 14.1.0

microblaze

> reproduce: (https://download.01.org/0day-ci/archive/20241018/202410180159.O8S1AyaN-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410180159.O8S1AyaN-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> fs/btrfs/bio.c:132:17: sparse: sparse: cast from restricted blk_status_t
> >> fs/btrfs/bio.c:132:17: sparse: sparse: cast to restricted blk_status_t
>    fs/btrfs/bio.c: note: in included file (through include/linux/smp.h, include/linux/lockdep.h, include/linux/spinlock.h, ...):
>    include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
> 
> vim +132 fs/btrfs/bio.c
> 
>    116	
>    117	void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
>    118	{
>    119		bbio->bio.bi_status = status;
>    120		if (bbio->bio.bi_pool == &btrfs_clone_bioset) {
>    121			struct btrfs_bio *orig_bbio = bbio->private;
>    122	
>    123			btrfs_cleanup_bio(bbio);
>    124			bbio = orig_bbio;
>    125		}
>    126	
>    127		/*
>    128		 * At this point, bbio always points to the original btrfs_bio. Save
>    129		 * the first error in it.
>    130		 */
>    131		if (status != BLK_STS_OK)
>  > 132			cmpxchg(&bbio->status, BLK_STS_OK, status);

I don't see an arch-specific implementation of cmpxchg in
arch/microblaze/ so I'm assuming it's using some fallback that's in C so
sparse detects the type mismatches. The attribute is __bitwise but it
should not matter here.

