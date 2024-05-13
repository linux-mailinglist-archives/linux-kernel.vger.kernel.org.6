Return-Path: <linux-kernel+bounces-178056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EC38C4801
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52EBB1C2337F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA06C7E101;
	Mon, 13 May 2024 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VdDy2ga7"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F7B78C9B
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 20:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715630520; cv=none; b=JgGlCQUL1mudHjGbAyIuhKc4gW4sa7Dfzu2NzVWlR9DiTIKxmdSnyX3Gr9djlKMMFA12WHEQDSUIrrqL/45VkS2EQFZfsjkbmtS2Q/4wl3lXI06tWSSovXr5ZrQEgyzeXMBeAULtvKrWvIfTQ58dW4EOU1ilVTdzx/Cljk3drlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715630520; c=relaxed/simple;
	bh=kCWIDqHKRpNiHgsrElxdguFxbwEejP1b6azKvmK9WIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhlXRIhASIFpr2ZnMLijzMqASrLUIk1Bup/q3Rx4u1jjkcp8nQJO7OD8nIEyzeVlt9Lj2oGvVt4hQMVWZkZfN6kTktHw3OcmQ/SPCzdbTNeYvd2W/M3WRyzsjVd6c3fDBKnmKY5afOJxBkNO4DO/zVsbsBR8SVeqcGiFTrztTBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VdDy2ga7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f489e64eb3so3423081b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715630519; x=1716235319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tu1mAvTbWrCse2gBIT6/NEo/4PodqCxfY1bOl+5rrf4=;
        b=VdDy2ga7b+h/pui9GflgSIcbqQ5RW6b51uIcx8L9IPzr46vMc0ii2ybvWvDfnz5B7C
         ONysuFuS30pEUQUrugk/Bn1ekykTflFcKJSscb39vHJwPrhKmrKB4zM1LlGsUgQkrCbt
         5zExdCqHyOdHaJIs2BIa2GUxOwtDUwF+refAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715630519; x=1716235319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tu1mAvTbWrCse2gBIT6/NEo/4PodqCxfY1bOl+5rrf4=;
        b=rutNqYuVBlux1ESs0ghn3/9PfCeMp2dofSuQSdxNyY5Jj7JRBqL4Lt8BRztbMADwML
         /iJWiPeylh+NcuexOHlleKN14aKOFLhUDrDjL9bLY85fRoIeEKvtw1zemVh3rYpX17YO
         ObrcyNHRaNyFSJDG1LDBMg9S/nuDpEfLKzEMBIzWQZ3j4GBBQ68uVvyiIFqbIBTw5Rpl
         BgwtzkY7hC3c9wpB5YuoumEC62ilUDtDyt00OEgfK3VB7VlrtJXnaDxPxyGHN0F7pQ8l
         4igtF+6BNvy8MKFNwvnkiWawPJ1fmyHoz7XhSIQ6+UxsWsyv28VmygjQjMjnZsL9860L
         KDbw==
X-Forwarded-Encrypted: i=1; AJvYcCWm7rINXaJnSvlSqDjJZbZMn1uPlNQOC0jCXIRKsmExn2ydEFpAZiqYZNudxpwB9wnl+mdrLE02we8FnOAmx5pQYI5IyOAYeQwG176h
X-Gm-Message-State: AOJu0YzrmO8hkfS20toID35vZRy2ub+ZPzElEYPl70JppEhwU/EyrV+H
	Ew3o03Lt0AHPo5gXLqK5yB1GPraoV3ArthtMmrDsb1zb9qsySbBuXI0Ix9X0lQ==
X-Google-Smtp-Source: AGHT+IEubUxmwygy9FUfqvNCwWK2g46wEFi3tc6dILI4lRjEEhS0+DJBsnBKhNjGbs2KCpgHnr3Xvw==
X-Received: by 2002:a05:6a20:1056:b0:1af:8ca1:8fec with SMTP id adf61e73a8af0-1afde0d3af2mr9562597637.16.1715630518673;
        Mon, 13 May 2024 13:01:58 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340c4d4a1csm8266124a12.40.2024.05.13.13.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 13:01:58 -0700 (PDT)
Date: Mon, 13 May 2024 13:01:57 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] fs: fix unintentional arithmetic wraparound in offset
 calculation
Message-ID: <202405131251.6FD48B6A8@keescook>
References: <20240509-b4-sio-read_write-v2-1-018fc1e63392@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509-b4-sio-read_write-v2-1-018fc1e63392@google.com>

On Thu, May 09, 2024 at 11:42:07PM +0000, Justin Stitt wrote:
> When running syzkaller with the newly reintroduced signed integer
> overflow sanitizer we encounter this report:
> 
> [   67.995501] UBSAN: signed-integer-overflow in ../fs/read_write.c:91:10
> [   68.000067] 9223372036854775807 + 4096 cannot be represented in type 'loff_t' (aka 'long long')
> [   68.006266] CPU: 4 PID: 10851 Comm: syz-executor.5 Not tainted 6.8.0-rc2-00035-gb3ef86b5a957 #1
> [   68.012353] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   68.018983] Call Trace:
> [   68.020803]  <TASK>
> [   68.022540]  dump_stack_lvl+0x93/0xd0
> [   68.025222]  handle_overflow+0x171/0x1b0
> [   68.028053]  generic_file_llseek_size+0x35b/0x380
> 
> amongst others:
> UBSAN: signed-integer-overflow in ../fs/read_write.c:1657:12
> 142606336 - -9223372036854775807 cannot be represented in type 'loff_t' (aka 'long long')
> ...
> UBSAN: signed-integer-overflow in ../fs/read_write.c:1666:11
> 9223372036854775807 - -9223231299366420479 cannot be represented in type 'loff_t' (aka 'long long')
> 
> Historically, the signed integer overflow sanitizer did not work in the
> kernel due to its interaction with `-fwrapv` but this has since been
> changed [1] in the newest version of Clang. It was re-enabled in the
> kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
> sanitizer").
> 
> Fix the accidental overflow in these position and offset calculations
> by checking for negative position values, using check_add_overflow()
> helpers and clamping values to expected ranges.
> 
> Since @offset is later limited by @maxsize, we can proactively safeguard
> against exceeding that value (and by extension avoiding integer overflow):
> 	loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize)
> 	{
> 		if (offset < 0 && !unsigned_offsets(file))
> 			return -EINVAL;
> 		if (offset > maxsize)
> 			return -EINVAL;
> 		...
> 
> Link: https://github.com/llvm/llvm-project/pull/82432 [1]
> Closes: https://github.com/KSPP/linux/issues/358
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - fix some more cases syzkaller found in read_write.c
> - use min over min_t as the types are the same
> - Link to v1: https://lore.kernel.org/r/20240509-b4-sio-read_write-v1-1-06bec2022697@google.com
> ---
> Here's the syzkaller reproducer:
> | # {Threaded:false Repeat:false RepeatTimes:0 Procs:1 Slowdown:1 Sandbox:
> | # SandboxArg:0 Leak:false NetInjection:false NetDevices:false
> | # NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false KCSAN:false
> | # DevlinkPCI:false NicVF:false USB:false VhciInjection:false Wifi:false
> | # IEEE802154:false Sysctl:false Swap:false UseTmpDir:false
> | # HandleSegv:false Repro:false Trace:false LegacyOptions:{Collide:false
> | # Fault:false FaultCall:0 FaultNth:0}}
> | r0 = openat$sysfs(0xffffffffffffff9c, &(0x7f0000000000)='/sys/kernel/address_bits', 0x0, 0x98)
> | lseek(r0, 0x7fffffffffffffff, 0x2)
> 
> ... which was used against Kees' tree here (v6.8rc2):
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=wip/v6.9-rc2/unsigned-overflow-sanitizer
> 
> ... with this config:
> https://gist.github.com/JustinStitt/824976568b0f228ccbcbe49f3dee9bf4
> ---
>  fs/read_write.c  | 18 +++++++++++-------
>  fs/remap_range.c | 12 ++++++------
>  2 files changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index d4c036e82b6c..d116e6e3eb3d 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -88,7 +88,7 @@ generic_file_llseek_size(struct file *file, loff_t offset, int whence,
>  {
>  	switch (whence) {
>  	case SEEK_END:
> -		offset += eof;
> +		offset = min(offset, maxsize - eof) + eof;

This seems effectively unchanged compared to v1?

https://lore.kernel.org/all/CAFhGd8qbUYXmgiFuLGQ7dWXFUtZacvT82wD4jSS-xNTvtzXKGQ@mail.gmail.com/

>  		break;
>  	case SEEK_CUR:
>  		/*
> @@ -105,7 +105,8 @@ generic_file_llseek_size(struct file *file, loff_t offset, int whence,
>  		 * like SEEK_SET.
>  		 */
>  		spin_lock(&file->f_lock);
> -		offset = vfs_setpos(file, file->f_pos + offset, maxsize);
> +		offset = vfs_setpos(file, min(file->f_pos, maxsize - offset) +
> +					      offset, maxsize);
>  		spin_unlock(&file->f_lock);
>  		return offset;
>  	case SEEK_DATA:
> @@ -1416,7 +1417,7 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>  	struct inode *inode_in = file_inode(file_in);
>  	struct inode *inode_out = file_inode(file_out);
>  	uint64_t count = *req_count;
> -	loff_t size_in;
> +	loff_t size_in, in_sum, out_sum;
>  	int ret;
>  
>  	ret = generic_file_rw_checks(file_in, file_out);
> @@ -1450,8 +1451,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>  	if (IS_SWAPFILE(inode_in) || IS_SWAPFILE(inode_out))
>  		return -ETXTBSY;
>  
> -	/* Ensure offsets don't wrap. */
> -	if (pos_in + count < pos_in || pos_out + count < pos_out)
> +	if (check_add_overflow(pos_in, count, &in_sum) ||
> +	    check_add_overflow(pos_out, count, &out_sum))
>  		return -EOVERFLOW;

I like these changes -- they make this much more readable.

>  
>  	/* Shorten the copy to EOF */
> @@ -1467,8 +1468,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>  
>  	/* Don't allow overlapped copying within the same file. */
>  	if (inode_in == inode_out &&
> -	    pos_out + count > pos_in &&
> -	    pos_out < pos_in + count)
> +	    out_sum > pos_in &&
> +	    pos_out < in_sum)
>  		return -EINVAL;
>  
>  	*req_count = count;
> @@ -1649,6 +1650,9 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
>  	loff_t max_size = inode->i_sb->s_maxbytes;
>  	loff_t limit = rlimit(RLIMIT_FSIZE);
>  
> +	if (pos < 0)
> +		return -EINVAL;
> +
>  	if (limit != RLIM_INFINITY) {
>  		if (pos >= limit) {
>  			send_sig(SIGXFSZ, current, 0);
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index de07f978ce3e..4570be4ef463 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -36,7 +36,7 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
>  	struct inode *inode_out = file_out->f_mapping->host;
>  	uint64_t count = *req_count;
>  	uint64_t bcount;
> -	loff_t size_in, size_out;
> +	loff_t size_in, size_out, in_sum, out_sum;
>  	loff_t bs = inode_out->i_sb->s_blocksize;
>  	int ret;
>  
> @@ -44,17 +44,17 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
>  	if (!IS_ALIGNED(pos_in, bs) || !IS_ALIGNED(pos_out, bs))
>  		return -EINVAL;
>  
> -	/* Ensure offsets don't wrap. */
> -	if (pos_in + count < pos_in || pos_out + count < pos_out)
> -		return -EINVAL;
> +	if (check_add_overflow(pos_in, count, &in_sum) ||
> +	    check_add_overflow(pos_out, count, &out_sum))
> +		return -EOVERFLOW;

Yeah, this is a good error code change. This is ultimately exposed via
copy_file_range, where this error is documented as possible.

-Kees

-- 
Kees Cook

