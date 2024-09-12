Return-Path: <linux-kernel+bounces-326366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDAF976739
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF601C211CB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78D41A0BCA;
	Thu, 12 Sep 2024 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a+R7dHbO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CrtU4tm1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I08yIP4M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ypw7oog+"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2004F187877
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726139561; cv=none; b=JSSRIDerfP+ruHTAnYs+s9LXPfADRK1QOYYrRCx+bz7Trl9aB8QsVj4r5AlvRN62+5hHcnJZDEw1LYgPPeqYJOd1idwPSukMpUolxrfQ09tpoW0REoTQVkiRtEGylNZHRPlSsEfGrsm2fVh2FcYEgHC+xTMB3t+dzZHlFmeduDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726139561; c=relaxed/simple;
	bh=OU2E+gBtfQvTY+c99xluDID+6sEBlOPR+cuz4LiUsog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPJuWT80MZw+jdoTJFN/pXC6p1R7TBj/rF982eAnEj3AMG5VVCbsEuy+cL55K9YXt+fp+aj0COQgCtjvypQ+mE7IIAqqs7QRKXBzJrXmUr5Gy+UQ5iX1jQdaLde5kWFM2jPmNAbJbTxi3oOsG/5wEooBBlxICf82xTnjASsOKmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a+R7dHbO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CrtU4tm1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I08yIP4M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ypw7oog+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E28F821A03;
	Thu, 12 Sep 2024 11:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726139557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z2XzAoPCLCzhHDKlc7A3HrXqq+xMYcBj3SgcFTa7Zrw=;
	b=a+R7dHbOcMSGFJ3UutayVbd57paWsykZ0c6Wz3oqnO6j5HVbZFOhjjLC/0Aad9JnvBOA0l
	54S79lzOm6inx4ZUGt/L1aj5mTxzpZjrZ7Y7kM1j3oo1BpaL+uRCj/Bd4XGLS7FIzELUz9
	sD/02rOmdl2U+ktP3eDiqjxeyBElTGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726139557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z2XzAoPCLCzhHDKlc7A3HrXqq+xMYcBj3SgcFTa7Zrw=;
	b=CrtU4tm1M4Txb3m1FujSAYDa7pEygO014PqsrtjTA21CTghx3yt/tWvSjjNLUHzPlwjbrF
	mL8cPYvUGhCj0DCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=I08yIP4M;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ypw7oog+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726139555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z2XzAoPCLCzhHDKlc7A3HrXqq+xMYcBj3SgcFTa7Zrw=;
	b=I08yIP4MKwZ/mih73dKReBRCkKICHypZ16ixoomXl/UhHB692bVlHXlh1JP2/fGed7qAp/
	iOYlZ3TeHKvQHF0zAl2M90P+dmIKdzYZvjzQGcSf/99kTTQ+upenFDYOgxH2ALEZDjGitI
	CGwZ7GGE9cIrBKdX3mpZtzkCnsxg9hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726139555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z2XzAoPCLCzhHDKlc7A3HrXqq+xMYcBj3SgcFTa7Zrw=;
	b=ypw7oog++H3TkTLyIxg5pVIWVUr99+2CNJtKDy39ca9WxuOBxakxdzdzas5nLhzsmI/kVE
	wp/Q2R28NCn1sVCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D80E813A73;
	Thu, 12 Sep 2024 11:12:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2uC7NKPM4mYpQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Sep 2024 11:12:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7EC41A08B3; Thu, 12 Sep 2024 13:12:35 +0200 (CEST)
Date: Thu, 12 Sep 2024 13:12:35 +0200
From: Jan Kara <jack@suse.cz>
To: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Cc: jack@suse.com, zhaomzhao@126.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] udf: return EIO when ftrunctate access beyond end of
 device
Message-ID: <20240912111235.6nr3wuqvktecy3vh@quack3>
References: <20240912061652.980443-1-zhaomengmeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912061652.980443-1-zhaomengmeng@kylinos.cn>
X-Rspamd-Queue-Id: E28F821A03
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	FREEMAIL_ENVRCPT(0.00)[126.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,126.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,kylinos.cn:email,syzkaller.appspot.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Thu 12-09-24 14:16:52, Zhao Mengmeng wrote:
> syzbot reports a udf slab-out-of-bounds as blow:
> 
> loop0: rw=0, sector=117, nr_sectors = 1 limit=0
> syz-executor135: attempt to access beyond end of device
> loop0: rw=0, sector=117, nr_sectors = 1 limit=0
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in udf_get_filelongad+0x167/0x1b0 fs/udf/directory.c:526
> Read of size 4 at addr ffff888012113f30 by task syz-executor135/5106
> 
> CPU: 0 UID: 0 PID: 5106 Comm: syz-executor135 Not tainted 6.11.0-rc6-syzkaller-00019-g67784a74e258 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:93 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  udf_get_filelongad+0x167/0x1b0 fs/udf/directory.c:526
>  udf_current_aext+0x435/0x9e0 fs/udf/inode.c:2235
>  udf_next_aext+0x8c/0x4a0 fs/udf/inode.c:2171
>  udf_extend_file fs/udf/inode.c:677 [inline]
>  udf_setsize+0xa8a/0x1280 fs/udf/inode.c:1265
>  udf_setattr+0x3c7/0x5d0 fs/udf/file.c:236
>  notify_change+0xbca/0xe90 fs/attr.c:503
>  do_truncate fs/open.c:65 [inline]
>  do_ftruncate+0x46b/0x590 fs/open.c:181
>  do_sys_ftruncate fs/open.c:199 [inline]
>  __do_sys_ftruncate fs/open.c:207 [inline]
>  __se_sys_ftruncate fs/open.c:205 [inline]
>  __x64_sys_ftruncate+0x95/0xf0 fs/open.c:205
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f13639ac249
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff0302d508 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f13639ac249
> RDX: 00007f13639ac249 RSI: 0000008002007ffb RDI: 0000000000000005
> RBP: 00000000000013f1 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff0302d550
> R13: 00007fff0302d630 R14: 431bde82d7b634db R15: 00007f13639f501d
> 
> The root cause is:
>   udf_extend_file
>     ->inode_bmap       --> etype == -1 and epos.bh == NULL
>      -> udf_next_aext  --> return -1 because reading block failed
>        -> sb_read --> return NULL because access beyond end of device
> 
> Under this, etype == -1, epos.bh == NULL, epos.offset is 24, which is
> less than sizeof(struct extentedFileEntry), aka 216. As a result,
> it skipped the epos.bh check and goes into udf_next_aext(). Since the
> epos.offset is illegal, udf_get_filelongad's first argument ptr,
> 	ptr = iinfo->i_data + epos->offset -
> 		udf_file_entry_alloc_offset(inode) +
> 		iinfo->i_lenEAttr;
> points to some buffer before iinfo->i_data, which triggeres KASAN's
> warnning.
> 
> The fix is to add addition check on etype, epos.bh and epos.offset,
> when ftruncate accesses beyound end of device, just return EIO and failed.
> 
> Reported-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7a4842f0b1801230a989
> Tested-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com
> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

Thanks for the analysis and the patch! I agree this will fix the problem
for the particular syzbot reproducer but I think a proper solution needs a
bit more. I think we need udf_current_aext() and udf_next_aext() to
differentiate between error and "hit EOF" - I think they can take pointer
to etype to store the extent type and just return 0 on success, <0 on
error. Then inode_bmap() can do the same and udf_extend_file() can properly
detect errors and bail out without resorting to checking for particular
offsets and assuming internal behavior of these functions. Will you be
interested in looking into this?

								Honza


> ---
>  fs/udf/inode.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 4726a4d014b6..66f73f728dae 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -660,6 +660,16 @@ static int udf_extend_file(struct inode *inode, loff_t newsize)
>  	udf_discard_prealloc(inode);
>  
>  	etype = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset);
> +
> +	/*
> +	 * when ftruncate attempt to access beyond end of device, sb_read will
> +	 * fail with epos.bh be null and return etype be -1, just return EIO.
> +	 */
> +	if (etype == -1 && !epos.bh && epos.offset == sizeof(struct allocExtDesc)) {
> +		err = -EIO;
> +		goto out;
> +	}
> +
>  	within_last_ext = (etype != -1);
>  	/* We don't expect extents past EOF... */
>  	WARN_ON_ONCE(within_last_ext &&
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

