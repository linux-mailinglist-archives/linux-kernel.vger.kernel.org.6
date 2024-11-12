Return-Path: <linux-kernel+bounces-406081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851C49C5ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C76B1F2177B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18331FF7CB;
	Tue, 12 Nov 2024 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jrKkLAA9"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A6F1FF033
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422594; cv=none; b=iKWLT8bX6wdRtK30OgoDzQteFsp1yCSswwqUqco3nj7/iLROt7x14OxNabQSUr7D0CUw9BobxP+Q4nkxBG31YQ/J9EOQ/uIcdXVagHT81inn4BFJUu1hSsoAhdrbEwb/ZQWxxVw81l3aPbmccWgl1xJCuwlYNH4+9Lic4a3MtgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422594; c=relaxed/simple;
	bh=eQMu9wFlAw8wd7/LIFMKvdcxLfmUX9u3NdnK8f75AAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbKbJwAvBJvKnN14DAgB3ZFNkSFh73lvRGBHvb3GmKO4UtddkDr5CfJSFkl+jAoYcHk7Hm/EaFHyNyCMDW51o4sONTvFo9zY0thAJs9cV9i8ZSp4yy2zcajUW0QKG+r2L+bjdj/rgRs1TAtkCog0AgDKPET1G+9MSKevnlvX6sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jrKkLAA9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c87b0332cso162465ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 06:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731422592; x=1732027392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BvlFHYG+C9rXozK50CbQs/8rIIweIWmOrHb6WLV7ot0=;
        b=jrKkLAA9IMwjTqQEo6bpRsDOZdv0lBomyshE7bN4nv8rjdU1e4BPBj0bQZh3EDRnm/
         Dlele044oFtmnsYWpdleJtu2jyoxUcc7jpmZ8G/Mp7jxYrP6MguSvvsJRzl5tEu1TFQI
         xHq5mPE0XmCn0vEIbjusUc2q2nt+GeVBc6HJP46hLk3Tm5OvvEo+PYN6XCc7kTl/76vx
         Gd87qX+8e9ECfMLvrd8snu/5OTINuw6XtVKVIexRvDjRVsDEV4O+8LFoY0J0y7S0Ccgm
         UmMYp+QG9t7HOEGwg39n0uHli+Vg1k3nLGESY/lS/75h0vEwUK57so33eWvSheunSbff
         YmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731422592; x=1732027392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvlFHYG+C9rXozK50CbQs/8rIIweIWmOrHb6WLV7ot0=;
        b=di+g9hUKkYaJragip69wMyWo9PU2YlfcJU9qx/arSnXBffPRxSqmE4h4P7nM+nWrT2
         hRkEX2ziYXmX0DuhEcjneZtZ6/gjOuwmt+Lml3EQE0Rp3v+q0Ej/dvAB2F3co4frAO98
         9uPfhyQiPEqNxLzGZkmKNt1yqG8l5PhTpv3rKnf9rXoevT5aN7pTxsB82AelCrmoCkPw
         fFSSfo2oXagB+hNUMSmYlKSrirK/iLseggDB13MhNz2eMFKhi2pJqp452Wj/YH5eXcmA
         zHcg5R9+6g63V/7amY0wWToZKI+k2eLhxa2qrQj5tWp51Y65DuhGq0bSU9Glj6K+XXYJ
         vlBg==
X-Forwarded-Encrypted: i=1; AJvYcCVvadLQV/YdDUITiHenRtsu/QHNWLms2xgIpluEMqUsDxZ2c5o3UMlSpi8wjRimxMEGd9pwgld+EV6Hk5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Ec6ktLoXiirVCak0qPu9qUHNJgGEP1oCzF365ZQz+Ape10v4
	/X4l5MB+1vLpISuZFylEJwvSe8aW3ZDTdIr4CNit7sdyKqzg3OqSAXy9si9lyQ==
X-Gm-Gg: ASbGncsOt3eO0uvzlWbulGBOJp64By5PCGCHC97mxazQJRlom3R9tJnmV6/LPkgSGoR
	mZzAEjRlqAn1gObXUPPbvZUdSsOTdEQNUIROI43l//jK+++KVgASS3J2wQKcOR2CPodj58DUexh
	IgH/huLqfvXHa0mphFHE57etuYPgv1aL4S0n1eQxfYIXI7Tpc3Cxsw1ARLRZlNFyPghz5fZ98Px
	J01DNNgYygLldQ16lVlA+Yi9thJKoMKa7vEE41gRabYXX+s21BuUEFHs3u7Cn4t60ne6NtXGgE5
	NIPkE6dpofokm4w=
X-Google-Smtp-Source: AGHT+IFCg7GRSgvY2qozfGiLnaMMnIplCIx5398UVS4SRJoq56Tsa+2fDuT2mZ18c6V5Z4GiY8/h6A==
X-Received: by 2002:a17:903:24e:b0:20c:f3cf:50e9 with SMTP id d9443c01a7336-211ab6fd8e3mr2726715ad.4.1731422591901;
        Tue, 12 Nov 2024 06:43:11 -0800 (PST)
Received: from google.com (180.145.227.35.bc.googleusercontent.com. [35.227.145.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a4f566sm11262505b3a.171.2024.11.12.06.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 06:43:11 -0800 (PST)
Date: Tue, 12 Nov 2024 14:43:07 +0000
From: Carlos Llamas <cmllamas@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Barry Song <v-songbaohua@oppo.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH v3 2/8] binder: concurrent page installation
Message-ID: <ZzNpe34A7Q4pTrpj@google.com>
References: <20241108191057.3288442-1-cmllamas@google.com>
 <20241108191057.3288442-3-cmllamas@google.com>
 <b0949317-9be5-49e4-9390-2ff1ca1b1ed9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0949317-9be5-49e4-9390-2ff1ca1b1ed9@redhat.com>

On Tue, Nov 12, 2024 at 12:10:20PM +0100, David Hildenbrand wrote:
> On 08.11.24 20:10, Carlos Llamas wrote:
> > +	ret = vm_insert_page(vma, addr, page);
> > +	switch (ret) {
> > +	case -EBUSY:
> > +		/*
> > +		 * EBUSY is ok. Someone installed the pte first but the
> > +		 * lru_page->page_ptr has not been updated yet. Discard
> > +		 * our page and look up the one already installed.
> > +		 */
> > +		ret = 0;
> > +		__free_page(page);
> > +		npages = get_user_pages_remote(alloc->mm, addr, 1, 0, &page, NULL);
> 
> This will trigger a page fault if we don't find what we expect (are races
> with e.g., MADV_DONTNEED possible?), is that really desired or not a
> problem?

This is fine. As of now, binder blocks its page faults:

	static vm_fault_t binder_vm_fault(struct vm_fault *vmf)
	{
		return VM_FAULT_SIGBUS;
	}

If we race with something like MADV_DONTNEED then we would just
propagate the -EFAULT error. I could add FOLL_NOFAULT to the gup remote
call to make it evident we don't care though.

--
Carlos Llamas

