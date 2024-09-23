Return-Path: <linux-kernel+bounces-335958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D4197ED24
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EF09283DB5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96F619E7F7;
	Mon, 23 Sep 2024 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nsulgRRg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="so/QAP2B";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jloADnid";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P/GdsNwE"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F8F19DF85
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101335; cv=none; b=U8EZqk0/E99P5txdXuUVQFmgKZR7Jp+TlQokOjl1mAnrlI9cra1idP7PXo8Mblu84S2DQvhdUYhh6owJ63bN61CfFg9I1qF5etPxiGPivhmNDY47JWcNZUIxBxnrJg0sNieSGTlxtHcj3LXJ3m58FyCbCZ5LvTRf3rArj7AhySk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101335; c=relaxed/simple;
	bh=91iiJ5Nh4in6QXaX8KoMwrdnENSodqtP99G3Ia2T7Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdOQ6vquljj15pwm/J6ZpNSq4dm44oUsBUDro1U9ZUbIwtnM8SnZs9Ime6fSwrz95EFIqEnfItKAgkN5MYDketXq2B1mpuDVJ0Ko81ZwSG4Z8z13AnNKdAbqvo6iNEcWuqbbten5Dz6up0g/2kKU86KTCl5Pq+SRLiB9NFvt16I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nsulgRRg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=so/QAP2B; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jloADnid; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P/GdsNwE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31E0821DE0;
	Mon, 23 Sep 2024 14:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727101330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XRsI6u4+vgDrTmAPsgmuRGF6Cg6elkqpDAkrilrEhN4=;
	b=nsulgRRgW1/167dAtVQFBNJYK8hWOdERHqoMfaSVQhu6uBJk3qykaVNHV3zAfdLoXs2pEf
	Ls9d/ocuQqska7HacEy65sjS5JoTTCDnyWIwgTo1yH2zozfuQRXKjgWUWUw0fgTqzjeB9t
	UnrHLvUyExHBudZm667Kf+PCXX9RPAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727101330;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XRsI6u4+vgDrTmAPsgmuRGF6Cg6elkqpDAkrilrEhN4=;
	b=so/QAP2BO1wk+syXN0AdkJOjrFLRcQodeMhtFtk6MdPx7CLYmJyMkx+TXmwK57EerRTNKM
	aTGCCWDC8QLkcYDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jloADnid;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="P/GdsNwE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727101329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XRsI6u4+vgDrTmAPsgmuRGF6Cg6elkqpDAkrilrEhN4=;
	b=jloADnidvNmpXrmMY6FNuhlKmVNGRXRMJu/nJNEaa0PYSPpB5CYegjL8hmeP1UOUezAZ7T
	20IQXmM54AtZNbEB4UQVBT/xOpxuQNcpYg7DeX045uHEcQoL02aVHXG2U2LY93P+7yLUa2
	RDusgm1roCHAoPmcyPzCd9a/KInQS9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727101329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XRsI6u4+vgDrTmAPsgmuRGF6Cg6elkqpDAkrilrEhN4=;
	b=P/GdsNwE4/1GNA6LqK68nh+xijCy1oB3Nt2PfWjy6h4nsnAXnz8XL1seREY9aDCi4X5alY
	QU+X5stcdTORTvDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 244B813A64;
	Mon, 23 Sep 2024 14:22:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MjjYCJF58WYiYQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Sep 2024 14:22:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AB884A0844; Mon, 23 Sep 2024 16:22:08 +0200 (CEST)
Date: Mon, 23 Sep 2024 16:22:08 +0200
From: Jan Kara <jack@suse.cz>
To: Gianfranco Trad <s323713@studenti.polito.it>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild@lists.linux.dev,
	Dan Carpenter <error27@gmail.com>, jack@suse.com,
	linux-kernel@vger.kernel.org,
	syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com
Subject: Re: [PATCH] udf: fix uninit-value use in udf_get_fileshortad
Message-ID: <20240923142208.qjqi2hix4g7v2dmv@quack3>
References: <202409230809.5ozgjLm9-lkp@intel.com>
 <8084185d-b4cf-4c30-a67e-28b9b590306d@studenti.polito.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8084185d-b4cf-4c30-a67e-28b9b590306d@studenti.polito.it>
X-Rspamd-Queue-Id: 31E0821DE0
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[8901c4560b7ab5c2f9df];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lists.linux.dev,gmail.com,suse.com,vger.kernel.org,syzkaller.appspotmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,intel.com:email,linuxfoundation.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,appspotmail.com:email,linux.dev:email,01.org:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 23-09-24 11:23:48, Gianfranco Trad wrote:
> Hello,
> On 23/09/24 02:26, kernel test robot wrote:
> > BCC: lkp@intel.com
> > CC: oe-kbuild-all@lists.linux.dev
> > In-Reply-To: <20240919195227.412583-1-gianf.trad@gmail.com>
> > References: <20240919195227.412583-1-gianf.trad@gmail.com>
> > TO: Gianfranco Trad <gianf.trad@gmail.com>
> > TO: jack@suse.com
> > CC: linux-kernel@vger.kernel.org
> > CC: skhan@linuxfoundation.org
> > CC: Gianfranco Trad <gianf.trad@gmail.com>
> > CC: syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com
> > 
> > Hi Gianfranco,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on brauner-vfs/vfs.all]
> > [also build test WARNING on linus/master v6.11 next-20240920]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Gianfranco-Trad/udf-fix-uninit-value-use-in-udf_get_fileshortad/20240920-035519
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
> > patch link:    https://lore.kernel.org/r/20240919195227.412583-1-gianf.trad%40gmail.com
> > patch subject: [PATCH] udf: fix uninit-value use in udf_get_fileshortad
> > :::::: branch date: 3 days ago
> > :::::: commit date: 3 days ago
> > config: mips-randconfig-r073-20240922 (https://download.01.org/0day-ci/archive/20240923/202409230809.5ozgjLm9-lkp@intel.com/config)
> > compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <error27@gmail.com>
> > | Closes: https://lore.kernel.org/r/202409230809.5ozgjLm9-lkp@intel.com/
> > 
> > smatch warnings:
> > fs/udf/inode.c:2223 udf_current_aext() error: we previously assumed 'epos->bh' could be null (see line 2204)
> Given this error my initial guess is to update the patch to check the
> assumption of epos->bh not null.

Yes, epos->bh can definitely be NULL here. Generally the check looks really
suspicious. I was trying to find your original patch but for some reason
neither LKML archive nor my mailbox have it. What is the motivation of the
added check? Are you checking for overflow on alen? In that case it would
be best to just use check_add_overflow() helper when computing alen few
lines above...

								Honza

> > vim +2223 fs/udf/inode.c
> > 
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2193
> > ff116fc8d1d439 Jan Kara        2007-05-08  2194  int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
> > 5ca4e4be841e38 Pekka Enberg    2008-10-15  2195  			struct kernel_lb_addr *eloc, uint32_t *elen, int inc)
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2196  {
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2197  	int alen;
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2198  	int8_t etype;
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2199  	uint8_t *ptr;
> > 5ca4e4be841e38 Pekka Enberg    2008-10-15  2200  	struct short_ad *sad;
> > 5ca4e4be841e38 Pekka Enberg    2008-10-15  2201  	struct long_ad *lad;
> > 48d6d8ff7dca80 Marcin Slusarz  2008-02-08  2202  	struct udf_inode_info *iinfo = UDF_I(inode);
> > 28de7948a89676 Cyrill Gorcunov 2007-07-21  2203
> > cb00ea3528eb3c Cyrill Gorcunov 2007-07-19 @2204  	if (!epos->bh) {
> > ff116fc8d1d439 Jan Kara        2007-05-08  2205  		if (!epos->offset)
> > ff116fc8d1d439 Jan Kara        2007-05-08  2206  			epos->offset = udf_file_entry_alloc_offset(inode);
> > 382a2287bf9cd2 Jan Kara        2020-09-25  2207  		ptr = iinfo->i_data + epos->offset -
> > 4b11111aba6c80 Marcin Slusarz  2008-02-08  2208  			udf_file_entry_alloc_offset(inode) +
> > 48d6d8ff7dca80 Marcin Slusarz  2008-02-08  2209  			iinfo->i_lenEAttr;
> > 4b11111aba6c80 Marcin Slusarz  2008-02-08  2210  		alen = udf_file_entry_alloc_offset(inode) +
> > 48d6d8ff7dca80 Marcin Slusarz  2008-02-08  2211  							iinfo->i_lenAlloc;
> > cb00ea3528eb3c Cyrill Gorcunov 2007-07-19  2212  	} else {
> > ff116fc8d1d439 Jan Kara        2007-05-08  2213  		if (!epos->offset)
> > ff116fc8d1d439 Jan Kara        2007-05-08  2214  			epos->offset = sizeof(struct allocExtDesc);
> > ff116fc8d1d439 Jan Kara        2007-05-08  2215  		ptr = epos->bh->b_data + epos->offset;
> > 28de7948a89676 Cyrill Gorcunov 2007-07-21  2216  		alen = sizeof(struct allocExtDesc) +
> > 4b11111aba6c80 Marcin Slusarz  2008-02-08  2217  			le32_to_cpu(((struct allocExtDesc *)epos->bh->b_data)->
> > 4b11111aba6c80 Marcin Slusarz  2008-02-08  2218  							lengthAllocDescs);
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2219  	}
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2220
> > 48d6d8ff7dca80 Marcin Slusarz  2008-02-08  2221  	switch (iinfo->i_alloc_type) {
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2222  	case ICBTAG_FLAG_AD_SHORT:
> > 2aa242080b8dda Gianfranco Trad 2024-09-19 @2223  		if (unlikely(alen < 0 && epos->offset == epos->bh->b_size))
> > 2aa242080b8dda Gianfranco Trad 2024-09-19  2224  			return -1;
> The check would be inserted up here in the if clause. But if the patch
> doesn't look good, I can redesign it in a better way. If so, I'm more than
> glad to follow your advice.
> > 4b11111aba6c80 Marcin Slusarz  2008-02-08  2225  		sad = udf_get_fileshortad(ptr, alen, &epos->offset, inc);
> > 4b11111aba6c80 Marcin Slusarz  2008-02-08  2226  		if (!sad)
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2227  			return -1;
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2228  		etype = le32_to_cpu(sad->extLength) >> 30;
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2229  		eloc->logicalBlockNum = le32_to_cpu(sad->extPosition);
> > 4b11111aba6c80 Marcin Slusarz  2008-02-08  2230  		eloc->partitionReferenceNum =
> > 48d6d8ff7dca80 Marcin Slusarz  2008-02-08  2231  				iinfo->i_location.partitionReferenceNum;
> > 28de7948a89676 Cyrill Gorcunov 2007-07-21  2232  		*elen = le32_to_cpu(sad->extLength) & UDF_EXTENT_LENGTH_MASK;
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2233  		break;
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2234  	case ICBTAG_FLAG_AD_LONG:
> > 4b11111aba6c80 Marcin Slusarz  2008-02-08  2235  		lad = udf_get_filelongad(ptr, alen, &epos->offset, inc);
> > 4b11111aba6c80 Marcin Slusarz  2008-02-08  2236  		if (!lad)
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2237  			return -1;
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2238  		etype = le32_to_cpu(lad->extLength) >> 30;
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2239  		*eloc = lelb_to_cpu(lad->extLocation);
> > 28de7948a89676 Cyrill Gorcunov 2007-07-21  2240  		*elen = le32_to_cpu(lad->extLength) & UDF_EXTENT_LENGTH_MASK;
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2241  		break;
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2242  	default:
> > fcbf7637e6647e Steve Magnani   2017-10-12  2243  		udf_debug("alloc_type = %u unsupported\n", iinfo->i_alloc_type);
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2244  		return -1;
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2245  	}
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2246
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2247  	return etype;
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2248  }
> > ^1da177e4c3f41 Linus Torvalds  2005-04-16  2249
> > 
> Thanks for your time,
> 
> --Gian
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

