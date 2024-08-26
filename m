Return-Path: <linux-kernel+bounces-301900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6BF95F716
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83673B20CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178AA197548;
	Mon, 26 Aug 2024 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dfYIma/G"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1892619752C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690916; cv=none; b=GIipdM0GWNsnGPyTBikt/qOzwc9nADh9T8io4t1ePFA6f9Z9/wAqR0yZp5ArDqgSMJHuQtEKMNxwvpFWEUuyK2rYb00WfJ6t5XDpxZWRcBjujxojW9DTPewXaHruVYbxRc1NgYjNl8VoKdfdyJMeL/O4dW4qZDRqSqAXch6yG68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690916; c=relaxed/simple;
	bh=PARDisZ2Koi33bFaMpmqQpE48LzRtUF2GFwOC6ibJQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHUuEFwEYiQoAC3cD/MLoHr+XJbYm0wC3SqTEHKrnxmXnZ22yOJZ1csnsiID67Y8rFSMxCD8gn+njWvPiE0eL1rvNETM1K8DbjzxKHFOtHM3KUtbUfUpAVxn6WwixMdUftkWG6TEp5asil+qkkugyYT8NyNeVmn5ywauBlMehGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dfYIma/G; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a86883231b4so584237366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724690911; x=1725295711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p2US3quHF4FGj36QLp9HjPVeknmBzXwXeyiUwSXj0dY=;
        b=dfYIma/GXDlVoz1XNhWVmSJmBl2sz4C2bhp203SeSJVyz/bAh5j8ziky/R6JsUC0/c
         nqKf+sZnTZLBxc6xhJm/J98IYVjHeO8YxCIRvTKE3jiyabnTSkRX587heqK+BVEY+ReP
         UsbQkO3YMHuR3eAz6QRRmr+NZc/wl2oo5Pqe9CQM6twWH+QMmb6DnfQrRVep7opVr89d
         HinC/s/Ah7IK5F/gCqruXVBWfbQ8+Wa8/4Ve2iQwjXzeWn2so1g6pA/eBsoEuyXRn3PH
         ohThMKJWR81b9/q6lySsEezTq9HZpEcqSRclEBLQu+WqZIDPA4T+M2015rsalqgTjjGR
         6m1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724690911; x=1725295711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2US3quHF4FGj36QLp9HjPVeknmBzXwXeyiUwSXj0dY=;
        b=WWpnN4sVtcv88JNrXzXyqtLuAPe757sKFmryVIc14acbx51VqgY6GJMhyezpsrxIMM
         7+5Wpxws6m1DHcIJmXZ/niZULNKQj0Re3sQYJhY0Gb26Nd7Z3D9SnXWd+AHzlUtC95vu
         Evb3R+1M7DCezQ9PWEbcC8CRI6jxByixFM/YiAd1UTdAutq8AJ8cRUpbVl8dQbWR80fk
         mO48x2DQq4yMDFwsWHbhffKLqNBCkNmyirelxEsIU/7nwx6h0jPskG9u5vmEY7uEPkWu
         sGJAO5J5dq0KTDGV4tChWYcCsB6ftxTrpjvJ0//skVAJVWIKCwYULqC9+w7qP6+3juZP
         Odpg==
X-Forwarded-Encrypted: i=1; AJvYcCX+ZODuTJNq9WQhu7AHPEbk6u8L2IvVxLzMlgeudLjLI5oWydSNBCBjzvu5k2vhuSt+SSIgH1Tc8mtpyuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Gjcy9gPgbQx1VNanSm5rrUNepHuOv3B52b+cESTjGv6fH0HX
	KJOcEz5D2m78TGAoHfV4Fub54nZNQWSJFsZW+QJSRll5g6eqUsrTRtqvXluIr1E=
X-Google-Smtp-Source: AGHT+IG4RhYrAmiaKC8by+8hzzm8ayqsOf70yu/Jj7guOgp1pyGhZgvl9T107oQfHo/SuMj/vaWTvA==
X-Received: by 2002:a17:907:9816:b0:a7a:9f0f:ab2c with SMTP id a640c23a62f3a-a86a52c71f9mr684278266b.29.1724690911285;
        Mon, 26 Aug 2024 09:48:31 -0700 (PDT)
Received: from localhost (109-81-92-122.rct.o2.cz. [109.81.92.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a869cdd4ef4sm567776066b.166.2024.08.26.09.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 09:48:31 -0700 (PDT)
Date: Mon, 26 Aug 2024 18:48:30 +0200
From: Michal Hocko <mhocko@suse.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, jack@suse.cz,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <Zsyx3m-J1U4XF5bX@tiehlicka>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-2-mhocko@kernel.org>
 <Zsx_C0QuecO1C0dB@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsx_C0QuecO1C0dB@casper.infradead.org>

On Mon 26-08-24 14:11:39, Matthew Wilcox wrote:
> On Mon, Aug 26, 2024 at 10:47:12AM +0200, Michal Hocko wrote:
> > @@ -258,12 +258,10 @@ static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c)
> >   */
> >  static struct bch_inode_info *bch2_new_inode(struct btree_trans *trans)
> >  {
> > -	struct bch_inode_info *inode =
> > -		memalloc_flags_do(PF_MEMALLOC_NORECLAIM|PF_MEMALLOC_NOWARN,
> > -				  __bch2_new_inode(trans->c));
> > +	struct bch_inode_info *inode = __bch2_new_inode(trans->c, GFP_NOWARN | GFP_NOWAIT);
> 
> GFP_NOWAIT include GFP_NOWARN these days (since 16f5dfbc851b)

Ohh, I was not aware of that. I will drop NOWARN then.

> > +++ b/fs/inode.c
> > @@ -153,7 +153,7 @@ static int no_open(struct inode *inode, struct file *file)
> >   * These are initializations that need to be done on every inode
> >   * allocation as the fields are not initialised by slab allocation.
> >   */
> > -int inode_init_always(struct super_block *sb, struct inode *inode)
> > +int inode_init_always(struct super_block *sb, struct inode *inode, gfp_t gfp)
> 
> Did you send the right version of this patch?  There should be a "_gfp"
> appended to this function name.

yes, screw up on my end.

> > +++ b/include/linux/fs.h
> > @@ -3027,7 +3027,12 @@ extern loff_t default_llseek(struct file *file, loff_t offset, int whence);
> >  
> >  extern loff_t vfs_llseek(struct file *file, loff_t offset, int whence);
> >  
> > -extern int inode_init_always(struct super_block *, struct inode *);
> > +extern int inode_init_always_gfp(struct super_block *, struct inode *, gfp_t);
> 
> You can drop the "extern" while you're changing this line.

OK, I can. I just kept the usual style in this file.

Thanks!
-- 
Michal Hocko
SUSE Labs

