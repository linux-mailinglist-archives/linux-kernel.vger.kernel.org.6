Return-Path: <linux-kernel+bounces-236998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD90E91E9A5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17E21C22048
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB3A171666;
	Mon,  1 Jul 2024 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="skuZDf80"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2EC16DEAD
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719866009; cv=none; b=DGLKclOZdOtyHEHz8l8tYOuUX2IQew5qkAPobEys/QcovObcZBghmOTRs2Z8GfPgNvurU/ypAKn9HBL5dMt1YidyFQtWfNjjWCAwMUkg7j9Xy9EJAFNyb5dhW9OpRmeND0VYNRWvSZphL3HfVX/ekb9Or2hPFEdHwmTaWfLqVAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719866009; c=relaxed/simple;
	bh=jEinBn73kAQeiKA6biJBVZ0znaclnyoeCW0MFqYT2GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPfimHPUvMKo8Ju2tDvAaa3gKgzRCzy52ldMGxNiI4C8MH+0tlTNZBfFQ8gm/xej8yQqPEg4NSXOeEmv+ylJCJCZJtcad1eKU0SBmlfDE42pMrUAdxfluLjKCwTdsdjDaLzvHte97GDUu71EpcKInskahngI9rGGRNclLtQLBxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=skuZDf80; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79c076c0d83so210588685a.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 13:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719866006; x=1720470806; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eJWQ2aw4J/WLIAVkZzcuHyyU5owW6RRYm2ZeVPaEzB8=;
        b=skuZDf80doiLymvCWsYlJ/cKG3vZ2Q9BukFjNM7u/x0SGqbYFJ011iPuV6oDCIO7a6
         HUAoBzRGXal73sktZYyKb0TwR2e7wEfj1mHmDsGvKSDRTZW3SPFWOegfKl/PvbPs3Y6c
         3wz454SIm87ualx41QjvPlxfSxP0yTzyv1CpudOk89UYSjfogovtFCroTYXD6qU7M01s
         qhj3XU41S0ZDH2vWvyMoL9402IdEpdLodXOybK49lcjzyHN5w3aIQNh/uw0nIbNf5CoA
         Lqz9fLshNXhhPAoOMmyrJJXb3fvP2HZOXILUWXKssSlHSvI9qXlkJvGxwrYSr9Rar0iS
         GROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719866006; x=1720470806;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJWQ2aw4J/WLIAVkZzcuHyyU5owW6RRYm2ZeVPaEzB8=;
        b=wLKky1zIur5EnWrnHLAfyXMrVnHAg9sW5y3TbTENV4DITHTA7xrB1Z1rVAQIXkqsZz
         VXiTTf2PFoADbTgrj5PUV9qLVMSS+umyEWvsD655164mjgQopzsKKvKL1yWIxMyLUgIg
         u9sNS8BxFVrNfIeDdnHdGGqnYkmS5/d2rCWmGrIIJ0Z9nM+XBtRUyamhv6LhVtejfwdS
         gl1vPTPUKXxhJzumncD49+JKd6pdXepNcGwQ1ZXLfFc6N5wXd8uH8FWu5D4NpueNnfm3
         /NlQM1SDqqR17fVtiBgGeC8LRhOE5cYe34tDLuvwGvA8r6WSs5BQ8zsKhqUIr8HdmBNM
         bwAg==
X-Forwarded-Encrypted: i=1; AJvYcCV4ewHCMnP5KJXaHJZ338XtvlAFhEI2VQ2/2i6qspAj4pbJTRZdLkkKApH+y/vV+/8IEAfcSMY4YNYHqUhQ3HihJJIBWqmVq8RfFwe8
X-Gm-Message-State: AOJu0YypQTkukLEmc3ab/1uKGxoo0GTb0s0iGjBCzG+2pQ/rwWJqRJvx
	IHwI2e+yy6tkzshT/BTK7+tLbsuwZI0d6W9CP4+V2bk/utuVm/UeNwzyro+MVho=
X-Google-Smtp-Source: AGHT+IHquiezZuh7KYAcKV1s9Va0xkaeqQinyvX7/0dTMvr1KCMbQie9WJzy87YdgytxI01W/IdsjQ==
X-Received: by 2002:a05:620a:2683:b0:79c:f0e:f793 with SMTP id af79cd13be357-79d7b99e142mr1064186885a.14.1719866006069;
        Mon, 01 Jul 2024 13:33:26 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d692600b6sm384373985a.20.2024.07.01.13.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:33:25 -0700 (PDT)
Date: Mon, 1 Jul 2024 16:33:24 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andi Kleen <ak@linux.intel.com>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 09/11] btrfs: convert to multigrain timestamps
Message-ID: <20240701203324.GA510298@perftesting>
References: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
 <20240701-mgtime-v2-9-19d412a940d9@kernel.org>
 <20240701134936.GB504479@perftesting>
 <ec952d79bbe19d80a7aff495e9784c60a1a1e668.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec952d79bbe19d80a7aff495e9784c60a1a1e668.camel@kernel.org>

On Mon, Jul 01, 2024 at 09:57:43AM -0400, Jeff Layton wrote:
> On Mon, 2024-07-01 at 09:49 -0400, Josef Bacik wrote:
> > On Mon, Jul 01, 2024 at 06:26:45AM -0400, Jeff Layton wrote:
> > > Enable multigrain timestamps, which should ensure that there is an
> > > apparent change to the timestamp whenever it has been written after
> > > being actively observed via getattr.
> > > 
> > > Beyond enabling the FS_MGTIME flag, this patch eliminates
> > > update_time_for_write, which goes to great pains to avoid in-memory
> > > stores. Just have it overwrite the timestamps unconditionally.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > �fs/btrfs/file.c� | 25 ++++---------------------
> > > �fs/btrfs/super.c |� 3 ++-
> > > �2 files changed, 6 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > > index d90138683a0a..409628c0c3cc 100644
> > > --- a/fs/btrfs/file.c
> > > +++ b/fs/btrfs/file.c
> > > @@ -1120,26 +1120,6 @@ void btrfs_check_nocow_unlock(struct
> > > btrfs_inode *inode)
> > > �	btrfs_drew_write_unlock(&inode->root->snapshot_lock);
> > > �}
> > > �
> > > -static void update_time_for_write(struct inode *inode)
> > > -{
> > > -	struct timespec64 now, ts;
> > > -
> > > -	if (IS_NOCMTIME(inode))
> > > -		return;
> > > -
> > > -	now = current_time(inode);
> > > -	ts = inode_get_mtime(inode);
> > > -	if (!timespec64_equal(&ts, &now))
> > > -		inode_set_mtime_to_ts(inode, now);
> > > -
> > > -	ts = inode_get_ctime(inode);
> > > -	if (!timespec64_equal(&ts, &now))
> > > -		inode_set_ctime_to_ts(inode, now);
> > > -
> > > -	if (IS_I_VERSION(inode))
> > > -		inode_inc_iversion(inode);
> > > -}
> > > -
> > > �static int btrfs_write_check(struct kiocb *iocb, struct iov_iter
> > > *from,
> > > �			���� size_t count)
> > > �{
> > > @@ -1171,7 +1151,10 @@ static int btrfs_write_check(struct kiocb
> > > *iocb, struct iov_iter *from,
> > > �	 * need to start yet another transaction to update the
> > > inode as we will
> > > �	 * update the inode when we finish writing whatever data
> > > we write.
> > > �	 */
> > > -	update_time_for_write(inode);
> > > +	if (!IS_NOCMTIME(inode)) {
> > > +		inode_set_mtime_to_ts(inode,
> > > inode_set_ctime_current(inode));
> > > +		inode_inc_iversion(inode);
> > 
> > You've dropped the
> > 
> > if (IS_I_VERSION(inode))
> > 
> > check here, and it doesn't appear to be in inode_inc_iversion.� Is
> > there a
> > reason for this?� Thanks,
> > 
> 
> AFAICT, btrfs always sets SB_I_VERSION. Are there any cases where it
> isn't? If so, then I can put this check back. I'll make a note about it
> in the changelog if not.

Ah ok I'm dumb, ignore me, thanks,

Josef

