Return-Path: <linux-kernel+bounces-331402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F27397AC6A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A0F28C274
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDB814C5AE;
	Tue, 17 Sep 2024 07:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZqzP+xTS"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED54137745
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726559471; cv=none; b=Xvh68rkUPVW1na3jPFhp6PqtYiJr036KcwU4o/sal6RFwpbnezJN//QiYV3ch++2tCw14e2nT60TYtiRNTnN0PISPjYmwtssSg1g1fPGC9rmKB8V0jkvgDY2QLqAibfrE8dWFjC7XA0c2/vSvUJsisKEwLkDM+gJkt62in7yXgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726559471; c=relaxed/simple;
	bh=Fb/PRE95IrWc4GVMYKNPXZjzYswrFaLIb3MD8w25iCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ipd2N2XrU80mlDI8CU6CSfRG3SJwNRW6uKvrQm2Dx6wv4Rhz5apZKC2HPFSJo7rYTUqhLcoekB6efjXwyRquqKTXfoNcnDNBVoibI7CB7GRiZpiKFAdQuuuQYGX7mzceohFoCubmU5aUrT2s2WXlRERGj5wJ+JhYoyMkSHLjbI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZqzP+xTS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cae102702so33663845e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 00:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726559467; x=1727164267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vKbget9kHS3cKjGipzdpUeRREgJys2Zr0EUkoUcP4ps=;
        b=ZqzP+xTS9Vb0kXE5GLAwjChSjLfb3JeKt4qEfSqIORiNgnOuN7udt+aO82yBRiw1FJ
         dFrSo2h99LzXCFD0IF4DYZ6JocVQP6W0/2IOTTz4fs+jqExuVF2A3nDCaYPY4XJwIGOE
         X2fT15KnFTgtP6OTqrAisLhhavT5nhASyQbZ5dAv1tziCzHs17MzXoBtzWAxyztBN70p
         1W7Hv3+NrQetuIAR0rQPqq1u0zZn4/fHD/ttUoKDl9G/Ad9arL7vWGj0y7vScnlCqDKW
         FQbAS9q1N9/QM7iHRBAPasCLzaUS3yeFHHA+JzV3amUlw52un4jGbhQK81ppxDpcT/Xe
         YZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726559467; x=1727164267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKbget9kHS3cKjGipzdpUeRREgJys2Zr0EUkoUcP4ps=;
        b=XY4CogquAc/at2z/LpatlXSV6ImFcOyVcBXOMthY8jxb45PoSRAKEEutuZEH4JqqbN
         pKJmwm8WQIA2PgyZRP5rmoymQXs+Bc/unYB/fOHex9Yu8UMAMimRdyhAg016HDxCCzJ/
         +x8q5RrPsfAYW3DBzGuO1qUjH8BtKzdcpE079w//VaM2oLgfuusaUazz9N8ksZ9Bttto
         phr5jJ07y9HbIRHL9rH6IYY0QQY6i2CUjGUfrNj1zhUGxSVMioICijaDVZBHP6D+r8+J
         +Z8LzCj3VbvS7nxSJ9eCa0yRex9CDjXPMSdmwkrxSaLidADPQruCEt3kxEIicAEU3JGZ
         ikhA==
X-Forwarded-Encrypted: i=1; AJvYcCXQNwOTkql5x1HuPGDKhUdw6EvUljJt6iW3wnkxEPpFq071kT1bW7ZbAwsgbjzEsNbFixH5mhsJ+EpbzeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8/rHMZguQn3XPtlq2O9tXAWvO+fTB8Zmv7ls/reprbPWM3cp1
	FQZNZMSRxY920AFFz2AzBtz+mW6vPEIhdT3eydJDkTWl82uDTNdF4VAcioojKjk=
X-Google-Smtp-Source: AGHT+IE0rMtK6o/bazTbZ5qxAOmHueW9ni4vtvrgTICtT7NsNghRhqyfXop3QknDWPgmyETSFhjNiw==
X-Received: by 2002:a05:600c:3b07:b0:426:6876:83bb with SMTP id 5b1f17b1804b1-42d9082b91bmr99955905e9.17.1726559466759;
        Tue, 17 Sep 2024 00:51:06 -0700 (PDT)
Received: from localhost (109-81-84-13.rct.o2.cz. [109.81.84.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b15c2f4sm129769635e9.24.2024.09.17.00.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 00:51:06 -0700 (PDT)
Date: Tue, 17 Sep 2024 09:51:05 +0200
From: Michal Hocko <mhocko@suse.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the security tree with the mm tree
Message-ID: <Zuk06cfmaOT5fltF@tiehlicka>
References: <20240911142822.7c65e02e@canb.auug.org.au>
 <20240917093048.71949a8f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917093048.71949a8f@canb.auug.org.au>

On Tue 17-09-24 09:30:48, Stephen Rothwell wrote:
> Hi all,
> 
> On Wed, 11 Sep 2024 14:28:22 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the security tree got conflicts in:
> > 
> >   include/linux/lsm_hooks.h
> >   security/security.c
> > 
> > between commit:
> > 
> >   3346ada04cf5 ("bcachefs: do not use PF_MEMALLOC_NORECLAIM")
> > 
> > from the mm-unstable branch of the mm tree and commit:
> > 
> >   711f5c5ce6c2 ("lsm: cleanup lsm_hooks.h")
> > 
> > from the security tree.
> > 
> > I fixed it up (I used the latter version ofinclude/linux/lsm_hooks.h
> > and see below) and can carry the fix as necessary. This is now fixed as
> > far as linux-next is concerned, but any non trivial conflicts should be
> > mentioned to your upstream maintainer when your tree is submitted for
> > merging.  You may also want to consider cooperating with the maintainer
> > of the conflicting tree to minimise any particularly complex conflicts.
> > 
> > -- 
> > Cheers,
> > Stephen Rothwell
> > 
> > diff --cc security/security.c
> > index 3581262da5ee,4564a0a1e4ef..000000000000
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@@ -660,7 -745,7 +745,7 @@@ static int lsm_file_alloc(struct file *
> >    *
> >    * Returns 0, or -ENOMEM if memory can't be allocated.
> >    */
> > - int lsm_inode_alloc(struct inode *inode, gfp_t gfp)
> >  -static int lsm_inode_alloc(struct inode *inode)
> > ++static int lsm_inode_alloc(struct inode *inode, gfp_t gfp)
> >   {
> >   	if (!lsm_inode_cache) {
> >   		inode->i_security = NULL;
> 
> This is now a conflict between the mm tree and Linus' tree.

Andrew said he would drop the mm patches and I will resubmit when merge
window closes.


-- 
Michal Hocko
SUSE Labs

