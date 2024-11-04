Return-Path: <linux-kernel+bounces-395071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7889BB815
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49460B26A80
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D291B5EBC;
	Mon,  4 Nov 2024 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GzCLts7K"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826341AF0A0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730731177; cv=none; b=SBDmZa7eBGy6rW4gHdkNFzR2FvhX8zuhJ0TSHzG+w4m19+FKadr0j5StDBfcfm8l8nxwWy6ENeiRCACCZbBb8HD4kOUfk18C7NvErO524Nr9qsF0OpKV4DN7Cv1pR8be3EL7DDg2vIdeePqktJyW7KruGgOHPuD/Oa1mya0uOEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730731177; c=relaxed/simple;
	bh=SAysRBjeTpqOVyOR4xiUjLxFglwi2nkq1p1t1S6E6Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEGYyaQJNmsTrdCqp9XsMMVrg20OqZzgRTi3AIJvZInCvaCBieOYVFutsSZnehCuk0EPSwg7Z5OCZzZH/b9fvjmnh51+reoEh3JFR2pjMSaq5HdAduL4WjlV4Rav10FoQnQZT+16sERd2P1bhFyIw7e/ln9qSvxJm2YJOSF5CGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GzCLts7K; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b1418058bbso320640885a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 06:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730731174; x=1731335974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K7GgJa5RTgd5P+6kcbbcnFfaof+SAy4P+4oMeWT7+qM=;
        b=GzCLts7KOXeum8Gg9IiRedVhnDoI1Gk9TcwB1z810CEBH5XdyifCMqAuSVFIhtv6uM
         9h3rr0APjc/6aIRcWmShQ3YcuMSByG3YErnrXF29GSUlXYaANkuDTAtUo4Wdw6nyRDjW
         ahEJ8QTWVLfs7+zWFS/UOFu4n9yRAecHpfHmVoqfFXOyA0MVec5Fz0t27FNrKY7Q3hmY
         0P9uOH78ngSPY8PPu76hSf8lKRCGO9iKRPoGIBhycrJwmNSju4oSdfirzbzfJEcdZLMD
         XK5SAdaBj8w5HYl8lI8NyuWGq1LcyNzj29RORgImQ/UnKkBxfF3H+erjjGE1H3ZfOmzW
         kClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730731174; x=1731335974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7GgJa5RTgd5P+6kcbbcnFfaof+SAy4P+4oMeWT7+qM=;
        b=r/Dt9eCst4+CdHTyam9MdKwNc+jB2g2F1/MZBvWrVNOuuwZfgSeQqwPW/Z+4eY3ldP
         os4OWZBk5wbF+tQMpdrQa27dDXzeA+3EKODdJdH0pYyqGzjHA7x3wN+SvNLWuQHiMtrQ
         0AzaN20yJ1hhAEWBhrZwXKKe/Q5H2QbkO0klSHoG8RVewtSC6YctVvnPfD9qIpOaKpvt
         Kx6T4bRJ6wTOj5/WAkxQA0SU+6VpAxRGXgAueCiWrWGVzGnjN/Ruo3Lvyu8sQOYhj8Bm
         PBczVi9cFtQLFkpBP4Fbg6lrTRqUB6zd1V+YKNG/lt4Juyw5CfvL0P690wC/aP6iq+R2
         ARdA==
X-Forwarded-Encrypted: i=1; AJvYcCXQi2o/hBlFWUczOwjGhjZXTYoipkzgctpab+qLQsA4o14uPAcHIetpqkL4IIZBBlNv1731A8VXU72swz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZsxs8jqDwxs8BYB5+A4vkmzHprCrVTSGNN5oW6FNtVOr3fnx
	G9nfxskyBVYuBl2JYOam0jmV9HEAFlICj/61bJq406k99EtPy39dAKwoy7rAdPw=
X-Google-Smtp-Source: AGHT+IGOTVPjFK4ay1adw/ohph20XHb3ApDLm6/FQn4TOPLQnmIzBK+Ks9cys0qKzNBDHWXmnqhTFA==
X-Received: by 2002:a05:620a:1909:b0:7b1:4536:8dc1 with SMTP id af79cd13be357-7b2fb9dbc8dmr1477560885a.62.1730731174508;
        Mon, 04 Nov 2024 06:39:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39e99e4sm424279885a.24.2024.11.04.06.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 06:39:33 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t7yEv-00000000isT-1BDF;
	Mon, 04 Nov 2024 10:39:33 -0400
Date: Mon, 4 Nov 2024 10:39:33 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Durrant, Paul" <pdurrant@amazon.co.uk>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jack@suse.cz" <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 05/10] guestmemfs: add file mmap callback
Message-ID: <20241104143933.GF35848@ziepe.ca>
References: <20240805093245.889357-1-jgowans@amazon.com>
 <20240805093245.889357-6-jgowans@amazon.com>
 <20241029120232032-0700.eberman@hu-eberman-lv.qualcomm.com>
 <33a2fd519edc917d933517842cc077a19e865e3f.camel@amazon.com>
 <20241031160635.GA35848@ziepe.ca>
 <fe4dd4d2f5eb2209f0190d547fe29370554ceca8.camel@amazon.com>
 <20241101134202.GB35848@ziepe.ca>
 <9df04c57f9d5f351bb1b4eeef764bf9ccc6711b1.camel@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9df04c57f9d5f351bb1b4eeef764bf9ccc6711b1.camel@amazon.com>

On Sat, Nov 02, 2024 at 08:24:15AM +0000, Gowans, James wrote:

> KHO can persist any memory ranges which are not MOVABLE. Provided that
> guest_memfd does non-movable allocations then serialising and persisting
> should be possible.
> 
> There are other requirements here, specifically the ability to be
> *guaranteed* GiB-level allocations, have the guest memory out of the
> direct map for secret hiding, and remove the struct page overhead.
> Struct page overhead could be handled via HVO. 

IMHO this should all be handled as part of normal guestmemfd operation
because it has nothing to do with KHO. Many others have asked for the
same things in guest memfd already.

So I would start by assuming guest memfd will get those things
eventually and design around a 'freeze and record' model for KHO of a
guestmemfd, instead of yet another special memory allocator..

Jason

